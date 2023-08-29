Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14978C358
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjH2LeX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjH2LeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:34:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101A109;
        Tue, 29 Aug 2023 04:34:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZlZj4jhTz6J7Df;
        Tue, 29 Aug 2023 19:29:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 12:34:07 +0100
Date:   Tue, 29 Aug 2023 12:34:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <Marius.Cristea@microchip.com>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: adc: adding support for MCP3564 ADC
Message-ID: <20230829123406.0000403f@Huawei.com>
In-Reply-To: <ae3562ee30e6d8aecae2a447cffc4ad6e8e44578.camel@microchip.com>
References: <20230818165750.55406-1-marius.cristea@microchip.com>
        <20230818165750.55406-3-marius.cristea@microchip.com>
        <20230828151631.6a60282b@jic23-huawei>
        <ae3562ee30e6d8aecae2a447cffc4ad6e8e44578.camel@microchip.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 07:29:57 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Jonathan,
> 
>    Thank you for the review.
> 
> 
> > 
> >   
> > > +
> > > +/*
> > > + * Current Source/Sink Selection Bits for Sensor Bias (source on
> > > VIN+/sink on VIN-)
> > > + */
> > > +static const int mcp3564_burnout_avail[][2] = {
> > > +     [MCP3564_CONFIG0_CS_SEL_0_0_uA] = {0, 0},
> > > +     [MCP3564_CONFIG0_CS_SEL_0_9_uA] = {0, 900},
> > > +     [MCP3564_CONFIG0_CS_SEL_3_7_uA] = {0, 3700},
> > > +     [MCP3564_CONFIG0_CS_SEL_15_uA] = {0, 15000}
	[MCP3564_CONFIG0_CS_SEL_15_uA] = { 0, 15000 }

etc

> > > +};  
> > 
> > Trivial, but I'd like brackets after the { and before the } as makes
> > things a tiny bit
> > more readable to my eye.
> > 
> >   
> 
> I'm not sure that I understood what/how to change here. Can you,
> please, give me an example?
> 
> 
> 
> Thanks,
> Marius

