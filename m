Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E07901AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350376AbjIAR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbjIAR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:57:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6510D4;
        Fri,  1 Sep 2023 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693591040; x=1725127040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KproFR7mOyY+HuYAcPrCjVl8C5RyKulXf5H/QoWv80s=;
  b=N9/mvezVtXDizbCLL32TR7lz6qwIH08mxhV/6Zgse0G3OCqmJOdeVDR7
   frrOFdVrcc5iOeJFdpchqyTUYqe9/c+w6VEO0Zzp71T7/pmUWIt5iehtY
   tbB10weiNF0nP1ZxspInSO4rYGr0MhFA1gi2nm2Er60TN9yq1FvrDeMv2
   SPCGSMbR2i0f7T3BJEDiLnRzA/z2cEgCTllODTUdZdU7QPGyHCnQQ5yV3
   kuXuJ/tZAGvFWsLv9yGY5AdBWV/1KtctnWw25UQdpLtq5oTQczJ9oQS6+
   7u6G4qyKxyN5Q2I4crsw6G60kdufjzg1hzYDdinGsAcrFnOen47erARyf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="380062797"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="380062797"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 10:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854804826"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="854804826"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 10:57:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 10:57:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 10:57:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 10:57:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 10:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPUMPMYh/DAUnwM6vACTXyXjnUK+wYlP5jH2BgKXdQzBhghc8Ai9hHNXHITqF67b8WyiXpHZWIaQp3+2nUcSFhZ8/cgfKXzcoZnkNk6nRbUVY1sWBk10t27Bb7L2ItdGqU5bEGGv92NZMLP5ETDJ55QRufCbrMXDGQrQjsikI0ocq7WOZvdfvAI70ekv7wlmyySbHFn4Bd+2jT2aol4KHtyrBZtcpjsndkbIrbl2YfA/Z8nB8AXbnvU0eiHOJeNt2dnAPxLnI9UdPmdojRRTe/BiR34wVqBga6xagDe3DA8AM7Ng2jxXQ8lBz3UauKPX4OmwcxqGI7ywxH4X4a/WjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLJvRuiEdHqxTkD35i0JfI53wZfbg9SSHK7l+f6bNaM=;
 b=Yh/2s0bIXTXz3V4yO1Rn87x8NEdSo5cBf1rMpywpqXCZtszDRnWvDNiwExmBROvtVFM2AJI3I0RWC5PrpG7logOtdnDlS5mbt6Rbsaht3IUswu3ERTFs+15ebEgMfpcy8oF+zkpTBpwIX4Us02lZJb1zEoXNBWR1zeV/jREyOXIrapI2X3jjFpJ5zmsrY5+ZEE4nFMmyFut7IoBRyc9zELoNQ3G8BNyFKwtEvcS1f4V87W+zs40lNNZBLDnda5i4pltxn/KRyz7sK1wdcRHltTf/pxflV01nOlXVeff2JkyssxuBMBIimzyS1JWdcL7QDMVwuY+Vot5rbdb8L3GkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Fri, 1 Sep
 2023 17:57:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 17:57:15 +0000
