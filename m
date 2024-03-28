Return-Path: <linux-kernel+bounces-123658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D15890C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DF81C21ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F713AA4E;
	Thu, 28 Mar 2024 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJf4speq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AA6519D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660297; cv=fail; b=jo474EuHYOHZSYZr3x0kmE1q1QgbtRmjIP9a73sBO0RlbGtYodfE6DAGgpJLk6NtlnfPKYviEep+ZVoWamb9u/lmRi0uxj0h/Q/x8kbXsdTO/yN0m2nrIaoxvE7z3E84/QncLhm3xQKuLM+ff+2FuWseDiGSk9FZK5+7bPPWkNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660297; c=relaxed/simple;
	bh=KFakO6yERXUHcbJwDgf5Zq/MMLID6nUE4y/vxCMpSYM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QnQXcDPwlMc0h3UWGZoz1OY16PNSoWOf2i3Hb5I2P4Fn0QT3o0PeC+XaNt7+6bf1VpFWdFpkay4C1AfDjWeaa4YNSj7piVvej3qTxvDAJOE4/Gdm30EraVX/7dszL0lkehm87DAB4tpiEo2mjno61r6CNlGVHKR44ddvdPPZQR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJf4speq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711660295; x=1743196295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KFakO6yERXUHcbJwDgf5Zq/MMLID6nUE4y/vxCMpSYM=;
  b=WJf4speqJ86iKhXmdH/K2k61bdC1lVZMK5yeiSTWhNyAeesEh2wMRMW0
   X4MCGdWgQSSrEOP+wVo9y3LBS8g6mVPe8/eWmvm5jclePPQ+Xhlx39voI
   h7C5i5K0O/3jAWGDMlLmbjRPm6krhDWx0QSEBwm6peFY7hdsIpJ9/eRHT
   GLlhRKqXrd8oWqh3CWxcXAQhww7xei3Z1PqiOY2VDSMDcSlfok4WWlJRX
   zkeuiGdMrsV9SNkgYuViQnCL2b6zIWH+LnUhzTVEXZBqjzqHiMlWuSQnw
   G5/yb6rv0LxAC3ZOM3Jxepd/p/YzmX3XLfeZb6rXBtHqElkr5qP7P1vub
   A==;
X-CSE-ConnectionGUID: OeY3pJ9BTeaTWUvnoPy+kA==
X-CSE-MsgGUID: y6JxjUFWRDSO+igWCZ3Tvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="18225021"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="18225021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17411540"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 14:11:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 14:11:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 14:11:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 14:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiM9xL0w9sONHfVacNGu54Rflch0KUSgnE/23HwP9LpRrUzanVyJ9lp2hnbCD1GJHUHBQVh2lT8yGJUP/UQ7RNKFeAWY88+rSTnfzX+WpWJAiMapn1mD5th87U4MpQAb9hXG2xgeriVokbLymH6r4HkpATK/SCy5xeUeeMmodJXQ57Y/E3NEJ78JjZUjPg+6YrdFogLUewK92uyqcFgOuLjRohOXZJoDM9lONwnDSN+GbYFDG4fkrzWc1LI1lgXsR4hfd4bu8IbHWE6yGj3B1eLqczNnOp13r9k50K/BIe9bhJpG9IQwjC//X1S1vgbEbsFYrBYKpfRWUdZZBxOBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u95/UODq2mDl+i6dHuixIc07VnWM6bZ3KtTIS5GyZhg=;
 b=PALEVdErefMDB4Tst93i0KGhAlG9Tvl8njx9hZjLCOBPw//Uh60T5THf0ZPVIpwsASLUcPngvNN6SIkBi8l9uHRHzlA+e88e0jOY/pqxWqwnkjQRlrn0lROJmoagDBzu7Xg65kTmcV8G4nRZwyv64Qih+YYrIN/1P1sbhwi7WpzInEs6A131jx+35e3sgL8p2NAoec5uCUSqLo//OxoVNBbVXyiZHhf+9S/OV5ALdlP8XdEs+5xPD6aaRtRQTenk1N3ibFQ202dIYS5MgKtb8gEka9Jz2ouFPHOMQRPDE2VaIcI8UjioR6rtRtnmHSzO1jsUsLF2fRhx4p/cH4XP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7547.namprd11.prod.outlook.com (2603:10b6:a03:4cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 21:11:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 21:11:06 +0000
