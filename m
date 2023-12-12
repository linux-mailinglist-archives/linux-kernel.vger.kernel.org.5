Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEC80E8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbjLLKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:07:07 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2064.outbound.protection.outlook.com [40.95.53.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6F95;
        Tue, 12 Dec 2023 02:07:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/cRGaNPAq/ylzgl2ZOk/YlbDXOq3Zd28HxKe/iIDQCkozExOt6S9aBxt5u8sZpWJgOrMmNj65PtFS1lPdSpbXaXMYqlYFn9fqSPlJDXMWMBojXoQHqgG5tLyw4ysq6w1jgTkaQcCsQ/BlokqCZ9KCOVb4JHwKa8qnjWxEpD3XM0UBvnVgh9U/shmBxEjF25hkZP4DkBom6XBFqPj4jh34UurwIOv9Gm7JNk9GUEFZJmU51gg41JsThSzkYQRIFOHLsBRbKAmugd8iN9PEbYQVTYQXyFxUWqzOISxDmAP2EytFuKbtTLOQDYrlyU1Xa8O2UqYmAjoj7jyZbBZZQqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOaVrE8lnrkHPMFZN1jgjNOoq2n0qz/XHmtRv9xEnJY=;
 b=Z8g+ZjJRgjbvlOAeltgvHOauXPPeEMCwlaTYgjWDBu8+Y9X3hioJGZM8fRxp+x7mBCElCG3AobBp6yYP/IzOGSRmz3nDu/RGSJcKWWOhGzW8MRn0PH3Y+nniWMoM/r7gEboDrupBgE+i43mvtcXwU7kfynRXTPUksbm2bKWkg5Q3vtUjNqDCzv/UEdQSsT/Nnwt6ECp9H2IHLasO4tNKDwr0glCmBcOl/MhU87oAbFwwAjGUtmpnyFzUb14An5fHxLEkntfnzK7VCQ7U6H5kB+qUW9oCLbEFBJmX7pjCuwtwG9fMC0ZtkjmMQsVkB33bbEI/MhxMR0frWEIsYjSpOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 175.98.123.7) smtp.rcpttodomain=arndb.de smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOaVrE8lnrkHPMFZN1jgjNOoq2n0qz/XHmtRv9xEnJY=;
 b=RxtWJinRXz6x0FgyAO8lJkRbDwZTF3QcwT/OFrBMbd+xpn28jUP+SiFSVALnUUqbfm+m5wvxHnMpGekVhcQTWmu7wXbIaQCGDvao1rA/b2yvOev2NldDKFBshN9Ng96Dtgj47MnUujH9T7TwGjO26uVSP3X2EOCiODjtH9PXCSI=
Received: from KL1P15301CA0057.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::19)
 by SEZPR03MB7701.apcprd03.prod.outlook.com (2603:1096:101:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 10:07:10 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:820:3d:cafe::ba) by KL1P15301CA0057.outlook.office365.com
 (2603:1096:820:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.4 via Frontend
 Transport; Tue, 12 Dec 2023 10:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 175.98.123.7)
 smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 175.98.123.7 as permitted sender)
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 10:07:08 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 12
 Dec 2023 18:07:07 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 12 Dec
 2023 18:07:07 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 12 Dec 2023 18:07:07 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id B6E885F5B2;
        Tue, 12 Dec 2023 12:07:06 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/3] soc: add NPCM BPC driver support 
Date:   Tue, 12 Dec 2023 12:07:00 +0200
Message-ID: <20231212100703.3374555-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|SEZPR03MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: fc88d3f5-dcdf-42dc-2ed5-08dbfafa19bb
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2J2jGHPgNd8T9YQXBduU52L2Ys8fmPyV3Ucdtg335HI2oWZqiPaLXd98BdXo2RE5uCTnQnOjuXfwrtR1vF8ozd4Y3eFl0aVVlBFBPVsa//grzjVqFYMkxqOT9TbzM3JSG+9rgtdyvqEXlK/6QLFUabOGZz85zbPrQU4B6nAuZMV8dIeOksZyN+D+MPiE9qp6ykk1snX8QxUMxXG6MpBzR1LazCC8CnN2JHT7EYme5TTOJCS+JSyajxoZFJgTB/oe1l81z0dfn5HSUhv/oHr/aDE3i2Posaxvu636wWGmwEt6+QlEoX5UN81jKe0/9NBdeuJgxKg5UOxxs4BleAAGp2gB8aoOFh5kmoqUD2U4amOGJRwZSwKeV0tHgXlDQtWQw1gmb0qeERnJndKwSRJ3tMZ4o9KL8bRgpxNUD8GiZcwpe9BVrWY1Cl99NoOMANrCNnjZcWNLy+xeUU6zd/5yeqzqnK1sqVx/AYl4iFv8lf1Mh8pBSzdSEpiZ0ClQ/f2A0TH42SP0ap39CZzOdeskeYpsenQpErvEJLgFwA4oPg+CyWvtDKlKgZe103dMXiK8cqeJEibcN9uoPplG65srEJrQra/Ef+XK0CgWAkf4yVK3pVW4G9+0Ll5V378i6D5G3Xq19LApwqJBbPSpEceTCuV/L597XwNiYi5Z12irodVQfnsOzbftzGBxr02RA1eJQhYoiN2RPxeuSsXmSiqkvCXb1y7XAJsU8Z7fWTKRrxN3jqzsGqNTUkQyn3lbQYzdM0Fj0QbG5w3rShM3Ijz4bS7hT8iq/0Z9Gzwbq/Pbcg8QmEfilo/s9rjmPNzNs+S
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(48200799006)(82310400011)(61400799012)(40470700004)(46966006)(40480700001)(40460700003)(82202003)(336012)(6266002)(4743002)(26005)(1076003)(2616005)(73392003)(81166007)(356005)(86362001)(82740400003)(921008)(36756003)(55446002)(4326008)(47076005)(83380400001)(5660300002)(35950700001)(7416002)(70586007)(70206006)(41300700001)(8936002)(54906003)(316002)(4744005)(8676002)(2906002)(76482006)(498600001)(110136005)(6666004);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 10:07:08.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc88d3f5-dcdf-42dc-2ed5-08dbfafa19bb
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7701
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

Tomer Maimon (3):
  dt-bindings: soc: nuvoton: Add NPCM BPC
  soc: nuvoton: add configuration menu
  soc: nuvoton: add NPCM BPC driver

 .../soc/nuvoton/nuvoton,npcm-bpc.yaml         |  63 +++
 drivers/soc/nuvoton/Kconfig                   |  16 +-
 drivers/soc/nuvoton/Makefile                  |   1 +
 drivers/soc/nuvoton/npcm-bpc.c                | 388 ++++++++++++++++++
 4 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
 create mode 100644 drivers/soc/nuvoton/npcm-bpc.c

-- 
2.34.1

