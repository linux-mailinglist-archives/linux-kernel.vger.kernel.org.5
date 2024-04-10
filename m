Return-Path: <linux-kernel+bounces-137751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B909289E6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D36E282A51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CD4637;
	Wed, 10 Apr 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYOFbdki"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3C19E;
	Wed, 10 Apr 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708205; cv=fail; b=mQYp0oU7V3f2Zmag2gTw2NMzKY62NgUJmdSyhczrtSMTCOQ61HZ8VuuFn5irxTc+PAVcXGELZBlPhontPlTzbm1gWAxyjyp4L/wt/xrhBEVv4Eyrsmm6cxjn16Z0ZRHxvhyuoZQLpXfoKkJT340jpv9/72+5Hv7aXw5s6gn809Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708205; c=relaxed/simple;
	bh=PbhcbfKo003ztH8PYbsoxnyKu7RYZS4Xy132VHmDoU8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qWto6o6J+5V8IpenGEamI07Dhszd83lOibA8uU1aFTq1bIXpFhN3hRk+Z1dtFvFGJ0JvIGxAyZ84XY8J8fAtp/6bgnTDr0p3xXA9mTS96Mdnp3PtAVKkvullGiJffxr+SpyfxFlgybhZkRonZAAMzrIWJB7UhN+fQCP/t8t/C5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYOFbdki; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712708204; x=1744244204;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=PbhcbfKo003ztH8PYbsoxnyKu7RYZS4Xy132VHmDoU8=;
  b=iYOFbdkiIEg12rS2B63tAUu2MBrm6ZfX3raAHcTGqkP0riUZ6wp0N/n9
   I6PyFlRmo5Jczv4/pDH0H8YeYeiEhbMUkK+L+zlWRzYktdF1ECypCyqZi
   zHKi4BhiFzPuBFkx4cy7gg7yPtfsTDrVep0hTczLlYoVqV/zhqfeEaKef
   impR0aIt+si74G24BMnK6Qnsf4hAqdhrUmS5nvmI41sC70ntsA2kbrGjQ
   JAr4wdhMcPQMcNG7CqZIOzuV+nE4qhPdxv7+D/BYlJrefze2WZaneuO4z
   zxiM5low6djAgQCqdvJFkzzDmY8JTFlnB03peHLJpxJodgH9x4wj6f5l4
   A==;
X-CSE-ConnectionGUID: SY00XwVCQeOT3diHNyeGcw==
X-CSE-MsgGUID: uvthBMvOQGKx8yzfS0BckQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11823723"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11823723"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:16:43 -0700
X-CSE-ConnectionGUID: fNK+LZLoTFunUQL6M6IQNQ==
X-CSE-MsgGUID: XEyS6HFsStunksflph7NAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20415002"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:16:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:16:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:16:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:16:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgHXV9ovhDnelKvfO2XbhM5b5kScvbIUljd3f8MNB4g3QWf6WA+lXlAzkKbqVureRj9BWE5P6QtuNzzzI5Ofgy7nyZVOW36yggoBeCuOnSC6PxiHaFgMThgdvPXRI7pzzSp993cXujiwO8PIwoEKzpyxb+kr4amj/JBmibOuL0UWLtmY83xnrcKm4PqO0DTRLlAI0ywOOwOmvxSIZQcfA+CJ7U153uxl0GtpeGJicPQEpbllfpUY8bOmdGls0RJd9Bkx/JkxXsgVecOllr8ZaN0r/mWRABqUJ+n7xUAIxKWS99iWNbbPtxcS+X7onbvD00y2v16UN+FC178SZJaK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI+BYo6j6W8EzKMZ1ny8S859Y2G2M2EOK1JQZW5BYRE=;
 b=jnZgOc89CCjxbkC69ZUpHae8un8oQHr1Fz4qdGfQiSsFWVNBScSVvkDptI0AszLf+KbCSlFu8emIHydMvqAHvg5ucjZogu6pPutM4Yt98yU25tKd86NwVHDimOHXSOeq33ib8hTDwntFqgTECXIsaONSCT8M44BBANCo/+dPnPoBHrND6UAbqMJRgUKVDZMvRA6J3cUP6JHAr1WoV1OUhIFj8Y+Vnw+O0UASbhle0MUOic6DG2t7XNdS+u9Ld71Vz8CYqXkcJltAa0jLIr7wXBSCfPhHe883UaMYtYRWMtJo+H/tvbxVKdYM75pc3sFEATAFWzpmu2lu6XCIUmdKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 00:16:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:16:34 +0000
