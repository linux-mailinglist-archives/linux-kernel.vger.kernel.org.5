Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C743179DFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjIMGPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjIMGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:15:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8A1730
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzLaKtEQ91HsR9LNEr5Sws90dqRxH2jaTGhjMXTaASvHtc1aWwVvWD6kNM8n4G3hlsLFtJuvwdllpNkfIJPnP6s0I5J3/kCd39A5nowsfuN7YUYBRE5EgDjDnGBkeTZ+EU0+NWCll8XizFLckzBWzXy1I9OqNXUBZh1rYaqwzRZHi6XplAZAQFkY/wf8VpTUGTnFE7Y2W2AgqQ90w9fwyfy0JjGO66kfS8qP+q1/HJw/4xRnCiMKu5+wb926Tmgef7xDdb12Bh+Xhsx53YeR9XkxlFFdLr2sL6i2I/tYUjz97Ak321xvPgjrOip8AVsr7L/5vGj1DIRlVRC9g2rMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg+3vzTzcmpz8hO8eSlnV3EgNw9ckVjfGKfh8qLMrCA=;
 b=b0Vm0gIZI67wkGgGUfNJyUik+rkSHlHE9YyriQWq3MRJ3VhoqEoakF+AAgifnyoqd8ybCaFuL3kkWbOcGmi/U4s31aned2aP6fudFfskHz8lo7915efK+ORNsR06Cj/12GcMz2qkl9Y8apHqO9YIopdReCnmxqlXGFWrc4aYChSRgKZb7MDppCl77rHhjwn3Xc0wPms5nhRgnHSdd6kmvf8rGSmIR2FRcR2Ub9PJV73zQiEDRs9eGLA6HUwymG5FxDqqKmVvj/CrqIcPuAw7n/Wb8AYJ88jC28srGJ1Bd8a4uNMYo3pFJlqmVRq8QCRYKy5L5YYT29wmDIOJ0CvALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg+3vzTzcmpz8hO8eSlnV3EgNw9ckVjfGKfh8qLMrCA=;
 b=MGiNWdNEGH+y7J70sN246wQiYUn9VJRM69K7bkvM3Pf/+dhtLea+/Q0cPzC7dLOuadqkOJihdVbCAlf05b6yI7Vk1osSaftT75HzJiDcH57rZh1wXtksrXTjvcfPbARkDdD5A5dXBel6RuvM3MVHp5zPcgXGbVh6PkyBqMobnmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 06:15:38 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:15:37 +0000
