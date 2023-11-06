Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA17E1CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjKFIuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKFIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:50:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647CB83;
        Mon,  6 Nov 2023 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699260597; x=1730796597;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VwxidrLNw95qiWopw0iB1bF7W21VR78ojVDAWI1ZNuE=;
  b=Pw+01E6e7dtHiNrQtvwMp1+NMXb1FCsAJDzfsTXthZDAVxO2MSrXCzZl
   hvWEUgeZIz7C4mdmHMXFgG4vUqpzoC/W3KCX/nBSJZb9R4KBGXOvRi627
   mXnkCpHcriewE4kBznpGT7ouVjXMVQIjpGRD2U3NHyFaQtzYOOxZWqJB5
   jrJEp4A4I+PSGiwH0wub4wS8+qP89RRM/OdAtoIgoCakQNKRZK9rVJXs+
   qmoWmjGOnSGX1dN+/VI64XDCGfpdAsIzfSvrxUEM+fYNCPp1Swgmn4ADf
   4GGlp5jbDnHojT2y3hxPqmkHnMb8um8HpnRVb2t0qXYKnzqDzrejRb4Ob
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="455716224"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="455716224"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:49:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1009462818"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1009462818"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 00:49:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:49:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:49:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 00:49:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 00:49:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX306I0AagXk++cJ6tEwJnQnUjdmMGg8/ACxjX3eMzsQllrp+5HPSekhhd45A5zwg4chLQVG+Gu4XRO8BV/is0w1cyX8zIXLRB9Torw47cCKNmzCfEFpOgqijAhgx6J/SXIyM5RHZuO3JeH7C6wAs1lEDoFY7pBhNwPVu8cWFHm2QNUU22LcagiRpUCorzyZbNVIavhmfer0LNPoTDO5RO+XWexZuAwie/h2rYio11XAwabqAlOwkkJgmpRp0jwuu4x9zPLeO3AkDTDEPEATA5kDRvQGqz0xgDARD1s6cJGMiRJXusexBNXXMWGdT4FBjIwSapT79KQNlS2+RdYvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja311+lRznnJYLuTrjUWQhvIm8/y8wCSKt3jdZ923Tc=;
 b=ku72CHBpcrCMa9CDYacGivWJ7/N3rUeMT+nCrmGCTbQQoGusnZTSaKtITRaY+AjnK8kSSH/Q4Osve5AbBa0rc+tofN/dGvE1CWtr//yZlKzL0YZ2AmGssrjaYVUM7mQYBHAKU0Lm6s7AQ305JmhwFctbiSA2dY3808chL9cIVCOZ5g3ENwcGlG8n44tcJ12FxWhjWf23KXBwJdt4l29wdWBwGU7oycGIM/E4bB8xQzHBudj586BuCMCx3DE4+jRPAIXffsijx8OLuNyIAoPH9V1ySw+pdG66cZ1As6ZPaTDokNCs/3KfNFgSzeNchrQlCiFGmhmyga9PLajoU8ULsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:49:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Mon, 6 Nov 2023
 08:49:53 +0000
