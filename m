Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215CA7E8C30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjKKSpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 13:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKKSpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 13:45:52 -0500
Received: from sonic317-20.consmr.mail.gq1.yahoo.com (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08DC7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1699728348; bh=7k+/Lp++yHj7+j0d0F+FragJXYDYTH7zSig2Tf7HDZQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=M76eNIVymkrSFhyBSXDSVqVhrOgDqh437O2gD0gyloA80XAkjoxphoxvrhVMTX7wrPIoGJh4oSUJDg5qsUVfHo2Iys65qkBT+HWUqaMFTMynK5V+l4W9FooWfYWX9/Y41+QxWS8zFBrxtMSiswCkHHUPPl1tAQmck62m3phes554K4yc2o21zgW2YqDFQw1TYV5TpmwLuonymVPQMSCdklleoM/RgV3Gv16YdnTjuNI0mK8uts2U4VD6TFfAztT90caPw2P3dN4ax9UGWQ3reKdFdmXtW1eaeEPdfzFH7AheNV3KgRAI+GHEHHzAknprXKyQgGeEcjzfuHe93uaZhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699728348; bh=R6NSUDEeVyyIX4F6J8syYWD5DeWO2XGw6dBgcM4fiyI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WBqXTjQxEvBbAn9nPeDbikM2at+eOyiiRthIQ1Iytgn5qs5BrdrX5KCxyGAdPupyKjfgc1TTLeEDim7/ilvl8YDNGyxc31pGagmO82oE6aYvCyDcoBE/iwStFonqERUib2xakhoU4l8KwTx5NiwtjJaDGDUNSA9U+8gCs6JQnSmc23iQ8YPekHRTWc2m2sNUWeLa4+pED5fb2kCRAWD5eI5jdpDdL8xlZ+JyxaXCPd9ZVV06g485BPdoTmd0DaVr6doUGN9Rhlk6jIECTsjkiUzU6QGJyXh2nUuzLs8Lu0wkx6Ss+iv/Ktm78mZKmJFrHCHeh0n+O95u92Mh5qtfLQ==
X-YMail-OSG: 9v0A1oUVM1lqwJtUV7Hk2diEcgEmen6asPpX.q2XJXPHOr7pMM5Pm4f9ZRDXvqe
 q6wDYSqhCk02vJgsya2_gM7h63_MPCfvuH6gnQTyRsJXJWNlM5jsq80Z9JKxf_S9ejOouArzIG81
 HyIFJZ0xcJ.UalHjJFbvpSEs291b6ClwAgSO6rOlZxU6j7ko.Nu2S2f33uyTJ_jzSKnsWZm7YwkF
 yA80doTNZhk7gVpMVl.2szFTKKmapedLxvuFNyZUIwJPLoap8Z2dsZp35xKmag9OuE308xuBDz2h
 3DrAU1Lznl36Amjop.z5Szlm5fmDDSOotNGcI4i4.5oBS4p5bHLUtemVF_O.5yfol3aFTRdTNsiS
 1H91MKiQ3bX8XXtAul7CzVOD1vPZnUHiWZj9SKvMvi8sikonXNfsGNiDrzDHpJ4GUudCGQ4azUUy
 Aw7Jlel4L.MUh6j83iMznXNcsiYMVQxcPecrA112x0qemAFIG1sca2ftkGYiPBlTnOOSP22hz96H
 m5OqWeu4M4OJZYCJbIfGSSAJcNq4MQTt33HrxzF8Q46oA0vbpj4_9UY8lXYuRdEcqtQBbv3dfSGA
 MRDHxxcp1OcO.WWZuo61JAeZXoCgJ5OMxXWgB.AE6MCxNZYobf4Le3cVVTnm5GS8sLZy4Wx7e59J
 Y5KpFeles9_4brqFYk8FrrKd_Cajgg80vRwZEK7O.GHu7oVBjlj6vnEJ2kBkgaaSWSabOPu30KGB
 8SH_ynyaMhMovdem2grbBvRW4saPhCEdWxNNTGjjayIEzRkgC8hMm1kIlT.KDsGxgpOIovBn8tyk
 9r2yIzEq8z7v1oe2DX9_nXAfIRFuvIZcn232305qHxEcTDfYxY4ZTWgEQCAP2ZC4__3SD83wTRpj
 V5FFpjK2NWY_GM45.1g3mJ.6jcy4CxyK2C3ysSq80R0vIjOxbZLMyGXQbePHp30SYbRE02tU1Wey
 C1i6ux5_OM0z6WBVC0JCTa3xqGDqX_VpGaEz7IeOnDgpUUPbDOaQBu5bmuq3jjPzsFTD9X5XzF_z
 R43iaPHWBfR8w9_pNuCHbfaKYAtdew.TPdoICWZDe5E6K5uhla_5MFIz1gk1mQbYOnOeOUdBF65c
 QIzGc5DNkcXqp2Qv5NWBicyLDK01Rv642NiPypT0O6vNHoi.957JCxBYKZLdjSUue_RU7xcu9rCF
 XZdP5x1E24ZnU7TfEaak02dpQIEZ51ZsdYNX.entYR2PF9.d0ME1gGu1xyfZGqoSMrbmXB5iix2y
 Q2Wpnk8.LIwOmV9cENvN6rC1oMuFjeWUBAfeCf67ZQRB.lGmPnYOlexlbEJNjZedbyhtrBsrUyHq
 1mzXC1S_mOs8q32W7ax_XPmmEqRVuyP7kKnvpd_4zhcfme_Mq.8Md_MFwRNJowoPIn1o5N48hpCe
 1j_b0k5SrG8KcQy1APskNKmUm5XLoJfgyW3sG1M3cFcAolZunW.yWb6o5auME9x6oB3BcCnKXUab
 rNvHIKt6dMbP4fTlpzJ0_NWLvmTZgNEnXU_rCh_vVXjuGzwx4PQ.5mG6SPpjJYlUJ5FenzkGcAvy
 4Ox7hiMWdedcf4xjGCFcpkDko5iWvbTiS6i46OcQKFKhG4qag_8UPdRnMOZfceo3uEvkJY_T6yeV
 j3LzjdOjN440rp_ywTcUx4m43HbPkyfgZx6QXK9lyLrScSoRb4Z3ugl7ZS0LFNLUPfZ256FYytBv
 XR0jeD6O4MBPGanBzSfNgCrTWD__ud6aQpWEvGXFaxOwE7kY8trFb5SdKlfcP0cvvCq6imrDrKK0
 QSVK6uLllzOnlFPQVhtiSeThkd1cbFlp.kC11IXW0Sf9_dUL1ouyTwDoyuRPdy0cWLDFNxKZpesF
 CHKLcsmilLH00ZorwDF5iT3eaulXFbNPGAR31lDnBZD0hE3u49qzzdZTA0AXfI70nI8UxRYWIWfs
 KoRrzbAJ0nGwvBQq.2gWRuyVGrdvM0KB.TWhqra8PDmLZ1DKNdDCKPzDV1WK11OOht4cx.N.7avG
 Y6sJLBo38VkUXSGidNjbuV8HoUsVpm3Mp12RAQsMPJXLzIXOy8d1VZjF0jLkEuoTPz0XsLRTcPhY
 fk48XNKDyFeV4pPg3OJRSDuyHXB9Rg2u1cVxlMF1IYc69otOQ1fP14Cif0NuQKVZ2a4HzVZ6V3WS
 hn5mvVK7_A.7CTp9gS5rGmqGp7BQ0DRqEGFVtPrfdPlY3cDz7_vArURyJMmRVEEeYPJo3hoT3EN7
 x6ihTJ2tu
X-Sonic-MF: <brchuckz@aim.com>
X-Sonic-ID: 935860db-45fa-466f-a70d-9a74ba36a6db
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 11 Nov 2023 18:45:48 +0000
Received: by hermes--production-bf1-5b945b6d47-pndd9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 58e07c2fd10b16fd7664a3575d70a740;
          Sat, 11 Nov 2023 18:45:45 +0000 (UTC)
From:   Chuck Zmudzinski <brchuckz@aol.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Julien Grall <julien@xen.org>,
        Mario Marietto <marietto2008@gmail.com>,
        Bertrand Marquis <bertrand.marquis@arm.com>
Subject: [PATCH] arm/mm: add option to prefer IOMMU ops for DMA on Xen
Date:   Sat, 11 Nov 2023 13:45:37 -0500
Message-ID: <20231111184538.2371-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20231111184538.2371-1-brchuckz.ref@aol.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the new option, ARM_DMA_USE_IOMMU_XEN, fixes this error when
attaching the Exynos mixer in Linux dom0 on Xen on the Chromebook Snow
(and probably on other devices that use the Exynos mixer):

[drm] Exynos DRM: using 14400000.fimd device for DMA mapping operations
exynos-drm exynos-drm: bound 14400000.fimd (ops 0xc0d96354)
exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma] *ERROR* Device
                             14450000.mixer lacks support for IOMMU
