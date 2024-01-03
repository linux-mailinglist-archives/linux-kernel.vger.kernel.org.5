Return-Path: <linux-kernel+bounces-15447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9037F822C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57331F23FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFD199B6;
	Wed,  3 Jan 2024 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YFHR7mq5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6118E16;
	Wed,  3 Jan 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE5RoeSD3kHvZ7rucCpRuG5Hg6+jrHvvz5XqzAy/5Ntd/TqSCZChryLMAb/PM7EfqlTFvVbAuFFWAvYS8wemF6El9a0Im0Id7zG0QNp19wWxatvF2MrLWQJl4f/y0HP7IGg8hBYtAP4oArP6Kadlo4cy7a4BRhTgA6T7+0DX9fvtin3UGwILZ1jluT5Fz2Z2yoE8kjpkzfqHk9HuWss1Yf70VO6R9QUmVqAa9mQX+li6HxKR2vBQNTm7q+A3BNJW9mmSL2BSAiRARuQ4Itotu8xSNSxbXFzS1H4GLhZ9DNo24R3wSLH2jdbxQfret+1I8IbTj+SNTdbzA1LOvj1Uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COoUf8/YYVQMCVYAqfhEqJ5uMuJPXijynpJqjP6KS+E=;
 b=RnXFooA3yIabkJwlH9tjB2x9AFcD/OkD1fPwK81NYH7TQVTEYICd04AZwKlnmZcgj56nf4gUSq8Yz436S89HefzPD2ScsOq0Poomil94LG3gUsrSGWqnNR/4LcxpeWYc/ys7GPTWUZ8J2wewK0Cek6wQaw7h2FPZsBo8wY2F2g2/t9yPT7gLSbD0TbOUgWtr2KSKVTe9ARbryhhJGJF+WBACuWJiMVtnIQt1brgHONxEWPzKjNHOYrLlIqY4lhAIUQH4zCjKdYjtCRPhGCNeuSf6/gQnvpIL2D2ytaMYOBB3ZVeICeZm1c/i8q7PmtIDxP8GnDwmC8T7op7DhApiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COoUf8/YYVQMCVYAqfhEqJ5uMuJPXijynpJqjP6KS+E=;
 b=YFHR7mq5D91IYXOHSAkCm+alyIFX88aEm5hFMqbWIPK8SrcxDfX6PMItomEGz8ibLFR9/xKeECanLD+F/HeUTnvCAoWvQjz++OO9G/7dASC+qzY/Nu2vgSgM5y87Y3Uwtev2degCbwXf0eW46zQd9L+ZaN4F5zkB+MAs7nlrsLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by GV1PR04MB9136.eurprd04.prod.outlook.com (2603:10a6:150:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 3 Jan
 2024 11:27:20 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 11:27:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 03 Jan 2024 12:27:12 +0100
Subject: [PATCH 2/5] arm64: dts: add description for solidrun am642 som and
 evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-add-am64-som-v1-2-dda1f9227aef@solid-run.com>
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
In-Reply-To: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|GV1PR04MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a5a56a-1208-48f3-ab2b-08dc0c4ef2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RcQFX3eLrMVyHb+95fGeK+rmLhtAVkKXvli9xW9rEka96RFp7Se0fHVJbiJfz9HpRd+eDEuQY8eACpWqwi2/k1haWH3xIsrOdvNTvvrM2pu9+lzGEc9hP7XjCKDokWXK8wCXEGYvHl22uO8+oIz4z2xWSz3L7wfc4tHiZhuFj3O+ZlCUoNEA/yHwJK0Ii8jH/WthzmDqKEcSFDsZ4PvxwhQk7YYxFgyiYvBjQomdFG2ErKZiwHyFwAE9ulyOYwB9Mw7SPP3O7F5PxN8N1XB9zfsm8qmH5HoJqJNZ5a9dQgNt/Sc8SaJ5anz+bGim5JqlkAdxQdKZbclWe4+rrzpVyIBe3l+mkfnrOsAqM4dqYhxaVRxxFVACiZzqdS6qSLuXHwp/voP6ZPDAX4pSAOGqIWGIUvko5YvfqocoCRsxASRMltt/3aejwu4o31NsRgI53OwP1ZOoftAfj5XFIjfwnyPmYx97avwRIzrJi2DnqYe3yssAA/tPcuZyaWnsz5bRtScLjnv8Ozne0nDhfiujNQ42Ks44fycEbHjH7wdSx8i/cH3jYJaW9PmcmkgRVU9mKUP2PcP6+54GTVjIoH2UP9ny/VH8bAVGfpKZpdOt7sAyeY+8I8fJ3DtoeuFnQ0nAVH3L2s6Rw0sKg9zx5Kjj8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39840400004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(966005)(6486002)(38100700002)(26005)(107886003)(478600001)(2616005)(30864003)(41300700001)(36756003)(86362001)(52116002)(66556008)(110136005)(38350700005)(316002)(66946007)(6506007)(6512007)(66476007)(8936002)(4326008)(6666004)(8676002)(83380400001)(19627235002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE1jSXpXemMyNlBJeFpTS1V1U04zYU80MW5lN0FvNFhRQ2hFamRWRlJERnFj?=
 =?utf-8?B?SnpYZWVTSWk3UTNTL2ZTcDlxQkNxbmxJSitUeXphVGRmcmw1ZVkrbXl4SGRs?=
 =?utf-8?B?czVWUnBqa1MySlJQbVNTb2doV1ZEMWlTRTduMkE3Y3Jka3EyYjg0RS9GQkhk?=
 =?utf-8?B?VjRjOGw4Yi9OdmhUVzIwd0hDV2YzYUJJM3dkUGc5NEU5ZGtjNEFWbm1JOGJT?=
 =?utf-8?B?cUk1NjhGQVVpL2piWW44enlEazZmcXpZZ2J5MnAvaG1WbFMwNTF1NUU2SFV4?=
 =?utf-8?B?MmdnVXVCUm00TDJiNzdyRGk1ZEt2SjhpTVNLWEdubWlsa2tPd2RjalJyN3Yv?=
 =?utf-8?B?NmhpbzhIakhGaEZybjBSMVgrUWZpdFY3SEM4YXVPbW9IK3N2SHptNjJIT2ZV?=
 =?utf-8?B?QlhHRFcrN1FQenhrVVZPeUNkNTdLTktzMzZWTFNhbC9KV3pPem13NHRqUG5a?=
 =?utf-8?B?OUFJVSs3ZFZldVpuc2NoSkF4WjBKcWljN0JyVVc4TzZaN05UN2dCUGdwUnNa?=
 =?utf-8?B?d3p6bUFxOTcvOE51aFVqUS9STFlYY2FIZDVEWFBOSm5qSkJNWmhPR05sMFZ5?=
 =?utf-8?B?MTBxQzMxUjRDMnJlVlZ4ZC9ITXk5RXhsOGU0Q3lOdVA2SHBLVVM0RWhSK2Q4?=
 =?utf-8?B?Umhzd3F2K0pCeWQybDY4WTkwOGltcHF2U0JUdVFyRG5ITnQ1TUU3ZmYvRXZJ?=
 =?utf-8?B?SXdNQ0F6OCtNRE1JR081clhuRGo2anRPb1Jsa3NjRWZRSkRjZmpYZkxselBF?=
 =?utf-8?B?SnRtMlR0dlZ6V2hNN01oWnhCWk0xZ3NmZXhVaGdMRU9NUHpqRDVJenFPaGtO?=
 =?utf-8?B?MHVobVR3ZnlMMHBBWTJmamdxcy9BbkZlS1BJL2FxMi9RL3R2Qng4Z3RxM0xo?=
 =?utf-8?B?azZXbWVqdEw5cVpYeTVSbHVjS0ZkQlVxUEJaVG5pUFJjNTBGc2F2YkI5UStl?=
 =?utf-8?B?VHlyaTZYK2g2eDZ6UHZOaWhjY09uc1R3YVRWQkNTVXBPQklZNy9BN3o5b1E3?=
 =?utf-8?B?eUFMdTFjZldDNlVWREtXaWpnTW1oaVpzT1UzMm1EbEl6UXBNVEgvN1hDNE42?=
 =?utf-8?B?TjBmc1JkRmpEK2g0dndqSit4QW9pOHo3QitMcWdUMVI0V3Y3aHQ4aDFBY3dm?=
 =?utf-8?B?YS9zM3paUld2eWtNS1o2eGs4dk1ObU9hWk1Eb3NvM3FFWkpqVU9UWGZvdkVx?=
 =?utf-8?B?VE1pc0FBMW5DWkJ1NkZhNVVsaEdNdkJHRHI0WmhSQ1U5THhsVkxjQUdiQXBT?=
 =?utf-8?B?WEFVa0ZEOGJYczFOdlMzbHZRVEY1UXBBakxSWmUzVDFmR2o2cHl4RXVod1Iw?=
 =?utf-8?B?S08yYXR1ZGFQQ1RJSWpwOXRPMGFZNldwREg0K00rck9VdWs3b3pxK2xCZ0tK?=
 =?utf-8?B?Q0RRSjBEK2Q5NWRRN2ZIckp3UGlEbVVCVDIzZG9HNFpiV0h2KzhVcmlmRTN6?=
 =?utf-8?B?d0IxQWg5OCtZSmt0bG8vc21MOHFVMjZ3R1lHdUl5WmtnOERxRWtvVjIvV3RU?=
 =?utf-8?B?K2x5eERxVTZYUThkdUd3Mnc5bkpQditLZFMwTllLYVA0OWFUT0k3KzRvOWUy?=
 =?utf-8?B?b0drZlRiYXZlMVdkemRqUDJTWlNEb3Mzb2tJbDlHTlpGb2ZJamhkNVVsekpT?=
 =?utf-8?B?ejljdFJ6MndHN3FiM2s5bDJKbGN1YTZOUlZmL2JKVE1rL0JiUk1EYU5ORlZM?=
 =?utf-8?B?ckZFcXY1VUhTeUgyMFBURytYTWp5MEpJS2hkR2ZkVGJYVnpxK29GQ2hLeFlh?=
 =?utf-8?B?WnUzT01iUTF1NTFzODcyUUlVaEtZZUs4UVJIcUZzSXZ0QUlEMXAxZlM1bkM5?=
 =?utf-8?B?QXd0N3puZWVVZ2VyRlA3ajhGZThFczExRU15MEsveEJUT0h0RFFqOGc1NzM1?=
 =?utf-8?B?dDMrZmpOZEt3dGt2dlIzNXpLQ1NZUkFNOUg1VlJjdXp0aWNzeUl6U3B2a3VN?=
 =?utf-8?B?aUE3OXNueHpHSGF6V0psZk1EK2EvZ2JRaXkwdE1YbHFXcmkva3pXa2ExRm90?=
 =?utf-8?B?OXRsRTVWZVkyN1cxMEdoL0F3TTg1QUYzUlpLRzFxTi9IZHcwK0xjRDBvSk51?=
 =?utf-8?B?ajJJdDQ3L3Q0QnhiSi9tNllPUCtBZkFqb0t1UXpkalBqTVVucy9lRFhENCt0?=
 =?utf-8?Q?SASExknjALKNeph35obzTep9W?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a5a56a-1208-48f3-ab2b-08dc0c4ef2c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 11:27:20.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSbFTP3cr38F8Gq0ezfiFhHdigZTice0m69aAzaTbELGOw6rEcoBcMoBCkWbhHUjD+VxhDvLq/NpZvamQgRTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9136

Add description for the SolidRun AM642 SoM, and HummingBoard-T
evaluation board.

The SoM features:
- 1x cpsw ethernet with phy
- 2x pru ethernet with phy
- eMMC
- spi flash (assembly option)

Additionally microSD and usb-2.0 otg are included in the SoM
description as they are supported boot sources for the SOC boot-rom.

The Carrier provides:
- 3x RJ45 connector
- 2x M.2 connector
- USB-2.0 Hub
- USB-A Connector
- LEDs
- 2x CAN transceiver
- 1x RS485 transceiver
- sensors

The M.2 connectors support either USB-3.1 or PCI-E depending on status
of a mux. By default the mux is switched off.

RFC: dtbs_check reports:

- error in pru ethernet:

  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: icssg1-eth: dmas: [[12, 49664, 15], [12, 49665, 15], [12, 49666, 15], [12, 49667, 15], [12, 49668, 15], [12, 49669, 15], [12, 49670, 15], [12, 49671, 15], [12, 16896, 15], [12, 16897, 15], [12, 16898, 0], [12, 16899, 0]] is too long
  from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: icssg1-eth: Unevaluated properties are not allowed ('dmas' was unexpected)
  from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#

  It is caused by definint 12 dmas, when ti,icssg-prueth.yaml specifies a
  maximum of 10. The pru ethernet on am64 mostly identical to am65 - see
  e.g. arch/arm64/boot/dts/ti/k3-am654-idk.dtso which also defines 12 dma.

  At least for this revision I am skipping fixing the bindings, because
  aside from raising the maximum to 12, dma-names also has just 10 entries
  - and  don't know which names would be correct to add.

- undocumented compatible ti,bq25713 (battery charger)

  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtb: /bus@f4000/i2c@20000000/battery-charger@6a: failed to match any schema with compatible: ['ti,bq25713']

  This specific charger has no linux support yet, I am not sure where
  (or whether) to document the new compatible.
  The reference could also be dropped completely, since the charger is
  not assebled by default.

- undocumented compatible for rtc: "abracon,abx80x"

  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtb: /bus@f4000/i2c@20010000/am1805aq@69: failed to match any schema with compatible: ['abracon,abx80x']

  It is actually documented in text format:
  Documentation/devicetree/bindings/rtc/abracon,abx80x.txt

- phy@0:cdns,phy-type:0:0: 0 is less than the minimum of 1

  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: serdes@f000000: phy@0:cdns,phy-type:0:0: 0 is less than the minimum of 1
  from schema $id: http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#

  I used value 0 here on purpose (phy.h: #define PHY_NONE 0), however
  maybe better to choose a specific protocol?
  Or better to update binding and allow 0?

- interrupt properties not allowed for spi flash

  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: flash@0: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
  from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#

  The assembled flash memory "sh28hs512t" definitely has an interrupt
  pin wired to a cpu gpio. Should interrupts be added to spi flash
  binding?

- wrong names for pinctrl nodes

  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: pinctrl@f4000: 'ethernet-phy-pins-default', 'ethernet-phy0-pins-default', 'ethernet-phy1-pins-default', 'ethernet-phy2-pins-default', 'leds-pins-default', 'main-i2c0-pins-default', 'main-i2c0-pins-int-default', 'main-i2c1-int-pins-default', 'main-i2c1-pins-default', 'main-mcan0-pins-default', 'main-mcan1-pins-default', 'main-mmc1-pins-default', 'main-uart0-pins-default', 'main-uart3-pins-default', 'mdio0-pins-default', 'ospi0-flash0-pins-default', 'ospi0-pins-default', 'pcie0-pins-default', 'pru-rgmii1-pins-default', 'pru-rgmii2-pins-default', 'pru1-mdio0-pins-default', 'regulator-pcie-3v3-pins-default', 'regulator-vpp-1v8-pins-default', 'rgmii1-pins-default', 'serdes-mux-pins-default', 'usb0-pins-default' do not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'

  Other TI DTSs consistently end with *-pins-default. Should a different
  naming convention be used?

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |   1 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 333 +++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 638 +++++++++++++++++++++
 3 files changed, 972 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 77a347f9f47d..041c3b71155e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
new file mode 100644
index 000000000000..f7b48ada8ef3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-am642.dtsi"
+#include "k3-am642-sr-som.dtsi"
+
+/ {
+	model = "SolidRun AM642 HummingBoard-T";
+	compatible = "solidrun,am642-hummingboard-t", "solidrun,am642-sr-som", "ti,am642";
+
+	aliases {
+		serial5 = &main_uart3;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>;
+		status = "okay";
+
+		/* D24 */
+		led1: led-1 {
+			label = "led1:green";
+			gpios = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* D25 */
+		led2: led-2 {
+			label = "led2:green";
+			gpios = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* D26 */
+		led3: led-3 {
+			label = "led3:green";
+			gpios = <&main_gpio0 33 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	regulator-m2-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&regulator_pcie_3v3_pins_default>;
+		regulator-name = "m2-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&main_gpio1 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	regulator-vpp-1v8 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&regulator_vpp_1v8_pins_default>;
+		regulator-name = "vpp-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&main_gpio1 78 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	serdes_mux: mux-controller {
+		compatible = "gpio-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&serdes_mux_pins_default>;
+		#mux-control-cells = <0>;
+		/*
+		 * Mux has 2 IOs:
+		 * - select: 0 = USB-3 (M2); 1 = PCIE (M1)
+		 * - shutdown: 0 = active; 1 = disabled (high impedance)
+		 */
+		mux-gpios = <&main_gpio1 40 GPIO_ACTIVE_HIGH>, <&main_gpio1 41 GPIO_ACTIVE_HIGH>;
+		/* default disabled */
+		idle-state = <2>;
+	};
+};
+
+&main_gpio0 {
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m2-reset";
+	};
+
+	m1-m2-w-disable1-hog {
+		gpio-hog;
+		gpios = <32 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m1-m2-pcie-w-disable1";
+	};
+
+	m1-m2-w_disable2-hog {
+		gpio-hog;
+		gpios = <34 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m1-m2-pcie-w-disable2";
+	};
+};
+
+&main_gpio1 {
+	status = "okay";
+
+	m1-pcie-clkreq0-hog {
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "m1-pcie-clkreq0";
+	};
+
+	m2-pcie-clkreq-hog {
+		gpio-hog;
+		gpios = <35 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "m2-pcie-clkreq";
+	};
+};
+
+&main_i2c0 {
+	pinctrl-0 = <&main_i2c0_pins_default>, <&main_i2c0_int_pins_default>;
+
+	humidity-sensor@41 {
+		compatible = "ti,hdc2010";
+		reg = <0x41>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
+		status = "okay";
+	};
+
+	light-sensor@44 {
+		compatible = "ti,opt3001";
+		reg = <0x44>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
+		status = "okay";
+	};
+
+	battery-charger@6a {
+		compatible = "ti,bq25713";
+		reg = <0x6a>;
+		status = "okay";
+	};
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>, <&main_i2c1_int_pins_default>;
+	status = "okay";
+
+	rtc: am1805aq@69 {
+		compatible = "abracon,abx80x";
+		reg = <0x69>;
+		abracon,tc-diode = "schottky";
+		abracon,tc-resistor = <3>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+		status = "okay";
+	};
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <8000000>;
+	};
+};
+
+&main_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan1_pins_default>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <8000000>;
+	};
+};
+
+&main_pmx0 {
+	leds_pins_default: leds-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0074, PIN_OUTPUT, 7)	/* GPMC0_AD14.GPIO0_29 */
+			AM64X_IOPAD(0x0078, PIN_OUTPUT, 7)	/* GPMC0_AD15.GPIO0_30 */
+			AM64X_IOPAD(0x0088, PIN_OUTPUT, 7)	/* GPMC0_OEn_REn.GPIO0_33 */
+		>;
+	};
+
+	main_i2c0_int_pins_default: main-i2c0-pins-int-default {
+		pinctrl-single,pins = <
+			/* external pull-up on Carrier */
+			AM64X_IOPAD(0x0098, PIN_INPUT, 7)	/* GPMC0_WAIT0.GPIO0_37 */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x0268, PIN_INPUT, 0)	/* I2C1_SCL.I2C1_SCL */
+			AM64X_IOPAD(0x026c, PIN_INPUT, 0)	/* I2C1_SDA.I2C1_SDA */
+		>;
+	};
+
+	main_i2c1_int_pins_default: main-i2c1-int-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-up on Carrier */
+			AM64X_IOPAD(0x00b4, PIN_INPUT, 7)	/* GPMC0_CSn3.GPIO0_44 */
+		>;
+	};
+
+	main_mcan0_pins_default: main-mcan0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0254, PIN_INPUT, 0)	/* MCAN0_RX.MCAN0_RX */
+			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0)	/* MCAN0_TX.MCAN0_TX */
+		>;
+	};
+
+	main_mcan1_pins_default: main-mcan1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x025c, PIN_INPUT, 0)	/* MCAN1_RX.MCAN1_RX */
+			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0)	/* MCAN1_TX.MCAN1_TX */
+		>;
+	};
+
+	main_uart3_pins_default: main-uart3-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x016c, PIN_INPUT, 10)	/* PRG0_PRU0_GPO3.UART3_CTSn */
+			AM64X_IOPAD(0x0170, PIN_OUTPUT, 10)	/* PRG0_PRU0_GPO4.UART3_TXD */
+			AM64X_IOPAD(0x0174, PIN_OUTPUT, 10)	/* PRG0_PRU0_GPO5.UART3_RTSn */
+			AM64X_IOPAD(0x01ac, PIN_INPUT, 10)	/* PRG0_PRU0_GPO19.UART3_RXD */
+		>;
+	};
+
+	pcie0_pins_default: pcie0-pins-default {
+		pinctrl-single,pins = <
+			/* connector M2 RESET */
+			AM64X_IOPAD(0x0030, PIN_OUTPUT, 7)	/* OSPI0_CSn1.GPIO0_12 */
+			/* connectors M1 & M2 W_DISABLE1 */
+			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7)	/* GPMC0_ADVN_ALE.GPIO0_32 */
+			/* connectors M1 & M2 W_DISABLE2 */
+			AM64X_IOPAD(0x008c, PIN_OUTPUT, 7)	/* GPMC0_WEN.GPIO0_34 */
+			/* connectors M1 & M2 PERST0 (PCI Reset) */
+			AM64X_IOPAD(0x019c, PIN_OUTPUT, 7)	/* PRG0_PRU0_GPO15.GPIO1_15 */
+			/* connector M1 CLKREQ0 */
+			AM64X_IOPAD(0x018c, PIN_INPUT, 7)	/* PRG0_PRU0_GPO11.GPIO1_11 */
+			/* connector M2 CLKREQ0 */
+			AM64X_IOPAD(0x01ec, PIN_INPUT, 7)	/* PRG0_PRU1_GPO15.GPIO1_35 */
+		>;
+	};
+
+	regulator_pcie_3v3_pins_default: regulator-pcie-3v3-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01a4, PIN_OUTPUT, 7)	/* PRG0_PRU0_GPO17.GPIO1_17 */
+		>;
+	};
+
+	regulator_vpp_1v8_pins_default: regulator-vpp-1v8-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x029c, PIN_OUTPUT, 7)	/* MMC1_SDWP.GPIO1_78 */
+		>;
+	};
+
+	serdes_mux_pins_default: serdes-mux-pins-default {
+		pinctrl-single,pins = <
+			/* SEL, 10k pull-down on carrier, 2.2k pullup on SoM */
+			AM64X_IOPAD(0x0200, PIN_OUTPUT, 7)	/* PRG0_MDIO0_MDIO.GPIO1_40 */
+			/* EN */
+			AM64X_IOPAD(0x0204, PIN_OUTPUT, 7)	/* PRG0_MDIO0_MDC.GPIO1_41 */
+		>;
+	};
+};
+
+&main_uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart3_pins_default>;
+	uart-has-rtscts;
+	rs485-rts-active-low;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins_default>;
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	mux-controls = <&serdes_mux>;
+	mux-control-names = "serdes";
+	status = "disabled";
+};
+
+&pcie0_ep {
+	phys = <&serdes0_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "disabled";
+};
+
+&serdes0 {
+	/*
+	 * Serdes Signals are routed via mux to either m.2 connectors:
+	 * - M1: USB-3.1
+	 * - M2: PCI-E
+	 */
+	status = "okay";
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_NONE>;
+		resets = <&serdes_wiz0 1>;
+		status = "okay";
+	};
+};
+
+&usb0 {
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
new file mode 100644
index 000000000000..952a262d6874
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/net/ti-dp83869.h>
+
+/ {
+	model = "SolidRun AM642 SoM";
+	compatible = "solidrun,am642-sr-som", "ti,am642";
+
+	aliases {
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &icssg1_emac0;
+		ethernet2 = &icssg1_emac1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		serial2 = &main_uart0;
+	};
+
+	chosen {
+		/* SoC default UART console */
+		stdout-path = "serial2:115200n8";
+		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	/* PRU Ethernet Controller */
+	icssg1_eth: icssg1-eth {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pru_rgmii1_pins_default>, <&pru_rgmii2_pins_default>;
+
+		sram = <&oc_sram>;
+		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+
+		ti,mii-g-rt = <&icssg1_mii_g_rt>;
+		ti,mii-rt = <&icssg1_mii_rt>;
+
+		interrupt-parent = <&icssg1_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4201 15>, /* ingress slice 1 */
+		       <&main_pktdma 0x4202 0>, /* mgmnt rsp slice 0 */
+		       <&main_pktdma 0x4203 0>; /* mgmnt rsp slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+
+		status = "okay";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			icssg1_emac0: port@0 {
+				reg = <0>;
+				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				phy-handle = <&ethernet_phy2>;
+				phy-mode = "rgmii-id";
+				status = "okay";
+			};
+
+			icssg1_emac1: port@1 {
+				reg = <1>;
+				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				phy-handle = <&ethernet_phy1>;
+				phy-mode = "rgmii-id";
+				status = "okay";
+			};
+		};
+	};
+
+	/* DDR16SS0:
+	 * - Bank 1 @ 0x080000000-0x0FFFFFFFF: max. 2GB in 32-bit address space
+	 * - Bank 2 @ 0x880000000-0x9FFFFFFFF: max. 6GB in 64-bit address space
+	 */
+	memory@80000000 {
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000001 0x80000000>;
+		device_type = "memory";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+	};
+
+	vdd_mmc0: regulator-vdd-mmc0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-mmc0";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_pins_default>;
+	status = "okay";
+};
+
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins_default>;
+	status = "okay";
+
+	ethernet_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy0_pins_default>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 84 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+		 status = "okay";
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+	status = "okay";
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
+&icssg0_mdio {
+	status = "disabled";
+};
+
+&icssg1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pru1_mdio0_pins_default>;
+	status = "okay";
+
+	ethernet_phy1: ethernet-phy@3 {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy1_pins_default>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 20 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+		 status = "okay";
+	};
+
+	ethernet_phy2: ethernet-phy@f {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <0xf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy2_pins_default>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 52 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+		 status = "okay";
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster3 {
+	status = "disabled";
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster5 {
+	status = "disabled";
+};
+
+&mailbox0_cluster6 {
+	status = "disabled";
+};
+
+&mailbox0_cluster7 {
+	status = "disabled";
+};
+
+&main_gpio0 {
+	status = "okay";
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	status = "okay";
+
+	som_eeprom: eeprom@50 {
+		compatible = "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+&main_pmx0 {
+	/* hog global functions */
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_phy_pins_default>;
+
+	ethernet_phy_pins_default: ethernet-phy-pins-default {
+		pinctrl-single,pins = <
+			/* interrupt / power-down, external pull-up on SoM */
+			AM64X_IOPAD(0x0278, PIN_INPUT, 7)	/* EXTINTn.GPIO1_70 */
+		>;
+	};
+
+	ethernet_phy0_pins_default: ethernet-phy0-pins-default {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x0154, PIN_OUTPUT, 7)	/* PRG1_PRU1_GPO19.GPIO0_84 */
+			/* reference clock */
+			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5)	/* EXT_REFCLK1.CLKOUT0 */
+		>;
+	};
+
+	ethernet_phy1_pins_default: ethernet-phy1-pins-default {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x0150, PIN_OUTPUT, 7)	/* PRG1_PRU1_GPO18.GPIO0_20 */
+			/* led0, external pull-down on SoM */
+			AM64X_IOPAD(0x0128, PIN_INPUT, 7)	/* PRG1_PRU1_GPO8.GPIO0_73 */
+			/* led1/rxer */
+			AM64X_IOPAD(0x011c, PIN_INPUT, 7)	/* PRG1_PRU1_GPO5.GPIO0_70 */
+		>;
+	};
+
+	ethernet_phy2_pins_default: ethernet-phy2-pins-default {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x00d4, PIN_OUTPUT, 7)	/* PRG1_PRU0_GPO7.GPIO0_52 */
+			/* led0, external pull-down on SoM */
+			AM64X_IOPAD(0x00d8, PIN_INPUT, 7)	/* PRG1_PRU0_GPO8.GPIO0_53 */
+			/* led1/rxer */
+			AM64X_IOPAD(0x00cc, PIN_INPUT, 7)	/* PRG1_PRU0_GPO5.GPIO0_50 */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x0260, PIN_INPUT, 0)	/* I2C0_SCL.I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT, 0)	/* I2C0_SDA.I2C0_SDA */
+		>;
+	};
+
+	/*
+	 * main_mmc0_pins_default: main-mmc0-pins-default
+	 *
+	 * MMC0_CMD: no padconfig
+	 * MMC0_CLK: no padconfig, external pull-up on SoM
+	 * MMC0_DAT0: no padconfig
+	 * MMC0_DAT1: no padconfig
+	 * MMC0_DAT2: no padconfig
+	 * MMC0_DAT3: no padconfig
+	 * MMC0_DAT4: no padconfig
+	 * MMC0_DAT5: no padconfig
+	 * MMC0_DAT6: no padconfig
+	 * MMC0_DAT7: no padconfig
+	 * MMC0_DS: no padconfig, external pull-down on SoM
+	 */
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
+			AM64X_IOPAD(0x028c, PIN_INPUT, 0)		/* MMC1_CLK.MMC1_CLK */
+			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT0.MMC1_DAT0 */
+			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT1.MMC1_DAT1 */
+			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT2.MMC1_DAT2 */
+			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT3.MMC1_DAT3 */
+			/* external pull-down on SoM & Carrier */
+			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* MMC1_SDCD.MMC1_SDCD */
+			AM64X_IOPAD(0x0290, PIN_INPUT, 0)		/* MMC1_CLKLB: clock loopback */
+		>;
+	};
+
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0230, PIN_INPUT, 0)		/* UART0_RXD.UART0_RXD */
+			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)		/* UART0_TXD.UART0_TXD */
+		>;
+	};
+
+	mdio0_pins_default: mdio0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)		/* PRG0_PRU1_GPO19.MDIO0_MDC */
+			AM64X_IOPAD(0x01f8, PIN_INPUT, 4)		/* PRG0_PRU1_GPO18.MDIO0_MDIO */
+		>;
+	};
+
+	ospi0_pins_default: ospi0-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-down on SoM */
+			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)		/* OSPI0_CLK.OSPI0_CLK */
+			AM64X_IOPAD(0x0008, PIN_OUTPUT, 0)		/* OSPI0_DQS.OSPI0_DQS */
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)		/* OSPI0_CSn0.OSPI0_CSn0 */
+			AM64X_IOPAD(0x000c, PIN_INPUT, 0)		/* OSPI0_D0.OSPI0_D0 */
+			AM64X_IOPAD(0x0010, PIN_INPUT, 0)		/* OSPI0_D1.OSPI0_D1 */
+			AM64X_IOPAD(0x0014, PIN_INPUT, 0)		/* OSPI0_D2.OSPI0_D2 */
+			AM64X_IOPAD(0x0018, PIN_INPUT, 0)		/* OSPI0_D3.OSPI0_D3 */
+			AM64X_IOPAD(0x001c, PIN_INPUT, 0)		/* OSPI0_D4.OSPI0_D4 */
+			AM64X_IOPAD(0x0020, PIN_INPUT, 0)		/* OSPI0_D5.OSPI0_D5 */
+			AM64X_IOPAD(0x0024, PIN_INPUT, 0)		/* OSPI0_D6.OSPI0_D6 */
+			AM64X_IOPAD(0x0028, PIN_INPUT, 0)		/* OSPI0_D7.OSPI0_D7 */
+		>;
+	};
+
+	ospi0_flash0_pins_default: ospi0-flash0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0034, PIN_OUTPUT, 7)		/* OSPI0_CSn2.GPIO0_13 */
+			AM64X_IOPAD(0x0038, PIN_INPUT, 7)		/* OSPI0_CSn3.GPIO0_14 */
+		>;
+	};
+
+	pru1_mdio0_pins_default: pru1-mdio0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0)		/* PRG1_MDIO0_MDC.PRG1_MDIO0_MDC */
+			AM64X_IOPAD(0x0158, PIN_INPUT, 0)		/* PRG1_MDIO0_MDIO.PRG1_MDIO0_MDIO */
+		>;
+	};
+
+	pru_rgmii1_pins_default: pru-rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 2)		/* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 2)		/* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 2)		/* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 2)		/* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 2)		/* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 2)		/* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 2)		/* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
+			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 2)		/* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
+			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 2)		/* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
+			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 2)		/* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
+			AM64X_IOPAD(0x00f8, PIN_INPUT, 2)		/* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
+			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 2)		/* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
+		>;
+	};
+
+	pru_rgmii2_pins_default: pru-rgmii2-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0108, PIN_INPUT, 2)		/* PRG1_PRU1_GPO0.RGMII2_RD0 */
+			AM64X_IOPAD(0x010c, PIN_INPUT, 2)		/* PRG1_PRU1_GPO1.RGMII2_RD1 */
+			AM64X_IOPAD(0x0110, PIN_INPUT, 2)		/* PRG1_PRU1_GPO2.RGMII2_RD2 */
+			AM64X_IOPAD(0x0114, PIN_INPUT, 2)		/* PRG1_PRU1_GPO3.RGMII2_RD3 */
+			AM64X_IOPAD(0x0120, PIN_INPUT, 2)		/* PRG1_PRU1_GPO6.RGMII2_RXC */
+			AM64X_IOPAD(0x0118, PIN_INPUT, 2)		/* PRG1_PRU1_GPO4.RGMII2_RX_CTL */
+			AM64X_IOPAD(0x0134, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO11.RGMII2_TD0 */
+			AM64X_IOPAD(0x0138, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO12.RGMII2_TD1 */
+			AM64X_IOPAD(0x013c, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO13.RGMII2_TD2 */
+			AM64X_IOPAD(0x0140, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO14.RGMII2_TD3 */
+			AM64X_IOPAD(0x0148, PIN_INPUT, 2)		/* PRG1_PRU1_GPO16.RGMII2_TXC */
+			AM64X_IOPAD(0x0144, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO15.RGMII2_TX_CTL */
+		>;
+	};
+
+	rgmii1_pins_default: rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01cc, PIN_INPUT, 4)		/* PRG0_PRU1_GPO7.RGMII1_RD0 */
+			AM64X_IOPAD(0x01d4, PIN_INPUT, 4)		/* PRG0_PRU1_GPO9.RGMII1_RD1 */
+			AM64X_IOPAD(0x01d8, PIN_INPUT, 4)		/* PRG0_PRU1_GPO10.RGMII1_RD2 */
+			AM64X_IOPAD(0x01f4, PIN_INPUT, 4)		/* PRG0_PRU1_GPO17.RGMII1_RD3 */
+			AM64X_IOPAD(0x0188, PIN_INPUT, 4)		/* PRG0_PRU0_GPO10.RGMII1_RXC */
+			AM64X_IOPAD(0x0184, PIN_INPUT, 4)		/* PRG0_PRU0_GPO9.RGMII1_RX_CTL */
+			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO7.RGMII1_TD0 */
+			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO9.RGMII1_TD1 */
+			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO10.RGMII1_TD2 */
+			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO17.RGMII1_TD3 */
+			AM64X_IOPAD(0x00e0, PIN_INPUT, 4)		/* PRG1_PRU0_GPO10.RGMII1_TXC */
+			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4)		/* PRG1_PRU0_GPO9.RGMII1_TX_CTL */
+		>;
+	};
+
+	usb0_pins_default: usb0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)		/* USB0_DRVVBUS.USB0_DRVVBUS */
+		>;
+	};
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
+};
+
+/* SoC default UART console */
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	status = "okay";
+};
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+	num-cs = <1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ospi0_flash0_pins_default>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <200000000>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		cdns,read-delay = <0>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&main_gpio0 13 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
+};
+
+&sdhci0 {
+	/* mmc0 pins have no padconfig */
+	bus-width = <8>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	non-removable;
+	cap-mmc-hw-reset;
+	no-sd;
+	/*
+	 * MMC controller supports switching between 1.8V and 3.3V signalling.
+	 * However MMC0 (unlike MMC1) does not integrate an LDO.
+	 * Explicitly link a regulator node for indicating to the driver which
+	 * voltages are actually usable.
+	 */
+	vqmmc-supply = <&vdd_mmc0>;
+	status = "okay";
+};
+
+/*
+ * microSD is on carrier - however since SoC can boot from it,
+ * configure it just in case.
+ */
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	bus-width = <4>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	status = "okay";
+};
+
+&tscadc0 {
+	status = "disabled";
+};
+
+/*
+ * USB settings are a carrier choice - however since SoC can boot from it,
+ * configure as USB-2.0 OTG here, keeping USB-3 serdes disabled.
+ */
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins_default>;
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+	ti,usb2-only;
+	status = "okay";
+};

-- 
2.35.3


