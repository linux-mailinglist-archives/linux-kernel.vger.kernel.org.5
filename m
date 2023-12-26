Return-Path: <linux-kernel+bounces-11608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94981E8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD72B21F94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02045537EF;
	Tue, 26 Dec 2023 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="SwK5rtGU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789C51C3E;
	Tue, 26 Dec 2023 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwfGeetKj8S6U43wTjbnwohStHI0JlnTejwmvsli1U/QcXuZDX7UzjVTNhfRqnTyhOYPkxxsMNUbRHiw5CPKH3W874bARtg3WcZMQaF2dputz1FSgN7dLoliInxAH/1iuu0Yo2wpqsyuQbvTd7zvA1JDXPoBcO6KxwUQlOT60SwweVLwEbbp+DYAOWKToMSsx8DHaEDXGI+rn+NftISLzRs1R5uodFRATDIUdTpO7gUNhoFlKjwYlW3aZpoY3eBODGg7nvl6RIoeV887syAC5gAdn08hbLfJcRrAkFU4cULZUwRr5/Snsk+/hlrNmQmDIzHuxaIEZO7Lg+lw2XKIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9HWUcxA0hxhKePaRoXbSXL90kbMTYu7WPz2V3s1mlE=;
 b=CEDvzdneuIBgdFQFbowcJoWpgvOm6dvLkrTEQ7XpXHtaWUuLZ0LD9GdvVQqroN8HfwTIRgCjyUNp7rGwqb3fnCJlNmI3kQfxELA1NHcFesUQHaZwF3FTcID9RTekSNl1ROZEGwtLoqEaivjFYC1DsX6zP0U1ACwNmELen42AxUQ9Bdou5hAfusQzkGp0FFIHQPvpAxuwHbGID5IS7Hg9k29T/nJg2pgI+y9zHGt2rB+N0KwJeAUoFkaaHu4jSZy+N676gEcw80NxD7T8MmYp9tGFVM4HMFBUx01IDFwVOeJiWGkKWiVnGn85BA2dG6cu9rwD6kTinhatUDuXLzE3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9HWUcxA0hxhKePaRoXbSXL90kbMTYu7WPz2V3s1mlE=;
 b=SwK5rtGUveUqNb98H+/LqS59tOCm1W/tJl4UCZaSRst92Vnbr70HQUBwO4OJ3GF3gaKC6OQ6uyo0cTzSMsytiqHvuM83gilWD3bM3zU3J4o3VKPh6XWvUjUeyFZsld27UGPLoPExjuqBjze4wD3CrWan10+YnxgIGzctAc/R3uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9868.eurprd04.prod.outlook.com (2603:10a6:10:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 18:11:51 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 18:11:51 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v3 0/8] dt-bindings: marvell: a38x: add solidrun armada 388
 clearfog boards
