Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F557AF9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjI0E5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjI0E45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:56:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B172716
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjOFz0JUkcRV4kqSI4ruxN/nyTPqMburk9z1ZJB6dxdM5nWNwSBhvnAkDeZZ1uXqR44qRZ2MkrUM0W9TsT/jyWDnPWVolT3rlLM6eX/Ydn3LfS8ON01p7upOalFEjT5KbSSqMd+tofLTiUGk3WrmhW5AWP8V5QCuY0LRIW+/2799cykTcSfs6m7Ac+qjF88hX5YT9/DnVE/qNQoEZgh2qq/Gn4j5C5s4Ry6EF1rc0usMbQ7Vw5lCquuCz/W0tR/zJ7r64sb62dsUOWWDqqLymoYxiGbMIFRVwcndXERSHqY36PEJh/0oWpoaQcr+f4DH1IJWzc5Q+USuE9YZKZ4yFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYmK7WGVwrwOz1mQ+V0ZB0bWpsry3I8X2P8+UNwAyNA=;
 b=NeBUyB5aR/M0eDvOw7MFzA5kA3+rBsbr/Az2tC5f7n27Pj7zeyh105wTau4nvTv4X4DBED2zLJWZJQzUXJ0GYx2NZCslBQcsFqZq43hk4G7nOFZ7xY+YxNIxFmqWSGoVFC712CPPAdf1xzDxuydRQ0oIvTBK788HOfMzdDJ2uUjDJuZZaFPnk5HTtM3GlhCisKFj1CLOfn8heKaKtquO9XQaYL5uwbka6fmPArodrLNkCgJpcmLdjYGZ6pEUv46LM06rhjI7JJqduqqgSW2aahFYz7NA1bzQU0EFLBofdmHfK76hS1npU8B3e9Uod9XeelNxV03pMLmMTgDmZKDxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYmK7WGVwrwOz1mQ+V0ZB0bWpsry3I8X2P8+UNwAyNA=;
 b=5S6UCB8cI2CGWoJh/NVVAyMakMb2aqRnLN5x76ORC4rd9lDWQfPw01QvJigkaaJmSOdWwrrcWdDNdzDX08pUiRcwRESOwEzKqGSjC6CikTSYKjGZJm7VPPS8aHpxuKYnsM0770/yqjAIbN20vYyNxsaGDE3IpXgm3jMHcmAwlA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 04:23:30 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::6f68:739f:be07:cb78]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::6f68:739f:be07:cb78%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 04:23:30 +0000
