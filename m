Return-Path: <linux-kernel+bounces-154422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E651D8ADBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABB0B2199E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8817C6C;
	Tue, 23 Apr 2024 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5nl/TKa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59E1799D;
	Tue, 23 Apr 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839266; cv=fail; b=fWT/xX/fZaLccL3iUBlcGk6k2iSMRkcXIdU3slFa50pX2UgePvNhCW8zpG0kYxB0CssSH0v/bk13odNrcZlblNaxttlRJcf/dVm0F8FQNb86r82FYDnd/JUOnCXO0xBOBxQYfJazakqGfAO2ug3FKNcyoe05JOH7EJ8RWBdH5dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839266; c=relaxed/simple;
	bh=pU2zsGBaU0Pt7wvOfYT5xcP+3w/KHcMw21AJz9YYFuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tp/cerCE8//gdLc7Iji6YLiHq1Vm49hAO2OdQ8idfdw5j5ttD87fxNLMsfoRFd2c8/AXHkJQwq5Krss7aHu5hR7K2QaIagp/82e5qgCvqHNHfcep/ZwYFt91eHXdZH+d+ZPDvZn5aZ5y1yJhUZUWQUeYVLvIUGGzMW414VTRoM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5nl/TKa; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713839265; x=1745375265;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pU2zsGBaU0Pt7wvOfYT5xcP+3w/KHcMw21AJz9YYFuA=;
  b=L5nl/TKa3iGJSoJcpmZVXvB6A5jtOTkIqF8sRN0GR6n7XEvlafLDXpOh
   nkfSYXaf/M2ThoqqGdjKdXniXMfYEJwlnQdVZZyp0P104DypBnLefXaZ7
   pzhfqFog7B20oXWEF+eYjt4ibjnHHWOt5UVZYxSp6vXQTKIaZKcqrLbmr
   BL9vvsySvDpweW7sRCkTn+T6++wmC4pePdluVZgJT/PKRK80eFR/f2dP5
   UwIMXy7fITgq9gwx7HJmNylQCePPqHjP3Xga2xvIHyHedSJ36sknMAAW8
   U9AEK7R0ERw+RJW5W1i7b4+iFB9UZlYvkeq9So/JCf+BoLr2WBEtUUik5
   Q==;
X-CSE-ConnectionGUID: ikH36O3BSo6HAnzdc3xQ7g==
X-CSE-MsgGUID: vW+/5MmhSNOwsLmrl3ulNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9235691"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9235691"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:27:44 -0700
X-CSE-ConnectionGUID: 2KWb+s6QQj2SVskWGhvb+w==
X-CSE-MsgGUID: Sa9a20ogSDavGvcw5t0jWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28727396"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 19:27:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:27:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:27:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 19:27:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 19:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKVbOjxN1CS0+t3L9wKeYjCIK3kjpUg6/WJrxayT/XtHEg/gnPXtXQz2qjLnQCmSdyZUmiAqSuhiQXI5Tx/tVx0GtzcpeFTE41fG1j/M0irWVC9woZHFNVj9bZfJDmQidhoA3sK6oLtODpbv/JHKd02vrlp6p+UE0r1mrW5LdyBcGR8WtAXGdmBYdUsGTWLttp90x457Z+yWgnX+fsvLv/UYIHLhRYZU3lwmEU1bFaUfI50b5NNdgtxbVuFgOixXj8nB8uNiS1IB568xoHtcz21kUH6NPUShNHjHLmZqCUYxJwpC3UcVWrZoFZg+e3InKiJ4dSL1/ypTGkxqvdw63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuM+paoD3K4MnAywEMAgfyCyK4a0vNBlAR5qAvUeH08=;
 b=T8fD2DE3sejpr7BF5b2fCFxXDHHQweGeQMPyOwRxNZzVJQGlRIDaVqSUYDc+pmeiX0YtL8b9v7SqFZXiya5Qwfi/JGLthKGj8EM5q2OqRU7kmPNQtgdIY1ourHJduOTmOdGlcv9u2OxoVRtEIjwR0eTM6424Wdk49BLBMmiE8oanE6bl4sk260ZIK37hyLCHw2ISsv3dg/mkafgiS0nKQc/+VbsHvbKd2cbNdqHWrLMlnskx89sr/NaOc/4dMmkd+0CvNZyATM+mkrsk6dXNSMEptsJ5ODRa5V79vCZCWgMkUNb4WjaL5C3ui2ELBHW+ppKUPQF2VR/XAwGAsvkl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 02:27:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 02:27:40 +0000
