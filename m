Return-Path: <linux-kernel+bounces-24901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1D82C474
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6951F21BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF4217540;
	Fri, 12 Jan 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ZVIIlPHa"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149061AAAE;
	Fri, 12 Jan 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV8v4F/XHZdzMV6mHe7U79AQybMCvmFvGNlD4nAocT2Rj9WMutpSviRHqUy9TGq3Y+5exX3SmfaZG9DibvRN4GRlqCayU3an7C9NXicZPCubF1aQTZt3zGew5Kf3PONf5Fep+uJGoPKzy9HN5ycmc3o90Wo5VUyFmeEmjbfUacAzuyI/P9+723QdSWvRybyzbJpCnLKRldzYbaC4x0ErJarZhzhtAd6xmhaGHrRw6dxaCSqQ/3Hw00DaaHOcqB6rKKiON67pGYGFfG8NMf/u7TzxLoR+R0SVHopB+2HKkXSX8G4gqAeM524EV9hI7Eh9uevxIU2vn04KOA4pdMLUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9JvopPBp8HAddLIQF1PrFE2wATCVqiAoGV+wZXkKWE=;
 b=IZ/yugq7oniWNQUrkR4qKTCrwFO4LAu+o4oTBAPzjY1tKxrigCMQ5edK9LvrbLEuDqaYXsQtSI1Hyb+XKQFIVuPGz3JKKHBLMQ1m05fA4H15+RIYsbTISG+wm0wd45RBkA8Zahmzoa1UVUXclJ5FlpKb2WbRsFvkoMu45rWuAAdm/Fe64LjrGu3YD/C837QC01m0kr7k64MUzMG+MNCmBjh5qg9dgkY3DJ0FblnVUaNEKX4cULJEHOR+yOBJk09M3lSOqEeDoKV/NGufWUQb78enRjI3IuhM1dqzboy9/CkW+CGj6BMjnKwK8srvVaYKMcCt4Tlvor30XktHHC5gDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9JvopPBp8HAddLIQF1PrFE2wATCVqiAoGV+wZXkKWE=;
 b=ZVIIlPHasED5uNZeOF8F588mBFyYLk0Xk/UDMQ9EqGSj+cQi3snuccueKFJbi2hPe3rLdYRexMo3uGSPX28ozuUgCv1NsgorwK3XlUXOSUY0lYHOTCootMDHEVMFf0Tv5cbx7a84Crvid6jndpBysfDrDsZKQrUS82XNRiYgkVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 17:12:40 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 17:12:39 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Date: Fri, 12 Jan 2024 18:12:25 +0100
