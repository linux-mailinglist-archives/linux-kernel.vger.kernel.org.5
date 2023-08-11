Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720587784C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjHKBM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHKBMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:12:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8412D41
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691716373; x=1723252373;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9x2aL+xU/Asb6ozGth3/kglLs/wxrUmaxD2EhwF2Phg=;
  b=QKNoZ2FEw0kR2B0rX1LWwmhuDNnNKNpTI8/eIOE7HmUBQ45qkundBfip
   DYIivBtfDheihh2nR83w4vhCfUU2OzwrjBq1HxyKtgymbnt/qBNu9Igz5
   8ZPr+LYx6LEkTdVGupIsV7NpJivwRFpocaz5tF5fRH2kFotkRvzSiVrtb
   CmC78vKdVAisDrgzSbGeLmLY1Z++d4VeGjVnEd5ducl8tDAMaNlNISWfg
   T73+22FzyC8sE7NSMogjhHfcAiAcVYwMXOlbR09Cx9ARoku4zo0YKEaqw
   Sx1oI5bMCrrNLtAt9Rw4Ja+S494JbjAwRisC49qBOAfGBZsLEBUhol0Ux
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356529809"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="356529809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846605434"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="846605434"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 18:12:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 18:12:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 18:12:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 18:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KilOxYPyQ/3TnaS8whpEtR6vyPge8VLR+XTXvYSGCzTnCtjxJTkaVmobjqTQmp7MDTTm5A/vo5bSOrGAXXDJ79CbA9gcVwOXmer0COjW1BZi1xGjvdRk/eMLVdUfV3GfYncteJUe49t+ff3vFBXOsn2Ta9R//hF35sUu5VrlQA2w7NfANS0Rf19takL1yGxpkdWVqQFmwF1W1goe8x9nl7z2VjayYP00QKeoVnWhAJkCghVOQRBLGSuhh6PVQIkcLke+EDGKz8OWww6FK7e4RwCmWVF3rwJhjxMsNoPQ1t+XsBZgCZQxh3yJxCcda/FopDKFK+7ueQOMBOHjA24TuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fndY7UKaG4bSrkjH/mEYbzjpOO9rlxAX/llNKGV4Bzg=;
 b=lqt9aLzqoaLphe1zPgHbr9opSA/dMC1ltFnEpi+Jvjb7d2UuJVHcFRuL1MqJV66tPRA7nWmPj/VJ1kJB63/WtYi9gWJ1wUrXQF+WahtF/toFIoxrmL9OORgSt6eIdX8mKnpEzFNlwxWmhofRsh9oUw7iuRv1K5An+1jBTaC+m22Hh4BfXxmaqvrQRgb8OlxopiPi8Rf9LQUFD58i+VyEcdfVTTB7AfkvvgHNiipqdJ5A2dJ8D8JUyPxDyCzg9yaWIZZVmUMXcrRxv1KyXWFHs2u444tUNhNrABlE5vgv45mXyO9WVAT8f/UbkR2gMbr5bfiRM+FOS+hzG3xm8/c16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 01:12:35 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:12:35 +0000