Message-ID: <f2481932-fb3c-d9e7-c6cc-9407fc0df416@intel.com>
Date:   Fri, 1 Sep 2023 10:57:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-9-babu.moger@amd.com>
 <4019a73a-8478-f18b-7f34-b8d838dfc7fe@intel.com>
 <da47698a-aa9e-3760-1321-5ec3ea1a14e6@amd.com>
 <5b75506b-80ac-a89d-4b70-f775c3b354d3@intel.com>
 <012bf30d-7c41-b9a8-cdda-0922797d6a80@amd.com>
 <2feb3e01-96c7-fdde-a0d2-509fa1527243@intel.com>
 <ce3e0cf3-9b4c-86ae-8095-d433a5669737@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ce3e0cf3-9b4c-86ae-8095-d433a5669737@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: e4749499-21cc-4c98-60dd-08dbab14e027
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aE9m2Eg2WLtoYmU24MHgbeWIT2pyqj2XB3wcFxXglCCVXk7Av+cZbgbJcijko60emW5jM+zuAMFxC7ZJjIZUaskiEVN0j7Kkov5dst9TV7eTxqnFyleF0XipxX9Ef4ObQYgxqlZXJI2xv+vx7YSRnPjUBjReNxXr7NNssnHlZ7Buy421wr+jFdeTFFOcTfa5Lr74WJsXhTXu5bwUqub/4cZyDeFl33mOb/fthJL2bzm5NEetSOk2/Zstrpa0p07+zeiJAZgeOW0T94DpVmHGDQzbwo6AV8HohmluXbI9+s374hLTyZRo1PCsfZP7UdRqLuzTPRBSqaAXMlTgLIk0/WbtvoM0Pw0bPGhk/ys1JYbLlkmXoH1cEEYLwaWCv3PJAmQs6ETj4rbK1MLKttP5+mPcWnSrAPpOpj4JcfUfLkU3nB2l3re+LoLxWW01B74d2iqNmmeYqaPyd559PGAAPNSA5JdR2mfx01FD4/VmMeMOYA5oM1XO9aM585HuzA+XbSpYF8eWDk/iksm8rJ8IXhL6nwgOMZXlHO8pWHLyOg2nhLebxJJONlRuLe0uc7edcJfgo5uTbUwXySp+x6AzSvwLvufpL8/AktNZ8QYSJMZsqDS5USUyfQi53RfjyqHTEun3uWMRL6BK0PkOdM8Dfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(8936002)(6666004)(478600001)(53546011)(31686004)(66556008)(6506007)(66946007)(6486002)(66476007)(316002)(38100700002)(41300700001)(82960400001)(6512007)(44832011)(26005)(5660300002)(36756003)(2616005)(2906002)(86362001)(31696002)(8676002)(4326008)(7406005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9rdWIwTHRscUtjRm5rMml4QkJzakFHUEhUQlhadzZhdEM5YkVwVit5ZlVQ?=
 =?utf-8?B?YXl2TFhSa0Q1Q3ZVWXZrelRIWkZBVStTMnpuazFGYzlBZVJtY1Q0TjNCNUE1?=
 =?utf-8?B?cjhFYjMyNWxoRERNMW9JTmxpUmhmOEdJZGUyN3pYQnVrTUNPcjRmaUYxcVk1?=
 =?utf-8?B?N29leE41U1ZGSURCN2xISHpjeVFZU09NWlBodGVGZUlaRjN1V2gvQVV5KzMy?=
 =?utf-8?B?MkZyNklLQngyMUVMUEZlVXk5bzVRS3lyV1ZPUE12Vk44bElGYTMxRjBrTG9U?=
 =?utf-8?B?TFRzWk9lUmxKUkhEMjN4ODhwUVF3VS9vZERKeE5UakxaZ1hNeXBMRHo3SWly?=
 =?utf-8?B?Y09SL1Ava04yd1BUMlZ2cVJLMmxOLytLU25tS1ZjVHlCTGhqMEJaU0d0SS9r?=
 =?utf-8?B?bnFUZU0yK0VsdDExUVBhWElaMVdlbDQwdmVzMUw5dFgrZ1JOeEs3T1FJVEtJ?=
 =?utf-8?B?dk9lU0pxQ05GVWxLcnhqS2k0UEN2azBXcVNLVkluK21lYVZ5aVlMTnNhWkxP?=
 =?utf-8?B?S0Fra01EK0E3KzVaNldURUg1TURjRndzQlN4a2lENmpOUFpDak53SEljTTha?=
 =?utf-8?B?cDVkeitKMi9YMDNZNFhiNTU4eVJyV2pEYXA2N3dkei84RmVxSDRJd1BNNEJ6?=
 =?utf-8?B?NUtma3phZjBiMWJ6VjFDNTZ4Y3FCUlE5ZmxYREdsZnZHdkRQbFpQMzMwY2FD?=
 =?utf-8?B?bFFEOHlSQlNhZkw3M21PdGFNTFJTeXNkb2pEeTJQOE1vVzZ2SHE3WHR6NTI4?=
 =?utf-8?B?TURxeG1BN1k1TEFuc2RGelpzZWJycEVDb2N0OHVJc0c5em1YNGNLN3htY1p3?=
 =?utf-8?B?SzJNNzZqUVhwWm93QmxZREIyaUcvTlRnbzdSTWZLVHMzaVlPMFFaS1ZVMWEx?=
 =?utf-8?B?Vmp6bFNMVjN1alFTTFJWV0lxOTVWMW41MGZEQWJpTUF5OUFxWk13cS9UU0th?=
 =?utf-8?B?TEUwaEJZWnhGV3NwOVUvS2ZWZGpSNE84Zkkxb1NHMzRHdDdwaEcxbUxGamk2?=
 =?utf-8?B?dFJYL284RkhBdVlOWHR1QitXUy9DVENNc0xNTWhzeHNaWU56Sm1YRHhxcFU3?=
 =?utf-8?B?clUzQUZjVGVaZ2xBWFZ6aEJLRHFrU3VXdVo0MGJEQ2ZQMGlVTGx1cWIzRkQx?=
 =?utf-8?B?TGtZc0QvTnVWaDFoUDBHZTdsMmdYNFN0bVplenJLWHhTd2ZKOGJRNkl4Q1gv?=
 =?utf-8?B?OFpJR3Y4WkZScmprbUNwcVRNVHhoVzlRb2JTL2NHemNuZERSVHphM09iRzRx?=
 =?utf-8?B?bElaclJ0bWFnN2dyaUNxekcyR0dVZ2tmYUx2bGNtRkpsQ3pLdVIxazFBZTcx?=
 =?utf-8?B?VHBEdWYwQU1hTTJLSjZ1QStsekV3b0JOTGJycGxuVFhybisyR003ZWNtcnpI?=
 =?utf-8?B?QTNnTC9wcDVaN3dpbFZ3RUQ5bmRXdFFtdjFpYU4wNXBPR1pxMk4yNW5Nckcv?=
 =?utf-8?B?b1FEYUpveTRDQkpkc0YyVDNGMDJoZkI0S29zMDREMmlLOXNHd3ZtVnJxbTBm?=
 =?utf-8?B?bGFoQXZQSHZIZFJnNGI4ZlRCTGxqdzFEL1RKM0pEVS96WExGZUZET0FNd0VQ?=
 =?utf-8?B?clczbGl3L3RZTVhQNkhNa3ZqbERXWkFXbUxCdk9EdmJQWlJ6VVpJdWNDK3RG?=
 =?utf-8?B?Wm5rNk9UN2xrZktjRTNlZnN5T1Y5YnRETE9DUnBwWGlOQkhVaU1wR2RGdytQ?=
 =?utf-8?B?R1REMFo0UmxsYmFPUG50MlBkdmdMV2lGY3lPTVd6RXVmcTdnWVJzYURpelJB?=
 =?utf-8?B?T1pOYUJkUUt3WVlCc1F0aldWTklZU1VlYWZEd28vbk1KOGZCQm10cjFJVjNi?=
 =?utf-8?B?eWNXMkx1bHpreXhKbUM0YWJWcGtaRTRrOUdKRDh0YjVwWHcxYWh4TWthaWlC?=
 =?utf-8?B?cUhWcGY4bXJHdWt5a2N1OG1pNEJPV2ZoclRLVFlCK3V4TVlVMzBLSlZmSDhN?=
 =?utf-8?B?NW15dWpDZ1ZMR3d4clhjVldUeWRRcXo5Q2xSRDEyZ3g5ZTB4eE5EYk1CNlcw?=
 =?utf-8?B?eVdMOUh6SHcrcCtKb05oZUNkcnREeEJyeC9kdU5kTytnQ1pMd0pNeCs0Y2xq?=
 =?utf-8?B?ekhiWDlaM3hlZGJ5dit6WDNUWVpFZ0diRHpBNkkyYkFIZC9zbzlsSkh1MkdZ?=
 =?utf-8?B?eFdzMmdMYWFuTTZ5NnVROW5QY3M1bnVJazFBcHBkelZkTTNaMklFa05NaGRM?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4749499-21cc-4c98-60dd-08dbab14e027
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 17:57:15.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaFNmXub9W6CfjVtrn55hpoo3SJM32ATaZcbdQEIE8pxCw5RHHcJH9/Jh0iJhOdC64IJ3lSTIGjo+YjD3TPjLMd5V/Ng3j9mbfNwNelj1lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/1/2023 10:28 AM, Moger, Babu wrote:
> On 8/31/23 19:43, Reinette Chatre wrote:
>> On 8/31/2023 4:58 PM, Moger, Babu wrote:
>>> @@ -3336,6 +3340,9 @@ static int mkdir_rdt_prepare(struct kernfs_node
>>> *parent_kn,
>>>         else
>>>                 files = RFTYPE_BASE | RFTYPE_MON;
>>>
>>> +       if (rdt_mon_capable)
>>> +               files |= RFTYPE_MON;
>>> +
>>
>> Is this not redundant considering what just happened a few lines above?
> 
> Yea. Right. I will change the previous line to
> 
> files = RFTYPE_BASE;
> 

This is not clear to me. If I understand correctly this means that
when rtype == RDTMON_GROUP then files = RFTYPE_BASE?
This does not sound right to me. I think it would be awkward to to set
files = RFTYPE_BASE if rtype == RDTMON_GROUP and then later do another
test using rdt_mon_capable to set the correct flag. It should be possible
to integrate this better.

What is needed is:
When group is a control group:
	files = RFTYPE_BASE | RFTYPE_CTRL;
When group is a monitor group:
	files = RFTYPE_BASE | RFTYPE_MON;
When group is a monitor and control group then:
	files = RFTYPE_BASE | RFTYPE_CTRL | RFTYPE_MON;

How about just moving the "if (rdt_mon_capable)" check into the 
snippet that sets the flag for a control group?

Reinette
