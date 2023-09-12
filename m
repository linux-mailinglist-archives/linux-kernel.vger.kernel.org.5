Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32BA79C71C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjILGnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjILGne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:43:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A039B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h87DgersXCOxgs0Hqu+8r7EGDWRDGcVWml5FlWa4/SNX0kSxmE+0p/5EzImCEaJsD85rhL3CeJp2E0knBIL/9lVOd7bMZgVH+sCSMImiX6/uzkyAy7Nox/gc+CjcBqs1RNQ53E6HE9ORVE+LWnlw5zEmQ+74nOY/vMz22xLKiIjJpNupgRaZ5fkXQ/qu8oqNtxKC8b5SyrRwUNjgqSE0r/XkJc2Xk5/rY6SFAB5jTNHOR8KF9wh1fPbUGrMZNqTUNdJe2J/MZz7+7iQ1Nj+lxkiol/Yasrc1JcbtBK2dLDd4z8xsf5jaOOb8Pl5LU5BaQyuaEDk692giE1IilaxdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOHJbFAsHkDmD1/pZKZE5ugYGF4b8Kv32zOTHYrgOjM=;
 b=SZd86KNk1KKvU0zXcI0zV/O+RHVa65uJWQMhkNTb0DUNIF6vfGlDQtBlUsyS9rhMALrxYBuFh7tBfgD3uSrPERrct+HBfehqLubIoXN2upgi8aXR0PiEFid5pj0nKDGfdGtOGZEEjEkUnKMpAAlzdZM+tOVB8PSJmKUBQOUgzMaTkG0LNiaF34KLHRmKfBRGeI6QBceUTK4XZNpS8EKOOzH9hYlQgZF5YvR3z7TqkIJHG5h9dUnuGqrviu5yJL6xHQaDSoz3UluSXhh3nXo6Y1ot0rN8ZOqmN5mxIjBi+spSTSHFcvxWSjN2kslg0hKwyGCvTmAkdC6Do4wRIlikLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOHJbFAsHkDmD1/pZKZE5ugYGF4b8Kv32zOTHYrgOjM=;
 b=KzTdtFRH/KRlU8+BpxB2OyD4BNTclPdb8ovhMyUia9wt8SWDuEeZdoVdlSu1gJbdMJ00Qp1KfEHGx2wesTo+6nz6mn9zqxBLb+g3GfypDNbzW5MOVF2sT1unlczK/AGhGPtZNJauqBhpAdlHsxpJzXnozS48d2QLjJ6Ze5f12o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:43:28 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:43:28 +0000
