Return-Path: <linux-kernel+bounces-13467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94058206F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0938D1C20BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1857FBEA;
	Sat, 30 Dec 2023 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XpiT/vtR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4708BE5D;
	Sat, 30 Dec 2023 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdv9IGQbgckmaVSGev3IuFFbU91RvJCzNgdfbo1LPdp9+1M7U//ElAYrMQpEw6CZFLYgPnN3sjGlbYhSE1bfhTUdezTXzclx7JQkJtFDhEEXJU9EZA06ff6VXF6CqY4QZamq3Ml3pL9XtIPGG0r0U3qsLuM9KZK6GKBKVlL6ObT2z1nay1SfoqsYTOE/tSr+OHnKBqzJB+r/BJAlcLp46tDCMFf1SWE43K7tSHxJPgUwp05o7Oei5DRWLYNsdBB+xUeoyOFJ/ErhMaAsthZIQo8CWCw1AZ1niSXMiCxj+gVotSirOB2xD/CF+uoqZDFzqHXyGyMqdk3ER2678SB/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu04XV/ylszVjjWQoKVFc+oz3Td7o5ptS1DQUoTvhq0=;
 b=RkEf1CfQXanUTcuBvYfFixNEQc8X9A2v7bc1iZFom0nWT0dCJQJwomkoj75gksy0E5UNKfSFqVflF11VaNYT5wXqhqSMJJMAXKtYvQdZ68Mzwzthun/+27X9lSNLR7AfYh31ff3UeNAfRKxf5lmdLBnwdcVEXhbZHIY8k3xBhKHn6UEQJHCnTrRF2jLROK4Eun6O171PlRKWtON8811Lwa+7q8q3hnCjHbLB7lQRrRPl3d74aRFtQfhGG4asHVdMCTxINR1m5tb5JyBRoTtZjemzRU4UPJArMbyjqRR9Ljrowls4gVkpEdhmKRTWA16bcqVQMjbPxwryOio9uqHRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu04XV/ylszVjjWQoKVFc+oz3Td7o5ptS1DQUoTvhq0=;
 b=XpiT/vtRd+O+ZYt2MFVR4RybW81GJ5Ke8DIzckbmWw9Wp01DLXJCzs+BjL1Ir6nujLJ5f0vkNk0/E6ZM21HEZ7VFlq12MYpShE9KV/XcFEpvyth6+mp+9G6TGny3OI+EI6bwlDqHmoiaecRuiQ/BgrrR3/HzLwWGhAUr4SXwkE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 15:44:47 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:47 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:38 +0100
Subject: [PATCH v4 04/11] dt-bindings: marvell: a38x: add kobol helios-4
 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-4-1d7f0e2c7128@solid-run.com>
