Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC67A5739
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjISCHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISCHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:07:17 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19011021.outbound.protection.outlook.com [52.103.10.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA410A;
        Mon, 18 Sep 2023 19:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX6De9w/x/fesX6uJmwxTEYDhc1kGAZhLsoYM0EJdRslT6NeIbytOleDTaRhxKcpPKLmlOSiTaRAM2ZY2MwpyAbtPggCxtkG9K2A9oe/9/9fX7IIkvxBPGe5/Dgot4Ss6jSJjL+ayGIKeCWrmJsse/nmpmaVfnYQRLVaRY2Hxj/ONyb3fsQk0H/ipwLABlZcPvkWM5I0YMmGWGzI5IM5K6B64e2TUjkjoEi2MNbRNbvTmywvRZujj8mSLr1GZCuC2OlQxYAnNQwPBmOM843UaRMy/p2jVbkVfDFAoMJHUB0IVRze7/ejzDPFmZnSk9zLCw5rFydvx4hDRELtwPYkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v79i9jye1eztT/Iy/ZWYMuOxEbkivNMH7MSfBxLJE7E=;
 b=gMzaBLQx2VlgBlOqlgzLgHsip7r8IVAmaJFOiAqaq/mZLJiJOVuigLtszjCNNtMxOiUIhEGWDhqWjVsNW4KnsCo5bTXgHfKLFNrj1iM44ZwvI0jI5uPL4S4hmVZhCLg3iCH400N1RWw8/3mNBFj2MGl1W/JbCpMbg+n61Bh7R+gggqkpifkLXwDQCmpPep+aNjbKczQ17MnlhNPmcP7kCJ5/6NDXLfUuZcJd8gZ0TJavhGq64NP/zq8SyhI0Dop3kht2/6iu1PLL571/Zxcyyv+48HKA2X9tSMim9MXXbyZ/+/0Tj/Xax10/Hha6sd2Keo9NBfjbzr9TieVYGvmePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v79i9jye1eztT/Iy/ZWYMuOxEbkivNMH7MSfBxLJE7E=;
 b=enoBzMDxtpKR/khHhw3T2HdoOoJ3NqT7mNnWMk6g44N784kRzTl/fpJOt4Pl0GPnS0yG3JXXVIMyrdRoOwAXsykq6+PzfQCVDJb1t9FiKpoZ9+Zjd+TtwwUCuTLzl8vzJzMVtY2AXyyWhYqJJolU4B2NOnrnhHKK7GP72Y6pWDk6q5HftXQtqQRK4OcO48ixeHVPxqBeRn1HfeUXdhedGhRCpkh6BDtv8WpcwROYNeEe2Vw94QDp/o8VRyBhsXBujva7qIeRghxwOHP4uii0k3Q4dGpZtLjODZrHGhs7qBNkGFhWE055EbEWE1QPYdA3sti2YIMuNQTyRrUr6XzWCg==
Received: from CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
 by BL3PR05MB9163.namprd05.prod.outlook.com (2603:10b6:208:3ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 02:07:07 +0000
Received: from CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f]) by CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 02:07:07 +0000
Message-ID: <CY8PR05MB9378441D3F6430D1A414142BCDFAA@CY8PR05MB9378.namprd05.prod.outlook.com>
Date:   Tue, 19 Sep 2023 10:06:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] xfs: use roundup_pow_of_two instead of ffs during
 xlog_find_tail
From:   Wang Jianchao <jianchwa@outlook.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
 <59dd15dd-5b35-871d-6d3a-ec779975b089@outlook.com>
 <0a72f462-8b8e-4dec-6ce4-f52e33423957@outlook.com>
Content-Language: en-US
In-Reply-To: <0a72f462-8b8e-4dec-6ce4-f52e33423957@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [uUYrLKjOFzPLVv5e1hsAs0cpMAq/tGBMgmTJEBhC/so=]
X-ClientProxiedBy: TYCP286CA0269.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::20) To CY8PR05MB9378.namprd05.prod.outlook.com
 (2603:10b6:930:91::8)
