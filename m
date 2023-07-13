Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600DC75176E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjGME1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjGME1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:27:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570D3AAE;
        Wed, 12 Jul 2023 21:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq5+43TetfrwLi2jyZMv1bcnwXFaX4/avqzaCGciMKuDFvfsO/Piu/QaTvrqDlhSsOvKiyWVb+4HqD/+/2IFPjIipFBYWTt4+XSzL2BSX0toOjKmewXFmgoetxq44FGDuO9futrKxlPPJKXTTJYGZCAqKCawZvgczUyNQLy3EE+zvYLLSBLolSAVn+ilZOF5bMomJ1JR5Ts2exQj/2WozlPaUOjdX7oIF9ofrBW5VFnoiF6AiRGPOxtkqMvIn8ysDstkY+mpc3u19wlwUb9bgagzJpzpFpgbFM9JJTBr/HPceBD1Nm0Wfj1dwSTZQU2/ZdxH7gtdau0l3RgAxsq37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfx9lAORIyS9M5LAnuWNbeLvqLfTUU6MatVBQui4DdI=;
 b=neo6vRTPSVQZCy84dYvXUDQcL+rGhtzMfqqgUfuqU9qrLUkDbJhAwJKH0POZ4IMjnqSgOxYXfjYAL1rcN5laGUZAv9yU0xuzl7JRV8L2S+jr9kv7jhkbGo08fpWsZJbvNTFGtDIZCK85NBB+rOuo+XahcGs+7ylONk4WXvQN4jNmgRVFU/6umx3SuthkZxKMMgPGD7CFDESPO/8pTBgfhZM1O6JmGQAOcxQLaigZhFGxGtz4wxY5oHS3DmoRCHQAMSjJb6ccjk6gRqif0wpingLc2vmLbrSbCNXIZHspf05EQEqc1Y1i4SBMvP+qPQwt0t2MVPZ4sawmpyVX6T6gVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfx9lAORIyS9M5LAnuWNbeLvqLfTUU6MatVBQui4DdI=;
 b=eGe4jf4DvF5wtoKMlfAzkW7sZflCCHYvDGecNQ+5L3hRBDjiWY3FPlVAEHHzRYWzraAnGiEh7Fz+giWlriAMeLjeVjfRIIIM70bw/+wVq07dMjL9Ewdm1LBb5j93Txho+qn5SPZ9Ee4vSR0/QoysE4j+hU/pRPgYul4lAhVt3CvXSp1vi22QZZn2r0HUwRHFuep+Q5QOaKf4Zx1CP3wx/ulcgJrXVOCD6pNM/pXVwqFSAsu47UjMyZVtvATAoea6eg/aNvzjBcBaSCdhdnhGdkGp6ncjlynTLgvyA6s/9hAl+FmuMbKzL2WI0xtRTcehqlQVoG2I4YH/UrjoaIwsUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB5025.apcprd06.prod.outlook.com (2603:1096:400:1cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 04:24:33 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 04:24:32 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] drivers: mediatek: fix parameter check in lvts_debugfs_init()
