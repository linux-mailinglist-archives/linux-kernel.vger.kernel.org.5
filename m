Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ABF778D48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjHKLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHKLTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:19:47 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99ECE71
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFPF+WiEfOfxFzN8xCdCbjoHa1irlCxtrcjPfiFdvIcSkO/MN3yUZFdz8q7naXRvHEjn9onVm+GXzsgtSwl5zY5+TNkNTxFiAyhO662HnJRyysxYykFRFSYLzVUFcLPNK/O2dQ5ek5DqgzdLLv4wG1l5oItIG6zTW8Pbrv/R46uZQpZrXuZx9e+h4D1/OEvXxcRSe0zuNqxmH5s8zlrfIo1xXzIAu+V8AC1BF4YRgGap8r2C/Id7aiYsm7/s+oZAfDRZa8D9RMG5A9m8MIbu9BhZ3XuSyL0Ink5BK1xjvlIOerzptHwCte14WZhbQJLNB7WI4i4cRFNQ/9/c0djPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6UGjwtwU8UfTZ7NNhusHh7wPW2Tj+J2cwXq7kMVCR8=;
 b=n8lEI/J66hNaDMR5mYGeOJDjs8Bj0n/5eE95G7keP1BpR+reC7TYAU/wX1KPPuanl8eJtHGjxoGf2FZVx2RnAXaMIRFIdcujxs0Zj/rwlrJk/mZLr4VTd240px6PTLON2xHRFpYIQhasc/7T5UkyDzlm4Yyhlf/C34L5GBslfYG/UlZjSteIpdM9Ozs7m9Osr0JqSRGbB/+ckUbaN3k2qxYiw+qfkHqULbAm8RsdRui9qRLrkj/cMOjxcNzYLgYHPbKvYZegmRlSuG24GiPXWUOHXxQ2q8orwNJ22+ikaC7w8BVYvGzF9IivJp6gbBKEPPfH35UK/HzpWJYLgmGWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6UGjwtwU8UfTZ7NNhusHh7wPW2Tj+J2cwXq7kMVCR8=;
 b=t4yJjsdr+jRswdZtq48VnuMiaw5uSSMIEu6VZqeNtjKFWNdgUd3bWY07rG3Y1HWZhjLXOoosJ7MmdIz4F1GShqMTwzgTleRxBEjzyB/8gP/v+lZRUZ9Qhy15joY57qgYgkBhX5a8ULsNeA9PJTM3OlWjjqJkVZzMpmA4TghzDQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Fri, 11 Aug
 2023 11:19:43 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 11:19:43 +0000
