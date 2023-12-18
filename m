Return-Path: <linux-kernel+bounces-3974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E73817642
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33421C253CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777935A846;
	Mon, 18 Dec 2023 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HERX6Iey"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FB495DE;
	Mon, 18 Dec 2023 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIFAI1A011936;
	Mon, 18 Dec 2023 07:44:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=853J4cZx
	NdcWTRitkB9n1oPkQmJjhMNR4rmYGkU2xBI=; b=HERX6IeyXAolkY0DlpICNmn3
	mq/IkxPX8HVPZOsGsFLlqPPTUE/yqk2T1x2r7dsraE+oRE/Q6Endp5oTFGYCwrHa
	LJCLUCZXDYGUm9SOp6GGMJMG3bJwg4688UwT+xWAGGU+XJO5EeGmZry57ZekhzCw
	VzBhtmL8ueD0UwUXgB7eLtCnfmDwgVLLGNyuYquADgbFwe2oKV3n26JyPwbGyXxy
	O95k5Q8+p3jTO2elt7xsYA44FsBAnl9TE1PhlYn4ag8Nax7vEcS0rCVa/x6hwFQ6
	3FD7Wk6ajScZZ8WJo/+CaICAodKdCvd4i1D7TWrRtEceuS81QeQy1J9/tUPgZg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v2rg5842q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:44:46 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Dec
 2023 07:44:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 18 Dec 2023 07:44:44 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 45CE93F704C;
	Mon, 18 Dec 2023 07:44:41 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <pali@kernel.org>,
        <mrkiko.rs@gmail.com>, <chris.packham@alliedtelesis.co.nz>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 0/2] arm64: dts: a7k: add COM Express boards
Date: Mon, 18 Dec 2023 17:44:29 +0200
Message-ID: <20231218154431.3789032-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9jWulKtpFZjAOKS2LA8WSaCcb9_vlXZm
X-Proofpoint-GUID: 9jWulKtpFZjAOKS2LA8WSaCcb9_vlXZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add support for Armada 7020 Express Type 7 CPU module board by Marvell.
Add device tree bindings for this board.
Define this COM Express CPU module as dtsi and provide a dtsi file for
the carrier board (Marvell DB-98CX85x0 COM Express type 7 carrier board).

Since memory is soldered on CPU module, memory node is on CPU module
dtsi file.

This Carrier board only utilizes the PCIe link, hence no special device
or driver support is provided by this dtsi file.
Devise a dts file for the combined com express carrier and CPU module.

The Aramda 7020 CPU COM Express board offers the following features:

1.  Armada 7020 CPU, with dual ARM A72 cores
2.  DDR4 memory, 8GB, on board soldered
3.  1Gbit Out of Band Ethernet via RGMII to PHY and RJ45 connector,
    all are present on A7K CPU module (none on the carrier)
4.  Optional 10G KR Ethernet going via the COM Express type 7 connector
5.  On-board 8 Gbit, 8-bit bus width NAND flash
6.  On-board 512 Mbit SPI flash
7.  PCIe Root Complex, 4 lanes PCIe gen3 connectivity, going via the
    COM Express type 7 connector
8.  m.2 SATA connector
9.  Micro-SD card connector
10. USB 2.0 via COM Express type 7 connector
11. Two i2c interfaces - one to the CPU module, and one to the
    carrier board via the COM Express type 7 connector
12. UART (mini USB connector by virtue of FT2232D UART to USB
    converter, connected to the Armada 7020 UART0)

Elad Nachman (2):
  dt-bindings: arm64: add Marvell 7k COMe boards
  arm64: dts: a7k: add COM Express boards

 .../bindings/arm/marvell/armada-7k-8k.yaml    |  11 ++
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../dts/marvell/armada-7020-comexpress.dtsi   | 161 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi  |   7 +
 .../boot/dts/marvell/armada-ap806-dual.dtsi   |   4 +-
 .../dts/marvell/db-falcon-carrier-a7k.dts     |  27 +++
 .../boot/dts/marvell/db-falcon-carrier.dtsi   |  22 +++
 7 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7020-comexpress.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/db-falcon-carrier-a7k.dts
 create mode 100644 arch/arm64/boot/dts/marvell/db-falcon-carrier.dtsi

-- 
2.25.1


