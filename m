Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E207DAD8E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjJ2Rsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJ2Rso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:48:44 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932F1D6;
        Sun, 29 Oct 2023 10:48:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39TDN70f028070;
        Sun, 29 Oct 2023 10:48:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=OP3kArmtoHp5EYUi2p8ZdBSr7Ca6MjehGwqB3ZEv7/c=;
 b=g5B4FF08QSEoffQPj+1xJLoND9uaOxU+Lla37hn/ZUDUb0LLfkYObCyZkf/0yKCyHdyZ
 WBZy2aWXOXIoN7JtEhb8hIW8isxuY/fmapSkAHLp+8d1zGjpZ8b9VlJjXJ9VPFeFVC6M
 anJ2r19rZ8p8Mz2udmBkuRTMaUWajmMLJnG+x+WzTbtQdpDgryWteY8h7iTPeBIeSffJ
 FccZgyoZ8rpIvWozcxdw+Sver3qtxqHUIy0rXKK2MG+RHW+/E7Q7Xkwsh+7ddjZg5TfX
 Rf7KxVoZXj+9b6Jj6MYZerPJmmlleNu/4OTN93syUOKP53PyY+nY+k30bWC98GU76fQj Fw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3u11tp3aq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 29 Oct 2023 10:48:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Oct
 2023 10:48:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 29 Oct 2023 10:48:20 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id E56A33F70CE;
        Sun, 29 Oct 2023 10:48:16 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v4 0/3] arm64: dts: cn913x: add COM Express boards
Date:   Sun, 29 Oct 2023 19:48:11 +0200
Message-ID: <20231029174814.559583-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eZguKLyAA5cOItN7CdpTm3qnZExYVfj2
X-Proofpoint-ORIG-GUID: eZguKLyAA5cOItN7CdpTm3qnZExYVfj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-29_06,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add support for CN9130 and CN9131 COM Express Type 7 CPU
module boards by Marvell.
Define these COM Express CPU modules as dtsi, and
provide a dtsi file for a carrier board (Marvell AC5X RD
COM Express type 7 carrier board).
This Carrier board only utilizes the PCIe link, hence no
special device / driver support is provided by this dtsi file.
Finally, add dts file for the combined carrier and CPU module.

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
  dt-bindings: arm64: dts: add dt-bindings for Marvell COM Express
    boards
  arm64: dts: cn913x: add device trees for COM Express boards

 .../bindings/arm/marvell/armada-7k-8k.yaml    |  15 +++
 .../bindings/arm/marvell/marvell,ac5.yaml     |  14 +++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../marvell/ac5x-rd-carrier-with-cn9131.dts   |  19 +++
 .../boot/dts/marvell/ac5x-rd-carrier.dtsi     |  18 +++
 .../dts/marvell/cn9130-db-comexpress.dtsi     | 101 ++++++++++++++++
 .../dts/marvell/cn9131-db-comexpress.dtsi     | 113 ++++++++++++++++++
 8 files changed, 282 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier-with-cn9131.dts
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi

-- 
2.25.1

