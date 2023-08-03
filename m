Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06876E4BE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjHCJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjHCJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:41:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA6FF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:41:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso7726845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691055667; x=1691660467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RatweBkvtrU6P41JPdWUfgV+9gxtDS8Z15ua81Y0Obw=;
        b=APeHPOyXf91yHIRI6YBNzlWPRQbO1IR+eQsGr21Ao+xfB9anfLQGbZNT/J1aHg9Byp
         v6LAOPFOZlNliD/AKDOIs050mgezdwlUWdqwUDf+jO+hD4pBMcLSgg9SLwNPDFgZyWq9
         SHLCTzxtL5hUt4jXWRzaONUoMufxm2+XYb4TGVsQ1WddU9CP8s5pH7MHmyOIZUo/JBMy
         8zOQZSL12lSc78hThPvHYS0X6NOvVDF64BaNQU7abAJZIkSCyUt14YVIzhovOlyZQfr1
         jSI/rMRDAj9KvyayyPCmYpuw/xpC3Uu13AvXaooleAhrag0RetHNtRAnyTOh3prDBxRV
         pGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055667; x=1691660467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RatweBkvtrU6P41JPdWUfgV+9gxtDS8Z15ua81Y0Obw=;
        b=SoKjgk3tKxquWcrHkT44898V64NiHm4gzOFm/cPi47Xw2/dEAfUCxfYUje5Z3OP8dl
         6di4B7wndvIEqAzwdC5IOS4gO4cWu5mRSJHQ0xBN3FsP/Q4p9gWyujVmhFJvefweRsOa
         ot9TXTVXQO0INBBmM3RLKduU+8cN/9WDl4XGpWqLSnj0y8BKYKwF+8L+IDg/GSaPhdJS
         jpPS8Jn2EH9085dYcCUYSVaNHL2k5mRJgXg3Vd9hSrx3uk1Yj9DFAZZAzSTnL2GTrXLj
         HujHrbJMAULLVC/lJSXFVU3I/bd+HqcDiIoSQii2emqtvUu+aVvHsuu3feAuw89Z4gJx
         kMhw==
X-Gm-Message-State: ABy/qLZT30jxLJLmbm+XwV4o+VcppTEU8T1YSBGI7zTMVrU3nruy1FdY
        W1Pa9w2HpY+BOHm3jOhnmmU4uQ==
X-Google-Smtp-Source: APBJJlFdQc7Hmxq2dsKHT6YWTWdGlvcTVi/JAbNG1Bne3H9oL8moyeKPEPygjcJT8ejEkDONpsbtRw==
X-Received: by 2002:a05:600c:20f:b0:3fe:1820:2434 with SMTP id 15-20020a05600c020f00b003fe18202434mr6613795wmi.1.1691055666846;
        Thu, 03 Aug 2023 02:41:06 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm13294994wmq.1.2023.08.03.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:41:06 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 03 Aug 2023 11:40:54 +0200
Subject: [PATCH v4 2/7] arm64: dts: mediatek: add camsys support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v4-2-84798657c410@baylibre.com>
References: <20230207-iommu-support-v4-0-84798657c410@baylibre.com>
In-Reply-To: <20230207-iommu-support-v4-0-84798657c410@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=gpd1qVgLFNytHp6mp3Oxt2b2oXUpJ1x+ZZ2jt7uMt0E=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBky3YuE+488b4g/54Hcf31FvCM1sQ21gc7YrC0+OFX
 n8nhfbWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMt2LgAKCRArRkmdfjHURS0IEA
 CmumZJyt4Gu96SS7OfBEGId/hR7PZyr8cF6qcQFLnoSJICFp7JNYXWDe6r4lw5aiZimmG6LbXpTgB1
 z5yrnL2/ULnRZA5KFBll3L6dGjnte98QKZwMNLquQfZO6YDz6r8mEUH4fsT8Z2MvHZaf32HffKShq6
 IhhSQC7KUNSWqn+el8qR6pXY6fE+o6UdHxod/lyOU81kjuuqf42DafKBfdCQ+HbFluUYMYuZxvCjpL
 o31BbfKGE+YGxXVpXwHtz8cFBwxlKRHZXe3U4oIxPUMrTHIG3mivQhp8a5nOXPoM00aLBdvNLEuN/t
 GVFPGgUORS8IIR2SkPZiU73V4mgMQmbNsH0CVcF1+uIAJ4V5ue3mLihG87shhzHiDNAy4JIBV3LnCm
 ZG7xbGHh6K4hZ5Npu57AbawgTP0OCZi0k+PKijLDN6dBJfEPRvFCRZaKQpGdSzUvcLsUm1q5JGKh43
 VUU3qFGt11wJR8B/WdaKrdnk//Mu0O0GVH03dtc72QLFxe91GsmrV1Wlh9PfOqxF3tPgFkiP4PNsR7
 RDaEPAVjr2YIpnmKO+3gpxvdPHz0pEsDaxz2Kg1yC8RdN++1HSjCEEURWY9MaX6/lK7sfGR5dWyBXB
 jKs5ME+8RFC5Ru+NaiTLto5KhmCAbGoFdm39Le7KO9Ebr4Gvo5t8gi8AZHkA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camera System (CamSys) incorporates an enhanced feature based image
signal processor to connect a variety of image sensor components. This
processor consists of timing generated unit (TG), lens/sensor
compensation unit and image process unit.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index bcabc2b89a94..f9cddce5bd9d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -609,6 +609,12 @@ mmsys: syscon@14000000 {
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		camsys: syscon@15000000 {
+			compatible = "mediatek,mt8365-imgsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1

