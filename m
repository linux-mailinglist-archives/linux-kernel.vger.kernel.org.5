Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30587B5F45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJCDPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjJCDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:15:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2055.outbound.protection.outlook.com [40.107.117.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3BBD;
        Mon,  2 Oct 2023 20:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFDZfi1GwndQrA+Tf/I411B+lHBRXVjxvSxmHIoiQ/OrWXNOR+kfVdNQ9Iz5MnKPBf0JBhOyZepWC67ltdy0frQeXnKwNELWA9WZko+JClugQE2obsBvR+SD3asDnlVS1i8jF/HLmCDsy91b5Nw+BpdtyuPKY/W7BA/H5XxFQzwWE3GNuB1yxX6JzV1OIm2sSOLqh694HgWrj0tSwZjjtsrAXsJJSpB4V7w9PzC+AMADD9FdmyA8AOtPVcTIpTVDmCiSWfB+G9q5hiyd5fBEIJHAvjRpX+6HAFOn29KlbP+SQ8PglJeTJWixFJxiZPiHozmcdQjIsngFHyAzfkohkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ABculsaNL2r+stL5Qp6KI32MY/C3wxBxj9evnp7U6w=;
 b=VjAWvf0awgBOshBtzcIO0cMOBDDIodMjvSdNcpK5MK2zW/PUl7+8gP+/LWcMMpSOa/NY+dDQNp62emTylYwn9NHe6S9qsRdrffQ+h7dvQCs4emOqcZDs7UKPBzmTWNaih0neyPUuAUyqv1MqvfFp1NVNKyQyyaug4LrJZMRCYxaWBsJo9l1CnG+3kNiWqHEch9kHQPGfRLm9+XyagU3R9Jo8KJ1X4nOzLSsGX35CZMe/dR/lQE83K2AVp/M/xBpXgmO5+xwBY00d6HgDWbg7PbHljdxqmtQKJET4Ab8jhX5FGRwkZYu4yMR5jpjpNnKXF3QiLsElEtz89H44xzYTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ABculsaNL2r+stL5Qp6KI32MY/C3wxBxj9evnp7U6w=;
 b=eCrt5l3inxSLOZLqEaed+pmV7XEDa03fz9JHiSiFe6fal5Jq7tH6ViPl+Jo71vaDsYS/fd4FT19neWXHBxecVWkGZxOHAJjLd0PVVmeyaHFr2Cf536HUaaOGy24XWqgi3VRDuk0U+b+YuMcDKd7e2+3/EsIHsIx1cK4F5BeTkFE6uitgNpFgB2+myb4DqxmQkFW7pZz7SNTyEzMrFQHc+g3e9J6nE3fuArezL2gxXWAOL3JBQLQ9UMECBtgeHo5qio8OkuM/h9xP8HhfcEZEUw5GjOIlVyUb2+wU5o7U5aWDqTM1oUOnNJqEgC1FzVGRtKl8ASFKx/pJUdv5DaPVGw==
Received: from SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) by
 SEYPR04MB6776.apcprd04.prod.outlook.com (2603:1096:101:dd::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Tue, 3 Oct 2023 03:15:25 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:18) by SG2P153CA0010.outlook.office365.com
 (2603:1096::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.6 via Frontend
 Transport; Tue, 3 Oct 2023 03:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 03:15:24
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] hwmon: max31790: support to config PWM as TACH
Date:   Tue,  3 Oct 2023 11:15:16 +0800
Message-Id: <20231003031520.3091047-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEYPR04MB6776:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d73efa7-5b88-4a5a-37db-08dbc3befc59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 814/qhOo5a4VqCQ1+sEFeF1l1OR4Xf3f4+0bTZBZGYDr5ZzvhTnBNG+XKtkAfQslbXi7unfAMKlJvtUK+Rs+luvC8Saxsz9C/7CPh7bwYFWWObQO/atdNZqEWetxrG47mxr94wkpIXHZc+0uF7JOL3M6eud+27xwE5rFlLPk09bSDtz/TV05Vf2mb3vR675lSLTEZy4m830dDpeZ7B3CdamOBxVCls3CaIstiyv04V0ww2cfLKNm6tympf62fFFeVzlcBHqtCbkLO/UcFu0k0jzIF9bcXJHtEQblmAVkd6P9ROn+SWZxOFAMg5wT6Lwzj8z68w0e2M9QMBQd2tYvWn4yDIINwF3vtc0zBswoxU6CWzPAgLvqgwuFg3JNVYgW9uzB0yJ7sPZn5D51N5eD80AIaY/5Svf3JEdpL/7BI6ebWJh7tiZHmbPcixmNRxKHx4xyMGncUmL6CD0bfu5m0c2NhEYol3JV75IfnBGt82mKZVqgT8j/B1PPmRtOWZBuiSPvgmu7b3w7bVg2nT49k9eDKiMBLfNqqV486IAfuIx9r9WoaI59TQEWjnIAflNUyTkkVEAaNbf5++z4K+8IgJ5fXmn9UkkwoMKQ1MeXNFPG1b+gWxXiJP7DCF+19bBzqbvLXLNy6cYcwX9rXFKRVe1/GJWVTKB1I+R0ChCP1k14WBq10uzfyTvuRe+SX+eLpa+YhHCX5e3PyNyQKreqKw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(36840700001)(70206006)(6506007)(6512007)(82740400003)(2906002)(316002)(4744005)(8676002)(4326008)(5660300002)(36756003)(36736006)(8936002)(41300700001)(36860700001)(86362001)(9316004)(40480700001)(47076005)(478600001)(70586007)(956004)(6916009)(356005)(81166007)(6666004)(54906003)(6486002)(26005)(336012)(2616005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:15:24.1558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d73efa7-5b88-4a5a-37db-08dbc3befc59
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6776
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support to config PWM as TACH in MAX31790 driver.
Add binding document for MAX31790 driver.

---
Changelog:
v3 - Use 'sensor-type' in 'channel' node to config pwm as tach.
   - Changed the status in MAINTAINERS to 'Maintained'. 
v2 - Remove unnecessary parentheses.
   - Add more error handling.
   - Change the type of "pwm-as-tach" from u8 to u32 to match binding
     document.
   - Add dt-bindings for the MAXIM MAX31790.
v1 - Support to config PWM as TACH

Delphine CC Chiu (2):
  hwmon: max31790: support to config PWM as TACH
  dt-bindings: hwmon: add MAX31790

 .../bindings/hwmon/maxim,max31790.yaml        | 89 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 drivers/hwmon/max31790.c                      | 83 +++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml

-- 
2.25.1

