Return-Path: <linux-kernel+bounces-162664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578548B5EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3AC1F22FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B88529A;
	Mon, 29 Apr 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brk0Ecus"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314784D3F;
	Mon, 29 Apr 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407271; cv=fail; b=UjzrNhdqV5Ju6EXButMUfDvg+urjmvstX4gEfwlEKUgdr5/Wswem18gdbzW17l7veh8RTohxZrIgtRnc1cOucZDQntRIiHmqoJaIYiPK/t0p3i6ikqyF1UexXKb9C829xEZQATl+8ookdfWXGeIG7cuJ8+OA3A3LISllNxD7/o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407271; c=relaxed/simple;
	bh=rWhAj+feh+3V1NAdjqUjeCYOAadhPrtozlOlTY4eWbU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hwnI+aKb7HbdWz8isMHJIbQ2bkq1kPVUWzAN3TOSOzA01Uf5kDsCn++FstiYWWjwPVXmzvHC/CF7ZtUafXKW3Objn8O/xKetrv/en76nkNOfUcYtSYxilLM3WdEbI60kpSfmdx9wuUb585KXqGH2Qby/QolIxlrY5trHfPUyzi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brk0Ecus; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714407270; x=1745943270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rWhAj+feh+3V1NAdjqUjeCYOAadhPrtozlOlTY4eWbU=;
  b=brk0Ecus9Zw8xp8iAJa9AqdF96Frj4nqO9TdDNit+EBqSGQfCQSRyVNw
   Y8ZiXk57Z8dWE4XgNd3UKcm/xt1OjBbOKL2uA8rkWQV6wwfgb2/YykSoo
   hndF4BYVz7OCUd2cDsrY8qrIrtwfCYyr9lybI9cqGXsVF6QL1vNSKu4LJ
   jBemndTtg3jiopnvit6SUwHDBXdKQtaDarCVRQj5Qb8sE47WM3VPN5vKw
   0FXT/D8sfJHXP4UDx1AFPzWoPqujXBPuei7WUIkaYisDP+sxDyyfkFZiI
   DVW66RMkOKl5b+6aMH0uOPVbmKzv8xCZHFIVG2+hxF2+ZPd4AdxQ8ytV1
   A==;
X-CSE-ConnectionGUID: PdugOGLATq+y//cUiclKPQ==
X-CSE-MsgGUID: wWqlarOSQ62Wzij/AbMkeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10198739"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10198739"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:14:30 -0700
X-CSE-ConnectionGUID: U1W29jfEQ4yqbuVM6rNaLg==
X-CSE-MsgGUID: AS0mT78FQSOTmdZau+V/9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26264381"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 09:14:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:14:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 09:14:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhgIn7OiBiXFo0eHrQhE71zclXbFKXnWd16sShVSepMKRNTou/ZxTb/eXYbEd4OdeQmrjZRvir725AiKEtHoT2gMXrP5TQqPbUAjDvwVC23ACFZg4TqF2lUAfuqVW5eALYPfgVmhiyVRVsnNrVRFhsbMTAAG37hsSdZz78GKPXaM4kc4oCgY7lnEYT9+hEokEGM108dO+5vlyp5eXQ+fTNczusJL2Iee1liWyQW/ub+RZu2pRMkqD1VJdmG4kdm4ahfp+n71n96cmig/Iqp3My4wxTdoyX8wXcXwAfAlGxb3a9pOcCswNqkqrog5JnFSr00cBFB6bJEQKKrTl0H5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfJgvPkSOyiIQSh1yCIg6ShJACWVLZH6kb9Z6mx1ef8=;
 b=mF7KQ9qbzDMpj6SIYjcp4QOPbhbVkkoSi9Mx+FED8CrijEum2LIOg5rDTqBRZdUWxO+kYiNP310ahptyR9hXrpFDCnzrdFGNXSQKh04XHy38NJ+BXzNotTT/7LCuo53s19GzOR3q+TYNpuPa5O5sZjH1q1yeRk4B+XGlHFxQU7o/f9g+sxPWd6Q6ZerRvLihqiUG4BxvXqORIeTzT5OPfCmu17lBS2AgQSNjsG7ih6BJ91ZnhrSzWftko84U7zXTFZ0Fl5Jrs1GuSMzzADaDmLrPvSwlzmvENl80i03KXppJeTQSuuURp+16H14brNi073rvJswGczDEdr/93HUUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:14:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:14:24 +0000
