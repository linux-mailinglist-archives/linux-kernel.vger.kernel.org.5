Return-Path: <linux-kernel+bounces-140247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24F8A101D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC0F1C22F19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8417149C73;
	Thu, 11 Apr 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sraqz2AR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411C1474CB;
	Thu, 11 Apr 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831430; cv=fail; b=TxAnhpUY4HTSvjayI9RdBgumk6qis2NI4+D9pEzgJ2lF7ykefZYffE+m+MuCtbUYqFM3WhpRufJIs9ng7u5zSZxCnDHf93Cs3vc9wpeK2z55X2zBdklQ1pAOx25AEcvBa4viUkfNl2iSYwWhD48kn1ZdlwWRuimSdg1HU3DYrII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831430; c=relaxed/simple;
	bh=jtBDSHH1wpNjHzBz9mfIIP8vidk8EEEHqwzZ7MW3vPU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbEqmP2+hscgf+ok6r3zMpDwKCv2GfZNBfwgSo7zs/vUhHBoDlmWlL+iHPGREv9bAZ+LPnmVpAocj3zoE0F2Y32xM7qEprLxKWPnSU0ruVgzEz6LDXVRVWPEoQsCC5XEwORisLoTdpCES6/0V2JUUxBMHI+oqlR7A073qfPtl54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sraqz2AR; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712831429; x=1744367429;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jtBDSHH1wpNjHzBz9mfIIP8vidk8EEEHqwzZ7MW3vPU=;
  b=Sraqz2ARLNBvo5aAE75Z4VtsFgDIwHUUs0RigzmjnInqTZQnAI5JvLlF
   gNbjuwjeP4y8gvqiVoxtYAQr/jGuWkNIU0RBwvnl5bcz1jQtSXOQ7wPRz
   WTI7ZsQ4xfQZNVpzcmMHMz+8TO+NtfjYKAN5ellqvt8L8HyI7w3SAAk65
   jOUSvJghnpqmMjqbl/p0NIz33eDPJ/5joZC9wvJc3JBSISdH+OUI05olK
   WvxfxXeJUZ37oOrPuMxtuDnz8zREL5IiDYMGz6MgPp0Imr1M7K4h9S84/
   qdMT96u7AI58Nn2/Aw6Mi1V4zVp+yKGcZoRHfMg0x+d08MZpqxYaOxb/5
   w==;
X-CSE-ConnectionGUID: npoKbfX0S52tkiufjQSs/A==
X-CSE-MsgGUID: vXb3YbAxS42EJcB3r6U9Hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8340211"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8340211"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:30:28 -0700
X-CSE-ConnectionGUID: /u66zlcUTkOXszsDAglreQ==
X-CSE-MsgGUID: +qKTYiitQmiM4aBQMny/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20909736"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 03:30:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 03:30:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 03:30:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 03:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRqriruXJo2Q5cwMZytMTIQml8oXQNceA201lKLSuk18vhhMfdAs1jzBlqZif6luhC1TNFBMhb2n3OaC/KCQ7QmbPgFOzN9U3yl90MywDHVkaNCyRPuyU6aCubZp7M9djMF5+sWor7vjQ9HyTnn1T1dZAVi/kdKpiYqLyva0pKOBX6GAjZN2bOop0R9WzzkgaJGVQiI53A6gsopVxtRpwjgQ7TE9UccpNzM3VA8DdvNqwdbwLw52MIW1t+pgineapNzStCQMr/u6gaNj2L1i4tTo3iXgJ7HoMgWj4YtAANuj4Ibm2AaFWTRsnttPjWj50zuCv8/9p/EdVr25+02OmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85YHFFX5Blf/PyisV+C+zDx3Zbakrr1bNu6NK/KDoTw=;
 b=U1BVm7SxCxup+Z4lc8lzIEcLyCrKvVmAI+7vSBIGWDOd/QQXvFlKNMwoyYpdDR1wnLS/2QjI3AFgrWS1mWYmtKk3EUts2WRrBczl9CPPWQkjXf05dn0oPeFKATBdryQMXRdNJT2fWRJrpeDDQWzUFgA9uUVi+AOHXaeuydW1zAgbep3OfveAg+4zRWCiWck+yVeFEZRoYFok7Y19xUVCubOwRz4rlobwIc6NmxrGZdcw2MoHOektEQYLJrW2Y6OHIeNKTw51lkm5/HEc7YQpwgGQU5aClZJiXhcC2EeTMu5PSWw6sJNqtyC3LsMPJXvaPGcV9RVHndcfh4uixSB39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 11 Apr
 2024 10:30:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 10:30:24 +0000
