Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B604811E04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjLMTFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLMTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:05:32 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2089.outbound.protection.outlook.com [40.95.54.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8EED5;
        Wed, 13 Dec 2023 11:05:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d43MIEqgkQ9lSsaOxLVKP/vXUuLWJkjUmCb/JWBl+b+Y0nCVOUPeCDj5VtoFe6S23Z2XcpfDD7gRHYvvXHOng/6pfjvhHH54BNDoyp6NAqqiydIb/+3gFOr+1KK6JX745P86m+clRU6CKsdMeu54aSfwi+v9QTRhpXzWdkewzyuY8XaBFwqE2xqnGrYlkfpSoTdNNeNTVBxJMnC5iYXimePoLSyzwGFNJ5Nj0soyhR5j3+3tu+ldsKc4dbS4qqPWSOl62c7U+8Ir8T7S8W4ldCWQgBjaR6htYJ8BGP8NtaSxO6J+rL8d/3IsH+EEyWblJjZ5ugcv9V3l/ErCzOeNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAB+2VWqPgQ5pF/q71H07YBh3mzkSI5r+fDj29BEmV0=;
 b=k4p44qLo194/8I326OcrAtCCfcAGSpaQfStrwmCC2TUPIAZ5Rf6QieQjoUGOKmW9f7fVCyhxXKBkJzDo7c354clalJRg+FJJjzQob0v6pcXG+Ib69EDmoz7RuiMEyzcqqLJu3dxctE39reIRFajYxE0oJ3HsK5tWERSb26Ub9Km3N1LOC+K6mVpV+G50aY/r5kozU1HWETdcjxnK2hhOlZTjA0a+ds6O2ES/ZURH+DuFJIsog5Vgx23qxM2a9iyKbsY9MPcs7vSRQhEJ5i+hT7KnowZObXKuvW1CQORkDw/Dqu1TrGWpB7aBIeskP4MP4W4TqUOM1Wftv6K+xdx7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 211.75.126.7) smtp.rcpttodomain=arndb.de smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAB+2VWqPgQ5pF/q71H07YBh3mzkSI5r+fDj29BEmV0=;
 b=lBnim1ubThge9eTuZZNWfA4beHRMOkNlPuEz1EUo1VOycxcvxASGQlfFDgW1Q3ppstY/c7BXiuAE0P6h30lF4uEbk1IE5Yw7hoScn834esUXWOE6kftYCO3aZS98mG2R2tO7x9gik1NS1BKsffugFLeJy1sulaBMKFmUIYA/4DE=
Received: from KL1PR02CA0033.apcprd02.prod.outlook.com (2603:1096:820:d::20)
 by TY0PR03MB6725.apcprd03.prod.outlook.com (2603:1096:400:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 19:05:33 +0000
Received: from HK2PEPF00006FB1.apcprd02.prod.outlook.com
 (2603:1096:820:d:cafe::b5) by KL1PR02CA0033.outlook.office365.com
 (2603:1096:820:d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 19:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 211.75.126.7)
 smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 211.75.126.7 as permitted sender)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB1.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 19:05:32 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 14 Dec
 2023 03:05:32 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 14 Dec
 2023 03:05:32 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 14 Dec 2023 03:05:31 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 07A3E5F5AC;
        Wed, 13 Dec 2023 21:05:31 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/3] soc: add NPCM BPC driver support 
