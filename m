Return-Path: <linux-kernel+bounces-135645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F24589C92F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F5D28137D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D51422AB;
	Mon,  8 Apr 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELDuqW/i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4FC22091;
	Mon,  8 Apr 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591941; cv=fail; b=DkHjrAmy8a2CkWpBD4YDF+i05llTOmjej7zyqWqresNYPi9J/Fs/eb7aMpU1kUqzmGojztFFQ98/1eFOs61ZsIw65aXMrU/kEaaUlcZyJt60d4niIAYRuwjHOcGS8cIsFxSRe+uLYwA/6SP41K5QmMGQQocdvRbU9zxXOtJevPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591941; c=relaxed/simple;
	bh=AdDvDQ90hLXddvSCcdP4mdLKel0ZkYels21VD9Ib7ME=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VyDinn/PGe72QoxSbuiEJlMhODxO+IBS1uoaq6R5AKWiAbyMAgGFOqR51piH5gnj9czP+aS6PYGg/SSRrIAeCbgL3tcV2ftZoNbLLUS23qeWQ+LZYTM3chrfUb0/zToYHCpTwE1BA8065iI1kGbWupU3av8mtnJoSnIA4jKn5qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELDuqW/i; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712591940; x=1744127940;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AdDvDQ90hLXddvSCcdP4mdLKel0ZkYels21VD9Ib7ME=;
  b=ELDuqW/iGHU91Te/8FOZ2wKb7osUuEkZzkP+0ynnaCjBqrKdg5X/U1J7
   S8ryo2jAiOjpLenM9tlU8FxS0tFDQtq3Xx4ElFhNqqDc+6imqsTfhYGmw
   XT/zozM36Ez7jJbyP1fS+qbhEsIDooCLyjQVl/4I7s20ZyjhAkozTaHlg
   5/Gm2FknqKHazkli+vl0xe7VuxGFWmFpDyiXFb+YhmawDrlvjvxHQrLEb
   0Laiu9m31IlQdXl+Pkr2D3aiteIEpHifQzs7iYqMqioyoY2KvlA38RpM6
   kKd25JGEycJSsD08+4mT8a/sMwlVkb+HRuR1iGKTbJHw+LSjINeMajkI1
   w==;
X-CSE-ConnectionGUID: i6LqTWF7RGK1khcqHiW1Xg==
X-CSE-MsgGUID: EFSrgeDxRSm2cnH+aGJo6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18595957"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18595957"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:58:58 -0700
X-CSE-ConnectionGUID: V060kMILTBC3G4rE2TpksA==
X-CSE-MsgGUID: fH4bfS8STLK39MBPPsrGRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19796941"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 08:58:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 08:58:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 08:58:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 08:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAstdEmXLY7LIELEK9ug+isTKytNRIhv4+5xGpz4v6N+PoNjPKggiIN9/Jr2lwyrjEvfCe59O/BNs7k1zTzm13RsmmO/nVKTnBw02m45s2DsdHHetNUVP1RGbVOyIfpsmhlK32DifXiS6SpAhK7VkGb00RzA/9VLU2nzrDcctAZCWmGxVN5x7cNltNYrhthcH4ptxDHRxeyuMGxiqV6PZiTIuVFQx2o3PWiQpDVzYesMtNVoWr5B7+8G2BXuXDVNg+BwXfGkt3+sJMM3OTb1nQowRK+tcZnxQ35X3IyVD8pz1ClU77AXnN09vib8Qd/cAEF2gHSrmuM0rsCNbkyb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4s9tyG730Mh8iRzsPAJpH69/1aLF9thLvaACKySETU=;
 b=AIqWUKWGxbpnYFSIM07XeUprGT34FizthGQdxcxJQEaYOypAumsk1Ruqic41Fq4j8uMRbbi53cdKjEisw9A2bq4iFwVvPhucoFOA7rUHPe/XmY+hFr8+jeGZEPRuhFz2dIPVDxUUo4QAUemB9pu6jSjzBRY+Jc0B++h5pFu5fxuvsunaEs5pZW9w8xFRIesEjstSyn9UE7/XZlTYK8Gz1gVUQt+rayQ0/Ma5WfTzRm/bzKFGe+a+5MspHntexJb6vkwj4korpgn0YFm6bhaEy/kv8pp2ni3BG1IF6PqV3WWNoIIVp1oNGTPME+qpl7xjseA8Sy9CRKukI2BR/CVVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 15:58:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 15:58:53 +0000
Message-ID: <b51dd1db-12a7-4618-a660-85f70c7ccd5d@intel.com>
Date: Mon, 8 Apr 2024 08:58:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo
 list
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Haifeng Xu
	<haifeng.xu@shopee.com>
CC: <james.morse@arm.com>, <fenghua.yu@intel.com>, <babu.moger@amd.com>,
	<bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <peternewman@google.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
