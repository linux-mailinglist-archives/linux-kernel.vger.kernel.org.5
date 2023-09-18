Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3E7A4E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjIRQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjIRQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:19:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0D86A0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053586; x=1726589586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CMR9NW892JFVnJ12Ba2qhAsnol4CpG2z+TRlNkv5Ww8=;
  b=Hupg9dWG/XtkIpT/TDVRxBQWTBJmIFEPLW/Wkig34bq1pDClL/tUR7Fq
   /hfZCynbwlSrHlUFCw1+241uxDJLilY96z7ui/zKJu9Yd3g4m/IdfLlBY
   jqJOm27uleUApy0HZ3+8bFODrn16BwRGVVtL0YkzoZ0LK9QQeEt7Dq4u6
   I8w3V3FX1E17+hZ8yzV2NNcX8jNBopTBLVLquzkoyTnvBVVGAQ6uEBG44
   +2WrIeGNjk51/QHNuMHbWG5aRVEsuvHYj8qRjZtSL7zcRxRp0HCfZSZGY
   rJZ0Mwt2d945vUeg4K3L1He/m8NlcF1gLzWv9kDGWFetLdY1jjAuT8Qdy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377020254"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="377020254"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="869603798"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="869603798"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:09:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:09:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:09:24 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjie5lsVBlyzaljGxt9Yn8REg0h0vtxPm1xo7fbepVHZ3ZnKbq93KtQtRCVv1miW+09ytT/LcdaG1z5WKqBas9w/tg/nc8OAB2rFiC38NUmCfGFzdkt5ozMjR81FrrucR8KYbv9sax0OmsraPOLyFGLuCPBDZCw0Lgi9iyWKqJwB7bzNLZbbzoK4ozRb7x9/G53LfeNqLq7QXTogQxTCrbkvhqF0/YrjAnjVm5uR+zuNE38IGuR1ibMWozXxrXxiMW6i+rYVz+OKqU1aAXsCRb7K0sucNm70sKWFX8mg1m9BbB6NwWnFC8Ta6HKd1EBM4QzWL06rSMl2DenFSogLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fk/PD29nHiMTD6YjEWWSV9Wy9OAcDOJ1B5qj8ePFik=;
 b=FnnxzVzIfnjMW+32Z74R/0XGY9vgYLDeHRJ4G0JLqrFZkz0SwsFO5QktdT0wHZI5m5o5Hqes6YeJ9XBwNQBh4EqZWmY+ygEhWTzet2KkXY9JYaT/Gtx6/kETZab+FSqoGDUxZ+wUSGDIxt55Gc/YCIR+qpDDTCKlQJwdTGx9ied2ueXNYR7uN7Ap0nSAWGQhMFaKCj0ISecADWSINlGUeiYHqD/1s9UppGXyUWuTYBeAnMPFCwHojJqEoT88BMG9rG+sDvy/Z43AKziTyO5LTWsEJDRq+9FgQQ5+wo5YGYbe80g18MXlKlmBLE5P0LsCm67HtKm+cpT0Fb0Key5D1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:09:21 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 16:09:21 +0000
Date:   Mon, 18 Sep 2023 12:09:15 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        <intel-xe@lists.freedesktop.org>
Subject: Re: [Intel-xe] [PATCH v2 2/4] drm/xe/gsc: add has_heci_gscfi
 indication to device
Message-ID: <ZQh2K506qQ+hGSld@intel.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
 <20230914080138.4178295-3-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914080138.4178295-3-alexander.usyskin@intel.com>
