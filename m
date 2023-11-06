Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA27E2FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKFWYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFWYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:24:47 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2024.outbound.protection.outlook.com [40.92.73.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704121BC;
        Mon,  6 Nov 2023 14:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6lqkapVZ9n4K9NpFBzN9vtEaCYopp/6ZredONxa2PyhNZNdqWFucRj0hpsV5tQmsv43nknZQc41Ck+Nadgkdo5zm06OEqi56Q6OIJg0X5+JRzv/NCnq1C12MVsAZWrpSQErwugPgXHRHDXwrQiuJXYgx9lDCTMU8snlxcV4dTgbR2UG+dF771qtkl9iiFiNyqVVR3aihbpIm9RyjHk+Vveq5mK4ZE72vyK4WFm1OwG5H7PNS0WFhT65CqrG2xQaIvpxdjiMOQDJDKy+gqJ1t8FQmf8+FkUzbOFggAPYUCKIQiqAf36bZdmKQQK7uTrd81q9tP384Z3dTZxr8EODXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfWyHV5ZD6rdAOuGjMtwvO4KZEEsuLhBprqVMtOFVOI=;
 b=NTSn89MexXglYXcdBYBqO0R9VqLV91c6nKuzVf3iBGU4tkm9ZMLKBbnPCSoOZoT6NV6tpAmHR2HDBnSpCLImTyt/jYkRTL1vTVzLWXgzOjHeZ+yunmbAl+xjCQVoBcUsjnyceXQNOV/h3GEqixwWvewKtIiiXbrDtZoHm9JowFn+3jGlfv9Fro3mI/fldH3+MTodwDnTKarzcjhTubr/BB2mRFcy+EgiXc0tMYccSYhjIGt+PjMSG059lmLE7s6yG0pOunIIYxEV9bIk3H91l6XN8KALHtAGlg25u/bv45tDf4H94nIy2KajVYabpZ4HjqMWDQCOHW+KXLR78AI/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfWyHV5ZD6rdAOuGjMtwvO4KZEEsuLhBprqVMtOFVOI=;
 b=mwihL7bdeyAbqUf4G2qL6IWsslg8CIoJnJ1q3HeLkkg+hBjiIGKlm+mMC9bOX6gVmprUwRCsyUX8G4kx4Zy9cIiG7fffdc8QnmRqLmvQAlI/yeB5Mwt72eJ9EjQdCGJ5sqZPY3QSEdYptfAxh8VpmoShAiwziOQZNtVmewgsOj2bFYZGaa/fBOFOPu9xb2YGd+MFeWgcSViPHyif2JScE72fbHT801ILFnvTpqzJiH+ndLYvpDqs4pMosK3HOEzUo9z/w0tac48iG1vjfRmTIHnqTm6yx1x+mwg6ZccQqvKQEWbvC0u+6RbiOfwjEagyxbeiTaKpwIEKETKoGGj+Gw==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS1PR10MB5144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 22:24:42 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:24:42 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/2] Bluetooth: Add documentation to exported functions in lib
