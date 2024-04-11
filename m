Return-Path: <linux-kernel+bounces-140324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913738A12CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B480B1C219BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E2149C7F;
	Thu, 11 Apr 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gK4q1bf/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50050148319;
	Thu, 11 Apr 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834187; cv=fail; b=bPFa+0Rs0q9bL+s6O8d+klkrqeyP5FSDMAt2pUnz6ESnK9zuJIohUzgUqWJGQpMio6S29G7C4VhxCLhmlLKOJskB5bj/fpHBcb2yi6D/gfV9uFrttxYKAplRWcBpYyOP7cQAtw9rCsFw1MWAHMpG3M8uEghkEb6nb2yKVdvetIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834187; c=relaxed/simple;
	bh=HuiervImBh+WB5DxH0FrRH6zK0yDO47xG+rhETqzEwk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a5Yp0/aafOj7rb821rAmbS2kIndkZmlAiAtMnqeiJFl6lvMwozQaPrdtDsjBj7xRmS8e2vOYm7RnZLV9+0RCpueA3S6kLorJny4pKDzoKXwR5yfmfqdcyKWGabqlhEBK+Kku9Qk6Q3njQ6NuMhiwlC/aXZNDHtJiA5pq6X7QT7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gK4q1bf/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712834185; x=1744370185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HuiervImBh+WB5DxH0FrRH6zK0yDO47xG+rhETqzEwk=;
  b=gK4q1bf/44+Yq3EtR0XHng2nHFkS2iM5LCZRdL6VdCH2WMgdxQDnEH1z
   VeRXwJ1YNAccUvpgWW4dwOFShQYgWOMU05FZ7RlRXLg1P/kU/E/IqUzKO
   o1ijy4t4BH3cjW9GK3yTA6fFime8m1Clu5hvc0e+tpbcX30smMGuCTxrb
   W9eq/Rjs4GxYTkIUhuZ2J359+Ez7F5S51tFb2mx0VUz3Up0Ma7mrqedkI
   sZvU6Z1sKSgIIac0al2YJke2doG/03LdCr1A9prr9n//+HA2izZxYoVRZ
   aLQVncSuo73jUdchP/+R6d1QZpuJMF7gaI2CTte+wBoXR91rNTipV5f4Z
   w==;
X-CSE-ConnectionGUID: rRsKeVz+Qz2QA5Izr0IfsQ==
X-CSE-MsgGUID: KiEODA+OSNOEW7FM/QIHQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8101002"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8101002"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:16:24 -0700
X-CSE-ConnectionGUID: Sk/lQeAuQXioRK+x73d6gw==
X-CSE-MsgGUID: zg8ois/5TL6W/vlfjfiRXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25648038"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 04:16:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:16:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:16:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 04:16:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 04:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO1zyraS4jZOylHJuEWz1rsdVd5KcYsfg4BVDdRgz7oafurHoAjKQ5pbs14aiSgdpLQYkO5M7bZ326Pb1lYNFkyj2TC2dsFYlbLF1rh0cNbjPCPqc+UGEwuEW5z9qpLi3eVtAydTfsOPsdVJHE04dLLOZk4Snym+UOfPshKBZaDqiD1blgX7EyPQ5GqjvvvlNVk8TBANRBg16KqWsW2YDmYiz0yQXJCE0tpAThT6xFak73G6BaNoaCFQof4f2B0+rgxk/LokwpLr9bCS9s/xGz1o7QyNyt17d8Tc3OJ8Qj5XkUtJ7mGOV64bw99TpUMMF82iLATxuON2bslp2WfzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mpy1NbY8hwjxonFxa9fQSaO79BWZPzOOBMrt4RjHB8=;
 b=gLiyJD9rUTYvGCOGks+EMIKCKy2wzzLNgwytYz957QCgXw2x222EBzf3u4f7p4hoIii2xNnZG0r7YCfWDicymYOIHlIJyJFae5SjHfHfhvcGM1mpkXGLvDxf0ePPM3wgt3jcXAqn84P6QsSdKKpOSO43E6xp3zmhuvPmzfD66L4W6zfTnflD/SjEGpogUcNzx1R7FqMfXm5yKYBXT0hFr62vrz54n0oBWgiCiZi/vJlJr29IYmVPryS2J53a9dDJfGXkjLacuWRmvH/Q67vizxYXPq9qaTGWPg6q1wwHaQkflEBKZwGrK/OhNTutKYIQmk2f5umDPnz//x1faDKvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 11:16:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 11:16:21 +0000