Message-ID: <ab7eaccb-82e1-4656-84d8-7180a1eed02f@intel.com>
Date: Tue, 9 Apr 2024 17:16:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
To: Daniel Golle <daniel@makrotopia.org>, Vinod Koul <vkoul@kernel.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>, Steven Liu
	<steven.liu@mediatek.com>, John Crispin <john@phrozen.org>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, Kishon Vijay Abraham I <kishon@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Qingfang Deng <dqfext@gmail.com>, SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <da5498096f71a40ca1eac4124b7bb601c82396fb.1712625857.git.daniel@makrotopia.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <da5498096f71a40ca1eac4124b7bb601c82396fb.1712625857.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:303:b9::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Kx8g9DGk80mcxJlkv9B2haon0sHuxK9Yz9mMuwLAGrZ5KcMLxMnPLKgCrfiFKn41zJEbDznF7X2WroMWMuf6GVETbviyNzH9s87me0DKyxe1E2C6GnNPUVFBq0RkTV6jVKqCQhdpMWgNxwzZLjAEm0mIiH1mROVeNOV6jIMSbFRtNunlWTQyk7FjK9VRhf1Wcj7WQe+YYyddK2Q3A6+J8Qe1waJvmxm42BoTxx2fPv7wtaugJS4aN67XDT6Rpf7M6JVTtc1cCmPAEOPNY/pzPuSBFarUzNd9WubZEIhFYV5PblrGnznF+rxQ0ScKp5QXvV5CDFb+AXYin1DHXTH+WpdcZn4kVtA4Q6e5fapXzfrhyLs1cItGVfoKtDkW1vmsQsnm1BS5ZRHUT5NLNB23/Z84nzaUZQ45t1HkAbR12s3z3f3sYDcb+9KJtjfipKgEfNIN35j/wjnR5TlCFgojjA30pSMDYZyhmkRQevZWmW1taJYSIci1XvAk+OgwObVcgr/HlCC5+hHrgINWbp7Ka55E+yjPdVLPZUORq+Jr/uQgzbbt5C++16GZ/8YMXqAWNK6IwWtJlBv1qiYsNZKJj7GFAeJeGqxlaruA6N9xRG2RXDqRJQ+gL6Q/sm3UucEX+YDaWVlF+FOr/DPLd8TFCeY9z/v2x3UZmzNEamUv6w+Ne+yOuyBQcY563ZDHr4fdZ6vH+53B7ZtBPUL0+Qz3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVFRSjhsVG9BTXdpQVlzdFhUQXFCc2plMW5iZEtQcTdDWklBQWpuNURQcE5o?=
 =?utf-8?B?SExLMzZrSEFsRG4zanVTOHBnT3FKNFlYQnp6Z0pBMVZqNFQxb1lpMEFPMVcy?=
 =?utf-8?B?blFyMnNJTkYzdGVZSkd3ODY1M2ZxU2hIUVJld3liMGlCV1BvY2gyMkhoU2Zq?=
 =?utf-8?B?blQySEY3N2dlVGdPT2c2bG5vbVNVT1Y1V1poa28vVXQ1b3N6dFg1R1MwWTJF?=
 =?utf-8?B?VXh1emNnVXUyR2kzOWIwbVptVkF1Y1lNZEhTc0JZeWc3ZVUxM1lBSkRoMTkx?=
 =?utf-8?B?ZVFQVDBYNk5IYmU1cTRUUTh1dzFEdng5NFpBc3p3YlNxQ3RmMEdVMU1XYTha?=
 =?utf-8?B?ajhkb2RUV253YlNkVHFpYlpvVTN6UWZuVTE2dmlKYmRFckhmcW1EUjhVb1B4?=
 =?utf-8?B?Kyt3NEZJa3NuUnRKWjZMWlh6Y2pEdlRTZkFVRi9PdFkwcTUyWVh4cWp3SUhv?=
 =?utf-8?B?SkE5VllnNWZ1ak5kMkpVU0dzUTVLMVc2QURmdXJONTRabkJiQVFQQ0w2dEVj?=
 =?utf-8?B?ZHR0Q0xBSEVpQUdyWVVMMzlTcUV0ai9vTGJVSjR5TjJ5Qlg5QllBZDFLNTVM?=
 =?utf-8?B?TlZab1JuNEFkb2dlY1BCL210Y1dwYmxuek9zNHVlRnBKNld6bWpjRTJmQXJD?=
 =?utf-8?B?VVp5bi9NeVBZNTAxOVRpMzJhQXIyWUNiRHJTNkU5eUlOZGdBdmNDS1dhck5L?=
 =?utf-8?B?UWZXMHNiS1dRRXllSG5IMHFRTVZOOWE5R3NTU3JDZjA4bzNBTzNlTFB2aWFJ?=
 =?utf-8?B?amdzUm4xM21nZUVIWS9mRVJGSE5Uejdwc2lCRWhEekJVVnJSQXdLZkRQYXlu?=
 =?utf-8?B?SWJCTUF2bHZOY3hYZGVsazhlbCt5dFUrUHRWZUtSYTl4MUU5MWRoZWswaSta?=
 =?utf-8?B?WjBPOHhaRUpqd0syemNWbS9uSEJkMHdyQjl0S1g4N2s1dEdHQWMwT3dZbmtE?=
 =?utf-8?B?ODI1TllrNkpJV3JoNzltamw0c1pCa1FNNEVZai9EV3l6Rzc0TE9sZnVTODFm?=
 =?utf-8?B?M011UVh0TGF0V0d6b09BK2ZQVzRJYy9qdjE1VngrdzZuVlFXaVlkYnoyV0dn?=
 =?utf-8?B?TklHOHJnWUpnM09RdktlRXh1K0JZRkZIVDJ0anI0NlhGQjVoZlA4SWtLUWhs?=
 =?utf-8?B?WmpsY0tkdHhxOU5CaVFzRUtiU1FkOWYwZTFuZnB3VzhZYi9lMnlqTG1PYWdi?=
 =?utf-8?B?VFlobFRaRlhzcDBadmEvZkZvOUR4d09NOHRKNXcyblUrb0twNVZ6eUQ0NitS?=
 =?utf-8?B?SjhubERDQUF2UitGb3hIQnlPQ1krS0NMUlhIZGluZ3RIRHVFdDVneGEySE9G?=
 =?utf-8?B?UnJINmw5a21uZ3pGd2VSNHhvSzlYSlZYM1h5bHh5a1pROERydHFybjc1VkF3?=
 =?utf-8?B?UWpZRXF4dTNLMEFnNUZLeUk4Y2R5djE2VjUvVVVJcGtiMVBZTVc4am1sb0JJ?=
 =?utf-8?B?ZFNsejZEa3kwenBYZ3RMRThELzcxMVZkUjE0bVh0bjJYVWlLWUxpL21abS9o?=
 =?utf-8?B?M3hMdWZRQzNkZjRSUkNwOWRhQWgreW5WbkNuVkI5eVlRNzVMZ1h0aDNVYXU3?=
 =?utf-8?B?TGdwS2VsdlU4NE5GaU8vTTE2TzdkSHh0TUp6b3c1NGZOc3hLQWxjY2tvTGJq?=
 =?utf-8?B?Y1pZOUxadTFqbkEyaENCY3E4YUk1M1pXM245ZlpzL25KbmJEdVB5UGIxL1Np?=
 =?utf-8?B?blRvWXBGbk9oSldhKytDSGNQb2Q3amZKYlkrZG14LzB0WVlqUmJNSkRHeHlw?=
 =?utf-8?B?ZnFrcVpJeXZaT1VkaHhndTFVY1haaFNDWmVHVVpzV3NXdC9DQ2tFRnBjRmpl?=
 =?utf-8?B?OStKU2Eza0VjM0Vud3VoNHh4b2lhc3N1Q3dPa2VjVXZWTGZLalUyNVF1VjFm?=
 =?utf-8?B?c0Z3TCtOdWoyYXFVcHBzWWZqYk1YMnZuSzJZbytuVnk5NFk3OVE3bDczdGNL?=
 =?utf-8?B?cmZ5R2VNU2xQMXRhaWVrT1ZLRGY5cjluOXZ5TnJ6dU9Jd1JBV0VUSUVUc28x?=
 =?utf-8?B?M2tHUGV3R1d3OVl6V0UraGZYSXoxbFNzRTNqN3RQS0lOU0U3TFdjWStjdnB1?=
 =?utf-8?B?NEJwbkdXSzA1NThCUkQrZDh0MkxybjkxOWNtcGhOTnp4N0JySW8vUVVtZStU?=
 =?utf-8?B?SHVJZW9naEhDZ1MrVmFkT0g5Y2NTRWZaQUluTElvTG5sUDZrWkMvbEdHSlNw?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f56462-dadf-45a7-46ef-08dc58f37af3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:16:34.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+xfcowtbMVAW0XjBNGOntdUnRw+fIc47ROmzh6/YKlnGyznGF2gLuU6gZzNdO/e02EF8q5NmVYj50pgKan4duuWn/NUoUcMNH70s6L4y/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com



On 4/8/2024 7:23 PM, Daniel Golle wrote:
> Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
> via USXGMII PCS:
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
> 
> via LynxI SGMII PCS:
>  * 2500Base-X
>  * 1000Base-X
>  * Cisco SGMII (MAC side)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

