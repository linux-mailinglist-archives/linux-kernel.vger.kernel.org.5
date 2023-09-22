Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE127AA65E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjIVBHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjIVBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE39102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695344858; x=1726880858;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KYRxsPZkdPGN4MD0B75y6lI6c7LYLscZmHIZ6RWU3l0=;
  b=YpcQNydST/Zf1qh49UB6RCoGvVtTqE04iMmsXr0XyHf3fEmk1A2xeaXt
   0EDjid7J3oSfKw+oC9oE4t+WmTlSVATgfw9cYJywW2mji+DlmsQ+vyAcu
   qTpt6AqLgEviE4gfg38rQRzNpE8UJQr33KR5NZbPzDxnIfQ75drwCNeC3
   go+2vRyWuPS2LqCjAKJVMlHtkvx09ZnzSgukV3rtTR9+bUelFCkD/ezGq
   DRMG5uYEheNze3kRpc1GLW7Ks57xZ5kwBxqAsEtEPbd3/qqaineu4L1DB
   aUHP5LzSy09ebjZclek4V7gc48tuHUXEQCTN9bM8/hrZd403gF+g3uERJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360095489"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360095489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 18:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="776652715"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="776652715"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 18:07:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 18:07:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 18:07:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 18:07:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQWAivzMDa//dgsdst0sSiRe1Uzzyk5/nCJIcWbdHLq5+OQ3Dgg/tNkRL3vU1G9XZmBFpobyd16vBNCvBeKLV0mzuLRm9cmh1h+H9HjgKeP03OHIVuuOTNkjeqTO7jR0il3+hIVjerH0RMu0YkMz6UvbjaLZ3rc50vRDALBxjiugdpJIeLi8NKmV8Z4WxpLWwxuzq1ADFQh6J6y4RgQCCBUOUedEwOvPqNL2uPfEhs3/TX1A8D8YQjf44ec9Uebj67GLgyTvuYClkA4+BNpUG/9W8me87LJPhLrwBN0fJJPEYjJEXBmwdqPqFOfV5MqNh5aCCjT5U06ou3+kuSo4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/Gy4h9lCi7km9TBWac0uofHc6Xwa14hyLZ1pZiNE5E=;
 b=F+WfQI0ciPkmJzgGNfbGWk0rw0mYcAnLPTOP8XaJUkYAekJ/nFAFtcDiXnUJtaM6yxlyPirTDXGD6nhbpyZh9XT7QRTb8XTNug3BJpk7iN7Eg1hH//i+eeIsP2N5G9wCwiBTjECv0Bg/PVWJYO4PcvQZDWAO7A0ccW8z11Qp/EsvzY61l3QlhrN84AQuCREQX6m+cMA9izmA+uNiieo7GGiBsFKyafSsZ6QfyYLxrAATKsI84kBcCcqxJW9Fn5lBayWIB5o5DX4byaSIlNQlZB6BadMO2AgF7F8xRrdNkQCrzFWfgZ6KDkDFq1O5Y7yCHzd8RAr+xW31vM3NrV04/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 01:07:35 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 01:07:35 +0000
Message-ID: <40c82e24-cff3-1f96-b469-fbfd18238d5d@intel.com>
Date:   Fri, 22 Sep 2023 09:07:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 5/6] iommu: Support mm PASID 1:n with sva domains
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-6-tina.zhang@intel.com>
 <20230921233133.GB13795@ziepe.ca>
