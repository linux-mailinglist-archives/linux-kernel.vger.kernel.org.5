Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E8A76E4B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjHCJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHCJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:41:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342E12102
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:41:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so10679221fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691055665; x=1691660465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wErjPQt6qENv87TZs9KiIyjig4b2yslS27coAwsNZVw=;
        b=QGFti+HY+QQe5LC3G/0lDrQ2VYSb5KoZKX8ZnH/pO4R1TpWJktXHTYQlaakPyF95cr
         PUhlo33Ig0P1ifERPRzNLBs57wEdxYiT8cuUrdOHuVGteASQ3hXq64p5cAiJiMd6ZP5Y
         JIGa5Fpo8tjngO6Up/6RJuwUe5/M1b+vDNMHODiq9q8tnL+3HbulfRxuHKc4h6Csw46r
         oVajZqpexvPC6TPZhoudyEdHDa+5AyCqf3XP9e3/raAI0hrS7sCxNm5SRSryT4bg8zwz
         dasrGyr5La7/7UimXTsxmRmQbnAEPmH3LjYiv5LX0hdZTXe7oORH+rbZRGUwxMfBB3Ue
         yK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055665; x=1691660465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wErjPQt6qENv87TZs9KiIyjig4b2yslS27coAwsNZVw=;
        b=XnbqRlXIUK6gzyAK7do7lwbwjWqG0ejAf9qr0zQk2bjdLf/I8r6UfHOrGLMWz4PqnD
         MOjmLelw8xalrkFl3NpBsUKUNvNraPG3/nnOHp4xI44BmqF6gyzlgKMiZUP/pBzQpLXU
         80Czu9R0f51tdk0m4Ufl0hy4lCvkWgHceYj1zURyzQaeiTtmCEEI8KiCmRicmyS+1Jfl
         npAf2RCr7976QEZ5Un707Jlisj/m1lRf+LaUpxxMkd27qHK9uZwH7TWGubf9xppWzsqY
         WlpN9jV11GYWQ2MLDVyk6wlpJiMgNCS3CgFzIlFQ/WsAqTZci2843gO7LKpLvNxCTChP
         tT7g==
X-Gm-Message-State: ABy/qLbqW77U+Ros/RuyYYE3NnYfq0WzIMoI6TZ7gWRpJ9UZiNlvYmic
        VPNPIJVX8XsDSBAjwscBMwNmTQ==
X-Google-Smtp-Source: APBJJlF8OCA1c+0+v9Bwna0TzEzHiArRZ7AzDrwGj/4GdA5Tv2uF3b+DFyV6p/26okEKWfxm90Wm9g==
X-Received: by 2002:a2e:9054:0:b0:2b6:e625:ba55 with SMTP id n20-20020a2e9054000000b002b6e625ba55mr7589092ljg.41.1691055665493;
        Thu, 03 Aug 2023 02:41:05 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm13294994wmq.1.2023.08.03.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:41:04 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 03 Aug 2023 11:40:53 +0200
Subject: [PATCH v4 1/7] arm64: dts: mediatek: add mmsys support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v4-1-84798657c410@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=5Tm918SwyWroVCRT9x2Od4dOEXsJxNFB5Eps83AeIaY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBky3Yua0NFqC8gbsqFLWmjdFOfQJ8aPh736LBg8KCn
 Hd4Rrp2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMt2LgAKCRArRkmdfjHURaL8EA
 CDPSg8MJKZTsa/itx2lqm1PK1xL5MVZHgNNlU21RwE4o3/AwbNc7TY2RWknCcEgVL4REl8/AoWklXw
 BoSLVnVri56WO3ifPTIi4aP4DUZIskdoavlozIRn1cHz3ifXckHty4PZdKDHKIR5znobuVLPwsh/Nc
 wwYzrhggRlxvOlDgFQdosiPuKixHW+aNiFSoP0UcXyJ++/KNRsnDqqXt5U7be18ZAnOANk86xnLeB9
 pg7YzM6FabLesI3x0tDSGT4yihICpbDIVTeq5ZuDGEpjx4N6HWnIpApnifGZSFY+v5rGwwLI7KkfuT
 bbWzwm5ri3nmwE9gGfbB2Ksjw04rjHATbKHObKYc1+y3qrPeDcn4UB7xAkEkeQS7LK5BHxmitd6vRG
 ZV9frVipNJtLFZfh7hhA9CC3jD2a6KkwPF+6ypAbnOSZi3al6sW4WmUCXDHoV5rjRKnWRxgu7ZmA98
 W6XAnu2SNlHocF038Q8lUVXAeVSzXumId9M/02MrQE3wYG+4YKXCqQt01EzbZycI378yyFnqynua/u
 mvJsSVvccfZ9NgMnuaAyeXbAvXmWpp9BHQsC1cH2rI+lTSCbAcAALIqKFOjfGy9HlbJl9dBqgT7wcU
 5eeMoAa24/BWbIp7I3gp2bgCRdY8nOWWP6vsW0pJx0RW7yvQrY5QC8eqZvkA==
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

Multimedia subsystem (MMsys) contains multimedia controller, Multimedia
Data Path v2.0 (MDP 2.0) and Display (DISP). The multimedia controller
includes bus fabric control, Smart Memory Interface (SMI) control,
memory access second-level arbiter, and multimedia configuration. It
plays the key role in handling different handshakings between infra
subsystem, video subsystem, image subsystem and G3D subsystem.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 413496c92069..bcabc2b89a94 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -603,6 +603,12 @@ u2port1: usb-phy@1000 {
 				#phy-cells = <1>;
 			};
 		};
+
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8365-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1