Date: Tue, 26 Dec 2023 19:11:31 +0100
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMXi2UC/3WNwQqDMBAFf0Vy7kqyicb21P8oPQSNmmJNyKq0i
 P/eKBR66XEezLyVkY3OErtkK4t2ceT8mECeMlb3ZuwsuCYxQ45SIJZAcwg+TlAP1sTWd9BNEYY
 KqA3QVNpYLQqjK81SIUTbutdRv90T944mH9/H2SL29duVKPAseS5UiQoEPDzN5kp+cA3Eecxr/
 2R7YcFfSwkldcHzouR/pW3bPk4QrbLlAAAA
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
X-MS-Office365-Filtering-Correlation-Id: 2ae4b52b-e45d-4537-2d80-08dc063e2234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aZZgWtuVlEJ7mpLqlXjliIgfaMsXT3sU26A+/WhD11R8P1mYdQKVMwy/1hN6WZSFtg4fSwy2KJ4ceN2uok9KUzO9fsb3ssAcLnZ2QF1XU+vJWQrUC9eEpT/14OfleOw1O1I/Qak4/3Nz1Rk7/TKHCf9L9/qmGiAFaTROFypgagbhrU2bOQW3OcI1UBTVq9tDhh0avC4o8YcteM7H8EcApOLrA1IvSFy7lfs1IgdaNMEoGarXZRSs4OqLbdjSwCt4DFg/K8nXY64TlBX0QN2+Q4Ig2sTLRURyQG4PzmsdLxTR1oqsEYB+R/meQZMiBLAMdsESzb4UspVjZN5tDi6XN3C121MZvSzatlfpZuvnvYyqiCaVHztxXwmmyriNK9zXT/NoOy+sJT7oQ6rgaXu84GZWiz9ANtm1tZXfEOXW3D2ifrBmHGizpxEKFyuuDMfaFixvd/XF5eL4Wo29TctlkKHNK4UDUVnbjxyGMVD0rxsek7YQ80vY7HT4kO/WbqexrTOZ5BWHhCTqtTrNvhJK5FEh1WlCkgE543kjdPtyFEvE4lincso8ouafv3nSseIqU0tytbbz+7Qa/Fvy4HTdFtqwJ4mBUX8ev8D6LwyD0Co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(83380400001)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(966005)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3pHUDc1ZjYxYnB5V0lLNU8wdEVSN3drdmtaMDd6Y0lqSDA0VENZZThtd09m?=
 =?utf-8?B?dmVGZ1JLVXNkcW9PTHlHZFRaUmZOd0RuQ1JlVDZiVHFEUnFxTlh1MFZVc1FP?=
 =?utf-8?B?QVM2cHMxVnc3N3RwNnFMRjVVQXl3Z0h1emFFY1ZKMHpxeU1YWnp2cEVZS1RD?=
 =?utf-8?B?K2ZGRExRU0FEc1FXSkpJWk4zaGNlS3prNHAyMFhXQkV0OGhHUXZtRmU3Y05V?=
 =?utf-8?B?ekVXd2NYaEZpYzdDeXB2NUNGSkFzU1FNWlBlL1NyaFpvbG54TU5mV0pFVzlK?=
 =?utf-8?B?bkJDTlFRY3l4cHVmcmpCL1RIWnFXWm5nazlxaGh6Z0ljVzVyRXMzZkczcVlX?=
 =?utf-8?B?K05FSWlPaUNDZ3EyREdJUk0wZlRIanF0d01UdUtKUUxHVmZqeEZteWVZY1U0?=
 =?utf-8?B?VXdvNWhHNm1DZFRRWi9NK0xJd2dpdGZidXhtYUxHMWppOVN1eFFWMHNvVmNN?=
 =?utf-8?B?OEJiUU91N3ZIV1J3N2NRc0JFNGdZQzB2NDFITmRLaUF2YWN1WEwydmNPZDR2?=
 =?utf-8?B?bS93SnpYR1picmhOdGs1eG8wTGpPbmk1dkJ4T3Qvb2ZIeHRHTzI2ZE4xeERC?=
 =?utf-8?B?cUR0WGVVYS9sWisrTmZjYXN3RnAwU0lUN1JPMnhoK3llRzU5ZjJqeEZLME9L?=
 =?utf-8?B?M1RPOXBVbWpMMHhqZ3R2a1VJMUR4cjcraUQxdU55RWU1VWhwVjFRREJBanZS?=
 =?utf-8?B?TjhYanBWdE5GY0dzMU1aUUQ3RWQ1ak5CMHF0WGZ4WGQ2Z2FiRUdqcXBPYUcy?=
 =?utf-8?B?M3Fva3lkMGQ5Z2Iva0s4Tm5oZjYyU2p0azhVblZna2U4cHJtMFBUWUh4dm9N?=
 =?utf-8?B?eXZ6OFpJTENVL2s0N1lhaWcxY0xQQ0NRRit3NFN3S2ZTNytWbEVLU2QwVEV2?=
 =?utf-8?B?TFZOSmQ0aXp2YlRKZDhRQWxnZjZ6ejV5aThsazRiODNIQWk4L1NqcnBTV01S?=
 =?utf-8?B?SGdwWVRDZG1IU0d5SkV6aDBtS1VRcFhKYjA2djNmam44Vk1hMldXMGtmRjNF?=
 =?utf-8?B?ZlJlQkFTckZKTU14aktIZ3B0OU00UitmSnI3YWRRMlluY1BQNHV1by9acUVP?=
 =?utf-8?B?eGlkajRrQkpzNmZ5WWZyalM4THdMaUVMTGxpTHR6Z2cveWxRMUlxdTNiTUh1?=
 =?utf-8?B?c3k3VFU2ck0wRHlSeklHRXJvWUtzTjlibGtLTnlyZlYxcVR4K2RqNzdHczhY?=
 =?utf-8?B?OC9hSFA1VURnT05tUEZXbDJmelZNdVpOU2ljTkVYdFFHRGxhNjVLNHBGb2Zt?=
 =?utf-8?B?SWVGdnVnSVRXZS9BNUtvazh5S252amNGcTNaV1M2L0RRb2RtUFMzN0FzaTM2?=
 =?utf-8?B?dTBmNkNBRzNnTjRyckJZOFZPQ1pOTFpXdmZLNzEyczdOblZ0RGEzSnNXK3lq?=
 =?utf-8?B?eC91VmhHVFZ4QVliaEtaOWtwbU9UYTU3MjF1aWRGaWFpR1ExMTh1OEdpSXBM?=
 =?utf-8?B?N0N1OWJnNXFsSHlDMkJFYW40a1V1eWw4bTZIdlI0ZXYxcDN2Mk43YysxVThq?=
 =?utf-8?B?bE5OK3hXSVZGMlBERWJScXQvZncrRy9lYk1vYUE1YUdWWTE5dDM0ZlhscDZF?=
 =?utf-8?B?SmJTZTFJNVdKVjhHRTBNdzBBYVlqR09MTE9QWmxLU1FJMTU4c3ZERGdTdHVF?=
 =?utf-8?B?eXN4N29NNXBOSWR2TEM3WWY2RTBoamV6SGhMdkhuelU2bVd0anR6aEQ1RzRK?=
 =?utf-8?B?elBHclU4R0YrMWdKQ0JHaUl2dTB0OWt3bDlySnNONVBJMzJrZlFLSzZMbEs1?=
 =?utf-8?B?UC9uc1VXak9jSFNFeGw1bFRpVUk3L2NWSkpXcHBROGJpMnJOZW80SWN2cnJQ?=
 =?utf-8?B?a2tISHdQT0pEdkxYNnV2TGw4Z0JpdXBBYVNuZVM1b25GS0hrakN5a1Jkc1Vs?=
 =?utf-8?B?Rng3ek1udEZ1dTBXelJjVU1XWGhtTVY5NmpPVFpJMWVWVHdwUEV6bU9IWUlB?=
 =?utf-8?B?SmZ0RkYxU0xmVXNRWGtVck12bXFUeTZFRFFjVGxnbS9VUWVscDQ4S3R5Ri9W?=
 =?utf-8?B?cEhzNnFmNWNpUmVVYVV2T0huWnVmM3VFbGREd1RoZUZwcCs1V0Y4OVVwSVNL?=
 =?utf-8?B?T3BhOWI3d01TTmVwei90Y2k5bm5lTHpNZHVxUmhpQW15VGpDS0QxTDBBRzJR?=
 =?utf-8?Q?Esp2tPLVW3NLukG4AG6u0VWLh?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae4b52b-e45d-4537-2d80-08dc063e2234
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:51.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgRWjQ7zMDPnPg4bKYNoTySzBKxVaCowzA4AQa+cHDZK2NLMfX9vnnE6KDnri7UWk2+2vGx5i1iJ1tE/tJur1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

