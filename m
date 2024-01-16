Return-Path: <linux-kernel+bounces-27295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EA82ED73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813702856A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD521B810;
	Tue, 16 Jan 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zx9q7ofI"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24F1B7EE;
	Tue, 16 Jan 2024 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZz/E4VEeHZbG9TPn7CJdoAE69Fjm46YdKMQkR88YoEJ9pPoU3owQ9/uXHKVAFwZpgMcE67DJew88x0926d9vJ/yE71n2k+zoja9h1+By5XQlJElf+A4LXNYdCTCE6s/riJ30DKnd1NaKotXoWTLn15bLtNZc7rMSpq91s7vwgnpCzfmj/fU86s4TFj/BT5MhHYUBY5YBz7eSEhq1XWus8royQbNc2kqxgar9ifxntQWsS5e4Jk6TdrJ8gj+AcZeaPwJdwB7KNXpHYoz3ng8bXGKZ4fpBMJkrASr7bJgwiV68Q8jcGREQow9/WLp5P+tpqTDiIU1szm33hxtqUYK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEfBxmXsN5GatCFvkL1HJC7vi7MsLypWqGC2uW9DQms=;
 b=PCIDpvdZ20Uk0P3MQoozitMZfuhG+3hUELptPjWx6AdiQNzqewRIHf2raJG4Q7akTCvzNJ2/QAi2tP50DLe7x/bWC577FYhqkhfaVz6HCMDKtAORa7QOh1X9dOjkiKYI2/uCyesA07XiZE0pa2RKreCxxTV3MIUYqfqwIu7IiGSLNkWf3pUGNaOnE9/Gzk4A0FzxDtqag3KJowjOa0cAd2R1MUdvC/eQpi2ZX6wEDhOu+23BmVkPU9hawgWSPdioCe7/zJSQphR+HkbDMj/OLoQqN+uKsS76V6kRbf4z71A89EAsJybu+1X1GHgwuBuc9qcWdX0Eou874D43cm1Itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEfBxmXsN5GatCFvkL1HJC7vi7MsLypWqGC2uW9DQms=;
 b=zx9q7ofIDtBXeo1lMiiNPuMHL7iOAyGj87g376iR/voYp3o2hPzghKKxc6T3ZR16309PdSkQ/OSKa8ee6UnegOFwDrxEdp+rTX9HwW5P2M2yKehOatW/xTL2F5fr2vNrMDC45utaOqQEyxaaszWoKUKlP2c44HDWeOp6u1cvrfk=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 11:11:46 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Tue, 16 Jan 2024 11:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:11:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 05:11:43 -0600
Received: from xirdraganc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 05:11:42 -0600
From: Dragan Cvetic <dragan.cvetic@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <michal.simek@xilinx.com>,
	<linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH 2/2] MAINTAINERS: Update sd-fec documentation file from txt to yaml
Date: Tue, 16 Jan 2024 11:11:35 +0000
Message-ID: <20240116111135.3059-3-dragan.cvetic@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116111135.3059-1-dragan.cvetic@amd.com>
References: <20240116111135.3059-1-dragan.cvetic@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 995a9ce5-f17c-4683-7c53-08dc1683ed5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G2672sKydKkgAxjj3S2ZXct/h4GHaYxV0qLdA4cSrJjyI5y2Wo6LWPb3SRyj8ZBSSxsMI8FJuJMrm/RVwhJ9zVpjYY+/cd4UMXHXmgsE7jOMfrqbB6+V6xTZ5AASSiGZY7jLpzuAb5KwbUK3Ixqn4gSXVZexipBirYk0mF9oH8mqXLdIcivyNL4C3Imzx9yegEsToPRjiorctiFkS7tq+ReC2bEZoY+q8bpIRe+wVXt1WFOFlgcvuI9lAWUj3m8sPfLPX3SVX66JEDl7fl9rlnmVX3XjJUEs45RQw1NOsberctJ+yqSuGKB6eULLKjORgCkSv/igTHVZJlA2Wb0ZKr0EZ1tIFnyF75TQXXK6yNW8mW9bvdn0XG9Drc/dqFEq1oZdhmZ0rS+YAJEhkk7PSTtq7trwnzAtWkK9wwqUuhdVBn0KZvfK8Xs75Hfcdx5KNxSSCsRBOL4EBZJI8Bsrol6t6W/PGP075aUA486OfQcnAoTpFezTE0kIOaiaZ1wJb3eg2vfQ+Xhz1C1HnofCRNqIDVuUtz38itrpGDBsZGtR6YNF3S9ZqjxA7xZPqwBphgrJQj96JZFeHRkCORuNiJEm9ZPsKI6AbrGKQrHf0VDfRhReT3lwZdkXCRMyjIkOS1fYNCfAKYKqbr487WyECD+t1+1KxLG1s76sJmU1R2YIwJ5K7R6FOf67PjKNnkg3Sg2VEtYwL3NTb08I1DAWNcYGr2sH5Qmp+W93OqR3r4iqB1gvyzWq4oj7TnPwkSDTw1f4Ewei1ILN47hVM6oXww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(2616005)(426003)(6666004)(36756003)(478600001)(47076005)(36860700001)(41300700001)(26005)(336012)(1076003)(83380400001)(40460700003)(40480700001)(5660300002)(110136005)(70586007)(2906002)(70206006)(44832011)(8936002)(4744005)(15650500001)(356005)(54906003)(4326008)(8676002)(81166007)(316002)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:11:45.7240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a9ce5-f17c-4683-7c53-08dc1683ed5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

The documentation for sd-fec bindings is now YAML, so update the
MAINTAINERS file.

Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35147477e8e4..37754901119d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23942,7 +23942,7 @@ XILINX SD-FEC IP CORES
 M:	Derek Kiernan <derek.kiernan@amd.com>
 M:	Dragan Cvetic <dragan.cvetic@amd.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
 F:	Documentation/misc-devices/xilinx_sdfec.rst
 F:	drivers/misc/Kconfig
 F:	drivers/misc/Makefile
-- 
2.17.1


