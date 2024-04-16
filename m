Return-Path: <linux-kernel+bounces-146424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F528A650B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE501C21255
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932277F30;
	Tue, 16 Apr 2024 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwsIWxly"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09F179B7;
	Tue, 16 Apr 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252462; cv=fail; b=D7+T9N3grhW0AzpLCclHfJIgth0leMOINTyfOuDw1HgTmbiktbPjpkS/1lAZSK2DITeBQt+vm0ZTTXF3Yrxt/2VlB2smrFHM/cP8IKnZ8OpCEkmC9VmIWZFHwEu1VbEg9FP65jK7SClFl5rmIEocHxT4w9IZ9GvQwUHCh8jLg+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252462; c=relaxed/simple;
	bh=nEcC8360w9TvNI14XlKWe86MbCaW2mLHi9Rr5uBMezY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vFkF4vFpm+zQKEeFiBHClhvBBMAgS3o3nqY3mbqyeqbXAlVIRG9xMiUgG9BXyXjsn8qLkLOh6OcOCuFoxq5Wn+r64kzqtr24R6RxPOCA+kB/7R/xnZ2IfHzRC0x2kxfi3FGQORQNxhdoVEHx4XAOqtk092ZdRBCaTJI5i1P/UvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwsIWxly; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713252460; x=1744788460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nEcC8360w9TvNI14XlKWe86MbCaW2mLHi9Rr5uBMezY=;
  b=IwsIWxlynPg4e+yGm5DWIrEVA4l0SYs1aYVDtSq9tajd1wH9vhs7/Oae
   jwVhl1bXm4WgpOPJq+3N1Q5Jt+aki/NSvZT2u9O0OBLuKJeARc7xb5Kk7
   7j8QmFZNcnet3kYyzTqnNVeE8FOIckHCff9ul63n3oBp83205pozRx0Ap
   dLNiYccM6up4Pp4dfFa3NFlP2rRHFEPSQ4xIe59UoFykbr/MJg3y4tdQH
   fpZLyFPq037LhjWcyTD8YpE/kAwOA8JxYhZCnXhJnXVTjyYTwEWpB0L9R
   dU2S1jutV59+a1CVF8n+N1Anpf02519J09p/+GD7nuG0Zr3L8nsD0w0+O
   A==;
X-CSE-ConnectionGUID: OQCKPpswQ7yHj7cmOx57dA==
X-CSE-MsgGUID: NfhYIjiARB2MgMYwi7uwQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8784627"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8784627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 00:27:40 -0700
X-CSE-ConnectionGUID: 5CK1+CwmQCOPlEzrfz73vw==
X-CSE-MsgGUID: Oh59OCDbQX+uzPao1BqsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="45461962"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 00:27:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 00:27:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 00:27:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 00:27:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 00:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMpOV7/7sCTgZ1fFfzLVBRQKqqCAwkaSUjatwUtjHLNnNBftQRSj7XpcuXagme3EE69BAzlLTtuaTggSulVOWQE9LCppc2OpfipCLOTmU4Qt5u3UyJh9FUS8EIIeVabLDUdSy/4S6g49q2BevVK61J3m0WchqBwhcYx6l3Fc+XDsXQRgBj2AJjAKLYY6Wv3gvKH5WS0I+XWNDDkuIFtC6YptRgir1JTUUNx26IPXsCuuox4z5WLt4XpfP1iiu4b+Yx36vOkauTnv8uH94Ifzq1hClDvukRdmG6ox5GKDmOOuCJdu6HLMrcxgTQJj9Yusgb7Rkjehb/INv0TehTzwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmL/7q5V12UUEcHSgsR0RPgQkDeE/iO/vskPAaiPUno=;
 b=WJa1EcRxE0f6dRWf50UoEK9F0JYbaQ6IGa5+/5roQsM3f7U6WHxADAZrHdXfV1ithgt+IHezrBTHcBOFblaZ4TLmuWrtGNWyy7WnsxOw6mH5HyieFzMTTz9wWpZM8AfoaB3yaLGP8VeZkt3yAUqn9ZiAjWFKI640w5mjoZr1BGWfAnqO+zUUEg81kuKRwRLcO1RXZsNRljU+0XQChZ6zn6vv7X0wHf7zujNFIJ1jSnIjQQsqbP+2WkjC+vs9MxBgZ8hugHUfAOKjXRx02IvUgExub7FDD2JiD/nCR1d26qkTLhqaHmd8kEdLMneZoj5haoXAgt9p2XqAKphF11m60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:27:37 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7409.023; Tue, 16 Apr 2024
 07:27:37 +0000
