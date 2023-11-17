Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2C7EEEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjKQJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345754AbjKQJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:30:08 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F082D55;
        Fri, 17 Nov 2023 01:30:03 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH9TWDB011177;
        Fri, 17 Nov 2023 03:29:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700213372;
        bh=8AY1Zj2fDh+MvTGvo5m3oqX+4w3vXGLhL0h02wTVRPo=;
        h=From:Subject:Date:To:CC;
        b=bqhtWhg/a1vyWGmT6iG03CiIZe9c6MKFu+x8I1WcK+QGeyxMKmb1qLGBOjvwDQ6TK
         nvF+PskNL0i0a71awX4TFDdPhtVelPOFltDKFQUEbPlGIefehdw13R3Qmj6qiNP30v
         7Wk0ETbrVnVmnVf7wicgXPJTFnbWqITtPxm2Hlgg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH9TW9A023814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 03:29:32 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 03:29:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 03:29:31 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH9TV2x000416;
        Fri, 17 Nov 2023 03:29:31 -0600
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v2 0/9] arm64: dts: ti: Enable CSI cameras for AM62 family
Date:   Fri, 17 Nov 2023 14:58:08 +0530
Message-ID: <20231117-csi_dts-v2-0-bf4312194a6b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkyV2UC/z3MQQrCMBCF4auUWRtpkqZQV96jFEmTiZ2FjWRCU
 Urubizo8n88vh0YEyHDpdkh4UZMca2hTg24xa53FORrg2qVllJ2wjHdfGZhQqe1dVb3vYH6fiY
 M9Dqkcaq9EOeY3ge8ye/6M8zf2KRoxTAEZ7SZ1ezxmuns4gOmUsoHnh0nhZsAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=5rJSVTpPkU1Yl+21VLiJPuQ+ThVzlJaMtsvyE3RSoHU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlVzJrT6fPIBmvgT8kjhynkbXmLZEbZKUlQhRlp
 X1FaizsHcmJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZVcyawAKCRBD3pH5JJpx
 RWQcD/43cZDvDKNUF+Wjou83dNT7Cyk4jrL/YOpcdyAXhEYNGF6KlUR9HLkdwO67yrFdCvC1EPJ
 RPboizqAFFIsEUHUBRqVoLangqYI56W6UnW6dqDwj1QeWfpuEgSgoWTuEB2aaoOuW1tftyUwkOe
 OO2NtM5PjDtEzmrmg83ZMSeemsaCd0r+8xSxB9CApGXrg2NuIw283aeVuHTtTCgNKSbx+va+KvM
 WZv8Pe4cpaT6xqXCSPsrFOpw8pba3/lg9GY6yK2YCO83e7zCMbQzrluxM34OB6DSzLOICuPXAEV
 rd+5f+YiVhr6V7niPENxFTSGbkBjUKC94CQ6Wu0dJCQbh38wrAQTyyQNXkcKZMTPfqlW9DG5Nq1
 PY8r5222NX1vo7eXKLHZhoNNe9DGKNPFx22uHyCoCeQYbM9F2ybQWfcmKJQqdDuoPpp9ZN3l8BW
 9LkJEFhrfwAjxOaj0q6D1rgpOjWNtMK0wUk9WfIfbgynMOYWzoIuiCR3eWvETDN5EUu+laoI9rH
 5u9PF/TGLEi5R4SsoeMCY+NHxsp1DxOYFt4I5Vxk1WmUmB4e5gQ6T0rN28X50fb/IkZHADwJ+JX
 TN+w1JhiYXrY33OfUWk2HVwGagRvYzz5vAeILCMVxvvwXyGNXu4YOHE24sU2zLf9sKxAKzUwWXY
 OZMWe9CBbaB3KQw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables CSI camera support on BeaglePlay, SK-AM62 and
SK-AM62A, now that the dt-bindings and driver support for CSI-RX related
IPs is merged in v6.7-rc1.

Along with the device tree nodes for CSI-RX, add new DT overlays for
different camera modules like RPiv2 (IMX219) or PCam5C (OV5640).

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v2:
- Follow Andrew's comments to avoid creating combined DTBs with overlays
  applied, instead adding them with "dtb- +=" to optionally test that
  they apply cleanly with OF_ALL_DTBS=y config.
- [New Patch] Cleanup existing combined DTBs to also do the same as above
- Pick Martyn's Tested-By tag for SK-AM62
- Link to v1: https://lore.kernel.org/r/20231115-csi_dts-v1-0-99fc535b2bde@ti.com

---
Jai Luthra (9):
      arm64: defconfig: Enable AM62 CSI2RX
      arm64: dts: ti: Enable CSI-RX on AM62
      arm64: dts: ti: Enable CSI-RX on AM62A
      arm64: dts: ti: k3-am625-beagleplay: Add overlays for OV5640
      arm64: dts: ti: k3-am62x-sk: Enable camera peripherals
      arm64: dts: ti: k3-am62x: Add overlays for OV5640
      arm64: dts: ti: k3-am62a7-sk: Enable camera peripherals
      arm64: dts: ti: k3-am62x: Add overlay for IMX219
      arm64: dts: ti: Use OF_ALL_DTBS for combined blobs

 arch/arm64/boot/dts/ti/Makefile                    | 60 ++++++++++---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           | 62 ++++++++++++++
 .../dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso    | 77 +++++++++++++++++
 .../ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso   | 77 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          | 99 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            | 35 ++++++++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     | 15 ++++
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso | 76 +++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso | 74 ++++++++++++++++
 .../boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso  | 74 ++++++++++++++++
 arch/arm64/configs/defconfig                       |  3 +
 11 files changed, 640 insertions(+), 12 deletions(-)
---
base-commit: 569293c4ad62826ba18e1e8371ce9667a5529efb
change-id: 20231114-csi_dts-5f433aca3665

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