Date:   Thu, 13 Jul 2023 12:24:12 +0800
Message-Id: <20230713042413.2519-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0254.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::8) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: cf84d3d3-f347-4270-5bd8-08db83590ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWLxAfhsmZT9JNeERZMJ+Cbc6Z73qt/HNhm5m+iK1DUAO9ui84WOPp/Fpw3vZ26CWD5LIufZR00Dx8cxAFfS41KvKQYsOHrR7HaljZGMdbTUfdmDZweTWsg/f0gS5OSYuD4J6ob7uG+SnuZaBCnPtyz4C9pvYMEwXZQujmAcZmOIs20S1hEe+D8a2YgnNY1cWfRV9mCy7M4JTbqp8n5GZjo4MA/euPn3RvbD2Hi7Hd1/nqPYnDhA5sUMhUjsmdm6zhO3Lp2WQmf8j9lcrd7Q2eV+KPvoP2zL9jX1RNbh/FiSoRjrhWfuPCbTCw5zrYy/dyX2ZD2AFetcfC1NqekDqRVIy4PbnOMVP954suoY7mIEb/oUDgitd8EVsnV3s0Vm+Q5hrGEBhnSgbjpyU84LaRzy9r5CB8BeWfU6tb7qPgVvUVaBZE9zSeeT7+pHhBH6iEeFpNk92f23SkiCwL+ltfpwhcpoZMsxHMJFQs9pPIUWwMt+OX6JloXXlL6Y0SrZXl5oO6kUh5/45BC2aq3t7ZAg+Osjdu2tbyUto6Pq+ojBw9t9moHh1TNdooqWOqMyckduqT/AskZAAU2R0RFc7LJTV7zrKLg7HFZhrKJNZ5Izo8ttDxtiBG+PqPdrUDXN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(366004)(376002)(346002)(396003)(451199021)(8676002)(8936002)(107886003)(5660300002)(478600001)(41300700001)(4326008)(6512007)(316002)(6486002)(52116002)(1076003)(26005)(7416002)(6506007)(186003)(110136005)(6666004)(66946007)(66476007)(66556008)(2616005)(4744005)(2906002)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2J2dKqycPB+kWYZs6NET++Sl+V82C6vGGcCW4mcF6QSX+I4uS6V5yhy2HOG?=
 =?us-ascii?Q?ohnET/SXYBhLutI6nu/0ZigBsB75AgKOmaq6Ttj1t9IjsmuhWxRvj5YkP3Fq?=
 =?us-ascii?Q?o3CNu/bULYhePQPI0OetOZoX1Y7Ur8cJgzRgXSGIjf1bTsCEiUnP8GNQjk6A?=
 =?us-ascii?Q?Ze6wO32lfO3UjagFPxmzbcFDgWaoPpXj5LVpq5NXksC0iDUlPduILbji/bhg?=
 =?us-ascii?Q?pkHOxY2/fumMgs+lneBdiYR55tMxhM/UMQnVNXB8AAFgsZDBcyQ8bLcsPa3B?=
 =?us-ascii?Q?mMsi6SU7O58gsZr2t5H2XnV1nf7Aprj9LJogNEILOEcARedle4Jt8AbrRv+P?=
 =?us-ascii?Q?bM6SWLULFgaJq8E0a1OT0r+BUCHPrHF8+kgt9QtCABDVSKaTW9pM1CqTPnxC?=
 =?us-ascii?Q?frM5l1ml/kY004niw+fl9zzDfEbQE7zgIzrNOaJZRQCMFtJ9DXOTmRW26pUP?=
 =?us-ascii?Q?uTO73I2fOt/iTnMmAevBw90EsWPe5MMwivxpBpdiwrJMbuJwkGIgj+1ZtM9O?=
 =?us-ascii?Q?gudq/7t7rjhaVT7cBQ4jj3l/JWtWnZwUGxehjIPl/MfXcoJJe03+vPgUvsR6?=
 =?us-ascii?Q?DmDC6fmf2U0FYCOqZP9ZP7Jc9YJjbqqsoJ1pq8xigihToqTSlt2LFq7UHOKu?=
 =?us-ascii?Q?+mmirfifn2a2mlhOl3OYQK1guy5gK5g8ndOIjv6Lu26O+NQd8kYMYuOuv9M5?=
 =?us-ascii?Q?ikhdWB7wrzOoVsYxkaMahurWi4zqKL2+RwHLGCb8OG0WDkQOmQQ1kEfLzD1I?=
 =?us-ascii?Q?DuNQ5MEMcaNSmX4b8iMceBuZlTMvBs/U0RXSJ6o8DYXm1H81YVDEBOTTYCxp?=
 =?us-ascii?Q?yIjj55hn8oBWZ8CIPi4mIh8Ph2VEL5hvoYeKYsIUmp8ZWy7tepetciYfnQTD?=
 =?us-ascii?Q?DqIfJ6vILxt5b11dCh4040fNQD1hOwDZGnKIXHfcOtB8PQRemvB8Nv4l5YYH?=
 =?us-ascii?Q?QQwsgDEbYUwCuxaqs05hgWWy5DqRH1d8vTHPL2uOQsJlrpaCDW3DkQNogoFO?=
 =?us-ascii?Q?CjDaBKZWMGRMccssjmtZ8HI+6bkOnnaGStxXB5SCh7oucTafDkO3izxsII28?=
 =?us-ascii?Q?6rTI6/6T7lmY9bwkK+Xcz++Iv1IPSUEdLaJX0tm49KfsqGwI0DFPWEDouuJj?=
 =?us-ascii?Q?ocxvdHtbUrrBA68lYK6k0byBY/jIIk58ESD9+i1Mro2mmX9HwFxCZBm5yX5c?=
 =?us-ascii?Q?/eGRdwXAI6V++2beBRyxjHKNUgGrsoLj5Pw+astvcKikuPW7sQsTMsGdiCm6?=
 =?us-ascii?Q?DwIkEUdxOTB3o5CDOhhOdAxCpF8aXFmO0cOXR5gqaZLzqlGOdB5Mk7ycqzg2?=
 =?us-ascii?Q?fZBhvV272NUZ7RIIWbUXOyl2IT0YNWDCUCemjD4BqDdeMW/XYsR857cn2m2o?=
 =?us-ascii?Q?MQcqhErLPcSI3QxyO/LJ1Svhs8ZbeTLhze7hY5M5o3UCck0CnMBHFYAHAguT?=
 =?us-ascii?Q?ehkGddXHLl9q1w8FkUbdjuFJGEunGIGXaUTeYARTbmheUlb6TnLz0qX6ol43?=
 =?us-ascii?Q?AqbH54dsLfPJ7BprtYfTPNvzxZgfhWCTrHBdPii1Qrk9s4GbVjQDAfN8/5/I?=
 =?us-ascii?Q?9O4GK4E6B+yrJYRtdJeH5UCMoDSbTmc7CZkGAyba?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf84d3d3-f347-4270-5bd8-08db83590ed4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 04:24:32.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/96naRJqFErKwNdQVeKYbEv3YsHutj3E5hjMMWqeCiAjthcinMXobFkZtU1x9fYbiQz+/3O6dwztkILjEdhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in lvts_debugfs_init().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d..b46f351d1 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -190,7 +190,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 	int i;
 
 	lvts_td->dom_dentry = debugfs_create_dir(dev_name(dev), NULL);
-	if (!lvts_td->dom_dentry)
+	if (IS_ERR(lvts_td->dom_dentry))
 		return 0;
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
-- 
2.39.0

