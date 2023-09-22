Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD97AA6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjIVCHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjIVCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:07:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFB18F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695348452; x=1726884452;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0pgl86tQXonI7X0/KLynlWxqaVh4hTDxUw2UcgOnEUM=;
  b=fXfqVP8N9asQZrB1PWhi3xU9i4Q5y6B17Z+czPZSJ0Ha2ASNOn2eoz2S
   z9qC9CdV5P1UEKyOSGJAYhqJFjHf5oZJ23Wy0vGAMDqn1E4efYa2ni7vP
   jQj1XOnAQtQcF7iHtqsY/zKYYDIHGs/nfOC4BXYNA8dKxIfqivFqO9vZV
   LiLPAboMyQcE4SND3wiQpbbEdDKG0OxKpDDFpFIhAEIgmcOCmz9g4/vyY
   Ni9mQv32Kl32qYYGidW2dxSGTvgsGjdKMx4Pal0MV/nYjeamPm0qAmYXf
   0d3cDHiLGuZFsMHQ6DeTguZp0PGleUbWncgpehfbLNmWBg7oIFxWSWE7A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="371041922"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="371041922"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 19:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="994361740"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="994361740"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 19:07:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 19:07:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 19:07:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 19:07:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 19:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBqG0KIJEuMvtAzE98Q6tu3pocRvMkxIDBadD7K293HHR8m/swFaqVEm7lpFd6a5ZjAvZMgeOOIZAxKgrKWI/EHwav50BvSn7NmwwMI7K9b5GF96DWPjxWofgEDsOM31A4JS2UazOo2iVsPAZvkwr5+j8Nmo+xmzWnvvS8LMAal939GBc3ADu6/UHPkP2hrvlPUlSmNrSk7yElslT+yhHiUTC1uu82BKzR8AXFjTYCHvy1kzK+gaCMhEagM4X3dCkOvCHQlT50maXc1CQDuHDL4pzUyryL+Az15yAP4lcV/t3eleT81lM7iWFc8rMRmxALwK8KD5wFjOgHPNnlL8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PEncrPahRgJZQspiHZJaNLEqwSBMJKVSrsWUloE5KU=;
 b=Agl9Z9bdTQycpBKbB8jpDPvVzbCNAoo2UOk1zG1Nz1FqlO6QsJsGmxm9+TMEOG0Hf+e7VsHjCT5Yhuen/3FFR/TTpRHLfJpmUEsup5ggjDrHXSfibVXxqWRtFbDtEN7jMckhGaqu9hFuDf7yoQb5UAR8/23RBRWEq6WSTjPn28De9nKWdNkpKVhtCJVJ9Ky7c3wDjLN8qPqDPBp+xrNDu8Ff3KZ6wpGrRombHIYYckLHrO2i/mWrI0SPphYk0Al9FCPEDeTG59xzVWZlQfJ2ytE0HPIjL+FFn7EZGC8n4wHgkEqVRkB6mfUPfT44TkUNPjeSAZWL+Y2A1lY2ctCjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DS0PR11MB8084.namprd11.prod.outlook.com (2603:10b6:8:158::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 02:07:29 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 02:07:28 +0000
Message-ID: <a160dab7-52ea-4baa-b668-ff69ab7c8e6b@intel.com>
Date:   Fri, 22 Sep 2023 10:07:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 3/6] iommu: Introduce mm_get_pasid() helper function
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-4-tina.zhang@intel.com>
 <20230921190259.GZ13795@ziepe.ca>
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <20230921190259.GZ13795@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|DS0PR11MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d7abde-6b28-410a-e376-08dbbb10ac1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bO4jgjuWAEJ5nIR+j8eGTTo/iY7kV3ARuYFdfQC6p62I8jGPHDWtAZoAJGVtYMQHdNep3NIliAD+LrGbfVj0vUTUJmeWmiJ+rS0fOwJeDQ9i2WfXMvFEv3Xc5JQZBUOGhBgriRl+TWF79UoFsXMNecmyqSrqfkctRLoS99JKJJuKSq5+iQFkSMZOUDBFo172RtuO+pASoO+gOtEEuhE9Euc0vLjF2iqtlegqZ3jPrSWOcE5Le9waMjHxfLhlnCShkOVRPDc24R9z43M7A1FNMWmKLJfB/nFbi2I9OOnpQbl8ghIKQHifbsrILv0B1J9n2PUdGs3mIM6AzHFNDvjjK6fR9YmCGAFUblIQraAbId6ghc+rCFJGX/DT8MMl5bsj7Y5ljPJnSIc5/6QxeY4MlYNRD5+BtRmGyFynTUSMtS2yGCggcK61PbMOqr7uowTsVEaWeVPfaxuOI39RCQJP/9rfVbb5LmUBCas0ZaLgVu2lWQRpDFcpeulbzX5fFKiP06cAPJ8NrMLyQv2GV+hdao3enmpQh0XC6n/nFVYp/AnCH+itM/SyjNGG0fVZ66peQ9NDbYPeGjJtTlXatIXs1JSrIFwgZ9tUwOIKDZvIpJcSqxQi8HyS1MurHDDHmLKi0Kz3DV07+HbKTiWY6amhLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(31686004)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(83380400001)(26005)(53546011)(6506007)(6512007)(66556008)(66946007)(6916009)(66476007)(54906003)(38100700002)(82960400001)(6666004)(41300700001)(2616005)(86362001)(31696002)(6486002)(2906002)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czdRWUFTNU9ITlZFaWwrQlE1bXE0TUZpOGYxcG1CUmRVQ3VnUm9rbXdwTVFz?=
 =?utf-8?B?ZUFkY2tCUVp1S3V6aGo1NEZ3aFd3L0hXZDZaMUZ3bTMvdmhXNEdOam1NTHZr?=
 =?utf-8?B?T0pyd2d1Y0tpU2hub3hvU3BmdVFxY0UzSVI4a2NFVmJQWHpDZSs4bkVmWndU?=
 =?utf-8?B?eVVnc0JueVNlMWFJaVEva2hDV0ZsblVYQ2dPSm51S1NOQTJjZXNmZDFGd2Mr?=
 =?utf-8?B?NkhONVU5cFY0Y3RPZnc4Zk5TQlhJNDNQYXFkQng1bkNsSHpoZzU0TENiTXB5?=
 =?utf-8?B?OGJsbE9TOGVHYS93b3B3UW1icEMycGl6cncvdzVxdkswVTBPL0htMW5JSGw3?=
 =?utf-8?B?UEJRYjN3ZWk2dDdtRHdYN0J2czVvRFNuaEk2dktRd2puUkxtU21rYlR4bkVh?=
 =?utf-8?B?cGRGajVPb0NSNFR2VThEMmxMaTh0L0VqbHdOU0g2NlhRaGkwbWtEaVRXbFln?=
 =?utf-8?B?QWdwN1l4MHRQc1F2U3ZqQlNRNXJVVmlOT1hJNVNtY21xbUZSczFCTU42b3VH?=
 =?utf-8?B?c1FVQ0grcnlzRmMxM3JQZHVEb0lKMWdKUTVtYnRoNlg1T3NKc3VqQzg1TXJr?=
 =?utf-8?B?WEp5ckUydmp2RDFydEhuZ1JTemhYSUMvb29EOVU0Wi9vU0xFa2JYUnFnS1V1?=
 =?utf-8?B?SmxMQ0NSdzVBanRta0VLek9La3BPaDIyUmRCMGhKYXhDVFVDaldlU3ZodnVH?=
 =?utf-8?B?Yi9UZ0xFd3lUWkNNbHRZTzZhdk1UNW9pQWxmMnpEMFBGbW90OXV5UndFcHRT?=
 =?utf-8?B?R0VvOHg5Uk91MW5NZ05CUVNsbnVhanBObEl0aENBZVBBRnQxdlNqMXRmWWxS?=
 =?utf-8?B?MkF5Sm5ucVdsYTJZREpoZmFST2orQlpOa0EvODBOWGFrc3cvNFVlWlNjblYx?=
 =?utf-8?B?OS9McGpoaHZlZVZwd0JUd0pMV0FETFQyUHI0cmRNemhjaGVNaTRTa2Q3enZC?=
 =?utf-8?B?VWVsdXNmSzFsOElBa3ZROVh5T1hsMnUxQUkyQ1FoODhVV0NSanowVURmQXln?=
 =?utf-8?B?MEp0aXJoelp3U1BGNmlvSXZhWFMrc3pxVnN4RUxwZ0MvRTZTQjZGUXJ1dGdM?=
 =?utf-8?B?a1ZQVHFDTHE5YXQvc3d6eEN0Y0NVTDRibkgyRXFCcS9rVkZUcXlidnlsQ0Rq?=
 =?utf-8?B?RWRHVXpzY3dPYjgzejI0NTMyOHJVYWFRT3BMeGp5MEp1TnVGRDFYZkZWbW9P?=
 =?utf-8?B?SVg2RkY4b29wWnc5Q3BJTzhsWlMvOXVudVBpRjF2VFQrZWhmQUdBT3I3YUNk?=
 =?utf-8?B?LzdaT2d5NlpLSS90cUovL2Q4SmRKRkxOU2JGbnU1M3BEaUFHMit4TmdNR29x?=
 =?utf-8?B?aG9SbTA3MktnTVgzZTJ2ZGdGa1pJSFIvOGgyUitISy9NeDVmOU5FUHdPWmJZ?=
 =?utf-8?B?d1hDS1M4b2wyZkpsdFJVMW5iUHh6Q0tGQi9NYnI3MXFscVBpN0hWZk42alJH?=
 =?utf-8?B?a1E4OHVNdmV2V3VpTVR0ckxVYVA3S2NEZ051TFdrRit5Uk4vd1lsaEpPcUFq?=
 =?utf-8?B?UjllTWJ4bHFXTEpWSGlzejlrQmNEdWdlSkJUODcwTCtnNTkwUitpbzhSYWln?=
 =?utf-8?B?NFNRNm12ckhldjlZRndLTldWNUwzbS9vVlhicm9sdm44OHdBNlBIeUV4RWc4?=
 =?utf-8?B?VFZvcG5Nanh5S2Z2RFU0L0s2bUtYVUE2Nmo3R0ZTOHNYQ0o2Q0xDbGwxWU0w?=
 =?utf-8?B?d01XVHNkQWlPeEtHa01HOFY5aXlYK29UZmo4Nm5lVlNCaUoya1ZtL05UQU5F?=
 =?utf-8?B?eFBVMUlOeS9HU0xycmVvbHIxT2RIdWtNWlVFaWk5c251VjQ4SGM0TTJPK1Qr?=
 =?utf-8?B?M0tGMGkrWWsyai9ubHU2WWtLS3hVU1UvRWRDOHpPTEd4M0NWbHljdGc0YTVD?=
 =?utf-8?B?ckpKR0U2bmxVdEZOeVRkMC9YUjU1YzNETXZvSTBCcVRsM1ZwdlRQZUVEbXpT?=
 =?utf-8?B?U1dMUmdNZmthV3dpNk85Vm4xbkwrSytCNnFoa2NHc3NrUGdldElrMlhKR2Zv?=
 =?utf-8?B?KzM2RmloeWFWeTdJc213V05BenJrMWtFYUEyNGdIb2FxVEtnNHJEMTVvUkQ2?=
 =?utf-8?B?ZjQ0SDk3S3JURVBXb2tEaXJXVDluZXdibnNyMXRFRTRYNFgrQnU1MjNXc2l2?=
 =?utf-8?Q?8REV7Dv/PKFiDVpPd2xAgzwzi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d7abde-6b28-410a-e376-08dbbb10ac1d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 02:07:28.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loKeNqYomXBqDjaGrfyRjqq83o2dOWUST1izDsDeHVuxOzbRdOBD3L20VDicHxihk9q72XtjkqV1Havygsyd/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8084
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 03:02, Jason Gunthorpe wrote:
> On Tue, Sep 12, 2023 at 08:59:33PM +0800, Tina Zhang wrote:
>> Use the helper function mm_get_pasid() to get a mm assigned pasid
>> value. The motivation is to replace mm->pasid with an iommu private
>> data structure that is introduced in a later patch.
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>> ---
>>
>> Changes in v4:
>> - Rebase to v6.6-rc1.
>>
>> Changes in v2:
>> - Update commit message.
>> - Let mm_get_enqcmd_pasid() call mm_get_pasid() to get pasid.
>>
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
>>   drivers/iommu/iommu-sva.c                       | 12 ++++++------
>>   include/linux/iommu.h                           | 10 +++++++++-
>>   3 files changed, 21 insertions(+), 13 deletions(-)
> 
> Michael already has a series to remove this mis-use from the ARM
> driver like you did for the Intel driver.
> 
> I think for the interm it is fine to just use mm_get_enqcmd_pasid()
> and Michael can remove it.
> 
> It helps point out this is just wrong anyhow and better discourages
> anyone else from using it.
Sure, I'll update the commit message.

