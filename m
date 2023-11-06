Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC47E1CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjKFIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:52:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38780DB;
        Mon,  6 Nov 2023 00:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699260744; x=1730796744;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6TJiS9FBIFTCi7j8+v1mZwh8E2nHS2UfDUhhmmtCwN8=;
  b=Mlae/r1+jim0ZY1VVFxuDIRw9QM/sLSJFzL3ZfsXwCB2RfipqDWFiYbG
   TXf2vkxog6kaOeACF3DQTnfiTvJ5NqjEOrzXHsV1GKrgeqAq9rpm/3zx+
   bAHNzpKLWC68f0GLVnUnWTHneTfhjEZUAssAEkvc6GYHvQst8xRHaqUDr
   G7Zj9Ql4cGxcvREGulesPdEtPrUiG+6Xj1FPY10seSYX6ycYSfJcLL258
   I7CcKLKR+OLL6kG9EXZs6XO3WyuRqGJUgeLvk50ErjwDYgcb8vDaS0L13
   Ho8d6ETSzotEkbIwUnjUSYuI3WkhRnR9zGMreRBQJUqjO4lY+ebteBPFJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386407339"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="386407339"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:52:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="797243927"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="797243927"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 00:52:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:52:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 00:52:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 00:52:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3bG2aJ8r9Wo5DXDxYmbn2D+albQu/DCfKpGv0sAPzsJpvwMcuDoxqLXLLigDgWpVI1zfpTYEOxnSuu3fDQA4P+hFpDqYensgSkIqIsYOXxqmWeuAHS9zNxt/xAtYNxG84I2mMi6ckG/K7I1IeFI/48gAsmm97eEJUBGKQbGxTscP7b3pnpFIdQ6vK7g1F9NLEGraydTvNESarLGKjzvMUe4qnjdTPFHPKPdYtFcQqVDMs3q87IIBtPQ0aiELsS+qqczGF2X7Z+VsQwcgPds/E+1lB9Tsc8zIwbONdXveAup8RKUARRqhIdOLGEaWzuZcl+C2qpFEEqSvz43Szx5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tqQWmJDdFJK9ATq/L6YSAQYJb1Vgdy3fGjagxKfQ7w=;
 b=RvQqw7H+2b52aTtqdHntP1FqPxhdpNs6tcNLcOv6nQX2ARf/azsY5LuF1qX1rIjskKyLW36EG74gqryyIIcA6f1W+e2K06vwfikMOzUIMoSumKtZNYmUVM5zPF9Opl++cTyLvWKkOV9spKvo0HyquiuTRotpZiZGP1scYAfhkgpTx4A1SWew4gajk9qW9IoiM1G56BK0QCw4iCYnrFgZd15+5D57g4Z6gfJYN/26sK+xKDzQw9ZHA86DdYQbOT7M8XJ7Qgo/Emmz2iNAhsor/ItgsdfLkRdhMAZjkbOp9j688onSl3+6fpvGfTAEQIyuFupL+/OmsQxTiyRpAHpasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:52:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Mon, 6 Nov 2023
 08:52:16 +0000
Message-ID: <12ebf6fc-9228-47a1-88dc-a177f7f7d5db@intel.com>
Date:   Mon, 6 Nov 2023 16:54:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 6/8] vdpa: change the map/unmap process to support
 iommufd
