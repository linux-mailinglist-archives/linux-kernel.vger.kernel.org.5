Return-Path: <linux-kernel+bounces-962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C1081489D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1531C23244
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF942D05F;
	Fri, 15 Dec 2023 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SStZbSYZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146772CCBB;
	Fri, 15 Dec 2023 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3XV3KEW6zei8NZEE6YO43AqcJ7ZsavI+H+WGSQfpx+Lm6vBMeEyy/brND8vaYIrwIqV+VLD7NrLg00Rt1x0ySKYTl+mjltbgyX0UPggLfOB4lZNHkXqT6VL8uwTtBNAUB/XJtACJxYarvXauDHkaod42sveA1GHvp6SBtZbwvaej2/aJHbUl0zLtUbIIzw6B+Ra0RACfv1Ho0zgYJTRWlkjZkcPiTP8nWQjJZ1+xGOTKllfbCbYjrXi4LXAifW7knXc6rI+JihDj9eIv/kAxKlF2mXszVDiYd2j208AM5w7xPij1kC2Kj/fUTN4SbS4DxC+lzscpv5/X6irgnazNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8xzfuOx7o3gYSo7AEgAczC5JX2sTLwHxgCXiR2HKe4=;
 b=KBUAlyXi+8FyiD2Kmq2Nysz+T8p0kUWQhePrX4zGXUIlOkOpw1PZJ9adfObc1UijpFamaRuXyUwQ+Ejg6kt8ineU+lh7wEmg+yn6txCkrOmuBVTr1C+rN5cchRNvddeAE8yKOL3ALIW61nBrb7e2QVQFM/DQS8dhFzmQL1AYOsMIxQ7SCT6kfz/I4DmfU8TlDKBb/ITFTYuR4tF3JlFJXYeSPxJU2Nzj0/f4/ABFHlBtopyA2S/mzH/HT0qrGZuZ+qR5bP4ZJY3aAZkI0U2p8vfO47MRMv5mCLYQLpWLF52nQ+62CUef3E+aW8SjDf6u1o5jlPndmOI1MWzxr8cBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8xzfuOx7o3gYSo7AEgAczC5JX2sTLwHxgCXiR2HKe4=;
 b=SStZbSYZjn2H3wBfwucbl1lFSSDC7DebqNM9FlAZJs3O+kf39rXhzXec9ccnrU6YOjnJqAJPhpQA0sYxcw0EAX02UGDkbeJ5GRP9OFqKoe0Thtdo7YJxltAjma3ATeNb8hMo6FX7EbkG+Hgh9nYJyWGB5NUQl7j6DSM3QD+Y9gU=
Received: from SA1P222CA0140.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::23)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 12:57:09 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::60) by SA1P222CA0140.outlook.office365.com
 (2603:10b6:806:3c2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 12:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 12:57:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 06:56:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 06:56:46 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 06:56:42 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V6 1/3] dt-bindings: Add reference to rs485.yaml
Date: Fri, 15 Dec 2023 18:26:25 +0530
Message-ID: <20231215125627.1691573-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215125627.1691573-1-manikanta.guntupalli@amd.com>
References: <20231215125627.1691573-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c465424-66f0-4960-0b6b-08dbfd6d5942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0AF5NTjiXzod/bamdVY7fcU3vDNI+ykyX9CawMjJaXRE6D6U5k3CQy7e6xPKcM/6mOH1tLTPeGOZMVW1gqS/BBMIXO6i54zdwqoP9NlJJaYl1YpOoWXZsGYFUf3CrAZDlxoNYjqlctarkUmAPbTofGAjNe6mSsm3VMH0KNqysxakwka1+JpNuaPq5uMhEH0U9VTmd24RoGwLRaX3MV21QS2zgnCft5tcPWs3fGSPhA4qHRM76ByAzyvdejGvaj0fC8LIG/TLk3858DgZkTNtkfXpSv40oDevfHNVxPH4XMJRWOCM2FkylvFDxL5WXZ//LuhIz0kvEnKNrgmB8B8k+SQ3hl7DphhYci2+0+wXYOjw34iCTInOtxdM3XbDo/g45fHpNXQsluYuo4XnKiSctGgyHOG5mppi1bEL5BhUoeWfhAdoJeIPr4rnnQ7VtZeATipmDk1wM7LPw2fRwo7PN118uWQFtpyQy2p0EjLWBONrHOMSISsAiNQ70vQxaXuHeKh+h//u1Wg1f8ZysL9fpA7RdM9H+Jy6H5VVv4X7xrKscM7FVldu1h6cRCVwthalq7u/QA2D5PobhmXDUByRu2zo6/jZ8BkoRHflld/QZuY++orSXqOgy3lSskMw7EubhNcJpAoeqhaqTjQgJCcmvgR5tHNCKaajWaxLfGYownNGQj4mXzZoj4ilyAaaOSHOBPDcJbOCsxoSnBqwuOP974UMXABvAU/qdykwC2/5R4u97PwfnO65f9hnq+5dxKSpBskqbEUvL3Oo9HAez0vCEGzGGWVEp0sfnoO2cK/UuIw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(26005)(426003)(336012)(2616005)(1076003)(356005)(82740400003)(921008)(86362001)(36756003)(81166007)(47076005)(83380400001)(5660300002)(4326008)(44832011)(7416002)(36860700001)(6666004)(70586007)(316002)(70206006)(110136005)(8676002)(8936002)(54906003)(2906002)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:57:09.3195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c465424-66f0-4960-0b6b-08dbfd6d5942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

Add rs485 support to uartps driver and Xilinx/AMD Kria SOM KD240
board have rs485 support.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.

Changes for V4:
Update rts-gpios description.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.

Changes for V6:
Update commit description.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index e35ad1109efc..2129247d7c81 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -55,6 +55,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1