Message-ID: <c6e7a2b1-1c5f-42cb-8b2b-49118ea0aa0c@intel.com>
Date:   Mon, 6 Nov 2023 16:52:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 4/8] vdpa: Add new vdpa_config_ops to support iommufd
Content-Language: en-US
To:     Cindy Lu <lulu@redhat.com>, <jasowang@redhat.com>,
        <mst@redhat.com>, <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-5-lulu@redhat.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231103171641.1703146-5-lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 55997bb0-e7f5-472d-893a-08dbdea5583d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpYh090T9IXMdm7bQm4f31XCdP6uTx7D5MxLO3i7/7yZWB4WsRId9Jv3S6jL7Rg1FKC09j2XS6wb7ai7aA3RHC72a2BhO/z/ibiFje9L8jZ1TXcUn+Z0fHF28DrTyLFeLk3s6x1+KEroFVrzdoAR+ZnxK3bzg20b3bVMMuUu7nL3qRNdsxnjyG4aRjm0K9+brOrZLseQhRQ9f6GHVpnLUvdoA0KZDFjMbvAMZx/r/o29yAGSHMzzAvEWzzTYz2u7UZmRmH3gQTFoY5AG+B/cssy5rYGg9T1xRHWmVfas1RvrbLP4H2VCkiDLjWyw672beJObw8J5VoRmp+pmuaPqtwp0NZMrDqgvfl+RnB3GqfI0bjQ+trbWFP3JRQCNXmmK3vp1QEW8IS4a7wWia/T1jZZHfSqdI8WK19D4AxW1FtY0JVxmFUcqMtXrDUNqbiD8wD7d1LvlEThVS+2CwrwRJSI+GYzTGZHHUyOPdNoHwo6Vo+Pgu7c6iuJQo83gl/U/+pW4Jw9uR210JADqxksgrboJgsMBEKVjoxo4mMFjW51dzBfwZd2q69ZMLwo/getjovhO/IyIPcbOUd+M47GWnTyXUJub3g43JiiHercW0nI6rlO0Lv4J0XVf+yMs6eWYCJHkttDqMRSP5J0Q7kRmFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6666004)(6506007)(53546011)(83380400001)(31686004)(6512007)(82960400001)(2616005)(86362001)(41300700001)(2906002)(8936002)(36756003)(8676002)(31696002)(5660300002)(66476007)(66556008)(316002)(66946007)(26005)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFVRWkpzVVJPQ0ZLV2Q2ejVQMDAxRmozVUo0L2dIWkxtRCtET0krR1dSNmZ6?=
 =?utf-8?B?ZzI4MXlxSTRsVlEwQzJ3Q09OU250NVBkc0lzNmxUWVhlYWNBVnh0NDR4bnY2?=
 =?utf-8?B?eFZOUVBQbVNaQUxxZTBXbWhoYzRvRmtzTjEzdHp5Q0tvSWhlNmp2S3ZwNTZS?=
 =?utf-8?B?Y3hhMlNxc05ObDBzcHpiZ2JDaVdGdnJDNG1hU2VxM0JTU1B3aWNjVmZ3ZFpv?=
 =?utf-8?B?VnFpSFYxS0RkYUlLaGVtR2tLbzZNNTczZTJqekZTN2NmMzBuWUZoYVpBcVlB?=
 =?utf-8?B?M2x3OEJibjJBQkIwMW9yN29CMlU5Umc5ZkFFbkNRbGZwR0tNdmxaSEJmYW80?=
 =?utf-8?B?OHQxcXFxUVZtK0YxVHRWMFVFZUpnM1ErQTB6S3pBMHY5Wk5VNUNwOVRpYnZj?=
 =?utf-8?B?cy9rNTdDREdScmZvRFplYThvbktoSlMrcTFLblJGZExiZEJ4NUppaHVmVzdX?=
 =?utf-8?B?ZTloMGRnTDJZWWhvakNHUGhidVNnaFhLRUdVY08xZC9XZTJsRXhLRHhDWXda?=
 =?utf-8?B?aFliaHRaYUl4SFdTUW1yYXdLcHN6elZzd0FEbU9IbW1iK0NNdTlDUXNCYXdY?=
 =?utf-8?B?RHVZdGMzemx1VDJSeXl5cFMzeFlZQnhDVkR4NFFyMldYdGx2Ym0zNGloU04z?=
 =?utf-8?B?YmNEUTM2NFVoV1MzWW1xMVdacXRJeGdZSk9SYkRJdE13OHRMdXFnZkxOTGVw?=
 =?utf-8?B?WU01ZWlsVlN5d3VnUy9iSDdrdmwxMTNhbnhFcjEvemZ5M09JYTdyM3VRMWt2?=
 =?utf-8?B?cEYvK29SQTdVZ2xaZjJ6NHl2K1B3OFovYmxXdUpaSHB2ZTZYUzltVkdnLytP?=
 =?utf-8?B?a2JzbGtydTdtZ0FMK3lRbEVaOHFPL2pOdkY5WUI0YmJPSmhrZERJMEV5dU1n?=
 =?utf-8?B?RVdzRXhBUXo4OWNjNGlLTC9aS3kvdW9ZcTBrU25TK1JhY1BLckpnME92SGhM?=
 =?utf-8?B?dmszOGxUYi8yQU0wbUV0bmpKVXVwb2dySy9waGUwakRaZFR1Z1Zadzg5emdL?=
 =?utf-8?B?d0xuSTVZaVdkSUdYSE1Ib0xjeGZyRVBSVWVuWkxNL2IrZm1mc1RlOVF3RjhR?=
 =?utf-8?B?MVczbzJVcTRtR1BIR3Q0eVI2VEdzUTZHZE9VNnRUTmhBS1V6bjNGU015QWNO?=
 =?utf-8?B?dmRacTRuaVhmSTlMQi9ZTUdWd3R0eDBmdG91OWkzeWVJR1pLcjFzNFhYVEV4?=
 =?utf-8?B?aktqdDZBWHhERVo4UU9QMzZSVEFsU1hKbkJzK1EyUDNRajNuUlI4dUF1alUy?=
 =?utf-8?B?UUhyYVczazZkbmJ3ZFBuVTB1NjA3REQ2dzdQelBIRmpiRnh6MDVJWmQrT2Rp?=
 =?utf-8?B?QS8wQWpKK0lXUlVsaHRIV2hLaHNFR3BxeVA5WXd0Y1hjOXR3aE9XVW5YVE93?=
 =?utf-8?B?aXZvQlR4YjgyUUdIYmFKQWdpY3ZzUE9XcnNBKy96a3phNWg2eStZNHJ0a2xX?=
 =?utf-8?B?L2RJVWZHSWszb0ZINFUyck5UelhBaVBzdGpiYWZFZUVzb3UzelRWcjYvT3pk?=
 =?utf-8?B?dFZ5NDEwR2kyUTd1UEpNaFBDcWllVzNTMmMrZmlvQmhXbkxJT2dXWmpsdW9k?=
 =?utf-8?B?d3NHUzRPcXJjNmliSXh5Qk0zL0Nvc3hPUFNSL1pOVjliVVFTNXN2U3hpYmgx?=
 =?utf-8?B?RmlOeHlENWs4MG80ME1DTWJDY0JwS3FlNEtDNzlGTVdyc283bWZmazJ2eVdJ?=
 =?utf-8?B?RkN2OUE2b1doend2L2t5WGZSL2VRamhTME5XU3RhMkRpcUVremd4THdYSGZx?=
 =?utf-8?B?WHVEbS8wUDZrZjI2Ni9SQWVRbmtJcHFxRHptT1VMQVlIVlhGTVBEbzc3bG1Q?=
 =?utf-8?B?K245T0xaUURCYlBmd2tVV0FkNUsvdnFTd3k0M1FNQ3hTSTI1dEZ5SVdPQTAv?=
 =?utf-8?B?bldqTlY4ZzkrMzMxcjR5dmRNWU8wNlE0Q1hNd2JFTDZLaUJqRnRSZk1zTnUv?=
 =?utf-8?B?UDBhODI1QmY2RzRlRXQwSHJiTk9lSTVsVUVXMEFoQ1dGTlBuVytQa0JIOGtW?=
 =?utf-8?B?STk0UHNUMDVXT2VYUW5IY1BxYitmN01hMjNRd2JlYkFQR1BLemlaOVFUSWNx?=
 =?utf-8?B?K3l5eENDMUozeVk1ZmVXelBtYXJWamlDaTc1MnZWY0FkNkxWUXAxM252V0p2?=
 =?utf-8?Q?i2xsa32l8JkEOgpX/055F7Xq2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55997bb0-e7f5-472d-893a-08dbdea5583d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:49:53.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spsn8+AFOUW2u0Rqy0RdyD+NTBv4E0lIPDNWXIoiEAmm5XiTpTEoHM8wi3yx3qJabA8FWvJQYSU/kuVoZzK06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
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
> Add 4 new vdpa_config_ops function to support iommufd
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   include/linux/vdpa.h | 38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 0e652026b776..233d80f9d910 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -5,6 +5,7 @@
>   #include <linux/kernel.h>
>   #include <linux/device.h>
>   #include <linux/interrupt.h>
> +#include <linux/iommufd.h>
>   #include <linux/vhost_iotlb.h>
>   #include <linux/virtio_net.h>
>   #include <linux/if_ether.h>
> @@ -97,6 +98,12 @@ struct vdpa_device {
>   	struct vdpa_mgmt_dev *mdev;
>   	unsigned int ngroups;
>   	unsigned int nas;
> +	struct iommufd_access *iommufd_access;
> +	struct iommufd_device *iommufd_device;
> +	struct iommufd_ctx *iommufd_ictx;
> +	unsigned long *vq_bitmap;
> +	atomic_t iommufd_users;
> +	bool iommufd_attached;
>   };
>   
>   /**
> @@ -332,6 +339,17 @@ struct vdpa_map_file {
>    *				@vdev: vdpa device
>    * @free:			Free resources that belongs to vDPA (optional)
>    *				@vdev: vdpa device
> + * @bind_iommufd:              use vdpa_iommufd_physical_bind for an IOMMU
> + *                             backed device.
> + *                             otherwise use vdpa_iommufd_emulated_bind
> + * @unbind_iommufd:            use vdpa_iommufd_physical_unbind for an IOMMU
> + *                             backed device.
> + *                             otherwise, use vdpa_iommufd_emulated_unbind
> + * @attach_ioas:               use vdpa_iommufd_physical_attach_ioas for an
> + *                             IOMMU backed device.
> + * @detach_ioas:               Opposite of attach_ioas
> + * @free:			Free resources that belongs to vDPA (optional)
> + *				@vdev: vdpa device

duplicated kdoc.

>    */
>   struct vdpa_config_ops {
>   	/* Virtqueue ops */
> @@ -402,6 +420,13 @@ struct vdpa_config_ops {
>   
>   	/* Free device resources */
>   	void (*free)(struct vdpa_device *vdev);
> +	/* IOMMUFD ops */
> +	int (*bind_iommufd)(struct vdpa_device *vdev, struct iommufd_ctx *ictx,
> +			    u32 *out_device_id);
> +	void (*unbind_iommufd)(struct vdpa_device *vdev);
> +	int (*attach_ioas)(struct vdpa_device *vdev, u32 *pt_id);
> +	int (*detach_ioas)(struct vdpa_device *vdev);
> +
>   };
>   
>   struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> @@ -570,4 +595,15 @@ struct vdpa_mgmt_dev {
>   int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>   void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>   
> -#endif /* _LINUX_VDPA_H */
> +int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
> +			       struct iommufd_ctx *ictx, u32 *out_device_id);
> +void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa);
> +int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
> +int vdpa_iommufd_physical_detach_ioas(struct vdpa_device *vdpa);
> +int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
> +			       struct iommufd_ctx *ictx, u32 *out_device_id);
> +void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa);
> +int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
> +int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa);
> +
> +#endif

-- 
Regards,
Yi Liu