Message-ID: <67ca2485-8a87-f3e6-8eb9-6dfd6ebc0017@intel.com>
Date:   Fri, 11 Aug 2023 09:12:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <BN9PR11MB527638E7361714F8AA5FD4448C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bfc2eb22-54af-dab8-72e3-a142470590c3@intel.com>
 <BN9PR11MB52760CE856F69A3FFD7EE2C88C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUQA01c8zIvHBQn@ziepe.ca>
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <ZNUQA01c8zIvHBQn@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|PH7PR11MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 011109b6-89c5-4a0d-1798-08db9a080b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUpdTb/KecfVsHqGCLulsAsAUXG3NpVuw3BdrgPRlC6Dx7Q1o3ACC9wMMUVunLj6ltyNTVdK0smMFAr/FxzBX+pJrCN6WA0IkqEIO18R9pymkOOn01VEUkjwFrJGH6GxH4Mm+0lhtYnzhs12uwuGYeZpXURg2QnEUNzZh4X+RTv2IVoyapLH++jzqC6Lu6BjKyPdkXDBs4PnFx2DCLqkuiUhKOTtO+daYGPBYNn2g4fazLr0mAjcFtsoL4nNoMbMCJBNrhXYAa7ggjsUx64tYs7uk7o3ux/nwHZXzv3oKAOfna/lFc9wqt2fQh97sVPeeSBbC2P1MyVnIkto1s/wrNgdVOOKs944k7SUpJCLkVx9R3UBksujVNk5FX8d6W52ujrH8uyggFhzqKBT6MAOi/I9yo3s2Bw42Tz077ynCwCF8g8pyWElVehTa/z8TtxiWZgfyjrVhuwHxiigafDwxZ6oMQqZkbnjrm2kg6yOzgVpzhNYnFf5XjlVWAaEuNQ4bh848r48hwIWBBEV5G+CdzWRJkFgmbotOCELU5ylyKVldrtrlyAjW99Jnsu3Qww3QqHUzimIXpoEcX1A+q7xAIScEjhMgq1Rml/lMlukx0BSTWC8wo08H3ebYb4mtD6eWUIystjaPSpPUZBav2ACcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(186006)(1800799006)(451199021)(31686004)(66946007)(6506007)(26005)(66476007)(6636002)(478600001)(6666004)(110136005)(54906003)(53546011)(36756003)(66556008)(83380400001)(2616005)(41300700001)(44832011)(82960400001)(316002)(4326008)(6512007)(6486002)(2906002)(86362001)(31696002)(8936002)(8676002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlYvdHl0UFNQaG5hK2dqcFlkejJubGZiTUJ4cmxiSHp3VXJvMDNYRFFRUG1Y?=
 =?utf-8?B?WllYR2ZsYXVzTzkzeXlLeWZkd0lkdlM4Z0dlTEx0SmhTbHpDVndmQmxkenlD?=
 =?utf-8?B?S2NNVEtTZ2tiTlltMjgraTVZK3BhaWtyTGpLdEZ0cGNaS0x1VXBIQW9pdllu?=
 =?utf-8?B?Zk5NM3AzTkgvSE9RU3J1dHFxWW1MYWFOQVRrOEZhMlhUZEgxRjU5N3pqa1kw?=
 =?utf-8?B?dE5hdEFPRWhtSkZudElpZ1V5cFRxSVh6YVpQSmw0R1orRjN0NlFFZzBBS1da?=
 =?utf-8?B?ZytuSzhxZG1NNnVtcjd3SVNrYyttNE9QTGlGZUJOSi9HSVQ4bkhKZEdRcEVK?=
 =?utf-8?B?ekMxbFpFTS8vZmVpVzV5RzRPVnhjMDJxcVlIUUNBK0NaN3pCWC9UK0sxQkpv?=
 =?utf-8?B?bVpDRy9kMm9TQXlkc3NIVW0wWk9ycHhTV2tIdEVydWxLSFdFeDg4Y1MrSDVI?=
 =?utf-8?B?U0NlZ0ZFSTc0bml5UFFWaXBTdVd3VU9JcU5ZakNZTzgzeFRlcWpFeWpxVnV5?=
 =?utf-8?B?ZldWWkhBZWtvV2RvdEJkWGVwZUJMSDE5R2U5NVk2Vzc1TURSZEJwSmxyT1d3?=
 =?utf-8?B?TEZlZEtjOTFJcE5mdnZGd20vaFFNcnVjcXFka3BUUEVrRXFLcm9lb1BKRFY0?=
 =?utf-8?B?bHB5WVg3YU92TDF2bzR5UkZyMjdJdnFKbVZKN1lRWlgvN1lCSk9DVlhlOUZy?=
 =?utf-8?B?a1pGN3JPM2hnNlYyR25DL3EvZ21UK3BRVTRMZVFpMXBsNnNwU0F4M0M4MXlV?=
 =?utf-8?B?UDNTa29naFFLcUtyREw2T2NpVEgxYmlzKzBBNzh1cThweUk5eGpkK3FMZ29H?=
 =?utf-8?B?c2d2SC9hN2tqZUZmRHlYQ0lCU21tMG5TMlRmMzRnSGc5NXM2bHBvaU1Zcitw?=
 =?utf-8?B?cFl3aWxobW40M3g2S3NINWkzaklnalp4TGVUZTdhV01yK2J4b3B2cFp0Z3A3?=
 =?utf-8?B?SnN6Sm5LT0d6eURGaitHUnNkL2xybUNVK2g1c1dxMW9nNDZBdWhJcTdrekhu?=
 =?utf-8?B?T3Nkb28xcVA1eUVxYjNXZFBHODFxTHpmamJHUXprOGF3bEFKb3lWOHYxb1FT?=
 =?utf-8?B?WHAzVEVCMXZrTWtNcjZSTzl6UkVxbGhDbW1HQXpIU1NCY1JSM1ZydlVmYVVr?=
 =?utf-8?B?SDFtNzZmOCszZC8yT29nM3QyU08yKy9hTCs4YXBwb0FuNno1RHJubXVBNmxL?=
 =?utf-8?B?amd0b0JZb1RsMzFVdVlKQy94ak9tYzVKbGlPT1J1T0ZqbHV2aW5ZUGZCSmlu?=
 =?utf-8?B?NHNuakRyZkZsa1hQQVNEKy9tRnBjdS93ajJoK2ZuOThzMDliMmg3MkhFakE4?=
 =?utf-8?B?bkZzSlVTa0ExUllVVm5aMlpzVDJnaWUvcVdrdkhRVERqRmpKVDhGUlZmTnNy?=
 =?utf-8?B?Zi9ycnYxOVNoSGdiQW5SUXZmTmtaTHhNQ1gyY0tIdFIza1FuaVRBbHNnVzhm?=
 =?utf-8?B?My9YOHB5UHRMckpWcm1xRjEwaUV1NXU2bG5LWnFJL2gxQVJmRDRHZFdURlE3?=
 =?utf-8?B?YnpZd3lwNGVnUmVsRmhocnE5SGVsNkNna2p2Smo4a3IvaWVyRm1kcmt6T0dF?=
 =?utf-8?B?YzVmQzFUSkhuZHgra2NDTkxIT3ZCVElxRDhUekw0OW9hQm5kREl3VGJEcHln?=
 =?utf-8?B?VHhtTnNFeW8zWmJPZkZyNldBYzJJOHBibGlTcmdIazY0YlRzbkZZeDNDRjRR?=
 =?utf-8?B?ejZHaUN3VUsyZUF1Wnk3Y3A3M3M1dHcxM1BLNFpYaW43QWNYT0Vnd2NITGJh?=
 =?utf-8?B?TktodHEvWHZWU3VScitzUjg0c0w4MG9NQVFnT1VhWG9OWGFEK1JjOE1SZldm?=
 =?utf-8?B?SXJxeWp1WXZ0eEhsbEozc2UwbDdtQTdZSWJHY1NPWmFPOVVDbmlyN25hdUN5?=
 =?utf-8?B?bEI3aDdVZEhuUWw4UFVIaUpGWVhpUXNNSWhZbTM4SzdHNDRaMTdabUplR21J?=
 =?utf-8?B?amEzVGpBREV3NCtoa2NPTlV0bEZjdHE1OGRMT1NlWENzWmtraGJNMGIxa0dn?=
 =?utf-8?B?Q1RHdFRtVldTaitmTURYRWg3TGJjYTNldlNNeFNJQ3J1a09CUUY4c041R2sw?=
 =?utf-8?B?cFNnOTFacWdHcGFrNkJlMzdnOTBoK0lUY0lBQ09WcGJaWE8rNGVmc2ZlS3Jx?=
 =?utf-8?B?SStad1o5MldHaE5xUURMeDJyOEg5dzNmWEl1ZU5iRTNDcVpZVFRiZHhBbk0y?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 011109b6-89c5-4a0d-1798-08db9a080b88
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 01:12:35.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f3A3jjWGeyezaT04zjccPm/Kf1G2h4LZGIVocbmc6Bi06oY0yEDOd4B7yQDRcfr+JpERqZY3iUKAiBGl8ZWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/23 00:27, Jason Gunthorpe wrote:
> On Thu, Aug 10, 2023 at 07:49:11AM +0000, Tian, Kevin wrote:
>>> From: Zhang, Tina <tina.zhang@intel.com>
>>> Sent: Thursday, August 10, 2023 9:32 AM
>>>
>>> Hi,
>>>
>>> On 8/9/23 17:41, Tian, Kevin wrote:
>>>>> From: Zhang, Tina <tina.zhang@intel.com>
>>>>> Sent: Tuesday, August 8, 2023 3:50 PM
>>>>>
>>>>> A sva domain's lifetime begins with binding a device to a mm and ends
>>>>> by releasing all the bound devices from that sva domain. Technically,
>>>>> there could be more than one sva domain identified by the mm PASID for
>>>>> the use of bound devices issuing DMA transactions.
>>>>
>>>> Could you elaborate it with some concrete examples which motivate
>>>> this change?
>>> The motivation is to remove the superfluous IOTLB invalidation in
>>> current VT-d driver.
>>>
>>> Currently, in VT-d driver, due to lacking shared sva domain info, in
>>> intel_flush_svm_range(), both iotlb and dev-tlb invalidation operations
>>> are performed per-device. However, difference devices could be behind
>>> one IOMMU (e.g., four devices are behind one IOMMU) and invoking iotlb
>>> per-device gives us more iotlb invalidation than necessary (4 iotlb
>>> invalidation instead of 1). This issue may give more performance impact
>>> when in a virtual machine guest, as currently we have one virtual VT-d
>>> for in front of those virtual devices.
>>>
>>>
>>> This patch fixes this issue by attaching shared sva domain information
>>> to mm, so that it can be utilized in the mm_notifier_ops callbacks.
>>>
>>
>> that is one of the motivations. e.g. another one as Jason suggested
>> is to cleanup to decouple the common sva logic from enqcmd. Both
>> should be mentioned in next version cover letter.
> 
> I also want to purge all the de-duplication and refcounting code
> around mm's and sva_binds from the drivers. Eg see the mess this makes
> of SMMUv3.
> 
> Core code provides a single iommu_domain per-mm for SVA. Driver can
> rely on this optimization and does not need to de-duplicate.
> 
> Single domain tracks all attachments. Driver can optimize using that
> information by de-duplicating (eg ASID invalidation vs ATC
> invalidation)
> 
> After this we need to fix the domain allocation op to add a
> 'alloc_domain_sva(dev, mm_struct)' op so that the drivers can setup
> their SVA domains fully in a nice lock-safe environment.
Agree. These can be added to the to-do list.

Regards,
-Tina
> 
> Jason
