Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D515679D755
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjILRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjILRNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:13:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D8110;
        Tue, 12 Sep 2023 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694538818; x=1726074818;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mTPJmn4JKUVFCizALjbFKhVIRs5JP7hoOBHU4UxwABA=;
  b=fOhtGTT6xyqUGGi+3tpjm1/hoZKBeh34gh61OR26XtssCieYLSLSY33E
   BwsBZNkMdx5EPZDBk7Usrb86wUzgtMHaRS0atPQpS2xzm2A88YXVeiSJS
   z0UTmliicnMJYmuhGjVxmKtkNlq2qATWxj+X0X5a188kd4ebqb6Wm2R/M
   yJmKIWb9k5QkG1t/HCUuTxeystWUTaM57FS7PXqMApb19E7pfWLFCagvn
   Pgqr2ehJmuCjGvQnK5ohEfllw1GWOriJGWt80myBP5T7pc7/YAPA4acMF
   oqKSlbfvFcdKZIrhzCBfqLfu0yudA1AGNGqe95grQn1lE30f5004t5Azx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363477099"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="363477099"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809358462"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="809358462"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 10:13:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 10:13:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 10:13:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 10:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQOnYN2EwRPoUf11g2gM7NLDzSeK5iYV9Icv/QYH9IoapqePZWZoMeJ+BIL3Fuz4XGCECBl6RLOBf33S0kRYLxa/Ws828MqSkc/zyICZEi5nMrZTvlQURFaHZtoSVZ4phKAJf/erKb7BPFLhfMGTeg+f9lwNFXSe5erths1+xZsVUiqDJsye4hhhifr5mZ1biJn20rq5GGS03YTJ+fdsTE0nNkcM0Jdtz9dQumYEc6BGmsSkW9DvbeTCdGqjB205Nyn+pzelfo2kGEBWq00+cGTY9iUe3/7xk2cu2Goy6DeB4FEevj7W5LJn246iZpiJuYYaupEv5149HgtTSJ3GQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvffplOtFgqs/fljdVnH3Iuq8jpO2lXXQQJyyd4ohOY=;
 b=NSfPNV8apgFPVDsuYZWfhVblAL25PZ0MbUqdQ3f20LNewu/UH+Vk/s/7pFCs8090qe55rYT1JDJkd4TP5+ME3CVuW3EfHuAjwlrPlmGKkU4P6rnX4V6Rq8tbjDY0Zct9s9gT0zDctVaknp2x3yMjXCcp2kuap2x2mmDCuc0dIhPSR/wBNR00g+FC6mrD906TGIddVSyVUYsggRc1kNQBDFdSLc9Q6oRYs/J/d9IhVcLFlVEnarZC5U3mBUmxpbCGXCCSowTw/ymhx2HngJzCun3uTRXdNvfpbm8avDI49pQEU8lUK3xtgtWBVqbuK/hMx1N8rYMiKlaadKcSSAz2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5935.namprd11.prod.outlook.com (2603:10b6:303:18a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 17:13:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 17:13:33 +0000
Message-ID: <0a59dce4-59f3-3d60-e06a-ef3e84e8c64c@intel.com>
Date:   Tue, 12 Sep 2023 10:13:31 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZQCLTS0XAs/H2min@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 7999f813-f472-49de-6b56-08dbb3b3983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8i2bgQAWb97c+W6dxfQtNrnuMuGcNr9g/5VaqvRyMf2ViT2pKfbwGvkIoIIb0pYVQmTRawoQkWN23RIjFtBrp8olddPk7Y/3+cQGMoNnn3B58SjosYqKLoQiOwypFFhYfj4ywsz5ZSO7gwAlcb85BCT1d4SMdV59ty7vvBHlb0vRp1kGmVUJpAMzIQLIPLkHns43k7Qq2WpEVH19vjCe4Z6AjDbCOTJUXSxwLPRRJTrdnzTNIW5h4oAuM371d4OiKqYoiFUu/QaSXD6hD4RtqMHw3gykESSuAgCLhko4DsKwNPJMP79q8cM/bW1fMDsXD5PkSomQVDdTR3UDQYTtDv/UEzAmdbY3XKmWjmu5D2sTXNT3jOnq6k0W7fVS4QVBqELMYlA7foENr2TOAfIqtYzQxHgTRbo9VY8RJ9cXKKbxIIEYvzsdheYo+bJgC02G4ZnK5xqGVy/nt2gNNSgvn6zeyCHiVj1IO9Gt7pFtvSfUtGD5xcifrdywYSDDVhTvxqfyP/EambYNfGu0r9DT5ONOE30kCQ+ZdB5PQ57htzJzkU8uI9tKbE5z8G/inkm+yG40OsB1bopvKZs+8n1OeEj68Q/mqkQ4byW8UWRyFE049uHss29ecNf3tg6vSrAYhX3LgUHlmowEaBgv0vtcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(41300700001)(6486002)(2616005)(83380400001)(26005)(316002)(37006003)(66946007)(6636002)(66556008)(54906003)(66476007)(8936002)(4326008)(2906002)(6512007)(478600001)(53546011)(966005)(5660300002)(7416002)(6506007)(6862004)(44832011)(36756003)(82960400001)(38100700002)(8676002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHh2RG82TnNyR3FwK2pScW1PejU4WUc1QTl4WU56TU13Vk13VzBESitFTWtu?=
 =?utf-8?B?a1ZWVmhtb1NBYmxwUkZBZmpGU0tsd0RIVHQ1OVpBYmwzdWpGUHpJTFF4blhM?=
 =?utf-8?B?d0J4Nytqa2s4ZmhMWUNiYlFaLzIzN21xY28zVTIveVdyQlpGdzNFaE1xclFk?=
 =?utf-8?B?YnhqY05SeVpzQzJKaS9uUUEwTS9nVXlSOUREeTdTTEpSeFlXM2NaaGFRZVZp?=
 =?utf-8?B?aDR2QnZST1lhMXRENUx5YWRSbjNiM0hpVTY4V2o2Y2FTSGlFeitxTE9pbXlV?=
 =?utf-8?B?ZElXZHorcWlScHpIUzByVkpjRXRubVdCbFNRczVtM2dEZE8xaG8xYkxGZ0R2?=
 =?utf-8?B?RlY3MVRsRlF0QXI1SHRldGZSYU05TDZUYVBZSFFvWlozdUY5aG1vemFNNUdW?=
 =?utf-8?B?M0VnWXRQT094K1VjaGN6WXlsVGx4U1JJOXJ5Wm8xWmtNSWJ6bG12TEJPQVZX?=
 =?utf-8?B?UVY3ajhIWGtmWFcyWUk1VjdiQTZPQ2t4UmxUNTVTTUZtNVA3WEwyWVZXWlN4?=
 =?utf-8?B?NTVsTjVHbUt1eHNscVlheVljOFJCaXBjeTZENTB2ekVsOGtCTVNVdG15dGVn?=
 =?utf-8?B?T0F0VVViaEJRWXVkbytYSitFSHBHNnBSdlgyOEVxYTlTTStUcitqQzBMOGw0?=
 =?utf-8?B?bml5bHR2aUdmZkRpbkpwMlUrVDk2VW5XWkpFS1huQnN5WGdld3g0SGtJbks0?=
 =?utf-8?B?clJ3dUJUanpPbHlaNERTZm02cis1ejBMZ2tqTStRUlRlRnp5SUJqR0x4bVQ1?=
 =?utf-8?B?Uit3dUtkQ282Uk9mNERVTkVvVnpRcTkvVndEVlVzbmt5cU9VNnd5QUZ1dW9j?=
 =?utf-8?B?VlI2Q0tZVXEzQ1BmbmtBZ2tDdDhRdWZlOUdnUS9kTGFpaDV0V3ZKTlJmZVV6?=
 =?utf-8?B?SDVmOXNSeVFKRUtTSEthZ00zek12TVgyZ1h0ZkNEcTk5Q21kM093ZU9uYjV3?=
 =?utf-8?B?MHJ5Umw0VC9qWWpsWGduLzVtZXRnb244N0JaY0liN3BBZEZCbkdNOEZPaUJ1?=
 =?utf-8?B?UEt6bnEyWERYY0VnSk5oclBJdFY3WVQxY3loVGd6RnZTK0p3R0JnYkwrV3lK?=
 =?utf-8?B?SVE3UlQwTktsQlZwM0I4UG5LUnZ2WnlsVlo2dm15Y3NNeEFPQytuenliVW4r?=
 =?utf-8?B?YkYxT3FNQlU0QzRRNDdxTjVHeUZXbkxZRVFyUUlhVFUzcmU4b3JIVTZhb21z?=
 =?utf-8?B?b3Jna0ZmVmNrOTIvcUJaQUgyNnR5NXorZngxNVlNazZEbWxBTlRVYmc2YVlW?=
 =?utf-8?B?STR2YnFDNXF5MHdrUTJRTzY0YVNCK21CMHVSeWs0TzVxRytqalVFTnl5TmU0?=
 =?utf-8?B?bVIyTHlmMzlvdzlKUVRZcDQyRGhZMlY3cEFMcGh5cXV2N3RuTmlnTHFvYWlC?=
 =?utf-8?B?bmdETjlTQXlveWwwQkYxOFBYcHJxVGNSZTZvbEhCcUhqMEdTZXhsUDZ1NXll?=
 =?utf-8?B?Ymw5NG5YQnZDc3ZmKyt4NC8yQ1R3UUIyazMvMlZRaWNQSlE1bzd4djNJZ3oz?=
 =?utf-8?B?UkFuTm5RakJvSGJIQ2ZxZmFSTXoxVDJRaStxZUtUdGU1RG5pa1F4NGcyZlFz?=
 =?utf-8?B?dWc4L2pjSVFlTy9hUEtaQ2VidHFZM3R0UWNrNUlpQ1BtV3ZXcFdoV1c2ME80?=
 =?utf-8?B?QzJ6b1BnWHloWkpId1pvMEdFZThsMTVZU2R2dmdyT3Z4UVdDMy9IeVhRMTZP?=
 =?utf-8?B?RitpSXJyYXhVdFlRYXFybEFNS29IYmFWbW9rNi9GLzZKOTk5T3AzYlRmaTVn?=
 =?utf-8?B?YmMzd011SytSbGlqMVVnRmtOQ3NlUURGZWNUTnlPb3ZMMUZHTmYvVGpSb1h2?=
 =?utf-8?B?SktnVXViZUlBRlR4S2NWN2FrMCtEeU02S1BzNVlScVJUeHhWeHpqMTFhd2xz?=
 =?utf-8?B?eVlJMW1HemlBMDBKSmcxMmpGQ0ZKV3ZpVU9FK3FLNDNFTjN2WlJIbHNrT24y?=
 =?utf-8?B?S1FIWG0rcjByTzBkUHJWdXZUNlk0dDdZM2xua1dqZ0Nvem9UY011ZG9xdW9k?=
 =?utf-8?B?Um91NjNqR3dTWVRteWoyak84RXI4ZkR0U2cyVnp0MytMTHFhOEUxbGFRRkNP?=
 =?utf-8?B?cFBBWXJIYnpNL0FEaHE2ajZ1bE9VaHpBblhPUlBlZ2lzaVRsNDFBR0xRbGpJ?=
 =?utf-8?B?Z0VNdWZ1MDdTK3NvdVFBZCtRM3Y1dEVvZDloRnNvT0pwUmRuMkpyS0lIcjE4?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7999f813-f472-49de-6b56-08dbb3b3983e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:13:33.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thjueKxyXjHA/F/auMpHoUx5whyK+T47djH8UQb2MxApj6rAfli6jWZyML6xVrPMp4UJwyCmtgrfO5kyvj+e/5+M/fC87U8wf2/rSQRzkf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5935
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/12/2023 9:01 AM, Tony Luck wrote:
> On Mon, Sep 11, 2023 at 01:23:35PM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 8/29/2023 4:44 PM, Tony Luck wrote:
>>> The Sub-NUMA cluster feature on some Intel processors partitions
>>> the CPUs that share an L3 cache into two or more sets. This plays
>>> havoc with the Resource Director Technology (RDT) monitoring features.
>>> Prior to this patch Intel has advised that SNC and RDT are incompatible.
>>>
>>> Some of these CPU support an MSR that can partition the RMID
>>> counters in the same way. This allows for monitoring features
>>> to be used (with the caveat that memory accesses between different
>>> SNC NUMA nodes may still not be counted accuratlely.
>>
>> Same typo as in V4.
> 
> Sorry. Will fix and re-post.
> 
>>>
>>> Note that this patch series improves resctrl reporting considerably
>>> on systems with SNC enabled, but there will still be some anomalies
>>> for processes accessing memory from other sub-NUMA nodes.
>>
>> I have the same question as with V4 that was not answered in that email
>> thread nor in this new version.
>> https://lore.kernel.org/lkml/e350514e-76ed-14ea-3e74-c0852658182f@intel.com/
> 
> Non-SNC systems already have an issue when reporting memory bandwidth
> for a task that Linux may migrate the task to a CPU on a different node
> which means that logging for that task will also move to different files
> in the mon_data/mon_L3_*/ for the new node.

It is not obvious to me that this is an issue. From what I understand
the data remains accurate.

How does this map to the earlier "may still not be counted
accurately"? 

> 
> With SNC enabled, migration between NUMA nodes on the same socket may happen
> much more frequently because:
> 1) The CPUs on the other NUMA nodes in the socket are in the same Linux
>    L3 cache domain. So Linux regard the migration as "cheap".
> 2) The ACPI SLIT table on SNC enabled systems may also report the
>    latency for remote access to another NUMA node on the same socket
>    as significantly lower than the latency for cross-socket access. On
>    my test system the SLIT distance for same socket nodes is 0xC,
>    compared to 0x15 for cross-socket distance. This will also lead
>    to Linux being more likely to migrate a task to a CPU on another
>    SNC NUMA node in the same socket.
> 
> To avoid migration issues, users may use sched_setaffinity(2) to bind
> tasks to the subset of CPUs that share an SNC NUMA node.
> 
> I can write this up in a new cover letter.
> 
>> I stop my review of this series here.
> 
> Reinette
> 
> Should I repost the whole series as v6 with the new cover letter. The
> only change to the patches so far is to the selftest reported by
> Shaopeng Tan[1].
> 

Is this an assurance that the cover letter in no way reflects how 
feedback was addressed in the rest of this series?

Reinette
