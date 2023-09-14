Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48C7A02A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbjINLbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjINLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:31:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2046.outbound.protection.outlook.com [40.92.107.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B633A8;
        Thu, 14 Sep 2023 04:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/3a4GCf46VO/SgxL5FGEx+Ip0Vub9P0YbfJRRWQJY0XazQcHHlzoGnRCRf7gvL4kYKXNbWFcAUcDSI3cdzSk5wxGkE3tcO+LD+7oR2hWIZ/C5tDamFhE13bA0x5FtugC2KhxJBwMoPqR5Yl1G7tz6ee67zGSTHP4SqI5i+EPI4NSxYATx3BieWGrqJmVaT23XpyjC5ujXL16py8btzMI1otwq4wY66tL3KJyvG9a4sf84WhKL53Xw3dkcr5ELP/hs8o0IPD93nHAUjmv1hIAucbP+d/7CN4/CGCTyL443AtpI5Hw46YszbWxZ+HEzLg84paGgU3c9lgyj06i865uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VXog/0xqoXOi9PoJ6xSuC7HF0UF8wE3XAgjuHASgdU=;
 b=AGcRmNc+l2exNOgKoDWFUHU9+rB99JFLF1C2aNQyR+Xbw+/ywbAE76KY3p4O9L8Bvt+0dMZA3LKkyuKU52PeWDbWlsk/U/fRg73xnozKAbmpBZdGreloUPD03WWeRLJoegKS9uCss3fT7tbSIH11dYZo09KaZigG7lXz0xIfcVst56FVq04sUV0J1K16ONYyqScDlYNiIilmoiPtJ52eeF5uzqft0oUt6StaiPOqtkCbgTsiZOTjgspwDTMwfK/CYVE7IwkadsXFNOVrrbaNUGGzm4BEYtY3ifcTvNduy8nYfH+1uPvkP4+Vk2PW66LxYdZKO6PLJtImFrop8iPAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VXog/0xqoXOi9PoJ6xSuC7HF0UF8wE3XAgjuHASgdU=;
 b=uMoKkyHtB4pBogvQCCMXIOCsZZZhjUzmF4dVezXDT1K6hUAti9nNtzTFc3s0P5y1p41YmufwoKtk9MCc0DjiQVuK3tVjRHi9d1rYG6gQfVUIHWUZuiTnAreooQVxaEGFB4vsz8YZjV3OmvWzX4Cssg9L1dF8LpXEnQ2r+31ernLqS38yWLdLOS1JqX3da7Mml+eAEXy8A0MTfzA4U5Nk4m7jtngyDWAbn+Qhun7oGB9pUr0Z5PvU+fYEx0SbaB4WybCG6pQFjj3sglud+GEkiajku+FjR6O7wkf+4Cg/jwO8ykTmpIadWh8tZTix2UchJJ9YQK1qrXTlUwN5fHGRcw==
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14) by PSBPR01MB3607.apcprd01.prod.exchangelabs.com
 (2603:1096:301:10::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 11:30:50 +0000
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::fa4e:3c3d:23cc:79b5]) by KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::fa4e:3c3d:23cc:79b5%6]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 11:30:50 +0000
From:   Ken Lin <ken_lin5@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Kevin Chiu <kevin.chiu.17802@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Reka Norman <rekanorman@chromium.org>,
        Rory Liu <hellojacky0226@hotmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zoey Wu <zoey_wu@wistron.corp-partner.google.com>,
        chrome-platform@lists.linux.dev, linux-media@vger.kernel.org
