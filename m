Return-Path: <linux-kernel+bounces-131842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B044898C73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3F5B27081
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E511F945;
	Thu,  4 Apr 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGe4sBv5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD41C6A0;
	Thu,  4 Apr 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248928; cv=fail; b=D4mVxYmccfaRwHP+RD22KLbgI/blYpEWJfOObKpxXTKRvJumdFExENVh6DSQNS8u9WwPPRvP8w2TXvCVPzMz0Pnrtm5eZvHvvzYDta9T/owDZc4pE2hR6ZGDY3VWTJOrGPTbwH/MEIGaG5fNY+uiTEE5dXI6gLKSzd6wVAEnM2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248928; c=relaxed/simple;
	bh=Lzh4zQDlEjxwQ2vnuYxHWuR6JSgNHX4QDWBOIPzWplQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GTJ1EnfIBzuP0cUhrfMT/ekqS0KMjAeAjvqI3ih4zVp7KRZ8Vip14Z6UwmmwIY1mfxqkbjUypqSQGNq1ZEWyUa5T8vnweJTRuE85A5p3kiqRzhb/DdtUWDaptFxZqnJUJpcslAFb4AZP7RBajzLNc5zbEgkI7wsjqmY9RwLy+VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGe4sBv5; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712248926; x=1743784926;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lzh4zQDlEjxwQ2vnuYxHWuR6JSgNHX4QDWBOIPzWplQ=;
  b=GGe4sBv51p4QIwW6CGCRIsdoeR0B//2qtg74TC9lm4bVHHldTyl2h4Rg
   8JputF5RPjoJPUWn/iQXnoEPBMlE+oZwoERcPadKXF5+sy64P27ugtMXM
   9l//na9QL66OUQvtw9RjfmpkZMwmQxEkJZsC8/o9GiEOTJdfqNF5gaGTL
   k1QIIpWS5c7GJcwY3Hql2vsJLUZnbFy/8wxhPXTmitbQfQrVt6JIfw8lf
   7nvZUWZo2fPlhI2DZl7rsS2CbLXZo1BOpJWsKCwDcLqFcg2QCQ5YiMOt7
   A7XgN9V3yX2OvYdsUo2SK+GB8GABa8tkJDpL0Bp1zee0qRqKe6N7CG13v
   w==;
X-CSE-ConnectionGUID: kGLjI5TjQ5uUseDHYnQDTw==
X-CSE-MsgGUID: lpox6b4OQdGo9ixNGF4vhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18982317"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18982317"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:42:05 -0700
X-CSE-ConnectionGUID: 8AP/3EqRSaCov9B4uE0pyA==
X-CSE-MsgGUID: l+e56g0US22nOSwKJ2ezhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18860511"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 09:42:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 09:42:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 09:42:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 09:42:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 09:42:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv3mJyfXR6geFW0H688AUBZnn/syg6yaiH1JO6iETdtTiVzeb21sRqLtPOdvZsCExD5Mv3hQHfUhXnW5dnW9ABp2LD87ybII24qIUC3flNpWTK2l54lNve6xYFLY63tpUXsxUHUMxSH6nsGEkzhO7OIWvqKBEDp+PkruUCLQrssxuWoTgFNlzMrYIBJjMQoQMnG8NZa2vJ5BGQvKmZ+ETE6e0fYcC6XlUJlha2zX62fUNlGi2Tzd5gFJE1IzIEAMy6Efi41C6TX7RINiSJy8WEHyTu5P30NvMVjo3S/W/aCGZhIGUIz28p8J+HjtU2MyF6OJPFih7N6+zZSZKj5nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhWbHEQAA3NEOjUohZDSL84aWGhsE0wGykB9BwKRYgY=;
 b=WUrHDjZWlKyNzX07yjieflW7DndcDW/A7rjjmFKBMoq9+9RaUVuZhqSfIfAILNENmdjPGfrQYTeKhVWtfFZ1rUxApwifc6cyqRnwKWvNe/zJWdDB8TSwhr3DKKsX3U6pDnCI5E8rZLYh1YnLoCu5Kd+QvUEJLD/67s36fqvqJ/l/1rHdoIp7ZrG5lv2mLsfv2sskfnP7Lz3grmOjbCGY2GKte6P8NDYRiR39/l+NZ5QgpxnZM6onSgEJTtHwPu1Pvi/lxJ0sY9qhta06OtZSUpSiiQhJ2TTlp+wyAJBLEMBINmW0ast8Wu8KKyvvACyEr0o3yBaDJ6pNf1jB7P+cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Thu, 4 Apr
 2024 16:41:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 16:41:56 +0000
