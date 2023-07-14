Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5007531AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjGNGCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjGNGCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:02:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5EB2D48;
        Thu, 13 Jul 2023 23:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCq/qbfCA+KKC7pKaj1nK+ToivXx4ig7STc4mCK/y7qm9dHl4b3XdfqB+BunDjzx9bNk4dO8G8po9W/ibg0Kn6jqDVSW8vWi0N8Ia5fpyTVfhJOb+HjCLh4IUHsYsUD0JcUWHtGUJEr1/CV3jorFFLsiLX6pdVeVuU1jxuvgD1ENuGOHOT3ypQR5hOpm0m/AX0KHqZFKVVBLjmouZOmHYQ3XpiRV1qr2rlG/ma5tDZb2IehZQPTI6BKvipkqjmSxKmeg+7e3SL1IDm2n86BBMhcOb8wEnI36AITJ6AAtB7jssOViqYaRVVBOc7ssw3+4wtyW7bwtcHE+FRTEr85IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/LF3weuamdRrsMUPt3jnZVrhWgd2iimN+7qkiWWcwM=;
 b=LP3kLSctS9v/fxYCHM0lyfp6TDGAam6dFRe6hNbQmXT2kCov0vIjWg5JXf6F+3EzUlnvgEOaPZvunRdw4mYrbkYmaEin/t1lgyiQto03svZ8kw0ffxbgLd4nAFNVXCyrqyLE0jaqDbOc7cbcDb1LBtE12/Xhy8kK9OYwAP/I8DaP9/FM7r/Yw3YfNYJvbi6hipWUJuXdpmFxCXeZEn5z3B8z7Zd6KpnYOlWdvtkJB176clz9zTT6v8ZCJDLQz3z6s/5IH4w9XyN8O5sTjac8buH/BuR/JBGsACrlSKiudfZizA9h9dalG3y5Fhdckt6u96ByKzMVUOsVLe9Vbh5rNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/LF3weuamdRrsMUPt3jnZVrhWgd2iimN+7qkiWWcwM=;
 b=X3n0Fu+c4WxcCE8PBcY0WtxBCVHDhD0EOz0jV27c6ksrxcd8Lm4RHP9XHvX87hRfybifz36TjJgV+jDDGECIfF2UzCQanxpQ7uwVOcUW/e0pekweXRXa3O0lfDzybAuDgeN/arOMsnUePoKVpNArNOMCGD8XHTfQWGHw4Ne4Q7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Fri, 14 Jul 2023 06:02:12 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 06:02:12 +0000
Message-ID: <ae21fca4-68ad-0599-39b6-028ade02b813@amd.com>
Date:   Fri, 14 Jul 2023 11:32:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
 <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
 <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
