Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606097F33E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUQhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjKUQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:37:17 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2061.outbound.protection.outlook.com [40.92.50.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F8E8;
        Tue, 21 Nov 2023 08:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTbkYYc+jTazXMmU7f16V17v8gXn02AQFedAVrfa8cd+WcFx5Y3KcHEPCcOyuSUR8z2YD52b2IIfMwEmmwm1iQ3+gL/a7X4pkXp9FRZXfY8cOUKrAviY5XyIMdBSaYrrq6zzkctaU1ckgEYPTwejvzPFyg6GbaMkuIktP5fiibbaXjUKsZt5nWEgerJQdiT4V6n9y//QYss58ed/W0bESfSQaomtGrvBAlq5QWUwTa9okLj8CJqcQenmpx/Yl4OOKINYmXCKfkj6O40Yr2nb9b6Yl25EOJ9GJ9xn9BXrqA8vGssci1Xtxf7d0n3Csrw/Bo6WWcKV1xA2snvxpGSxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9WexPYSxUUFbOsoLFpA5Agpr4GDWgHhnjckeuX3K0E=;
 b=F9k2tcwk0afzNkVdDNgE8qWd/2Xe3ORCLRyLr60eQ9KTQ5gH7pYj3yvV1Ru+p9saodYiQtRAmU0smNYSCJYDHuxiyHsCDu24Ul+ZgsqLtI2EACEliYOdJu1cdAxjiH3NIMNB86Erp0reL83uk0CXFYYPJYKXdghGv1utEmwE4LnPjrEDFE9e0IE4TlSjwVfoG8GhajwzrgFURzZmfugS371ABeypctBtRKdeJ7xlX2gM3eY96BzyKiNLVhkShdRKbcbn6BjvFhuc4zx9ISvqszL/pDaUlYLgNhez+Cu826cil7k/rtLH/KQ4NhqbebUSZ2EUFec161uqdceadbS7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9WexPYSxUUFbOsoLFpA5Agpr4GDWgHhnjckeuX3K0E=;
 b=n6xK9tfeDD0ZNjsMLvykhS2QWUp1MwpnxuIza6/YhcfE2k90Ovbld3V5D6Uh6OPwajD6kX5ESsdZ9CQY/oI2C2Z7UHvTYUh9fV9b78VMTh4RUd1AEM6ioq/y6QbyOMCzsEf/X2ROedqmLShk5yzVDlA2AW8i2v8xMcnSHRC7YJ/1+ek37zUdIq2Es3LepsqEGTG1iEddHDeDBWBe3W8OyRLeoofc0YVz+On/ofGBsorqkDjT2m/kC0YAvBQtwfEQgysi0KzEJKY2N3/PE2vgqg6k1/YHpCDR9y/2Kw243E+oPOQiuoeOQlQy6x3JJJh6eg0Ss5WWUVn3rpQEd3H2TQ==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by PAVPR10MB7356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 16:37:10 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 16:37:10 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org
Subject: [PATCH] Bluetooth: Add documentation to exported functions in lib
Date:   Tue, 21 Nov 2023 22:06:36 +0530
Message-ID: <GV1PR10MB6563B895FB2E3677DB984302E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FIzFFNt56uB3I3w9v7tqfLN0hH+ykClk]
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID: <20231121163636.450087-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|PAVPR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b530bb9-189c-424a-ca96-08dbeab01b4d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hH8fv60eUjKgGJWZnTJL1OF/WfsdNChwMnuC831Tl7RT8JrgriCXadaNWqjcaDl32HpZFeto9rRZ7+JKWn8st2Dw5n9lv0ed+xXgF4SrrDRITH3agpBAvDo2d9ebAXI9omxvLrId3q1IDGNlRUdtY9/ghEpqfOmgW2NG5QlP1VlUBeGAVqP6Yz7fp0qK2IEveIUiAsMf5UtTWFUI7rac0GgOIhdApc84opsDyuErPlxKQCA2jiJ0/ArVCgBO+OqScWnNIJ/iJgQ8TV4CQk/st/BjbjyXWrBElTN9/7mLlPE4sDvrtmYZPtJd/XPDTf2Qp8GzDPmoebuVzgN+sMft5rmDg3nojhkxWvR8Erty8wus+eG4DM215+tG0/hhaOM1CjpC6+gY3VlmgpQSjairmprVWgfsGiOsbWqIQV2fhLP7n4qeAWPPM/VlMEjIltsuFW+ZE0dbygHvteDssLrTtAAyhTz5QAvHvBfuw+ZGX/Rof6nT3dAY+5O0OURs7iX9VhoCPa3aIDkkIgnX0PtpZOwpgxdqWc2pegup/361WMR55ytu8O32d7IH/KPsc1J4DNRql21HDJw66p1wSa+GwcOjEHuVEbn8EMdh+byb4C8Lq4+TaQJ06bvRBKQTNkvJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jqB3lAXwYy69K1qlamxsIoGjQEmraHvi3DT2nrpbazbY+tZrU7SaY54uxRG?=
 =?us-ascii?Q?tRMSFWPQKtwNddOkvtWtiZosieQjwWMhgg9DKmIYIwUaqluNkSJR8o2cGeg4?=
 =?us-ascii?Q?VhbOSZrONXQdE05greSbNaLOVTmO9jCv8LYSrNARibmd29lwVKI9VWQ4amCs?=
 =?us-ascii?Q?RtBIAwN/FHenSng8yAVrFedtyLrEfJM7L17/99CHoGL5nbczdTAtz5O2yavB?=
 =?us-ascii?Q?WhcPMe1IUWR+km+JfVJt1HHv91/njXaFxngc5nel4boZrDktPwAhLJvJsOoS?=
 =?us-ascii?Q?XTArZ77CkQtrVo8auVCJIA6FmM5Bo0woBCi5bkzp9Ede682EX1E430vPOF7q?=
 =?us-ascii?Q?5nVBrnCjmANu5OJf5s90zwhFRAe/+bg/BUK1qpozMzCMvDWrW46IOS1eUNGB?=
 =?us-ascii?Q?hO+s74qZQcaE7JEBRY7PAGmjnQDIerk2wyn4KkjUvkDv1jjaABVPeL110UlP?=
 =?us-ascii?Q?FzdJk4pKr/CvJVs1CFkOVBUUSF3ptHfE7jlMmxqK94//xxNGKthAjZePQT0P?=
 =?us-ascii?Q?glMptcPB6iao0ST/7MaWo8Z9r2oaLv6SyQl6rChCsyHcrki6oiXGMXmvxwzt?=
 =?us-ascii?Q?TyCBValS1FtKJ9YlawkbU27MtJe5KpZOveWoKOHo1zlIypv2m89mcUlHtEkg?=
 =?us-ascii?Q?p6tDqJ1/ST5eEMNn80f/miQ9Qvkczm8UUq4K8yLNZQvzzD3QyHr68qY6cPvG?=
 =?us-ascii?Q?hzMt1GMrmzvv7Pr10/qtyDdQhR11P4LsbXqvp4XWxY/OrXbLd9Ia6gLjBWHi?=
 =?us-ascii?Q?p2L45kx+iiUkw0sMh946nbCJS/lvWw/oNRz0OJ2/hNyhEyY0odRPaXYVG4YU?=
 =?us-ascii?Q?6kW+VYVZ8oxK13wnnCS1RGxZMdJgcbvTtdnwrq8CRDsK+lpGrnOylptnaMVh?=
 =?us-ascii?Q?TgxgsokT27XbbsBtoKrdTp7mCsPtzHCEuOq2o+XXASf8ijxN3U0Je7Tf2rIp?=
 =?us-ascii?Q?g36mFWB7US5rYTIJg1JnfkTA0e397JiRaM2JyljB73oGqGMvOFnaMSznRppy?=
 =?us-ascii?Q?1VOwbAR5u6SZ5TrODLNb87l3EeKwYQmyodvfw+Ocwsix99xCHKTiUMWQAeu0?=
 =?us-ascii?Q?3yO1nsMBVe/6mX0TzFOi7P0HRcOhlPTsu+e8aT2YyM4mF04ZFPoZN9z73Fqv?=
 =?us-ascii?Q?18OwVOwjU4zIZndASojOHVJFxYkyKPbueahVr2x821pI2eTXuwTXaLaDzw9F?=
 =?us-ascii?Q?ZF2g/yjyJMa2aWHjlQu193Tljq31fT2aTuepl6Kjt+pii7invBqj9/DNDaA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b530bb9-189c-424a-ca96-08dbeab01b4d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 16:37:10.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7356
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
index 53a796ac078c..43aa01fd07b9 100644
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

