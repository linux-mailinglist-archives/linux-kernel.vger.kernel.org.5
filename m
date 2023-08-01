Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50276BE51
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjHAUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:13:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7639E71
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:12:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 371KCTNo103615;
        Tue, 1 Aug 2023 15:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690920749;
        bh=92E0FyIOdvL/ASqKMYUYhlN3Vb+r/XnDzr2cJExGv3c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yzGHZTY0d+g62JArpdrYa35dp0weGCoxzVkmpcX75QH26POeOWz8PpPCBSxxN0xFG
         f5w51Jz2IMBJKtxgEVKBOBseawBREsE0px/sFmlrejFeChFtelI2ObzYJJoJQAr660
         4gx0OOOQPVdEFUC3HcSm32175laWTSl1GxAs55Xc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 371KCSI0003548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 15:12:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 15:12:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 15:12:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 371KCSk3103636;
        Tue, 1 Aug 2023 15:12:28 -0500
Date:   Tue, 1 Aug 2023 15:12:28 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Bajjuri, Praneeth" <praneeth@ti.com>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: defconfig: enable TI K3 thermal driver
Message-ID: <20230801201228.rb2lxawcsgjkan2m@twistable>
References: <20230728113029.403862-1-francesco@dolcini.it>
 <4a295f06-c6f7-e023-61f0-01fdd07deab1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a295f06-c6f7-e023-61f0-01fdd07deab1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:31-20230801, Bajjuri, Praneeth wrote:
> 
> 
> On 7/28/2023 6:30 AM, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Enable K3 thermal driver, this is used on TI AM62 for example and
> > various platform based on that SoC.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Reviewed-by: Praneeth Bajjuri <praneeth@ti.com>
> 
> 
> > ---
> >   arch/arm64/configs/defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 0777bcae9104..cbacae73e9af 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -647,6 +647,7 @@ CONFIG_DEVFREQ_THERMAL=y
> >   CONFIG_THERMAL_EMULATION=y
> >   CONFIG_IMX_SC_THERMAL=m
> >   CONFIG_IMX8MM_THERMAL=m
> > +CONFIG_K3_THERMAL=m
> >   CONFIG_QORIQ_THERMAL=m
> >   CONFIG_SUN8I_THERMAL=y
> >   CONFIG_ROCKCHIP_THERMAL=m

I will be picking up
https://lore.kernel.org/all/20230731161048.2522154-1-u-kumar1@ti.com/
instead. going through the usual tests etc..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
