Return-Path: <linux-kernel+bounces-146291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5569C8A6340
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3F9283D61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA14D3BB23;
	Tue, 16 Apr 2024 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hj7q09e0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387A539C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246847; cv=fail; b=blJCya3Rar+NO00qxSVFbXIF5/XFvVQBdMSfdJCIk7FTPGj0tMzaeL3XgS636SnZ2NZpQEJqdpAcs9mrWLj0DtERSd/g5EVfvfp08xzccccpET6it6dz1Kf0tfthsgU2WeYVca53i+Uois27CnC3tv7KdZEWiAiAaRwO+GSj0XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246847; c=relaxed/simple;
	bh=51/JU+p2UdGgf2+O5XTg5SBRQX7AqY9xk1/tNdrxjW0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hYZlAnr8KcTCR5isfy45Gr3DZ63PC1UvX0kUN9HgonO1tc3EkBzjTN/7ovTwrgpsIP1/XYwGOSf1/LX8e82qcRJw0TNm2eRtNmGDwPeWMOp7Cm87W6Jp+eTsT9B8lbVIv4uu6Mx+4smWaNBM4uxH9evXeEmJohv8qQgrGPYHuXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hj7q09e0; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713246846; x=1744782846;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=51/JU+p2UdGgf2+O5XTg5SBRQX7AqY9xk1/tNdrxjW0=;
  b=hj7q09e06G9jdbB03rYmxur7TuYWrFX+aEWw6mH6QWeyFEzEUyXsckuX
   SRCvkaWfuUOS8hC2Ql+BTv9Yx3h9Q8HHr7yIOr6MeT6cAKJu568cKVpYp
   tVCix9HPvC+br7EOVaaIbhnoDo1cpOmbVE7I4yehSw7QjWBbIF4T6+TfZ
   MTCuCUXBIEIPQ2ie1Ye5WqpvTgHjNZwSCTkK8KK2192okIDgn3Rk3yRQA
   Z73zmdE9MDXtJ9JkvO7H8f4NrePlaQ2b0e0/H6Xh01iitz0FZwCZEpz+3
   t0Zpp/rjmFphMSlhcRjA2XA3aZ9ZHjVio6B/is8VuPLgwwFdcozPyZK0g
   A==;
X-CSE-ConnectionGUID: 4CpCWxc7RvS+SbBNKGzgAg==
X-CSE-MsgGUID: L6kod1dATLC4DcB4YQFbaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12454496"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12454496"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:54:05 -0700
X-CSE-ConnectionGUID: /2RqJz9bR0WkEHCaq8tqcw==
X-CSE-MsgGUID: BaREqeTdRfeIUqFTlJ/BdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26808560"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 22:54:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:54:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 22:54:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSnkgYabqqjW2KEzMB0FbDS6yQI+SPblvRTzPh9/vVhOjsoVQVvkAAYyTz2fk/chcbm9DcAGjmz8K1mfBHWaxaSt1fyrZ89xBcBhLa0IhhGF/o3LtcX41zzB9ORSqlMIJFqgMLAH3gVoQzVjryGPA4opBI0evyYbue2D5po+et6iq8mm/rD7T9DXRlQuxtmv+C/8OZmyvCccQ5ZVgejD1b3MKxMmmsUN9XRhe8tWKdFMJuXW/md4Wp3wzf5ITUaWVLQ4np8vlmKfCAlkuYT/49ZUr5rSucfmqisht1UH8T0I4B6cAP1Xj1u6THoNHdmpyF1wSD6PXa0jqiiPBXNB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DZe2567+oncFfpQYgCrUL0+806tJZ1R6ZlJaVOGfzg=;
 b=nDpw3YFWuPMrOu9CwGD8AtXKxvCUE8wH55mDKV5UWKwfPU+mYIlqDV/c+iXUdOnDuZ6nMKdFFntHwQ2j3OMxROcdcPbCnNvRMKLUu7Y721NhSlGHI6zzFw0lfNG+HiQdD6F7LRFeUG/fDQ7lysEmyEtdyl0S/DB3XAqzCX92SAGfsGVT6K3Z+kIWWjStU2HT99NeOtwdovoQ7DWICkQWlFDcsttB/yL0hw7GLTOYA/wm99UQZVwctOqbUKAoxW76/Bq0GOkDYLeZEqL5yNfSTSnQ1tBdVzcLi3u2GjDo80kLDVA/vKybrdp3+iFuWtRTWQi8YGxLXj3el7R9roPORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Tue, 16 Apr
 2024 05:54:02 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7452.041; Tue, 16 Apr 2024
 05:54:02 +0000
