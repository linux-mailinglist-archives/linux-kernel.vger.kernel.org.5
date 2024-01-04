Return-Path: <linux-kernel+bounces-17056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3548247B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB18F286493
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D6288A7;
	Thu,  4 Jan 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aBx7+xzk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A761288CF;
	Thu,  4 Jan 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeiP+IIlMO2bex4KMvG2dESjxw4Bb+XBZZkUa3IDNdkXxu/YsJJe40ohhgOwWVXqhWwO+a6Ao9T6+3sUOU03YnsWdG88XmaB9vUyDYAB7LC0G2ub05VngRSxlxxpdCkmZcBHLfCnUfKUW9jBjnTzT0oMl6o94jWmW0j8Y5jdNpOxzILC6r5b57Wd32R6XvfI8soBsXp5akegNRFo8SE1k11LGI5dHxGhzxeKsgsaABay9hqg2MsZBLEAufatvVJecxcXMe8SCd19109TMUbGgttGboXngZ3iYLrd4G0dVAk3jvL/MQ98YPgD1X1Nkiy4RmXeK06gpAjlAQWhbw/qeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FFWPSXCAQqzXsmXJ25y5l4ATjDpKuKRamxrnFmFkj0=;
 b=YHnucfJd68aHdYv6u3gyY2feB8bYEomcsPi9RdcSldDIpzOZ4x4WNZeuwYDb8Xdb7ZE226HfPFuDq0fbkk0alKpVpBDJxTp1bp6P0QstECDoIn14Qy3Y9TOKjqkFIU2pno3Q6XNJ6pyHobnZ4rMYcQadJi2lGCPAYmgtjKyO5zhfcD8T8CcbaB9qxc1e0qi3d5JeJ03b7XxLU5Kv9q/Yvmu6BC6amthomAoXmwH9XWHNIpW1a4tHRpEeUgdqUexHHc28SElWn6k2rGq3nJZwIiGdgnTgIJ7EnuzjH07lsppACJR5PP5kMB4qshaakFjWgVi4oP9maafUPrF3t6RC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FFWPSXCAQqzXsmXJ25y5l4ATjDpKuKRamxrnFmFkj0=;
 b=aBx7+xzkG3ES7on/HMxKHrXzm86xtzyMpOTVhwi7QX/AltfVb25iO/6LvjkofTYIIBpL34VcVPBSTRLTGPEjFxx4YGg5vQ3krYK6Aous88iScNoVroCOLZnMcwIgMOaFwpaTT9TSoK2NiJbnX370KfWdOyGCxWby+vfGVzHSmOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 17:48:06 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:06 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v5 00/10] dt-bindings: marvell: a38x: add solidrun armada
 388 clearfog boards
