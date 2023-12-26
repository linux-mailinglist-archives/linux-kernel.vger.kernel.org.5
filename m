Return-Path: <linux-kernel+bounces-11610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E081E8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194421F21AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F854657;
	Tue, 26 Dec 2023 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Rya8mZ8E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A1539E6;
	Tue, 26 Dec 2023 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c94ZS86juuvQekjn0TIiV6gQjrolYRCfnEB4AZElGHhRZgImHDJI5Bm6rSMueA7oosvvxVRz4ZPE1X6VeMShOZ2KOKgTUgBRJUQhghBTHRSzl+hM25ZmCDbktfMs21tlbstWPJhA0cgUje7Xxzb5UZYMYvLmb2p3FZiLD+dJ/q3JGGPuTgKwpk2hyYc3+Dpah/hHvwla4xjiNWNtDwkMh/LO9UYBNRrV4Dp2nmd3j0tDVv0CFpy+ufp5YkARt2WcuVhLifusnfHxV9sq9vxNeQT7uiDDCta58unNSQ0jF8GTdckTpC1B0GYlKtw3Q1899P3ErZ64uGzwlJKTOTrKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgihidoIwllAJimqo2qK13Sh2/qR4xr8ivY0OFkGmzw=;
 b=bWzFGXR1OOl9JHJAo/liLQd9RN9mwm6jK3KCon5zYuhVTdUIvY1t4bsKuBAHu0rT+gXyV1YKGgmXOpcKmojjvblNVjTANm23PAr9BVhZxB3dnC9ZVaeF0mZkjZPZHRvWNZSAWW+LgIoBYCVcONHjWBeaHG0aZ0d491RCFpQvTSNPUhgZaKXhj+NUBB52XPQujM6ZERdRtmgjBehPBlBGZ4XnrEEwAVazYZ8McxOIY/2Ui+OUx6OkRBu7cplxdlmi1dEzW5pd0ZiZpmq5/WzkV6URCv7t23vWHgL20QZRcMHd4UBlcV37WEwvxk+K7QJ4+hjWA8FwoIogTvdNe75dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgihidoIwllAJimqo2qK13Sh2/qR4xr8ivY0OFkGmzw=;
 b=Rya8mZ8EiE5Hvm7BRaPOW9vI5Kh0Kmydh0JUua4U5P6avkoPKQmG2yE1wPOa8RW0WNmrcuGrIZsIyOP07BG2Ak7pZTZIC15+1PfCxt0Dlu58ANYfPO6god8HVulsFEg2Tp2YGAyI1cWEHl1m9b7Mc89Up61gC3fqIzJmk2cBWbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9868.eurprd04.prod.outlook.com (2603:10a6:10:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 18:11:52 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 18:11:52 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 26 Dec 2023 19:11:33 +0100
Subject: [PATCH v3 2/8] dt-bindings: marvell: a38x: add solidrun armada 385
 clearfog gtr boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-2-fd1ac2d6bf2e@solid-run.com>
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
In-Reply-To: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB9868:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7b62dc-0a5c-4ce6-9e3e-08dc063e22c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jiTagE62nsXGerFQP4EtpgEqtP+tFuQv59vpcfzwH+MfVXwtzeA4hmCE5GGHYlVb7rlxMMmr2SSAH324CjrwZiZaAo5Jfz3YcPkyW71c82E3GDgU/EgeP5c+ozlgakaFM5wO1EQRNDgbegOC2//MeUsW0mEzWNdrkf2u5ZfAuSj+q6QxY3ZTyefNPsI1lD6iE+oPHBJAjO00uc+k965YKUA3mo2lVwcYOo/BnFyrsuw9P2IeXcaBt72ArFOWvGXxjhq2G1BHdpgjaKKojEUQyuP+F59JiXScfMLiumgfQKx2ZEyjAWvmRLgCbBcSCVLuSxMaZlmjt7Grd+P9CtsOWOSnRMSjBOp0PHUbjOzkRdfgkovYcEUlgDnnMeTDphkxZGI21YPLou5wSyz4rd46I2UpJmZ32jvb+2di6BLT0VYilFoZUFdw1peknk3hZ3p+nW88jgU6pGIZzSSU2CcE3gA7dB2UcvsofaX/wkg6tp8cVgXQEfXxmeNGLqqb8EVyjVV52fnwozmmHAOd+jOdpsTrToER8MSKlKTVihzHLpfnyTOf+PwahNbwEEDLMjIyMmnNLwmlktIK0u3OBShSKW7ozZx1zcchTZJge8fazzPCKBz10PDi33vIxj5SAWax
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNKUXlhb2xOQzNLVU5vbHJxSERxaC9SbXYyQTdUZGdPZW1NYlVTNFowTW1m?=
 =?utf-8?B?WlNYTkc0bjBHeTQ0RWRYY2VQaDBoZjUxM1VlN1RERDI1WFFxS2l6TVM1dnV5?=
 =?utf-8?B?MXFnVUo4K1c5MDNNMUtwRjBBazJJZFd0SHFjcXFxa0RPVVd3b1hrYmdqRUFp?=
 =?utf-8?B?b3hETHNVc1B4RlVOQys2Q3lOd2ZQeC9LOUVsdGdwYmZIVDFaWHdLeWJxcEpj?=
 =?utf-8?B?SmxVRU9hUnNIWVQrc2VrcGUvV3BRZ0FVSEpCNlB5U2NYWXBsbHJvR2IvbWlI?=
 =?utf-8?B?RHl0R2I2a0ZCVWt6cnJESGFvbWtZSXBkT0JLdGs3bHVZcXlPZzFVZGdiakdr?=
 =?utf-8?B?UmkrMEpyRHRzR2NUbVNEQmtNTzdaMVgyeEk0cENWU1A5eTI2Z25vc1Zqcm05?=
 =?utf-8?B?T2QzR0FucTQwY0lyMTdxM0dtVlRhOU1JL3JxZGhuaUtqM1RZYnE4M1NXNWFT?=
 =?utf-8?B?REdJQXNwbEtaSkhGdFc1TkRkQWwvVzB1RGxkY0MvL040cE5UVTF2dm1acFZV?=
 =?utf-8?B?Y0Q1anpmbWpiWWdQOFBoQUpvYjRXemFsSWhhUFpFMXUrWEtFbW90MXVnbUdP?=
 =?utf-8?B?eEtObVBoRnB4L3Y4YVZjL3JwM1dMU0tFQmdSbUtZc3J2aXZ2ZFFGTkJNTXBY?=
 =?utf-8?B?VTNZQlpNd2pDdjJ4NUJQZEdUVStjUDQwSzVHdDhEbjBIdVhWRzRCd1RqV3FF?=
 =?utf-8?B?d0NqV0NYaGpvV2FtZ2lwdlExOW8yeVRFOTZMTjV0amozdXVjSFlDclAxQTJY?=
 =?utf-8?B?NVVmQ1FHclYyWTVoK3lkNmdYdjc5dDJaSnE1K2sxQXdadUxRaUNUZmV2bXFE?=
 =?utf-8?B?SjJwRXdEQ1ZpSG84Qm9CZzhWT25IQ2VnTU1sWUEyc1lPd0w0aDdrT2lhS0hQ?=
 =?utf-8?B?SGJUSm1yTjk5N29UUHBJR2hNZUdmNnJmREhWc3NpMnhGbUQ1YW12cjE3VWJh?=
 =?utf-8?B?SGF0NzBPUDBGeTVOY2c0M2E5aHdvelhtZkkvendlN3BSVVJSRzlXQUJaVTRG?=
 =?utf-8?B?QnpNbnN6RWowYjBTNlJ4N1JRNGoyaTNiT01JS2o3OUw3WkRqbjZjaWd2dzVL?=
 =?utf-8?B?aHpMMDFUMjFGc3pscjRYdE5OTjJQSyt2b2p1anF0ZGRqUThVT0NqTTZOYlFS?=
 =?utf-8?B?M2xmWTdMRERacmRPU0dDWWM3eXZ4SVcwR0hqZ0U4eTR3aStOaXU0NllvODZT?=
 =?utf-8?B?Ym9CaXRsMWFqNTJCNGFCNjE1ckZWQkJOeHhUUzdLK0lFYWhtQlZzVGZDTTNs?=
 =?utf-8?B?U0Nka3JoVFVXc0dvOTRYd3F2ajJZM1pVQWd0aHMvY0Z2dHhQWG4yWFpadVRT?=
 =?utf-8?B?Y0dsYlZDL1k1d1ZVV3ExTTQvSHhNWEorNWdtOVJYZ1doaldKb2xpdWxITnhW?=
 =?utf-8?B?YW9hTXRyQ2psb1N3ZTZ3WjJoblo0VTB0YUtDVENjV3kzN1p1V2ZubFNKR3F2?=
 =?utf-8?B?WUZ5TWNHQlowaGxXQ3hNYVlIYWNhV09vRE5LSnJveVpPKzRhcHJnUkNMNWxz?=
 =?utf-8?B?KzBlUnZLQk1nZ2lXZWJvNm0rOGNaamNCTktiMk82Q2ZIUHFpdlN1eDQrUDdF?=
 =?utf-8?B?dHNNMFFPcS9MUFJmMTlGM2xhczZtUHFweFFzUjR6dm9RTnI0bm1VV2lPWklO?=
 =?utf-8?B?ekJ4YlZsRDF1STg0UEk3VklxRGd3bndQVnIvL3JNcS9JV3BtakxPRGZhRm9Q?=
 =?utf-8?B?SDYrc1hiWTYrT0JNQUk3ZU91cmdsanBGNGxuNGFzNy9ROHRiL1FzZW1hUXo2?=
 =?utf-8?B?SmM4QnF4d3BkZWNDd3RzQko5c094TlBHTThnOEFwRW43amJzU3RMUXc0dG42?=
 =?utf-8?B?Rmk2N1lVZVdtRFplOVAwVzRmcUNtVFlYeWcyU3laSlZFemR1bHRGNHhJU2pC?=
 =?utf-8?B?UmxTaG1TTEZjUWpBbkY0TVQ1KzN6THJJT1VKdkV4enNPcXl2TlUwT1pKMUN5?=
 =?utf-8?B?QVdDbGF0a2tNUkhOd2lVK3M0NXh4V1RUaHhQU3dsaERrRFE1YjVvWG5VMmpR?=
 =?utf-8?B?cU1ZQ2VOWG9tc2Y3TmVQRlBIekErQ3EybWM0OUd0L0VCOGdHYW1JRnA1VXVy?=
 =?utf-8?B?aEhQNk5IYTI3VmYrUE4yUmJZTUU2cU5CL2NJRVNmMVo0VkprSUh5WXFNR2hP?=
 =?utf-8?Q?L7qg99wguBmGeaQYzfUQtxXmr?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7b62dc-0a5c-4ce6-9e3e-08dc063e22c5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:52.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwsIlK/YoXC4PSMf0iuRtuc4x587Wv0sy7UERpdl9wD7AHWA9GuoE9GY05UvvCOYk+fQvBdGC0SvoQaqcYP/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

Add DT compatible for SolidRun Armada-385 based Clearfog GTR L8 and S4
boards.

Despite similar name these two boards are designed differently from the
armada 388 clearfog base and pro, they only share a name and general use
case.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index 5af222e6db18..5bc69c4fe34d 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -30,4 +30,12 @@ properties:
           - const: marvell,armada385
           - const: marvell,armada380
 
+      - description: SolidRun Armada 385 based single-board computers
+        items:
+          - enum:
+             - solidrun,clearfog-gtr-l8
+             - solidrun,clearfog-gtr-s4
+          - const: marvell,armada385
+          - const: marvell,armada380
+
 additionalProperties: true

-- 
2.35.3


