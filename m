Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616747AA55C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjIUW4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjIUW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:56:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36F18B;
        Thu, 21 Sep 2023 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695336943; x=1726872943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WWmJu+ZyAo0weLdoEljMpGIaI6J1xFEz+4RQ/JEvEnU=;
  b=BCqbRqJWXkgiAxMUTN63Qu4Z+SQzrUti6yn9Sb52kMnV74Gc+eXwUlsM
   NMgskQrHsHdh4fZ5+tmfCNs3vXQ25kUU1MTxTXlID96wKzUwj8KPdycGJ
   WF9MLMf38TqWuuN8BX/mzGzvqNdjJ4uIWda0zf3ISMm7k29j53a/b9orz
   wvOERxH/WamUawsAkj0MmSCDG0H9pSZbI7LgK1699epx8LX87Mx6SB6tM
   Es/yAsMU0PsZFNbG7BMdBr7MYJzG6Aa9G0pcA/wgmjIRWabcoR5XkRSMd
   ixk05wQp/9efdHa8X/XozOBFTzB7/5KE/lwRyOwN3uwVmt75EbojWKMzy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383440429"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="383440429"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="920923040"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="920923040"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:55:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:55:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:55:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfNArkt+1VK9k3XvQAYoZYg9xGB45LcH8bnUIwBn4QXA2mFoqi1yYs+Rsaj/OLUMWB6qcM+eKJrisl1KS8wzKS/i/HfQs8hbBsnd5mrawrGoad15gspF5E9TKJ6p3VkwkaeChez4zons5KryuTf/NA3Inux2GvZy1SezfELovA4H0tIHzBSMnzIcVygQvPXVnF8ty91mYlyUDv8IS6wCon6ajgB1bzivPL/eYs4uXxrZbZFDUK3Zqk27+q2074LrkRT53GeRlXzRt/WKTgaQ5Y7hSbHTWf7ylLxcf5dkDKCYNzUsfaEAt8bDbyZuxj2BZ/qkss1KVshQ/WDR7RB0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlmEV2Sz55og9kC+2FqqfiCt/R/T6jXIsD+hZ/rsjLQ=;
 b=kktLtLoByjufx02AOJVrBFVYOVhQh6KYv4O8rTZyI+xiizGU8Yp3FZ61gibhun9a1DvRolME/mD5ziFGUL8HJo895hepjuf/4m4uSLZ0YU6DTRXepInEiqSlNh4gVryDnoi46lryfAA+p9S2NVBQPl/NVan3blsTiE7Q0337gIA0tRHNv2sQspzgnGrJAKMxMyINxMCSO6273Y2fhmhiQAPKEMussND/yQ5PqjtughceJ0UqVByzTgu/lS1dbBdgmgfxp2YTLMzaK+JMeTPkOLUpph0YORIf12uHhFAbXHSESKpLgVTjONQ5u1c/s0l8Bi/qwOWbsh2HZL/dwXKeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Thu, 21 Sep
 2023 22:55:39 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:55:39 +0000
