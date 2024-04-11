Return-Path: <linux-kernel+bounces-140381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5A8A1390
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E581B1C20AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8A14A4F8;
	Thu, 11 Apr 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9JxlSQb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE541147C9D;
	Thu, 11 Apr 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836162; cv=fail; b=pfOYQbWV868o7JBOok96IDqW1vgftEHEWYKlcMAIk/0KoHMxaY6ua7rzwXsQqqY/CFkiDlk+Ejw9K63ncS4LwwNkoHWB5WmLm+p8kCm367gbyThHbCms+MdkyrE9K7CLWjoF5SuDuSHAV8f+NQEG0qNDgPyj8GQ0ZBlb5Nt4ioM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836162; c=relaxed/simple;
	bh=WsGEYFc/TsB1FjBvMuyJlS7pBFt/W4/WvV5oRTC95YY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hPRWcLIfYGjs+zp8hzvPxhQ+N/fAZR1Kakb6H2Xt6UhWKn79n+oQaBPJOCgM5mVhlVwvrIQ5tjU/DHhmK33t0BPlkHSLoetTV5jdFslluqCgStKM+HkSJFyaR4Li6eLBR6WIFD2DOgHwukF6bClYxPWboLmJGtD3AZJd08MKpYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9JxlSQb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712836161; x=1744372161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WsGEYFc/TsB1FjBvMuyJlS7pBFt/W4/WvV5oRTC95YY=;
  b=H9JxlSQbCoQ9k4nKwAsriksg3bQ0Cz1CtBWSCMnQPG+MkO4hoSBfWAwE
   MLjk++d/GB3hrdPeiTIv70P6iQ3YwOX78HTiS61VKw8vWFOApLGGMt53R
   SJ7pT09WJsA1Up04/Z0XF7UQ225g2Kmv9YaaWRPjAA++wp5skUfyR+1Ra
   oUbG5UVqIJOPxgYw93xXwOBYDVaJsdwnHKr6miFWevEb32sllLv7ul+SK
   kOx1meAUBsCECLNG2+GOjC8zUPE84Xtc046vb6NTeCmip1XfuUUpVpOm8
   QNkKyyV8p7qymeuiyPrzRenFhzdq60y9yU6FqV4NwmbQVoqcgGQ36t4Pu
   Q==;
X-CSE-ConnectionGUID: 612A3UZST+CfxlKYb7hsMQ==
X-CSE-MsgGUID: O2jQ/dK7Qhqo+l1c1+nHsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33638922"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="33638922"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:49:14 -0700
X-CSE-ConnectionGUID: wi4jbjJrRsyMx8XrwW0vaQ==
X-CSE-MsgGUID: l14mFjt2T+e6xemIVj0jFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20923559"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 04:49:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:49:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:49:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 04:49:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 04:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMfPMZHRP7bv8YRB38GNENYa/O1kZBXjXGXQiNUILkurt54sg9meQOxxSUxUXHFJvHh4RZk1+I/vEa+7TzNeSjsn0x0hhm4ulIDCXQFjeYDUwy/q9LP5NO6ruSQ6brjWzP/J8+N67LZcMTRWjzZPFAs/fgYk/5oUb+696By7BungxIQRZJVomAluxJjNIcQXqCfIVY2M45XW1iV8kdvaj8hkbWNAsZxyU5DyDbbBb6geUgrUSlGc22F4H64NJ8UzQU/8NKmkS09MQK6jae4rmrj8TL8N15fxP7tttS3TkEm3UIXr9l+teD7CNM6vd5d2tAu1vvZqPmwijvQAaWKjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59tTlb6bQ5YX67R+99b1MsEu/4aVcLEvgdxTNK7jvsI=;
 b=m+Z5wwGyZYOSehS/aUW+fO7qs99bxwWKBgrwGhdNih8g1qNmoTRwDJcMDqckjfG9Y/Qw186UHFsbcvUvw5u5TekyCVUNXnOfUyeSXO58jFWyosBl7nm9qXK1OKEDkZhoLJwxZpj33S5/z4XsOxKnVXO++/unZ6q0s70A3z3T10ykdZ9x4w7dds6FV2LM/YqTXZ2ok2z9at8L24UoZFC6x/KCbce5j6+BoSLrwGTiVYsZxM7q6WGU83Dpentgj3iAL0JBaLAWVC0loq5896t2rcVjueTx7U9k/J3L88f0/rtLkeQph59dlYVuOmSyWfQV3hMekJVA/Y9hms/TPMXQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 11 Apr
 2024 11:49:01 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7430.045; Thu, 11 Apr 2024
 11:48:57 +0000
