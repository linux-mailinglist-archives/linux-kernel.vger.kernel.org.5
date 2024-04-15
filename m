Return-Path: <linux-kernel+bounces-145574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27E8A57FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DA61C20A26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383A79945;
	Mon, 15 Apr 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SM87uiHu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A68627D;
	Mon, 15 Apr 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199044; cv=fail; b=Ts59D0hMMFnn9XzhCHTV3YAPxWxoyorwQu+mCCZj/uleh8CIw5Ud26PEd60xYPmHPOpGEDI5hzpkHpOyaUPW+ry+8v4qjlb8seEn3oVVOk9Dr7UmyzkW0IA9lO3b+/YM2J4BdEtbncTAwkx5kwQ9Uzet0yScK1bPziclrvgCiEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199044; c=relaxed/simple;
	bh=dUCTgmqjWnosLjClj+F48+ss8DujRuzSIa9skmK186c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qr5WO/cLoZFumUuSb0OsJK1SUG+FDkt+G+Fdq/h6LUs4PPP5g6kjk2rKOXY6kvBfEwBGxnFqzZekhvX9LVO+wsHNy+ZGEsQk2yVGmfS5QuOK1buD22NOlghDwaOTmOuq4wEwwrbYu5QGEjE6ixj4CLDCCckeWNrSQ+pWc9vCo5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SM87uiHu; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713199042; x=1744735042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dUCTgmqjWnosLjClj+F48+ss8DujRuzSIa9skmK186c=;
  b=SM87uiHuvX+ToDY9qoibJAKddAkTUcMOEIiejTQkRceJQNrGafKEFf+8
   fh24g+QdlhOtoC4NmusHNDjv5Dk+EyWzApBk4lFc8pI60hNfMjj3FkKhY
   XeY5Hp4jrXPeSOlc93yWatnIj+sAcTkhh6cvgR9/lmxq9JdLX3U2QXODv
   zkphin2VKGFHkW0M8tUCxPeltQJBE+vr12U0QHuj7xP0xiBP0uDUX68iX
   juxacPqbY/YTyL3x09UQZ7Ru1vhrpdyQkINgX5AVP8f5p3BOoVcTgEn9y
   p2AqncUtT3X/22Xr9X+yO1rIJnV/O1rEf97+/txhRTRenYXTuYswsfpfb
   w==;
X-CSE-ConnectionGUID: n4oDepi1Sz+xPkeFAA/Gpw==
X-CSE-MsgGUID: P9aSC+S2RHaI2iUuj7TwkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8471420"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8471420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 09:37:19 -0700
X-CSE-ConnectionGUID: QVRMjjRrRheq0rg0847tXw==
X-CSE-MsgGUID: nmZWEVSbRSOJoemt/mw+yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22022656"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 09:37:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 09:37:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 09:37:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAnuZdEl/hLIu0RH+D1UFszW4XlWHO4EHMPmHXgDF9fgtVr/U2ukC+mggnPAP//vNBznG8HXbcMavvSjywkE7qrmdl4142XAaebYuLvd6o95s7NbAj7dkyfM8lcNRGB6jOV4AWOhftEm3J0Ja6nOwOZD7kwzB4Y4ZVculFG4K/3+53DTHMI9hpgM3F7TCZD0P7u9BU03FwS3xA2S8hnvlsJtNdRRg7G7bQkuglFvosFaO7BV0p/7UTwfGxVpetrowpzOOL0fapqXIXiiz8IZ+6gavsmUEstKOyakzGtZaEiWhvzi/nJQY138CTzkcYaEGDstqwo2aIIWlaZSv4ROGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR7e7F/FjTN5OiMiPKOLRUKWm5CtRPVHzYbxvvQyMKc=;
 b=U1M4ctq4LO+7zsgN8gZkftq+RIzS86uPr/mLz1TFhPrWNs/6EYtU3jEISKDqraTgsT/XkqU3qV1e/ftniRLzD6wefKg3RC2/STsTKuuq6n7xqTr1djrVyfNMHTjO5A7k16rOJaBqCdKuIu/jVjErL4Dia0Gjj0IPihqKO13AsIhu4vRZrtrFSMzJ5xcndCaD+R54LVAUUXpgbuWKswkn1fU5yrBImUlPxNtbKClXwMDCNFgWIL294QibHWRHNojqBlBWf3vqBY9QQ20UDi5ySB+7f8nJK2q2z+fSr8piC2Zk58ZurYKRaAFa3yPhBeFXExX8KG5uKEUUlDknKBbaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Mon, 15 Apr
 2024 16:37:13 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 16:37:13 +0000