Message-ID: <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
Date:   Wed, 27 Sep 2023 09:53:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230831191103.GC531917@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 1511baf6-1a30-4029-91cd-08dbbf11807f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Z7q6BAjvi8Z11mYcFCFxW452NzxVniHfRAdj+uD9v4lW91AUVBMy3MW/hH1vPCGH/LmIoLUwu8RFKbZ35XFmKFM/d9U3YrWUHP8bEwR2oIbNuMOaLNJOC9+zPQcvGOk9qlvKBuFsFPP6OrptcG4OfxSN8bchECQIQdVPPc8Rx+myw54PfcrDkc05PCHnJ5+j2Ts7xwIO+2yWNVNBuAnJNA+RSGQwAz8n7VoOx6P/Pzso65yoGBrVoiVqwD6yFvCLjlP4azFjFLeC9v6YkkuxEZ9lA3g9x6ZnSmUbgKjV7Ag0n31hEIzplmPbQD7NoeINCM1wHz/bZbJ1+H0SAWlIPkdb9Ual0GLurwLYNmwIfyiPFyEvsS8vqdQwBu0XmMxkZzyCSYiCe6rdsWETTrmOzOPz+l9zi8jKiefK9zrLbW7mnAyMrq1ISUVxCAi9DZQAabI/7g3GtsBxMRCCdHIxsurpDKig74phsSXx1RqhpKP7W843uIo44WMtWBhtQQMe2r3658jMypnoBEE984SNWoJ0QLXxVCghduuVYz027BWj6E+gNC/MFW6F4Lknov8n6++DYX/8RTVMsBgvbraQvlnPOPOaml5K2joQHxeGGdK/S/hY3AC2zdtDMG6dtRraY+fgET+MOT2bMCDx+kCKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(2616005)(5660300002)(31696002)(26005)(41300700001)(7416002)(2906002)(30864003)(38100700002)(86362001)(4326008)(36756003)(8936002)(478600001)(83380400001)(8676002)(53546011)(6666004)(6506007)(6486002)(6916009)(66946007)(6512007)(316002)(31686004)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3QwVUN5RWZuc29kc0pVclY4QlhrckV6L2pldC9EdzZERVB3NmdobW85blNr?=
 =?utf-8?B?NlFFbGorblJTaStTUzI1VUlGTy82ZG5QM2Ezbys0ejZ5UDlrSkFiRCtKSG5I?=
 =?utf-8?B?eHU4YXhEbVBRWGxibjRIc2xkOHlERllkUVdUeWpNeTNJdjU0ay9xUXJoSzBE?=
 =?utf-8?B?c2FmeWJzVXZEMFIyMWNQOEZMOTM2OVNPVmNiYTJNTTFoV1VmZHZMWCtUOXND?=
 =?utf-8?B?OWxRM1NjRTZKZ2VDY2FvWlBtd3ExdXJNU1VhUHRqZ01WbHBVNHdvTENZeHVX?=
 =?utf-8?B?eGZZQTY0Vy9JMm5hbUJnOEMrYjNEdEVnS1JPVzlTUmh3Z2FUR1BsTXduSzlE?=
 =?utf-8?B?VXlUUVZSc0U0d3pqK3AvUWVidDlWRVZVNFBNRjhhVm1MUWVNMDNzRGtMSTJT?=
 =?utf-8?B?dXNZVEtYSFRCRDFhd1BSVkNJYjd5SkswTjYxdHhGamt0azEzK3ltUHVqTWRx?=
 =?utf-8?B?Q0dXVnlpUkJlV2l1K0dyQzVrRWRaWlQweUlCNzZaZmI0VDZCS3VLclIyMlJJ?=
 =?utf-8?B?dmJqdTlWVjUzbHNNcTBxMGpIY0pORkdYVGlhMGQ5YmlLdWZzNjdNQVo2YVVT?=
 =?utf-8?B?STFTQWF3Rno3SDRwQ0xzNXNKQnJJWXVxazZNQWR6Skl3N1pIL1BrS04xQm5D?=
 =?utf-8?B?WEN2aVJLRzVjbmd1V1JWb2tpM0pQZkhBelpseDdJc0dwUkJXU0Y3amVaamx5?=
 =?utf-8?B?dU9pMm1pMlZHNmxaenZCaUJ1UmJHWlVPOEpVSnlKT0FsN1VxODlpd2hsTitI?=
 =?utf-8?B?eXhOODA0V2h0WGhsKy9JcjNGYUZ4NC9hWWlnUzN1ZG4reGUvNjBkV1hLMVNS?=
 =?utf-8?B?SFA2U0RGWno0eDV0YUdoWDY1cmlBdnZTRXFmMU9peVA0eExWSmUxRFhjMElV?=
 =?utf-8?B?b3ZKUVN5VUMxdGVaTDlVdDg1Ty9QSGN3Wkd3TjNWdC8xU2x4cEw1Q2o4Q1lh?=
 =?utf-8?B?Q0x5Y3oxTFBTdWZkQy85NjQ3S0ZsNTFjbjFxVE9pSkNSK0VNZU5Na2lLdElZ?=
 =?utf-8?B?aDAxMUlTdFRGU1JwWkc5TUdZa2diTVBmVloxNEw3NmtndWdrdGVoTWQydEIv?=
 =?utf-8?B?MkpucFFSSzZmcU9ZUzYvdk11eFJyZWdMRzloakcya2NSdFludmJ5THRRV05O?=
 =?utf-8?B?Wk41QXd0Qk9vTEF4SHlVdUxoMy9WZS82M1loa29DRVc0cWFsMTBvVVJMZ3or?=
 =?utf-8?B?V3FLaGRjckZ2SjFUTGFwNnc5N2xJeXpVblMyejl0dzNFM3pvQmxFbDNzYzF0?=
 =?utf-8?B?R3A0cjlXdFdycTMyS3lhUjgvOXR6cTdybDRvWFJnU3VrTnY5MGoxVllWUU9s?=
 =?utf-8?B?ZVNKR1VrUzFDVEttUTlwSDVhTS9QSjdRVy9zL0FaM0piVjNORGlJWVB6SXlu?=
 =?utf-8?B?NnVJeGdSZXJiOWJFa3I3Nk5SaGUxQW54OXZYK1JITDgyZ3lzNW8rTzhKOTZR?=
 =?utf-8?B?TXgxWUtXZ1FILzRTU0ZxNE1YNnE2a1FVR1JjMmdvY3U2OU1LNG5XWHBSZnpm?=
 =?utf-8?B?TjM5R0xrZCtlRXhXZHNmakNPUlFEay9ZdVI2VzFSQkNnSlU2TUlQUW5oTS84?=
 =?utf-8?B?RjVrMUJIY0xiYU9zRVZMTEdXdFNGUEFtMStibHZTMDBYdDdSVE9Zem1UWnpr?=
 =?utf-8?B?UFdjVVR1eWZiQ3N4VGtjWmRjM2t4aTF3Q1RIK1ZVbEphSUJHQ2lhcGFmK3pD?=
 =?utf-8?B?WHFmeGNvbi9YRVVnTTVFcnJtazVtNGVrMnN6QnMxMnZmM3FNV1pJeVVGbWIv?=
 =?utf-8?B?eHpuSkZadWFiRTZtRFdOdlZPL3FzbkJObS93N0U4SmdkUFR6MzlmNnJQdzAx?=
 =?utf-8?B?NFp2VVlhQVZxc1A0WDYrR2Q5RTVFUjJYcEdqeGl5TUVuWlFzMHlCVXpObktL?=
 =?utf-8?B?T0ZYdE02L2h0d1VtMDJZdW9FdEdxdmFQb3NLazhOQUoxclk2VWZ6MW10Qk9C?=
 =?utf-8?B?VE5PWW9RZXplbFBUWmRYcjBwamJiaTY2ZUJzOW5tckN6Zzc1ZVBoWkVoUkF1?=
 =?utf-8?B?VzFpbDNuMU10cER0NmxmdkZIRENGOElrRU5aYVU5bnhPa2oyK1AzTHJVRHpJ?=
 =?utf-8?B?a09xK2pqUG1LVmZKMWoxV0lRS3BCYWFSMVEvVnVFSkhQb3MvaVRGSWhxRDJ2?=
 =?utf-8?Q?EEOKw2djxI+/vf8XluLIakkDX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1511baf6-1a30-4029-91cd-08dbbf11807f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 04:23:29.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOv6KZ2x62zkN1+Gj6udV9xoR4TNov3MrBRhGl8seDv+XBkuuzmcZuPRzXaBOb0zzRMnhkMrgzyyy6IWpgc1bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Some more test results (although this might be slightly irrelevant with
next version around the corner)