Message-Id: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlyoWUC/1XMQQrCQAyF4atI1kYm02rRlfeQLkKTsQHbkRktS
 undHQsuXP4P3jdD1mSa4bSZIelk2eJYwm830PU8XhVNSoN3vnbkCFkEeTjUmOOAe2LquG5UQgX
 lck8a7LVyl7Z0b/kR03vVJ/quP6j6hyZChyJM4eh9wxrOOd5MMD3HXRcHaJdl+QDdrUIQrAAAA
 A==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: e28a93f2-9f14-4345-ca9a-08dc1391ae43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3TPBKHiaBPgMRMGHfm4HWxPVIaUgtDMLfgITVZ65VUvZpE6mYBehxpdj7lAL3Y1RFz0ZT0uQ7XZTsxgib7bNDj+zoglX/P7o3PhEf7x0DYI7OsCe3cf8U8/+MgaU40rwKkC1RYDCH1Wc6TCwHZM8GWQJf3eTxL1Yh9UXOHnBj/SLAczboqMihviIxbu9IgkAIUmLhIYWkjVb/N30E67Rsf1KAa7RdJr1Qqmn0+lRxCw62QjSUuWHYnh9nOys4t4SG8zBjaxbYUnwP5xYFEildvbr942jE3tUqYJdbNh4QHX1VCEQ3Udr/jjpH3CpjCtLTskGlISEnxsmXos77buzH4HBMfGY/JvNYw/WXH6RPhjt4WahGNyJIs2Cbzr9v7lOiWBeeK30X9N8TqOR37DfLNzSRMk/wGT12fZny8Wv692ei75m76Mzo1WEDCmnWlukKp5eGShmz3ibFJCC3Se1yHfksCfCIEpXhKC4isRqu/5LPouwucqi3Gz2QO9Mdv/0Th36hwRSYkCf8TuEcJ+IycWJAzwYq/WCzk4y2rJIuTrlMeJMi4ZShxtWJ/OaqzuaEvu6L07krhjH07MOQfMSFpgid5C45DVm0laBF4KsAgJiyMVCmEVb9YV6FGeKbU0YisadcxMUcjvJetO6VEDL0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(366004)(376002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(4326008)(36756003)(2616005)(26005)(5660300002)(6512007)(8936002)(8676002)(41300700001)(478600001)(2906002)(7416002)(86362001)(6666004)(38100700002)(966005)(6506007)(6486002)(66476007)(316002)(66556008)(54906003)(66946007)(110136005)(83380400001)(38350700005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWxFdzJ2RXJMdjI1UXNQRytUNnRJU3NuemxWcGp4TGdCdWFsaHAya3g4T1ly?=
 =?utf-8?B?WUFGdE0zZjBZOEM1VUROcElDU0N6Y25KTit5QlNjOENOc2VweTdRcW1Rc3Nz?=
 =?utf-8?B?eE1DOGZLcWI5OTg5dVloUlRJVlRUakIvQWVUNSt1RUQ2cDFuTm9mcUI2bnpS?=
 =?utf-8?B?YTdiT3dHTGE4aUc0T205SU9ZeEN6RnN2MmRiMUNyY0NvNElNY090dGVuM0x5?=
 =?utf-8?B?elBMSjdnbzZlYWJXRGtYK3hEbGhWcXZnQlNaaFg0Nkh5Yk9VKzdjL25CcEU4?=
 =?utf-8?B?N1dDZjJ3Rm10ZjFSTXJmZkpsUEJyemNQd2QxTU9CZGhRd0pCd0E0ZlowaUlx?=
 =?utf-8?B?Z2lURmZKK1dVSjZwZXZCVnZqVmNFTVp0eS9FVFErOFJJMHYvSmI3emptVUVy?=
 =?utf-8?B?a0FRK28veEpQQnFIOHlibWhjWWVybWhBWU1FemtqVG5qQktCZ0t1MExSK2ZK?=
 =?utf-8?B?VThnZkh3RWtnbWN0azBmbVNaOWhFcEVoc3pUMGpTaTUxUGNVRWlkQTd2RWRN?=
 =?utf-8?B?Skh3Rm81MnVsQlNrNWRiZXViRXJ2andDdzdSRXhEamFqOUpvYWxZSDJGdE14?=
 =?utf-8?B?N0dSZHBHbHF6em52cEY2MGZQTVBadzJyK09aMFFpdmNuWUliNFpmbVZpUEho?=
 =?utf-8?B?WDhCUEk0anB0K25SNVdYVGN5VitmL0pJSzcwTzhkcWtPS253SnB0V2JOYUw3?=
 =?utf-8?B?Y2MwZEVUSUk5aE1FVmYwYlM4N2s5akM5VUF2czY2YXRHTzRoV3hVeXhGR3FZ?=
 =?utf-8?B?MGYzTGgrUkg2a3JVQXRYZ29XbG82amY4ZTdFU2ROMVU0dVdyRHVVY0draWk4?=
 =?utf-8?B?YUlSSURDWmtUbXFEcmNjK0pDRDg0eW5RZ1NTSFBVSkl1K1A4NTJVak15TkU1?=
 =?utf-8?B?Y1FPTzNYTjJJWDFHMGhXWTBKYXJRZXlsWm1IUjZZc2JYdVFsNE1vTTd4TnFs?=
 =?utf-8?B?VEJpWDlFdWVPY2VYK3U0QTJzVkdwbHV3OGdsMHJXR1UyZFBHQnJ6ZWVWUmV1?=
 =?utf-8?B?VFB5bkhGc0hSZUtFSWV5d0ZEN2JXNVZGNDZtOUVNUTl2cGhxSUtQL3VVak9w?=
 =?utf-8?B?SHNTd0Q0TFd6TERwYnNvdUVMaHIyLzM5ejRRak81c1VLYTErSm4xbVplRmE0?=
 =?utf-8?B?cXJ1dnFLWWpaM2lRYnNTNTBUeVNGY2tNaTM4Ym5KcU40VkRPclFvMlZ0YitI?=
 =?utf-8?B?UEpzZFRIamRiVkZsODVJSmZOTXZCU0FqanUweEg3d2JsaFpaTFdTUTBxVFl6?=
 =?utf-8?B?S1dZY1pxSXN3ZnBBbHNSbDJLTzRCQXZIOGMwUjI0SEhzZk9xQ3BScUwxRldi?=
 =?utf-8?B?YklTMklkSC83Ylc4d25hUStjTTUyS1pmcXhzNGQ5c3REc3BsOWllQkZ0TzFQ?=
 =?utf-8?B?d0JqNWF1Wlkxd1BVUWJrQ0lueGtZZ0ZLenlBWTY2SFZNYkFYKzdueFdLSW5t?=
 =?utf-8?B?ZkVxbWFSMDNqTTdIRDFHSVBtV1J0RUt5bC8xcllDL2U4eW5UdVhpR0xxSlB5?=
 =?utf-8?B?Q0QwZ3JEOW5JcEJhMkxHM1d2eXh3clhVcHIySCtZOEcvK3RteEp2aGMxcm5a?=
 =?utf-8?B?Rjg1cG8wZGlDR0xGc0tXVFU1S0hHbTl0WWl4RC85SFJDQTFCTFFVWGJWMDU2?=
 =?utf-8?B?RFg4Rmc0VkpnYW1hUWpOeC8yRTN0RVZ1MnF1WFNtQ2dRZmJmVTg1a2dtNmF1?=
 =?utf-8?B?QkdYK2hDOXNaYzRpZm1VWWsvNWJ2amc0aXNlYXk0emd5UWVlTHJlQjJJYmw1?=
 =?utf-8?B?d2ROd08xTEdnMjdzUENDd3NwV1Q0ZlpTRkNrUU1rRm1LS0lva1dDZWc0Q1Fn?=
 =?utf-8?B?blRUdDJBZ2Z3YUNxNldEcFlkemJ1dDFJeWNxb2wzTHRoMjg3eDJYek9HU1Va?=
 =?utf-8?B?TUloSWFuWEt2cUo3eTArMVMvUXNxSFJjZmFSWmMvYjNsMVdjSGdYc2M2RlF1?=
 =?utf-8?B?QmNRMkk3a2MwVFhTa2htWlA2dkh5VWJVMTRnQ1RGT3pVbkRnU2Z4dmhER0FQ?=
 =?utf-8?B?UkFCUVR2S2Y0WS9VRWV3bUF5RW5wazJnM1VLajdqN2c3VUtGaVVjNmRMdlJK?=
 =?utf-8?B?WTBqUWR4VlJBNHVEcS9uYXI2OXh6WHZNNk9EaURvMGpMRTdtaWpvRFJTRk1V?=
 =?utf-8?Q?Kd72MGD01rwGwx/IYMCipQKbk?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a93f2-9f14-4345-ca9a-08dc1391ae43
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 17:12:39.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufXR1mPj0E2UyQeW0G5NTo4cSDfq5SE8uXSz1EPCLPahJhNSaPmk7zunBRyUKkBCPnRWh4OY6bU7ntWVsR9DwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846

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

Unfortunately dtbs_check reported many problems, I put some remarks:

- 'mux-controller' does not match any of the regexes
  The expectation seems to be that a mux-controller at minimum has an
  address, something to put behind an @. However this is a gpio mux, not
  sure how to name it better.

- unevaluated properties: interrupts, interrupt-parent
  sensors and flash yaml are missing interrupt descriptions, but these
  parts definitely have an interrupt signal in this solidrun board.

- icssg1-eth dmas is too long
  It is caused by definint 12 dmas, when ti,icssg-prueth.yaml specifies a
  maximum of 10. The pru ethernet on am64 mostly identical to am65 - see
  e.g. arch/arm64/boot/dts/ti/k3-am654-idk.dtso which also defines 12 dma.
  I cannot fix it because unsure what is the purpose of last two dmas.

- wrong names for pinctrl nodes
  Other TI DTSs consistently end with *-pins-default. Should a different
  naming convention be used?

- cdns,phy-type required property
  inherited from k3-am64-main.dtsi
  there is a PHY_NONE value in dt-bindings/phy/phy.h,
  but not allowed in phy-cadence-torrent.yaml

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- reordered patchset to drop separate patch adding iep handle to som
- moved dtbs_check warnings to cover letter
- converted abracon abx80x rtc bindings to yaml
- updated dts:
  - remove unnecessary status properties
  - changed non-generic node names
  - use color property for led descriptions,
    they have no default function on evaluation board
  - drop earlycon bootargs from chosen node
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- converted charger node to comment, part not assembled, has no bindings
- picked up acked-by on board bindings patch
- Link to v1: https://lore.kernel.org/r/20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com

---
Josua Mayer (4):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      dt-bindings: rtc: abx80x: convert to yaml
      arm64: dts: add description for solidrun am642 som and evaluation board
      arm64: dts: ti: hummingboard-t: add descriptions for m.2 pci-e and usb-3

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 -
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  56 ++
 arch/arm64/boot/dts/ti/Makefile                    |   3 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dts   |  31 +
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dts   |  37 ++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 326 +++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 638 +++++++++++++++++++++
 9 files changed, 1122 insertions(+), 31 deletions(-)
---
base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
change-id: 20240101-add-am64-som-51a1ca47edf3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


