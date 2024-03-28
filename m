Return-Path: <linux-kernel+bounces-123132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B7890292
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0135B21DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC31E12DDA6;
	Thu, 28 Mar 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKSaolqn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332111E48C;
	Thu, 28 Mar 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638163; cv=fail; b=GZ6l930UnMqKEmcWV1VDSR+8EPMLiFjS1cHqh8NhCsXzSrHRRTTy5KPA5j2A/AZmPXt0a1h5u/CkiCpb2q6d7nIcDC2B2t+GpiBKC9DUeA5HW1ToxLwg+oAMRTQ0qeisb3JXlNkprUXaqR71E0yDy3HRqO00B7l/dYcNxino/Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638163; c=relaxed/simple;
	bh=ETqA0btz5xNnJxPwSdCTtC61wryMq3XWUG08jWc+Jpo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oAoR0fCPrj5U0qpbGilyhuaT8pfFI8qX0+bVi+iVZI3NQTjXT3JelEr0uOekVGRxA3OTQIrDMu5NCRCU0GDOEW/yd5pqT93OsEqkMqNC3VzQiuN94jMvnD2XOoJCkYmTl2WVOKeYTkcxJgxMd1PrfcW+YoAFTtBbpjEQQcy9CuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKSaolqn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711638161; x=1743174161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ETqA0btz5xNnJxPwSdCTtC61wryMq3XWUG08jWc+Jpo=;
  b=cKSaolqnUPXZrJEG0Alsf51V7XWY07L3sH6CGT1s3Hfw9vGWPW2O/sEv
   jYdbDxoFyqNHj0JWVai4fyGg5qNFCpZgyUu4IfTD3wQk+PFzalsz0Sxej
   8bQNWdFiRvCmzBDqg2Oa1BirFCbbJyGtCgu8Sgqd9CYEOeHNskfRGfUzB
   5JfQn6bsYHLO+zwrYt8OhDEEOV5xncqAcA3s6ZP822TBxlqyo8bc/oP0J
   t3GglDibdYHt6N1XBlOcfRiO593uTzANimN1QEi4zKQBqSR+pPWbWrLHP
   7fTLby8IdSSXqoyjF/dw7t2tCEbYmtidr7Nbg5TeJEvxiv+2WLP4zmKut
   w==;
X-CSE-ConnectionGUID: aOwCTXZlQmu2U6l9S6G0lQ==
X-CSE-MsgGUID: Gip531qKQXOGWNqDKI470Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6984375"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6984375"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 08:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21320933"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 08:02:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 08:02:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 08:02:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 08:02:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 08:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdBhRqVF5Tr0B7BXZ+l2vgo6Ix69fvj3Ym8SzsbklnyvBDZj4XCuFMbtHzPyUl5rGcvF56Q7vrt3KsZPJLhnKCi3eNdyubfx2R8nPe4+LF6wQa0RXvLnztPcrX1pMF80e6m8xlAKL70PwfTY4AqZ5bDiqRKbeh9PehzNRsO8S3DiZXFzQ5koR68cq94eh2XIk1XsSi4NJ5x+O+9sZ/yIjrIgiCFk36frAvo9Wi/FEFAcxFLx8S9DFq2yUXR4RYA5GUSSAM6kzgxBgbecJ8hG1aBfy96r9kcJ3CQNVZA5bFa2+/CZjNjFqzGzz+6VfDzeVXsu+N3er9Q2+jhWLiP02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fBA6+qtorBH9UjPYBMpCs0co3YmRwco0ir1xuC8iMs=;
 b=ee15fN+0qeW1kojYvrku0IsDXV+Zwk8omQgjXyJiWG1gUYUDYttBXvNALKpqJ3zTpy31x5bVkEiAhNGWW/I8Fso/VTICZyNdEr7aitskIF97up2UG1aIqiBpVSCholtd3xLySI4kjp+lm3aBZYY6N0GCE5gxkSCfkw6lggikzueAlzRYKk39WFNa7+lBhc2PXcHe7xYioxFEXRgbOOsqbGbhhRfW9arOgcNE0SIIBcbpMsUJtmaFaWYugp4UGry5bIkPhkUw1Up1OC9C/ovLyVkqFF5DpRWuBLtGfmM7ujtYWcppIS28KniUoA5muZ9mQMIwT7tEzaj/ET/tn9AIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 15:02:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 15:02:35 +0000