X-Microsoft-Original-Message-ID: <fc54707d-a888-2687-9d2c-475d689c1e87@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR05MB9378:EE_|BL3PR05MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c374b7d-faed-4d3c-7913-08dbb8b52013
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMXZEzIPu/M/KbFzjrFOo8pfYFT9eIP/77Nl/2IW9pe+bpOHBSVrpYlpE25ohhSC9tzQBDR7TEsb0VU7A/4VyyOkLE5P/CZuwKyVlidmI78QS/PRytg8gDcL4J2QbBCKv8f76uJijHMKRTIjizTy7Oq5DzMgdq1bAk4+KO9OkbtaVB89p8T42L5e3iX2GnHJpgS9rnZ0swE3QAOkCM/+DNaj+1CyrzV2UtY1WaFvsDU58Orf9O6ZLy+XHYTiRz7xYXpg6UEXLDyKZUKVHkhrDAKC3z6Z0TDkvmlwdDxQu5YXje2tVX2jNo0wWlwNImg8rf4mLgclOfyfwDRn4sOYM8QMx8RTBb5CSQ/nHOYbw4Jko59eCr2tH3oAF7F9D19ZPeTT2MqQb4Ii1vJXHHj73vAMIGOmJMSX50/JzVlvY0EnZQfgz604J1Jxvr6xEjujNe47MfAqTeDFGLZU7ZvE5Y1lHGtAKu8M/5eazFIH+GVDlcpAEISBr2VqxSgTaAlhGyp2v+vI8wsNumYm+mJAig/Z3jZf3KciV7voBE/pgQFSJdX7YcFHTxoebnjUxLe5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmU1U1c1b3E5QmtLS2VCYXBPbkJ2OWZGT3NERzlYNlk2OTQwRDhtOCtwOGRk?=
 =?utf-8?B?U0NCdjN0RG1JaUkzK3VMcS9SZllrN0ZwaTZqSWpNQ25SQnhkcENrNFpYU1Nj?=
 =?utf-8?B?ZHNwVHcyWDVMYzZNbW5ZNjk5M0RtREllTnhYTm8ybFdqaUNVL2xZc00wQkoz?=
 =?utf-8?B?ZWd1MFJqL2o1L1kyWmF1YlRFVmRoaHRINnlQK2w4eFRHR09JZ0xCbFNzUCs5?=
 =?utf-8?B?UmIvVGRLbGJzeVJ5RjNBZmpmMkJWV0t2UXpnSkZDRlptL1RpenU4R0g2R3F5?=
 =?utf-8?B?ZEkwZUVjY1J4SDZRQnRxUVJ6ai9PN1FyWWRaT3I5WUF3c3ZBTUozUE5hcEJN?=
 =?utf-8?B?MUNpa1ZFbjZQQ01UUldMd2JsT21UejU2dTYycFExczZzQXVpMDNnQlF5YUJz?=
 =?utf-8?B?bHFVTC9qb3ZUT3NpUitKVk5oZkV4R3E0YTdtemZaOGZmMTQ5ZGRSdUNqemRt?=
 =?utf-8?B?OVh1dHBLRTFpeXZ4eDhoMW1LdmRZRHFlWFJ5dEVpNys2alRUcWlsWFF3UnJa?=
 =?utf-8?B?Q1A1cXZsU0FVWWxidUZrdmNWSXllSXk2ejYxazB3eFlxU0Z6YmtpeVdnRFc4?=
 =?utf-8?B?WFZuZXVaZmhpcVVOR05YK20wTE9kTk8zOHlQd01COENVcGRNUW9Wc1FPVklH?=
 =?utf-8?B?bklJOFJxdGw3NHRONGFlV3hCcEVQMUs2ZDRYbjlwUG92WDBWajlyb1I3NmdE?=
 =?utf-8?B?MEJBcEpMQnJRZVBwcW5TTWR5amVISFpydEM4RSs1YTdpL1RRQXNmS0docEtn?=
 =?utf-8?B?ODJYdGJyUXBQaFJMQUlxOTdlaWdVMGVVc1I0elVQM1dtRmU5cHVTMGVuWEMv?=
 =?utf-8?B?aHA1Y05HQ2Nqb3o3dmtNRzhjVFhyc2JYZTdTRWR5S24xRndXMlJpeU11OWxq?=
 =?utf-8?B?bGRYV3grN3g0dXJ2ZWJkWXhpcy9ZYkt3di9LQzZ0M3lXNHBXbzJjWERNNjVa?=
 =?utf-8?B?NlhnM3cvckhHVmZyUjMwOUdjVG9SWkprYXE1ME8vT244M0xkVmQrRGNGZWpo?=
 =?utf-8?B?aDhTd29aMFc3ZUlYVHhJc3FjZEFVb1BSdWNIOWpTWmtMOFluNHFRenVPSG9t?=
 =?utf-8?B?bEFZbkRZeXIzVlFKZVV3SlRDSTQ0WThBbmd4ZEY2aXZaVnJwWks0MDFzSkVw?=
 =?utf-8?B?Mkl3UWpYSnE1dTcyYVYvdnhlTXhMRWs5MzZab0dOMk1CMWxIZnJjS0RXME93?=
 =?utf-8?B?UWRDeEhKN2hZYkJuQVlqVXA3czF2QnptallHTGVGcnZIbGZoZkFqSkwvZE0z?=
 =?utf-8?B?SjZFdUtRQVc4bVVYb2pqTmVMR280SUV0Z2hiRmR1R3FrTWxGT2V2cnNaVmtI?=
 =?utf-8?B?WDlnQlRQYlhEVUhJT0p3cnR3N1diRVhwOVVCR01oT1ArR0k0SFNEcjdydnRQ?=
 =?utf-8?B?K1RqK2xxWU9YTjVvQ0k2Y01oRm13Qm5EZ0ptek42aU56WTM1SzhIckUxMGY1?=
 =?utf-8?B?bER4aXFnc1UwQlh6R1pjeFIrTTJTUys4ZFlRd0ZEMEpOcWN2aXFGNW1HRGgr?=
 =?utf-8?B?Q25CZDJRZThpMzBZWDFtK005MUo1M2xGdWtpaDdlUExJQkZZVG1kRi9CUHV5?=
 =?utf-8?B?VnZnZzRUUE5BRlFYWjZ4Vml3VlcxZVlZRU5tZXNXdWh5T2Y3dnJha2R0b1JI?=
 =?utf-8?Q?tM5sQoKdujQp+sVrZTwCPLfNMt85U7t1oObXwLgCGRvM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c374b7d-faed-4d3c-7913-08dbb8b52013
