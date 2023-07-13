Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83129751AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjGMIJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjGMIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF9826A8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR/pIVKefn7jb/P06AXduzDw/Y+UmKz1GRsj7+gdjfnFMYiYGqixUqh7hWXFcqKCdbg7lHGtprcD+DUO484HQJzFFKUeDjG0Ws/oOlKP6myKiISKEoCbE65L3GT1r4uCt33r/J0QOTQco/WfMNGoxt47gQYk6UOVN2ZFinsjInutgg5ORgnpGfwvsE6MMhjn6fohCEa+v8qOtbkg7oJKkWVK9vo4UVGGKhcC6Lz1Rm/JbfxEK+h3ZHalDVC0tpas2H7lhVtxon9+tCeMMMbxspF3RZiyJOy5fW0vizKhM6KcmxmUaqNChSo4wAQrVj0QMm+D4FSlM2HhMQoFionlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2TR6jjfrnTKXG8rqXHCY8zDYGLiP/Tfop+sHJg3n8o=;
 b=Fr4fi4m+e5LKsxo4pVjOyOGH7PzXSPgPh6N61VoPbBJVQG7R+srMBdaG2v8mLel5JpTg+O+NVqpuLNREAxldSaA271zeio3cvhJ2EGGN2aANY4yAPEd2YYmDvMJSwZgD19janP6sPKTam6z+wrDW20hBEZiX8CAsXLlU+wLwdK3wL9cAxVOcJankCU7Hm7NW0OZYKVpIhaEcyFD5rpfV/jV2qM37Y/wrhs/cS/G/ONdTjngUsvPpNm18YUsjvGk95hARcS3sXx63yv2C8on4dJHDk6jBCSFzaJioBCsqP4kN1vrtphwgsvyVEOON6APwV1BYIje4xrxQipu/b0/+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2TR6jjfrnTKXG8rqXHCY8zDYGLiP/Tfop+sHJg3n8o=;
 b=JPLU9BjiGR2nuGD1URv2efvb0OYx+KLMyKGe81Hb6w1WJ7NWg3Xkl5GT+7fQqwO2d+mkGT69ge91UAWCTKvH1iD03V4Si1zZE//9sskOt/lupppaIMdrT+Ybz6RfuAZgWkp6EXmRscOALAnxWtbS7nbbFARlKTbdTJX7lFiDuib2xJJMqeikR+Y7OqvubEL6MBLVX4Be29EptheTq1Uak9cIDIknzDNRtF/cRmssF25ZJMBUdmBqA8hq8FMG0k7FqlmzyeTJq6SicINfJbzL+zUYh/lQu2x9EuszOYZIEAKTrab74I72aTZnucShKheHCFtXNLtztLrqTlOuJwf3sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PSAPR06MB4135.apcprd06.prod.outlook.com (2603:1096:301:34::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 08:07:06 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:07:06 +0000