Message-ID: <ccd04a6b-20fb-9cac-ad59-215a552df81f@amd.com>
Date:   Wed, 13 Sep 2023 11:45:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 4/6] sched/numa: Increase tasks' access history
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <202309122114.b9e08a43-oliver.sang@intel.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <202309122114.b9e08a43-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::6) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c4ae2b-5069-473a-510a-08dbb420d883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+LTJZEh1EYv22nTsLQOhs/4Z6gG/bCF1aYa6VobkSL8jA/sgmgFRzqGGkJ+Sam0p5SWdv99izcaIpWHDLds/BmDtMuKT/LVuKlMGc/JX0u5Eq3PGqyM7DofcT0pcUTe8rEL7ZDg3wUr6ORGXQrKw38d4WuW1TWd3E96JaMvZx6nQUx2PkDSM2a8Q54Hua7xomy42NwmuUTMM9/QucdQNcJzwqM5lsJ61lZxakmBvhOkF41Ioqy47RXIyas7E6HBO0LFNu7blO0+8NoRn3RPWakTZXxWJHqySpzg9oIUxjKaSp7Ux/yZGEVVFFzaDJ/8CwbEFyLfMJglDbXGD6XjG4CTN8H4jKzsdtv3lrKSrXE3J2WABCksJRtuXoxyx/xjPar2ehbqo25Sncq3WlW5uhAteXZO213NLBJjNZOHfihwp3ud2NqA7QGmuJyvqAZVpdFWmkl1WropOqM6i8D4Cm/0AlNnJrAtPHXo/L0yh73Z4M/SjVsN9CnMw8D6XCKCynqYyAjgbKSJ0tdOq/j2WF1rcWVN3e/LdSOPpkKrzLL7T6B0FaB4gLYo5DOvhV1o+x1xE/sGfgNe3wdxJllUDpklYaB8RSUmc4iTvnOoLKIdqxBp/2hgIW9kET2IZNBo9IOVU7m2DEDa96LfRZacdAM5F53kB3pjsaO9ELzG8Z4Tp7Wd6wE0Axgxvjy/bKm4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(186009)(1800799009)(451199024)(7416002)(6506007)(6486002)(41300700001)(53546011)(478600001)(316002)(36756003)(30864003)(2906002)(31696002)(66946007)(966005)(6916009)(38100700002)(66476007)(54906003)(6666004)(66556008)(8936002)(4326008)(8676002)(31686004)(26005)(2616005)(83380400001)(6512007)(5660300002)(45980500001)(43740500002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRIbVFaVGh5NHZ1djhqT0hKTTBwSHFBa3BRaHBuTHpTNDR1R3RwdC9wRm11?=
 =?utf-8?B?b21CQnZrVGdPK0ZFTlFQTjJLQWZnelBwYmdJNlNQUWlsY01FMWRsWHgyNHJO?=
 =?utf-8?B?Qm5xMGIzRUVTZ3REZ1AycjVmblVzSmxDTXZnZi9BdmN6VDF4WUVidkttdThU?=
 =?utf-8?B?TXkyUTFTNERib0dUNUFpNFRmRDUzK2NURlBpSlcxYk9TSXFzaU0zZm4rUVor?=
 =?utf-8?B?WUdvTWlGZm9aV0dvMUw4ZnNTNDVOY3lBQ2l0N3RmSTZjcnkyQ2ZUdGpzT0lL?=
 =?utf-8?B?WUc3b3pGZDBtak5WRlVJK2Z6Q2I3RXZLMWpJZjZFeGNMWHZDL1lNWUVRcFpS?=
 =?utf-8?B?ckRlUWRTbmJ4MzkvdktKaG44SFcrN1Rub0FkSmg5OWJ1V2FjVWxiV3I0S3V0?=
 =?utf-8?B?UDNpQ09iQXlBaUxlV1F5M3BjcXRlcktZaEViRXVHNkE5anVyeEFyemRBdTh5?=
 =?utf-8?B?R2dwUFJXMlRIeXJNZXhaSmhwdXRBUzA0UnJjOUJTZXNPZFBqc1hNcFpsbGha?=
 =?utf-8?B?Ymh3NkN4YytHQWVSalNEdkY0QndXTkhsSkNLQ3NqMkFEOG5CajFMRHYvbkpX?=
 =?utf-8?B?UDRTZHU2UGFUUzhUek9CNlYrYWlkM1V3VndKdk5GbFNLTjZuTEcxYzhSaXpt?=
 =?utf-8?B?RU5odnhwWWNJNEF6dlZKemZGcS8ycVo4RmUyMC9QZ2p2NW9GZXc0d0IzUFlz?=
 =?utf-8?B?RmFFUDNWbVlPVkZqWkZEWjloME1QQXRnYXEyMXYxRG01bmUvbFMxREU1aHB3?=
 =?utf-8?B?S2FzRnhjTHAybUJmZTlSelpLQ3Yyb25VK1lML2s0LytaZU9uTXlOTnRzSTBH?=
 =?utf-8?B?OFhNR1puT0QrWUgvRE1KWmh0bmUrbUVoTEFOV1dRcGxWdDZINXNpWDZGVFNl?=
 =?utf-8?B?YVI1aGZISEhud1M0WW9GcEVyV1Y5NEVnbnYrSzBmYUNYOFpNK2xLUW1RZ01o?=
 =?utf-8?B?STNnRDkvbFpVUWJ2MEJtQ2wzM1VXS3I3UnVkRWY2bGV5cXNQNGZad0x4eXoz?=
 =?utf-8?B?TG5Zb2RoRG1haVZ5NkpwTXlIWFNkcVBrRVU0TnZVV0dxMVFjb25GcmpXTGxX?=
 =?utf-8?B?cTUwcUdwQXVlMUVqRk1MQnZ1U1A5bWVoVmNHaDNCL2RzV3hRNWkvcmtKNk5O?=
 =?utf-8?B?ZkV4TVVYczJxaHFLV3RJL00xOFdWOElZRGJORXBORDBwT2VvMzE4bVg0WllQ?=
 =?utf-8?B?OFg5TmdCSkFqN0lGbGxsbFdzYmI1UCtZUFVrS2J5WTRuN2NrMmVLcTRMTUR3?=
 =?utf-8?B?OTFRYmMwOWljYzg2S2ZpKy8xQ0J2TFd4Rk0xS1pwNGRxa3hLb1ZEb3hmS1VU?=
 =?utf-8?B?YXpRWW52cW16dVBFc0puZHp0Mm5FbnhITUxYQlBOdUFiTXM0b0lSWTRoSTFX?=
 =?utf-8?B?M0tFNjB0TEJYSXhqdnJvamlrVWVudG03RVNaeHNDVHQrUmJJR25IaXQ5Rkto?=
 =?utf-8?B?eDA1c28xT3kzUTBrdTVqYm9GWW8ybHhLTkIycWJWMmhQRjVZQ043Rm0vVXRX?=
 =?utf-8?B?a2paQ2JzRUJlRDk1KzhVZjA0NGx4WVo2ZHhpSGJCSzZ2Vlp6ekxwSWoyUGRX?=
 =?utf-8?B?RlRjdzk3V3lHUVdvSzd4c3dyNVFtQkRweHB0dHFNSEZTSW5RRW5DVWNmM0s4?=
 =?utf-8?B?a2xtSzVpaU9rdjNSTjB3SmFLdGM2U2RGTjVYdHdydzlNYUVOTitaY2xkcGRR?=
 =?utf-8?B?V1F4aFVTMmlDRGt5R0VyNWRLSDZtc2FWM3k5OWgzOHJaYjZWbnBEUjJPeklO?=
 =?utf-8?B?akU3dmQxdnpleFNvYjRITWZOaFQwbjMrUDRYb3kyZFFlanI2NU1Ccngzb0xs?=
 =?utf-8?B?SjZ0WDlHMklaMG8rUzN1SXoyWGV6aFNoYW5pY25uUmc0QWI1NlBvbWFpK2dT?=
 =?utf-8?B?MWJWcEpGWlR6QWVLQVNPWWZvR1Ftc0ZjUkk4QVl5Z1MvTkxaVC9JUkZ2K3Bi?=
 =?utf-8?B?L3NldDF5UVhMOXFuM014Y2RTSVF0WGtZblJEWUx6eWlaazJQMnRaWUpRU3l4?=
 =?utf-8?B?dU0zcTRQSjhWQmV0QzcrTFRiT2xkZlVVV3FvclQzcjExNldSaXp5V1dUSyt1?=
 =?utf-8?B?bkdXclRLNkI2ZUZXUXhDb3ZwdnIyRjJCUXN2TE1UcHFBOWpSN3pMamhtcFdE?=
 =?utf-8?Q?MrG0Yt9kt3SkNEgOl77cpJIbH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c4ae2b-5069-473a-510a-08dbb420d883
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:15:37.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF5TJi07On2iuE35HEaYDBNfSzAK4+9Ok1fcOeq7CCQ+YtvIhVZXwtn1igAUudqz+XapeRClMmLMHvKROJKehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 7:54 PM, kernel test robot wrote:
> 
> 
> hi, Raghu,
> 
> hope this third performance report for same one patch-set won't annoy you,
> and better, have some value to you.

Not at all. But thanks a lot and am rather more happy to see this
exhaustive results.

Because: It is easy to show see that patchset is increasing readability
of code or maintainance of code etc.,
while I try my best to see regressions are within noise level for some
corner cases and some benchmarks have improved noticeably, there is
always a room to miss something.
Reports like this, helps to boost confidence on patchset.

Also your cumulative (bisection) report also helped to evaluate
importance of each patch too..

> 
> we won't send more autonuma-benchmark performance improvement reports for this
> patch-set, of course, unless you still hope we do.
> 
> BTW, we will still send out performance/function regression reports if any.
> 
> as in previous reports, we know that you want to see the performance impact
> of whole patch set, so let me give a full summary here:
> 
> let me list how we apply your patch set again:
> 
> 68cfe9439a1ba (linux-review/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007) sched/numa: Allow scanning of shared VMAs
> af46f3c9ca2d1 sched/numa: Allow recently accessed VMAs to be scanned  <-- we reported [1]
> 167773d1ddb5f sched/numa: Increase tasks' access history   <---- for this report
> fc769221b2306 sched/numa: Remove unconditional scan logic using mm numa_scan_seq
> 1ef5cbb92bdb3 sched/numa: Add disjoint vma unconditional scan logic  <--- we reported [2]
> 2a806eab1c2e1 sched/numa: Move up the access pid reset logic
> 2f88c8e802c8b (tip/sched/core) sched/eevdf/doc: Modify the documented knob to base_slice_ns as well
> 
> [1] https://lore.kernel.org/all/202309102311.84b42068-oliver.sang@intel.com/
> [2] https://lore.kernel.org/all/202309121417.53f44ad6-oliver.sang@intel.com/
> 
> below will only give out the comparison between 2f88c8e802c8b and 68cfe9439a1ba
> in a summary way, if you want detail data for more commits, or more comparison
> data, please let me know. Thanks!
> 
> on
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> 
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> 2f88c8e802c8b128 68cfe9439a1baa642e05883fa64
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      271.01           -26.4%     199.49 ±  3%  autonuma-benchmark.numa01.seconds
>       76.28           -46.9%      40.49 ±  5%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>        8.11            -0.1%       8.10        autonuma-benchmark.numa02.seconds
>        1425           -30.1%     996.02 ±  2%  autonuma-benchmark.time.elapsed_time
>        1425           -30.1%     996.02 ±  2%  autonuma-benchmark.time.elapsed_time.max
> 
> 
> on
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> 2f88c8e802c8b128 68cfe9439a1baa642e05883fa64
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      361.53 ±  6%     -10.4%     323.83 ±  3%  autonuma-benchmark.numa01.seconds
>      255.31           -60.1%     101.90 ±  2%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>       14.95            -4.6%      14.26        autonuma-benchmark.numa02.seconds
>        2530 ±  3%     -30.3%       1763 ±  2%  autonuma-benchmark.time.elapsed_time
>        2530 ±  3%     -30.3%       1763 ±  2%  autonuma-benchmark.time.elapsed_time.max
> 
>

This gives me fair confidence that we are able to get a decent
improvement overall.

> below is the auto-generated report part, FYI.
> 
> Hello,
> 
> kernel test robot noticed a -17.6% improvement of autonuma-benchmark.numa01.seconds on:
> 
> 
> commit: 167773d1ddb5ffdd944f851f2cbdd4e65425a358 ("[RFC PATCH V1 4/6] sched/numa: Increase tasks' access history")
> url: https://github.com/intel-lab-lkp/linux/commits/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2f88c8e802c8b128a155976631f4eb2ce4f3c805
> patch link: https://lore.kernel.org/all/cf200aaf594caae68350219fa1f781d64136fa2c.1693287931.git.raghavendra.kt@amd.com/
> patch subject: [RFC PATCH V1 4/6] sched/numa: Increase tasks' access history
> 
> testcase: autonuma-benchmark
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> parameters:
> 
> 	iterations: 4x
> 	test: numa01_THREAD_ALLOC
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | autonuma-benchmark: autonuma-benchmark.numa01.seconds -15.4% improvement                           |
> | test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | iterations=4x                                                                                      |
> |                  | test=numa01_THREAD_ALLOC                                                                           |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | autonuma-benchmark: autonuma-benchmark.numa01.seconds -14.8% improvement                           |
> | test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | iterations=4x                                                                                      |
> |                  | test=_INVERSE_BIND                                                                                 |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | autonuma-benchmark: autonuma-benchmark.numa01_THREAD_ALLOC.seconds -10.7% improvement              |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory     |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | iterations=4x                                                                                      |
> |                  | test=numa01_THREAD_ALLOC                                                                           |
> +------------------+----------------------------------------------------------------------------------------------------+
> 
> 

Will go through this too.

> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230912/202309122114.b9e08a43-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> commit:
>    fc769221b2 ("sched/numa: Remove unconditional scan logic using mm numa_scan_seq")
>    167773d1dd ("sched/numa: Increase tasks' access history")
> 
> fc769221b23064c0 167773d1ddb5ffdd944f851f2cb
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      105.67 ±  8%     -20.3%      84.17 ± 10%  perf-c2c.HITM.remote
>   1.856e+10 ±  7%     -18.8%  1.508e+10 ±  8%  cpuidle..time
>    19025348 ±  7%     -18.6%   15481744 ±  8%  cpuidle..usage
>        0.00 ± 28%      +0.0        0.01 ± 10%  mpstat.cpu.all.iowait%
>        0.10 ±  2%      -0.0        0.09 ±  4%  mpstat.cpu.all.soft%
>        1443 ±  2%     -14.2%       1238 ±  4%  uptime.boot
>       26312 ±  5%     -12.8%      22935 ±  5%  uptime.idle
>     8774783 ±  7%     -19.0%    7104495 ±  8%  turbostat.C1E
>    10147966 ±  7%     -18.4%    8280745 ±  8%  turbostat.C6
>   3.225e+08 ±  2%     -14.1%   2.77e+08 ±  4%  turbostat.IRQ
>        2.81 ± 24%      +3.5        6.35 ± 24%  turbostat.PKG_%
>      638.24            +2.0%     650.74        turbostat.PkgWatt
>       57.57           +10.9%      63.85 ±  2%  turbostat.RAMWatt
>      271.39 ±  2%     -17.6%     223.53 ±  5%  autonuma-benchmark.numa01.seconds
>        1401 ±  2%     -14.6%       1197 ±  4%  autonuma-benchmark.time.elapsed_time
>        1401 ±  2%     -14.6%       1197 ±  4%  autonuma-benchmark.time.elapsed_time.max
>     1088153 ±  2%     -14.1%     934904 ±  6%  autonuma-benchmark.time.involuntary_context_switches
>        3953            -2.6%       3852 ±  2%  autonuma-benchmark.time.system_time
>      287110           -14.5%     245511 ±  4%  autonuma-benchmark.time.user_time
>       22704 ±  7%     +15.9%      26303 ±  8%  autonuma-benchmark.time.voluntary_context_switches
>      191.10 ± 64%     +94.9%     372.49 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>        4.09 ± 49%     +85.6%       7.59 ± 14%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>        1.99 ± 40%     +99.8%       3.97 ± 30%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
>       14.18 ±158%     -82.6%       2.47 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
>      189.39 ± 65%     +96.5%     372.20 ±  7%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>        2.18 ± 21%     -33.3%       1.46 ± 41%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
>        3.22 ± 32%     -73.0%       0.87 ± 81%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
>        4.73 ± 20%     +60.6%       7.59 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>        9.61 ± 30%     -32.8%       6.46 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       13.57 ± 65%     -60.2%       5.40 ± 24%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
>     6040567            -6.2%    5667640        proc-vmstat.numa_hit
>       32278 ±  7%     +51.7%      48955 ± 18%  proc-vmstat.numa_huge_pte_updates
>     4822780            -7.5%    4459553        proc-vmstat.numa_local
>     3187796 ±  9%     +73.2%    5521800 ± 16%  proc-vmstat.numa_pages_migrated
>    16792299 ±  7%     +50.8%   25319315 ± 18%  proc-vmstat.numa_pte_updates
>     6242814            -8.5%    5711173 ±  2%  proc-vmstat.pgfault
>     3187796 ±  9%     +73.2%    5521800 ± 16%  proc-vmstat.pgmigrate_success
>      254872 ±  2%     -12.3%     223591 ±  5%  proc-vmstat.pgreuse
>        6151 ±  9%     +74.2%      10717 ± 16%  proc-vmstat.thp_migration_success
>     4201550           -13.7%    3627350 ±  3%  proc-vmstat.unevictable_pgs_scanned
>   1.823e+08 ±  2%     -15.2%  1.547e+08 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.avg
>   1.872e+08 ±  2%     -15.3%  1.585e+08 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
>   1.423e+08 ±  4%     -14.0%  1.224e+08 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
>     4320209 ±  8%     -18.1%    3537344 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
>        3349 ± 40%     +58.3%       5300 ± 27%  sched_debug.cfs_rq:/.load_avg.max
>   1.823e+08 ±  2%     -15.2%  1.547e+08 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
>   1.872e+08 ±  2%     -15.3%  1.585e+08 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
>   1.423e+08 ±  4%     -14.0%  1.224e+08 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
>     4320208 ±  8%     -18.1%    3537344 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
>     1852009 ±  3%     -13.2%    1607461 ±  2%  sched_debug.cpu.avg_idle.avg
>      751880 ±  2%     -15.1%     638555 ±  4%  sched_debug.cpu.avg_idle.stddev
>      725827 ±  2%     -14.1%     623617 ±  4%  sched_debug.cpu.clock.avg
>      726857 ±  2%     -14.1%     624498 ±  4%  sched_debug.cpu.clock.max
>      724740 ±  2%     -14.1%     622692 ±  4%  sched_debug.cpu.clock.min
>      717315 ±  2%     -14.1%     616349 ±  4%  sched_debug.cpu.clock_task.avg
>      719648 ±  2%     -14.1%     618089 ±  4%  sched_debug.cpu.clock_task.max
>      698681 ±  2%     -14.2%     599424 ±  4%  sched_debug.cpu.clock_task.min
>        1839 ±  8%     -18.1%       1506 ±  7%  sched_debug.cpu.clock_task.stddev
>       27352            -9.6%      24731 ±  2%  sched_debug.cpu.curr->pid.max
>      293258 ±  5%     -16.4%     245303 ±  7%  sched_debug.cpu.max_idle_balance_cost.stddev
>      -14.96           +73.6%     -25.98        sched_debug.cpu.nr_uninterruptible.min
>        6.27 ±  4%     +18.7%       7.44 ±  6%  sched_debug.cpu.nr_uninterruptible.stddev
>      724723 ±  2%     -14.1%     622678 ±  4%  sched_debug.cpu_clk
>      723514 ±  2%     -14.1%     621468 ±  4%  sched_debug.ktime
>      725604 ±  2%     -14.1%     623550 ±  4%  sched_debug.sched_clk
>       29.50 ±  3%     +24.9%      36.83 ±  9%  perf-stat.i.MPKI
>   3.592e+08            +5.7%  3.797e+08 ±  2%  perf-stat.i.branch-instructions
>     1823514            +3.7%    1891464        perf-stat.i.branch-misses
>    28542234 ±  3%     +22.0%   34809605 ± 10%  perf-stat.i.cache-misses
>    72486859 ±  3%     +19.6%   86713561 ±  7%  perf-stat.i.cache-references
>      224.48            +3.2%     231.63        perf-stat.i.cpu-migrations
>      145250 ±  2%     -10.8%     129549 ±  4%  perf-stat.i.cycles-between-cache-misses
>        0.08 ±  5%      -0.0        0.07 ± 10%  perf-stat.i.dTLB-load-miss-rate%
>      272123 ±  6%     -15.0%     231302 ± 10%  perf-stat.i.dTLB-load-misses
>   4.515e+08            +4.7%  4.729e+08 ±  2%  perf-stat.i.dTLB-loads
>      995784            +1.9%    1014848        perf-stat.i.dTLB-store-misses
>   1.844e+08            +1.5%  1.871e+08        perf-stat.i.dTLB-stores
>   1.711e+09            +5.0%  1.797e+09 ±  2%  perf-stat.i.instructions
>        3.25            +8.3%       3.52 ±  3%  perf-stat.i.metric.M/sec
>        4603            +6.7%       4912 ±  3%  perf-stat.i.minor-faults
>      488266 ±  2%     +25.0%     610436 ±  6%  perf-stat.i.node-load-misses
>      618022 ±  4%     +13.4%     701130 ±  5%  perf-stat.i.node-loads
>        4603            +6.7%       4912 ±  3%  perf-stat.i.page-faults
>       39.67 ±  2%     +16.0%      46.04 ±  6%  perf-stat.overall.MPKI
>      375.84            -4.9%     357.36 ±  2%  perf-stat.overall.cpi
>       24383 ±  3%     -19.0%      19742 ± 12%  perf-stat.overall.cycles-between-cache-misses
>        0.06 ±  7%      -0.0        0.05 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
>        0.00            +5.2%       0.00 ±  2%  perf-stat.overall.ipc
>       41.99 ±  2%      +2.8       44.83 ±  4%  perf-stat.overall.node-load-miss-rate%
>   3.355e+08            +6.3%  3.567e+08 ±  2%  perf-stat.ps.branch-instructions
>     1758832            +4.4%    1835699        perf-stat.ps.branch-misses
>    24888631 ±  3%     +25.6%   31268733 ± 12%  perf-stat.ps.cache-misses
>    64007362 ±  3%     +22.5%   78424799 ±  8%  perf-stat.ps.cache-references
>      221.69            +3.0%     228.32        perf-stat.ps.cpu-migrations
>   4.273e+08            +5.2%  4.495e+08 ±  2%  perf-stat.ps.dTLB-loads
>      992569            +1.8%    1010389        perf-stat.ps.dTLB-store-misses
>   1.818e+08            +1.6%  1.847e+08        perf-stat.ps.dTLB-stores
>   1.613e+09            +5.5%  1.701e+09 ±  2%  perf-stat.ps.instructions
>        4331            +7.2%       4644 ±  3%  perf-stat.ps.minor-faults
>      477740 ±  2%     +26.3%     603330 ±  7%  perf-stat.ps.node-load-misses
>      660610 ±  5%     +12.3%     741896 ±  6%  perf-stat.ps.node-loads
>        4331            +7.2%       4644 ±  3%  perf-stat.ps.page-faults
>   2.264e+12           -10.0%  2.038e+12 ±  3%  perf-stat.total.instructions
>        1.16 ± 20%      -0.6        0.59 ± 47%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>        1.07 ± 20%      -0.5        0.54 ± 47%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>        1.96 ± 25%      -0.7        1.27 ± 23%  perf-profile.children.cycles-pp.task_mm_cid_work
>        1.16 ± 20%      -0.5        0.67 ± 19%  perf-profile.children.cycles-pp.worker_thread
>        1.07 ± 20%      -0.5        0.61 ± 21%  perf-profile.children.cycles-pp.process_one_work
>        0.84 ± 44%      -0.4        0.43 ± 25%  perf-profile.children.cycles-pp.evlist__id2evsel
>        0.58 ± 34%      -0.2        0.33 ± 21%  perf-profile.children.cycles-pp.do_mprotect_pkey
>        0.54 ± 26%      -0.2        0.30 ± 23%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
>        0.54 ± 26%      -0.2        0.30 ± 23%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
>        0.58 ± 34%      -0.2        0.34 ± 22%  perf-profile.children.cycles-pp.__x64_sys_mprotect
>        0.34 ± 23%      -0.2        0.12 ± 64%  perf-profile.children.cycles-pp.drm_gem_vmap_unlocked
>        0.34 ± 23%      -0.2        0.12 ± 64%  perf-profile.children.cycles-pp.drm_gem_vmap
>        0.34 ± 23%      -0.2        0.12 ± 64%  perf-profile.children.cycles-pp.drm_gem_shmem_object_vmap
>        0.34 ± 23%      -0.2        0.12 ± 64%  perf-profile.children.cycles-pp.drm_gem_shmem_vmap_locked
>        0.55 ± 32%      -0.2        0.33 ± 18%  perf-profile.children.cycles-pp.__wp_page_copy_user
>        0.50 ± 35%      -0.2        0.28 ± 21%  perf-profile.children.cycles-pp.mprotect_fixup
>        0.28 ± 25%      -0.2        0.08 ±101%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages_locked
>        0.28 ± 25%      -0.2        0.08 ±101%  perf-profile.children.cycles-pp.drm_gem_get_pages
>        0.28 ± 25%      -0.2        0.08 ±102%  perf-profile.children.cycles-pp.shmem_read_folio_gfp
>        0.28 ± 25%      -0.2        0.08 ±102%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages
>        0.62 ± 15%      -0.2        0.43 ± 16%  perf-profile.children.cycles-pp.try_to_wake_up
>        0.25 ± 19%      -0.2        0.08 ± 84%  perf-profile.children.cycles-pp.drm_client_buffer_vmap
>        0.44 ± 19%      -0.2        0.28 ± 31%  perf-profile.children.cycles-pp.filemap_get_entry
>        0.39 ± 14%      -0.1        0.26 ± 22%  perf-profile.children.cycles-pp.perf_event_mmap
>        0.38 ± 13%      -0.1        0.25 ± 23%  perf-profile.children.cycles-pp.perf_event_mmap_event
>        0.22 ± 22%      -0.1        0.11 ± 25%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>        0.24 ± 21%      -0.1        0.14 ± 36%  perf-profile.children.cycles-pp.do_open_execat
>        0.24 ± 13%      -0.1        0.14 ± 42%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>        0.22 ± 30%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.wake_up_q
>        0.14 ± 17%      -0.1        0.05 ±101%  perf-profile.children.cycles-pp.open_exec
>        0.16 ± 21%      -0.1        0.07 ± 51%  perf-profile.children.cycles-pp.path_init
>        0.23 ± 30%      -0.1        0.15 ± 22%  perf-profile.children.cycles-pp.ttwu_do_activate
>        0.26 ± 11%      -0.1        0.18 ± 20%  perf-profile.children.cycles-pp.perf_iterate_sb
>        0.14 ± 50%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.security_inode_getattr
>        0.18 ± 27%      -0.1        0.11 ± 20%  perf-profile.children.cycles-pp.select_task_rq
>        0.14 ± 21%      -0.1        0.08 ± 29%  perf-profile.children.cycles-pp.get_unmapped_area
>        0.10 ± 19%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.expand_downwards
>        0.18 ± 16%      -0.1        0.13 ± 26%  perf-profile.children.cycles-pp.__d_alloc
>        0.09 ± 15%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.anon_vma_clone
>        0.13 ± 36%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.file_free_rcu
>        0.08 ± 23%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.__legitimize_mnt
>        0.09 ± 15%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__pipe
>        1.92 ± 26%      -0.7        1.24 ± 23%  perf-profile.self.cycles-pp.task_mm_cid_work
>        0.82 ± 43%      -0.4        0.42 ± 24%  perf-profile.self.cycles-pp.evlist__id2evsel
>        0.42 ± 39%      -0.2        0.22 ± 19%  perf-profile.self.cycles-pp.evsel__read_counter
>        0.27 ± 24%      -0.2        0.10 ± 56%  perf-profile.self.cycles-pp.filemap_get_entry
>        0.15 ± 48%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.ksys_read
>        0.10 ± 34%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.enqueue_task_fair
>        0.13 ± 36%      -0.1        0.08 ± 19%  perf-profile.self.cycles-pp.file_free_rcu
> 
> 
> ***************************************************************************************************
> lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp3/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> commit:
>    fc769221b2 ("sched/numa: Remove unconditional scan logic using mm numa_scan_seq")
>    167773d1dd ("sched/numa: Increase tasks' access history")
> 
> fc769221b23064c0 167773d1ddb5ffdd944f851f2cb
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>   2.309e+10 ±  6%     -27.8%  1.668e+10 ±  5%  cpuidle..time
>    23855797 ±  6%     -27.9%   17210884 ±  5%  cpuidle..usage
>        2514           -11.9%       2215        uptime.boot
>       27543 ±  5%     -23.1%      21189 ±  5%  uptime.idle
>        9.80 ±  5%      -1.8        8.05 ±  6%  mpstat.cpu.all.idle%
>        0.01 ±  6%      +0.0        0.01 ± 17%  mpstat.cpu.all.iowait%
>        0.08            -0.0        0.07 ±  2%  mpstat.cpu.all.soft%
>      845597 ± 12%     -26.1%     624549 ± 19%  numa-numastat.node0.other_node
>     2990301 ±  6%     -13.1%    2598273 ±  4%  numa-numastat.node1.local_node
>      471614 ± 21%     +45.0%     684016 ± 18%  numa-numastat.node1.other_node
>      845597 ± 12%     -26.1%     624549 ± 19%  numa-vmstat.node0.numa_other
>        4073 ±106%     -82.5%     711.67 ± 23%  numa-vmstat.node1.nr_mapped
>     2989568 ±  6%     -13.1%    2597798 ±  4%  numa-vmstat.node1.numa_local
>      471614 ± 21%     +45.0%     684016 ± 18%  numa-vmstat.node1.numa_other
>      375.07 ±  4%     -15.4%     317.31 ±  2%  autonuma-benchmark.numa01.seconds
>        2462           -12.2%       2162        autonuma-benchmark.time.elapsed_time
>        2462           -12.2%       2162        autonuma-benchmark.time.elapsed_time.max
>     1354545           -12.9%    1179617        autonuma-benchmark.time.involuntary_context_switches
>     3212023            -6.5%    3001966        autonuma-benchmark.time.minor_page_faults
>        8377            +2.3%       8572        autonuma-benchmark.time.percent_of_cpu_this_job_got
>      199714           -10.4%     179020        autonuma-benchmark.time.user_time
>       50675 ±  8%     -19.0%      41038 ± 12%  turbostat.C1
>      183835 ±  7%     -17.6%     151526 ±  6%  turbostat.C1E
>    23556011 ±  6%     -28.0%   16965247 ±  5%  turbostat.C6
>        9.72 ±  5%      -1.7        7.99 ±  6%  turbostat.C6%
>        9.54 ±  6%     -18.1%       7.81 ±  6%  turbostat.CPU%c1
>   2.404e+08           -12.0%  2.116e+08        turbostat.IRQ
>      280.51            +1.2%     283.99        turbostat.PkgWatt
>       63.94            +6.7%      68.23        turbostat.RAMWatt
>      282375 ±  3%      -9.8%     254565 ±  7%  proc-vmstat.numa_hint_faults
>      217705 ±  6%     -12.6%     190234 ±  8%  proc-vmstat.numa_hint_faults_local
>     7081835            -7.9%    6524239        proc-vmstat.numa_hit
>      107927 ± 10%     +16.6%     125887        proc-vmstat.numa_huge_pte_updates
>     5764595            -9.5%    5215673        proc-vmstat.numa_local
>     7379523 ± 15%     +25.7%    9272505 ±  4%  proc-vmstat.numa_pages_migrated
>    55530575 ± 10%     +16.5%   64669707        proc-vmstat.numa_pte_updates
>     8852860            -9.3%    8028738        proc-vmstat.pgfault
>     7379523 ± 15%     +25.7%    9272505 ±  4%  proc-vmstat.pgmigrate_success
>      393902            -9.6%     356099        proc-vmstat.pgreuse
>       14358 ± 15%     +25.8%      18064 ±  5%  proc-vmstat.thp_migration_success
>    18273792           -11.5%   16166144        proc-vmstat.unevictable_pgs_scanned
>    1.45e+08            -8.7%  1.325e+08        sched_debug.cfs_rq:/.avg_vruntime.max
>     3995873           -14.0%    3437625 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.stddev
>        0.23 ±  3%      -8.6%       0.21 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
>    1.45e+08            -8.7%  1.325e+08        sched_debug.cfs_rq:/.min_vruntime.max
>     3995873           -14.0%    3437625 ±  2%  sched_debug.cfs_rq:/.min_vruntime.stddev
>        0.53 ± 71%    +195.0%       1.56 ± 37%  sched_debug.cfs_rq:/.removed.load_avg.avg
>       25.54 ±  2%     +13.0%      28.87        sched_debug.cfs_rq:/.removed.load_avg.max
>        3.40 ± 35%     +85.6%       6.32 ± 17%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>        0.16 ± 74%    +275.6%       0.59 ± 39%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>        8.03 ± 31%     +84.9%      14.84        sched_debug.cfs_rq:/.removed.runnable_avg.max
>        1.02 ± 44%    +154.3%       2.59 ± 16%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>        0.16 ± 74%    +275.6%       0.59 ± 39%  sched_debug.cfs_rq:/.removed.util_avg.avg
>        8.03 ± 31%     +84.9%      14.84        sched_debug.cfs_rq:/.removed.util_avg.max
>        1.02 ± 44%    +154.3%       2.59 ± 16%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>      146.33 ±  4%     -12.0%     128.80 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
>      361281 ±  5%     -13.6%     312127 ±  3%  sched_debug.cpu.avg_idle.stddev
>     1229022            -9.9%    1107544        sched_debug.cpu.clock.avg
>     1229436            -9.9%    1107919        sched_debug.cpu.clock.max
>     1228579            -9.9%    1107137        sched_debug.cpu.clock.min
>      248.12 ±  6%      -8.9%     226.15 ±  2%  sched_debug.cpu.clock.stddev
>     1201071            -9.7%    1084858        sched_debug.cpu.clock_task.avg
>     1205361            -9.7%    1088445        sched_debug.cpu.clock_task.max
>     1190139            -9.7%    1074355        sched_debug.cpu.clock_task.min
>      156325 ±  4%     -21.3%     123055 ±  3%  sched_debug.cpu.max_idle_balance_cost.stddev
>        0.00 ±  5%      -8.8%       0.00 ±  2%  sched_debug.cpu.next_balance.stddev
>        0.23 ±  3%      -6.9%       0.21 ±  4%  sched_debug.cpu.nr_running.stddev
>       22855           -11.9%      20146 ±  2%  sched_debug.cpu.nr_switches.avg
>        0.00 ± 74%    +301.6%       0.00 ± 41%  sched_debug.cpu.nr_uninterruptible.avg
>      -20.99           +50.9%     -31.67        sched_debug.cpu.nr_uninterruptible.min
>     1228564            -9.9%    1107124        sched_debug.cpu_clk
>     1227997            -9.9%    1106556        sched_debug.ktime
>        0.00 ± 70%     +66.1%       0.00        sched_debug.rt_rq:.rt_nr_migratory.avg
>        0.02 ± 70%     +66.1%       0.03        sched_debug.rt_rq:.rt_nr_migratory.max
>        0.00 ± 70%     +66.1%       0.00        sched_debug.rt_rq:.rt_nr_migratory.stddev
>        0.00 ± 70%     +66.1%       0.00        sched_debug.rt_rq:.rt_nr_running.avg
>        0.02 ± 70%     +66.1%       0.03        sched_debug.rt_rq:.rt_nr_running.max
>        0.00 ± 70%     +66.1%       0.00        sched_debug.rt_rq:.rt_nr_running.stddev
>     1229125            -9.9%    1107673        sched_debug.sched_clk
>       36.73            +9.2%      40.12        perf-stat.i.MPKI
>   1.156e+08            +0.9%  1.166e+08        perf-stat.i.branch-instructions
>        1.41            +0.1        1.49        perf-stat.i.branch-miss-rate%
>     1755317            +6.4%    1868497        perf-stat.i.branch-misses
>       65.90            +2.6       68.53        perf-stat.i.cache-miss-rate%
>    13292768           +13.0%   15016556        perf-stat.i.cache-misses
>    20180664            +9.2%   22041180        perf-stat.i.cache-references
>        1620            -2.0%       1588        perf-stat.i.context-switches
>      492.61            +2.2%     503.60        perf-stat.i.cpi
>   2.624e+11            +2.3%  2.685e+11        perf-stat.i.cpu-cycles
>       20261            -9.6%      18315        perf-stat.i.cycles-between-cache-misses
>        0.08 ±  5%      -0.0        0.07        perf-stat.i.dTLB-load-miss-rate%
>      114641 ±  5%      -6.6%     107104        perf-stat.i.dTLB-load-misses
>        0.24            +0.0        0.25        perf-stat.i.dTLB-store-miss-rate%
>      202887            +3.4%     209829        perf-stat.i.dTLB-store-misses
>      479259 ±  2%      -9.8%     432243 ±  6%  perf-stat.i.iTLB-load-misses
>      272948 ±  5%     -16.4%     228065 ±  3%  perf-stat.i.iTLB-loads
>   5.888e+08            +0.8%  5.938e+08        perf-stat.i.instructions
>        1349           +15.8%       1561 ±  2%  perf-stat.i.instructions-per-iTLB-miss
>        2.73            +2.3%       2.80        perf-stat.i.metric.GHz
>        3510            +2.9%       3612        perf-stat.i.minor-faults
>      302696 ±  4%      +8.0%     327055        perf-stat.i.node-load-misses
>     5025469 ±  3%     +16.0%    5831348 ±  2%  perf-stat.i.node-store-misses
>     6419781           +11.7%    7171575        perf-stat.i.node-stores
>        3510            +2.9%       3613        perf-stat.i.page-faults
>       34.43            +8.1%      37.21        perf-stat.overall.MPKI
>        1.51            +0.1        1.59        perf-stat.overall.branch-miss-rate%
>       66.31            +2.2       68.53        perf-stat.overall.cache-miss-rate%
>       19793            -9.3%      17950        perf-stat.overall.cycles-between-cache-misses
>        0.07 ±  5%      -0.0        0.07        perf-stat.overall.dTLB-load-miss-rate%
>        0.23            +0.0        0.24        perf-stat.overall.dTLB-store-miss-rate%
>        1227 ±  2%     +12.1%       1376 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
>     1729818            +6.4%    1840962        perf-stat.ps.branch-misses
>    13346402           +12.6%   15031113        perf-stat.ps.cache-misses
>    20127330            +9.0%   21934543        perf-stat.ps.cache-references
>        1624            -2.1%       1590        perf-stat.ps.context-switches
>   2.641e+11            +2.1%  2.698e+11        perf-stat.ps.cpu-cycles
>      113287 ±  5%      -6.8%     105635        perf-stat.ps.dTLB-load-misses
>      203569            +3.2%     210036        perf-stat.ps.dTLB-store-misses
>      476376 ±  2%      -9.8%     429901 ±  6%  perf-stat.ps.iTLB-load-misses
>      259293 ±  5%     -16.3%     217088 ±  3%  perf-stat.ps.iTLB-loads
>        3465            +3.1%       3571        perf-stat.ps.minor-faults
>      299695 ±  4%      +8.3%     324433        perf-stat.ps.node-load-misses
>     5044747 ±  3%     +15.7%    5834322 ±  2%  perf-stat.ps.node-store-misses
>     6459846           +11.3%    7189821        perf-stat.ps.node-stores
>        3465            +3.1%       3571        perf-stat.ps.page-faults
>    1.44e+12           -11.4%  1.275e+12        perf-stat.total.instructions
>        0.47 ± 58%    +593.5%       3.27 ± 81%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
>        0.37 ±124%    +352.3%       1.67 ± 58%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
>        0.96 ± 74%     -99.0%       0.01 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
>        2.01 ± 79%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
>        1.35 ± 72%     -69.8%       0.41 ± 80%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
>        0.17 ± 18%     -26.5%       0.13 ±  5%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>        0.26 ± 16%     -39.0%       0.16 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>        2.57 ± 65%   +1027.2%      28.92 ±120%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
>        0.38 ±119%    +669.3%       2.92 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
>        0.51 ±141%    +234.9%       1.71 ± 69%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_binary
>        1.63 ± 74%     -98.9%       0.02 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
>        3.38 ± 12%     -55.7%       1.50 ± 78%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
>        2.37 ± 68%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
>        2.05 ± 62%     -68.1%       0.65 ± 93%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
>        9.09 ±119%     -96.0%       0.36 ± 42%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>        3.86 ± 40%     -50.1%       1.93 ± 30%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>        2.77 ± 78%     -88.0%       0.33 ± 29%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>        2.48 ± 60%     -86.1%       0.34 ±  7%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       85.92 ± 73%     +97.7%     169.86 ± 31%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       95.98 ±  6%      -9.5%      86.82 ±  4%  perf-sched.total_wait_and_delay.average.ms
>       95.30 ±  6%      -9.6%      86.19 ±  4%  perf-sched.total_wait_time.average.ms
>      725.88 ± 28%     -73.5%     192.63 ±141%  perf-sched.wait_and_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>        2.22 ± 42%     -76.2%       0.53 ±141%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>        4.02 ±  5%     -31.9%       2.74 ± 19%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>      653.51 ±  9%     -13.3%     566.43 ±  7%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>      775.33 ±  4%     -19.8%     621.67 ± 13%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       88.33 ± 14%     -16.6%      73.67 ± 11%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>        6.28 ± 19%     -73.5%       1.67 ±141%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>        1286 ±  3%     -65.6%     442.66 ± 91%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>      222.90 ± 16%     +53.8%     342.84 ± 30%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>        0.91 ± 70%   +7745.7%      71.06 ±129%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
>       21.65 ± 34%     +42.0%      30.75 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
>        2.67 ± 26%     -96.6%       0.09 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
>      725.14 ± 28%     -73.5%     192.24 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>        2.87 ± 28%     -96.7%       0.09 ± 77%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
>        2.10 ± 73%   +4020.9%      86.55 ±135%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
>        1.96 ± 73%     -94.8%       0.10 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
>        3.24 ± 21%     -65.0%       1.13 ± 69%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
>      338.18 ±140%    -100.0%       0.07 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
>       21.80 ±122%     -94.7%       1.16 ±130%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
>        4.29 ± 11%     -66.2%       1.45 ±118%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.mprotect_fixup
>        0.94 ±126%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>        3.69 ± 29%     -72.9%       1.00 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
>        0.04 ±141%   +6192.3%       2.73 ± 63%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       32.86 ±128%     -95.2%       1.57 ± 12%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>        3.96 ±  5%     -33.0%       2.66 ± 19%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>        7.38 ± 57%     -89.8%       0.75 ± 88%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
>      643.25 ±  9%     -12.8%     560.82 ±  8%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>        2.22 ± 74%  +15121.1%     338.52 ±138%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
>        4.97 ± 39%     -98.2%       0.09 ±141%  perf-sched.wait_time.max.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
>        3.98           -96.1%       0.16 ± 94%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
>        4.28 ±  3%     -66.5%       1.44 ±126%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
>        3.95 ± 14%    +109.8%       8.28 ± 45%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>        2.04 ± 74%     -95.0%       0.10 ±141%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
>      340.63 ±140%    -100.0%       0.12 ±141%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
>        4.74 ± 22%     -68.4%       1.50 ±117%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.mprotect_fixup
>        1.30 ±141%    +205.8%       3.99        perf-sched.wait_time.max.ms.__cond_resched.mmput.m_stop.seq_read_iter.seq_read
>        1.42 ±131%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>      337.62 ±140%     -99.6%       1.33 ±141%  perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
>        4.91 ± 27%   +4797.8%     240.69 ± 69%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>        4.29 ±  7%     -76.7%       1.00 ±141%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
>        0.05 ±141%   +5358.6%       2.77 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>      338.90 ±138%     -98.8%       3.95        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>        1284 ±  3%     -68.7%     401.56 ±106%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>        7.38 ± 57%     -89.8%       0.75 ± 88%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
>       20.80 ± 72%     -20.8        0.00        perf-profile.calltrace.cycles-pp.__cmd_record
>       20.80 ± 72%     -20.8        0.00        perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
>       20.78 ± 72%     -20.8        0.00        perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
>       20.74 ± 72%     -20.7        0.00        perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
>       20.43 ± 72%     -20.4        0.00        perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
>       20.03 ± 72%     -20.0        0.00        perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
>       19.84 ± 72%     -19.8        0.00        perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
>        0.77 ± 26%      +0.2        1.00 ± 13%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>        0.73 ± 26%      +0.3        1.00 ± 21%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.74 ± 18%      +0.3        1.07 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>        0.73 ± 18%      +0.3        1.07 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>        0.78 ± 36%      +0.3        1.11 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
>        0.44 ± 73%      +0.3        0.77 ± 14%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
>        0.78 ± 36%      +0.3        1.12 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__fxstat64
>        0.76 ± 17%      +0.3        1.10 ± 19%  perf-profile.calltrace.cycles-pp.write
>        0.81 ± 34%      +0.4        1.16 ± 16%  perf-profile.calltrace.cycles-pp.__fxstat64
>        0.96 ± 33%      +0.4        1.35 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.96 ± 33%      +0.4        1.35 ± 15%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.18 ±141%      +0.4        0.60 ± 13%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
>        1.00 ± 28%      +0.4        1.43 ±  6%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
>        0.22 ±141%      +0.4        0.65 ± 18%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>        0.47 ± 76%      +0.5        0.93 ± 10%  perf-profile.calltrace.cycles-pp.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64
>        0.42 ± 73%      +0.5        0.90 ± 23%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>        1.14 ± 29%      +0.5        1.62 ±  7%  perf-profile.calltrace.cycles-pp.__close_nocancel
>        0.41 ± 73%      +0.5        0.90 ± 23%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>        1.10 ± 28%      +0.5        1.59 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
>        1.10 ± 28%      +0.5        1.59 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
>        1.13 ± 19%      +0.5        1.66 ± 17%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.58 ± 77%      +0.5        1.12 ±  8%  perf-profile.calltrace.cycles-pp.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.22 ±141%      +0.5        0.77 ± 18%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
>        0.27 ±141%      +0.5        0.82 ± 20%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
>        0.00            +0.6        0.56 ±  9%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
>        0.22 ±141%      +0.6        0.85 ± 18%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>        1.03 ± 71%      +5.3        6.34 ± 64%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>        1.04 ± 71%      +5.3        6.37 ± 64%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>        1.07 ± 71%      +5.4        6.47 ± 63%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>        1.07 ± 71%      +5.4        6.47 ± 63%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>        1.07 ± 71%      +5.4        6.47 ± 63%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>        1.00 ± 71%      +5.5        6.50 ± 57%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>        1.03 ± 71%      +5.6        6.61 ± 58%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>        1.07 ± 71%      +5.7        6.74 ± 57%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>        1.38 ± 78%      +6.2        7.53 ± 41%  perf-profile.calltrace.cycles-pp.copy_page.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
>        1.44 ± 80%      +6.2        7.63 ± 41%  perf-profile.calltrace.cycles-pp.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages
>        1.44 ± 80%      +6.2        7.67 ± 41%  perf-profile.calltrace.cycles-pp.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page
>        1.44 ± 80%      +6.2        7.67 ± 41%  perf-profile.calltrace.cycles-pp.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page
>        1.52 ± 78%      +6.5        8.07 ± 41%  perf-profile.calltrace.cycles-pp.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault
>        1.52 ± 78%      +6.5        8.07 ± 41%  perf-profile.calltrace.cycles-pp.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault
>        1.52 ± 78%      +6.6        8.08 ± 41%  perf-profile.calltrace.cycles-pp.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>        1.53 ± 78%      +6.6        8.14 ± 41%  perf-profile.calltrace.cycles-pp.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>        5.22 ± 49%      +7.3       12.52 ± 23%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>        5.49 ± 48%      +7.5       12.98 ± 22%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>        6.00 ± 47%      +7.6       13.57 ± 20%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>        5.97 ± 48%      +7.6       13.55 ± 20%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>        6.99 ± 45%      +7.8       14.80 ± 19%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>       20.83 ± 73%     -20.8        0.00        perf-profile.children.cycles-pp.queue_event
>       20.80 ± 72%     -20.8        0.00        perf-profile.children.cycles-pp.record__finish_output
>       20.78 ± 72%     -20.8        0.00        perf-profile.children.cycles-pp.perf_session__process_events
>       20.75 ± 72%     -20.8        0.00        perf-profile.children.cycles-pp.reader__read_event
>       20.43 ± 72%     -20.4        0.00        perf-profile.children.cycles-pp.process_simple
>       20.03 ± 72%     -20.0        0.00        perf-profile.children.cycles-pp.ordered_events__queue
>        0.37 ± 14%      -0.1        0.26 ± 15%  perf-profile.children.cycles-pp.rebalance_domains
>        0.11 ±  8%      -0.1        0.06 ± 75%  perf-profile.children.cycles-pp.wake_up_q
>        0.13 ±  7%      +0.0        0.15 ± 13%  perf-profile.children.cycles-pp.get_unmapped_area
>        0.05            +0.0        0.08 ± 22%  perf-profile.children.cycles-pp.complete_signal
>        0.07 ± 23%      +0.0        0.10 ± 19%  perf-profile.children.cycles-pp.lru_add_fn
>        0.08 ± 24%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.__do_sys_brk
>        0.08 ± 11%      +0.0        0.13 ± 19%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
>        0.08 ± 12%      +0.0        0.12 ± 27%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
>        0.02 ±141%      +0.0        0.06 ± 19%  perf-profile.children.cycles-pp.workingset_age_nonresident
>        0.02 ±141%      +0.0        0.06 ± 19%  perf-profile.children.cycles-pp.workingset_activation
>        0.04 ± 71%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.page_add_file_rmap
>        0.09 ± 18%      +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.terminate_walk
>        0.08 ± 12%      +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.__send_signal_locked
>        0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.proc_pident_lookup
>        0.11 ± 15%      +0.1        0.17 ± 15%  perf-profile.children.cycles-pp.exit_notify
>        0.15 ± 31%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.try_charge_memcg
>        0.04 ± 71%      +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.__mod_lruvec_state
>        0.04 ± 73%      +0.1        0.10 ± 24%  perf-profile.children.cycles-pp.__mod_node_page_state
>        0.11 ± 25%      +0.1        0.17 ± 22%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>        0.08 ± 12%      +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.get_slabinfo
>        0.02 ±141%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.fput
>        0.12 ±  6%      +0.1        0.18 ± 20%  perf-profile.children.cycles-pp.xas_find
>        0.08 ± 17%      +0.1        0.15 ± 39%  perf-profile.children.cycles-pp.task_numa_fault
>        0.07 ± 44%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.___slab_alloc
>        0.02 ±141%      +0.1        0.09 ± 35%  perf-profile.children.cycles-pp.copy_creds
>        0.08 ± 12%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp._exit
>        0.07 ± 78%      +0.1        0.15 ± 27%  perf-profile.children.cycles-pp.file_free_rcu
>        0.02 ±141%      +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.do_task_dead
>        0.19 ± 22%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
>        0.18 ± 29%      +0.1        0.26 ± 16%  perf-profile.children.cycles-pp.lru_add_drain
>        0.03 ± 70%      +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.node_read_numastat
>        0.07 ± 25%      +0.1        0.15 ± 51%  perf-profile.children.cycles-pp.__kernel_read
>        0.20 ±  4%      +0.1        0.28 ± 24%  perf-profile.children.cycles-pp.__do_fault
>        0.23 ± 17%      +0.1        0.31 ±  9%  perf-profile.children.cycles-pp.native_irq_return_iret
>        0.11 ± 27%      +0.1        0.20 ± 17%  perf-profile.children.cycles-pp.__pte_alloc
>        0.06 ± 86%      +0.1        0.14 ± 44%  perf-profile.children.cycles-pp.cgroup_rstat_flush
>        0.06 ± 86%      +0.1        0.14 ± 44%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
>        0.06 ± 86%      +0.1        0.14 ± 44%  perf-profile.children.cycles-pp.do_flush_stats
>        0.06 ± 86%      +0.1        0.14 ± 44%  perf-profile.children.cycles-pp.flush_memcg_stats_dwork
>        0.12 ± 28%      +0.1        0.20 ± 18%  perf-profile.children.cycles-pp.d_path
>        0.08 ± 36%      +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.lookup_open
>        0.11 ±  7%      +0.1        0.20 ± 33%  perf-profile.children.cycles-pp.copy_pte_range
>        0.13 ± 16%      +0.1        0.22 ± 18%  perf-profile.children.cycles-pp.dev_attr_show
>        0.04 ± 73%      +0.1        0.13 ± 49%  perf-profile.children.cycles-pp.task_numa_migrate
>        0.19 ± 17%      +0.1        0.28 ±  7%  perf-profile.children.cycles-pp.__count_memcg_events
>        0.15 ± 17%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.__pmd_alloc
>        0.00            +0.1        0.09 ± 31%  perf-profile.children.cycles-pp.remove_vma
>        0.13 ± 16%      +0.1        0.22 ± 22%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
>        0.12 ± 26%      +0.1        0.21 ± 26%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
>        0.08 ± 78%      +0.1        0.18 ± 20%  perf-profile.children.cycles-pp.free_unref_page
>        0.02 ±141%      +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.nd_jump_root
>        0.05 ± 74%      +0.1        0.14 ± 23%  perf-profile.children.cycles-pp._find_next_bit
>        0.12 ± 22%      +0.1        0.21 ± 21%  perf-profile.children.cycles-pp.clock_gettime
>        0.02 ±141%      +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.free_percpu
>        0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.lockref_get
>        0.25 ± 40%      +0.1        0.35 ± 24%  perf-profile.children.cycles-pp.shift_arg_pages
>        0.26 ± 29%      +0.1        0.36 ± 14%  perf-profile.children.cycles-pp.rmqueue
>        0.13 ± 35%      +0.1        0.23 ± 24%  perf-profile.children.cycles-pp.single_open
>        0.05 ± 78%      +0.1        0.15 ± 29%  perf-profile.children.cycles-pp.vma_expand
>        0.09 ±  5%      +0.1        0.21 ± 41%  perf-profile.children.cycles-pp.prepare_task_switch
>        0.08 ± 12%      +0.1        0.19 ± 37%  perf-profile.children.cycles-pp.copy_page_to_iter
>        0.22 ± 40%      +0.1        0.34 ± 33%  perf-profile.children.cycles-pp.mas_wr_node_store
>        0.16 ± 41%      +0.1        0.27 ± 13%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
>        0.16 ± 10%      +0.1        0.28 ± 26%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
>        0.11 ± 28%      +0.1        0.23 ± 27%  perf-profile.children.cycles-pp.single_release
>        0.00            +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.find_busiest_queue
>        0.23 ± 28%      +0.1        0.35 ± 23%  perf-profile.children.cycles-pp.pte_alloc_one
>        0.23 ± 32%      +0.1        0.35 ± 16%  perf-profile.children.cycles-pp.strncpy_from_user
>        0.20 ± 55%      +0.1        0.33 ± 25%  perf-profile.children.cycles-pp.gather_stats
>        0.16 ± 30%      +0.1        0.30 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        0.29 ± 31%      +0.1        0.43 ± 14%  perf-profile.children.cycles-pp.setup_arg_pages
>        0.13 ± 18%      +0.1        0.27 ± 28%  perf-profile.children.cycles-pp.aa_file_perm
>        0.03 ± 70%      +0.1        0.18 ± 73%  perf-profile.children.cycles-pp.set_pmd_migration_entry
>        0.09 ±103%      +0.1        0.23 ± 39%  perf-profile.children.cycles-pp.__wait_for_common
>        0.19 ± 16%      +0.1        0.33 ± 27%  perf-profile.children.cycles-pp.obj_cgroup_charge
>        0.03 ± 70%      +0.1        0.18 ± 74%  perf-profile.children.cycles-pp.try_to_migrate_one
>        0.14 ± 41%      +0.2        0.29 ± 34%  perf-profile.children.cycles-pp.select_task_rq
>        0.28 ± 35%      +0.2        0.44 ± 28%  perf-profile.children.cycles-pp.vm_area_alloc
>        0.04 ± 71%      +0.2        0.20 ± 73%  perf-profile.children.cycles-pp.try_to_migrate
>        0.04 ± 71%      +0.2        0.22 ± 70%  perf-profile.children.cycles-pp.rmap_walk_anon
>        0.37 ± 28%      +0.2        0.55 ± 23%  perf-profile.children.cycles-pp.pick_next_task_fair
>        0.04 ± 71%      +0.2        0.22 ± 57%  perf-profile.children.cycles-pp.migrate_folio_unmap
>        0.11 ± 51%      +0.2        0.31 ± 30%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
>        0.30 ± 30%      +0.2        0.50 ± 16%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>        0.30 ± 19%      +0.2        0.50 ± 23%  perf-profile.children.cycles-pp.__perf_sw_event
>        0.21 ± 30%      +0.2        0.41 ± 19%  perf-profile.children.cycles-pp.apparmor_file_permission
>        0.25 ± 29%      +0.2        0.45 ± 15%  perf-profile.children.cycles-pp.security_file_permission
>        0.13 ± 55%      +0.2        0.34 ± 24%  perf-profile.children.cycles-pp.smp_call_function_many_cond
>        0.31 ± 34%      +0.2        0.52 ± 30%  perf-profile.children.cycles-pp.pipe_read
>        0.32 ± 16%      +0.2        0.55 ±  8%  perf-profile.children.cycles-pp.getname_flags
>        0.33 ± 11%      +0.2        0.55 ± 21%  perf-profile.children.cycles-pp.___perf_sw_event
>        0.17 ± 44%      +0.2        0.40 ± 38%  perf-profile.children.cycles-pp.newidle_balance
>        0.38 ± 38%      +0.2        0.60 ± 12%  perf-profile.children.cycles-pp.__percpu_counter_init
>        0.38 ± 37%      +0.2        0.61 ± 18%  perf-profile.children.cycles-pp.readlink
>        0.27 ± 40%      +0.2        0.51 ± 21%  perf-profile.children.cycles-pp.mod_objcg_state
>        0.76 ± 17%      +0.3        1.10 ± 19%  perf-profile.children.cycles-pp.write
>        0.48 ± 42%      +0.4        0.83 ± 13%  perf-profile.children.cycles-pp.pid_revalidate
>        0.61 ± 34%      +0.4        0.98 ± 17%  perf-profile.children.cycles-pp.__d_lookup_rcu
>        0.73 ± 35%      +0.4        1.12 ±  8%  perf-profile.children.cycles-pp.alloc_bprm
>        0.59 ± 42%      +0.4        0.98 ± 11%  perf-profile.children.cycles-pp.pcpu_alloc
>        0.77 ± 31%      +0.4        1.21 ±  4%  perf-profile.children.cycles-pp.mm_init
>        0.92 ± 31%      +0.5        1.38 ± 12%  perf-profile.children.cycles-pp.__fxstat64
>        0.74 ± 32%      +0.5        1.27 ± 20%  perf-profile.children.cycles-pp.open_last_lookups
>        1.37 ± 29%      +0.6        1.94 ± 19%  perf-profile.children.cycles-pp.kmem_cache_alloc
>        1.35 ± 38%      +0.7        2.09 ± 15%  perf-profile.children.cycles-pp.lookup_fast
>        1.13 ± 59%      +5.3        6.47 ± 63%  perf-profile.children.cycles-pp.start_secondary
>        1.06 ± 60%      +5.4        6.50 ± 57%  perf-profile.children.cycles-pp.intel_idle
>        1.09 ± 59%      +5.5        6.62 ± 58%  perf-profile.children.cycles-pp.cpuidle_enter
>        1.09 ± 59%      +5.5        6.62 ± 58%  perf-profile.children.cycles-pp.cpuidle_enter_state
>        1.10 ± 59%      +5.5        6.65 ± 58%  perf-profile.children.cycles-pp.cpuidle_idle_call
>        1.13 ± 59%      +5.6        6.74 ± 57%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>        1.13 ± 59%      +5.6        6.74 ± 57%  perf-profile.children.cycles-pp.cpu_startup_entry
>        1.13 ± 59%      +5.6        6.74 ± 57%  perf-profile.children.cycles-pp.do_idle
>        1.51 ± 69%      +6.1        7.65 ± 41%  perf-profile.children.cycles-pp.folio_copy
>        1.52 ± 69%      +6.2        7.68 ± 41%  perf-profile.children.cycles-pp.move_to_new_folio
>        1.52 ± 69%      +6.2        7.68 ± 41%  perf-profile.children.cycles-pp.migrate_folio_extra
>        1.74 ± 63%      +6.2        7.96 ± 39%  perf-profile.children.cycles-pp.copy_page
>        1.61 ± 68%      +6.5        8.08 ± 41%  perf-profile.children.cycles-pp.migrate_pages_batch
>        1.61 ± 68%      +6.5        8.09 ± 41%  perf-profile.children.cycles-pp.migrate_pages
>        1.61 ± 68%      +6.5        8.10 ± 41%  perf-profile.children.cycles-pp.migrate_misplaced_page
>        1.62 ± 67%      +6.5        8.14 ± 41%  perf-profile.children.cycles-pp.do_huge_pmd_numa_page
>        7.23 ± 41%      +7.5       14.76 ± 19%  perf-profile.children.cycles-pp.__handle_mm_fault
>        8.24 ± 38%      +7.6       15.86 ± 17%  perf-profile.children.cycles-pp.exc_page_fault
>        8.20 ± 38%      +7.6       15.84 ± 17%  perf-profile.children.cycles-pp.do_user_addr_fault
>        9.84 ± 35%      +7.7       17.51 ± 15%  perf-profile.children.cycles-pp.asm_exc_page_fault
>        7.71 ± 40%      +7.7       15.41 ± 18%  perf-profile.children.cycles-pp.handle_mm_fault
>       20.00 ± 72%     -20.0        0.00        perf-profile.self.cycles-pp.queue_event
>        0.18 ± 22%      -0.1        0.10 ± 24%  perf-profile.self.cycles-pp.__d_lookup
>        0.07 ± 25%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__perf_read_group_add
>        0.08 ± 16%      +0.0        0.12 ± 26%  perf-profile.self.cycles-pp.check_heap_object
>        0.05 ±  8%      +0.0        0.09 ± 30%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
>        0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.try_to_wake_up
>        0.08 ± 31%      +0.1        0.14 ± 30%  perf-profile.self.cycles-pp.task_dump_owner
>        0.05 ± 74%      +0.1        0.10 ± 24%  perf-profile.self.cycles-pp.rmqueue
>        0.14 ± 26%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.init_file
>        0.05 ± 78%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
>        0.05 ± 78%      +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.___slab_alloc
>        0.02 ±141%      +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.pick_link
>        0.04 ± 73%      +0.1        0.10 ± 24%  perf-profile.self.cycles-pp.__mod_node_page_state
>        0.07 ± 17%      +0.1        0.14 ± 26%  perf-profile.self.cycles-pp.get_slabinfo
>        0.00            +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.select_task_rq
>        0.07 ± 78%      +0.1        0.15 ± 27%  perf-profile.self.cycles-pp.file_free_rcu
>        0.09 ± 44%      +0.1        0.16 ± 15%  perf-profile.self.cycles-pp.apparmor_file_permission
>        0.08 ± 27%      +0.1        0.15 ± 35%  perf-profile.self.cycles-pp.malloc
>        0.02 ±141%      +0.1        0.10 ± 29%  perf-profile.self.cycles-pp.memcg_account_kmem
>        0.23 ± 17%      +0.1        0.31 ±  9%  perf-profile.self.cycles-pp.native_irq_return_iret
>        0.13 ± 32%      +0.1        0.21 ± 32%  perf-profile.self.cycles-pp.obj_cgroup_charge
>        0.10 ± 43%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.perf_read
>        0.14 ± 12%      +0.1        0.23 ± 25%  perf-profile.self.cycles-pp.cgroup_rstat_updated
>        0.13 ± 43%      +0.1        0.23 ± 27%  perf-profile.self.cycles-pp.mod_objcg_state
>        0.00            +0.1        0.10 ± 25%  perf-profile.self.cycles-pp.lockref_get
>        0.07 ± 78%      +0.1        0.18 ± 34%  perf-profile.self.cycles-pp.update_rq_clock_task
>        0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.find_busiest_queue
>        0.09 ± 59%      +0.1        0.21 ± 29%  perf-profile.self.cycles-pp.smp_call_function_many_cond
>        0.15 ± 31%      +0.1        0.27 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        0.19 ± 39%      +0.1        0.32 ± 19%  perf-profile.self.cycles-pp.zap_pte_range
>        0.13 ± 18%      +0.1        0.26 ± 23%  perf-profile.self.cycles-pp.aa_file_perm
>        0.19 ± 50%      +0.1        0.32 ± 24%  perf-profile.self.cycles-pp.gather_stats
>        0.24 ± 16%      +0.2        0.40 ± 17%  perf-profile.self.cycles-pp.___perf_sw_event
>        0.25 ± 31%      +0.2        0.41 ± 16%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
>        0.08 ± 71%      +0.2        0.25 ± 24%  perf-profile.self.cycles-pp.pcpu_alloc
>        0.16 ± 38%      +0.2        0.34 ± 21%  perf-profile.self.cycles-pp.filemap_map_pages
>        0.32 ± 41%      +0.2        0.54 ± 17%  perf-profile.self.cycles-pp.pid_revalidate
>        0.47 ± 19%      +0.3        0.73 ± 21%  perf-profile.self.cycles-pp.kmem_cache_alloc
>        0.60 ± 34%      +0.4        0.96 ± 18%  perf-profile.self.cycles-pp.__d_lookup_rcu
>        1.06 ± 60%      +5.4        6.50 ± 57%  perf-profile.self.cycles-pp.intel_idle
>        1.74 ± 63%      +6.2        7.92 ± 39%  perf-profile.self.cycles-pp.copy_page
> 
> 
> 
> ***************************************************************************************************
> lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp3/_INVERSE_BIND/autonuma-benchmark
> 
> commit:
>    fc769221b2 ("sched/numa: Remove unconditional scan logic using mm numa_scan_seq")
>    167773d1dd ("sched/numa: Increase tasks' access history")
> 
> fc769221b23064c0 167773d1ddb5ffdd944f851f2cb
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>        0.01 ± 20%      +0.0        0.01 ± 15%  mpstat.cpu.all.iowait%
>       25370 ±  3%     -13.5%      21946 ±  6%  uptime.idle
>   2.098e+10 ±  4%     -15.8%  1.767e+10 ±  7%  cpuidle..time
>    21696014 ±  4%     -15.8%   18274389 ±  7%  cpuidle..usage
>     3567832 ±  2%     -12.9%    3106532 ±  5%  numa-numastat.node1.local_node
>     4472555 ±  2%     -10.8%    3989658 ±  6%  numa-numastat.node1.numa_hit
>    21420616 ±  4%     -15.9%   18019892 ±  7%  turbostat.C6
>       62.12            +3.8%      64.46        turbostat.RAMWatt
>      185236 ±  6%     -17.4%     152981 ± 15%  numa-meminfo.node1.Active
>      184892 ±  6%     -17.5%     152523 ± 15%  numa-meminfo.node1.Active(anon)
>      190876 ±  6%     -17.4%     157580 ± 15%  numa-meminfo.node1.Shmem
>      373.94 ±  4%     -14.8%     318.67 ±  6%  autonuma-benchmark.numa01.seconds
>        3066 ±  2%      -7.6%       2833 ±  3%  autonuma-benchmark.time.elapsed_time
>        3066 ±  2%      -7.6%       2833 ±  3%  autonuma-benchmark.time.elapsed_time.max
>     1770652 ±  3%      -7.7%    1634112 ±  3%  autonuma-benchmark.time.involuntary_context_switches
>      258701 ±  2%      -6.9%     240826 ±  3%  autonuma-benchmark.time.user_time
>       46235 ±  6%     -17.5%      38150 ± 15%  numa-vmstat.node1.nr_active_anon
>       47723 ±  6%     -17.4%      39411 ± 15%  numa-vmstat.node1.nr_shmem
>       46235 ±  6%     -17.5%      38150 ± 15%  numa-vmstat.node1.nr_zone_active_anon
>     4471422 ±  2%     -10.8%    3989129 ±  6%  numa-vmstat.node1.numa_hit
>     3566699 ±  2%     -12.9%    3106004 ±  5%  numa-vmstat.node1.numa_local
>        2.37 ± 23%     +45.3%       3.44 ± 16%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>        2.26 ± 28%     +45.0%       3.28 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>      203.53 ±  4%     -12.8%     177.48 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>      128836 ±  7%     -16.9%     107001 ±  8%  sched_debug.cpu.max_idle_balance_cost.stddev
>       12639 ±  6%     -12.1%      11108 ±  8%  sched_debug.cpu.nr_switches.min
>        0.06 ± 41%     -44.9%       0.04 ± 20%  perf-sched.sch_delay.avg.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
>        1.84 ± 23%     -56.4%       0.80 ± 33%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>        0.08 ± 38%     -55.2%       0.04 ± 22%  perf-sched.sch_delay.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
>        7.55 ± 60%     -77.2%       1.72 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
>       10.72 ± 60%     -73.8%       2.81 ±171%  perf-sched.wait_time.max.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
>        0.28 ± 12%     -16.4%       0.23 ±  5%  perf-sched.wait_time.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
>        8802 ±  3%      -4.3%       8427        proc-vmstat.nr_mapped
>       54506 ±  5%      -5.2%      51656        proc-vmstat.nr_shmem
>     8510048            -4.5%    8124296        proc-vmstat.numa_hit
>       43091 ±  8%     +15.9%      49938 ±  6%  proc-vmstat.numa_huge_pte_updates
>     7242046            -5.3%    6860532 ±  2%  proc-vmstat.numa_local
>     3762770 ±  5%     +34.7%    5068087 ±  3%  proc-vmstat.numa_pages_migrated
>    22235827 ±  8%     +15.8%   25759214 ±  6%  proc-vmstat.numa_pte_updates
>    10591821            -5.4%   10024519 ±  2%  proc-vmstat.pgfault
>     3762770 ±  5%     +34.7%    5068087 ±  3%  proc-vmstat.pgmigrate_success
>      489883 ±  2%      -6.8%     456801 ±  3%  proc-vmstat.pgreuse
>        7297 ±  5%     +34.8%       9838 ±  3%  proc-vmstat.thp_migration_success
>    22825216            -7.4%   21132800 ±  3%  proc-vmstat.unevictable_pgs_scanned
>       40.10            +4.2%      41.80        perf-stat.i.MPKI
>        1.64            +0.1        1.74        perf-stat.i.branch-miss-rate%
>     1920111            +6.9%    2051982        perf-stat.i.branch-misses
>       60.50            +1.2       61.72        perf-stat.i.cache-miss-rate%
>    12369678            +6.9%   13223477        perf-stat.i.cache-misses
>    21918348            +4.6%   22934958        perf-stat.i.cache-references
>       22544            -4.0%      21634        perf-stat.i.cycles-between-cache-misses
>        1458           +12.1%       1635 ±  5%  perf-stat.i.instructions-per-iTLB-miss
>        2.51            +2.4%       2.57        perf-stat.i.metric.M/sec
>        3383            +2.3%       3460        perf-stat.i.minor-faults
>      244016            +5.0%     256219        perf-stat.i.node-load-misses
>     4544736            +9.5%    4977101 ±  3%  perf-stat.i.node-store-misses
>     6126744            +5.5%    6463826 ±  2%  perf-stat.i.node-stores
>        3383            +2.3%       3460        perf-stat.i.page-faults
>       37.34            +3.4%      38.60        perf-stat.overall.MPKI
>        1.64            +0.1        1.74        perf-stat.overall.branch-miss-rate%
>       21951            -5.4%      20763        perf-stat.overall.cycles-between-cache-misses
>     1866870            +7.1%    2000069        perf-stat.ps.branch-misses
>    12385090            +6.6%   13198317        perf-stat.ps.cache-misses
>    21609219            +4.6%   22595642        perf-stat.ps.cache-references
>        3340            +2.3%       3418        perf-stat.ps.minor-faults
>      243774            +4.9%     255759        perf-stat.ps.node-load-misses
>     4560352            +9.0%    4973035 ±  3%  perf-stat.ps.node-store-misses
>     6135666            +5.2%    6452858 ±  2%  perf-stat.ps.node-stores
>        3340            +2.3%       3418        perf-stat.ps.page-faults
>   1.775e+12            -6.5%  1.659e+12 ±  2%  perf-stat.total.instructions
>       32.90 ± 14%     -14.9       17.99 ± 40%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
>        0.60 ± 14%      +0.3        0.88 ± 23%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
>        0.57 ± 49%      +0.4        0.93 ± 14%  perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.find_idlest_group.find_idlest_cpu.select_task_rq_fair.sched_exec
>        0.78 ± 12%      +0.4        1.15 ± 34%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn.perf_evsel__read
>        0.80 ± 14%      +0.4        1.17 ± 26%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>        0.82 ± 15%      +0.4        1.19 ± 33%  perf-profile.calltrace.cycles-pp.__libc_read.readn.perf_evsel__read.read_counters.process_interval
>        0.80 ± 14%      +0.4        1.19 ± 33%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.readn.perf_evsel__read.read_counters
>        0.50 ± 46%      +0.4        0.89 ± 25%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>        0.59 ± 49%      +0.4        0.98 ± 19%  perf-profile.calltrace.cycles-pp.find_idlest_group.find_idlest_cpu.select_task_rq_fair.sched_exec.bprm_execve
>        0.59 ± 48%      +0.4        1.00 ± 25%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
>        0.67 ± 47%      +0.4        1.10 ± 22%  perf-profile.calltrace.cycles-pp.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
>        0.90 ± 18%      +0.4        1.33 ± 24%  perf-profile.calltrace.cycles-pp.show_numa_map.seq_read_iter.seq_read.vfs_read.ksys_read
>        0.66 ± 46%      +0.4        1.09 ± 27%  perf-profile.calltrace.cycles-pp.gather_pte_stats.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
>        0.68 ± 46%      +0.5        1.13 ± 27%  perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_vma.show_numa_map
>        0.68 ± 46%      +0.5        1.13 ± 27%  perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_vma
>        0.68 ± 46%      +0.5        1.14 ± 27%  perf-profile.calltrace.cycles-pp.walk_page_vma.show_numa_map.seq_read_iter.seq_read.vfs_read
>        0.68 ± 46%      +0.5        1.14 ± 27%  perf-profile.calltrace.cycles-pp.__walk_page_range.walk_page_vma.show_numa_map.seq_read_iter.seq_read
>        0.68 ± 46%      +0.5        1.14 ± 27%  perf-profile.calltrace.cycles-pp.walk_pgd_range.__walk_page_range.walk_page_vma.show_numa_map.seq_read_iter
>        0.40 ± 71%      +0.5        0.88 ± 20%  perf-profile.calltrace.cycles-pp._dl_addr
>        0.93 ± 18%      +0.5        1.45 ± 28%  perf-profile.calltrace.cycles-pp.__fxstat64
>        0.88 ± 18%      +0.5        1.41 ± 27%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
>        0.88 ± 18%      +0.5        1.42 ± 28%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__fxstat64
>        0.60 ± 73%      +0.6        1.24 ± 18%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.23 ±142%      +0.7        0.88 ± 26%  perf-profile.calltrace.cycles-pp.show_stat.seq_read_iter.vfs_read.ksys_read.do_syscall_64
>        2.87 ± 14%      +1.3        4.21 ± 23%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>        2.88 ± 14%      +1.4        4.23 ± 23%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       34.28 ± 13%     -14.6       19.70 ± 36%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>        0.13 ± 29%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.schedule_tail
>        0.12 ± 20%      -0.1        0.05 ± 78%  perf-profile.children.cycles-pp.__put_user_4
>        0.18 ± 16%      +0.1        0.23 ± 13%  perf-profile.children.cycles-pp.__x64_sys_munmap
>        0.09 ± 17%      +0.1        0.16 ± 27%  perf-profile.children.cycles-pp.__do_sys_brk
>        0.01 ±223%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.acpi_ex_insert_into_field
>        0.01 ±223%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.acpi_ex_opcode_1A_1T_1R
>        0.01 ±223%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.acpi_ex_store_object_to_node
>        0.01 ±223%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.acpi_ex_write_data_to_field
>        0.02 ±142%      +0.1        0.09 ± 50%  perf-profile.children.cycles-pp.common_perm_cond
>        0.06 ± 58%      +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.___slab_alloc
>        0.02 ±144%      +0.1        0.10 ± 63%  perf-profile.children.cycles-pp.__alloc_pages_bulk
>        0.06 ± 18%      +0.1        0.14 ± 58%  perf-profile.children.cycles-pp.security_inode_getattr
>        0.12 ± 40%      +0.1        0.21 ± 28%  perf-profile.children.cycles-pp.__ptrace_may_access
>        0.07 ± 33%      +0.1        0.18 ± 40%  perf-profile.children.cycles-pp.brk
>        0.15 ± 14%      +0.1        0.26 ± 23%  perf-profile.children.cycles-pp.wq_worker_comm
>        0.09 ± 87%      +0.1        0.21 ± 30%  perf-profile.children.cycles-pp.irq_get_next_irq
>        0.93 ± 12%      +0.2        1.17 ± 19%  perf-profile.children.cycles-pp.do_dentry_open
>        0.15 ± 30%      +0.3        0.43 ± 56%  perf-profile.children.cycles-pp.run_ksoftirqd
>        0.54 ± 17%      +0.4        0.89 ± 20%  perf-profile.children.cycles-pp._dl_addr
>        0.74 ± 19%      +0.4        1.09 ± 27%  perf-profile.children.cycles-pp.gather_pte_stats
>        0.74 ± 25%      +0.4        1.10 ± 21%  perf-profile.children.cycles-pp.sched_exec
>        0.76 ± 19%      +0.4        1.13 ± 27%  perf-profile.children.cycles-pp.walk_p4d_range
>        0.76 ± 19%      +0.4        1.13 ± 27%  perf-profile.children.cycles-pp.walk_pud_range
>        0.76 ± 19%      +0.4        1.14 ± 27%  perf-profile.children.cycles-pp.walk_page_vma
>        0.76 ± 19%      +0.4        1.14 ± 27%  perf-profile.children.cycles-pp.__walk_page_range
>        0.76 ± 19%      +0.4        1.14 ± 27%  perf-profile.children.cycles-pp.walk_pgd_range
>        0.92 ± 13%      +0.4        1.33 ± 20%  perf-profile.children.cycles-pp.open_last_lookups
>        0.90 ± 17%      +0.4        1.33 ± 24%  perf-profile.children.cycles-pp.show_numa_map
>        0.43 ± 51%      +0.5        0.88 ± 26%  perf-profile.children.cycles-pp.show_stat
>        1.49 ± 11%      +0.5        1.94 ± 15%  perf-profile.children.cycles-pp.__do_softirq
>        1.22 ± 18%      +0.6        1.78 ± 16%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
>        1.28 ± 20%      +0.6        1.88 ± 18%  perf-profile.children.cycles-pp.find_idlest_group
>        1.07 ± 16%      +0.6        1.67 ± 30%  perf-profile.children.cycles-pp.__fxstat64
>        1.36 ± 20%      +0.6        1.98 ± 21%  perf-profile.children.cycles-pp.find_idlest_cpu
>       30.64 ± 15%     -14.9       15.70 ± 46%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
>        0.01 ±223%      +0.1        0.07 ± 36%  perf-profile.self.cycles-pp.pick_next_task_fair
>        0.10 ± 28%      +0.1        0.17 ± 28%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
>        0.00            +0.1        0.07 ± 32%  perf-profile.self.cycles-pp.touch_atime
>        0.04 ±106%      +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.___slab_alloc
>        0.12 ± 37%      +0.1        0.20 ± 27%  perf-profile.self.cycles-pp.__ptrace_may_access
>        0.05 ± 52%      +0.1        0.13 ± 75%  perf-profile.self.cycles-pp.pick_link
>        0.14 ± 28%      +0.1        0.24 ± 34%  perf-profile.self.cycles-pp.__slab_free
>        0.47 ± 19%      +0.3        0.79 ± 16%  perf-profile.self.cycles-pp._dl_addr
>        1.00 ± 19%      +0.4        1.44 ± 18%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
>        6.04 ± 14%      +1.9        7.99 ± 18%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
> 
> 
> 
> ***************************************************************************************************
> lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> commit:
>    fc769221b2 ("sched/numa: Remove unconditional scan logic using mm numa_scan_seq")
>    167773d1dd ("sched/numa: Increase tasks' access history")
> 
> fc769221b23064c0 167773d1ddb5ffdd944f851f2cb
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>       36796 ±  6%     -19.0%      29811 ±  8%  uptime.idle
>   3.231e+10 ±  7%     -21.6%  2.534e+10 ± 10%  cpuidle..time
>    33785162 ±  7%     -21.8%   26431366 ± 10%  cpuidle..usage
>       10.56 ±  7%      -1.5        9.02 ±  9%  mpstat.cpu.all.idle%
>        0.01 ± 22%      +0.0        0.01 ± 11%  mpstat.cpu.all.iowait%
>        0.17 ±  2%      -0.0        0.15 ±  4%  mpstat.cpu.all.soft%
>      388157 ± 31%     +60.9%     624661 ± 36%  numa-numastat.node0.other_node
>     4511165 ±  4%     -13.5%    3901276 ±  7%  numa-numastat.node1.numa_hit
>      951382 ± 12%     -30.4%     661932 ± 31%  numa-numastat.node1.other_node
>      388157 ± 31%     +60.9%     624658 ± 36%  numa-vmstat.node0.numa_other
>     4510646 ±  4%     -13.5%    3900948 ±  7%  numa-vmstat.node1.numa_hit
>      951382 ± 12%     -30.4%     661932 ± 31%  numa-vmstat.node1.numa_other
>      305.08 ±  5%     +19.6%     364.96 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>      989.11 ±  4%     +13.0%       1117 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.max
>        5082 ±  6%     -19.0%       4114 ± 12%  sched_debug.cpu.curr->pid.stddev
>       85229           -13.2%      74019 ±  9%  sched_debug.cpu.max_idle_balance_cost.stddev
>        7575 ±  5%      -8.3%       6946 ±  3%  sched_debug.cpu.nr_switches.min
>      394498 ±  5%     -21.0%     311653 ± 10%  turbostat.C1E
>    33233046 ±  8%     -21.7%   26018024 ± 10%  turbostat.C6
>       10.39 ±  7%      -1.5        8.90 ±  9%  turbostat.C6%
>        7.77 ±  6%     -17.5%       6.41 ±  9%  turbostat.CPU%c1
>      206.88            +2.9%     212.86        turbostat.RAMWatt
>      372.30            -8.3%     341.49        autonuma-benchmark.numa01.seconds
>      209.06           -10.7%     186.67 ±  6%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>        2408            -8.6%       2200 ±  2%  autonuma-benchmark.time.elapsed_time
>        2408            -8.6%       2200 ±  2%  autonuma-benchmark.time.elapsed_time.max
>     1221333 ±  2%      -5.1%    1159380 ±  2%  autonuma-benchmark.time.involuntary_context_switches
>     3508627            -4.1%    3363550        autonuma-benchmark.time.minor_page_faults
>       11174            +1.9%      11388        autonuma-benchmark.time.percent_of_cpu_this_job_got
>      261419            -7.0%     243046 ±  2%  autonuma-benchmark.time.user_time
>      220972 ±  7%     +22.1%     269753 ±  3%  proc-vmstat.numa_hint_faults
>      164886 ± 11%     +19.4%     196883 ±  5%  proc-vmstat.numa_hint_faults_local
>     7964964            -5.9%    7494239        proc-vmstat.numa_hit
>       82885 ±  6%     +43.4%     118829 ±  6%  proc-vmstat.numa_huge_pte_updates
>     6625289            -6.3%    6207618        proc-vmstat.numa_local
>     6636312 ±  4%     +33.1%    8834573 ±  3%  proc-vmstat.numa_pages_migrated
>    42671823 ±  6%     +43.2%   61094857 ±  6%  proc-vmstat.numa_pte_updates
>     9173569            -6.2%    8602789        proc-vmstat.pgfault
>     6636312 ±  4%     +33.1%    8834573 ±  3%  proc-vmstat.pgmigrate_success
>      397595            -6.5%     371818        proc-vmstat.pgreuse
>       12917 ±  4%     +33.2%      17200 ±  3%  proc-vmstat.thp_migration_success
>    17964288            -8.7%   16401792 ±  2%  proc-vmstat.unevictable_pgs_scanned
>        0.63 ± 12%      -0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.__libc_read.readn.evsel__read_counter.read_counters.process_interval
>        1.17 ±  4%      -0.2        0.96 ± 14%  perf-profile.children.cycles-pp.__irq_exit_rcu
>        0.65 ± 19%      -0.2        0.46 ± 13%  perf-profile.children.cycles-pp.task_mm_cid_work
>        0.23 ± 16%      -0.2        0.08 ± 61%  perf-profile.children.cycles-pp.rcu_gp_kthread
>        0.30 ±  5%      -0.1        0.16 ± 43%  perf-profile.children.cycles-pp.rebalance_domains
>        0.13 ± 21%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
>        0.25 ± 16%      -0.1        0.18 ± 14%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>        0.17 ±  9%      -0.1        0.11 ± 23%  perf-profile.children.cycles-pp.__perf_read_group_add
>        0.09 ± 21%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.__evlist__disable
>        0.11 ± 19%      -0.0        0.07 ± 53%  perf-profile.children.cycles-pp.vma_link
>        0.13 ±  6%      -0.0        0.09 ± 27%  perf-profile.children.cycles-pp.ptep_clear_flush
>        0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.__kernel_read
>        0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.simple_lookup
>        0.09 ±  9%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.exit_notify
>        0.12 ± 14%      +0.0        0.16 ± 17%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
>        0.02 ±141%      +0.1        0.09 ± 40%  perf-profile.children.cycles-pp.__sysvec_call_function
>        0.05 ± 78%      +0.1        0.13 ± 42%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>        0.03 ±141%      +0.1        0.12 ± 41%  perf-profile.children.cycles-pp.sysvec_call_function
>        0.64 ± 19%      -0.2        0.45 ± 12%  perf-profile.self.cycles-pp.task_mm_cid_work
>        0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.dequeue_task_fair
>        0.05 ±  8%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.file_free_rcu
>        1057            +9.9%       1162 ±  2%  perf-stat.i.MPKI
>       76.36 ±  2%      +4.6       80.91 ±  2%  perf-stat.i.cache-miss-rate%
>   5.353e+08 ±  4%     +18.2%  6.327e+08 ±  3%  perf-stat.i.cache-misses
>   7.576e+08            +9.3%  8.282e+08 ±  2%  perf-stat.i.cache-references
>   3.727e+11            +1.7%  3.792e+11        perf-stat.i.cpu-cycles
>      154.73            +1.5%     157.11        perf-stat.i.cpu-migrations
>      722.61 ±  2%      -8.9%     658.12 ±  3%  perf-stat.i.cycles-between-cache-misses
>        2.91            +1.7%       2.96        perf-stat.i.metric.GHz
>        1242 ±  3%      +5.7%       1312 ±  2%  perf-stat.i.metric.K/sec
>       12.73            +9.8%      13.98 ±  2%  perf-stat.i.metric.M/sec
>      245601            +5.4%     258749        perf-stat.i.node-load-misses
>       43.38            -2.5       40.91 ±  3%  perf-stat.i.node-store-miss-rate%
>   2.267e+08 ±  3%      +8.8%  2.467e+08 ±  4%  perf-stat.i.node-store-misses
>   3.067e+08 ±  5%     +25.2%  3.841e+08 ±  6%  perf-stat.i.node-stores
>      915.00            +9.1%     998.24 ±  2%  perf-stat.overall.MPKI
>       71.29 ±  3%      +5.7       77.00 ±  3%  perf-stat.overall.cache-miss-rate%
>      702.58 ±  3%     -14.0%     604.23 ±  3%  perf-stat.overall.cycles-between-cache-misses
>       42.48 ±  2%      -3.3       39.20 ±  5%  perf-stat.overall.node-store-miss-rate%
>    5.33e+08 ±  4%     +18.1%  6.296e+08 ±  3%  perf-stat.ps.cache-misses
>   7.475e+08            +9.4%  8.178e+08 ±  2%  perf-stat.ps.cache-references
>   3.739e+11            +1.6%    3.8e+11        perf-stat.ps.cpu-cycles
>      154.22            +1.6%     156.62        perf-stat.ps.cpu-migrations
>        3655            +2.5%       3744        perf-stat.ps.minor-faults
>      242759            +5.4%     255974        perf-stat.ps.node-load-misses
>   2.255e+08 ±  3%      +8.9%  2.457e+08 ±  3%  perf-stat.ps.node-store-misses
>   3.057e+08 ±  5%     +24.9%   3.82e+08 ±  6%  perf-stat.ps.node-stores
>        3655            +2.5%       3744        perf-stat.ps.page-faults
>   1.968e+12            -8.3%  1.805e+12 ±  2%  perf-stat.total.instructions
>        0.03 ±141%    +283.8%       0.13 ± 85%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>        0.06 ± 77%    +254.1%       0.20 ± 54%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>        0.08 ± 28%     -89.5%       0.01 ±223%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
>        0.92 ± 10%     -33.4%       0.62 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>        0.10 ± 22%     -27.2%       0.07 ±  8%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>        0.35 ±141%    +186.8%       1.02 ± 69%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>        1.47 ± 81%    +262.6%       5.32 ± 79%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>        2.42 ± 42%    +185.9%       6.91 ± 52%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>        0.26 ±  9%   +1470.7%       4.16 ±115%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>        3.61 ±  7%     -25.3%       2.70 ± 18%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>        0.08 ± 28%     -89.5%       0.01 ±223%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
>       17.44 ±  4%     -19.0%      14.12 ± 13%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       23.36 ± 21%     -37.2%      14.67 ± 22%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>      107.00           +11.5%     119.33 ±  4%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       75.00            +9.6%      82.17 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       79.99 ± 97%     -86.8%      10.52 ± 41%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
>      145.98 ± 14%     -41.5%      85.46 ± 22%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>        1.20 ± 94%    +152.3%       3.03 ± 31%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
>        2.30 ± 57%     -90.9%       0.21 ±205%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
>        0.06 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>        0.58 ± 81%     -76.6%       0.14 ± 50%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
>        2.63 ± 21%     -59.4%       1.07 ± 68%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
>        2.68 ± 40%     -79.5%       0.55 ±174%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
>        3.59 ± 17%     -52.9%       1.69 ± 98%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
>        4.05 ±  2%     -80.6%       0.79 ±133%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.mprotect_fixup
>        3.75 ± 19%     -81.9%       0.68 ±135%  perf-sched.wait_time.avg.ms.__cond_resched.mmput.m_stop.seq_read_iter.seq_read
>        1527 ± 70%     -84.5%     236.84 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>       16.13 ±  4%     -21.4%      12.69 ± 15%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>        1.16 ±117%     -99.1%       0.01 ±223%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>        0.26 ± 25%     -93.2%       0.02 ±223%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
>       22.43 ± 21%     -37.4%      14.05 ± 22%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>        4.41 ±  8%     -94.9%       0.22 ±191%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
>        0.08 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>        6.20 ±  8%     -21.6%       4.87 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>        4.23 ±  5%     -68.3%       1.34 ±136%  perf-sched.wait_time.max.ms.__cond_resched.mmput.m_stop.seq_read_iter.seq_read
>        3053 ± 70%     -92.2%     236.84 ±223%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>        4.78 ± 33%  +10431.5%     502.95 ± 99%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       79.99 ± 97%     -86.9%      10.51 ± 41%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
>        2.13 ±128%     -99.5%       0.01 ±223%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>        0.26 ± 25%     -92.4%       0.02 ±223%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
>      142.79 ± 13%     -40.9%      84.32 ± 22%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
> 
> 
> 
> 
I hope I can add your tested-by if I need to REBASE the patch for -mm
tree depending on the feedback I get any further with any minor changes.


