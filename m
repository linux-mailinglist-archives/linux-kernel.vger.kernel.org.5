Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7088F78A16E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 22:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjH0Ugm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 16:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjH0Ugf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 16:36:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0D128;
        Sun, 27 Aug 2023 13:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT74JyoBVImvf+gUB+HNNv+Uk+ChR1vmfqaS2/mrz8ZAZdORKDKBfki5rqlhMXlKnxISlrbWPwCj96HDXsfBsKyDgZtGv4EieZiTSFzYvR3uSWOe6ffPncokOeBvW6s5mh4iBRJvKMNk3vcdNmJwPjDwt7V3qSSpKeETylXgwF6ZpQAWqiZ9lz2GC7ZKArBSyU4ZTlobARBiA3pmPtJX9nwZ7jZM7O8ARUgmzmO9w/sT7oiV0HXGhOgSoY9uCzGgDMUnYeyrOygL8rllZak/4k+Aup45Pr9qGYclrq59UUwYhNrJOye0KAaygWok6k/qhkGCNYzmNzHIKYIYzkd9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcKaXGUbTIwgwWBf9MoobrMEwMoCtB+WXuvo2wiYiuE=;
 b=TYw5BJugArvzuceCq3AjsQlc4k/N2HciOKBQzAvDtZTnh8D9x1sXG4RR6B/figAxCvdUKB1biM0mch9f/wj6UR5SSa2B31sz21fLD/Nz0KNGxtR4h9dBdqOXHdqrYyeKdacaueBGZDTXgNVa4uYdmXtUBC6Er2r5J3SCwf5VRSUAombdyI4eFHt4+Jbg7L2kni3C/DIzhSg2o+nExq6lub2qS8fV6S/Z+0GQgVZSeBOWc0b4fKaoTjmyPEp+Daf/WynO853sceg7zRySDtOmu3bQbctfJ2lNM7C10YLoFNu47fLD+qFlOwFjwEyq8YpCnzil/WM8pkC1RyAsEkuWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcKaXGUbTIwgwWBf9MoobrMEwMoCtB+WXuvo2wiYiuE=;
 b=bJRdVQNDaC1sMuvxlrIG+ppKFnXtvgqddG4eRl4A1xD8XCvxewfyRl9busWbWXOLfWAAGHzDIWSwxByN7wJY/L9SPGRq9b/VIjGmXUoIeCNvVqHeej1sS1NinN+xFqD1m9pTXEnmIFzYt96V4mtLq4L/7BGQzdc5anw+pylmCCo=
