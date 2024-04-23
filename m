Return-Path: <linux-kernel+bounces-154427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A208ADBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75241F21E42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C427F1C69C;
	Tue, 23 Apr 2024 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVUErhMB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716501C2A1;
	Tue, 23 Apr 2024 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839395; cv=fail; b=HN/860uHoRaI93e6hQ9oiVG9q9nFipmyHZjjmK8RMWqsyOHpn4m22LPSYdVSlSJzOIwm6BU4OybIix3tIH+obUkhW6OWckzmApE0LOiJFm0QoYNj0ir21tbC/gQouIT68NMEfst0w0bFauaZqlHgX6iYDy0f+AvqCXWZzN3ujX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839395; c=relaxed/simple;
	bh=2aQr5dwLWQY1Twr7/QCfwoOK+9xnusLZQbRr/rj/754=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RsMPgxA/oqC4p8uo9kBP+XhikvGyzx+M8QpwgbesJxEMqah6PWTOIFuHRpchYrMQTQbqVvf1+UPqOEyuccrTw6utbZlSCDSXyJrK3Y/paV9tLlTdFjXwSFacLRdMF7VTOp8XGLcDiUeBtCNK18TCoBdgWJCGJ1yonqGnu86SKeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVUErhMB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713839394; x=1745375394;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2aQr5dwLWQY1Twr7/QCfwoOK+9xnusLZQbRr/rj/754=;
  b=ZVUErhMB0Bqaq5UvBJtlzYdMtFi3Ma8xz0YvAZbH/BkiBuidhOEnkSHz
   fLA8ukRL9JrLBI6CenpEmY6uZdL8z6LFhd9BIPdlDYYa62oeZB+BljDWe
   mGiFBFYvJZc1ACay7QyzPrjXG6mH5nlNCk6V2RR+iUNZZPc05oEZ1b8Cq
   v9VwQ0VwHDfJSGigWTg6fnT9YpLpsDsoQc+7J8v4FZ13PPjrSQ92b/dz+
   uYPVMPImLcBQjjmQHUXw8yr57W/0kP5Pe4pNj4cD6QLVGkCSc8Up91nLh
   MsO8iLlpCr0YH45OwWlXETpWMKxeVKdHla8ZVdDKFlUWRs6awxERwcwU4
   g==;
