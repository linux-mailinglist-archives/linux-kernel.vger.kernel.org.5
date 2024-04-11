Return-Path: <linux-kernel+bounces-141413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA3F8A1DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD8E1C24D82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8785940;
	Thu, 11 Apr 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8e1HR5R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6E85645
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857108; cv=fail; b=fqXM618wlRBYQldDhWTwXYOLCwRKjl+BA1arSX28nl9fepQs70JID7V39LXWJhqiPD011J0IvFo4nLzJx2NB6UtywYDaz9TP/xXnEmM+LPchx4v8gfzsMtmLG2DnHoI5XJu29csHoozW8eTkUh4JzRN6QsJjNpJLs+Wx0tNXT/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857108; c=relaxed/simple;
	bh=jQVTpeVPRjO47q1Uwpl6iSlZOxoLGyKIgYmIRdowVuo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5cVMLqFaqhwc6enXv2b1iE4m7aZt17gOz3p5zflHuub2GUXCQ7fYnM3G6hzy7flcTQcvIIOrWiqC0cITyg7pkhlF6mroxEaTJv7rwgTD7xhWlOO/O3rB5ipQkd7EbxMTyWs0NZPGo2sTpO8Q/45VPT6SLLjClTifwZfRo1wMQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8e1HR5R; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857108; x=1744393108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jQVTpeVPRjO47q1Uwpl6iSlZOxoLGyKIgYmIRdowVuo=;
  b=H8e1HR5R2uwIV6Ok6plnvDQu/7KT+jt/PG6oyGJhXcfRx34ZeiiiNpbG
   3ungvX4Dt/DW6P4fhIuGwwT74HmxERDUbJqttU7pn+xS15tGUzhfOA+LU
   umP/51A59G2mXfbVs8iVVxzz+lUBuyL3jRmHuYTxOJa4uafaIRI8CC3qi
   Hw7jeghGLv5BtyyApvdsne7KIc4yMh93K8IvrEdeZckxTkWcV5Uf0LFZd
   qAgt668XF3oLl40EY1vsljFhSY2I7VrRkmciYeoN7doFmc3PUUlwcpK8Z
   DwTCcvjOG+/J+w2d0osVDSHzSCoNKDUtBAGGNGSYWJRsH8qO+FqFHBCwP
   g==;
X-CSE-ConnectionGUID: oJggqvkpQyunupd1TQPymw==
X-CSE-MsgGUID: FEuUtlHXRqSAng5u9Z043A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8507793"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8507793"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:38:27 -0700
X-CSE-ConnectionGUID: I6IS0pDuRbKOgvlSKKam2Q==
X-CSE-MsgGUID: bNQ8Wbv/TzWAplAHi0uI6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21413421"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:38:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:38:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:38:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:38:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKIOqPSEne1y/ckEncCHuDKgcpyAWmiKaWn9kRy1YzTFVNt1bkM1+GXeLo8CqMRQyhx0j8WMBJ6QQEDgLvIrp6CkYX6KN7QAcfQIkOqpYdovN7hPVouCgT+FiFWr5oNFWxYySOQHhPuPFwBPmp5sle6+uHOnCPkwagsHv4s+LJ3ffTZ7oAYb5gJ4gLxNR4SRSfssE/+ylQqkiYGzrWJp08tIRtlp9OB/RBqZJ/XVoy9ZA3WCqFHI41glGnZd3STc3vNZITgtFr6VainiA3cT6dzoUlpyimZ+ZZu466veoMrezjIKNbxcExBNP4PFtrAFWETryWzOWKnzHkHCNPw6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48KjN8Qd0+yhSIAMehC+fBksCyerLYirtf7A0+L/wNo=;
 b=agkXMmfC3gBHGXcnlUlWTeDzpzAdoLoDFWZWkbcWsAWFfa2huDdfNqwC1gqDSmdrttERyJzlq6y5EsU+KoZhduRWjkKb+IPMn1cgK/f+AHM3NlE1ma9TrtOz2c8pj9DsoMSADN4IMrmmXiDy8G33CRYD0uJq4mIJZqCX3Zf9UGgftkilxgna/o4GRdsIhzL4idoPCKMHPyGovTgraqzeZoAwVwL/6ZkZYoUrnhEA3V+9VaPox7ITY3GaW1StyiDb160b2Wxxh/1BIuRSPCXqopfUgI06JCWWZ1aSMeW0vucgtI8ID+NPe2pj3BRiFpyFVqm1pV9jiGqiHuuq1iZ/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:38:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:38:22 +0000
