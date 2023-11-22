Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703397F3C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjKVDX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjKVDX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:23:56 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D6B197;
        Tue, 21 Nov 2023 19:23:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtscoswv/BxhDv2X/y3oEpIdbJm4LvZw0ps3u0vWG38xpOpNoiHKJahYZm/nlffbE84xR4dof+JMSGJ5+rG0BPAHjwgnXRPVAaG/8tSzDc8ywDhd+ZEtuta9mFC5o9VHtj7/px4U3w9uQOaTsGTvjX3veQJEiBKRSjSiZ7SAkz5qVo+s0vuhjJLuqX+7kjj7o8hB3kZS05taSzAt87SWApUyvSllRF1YnLtjpjSq8EMSHngUo5BtXWACEzgJ5A//8jf95gfZEltn9+URFRlXaaHy/UpHagik+MmUTx7AVXfYoOsQ2/i7Sdr+ZfqQHX1VuqsxfWUSwxy8TqP/19Xs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV+AT0j7zdkc5daB1loqGuFLWJsc9iguLBX/Ldd0yQ8=;
 b=i3HB1g8059Q3Eh3st7J5Y7fOc/wKMpyrH0AVI+WB+52m5lg4V5TNVvDBKJdYiEeFjxlXD0nUFhVkx6bEgq2d54rFvkenNDlhfKGcKz7L3rN0npzumPI3JGFDtVoMu6REL5foI25mR2587cs9jEOjiQzDZLfEyYDKbj8VQB3U5cdDCZ6RlkXimihBlAL6nD3SUdyw5wH89qso/UBH06h/XtlOnGHdKrWAOM6+9Wn+Be3LSTy5ESZhFlzhdhmXAc07kysno1/RxRR+JuUAiz5X6/iqodWVIzXL6USbqyUh/FCRO4k+pQCrjjrXIQIATvlbItRTDfzuHY7fnS3V6aa1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV+AT0j7zdkc5daB1loqGuFLWJsc9iguLBX/Ldd0yQ8=;
 b=qcH4hEeeOgOFd69xHY+6ldkCAuZCtvLxfW0qPAEOZBcQm0vbd/WGl0u4V5zoljcMJ8bD+EbGm97J2JFrQuRRisG16oIhIlvxD1PCD/+fxOpMBeHkyMa0dGdAwvIPm7Qy1IfKEiGHSyuh4xOad4CjIP/MQh+HNYcv4yXY+i5oa5s5kbCLwJQX86eaXHn+cUS15T+JPx3NrmL3LnVzXcIYlWn/ZRvF50s0WOAclcK6+y/dfVsULNobR9oPBdrVW0AwGTtbZEkqWUeKKsWBfYElvKMgijhGzxR4OAOaJOEbfTiyyeh9wKw0+d0Js2nKKzxbDW3ljhSriFZYfMsE8HQOGQ==
Received: from KL1PR02CA0035.apcprd02.prod.outlook.com (2603:1096:820:d::22)
 by SEZPR04MB5778.apcprd04.prod.outlook.com (2603:1096:101:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:23:47 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:820:d:cafe::71) by KL1PR02CA0035.outlook.office365.com
 (2603:1096:820:d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 03:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 03:23:45
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v1 0/2] Add adm1281 support
Date:   Wed, 22 Nov 2023 11:23:40 +0800
Message-Id: <20231122032343.2794903-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEZPR04MB5778:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c568bf1f-e362-479a-9040-08dbeb0a6fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW44VxbMvpFpG0c5PuBjW9/nvDZ3uw2tcc7/1cQMCz+GXZ/dvMpHbH/YFedIYa2cSMGZdbBlnzWbk8lhwkKYirSFwTPoZrzH4df0j0VLGHgGgH1BMkNM1zTX6OPXpeF0RuoX34iqM1UTXE5hcP6zQ1eoWyj+3Sk14Dn+WqQU2AiicJ5Z8gGiQJbZjNouN0AAEHVkoHQIZME3PuWZFHbOJ7ubqAZVzMzUQGDntA074AZ+vOJ1gnL71nxJbjDZn9s1hA+XEP4sk1y+QTPMMnWm3MLitkYL3wFJTSSumHXysU+zPzq16dFZ2iE2cjqfxM2DA5OHnX3E2lIF2wsG1GPv2IrjrPfLMPgNucJTa4AHJ+AN6F8NhUaIpMsV5N0hpIpMSbk3XUAFbSI/nF7huJiFK3aIN+SzoMdWqzYSkHthbxP1l96mJX6xzWT1yGNNbIOcvqlN7D15imn/ugJpLe8QJ9gFfnXM5nR3rFIpI2dw2By9K4DVb9UK5ah/l+izhF6NhByA7dZffsqsENSC0ENG+d06i+FpThnQSgScU3+taVKCV+svZsP2KPJB5Bq61Js5n5IXkb/mQr5jY3Frn2dNdfI0fUw0pw5NW6iJuMSY0+EsXycvV+9F4/2tRhbFrgbB5F83jVmn+UE8LHDimj5lJEMhm9jyXVseSFloV3oLD61P7eVwdvL1wdA+4iNnfMyx6kxAgw/sBWTTkjZFea29mg==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(46966006)(36756003)(4744005)(5660300002)(7416002)(86362001)(41300700001)(2906002)(2616005)(9316004)(6506007)(6512007)(82740400003)(956004)(83380400001)(1076003)(336012)(26005)(6486002)(478600001)(6666004)(70586007)(47076005)(36860700001)(81166007)(356005)(316002)(6916009)(54906003)(36736006)(40480700001)(70206006)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:23:45.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c568bf1f-e362-479a-9040-08dbeb0a6fab
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5778
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 - Add adm1281 binding document and driver support

Delphine CC Chiu (2):
  hwmon: pmbus: Add adm1281 support
  dt-bindings: hwmon: pmbus: Add adm1281 support

 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml | 2 ++
 Documentation/hwmon/adm1275.rst                          | 8 ++++++++
 drivers/hwmon/pmbus/adm1275.c                            | 8 ++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.25.1

