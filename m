Return-Path: <linux-kernel+bounces-135110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35AF89BB4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166E1B225B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C5F3D964;
	Mon,  8 Apr 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O31aLKrh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3A3B799;
	Mon,  8 Apr 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567512; cv=fail; b=E58gMBnKGkCSgwtG8S47UhlhACcwFPn1a0Cso/bADEj1u2OoLRPpghzghEUHIr3U0D6xwrdgiPv9+0L4m+loh+6TBd78bPxG5TCgBYLB9PWGjEjzRiFfOtRu8AVR45DT4yf4GJ+ylJ3KrQNM4tsFOKj5wpDnLfMwhcA74lxvNNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567512; c=relaxed/simple;
	bh=wvtuJ1XivU6jajhmad12pCEYOQ4c9y/EcX1MxVB4HE8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtoX0+B/SqfF1cXC9Mjk/e+ykBVQ4gAY+qCjT7kJQwPvqK0ZzVd2zqkkjSA9ESLvxEJxIFBT/XAZSzhSWVmCw+QQLmGb1k47WZabQZgCsC9/VVQeQ0IKyXGkOWevp7lZLbVqBwRculWoLpPuUwnkcL/vMvTFmRoLCC3gy7LhlWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O31aLKrh; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712567511; x=1744103511;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wvtuJ1XivU6jajhmad12pCEYOQ4c9y/EcX1MxVB4HE8=;
  b=O31aLKrhY8vLKzMk21bxdsejh1/z7UVdNqGcT3wHnuYbBRYeEroRrmyX
   S04mHERfPGGV/mFebuk/OE4XxepXsfmk4hqTzpmBuE54LGkylqJawRp90
   c31QLhd414wjy0wnrfRswHBXpN4UXB6iw4efAeW0zX7MG3UwKlePWAyPH
   ivwABjHTnYlwysXibBB/bwNolbwAXqCjq9uoP3zxTvj1liAQx6Raj6HuU
   wcecaHLl1JZrNSwTsYe7WE+KpP/skJXZGJq9KaRJMUPq2XSa3+84ulA0/
   pCK4WHVyJXLiW6kYCVzSaONeWGoGjY5b+MOx0dZ7nsLrZwXLpfvK1OhYr
   g==;