Date: Thu, 04 Jan 2024 18:48:01 +0100
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHvlmUC/33PTWrDMBAF4KsErTtGM5ItN6vcI2Sh6sdRcCwj2
 SYl+O5VAgVTipdv4H2PebLsUnCZHQ9PltwScohDCfXHgZmrHjoHwZbMiJNAogbyPI4xTWB6p5O
 PHXRTgr6F7EewrdJOYa1Vq1gRxuR8eLz186Xka8hTTN/vsQVf119XENKn4BXKhiQg3GKe9SnHP
 lhI81CZeGcvYaFtS6IUquZV3fDdktiW9l9YBHDwFrUh23x5cv95cuMJvu/J4qFVnjsyCqn9663
 r+gMDARTuhQEAAA==
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU0PR04MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d8ee75-528d-4768-0e46-08dc0d4d4e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VzWcGN5OKBD3WVsloprzSn6AZMltJ22pJP2MZkEAKA/1QMehd6dh+CTq5RHIPD/uY3FNAzJ7E1MISvzgD5khZd2zD1p6CjlBb2BeKlSRMJ+InBR1lLE6JysW9Ex2xpQl163JzFeLUbbfOa7sHOstUpH3Zs7MOxfEwYO1pczsqfIf2c6RIdLXcVpDmHXYE8RpfGvSkBVNVmY1C4DOvF9hld+lD+vxUIe7y1iFIT8G8o18fhChCJ+A6WQmpt1mzU8G9s+wWt1CoA/sigx4B9hu1RRm64alsWAgnZbpHKV0uMknnwdM6w0GnrJhvSSSR67vviK9KpLRA/WltN5yIecsoIO2KX0468R3lz3q+MQVChJfkRzt5oBb68ZRTYwwxP9oAlninqBiXx9/jwKvyw9W3sC+3Qh1w7omntHjxnxL14WVUsupqaRyIoCD9xCXe7q8C8tZVk5KqP+rkVZJAgu6u34g3DPSppNAh7Q/y2vTFlDQF3J2Xohc5SOhewb7yBXvchitYSiFY5oqUgXYkGGWH2MD8HSqw5ADhIyqIew+P2n+8VDBMHJJ1jfXjG+gaWztzDkSOot/0u4SsDzy3oV+j0E5pryYJktywDS4Lk1h1cQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(2616005)(6486002)(52116002)(6506007)(2906002)(8936002)(41300700001)(4326008)(66556008)(6512007)(7416002)(66946007)(6666004)(966005)(478600001)(5660300002)(8676002)(316002)(66476007)(86362001)(107886003)(38350700005)(36756003)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFUvZEFIRzVHOTQ2VHhvN3BjdmFLaDI1ZTNLU3lVaEpoektIcmQ5VktzaEpk?=
 =?utf-8?B?UTBQbU9GL0NoMlBHMEdLVTM0U0tHOFZWM0owcFZPRmZ5c2l3SUsxOXRtNXZP?=
 =?utf-8?B?UHhEVmR5YjJPL0JPclZ4OFRiam5Yd0gra3lUWnlBeFVWaWZ4czA1L3VCdjZT?=
 =?utf-8?B?eXZWQnM0WisvZDdrZ1lCd3ZXcnhWa0VXeFIzaGtXS3BJYnl2YWNxemJhMUdm?=
 =?utf-8?B?bFplcUd2dFN3SDhNbzRjZm0xejBWQkNqQVVuNWlYeldtdEU0SUxWZElLbWxw?=
 =?utf-8?B?ZlpYUWlDRzFYS2lvNnpKbzNqaFNwUE5weWRvVmVIVGJKOURMLytDN2x0S1lK?=
 =?utf-8?B?Zk95MHlGK01RaUFGc0JnNWpDaU9relBJYTZTMHRpRTJMTmI4SlpSeUpRT1Iz?=
 =?utf-8?B?VW5yZDhJT053OG4rUmp0WTVCNkdDbWxkYnltNzE3a0EyT0VoT1VQZlpicnJC?=
 =?utf-8?B?T2IvTGppMG1acDIwazF3Y1dRV0sxOWVXYVhXSHBQTXBiUHN0bWdxRE16ckgw?=
 =?utf-8?B?ZWtENFZJWlhLYm1vQXR1V1E1QWxwa2Nzbnc0YUI4N2hQTk5uZHkyT1lXRElu?=
 =?utf-8?B?WmZzbHNJMDdXMjNiL0JqeGZmaU1uQXVleTdNNzIzUUJRZU1EMWtkaXlrWXFv?=
 =?utf-8?B?Z2V1N1g5WElWV0lUdG9TZEdRcHovK3VockFzRExLL3Y0UXZwSFZnWWJvd1d1?=
 =?utf-8?B?UW85cTUyT09LQUNvYTZsSjRkaGJUaDBnMTF4dU0yMmNqcENqQ0lKYmJXNDZw?=
 =?utf-8?B?Mm1Cemt0NjlZZ0RkRjlaVFA1NzNHR3J5UkRCU3A5MTJBZWJ5a0MzRW9aVXJu?=
 =?utf-8?B?Z2FEdWJja0R1ZTUvRC9kYjhOdnRrODBqdnlOMmlUMThnVjAwOXhFZ0VCMWxC?=
 =?utf-8?B?Q093RUJ2TExUb01DbGtwc0lhU09uOGovb0FxamtWQWtkclc3cGRhRGRiVHY1?=
 =?utf-8?B?RlIyVW9OUHhMR2puaVRjMGJ3NERuVXlsajRaRnR3RjllcDNwR1o3SnhlKzll?=
 =?utf-8?B?NFZSRWw4eGhhelM4OG9Da0FVNHkxdXI3UFc4eUpxUmlSUVEzVTQ4RUdtSGha?=
 =?utf-8?B?NTU0M1ZtUjExbzcvNkZteWx6WGNVMGtiZU1DTENtbHd3ZUtNMFdKb3lmaEdM?=
 =?utf-8?B?NkRla3ZldkxtUnk5OTlJREMvdTN5c2lKRUdyZENhRmJxUzN3ZkwxZWFyRU4r?=
 =?utf-8?B?TTV4RXZzK2p4TjQwZVExY29KaW16Z1hCMUtHTmdpSWN4Z3NsbVlDRWFJVVU4?=
 =?utf-8?B?RFlMUkFSZ0lVWDNBb3kycXVtem9ZcGhYNGFqUm1SVVFsTEtZYUNUV2phTXN0?=
 =?utf-8?B?Yzl6SDdpT21PL0VmSldGVVdTWXVyOFMyZ3kxN2I3NW9SeUJnTDAzQzE4a0RB?=
 =?utf-8?B?Z1BDRllXZG8yVTAvMUMwclAyYnR2UkxoVlVWQ0pZRGJ4QTRhdHpuTDh5cy8z?=
 =?utf-8?B?cHBzUTdSV1FaU3c4a1dIZ2s0U0VscXRHcDJVTEh0ZzRoS1lsNFBld0kwRlln?=
 =?utf-8?B?SDZ6cS9SY1dTeW9aL09TR296L2JSaDBUK3F4aFJlQTlhekM5bVV2WHJFdU1t?=
 =?utf-8?B?LzZDbGsrK241OTZMTXROaTFHanAzRWJld3haVlNadjJPYytxL2EzdUl5VFRL?=
 =?utf-8?B?S0YrMlJOeHRrc2RKMXVaKzU0VE5La1dESER3ZjFXU25vRTlZYXZtNXNlSUNq?=
 =?utf-8?B?SVl2ZlppKzFoUTFVV1YvNkltbWJiRnpHYmIrRFg1Y3QzMExQcElvWFJETU5O?=
 =?utf-8?B?UUdCY1k5dlQydmhoZi9aT3R5eGNYNFdqNU5OMUNFdW1CT3J4aUJsTGVDUktr?=
 =?utf-8?B?TmhPa2dlWHR1VStISk1aVGJCRXMydXRKUFV1SEJRMGw5dkwvUSt6VFZjdWkr?=
 =?utf-8?B?Mm1OR3pBeE8zcnJhNGhlOUpVeFVRa2FWTTBoanJORzFEQnpRMTUvZ3NydG14?=
 =?utf-8?B?eE1rbHRIOUI1M1djRDlXRko3Zm9WaUVMa2hydHNDN29sN3VNbTAxS2dlSnVU?=
 =?utf-8?B?OWlGU2pYckpTOXNIRkxZNXZhUWhsVzVESmtKeThOUThhb0g4RkU0ZmsydnBI?=
 =?utf-8?B?OTIzdk1aMUloaUlYUWc3RUdRRVIxTE4wdGhhalFMdGcxRkU2Wm9uc1F6UTFh?=
 =?utf-8?Q?FbdyM5u9anGpn+KIOubzyfcDt?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d8ee75-528d-4768-0e46-08dc0d4d4e8a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:06.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRTXMjkF2x8LCdUKFIDDygsMF6AugpBDM9pcHFPBZWYIapRujy1WdZpv0IVa8rH+HiRoZOl287XCymPw1yYmBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495

