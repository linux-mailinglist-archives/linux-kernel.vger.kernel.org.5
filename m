Return-Path: <linux-kernel+bounces-13465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D08206F6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8740B2820C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8DDDA9;
	Sat, 30 Dec 2023 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hbWHH3NN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4FBA29;
	Sat, 30 Dec 2023 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj6h4ikFdJaG3dnpIYX/Ct78a15nzIh256vSxLpWKEIzNHi3dTBsiQmrSg26b1MbzY3UNP7KkbbAFjEF7Kik0pjYjSbskbPHcZjci4JgmRwQsPO/Jce5xUx8JLz2q+RCBJR1bMnieFNQOh7wVp1j6c7RafUTkpnbFPwtfjbZX7BEccXUhyVupqI0EXowyhddcJRauurPrEw0f0yBPVdA3wpgJzYp8wpxd9accVfZCraxaTOngHjd14b2+tN2FiLWybcKXQHxSHmm3E65YxCVVXF8as5xtOaKRDzkTtIuoA29+Ay7jiCzsMRZ32RVICYhugIvircX/v9fc9Ehkrov8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1NsaxaShk3jcZW2dEcpiSOjsTZyOZyG+OapyaxdmG0=;
 b=ghHXSK4yS3n6PJMybfT60raiVURjAqRPY9jlHoVpupeGxvO+UjDQEeiGZh4ofuBBtdtaiRzu7fZVU8vdKX57r4rPQ/Tf+ULPb0pY+U4wGpq44A7XtIHViVslJT11Z3GWvwVgrRYqBGRBspxRgTEGZGXrB0mmyVybMr60S4dB3JaFbvnXsKGEaBv7sUgFWXUZaiex2Ra8n3HRoupQeiFEHEIMd93oLyny2IyQ14y8SMQl8rTEGw7p5pYDli/KS98GydJHbYoEiIOb8/9xQ+yV9Y3r8rmlnxS6llpMGPV4gRqVPpf6coUhru8L7OY5CTyv6O8esTTrtt8XF/znl/ZG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1NsaxaShk3jcZW2dEcpiSOjsTZyOZyG+OapyaxdmG0=;
 b=hbWHH3NN95jTAMXNd21iRTktelOVbtfERcUD7GLTqMnIJVyDclIl66G2kgCsNmq+AK7RESHdh4En/qdhsdcCTudiBBxPllCSCK5hzXptBmc6mlT+Qy2NCy+awxbmMab91WVGqsvfyHz3p0IAIpvy12Vk44OclV+r4OqMigkXja4=
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
Date: Sat, 30 Dec 2023 16:44:37 +0100
Subject: [PATCH v4 03/11] dt-bindings: marvell: a38x: add solidrun armada
 388 clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-3-1d7f0e2c7128@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3b3d1e7-e6fb-4128-cd18-08dc094e400c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nagR5ghT+StBqeH2p5xHcvTonkJPVjjWOaW26GJbTKRDbSyr9Y9Po7n+XD5TQ7ovopvbpK9puDOyN8fYkyZbNPFTBxl1a3EevAMlA0o4w16XgCu5ULWA+qpjwiKnWossBFIIY20YCERTdZbzHgXSEIfCrK/Mb6/p7iD0w3V1qbYiLcHuLRlryjUD2qARph8zXNusZNex6JAu1knPs/0kfchBKHOrOrTmYkHxSYX+ycST3DCn9cYgLMy5sLJQ/2eHZMgwc/qp1gncgfyjlpyTRAF7pdo9iifk2Wy8s7AqkJE8hNaCw6W1IGOowUXv/ohe5KksrWLnVu5F6BQbkuDo/t2lm2s6MaUEu3S2PG1SRrtCHOkXWd36G1iqMxa/INAssyl043D2TRiOHwC8C6NBhfbAFLVGlSNJQF3Hu7lwU6GGBUzpsD7GKsMXJhh9BCdDU/65g2l1k+VhMxe+GbzHiEB2NCqr+pCC8eCbTxWodAUdywlC6UEKsBgB3NgRu9/8vHWNWlNxF3uTBOKqSJGoynpPWv5afhHJ+Oj0CEL5VNv7G+s7EnoCq/6h6oygofoFA0Ja9Vxe+AQy1SiPgixIQfbvsNclzXnqf8j+qtyqLnnxnZscmHKzJBo/IYY7D0um
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(83380400001)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWdXbkdRNnoza1YzV0wxUHFyM0ttQ1J5WmpTblY5eGdnQmp4Z1A4T1prRjlw?=
 =?utf-8?B?WUdNemxkdDIwbEVSUEhWQWN3bGRFcU5UbVNoY1h1RCtnOFA0UXE4NTNvNXRY?=
 =?utf-8?B?SnFsempIUHQ5Z3lNMnBsaWJqVVlaK2x5Q3FORDAyQjlpQlFsQUE4ZXhoUzlC?=
 =?utf-8?B?OUZIUnZEaEZQaG5WR0Zrd054ZW82RGUwYTBhTU5XZElZckhwUGxHT1NpMklF?=
 =?utf-8?B?MnJVdHVrQWFKTjdqdDRLa2tPRlorMDZlVXBJSDZ4Z3hvaTUyaGx6eHhlbHI4?=
 =?utf-8?B?TnRlcCtwS2hRSC9naGQvaTZhM1ZFbUxDdjlCbmdDbUpCVnE3V216SlhDWWho?=
 =?utf-8?B?bTRWUkVZWmg2blZuSWN6QkdNWnd3dW9VazNFTlJZSkZMd3lIc0pLTVplM2tQ?=
 =?utf-8?B?Wkcrdkg5VEdNSERoR3hyb2pNZ3ZjZStQYUQxU1JzTXVIZm5VbFBXN3NjLzBp?=
 =?utf-8?B?MEVKNkZxTVNqNU5CQ3picjM5cmQrV1Z3ZHVteXd1OG9nYWhVZjl6cU0xdDRi?=
 =?utf-8?B?elY1VG5wM2cvejdGcVFIbUpVc01qV25QN01wMU5nN1hhZE5tTWsza1ZFZUtk?=
 =?utf-8?B?UnU3TXRibEtHazhuMjZoc04wUEcxeWNkVGNLelVkcEVIeVZPMG5xRVdTbGZO?=
 =?utf-8?B?RmtaaGRGYkRMeTRPMFVGYm9Va2NHQlE0MzNTZFAySXpkUHRueGwxNS9JZDBN?=
 =?utf-8?B?cFBxZkhtZGFMbURxajZUV1JNNk9tMHN0Wk01dnB0S2RrV2lPNEx1L3hmK24y?=
 =?utf-8?B?WFZ0OFpRbG5LZGhCbGtFRlUrSlE4M0hIRkFsMHNDeHpVRjBOVlhJckFmMUxS?=
 =?utf-8?B?NkRieFh5bnJoTHRTNzBMVDRpdVRLTUp3TTh4eVhJQWdJakZOZ2tEbng0Sjgy?=
 =?utf-8?B?QWRkbFRhUE8vVko1dVdPUjlkamNTdXJHeXhlbkFlaGh0Kzhvd1pBWDAwYnJo?=
 =?utf-8?B?SmZKbXQ4eGFTTTJpMkNqZGVqNGVYMUl6eWxXYkJBVFdyRDFTek1Ma0Ixc1lS?=
 =?utf-8?B?S3JhcmZhVlZ2N1cwMmRzSWpWUjV0QjBtREJ0Y0ExRStmRDdTY2hYZmpVUm5a?=
 =?utf-8?B?dkFvaWNMbmRIZ3NLazJuWU9Ya2tEZ3FjSzJQQ0dDYzRGbmdvc3lIUGF3cmZU?=
 =?utf-8?B?TURVeC9WOCt2NFI3YmozUVV1TEd0ODhrM2JTTlhWRExxbWswV1J3OFE0Wm8x?=
 =?utf-8?B?Uy8wRm4vOVBJY0NXOTdZazBGRDY1VVhqRmxqUHBTeUUydTJ3aE82dHgxNFpV?=
 =?utf-8?B?V0dDcnlVeXZkN1hMcDdwQnBkUkU5MXM2eGpQdzAvTURrd280YnVpZUNRMTFw?=
 =?utf-8?B?cHBGQ3JOelNtdnJxUEFGaXd6c09ISXNGN0tOQnk5Zm85M2c4TlJiZUgzZ3ZK?=
 =?utf-8?B?OXJmRGpseDdReUtDckxYczBIOHR3TVl2YXpOMU1GVzRRL1NMUEpnZHo1ZmRY?=
 =?utf-8?B?anB3Qi9pRzVkZXRZb0tmQURuZEhLTnFXS3kvYzVMUnN1RCtVMFppQXd6d0o4?=
 =?utf-8?B?N3cvK2NGYlZFdGNaVVV2WmlOazJ3Zk1FbVNDOUdTRm9qUUxGYUJIUnI4VjdW?=
 =?utf-8?B?NFl3d21HQTh5N3JnTnV4azVlKzg1ZjJUbDB2dGd5VDdNM0FwU1h2MWZiU09P?=
 =?utf-8?B?VGhUakpqVHhVb3lacnpUaU1NZktUQnBORUhVNzVWT3ZGNEJ2d3VOVHZuWGRz?=
 =?utf-8?B?dGxhQTd5WkJMNHFwQ2tiOHNpemx6emRHRkdXVXlscmx1L2UwcldXOUdCL3lV?=
 =?utf-8?B?d3MxYkZVMjBwNHU3VG9WZ1BDUjg1N0h0UGtUNlNVd0k5eUJwc09pdlJ3Mjlr?=
 =?utf-8?B?aEMvbGw4RDVEQ0E4dzBiSEtKL0FSd25JTFhrSGROeCtkNjd1cjZBYkhVV3VX?=
 =?utf-8?B?SGVWR0hOdTJnVnJHM2VZZllDSERXZHJwdGowaE1IekNjSFlBbkFNM1hEb1JU?=
 =?utf-8?B?bTNQWDlNZ0ZKN2lWalVTREpMQkxwVk5PdTVyL2VuWjdxTmx5bFlLQ2J0TjVh?=
 =?utf-8?B?Wm5NTDh0b2UwdmlKS1pvN0J5eVdNVDZ0Njdybjh4cGRvSUJsM2crbGIwbHp4?=
 =?utf-8?B?THFhWnB0RDI0dlZ1WDAzWlZVeFZ5L0MrZ0tvaXludkhDc3IraVBud1EvWWZh?=
 =?utf-8?Q?5KSMwT0pm1mI2noqZmWOuMe/n?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b3d1e7-e6fb-4128-cd18-08dc094e400c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:46.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyr68PnqPG7acckPG5nAbM+YRrYDBr8pPtDPAIk2Gq3VYmQ7qeY6CoFpeKwGdwfIMAKjWL0cDJ8016HWvsPSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Add DT compatible for SolidRun Armada-388 based Clearfog Base and Pro