X-ClientProxiedBy: YQZPR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::13) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|SA0PR11MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: ae19541b-a63a-4909-78d2-08dbb8619e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdTyc4RjV8/PQTl9qtbYyZygGXuizOuonE/f4Z9/Zu26We7hnHQusoYSWFhPatFRuGJxOnNEJIcFv4UJTXdUzZTlk7tAjL7hrzgKrOd+1g0src+WmBlVs5Jl/fj1ZWyCQzjN+hyb7A6IVwqjiZQgu9+Qdg8O14/ELMCMoG4avg87HHVgAPX2rX6Tef3WShX+pbsbZHqVSSHZbP/3TVAkvsrLuG0rHftSjNlB9pwQ78dZ0+mXkvibSaDJe7fcI/vj444h5w7QMMjsZjf0TqjGGVK9ZU9QlWTittErYjX61Oc8PMZRjdFd5o+Q75xg/ieySvIEjQTt4MQIaMwZc6M10aVLzvbeRVX6otuz7fTZrCx1XtHqk7TRluRGxGe4q9s5oWnSoZDzrcIQrd4h0DxV5LjcJe+Ho+smU+QA3WPFe/pc4xNnyVLl0oK/xx0K+gW9sYKn1SmPSF3f31Yeun/xWEz0HAx+VWBxMOp850mV+3SlKCYXpKsi+7nBzu9zPk6dOXqSc8DkI5ah8jyu2jpQW/ONU3nMqTGNVLcSbw9DEtZkI4DLJ0EPftHi5+8TRRWTPZdZqStab3qBZni/AGyh/lV2dfWwxflAH01uHq3eFUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(6666004)(83380400001)(82960400001)(86362001)(38100700002)(36756003)(2616005)(26005)(37006003)(316002)(41300700001)(6636002)(6862004)(8936002)(8676002)(4326008)(2906002)(66946007)(54906003)(66556008)(66476007)(478600001)(5660300002)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bpL9Au7XWly1o2RQvf0QtGaZfK3kvGruIe3n3IVYdQiils0pL4SkUp5aXh+?=
 =?us-ascii?Q?Yvzus8eLz94R9Zu6VgcaekrPC6kL4phgb3thh2dopWO4KqIeWjvTu2ldumdA?=
 =?us-ascii?Q?V9dlowGOUtWW/jS2FbIHpIjuf1xsvGrRwtNhuk9PDn4ajNL7UgpkBnJqaVqx?=
 =?us-ascii?Q?IDiMME+rHdrGq+y+/5TtVrCBraZjjMw4CUszQ+BuWlfqmOPsmsyLbgXYGZmE?=
 =?us-ascii?Q?r7UEB0nPo8uPFOLlQex3CAyJ7ZY42DD1QqOSHwHvYO11vQTsdv/736Fd5XVI?=
 =?us-ascii?Q?pfbbdC9+2zzmXslIy9KJoc9gUcMOcdl1GLFaImjvCs+/ShA1GQ8N1bXMW2nt?=
 =?us-ascii?Q?luIZFuiP4CqLr4xLVnLleEdUITQ4JBCZCNu6LWmYR1fTmo+kZauUd6Kk1k/t?=
 =?us-ascii?Q?8RHZysVUY4pI3cn6lybczMEDVDFqR+ifQ/ykzgL+NAtaTTok9+UKk0/bgvQq?=
 =?us-ascii?Q?YMhM+jjS/hqvnvMbWHL3MXrU2LD07uF7+UBdqZUi1o3qrz+fjYKMlCIznHHy?=
 =?us-ascii?Q?F4LhZqEvBbSDPp1BToLchnrexQCbzRz5fHyEXaItvJTI3p8R9ceb+gqb3bfL?=
 =?us-ascii?Q?P4xVtjMkr9QnDb0EcRTMZLqmYMjhnOKAUmvHaCmQgrZeucn6Y2Cn+7i6b+C4?=
 =?us-ascii?Q?RwVXeJDxFgl/xIay/ueBvgaoKZblRErQrG+pTqwXBedy6A1lp9DEmlD5UUol?=
 =?us-ascii?Q?THzt6j3J5/Hzpqj0dK95m5v7zuzhn9dD/kdc3sJ9/psHUSeIwlHYcTRCHBtD?=
 =?us-ascii?Q?G7R9La59fhi7yNwNL9r6wkOYGflwihRrsxDs/0cdNN70nq8cbRRNFIx49emi?=
 =?us-ascii?Q?co9bRWdM7IwPnzzVPshscmCq1bTrl2VUcLDAoy0OKSH06OE0iLOTTmieK1Q0?=
 =?us-ascii?Q?ITdrcqE4SGJktRHOPx6RtI62s9WRfw6U/WESo91zcP+bcUdgPyUaUTy1EQbc?=
 =?us-ascii?Q?J3Y5Y2RvWQI9DQErCU8YhBhhIE7mJw/WhvjZ37IZPxCKDfmoqJKkJ7F2zkDk?=
 =?us-ascii?Q?Zga4bMkdPwzJ25OOPI19LHfRMNSuf65HfyrRY8XyvSSFJyvW+UVi3ZWPpA5Y?=
 =?us-ascii?Q?6Dsu8tFzokzioRkXKQNDej5jttRs6+bl9Uj8vN0EkSS9HI6/eHizZXk8TTb7?=
 =?us-ascii?Q?NmgEGkgSZrydg4yHyNWxTDOTjBw/ncFwgmWhQcu3oYxvmobefo4czao5THMj?=
 =?us-ascii?Q?VZSz0GiFIRwSvPCrXVVxIDaSDmOqeTrRZUtRsASsoNOljkCrDp4G7VsL2baw?=
 =?us-ascii?Q?zphFTwEye8StR+p4Yyur4ho5g7bYBV1gTv4etHvnOgPOdLq8YKL8eiEn1B1J?=
 =?us-ascii?Q?O2BmUDXS8uPwQEQmdxmBG9SPw4aqz2QQ2s/YKIXm8cTN9QKbQLkK4qV5sfSb?=
 =?us-ascii?Q?b8sPZBGqD+5xtzY7u/Q/nGwn1UVeVmmCeuww9x30xFhpCwAv/CUdWAvoegWc?=
 =?us-ascii?Q?WSnVljX0h8SzIryWkCHoJlBUgpvN4jdqWBkv/0wlsQgz4NafDFNAcFT2nMKQ?=
 =?us-ascii?Q?S77PCtCFRKYzAg+ncofTTY8ZcwekbHi8kooLXubnSxohMnNWJrlhrxOv4J/A?=
 =?us-ascii?Q?Kh1OOUlDQLhNHyBQ5Hhhju8mdQIUrdoxgnxl7pPj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae19541b-a63a-4909-78d2-08dbb8619e6d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:09:21.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awbQDkl6veVmNzN+DmJ5d06PuKmRdWjFzlZgXJcYIGGbg/X/R4IthjEa4uugTRVHQcw0v7P6qMjPzTCMOirjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
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

