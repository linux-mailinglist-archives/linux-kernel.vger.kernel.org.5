Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1941C7FB6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjK1KKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjK1KKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:10:36 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94FF10A;
        Tue, 28 Nov 2023 02:10:42 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASAAVAr120134;
        Tue, 28 Nov 2023 04:10:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701166231;
        bh=tm0UDT69bL/5esGVd0d3xwKLdjQ2FPR5EG/pDnLBVgg=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Uh0WXSLCkIv+on504OqL/LGM5gqGuBc7H8XThukxLSoNIPjWvle8wPo3gst4vSoaq
         J8W1w/eRvwmQ35BQHZlwYdy0W6hON8yk0H533iTK45NOq7ttTm+Rv8TAVwpmcKKybB
         9s9p6mRtJl2mpcd78c+bbnwnPYPhtu8EGXRNmGok=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASAAVkS070656
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Nov 2023 04:10:31 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 04:10:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 04:10:30 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASAAT7U125418;
        Tue, 28 Nov 2023 04:10:30 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Nov 2023 15:39:47 +0530
Subject: [PATCH v3 5/9] arm64: dts: ti: k3-am62x-sk: Enable camera
 peripherals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231128-csi_dts-v3-5-0bb11cfa9d43@ti.com>
References: <20231128-csi_dts-v3-0-0bb11cfa9d43@ti.com>
In-Reply-To: <20231128-csi_dts-v3-0-0bb11cfa9d43@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=glJ8V1sz9XMUeqlM6p2gMwJEQJqQRMwL+OUstDqPAlM=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlZbyCEonbjLCaLNUYg9a6aXIrW2pk47wtu8XTl
 G2W3fU8fQSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZWW8ggAKCRBD3pH5JJpx
 RcLlEACJNKm571X69Z6SBVRWBnzbusRJ74dK8gPJqI9t1uFRC74ZN3oFeTAYlXiO4PYFlZ5EjZO
 cI7xiDzRjwVmfKIxjfzKn4IvnQyzOSD8BM8lyK5az3qJawms11Hk1NGj9J0nGrNEtmzo3RCNwtD
 j4ra3oe38CRCqBtUqJ9GWqZSWgmRWPVhtqyZYrY4Rh5wLOe27MPevFW8Nte28Rt5ysTOD18wmfe
 O9DD6FAOq5BhLikOaJUX3TwwW4Frw0+Q859g6upzB2QWAETOy5Fw5vgzD2dNJLv74PJWv9R2U4L
 OPnIPmnAYMHb5rqfQVEBq2lj6hZ2c5mgGxxEUFKN/C+iqC6TDXrmBQ4jpksUGrQvrofLzssNRc3
 v86vWgJUNIneupQHa1p0sXBq4ASu9HwNlwagTtukwUd5lJnuIfCUBxrhbcrLItzOt1PT71Ac0XW
 372lfEJcz4yqRX2DCmiAg/9ppYEyaABeUwI1cWljoSx5iNWWhFJgbVwIZK2gFceSUkyi8Mul372
 oYL52IBgwBTlHp07hK0OtjjVLjatTj5GtneNfxxjvgaEiJth+YMGLSWnk7V3Hx0bH5lLY4e1Eyd
 zMevxkZ+4LNh8lllmJ5bD9EO0sndER32Z/l4dbCubO2oVXNQP7JK4c9vNnaxRQ0hSCGiZDhJfpP
 66L9sTWp8SdfmwQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CSI cameras are controlled using I2C, on SK-AM62 and derivative boards
this is routed to I2C-2, so enable that bus.

Specific sensor connected to this bus will be described in the DT
overlay for each sensor.

Tested-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 19f57ead4ebd..5bbc7e24b548 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -399,6 +399,13 @@ sii9022_out: endpoint {
 	};
 };
 
+&main_i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &sdhci0 {
 	bootph-all;
 	status = "okay";

-- 
2.42.1