References: <20240319083039.223088-1-haifeng.xu@shopee.com>
 <4244b729-2eec-4999-9427-00b5c9f3e6fc@intel.com>
 <ca45f32d-b526-4bcd-b177-08698babaf3d@shopee.com>
 <20240408-stalwart-tomato-sloth-bddbae@lemur>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240408-stalwart-tomato-sloth-bddbae@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6446:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2e4skvH8ksTrHwtzIuivslQFaBZkGC+TqSjRuiVgixvDalOyUDyV16VX9rwBixmaB1uMiRu8J9zpPSTlksyDabiBqn4VRK2N6yPa7t6zThc3wjdljVnq5XKPmQXH7EeSfnjKGZrLTuBKkGj3tgzaPZL6PKMNgsraThW768scQh2hZtG0bZpAwp5GW6GqG71GY92cnIkWrkjBNMlgcUbSU8M80KZlW0p6zEYddZJIJXPPYqSyv5JCRBECJfYNzRqPv8zf0WTDHnuzUijixIakxu9aEiUMo5OxaOFZhZVrr3/zffn8FYARIBpP1Z14yA82l7gla3xCBDrzt2g4xfTSBjKKuhfnpBbqWPg49G8y38DIET9V0jGh5LRRI+iRohMCrmfyb93dyLIEkz+SMphH00AIr0d2jwnDcTKPv3oawxpg5NMVVlK5ZI1roAhz9A7OMUQieiXpi6HQsuk3EjTm7sefCUOukldocfqQ0UAxsdXsJ9LQUGODzuVgiZa0+EMnXRr3mbY7owCe3R1fQwpRX9ToAkF2kXSQMHiG9GGQhqeBouSJPzrMojv7sJR39bSmN6Xs7goH9y/uY1aDEW2egwwgJfS9GXOzetqrTCMZGj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXp0eUx6VFlqUmxBMGFTcjJDdGRvb0p4SjY0SXpWOVpnMXc0Znkxa2tmYWpy?=
 =?utf-8?B?cmFzNzR3R1c4ZGRtWUlTS2ZPei80b3RBQ2w5YnhRL2xMTU9vRGhoSkk4LzQz?=
 =?utf-8?B?aGZ2bFBoSWNUYllUOHFjVlJyOFZ2TWxzWk1LVno2d2lvYXFLbDlTS2FnQUxm?=
 =?utf-8?B?MXNjRWtuVFoyaUtleG1RYmRJV1FuWWpjN2VZUm9iR3hBZlR4REV0ZWU1S2M5?=
 =?utf-8?B?ZWVvZStvYkp0Yk9heFc4NVpLa0NQYTVyay82anQ2L3JjSGdMaHVvSmNieXdm?=
 =?utf-8?B?MHhTS2pKeGIwSWtFVFVzRE9QV2YzOHZZbTlQeHBxeWdyc3RtQU8rcys1eVAz?=
 =?utf-8?B?dGJ1QlRmRkovVFF4Si9XOTJCTlNyb2hBYitNUy9RYzJqNElpREVIeVBtQnpD?=
 =?utf-8?B?dUpSZXRJckFrWHdSYVFhRG5SZ0xlTWYyZkJibVJ5Uk52L3ZZc0lwVmxXcXdR?=
 =?utf-8?B?cm5FNlZUNkNlK01oNG5iRW1QWE12cWZuNVpKT0crNUs0dWxrZWJyY3NQMDVG?=
 =?utf-8?B?WFBzRnpSei8yV2NQUHZKTWtTNE4vUWoxck80ci9ydGRKdjBGbGVoL3lBajhi?=
 =?utf-8?B?R1IxVUpDK2dFYW94Wi91M3hkYmlCdVJIQTAyM1Foc3dzZkd5U2xraXJYU1dG?=
 =?utf-8?B?ZTYvd2hvNjVIa1BzZSsvV2hlMzhjcTFDTjJmNDIxL1ltM3VNRFN0dGh1Wlp5?=
 =?utf-8?B?K3lYQkU1ckE4OGVOOWw0cDJDRXhVVjVkM1NhNW9ya3RFNFNTL29LN1lXMDVm?=
 =?utf-8?B?VUZaVDVLd21jS0R5WXFNQjEwcE53eEdQVU1TWnk2NzMzYnRrcWs0Ykh4Vk5F?=
 =?utf-8?B?TUpvN1d3WlJ5N0VZTERWV010NjJCVStROTI2bFpHS1I1TFE3Q2g2d21KcEVu?=
 =?utf-8?B?ZmhyeUk4cldEdDVtVXAySHAvK3RRdkhXTDQ5dWRxZnJSeGh1YnMyd2tyMkVt?=
 =?utf-8?B?dWVjSGFnM3ZjZ0ZrU00xb0R2MnpHOWRsSUR0S0J6QlZnblJyZEJ6SHN4RWtD?=
 =?utf-8?B?MTNPWVlwT0dXSEVYVklnbldUTGZVRk54VElydkU3c0FqQ1J0SS9wd2ZLQ0xn?=
 =?utf-8?B?WjFIM1FNb3BrOURyNzkwaW14ZWllWnlKaC9qTUNsM2xpd0FIMXBjSFp1S0tL?=
 =?utf-8?B?MTJSYnVxWUhweUlCME1CRDFZQk1qczVXM0tsaTFHT1VGa3A5cEc0UGRQMk9a?=
 =?utf-8?B?UHZIYVA0eldTWjNLRWIwQkkzVmV4WUVtbnZBY3YrMytwRHMxQWV2Um82VTRZ?=
 =?utf-8?B?bGYyNENrZUdRdm9yMUJIbU15UGhtZEJXV0RhUHRBTEJEY0pQcWpZMWRpQkZu?=
 =?utf-8?B?ZmZUTEFPS3FDTE5GN21JdXk3Y2VxVzBrRGNRUzRGOG9mLzYrZjZhSjZ1N25p?=
 =?utf-8?B?M2t1bmIvbDJNeEJPZlN4QkRNSERnUmpjbWkxNzRXdnZmTUpxdk1TckxTYWdp?=
 =?utf-8?B?Y1g2WTNCUnRRWCtZSHNPa0Fmd2Y5emgyYTFXNDgwZTEwMExXZDhMTkl6K29y?=
 =?utf-8?B?L09mL1M0L1FMUkRTVk1HSUxuZktlS1hvUTA5Y0RUWlZoSWw1azhTQkc5L0JY?=
 =?utf-8?B?MU5kTU14S2ptcFdzTXVNZUtIR1lKdjNDbzlFK2UvaWR4NnlJL3g0Q2M0YURF?=
 =?utf-8?B?WnVJbnJKaTkyY2diQ3pBR2VOajVDNk9wcXF0ZUFsVXhTYUxHUFlsSm1zTits?=
 =?utf-8?B?UW0zMFpJU1Y3cStmMENtVlpRaHpIeFdUVkRFcmdjTlAzVDBFQXZPT2pCeWtD?=
 =?utf-8?B?UVVDSk5lS1QrVm50TGFSUWNZTlVIWElldDR4R2U1WHUwMU45MWpacXk3TDZo?=
 =?utf-8?B?NTZUNlpkZ2EzVjA4NElIbG1hMGJuY0syWFdSZkphejcvN1RMQWtCWk96R3Bu?=
 =?utf-8?B?NDdYS2JGYXdZcjdXd2VWRFZyb01jVENDVDlmU2dYaWc0bXIydEVVNTYrTisy?=
 =?utf-8?B?bzFmejI3SERuS2p1dHEyUTdiRStnQytLU2pyMGg1RUJ6OVRBa2Jrd1k2aHpj?=
 =?utf-8?B?WWNNb3JJMVZJUWhHK1g2cWJPWC9UbkhQZjFoM2FNOEZUTURnb09iVlYyYm0r?=
 =?utf-8?B?MmV4L3FSL3JiUjF2YVprTGZsRUZMcVZZZVYyOUYwNVBlVWFjY21oV05GUGVU?=
 =?utf-8?B?cTdycHV2TndkVmpZNGhVTjhVaWxjR2JValI1UE83UWQ3TkYzNVEySlNNYzBo?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88015e80-6b23-4920-574f-08dc57e4c9ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 15:58:52.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRrf5yGyKdbDLNGckgwlzJQbYE2rYq9l6//yf4AJINlQIhglrp5TiR78wE+tntYEOuK3o5uKIt5XM/52cmnqPWA5RVBwB+U+J3eyg348xUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com