Date: Mon, 29 Apr 2024 09:14:21 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Message-ID: <662fc75dc1106_19ca3929456@iweiny-mobl.notmuch>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <20240429013154.368118-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429013154.368118-2-lizhijian@fujitsu.com>
X-ClientProxiedBy: BYAPR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d557f22-2591-4f32-226c-08dc68676fb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wOyk2vmEaY3b1NhJkyYcJdjDfOMg0D1ZBwdYTv8SwqboLZpjKITaSJ7FSuor?=
 =?us-ascii?Q?QxXaK6lrtEUa+egE08BWgmfM3yqPRIXjuS5kvNFCCGmYzZIK+89OxmOw3fJN?=
 =?us-ascii?Q?QQ0t/9kdI8G0bAZsDyxYXyOMhrKAjBHD/JSCfEZAdMMoGfpfg1jPxbKpye1y?=
 =?us-ascii?Q?Lz5dmCCxhQRDkP4C06xwNd2eZqSJxQAJduzkd77lVTA78yMDI+dpahy648BZ?=
 =?us-ascii?Q?k/c1lXPF+BHXXyzFj1ai9gkoZzV3iih2XHXktAoqD7v1R9PkzLfmN1KogcTd?=
 =?us-ascii?Q?jFXDYO3i20gJT8zulVHNd2cgq4zWLOrUnjFddraKbHK1TMySEkrCqeEXoCeu?=
 =?us-ascii?Q?/bqgE/pDjDzW8AiXmfvMVRNtJnzVUeReMbVWzfj9rWIXew5MELKPvKSbxEmO?=
 =?us-ascii?Q?FhRAB7VC6NDWp9aEtaZCYpHOIIJ6lmN2WHVwSovsnUGQyrCakVPa/EIwxRnP?=
 =?us-ascii?Q?TAjH5f2biC+k8wM7C7QrWP6lqgnVyDusDjy1J6+VfJkCNsN1SKLaCFlRvy+x?=
 =?us-ascii?Q?WLH1CvhmEL4hXHV9trg+uOJT2X8O1Xd9ZVbO3gV0BkcAEEdKh7UNscDTztrs?=
 =?us-ascii?Q?usKEnhimzWvafEYmZk3pUTh541n6mrm1DVg8ISlG/XvfpJQKfQ4xs7s2RAeo?=
 =?us-ascii?Q?x1pgqSFNCqYi/ZTtHlnIp/HUC/kirUzs26a2Sl91ROQUjdCZmXStZUxjAJxQ?=
 =?us-ascii?Q?hFcZN7JT6VEKBcueJaWtxr8ARsz+a5riiIxX1ZjVvJVzus7UXLbNQnnbo9ef?=
 =?us-ascii?Q?W5ODqGa5+BnNdN/UJb80KBIgby2gOyUss7eCnwgS8D4jqbuzAU1DkKPuw2b6?=
 =?us-ascii?Q?ZEDY/LKlnTpeNyLJY0ZgOLkdDvRGA4AkroMM9ktqs2weVcxZluw5PaMl64Uy?=
 =?us-ascii?Q?8l9+nxV8f3tAUZtBkrRnDSWsI/dV19tUkOf9n3lZQcnjc5dgw4o+9y+CVSAN?=
 =?us-ascii?Q?Pltjnhjwc4Cg8JoPZkoIZHgqb2hzKsjAKKA7a1eAnEJW+rIX3dva6EO2QWyJ?=
 =?us-ascii?Q?n6zt/z6HU4SSeoHj6rEhJcCqNXeC4JqbUtJ/ZKBYM6FBzeCORK0hYq/ni7FD?=
 =?us-ascii?Q?yNurufXFvnEGcckegYuRf6gaY0XXtijVs+0hwdrXbo/kBIwUAGc+H2s7oRZL?=
 =?us-ascii?Q?DNIsnO6mKaL2GgQkoPKWPMKfvH6PbzGMPfysIYWnbEmZhJWKpkzRQlOoiAAT?=
 =?us-ascii?Q?V/MQv3dSHj2XOGfRtQGpo4YxRzR8elgW+qCyRw5kkQRO4EPxbtgVnH6pwfO7?=
 =?us-ascii?Q?8OIvfnZR6Mkiqi+VyGfuktPYuEAs7wYCxzNAFBdRfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JyFkt18Hx+cyrchHfZ1V1Xa89PlHC1B7UIqTtr5PDHaPij1ahd9kBTP0EyF?=
 =?us-ascii?Q?aLb+XSdVVw6zUntdA+Yx8Gl8HLPciZbHDVssN5e04NDpYXI7gtKnALw/t6nN?=
 =?us-ascii?Q?O1KE9l8tj0sa/WryYhxDmw9kdBF+jSb3Y9tEYxSYvcQaqQVaz5KDaeoGJAx2?=
 =?us-ascii?Q?aDRgHoFrEdfHEqwqOkIL2EDhjWMSL6hHJMf7rmMYKN3QYhOinuHgQ/EN+w/k?=
 =?us-ascii?Q?VkMzMLBXBdWKnhP1uWdnsoXNzQrJ9vH5ZhoBcd805Hs+l7g49mlJo9EwDVG1?=
 =?us-ascii?Q?fIXvW8kpnkvKo1hrmkZaB80BLJGhX33OANu1IRCqUZ3E/S75Oaz9SiGH43SJ?=
 =?us-ascii?Q?qXacHvcwrSofrWbdnI/zQWfiCS6KoR/rDMqW8L2fOL47GZ3mioGibok3eJNR?=
 =?us-ascii?Q?1is90PpI1uU/NDCFzT6ueM2EOSvdRwMjMovdDd1fssSDDsJ3+K/dl3TDRXdr?=
 =?us-ascii?Q?hBEISymOtpQxLrtke8IT32iPC8IL2RBbgG4UmDP6uxX7gp9j+97PRH6Zjq3k?=
 =?us-ascii?Q?EtsX3x69qmqByFMsM2ozqXBjJOPkbTNFQPIIHLl7k98c35Uixiq30MyIS1bn?=
 =?us-ascii?Q?1tFbbsoEcknmZdc65u2i6fC5GbkQouE0Rdbz4Eez7gcH/hdZFH3iQYycYWtK?=
 =?us-ascii?Q?qEHNY1HJt/H2umP4Nffkma5zTQVkMn1rfz9pVDJmAjnQF53UNcXwI0ErFmGO?=
 =?us-ascii?Q?8eOYSTEFqfgp+5BcaAigq8jamnDObSYOY0rd4JMLvH803lH348HQZzN7tQ03?=
 =?us-ascii?Q?FQPI+3uUDZyH49vAVJdAinwPt6oXzoOLT1ZFPywE5S/w/jQM/hmBRXeTeeLF?=
 =?us-ascii?Q?z4Z+ZrfQWo0wlmXIjdUFATs4oQaJuu92dUiFm6HqUoySCCJZ9V/M9IhJCPXu?=
 =?us-ascii?Q?yNaf5Qp72MgDhqQuzXOS+SKsqesFY+knzrwlMofde0i0KrFkgFR+0s4SnRgf?=
 =?us-ascii?Q?CuVDVv0RKw0FRf/UxeZRgF8IM2IJoERnqrdZ4pBzaw5yd/RTUUrZ4QeMThvx?=
 =?us-ascii?Q?OHf1GfFURve7rpnR3+yh3Mt9zrdNFDC6IghTAozPDrak3JhsGsO9Q4w1ue7T?=
 =?us-ascii?Q?0gV6Ozh4XSG9QOU97Afghouh4h6BfP6oP6fwSXg4qm/UnCQ8RQRgyeS0pcz2?=
 =?us-ascii?Q?zI2xN+F26J+ThhLpoVz9/UMdYfKnNYst+oRhox5Efseo6iMNmrmj+fKBpX04?=
 =?us-ascii?Q?CIBCiExAqzL1KJflVdvlqeltA/kMdAK8z0S20mn7ayIN55yq2LnJ82wKYfyj?=
 =?us-ascii?Q?b4n+fR0ETpTh5VWhoa3VXj9zQZN3zv2bkXEkgPrcPb4yzaGW3tDP1MMyUkOD?=
 =?us-ascii?Q?wZjeT0U3cxfkDjz6mMLP3FKyNvwbFFgQ7HsNrtBPxZ2thT/GCdx6DQaUOWLp?=
 =?us-ascii?Q?OXigwnZGDn6PktJ1AIkvDlvbCeS8PTdc3wpK8cpyl6cl3oFjeAUBy/c1afaD?=
 =?us-ascii?Q?Dl/6xP/6J2L1lcE5caEc4/1ufoxAKq5ePkMBrGGWsyb5zQLO7Ve4MFNk2IIR?=
 =?us-ascii?Q?aMguFTB6l1FPry45trGR7Q10lNR0IuUuCWericSeHNPtXAdxxyaOlWvEx9r4?=
 =?us-ascii?Q?Lghk9kQ3s2W9hGkcXJxcitS8DsO63259HkIx+tmu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d557f22-2591-4f32-226c-08dc68676fb2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:14:24.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZmsz8NFtIL2xh4JKqgGOMKpxU5TS8G2YVrwFis2SXqAxlZ29ln1Pm2+BT3Wcg1z1pQt6/DPjmLY9K38gT0U6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> >         mutex_lock(&cxlrd->range_lock);
