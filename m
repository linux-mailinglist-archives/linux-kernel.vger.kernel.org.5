Return-Path: <linux-kernel+bounces-167873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0488BB095
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBECB1F223DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30915533E;
	Fri,  3 May 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gG4PVeWf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4523749;
	Fri,  3 May 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752571; cv=fail; b=pNw5cs6fih30Aat658V1+BNrDZONHFI06Ystc73j070MZg+l8+UOx65oqFbHc4+sBBp29OYX1EMVisSyoAyd3IWEzt6A2NPYsNEd+7C5o2BIk5O40VkOWcfvL51+WFkMS5QrtsG05ZZjZT2eFsiqbIOzt78eJahZcbzpBmM4bT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752571; c=relaxed/simple;
	bh=diWg98s18EYgLpKvYqLHxT7ll7v2Sj+rXsjY5CqIqMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q9rzCzQrfa/l5gWaPusyYV+V4YxTFdAM6bKnaZ2EwUMT3dDyloYxPZT/KLAu3aCrPuRGic+0V+Z8TwdHfQyZkhwyCLx2ZaADkascyaU46GBA0PWAeb1PEEO71UGcvegSOJhMpEyU6inJOCZGB39nUPCrcYcO+V9Lzze8mAryOd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gG4PVeWf; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714752569; x=1746288569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=diWg98s18EYgLpKvYqLHxT7ll7v2Sj+rXsjY5CqIqMA=;
  b=gG4PVeWfl7azRxJj+OzFtoo3LOFFFvcG3ML44aVNRZER0uezd/oK8RCc
   f9zM/8B4ootbeWL6ZqOIEinDdhsw5GYa1kC5M04Uqv97Ceoafexz4mWrT
   x8C5npV7VWTn/NQD58F6GTEFlcYH2FAGYy7UlbL853F+1MQhzpoEzUTiP
   G74DaeT7ia79+AoDQV4HNnqYUjy4dTzbrm5Qkq1tIJKW2+VKA8lI35/rO
   6o0ns4mN80WpL5om1Y0DDHJQjibtFY3Cg4pkSUlp1EHOhRoAprczJ65dA
   bNc+Qum8okr2O5ynwEhjfUTVOn//AUXFLsgGrtrGJb/mMNOH+afpVOTJt
   w==;
X-CSE-ConnectionGUID: 2KmCR5VcTBiiAmqnQ1xJXg==
X-CSE-MsgGUID: dxe53LGXSyOXMZglldLUag==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21118041"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21118041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:07:24 -0700
X-CSE-ConnectionGUID: JPsUjQ0vQni4OAj/IyWhhA==
X-CSE-MsgGUID: erNj247fQXKy91ExW84SLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28080368"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 09:07:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 09:07:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 09:07:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 09:07:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 09:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CItp4GtLC+u62H55PU3alWNU9ZjwIyMldp0FKLD2GEKCzU+N2iBcLC1U1ZMtVyU51s0K06PmfQ36zoGqJKEAwt4K1d//p/H3/eP6WYkDYY5AXtMZ31VNJan9tzeEIJAzqIY1xowcZS3RJIu6uRKCu4HN3IL555FAcfdp4Lm22glQfPgdT6ILyRyiCM3YepFoJxgWdjIBBfuD1mRHlxE667J3g15EuOwNT45ZRTuWBQQlmyDBkcuS+CXY2Zj1Lc4SGeeApTv0NeacaGEf54KHTuVbt1so2TP518qjx2p/kQC96XF2cQdgIVdhkpttubocJxewStYe0SyaqCSyJveQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a382vT4kUIRZppjReTd2uNIbYY0J/cWdmKC01vgEifg=;
 b=cfCd6Z+W93RYJwLpef4VyZWvW3Y2N6hLzFCgJqd5hE/Jz0bINxhQpXG1yigcxjkpBjuWi7Gj/gHJwBu7IkQ3yWxLVj9TecirTz6lfplCbLkvIICxzXLjfb4KmkOed/BTihZ7OcEUobjEm6iXSxgJIH/N/QZqrRAT80CchBfUpUVdysVYu0Ij8uIWJHT6yyxMKBS4roHzSWeLC6K6k6C0/tbGoC9RvTDkvIYltFWchL4v4E3AG9BZNqgNOkL9r2G6duriFkvxrLa5H8IHxiPWieSgT/RPNnNljTkwSi/vo1konxfSETgTVP59DrmcQJpeGSmHZSqx7pI1MOi3lWTEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 16:07:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 16:07:16 +0000
