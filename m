Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A257CBE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjJQIvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjJQIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:51:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3203B0;
        Tue, 17 Oct 2023 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697532690; x=1729068690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EWh17th5uhdjwY0NUw5hxPyLhuB4dS8SHu/yeqU85FI=;
  b=U0ZSgHt3f2ALxSKpOn5CxtnvTMTHHhn1rnplvf4ECfp0YcIcHRAq/EDI
   1jYrNFKu3X3fTsY9ChBuY4ucGIdE5a86l5b1RiIv3VilVvFjQOnmW42l1
   gFOxvEb8dlLsnlHSC3FBjfx4jZyA6/TJgm5RCyZ88nkQfKheDkNziI1+V
   26fJfQB4RtGtyUqgkDFhudkFv2U9PP0JDbTvRawQbKCfN+P+OnWhNISM5
   d1L4OdNVkuyvtokkaM0838WLGAxUN59KcSoz+xP82bqoXZeZneYjV183+
   yva6wBoUAWSowifBkwQ+WCIe4CZkD61NnGLTPnkRw/wCQE+zIrL1LwMxS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="382954531"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="382954531"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087420938"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087420938"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 01:51:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:51:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:51:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 01:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1dgGOslNCPg7Gze8tyeIRZ1Y7cRrg4y5KjAjN6v+R6sYIxbYejZs7bhg5I05bsta0AbdfHC25jZ6Zsk9Ynvfo/eDGztytc9s4w/CBlR7O+pVRaY/m9s9ttN2FuF+gH4URSMlqrOjiFITpaG0Xmg7fyJFhBwWOQd71CinmmQjNBuPd4ETG0bk+a4G/IUPEnidJ/b2xl8TSrpN9Eii0v+nh+vrgYuZE+X0EBy5LZ0iRg9Smvg6Fv+f5cwtkg+N9aaqZxtxs6X93v3tZAYrIcU5Td3tNn/MCdDzXmmURm/8pb8FzvV4Q34bDbwem4OdFeQKqNQS1buzVgduoHVPXoGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smPykctM+dEu1Nm2ZuKjIq1Gcq1ojhsp1AgSn6grpiM=;
 b=OpzUVv0S5lcIVRI+TIchQ6ybIVSwOBPXSc1BqNNiiygtTMTu6Q7QkrP0BuqzfRibumhmP4phGyOZqKlHArme81RGE2AvO4FPrrvJLYyncL1nBzmFuueRDPnZmC6/+Rms9w98DUrYMMMra8rJANcBULfPiRJi44+wfQz2OJY+OdOfXhTB4kvRjjwJqegaYNE+52HKIiIgZd6PZhzqe7ZUuNLlEFgih03S2pbRnaXR0QQnNHGqrkwwtqKGHjKwB3rZittek1DxufC2Vp4bxvjGVbt3BjHob4Kt0O+dTORYUlH8DWbza7et86MFWdeTftqqAM1wFG/po1JSoQvR2kFgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 08:51:11 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:51:11 +0000
Message-ID: <e651d5e5-50a9-4884-8263-ce9d0d705b52@intel.com>
Date:   Tue, 17 Oct 2023 10:51:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ACPI: NFIT: Replace acpi_driver with
 platform_driver
