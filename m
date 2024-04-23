Return-Path: <linux-kernel+bounces-154420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01D8ADBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625841C21377
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD117BDC;
	Tue, 23 Apr 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSCnjjSz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA817753;
	Tue, 23 Apr 2024 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839038; cv=fail; b=hRHg7h7UWMtXkUOPFsYq5A3ZqMHkoR6IYuWuGOro3zil8Zyfi4w2sCC3iNqOwVK4QeRgb02nTtwzk9cOUoA5DJ/fE52DftQzgr1SI++PALYzt0iCXJiWfgIg6iXWCznVARqCpPvzzQ0FkL6gG5KqiA9QUg7tpyUFsao5FY3xNF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839038; c=relaxed/simple;
	bh=O74f1wxVkIN96Fg8G1+QtxBabFeQmjk5Y3SCjbHrjFQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKmhwX4MUIyp6fBBj6F0xpuW81Eb/22z02od0UnrA+ognt8RndQPrUL9xx7R0WTF+q64GD8J+SZS5EFRHW2EHO/FZSbk4ZRnyl5XT+55G/tXrG9ZaR7y2BdH359f+RLj9nCpno9Xipl16Nknvefd1Zg4G6lK8aebRNk8Siu16eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSCnjjSz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713839037; x=1745375037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O74f1wxVkIN96Fg8G1+QtxBabFeQmjk5Y3SCjbHrjFQ=;
  b=YSCnjjSz5QCCICv9MM0gC+2gv2RR7OSJAuiKzy1kOMbVBzRGm76VPL8z
   IsU3C2FI8C5wdT6hjpcqjk9Yve4T/4A91T+sTRsF05NcAgq7HC9Z6SFVr
   ISL9QGVR9oaf9ZUs/SI6JocSRloUvozCesvh2q1p/Vgqnb2HChASPchJs
   ct49Y97SoIQZUNrTjdGpNaRDSUbKMCo1GCuTAuRy3X78NL6JkdrqSx5dd
   xM+5KBygILUrqTC9Gvujszusbq1tvecJY5/v01hAZR335R67AAbN9ofXV
   kRrGj3SQxC6ZKb0g0ZRa/jQbZEkVV2jmvK278uI9q+N6undn8nP6GbXmG
   g==;
X-CSE-ConnectionGUID: mZBGR8pEQ/+zn/KGq03+Qg==
X-CSE-MsgGUID: o/E7d/ePRW2Iq1KykTpJGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="31895222"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="31895222"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:23:56 -0700
X-CSE-ConnectionGUID: pIz2rpz+S5qMxLDa2o99hQ==
X-CSE-MsgGUID: kZJTfwZ5SieaJDecBCpL/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29023844"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 19:23:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:23:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:23:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 19:23:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 19:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONpZdw1eoymlGB80gskaTvdoUkDO3grYO+uSygIa0zViMmO7vP8Pw34UFTFXJYAR8+RyYRFZ6RYs6USXSZx2BXiBxb94wiZ95YCctYScQL9E+hPq01MaXRxtXHDF8GqtyDAFjSTyvfeOyEGh/FIt5bl5gl0bBijaQxinVW4KOyOsT1OImtQxwgX/pm66s9sV6EDsGAeLwVCDMweZP7nsMWkg+Peo2sIe1YhYUK6nG02v9ebCTLIhyujf34yfHY8ivsL+Yt5oza0/wwN7/q2RrFxb5ZLoqC5zkF+tesQEMuyH8NmeEaaLf0lpxRbJkbwEG6P0w2uuzkDcOteIa+NPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygGgACbtre9AUyOpQ1V6eenvgJeibXmFrLppT6Gj2sc=;
 b=Hyn3JcsLNSBsxh92XgEsDj6om128A8N1DQclQD2C5a3l//MpWpjNpDBVmGKxEMNhvXgZDkMFY5shAQbGHv7676WPgyopJ5jMCkw1zmU4ZkptwMZYL3SRBxmeDRZwrnVDKSs5xl4IRq+0O0DjMCkdGgGDtzzzsyuktTwZOwaYSfW0Yjc8zjfeOXMvGH4g5r8EXhbhvF5Kk9b47HOJh2C+fcJu9wwKd+WUQ6rdqSYrUmSPqFR9pwAUUmInpCSEigkzoJ/u4a1v99FBsUEMehFtR1Ku6JkpksvMF1ZJxrzxxd5gRZJyM4TFUG8Tjk23garLOh2myz8DjWzaZHyYPucX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 02:23:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 02:23:52 +0000
