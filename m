Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FBE76FCE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHDJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjHDJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:08:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8464EE1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691139976; x=1722675976;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5wnRXTe3+l6CdXR+kH8ag3xAqfr/wehlms4jx/8R2m0=;
  b=K1XaZZnx04ewWQlfwSxZCSPdxCNdQmRuj7T/hCxYFUzPhvfiDWnx/u62
   4mYY48QamcpZXxZk4FLYtvHUKXcmdZj+3RMU8619kewojX6xT9yNJn+PA
   VyeJnwtcqrkHgWEz0BHeDCpg/J29SPnQ+YpQ58Ce9qBHq+Rih1rkmxNFX
   79uOaaGymtniOTe0prjYWSCM//QHYMlPzUs9eLsS1kQa21hnwC2qxftPZ
   XIRc0kX0TwvHbkdMMihs/bLtU6bVbodSToXj1qNUoK4wJjF+DFXzrIfqH
   DWQAtmL88iInmZb6b+lzxQ6Wbs0X5oLSUyJKHTgY/0dLVA1KrTyhCR0zw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350411019"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="350411019"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 02:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723579827"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="723579827"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 02:06:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 02:06:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 02:06:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 02:06:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 02:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BErUmgsV00/O+Iepoa8Dic6buorTcsxL06CXHDHfCBuyeyetjvb39ePWBo9uYWKQvw2cHWt4+/ztfYI4A9lTLnr9oON2ynCycpHxQbeOvlar6jnwuF6uRI1noqzOdHEuGbyezA3qGSK3vcQjt/xwTrYgFJTzcXp4usaOBjtZI0yD3q9/wbb29wj0E87yNQLgTYKKa3WJdgAUyA96zhhM9JERakqZbos1B5JEpDiAKUb+SfOgwubjke6C3a8gfjjNbfCnyiFjAMDu4Wzj8tbl1lie77xu+uYljU3+lLGEzr8wzJXfILCrueHevuJU2wXyhLtKWgPbMU+8WVpyLmUWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adSP//YAv24HbQ974Me4lcwfxx3Nn1Yu+0Fdx/EqIAw=;
 b=VY8vFSPwEm4rAUDgyiXHkJJLdra57WkklEwOYvQZ2dNo0BW8K9nwyCtqkWEZkQEP35XDVa/MvBB2aI5Mt5+sTegVoEXlHZDvEidsITL+zl7HCi8n1IF5w36JhCq7Q0ULob+I2luKd+Ab+s07P/Hil1g2RWYzTLWdPeBG17fmc1f11GiYyLPDh6GkrHSFFHZXdHZkDaNHjAE7A1hZaIs7qbYzdu1y+yoJMRx1H9SPrhpDbJvzgZcolhpSr5MSwEQQ1hWfHOBIRdpEd6ujViaLAsZjFtK/Ra8IfKIJBGsgsuyi05kf60dJpApuOhzgsW27XgjTDdwcrx62DtIynaMnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 09:05:59 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 09:05:59 +0000
