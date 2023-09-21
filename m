Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C87A9623
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjIUQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIUQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:57:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF0CF8;
        Thu, 21 Sep 2023 09:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqGD287hGXI8+jZyCvUQFS6W6euct3mSnFquWIDzEAp8Gb2EcsNxmeZKVSS1wTjxjkHfcV0RGSjZlTL+F3AWbXOQz/PTk02G0aVbf3yjaZ9CSj1/HDCu7zXESMeNDdq76ChI1RZ8+EAtbAN4blWh5cRqL1H5BKfrTrINRbDT/krlNSYqqp3uR99McMiJs/EU9nXLwW7htVka5OKMhuoov7z7r/lABPABWC0pVSCsaiyzI/ilWh2udnTPAQnue56TvsK/lSrhq0riWk3O37KM5EpoAvG5i7xS8Ow/e36gCHbdYVsiqhC308Ub9csAoPQKNUskiJPQhs+5RgDQKxn9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA+uXESCqUqC6ptodBbmlsOHlWbysh/mRePngZjrs+o=;
 b=ZckIVEyKepQQT4aqUxlaQrPchPkrWsCsJ4R8tkpxG2m74NSO47SB4iKgHZipGXqzMGelTvxmeP2+RWQ20iin2TDoHLv/DSk08MFnV94tqYVzzZXcWi3B1rqcjUG8gomld460/9OsZyZA1hVUUc+Mh4pv5kq/zmN7hmr9iPS3eEHMTuCkccbWS4EBVuNXbsv2S0vQkvr1HLlv++mKEioNSVlTiik/GcTq4pygpIGiVAfc9b9WlxpJO2yqE/eFn3JHc4hIvOAgviVQguzSMZ+PmR4AH8ygyCoymac08WPcbAIVp8tJxN8nAeWYagtBc1vEQNW0+56HuDx1nJpQC7/dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA+uXESCqUqC6ptodBbmlsOHlWbysh/mRePngZjrs+o=;
 b=XINUmdQKc0wmdDukvpmEmNnjK1mNLaJSZspMFlKaN7euTR/OQrvSnTndR/fn47WLwtzSDrdhxvKjpjDA5Qe7jcC3S08cZLK+dAMLbBIhpnG7HPYhmMJZGeuQOTdem4gD3GqwkhnL1tE83EvJUYHIWhkx8Y1sgO3YEm6Qok+lGRJtoS0RA3UDWL6uyx3P9ncI77jZaH8HXVEBgoxGDgGS22+1GayRP7C5abmY2N1iuwLQVhkh7Qd1hOuUz+6Fr/Nw9pYhs+qxsXmTJmi8QCb5ZDlSSY0pl+YEm2oo+qsVYp1reNa75pFdezqA6lgWGAMFi0nzcwE3PCUcVapmTK7tFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB4634.apcprd06.prod.outlook.com (2603:1096:400:125::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 07:56:16 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::1d4d:f221:b9dd:74d1]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::1d4d:f221:b9dd:74d1%6]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 07:56:16 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Minjie Du <duminjie@vivo.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] thermal/drivers/mediatek/lvts_thermal: remove extra error check in lvts_debugfs_init()