Message-ID: <80d765f5-1436-4799-95fe-ba05c0681d5c@intel.com>
Date: Thu, 11 Apr 2024 13:14:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: fix struct_group_tagged() parsing
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Jakub
 Kicinski <kuba@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Keith Packard <keithp@keithp.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <linux-doc@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
 <b9804c32-9ba2-493b-bfb8-a6ac4f108175@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <b9804c32-9ba2-493b-bfb8-a6ac4f108175@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2fe132-ece6-41d6-cc51-08dc5a18d0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIPGFUW5/lCGBkA4hYTVuIYXGcLzOWuLTg/Rxsr89QL2hwmrPB10Lp6/62XfDbT28b9Txs1ZaRfHP+rqvEhDpgve2WKBzPHUlJpxvWB7P4do5JFgdzPEDqYtcdrblx1P9ogrpTwHxV4actAoZySHdrqQcpIeXb4yUrmQidQA2dNYis2LlBdMqZPkPZz43RzaW1Sy/1o9rhBSpmzd/kf6svDzRg/RV/LM2em11nyKuCDn+gpRuBKhIxT+z7b8Iyd4tT4fsYpUKmLXWlIuGuovWbtd1wjlPo2dJHIynp+QpFXQijz3HIt96uKUy7HscnLmv6xwad011ELSm+wPGorbtT9SfklXx6M7JpC9x7jqxiKeAABsDSk/SHpW3VFR287JjJOqPVYcQETSbAzvfkSN+obMm7y125YXz0pyaOYChoU3eCZNSve1bB5MUDZXRuuKG0hjwQst9DcaE4TtJpw0Cg9O3qLvMAML+qGdPAvjFK/okfdVfN5t+7BTld1M+W0RGkp+ayt+tARL35Cle18ebmxuMBrxgq3eeLyIg0rAriR2xqeTGFtWyzRUERUjWN9Rcb3m/ivMAu/0jjPHxxQ9A3BPanChfM6ZcdEy8BnztvxJAIHZ/3fnN7mQ6jWWGtYsMMxGCZSgSYs7K/CekAaXY3m+1GJ2AOqKT6TI2Za75BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNReWNPWFZTSEdFVWFicU5xTEkwTzFyVWVTVHVtZHFCV0grblB0MjBSa2R5?=
 =?utf-8?B?OUdKcUNJdWp2YUFQVTgxUnRMaDNPODlGdVE1b2lHdHphWjFCcTk1OGxERFBS?=
 =?utf-8?B?bGt1cEtjc0RTek5jZDlNSGJla2ZUZVJ0em02dWlKUTdkOVhhdUovanlRSTVq?=
 =?utf-8?B?V09kUlI4NjR5U1pMZE9tbkFlZ3NVRGpQU3R5NDh1cnZOSm51aExVVzRqWFV5?=
 =?utf-8?B?b1hOK2dmb2c5UmZtVVpiUnlST0FiWTVHcCtib0R1SDVnNDBZZjduYTBRN3l6?=
 =?utf-8?B?NDFHUGlMRDREK0dZNDdDRGhMNHJKc0l4ZGZtQ3RnR3VCc3psSVBXeUlvMmZP?=
 =?utf-8?B?aFJQb3d3WUExenZWL1pac0R3TnFLT0xRdlJtMVpxY1NTeTJNdjFadENsZjU5?=
 =?utf-8?B?N2VrdEx5dHZkWllKaXBQdTJPUmVVMkpXVzBsMWZsVjI1RklBbDhpQm1XTkcr?=
 =?utf-8?B?MUlIczM0N0dRR3g1OTlNa0lObjRaYlpMK0xpbU9NNXVWRUxhSWNZUlVHVXhO?=
 =?utf-8?B?dDNRVUpFTWxscXVscWQrZEJETFhoN0ZaWkV1YU9KRW1ycmsybW5tMjJ1Q1dN?=
 =?utf-8?B?SERpVXJub3V2VjRyWVFBTzNzSFlod1h6U05mTUtEdHJEbWpJTHpLcXF4ZGgy?=
 =?utf-8?B?UWFzOW9rOXNqT3FIZmhveGlLQS9vZVdoOTAweTBjU1BDOVhaMWZ6TTBCRDRQ?=
 =?utf-8?B?Tzk2cUV2b0UzWHFQMjdwMzFkbm5ocjVUQytxeWdhU0l1dVQ3cGFiYzM5cUhV?=
 =?utf-8?B?K2RVSkJTSXR1QkJJUHlpMjdLamdNTnF6dDkwVGpJL2J2L2p5K1NYNSt6QXpN?=
 =?utf-8?B?d0lnUWdaQThITTVhOHJRdjE4OG5ueUFzTk15aUpDVmw4R0pmZnJGYVNveHFw?=
 =?utf-8?B?b3RiME9IZHdyeVU0c2h4aVJSeFFxTmZxU3FSN1Jjc0lRc0pmL1dwelYwMGpq?=
 =?utf-8?B?UkJLNnFkUlM5Y2hRblZzRWd5TlJxWW1GMHhBN3ZIMk5PdVhsVEY5MlBtSXk4?=
 =?utf-8?B?Q0xCY1g4M3U0dkZkY2psSTUzK0crcTFmNFM0MnlTRmZPdTltRDd6ZEVoVGUv?=
 =?utf-8?B?VFJVM0EvT1UwaU8wS3NCQkNLSllLbEVDSWhiWDNNb3FncWhFMVF2YkFaaU9G?=
 =?utf-8?B?Z29SWnFnL3ozYW1DbnNqL25YeWhOcTFZeWFNNWVLMUJNRUx1VlppRGUwNmxE?=
 =?utf-8?B?elRNQUdrcy9sai92OFM0VnpiWGIzVytzaG1NMkU4SzR3Tk1IR0pmcmpRQlVZ?=
 =?utf-8?B?WTVReG9zVzcwREFmN1VKZEJWakhrdjlBZ1ZjN2F1MUEzTU5CWVB0WWpkTDdh?=
 =?utf-8?B?VG4vUmQ2NEFWalZoTllZOStRYXZuT2RmUHRPS1pGYjRndGFUa0FnZVhtWVlU?=
 =?utf-8?B?Q21BNW1xZ0dLZ3kwNlZrUmIzb3pqQ2VKZ2NJamdQSGtHeVhqcmZpbjYzUWpY?=
 =?utf-8?B?Y20wWEZPSFVpTU9lMm1JQythM0JaRVljTHFJcnE0blVTVXBFeWR5SThmL2tM?=
 =?utf-8?B?N2tkbEpqTVhxb2JCYWFZSzhMVTFEL3pFaEdLUnFrZTQvVnF3dkROSUZOVWhp?=
 =?utf-8?B?TERqbWxuTHdCZEZYSExIcnJCRlBibXhtbzFrbXN3MWRWZ1JQUzAvd202YXlZ?=
 =?utf-8?B?VXpuc3RYYnJYY3hWVjNyckRHUmxxaUNpeVFPak5JaXY2WDQ1ZGlEdjVKTUdn?=
 =?utf-8?B?NzBueGg3Y3J5eTA3UGtUS3Zkd0dJaUd4SG1INVg4YWhWZzdNYUV6QnBhRm5q?=
 =?utf-8?B?R01qOWdFR1Y1MG9HQy9RbmViV0RDN1NsN2poNVgycU9KeDJ5RDdnQjN3dW1k?=
 =?utf-8?B?bm04c3U0UHhmT040d0thbFV1eUcxQTBOOUMwYXJsK2VrQkhIM2JQd0tpQTVa?=
 =?utf-8?B?UzdkckNyVHZaYVROeklwYmdrd2ROSWZSVjJmVGh6cm1WVnRVbG5WT0pnZi9a?=
 =?utf-8?B?WW4wZHdmZnlkY09LSzBFejBJRGpUM01la2RJWUNwQUdtNFV2aTFYME1mYmJl?=
 =?utf-8?B?dG85WWhPUk8zS05oV2xNL21vVjJ2d1BhSEFmUXU4dEZ1eWdOK2ZpdGFPR0Vt?=
 =?utf-8?B?WnptS1NuV3J4ZzZqWmtKK0xNMkZjUVAxb3c0RGVSZEVlcnRuZUw2by9jaVJ4?=
 =?utf-8?B?S256blAreTMxd2NwSkJMU1QybEYwMHdSV3JIVVI3SU5OZkhWS2tMOXdGUVUv?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2fe132-ece6-41d6-cc51-08dc5a18d0f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:16:21.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7QCavuYuixxP3GkMg+yki49cU51aycRH3zJYKuAhFeZuVY3PIZCclHAZQXRVJ3RSnYjbPfTHUc2KNVX2liDwmk51K4Tn5+oBJfBZuh0/yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Thu, 11 Apr 2024 13:14:20 +0200

