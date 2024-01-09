Return-Path: <linux-kernel+bounces-21084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0B3828982
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF3CB23F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07F3A1AA;
	Tue,  9 Jan 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a+eiQQeT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2C39FE7;
	Tue,  9 Jan 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3U62x3BaaxB+hrojirfjLa1S9iDUzngkh28NbM60DRRoPlU8n4s3g+l6j9xuUFMw/KIQnsPAdl7beoifC9EoUgUSrAF9DiNV3zWnXO7D5t7QotWt6wLs0rDQBeENjghXCfm8JWumrOuSM9k0j9fkbps7zpOoAs5DOZJx5vA9l2xtbauQUdAN1HIZZziSKw+gSQk+MNK1tTk6gDJxD+SvzXip9/HkFty1wv7bb8bP2qnN/QscpXJiDpQslJnjCu3psuEhxqRP7SmovOJt+U6RWCfSMbDWCVgtf40CBVaAstf7FsUfHlsOdPr/qhDMqhAZw/lVKMndac7+KDbX2dwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJtiMQP+z/k7992HH+4d/4Je79ovYZCjOYQ/bES9evo=;
 b=eUhq3FvfaOS+eBdXCg1xa9LlrMoxDHb3fQkMo3c4/FrgCt7HPe8K2gc98FG/co3AKgplxx7lHUvg5g80082rhiZ+2G02DsoTbFiXxyzff07fHn9OdSJ/wnKktdQUcZSHezBYqk082mjnkE/Y6sr7Q2STCvhickKmzq0X6a5WYTWINFpd9yYAZ9dhz16xFs9kfQUIfLEgmANJhsR0FfJ5v51d97sC9v6C8PC7iTJ85o9Bb8/gewbFPDS/ow0ahaJtFRpgTtxz95dcgws1NXN/EKF1YOixBHFUFnBp/nAMmAjYBQYqonoNQjzAUn9rtbl67Mk7DuwAmYaoiAc0dOCY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJtiMQP+z/k7992HH+4d/4Je79ovYZCjOYQ/bES9evo=;
 b=a+eiQQeTCWAvB8MQMLBbF/73Y+mrl/GPAPGviPP2wF5WZZcYzNaDbwOA8TcHVtBiwQBdwzzJoITrwM8CcAXr/Fyt9HsX6QQmYloVgVbLqISrB6qEErDU4oRY3qozcJVELeK5pZfF5ruedJ4EW2Yx9yCp75V5sfsbaqhH0jM3i4s=
Received: from SJ0PR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:332::11)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:56:46 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:332:cafe::61) by SJ0PR05CA0066.outlook.office365.com
 (2603:10b6:a03:332::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15 via Frontend
 Transport; Tue, 9 Jan 2024 15:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.4 via Frontend Transport; Tue, 9 Jan 2024 15:56:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 09:56:44 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 9 Jan 2024 09:56:44 -0600
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: <corbet@lwn.net>, <rdunlap@infradead.org>, <vegard.nossum@oracle.com>
CC: <bilbao@vt.edu>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 1/2] docs: Correct formatting of title in admin-guide/index.rst
Date: Tue, 9 Jan 2024 09:56:42 -0600
Message-ID: <20240109155643.3489369-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109155643.3489369-1-carlos.bilbao@amd.com>
References: <20240109155643.3489369-1-carlos.bilbao@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 87adc789-5335-4891-11f4-08dc112b94cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Cvvc9TJWCAwrfq6ChtRLvsmUf4wvWF2Q1cYvB6VUtByhuO/62DZz5jilCb/v67zrQzAHVNdLNXkXcyx8wFGQ8UWVUp1Ii4uIfaLzymWBGqdS8o/VPhzG+AxN+RO6Zjf6XvCVBQMN1nHtrtkXpKR9a/rcr2isEOIlTU8+9MUVLklZnSXZvDzZiAvwH9tHeqz8v1geQ63pVnau2CO2l3U3MQ1avTaOLdkdaV0pYk85vDzsPtNIHHHaA7wjpbxebS+iIUUYNb9ATfF0pgGLBOuBsmsqwlWhlnAMFVUuKAuyQDakNDOcmhy/bWsr3NtEiZEuJ4j2wbwvKem9Qbz3e+XRVyXPI2YAxn/US5Jpt1jfGDzOiT43ZHcn3aTpg6mEvTdDazOHBYT3h3pVX6TknvXKnBAGvAeiOxHbyrM1R6/AFu1BYUQ2OyKvPNEMUejsG1D3NbmpgxCFqirSOufLBnR7Y6/voDsMRleJmHFfiBm+VVrE8jZLxcwJbu2K5NXVF2orIguHi9puimRLAAXZLC3l1J2SyyqOhivwxZ5csAU+D6khDswBNkrqckvCLS7MZ5Ev9BDk2Bee9oi8WDy3lR+Hbu+w/BOwG1J83AgBMlT4MeGGb3aXTTCkBzpwYDse6BRof3V1nbd94/ZlcoNY1cjio3Xzyu+O/c8MfuVuQ5Y6s7Dyz1Wtq0KCeTCXmB49YI34oXH2SqHxQc22hlcMszOL0PgxytBsue97vdfp8EpxmQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2616005)(1076003)(336012)(7696005)(26005)(478600001)(426003)(82740400003)(36756003)(356005)(86362001)(81166007)(4744005)(2906002)(41300700001)(36860700001)(47076005)(83380400001)(70586007)(5660300002)(54906003)(110136005)(8676002)(4326008)(70206006)(316002)(44832011)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:56:45.6225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87adc789-5335-4891-11f4-08dc112b94cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

Adjust the title of "The Linux kernel user's and administrator's guide" to
adhere to the expected reStructuredText (rst) formatting, using double
equal signs for the main header.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/admin-guide/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 43ea35613dfc..af0fa0ff5d65 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -1,3 +1,4 @@
+=================================================
 The Linux kernel user's and administrator's guide
 =================================================
 
-- 
2.34.1


