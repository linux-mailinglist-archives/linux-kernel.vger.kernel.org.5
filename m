Return-Path: <linux-kernel+bounces-1139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BE814B03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624D2286134
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE34358BA;
	Fri, 15 Dec 2023 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B/lwUzTL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607A1856;
	Fri, 15 Dec 2023 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiXBpmmOH9SlMZonuka24y0C74Cekj36evxW/ccAS6YGt+9Er2UkY53DN9rnNMu8Us5eS12Q6WHYroSc2R+su9bp9qsaIC8XqtKH7RdsZ17SF+SapXe3+g6XXAffWQmJJ/WrHKdVIQaOrbkUDZFhJB/7dLcKA/tyjRV/BPk8vZdQK/dnCXIpiLW+Xi4g30YdI0o89BX+iTdXGUhKe7TOAaAwTfPjQLrCpsWaSwhJuyjw9wY09tVBIkYP1Jd06aJ42w5rQJjTITXxitY37szTRGLa14NMnGH9skdSBYRdwpwzqh3YMquJH8aLuY9XV9tl/WvtdO8o3zaa0Zo+fRzi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+98QjCgvTYEn+OxbjbviKAM/7wMMvgvSL072VQPSjo=;
 b=BP2hCCrw7Kc1/nNGokFZ3J+mbdHzl2yHnD+R9c3z8QuKl0RghCD75WaZtaZYXhNYPICsAaBVvNl+GSN5lkF2dnSvhMlHO5IXu8pG39kUTmY6Me9PdINcuUJ6v9stqXz8XxfqHBuMhg1vcfwcKmNhwU2f/2axMDDTbXkcVTetHgaoJnh7Unvjn3zdxkfzP1AW1+q9+zd1SeiRPbVxDpirmmpxdYS8wDj6sHHJGRY+aKzese/pN+esImXCGLAj3SeVPS0XnyUF0JPd2M6MveBWn1/iwWMe6bMc33h3gwV+tY46VqPA/zcoPVBlAq3UI94/jHhvq1O/XIDPNt6PbMMXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sipsolutions.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+98QjCgvTYEn+OxbjbviKAM/7wMMvgvSL072VQPSjo=;
 b=B/lwUzTLh53/EcOh+QABUVVtSPJlooGh5Xq5piOREKxwVmBNlGtZEYkJZEKv7OGbLe4pcsAKxC0K33zSMBYOjYV7TBdHNw8EBdjaFEB7XX23RHBs5Op04/bq39ZCuqmgfoSiyBfS1oDShNpAaUPFve9uarwXC7v5Y1oOqD8oJbk=
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:55:01 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::22) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 14:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 14:55:00 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 08:54:49 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:MAC80211" <linux-wireless@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Jun Ma <Jun.ma2@amd.com>, <kvalo@kernel.org>
Subject: [PATCH] wifi: mac80211: Use subsystem appropriate debug call
Date: Fri, 15 Dec 2023 08:54:39 -0600
Message-ID: <20231215145439.57286-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH0PR12MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: e85cd8c8-5c0a-4cf6-b02c-08dbfd7dd046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xhgxoUypo/mU/7bJ4TYYZRxwZSf2fk8hGso9jLqWHxtasQfJKTinjFBWkPt1L64G0hBTHrXzOOR+GrHBEcjFOPbMZv+08qUoiSAmcJwtNsXWpXkdOCrony9A8wKJrVLgGmwUTzJGeYbm/4fvoebTRsgNICD1gg+D0AkO6vLr3N0p9+PdpoCHBbuQX+TbBslcMvLK8iUTKfudzQmPOrJY/SeV8cKQYfMGe2g6Kf7bZpWLt34/gXM+KB5GUKhInqiRH3el2iaT+Fz3NbmNqESm9wLOaFbotG3gFObt2HIGPYnGgfZA+iN1MY1VX5eObLgXK51YjfFdDXx0/SbjPc+ZZ4aQ8JYxzkvftBNfeA3wtyfnq+QDWdLZ52MRDot7ZlHdsZB3rUYs0OeLpoqppVB7aejriZ+fF2em6TA6rJZnMvcFBbE/wt7yp+x6smw6rHzYwJVCSjVPTGobn6Dx9KLDoEX413PfeuX/mxgh7w1gwGeafGhfsCZAk/F0edgSdXccqojy9NxO38yCWOwvup4A/FmjVlRn0xpY/F6LPNZmiMZ+kBcRh+c6Xjlo18kKPDiMJ/i8M1ZSqowga3v9+w3anzCygh65Xgfm2Bpcz7iUcyZbDkyS1fOsGeHzUA+hF8MNno2CVpKxf04RpCWNYv2ErXAIoT/t1a/I4+3xMGTYBoxhjmqs9OS2XqsYzezrOhKbjlVLPGxtxGt0FHkcQ3K8RVmthC7GhfAtIgE6KOE52mxr7J6QPvZXokj0EY5+6/bQJPPCNZJ/3FnM98vyo5hcIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(16526019)(26005)(426003)(336012)(7696005)(2616005)(1076003)(82740400003)(356005)(36756003)(86362001)(81166007)(47076005)(83380400001)(4326008)(5660300002)(44832011)(36860700001)(6666004)(70586007)(6916009)(316002)(70206006)(8676002)(8936002)(54906003)(2906002)(41300700001)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:55:00.9308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85cd8c8-5c0a-4cf6-b02c-08dbfd7dd046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025

mac80211 doesn't use dev_dbg() but instead various macros from
net/mac80211/debug.h. Adjust wbrf code to use wiphy_dbg() instead.

Cc: Jun Ma <Jun.ma2@amd.com>
Reported-by: kvalo@kernel.org
Closes: https://lore.kernel.org/amd-gfx/8bd60010-7534-4c22-9337-c4219946d8d6@amd.com/T/#mfe2f29372c45130d27745912faf33d9f7ce50118
Fixes: d34be4310cbe ("wifi: mac80211: Add support for WBRF features")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 net/mac80211/wbrf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
index a05c5b971789..12c23e14f884 100644
--- a/net/mac80211/wbrf.c
+++ b/net/mac80211/wbrf.c
@@ -23,8 +23,8 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local)
 		return;
 
 	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
-	dev_dbg(dev, "WBRF is %s supported\n",
-		local->wbrf_supported ? "" : "not");
+	wiphy_dbg(wiphy, "WBRF is %s supported\n",
+		  local->wbrf_supported ? "" : "not");
 }
 
 static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth, u64 *start, u64 *end)
-- 
2.34.1


