Return-Path: <linux-kernel+bounces-4717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A53818122
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7BD28504E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17362746C;
	Tue, 19 Dec 2023 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ueJddjFm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E916FAD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjwnxXU2fAGfJiW3CQHOvbp9Vj6k4a4RWtOJGkPYH+sloJZew4zPItUuf2I8SdopHbwftPQPrzk5Hvxdjltd4gGB5Bjd2dWdtTNgGtyUELTNLMEdZx1oaVfslrrrXtPZQuAkhRS4NhqTwq2Pqb3ElXIzigyn9bjcVjh2tXLXKIUefs6l1Y5nUK2HSt0eeu03Dh4zLQu92p4gUR4Nh6gRJ55ZV/bVib4CicoC/dEqo5orjVDEMUAVyr+GpaWPpWFokRmyBXV3MPqNRUqbiEFXEA+v/6ToOVPKil4AxTDvHedoFTUK/6locHFn9zqD6IwlqBYDOuGOcN0+54ReEHTjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2FnMIUUp3DS4FV2NAFpTufxAbU8BW+Russ02EOUGkY=;
 b=F8nWqVz0e91tBglbusCOK7/Ot4QktqBOTDUZzaZHzMlWyfeh30WhrOtx4esFQ4w5rCA0gHWOWLKG33/1V7Ocvhcs+gYzz/jJ04Hef+6RzvQeaFtkhwgGU0jsipUrYV7UMVS5P18Z02tyIfmy//5SZqeSr6j2T67eiUZWTM3otCrP9C/vcIJOX8CAs1/GdO4qQTvHgo7XfYSjOhJZ1rMwWi4pIT7PIpDAqyhwio8fIMciMK5VmQsJ0mldL4Q8N2crJYOJnKaKt2HOmZNrouuEeQpmb68r8fw26szP6bYRrb0XFcvmG3aoWBZGcHRSQifxBvjumKetF5GiWEXi5Nlu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2FnMIUUp3DS4FV2NAFpTufxAbU8BW+Russ02EOUGkY=;
 b=ueJddjFmvtHsoTfvHzy6NVyrd4oXpW+aAe7OSpYo1OiC7R0SE4O89M0kXvcck3PLhWjZyj2QHfnC3BihJxlEPRtMCqxudgrdKv8gDOCyXjxL/mavh6vV6yrZrzxrsyXCkeRP/d//ZMiBiLNoAmqpYKg1mvD7MRLiRCh6rXOTHWw=
Received: from DS7PR03CA0104.namprd03.prod.outlook.com (2603:10b6:5:3b7::19)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 05:50:47 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::51) by DS7PR03CA0104.outlook.office365.com
 (2603:10b6:5:3b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.39 via Frontend
 Transport; Tue, 19 Dec 2023 05:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 05:50:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 23:50:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 23:50:46 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 23:50:45 -0600
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<sai.krishna.potthuri@amd.com>, <linus.walleij@linaro.org>,
	<nava.kishore.manne@amd.com>, <dhaval.r.shah@amd.com>, <robh@kernel.org>,
	<marex@denx.de>, <roman.gushchin@linux.dev>, <arnd@arndb.de>,
	<shubhrajyoti.datta@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH V2 0/2] add platform check in event manager driver
Date: Mon, 18 Dec 2023 21:50:23 -0800
Message-ID: <20231219055025.27570-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0701e8-0561-4bdd-1087-08dc005672db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4I6TCi2rF44rup9XKtCBB3yavfGcIW3kcTXKjmr4Bdkjzg6tWicgf93Srtq5yiRlEyXyF/lHFpCkku7OfoCKlmXgZyGbEgpaexLWWVM+vNJSsNztHIQa6Wy2SCGCaEK1qHV0FEFmeycKI9v5TFto9+iUvUDXvJvfKEE5McTNqckBs+Ft3pxdKU8JawemSSODkgYfXcJxWWKqK+Og3U+v2DhzMXbdyLhOYXl9w08WnFogdeCAZ8oI62eYGJeUyZPYT8XWR6/QI7EVhOkaWdETD47R8aSaAT4QBIhMXGrL+beViDGVyP+bFRZdXxeywUahzXsaAC4VqumlOy1DfGDTOJQRjTA4qkFXyaKDt+NPGNiuJaFqSxLNGctyGwfpy4ZsFssahJDCK7HjyVgRdOVN1PAKvonU0F7bpbBhsQdo51Xb26TKaKFfXQwJm61HA61LMGD9x728SchpHGd85G86E7Ybrpg+LIcqlWzCyzh8SUzs3LIm2t9Rc43XP9hMmkOPmjVdm4LhnQ59L3H7iq190QHfFGs1e1CkMJO1KOxUi1XcT2/n6fAAYMBmyojY19QbfKNu/QwOWsgfhhRZz3mse/Abpr/Ji+O95N5CQ0fkmCSkI56eugItuwjnbGatoFbUc2XFU1jY3Z6FbR/NDErhwPbM/Z97QEPlqcPE4kzG40jenLhV9b0SdIGrsWrWdcqYGnVWx2Oh6V7BhvBEPEnyvp+MHV2Qs+Gduu2W3iQ56AR/Q6k8C0GqWtD8XsHM8x+UXX8wJTpAxiZLH+sXtKgXDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(6636002)(336012)(83380400001)(426003)(2616005)(1076003)(36860700001)(44832011)(478600001)(4744005)(4326008)(47076005)(26005)(41300700001)(8676002)(966005)(2906002)(6666004)(5660300002)(316002)(8936002)(110136005)(54906003)(70586007)(70206006)(86362001)(36756003)(82740400003)(81166007)(356005)(921008)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 05:50:47.3133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0701e8-0561-4bdd-1087-08dc005672db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

Some error event IDs for Versal and Versal NET are different.
Both the platforms should access their respective error event
IDs so use sub_family_code to check for Versal or Versal NET
platform and check error IDs for respective platforms.

V1: https://lore.kernel.org/lkml/20231218094009.13528-1-jay.buddhabhatti@amd.com/
Changes in v2:
 - Fixed compilation error in edac driver

Jay Buddhabhatti (2):
  firmware: xilinx: Export function to use in other module
  drivers: soc: xilinx: add check for platform

 drivers/edac/versal_edac.c              |  4 ++--
 drivers/firmware/xilinx/zynqmp.c        |  3 ++-
 drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
 include/linux/firmware/xlnx-zynqmp.h    | 22 ++++++++++++++++++----
 4 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.17.1


