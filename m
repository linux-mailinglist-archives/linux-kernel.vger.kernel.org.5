Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC27AFC05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjI0H1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjI0H05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:26:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42999126;
        Wed, 27 Sep 2023 00:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6Pfxy6wG1DbzvfRYvK9QlfDXbE8cTjMvVLoXn8WLHYWoYU6guvf8zVchb3FpGV3i3v2bwlz1Uz/jrMlx0nbZ73X6vGBvbaIu9jPtRuaB7Az6EbYm0r1SmeEBOtZmf4IZvMX/edSF89uO7HARHcTQil2sOGodm1hg4zpSAPLrDSYNAHi/gI3EqQT3+tP2U5wV1uK8nzXzBbp83slfabF7DH/C1wHsLdWcV5tkPS05B+OQo5AN4qCunhjDAEEJj9QryWsWS1Z1csBjHhHZR3aejRVa5+sK6QSPjUyw2tjoxdygraIOX0m/5/r24poH7HNPGyE6zAHe5PoyM8TEIeW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNvPCgj6HwB6SzIsrGSoHHZDb5nKuZMAlqzer6xMG8k=;
 b=KXmZrSX5xR1JZuSUFJeKLAVcTzs/DRcJ+Aur5nLJXdn80bet9ZWV9Ow7+s5LAn9awsAScFzskujyFOPYuEtjlfUVcd790MlhBncq+ELD6YebaE07b/RyJvEUleI0UaIKHZDfIuDzdBmgkDiw2YfL+F5UpPB1HlolJhl7WcFsYlhrGtKxv5E85Ck5+T094ukASpAXclAmQUAe/eUao3vuQgj8m6aEzflORrP7WR/gCqj5D+3qlNNvFdmIFKxSxF3/Z0SEMJJmIvRMMOsPuV5cwxCqcu/Y86YSFU3gZEgjwK91GjQkGNChiVeQWvfADBLwFs3dXbwGjF/SJmu9VBgEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNvPCgj6HwB6SzIsrGSoHHZDb5nKuZMAlqzer6xMG8k=;
 b=y0cgW5YuUz8u7emIa285B3Zg36egX65tHkPY0Ofs2I8YJVSsQio7cAz9nYRH3b15Ey3Zenddjkv732ZYUxGIecSGwhGaH8Hl7E7yScbOSfA95ROvGcOhdwH4cjDKv9bdpB2rWCPqSCqTkccWWV/0srs79ecbrEqhmC35yFR+aUlB6mmMUigEn+jXzVtSV3vUjWvl3W0ocSBH9cSTBzF31RSWeogMIP3rhgaWUyrG6UlpLyfnHPs3zeixY0MR4oN+ciG+wtfAGoZXkCRBf/ebRDmDOdevGLdPPMsGyto2S0DkneenBurRYKy9JUE+v37vBYfvejyzVZFHeWdE3xbVVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SI2PR03MB5943.apcprd03.prod.outlook.com (2603:1096:4:147::8) by
 KL1PR03MB7285.apcprd03.prod.outlook.com (2603:1096:820:e2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 07:26:02 +0000
Received: from SI2PR03MB5943.apcprd03.prod.outlook.com
 ([fe80::c088:78e7:87ab:dd1d]) by SI2PR03MB5943.apcprd03.prod.outlook.com
 ([fe80::c088:78e7:87ab:dd1d%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 07:26:01 +0000
From:   "Rong.Chen" <Rong.Chen@amlogic.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rong Chen <rong.chen@amlogic.com>
Subject: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
Date:   Wed, 27 Sep 2023 15:25:44 +0800
Message-ID: <20230927072544.764285-1-Rong.Chen@amlogic.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To SI2PR03MB5943.apcprd03.prod.outlook.com
 (2603:1096:4:147::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5943:EE_|KL1PR03MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e97300-c08b-483d-ef0d-08dbbf2b001d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJS9y40kvwajYewOr4Kg9Qg83/7htZKtN/Kew0cCk0ITNyxUJyviUs66hIyZnM3i4sRsGxltJW4P/338HFXU5jG9X3JCvQYfCK/6fUxQ4a6vrVq29wSOTQxDTkK3dUTygpDAvjLDJrYjgvdwJ2JVHWqzX/I//9TPnRtM4ZK2/RrXEq/qYzZmtwvZb3NjWxMF60RgnBZHflDWw8cWk9eCs7F4m520Y8r4004l3Di0VYDzcsu2y5uagRfvwbNT3JyX45uKRfpoLzxypGesAfRaKU7aOLrBOD619SFw5PJZGAbJBwvKYo+rGvzr/0BODJlo1jracTACZO/o1jT5qWOmi/6ZrLNIKNrgbsIqTRegNXIhcISgL/4+yF+tqPJFtkYGiAd8mGMbXjMMck8gY09eD96ieqUgiYo38ri7wrrJYwmsCKi10Et7DPALuVFwMA1q84t42G3vp3TRHWF48hDszkNdwNCOcROWgPAry5wT1RmZuh1EQj6xkl+gZK/LRL8U2426Z20Hj2gfFKZbxLcWS1drS2muCFKIodQbLANzlhyK+7XqohXo7J6zUS+ZhWraiR+pAMNO+083ebjiEmRL35amB+4TFrvzZ2O2G0gpLCiZrjn8HMBKOb5ABatfqw+/I34f01uR2tVC/CWrqHt9IgAxAYxeRYJdugIRB42YaSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5943.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39850400004)(230922051799003)(451199024)(186009)(1800799009)(52116002)(2616005)(1076003)(66476007)(6506007)(6512007)(83380400001)(478600001)(6486002)(86362001)(26005)(110136005)(66946007)(38350700002)(38100700002)(107886003)(66556008)(41300700001)(2906002)(4744005)(5660300002)(4326008)(8936002)(8676002)(6666004)(316002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NpAi/SeEKbM9mabdh6kMFyWnovR0DtZbU1uakkWufYXpCeOellVlmfqJJ8cR?=
 =?us-ascii?Q?6ZBnbpE6hyIe25KEkvvOQlZ1iCz3Y7GyVJFn4Kt/IzckOpih+cNwkAT+KHLQ?=
 =?us-ascii?Q?LXcJWK6heqv6EnMyp/yVNHv05aAvHWAVrH0ftF5lPCcM2VDKmFIHkE5s9C5D?=
 =?us-ascii?Q?E9WwcfPKorQPXLMQcmIDhYDkijuJS7j3YT5rgeHsf/sAr/yDx5zzkhNkOYjZ?=
 =?us-ascii?Q?Ler593t2Fod1LBhcyJjF4u8X3hJHwYsDL6ms67gwwC1wifeNj/WKYyxI99Jp?=
 =?us-ascii?Q?hRyk2WyHl1QjAOUeMjkDZtC0I/Zr9g89NWC26M2phI5cAYfH10FQ2/szrBWf?=
 =?us-ascii?Q?GcATj2XodVdQRQvFOLZtWST4XBcdB49WsnwX51xrXaPtpO9YNk3w+fLNKMDL?=
 =?us-ascii?Q?j784rBXHtAq/5gawhNlOGwdAvxYerT7kb++IyqYZzimn5L8DlQMl334Mf07a?=
 =?us-ascii?Q?juuCW1zViOyoalIO2nj6M7rLx1rtzwSF6QJp/AddLoFB4lUiO//ZgTLadL1N?=
 =?us-ascii?Q?jMGvsZ1jRvJqdBh8UnE5WZ3sD4iD7Cn57M1X6OiejWjXmMm0TzBbEwdQPgTi?=
 =?us-ascii?Q?N3xScVtSbgGeBuZSQ7Vid56btXWiLaHk48CBvJ1satbahA+rlnO6Z8bSrCPu?=
 =?us-ascii?Q?KbFMX8Bd9oCTRdjsb7XhNZ6g+Ueg4MAPbIRbxlhVdzbXjc/GZ/BozD+fO/ky?=
 =?us-ascii?Q?XSfsDz0wC45D0PUsMMGWJXg3K3Bgf4DGW2Pe0kPtCc0amH+hkImKGxes0/qv?=
 =?us-ascii?Q?jHPTieTuY4NjJ+iijU6RNlsDP40hiiogOVl0KDvDfW4wRZ54aulZcm+bWZSl?=
 =?us-ascii?Q?cwxcwiYVlgYQ76lP1OrAdcqjF48jfhDbKIVzib9f7UFyKYLxkolHz5JuVT3t?=
 =?us-ascii?Q?9yg6jk+W/mg4//eUuXxRyv6AYB25K2lpEpooYn7jlm9xXeGQd3Zm7p7HnoaI?=
 =?us-ascii?Q?OgaOX4w9r4xGT5v436xbICh9YzK87ftoqZifPnQ9ubrbqaS5Mwy3cWW/iLiu?=
 =?us-ascii?Q?S3dAesgPiSKNqOhOXZj4/fyVGGee6+ZpsvveevkggEz9hQRmFD295V3lh9RE?=
 =?us-ascii?Q?4h13l6jyzkyoTWM5WAHWtrdhyttotcT/KcUf5gKMp0a42TNIQvAvqfBEMUAC?=
 =?us-ascii?Q?kOFim3tf5Ph3GyRIq/9hXspRP2bCJNhCii2S/FO6fGlDnoPzuVwcQtfeBBRk?=
 =?us-ascii?Q?BnNaPyvwulgHwuOR75+4yS06gFQhekckrlwp+t8e5+mi99JUHWEiRdrKxv7q?=
 =?us-ascii?Q?hSXyYCzPO4EgRzydmmYLCsdAeSTVBWzh6YkzDBgaOt3F190Bj+peFoUG/6dz?=
 =?us-ascii?Q?HYgL/oIrmHOE46WWMsxY5/wu8MjQFfP+V760CI3S2+LaRfcNWeCrnF89XIHl?=
 =?us-ascii?Q?aEfIqQIywEXDw+Zdd4U0nXQB6FDWH9z/YRHeBcvA7ier0Ob9DCi2HYlFExbW?=
 =?us-ascii?Q?yShbKsV/7WMXlIb5nLQ82bQKsrH100tvOrov3Q5slS9Thc5v8WjqGNoOq5tz?=
 =?us-ascii?Q?m2LhxLpASxGsP6ZBQwf4lfcs5AjxnD4kcJ1pdfuBxeMBTBFFsUcnuvQv0F4H?=
 =?us-ascii?Q?Esbxta3LfpFe4LKOLVSGuLWdeYXvwwGDvjy3Adzm?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e97300-c08b-483d-ef0d-08dbbf2b001d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5943.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 07:26:01.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upaKkhx0dnXsproctZ2sEdjnpiUNiyR9EmzEbAutbbi9kJRKhoPBMWKcMszGynAfGromgP5GdRHihu/VRgGCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Chen <rong.chen@amlogic.com>

Setting bit CMD_CFG_ERROR has non effects on previous controllers.
However, it will cause an IRQ and stop working on latest controllers,
This bit is used for selecting SG LINK of data address.
Don't set the bit CMD_CFG_ERROR anymore to resolve this issuse.

Therefore, remove this setting.

Signed-off-by: Rong Chen <rong.chen@amlogic.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 9837dab096e6..c7c067b9415a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
 
 	meson_mmc_set_response_bits(cmd, &cmd_cfg);
 
-- 
2.42.0

