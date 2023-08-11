Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9314E7784BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjHKBGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHKBGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:06:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2042709
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691715979; x=1723251979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AgRwU6rEOCzaoPTWHSxjGRniF1e5nhGutZ2D0UeSRCw=;
  b=hMUb0nMAT+RhGmIYIAfG68A3RUk1BLNnRUOxjl3ima7cZvrACKD0UUbk
   zzzxn6x7rEXO4wqU1eaUrWWwNMYbGT9mMR434ECgdOFdIM9esxTnpvlLb
   +cSSVzZ96xdQeJWOS/kFnb4OV51MfWWu3HCrgoDsB+PecWTQMdbJ1Sn+e
   7lfmOjsq2b5IbTyDAeHw4f4DtfcD+xjyzHvT79sggU4dn2+4dm0dDNl50
   s4fZH5vZu8mj5OF5a4gb1h13aO0HO2CT8RGW1BzSDtOC+WiiI8EGD6pzV
   pBWF348KorOh00m37idxUBwzhXXzasAIakKuNAhHDoCTax/yX/7WG6K6S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361702599"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361702599"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875971655"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2023 18:06:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 18:06:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 18:06:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 18:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiEg5T/lRNkvJHETTRw/kx2Hclvo6P77l8QVm16JRkb3LUhT0MTLBbR3fDueWtVmBYcwr4EuAald+kU64tHcCvYwKYbYzJ+SQSF3PIDzIjIIjxquruUFvyUoE/e3lX1nL7y8YW656AK8549gW/b+msbGBhGPtXiusxC0Bwv/64+m7JYHPlr3a6P4TUnK7MFPTGtK8MYBfzNze8Ev5fvo5Vc7FZUIOO/Op5FoW2lr4Twc8ffQaFF5NVcAjgoAC6hIHxCg+fGBVcIBrF7tX0PA2I9LAc3Z77hqlkjqHPI1FJF2eu0y0y6txhtpBuKDbrGw1J3YyzH7fHq4OzZGuuRshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxJIsYgXhNJeFnjroajmIvzPRn9bEEYPlGS4ATwFZg4=;
 b=hgNUjQmDDDUocOrr6MckvT6ToXv9Lxr4r3LYSmdaAfMYkfdlKUyZNbS9GtbyObCw0CfwPY+4qMmh1prz9qtD2aASSt1kuhJEQ4Ze0hDmF0foJwHW9iuXPUAhokMqpshwHZ5fo9cZLjzDyyReHdUKsmirEJD1SUAJLif0r10FO0C518T2KoMGySIX4aNejx5tK+rrZTJKfhTyFuXVNyLO4fUkNL3yaFuG4OD54zaK3ae/1FmZU2Vb1+AAm5CW4iZedMkyMxS+ezZ1MsunmaqXNanPk39gu9jvp0zS/zP3Wro8UlzadvzfJBNUSrxEPvu2tMQcVOdctY1ZD16y1i2LQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by IA0PR11MB7862.namprd11.prod.outlook.com (2603:10b6:208:3dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 01:06:16 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:06:16 +0000
Message-ID: <41e8dee7-e5f8-4c6e-24e9-4e33cf53fb38@intel.com>
Date:   Fri, 11 Aug 2023 09:06:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
 <BN9PR11MB52766D5CF4F959D58E60C9238C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <86ecc67a-8567-f3b3-02c9-572474af8e72@linux.intel.com>
Content-Language: en-US
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <86ecc67a-8567-f3b3-02c9-572474af8e72@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|IA0PR11MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8e9f5d-a49d-439a-57e9-08db9a0729a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAQ67+1P2T+6BkAF75vR2VdXG2P9j8k+iCZOy32eBEbYFm9W4+I6uIKx3X8YHV6F9gyQTb5XRW1DNIiV1Ebs4d0ZBZXZTFalDLHgtFQZqgaW1JsMHq1zjmyzdH/gN4yMywADEJDNON0JXbcsWgy6ANwbtsp/mSic545KEf0f5WY2F2/tcrLihGl6kjwlrebyJCxQYKK5TAuuUdxpMAfvoPwUURto251pe3oRSvBelwtoLtCEzGxpe0DNZNIUrlXGJzNDJUEii2VDrTcNn5wQHoZb75JABzY2Beu5k75X4VsavO2sC7R1kWSTyUFFSKcGThEtHJ+c1xoeYMdY4IPs/FwkzAU9SY8WftWZRZgfH8K2qKTwm5lSO9Vh6d7kI3gDHRHJcrjoFsQk/fDWAK0uHAjtA8RmRU5ur+etEXZKGLWfiYQau7mcfQEZrFvepfdwsn9XcZegWQ+gjvjrGgmvbQ5Q+39pUPMq7cEztrl0qrrv6KylX6sj1D0cxGeJYXXeRR9iQE1UVbeWy0BTgvZgik7UWioYiP9Jc56CEt3QN8BKFG4XQchDMI/Vnh0BbYhdi7x/fqYlPrK24cwbZte8cH3IFJyEHghaaYmGCTuyy05wFIZcJIny+Y+xByzqipDuswB7iNhvUAsNEA8D8vZJPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(186006)(1800799006)(54906003)(6512007)(31686004)(110136005)(4326008)(66476007)(66556008)(66946007)(316002)(478600001)(6486002)(5660300002)(6666004)(41300700001)(8936002)(8676002)(6506007)(26005)(53546011)(86362001)(31696002)(44832011)(36756003)(2616005)(82960400001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTBWOTQ4eG51N3RRdHAyOUUzRnVoMzNLeHNJVUNkdzR6QjNHTTlxOHlySE42?=
 =?utf-8?B?eFV0WkNYN1k3RDdncVp3aHRGcG9DTHhnMjN3MXJOOFRkeGFBalRBSnRVSFlF?=
 =?utf-8?B?dkV2S284WUIvT28yNGh6OEFWaVNSYjdOZi9lRy9wMWVkOFo5OHpxS1cxK29J?=
 =?utf-8?B?T0ZseXVvcG5aNWJQNE81aXpEaDdVbklUZlZpa3E4UjRGWWxOQkRsYks5WDRG?=
 =?utf-8?B?azdPZ2RIZDVqMDRwNEFQMElURE5LZWN3aUFNeTgxOHpMYXIrR205UTFZZThB?=
 =?utf-8?B?Mm9TamRtaXltRUZrVW5Sbng4ZWNLVVlJUkdVRnNoYTM2Q1VucmUxSEF0QTBO?=
 =?utf-8?B?Tnh2ZnBMWTk1azM3RVRLcCt4WU51MnphbHNrUXYwS0xNRlN6dGptTTZqWVNT?=
 =?utf-8?B?ZGZOeGhUcWkyRU5USTZmSmRwcThGSEFSTCtXQUoybE9wUEJzQjNSVUZWMXR5?=
 =?utf-8?B?U213bEZJNitrWGM4ZGpiT3BFLzEyY0NKalNVN1ByZHg3TXVhWmJvZVpZMVpF?=
 =?utf-8?B?VGRTM0JOak1xb0s5NzRlS0FDakVNR1NHd0lWTi90QnJWTWpsM2tmc1QwMkEw?=
 =?utf-8?B?dWhnY0ZudUI2R0oyb2E5WGhZNmh5OFEyTnFnaHlxT0owVFp2amZ1bzcwSllX?=
 =?utf-8?B?ckNtVFdYVjFUSmVPK1JUS1ArMDNLeUNmU3RlWUREdWJ4WWFXZllWWGczbmJU?=
 =?utf-8?B?K2RHZ043UkRMeWR6VlFhaS9jamUzYUpNQ1RPcklYSVNiRVRxT1ByYzY2cVFn?=
 =?utf-8?B?UmxkWmpLM1k2VHVzQzlJdzdLd25BL0tPSVJ1NWdyZ1VTY201RGNHYkxiY2NG?=
 =?utf-8?B?NXVwdUEveTZmeFl5ZHcxaWhibERVWmdUTy9IaE52SDNZalIzdTY4NFZIUk1N?=
 =?utf-8?B?TUVSRklCT2ZnSCtwWmxjbVAxRVRvcDExQW81Y05QMEFZdW14R2sxdFBnSDNX?=
 =?utf-8?B?aVlTOHk4UzBTSDB2MkNPVUkvSGMrV1lHZW1qZ0QyNG9HZTJtU084aGZvd1pS?=
 =?utf-8?B?d25KYVZESUlTT242L1ZDTXo1YVVWdmx2TEkxYm1VMks1V2VXTGRFNzZIN2h0?=
 =?utf-8?B?TVhGeTBVRW5jWGJaWmxLaDJmLzg3d1dsblMxRVJ3ek9GMUFRYTBrdTlObWxX?=
 =?utf-8?B?b2cvQVFmWE12MTB4blBZeU5CWUNHblpXa05VTERpWEJLTnJ1cmtraXZPZElC?=
 =?utf-8?B?UloyVkJHdzhHbEppRDRtNnl6TW5KVExkeXVyeFJ3NExaWHFkNmtUaVYrMHdB?=
 =?utf-8?B?bzNpc0I1K3dsUzlua1FvWXFMNXpBVlZGTm01Nmd6MDR5dkt5NkVTcWd0WkhW?=
 =?utf-8?B?WXB0bWI0VXBPTjZ1TklZdXVxdVEzcVB0MXFQQ0RISTQ5N0g4QkNwM1FnMFBw?=
 =?utf-8?B?TWcrU1l2TzljNnR2QVpEcm9sMlhTT0hmNHU4Tm1NUm1sVk9LQlpaS0tWTkxa?=
 =?utf-8?B?RFFzMlY4aVB4TnZQVWpqbkZHcUx2OXhQVnF3ejBTMnZLaGVXcFNFTWJrTHdm?=
 =?utf-8?B?NlNkYjNySXU0ZWRXQlZWcno3b2ViUVoxT3dvVVNaQ0UxNWRwUlVkK3hSZ1Zo?=
 =?utf-8?B?Y2M5eHBZUDFLOUg5QzMvQVJ6MG9UQldQVVRZMy9sRjZobUtvcUJiR21maDB4?=
 =?utf-8?B?VW9ieEtlRFlaUllENDBXdmo2QzZpTlJlNHlYM1VGWnM0Z0FRbVJQdHVOVXJV?=
 =?utf-8?B?azhaYWF5aXNFWStzeUpUSkJWWFZKY1hiaTVqRkxWc1ppMCs5WTh2ZlZBMnBp?=
 =?utf-8?B?bzUrNEJ0Y282d29Bd3NYa0VaSUVnUDNLNVJhd3IwMFhtZFRJYkk2U29qazJ3?=
 =?utf-8?B?ZW15T1puK2NydllVUGxtcnhTZVBHam9uR3NIaUFqZVhkNTlUN2pBQkRxZDJz?=
 =?utf-8?B?TlBTM0N0OTc5bmNjWnkxbXMrZ3RtZ1kvVzJOMEl5NTZEZzlSc2ZrL3J1YW5k?=
 =?utf-8?B?dFhmYnF4b1hDVlhwMmVHbmJSY0l6Ti9vOWRtVUhENGJTc1BrVHM2blY1T2N3?=
 =?utf-8?B?WnN1TVRqZTZ2UFI1K09OUzE4Z2s2S1NsT1lMTmNLdUNpOWJFL1Q5ZXFVdnp5?=
 =?utf-8?B?b2JJcUZaOXRhNTZwNzR5ZVYwM3VUZW50aldpU0JkNkdnaUtHNU9IRXBzSzVW?=
 =?utf-8?B?VkJhT1N6NkUwcjVncXBzMjkwNEdTY1hkbHZQTmU1dUNXcS9NT1IwU1czbHpD?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8e9f5d-a49d-439a-57e9-08db9a0729a4
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 01:06:16.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGeJZhKeLsm+9pgvRM58904v6nnhAgEWbJwC2bIiiCnUfyX1DrSO9FbGGy/nodXkgT0Cb0n3lkMFoJE+JLM9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/23 18:51, Baolu Lu wrote:
> On 2023/8/9 17:44, Tian, Kevin wrote:
>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>> Sent: Wednesday, August 9, 2023 8:18 AM
>>>
>>> On 2023/8/8 15:49, Tina Zhang wrote:
>>>> A sva domain's lifetime begins with binding a device to a mm and ends
>>>> by releasing all the bound devices from that sva domain. Technically,
>>>> there could be more than one sva domain identified by the mm PASID for
>>>> the use of bound devices issuing DMA transactions.
>>>>
>>>> To support mm PASID 1:n with sva domains, each mm needs to keep both
>>> a
>>>> reference list of allocated sva domains and the corresponding PASID.
>>>> However, currently, mm struct only has one pasid field for sva usage,
>>>> which is used to keep the info of an assigned PASID. That pasid field
>>>> cannot provide sufficient info to build up the 1:n mapping between 
>>>> PASID
>>>> and sva domains.
>>> Is it more appropriate to have the same life cycle for sva domain and mm
>>> pasid? I feel that they represent the same thing, that is, the address
>>> space shared by mm to a device.
>>>
>> iirc it's a simplification to free mm pasid at __mmdrop() otherwise the
>> implementation is tricky, but I don't remember all the detail...
> 
> Yeah, probably we could also free the sva domains in __mmdrop()? Remove
> the refcount for sva domain just like what we did for pasid (at the
> beginning we had refcount for each pasid...).

For sva usage, mm->mm_count is increased in iommu_sva_domain_alloc(), 
and gets decreased when the domain has no users (which is checked in 
iommu_sva_unbind_device()).

So, in a mm's life time, there could be multiple sva domains, though 
they are using the same PASID. I think it makes sense to mm. Because it 
makes no sense to keep a sva domain alive when no users are using it, 
even though the mm is alive.

Regards,
-Tina

> 
> Best regards,
> baolu
