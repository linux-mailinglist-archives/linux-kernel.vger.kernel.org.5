Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1447B6790
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbjJCLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbjJCLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:14:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59CAF;
        Tue,  3 Oct 2023 04:13:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 204196607328;
        Tue,  3 Oct 2023 12:13:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696331637;
        bh=FvSi3BSwzuy5WbsL2UYcyLOhw7c/SDxzR3WOj7ZEBrg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QfGay9YjZBSiEdEo2C8XiZnfHw9DmvvyRvqzvqIAdIhB6YirsTKyMaY9cD5NANA9H
         7RuW7xOY4kUs1iksNfpQullJg0oGbdYocdtZXoAP1LqOO8J3gHHmg4zOmI1jcraAdV
         z/oXOm+83hEguOAyElTDFcUnBob6APkhAjjvpvb+FHmBFWLOm8qJDhEgFKd+D1tzzy
         ofw/8YwhQJXl7eokusuTrEyvq/y4zVYS9F68O64bNDikSpOBWchY8mKaTJ0vg9a21N
         0zn+o49BwZx+g8DGl3nQE8LlSe0iuC/WATrKGI/kLE1WASGpFsHj0Nc3e6wIdBPp/5
         +Gifj5NeDaCCw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Tue, 03 Oct 2023 13:13:46 +0200
Subject: [PATCH 4/5] arm64: dts: mediatek: fix t-phy unit name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-mediatek-fixes-v6-7-v1-4-dad7cd62a8ff@collabora.com>
References: <20231003-mediatek-fixes-v6-7-v1-0-dad7cd62a8ff@collabora.com>
In-Reply-To: <20231003-mediatek-fixes-v6-7-v1-0-dad7cd62a8ff@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jieyy Yang <jieyy.yang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Eugen Hristev <eugen.hristev@collabora.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934;
 i=angelogioacchino.delregno@collabora.com; h=from:subject:message-id;
 bh=USC6QZCCqTLO2M1u4nBUCKN+Ny3rpy5drCaAShL4ZgE=;
 b=owGbwMvMwCU2y4zl/NrpLRWMp9WSGFKlv+c/sCjWTUr0qDf89Cz97rdNdu8v7G7U2qjGuuh2X7X3
 +566jlIWBjEuBlkxRRb1uzXZz9esZDzSfrYEZg4rE8gQBi5OAZjIAW6Gf/qisTLXJhpvWH3P7XXHj+
 fPwiMF4zzWT+YSW7gxdU5ZkwrD/wCppheShevm/9HRZPDUK+n7fHCPt1DDyZktinW3PrHysAAA
X-Developer-Key: i=angelogioacchino.delregno@collabora.com; a=openpgp;
 fpr=57152E620CAF29C5DBE574766833ABB5BEBAF7B7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@collabora.com>

dtbs_check throws a warning at t-phy nodes:
Warning (unit_address_vs_reg): /t-phy@1a243000: node has a unit name, but no reg or ranges property
Warning (unit_address_vs_reg): /soc/t-phy@11c00000: node has a unit name, but no reg or ranges property

The ranges is empty thus removing the `@1a243000`, `@11c00000` from
the node name.

Fixes: 6029cae696c8 ("arm64: dts: mediatek: mt7622: harmonize node names and compatibles")
Fixes: 918aed7abd2d ("arm64: dts: mt7986: add pcie related device nodes")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230814093931.9298-2-eugen.hristev@collabora.com
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi  | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 36ef2dbe8add..3ee9266fa8e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -905,7 +905,7 @@ sata: sata@1a200000 {
 		status = "disabled";
 	};
 
-	sata_phy: t-phy@1a243000 {
+	sata_phy: t-phy {
 		compatible = "mediatek,mt7622-tphy",
 			     "mediatek,generic-tphy-v1";
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 68539ea788df..24eda00e320d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -434,7 +434,7 @@ pcie_intc: interrupt-controller {
 			};
 		};
 
-		pcie_phy: t-phy@11c00000 {
+		pcie_phy: t-phy {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
 			#address-cells = <2>;

-- 
2.42.0

