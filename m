Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2231079C7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjILHSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjILHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:18:23 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azolkn19013056.outbound.protection.outlook.com [52.103.10.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BDCE7C;
        Tue, 12 Sep 2023 00:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLGEHFlFZF0enWDp2yYSfcXvHYcXFIZo2VL2PIauu+Ha2qd1IVxgTCCK+t0ML/WZYbsg16vfdUaLc/Urzn3rNp7YVwl9HnFwdeLDqVcVe1bM9wQfHd25M1FI/W/xNpmHYgMuMFGuTFUeM1WxeEcTKR9QFSYo623ILvaseD9pSEq+yUZOF0ixiZ0Nk7qX5LVBCFT+kyKycPTgHZflXvZDrhfjaoKNRqGgcPwvDUhAbw7k7SH/OWQH4VcyGrZpgr8LBd9QiWCXr19kZostn1xpMjvw0euaHumF4MHn+JhxyxCTmMiRKaW5R4818HrRZO5D7/D+CFYHNuFxndl6d8H6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ItRPzXojkkEcqUoRKeRKP8L9I2/s5zA8Yuho5oqrIw=;
 b=Qijagane9AQ66wy+d8689t0dRe3R5fCXfBw+6OsGOeXcrOa8x3F6y/MzVA1nU+oGQL1RpbeSB9a9gPayv+bgiDG5dOUhmVykEYmbp72u1zXahejBDcjdP8ud3cbZRtHtx/V24PHGLNfr20kkrNSQ2RI+nPGNavXfadLq+uF7DByOEpj20UPV+lLRsWaeamRJyeeyQJYSXXLwWagK36nWpHyik8wMH1ILcaQE1PAQQiOwIp/qdTGvmSLaCnkeZsmNZDiPBb5GtI7CDGqxF++lZvk5I4flkceQvm4/fmD7Ygt2SK8vvWRaCZ2bUxxUe4jjawOJVYpyXUUTxvGStLqv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ItRPzXojkkEcqUoRKeRKP8L9I2/s5zA8Yuho5oqrIw=;
 b=oNK6kB0zOyacptgFgIcZrHf0McnOTWRgPQE8vcuuEoSZuKiLoQra7y5camWVYl6UllaGrJeMLcLQjvf+0HGrbRlSEFxgRC9H+Ky846Pd1EaDbLUniAjGl27i4ex3FEAZxSMK+syLH66B21tQTwIlF3ARSV2cSSd00qA/j/7NNfKiCXoOmh9zHK3ms/BSvRuBomewzccElRY9+ROelAeNiPJ99X9w8EaedsKUbNqw3yozWGkzvZnCWHI/6JZGJo+mZWi4JYb29RigLh/isKvXbvazYLzGsPIOeiAhCHd7wtIK4BeqN10BCdJawYSCN/mqBP1GzVdb68AHWYfbRebJZA==
Received: from CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
 by SJ0PR05MB7627.namprd05.prod.outlook.com (2603:10b6:a03:2c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 07:18:17 +0000
Received: from CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f]) by CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f%3]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 07:18:17 +0000
Message-ID: <CY8PR05MB9378BECD112419B7F0AB5173CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
Date:   Tue, 12 Sep 2023 15:17:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: PATCH] xfs: use roundup_pow_of_two in xlog_write_log_records
From:   Wang Jianchao <jianchwa@outlook.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY8PR05MB93787EA896549E9F08766754CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CY8PR05MB93787EA896549E9F08766754CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [zwQQ3Qui0BT7bihV66my79Wng/90Bv9A2WXu8U4WWFA=]
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
X-Microsoft-Original-Message-ID: <062b406f-8584-187c-c190-0a8ea6fb6b54@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR05MB9378:EE_|SJ0PR05MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 7911ae81-816e-4439-1658-08dbb3606f68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GdxMnI8vnzDLTp24IIF+W6KNa65AHGUQ9JSsJj/N0FjTf6ZPoOdf7ibjLrp2iDjdUKOXdYdERfdr08ZtdoT8lKwUCaHvBrySzvX1n2jepF+7k1EF2XEaohBCCtFhuWuHnm6BHwe9x+p43ZAE7h4Dq5RRsS18CrvfomhHlJZRGzbkQTTN7pSljRG8KrBqbZlnRU+vRoxUAKI67RjRYkg5sS9lNm+IxL9I92oX1ZA2bBXAe0T+js4Zym5+1X5BYt0fCo5AiuNJP4dPG5ccdjcZeT5YCXbTgdsIL+nB5ZCVWMVeXXWBm9vybWQ+Zkx2uk0UISfMcKvzciD4LtbCOHDXVilvsF/0I9bIBxyxhkdEA2GIPiWpGlKjkkZqTA7AaG5yq+O8IyPi5FIRbd7y63DCJg/1bobkfwCM1X4SK3cq7AdJvUIm6KP3XOexVObII3fwlnSQ1B9l+sFronExHtbI9gTCvF3vp5SioRyRKhkqHqnYYZ2LEY/bZr+c3BSunluvACqCdzQb7Mpu600SssTNARF8fYqSJeD67R79tScWic1JYUMYy7MKvg1h7rzwN79
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUIwakRiR2JUN053TDBjR3FUcGpQSVd5Syt1K2g1NFFFemtwMk5ZWDdiSGxj?=
 =?utf-8?B?TkQyQ3JRZnN6M3NUUDlhRERTZzI5amlhazNHLzJQMDM1cWtWZ1pJMHVVbXpw?=
 =?utf-8?B?ak5lYXhSWkZWd2Y3M1VZK2hlMzhIZFlzWWl1SXduTjJxMDBDVDIxbGYvZFNL?=
 =?utf-8?B?NEdZR29HWnZOV1lPT2xKVUptaXhBcXhxZ3RITjQ0YWxvM0FJZHlLdGRaR1RI?=
 =?utf-8?B?MEVtNWhMeXNRSDV0YXowaUs1a0tJV2xRbUd2QmNyMkxOeFczVTVyUHR1bHE2?=
 =?utf-8?B?Yk00RVFWOU1iZ3FCQTV1Y2JscmZNMU9lT1hYOWFWZXVCZVFqbWVIc1R5Nnoz?=
 =?utf-8?B?UFNlTkVFMzFkUVFIQ3o1dTR5MjRQZ3V4L21hSVdRZVlMUWJ0cEpyaGpJaUFI?=
 =?utf-8?B?eVFsb2xsbXFmY3V0aFB5Q2MwTmkvVEtBcTdDTzdFWUZEQzdBU0V2YldlQmV1?=
 =?utf-8?B?elgyeS9sQWRHVjZwWG9Rcm9GY1pqcmUrWkZ1dTF3YUZLUFF1R0M1a21JTUt4?=
 =?utf-8?B?M01RMHZjTUhBcE9aUlhYRk4zSTZkNkJubUYyR24xRDh2cUEwSTQ4ano5SDJG?=
 =?utf-8?B?RkdmZ0dDa095aDRrY05kU01JUndubEIyeVU3TUw2cnQ0Y3NTc29vbFFSc1Zj?=
 =?utf-8?B?MEhMYzRNQmRlcmp0R2tzbDRqNnhsREx1N0tIRlppeFVaWXJlQTEyT3lxMURU?=
 =?utf-8?B?ZXRFYWM1dGcxT1lOYTVNMTdORmNhVElWODlyQkFRSHJPdWlWSStVV1VzZE4x?=
 =?utf-8?B?UXlFNkN1ZGR6Vy85ZkRpenhzRHJSZWY0K1JndkdaNUNYb2NmMERzQkhqcDlE?=
 =?utf-8?B?THRkRVU2VWE3OUswWktZQkJ5M2RDcmNMUWwrZU10SlZUM25NWDJBdnE4aFpr?=
 =?utf-8?B?Z0tLWWxPR0srZ1RXN3JralBXekNZTmtpTW1uWFhpVHhaaE0ya0NVRlJ1WjJ0?=
 =?utf-8?B?MFMrdXZBdDE4aWNWR1NpU3lvRVJUTWR3aHZsSVNTNytCR1BmOEFCUHJja081?=
 =?utf-8?B?M2dyZjMzVSsxU3RsRlM2WFk5NE1TUlNmdFpQcmgwaVNqeFc4WUk4VUxwOHow?=
 =?utf-8?B?c0VzdHc3Vmhzd2svNFN3UW45MkN3cUV2N3V5LzRNcG9seVJJb2JVVFA0Z2Nj?=
 =?utf-8?B?MGZEeEFnU3JSQVFxOExZcUFnODhyVWdpckNWMmhNTWZUdlgvaEdtWE5CdTBh?=
 =?utf-8?B?aVVaR1NJUlZjQWlHM1hKTzZ5bVE4NDhxWlF5eUpiU2lWRGNNY1ZoQS9DVE9v?=
 =?utf-8?B?ZTQ3a1ZyL09uYm05cGsvL3U3U09QQkRlWk43RjVxUEVxbmNCOWR4OVhXb0d1?=
 =?utf-8?B?clkxLzdOTmJ2allUNGVDVEFoOVZMZ3MzQVI4aG9CalIvT29kQ3VwRmFWT1JL?=
 =?utf-8?B?bk00QUpQdThXM2x5RWV6alljb1lSbkQ0ZlYzaFVQaDNxcUFReWw2ZHcrSTVo?=
 =?utf-8?B?ejJVLzQ2emNXUktYQjBNa2V3UVVOYUk2K3BRdDA0c1k1WGQyRnhUckdXYllo?=
 =?utf-8?B?NTJCM0JGMDFFUVJRNjZZNFZvdkExWlY1elBXRU81K2hJMHRPV0wvY1YzTlRQ?=
 =?utf-8?B?ajlYTlI4N3NLT09WYy81bSthOHBPS0FIUEl6UFJyUzhTV0pGUjA3Um5RS0tE?=
 =?utf-8?Q?QBmF16aLa63Vn2YZC/lrjiUOs+IFPdTKhR2itU0xgT0c=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7911ae81-816e-4439-1658-08dbb3606f68