Message-ID: <e1fe68a5-d088-4e4d-bac4-bbb7793dab6d@intel.com>
Date: Thu, 28 Mar 2024 14:11:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix mbm_setup_overflow_handler() when last
 CPU goes offline
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, "Drew
 Fustini" <dfustini@baylibre.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20240327184619.236057-1-tony.luck@intel.com>
 <c53d6abd-5dbe-4edf-89c0-abbea0df1f1c@intel.com>
 <SJ1PR11MB6083F3AB8069CCDC7DB5004BFC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083F3AB8069CCDC7DB5004BFC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7547:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bh0vMAsRNNBWmmFrmu7ABW+yjnH3I1uQO+Jqf4DHhMAd52F5+gKjdtaijt63b+5ggz/L8t5n68GdAy+uuUKQICTsYiaNzwsSW7QUa1aYqev/VMR4qNxZdgH0N6u7vG9svoaT9SwsgRGdLxoHvqHxYeJr59xtgsBldm8dPZJyYYPl33agm2ukl6Vqt4IAv13rqc1uoUv/LjK5Tn6Clhq2wSer+hU4Y8F6NOeMdJF23FMjBb5FTifCnrK5A94hZx76WiXMMjp5ubBo7mJvA7UAQB4LINNRndaDniznDw2+lAp97s/fzITObRq/NPyoBQCSJR97PrmB89iASrUkUqFY8qwQTLJmRElQirVDC5eErsiRkc6HQQi/PPHAAUGwZ5mTrOcQi0aEqZhjbDrYdFyHMjIXmqCfvHZGrR1ksehEKOO+vpESOpk/U9H/M+v9bmFmHIFrplPdO0JsWrBTFgybfv6GtxqI/miDPk4/phHKHetzMZ7Q8exBQv6dDPQDpxVIJ4gJF5juDVqnqQsaMUvH3kDd7CeB6zMxurzNak4kXGUo2vRrxrQcBvYpYZqW7ZmABxS4AnWbYUDPL7WvAWmnF9Vw8m6YeEy7LM64DRvKa/RnFuK4+x2yLL9unYxKobpkboTa8aSVS652533Uno6yaI9ZESC/DFjP1XkoWLLcmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFoc3Q2em9xWEhRV0Rnck1HcTJyS1BuMUFpQmxGVkVxMllwaVhJYWlqdloy?=
 =?utf-8?B?c3JEZVRyUVpHL3o5RGNRcllqYWQ1Ti9HdnduUlNjMXF1dEkyRFFmWktEbXd5?=
 =?utf-8?B?R1hRRkViQkRXNlBQQ3RNL1pYSHphMUVQV3BTMHVxTU9qdmw1R3p2QkhxU0Q1?=
 =?utf-8?B?VFF1eVhxMWV5WWNqYmhOdU51Njd1cGJmbWZPb21oTnF0QVc1SzE1Nzc4VGli?=
 =?utf-8?B?WWorKzlsWUY4cHhSS1FoczZJMHYwRklMbnhKbkswN2pCaHBYTjNJZnNad2xi?=
 =?utf-8?B?WmFXK2Z0ZElsdWQrMHJDemFLZUdJMWdGeXpxemRiV2QyRHlvaGxoTWZENGVx?=
 =?utf-8?B?cFdDemtoU1JtRis0WFkyYVIrdDdQY1pFQU9kazA1b0Z0dllvdThrVTgxK0N4?=
 =?utf-8?B?enI2SjR3WExBNXJGTnlGbHJNLzNUZlVLaHpNK0lFRzA4aHBJNDFFejR2WTdE?=
 =?utf-8?B?MkdLK2g4N0ZmRXo3Y2YvaHBXMUJhQnorZDFtOGpjUW5TZ1RpQXM3TmhpM3FM?=
 =?utf-8?B?THM0YTZqdEgwdzc0OEw3R2dpaWRrcHcyVGg2UGp5OHU2cm41b0ZnZEFNQ1dM?=
 =?utf-8?B?RjZUUitqKytGZlF2Nk5PZnZoU3VWNGtmeVBIZ1BvYXlINGc1TVlFMklPdGgz?=
 =?utf-8?B?eWd2bmV5ZnYrZGloeWdmTFhIVGIxZG45Q0U0a1BLVVpFN3o0ZXFpWmZrNjlJ?=
 =?utf-8?B?Z2JZck0wT2VObzJ0QllORXpDTkJBSmJ3YjFicGlCdHRheTVXUG1wZXJRZSs4?=
 =?utf-8?B?MGtYckQwRkUrdDJvb3ZpTXBVT0xHN1NTSlhpNjFPUFdrVzZuMFpHM1g4dUJ4?=
 =?utf-8?B?Rnh1RUIzWm9lSUlHMllPOVBTdk5VWkJkS3puQUZ3Y3FibUtvdXloTTFSR243?=
 =?utf-8?B?WmpGbG9BZG9lVkNWbHRKNGN4YXJ5Z0k1YlBkcU5MckNOM1ZrNG1BVDkxcVF0?=
 =?utf-8?B?QW1KZXRzZ0N4YlhaVzVyMEdFZFZEem93Q0hzM3NsVUdkVGFmOWRLV1htdXVo?=
 =?utf-8?B?OTBQRkdjM2dHaEpyQUhPS0diV1ViYS9tMUY1Y0EyZzBLdW1ySTJkV2VrZEs4?=
 =?utf-8?B?Qkp6TlVjakRFNHowckYyL2EzMklUK243bCsvNllBaGJTMmtjRXdhTDZOUEhM?=
 =?utf-8?B?cVNKK1BmYkl3eE1iV1F1WE9rdTZGMURQUWJrU1lINFdWakM0MG43OU1rR2Y0?=
 =?utf-8?B?VEEzZFE3R3orYS9yVVc2dHhhRmMxZEp5UnpOYzAzUUREVWxxMG5HZTZUZURl?=
 =?utf-8?B?Snpla1QzVnVkWi9RQmcxMXErdlN2ME9OSzcyeUhDSEh6QVhHTDVXQUp0Q1ZE?=
 =?utf-8?B?RW96OXE3Y1VpSldZSXJOVXlsUzZYbjFzdFkwR3FmRjY3dlJxOUQ3YlBhWWJo?=
 =?utf-8?B?THJVeFNoT2NJK01ZMC9VaG9aajBYNzgzOUFLL2FNTGZjNWpkMytQZFFUVTBO?=
 =?utf-8?B?QXRYV3hVdlYxRmVwT1NGbDYrY2RFVkcwenBvNnNMUlh2Q3RsN1oweGRYL1pU?=
 =?utf-8?B?RjJlUGZjQzc0TzVocFFDQ2FxWEN1dis1YnFwR3NEbU5uWThBaHdWTTVPcmRh?=
 =?utf-8?B?Ump6TmZ4UENLYjZOZXNQcm1kT1NvMnZzMWY5NHRROW96TWhhcHhLR2ppN3R3?=
 =?utf-8?B?YnJwTGVrOXJPZzZwZGlycFhEL1JJMWdQb1hWK3Q1eGdjeG85NkIzYmxpaC9n?=
 =?utf-8?B?Zld0bGlCTzFwZmh6RFBZckw4ZEc1ejJrQWFHSFhDY1plamlOK0hYdWYrSkdh?=
 =?utf-8?B?NlE1M01YUWtLVlNSbGJ6Y1hUenNQVFRSdWh1UVhHUkNOVEZjMWNvcVV1QXJV?=
 =?utf-8?B?SmM1S2h3aTBGc25JbUhWMHJDcXpJYnl2REJ4UDdOMUZ6UkJZNXhkSmxVeWRM?=
 =?utf-8?B?cnJ3dCt0eXQ5eCtuK09TTjNlMkJFYW9IUUFLZjVPNHZQNkY0cnI1WTl4ci94?=
 =?utf-8?B?aVMrTTNNbXRvb1U5SHJyNWxlcVpqMU9aRUU3T2taV0R5SklwQWhzK1dIKzIz?=
 =?utf-8?B?aVBQUGhjSTI1c1JyRml4RFQ5MDlzbUF4ck43SkpyWDBUZGU3WmRrMHNBbUpn?=
 =?utf-8?B?NEo3MDZFYWpNV2lWcVJkaFZKajhUVVF0c3d0TmZ4d25FZlRrdGd1NFpHREI2?=
 =?utf-8?B?WUZUdHJjTEhlRUhKYmo3SldGbU1oeXN1RmV4dEtYOXpxRUozcjJEZjBaZUU0?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ace8876-834c-43bf-5974-08dc4f6b9542
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 21:11:06.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiqhX3copYN4N6GMC+m0DdUWOGs4zWfhFYXxCdJ2yZcjUFkJ2ucKFoEjuO2IdmZrlO90MyUhC0SA6bun5Vp6fWGMS9k9J5pY7Kp4IaM0Yuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7547
X-OriginatorOrg: intel.com