Dear Maintainers,

The initially merged device-tree for Clearfog GTR devices contained
various subtle mistakes and omissions:

- missing board-specific compatible strings
- missing pinctrl entries
- missing second sfp connector
- invalid sfp loss-of-signal gpio
- mismatch of labels between dsa ports and enclosure

Most notably this had caused functional issues with the sfp connectors.

This patch-set first converts the armada-38x dt-bindings to yaml.
New bindings are added specifically for the Clearfog GTR boards,
and for the already in-tree clearfog base and pro boards' compatible strings.

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
Josua Mayer (8):
      dt-bindings: marvell: a38x: convert the soc compatibles description to yaml
      dt-bindings: marvell: a38x: add solidrun armada 385 clearfog gtr boards
      dt-bindings: marvell: a38x: add solidrun armada 388 clearfog boards
      arm: dts: marvell: clearfog-gtr: add board-specific compatible strings
      arm: dts: marvell: clearfog-gtr: sort pinctrl nodes alphabetically
      arm: dts: marvell: clearfog-gtr: add missing pinctrl for all used gpios
      arm: dts: marvell: clearfog-gtr-l8: add support for second sfp connector
      arm: dts: marvell: clearfog-gtr-l8: align port numbers with enclosure

 .../devicetree/bindings/arm/marvell/armada-38x.txt | 27 -------
 .../bindings/arm/marvell/armada-38x.yaml           | 53 ++++++++++++++
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     | 38 +++++++---
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |  2 +
 .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi  | 84 ++++++++++++++++------
 5 files changed, 147 insertions(+), 57 deletions(-)
---
base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
change-id: 20231226-support-clearfog-gtr-l8-sfp-d87ae715a787

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


