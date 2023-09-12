Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA8F79C81B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjILHV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjILHV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:21:56 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azolkn19013052.outbound.protection.outlook.com [52.103.10.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92300E78;
        Tue, 12 Sep 2023 00:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6U/v+sZMPC9Ik6lQ0bbfPLOknRPqwkFiLNXU11ANZ+QSz8bp4VHZqCXjFw0YjpUhfzJZ4Y+zq028eHIX8/MutdDqFcYRQntRs8q4YzJqZAjC8joVRu44RW7XXl/W+EM/u3PamxT7IgOy0GwgZtyt0oayVbWVPldw/Nd+55lvPYQU0GRZ/Y4EGcLHkjAmvZPoaJ3a0LmN+BW6N3rUj9Kv1xusn1jrYeFAUJUJrJs36GoJ25siIA345/zA7GIF8cVaGaJ8ThR7hmjEJ0aXzhnBMYGMt2AUhImLwkR9WIrnkJ+NSsZ//PCYS1IPflVieGHVy5uVCxZIZfhwe0CeQ0vEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSt9M3Lx9ELnykLY4hPhekC2XnMJZbCE7nsKpZmTlww=;
 b=GGUZ4H/zW+BFq3AabenzXZ09MXu1fCtFeNeAHa46yp9IxwcOLK42G3wIPDEpkebRYmi2Wtn9oktk+d1DHusLbqxFHFLJ6CKMTVzJc3vpjXsJf1hjEtGbJIc2Fnc5fCRCmUIqLtRYYq17lZc6FrPN2/TYfafB/0Mon6PmjhRX6WfXOsnC0iFHsNUbPrQt+cvqPmaKj4nNYu7hlYGRvbHlQfGdwr7dUY4AmndnFM1gVFfYBHUQ6EtN0PyvQEKtK+D+WMsRpez1fXPCwBzoE2JR0nI9nxl7dfv8rjC995UTIPYsnjco/9T2vbak1sAT0S/d3y5dAWjv3GRdgJGMJaY9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSt9M3Lx9ELnykLY4hPhekC2XnMJZbCE7nsKpZmTlww=;
 b=R1TrxI/uDRc1GHFj2a+jWdu00+bnAoooQaAJxxsOziJMkCbK2E2cohHf5Sahuf/BJr/wn5Oh2BDWBzg5Cg8hSfLEHQFebYG5gKUROoBH4XgK3kQEWNQOPQMewfZMLe3SKfVggKPWM2M7EU2BDhH/8xGcfrM1WZRufnBFbhxy4Y5vHDQOYo77ROVI8KBxg2ybdTa+kLjjWb27MssvaF21Wwif1JLo5EixmUk7Fqg0ATcCc0tZ9eZV9EJ0arCzd1kNzmkQFroDnesagZ8XILw0dBHHJ42L+Q/y4iDk5eJwI2qNNvAmQcOwP/TT1KHyRRCzV2zTFKO2UyaBDAYxkRC1qw==
Received: from CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
 by SJ0PR05MB7627.namprd05.prod.outlook.com (2603:10b6:a03:2c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 07:21:50 +0000
Received: from CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f]) by CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f%3]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 07:21:50 +0000
Message-ID: <CY8PR05MB9378060FDF6C7E15589EB668CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
Date:   Tue, 12 Sep 2023 15:20:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: [PATCH V2] xfs: use roundup_pow_of_two instead of ffs during
 xlog_find_tail
Content-Language: en-US
From:   Wang Jianchao <jianchwa@outlook.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
In-Reply-To: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [ykzJC+USfiPsvAzHzYzPGWj4xCtOW11n1lKnDNepfd4=]
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To CY8PR05MB9378.namprd05.prod.outlook.com
 (2603:10b6:930:91::8)
