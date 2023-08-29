Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3830278C7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjH2OlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjH2Okt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:40:49 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAEE1;
        Tue, 29 Aug 2023 07:40:46 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TC53c6016602;
        Tue, 29 Aug 2023 16:40:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=4PWDKgxwZIJSbPew0UgQ/
        oUfBjtE2Peg1n6O5qbRfq0=; b=GgjnIXWv35TCEJisI4F8dP6T6vuX7KBFdVEor
        WPomEcwrYe2CgXvcI34+RIV6pJkQPLyNVDtrDpbRXXHkHz8ClaFbxeHusXOA+syH
        /kp5xvKeaMPjtTa+U3AEg9fTgg+PmJyjck3o6JBA9uAmPqfY1fsG2J6QDjaWcSEi
        HSiwC2il/CI0hhH+Shx0/y+W0f0HUYmS4X4xRBFoKVs1J6oDCIvCA7N0xx8QzJy9
        KAFT6pWUxZQnquYBrRV1s6a6KTeUisJ/GHGAVRj5IuUi7PyPFV2U9sPwjcqRRcN/
        BEptez/2Hi72GtWLIYU8MqxnUPMyMDwA3izak2rVeHu479U3w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqtxyt6js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 16:40:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C3301100057;
        Tue, 29 Aug 2023 16:40:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9C62F2309CC;
        Tue, 29 Aug 2023 16:40:30 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 16:40:30 +0200
Date:   Tue, 29 Aug 2023 16:40:29 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, <icenowy@aosc.xyz>,
        <martijn@brixit.nl>, <megous@megous.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <megi@xff.cz>
Subject: Re: gc2145 camera driver (front camera on PinePhone)
Message-ID: <20230829144029.GB193536@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, icenowy@aosc.xyz, martijn@brixit.nl,
        megous@megous.com, kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, megi@xff.cz
References: <Y6tGfxrq/Mh1JoA9@duo.ucw.cz>
 <ZOJPpBoiC92VsOV+@skv.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZOJPpBoiC92VsOV+@skv.local>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_12,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

sorry for the delay and huge thanks for the effort of adding parallel
support into the driver.

Yeah pushing this driver is still in my todo and your effort for the
parallel part helps me a lot.

Since you already have a commit which adds the parallel support, what
about I prepare the driver with only CSI support for the time being
(after cleanup as you also suggested) and then you can push additionnal
patches on top of it to add parallel support ?

Regards,
Alain

On Sun, Aug 20, 2023 at 08:38:44PM +0300, Andrey Skvortsov wrote:
> Hi Alain,
> 
> > we are also using the GC2145 sensor but in a CSI based environment.
> > 
> > We are in contact with GalaxyCore and following discussions we had with them
> > and data they provided us with, we've made a driver for that, supporting for
> > the time being 3 different resolutions via the CSI interface.
> > 
> > The driver is available on the STMicroelectronics STM32 github [1].
> > 
> > If you are ok with that, we could go further upstreaming it while testing/adding
> > features necessary for the PinePhone.
> > 
> > [1] https://github.com/STMicroelectronics/linux/blob/v5.15-stm32mp/drivers/media/i2c/gc2145.c
> 
> I've implemented basic parallel bus support to check your driver [1] on
> the PinePhone. My changes are here [2].
> With your driver results are much better in compare to Megi's
> driver (I'm still glad, that Megi has written one). See pictures for
> comparison here [3]. Access to vendor support and (probably)
> documentation gives great results.
> 
> I'd recommend to replace more of hard-coded parts of initialization
> sequences with functions like in proposed Megi's driver. So this will
> be clearer what different register values mean. Since you have access
> to support channel/documentation it'd be easier for you to do.
> 
> It'd be nice to have at least some gc2145 driver in mainline. Do you
> still have plans/time to mainline driver?
> 
> P.S.
> Alain, I don't see your address in the list of recipients of last Pavel's
> response. In case you have not received it, it's here [4].
> 
> 1. https://github.com/STMicroelectronics/linux/blob/v6.1-stm32mp/drivers/media/i2c/gc2145.c
> 2. https://github.com/AndreySV/linux/commit/f06ff60eb7a664dcafa8d40901a1ab0f59071529
> 3. https://github.com/AndreySV/linux/issues/1
> 4. https://lwn.net/ml/linux-kernel/Y6tGfxrq/Mh1JoA9@duo.ucw.cz
> -- 
> Best regards,
> Andrey Skvortsov