Date: Tue, 16 Apr 2024 13:47:27 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: arch/alpha/include/asm/page.h:9:25: error: 'CONFIG_PAGE_SHIFT'
 undeclared; did you mean 'CONFIG_HAVE_PCI'?
Message-ID: <Zh4Q7+IV6Py3LzQn@yujie-X299>
References: <202404142258.3CWV3f05-lkp@intel.com>
 <ae1e6ebe-be09-46fb-a2aa-4db0eb53f160@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae1e6ebe-be09-46fb-a2aa-4db0eb53f160@app.fastmail.com>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|BL1PR11MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f808bd3-ac87-4fc0-a4c2-08dc5dd99dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khh1CgJJ3R/8ZtKWZI1zLg5afawU6A7tLREkVuLcFozyKdvSQSAkc5KCTvi4SGfTXCooNbR4Fx+Xyqpai0OwIxrAciMX3U8+fiKK+tWJRyDBGFghTt/3MyAGQUDl0dPXwNoQUc2YGcIjqx0MEE272zYAt9qxpD2OF3NXrVuIBIY2S/jjc9iO2oD+EKROOft29/UwYCJ3LHxiXRnBUce1OtDiRRfDd+XEA4IXUAGfHIVMuuvjXVmmOE3Lh5W4FlTJ4xXp6WPWjIGmQzd+5RK6K/NG97Sm45eiI6h0yG8i2dVJA+xpZ3efwLTZk6UhqaNHwSxaSinntH616Fhx9ttUHm56MCRBM781NO/uxWNKXdPoAywR4SZRaYRgWWuHukQ7qu9gFlAEhjhYh8G1eCm8fbXNBa/slntGxQQFU5HC8Ot5bz06ZmotWX7dWG5szKJdvRQ1hJdDMceCyd4PlwxBTGlN5bWLAxgEEk5edp3Ken06paV3ZUDb6g2aNobjcTBefGqGZ4TI0v3eB9IxBNxLELXonJQjgJedrT3jF6ydifn5ZcNBejGjAoxsu9aSoPk08R2/Y6H/WfZi7iGI6GSUNfcOG0B3RvsFoG7qkyXLdUtSuOD1EVRVauFlbPjZGn1h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VzGWud5wX97VcSALDux1FCaFPn5z9z1qBpalblQBjruhccAYlVh2XjqVre5m?=
 =?us-ascii?Q?skwbeGD6/RRyrvVf8W70kg5OndiLzT9p/a7xQzhVzcgtMY3Nbemlw4BMANV0?=
 =?us-ascii?Q?qKN72R6UO0N1f96YWXmAND2wPb5m0m62ygDsEquy/6IWgEJEoE7llYsTTz8J?=
 =?us-ascii?Q?DTUtmgRLmlTOMdpMyBsFUMid+/q7qJNUony5qBOFezEzJJLaj8pZuL076dvc?=
 =?us-ascii?Q?ebKDi1LLrimqUU5aldINsjxpTgI5N2cIlyeNjeyxAKLsB7vl8y1U2ByWTNK6?=
 =?us-ascii?Q?WWCnx4zeHPfJoRS6sGQNH48Gh5RDey73IDB4bvIyYpcYk6qhKunCCuzOtZdg?=
 =?us-ascii?Q?nxv/EEU7gm54vFedPTZ6IUCMHtCUGb1EjyubEANZ4qNqJPLxmcktb66pPbMy?=
 =?us-ascii?Q?LYQa4LxlPHEvj3ivuFR7Ty/svDMz3L1ZsIu4wkDnNxSCeLhHIfnbGlTmFEp8?=
 =?us-ascii?Q?rFDV8Wc4X36K5LBWKoaYWR44unBKieD5boAquDbIDBN2frd+IvlmkCfRiO7c?=
 =?us-ascii?Q?SQfEBvdmbQoEcmsQ9dQNM0jtxb+grhLyksZNuRaYDXubupYt6QKn2Nfea0fo?=
 =?us-ascii?Q?YAOx9aFgDu9isRezmKstu473POB/PMlrmlJneqhYPvxQJFA1EwSHjuNDIdvN?=
 =?us-ascii?Q?+mfD99x/QgN/+2O+yIEUSrHTA1FYoIY72pD2XXOD+S+ICV8oL+nG5sax/gbp?=
 =?us-ascii?Q?ICT4UuSyQMaULB7FCBnFiq7yueJofMZfC6cPRPbaIeCNbrDMMOyajOSSDoRP?=
 =?us-ascii?Q?LA8fJZZAjcjK84ABeprRH9ztaABD3j1Noh0tvRH0mp838cAnXtDnLRxAu88o?=
 =?us-ascii?Q?CWg9o6gXZIvHJ2bPbRWvJb3Bq6zgnDpe/AM+vKmMgLeWrNZE7O3uhMxXHbDq?=
 =?us-ascii?Q?5GYDymjP7YluiV4Qpr3+Yq5F+w3jKe9UwofxD4lxVOErfeKhihL2brpvTWFX?=
 =?us-ascii?Q?UtYrh5uAzIUPng5K70s1gMdcLhpF0uyFyuOeX/nL+zYPuVqECUpauooep/F9?=
 =?us-ascii?Q?V3qHv93k5G3HewOhQNJGNnZ74d5EH+QCJVJk+RTVZmd03qa3i2JWiRH8eGgr?=
 =?us-ascii?Q?rtxYuj+WNBrcYTTDwS55CRulC3shgV+/gSHROCzmn4AnuRtzCJUZS6vJMLF4?=
 =?us-ascii?Q?HZ2vnRRuEk8vQ8zvwKyAuohAH55XhbWB3BBt3QllHj3iYoB0q+nnJkV9B+2K?=
 =?us-ascii?Q?JIGKNKEvPcy1IPBLMugoGQlbmnYoEc1s5purECcJP/amwFJ31PSUpKUiT7lD?=
 =?us-ascii?Q?HA3mjzwuPVXNH453mf+r7vUAhhgg2wZIOz465Szjgo7ko6ayK/rJXrY+jjHK?=
 =?us-ascii?Q?b7t+DFrhdkY4PfAsA0QcpBfUm8UwnzwG/xVh5bOnIJbK4Cnmd6QDMdQXhjPa?=
 =?us-ascii?Q?RW0F+Jc2Z+R/DPrl2cSqbRrNM3vxK51axWUlUKwArqxnIkwQ3q2MhAHUV3Pn?=
 =?us-ascii?Q?1MPXN/XoUQ5HqVUiDYLPqt1ge75W+ZZA8f8TLzZXqr9pIdQXOQqSvdphgFiW?=
 =?us-ascii?Q?bOmBXtua031ilr7X0NVIkxUWafMNeE/DXjavz7pU80XEiYjbEWL5FP3aq7QR?=
 =?us-ascii?Q?YYD32Y7D7l55mt17/RCMEo/bzNmw/4urP3HnvOMW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f808bd3-ac87-4fc0-a4c2-08dc5dd99dfe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 05:54:02.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i73opmUzCc/qjh8gmav9COkeKPd/NPvqMgbmY2KuQKeKdTfUumktfVsR+7xNdbpOIenl5pRq3TXnj72eS/4uqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com