X-Microsoft-Original-Message-ID: <59dd15dd-5b35-871d-6d3a-ec779975b089@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR05MB9378:EE_|SJ0PR05MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fae2753-c7be-477c-6bc3-08dbb360ee95
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVCkk9f5Abex0COt34DBZJ29if8Tks1nEb5ZROJxPP2qShrmEc49+Ey0FNztJoskXWCVVfChH9XU3RhrElDhRbNIHYtcRN+eN1fCPLBeSBmGr3qUu9noM8ivumjWGIXDZkojUZWvasjqNFxrGhYSNjDaOqgFnlJb3wnnZnlxq0RK3nCcFdaCfwZY28UjMg84Q/uudZLMk18R/jtR7jNaNFhxYB0BdHKiULh0VkL2wufYwfRncL3y3cgv+gaZegqDMEUcFX4UNGV+wL/sq+66MykDkJZPrYqczIpThvEzqaYLhMFTUaSQ0CuZRH/EJwd/AQ/2n93SXZBxsX5K1xY2Emqt0IWXgcarJd5WkOhnXukfbxREcn68PyUSnGZ/vueBYn6aT41Io7e8HsLOm4a3/xYTNFCQ5AWBF8y+/w9p8t2F46szMNgjucvue62YLDEC6uEnWYuakgLKcaGP9TI4eiPHAbRRlKsvVot8v+qdPVy98/ukTG9k8hcOZy4NqiOQNbG9dP+keHzjeXqVT6rbCKXdYKogVP+mABIS7XmF/pCUoAlpJEEAAhHgQxJiGLTr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5hdWdlb2dOenJ6c2JMTCt5U3h2NmNkT3Q2blY4blZJTU45UDhPdXRqclR1?=
 =?utf-8?B?VHBQeHBRWEEwU1NxdnoxWityMVBLdDg0bWU5ak85aGF6UlQ3Yk1UblNNaXQr?=
 =?utf-8?B?SnhPbjFkVUgzenZRaVhCV0I0OHI1Ynh1T2h5V3dkbTV3WGJocXFXaWN3UU1N?=
 =?utf-8?B?eXpkY0lvbFo4ajJtL3MxR1dZZWkySTZaY1pxQWFyWkd3WU45RnhWRGYxK0Z2?=
 =?utf-8?B?U0I0SG1kUllCZlk3QmYzR05tRWxLTTBuVStOMm5OTFV0V0wzcmxTWGFTSCs4?=
 =?utf-8?B?bFQ0a25rTnE4MnJlZHJYTkN0NFJxMDhPc200Z0hjazhLeXVGeEs3NHpFSjdL?=
 =?utf-8?B?MEhpQU1rTDJsZjVoSXRPcitqUFM1TDFtSmExcUdSa1FGeDFIK2NsaDZubUxq?=
 =?utf-8?B?bkRSWS9HOEsyYzh5VGQwblRocHdmM1dzb0FPZExqalF4cEVmblVDNmRaS2ZQ?=
 =?utf-8?B?VVBGUFY1UXNpckZaYkpxaXlrbU1uMVBNSzMxVU5XWEc3cndLa0tDRVVjY0Iy?=
 =?utf-8?B?ZUFhcHRTT0NsYSthc0xMOEQzc3JjZGMydDdNWUlFNldFYUR4OG81bURwb2cw?=
 =?utf-8?B?R29DYkJuSTcranRaaTBsQkZMOHNZMTl0dnAwam5sbm5xdStVV1RFQjZsY2pB?=
 =?utf-8?B?K2Z1QkI5aVNYK0tKK3RMSGNyY3lyaWg2VFpVWGozQno5VFUyVDRBUDkxdXNu?=
 =?utf-8?B?ajVDUjNNT2hCaG1lTmhTc3V3Q2ZRbHhUM3hWVElqL2dtaUZ6WFU1UEtEZ3RB?=
 =?utf-8?B?ZGdrazFuZFNSNlFhVDBqZk5kMWh5OEl5SWxiT0dESTY5aU94bzJFVHRPdnNH?=
 =?utf-8?B?QUs4akx2MmZ4dUxicHVaL25TQ1ZzRUdVVFNCSHhlWXhpblBpUGY5N0NMSU9B?=
 =?utf-8?B?TVJHeFZkcHZoOUljMmUrQWMyWWN0djkwYVQxVWNQbkN4R0lTeWxwblo3Q1pO?=
 =?utf-8?B?NXZqdFB5d1lpeDFwZHp5R1FDeDFOeGJWWlpBeWoyNkVnVjM4cTYyTURqZk5O?=
 =?utf-8?B?NzlCU3hFRnltT0RHNFhyV0pmMVpXWm9HU1YxejhySHhOTXM5ZTdnWWl1K3Zu?=
 =?utf-8?B?VWR0QU5POGZuWS9Xc3NYUHlkSXRmOFRqeDgxbTg2ZGs0RmtqU1U4eVdFY2la?=
 =?utf-8?B?Tnd3cnRsS2pqN1RDUi8zZzE1NUlORHJ4cUc5Mklsc3hyRnBaS0hwWS92cC9r?=
 =?utf-8?B?ZWxlYVNHRXZBTVVrQlNydFU2UlM1VGZDTzEycmlqTndNdE5VbHJkWFpid1pX?=
 =?utf-8?B?SFQrVWF6Vy90U1JtbFJYbk1QQnB2VFVGS2taNE56dkEyRm8zZC9iOUxOTm1j?=
 =?utf-8?B?dHRiM1BLUUU4MEhOUno0UkpLVi8xSWd6RkkxRVNnNE42MVZ3S2VXUVh0ZUJL?=
 =?utf-8?B?UFRreU5Gcnc4ZHp6WGNydE0wUUR1dHU0RUxPSGk0ZHFEeTU5ZFpRU0tpdWVU?=
 =?utf-8?B?bmtrNnFrYW1tblFUZDdNUDJqeUd0RlFpWmwwajN1MkIxTmxjQWdHd0JJQkN1?=
 =?utf-8?B?YXBDUURkMjdKMDVjaFJZbWpnMEFnTVpwY3ZBL2M4QzhMcVIzZ2xuc2gwOGhw?=
 =?utf-8?B?MGt6ck9Rak1Wbnk3TzM2QzB2SWZ5OXE3U0liOUNnREZWOXYwRGFCK0Qxd0RV?=
 =?utf-8?Q?oLP/+acK4pN6/fKMHkLfvxhBPQkhgKZnbeS4vjKtHcyU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fae2753-c7be-477c-6bc3-08dbb360ee95
X-MS-Exchange-CrossTenant-AuthSource: CY8PR05MB9378.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:21:50.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7627
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In our production environment, we find that mounting a 500M /boot
which is umount cleanly needs ~6s. One cause is that ffs() is
used by xlog_write_log_records() to decide the buffer size. It
can cause a lot of small IO easily when xlog_clear_stale_blocks()
needs to wrap around the end of log area and log head block is
not power of two. Things are similar in xlog_find_verify_cycle().

The code is able to handed bigger buffer very well, we can use
roundup_pow_of_two() to replace ffs() directly to avoid small
and sychronous IOs.

Changes in V1:
 - Also replace the ffs in xlog_find_verify_cycle()

Signed-off-by: Wang Jianchao <wangjc136@midea.com>
---

 fs/xfs/xfs_log_recover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 82c81d20459d..13b94d2e605b 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -329,7 +329,7 @@ xlog_find_verify_cycle(
 	 * try a smaller size.  We need to be able to read at least
 	 * a log sector, or we're out of luck.
 	 */
-	bufblks = 1 << ffs(nbblks);
+	bufblks = roundup_pow_of_two(nbblks);
 	while (bufblks > log->l_logBBsize)
 		bufblks >>= 1;
 	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
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
