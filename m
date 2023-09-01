Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF378F9FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbjIAIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjIAIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:34:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2105.outbound.protection.outlook.com [40.92.98.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC30E49;
        Fri,  1 Sep 2023 01:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdbKmTVvNn09S43yrY807h5l/wNPX835vpPEJXVAqDugjY2wWMgge1aJRduAVhF+E8GRr2Pbz76wxMvSkkpyyiIulLn+sO1Dd83Xj6nyY2bbGnIT4JZ/8iTV1uwIua2RyQ/rt1TTxZaKwkXKd/HfOpPWGrZqKJMdRhKkTCk56qhDZitymH04eRqRpkYBI9CFeNXqXJXacuJmRve4qPP8lWsRMvP9DuRc4kqm7DWQFsGz2jBmJ4PVJ1hspD9wjs2CDQsSpiJdY5YLhX9ytpu5MRlQnyfGRdc038PJ+MbWoz/C++o6x4KLoabTvlW8DK40/FyR5OhjRMFqZDtu3KtARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1maS6Ie4blYrsUMWoXT0H9fmf9lpQ9Tur2lK0t5dStA=;
 b=e8NXR1HEuAlLQgCUv3wWaIKp2009l3dQR6slhsm3pFUOSD8S52bT57jAiEXyf0rRpOZy1TquKV+OqtpN916mOzkC78tz/KgWHmR4GcaB0QjPMKAsUVzkpXLeUiUGQGV4PVfw0jq27O3yseSbLG9TveqLvHoKTypJ/caD87K64Y38UXNWnjFkjsnyhWSfD50rgg7eRmV0XSzWE/ajjaFUzrY8PL2LhX9+7y3Gt0ni+BGe50fyEcNCXTG7L7vX01AvzmYzqCtrIOiBP37wT5AA5qN+skEMYeDUQRO1WGmw6GZn2xEBOYSYAWtQlG/Gtbe8512ZRijZclS3alflRY915g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1maS6Ie4blYrsUMWoXT0H9fmf9lpQ9Tur2lK0t5dStA=;
 b=cpRnHVFFjQpVi5zo1YwgvIggpQFYZqVjTawSct+ZhTRNyjDVEHEGcAY9fUl4f/7pEDE+RthvFLkiTdBxGDGr40DNeqIjTdQ6EsvoAT/Xvz0F32D6AkdeUjxZfPbcOAAmR4wm1SyTEbrltSOcIiYbRj/vliBs7G0V5d7TGalLDyLxYZGx+tuWj4XJAeXz+/4doKuNIrB5HYcw82sfkY1tp/jEnw1ko/38OG3DuHGJ1rhpimYvUlqciVzgnAHSVY0jPHatbxDVt1AZ5xxg9gl/DRwiRE9wCYJIFMxUgYZzRRERcEl06C0mqXEaE3AA75kntjD1TtUSZAEw6L3qs8n5NQ==
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::11)
 by TY3P286MB2548.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.16; Fri, 1 Sep
 2023 08:34:07 +0000
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce]) by TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce%4]) with mapi id 15.20.6768.016; Fri, 1 Sep 2023
 08:34:06 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergeantsagara@protonmail.com, Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v3] HID: i2c-hid: use print_hex_dump_debug to print report descriptor
