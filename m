Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27379ED33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjIMPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjIMPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:35:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DEE54;
        Wed, 13 Sep 2023 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694619341; x=1726155341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LvFVhNMcYdaJyUaVskoAFkiylnlAKJttH3LeeMgKf2k=;
  b=WJ5C46m/3d5O9vduvRcwNKBxo9I9czIO2FJfULUPxexXgTt7jx2IHbad
   Tt5KdBJRIhvz/1LhOIcCkM99jfCBbgqOTNeorhTIheYf5LkdlPLQW/CKR
   KwhHLGHi760KgZnVm3CYVTJEoEq/80plOPZ13uC71BBKq0I7rAwndaton
   l0TD6Vtkje/HU7zFAtTm+h/fXVPykf3RRr+RVgEbzkzjfbs0psEueEIUh
   izgxfjS7HYeRw63RKXyR38HcY+ZYN1D+Eyp5Mxh2lYXA0Hc95pQeSL9ZE
   II282hq8lyGkl7UatTe32PVIjcaWFWyjZ9stMj7uqN2ULeocgarGvXVOL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="376028692"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="376028692"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="867851087"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="867851087"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:35:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:35:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:35:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLv5qwfy8vFbohNy03EppPyuUAezZOgJaqIB6RACkYFasC1tuSgB+9s14MKW5yq6FLzT/0JREJ+gvoebt8gkHAk5XDpmB7JHk2TmlApWSsH9C/B9R2m4B3ngnD9zm6nsggc8+wDLZsTf50+bnnHbowSezBVSxlPtG39WOdzfM2KSRWFL3rd02z3bRcRCPjVMpBUkAIsqp3Huwi8gDahkHHUNm2cuIzBktUnGGBZp5oyE4oTAbXb4b4L/CYqwTAD+wQTeNZGe7imJsQbRHPViMDMyicmJKVg5YJEnZuBiHQxuADBGL/aZbXXW1BskBq+DzVASn0YsFwKpdybIxDsEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10mg/+gu0eOgRx94L/WTtQUSfjBZth0KGe6iPq0cRps=;
 b=keZWkHZzTcxmFDrVV+cHnZV8hmCKDWMyVe4vwrIm/DQT2SzGesNbmhQuxLBNFId8IUw2nD4DkY//E1rOX6RS4u4aLYgve+OVhzpuADzhdSDJA3wQnLAxVhN84X2zUZlb+hJ2o02lcwQpxwkGnUiO/J5WqOFLiLPh0x9kWDe0LNkjffzdTCKP16XH97zLR5idkiDSliK4Cd0bXeuRvGhTi58tg0WB0NtMH8BlOS3OEqycUg0vn1tPG8Y/g6LzpNM505I8CsLc+aIupwM44xJBZn7xcCrPUSQdlaXPjK0BcZ/V9mn6jxx+9o4e8Ec5O4dbYzqhcgGjac+I8nomEpkHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 15:35:12 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:35:12 +0000