Date:   Thu, 21 Sep 2023 15:55:11 +0800
Message-Id: <20230921075518.3016-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:404:15::35) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: 564bd8ec-13d4-4368-619c-08dbba783b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QLXaOr5bjkIU7Ig0wiefr6dKjzUOhOHDEWqadaq6nXhuBMxXe5eE4OK7Op49ChpiX6X5rdLAhZd9kJntxTd69iQe4EVu6iYusQadjV+glvNOxqIAtEWh7v8/3BQC79PwvqXZy47XOJgZlMaqQk9T8U0DvGZRbwTgeTwjn70FUeWfIulJMVJgAyuVHArOY+u2ExCmb5lr5ga2Sdf7rJkq4nQ7tLEVaZwQFsnNnfD6ymwdAwyJwe80zp+H/sd2AceorpYJRjPQwJtVR1C3F8WA2DLpyef/rRWvWQChtRSwgAvShPifJ95GTNP8fZQvymNpS7UcQtBXjwlxru3NJlQTDjjPm8pRpf5U8XW04ZYkeFdOOfrXZ72h5H6tnV8xGEIQzub7JBVWUaos06WoxSfV4s0cU3Vy+xZYiYJnjIOpIkhq07wPOR4ULJ/rNaQHPBNVuVhyjmYAqdc7urXb1coHURlJ2Tv7IRBLusKzABGKwReC106A+S+icOaVXMX+AgvH5WwHMsT1T3oYZp0HQqNTJe2XoXYTT53RvdVGIQQ8NrAnCtRJjngWysFV57FAvVnbnMkXyHVnKNLn456FrATLssYZBQixRUHEl98y/G7gDRYUvZSxUgVsItTHquwML4IfA/YEIdrEszOJDhyUpmqCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(1800799009)(186009)(451199024)(6512007)(52116002)(6486002)(6506007)(6666004)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003)(2616005)(107886003)(1076003)(26005)(110136005)(4744005)(66476007)(7416002)(316002)(66556008)(41300700001)(66946007)(2906002)(5660300002)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nCl7C7rkIj9P6LAs9dLqaUwOPVLA/h9wswAofsqRe2hCl7fRaehvpgMP0hRi?=
 =?us-ascii?Q?5LYg374MGRzTa+L+CaNVwUmCw1r6knNjqkYyTejBBH0LaC5i4e5TM298dMFv?=
 =?us-ascii?Q?uRjzL+egwDirVwwOasuR3x6n1WOREI48/GDQifS/rqybjPZsm/j4AoAL3Gl0?=
 =?us-ascii?Q?gW+GOC56+P9x1WswLepQEvKLGhJPjVEbrX1DXZhU5PLvyuQFz7ODpA9Ud98l?=
 =?us-ascii?Q?vrw6WsS/yQnE8WxU0JlLZkGddL9ds1QSQDw6TVTJDIYrhCwfv5Tz/TOsLDZN?=
 =?us-ascii?Q?P5W2szOHe8B1IwZgzx8KZ/s6v+NNDbUtA9EdfewjkN+0PQklNZRLdCchlSDj?=
 =?us-ascii?Q?PY1XTV0fCTvoFYkVMqKMgvjsEnj9Ad1OsEqhvmlf8GXv/CCtrJ+BGsYriz6I?=
 =?us-ascii?Q?b67HFu6keQ5AmRFip/ocxE0sIA73os06uFogK9CglgmXOAuVcgKb6QVV/pYw?=
 =?us-ascii?Q?5r+h6RX4FuSIwWuLvgqNvDzXlaiUftYl2aaqcNBGAWvdOB+z6nlnRR6KdLfj?=
 =?us-ascii?Q?CKklNhAZ3vxkIqgBvKbYxn13gOmeSqAbYs0rcUFye/wNbijm6Ntw8c3VtmOU?=
 =?us-ascii?Q?6AzPNla90CJPVbhV74BzjEz/aMNjKfXhPdt9ugi2Sh3S3Vj50QtrWFtgWjeK?=
 =?us-ascii?Q?Q6emwGXMQ251oukvgX/dp+1j3c7RannmViuDvPJGqhU3ni0/jFZwrWA9gO+X?=
 =?us-ascii?Q?+6PX7/o3ysJ6/ar7JV2JL1WQYaV6mUS7a3eRi7dyVJR4h4fbzp5fHGJiq2Sn?=
 =?us-ascii?Q?UjFNiV0IDrdYFy2w0s+rWqix/sCixZDTltw8QaZ4S49iQSqwy1fgQHKICumy?=
 =?us-ascii?Q?H/jB87rkn7xmhw3UoCjTtelPRosk3AHyxiXTIp69381gWpJj4EV7KAhrVsLF?=
 =?us-ascii?Q?Yxoit4emhu8FgmVAxc8r9Sz2u6Hgjk9WSTVv1fWczD/fT6fw7t2oMjdLOWzc?=
 =?us-ascii?Q?nlRcompQZ1ngKEOob3dEp740mUCPpIWZVE3cCCR/lJ7yFD+8l3qv/2nQ+k10?=
 =?us-ascii?Q?LS3F5oBTPN1G+J0MG8mPyzPWIIvtnzs/fIpf7iXk1bbLvLoEZahBlLKooHeQ?=
 =?us-ascii?Q?x1rvoL5V9qk5znPFekJqy8K+wh8frgk1fmP6JuwrAc6TMq/oaKavQMkTH8FE?=
 =?us-ascii?Q?2ze0ld0wQM6lfOruzYuGcQCkeIS12JHlm6ahgoZRRhK8sCq9Umjd8mgMafA/?=
 =?us-ascii?Q?mhE9cl7Gnr+DiSXVLMzhWgotAjNtNZiJII9bDVErJBZIb1PQD/kYTbFKrke2?=
 =?us-ascii?Q?6Pz9+r0gwZuIGRdAWmAev5FdUQ6fxyq51Q03NN/kTpNShs/qvhuz13VKPDuL?=
 =?us-ascii?Q?3lAM/jWXSoLaKsB8i/v/28jte8H/QJyG7kq/EXSELwRNCNol4lJ4XBmi8jd1?=
 =?us-ascii?Q?g/00ZsgW7OX3VR2ORRTX+W0pgTg06oetutlD2NBhIgjHHxhQH/kmnp6YjonG?=
 =?us-ascii?Q?wFxx6UAfNSNvn9jm4OhoN5Nh5xQlui3ZJcCxpYScCEBQiy56RT7gbvyjM+EB?=
 =?us-ascii?Q?pVMVNNtWNBXUFfuIldiAuKvXOA/CrNbQU4iOV8E+UD3Ih/OUg1q+mHOn2yKk?=
 =?us-ascii?Q?/QlAImt8C/CPRVFUFWCeAIlVosNjly1pMM/OLy60?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564bd8ec-13d4-4368-619c-08dbba783b9f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 07:56:16.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSmm6VRhlexzJRkunVXHyUI5LrSZL/2JIaE4XlzPsHaHZzSsu5wiPDRIiNZ415qjq3T50JDFwmayFc7o2e8JUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4634
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the comment above debugfs_create_dir(), it is not expected to
return an error, so an extra error check is not needed.
Drop the return check of debugfs_create_dir() in
lvts_debugfs_init()

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index effd9b00a424..171ce25fddf5 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -213,8 +213,6 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 
 		sprintf(name, "controller%d", i);
 		dentry = debugfs_create_dir(name, lvts_td->dom_dentry);
-		if (!dentry)
-			continue;
 
 		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
 		if (!regset)
-- 
2.39.0

