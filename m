Return-Path: <linux-kernel+bounces-18666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC2B8260C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AEF283626
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93C8C0A;
	Sat,  6 Jan 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q8vs3frD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1CC8DE;
	Sat,  6 Jan 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQGUGiWsg+Jd/R7i8+Ysff900Ea2HHRGz9GWHM8gQRymUTyUCYKmnOgYd2EJwHOpSoWiNUrfDxdhp30a6QyqcZZ5msiIK47CNsjumcRLkb2/0I2X9onKf1LOJ/sqSlIdNio3pqDDs8GEIsL6cn2JC049cz4lJB1h6xAGcJP9nxjUIckOwuVpa/nDJaPc6XV2F2CFk9N7mNj99+SNDc46ek8HhALW35ARgl46CTOnU5Qoa/3pVOAbBY6ZSIv08F9jGHM2HYvTFBja1saZqLD/pWIQaL7b63igTEq43+GaE2VpoWU9vYcqXa8RQAVNsG9o2hLdvAjtTW/ttetf0QCiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLqDbC/VkWwHpJsvacZD8fVAgDKcEC649GsjpOYm2q8=;
 b=I0JPw1kiIUDpJYhXu09B135oydO3FfMXecuCdoj+eq3KNLYiysua7cqqfjlP5qPGdOqnpKsbnNe9BEV7wYG7dO1kXwCB1qTomQXqjKfiFHQWx4yTS9C3YjS/lFImXmBAPjr7mOEuYjblRDJEIiIPXO7xoS6RSF8alS4yMDlx8wk+bzbI2HlK9Ec4Aq1gwI8BgNaBQ3Pp+IqUBQKNTXt7W/cdVAdcDJPIO+kPVnCFYpOhCRTmf8I7Up7UaQxgYxApg2hczqLoJK1inoIRHMN+EIvYTt7SOSJy3BNmEvftAGjNiORhdQr6r1pqoiF7pGt/vsN/SryrpH7jLpxhX63Xwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLqDbC/VkWwHpJsvacZD8fVAgDKcEC649GsjpOYm2q8=;
 b=q8vs3frDpMVY6pIuBv5W04NTPow2bUNWS0ais3auqVvu9JceUS6mxkTpIugVnPCNy63jK8r+f7vDRA0AQDH1+ui7x8hBTrWmRMssBpMBAh8HUVVSRyE67PycvQCZ8D641kmDojvgY8p/i9oHObN/QExYsaX54MzF8bDIoJPeFwM=
