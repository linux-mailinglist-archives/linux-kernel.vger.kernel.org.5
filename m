Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9796E800397
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377590AbjLAGNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjLAGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:13:40 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02957172B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:13:46 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B16DSK5082436;
        Fri, 1 Dec 2023 00:13:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701411208;
        bh=rB1XmTGzoDJq5odP3oGC6AWHoMG4DmhTDFrwngnRKbo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xmxsdO2X8yuSU30NV85rSXkx/XiVAW+559cW8D+MqgEVi1Qz+rsgZ/te1Bp+johuz
         Ybqb1pEVFOD897GraRJycluBy8j6M0jm2VpWeBpFbeQBTmJBEL88F/6YwO7egfNTAO
         ojXMQhmSR6+LeMIrUp+QikplcI8MeYfpW9CXbi9Y=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B16DSLh075933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 00:13:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 00:13:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 00:13:27 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B16DR0l084648;
        Fri, 1 Dec 2023 00:13:27 -0600
Date:   Fri, 1 Dec 2023 00:13:27 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
Message-ID: <20231201061327.mfadiwejp5akmlal@properly>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
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

On 19:29-20231128, Geert Uytterhoeven wrote:
> The Imagination Technologies PowerVR Series 6 GPU is currently only
> supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency on
> ARCH_K3, to prevent asking the user about this driver when configuring a
> kernel without Texas Instruments K3 Multicore SoC support.
> 
> Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")

Minor nitpick here - 12 char sha.. otherwise:

Reviewed-by: Nishanth Menon <nm@ti.com>

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/imagination/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
> index 3bfa2ac212dccb73..af492dbd9afd4ed9 100644
> --- a/drivers/gpu/drm/imagination/Kconfig
> +++ b/drivers/gpu/drm/imagination/Kconfig
> @@ -6,6 +6,7 @@ config DRM_POWERVR
>  	depends on ARM64
>  	depends on DRM
>  	depends on PM
> +	depends on ARCH_K3 || COMPILE_TEST
>  	select DRM_EXEC
>  	select DRM_GEM_SHMEM_HELPER
>  	select DRM_SCHED
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