Received: from SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19) by
 JH0PR03MB7594.apcprd03.prod.outlook.com (2603:1096:990:9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Sun, 27 Aug 2023 20:36:28 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:0:cafe::df) by SG2PR04CA0157.outlook.office365.com
 (2603:1096:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Sun, 27 Aug 2023 20:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Sun, 27 Aug 2023 20:36:26 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 28 Aug
 2023 04:36:26 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 28 Aug
 2023 04:36:25 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 28 Aug 2023 04:36:25 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C9F306473F; Sun, 27 Aug 2023 23:36:24 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v6 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
Date:   Sun, 27 Aug 2023 23:36:10 +0300
Message-ID: <20230827203612.173562-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|JH0PR03MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 71633b5f-60db-4365-1e69-08dba73d4967
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1Z0cVl1R1EvY2pqbkhxeDJzM2I1QlczdmZPMVhiWE45ekdxK2V1Q05NSE5Q?=
 =?utf-8?B?ZEpMazZhYStybG50VGc2VjJWUlBsTndFL0NGYlJ2cTFzQ1N3eVpRRmozZEZC?=
 =?utf-8?B?TDIyMHlXMWxlSGgxQmN0MUlGVFNabW9PYkNNZzB5U09rSEl4emNmQ0Vib3Vq?=
 =?utf-8?B?SHF5RkJDQ0M4cDBhb3ZmL3hMQnRoNEk0c0VwKzJDVkhwVzFwTzJvdmRRSmo0?=
 =?utf-8?B?MEgzanFRdFZEYlRic1NTMm5DUjRNSkF0c2ZXQW0yRTFvcFJDckN3VmdMYjhx?=
 =?utf-8?B?Y01JZy93Z2VoRThncW8vcWVIRkZDWG9abmtjMVYzak9wTGJsZTBPZzlxRHVK?=
 =?utf-8?B?UU4ySDRzaDAvMDlNNkJacHJPTFpzeXg0Zmc3Y21CZUpaRlZZZVV1cmhrQVBT?=
 =?utf-8?B?Y2FPSzAwcDlYd1pXY2ovaUR4d2R4cjFZUUw3ZFBjY0dpeEkrc1JRMFVzM25O?=
 =?utf-8?B?YzY0eXNyZHRlWXB3Zm41M1RTRmVOOXFNRFJ0dHJPTDN6UTB0Wlg0bnBtUE1P?=
 =?utf-8?B?Y2o2R1djUmw0T1lvS1FIZE9pRzl2RTczWU5yRkRHZjBNRE5vMG9odUc2dUw0?=
 =?utf-8?B?Rml3MjNzSXltL2lYWkNVdE05bE9OeFE2UWFHNXIybExBTFZBMlplbUJobDZn?=
 =?utf-8?B?OVRza0FUd2orQmIxT2tRN0NacFc3MWozY2sveTFCVWMwSjBBNmZuTjVPR211?=
 =?utf-8?B?WW5LZlVsNy96eWwwSThKYnRiZ2dXV3JYM0syblo3cTdoclVqUFlxYmMxN052?=
 =?utf-8?B?SHBuOXV2Ui82MmROMFpUYVdnQkI0dVdmV2ZsU1QyMTZNTW9aODQxSEtYSkZn?=
 =?utf-8?B?Z0N2Z0lWRDhLZVhTZ25FUlNFMnBBVUxDdmNGd2hIOE9kNFRjYkZpQlZ1WEh5?=
 =?utf-8?B?eHJHNzBOMkZQMnhBNER2U09ZRG5rWE1kaVo4OEpIWUJrR1JacVZoUld5V1p2?=
 =?utf-8?B?R0o5RmJVWmpvb2FJVHVrRGZ6TlJxZmxLRnhWd2pyekF5UUdVenN0Zjc4bURy?=
 =?utf-8?B?MnpYcmtGZExpSXc0R3Y2a3ZUV3gyeDF0c00vOUtoSEdZM3oxQm5SZU9uTUlm?=
 =?utf-8?B?cXVQNm1kUVEzYTJqMDhTVlJDQUNpR2loSEhNSDd3dmRDSk85ZkZRZHdrQ2xB?=
 =?utf-8?B?b2NkYTBCUy9IQkx1OE9rVE9TYUtkUkNodFdzOWw1eWM4VndCd0tHaFdicHNz?=
 =?utf-8?B?SzBsSDVoR1F4UUJhaHNQUHNHY0NZUDZXdFQxRDYwbGR6WmwvWFpoMHNpZnNo?=
 =?utf-8?B?TllXWFdqaHF5elhnMmVVNEVDenAxU0hOODhmcTNhNmU2bmMzcmdWM1NVZnNM?=
 =?utf-8?Q?JAXq1uObeCXq0=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(82310400011)(186009)(61400799006)(48200799006)(451199024)(36840700001)(46966006)(40470700004)(76482006)(70586007)(70206006)(110136005)(36756003)(55446002)(40480700001)(316002)(54906003)(42186006)(966005)(478600001)(81166007)(356005)(921005)(82740400003)(40460700003)(7416002)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(47076005)(42882007)(73392003)(1076003)(82202003)(26005)(6266002)(336012)(2616005)(83380400001)(36860700001)(83170400001)(12101799020)(6666004)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 20:36:26.8301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71633b5f-60db-4365-1e69-08dba73d4967
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7594
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 - Rob Herring: https://lore.kernel.org/lkml/20230821170941.GA1915730-robh@kernel.org/
 - Krzysztof Kozlowski: https://lore.kernel.org/lkml/ddaa0a85-111b-5289-b8eb-afae5e5ab1df@linaro.org/

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

 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      |  214 ++
 drivers/pinctrl/nuvoton/Kconfig               |   14 +
 drivers/pinctrl/nuvoton/Makefile              |    1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     | 2491 +++++++++++++++++
 4 files changed, 2720 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c

-- 
2.33.0

