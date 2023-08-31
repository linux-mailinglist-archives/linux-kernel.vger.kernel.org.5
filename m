Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B94578F217
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbjHaRmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjHaRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:42:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C8CF3;
        Thu, 31 Aug 2023 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693503771; x=1725039771;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ChgFEwBuhRPds7hGCbcm+sApIa6xGr1pxW8Lsj3f0HY=;
  b=lZ2siF+mv1U5hkBv9kO8OcO/JbMi0D0FdDjdC8PULbNru+M6ifvcMwXI
   fi2Y/fnmoDxu1e+ZXOouM+A+g+2z5VKAgJOxhhrtGjaz02E/2INHefpWM
   75nj0IbkRsT8by6wbAo5f61CuHFcqdBUEjEA5iEp2inYDl5SlOvCqrr79
   A1l+bruR93jtKS+sUBJFQ3Pn7RqZNExYSysE4CgmBqYAObHoOJcKQCNZh
   /FsmtQMl3Tj8z9Z9UcWuAgrrKGx0S4BijcrosXRnqlp/eEevIc/XzqAtP
   Qnffp3S2AOOXpqdfFMMh58JFriNwVtn664bv1qQLvAtkOIqw1y2Yd2b3i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442413335"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="442413335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 10:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="774673395"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="774673395"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 10:42:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:42:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:42:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 10:42:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 10:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHmQmoVC4X54mAdRUaPylJ1i6SWdt27h6/1V0cQRNWdZPKzNvqvhC2aAPEbhqtOzRAmGqxayoeSaJSxNfq0Rwg2Z8NF5fi9ppaJAudfBEA1vXrfbOeq+RGJFHo0tiZFN+8qBR4vwHHNr5ibYvR7kCQmodzpEViN514ja9219Bk2+WXIMg7zTJAzyC+oNakSYySBbq4fETuj/KUw+5kyPtmbxcI6Rj9AKUzLN/sYgVeDpomp1w8EWleH59B0hAjEdt2trlMqntwJrhPfcpPL+EFLPaeO4H8+lNmtF1GQ62zu+9U/zcaTMKOt7zPtm6YpqY1WmjxRwLjJ8CCHtvcjhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgtBkRim+VfRjDou54hVHsdNEHCoueK8KwjN0Ldu4jI=;
 b=OM198W8h/nUXQxT+vI9QiFYu3IbNSNQQ6voYq7ixew9potv4Ca0rsZ3Gdgg9Ds2cGQfVg90SK+/8tII9+c5s5P5T2Mz86D93dCthtWrXSlfwy7irDwAedXBa6UNSyOQpT1zfj1DKu5ZZ759AAjQKBvat7yIC9yBsvgZMG+bjsUSPq0klEhrNEgzMWSDI3/ojCP928exm25q8zS0FjpL1xzkvCpPHRS+f9owoLFdVmTH9f1wpXFZowQUTkz+Q/x0QG4Y4mmwEuKrMNj3P8TfN1nnaC4GzyapiX+caxqjtgOslY+ac2ajiN3+B/ZJ7rHqQUjdEL1/RpnEZk+eUih3s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8690.namprd11.prod.outlook.com (2603:10b6:930:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 17:42:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 17:42:43 +0000
Message-ID: <5b75506b-80ac-a89d-4b70-f775c3b354d3@intel.com>
Date:   Thu, 31 Aug 2023 10:42:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
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
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <da47698a-aa9e-3760-1321-5ec3ea1a14e6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c70b46b-f8b8-491e-d306-08dbaa49ade5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEp8r5MKz/ERjPyZaLy7ucL0iVBXv+muqs7G7FChfmcwxnHzfeg46HgMrTykhAPJsk1J46Cx/KB5FIJhmp/qbPNiC+LsVsubIk+5+zbBDgVeI5FNaQ6FAPqzoIfvQCA6aAHMGsVt/lUTCF95W4sVvVxreDxClvD91f0QUUiQa0+C2KBySbgN//C0e38y1QmTEJn2LTqx+SYCAThUScwwfpN/sRGh15jTJckQnboIcGjTS3+7EkPBPcnLR1Jf9RSxUWWW59vsLs8PWu6+dEtwBp5UltEAw6L3eqK5AU7owCKWJ+4zhAp4zpCA0rx4rOxrFNEB4/DL8nkHUTkgT8MggV2V/ZWSpG31gTyhUvtmgiEfW9++yBh11xGR6Js+SMgF26ejulmAtgtrXaGBIg6n1kZHPWP1P80hREm9kUZioogXjAtn0keI3PtpiDqMd9vF1adWe1XdU0JTNf0nakBp6BR9Qxw4amNxcJ8+uo/9p6NneKWx7e4vWvgKqTV45sSChsRHs1KksuyI55mZtuh+l7wC7EDH/GTUQRXwNuPs1C6yBtu0Pl00faXxsT+ozfck5dtD+lqAVDlo/MQz4LsDDwzpSkNv9As1oJ4/5r9oWzfwcv9l0s74F0tGbFVAR4SK8QjHhV0H9zCbQiqUngHA2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(1800799009)(186009)(451199024)(31686004)(6666004)(6506007)(6512007)(6486002)(36756003)(82960400001)(31696002)(86362001)(38100700002)(2616005)(2906002)(26005)(53546011)(83380400001)(478600001)(66946007)(8936002)(8676002)(4326008)(66476007)(5660300002)(7416002)(7406005)(66556008)(44832011)(41300700001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1lvV08rT0o3ZnFoTVI0cEtvU1Z3MXhxYmdCbjdNNVlNdVVWRUVqWTllYURy?=
 =?utf-8?B?b1NGNElWUmxVTmtlMVQrSFhoUDE3RXZ5bDhYQzlBNmFJc0FDbzhmSVNDS1g5?=
 =?utf-8?B?dThrbGkvblJSY21LT3U1ZkF6aDByemhQcXJkMW9uUmt3ZTBkR2I5cjllRjNV?=
 =?utf-8?B?Z25nSmxrYU5ETFR6eGlQTW1Wc3hhNDlKNUFxMVRWTEFNL1c4Y0hVT3RIWm5x?=
 =?utf-8?B?L0s1TlUzRkFwNVdLejFrSzZOR1BZZk5EYkYwTnd1Rno4bXA1d3dybXlSc2Uy?=
 =?utf-8?B?dmNTMW55bGR5QXB1ZTZQRDFUQjVHVkxWWXV2M3A0TmEwdjlXRmI4NXk1M1JE?=
 =?utf-8?B?VEp4dXBSVHZDdHgrV0RLbVFINU1UZ3BhTTlCVkNrYTNRS2p2SFdFOGZ2OURk?=
 =?utf-8?B?NnJvMWxmcTkwSzdaYWVKVW15b2w2SkhTRlBRd3pnQm9yb0RNd1o2cDJ0emFM?=
 =?utf-8?B?QWVuN3FHb0FqS0haTTlycGZWNFFXVWtKekVCdW5JdFgydExOYWdINnJ5STdL?=
 =?utf-8?B?WGkvMWx1V0QvNHFZenVOUHQ0VUpSV3VlSVlDWWx0NTBsZTlLU1Yvai9xS0Z0?=
 =?utf-8?B?KzZ5VEdWQ0VaMjE5ZUtOUmh6YkRiYkc3ejJOMGpGdFJTVkRndDUvU0dDSjN4?=
 =?utf-8?B?REJqNkhJa28xRXNaK2E3anZTUlpnYkFDSldwRFhibE9VWnZGa3g2T2tXTGo2?=
 =?utf-8?B?K0pIWUxOMWdvN2FuaU9XRzJGaXVsU2lOQnF5cU9aVjFWRi9sbWF4V2x5OUhz?=
 =?utf-8?B?VCs3QmY5QlZsa1UraGZ6ZHIrTEkzRGJRVEVOelIwZFpnMUZmalZhSmZBcUYr?=
 =?utf-8?B?T055bWNXMlQybkJiLzBzWEw0N2N6WG91eWhjTHBxSWo5dnpacVFnMUsvTzlF?=
 =?utf-8?B?TDNDbHRrVTc5ZEVtVVYxcnhmeUtIZ2NsTFN6aUU0elNicHpjYUpTUUVvck9v?=
 =?utf-8?B?V1pCQlorcVpUMy9xNjU0a0liNW5zenhQcURVRGI1YkFlUmFYcGYydlViVUla?=
 =?utf-8?B?YVQrbnZWOTFDZmdkd0RXNlVBZFI0amNvVExqYWo2VC94VEFORXJ1R3FZNW8x?=
 =?utf-8?B?QUhqaGdIclNLUWwvdXlTRTRkYlFPb2JHNjVHeXVoQkplMTlUVFMzMUIvZHlj?=
 =?utf-8?B?NmRZS011K0NxZTdlY1czZmRWRFhVVFB2R1k2UFl4L2M4bHdYanJXM3JydE8z?=
 =?utf-8?B?SlEveHREQUN2MmdUdlVSc1hLTFlhY0JSZmRFUTQ2dHYrSEkrNWx3cm9JcjZ4?=
 =?utf-8?B?R0xRdHhUZVloNTNnM3IrYmh2SjZSbmZVSjVUZFdkYy9JSFVjSXlQR0paM000?=
 =?utf-8?B?L2l1Q0RGS1g1TzRBMVRWOHpoY3Y3cXh5Q1B1U2s3SFBrRmFKSlFONFVhL3lv?=
 =?utf-8?B?S20zd1pROGhiYWRpWU5nQVA1ODZsVDVRenpUTHBvZEpPbTJUUGVsakZXemJ3?=
 =?utf-8?B?RzZTQTFTTkRMVWhqeW9ZcUw5WEtZa1ZCVnJjeEYwL1JsUUtnMmlrdnlqRjRC?=
 =?utf-8?B?dE9EZWJ4dGc0cGsrKzhRVTlFQUkzMVJxWkpDbjRDZXNWbVY2eFcxT0ZWejk2?=
 =?utf-8?B?YUpTOWs2N3RPdUtNM2kzblBxdk1QOUc2cWtZOW5hbWY1SkdoVldkcjg3clRq?=
 =?utf-8?B?QU00YURNK1c2aU41WFFscUJFaEY5YVlSU0lyWEZqdVhzY2hoWWlsbjNTTzU2?=
 =?utf-8?B?dUhiQmorMzE3bmhsNCsyQWNjdW5vWjMwZGdCRkYyaEFBZGUyaDFQdVZrR2Vx?=
 =?utf-8?B?ckpLT09IK0hLS3o1emFjTnBuemx4djY3aVZIZElkZGZRMENNL3NkbFB4TnpB?=
 =?utf-8?B?QmZCR0FWTDlROG1lankzM3NsRFQwRDVJNzlKYjh5ZGVCQXhaWUUvWFFXMEpK?=
 =?utf-8?B?Z1QzVUFSckk5MFh3c1R6T0dRbXdHSU9hVUNQSUVFWjVWOE1FSzArS29mczAz?=
 =?utf-8?B?dnJYekRJU1l5VkxCZ2JWa0J6WjlLUEl1N1MwRldOOTNBWU02THlsR1hXaDlL?=
 =?utf-8?B?UUVYQlIrZGp4WFRwRTFxcVpYd1daT1VYRGZDQWZ6RVJwRlZTSkNFbFJhRSta?=
 =?utf-8?B?OVdaYklDWXFEdW1qaVlzMWZSVlRSSUZ4SEdLSFNuWStGdk5iVkplYzZIVXMr?=
 =?utf-8?B?VTVRdFpqaWgwRVhFVmhFQXY0eFM3cHlYSEI4QTZyK1pzREd0MFU2V2dSL0t3?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70b46b-f8b8-491e-d306-08dbaa49ade5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:42:43.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLaPPunawtVF3G098hs35c1X7P14B9Nh+Eie6wgdsgD2eMLHKjFPBD5zciAykjMIQHK6fJFe5FxMTfyNalQWhvDQqiC1Uj45DGgtszauc8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8690
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

On 8/30/2023 4:19 PM, Moger, Babu wrote:
> On 8/29/23 15:14, Reinette Chatre wrote:
>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>
>> ...
>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 2fae6d9e24d3..3fa32c1c2677 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -296,9 +296,15 @@ struct rdtgroup {
>>>   *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>>   *	    Files: cpus, cpus_list, tasks
>>>   *
>>> + *		--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>> + *		    File: mon_hw_id
>>> + *
>>
>> This does not look right. I think mon_hw_id should have RFTYPE_MON
>> (more below).
> 
> I am not sure about this (more below).
> 
>>
>>>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>>>   *		    Files: mode, schemata, size
>>>   *
>>> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>> + *			    File: ctrl_hw_id
>>> + *
>>>   */
>>>  #define RFTYPE_INFO			BIT(0)
>>>  #define RFTYPE_BASE			BIT(1)
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 94bd69f9964c..e0c2479acf49 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>>>  	return ret;
>>>  }
>>>  
>>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>>> +				struct seq_file *s, void *v)
>>> +{
>>> +	struct rdtgroup *rdtgrp;
>>> +	int ret = 0;
>>> +
>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>> +	if (rdtgrp)
>>> +		seq_printf(s, "%u\n", rdtgrp->closid);
>>> +	else
>>> +		ret = -ENOENT;
>>> +	rdtgroup_kn_unlock(of->kn);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>> +			      struct seq_file *s, void *v)
>>> +{
>>> +	struct rdtgroup *rdtgrp;
>>> +	int ret = 0;
>>> +
>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>> +	if (rdtgrp)
>>> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>>> +	else
>>> +		ret = -ENOENT;
>>> +	rdtgroup_kn_unlock(of->kn);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>>  
>>>  /*
>>> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>>>  		.seq_show	= rdtgroup_tasks_show,
>>>  		.fflags		= RFTYPE_BASE,
>>>  	},
>>> +	{
>>> +		.name		= "mon_hw_id",
>>> +		.mode		= 0444,
>>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>>> +		.seq_show	= rdtgroup_rmid_show,
>>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>>
>> I missed this earlier but I think this also needs a RFTYPE_MON.
>> Perhaps patch 3 can introduce a new RFTYPE_MON_BASE to not
>> have the flags of the two new files look too different?
> 
> We have two types of files in base directory structure.
> 
>  if (rtype == RDTCTRL_GROUP)
>                 files = RFTYPE_BASE | RFTYPE_CTRL;
>         else
>                 files = RFTYPE_BASE | RFTYPE_MON;
> 
> 1. RFTYPE_BASE | RFTYPE_CTRL;
>    Files for the control group only.
> 
> 2. RFTYPE_BASE | RFTYPE_MON;
>    Files for both control and mon groups. However, RFTYPE_MON is not used
> for any files. It is only RFTYPE_BASE.
> 
> Because of the check in rdtgroup_add_files it all works fine.
> For the control group it creates files with RFTYPE_BASE | RFTYPE_CTRL and
> RFTYPE_BASE.
> 
> For the mon group it creates files with RFTYPE_BASE only.

This describes current behavior because there are no resctrl
files in base that are specific to monitoring, mon_hw_id is the
first.

This does not mean that the new file mon_hw_id should just have
RFTYPE_BASE because that would result in mon_hw_id being created
for all control groups, even those that do not support monitoring
Having mon_hw_id in resctrl for a group that does not support
monitoring is not correct.

You should be able to reproduce this when booting your system
with rdt=!cmt,!mbmlocal,!mbmtotal.

> 
> Adding FTYPE_MON_BASE will be a problem.
> 

Yes, this change does not just involve assigning the RFTYPE_MON
to mon_hw_id. As you describe mkdir_rdt_prepare() does not take
RFTYPE_MON into account when creating the files. Could this not just
be a straightforward change to have it append RFTYPE_MON to the flags
of files needing to be created for a CTRL_MON group? This would
support new resource groups and then the default resource group
would need to be taken into account also. What am I missing?

Reinette
