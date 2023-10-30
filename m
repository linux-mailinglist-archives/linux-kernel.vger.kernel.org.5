Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA957DB233
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 04:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjJ3DMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 23:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3DM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 23:12:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2014.outbound.protection.outlook.com [40.92.99.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD3583;
        Sun, 29 Oct 2023 20:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMvzv9E5s1UNISlRtZEBYNHi0Y9NShYnePbZbKtKTsuJx6QeCJw7LlLZ+c43Ggvi+rEzScudCqOm7HsF/LSJJmDoJPYPdeCT+bxPMgJ+vqfDL/swgmX+VXaE8pEL3FkbnqSVc4QIh/chTzt8sx2QdwFBU0Wxt6sE10mfC3cW2tqv19byReI2FL+6ANSdl5G0S+PAb/tiskktmQuSzIJV+5AYpNHQkB4azSGjJj2FNFneAEwbz15KRTCZhp7tadxVNoaoyjVDEewqlytpTvQPd9ABemcfcBnB/M5DdXJ5nZN8tyFoZJ5BeLci1TCqKNRrM/xxquYvJNG40ORoAlclPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ0GVczn5B5dZgmYmSZ2mwq8aPH00C4+W9rDAE1zh8U=;
 b=YnnH5Ue5HVOgeQYyZrJ4qY28W9ew5vKzA2JovXLhz+JB/Q6kq5uiBxsowEQ5kqj0oFU4rLCkpZmfj/7yMGLZKO/u6DCYb/P/v7R0OvJAigCEICaIgQttysbo/yeQhRpXKqBWW9xMJqmgNM9ZvedtUfYvT+Eg55bJVbA1ef+//tB7E+ioR+FT9GZgSEUfyOxZC7SYBBPzfnbVhPbFjEoXxo9tx48L389YUL/9rbc6YJfKqz6QzYSSQQWPqXPtOJcOEuFJfgPMOL8ntwOK825TOzqTxIV4sZU9JP9GwqU1ZI4rr+mxXf0mATFoap0E9HwRGd0VEL9a0J0q55aXHWK3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ0GVczn5B5dZgmYmSZ2mwq8aPH00C4+W9rDAE1zh8U=;
 b=lf10daWoWN7b2VOwwezOyOxSS03csdP7LDdVbPVh2ynuFSlKiUrUnpef5OPX9KHuHU3cfrhMalXZetrIDkMKxkUKh5Rs9KmtVNLtIe9EmOS6U9lkGoAaDpld1LypeA2DdylNK4u7nptycB99qKjE4FAWfLsP438QzQIyevmIm/QVup68dMiQHXkUoe0QHLmVbXbF5c1EXMwUg3iqgbfrpYkN+xwN+vNPjliQQVnZSRPfKBBHdZVT8UssPk38JLgwqSdrNjasITsPi8HCT2UGcj61mxsisfFiHTB0CZWzzFlcVmBBRwUSuFHbWtcmbulzVjsgsgsCpK5ipVJf/Op8Jg==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYCP286MB3800.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:37b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 03:12:22 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::76f1:9199:ce06:9129]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::76f1:9199:ce06:9129%4]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 03:12:22 +0000