Message-ID: <316aba6b-2384-4867-b634-89f9c07f03ca@intel.com>
Date: Thu, 11 Apr 2024 13:48:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: fix struct_group_tagged() parsing
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Jakub
 Kicinski <kuba@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Keith Packard <keithp@keithp.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <linux-doc@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
 <b9804c32-9ba2-493b-bfb8-a6ac4f108175@intel.com>
 <80d765f5-1436-4799-95fe-ba05c0681d5c@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <80d765f5-1436-4799-95fe-ba05c0681d5c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 993930b7-203f-407d-79d9-08dc5a1d5f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uImcFCSbhx7zvaLTTIGRQ+ooFr/Ip0i+pT3zf4qv9ASbfTQHWxECUyf1ZGqtzyPPfcsbE5MhfAWQ4uvqCNXJDNtN0L7wG3PFK42X3N5W/4sFKMtwNW7ggQMyaZV/566/jrWLN/VQ1euufxfMgLLOqMuhtK9J1NCV7ahN78eO7kincXX2dc7PLbmqXr0488B0RWkE09lh9swBW2Jlnvpo3JifwuSb/nwTuKAhm16XdAvF8Law8LJl1AaecXLb2aXRWvm586AEtUKD92man+nfVne8mxXgB48YXy4ASR6WCJEJj6DCzmGqe3+S1eTjJOyPzkfxWDQAMIjDh985xPsPQQHiYzexsWc0sGFXRAXNs3W/ZEvBDMBs1VKpaNn0NQCbKAvsxY4yQk2bJh07SrUeoGBphxY33OEd8P8sKjaxdo6dzUE7xoR3PXJAknCFGAEquM8d+5XeEg6SQcD/yCqJibi8oHx5Jo0hDehB0py6+NZuNn3MslG12tWyWgHAP4afftPSDwKehjknEOIgfXyuA/5uOHaOgW2bQZBi/TgQTFIFuidpIhxPoFzKDpYu3dq2zAIoKyl5g6Q7V+wo3zUcOdXuuSq5RSxhkiPAoU55B9DtI8QONMbMqaFKENq788jiLmdts+tJqU7YTj6P3Tw2IGLxDIklG96wspY8O8jxFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UktuL3NmVHRwa2dXL09xOGFKRndLTUx4UGpsbUp6UXMzaGV5d3FidFh4ckp6?=
 =?utf-8?B?M0o5N015aDg1VU1hTCtSVGhLYlRsYWt4WTd6K0JUZGs0eVkrQ3hhVGxOWVJr?=
 =?utf-8?B?WnZEOGtJQklBdXlPaG8xZlpXK0phekI1RHpRQjlLTFdncVJYaGhubFB4eXVn?=
 =?utf-8?B?czNqd3RMRVhYTjUvaGg3TmhqVEdQdklxZE9yb2EyTVBwejlPaXpnTUFnbkZo?=
 =?utf-8?B?L2NEbDhBSjVFNXVyeFhXZGRvczlhV1hQek1kREV2M0tSODlUSFpSWk5tQ09i?=
 =?utf-8?B?YkxSTU1BQkdUSSs5WWpwQlpnWnVsQklTcGhCaCtnT1gwd3RrcHh0Yk1BWUdz?=
 =?utf-8?B?NWVVRjhIeXcwdHNidmVTZHhwWHI2YTU5MWVjVmZGWlNnSmxVNm9IYWMwbW1N?=
 =?utf-8?B?QWhwTHVjdVRLL3dlbTNkMXZqTzlHN2I0Tk5XeEh5Q2IyNGFDWU1kZ0dzSkFL?=
 =?utf-8?B?Yi9MYjMxbCtvc0JtbFlTTmZ4QlNZMHRYTUEvTTlrYURnZHY4a2R4c09lRE9D?=
 =?utf-8?B?WVppS0VmT1pPYXZLUnVuQ3gyNm9nTEdiNWlxK3dNRXJ4UGhnRzd1d1l1RC9S?=
 =?utf-8?B?aEw3NUw2LzVRb2E2U1BiRThoRkNKMmltY25YQjllSGR1K0hpYk91cXRTWEdh?=
 =?utf-8?B?STVua1hoaWtDM21kbUxlM2pvVDdPL3pjOFExMGtIZ3FNZVJpVGRaeU5uM1JN?=
 =?utf-8?B?OXVSNmR4NjRtTXgxZ2psWXl1SjY3RlpqcWhCQ0swMm5CSmt0aUN0d1ZWWWkw?=
 =?utf-8?B?MlVzOG1YQU9GcGhreDRROXV4cDM1bERBU3Q4SkdMTDF2N003R0Izd0xNb1hM?=
 =?utf-8?B?WE1EdDdHTDhxL09yQUMrbit0ZldrV0pNU2JhL1JKVGpuR1dxbjR0RzVYZmNC?=
 =?utf-8?B?NzhXQ1RUa3NRWWtsQVBwQWg4aklMSzdhaSt5VU5HTFFOTk51Qm1hNlBRZ3ds?=
 =?utf-8?B?NE93ckFoWVVKcnV2ZXpKRGFJN1pEZ1RQejJwVHRYNjM4ai9ZSzVYdkhJNkk4?=
 =?utf-8?B?bHdnVjByZjNJZ000b1NMK3dWWDRqTU9Dam5JT1l3andjTjYyOFpHZG1mT3pZ?=
 =?utf-8?B?VERCQWlQRG4rV1VDbC9uK2trNEs0eWYyZ0JHdFNWdTBYUnl2SzJMbjE5NFJD?=
 =?utf-8?B?cjAwdVNmVzJ6aGo3cExuWW1iejdUbmNwZHVpQWdoYXF4d3ZoeTFmZmRyS1po?=
 =?utf-8?B?Ry81bjI4c3BRN2gvbVEzaC95UWVHc0tOV0tvQ1NkNU0zR3Z4WC9La014bzNL?=
 =?utf-8?B?aUZZM2V6OTMvSnppdjZzK0VtaHRwQTAvV2I2ZDQvYTd5aG1ITmY0UGhaeS92?=
 =?utf-8?B?RFdmTXhLTWVBN1k0NVdXSVBNMVNhR3ljQTBxaWtydm9ldk5ESW9QRko0dENy?=
 =?utf-8?B?cXJpdDNEMXhtR2wyNDhNdGhTTXEycThSb3hjTkNxUkdPT0hMZTZjTG1zTWRk?=
 =?utf-8?B?KzBieGtHdDlxcC8zc2lpdVc2dzYwWUZVcVNvM1F0TEp0dkpMQ0szMThNNFVC?=
 =?utf-8?B?VFZqeURmUWRxbmpvN3QvdzlySEFReGxTMDU4UjJKZ3huVGZ6L3FUdFA3U0Qv?=
 =?utf-8?B?VWo3bGxtbTZCUGFRUFR6aTkrT1BoOWVIbFQxbFBsckt5a1dUYXE2ZWxUWUxD?=
 =?utf-8?B?azg2WE5CTkFyd1h5MWxNSWU5aTRTYktxcVI1QUIxMkMwRU5KQTdJVW0wY1g2?=
 =?utf-8?B?LzVSZ3BlSXNNTGUwNDBVUFUvMEVHL2RacDB6N08ycSsxWjVWYWNIb3Nra2NY?=
 =?utf-8?B?VjJsZ214TEppaTJQWi9TQitWV3kzRGRoSmI4OWdpUDllVEp5NHVSL01zRGlB?=
 =?utf-8?B?cXpRUWI2Rk5sUVNDWmpOWWhNOEZLRmpsRzVaNGF1WXlIaVVZczRrY1ZXMDZs?=
 =?utf-8?B?VFMvSjhEZDhubWRMS0RIRHBQVkxmVjNyQTdvQmdXMm5mcHFqLzBqTnF1eVEv?=
 =?utf-8?B?WFVpbXdUSXZCVGdYSjVyQnRFYWhRT1B0aFdMSlpjMEczU2ZqTEZFZTI2eExL?=
 =?utf-8?B?ZTRNZXBoeUs3c01LQjVERVM1dVhvMVI4REdtdkJPZnBUS3FGMW1mV1MxRm0r?=
 =?utf-8?B?WERlK2QxZks3VGF5SFo1czRrV2F2QWJteWVyT2RoekNPUTJlRHl5WTlBOUZD?=
 =?utf-8?B?bGdDQWdlYVVLM21Edkl3OWV3cGhvaG94WHUwQnNPeXo4VWdrU29vaXdoeGNI?=
 =?utf-8?Q?k7i9YOvZDaKfvdD6XsEGd48=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 993930b7-203f-407d-79d9-08dc5a1d5f06
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:48:57.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icqVYj6bJgTbEdc80+2i/tLLrJBedsq1lFo4ozO9FNYA4EzLYykO8rTEXER/eBSXCdsmccrp5yK9v8xEXxIuTjqT8aDq2Omi4h97fd8gf9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
X-OriginatorOrg: intel.com

