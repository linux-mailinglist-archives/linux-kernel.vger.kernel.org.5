Return-Path: <linux-kernel+bounces-3972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D1817637
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1BE1C252D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C04FF82;
	Mon, 18 Dec 2023 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ip/qaZr+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92D4FF76;
	Mon, 18 Dec 2023 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or8gdgG/8CRQqAmc7gji1gqnCKHcgPSOf/nGp1uXapycZfhjgFAn3/NUdc5jdOg3CXpmlZwkjXYNhPm7FhB0KPtrWA+XIDj6uc2lJb2YIpPC5X6xOJ52e9Xi8aKFeYlHxm2Rp1H38sY1oliGqueaGqF8FlQpFhmqrgJhcZH0inNkcQUnAZPgrzZOYXEAx/A9g1IDajFpvUiz8J6bcPMhqLz4tWT3OxZQgg+rEHqDCeCaylgJgbJP+d86oU+FzSXxu/HNlJNAVX93gwx7Gb683uKi/HvOvXDnCQWlraNoMadeh3Bj06yit4XKKL819e1rgbZ4zpMJSxJiq3YjxWM0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvye4HPHmhqzYFrSgmIoUyM1q7dNcfBaNGVSvMMn0fM=;
 b=gUfjISDA7vQfAeUeatcxu6vnvAP08bYJ8cq2Fqo3LRKvI7OEmnVGKx942GoCDLpHoyLyAVzqylUl1ce72lfdeZbR787QmTWIl97Tw4OXXdGiMNZtOrT3fD/zuYWEx4OoeTtMUCV2edCKT3El6VARPUa1kOtJvisi0oDVg6s74pYm7rNlOXJ/9tC9Y9bACmLSXpqfFxKIz2rJvIrgOCa2ZFTC3XopGG7V37Ok1PFnppbVlLCY8MGfNl7xfocYsMfgLR4vy/eVrYWEuY+JJRC1uZrkzpW+ea8NqLkCPaJW+PDaNoCYvuQM0uDwW/NAvWAAVuoR30Z8AHhyhgdRZ2v6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvye4HPHmhqzYFrSgmIoUyM1q7dNcfBaNGVSvMMn0fM=;
 b=ip/qaZr+qeU9/PSNdU423xe/FV8tLgetBUrZdyO+Hyzd10RezjgelUd3ixnev0XP5gDD9zLBCXeNc5rlNgK+SDU4vrZ6IonihD5UIKwr5G2FpT0fDgLiNfUwoimYpSUdTsRtXZlVCmtWXy+RqDm/GbK610kVEsr3Fb1Rm0RR+Nk=
Received: from SJ0PR05CA0145.namprd05.prod.outlook.com (2603:10b6:a03:33d::30)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 15:43:11 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::64) by SJ0PR05CA0145.outlook.office365.com
 (2603:10b6:a03:33d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Mon, 18 Dec 2023 15:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 15:43:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 09:43:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 09:43:09 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 09:43:08 -0600
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: <corbet@lwn.net>, <avadhut.naik@amd.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carlos Bilbao
	<carlos.bilbao@amd.com>
Subject: [PATCH] MAINTAINERS: add reviewer for Spanish translations
Date: Mon, 18 Dec 2023 09:43:08 -0600
Message-ID: <20231218154308.3314929-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cd3a0a-3f2b-47be-2e97-08dbffe00a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	09cbUbW34hl2mNfbJHrt91jAd4Gly+sT1trdhWlFNzqernpnqEmWIiQLoGdVbG8R64iS0++NPwqyXGIU2ZBCfPVIcHtU9Rg6wfnHcwNoD9t9kT20aMki5/R9ez/MyuhWxzFApMXlMjj+l+E7ctxD/NCjre/myM5YeWTr4LPdgjbeFoiZ9GNhEbDHwyROn9kehLK6usXpsdOYrZFmx9VOt3ojjoq6XM0b6wsfyYtYicdR0oT6f6mC8Na2mgXGJzYhIaZO6jFRXS4utHqy8DokbKa/IY8HwpTvRYqHn+kiBu1r2SjZ5TQan9AkwhP4OHPhkLWaqwXfEpGAHOtcGkTFpqH6TNUhE9Z3sXYliwlNmQBVT3oHNKmwlREnFeEx9zkdwfE3gpHdsMr2TUiwju5spIwK1F+kkjvJGt0Gwc3+Arow9Z0FvJbHxe3IX99Re7f1wro3Fd8AOS/qWjxoG/Rp4lI+MGyTBVlVhPoXH3hVtn3Xqlbr+69Y0pCRC95DqTVEabVLDMImBzS1pWNxCZeL02rNcUsaywIkrk8+8eM7LHX56UZFBkEk6VNT9ZBN21add5Mk2M/vd4XBoms842J9yFK00sTLTRC7hPZ/ZuGa29ZtQIA2BRjbR0L6TjMHfqyGzk17l6pV87Q5ttsJzKx0quTfYizWbgB5v+61oV1SyG9K7k6Fb/4y5bj3nedJsPo5z98n++8j0zi6hfzhc6bOeutuoDXwIEKRclABl7HMBFT/X+1INKOIWim4ZmlRgdublBogfjrAVP+WLrRJ8U3IUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(2616005)(70206006)(70586007)(6636002)(110136005)(316002)(478600001)(54906003)(1076003)(40480700001)(26005)(336012)(426003)(4326008)(47076005)(44832011)(8936002)(8676002)(7696005)(40460700003)(36860700001)(5660300002)(4744005)(2906002)(86362001)(82740400003)(356005)(81166007)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 15:43:10.6153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cd3a0a-3f2b-47be-2e97-08dbffe00a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

Add Avadhut Naik as reviewer of the Spanish translations of the
documentation.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6024d1d5ebf8..0506d14340f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20360,6 +20360,7 @@ F:	drivers/media/dvb-frontends/sp2*
 
 SPANISH DOCUMENTATION
 M:	Carlos Bilbao <carlos.bilbao@amd.com>
+R:	Avadhut Naik <avadhut.naik@amd.com>
 S:	Maintained
 F:	Documentation/translations/sp_SP/
 
-- 
2.34.1