Date:   Wed, 13 Dec 2023 21:05:25 +0200
Message-ID: <20231213190528.3751583-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB1:EE_|TY0PR03MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dc031c-674f-4210-866c-08dbfc0e7b01
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5G82PBEyOhZuQLfw+E3Aa6rEvJFsmYwxdAPZQKQmW2fXKgI6bnnoEkSKQj3MBEmF0ZtB+3tMLj/g0HLmqB9oc90/ylFHdR7tLrP7Xg9w5wWJWNTgKeg2MSSEf6Ena4PoPIHHTGIwm1LbC71Kn1uuS6EEX9bhtIxArSszS1yFGEnckPC5HT/uhKfdfXN4XdO8285vbvTAODY4S4ERlr7be8xnXI0iQDFhd/Lt5t4x7H5HAznvHmbSLTRw01CtrYdvLoYvQP1qYAC2utTHCzhIUHI4OGXrCFoQHlfOZCkHO6a7UFu6YdKBpxJKiiOqcftOIwzJGAtGErHl/VZZ4Lk1qaeiY7RfOWUrCxSvuFHFebsw4blHeCaPBwBOV6B1awp1v8n2cHLmn2n+Xlu33ezmAegapZPyteC1xRqQqZkWoIizGbxDLnMGKH/Jfcq9r+LuumoGFBBZKB1FO8X+TdDcGkXyuLo2Q9L72xGpgykC7uQMZ59WVMAk1n/SfgRqG8NeKPAF4CCySxaIwbruqUuH3sdZTjZNm59QBQYmtQuAxYSLyfqiCRUIqCVy/uCaF/SuP7DcUTvg/U0S3RestY57j/sklV1gd2nafNNHEi5OtJcMj7jB+n1I86+FVOB54Ty2mo1zwH5D4Z8khtWdmxPKrtQC4Q2bI7TW5hVVKQ0C5MCji8Wc6tJlLT9/durrPYQqnEKXFA93nqQQPZB8eYmIcY4bpgL4I42ZQoXUsEHXGRyzlh+qYk4r9FCM8cR2q1YQ4WTpDiqFxW2UkF4SceKJmWyTIDoLu4SxH5jhS4dTD/g=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(82310400011)(48200799006)(64100799003)(61400799012)(451199024)(40470700004)(46966006)(7416002)(5660300002)(2906002)(55446002)(40480700001)(8676002)(4326008)(8936002)(54906003)(82740400003)(110136005)(81166007)(356005)(76482006)(40460700003)(316002)(6666004)(41300700001)(86362001)(35950700001)(921008)(498600001)(70586007)(70206006)(47076005)(336012)(4743002)(83380400001)(2616005)(6266002)(82202003)(1076003)(36756003)(966005)(73392003)(26005);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:05:32.6183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dc031c-674f-4210-866c-08dbfc0e7b01
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6725
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,PDS_HELO_SPF_FAIL,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds BIOS Post code (BPC) support for the Nuvoton 
NPCM Baseboard Management Controller (BMC).

Nuvoton BMC NPCM BIOS Post Code (BPC) monitoring two configurable 
I/O addresses written by the host on the bus, the capture data 
stored in 128-word FIFO.

NPCM BPC can support capture double words.

The NPCM BPC driver tested on NPCM750 Olympus board.

Addressed comments from:
 - Krzysztof Kozlowski : https://www.spinics.net/lists/kernel/msg5035188.html
 - Conor Dooley : https://www.spinics.net/lists/kernel/msg5034239.html
 - kernel test robot : https://www.spinics.net/lists/kernel/msg5034970.html

Changes since version 2:
 - Modify compatible bindings.
 - Add more details to nuvoton,bpc-en-dwcapture parameter. 
 - Using _is_visible() function to support NPCM8XX.
 - add __poll_t custom.

Changes since version 1:
 - Remove LPC present from the BPC driver.
 - Modify dt-bindings message header.
 - Add vendor to the file name.
 - Modify incorrect spelling.
 
Tomer Maimon (3):
  dt-bindings: soc: nuvoton: Add NPCM BPC
  soc: nuvoton: add configuration menu
  soc: nuvoton: add NPCM BPC driver

 .../soc/nuvoton/nuvoton,npcm-bpc.yaml         |  65 +++
 drivers/soc/nuvoton/Kconfig                   |  16 +-
 drivers/soc/nuvoton/Makefile                  |   1 +
 drivers/soc/nuvoton/npcm-bpc.c                | 387 ++++++++++++++++++
 4 files changed, 468 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
 create mode 100644 drivers/soc/nuvoton/npcm-bpc.c

-- 
2.34.1