Content-Language: en-US
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-6-michal.wilczynski@intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20231006173055.2938160-6-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: a34f9224-1a5a-4d19-57f9-08dbceee35ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTHpW6QReO1J66jRZFbw+18mkCu5Iu0wxRWh2KTQzhRxtUsPxw/WOJQ2UOCtYVV8HDQu/DogGO/VrfagwojZqaWf0g5u0UaYmhqMnB+8xN1WrnGgfuROWuCT6/+EvZlHtSgfSEkfOgmLaEGKazOh1pcwIbHCRgpv7IPH3gwxYI2wecQu2f+sof9Imm5V/mvP1JtPWw2hiz0xyvcZetAYLd4gUqMwC+hxeKsQXc253RGjwiVPMoPy5Y3xsU4qlSkHX+kmfI0+VcPBcbBRd8MSNqP7tWvUUVjy/CwyjaBcH/No4agEmOoFX5WdaN9aLoWBbk9kR1dC3GluOBHqrMnrPDAGdMrQgZ4Ix36mOkg6gi1TFjy/btcVr+8hEiOMaNNQmmTIwEhaBlhekOn4m2ic47z9RgeIligpG8Ug1fRJWu38FXQqWbPMh0aqLU+ETWgeqJHRjfH/I8gOvNhrNHZspcvuisf8NN/nHZDthaTTYluRXSKZ+y2WtsJPhiBYPi1/Y2iAv/TMZVSYewyydjbzYfDq+L+PDFAsN1yJHkSk5LsGqgbY2nfYovR230PfiFMdRg5AuBRJCPvDGR2EXg3xDlPbm0QbZXjqHhif05cA2WK5RhHZTox8ByUn2NpkXS3WfUa0ajzdsQuVC5dVHrp9VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(31686004)(38100700002)(66476007)(37006003)(4326008)(8676002)(8936002)(316002)(6636002)(66946007)(66556008)(6862004)(41300700001)(5660300002)(478600001)(31696002)(2906002)(6666004)(86362001)(6506007)(6486002)(53546011)(36756003)(107886003)(2616005)(82960400001)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BZTTA3WUtZMjlJRTNYa2RnemgzSkIvQTdxSmx1RHNiN205c2JleXJKSCtJ?=
 =?utf-8?B?MUMrcGxRdit2VDhVOU13WXdZY3Y1Skw0N3ZIc0tieGhZVHVHck9KQ0p3QVZO?=
 =?utf-8?B?aDh3bkVqc2h0NnFPazNqMlVKQjBXRCtKOTVma0NMUUIyS1FmNFRTaTBBTGd0?=
 =?utf-8?B?dndMQXBObnoxaFBra2s3QWIxTEJyemFsNW5XZWdEOCtOMFZVdHFCbDh2YWlp?=
 =?utf-8?B?T09rVHJXVlZiR0FtZHpaeSsvK2R4TWk1bHZpMWk0T1lnUzRkQmQwMkwrcWhv?=
 =?utf-8?B?UVZ1bjUxWEJkRXZYWnhsbjA3bnVsWUVLdmVMaDFmQmNjck5rRUxPckhZQXBM?=
 =?utf-8?B?Z1YxVWdwZm1pSHJYY0k1ZlRwUDFac1BSTnpEVUFwUXZVTEdxeEtjem84bHBH?=
 =?utf-8?B?c0lBYVlMelR3MFA5dXhtMjVScFVxMlBXQ1h2bW5wWnFwU3VmZFE5bkY0Z1pv?=
 =?utf-8?B?TnRLSnRNQVpCMGNRYlYxUWlvYlZ0UEdlRGxjRTJuNGhQbUJaaE1ML1h1TnNR?=
 =?utf-8?B?Q3VCeDd5a2Y4K0U5cWxLcjNmak9PZ0wzd2ZKWGxlMy9TWU81M2haR3RjYzBB?=
 =?utf-8?B?eXF6RklMdEJaN1piNWtJTlRLMEM3ZzNZeGVIWTlyNHBsMTkydk8yZmdQVmgw?=
 =?utf-8?B?NUFUSVl0ZlQwcmxzUzllNnZOditmbUw2ZlhoYU9DQVhwanVvbkM3UXdDSjVT?=
 =?utf-8?B?RHVSbzdpL3dYcCtBaGtWd3RuNmZVcVdEdU1ibTEweU9Ba1pLZ1JaVUJRODhx?=
 =?utf-8?B?WjVrQmlianpzenZQZVBLVW9md2NTRmNkZkxRZmVGdWpaY0FDa0FlWHJCanI3?=
 =?utf-8?B?ZEhZdCtWM1BhYXY4dnMyVGlLMDFZSEVFV0FneEZaK2ExOUZaVDR5bCthQWFn?=
 =?utf-8?B?V2xsbWVNdi96ZDhNREZtajlBRlQ1VUxTWU9LdVFrbW5IQW9LcUE2NWhXeUlB?=
 =?utf-8?B?YmxWLzQvTzV5UXc2aU9FNlo4QjlVWXl1L1NubkYvTDJxa04wVityMjFudHcr?=
 =?utf-8?B?Ym5KMUd0dHlVR2NaYTdOSU83dG5zVnRZQ1h3Tm4yTmxIUUlZTmg4VGVCUlg2?=
 =?utf-8?B?VUVCdk9NWTNGUms1amF6N2VTUitIeWJKT083UHdybjNIT0x1eWJDZjErNERE?=
 =?utf-8?B?Uzl6amxiNFJadDZTbVF4bHpSbTd4Vkc1S0QxRkt4M05pOVJ4dDI2K0FSZnk2?=
 =?utf-8?B?QSs3MXk1MG9aRzg3Rld3UkRRNE1UbjRrcXBaZGJ0ZlI4cTVjWlNBbTFxRkV2?=
 =?utf-8?B?MnN4UlpJT0lSOEEyMllaczRkUlpZaVNON3d5Sm1hcTl6d2g0M05oWmhTM3V1?=
 =?utf-8?B?Mkh1bkROTHA4Vm1LNWxHL2J0cUdSYTNjZnRTdksvVmYrZTc1USszNkE0cGwr?=
 =?utf-8?B?Ukw2RnlOcFQ5ZkVVdjdSSWJQTEN0emE2VVgxSFB3c0d4eXptdHdHRk5QdzFz?=
 =?utf-8?B?MHlPOWE4cEhTS3NDOGErWFhOLy9ZRFFJbTBZc1VJL0dYWHJVcmxzS2RFNXU1?=
 =?utf-8?B?VXhwSS9GQXNNa1pLMnhZS1ZwbnBRRERtVTBoTExPVHZxVXcxR2VYVjNVZWZE?=
 =?utf-8?B?Z1VLSkZhamFYc0ZObzlvb0NkV0s4ZWIzNkpiM3pockZZUEJ2UWRYYlZRb2cz?=
 =?utf-8?B?NW1oWXFicy9SMGZaVndMeXdKSzlNUHZEL01YWVpoSFpUNytyWFlOZnJNSTJZ?=
 =?utf-8?B?Zm5wQW80V3VvM0RaRC9zNlhSTCtDdG5rdFRZaHBCZlozcnlOTTZnQWVITnJy?=
 =?utf-8?B?WWxLU29nQllJamtHMjVLTmk0MG0zcCtWU01Pb1czYU5STm5SdDV2UUp3NTFB?=
 =?utf-8?B?U3RqcjVROU5YN1NSQnE5Mkpsd1hXMXBnTktHUzZQaFRSUCtqOFhudlh6UmNE?=
 =?utf-8?B?V2ZpeTdCV01QL1hzVjJRSU42Mkxvd0xCOHVQMXA4Qm0xVWR6T1o1T0J4VFR1?=
 =?utf-8?B?dy9yMldnSHhSZ0ZrUnh6Uk9jQ2NHdFhoU2QwYlEyZktybVpreFZGaTZRNURy?=
 =?utf-8?B?bnp6ZDUzSmVNQ1JCemNtc0M5V0xKaDNUR3JlN3hNRnpMY1h5UkdRTFlPbEtZ?=
 =?utf-8?B?ZzZNZFpqWEY3bUNUQXZmZEpHSGszOGZJckVZY0pKT3hNd2dqaC85YnN6Zlgw?=
 =?utf-8?B?elF6bTgxSVNyb015RXdRNjU1aExPaEhHQjFCRCtTam8zOEpCakkyRVhLZGlQ?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a34f9224-1a5a-4d19-57f9-08dbceee35ad
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:51:10.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qH99j2yGghrSBVQloffheQDPXiF/H9LSMHLNKwpNdkd4GbdTuqe6eLFZTB3I3JAQfbkWe0AznONjm5lkJGFROBsuMy+uCNiFEK0xqkVqGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/2023 7:30 PM, Michal Wilczynski wrote:
> NFIT driver uses struct acpi_driver incorrectly to register itself.
> This is wrong as the instances of the ACPI devices are not meant
> to be literal devices, they're supposed to describe ACPI entry of a
> particular device.
>
> Use platform_driver instead of acpi_driver. In relevant places call
> platform devices instances pdev to make a distinction with ACPI
> devices instances.
>
> NFIT driver uses devm_*() family of functions extensively. This change
> has no impact on correct functioning of the whole devm_*() family of
> functions, since the lifecycle of the device stays the same. It is still
> being created during the enumeration, and destroyed on platform device
> removal.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>