Message-ID: <d269b5d2-bd6d-44b2-8d99-0e0a2790bf50@intel.com>
Date: Thu, 11 Apr 2024 10:38:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/31] x86/resctrl: Move max_{name,data}_width into
 resctrl code
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-13-james.morse@arm.com>
 <fc4ee516-54b7-47cb-b881-00ce10d311a9@intel.com>
 <ZhfwjBJPeTvO04BL@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhfwjBJPeTvO04BL@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: d618967a-f612-4ffc-2d4a-08dc5a4e2f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO5TEox7gb/U8ihJyfIGj1SHFZSr2WgpACXXLz87fMF5qmmp5bbANL9VFNfrw1gP40guA6+yrxeoifLQ+kV53Dg8DMUandxXm4kXIx/s2W6aU+nPMSK06bmjK2uz7uqdymj8RLRL1WEmmFmYniPeFDmM3H0Sk8GUQqanPFdXtd5C0ElvhGZy6yT2tkc3F2aRKiP/CKw7bnp9vQlXtGJznXlgj2MAgKbjZb7IRx5fWmhGA3aXzezBbj+jX46R8btFZi2gvze/QGXn6QRhGpF9tukepKjDi7D03g4dccQvwRkmUlWiFF9kz6wzThqH5igurkxyDSJLi96+tHvDWzZQXL7sa103VInuvjBYsv5054xU2SDEegp25zVtptvKRm9JgPj9Ii/hJSYtNLA7Lr+i6GjHPfG+fhIoaH+X+R8Gwji28BkMNRZw0zZzOcY/jbYAL4KcVt80oJfNEszULV65v0R7ZbvRSDZf7foR/VastklxUHdL0nbKQr1hrAvWloOu1+VV9Zo2DPpj3euJr5eBHnBFlH1fTSndgtsIN6oCcfMiDRvhh5BvRP2Nuc6KvuleTz9Ym10VCo7lkN6WArFPgEsO7ckifMi7VvUoOKczIXmXvGw10vSaU3YljgQf9sco/R3pl3PgcbSBzQfPcCtMOuvkTdEYkng6Tuupuvh1zYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRVN1ltRHdXQzA5WXFCY291QytnSHNtZnhnQ2Q1TklaOVNtN2Z1Z0VuWG9W?=
 =?utf-8?B?a01lak5sRmhlZXNPWmlJTFZYMmREQnRieTFsVjd5ZXh0WXlpN3UyVUExOXRq?=
 =?utf-8?B?UzZxdWZTMkppYUZVeHFHdU5Mbm8zMHJaL1Y5WnYySjFCTzY3R3lTcDYxUjlq?=
 =?utf-8?B?cjIvcktLd21sT09GRHZMRXZSV0N2ZkluMXhjTlNoaFB5RkFoS0dCaFNEODNK?=
 =?utf-8?B?L2w1V2dRL3IwUWRWKzBBWTlrQnMvQ2hnZ1haNVl6b0RyUlM5TE51cktUMGk4?=
 =?utf-8?B?aENOaGlVU1NtMGtRcFg5bEFLUUUvMnFHKy9ybGdFdkpoZUJYTEg4SU9nWjF0?=
 =?utf-8?B?eVJFc3dnTnNLRUp6V2Z5NGJrWjBueXpGMDlJc1VaeURYOTVoV2NEMEF6MTlY?=
 =?utf-8?B?dkJnYWFDOTZUZ1h1bkZjdFMrZU0wNy9wOFlTNTR4b1JXZmlFOEtjdUxsQWY4?=
 =?utf-8?B?Q29rTmJhRUM2a3lUMHFRaEp6allqdEtuNnlTeDI5Z0MwaVY3YWxjR3NNaGJ0?=
 =?utf-8?B?K01iMEU1azV3MnFTSzNENHB6ZDJ0RXZwd3FrWjY5bXozR1NWV1h0dDJTTnl1?=
 =?utf-8?B?QWhWMW5OeTZqeHhkNE9IYlFjdTFGWXdwU2VRQTFscDN2QlRGVnhsUUovdVRu?=
 =?utf-8?B?Qk1hUmt0bDFXVzdqWXRpRXFKNnpSOGFWc0ZJeFZHczczZU16SUkyN2tnR1p3?=
 =?utf-8?B?RExQNjJyeXZuOFpxL0ovTEU0b2k5N2N2ZjZOYWp4L29SOG5uQWhMemJqSGlT?=
 =?utf-8?B?cExnZEtmUnJvTEx5S2lpVnBkM3k3K0JrYlZYUjNUbHNmUGNIZlpqUmdQNHRP?=
 =?utf-8?B?V0VZUi9hOHFQRjhxMXdnWnkwTTlWV1gvVFlLdUdTUStyMVpxZVJRSlVlekVx?=
 =?utf-8?B?ZE14YkNtZ1dTR2FkeWdRbHRwdGxqTWNuRXQ2Z1pRTDE2SHhwaWx3N2crYzNY?=
 =?utf-8?B?SU8xanAvTDVxQ0lsUkNVaThad2lQTDZaNTFmaE5DNmg4V3NWZGFzZk9iSmpx?=
 =?utf-8?B?Y1hGTWswdnAxSmpLYjV3bUR0NGR4SklHOXNac1oyQWh1R0IwYkpTMHg1UnZE?=
 =?utf-8?B?NWhPcTlKYTZWRE5BTEVlc3VoNkpEdU55amI0Zmo2LzlPUGduZjNzWkhzc0xM?=
 =?utf-8?B?L3hVV2MxMWxwcmVTL0VTaXJCUW1ISGMxUzZxVGQxQStNUDNBWU42Y0dFM2pi?=
 =?utf-8?B?SDhkYTNFSlpRUGdGTTlETTdYSTFORDJoVldtU0RNd3hQTURnRlVyQm1WSzM5?=
 =?utf-8?B?MXU0R21yRXM1RUpiS0tweFNocUVMcEpreDdzM0NtQit6dC8wbzdZRTh5NGVL?=
 =?utf-8?B?NFUwZUlQNEptT0ZBczBVV0tuaTZza2NEdkF6Q05iOWM5Q2NyNGxvK3Z5QUpS?=
 =?utf-8?B?bnp0YzdPVXd6S0ZKSTVZQ0tJVlgwYThESnZmb1Ftdk9kMFVjQUFkMzR4ZjVX?=
 =?utf-8?B?MXJTdndZa1JrOW5sWWZrOG1FOTdZZTYyOUNMR09FUmZQWExsTXVWYjk0NGly?=
 =?utf-8?B?Rk5sVU1zY2F2QkxtbTRma0pSMkxIRUhIamJvQUpucjVxOGNMaThGbUpLa1Ri?=
 =?utf-8?B?VFFuT3FlRGIrVU5CS2YwL29kWDZPVlQwd2JzSnRoa0V5eFowcHY4Wm1tS2lD?=
 =?utf-8?B?S01UdmZSUkhEenVUMzNpU1FQWFhkZHpiRjdlMnBhM3JpWW1OKzhZTnMraWtT?=
 =?utf-8?B?cDBPWTA0MUFkMXBNYjN5RlBVZHRDSXp0L0xqeTBwUkZrUzdnbS9Zc2I3V1du?=
 =?utf-8?B?ekllVEJsTEFoRDAwdHNZWHZudDNYcXNQcjZwdEQ4TFZBQlo4RFJPR0pmT1RV?=
 =?utf-8?B?RFdDTGJWR1dEc3ZiMk1VcFd0SGo1NGUyc0dOcktLY0VEUHA3dCtjSjFwK3lP?=
 =?utf-8?B?UVZmZkFmUks3b1Yrc1YwUVN6NURvaXJDTUl3cXRFb1JBcy9JRS94bmZwVnl2?=
 =?utf-8?B?aDVzQ3p5RFczTWZWUzZ0Wkt3b2dHVUNzMzNXdUkrdzdsdG1zZm5aZExPM0pL?=
 =?utf-8?B?VDg1dG9hYjdZY0hBdzNlUXV3VjNOTjRkS1NGSUoyRkdOY3BWdDFnTDRqb0M3?=
 =?utf-8?B?aFhGRko4UlR5UGRPZ1dOeVBPdzVmbTlHdjJzMXY0QldZWDBSdXNUbXRtMEdG?=
 =?utf-8?B?MU8reFJyeXBMOWE1R3BvMWhCZ0tlT0xOaVlJcm1ocjM3aC9MaUlXTDlqeGZl?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d618967a-f612-4ffc-2d4a-08dc5a4e2f2b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:38:22.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdJllpic3iOnZsSAOywt6KmlJhOI5bzTl1tFLTCuLuTQ/tAgdO85Ogd9eSZ/mjlBLGPCAlS9YDg8AdHMRB37W2Oqac0/5VpILRp+l/Bq4UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:15 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:19:15PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> @@ -2595,6 +2601,12 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>>>  	if (cl > max_name_width)
>>>  		max_name_width = cl;
>>>  
>>> +	/*
>>> +	 * Choose a width for the resource data based on the resource that has
>>> +	 * widest name and cbm.
>>
>> Please check series to ensure upper case is used for acronyms.
> 
> [...]
> 
>> Reinette
> 
> This patch is just moving existing code around AFAICT.  See:
> commit de016df88f23 ("x86/intel_rdt: Update schemata read to show data in tabular format")
> 
> Since no new usage of any term is being introduced here, can it be
> left as-is?
> 
> There seem to be other uses of "cbm" with this sense in the resctrl
> code already.

I am not asking to change all existing usages of these terms but in
any new changes, please use upper case for acronyms.

Reinette