References: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
In-Reply-To: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f57403-8136-46cc-8fab-08dc094e404f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BdI6TyX5rcldBi81cTEpNfFPaGtKqlMCAasAq0F1MLnGBhBeigG9AWynepBQKedgeQmr+EGShrS0Pv2nb0CQTlYvR73hnC3bFwcMOaYit46/7WHeIV51U1NwKzxyG+zS+Iyh8MwLOlmyY1FZeKKXG7tI36y01seF1H6tHyWgffixoH63PdcIdZ6YeoysrucBXHKF7/2bUK4+Q4aI3iwX02yr1QAtvUnaZ9Ot7mmYchrLFWZmgsaPgWZxKyUhYlzCtmknM09TIapbM69YoJClsNxEu0vyJQ3+Boz27JcVkclMVveATIZzqVHvGOFCJnkQYrYrNjrv6q+fZqiHhE0hm7uZ4SbvAX2BUKw9T9qdoAwqZ6D+NNIWngdGgaLpJ/uHdcFfUDAWjFqYfMXGMdm4/QeCl8877PYBvjmt3Z06pV7JXdiFRx5oaDy1SFpK57Y76LtO3rUc9qkTIiijzkZynNkSukMA5f2w+YZVVC8/y9UqkBUAvpFDMz4WtYXHZlM300GTzPDYqHTofbJKBO6gG5yzfMsIhNnbhIQuM/9jYn+EggPQqrZ49xn7Yvn22aKu59LmEeno6Mc0ngCYrhh4rMF1WdTuV2EOIrK3m/3AsZRdcsOqvSHyJHmCuenJ1ogs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtWdExVK1hiVEhya3FFU0o3dFdhU3I3bkExaTR2ek41aXFWbGRnM2grankr?=
 =?utf-8?B?WGdidkJRejB0eDMxL2k4ZWlvUHJzOFBTUHpZZ1JaQmUwOXpDL2xmY1R4ejdv?=
 =?utf-8?B?RWx2YklyYzZjUVVlTjVyaWtZdGR5TS8vbkRyRkczQzF5MGQ0QTIyeWVxdEVq?=
 =?utf-8?B?Z1cxTEd3cDVOQURJMVNrMlh2ZXFXT0RSOUt6L3FDZk14dkU4bkcxZlJiSjUy?=
 =?utf-8?B?bHIvVDEvWTQyZXZwaGVGOEVtMEFvWDlOYWFwY21Rc2d3N3l0ZElxeWdRMkhl?=
 =?utf-8?B?V1VpQWFEYVdWU3F6eDFLOUhCd1QyZ3dOVXB0dW9YMWdRTXdZT1ZEeDdocVVK?=
 =?utf-8?B?OHRqNHloRzMzaEZSK1lGbTZHZXArWUR0am9CQUR6OCttc1Zkc2NaT29zYi9R?=
 =?utf-8?B?TEQrNGRDTVBtdnZBY2xvMzNXcnBqZVlYZ2NNUkl1MHpMOG9ERXVoREV0ejY4?=
 =?utf-8?B?cVZiSis0bDNSR1Z0S01tcU5hQVFHazJRUmFvc2ZuOE8zZkppcjczR0dQMnhC?=
 =?utf-8?B?Q3JRVXMxak1KV2l3ZmJGeE5uR1g2L0RVZHlQeUR4Qy84Uyt6V2ZOeWQyTWFZ?=
 =?utf-8?B?VzBLOHl3NXdYZW0yRUdFVStGRWdPRUw0WnZQYlkzK2hsSzY2WExjNUZHdlhY?=
 =?utf-8?B?NWxEM1ROQnVxeitWNVhNbTZBU09TVUw1QU1Ud1FXSkNIazJ2SkRrc2t6QVZ4?=
 =?utf-8?B?ZlRNY3h3N2MzakdRdERZQ0tKN0VYYU9FUWFjV3FqcXF4ai9idm1tdllvUGI3?=
 =?utf-8?B?N08vUlV3eVN2cnVuS0I5MGs1dndnWU42WnY3S1lVQlRHMGNlaUk1YUU1YkZE?=
 =?utf-8?B?SnBUWk93TXNwMUVYU1FxclNYTENvTTNSQk0vd3ZHUmQ2L0Y2bDRuR2U5M29q?=
 =?utf-8?B?WlB1RGhKUXJDbXUzRzZoVHBkVU9tVVo0L1JhNDBzMHhQcGVyS0V0dTI5Ky84?=
 =?utf-8?B?UVlMdFU0cTV6VWdKYndzL1Zzak8ydlQ1QmIwb2lEcjg1K1MvZFhoOG1OV1pa?=
 =?utf-8?B?M0dNNTFPV1dXVVhOMzJUN1VmazZNUFJLK0U4V3h2OUxTbXRJL3lYU3ZtMkdK?=
 =?utf-8?B?Uzh6cmw0VXYxZmpZT1R3WlVpb0piYkh0OWR2cXhnTDVJMjluV3VyMUUzTkVH?=
 =?utf-8?B?REMyQVNwVkhCT1VqMUMra0V4UEJzZUdkeXlXU05YMjdtNUttRXcxMVZLNzNK?=
 =?utf-8?B?Z0hDc1RqeklsaDFWaVMrK1hkcFUrWWlxZktZUkQ0ZU9vUEo5QjVkRlNsTnZ1?=
 =?utf-8?B?YkJQQVZEQ2oxRWpQSUxFKytmcFlZQ0dFc0had1MxUUFEc0tZczk0WDJtYjlz?=
 =?utf-8?B?M1dRUVB4VjgzTXM1bUtGM3IxakhMSUcrVVlkeEZNcXJOTnJYbUpsRG11dnVV?=
 =?utf-8?B?emV2REdqY0ZLc3djcnFHaXdRaWM0RmN3ZWVPcTdJUC9wUi8yVURROElyUlRU?=
 =?utf-8?B?UjdjRk0xWEJhK3BkTkJxM3BSdlN1MUVkRmNITURxdTJ1SjNTV0NoSktzaEZ2?=
 =?utf-8?B?ZmJHb2pwY0NEZUJ0dmpRNHFIb2JyVHRjdVJtQWJRcUt4aEh6L2pFZUIycVVL?=
 =?utf-8?B?VXYrN2F1NTBzU1ZKNE5CaVYydVRkN3RIMDF2RHJVdVFoWC9QK1RMK21kTFFY?=
 =?utf-8?B?VDBicHZyd0s4Q0JPNStxN1R6ektzekJORW4yQ01YTWFvaFVtU09JcHZWU216?=
 =?utf-8?B?S0IyMlI1UERDUDd4dkdCRUt2L1hncE5HUmtEa2FzRmdOODdoRzlFd1VoWTNH?=
 =?utf-8?B?RjNVWVdGUURIR3JrK2xWWlp4NHB6MHlvT1RHREFYTHhvWUNmRFV3Wkx0eEhJ?=
 =?utf-8?B?RzNnamZFSm9IWkVudkdWUkI2M1pFeDl3YnQvQnB6ME4vWnNvMFFjUEQ1cnNz?=
 =?utf-8?B?OGlYMlZzZGFzUUVPK0JaMDRBRUN5akFwY3FTaDFXWU1GOFUvT3BMd3RsazVG?=
 =?utf-8?B?RHpaWlZDL3FZUks5NFQ0dDVUZS9nWUFqMDFzY1gzS1BqS2Q5NmswZkFZZjlo?=
 =?utf-8?B?ODd1ZFZ6WGhlM3RhOGhWLzVqYktzeStLMnNmUFRnV1FsWmZQVUh4VVdWcEZN?=
 =?utf-8?B?d0UzeUJ6Y2hkd2RXQXpSOWYxQ2pqQjN6NlZFMmN4Y0hYemk4Mit2WUJpQk8r?=
 =?utf-8?Q?xCjwa8VoT6JpoPuIp7PvtLhaw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f57403-8136-46cc-8fab-08dc094e404f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:47.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knXBowN7G52UqGIiGO7NkdGb1Yaxbga5BMC1tR6hSn0t9VLrlLI56naEZo7Vs8pU0waQtZRiFHU9OpOSy2f6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Add DT compatible for the helios-4 nas by Kobol, which is already used
in-tree.

This product shares a common system on module with the solidrun armada
388 clearfog boards, however it is not easily described in a single
list due to their extra "solidrun,clearfog-a1" compatible string.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index 4950b840bf1c..3babda0d575f 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -15,6 +15,15 @@ properties:
   compatible:
     oneOf:
 
+      - description:
+          Kobol Armada 388 based helios nas.
+
+        items:
+          - const: kobol,helios4
+          - const: marvell,armada388
+          - const: marvell,armada385
+          - const: marvell,armada380
+
       - description:
           SolidRun Armada 388 clearfog family single-board computers.
 

-- 
2.35.3