Message-ID: <1b1dfe1f-57ed-416d-a9c0-408aafa69583@intel.com>
Date: Thu, 4 Apr 2024 18:40:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] net: create a dummy net_device allocator
To: Breno Leitao <leitao@debian.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <elder@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<nbd@nbd.name>, <sean.wang@mediatek.com>, <Mark-MC.Lee@mediatek.com>,
	<lorenzo@kernel.org>, <taras.chornyi@plvision.eu>,
	<quic_jjohnson@quicinc.com>, <kvalo@kernel.org>, <leon@kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240404114854.2498663-1-leitao@debian.org>
 <20240404114854.2498663-2-leitao@debian.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240404114854.2498663-2-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7811:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aq3cuYmRf6iL5RTnZTk/GAX2cNd3OoQmChs5n+xOVE75DBUsbVHpm5HmQEW4BsrjruB+dYEDlTpOu1h/UCsXlQnE2xjSF6COSiXJQRbDkNsfIgOwbXEclMRCYGXRqx8/Q6s8W4qH3/SDamt4MvG8DlvPqvuqQpIgHtSC75LgIpUpsbbX6W6Z2uwNZmz6N2iRCXZZWZ2U8Wfabk2IDlWO0um0PUEUK6hqeL+TyOSZH5gkaLNpdalnqLckxoCzfYRx915YoWVuD/KMlkElwUHN10kdEqpNWsM5tYGb1EXbl172A2VtW36WnAiwFe9U3WG269XYq0ArAGUUVps1VcG2Rzh8QdMWx41fOtsBO7CUWLc7Q/BZZfEOQXu4463kh+X/GLyst9jGPii4IQj8ySR1rT/DUxDiKPjp+zuu2Jfq2dkM/RIDAxxtZbdZs0vGvtmfXZL/9iYigNObji1P3xLx724p/h+9HoZPJeXqjZ0cFWU+TU7r/055pXU1rsIcmxQdg05xvR6pQnYi9x8z/z1R9d7j72LWzYysihK5nBcex5viwcm5hR+czz6BaCrksJuk1aaxr0ceBNPHnPNpdhFA7q8xrF7mT9D/hc0kBJdtjlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW5UQkNqQ0M4SHlUSXlUUjAySWsxbFIxSFE3clB3dmxzemJqY0wyWjlFL1lp?=
 =?utf-8?B?KzZwNzRjRjJJcTBTa2d1N3RUMGlNMmZ2cTRzaW4vb0ZoMWVLQ3lHcW54UlVu?=
 =?utf-8?B?aHRWclFJV3d0NG9HNGx0V01JNC9RcFJUb0c2eWlQMlk0TE8wUk4xZFoxRkUz?=
 =?utf-8?B?S0FLOFlqN3VMWVcxOERwNEM5NUgwRGhkMmFYYlJyR05zY3NvQ1BKTmNZaTAw?=
 =?utf-8?B?d2c3R3orQm1mMnhBTnIwbEtrQXhON3d1SVdxNTFBaDBaRm1IdFdsKy9mZ2xj?=
 =?utf-8?B?RDZOQU51bWR1TnNob2pCdGJKYk1CMXFkeUEyYm1YbXNxN0FNZ3B1R05CWTZU?=
 =?utf-8?B?STFPb2pQNVY2UW5KYUlOTUordGRMS01NemRPUGJKL2hmNE8rT3FTclp5dWdo?=
 =?utf-8?B?VlJKaHpUR2xhV3lDMHYyN1BEUC9GbHBDdE1ONnlBcHY1SFRwYjVhZ3F3TzJT?=
 =?utf-8?B?Sk8rQWJzK0ZxUlF1bUYwc2p1ZW5nT0o5LzhaTmlyQ2hDUVVNQW5QaHBIc1dW?=
 =?utf-8?B?S29TYVRvdkViUDRqa2lqL2FoZy80dmw1WW9YNVR4dHNhbXhja2NQNGQwYlQ5?=
 =?utf-8?B?VFVUaWQwN21WUDBRcURhTm5YQ3pEbys3OHJpYkNvVUIyem91eFFhM1MwcW51?=
 =?utf-8?B?emxKZjU4aG5wazZDSU9xOUZySWt4ajVaSlVLdEM0ajJ5UFNiazQ4VUxnaGhW?=
 =?utf-8?B?V3BZZWd1ZHU3ekZ0bjVDUEpLdktOWG0vdEY0Zjk4TWZtWTNHenFDVW5jeG1R?=
 =?utf-8?B?cFZUdnFtUm5NYjQ5dFF2dCtuNG53a3VNMVd6ZXlxNmlFTFZFVDB3dExIZDE0?=
 =?utf-8?B?bTBqbS9LVWw3VGI2TktXcVZvNCtLMldVenMxNlhFWWR5OFQxWldFR3hFYXN3?=
 =?utf-8?B?aU9KenJ4WHE5NXNrWFRGTkZZZnY5TXV4am5KZEdDWkg4cC9yTURWTTJRaWln?=
 =?utf-8?B?NGZWb1k1cHRCOEFkbEFLNUlVclZCVHliVmloaVI4RlJJSlhPcDc4b2Z3bkZG?=
 =?utf-8?B?cmpFbHByWWNYN3ZsL05kQ3FRQkJSRWk2NHZ5VXJmOXdNU1owSGdGS1d5Q3JI?=
 =?utf-8?B?ZTdJNTJyMGVmUFcrR05SeWxmWXJrcVBDMGRNemJhMjJ6MXlqU2NlQzQ0SFdx?=
 =?utf-8?B?OVhTbEFxbmFNQ1hEZHNTaFM3QmFJRitSY1drak01UGVJdGR3OXJUYUdPcFBH?=
 =?utf-8?B?ckZ1SWdsUStTS21yQ2tRazN1cUZmVlIzZ2x2eFNheVE4Rll1eGhDdmdNMTkx?=
 =?utf-8?B?NFNzRmVacE5qazNudFF0V1d3NEhySkQxMGFGZERlNkJ3VThyMFJCb0c1NWhl?=
 =?utf-8?B?SnlYUkp1eVRJSmE4TWcvdWxHcUxnTmtMYURURml1SWxHWVBvbmZERjBITUpZ?=
 =?utf-8?B?YWlFK2NuL3YrT3k5NVYrQldZL0ZUTzVES2hBTlVPY0JMNUJxY3hsQk1IaDgx?=
 =?utf-8?B?bUFBQmswNlg0VnpCOEhmNFo2OXRhSTV0a29hWFRYaEY2NE9qQmFyTnYrQ1NM?=
 =?utf-8?B?NXpmVTdTdmRxREQrbCtpeEpHZ08yS3JwenR4MkZQWkRmTXdIL09SbnNMSXVr?=
 =?utf-8?B?UzlFZGcxVXNTdjJnTSs2SURmZFV2MFNCd3p6aUE4SURqamZCZkdWQXhoeFN4?=
 =?utf-8?B?SVBvWlJIckY1a1lDMnkyaEVxZkdOb3ArN2hmRGk5TXorRDFqTTkxSEZTdnpq?=
 =?utf-8?B?NWE0MmViZDRiM1pCa0pWUUVsZEdUekZDRnlqZDgzUlAybUpRWDRlcERBcmM3?=
 =?utf-8?B?RUR4R0cwWTlMK0xodGN4NEl1K2k1TkloZlFIVCtndklPUzVOZjBEU3owME9F?=
 =?utf-8?B?Qml6YW56SkJHK1dmN3JMSDdLRUpYakZBU1QvaFBNNU9LS1pJVCtOZ1MrTXdT?=
 =?utf-8?B?MURGSmpQc2ExRnVmZ01qWHN1ZkhLdk5jU3M3U01DdE9TUDEvK3gyZWc2ZHZJ?=
 =?utf-8?B?b2VLQ0pscFdjeUg3bEY2VFhEUWZtb2txeENpSmg2dDJjYi8yanRmeDFXVlB2?=
 =?utf-8?B?QVRQb1l4SXJrVmZ6ZFpkU21EMjlWSGdEQm10b1hKSGkxb05ZcStLZ2N3bHZs?=
 =?utf-8?B?UnRDdDdQOHZQK2kwLzduSDQ4MzhqNUQxdlZTSUZkNHd5b1Rjak4vMGt5b2M4?=
 =?utf-8?B?blZUVkEvSWJVWmxjZmhjc25RSVFNT3RrSjFHdzR0clRaVS9QRG0xTU52ckR6?=
 =?utf-8?Q?u2wKxr+PBVAvmpqYhPvPVIQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d88724a2-0f55-4c72-6150-08dc54c623f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 16:41:56.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P08Tif2r0+LjXr9CWrij060feAnyB1FAOvgSHBg+Eagqr3fcOMyqfol4OhvD5hL0euVrLphhfTjT3Ha7askxOC+QpWhtUhbyudLfgdpAQl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com

From: Breno Leitao <leitao@debian.org>
Date: Thu, 4 Apr 2024 04:48:41 -0700

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

[...]

> @@ -11063,6 +11070,17 @@ void free_netdev(struct net_device *dev)
>  }
>  EXPORT_SYMBOL(free_netdev);
>  
> +/**
> + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
> + * @sizeof_priv: size of private data to allocate space for
> + */
> +struct net_device *alloc_netdev_dummy(int sizeof_priv)

Repeating my question from the previous thread: I see that in your
series you always pass 0 as @sizeof_priv, does it make sense to have
this argument or we can just pass 0 here to alloc_netdev() unconditionally?
Drivers that have &net_device embedded can't have any private data there
anyway.

> +{
> +	return alloc_netdev(sizeof_priv, "dummy#", NET_NAME_UNKNOWN,
> +			    init_dummy_netdev_core);
> +}
> +EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
> +
>  /**
>   *	synchronize_net -  Synchronize with packet receive processing
>   *

Thanks,
Olek

