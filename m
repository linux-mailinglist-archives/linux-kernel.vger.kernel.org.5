Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D357D38C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjJWOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjJWOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:02:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C77110;
        Mon, 23 Oct 2023 07:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqKGhQIPGccdliRPHxVYgDepliO3TT3V+8YOMGrFnyYx9k4XVWt2f6lw7WgD80TcKRsSiGD4um6Ww13WoOffUai9Mmj3yd6pjqSWGv6TBvmQ2/m083U6S0bzkCgZJTmJi3tgVOJOKo3bp3sA4wyNDdPZXrqLkWgNkPLv7gxjYWpISSWbz5SG2ImrKPlTuB3Bz0L4UMhx95ezCdroJAqqkm4B9iuNL8cfLd2R0MDNBwYDl7+z+bhH54rCMh7u5X/4cyh3rkbBZvCex+bQQYvL0UvYF04XXJtWbdiTvc/RZAsKQTFNxfbZ2kfBZSJOOsrFCPeXN6qRpeXMgVdD5KYt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3DyJd7TFF/qBXDokCRyFkVipgEdQQ7Nb0o3Rd52qZg=;
 b=SeKD4wb41x+wFFLwRZ2bNOCldjeYvd5R5+2lFyGsqUP0bWnFc18bMehU5EWZzQ0YwCFYhhF0YbNm4iff5m/L+WL8Yke7d7lilOHBKVYfOheShe9pHfo8TFKdWItgL2SZY7P3Nl04ImzDCw2wl+Nrq2mMjdQ7QCg5tT7zYRu7LmHYmJYNLHOGM1TBAjqdy4RklxIKGcpEra321dHRL4b8AQOY49lUZfQ0WTaJFWAMw3XqOTCqlSqx/tA1H5uMe+GvBhaHC0uSoI4p2SBTGC8NJAhTShwoC2HpF8PqV+ZvGBVz+j+drb5cod7ZPpE1IxViAkIUYh7P0AUB+ZmkEHNh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3DyJd7TFF/qBXDokCRyFkVipgEdQQ7Nb0o3Rd52qZg=;
 b=iIwHoOSu3FdhhB7tyOTdvpTb4Oa4a2G/73rnD4PIIkC+GkjbWBafCgr/VIlARmqrg4XVZwW6VVHPSg6UjbNssW9Qk0zn2IVbYbyMeyKOxR418q6GNzR6vMQdw6QxWr2SMCpHVuPSze0PlgxdyFMK5rrN0zNXMhvVF9X19X3aqzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 23 Oct
 2023 14:02:13 +0000
Received: from SA1PR12MB8743.namprd12.prod.outlook.com
 ([fe80::4af7:3f12:6583:f51d]) by SA1PR12MB8743.namprd12.prod.outlook.com
 ([fe80::4af7:3f12:6583:f51d%7]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 14:02:13 +0000
Message-ID: <cbe9af6c-cf92-4683-b302-0fdfc9c5009b@amd.com>
Date:   Mon, 23 Oct 2023 19:31:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tee: amdtee: use page_alloc_exact() for memory
 allocations
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
 <f08778aa-0e50-40aa-a1be-9cc894b2e219@quicinc.com>
Content-Language: en-US
From:   Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Organization: AMD
In-Reply-To: <f08778aa-0e50-40aa-a1be-9cc894b2e219@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::16) To SA1PR12MB8743.namprd12.prod.outlook.com
 (2603:10b6:806:37c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8743:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fde619b-582e-4fe7-4847-08dbd3d0a7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAAugxLSfRWV9XoKxcBMpQpzazqlqFrml7pB2/7uO7TXkTnol7YmR/uGGWf5Q9g3XMLICxsbZj700XAn2QQ9hUSyh8xtizm0eRR5b8bZc0Rj5gOnaac2dVGznutV47KSoGb/5W5o10xCE2KzKd/HGdnmOyleab5cVP04xgs/m5m0ejwExuURsLTyY5MpcCG2FDH8Iruyj19ITLToZP8BbTDm7f6fZhrOhYhs27a7EsAhoewH0EmZZPcSU5QKxhOQfXhu6E4dAmO0W00Tj/NlOKlREvHGt6haUSJFFKhNtGNX2/+DI9QVBYRpfhQD97Z4he597GFsVanDw97cF6PgF+GrPGTYXMr0Qlv472nEKXrMkyyd6zGnCw27JEjNOkjQkmw05NacIN0x9ja6QH9q3HEKF96kE/VH1cbWnPfLtaED8lpo03FOtHvRyaFajU365v6TAdHyZAcrcG0JrmS903WZAFtfi+VZcrp696ANmehMr8M41y2PNFeMThvlJLM1hEca27KavjYcdI2L/aBqizlWK7dxrAo8jV3A6AqKWqjKjBo0iWNYsYQkNi8F8Px8VujXVbK78b8NtGO9HS061d3l0cQEAw1xKU2OfYy2DArGegrTvRX7jvqCh1E5X2EFFgJxCurl37/Ye7k4sIEEYXkg9dLlxCY3UTQVZmLzejY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(36756003)(110136005)(66946007)(316002)(54906003)(66476007)(66556008)(31696002)(38100700002)(86362001)(2616005)(6512007)(83380400001)(4326008)(53546011)(36916002)(478600001)(6506007)(26005)(6666004)(41300700001)(6486002)(7416002)(8936002)(5660300002)(4744005)(8676002)(921008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xrbTVjK1Z0T0MyS09EVVhTQnZ6bHZ3Y0NWVFYzTTZDRTNXak80SVhBRkZt?=
 =?utf-8?B?NzZuWXVCcGNKUWpTYzBSblNIaXlrK3NUaTVqY3l4azdxRlJvVDdNYkVJLzR5?=
 =?utf-8?B?RTJWRVkxQnUyRGRZdWlObnNoSzRNV0dDYkNPTXhVT2lqVStJd3hFclpveDd6?=
 =?utf-8?B?ZVp1RFNMZGRkMFlNelJRaFo3bHlvVlpZVm9oV2VMSWNxYnQxL2JYZ21WQzkw?=
 =?utf-8?B?Y0xpTTUvY2d3dDYwbTN5dWZlVjFWdTdQQ3BhYzNDU3lJQ2FLdVdFQ2w5WEh0?=
 =?utf-8?B?aWhjU2RWSEROTDhveWxRVFBDSkFvY3pRRDJ3eWxmWXh1dkphWFBTcmtZcURD?=
 =?utf-8?B?ekQyN2hrNmRjYjE1RGFCY3BvdnYzaFZYSDhZUXUyMlpkRHhNZ0oxdUZOUzc5?=
 =?utf-8?B?S2JHRnVwcURIMnlSM0NNNlZWcmtjM3h2UGYrU2luaWlKV2Q5ZUFrZXYxZzl2?=
 =?utf-8?B?YWRGNGpVQ1NIVDZOa24yYWkwRmNnZkpXVmVNSGNZVFg5M0dDYUFNdE84R004?=
 =?utf-8?B?QW5CL01vcVpGcm03YzRuTkFqMXZ4Y0ZGRkYyTkQ3RkZJSXRkOFYxV3hRSkNS?=
 =?utf-8?B?ZHZtOUloemhTMk9qMituMEQ3NTR1U2FvTEJjeFphSnllQXFSOUNscVR1dFN3?=
 =?utf-8?B?OHA3WVBpK0xRYTZRbUk2UFBOK1NJbVNKVlpDZGxoWGFXbUhzZ0Y3eGs2dTAz?=
 =?utf-8?B?WEptY25uTlVzSjNYYzdGL2FrM1F6a3BJWGhiMGZ2OEZ4Vk5ydHlGUTlNNEtT?=
 =?utf-8?B?K2VuR2tSY1U3M2lKc2JOSTZrN2JFdk8vMitZUHNtUlVzUC9ZbDhDbW5xN3Ew?=
 =?utf-8?B?bVJrSzR3RnRuZkg0UTRBeWtnQ09GWjEwWlJHOFFGeGJJUExPWnMvN1AvazR6?=
 =?utf-8?B?aHpUZE9mUU8ydHdRNGQ0bUNaSjRNSmRNSnBtdWFldXNWQURjVlFPRStYL2wr?=
 =?utf-8?B?QjBMT0tablBGRTZtYm5PVFdTZzkycXdPUjVjQ3Y5VDRnbnRiR3JlZVZqQzE3?=
 =?utf-8?B?VUwzeW96Qjg2SzY1cEhsbkFIM2l6SE1QNFE5UnJIY3c5Y2p4aVFJNVJvRjNh?=
 =?utf-8?B?T3Z4VCtLb0NlcDcyT0VnbFd4YnhTYjF4L2cxdU04RmRhTnBxcTFuUy9nbnRr?=
 =?utf-8?B?bEFwNDV3OTZRR2U0TWNRN20rUyt1VFFvbVprOVQvMkVCeVk3RHBFQ0Rwa05V?=
 =?utf-8?B?UXZyR3FSUUJoMU5aK0xDT25pbWNNMUpwT0JHYk03QWhFTEE5OU14NGZUclU2?=
 =?utf-8?B?THh1eVBmRVRDbG5XZ2UvSEZFMjJzTnl1U2tOTENqRnE2MjNsYmJJbktxWFF5?=
 =?utf-8?B?bmRrS2pZd2pPcEE1ZlVOMHE1ZUp6UFJSOWIyQklxUmx2M1lsdFdsVjhDa3F1?=
 =?utf-8?B?NURiTWFvUVZCb291VklXWmNmT3N0NzhLMWZyMHVCZ0tBSk8zYzhUV1hQZlcx?=
 =?utf-8?B?cVpGTXZTY2d6alNQb2hVbnhLQnZ0N3JlaGhTVGZ3V1pLTmxuS3BZdFB5QVp4?=
 =?utf-8?B?VDdxaHV0Z1prVFJFMG5xV1ZWVkl3WEJRRFpQeWZySzNCenlYaGVWUG1FNjJD?=
 =?utf-8?B?S0loZmdoQUNSOG9Ic1ljN204bkVnUEwrOFJLSzhQam8zTHJnYjZOQU1MdTNI?=
 =?utf-8?B?KzRHbDJwS0h3Y0pEVklGQTFZS0k0Q2pJTkxLUEZsUE9ibUsxU1pTNXpBTlBy?=
 =?utf-8?B?NzdtL1lJZko1NnAyeXlOYUNwcTk1WTMzUmVDa21uRkJERlJQSXc5a3Y1Z0la?=
 =?utf-8?B?TEJWY2tlS2x0dFV2azZRSTFBTkd5T1U2Q3gyNTNlemFsK0pLVzVrQ3dsa2FM?=
 =?utf-8?B?dFJ0TStzaDlIREp6N1dUNVB4UU1zWlZGRnRhZ2U0bVVGcCt3NnZ4UlpFakVa?=
 =?utf-8?B?WEFCejBYaTJoY3EvNmtSMUZqNVRHdWNOa2YyZ2c3Qml3QWQyb2ZuOXUwalUr?=
 =?utf-8?B?Lzd0aTlNMmp2azRLdC8vN1RkL2JST1VXdGlzb1VKeWYrUWlyMzhSODdtL0hy?=
 =?utf-8?B?dUlielZBbkhLNzB0akRLRUt6TlhKYUJYV3o2SG41b01HT29iTmxzSFU5VnV1?=
 =?utf-8?B?eE4wN0hSbUlpM210WkNES1ZZa0xmR2t1QTNWdlg2UyswVTJOZGRSMEVmZHhC?=
 =?utf-8?Q?4k/Uswz4fjoaFaLA6hWH+4k47?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fde619b-582e-4fe7-4847-08dbd3d0a7fc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 14:02:13.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vZYzQS720ct3ut6rSu6YWwOWjE/Po0fmjfU3CJ15g96EZywa7aLIFyW/RlVCwG9fmqWa6JgJXo79Y3DGq/KdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/2023 12:39 AM, Jeff Johnson wrote:
> On 8/29/2023 1:19 PM, Devaraj Rangasamy wrote:> Use page_alloc_exact() 
> to get buffers, instead of
>> get_free_pages(), so as to avoid wastage of memory.
>> Currently get_free_pages() is allocating at next order,
>> while page_alloc_exact() will free the unused pages.
>
> s/page_alloc_exact()/alloc_pages_exact()/ everywhere including subject 
> to match the actual code change?

Ack. Thanks for the catching this.

While I could send an updated patch taking care of this, we are working 
on a rearchitected patch, due to a new requirement.

Kindly abandon this patch series, and we will be posting new support 
soon to the community.