Message-ID: <10d89693-21af-4560-a088-d58d16cbb9dd@intel.com>
Date: Thu, 28 Mar 2024 16:02:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
To: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <quic_jjohnson@quicinc.com>, <kvalo@kernel.org>, <leon@kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20240327200809.512867-1-leitao@debian.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240327200809.512867-1-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: b087dfa4-2757-4e9d-ba45-08dc4f381a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0XFPcGKW1Gm6XykydqYIWl14RkF9W0rUa9fEoLEJE1ikAsHxAU64+UEn7+O9efrT/Dp0tLUFQ77BoxVzuQEflE4lKntLobXDYb3fg7HpDTQEi3g6JRfwkrgq33xbEo3ycjIokXx4ViJTHN0JvkcqlUVWtKjHL9VOtLDuGT5iJT3GzuRFM9fcwtHii8O9icr3mXAb/6Lbz89t4/BXKS2OiVoqEmohn8VssY8+c7PmdfygO9f6SwEKfANDLC3m3r3fxz3UyegI38q0PL0MAODmrTmYMIKK4Ca+gHAgxMi6U0XZIzh4BUmsOwrwy+lDvZKIwGRbOUZEc2dpjOusRvKcPb5XTq8fWxBeVbTGk0UrHUiCmNaTCnpdpoQZVHEr+KWPNtWK6cctiX1BB0bofDKeJrSoE/ZCo5VRtYcayjhe2g0rLme1G5Nud9cn2Jonuop6qF+MmdNETCICV3hsJ0Bgzqpkd38Np8CC7NuRv71mqtECS1r61VvcCpyAkASpbXlMt9kdF2HVn5eorBffnFtaSyjIVpYtqfIYIQvEpo3yl6kYYGcIEupeNao+a2SV8v+8KUFJDR2xJddE5JmqTN7oMnlrnxlL0Dm8kCDI1LdkYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRCQWFDbWN3QXUxcm1HYnlJWXBMcWY5QXVtbVJhT0tveXZwcmpBVVYybVY4?=
 =?utf-8?B?bzh3b08vUW5kRndjNHlGTmtQQkxQNnQvKzVEN3hGRjVBNVFFUlZOdW9FazZz?=
 =?utf-8?B?TmFJK3p6MXhyQTB1MEpsaHlEcEVmaTIxakxQd3BtVmZuOGhsOWZwejV0dE92?=
 =?utf-8?B?OGhLb0JycjlNSFptaVVGOXNDVSthWGp1VWJlK2NJckhhWlcrVTVZajg0WXlm?=
 =?utf-8?B?K3ZpalhLM3FTU0c4RTlydjBqZkp0Q1p6aG84emRuS1EvSlR4RTRhdElDMHVP?=
 =?utf-8?B?dlA1RWE3eDRTYmJva2l0VUVZMTZWZFJwRzgvNlIySEdqa2pveXpZcmg1NEJI?=
 =?utf-8?B?dEtQbk0wVWRYMktZK3R1Y3BWOHpzWlVWWjR1OVFmNUdsOXRWdWx3NHArUG5D?=
 =?utf-8?B?S0NabG81SVNRUzlHeDkwSUZCdFFRaGI4K1I5eU1JOWlyeEtCYmpLZzU2STJZ?=
 =?utf-8?B?OHg3OFFsalJLeVF0KzBTMWFWbWlqUGFNR0Q1LzRlNVk1VmpjeXdGR2hZWU1Z?=
 =?utf-8?B?MmtBVzErU1VWRDdFNE5waG1xYXFEMm1ORnMyVzBUSytNOS9ZdW1yNmhscThm?=
 =?utf-8?B?aThTdGlHdTgrVjFKK3FYckszOXowYytnc1pqVmI0UkNTZCtpeDUrSzhUbUo4?=
 =?utf-8?B?MDFlTHNrTmEzMmwxQno4ekMvRFh1VTlWYk5wV3N2bllLWnkxeFFZenY3QjFm?=
 =?utf-8?B?b1JyU0F4dTB1Ry9hQ1pNQXBsWjgzMXk0UjZXdnBUWjJ6UHBpSGhkTlV2cjhh?=
 =?utf-8?B?aXBkY0JJakNnQ2FjVk1vbEZzMmRHbVFhZzQ1U1Y3U0E2dEsrREZ6REtmN2sr?=
 =?utf-8?B?bWRaNS9XTmlEMjE5eml6RTgvTWJhNEtOY0ZuYm91RlRNMU9FRXg2RG83cm5U?=
 =?utf-8?B?VWZqdkZjUFF6c0RJN3cwc292Ujl2dXlva1lTaTVuSTY2dGtiQTZ4ODhDa1pl?=
 =?utf-8?B?RzRPSEVsaDlIUlpNU2djNUlPbDRDd2MyQ1lHcUVWQzh4dmVUbExtN2xMWDFp?=
 =?utf-8?B?VytHaUdJUmtxV255dy91dk9LQ1dNZ3BhbS92T2xSRXdYeVM0VTVNRDgwMnJh?=
 =?utf-8?B?bFRVOFo1dVhPdHNTWXFyWHg5OUVMb3pnWGY0QytmLzhQRCsrMnR2OXBpYXVs?=
 =?utf-8?B?NnNaakRiQzE4WExSRWg2YTN3K0pDV1RFQk1vdmxTSm12MWxnMHhDUjZRMDlT?=
 =?utf-8?B?UFVzOVpuekpxYXFqbU03Ty94R05CLzc4aEVqNVV6Q2d0RlVIaXBBdlFCN3ly?=
 =?utf-8?B?RzYwVEg1RWlkRWxoSW45K09VbHVIZDZnVVNad1hKdGxCMURJdEtRWGJRS1FQ?=
 =?utf-8?B?YUN1VzdZc2pJallnSkFDR00yN2QxdlBxZHlLRnZiTHVEWkFTSThPbUhLZEZB?=
 =?utf-8?B?TXRpaUd4QjRJaXAxaE5FNldzdTNMRUkvcDEybHhTY2QvaFpZK05UVm84YUdt?=
 =?utf-8?B?Q0EvZ1BCTC81QjUwSlBpcGtlT2NteFNvWkFHanpDUVVuc1dybHNCSHlhUkhj?=
 =?utf-8?B?VGNEcFlYekN5aE1pWEFoTTh5RXFhZW9oQXdxOFYrYk9wTWZYaFB3a3lOZ1Vv?=
 =?utf-8?B?ZllYeUtmTWVUMW5tZzN3aXNHOGJKc3kzV084ZU1zTzVtZ2pNSThMVElpZnJZ?=
 =?utf-8?B?TVFiOXdzZ3g4UzdNbHpmV3plQWNwWWVFRWFqUlVubms2eFNDaVB6VUtFdkJO?=
 =?utf-8?B?RUdFenYwS1BWRWNscjNvZkxSN2QwZFdkTCtXZG01azdMUjhEanNrUWZhc0Fu?=
 =?utf-8?B?UlFWUHh3UzdlSmVxV09nakdHZ3JVZXJPN3pEY1ZuOFpJY3Bob0dreXhyYlFq?=
 =?utf-8?B?eW9NTzhJNlpGdXJVUDBNSHdBRWJySnVxV3NINFlXaXM5dUkrL2ZQZGJmSTBZ?=
 =?utf-8?B?WFF4eVl2NHE1SVdINTNUQ2tQd2F0elprR3FMcVRvY0dRbnBWWHFTb2IrcTNU?=
 =?utf-8?B?dUx3VTY5dGR0NWtzWWtxQkVLS3RjUkdwUHV2NENzckRocDNGNE8waDZHbDBL?=
 =?utf-8?B?M09nNGxmU0hlWFA3bTZKLzNyL2diVmFnRlVnNHhoVWJYQWJueUlDVEdsdFQv?=
 =?utf-8?B?ZENvcUZ4dUlEamR1Q3RaeC92U1UrM1NvUnRMV0xhWVFtVzM0THNTRG9BaEs1?=
 =?utf-8?B?TXhSTEFKbVM0QTU2Y3ZYOENEQ3hZaXE4WElKRDV0QkhaRUdLQnV4dXQ5dVVL?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b087dfa4-2757-4e9d-ba45-08dc4f381a20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:02:35.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/tBPSRDSzsXilXNV+LUh38Jo1Jpv95iPE/zmd7SWKU3bu/G1Wv5hb3bELYYYOvuRdJZAoWzuKykcpLdShtq/aEcZK75LRic05rrldSEEsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-OriginatorOrg: intel.com