Content-Language: en-US
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <20230921233133.GB13795@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: e54caf9c-23c1-4751-1052-08dbbb084e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lU8pZO2jQ4zRb5ir9HMGLeoff5N3noCQ1dWlba2ACyUQqMtx158bH+H2MaosrB9ycZq4OPeV4FbPMlLsqCy9Kwj+sP2eM7lU89RkDurZ+NCg11eFiMZtK3NrvPH+8Z2F2TcO37AO918ZzNIQ6ob3TP7IDSz0smhFsQliF0o6MFH5pME3rGfcnlpZjEaY1lG1dV9zvqtPhwHlnuIXJh7eqSwQinYJ/cE0Tcrfp4UDz+Y9y8MpPIMklmJcR4tiIFKS53RSsuH4HcED74KYzOj9GHBndFeNz8utEXRw+KrrVFpClANuCQrb4uXOBwoynoym0ZCWoQOOLT4+nN3w4vRrTAULd0vIpqVj01uNZcRhU6t2JktvZ0xqkYTI51XpWTiuPfklZEDaKIEKrlcoSJ4mlX3PJn0uQA7ur8PRY5NEQybFUrKfVt39s3fI6ZNNU7L7D9mGMq/Q7eXCj4+xKG+FFogdHnpP10NGLPDrm9OExQGNtiS0ddap479Jpf9GOayd1zb0Ku+xXML2iQ9sWpZ3rbyshNaR+2SImrzEOxD1jred+8RDECjT99HeJ+QlAG+PbJfkwxyaZLL80sabJpXb+8slhVVUNVa/r6FpFjoC3h7kFnrh3LgCBOHUyWlmgIE7vYMuAk0qu6B0vUnBdRnPFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(6666004)(6512007)(53546011)(6486002)(36756003)(6506007)(82960400001)(31696002)(83380400001)(86362001)(38100700002)(2616005)(66946007)(54906003)(66476007)(6916009)(66556008)(41300700001)(26005)(316002)(8676002)(4326008)(2906002)(5660300002)(44832011)(8936002)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5mMzREZncxVVgxdHFzVk5pb1A1L0hLRGxDaWZlNkpnbjQyc0ZrQmphSGZv?=
 =?utf-8?B?UHp4OC9jMXZHaXFEdmlOU3o1dWt6QnEvWnZuU3o1V3FyMTNab1ZNUHIxUGk2?=
 =?utf-8?B?TW05aElENWRFaGpRQ0VIVGFMWitLQ0hHZDg3Mm9jQjRtK2pOcmdVbmw2Z0dK?=
 =?utf-8?B?YWpMbzB4TEdpQWhnLzBxM0wyamRmMytwTDFFTFBmVDdYbnNQM2JWbDBvUHJE?=
 =?utf-8?B?YXI2TTFZamZFSys3ZEVNSS9KRmlQaVlpa1FVQW5YR0JHTko0d3V2M28wOFlL?=
 =?utf-8?B?d3AvZm1BVWhrdWlmeHdMOFFoeURvMEpocXA0UTNvVXNuZWlVYlI2QXVJSkRa?=
 =?utf-8?B?VWNldWtON2xSUk5lWGRXeDYrMEpzV3B6U3Bob1JFbzgvRm5jSXBBTUhYMjZC?=
 =?utf-8?B?aGRrRVRqZ2doY29WREQ3RVZQa2Jmai9xSStjNFJIRVV6dHF6YWJuTEY0TExJ?=
 =?utf-8?B?WGQrTjk3Y24rMVduTUM4UllPaUJlamJHaG95bmxIUjdhcWVyZzhNTitiYVRp?=
 =?utf-8?B?VHkzT0NYWDBUOERzMkgramN0eEd6c3R3bUhhL3NmUHVrTE9tZHV1b2w3dWRF?=
 =?utf-8?B?djNNWFFzSUJiRUk3YmZhK3lqYVBoQWVZTVd4UUQ5K1g1YWxJN3hSS3ZzNFVQ?=
 =?utf-8?B?Z2s2cVkrNFNNRW9ZblZUV3RLZkhLdGtrSUlDSE1kRzJlaXdvS21hR1A5dE1v?=
 =?utf-8?B?SVZxQS9XZmV3Szc3RmlGbXN2bjdaVVhEbUhwQ1hXTGN3R1l1YXRzSDF6OXly?=
 =?utf-8?B?My9EaVNVU2tSeXFZUXdRSUNlcWpiYVBCTjBYM0l5c2ZLc2hYV1UwOVRQK3Ra?=
 =?utf-8?B?UWVLS0hKWWJJeHNlUGZscTdwQ09mMS9HNCsreTFIcFQ3Ym5pd3ZEaXZKUTh5?=
 =?utf-8?B?QnlrTi91bWxER0JpYllObkFvQ3pRdlBBbHBHYWtHL0JCKyswWVZzVFAzcjJt?=
 =?utf-8?B?RHp6bmxsU2VXQ0U2eStzcjdabjQ5eEpTZFIzODBtSW9HWFJ0YmhyQzhpMHhH?=
 =?utf-8?B?UnRSa0ppTlpRTmtKK2hUQ2RsS3g0TWNzT1htaVovT2g0RHowa0xIRlhOdmF3?=
 =?utf-8?B?dDRzTVovQ3J0R1NPVlUvRHRvcWQzQkxQQ2E2NkpzOG9OcnVkWFk4OXd3WGVP?=
 =?utf-8?B?TGxVL3pLZGlhSm1sZzB0eXgwckJ2VWdueVppeG1Randpc09kb2xxbE11RDFs?=
 =?utf-8?B?QjdpQXJydWliL0d2aG1NR1FOM3gxL2VLdkl6OExmMmRlejZGZXFHbUovMTVO?=
 =?utf-8?B?YUlpYWJKdWc3WnpRYWRSaSszTndsQmJ4eHJiaVlaL0NiS1NMa0h4eHcram51?=
 =?utf-8?B?NGZnQ281WnpsM3EzTXdOdEI3RmFjNjBpNnVMcnY2YTRHUWJrRVlob2VlZmhk?=
 =?utf-8?B?NU5QM0N4UDdSWDNzRXhjek5VbDAyMXk4NjVKaXJmMW9vbmJCS3lWMTRyVnYv?=
 =?utf-8?B?bzNvNXUxdEVSZFlUdUZxS0liLzN4NXV5d2RsZTBkOGswM1JYN3l0WTZScXUx?=
 =?utf-8?B?Nk45MDRadS84R3lWRXJRNms1djNVK3ZSa2RybkNBQUp2My9abjRDVm8zeVB0?=
 =?utf-8?B?V3VWcVJrWUJkN3duVjJ1OW1IVGp0VHptRG5SZEZlOUJzT1dubTNCZW56MkN4?=
 =?utf-8?B?QmFOS2lFczVLSW1oUUwzYjdNbWp0RlB2N0ZEellpZ3lITFpuL1lsOXhvT1hD?=
 =?utf-8?B?RGo5b21tN1FFNnBNQlV6ZFV4SXowWk42a1Y0akp5VlJPa1lzUThiaUZvcFBv?=
 =?utf-8?B?dkp1M2Z4N2ZKZlNxODJkdXZtRE5ZZ2wrNWJieEx2dUx5c3h4Tjh2d2NaZmt2?=
 =?utf-8?B?TlFzSFZkZEpKb2RXNGJ1V1RNcERHaW5SUVNPWkdXdXg4dVZTZjNmeFVaaDVI?=
 =?utf-8?B?Q0cvS2hSbEFTNmNkQWJoWVVVZk00L0cvRzFyeEp4L2FPSEc1NDFacXFaUjBn?=
 =?utf-8?B?ZDdwVDV1bExuQXNtbS9SVFlDRW1GaVNWa0h0S0pBWi9sSkxTY3l3Q1ZnTEdw?=
 =?utf-8?B?RWZ2a0xoaGdpQWhYeE9sUmhZS2tYRWQrT0FqQTdyTnV2TGtId0tOdEJkQjVs?=
 =?utf-8?B?dEUrd3N3Z0ZvVTkwZTMrekNHS3NzQlVCZHhvTHRRM2FxSlAvMHQrUS84Q3li?=
 =?utf-8?Q?8+bJjSPgsPxe/+TUeuwbaMNX9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e54caf9c-23c1-4751-1052-08dbbb084e3e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 01:07:35.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QljY4W6NJMiy3p8L4HzyV2Touha8vGWE93NxlwuQfr/Ahbd++hX4sAHnfzLsWFGAOsOQmcVH1E8Y+0rtqrL3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 9/22/23 07:31, Jason Gunthorpe wrote:
> On Tue, Sep 12, 2023 at 08:59:35PM +0800, Tina Zhang wrote:
>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>> index 0f956ecd0c9b..79779bbef653 100644
>> --- a/drivers/iommu/iommu-sva.c
>> +++ b/drivers/iommu/iommu-sva.c
>> @@ -15,6 +15,7 @@ static DEFINE_MUTEX(iommu_sva_lock);
>>   static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>>   {
>>   	ioasid_t pasid;
>> +	struct iommu_mm_data *iommu_mm;
>>   	int ret = 0;
>>   
>>   	if (!arch_pgtable_dma_compat(mm))
>> @@ -28,12 +29,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>>   		goto out;
>>   	}
>>   
>> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
>> +	if (!iommu_mm) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>>   	pasid = iommu_alloc_global_pasid(dev);
>>   	if (pasid == IOMMU_PASID_INVALID) {
>> +		kfree(iommu_mm);
>>   		ret = -ENOSPC;
>>   		goto out;
>>   	}
>> -	mm->pasid = pasid;
>> +	iommu_mm->pasid = pasid;
>> +	INIT_LIST_HEAD(&iommu_mm->sva_domains);
>> +	mm->iommu_mm = iommu_mm;
>> +
>>   	ret = 0;
>>   out:
>>   	mutex_unlock(&iommu_sva_lock);
>> @@ -73,16 +84,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   
>>   	mutex_lock(&iommu_sva_lock);
>>   	/* Search for an existing domain. */
>> -	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
>> -						IOMMU_DOMAIN_SVA);
>> -	if (IS_ERR(domain)) {
>> -		ret = PTR_ERR(domain);
>> -		goto out_unlock;
>> -	}
>> -
>> -	if (domain) {
>> -		domain->users++;
>> -		goto out;
>> +	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
>> +		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
>> +		if (!ret) {
>> +			domain->users++;
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	/* Allocate a new domain and set it on device pasid. */
>> @@ -96,6 +103,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   	if (ret)
>>   		goto out_free_domain;
>>   	domain->users = 1;
>> +	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>> +
>>   out:
>>   	mutex_unlock(&iommu_sva_lock);
>>   	handle->dev = dev;
>> @@ -128,8 +137,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>>   	struct device *dev = handle->dev;
>>   
>>   	mutex_lock(&iommu_sva_lock);
>> +	iommu_detach_device_pasid(domain, dev, pasid);
>>   	if (--domain->users == 0) {
>> -		iommu_detach_device_pasid(domain, dev, pasid);
>> +		list_del(&domain->next);
>>   		iommu_domain_free(domain);
>>   	}
>>   	mutex_unlock(&iommu_sva_lock);
>> @@ -209,4 +219,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>>   		return;
>>   
>>   	iommu_free_global_pasid(mm_get_pasid(mm));
>> +	kfree(mm->iommu_mm);
>>   }
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index b9c9f14a95cc..c61bc45d5a82 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -109,6 +109,11 @@ struct iommu_domain {
>>   		struct {	/* IOMMU_DOMAIN_SVA */
>>   			struct mm_struct *mm;
>>   			int users;
>> +			/*
>> +			 * Next iommu_domain in mm->iommu_mm->sva-domains list
>> +			 * protected by iommu_sva_lock.
>> +			 */
>> +			struct list_head next;
>>   		};
>>   	};
>>   };
>> @@ -1186,17 +1191,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>>   }
>>   
>>   #ifdef CONFIG_IOMMU_SVA
>> -static inline void mm_pasid_init(struct mm_struct *mm)
>> -{
>> -	mm->pasid = IOMMU_PASID_INVALID;
>> -}
>>   static inline bool mm_valid_pasid(struct mm_struct *mm)
>>   {
>> -	return mm->pasid != IOMMU_PASID_INVALID;
>> +	return mm->iommu_mm ? true : false;
>>   }
> 
> HUm this isn't locked very nicely.
> 
> Above do
> 
> smp_store_release(&mm->iommu_mm, iommu_mm);
> 
> And then do
> 
>    return READ_ONCE(mm->iommu_mm)
Good suggestion. Thanks.

> 
> (no need for ternaries with bools, compiler generates it automatically)
> 
> 
>>   static inline u32 mm_get_pasid(struct mm_struct *mm)
>>   {
>> -	return mm->pasid;
>> +	return mm->iommu_mm ? mm->iommu_mm->pasid : IOMMU_PASID_INVALID;
>>   }
> 
> Then this should be
> 
> struct iommu_mm_data *iommu_mm = READ_ONCE(mm->iommu_mm);
> 
> if (!iommu_mm)
>     return IOMMU_PASID_INVALID;
> return iommu_mm->pasid;
> 
> Keeping in mind that the kfree(mm->iommu_mm) being placed in the
> mm_drop is critical to this working safely.
Right. Thanks.


Regards,
-Tina
> 
> Otherwise the logic looks OK.
> 
> Jason
> 