Message-ID: <eac35f48-8683-3d3a-fa04-2adf20d3380f@amd.com>
Date:   Fri, 11 Aug 2023 16:49:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     gregkh@linuxfoundation.org, maz@kernel.org, tglx@linutronix.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc:     git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
References: <20230710112844.27309-1-nipun.gupta@amd.com>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230710112844.27309-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 224fa406-2840-4754-0753-08db9a5cdc2b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOf+Tk8ShHHy//rCu0dWAXXWP4fmI679jNVe4W5VYroTqBaNpo2/eYIsA1d2T8xPtyHAp/z2gR3bB1mSk+Gf2Y3AxBrqFExi4R/wAmVyoi/qPF6pa8u7sNGQF2PgPr19vIYAiEYRoy88l/pn5Ka2SwuC/6V7YBw7lN6SBUXfwLEjguLnQOR1cqVTS743CaptL0D3E5DQ5y+oUXFlyF3V1kmeG6mxDx0cHsfgqDI+9v8WDz5c0gux15FPrZqrllLKaDQOlm/3cDuH3fDycznLmUz6n2E4X243EBnY5B6FqW948FlsAhyLxs/az1kv07V0fxpnKTmXZuTHpqY7T1p63Fh8+fSrnShGAxkzqNAkTtmHg4/WzTafeUA/iL8KZQY1CYioVfFUNYBiJBcPwlhE22YLRFIeYzWwDOEDFzWsGY8gp1Za3rj6Eri9Ks5Af41eiP5dfM8shw84N4kWVt1fI21UqrWdOBMXVLkyJQFfmqQ0PqwMGvgutI6+VunpmBC6+s2ojtXXpSzAs6ZCE0kKV+n1Lxwydw8sFRT/J/IJZIAxlHdGstuB1N8j7LvlM+QxFwiqQjgXSyeOBpbedRj7xdB80NFCCICKOJ9FcS+p6SaP1xepeeBYFqv+8oCMnLccaKVlj47EdgHMbqRU6fAqgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(136003)(376002)(186006)(1800799006)(451199021)(31686004)(26005)(6666004)(53546011)(6512007)(6486002)(36756003)(478600001)(6506007)(2616005)(83380400001)(8676002)(8936002)(316002)(4326008)(5660300002)(66476007)(66946007)(66556008)(41300700001)(31696002)(86362001)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVHNXIxaEVHMHkyRWJ0UWhmUEVucG9vY1VMTlJYWXRyOUNsanZqUEg5N0pH?=
 =?utf-8?B?VkFOT1QzUHlNTGZqcWFQWStpQTYrdjk4cmgrNU5tT0MrRjRGME0xYXlwc3F2?=
 =?utf-8?B?SWN3TjIyT0c2bHFnYXdXN1YyTDh3eGU5MEt4OXhJTHhwN0FBeDgxVU4vT2x5?=
 =?utf-8?B?QkVvbHJIc2VnN1lZREZ4ZXVhaW12Yms3L3BZL0VESWZVVUYrVTRKMXVqcm5E?=
 =?utf-8?B?a2xtaUVQeVF6cXV4T0hyZTNDQ3VlclpZeVUxMFhVSEw3bDg2ZGNWWVI1ckxm?=
 =?utf-8?B?QkkydzJHbmxuK1BMcjQvS0d6a3BBdXlHM3lMWU0xd21iZ2NXUXAzYWpvVlNk?=
 =?utf-8?B?UVRNdFBDL0RkSDhTbEhubmUvWTJITkRYY2ZyQ1Z4dDQzVERyWWxNTE5tSmRT?=
 =?utf-8?B?ZE1HUE1nQWcxT2RQbmswZjdtazlYbWg3TUVXRHlLRDZic245VEx3alloam53?=
 =?utf-8?B?Wm9ESW96MmVPK1h4UEY0SW5qZEIrT2NaNm1JZVl5a0hMZFRGMUMxVkppUjZP?=
 =?utf-8?B?SERVNGh4ZEE0dlp0U3h5U2MzL3pxWERpWE1JTWZEdStWZjJJdjZMVVRyNkw1?=
 =?utf-8?B?ZnFsc08weWtzRVB0eFJKbXpscXJzRkNXTEVsL2V3Mlh1a1krYXh3a1JiSndO?=
 =?utf-8?B?Sk4xRFVnZ00vR3AwK081bXRCYXhHalN2WDdHQzFFQ0lRQ1JjRnVjTjlySFU0?=
 =?utf-8?B?cnlab1NHK3lQbjFHVXdoQ3ZmZFF3TzZuS09ZUUtUSVVCQlB6ZFBhSW1pbUVW?=
 =?utf-8?B?WUI3UEN6OE5JcmZOWkFnVEpQR3NOUk9yVUJhUzNvOWdpWHB5QWJjczhWRjAz?=
 =?utf-8?B?S3pwTVc3Wk5KYzJLVnpPRC9ZU2I0cVlGWWNzM0hud1pwaVVSU2xNL3BmTklx?=
 =?utf-8?B?eUVZU2ZOU2QrdUVMY1BYOFVmZG1mOVF4T3NKYm5IWkxod0p0a2Y5dk9kQVc4?=
 =?utf-8?B?bzROVGxobE9aNCt4NGhjRWtqZmt6YWcwbkc4RERYNGtQVURLaEozbkJockJP?=
 =?utf-8?B?aXJkN1JBNDV0UTNDWlg1cGlnUDFGMkFSeCt1ZXBPeDlWeEQ1cHZaQzNwM0FY?=
 =?utf-8?B?YWZQZlc1MDVnbFErQTQwdGw4dDlpeHJkQ21CVVpwQWVua3puMitJRmxNWWI4?=
 =?utf-8?B?eGQ5Zmt5TTF3VzRUYmMwYUcvb1E4V05qTHl2Q1htUjJNQkdiNWo3M2U3cC9u?=
 =?utf-8?B?YlhjZ1FQN3cyVTlCSGt5Ni96OUxMZitWTU91MzQ3YUk0azZ2VFJRaUVSMEZB?=
 =?utf-8?B?dGlXT3hVMVEwMThOa0wydkY0bGZHYm5KL1YwcHpWSXRHdUc4NkcwQURZOFk5?=
 =?utf-8?B?L3E0UjlhWmJhc2tFZ1RFWXhzVUwyZXVhanJlc1NhL1o0S1N4dEZ6NDlNVG1Y?=
 =?utf-8?B?MVZzMFpyalMxQ29YdVloRjBtelNwTFJJcTlHRDZTTjdqNnlSSkRvNk5WQjJC?=
 =?utf-8?B?OG1uaWFTTFZkWEVuYjJNZnl1dExSNTFFN254VVpnK3NLQlkvLy9YTUJRN1pk?=
 =?utf-8?B?cG9EWWdOUjdUQ2JsVkh2YmZNQjlSSExMTXh5d0cwTzYwaTRRYkdXZFZva2Fa?=
 =?utf-8?B?VjRMM2UwUHFCbTlCeloyaXhIcTdFRnA4Q1JQdklmNFdjdTI2TklqR1ozSEpC?=
 =?utf-8?B?bnhsZWNJZ3FvdU1vQWlURWM5QlZJVkNCWVFpc2pjdHhnd1JKcDNwcGdGNUZJ?=
 =?utf-8?B?Nzd6akd2ZXNXUlB6a1pKVUNLODRjejg5WnJRZlhJNDRxNFpUbEZZMEhpakR0?=
 =?utf-8?B?R2JEc1NLbVV5LzVrVnZFL3dTRU1aMGVPd0puZWFJYzhqT3Y1MW1qRGs0N3lV?=
 =?utf-8?B?QW44SEpwV1N5eGV2dmhmdXA2cENSdk9pK1FoRkVYeHRxOFVoZVo4cGlCb1NP?=
 =?utf-8?B?MTVwR0U1cVZ6WnZXSktxVFdmMVpWRWZ1Yy9vYWFndDlreGJ4bFN2dFJMTEkw?=
 =?utf-8?B?V3VDSTdzd1ZlL3JDVmMwUHE4WVQ1SUhuQ1RzbENhUFp1MnM5ZVp2cXN5RnBh?=
 =?utf-8?B?UGtBbEppdWRMMXgyZFVVZlQxTzF5MmU1YW5TWHkrTkNDKzd4dENsTml2RlZq?=
 =?utf-8?B?OGErczZZejZrVjZjMEtqcDVrRkRnOWF2d2FVTVhUUERmczdMK1pxUlN6ZzRP?=
 =?utf-8?Q?Pan9T+YJ36nNlzj7JFoApD6/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224fa406-2840-4754-0753-08db9a5cdc2b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 11:19:42.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUlN0frF47E2ZzAk2BtETQa7A/DWU03sA7+pBJVN+p5E69s4eJvFhe5/YB2GB1Oc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 4:58 PM, Nipun Gupta wrote:
> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
> 
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
> 
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
> 
> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> 
> Changes v2->v3:
> - Rebased on Linux 6.5rc1
> - Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.
> 
> Changes v1->v2:
> - fixed scenario where msi write was called asyncronously in
>    an atomic context, by using irq_chip_(un)lock, and using sync
>    MCDI API for write MSI message.
> - fixed broken Signed-off-by chain.

Hi Thomas,

Upon reviewing your comments again on the version v1, I couldn't 
identify any oversights. All the review comments you provided earlier on 
v1 have been incorporated by using irq_chip_(un)lock and sync MCDI API 
for write MSI message.

However, there might be aspects that we've missed in this patch. I would 
greatly appreciate your suggestions on how we might enhance the 
acceptability of this patch.

Thanks,
Nipun