X-CSE-ConnectionGUID: qGsyaN/2SaWzGAnN4V/7yg==
X-CSE-MsgGUID: XMaIeFXSRE2SQgdDGa0dAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7999238"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7999238"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 02:11:43 -0700
X-CSE-ConnectionGUID: v7uKLOpSTaCrIIuL/q4eHw==
X-CSE-MsgGUID: OXphSOVISfyBX1FKeWs8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19735203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 02:11:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 02:11:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 02:11:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 02:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf6VYiaenC9Yhr0WmQmZM5hdxgaU41cYEbgWqnBv4z16i8d4Z5uyruhF9skBP6YbhuiXbPRcVX6THcMDCzURNCKXFtlvImAcZY2QlKUWjmuFRHDrFEf0Db12ye0CFm4fo1SserwQhfT0LffDnxx5TuyO1r9juz74dhVTSRcIEiUFSJsAYVBiMBfz2QoJsBSLJ+yGjPCzGubQ4ih8gtmResN17IHyPIdqYao2z48ZDL93x9qjOwHWlg0kj9084YonmDsIBv2V72CD5dpATK527Ze81Y5B/VuFvIszXhkBdyg+6G+KuqKhuVv02UaB8sTuevZDp2Y0c0KD35dX+Kz51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjdQt2OnRIWrvtnENStr6MOwFJj8HSTtifp7HhxPjR0=;
 b=W+NaSi8zhskDgDC6HvgJhHFOK4kdbYNbMHdErJ6cjHbtfmHG/XcNpIFcPniZV0eISy8WnTehwT0eA0e+BMe7AfyLNV2hUZG17Fz0FXg7kqma9LNR6MGExCM26zMIEG1AL1M2HKb+4ufxwR2WJqUlX+by/mndzXDpnkerl6CiCZXqY+wfJN0kIZ8gXWP3mIGgVglCEBF1iu/xs8Gu5M6N0J6/gF217WlwqmlCagPn/nspC1Guuo/pAsSb/LQheqGEWVCPf1OBna4gg3RCZuM3C2YyLtufxEQYB04X46QGXpiUUlYUnd8y5Fv7zh5seONM2t4Q3NvlxF/6d90GTK3HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8321.namprd11.prod.outlook.com (2603:10b6:a03:546::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 09:11:38 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 09:11:35 +0000
Message-ID: <bebf1a1a-e4ec-4ec0-9d01-57a51bcf14ca@intel.com>
Date: Mon, 8 Apr 2024 11:09:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 7/9] libeth: add Rx buffer management
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Duyck <alexanderduyck@fb.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
 <20240404154402.3581254-8-aleksander.lobakin@intel.com>
 <45eb2bf1-e7b0-4045-82b3-93b9f81b7988@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <45eb2bf1-e7b0-4045-82b3-93b9f81b7988@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3p6EuscLA6zHh6bP0Hth3a42p4XKBjBff4C/xhvSxrCrI6BDuD5kSHptep6xLn1OfY/fcolsWOOIIJmpCr+lT+QnXQwpxITePHF6T+xCIf0/smi15AlVijEVDFyP/tH/tnkoiaxTOf53XlItpjxczEsK6ZWFkT5x+1sW99T7gIbX5el8Y6CEzkRSVFW7rdEKDO9YRBEBC3394PE/N1HS8XIFy9XF+gJVFWJZOkUfucPmCeJcn2xgFuQK/5AsTMREf/Q9UJCapuvLYpLJrNH+aXWFwXmEGRTPz/zu4Ge6F/+yqrZQAR6+2jcq6mbWGZBrD/7T7raoshLDHKk9ROIEDJ82CroHPOzbU3SjLskPfH/KJr+WgnIAxNFnkZ0fhifbb2tjh7zup11P+3QBiV3z4TED7Tj3IKtXZhGve6dcivw5dfBJY0xb1wBzBTxFOjRuRiraUKF1csVb6vg4BRKUPYsRGywXHxiDXV6GUAjLLvd+vLTuIRUUcYpKa2Vpagtjt8tVLU26l57rAqD4OaYZ60+IF/V7tvheOn9rw0N846eFDM7Dv+3E3NkNJgQ8pWzNA5OLff/YV+AOpZWdIBiyxJygGqo4uUAbixZwSY2/pcv+sAbT0Kj6kl+Vs3g/aA1PBPOH226wFqxZnOZXkzMQYi+w0JFI2WB+za0rh9mH0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzB5T0hWQ1NwbUVBbXFVWXVuNnZVaG5XYzIxTHB4b1hWNGJ6YXRhOGJObWdh?=
 =?utf-8?B?Tm9rRVIrckN6TlA4UmxjLzBtUlFHeER0ZEt5dHVsdEdlK3RjWXhPOEhNa3ll?=
 =?utf-8?B?ZW5PS25jUms0LzZwYnJ5U0w0cmNhYWpiRUpVUmJ0c3lqUEVKYW5sMlpQNXRJ?=
 =?utf-8?B?SjlrZVFxRDIxZEZPcU5ESjZBOWhEOXZVZ0FtZlV2WmhObDBIak4zWUhDWWhj?=
 =?utf-8?B?WXZ6OUVZWHMxakVsNWFLYkVFRkkrMUdCUXdkYWhyOXVvOEFUZDExRXJPNGRM?=
 =?utf-8?B?dmtjRm0vMVcvOW1TaHV1WW1qd1hwWG5ZQ1dSUWVTSVVSUXN0T0pCQVFVelBx?=
 =?utf-8?B?UkdVRUVKdDNUTUh4VlZpZDBBV3dKNkpPTW95WkxBVXIwV1NYWEswNUcwSUEv?=
 =?utf-8?B?b09iWVh5WGdtK1VNU0ZDQVBOcHRtcEdOcDFhemhBWTNFNWdyaFJicHF1UXo1?=
 =?utf-8?B?RzUwc1lYVjlyMU54Wkl1V24wZ0MxSVp1MERqUW8rQnhhTWt4WTA3SUMrY29k?=
 =?utf-8?B?YnNnRE04NlZ4VDVYWWZXSnZmOHJNL09YWHEzVk95UzhqaFExY0xPVnBJd1pv?=
 =?utf-8?B?S0FZZXlrTHR0VUxvZnF3b1JWaGNjZk1uZm5LWU8zV1gwN1BNL1U4MlpmSHM4?=
 =?utf-8?B?dDR2OXM5aXVSUGJxd2lrUlczRElPMWI1cGQ0WW1ad00zdkZBWEljSW56S3VV?=
 =?utf-8?B?dVJTRVYzcDBiTTFvamNva0VwcGtnczkvRWdObFZTQ1NqYmxNeHM5ek5QRHIx?=
 =?utf-8?B?RnYxYlZCZjltOE1kUm91L053YVVFL0JLRFptQUxnYTQ1UHFOMEVBL0tqOWVm?=
 =?utf-8?B?N2JFSGlHMWhVYTl3a1dYSmpqQ0hkSUw5ZDA5a2JpZmRwTnhEcWFQZVVJaU1p?=
 =?utf-8?B?NWJ3NWErR3VtUjd6WDF2b0ZuOCtQQzJMejVXVTN0SjEwQkRuNW1vTnZlNzdm?=
 =?utf-8?B?RnBhbVJINitkMzMvUFk0VmhGV21SL2VHd2JGakxqbzNQZEs1TmNSM0xRTjZ0?=
 =?utf-8?B?NlhtendIckZRaWtvKzlJV2ErMWgxOFhyNmVtbDNnN2t1QTA4WW81OGREeHFo?=
 =?utf-8?B?eURhTi96aGtUek5jUFllNHhZblhQK2lncVlScUN4Ukx1ZUpTbWw4Wk9hdC93?=
 =?utf-8?B?SHFBU01zZ21aeVJWQXFMQ0tvQi9LNEtqY1ZtSmV6MFY1cXhGbFhLYUd0NmFB?=
 =?utf-8?B?Ym5uS3BBT1BjRDVpSGM0ZXFpRjJNSEh1ZVloOTdzTUVNVW1KaHlncHZ0V1RL?=
 =?utf-8?B?bDBmZ080dExwb0RGbkFWL2dFR0NYTzVOUm8rRXhSa244Wmdad1dHL2IyN3pL?=
 =?utf-8?B?dFJKdnJOQmZwZngyNDB6eXhIT2pYcHBRSjRwQmEzelUvenJqcW41dnM0MnpR?=
 =?utf-8?B?WVRQVTQrdjVDWFoxM3F0K1pQM1E2SUVwYnhVQnJ5c2RwZnJtTG55eDVnU1Nz?=
 =?utf-8?B?REN0VXM1aXBuYVh6SFFUVFg0WENSb05sSE1LRUlJczA2UldpVE5EZjcrdEpV?=
 =?utf-8?B?YXpzWDhtUjNIeE44MzVWaFNNM1JBU0w3U2dnaXdtbkdxSXUzUjNTb0RUTjBt?=
 =?utf-8?B?Wk5aaElBL3ppMTZ6clNhTUROdFBUaG12S1U1ZVlvRjRwTmZOeWxUMDVZWGtO?=
 =?utf-8?B?ekdyOFU1bm9vWXd0UldKK1JQV3p6ZWlzaEJuN212UHROWDhLcmkzRGVQWHBZ?=
 =?utf-8?B?V2hsSWxaSnNQVjIxUjdKTHBNVmdFN2Zub01tUmNwa21BVjZCZERQRzhoTFpF?=
 =?utf-8?B?YUtzSjdTZWFJOWJ4RnZ2dVFrRk5nYXR3cTBXYjVNdlU4b0Zxc01WM2Vqd05J?=
 =?utf-8?B?RThRWktDSWZQVzhZYldWU1FrYlpQSFh5RG1Wd0F6Ymd0d1ZSSm1qYVZJQkhy?=
 =?utf-8?B?RWZsaXFLbUhlT0FSa202KzJDdzZwMTF3ZnJwbkNYT1VaSlJ6UHQ5TU9zckMv?=
 =?utf-8?B?UFIzTGJ1K2tRQUFmT0c3UjVpYnZKUHRNTjVoYkh2RmxNZWJUU1dRY0kybnBI?=
 =?utf-8?B?a3hZSjhnei9hd2J1VkVFcERyWVZnUUR2V3U3cDUzWEVmMXZ6ZUxDOXpkSFBF?=
 =?utf-8?B?NXg0eWZnbFFLcFUyRE5mWVhDeHNMVHFDZFZ1SE96eGhlSFFTcXNKZnhjRHpH?=
 =?utf-8?B?ZERBZ0puWHBvbUhQakNWRUJST2xKZUptVlhsQmhDWWx5eDcreTRoZittNzRB?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 868098ad-fb3f-4e62-f966-08dc57abe401
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:11:35.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ocxv2x6ini8GqHzp8MquuDRldZ6GfJflq+nQxcMSOulxf6g/naOvAGErNCOv6dc926gUozRQXG10sZqe4hfwlhsK9VcP85O4YMCaMCgM3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8321
X-OriginatorOrg: intel.com

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Fri, 5 Apr 2024 12:32:55 +0200

