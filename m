Return-Path: <linux-kernel+bounces-14466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648E821D63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E76228483F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B11119D;
	Tue,  2 Jan 2024 14:07:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2081.outbound.protection.outlook.com [40.107.222.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D3101D5;
	Tue,  2 Jan 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7/2VhM9QM5lmHhx0WnhgMESKoBtgQhV2K/R68NTuBprX7C/sPh2PsEKXTDb14Z+zDfbD4Fq1mgFeEI0epf0Hzg9DfvMJ67wd1sjqWOsHPkvv/xCZy8zxFdQf/MMgQ1gTyXwZV/1UR4yIfk08meMu3nYcqhFSthOlM6cij+I9dIhJnrjui6OYJKoo+sZmmx2H+Ep/t3es/WF4smhuYopfL9Tc0gMTDvIOcJ6UNdKE5GbrTG/6kpOezCc9ZLLNIDoomiQ6pRvPspQuV2A+S1zsCMESThyvVuhDZmgC8JL35i9TezWCRn4c9cg2ZL/d+m+5qiM1E7Fz/TZaiLMqd8qYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZCP+tZfOSiECWGY85D2VgoJ9IlWyNopswZ+YSbCsTI=;
 b=NLHkoahMn8p+tz6c1HAStTkyYD3UWOZPSY+bGUMbCOLFblNrXUbrsXdJc37/aQZ8cGwxlFvvRtzq4PFluh5wRJ4zqjDh8Mb5BuboOERv/BSpMIVQCAKt5ToA1wSyPLtqRft+q5IlMprthgJnDAjMKvEMLCkhXRqcj2wob6gSVNiJ/U6HBZRX6YGtPjG/UsMGygxoyaakWKj6TVECaWbzC1G1Rr1z4VkJjFIPYF7xrY+uoeNPSCzaQ2rB/sN/PXQ8pG2ToSB2Em6Tw8CjbAqzJQIfCP0mvAybs3z0+GmI0dg5Vz+Wj6H6yYW7XXPL8OgoPG4nc33xwVKh+Rb71Sn1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by MAXPR01MB4456.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:07:19 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 14:07:19 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: mchehab@kernel.org,
	kieran.bingham@ideasonboard.com
Cc: bhavin.sharma@siliconsignals.io,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: adv7180: Fix cppcheck errors
Date: Tue,  2 Jan 2024 19:36:40 +0530
Message-Id: <20240102140641.1740275-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|MAXPR01MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4258bd-f4d0-4bb0-2e4f-08dc0b9c21f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NoizWol0sxJALPyvQKKv2xgk35v7/0y3oKW3F3X6bsgR5HzX08MKs+Y7B9TS0DWUWt4QOiftbf0m5L8aMslPOuji7Et2dg7rEf4r1IhOpPV7PXff5JlOvQUR0BQ2F1mrpyv3beFHRcPPEYL2xO64dvUnQESiwRDbpuvAo9pSWUzFXBxvbV6p15K0738rjQLuxh9Zpe8ItYzGDgrsMSUYRW9MPFx5mpavg5QF+ytktKyIqALFTpvCJ5WEIagiewU+hufpaQC0kd//43jHEv52UPd8v+5H3ztLfG9cbdP7/fVlX23FuA8AamRT8daUDfASdfE15HWLj3x78uU0sUlX6+EHwl9nRax3Lkp5zJypaeNGWJzPHqHsw57GFF7rT+2hc/CVeScRCoWMj7iOTiVqKmC+q2gAUD56DDlXYRmvFkc2xWHq4NSfu23gPpHR2mkOCEIli07sbO81O/t4VbyJNwnReDqI3Cz8OwoK5Yx1ifd03joXO1OtdarBfqtEjxK8R8eqvNvgutGjTpfeEEwCK9P+jOlBJyeR/Zq1fvQV3SvH9Zyq+Rj93vbq0jiffClXfN+6mRe8/3pxQ3M+YT5TFeJtcar8cLQGBz6Go/vimMbHYhbmZjIME3VdSTPDjdMO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(2616005)(26005)(1076003)(4744005)(38100700002)(41300700001)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(6666004)(44832011)(478600001)(6506007)(6512007)(52116002)(66556008)(66946007)(6486002)(66476007)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2p1wZYvMQQL+x3BUJWqt+DxxrGRNkoPxNjK78K42jXDCjLzdNftFsorft7aD?=
 =?us-ascii?Q?/ipDAo8L3erN/uf5RNTaYsAdzhjn3hut6InGSsaczxMP9lAW2iZDKo33H4bY?=
 =?us-ascii?Q?2aayB7Mbh9MU/yMaNVE9Irx2FSeHGzCTKZ6eDA9nuXHVZJ7kQkaY6afpZPcP?=
 =?us-ascii?Q?s8O+iyZ+yh+8ufEVAJBQ4d3ZpXksQlvWIn2QkuNcxLNGvzv3C3ZlQokwBHzB?=
 =?us-ascii?Q?RtRMjbAPduAiJKO/5pxPbg2X0WcBqbElxSY6l3UiYaL+pI7gKeAap7VvAAu9?=
 =?us-ascii?Q?QDAOuWh9vXsbWWZM6IYTkirwaUn8b0dGMm4/y9momFUC+4QNb1adoiCdx+uz?=
 =?us-ascii?Q?aCxvlEZ3BUWL81BnlIbGUGw7cigOLLgFBEhQUfuTcRlxInru5Ui2JKeK2Q+Z?=
 =?us-ascii?Q?IzcxTpV1EcuPZk9+RxfdJU/aGVpahrWPtpeL+U/Mr0tE/9x3gy1mjpCovJ2B?=
 =?us-ascii?Q?IQV0xsHDsDtKzooXhhnkGWz1uiZIz7MQrKE3SHOnx/Zei/IUnQFY2F7vDqrb?=
 =?us-ascii?Q?mtIA98IEBlgqWWRYpsTrxxMSCZTGQb3BCoqf2Slos/sCjMNbRAjMu3gbjtS/?=
 =?us-ascii?Q?5eVI9V85GOrZktQJ3D+4fq9/xpnaSK0JWGmxgnVz9VuxmhRt9Hn+/pWfpPL/?=
 =?us-ascii?Q?oXJBuwjUHl93Sbml2dsekaS/f79tLnq3rTFj4Di1Vqx7ijRuIx33B61CqsY1?=
 =?us-ascii?Q?RIYpW7uGGXXpT1J1d2blGckvk2eL83yFEVl+tgpQvSWFVrUDNhETclVWly3w?=
 =?us-ascii?Q?zWl30qUsWgQVhdmM7jsQZPa0i6MbcWyPUuCFxHT5R2CTI4AiCrds55a4Td2B?=
 =?us-ascii?Q?wtQGXKVHZ7OyhAJH/IP1dmY9cdiUBrt9A75zE12e6fxy0FBDkknExCQaykrR?=
 =?us-ascii?Q?N+wV1Uo9FUHcQp6wyFhehQnH4gz3ffIVAG+2bM2+dV3W8t5DMTjREsvwvyzx?=
 =?us-ascii?Q?zp6bk8fif0QICP1+j/WpjARNL1dgjCaJZiiHtpligGAXU5dwBRRN8mSV89DA?=
 =?us-ascii?Q?B9nrCIMdOm8YgeRPLuw80+34Jf0vkU/9zdg2ERVLgUOilusb/qfv360Grhk+?=
 =?us-ascii?Q?hCvZDOy+oNz+sonBymPweEt4ixvekJcumzAfZSJw3RBwQCCcYvFKQHo8lyUr?=
 =?us-ascii?Q?T8Jj37XHuueKdH6V/rzW9fLVDAJo+gIFBbg4BcRPEEB0ydIVPaXloOxKZyet?=
 =?us-ascii?Q?DmOtL0voVhsI6mTjQGD1h3HLHU54/3fM7/5n9/ItdRer023iN+hHCfrUh2jt?=
 =?us-ascii?Q?tD5Go+wgRkhreXklCbFFv72KbkvUcxqpWeAXmz1Ufjrcf2ml4r6OhO9q0e6R?=
 =?us-ascii?Q?MIwoc5hP22DCxmZ/UNjZW4+RNwZAzTMGc3qm27AYjKvu9QBnJ4hmnUqWKz02?=
 =?us-ascii?Q?rNGkE3rs2lvqNMMXw13Eehu2zVQkss/Toqp+GuAVMTm2wJ8NFzowuXImGp9P?=
 =?us-ascii?Q?/g2cH3TfPVwY5w5X1UJRyqoopvyXDPo3KLWaZ2DbyXStsjVk35ovc4TfLUcQ?=
 =?us-ascii?Q?RDan+xVFQt4nmUFxxujzqWOxguU/ECAfsa53UUdtxfeYiv+YihcqMtUYv0U5?=
 =?us-ascii?Q?/QZhFGCJPU+heN0+tQhE/fMBELot58kupu1nf4kp7xt49i9pxjP5Tw06awiU?=
 =?us-ascii?Q?CBnBPj71PGhB8aTqOYqoKDI=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4258bd-f4d0-4bb0-2e4f-08dc0b9c21f5
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:07:19.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wg6/FQOQi6Q25QrFP78ng2mBv/COqdJkanodAaEtXoooA9eKI4AUOFGDPWGDbjsyc4XqX3jDSvldgMk50ub9GwgmLzIFiHEr8SZGK5FmOWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4456

ERROR: else should follow close brace '}'

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 drivers/media/i2c/adv7180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 54134473186b..e3b59f7e2a2a 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -1046,11 +1046,11 @@ static int adv7182_init(struct adv7180_state *state)
 					      ADV7180_REG_EXTENDED_OUTPUT_CONTROL,
 					      0x17);
 			}
-		}
-		else
+		} else {
 			adv7180_write(state,
 				      ADV7180_REG_EXTENDED_OUTPUT_CONTROL,
 				      0x07);
+		}
 		adv7180_write(state, ADV7180_REG_OUTPUT_CONTROL, 0x0c);
 		adv7180_write(state, ADV7180_REG_CTRL_2, 0x40);
 	}
-- 
2.25.1


