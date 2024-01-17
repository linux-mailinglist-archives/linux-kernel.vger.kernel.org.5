Return-Path: <linux-kernel+bounces-28914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76A830490
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852B52880E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE11DFC3;
	Wed, 17 Jan 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f3G/Xp+M"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B81C2BB;
	Wed, 17 Jan 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491077; cv=fail; b=a1vrlsKVuabQ074fW32obY+UdZh2qZRsLSKZEdqbiwO4Fb3SHcBo+Ffqhsqj4Amfk9eYuEMoI/bBJChoEhzu0eqRGUTHeQKsbsVsdZirA2G+f7zVqApSw4U25ZFxomeJHIc5QKlvnTqpjDYQC70nfZ9azl8CK6PM9ZFdltvzY1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491077; c=relaxed/simple;
	bh=o0EI86hFzHFgy0sEINdmALcFfToHoOvzGbBleYMWPPU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=CuS1TALuQFGg08s1KyPgiDF1CBWjsAbAKHn2NMb/da14sctit/k5fjk1RhnfKepthFJygDQ/mK5LDh+a8mn65pXQbjXQFj5g/YAIxOAqQymyBk6euW+vDQnhtUd/CYC1V3un0AaC1ev0rZqIkZMr2o3eDHaJOFbdzAz3r+kPiAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f3G/Xp+M; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMWi0EnXvTGQDy9J/dfv+/0bOdEwTD5CdZcagNhwS5rGGwOULFujBLUJan5OLWbwm13KVR254F0slyOdU1w/vwl27AYs4Z2w8OzGmL7uWnfCrDroaY4MZhoSvA677+YMmepxGD85c0rpK9xAYTAyw+4LCgKFO+7bW1OF/2+j9f48UoHMQmMc2csGTqVJWVaEaPtWt8x2P8tqs6lffKHINgkpLE2vjWJf3Xjp1T0r20RYpoloDSGSI3aH0aFyAgYarZ2bVb07EHXjFDm+eCML796e0ezr5jrgQ19zja91Xrr1igNKZItpOCj7VDKUUCF+1Knb/yE/IfUdHVwDijySEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9ozxVYEr2YAqM9jTCCaosX+kelefPBBUXBGKF7IyyI=;
 b=GVmCZKcHhmTESuZ4Nzq+EJvxgXT+ajHu0ChiTwQidKnE/dspt1n+Fw/5isVbZ724KVvkX2x5nZodc3+n+jhKhRg7JNO9NYLEQ1PX7huHX9plIM8lw/e9iYsfVca33Hw+4g9d7TGj3MSx3Ra9SGPRgssNa8Q1dbynOVnWkxOaYnb26kCs92u8ZsjCjlPLoEUpY+8C/m9fKiwH/dbwzZr8QxZ9WtnPBOwJ4JIdavEVpYl2IFZOYEqJwXM0aZwoS0nOTGBy/PeuvBEntGB5lBL2wczJ9P+xlgbz0ZAiKrGs12M2z9Kfbh632FcXabZvohoKsHwQ8LsCSZunyfPW5OIHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ozxVYEr2YAqM9jTCCaosX+kelefPBBUXBGKF7IyyI=;
 b=f3G/Xp+MhoBOZ+50t97vi55VNfX+144RLXkLAB0bMqV6efsr+AnxpDO5GVfeC2fDXyYa/Ts9iOs5sdxwIBopFwOqiE6NH1TdvcTUEsLEdAI9xMB5xfbexxyKzoeoVSC/aXN481nACfKzbyIOUoEZ5RELAYO3PLjK51Y3XAoURPQ=
