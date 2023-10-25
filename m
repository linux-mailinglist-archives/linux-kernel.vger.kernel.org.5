Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6552B7D62CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjJYHbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjJYHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:31:20 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DFD5C;
        Wed, 25 Oct 2023 00:31:12 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P4ABqh023029;
        Wed, 25 Oct 2023 00:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=0ZfGdwRUHbucisYnUDz5UO8MTwwmmWOJWbiCA2W4CqQ=;
 b=TwEMY6PXz/Z+5E/WCLHU0jhPhgJOkzvdIGj0LuVkvzW2ypswIwFNtqr8baZgrWhYzGmq
 BnH4fkNrEFcrINaipANtWo2zjiA+JaD+PI3/jo0WKfCWrfQ7/8+uQD2+pW86qJ6q2QX6
 /xQXvTCfZqYu9odwmUqOi9658cOLeeXAa54gSBf/JdAUSJ3ltfqzqjVaCu+ztZi4rv4F
 g+pMnroM+6jga2ua5L/DGEHMv4aTmbsy8f79xC04MYYOBYDVcHgC90VykU6IpAH6TvvA
 OUvPZACjNgMcHa4ZKGF13B/FcE7hmqDD5xJcC3nR4kescHHfn/Sa4Jf48bSeB2ropl/w zA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3txcsqv1s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 00:31:01 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 25 Oct
 2023 00:30:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 25 Oct 2023 00:30:59 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 0C4F83F7053;
        Wed, 25 Oct 2023 00:30:55 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>
Subject: [PATCH v2 0/1] arm64: dts: cn913x: add device trees for COM Express boards
Date:   Wed, 25 Oct 2023 10:30:31 +0300
Message-ID: <20231025073032.2824877-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 478sOiMvVwBpGDDpyDBrwoJC2n1YFqIs
X-Proofpoint-GUID: 478sOiMvVwBpGDDpyDBrwoJC2n1YFqIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
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
module boards (SOM boards) by Marvell.
Define these COM Express CPU modules / SOMs as dtsi, and
provide a dts file for a carrier board (Marvell AC5X RD
COM Express type 7 carrier board).
This Carrier board only utilizes the PCIe link, hence no
special device / driver support is provided by this dts file.

v2:
   1) add compatibility string for the boards

   2) remove un-needed hard-coded PHY LED blinking mode initialization

   3) Split the SOM / CPU portion of the carrier board to
      dtsi files, and define a dts file for the AC5X RD
      carrier board.

Elad Nachman (1):
  arm64: dts: cn913x: add device trees for COM Express boards

 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/ac5x_rd_carrier.dts      |  23 ++++
 .../dts/marvell/cn9130-db-comexpress.dtsi     | 101 ++++++++++++++++
 .../dts/marvell/cn9131-db-comexpress.dtsi     | 113 ++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x_rd_carrier.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi

-- 
2.25.1

