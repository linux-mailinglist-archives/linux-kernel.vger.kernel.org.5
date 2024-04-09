Return-Path: <linux-kernel+bounces-136186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D389D0EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3393C1C24657
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57A54907;
	Tue,  9 Apr 2024 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhTAMVqN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA0548E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632640; cv=fail; b=D21N1Wj1n9bhxCsU3iJ/rZIEUHsZyz2iCuUoJvTiQffGKJuBZ2QzbEEyB2kd1lldKtyv4YeAjr8V1B4qL3kfWM+auVbTBXTjQ3rF4DAxsRqa+IJ7cJtk6EqgfkD6orDL5b2/eMlGrLgz9DLbw1a5brQcM3V3CP+uzQKSyq/0UHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632640; c=relaxed/simple;
	bh=k2MJONXcFYJ5jl/3+k3vucDxhIkWzyCf8xVK73NwCbY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHTgR4YIIoOxn+oGKnVG3YxeMiJ8WVTfzpM9/o6/3g+LwYBbXMbmCGXGCQou7yyeqb0qHkYelNPpNkCpdw/xAazaoqmDPj+sNP/F4QjwZtWziITmodwQARiSOJH0BJgEKab75JjlvHy4qMeVa+qYaeNSdW6pVZi6gAw1A9GWlTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhTAMVqN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632639; x=1744168639;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k2MJONXcFYJ5jl/3+k3vucDxhIkWzyCf8xVK73NwCbY=;
  b=nhTAMVqNozGjTQFOXP4B3daFqG8QLCDZz/lG3JOruRzrSNrzy2omQzQk
   ak131p6xHETVGEhMj68SrcmxTO5zUT9pW3woyPuluIrr3ZEn7kjLmYED7
   7jEoABr63bC8jEYGp60af32DzwxWHFnXrcpBjo/lH66EMkQzy0C6Qr3W7
   0S2RyVHY4EZpH0seRCFvwnnBBZ2kXXeSDHjD52HLfjx04MEjpyPfdr6BL
   ooRuVn8ZMZKX05cxTNH7dKRKTbzZOYnt223hfhdRrQRhrEFFmHP4zoSxL
   YKQOLg8sjhY1K3a58noiwvyV4ipVUsANwOiGDd6TUcAhvVL/oXy17AOcJ
   g==;
X-CSE-ConnectionGUID: grBiZGBaSX+OTERhqOi6rQ==
X-CSE-MsgGUID: d56orDw7S12m/4pgpKOYBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25435680"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25435680"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:17:18 -0700
X-CSE-ConnectionGUID: jJz1TIVpRuGnYOwD4hlTag==
X-CSE-MsgGUID: 2u6OtPrURvWSVjZj6ize7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24575697"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:17:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:17:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:17:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:17:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd9lUm3mE1guTsa44yaked/Gm+A7xfYHlFBmFXyznRfaIW/psY74G9LHRarPwsLaJx0U24lqaUABdq3qq7UFbDDoeepfojphNo8AlMrRYaC6jhtRHPBvG+xigJdaQ0GuWg2MG9XRjDYByS4ULIxMFD/Hi0XPeERXoqKtLRzIXAt3M1j525sGN6Adzr8egM7RmjrNjsxelsuuLcZ+8w4w4wlFTzivae9hKCVnd6+gtU4IHUP0DjSVU8Nit3ZFrNft1P/0+Y6z95s2LEk0mzhVyypZVJnuIHv0wDs5bY5IxldLc+YuRk6m53SsI8/VY3RQ1/mVGez2xGPGEIdD9it49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJpjVzIXsZOJvbBCRLC7yfj5zA75Pbo1eaJZf4+vvmg=;
 b=CO5F4FM85/ttc+8b74+VTURg/XzlpeC/G+x7qgbyU7rhTcpnJ6wdXRAouGgUnmE+m4bQtawxcusuW2t/m5ATuVKtcD6uFPXWpddoMj4KeF+0ri6dVxHmrpzARLgzuA8VPHfDQjxBwDwRpf+z5jlrrqIGkGBlSg5eHtTuk61KNL2qIRGDz0oNdWK4fEstMvzaMgIkFz9761YSPhwy4NKfpDeIk1fqkbrCZwqwjwvgQc/f/cmmzw4F0OoSJXcwtGA149b3vYFjAFHsXvwxf4ycWD18pz4wK5+DPfueKBnolEkZ5LLnf7yXHy8XOIELOiswDmpFJpvPXppw4t66BC+GhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:17:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:17:15 +0000
