Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20017F8C02
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKYPUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:20:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31884101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:20:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A854C433C8;
        Sat, 25 Nov 2023 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700925607;
        bh=1pvnCX5R8u7RfMiNPMMmS+WyuEpdLzjE3FRiy8NZtag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HEDX8mPbSBds2f9EPZIoR4PeAeVug9LqWOLy4sEKt1ZLgpSQ81ClVczXPJH7ok8/n
         xlur70r2f2X8KOkin4mEpIGOWbCVYwxPglQUXK0793tK0lQNkt/TWAR643uOgymRDX
         JMnau9dxkkRPbnvWXrwGoQY7I/743LfrKMY1TJgFd0vMNHrU3rD1PbPi8/+EbL10WE
         s6P2+EOTMsuInMFG26T/EUwZtaEHItecdAjYRs9rGA1Wr4tLSAhndiPXYTo+g+Jp7q
         3eDaoTl7tce+RxUhSK1CgLxBWFl9QQ4nnFqOtgKR/QHoBGlS7+sn8rIccdMAnxdp/R
         YBM8wLekOBbwg==
Date:   Sat, 25 Nov 2023 15:19:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Kim Seer Paller <kimseer.paller@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: frequency: admfm2000: New driver
Message-ID: <20231125151959.00261229@jic23-huawei>
In-Reply-To: <CAKv63uvod-zdYSy93sJPBefBrqUUGhKDRLrC3vxvdeTZ4eM-nA@mail.gmail.com>
References: <20231123094357.222371-1-kimseer.paller@analog.com>
        <20231123094357.222371-2-kimseer.paller@analog.com>
        <CAKv63uvod-zdYSy93sJPBefBrqUUGhKDRLrC3vxvdeTZ4eM-nA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 11:19:51 +0100
Crt Mori <cmo@melexis.com> wrote:

> Hi,
> Just minor remark inline.
> 
> Best regards,
> Crt

Hi Crt,

Please crop replies / reviews to only relevant context. If there are lots of
comments it maybe fine to leave whole driver but that's not the case ehre.

Should only see something like...

Thanks,

Jonathan

> 
> On Thu, 23 Nov 2023 at 10:44, Kim Seer Paller <kimseer.paller@analog.com> wrote:
> >
> > Dual microwave down converter module with input RF and LO frequency
> > ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> > 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> > for each down conversion path.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
...


> > +static int admfm2000_setup(struct admfm2000_state *st,
> > +                          struct iio_dev *indio_dev)
> > +{

...

> > +       if (st->dsa_gpios[1]->ndescs != ADMF20000_DSA_GPIOS) {
> > +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> > +                             ADMF20000_DSA_GPIOS);  
> 
> no return -ENODEV here?
> 
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int admfm2000_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct iio_dev *indio_dev;
> > +       struct admfm2000_state *st;
> > +       int ret;  
> 
> Order these in reverse christmass tree like you did above.
> 
> 
> > +
> > +       indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       st = iio_priv(indio_dev);
> > +
> > +       indio_dev->name = "admfm2000";
> > +       indio_dev->num_channels = ARRAY_SIZE(admfm2000_channels);
> > +       indio_dev->channels = admfm2000_channels;
> > +       indio_dev->info = &admfm2000_info;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +       st->gain[0] = ADMF20000_DEFAULT_GAIN;
> > +       st->gain[1] = ADMF20000_DEFAULT_GAIN;
> > +
> > +       mutex_init(&st->lock);
> > +
> > +       ret = admfm2000_setup(st, indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = admfm2000_channel_config(st, indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}

Thanks,

Jonathan
