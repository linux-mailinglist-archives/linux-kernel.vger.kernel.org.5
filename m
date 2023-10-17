Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AB7CC415
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbjJQNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQNLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:11:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2118.outbound.protection.outlook.com [40.107.7.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5CED;
        Tue, 17 Oct 2023 06:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu6voIosV68YI5ifr2ESg4FHHjpjh1z64/i6nioKmxQSLB6/wsEc1NhetLz2YWY1GzXcBDBPafTLe3na6bkN81HcWyELegDxLge/yaqEMXB73hlaaH6RxbBU1v5Q8xpzWLa5ppDZdScVSQ5cKWR04sFpwTYz5XjioKGx5Hiv3jFeRSUG7WwSKWisY6Ag1Nv+w4kdhMMmxqw2m5Mpahb2lS4TwQP3E6aguMkC7/pTOD3zGNy4iAaLAaqqMGuAHBLFkQIkMa8cMdL5DLsOjgSnACNo1aWASyFhjJiw5hef1ADccPWIErp0BBQcwVNq7kWygkm3Z5xcGs7+DJeoF+S8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNgZZi17qr97aaiUk3P9ofMHjKqfiE6A3rZ3th2V9xk=;
 b=gqD7WlU+rq6wgWIrKapPHDUEH9SFl5w7IoWcC6LrxZcgIBynTOeCLjwPlE0equXbZE7aDN1NfwtSJ5yRa6QfARkTg7ulh62UnqBhpt7cGXBcyARh9oesvQ0qV+CpzaZDg/pNOZK5yruBi9IYwSEqoffp6siW/LjQShhJ5tEH/M0M7ZhcfzLjk2mAhmu/k8+zXfnkMeZbJDEPuK4Xx4Epv5XGyj3AOOFTtYI5TsK9CIpMNDTOc/cr0Evl1NO/JA/AWu0ZzEHZWJPzPndnU++1LFOEuX6V5J3TfBH88hbEUns2ok2ha6hVHSOrA/K/gTfT4X291TqLYLuktUaSQukyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNgZZi17qr97aaiUk3P9ofMHjKqfiE6A3rZ3th2V9xk=;
 b=letWA6nCuQnKxEuD8A+CupyRwGEP0ge2QVg856crKtF4iM7fGinDFeoa0DjdClHEdtKebWP6AdccQUkX/vUrO7PS23yP8BGmgZTwiOzCYbRzl6iflkzB64fKAlxu4M4H654WzOoFNtYq4hdNF7xqT8vd3bgAoeZJ5VxiHh50Imz2U8gnZe2U3cJXFF3zyuyyZn6zX39PHIJ4zKr1J7ge2QbFNQfh3OujrrEgyxrUx/JR4KN/lJbuU35/lMyOAmFIPo4FNCwLqr+Oz29K2Bip//TC1QH7TE0LEcFoi0iHJDsYQhaNxj8t4GdqLWwtamToQdQDhnk8MvgFFghsyC4/sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB9071.eurprd03.prod.outlook.com (2603:10a6:20b:5b3::17)
 by PA4PR03MB7453.eurprd03.prod.outlook.com (2603:10a6:102:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 13:11:45 +0000
Received: from AS8PR03MB9071.eurprd03.prod.outlook.com
 ([fe80::c1b2:3dfd:21a2:834b]) by AS8PR03MB9071.eurprd03.prod.outlook.com
 ([fe80::c1b2:3dfd:21a2:834b%7]) with mapi id 15.20.6863.043; Tue, 17 Oct 2023
 13:11:45 +0000
From:   Markus Burri <markus.burri@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markus Burri <markus.burri@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org
Subject: [PATCH v0001 1/1] input/ts: ili210x: send abs-mt-pressure for untouched
Date:   Tue, 17 Oct 2023 15:10:57 +0200
Message-Id: <20231017131057.1034956-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To AS8PR03MB9071.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b3::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9071:EE_|PA4PR03MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: c21a9547-9392-4bc2-732e-08dbcf129cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8S7R1uzq6yaJ63QFyL8GiBv2rbEfb0dKpEu9rdC3UCMhWiFksbXcz3rhe4kQdB/oQCGInhRnbtjLvujc3t/8nDQY0FCCFbdfI0z/IbD4GfFjK3uF1D0nmTzXNPl+ncC1ogGyJMxV/JEz8dCDqDLzBILnd900Jo0aKabFHueypI4TCkjYVDZmeFm5/JI3xg6JdAnIvitEtwBz2qgIo6AWsy1QPd/SLFMiXJv7xKciK93udTi8Wu+EgF+kLkUMs1UryL9SGqvp5ipP/On2z4Z5Tp5mAdLHjg/ExsYZelN2qBgZLsqwaB045nc0O20dDdzjvBJUtbpyalYUF1cXm0dJScIXXfKP5p/rxN1S1dmNjPPeem5rsUeqaD05z5xzmPLkq9lFd4kynP1vnA69yM4yLTVahbNZSm8gqPYukF9sb5NuC8Pg7PBqbB4Mg5ct6VWn3d5M/t6DOrZ0WfoldsfBabbZgg9Livl/JQ3XABRiNALUKl44ZDhaTHbKkc9Zp+buYTfgyEu9izFqKg8TdDgSX2uieiR6rhrTQDBK5TphEw3XiRqoPemJVOH6RVimM55eW/Eh5bLzISc/LOZ+smvnIUijAM9ku7K9lRK3EncXXEsge70KGC9HG7Ujzcoc28Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9071.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(316002)(66476007)(66556008)(66946007)(54906003)(6916009)(6486002)(478600001)(6666004)(2906002)(41300700001)(44832011)(5660300002)(26005)(8676002)(8936002)(86362001)(4326008)(83380400001)(1076003)(38350700005)(38100700002)(36756003)(52116002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FyHEWUUQpIY9HkYeqLBahAFgWCXBk48Ai+scp2S7bLftT8aggqgpo8H0FrU6?=
 =?us-ascii?Q?zTpV5aCZYgPu+/fbUemNpoVdOPB+fzQqSLszuXiYhkRCNqh74BNa8emkxX0b?=
 =?us-ascii?Q?aiOh46JF+FtmVQ11XYUiCLkJ+pWc4OzlC9//RMUFUs/TRel2VUa4Na6wRVfB?=
 =?us-ascii?Q?geyKYlUlUFz9WqihNdaEP4vWU0zzzqhx53wUSGKrCc8QSVMyQWBtUVwiM6Lo?=
 =?us-ascii?Q?Pd8EkfCnRgmE5LdT5sw5C7LiTsUDDokGmJZP7hvcu1ks2ovvb6tr+xBFa+6s?=
 =?us-ascii?Q?moKszqS5L5FNW3QAm8i/OA4m1UDAQeP/u/3Rik0I5YnQRlyZ0l9rdJHV0c66?=
 =?us-ascii?Q?9KkjrhuK3uEifyenAeWqn6PGjrrBIE6D94oRKrukCphcCCgMBQPI7Ui5/DA3?=
 =?us-ascii?Q?dk8cXW4jzZYrMBLMEzr6gnpz/mFDMByALxK+E5ZnSORMW+fS8wElzGYq1eXd?=
 =?us-ascii?Q?p3+xalX39jfO4Pvp+zKiF/A6a72590/DdpTmT3objKfof6RmRSYOCotxh7i/?=
 =?us-ascii?Q?KKegpu+n6S29qi5MJa0ksJQALg7KH0kMSE0kKNP66Jw+wJ2Lw/Gqgf3OsJID?=
 =?us-ascii?Q?ISdx8ow0Q/+zWrxO66hDHW+x2GBOxppDWKMdUyC/F42aGbp0p/BUXUOWkHhk?=
 =?us-ascii?Q?B+p06cyFen9f2E5AkV1f4xEXeT9zsBYuPu7MkInV8EdN/zjUFXuzexEfYmwf?=
 =?us-ascii?Q?Bg2sSeBtAa4EapgSsCsy9/n7yyop2RjtboR0WMztQIv1mUgayKK4q6Nc2npB?=
 =?us-ascii?Q?W6O+5MpkGKkhGDbLF94GsX8Xn4vfdp0kySaNRXVz117Ufo4cMeKTeB7eukX4?=
 =?us-ascii?Q?EmyfBtKHAHW7SZNmFN0GWoI1oYYLYw0dIijj50DK1oT1jMsjt7DhoCJ2VGKQ?=
 =?us-ascii?Q?/w4fP78MH3L8qv/4eUSzg6UD1Jc5Ij47jXrZ+axi3DTcvH5HtcgCcTv+1qjP?=
 =?us-ascii?Q?CC+sesG7Ca+wi95+BXbP9XeYOe+UReXtq3LebzKdD2tvQN+WyBWVdCAnZ51N?=
 =?us-ascii?Q?RqMo5YILryfma/AgO2M5HudSJpCaZgGv4d/4r2I0G0e3LUf3krBjtYZ0sPdX?=
 =?us-ascii?Q?8iwIHTE9YctsBwIxh4C36IK0YRSBlswp166j66xTKzuZxpdXAaHkqg6NpRrY?=
 =?us-ascii?Q?tWEEBnfCBZB5/YEXr829pr5ZayD5CXDk/a92/YeR272mw376uiUnromIwrIx?=
 =?us-ascii?Q?CJoRfV7pqFKmmFarOe3UA1VTPBCsjYebHY/Gbnt2L2+1UJSq0p7DlbDrvyY0?=
 =?us-ascii?Q?BbFep6SZdpS/an+VhqdH+eymJ5qNnziaa34+VSAeZFUYBy3I3qX6avxkcFtb?=
 =?us-ascii?Q?Lfvzr+Svz12IYDikpAPd6h7eDKaN2KdjUbT+dL0R5vAZCRey+Yg9v9o9kljn?=
 =?us-ascii?Q?JiwOWdJVzMhauSsA8nLJjmNtPIDpSwCiWC7+XwIcM729Qi5OK1jyKgD6gxN/?=
 =?us-ascii?Q?qfMb2B3nfY49MbxDHwh4SbRnOQOD5baWUZVI9D6E1kK4x0IxdyU+SlyoDSnG?=
 =?us-ascii?Q?ohl+pNHhgkDgHSLfF+j3V2y46z0G0XqT2IU+QLxHhzwWadL1+gGF36HsZpTA?=
 =?us-ascii?Q?6Bys5qZWN55KrmzvLtVaLVlQLb28kjAFL7SEmeS1?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21a9547-9392-4bc2-732e-08dbcf129cd9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9071.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:11:45.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjZcN5OQMnIwFwwzKgeY6QGHfseDaUDg8w4WybIUNWrBa2rMKAzLYoZu0/EYOFBUdcP6iG1Q9rMax2ujAlcJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send the ABS_MT_PRESSURE event in case of untouched with zero pressure.
Multitouch pressure is only sent on first touch.

Therefore send an ABS_MT_PRESSURE event in case of untouched with zero pressure.
This avoids that the next ABS_MT_PRESSURE event will
be filtered out by input_defuzz_abs_event() in input.c since the pressure
value has not changed.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/input/touchscreen/ili210x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index e9bd36a..6b79513 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -318,7 +318,8 @@ static bool ili210x_report_events(struct ili210x *priv, u8 *touchdata)
 			if (priv->chip->has_pressure_reg)
 				input_report_abs(input, ABS_MT_PRESSURE, z);
 			contact = true;
-		}
+		} else if (priv->chip->has_pressure_reg)
+			input_report_abs(input, ABS_MT_PRESSURE, 0);
 	}
 
 	input_mt_report_pointer_emulation(input, false);
-- 
2.39.2

