Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F27CE630
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjJRSTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjJRSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:19:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2074.outbound.protection.outlook.com [40.107.215.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F3111;
        Wed, 18 Oct 2023 11:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXib0617sF6gB92iIKMrzzc+GobdpLKXTHHLDUNt7vNjbRHHuQA59EBfRGYegC7USlHg7kwdPXZtF4zW41a4oQp45BXfVgl5KA6EurBIuphjtM4r+IIE5ze5AMJ4r8LK05IaTjQtz1DRPyPrrR608nBf33x2jT86PuSSpukMmb0U8TaotdsCjnZlpL8Yh5sD6v647dm2Hs1VwZsUvk3fTdpj2+4gjphsStIVxjYYkA8lej4Y01B/JtStpEqGIMCzw+FEOmyNVtrKAjvyUZ4vadQ49E1BxjzRVVuTWvYjakjRMiYvKNiv4r6GzjNT3HNkmI/WOsKjcGaoAraNb4sCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeQ59FtHGcGCydvoZA0h/fX3T3epa3YHFbT2jrtXvGU=;
 b=gqklxzq6VGzcIQWqM4STCnkcKoHEuyVu9uEQnBYOugVNiI9YkGDTybmIVLuMgF+7qFM5SmgGte/U9bwrjewD2fRNO/I5HBmsopyAf/SDwtOf2+EmF2utQ1H4xKvMhqet6lsMSjo3tljIa9gzaTbeA+T4SbBtn2GkmvlRt39QvbkGl5vR0mi6TWYvQfCNc3yoycrKcuFEbb1MffCYvHyCIo/JpwUxhRVcvnLbTVCCJAuOCZVLk3KBczGWPosIe/hTud5rmWXRbPQOHGOLbCqDk4dcLbMd7n/XnsQwlmqa6e+IZssEBg3wWa0L1xc+c6NYIPtB49DrHl+TzE1RSJutfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeQ59FtHGcGCydvoZA0h/fX3T3epa3YHFbT2jrtXvGU=;
 b=ispH93IRcKGkBbGFKEmsBS/N0LCriOmhWmNwaxB0dgEBSdiZGXyDTDBmMgEw6A/RTP8sC+6UX5uMA9/NA8VhYBCcXUiy4yuQROliLmTZ9OD7XyHeMoXKCoJ+yVmQtaZmI3ki+iZQP6r71+wc/6o2+35X5ZN7F8nzNLzyhpJXPV0=
Received: from SG2PR03CA0125.apcprd03.prod.outlook.com (2603:1096:4:91::29) by
 KL1PR03MB5603.apcprd03.prod.outlook.com (2603:1096:820:5d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Wed, 18 Oct 2023 18:19:30 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:91:cafe::d1) by SG2PR03CA0125.outlook.office365.com
 (2603:1096:4:91::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Wed, 18 Oct 2023 18:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 18:19:30 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Oct
 2023 02:19:28 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Oct 2023 02:19:28 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 6D95168E66;
        Wed, 18 Oct 2023 21:19:27 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 4A05821CFCF4; Wed, 18 Oct 2023 21:19:27 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>,
        <andrew@codeconstruct.com.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/2] hwmon: npcm: add Arbel NPCM8XX support
Date:   Wed, 18 Oct 2023 21:19:23 +0300
Message-ID: <20231018181925.1826042-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|KL1PR03MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: a5010bf6-ef02-41a2-66bd-08dbd006c554
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpMJB8pRD0Q4bFuBNqLAeKKcZ1r7VUaAvT3nODyvkOmSawYJXjLmJ+c0SGxBV7wohl8NymIco2hD53aBzWkzl6p5CLnjIPDc0FX4YfANZY5vuK5nHm5jdTgqoZX1RN9KsSCjvkDkOFMfYtJ3EbhSnqvgJM/d5AUIsz4vjQXPp4qmlFP3Q/DOA0b7mlSAlaJvi7E2TIcjMtcRaWl+p4eFljWwE4Rj2QiFmeksgYXtmrZSbS4kuu3AtCzCZrOK8zv3pqbS1lFHyTpufnwEnZ2RUQxPSEVSZ1qEhr0M2cyhgKc6yashROQqRFJtMJshfXX4VStnN+q0kpt/qJJ5On9wEoZ2cFEEnfARAbVNMK/BrfXS/9OEK/oIfwcLMimLkU9Jt1ywrkYFX+cgUoptVNtmyyc8HlPNRxNvlSR6gCJl8ycBtyq1zDMcl9zlOqbp2WGAbGDLcXWpdauOcmG65Y77T4yqxuNM37wfJ0+kgoYA5CWx7jBXCJsItZTPGozq737/CBtTFiMhyD1lkkqUVMa6kcAezaSAutlVwrcXJex0XGpxUyXmSdm5Wu1paSGnjLM3/HMxC/i6mCdRal35Qn8+0GkOtogOoElfn5077/4eoDRCe/hgP0VPcZ4MME43OyNxgKfFxWp+wQxSYiLRyP5I+2WU9k4YjNIeZlIC26TxflA3mzMIKuMULjrTuuNLP/7f9AqKV1OZL4c3oE69/fYgq5H5DeMrcZctdcRkoNyCVYRu95n9PId9zrntFjrS0IF2NfMODhigzFbT6rBFmnqmLG4pg/SsKzQtWWSaMHmpb1rPFHtfsiVZl4qFDRO1WexQ3LLZ19DfcLu9kHQyRj0AwS3VnS4+r+LHmrsDtzVmEIXknSltJLpT0wf8PnrlOHo59rh4PwRkF4PUDLK+ErP1ft7KARa/9QA45JG6UBCMFKY=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(48200799006)(451199024)(61400799006)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(83380400001)(83170400001)(2616005)(6266002)(73392003)(42882007)(82202003)(81166007)(1076003)(82740400003)(336012)(6666004)(478600001)(356005)(76482006)(54906003)(26005)(921005)(42186006)(110136005)(316002)(4326008)(8936002)(8676002)(70586007)(70206006)(41300700001)(5660300002)(36756003)(7416002)(2906002)(55446002)(4744005)(40460700003)(40480700001)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:19:30.0362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5010bf6-ef02-41a2-66bd-08dbd006c554
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5603
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

This patch set adds Arbel NPCM8XX Pulse Width Modulation (PWM) and
Fan tachometer (Fan) support to PWM FAN NPCM driver.

The NPCM8XX supports up to 16 Fan tachometer inputs and
up to 12 PWM outputs.

The NPCM PWM FAN driver was tested on the NPCM845 evaluation board.

Changes since version 1:
 - Add Rob Ack to the dt-binding commit. 

Tomer Maimon (2):
  dt-bindings: hwmon: npcm: Add npcm845 compatible string
  hwmon: npcm750-pwm-fan: Add NPCM8xx support

 .../bindings/hwmon/npcm750-pwm-fan.txt        |   6 +-
 drivers/hwmon/npcm750-pwm-fan.c               | 161 +++++++++++++++---
 2 files changed, 141 insertions(+), 26 deletions(-)

-- 
2.33.0

