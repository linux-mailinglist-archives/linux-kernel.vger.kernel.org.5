Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB07EDA69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjKPDgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjKPDgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:36:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102AA19B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700105777; x=1731641777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xdM+BewN/4I7kVeLguKi8x48n9f6ZHrfJ+PjPDSR3cM=;
  b=U4Hzloabjrz9ZLEJyBTLNYkABWqUfTXBAB6M8u4AiOCWK3oiqMOnCVAE
   tKC8GLWKr0in2hI9kpQexk4EgUJo8RH7eMnsOXLUCXp7lPDrYzdK8fUy7
   q/vJcsehkRwWR6edJDf3pA0gO4lpyW+eFjHbuXM2k8He8acVRJc4VIRKS
   pEJ4p2gQV+5Nk9/xQhP/2YqhRsfntCrXBONw1eVHC+bFq14qk08Yr6iHZ
   tYQ2Zs6wu/RsrWXttonZQCBsLZqyaspzIEOc4AU78IeyR+Q3lQWWZes3r
   QsVZGiC1J7Op3LSwK5jUXQvXHyL58si7//fWRWJaZHgz3VdqINQ/D7fPV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389862319"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="389862319"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:36:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="13417805"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 19:36:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:36:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 19:36:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 19:36:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgArJZXU8J1Ssz7C9JFPWPjJg9zjT602F3G6jyHCGVhx2ql0pT97w+oqPv0grNwt1z1wgFadgRsdp6ji65PJ1YXFl7IfUQXhFYybNsdce5Z9VR3Y9Nrt6PQsNVJZNIa/R8QEVGFYBZ9lNEeXlI4PZRWXCFdEaxEvq9Cy4W4Fmo5hTSkpCbLHoQkTkBAWVRgEBF0QHc6hL6NaxlC5RODh8SMBxB5IZPiNgl/w5+au3RsPQ3oGpF3ObZUbqvTe7bOnBxWcJVey2jVYhIkKntZYUvcvYEBVn6714l78YDyIFzLYh8KmZPaNyUzMar8OF3XADUsp0X6Ybge+BPeYJM7LQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT5U+3b+dpwfN4UMyU2eXhHIwTKm3aB9wWszTvuhjGk=;
 b=ciGnuEnXt2ya1HwHJv4Ao5zSR0b3ISJL3v6GM3qBpHWWMYM0tbRF3CRNXmpK4nLT/wn0REPeF3CCmVV7Sp3YAm5oPKO4XDBO6NpmQ3/TVkwJ5mTHvoJeE4VZri4vp+aN/3hlrXktbBSaXnUvLR4RBZHKL1kMW1uxJgGhk3D2nCgnvTGAhi0HemkmxnsKbFljntKzSSV+SStMt/MC6ugoBwxeSQQ3w0a35LXJiixuqK3njWT6OpnbpnK06ykRLhSTAi8RfQ7Ypqey0gRB5HUEGFk5VREPBEyJ5JUn9Mhx4wBArwgtaBJC1zeX7xZr34lJdClQY4XgWpO6DLDRlodszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by BL3PR11MB5699.namprd11.prod.outlook.com (2603:10b6:208:33e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 03:36:06 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 03:36:06 +0000
Date:   Thu, 16 Nov 2023 11:35:58 +0800
From:   kernel test robot <philip.li@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/gpu/drm/loongson/lsdc_plane.c:268:42: sparse: sparse:
 self-comparison always evaluates to false
Message-ID: <ZVWOHqAqo5RVjbqn@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|BL3PR11MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: fab27954-3661-4ddf-689c-08dbe6552a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AW6waPGOFs8liaezcgzUqaPGf+nhWYbr1LiDaF3SI+j84mMyoEHRShdxiCyAhatlCx7CTokcBN25Q9hRYGDONVqe8wkypCBdGFghTbcWrWbXMwijJvGyIdTXaFBibArme4aRda6mAiV9lkTAHUgAhir9n9ynTK+apGVes/wyORcILb7jveY4u09vo8Ms/v9IWBiRDfAmePBhT32MVVVXkU2a0eX504y2RAlZtOjK6uYq20CL/lSjO8ejAoDiKM5vF7pXePj38A6iLUl2XGvg/yg7v968HzyVAULhPTGNHJRciKHtos1bDnpd6iRmj/qkwq3h0UrHC8e5trjt5WFXWLYwh6yURrIgXJAA+JQxQ8G5W4ZQsnmDar+eKAo4BJTngKEsczZEukqqP5mjdyCSrGfvQ1yaNxfd8ZuvAFowBDkuc9XhLlpXWbfFQKY8M0AgEemb4QQ0P9fzZgMQh8Hpx7txLQ3mcRg3A8TB1Nfn5QHqlwloznbIwGXnxNcRBntxu5rNz57ubFSwNXtjAf9freFPYnL/6FsGUnafEP+xyukLwoEd+xm50oa83unUz3ubjuYU5lGZe0XA33sozgqg0+uu+wsIZKJZYVPDczbHWjXBc1LQ78YVq5vOfQXIiQIGMbTbTE5S9ba0qnTLibhTWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(396003)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38100700002)(41300700001)(8936002)(8676002)(4326008)(82960400001)(83380400001)(26005)(6506007)(2906002)(9686003)(6512007)(33716001)(6666004)(478600001)(6486002)(966005)(316002)(6916009)(86362001)(66476007)(66946007)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LzYmjsMvOrEcTOlpP3OnNvP0fzTLIxXfWWEPqsuMpKlvkC8yNOYwfoIK3yN?=
 =?us-ascii?Q?0kZQcnl9PFHjMv+hfa3zaNUxTh04jIYFK/NxkDAQcTP25ASQfm+OXj+tUZS0?=
 =?us-ascii?Q?B0WUSBgrk0z6AwzNoh/6GV2EZMmjYWIAN1l/EBTxobiJaRcJmQ7ltyfPfdsq?=
 =?us-ascii?Q?Fygc9mCapwNYCKPsKqcBGqRT3O2z5Llv4N0PDO5Mw25AlNLZj4Wxx0J3T3d5?=
 =?us-ascii?Q?non8rEy56/TVcS+f8ib9IlWRFdnYhdU9LGGGX3AWrqso7pB3ALwqoLWkHOfV?=
 =?us-ascii?Q?sxJm28qGIfocttDZ+HCTh5PuumhT9jXAcqE60Ftcx4uO3Kw5ZuFBc6hNoclC?=
 =?us-ascii?Q?fmCfSeEhPpCwWkxbtRvS1nrUI60v2zNxG0yfPxLdJ7xfraU843J25nMv1zbL?=
 =?us-ascii?Q?2fiMGa37arNKentx6rF5UpHS3gHraiZj2Inxw8rUhasG5/GDidQHRUkvOmEz?=
 =?us-ascii?Q?fniwpgxDNRnMqcX0fcJGB27jA0qo1mYpTW6TnMd+dt70NoBnxqRvLtsSiNhT?=
 =?us-ascii?Q?s6cBrLxeGW+VuMr+2fFD2kW5jZIyw79kqCd0LcE+CgpoxUwyn0QmPRCe9YZq?=
 =?us-ascii?Q?TeyAXXbgzuXvjfoJywy87EPD8i7H7CEg7EI7fSvId3sopPy5iCrhs+S3L4ub?=
 =?us-ascii?Q?ltGRB+uXuycRziTyuzG3FyNE5pa0lplvcjj6YHI9oFHdpZeua+7pTVkHYkIT?=
 =?us-ascii?Q?4hPu44k/lWXUO5S6eSylgFzBmVkfYWIgMURsO1XvWPKZGBkmNNdm9yW8+K/1?=
 =?us-ascii?Q?3l0INWhrsFrF3+mOLlgkNPH7o+uMujB0Hv2WdNcrakxHnuLZLA6byWucQLLw?=
 =?us-ascii?Q?sNXLRtfd60lrNoP5jcid3CYSKTx7kKIC/ZkbLTyEE+WHgqblmwJ0/JQLdxnb?=
 =?us-ascii?Q?WpGzFnTh8unex5plqIOieVCcIuzShn5Vm3N21tk/RCAb0ANvRR6Gz2i+gN5r?=
 =?us-ascii?Q?AGvYkp+mctiuuBbKBab2DxlOObAGrhhLod2qwvCbkQ6zGIcUit7M2+8Mp1rI?=
 =?us-ascii?Q?CEjR+g0qyGzOpjl5aPFb4zTPr6sFilXVcvZT3v2XRB6X/Caa55aG3It05hKX?=
 =?us-ascii?Q?qo9pDDsTcfX+JBFOnniVEATnJW+rMOgEcI/VQwiDYOw7PgG/pXZQasxPtT6X?=
 =?us-ascii?Q?SBeuox84ZIPEazWkK/0mTPB80+C6htkuWNiYC27n20Kyv6uUKwCrgqOFono/?=
 =?us-ascii?Q?3spCcYSiFcNN8sNhFrOOKRqAeKEtd8e6rAu1FhhKCnAFKYDtDhq7GuNByefd?=
 =?us-ascii?Q?zokVwDek2+XsLyLdV3vtjwHAH2QP2V8LwMTxtTyVKSOyaLYMPfVHnESU80gH?=
 =?us-ascii?Q?CAnlgIgVWZZnd794R+mtMtp/iXXaf6sE0BjnH0aim8fPF1EHAbaNRtS624Xv?=
 =?us-ascii?Q?23HP2laJxvNQ8PFy96WyAxRwYfB+U8OsTIczOaz/+ZeLKHcvPpDlKlcgwDF3?=
 =?us-ascii?Q?8LNZ/pJopFl4sjeyJwgeJV3KLnmFb8iGJacGrk1OwJAUcAkwSaL2VZaxi0Vf?=
 =?us-ascii?Q?nmVDTZmW9ZOGtxypHxXoms0QFGfFiuP4xKBWPZ7gSPFPgn8NeTc/9YyT7FvF?=
 =?us-ascii?Q?yZsw3Jzhxg+RsYbHBjXZkSI61N03wMHFVtcOUxxm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fab27954-3661-4ddf-689c-08dbe6552a61
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 03:36:06.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k34lqxEqwHwZSjMgHIEihIxUpfHdgdW1exUpiBWroT/mCQyTjwX5NIvOcO/KmRZqJCBYA0eAtm39OUbnODM+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: f39db26c54281da6a785259498ca74b5e470476f drm: Add kms driver for loongson display controller
date:   4 months ago
:::::: branch date: 11 hours ago
:::::: commit date: 4 months ago
config: loongarch-randconfig-r111-20231115 (https://download.01.org/0day-ci/archive/20231115/202311152357.4KFS0M8f-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231115/202311152357.4KFS0M8f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/loongson/lsdc_plane.c:268:42: sparse: sparse: self-comparison always evaluates to false

vim +268 drivers/gpu/drm/loongson/lsdc_plane.c

f39db26c54281d Sui Jingfeng 2023-06-15  225  
f39db26c54281d Sui Jingfeng 2023-06-15  226  static void lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
f39db26c54281d Sui Jingfeng 2023-06-15  227  						  struct drm_atomic_state *state)
f39db26c54281d Sui Jingfeng 2023-06-15  228  {
f39db26c54281d Sui Jingfeng 2023-06-15  229  	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
f39db26c54281d Sui Jingfeng 2023-06-15  230  	const struct lsdc_cursor_plane_ops *ops = cursor->ops;
f39db26c54281d Sui Jingfeng 2023-06-15  231  	struct drm_framebuffer *old_fb = plane->state->fb;
f39db26c54281d Sui Jingfeng 2023-06-15  232  	struct drm_framebuffer *new_fb;
f39db26c54281d Sui Jingfeng 2023-06-15  233  	struct drm_plane_state *new_state;
f39db26c54281d Sui Jingfeng 2023-06-15  234  
f39db26c54281d Sui Jingfeng 2023-06-15  235  	new_state = drm_atomic_get_new_plane_state(state, plane);
f39db26c54281d Sui Jingfeng 2023-06-15  236  
f39db26c54281d Sui Jingfeng 2023-06-15  237  	new_fb = plane->state->fb;
f39db26c54281d Sui Jingfeng 2023-06-15  238  
f39db26c54281d Sui Jingfeng 2023-06-15  239  	plane->state->crtc_x = new_state->crtc_x;
f39db26c54281d Sui Jingfeng 2023-06-15  240  	plane->state->crtc_y = new_state->crtc_y;
f39db26c54281d Sui Jingfeng 2023-06-15  241  	plane->state->crtc_h = new_state->crtc_h;
f39db26c54281d Sui Jingfeng 2023-06-15  242  	plane->state->crtc_w = new_state->crtc_w;
f39db26c54281d Sui Jingfeng 2023-06-15  243  	plane->state->src_x = new_state->src_x;
f39db26c54281d Sui Jingfeng 2023-06-15  244  	plane->state->src_y = new_state->src_y;
f39db26c54281d Sui Jingfeng 2023-06-15  245  	plane->state->src_h = new_state->src_h;
f39db26c54281d Sui Jingfeng 2023-06-15  246  	plane->state->src_w = new_state->src_w;
f39db26c54281d Sui Jingfeng 2023-06-15  247  	swap(plane->state->fb, new_state->fb);
f39db26c54281d Sui Jingfeng 2023-06-15  248  
f39db26c54281d Sui Jingfeng 2023-06-15  249  	if (new_state->visible) {
f39db26c54281d Sui Jingfeng 2023-06-15  250  		enum lsdc_cursor_size cursor_size;
f39db26c54281d Sui Jingfeng 2023-06-15  251  
f39db26c54281d Sui Jingfeng 2023-06-15  252  		switch (new_state->crtc_w) {
f39db26c54281d Sui Jingfeng 2023-06-15  253  		case 64:
f39db26c54281d Sui Jingfeng 2023-06-15  254  			cursor_size = CURSOR_SIZE_64X64;
f39db26c54281d Sui Jingfeng 2023-06-15  255  			break;
f39db26c54281d Sui Jingfeng 2023-06-15  256  		case 32:
f39db26c54281d Sui Jingfeng 2023-06-15  257  			cursor_size = CURSOR_SIZE_32X32;
f39db26c54281d Sui Jingfeng 2023-06-15  258  			break;
f39db26c54281d Sui Jingfeng 2023-06-15  259  		default:
f39db26c54281d Sui Jingfeng 2023-06-15  260  			cursor_size = CURSOR_SIZE_32X32;
f39db26c54281d Sui Jingfeng 2023-06-15  261  			break;
f39db26c54281d Sui Jingfeng 2023-06-15  262  		}
f39db26c54281d Sui Jingfeng 2023-06-15  263  
f39db26c54281d Sui Jingfeng 2023-06-15  264  		ops->update_position(cursor, new_state->crtc_x, new_state->crtc_y);
f39db26c54281d Sui Jingfeng 2023-06-15  265  
f39db26c54281d Sui Jingfeng 2023-06-15  266  		ops->update_cfg(cursor, cursor_size, CURSOR_FORMAT_ARGB8888);
f39db26c54281d Sui Jingfeng 2023-06-15  267  
f39db26c54281d Sui Jingfeng 2023-06-15 @268  		if (!old_fb || old_fb != new_fb)
f39db26c54281d Sui Jingfeng 2023-06-15  269  			ops->update_bo_addr(cursor, lsdc_fb_base_addr(new_fb));
f39db26c54281d Sui Jingfeng 2023-06-15  270  	}
f39db26c54281d Sui Jingfeng 2023-06-15  271  }
f39db26c54281d Sui Jingfeng 2023-06-15  272  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

