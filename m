Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CFD7DDCB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbjKAGfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbjKAGfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:35:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2217.outbound.protection.outlook.com [52.100.164.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1537115;
        Tue, 31 Oct 2023 23:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT25mPd2JzYrLtqgyFpDvxzoEIharESHQxEYftOLatZIrVYCxFeinkE/1JGGr30Y6jdfgJvtGYCUwuFuSJTZCh6q22UuqaGEJJvqi0OO5SLPeQ88YcyTzDHHa/pavjxdyasarZ8/+B21e0pVZCIIcwOqTEKgksWDsu/SlP7GspluUqb1A2IVvsMc0AWn6QIZtpdqf5um1YL+iCsuyKOkPbLv96KZs4sGONFYNWcYLo+qhHbe2taVP9TLT8cMENklR+Mjb1VKdc6B22BycLg0hHw2n+55NfDKsuC0RhALBTu0EF9jZ64zWf8+Fx/oefiOViJ/NIRsh1kUV6ugUw6XeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pI1woDbbhMg0gbXK6xUmhQI1QmNxr4woQLsEAbCwLA=;
 b=gs2ge/kiYy+wz6CFyacqhE0jWsM3/Bj8mERrrIPC13ApQ+CIJDmO7GGByyMDTG8Fedk3Mm2NsKi5zjCAdsS/Ox9ZxSMZjxrgEsr/hwL3eyNnWXlY8w6tBuVe7K5mjL1XN78Iq7PlT/PV9AtnYMs0bHNnbsXoMxKzohq1UkDFYrBPTIGHeFMhSA8Ra7j6yIfYGWjwZGWjBNwSYrAtiQV/i5o1Gvl+KDqvKKyS50xjIOOOLI5Y9e2yB0eM/9z3Y0Y0V6NbCcmOtA8AkwrVZ0B+cELsOHm2x0swXl7X+AoqAOPlJfRkeKZ67VlIPVEIc7/QNeoZhtW45WANN8apvK13Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pI1woDbbhMg0gbXK6xUmhQI1QmNxr4woQLsEAbCwLA=;
 b=KAr7K29kcOnYfziUDdChXZJ3MTpOYzzpd25+S+7cHarJ0dUI7oGCk5txZ7Yq0jNrPnW+8mgpwURWWM5rmMjGa7CEWCsrBFbS9DWyR196CSyIdxlDbNBln2Dc/0ly6OVUYLuQrvbXx4jcrAOpFnsjKOVDNBVwYuvOzJGGHqYtKaw=
Received: from SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) by TYZPR03MB5725.apcprd03.prod.outlook.com
 (2603:1096:400:67::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 06:35:26 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:189:cafe::15) by SG2PR01CA0181.outlook.office365.com
 (2603:1096:4:189::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Wed, 1 Nov 2023 06:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 06:35:26 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 1
 Nov 2023 14:35:16 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 1 Nov
 2023 14:35:15 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Nov 2023 14:35:15 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH v3 0/2] Add DMIC slew rate controls 
Date:   Wed, 1 Nov 2023 14:35:12 +0800
Message-ID: <20231101063514.666754-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|TYZPR03MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: b0aee090-7da1-46a3-8395-08dbdaa4bbd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXZXUwxk3qxxkdNLPRRnau5hW1eRqL2Mgb0uakeCsC2scqeDHbKNzlEgAC0mKECyKGG2v4BLQoPDscSFyDuitSsH/tkEcgM0V0D0g/hicB5nn/BVYJwvgLoMnMhuomDqoC/IXFkcaqzhZExuDNPjelVLzW1cHNGh2rwIOjxuNMoSiJS4+OU4FS3zSxDnjbsFdU+W7aT7omlI6ZJEQLLQh+DoB8Sog9y6t7Ug4/FW+MW8NoXaAtusmxi4SuxNXJlMgbpF5wh6ruAm39HWaryXCdZU4qdlhTs2fNfO0ghA6CyayZIUpOnkHo1ZQUFi1TES90BoBXYQNuveiy1IzYKM2IH3pFDRK4m+bDQKdz9Kb/mUuwdq8zbv7TJTYW9dwdz4QUK0+W0sdzkQ02JjGvbXk+ZCEBe5P0z48hrCorSvK1jSFE5kjzz6QxGk+N3cB5YpJl3ry/Wo9TKHf9e9tqN2UgjyQM9lDGld+nD41xXRUPNk9BUmrrQBzpt7pMTSz9BvCeuJA8vsslvfOekF1o72oOE9vOVi7OnCWSZS9rkNNWEjRYmrHsn/w9Iy2S8sNIKs7qvqH0GWDE1zjbCGpVGAZztv9nnK0EkIEoqtKXIX7hGzjXdl5pTKAcC12FI4Rmhk2g6AQqZ29TgStXWuh2ISAsfr3qZ4Y0Rp+lsK+X6exQ1xrDtdZdFrdg2SpGNrqITGdUgK8w7cNo/bc9lau/5YdVYADA1Ec+MF7KGhpRla1LX3aHf6ImZ+tnNl7hxIbnQ73AZHFGcpQkhZjJH/f6QL3lYPBh0oy3lvdUbrmUjHUQJPlkPkr4EsqKkWHIPqkPGYNJvlP3odXnyijURj2VHdhOGN1irex5WfRzDKVv5xmPs=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(5400799018)(36840700001)(46966006)(40470700004)(26005)(1076003)(4744005)(40460700003)(356005)(34020700004)(2616005)(82740400003)(86362001)(36756003)(40480700001)(81166007)(426003)(336012)(7416002)(2906002)(83380400001)(36860700001)(478600001)(6666004)(47076005)(8936002)(4326008)(8676002)(316002)(54906003)(41300700001)(4743002)(70206006)(5660300002)(6916009)(70586007)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 06:35:26.2983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aee090-7da1-46a3-8395-08dbdaa4bbd8
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determine DMIC slew rate via property setup.

Change:
V2 -> V3:
 - Update description of DMIC slew rate and remove
   "selection" key words from property name
 - Corrected variable name of DMIC slew rate from c file

V1 -> V2:
 - Corrected description of DMIC slew rate.

Seven Lee (2):
  ASoC: dt-bindings: nau8821: Add DMIC slew rate
  ASoC: nau8821: Add slew rate controls.

 .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
 sound/soc/codecs/nau8821.c                                | 7 +++++++
 sound/soc/codecs/nau8821.h                                | 3 +++
 3 files changed, 18 insertions(+)

-- 
2.25.1

