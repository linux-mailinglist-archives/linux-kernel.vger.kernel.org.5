Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49204755EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGQIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGQIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:48:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22DB10E7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689583680; x=1721119680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=irlxAbN/9IiyH2WgYxz+yI536T0DNbCaKBm7hljl/P8=;
  b=MCYdRQ1cLadsIP5cCxmUQOJxombr7uK7/czRpyq8DTC/vazSZFKJ7/fJ
   UdIMFSl7vWtwFxKxda7aTw22hL/Bb5AF4k1ruW4GYsfnN/a9eHVHECcWQ
   ueQuunrPBdS5JwcBfKQuVLeQPT/f6sKg9pZUexPcBhkfp4jNpiwLj6gTt
   swzRLc6sbkF5Q6004vBtHj5ZpGAUIU2phxkmKQ9wWQMwVw4oOjI7BdTXs
   Qf6PoVgKv3QVMzRbBfEFRdNP+hYw1erViJQX4yQYzASI/x1n+EJmkhTOf
   UMYPPaxfOffoJ56BQk2xacjV7huJugN9iGzjv7aB4ZdAXKV+6fKZ672QE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="368521858"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368521858"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 01:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969801370"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969801370"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 01:48:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 01:47:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 01:47:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 01:47:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 01:47:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjGI9dk8nx7NxLiRUxnfz+75WBbyyQhSXppuKJyKycTadqifQoKdU2sVNNJ8A3PygDzPlKtuu7Dab8mgeatqjSbmd6t6sLEw5kHhhJMG8HwHZzL/jM1z8enG9NoP+sXt9fSf8dVAPCle+xjkFVZi5JtnlcendzEijRM0C/iRxo5QHG/HshZ/TbVkiezAGBKGTMoeFah7ZcngnzXSe/BkQVBU5UTLCG1kTtd8GgE/f7/4uPvds9ypymrTZh5SVpbZRVylHESiyvS4rGugLcZRGGkUviXdmpC0ECmh32VX6ZoiEsteeHPAUOrchwMbP2IH6t7GGMXWNx/6Umhv6woBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se9ilvbalvhiwwHuqcr3LwBVH+PdAEkXrGLDgOg8xvw=;
 b=i/ZkNXJysbuJZkKLeDAqhTwGIDbCeU24rXv9sQkbZmjnpidM1IWFPP+OFjbCIzNLdhGOx1zYAiiSI6+3s4gAb+bypIab5lFpOMXMGHDqeMbwFLrwCa5BVk0Hy6YLlWzyvT1AjzUa/+72a8MsDZnP5APrtSVVkEY9GrN/TgaRvj8I0NQRtxlPewpLs3iA2DpGX3itGH9L/eUIRz7tFQAzQDPKQO8RfCTr9hMw7j+z6c3SUvZOw8pEqjImtMayYe2B5Kn/ovZ7d07LQHYuGFNU81YvezOaSnUARPYdIc1cL34CZ/Ywd6Nm+mK3mqRaDeoEaxyfasmt41o252j10A//8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 08:47:57 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::1a30:fbe1:9dc6:4e1a]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::1a30:fbe1:9dc6:4e1a%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 08:47:57 +0000