Content-Language: en-US
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe34dac-e281-4089-4244-08db842fdd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wy/0iVxGH5R0VTCindm9aR/ie1DL/ud4FReIoxQn+MChLlWGjXKhx5lQ3lvrPY9y3gM3BElkvQwIlGiCJOK1Z8ZjDlxYa3DKonWgVkfeE7Nixq4wt3wX8TKzvMbbJ1PMoPcN2UQI0+CRPW1Q48HaWrTK6BpYC9oEgtILzxYxHqkBXnbYKUR7mgDswlxzaSiynCEpw1SYvMklm32Q3msMCNHMnbmiJqbJJEIlHk2Z2vEjnMDZ5dTQSPHuL7M8x2boALdvBp0RjG6fX6AhJEZhhCZLg3JavYJ5aQexFQby6kuS76WZOij3nInB8uJ70hK6dVmBEKgJKEmN4kOTvcfA1B3A8Dbe5b9DpT5QQRIy/PCPnJtkpC9m6SS5hw/jGZKXwIpBjXMYNwXhLvzO8XbD8Swy5rl/u1+3b0HaRhmTuHXStKzfAkMjsd2L9MUtPJlGFzrxuG+w2gOqfIwCSG26dwd4DcOZbMLYxXjCP2wqvv4qpT4pw39ayrKc7YDlA3wd2k5odZQxegdnW/pwR/VjeckXk8eCSimfl222QgXJMOpEF+u067cGRgmWNB+o2tIkSj9bx99nfeROZbMa0p55QmyNU4Q0A2PH9D0LHJuCVwxu8nuStxB84cj4hOmGyuJ3+/IEG6ZXqArmP+3QWnSoBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(186003)(6512007)(5660300002)(26005)(966005)(6666004)(53546011)(2616005)(4326008)(2906002)(8936002)(41300700001)(316002)(66946007)(66556008)(66476007)(478600001)(83380400001)(8676002)(110136005)(54906003)(36756003)(6506007)(6486002)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01Hb0dOYlA1Z2ZoWmdpS1o3TE9TdGQ0YUEzd3lwM0N3dVA1S0VCTVlUSnpr?=
 =?utf-8?B?RUpRR3JpRG1DV1BXN0pIQnM4UEZIRzkxR1NSRUpZeW1yVm80cCtnVkVSeWxt?=
 =?utf-8?B?Wk42cTYzRDk2ZWRheENhRlJvRmREdGdwOHhNZkVQcEJpSXJtak1aQ3dhbkpZ?=
 =?utf-8?B?MVlXa3I1YTg3SUppQ2pLaEUvMHBnM0pwaXVnWVhnZEtveElWeGZXeXpoTy9v?=
 =?utf-8?B?b2xxbFBzbjh5cytYVTdTOWZiRWRQWGVzcnowUWJyMmRrVHI2bVF1TVdDQTZN?=
 =?utf-8?B?MHNHbVlEcGl0aXVXc0RvMGxWSVlKbUtBQzRWenltVmZHMzRtOXZpdVA3RTZa?=
 =?utf-8?B?ajlwMkVEdlN2dmlEcEszM3Nva3h1VlpHdTNMemczei9UYjk3U3o0TXBlaEFG?=
 =?utf-8?B?a25rMTlLM04wNk1DWlEwOVhPRHlxVzV4TVZpWmFJWVZoc2ljekNlazNpYS9r?=
 =?utf-8?B?NUZhb3RaS29yUU44b3Nac1NLUGdWNWV5bUVuM09mSHdMdDFjMG44TTNmdnQy?=
 =?utf-8?B?ZXA1OFVtdUNqbG83dmZVZEFWUE10TTB1NHJ6Uk1TMDhmVStURXJNbEtaL0J5?=
 =?utf-8?B?Q0ZFcTE4SCtKTW9uRzNSQ2RiSE4wbG40QlAyd05WaVZCMEJxNDMyM3N0dEFF?=
 =?utf-8?B?Y2pIWGRlS25hNVU4YmZnRGNYMldRYTVRbjVrMUJzNTBVeEtBU0pYUVVDbjQ2?=
 =?utf-8?B?QUltMEY4eDJrS0VBQ2xuL3RDUWlNT2xPeVdkNTdIcTNNZUdmSXlLUWRTU3V4?=
 =?utf-8?B?eWZ5Y3JXQ25RZzdIc2RudmpNeVpaY0lvWk5pMGZ4dU5NN2lsTTJQRlpDdmxF?=
 =?utf-8?B?eldWUFZMdTlSbDFIVVRPMXhIK3htQWQzR1Q3QXd4UnpNdUlyRXlvUVpDakV2?=
 =?utf-8?B?cGlNY09KemZqOTZ4TWlaYlJ6alZyNStaZ2F3UjZQZEM4cnZTT2JkQnRnc3FM?=
 =?utf-8?B?QkEzVE5hR1VuK2FCb0lEZ3hoWk1EbVlNYW9WSUFnMThVeWwrQzFxNkVwYmc1?=
 =?utf-8?B?cVFWM1YrVFByOTZRZjZYY0NXM05DdDN2S3luT0d1UHJuK29MM2RZTnh5V0Vv?=
 =?utf-8?B?WnozVitxOUN6bGwydXJNaGFGU2hwN0pzQUxsYjRuMENoSTFFcDhoV1lpeEZY?=
 =?utf-8?B?VXErWG1CVTlmSkdwN05iS0JnY0dkNUFqUTlhZUVLcFhBYUZ3QXJjT0VXckdB?=
 =?utf-8?B?UEtXUjF2VW1aYzNqSWxMRXpLY0Y5QXlJSENaalRJZUcrUlRGZVpHbVlZOUJh?=
 =?utf-8?B?UWMrcGdVOFU1SVJRV2lWUjd2UUxPZVovSEk5c3Vhc05qRnZ1RGxiWGQwSXNx?=
 =?utf-8?B?UDg4OUxLQzhkUEYvYnJCU1BvTTF0TUhkWVdiRGRJaCtjaUZ1ZldFQS85enlo?=
 =?utf-8?B?QXcrRFdXTW1pZjlsa2ZkNjk2Ym9odFoxNXJLazdZblE0YzdWUlIzTjl1eDhJ?=
 =?utf-8?B?eEZlbWx4VlNPbk1xeEUrUTNka2tTTFM3MCtkZVNaQmZCSVYwY0dhYWpLaGNC?=
 =?utf-8?B?VjZnLzJqZkx1SDRKQTZRbTZtR2NrQlkxZ3MyQUpHVlBFR25UdHhBSFNTZEZ3?=
 =?utf-8?B?bWJpc1VnUHlRQTZ2Sk8zVlJOVHV4QnJkTXN0MVhoVXhleWhmcnNDSWFYczVR?=
 =?utf-8?B?cVBQdno1Ris0dFc1WnJWYjFENUl3NUpEM096WlBxR1VuWldzRFFMaVBvQm03?=
 =?utf-8?B?NkV5Mi9qVE9ZaEt4MXRvV0NQT1J2ZWw3clNIV3c5MVhpajdWdGZ4SG9JeDBw?=
 =?utf-8?B?Z3gzc3ZzeVJsQ2VJTDE5bnUvZ05DZWhuUE1wa0lwQXd3a1pBcSs0S0dQMHZS?=
 =?utf-8?B?YllnOFdMQXh6ZzhPNVpiKzVrRVptTXdXQmtCdTZWMXlTTkh2UUUrY1Vzenha?=
 =?utf-8?B?U3Q1VHR0b3Z3L05DdWJKMmJvMTIyektXL1F5YkhpM2lyajd4YzhCZ2V0TkZL?=
 =?utf-8?B?dkhGN0d4clJlbzdmcEpENFU0U21neWgrUldQbTYyWURFOFZESFZMT1pybEk3?=
 =?utf-8?B?L0Z4aWhYcThhR1ZRYjNCTCtNSTJVbXluYjhMb0NaV005ZWk3TkdJMHA4Sk1E?=
 =?utf-8?B?RzRDVUQ1dGx1aDZRNHl4NGJaQzhUODkrclROMWxxdGVTVTdDNXpkWjVlYit5?=
 =?utf-8?Q?c7Aw3yCjOnn6l16/UzSogqjkh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe34dac-e281-4089-4244-08db842fdd5d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 06:02:12.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEXI7XwZlsELiHgcGM60E2CBvJWif8bJoDgxUrZNI6GMkaux5npa+1nMXM0pkdU+6Cn0mJKOT9J0cZdT0U/vXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 6/22/2023 12:21 AM, Mathieu Desnoyers wrote:
> On 6/21/23 12:36, Swapnil Sapkal wrote:
>> Hello Mathieu,
>>
> [...]
>>>
>>> I suspect the regression is caused by the mm_count cache line bouncing.
>>>
>>> Please try with this additional patch applied:
>>>
>>> https://lore.kernel.org/lkml/20230515143536.114960-1-mathieu.desnoyers@efficios.com/
>>
>> Thanks for the suggestion. I tried out with the patch you suggested. I am seeing
>> improvement in hackbench numbers with mm_count padding. But this is not matching
>> with what we achieved through reverting the new mm_cid patch.
>>
>> Below are the results on the 1 Socket 4th Generation EPYC Processor (1 x 96C/192T):
>>
>> Threads:
>>
>> Test:              Base (v6.4-rc1)   Base + new_mmcid_reverted  Base + mm_count_padding
>>   1-groups:         5.23 (0.00 pct)         4.61 (11.85 pct)        5.11 (2.29 pct)
>>   2-groups:         4.99 (0.00 pct)         4.72 (5.41 pct)         5.00 (-0.20 pct)
>>   4-groups:         5.96 (0.00 pct)         4.87 (18.28 pct)        5.86 (1.67 pct)
>>   8-groups:         6.58 (0.00 pct)         5.44 (17.32 pct)        6.20 (5.77 pct)
>> 16-groups:        11.48 (0.00 pct)         8.07 (29.70 pct)       10.68 (6.96 pct)
>>
>> Processes:
>>
>> Test:              Base (v6.4-rc1)  Base + new_mmcid_reverted   Base + mm_count_padding
>>   1-groups:         5.19 (0.00 pct)         4.90 (5.58 pct)         5.19 (0.00 pct)
>>   2-groups:         5.44 (0.00 pct)         5.39 (0.91 pct)         5.39 (0.91 pct)
>>   4-groups:         5.69 (0.00 pct)         5.64 (0.87 pct)         5.64 (0.87 pct)
>>   8-groups:         6.08 (0.00 pct)         6.01 (1.15 pct)         6.04 (0.65 pct)
>> 16-groups:        10.87 (0.00 pct)        10.83 (0.36 pct)        10.93 (-0.55 pct)
>>
>> The ibs profile shows that function __switch_to_asm() is coming at top in baseline
>> run and is not seen with mm_count padding patch. Will be attaching full ibs profile
>> data for all the 3 runs:
>>
>> # Base (v6.4-rc1)
>> Threads:
>> Total time: 11.486 [sec]
>>
>>     5.15%  sched-messaging  [kernel.vmlinux]      [k] __switch_to_asm
>>     4.31%  sched-messaging  [kernel.vmlinux]      [k] copyout
>>     4.29%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>     4.22%  sched-messaging  [kernel.vmlinux]      [k] copyin
>>     3.92%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
>>     2.91%  sched-messaging  [kernel.vmlinux]      [k] __schedule
>>     2.34%  swapper          [kernel.vmlinux]      [k] __switch_to_asm
>>     2.10%  sched-messaging  [kernel.vmlinux]      [k] prepare_to_wait_event
>>     2.10%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
>>     2.07%  sched-messaging  [kernel.vmlinux]      [k] finish_task_switch.isra.0
>>     2.00%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
>>     1.82%  sched-messaging  [kernel.vmlinux]      [k] check_preemption_disabled
>>     1.73%  sched-messaging  [kernel.vmlinux]      [k] exit_to_user_mode_prepare
>>     1.52%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
>>     1.49%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>>     1.45%  sched-messaging  libc.so.6             [.] write
>>     1.44%  swapper          [kernel.vmlinux]      [k] native_sched_clock
>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] psi_group_change
>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
>>     1.37%  sched-messaging  libc.so.6             [.] read
>>     1.06%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
>>     1.01%  swapper          [kernel.vmlinux]      [k] psi_group_change
>>     1.00%  sched-messaging  [kernel.vmlinux]      [k] update_curr
>>
>> # Base + mm_count_padding
>> Threads:
>> Total time: 11.384 [sec]
>>
>>     4.43%  sched-messaging  [kernel.vmlinux]         [k] copyin
>>     4.39%  sched-messaging  [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
>>     4.07%  sched-messaging  [kernel.vmlinux]         [k] apparmor_file_permission
>>     4.07%  sched-messaging  [kernel.vmlinux]         [k] copyout
>>     2.49%  sched-messaging  [kernel.vmlinux]         [k] entry_SYSCALL_64
>>     2.37%  sched-messaging  [kernel.vmlinux]         [k] update_cfs_group
>>     2.19%  sched-messaging  [kernel.vmlinux]         [k] pipe_write
>>     2.00%  sched-messaging  [kernel.vmlinux]         [k] check_preemption_disabled
>>     1.93%  swapper          [kernel.vmlinux]         [k] update_load_avg
>>     1.81%  sched-messaging  [kernel.vmlinux]         [k] exit_to_user_mode_prepare
>>     1.69%  sched-messaging  [kernel.vmlinux]         [k] try_to_wake_up
>>     1.58%  sched-messaging  libc.so.6                [.] write
>>     1.53%  sched-messaging  [kernel.vmlinux]         [k] psi_group_change
>>     1.50%  sched-messaging  libc.so.6                [.] read
>>     1.50%  sched-messaging  [kernel.vmlinux]         [k] pipe_read
>>     1.39%  sched-messaging  [kernel.vmlinux]         [k] update_load_avg
>>     1.39%  sched-messaging  [kernel.vmlinux]         [k] osq_lock
>>     1.30%  sched-messaging  [kernel.vmlinux]         [k] update_curr
>>     1.28%  swapper          [kernel.vmlinux]         [k] psi_group_change
>>     1.16%  sched-messaging  [kernel.vmlinux]         [k] vfs_read
>>     1.12%  sched-messaging  [kernel.vmlinux]         [k] vfs_write
>>     1.10%  sched-messaging  [kernel.vmlinux]         [k] entry_SYSRETQ_unsafe_stack
>>     1.09%  sched-messaging  [kernel.vmlinux]         [k] __switch_to_asm
>>     1.08%  sched-messaging  [kernel.vmlinux]         [k] do_syscall_64
>>     1.06%  sched-messaging  [kernel.vmlinux]         [k] select_task_rq_fair
>>     1.03%  swapper          [kernel.vmlinux]         [k] update_cfs_group
>>     1.00%  swapper          [kernel.vmlinux]         [k] rb_insert_color
>>
>> # Base + reverted_new_mm_cid
>> Threads:
>> Total time: 7.847 [sec]
>>
>>    12.14%  sched-messaging  [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>     8.86%  swapper          [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
>>     6.13%  sched-messaging  [kernel.vmlinux]      [k] copyin
>>     5.54%  sched-messaging  [kernel.vmlinux]      [k] apparmor_file_permission
>>     3.59%  sched-messaging  [kernel.vmlinux]      [k] copyout
>>     2.61%  sched-messaging  [kernel.vmlinux]      [k] osq_lock
>>     2.48%  sched-messaging  [kernel.vmlinux]      [k] pipe_write
>>     2.33%  sched-messaging  [kernel.vmlinux]      [k] exit_to_user_mode_prepare
>>     2.01%  sched-messaging  [kernel.vmlinux]      [k] check_preemption_disabled
>>     1.96%  sched-messaging  [kernel.vmlinux]      [k] __entry_text_start
>>     1.91%  sched-messaging  libc.so.6             [.] write
>>     1.77%  sched-messaging  libc.so.6             [.] read
>>     1.64%  sched-messaging  [kernel.vmlinux]      [k] mutex_spin_on_owner
>>     1.58%  sched-messaging  [kernel.vmlinux]      [k] pipe_read
>>     1.52%  sched-messaging  [kernel.vmlinux]      [k] try_to_wake_up
>>     1.38%  sched-messaging  [kernel.vmlinux]      [k] ktime_get_coarse_real_ts64
>>     1.35%  sched-messaging  [kernel.vmlinux]      [k] vfs_write
>>     1.28%  sched-messaging  [kernel.vmlinux]      [k] entry_SYSRETQ_unsafe_stack
>>     1.28%  sched-messaging  [kernel.vmlinux]      [k] vfs_read
>>     1.25%  sched-messaging  [kernel.vmlinux]      [k] do_syscall_64
>>     1.22%  sched-messaging  [kernel.vmlinux]      [k] __fget_light
>>     1.18%  sched-messaging  [kernel.vmlinux]      [k] mutex_lock
>>     1.12%  sched-messaging  [kernel.vmlinux]      [k] file_update_time
>>     1.04%  sched-messaging  [kernel.vmlinux]      [k] _copy_from_iter
>>     1.01%  sched-messaging  [kernel.vmlinux]      [k] current_time
>>
>> So with the reverted new_mm_cid patch, we are seeing a lot of time being spent in
>> native_queued_spin_lock_slowpath and yet, hackbench finishes faster.
>>
>> I keep further digging into this please let me know if you have any pointers for me.
> 
> Do you have CONFIG_SECURITY_APPARMOR=y ? Can you try without ?
>  
Sorry for the delay in response. My system was busy running some workloads. I tried
running hackbench disabling apparmor, looks like apparmor is not the culprit here.
Below are the results with apparmor disabled:

Test:                   Base            Base + Reverted_new_mmcid   Base+Apparmour_disabled
  1-groups:         2.81 (0.00 pct)         2.79 (0.71 pct)              2.79 (0.71 pct)
  2-groups:         3.25 (0.00 pct)         3.25 (0.00 pct)              3.20 (1.53 pct)
  4-groups:         3.44 (0.00 pct)         3.28 (4.65 pct)              3.43 (0.29 pct)
  8-groups:         3.52 (0.00 pct)         3.42 (2.84 pct)              3.53 (-0.28 pct)
16-groups:         5.65 (0.00 pct)         4.52 (20.00 pct)             5.67 (-0.35 pct)

Thanks,
Swapnil

> I notice that apparmor_file_permission appears near the top of your
> profiles, and apparmor uses an internal aa_buffers_lock spinlock,
> which could possibly explain the top hits for
> native_queued_spin_lock_slowpath. My current suspicion is that
> the raw spinlock that was taken by "Base + reverted_new_mm_cid"
> changed the contention pattern on the apparmor lock enough to
> speed things up by pure accident.
> 
> Thanks,
> 
> Mathieu
> 
> 
>>
>>>
>>> This patch has recently been merged into the mm tree.
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>> -- 
>> Thanks and Regards,
>> Swapnil
> 