exynos-drm exynos-drm: failed to bind 14450000.mixer (ops 0xc0d97554): -22
exynos-drm exynos-drm: adev bind failed: -22
exynos-dp: probe of 145b0000.dp-controller failed with error -22

Linux normally uses xen_swiotlb_dma_ops for DMA for all devices when
xen_swiotlb is detected even when Xen exposes an IOMMU to Linux. Enabling
the new config option allows devices such as the Exynos mixer to use the
IOMMU instead of xen_swiotlb_dma_ops for DMA and this fixes the error.

The new config option is not set by default because it is likely some
devices that use IOMMU for DMA on Xen will cause DMA errors and memory
corruption when Xen PV block and network drivers are in use on the system.

Link: https://lore.kernel.org/xen-devel/acfab1c5-eed1-4930-8c70-8681e256c820@netscape.net/

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
The reported error with the Exynos mixer is not fixed by default by adding
a second patch to select the new option in the Kconfig definition for the
Exynos mixer if EXYNOS_IOMMU and SWIOTLB_XEN are enabled because it is
not certain setting the config option is suitable for all cases. So it is
necessary to explicitly select the new config option during the config
stage of the Linux kernel build to fix the reported error or similar
errors that have the same cause of lack of support for IOMMU on Xen. This
is necessary to avoid any regressions that might be caused by enabling the
new option by default for the Exynos mixer.
 arch/arm/mm/dma-mapping.c |  6 ++++++
 drivers/xen/Kconfig       | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5409225b4abc..ca04fdf01be3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1779,6 +1779,12 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (iommu)
 		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU_XEN