On 4/11/24 13:14, Alexander Lobakin wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Date: Thu, 11 Apr 2024 13:14:20 +0200
> 
>> On 4/11/24 11:32, Alexander Lobakin wrote:
>>> From: Kees Cook <keescook@chromium.org>
>>>
>>> kernel-doc emits a warning on struct_group_tagged() if you describe your
>>> struct group member:
>>>
>>> include/net/libeth/rx.h:69: warning: Excess struct member 'fp'
>>> description in 'libeth_fq'
>>>
>>> The code:
>>>
>>> /**
>>>    * struct libeth_fq - structure representing a buffer queue
>>>    * @fp: hotpath part of the structure
>>>    * @pp: &page_pool for buffer management
>>> [...]
>>>    */
>>> struct libeth_fq {
>>>      struct_group_tagged(libeth_fq_fp, fp,
>>>          struct page_pool    *pp;
>>> [...]
>>>      );
>>>
>>> When a struct_group_tagged() is encountered, we need to build a
>>> `struct TAG NAME;` from it, so that it will be treated as a valid
>>> embedded struct.
>>> Decouple the regex and do the replacement there. As far as I can see,
>>> this doesn't produce any new warnings on the current mainline tree.
>>>
>>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>>> Closes: https://lore.kernel.org/netdev/20240405212513.0d189968@kernel.org
>>> Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> ---
>>>    scripts/kernel-doc | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>>> index 43a30f2de513..01ac8f794b30 100755
>>> --- a/scripts/kernel-doc
>>> +++ b/scripts/kernel-doc
>>> @@ -1152,7 +1152,8 @@ sub dump_struct($$) {
>>>            # - first eat non-declaration parameters and rewrite for
>>> final match
>>>            # - then remove macro, outer parens, and trailing semicolon
>>>            $members =~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
>>> -        $members =~
>>> s/\bstruct_group_(attr|tagged)\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
>>> +        $members =~
>>> s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
>>> +        $members =~
>>> s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2;
>>> STRUCT_GROUP(/gos;
>>>            $members =~
>>> s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
>>>            $members =~
>>> s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
>>>    
>>
>> I would complain on code that matches `[^,]*` part with 0 characters,
>> meaning no tag for struct_group_tagged(), or no attrs for
>> struct_group_attrs(). In such cases simpler struct_group() call should
>> be suggested. However, that issue was presented prior to your patch.
> 
> Rather a subject for checkpatch, not kernel-doc?

Good point.

But that reminds me that getting patches accepted into checkpatch is not
possible for mere mortals :/ (exaggerating here, but just a little)

> 
>>
>> This is clearly an improvement, so:
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Thanks!
> Olek


