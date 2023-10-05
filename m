Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A034F7B99B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244327AbjJEBlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbjJEBlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:41:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2028.outbound.protection.outlook.com [40.92.53.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DC8D9;
        Wed,  4 Oct 2023 18:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd8s5tPbmzDHjmqi2+2bTMjVjGnWhyzhQFNS20NSyzn2CwGiwxz5pF6KBDGFuliJcu7SGfYyI6a8RZxTmnYSoTkIIPyW60kdst0M+v10xmTaB5HVtlYnLnvyrCOUBcrjNiPOXJUyQoM0VlQXbGEYtoVUUtcKcdfkW+aFXt/+cxhb4VuhSzNDFxY3mZaPGe8HVpqPZ9LTo1gUjm8mqoMwgtjUoaN288lbOy18oTplJnMkOZBjmwKEwTxQGpJDIn3JGbPQpYoBvmqYq89P4WhcqaBC84f1pDrqUZOnJhN8OyZfkEiJJuAvII0r52uMLOq7vidXrnZtKCDO3NTJEwibjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIT6EfdtQcrQMZgjnfXHt9gJBek0TkcbxbquY9ZGl4E=;
 b=DiyNKuymuUD8HLvSZ50iqG2YgE264ZiIKeFXOuRHaCaLsD9iBB3VnWu+NV4E0JkDXKrZGOSLHpgryuGRgxGKM9mOj85ECH4mDE6DDNtmAGyx1mrSjTy453XEgyim7x6b6zdY3EEKiNziPEulObpUzsAqESlnL28Czb9o+KPDB6EN52QHntDw08BPknOHUI9sRM+X807kT1iUkRvN88fMqVIsOt9LxPy8o/wJEdTijVk3WgVaA3YNlUb6aE3SBq+eJGtky+mv1AywE3Iczf21ADNlbEgXtKciSYl4xnoDe42mejJVEcB+Ue6TYhMuIiWIndeZj5bqHdF5vjgzSzM8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIT6EfdtQcrQMZgjnfXHt9gJBek0TkcbxbquY9ZGl4E=;
 b=gWbudCwThXYVvfXQ0R2EhSjA9RdF8JifZF5w2D1jH9PDzAMeSjuPvthZ7dxDhqTfsRUBobPRY3NuqOuoA/FJTDSAaf+G6vi1ydZ7E5IZeWk73YUQAPnoCcEseF8E/r99CauH0JMticZnHyTaaePiPY0n9Bj2F4TAEees+Y7dWIzIbBFTjCCxxRdsTPELllysQ0I5DUvsbocy/bXFvipOVozx5IFkRLY1Dp9m8Jw/fqmWAHS4LxlXaspsuUbIPS+kaanh81BJnEy04n7Bd+H8NMBwlDj9nxbnmyly6oK9iG+8EdUuhOqRD56VBDziEPhVa3kABZsKbhoTr/8jmXC75A==
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14) by SG2PR01MB4592.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 5 Oct
 2023 01:41:00 +0000
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::2f73:985:641f:399a]) by KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::2f73:985:641f:399a%7]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 01:41:00 +0000
From:   Ken Lin <ken_lin5@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Reka Norman <rekanorman@chromium.org>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, chrome-platform@lists.linux.dev,
        linux-media@vger.kernel.org,
        "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: [2/2] media: platform: cros-ec: Add Taranza to the match table