+	if (dev->dma_ops == &iommu_ops) {
+		dev->archdata.dma_ops_setup = true;
+		return;
+	}
+#endif
 	xen_setup_dma_ops(dev);
 	dev->archdata.dma_ops_setup = true;
 }
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d5989871dd5d..44e1334b6acd 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -181,6 +181,22 @@ config SWIOTLB_XEN
 	select DMA_OPS
 	select SWIOTLB
 
+config ARM_DMA_USE_IOMMU_XEN
+	bool "Prefer IOMMU DMA ops on Xen"
+	depends on SWIOTLB_XEN
+	depends on ARM_DMA_USE_IOMMU
+	help
+	  Normally on Xen, the IOMMU is used by Xen and not exposed to
+	  Linux. Some Arm systems such as Exynos have an IOMMU that
+	  Xen does not use so the IOMMU is exposed to Linux in those
+	  cases. This option enables Linux to use the IOMMU instead of
+	  using the Xen swiotlb_dma_ops for DMA on Xen.
+
+	  Say N here unless support for one or more devices that use
+	  IOMMU ops instead of Xen swiotlb ops for DMA is needed and the
+	  devices that use the IOMMU do not cause any problems on the
+	  Xen system in use.
+
 config XEN_PCI_STUB
 	bool
 
-- 
2.39.2

