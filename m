Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE7813040
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573068AbjLNMgM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 07:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573052AbjLNMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:36:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEABA3;
        Thu, 14 Dec 2023 04:36:17 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrWym6SLmz6JB0r;
        Thu, 14 Dec 2023 20:35:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 4C4AD1400DD;
        Thu, 14 Dec 2023 20:36:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 12:36:14 +0000
Date:   Thu, 14 Dec 2023 12:36:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Lechner <dlechner@baylibre.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
Message-ID: <20231214123613.00002b69@Huawei.com>
In-Reply-To: <CAMknhBF9GtbOP_M2q8DrrMOePFOaQzGxqcS2P8OHjtGN-Z27Vg@mail.gmail.com>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
        <20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com>
        <20231214101415.0000060c@Huawei.com>
        <CAMknhBF9GtbOP_M2q8DrrMOePFOaQzGxqcS2P8OHjtGN-Z27Vg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 11:33:51 +0100
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, Dec 14, 2023 at 11:14 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 13 Dec 2023 05:21:20 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >  
> > > This adds a new driver for the AD7380 family ADCs.
> > >
> > > The driver currently implements basic support for the AD7380, AD7381,
> > > AD7383, and AD7384 2-channel differential ADCs. Support for additional
> > > single-ended and 4-channel chips that use the same register map as well
> > > as additional features of the chip will be added in future patches.
> > >
> > > Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> >
> > Just one additional comment.  I 'might' sort both this an Nuno's comment
> > if Mark is fine with the SPI and no on else has review comments.
> > Feel free to send a v3 though if you like ;)
> >
> >  
> > > +/* fully differential */
> > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
> > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
> > > +/* pseudo differential */
> > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
> > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
> > > +
> > > +/* Since this is simultaneous sampling, we don't allow individual channels. */
> > > +static const unsigned long ad7380_2_channel_scan_masks[] = {
> > > +     GENMASK(2, 0), /* both ADC channels and soft timestamp */
> > > +     GENMASK(1, 0), /* both ADC channels, no timestamp */  
> >
> > https://elixir.bootlin.com/linux/v6.7-rc5/source/include/linux/iio/iio.h#L567
> > See the comment (added recently!)  
> 
> I did see this comment but this is already sorted in order of
> preference, so I'm not sure why you are calling it out. Just FYI, I
> guess?

No. Order of preference would be turn on the minimal if that is enough.
First item is the highest preference (if the requested channels are a subset of
that we don't look any further).  Here that means we always stop on the first
entry and never look at the second.

> 
> >
> > Also, if I remember how this works correctly there is no need to include
> > the timestamp in the mask.  We do special handling for it to avoid having to double
> > the number of provided masks.  The details being that it uses
> > iio_scan_el_ts_store rather than iio_scan_el_Store.  
> 
> Indeed. I've been working ahead on adding more features and noticed
> this. So we will need to find a way to say that we the timestamp
> should not be allowed under certain conditions. But that will be a
> discussion for a later series.

Interesting - you have cases where it's not valid at all?
It sometimes becomes inaccurate because we are interpolating across
data from a fifo, but I've not seen a case where we can't provide anything
useful.  Ah well - as you say I'll wait for that later series!

Jonathan

> 
> >
> > So as you have it I think you'll always end up with the first entry
> > and that will include a bonus bit that isn't a problem as it will match
> > anyway.
> >
> > So just have the second entry and 0.
> >
> > Jonathan
> >  
> > > +     0
> > > +};  