Dear Maintainers,

The initially merged device-tree for Clearfog GTR devices contained
various subtle mistakes and omissions:

- missing board-specific compatible strings
- missing pinctrl entries
- missing second sfp connector
- invalid sfp loss-of-signal gpio
- mismatch of labels between dsa ports and enclosure

Most notably this had caused functional issues with the sfp connectors.

This patch-set first converts the existing armada-38x dt-bindings to
yaml, replacing invalid soc-only compatibles with specific boards that
already exist in tree and represent the three SoCs (380,385,388).

Secondly for clearfog gtr pinctrl nodes are added for all referenced
gpios for independence from bootloader defaults. U-Boot is shared
between armada-388 clearfog and armada-385 clearfog gtr.

Further remove an invalid io from the first sfp connector description,
and add descriptions for the secondary sfp connector which is driven
by dsa switch port number 9.

Finally labels of dsa switch ports were updated to match the enclosure.
That patch is not suitable for stable.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v5:
- remove empty lines between description and items yaml entries
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- bindings text to yaml conversion is now single commit
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- added bindings for some existing a380, a385 and a388 boards
- removed code from commit description
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- Link to v4: https://lore.kernel.org/r/20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com

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
Josua Mayer (10):
      dt-bindings: marvell: a38x: convert soc compatibles to yaml
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
 .../bindings/arm/marvell/armada-38x.yaml           | 70 ++++++++++++++++++
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     | 38 +++++++---
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |  2 +
 .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi  | 84 ++++++++++++++++------
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |  5 +-
 6 files changed, 167 insertions(+), 59 deletions(-)
---
base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
change-id: 20231226-support-clearfog-gtr-l8-sfp-d87ae715a787

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