Message-ID: <b4a721c2-567d-4ab3-8a85-963e3f323e61@intel.com>
Date: Tue, 16 Apr 2024 15:27:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error for
 CXL root port
To: Terry Bowman <Terry.Bowman@amd.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-4-ming4.li@intel.com>
 <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b79f351-9e5a-4934-60cd-08dc5de6b099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zUXPyye8qb/oJIGKTlHZqlqSNHZldrBf9L3fxT7OpDGICmEqhrlSR16xL+DWBZAyb16WCJAeY5TeG8xveUTMy54krv30hgcelLKpgjbX9m9LXOgeY8edJTJ6ncb6UhmthDL8reytfbqyu3r1LqoH+XvX7g/twds0AxH6cIa92QGYvTBklMCsvtSNzhZnzzzw3WXJ1holCUWtVOQBUb50VPQARSla2EfzRzs7l1M6FSB0MSL8HQxBAKNxDyvT7zOE3WNPTmry+IjAwKicXYxdlMQIKyC61/dwsYEa+tgtIzEHeBrjgYvzfk+5U/P5FB9cUVEut2KAtUXMVGg+4MsR2+W+OMNZtO+vHtxuCMApcS/Eq9c+ZK0IV6EZosy1k4xjTKLFRViJXGO/T+la6176Fvbz5JULoRc/sTNDxKilqPU/UncinhQ65lgrp1LlK2VoVr6/BNqbihi8SUXtISmtljPXxareor4ZPcSQow1CdAH3SIL/mZG3pq3bNyIBWxeUMRJX8wOhaW5R8akrynwOtk7llJz8rNhcQLMi9iehzhWiRSrTabWETsxdUztY+FJiqE6AqWsbHJCq78Q9DkZ+AWhm1QQw5IKHbt7BorAD5sqSh2fvaus1i3D8Hr0V+boUEALqe7sWEN9syBHbeVNDFDX9CpXHU9OtoSDW7qSYC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVB2dFRuTHdrMS9NNUN4dmYzeFR3cS9LRWRDVDdjYW9FNVkxbkZZY2NUV3h0?=
 =?utf-8?B?QXBJYXRpMXkrT0ppZm1Kb3dPc1plV1JJQnpqdGgzN3hlM1hiRk4xNGxkSWhZ?=
 =?utf-8?B?bHd1VHpBUTVPWEZ3Sm11Nkh0ZG9hY05KeHlxc3lpQkpPWTdBdVIwUDF6NU5J?=
 =?utf-8?B?bW1sQmZUTG9DUWxFQzU5N1Q4VTZySlY3UmdJKzd1aEVqekZmUE1LcHhlMEpn?=
 =?utf-8?B?K0dpQ2hZeGw1andIVHlOQ2U0RFZaaGRtbG1xSWhORkxuZGFNRzlCNjVCTnho?=
 =?utf-8?B?TEozZ1RBM1lidGY0WjdkMTNGclhoU0g1dzJMWHVaQVhZdklkZExZM2VKMFFF?=
 =?utf-8?B?Q09yTXRyZDh3aU1sUnlIYmFFeVpLY0xWWGx0RHNmMjdXc3JLcWxhNk1Ya2Yr?=
 =?utf-8?B?TlpSdjc3bjZlSWdLQVNMTm5nNjdRdnk1VThhWUJoZmU1RC9QZDZMOGIvUXJo?=
 =?utf-8?B?ZjBLOU1vUlZaaE0yZ2s5Y2lzbkN6d3J1WDVReHN1cXdOL3FDS0xtUUNZaS81?=
 =?utf-8?B?Zm83aEx0c0hyYXQ0SnAwUXV4K3h0QlUxbG4rc1U0MkNKS3hJZFdZWGNiZjR0?=
 =?utf-8?B?TUJXL08yVmxGR2p6a0JEckllOWJ1clNMT1hvYVo4MXpqNmlMaEd3c3BOSkVq?=
 =?utf-8?B?UTRNT2lxQTNrUVUxY1k2ZFpWV2M0WjdFOWM2c2NSdk9mV3VDd084NzRHK2lY?=
 =?utf-8?B?a1VMRE1JcUZEdW5hU1JhS0VLYW5IWFpkYVF2MWpnK0VRMDNSRm9JRlNtL1Jw?=
 =?utf-8?B?U2lDYndOK21JMEJ5eXdDUkpOakZHaWtvUTVzbjduejFlaE9YQm0yeDFySWcy?=
 =?utf-8?B?S0pWOXJ3SXZxYk95SS9RcUcyVkYwRGxNYlF3cjdJVHZPeDJ3YTE4YVRwTEdX?=
 =?utf-8?B?V1F1Y2VVS0E5dC93Qm4yZE5hSzhOZkJhTzgyVlNQWTF4dGRYZ0I1MmJ1TGxr?=
 =?utf-8?B?NFVvTHdFNy8xbGJtaFJDaDRVd2s2Yi9qQ0xhUVpRQk4zZnJMNVRzZkUyYVhZ?=
 =?utf-8?B?V1dJdnFtWkU5UzZ3dUlwc1hFbElMdS91WTlISXN5V08rUGFSbVI4WTM2aWcy?=
 =?utf-8?B?U01TeE53UmNZNzNuR3lVTXAyU1BlWFI1QldId05DRnQ1eXpzL2ZkSlFNeHRp?=
 =?utf-8?B?MWRGalJWSU5xd2FuRkROY1VZQWtLOWNSeUJmNzdLQXU1RXpVajd4aGFLQkVn?=
 =?utf-8?B?RjdGYkhPWmYvUG5EWUc4TnphVTF3WkhXdUIrdFJ3Z2tMSWJqYVR6aUFlNDJk?=
 =?utf-8?B?WmRjNlVuaEE2Y1ZDQlk2bWg0VG9KMExneDN0L0NiWDd6MFZhVXlyekRla3By?=
 =?utf-8?B?UVBGbzdLUE1tV1c0c3RkR2VTRk5wREMyR08xWWtYRm53RTFxS0lPRXM0WjFm?=
 =?utf-8?B?Y3FmOVhzUWp6cFA3VS9hakxxeHlwQ2ZDMytNb2NYMmhkZzVCRTJwMUpuRkw0?=
 =?utf-8?B?QlNnZStiQ2N5RHdqVm1OUG5tK0J2Q2ZUaGJHSjJJZm9ZdE42OUpITXRtc0Fq?=
 =?utf-8?B?elQrc08yL0hyL2dzcUhBNXNBS25kYjhnRkxOSi9SeFg1bDI3elF5SWRIUGp6?=
 =?utf-8?B?SmdqRWkwY3NSZTZzdGhOaWlXamxrejA3SzJPMXpRS0d4WUdEUUF5SFFJWk5O?=
 =?utf-8?B?eWduSDBRSWl5ak9vN0R2cnozTzkzeG1aR0xhZnRsam1tODFNZW1KdU5TeEdx?=
 =?utf-8?B?SDFLOUtHTVJFbzQ4aXlPMUlRTDdtRy9SMVlCZzlTcDhrb0VnOGNIODF4Zm5o?=
 =?utf-8?B?SjltSmlTSEpJVlcyNUtaMlA0YnowekZlQ0xmMHFUOHNyQjJuUkcvTzFneWdr?=
 =?utf-8?B?NDFPU2pTZXc0bXQ3UEs3YU1kbGlrRWRQNnpQMGoyV0QyMFF3S3Vtamh4QjBV?=
 =?utf-8?B?YWQzREdnMHNnMmIwaFBldEZhWk1GcXkrZEEwVzM0ZjFlQmlJS1B5dzdyVHpv?=
 =?utf-8?B?MFk1dVhrSnJwdmJ2eWsvSjZhYm5sN2w3VVcwcENzS00wMi9uQWtOc2MzZmha?=
 =?utf-8?B?V0NvTGJKR2wrR1BGbysydGtnMER1ZTNPYTR2TmNIUzYxdzk3eU9wRENjL0hS?=
 =?utf-8?B?TnU0RGJVYW9oVkRKQzBEYUN2UWRZeUQyd1YvRUxBcndaTjVWS01wT0pnZDVq?=
 =?utf-8?Q?xiqqOIgZYEws9FIapEGqcKFVA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b79f351-9e5a-4934-60cd-08dc5de6b099
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:27:36.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUIPJp+vX3O47Uwi9lR8A7sc2fC7BM94cVbv8jn1S6GwaouB1jlSziCxuP3M/tL46Ca/DpHyGpV5nwmraqYmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com

