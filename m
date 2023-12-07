Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A34808AAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjLGOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjLGOdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:33:15 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93620121;
        Thu,  7 Dec 2023 06:33:15 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B76LrHD016498;
        Thu, 7 Dec 2023 06:32:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=83cT9X0WoCPXDQdO0m3fkmTFu3FaXI0/hx3jIvTEUZs=;
 b=J+vK8ES4SPIYveko9YIZp5euL8d1sLhiol7MoAQK1ErRY94cQiha+SY9pisfEURaqCIF
 +uDjCCF4T+1WWtQ836rCbl1ozmc4DGqOLCrrcHuj8POge1FhC1VZdQyX2iIwvEqShspx
 t38qAu+Xne7/aNmsxIBDy7UJSU8mSkitmm3m09Nj5Pwpoqp34ppi014HY2M6H7tZZON0
 PgyhVS8oZrCevE8tk99M+NWmLXG1HFpVh1YslnnGkbQUx4Amkaz2ZjibY1jF+EJ2YVCI
 3UjbDpw6QyXgM+bcaH4yCe+7ci0hglIMBHk9D19S7GPQkzKA1191oIQbfCvRFAtgiyv/ Yg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uu8qe9jfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 06:32:58 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 06:32:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 06:32:57 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 0C4763F7051;
        Thu,  7 Dec 2023 06:32:53 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v7 0/3] arm64: dts: cn913x: add COM Express boards
Date:   Thu, 7 Dec 2023 16:32:45 +0200
Message-ID: <20231207143248.2439926-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gPKCn1kOMn8dsNtTUaNJvwDeHljikPEL
X-Proofpoint-ORIG-GUID: gPKCn1kOMn8dsNtTUaNJvwDeHljikPEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add support for CN9130 and CN9131 COM Express Type 7 CPU
module boards by Marvell.
Add device tree bindings for this board.
Define these COM Express CPU modules as dtsi, and
provide a dtsi file for a carrier board (Marvell AC5X RD
COM Express type 7 carrier board).
This Carrier board only utilizes the PCIe link, hence no
special device / driver support is provided by this dtsi file.
Finally, add dts file for the combined carrier and CPU module.

v7:
   1) update MAINTAINERS file to contain all marvell arm64
      dts file in one line, covering all files
   2) Add Documentation to carrier dtsi and combined carrier
      and CPU module dts, explaining the configuration and
      modes of operations of the carrier and the combined
      system.

v6:
   1) Add cn9130 COM Express system

   2) Drop with from compatibility name of COM Express system

   3) Fix indentation issues of dt bindings

v5:

   1) List only carrier compatibility on carrier dtsi

   2) Fix dt_bindings_check warnings using latest yamllint/dtschema

   3) Fix subject lines to remove unnecessary wordings.

   4) Remove dt bindings for standalone CPU modules

   5) Move CN913x dt bindings to A7K dt bindings file

   6) Fix dtbs_check warnings for dtb and bindings,
      using latest yamllint/dtschema.

   7) Move memory definition to main dts file, as memory
      is socket based.

v4:
   1) reorder patches - dt bindings before dts/dtsi files

   2) correct description in dt bindings

   3) separate dt bindings for CPU module, carrier and combination

   4) make carrier board dts into dtsi, make dts for combination of
      carrier and CPU module

   5) correct compatibility strings and file names to use dashes
      instead of underscores

v3:
   1) Remove acronym which creates warnings for checkpatch.pl

   2) Correct compatibility string for ac5x rd board

   3) Add above compatibility string to dt bindings

   4) update MAINTAINERS file with ac5 series dts files

   5) remove memory property from carrier dts

   6) add comment explaining that OOB RGMII ethernet port
      connector and PHY are both on CPU module

v2:
   1) add compatibility string for the board

   2) remove unneeded hard-coded PHY LED blinking mode initialization

   3) Split the CPU portion of the carrier board to 
      dtsi files, and define a dts file for the AC5X RD
      carrier board.

Elad Nachman (3):
  MAINTAINERS: add ac5 to list of maintained Marvell dts files
  dt-bindings: arm64: add Marvell COM Express boards
  arm64: dts: cn913x: add device trees for COM Express boards

 .../bindings/arm/marvell/armada-7k-8k.yaml    |  24 ++++
 MAINTAINERS                                   |   3 +-
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../dts/marvell/ac5x-rd-carrier-cn9131.dts    |  44 +++++++
 .../boot/dts/marvell/ac5x-rd-carrier.dtsi     |  34 ++++++
 .../dts/marvell/cn9130-db-comexpress.dtsi     |  96 ++++++++++++++++
 .../dts/marvell/cn9131-db-comexpress.dtsi     | 108 ++++++++++++++++++
 7 files changed, 308 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi

-- 
2.25.1

