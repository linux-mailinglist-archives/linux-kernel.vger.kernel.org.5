Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C02773D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjHHQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjHHQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:18:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53A10CC;
        Tue,  8 Aug 2023 08:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9jXzhawctvu9h5k2bCcJM72JuFatQqymeHctinTA++tC6ZvUkL8H3k6vXrWg7C74QuUWslFMnJBJ1fqZWGRr/73HXmycs+aXg0QzQcKlT9XurujI+AEW1SX6GtMVzwRsQEyig/vQJksVsmUN2m8xeOjK8hMCv3oznxZ/z4GBP3b23pc74J40V0WKIDUSJTKe4ugdYpUitA3TV9ulr0N9aa3i9OOgNWMBZVA9pzxZT2qIFwjHxXmX8RRCHG8Otl9gqi0QUK9h3jWb49vs001kVNRz84y0wMyr1enyL6GddPRWsmhb7fIqKo3Lhge/yXlYesFk4rKk2e5r9oBTHDrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LwnuwlCmyloyZ03i82PUqrnlt8+YgjpyoUKttCGMRA=;
 b=X6nR/jihRUKh78bpxcLwqhIOFxmGrgcYSlOa8LJojBoloj8WZdtd3upDvm/pwRJLATUiY8pylvIfSw1rx3y+ouycxnzgShIOGGGquDYiQhgvpLUVRRYJjTu0Mu4LCJyqxgguPAICEdWf0Xu6Z4HQF2kcLXNDgo1gHC9VdZ2A8RCnuBQYC4uVzLhmVCrcSSPWaqQbokun1f56QNpCZr+etF6m2CcSYVcVTJevl9RMHykPhy6WnuA+fQ6n1sgh53slkc95/IFokkdMqjxac55B3zMbPLR2ycp5op49hcyqo/jJj1/4MBpN9nNWDJi61vpcQRWEvaeOnhI5rW+VVzPGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LwnuwlCmyloyZ03i82PUqrnlt8+YgjpyoUKttCGMRA=;
 b=ysPLGmbT6YXJ8YdPkiWpQ1VMv9KO5gsWkNjunOMN8D2pxpqrwLcyq5R8s+lJL6lxMs4Srx1wAvuCYYnbU/8xWo9JnHneh8qtOA3B/nLnOe6AF6qcuQQJCtULBD5P2Zma/vljuWn9RTkXWqjPSJc2EoxpIcCDdIzf2V1Ubh0fmhV5dyfItQC0fExhqwUKNykY2dcPE+VneVuKQlos+M6zRyNCCkbM1+UlU+Rn8hwAZaBD3CTmOTvkMoW5K0eIkjuo3MRgwT1dF/YyGYRFz0/tWyyRC/H/M39unzihqzLPMR3cPsWAo7f1Ow6iJnF+4TxhUm4Z4qwfJpB6ziWllnfnPg==
Received: from SI2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::19) by
 KL1PR04MB7124.apcprd04.prod.outlook.com (2603:1096:820:f5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 07:30:03 +0000
Received: from HK2PEPF00006FB1.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::a1) by SI2P153CA0008.outlook.office365.com
 (2603:1096:4:140::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.2 via Frontend
 Transport; Tue, 8 Aug 2023 07:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB1.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server id 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 07:30:02
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] ARM: dts: Facebook Yosemite 4 platform
Date:   Tue,  8 Aug 2023 15:29:55 +0800
Message-Id: <20230808073000.989942-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB1:EE_|KL1PR04MB7124:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c99c9a9c-2dfa-43f4-06bc-08db97e147aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QISHe5m0mGeeUfBkqqBiNRt7NEwgcn83K/pmByWbT5J5oupEjgHztPzGPtD2+O2yHs3V8ObEeead55znjAKA5267DfyDf4Cs/WHgDp9H+AQRMATpE+c1f53UesttZYnVzuoL/uBXnTtEh/CwRzfTtbmUbIZSvSG85Lr9KIAUs3oQpOMu67bGAvpETxnNe6+JW43OVvN4Q3U9iUMv7kJo9h0V4t2ii4uVlmUO43/C/JiACjq8uhOB+kjc0hl4YJlJznc8KP82ZWpFeB4XGNfyT6DCjxUoA8JvkyH63vI2lvrKo8G0+FCf0ddUMBGRk4V1dGMs2yOK5bIaxoIavltp9LCOtJDt+GSc/TCR4n8RAC0F8z/Ji7Alf8mKu0ZCj4Ng799Ak05e61NAXNzfFwSQDahr/bN/IByysT+lN57lUikpcpNayG3GK8zyOqZvYS2+HgykXmKW6VsYkKI5tltG9xhISVFvGOOLqoyCJBW0XTkwa17LuIqYT0Mmro3zc7OX5gmkp3GtSE50YuRL7fakFTWKuVM5XGJ/IUUMXOXIDeZHX+drt2DwbwZGzA3q8X6o/UtmXX/1akaxxJ+SBXbPkKnQmxxQqisfgZ2bpA3jZw0zi268bYHbV++rQRD5soq/39ApOSHHGn9XeIuW3yuXn8lNdIk6zYzGwRKnWcvGoHWV+fEca2WzX2EpyIBCXXSDtbOHffaC7GgiMtB8TyyvCIJ+lEIT+EaAIzlxS1ehoSNNeYlJm5JSC6f2kjySd4eMvolEEiw1v9mj7Zbc0Axy9Q==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(396003)(39860400002)(136003)(376002)(346002)(47680400002)(90021799007)(451199021)(82310400008)(1800799003)(90011799007)(186006)(46966006)(36840700001)(7416002)(8936002)(8676002)(6916009)(4326008)(36736006)(5660300002)(41300700001)(316002)(47076005)(40480700001)(86362001)(4744005)(2906002)(36860700001)(6512007)(6666004)(6486002)(956004)(2616005)(1076003)(6506007)(26005)(336012)(9316004)(70586007)(70206006)(36756003)(478600001)(81166007)(356005)(82740400003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 07:30:02.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99c9a9c-2dfa-43f4-06bc-08db97e147aa
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to
Yosemite 4 specific devices connected to BMC SoC.

Changelog:
v6 - Change project name from yosemitev4 to yosemite4
v5 - Revise rtc setting
   - Remove duplicated multi-master setting
v4 - Resend with cover letter
v3 - Revise the bootargs to stdout-path
   - Revise i2c devices
v2 - Revise the DTS node name
v1 - Add binding document

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite 4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 633 ++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

-- 
2.25.1

