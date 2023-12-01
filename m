Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E72800393
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377605AbjLAGL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377596AbjLAGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:11:26 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A691703;
        Thu, 30 Nov 2023 22:11:31 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B16BDfs038786;
        Fri, 1 Dec 2023 00:11:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701411073;
        bh=epgSri49vYEanu4EViex8BzQiAMqKTxnJBmbQuxifM0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=t6PJjZxaE/YtFzz/B70/3TNeztm9LWWkw4Mfud1GkBiyFotsioiKmtNipJ2Ot7c0E
         uix24CTz1p4MZTgBCORTXNCg7kJpaoYYyKxR6yq0V7880YozN2BGPYFiKVL4IWu2E1
         cD/WcgQl1E+nfecTyEi17z6l25t5vSxKzxq/fSdQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B16BCN2059564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 00:11:12 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 00:11:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 00:11:12 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B16BCeA082440;
        Fri, 1 Dec 2023 00:11:12 -0600
Date:   Fri, 1 Dec 2023 00:11:12 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] media: chips-media: VIDEO_WAVE_VPU should depend
 on ARCH_K3
Message-ID: <20231201061112.jvera4kirvoqseqz@reseal>
References: <eb27184d182811520de31e59f449ea49e7cc6963.1701195705.git.geert+renesas@glider.be>
 <20231130100647.pbgk7oqgynx3pzrw@basti-XPS-13-9310>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231130100647.pbgk7oqgynx3pzrw@basti-XPS-13-9310>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:07-20231130, Sebastian Fricke wrote:
> Hey Geert,
> 
> Thanks for the patch!
> 
> Could you please adjust the subject line to:
> media: chips-media: wave5: VIDEO_WAVE_VPU should depend on ARCH_K3
>                     ^^^^^^
> 
> On 28.11.2023 19:26, Geert Uytterhoeven wrote:
> > The Chips&Media Wave 5 Series multi-standard codec IP is currently only
> > supported on Texas Instruments K3 J721S2 SoC.  Hence add a dependency on
> 
> While it is true that is currently only tested on the K3 architecture ,
> it is not only supported by that exact SoC, as you can see here:
> https://lore.kernel.org/all/20231127223718.2651185-4-b-brnich@ti.com/T/
> 
> So, maybe this commit is worded better with:
> 
> is currently only supported on the Texas Instruments K3 architecture.
> 
> The change however is obviously correct.
> 
> Greetings,
> Sebastian
> 
> > ARCH_K3, to prevent asking the user about this driver when configuring a
> > kernel without Texas Instruments K3 Multicore SoC support.
> > 
> > Fixes: 9707a6254a8a6b97 ("media: chips-media: wave5: Add the v4l2 layer")

Thank you Sebastian, in addition, a nitpick: checkpatch.pl complains:
Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")'
https://docs.kernel.org/process/submitting-patches.html
Quote:

If your patch fixes a bug in a specific commit, e.g. you found an
issue using git bisect, please use the 'Fixes:' tag with the first 12
characters of the SHA-1 ID, and the one line summary. Do not split
the tag across multiple lines, tags are exempt from the "wrap at 75
columns" rule in order to simplify parsing scripts


with the above fixed, please feel free to add:
Reviewed-by: Nishanth Menon <nm@ti.com>

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > drivers/media/platform/chips-media/wave5/Kconfig | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/media/platform/chips-media/wave5/Kconfig b/drivers/media/platform/chips-media/wave5/Kconfig
> > index 77e7ae5c8f35f454..9ccc1f7e32f3874f 100644
> > --- a/drivers/media/platform/chips-media/wave5/Kconfig
> > +++ b/drivers/media/platform/chips-media/wave5/Kconfig
> > @@ -3,6 +3,7 @@ config VIDEO_WAVE_VPU
> > 	tristate "Chips&Media Wave Codec Driver"
> > 	depends on V4L_MEM2MEM_DRIVERS
> > 	depends on VIDEO_DEV && OF
> > +	depends on ARCH_K3 || COMPILE_TEST
> > 	select VIDEOBUF2_DMA_CONTIG
> > 	select VIDEOBUF2_VMALLOC
> > 	select V4L2_MEM2MEM_DEV

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
