Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37AC7BF1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441973AbjJJD7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442080AbjJJD7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:59:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95B92
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:59:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39A3x5TT053741;
        Mon, 9 Oct 2023 22:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696910345;
        bh=psexWA7X2IA6hATucSDe14gmAloYmPI+DZMD0JK+WZs=;
        h=From:To:CC:Subject:Date;
        b=RLSc3PIxIJXYCVcH98fSdf2G+dt3OF7RzLHt1jUzbP7uHBRngMrS5OiDWg47YwoMv
         VOiyZwU2YmmEuQww7HBoMhWPR9Htm/Ls/esDy/r0eXGVWaVoW3wdjjtpd26LfOz0E6
         0STwGZG/fKRNmjHYT4DzLa0hej/qgaHZOk7+5j4Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39A3x5rc074532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 22:59:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 22:59:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 22:59:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39A3x5ZF050572;
        Mon, 9 Oct 2023 22:59:05 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: enable more peripherals
Date:   Mon, 9 Oct 2023 22:59:04 -0500
Message-ID: <20231010035903.520635-4-bb@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=bb@ti.com; h=from:subject; bh=M2Qmfj1rWtQraX9t8lF903XeqmX/JIsTqE68cvcRCLo=; b=owNCWmg5MUFZJlNZhStZ8QAAY3////fN9+X7iln390r39zRPfTk3fexXnv//3/zf7JHo/9+wA RrKh2hA0AANAAAGg00eoBoDTTQ0A0BoNA00BoGmQGjQHqBoGjTRo0aPRNNNP1M1QygGg0NAGQAy ADJo0aMmjRtIZNBp6ahoBkBpiaMgAAaMjJiaaAZHonpMmQAIZGmhkDTTQBk0GJoNBoYTJoA00ZG QNGRkMTIxBiDBNBoAyYTRpiAyDQaGgBAjQVpeg1qJiDDC8WW7RESsqTQ4Jh2F/RWI8NNT83GWkR mq6wGgLCL8j35B8EAvoqVXCJAi3leuh5LzcRTnw6IHLqTJ3sSlB/Qk3qy6xakVnRu6e18Es1XIk FyGzMIkLii22vFQFKNL+cqcKoGdSH9i8uYK6YN87UT/vf+ujni6vIPMPQaxerfk2bI2VoVho2AO TE2Cmtq37Jos79SeSJ1UZkjGy3rPBnu4MTwrugbA8cUEKL8sMLkSoWjHv8j3Uyt9P1KMOO/+U/O xXtDjcFxF4ohbJ8Y9UzW/0mo+CqfdHnWHsDt7FqNVmsXW/i8GCURjmwL5qmslNrkPXHi7BQS4gf SiND5EQB95gICPsFAbOPsG4ZmJjD8WORpCtQCQR8bAAYC4bKA8rJugGvgXUq6E9Y/vhuSBGwSM9 CYRbxkk8fWGg/4u5IpwoSEKVrPi
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables most of the similar peripherals already enabled for
the am62xxx extended family of TI's K3 devices for the am62p SoC and the
am62p5 starter kit board

Vignesh Raghavendra (2):
  arm64: dts: ti: k3-am62p: Add nodes for more IPs
  arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi    | 835 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi     | 191 +++++
 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi |  47 ++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi  |  67 ++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi         |   2 +
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts      | 572 ++++++++++++-
 6 files changed, 1703 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi


base-commit: 69c570ebc3964534c19dc4438d3b96f55d489fc3
-- 
2.42.0