boards, which are already in place in-tree.

There are already 3 distinct dts in tree for these *two* boards,
declaring particular compatible strings:
- armada-388-clearfog.dts:
  compatible = "solidrun,clearfog-a1", "marvell,armada388",
               "marvell,armada385, "marvell,armada380";
- armada-388-clearfog-base.dts:
  compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
               "marvell,armada388", "marvell,armada385,
               "marvell,armada380";
- armada-388-clearfog-pro.dts:
  compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
               "marvell,armada388", "marvell,armada385,
               "marvell,armada380";

This has historic reasons, the first entry is a legacy name for the
"pro" version, old versions of u-boot built when only one variant
existed explicitly boot by this name.

Note that both compatibles and model field include the string "A1".
At least up to revision 2.0 of the board, this had been printed
on the pcb. However in marketing material and conversations it is
usually omitted. "Clearfog Pro" and "Clearfog Pro A1" always mean
exactly the same product.

Technically Base and Pro variants are similar enough that they can
successfully boot with each other's dts. Hence it makes (some)
sense for them to share the "clearfog-a1" compatible.

Add bindings for the explicit variants including base / pro suffix.
The legacy "armada-388-clearfog.dts" is not supported by these
bindings" as it does not make sense having two bindings for one board.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/arm/marvell/armada-38x.yaml       | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index 5af222e6db18..4950b840bf1c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -15,17 +15,14 @@ properties:
   compatible:
     oneOf:
 
-      - description: Armada 380 SoC
-        items:
-          - const: marvell,armada380
-
-      - description: Armada 385 SoC
-        items:
-          - const: marvell,armada385
-          - const: marvell,armada380
+      - description:
+          SolidRun Armada 388 clearfog family single-board computers.
 
-      - description: Armada 388 SoC
         items:
+          - enum:
+              - solidrun,clearfog-base-a1
+              - solidrun,clearfog-pro-a1
+          - const: solidrun,clearfog-a1
           - const: marvell,armada388
           - const: marvell,armada385
           - const: marvell,armada380

-- 
2.35.3


