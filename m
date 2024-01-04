Return-Path: <linux-kernel+bounces-16993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05B8246F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86EC1F24ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24228E03;
	Thu,  4 Jan 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ceyc92/m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E828E08;
	Thu,  4 Jan 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oaml5MlsX2fB8uOS5exsKWrTYFZTV+qv9BPYo0vZH6dJ+VJuKee5C2k90J9CID9CNhk+UpILrQy43YlTILLEeaN3fCiiaK4PKj670OLYKM93ssaULqvRZErOnHWq44kAgy/ajBTTi7RoKn1QBv+95khZq8e3bRLFHrXyEBZtupeEvD0O47RRUrwzyyTF+jfqCdN2tJslt54kIdItjo9MHk0B3G93mteSpIpFIwuvwM3nIyMbq/mLswJaDRgwu0QMHoFgDKPUMVFFDyHRI0Sbc4JZmeZd2bsA4c8TwJ1Vyuw8E62SIfvLbqFZDf74BKB/d5xSTU9Usz3xCCfePqeOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i5iTkjB9RKVS849bpRU0uyBpm1hokcu+T/8U52wCLw=;
 b=jDldbzkJFW+XfpHrzLG1cdnqC6LyOQPrRjA7rZs+c7Zo3ptFaetvE8vHk3shsWkYtA1m2s6rKzGibA2jQ/Zb9/9alR8M6eD1cdXQFAq9Dh1BCNwVTooXnytg+MUxbZnawa37MDvs0P62UPot/1Uw0DxOYFr4gCT88VhrWbv2CV9KuM5GU+8XjfRJdhrqvj5msFqK9d6n6emJozdgv2/LftscWieE5FBcdHUvOS/j5yKHXlrv28WgdKyqp3mFoLr3TyKK51PmKZXF9saPtKWJ6B9hq0zsO70ZYVXNYR6p90uALa12NEKapeTQBrA/Tm+Em/7Rt4bcAlgGhgBYWytYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i5iTkjB9RKVS849bpRU0uyBpm1hokcu+T/8U52wCLw=;
 b=Ceyc92/mUnaD//h7mo2KQ5zAbegHt594wG6WOqiUpEgNpD02usEtmX5yCxzZ7/0p+wmP5LhAXWqO2fjEJy3LTmAB5GWvyORvE+Watid0kwTgFndwMSJTQUoIkHBBnXdsc8AZUsGPUvphM28UbQq5AUhHybr4Al3Ib+GtO3rCS0w=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 17:12:36 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2f) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 17:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 17:12:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 11:12:34 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 0/8] pds_core: Various improvements and AQ race condition cleanup
Date: Thu, 4 Jan 2024 09:12:13 -0800
Message-ID: <20240104171221.31399-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: a4040157-b43b-4d81-6deb-08dc0d485906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fs2hIiyoGLcrg37gVJtfYFvAzn8fu8ef4vHxMubjlMDUVKPMCCsus6mp6UzBD3Q7IxYABdo1P1RZMKSODF82p7S3uUjQkgg4Kr9zIKzUREqfnIfmuieG7kHPMqgr3TnUUA66l0kmCswc7fCPv3YW7E46Cnw4jjgJttOkAzjuXUn2jgaSzmGTCRW6jTVgIS/k2CwtwbhZnOHFw6alQ2bquYzA/qtZjAlmzE3cE1C7GO1XkORjiwoqJc+5JE/tzIS7u9UlHPeKhqA4n1UeDTFgqZiL/JzlrfadvAq/sylBTESrIIX0Ar60qzgnKkwd0v4+/d97H+3nXvG8x+BtUrkzW0XOKRXHUVR2GZXZXG/Ai544Gu2uCswZZIgjdS1C2ji2yAwvXg658P9jdDdbPjj7FUOKJsnxgCnou0NDKgQpLHbtmp2akQCIRzhXJTB2iUw3LZU7QHLlwz97ennCvIfZ9L0lsMbeQKTmHFskDAi/FUWBlSDkhsDiz3xOlRBk304Zv6onk4F0n2IeYCWlsfxz0UjJhl6pgDoknU2w1Uxky0Yb30ShB3mIrdFzRERDQn9JIT+xwNcNyEsHprhn9COM6QOJQ3cxo8qP4MnO1p73sM7E9iqhcy1xI0W/VP62B99RRpzIx1+oRlzz1lJU9LA93VrT7ahPtoTodbnCj9xtKBCiVZbO1NwOF6S828o81hJ2VeW5AHDjGTDaazCqthRkPnXUu+j3exEB//5MWotaWDBw4f5EJkn9yHiimkNkVjOP/PjWBCTO1Aczx9TcdO1iwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(36756003)(70206006)(70586007)(86362001)(81166007)(356005)(36860700001)(82740400003)(47076005)(6666004)(83380400001)(16526019)(336012)(426003)(4326008)(316002)(1076003)(2616005)(110136005)(54906003)(8676002)(8936002)(26005)(44832011)(5660300002)(2906002)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:36.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4040157-b43b-4d81-6deb-08dc0d485906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966

There can be many users of the pds_core's adminq. This includes
pds_core's uses and any clients that depend on it. When the pds_core
device goes through a reset for any reason the adminq is freed
and reconfigured. There are some gaps in the current implementation
that will cause crashes during reset if any of the previously mentioned
users of the adminq attempt to use it after it's been freed. This series
addresses these issues.

This series also includes some general cleanups.

Brett Creeley (8):
  pds_core: Prevent health thread from running during reset/remove
  pds_core: Cancel AQ work on teardown
  pds_core: Use struct pdsc for the pdsc_adminq_isr private data
  pds_core: Prevent race issues involving the adminq
  pds_core: Clear BARs on reset
  pds_core: Don't assign interrupt index/bound_intr to notifyq
  pds_core: Unmask adminq interrupt in work thread
  pds_core: Fix up some RCT issues

 drivers/net/ethernet/amd/pds_core/adminq.c  | 74 ++++++++++++++-------
 drivers/net/ethernet/amd/pds_core/core.c    | 38 +++++++++--
 drivers/net/ethernet/amd/pds_core/core.h    |  1 +
 drivers/net/ethernet/amd/pds_core/debugfs.c |  8 +--
 drivers/net/ethernet/amd/pds_core/dev.c     |  9 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c |  3 +-
 drivers/net/ethernet/amd/pds_core/fw.c      |  3 +
 drivers/net/ethernet/amd/pds_core/main.c    | 24 ++++++-
 8 files changed, 123 insertions(+), 37 deletions(-)

-- 
2.17.1


