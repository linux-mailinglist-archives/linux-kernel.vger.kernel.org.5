Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E117AA2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjIUVed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjIUV3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:29:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246285AA9F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso1127344f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317343; x=1695922143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaqmMPfKXAOtSVjFcLvPHbWm7slgkGY5/ld8VMlAl3Q=;
        b=B/bfnwSEfkB7271SnjIa9UnvNsZ1Z8MHI+KH1kbrWNytjj9BMhLzx3dcjkZM4K4O2e
         CQ9fBOU2IaQ144/Z2JgA3/7oSbp7eucogrGv49wSP/Pa7pMVGLPldNtV8TPTNbhep1En
         pW+vJX2LzM0skEWaDMaCM0tOMiTNeCM80WAZdz12LQ5KRUb0yDj7heS4Q4jJjcQqe3d0
         ChFKcTYtZU2Cn/We9I01HJ9KN4ljlZt0MNGxwLIAzUCmvMz3BJ254XP+egqtLuxEFdT+
         XA2b/rwKYi+Jym4890B3/K8PUeJDVKm5ZwR259WtiTgcv6qGTdV7kOKQsKbzmXTSi2W1
         Lk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317343; x=1695922143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaqmMPfKXAOtSVjFcLvPHbWm7slgkGY5/ld8VMlAl3Q=;
        b=UMAy5lSEllhqd7bCW8Fl8GWIGaDdf6jSlBNnx+6h1oF2NomXzicp1CWkNpFVJ/Vlly
         ACoqpq+mTqOeiloXmW39Zl/pGmRW/7Qa3ywKwj4Q7HYswDRIyVh1RwjcfJJh3g6L+IET
         PoC9/sb4qTqcHtVPXYqV0Ku1BlrtjvLmEseD6emenAREcXoQGwhJurI/oFujraH8Bden
         ODLYMxn8uDyzlmLCulmfzVcnq+cfDCwq7Fz+W1ppZ0xy1T4PYkswt1dduRew6hP6jMjr
         gQQJjCApSZZJbiaTBdiB1/tQ5pCJwDC0djWsAOOoVmK5l2WyJ7X+QEMouej8cIsSUiCl
         xnOg==
X-Gm-Message-State: AOJu0YytYFP+xxhBJwYjJFFSy0oAKGykcX1+awieTs6aQefzpqr7oUaD
        m25AfGIIJCBtfl1TrboR0FC/z09HcDRI9yZTR5Y=
X-Google-Smtp-Source: AGHT+IFaAYDa6Vr0lrCvqGhnr3YcAh06ruBWoq695g+RZk8mUCM1VfhyAsQXvwPJdaNC8FQdqzlkZw==
X-Received: by 2002:a17:906:28d0:b0:9a9:ec12:4832 with SMTP id p16-20020a17090628d000b009a9ec124832mr5144140ejd.41.1695306778831;
        Thu, 21 Sep 2023 07:32:58 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:58 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 16:32:46 +0200
Subject: [PATCH v5 7/7] arm64: dts: mediatek: add iommu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v5-7-fa6f03680832@baylibre.com>
References: <20230207-iommu-support-v5-0-fa6f03680832@baylibre.com>
In-Reply-To: <20230207-iommu-support-v5-0-fa6f03680832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9vmrSAYQ/OJGejgymOj9rq18l0jyb8olHnhsKnJiPYw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQPl1+LIdPl1L229+UVcYfLca3OCYNM/P0YnuXB
 v4QWDSCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURQJCEA
 DHuD1i2t/r+Gg3749MClPYGF6EvLT0nqGc30sqhS8plPDlblum+YJR+x5f9yqpboZgb+3sCnX7Zi6E
 d4A/JTQDZ1rL3QYD28iI3zVNVFl765+7QIM/KeVEJ9HThaF0sfXQe2i6Pvsy/IetfSueods9QemGkq
 JT9DTpz6wFf7Ciq57MLgYGvCxDq0zY0AsZ2sJV1mxmQNkfxVfakpoRgiiNmPbNrbzfFEzlLTf3Udp1
 j8iZCsdmO4kQT8oLRzMzepRpIIQNlFo+aWfjq3L/c7Gl5YoE2tgtsRcVt7b8czjJJH4xoMCD+mEHfe
 Pp1LRdwNJGKcOmDuH7Bs2MZTyFOYLWtmQ8Me+Ht9Nkj0P3r0iZTSvBRn7HVSzx9GL/eE3pTDJm/Iac
 s0Kqc/ySTwwbvhJn+a6NqUZaW5pI9szuP6KThc56aZnU8xKbo2b6ROzifjl2eEIqgSsm8tIyrMIMqn
 3mLLqsDL0vBKQdyhw+FjU0V482ifiB0swMjtuzEgQHjc+linbCEBFDWe4LfTnFV+6w0dSWCSaufIXt
 xPedYGgozlvbrJK8TJLdcfHzQYz6qZ+dl3iDu/yWu+MbXuRmXJ7pYgP99wIL+8bEORcE2Mj2J8VzFH
 wJnE5PfTyKrI/9/85Dch7lBPFSwIyjoAa+RochVFwz9nsl36hPVAF/8K5ktg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu support in the SoC DTS using the 4 local arbiters (LARBs)

Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index afcfa1dd242e..24581f7410aa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -471,6 +471,14 @@ sysirq: interrupt-controller@10200a80 {
 			reg = <0 0x10200a80 0 0x20>;
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8365-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>, <&larb3>;
+			#iommu-cells = <1>;
+		};
+
 		infracfg_nao: infracfg@1020e000 {
 			compatible = "mediatek,mt8365-infracfg", "syscon";
 			reg = <0 0x1020e000 0 0x1000>;

-- 
2.25.1

