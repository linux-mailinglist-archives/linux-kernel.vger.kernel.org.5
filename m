Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0195E79D8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbjILScD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjILScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:32:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9ED189;
        Tue, 12 Sep 2023 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694543518; x=1726079518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YQ0N9KqLjF6Jg8G8R+D2t0FnopiQRnTDpFlEHg5GcBc=;
  b=Npq1ik52y9+pIuKZZBHUAJTtdeaJC72vlUgedz3eEVpP+txqG/UV9l3i
   oWi6PCQyyypLz5WX51Ph+ijmGcrwjPoMn+daSabJSohxKobDb3boNRJYQ
   8l6tTKRAsCDf8tK5Ii33xU9WMD3/eldMoGkB7rblywMGmfDNdmDC2ZSHZ
   BnE/TiMlF7HIcVfphUhGClQGzZpJuBEADWL7fm1jPTNv8mHU3z6LChAzd
   6TszQz8Z+n8+/DZbfKD/Dd0cDhxX2cN67LUtBEgdDPDmgOIWnR26WsmOx
   LrjprkJPfNFfrmboYS5BcN1KTzviJ9IT6CSHvE04Z73buTiN+k+Ax9Bw2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="444898838"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="444898838"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809377676"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="809377676"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 11:31:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 11:31:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 11:31:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 11:31:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 11:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B67bo0pU1v/Frb5E9MfMOEXrpjpvqznhLoybwGbCq0Mi5WIYn701d/lvAwQitnwAHYBgiP+UIiIabIscJqg5xMi19o0aTpTmiP7rU2JmFSCBgpYb1z/2RGc0TQo07RC7bf6rs7nIy7s9k5tJ0WhVzk1OZn8fEyxh8V1p5Q3OVcAHqmFdE5lKE3Tu3F8qDEDtm2H4DMYvu7adcC74QGqaYGth8dkgGW7CZYfdMJD9vSlpEw3YsKtR/MQnotxJTy/nmhk66YplXPL4LWf2pBmiYjRH9dnF/rOQDOgr6Xy4c9e0RkewZjkYJHaR3R6xZOqq603T9DG6oN5txc5Xv4ndBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLB8vZ1eW31NjTyb7tmb/pJtMeC4qNJf6wYTXC1vFrc=;
 b=l/nwScIpjaIsnbnBrvBJN4NCXkpIe4z8/wFKUw0AlR01/9UwHnhoZaS0hdV+e+X268zH3a/zHylIovbmaoqwOufjIkbpn7pcmhnEWxVsfAG9d+aOsaI9YArMJocZh5RdAPJOm9AuPvJKZi1eXR8L7H1DHdXUWvb19FnRZzxANHeJtF3SGlqPIc4kPWp9R6lhIv0X+jm4OEA42L7J5/yMR6EbDyZ+tkZz+vbd0nBs1rkGNaBHyBMKuLfPitK9pPJHXw9jsetFbtt5x7eZfNXUvKgl64/qCAyZ7fOi1PRwjflU/4gK2ZNHd5GtsRSyYZlYx2DzPIfmmdOBdg2lRlCdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5475.namprd11.prod.outlook.com (2603:10b6:610:d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 12 Sep
 2023 18:31:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 18:31:52 +0000
Message-ID: <41cc8a35-81fb-b890-f963-8dc9524a54b0@intel.com>
Date:   Tue, 12 Sep 2023 11:31:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v5 0/8] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <45e81506-3c43-95ba-56a4-38e1bb2e42dc@intel.com>
 <ZQCLTS0XAs/H2min@agluck-desk3>
 <0a59dce4-59f3-3d60-e06a-ef3e84e8c64c@intel.com>
 <ZQCjqc4XJ4sxZARn@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZQCjqc4XJ4sxZARn@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: 047e4167-1cb6-46ef-5142-08dbb3be8911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYJgslNgskI65VOS/c8Q150W1p9I0IaEnIz+4CzQ9B4MuYKCCfxgVUJmQc2REAkWCQ8ocN0HdPKWFq97oQfRQHwDnBrv4kvd36cXPIaMXePOWQ4pbCAbrwtvloCvFWebqm5SEqwMZuLLZnP1UhsCafHwSIWTCIKOrLfPJmovy157qL1Wr0OSLKmG1nqscM4JiT7m15j3lR5SNTjHLiZpj13T3eSPQI6x0jNjcb/ZbniPdhVoGGsKQ/ke4FanJVBn3/8xnYGt+wKdSeKyUVwj8b4tTRPwdYNjJRW3YcCSp1eXfrEhX5bpNDGdM7mazgZ9PRspZepmOEDM8dCPtJGJSUcmQj5xWF7HmCFwtAE2XbkQd6ny/5X5IwxMGZEPMlWs7+YbqDYNv8bESozZLZ6CmEtZHnGeqXKVhlLHZGNX/rjHIztVK8kBvFMNieQ0DStbx553NR5/e7FGi2lfid1oRCPmDbbfT/4zzsgWriXmxXefQlpclfMDp8kI4EbGvINCjZIQZHNoMzVKFcgRSUfcclb9ohYEYjprb1kSVq8dNFKdlby29AXiPt5fM3IB+FULnQzivPjms/9PozUXmGoHcvZZ3YsN2ZkpPoWZliD5MPT/kZQt+TUd4UFT0LdQt+V55kyT6BBb+D0A0AIpRKc3qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199024)(1800799009)(186009)(4326008)(6862004)(8676002)(8936002)(86362001)(31696002)(7416002)(44832011)(5660300002)(2906002)(36756003)(6486002)(478600001)(966005)(38100700002)(82960400001)(31686004)(6512007)(53546011)(26005)(2616005)(6506007)(83380400001)(6636002)(41300700001)(316002)(37006003)(54906003)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZra2ZBeXBjTFRYMlFkWEt2NnMyZUhQcm9aY0swTXpIRi9KOUlsTkJ1czJl?=
 =?utf-8?B?SjNKMFZidjRtMmxZdVVDNkt4ZlJmMjNBQ2M0ZWswMC9QL3ZGUGVYWjg1c1Bx?=
 =?utf-8?B?d1VUZzZRd3VWTDRSYmh2SXBIcVJhcXpSTFAva3d5Mlp5cmUzdDhiZmRaaS9Z?=
 =?utf-8?B?WlZrWXAwVUR1SmsvK0d2R1B6VVMwTWp3SERWekZrOFFMRit0THYxU1Fhck14?=
 =?utf-8?B?ZnFodmlxTXZTUGgxZGZKaEhaeDFYNEF1azl0cUNBV1U2YW1Pc2xDc1hDTkVK?=
 =?utf-8?B?TFRaZDVLVExySFlRSVpaYVFSK3RBMFluYnl0RVFOU2hYOTVkQWw0ZCsvdmp0?=
 =?utf-8?B?VzFXd3Z2dWl5UkVqQmJFNFpuZElma0NCVyt2U3N6ZXU0dWYzbDlTeUxTK1hy?=
 =?utf-8?B?a0VUVkhsYlMwSE9JMmFRRGhUV0ZuM2h1MXNlZmpQcEt0bWFvRUN0SnUvN215?=
 =?utf-8?B?WTcxaVluZVdydGtGTk1QVFpDRTdzUllqejRWOUUrUFFsWkdpVDdDUnltK3pi?=
 =?utf-8?B?dVROcVhIakY1S3FwNzE0Vmp5UUV5U1cvVEpVbGl3UjJ5bGtjWEJkdVRKSE82?=
 =?utf-8?B?bGdNMVlPTWZTcmEwT1ZzQlE1WFpvTTR2empjZ3B1elVuenY0bm1GOGdReTBD?=
 =?utf-8?B?V2RWVTJDQmpUcUFIUjVac2pRYXR3Wnh6SDBrUGRnVmhPdlBraWZTSlQ4OEhx?=
 =?utf-8?B?bGFOVWtDZVd4dVo4a0hkdkdvYUdyblEvbU9EQ09BZWtGNk5yN0dyaFVWNEl0?=
 =?utf-8?B?RE1XdTlVSUtzalpiV3JZc0tWaEp3RlJrWll0eDJnRjBzOVBMc2lsanpub29X?=
 =?utf-8?B?T2RubUxqcjBoQXBMa2cxZ2RmKy9ZemdJaW1yYWxmcmRPWnY2bG85NEQ3aFFU?=
 =?utf-8?B?T09RWTh4bVU4UUtyY2lUTFJ3UHlYS21kU1BpUjRYSjBhMTRoTlFkcWZTMXNl?=
 =?utf-8?B?bDV1b1VkZFhCS0gxY1MyTUV2Q2x0UkE3cWI3d0VxZkpLei9iaDZJampJVStB?=
 =?utf-8?B?WFZBcW1oNWdQcHQyRGVkdTJjRDlNNVdtc045a0VQMlVWMU1lQjBMZGxLczRY?=
 =?utf-8?B?NWh4R3VmdkVQeE9FaFdtRVRtZ2pXUlpUQndmVlZCQzhpSlBmUGlUZmFqMXU5?=
 =?utf-8?B?ZVY3QnVmbzhZUU9iUzZQQzV5c3B2OHV6Z0NKUm9WR1cxbGUrUDJrSUF2MnJa?=
 =?utf-8?B?c3NTaTZDRmdmajk0RGZja2Joa2ZubjR0aWhlWmVHemZWRXA2ckoxdDFxVHRK?=
 =?utf-8?B?WkVMb05UODhFOFlzN2VrTUhNV3IxYVpiVHByNzgvVFM0UHhtZVRnZm1mUlZO?=
 =?utf-8?B?Mk9kUzFVYnl3eXZvOFMvWExDQzJWYzhMVVliMFdaOUN1Ym5Nb21weFN2Yk55?=
 =?utf-8?B?czBISTFPTXl0VnNweXFvRUZ6bXRBWjVsYVAxM2dHUzNpaXJ1SEw4LzJEeXhS?=
 =?utf-8?B?N09NTVMzK3lrRVkwWVMvV2lzbG1tajRyMmQ3VExzVnI0cDhjbjlaZ3JEVnNa?=
 =?utf-8?B?cERQaU8rWmRYcVZpbC9vaW9xWUxxdVRyejV4THNIMkhQWHU2QllUUlJqeHRL?=
 =?utf-8?B?emduc2lObFk5WmdsYTVubDBvd2xqVGRNNHNuOEptODNXN1dQT3R6K1RxbTNn?=
 =?utf-8?B?UHdvbnBjbWpoNjJMRUtZdWxCZnp4ekVabWhwWWNXMXd0U0JQeW9FWXFlTnhV?=
 =?utf-8?B?aXJhRFNucnBudWdyMCtwUjUxcUp3U3JtdXYrM1F1emsydkZOUENpSktSY3FJ?=
 =?utf-8?B?ZElXS1ZZZWh3WGVRallySTFuNXJwZkw5MEFqVloxdWlMd1k1eVk3Z2hvWUho?=
 =?utf-8?B?QjRTQjdEd0huRkpaWmNydUIwdFhrZjFSZUt1elNKUEY4ZzREOUMxS29PQngy?=
 =?utf-8?B?OEtQcFFwUkJ4SmY0cXgwc21YTjVpczZ6VnNCQnZ6VVdMY1ZQL1JQb09EQkNs?=
 =?utf-8?B?QnowQmM2UExOR1ExVno0WVRwdW1pZkduWXRqd3RWUG9LbVhpZzFzYWJTSTEr?=
 =?utf-8?B?SnNvdGFhTzdEL3VaSmd2RzlzN3FDaFBacVpVK1VFZUxnS2w1MStoOUtSMS9Y?=
 =?utf-8?B?WDRyaG1HZzFWUlY2bHg0MjJpTHhOOW1FZlZTdzNVMUlDVTNCQ2ViRDRuMHlK?=
 =?utf-8?B?ZDZnK3plcVNrZHdmb2VpcVpTQk1QR1RYL3dLaDB0QWEzVlNjTUlYTC84d0ox?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 047e4167-1cb6-46ef-5142-08dbb3be8911
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 18:31:52.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BF/pWnh21m0sgn5AAEXnDuTJxHkyt2HyThmQHnbES3WOQzdjEoSb70gM0IaORG4B4B2fUExmkCtgU4NWP62bVMVULhm00ofkq+0pjXwcsfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5475
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/12/2023 10:45 AM, Tony Luck wrote:
> On Tue, Sep 12, 2023 at 10:13:31AM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 9/12/2023 9:01 AM, Tony Luck wrote:
>>> On Mon, Sep 11, 2023 at 01:23:35PM -0700, Reinette Chatre wrote:
>>>> Hi Tony,
>>>>
>>>> On 8/29/2023 4:44 PM, Tony Luck wrote:
>>>>> The Sub-NUMA cluster feature on some Intel processors partitions
>>>>> the CPUs that share an L3 cache into two or more sets. This plays
>>>>> havoc with the Resource Director Technology (RDT) monitoring features.
>>>>> Prior to this patch Intel has advised that SNC and RDT are incompatible.
>>>>>
>>>>> Some of these CPU support an MSR that can partition the RMID
>>>>> counters in the same way. This allows for monitoring features
>>>>> to be used (with the caveat that memory accesses between different
>>>>> SNC NUMA nodes may still not be counted accuratlely.
>>>>
>>>> Same typo as in V4.
>>>
>>> Sorry. Will fix and re-post.
>>>
>>>>>
>>>>> Note that this patch series improves resctrl reporting considerably
>>>>> on systems with SNC enabled, but there will still be some anomalies
>>>>> for processes accessing memory from other sub-NUMA nodes.
>>>>
>>>> I have the same question as with V4 that was not answered in that email
>>>> thread nor in this new version.
>>>> https://lore.kernel.org/lkml/e350514e-76ed-14ea-3e74-c0852658182f@intel.com/
>>>
>>> Non-SNC systems already have an issue when reporting memory bandwidth
>>> for a task that Linux may migrate the task to a CPU on a different node
>>> which means that logging for that task will also move to different files
>>> in the mon_data/mon_L3_*/ for the new node.
>>
>> It is not obvious to me that this is an issue. From what I understand
>> the data remains accurate.
>>
>> How does this map to the earlier "may still not be counted
>> accurately"? 
> 
> Yes, the data is accurate. But a naive application reading the wrong
> files from mon_data will not see the accurate data. Without SNC users
> may only see this issue rarely as Linux tries hard to not migrate
> processes to other NUMA nodes or L3 cache domains. But with SNC enabled
> this is no longer the case. the ACPI SLIT distance of 0xC is below the
> threshold that Linux checks for "is the target CPU for a migration far away"
> so migration to other SNC nodes may be quite common.

I would like to recommend that you take care not to present this work
using uncertain terms like "may not be counted accurately" or "there will
still be some anomalies". If I understand correctly there is no uncertainty.
When that "naive application" reads the wrong files then I think it can be
considered a usage error and should not be documented as an issue with the
counters. I understand that the user space requirements are not obvious,
and there should be guidance. 

> I can move this out of the cover letter and provide guidance/warnings
> in the patch to Documentation/arch/x86/resctrl.rst

Yes, I do think this will be very helpful.

> 
>>
>>>
>>> With SNC enabled, migration between NUMA nodes on the same socket may happen
>>> much more frequently because:
>>> 1) The CPUs on the other NUMA nodes in the socket are in the same Linux
>>>    L3 cache domain. So Linux regard the migration as "cheap".
>>> 2) The ACPI SLIT table on SNC enabled systems may also report the
>>>    latency for remote access to another NUMA node on the same socket
>>>    as significantly lower than the latency for cross-socket access. On
>>>    my test system the SLIT distance for same socket nodes is 0xC,
>>>    compared to 0x15 for cross-socket distance. This will also lead
>>>    to Linux being more likely to migrate a task to a CPU on another
>>>    SNC NUMA node in the same socket.
>>>
>>> To avoid migration issues, users may use sched_setaffinity(2) to bind
>>> tasks to the subset of CPUs that share an SNC NUMA node.
>>>
>>> I can write this up in a new cover letter.
>>>
>>>> I stop my review of this series here.
>>>
>>> Reinette
>>>
>>> Should I repost the whole series as v6 with the new cover letter. The
>>> only change to the patches so far is to the selftest reported by
>>> Shaopeng Tan[1].
>>>
>>
>> Is this an assurance that the cover letter in no way reflects how 
>> feedback was addressed in the rest of this series?
> 
> My track record here is far from perfect. I believe I addressed all
> the issues you raised. But it's very possible that I may have missed
> some, or misintepreted the concerns you raised.

This is a familiar response from you that just puts the burden back
on me to go dig out previous discussions. This will be the last time.

Reinette