Thanks,
-Tina
> 
>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>> index b78671a8a914..0f956ecd0c9b 100644
>> --- a/drivers/iommu/iommu-sva.c
>> +++ b/drivers/iommu/iommu-sva.c
>> @@ -23,7 +23,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>>   	mutex_lock(&iommu_sva_lock);
>>   	/* Is a PASID already associated with this mm? */
>>   	if (mm_valid_pasid(mm)) {
>> -		if (mm->pasid >= dev->iommu->max_pasids)
>> +		if (mm_get_pasid(mm) >= dev->iommu->max_pasids)
>>   			ret = -EOVERFLOW;
>>
>>   		goto out;
>>   	}
>>
>> @@ -73,7 +73,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   
>>   	mutex_lock(&iommu_sva_lock);
>>   	/* Search for an existing domain. */
>> -	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
>> +	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
>>   						IOMMU_DOMAIN_SVA);
>>   	if (IS_ERR(domain)) {
>>   		ret = PTR_ERR(domain);
>> @@ -92,7 +92,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   		goto out_unlock;
>>   	}
>>   
>> -	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
>> +	ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
>>   	if (ret)
>>   		goto out_free_domain;
>>   	domain->users = 1;
> 
> These ones are all manipulating the enqcmd_pasid really..  If it
> wasn't for enqcmd then we'd simply make each device have its own PASID
> and then we wouldn't have the issue that a valid pasid is incompatible
> with a certain device.
> 
> Jason
