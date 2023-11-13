Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07117E992E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjKMJjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjKMJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:39:05 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D8210E5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:39:01 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1f03db0a410so2509561fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699868340; x=1700473140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkUqHilNLJf2jcy/dzmNPu/MlxdQwClQb83sCKhp4LA=;
        b=XUcmWv698QMihZvs6W7YFiYNIka2t/6WJap8yUfl41BGqq4tP08Uqs3wUlz/p2xVrk
         r1g7+1LTgQ6Tbzxx8hGqv8rEcbUZSSUiaeuiOa4vGxpaR6brs3yxxynTfdr8pUdySFjs
         tYFUOjBU0AySCwPCENxvHqgdbWS1F0Q1JIH1+ORTpB3wmxdDGFMEqXADf7gEBu8qGUnp
         azjToCh/0bQbLASi0RS9UjEAEBJ6B6d/3JXf9ypTG4E+HOU9Vi3rFSxLbWww0wtOPiXv
         7MPnHCvwCcmotVA7H7SL8sUXbNAEFyjQbVmEb92sCacQ/FUI74DxTYkVVmS5yiEY55S3
         XbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868340; x=1700473140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkUqHilNLJf2jcy/dzmNPu/MlxdQwClQb83sCKhp4LA=;
        b=Muu5qxROVERZFvEc3cBG+XCTkUivxe2ygbpAU8fYeVMna5FbvCieupzHhjFEFOGT6g
         KoKJqim+Yi6FigrcHCziRHuayern8aMybGncvgm9Bui4tf07uxFZZQr+ZrzGt5uR58xn
         8xQeLecJsBVHIXXZx4EVM6UViHejNqe0spcCPBzCyfU+jIYvkpGNv5o7fzT8Qku1Ikea
         2Y7JqYL4AHwvjr7AJBMtGnS3v75JsC8AqWiMkEzn/u7E82TAVvS5uyDvcHPfwTmkiNIL
         KvQqXDFsnYakIl4fAgcrXlk+JYPaMmrSpDrcvWoTVrgUB3ZfXboT/f7MTZn4X4x5fo2V
         IEbw==
X-Gm-Message-State: AOJu0YyKgE4kaKnbmW2TZ+IYHSc8J7WCZ1KLgCaeX6JaASzS4ravajCf
        17/5NjK5j7dmIF1SPhugTwE=
X-Google-Smtp-Source: AGHT+IG+55gFc9k3ODG7zuJ7MS0xkDXbZatxNHnIOwFhu9j+YucILfgWXZdijEaKt2hFzVqMdYsB+Q==
X-Received: by 2002:a05:6870:414b:b0:1ea:159e:75ff with SMTP id r11-20020a056870414b00b001ea159e75ffmr8726298oad.2.1699868340507;
        Mon, 13 Nov 2023 01:39:00 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fa35-20020a056a002d2300b0065a1b05193asm3490700pfb.185.2023.11.13.01.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 01:38:59 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id D2A571029976A; Mon, 13 Nov 2023 16:38:56 +0700 (WIB)
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
Subject: [PATCH] drivers: staging: vme_user: Describe VME_BUS and VME_TSI148
Date:   Mon, 13 Nov 2023 16:38:38 +0700
Message-ID: <20231113093839.7687-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=bagasdotme@gmail.com; h=from:subject; bh=NQNt33u+INJVAr8Nxt440nGsCQJyT6tpJZVWZ83RJ+4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmBb0X+K2XaLrdi41W54G+98VarboARY5ad/96wb++Pm 83UL+LtKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwERMRBj+x0/u3PxtY0+946+g rp2m3dZT2ffGaF63UXU4ZR5/x+/xRYbf7EcSXD/qP92Ws9aeUYn77LSCyQetrB7NKim8VL/WSmA DDwA=
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

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
An old man doll... just what I always wanted! - Clara

