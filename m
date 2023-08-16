Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0877DCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbjHPIsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243119AbjHPIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:48:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2039.outbound.protection.outlook.com [40.92.99.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B4359B;
        Wed, 16 Aug 2023 01:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACsuwz4zb3JiGPYLrMdkiTm4uHu+W6puVjbnt1WJM5zPZARBSD47U+/4bfIwuyuge2Q0kKwQEu8cHt8rDOtAX+/hIbA1JGFKANk9mjQPGMNZmjfgy5QcSK/8svWUnJD4A+0Lx5Dku+Bq10ZSDTV7PXOxTfHUDenn+oEh2oY6Yd1OVrUpBFyT6N6+vGGp1p1MR8TBM463BKZzNgDQ104FIk706aWWtj7j/2aOUidgyKnJ4Vp7jFotugiLZTIQ6OJtc5D6LSHK7WMClL7Izxb6Hdux3lJGIHyU4Uu9tmTc9pYDLoDo5lWkC7d9Xk4zh+bNh3YqU6HEKSV0zEGnQ87t/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LR9EsHbIxNGf0536/ZuM3XSSPTPgM+gsCGik20cIRQ=;
 b=Vy/qSK1yges+6yGmtopvI3wHReC/6uQGaNy8/fUia5WRAQLwrvldW63qEp0lOaVA5pYdRI6rpkiH0WOFHw3EtBsrevj0irFpHWCdhgP53+cuJPaGPSJWDbEms7j/ZQHtwstvksih3tm6DTUkQyiEaxJrRBn4zfp6uqZER1glYii3raf/sL2+aS+dL6f3xFOcA/GdUg+O9IY5YoQA7FzEeizOvmSBVK6lF4w9VurvPZh27/uCbAH6GQ+Sct1I64NMHRVDNGBTXtsfl0AKtMW600kIfo6AIEsaAqr7hdWDKKR2GrA6txAejtcbP3AFXOgdzqsyxH6oLJGSQOHPkliHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LR9EsHbIxNGf0536/ZuM3XSSPTPgM+gsCGik20cIRQ=;
 b=jAo/h9QcU451CpG4a3J08FlpKQuDvUz/RRxN7Gu3m3ChGAcnuqXyjdHmfn41e/gP/YOAbg26oFMElXFWRNTeZ7TLblRixfT1SPlV7IsR4sVmeT3Z4UxEj3Zey5UPClOVSNgtbIoI+9TAcmdf+oNuwwA9mcEmoWzfqxRyk6P8POtk5XkOzty0d/JORSiVUxvC5zPbCiz9dA7c/GpVvER5H+iVeHhBho2DJ+fxTclbZOVTTX8Yk4oIWurKhkVn63lOvXUVJ3EUpBET1iz6W1TbCaoSET/dEFsmXpp32HZb9stY9OUs6zOGGcCWp864LC7DWysuFjzggtlLqGrsEVx11w==
Received: from OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fa::8)
 by TYCP286MB1610.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:183::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 08:38:30 +0000