Date: Mon, 22 Apr 2024 19:27:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: RE: [PATCH v3 3/5] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <66271c997b704_691029421@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-4-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 192fce44-0159-49df-b485-08dc633cf2ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MP2tR9PZlcnKLzGyWnXgVP2jST5iA4ui6FFhbNTiYSxvkE3fFBElmCTDXMtE?=
 =?us-ascii?Q?Oly+0+vZNxi+hUZKHCiheOREhDGIoY7qVTpOc+fopUuqyQhSYN1tochCRULc?=
 =?us-ascii?Q?gUXzx17F9/GDSCJoMnf7NsNiBLuBwyhoeb4unjrmL8YwZrQZdzdkcMvxLAAj?=
 =?us-ascii?Q?k8vtfPL3W6MDTZ5nw1ic2X6LtulziW9CAv5dIjs6NPBUm/lV+mukjNZbBLnY?=
 =?us-ascii?Q?6Z3l4wKAI9o+7h1IGoW9RE72O1AKOJEuPZ22mMiliFY8I8UFMGQWc3d0WaFw?=
 =?us-ascii?Q?u6LLb7/cpw6uoygvS4vunEzd7mh2zPzh+JXTUFjHTPrV8ENn0Y8TXGFSzJKU?=
 =?us-ascii?Q?fd1D0IfDv5CIF0gsC94JHTQjOvi/5QPyL8L1wBqM3j5H2c2VmVgb/kP1le/C?=
 =?us-ascii?Q?rIk0D87EgDBizzbCQ4aVFVm4OC0qBkyPIkr47Ptba0RPHwzEbAo84NZp++L7?=
 =?us-ascii?Q?aFMulBuBfp7xpdXIoDm6Ey2fds1JJamaZ9/TI6WZtLbG+k98Oahyj18cgL1q?=
 =?us-ascii?Q?ZGQiJcB4ULzp2h0zA5NCc3HgEPKhxiq1PVUM7fVqAxBSgO8h4to+0qoXl8aP?=
 =?us-ascii?Q?VFahG1eTb5r775M7osTqxwgZ0v2iqMFhJGsxgFZg4jcfNmubsGarz0g+SBF5?=
 =?us-ascii?Q?CQMaXFSE4lppK9Dt9awTrlQGmLO/F0jg5wrdnf8Bsf4es13D9o0ykoD3w1Bw?=
 =?us-ascii?Q?gaWNue4YRAfMVG/JihmBjctMw+wCEQbv+e6Ka8j9Vp9AMeSRDBTDnTDt7dKx?=
 =?us-ascii?Q?pnhZWOQ09j3weRzB33fK+0v3GB/MKmiA//AEKmndpl++bRDwmetjXXPoODqx?=
 =?us-ascii?Q?b70bSey1kuJ31XW0WYSh59lFihIO7Wttp5GlKpb81jVq2yysMANEDlRrMlNL?=
 =?us-ascii?Q?/RUdtNiRB4NRQv5WzyBsJbwUH6OdKKSY3SXisL7WbegYrEtkA95VBqse7UyX?=
 =?us-ascii?Q?ns+tvHK/oFpzJDKsuJMzS3vmZwLopQIGBgriK3r1lul0Lv7/R37Z2KbrlWj5?=
 =?us-ascii?Q?WMb16UwZsnHBJiGGK+l38aYxr4tvcyGekmdcR+gaytVrLidUZN3LUbxSNH60?=
 =?us-ascii?Q?DNwCuPQUxaBy/qamYstvy5yPpETyPzKvqFVLq/I6wukZjSoUBNYcMP4r6Xcq?=
 =?us-ascii?Q?ogXZ/iuYyZJOd1asQ+E0zsLnpU7nqQW4SGMj6A8xoPq09PbpeMjjXD7ib9Df?=
 =?us-ascii?Q?vfTS4eXRY77UQUIF7anYn8/o81pBpHzurqu0Eckn14J01oP72PSSaMRzs2Mr?=
 =?us-ascii?Q?m4vmsP9dWJnvHRQyk13HPQqjwY4KYumwFhcEdwf6yQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fjV8lgi/Csf/aPcO1Yqq5tRI9/+GDwN0yqAI/SoLQy83LCLMFsXlzbyXmZg/?=
 =?us-ascii?Q?3DVLQMj16IhH8LaT001YaZhsS++HvxkOhC26Bdb8rbZFpsqQf3CSnB3gHV/t?=
 =?us-ascii?Q?7kR8VsrSoSa2HfUNoFb/DUH1QLy4+LxbYV8zDhep5u8qjwHRHm6m9aKZjYC3?=
 =?us-ascii?Q?ou+xVqi7lSeRyQQIwAyIgH163KOw4ORfPoFQkIqx+2UEiKFJRJ/tf0uVjAca?=
 =?us-ascii?Q?1kKvMHWMpy36lWboVFS2aZlsA3v2AZwPtfQRRMB6ise4IQX8eejlLQGpKtnx?=
 =?us-ascii?Q?hCxuCsRnqJrZB8XHT/zjBtCtItZb+4KKH0jIr0k2+dG5KE9RVjF/5NeZh+3q?=
 =?us-ascii?Q?5b08qkDayErzpPBT52rsZWxHu0g9LIlHMnTWytYAu8v75jtUlS/565XX4BGm?=
 =?us-ascii?Q?TuP7vkRdBHlKA/wDOqSiY/bu3m24agcNs0Z+Q3CN58VMLPY80lv+ih1cE/+K?=
 =?us-ascii?Q?Ywx++vWpPgibQarW9Ef0PINlVgEtFalCMyyMDtYfQnHvYEwhB96I9delw5Dy?=
 =?us-ascii?Q?p6C6Usj9n79IXEidZ5mw+jf+OkFON01mPhk3rbXpivRrmMcgHOUpHPl3ZNCU?=
 =?us-ascii?Q?59kJoJ5iK1qQgNbhm9+qawRW2pY3fPpIKNWq6vW/QjNoCsZX9fxubYTqaDsZ?=
 =?us-ascii?Q?EJ6+rqNVhpL/eF5p36MVPy2VPXcFOaXnmEkTBNHxMKmRikUnpuCw3iTe+KCu?=
 =?us-ascii?Q?ytsST9k2G21CHOXl5ZYBv78P/QiPKRa5EO2J/7yrAZKjQHU0A+AeNt0zvmJa?=
 =?us-ascii?Q?P784XWJcjnxfmqnG5yWMpN7EUuv7K/iiZvXjTA27cqZLLqJCecrO3FY5hb2L?=
 =?us-ascii?Q?0Unnz5PvMl6NWZVvAHS1A2r/F0lBdD758oUdlxwb35MjL6wSLR5eEI71hYeH?=
 =?us-ascii?Q?E9J8cwjSSY8BrEjkOw11pgBXgdPuyHmtUxTPUWSSG8GsAz/SuzeHpsjLMZGd?=
 =?us-ascii?Q?7Cfou0khxrf9N0YGxF/4ILeDpDW85q95HGDvU8paiZ2D4XPZqnFa1zqCGf1i?=
 =?us-ascii?Q?/r3yRZUFFTA0IYnsPkViu5IoSaC20F3Q2H4i/M0Y3CjUXGNEIYityVTLSPM9?=
 =?us-ascii?Q?TPIxeRfR1zDQJFnbo8dehp8HuAxTJ/gNaflAcKxNOkufeeLzqq1VdmupkhiK?=
 =?us-ascii?Q?A5baec5oTj+9VopjrdNBjk1yHTKErbmFs2bOoecAx8cujiJaXf2tMPOOrwjK?=
 =?us-ascii?Q?eziBtqP1aDXIVeciMhaH80CE6ahBz1+xh7ZHOa0R3blmLjI5Bl78JGIjM3vN?=
 =?us-ascii?Q?/QKy3rR7pdZEH+kalZcPHjCmHMmYxd/jrRjhrTCna/dIxc1ysXkMpyHmkyyM?=
 =?us-ascii?Q?l53EQM4wCoD1ILJtoYV9DbXLEAghNXGnm0p0Jiz8+8gRK+sCxGCyu9r/U+dq?=
 =?us-ascii?Q?iEfDL/qY78krlCxzScEqD+oqfyRBkQPTSqbd1asljgZklRcrzpf2YmXitCOm?=
 =?us-ascii?Q?Pc/EtsPghKrnJPHb/DOGfnELfRWvPQ2SK4QD8D2eErIkko8IBucxCUiKDdsj?=
 =?us-ascii?Q?azgwCo3KS4/Uw/R5LSGx58QvZmXOzIPaR1tDbtOkraY5OnyB6xyWGL7rwNnO?=
 =?us-ascii?Q?UZU7UVeseziIbOaP9NY0CDY/k1Z3JtMJQ5VHJ+coac80xUACYl3Z48AyGjLX?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 192fce44-0159-49df-b485-08dc633cf2ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:27:40.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewP89rdhjG1jDw+qe9LKxutDhVLDgxAQDplG0sXD/lp+srksqZxk82XtHZy8L7aUX00EP2J4+U8EDmDU40kNfPmnTu87SvV9U6chJ8PL2Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com

Robert Richter wrote:
> With the removal of the Itanium architecture [1] the last architecture
> dependent functions:
> 
>  acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> 
> were removed. Remove its remainings in the header files too an make
> them static.
> 
> [1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 17 ++---------------
>  include/linux/acpi.h     |  5 -----
>  2 files changed, 2 insertions(+), 20 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