X-MS-Exchange-CrossTenant-AuthSource: CY8PR05MB9378.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:18:17.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7627
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xlog_find_verify_cycle() has similar issue.
It will be covered in new version patch.

On 2023/9/12 14:17, Wang Jianchao wrote:
> 
> In our production environment, we find that mounting a 500M and
> clean /boot needs ~6 seconds sometimes. The one cause is that
> xlog_write_log_records() uses ffs to decide the buffer size. It
> can cause a lot of small IO easily when xlog_clear_stale_blocks()
> needs to wrap around the end of log area and log head block is
> not power of two. As xlog_write_log_records() has handled bigger
> buffer very well, we can use roundup_pow_of_two instead of ffs to
> decide buffer size.
> 
> Signed-off-by: Wang Jianchao <jianchwa@outlook.com>
> ---
>  fs/xfs/xfs_log_recover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index 82c81d20459d..9368fefe1d0a 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -1528,7 +1528,7 @@ xlog_write_log_records(
>  	 * a smaller size.  We need to be able to write at least a
>  	 * log sector, or we're out of luck.
>  	 */
> -	bufblks = 1 << ffs(blocks);
> +	bufblks = roundup_pow_of_two(blocks);
>  	while (bufblks > log->l_logBBsize)
>  		bufblks >>= 1;
>  	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