Received: from OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6966:de19:27ae:5c4a]) by OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6966:de19:27ae:5c4a%6]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 08:38:30 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergeantsagara@protonmail.com, Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v2] HID: i2c-hid: use print_hex_dump_debug to print report descriptor
Date:   Wed, 16 Aug 2023 16:38:19 +0800
Message-ID: <OS3P286MB259916DCE3D992135FF05F4CB115A@OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <TYCP286MB2607175E9C15DB17A2102AEAB114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2607175E9C15DB17A2102AEAB114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [HVFTEIYtjYvB0MALWX/0NjRoDf469JhN]
X-ClientProxiedBy: TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::7) To OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1fa::8)
X-Microsoft-Original-Message-ID: <20230816083819.28410-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2599:EE_|TYCP286MB1610:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c58db6-db68-46b6-420b-08db9e342b30
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1fqPwHGeq7vmSXD5/8EaXM3eikx2irrju5pVQr4SW/4nE8fdXTgVWiLi+QZYoqHyj2FEga1/sWiNkJTwB9pZAYvGQNLKXt/pwvMmew2mbyLKE9fh9gj4R8VyBCcMqJwVnnDqCD3nRTdJ8EQMqsU0wMx9IpMVRQNcwrmwyfhVNO3SszTjcZiza1CT/NQ/rmAJvJPQTJOPx7MCWC1J2/jTl9Ehwd3lWZhvlqDpZwZdZXVZJ83QBiYw8NeiMJAxKaOq8hdF9O6YQuukbSEs2jPn2/MqIxfk18rM3UtYFvLQB84h8u7fVbbDDJG9SF80MLl9NsWIbKaJha8r7rGhcPNR5ZbbTWnB0mgwbWpsLY4UpdfJXUlNqYFxtPiDNcKhdo3FTg2OKI1R+U8VR+4R9BYrD6MU6busW7dmAlDwPTn2synrCfDiKEroi1llP6ptKtaYTlKhQhybopqPQuIASut1FSnDmjnMNA+YldR3/reCFryMrr5jIrVY4k+Vox79+DCQO4XgVT29+LYCpEdW2bOTMD0Hm6Juzwzl8UpCk95Uf1TFIeTBBy17b3AFBwxBOeu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/u4tDRfoBZYleX7Fk8BFJljaxI2wM92o4GFJi6EVH5tK5dhdNgNr2lR083kO?=
 =?us-ascii?Q?JClgLIKoehN1SKi9hDgu9s9NpBQ6a/r5DSM7ESjDGU+U8aZ2ViyW99aqUYLE?=
 =?us-ascii?Q?syPgYVIjJnfhIymlkcYLtTHJCAOUv3w9RlxsPnjaZOEjeINZPPXG4qBX17fQ?=
 =?us-ascii?Q?nYK9rcoL6v5WVICJBfQa2gD/ZzuoAf46vsbZGVk5d4OeEmx9zmQzMgJkEbAl?=
 =?us-ascii?Q?vqnFjhFFOel4Z3p/vgsWQkf4F9i4uO+Hk12jRwhsndsTHSgCUuNjq4PYFosD?=
 =?us-ascii?Q?wo+vaYvSfMeRG8rSmQdbdcC1bskEHefxtv2bR7b2mz/CFNnZaZO5qMavRUFD?=
 =?us-ascii?Q?XJd09hCWBhKse3LQ6FswkwYy2g1OjPku8BDBh3WVJITcpX6/fa5jAnEpppOl?=
 =?us-ascii?Q?FPYRCxJERYkU0QQBZx5ai+e2yXXEVGta0l4UIHswqdc1xFwzEMwiFJY6ygvF?=
 =?us-ascii?Q?65Y/EvhwLEK60EMI7rHTr2MGMtpcnhCbagm7Y6PUTXlRh20wArXZurbxYID0?=
 =?us-ascii?Q?uKjHJ+Zeq4rwM/dcKIaq8oO6lUTLqvuGxE+33TlBLtdWC/ew475TMg+My23b?=
 =?us-ascii?Q?zxnTc01qRnZwwk7jez3O8q3eWMQcLJDQCuDxX0FZiS64FNrT8mQl/UlOhHsr?=
 =?us-ascii?Q?i9blO7vTUIVK/Y9ubJcnr+yTBGI6QNWc1uJARkseIOS5yVyN96cTOB/0e3/j?=
 =?us-ascii?Q?HJgMOvYaRoS6jYoP9ImdiQpGTWbP9ycilItZ8r/LNZhxPnt5vzuRiKcAPThz?=
 =?us-ascii?Q?sWM5thC4J8swmifxiPMAFA0XjwUZIFETE0Da7459pUXdt+mQFZ/D0cX9JEnU?=
 =?us-ascii?Q?Cer/M0LiMlV8i/dhCevWXnv5Tpi+39K6wXr0AfNR0ysXUN1EVEXV1lvN4Xet?=
 =?us-ascii?Q?JEuHY1KyJ1lDG4wz+AXxaPp6CJtJuxOcrT2mG9mlyUEpPQcLWVom2/bSfxhS?=
 =?us-ascii?Q?olVGYGYEXWRuf5Hr4YwJ7OQnDVJPmsz3+0aRzdh3xRvkPiuCBPRUE1VHjh57?=
 =?us-ascii?Q?T87nekDm+703VjDlWtWIDwewqL/J98HG6U7XWXFZIttYtLoXK6UUrL+XAHdB?=
 =?us-ascii?Q?qrpsHz4CitFp/QdL0DAw9QtzDehc7rYP5cEQKAIToUvRw70rziwz7azw2p2b?=
 =?us-ascii?Q?IzpQfdLkB98d1NK4TJ4ChKkz2Mb37MRxd5hqZHfnZO9a7iMA1cCZT3pDMSSU?=
 =?us-ascii?Q?a/iLOecVv9oKW9YIx8Fq+KkpyEp8oqYDR/ZEAg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c58db6-db68-46b6-420b-08db9e342b30
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2599.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 08:38:30.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

The format '%*ph' print up to 64 bytes long as a hex string with ' '
sepatator. Usually the size of report descriptor is larger than 64
bytes, so consider using print_hex_dump_debug to print out all of it for
better debugging.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1->v2:
 - Add a prefix for the hex dump.
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index efbba0465eef..fd82e9042da5 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
 		}
 	}
 
-	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
+	i2c_hid_dbg(ihid, "Report Descriptor\n");
+	print_hex_dump_debug("Report Descriptor: ", DUMP_PREFIX_OFFSET, 16, 1,
+			rdesc, rsize, false);
 
 	ret = hid_parse_report(hid, rdesc, rsize);
 	if (!use_override)
-- 
2.25.1

