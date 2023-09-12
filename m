Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A216C79C6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjILGSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjILGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:18:11 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19012039.outbound.protection.outlook.com [52.103.7.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182D10C4;
        Mon, 11 Sep 2023 23:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpJw3uEnh1YXRZTD2w/bjvbKyS2aB+IfZdtmDWuPK/NIhKX14nlVlUrtXgJyu580gbZOZ98XQTJVqxKixqljS64DgeWqqEo/SE4VcErY+qMhc9Nw5kO5c7E9i9+Iriutd2E3NB4Pb1kE6PuPMPVDuKwGMaMiidAPLCh/4VvGjAQweNkkKC2sLMCgdu358v0fTwVvxdHg/krbsLb6IESAT2R/mtIEuqnpNbKV94iclb4MIiaVcEOeW8uoj2zn19mDUA7bKTKgtkp56QqovCtPMIRjDAdCGBTR+Ouv2W67iJx9Tytxi11Hwso04HrkYIRITD3JXSsfVN3CfjpUR7TlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwZflGrZFxmQM3SVCaiKp8atHQFqtJXEBZCT9wr3mFE=;
 b=nG8YIwN5Rdo6VwgUFStVqVdx+hfdLu5ESJRCn3iWAKkjdzAIe//s69JdtqeddebZ2dPydpK6BJfLpxi07Y1lDJCBAN4f6spUiubj5ZViU3O79LF6tNkzsKd/B5K8LH9ZKKJU7lOxVEY9FD7RTjYYAZjKyRfyTuWO//FREzymxza7ojg1aExc1Ekhzk8j56Hv38ujKA1ehbQwvX3fNHzSVLXsySICCkHyp7o2ObzIk6zqSckv0JG8SbNXEfzvqEjj/zxsNVLHlfG+4m+EOvFh2ecbhj1LDIE7l4WRe4COLKlAhIS8qDLxWasz7aUGh9uJ4crgxbnx/zRhltPVCRcLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwZflGrZFxmQM3SVCaiKp8atHQFqtJXEBZCT9wr3mFE=;
 b=ISpKh1hGw42o18TJR/sO4dXVhAL5VrLcpX7yaKWz7Rh8ZFWIc+w1YqmJq3SUdXB+UIU1wIFuvVtnkmX5pCW66FmrWxmmEe58hZCBv4T1uo8HNfGP1qy1PVsNoq/oBscDlge7tEywgW8wp3/KpJKEJk4uWPdJrcZInpd/ex4jW6/d/THsDWrU3GBkim/lJ6wJuGxoIEclibBHplja2x5L12uJdRj0EJ0yNWVWTbetCcFLrd1FjcoarXktrQw/rqdJgyoOz6mEBxvyVyNuoA7RyCQr+mVgXNclALIkIf3a46VbPF06/yFDf83n26cF+S/2e7e/TJImUgF9D5ASo8S/+A==
Received: from CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
 by LV3PR05MB10358.namprd05.prod.outlook.com (2603:10b6:408:1a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 12 Sep
 2023 06:18:06 +0000
Received: from CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f]) by CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f%3]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:18:06 +0000
Message-ID: <CY8PR05MB93787EA896549E9F08766754CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
Date:   Tue, 12 Sep 2023 14:17:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Wang Jianchao <jianchwa@outlook.com>
Subject: PATCH] xfs: use roundup_pow_of_two in xlog_write_log_records
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [a1amV7lHP1vY6t1B4bLnh6RNI20EqMR/]
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
X-Microsoft-Original-Message-ID: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR05MB9378:EE_|LV3PR05MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0f09f8-0cdc-4f1a-a6c0-08dbb35806c6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NqDdfbwwLUcqSZHdHuvk6O0fEYt6vsyNV3CT+UjAr0+qGpVHofu/5dpTm01bBHF5d0chaE5UbGiiJQpf3zCH3hFJ4QoSUSIXM+kC3Ft5sL1fqT0rx/qxQ98dGznmi7n/QCERlp8SvZTB/qWRLniOocByz34I0jOCz2Wrz27gPEvH9nXMiWhjjIpnNp36QywMsZFCr1Ug4SsgkgvXMNlJ6hXSqDxC+EF8XL2L/ScqyA+RNya2sfvBv54CmD3EhXE7oHqppXIH1JSK0WGO/nRCa899mnp/Rjv4JmYt0itShh3wrPbrajIo7bSFZBm3gmeFkuUlJAdhPvCHkmeG2bh3paM7ZEGgeFYDsg7P3XSpiZdTlMTDWDjCARzh7yrIsc0wHoHxOjGnF/eWTGfT5He8du+uKke7IPqdxM0NcBfwQx/5pVvblOjqJAt+cEZUTmXl8VonSHFAt9PQJYuqAmb8TefwOdacEoNacM2YMAMA8nuwAiV+cQdGhtE621txlTN3snL9yMDjnUsmjihMCQiU8fcz1UcyBhMnQN616RF60L8hEfbjszM2PGUY/JQAVx/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODlQY2ZkV0FNaGxkK0lEbngxT1B6Q1RPekxQUWxkTVJNSWtTN09najVVaFNH?=
 =?utf-8?B?SDhYQ3ZuV2F5NVo0YSt6ZU1vYzRWTEFzdmRKdFgwZC9qK2pOOU1TZ0gyb1Z1?=
 =?utf-8?B?dDZTaEY1VjMvME1RNlg3bTl1SVoweXZLNTAreHFFUEQ5Sm9tWlZEMEtUUnZO?=
 =?utf-8?B?YTBuQTN4L2FOeTdFQUlxWnhhZENKOGl3NVM3RENTb2xoSHpSNVBkVWpZaTdZ?=
 =?utf-8?B?VkpnN2FTMmZJUkhpelVRdVBodWJjQkFjcEZwRlpYMjJjVlJDT1dsVkxwOENl?=
 =?utf-8?B?aURsUzJ6M3FRNjhiVXkxa2pITmxubmlhaGpIeXFmeE5LRjVsa1B6QW4wbjBv?=
 =?utf-8?B?eTlkUlVuaFVwR2l0Q25xWWU2OWVjSVJUVFN4elBSVWplMlROaVByRWZHbTBW?=
 =?utf-8?B?VzdBaExwMS9wMUpGVVZMUlF6dUptMG5KNTk1ZmQ1anUxcDJ3OXlrcUNvUGVF?=
 =?utf-8?B?emZHS0V0cnhFZ2JtTlBUbFlsS28xM0hDVThnSDZZZzk5OFJUb21PQzJoWHBB?=
 =?utf-8?B?bXlRLy9WY3BPYmFXWWlFcHQ3WHNXS3dydHlNS00rYnk2SEpTZjRZNlJmV3dZ?=
 =?utf-8?B?UThSN3l3bWd2VDdmOUxjZ1c0MlJTM0xhQ0dhZmcyL0V3Um5HNWFoOU1McmNw?=
 =?utf-8?B?elBOelp6U2xIakVTTk14eGhZL2U1b29YMWdIaHZYMU9YTXBxWVhYdERNYXBX?=
 =?utf-8?B?RjljZU1jZzMrajN1cEh6Z3h6b1pBUEh5TXJOeG5ZVUZrREd4QXYvcG5vZ2N5?=
 =?utf-8?B?THVYb014VkNTNlFUcFY3OEt0UFdsOUkvd3E2dWZiVHg4VjVWSTlJbDcvZnVI?=
 =?utf-8?B?MkZwZ1IxUHFkOGNWVWVkbTIxbmhoaFcyZ0R5Zm8xR3ZubTVNZFNHemxmMjdL?=
 =?utf-8?B?dk05Z3BKNGNLZEs0VFB6aGYzaVB0aytvRytNVlAxb1pYSkdUVUt2TU9RVjdI?=
 =?utf-8?B?ZTlhM0tJL0ZTRXRzM2gzSlVDNDJnNUtST2ZFekZ4MDFNbHlSRDNKM0JJdFNh?=
 =?utf-8?B?L1ZnZWJNQnlnNDI0ZTlGcUo3dFZzalpwQ1hMVG9xazJIWUc4YlUvbEExT1di?=
 =?utf-8?B?U1IrZUdTTGR6NldFSCtNdmY1MUpNUHZxVzFhWDcxZTJRZmYyYjBFclVUb1N3?=
 =?utf-8?B?ekFyNkYzV1ljekpWKzdyQjg3dmhPTlhkd1lmbHkwODlvYmJaazJ1OWdGTUY4?=
 =?utf-8?B?VDR0RXFUNndhVzNGQ2l5R2RtME1zSUxZUkdjdVAxU0k1UU8zenExUENLS0c0?=
 =?utf-8?B?MDIwd243YWxPZHhpTzdOeFdhSjRUZTVkaXRrRGJuMEFIT3QyRWhudlFuUjdX?=
 =?utf-8?B?M25qTVNITWVjVVpoVU9ValNYbUhmYklMOTNkMEE5RW5iTXl1TEJIVVVNbUZt?=
 =?utf-8?B?SERsTkl4SXNTWnlwRlNzcHZKdFJZQXBQbXk5WWdnZlhoVXFaOTJ4UFdadGtX?=
 =?utf-8?B?YmN6TTZUdkpSZnJXbndoejBudldHa211Yk8yMGo2RkloblVsZnJFTjYyU25n?=
 =?utf-8?B?Qk5pR2xZSU1lTmtkQ3NXSDN0WVJheWRlRFNYUVA3V2R4WVZnRHVNczRlbkpD?=
 =?utf-8?B?QWM4NHp4YlQ2WVcxVU8vbXU4ZDVpOVMzMjN0NmJmYlVVc01lZEFOWVJ3SG5t?=
 =?utf-8?Q?bRdE9t/uM81ugyVHmvteY1pnL1eNwmPccLDZ+lA1n40M=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0f09f8-0cdc-4f1a-a6c0-08dbb35806c6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR05MB9378.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:18:05.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR05MB10358
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In our production environment, we find that mounting a 500M and
clean /boot needs ~6 seconds sometimes. The one cause is that
xlog_write_log_records() uses ffs to decide the buffer size. It
can cause a lot of small IO easily when xlog_clear_stale_blocks()
needs to wrap around the end of log area and log head block is
not power of two. As xlog_write_log_records() has handled bigger
buffer very well, we can use roundup_pow_of_two instead of ffs to
decide buffer size.

Signed-off-by: Wang Jianchao <jianchwa@outlook.com>
---
 fs/xfs/xfs_log_recover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 82c81d20459d..9368fefe1d0a 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1528,7 +1528,7 @@ xlog_write_log_records(
 	 * a smaller size.  We need to be able to write at least a
 	 * log sector, or we're out of luck.
 	 */
-	bufblks = 1 << ffs(blocks);
+	bufblks = roundup_pow_of_two(blocks);
 	while (bufblks > log->l_logBBsize)
 		bufblks >>= 1;
 	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
-- 
2.34.1