Received: from SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::23)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 11:31:10 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::b3) by SN7P222CA0029.outlook.office365.com
 (2603:10b6:806:124::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 11:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 11:31:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 05:31:07 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Moritz Fischer <mdf@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>, Wu Hao
	<hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open
 list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: fpga: Convert fpga-region binding to yaml
Date: Wed, 17 Jan 2024 12:30:58 +0100
Message-ID: <4d87561dcbfab9e4818d7ad99caf89938774a839.1705491050.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=34407; i=michal.simek@amd.com; h=from:subject:message-id; bh=o0EI86hFzHFgy0sEINdmALcFfToHoOvzGbBleYMWPPU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTlu3L8LH8+5TWy9TxVMTXspUVmwqJ5S250c3w91zyHZ 7WlyOdNHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi3+czzPfleRjEyavucXMv w3dPBq3+Y1H5txjmZ51pbryX/vfVSp3w6o3La/QZIwJDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e03a3d-9141-4a57-5158-08dc174fcd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nhv/EOEiFewCHORxn+HEMzknOhF4e/rexFiDGZNUO0Eal4+83bdAbEcLVyDWF3IPIM8miuipyjArI6vGBXdYPytG0X1kKVPazC6rYYJsrpEP0wMcVRfYFwSWIn+zEZgmwF1TzTNTolIt0DpRUV9GjYX1lcOp7KCe+s9o+lEbGO3my5Ksg4hKt5hwIB4yl8LXPInMkEuAuyaVbMnYAHy2f0wiOACjSL3PPkVzBEyZzFln8XdiS2vXaYrfymX8yWzqXOwlRUMMvPjRSdQUfg/SzpjjCLQSpVBpcR4+JjxpEEAKaNkYZswcf9DwGi1s9mtMK8DvuNC9Rid48Fvd8nYG+WyAJMtV496VXYKEJs7KAlBHsc/RzGKPsibSDH5ZjQHNp7JrUBLkGhvSD3cYcnHBeyxX3LfgvUh0ObARHHXIRTnztkk960kIfkDoOw6NHFH3QFCjwGnqHC6KCAhIOsqOIOR2FE/1R6yp6Zw4oANBHzmVg90cCxstabQ+T+NPpF3TyYNKxmzfRObtSKfqwxCdu/qB3ByYDxI05NMMo7eCYinyPkRpKURwQzWeGsJW6iw7jTwRrdz2BJsdXmnPvFVrho8c6mMMqF7ychhvwjs+DvNLVia6Dj+nJC2C14s6xT29gyu8cwmVTNlKSyWTs2vjd5oso2V+OT+7p1OuUmyQzwAjYYEp13JVpjBGycvzTPK1ppzlb8CQJOBB8UAhN3dU8MWV97AdUALBrw7sU1daNQ8M4Prrt8cBEpnN7R77talMVlj0fWFK51QppPv0Iaak03xA+F2CzJ1K2rKxD9FRYX6HPTnRT66ztT9hkiMpHoW1DMcnBIfyYnZZ6JirWF45nUEGYh+eSO2hPRvB6oy3Ovc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(84970400001)(83380400001)(70206006)(16526019)(426003)(966005)(478600001)(5660300002)(336012)(30864003)(7416002)(4326008)(8936002)(316002)(54906003)(6666004)(70586007)(8676002)(26005)(44832011)(2616005)(110136005)(36860700001)(82740400003)(356005)(2906002)(81166007)(47076005)(41300700001)(15974865002)(86362001)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 11:31:09.8178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e03a3d-9141-4a57-5158-08dc174fcd96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Convert the generic fpga region DT binding to json-schema.
There are some differences compare to txt version.
1. DT overlay can't be described in example that's why directly include
information from overlay to node which was referenced. It is visible in
example with /* DT Overlay contains: &... */

2. All example have been rewritten to be simpler and describe only full
reconfiguration and partial reconfiguration with one bridge.
Completely drop the case where fpga region can inside partial
reconfiguration region which is already described in description

3. Fixed some typos in descriptions compare to txt version but most of it
is just c&p from txt file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- drop fpga bridge and mgr descriptions in example
- use additionalProperties: true
- use fixed-factor-clock instead
- fixed matching pattern

Changes in v2:
- Fix typo in subject
- Fix comment in bridge example
- Change license back to gpl-2.0 only
- Do not define firware-name type and add maxItems 1
- Make fpga-bridge phandle-array
- Drop ranges property because of missing reg property of fpga-region
- Also describe case with fixed clock node and axi bus
- Fix fpga-region names in example

Please let me know if there is a way to describe overlays to dt root to be
able to reference fpga region back.

---
 .../devicetree/bindings/fpga/fpga-region.txt  | 479 ------------------
 .../devicetree/bindings/fpga/fpga-region.yaml | 351 +++++++++++++
 2 files changed, 351 insertions(+), 479 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.yaml

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
deleted file mode 100644
index 528df8a0e6d8..000000000000
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ /dev/null
@@ -1,479 +0,0 @@
-FPGA Region Device Tree Binding
-
-Alan Tull 2016
-
- CONTENTS
- - Introduction
- - Terminology
- - Sequence
- - FPGA Region
- - Supported Use Models
- - Device Tree Examples
- - Constraints
-
-
-Introduction
-============
-
-FPGA Regions represent FPGA's and partial reconfiguration regions of FPGA's in
-the Device Tree.  FPGA Regions provide a way to program FPGAs under device tree
-control.
-
-This device tree binding document hits some of the high points of FPGA usage and
-attempts to include terminology used by both major FPGA manufacturers.  This
-document isn't a replacement for any manufacturers specifications for FPGA
-usage.
-
-
-Terminology
-===========
-
-Full Reconfiguration
- * The entire FPGA is programmed.
-
-Partial Reconfiguration (PR)
- * A section of an FPGA is reprogrammed while the rest of the FPGA is not
-   affected.
- * Not all FPGA's support PR.
-
-Partial Reconfiguration Region (PRR)
- * Also called a "reconfigurable partition"
- * A PRR is a specific section of an FPGA reserved for reconfiguration.
- * A base (or static) FPGA image may create a set of PRR's that later may
-   be independently reprogrammed many times.
- * The size and specific location of each PRR is fixed.
- * The connections at the edge of each PRR are fixed.  The image that is loaded
-   into a PRR must fit and must use a subset of the region's connections.
- * The busses within the FPGA are split such that each region gets its own
-   branch that may be gated independently.
-
-Persona
- * Also called a "partial bit stream"
- * An FPGA image that is designed to be loaded into a PRR.  There may be
-   any number of personas designed to fit into a PRR, but only one at at time
-   may be loaded.
- * A persona may create more regions.
-
-FPGA Bridge
- * FPGA Bridges gate bus signals between a host and FPGA.
- * FPGA Bridges should be disabled while the FPGA is being programmed to
-   prevent spurious signals on the cpu bus and to the soft logic.
- * FPGA bridges may be actual hardware or soft logic on an FPGA.
- * During Full Reconfiguration, hardware bridges between the host and FPGA
-   will be disabled.
- * During Partial Reconfiguration of a specific region, that region's bridge
-   will be used to gate the busses.  Traffic to other regions is not affected.
- * In some implementations, the FPGA Manager transparently handles gating the
-   buses, eliminating the need to show the hardware FPGA bridges in the
-   device tree.
- * An FPGA image may create a set of reprogrammable regions, each having its
-   own bridge and its own split of the busses in the FPGA.
-
-FPGA Manager
- * An FPGA Manager is a hardware block that programs an FPGA under the control
-   of a host processor.
-
-Base Image
- * Also called the "static image"
- * An FPGA image that is designed to do full reconfiguration of the FPGA.
- * A base image may set up a set of partial reconfiguration regions that may
-   later be reprogrammed.
-
-    ----------------       ----------------------------------
-    |  Host CPU    |       |             FPGA               |
-    |              |       |                                |
-    |          ----|       |       -----------    --------  |
-    |          | H |       |   |==>| Bridge0 |<==>| PRR0 |  |
-    |          | W |       |   |   -----------    --------  |
-    |          |   |       |   |                            |
-    |          | B |<=====>|<==|   -----------    --------  |
-    |          | R |       |   |==>| Bridge1 |<==>| PRR1 |  |
-    |          | I |       |   |   -----------    --------  |
-    |          | D |       |   |                            |
-    |          | G |       |   |   -----------    --------  |
-    |          | E |       |   |==>| Bridge2 |<==>| PRR2 |  |
-    |          ----|       |       -----------    --------  |
-    |              |       |                                |
-    ----------------       ----------------------------------
-
-Figure 1: An FPGA set up with a base image that created three regions.  Each
-region (PRR0-2) gets its own split of the busses that is independently gated by
-a soft logic bridge (Bridge0-2) in the FPGA.  The contents of each PRR can be
-reprogrammed independently while the rest of the system continues to function.
-
-
-Sequence
-========
-
-When a DT overlay that targets an FPGA Region is applied, the FPGA Region will
-do the following:
-
- 1. Disable appropriate FPGA bridges.
- 2. Program the FPGA using the FPGA manager.
- 3. Enable the FPGA bridges.
- 4. The Device Tree overlay is accepted into the live tree.
- 5. Child devices are populated.
-
-When the overlay is removed, the child nodes will be removed and the FPGA Region
-will disable the bridges.
-
-
-FPGA Region
-===========
-
-FPGA Regions represent FPGA's and FPGA PR regions in the device tree.  An FPGA
-Region brings together the elements needed to program on a running system and
-add the child devices:
-
- * FPGA Manager
- * FPGA Bridges
- * image-specific information needed to to the programming.
- * child nodes
-
-The intended use is that a Device Tree overlay (DTO) can be used to reprogram an
-FPGA while an operating system is running.
-
-An FPGA Region that exists in the live Device Tree reflects the current state.
-If the live tree shows a "firmware-name" property or child nodes under an FPGA
-Region, the FPGA already has been programmed.  A DTO that targets an FPGA Region
-and adds the "firmware-name" property is taken as a request to reprogram the
-FPGA.  After reprogramming is successful, the overlay is accepted into the live
-tree.
-
-The base FPGA Region in the device tree represents the FPGA and supports full
-reconfiguration.  It must include a phandle to an FPGA Manager.  The base
-FPGA region will be the child of one of the hardware bridges (the bridge that
-allows register access) between the cpu and the FPGA.  If there are more than
-one bridge to control during FPGA programming, the region will also contain a
-list of phandles to the additional hardware FPGA Bridges.
-
-For partial reconfiguration (PR), each PR region will have an FPGA Region.
-These FPGA regions are children of FPGA bridges which are then children of the
-base FPGA region.  The "Full Reconfiguration to add PRR's" example below shows
-this.
-
-If an FPGA Region does not specify an FPGA Manager, it will inherit the FPGA
-Manager specified by its ancestor FPGA Region.  This supports both the case
-where the same FPGA Manager is used for all of an FPGA as well the case where
-a different FPGA Manager is used for each region.
-
-FPGA Regions do not inherit their ancestor FPGA regions' bridges.  This prevents
-shutting down bridges that are upstream from the other active regions while one
-region is getting reconfigured (see Figure 1 above).  During PR, the FPGA's
-hardware bridges remain enabled.  The PR regions' bridges will be FPGA bridges
-within the static image of the FPGA.
-
-Required properties:
-- compatible : should contain "fpga-region"
-- fpga-mgr : should contain a phandle to an FPGA Manager.  Child FPGA Regions
-	inherit this property from their ancestor regions.  An fpga-mgr property
-	in a region will override any inherited FPGA manager.
-- #address-cells, #size-cells, ranges : must be present to handle address space
-	mapping for child nodes.
-
-Optional properties:
-- firmware-name : should contain the name of an FPGA image file located on the
-	firmware search path.  If this property shows up in a live device tree
-	it indicates that the FPGA has already been programmed with this image.
-	If this property is in an overlay targeting an FPGA region, it is a
-	request to program the FPGA with that image.
-- fpga-bridges : should contain a list of phandles to FPGA Bridges that must be
-	controlled during FPGA programming along with the parent FPGA bridge.
-	This property is optional if the FPGA Manager handles the bridges.
-        If the fpga-region is  the child of an fpga-bridge, the list should not
-        contain the parent bridge.
-- partial-fpga-config : boolean, set if partial reconfiguration is to be done,
-	otherwise full reconfiguration is done.
-- external-fpga-config : boolean, set if the FPGA has already been configured
-	prior to OS boot up.
-- encrypted-fpga-config : boolean, set if the bitstream is encrypted
-- region-unfreeze-timeout-us : The maximum time in microseconds to wait for
-	bridges to successfully become enabled after the region has been
-	programmed.
-- region-freeze-timeout-us : The maximum time in microseconds to wait for
-	bridges to successfully become disabled before the region has been
-	programmed.
-- config-complete-timeout-us : The maximum time in microseconds time for the
-	FPGA to go to operating mode after the region has been programmed.
-- child nodes : devices in the FPGA after programming.
-
-In the example below, when an overlay is applied targeting fpga-region0,
-fpga_mgr is used to program the FPGA.  Two bridges are controlled during
-programming: the parent fpga_bridge0 and fpga_bridge1.  Because the region is
-the child of fpga_bridge0, only fpga_bridge1 needs to be specified in the
-fpga-bridges property.  During programming, these bridges are disabled, the
-firmware specified in the overlay is loaded to the FPGA using the FPGA manager
-specified in the region.  If FPGA programming succeeds, the bridges are
-reenabled and the overlay makes it into the live device tree.  The child devices
-are then populated.  If FPGA programming fails, the bridges are left disabled
-and the overlay is rejected.  The overlay's ranges property maps the lwhps
-bridge's region (0xff200000) and the hps bridge's region (0xc0000000) for use by
-the two child devices.
-
-Example:
-Base tree contains:
-
-	fpga_mgr: fpga-mgr@ff706000 {
-		compatible = "altr,socfpga-fpga-mgr";
-		reg = <0xff706000 0x1000
-		       0xffb90000 0x20>;
-		interrupts = <0 175 4>;
-	};
-
-	fpga_bridge0: fpga-bridge@ff400000 {
-		compatible = "altr,socfpga-lwhps2fpga-bridge";
-		reg = <0xff400000 0x100000>;
-		resets = <&rst LWHPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		fpga_region0: fpga-region0 {
-			compatible = "fpga-region";
-			fpga-mgr = <&fpga_mgr>;
-		};
-	};
-
-	fpga_bridge1: fpga-bridge@ff500000 {
-		compatible = "altr,socfpga-hps2fpga-bridge";
-		reg = <0xff500000 0x10000>;
-		resets = <&rst HPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-	};
-
-Overlay contains:
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region0 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "soc_system.rbf";
-	fpga-bridges = <&fpga_bridge1>;
-	ranges = <0x20000 0xff200000 0x100000>,
-		 <0x0 0xc0000000 0x20000000>;
-
-	gpio@10040 {
-		compatible = "altr,pio-1.0";
-		reg = <0x10040 0x20>;
-		altr,ngpio = <4>;
-		#gpio-cells = <2>;
-		clocks = <2>;
-		gpio-controller;
-	};
-
-	onchip-memory {
-		device_type = "memory";
-		compatible = "altr,onchipmem-15.1";
-		reg = <0x0 0x10000>;
-	};
-};
-
-
-Supported Use Models
-====================
-
-In all cases the live DT must have the FPGA Manager, FPGA Bridges (if any), and
-a FPGA Region.  The target of the Device Tree Overlay is the FPGA Region.  Some
-uses are specific to an FPGA device.
-
- * No FPGA Bridges
-   In this case, the FPGA Manager which programs the FPGA also handles the
-   bridges behind the scenes.  No FPGA Bridge devices are needed for full
-   reconfiguration.
-
- * Full reconfiguration with hardware bridges
-   In this case, there are hardware bridges between the processor and FPGA that
-   need to be controlled during full reconfiguration.  Before the overlay is
-   applied, the live DT must include the FPGA Manager, FPGA Bridges, and a
-   FPGA Region.  The FPGA Region is the child of the bridge that allows
-   register access to the FPGA.  Additional bridges may be listed in a
-   fpga-bridges property in the FPGA region or in the device tree overlay.
-
- * Partial reconfiguration with bridges in the FPGA
-   In this case, the FPGA will have one or more PRR's that may be programmed
-   separately while the rest of the FPGA can remain active.  To manage this,
-   bridges need to exist in the FPGA that can gate the buses going to each FPGA
-   region while the buses are enabled for other sections.  Before any partial
-   reconfiguration can be done, a base FPGA image must be loaded which includes
-   PRR's with FPGA bridges.  The device tree should have an FPGA region for each
-   PRR.
-
-Device Tree Examples
-====================
-
-The intention of this section is to give some simple examples, focusing on
-the placement of the elements detailed above, especially:
- * FPGA Manager
- * FPGA Bridges
- * FPGA Region
- * ranges
- * target-path or target
-
-For the purposes of this section, I'm dividing the Device Tree into two parts,
-each with its own requirements.  The two parts are:
- * The live DT prior to the overlay being added
- * The DT overlay
-
-The live Device Tree must contain an FPGA Region, an FPGA Manager, and any FPGA
-Bridges.  The FPGA Region's "fpga-mgr" property specifies the manager by phandle
-to handle programming the FPGA.  If the FPGA Region is the child of another FPGA
-Region, the parent's FPGA Manager is used.  If FPGA Bridges need to be involved,
-they are specified in the FPGA Region by the "fpga-bridges" property.  During
-FPGA programming, the FPGA Region will disable the bridges that are in its
-"fpga-bridges" list and will re-enable them after FPGA programming has
-succeeded.
-
-The Device Tree Overlay will contain:
- * "target-path" or "target"
-   The insertion point where the contents of the overlay will go into the
-   live tree.  target-path is a full path, while target is a phandle.
- * "ranges"
-    The address space mapping from processor to FPGA bus(ses).
- * "firmware-name"
-   Specifies the name of the FPGA image file on the firmware search
-   path.  The search path is described in the firmware class documentation.
- * "partial-fpga-config"
-   This binding is a boolean and should be present if partial reconfiguration
-   is to be done.
- * child nodes corresponding to hardware that will be loaded in this region of
-   the FPGA.
-
-Device Tree Example: Full Reconfiguration without Bridges
-=========================================================
-
-Live Device Tree contains:
-	fpga_mgr0: fpga-mgr@f8007000 {
-		compatible = "xlnx,zynq-devcfg-1.0";
-		reg = <0xf8007000 0x100>;
-		interrupt-parent = <&intc>;
-		interrupts = <0 8 4>;
-		clocks = <&clkc 12>;
-		clock-names = "ref_clk";
-		syscon = <&slcr>;
-	};
-
-	fpga_region0: fpga-region0 {
-		compatible = "fpga-region";
-		fpga-mgr = <&fpga_mgr0>;
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-		ranges;
-	};
-
-DT Overlay contains:
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region0 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "zynq-gpio.bin";
-
-	gpio1: gpio@40000000 {
-		compatible = "xlnx,xps-gpio-1.00.a";
-		reg = <0x40000000 0x10000>;
-		gpio-controller;
-		#gpio-cells = <0x2>;
-		xlnx,gpio-width= <0x6>;
-	};
-};
-
-Device Tree Example: Full Reconfiguration to add PRR's
-======================================================
-
-The base FPGA Region is specified similar to the first example above.
-
-This example programs the FPGA to have two regions that can later be partially
-configured.  Each region has its own bridge in the FPGA fabric.
-
-DT Overlay contains:
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region0 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "base.rbf";
-
-	fpga-bridge@4400 {
-		compatible = "altr,freeze-bridge-controller";
-		reg = <0x4400 0x10>;
-
-		fpga_region1: fpga-region1 {
-			compatible = "fpga-region";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-			ranges;
-		};
-	};
-
-	fpga-bridge@4420 {
-		compatible = "altr,freeze-bridge-controller";
-		reg = <0x4420 0x10>;
-
-		fpga_region2: fpga-region2 {
-			compatible = "fpga-region";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-			ranges;
-		};
-	};
-};
-
-Device Tree Example: Partial Reconfiguration
-============================================
-
-This example reprograms one of the PRR's set up in the previous example.
-
-The sequence that occurs when this overlay is similar to the above, the only
-differences are that the FPGA is partially reconfigured due to the
-"partial-fpga-config" boolean and the only bridge that is controlled during
-programming is the FPGA based bridge of fpga_region1.
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region1 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "soc_image2.rbf";
-	partial-fpga-config;
-
-	gpio@10040 {
-		compatible = "altr,pio-1.0";
-		reg = <0x10040 0x20>;
-		clocks = <0x2>;
-		altr,ngpio = <0x4>;
-		#gpio-cells = <0x2>;
-		gpio-controller;
-	};
-};
-
-Constraints
-===========
-
-It is beyond the scope of this document to fully describe all the FPGA design
-constraints required to make partial reconfiguration work[1] [2] [3], but a few
-deserve quick mention.
-
-A persona must have boundary connections that line up with those of the partition
-or region it is designed to go into.
-
-During programming, transactions through those connections must be stopped and
-the connections must be held at a fixed logic level.  This can be achieved by
-FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
-
---
-[1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
-[2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
-[3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
new file mode 100644
index 000000000000..fb6fe6f43fa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
@@ -0,0 +1,351 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/fpga-region.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FPGA Region
+
+maintainers:
+  - Michal Simek <michal.simek@amd.com>
+
+description: |
+  CONTENTS
+   - Introduction
+   - Terminology
+   - Sequence
+   - FPGA Region
+   - Supported Use Models
+   - Constraints
+
+
+  Introduction
+  ============
+
+  FPGA Regions represent FPGA's and partial reconfiguration regions of FPGA's in
+  the Device Tree.  FPGA Regions provide a way to program FPGAs under device tree
+  control.
+
+  The documentation hits some of the high points of FPGA usage and
+  attempts to include terminology used by both major FPGA manufacturers.  This
+  document isn't a replacement for any manufacturers specifications for FPGA
+  usage.
+
+
+  Terminology
+  ===========
+
+  Full Reconfiguration
+   * The entire FPGA is programmed.
+
+  Partial Reconfiguration (PR)
+   * A section of an FPGA is reprogrammed while the rest of the FPGA is not
+     affected.
+   * Not all FPGA's support PR.
+
+  Partial Reconfiguration Region (PRR)
+   * Also called a "reconfigurable partition"
+   * A PRR is a specific section of an FPGA reserved for reconfiguration.
+   * A base (or static) FPGA image may create a set of PRR's that later may
+     be independently reprogrammed many times.
+   * The size and specific location of each PRR is fixed.
+   * The connections at the edge of each PRR are fixed.  The image that is loaded
+     into a PRR must fit and must use a subset of the region's connections.
+   * The busses within the FPGA are split such that each region gets its own
+     branch that may be gated independently.
+
+  Persona
+   * Also called a "partial bit stream"
+   * An FPGA image that is designed to be loaded into a PRR.  There may be
+     any number of personas designed to fit into a PRR, but only one at a time
+     may be loaded.
+   * A persona may create more regions.
+
+  FPGA Bridge
+   * FPGA Bridges gate bus signals between a host and FPGA.
+   * FPGA Bridges should be disabled while the FPGA is being programmed to
+     prevent spurious signals on the cpu bus and to the soft logic.
+   * FPGA bridges may be actual hardware or soft logic on an FPGA.
+   * During Full Reconfiguration, hardware bridges between the host and FPGA
+     will be disabled.
+   * During Partial Reconfiguration of a specific region, that region's bridge
+     will be used to gate the busses.  Traffic to other regions is not affected.
+   * In some implementations, the FPGA Manager transparently handles gating the
+     buses, eliminating the need to show the hardware FPGA bridges in the
+     device tree.
+   * An FPGA image may create a set of reprogrammable regions, each having its
+     own bridge and its own split of the busses in the FPGA.
+
+  FPGA Manager
+   * An FPGA Manager is a hardware block that programs an FPGA under the control
+     of a host processor.
+
+  Base Image
+   * Also called the "static image"
+   * An FPGA image that is designed to do full reconfiguration of the FPGA.
+   * A base image may set up a set of partial reconfiguration regions that may
+     later be reprogrammed.
+
+      ----------------       ----------------------------------
+      |  Host CPU    |       |             FPGA               |
+      |              |       |                                |
+      |          ----|       |       -----------    --------  |
+      |          | H |       |   |==>| Bridge0 |<==>| PRR0 |  |
+      |          | W |       |   |   -----------    --------  |
+      |          |   |       |   |                            |
+      |          | B |<=====>|<==|   -----------    --------  |
+      |          | R |       |   |==>| Bridge1 |<==>| PRR1 |  |
+      |          | I |       |   |   -----------    --------  |
+      |          | D |       |   |                            |
+      |          | G |       |   |   -----------    --------  |
+      |          | E |       |   |==>| Bridge2 |<==>| PRR2 |  |
+      |          ----|       |       -----------    --------  |
+      |              |       |                                |
+      ----------------       ----------------------------------
+
+  Figure 1: An FPGA set up with a base image that created three regions.  Each
+  region (PRR0-2) gets its own split of the busses that is independently gated by
+  a soft logic bridge (Bridge0-2) in the FPGA.  The contents of each PRR can be
+  reprogrammed independently while the rest of the system continues to function.
+
+
+  Sequence
+  ========
+
+  When a DT overlay that targets an FPGA Region is applied, the FPGA Region will
+  do the following:
+
+   1. Disable appropriate FPGA bridges.
+   2. Program the FPGA using the FPGA manager.
+   3. Enable the FPGA bridges.
+   4. The Device Tree overlay is accepted into the live tree.
+   5. Child devices are populated.
+
+  When the overlay is removed, the child nodes will be removed and the FPGA Region
+  will disable the bridges.
+
+
+  FPGA Region
+  ===========
+
+  FPGA Regions represent FPGA's and FPGA PR regions in the device tree.  An FPGA
+  Region brings together the elements needed to program on a running system and
+  add the child devices:
+
+   * FPGA Manager
+   * FPGA Bridges
+   * image-specific information needed to the programming.
+   * child nodes
+
+  The intended use is that a Device Tree overlay (DTO) can be used to reprogram an
+  FPGA while an operating system is running.
+
+  An FPGA Region that exists in the live Device Tree reflects the current state.
+  If the live tree shows a "firmware-name" property or child nodes under an FPGA
+  Region, the FPGA already has been programmed.  A DTO that targets an FPGA Region
+  and adds the "firmware-name" property is taken as a request to reprogram the
+  FPGA.  After reprogramming is successful, the overlay is accepted into the live
+  tree.
+
+  The base FPGA Region in the device tree represents the FPGA and supports full
+  reconfiguration.  It must include a phandle to an FPGA Manager.  The base
+  FPGA region will be the child of one of the hardware bridges (the bridge that
+  allows register access) between the cpu and the FPGA.  If there are more than
+  one bridge to control during FPGA programming, the region will also contain a
+  list of phandles to the additional hardware FPGA Bridges.
+
+  For partial reconfiguration (PR), each PR region will have an FPGA Region.
+  These FPGA regions are children of FPGA bridges which are then children of the
+  base FPGA region.  The "Full Reconfiguration to add PRR's" example below shows
+  this.
+
+  If an FPGA Region does not specify an FPGA Manager, it will inherit the FPGA
+  Manager specified by its ancestor FPGA Region.  This supports both the case
+  where the same FPGA Manager is used for all of an FPGA as well the case where
+  a different FPGA Manager is used for each region.
+
+  FPGA Regions do not inherit their ancestor FPGA regions' bridges.  This prevents
+  shutting down bridges that are upstream from the other active regions while one
+  region is getting reconfigured (see Figure 1 above).  During PR, the FPGA's
+  hardware bridges remain enabled.  The PR regions' bridges will be FPGA bridges
+  within the static image of the FPGA.
+
+
+  Supported Use Models
+  ====================
+
+  In all cases the live DT must have the FPGA Manager, FPGA Bridges (if any), and
+  a FPGA Region.  The target of the Device Tree Overlay is the FPGA Region.  Some
+  uses are specific to an FPGA device.
+
+   * No FPGA Bridges
+     In this case, the FPGA Manager which programs the FPGA also handles the
+     bridges behind the scenes.  No FPGA Bridge devices are needed for full
+     reconfiguration.
+
+   * Full reconfiguration with hardware bridges
+     In this case, there are hardware bridges between the processor and FPGA that
+     need to be controlled during full reconfiguration.  Before the overlay is
+     applied, the live DT must include the FPGA Manager, FPGA Bridges, and a
+     FPGA Region.  The FPGA Region is the child of the bridge that allows
+     register access to the FPGA.  Additional bridges may be listed in a
+     fpga-bridges property in the FPGA region or in the device tree overlay.
+
+   * Partial reconfiguration with bridges in the FPGA
+     In this case, the FPGA will have one or more PRR's that may be programmed
+     separately while the rest of the FPGA can remain active.  To manage this,
+     bridges need to exist in the FPGA that can gate the buses going to each FPGA
+     region while the buses are enabled for other sections.  Before any partial
+     reconfiguration can be done, a base FPGA image must be loaded which includes
+     PRR's with FPGA bridges.  The device tree should have an FPGA region for each
+     PRR.
+
+  Constraints
+  ===========
+
+  It is beyond the scope of this document to fully describe all the FPGA design
+  constraints required to make partial reconfiguration work[1] [2] [3], but a few
+  deserve quick mention.
+
+  A persona must have boundary connections that line up with those of the partition
+  or region it is designed to go into.
+
+  During programming, transactions through those connections must be stopped and
+  the connections must be held at a fixed logic level.  This can be achieved by
+  FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
+
+  --
+  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
+  [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
+  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
+
+properties:
+  $nodename:
+    pattern: "^fpga-region(-([0-9]|[1-9][0-9]+))?$"
+
+  compatible:
+    const: fpga-region
+
+  "#address-cells": true
+  "#size-cells": true
+
+  config-complete-timeout-us:
+    description:
+      The maximum time in microseconds time for the FPGA to go to operating
+      mode after the region has been programmed.
+
+  encrypted-fpga-config:
+    type: boolean
+    description:
+      Set if the bitstream is encrypted.
+
+  external-fpga-config:
+    type: boolean
+    description:
+      Set if the FPGA has already been configured prior to OS boot up.
+
+  firmware-name:
+    maxItems: 1
+    description:
+      Should contain the name of an FPGA image file located on the firmware
+      search path. If this property shows up in a live device tree it indicates
+      that the FPGA has already been programmed with this image.
+      If this property is in an overlay targeting an FPGA region, it is
+      a request to program the FPGA with that image.
+
+  fpga-bridges:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should contain a list of phandles to FPGA Bridges that must be
+      controlled during FPGA programming along with the parent FPGA bridge.
+      This property is optional if the FPGA Manager handles the bridges.
+      If the fpga-region is  the child of an fpga-bridge, the list should not
+      contain the parent bridge.
+
+  fpga-mgr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should contain a phandle to an FPGA Manager.  Child FPGA Regions
+      inherit this property from their ancestor regions.  An fpga-mgr property
+      in a region will override any inherited FPGA manager.
+
+  partial-fpga-config:
+    type: boolean
+    description:
+      Set if partial reconfiguration is to be done, otherwise full
+      reconfiguration is done.
+
+  region-freeze-timeout-us:
+    description:
+      The maximum time in microseconds to wait for bridges to successfully
+      become disabled before the region has been programmed.
+
+  region-unfreeze-timeout-us:
+    description:
+      The maximum time in microseconds to wait for bridges to successfully
+      become enabled after the region has been programmed.
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - fpga-mgr
+
+additionalProperties: true
+
+examples:
+  - |
+    /*
+     * Full Reconfiguration without Bridges with DT overlay
+     */
+    fpga_region0: fpga-region {
+      compatible = "fpga-region";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      fpga-mgr = <&fpga_mgr0>;
+
+      /* DT Overlay contains: &fpga_region0 */
+      firmware-name = "zynq-gpio.bin";
+      gpio@40000000 {
+        compatible = "xlnx,xps-gpio-1.00.a";
+        reg = <0x40000000 0x10000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+      };
+    };
+
+  - |
+    /*
+     * Partial reconfiguration with bridge
+     */
+    fpga_region1: fpga-region {
+      compatible = "fpga-region";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      fpga-mgr = <&fpga_mgr1>;
+      fpga-bridges = <&fpga_bridge1>;
+      partial-fpga-config;
+
+      /* DT Overlay contains: &fpga_region1 */
+      firmware-name = "zynq-gpio-partial.bin";
+      clk: clock {
+        compatible = "fixed-factor-clock";
+        clocks = <&parentclk>;
+        #clock-cells = <0>;
+        clock-div = <2>;
+        clock-mult = <1>;
+      };
+      axi {
+        compatible = "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        gpio@40000000 {
+          compatible = "xlnx,xps-gpio-1.00.a";
+          reg = <0x40000000 0x10000>;
+          #gpio-cells = <2>;
+          gpio-controller;
+          clocks = <&clk>;
+        };
+      };
+    };
-- 
2.36.1