Content-Language: en-US
To:     Cindy Lu <lulu@redhat.com>, <jasowang@redhat.com>,
        <mst@redhat.com>, <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-7-lulu@redhat.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231103171641.1703146-7-lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN2PR11MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe212fb-02f0-4c08-ec09-08dbdea5ad4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUlkNL9zeHSFCJdCutNNpSlu4G0EP3MS0wQxxOpqJXgGd58raXG4CgXO1WlpX5/7QIEBpzMqDiV2C2SobBBbiaNEcEiTRJYFwCkUNWXX74gZBXfjlCT8mr8JUIpGdtYId29nSOOIQjYbZQ7HbLlLSwR0or5TwzX/ms8Xrly50LlMPecz6OVhQqTL07Uy3S/kgb016JtEKQNaMXrSKe5xX/GexsKOAM/aPopSLnl++l0lRFW/UBhy5Ui+2CbrSX12mOmZ2QDLihcZDYzFui4G6wuzJtgTYrt35iBQQEU17rqBEQ398uvSOxKQzyEpFsFOQAtmXtXIpuRVQ48r6nbdFu/OxIs1CBF1DFWPYuHEWBfR4dtnx2jcoGDKs0Pyb261KHPDp8fFpBMBU99qCVWXjHm6rE1vDxn32XdmGUVWwoDdw0npVT+tra0WvmY9n1s34kp1Y5pglzLyEklfSm983mOMLYLmAsUAIq4KnY/Vkk8MKA4jdkT6xd678xz3B+0vKPIp9qvD/Eh73D1amO1TczzcBpKIdoUDpwmh4FmxL6H5mgUVk3iY9iqGKkhtERAsIk21FrEX4UBytSfk0NLJZOP7ZlpX/oTp/g9rs/17fIO/ffp/yszzKkClnYSKeFgOpD9yPA91n4RRm38w2fC3Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(38100700002)(5660300002)(41300700001)(2906002)(31696002)(86362001)(36756003)(82960400001)(478600001)(31686004)(83380400001)(53546011)(6512007)(66946007)(26005)(2616005)(316002)(66476007)(66556008)(6486002)(6666004)(6506007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RhT2V1SEY5c0kxdFJhaXNtNVdqNEtLQklPYW1TK2J3SVFGaUpHY3d6ZmY2?=
 =?utf-8?B?ZUQyY2gva2RqZ0VWOW5BejlTemhIcDc1Q2hlVmRlRnJXaWlFQnRkSUNFLzRl?=
 =?utf-8?B?SnpsQVdTbjhCYnZ3MUhUdEw5d1FkREVlQXFxSUZnZHZUREhid2ZHL2Y5dlJO?=
 =?utf-8?B?VU9Ec3VyckhKUnBjbGJqVmVXdENVa0piTTRWeXg2MUhpYkpTY093dEJPaG1F?=
 =?utf-8?B?RGFITFdpUE8wbzZ3dzRuK3V5RU1weTdmYk5ybHlzSW0rOE8vMHB4SkJ6UFlN?=
 =?utf-8?B?QWlja0JwcU4zdGZaNm4rYjJkUUtwQ3Q5R3R6Vldob3lJMDhsUi8rVDlWT3Np?=
 =?utf-8?B?a0x6NWRRaFMvNEZUYndmU0w5TXplMW16ZWVRYVhvMnJRblBncUtoN0JkTUlR?=
 =?utf-8?B?N3UzV3hvei9nTWwyaXlVMXplWFMrRHplWTlTWFc3N0ZhTC95RXB6TkVoNDlR?=
 =?utf-8?B?YXF4dE5Rc2pVLzhrbGZ4eXRaVjBjYldtOVA4Q3ljdE03OVBxSWw5WGR5a2ZU?=
 =?utf-8?B?SlJqQ0hJYUdnaWd1MzY5dVhCMjdKRVRsbjZyNnZzbnhpVWpZN24ybU9nQnEw?=
 =?utf-8?B?bEx2b3hVanVuM1BFaTZRZkdVMmZGRHNjeThHMzNRYUUzNmhPaUl2bnNNamp3?=
 =?utf-8?B?c1NaNlhMTmloQmZpSFd3eGdvUHRQTVR3aUFmVWFsOE9oV2JCZytKS3dmWnBQ?=
 =?utf-8?B?VEZXWXFwRFBpaC9DdGZWN2RhcWhiZ0lIeXlYMDgzNStZRUZNa09UNmNCclU4?=
 =?utf-8?B?TWx1R2VIT3BEQ0V0d0VtT0RQa2drc3g5TW0yM3dTR3pGcFJucFkxY2RRTS9Y?=
 =?utf-8?B?TmV6THE4L1A1RUtUaTNVNnFVejFwb3pEOE9DdVBEYXVaRHJZZDNtd3NPQlhl?=
 =?utf-8?B?ZXhRZm1RMWphSHptZG0ybTB6bWV0QnlBTDFFcG9BekgyaTdTVU9ablQwM2Iz?=
 =?utf-8?B?Q0FVeTg0RjBPS2krc1czbkppVmhFOGhFMTFpSjFCenI5anRkWm1nYXRNWVZx?=
 =?utf-8?B?WVVFQWdSTE41d2hFVWkrNjFJYUR1c3RvaHlKT2oya2I3RDB3bjJ5OGluM1FC?=
 =?utf-8?B?cHFab0NjOERyNkFaTnBKODdPTlhscTc1RVRHUURpa1dwSVpTOWh3VHdXcmpZ?=
 =?utf-8?B?b09NekZSQTBYVi84UjR5RmlXV1N2bHE1T1I2VWQyZFdRdUhqQzA5TVpBZUJE?=
 =?utf-8?B?bVR3bERBTFdvTmRiWFd1R3d1MTJabHE5TGlCRXdFU1I2a2U5Yy90VkhLbDlO?=
 =?utf-8?B?eTZRZnJBMlNWYzNhQm85bW5Va0kxYldtQk9sZlh1TWllTkVHWGswSEx1QVJk?=
 =?utf-8?B?L2hqT0EraTlnYkRlNXowK2JyMTErZFFWZVBUZzhMQlZtbE5XTUNFejRPZHZE?=
 =?utf-8?B?UHVrOFQrMzU4QXNPeVNXeklOL25LbG1UT3ZKazllU0NZaDNUeGJieUJjU2h5?=
 =?utf-8?B?SkVNSDVmb2UvTkFReWI0TklTbmpMNFIrWFZRZUZSa3piaUoxdndubUx2aG9Z?=
 =?utf-8?B?bXkzWlRscEFpem1CdWtRK29vamZZbTNkYTBGNCtRRGJSZVZNb1JuWDVVZVFI?=
 =?utf-8?B?SHlYamoySmNLSWp5TGNFYUtzRTl4QnZTY0FwS0FPd3RXSS96dFowcjJBaC9F?=
 =?utf-8?B?QjFEbFkvZmdiSnpCV0NtQlkvcFF0MFRWZnMwTXZ4MEhGaHpidFM0Uy8rT0xB?=
 =?utf-8?B?ZGVOSEZHRnBSc29RdU5FZ0RHbFpZMm9vZjBYMjIwYWFHVnQxSGVhcWxFUTVZ?=
 =?utf-8?B?YnlrUnhzODIxK3hBemM1amlNS1lDOEVMV0xWb3Q1dDZjWjAxL0k1M293dkZQ?=
 =?utf-8?B?SVh3TEdScWxsZVUyTmV5azFEclNaTVNzaTJJekZVdHR3b2d6OVViK2VHaUNt?=
 =?utf-8?B?alQvRFhzY29jdVN1R2Zjd1kwNVVZaWVxaHozRkVySXRabUR4MEhGck94Zm13?=
 =?utf-8?B?aWc2dWVCbXc3eURNVEUzRWtQWitVZyt3bXlJT2I1am5FWjVET0dOTFVWc2dN?=
 =?utf-8?B?ZmxxbDlPSC9uZWZNSzAxWDlHNTFZZG96a3lNU1IrL0gwTUkyZVJLa2xZOFps?=
 =?utf-8?B?U0RlamcwNzZESjg2LzB2Q0p5TTFNRWFWTUN6aWc4WDJoN1Z2dDFhNCtwN2FM?=
 =?utf-8?Q?ZqLJu930KX+2w3IA1gh6PMOiA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe212fb-02f0-4c08-ec09-08dbdea5ad4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:52:16.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tco0jmtAQ4Ic2qE06sXrnQbrKkqN1Q+r5pjCwM9G6D/FsK68fjDhg4jb4j11BBoqMOzNbtfwceoTbMF6C0w2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4552
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/4 01:16, Cindy Lu wrote:
> Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
> then will use the Legacy iommu domain pathway
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   drivers/vhost/vdpa.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index dfaddd833364..0e2dba59e1ce 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1067,9 +1067,6 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>   		/* Legacy iommu domain pathway without IOMMUFD */
>   		r = iommu_map(v->domain, iova, pa, size,
>   			      perm_to_iommu_flags(perm), GFP_KERNEL);
> -	} else {
> -		r = iommu_map(v->domain, iova, pa, size,
> -			      perm_to_iommu_flags(perm), GFP_KERNEL);
>   	}
>   	if (r) {
>   		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
> @@ -1095,8 +1092,10 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>   	if (ops->set_map) {
>   		if (!v->in_batch)
>   			ops->set_map(vdpa, asid, iotlb);
> +	} else if (!vdpa->iommufd_ictx) {
> +		/* Legacy iommu domain pathway without IOMMUFD */
> +		iommu_unmap(v->domain, iova, size);
>   	}
> -
>   }
>   
>   static int vhost_vdpa_va_map(struct vhost_vdpa *v,
> @@ -1149,7 +1148,36 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
>   
>   	return ret;
>   }
> +#if 0
> +int vhost_pin_pages(struct vdpa_device *device, dma_addr_t iova, int npage,
> +		    int prot, struct page **pages)
> +{
> +	if (!pages || !npage)
> +		return -EINVAL;
> +	//if (!device->config->dma_unmap)
> +	//return -EINVAL;
> +
> +	if (0) { //device->iommufd_access) {
> +		int ret;
> +
> +		if (iova > ULONG_MAX)
> +			return -EINVAL;
>   
> +		ret = iommufd_access_pin_pages(
> +			device->iommufd_access, iova, npage * PAGE_SIZE, pages,
> +			(prot & IOMMU_WRITE) ? IOMMUFD_ACCESS_RW_WRITE : 0);
> +		if (ret) {
> +
> +			return ret;
> +		}
> +
> +		return npage;
> +	} else {
> +		return pin_user_pages(iova, npage, prot, pages);
> +	}
> +	return -EINVAL;
> +}
> +#endif

Is above code needed or not?

>   static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>   			     struct vhost_iotlb *iotlb,
>   			     u64 iova, u64 size, u64 uaddr, u32 perm)
> @@ -1418,9 +1446,13 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
>   	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
>   
>   	if (v->domain) {
> -		iommu_detach_device(v->domain, dma_dev);
> +		if (!vdpa->iommufd_ictx) {
> +			iommu_detach_device(v->domain, dma_dev);
> +		}
>   		iommu_domain_free(v->domain);
>   	}
> +	if (vdpa->iommufd_ictx)
> +		vdpa_iommufd_unbind(vdpa);
>   
>   	v->domain = NULL;
>   }
> @@ -1645,6 +1677,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>   	}
>   
>   	atomic_set(&v->opened, 0);
> +	atomic_set(&vdpa->iommufd_users, 0);
>   	v->minor = minor;
>   	v->vdpa = vdpa;
>   	v->nvqs = vdpa->nvqs;

-- 
Regards,
Yi Liu