On 4/8/2024 8:29 AM, Konstantin Ryabitsev wrote:
> On Mon, Apr 08, 2024 at 03:44:00PM +0800, Haifeng Xu wrote:
>> I can also reproduced it. After digging into it, I found that our DKIM signature header
>> has 't' and 'x' flags. They are recommended as a means to help identify spam.
>>
>> t= is the DKIM signature timestamp.
>> x= is the DKIM signature expiration time.
>>
>> The source code of DKIM Validation can be seen in dkim/__init__.py(line 351), I paste it
>> here.
>>
>>  343     if b'x' in sig:
>>  344         if re.match(br"\d+$", sig[b'x']) is None:
>>  345             raise ValidationError(
>>  346               "x= value is not a decimal integer (%s)" % sig[b'x'])
>>  347         x_sign = int(sig[b'x'])
>>  348         now = int(time.time())
>>  349         slop = 36000 # 10H leeway for mailers with inaccurate clocks
>>  350         if x_sign < now - slop:
>>  351             raise ValidationError(
>>  352                 "x= value is past (%s)" % sig[b'x'])
>>  353             if x_sign < t_sign:
>>  354                 raise ValidationError(
>>  355                     "x= value is less than t= value (x=%s t=%s)" %
>>  356                     (sig[b'x'], sig[b't']))
>>
>> The expiry time is less than the time point you download the patch, so the validation
>> fails. If I comment out these lines, this series can be successfully downloaded.
> 
> FWIW, I've requested ability to ignore the x= flag when validating signatures:
> https://bugs.launchpad.net/dkimpy/+bug/2047054

Thank you very much Haifeng and Konstantin.

Reinette