X-MS-Exchange-CrossTenant-AuthSource: CY8PR05MB9378.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 02:07:07.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR05MB9163
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping ? Do I need other update on this patch ?

Thanks
Jianchao

On 2023/9/13 09:38, Wang Jianchao wrote:
> 
> In our production environment, we find that mounting a 500M /boot
> which is umount cleanly needs ~6s. One cause is that ffs() is
> used by xlog_write_log_records() to decide the buffer size. It
> can cause a lot of small IO easily when xlog_clear_stale_blocks()
> needs to wrap around the end of log area and log head block is
> not power of two. Things are similar in xlog_find_verify_cycle().
> 
> The code is able to handed bigger buffer very well, we can use
> roundup_pow_of_two() to replace ffs() directly to avoid small
> and sychronous IOs.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Wang Jianchao <wangjc136@midea.com>
> ---
> 
> Changes in V2:
>  - Move change log below "---"
>  - Add reviewed-by Dave Chinner tag
> 
> Changes in V1:
>  - Also replace the ffs in xlog_find_verify_cycle()
> 
>  fs/xfs/xfs_log_recover.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index 82c81d20459d..13b94d2e605b 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -329,7 +329,7 @@ xlog_find_verify_cycle(
>  	 * try a smaller size.  We need to be able to read at least
>  	 * a log sector, or we're out of luck.
>  	 */
> -	bufblks = 1 << ffs(nbblks);
> +	bufblks = roundup_pow_of_two(nbblks);
>  	while (bufblks > log->l_logBBsize)
>  		bufblks >>= 1;
>  	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
> @@ -1528,7 +1528,7 @@ xlog_write_log_records(
>  	 * a smaller size.  We need to be able to write at least a
>  	 * log sector, or we're out of luck.
>  	 */
> -	bufblks = 1 << ffs(blocks);
> +	bufblks = roundup_pow_of_two(blocks);
>  	while (bufblks > log->l_logBBsize)
>  		bufblks >>= 1;
>  	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