From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 Mar 2024 13:08:04 -0700

> It is impossible to use init_dummy_netdev together with alloc_netdev()
> as the 'setup' argument.
> 
> This is because alloc_netdev() initializes some fields in the net_device
> structure, and later init_dummy_netdev() memzero them all. This causes
> some problems as reported here:
> 
> 	https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/
> 
> Split the init_dummy_netdev() function in two. Create a new function called
> init_dummy_netdev_core() that does not memzero the net_device structure.
> Then have init_dummy_netdev() memzero-ing and calling
> init_dummy_netdev_core(), keeping the old behaviour.
> 
> init_dummy_netdev_core() is the new function that could be called as an
> argument for alloc_netdev().
> 
> Also, create a helper to allocate and initialize dummy net devices,
> leveraging init_dummy_netdev_core() as the setup argument. This function
> basically simplify the allocation of dummy devices, by allocating and
> initializing it. Freeing the device continue to be done through
> free_netdev()
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/netdevice.h |  3 +++
>  net/core/dev.c            | 55 ++++++++++++++++++++++++++-------------
>  2 files changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c6f6ac779b34..f4226a99a146 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4545,6 +4545,9 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
>  
>  void ether_setup(struct net_device *dev);
>  
> +/* Allocate dummy net_device */
> +struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name);
> +
>  /* Support for loadable net-drivers */
>  struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  				    unsigned char name_assign_type,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0766a245816b..df2484bbc041 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10340,25 +10340,12 @@ int register_netdevice(struct net_device *dev)
>  }
>  EXPORT_SYMBOL(register_netdevice);
>  
> -/**
> - *	init_dummy_netdev	- init a dummy network device for NAPI
> - *	@dev: device to init
> - *
> - *	This takes a network device structure and initialize the minimum
> - *	amount of fields so it can be used to schedule NAPI polls without
> - *	registering a full blown interface. This is to be used by drivers
> - *	that need to tie several hardware interfaces to a single NAPI
> - *	poll scheduler due to HW limitations.
> +/* Initialize the core of a dummy net device.
> + * This is useful if you are calling this function after alloc_netdev(),
> + * since it does not memset the net_device fields.
>   */
> -void init_dummy_netdev(struct net_device *dev)
> +static void init_dummy_netdev_core(struct net_device *dev)
>  {
> -	/* Clear everything. Note we don't initialize spinlocks
> -	 * are they aren't supposed to be taken by any of the
> -	 * NAPI code and this dummy netdev is supposed to be
> -	 * only ever used for NAPI polls
> -	 */
> -	memset(dev, 0, sizeof(struct net_device));
> -
>  	/* make sure we BUG if trying to hit standard
>  	 * register/unregister code path
>  	 */
> @@ -10379,8 +10366,28 @@ void init_dummy_netdev(struct net_device *dev)
>  	 * its refcount.
>  	 */
>  }
> -EXPORT_SYMBOL_GPL(init_dummy_netdev);
>  
> +/**
> + *	init_dummy_netdev	- init a dummy network device for NAPI
> + *	@dev: device to init
> + *
> + *	This takes a network device structure and initialize the minimum
> + *	amount of fields so it can be used to schedule NAPI polls without
> + *	registering a full blown interface. This is to be used by drivers
> + *	that need to tie several hardware interfaces to a single NAPI
> + *	poll scheduler due to HW limitations.
> + */
> +void init_dummy_netdev(struct net_device *dev)
> +{
> +	/* Clear everything. Note we don't initialize spinlocks
> +	 * are they aren't supposed to be taken by any of the
> +	 * NAPI code and this dummy netdev is supposed to be
> +	 * only ever used for NAPI polls
> +	 */
> +	memset(dev, 0, sizeof(struct net_device));
> +	init_dummy_netdev_core(dev);
> +}
> +EXPORT_SYMBOL_GPL(init_dummy_netdev);
>  
>  /**
>   *	register_netdev	- register a network device
> @@ -10991,6 +10998,18 @@ void free_netdev(struct net_device *dev)
>  }
>  EXPORT_SYMBOL(free_netdev);
>  
> +/**
> + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
> + * @sizeof_priv: size of private data to allocate space for
> + * @name: device name format string
> + */
> +struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name)

Since the users of init_dummy_netdev embed &net_device into their
private structures, do we need sizeof_priv here at all? Or maybe we
could unconditionally pass 0?

> +{
> +	return alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN,
> +			    init_dummy_netdev_core);
> +}
> +EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
> +
>  /**
>   *	synchronize_net -  Synchronize with packet receive processing
>   *

As Jakub mentioned, you need to introduce consumers of the functionality
you add within the same series. Personally, I'd like to see a series
with agressive conversion of all the affected drivers from
init_dummy_netdev() to alloc_dummy_netdev() and final removal of
init_dummy_netdev() :D

(and then a followup which converts &net_device to proper flex arrays)

Thanks,
Olek