On 9/1/2023 12:41 AM, David Vernet wrote:
> On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> 
> Hi Prateek,
> 
>> Even with the two patches, I still observe the following lock
>> contention when profiling the tbench 128-clients run with IBS:
>>
>>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
>>      - 10.94% native_queued_spin_lock_slowpath
>>         - 10.73% _raw_spin_lock
>>            - 9.57% __schedule
>>                 schedule_idle
>>                 do_idle
>>               + cpu_startup_entry
>>            - 0.82% task_rq_lock
>>                 newidle_balance
>>                 pick_next_task_fair
>>                 __schedule
>>                 schedule_idle
>>                 do_idle
>>               + cpu_startup_entry
>>
>> Since David mentioned rq->avg_idle check is probably not the right step
>> towards the solution, this experiment introduces a per-shard
>> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
>> notifies of the possibility of one or more rq covered in the shard's
>> domain having a queued task. shard's overload flag is set at the same
>> time as "rq->rd->overload", and is cleared when shard's list is found
>> to be empty.
> 
> I think this is an interesting idea, but I feel that it's still working
> against the core proposition of SHARED_RUNQ, which is to enable work
> conservation.
> 
I have some more numbers. This time I'm accounting the cost for peeking
into the shared-runq and have two variants - one that keeps the current
vanilla flow from your v3 and the other that moves the rq->avg_idle
check before looking at the shared-runq. Following are the results:

-> Without EEVDF

o tl;dr

- With avg_idle check, the improvements observed with shared-runq
  aren't as large but they are still noticeable.

- Most regressions are gone nad the others aren't as bad with the
  introduction of shared-runq

o Kernels

base			: tip is at commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs bandwidth in use")
shared_runq		: base + correct time accounting with v3 of the series without any other changes
shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
			  (the rd->overload check still remains below the shared_runq access)

o Benchmarks

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           base[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.64)     0.90 [ 10.20]( 8.79)             0.93 [  7.08]( 3.87)
 2-groups     1.00 [ -0.00]( 2.97)     0.85 [ 15.06]( 4.86)             0.96 [  4.47]( 2.22)
 4-groups     1.00 [ -0.00]( 1.84)     0.93 [  7.38]( 2.63)             0.94 [  6.07]( 1.02)
 8-groups     1.00 [ -0.00]( 1.24)     0.97 [  2.83]( 2.69)             0.98 [  1.82]( 1.01)
16-groups     1.00 [ -0.00]( 3.31)     1.03 [ -2.93]( 2.46)             1.02 [ -1.61]( 1.34)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:   base[pct imp](CV)     shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
    1     1.00 [  0.00]( 1.08)     0.98 [ -1.89]( 0.48)              0.99 [ -0.73]( 0.70)
    2     1.00 [  0.00]( 0.69)     0.99 [ -1.48]( 0.24)              0.98 [ -1.62]( 0.85)
    4     1.00 [  0.00]( 0.70)     0.97 [ -2.87]( 1.34)              0.98 [ -2.15]( 0.48)
    8     1.00 [  0.00]( 0.85)     0.97 [ -3.17]( 1.56)              0.99 [ -1.32]( 1.09)
   16     1.00 [  0.00]( 2.18)     0.91 [ -8.70]( 0.27)              0.98 [ -2.03]( 1.28)
   32     1.00 [  0.00]( 3.84)     0.51 [-48.53]( 2.52)              1.01 [  1.41]( 3.83)
   64     1.00 [  0.00]( 7.06)     0.38 [-62.49]( 1.89)              1.05 [  5.33]( 4.09)
  128     1.00 [  0.00]( 0.88)     0.41 [-58.92]( 0.28)              1.01 [  0.54]( 1.65)
  256     1.00 [  0.00]( 0.88)     0.97 [ -2.56]( 1.78)              1.00 [ -0.48]( 0.33)
  512     1.00 [  0.00]( 0.07)     1.00 [  0.06]( 0.04)              0.98 [ -1.51]( 0.44)
 1024     1.00 [  0.00]( 0.30)     0.99 [ -1.35]( 0.90)              1.00 [ -0.24]( 0.41)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      base[pct imp](CV)      shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
 Copy     1.00 [  0.00]( 8.87)     1.00 [  0.31]( 5.27)                1.09 [  9.11]( 0.58)
