Return-Path: <linux-kernel+bounces-154075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC5E8AD723
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBF91C21942
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCAD1E4A0;
	Mon, 22 Apr 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGJAuLex"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E251CF9B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823994; cv=fail; b=AvbPM4n9uEc9pAOPZdL46CRN4d/Le4NYcLE8b6L3zdE9FcOIL8GRb1zSmpOLckBntgQUHMugBksuhNzUlR4IlBYg4IlSbZvFjmXjPeUasIBBuizTUlSvRUUcdh9h52mFlSKY8wTeW3ePk45cLdE6/LniW1FJqljcUzGygobh5a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823994; c=relaxed/simple;
	bh=/zZEcon7OK8ySYVY4KkyqsqEo32ioLDekWYsPqhMHns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i/YAPR8XjwYSeMra9YjPhEEfMV3ICb/3UEcuqko4dWpRxej2NDBr8kUsuQtu18dOb9NNrW3oO3AQwN5Rqs88p+CZnFvF1BW0PXViU3oJW+qyGvJg+mqdLxRRFqio8Q9/ZxdgAEUYLAKMetkvxFoXv/j/Rucx5Pyy+TRbrrKHQGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGJAuLex; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713823992; x=1745359992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/zZEcon7OK8ySYVY4KkyqsqEo32ioLDekWYsPqhMHns=;
  b=QGJAuLexavwmtGBO0H/qA3pT/NjoBt1sPNhI1UOMiCNpSvO+Ux24rm8w
   F0nPVAo59fqaLBTAt/1YCmWxuvDJXPMQkjtSzqy6aTW+rx2gbPcj7lIKU
   RSB/Ab7etIW6C90XbocyoTCmfmzjxK1NINmD4Q/wjgtPL3YVLd9mUsd34
   q+XvEAKaYHm71940u/SnrU3z5SsraNSZqivM2YxR7R//BAAEZNkzkS36F
   R0iJuKEdRYauDWQHc526SgYPWb2FyZQOhmw4f47ec+feuIMZsV47hF3pJ
   oy8XyoBGvp7uATphfVSDEIR7QBPI9cM/jcHFw7kf87wamF3GJaOQlQAx1
   A==;
X-CSE-ConnectionGUID: z6rOw+cyRSas022ltn9wVw==
X-CSE-MsgGUID: bnfJ1vszSB6/AQiSBHEZrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9926840"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9926840"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:13:11 -0700
X-CSE-ConnectionGUID: Mj0GRZn9TaWFL2st/FeM+w==
X-CSE-MsgGUID: w8+MUeTbRMemqz072vxevg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28951405"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 15:13:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 15:13:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 15:13:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 15:13:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcbyiieCy2vzpdjsNQ8Ovr/xnb8EB3KiBFCAr/We08D+RE0GwKeeDiNrrSqWzU5O0sK4iXihx0uz6OA65pUp1kQPUOnzQzydps9e6ZRxS++yYAGKc7zwwE6B4MPCjQt99vi3F2Sq6g5EYvUSEQBSo+V3z7544/lefZ7b4JABqFgVanHyj2QMXMEH0Y4uK6aUZ+PGlyb2Y9obpPzt+yqEcyfzw2qTy172e1OvGmVRIdz1hU8qMIRl3QnlgYFEYbVjdnhbSPhuoX+fyxELWQobzMfO5FNduSzkhatY5rMk9tSQ0+ueVcDrxqoZKChC9XpUuONv0evwxG0TuXedIGbD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neYHzY0T7CpQIjWMFRTzQDsY++rFQQbxcGCcZRmbmtY=;
 b=G8elAGWZryv4ndXAKAyINZyL6qzoiPn99oyY/xT3w0TVZKmchd/r/ChmCfYLfnnAKJ4lipOxJjIkQcAzRBlZRVVRpYZ/7E6SDlR5/33TpwThS2ZF+BZE5w+BS7YU0pXUeRn3GhbGu551xhcdw66miTotVpfj0zfO/Afq0b9NGkWzAoUxO+NlChiJvULOjaEnhnEN1lzhZ6+tQrBpupRDdPcmvUin/gEk80AD+FPgk7S14XnMSJNlIWjqCLpC0w9lnxxz6G74926dRuwmuH71SiVqVoXC0gIu9uoDMNV7bWWkpy0x4MxzOVIGYqBhs362ItZs2kWxqQ4cGN+tZUoceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 22:13:08 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 22:13:08 +0000
