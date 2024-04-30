Return-Path: <linux-kernel+bounces-164499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75C8B7E44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7EC1F22E13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0517BB19;
	Tue, 30 Apr 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKFzkCXB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9217B4E1;
	Tue, 30 Apr 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497250; cv=fail; b=tvp9BK4q+ZHz86GYfDYzAHXAdz8vxkFFwRTmWRRN0nCeTuFm/J5rcrlKMJdBqCdV0UeLXR/X02cNftBAcyPbkWVpWW5L+7PQR3VKoUTs2j5p6o9ySHhnhNa0eReRVNDQ2BzG/W1bRKMEkLSClXDlKU6ryLhh3orCbklAyjeSKGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497250; c=relaxed/simple;
	bh=d7O3qkBiMlkBEWHeeFFz0TOyGVxTTEOM/dbZYu1bkBE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8lCaQdILicIQrjWSlKZeVJqF3FYlkxF/ZzlxhC6UnD1PiGTVH6zJdopA2ycJkSyVbg+DbZ+0+NuenH4iFakvalOreE1YQjGTh5REkvXrkuUwRCfz90h2YhzP/riMwjUQ6k2PGZ6avOVPFC1XLxDWRDNIEHC30ERXzoMJH5Gwvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKFzkCXB; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714497249; x=1746033249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d7O3qkBiMlkBEWHeeFFz0TOyGVxTTEOM/dbZYu1bkBE=;
  b=RKFzkCXBcBdclA9/oevOR8/7QqRBFOJbZoakDW7KbvenSd2Q7FGVjqBU
   P/mk/8etUDw//yrwBHvZY8SpHHt3iPzw3n4JZ0pb43vtPxfg+q80iyvzy
   bvBAwEV7sQescX5K2SvPm4IjIFzo5KPxldUVIDVuNl3gYYPcsx5GB5s63
   D72wojZufpDWvF+PKxqLYUgUwEcR3tZbKXXwRTHoSF6ma20YN0EEPtwEZ
   YYwLjYkFoNX2mssiJUB9r13YTARF9ehrxYeVMrR+SWjvgDjCkdSAc0E2A
   qlmn38vKPgA4WJR2Ic5SihwOa5jiCp/OtEz7xNmZ7SK6keYXayEVwATmv
   g==;
X-CSE-ConnectionGUID: /bhbh8y1TAGEbtmfPl6HSg==
X-CSE-MsgGUID: GLd0Q0XiS/+LuEjl/t3/tQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21638884"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="21638884"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:14:08 -0700
X-CSE-ConnectionGUID: /JdYCN0ZQvG7rnrNcbxfUQ==
X-CSE-MsgGUID: kouwnL2rSFuxvgYSiqR7FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26530674"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 10:14:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 10:14:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 10:14:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 10:14:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 10:14:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkmdkcS0CutZGlkgUQYGF0oIjK29Ab4HgIICt2zH5Efq1Yrde5T2+uA3dkfkU0dHN+rF8UntNpmvnSXtVQ/RP93NqrHcCyaTN9GmdC3n3r0ZLXmMMqH8X1x5T1Wsyjx4DG/hFuotXmUUTQw+m3qHyPQwRez+nKuITFK+3+lb11NJRGrF4A7bJovxYiVgz8+LbXhb0oj301OMa9zkciC+H/U3GD2lsg3+s/l3OIOFaMD0ke7H+U6D947MjbW9XMFHN6Fp5wn5f3LCgd3qMAGzBcUmgUOTLoaxSgZehWw5FqH9MJA8oKGe/mUWt8H9tf+j99/aa8avzyumWF6g12CWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfA3HD3vPbYnuaPynIGdv49fxPzaGT0OHYcd3J2qYJ0=;
 b=G7WlB58rVrhr8rLCaeidoTbqVOjt+cvi+loVZ8oq3yS4lQh20K2jXhVC9Fr/5NDBZvhz9e0CEPQydHL/QdbB9Sq/qyF3USkqCsqHYBbMjFJr6msQBBrIr9PsDoh0cEL8Wml2T5y7iQJLiZXeLnYVkUWP+omLNTE8tg5519myUad1kkf6cpiMXazl/4mEkiPH+UoNJen2+B6ihjjo+cmeVlnwTi6l0NRYnu+Vw8hriprHHv72D9hxFDD38fIYNJ3AcIHr23qJaSuSiPa+Z2Gp+jPvdZ3O3HJGvy3RQvObnuzh/4PJwaHiv7Hsdv0hHY9c2YNTMf8ynkBqSVI5uzdTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6896.namprd11.prod.outlook.com (2603:10b6:806:2bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 17:14:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:14:05 +0000
Date: Tue, 30 Apr 2024 10:14:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 6/7] ACPI/NUMA: Add log messages for memory ranges
 found in CEDT