Scale     1.00 [  0.00]( 6.80)     0.99 [ -0.81]( 7.20)                1.00 [  0.49]( 5.67)
  Add     1.00 [  0.00]( 7.24)     0.99 [ -1.13]( 7.02)                1.02 [  2.06]( 6.36)
Triad     1.00 [  0.00]( 5.00)     0.96 [ -4.11]( 9.37)                1.03 [  3.46]( 4.41)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      base[pct imp](CV)     shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
 Copy     1.00 [  0.00]( 0.45)     1.00 [  0.32]( 1.88)              1.04 [  4.02]( 1.45)
Scale     1.00 [  0.00]( 4.40)     0.98 [ -1.76]( 6.46)              1.01 [  1.28]( 1.00)
  Add     1.00 [  0.00]( 4.97)     0.98 [ -1.85]( 6.01)              1.03 [  2.75]( 0.24)
Triad     1.00 [  0.00]( 0.24)     0.96 [ -3.82]( 6.41)              0.99 [ -1.10]( 4.47)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:        base[pct imp](CV)      shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.46)     0.98 [ -2.37]( 0.08)              0.99 [ -1.32]( 0.37)
 2-clients     1.00 [  0.00]( 0.75)     0.98 [ -2.04]( 0.33)              0.98 [ -1.57]( 0.50)
 4-clients     1.00 [  0.00]( 0.84)     0.97 [ -3.25]( 1.01)              0.99 [ -0.77]( 0.54)
 8-clients     1.00 [  0.00]( 0.78)     0.96 [ -4.18]( 0.68)              0.99 [ -0.77]( 0.63)
16-clients     1.00 [  0.00]( 2.56)     0.84 [-15.71]( 6.33)              1.00 [ -0.35]( 0.58)
32-clients     1.00 [  0.00]( 1.03)     0.35 [-64.92]( 8.90)              0.98 [ -1.92]( 1.67)
64-clients     1.00 [  0.00]( 2.69)     0.26 [-74.05]( 6.56)              0.98 [ -2.46]( 2.42)
128-clients    1.00 [  0.00]( 1.91)     0.25 [-74.81]( 3.67)              0.99 [ -1.50]( 2.15)
256-clients    1.00 [  0.00]( 2.21)     0.92 [ -7.73]( 2.29)              0.98 [ -1.51]( 1.85)
512-clients    1.00 [  0.00](45.18)     0.96 [ -4.06](52.89)              0.98 [ -2.49](49.22)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:        base[pct imp](CV)     shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
  1             1.00 [ -0.00](12.03)     1.04 [ -4.35](34.64)              1.13 [-13.04]( 2.25)
  2             1.00 [ -0.00]( 9.36)     1.00 [ -0.00]( 4.56)              1.12 [-11.54](12.83)
  4             1.00 [ -0.00]( 1.95)     1.00 [ -0.00](13.36)              0.93 [  6.67]( 9.10)
  8             1.00 [ -0.00]( 9.01)     0.97 [  2.70]( 4.68)              1.03 [ -2.70](12.11)
 16             1.00 [ -0.00]( 3.08)     1.02 [ -2.00]( 3.01)              1.00 [ -0.00]( 7.33)
 32             1.00 [ -0.00]( 0.75)     1.03 [ -2.60]( 8.20)              1.09 [ -9.09]( 4.24)
 64             1.00 [ -0.00]( 2.15)     0.91 [  9.20]( 1.03)              1.01 [ -0.61]( 7.14)
128             1.00 [ -0.00]( 5.18)     1.05 [ -4.57]( 7.74)              1.01 [ -0.57]( 5.62)
256             1.00 [ -0.00]( 4.18)     1.06 [ -5.87](51.02)              1.10 [ -9.51](15.82)
512             1.00 [ -0.00]( 2.10)     1.03 [ -3.36]( 2.88)              1.06 [ -5.87]( 1.10)


==================================================================
Test          : Unixbench
Units         : Various, Throughput
Interpretation: Higher is better
Statistic     : AMean, Hmean (Specified)
==================================================================
                                                base                  shared_runq             shared_runq_idle_check