> >         region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> >                                        match_region_by_range);
> >         if (!region_dev)
> >                 cxlr = construct_region(cxlrd, cxled);
> >         else
> >                 cxlr = to_cxl_region(region_dev);
> >         mutex_unlock(&cxlrd->range_lock);
> >
> >         rc = PTR_ERR_OR_ZERO(cxlr);
> >         if (rc)
> >                 goto out;
> >
> >         if (!region_dev)
> >                 region_dev = &cxlr->dev;

This diff hunk in the commit message is very odd.  I would drop it.  We
know this builds on patch 1 where you made the above change.

> 
> When to_cxl_region(region_dev) fails, put_device(region_dev) should be
> called to decrease the reference count added by device_find_child().

I __think__ this is what Dan was pointing out but I'm not sure.

I wanted to point out that to_cxl_region() can't fail because the
device_find_child() is checking that the device is a region device.

Dan, is that what you were saying when you mentioned there were more
serious issues if to_cxl_region() were to fail?

Ira

> 
> Simply put_device(region_dev) if region_dev is valid in the error path.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c80aa263a65..75390865382f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3117,8 +3117,9 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  				p->res);
>  	}
>  
> -	put_device(region_dev);
>  out:
> +	if (region_dev)
> +		put_device(region_dev);
>  	put_device(cxlrd_dev);
>  	return rc;
>  }
> -- 
> 2.29.2
> 