Message-ID: <253df281-debb-f73b-dc86-a461fa60eb4c@intel.com>
Date:   Fri, 4 Aug 2023 17:05:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <502afc9c-0760-76af-d224-2a3428089850@arm.com>
 <66332544-c102-9134-a1a5-c4e4a82b66b9@intel.com>
 <0e7c6b9d-77c4-8c06-4c5a-fdf24c3b003d@arm.com>
 <b9ec207a-8cbc-4014-1fb1-f1f437afd957@intel.com>
 <a2d71d20-973a-3642-877c-79f86e1acd97@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <a2d71d20-973a-3642-877c-79f86e1acd97@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ed4c7a-ae33-436e-e318-08db94ca0516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmxjNOcB0F03mP+foKu3Wi3PqULfK/ikct0zVPyCkxRjavDtFreQit88G7xT1LovP5u9dxqUQEO0wtUZiFtXjOWC5Mg+tEbhW8PcJYIeDTJIdpfE0xtyRlNKrav4w4WaF1gwzUcwYoEKsQzHk0u89OYILfZa/Y3SWl/Ztcp//Z1L6pJcs0CHTFbLq0hP32pJqcATVN7KafBqqgJW5A61KjiUJTHnT92kZHQUdcbFEgpMuSN4/BCTavgSiyjW1puFFoPoWT8QUfNBNnYAyuc8T504WeFajGQtFi7WmeqLuTLJCxTA+u5yPdwjJ00wugR8JeqcuxuijKeaxPQetdqVmoZpKDaKGMXiZ8NF7IDmOW1DQTeDk8FtIVE3CiayazN5cdO+TzSMQOLV9jxWZLwp+j8XJ3EWnaz8aZDdaAo6YDXQzsMTrUqgzUedXOAdtR/Hdu72RtZTG3HlLT/FoC+vPvVDF+WUrwEHczk2UMpsCZ1WDKWDhHuJqSEbrEZxs0Na2uqqIPuTfeItyT3ZL4mA2bPAJ3StJvi4eBwg3e+4uxg5hRBFNkCwt3hY1esMA5SL/TnlOBfWQIfGaPSd7akjRYWkQtwWv4bMh+a+dvmOZwuszr5Y9BPZrN/t4PV31XHHgjgu4Mzdybh2LYupATOZHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(66476007)(66556008)(66946007)(2906002)(82960400001)(38100700002)(2616005)(53546011)(6506007)(83380400001)(86362001)(6512007)(31696002)(26005)(478600001)(36756003)(6486002)(6666004)(30864003)(8936002)(8676002)(5660300002)(41300700001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0htS2MrNWQrQzBPZnlTZ0Y3cVZxWnRtN0pGTE5JMk55WUl6UjN4RjQyeGdl?=
 =?utf-8?B?WHk5dGtYYVVrck9zcGhGQjdvbk9Wc1lBWnBLMVFhOXR3dXVPZm1BcXowNUIy?=
 =?utf-8?B?OXNlMWpQc1F6RGx2ZHF3RjlKbGNBenQ5WjUrckpGVjlYbG5rZUtWM0lQaGxZ?=
 =?utf-8?B?eXppUkM3ZkVLVy9yb092d2V0UEk4YVpQWlNtWmRMNm1tUVN1ek1HTXl4UHdZ?=
 =?utf-8?B?bElPZFhWdVpFMVQrS3JKSmNBdzZiSWZWNy94aWdkMzY0UlF2WVJFeTcweFZ5?=
 =?utf-8?B?UTN6THFia1FVeUNWelVZV0hNOFlWMGYrVlR6bVBFeitjemwrdnVaTDdiQlVz?=
 =?utf-8?B?SDRFdXowa1VRdURqK2oyUzJUalgxbGtDZ2NEZEc1YnVvSWFweEE5cXk3OFdt?=
 =?utf-8?B?MzQ3MFR5a05XZ2dOcG5zaStnWWJJa1hvSm53VkRuU3lTS0lydHB2M09MU2pQ?=
 =?utf-8?B?bFVZd1JJcm1ybmoydElNZFJ4UGpjeVZDcjBzczhPODRUU3JaMDZiT01oTkdM?=
 =?utf-8?B?bUVXUmM0ZTB4UXVXMVFic3BGZURyVllhM1BQR0NLZmNiR3lHcVdxS3R5cXdC?=
 =?utf-8?B?VDdteEpJZ0NYZUVISm5KajFLYmZzNCtvK3B0Nis1Y0tNdVNzNHQ3dHVoRkQ3?=
 =?utf-8?B?eDFWU1krYjlFb3NSdjBaN2toWUJueXBXY2drQTJXYWMxaGVwWS9WdStod2dk?=
 =?utf-8?B?RzBHQTBOVGhxSFQxUElQUWVrdk4rUStxNExCOUg1SzZYSnRKd3NyaFhaaWIx?=
 =?utf-8?B?TWRxbG02UWtlRjZJL3YrRmZranZNZ1RpcDRzeXRGeVVhOFFraE81UWNGYXI5?=
 =?utf-8?B?RTlSOXAxdlQrcDdsa2RMV0FOR0c4cXRnemNHdWE0ejdrM2FadmRES0hsSFpy?=
 =?utf-8?B?SUxlalVCOUp0OXo5TDBXbzZtbmFCcERsa1B2RkZwZERqV0Z0NjIrb2RUdGw1?=
 =?utf-8?B?bWUvR09CWVlIYy81VDhuKzdHbTBLWlZlc0xLeFM3K2lGc0J5Q0NJQkNFbXVR?=
 =?utf-8?B?Lzg1MUJyeVlKa1dNQzhrTVNZTGJqMzZ3a3dPSHBuOTFVRisra2s0cHVkNXNL?=
 =?utf-8?B?dUpKbm5TL2lkS2Vza3IzamVwK0d5QjFtMy90VDdqNGFwU2d3SHNKcjdLWnhR?=
 =?utf-8?B?dy85bkUwb3VPcDF3MlphUWpzRG45MkNRSi9neDY1TTArNDFvbnlTaVc4Nmlu?=
 =?utf-8?B?WGpKMnlOM244RkNIOWlod05QOFNKTU45VThDOGZBNjZxaDB2U3ZUaFRmazJK?=
 =?utf-8?B?NitjNDBzVHZkWXBwZmdGUWZBM1JmdTlSZWV2eGc1RXdwSm1zMCtob0ZtZEEz?=
 =?utf-8?B?VGVZb3pIaWR6Q0lzekp0SERYd25iK1V2QjllRElRWk9rOUx2SnZPR3Q5WUpw?=
 =?utf-8?B?ZkpGTlcrR2RpUnNFQ2pnRmxaMzJwNXdXaFZkdkNrc0JxdCtDYStvcDhzcWJF?=
 =?utf-8?B?Rk1vaUZaMXJXanQvMU9oQmZ0YTJxb005dGc1YnZrUlp6TFQxZWpoMlJwYUMw?=
 =?utf-8?B?bml6T2tzNTNDSTdyRDdRUUZLN01nYWdoTnFzYUtMVFZZbnYrQkUvdzJVL0VO?=
 =?utf-8?B?cUMzS1d1NVNJSWpLanRHdi9saFpualRaYUlxUUI3OHBUUFpaWSs1YWdDeDda?=
 =?utf-8?B?NFJNOXpvT09KVnhxU3IwWWk5dTJoRDJzcldwenMzQ3JWWFFtVmpIcmpQUDRG?=
 =?utf-8?B?TG1GYUFqNEpNYnJHV3FWVkZRakV0TDh3ZDdzWktJditWR08wT05SL3paa0x5?=
 =?utf-8?B?V3dIWXZEUlV4bGFXdlFOcHZnREhFZHJ2eU1ncGF5OWFYY293OVF6SGs3RHpU?=
 =?utf-8?B?SjBLSWRsbVBXL0xOMVNpbHV4VmYxK3VCSUZjWW5QcW82bW5OUTFlWXhCY3NM?=
 =?utf-8?B?K2EvbExEeDc5NmZKU202QVMvR3NCRW0wTzROQ1lHM00zWFM0bU1rWjhrYTd2?=
 =?utf-8?B?OFJIdGEzK0FNOUVvQTJJTkhseGkvT3I3eXB0YWdPTHJGZVFOZTlUTXFreWRa?=
 =?utf-8?B?UThiYmhBaWVNSUxuNWxUK3hPNGNwKy9ob0V6OFd6aGJIMC9NbDl6aGt0VjlM?=
 =?utf-8?B?ckk5ejFBWlNrZzIrOFNMSFlHRVZmRGM2TnE5azhUQVpwQjZsd2t0aUlXUU1M?=
 =?utf-8?B?Ui9tZVNraXFHNzg4SFF5bFpnTFFQNjF6T2cxS2kwczVRNjBWbGIzeXh0WFJq?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ed4c7a-ae33-436e-e318-08db94ca0516
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 09:05:59.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TS77JMQx14Fo4fC2DunVEsYJO2gvfpLvyQZ+3NUd8AJWL8hBjE8P6N5YeSRXtetYSAYdw/bHr4sAsh4QJbU2cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 8/4/2023 4:46 PM, Ryan Roberts wrote:
> On 04/08/2023 00:15, Yin, Fengwei wrote:
>>
>>
>> On 8/3/2023 9:20 PM, Ryan Roberts wrote:
>>> On 03/08/2023 11:48, Yin Fengwei wrote:
>>>>
>>>>
>>>> On 8/3/23 17:58, Ryan Roberts wrote:
>>>>> On 28/07/2023 08:09, Yin Fengwei wrote:
>>>>>> It will be used to check whether the folio is mapped to specific
>>>>>> VMA and whether the mapping address of folio is in the range.
>>>>>>
>>>>>> Also a helper function folio_within_vma() to check whether folio
>>>>>> is in the range of vma based on folio_in_range().
>>>>>>
>>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>> ---
>>>>>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 69 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>> index 5a03bc4782a2..63de32154a48 100644
>>>>>> --- a/mm/internal.h
>>>>>> +++ b/mm/internal.h
>>>>>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>>>>>  				   bool write, int *locked);
>>>>>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>>>>>  			       unsigned long bytes);
>>>>>> +
>>>>>
>>>>> Hi Yin,
>>>>>
>>>>> I wanted to take a step back and consolidate my concerns about this function. I
>>>>> should say that my understanding of the pgoff and index stuff is shaky and I
>>>>> could therefore be wrong about some of this; if this is the case, then sorry for
>>>>> the noise! But something about this function doesn't smell right to me, so I
>>>>> figure its better to raise it...
>>>> No worries. And thank you for looking at the code ans share the comments.
>>>> That helps me a lot. Really appreciate it.
>>>>
>>>>>
>>>>>> +/*
>>>>>> + * Check whether the folio is in specific range
>>>>>
>>>>> What exactly is the function trying to do? I *think* the intention is to figure
>>>>> out if a folio is fully and contiguously mapped within a range of virtual
>>>>> addresses belonging to a specific virtual address space? And I assume you want
>>>>> the answer to be precise? I'm assuming 'yes' for the below.
>>>>>
>>>>> I think the only way to do this is to actually check each PTE. And that causes a
>>>>> problem, because a folio can straddle multiple PTE tables, which causes PTL
>>>>> locking issues, and means having just a *pte pointer is insufficient if we need
>>>>> to traverse multiple pte tables. So perhaps you need to allow for a false
>>>>> negative in the case that the folio is not contained within a single pte table.
>>>> Let's check the users of this function first:
>>>>  mlock/munlock: Needs only care whether the folio is in the range of VM_LOCKED VMA
>>>>  madvise: Needs to check whether the folio is in the range of VMA and
>>>>           range [start, end).
>>>
>>> Sure but those 2 ranges (the vma and the user-supplied range) are known to
>>> intersect, right? So really there is only one range of interest; the
>>> intersection. I would argue that should be done in a higher level wrapper, and
>>> is not part of the core primitive to work out if a folio is mapped to a
>>> particular range of virtual addresses.
>>>> This range is from user space. It could contain
>>>>           VMA range (in this case, we only need to check VMA range) or is contained
>>>>           by VMA range.
>>>>
>>>> So we check:
>>>>   1. Whether the folio is in the range.
>>>>
>>>>      To do this, we need to first check whether the folio->index is in the
>>>>      VMA range. If not, we know the folio is not in VMA range. Just return false
>>>>      without further check.
>>>
>>> Right, so if the check fails, the folio is definitely not mapped by the vma, but
>>> if it passes, it *might* be. Further checks are required. So why is this useful?
>>> Why not just do the check that gives you the precise answer and skip this?
>> What check can give precise answer? I don't think checking PTE is right at this
>> stage. For following case (assume the folio is mapped in same page table and just
>> care about the VMA2 range):
>>
>> |-----------vma1-----------|------------vma2---------|
>>                     |-------folio-----|
>>
>> How can we tell whether the folio is in the range of VMA2 by just checking PTE?
>> And in this case, why not bail out if we see folio is out range of VMA2?
>>
>>
>> So only need to check PTE if we are sure the folio is in the range of VMA2:
>> |-----------vma1-----------|------------vma2---------|
>>                               |-------folio-----|
>>
>>>
>>>>
>>>>      Then, we will check whether the folio is in the range which is defined as
>>>>      [max(start, vma->vm_start), min(end, vma->vm_end)).
>>>
>>> As par above comment, I would personally factor this out of the primitive.
>>>
>>>>
>>>>
>>>>      This is the version in RFC as I was not aware of mremap case and forgot the
>>>>      page cache case. So if no mremap with an anonymous folio, this check is enough.
>>>>      But we need to add PTE check for mremap and page cache cases.
>>>>
>>>>   2. Check PTE for mremap in middle of large folio and page cache
>>>>      If the folio is normal 4K and if the folio is in the range, it's not possible
>>>>      the folio is partially mapped to two different VMA. So we are sure this folio
>>>>      is in the range.
>>>
>>> But you test for small folio and exit early without checking the PTE. Given the
>>> index check only told you that the folio *might be* mapped, I don't see how you
>>> can return true at this point for a small folio, without looking at the PTE?
>> Yes. We can do this. You can check the discussion on the RFC version. I did move
>> the normal 4K folio check out of this function. Yu and Huge suggested to just ignore
>> the normal 4K as this API can' handle it.
>>
>> The thing changed from RFC is that we need to check PTE here. I tried to avoid to
>> check PTE even for normal 4K folio.
> 
> I'll go read the RFC. I've made my point; if you and others are convinced this
> is correct, then fair enough.
Thanks a lot for your comments. I will work on new version based on your and Andrew's
comments.

Sometimes, I blindly assume other people know the assumptions (like at least one page
mapped in the VMA) I made. Which did make the review harder. I will try to improve
on this in the future.

Regards
Yin, Fengwei

> 
>>
>>>
>>> folio->index is just the page offset within the file it maps (or the (original)
>>> VA/PAGE_SIZE for anon memory - I think?). And vma->vm_pgoff is the page offset
>>> within the file that the vma starts at. So you could have a folio that contains
>>> the contents of 1 file and a vma that maps another file, and the folio's index
>>> might fall within the VMA, but it doesn't mean the folio is mapped by the vma;
>>> its a different file.
>>>
>>> Or perhaps there is an assumption in the function's spec that the folio is known
>>> to have at least one page mapped in the vma? That would change things... but you
>>> should make that very clear in the spec. And in that case, you can move the
>>> small folio check to the start and return true immediately.
>> Yes. "At least one page mapped in VMA" is assumption here. I will make it clear in
>> the comment.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>>      Currently, check PTE didn't handle the case you mentioned. But my plan is
>>>>      checking whether the folio is mapped cross page table (by checking whether
>>>>      the folio start vaddr and end vaddr has same value for low aligned to PMD_SIZE).
>>>>      If it cross, I will treat it as out of VMA range. Otherwise, we can reuse
>>>>      current check because we know the PTE pointer is always valid.
>>>>
>>>>      Obviously, the PTE checking needs hold pte lock as you pointed out.
>>>>
>>>>
>>>> My understanding:
>>>> pgoff is important if we have folio and VMA and want to know the virtual address of
>>>> the folio mapped to. Like first, check whether pgoff of folio belongs to VMA, then get
>>>> vaddr by:
>>>>       addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>> rmap_walk() also depends on pgoff. You can check the vma_address() and rmap_walk()
>>>> implementation.
>>>
>>> Yes but the rmap is only traversing vmas that are already known to map the same
>>> file that the folio contains pages for. (See rmap_walk_file(): it grabs the
>>> "mapping" from the folio, then traverses the list of vmas within the range of
>>> interest "vma_interval_tree_foreach"). Its a bit more complicated for anon
>>> memory but I think the princple is the same.
>>>
>>>>
>>>>>
>>>>>> + *
>>>>>> + * First, check whether the folio is in the range of vma.
>>>>>> + * Then, check whether the folio is mapped to the range of [start, end].
>>>>>> + * In the end, check whether the folio is fully mapped to the range.
>>>>>> + *
>>>>>> + * @pte page table pointer will be checked whether the large folio
>>>>>> + *      is fully mapped to. Currently, if mremap in the middle of
>>>>>> + *      large folio, the large folio could be mapped to to different
>>>>>> + *      VMA and address check can't identify this situation.
>>>>>> + */
>>>>>> +static inline bool
>>>>>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>>>>>> +		unsigned long start, unsigned long end, pte_t *pte)
>>>>>
>>>>> The prototype looks odd to me; Fundamentally it seems to me that you need the
>>>>> folio, start and end virtual addresses (the range you want to check that it is
>>>>> in), the pte pointer and the virtual address that the pte represents. That
>>>>> virtual address allows you to figure out the offset between the pa and va. Then
>>>>> you can look at all the ptes to figure out if they reference the folio's pfns,
>>>>> and use the va to pa mapping info to figure out if its within the specified range.
>>>>>
>>>>> I don't really understand why the vma is useful.
>>>>>
>>>>>> +{
>>>>>> +	pte_t ptent;
>>>>>> +	unsigned long i, nr = folio_nr_pages(folio);
>>>>>> +	pgoff_t pgoff, addr;
>>>>>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>>>>> +
>>>>>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>>>>>> +
>>>>>> +	if (start < vma->vm_start)
>>>>>> +		start = vma->vm_start;
>>>>>> +	if (end > vma->vm_end)
>>>>>> +		end = vma->vm_end;
>>>>>> +
>>>>>> +	pgoff = folio_pgoff(folio);
>>>>>> +	/* if folio start address is not in vma range */
>>>>>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>>>>>> +		return false;
>>>>>
>>>>> Why is this pgoff calculation helpful? Surely it's only useful if the folio
>>>>> belongs to the same file that the vma is mapping? Otherwise the folio's pgoff
>>>>> might be referring to a completely different file than the vma's vm_pgoff. So
>>>>> you will get spurious results.
>>>>>
>>>>>> +
>>>>>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>>>> +	if (addr < start || end - addr < folio_size(folio))
>>>>>> +		return false;
>>>>>> +
>>>>>> +	/* not necessary to check pte for none large folio */
>>>>>> +	if (!folio_test_large(folio))
>>>>>> +		return true;
>>>>>
>>>>> I don't understand why you don't need to check the pte for a small folio? As
>>>>> above, if the folio doesn't belong to the file that the vma is mapping the above
>>>>> checks seem wrong and you can't conclude that the folio is mapped in the range
>>>>> without looking at the pte?
>>>>>
>>>>>> +
>>>>>> +	if (!pte)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	/* check whether parameter pte is associated with folio */
>>>>>> +	ptent = ptep_get(pte);
>>>>>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>>>>>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>>>>>
>>>>> I think this could wander off the front or back of the pte table into arbitrary
>>>>> memory if the folio is strddling multiple pte tables.
>>>>>
>>>>>> +	for (i = 0; i < nr; i++, pte++) {
>>>>>> +		ptent = ptep_get(pte);
>>>>>> +
>>>>>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>>>>>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>>
>>>>> Doesn't !pte_present() also cover pte_none()? So I think the pte_none() check is
>>>>> redundant?
>>>> I think you are right. pte_none() can be removed here.
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>> Thanks,
>>>>> Ryan
>>>>>
>>>>>
>>>>>> +			return false;
>>>>>> +	}
>>>>>> +
>>>>>> +	return true;
>>>>>> +}
>>>>>> +
>>>>>> +static inline bool
>>>>>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>>>>>> +{
>>>>>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>>>>>> +}
>>>>>> +
>>>>>>  /*
>>>>>>   * mlock_vma_folio() and munlock_vma_folio():
>>>>>>   * should be called with vma's mmap_lock held for read or write,
>>>>>
>>>
> 
