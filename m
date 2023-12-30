Return-Path: <linux-kernel+bounces-13464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 656518206F3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1350B2143F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F87EC12B;
	Sat, 30 Dec 2023 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="LBcUV3zY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064D9465;
	Sat, 30 Dec 2023 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaCVOcpbQi/12iahUHwLvfn4iscuQWZnDN2qs4uaO0/BoE5TJUCAnCzoKjKnjjxQzSlJLdf3YOwYAT5yf54w62eSELnC7TKl18ZW3r5vuY+s3K9dewYknOSnjVZlh8iNZcLg6ZtsQNiqozwL8dIuPbaWlvO6q+IbnCBYg+bFMzZXrGUHyhzIfH+prrfj4+18ErC8B2ZJ8x3SkgSZIBKwUFlHArUjEzdX7GMLG5jls/UQrqcQL2sdVyhuxcRQ6NI2PcvXv5tv45lh4pjkeoXOCgiQT4kE40I4s5kwat2O46dCnL6t4JGOmm2kPENuK8BucUGKged5bua4bh3BDX7YUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOdUbyZIg4N0pHwkxAftRnGuagmHBGntjCthFDV3DOw=;
 b=S8bkoNe1uzun2uCFpKey0cy3D9oCnVDZC3oCJqXSVLQW+INVaHMFlA1B0S0iPxKpbhNvd25v6YqiMb3XsEUdI34OG41F2VEAP34qNWFJaps/u69Z2dK5KVmdolT+R/4vx8TIrp0my4x9IPtiG/8USQP+8Qg2HPjss/xkODbWig513iOS0Y8XIKMW/3OkoFrZmmyYxpNfC36R6h8mgSr70zyVhl4M6J8Es94qbIhXjxw8fKHL04Ud+Thx0ggUwK3SupSf8MllGnkwDbK0GxgSWjKshn55fnglId4mL1qwjM/a/DBouAuzpaoLArCh2IiD8bLLA0c6gwEsa9oBXjQ9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOdUbyZIg4N0pHwkxAftRnGuagmHBGntjCthFDV3DOw=;
 b=LBcUV3zYXe4XomvjIWEkysaOVWxIvH1oqQdVyaRGbQ2ItF+Q1fB3DQNzN1u4f64pnXhs5vIrzHchZc6r71UzGa0FnDdjjrCMPY3eUNgQ3Lpm7E3yoZG7FntfRO22M7fv/augCVUDZ42Zk7vIXX0akA903AZ7jZQ/N8CrnK9XTmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 15:44:45 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:45 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v4 00/11] dt-bindings: marvell: a38x: add solidrun armada
 388 clearfog boards
