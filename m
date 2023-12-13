Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2632B811C75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442416AbjLMS2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjLMS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:28:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9275C127;
        Wed, 13 Dec 2023 10:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0YiuW16mgRjuh+mAU1cgA7KyYwOfg4lA08b0HUP2CM77w4UbL9pIPp0dacnpomCKv61KcWPxCsacW96YwFjc7IKuZBkybjZusOMlj1iIqAV5Kdvga+LpYipIuVc795iTi9/u5KIC2nQWUMWZyDhzFQGH5F3I9tB7RYKSSvw8HdRhTetLPRE4OFSyi6UR1zWhUoMaNzDpKPfXCK2z+9AXgGGitqL4eglmAUy6fOq4LbHmuYujBEof6VoD6gvYEBgjxDQnJk+xBYiskRx+Q/TfIX1rTVcyW0InT8v60UdKGUiTSg/CdF7/0pZY3FpsQ44D42d0M4NqRB2Gwdc81CI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAB+2VWqPgQ5pF/q71H07YBh3mzkSI5r+fDj29BEmV0=;
 b=br2wjFZaLiAaxKaPPIbsbLYR38OBMdZQgSgGJYEFOt3x/cPyHtV8remClwcu9q9v62oqAc0oIsqXIXX5RpwgdP/luRFyvMN3lmi2nSoMAwq5GxAaJiAqQbWrgrDLYb2jA6V26G+Tyw5MVDtDyTCNtbsVosYUyZ6OpptLKGWtyT6b/cT8SfNfUD+qqaUXGT3DfD343RkutK3RABf4i53WZztlSz3fGbrCtLJBONSw3wMVDNcZbHVltihKtF1S0D/Xu9bA/4ulTzcEZcdaS8o6xC+eO9L/V7emXUd+ZU7YkBKyPj6a9n0EnyNFH6KcQMz95EkJq0FDbm5q6t6KYHvapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.75.126.7) smtp.rcpttodomain=arndb.de
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAB+2VWqPgQ5pF/q71H07YBh3mzkSI5r+fDj29BEmV0=;
 b=Q68w51nPDv6aFfYKJsmj4Y0rwqSNOFiXyJ3xeok4WG4Q8n1cxva+rGy9gG/KaVCUP22XDYt5UkDggTBOsyiDf0PYxVMUc15MNhYK32iuUK1pKh7eMeQc3u4aYUrQeosJCMiYDxjWzr5R8OdzTxiIglNTYXaC1HgW9YXjUz3acNQ=
Received: from SG2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:4:188::15)
 by PSAPR03MB5384.apcprd03.prod.outlook.com (2603:1096:301:48::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 18:28:50 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::c9) by SG2PR02CA0132.outlook.office365.com
 (2603:1096:4:188::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Wed, 13 Dec 2023 18:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 211.75.126.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 18:28:48 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 14 Dec
 2023 02:28:47 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 14 Dec 2023 02:28:47 +0800
Received: from taln60.localdomain (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id DF0AC5F490;
        Wed, 13 Dec 2023 20:28:46 +0200 (IST)
Received: by taln60.localdomain (Postfix, from userid 10070)
        id C663FDC3749; Wed, 13 Dec 2023 20:28:46 +0200 (IST)
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
Date:   Wed, 13 Dec 2023 20:28:42 +0200
Message-ID: <20231213182845.3744685-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|PSAPR03MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: 525f2775-e7c8-40b0-e839-08dbfc095922
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uRUpPV46GQpYZuTtt5iVddxJhWIpQWPb1t68wtLH69iXdDGQaFnk5gSn3/jMkm0LDah0T9BBbTzb3t8DvVSgi+40NAwPA/shqjEGvXnwBAHIzZvAORm2Uwqwv6GWXMcR+fFS9n8PvhQqwINTYLZFA4BGyhTjnxc4GpJig431dH8h/kBj4Fjr4+mX08ToC/+YxcCxs4P+cNS6UdBlUUR8+AEo6Sa519yMd4tCrOEZMgbZTwMmXbf2xRJiFnVruz+dDExzNx3l0QjZ0PJZ7Ca4ijUG/oY7FvaLFqgFliP+hMaRZOYB7qPwQJR42yzikUSQIyceCyv8GiIgJTGdPqKGCiu/tG3FJyfLa/Pr1RC4QDERQvIQQFuu+UGTLLtREwkxc6TZRoib+9DSvnYcdqZors0dTAj9dswJ8uly1Cwx+VrOpRli0ZfmZyEe1IRgeE8TeILMtoKJUZrol5JvCJpXSrD7w1+mu1WsQgwfwrWzryL9hE/8knTgrSB8VI2tnq5so2FhR+XTSobDYZMXW43dmiCZDrAVwT39BEddJZ7//fidgga9TFgfg7Ws6Vg0Gq7QjvOxmMXahGUSEI0E6FQGKl94PXKaHOPRmTmpdmePgS9QKHKdSNn3RltSLC4AtBo07SNOriQRj19QbSMiusMY41q9k2wkKNUYgPI7b+2K75j94boExVuU/UMdixQTJzzBYcxx0W3FCT0kiwIunuH2LC4NhvBHqsAZeyOUFrc37FpouGEBD6E8L7gwN+hA20Ipa1Epam9koUO0K+g1mFJgl2/FB11HZc1cpidDD/Tnnm7/S8Qp8uIbC8OrZnbuZrJJ1dJLb/AR5Zedh021nZA6u0jp0or6DP6Kg4H3hpSNZU=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(61400799012)(82310400011)(48200799006)(64100799003)(46966006)(40470700004)(2616005)(26005)(1076003)(42882007)(82202003)(336012)(6266002)(966005)(73392003)(498600001)(6666004)(47076005)(70586007)(35950700001)(83380400001)(7416002)(4743002)(63350400001)(5660300002)(2906002)(70206006)(54906003)(4326008)(8676002)(42186006)(316002)(110136005)(76482006)(8936002)(356005)(83170400001)(41300700001)(82740400003)(81166007)(921008)(55446002)(36756003)(40480700001)(40460700003)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:28:48.3109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525f2775-e7c8-40b0-e839-08dbfc095922
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5384
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

