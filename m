Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44AD7B0119
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjI0Jzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjI0Jz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:55:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2212.outbound.protection.outlook.com [52.100.223.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9010E;
        Wed, 27 Sep 2023 02:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjShKLKkRMcPKTNbcHEJVxOSPtGcuwCkss8enhBf5SofpE9DvQY9gy8rgjxA9CLGQnnTYMz2RzidN+WFX0MKNP8z45Tr8WodW7iFpR47JHX5NCSRE87cHd+VAJvKEAr64/NfrpeMmzn09YvQDn2lukJTEwTlCTPhhyPaTZXEkV6F2wkuXiGOMoKDOD1ZpVvrhxZT8CjoFTG4fd9OVlJM5MGsC7sJ3rMS+ZsYm4P1GPMtn0IPYvN96EVpz9nWjMNLsaTD0FJo4KgZxI13exwj/5YOOmsplkvbYe/EUkpSynn+0nUfecl/wsToWUUTO/9FPm5cNQn0kjYtc/fwRop5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1Kp9hXECWrSVj3RrKfs1suUHvBoFn9FhI6/bx2zAxE=;
 b=dZCUpIOcS04n2L4WfvOzvpwaFsArjSqiDh6rhgaR/6zK/Za2miEJOPD3Rh8X3yXfP9IVHCvMXuAImsrwmfOKXxai+/RBlUE3aNpI565VcWIG8mvrvQ+I9ZyayuVxUFzYKIOd5rBWXKPsZyhJ4aY+ZFN1D0s+sZo2wiERFKBMvxYmQlISu5SdyohsNDtqYDDSrDVQoFL6jBP9x9RbrCJp1V4mOavD8YH4uScRw+ims1rvXIiE0sQnzihPdKWTMBnBt4xgrNJ8CzUot08WMx8r9FqIz2/nXIlt0ZzBaHifvRS2VLjSnhImgQeKXAHGYXjXN/Lq+OW5UbPLGYp27SgHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1Kp9hXECWrSVj3RrKfs1suUHvBoFn9FhI6/bx2zAxE=;
 b=DsmtdEYk/5Z6IzMm0jPUZOMS/XyQEh1xSD5ytouFh/ZsnPN85IFJRhR0NrQZLrWujRpntxzl+J1pUTv9G39eGhJiY9nZjWz8r1TeGKvEr/lJ28IUt6mBj4TZ1eNCCKgvN3j3zsoy3uVTywsr5l7muGD9g7Wiw4yqXQj8Uc56BII=
Received: from SI2PR02CA0012.apcprd02.prod.outlook.com (2603:1096:4:194::7) by
 JH0PR03MB8351.apcprd03.prod.outlook.com (2603:1096:990:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Wed, 27 Sep 2023 09:55:24 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::a4) by SI2PR02CA0012.outlook.office365.com
 (2603:1096:4:194::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:55:24 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 27
 Sep 2023 17:55:12 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 17:55:11 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 2803664740; Wed, 27 Sep 2023 12:55:11 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <xu.yang_2@nxp.com>, <peng.fan@nxp.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Wed, 27 Sep 2023 12:55:06 +0300
Message-ID: <20230927095509.267029-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|JH0PR03MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6142c8f5-be9a-4db4-6157-08dbbf3fdf03
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3RzcFYxSjhsT3JYMFY1R0FoN0RjQ3M1UEJVRWNxdGdPb05neHYrR2xJYXlZ?=
 =?utf-8?B?TEhjVmJIUGdxQ2RLYjNQR1lONnFPUW56bVRRYjBwNGhOUTNqM3FDalB0aXdi?=
 =?utf-8?B?azFwblNYM0grUTEwRGdLVWtMZTA0bmRYSCtaSCtxWmhSQUJNUElmb0NaV0xz?=
 =?utf-8?B?VWlIdk03V0JqWkNJUmgxZmNNSXVMTjcwNnB0RE51R1VaT3F3VFZPWUdaSkNN?=
 =?utf-8?B?WUY5U0JwL3BXTmFUa0RhVEdObzVVNTl6YncxZXdML21xbjVwanZ1cUU4Rjdz?=
 =?utf-8?B?QitiWVUrSWpad2xaR2VZSVpEQ2FpWTJoRWpONXhmeXAwL0xkVk5CYzlXenQr?=
 =?utf-8?B?aUZXUkU2K3VqdDdKT0tDa3h2eDJielo4MjVjZGU5WFFrQ0RrVmlZVkhIaXdk?=
 =?utf-8?B?blBpeURaV1hOZzFLK2g0RDRzSW9kQlZtZmlKQnFESmVrbkxNeVRXK1M4Y3cv?=
 =?utf-8?B?dmZvNTVKb1YxTEU3M3VoVFFqYmttcGYrS0lxaHg5T0toN082Z0htN0VTdmNk?=
 =?utf-8?B?Sm00WVpJMzNjZ1NHR1JuOFBTeWdHcGdoYzEzamlHdHBZSEp1T1JMcEk5Qm1O?=
 =?utf-8?B?TjMvVGd4dWVHekoyU0JwWEhpMWJUeUp1OFBiQS9GZVFhTDJNZmYzTGw2azZy?=
 =?utf-8?B?V2Q1bzYwdmd1bGxhYWVLTG14ZkYrN2Z2UmlDS1RxL2Y3WXRRY1ZXQ3lFZXhP?=
 =?utf-8?B?U1gyWlR2NW9kVjAwLzdPb09Hd2FUaGo0bGJBdTFEMERYR3NmOVhDZjl2cTlm?=
 =?utf-8?B?MGZNazc4N1BCNjM0RFA1Z3NpTW5mazFmbzdyWi9ZSGpXWWp3NkNIeTFheWZw?=
 =?utf-8?B?LytDNzFxTFdOK3FFcGVIS0toL2F2TnFVM0tFbFpiSUo3eEM5MFpqOG44QUNO?=
 =?utf-8?B?U3ZGV1h3QmxwaXdLZC8ranUxUWhHZWQ3TFNOcDRZb1d1dG8yZEJyR3N6WHhM?=
 =?utf-8?B?dzhOSFpYODVTc2tSbGtOQW4vWWJ4MGlFNTdLdmJJemdTTVo2MC9ITS9FT3ZT?=
 =?utf-8?B?RlZ1YzNtR2h4di9yM2ZmNHJPZXB1TGcwaHN1NXNnT3djN1hNa0NRQkZaWDU0?=
 =?utf-8?B?RksrM3hZYXMzT1FWek9HTW15c1pZVE93WkRSS2hnaVMvVS8rVEVPeEVqT2xX?=
 =?utf-8?B?VHJVRjViNUhZbmVzdTNrZ2hEc3h1NXprOVNqTU54MEd6SW53WHlyUllyMlBm?=
 =?utf-8?B?NkNsVFE4b2c3Tjlwd2tTNnNKbkwyRDBsWmZEU0p5WGcyK0dhVFhwQU53T1g5?=
 =?utf-8?B?K3BYNk94WlRBem9pQkk1V25hNVgwVXdwRGYrcXpTM3RQdzFOZmRtT2xObEdJ?=
 =?utf-8?Q?BYxthLs7eJa+IBmZYBW5hss0qctnDRC7ni?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(48200799006)(451199024)(82310400011)(5400799018)(61400799006)(186009)(36840700001)(46966006)(40470700004)(54906003)(966005)(478600001)(110136005)(70586007)(76482006)(70206006)(47076005)(40460700003)(6666004)(316002)(42186006)(36756003)(6266002)(336012)(40480700001)(1076003)(42882007)(73392003)(66574015)(41300700001)(2616005)(82202003)(34020700004)(26005)(5660300002)(83380400001)(55446002)(83170400001)(81166007)(36860700001)(8676002)(4326008)(2906002)(82740400003)(8936002)(7416002)(921005)(356005)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:55:24.7192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6142c8f5-be9a-4db4-6157-08dbbf3fdf03
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8351
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

This patch set add USB device controller for the NPCM Baseboard
Management Controllers (BMC).

NPCM UDC driver is a part of the USB ChipIdea driver.

Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
parameter to active in case the ChipIdea USB IP role is device-only and
there is no otgsc register.

BMC NPCM7XX and BMC NPCM8XX has ten identical NPCM UDC modules,

The NPCM UDC were tested on NPCM845 evaluation board.

Addressed comments from:
 - Rob Herring : https://www.spinics.net/lists/linux-usb/msg246811.html
 - Krzysztof Kozlowski : https://www.spinics.net/lists/linux-usb/msg246773.html
 - kernel test robot : https://www.spinics.net/lists/devicetree/msg634160.html
 - Jonathan Neuschäfer : https://www.spinics.net/lists/linux-usb/msg246790.html

Changes since version 1:
 - Add SoC specific compatible.
 - Remove USB phy mux property from dt-binding, will be handled differently.
 - Add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS commit to this patch set.

Tomer Maimon (3):
  usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
  dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
  usb: chipidea: Add support for NPCM

 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml |   4 +
 drivers/usb/chipidea/Kconfig                  |   4 +
 drivers/usb/chipidea/Makefile                 |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c           | 117 ++++++++++++++++++
 drivers/usb/chipidea/otg.c                    |   5 +-
 include/linux/usb/chipidea.h                  |   1 +
 6 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c

-- 
2.33.0