Date: Sat, 30 Dec 2023 16:44:34 +0100
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOI6kGUC/32PQQqDMBBFryJZdySZRGO76j1KF6lJNMUaSVRax
 LtXhYJ04fINvPeZiUQTnInkkkwkmNFF59sFxCkhZa3ayoDTCxOkyBliDnHoOh96KBujgvUVVH2
 ApoBoO9CFVEayTMlCkqXQBWPde6vf7gvXLvY+fLaxka3XX5cjwzOnKRM5CmDw9HFQ1+gbpyEMb
 Vr6F1kLI+4twQSXGU2znB5KfC8dvzByoGA1UyXq/GHR/Pfmef4CwqhUCjUBAAA=
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
X-MS-Office365-Filtering-Correlation-Id: 1177cf65-5eb3-4508-4ca2-08dc094e3f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AJRGe+zEfhm4TQwXxIltFYX+zGWyVqhU5a8u0/0x1jHNDRQBjgpzy875O8ln6c91yn8eEd0RpIMjijAopLsZ9agyBtdeZsEe+Ruv22wkQMTzs8cYSdR+ZdFnpMZ2SJtjkLu5kbwkD+puAAwQ8HEGpvCfak/MgluQke8nMI3BR6jA/rG84Q+5KOduVwRBwT1ZAmAdBVM9cGq+I6CCUZX2CRWOxUL6OKBOi/WYE61E6eGlQDY0qFMp4Ni8q6UwCp9M60YLLFZugt/S9k119/CljPckJQ630nAbKg3fajuxbcArgraOJ4fr/RrTLFnP1vjqqqTKbwmvYUwaqdiTi7f4oV7gdnpU32YjI7Z2WPi0qlYw8kr6T8e0RLSghzIgVDxaVPwERpZRn5l2DWNu/BIBlKlJgeR4iyb2zt2hGjdfc3fT+F6j/nZQGXLQiWx7HFsh1/B2znjLW/FlbTBltqFyNONvTqnXBmi/g8wP9PtF3s2eqDYtCnP/JULfWcMbFTUU2tHC6FtAE3eMMB9rY3IgYWjEvGI2fErDb+e+21+DWCsLQEOrPFZBa8yOf/LVhw8J7bWtV18h4z+1ttn8H4b8XqHoDsdA2j3fNTxK777N5L0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(966005)(478600001)(66556008)(66476007)(66946007)(5660300002)(83380400001)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2gyWjlDQXVkRm8zTEEwRjdickx1WG13MFdtZ3o0ajRsajk0QXc2aUR6bnlq?=
 =?utf-8?B?WDJab3VJZ1Jkd1FjcHFiaDVmNWdNUTdVbW90WFp4VWJieFh1T3dBVVNSTk42?=
 =?utf-8?B?N2owRk56TXgwWDMwL2NlcW5XTGVHb1VzVmhRL1dldmkvU3hCOGpxTVl1UG9r?=
 =?utf-8?B?K1NLYnF6Z00rWGFIeFVJbFZEUXZNNkI3MWlQUkJvVlJlejN0L0k2ekR5WGtR?=
 =?utf-8?B?KzlZOExQeUE4TDdQMjJXeXN4NXVPc1NtZ3RpR3VvY1FpL0JKTmN6TVhpK05P?=
 =?utf-8?B?R3M1Ri9oWmNoRlBpU1d3UkI5YUpSNHdJbUJyMTJWWnRlMDVBNGhqK2xraVVj?=
 =?utf-8?B?aU1oWFVNWFZLY2d4amN2bmNwTW1EbU5MQTdCV1MvMzhidWdnR0NzTG5UMmpI?=
 =?utf-8?B?cHNkbGp3WUV3b2xraDJ3R25nL3R6THNFYU5rQTkrWWwrQWkrZXNKVXh0b21h?=
 =?utf-8?B?UEk2ZElKbzErK0NkTzZRejQyc09zN1RJZTRXZjZwMXZDdXBZbVg3eE1SeU9C?=
 =?utf-8?B?V29GcnlwenZqdG1DZnZ3ZDZjdDQrMy9aREVVb1F2WTlsUFp3LzB2OWhDdXVa?=
 =?utf-8?B?MUlCTk82Z3l4T0RHTm51L3dwOTd3WUdZd1pjOEdoOTljdTFubitoWW5HLzdr?=
 =?utf-8?B?U08xTXRoNzNES2ZFUFpmNWVKRHdvQ093L3gxU2pFSjBCSFRkcVIvUGgwSktl?=
 =?utf-8?B?dGxDMDl5RnJqN25lR2JkQzAvU1cxWFc1OFFtWk5nZkE0clUrNXl4Q2xkclRz?=
 =?utf-8?B?MzY3K1pSZmdoSTFaVU9YMmlzWWJBWHZvR3ZscW9ZSFlINVBhYVgxeUtubEhz?=
 =?utf-8?B?K3NSTFlKVnIzOS9xUS9CUWFyREZzUDBsWnlEUzV2WFpEU3p1Q01vK0tDZEta?=
 =?utf-8?B?Y3JFbmVveTREbTFmL3AwbS8zOXl1NVRVdkgrNDROY2FQYXpRcGkrUzhWWHpp?=
 =?utf-8?B?aDRIN2s0Y1hneFlyaXFXb3NRMFlzcW5aT3FQTURSOENzNWg5dDB4M0RlbFFO?=
 =?utf-8?B?UCsrVmU3dU9PMkYwNkJlUkZjd25MVzhYSVZWQ2N5NWhYOGRKZTYzYm1SMEZ2?=
 =?utf-8?B?RkUwNHJnL3k0ZVF1UmgrMnRDUytvZ2lSSVRRZ3R3STBGVFJzQjN0ZERHMDJR?=
 =?utf-8?B?UE9XMWJqalRyaFNMYXJBY2hLSTYxRlEyWDhFejJhYXB3Sm4rcnN6RVc3V0ZP?=
 =?utf-8?B?czJnUjd4U1o1NkV6ODhqRjYyQVVWSmtQcmdrejhlNnZvUWo5eFNQcHdDb1Z6?=
 =?utf-8?B?UUs5Uk1RRHVmWWNJT1F4T1A4RkZCYTNsa0F6WnFRdUFqUE5hSnh4MjlRRGJy?=
 =?utf-8?B?dlFhWVpsZzNzUklrc25rZDBZQzBGSkJjRisrRGxpMWMxdjlJeDdCWnZZYVha?=
 =?utf-8?B?QkpzblhXWGtpcTFmQTVuejc0K0FvMG1Nb0N2VmxZMUZKRFFiOENneGFrUVFE?=
 =?utf-8?B?K2hKVFE4S0hnSWF3dlNqMWErTVhJZHJQUnVubTI0UGR3ZjlLZkc1ODFlTXV6?=
 =?utf-8?B?c3lTSm1MUTdwVkFodC9vY21uT2ZnY0paNUtEemJCR0dTUTIzSEh3RXQ0MW5E?=
 =?utf-8?B?M3BwNGJHSVlHcmFQa1FvQjVEUEY1Qlk5SmwxOE9uZWZlMk9rSDhlSlpaRE1y?=
 =?utf-8?B?VkhYajlHQVUwbnNWbi9OSU5FMzdUMCtnZ3lkS1dwbS92V2V0Zk51YVg3RlBj?=
 =?utf-8?B?Z0o5TkdsSFV2UkQ5QWJxUlBORy9FMExOd25jbnJUUDRLcjk1cE9udXhKcVB6?=
 =?utf-8?B?eUdBUUo4WnF1L1RqN3V2VVJjMnFDeGNkZ0VnalpQdW90NWo2MmQ2d1VHb1lJ?=
 =?utf-8?B?K09HLzIyZGF4NENvSUsvYVlsYlgxVHNhZXAzU2RqSTE5UjV5ZHdWWFJ1L3BV?=
 =?utf-8?B?Mm14NE1NRkFNZFpsT0QrVDA3aXVJVDV3ajlObDAxaFZ0ZUhNMnliRTRteVhl?=
 =?utf-8?B?SFBNT3ZSaGRYMkFSS0g4bTZpd09aYlYzNGxtNWs0SnNIanJkMU4raHNsMXRn?=
 =?utf-8?B?Q0FJMGhlOXdBdEhiN2JHVG95UEE3ZVI3QjR3cXptYVg1d3Y2NTk1c2xCUmZi?=
 =?utf-8?B?MnpsR1RteDFDUUg0R1ZPb005TTFSTFJoSExLSmVJQVhPOHVQT2x0c3JycDVm?=
 =?utf-8?Q?wm56kTftuTNJbZrwH8fPdxl4/?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1177cf65-5eb3-4508-4ca2-08dc094e3f2a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:45.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dlwykbie1wR6DOqpq5p/ZSbe3J4U80D3Y6eLzrs8Plh8V9VqmjiGD5IfTvao0+jAUXxknc1eaEW4HH0UwrqEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Dear Maintainers,