Hmean     unixbench-dhry2reg-1            41407024.82 (   0.00%)    41211208.57 (  -0.47%)     41354094.87 (  -0.13%)
Hmean     unixbench-dhry2reg-512        6249629291.88 (   0.00%)  6245782129.00 (  -0.06%)   6236514875.97 (  -0.21%)
Amean     unixbench-syscall-1              2922580.63 (   0.00%)     2928021.57 *  -0.19%*      2895742.17 *   0.92%*
Amean     unixbench-syscall-512            7606400.73 (   0.00%)     8390396.33 * -10.31%*      8236409.00 *  -8.28%*
Hmean     unixbench-pipe-1                 2574942.54 (   0.00%)     2610825.75 *   1.39%*      2531492.38 *  -1.69%*
Hmean     unixbench-pipe-512             364489246.31 (   0.00%)   366388360.22 *   0.52%*    360160487.66 *  -1.19%*
Hmean     unixbench-spawn-1                   4428.94 (   0.00%)        4391.20 (  -0.85%)         4541.06 (   2.53%)
Hmean     unixbench-spawn-512                68883.47 (   0.00%)       69143.38 (   0.38%)        69776.01 *   1.30%*
Hmean     unixbench-execl-1                   3878.47 (   0.00%)        3861.63 (  -0.43%)         3873.96 (  -0.12%)
Hmean     unixbench-execl-512                11638.84 (   0.00%)       12758.38 *   9.62%*        14001.23 *  20.30%*


==================================================================
Test          : ycsb-mongodb
Units         : Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
tip                     : 1.00 (var: 1.41%)
shared_runq             : 0.99 (var: 0.84%)  (diff: -1.40%)
shared_runq_idle_check  : 1.00 (var: 0.79%)  (diff:  0.00%)


==================================================================
Test          : DeathStarBench
Units         : %diff, relative to base
Interpretation: Higher is better
Statistic     : AMean
==================================================================
pinning      scaling   eevdf   shared_runq    shared_runq_idle_check
1CDD            1       0%       -0.39%              -0.09%
2CDD            2       0%       -0.31%              -1.73%
4CDD            4       0%        3.28%               0.60%
8CDD            8       0%        4.35%               2.98% 
 

-> With EEVDF

o tl;dr

- Same as what was observed without EEVDF  but shared_runq shows
  serious regression with multiple more variants of tbench and
  netperf now.

o Kernels

eevdf			: tip:sched/core at commit b41bbb33cf75 ("Merge branch 'sched/eevdf' into sched/core")
shared_runq		: eevdf + correct time accounting with v3 of the series without any other changes
shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
			  (the rd->overload check still remains below the shared_runq access)

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:          eevdf[pct imp](CV)    shared_runq[pct imp](CV)  shared_runq_idle_check[pct imp](CV)
 1-groups     1.00 [ -0.00]( 1.89)     0.95 [  4.72]( 8.98)         0.99 [  0.83]( 3.77)
 2-groups     1.00 [ -0.00]( 2.04)     0.86 [ 13.87]( 2.59)         0.95 [  4.92]( 1.98)
 4-groups     1.00 [ -0.00]( 2.38)     0.96 [  4.50]( 3.44)         0.98 [  2.45]( 1.93)
 8-groups     1.00 [ -0.00]( 1.52)     1.01 [ -0.95]( 1.36)         0.96 [  3.97]( 0.89)
