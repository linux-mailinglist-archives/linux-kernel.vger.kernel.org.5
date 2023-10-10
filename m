Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A952B7BF990
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjJJLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjJJLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:21:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6CB9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696936912; x=1728472912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GSwSurgU5VmpCGT8SNeLj3Hu/yO4xG94clrYMoyVdno=;
  b=RXC7PWHk8n+porQXLqg23Y09rj96ZLV50vrazhyNll23y7YTvWz49XnE
   EKXetbZKp3y0Wy6vkzRFMjexUExlp7o940x0HitXxtTpco2byXmlaqGrS
   jh1qDBDdFml1b1vsRmBlb/JM3CQZDVZyxxgmvIr6BUCOivNXpp9l/Lr3q
   GWcfQWDXtH6H7lCwRMhYJgDe6x/UW4R9HXb3DQlmf7DXhotuQiLnBJLmV
   VkSB/rNWG3vgxLRTTjkHCs1FEk+sIeC2zAkkIxIdFg1gNSKaXuuuK7QtL
   usjHiwbdl+ZokAzUCVViKmqwkXGoHE3PtpDpSvTuSXuL21dxKN1agZmMC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363717120"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="363717120"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 04:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788552275"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="788552275"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 04:21:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 04:21:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 04:21:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 04:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIhiESZjHOS64gqATvfe6+kE0ASmIYN1Wj7Rguh02pQ1T4jtZN2h5tfKEMydd6t9u6L6m3H46e0XXGJg+6nw0GLrkrEQ6I+TMcvfHItPCFh8cDH7HhSc6HPm1TfK4hgJ+vFVB+G+qBo3Cvy1B+acsIYSObpMKqINBLIPQ2hFhDIwc81CIn/YyKe3I/l9JCAjEgPb8IE5p0A/ilzq6nhbY7ISXgo3uB5ULcNIGI6S7dYWL+0F/aFPXUEQ7SbZeM8JX3KHtF45q1NcSBfbTqLQYDgAchKIxwJqcJJJ2eb9ro245mzu/gut/WD6/yZx9b59slWcLzoseFXBI4cPJMZpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAeFayLPvfU78cudZxpiHCnGQDLT6sIOx5gClKThKzc=;
 b=iYpTa8RdU6rfGn0ErcsVfwtUn5NDPM/yvrgNg4Q8jesXQKirD6RQnJ9sNljUnCenCK5DA+gzI1N5+aJdaMaec2ZyfnD7fbICzsyCPpO0epZCl2QXirGUXtKDhL3f1LXx37Ilh1PjYSHg480iKabipLE0hMIjPegWbcjjvYtYZ+YsIysgSa9/O8qbeAGwt25Bf4AxWhFN9PSRrXpn+VyHrU3QRKxGBGIUD18wEtDvwGer/dKZQVkPFuGFt/jbzQWkZrBV+OZKAFEczjY/SHEex4aG3AGzsJ8KnFL+WFtrTEhQrCNXg59pnE9p3HBrSMmQc3xRmaKgKg/sAcK9ZlDSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 11:21:39 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:21:38 +0000