Message-ID: <a630e762-a866-7ce0-84ec-22ed09a92f89@intel.com>
Date: Mon, 15 Apr 2024 09:37:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [intel-next 1/2] net/i40e: link NAPI instances to queues and IRQs
To: Joe Damato <jdamato@fastly.com>, "Nambiar, Amritha"
	<amritha.nambiar@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <sridhar.samudrala@intel.com>,
	<nalramli@fastly.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240410043936.206169-1-jdamato@fastly.com>
 <20240410043936.206169-2-jdamato@fastly.com>
 <bb0fbd29-c098-4a62-9217-c9fd1a450250@intel.com>
 <ZhckCOFplMR0GMjr@LQ3V64L9R2>
 <f6a3f010-8fb5-4494-9ef0-23501ea01f64@intel.com>
 <Zhrb6qJAoTYks2lK@LQ3V64L9R2>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <Zhrb6qJAoTYks2lK@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|MW3PR11MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: d44d3139-3e46-47ef-0375-08dc5d6a4d75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFTCucR9SB3vsIA4HJTm/1lUgt4ouYYrwnPf8FFlX0eJW8qvkPPwcrdbgIr3QSH1emJpudr18Te3NFg4wGsxhoXj73yVMSEHdNe6KwGmHP0QZ8UZ7er2e0nBMN69koVB3gUffmlziXx46Op2GWNlFokmSRuPqmLHuwlJRWB+b84eB5juHPTkXltJsw0fea765dIjXTfai0FgOFyJbRPDjv3S7KW0mAzVI7OcHd3VFyeqxI18woNv4dSKCurRnW/SnApkZziZ+gFa2z1o86wXaWEZqlF+7j3fDkzs/eogGWy6Gpib7fP6dzlmPY1uFzt4U02sD9LgjUZC+IARou49QIBHXz8gehGd3BWT3mqZDvKurgNsuEwe7gNTMfTH5rb4OcyQ6ChtbnYYf5h0GJoOld45LK1h7uGOaaSknS9ZOYeY931/FWFugDw9gJNqH9L1KUSVVAbeqifGMLgAO6sU4dqyC8U39NErafX92Pt/4FThOR+XhGDc9mkXirYY5DjWnbFl44ZksweNkGAgbEhNgfc4Iy/FPSkfpkKutzpMLZcWqGYzGgjo5pv3AbGbMDfA+xnv2Br7IuiO/st6i5XUn8b74ra7yrOqCMYJyZcqX7sbFaZ4cXUU/J7JlTRcQD+rYkPHRYqCU8LBhRBvI0Od/pDNVgbK+VHJFH3iwIxCZdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmgzNU1qZTlidUVZY0VOcEtrK1FDVSt2VVNrdXBRT1B1a25oMkd5M0JITUpt?=
 =?utf-8?B?aDBLV0xvczZiNnU5RmpiVlpzTWR1WDhUVnBNbTR2QlQrbmZVckZUUmJnNEFw?=
 =?utf-8?B?TnNYbzc3eGdwQkYrdHpyRVRvTE1SYWhoZkQwWDlwR1dpRTNVUk9sYjMvb09N?=
 =?utf-8?B?RzIzQk1MaDFaSHZsTVdYcDVWb2Zjc3F5TTdLUm5PTGlOUkVXejY0Q0dxOG9q?=
 =?utf-8?B?YW5vMUV2NXRwTjNCa24rS3FhRGpLdWhENXZsQ1dFR0Ira2VJRm1ZN25mYmtr?=
 =?utf-8?B?WGxBZXRsMkF3Zlo2dWVxOGlCT1dqUXpWQnJuQ3VmYitiZCtSWHB2azBXS1BC?=
 =?utf-8?B?OWx4RkpmM3R1VHJ3UjlYWXBvV0x4N3ViSnJnaXdLUXpEVmNsWDJCNU9US2JZ?=
 =?utf-8?B?SVNieCsrcjdkbDBLR1I5TDUzTmZxdms0OXFGeU4rOHlUUkRUeDBJTmdDa1hT?=
 =?utf-8?B?dXg4Q0JtQlgxQXhaTVBLVnRuUEU1ZytQc1FWM1ZTN3o1RE9LNVkyWWY1c0Vr?=
 =?utf-8?B?RERROUN5aVozZitmQzlBdVZlWURjR3J1Tit2RGpoYjc4SjdRS2k3Ymw5NTQ5?=
 =?utf-8?B?dk1YcnNrbFRTOElNYnJvUWtxQ2E1YmQ5alR0dnRMc2FRWXNCL21BYmkwUkkv?=
 =?utf-8?B?TTRFRDRPT1JqQjBpd2Q2eW1DT0I3NEVuZDViWHk0RGJxWi9QamVKdHdmU3Ar?=
 =?utf-8?B?enVmcTdLL2I2Undydk1rOG8zWSsxR0JXQ0dSbGc1Uno2MFN0WDloZituMnFv?=
 =?utf-8?B?eisxNm5JSWRuRTM3cHAvbHpoaE1nTEJ3QkhOZnlNaGJSUUhUTlBTZHl3QnVM?=
 =?utf-8?B?YXVZaDkrZzNmMzkwWXJYalA0Yzl5Vko0a3BNMFpCelJ4SUlKMEU4amlzdG4v?=
 =?utf-8?B?QkRIdnd4eFoxQ3R2MEtwSCswWEZQZnZqZWNJMkw0UklGZ1hPWmZqOVFsZGsx?=
 =?utf-8?B?ckhRbysxUnVIRHZ2ZHMvaHljSGpyWmJCYTBPU2piV2UvZDlCNmxycHd5blI4?=
 =?utf-8?B?bFdVdnVvK0tCeGZPRWtMaithd0QvOUl0ZERCWkMxQWtXWXNOc1dvRkU4Z3dE?=
 =?utf-8?B?VVl4S0RudEtvUXRhZTJ1NngzU3RBeGJYMDlTODVHRnM0Q090ckJJbFRkaXdo?=
 =?utf-8?B?djlwTTNqT1BuR2RHN3BWMWpMNmdRY3lmVjY5c1VYS0IweklRNUxWbGk5NVIr?=
 =?utf-8?B?VGxRc1J1bE50TVNUd2QvTE1ldW8zbTk0elptVWNicGNUTXlwSWdWL2RQbTVp?=
 =?utf-8?B?SzBVWk44K1M4aU9hL1UxZnNBb0szZGx5L3FhSmRNeldxOU9JU2JHOXV0V0E0?=
 =?utf-8?B?dkhOMHZIekVOak85TVd1QzdpNGZOVFEyUlZCOTdISU56SkpWME4zNVNQMEVZ?=
 =?utf-8?B?Mk5RbU1CYnN5THprRzRQcG0zUkVYMzJBODhKclZmOW5JSUsySmo3dW9obXJn?=
 =?utf-8?B?TUg4NEQ2bkl1Q3VZU1ZvYTdvYm5DSGc2N0Y5eTA3TC9qTGZmTTE4TFJ2MTU2?=
 =?utf-8?B?MUtackJTdkNpZU9adVdqbm5kSHZGZytpT2NYeGRoOWhKdnpWeDdMbmQ1Y3Nv?=
 =?utf-8?B?OHB6RlhtOHJYaHVLbzJMSzVqMVJBb2l5OWpOV3V5Y3MzcjZIb25IS0xsb1NH?=
 =?utf-8?B?TUozNmtVTHg3TG43cElkemNmZGRpd1JNdnIvYnZBV2RsUCtUOVdBQWVEL24r?=
 =?utf-8?B?eElINTZpN2Z5UWUvdnlWUnZtK2pzRG1UaDRSMVJGdjRDN1BROWlKaXRRbDFI?=
 =?utf-8?B?Vk5teEczc2FSM3NDL3gyaGlXVUtJRU5IL0pXUVZ1VUxycC9XeE9BdnZ5VUFU?=
 =?utf-8?B?cVg4ZWs3U0VMVzdtQXd2MnlxNXMrbzAvYlVWWm51MkJwS2lYbkh0NzFwaU5z?=
 =?utf-8?B?cGZwYlRGM2ZNUTBZK1V2UmdpQzJMTmQwWU5HOHprZnZYK1JpbDkxcUlBMS9m?=
 =?utf-8?B?ZGtwVFJvY3lNS2VLYW9kUDdGL3J1N2hZL3cvV3pnYng5U21mcUtKbU1heEhi?=
 =?utf-8?B?VEZadng5WUM5VjBhMkhpZ0xXd3Bpb3dKS0JEcmFlRlJvZFRDSTdTU2tBOER0?=
 =?utf-8?B?aUhzeERGMk9vc0IrVmZSd0pZVDYyZ0twMnNPS3ZzQ0luQW9wcHkyK0EzM2tT?=
 =?utf-8?B?eCs5ZlVEdSt0WU1HWmJHeHlKYjRBYUtQQnZjSUdJMHBSL0liR2lSSUlyRnh2?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d44d3139-3e46-47ef-0375-08dc5d6a4d75
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 16:37:12.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XelPRRhRBvpWOVOyBSlzdavRlSXzISe7sN+jJNPRlOHdkoJCeLkjlKl+mY0xaPJTiGBiBsFiC9wHfUaEocuCLzY1uLocZFFfh333ksiwIdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com



