Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636AC78A7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjH1Ida (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjH1IdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:33:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC2FA9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es+sLutZclXP/zaPjjH8KOm8aQSnV9B6Cy5j/lSPsYfkW1Y+PYIn3OqEpI5YBNUJihCzptXYGTYnZ+QBBkTpd2d2xI6KRIW5GmLor8HlDrQ1Ga62A+c7L0aQ3SxmfXptDy7mR2tLsnUwbTVccngwEYmbC3mAz0x+OEnx7e9ocwxUbcFHQtbCBEj7eM00io5ILPCojmHmAIiwqGtMef8gz/K023LgpDWVzPFkxhO1TGEsU6Kmgj9RsGIK2mYoD9wci6ji0XAxdzKAnsYLvE7QCL2O85l2GHTysR4F3FblJmQ74abLfuWag/1uIvEXyMoXzRqUoR8H6QGOENf6jKGUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHPsBgEM7VR5jWegEP3/lG4+dgDZw3S1tTJ6hDchUFg=;
 b=KJWJeIMWtJrXCCp+Ga8ayxccPRhriTTkvH+fxujj87In+QiA+Z819RQFdQ6NZvtJPyYle4hg5PlCkgMhtb0zIcgJsFQX+dvRR4LjxaMFwRMxEm56rLUIz7+XShCxNl9kmPyQqezSRjvVpyg8KpA1rpzfm8Us4x+2i/2jeCySCE758QJ4rvr/gadzAB/4XHdmvVvh+sfqD5guG05Vt8oxtOTH1/CNMgPCaXgOnvpfHbVyaKpCfrQdGZ3H+OAWQAsIs/HQpa7RL382tiRJDLUWcoEPUt4VfEiGNCdvPs5f5oAndZbzMCwBiaA0nOyXJA6tSVqNUf6ZfaDIVr0o7llnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHPsBgEM7VR5jWegEP3/lG4+dgDZw3S1tTJ6hDchUFg=;
 b=HWY898cgtp9ymgZzOkR2wOn9aqFWMXHh/iP2xBYQEPvAVKjRcOFh60r++xkkUUdhHp634Cn5J8YhUGgwPTASR/fkOswar8Umt3Ys7N7zEoCzZGDVIqFjjb4r1ChoQFQmolJ9GYIMJ8pbuXwpK1iQ5hMZyfv9RzMSE5eKjyeyBdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Mon, 28 Aug 2023 08:33:05 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 08:33:04 +0000
Message-ID: <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
Date:   Mon, 28 Aug 2023 14:02:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230827084401.819852-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6c85f2-1911-429a-2877-08dba7a165ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uV4aJMPOH6bM0ngmPR7rMYmpOoJ/8vR18KwVVY/CEZD6nOk+oxmAmLvnqxO/O72TeYX1InQqypj2H31DDJIUYFOJ7UMuubsGubAMRoubPoNhAw1+VS3x4vSUsM7kOe/sCFFztXJ0OI6dX+kZ02xbf7vbMu1QUmypnR+lfzqeLOhu3jCluT54kAvrzRzHAXcXdOSBiLvd+gYKLbjjXzM8N+ulitjNP/IcXpQ/CXPQoLFYb2MQQeNkWz8+1siSyyqgaTDtAAi93bdhbzKj9hQomayGMza4oEAyBpo+guVklXQKwWMQAvHYzrwrLefb4GpZpduFPj1bgX/ltmz320XqmWqRT78lP9liJBY6hYHwgehUxesKo/PKjjWk2PExkUjBS5Ej5rjHHxc53lPn7CPqQGeAzXRoMambaQDXC9A+r/y66PC6eIElOXlV6ffMjWIQaicY2XiuUFMSry55XR7Rs+g07Z+WckgzV0ATgr4zWFHzDOva7bCcPFu6TiMuRZ16YyiFf+HFByv1axxTRDjMCluQFE/HwADjVYE5I7qC+F+TuUaOb++0NH8c+crOQFK7/W666BKgZIgbRIouMjcgPlGNqEbhF2+oXkX8AYWzX4WwLX1cnB+okiv8WeYyCHhFvw1+5vkeTkjz75KL5eGmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(1800799009)(186009)(83380400001)(478600001)(26005)(31686004)(6486002)(2616005)(110136005)(6512007)(53546011)(6506007)(6666004)(31696002)(36756003)(5660300002)(86362001)(2906002)(316002)(44832011)(4326008)(38100700002)(66946007)(66556008)(66476007)(8676002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTljbmE2VG0rQStGUnZqSGh4UXc5bkN1VXZtOEEvaUY3ZTJpU09MdnpaVkVn?=
 =?utf-8?B?ZkJXOUJhMVdmbTMrc0xvY2J6M01VYjdZYnREeVRmQUlmQVBzNlVEeHZKRjEw?=
 =?utf-8?B?VTJOb0Q3R2tHYXZLcHcyQ09Xdjg4eXhtVHpmZ3JjY0NGWDg1WlRZQUd5V2RY?=
 =?utf-8?B?NnhONVZFKzNzZC9YMGRNcGxwem1aV2N3NHJXN3pKTWRyRllRbzhkYjdtSjln?=
 =?utf-8?B?VFloaFRSekYwMVZqYlBGSmpxM0VwdEdMY2lMVlo4QTZQOW9PQmtYOVRnVzIz?=
 =?utf-8?B?VzVvRHQ2NTBjK0FmeG9lK3h4akV2QWNJZVQ2cjNldWpNejV5VGNxR1FhaHJO?=
 =?utf-8?B?VUhleHRXMjZOUFZkcEg1bkpQL0dZZHJhbFEydWllc0pGd0VLbW54bEZjTk16?=
 =?utf-8?B?M0x3Z3pSMVQyazkrbVF1bVpCY1k0eGY2S0s2QjFacDVBdFFYYjdOSUhIN3lP?=
 =?utf-8?B?VXljWjlxUGxpMUxrTTArVDdoOVBhMUFmN3lmN1BhSktFc1V6RVJMWjR0S09I?=
 =?utf-8?B?c0N2QkFkM3NnM2V2NVA1K0ZlM09GNHUzZW5ZSEN5eDdQUDV4aHZGSDhxOExm?=
 =?utf-8?B?N1N3NUxyQ29QQ0Q3ei9GQlhudjQzMmdIMDd0YnRxT3FrK1kwbFJMWURRVnF1?=
 =?utf-8?B?aXNtT2xlSUovRjIxWGdkam5FcFhiMnUydHAxMEM4aTF5REhtbnNWMXJSUlhl?=
 =?utf-8?B?Y1ZtTDhTeE5ZRis0UjZXVGQ5NS93RFBLUTV5V3lFdGNjR1liRlQ1WVR6cEQ2?=
 =?utf-8?B?aTZwOGdFOWNPQytSMHU1L0F0NFpQSDZZcjNOVkl3VW1uVXV6c0VHc0cvSm9W?=
 =?utf-8?B?Y3hKcVRGY0NBRHl3cE1iUjdSek9kV0NRRHVhdWR0UDA4b0hVTllLZUZRMkYw?=
 =?utf-8?B?V0d2V3BOMVdyU3lYbTlGazVicDI4ZHdvYUdjaGZXQUZCSTdzWVFVdEVtdU9u?=
 =?utf-8?B?dkkybDVWcFFhdk8xaHRIZjdhcWpGQTFnQldlQXdhLzEya1R2NTdzdFJ0T2kr?=
 =?utf-8?B?QlM2TFk3OTZHL3FSdHExV1FPUUlISWY3QmJleWo1ZVBtbnhPQWRkYkNMemZD?=
 =?utf-8?B?c0NqOTdDemdTSTlKRWhRVWFLTnppNGgwTVpVQXNjZ1I2YlBNcFkzM1F3ODd2?=
 =?utf-8?B?c3lVRCttTmdjWlNzeDR3UG1ibmZWWXl6TkdDQXI0SlkrUlpRTWcwTURjaitR?=
 =?utf-8?B?bmhYdEJUNHZ1NjdmUzI5ODVMNWFYT3dsMDVYc3hjblJCcG51ZGFnck9UY3pC?=
 =?utf-8?B?M3dqRlRiaFU2SkV3c0VLbzk2Sk5ZQ3M3Umt5UUxaQ0FJb1VCZFhpVUljbENl?=
 =?utf-8?B?RWxJZ1VrTXo5b2ozaUNyQWJEOEh5M1RTYldZUnRWZUNBVG1jNHVXTDJYRTZI?=
 =?utf-8?B?Ykg5SnhPTWRGVGdzYXllV084M2I5ajI0dW1TbU5aNGkrektwNFZDQkJucGlP?=
 =?utf-8?B?a3VlM1pyMTBzMlA2SnpSc0dFQi8zby8wRE5ZS3V0Y3pCSjdLeFN1bDI2ZFNC?=
 =?utf-8?B?MUU4eEorU056am5SeGl3RFBpaWR4SzhYd2VhdXV5N0VmTmRSV1UxZnhTVytV?=
 =?utf-8?B?cWV6TGkzUUlocHZ2dlY2QVdmai9xUzNzT2ZGZmlhaTgyams5TGtJOHUvZTdo?=
 =?utf-8?B?dDlzVlBjUXk2dmx1aldVZjNVZHN1dnRZSXFoelI5RDNTNzVPY0JudS9LYUhs?=
 =?utf-8?B?VkxlTkxVWi8weXk1SEdZTkhBRFhrTGhlOW1ESXRoUDR5UWpVS0VSUXZZUXJy?=
 =?utf-8?B?UjdoejIwY2ZHekF1Mkk5eDJIc0J2djVuTncyZnpMMUFrRC83ZjRQQ0NrN2tk?=
 =?utf-8?B?WVhPV3BjSHM3WUdjbSs4dDBzdVc4UjVodEgzSzdMZE1lRXA0MitBMW9ubnFQ?=
 =?utf-8?B?eWhRdGJDSldyVDZjdW5YRy9abFF0WENpL005NlpOMXU4aVhaRFRMNWVaSU1q?=
 =?utf-8?B?MHUzQWxSemtBRUtIUWhGRGdTMExEb0ZCdWlTZ1JEQWdkcWgreGF1cDhOZXhN?=
 =?utf-8?B?OStFWlkzc0MyOGFINzhlbFd5NFFDUmR2SmFieHlWY1ZmQUk3cndxSHc5ejBT?=
 =?utf-8?B?TGVjeGtxWDJkOEtFUFJLMzdnTGduWHdCa05QWGVUTmE3K3R3THJLb3YxQ1li?=
 =?utf-8?Q?pEDBVidNoA4JWhy8+NzoDPFdm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6c85f2-1911-429a-2877-08dba7a165ea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 08:33:04.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQxCXR9D5xdfDJ2sURhFQrygoHNcO6YDjUH3F0lecbfypxPK8vLsOwIQM5FzH2YibewPGajb1GNQOCn0sB8ELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tina,

On 8/27/2023 2:14 PM, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when no one is using it (the reference count is decremented
> in iommu_sva_unbind_device()).
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
>  include/linux/iommu.h     | 10 +++-------
>  kernel/fork.c             |  1 -
>  3 files changed, 28 insertions(+), 21 deletions(-)
> 


.../...

>  
>  	/* Allocate a new domain and set it on device pasid. */
> @@ -105,6 +113,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;
> +	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> +
>  out:
>  	mutex_unlock(&iommu_sva_lock);
>  	handle->dev = dev;
> @@ -137,8 +147,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  	struct device *dev = handle->dev;
>  
>  	mutex_lock(&iommu_sva_lock);
> +	iommu_detach_device_pasid(domain, dev, pasid);
>  	if (--domain->users == 0) {
> -		iommu_detach_device_pasid(domain, dev, pasid);
> +		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
>  	mutex_unlock(&iommu_sva_lock);
> @@ -218,4 +229,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>  		return;
>  
>  	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
> +	kfree(mm->iommu_mm);


I am not sure whether I understood the flow completely. Just wondering why you
are not freeing pasid in iommu_sva_unbind_device().
I mean once iommu_mm->sva_domains becomes free shouldn't we free the
iommu_mm->pasid?

Also in this function (mm_pasid_drop()), should we check/free sva domains?

-Vasant