Message-ID: <acf254e9-0207-7030-131f-8a3f520c657b@amd.com>
Date:   Tue, 12 Sep 2023 12:13:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 5/6] sched/numa: Allow recently accessed VMAs to be
 scanned
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Bharata B Rao <bharata@amd.com>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aithal Srikanth <sraithal@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <202309102311.84b42068-oliver.sang@intel.com>
 <1e8fcce9-fda4-7bf7-97c3-cb9e4a4d788e@amd.com>
 <ZP/LeEQpE1TBs7LS@xsang-OptiPlex-9020>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZP/LeEQpE1TBs7LS@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::6) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5c7d7f-5def-43d7-63c7-08dbb35b920e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lVN6DRueLFEGyVzNVCCKXRffhRwvh6DYteTYEG+HBQMeY2ZlfOTHNnPen4ANbx2NmqXfHu4fBsgzlaxk7F6JnyckeTq4jIqFbx/6gLkSl1V6xO2jT+fztes6kpXYc70rr2xTK6ZSqAv0Wk1kujWAOol1OpzQ61JLRcgy6zpU3Mc1oaF9gkl789Ow2GReCfeRUG59NapsThedfUb/p1A7cytwXTpfgx2LHaagO/fIJpp0fCst0ER4VL+txosvNUr7X3YNHgNA/A4fKSqgr2UugxQMpH598axltTjuxKoFv7SufhOzr6M7EmXlKF7VT1osWKB0eVtc6JLRIKoI7gpUiVGnh/01p83ecrrXb2TNH44oKne81WH/Lw5QOpTftCizXpg/p8709blK6W9PNPAhiOVKuL2rGOkXFHO7YUzUjzSlbcuLL6WAXo7g2/HwtKREF0GmTgvTgRrGW73oK9nSgU0gqICdkdED5cteW+mGfKwjfdK8xx72bZZbwikytLvc0cIFpxdLvJAZqD15sCtOtitSzVKdiiJK28AYYefio39GA/pqtzwJ0acq7qrmQzQAZu9ZwQMLwouOXdJml2Y9JrQNMPc9EVmZCkuUguxmGUnVx4Sfe26V400eDkvib3ms2QLlVz2EI1Kiwdb4WZ1ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(6486002)(6666004)(66556008)(66946007)(66476007)(6916009)(54906003)(83380400001)(6506007)(53546011)(41300700001)(316002)(6512007)(478600001)(31686004)(26005)(4326008)(2616005)(8676002)(8936002)(5660300002)(36756003)(38100700002)(31696002)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThnbGx1enFCdEZiSmN1WC9pOFB2NGtyclVhZ2FOekZyUVJBQWlDNkpLUUYv?=
 =?utf-8?B?UXIyU2tKYVpxSTgxRWNDV0FKOGFyTldnZ1hkK1BhTUp4OEVWWlFaY2psOUtH?=
 =?utf-8?B?cUN0YmhoWEhDWmhIcUxQQlEwK1hnMnBYeDhhQ0xNSUFCMUJ1ejVWd0pIQWtM?=
 =?utf-8?B?b1JTanFnb1dnUTZDSVFYejFGODdLSkFtWThLNFhIdVVXbThmTGZKVmxLS3pG?=
 =?utf-8?B?L2ZmL09MckVVVnE2LzQ2dzBlWDdqRFNxcnRwWkZUKzQzN3JQZG0vSTZMMnpM?=
 =?utf-8?B?MitPODViYUJhdjVLVWxjL001b3BsVGZxZzdFTHE3ZWVqc3IxdW5YclpHWWd3?=
 =?utf-8?B?R0Iyb25KM2FiUEpEbzh2WlkvTmxhcmZ2cUVqaDNuT2hJL2w5Uzl6TzdaVFBH?=
 =?utf-8?B?RVlKbVR6ZWEwQ2JTZGpmd3k4OTFHdnVIa1ZrSWw1cU5kT0ZCaXIrdFU0NWJX?=
 =?utf-8?B?MTg4SGNXQVpFOEEzRzA4SEhKc2tySnBqNkJkTUVpUVk1VW5XYzdaeWpjTm9D?=
 =?utf-8?B?cEdZazFqVmowRm9LUjAzS0pSbzI2cDdiYys1WjF1cnV2WTIxUk8zR3dRemkv?=
 =?utf-8?B?YmlmZ1R6dGNDdDJwRFdodlNPZkNHbkR3UURaL1ZFUjdPVjNzdnZCdHZ2dFQx?=
 =?utf-8?B?VXdVMmYvV2Frd2RMRkdxdkt0dXkwM3J6RmhBVnRna1BHSnlBak1Zd3N6S3p5?=
 =?utf-8?B?QktqUldkSXNMaStSSjFtR0ZiWU5WZmRaQWwxZHJNWHVKUzFlM1Y1YzVnKzlS?=
 =?utf-8?B?WDBVZEMwWjdxZ1ZJTHF2aFFON3B2K0ZUd1lKbG96dnlTVDRudU1acTlmQ0px?=
 =?utf-8?B?cW5aZUM3RXN6b1VLQTErb1M3dC83N0pkejBLYlh6V3lWT28yMjRzY3NHOGhR?=
 =?utf-8?B?R1NpaEhpS0RsOWFhcG55Z1kyVGtQQzhiRU1acTRDVlYvdFZTMWxic3pPVDRl?=
 =?utf-8?B?MXlqbXcyU1JsQmtOMG52TmtiSjNpcmhBa2hOVngyWGE0dkRBeWVJNXNEL1Ay?=
 =?utf-8?B?V1BmMlpsT1RKWm9uc1VPd0RDTjJ1YzRSTmZaVkZTd1dXTDkwL1ZnYTNvZUZl?=
 =?utf-8?B?SEhVMHQ0aGJHS2hLbXdSM3FFOUIyZ2FBSlp4Y0MxQU01UjJVZGdETXRnZjcv?=
 =?utf-8?B?S0p4L1R6anNYT3BEOUFIUkNWTVNvVjJiRVNBMTRkV216eXlCRHdCSk9DVzZG?=
 =?utf-8?B?WnpkaWFkWm45dGN0TXczaEpiR0FNeWNOQ1RBektXM2pmbmo1T1pPWklrT2Fl?=
 =?utf-8?B?SlZZVmpzaWUvOERnVXMxd2pXV2Rua0NjS1BwSUdhRXo5SkJnSmVaYUxjcC9l?=
 =?utf-8?B?OWpsZmR0N1R4VVhSaHNBZmR6MktYcGExTXYwMGtlTndvMEFFOFJwc05nZllH?=
 =?utf-8?B?dVNmMlA2VjZkNFM1bHRjenMzeXdpU2JGaEtEUytCQTFZSjcwWnpUTUxSaE1k?=
 =?utf-8?B?YU9RejcyTGNINE56cmRqOXljdXh6YlRvNnpFbHNld1BaV0d3U0FpY2V3K1dY?=
 =?utf-8?B?U2o1eGxIWUhiVS9jSENkOVRmN2crblpJWG5aSGhrZVZ2enUzUmdXOW12RExG?=
 =?utf-8?B?amI1SXJjaXMzbm1nS09DUXpVVnFURHM3RjIzTUEvSUNVcE1CNXB5TmtlL1Bt?=
 =?utf-8?B?YTFyeFIyWXNXekUzQXk5ZTVaTjUrMnVURWc1cStWUGlISFh1dTNaMTZaQlhV?=
 =?utf-8?B?Q3NJdDQxb1lBcndPT1Q3KzlpL0pZeGpBeGtDQ3dLazFTT0NaNy8rY0ZMclFC?=
 =?utf-8?B?czN4NCtUQnBjbWRhZ0p1OFhwRkVLMk03Z202MXNOUWh4YlpXMit5VS9NS2dm?=
 =?utf-8?B?Wnl1cU52czRDYTJ4MVpqc2lkYnFLaUxSYzN0TDFuM2VSMUM5aGJoUTFmZUh0?=
 =?utf-8?B?OWxsRFh1TWY5aDkzS08waEdlcWM3a3BMOEJzYnoybTYyclM3WjZVZUYxSjJB?=
 =?utf-8?B?Z1lTd3I5VjdncHNTOFN2NGFsNURtYTZVR2J0ZjFZSSt6U1hlNGt0Ym9wSDRE?=
 =?utf-8?B?cC9EVTdwZGp0eUtrZWhIQW0zc0hjT0tsN1p2SHpxdlZCU1ZhVE9EVHpxcmxI?=
 =?utf-8?B?M0RmMTFjaGN1andzVlcxTzNqZHJkcWpKQ0d6NzFmb1ZpY296REhyaFZsR0Nh?=
 =?utf-8?Q?U/OTryS5OrgOucSQauE9ZBfo1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5c7d7f-5def-43d7-63c7-08dbb35b920e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:43:28.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Am+NCUbM2wTiL+YEzS6sWi3wgpC+qegkBJbQYWWEsRxwkZUY3NLUGQ2eY6/dw9U8jEjz/ok9AtKQ9T/aLmKXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 7:52 AM, Oliver Sang wrote:
> hi, Raghu,
> 
> On Mon, Sep 11, 2023 at 04:55:56PM +0530, Raghavendra K T wrote:
>> On 9/10/2023 8:59 PM, kernel test robot wrote:
>>>     341.49            -4.1%     327.42 ±  2%  autonuma-benchmark.numa01.seconds
>>>       186.67 ±  6%     -27.1%     136.12 ±  7%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>>>        21.17 ±  7%     -33.6%      14.05        autonuma-benchmark.numa02.seconds
>>>         2200 ±  2%     -13.0%       1913 ±  3%  autonuma-benchmark.time.elapsed_time
>>
>> Hello Oliver/Kernel test robot,
>> Thank yo alot for testing.
>>
>> Results are impressive. Can I take this result as
>> positive for whole series too?
> 
> FYI. we applied your patch set like below:
> 
> 68cfe9439a1ba (linux-review/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007) sched/numa: Allow scanning of shared VMAs
> af46f3c9ca2d1 sched/numa: Allow recently accessed VMAs to be scanned
> 167773d1ddb5f sched/numa: Increase tasks' access history
> fc769221b2306 sched/numa: Remove unconditional scan logic using mm numa_scan_seq
> 1ef5cbb92bdb3 sched/numa: Add disjoint vma unconditional scan logic
> 2a806eab1c2e1 sched/numa: Move up the access pid reset logic
> 2f88c8e802c8b (tip/sched/core) sched/eevdf/doc: Modify the documented knob to base_slice_ns as well
> 
> in our tests, we also tested the 68cfe9439a1ba, if comparing it to af46f3c9ca2d1:
> 
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> commit:
>    af46f3c9ca ("sched/numa: Allow recently accessed VMAs to be scanned")
>    68cfe9439a ("sched/numa: Allow scanning of shared VMA")
> 
> af46f3c9ca2d1648 68cfe9439a1baa642e05883fa64
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      327.42 ±  2%      -1.1%     323.83 ±  3%  autonuma-benchmark.numa01.seconds
>      136.12 ±  7%     -25.1%     101.90 ±  2%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>       14.05            +1.5%      14.26        autonuma-benchmark.numa02.seconds
>        1913 ±  3%      -7.9%       1763 ±  2%  autonuma-benchmark.time.elapsed_time
> 
> 
> below is the full comparison FYI.
> 

Thanks a lot for further run and details.

Combining this result with previous, we do have a very good
result overall for LKP.

  167773d1dd ("sched/numa: Increase tasks' access history")
   af46f3c9ca ("sched/numa: Allow recently accessed VMAs to be scanned")

167773d1ddb5ffdd af46f3c9ca2d16485912f8b9c89
---------------- ---------------------------
          %stddev     %change         %stddev
341.49            -4.1%     327.42 ±  2%  autonuma-benchmark.numa01.seconds
     186.67 ±  6%     -27.1%     136.12 ±  7% 
autonuma-benchmark.numa01_THREAD_ALLOC.seconds
      21.17 ±  7%     -33.6%      14.05 
autonuma-benchmark.numa02.seconds
       2200 ±  2%     -13.0%       1913 ±  3% 
autonuma-benchmark.time.elapsed_time

Thanks and Regards
- Raghu




> 
> 
> 
>>
>> Mel/PeterZ,
>>
>> Whenever time permits can you please let us know your comments/concerns
>> on the series?
>>
>> Thanks and Regards
>> - Raghu
>>

