Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785B7EEEA3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjKQJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345753AbjKQJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:30:08 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420CFD75;
        Fri, 17 Nov 2023 01:30:03 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH9Tdll058796;
        Fri, 17 Nov 2023 03:29:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700213379;
        bh=nHfkSgbbam9tsZlg9KrpyEnoI2oaToGB9A+3LMjzCQA=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=nXXwS0hv4syd/ZfIHd0rAwJjQpZszl3LnlVQqD8SSn2tRaDrSNCdSdWJQofIK7iAV
         d4u0KWizmNBBjh1CIjh8MxVYhln9YPdOawlt1vdGW6IMYQhzsF28oSAlgNm0iw8cZQ
         3j6uCDJcdlQzh9VGzYBEq5iY0EJvDMO10TPNiKdw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH9TdjJ023858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 03:29:39 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 03:29:39 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 03:29:39 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH9Tc0o105788;
        Fri, 17 Nov 2023 03:29:39 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Fri, 17 Nov 2023 14:58:13 +0530
Subject: [PATCH v2 5/9] arm64: dts: ti: k3-am62x-sk: Enable camera
 peripherals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231117-csi_dts-v2-5-bf4312194a6b@ti.com>
References: <20231117-csi_dts-v2-0-bf4312194a6b@ti.com>
In-Reply-To: <20231117-csi_dts-v2-0-bf4312194a6b@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=DWMd8DynE4oPJWbT7wW32YZODLtvs3BBy7dXHnEQO7M=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlVzJwMN9aaDkLxk93s/Y7CE61rBPS//0Yv8s3e
 f5Vzj3285uJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZVcycAAKCRBD3pH5JJpx
 RfMDD/9UveCssc6gFNkrfHKeZAeO58MI3paCrNEto7yxFWtICqnUkMkKtzH2QUZVKM2QMFK3qaM
 tp14RzXBaCdqYZkotffN0ujyEhv/PB3hzlSoWkk4/TfOuDmzU7xye+eZDz5A0DOeq5AKy9+H4xC
 V07+fQVahn9x15ntDFlTyGdsFz8CIuu2c2YA7JsOSSGyWLz4NiQPxvfHs6pyOnpwU8ezPND7Ym8
 lFqKA9XTY3ZRo/lkcrT4X3eK9y7Wb6m8hpvsi8TNPy9neaEeWhF3LeY5Y27VYpJ23HZiKTLe9Y+
 aZxNfUvSkZ1UhixpQ5mUzSqYzqBTUxdUPMrUtw82WI9Sq0uacKOHD9zdiidC7HyHTscaXSRkU2A
 uFb3MNxfoQUOP+5JogtWpf26GM8e7mdxvxgL/nzL0WL/92V4k2qc0G3dP9EtQOB/1GqPMiG4uYR
 NNC/yPFXVsBmK6vl2KFNyd/z0NEeJtDLYF/NWDPyDyFm5UGhjmj+0qhSgYpPWk+9OZrakgrPa5o
 O3djxHdqw+crkgxIdkoUQi0Xmd66uxi6PQJPgsIiRIalSIBcEawbNsY+gc8hcDeppXw5e4njBEk
 G917ZGLT28o0v9UBXNntLdMbpu1UGy1qewQeTdz/73WRCZTUG2y/vYnDsy6xGGh2JTBLPRXqPxL
 DH81Ky/fV9N6vdA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CSI cameras are controlled using I2C, on SK-AM62 and derivative boards
this is routed to I2C-2, so enable that bus. Also enable the nodes for
CSI-RX and DPHY-RX IPs.

Specific sensor connected to this bus will be described in the DT
overlay for each sensor.

Tested-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 19f57ead4ebd..21658f811307 100644
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
@@ -517,3 +524,11 @@ dpi1_out: endpoint {
 		};
 	};
 };
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&dphy0 {
+	status = "okay";
+};

-- 
2.42.1