16-groups     1.00 [ -0.00]( 3.44)     1.00 [ -0.00]( 1.59)         0.96 [  3.91]( 3.36)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:  eevdf[pct imp](CV)    shared_runq[pct imp](CV)  shared_runq_idle_check[pct imp](CV)
    1     1.00 [  0.00]( 0.18)     1.00 [  0.15]( 0.59)         0.98 [ -1.76]( 0.74)
    2     1.00 [  0.00]( 0.63)     0.97 [ -3.44]( 0.91)         0.98 [ -1.93]( 1.27)
    4     1.00 [  0.00]( 0.86)     0.95 [ -4.86]( 0.85)         0.99 [ -1.15]( 0.77)
    8     1.00 [  0.00]( 0.22)     0.94 [ -6.44]( 1.31)         0.99 [ -1.00]( 0.97)
   16     1.00 [  0.00]( 1.99)     0.86 [-13.68]( 0.38)         1.00 [ -0.47]( 0.99)
   32     1.00 [  0.00]( 4.29)     0.48 [-52.21]( 0.53)         1.01 [  1.24]( 6.66)
   64     1.00 [  0.00]( 1.71)     0.35 [-64.68]( 0.44)         0.99 [ -0.66]( 0.70)
  128     1.00 [  0.00]( 0.65)     0.40 [-60.32]( 0.95)         0.98 [ -2.15]( 1.25)
  256     1.00 [  0.00]( 0.19)     0.72 [-28.28]( 1.88)         0.99 [ -1.39]( 2.50)
  512     1.00 [  0.00]( 0.20)     0.79 [-20.59]( 4.40)         1.00 [ -0.42]( 0.38)
 1024     1.00 [  0.00]( 0.29)     0.80 [-20.24]( 0.64)         0.99 [ -0.51]( 0.20)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:     eevdf[pct imp](CV)    shared_runq[pct imp](CV)   shared_runq_idle_check[pct imp](CV)
 Copy     1.00 [  0.00]( 4.32)     0.94 [ -6.40]( 8.05)          1.01 [  1.39]( 4.58)
Scale     1.00 [  0.00]( 5.21)     0.98 [ -2.15]( 6.79)          0.95 [ -4.54]( 7.35)
  Add     1.00 [  0.00]( 6.25)     0.97 [ -2.64]( 6.47)          0.97 [ -3.08]( 7.49)