X-CSE-ConnectionGUID: 4wsPPD3CRWSNuDpRkvEb1A==
X-CSE-MsgGUID: WWG77tqGSiON/Dv7ALBa2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9235836"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9235836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:29:51 -0700
X-CSE-ConnectionGUID: urzzaeshQzGX73aDg6wDsQ==
X-CSE-MsgGUID: R8xyZyPAT82xO8SYN9bewg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28727712"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 19:29:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:29:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 19:29:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 19:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/FQpkRL/Z5DP4Ym5rEvkCP/1OVE2dcZhUVOZmGDM0DicwhtU940nSxUzMRz4szWuRlmmSauwxQYgpFmyZDloqUK6edJ9GfQ/slIji0BKKqm7UVvDzOtnywXAFtJy0f8CwOnAbkPhDkSWzDRBnuMejlPSyvI2AnI1wSZKVCIpobXvevq6GyATixaI1khnTy12xr757ornMZYWyGanX3fp+WqH5hG7YVy8iiTC9ADHu4JjSOgn0QKKclOKqlQ6QSWgQaN5Hz1KyvRfLpFYXUsm2Vzs4j5LMAihnFzR9fb1UYD00hVJ9YtldIjRene6vJVZlD5J9ztSOPNYs7//g+9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zatvSwt5VaJyA8NBYOSii07km0jcVsNJwII9pYcaCcA=;
 b=HfP9XspodG0PWjK5cuAXpd6dCYlNTU0PEdJ1L6qAQFiYCFh4WlRRERdW2Ym3LHu2TDEDzRAwGbLdAv/hqjJPVoedW+npqK7iqgHlDn8uT5fv+pAoztobSbCCgX+vsZhRwFWgWjUR8WjkFa4WQP+gu1cnw9V5uUAEYZbMv1aqHRYj7NqyErcijxZfgZevyYl6dCsyOyNKGQxbQ4die460l3ZvnI0BvHhhTm0TKL4XAZO7J+Sqx0e6MxxyHZ0F8gj0G+T/wSrpEJe98Fjoxfi6WriUwjm9JTzlbDXlsOHNgo3EUmr1xU+Sh3f/D4m4slH2vF8gytEjYlLVu+hiT2W2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6872.namprd11.prod.outlook.com (2603:10b6:806:2b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 02:29:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 02:29:42 +0000
Date: Mon, 22 Apr 2024 19:29:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "kernel test
 robot" <oliver.sang@intel.com>, Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v3 5/5] ACPI/NUMA: Squash
 acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Message-ID: <66271d14606fc_691029447@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-6-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:303:84::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f51d36-4d2c-4cb0-52d9-08dc633d3bd5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KtjbqAy/W/6Zexi0r4Jw5Hs1j6cH828DUCLFjJ7cvlcEdxzMgQhHtbpMkAg7?=
 =?us-ascii?Q?xeH6ePQPRS7stwUSho4stZu+mmk2sbl3log7LbgpXCLBVEftGd+0cLixG+Fd?=
 =?us-ascii?Q?DnMiergLyjle83LjbG/cXwIFHwcqBXALxlygHeHonMd9zhALYF5tmbDNZ/01?=
 =?us-ascii?Q?RkOSSCQjjURN9kc5Cp2R7FsMh+pjt9ZMmf+/sr3zUTBJnPaEUXvqQImThiQD?=
 =?us-ascii?Q?2+Hkn/HdfowdUKKPdFm4UzXuZl9kgteHCTqEd25AlmQqXbwiy1BRVyLlGgmW?=
 =?us-ascii?Q?raZdoWJP/pTh0gsdoKtDgh3NK5HAHLOBWTknA1OHpEiKpYOxnhM7yrFQ3/V8?=
 =?us-ascii?Q?ewoDvypV142wIgyzqlRa+N95qI2HporTOUKP3KJmfaBjW+/xjnKwfbz7PgxA?=
 =?us-ascii?Q?GTxgiHPW3Z4ReWYT56JRVBbghVDAwtK9CZfwbfFz7Gz8ETcxPrAJrIPGmP7r?=
 =?us-ascii?Q?YdQD1lNgnhD2GdtW/EBBaSXQmFEPq4DlRCEfBctAcVLmReAM9R/RmsjAZDyj?=
 =?us-ascii?Q?ouLprF09QpYeRzDDqIMC6Y4UgwrcCV9ODirRqlzP3vMGjlyidZ58Fps1V3eq?=
 =?us-ascii?Q?kLSc4YKHnoczthX71/Hf26LLAmAk3UeaYw8J8wy9Rj4+G+ZOPkJudaukmdA7?=
 =?us-ascii?Q?oRwYXigL6DzH+AEE1nYLzzbW5cL3x6yl5Ep8R9tGygvqCmj/LseBhJz82q/h?=
 =?us-ascii?Q?26oHqAulJJqbvz1QgZDkPEmcjzLSNWIOyPgjyi3ctPLEIHq8PqUfthRv0vp0?=
 =?us-ascii?Q?sn6qt9b7k+Yt8hct2UFy8NLWdFAUmeofYSaZ0kfWRLuH3hNdzdvFtFF2A1At?=
 =?us-ascii?Q?3RVCb1BmbmoFL93qDKGvrlS270q9C4xwZ5xVdnGsKbsjFyWvonVOzi84qf0b?=
 =?us-ascii?Q?qVxEbyYLWHhuPz7i5F9xYnwKH/tn8L9BmxtqVuqzLITtHIJ2w9/U/QFrvBDT?=
 =?us-ascii?Q?tSue5bqXY+rMXYP3v26UFlMbRDP1Cuqdr0cs1hxZG6pvx5wo8UuDyLnxQAfS?=
 =?us-ascii?Q?CBjB/AVAcLuCCjf8TAL1KRBoYmh4f19q0EUimbAMUN6wFNPpAhwWJORaQw5v?=
 =?us-ascii?Q?4WzuusB/51U8zUU7+i9Xj+2EnVfmMrGmNvt+cUUpTMZn/wWNSKNu9Ulh93RV?=
 =?us-ascii?Q?fix25hag91Jc2f3GYEwFm/Lh36OATKnlyuCs29pMB+eORS8LVGsyIwx21kkk?=
 =?us-ascii?Q?SXhlIxPvCrnnGLVQ3FpLItVyn5gWNyjryhvR86tYl84R09wIHDHnZ6PyekVH?=
 =?us-ascii?Q?QyYjH/cj1vFqv6y6AYPnK/dRMgyAGXjFUvzHzLhwJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWNyGjpNTEJw6kRVN5ZFjB71vPsjDzNx+hinmauHzcO4o6Odqu7jau7ePNql?=
 =?us-ascii?Q?c9PwBy2lUGuZGsxqWjnTTHRnjJduel8hny/lxRMltyxli+mriEIy4zA953hR?=
 =?us-ascii?Q?KWXQrF9LOOguWxganFzEbZawR7g4dW0ddoXQ1buxNy6GJ/ViANRxsiIWZhuH?=
 =?us-ascii?Q?TWLTr9i9ipPzsnFVsYqlrnzQR0os3rKmtceGM18f0oLeEWTPCoC3MW5YQ+fh?=
 =?us-ascii?Q?7RAFm3OEacjiAsChmyaTLqaaGgfOgndViB4nq6hAbrzfFXR5CmvM6oaNUi41?=
 =?us-ascii?Q?RJTUVUYk+6O+UJqKrN4VfdrmwYaCVLJ/4wH8ZmltH0atoGlnxab6LNT/y7HT?=
 =?us-ascii?Q?p1NwC/cTVrhlCbTTTD24wV6/4HDb9psr8hytpTUIQq+Xp+7V796TZMeOn8q+?=
 =?us-ascii?Q?kqQypDEl2PvFCuY9OCSH3f0/EcF0lp4cC2xOrYzR1rXJWJKrLhFklQS2nTcy?=
 =?us-ascii?Q?oOmB2eNwv1G2ozegqNk6ANQ1e6LWsV7i2gZcoJx2aFwFWcSraCGZtCOCpCts?=
 =?us-ascii?Q?uCyMDeASIggDmtErIT2b+FR+xZEk1HWX7/IOtLFlDp5VGkFKfSFdUWVl2NMQ?=
 =?us-ascii?Q?Znx4RtRTnbVtzRu9AZ+cS+xMSCykI8iiSV7TBquj5zsyhriw36bxrz0xYlYx?=
 =?us-ascii?Q?WoRl9jShsVkaLlhAQvBFr5MrbvHUFgmRauY+Wd6Gcg7jGK92WhVf0Cmrn3kU?=
 =?us-ascii?Q?ZWGljv7sgB3F8Exe7M04AjjRbeQc0vApg/tUowlakH3QD7A386hTWGzp3+S9?=
 =?us-ascii?Q?UpYvlXv7qwqCbwqOJSnvkMTvn6XuY2KuHHtkGes3tH4iYOLEKQct5pu8koy3?=
 =?us-ascii?Q?zzxT3HvoZu2vWVoLRsMQp/I+NqWc9go0SzGKcinxFR35aO/LfRZS1eOiFDgY?=
 =?us-ascii?Q?FvQNS51hSXvwpepcvWNZn4iwFF9CE+bPnQthxPMXwNUXkT23mIWkIxVRI4jY?=
 =?us-ascii?Q?cM05I4MQGxwwxWPPT1BvBRUR8+Atr+XlvoHRcHWrWDDkGQiIFTWKZTPL6aQt?=
 =?us-ascii?Q?jgvDKzJTfc/yJ7dDR13Dvaxe9CBM4IMfDlo6MR84ztavk8kYROL5YoIn64he?=
 =?us-ascii?Q?vcAmH3vTwoHMRcu1CU308tqn1FnwyKugmGhpXW7ieeijXuHRgZsxI27EbmAK?=
 =?us-ascii?Q?Xc+aejFRhR/JP9iP8QwmaeBWZwOOLZL68GRHieQp/N/J3yxWe+KW9K0ZrlEH?=
 =?us-ascii?Q?f7OYg8q3UQgeMXO3MlKr5iBe2vlNljoUswjQhNT93HRJEGFWrvFNox96RppX?=
 =?us-ascii?Q?SFC/w/PXNvLnR5U4BoJ4cq0R16U41zcl/MUrIMpMI+6JImJqiPj6YR37QrIz?=
 =?us-ascii?Q?AMFWzBgOLDsaRUwl/TPlb2S/0MmCB1W2BXCV5Ntf49q+BdKaECBiczytArZX?=
 =?us-ascii?Q?R5J/GOkVqzS18CnmhcMo/+eKwxtKFX41Rduz7Ub8gATXHGr+42/QTVfR2XHZ?=
 =?us-ascii?Q?6WMOyC+KWxpctkwugnuhrXv0gDt9qAAl3tAXuFWpQ4jTlazUjvw6otXhs16J?=
 =?us-ascii?Q?lWhKE/kxuM99BoVmKYNwnHDGcWDRYK7m3WdNYJFlxnpmjnmLq00pWSeplRSJ?=
 =?us-ascii?Q?9Qxq61NsoBsmJlZVuXBircgxiVjeDR1axAxrAVvlOzp7t5/iJzaqU34ULLOu?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f51d36-4d2c-4cb0-52d9-08dc633d3bd5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:29:42.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGH0zB1xOYs+6AkIMhNzy3ItYILKnKUUDhadpgVLiz5EmKmLD3t2mPPkN9MiBKR+0Yq8fw4ohZE9DGAj+MU+ILWayKaSm0zxeZNPpiraRfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6872
X-OriginatorOrg: intel.com

Robert Richter wrote:
> After removing architectural code the helper function
> acpi_numa_memory_affinity_init() is no longer needed. Squash it into
> acpi_parse_memory_affinity(). No functional changes intended.
> 
> While at it, fixing checkpatch complaints in code moved.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

