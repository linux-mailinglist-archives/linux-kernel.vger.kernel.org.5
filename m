Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00827FF368
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbjK3PUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346261AbjK3PUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:20:19 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4810F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:24 -0800 (PST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ACC863FA53
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357623;
        bh=x/4VKc6j7ZPLGeNJb06p6pcCmpUDLk01xwbpFjzzvZw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ap1qRYRraseSqCpDR3saeu4bryWspvFmdIcGYnSSvvvjGtKSq8qLb7Yx1hJElwaEm
         Ziv+Nu8IeQ7xU5D70a0ov8QnfUOpcv2v1nRQj5vgAPG20/YRH88VP1DlI9Iax0ziOP
         BAADJ5xYfxCJ+Gt90xD2K9hOc7e84I9oJDjqN8jv3rY5gKuSq6eCSucqzp+g9DBjqG
         cAvoLgMF1XWXSRk+PDFqHpS0Uo/YbuToTIbLkFW/0luT6TF3bG9/tE73aHXL0JD6Ad
         5lGeXOBROj0XKGYfeG77c8ltJ3ZSyK9FPkGHVAoJTIHxGNfBD1zn+UHfBkptVh+thS
         zpujZSjzjVMGA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cddc344b98so1284089b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357622; x=1701962422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/4VKc6j7ZPLGeNJb06p6pcCmpUDLk01xwbpFjzzvZw=;
        b=O1v41VkY7xIxF6RgLy66y7sWPmtjAaIBOdnDYgij1Cag5pppny606iSOZeUi0y4pit
         hcfFrp5DHSOQlE8lY/zJRKMv0KDCJaQWSgfJbDT+hQLGrdt+DscwaQ/R0SBJ+XJnTxsX
         U9F2k7zQqhZCeOtg+BjYJRsgt8087rwcZFtEzf/cb7hv4svuUMOUHmCOZjsaSUgNSfAr
         SbEv/J94NMrQUxfgSIM7Mp6Qsyw5QjNd2Pu5HkdTYQAyi2lKtxGDcBAIAAW4LaRSDl7q
         dpoqg/1L9GecXyovFab38N/Ss0NrO4jetunaRCSlC/fYrJbTQ7AguWCy0E7feakd8gzo
         Ti1w==
X-Gm-Message-State: AOJu0Yy4kRLGFb2qxdCJtTPLbWt8X4Mefa+Aa0cnNO0RI4qv0p/33wO8
        7Dy25MnvH/h4580lTXtQQ1OUe+f3HVdGoHFq0AdG+9uRqXx563lbA+0iCDCaWvDyc1GXG7zRwqA
        Y7ydzZ34y7rYzT2D4W3t08DlZ+gPNPA1PlZAtKKMOQg==
X-Received: by 2002:a05:6a20:144b:b0:18c:548d:3d0f with SMTP id a11-20020a056a20144b00b0018c548d3d0fmr23512358pzi.5.1701357622022;
        Thu, 30 Nov 2023 07:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJual8Lkb2g8N/YiH3FRK7taRMkY4AzxQVOPrkbyzCXqvXjTjv3kTIlyWPfwhdcnKtKcS4lA==
X-Received: by 2002:a05:6a20:144b:b0:18c:548d:3d0f with SMTP id a11-20020a056a20144b00b0018c548d3d0fmr23512330pzi.5.1701357621745;
        Thu, 30 Nov 2023 07:20:21 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:21 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 5/8] riscv: dts: starfive: Add pool for coherent DMA memory on JH7100 boards
Date:   Thu, 30 Nov 2023 16:19:29 +0100
Message-Id: <20231130151932.729708-6-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The StarFive JH7100 SoC has non-coherent device DMAs, but most drivers
expect to be able to allocate coherent memory for DMA descriptors and
such. However on the JH7100 DDR memory appears twice in the physical
memory map, once cached and once uncached:

  0x00_8000_0000 - 0x08_7fff_ffff : Off chip DDR memory, cached
  0x10_0000_0000 - 0x17_ffff_ffff : Off chip DDR memory, uncached

To use this uncached region we create a global DMA memory pool there and
reserve the corresponding area in the cached region.

However the uncached region is fully above the 32bit address limit, so add
a dma-ranges map so the DMA address used for peripherals is still in the
regular cached region below the limit.

Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index b93ce351a90f..3af88e6970a3 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -39,6 +39,30 @@ led-ack {
 			label = "ack";
 		};
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dma-reserved@fa000000 {
+			reg = <0x0 0xfa000000 0x0 0x1000000>;
+			no-map;
+		};
+
+		linux,dma@107a000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10 0x7a000000 0x0 0x1000000>;
+			no-map;
+			linux,dma-default;
+		};
+	};
+
+	soc {
+		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
+			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
+			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
+	};
 };
 
 &gpio {
-- 
2.40.1