Triad     1.00 [  0.00](10.74)     1.01 [  0.92]( 7.40)          1.01 [  1.25]( 8.76)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:     eevdf[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
 Copy     1.00 [  0.00]( 0.70)     1.00 [ -0.07]( 0.70)         1.00 [  0.47]( 0.94)
Scale     1.00 [  0.00]( 6.55)     1.02 [  1.72]( 4.83)         1.03 [  2.96]( 1.00)
  Add     1.00 [  0.00]( 6.53)     1.02 [  1.53]( 4.77)         1.03 [  3.19]( 0.90)
Triad     1.00 [  0.00]( 6.66)     1.00 [  0.06]( 6.29)         0.99 [ -0.70]( 5.79)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:       eevdf[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.46)     1.02 [  1.73]( 0.31)           0.99 [ -0.81]( 0.24)
 2-clients     1.00 [  0.00]( 0.38)     0.99 [ -0.68]( 1.17)           0.99 [ -0.87]( 0.45)
 4-clients     1.00 [  0.00]( 0.72)     0.97 [ -3.38]( 1.38)           0.99 [ -1.26]( 0.47)
 8-clients     1.00 [  0.00]( 0.98)     0.94 [ -6.30]( 1.84)           1.00 [ -0.44]( 0.45)
16-clients     1.00 [  0.00]( 0.70)     0.56 [-44.08]( 5.11)           0.99 [ -0.83]( 0.49)
32-clients     1.00 [  0.00]( 0.74)     0.35 [-64.92]( 1.98)           0.98 [ -2.14]( 2.14)
64-clients     1.00 [  0.00]( 2.24)     0.26 [-73.79]( 5.72)           0.97 [ -2.57]( 2.44)
128-clients    1.00 [  0.00]( 1.72)     0.25 [-74.91]( 6.72)           0.96 [ -3.66]( 1.48)
256-clients    1.00 [  0.00]( 4.44)     0.68 [-31.60]( 5.42)           0.96 [ -3.61]( 3.64)
512-clients    1.00 [  0.00](52.42)     0.67 [-32.81](48.45)           0.96 [ -3.80](55.24)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:   eevdf[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
  1         1.00 [ -0.00]( 2.28)     1.00 [ -0.00]( 6.19)          0.84 [ 16.00](20.83)
  2         1.00 [ -0.00]( 6.42)     0.89 [ 10.71]( 2.34)          0.96 [  3.57]( 4.17)
  4         1.00 [ -0.00]( 3.77)     0.97 [  3.33]( 7.35)          1.00 [ -0.00]( 9.12)
  8         1.00 [ -0.00](13.83)     1.03 [ -2.63]( 6.96)          0.95 [  5.26]( 6.93)
 16         1.00 [ -0.00]( 4.37)     1.02 [ -2.13]( 4.17)          1.02 [ -2.13]( 3.53)
 32         1.00 [ -0.00]( 8.69)     0.96 [  3.70]( 5.23)          0.98 [  2.47]( 4.43)
 64         1.00 [ -0.00]( 2.30)     0.96 [  3.85]( 2.34)          0.92 [  7.69]( 4.14)
128         1.00 [ -0.00](12.12)     0.97 [  3.12]( 3.31)          0.93 [  6.53]( 5.31)
256         1.00 [ -0.00](26.04)     1.87 [-86.57](33.02)          1.63 [-62.73](40.63)
512         1.00 [ -0.00]( 5.62)     1.04 [ -3.80]( 0.35)          1.09 [ -8.78]( 2.56)
 
==================================================================
Test          : Unixbench
Units         : Various, Throughput
Interpretation: Higher is better
Statistic     : AMean, Hmean (Specified)
==================================================================

                                             eevdf                   shared_runq             shared_runq_idle_check
Hmean     unixbench-dhry2reg-1            41248390.97 (   0.00%)    41245183.04 (  -0.01%)    41297801.58 (   0.12%)
Hmean     unixbench-dhry2reg-512        6239969914.15 (   0.00%)  6236534715.56 (  -0.06%)  6237356670.12 (  -0.04%)
Amean     unixbench-syscall-1              2968518.27 (   0.00%)     2893792.10 *   2.52%*     2799609.00 *   5.69%*
Amean     unixbench-syscall-512            7790656.20 (   0.00%)     8489302.67 *  -8.97%*     7685974.47 *   1.34%*
Hmean     unixbench-pipe-1                 2535689.01 (   0.00%)     2554662.39 *   0.75%*     2521853.23 *  -0.55%*
Hmean     unixbench-pipe-512             361385055.25 (   0.00%)   365752991.35 *   1.21%*   358310503.28 *  -0.85%*
Hmean     unixbench-spawn-1                   4506.26 (   0.00%)        4566.00 (   1.33%)        4242.52 *  -5.85%*
Hmean     unixbench-spawn-512                69380.09 (   0.00%)       69554.52 (   0.25%)       69413.14 (   0.05%)
Hmean     unixbench-execl-1                   3824.57 (   0.00%)        3782.82 *  -1.09%*        3832.10 (   0.20%)
Hmean     unixbench-execl-512                12288.64 (   0.00%)       13248.40 (   7.81%)       12661.78 (   3.04%)
 
==================================================================
Test          : ycsb-mongodb
Units         : Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
eevdf                   : 1.00 (var: 1.41%)
shared_runq             : 0.98 (var: 0.84%)  (diff: -2.40%)
shared_runq_idle_check  : 0.97 (var: 0.79%)  (diff: -3.06%)


==================================================================
Test          : DeathStarBench
Units         : %diff, relative to eevdf
Interpretation: Higher is better
Statistic     : AMean
==================================================================
pinning      scaling   eevdf   shared_runq    shared_runq_idle_check
1CDD            1       0%       -0.85%             -1.56%
2CDD            2       0%       -0.60%             -1.22%
4CDD            4       0%        2.87%              0.02%
8CDD            8       0%        0.36%              1.57%


--
Thanks and Regards,
Prateek