Date:   Thu,  5 Oct 2023 09:38:41 +0800
Message-ID: <KL1PR01MB380965F8A7FA341F880FDDD5AECAA@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005093804.1.I63e353b5d722f212d2979e0b9af36f08680898a7@changeid>
References: <20231005093804.1.I63e353b5d722f212d2979e0b9af36f08680898a7@changeid>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [OlXrM0zHkW+iNs8YVfZIB6ynSsIox29L]
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To KL1PR01MB3809.apcprd01.prod.exchangelabs.com (2603:1096:820:41::14)
X-Microsoft-Original-Message-ID: <20231005093804.2.I5912ce53092f181456e09b300ce85da35db305ac@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB3809:EE_|SG2PR01MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d014cd-5b97-4142-cb2a-08dbc544206a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGC0JIILtLOf3wOhYRNwoMEl+IAvboxffRZkpe1uzJmb/3A/hxOyLPAixfRWGlb5FlA78DB4uwx5QJc8+LKAqKje42X1lbeU5z4qvrZxuY8Hr+lolqEgCO1YKLXlnOs+WxFi8QtaZV+G64HYWfmWWvIUD+P/NzlbQXxnc0JbOpZcgOT8aefBZpf7aZLt+0+Tm+MW8iwIwxMC1LI4X+mcdDZ7iwb2o2RHCSooq3kzrV1RindbChpFVT74V1GgO9eBAeZ7gh+qkQ+X1UvgxSjrgmpdU8ygzEj7Q7J2u9iHo7CFdc28YV+KuKL2/ik9apy46TnRpXdSU5qEvU69B4gXdAfJ3Ur9/rnedk4f4zaOpCTPcdNF9vGb6ySfj7ae1bFJFBohX3oQxwRNdN1SHodTI2qOjrBDox+qTmYlO/LcA8Taz2DH9M7Tssam8Qe5GLm/KsymzHj8YgKogJJPW4LRj4uw0/xJt7ENbm5YkSfps40H67hmSeUt8TW0aocQXU1OsjCuWA/yYlobeKwKgCMBrnC1Ph51SvgTcEAiVsPWFIHkze9NtCYSQwTnz9+Bo2WI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1CAfg0852f8JEzY6mgzxUOg/Oumk/VrS+KHQFhH1v5GMKSXIAWyIbHqbrx1?=
 =?us-ascii?Q?XlrLkCCr1SRFLeY9eONbaob9ASkkfevnZBlagMjhwNVJ0cCuW96VLp1kCnWW?=
 =?us-ascii?Q?eL/7UkWw++8VUXefnPAQq26CGAoo9OEHMmocIdCf5bM2mJZFCb1lkezoE7K4?=
 =?us-ascii?Q?01bnQK3emKk+zRFijfU7LLzPiaVJI4EF2j620vL3NYGxTNxvbl404OdMw+6e?=
 =?us-ascii?Q?zLdHcMElNiFZS9jtf+4HM1eHmeBazxpahpqrRTNZKetBBJr6SXA3mv8ioqtS?=
 =?us-ascii?Q?tNzOkcCNh49vrxtDnpDuq49MkEp2WTpH9GXxJ+6SMeWxogGS8mMjWu7lgg2n?=
 =?us-ascii?Q?o5rJXgAJuiV7XYXfUgxxApqQ3tuGb0aNcBD7F0FycCzSIhotlqH5hRGclhpZ?=
 =?us-ascii?Q?auNqT0Kr7RbWxwzhoLFRm8313XZlYLyUF06D0fXAYRepp4+JMyX5uNzc98g5?=
 =?us-ascii?Q?us0YkueSoD1xwlW3GNQVBb2CK/Jrn1JEv58tNkC2sTU4t/9ex704vKG5TPsv?=
 =?us-ascii?Q?ndo2F6rBauwUnGeHnolu2TYfeybtTAY3cfpABS8szkG22ACoIOat3HWL+s1K?=
 =?us-ascii?Q?EugdTDywJkchEasYnqN2+tXOeI4YYTgiUVkYKSVtkIXTcG7GWvXW1Ur2nthL?=
 =?us-ascii?Q?KuTdTcyZhmAvKkxEFTL5skxqKM0LTB7XX0dnnQ8LMTxfeH8GgYcfH7/SZ0ZF?=
 =?us-ascii?Q?NCK67bVm6mb7eQiEdkUReTu7xY9fFxbFKnH1XVjRZgNKsOAvSfFZm4TtbGtH?=
 =?us-ascii?Q?aQ3kBLvxWIA38YUMYp1pt+W4CzrjrpHdAVGJgY0vMVlkJ79lteqwoSmyDqpT?=
 =?us-ascii?Q?qB49lxwRb5/SjcZrWbV0NFtVQjR2fBg/VMjFgqPRXm0r6z7XLNnVS0Nhdpu8?=
 =?us-ascii?Q?EX41HB/tj6hrqLo6hrmZbbqjofwD9YxybTukQHiR9l+wcfZOXgaHtjcAc7Ih?=
 =?us-ascii?Q?abLHRqioAug9xtTxctDJnfIcFK03FhQlj1tCMFO5WzujCHm92BQKsURgx2tn?=
 =?us-ascii?Q?6uLNsNMpDULPTHwEdVfRzFmYtWHiwSzZtiQIQ6pDqHbF4kVOYdvhqSCgD0eK?=
 =?us-ascii?Q?jHKTDvApwUyZB24pcxPds35caRW8sCmnowFawFABdbz9lXR6XZbvv4YfT3Ie?=
 =?us-ascii?Q?vBnbozs1eZejCD8O/yqYK+BdyK89UGRaC4WazolP+JOGgS8ZOry3kxA+iPdt?=
 =?us-ascii?Q?4IC7du1YriJf9Ka7h7M1M2EiZy+gQJJa66CGnw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d014cd-5b97-4142-cb2a-08dbc544206a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB3809.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 01:41:00.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4592
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taranza has two HDMI ports which support CEC:
Port D is EC port 0
Port B is EC port 1

Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
---

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index dbee25b138ff..42dde3f0dbde 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -322,6 +322,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Constitution", "0000:00:02.0", port_ba_conns },
 	/* Google Boxy */
 	{ "Google", "Boxy", "0000:00:02.0", port_d_conns },
+	/* Google Taranza */
+	{ "Google", "Taranza", "0000:00:02.0", port_db_conns },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.25.1

