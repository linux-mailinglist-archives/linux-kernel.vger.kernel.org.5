Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C07A724F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjITFr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:47:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A9393;
        Tue, 19 Sep 2023 22:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA20jYAz8m2UvnSCAOhn4YQbOv4gLagMEfwrgVgtnZHeUql+OOxBACE4ocTXw0T2hxRFdXnGRil1O2quEfaRRJ+OVQgNgo3spxKCu1ZXtAJnXjOJYHvWFWtKExE7o1aCglkV74+fJERRPSae8OjwCIcClx4aAGiI5gAetNOH5i1StClIPXZjGDIUf2RzreVCnrpltWBgx1bVWpPCUGbNziEIYs5kJNTPZtnwBeNSQOGRBsubbrApLx2SbPqbMJsEiYem2r+NGF8U5Zj5JRegNj2qWzQr+ex/6YE9qmMXUPwvMM8+GuapQp6awx2qgNgLP0x7xfHE/ScWQZyhoa8drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgLkFCWT7nkGgUDGF/zHs3uKX3rb29raA1zYy7JdVhM=;
 b=lMHAPHvkAxqckaEdYhcKsfMY1T0b1ydmCe6GgK8K9qp9A5vYEutpLCqktJE/igGz4tpRIDE21lYX6UTPhYH6LW6AdS6aCBwZxogFwv7/qCgGw+qKyMBITyUp4Z8h79CkMjehQRBXyKjEBW1/e10XgxEaLhWRDDqNcQEnRHOzkvAIGyJGR6ChuyFbXW2+/awuMStK+OSzf2oW7dMrrxrB1GwKJuxEhMJisn8IRMuCUfagkvyk0Nf5X2kx5cwCrxdQ+3lNccSFVBFA66XuZOK2PPP8gWWEUz1FQnIwejm/ycK5m8x0dF57Alf0s7W1pH9lIJFb7kjdEvK3agUVRlacsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgLkFCWT7nkGgUDGF/zHs3uKX3rb29raA1zYy7JdVhM=;
 b=wxTpkM3XfueqeaiwQUBiNvG2869mvjXl8s2yJ4e/jjwB0zB09pS7bvqcq8+XfNrCMgM1QcbYdvoq8jfUGfqOkSxrDTRaVyDfBAnV70KSanabNHrNr97i+BsR3wJYIrEopFKsFHSADVxQK593l6j6dxBnj+xr4bOxpJQSf0ZXt0mEtRf/emhHWGMue5Ak/jja/TvC1xEFpgKjDIHjgbFkHfqg2vAuj1JEGzy2QbfRfnBywEx8fy4seQFVmNhZqp1g59wEvPWxQQvfexf/ctZuuTmMQsoMG3otGKf6UbELjwkiwT57OO5Z2MvfI8SImnQPmHH4zwoyukZOoOanLw1iKQ==
Received: from SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35) by
 SEYPR04MB7361.apcprd04.prod.outlook.com (2603:1096:101:1ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Wed, 20 Sep 2023 05:47:42 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::6f) by SG2PR04CA0173.outlook.office365.com
 (2603:1096:4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 05:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server id 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023
 05:47:41 +0000
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
Subject: [PATCH v1 0/2] hwmon: ina233: add ina233 support
Date:   Wed, 20 Sep 2023 13:47:35 +0800
Message-Id: <20230920054739.1561080-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SEYPR04MB7361:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c61c4956-bfca-4a32-314b-08dbb99d1b23
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB9/b8zshmP4Jvjq+BQJS2z3rDGYvMGlr/HZNKhqMXtTXceC43SQ/Heoa0dNztuQ//ZJEoau3MkJ56l0boX7Bjwnc7HBSFLvU4K6SOE0knz9na4p5sR3zsWH+f4bzseMk53Y+AKuUkAVxIeaTcDsvOuoZWACUBK/vNS8KD0F4JSfgRTieCfSyrDn1HP4D3yMyAic5w9/BBxHpxzQw9mOsUo42lzItmIfjZh3ranTg85uK8FHRnyxiCxudZ3TEioY0eJb02y0FiAVQHQF9RcP5Kddt43mMnU0LQW1zZ2xYMRO3P9ES+a9yQLuDxXiMZzJQjt2Mnv126H7aR1VoPTcitmovbiLEBRJgnwRT4KPuqeaIJ55PV1vE8b/7D3dPYNKGlSGXj2cWP+jdgUs5ul+g1wJAYnqY0qEgvu4OmYjd4iFxAatewEd7SD1NJVZ11mKwDgGIGsFbp/zZPS6MBnPX8zTCyJep5RaSwMno7bV9vhvBxxJqKQ7ANIKB48DUTDH6GpTNNTs/JIWdSI+Ngu/J6TYzavWBzchYpJnHTEoMywqJqIRkacNeuIRiIi3+cbLX3tYOjDUvdzRet+Fvhss5Ia9tLykA6DFcdtw19WTzJeOKdtOMEA7IYxJPrFPl+ZGb4YNt6RJNnFWmj1ShqdPBOYRAeq+vtK1otKKFxptYYID4ldtdzbVMNUC0MZRk1a5h9DCgFg5+VPejhVUU/BH5+cYcseSAT95bSdTcva6P/ZU25mwSpBcd2zVpArdht0s
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(4744005)(2906002)(5660300002)(4326008)(26005)(1076003)(41300700001)(36736006)(8936002)(316002)(54906003)(6916009)(70586007)(8676002)(70206006)(6486002)(6666004)(6506007)(36756003)(956004)(2616005)(336012)(478600001)(6512007)(40480700001)(36860700001)(47076005)(356005)(82740400003)(81166007)(9316004)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:47:41.3258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61c4956-bfca-4a32-314b-08dbb99d1b23
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support ina233 driver with binding documents for Meta Yosemite V4 using

Delphine CC Chiu (2):
  dt-bindings: hwmon: add INA233 binding documents
  hwmon: Add support for ina233

 .../devicetree/bindings/hwmon/ina233.txt      | 27 ++++++
 MAINTAINERS                                   |  6 ++
 drivers/hwmon/pmbus/Kconfig                   |  9 ++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/ina233.c                  | 89 +++++++++++++++++++
 5 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina233.txt
 create mode 100644 drivers/hwmon/pmbus/ina233.c

-- 
2.25.1