Subject: [v2] media: platform: cros-ec: Add Taranza to the match table
Date:   Thu, 14 Sep 2023 19:30:34 +0800
Message-ID: <KL1PR01MB380907A7B0AD8A53727F87E2AEF7A@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [zabyN1Y7wJdEFxmBXrcSAoMqWlD+7HZT]
X-ClientProxiedBy: PS2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::26) To KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14)
X-Microsoft-Original-Message-ID: <20230914193006.1.I3e77e62101570491a2e135dde745294d230cd6b1@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB3809:EE_|PSBPR01MB3607:EE_
X-MS-Office365-Filtering-Correlation-Id: b10126fa-f8c0-4979-98e2-08dbb5160be6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9XcQvuh5b1OHXHR/sLB7/4aERDiwzlDlbSEXYiEa2LCEfSmGgrvM1qBDm1ny03vbPEdOVxyEjAnrv+9Ndf8jASp3DMco3zWRs0xckERcUJqw8BT+9J1oMIvQOl0qX1I9Yqy1/Tzc/dLDFDlbeUYmA49OaStVt1Sv8NBHxguQw/Ss6j2zc7zzERBoialpe4v+GCBRzPyLC2vxxu7NC8q2T9o9mVws7aIpu1CEr6juMlbizSZJyTl3u4pl/3/+H0sawb/d3iBPEgz92G0BL26ZlMTRaSIXj9OyMaWz1A8kFnUezVG2ngvJeECv2iC/wD4L/n5bsvKYXmbEatgYSk6byJy0QeGYO5F5dKqOiQyS1RUt0zsrLUNCM1iko/QSqGyjHB+rmTjVY5FMgbgjxCzmQvERDJcKqDneev/0dL8HPotrUKV4rX/4H8kbIiDDyMrSSzlHEjJGKcma1+K1vWPIzAruUI2xFntR1mCD/Pz17kcbsUSBLEP+O/VlRHOQJZb+JyrisM3UzjYPz64Wi7u0maaQP9eOugSpyCEgcniNEKab7CgtjhaBpfNyluJGJZh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPgseXKm9r5MrBubDrq91j/41Uw6cUFDNWzDGjTZWsBlJEZzsfiHLI5OvLZC?=
 =?us-ascii?Q?wAidm+5caMgemXBuJazTBI6e34Rf7aoRJbe38dZGe7DQUOAW25RuR08C93Lr?=
 =?us-ascii?Q?n0vziFJJ+qOmDY+IwqSvq8Nf4MtBxvqsYiLOZyejaS5FWG1t5/ejk98iT8Gv?=
 =?us-ascii?Q?yKxB4FvC7awdjE8xcpBUxKV6CBFA+TgOL9e/pHJvOjnBYJgRNR4ZiwURG6U2?=
 =?us-ascii?Q?TeTagZgh6oc5fbDNg7cpaV8N4mfUDiFxcOiidkJsQMLJtOUcxmJzS5jRoKGN?=
 =?us-ascii?Q?u/V0dvbLNRX94Ot72o+nvFv0o41xwKXlCx62gGY446E0gI5C6ekVeusBxlvj?=
 =?us-ascii?Q?zAmsi6nqeXc6VlqPJ0Od9F4CMrofvsFZXZWzUFu5Y9BpHlVDXLNAMqYfuurV?=
 =?us-ascii?Q?fxyUXP0CSWOCDjX07htos7ZDTSo2fW8njRAtBwrDHBU7iuxebIxjX/aAkfhQ?=
 =?us-ascii?Q?yp3kC1QmD4E/sWQ/Ag+TRHiB3yDj6F1ubyVmNTLg6GGrHH9jrovb88vtDrt0?=
 =?us-ascii?Q?MLq9YE5SHQOE3gKQm4WjqeXbNlHsPokAYFDYfzfvXNd9YnqH9gELtys6Gq3T?=
 =?us-ascii?Q?vo65FrRgWVEA9ZWP+oMEY/4GhR9AkrorNfG2ot2mgtsgaSXR10ckaPLg8lV3?=
 =?us-ascii?Q?5Tu5qEtaeMemgOf3xki78ENj97yLJOXeLYbP68Hl3zrm16al4ATjyrJ2Rdw2?=
 =?us-ascii?Q?fPKah3MS9NxFBtP8o3Szy/qVEVF0YHMFTLVvDwfi9AMJvLuZaZLZkeotJ+1j?=
 =?us-ascii?Q?4Gy9aW5OIMucwLG+Vh7KqBHTrYwjAENj7X5vfPftFLEYNOprPZsrK+ES5q1C?=
 =?us-ascii?Q?eTOBZtPwKRbYlmL13eGXAa3F5J5bQi1Clnn3PFRbqnZAaD+e653TdlrJ3L1w?=
 =?us-ascii?Q?NjCR8CdcsqNSYhczy0d8JWsLWH8dd0qmc8Auvr9uimd10jRn9iXHqlN5Yuzu?=
 =?us-ascii?Q?Bp7KP2frKOA3k9baoXpx+8XsQGscyQjtmWmj+o/hDrH06Kxzc9r4WdojIdf1?=
 =?us-ascii?Q?5guMCaXW/nDXReGWPLvaoXo4bBkqvJ8UVlq7iQNwllpxQTnM+e4E3XsPy8fG?=
 =?us-ascii?Q?vDY10+5Icjef7RoYRW5pK6yJ5klThmjggrzjDkwc8CTT953ufSLqLHgrGjpn?=
 =?us-ascii?Q?BWqGtAFeicHcC4kAnr38wxoESvRyWDm9g7RREE/LN9R/5te8xm2A9vxq36p0?=
 =?us-ascii?Q?wd4LwDTWj8iG65nxZLZjRNV3963kENMlrBH/Qw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b10126fa-f8c0-4979-98e2-08dbb5160be6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB3809.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 11:30:50.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3607
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taranza has two HDMI ports which support CEC:
Port D is EC port 0
Port B is EC port 1

Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
---

Changes in v2:
 Use a NULL-terminated conns array for the match table entry
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 920aed0d1929..66e96abc9abf 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -298,6 +298,7 @@ static const char *const fizz_conns[] = { "Port B", NULL };
 static const char *const dibbi_conns[] = { "Port D", "Port B", NULL };
 static const char *const constitution_conns[] = { "Port B", "Port A", NULL };
 static const char *const boxy_conns[] = { "Port D", NULL };
+static const char *const taranza_conns[] = { "Port D", "Port B", NULL };
 
 static const struct cec_dmi_match cec_dmi_match_table[] = {
 	/* Google Fizz */
@@ -322,6 +323,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Constitution", "0000:00:02.0", constitution_conns },
 	/* Google Boxy */
 	{ "Google", "Boxy", "0000:00:02.0", boxy_conns },
+	/* Google Taranza */
+	{ "Google", "Taranza", "0000:00:02.0", taranza_conns },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.25.1