Date: Fri, 3 May 2024 09:07:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Ira Weiny
	<ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Message-ID: <66350bb1d3817_1aefb294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240428053715.327444-1-lizhijian@fujitsu.com>
 <662fc9659f6ab_19ca3929435@iweiny-mobl.notmuch>
 <TY1PR01MB1562E0A5EA4F95FFE0F39602A51F2@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1562E0A5EA4F95FFE0F39602A51F2@TY1PR01MB1562.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 0550dacc-14ef-41ef-4d1f-08dc6b8b1a17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+c7qp/8qpO9G7G5dOcEqDMcfF8ArEcRHCjfkAEZaPgZOrvpXTg+66Hlaiw/7?=
 =?us-ascii?Q?3Eszh0PUMR8HHyL12hnwBRcP7nc4E7ENN5FHsVGtgr+6VZldJbuY2mWgUeoH?=
 =?us-ascii?Q?wrD82SQfJTta07HAWN360XdmLbmYT7mD3Rq1J6NcAkP4BvwIZcClFPuPJtlV?=
 =?us-ascii?Q?moFBdTGJs2o0UHfIQOrzEtEWHOJrYptFW7WTDFy3m0nrme3pZ2uFBvGeKJMF?=
 =?us-ascii?Q?tBNt+MkpZOGtERraOghEAyGCJnpevdbfi34dcCNgwDqfVlDrJhaSAgCRfL74?=
 =?us-ascii?Q?Ofk2/B8pCWmjPsTOB3Dbm711tcvdkuwyZiN7RRvBnUtars45yv0C1SPTj6Uh?=
 =?us-ascii?Q?VmijCBuH22GE6P4XXqQQbGj5TSRtXluQmnXhigHn2DZDZndlW6WyQzen9ISA?=
 =?us-ascii?Q?9H0d+GxiMHyKc1rSuyp3KBeEK9U5ojqDE206XdHp01to8gzku0XLz3F1BR4S?=
 =?us-ascii?Q?QHZEsMI2wLVYvsi+Mhr9sXclPa6kvP5UgmP6GWBD31/TaO27SzuFtngDupNQ?=
 =?us-ascii?Q?xN1+ZHdnPfZ0k81u3/3qcQUeEeIzk0fnQhldjuYcEIu6n3Td76DruIgVRwcL?=
 =?us-ascii?Q?i3lI3pt7VrXEecMXE2c/eymL4zwYh57aggPlEk2HoRlof3KQdvW7VJKGtKID?=
 =?us-ascii?Q?+kJ3pNanKe9Sd6H8XvAWBVpA/iMJC91WzW5Y0WHnwoq1ZfVDdLxKPdjevQI3?=
 =?us-ascii?Q?GA1lyb1sIHACKd83lnJUqx89gKboeipEdHKSIvHAl9F+OGgW3YPHJmekOzhC?=
 =?us-ascii?Q?apNWUmWCmzH2oP6QEiE/lYsxt5Nf8VsD096v1En2mfX8xXCQu/9e4Ci0XnLp?=
 =?us-ascii?Q?NFCd6Btw48SQ0cB+rg3U5U6mMUoq/mvf5c26Ms1foN8ujuO9Q3noM/X6nQSk?=
 =?us-ascii?Q?NsuW1yK/Hou0CYRJWXp39zGXbuTIF8FgRgcwySAn/BWFxFhwhKNmOE+GaAfc?=
 =?us-ascii?Q?XeRTeyG0KYreuhpF6we3f08+VnTD//kSw8mZMLIrhFPCgvwPnsbG+YjFzl6d?=
 =?us-ascii?Q?yiN84SZiv2sKe4cHyGDcmPU5ptj6kGVnei49IMORs0QVWEGOrB6BQynKMEz3?=
 =?us-ascii?Q?JlXpq0I06HmYSLglSCl+5alrW7MYFzKT7+4A54ypc40aWHvAXgyJ13+RRzTF?=
 =?us-ascii?Q?D7zid/8cbY+8oGd9/4jo0idVWGEv+MnRDT3MWfMMXM3iNcxFrigbqzNahKd/?=
 =?us-ascii?Q?XigbkBsiuB2CNQBPi4Zbs4ooAIxhTgttauWfo5TrgpRjLfoOJ5uMjOUI7UTe?=
 =?us-ascii?Q?ASiW7FRlsGA4Imr1yHNG839JX+DFUSQLXAV2V2WPdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrtCAGOCYG8aPnYAhHRdyU65+sz3Ci4+fPrJig1CYq5gX7dndUwM1IG/uMbX?=
 =?us-ascii?Q?Q0ixLyDWjXCgqKtApuiC9xad+m3ZlUfDhIFi8sabAxHIWuEP7aT8NBEZdb3z?=
 =?us-ascii?Q?i/ASLHSA6KMeh6mEHjvmI+aT9ajqKXuVfbpmCxDUnbYJ7k5ucXoUz7Qa4SkE?=
 =?us-ascii?Q?PHABb7jceeESRk1ukd0wfES/LzSvesImM0g1w8Ol2yHDbQmuAMYb2JcS5KYR?=
 =?us-ascii?Q?MoP44Z01jAkcMBNg4t+P+Q565k1DY1bvfX4Ob5EPqkCpQhHjbvOPWWIo78eh?=
 =?us-ascii?Q?vNlfP9i28rWeomDgrn03P/IKWNiauW72EBxpXDDGMf8poQyheukyePnoHNWS?=
 =?us-ascii?Q?UrhLL67Ssi/PBfI9CeMonGl4/OsksNP4MQt7Ow9aBZPL3kR6AxYnHxMg7Ia9?=
 =?us-ascii?Q?kiZ0XmjY2CWYzm0bWjPgOPGbZu6toc5/3zUWZcnZc1sdCbE+UsJhgrcp3Gra?=
 =?us-ascii?Q?a9xQN3WSwvLgCmy7N3nYPiXPnZcVk1c3Rs5WcLtzGB2UUpmrRWN4RChlNI14?=
 =?us-ascii?Q?u3czWaeJJT9z4a0NRS289DYcGdGPvjcBJmDZI1+9Za0wIZmTxStI0WpaIZDO?=
 =?us-ascii?Q?y+reXg/EwmwKZlSNhqI1G3rJjId47eGEv03DCqjkjrbpTnUko0LCZ02W5bLM?=
 =?us-ascii?Q?WkxOYSAyTC4JCRxXmLgU7wnZl+ZGE50dxDXjgeJnQsPMoiEN4xlJReSS0aJL?=
 =?us-ascii?Q?eQDlEaw6lTrw1W3f6LD0zycgJd+WfJRpks3SJZlyRx+O3GFXEKyZTc9irNgN?=
 =?us-ascii?Q?cJhLV0TqxRQIn2en9DBDEx+DDR42MtoAAm+5rvos0Sk/brETjZCXgETN7Ly9?=
 =?us-ascii?Q?VnUJ3nWtpVM/nS/UrklWse6FFsssdf4argc/RIXOn4F72g8qVZPgLwGQWlZJ?=
 =?us-ascii?Q?Vz9kZr7PI+Sbp882mtordH9Gtl8fSkAe6aYIIJ2B9kL2OyqQKwojPdfVGx/5?=
 =?us-ascii?Q?4HS59MSItuX4JRC8O3oBZ3J/xeFWJSliwcnMs3EXOqFjndqikcvxSqmjYmSz?=
 =?us-ascii?Q?v5xGaEL/zrUnwkFtpNolvaPNrSDxTy/Zef0mQrUz1IdT4ARaSGIcCCkNWrmF?=
 =?us-ascii?Q?p+KludYPWd1zGfWVMJOZm5I49IvJY+rzFHm8hfx4/MdqKlEdu2oqpWt0Dex5?=
 =?us-ascii?Q?w7YkyBI6kzjbBns/SkL8++jlV6t8LGt2ZE0i2G3Zmyq6vjC8PwJp7fzRry7u?=
 =?us-ascii?Q?qXD+PmE8igW5Y47ys3J7VOPybeQ1Ys5/hogpT02U/oZ2eMkdcNreSC3xWP7G?=
 =?us-ascii?Q?a+zE3Owl3KLEAvo+go3x3N3pam/67sGBOf4/zKA8L/4iUmyMNl15l0mJHcFm?=
 =?us-ascii?Q?iKPmadNZrj4+3ZBqaGqAikxsbax9pgTLMOMTpPlFTAnTDzgn86PiSABORPuj?=
 =?us-ascii?Q?x08PtBpIHyY1VWLcLOxECubX0CE42tMD6BadXb1OJMmM/dWtTveF652uOV2a?=
 =?us-ascii?Q?66lXsuTSwEz6ulNPv0ICvIccQWNM85X4ux081AK9aL/qBIV2G7oieBrvGond?=
 =?us-ascii?Q?YPtb5HaifMlDmCjYVrc5SD3Ll72cR4jt68FUJJLxUz5F4kOm1BC2ChUQ8SKT?=
 =?us-ascii?Q?DbE5hK0FWRUCTioy1rl6npJN6p9ODWgauws2DJRBmKgq94aCwG3Ny8DwVJgB?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0550dacc-14ef-41ef-4d1f-08dc6b8b1a17
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 16:07:16.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuKpdOjtCBriN5YabzlSCwk86Bz/UtGQQf5PvTJqtzTfaOiQvSVunTErbkEZSSopIwDiUQqT1Qw3qNyRTiWf8V6fnP8VMsFwc2fmrBCocqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> > I'm not following what the problem is you are trying to fix.  This seems
> > like it just moves the memregion_free() around a bit but the logic is the
> > same.
> 
> This patch not only memregion_free(id) out of cxl_region_alloc() but
> also add an  extra memregion_free(id) in EINVAL case which led to a
> memory leak previously
> 

I think I would prefer to just eliminate that failure case, something
like:

-- >8 --
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..95ba32f8649c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2352,15 +2352,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
        struct device *dev;
        int rc;
 
-       switch (mode) {
-       case CXL_DECODER_RAM:
-       case CXL_DECODER_PMEM:
-               break;
-       default:
-               dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
-               return ERR_PTR(-EINVAL);
-       }
-
        cxlr = cxl_region_alloc(cxlrd, id);
        if (IS_ERR(cxlr))
                return cxlr;
@@ -2415,6 +2406,15 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 {
        int rc;
 
+       switch (mode) {
+       case CXL_DECODER_RAM:
+       case CXL_DECODER_PMEM:
+               break;
+       default:
+               dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
+               return ERR_PTR(-EINVAL);
+       }
+
        rc = memregion_alloc(GFP_KERNEL);
        if (rc < 0)
                return ERR_PTR(rc);