> On 4/11/24 11:32, Alexander Lobakin wrote:
>> From: Kees Cook <keescook@chromium.org>
>>
>> kernel-doc emits a warning on struct_group_tagged() if you describe your
>> struct group member:
>>
>> include/net/libeth/rx.h:69: warning: Excess struct member 'fp'
>> description in 'libeth_fq'
>>
>> The code:
>>
>> /**
>>   * struct libeth_fq - structure representing a buffer queue
>>   * @fp: hotpath part of the structure
>>   * @pp: &page_pool for buffer management
>> [...]
>>   */
>> struct libeth_fq {
>>     struct_group_tagged(libeth_fq_fp, fp,
>>         struct page_pool    *pp;
>> [...]
>>     );
>>
>> When a struct_group_tagged() is encountered, we need to build a
>> `struct TAG NAME;` from it, so that it will be treated as a valid
>> embedded struct.
>> Decouple the regex and do the replacement there. As far as I can see,
>> this doesn't produce any new warnings on the current mainline tree.
>>
>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>> Closes: https://lore.kernel.org/netdev/20240405212513.0d189968@kernel.org
>> Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>   scripts/kernel-doc | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 43a30f2de513..01ac8f794b30 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1152,7 +1152,8 @@ sub dump_struct($$) {
>>           # - first eat non-declaration parameters and rewrite for
>> final match
>>           # - then remove macro, outer parens, and trailing semicolon
>>           $members =~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
>> -        $members =~
>> s/\bstruct_group_(attr|tagged)\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
>> +        $members =~
>> s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
>> +        $members =~
>> s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2;
>> STRUCT_GROUP(/gos;
>>           $members =~
>> s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
>>           $members =~
>> s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
>>   
> 
> I would complain on code that matches `[^,]*` part with 0 characters,
> meaning no tag for struct_group_tagged(), or no attrs for
> struct_group_attrs(). In such cases simpler struct_group() call should
> be suggested. However, that issue was presented prior to your patch.

Rather a subject for checkpatch, not kernel-doc?

> 
> This is clearly an improvement, so:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks!
Olek

