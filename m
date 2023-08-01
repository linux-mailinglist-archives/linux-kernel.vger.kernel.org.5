Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2276B300
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjHALUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjHALUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:20:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED775210A;
        Tue,  1 Aug 2023 04:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6XLWR2aqZGHH3Vy1F/EfET899PmzJUF68Ss9DRhlrPMY4WGNsvcb7KLJPVz6UkC8LNZHnjyj+Y6nJ/6emfhznNPpm+ZzxmOsBJUYb/EdB6ohI7ibXR55oATugHJ6FFTGK3qKaBYcCGyVKOpl7jQRlCocvUbOK1oPFvVqpgXh2uitD7xEWV1/DbVZ5/x4vMZAKKQTLm6V7HV/UurfNIhVFiGYz8u3sQNcRbDZKpR77JD7faU1nbM4cVTzKu/2WCsc0Ua8hHAo24/x3gMf8qCMIC07UvFWtHK0L8DVMBQnVv7QbtSy+5jqg/9vix4/FNeCsSKkDV+F++MUIrkBt04vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r//CyGq5iNQRx1MQ8hr0M+rwrfw/iU56dQ8qP42D37g=;
 b=c5DBJAa02Me1aZPh8ykhShltZ4PFVkvOlBY5MbK5SJjHv6oVg4Oqn2MprO6AxCqL4Pw3AHUQU5DIjLexxdx7nKx+RxdBaT12tNJENVcJ/QGZrQfjwSVecRLLD8oX7/Urc1z10C/HkJ0ixMg9ZcyayHx7ezNPnep337mKZYoX+rHaAjduFQjT8u+8k7xvAaoZY3o9R72/aWcZ5YMOLKjLKgMIbkTnV+LfR/wPea4IW8ave28H1wAeLAg7cNR/hiSvsXP+s/DbrIm1h0wqUT+8LyYGpCOIh4cdUZEdV5SJLbFELx68CmM263sxILPFNYkU2qdzM4hYXcxp2fp7d2rR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r//CyGq5iNQRx1MQ8hr0M+rwrfw/iU56dQ8qP42D37g=;
 b=Qat7kdA41eO1LywCCeNYuRGEtjxh7sOdTNWtW8TjSewj/mie9iKHCoPT/GooKKg/5eR9eXZzfaiPHIwFkJECptHkGvc1FdxqHM1TQaObVn2rXjqwSUIslQwKYDUz7ClrcNWDMPxK4NrqlNiItuZR2+i3ySZjC6lyPwWy/8kuCR4=
Received: from SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) by
 TYZPR03MB7846.apcprd03.prod.outlook.com (2603:1096:400:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 11:17:17 +0000
Received: from SG2APC01FT0059.eop-APC01.prod.protection.outlook.com
 (2603:1096::cafe:0:0:2c) by SG2P153CA0003.outlook.office365.com
 (2603:1096::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.4 via Frontend
 Transport; Tue, 1 Aug 2023 11:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2APC01FT0059.mail.protection.outlook.com (10.13.36.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6631.44 via Frontend Transport; Tue, 1 Aug 2023 11:17:16 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 1
 Aug 2023 19:17:15 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 1 Aug
 2023 19:17:15 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 1 Aug 2023 19:17:14 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 29A8C6473F; Tue,  1 Aug 2023 14:17:14 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <j.neuschaefer@gmx.net>,
        <zhengbin13@huawei.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
Date:   Tue, 1 Aug 2023 14:17:10 +0300
Message-ID: <20230801111712.45653-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0059:EE_|TYZPR03MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbd2aad-d35e-450f-6df4-08db9280dce5
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7vpsRDg2GMggqbo2Yzp0CbQu5KWbBNYj2vbBw6OTym7TNJGKHMqls7jeTUjFAf+6VNvlq5aI93bGO+yUda6SB87J7Fz8D+oOa8aJon6srBw60LzwMejItHEjZlQzII2RHHvIKFOTMEs37HT9UvY7+f3XeizmK9iYCP7nhNu1YFtRwcbm5/r5shOCaz24BolN44NdFb/7KiN6YKldH6UWe7hQZDgz3gzXmaSfaViSiTrufGN7hdJ/NawNJcG7WEMvdx9Kz5iY9km8tFgPfZdz7LAn7wdgYh8GiczWzPGN2I/mxtk3cBJ60keV05YmPazdqHrnJ17wPKqSZ3HmwJp4koJQhdU2PL70R26OkKblk74xRu/ogjy4+Pv75IDACp3wVOhjrKGnO9+vv+ShKIEhJy5gPPHxJW7BO7BOvu2Y93I9fw8r4DLKyB75WBaiTsBVcDuodJf4xrB3J+aMf/NrIdB3EDu+wp89hCU85ZsoV9NNVEYliZLHDBSnUf2V4aij1dd4rFPpuJokSGisspW/dCXX6MN2UY288mNCoxrgx0WA9YEQ2TfFzKLh2unoLwl+Cp4QmYgRqzw0yAdvQItQmVMn2ZXAGK2Z1Kt8nU402NBAFDxiOGiCMMnt2AVShQCSudx+TjWVU5Wwhv4pTvEfzX5p4ujmDDOKHGYQHmPy71hbN3FL9Iil5yE5hJ398kLV2kszbJMKSNXXjFC7tmVzzA6grYMGbNBtd4kKq+vXOMr91RZFknf67iehhutfwhdQGQcBmZRaeTbyHIkE5JLZrGiosQJ7otVfFe9gkGjCUXxgL3XP8O4V/V60jIXeh7Q6LJogjzr8P5ukG4NA3cMKITCbMd2gFEkkI5SGwviaERRjg++c6Mj5TGc0dlchlo6M7AhAzPctt2IJyrlOiFkF9WXx2s8LJMFJ8GD63Zx6rI=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(82310400008)(61400799003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(966005)(6666004)(36860700001)(73392003)(6266002)(336012)(186003)(42882007)(36756003)(47076005)(2616005)(83380400001)(55446002)(81166007)(82740400003)(83170400001)(356005)(1076003)(26005)(82202003)(40480700001)(70206006)(2906002)(70586007)(316002)(42186006)(4326008)(5660300002)(7416002)(41300700001)(76482006)(8676002)(8936002)(478600001)(54906003)(110136005)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 11:17:16.1299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbd2aad-d35e-450f-6df4-08db9280dce5
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0059.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7846
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