Date:   Tue,  7 Nov 2023 03:54:18 +0530
Message-ID: <DB3PR10MB68355F5AE036ABD128F91535E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [vl4rtQFcbu+BM5+HB6vnCTEnW7K61V+9]
X-ClientProxiedBy: JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231106222419.1793747-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS1PR10MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a17e3a7-6ad9-40ce-fa7b-08dbdf172c07
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgJUawaWDiEtJskrJBFcd0bU+iPTzHicHXxdDchsM2HFz8cGuftLKKbEH42N0lP/+MSL7FGI2zT8NCv6dykLZImbifJcqU80yRH+0CH60ZkpunwtO9JfFkHBwaMsYiIO5sVH0x5bsqJScBvc8f668G37ZNGAo3Hj2QsgEvlmoTZT9fHocBk4eedMHVbaidnWnyuwVG+j0S5wgrNsKOy2up3UWI4tur/In+D1S4wWUfI6u/CFTfyEkxfUGrKNOJDIjXxYwphWctcpn7pCJccySFqXy6zY+i0hrqrndscGP/B3EyLsD12LWzuzJ4p1GWszIAV42w6bnRUJ8MVPZRBxZQ4WSv0Na0zAlZSrz8OjxX+WQJwMtfOYE5ljBHIgOXvF2WeG+HbgZhUBwELcrh7fIWcoPVVM/OCxnNc8q40xIzt2qKHuBV72evmsBr7uTjwiK7IYG20ryuUOH/Z/RzcMDIq8bDo9hGKOVtOmiCGANy0Il3lAXVxJorhSsGmJGN0YaAxiW/p73CgcLYc8H5snJIWfQ17BSvApBNYqmjjRsKu2lfeeDUlumDQLxQav8DkBMgnjKwsmSN4XNX6lfrnL20lY/zxNkOvPoqACnLWzFQkwE1IcYpq9wD6sm02oPgdv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bk0nqJBmA3W/Qhr+Od2BLoY76MENrR+kQ9CrVpLXKOlzQpyMwtWfFelcFg7v?=
 =?us-ascii?Q?Fys6ioALk5+7PsUePV+/gqkkIprZXdEeSRmV9PPPaHu19NqYd1FEwqC9ppwT?=
 =?us-ascii?Q?KNILQsBgjiY0TUrfYM1JjXjqnp7ldsY3D7qWnwH1DIwxIS3e18orrW6qu9y3?=
 =?us-ascii?Q?0y9WQzpPLk/mhlEatSyAzZ8ftFL3+JElTfHjeflO4k+W0lmRa8r0bX6xSMVS?=
 =?us-ascii?Q?oCyjgXxcpJ6NZ4PhaJb/2q0395MWAa5mxlCRsh/Gp84+6abrmKadXM/Fmreq?=
 =?us-ascii?Q?HY+kM6D+vkb7Wjsg+H11BAptnGGDGspA7YLgiPb1VWhmIBDjLO6YxuKOa9up?=
 =?us-ascii?Q?QAkODvdy6kq6m1Zw0pVTLztyd+UBcLsba4YRqSOlHLo0DZDVFz26bXVmbgyP?=
 =?us-ascii?Q?RsdiIyoTMEmQQG29anJgY4WpgB73ft2e6Re+Tag6hCrz6NLWUrV+LmIxBJrD?=
 =?us-ascii?Q?lZggzErdB9lCgv1XEBmm5TBA0xSHXJ5Aqa4TJkk0otnPtTeWWSSuGxZ/sBzX?=
 =?us-ascii?Q?rnyL7leYS0tD/9i+A2z6RqfAiTw27g1PpihspdI+AlA4ccD8JJ0T3DN+9eCo?=
 =?us-ascii?Q?/HdaBgwhv2epJXd5R79PwM/2QI0dkz+N8Ur7kmM2CtNY0rzcJWTLXpDoUlb/?=
 =?us-ascii?Q?z1ePtgHpuAuIlU2+L/+Ib8RuLAV/m2MhQHOttXgIO99zYypnsBUeeMn96H9T?=
 =?us-ascii?Q?JYBshwmLtIRx1A7fEG84qwgyO2LAh7EkDekjgfFJkifclLiE/4cNGa/nL8PQ?=
 =?us-ascii?Q?veGoBncoqF3DlVsyTUwFYiVczJz6HuGw2LEzvJ/6CwhshE+/4K5fiCH92/sN?=
 =?us-ascii?Q?BdDJY0Fv6UVHZ6bd6H336zGqM/mb/ytQ7RnP7koEgWJ8UnMq0rb7t50mhMFz?=
 =?us-ascii?Q?KcFp4I4vNODX6XhuJPmURkZAFbwht6Ffa9TFfqQiG+rB0OTNPToPqyNMQysL?=
 =?us-ascii?Q?Rr4nwoNT0m2hKMuwitf488KyMwbx6Tsl6DYA8QkpUBkxPxRnEcuVGa9nW62t?=
 =?us-ascii?Q?0A0G/2yXOzJLCoHCFJfuUKvIStq+UihfueaJ2bHkkq5DZhd44fQrSmgzl/iE?=
 =?us-ascii?Q?UziqummHmEzY51GV03qqRacIx8M4By9oRrJz4LLS7mvCrJ7vq/JNBb7/OxEP?=
 =?us-ascii?Q?xTvimQbYOU+2KwHxLIGcTCImLCfqMb5VkwQbvrn2e3YpasaQIEtJOVhKxiEG?=
 =?us-ascii?Q?Rt0P6td5KV5C8oNM9YZtYlK9nxMZ6YbtRgaxhI4F4b1nbAhoUVK1hBuDA1A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a17e3a7-6ad9-40ce-fa7b-08dbdf172c07
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:24:42.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most functions in `net/bluetooth/lib.c` lack propper
documentation.