Hi Tony,

On 3/27/2024 4:01 PM, Luck, Tony wrote:
>> There seems to be two issues here (although I am not familiar with these flows). First,
>> it seems that tick_nohz_full_mask is not actually allocated unless the user boots
>> with a "nohz_full=". This means that any attempt to access bits within tick_nohz_full_mask
>> will cause this OOPS. If that is allocated then the second issue seems that the  
>> buried __ffs() call requires that it not be called with 0 and this checking is not done.
>>
>> To me it seems most appropriate to fix this at the central place to ensure all scenarios
>> are handled instead of scattering checks.
> 
> Good analysis.
> 
>> To that end, what do you think of something like below? It uses tick_nohz_full_enabled() check
>> to ensure that tick_nohz_full_mask is actually allocated while the other changes aim to
>> avoid __ffs() on 0.

I studied the flows some more and I no longer believe that there is a risk of __ffs() being
called on 0. Looking at the flows starting with cpumask_nth_andnot() the value provided to
__ffs() is ensured to be non-zero via either an explicit check or hweight_long().

To confirm this I tested a CONFIG_NO_HZ_FULL kernel by booting with "nohz_full=" set to the
highest numbered CPU in the domain. When all the CPUs are offlined the behavior for the
"second to last" and "last" CPU are most interesting and worked as expected when using 
cpumask_nth_andnot(). 

> 
> Looks good.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tont Luck <tony.luck@intel.com>

Considering the motivation above I will submit a change that only adds the 
tick_nohz_full_enabled() check. Since it is such a big change from the snippet you reviewed
and tested here I dropped your tags from it and hope you can reconsider the fix after considering
the information above.

Reinette