Message-ID: <c0e2ec72-1b37-018e-5b5c-2d506b451db4@intel.com>
Date:   Thu, 21 Sep 2023 15:55:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 2/7] cxl/region: Fix a checkpatch warning
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <20230921025110.3717583-1-jtp.park@samsung.com>
 <CGME20230921024831epcas2p36f222c434f41ce80ac2850374868da9a@epcas2p3.samsung.com>
 <20230921025110.3717583-3-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230921025110.3717583-3-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: b610a55a-05ac-4bf9-e15c-08dbbaf5dff0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrRTvLFK9gUPuIBoOwuRk6UejdCS76bRhUtLhacZF5PtSRNxSEFplBuzrHYa4FeF0jy3H3N3xFBhuQtF5Mk5zoBMJiTB9By9JzpjgRgj60mapU+pCRbrTgpaGUUzyPIFjwWxB25iDylfSQwaHjbWLiIDZXuQYW948c5QKQLRZe81qEYEnexv5I2L45ik5Qrn9AJhYLAkNdC0rCzrIEcWLUzsBElPH1D7zOriw1bDQYchav2VsJaJRj1Q7rNoO61sSuzMqgND2Y8LADglz2FQrD3EXtngrnjqB3W9KCAoNbqBxptGq0wvyShJQIPNW/5gfu5gnUIsntFpm+KI3QO1QY85vW872IKYPRTPJI9wvY5pGLtG0hsXzKGOeEXKe44Ib8npt0zj9soSZfGCpR3Y3Q7v2+fpr0A/1MWynSyWEg+dTMZzFvxlS6ci0GXfN/+fE/mVHST6Q4VX0Yf2awzMMb4X1yRjTtCOESmYqp0Lef6/cS5QrM/kTnsKoK8tGa7YvjOzpYemmbGt8URi2YRartkGR/uQjJr6jqhYFmlZ+S10PGbGQ0/ahYa3qLsJ08o3h7xzp595GbnXTrnhowov/X8GLPP4c3lsq1ZSpa0fCix1KorsOqcrvV3MAXX7Mvh0Fb0IP1jVLbfO1+Witm0rQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(1800799009)(451199024)(186009)(31686004)(6506007)(6486002)(6666004)(53546011)(5660300002)(31696002)(36756003)(38100700002)(86362001)(2906002)(41300700001)(8936002)(316002)(83380400001)(478600001)(6512007)(8676002)(66476007)(4326008)(110136005)(2616005)(7416002)(82960400001)(26005)(44832011)(66556008)(54906003)(4744005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZlMit2QXBRajZ0SStEVy9lSkVMSFhaaEVOUE9ueVZsQVdwVGl5b0N0ZkVq?=
 =?utf-8?B?L29Wdk1BcHI1b1k4T0V6QWx1bkZ3T1FCeDFCUjg1TGNpR0lwZGJjUDFGSUV1?=
 =?utf-8?B?aEhQaEQ1dFEySTY2eGdhTjVjSmNWUm1iMVo1UXFadVJ1d1g2eGEwSkdCMDRo?=
 =?utf-8?B?d2hKcW02R3VjNTlpWFBWcmVsNkFuQXY2SjZBMW1MRmpTSzBqQ2NGNHNXeHBr?=
 =?utf-8?B?WUwyeFNNN3J6aEtKQmJrT0VmT1lzUC9va3Awb0V3MXZJZGVXZm9VUjRIUEVi?=
 =?utf-8?B?QldqUGUrSHNMckZQZjBWTDlKTVlPdGM2MnFsSFhlQ0ptRW9Ob0JUa1Fmc1FO?=
 =?utf-8?B?NHJHZ2ZpYnFGNXY4OXBSQkNxeWhtUTVoT0YxY0pvTXlQYVJuNGI5TlV1S29F?=
 =?utf-8?B?VWNwVThyR3l4RzRUWEZXd0RXZEFkci9oYWNyN1FxeTNDazNaa25XL1RCaVJO?=
 =?utf-8?B?NUlmYWt3Vlh2UVlpOG4wNEVJdmdtejlFVFhia1J6Q1hhU01GZExzZ3BKRlNh?=
 =?utf-8?B?cklzQmdTQzVqWTFuY3Z5SktaanhSeWNqbE5kNHoyQWJVV2h5VDEzSjFKYzFU?=
 =?utf-8?B?VW1tVll4cUpUV1FhNVRpOWJMNHp4VWZ5Nml1RnFIK0VmVVhQTGdWU1VEWXgv?=
 =?utf-8?B?QzhBRTZCeWxVWmRtYVJST1czNis2S1Z0RUZZd3Q0YXE5dU1lYUI4TTlRUGxB?=
 =?utf-8?B?c3Jpa09VUkh5TU00alR2a3FyWnFqZ1pWNXhIWFFzWmkrL0pQWk1hZ0RJOG1t?=
 =?utf-8?B?cmZxRWpaUTQyNldWRndhdm4zS2EzRHVEdUhJdTkxZG9sYlhSV01NYS9pK1dJ?=
 =?utf-8?B?Q2toM3lhd3FOUXN3UzNNZm43MXZzYVBvR2N1a0JkM3Zjb0NyaXNwdi9pZTla?=
 =?utf-8?B?eldJZmY1UDgzMmhVODZnYk5CK0lLbW93NElQK1Q0UjNZSTE3cmRWTnNzanc5?=
 =?utf-8?B?d2dpTFpDdk9NL3NqT1pwWUhVOXdLb3dQMnoxWGtZK29aOUdJYjJwWmNvVlgw?=
 =?utf-8?B?TzBNTWYyZzVydGdiU2xiSzFIKzZKWmNUeGRTQW55L0EvNW5FNHFldVRreUx4?=
 =?utf-8?B?QVNaUmxzTUxTMTJWbVhtbDIzYzJKUFM5YjZmV2YzSHRlRDJtN0JrYzZ2cDBh?=
 =?utf-8?B?cmRLTVp0d3RlS0ZOVWp5Nk9Ubzk4WFp6SUV0NStaQjY2VGVsOTNGV05ucXFF?=
 =?utf-8?B?V2RHMXl4QzJmQjlxdGxpd2t6Ky9uWlpDODRxbEtFTk5zQ0J6cVQ1RlRGN0tO?=
 =?utf-8?B?aVg5TkcxZTVsNGRRWVdzaCtNVXE5WXB1ZWUvOHdGR2lhanlHd2x5WmpPUjVr?=
 =?utf-8?B?YzlyYlV0SFAwV1RyUFJjRnFzOUp2Mnh2dkdUM2xBTzA5ZW1QZG4zelpaZnZH?=
 =?utf-8?B?ZFNLSXJEMHpJWE1PajRYUkRCNkZZZzBGaEd4dVlWSWErdDh5WEh3Q0lBY0E4?=
 =?utf-8?B?dzk0RmxyU2Vkc3hKRDc1dTdGcTBPV1lHQlpncVorSVAwbHlJcklKUzJXRUEy?=
 =?utf-8?B?dVlJTlNvdHMvZ3NZYmtFRFE3TzhObUJGSkdXaEcxalFyeldRd3FOS0hLSVRF?=
 =?utf-8?B?dmhQSks2bWdmZjFpM1BzTGRML1lWZGNlcVBnM3EzNTRJajR6aVptdVFyaHRD?=
 =?utf-8?B?SVhuL0tJMXc1NWJ0dU9TVjk0cHo2OUNFMm4rSG90ZlNhRDI1U29WcDYyYWh5?=
 =?utf-8?B?MllIWUR1UHZXc0I1YXlkeGwyRmcxQUdtWmhlYkRDTThvU1VjcjBBTkE3SVU1?=
 =?utf-8?B?VDZpMldScUVaTTh6anlaNS9NZVlIK0xzWEZNdmxOQnBNcDBqd3NSc1MxZE1z?=
 =?utf-8?B?K3Z2RGd0RENqakpieklOMUthcGJHREdDZjQ3SE5MaDJrcEoxWm8ya21UZW9q?=
 =?utf-8?B?NGJxdjBVS3ZzSk9rQWp1dGliMEtMOGp4S3diT0dqL1VSTGZnU25MZnc0QjVH?=
 =?utf-8?B?eXppOStOSFpSdWdmemw3OVBVRDFEQWZtWFp4aDFkY1NtVzVJdUtWZUlvRW1l?=
 =?utf-8?B?aFdJeUVYekU1dG1sdDRSWld3Q3RBa1JURjhlODRTMHl0eE1rYnhMOXZzRGh2?=
 =?utf-8?B?YXoxRDFwUG9FSW44T0xIdHFrYTF0NlhiQzg0N0xpY0RWaS9Kam9qYm1IcjUr?=
 =?utf-8?Q?Q7go4IZgRl+kDfhGUleJFM6Q3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b610a55a-05ac-4bf9-e15c-08dbbaf5dff0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:55:39.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL3OeKdPgGUSmUuCPoMPOZhYCJ7skpzQyOt2yw6CluLjxlfJ/cHpzS47S+6n+/bgBQgzfZpCi+pVN9tLe2QM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
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



On 9/20/23 19:51, Jeongtae Park wrote:
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..1fc9d01c1ac0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -133,11 +133,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  				&cxlr->dev,
>  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>  			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
>  		}
> +
> +		dev_err(&cxlr->dev, "Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
>  	}
>  
>  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