On Sun, Apr 14, 2024 at 05:46:54PM +0200, Arnd Bergmann wrote:
> On Sun, Apr 14, 2024, at 16:52, kernel test robot wrote:
> > tree:   
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> > master
> > head:   7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
> > commit: 5394f1e9b687bcf26595cabf83483e568676128d arch: define 
> > CONFIG_PAGE_SIZE_*KB on all architectures
> > date:   6 weeks ago
> > config: alpha-randconfig-r016-20220816 
> > (https://download.01.org/0day-ci/archive/20240414/202404142258.3CWV3f05-lkp@intel.com/config)
> > compiler: alpha-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): 
> > (https://download.01.org/0day-ci/archive/20240414/202404142258.3CWV3f05-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new 
> > version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: 
> > https://lore.kernel.org/oe-kbuild-all/202404142258.3CWV3f05-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from include/linux/thread_info.h:60,
> >                     from include/asm-generic/current.h:6,
> >                     from ./arch/alpha/include/generated/asm/current.h:1,
> >                     from include/linux/sched.h:12,
> >                     from arch/alpha/kernel/asm-offsets.c:10:
> >    arch/alpha/include/asm/thread_info.h:43: warning: 
> > "current_thread_info" redefined
> >       43 | #define current_thread_info()  __current_thread_info
> >          | 
> >    include/linux/thread_info.h:24: note: this is the location of the 
> > previous definition
> >       24 | #define current_thread_info() ((struct thread_info *)current)
> >          | 
> >    In file included from include/linux/shm.h:6,
> >                     from include/linux/sched.h:23:
> >    include/asm-generic/getorder.h: In function 'get_order':
> >>> arch/alpha/include/asm/page.h:9:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
> >        9 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> >          |                         ^~~~~~~~~~~~~~~~~
> 
> I tried reproducing this, but it always works for me here,
> using my own gcc-13.2 build. I tried both the latest linux-next
> and the 5394f1e9b commit.

Sorry for this false alarm. We re-examined this case and found that we
could not reproduce this issue either. It seems to be caused by a
malfunction of the bot. Please kindly ignore this report.

Thanks,
Yujie