Hi Dan,
Rafael already reviewed this patch series and merged patches
that he likes. We're waiting on your input regarding two NFIT
commits in this series.

Thanks a lot !
Michał

> ---
>  drivers/acpi/nfit/core.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 942b84d94078..fb0bc16fa186 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/sort.h>
>  #include <linux/io.h>
>  #include <linux/nd.h>
> +#include <linux/platform_device.h>
>  #include <asm/cacheflush.h>
>  #include <acpi/nfit.h>
>  #include "intel.h"
> @@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
>  			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
>  		return NULL;
>  
> -	return to_acpi_device(acpi_desc->dev);
> +	return ACPI_COMPANION(acpi_desc->dev);
>  }
>  
>  static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
> @@ -3284,11 +3285,11 @@ static void acpi_nfit_put_table(void *table)
>  
>  static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct acpi_device *adev = data;
> +	struct device *dev = data;
>  
> -	device_lock(&adev->dev);
> -	__acpi_nfit_notify(&adev->dev, handle, event);
> -	device_unlock(&adev->dev);
> +	device_lock(dev);
> +	__acpi_nfit_notify(dev, handle, event);
> +	device_unlock(dev);
>  }
>  
>  static void acpi_nfit_remove_notify_handler(void *data)
> @@ -3329,11 +3330,12 @@ void acpi_nfit_shutdown(void *data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>  
> -static int acpi_nfit_add(struct acpi_device *adev)
> +static int acpi_nfit_probe(struct platform_device *pdev)
>  {
>  	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct acpi_nfit_desc *acpi_desc;
> -	struct device *dev = &adev->dev;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	struct acpi_table_header *tbl;
>  	acpi_status status = AE_OK;
>  	acpi_size sz;
> @@ -3360,7 +3362,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
>  	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
>  	if (!acpi_desc)
>  		return -ENOMEM;
> -	acpi_nfit_desc_init(acpi_desc, &adev->dev);
> +	acpi_nfit_desc_init(acpi_desc, dev);
>  
>  	/* Save the acpi header for exporting the revision via sysfs */
>  	acpi_desc->acpi_header = *tbl;
> @@ -3391,7 +3393,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
>  		return rc;
>  
>  	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> -					     acpi_nfit_notify, adev);
> +					     acpi_nfit_notify, dev);
>  	if (rc)
>  		return rc;
>  
> @@ -3475,11 +3477,11 @@ static const struct acpi_device_id acpi_nfit_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
>  
> -static struct acpi_driver acpi_nfit_driver = {
> -	.name = KBUILD_MODNAME,
> -	.ids = acpi_nfit_ids,
> -	.ops = {
> -		.add = acpi_nfit_add,
> +static struct platform_driver acpi_nfit_driver = {
> +	.probe = acpi_nfit_probe,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.acpi_match_table = acpi_nfit_ids,
>  	},
>  };
>  
> @@ -3517,7 +3519,7 @@ static __init int nfit_init(void)
>  		return -ENOMEM;
>  
>  	nfit_mce_register();
> -	ret = acpi_bus_register_driver(&acpi_nfit_driver);
> +	ret = platform_driver_register(&acpi_nfit_driver);
>  	if (ret) {
>  		nfit_mce_unregister();
>  		destroy_workqueue(nfit_wq);
> @@ -3530,7 +3532,7 @@ static __init int nfit_init(void)
>  static __exit void nfit_exit(void)
>  {
>  	nfit_mce_unregister();
> -	acpi_bus_unregister_driver(&acpi_nfit_driver);
> +	platform_driver_unregister(&acpi_nfit_driver);
>  	destroy_workqueue(nfit_wq);
>  	WARN_ON(!list_empty(&acpi_descs));
>  }

