Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3F78B2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjH1OJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjH1OJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:09:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7BCF7;
        Mon, 28 Aug 2023 07:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2LvREfZ6X5Jz/PVOPO/kYn6hNuqbtmAh3gmwtLFYO1Pys+5VWjYgjb5eQn1wO+BUpaFws5czk/iBzOnztvbpvJn6WxRjIJINeH3UxZI47NhRob30I/zUrROPhVba9l9afYUSsyz/2aRvYKJ1Ikr7JxqcLpgEcWCfzdsB0KzCDzi7yqiASyMkCj5or6n5nh/HI6Gp/PQPkO9cnGRioFRKUZUEfR7lIC67YKT45AZfx7ShfhaG1kX8mIC9DucEET8aug1D9j7dQiCHuKLHNvFyug+I25mXAj9GWoqf1SxLRA+Aui6wJkL8uWcHFjfwZPZtdTBQDq7T0S235dMSbBoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+IuwEJOC7QKEsaNcOJu+abqp01EpX7y2Z4pc8PQqn0=;
 b=cyVtich58LZanWev014gT1+TGG6nA6pa367gTGGCamytAYkDAy8+w5NPgm1BqcQeVJa3ZSEpDaZw2suPuq1U7Bm0jXpTVcF37lhv44S4WxCY8NeDGtcUCVMdp2qvlxHk1sWPtySkvoDpQ6POKa30yzSesPSQ7BI6FBPFGdLAZwR3wniXUxPTSpzOQntjVIgzlMwRdzj2cc8eig/dERUCmixuvZuylbnAQdNjyjxerjHeJGbuXiJCbEuzOVGc6DlrRLO1hzVqf34flNcBWrGDy3T8ZLMjS+I1lvJi6/c8HhBqCyOI9DZlNs+3gfSD5wSBNw9bIFrPR6NuQmOKxGXY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+IuwEJOC7QKEsaNcOJu+abqp01EpX7y2Z4pc8PQqn0=;
 b=Gah493vcWxXB+H75cG9CW++7r4Y+DGERRktHcRamv/hpQ+ZYfTelEEvHEsBJL7dMM+nyrYBZQZkstRU0ajXcYoETIqKxrFqET6lUaOTUMG12s3kFgf9lthgBNFw2dbAM4fTArVLu6IpI5ZaUUFnxTxYZLiM660wvtz8fOjG1aBA=
Received: from PS2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::26) by SEZPR03MB6958.apcprd03.prod.outlook.com
 (2603:1096:101:9f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:08:52 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::1a) by PS2PR01CA0014.outlook.office365.com
 (2603:1096:300:2d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 14:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 14:08:52 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 28 Aug
 2023 22:08:52 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 28 Aug
 2023 22:08:51 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 28 Aug 2023 22:08:51 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id B069764740; Mon, 28 Aug 2023 17:08:50 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v7 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
Date:   Mon, 28 Aug 2023 17:08:47 +0300
Message-ID: <20230828140849.21724-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeb844b-5e64-4a47-2ad6-08dba7d04f14
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk4zV25TMVlvdHNpWHZYVjY5ampMTTY4ZTg2UldHajV2SkVpdklQK21pVytX?=
 =?utf-8?B?QUF2elFJemZwUUxCRlhUNWpMMTFZWDRJWHVFV2RPMHpoSGpxalJZek9PSmpz?=
 =?utf-8?B?V1dBMWMwcTRKTWdnblJVNUJKUjhoMDdSamkrSU5jYXNQcEdwenFLLzFZbnF4?=
 =?utf-8?B?clZLM3dPUW9MMVg1eWs2Q1RzNnFRYVNVRlJ2Wmh3UDVWTWpsUlZLendRRjNx?=
 =?utf-8?B?bUZGY1BhVXpud2pHemRiUDBZNTh5T0U5YjFBYVc4bVplS1lzOHBVOTNCblht?=
 =?utf-8?B?OW5lb1hlTG9nSmpROHdMMkV2U1BHYUJKRkNKeXI2bHI2S2lGN3RKNzhha2g0?=
 =?utf-8?B?ZFJOV2d3T2ZkN25pQVJPTzdYZjZ2akRGT2tWNE1FN2tLQ2VZdWxHeDQ4UHE2?=
 =?utf-8?B?Ykt2WE9NSzIxenQrZ1hHRGludnY4YytFRmxOMXloUnluTHFBMmY3WENvd05l?=
 =?utf-8?B?alZkbkxnYitGQWJMWUtwY1g0MWNtQ2luWEJqbThUWE5Xby9TTlZ5VWlNY0JH?=
 =?utf-8?B?UnVGUmQ1L2V0Y3NsK0h4TUp5VTA1bmd1TjRReUNlZGN4M0xMUGdLOEdxTm1Z?=
 =?utf-8?B?bytJNXkvbWNMOEdHQmZYQVRENk1FQXJUQUdKUktGU3JiU1Z6dUdoRmRKQzNa?=
 =?utf-8?B?RlJ5M2RSSlk1L05McnluQlNwajd3bUNWT1g0L0ozTlh5TS9URWJoNzFycjBB?=
 =?utf-8?B?cFJaWjIyTDhLTkhNQ1Y2UEZQa2JXbmI4cUFYTzhoK0NLYWF0cjd2cW5jNUpw?=
 =?utf-8?B?VHlZWFM2dldEcnY4ejZFZjFwWmlwYjNKVEhDZ2hJZWlEd0FidU5ndTVkKzZx?=
 =?utf-8?B?WGlLMkZCck5RaEdqdytaT1NtR2F4dGMyNy9ScS9vZWVrckJiMlE1bnZMQTJo?=
 =?utf-8?B?YVNlNmZ6YTRMNThrdzBxOERPcXNYQkZKeUJyMC8xNG1YMWlaOElhWTgyT1hO?=
 =?utf-8?B?bndSRTNJdXFwZTBteTE3dy9aV3R3bHlhYmhKTGRjeDcyTUsrRDlWYlBaTy9q?=
 =?utf-8?B?WlRDTGtmZXlvM1luUWpjaHA4LzRQeXBGYmNVM2cwMWRoNDNKOFduekR1bnVZ?=
 =?utf-8?B?WlNIdzc0RW9USWRSdlhRUnVOT1k3R2xkeWd2WjlVM0tObk4vU0RZUTdzam85?=
 =?utf-8?B?ckowTWN1eGx6VmoxRkJLMHVRT1BsRnVubmxxSXJCUmhGTVlndjF3eXUwczY4?=
 =?utf-8?B?UnpjbklEMnBURERQY2FGMEMzNjQxZlJaQ1VuWm9laTZhN2p4aWdxVTZkNk84?=
 =?utf-8?B?S0t4T1krZXdSMTlNRFV2VWl0NWx2TkVMMVJ2ZHRhUkJicXJPT1R3b2ZwWi9z?=
 =?utf-8?Q?JshZvGwx3r1uw=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(48200799006)(61400799006)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(6666004)(966005)(73392003)(478600001)(2906002)(1076003)(2616005)(83380400001)(6266002)(336012)(26005)(82202003)(7416002)(54906003)(4326008)(41300700001)(42186006)(316002)(110136005)(8936002)(70206006)(76482006)(70586007)(8676002)(5660300002)(36756003)(40460700003)(40480700001)(55446002)(82740400003)(36860700001)(47076005)(42882007)(921005)(81166007)(356005)(12101799020)(83170400001)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:08:52.4346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeb844b-5e64-4a47-2ad6-08dba7d04f14
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6958
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds pinmux and GPIO controller for the Arbel NPCM8XX 
Baseboard Management Controller (BMC).

Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
period time.

Arbel BMC NPCM8XX Pinmux functions accessible only for pin groups 
and pin configuration parameters available only for individual pins.

Arbel BMC NPCM8XX has eight identical GPIO modules,
each module has 32 GPIO ports.

Most of the GPIO ports are multiplexed with other system functions.

The NPCM8XX pinctrl and GPIO driver were tested on NPCM845 evaluation board.

Addressed comments from:
 - Krzysztof Kozlowski: https://lore.kernel.org/lkml/eccc6a7a-b30f-8c77-77cb-5deef47a1954@linaro.org/
						https://lore.kernel.org/lkml/3a00066b-ec4e-bfdd-91bf-9f35edd72da1@linaro.org/

Changes since version 6:
- Pin controller driver
	- Remove blank line.

- Pin controller dt-binding
	- Modify pinctrl address.
	- Modify to lowercase hex.
	- Add pin naming.

Changes since version 5:
- Pin controller dt-binding
	- Modify gpio unit-address.
	- Remove blank line at EOF.

Changes since version 4:
- Pin controller driver
	- Modify DS definition.

- Pin controller dt-binding
	- Modify -mux pattern.
	- Remove tabs.

Changes since version 3:
- Pin controller driver
	- Remove unused line in Kconfig.
	- Add GPIO 183-189 GPIO support.
	- Add SPI1 CS pins.
	- Modify SMB23b pin list.
	- Remove unused module pins.
	- Fix PIN-CONFIG_OUTPUT setting.

- Pin controller dt-binding
        - Modify pin and function items.
        - Use consistent quotes.
        - drop unneseccary quote.
        - pincrtl node name modify to pinctrl@f0800260 since
          the pin controller handling was done in 0xf0800260 
          offset.

Changes since version 2:
- Pin controller driver
        - Modify kernel configuration.
        - Adding and removing include files.
        - Using the same register format size.
        - Reducing lines by command combination.
        - Remove unnecessary parentheses use.
        - Use GENMASK and BIT macros.
        - Using traditional patterns.

 - Pin controller dt-binding
        - Modify GPIO description.
        - pintcrtl node name, Sorry, I know we have a long discussion about it.
          Still, I think the best header pinctrl node name is pinctrl@f0800000. 
          because the pin mux is handled through the GCR.
	  BTW, same pinctrl header name is used in the NPCM7XX pinctrl version.
	  https://elixir.bootlin.com/linux/v6.0-rc6/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L560

Changes since version 1:
 - Pin controller driver
	- Remove unnecessary debug prints and comments.
	- Use fwnode functions.
	- Remove Redundant 'else'.
	- Use switch case instead of else if.
	- Use GENMASK and BIT macros.
	- Use dev_err_probe in probe error.
	- Use callback GPIO range.
	- Add GCR phandle property.
	- Parameter order in reversed xmas

 - Pin controller dt-binding
	- Modify name from pin to mux.
	- Add phandle property.

Tomer Maimon (2):
  dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
  pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver

 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      |  216 ++
 drivers/pinctrl/nuvoton/Kconfig               |   14 +
 drivers/pinctrl/nuvoton/Makefile              |    1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     | 2491 +++++++++++++++++
 4 files changed, 2722 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c

-- 
2.33.0