> On 4/4/24 17:44, Alexander Lobakin wrote:
>> Add a couple intuitive helpers to hide Rx buffer implementation details

[...]

>> +struct libeth_fqe {
>> +    struct page        *page;
>> +    u32            offset;
>> +    u32            truesize;
>> +} __aligned_largest;
>> +
>> +/**
>> + * struct libeth_fq - structure representing a buffer queue
>> + * @fp: hotpath part of the structure
>> + * @pp: &page_pool for buffer management
>> + * @fqes: array of Rx buffers
>> + * @truesize: size to allocate per buffer, w/overhead
>> + * @count: number of descriptors/buffers the queue has
>> + * @buf_len: HW-writeable length per each buffer
>> + * @nid: ID of the closest NUMA node with memory
>> + */
>> +struct libeth_fq {
>> +    struct_group_tagged(libeth_fq_fp, fp,
>> +        struct page_pool    *pp;
>> +        struct libeth_fqe    *fqes;
>> +
>> +        u32            truesize;
>> +        u32            count;
>> +    );
>> +
>> +    /* Cold fields */
>> +    u32            buf_len;
>> +    int            nid;
>> +};
> 
> [...]
> 
> Could you please unpack the meaning of `fq` and `fqe` acronyms here?

Rx:

RQ -- receive queue, on which you get Rx DMA complete descriptors
FQ -- fill queue, the one you fill with free buffers
  FQE -- fill queue element, i.e. smth like "iavf_rx_buffer" or whatever

Tx:

SQ -- send queue, the one you fill with buffers to transmit
  SQE -- send queue element, i.e. "iavf_tx_buffer"
CQ -- completion queue, on which you get Tx DMA complete descriptors

XDPSQ, XSkRQ etc. -- same as above, but for XDP / XSk

I know that rxq, txq, bufq, complq is more common since it's been used
for years, but I like these "new" ones more :>

> 
> otherwise the whole series is very good for me, thank you very much!
> 

Thanks,
Olek