On 3/26/2024 3:42 AM, Terry Bowman wrote:
> Hi Li, 
> 
> I added comments below.
> 
> On 3/13/24 03:35, Li Ming wrote:
>> Per CXl r3.1 section 12.2.2, CXL.cachemem protocol erros detected by CXL
>> root port could be logged in RCEC AER Extended Capability as
>> PCI_ERR_UNC_INTN or PCI_ERR_COR_INTERNAL. Unmask these errors for that
>> case.
>>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/pci/pcie/aer.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 42a3bd35a3e1..364c74e47273 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -985,7 +985,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>  {
>>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>  
>> -	return (pcie_ports_native || host->native_aer);
>> +	return (pcie_ports_native || host->native_aer) && host->is_cxl;
>>  }
>>  
>>  static bool is_internal_error(struct aer_err_info *info)
>> @@ -1041,8 +1041,13 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	bool *handles_cxl = data;
>>  
>> -	if (!*handles_cxl)
>> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
>> +	if (!*handles_cxl && cxl_error_is_native(dev)) {
>> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END &&
>> +		    dev->rcec && is_cxl_mem_dev(dev))
>> +			*handles_cxl = true;
>> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>> +			*handles_cxl = true;
>> +	}
> I understand a root port can be found under an RCEC. It's possible. But, does the downstream 
> root port forward AER to the upstream RCEC? My understanding is AER is handled and processed
> at the first root port/RCEC upstream from the device/RCH/USP/DSP.
>  
> Regards,
> Terry
> 

