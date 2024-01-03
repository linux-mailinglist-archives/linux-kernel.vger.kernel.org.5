Return-Path: <linux-kernel+bounces-15443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE9822C12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD6F1F240AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B30F18EAD;
	Wed,  3 Jan 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Zcmv/0xM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713A18E21;
	Wed,  3 Jan 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwPLIkp/hAIuqOm88YJDQia0Low8vj0oE/4+M3JEbkiAqn3MS92Rf5Ov9xPdNHE3wvNpJe498mgpzW7wobNOdx8ejF7nPQX9qnJp4SKikXrz6763IIo16bSl6lqxK0fGdl5/++SylSaAWatVGZLzxbaK/sV0JjZKwzE8nHh2vRmexf9FZvFWR/a7mvtDmdzp87BEGNZqsO2v20SaM4b3Eaac3BKdodheBz0pRo99eB0XUaFebaP+LPK954jUS01VqgcXdqljimOWyFFRUvih2RspwSHk2qdPutlabNlnghCEenz1GgWiQhyrQZsQmB1ZfnxuV1sriFT6v2s4EnNq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nntzXGt8yqjv0gN1EveBDQ1zwyEtVWF2t5bBClYRUgY=;
 b=ZcDLuVOOLIiCTxupKVaWM+Ee6QZE7LQOrxqU4ihMwMhe4kfWIPrncNQCLer2nEhNcatfy+IKvXmIIJbTXBi2mTGS+ERzzT1RSqiz4JjHa98KYyxF2aPPYMZfnw2wizBAv4xBvoW2HpdoAzhYmt1vJ4CSbDXy3+7d5AbBoA+C4sDELfgZYhEBwIaj3GEf289igT80MkJ21v3xBnvN51YZMREgzHfPpM6G6oGhqVskpdY0LJnQpYRnbVbRXjhMN4S5NEtgLaxnLoDb10FEnMMS6r5twpjsGuh+EgK9gM/8gDy6+K6qCg0RUpJeVNVL45SDY7xXP91y2oM8EYxMwkgZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nntzXGt8yqjv0gN1EveBDQ1zwyEtVWF2t5bBClYRUgY=;
 b=Zcmv/0xM4UbM7mkJSP/SCoJwTzoGdg7U+F+TVzKXt/81jImse4rFx/lJIepqdlvwXaN77WMvSCeEX0SWNxynjVASRo4Gl+TEoFAr8F5f2Fdu9uooM89lo3unEqTYs/HDCafX56EXpqb2Phy9Cr23ryHHIgf/VJVrTQG6ueuiisU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 11:27:19 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 11:27:19 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/5] arm64: dts: add description for solidrun am642 som and
 hummingboard evb
