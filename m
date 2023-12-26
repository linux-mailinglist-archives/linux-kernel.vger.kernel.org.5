Return-Path: <linux-kernel+bounces-11609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB0F81E8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F58B1C20860
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26253E17;
	Tue, 26 Dec 2023 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rAocvrpa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14752F70;
	Tue, 26 Dec 2023 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgt6e9DkXO4h/ufQEfKrUXZ1FWFmXsVAQdIykupdQHDnqDzpHyvCsrz18VQsjNmKmpTRbMSDcdqURfAu4EOdN8YHT4h+jmPlKclLfSSwlfC9u0jTVluLTpzBQthJ06DDYzBxsRS/HMAlJ47Jlv5GpiiOJQXQ1YujMThZkNnoWx5v30Ks1oOaV5H7qqev4+42pRb97sllMH82pMEplSs6uSacb7mefX6uBiJqxnu67xySFQ2/wrTCjl5ygVSkwN2lzqIp3QBs950DcHrY0g/+9IkoZrpSppN1poJKvkMN9HP84l7SZ1Crls7vAxp3ZPBwYAdRU/2Mkn8U1nQlgjYi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhDSuGG9G9tKZc8hTeA5QnvBqci/AaN0HvDnH18r3ME=;
 b=iqPykhXFo3aKGbMWUjScTmCN+qLwVCgXbyJaYW49A1fsCDpgRkOI3a5OPGBmzIJCGLFwEh8Z69ob3TbAr+XyOjqe2IyKVbB+hZKTJkkfVXSRSMRZ7TC1mcryRzY9vPW2V5CGu33fVk1GmHOqB6V2JFLr8wSUt9Isbq0Wsm9WDAUm/QmUmqRXavr11HoKPcNjY/BJr8Zr1PNd/oVhaaav8Bpzr2sQ/WKbhA/OnJstjbpJ9y0bIfG4OPrbEO9Tqkxsfb9KJpcBctER8CXBbGVjI9xhLy2s/oCimg+eLFXuQNJ0zuRgQp+8uwMYySDgsizfyJHN2YZlN/K4rMukE/Yg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhDSuGG9G9tKZc8hTeA5QnvBqci/AaN0HvDnH18r3ME=;
 b=rAocvrpaN40uJCf+lVMhDtw8L2Ad49+jlu6P0Yy4zseSyNimXJdsERu6cy6nsEt95jqssgnsjL4WdQOmjQXDsfSKerdh9JU6uHwmqHDv8eA7PKkVLBRLrkdqWY8cPREIAjHTALnJYzfaSCPeLLhfIcN372nwWcEvIWhg1Ilwb/s=
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
Date: Tue, 26 Dec 2023 19:11:34 +0100
Subject: [PATCH v3 3/8] dt-bindings: marvell: a38x: add solidrun armada 388
 clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-3-fd1ac2d6bf2e@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26ea4e74-ebc0-4306-fd87-08dc063e2305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aQXLsQ7QYC14fYmXThADW765w9o0JUGixGkY5wRhPQDBob4ICP3KGVl+r7j3eq5qP1m92dOy9karjOVft9VUJuLHbIrzitdr6WvR3qpYNblFgEDrFT4/nnbIyw17vABcqn9zCAOQAdWwS0lUeNob1u5Op+uW4tb/W7AXxlQkB3yVQCXqghSY7yLv6SJzGk3LnuSAkfPJ+xEjUEIyPR9CXQAQSJejw6jlTDnj3M2ny2nevTXBndoXGAo5+HDeN3Lb5cWKAdtypMECutRPEK8t0/YXtOgQmLUW4UCM8ZJXSjhY25+J1vJqlY7UChORwXQgMpgrZWjBLYQyLllsm2xVzW1GseeTy+sbGYontrElDQiCLVrAHEZFSE7ndRV4Q/nkl7jOHapjlHR2rmYOxkGBsCbxf1zY9YUfbmHbrRE9+XUcuUWdtyS6e0igaxozf0ntBvsHzIaAyzlaCzGT5k9DJSrAEpBC2Q/NmKKQBp40ykfvGoynF3usKmdz2k240BZv+z6iEwa7+ziOZ/wVmij4SgyABoLXQoW+BxhMpqXAmkKCJvmnhAMWDKS5up3vk9HJU8U/Hth+uaw/3v93EddKPCzlnbM4h5XQbzQshB7n+YgZGHqvvYdjpTJ7DkktEDyy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d01heWd5VE56bkg4d1AyVUFWdVBBcUd2RHJxSXhCeWwwaTJkNHNNUkZJU05K?=
 =?utf-8?B?Q1BJUlBDM2VoNWpiODc2UGxqOUJUTHJCMVkyUDBXN0ZqdkQvMlVsajJnSXNw?=
 =?utf-8?B?ei81a2RJc0ZKUmduV2dQZWhTUVRJLzlZZzFxVm93aVowOFI2WUZxRWRPTDlG?=
 =?utf-8?B?REg4QkxBbkZqbVh5RVRkcUpNZVBBbUhyejYrckJ3cjJaMHJqd21CNkVxNmJK?=
 =?utf-8?B?SXN3M2RtSXRwZnY5T29JUGpvZ0NtOGZvcXZlZXBSQkxDUWIvY3FVdUNPL25z?=
 =?utf-8?B?ODJaWkJvU3ZOdkMxdlhKTnZER08wY1QrVVlGK3M5czJjSUcycTZBM24zeENR?=
 =?utf-8?B?WExWYWszMUY0K05MVjhLT1RIM0c5RmVjSEJXVDJ3bXh3YzlRZzNTWTlWV1Yr?=
 =?utf-8?B?L0gyOVR5V1AyeURhKytnSW1jRUswY3ZiV1QzL1oxOWt4MDNubm5uTVY4d0Zz?=
 =?utf-8?B?UmdmSUNlUFJnNWU0VG4wVzFSQjYwZloyQXNRbzBHTkpZU2hpaENyNEtwb0Zx?=
 =?utf-8?B?L1RyV2IvMC8wM2RzSzVWMC9ueWE5NEh3d2ltc0NrdUh5R2haMElGaStTMXo2?=
 =?utf-8?B?d1RJRGNDTUkzWnZmd3NPOGFTaW5Id3REM1dwNFd4NitmSHBESVI2ejlVWHJo?=
 =?utf-8?B?UWtQdklnUTRKWEZhWWxjbzF3Zk5VSWRhWmw3NXVuYUJuaU5pTGFtQk9Mdll4?=
 =?utf-8?B?bDFzb3ZIOE52U2FXNytrYzRMbUoxdXZqeG8xRlB6QkNsbG54NFNKc2cxdFhr?=
 =?utf-8?B?cytCemx1MFhHOWVGNExoSVBEajRtQS9OcHBBakxGd1l1UTVqMFhQeXJnYVov?=
 =?utf-8?B?YlB0cVpiZ2tHQytxNmRpRTFqT2VoeUlaOHNoUTNrdjhuQjRUMXRlcTRneWlv?=
 =?utf-8?B?Uk1BZ1ptc1B1TEIwYXd2dW5UNGFPQVJBbnJnWXFDMjYrYVg3dUgzazJ6OTdQ?=
 =?utf-8?B?N1dEMHZXcm44VFgwQ3pESnNZMDRSUXB4TjIwdmdnRkkwdXJRNEhPRDl5eTBx?=
 =?utf-8?B?YXUvcXNYeHd4QVMzUXN1em5DOG9jNTZGM01RUURsZ2tmNDZNQzFIbkFuRDRj?=
 =?utf-8?B?WUx4TkM4RzVyZVFhRnh0K0d2RVpBL2hpbmlZNGg5Tzd6VkJWalo4M0p1cVIv?=
 =?utf-8?B?c2Q1ams5RFpBQTY5azZuekhMWlNQdURtN1habVNRbkwxQk1EbG4veXNDUzFv?=
 =?utf-8?B?MnBCbDFITldjQWkxeEtjbnpnelJzSHd1WnV6UmEyYUNsWFdKOEhQbDJ6Szh2?=
 =?utf-8?B?YW1iSkUrVWRQSFpJMnJxb1QvODVvYUt1Y1F2RDR0T25TbCt3UktBL2pDaGFD?=
 =?utf-8?B?ZGc1bTVCZjZDQWN2RDJMVG5FS3hiTXVxZ0piQm1QTVlIcjdvUS9EakZoRzlI?=
 =?utf-8?B?Z2c1ZUtUYkJvbWw2ZkVpNHhiTUpqVlN0OTYwZ3lLbVJBMm03MlE3VkFrWGZT?=
 =?utf-8?B?dlJGWkpwSTE0UkZCWkFBNnNrdTR1SHNLZ0J0TEJQaVRaNWNIZ3hwa2prd3BK?=
 =?utf-8?B?WjdkYU9Zc0ltblZkcjNXaVkxb1ptSVpEVUpiM3pvS2l4aVVFTCtyUDgxTHY5?=
 =?utf-8?B?UzYwZHRVMjh4QUlSNitFcjQ3Qkp2OTNzUWUwQ2d1MnFiVTh6UU5mZnBkNVgw?=
 =?utf-8?B?Y1JUYTl5dlg3RHF4OWVFV1dYMlo4S3NvNnJiLzFCOEZwVGpLaW8zVFdWUjJU?=
 =?utf-8?B?NGNPVmtaQUJYK0RsTmpXNHN5ald2ek5UMkhRaE5RNEhPYTBHMU5CRDR2dFdi?=
 =?utf-8?B?T1lJU3pKVXc0T0dFenFodmhSYmNIR3JMZXIwUEROdml5TnA0S1g5ZktFM0RH?=
 =?utf-8?B?eTVzU1piLzZ2bk41dlpadUUvVmtiaVllZ1diWjdDMDlnbjdrak1sV3VsYm1v?=
 =?utf-8?B?b2RkZXQ2UDJhZTNYZlBBZXoxTU9iVk9rS09EZnZUZnEzRit2dC82SHljTG5C?=
 =?utf-8?B?MHpUNkJ5dFpJQmVZTENGeUtUR21qVHAraC9GK21IMTRCQWt6RDMrTldESkJt?=
 =?utf-8?B?dG9UOFlBUVlaUWhiMm51RTI2dXg4YXBpL3ovS3ZJUjZscjdtR3dZbW1sRDd4?=
 =?utf-8?B?bFpDRmVKb0s3cHY1S1FQOXc0QkJhZTNBbDBNRHZmWTRxUTFtVGZCcVFtcUdR?=
 =?utf-8?Q?ROfPT5pIF8w6+4DNB1d0vkvry?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ea4e74-ebc0-4306-fd87-08dc063e2305
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:52.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOeYbQBpHlXIQcMxAbnAb5Dw10FXFLwiITLiQgLKTYhsTPbbQfUdcizAiP2QmAPqlx4WInnakIx8hcV4u3PJrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

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
 .../devicetree/bindings/arm/marvell/armada-38x.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index 5bc69c4fe34d..f77976138bb3 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -38,4 +38,16 @@ properties:
           - const: marvell,armada385
           - const: marvell,armada380
 
+      - description:
+          SolidRun Armada 388 based single-board computers
+
+        items:
+          - enum:
+             - solidrun,clearfog-base-a1
+             - solidrun,clearfog-pro-a1
+          - const: solidrun,clearfog-a1
+          - const: marvell,armada388
+          - const: marvell,armada385
+          - const: marvell,armada380
+
 additionalProperties: true

-- 
2.35.3