CXL r3.1 section 12.2.2 mentions this:

"If the CXL.cachemem protocol errors detected by a CXL root port are logged as
CIEs or UIEs in an RCEC’s AER Extended Capability, it is recommended that the System
Firmware populate an RDPAS record (see Section 9.18.1.5) to establish the association
between the RCEC and the root port."

I think it means that CXL root port is possible to forward its AER to RCEC.

Thanks
Ming

>>  
>>  	/* Non-zero terminates iteration */
>>  	return *handles_cxl;
>> @@ -1054,13 +1059,18 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>>  
>>  	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>>  	    pcie_aer_is_native(rcec))
>> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>> +		pcie_walk_rcec_all(rcec, handles_cxl_error_iter, &handles_cxl);
>>  
>>  	return handles_cxl;
>>  }
>>  
>> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>> +static void cxl_enable_rcec(struct pci_dev *rcec)
>>  {
>> +	/*
>> +	 * Enable RCEC's internal error report for two cases:
>> +	 * 1. RCiEP detected CXL.cachemem protocol errors
>> +	 * 2. CXL root port detected CXL.cachemem protocol errors.
>> +	 */
>>  	if (!handles_cxl_errors(rcec))
>>  		return;
>>  
>> @@ -1069,7 +1079,7 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>  }
>>  
>>  #else
>> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>> +static inline void cxl_enable_rcec(struct pci_dev *dev) { }
>>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>>  					struct aer_err_info *info) { }
>>  #endif
>> @@ -1494,7 +1504,7 @@ static int aer_probe(struct pcie_device *dev)
>>  		return status;
>>  	}
>>  
>> -	cxl_rch_enable_rcec(port);
>> +	cxl_enable_rcec(port);
>>  	aer_enable_rootport(rpc);
>>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>>  	return 0;