Message-ID: <bef8be2b-2d37-b00f-42fb-40887aac27a1@intel.com>
Date:   Mon, 17 Jul 2023 16:47:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Content-Language: en-CA
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Kevin Tian" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-6-tina.zhang@intel.com>
From:   Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <20230707013441.365583-6-tina.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To DM6PR11MB4138.namprd11.prod.outlook.com
 (2603:10b6:5:19a::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f35736-49cf-4aa3-1b1e-08db86a28412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xm5PGPrypDteTD9m1HUOKgyZr7QxjiKexYRQrUzDw1g9mX1qT8HeblLS0brKIlRS25OPnKap5hdzJ238L5u+y+c0n1UpgZMnJKBnkQlBJZvI/FgjPS4GC+uIShPmuXZx+JdsRsJhBR0zGY7pQhqRDmG628xNs8faq3072gW/Tsw6Q5Wy+XcL09KJmKwke5QyCpaS07k3kV+8gKQi129xZdxryS+dHI6VlIUbU4COdkHFNGbrRVqISF5WhlBYOFbFQuQ7mOT6YP9pd3yhryldv74Mz1iP3G4bwZyzWkf3YzwHuMvtgXRrJfem97P6GfOa1AcS5mAMCtPal1lOe90QA8NiMc0r5D4X8IxozQ5Ti4mGa0rYvSuzVR3cYbYsPt3f7+oLSh+S2q7pfaWR44PY8Law5a5utpvISROUr8NGQL+Wh9POiyprzXC7UeoBZpy9ko6lrVd6Yfhrn4y7hSmMwKj+6D+C5r8TOQlFF02NKowWYhz8BUYw14tyFdASvOpJS4vyWZglEw6onNIuRrA8TV2rGuRhKf4kOrqZOE8xTC7H6clPSK5jqoDiHuu7Y1R9QR4cW7QhxdOJqnXUFR0CBaBYBW7lLmQgwYqQBBZVZa3QwGhNAPLBJVpG6BFaFwG65czCLW/Br+ozIOIHoJDB1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(478600001)(6666004)(6486002)(110136005)(186003)(6506007)(53546011)(36756003)(26005)(6512007)(316002)(2906002)(4744005)(41300700001)(44832011)(66556008)(4326008)(66476007)(66946007)(5660300002)(8676002)(8936002)(38100700002)(82960400001)(2616005)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU1EWVRvNytvSUNEWGZJTlhMbjlsL1djTXBsS3FTZ3RSRVVKRXYvTEtjYy9s?=
 =?utf-8?B?R0ljTjIxQTcrZDMzZ1A5ekIwZXVETnFHOW5BVy9WWm50LzZMakVia3J2TVNl?=
 =?utf-8?B?WFQxZm5BUE11T1h5UHYxTzBkR0Nwd2RYMC96RzhSN1M1ZnJkUEVoZHBIL1o0?=
 =?utf-8?B?UVlxOGZvMFdlMkxiMUFLeUpLR3d3eDBZcnpCbGd6QVZ0QjB1ZVptdHVJaXVH?=
 =?utf-8?B?TVVmblNPZ3VDWWJiN08vNHVTN2Z6RkVXT0Rha29mN0c4eXk2QWVuRXZvbTlj?=
 =?utf-8?B?U0RYZlRZTzJieWxkTXprNGE0ekxtUjRhOTV5WWRkOEVJTEM0Q3ozN2lYaEVW?=
 =?utf-8?B?VXk1VGR2enJvM2JEVk5uSG9VRlZqZU0yWndGOEZDNU00T2svN21BSVozY0Jt?=
 =?utf-8?B?V3pmb25JaC94aXRJWWdXR1kyM2pUVk96OVFXU1cvYkxtVWNEVWs4cHFHeStx?=
 =?utf-8?B?eW1TSWJXa3pHcXRLcWd6dTB5ZmtZVnEyWXpCQ0JrR01wVW5YUUx5Vnc1cE9i?=
 =?utf-8?B?SnFtdW1PZ3hab3EvRXNFY0gwaVdyWjBVVUxjK3JWK3QxSlRoL1k3VHBiby9D?=
 =?utf-8?B?MHRuSHpDaGJrSkFsS083MnZoVjVwSlk1VjFJYTFta3c1a05nVzB1c0RFZnpG?=
 =?utf-8?B?ZHZYUlVjMU83QTRrS3pDcGwveWV1TzgrRE9FQmlFTXpuNUZBYzlTNzh3QkdI?=
 =?utf-8?B?enRyQzkzTUFpUUw5Y3o5WGJaSTRNRVAvWlJIUFlUMGJ6K3U3VWRBTnl3RjRo?=
 =?utf-8?B?ZGNPc0V0MjRkSUQ3dTQ3c0dmWnRGMFpsZG5oT3pzSDZ1L1VjWjhScCtoSmRk?=
 =?utf-8?B?MWt0Q3BHRXRXc0dIZGJxTlE4VWEvY0FDbmdTdkRqV1lHMzUzUXNzb25FWkpk?=
 =?utf-8?B?RHc1TU13ZUw2MjZGSmJkdjhRM2RaRUNHVzU0aVlOZ3lDS0ZHcC9WZCtMelBa?=
 =?utf-8?B?SWVTNzNUZkVOcWY5ZmlCSWpiaWhxTGxsWkQ1LzNtRjFHTU1EbVNzN05BZ3hW?=
 =?utf-8?B?VUVsNDFKTlBsbDFIbDlBekk5YU80K1Y4V2VhOWVIM050MnVwZjVqYlMzMlRE?=
 =?utf-8?B?anhIbXpTMXVrV3c0RnpCTG5OaGtCVmVlYWM2MStHYkI5aDdYaU5BOEI5azNr?=
 =?utf-8?B?bHV6TjF0YnNnNnFKM1RITEoxdEFzQnZzcTZ4ZW00ZThNUU41VU9aSnRPS0dI?=
 =?utf-8?B?RG5UMFBZTjVZOFA3VUkyL0lvTDR0UzQwT0FITS9UQ3UwMFJsVmJUM0h0YVdv?=
 =?utf-8?B?dWZQSHpxWGkzMkswdms3QjEvSU1zeURVK25HcEM5dVVvWXZlZHJnU0ZNck1Q?=
 =?utf-8?B?QVdKdEtSTG9UZ2xmWFZRSUlmSXBhemI5OFh4MzQ4UDk3VEtnWEtyRWhVQXJN?=
 =?utf-8?B?RW5QcjVxZ3dBRElaam1NMXBkQ3pQWTh3MWcyRWMxeVBDQUs2a2w1bmFlNElv?=
 =?utf-8?B?Z2JCLzJSWXl6b1BpUUtvZUlkSTRleWlmQzcwY21FWnlhWk4rL0VFM3lCakNX?=
 =?utf-8?B?eTZXd0JyNTJZSFV4a09YTTRLelo0bzZFcmFlbGNIdUZFaXlwcUpKRTBqMUdO?=
 =?utf-8?B?NVJzY1BaUDMrMzE3bFhhYmZTVWs5R0JqZmRYYVJ1OSttQVVLamorU3J2dU1p?=
 =?utf-8?B?emtWL3g0UHkwZmtUOTNZYlpTcGd6bEhzc1dVS2UxTlVFYkhrYmJUdWl1NFVx?=
 =?utf-8?B?OFhtUmE3eEI5SDB2d1hXT0pFdnZ5OVM3cnEvL1A3NGpTNk9HakxwZmRDelc4?=
 =?utf-8?B?UjlzVkp2YXJEWFdrL1g4YW9ZTXFLWHdYOFdPMEVEVmN2S2FUMkk4MmdHSUJz?=
 =?utf-8?B?Z01VK3FQYmpiamlQV3VjL1k4L3IxaWxrcVBLSGEwMmhUSkpJWkZFYkhoZEd1?=
 =?utf-8?B?cTBtRXBObzRPbnZhT1R0aGg4Y1lxV0lpVWxqY21idEZlQlRVcCtnSTNtbXlM?=
 =?utf-8?B?TXdmd1JVeVhTcUtsTmEyOWl1NXpQcWs2dnJ5clBJNTZGbWg5NGRtM3lOalU5?=
 =?utf-8?B?dXh4dUltOXFyajFhVnpYc2xkbWtZcWpqaTdHbG5obVRYVzBCQUhKL1N2L2c2?=
 =?utf-8?B?NnZuWHZmSDhwY1YxWjdQeFhOYVhKL2FrRFlrSzdyWC84NVk3Y3AzU213eEx1?=
 =?utf-8?Q?5lYa39Wbj0xXwU4wO5UbSOCMx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f35736-49cf-4aa3-1b1e-08db86a28412
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:47:56.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8vFhBrFiJdhK3qhaTkcB7Cj8Yt/XNzMGyz8HDVYWbPkjwa87FUPOqXVTzJjbYuiPLiVerru9o6Pl4dm7eQb8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tina,

On 7/7/2023 9:34 AM, Tina Zhang wrote:
> @@ -33,9 +34,18 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>   		goto out;
>   	}
>   
> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +	if (!iommu_mm) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	mm->iommu_mm = iommu_mm;
> +
>   	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> -	if (ret < min)
> +	if (ret < min) {
> +		kfree(iommu_mm);
>   		goto out;

Once pasid allocation fails at this part, we should reassign the 
mm->iommu_mm back to default value, or it will keep a unavailable 
pointer, right?

Thanks,
Yanfei
> +	}
>   	mm_set_pasid(mm, ret);
>   	ret = 0;
>   out:
