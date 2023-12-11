Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D880BFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjLKCtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjLKCtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:49:50 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4FE3;
        Sun, 10 Dec 2023 18:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSLAjhDjDubJetYIyUs2dxqtpV9ulEZj6MHO0TOeB9GAwajM7UnZhSrEibjCVZfhWQ2RzII78fYGr0l5NpXtKovlKWepgk5gIuQcq9KLEM2MAZyzcnOFHfB2+qRs1yYArxJtabsZxz+IGDIs0ebtmM9Ve15Z9DfscgqPiD1K9maoSemN6NiqtxRMQw4Y44+eG1FlXQsuLEh5qL92LYyfySU4erAoq2HPYwVeGoBkXAoY9FLBnQQy+rRTFG0TjrjWMValD97RiNs1gksqA2l/YM6O+614kIeFXVUzS9PUfxXEAyOsiNQKTQs8+TXRkeMbTS/O7unKLUiUeCFtYKdpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olsD8EReX59CZKcyk4Xdhru6OQAkB1Ap6v494xj6NWs=;
 b=Db8T835wgVwP1VJ7QwukumMp/tnf/GPN+vTXuRp5uKV+aL5yG0ypmvLuwBoL/dwJ03+vJL3aVGCPYE4aInyqz0CSZI4KC8NCqViTP6qShF8TQzvTkUcDC9p7DESJTN0Hi9JgnbbYMsoAnBGqwgFHkBjLYYTGCCZ4LuvTw2D8LFW/wiTvJLtCb0VVKIm0Fky8GeBLL8or+FDkS42vEtK/yafb+NZZolAQ2rIY4sM+su9nTomTBD3nypeKbMbXs+xzaI0Z3hkVTd9sgf/BXmz3S1fpOz2QnYgIAtIdH/BaBWjTBTwWaobRvApe0D/1LStuF8cTaHEM4WDubvY0tMPPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olsD8EReX59CZKcyk4Xdhru6OQAkB1Ap6v494xj6NWs=;
 b=2Y+MsuzMv1KONDo6sboD6sp8c1mSrFQwGsdNuW35J8n/eN9E4qJnQEuW2rAv1qud6wotTODugT2aY0CnBlj31srhN+vUYRxfn9oW7JwMFeTDCdRjlx51XK1pp0ZRHnnvX0sZEgEoayE/8zbw0+vJqyOlJ8Se/dbIG9AOUjGeXMGQqgg9QV+He1r239jI5cBJuLIBUaffSHFWMKPsDSQVq9nsBu9LsPU/WhW26BatkzTP2JCWnz9FkkvKgJg+UhYc8z3nA3t0pTvbzqfs/t04a+ooASopxCO/TRJ+3G9BO7QYwNeDGgg0Gor+6b8VhzDLHtgkkHF3SOzSUYdAySo6Tg==
Received: from SG2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:3:18::16) by
 TYZPR04MB4287.apcprd04.prod.outlook.com (2603:1096:400:24::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 02:49:50 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::da) by SG2PR02CA0028.outlook.office365.com
 (2603:1096:3:18::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023
 02:49:49 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date:   Mon, 11 Dec 2023 10:49:31 +0800
Message-Id: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TYZPR04MB4287:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d1ac8604-49bf-40d6-025a-08dbf9f3d833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qi8ozIvXyGqMOIN1ZSZoSXmfe7c/c1vGfqz+wKdh6RAbW7OvcWFaxS6/g24g/Le8kXxRJQTlldk4gtIaYAXiv3zz2h5DdifwNiMg1zsH+IG/yruGFrNpltYNgsRChcT9NoK5n/pN0X3r6Tv9ltBUuzUt5NYpRfVByPozWkqqCH3hraFmS2ywW6vANxV05VWrrPTHrEOIPzOJFCDiTd7kRNl4/NOw7NhMsVKm5DKNcfkEXXzDIrVljjicpHb3dXcad3CsQyzwF6UEWI2JNBgOtAuLFDB3xFtzKebrihBOmPZ2PpMYwmUalBw6W3qWfMSv20QeYSI2g2v6HzUo+a67sYiLl0ucHwfG62uFkMz6di/k2pfILV3THUUcd6EENdWk3oUdXr3VUqGEnCotEZa18hv70qpKmPiTiyJVjAtS85MExRpyjNQpkiSsiu72OPKAPnfJFDxQ6oSV0xQvc+3ArVe7FPdQ1a2eTUAAgAmrcUiL7hzjPRTODnSn/go5jrWwVsSGnekEhaX6mNVPbM+Ln3W9DeW0TAIGzZu9Jvym45NlK/uJelJKa1z53kB7ffedYyngY8jdPQbKstI6VsEc9571xeQJbkRHOLRz2FlrdZUhgkoO/wg+5OU9bi7It+aHHkmpxX4sxIbDqjBQSNHKX88IH8PANRvbiCmfC8Gu9mhzQ3l41+E/gIV0/EUyDSSeNIW44uDTlqHDcoUC9f0twQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(1076003)(26005)(956004)(2616005)(336012)(6506007)(6666004)(6512007)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(316002)(6916009)(54906003)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:49:49.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ac8604-49bf-40d6-025a-08dbf9f3d833
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
  - v2
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name
  - v1
    - Add gpio and eeprom behind i2c-mux
    - Remove redundant idle-state setting for i2c-mux
    - Enable adc 15, wdt2,spi gpio for yosemite4 use
    - Revise quad mode to dual mode to avoid WP pin influnece the SPI
    - Revise power sensor adm1281 for yosemite4 schematic change
    - Add gpio pca9506 I/O expander for yosemite4 use
    - remove space for adm1272 compatible
    - enable interrupt setting for pca9555
    - add eeprom for yosemite4 medusa board/BSM use
    - remove temperature sensor for yosemite4 schematic change
    - add power sensor for power module reading
    - Revise adc128d818 adc mode for yosemite4 schematic change
    - Revise ina233 for yosemite4 schematic change
    - Remove idle state setting for yosemite4 NIC connection
    - Initialize bmc gpio state

Delphine CC Chiu (14):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: Enable adc15
  ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
  ARM: dts: aspeed: yosemite4: Enable watchdog2
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
    change
  ARM: dts: aspeed: yosemite4: Add gpio pca9506
  ARM: dts: aspeed: yosemite4: Revise i2c11 and i2c12 schematic change
  ARM: dts: aspeed: yosemite4: Revise i2c14 and i2c15 schematic change
  ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
  ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
  ARM: dts: aspeed: yosemite4: add mctp config for NIC
  ARM: dts: aspeed: yosemite4: support mux to cpld
  ARM: dts: aspeed: yosemite4: Revise gpio name

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1215 +++++++++++++++--
 1 file changed, 1091 insertions(+), 124 deletions(-)

-- 
2.25.1