Message-ID: <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 30 Oct 2023 11:11:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tools/power turbostat: Fix Bzy_MHz calculation equation
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
References: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Peng Liu <pngliu@hotmail.com>
To:     lenb@kernel.org
In-Reply-To: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [IWYN1efRQbT25cgF9QkAvMD+Z44Vwa1V]
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <2e938053-3502-dc03-b95a-255bfe794882@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TYCP286MB3800:EE_
X-MS-Office365-Filtering-Correlation-Id: 922841f8-456b-45d0-bc6f-08dbd8f6084a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXSziK8B5ZbPfkBoVwwf5lqzbFLL7LYv6L/NuSCfw4eLzJGo+ffK8Y3GAdzdIe4g8CaUV9TcLzFBlXhSga1jq3YnHZnBprAoAbVC6R505z++HRRrIlCGEM99kTm0L3S5X1qf8LY9DJ81T3aOquiyYfbzBIK5uXwIqVzlYJJyJyPJmUSkiezqnC0oXDB1+C8whwJ6jPrbzy5S8Q9K0pH/ukm6ReOj9Q9oVG7s/25pXNcYOoPQFtq/rOeH1/y3bWMqcRNt+gmwTNF90SColCp6x4OfMs8h8GCnsLOlGrKct3Y26n0W/TqNJ6wLg5HFpNbGCkj0QWeNFz/ACm28poZl0CRtjCECfStmBq+93GKVKx74NKEUd3k1V5PlU5NS8YYDNOktVQaon6hgI2W3xi+62osfiZaXpMFB0VM3upS3RtQIm9jAWhUFTlCT0A2AY5jghlnUIlzSURdrzUODVnsN7ZwRXC1zRaa4QSPRN8UMW0HrWly8kGYNH7s0C4KTzUZkNdTFYTT2Sie8uHVwYBzTuzGc/hMwhjl58AzAECqJZ6xWXVd3Ojx6+f/xh9SXSdpV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FWVTE3b3RGSlpFbWEyUW1EOVR1WFlxZGpFOE1zWUoxU04yaDVDWVorVW4x?=
 =?utf-8?B?U2Z6Q2lFL21LN3hFYWhsc252NG1tUEFNNkdhZ1l4VTRTT3pxMHZBNC9ETFJF?=
 =?utf-8?B?NGt0R1JqcjBheHhjWVNsZVcrMXl2TTB4Mnk4K3dMeVN6bW9scERvVExrNC9O?=
 =?utf-8?B?aDA5ckpJNVZCTkxWV2VPSkE2d1N6NXdrVHVKcGNZdVBDS3FJRmYwYWtwTmxR?=
 =?utf-8?B?bnJNZ1p2WWhiNGpaTytJaFdHRHd3U214SU9LV3R6MGhwOXhVR0RQNlBXN3p5?=
 =?utf-8?B?b1lsQldXQ25YY0laME5xaFJaZXNJanB2TWN2ZTRSRldmeHViQXZHUU9Qbkd6?=
 =?utf-8?B?WXlCL1JOYXR1YlVSbWE0Zkp6U2VySVFvYWU2M3RCQitIU0dxbDc1cDRwZFhX?=
 =?utf-8?B?eXd4MmVtbmRWWXJWenpESjdYdGFkTjI1ZFpGR1Bnd2wxZ3g2WnVHaTJ0S014?=
 =?utf-8?B?bWJwWHJrY2EvRm91cStBMDhpblEvY2hobTg4RVgxN045SElRVlFqR05kand4?=
 =?utf-8?B?QjFRT1d5dGllVVh5d09abTdXbEZJblk1YmQ3UjlGbWpRM0wzeFg0dDBkekly?=
 =?utf-8?B?UExVNG5FWllVTE1JN1VHWWZaazBkbEtKa1NoOGN3ZEFpWnZRK2NEVmpUVWw3?=
 =?utf-8?B?NG9YemVLM3YwY3FkUUhEMkw1ejhKaEQ3dDduenRsVzhHV0hXK1NmV0FkQ0Fa?=
 =?utf-8?B?VzAvcHQxQ2hmdjVCcmhxZGpTQThtbEhGZFBNaW9mejZQTzRvbjc1MStvQ0o2?=
 =?utf-8?B?andjWFBjNDMxWnVsUnNCNHlJUWpWSW9zUUZ4aXQ4ZGxpRjhOMGh6TVM4andr?=
 =?utf-8?B?djVaNHpuNlNFMU9VakNNZW9OUnk5Wjg2NysxQ1NBQ21CeTFrd1FSQm9pTVN1?=
 =?utf-8?B?anJSK3RSTWtwa2xuam1LMHBMTUpZaG5CWjB5THBsUzZySFBxZnBOUDUwWVNq?=
 =?utf-8?B?R3Z2blRtdVdDcjJNUUQ2UFNINDMwYXJnUVJJVnRNVUF1OTFkVXlJM1hvZ1Zh?=
 =?utf-8?B?Q1F5MEZTVmxzSG1LWnlTVEFldzV6bjkyanZMQ3doZitxVlQ3aTJIbXFoQllp?=
 =?utf-8?B?SkRKc2x4Sm4rV0s1MFc3UWlTdVpsdXYwZ3hRYnNub3hHcHBLamxZNWhIWXpl?=
 =?utf-8?B?V0twUVV3TjZuYjBPWFJqL1pBTWRXU2pOTXpBU0ZTUDl2L0FaSEpkRnZaKzRs?=
 =?utf-8?B?TDBYTUVmS21wNFJzSDJSTDJVb3RnWVhRcHdibHR5VUtBN1pMY1BPdEh2bjhm?=
 =?utf-8?B?TkdGcDNwclhJNUZmMkwyZWk0WVd1bVQ4U3hLK0dEcktVQjlJWmVrMjVPZ3JP?=
 =?utf-8?B?dVFnamRLaE15YUZWOEgzUkFyWXNWMXBlNE9EcDRkMVAvRnBLQkN4NnZhd3Fs?=
 =?utf-8?B?VHNNSXB5WUtIeFRsV0dNbXhPR0R5TkpQa0pJYm02eW1wNzhOeFpTdHV2aVJo?=
 =?utf-8?B?bjhBa1ByRUFDcFFoSW1lNERvKzBSTjBPc0VLbENxVzY2NEVGcDZrQTVkVDlm?=
 =?utf-8?B?VXRoQjJNSFV3R0RsbWNSQldWVmE2VHFEck1pQnlLc0ZwVm9jWDRNVmd5cXhS?=
 =?utf-8?B?K1Q5RldrYnd0eTBqck9VTmZtSldmSnAxWFlCWUV4RUd6NHlKMDVMRG5xMHBh?=
 =?utf-8?B?cTQ3Nkt5Rm1PM1JpNUpGU2xuYW45QkE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 922841f8-456b-45d0-bc6f-08dbd8f6084a
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 03:12:22.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3800
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

On 2023/10/7 13:46, Peng Liu wrote:
> From: Peng Liu <liupeng17@lenovo.com>
>
> To calculate Bzy_MHz, TSC_delta should multiply APERF_delta instead
> of dividing it.
>
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
>   tools/power/x86/turbostat/turbostat.8 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
> index 8f08c3fd498d..1ba6340d3b3d 100644
> --- a/tools/power/x86/turbostat/turbostat.8
> +++ b/tools/power/x86/turbostat/turbostat.8
> @@ -370,7 +370,7 @@ below the processor's base frequency.
>   
>   Busy% = MPERF_delta/TSC_delta
>   
> -Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
> +Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
>   
>   Note that these calculations depend on TSC_delta, so they
>   are not reliable during intervals when TSC_MHz is not running at the base frequency.