Date: Mon, 22 Apr 2024 19:23:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: RE: [PATCH v3 2/5] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <66271bb55bb92_691029473@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-3-rrichter@amd.com>
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: efacdb74-df4b-4194-8375-08dc633c6a9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P09e2gJir4/tfurPhmkCJ8GNh4/oYsKqoh34vODPVytZFOpvk4B0feYymzny?=
 =?us-ascii?Q?jMnKCDncVNRxyLkngJe75yNDpnPZT0PcvQPUrbqpkeaIj3yQezWOLuqHEG8y?=
 =?us-ascii?Q?fAPP66X3qlig2I9LJMnC1RzygUG5YSlhLsTqfmd2JIpJ17rDuBupCy1bVJv2?=
 =?us-ascii?Q?wEaFDR16vd3y0Jv/sQX3T0eYtTqoMCWO1Aj9M8eEXZTtVtLW0mynGbRbmsQL?=
 =?us-ascii?Q?WhncAS11fXQD9nGGC0pLbBgpCyzK2EU0VJdtP715XyV2jpE6mbo55YlajaED?=
 =?us-ascii?Q?iOt6TjRS4xifY2nX1y74eB9nZcESNbxmR/Gp8D71D8YfO432pDPnFM8xnf0E?=
 =?us-ascii?Q?l2M2pUkSZ8uGJdEn1/dJ3r/n4CHh+ZUuv9nWmzxs2S0DCtHh1NHWkx2J+rx0?=
 =?us-ascii?Q?sTeKRKYXWUyaptgPAcwjtGWZZnxTlyvDEqpOszYNFA6bW6SaLFtVAg+0scYd?=
 =?us-ascii?Q?Gt50WlncSpWVpNyef81p84o1zqLlfewLVoRg2c3CpUMUFAYGpCqEcM2kOrWo?=
 =?us-ascii?Q?nhrlHoa8GsakjSvkN0DxpzvOLGcwz6I6L/CnPkqT2uoxv5X1wrV1Kl07MXB9?=
 =?us-ascii?Q?Uulev+OAcXUrJpWW5NQ0Wt9W83egipykTwV+Mi/UY3jz2QkVfDznYa1rxPBm?=
 =?us-ascii?Q?QLLGYyITiZ1maH4jrV4xvsw4pfkeaZ9LslcIz3EDjxCKy5+UNLoCyd7s7QWb?=
 =?us-ascii?Q?W3Ysf2+SllVG/yhnEWNupaBE9U18juc/65K3rtJE0EF6wUugF3mGPT995Ac5?=
 =?us-ascii?Q?POn3xMWahUqNFoIcwfqBYz18WLtUsYwIK7jQc2ckiyf7nKtNLnqbwnno82Pe?=
 =?us-ascii?Q?9A+4RB7GbeQOzhz6tbQJ+7t23umAk1Re+ur9WEpg6V+PScIzWs/ltHee8qoj?=
 =?us-ascii?Q?Lx0ELg0B3Q1mFeI+zTyKSWm3P/kg8CBm6Yweckq7EAGZaMv5dIwtIkki8YOr?=
 =?us-ascii?Q?wnt7ZYb3crF1nziuj7ZhWrhqhKQkjec2DttMaVo2GVOPqcgUBoTgGxosdiu0?=
 =?us-ascii?Q?ttboJU9FzGViF1+DGNW7xjekHyWf/xCrWoPOdzeijlJzikeToObmNsFCrt0j?=
 =?us-ascii?Q?ZVoSt0uPoP35WQKmpMp3VR90JyEY28zLfLCu+++EWn9bktpIuPCvzaIJPkLh?=
 =?us-ascii?Q?/7S4KR8pH7GilhDW6h5YKsQ82F35sqZRPJK3tNEvJGQgJ2jCt+3pQehzJnvU?=
 =?us-ascii?Q?B6AFrTC2zcofxUzQU1SX8bEXlsVfB3MlkdX0fU1mX6elnvdNCIApuVTPDI1q?=
 =?us-ascii?Q?kh9pZxPMwVyhGITp4toz6Sa+AIeP5Vw2Icc74BxZZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1mla1WJ/1bz+PGXRZrAQ5Dc1rAzIztldkn1gYSUuz/lwwXE3M5BUBVKv0Cu?=
 =?us-ascii?Q?sYG3LrBM7Mmu281+/ew5Z1TwT/3/aFOtmBH36HwZfcYeJZYPm4NMRYljnGK8?=
 =?us-ascii?Q?0fMEEA1I0YUAG/TCHtNL4VS0CMnVwp2wqpjeBSrIWTjuDkLcmXL/9IziaUrQ?=
 =?us-ascii?Q?geteNAVnfE35VEk9c8rqxgKgTyOQqnbRM+Qv0OZV3VQ/2I9+CeTjJS5VOc+e?=
 =?us-ascii?Q?6X4EJQ3TE3rTjJObq0E0Dc2cgIlBbYY4dRTdF3CZBEhQsUIDLGmOXU8RhyxQ?=
 =?us-ascii?Q?4y7ZSxwYngE5tIqSnDmtUBdmhtDfpxUXePHXcfMgVyHFe3XY5P/5Ta0M3TNB?=
 =?us-ascii?Q?iJOxmVK3eoW1ZcGR65QTQKVqu8gX70/dALN2ZNm4kclgXMT93KLcKG+enUr1?=
 =?us-ascii?Q?2ZKH/1p/77FLT62gb/9L25Om1Z2OibYT6V4d0Q6UsO6MUJgjlBeJ+y5SwdLo?=
 =?us-ascii?Q?EVyz+2PizhY2+Wh+R+XKDodekYSrhEXvwnauJqyKcFlLtz6Dz4YpPQj1zUAB?=
 =?us-ascii?Q?xXQujMgduhczGZUe+PezIpQMQDRIqPTNP8QG/Miz+3qjxZms3tecYwe0dpL4?=
 =?us-ascii?Q?XhXC0rVphZ+N9v0wenoc8jnADIZj7hdrPwtNw/sziY2XCCP2ZKeb4Dk+IlAT?=
 =?us-ascii?Q?/5uZ0qjRNixxvL6fu1A/20kgku2Dzjpnye3H2xP1CLN8nOrkYRxwyJHJu3B9?=
 =?us-ascii?Q?tpF1w6lzgdfcJG4S1EJDbEOJ7GVY91zcXaIT9T91FzVc22ElG129KUzSnNmn?=
 =?us-ascii?Q?4hhZxvIwIgpWlsO3w6qIAEaUEK9Y9ghVGsRDMfa+NE/Gjy+afMgdADLArSKO?=
 =?us-ascii?Q?o1XmZ2avL7UTMK3O4ua8L9+202moFVA7BishUU6fH5p2jU3U10EKr/Pf/PV0?=
 =?us-ascii?Q?w16bHd9ypxNPahFL0pnGesMNFgPitJdQtLAZU9JuYn/upAarjjRoND4TvyN/?=
 =?us-ascii?Q?UZPAR5Qn8KhvLQwuRwueXbvtDV0oyaxxs9LX5fQgiXpastvdRe0g+K6Y5/tS?=
 =?us-ascii?Q?0LUAkr68eYFRrNlLEok2zEHWOmQ4I2cn5/WJsHYe4cqfzTeuy7skQ8/eNg8W?=
 =?us-ascii?Q?Kd/t+1OZglmV+QxXmnNTDKGpkFF5mF5MX44N0CF1kCVgMzJyZTuB7I7gZoSc?=
 =?us-ascii?Q?9DBp+laPidpx7AhQ7wEheaMTL4JetzVBbDrdxW5I2+sinv7narQ6o5fUw4ME?=
 =?us-ascii?Q?lIl/pGdjHtqCjZflE7mj7JH4mawKN2ZwBQdAzl2S8aKQ1m9zaWlsgFropu9A?=
 =?us-ascii?Q?L3h7pcvsQWvM3xmAKQuGy9ES5i9ZS1kAFDeMTbQi4cIA3lArP3NF/093Lq9P?=
 =?us-ascii?Q?KDBwofwKdmczMgO4t7tAJbfcc1ijpWuvVwYHsa3/XaSpnEzQci8BsZGiLFjB?=
 =?us-ascii?Q?jSz9IK6UxWUDJxjPh7pQq2fSX7ZnWKKJfezqwwT2AZmCag6DIv32yHOstSnw?=
 =?us-ascii?Q?tb69CD9xilQ7+DWpnGoR2RTzuujo6a+A0Bucwi40/lGrcTx7f/48Af9LQ5Gn?=
 =?us-ascii?Q?9Fw6nvdCpvWfLQVaM6xXqZ4Ep5pCTZZWDMWJM15yIHKBO9Go24T6EI0dOe0r?=
 =?us-ascii?Q?9nSeTs3pqIk8e1AVHlKFklmQ+Q5yVP3raytzl1TrnwEUKxzBGr+CaquEF4pY?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efacdb74-df4b-4194-8375-08dc633c6a9b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:23:51.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sn+xsdobOe58Tbfy4nGEi77fBOmZeyV5TYpQ83m2DCGAdVU0gfiLWZtc0P8anO08IqKZnNUKq1enqzUxv7bgQg3BqB7VztF7Ar2/16T3gkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.
> 
> Adding also a pr_info() when successfully adding a CFMWS memory range.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com> # CEDT node info
> Signed-off-by: Robert Richter <rrichter@amd.com>

This patch feels out of place with the rest. At a minimum it should come
at the end. For me, I would just drop it altogether unless there is
some motivation to enable more bootup debug messages.