The initially merged device-tree for Clearfog GTR devices contained
various subtle mistakes and omissions:

- missing board-specific compatible strings
- missing pinctrl entries
- missing second sfp connector
- invalid sfp loss-of-signal gpio
- mismatch of labels between dsa ports and enclosure

Most notably this had caused functional issues with the sfp connectors.

This patch-set first deletes the invalid armada-38x dt-bindings.
New bindings are added specifically for the Clearfog GTR boards,
and for the already in-tree clearfog base, clearfog pro and helios-4
boards' compatible strings.

Secondly pinctrl nodes are added for all referenced gpios for independence
from bootloader defaults. U-Boot is shared between armada-388 clearfog,
and armada-385 clearfog gtr.

Further remove an invalid io from the first sfp connector description,
and add descriptions for the secondary sfp connector which is driven
by dsa switch port number 9.

Finally labels of dsa switch ports were updated to match the enclosure.
That patch is not suitable for stable.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v4:
- dropped invalid soc-only armada-38x (txt) bindings
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- add bindings for armada 388 helios-4
- updated yaml whitespace indentation count
  (reported by Rob Hering's bot)
- Link to v3: https://lore.kernel.org/r/20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com

Changes in v3:
- armada-38x.yaml: removed '|', no need to prerserve formatting
  (reported by Conor Dooley conor+dt@kernel.org)
- update commit descriptions to clarify confusing board names and
  compatible strings
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- send to all relevant lists
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- remove duplicate binding for clearfog / clearfog
- Link to v2 (patches 0-2):
  https://lore.kernel.org/r/20231224143750.5604-1-josua@solid-run.com
- Link to v2 (patches 3-8):
  https://lore.kernel.org/r/20231224143850.5671-3-josua@solid-run.com

Changes in v2:
- removed changes changes to gpio numbers because they were wrong
- added bindings documentation
- Link to v1: https://lore.kernel.org/r/20231223212930.14624-1-josua@solid-run.com

---
Josua Mayer (11):
      dt-bindings: marvell: a38x: remove invalid txt bindings for armada 38x SoCs
      dt-bindings: marvell: a38x: convert the soc compatibles description to yaml
      dt-bindings: marvell: a38x: add solidrun armada 388 clearfog boards
      dt-bindings: marvell: a38x: add kobol helios-4 board
      dt-bindings: marvell: a38x: add solidrun armada 385 clearfog gtr boards
      arm: dts: marvell: clearfog: add pro variant compatible in legacy dts
      arm: dts: marvell: clearfog-gtr: add board-specific compatible strings
      arm: dts: marvell: clearfog-gtr: sort pinctrl nodes alphabetically
      arm: dts: marvell: clearfog-gtr: add missing pinctrl for all used gpios
      arm: dts: marvell: clearfog-gtr-l8: add support for second sfp connector
      arm: dts: marvell: clearfog-gtr-l8: align port numbers with enclosure

 .../devicetree/bindings/arm/marvell/armada-38x.txt | 27 -------
 .../bindings/arm/marvell/armada-38x.yaml           | 49 +++++++++++++
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     | 38 +++++++---
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |  2 +
 .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi  | 84 ++++++++++++++++------
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |  5 +-
 6 files changed, 146 insertions(+), 59 deletions(-)
---
base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
change-id: 20231226-support-clearfog-gtr-l8-sfp-d87ae715a787

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