Message-ID: <1f14cb75-ee6b-4a7d-9041-23a8cfcd8476@intel.com>
Date: Thu, 11 Apr 2024 12:28:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 7/7] netdev_features: convert
 NETIF_F_FCOE_MTU to IFF_FCOE_MTU
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-8-aleksander.lobakin@intel.com>
 <20240408193806.18e227c8@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240408193806.18e227c8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0188.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: ea017eb7-97ad-4f84-ced6-08dc5a1265c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHwa54XjnAsgHrZ/xwmCVWRwvYH/RrWxe5VyoDCIdYqUnOGBj7H2jufBGoy8N+Pd01XI8J+K6uPCXyYI2AsSDTuoqfHz+k4NiKSVG478EJdG4j0UJ8nx2aRiwykhVy8HgSc4L09MAMI6u3WSg1TOp6YIYHkyKUQ3TXnd03dgwtl7+IdKb3JNYUnah2SVycRguPIgxMkjbixhN/3kO1iSEiv4ZL7XIi9bS1JUV/fVmDMsr6E1tKW1N9jNWlNVieFP1EBUiE6BGHqxCkjxGuaFlXrKH7vWvVGo++Ug4xPl6ncqeYgvz6/CQJvuhYY+o3Rqq8YUTq3H3jAki3ZSxuKmB9YZOvQkr5iZPfGAQmmxwsruWeMatElcXRCvzNOhyqDak2W9XEyfK5WMSc6sV81uznlSmK8elITImMXDfIH5fBe5elPKlq8mgLe85JF2pD1Z7aJBh64CSFR343OxDTVFJhQWHcqO974CvQQZ3cYQYajmnK/JB5hPvvB0A8azrCB8Ih/cL/vnvy9U+i3SeRXgkFvoR8vhGSw9K70tPf9zZlzIvOygrWiZHUkTjx1bBKyNTik4/ZDPcg1wI2Q8r+zNZGgrUV1F6rChOtwyai04HXYZP1adLiGjwzHEeqPZ/B7UQO19tjEJwKn4xVKoo47DeOpq7iMgfLm33pzdBsqqRhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3A3MFV2NlBEK2hmYTJ2SXNqL0k1cUQrUnoxYy9LTlhEL3ErUHZMUUpGZC85?=
 =?utf-8?B?eDFKNHB5UE91WTM5MDNMTDZ1ZU8xcXFqeklDOUFJNEJQdFdNa01udCtQQXFO?=
 =?utf-8?B?eU5FbFZyQlczcGFUek5DUVR4bFBhUXZPUGE3ZnVVOEd6d1NtdGFoN3hmNHZS?=
 =?utf-8?B?S3B3TjV2UFRxQlNtZDA3S2x0alJkUVEzWCtyRFNyK2Vic01BNW5nbXkya25t?=
 =?utf-8?B?VVZkZXpwblRNbkh2YzR4N3FPMUJGV0ErYm1qRGx1VlZjRng2R05WS2xnUkdX?=
 =?utf-8?B?aWsvZTN1bkd1OFdXQlRicE5JRVRVbmJEZjhoVnZnb0taMHR4TitJRnNka1FG?=
 =?utf-8?B?WlNsL0NZSk5sRnk4SUp0amFZdkVRekVDdWdMWW5ycnFvTWVDQ05UbnlpWkhC?=
 =?utf-8?B?VmdXRzVRQjI2ZEc1RGpCV2hLSnhKdHVZTXQwZGtMYlZVc0lrLzMxeHk5VFJX?=
 =?utf-8?B?SjZZbzlBa2ZOMlZaamM4aEZEbHRxNEZ4by9PSlRHZFZGMzlBekYwSjVDRUlE?=
 =?utf-8?B?ZU04TFFIellzWHNiSjBXd1gxRWFLcWgxVVIzMFBwS1ozNUdxYzJRbitFMG52?=
 =?utf-8?B?YVFwcURKUHZUYjVGRE5FaUdzQWt4S3JxOXJ5WEZLYmVOejFHa3ROa2tyYWZ3?=
 =?utf-8?B?WDVTd0ZXT2pnWDJ5KzhyRlJ3UmtwckxyMmR2L0NXV0dIVitISzB2LzhOTGUy?=
 =?utf-8?B?TVRqditsYzI0Yy9RTFo4UGhrNGdkbCsvYk9LNS83aWtPcnBORkhZOXpaR0NI?=
 =?utf-8?B?UXpXaVZ3ZEExc1lySWc2NEJxd2IvVzFFMnk1NmRSZUlWT2I5M2hrUXVvMDJQ?=
 =?utf-8?B?akpZRkNnVTFkUW9USTBraWFTZjFaelZBdW5tY3V0WnF3MVMzb2RsQ2U0bDBT?=
 =?utf-8?B?d1ZJdnlBR3A0UzdyeVhyVWJUelk5eEhERm90Z1hvWlRuWUtkWnAxVmVNUmND?=
 =?utf-8?B?UkR1STM0UWJXMmxnMmpHUkloTlhleVV3M2VmY3NIcmIrY0owMXR5QXFjOEVF?=
 =?utf-8?B?Mm9YTkhUeGJLTFNtQU1tME9TRmJBK05leXp1ZG9kc2R6T2JacDFScEVLWVhM?=
 =?utf-8?B?K012S3NOdUQzQjFLVi9hWldKUkpka3JoeGF0UEtXT3NFeWNZbnRqRWVaQXg0?=
 =?utf-8?B?TlBsKy9kdnJidHJXVTV1UzI3blUvakMvYlNLanI5ZHVlSTNyM1ZoNFdBV2li?=
 =?utf-8?B?RDNWV3A0VG9pRk9DeWk0cHE3NjAzcmNEWEtkT3VmOHgwUUdFcktMNFRjS0pB?=
 =?utf-8?B?NXUyTEp5Zk5ZUHFBa3NvWEIvbXZCaElIYTVsRkdhMFNtUjAvcHBLV0VkZ3Bp?=
 =?utf-8?B?Z1NmenFoOTd0SWFtKzlzOHA1TnFCZ2ZSQzZUMzEzNzZHWHJjQUpJV0xIQlNl?=
 =?utf-8?B?cThDMEN3NGxaVVNadVJPZk05VHhaK1B4ZjllZDVxVmhteXh0QW1kNHpCZFRG?=
 =?utf-8?B?dVA4NUtic2JvdEpqMHg4TnpNeUw2ZlNSMDJGNWJiWnRXb3VJRUVlUkM3N0J2?=
 =?utf-8?B?NitHYlArS0ZxTUxJQVAyeFhlNEZWbFdJTjZmejMzd3ZKSnRFWER0bjdQcUk3?=
 =?utf-8?B?ME56bzYybE1MWnFWMGdMRkVFdzBLZy9WbVczTUF5ODV3OXpSTms1alc0L3lS?=
 =?utf-8?B?dHBYeDlhNndXSTBHbzNWNnRsRFRqQmYvdStRazNjL0F2c0p3UHVBN2RuKzJR?=
 =?utf-8?B?VVhQdFYzQXAySTg1T1Rjck1ZbnY0MUtRVS8xK2QvbXBtWGFLaWRQS2hVZ0ZF?=
 =?utf-8?B?T296L1Z1QnRyRkpveXE2cmJ0clRUU01aZU53eEE2TlZOOWxjdThlSjQ1OCtv?=
 =?utf-8?B?elN3MUNaL05HZnZoTUsxMFA0TXIwSStMN1o1bXRKdlhzT2t1YnIzcUN2ZXY0?=
 =?utf-8?B?NWppT0wwN2VobUFaRENqVHk4WW92NDZPaFMrbHhzWlBia281RnppRWdIMWhQ?=
 =?utf-8?B?YTY5cUYxMzRaNEV1K3dQcGdHZ2ZKMHZRUm16amRMaTh2T2gxNDFpa21VVmRs?=
 =?utf-8?B?OUlxVWNYaEhEU2NsN0M0bXNnd0VlcmtGaEo2b2lPbE5BaDNnbWg4eW45MjhI?=
 =?utf-8?B?b2dmcHFsQkJLVGoyODhGOGJPUVNqTFdEeHBDWXBRZnZsMERFWmt1UG1uMXh1?=
 =?utf-8?B?VmUrN0tlbFA4cU9kK3NTNG5GdXZhOEVHVDVKOFRKa0pQbzc1Wi82bmkwME5a?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea017eb7-97ad-4f84-ced6-08dc5a1265c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 10:30:24.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZFHun9OfyAIt1QcpS4bZmLr02AvVxi2QtYLV0qrs5nmsq6VwDVZ0vz4Av+q5UfMslyZrlSOZ7GkcXQfAu8Udo8BjSf/KAS+g1ZhgItvsNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 8 Apr 2024 19:38:06 -0700