Message-ID: <7d8e895e-5f95-4ab3-b6dc-292b4197bc87@intel.com>
Date:   Tue, 10 Oct 2023 19:21:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        "Vasant Hegde" <vasant.hegde@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-6-tina.zhang@intel.com>
 <ZR/ATxpIfCPRJO6r@Asurada-Nvidia>
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <ZR/ATxpIfCPRJO6r@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|PH8PR11MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 433384f4-56f9-4d80-2813-08dbc983120d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il+QatrI590pkorMZ2q3AwGKZkWNJHx0VlIZRc9Sw+nEjBOYr2efpjl3WvKGmx5crV7sZ0+CX/TUaCVqoaBfAmxxcZEzoa6xKLuuPNxCz1SowM09UD/XHSpz6mK9h/DAj1DziyrbI0Nd7FldMtq7bf0/rPTFDChT3pibuhc58Ua4eZlVpvJeYydkOd6xzojE5rxPuDWcWQ4XoAsVlbKCyhe56beNDyuI0sazaMITUESMwOlco8IAvE6TpOt6E0JubAYkzgi6tpR1+8THwSY2CdNAxhMfnFERpjRa1FrKK2hecYeMhPlgz0ZvspFpinV+GFt2g3nLh3BXvafzEtJEhIShPfRQd38YPY6WFgoDIhx7LjVy7ZRg8n2K9KZ2+gMcX0Ccc3Y0Csr17eTz/EQsAPTMpxR7KzbZsr/Ih7urEeDXgh90ba4gIruAUcc+EOSSgOwzwnmZnss7tKkrpLW39yWeYIMRuFcX767mpi5im1eH7+SzjVvt1AM4e41y1dSQg+f4ZsvGwgNglxzL4BWu6lA5jia5sEinMd/al06mqebVKSSgHHwiHGPV/yFcsBOQeHnKp9sBZPercT7u5Gg8TQuI23DLGMSlzri45SVjz80B11uc9AZGAJblXKSyvCkpUhRyQ13L8SXymElpklYhOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31696002)(86362001)(82960400001)(38100700002)(36756003)(31686004)(6512007)(478600001)(6486002)(4326008)(8936002)(53546011)(8676002)(5660300002)(44832011)(41300700001)(2906002)(6506007)(6666004)(2616005)(83380400001)(316002)(66946007)(66556008)(66476007)(6916009)(54906003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZERkbjNEcVIzVWp1RzZoUm0yNHlLanJGSFNpQ2pqU24xMGVYRGllY0JTNzJH?=
 =?utf-8?B?Q3BLbTZQY3RSaGxaK2d3UHFlOGJoRU5ieGNKQW5meFZKbkpTVk5BL09uSVhw?=
 =?utf-8?B?S0ZhWG0weUMwZDFmZW5tVXVweUJvakxkNUxpUGZnY0l1UTdWUC9rcVlZZjJM?=
 =?utf-8?B?Z29lMSsxNmFkQkR4b2c5U0tvZTgxS3BCbEJ2M0xwZUZickZiVVNPOTBhN1BX?=
 =?utf-8?B?c0VFMWRGM0swTk1uNHRuYUhiYitCekpTc3AvVDB1MkxjUEwrZjdlSEtabnha?=
 =?utf-8?B?cmVUd1F5STlWeXJGNWNjTVRUc2M4SDVMRUFMdFlKVWx3V3U3L0dBZk1uWmg4?=
 =?utf-8?B?WXcyMS96VmxmOVlEbFJxSmdueldIamZOTFJaeS8zd0tVdFRleWE3WHZuWHFJ?=
 =?utf-8?B?SEd0RkVvOXBOQ294bHZNSm15Qm5lQUdjWTlNOStoZTYwNnM4WERnS1B1L2gv?=
 =?utf-8?B?T0ZEY0hzZ3doR2ZHS1gzQ2lKblpnVmpMT0tRZnRHcmhtZVE4S3lyTExpK2JG?=
 =?utf-8?B?M0JIc3RJRm9LNGwwUzU0eG5IOXpHRXJRbGwwNWRnSU9jTUNGbWNSSnJBM2dH?=
 =?utf-8?B?dS9wNGF5VnptRU5uSlhyYnM4bUdiQlo1WVp4aHU4MkxaLzBERE9SUWN3bmRT?=
 =?utf-8?B?cGZla0VmVGYzVXA4NkVESVY5WHZPa0J5VFFVVkpFWEVHZGpQZWdZWWhxMDVp?=
 =?utf-8?B?WlNPa1AyenZjOEF5bmJOL05lcU82ckxiWU50ckY2aUtZeUdJcWQ0VmZxYXR3?=
 =?utf-8?B?aEphQzBOQTRuY3hHL281K3JEYSt0U0lpRnNxc0NsSzZ2eTI1cEZnc2FMNHhR?=
 =?utf-8?B?VlRDblkxbE0vZ1ZXeW1PQlBGRjBwVTdNNFp6aGF0T1o5b0w2VytYRHNVdy8v?=
 =?utf-8?B?YWRzeUZaQ0JZd3MrVFFNS3YxZVNneE9IdUhTNlhZOGJUZllqakRxV3hKRHVz?=
 =?utf-8?B?dUUrUDNCUkI3ZndxbEV5MlNHODRWU1ZaZi9yRjJmQTF6YldILzZJNHNlOFd1?=
 =?utf-8?B?NWpFQ09KR3N3UkpZMDdCRm04Z1JqcHRCeWF2S3dFODhiQXYrQVE1R1c1R1A3?=
 =?utf-8?B?VkJoY1pSUGNqb0prLzlwYW0zcjU0Y05zTTQwWk80cmlIbzBxYUVBR1JHS0ZU?=
 =?utf-8?B?dVZwbTAwOWwzUXFhWmloOEF0aHh3RTVFSWJlWEhDOGVrQVNkVTVQdDQ1bWRD?=
 =?utf-8?B?WHBYSUI4SjhWY3dmNmkrRnlxZG9PYXMwSStwUXhxdkU1dklLd2FGRDl6ampT?=
 =?utf-8?B?K2pCTG0wNXQ2Q3ZUbG9nNHZVYks2K3pMTmZwbWJERkdMR0xFcFV6MTc0Q3Rq?=
 =?utf-8?B?R0FMQkxzTkJ3Z3ZBYzR1YksvRFVqcitPUHlOT0VTT2dmblFsSDFnbmNOSk44?=
 =?utf-8?B?cG1pdlZBQVZINTB4Ly81dy9OaUQxc0dWSDdBOXlqTDJURXN6TWF2STdmc2k1?=
 =?utf-8?B?dFBQR1c5L2dlTGtRYU9La2JEaHVFQUZtZUdHT1grYk5PQUhydGdMZ0dYUjAv?=
 =?utf-8?B?ejhSWEoxTnpEOVZObmhmUGQySlY3MTlyNzdKc0tuZVNtWmhXYllZSXcwQ05M?=
 =?utf-8?B?WFJxNHJpczE4dFJzU1ZDTVI1MlZad1g1THRWK2VDcjJxc3lrUmRUVk4xUmNW?=
 =?utf-8?B?ZVhpTnJGNGh5WWNYNm9lSXhHdEpFZHRvcUVwL01ScGRIbXZSQ0EzeXVZTmJm?=
 =?utf-8?B?aDBwRDlsckZmZ3E3T002cEViWnpoTXppZUdYd2dLUDBiSnJpRDk0akdzTnBl?=
 =?utf-8?B?TWErWk51emtNWi9WMDlMS0FHMXhFc3htekU1citIMHFrUVZpNHJQT1lNMXIw?=
 =?utf-8?B?ZTRUbWZMTVRMb3BBWUMxTUc0OTh1RE52UHYvVTlmaVFZU2VDRHVUZnlTUm13?=
 =?utf-8?B?RCt6UUF1ME1rNDhta1VaYXBLZXRMbGJRTGUwMXBVc0JHWnEwVEhxUkNKTlMy?=
 =?utf-8?B?S1lrN0pLcXlVTnJ1UXpRMldtTHNUaEZMRHBIUGNTQStRaVQyR0l3Rit0Z3ZC?=
 =?utf-8?B?M2I1S1F2QUdIZWlNSkFKU2IzSVFDZkFJdC9aS2tMaUd1ZzdFTTBnTVV4R3Vl?=
 =?utf-8?B?dGl6ejhoSll5N3UzMHhLZWVkVjMwemt5UEhSbnBmcmJ2WUQyU0pSWGtSMUpH?=
 =?utf-8?Q?5pS2Hl3NrEiqOGxV4rZ3M2cs1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 433384f4-56f9-4d80-2813-08dbc983120d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:21:38.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyw6edNmgE74C8nzrOgv+oUqoouFCGEypQmo/Osrmh2sTOFdR4b6WvrR9TMT/bKd5Nf0jl4G+2Jt+nBtRMXeOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6878
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 10/6/23 16:07, Nicolin Chen wrote:
> Hi Tina,
> 
> On Sun, Sep 24, 2023 at 07:38:12PM -0700, Tina Zhang wrote:
> 
>> Each mm bound to devices gets a PASID and corresponding sva domains
>> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
>> field of the mm. The PASID is released in __mmdrop(), while a sva domain
>> is released when no one is using it (the reference count is decremented
>> in iommu_sva_unbind_device()). However, although sva domains and their
>> PASID are separate objects such that their own life cycles could be
>> handled independently, an enqcmd use case may require releasing the
>> PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
>> will be permanently used by the mm and won't be released until the end
>> of mm) and only allows to drop the PASID after the sva domains are
>> released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
>> increment the mm reference count and mmdrop() is invoked in
>> iommu_domain_free() to decrement the mm reference count.
>>
>> Since the required info of PASID and sva domains is kept in struct
>> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
>> field in mm struct. The sva domain list is protected by iommu_sva_lock.
>>
>> Besides, this patch removes mm_pasid_init(), as with the introduced
>> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> 
>> @@ -128,8 +142,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>>          struct device *dev = handle->dev;
>>
>>          mutex_lock(&iommu_sva_lock);
>> +       iommu_detach_device_pasid(domain, dev, pasid);
>>          if (--domain->users == 0) {
>> -               iommu_detach_device_pasid(domain, dev, pasid);
>> +               list_del(&domain->next);
>>                  iommu_domain_free(domain);
>>          }
>>          mutex_unlock(&iommu_sva_lock);
>> @@ -209,4 +224,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>>                  return;
>>
>>          iommu_free_global_pasid(mm_get_pasid(mm));
>> +       kfree(mm->iommu_mm);
> 
> I ran some SVA tests by applying this series on top of my local
> SMMUv3 tree, though it is not exactly a vanilla mainline tree.
> And I see a WARN_ON introduced by this patch (did git-bisect):
> 
> [  364.237319] ------------[ cut here ]------------
> [  364.237328] ida_free called for id=12 which is not allocated.
> [  364.237346] WARNING: CPU: 2 PID: 11003 at lib/idr.c:525 ida_free+0x10c/0x1d0
> ....
> [  364.237415] pc : ida_free+0x10c/0x1d0
> [  364.237416] lr : ida_free+0x10c/0x1d0
> ....
> [  364.237439] Call trace:
> [  364.237440]  ida_free+0x10c/0x1d0
> [  364.237442]  iommu_free_global_pasid+0x30/0x50
> [  364.237449]  mm_pasid_drop+0x44/0x70
> [  364.237452]  __mmdrop+0xf4/0x210
> [  364.237457]  finish_task_switch.isra.0+0x238/0x2e8
> [  364.237460]  schedule_tail+0x1c/0x1b8
> [  364.237462]  ret_from_fork+0x4/0x20
> [  364.237466] irq event stamp: 0
> [  364.237467] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  364.237470] hardirqs last disabled at (0): [<ffffc0c16022e558>] copy_process+0x770/0x1c78
> [  364.237473] softirqs last  enabled at (0): [<ffffc0c16022e558>] copy_process+0x770/0x1c78
> [  364.237475] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  364.237476] ---[ end trace 0000000000000000 ]---
> 
> I haven't traced it closely to see what's wrong, due to some other
> tasks. Yet, if you have some idea about this or something that you
> want me to try, let me know.
Thanks for reporting this issue. I did some sva tests, but didn't run 
into this issue. I'm going to try more cases and let you know if I can 
find anything interesting.


Regards,
-Tina

> 
> Thanks
> Nicolin