Message-ID: <3611ea4d-d714-4ef2-9dd5-d1637e806411@intel.com>
Date: Mon, 22 Apr 2024 15:13:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/14] x86/gds: Lock GDS mitigation when keylocker feature
 is present
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<dan.j.williams@intel.com>, <bernie.keany@intel.com>,
	<charishma1.gairuboyina@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	<daniel.sneddon@linux.intel.com>, <antonio.gomez.iglesias@linux.intel.com>
References: <20240407230432.912290-1-chang.seok.bae@intel.com>
 <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
 <142380d5-27bd-4ddc-8c33-03a2f8701fa2@intel.com>
 <20240422213213.7og6adib7zcbpnys@desk>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240422213213.7og6adib7zcbpnys@desk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|CO1PR11MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: ca18f1d4-d70b-48b0-a37b-08dc63196436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SERDVW9zcDRHdnJaejFJWWFhOVVwNjdEU0x2L3pCamJReDVwTG9WUlN4bmNQ?=
 =?utf-8?B?OU9VdVFVWklPV2lqcjhTNDM5MUtSRk9rM3hEaDFhMFJCUTZQcDd2ZHVNa1di?=
 =?utf-8?B?Z2pJakhza1hBUzN2MU9wOWpYbXJXVk9iY1RYdnJzWU5jN2lSWDN2NUVlWVVY?=
 =?utf-8?B?eXVVT2V0WUZtbVgxQjhHVGJ2c1VLUzJQTmc4VHBiTXVSRDhkMUdZMXhUUFE4?=
 =?utf-8?B?MzFVcDFubVJtNk1hWkI4V3h2bFU1VzhEYkNUVXZDaDJEQ3UzcDBnc2dHMjVi?=
 =?utf-8?B?K2pEbjZLOStEWlNDMVVQd3BTWTV3RCtSK0RPL2J6NC9rZU1oWnhNWEEwNlVv?=
 =?utf-8?B?V2J2N3FPek5HMTRNWVRUS0syWDh4L2FOT3QxZ0Jma1J0RDcxeG9rVmc1blFj?=
 =?utf-8?B?dHNEUVpXNUlvUVZKWGQwK1FhbnpVT2VMN09pMm5Ocmw2YVB6Tm03ZjFMd2U4?=
 =?utf-8?B?REN0NjQvZC93VHN5REpqODlPYmRGT1c1cWJMSXJhNk5oUFNxUlVTNjhub3E5?=
 =?utf-8?B?d21DM0lCOEYyUzdlUE5vcVVkamF4dnB4Y21tVTJRSjA0cTFPczhwdzVUSEt2?=
 =?utf-8?B?eFVSaEF0NStLcXRvaUtLVjZsUUM3WGxqOVVPS0FCSmpZV05WTWlrZ1U5Zzcz?=
 =?utf-8?B?VkhQTlpLYk9WUmZueHkwR3VZWjJYOGJWckJoTkZack9ZODQ0TVFJaEtHZnZ2?=
 =?utf-8?B?ZjRFQm5yVnA0ME5SRE8xd2VrOVR3ZW12Wi8xMHR4Tk9na3RKS3VXNnpkQTU1?=
 =?utf-8?B?VjJObGgzM3o3WlA5NEZ0OVJwVGxlOXFNVjZlVTVSem82Wkx5aWI2Zlhld3JS?=
 =?utf-8?B?MDdQeDYxaWE4eWt0Sk4zSEZkSXdSbWVCUVNZNVByU1Bmb1JnVVZFdmZwK2la?=
 =?utf-8?B?SFZRNlZSc3U4RWExMnJwQUVxYk5MRmpmMVhzMTlUQTJWbmdEenNXS1NlWVlZ?=
 =?utf-8?B?dld1YkJGejdnVGQwU2FSTUVSWVZvVXFvVlgzeXB0ZldkcWVlZ0YwVzZsQ0hy?=
 =?utf-8?B?MmsxMk5ya3VqMkhOR3pWeDU4R2RSOUM4ZmFlZXdTS2FRL21KQlR3ejcza0dr?=
 =?utf-8?B?QVFjY3l2L0NNRUNEUkVxVkVCTmlmTStxQ3JxMzRud21LNy9MU0tXRHRPdncy?=
 =?utf-8?B?bksyQ1AxUTdBYVVpR3hJT3U4cjNQUkViL1U3aXlhLzI1bzlhQjdBM3h6Tkpx?=
 =?utf-8?B?cTREQTNBdVFGM3RsNnYzOHhBWW15QXdqRmVkZHZ4MVpPbGZBYlBINTdoNWtW?=
 =?utf-8?B?Rmo5TmVMSjRHVkkvVzAxL0gwQTUxalhGa2RkVUxIdDVTQnlJSUlwUUtCdHND?=
 =?utf-8?B?OFVLdENkRjJHeG5kOUlVSGYzVnhHRVl1RWs3Zkp1ZExwNVFJYnJxVkhCMTBv?=
 =?utf-8?B?ME1lTzkzUEloQzlYd2xsc2c1SXRUQ0RpMFJuQU11V0FpTGo1dklJVnQ2SmVp?=
 =?utf-8?B?Rm9tOFdqRTFjZVlpMUhDbTNVSlkwNGpDeFZiV1BsVEVqRnMxWDhTd0o2d0Yr?=
 =?utf-8?B?TDNFL3NCZE11U3VEdnhxODlkSmpKRGk1U2ZvU0pxWldzSzR0bXFtOG5nRlll?=
 =?utf-8?B?Zk9NaU50ZVZ3dHBrSjNyYlBKZWljWG8rc0pBaE9RSzVUd1ZYZDdvRi9jUVNj?=
 =?utf-8?B?djAyTi9wUVk3Q044b2tCMjRIWGhxRmh1MnYrVGl6TmRLdFlsRGdobGFja0R2?=
 =?utf-8?B?elU5b3pMR1VnOVZOazRwSnFTbTVIcU1ndnhLYnJ6cGZSRWdENEVqd1N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VueU9QWTdkczBrdGtsZmphUlJzVHpjZVBsTE5pWEJtYThub29EdzFzVm84?=
 =?utf-8?B?ZHRGSGxVeXVCZHhwUWw5UVBLdFRCVjA3L1U2SXFUVElqS21WUkg2UW1ZWDU3?=
 =?utf-8?B?S2t4Z2JNcnZ3TmRBTHBjMUNwbnFVSVhQc3BmU2hEd2ZLWjdFYm14Ujl1RGFC?=
 =?utf-8?B?cVJqV1ZQRHVxWi8yM3FaVVY2OWQyRURwTmhldXdqeFdvaUQyRU02NG5sSWdH?=
 =?utf-8?B?M3FHWEUzd0hiUWpEcXBGT0lXcG44TmxMRkwrT0NLYUZZY0FpclhrbzBnREY3?=
 =?utf-8?B?ZElRN2p0WFM5TFVPMnRQTjl1YmdMdUR2bFUyOHFSaDJ5cW1SUnRsUFprYk1Z?=
 =?utf-8?B?MjBrcnh0S29VTlJLOFUyUEY0YnZVbzVwWFluUXo0azNONFI3L2RQNVlDQ3pY?=
 =?utf-8?B?TzNoY2lzYUUxSTd0WVhoKzFXd2RFUzQyRzErQXM0V21vUUJEdmc0ellkcEV1?=
 =?utf-8?B?VUpEdkVsZG5pbUxjaWpPQkl5ZlFpSGU3c052SWdKaFBvMzNYVVpydzFhbFNi?=
 =?utf-8?B?WThSa2lOSEZ5STJCbjRmelNsblNadnNraGFDdGNxaGlPYXNZVjNDYW1mQ2RW?=
 =?utf-8?B?bHV5QURiMjM5bzNtODVpVkhJNVFFekRWckhsQ0s1R0M0eS9nN0tCcnRHSmxW?=
 =?utf-8?B?UFJwb0VRNG9Rc0tuUDZFWktqd0x1NENaQmtSZU9FVEtFdVJQTnZXZ1RCeEEx?=
 =?utf-8?B?TWMwcHM3QlhrNmRpQWJVN1ZrWmNSeFNCdU9LMDVVVEYrMVFjRC9zaTlaSkZr?=
 =?utf-8?B?c3BiMmlzajAxdU5FN1lCaWdHa1NkSzJGNmt3T3BkdzJUWG1MM0Y5QnZMRUZ1?=
 =?utf-8?B?Vmd3ekkyTkZ4aXV0S2hwR2dUZkhrSU0vbDBraGpzb3creWRGbVJiWXh2ZzVu?=
 =?utf-8?B?WUhBVEpBYUY2V2xrYXBjNWI2L2JMMm0rSW0zamJMNWVPMm1jQ1N1bTFodDJO?=
 =?utf-8?B?QUhNSGJPNGZDVGYyZ25IVUE3ZUlGMVhTbHZ1OUg4Snhpa1p1V1N5U0dyN0JW?=
 =?utf-8?B?cW1UQit5TkFFNHp6aDFoUEtBd1A4SllzNVFDUGJodFhOQUVJYXhDOXVpSTF3?=
 =?utf-8?B?SXpGZzl0dHVuYUdYQlNkWnBheVdKbTJTOG9iNWxPNnlML1kvdWpiSzB0Qk1j?=
 =?utf-8?B?V1RxTFA5bHduZkdPVTZyUTJpclhVZjNTaE5WT0N5V0tTUnRUVmRMbWx1QXUw?=
 =?utf-8?B?UjhROUtKNkRBL3ZoRURZT0JFOUlpTkNXR0lhdXYxbUcyZ0xwc1kvYnU4MmRp?=
 =?utf-8?B?YVNzZEI2aGZrLzN1QlJhY0dReTFSYUJZM1F5K3BCV3VMdHhObzljK3QySUZn?=
 =?utf-8?B?WFFKRDhrVDZNdStickxjdWl3Z2JSMWpTNEZVUE1qTXFoNitrSU4yV3daMStG?=
 =?utf-8?B?U0RoazkreXhIYkhsSXIxbURVSzBLWGhWdGRzOFdnOG9Xam8rcEhTYVlpYXhr?=
 =?utf-8?B?RkwzTVZBUis5RTdTVlc4T3dLM3BncmozRWlIcDFXdm1vbCt4NGM5SzZZbHJk?=
 =?utf-8?B?emRxTmQ0T1QwNi9wS3BMdWg4QUlpMmI3Q0lLSFBPeHdZc1hub3o5UXpGQ0FW?=
 =?utf-8?B?UXZ2Vmp3N1ZXeDB4NEhiN053cG0vbHY0WnZvQW12dzZhc0dpL3c0M0hMSFR5?=
 =?utf-8?B?Y0FuSm9yYnZycFZmTTQ5WktReWRWcDBicmZMZkM4NTIzc3JxUS9Rc25YcEZm?=
 =?utf-8?B?dzdyRi9pYUc0SmVkbk1rUHkyWGxNcHFianpEQnBzUnMyenczUHRrRzVZZFdm?=
 =?utf-8?B?cWhWL0NHM3dTY0VSR3A0QjhsUlo1WTlNR21xc3AxNWFEb0ZsampzWTFTWDVE?=
 =?utf-8?B?clpUK2xYSkNKekRtSGUzNXBuM0xubk5HaFZmZFo3Qk9iZDRVWEF4RmZKREtG?=
 =?utf-8?B?VjJMaC84b2JMRjVMaW83dXVxcnhpTktyY0YzcGRSTXdIWkZKQnFQcWJrLzFQ?=
 =?utf-8?B?cnZUd1ZiUlkwUFVqUkhVQ2hWS2JJS0VZK08zTmQ4RFdCWEkyd1Uvd1R1MDZO?=
 =?utf-8?B?WmlCKzFEUWpOakZEckREaFVJMHduc2hoMUNubWsvcWp6STV1Q3IvZzRnMXFm?=
 =?utf-8?B?Tjd3V3QxTmh1UnNoNHpqRUtHbUwycTFxa3UzUXhncTBSY3BsL0pQR2JFcTdZ?=
 =?utf-8?B?eER2RDBnb0Fnb0lTVVNpK3o3d3F5NG51d0xyN2toVGdscm1aMWtjcGlDZWp5?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca18f1d4-d70b-48b0-a37b-08dc63196436
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 22:13:08.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqapTMqEDflL/og8Uf9rPQgePsRh7RYz44eFhmV6uGCSCPrr7NDC1uXWMxmTd8P9zjckiSajFC/lxG4goHQvbI0DnRMyl9Xm2gFvG2D96pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
X-OriginatorOrg: intel.com

On 4/22/2024 2:32 PM, Pawan Gupta wrote:
> 
> To enable Key Locker feature, "proper mitigation" is microcode mitigation
> enabled and the GDS_MITG_LOCK bit set in MSR_IA32_MCU_OPT_CTRL. Do you
> agree?
> > If not via this patch, how is GDS_MITG_LOCK going to be set?

The lock bit seems to be set by microcode when SGX is available. 
However, if the lock bit is not set for Key Locker, it does seem odd. 
Introducing kernel code to override this situation might be seen as a 
workaround rather than a proper solution, potentially leading to more 
confusion.

I'd rather investigate the behavior of the microcode further, verify its 
consistency, and gain a clearer understanding of the requirement for 
this lock bit.

Thanks,
Chang