> On Fri,  5 Apr 2024 15:37:31 +0200 Alexander Lobakin wrote:
>> Ability to handle maximum FCoE frames of 2158 bytes can never be changed
>> and thus more of an attribute, not a toggleable feature.
>> Move it from netdev_features_t to netdev_priv_flags and free one more
>> feature bit.
> 
>> @@ -1700,6 +1701,7 @@ enum netdev_priv_flags {
>>  	IFF_NETNS_LOCAL			= BIT_ULL(35),
>>  	IFF_HIGHDMA			= BIT_ULL(36),
>>  	IFF_VLAN_CHALLENGED		= BIT_ULL(37),
>> +	IFF_FCOE_MTU			= BIT_ULL(38),
>>  	IFF_LOGICAL			= IFF_NO_QUEUE | IFF_LLTX,
>>  	IFF_ONE_FOR_ALL			= IFF_HIGHDMA | IFF_VLAN_CHALLENGED,
>>  	IFF_ALL_FOR_ALL			= IFF_XMIT_DST_RELEASE |
> 
> Any reason not to make it a bitfield? I haven't looked at the longer
> patches but this one seems to be used like a basic bool.

This whole enum could be made as bitfields, should we convert it? Would
be a big patch tho ._.

> 
>> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>> index 2de4dd5a30de..71e36e1a1b15 100644
>> --- a/net/ethtool/common.c
>> +++ b/net/ethtool/common.c
>> @@ -47,7 +47,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
>>  
>>  	[NETIF_F_FCOE_CRC_BIT] =         "tx-checksum-fcoe-crc",
>>  	[NETIF_F_SCTP_CRC_BIT] =        "tx-checksum-sctp",
>> -	[NETIF_F_FCOE_MTU_BIT] =         "fcoe-mtu",
> 
> 
> But this definitely _is_ a uAPI change, right?

Why?

> Some analysis why this is fine and why avoiding the problem isn't worth
> it in the cover letter would be great.
> 
>>  	[NETIF_F_NTUPLE_BIT] =           "rx-ntuple-filter",
>>  	[NETIF_F_RXHASH_BIT] =           "rx-hashing",
>>  	[NETIF_F_RXCSUM_BIT] =           "rx-checksum",

Thanks,
Olek