From:   Wang Ming <machel@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2]  android: Remove error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 16:06:37 +0800
Message-Id: <20230713080649.1893-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PSAPR06MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a50af9-7137-4d18-ab61-08db837825ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMCh6MHW/UYqaU1f+YI4FbitMiCmVRw+GfwYubxBAb8+hfZJTHn9oPUDp3BsCzX0DfWstxmvgMSQ9sSzsDiHkAZbdKoCncWkSL66AgZMQzvSfbwKK1fzD+WokfA2F99vCqoj/622bAGrjWkjojGGAINlrwOf04/9YB/9bVzx0aEtec5jFlXJM25DtXsbv/FoMQqnIiFzSJX+a1+bijvSCVIB2JV8iixgZSiq0OqRSv2xuzKW6fSPSQqVXn6E7I+2TTjtenWooBv3H+6tk//cpU9TIPx7bBIrEhw+X7wXFR9kVB62JISwzRjczymnaGxnELedXIxYsNgeWBDhNkFZ2m7AGK5PpF/RIudf/AioOyS3rMMXRR3g/O286wqQ5Yj4u1L9bFgPh15+wMFywO034PD2oK1dQwslRgwz1EQbuhDN0dOgdDxMLb5m9Qg/qz/iblg7t3J4Kj+48MS1JmYFOr/M60hpfwr/ynNR40nwuGXfZSZf/dY/fTwfcTVC8zlm1ZwRmaqc+LscesLBV4NiNiZ3G2Qbnb0rjDLuec9yF788OnuwXnrlr+jwJlARk7cIjW56Z1dx2IE64yZJfiE1odtsNnRNXUw1QSn/KD+AsaNKpxJcEXlXPoPC0yLf5u+C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(451199021)(478600001)(66946007)(110136005)(4326008)(2906002)(5660300002)(316002)(41300700001)(8676002)(6666004)(8936002)(66556008)(66476007)(6512007)(107886003)(6486002)(26005)(6506007)(1076003)(52116002)(38350700002)(38100700002)(186003)(83380400001)(2616005)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9oPJoaW0F5bNU/GAwlKX/U3j2T+KPA6oD/gxprToa8VmwCHVefR14AT3BJX3?=
 =?us-ascii?Q?lnUqKbMz04Vaw94MuLSAadrmGS/1n6c7hy75VWPgylnJS0UQmDFw947bBPDZ?=
 =?us-ascii?Q?wIxcCdAv5fMT/m8PvWQrUBUFJpkRgwOoIBrpr24E40ZR3mwNzhhkrKWgUI+0?=
 =?us-ascii?Q?YYDLeNsXPhZ/dSYbbGm2xn6RIXGlBESQNa2CF96ikE+NbBBa85lavQOT+A31?=
 =?us-ascii?Q?fVTSjdtslRrJbqAQf4gNRrAA2bwy1UsGzU0SM4JLe5I2j7v+bZXjlLCMj0nm?=
 =?us-ascii?Q?JiDCjFlKS+2h/IW7No0OokaPOT0BmtQkQkXG6iQuWTNNlW7kTukU4ECjIYyJ?=
 =?us-ascii?Q?v4LueLnXVps1gIJLy8P1b/HQsac/oTfBwa5H3UWC5AZdlqx0IAaWRgZIb2sq?=
 =?us-ascii?Q?9Nuc6+swfGTT+d1m/7yIFdaJaf7o6xOLEFbsnvFmD7hig4YrqokGYlt3+iUs?=
 =?us-ascii?Q?egp475HiN0ggWwBDfMq8tD2QCqXNzl7HlpDHl2SnxG66pb4TBlls3nfciGXA?=
 =?us-ascii?Q?pLQvwpX+rGk2s3i7Pf58aBnh2lYxVvDsv4bnGXaWnCR7r+zYxNbkEtnQRuiK?=
 =?us-ascii?Q?QcsQbdT3RPBF+Iz9AKP8SYqJltEvSfpPGxT7jX4HZLppE+Kp+RwIB3HQjS3m?=
 =?us-ascii?Q?0XVsjZbdRg7sm/uq4kMWLJt9Tlsaa9JdcgghO3O2J9rQZoiqarCvCZcxGH+x?=
 =?us-ascii?Q?olvjo76tUhHdj0F29wx44DuxtLDHO6xYxcUFydTq2v1Tv5EAiJH5UhvhxePC?=
 =?us-ascii?Q?nyXy1smNNSBORsdFSShkWNtrKnndMAa9a3jYNKF4pMqoMXFmTXJSiVbcWPbb?=
 =?us-ascii?Q?brVEjwI6up2u6DwO30qehZPUFl9t3vpxOvED0Xccn4mNk1/kWJyHTOKw0ElZ?=
 =?us-ascii?Q?K/AgLODw552l+vhQCIpmrzlfPoyEmYo4wzgESWwKJpU7wyWvUbV0mRyvkfKV?=
 =?us-ascii?Q?iM5Buhn6D8Xny8/4IsXWsSiXl4lj85PUHmi7ENAq3Cv6utuHwrZQWWRT4FQg?=
 =?us-ascii?Q?PaEuT/GIO1wWWsBGDJljVq7YyA3frcJ94TAn27Hq/w8wSOLehMBCcUAFwtAk?=
 =?us-ascii?Q?7s0Ks1Sxz4UVhv2cMGy8OTLOUeV9fVkXrm0+4wns1YPreubo24kKwOc1D5ZW?=
 =?us-ascii?Q?zxFHGWypcifWDzPtluLxRJXjROrmC+r5xnW/Oydwe9FbtGxv8SYfUS6LZrOB?=
 =?us-ascii?Q?3iADcLkPo1r8ScNoOCVk0ZdruKOItirssEggIC70kFUqhs8nIU6lvMvvihLG?=
 =?us-ascii?Q?TwyrDrWiYtXECgRQkFxeaRXz3ynSzR16dutVfLKs8cR+fZZhqnnLXQy2xGWt?=
 =?us-ascii?Q?HhS3g1DzRibTFmh6FwW/xdenPiSZU4OHubQLCz7ZNULiwqtGJNbUSadCS6uZ?=
 =?us-ascii?Q?UBlP8bjPEEXBycU+Oe0/BYSE5fhmH/J1WZ67mW0ofx4voW8uEULJ2OWOVOk0?=
 =?us-ascii?Q?smfzUPrQBwOkF+eo3Ggy5MYGiE1uP9vWNsDiQgzBRZ+nb4CWhqArvvBydNkf?=
 =?us-ascii?Q?+m+OGErTTTiTnxmDRjvz/z/0bZLp3OHNcDlWHYZoondF09u1SlFMXCnxhime?=
 =?us-ascii?Q?8Wxvy+vUxnXutcOKEQ7lIh+7edz+IPoV74ajtfiI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a50af9-7137-4d18-ab61-08db837825ab
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:07:06.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jScl8Fq0aja0SCkLxXW0f8iJ0x817M/r1sCmgIGsk+35JmHCfdvFJk9TlHCU4uSebKCpbBK77dIlHdMra9/f2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in binder_init().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/android/binder.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 486c8271cab7..49d84a6c4594 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6557,6 +6557,7 @@ static int __init binder_init(void)
 	struct binder_device *device;
 	struct hlist_node *tmp;
 	char *device_names = NULL;
