Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D3D76E4C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHCJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjHCJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:41:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE6358B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:41:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so7538055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691055673; x=1691660473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaqmMPfKXAOtSVjFcLvPHbWm7slgkGY5/ld8VMlAl3Q=;
        b=ORHKnuWxwNVvjhuPg+lGCHO2YLJA5sqiZdPzQsNUCwPqjluQs7KGXlQ8CubTtLmlQT
         c8bm7rPEPljBDm4e8hAyNHrnsMCInefUM5LcxQs7KP7xKaMJcmhFWzZrJD/xbaHkMq4K
         0J5eFFVdb/TKh/yck1LHmLiMstpoxAt+ruXdmLEWzqe8yf1uh6C+rft1ICXtICDAjph2
         HAspl4rKv91tZHnMiJUXBNwCch9/Fxri0gWcp5/L+rN6gbuBXEwIDeeqqmJuodktKHcJ
         gTTY88x8CVZsDWuBaRdCVQWh1gGKYMDVVyptnAv+x2ZNSyKHJeFpJx6eA9Ib9qSSYFuK
         SDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055673; x=1691660473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaqmMPfKXAOtSVjFcLvPHbWm7slgkGY5/ld8VMlAl3Q=;
        b=W5Ojw0fLC+K5HUh/09wKepfa8gKFDpBqH083o2muUQ9csqGSVgMz/OQmExtuXtabEL
         7qY4i1Wxo/maFypDkUWq8U2m6nv8N3cM+ymYSyFJgcKaYDohTuAIbKePBGoLNcNJg6VU
         omH96IiYUqznpQ4YkmvasGTuWP3vTTNgZ2hsr/nVFU+L28P4bbgxdnbB9Vc7VH64/Eff
         FaGRJU7yiKoEYaat4ikgqjaHJBfL/2hJhymrqWO2a/5UB2Vft4w1B3w8g0NobRhKNYuz
         M/ZpNgIP/mvilsXHP7pNwOiADuvnsfFkn0AQ2Ke1X0F5oGYsS0bUrHgRBi30G82S9Lb1
         tmWg==
X-Gm-Message-State: ABy/qLZIREXYde59jgld8VbpfHtzXeMxtsPQN/PDQ3wsjvJZhcLhXHld
        if0UekomwvjYkYBju2NWhmeRew==
X-Google-Smtp-Source: APBJJlE4g/QxkkNcPkq5XGfDtMFOGuI1W8qHwNsMr4YidpB8nT+vJcn+uCpQv4l+jguaoqHYqH0UeA==
X-Received: by 2002:a7b:cc88:0:b0:3fe:1d13:4663 with SMTP id p8-20020a7bcc88000000b003fe1d134663mr6818673wma.1.1691055672966;
        Thu, 03 Aug 2023 02:41:12 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm13294994wmq.1.2023.08.03.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:41:12 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 03 Aug 2023 11:40:59 +0200
Subject: [PATCH v4 7/7] arm64: dts: mediatek: add iommu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v4-7-84798657c410@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9vmrSAYQ/OJGejgymOj9rq18l0jyb8olHnhsKnJiPYw=;
 b=owEBbAKT/ZANAwAKAStGSZ1+MdRFAcsmYgBky3YuJx6x4dzDhkJEC8For4LCR2hLUkAQ+++WgYvK
 LGwc6IyJAjIEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMt2LgAKCRArRkmdfjHURedSD/
 i0CM6VH7TYVqNFUOU3Vvvj9lj3yLia/HYD5uuz2nC0zGYQeLx0mOPVnS7DEF8TBRwRXc8PLyiuWeIk
 faqvsYAXVImDAominB2/0DREyXWQ8YIBcnKzi92enu/y+pwFo/aS4WblRnwc4TzN4cFjFeS4/4O6gW
 89KNusCnwqg20iHE/bTxOjaAHz598/azpJ/eawPEydC+Wd7GUudVnkXiIbsQzvYJ83I8UHMXH8kZQi
 pKg4StMsGHCS3mewVMRZCtmgB2tGmMwo/X87RD77II0ZVIV7I1OI6amUzBSNXB/nJHsMvIEYiapECo
 bxLrIHWMT2V9KcSxkgdp81B+ZbIRkro1vN2+M6fS5LTJMNAAd5YiIRyTxAWJ4Af5A986e6roNmUN3Y
 Om8RsQmDHwgKAQoDhsphdgKucuhPDEx897OX0Uk7SNgW/1qlGVM6nyBoi8kDGtyzBJZVACdT9vr01j
 Ijjc21Jm+h0tOits72Ao7oYZxXIdRL370X3vEn4yGPkTxK0lsei/mlY1DL7tQb1jMfCPSW+WLL1JcY
 gYvGxfzhdkyGXi2K59ZcwqOSYPg8N8SjTxg2HUgNd8c175WRL9tn9rZrY/c7K2ifAZCfJ2ZyVAB4M0
 GNhxXJc3aVW+DycPFeL+AUfJvCrUMNclqlF24ClQJ6VRXjvTy096lXvt8W
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