This patch adds documentation to all exported functions
in `net/bluetooth/lib.c`.
Unnecessary or redundant comments are also removed to
ensure the file looks clean.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 net/bluetooth/lib.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 53a796ac078c..063032fe9c68 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -30,6 +30,15 @@
 
 #include <net/bluetooth/bluetooth.h>
 
+/**
+ * baswap() - Swaps the order of a bd address
+ * @dst: Pointer to a bdaddr_t struct that will store the swapped
+ * 		 bd address.
+ * @src: Pointer to the bdaddr_t struct to be swapped.
+ *
+ * This function reverses the byte order of a Bluetooth device
+ * address.
+ */
 void baswap(bdaddr_t *dst, const bdaddr_t *src)
 {
 	const unsigned char *s = (const unsigned char *)src;
@@ -41,7 +50,19 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src)
 }
 EXPORT_SYMBOL(baswap);
 
-/* Bluetooth error codes to Unix errno mapping */
+/**
+ * bt_to_errno() - Bluetooth error codes to standard errno
+ * @code: Bluetooth error code to be converted
+ *
+ * This function takes a Bluetooth error code as input and convets
+ * it to an equivalent Unix/standard errno value.
+ *
+ * Return: 
+ *
+ * If the bt error code is known, an equivalent Unix errno value
+ * is returned.
+ * If the given bt error code is not known, ENOSYS is returned.
+ */
 int bt_to_errno(__u16 code)
 {
 	switch (code) {
@@ -135,10 +156,22 @@ int bt_to_errno(__u16 code)
 }
 EXPORT_SYMBOL(bt_to_errno);
 
-/* Unix errno to Bluetooth error codes mapping */
+/**
+ * bt_status() - Standard errno value to Bluetooth error code
+ * @err: Unix/standard errno value to be converted
+ *
+ * This function converts a standard/Unix errno value to an
+ * equivalent Bluetooth error code.
+ *
+ * Return: Bluetooth error code.
+ *
+ * If the given errno is not found, 0x1f is returned by default
+ * which indicates an unspecified error.
+ * For err >= 0, no conversion is performed, and the same value
+ * is immediately returned.
+ */
 __u8 bt_status(int err)
 {
-	/* Don't convert if already positive value */
 	if (err >= 0)
 		return err;
 
@@ -206,6 +239,10 @@ __u8 bt_status(int err)
 }
 EXPORT_SYMBOL(bt_status);
 
+/**
+ * bt_info() - Log Bluetooth information message
+ * @format: Message's format string
+ */
 void bt_info(const char *format, ...)
 {
 	struct va_format vaf;
@@ -222,6 +259,10 @@ void bt_info(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_info);
 
+/**
+ * bt_warn() - Log Bluetooth warning message
+ * @format: Message's format string
+ */
 void bt_warn(const char *format, ...)
 {
 	struct va_format vaf;
@@ -238,6 +279,10 @@ void bt_warn(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_warn);
 
+/**
+ * bt_err() - Log Bluetooth error message
+ * @format: Message's format string
+ */
 void bt_err(const char *format, ...)
 {
 	struct va_format vaf;
@@ -267,6 +312,10 @@ bool bt_dbg_get(void)
 	return debug_enable;
 }
 
+/**
+ * bt_dbg() - Log Bluetooth debugging message
+ * @format: Message's format string
+ */
 void bt_dbg(const char *format, ...)
 {
 	struct va_format vaf;
@@ -287,6 +336,13 @@ void bt_dbg(const char *format, ...)
 EXPORT_SYMBOL(bt_dbg);
 #endif
 
+/**
+ * bt_warn_ratelimited() - Log rate-limited Bluetooth warning message
+ * @format: Message's format string
+ *
+ * This functions works like bt_warn, but it uses rate limiting
+ * to prevent the message from being logged too often.
+ */
 void bt_warn_ratelimited(const char *format, ...)
 {
 	struct va_format vaf;
@@ -303,6 +359,13 @@ void bt_warn_ratelimited(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_warn_ratelimited);
 
+/**
+ * bt_err_ratelimited() - Log rate-limited Bluetooth error message
+ * @format: Message's format string
+ *
+ * This functions works like bt_err, but it uses rate limiting
+ * to prevent the message from being logged too often.
+ */
 void bt_err_ratelimited(const char *format, ...)
 {
 	struct va_format vaf;
-- 
2.25.1