Date:   Fri,  1 Sep 2023 16:33:56 +0800
Message-ID: <TYCP286MB26078CEC570EA9055D86D82DB1E4A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87bketu33z.fsf@protonmail.com>
References: <87bketu33z.fsf@protonmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JyIlt+0tQ3FtwKYnUJW6I6m1nq2zxbUl]
X-ClientProxiedBy: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:242::11)
X-Microsoft-Original-Message-ID: <20230901083356.626091-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2607:EE_|TY3P286MB2548:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e3074d-ad27-4700-b68b-08dbaac63483
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvdwPFuioOloAifuu7WL7uFjOjM7EICPFP/HAQzLY3qJlUdoDki6/4ZUaQ56TVsnDTpBxbVWxJa9l2K16Ios1IAjirjDUKQ+DTqQyxB0oG3UPvZRXA0KZPdx3VIQC7Auz91L+Kk5G3X+4sl7D2rNoo9Tim2YqSpqn7bkmDbRBALhxlhGAo/tYqzhpgbJeKduE7oYc/P7nR6L8+bkKz5nkQo2MDIMbevPfHVKdKtX8u3Sb6gsK0O2OOV+/QiRTeT09hkoF6EzicgEl1KxYVXuyOgafbZgUoyzJt2e6mxROufKtnEsloVG6tIsEEGI/sisSKpNMVoYOXsdw5vPK+i4lrTu33VSV3wrU/ymyYJlyrk2ey04MYvdZilQ25KfTdrJ06lmYxdr/TaVrIo0e1hj2H5vhKJhCdKQu8cElunX8GKtnntPd+uqIEPJiKcwBOcJi9tr0j2XEIwiXUDBkwLgK0O1iBVOVgszulAB3AaImo0iJMUeLr2nIDVdhGQITkXT6ornx/+3HWg1q1LdObqj5/SfbIFX9o9+AEJ2uyFPCNWCiP1sdTmcp4BvDsbQj9Fv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s3JYLtEjEBYen9AwnjTCBYS8bfkj+Qj2u4d2765UKIfy+tZyl+D9xY7D79Dt?=
 =?us-ascii?Q?jsXDzgjVgljPeCQ+AFIvkxbOAxjykLvLX7HB4f2CJcJd3OHx7h8QvW6feEkn?=
 =?us-ascii?Q?P+3sNQu9Jjnh8a6gZMFfU07xUVuYy8gsbsBu/oER8b8999DJZuCJFZ4s/VDP?=
 =?us-ascii?Q?xkbFO4tIP4mor/SW9gSWo0kC9wLvOkjX0RoUS6N5atk8ucoxpVYThyt/UpF3?=
 =?us-ascii?Q?J6BvHzpHvg2LeEfDdyD/2hHR3bAd3iWTqug2HsQe8zAUpVCuToRkb5NLoQS6?=
 =?us-ascii?Q?PMPQ6WkAE5l7nPirpwkDSC9icz5xR1DDW844yaptbGwA2gc4pQWAiS/FnyM5?=
 =?us-ascii?Q?Bv0U6BQmm8cjSgIx1uhUaqtaqhb8Cu7s1LTA1F2P4nvKOYo0m8+rFmDhBfS7?=
 =?us-ascii?Q?JVSI1DMnS8RH9q6k5TpWdZe9pUg4JiLBQlIDfY4+LEMNt3b12Cfr0rn9INEn?=
 =?us-ascii?Q?L1jo6+4EmIIIRNg1vcPqn+OS6MTUW12WBeQ8qqNisG/44Lb1fSuuqiVo1uqI?=
 =?us-ascii?Q?ShurE4HcG9K4eOz+ejFl+qVwYIezK3w7ovJ7RA5kbS//Xt9jZfuagoRtsf8H?=
 =?us-ascii?Q?faZdxSKng4sxWTM25dU0W8BVdfhBUHBM/YYJqp+O5lrSKR1LKnh3joaDfa0r?=
 =?us-ascii?Q?up9C8cHIFZZPzMn1+STKmKtrXZlbBJS01YfJUWsqHxttdxJn3buCDoRGnmbw?=
 =?us-ascii?Q?sGPIUkdbHj5juxAWAbG5v44HeCToxljbi+mc5CvdVFk8/OYI5Kc2cTbHqGS7?=
 =?us-ascii?Q?e/1LURS3SwNaNO19X4xbiIEq3fMjfvf/wuCaX3r/o32p6Os6Yn46rq/L3PpE?=
 =?us-ascii?Q?YBM8QtaVxwPWFcNlIFHf4DCjPbvm74TogmgB4TmOvSaGw4oGqJaj9iBVxxMo?=
 =?us-ascii?Q?mGF1+tIHk2JFMs6e42sW1FrA641FHkq8b9nGWD35BIaNJ7H4TbMBTsnlLrU+?=
 =?us-ascii?Q?6dCExmONv+rPRl1g83tVqUpiwtubusiCtVlA4dfAVN4o87vZDlsStmNdMPOq?=
 =?us-ascii?Q?i68+LHEVAA9yde9YwuConHtFHFuq3uoBN61esHafqz4pSp/wx5RBMN0Aho3d?=
 =?us-ascii?Q?cGsP2vM3LoqtKEG2UkWaCjM/sd6uX6xTPIi1LnQ1V8ajC7NkoJ2oYQp8a9Qe?=
 =?us-ascii?Q?IwPTOXZPrSgFfq1rcP6/sX2xxCrWSh6Oq/hGmaFKQWEzj3ARiABrrafoDLoe?=
 =?us-ascii?Q?3E6xzTGJQxSPOUJqLcvMCpHwHUiSSverJRM++Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e3074d-ad27-4700-b68b-08dbaac63483
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:34:06.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

The format '%*ph' prints up to 64 bytes long as a hex string with ' '
separator. Usually the size of report descriptor is larger than 64
bytes, so consider using print_hex_dump_debug to print out all of it for
better debugging.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1->v2:
 - Add a prefix for the hex dump.

v2->v3:
 - Print the size of report descriptor.
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index efbba0465eef..dd69abdd1f0d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
 		}
 	}
 
-	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
+	i2c_hid_dbg(ihid, "Report Descriptor size: %#x\n", rsize);
+	print_hex_dump_debug("Report Descriptor: ", DUMP_PREFIX_OFFSET, 16, 1,
+			rdesc, rsize, false);
 
 	ret = hid_parse_report(hid, rdesc, rsize);
 	if (!use_override)
-- 
2.25.1