On 4/13/2024 12:24 PM, Joe Damato wrote:
> On Thu, Apr 11, 2024 at 04:02:37PM -0700, Nambiar, Amritha wrote:
>> On 4/10/2024 4:43 PM, Joe Damato wrote:
>>> On Wed, Apr 10, 2024 at 02:10:52AM -0700, Nambiar, Amritha wrote:
>>>> On 4/9/2024 9:39 PM, Joe Damato wrote:
>>>>> Make i40e compatible with the newly added netlink queue GET APIs.
>>>>>
>>>>> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>>>>>      --do queue-get --json '{"ifindex": 3, "id": 1, "type": "rx"}'
>>>>>
>>>>> {'id': 1, 'ifindex': 3, 'napi-id': 162, 'type': 'rx'}
>>>>>
>>>>> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>>>>>      --do napi-get --json '{"id": 162}'
>>>>>
>>>>> {'id': 162, 'ifindex': 3, 'irq': 136}
>>>>>
>>>>> The above output suggests that irq 136 was allocated for queue 1, which has
>>>>> a NAPI ID of 162.
>>>>>
>>>>> To double check this is correct, the IRQ to queue mapping can be verified
>>>>> by checking /proc/interrupts:
>>>>>
>>>>> $ cat /proc/interrupts  | grep 136\: | \
>>>>>      awk '{print "irq: " $1 " name " $76}'
>>>>>
>>>>> irq: 136: name i40e-vlan300-TxRx-1
>>>>>
>>>>> Suggests that queue 1 has IRQ 136, as expected.
>>>>>
>>>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>>>> ---
>>>>>     drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
>>>>>     drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++++++++++++
>>>>>     drivers/net/ethernet/intel/i40e/i40e_txrx.c |  4 ++
>>>>>     3 files changed, 64 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>>>>> index 2fbabcdb5bb5..5900ed5c7170 100644
>>>>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>>>> @@ -1267,6 +1267,8 @@ int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
>>>>>     int i40e_open(struct net_device *netdev);
>>>>>     int i40e_close(struct net_device *netdev);
>>>>>     int i40e_vsi_open(struct i40e_vsi *vsi);
>>>>> +void i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
>>>>> +			 enum netdev_queue_type type, struct napi_struct *napi);
>>>>>     void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
>>>>>     int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
>>>>>     int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid);
>>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>>>> index 0bdcdea0be3e..6384a0c73a05 100644
>>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>>>> @@ -3448,6 +3448,58 @@ static struct xsk_buff_pool *i40e_xsk_pool(struct i40e_ring *ring)
>>>>>     	return xsk_get_pool_from_qid(ring->vsi->netdev, qid);
>>>>>     }
>>>>> +/**
>>>>> + * __i40e_queue_set_napi - Set the napi instance for the queue
>>>>> + * @dev: device to which NAPI and queue belong
>>>>> + * @queue_index: Index of queue
>>>>> + * @type: queue type as RX or TX
>>>>> + * @napi: NAPI context
>>>>> + * @locked: is the rtnl_lock already held
>>>>> + *
>>>>> + * Set the napi instance for the queue. Caller indicates the lock status.
>>>>> + */
>>>>> +static void
>>>>> +__i40e_queue_set_napi(struct net_device *dev, unsigned int queue_index,
>>>>> +		      enum netdev_queue_type type, struct napi_struct *napi,
>>>>> +		      bool locked)
>>>>> +{
>>>>> +	if (!locked)
>>>>> +		rtnl_lock();
>>>>> +	netif_queue_set_napi(dev, queue_index, type, napi);
>>>>> +	if (!locked)
>>>>> +		rtnl_unlock();
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * i40e_queue_set_napi - Set the napi instance for the queue
>>>>> + * @vsi: VSI being configured
>>>>> + * @queue_index: Index of queue
>>>>> + * @type: queue type as RX or TX
>>>>> + * @napi: NAPI context
>>>>> + *
>>>>> + * Set the napi instance for the queue. The rtnl lock state is derived from the
>>>>> + * execution path.
>>>>> + */
>>>>> +void
>>>>> +i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
>>>>> +		    enum netdev_queue_type type, struct napi_struct *napi)
>>>>> +{
>>>>> +	struct i40e_pf *pf = vsi->back;
>>>>> +
>>>>> +	if (!vsi->netdev)
>>>>> +		return;
>>>>> +
>>>>> +	if (current_work() == &pf->service_task ||
>>>>> +	    test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
>>>>
>>>> I think we might need something like ICE_PREPARED_FOR_RESET which detects
>>>> all kinds of resets(PFR/CORE/GLOBR). __I40E_PF_RESET_REQUESTED handles PFR
>>>> only. So, this might assert for RTNL lock on CORER/GLOBR.
>>>
>>> The i40e code is a bit tricky so I'm not sure about these cases. Here's
>>> what it looks like to me, but hopefully Intel can weigh-in here as well.
>>>
>>> As some one who is not an expert in i40e, what follows is a guess that is
>>> likely wrong ;)
>>>
>>> The __I40E_GLOBAL_RESET_REQUESTED case it looks to me (I could totally
>>> be wrong here) that the i40e_reset_subtask calls i40e_rebuild with
>>> lock_acquired = false. In this case, we want __i40e_queue_set_napi to
>>> pass locked = true (because i40e_rebuild will acquire the lock for us).
>>>
>>> The __I40E_CORE_RESET_REQUESTED case appears to be the same as the
>>> __I40E_GLOBAL_RESET_REQUESTED case in that i40e_rebuild is called with
>>> lock_acquired = false meaning we also want __i40e_queue_set_napi to pass
>>> locked = true (because i40e_rebuild will acquire the lock for us).
>>>
>>> __I40E_PF_RESET_REQUESTED is more complex.
>>>
>>> It seems:
>>>             When the __I40E_PF_RESET_REQUESTED bit is set in:
>>>               - i40e_handle_lldp_event
>>>               - i40e_tx_timeout
>>>               - i40e_intr
>>>               - i40e_resume_port_tx
>>>               - i40e_suspend_port_tx
>>>               - i40e_hw_dcb_config
>>>
>>>             then: i40e_service_event_schedule is called which queues
>>>             i40e_service_task, which calls i40e_reset_subtask, which
>>>             clears the __I40E_PF_RESET_REQUESTED bit and calls
>>>             i40e_do_reset passing lock_acquired = false. In the
>>>             __I40E_PF_RESET_REQUESTED case, i40e_reset_and_rebuild
>>> 	  called with lock_acquired = false again and passed through to
>>> 	  i40e_rebuild which will take rtnl on its own. This means
>>>             in these cases, __i40e_queue_set_napi can pass locked = true.
>>>
>>>             However...
>>>
>>>               - i40e_set_features
>>>               - i40e_ndo_bridge_setlink
>>>               - i40e_create_queue_channel
>>>               - i40e_configure_queue_channels
>>>               - Error case in i40e_vsi_open
>>>
>>>             call i40e_do_reset directly and pass lock_acquired = true so
>>>             i40e_reset_and_rebuild will not take the RTNL.
>>>
>>> 	  Important assumption: I assume that passing lock_acquired = true
>>> 	  means that the lock really was previously acquired (and not simply
>>> 	  unnecessary and not taken ?).
>>>
>>> 	  If that is correct, then __i40e_queue_set_napi should also not take the rtnl (e.g.
>>>             locked = true).
>>>
>>> Again, I could be totally off here, but it looks like when:
>>>
>>>     (current_work() == &pf->service_task) && test_bit(__I40E_PF_RESET_REQUESTED, pf->state)
>>>
>>> is true, we want to call __i40e_queue_set_napi with locked = true,
>>>
>>> and also all the other cases we want __i40e_queue_set_napi with locked = true
>>>
>>>>> +	    test_bit(__I40E_DOWN, pf->state) ||
>>>>> +	    test_bit(__I40E_SUSPENDED, pf->state))
>>>>> +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>>>>> +				      false);
>>>>> +	else
>>>>> +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>>>>> +				      true);
>>>
>>> I *think* (but honestly... I have no idea) the correct if statement *might* be
>>> something like:
>>>
>>>     /* __I40E_PF_RESET_REQUESTED via the service_task will
>>>      * call i40e_rebuild with lock_acquired = false, causing rtnl to be
>>>      * taken, meaning __i40e_queue_set_napi should *NOT* take the lock.
>>>      *
>>>      * __I40E_PF_RESET_REQUESTED when set directly and not via the
>>>      * service task, i40e_reset is called with lock_acquired = true,
>>>      * implying that the rtnl was already taken (and, more
>>>      * specifically, the lock was not simply unnecessary and skipped)
>>>      * and so __i40e_queue_set_napi should *NOT* take the lock.
>>>      *
>>>      * __I40E_GLOBAL_RESET_REQUESTED and __I40E_CORE_RESET_REQUESTED
>>>      * trigger the service_task (via i40e_intr) which will cause
>>>      * i40e_rebuild to acquire rtnl and so __i40e_queue_set_napi should
>>>      * not acquire it.
>>>      */
>>>     if (current_work() == &pf->service_task ||
>>>         test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
>>>         test_bit(__I40E_GLOBAL_RESET_REQUESTED, pf->state) ||
>>>         test_bit(__I40E_CORE_RESET_REQUESTED, pf->state))
>>>             __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>>>                                   true);
>>>     else if (test_bit(__I40E_DOWN, pf->state) ||
>>>              test_bit(__I40E_SUSPENDED, pf->state))
>>>             __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>>>                                   false);
>>>     else
>>>             __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>>>                                   true);
>>>
>>> I suppose to figure this out, I'd need to investigate all cases where
>>> i40e_rebuild is called with lock_acquired = true to ensure that the lock was
>>> actually acquired (and not just unnecessary).
>>>
>>> Unless some one who knows about i40e can answer this question more
>>> definitively.
>>>
>>
>> I'll wait for the i40e maintainers to chime in here.
> 
> Based on the findings of I40E_SUSPENDED below, the above if statement is
> still slightly incorrect, please see below.
> 
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * i40e_configure_tx_ring - Configure a transmit ring context and rest
>>>>>      * @ring: The Tx ring to configure
>>>>> @@ -3558,6 +3610,8 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>>>>>     	/* cache tail off for easier writes later */
>>>>>     	ring->tail = hw->hw_addr + I40E_QTX_TAIL(pf_q);
>>>>> +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_TX,
>>>>> +			    &ring->q_vector->napi);
>>>>
>>>> I am not sure very sure of this, have you tested this for the reset/rebuild
>>>> path as well (example: ethtool -L and change queues). Just wondering if this
>>>> path is taken for first time VSI init or additionally for any VSI rebuilds
>>>> as well.
>>>
>>> Can you explain more about what your concern is? I'm not sure I follow.
>>> Was the concern just that on rebuild this code path might not be
>>> executed because the driver might take a different path?
>>>
>>> If so, I traced the code (and tested with ethtool):
>>>
>>> When the device is probed:
>>>
>>> i40e_probe
>>>     i40e_vsi_open
>>>       i40e_vsi_configure
>>>         i40e_vsi_configure_rx
>>>           i40e_configure_rx_ring
>>>         i40e_vsi_configure_tx
>>>           i40e_configure_tx_ring
>>>
>>> When you use ethtool to change the channel count:
>>>
>>> i40e_set_channels
>>>     i40e_reconfig_rss_queues
>>>       i40e_reset_and_rebuild
>>>         i40e_rebuild
>>>           i40e_pf_unquiesce_all_vsi
>>>             i40e_unquiesce_vsi
>>>               i40e_vsi_open
>>>                 [.. the call stack above for i40e_vsi_open ..]
>>>
>>> Are those the two paths you had in mind or were there other ones? FWIW, using
>>> ethtool to change the channel count followed by using the cli.py returns what
>>> appears to be correct data, so I think the ethtool -L case is covered.
>>>
>>
>> Yes, this is what I had mind. Good to know that it is covered.
> 
> Thanks for the thorough review; I appreciate your insight. The more I look
> at the i40e code paths, the more I realize that it is much trickier than I
> originally thought.
> 
>>> Let me know if I am missing any cases you had in mind or if this answers your
>>> question.
>>>
>>
>> One other case was the suspend/resume callback. This path involves remapping
>> vectors and rings (just like rebuild after changing channels), If this takes
>> the i40e_rebuild path like before, then we are covered, as your changes are
>> in i40e_vsi_configure. If not, we'll have to add it after re-initializing
>> interrupt scheme .
> 
> Here's what I see in this path, namely that i40e_suspend does not call
> i40e_queue_set_napi but sets appropriate bits that can be checked.
> 
> i40e_suspend:
>    __I40E_DOWN is set
>    __I40E_SUSPENDED is set
>    rtnl_lock
>      i40e_clear_interrupt_scheme
>        i40e_vsi_free_q_vectors
>          i40e_free_q_vector
>    rtnl_unlock
> 
> It seems in the suspend case the i40e_free_rx_resources and
> i40e_free_tx_resources are not called. This means I probably missed a case
> and need to call i40e_queue_set_napi to set the NAPI mapping to NULL
> somewhere in here without calling it twice. See further below for my
> thoughts on this.
> 
> Continuing with resume, though:
> 
> i40e_resume:
>    rtnl_lock
>      i40e_restore_interrupt_scheme
>        i40e_vsi_alloc_q_vectors
>          i40e_vsi_alloc_q_vector
>      __I40E_DOWN is cleared
>      i40e_reset_and_rebuild (passes lock_acquired = true)
>        i40e_rebuild (passes locked_acquired = true)
>     rtnl_unlock
>     __I40E_SUSPENDED is cleared
> 
> So, in this case i40e_resume would want to to call __i40e_queue_set_napi
> with locked = true, to avoid rtnl since it's already been taken. I think to
> cover this case __I40E_SUSPENDED needs to be checked but true can be passed
> to the helper to avoid taking rtnl in the helper.
> 
> This is an adjusted if statement, which is likely still incorrect in some
> cases (especially when considering my comments below on the
> i40e_free_[rt]x_resource paths), but maybe getting slightly closer:
> 
>    /* __I40E_PF_RESET_REQUESTED via the service_task will
>     * call i40e_rebuild with lock_acquired = false, causing rtnl to be
>     * taken, meaning __i40e_queue_set_napi should *NOT* take the lock.
>     *
>     * __I40E_PF_RESET_REQUESTED when set directly and not via the
>     * service task, i40e_reset is called with lock_acquired = true,
>     * implying that the rtnl was already taken (and, more
>     * specifically, the lock was not simply unnecessary and skipped)
>     * and so __i40e_queue_set_napi should *NOT* take the lock.
>     *
>     * __I40E_GLOBAL_RESET_REQUESTED and __I40E_CORE_RESET_REQUESTED
>     * trigger the service_task (via i40e_intr) which will cause
>     * i40e_rebuild to acquire rtnl and so __i40e_queue_set_napi should
>     * not acquire it.
>     *
>     * __I40E_SUSPENDED is set in i40e_suspend and cleared in i40e_resume
>     * after rtnl_lock + i40_rebuild (with lock_acquired = true). In
>     * i40e_resume's call to i40e_rebuild, rtnl is held so
>     * __i40e_queue_set_napi should not take the lock, either.
>     *
>     * __I40E_IN_REMOVE is set in i40e_remove, and freeing the tx/rx
>     * resources will trigger this path. In this case, rtnl will not be held,
>     * so locked=false must be passed to the helper.
>     *
>     * __I40E_DOWN is set in a few places: i40e_probe, i40e_remove,
>     * i40e_shutdown, i40e_suspend. It is only cleared in i40e_probe after
>     * the vsi_open path is taken (in this case rtnl is needed) and it is
>     * cleared in i40e_resume, where RTNL is not needed, but the i40e_resume
>     * case is handled by checking __I40E_SUSPENDED in the first if block.
>     */
>    if (current_work() == &pf->service_task ||
>        test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
>        test_bit(__I40E_GLOBAL_RESET_REQUESTED, pf->state) ||
>        test_bit(__I40E_CORE_RESET_REQUESTED, pf->state) |
>        test_bit(__I40E_SUSPENDED, pf->state))
>            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>                                  true);
>    else if (test_bit(__I40E_IN_REMOVE, pf->state) ||
>             test_bit(__I40E_DOWN, pf->state))
>            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>                                  false);
>    else
>            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
>                                  true);
> 
> 
> But please see below about i40e_free_q_vector.
> 
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -3716,6 +3770,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>>>>>     			 ring->queue_index, pf_q);
>>>>>     	}
>>>>> +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_RX,
>>>>> +			    &ring->q_vector->napi);
>>>>>
>>>> Same as above.
>>>>
>>>>     	return 0;
>>>>>     }
>>>>> @@ -4178,6 +4234,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
>>>>>     		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
>>>>>     		q_vector->affinity_notify.release = i40e_irq_affinity_release;
>>>>>     		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
>>>>> +		netif_napi_set_irq(&q_vector->napi, q_vector->irq_num);
>>>>> +
>>>>>     		/* Spread affinity hints out across online CPUs.
>>>>>     		 *
>>>>>     		 * get_cpu_mask returns a static constant mask with
>>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>>>> index 64d198ed166b..d380885ff26d 100644
>>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>>>>> @@ -821,6 +821,8 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
>>>>>     void i40e_free_tx_resources(struct i40e_ring *tx_ring)
>>>>>     {
>>>>>     	i40e_clean_tx_ring(tx_ring);
>>>>> +	i40e_queue_set_napi(tx_ring->vsi, tx_ring->queue_index,
>>>>> +			    NETDEV_QUEUE_TYPE_TX, NULL);
>>>>>     	kfree(tx_ring->tx_bi);
>>>>>     	tx_ring->tx_bi = NULL;
>>>>> @@ -1526,6 +1528,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>>>>>     void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>>>>>     {
>>>>>     	i40e_clean_rx_ring(rx_ring);
>>>>> +	i40e_queue_set_napi(rx_ring->vsi, rx_ring->queue_index,
>>>>> +			    NETDEV_QUEUE_TYPE_RX, NULL);
> 
> It appears to me that some cases may not end up calling
> i40e_free_tx_resources or i40e_free_rx_resources, but most (or all?) cases
> do call i40e_free_q_vector which is where the NAPI is deleted.
> 
> It probably makes more sense to put the NULL setting where the NAPI delete
> happens, and then check those paths to see where rtnl is taken and make
> sure the bit checking in the if statement lines up properly.
> 
> Before I go any deeper down this rabbit hole, I'll wait to see what the
> i40e maintainers say / think about this.

+ Alex for input

Thanks,
Tony

>>>>>     	if (rx_ring->vsi->type == I40E_VSI_MAIN)
>>>>>     		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>>>>>     	rx_ring->xdp_prog = NULL;