+	const struct binder_debugfs_entry *db_entry;
 
 	ret = binder_alloc_shrinker_init();
 	if (ret)
@@ -6566,19 +6567,16 @@ static int __init binder_init(void)
 	atomic_set(&binder_transaction_log_failed.cur, ~0U);
 
 	binder_debugfs_dir_entry_root = debugfs_create_dir("binder", NULL);
-	if (binder_debugfs_dir_entry_root) {
-		const struct binder_debugfs_entry *db_entry;
 
-		binder_for_each_debugfs_entry(db_entry)
-			debugfs_create_file(db_entry->name,
-					    db_entry->mode,
-					    binder_debugfs_dir_entry_root,
-					    db_entry->data,
-					    db_entry->fops);
+	binder_for_each_debugfs_entry(db_entry)
+		debugfs_create_file(db_entry->name,
+					db_entry->mode,
+					binder_debugfs_dir_entry_root,
+					db_entry->data,
+					db_entry->fops);
 
-		binder_debugfs_dir_entry_proc = debugfs_create_dir("proc",
-						 binder_debugfs_dir_entry_root);
-	}
+	binder_debugfs_dir_entry_proc = debugfs_create_dir("proc",
+						binder_debugfs_dir_entry_root);
 
 	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
 	    strcmp(binder_devices_param, "") != 0) {
-- 
2.25.1

