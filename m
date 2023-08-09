Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A287767BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjHIS6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjHIS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:58:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2075.outbound.protection.outlook.com [40.107.255.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D03E72;
        Wed,  9 Aug 2023 11:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZuj1A65pFzcO7y1h1U4HJzmZ7WOpQu3BPRqx72BTXBSBaVmQ6upFvvuQqsi8oavAor7YhVD/0cTzlebCYTWI5Lj4DL2lh6rBPgaIFGS7vyTbwNVclb2/6KdAv/7zhEHfkh3GHsWW7TGffB1VJVxaNE0b/bnqSYI9Rm8AZFKRC/0DpmjXmUTm9/XLuxdZBylZvDuDOhPPMkXjFji6jd4zHrS9viz88AmWbtDmVvDIdVrWzKhG6emhlTU1LN5/vstvp6lI9tmrsjPdo4NkqntKSFs3gvnLfBY+q/NCv4Lhs20MBs96Ts7pV+S1UoR46FLJpyWqJNuzIFuasyMS49bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQOkSP0wp9uBfeTvQWJptHy8AOkCwbs3QRPbFy2vLgY=;
 b=ML+Ywg7u60sNyJKkzRJTPEgJxqd32pCJXnr653etVqP21rCJHX3WO3fijLFUZXyZfG+7RckBgTjCYe1w+JAdbVqxGiqVTAzL3vu4jTQ7czU16aXL3tXBw/c7tTNVHfY6S+yuYiaWqovzwIodgN4yxbKsSzZMMhUqDVAVIFOKKgnNKuC6jbemtsAbDDgKfy5sz+x5SQ/QUpi3+AoleoVrFQMXxfmwO3nrXk/o0wMUrgb0wDXpnNUxqSTF/cYBIXown9JQSERGC+KK0Twa+cd8NilUHUiFHZQ6nqYKZObW8Zvq42gbXfJiC/l4h9MYghm8SjDHL8EIVmP05Iq7sg/NCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQOkSP0wp9uBfeTvQWJptHy8AOkCwbs3QRPbFy2vLgY=;
 b=lxhskTPTln/gi6PeufudIxKdtgcYYRoaXEsaYCAU8OSiLI8egRcxO7yTqPDIX12hONFbV5gBlRanXMVRgNh31ESXPxOC7qnCVOadi3hWWH6LlCPbjO59nZz1GfT8m+sTt/qDy4TIuEgQS3zyWnEGjD0Rs2StFCwk9Ii5am+FPR8=
Received: from SG2PR02CA0092.apcprd02.prod.outlook.com (2603:1096:4:90::32) by
 SI2PR03MB6139.apcprd03.prod.outlook.com (2603:1096:4:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.29; Wed, 9 Aug 2023 18:58:07 +0000
Received: from SG2APC01FT0033.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:90:cafe::99) by SG2PR02CA0092.outlook.office365.com
 (2603:1096:4:90::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 18:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2APC01FT0033.mail.protection.outlook.com (10.13.36.189) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6678.17 via Frontend Transport; Wed, 9 Aug 2023 18:58:06 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 10 Aug
 2023 02:58:06 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 10 Aug
 2023 02:58:05 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 10 Aug 2023 02:58:05 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 7A1366473F; Wed,  9 Aug 2023 21:58:04 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH RESEND v5 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
Date:   Wed, 9 Aug 2023 21:57:20 +0300
Message-ID: <20230809185722.248787-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0033:EE_|SI2PR03MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 181d30da-4975-4b18-55bb-08db990a9133
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8UKgOeEEo87M6Bgc1RfbQ4DfjtfruTJzbBQ80zM0VfJYMjHTaDPKgH+sgJN3908/sJZMdtELvFHgYm6Ov2vhxBJoN/Snl3OdrMivUS1nfFSzIu3aW+6C3LHyN0rh+RTznebfdAiOa7gssddNYVrMnMNl81TQzT86icR2LrWZzBcK8db5BCP9+83BYlAxp8cQzlRunMcj8bLnzA7HTWZ4bBxtXYRemthPO7BP0NjY9MAZ2aae/GnjryBOTIAlsxY/dzy0AtMAxXRH4KmY58x6fbDT9UZOAg3x0nQmwQckMvRKZM/uUGyZ01rgojlQVzpmpQsSaIEc/U5fvAqj9cMzCi+oL9z5lmEVjXgV03f/jqDTI5b2+6/FyIFVs8Yy3iVtDwOzPhNzQgV72MaKCLe0jGUkCBMrsMbD6k0zzMAlw3btKaMdH6ijxalxzOJRdlh9gGXw6Ix0QIAeTOHIXuj2w9IdWqW2d7qAkNvWC5JwdJDKkQ/fcKPlSkwVB8R8wjrEx67gSac9diyWamAiIcoLedJIA1j7YaL9YqZKENq4fIl2O3FmuOECILxNsPkztXdnH4jE0yb61HK5WLRX7oNH3pMNKFiOcLCt6PIQKaTqE2cNiipHe/DMro8Z44hrMHvReYHlAGldCPBG21T5sylC292k5XY5gbjZtoEkTtEs3C32tEZTGKJ++EtmXU/i1W4+fsRy/3cwh5cSCeTokd3eTDcqIFD4z74rEtuEg00U3Ab66jhx7WdKgj/8l/ql7+pn+4m75z060t9/KCN+PbBkJx8nphq7dKZPCI/uLCWmPQLLKUHCfh2Ujor8pBDWGQZBBy39zCfKYgBemttxck2Doi+1bEumYzQzMzoVR7tXgOMn6G2AOtcafFgrPyot1s+Ya5K5ofNGb83Y767p/6373ihswWqR1PH/BQh9+nnx2Yo5kUHZSWmXNV9e4beFdhk
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(186006)(48200799003)(82310400008)(61400799003)(40470700004)(36840700001)(46966006)(6666004)(76482006)(36860700001)(83170400001)(8936002)(8676002)(41300700001)(110136005)(966005)(47076005)(54906003)(82740400003)(478600001)(356005)(81166007)(921005)(40460700003)(316002)(4326008)(70206006)(42186006)(70586007)(40480700001)(2616005)(26005)(73392003)(55446002)(6266002)(7416002)(83380400001)(36756003)(5660300002)(2906002)(1076003)(42882007)(336012)(82202003)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 18:58:06.6590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181d30da-4975-4b18-55bb-08db990a9133
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0033.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6139
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

This patchset resend due the a mail server failure.

Addressed comments from:
 - Rob Herring: https://www.spinics.net/lists/kernel/msg4881522.html
 - Kernel test robot

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

 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      |  215 ++
 drivers/pinctrl/nuvoton/Kconfig               |   14 +
 drivers/pinctrl/nuvoton/Makefile              |    1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c     | 2491 +++++++++++++++++
 4 files changed, 2721 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c

-- 
2.33.0