Message-ID: <663126da389b7_10c2129445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-7-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-7-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e57431-65d6-4dac-3919-08dc6938f030
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zHOYgjdEggkn6HAGxbKe97avPL39ctCTnWcyZQB47ItXkRLGDWQCAqKFQVjW?=
 =?us-ascii?Q?uyXyNRo6I4oa6m5QKr+3lKqpVwn+jrAJtyXXwN68NCqzt1ibk+iDxrUsDqc2?=
 =?us-ascii?Q?pLHvIpfxaFj0dWPqOIWCArS87BWgEgl+UwrKkhULA6rJ9tlRfT2MIuV6Vrxl?=
 =?us-ascii?Q?rkjUmoxr3iHTLYVbi904emtBJSS4QSYozD+USuJIKl7yFPKtDGpC/o8LQVj4?=
 =?us-ascii?Q?T9OhhWn7kZuk1sMa2x0u3AyXsgBXszPJZipgsLWyKCp5HhfTq235/sj7kfeJ?=
 =?us-ascii?Q?W7Sbm78RUInzPkWJRyQIGriQ/I8xaE9r5HHRZpCdhKwK3CA+0uDC+GjdNrgz?=
 =?us-ascii?Q?F1raDhc5yGCFkpmL7P3eiGsT/xeLY4aD47ZhINIFxaMD2t/v5aBwMVv1Gbfp?=
 =?us-ascii?Q?U2HvnFMQNxPXTDkhCS20Cw4GqOnuUkjJ5DL3BE7SKQGhMpr73aZSU6r3YI0J?=
 =?us-ascii?Q?vxN2tUySrEuKfM586iVh/slnZ/Rs7Pr0ptDKRcbSySkJ+isRcHQAdEZDVe0h?=
 =?us-ascii?Q?/oR6GGLif4+TF+1Lqhm80XBkwQcQuTv/TsJ6ByyVkgYuQ2OSVhoexnQZVylM?=
 =?us-ascii?Q?Eg2Tajk34QjKHK/cZuNxOfxKh/IVXD/czQuN7wvUHXgCzTGgFzgBVqwpE1lQ?=
 =?us-ascii?Q?35EDjFpmQZZnxYFW09bk2sk9hQUa+UCcbw1EWZBDLF7jp6iCJhdCgFI+ztRB?=
 =?us-ascii?Q?QYEFnnbjEV2Dl91kW+yajeF1ZN/CAMOCh8ROJK1UXoYrUgywjtjygHF/5mRD?=
 =?us-ascii?Q?QCMlWXwP1K/neZGrkdY5DfO+R9L3XmKKsrQHcYzLVdKOczqLkafNVwk9dLip?=
 =?us-ascii?Q?dNoGrIb/dHVlUdhIMUnEDiu5EOUs1jle6/3q+QsxzESTyQt4j1GvoyMLj/rJ?=
 =?us-ascii?Q?OplmM2+r/KJfQjDvV8ssOcIGSmN14D8HBGwYpsN4a8BjMFZKXxxcwabWDAYU?=
 =?us-ascii?Q?b7vM0VWR8Bd3uPmOy4DBvp0JsLB/dbyzdX53xevcM8wrA1Jw/qPqWhgQ4AIA?=
 =?us-ascii?Q?B1wW7ebZlRHU06owFpV46oCblFuXjDB2D5R1Fmre/ILHwT0hbIRedab1lqw4?=
 =?us-ascii?Q?JLGKdjFVW4QzPVAmxyVr7xwu4ZeVDFVxVQdkWgtkYxklwbqtPrbBaEt9Gvmm?=
 =?us-ascii?Q?1tKVL3oImNjwghcy3EWiAECr2OZd1tebQGA5/0HS1r0d9T7p/jE6zxsHg3um?=
 =?us-ascii?Q?UzI1s0L68Fa67b/6lB14WeT5f5VKRkWX7AsOx2SkHAFwUZGk6Bp5s5HAANgA?=
 =?us-ascii?Q?bRnByveUKz13JCtxG09KHKjeeQNhepwltdc6eGAZfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ZkARnB0rx4ZTRcpm1uBoS9H6Puooo2GllqKoaW1FTyd5pH2+ybd8JpMbrcf?=
 =?us-ascii?Q?q00a10DcBFNTxQXS4r/BvmZ9YbQcl9f1FdOdKCP7v3pva7rb73imkTl2Plck?=
 =?us-ascii?Q?v4spX7/OphNgVXPUu+7zwIwTMZm8W1CVUcIlVWMrPTAqdAR+eZJff8POioXJ?=
 =?us-ascii?Q?8RvI2kIDfd8IWelEd5lcQcGEdIyPDpItfb0ecRb1ItT5U6zejZNJfgJca/67?=
 =?us-ascii?Q?iwGo2rYrW12CYEOqvMwXpJ8QC+KEDSwIi2U5g2bizD8LX6e49fWGUrZjy9qu?=
 =?us-ascii?Q?3RkdEC5+IRc8FJl1xa8pdQ94jE3XZzjSEIkUPDr71W0y/vC+REem0Lxthumx?=
 =?us-ascii?Q?0guSqnWUuWSinV21KktZkSSS29f30QuzA+ph48cs7WmwmER478hkm4u+etOD?=
 =?us-ascii?Q?YjcR7EnDCEfAr2nppSNy30fY7+v8jJBvgLgI4oEL0p32iOv/rC8JV1jdBOag?=
 =?us-ascii?Q?kMPAYaQPZgH1tzj0hRMx76/hBRqZ4pruYOz0O+yxzpW/UbIQBZJpOJKFwGdA?=
 =?us-ascii?Q?4eIM9srjHHQSw9ykQdGvEYabcRcBCvhpMdUAZEgpXAxvp7hRe/G1EhoceLeK?=
 =?us-ascii?Q?D3Gd5uTI8e13UYaKH9mrXYkL0hbFfkfriCxAPC6hjBXOvLJyWd8xxoSUxwYv?=
 =?us-ascii?Q?+AjwsJkaSTG6rPYwDU7+da1wphqmwGRaLCqgl1Og1qE0pOP1y1wAYJ/jCJ63?=
 =?us-ascii?Q?Vijeg52zG3rtQYVDTTTU1aLdPalGv4vKAp6KOxLs3jeHky0unEtC/lT6Vqt9?=
 =?us-ascii?Q?ReqTqn2kB1Nh8tVUlN6re8eckOpfJwNoUMdxdTbgRbp/9yeiz+XuGUXetZdm?=
 =?us-ascii?Q?yr1V8JhUGr1dokwcSMw5l4FKpHqCt08z7vgfdy1yb6QcMnzRbNHsofb7Tnef?=
 =?us-ascii?Q?4qFTHGekUJu2chyT8sQ3fwXmiS0Z+UBq7jQnh2js/p0jSwAd7OUYxZEhm3pE?=
 =?us-ascii?Q?hVdYxyWBhBw5I2iBG6UuFQP0p6QpfxbfDKnguv3CW3FaXDfBB6sKzqCxZxc9?=
 =?us-ascii?Q?8O54NYYIbHFs3qbXK9CRe1yo6qA31FRpc8RiUWWFrNNo1DB0vDFKiD3QYPXg?=
 =?us-ascii?Q?cgGNcJ86vfnnl39DSwDz2fqCcCXH8PLqY9Fp6YSaSNC8A950WUTUOwK2fDt/?=
 =?us-ascii?Q?aGwpdQZX3y3V+/KzW5pzTHHEK2YAnN1yLITRVwIx2QogMXCcfYGfR03URy6I?=
 =?us-ascii?Q?1gifShlgLzcYPZhgerk0sEC9pKNWNBb5RRURjMRF979JF9D5gyvBo+dMU9GY?=
 =?us-ascii?Q?JfivHM1+SOACgTNmvgpjuXNWwy3okURQ0IHewtG3fyu/EIv/9InqmNw7D8pr?=
 =?us-ascii?Q?Citb8tPhI9KYSxetvJqpWLuJi1gGs5/bsqoC+5oEcszcAp1myo8g1OtosPj0?=
 =?us-ascii?Q?oTH9YqiP/vQw1F0PLFSwTiWr0lH0kPHNu8/jvyXz4GDJ3xFRPeJAAZ6XgdC/?=
 =?us-ascii?Q?u99Ft9w41BOlIGHkY5vYx1lkgouBU12roVCGDVhmm1eCLB5xHzkwt/XYpVLB?=
 =?us-ascii?Q?yakYQzebqhZxso99ssE6teSwjEQcoFfOHHiDu2HhZ96JjFTiGFR81790oETY?=
 =?us-ascii?Q?KzzO2gkypdTx37LxH3gkCk2yr+oO7jfvL4xrWDU1QGs+0EAoxYpr93+3Kj3P?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e57431-65d6-4dac-3919-08dc6938f030
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:14:04.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A42qgUZ/G0l1EAEKagSOeEkAdUnK7fWQKzW9DOuzw01lYyRPOC5B72RXBZj7a+OiocmBB55MOgEsRTcPb5xIv73p36k5/b3lhW9kxFd6iVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6896
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Adding a pr_info() when successfully adding a CFMWS memory range.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 76b39a6d3aef..34ecf2dc912f 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -339,8 +339,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	 * window.
>  	 */
>  	modified = numa_fill_memblks(start, end);
> -	if (modified != NUMA_NO_MEMBLK)
> +	if (modified != NUMA_NO_MEMBLK) {
> +		if (modified)
> +			pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> +				(unsigned long long) start, (unsigned long long) end - 1);

This one still feels too verbose to me, can it not be gleaned from other
startup messages?