Message-ID: <f0243dbb-f333-4c06-a315-ceaca8fa0bc2@intel.com>
Date: Mon, 8 Apr 2024 20:17:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/31] x86/resctrl: Wrap resctrl_arch_find_domain()
 around rdt_find_domain()
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-8-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TmzeJYYxFh85eDwPSuByrp3HGsQLN/mTu6JP6TLD8cm4d8B+sqzIUOSrMoGa5qdObhsXPDYt4jO6gVhRCRSHsIexREA7aVVY9+2grsActI76IiIVnn5TgG5HSVJwwvvlud15REvKsAWhdW8Bslm0uShLiYqW3GlWGRSLRR5H0lNLpDc8C5fRuLEUPmeljl2NvEQuxi8qK1424ZxdxyX4811kPGxN4uQanQHS0/lF3r6W30c+ttopttF7zRRpEkCqndfzv5pcvyHdToSZ+q5YOE7BnmlViSJpDoqR8w2QDOjd1QvR7McYsjnXkeunW5XvrTs4ZQ/5W0th5t4q0SGX7wXPy4ZdhjLLB3xqksztWiJIni2su7iUhGfrNZkv3VVRarGpWxKLU1JkQcuDsFDUkrJefO4ER031c4SEB9F/G0GeTp1lqK36GB47IddYlWIdqcD79sP/Kw+GsPkc47g4z8bErsushW8vU9vpiPRAvlekOCAAeL0XaX1uA4NE+JMtTM+TIjCqoUK5NOF6EyRbUopD5Z2XG65YBq59CjhELiujKAJRP2zUh1GBKna2GaSs8IDWZdffwri8jjPpFsXOlu+v8PZh5+ztqJHhRhiFyLPOw0U4DeKj3aFdexiBoerk1YvTkVq00+sZeBLlcLpCHeugL3A+9AJYDVpJbBNxbxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWY0Z3gzQytIS3NGWEEwWTJHM1pLNDdMQ0JKdDNGaEZPQk5CMEYzNFZoamZU?=
 =?utf-8?B?bjVZSThicXl1c0lvbUk0dDQ2TGVBeGV2TFlIZXVBNTNDTmZDSTFJWHlaVXVy?=
 =?utf-8?B?QVpacUplR0lSbC9td3hOV0F1VWQzLzlmVllXVEd1Q0NwQUtWd1REYkM1WlV6?=
 =?utf-8?B?QXZrVnhpQmx3L1psUnI0dmNnUmpCUW10RG9hRmErK2trNEUrNDNlOVRlMmlK?=
 =?utf-8?B?Y2tucFFabUtyZ21zc2U5a3ZWUXJXbjZxTlVwd0NsbXRFOE1SNTBTbXNkdm1n?=
 =?utf-8?B?N1ZnVEEzS0twcEo0V3VKL0NLWWZNSDdQN1JUWFhIejJDQ1FaQjQ1dytNR1hM?=
 =?utf-8?B?N0hMa1ZCOXQ2YmVTU2lhMWFzRmNtTnI3a09ZZmZwQUljd05qaC9DZmVQOWtv?=
 =?utf-8?B?Q0cwSDJrWmNZRTVQajVLZG1xL2VoYXpaMFpVYjRBM1hNSENORnQ1bENsZmxS?=
 =?utf-8?B?YmNtTE9OUmNjR3BkYlYvVk1SMHliSVJ5Q01FZXUvQVdCczZmSkhVcm50cDAy?=
 =?utf-8?B?bk9lSzFMbFQyZG1uVVQvbjdOQU84Z0J5T3p3LytzUjRnc3dZcjNZTkpUVVc1?=
 =?utf-8?B?eEd1WHlPYTkrVDhDQmwxM1hhOWJEdjV3eE9HU2RkQjJBcHk4Yk1xdkJ5Q0lm?=
 =?utf-8?B?NU85ZTBjN1g1aHk2NG9DWlhxZm00TGJoa0h2Q0VuQ2I2RUZyUS8xWE1YdHVy?=
 =?utf-8?B?SXI4ZGVKL2ZNaDlaRE5sN2JlcGxhWjNycDVsU0d3UFEyTFZaMzl6blF3YlF1?=
 =?utf-8?B?a3hUaEYzemNUZExvK3pBQUF2d21xQmxrb3dNR3RibHd4cCszMmpTU2RXS2VU?=
 =?utf-8?B?NzA0anpEL1ZHYjFzNjBHWjFGb2pUUitsdGtEdmpTR0ZlaFdDT3hYRnR6czVM?=
 =?utf-8?B?bExraXpEVFhjaGJoR3JmclpsOTBCL05NK2JtZ1pIaEJEM3NmdWdGM2F2eE4z?=
 =?utf-8?B?ZnNmZ2J5a1AxdXNHQjdJNHk3c3dqMWVHa1QxQzQyckQzek5WcmYzcWx0eVVy?=
 =?utf-8?B?dGJEejJOb0lVTUJLVzBWL3ROalIyNjVjT0ZjWHdqaTE0UjFmNUgrNFQyWmFO?=
 =?utf-8?B?Uzg0YjJCOGsvUzYwdlJxajVyRHRlREtqNHBvcVozZUl2MHlQTzZ2dk1zZHp5?=
 =?utf-8?B?eUduT2VURGdUSTVXNjRvM21wV1ltakV0UWVtV2R5Y0Y3cXRRaUpRNFdZaUpo?=
 =?utf-8?B?ci9ha2VqZC9OeFFka1hncGxkc3ZnNE93OUxkNUpNeFhRNU1UWWhLR1pXWHpE?=
 =?utf-8?B?Y1VWRDhBbkg2cTBVREtNaDNjSUJ5bm5wOWV4RXBFS0RMS2RJSldNck5ZYVgw?=
 =?utf-8?B?WnBBc29kbTFuREVLS0tNR1lkU0NPLys4Y1Z3dW1oQ2tKanVYSllkWDgydklV?=
 =?utf-8?B?eGMrb2F2a3NNVk43QXhBVUhYTWpxdjMxVW1OZXVnZnhhNWhpMzFrS0lIM0hM?=
 =?utf-8?B?bjVUd2d2MUxIYlBwMW1od2lucldtTkFvd1pBdk5DWnlIVlBiWFZIYmRRcS85?=
 =?utf-8?B?cUxXamNEM1dVVHFNRW1FTldQWHM4Z1FrVzhSVWliQjdGYi9OR1dZUXRGejBF?=
 =?utf-8?B?VXo3cW1RTjRMYVJTOEtsb2t3QVNDU3J5RXdobkxzcXFsMG1jQ3N3UTFVRlJz?=
 =?utf-8?B?b0paRVlVcDZlTExQU3NnbXUzdERCR1RyZ2ttM21FdFM4QUJqNmNJaFp1ZWRr?=
 =?utf-8?B?c0c5dlpmancrU3BTWDJFSlBpQnNvYk55WHEyWFFHeDFPUmRlUFVzT2JFdFFa?=
 =?utf-8?B?VjRQeFpOamVMTG1rVGllUjBid3lLYzlMSUdyS3Urb0t5WXpLRThZcCtJc0pS?=
 =?utf-8?B?NzU3Tk5qb1hLTHByN1lZNUdubzBKMk9mWlBlZk9jUm0wVjlwVWIzQm5GYS92?=
 =?utf-8?B?WVZBYkdiS3VNK2VYZjF0d0NPOG9rYjdVN3R0aDZoY1hUMFhFYmZUekpIMnZX?=
 =?utf-8?B?b2NmVHowOXNENFkwaEgweTEvUmJvU0YzSXd3bVFGQWJHV2pyYkNzN0dld0Ju?=
 =?utf-8?B?aGR6WTlEaTJMVVhEWmQwRlRSOVFWb2lCM1UvdllmeS8wc3pLNUlwOW9CZlpp?=
 =?utf-8?B?U3hZSmVPbkZETCtLTUZsdUdIMFVNVDljY1VCbXlreS9JVWN6U0dwTFR3dDk4?=
 =?utf-8?B?aWNKMjN2MnFabDZ3SGg4WWx2NzZnN2J0S28rMFNady80a0VkMlg4Q0pkUjZO?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 783bac84-a6c9-4171-a357-08dc58438e08
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:17:14.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrWwj/+b2G3YWQmjWaytjAHaNrfhiNB6G0xH/itZ5/pgJIjq4+ZCyuwHzPymGYwOXHO9aECuMC3zhhFdJSLg7vzrD3d1dFUQkBlXOLKrPtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> rdt_find_domain() finds a domain given a resource and a cache-id.
> It's not quite right for the resctrl arch API as it also returns the
> position to insert a new domain, which is needed when bringing a
> domain online in the arch code.
> 
> Wrap rdt_find_domain() in a another function resctrl_arch_find_domain()

"in a another" -> "in another"

> so we avoid the unnecessary argument outside the arch code.

Please do not impersonate code.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reinette

