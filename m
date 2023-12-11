Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A080D388
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbjLKRSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjLKRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:18:19 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D280FF;
        Mon, 11 Dec 2023 09:18:25 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBDVP27026392;
        Mon, 11 Dec 2023 09:18:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=e2bkNe/sLQYaZUIgThv87udMHn75QjifwZDXa207jxE=; b=WMU
        bg0Psh0AkAkFxZIS6sLdoWGWUzo8FhVryWMg7Uc34+FiikfzLYi8xCUhISl8QM5P
        tXUi3hp4erqN64c+YzWyuT2zNJUqzbGai2L/6mg0MgwlF38//9o8jjPiF6bcC9pA
        i2kHQkyltQAExtKII7mNr7S/t1u1EPQlxCiQBk4DrGKYWnpGQTlpJH5arjEzdm08
        jYAo+BzT9x8VNRat53KqFW89UD8G9Ar78rP1CbdiksPR/3UfaeCBEdlv5NfH7p7+
        nw3wASJzKBUOmtNONKGY9zB5k1mlqsKm+Wo5qGJlO204PQSC+l3HT2XQdYigVdbI
        t4SeRsCe78yuQqx5NXQ==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uvrmjnfqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:18:15 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Dec
 2023 09:18:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 11 Dec 2023 09:17:52 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 56F653F709D;
        Mon, 11 Dec 2023 09:17:49 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v8 2/3] dt-bindings: arm64: add Marvell COM Express boards
Date:   Mon, 11 Dec 2023 19:17:38 +0200
Message-ID: <20231211171739.4090179-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211171739.4090179-1-enachman@marvell.com>
References: <20231211171739.4090179-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DcJGw3ju1XPQvsTZUr29iwe0hDKj5ZkW
X-Proofpoint-ORIG-GUID: DcJGw3ju1XPQvsTZUr29iwe0hDKj5ZkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add dt bindings for:
CN9130 COM Express CPU module
CN9131 COM Express CPU module
AC5X RD COM Express Type 7 carrier board.
AC5X RD COM Express board with a CN9131 COM Express Type 7 CPU module.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 .../bindings/arm/marvell/armada-7k-8k.yaml    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 52d78521e412..16d2e132d3d1 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -60,4 +60,26 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          Alleycat5X (98DX35xx) Reference Design as COM Express Carrier plus
+          Armada CN9130 COM Express CPU module
+        items:
+          - const: marvell,cn9130-ac5x-carrier
+          - const: marvell,rd-ac5x-carrier
+          - const: marvell,cn9130-cpu-module
+          - const: marvell,cn9130
+          - const: marvell,armada-ap807-quad
+          - const: marvell,armada-ap807
+
+      - description:
+          Alleycat5X (98DX35xx) Reference Design as COM Express Carrier plus
+          Armada CN9131 COM Express CPU module
+        items:
+          - const: marvell,cn9131-ac5x-carrier
+          - const: marvell,rd-ac5x-carrier
+          - const: marvell,cn9131-cpu-module
+          - const: marvell,cn9131
+          - const: marvell,armada-ap807-quad
+          - const: marvell,armada-ap807
+
 additionalProperties: true
-- 
2.25.1