Date: Wed, 03 Jan 2024 12:27:10 +0100
Message-Id: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5ElWUC/x3MMQqAMAxA0atIZgONVgWvIg6hTTWDVVoQQXp3i
 +Mb/n8hS1LJMDcvJLk16xkrqG3A7Rw3QfXV0JnOGjKE7D3yMVrM54EDMTm2k/jQQ02uJEGff7e
 spXwh2ZQGXgAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM7PR04MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d396b9-d772-456d-3f7b-08dc0c4ef211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Ont+zSyHjpeScVV1cQaoq5BTopwHSjMtcf581lomufY/C5PIjUg+e/rx9+KOdRLmUvC/eO4ZdAYpC/bIhL8qEf90o+IABQATkkyYajGvKwMbrhxlIHc9TmKZkWodU3sf1mM9vahIrsY2vQd2AqZiUObzIfOFLYCqsGZBYj1cKcsH0aQ9WjJm6scFpDfYMxQolyhroj4KkLVq9ynJ8bqcEuoxRqe7LUTfRyrCDtgfk3nGhnogdGpHO2smuEk+iojBTNGqZNkr/QJYZfNFbMc9E+jjQihr52cb8pw4tWuZY9PFQziNTZGgcAkycn1olx33OvWCCXpj7tOf8kR1mcCHUs3OWA1D1aG2rJQHZ7J1rGFYKTjFRbL4nE+miHt+TKy3qAMszvMnnFdLkzvGAx19/DYxPG6OMLvLx5dqjL80HPK1861M/nfigQlDASAQZLzF3oL+iWUkCCMFFAYUVcM4AfdrdYlZ/BKM6imtohX/vE3bfGX11Z3AskDsKqE1QUs/MaCmMyUla8BH7NkGgog11OPAeqGQwyetBHzT3JVBqqZ9HR+Yr/dgZpIgDbMcoms1dwJNFoP+48Fa+B3iQ6heyYhaOIl/svFF67DFfICFvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39840400004)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(4326008)(6486002)(66946007)(316002)(478600001)(110136005)(8676002)(966005)(54906003)(8936002)(6506007)(52116002)(6666004)(6512007)(26005)(2616005)(5660300002)(2906002)(7416002)(41300700001)(38350700005)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUFwaVEvYmtFYUM1VHkxS3B2dTFHYzIxU3d6Y1ZxbW1oOUlna3cvTjQ2Vk55?=
 =?utf-8?B?aXgwWjU3azN1VlRzam8raU1pWmN4Y0NmdjBUeVFTN0I5T2ZtMFRTSmYvUzQy?=
 =?utf-8?B?UU1meEo2K2hkTmRCTFNZRFMvVVhoSW5WdUNlaldqeTBwbVhsQVpSUVdoUGgy?=
 =?utf-8?B?OWxCalJ4NDZFNkgzOGlVMXAxTWhzSWZYclo3UGl6Ump2d2JoT1BWclJPaHpv?=
 =?utf-8?B?TmxHanZ4RWY0S3Z3TlIzVTN5REFwODdSanBrRHkxM0E2TmxEaTFkYjJSYksx?=
 =?utf-8?B?V1Bmdm94dW95TTdveW40T0xBZDE0NlFCWDc2YU5OdVhJT2VuTE9wSFNMMUdz?=
 =?utf-8?B?ajZiV05wZzdGT2tFeFpTV1FkOUVONVBBSm1VaFFKaVpIVzhEdnFVV0ZZVWJJ?=
 =?utf-8?B?aWR3ZXZCWThWVG1WUmo3NFJmRzVZN1djamxBSWQwSVZQV3lXYXYyb3hBb1Nt?=
 =?utf-8?B?aFRjcFdteFFhZTRKdGgzSWJhVTdUK01meHoyYlpsRVBvR0RoVlRma0xLMmkr?=
 =?utf-8?B?eXhqL1Q2ZURCRjBqSnNQcE1OZzJMLzlzOUtDTnNhQjh6OTdacktSK3BwSUhj?=
 =?utf-8?B?RXpMRmROOFBFQUNIRXBsUlg1Qms0TzNwa1FrSEoyb1BkQVFBQmdFaW5pd2ha?=
 =?utf-8?B?S1p3WGIzL1FmOXMxdjN3djJTU1pSUDdXNTN0bGgyY0N3L2NudFl5ODVWMDVr?=
 =?utf-8?B?cDYzd1Zjb01jYmRPZHl2UHRGT1RRY25ES1B2Z0ZwY2RpMFlsMVZKRWt1UmtJ?=
 =?utf-8?B?MXRDcmVrdU40dHVDREozV29uMDJtcFFZVFB1cmlqQVhGVEFwQTBzRFRpMG4v?=
 =?utf-8?B?NVMyQ1JlYWN1V2pRelNNS3h1R0ZTbzM1ZTg4M3hDWkZTSGgzOUticDVwRm9V?=
 =?utf-8?B?dUQvK2tsZE1HMEE2VUlzM3ZwU0MrdmQ5dnlzZE1kdjRtZmFWNlF3T0RRM0JE?=
 =?utf-8?B?YU5VbDhxV0Vtb0RobjE0cmhoT2dadEhOLzNhYndDdjFXcnJHajZjTDBEa2J6?=
 =?utf-8?B?ODl1MVdneFpkNEtBS1hvQ1NocDNZREpLajlZQWNtYk4xQjcraHhxRWdVb29Y?=
 =?utf-8?B?Qm1waGlsMjU3U244Nlh1ZlQ4S09pdENmWmdVbXl2T1hyaFQybzI2c2pKNWI3?=
 =?utf-8?B?ZjI4UWl2SW03UkMybFdMZnY5V3A3VHdyYUFibTVNYlpSZmM2bjhKYlkweVUv?=
 =?utf-8?B?QVRUZlYzZFB2NEdUa3p6bUEvS3NtYlhHS1NkcnZuWkNYaTcxa1lHaWluaVIr?=
 =?utf-8?B?a3Rra0JGNlpUaGhKb08rOGwxanlhK0xJUS9Rai9pdWZFUVZyc1QzTFZUWmVy?=
 =?utf-8?B?clVsUkpYdk9ZdktoWHltbHo0S1F2ZWxtWUVtaVlTTkZabyt3d1F4UVZhVEUx?=
 =?utf-8?B?UEN3VThlekxLOFlUVElERW9KY3VPaHFmNkNRVjVtRGprRkYxQXNoR1pReG9h?=
 =?utf-8?B?Q2puOS84L1paK1J4b3FrQkFuNUQ3eHRyYW1QTE9ZcWRaWDg1YWEyMWFzUTRO?=
 =?utf-8?B?aGlROGVzREcxcDdEZE85WUQ5UVd4QnlJT3VrYkxycHZlTlhjVDVsWXVDcGxJ?=
 =?utf-8?B?cnhZb1NXaW5takFBSnkvM2VkZFl5VlBvSXR2S3FzRzFZNGc3N0phNXZTY20x?=
 =?utf-8?B?TUxxVVlTbjhSNSt6ZVJ6TUtvbURZemVEL1VnZkExWXhQZW9keGFQeVU3ZTEy?=
 =?utf-8?B?UWdaRUJYOGY3aW9nVmVmU2FNeWxzeXhnY283NEY4R1dCT001RUo4MFdLMzBl?=
 =?utf-8?B?SWtYVmpjcExYRU11d0Q1bEpWUjh6aWFESWg0S2dDNXF3VjNvT3lrdmttcG1Z?=
 =?utf-8?B?MmRXT2NzU1l2WHkvang1c2J6T081R0dxYmtlbFlpQ2hzOHNMWmM4RE5MMFJq?=
 =?utf-8?B?MXZCVkpwTGxKYkd0dk92WlhNWTBrN2s0SjNzdjBVOXNDOE4yQzZHQjBPR1B1?=
 =?utf-8?B?ZUMrQ3JTWER0amE3SWZQaDl1N1Y5VUZydEFIdmhTOG1meUdCWWU4SHppNDdm?=
 =?utf-8?B?a0xLZjJvVFJuY1NKakExTDNhTkZwMVVPY1VYMVk3UzUvRnNFRVg3eW13Smhq?=
 =?utf-8?B?N1NYRnIweHpwMU5CcnQrTVJDc0FTK1hEVUJqQk5nWG1vY0d3bzhsanJybmdR?=
 =?utf-8?Q?et2rx5NFkiko3/KXYCDvqYSav?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d396b9-d772-456d-3f7b-08dc0c4ef211
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 11:27:19.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btPMFjhhTRrEokyYecOUcFxd0LwwJHOJ0MpcbXS/r69MUxD7dfF5nMG6nh0R9V/LYa2taiLbAmD/potWJORw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

This series adds DT bindings and dts descriptions for SolidRun AM642
based SoM and Hummingboard EVB.

Additionally a commit from downstream vendor kernel are included,
enhancing support for pru based ethernet.
I wasn't sure how to properly annotate it in commit description /
signed-off area ...:

1. add description for "Industrial Ethernet Peripherals" (IEP) to am64
   https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-am64-main.dtsi?h=ti-linux-6.1.y-cicd&id=5afb73d82a014b59462162d960b350b8c58e5ae6
   IEP is already supported in-tree by a driver, and used in
   k3-am65-main.dtsi.

Unfortunately dtbs_check reported many problems, I put them up as rfc in
the commit description of patch #2.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (4):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      arm64: dts: add description for solidrun am642 som and evaluation board
      arm64: dts: ti: hummingboard-t: add descriptions for m.2 pci-e and usb-3
      arm64: dts: ti: am642-sr-som: enable iep for pru ethernet ports

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
 arch/arm64/boot/dts/ti/Makefile                    |   3 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dts   |  31 +
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dts   |  37 ++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 333 +++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 639 +++++++++++++++++++++
 7 files changed, 1074 insertions(+)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20240101-add-am64-som-51a1ca47edf3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


