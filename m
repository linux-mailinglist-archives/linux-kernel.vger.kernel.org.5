Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3B7924E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjIEQAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349622AbjIEE41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:56:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6644CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZS4xNoEUaSyUFd9riJsgAsb90Yy0JGUX5G/uH++FkLX+LNPW+jMvvS8uJLByeWf75djG7sQlrIN6pRRt5AlTZGzQEKTA+xvLbsU8WdG3xPXN8XS5Jvs22qwhY33cG7n9D12onhqBIQBYTaAkLuEkGoXSTYg0wqDSOWpl0xA7hbogZpIUVe+UDXir+zS/DcmV06BPMk9m+CSsFCCLoEPXR0INAvdo0OEdynf9TXBxKHjBskojgwkDVegbIjgBqMHH3QM4IhkrFhQcnhigXNPRUhRoqAYOicZl9dSerxxJm8Asc+qwxnoQsK1DMdeRa7AdgmraXpP19Scpl7G+/yojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl2gn7fOelJCPvfRA4pnzHnUfdTocZ3rO0V26cnpKMk=;
 b=FBLwegbGS0xNBIs5Zy8b2EgVOv35aqcPKZRSOH7kypFkMUIkeZjOTT5LTc9b9DqezfxhZ24G3fMeFZM1ZrjnBQkwbEw0hhl6yCDOdnkOhojqugICyjW0Wn4c9h6lsP4euuqaXn4psSqxiQz9hm3ITGeqTuNtQH/W1Vk3hr2MY9/8FgwRkWWaF1BAp64d5yAslCkR1Uo8dzXMeVnWT0/Vyhsb1dAViAd7YQ/rzu7e0rXUYoMZ5du9cS1feoCTHoGb+3vLrgaSjNPIbm3S7qb3c61OIzJmWANrIwiLMvzGb3xHdev24z0ReuN3Xnfzpuh4PYgG5eRnLvV7/Ed6fOzGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl2gn7fOelJCPvfRA4pnzHnUfdTocZ3rO0V26cnpKMk=;
 b=IS6xw0u3NkxDrfddSJqoIT3eHzFtOE9FLKKEOLiWG4/ONAwRpXNoIVffZ2Y5YcEjPr4KrlqRax22JzFMsFdCpR8+y/0e7L2Ml5sPqyLhshBG/rRCuCj8Ru8tOIp2g0wfls7kIQ9GW+rcRXhgPw36XfF6oowxmBXzsFtLEi88lXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Tue, 5 Sep 2023 04:56:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 04:56:20 +0000
