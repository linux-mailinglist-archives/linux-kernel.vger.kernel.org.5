Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D837ADE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjIYSSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjIYSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:17:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D710510F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso40447565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695665867; x=1696270667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSdigwnv6RgG85RLkxEQM6OYgPlcYxXywtYyeU3tLN4=;
        b=FtCBkwN3W0/+8LhJxWqK5XJY4drpNuX5fDkrZ2gltmZMepZ01thIByPCgZrttcT6aN
         LIlyhThm/QNIMpXiDHzN7wNZ8mKKyER4IbqNIJkZ6irBPh5Y/2IgegJj75KqoTS5a4x5
         vu+Udn8EHkV0E7TjGxOCoVDlm1CIgXHKUGvsgQ6ukxL1fAkI+OcnlXtjSALt4sbPU8E7
         XrH7aXwnU7S68jaLwK2DxT1lJMk4S37R1SGTXJ8tlojpTaoDrZ+Dc0MDBG7iXm1maQLc
         Mrtm/quFV3zONN8ZFXJRrzhJut3RBl9G8jb3u9vpCFM31rZcyzVGW3W64KMLWqRoW/Kh
         hdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665867; x=1696270667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSdigwnv6RgG85RLkxEQM6OYgPlcYxXywtYyeU3tLN4=;
        b=BHTCM14dz29Lt5T7mdxDwK7g/o1TEaLFCKubM6SKHF2JO20ziJwUkQ7Q0xND3N+fVw
         c8u5hKSCaYsYBhQrBhxTzLY1rWMXp3tItEkFLAGc0UktXzgSj/U66dFVQNEWYwWkUU7e
         QIDR9I0YsmEHEI9zFGqjokq6LfQHs+Tnt2uVVYteVup46bd13RFCqKGyYeUtMjoE5PpY
         NK4xmS/LdGbaIYox/zi1LDF5jXsHOEtIOwPsBBwrWSWi3fv8xaX8tg5LGqreaaqRjKZ7
         IRKZYD2J5vEp9Mx5vPM3MPn8stczMHE770ufESJD7QhSNVI9p5DCDynpRF03GtNGl/WF
         6CQg==
X-Gm-Message-State: AOJu0YxzNYSxDwB2Yq3nnYU2uQqtRxU9jCmwCgNKo/uBXvWzrzkppHeF
        QF798SaAYOk2DCwvFlWxhsV3rw==
X-Google-Smtp-Source: AGHT+IHYBE2IuQNCq1Gt/vn7Wz846Rak3F4Vhdj8pjePlol8AQ8j+B+6CylLiG+V70368axjPWWF2g==
X-Received: by 2002:a5d:6084:0:b0:320:7fa:c71e with SMTP id w4-20020a5d6084000000b0032007fac71emr7331834wrt.15.1695665867378;
        Mon, 25 Sep 2023 11:17:47 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j26-20020a170906831a00b00997d7aa59fasm6793962ejx.14.2023.09.25.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:17:46 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 25 Sep 2023 20:17:37 +0200
Subject: [PATCH v6 3/7] arm64: dts: mediatek: add apu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v6-3-24453c8625b3@baylibre.com>
References: <20230207-iommu-support-v6-0-24453c8625b3@baylibre.com>
In-Reply-To: <20230207-iommu-support-v6-0-24453c8625b3@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=CPSRatML/h/herC8Ies/GAwzWIDM+NFutvJF7JB3RkQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlEc7F95BVIXjRxwsMjDXaJ93Z9uiEPOMTZe4Dv8av
 uxZJVnWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZRHOxQAKCRArRkmdfjHURRh9D/
 4l2SKbqEelg7PLcaIrgtjVSeftxwmzStEOiWfil8pu5QyA8ZcyePOpBRkI039ECNClYWt4CuTUFVYd
 m+SJf+1Yy43dxPOtWgTqL52++b5ZZW3fYRCNqUKNlMaeFlK1XQqWme9Hciopf+RHXTLU6/21aW2Yzf
 A/sFVGtT6CXRmfr6M1UzlcILF8xsseJUn0tK8mfM1+zfn04fkVLGx3F/fMJWKbMXteEG4pch1wZY0F
 /9ZYfgs7PB70sbZ7s09yiSP1eiBJC7VLAJtWCdi6b4Lbfq2t6O4ZtZsxmP2v0Qh+UYbjIVVmZ+2Uip
 zybgELeq/bSX0FPIeOOjCJzCSyFBXkulrL56ozabF6NFnUXFTLM3N2VIN55VeUucvn7BV73GvpnYaU
 4d4FHLwB92g4+OgwqhhsTIAmNHBDrYsxkO4+qDTBkh3my9ZS9MypgNxfWX9iLKMzIcc7SltQ3nyLnH
 Ojq8KdoqHRrCU+fcgMb4rnfQLEojHERf4n5AOctZSxBu6rEZ9wq4cwVYQEI2PFWvp+i8zxXhNhYs7j
 gEvqT9+tBWux1BJIuttIKPKY9j+xPjWWhKeHGj7c4UXUrxSwZ8uwahk/L1hAa1Mu9NJg/t5QPPOWXW
 tWUnwyIthZWdUE4pl9QsIsmKfWlfzhZg6r4/WQGCjNaQLcWL48W1y+3NToiA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AI Processor Unit System (APUSYS) is a highly efficient computing unit
system which is most suitable for AI/CV algorithms. It includes one
programmable AI processor (Cadence VP6) for both AI and CV algorithms,
and an eDMA engine for data movement between external DRAM and VP6
internal memory.

For more detail, ask Mediatek for the MT8365 IoT application processor
functional specification.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index f9cddce5bd9d..c3ad7cbc89ab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -615,6 +615,12 @@ camsys: syscon@15000000 {
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		apu: syscon@19020000 {
+			compatible = "mediatek,mt8365-apu", "syscon";
+			reg = <0 0x19020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1