On Thu, Sep 14, 2023 at 11:01:36AM +0300, Alexander Usyskin wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
> 
> Mark support of MEI-GSC interaction per device.
> Add has_heci_gscfi indication to xe_device and xe_pci structures.
> Mark DG1 and DG2 devices as supported.
> 
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_device_types.h | 3 +++
>  drivers/gpu/drm/xe/xe_pci.c          | 9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 750e1f0d3339..1d1fe53fc30d 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -32,6 +32,7 @@ struct xe_ggtt;
>  #define GRAPHICS_VERx100(xe) ((xe)->info.graphics_verx100)
>  #define MEDIA_VERx100(xe) ((xe)->info.media_verx100)
>  #define IS_DGFX(xe) ((xe)->info.is_dgfx)
> +#define HAS_HECI_GSCFI(xe) ((xe)->info.has_heci_gscfi)
>  
>  #define XE_VRAM_FLAGS_NEED64K		BIT(0)
>  
> @@ -237,6 +238,8 @@ struct xe_device {
>  		u8 has_link_copy_engine:1;
>  		/** @enable_display: display enabled */
>  		u8 enable_display:1;
> +		/** @has_heci_gscfi: device has heci gscfi */
> +		u8 has_heci_gscfi:1;
>  
>  #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
>  		const struct intel_display_device_info *display;
> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index dc233a1226bd..145eaa430d74 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -57,6 +57,7 @@ struct xe_device_desc {
>  	u8 require_force_probe:1;
>  	u8 is_dgfx:1;
>  	u8 has_display:1;
> +	u8 has_heci_gscfi:1;
>  
>  	u8 has_llc:1;
>  };
> @@ -265,6 +266,7 @@ static const struct xe_device_desc dg1_desc = {
>  	PLATFORM(XE_DG1),
>  	.has_display = true,
>  	.require_force_probe = true,
> +	.has_heci_gscfi = 1,
>  };
>  
>  static const u16 dg2_g10_ids[] = { XE_DG2_G10_IDS(NOP), XE_ATS_M150_IDS(NOP), 0 };
> @@ -274,6 +276,7 @@ static const u16 dg2_g12_ids[] = { XE_DG2_G12_IDS(NOP), 0 };
>  #define DG2_FEATURES \
>  	DGFX_FEATURES, \
>  	PLATFORM(XE_DG2), \
> +	.has_heci_gscfi = 1, \
>  	.subplatforms = (const struct xe_subplatform_desc[]) { \
>  		{ XE_SUBPLATFORM_DG2_G10, "G10", dg2_g10_ids }, \
>  		{ XE_SUBPLATFORM_DG2_G11, "G11", dg2_g11_ids }, \
> @@ -562,6 +565,7 @@ static int xe_info_init(struct xe_device *xe,
>  		return -ENODEV;
>  
>  	xe->info.is_dgfx = desc->is_dgfx;
> +	xe->info.has_heci_gscfi = desc->has_heci_gscfi;
>  	xe->info.graphics_name = graphics_desc->name;
>  	xe->info.media_name = media_desc ? media_desc->name : "none";
>  	xe->info.has_llc = desc->has_llc;
> @@ -703,7 +707,7 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	xe_display_info_init(xe);
>  
> -	drm_dbg(&xe->drm, "%s %s %04x:%04x dgfx:%d gfx:%s (%d.%02d) media:%s (%d.%02d) display:%s dma_m_s:%d tc:%d",
> +	drm_dbg(&xe->drm, "%s %s %04x:%04x dgfx:%d gfx:%s (%d.%02d) media:%s (%d.%02d) display:%s dma_m_s:%d tc:%d gscfi:%d",
>  		desc->platform_name,
>  		subplatform_desc ? subplatform_desc->name : "",
>  		xe->info.devid, xe->info.revid,
> @@ -715,7 +719,8 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		xe->info.media_verx100 / 100,
>  		xe->info.media_verx100 % 100,
>  		str_yes_no(xe->info.enable_display),
> -		xe->info.dma_mask_size, xe->info.tile_count);
> +		xe->info.dma_mask_size, xe->info.tile_count,
> +		xe->info.has_heci_gscfi);
>  
>  	drm_dbg(&xe->drm, "Stepping = (G:%s, M:%s, D:%s, B:%s)\n",
>  		xe_step_name(xe->info.step.graphics),
> -- 
> 2.34.1
> 