Message-ID: <b9260a50-7b60-4a2a-4e8c-61ec4401576b@intel.com>
Date:   Wed, 13 Sep 2023 08:35:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dax: refactor deprecated strncpy
To:     Justin Stitt <justinstitt@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20230913-strncpy-drivers-dax-bus-c-v1-1-bee91f20825b@google.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230913-strncpy-drivers-dax-bus-c-v1-1-bee91f20825b@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MN0PR11MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1477c4-bc63-4447-39a2-08dbb46f04f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUIdkg3E8z5EtmCal0/QsskQf7pWitl9QoBBhJVVlxsHeaUZDXY9renO9hjzTw/4Wzv4+OqPeRu4pO2Blb7kMHpYZsSDQHD6AgS2AruZtdvEB6PAuFZHyU7nz3GYvQaijNHD7oyl/IxGLejt9utOVR3vUw0D2oGuACJplBRksdR7q8EsTOqQ1B5tzDBJkU5rMd//xOB9uoKbL6ziuaCsVnMesMy9A6LfiIR+4pfrhaQkxSXsUa/ygbRbNLn76WZumSp1Kj5UvvZeQf0JJ5aVob5wUuK5A3bpy4JFhi/TMQAFrpBTDVV3bBOVvE9snTo+k4n1oYQClWEx4fTcAkr8kz0oS4L/9oXvZqnw3zzYNDj86fZTTE1w5NzIZLCkVHQCqtvj45kMPIe98APWlQC80lJBzMUjKdfxKgKqd4dZNCWvVFbMpnCMyTNuuM/wxG56IBYcGE1L64QgO0JfhBP0Zx9Amwzd7voXEu4wTjdNZI78uF+hvIhIEErAb0bGbFBeI6DXPgIWVNKZM4RORO0xnh/Ro1/PQpdvq1qziIzr/ucQ6idrVgy47fN+BZPmscjwc0ChKg5YV89uZS0bnsyq31Y6V+eyRFT5pMc+R0lnFVkaH4+gF9NHRKe+tGdZHIuCYBHoJKLkVD6ynj49/TlSCv5rtks2YuwiI0nl7zpCPhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(1800799009)(186009)(451199024)(110136005)(86362001)(31696002)(2906002)(83380400001)(6666004)(2616005)(53546011)(6506007)(6512007)(82960400001)(38100700002)(966005)(6486002)(36756003)(26005)(478600001)(5660300002)(31686004)(8676002)(6636002)(66476007)(316002)(66556008)(44832011)(4326008)(66946007)(8936002)(41300700001)(156123004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGwzdVR1SlJLMm91WFVjQVk1NkZ3eDM0REdsRGZZRUsxR3BmUWpRSDU4dGF5?=
 =?utf-8?B?ZS9pTUlXb2ZNcm5IZGFMYnZobHVWWnRNNUVJeTFQY0RIaVRyV25DSmJQQlkw?=
 =?utf-8?B?VHRZSWE1ZlpVRmFsYmNzUW5RV1I5TjBxdldFZGhPN1hxMW1YTXltaml5N1Js?=
 =?utf-8?B?dERZOWRhQS9HUGhhaWd2ZE5uMWQ4U0gxT3dGcGFuZmRuVldWU05nYjgrVm9V?=
 =?utf-8?B?d1dFVDBtOENtb3NucG4waWo3ZWtuM2JabDJsRG80YlMwSk1Qb3lRbHpwdkgr?=
 =?utf-8?B?M1RWM1drZE8rR0c5VFhaQWNmMUJNbTdsN21xYU5ib3hNNEJHSitGQmF1S2hs?=
 =?utf-8?B?WHRRQS9CT08zdWhtSTFheThFWW42VXhSZlpiZjVLaUhnclJSYzF3aEFJeHk5?=
 =?utf-8?B?K0dRMFJlVG9keG8wTXNlSWVDdnFiWm5vcFg3VGFPS3dZaXVsWGFpS0JMMFI1?=
 =?utf-8?B?dDdCVkFEV1hjSGNiNVM2b0l4NS9kZ3I1Yk01WXBVN3R3dGZJOTZ1OHBlY1py?=
 =?utf-8?B?ZS94Nk1lOU5nbDB1MlEvNnZEU1JmWWx5STh0TGJ1aUdMM29VTGgzQloxcndK?=
 =?utf-8?B?dXZ5WkdQb2V2MU5EZVdBNXFKYlBLTkgxQ0c2QXdDWHJjeFY4UzIrYzJJRlRw?=
 =?utf-8?B?ZU1ZV055a0dWMDRsc0tuWFNGRmhHbkQxVXZzZG5xMy9pbm45ajNGM2NDT3BE?=
 =?utf-8?B?RU5NNjU5aWpYdFhENU1iVTR3S2xzcGNPN0h5eTFtSFdkWWhjaW1SMUV2Znlw?=
 =?utf-8?B?Q2hPZm9WZDU1OU9EMXdXdjV5V1h4dm0yQXY3am1TWkRSUklBai9ycXpnT2NR?=
 =?utf-8?B?UmVVUVFQNWYrdnlpZTNNb0w3anpTSEs2cHJYeUpTa1E3S1BMK3hnZGtGYVVY?=
 =?utf-8?B?MEFYdi9CbVZFK203NHlWSjVWSHQ0WVJiTGJybDlES25LTVJFTDNMUFRWbTY0?=
 =?utf-8?B?eDRKWFhhWmRvdmVJdDhYbFd3a2ZVWW1IVGFWMkdpRkh6b2lHV2I4azliTVlk?=
 =?utf-8?B?bW85MVFkQU9tNkhGTktPbGhzeWR1NTEyWHdHdWpEcG1iWlJSM2hBM0NmMFp5?=
 =?utf-8?B?aEp3ZlBDSWZudHNLRlA3TTNtcGJwZUlyN2xLbS8zWTFuY0QyU2JXQ1VTWFBa?=
 =?utf-8?B?UHp2TW1IbnA1OFF5UUZHT24vVm1mZmdMSi9ybEc5SHRwZXJwSnJTN2U4MW9P?=
 =?utf-8?B?SUxJVmFyU1Z5QTJQKzBKNlVJaGpWVG81clQyVWcwdXpZQjZaSWxDODJrRGtW?=
 =?utf-8?B?dmpKZWUrOVhLdlpCWFhFV2RHTXV3TlUvaXZRVG8zT3N5aVpTRFppM2xpTFFZ?=
 =?utf-8?B?NHJRMEVzNXIwdHE2dXVsSXhqL0s2QWF6cWJ2WFpYWFZ2T2tRSzRKcjZYUWh1?=
 =?utf-8?B?STNUSW9nUmZLM1AzOWxtOURRRmswWmtCVGZ2a2ZCeUhnZWZpNStXc0w4YldE?=
 =?utf-8?B?T3ArVEtFTkVoa1ZHemM5WkhUcTJacEk4bzdwMVI2QzRNdHZoY0I4UmQrSFhD?=
 =?utf-8?B?NzQ3M3BDeUxyUUJ4a0dSb2JPTDVvUVRtYXV4Vnl4endFNEhOS2RubVdZSGVH?=
 =?utf-8?B?UDJzaFpyOE5aUGxteXE5N1JhZTJkYmJYUzZCa0g5Tkd1WWQ3cEFrUXpEc3d2?=
 =?utf-8?B?eXN0SFkrajRzRHBnd0Fzc3cxcjQwVWRsRXpzYWZDd3JScExsUzFmSWtjYVlP?=
 =?utf-8?B?SGFFMkZpaytNMk9EOEZyRnArbnBpblZneDFZVDlrZGdmbXVaUHVMZGw5UUVT?=
 =?utf-8?B?UlBlQklyNTRuOXlnQTB0L0ZhWVJWUG5UMFZRS2tXMisyVUE3SjdsclZ4U3dJ?=
 =?utf-8?B?WUhPR0laVzRHd3hvcFlQSndBdSt1Y01MSDZsSzVVcmdVblltRlhGdTNyS2o4?=
 =?utf-8?B?ZVV3R0tka3ZSMVJVRzAvNFc0bzBPb2NlV0RDZnFjaWlnQm94L1BTaTJCNkpC?=
 =?utf-8?B?WklHOFRyV0toYm0rZHhGUmhSUERuYkJGcnI1ZGZ6V1llNnFvMjAzK1U3UHdM?=
 =?utf-8?B?RjhsSFNzRkdqMDd4bEsweGFXcFlJUEhZZ0ZPOFdHSWhYaVNTejZodW9YcDNR?=
 =?utf-8?B?TEl4SUxLdEl6RkdHcVA2cG9HMHVlR0VEOFhqN2lOTWIxb0JMNWkvcGc4bDBX?=
 =?utf-8?B?TGNxcTF2Rkwrc0VmU053YUU2UGE0Q2ZCTnpJZWd3SVI5RTg4SE5jNXpXcGJm?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1477c4-bc63-4447-39a2-08dbb46f04f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:35:12.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OCdO9KwEP06GxU8kjVo9+N7r/3hI75omxVCFHJRkO8TSfBpzM+uswZGLx/Xfmoy9wHJbspuM///AxzgJ3D6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 18:10, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `dax_id->dev_name` is expected to be NUL-terminated and has been zero-allocated.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer. Moreover, due to
> `dax_id` being zero-allocated the padding behavior of `strncpy` is not
> needed and a simple 1:1 replacement of strncpy -> strscpy should
> suffice.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> Note: build-tested only.
> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 0ee96e6fc426..1659b787b65f 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -103,7 +103,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
>  		if (action == ID_ADD) {
>  			dax_id = kzalloc(sizeof(*dax_id), GFP_KERNEL);
>  			if (dax_id) {
> -				strncpy(dax_id->dev_name, buf, DAX_NAME_LEN);
> +				strscpy(dax_id->dev_name, buf, DAX_NAME_LEN);
>  				list_add(&dax_id->list, &dax_drv->ids);
>  			} else
>  				rc = -ENOMEM;
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230913-strncpy-drivers-dax-bus-c-f12e3153e44b
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
