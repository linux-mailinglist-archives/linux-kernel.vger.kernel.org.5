Return-Path: <linux-kernel+bounces-19711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03A82715F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB923284238
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220D405D9;
	Mon,  8 Jan 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oa1eV0eE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D036D6E9;
	Mon,  8 Jan 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+eV8FyERR9xsa+jvw0FYbo1rapj29utPRsQnSGZvtBagMi6EtP0UGPKJcfeM+YNhfCql19T+3gMZ3BQinfCZlbYnNEARgLlwUIqOWe84DWGr/YmdN2VLuPZ+U5dkAzrPbXMhkUdGwmGONoa3iGQ271ZKfPI8/I0sJwK89uWAuzJeEq5rqqiZLEOOZVR9syCIijhU7PN6oj5nFfVe3sYxoiMFzC7pZxxvZ5vWSttWS57U6NkiQTSX+0Oqx4EvsSOG9tNoXDRMzZ71CHGuMIaQBWpBelitjj/sjUo0KPl3GGA+6s4y5PAMOf6tqU8GKdeopmqQXaqzpna0Cn9n4mNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOBevP/T5NjXmpkWtBdv878BfJ9DHwjwLErlE1qutzw=;
 b=Zp7VCozAAC1fpZ5dLg+CyPyHw55dXunRjIXkpfqDEGbtGAFkbbNWFbNDbF90H0KNoud+fapcWk35fN1oNcJl7QT2DZZ6a7gPdzzGzfktM65AF1mniTEc81gdmFsSXLAnmzIDqe25JrCW8ZwPcEbA3wixsDP+0P0IjSkcuHb6PQ8D7hifR8Ra8l1XccTWhLFGxcvND2j5LONiOf9aSdRbYauvTmDUv7yE2DJ7FzbWIoGLESoNJAkbLZcqoWHs5o/Mtp3qdareS0JnTboJOZyMoKrpCNS0QX6Aw/20C2FBcxgm3oet4tMvm2b7iy+1A7yPU6UlDd1xg+8AIb9SoKAlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOBevP/T5NjXmpkWtBdv878BfJ9DHwjwLErlE1qutzw=;
 b=Oa1eV0eEW3dwJsELrHL0VM1yK9Y3c17xn4g+Tt9+YzYS4uhBCpjospHNAArWL3iFkyDYhLrP1FQw5wLfuO9OihG4+0WeTAbmdM0ogRYUsrMBM6fnimr979e0RZN1ev5lcwXTaabCbQ7azo+mCKMUHGV/yOgIpLlwdfWKJMqCKUo=
Received: from MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15) by
 LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 14:30:56 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::13) by MN2PR01CA0046.outlook.office365.com
 (2603:10b6:208:23f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 14:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 14:30:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 08:30:54 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:INA209 HARDWARE MONITOR DRIVER"
	<linux-hwmon@vger.kernel.org>
Subject: [PATCH] dt-bindings: hwmon: ina2xx: Describe ina260 chip
Date: Mon, 8 Jan 2024 15:30:51 +0100
Message-ID: <4c82dc4d412e91d1601c1da5bca1cdf1a91cd9b8.1704724242.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=michal.simek@amd.com; h=from:subject:message-id; bh=NHCqolahrlTNQmu9fswCHi6Cx/uA37ao7xcwdiQqK6g=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ57MIbTmp3cnw+3bxzm4XH/DV1Lz7HPbI7+V1xrvmzm KL7OnONO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEdukwLGibdfPx2nlTtYOX tbL3MX6J/OaespFhfkXYgUizqa+T1S3yuo6taxT/sqT/NAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: bc370e6e-994f-482f-5c7e-08dc10566d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0HqU4Ds+kZ1RcnkB4eH7tcnWddwDRAgM7FZfBS0LTwNvCvPWTClqsasRjpcQNBKY0h2RpP/4AJu5idhiLu84/DCCZbCTyc2ywkeA+1UTygCptWqaH5PE6PQTp4oY7rrLjmEbzlxkNMOzYm9el1+vfbgufAyTpEfJKd2QOSMeXGbPxExD8tp4vxRRywm9Sx7EJEeaQDiQrfolz9f4fQekckHedvdh7xkEZ0YerF1ZtPFuDfFqGCw9sJjGc3P5Na4PvQRDRG0TMxBqHqvW2Eh0/V43YW8Yb0wxBPl7plpzYIH6Hvrq2QMV/jDLaUsLAvym6tDgP+5oMzR7eKtRKAzB93ghB/yH/oGAPZw8CoKwUFSRhDgFbgHFSSUe0owF/t1/EIGokm6u4JmxCTNnkvqz2ropa1RCAWw/+Gar3hxGUA1FfGsW2fz3e84+Epc46dzfBzFnPgGqtreb08A9ZoPUNc1th6+oNv181O0ek5QK8RGgku0iOi1d0trwa/g9yTSn26EomIowXU7nVHmW6nuQ2ijQdvOs5hQ+hcIrQ3AqdWFopF5292wEJdGufJtU+sCh3Qwd/5YtAz+zVbhAb4s6GjokGgJGcwi3keLOrb/dfTJy7OD33ejMFjnRK64BPgv4aoW8Z1z3SYaniZdbCn7CzQ2YTcZApabz3keWhuIfeYH74e31wl1feCR3LWtKuZPEYvfik/j3GK90ULlukN4XzZnH6KJJOi303Sb+P9WBQpHf6AZc5JUNZgsYnnyoccPbvdm9gnbfmK5Fl3+QMYdCoQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(5660300002)(40460700003)(36860700001)(6666004)(7416002)(4744005)(40480700001)(478600001)(966005)(82740400003)(2906002)(47076005)(44832011)(4326008)(81166007)(356005)(336012)(16526019)(426003)(26005)(2616005)(8676002)(8936002)(54906003)(110136005)(316002)(41300700001)(86362001)(70206006)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 14:30:56.5556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc370e6e-994f-482f-5c7e-08dc10566d3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

Describe ina260 chip which is precision digital current and power monitor
with precision integrated shunt resistor.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Driver has been sent here but not merged yet
https://lore.kernel.org/all/ZOILXb-1ObJRB1ck@lguegan-thinkpad/

---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index f324b627bf9c..a099bb71415e 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -28,6 +28,7 @@ properties:
       - ti,ina231
       - ti,ina237
       - ti,ina238
+      - ti,ina260
 
   reg:
     maxItems: 1
-- 
2.36.1


