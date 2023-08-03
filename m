Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4832176E4BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjHCJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjHCJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:41:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43313581
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:41:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso7604775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691055672; x=1691660472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxkPmAViZ4bBY9DKE4WBvD6KeHCq77X51+2zFhsJvjI=;
        b=nVOzC/fyH+yzD8G9EHecBPK0eWIjtfrOVLSW24WxuU0FxPbQdHw/UyY+HdPU2PIFX0
         mi3TJBIDPjNyU/0l07O7oXWdswmLt0WzQvuym12mSkOPnDEqkitET7zdLpvS8KvJGENm
         FYHS8+n2yGUxXWRz5HnCrfZw2QVn2FCyIUtfMqB+aKlBg6hMzAwTgmTmgP8E18HUDUCt
         OQjwnNA8dKEQUIlAzf8eapVPu2k2DpkieAhKWfHCJ9ENml6/0BB3Qbo8OvAv51MMKi0w
         3wU+snUb5y6kf5e8OqQ/CDAnqfPwQOTddkbyYBv0mVWv4QURUNiKnmcoRQpbVCIqfPnS
         HMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055672; x=1691660472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxkPmAViZ4bBY9DKE4WBvD6KeHCq77X51+2zFhsJvjI=;
        b=ZcZqfK3YzDdN7THOL2//5wNE7/SgLrbIuiM67iHnptZcAzrTA7CKtW91+bxd76NqFJ
         09/O6CHnVHjgnwBK2eoBM2jCy4xsEJ4gE1A5hju/BmlhOIb0XtWtPa+6nG1yjHsimVXv
         1fBSjZO0iKnw6+73ZB9kLbQX2Ck9D2y8jU6EReD32/+8CLC7GjQns91kfJmXB+kbQki+
         U03YTDI1qOtJpOjcpntiaFtPytLxyGocSxBtbnXjno4nAzDDJ5RmHJwg7xMsQH1VI+Di
         8jc7+khCB7Xemy8WK1qQ6W0vZhsD+frQEXniasLtkZ9MQNps4208yH0nszVNB0GP720Z
         tH1g==
X-Gm-Message-State: ABy/qLYPc96Kyknj3poiyuTEZ+5rMWfS7jFjVe9quj3R750p0xfHgOxP
        EJ78nlMLgquwHzhABLHe/UqChg==
X-Google-Smtp-Source: APBJJlGfqWuOZ1y3FemnkiQGD3vZ35hDptoXu7aAiWCmrn9R2zrux3fKhJjN70AH44CvsZEaEAqvpQ==
X-Received: by 2002:a1c:4b18:0:b0:3fd:2996:9d88 with SMTP id y24-20020a1c4b18000000b003fd29969d88mr6702974wma.25.1691055671647;
        Thu, 03 Aug 2023 02:41:11 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm13294994wmq.1.2023.08.03.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:41:11 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 03 Aug 2023 11:40:58 +0200
Subject: [PATCH v4 6/7] arm64: dts: mediatek: add larb support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v4-6-84798657c410@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=YQ4gFuFLZ3ZXhHJoLIMLvf6JGXdHrmuwZeJIyfaEitM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBky3YuBVw4i/Z9cSxRo3MXCg+TjdfkIHGZDri5k5Ip
 YHJc6mKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMt2LgAKCRArRkmdfjHURcx+D/
 4yToAVIyrWA4woG7STs3ZuLzCnqTegSZw1KjRjBJMWKRnCPzGNsiQPnLHGiBXcfxrs3EC3/8ljLxy2
 4CoU71zfWWi3T/3aBfvLUk6kb3KqLMTFc/1/ipLh2p7eqqoYH89S+AUeR4uuTLdtqUP318svuSnjmA
 Z4IAl4mTVpfK3A8VprnFH6f463qbJD8nVvl6YyuHbfmP85v6eO82cpvCdNHCOeE7TPjL0YycBhKEsa
 axg2aVxGUPHr0aVGrxaLCFtL9ewWD5uCAHVJJ3ZGxfIEaSpSItz0eiTfDhH/DLFFOA7OzJKWdIWmIB
 o6cvangqcIz2Nxtc08zR82NpM9o995kB+MA4Io+NazQAfF5kjTIOxC87J0peEa9ZAW9dbTSUC4a+9p
 UyYuG+AukMC1t9U/er63LWZyU1r8mLTf/RwliEEvv24Bmc6b24RxrEZOeTn9C4gylf4z5v2UokpInQ
 MS8b+faKrWKr6iVa/B6G0NdqZBOYiu0ODVG6drg5n5oK/ZUJv2SanqPflrEwsmxU/yT0DnDtOBwqta
 sw1IyT8pmqBVk3v5LYxe71UX8EV6E4n5EQFUfaEtcRGPIOII/7rQ00KW/QJLF/Hav+Aq03HKBiiKBp
 WuajFlH8z2DGqPQXa5wECG+EPY+0n9lsnBtBQaZPGdPf2po6l+G408UBxfig==
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

Local arbiter (LARB) is a component of Smart Multimedia Interface (SMI),
used to help the memory management (IOMMU).
This patch add 4 LARBs and 2 clocks for the larb1 and larb3 support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index a03b8c0da68b..afcfa1dd242e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -735,12 +735,71 @@ smi_common: smi@14002000 {
 			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
 		};
 
+		larb0: larb@14003000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+			mediatek,larb-id = <0>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb2: larb@15001000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_IMG>,
+				 <&camsys CLK_CAM_LARB2>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+			mediatek,larb-id = <2>;
+		};
+
+		vdecsys: syscon@16000000 {
+			compatible = "mediatek,mt8365-vdecsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb3: larb@16010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_LARB1>,
+				 <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VDEC>;
+			mediatek,larb-id = <3>;
+		};
+
+		vencsys: syscon@17000000 {
+			compatible = "mediatek,mt8365-vencsys", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb1: larb@17010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC>, <&vencsys CLK_VENC>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VENC>;
+			mediatek,larb-id = <1>;
+		};
+
 		apu: syscon@19020000 {
 			compatible = "mediatek,mt8365-apu", "syscon";
 			reg = <0 0x19020000 0 0x1000>;

-- 
2.25.1