Message-ID: <52cd594e-42e3-f74e-5993-8a8a362dd644@amd.com>
Date:   Tue, 5 Sep 2023 10:26:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 5/6] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230905000930.24515-1-tina.zhang@intel.com>
 <20230905000930.24515-6-tina.zhang@intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230905000930.24515-6-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: 07292072-374f-4039-d30a-08dbadcc71d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcPJSI9ydoapOVnz9n+slYx2rePfM3SSg6hEpNUKhicU00HJr/H6Kas3g1AjhKQgl6JYlVJDQWfMD6Pp35C/ldXHMu1xJ887JvwGXn1eFtLkE0Kxy1ioBU2mauv2MB4Q3N9b1EiWa404shb8lcX3AlAcPuAepZNqzvaWTiDCeYs2Wdtw7ujiI3W8SFeIGhv05erA0MntQGOlMRNwsjW2J0YGvSECx7ULUKALRwcb26Vsmot9pLViHwsVSxZVxKEVd6dURUXe/V6DBxtpMg7IAaVCB6b6jjKXnoZaGIOYCvP8mX6fNWnGFwW4TaYkmdfy+kqs9vwDVpedf4FU6xGBBSNs+xTlhiO2Ma0jpIwJVXya3jW6YHkm9GM1CedDdJbX1NCFdR83LSpQVj90K8L4sLpYpzIAGEjFrMc0KCdgHhhrnpHcgkLuLdU4FTT1y8Jjtf0W2sCc2fFa/BKvujEh2uDrti8mKw8z9QLvXppGS4PQSCjZt6BPbtydDJ2G5Qt1nPrEUdX2a/JlfjeIOqp5UOQW8WmEZr0jz3T7sidCt39mZrX5bxC/wdIQJzc51o4rJ9QNbedwQd/808fdFk12E+Kk1W6EX5Idf5M+D0Sha7pBorAU/8IrvlMl9GnjbcqL2Zld5YY3yTaGeHHw/ngdRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(41300700001)(6506007)(6486002)(6666004)(53546011)(478600001)(83380400001)(2616005)(26005)(6512007)(38100700002)(66476007)(36756003)(2906002)(110136005)(66946007)(316002)(66556008)(86362001)(31696002)(31686004)(5660300002)(8936002)(44832011)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk0rcHdOVWo1SVdHWkNNSXQ4NmlBZkdBMHlqQ1NOaUJSMzh4Y1pxV2craWpJ?=
 =?utf-8?B?dlgrMlBmTTJ3MWhqdkZCdU85M1ZyMWdTNDI0V3I1YnY0STBNUzF2a1d0ZVNR?=
 =?utf-8?B?ejdvT3ozOG1HL0hFMGlGY2VpUlc5OStQR1JzTlRvLzR2U05odVVJd0JwWU9L?=
 =?utf-8?B?Yk5jaTJqNjRSV25jazR2SjMzY2NiZnFjM1phcTdseFZYU2d5TFZ4WGV1VjMr?=
 =?utf-8?B?TzJkVEJZOTJtS0lURHQ3bGh6TFcvQUN2eFJFZSt0cFhaY01RbmV3aHYwbjVr?=
 =?utf-8?B?QW5Xbit6ZVNyWE0xT1M0d3Z3OVlkTlMzbVdvVVo0N1prblF2ZDhVN3E2TmNn?=
 =?utf-8?B?YnJHOERvbkVuampHQnBQazlEWTRPdjJhbCtGZGFveUl1eTdTUHVHVHphaVFD?=
 =?utf-8?B?SGxQUjhBaTJ3QXVnRkhTd0NkOGZaZ29jVXlWREcyT2tyT0ZDdzlKK0g1MG5m?=
 =?utf-8?B?MHlDT1FRR200Nm5sSVVPL3JTcmxSTERQUmpoUkFGUHBTTEVrN0VQdCtRVkwv?=
 =?utf-8?B?NWxSellEamZ5Tm01Q3MwdjlKdGFkOURJOVlqWCttSDFPWXZPeDdZaDE2UjBC?=
 =?utf-8?B?YnE1U3NyNHp3djFkM1dnUThPcDB1ZDRZL21veURaSWpLYU1uMnlDbU92d05N?=
 =?utf-8?B?bzMwVEQ5aXJYUnQrTTBCWTJmWmRFb0VXLzV6WSthUm9WRjFXRlVaRnFNM2Nr?=
 =?utf-8?B?UlBLWU1qbzZVYWtSdzZwSDcxbTRtdnl5cTBSTmllMXZlYWtOKzdXQ3FNcGx2?=
 =?utf-8?B?Ym1lcnlUN2lBcFk5MFBVaXZYaEVMV2NxMHZiNXFjeE9oY05jNXNtb05vY1Bq?=
 =?utf-8?B?RFEyYXVSTDMvODhabm9jekdjU29mMG94R0I4d2pxRTVJQ0ZRdlVxTDV5aHRZ?=
 =?utf-8?B?cmxkVHNPSzdQUXJ0L0N6RTBuZDJLZGcvSkdpWHozc010NDJHZmdDaVRSSGtw?=
 =?utf-8?B?eGNVbmEwdGozZ25vTmgzRzQ0R0puZzJJd3I1VG5vZlN2ajZVcnVNNDhGc095?=
 =?utf-8?B?bzhPN3llQVFYN0tLa2txbzRBV2dkcGdYL1Q1UTBvSjl0WGRqTldScTlxVTNw?=
 =?utf-8?B?djlaQzQzalJpUDIwS0Z5bGl0aEhIN0V2Q3VhbSthR2w3RTR4M09KZUpTTHZO?=
 =?utf-8?B?M0h0M0dQbVZ2YmY3VkNvc0lzL3VNelVLdEprNjBmSDBTU0dLQ3grdWdOdVB5?=
 =?utf-8?B?bE40VEx5L3BmV2pqVnR6VG9DdFE1SFJ4SVh6TktVWElYSUNodUg3UkRnZkxF?=
 =?utf-8?B?OGIxSmlqNER5OWFPNTlLanJIWTQ2MU9GZEVvQXBnUUE3VFA3ZXluNmRCc1Ry?=
 =?utf-8?B?QTREdG5mSS9TYktYSGZMZTBkaEluOFNwaFU5REhaL055NTBRdjJkV0NxYkFO?=
 =?utf-8?B?RGpsRnk2aGxaZTdpRkxNYmNmVWlOYVRyZlpva1JlSTdxUGlyKzl2cVUvWEhs?=
 =?utf-8?B?TTVjUGViWFZRdDEyaFJvaTlycHFLb3VnclRZRkVSaHZFYnpCZnlHS0RBQjcy?=
 =?utf-8?B?dThBcERmSUxiS3AzOERwRzNtRWZ1YnJVeFRjaWViellqS3J3Z05HeGJYeDRp?=
 =?utf-8?B?aG0vWi8vQVhGOWZDWW5pejVZU05lcm5yK25oT3h5VHoyYkhOcVpDRVNXcnRu?=
 =?utf-8?B?WmROMlY3eUtvOWJNTlNEY25xdWs4eXE1Vjcvb1U1cVFnOVQwdVlZN3drMHV5?=
 =?utf-8?B?OVE2MTBtUTZIblFkZ21wcU41aUw3UloveDM5by9paEs4czNxVTgyb3FyTFdF?=
 =?utf-8?B?V1N6QWoycVcxMEVaNnRRRnZVNFRqaFVIYk10UjcvT3MxUFRNK3l6Um5XL3U2?=
 =?utf-8?B?TnVsbFNmT0oydjUyU0pQd1VRck4wMFpPekgrRm1YQjEzZURnWHl2U1BaRmhw?=
 =?utf-8?B?NHdwY29CUnFMb2tqQm5kODdxeEtTZTNhbGFIcFpmL3p4NkRqOGV1TzBOa1Jw?=
 =?utf-8?B?SUxaOG5EOTltL0h6R1JiNlVLSVNzbWp2eXV2bW4yWUt2ZWFPVExualUyTm8y?=
 =?utf-8?B?TDZGRyt0OC96REovR0pmdUlqaHRtVmcyQWxUdEFZYUFDbVlsL3BTaXBNWkVQ?=
 =?utf-8?B?S0pETGRIUnlyTXROaTNVY2NRaWVIazFNenVZaFdVTlVEQUNCbDFUc0FyY0s2?=
 =?utf-8?Q?NTC1KEcj7D4qW06OLLPDYaLdu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07292072-374f-4039-d30a-08dbadcc71d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 04:56:20.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf1vLo2PCn3qe5rUS/mVk26WAMX1WDJUkfy0Akj6cfyX4keaHEKjVQl6B0WovYhePF1Yu7ayW2W/vQPzWAT1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2023 5:39 AM, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when no one is using it (the reference count is decremented
> in iommu_sva_unbind_device()). However, although sva domains and their
> PASID are separate objects such that their own life cycles could be
> handled independently, an enqcmd use case may require releasing the
> PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
> will be permanently used by the mm and won't be released until the end
> of mm) and only allows to drop the PASID after the sva domains are
> released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
> increment the mm reference count and mmdrop() is invoked in
> iommu_domain_free() to decrement the mm reference count.
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>

Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
> 
> Changes in v3:
> - Add a comment describing domain->next.
> - Update the commit message.
> 
>  drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
>  include/linux/iommu.h     | 14 +++++++-------
>  kernel/fork.c             |  1 -
>  3 files changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 0a4a1ed40814..e7e3aeaa7055 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -15,6 +15,7 @@ static DEFINE_IDA(iommu_global_pasid_ida);
>  /* Allocate a PASID for the mm within range (inclusive) */
>  static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  {
> +	struct iommu_mm_data *iommu_mm;
>  	int ret = 0;
>  
>  	if (min == IOMMU_PASID_INVALID ||
> @@ -33,11 +34,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>  		goto out;
>  	}
>  
> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +	if (!iommu_mm) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(iommu_mm);
>  		goto out;
> +	}
> +
> +	iommu_mm->pasid = ret;
> +	INIT_LIST_HEAD(&iommu_mm->sva_domains);
> +	mm->iommu_mm = iommu_mm;
>  
> -	mm->pasid = ret;
>  	ret = 0;
>  out:
>  	mutex_unlock(&iommu_sva_lock);
> @@ -82,16 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  
>  	mutex_lock(&iommu_sva_lock);
>  	/* Search for an existing domain. */
> -	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
> -						IOMMU_DOMAIN_SVA);
> -	if (IS_ERR(domain)) {
> -		ret = PTR_ERR(domain);
> -		goto out_unlock;
> -	}
> -
> -	if (domain) {
> -		domain->users++;
> -		goto out;
> +	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
> +		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
> +		if (!ret) {
> +			domain->users++;
> +			goto out;
> +		}
>  	}
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
>  }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 937f3abc26f2..95ada53f24ec 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -109,6 +109,11 @@ struct iommu_domain {
>  		struct {	/* IOMMU_DOMAIN_SVA */
>  			struct mm_struct *mm;
>  			int users;
> +			/*
> +			 * Next iommu_domain in mm->iommu_mm->sva-domains list
> +			 * protected by iommu_sva_lock.
> +			 */
> +			struct list_head next;
>  		};
>  	};
>  };
> @@ -1177,17 +1182,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>  }
>  
>  #ifdef CONFIG_IOMMU_SVA
> -static inline void mm_pasid_init(struct mm_struct *mm)
> -{
> -	mm->pasid = IOMMU_PASID_INVALID;
> -}
>  static inline bool mm_valid_pasid(struct mm_struct *mm)
>  {
> -	return mm->pasid != IOMMU_PASID_INVALID;
> +	return mm->iommu_mm ? true : false;
>  }
>  static inline u32 mm_get_pasid(struct mm_struct *mm)
>  {
> -	return mm->pasid;
> +	return mm->iommu_mm ? mm->iommu_mm->pasid : IOMMU_PASID_INVALID;
>  }
>  static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
>  {
> @@ -1213,7 +1214,6 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
>  	return IOMMU_PASID_INVALID;
>  }
> -static inline void mm_pasid_init(struct mm_struct *mm) {}
>  static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
>  static inline u32 mm_get_pasid(struct mm_struct *mm)
>  {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2e12b6d2b18..f06392dd1ca8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1274,7 +1274,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm_init_cpumask(mm);
>  	mm_init_aio(mm);
>  	mm_init_owner(mm, p);
> -	mm_pasid_init(mm);
>  	RCU_INIT_POINTER(mm->exe_file, NULL);
>  	mmu_notifier_subscriptions_init(mm);
>  	init_tlb_flush_pending(mm);
