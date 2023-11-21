Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F227F26AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjKUHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjKUHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:52:16 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF7CB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:52:11 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ce28faa92dso41535175ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700553130; x=1701157930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2WX9z+qXmObEydEr4Jsr/fb5FQuMi975OooEeJzj60=;
        b=GgygPtODdXZWCJnxOKTCGOOKnMZM5IpAIMvTg9SAOAyC5f4IfL8yLuh0E3G21oCXpn
         /OoqNzx3E2lzfH9ozDdn3wcWYbbkyYTzfyNeD4t5NadQK9Xp+THyAqvBel5lMB5ZAntz
         QBhGAF9Y7tTA++H6pmSrBHLPa4qAjA8IoDFbnQTzZhiMF7m3XleR+/jybJv6oIYfqbMo
         oj1Ab5uztL7YnNn6G3d++fzUI/KqYrlifBJaW6v9zjbGBwT71Eiq9KvQNgClXsEfVQdH
         N9E3s1py1aE0kmMNDiZ3vWnQOyGaVyuFpnS4dhbOlhdQE28I7wtzGGb/PLS4OgTZJvbe
         z/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700553130; x=1701157930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2WX9z+qXmObEydEr4Jsr/fb5FQuMi975OooEeJzj60=;
        b=xLi1NJ1/PStJJ3G4sAtw6NIK6kyQMxytDSCNh09RjQAubAgdDfw0XImpXuRr6lNhvg
         8TEAT3FMr+4+Wh0A7g82g0BKk/PEdssSCQzYAlTMC15TbgLCVJGdHUCnjnexhWtCx+7L
         3yAVeScwFBE9/rmsbZBO6GHDmwrEaZEOaqsyiYZ9IoIFDdl/8nK37QQgG720ZjLHvwtL
         FrS01jrLXoBpawT5YgseiCLe6Ww+pkSa7TKaQk+OUmW0k9sRNArzRLEDfAKNEW4nzMrd
         AdnAuqAhpXAxiO/DNTygamc8u2SGIpX0jjL7M1pRjs7lUkoXtVvJ8swEvpO8oFsJO3Jq
         2GaA==
X-Gm-Message-State: AOJu0YxPXt5yLfcYhlMZ3sJ6BkRwpQOz+e1fRRTscV5R/yUdTYT7G0as
        QDhfbkjVcTGTTr0zMljKixRRahNuj5l4+g==
X-Google-Smtp-Source: AGHT+IGnCYzS+fogym/NhlsT3aV1sdcgMvY1MnbUkzlSJFH5N5nR34K77Q3GFneyd42Vv0iJUgjJVQ==
X-Received: by 2002:a17:903:11ce:b0:1cc:49e7:ee1b with SMTP id q14-20020a17090311ce00b001cc49e7ee1bmr11373490plh.58.1700553130536;
        Mon, 20 Nov 2023 23:52:10 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902ea0c00b001c9b384731esm7272113plg.270.2023.11.20.23.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 23:52:09 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 6CAC51026512A; Tue, 21 Nov 2023 14:52:07 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Soumya Negi <soumya.negi97@gmail.com>,
        Alexon Oliveira <alexondunkan@gmail.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Matt Jan <zoo868e@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Dorine Tipo <dorine.a.tipo@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Charles Han <hanchunchao@inspur.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND] drivers: staging: vme_user: Describe VME_BUS and VME_TSI148
Date:   Tue, 21 Nov 2023 14:51:55 +0700
Message-ID: <20231121075155.16078-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=bagasdotme@gmail.com; h=from:subject; bh=gd9leacfyMnMQZLW/LkwOu83xlPVFP0/KeYNEpi0Yds=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkxiaHT+B3mz17gm6H40bZdt7/BfKNVT6+83Zq7PNcfL VI73CjVUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgImcnM3IcHy/6q6+lkXO347r MPOfYOz0uzC57cSflbva/ramFNcz9TAyHA15tsdG6f9vvef/mZN6dyufnfH85dbla60jhH9c+3x biwUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help description for both options only tells users to enable them
without description of what VME bridge and TSI148 device are.

Briefly describe them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This is a wording alternative to Dorine's patch [1]. The wording is
 inspired by [2] and [3].

 [1]: https://lore.kernel.org/outreachy/20231029180346.8570-1-dorine.a.tipo@gmail.com/
 [2]: https://ohwr.org/project/vme-sbc-a25-pcie-vme-bridge/wikis/home
 [3]: https://www.slac.stanford.edu/grp/lcls/controls/global/hw/users_guides/cpu/pci-bridge/Tsi148.pdf

 drivers/staging/vme_user/Kconfig | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/Kconfig b/drivers/staging/vme_user/Kconfig
index d65cc5510649e9..8e5df6ce36e8f9 100644
--- a/drivers/staging/vme_user/Kconfig
+++ b/drivers/staging/vme_user/Kconfig
@@ -3,18 +3,32 @@ menuconfig VME_BUS
 	bool "VME bridge support"
 	depends on PCI
 	help
-	  If you say Y here you get support for the VME bridge Framework.
+	  Enable support for VME (VersaModular Eurocard bus) bridge modules.
+	  The bridge allows connecting VME devices to systems with existing
+	  interfaces (like USB or PCI) by means of translating VME protocol
+	  operations.
+
+	  Note that this only enables the bridge framework. You'll also
+	  likely want to enable driver for specific bridge device you have
+	  to actually use it. If unsure, say N.
 
 if VME_BUS
 
 comment "VME Bridge Drivers"
 
 config VME_TSI148
-	tristate "Tempe"
+	tristate "Tundra TSI148 VME bridge support"
 	depends on HAS_DMA
 	help
-	 If you say Y here you get support for the Tundra TSI148 VME bridge
-	 chip.
+	 If you say Y here you get support for the Tundra TSI148 VME-to-PCI/X
+	 bridge chip (and pin-compatible clones).
+
+	 TSI148 is a high-performant, 2eSST and VME64-compliant VME-to-PCI/X
+	 interconnect bridge with support for PCI and PCI-X bus interface.
+	 It is primarily used in industrial and embedded systems.
+
+	 To compile this driver as a module, say M - the module will be
+	 called vme_tsi148. If unsure, say N.
 
 config VME_FAKE
 	tristate "Fake"

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
An old man doll... just what I always wanted! - Clara