Received: from MW4PR04CA0253.namprd04.prod.outlook.com (2603:10b6:303:88::18)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 16:57:55 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::d9) by MW4PR04CA0253.outlook.office365.com
 (2603:10b6:303:88::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19 via Frontend
 Transport; Sat, 6 Jan 2024 16:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.2 via Frontend Transport; Sat, 6 Jan 2024 16:57:54 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 6 Jan
 2024 10:57:51 -0600
From: Sanath S <Sanath.S@amd.com>
To: <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
	<michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
	<YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sanath S <Sanath.S@amd.com>
Subject: [Patch v3 0/4] Add support for downstream port reset(DPR)
Date: Sat, 6 Jan 2024 22:27:19 +0530
Message-ID: <20240106165723.3377789-1-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM4PR12MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a010ea-3cc3-442c-bfe0-08dc0ed8a0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JivbEMQ4UZa56ouO07XMltPmnsjuhkAfdfXIt+n0sjTaED94La3n/KHZe7bc7VqBEfoLfRqWh/WZZk94tn9Bn4aBgyJbkG7XCtOXPfqNtWk03F5fCC0TXlBVb97ggbTU1KvB3rA065KHMoE+vN4gcPdp+f+PNfeJTgjTkv4kZDv620GDU7dOqFBDeELroeQ8EReKvqPLpUR7tQYEPvq+4XoZPVO210ilbwOu5rotEzWvQV2fU4R1rimlRGyaVLJZuvmR9kF+O8Yq3um6fwiA36FNKy0OrIWt6JpnjRD2L3bz+NiSPkkpnhyaiVmNuyz8tWrZxBBonI3ImX5hwGpgq636gn7yvSCR3dG8svBvy5ci8xcvFQ7fTPAy8mwr1SFqV7akgJpHM8GCvxEoUmvMci+ek8/4TWdtHQphD2rTxL53JKxwBD3IYvGwOfzg6GVQ4sRpQjpvhCjyXBzc0+2ecQKVVLBbTBp3Vr5BSiMcdL2o2lz5OsxKISs/VPuEoGknalUZa5qtWONZFemvGgS+AV2Cp6UY4WgVvS0SpzoATJQYfI1LcYC0XkEd7CKNWZwuPMIwY34zTXN93wU6T3NRRo//1oTZ36cW8wqujGePE3mEptxAPet2K2aQjarP7VZYNI0kDgc60m2Zyv3HyEPdw0/kWuvG3Ki6/eFyYzCcCTy05qCVkYeFyMqqBcU0FGH50wOVv/DVBOYCKZ7PqfEehdBdteVfjVvDOSixY7HxNiO3PV/moP8FZ/Ulw7RRjNfzeh8PE+aUEVSmzURYNIhiQcSgFySOAZ2tLOIn06ey1k8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(1076003)(26005)(426003)(336012)(2616005)(478600001)(6666004)(7696005)(16526019)(47076005)(36860700001)(83380400001)(66574015)(2906002)(5660300002)(41300700001)(316002)(70206006)(110136005)(4326008)(8936002)(8676002)(70586007)(82740400003)(86362001)(356005)(81166007)(36756003)(40460700003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:57:54.9605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a010ea-3cc3-442c-bfe0-08dc0ed8a0ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278

Tunnels created by boot firmware results in incorrect PCI resource
allocation, which results in failure of extending daisy chain.
This series aims to resolve inconsistent tunnels or paths created
by boot firmware.

Before:
           +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
           |                               \-04.0-[07]--
After:
           +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
           |                               \-04.0-[07-62]-- 

This series also aligns with windows behaviour of performing a teardown
of tunnels and resetting the downstream ports using DPR during the init
sequence.

Changes since V3:
 - Remove discover_tunnel() api before resetting DPR.
 - Add lane and protocol adapters reset in tb_switch_reset()
 - Addition of tb_lc_reset_port() for TBT1, TBT2 and TBT3 routers.
 - Addition of tb_path_deactivate_hop() api to help suppport path
   reset of given hop index.
 - Addition on new patch to store and indicate host router reset 
   status of USB4 v2

Changes since V2:
 - Perform DPR only for USB4 routers.
 - Update kernel-doc and return value to -EOPNOTSUPP.
 - Limit delay range to 10-15ms.

Sanath S (4):
  thunderbolt: Introduce usb4_port_reset() and tb_lc_reset_port()
  thunderbolt: Extend tb_switch_reset() to support lane and protocol
    adapter reset
  thunderbolt: Store host router reset status in nhi_probe()
  thunderbolt: Teardown tunnels and reset downstream ports created by
    boot firmware

 drivers/thunderbolt/domain.c  |  5 +--
 drivers/thunderbolt/icm.c     |  2 +-
 drivers/thunderbolt/lc.c      | 44 +++++++++++++++++++++++++
 drivers/thunderbolt/nhi.c     | 19 +++++++----
 drivers/thunderbolt/path.c    | 13 ++++++++
 drivers/thunderbolt/switch.c  | 61 +++++++++++++++++++++++++++++++++--
 drivers/thunderbolt/tb.c      | 29 +++++++++++++----
 drivers/thunderbolt/tb.h      |  7 ++--
 drivers/thunderbolt/tb_regs.h |  4 +++
 drivers/thunderbolt/usb4.c    | 39 ++++++++++++++++++++++
 10 files changed, 202 insertions(+), 21 deletions(-)

-- 
2.34.1


