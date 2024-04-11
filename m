Return-Path: <linux-kernel+bounces-141410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875B88A1EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6DAB29B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45B82862;
	Thu, 11 Apr 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTG3q0St"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AB81ABF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856966; cv=fail; b=Qkt6edrvsuj2M+U45aMDekO9EQuRP+YVbJHggIIwBNHlz85MU4ork75zfcgh097SPSfaWgRmZ7YUYI1y4YmS3SBwHjO7c1CgZgg5zn+A12GpTAP+noxE+y7gk5nIctBqG4UyYba/js++ahxrNucnyaEsbNhnaaHqYsLpyeX11j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856966; c=relaxed/simple;
	bh=mU3841BWP66gkDoPo0wq4oo1Ri/1p21jdW2g/by0390=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3Xks9cgD+ogSzNPo0Z1Otj4ymcXv11eeUOavdue8QNaxoTI/IF8IHNT1C/mRMcKFy0GdtK2/HU5YKk2+Rucfls0uoB7WqJ07Gpn2X+cq9FBrhD0iF/PAjKRbOSBftQy7rTDdbT7hemq76IUUX1XKXQQp6BdzJwTWLG0wOK7Lhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTG3q0St; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856965; x=1744392965;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mU3841BWP66gkDoPo0wq4oo1Ri/1p21jdW2g/by0390=;
  b=jTG3q0Stf0X42jTjf8Bl4xCD+Ik7AvgtY1KE0kS/mH5kBl+rVZY49qTR
   EPylOaHoQ6dgUHxNnRw4ENf6+pJow2557829YuW6yIv9Eblsw3SUuFPqw
   6F8qmfapr780aLM0u8sB54/nou2wAp7bGn+xf2QjLOF8NJbrM4g3AKbSd
   FHfkUsYsuA1Mg9R4l4cHD00EAfK2YjtbnhAcdlo51PQJACNt+0aRBZnNs
   +mr5qCUfIOm8jACNFlnuxV6E8Wm8eH86XE1uX8S4oyt6bBsgsmYrj3oU0
   siuYwExLZKaMm4J9oAiJHvHWqiHYaXdcNECeaBzR08o9fg/ETaCTPUFYe
   A==;
X-CSE-ConnectionGUID: DUnBxOcTTQSog1oX8XLZrw==
X-CSE-MsgGUID: ekjyu5k6RRSKjHWqneXwIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33682234"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="33682234"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:36:04 -0700
X-CSE-ConnectionGUID: AD8pMtO/REOe5NnsC98MFQ==
X-CSE-MsgGUID: hmL2TvzQSQGp/CVCAY8tLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25752492"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:36:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:36:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:36:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4JDqgYI/lTdCy0YoBdzqfTHouDTiJv+BnlCnP0XRGFvapMcmbfmDvdCzA+tpzM7rvLO02a1x/as0G1OfJ6fhC07PhBnVtn6w1dHCKomuUSXq8vPafcFjl5avfIoCVNDK2r+q7sk4SQ/qpzaBbqg5EhISLyJQ4cXoVQqftl4uphwaGwIkmdQ8n9FmPN0VzkHzlZk5JjrbzG6LpYDSV/7FJcXNAP/uUnB5ocbrCa45eXNH0UZtFNWWilqLtM9B3O3tRYCypjku5/xKWuZcwUMpeBb1F8yBlBbaRGkSErahNbwPvrxaFpYJiapMCOW8PJYTcShrsrZmygyBeg4aQIJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHdWawqgX8xLfKSA3o/ejdEJ9+ja4tv0s89Yw5USjCo=;
 b=Jvzpz1wylxzfLFTH81V9jTertr1kDJ0y8eyZAjdwEm+3ccaUjc3aUnpwyim9PFMNIKPbK84DQ/RCDO2GzVCoNcxseJCELohW88eM7LSj7IzTcXCnoMmrMesCUpYUybNjcJF+B9SO3lXuB7C4euizsktuLaHGy4Ryw9JqJK+GcjPrR6rK722za0T7v5l6RbBTca3Xg7MNDIzR5XRKesVLpxOCunIZ3kN9TB90sDjdB1/ltL0aGKcNjgKvAmuxpXbkOol5jKoV4KI3SnCQL1ETx3h8WpFpybjz6w97UQxEJ5uO+yecdyamCcRoxJtYY256zV1W940f4wPFXvb4ewSGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 17:35:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:35:59 +0000
Message-ID: <4bc84ef2-6db4-4d3b-9b48-42396e78356c@intel.com>
Date: Thu, 11 Apr 2024 10:35:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
To: Dave Martin <Dave.Martin@arm.com>, David Hildenbrand <david@redhat.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>
 <ZhfwEF5EJiTM5Hjm@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhfwEF5EJiTM5Hjm@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 043ef3e6-b814-4872-0870-08dc5a4dd9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0u/kAi4BUYeGjczmjAxiQjOD3xRNHa+1EiILqFuLjEoa6qm1rVIiumKgI5oDidkjx1XoJ/wgSKATbhhjBmpmnzPw7eEITzU2uxdiEQHrCMXgTgKBgsmyjGQHNrb3UPciLrMMyGeOM5OeIqDsQcO1y/I3fT6jnoIh9Qq5qJH9oooo13p3x0iguVMj9n8zFljrirzaAEtQNfdb7zRz70/xOVePbgmnkXH3HJhkbN1xcOhngv7Sfmx5pov+IwMc3DX8K/LCeULLSuEDLxH4MrVzWOGBcRK8nXS8wBwG/rPAJCEYwBnD3urZEGcblqJf3f0dFIvgkaxvlkUElJFyuiW9JlMHQW5dWsvQsp1kzG+SZBwnZddN+bSvyCjBAV5SS71yysLHPSqC5j55rLy8HHo4pdKpvQa7cUxJi5K9cQIY6FWesMZ2fkC3iovfyw6zZ4PFL4APXEU6GX18pvSN2HbFUMDxKY7Do6s4Rf2lGzFJ/yh52wM2hFeta/OuykX+tPzdOQTpFT/S0EM+yUCPUXzJOcr2oFBNL5ULePwB+tofjz6By0a+Z7t6Sit5pcrJ31LvEW1zEfEjijC5g+zGmdp3y/OXyq2ssKsYDRFnqVHf/+xf2huDcIrQGirn66/4S7EpOsHbSoDQfcZjd4dq6PpouPUIYpKaRN1NGa9F1b+33ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtIT3ZBTEpXUmQzN250UmNiN1FPZzZuREZncmg2RWlDd0ErMnJwWmYxZ1JX?=
 =?utf-8?B?OEZIY1dXV3JENXNncFJmRW9McjUyTklDRW9QdklmVDlqOWkzSmE0YjV3WWJ5?=
 =?utf-8?B?V0o0dEhHck53eUwvbG5xZlYyVTJjczlUV0tvMlZobThCMzAyaFFVbTJrd3Fk?=
 =?utf-8?B?UzBmcnpSbVB2WUFjTzRWNDdUTkYwR1NLdVdTV1lRdVhNUHBnQ2tzZ045VmM1?=
 =?utf-8?B?NkY3ZVJwU3M0cmFucVNZRWhlQU5Ka2lKKzdIZ1VVekdsdzhTZnR2MTkvb0lM?=
 =?utf-8?B?L0dMaFFBWUNScXM3UTJSOXZscUlySzRCanRGM2UxMEJUOHMweDYzRnQ4dTdx?=
 =?utf-8?B?QTBxcUtnZFVBOG5CUlBBTWw5WFkyd1BSNllONEoyN2JzNVZqUFBlZkxKcVdi?=
 =?utf-8?B?Njk1SzZ0RWsyMStoSWgrWlo3ZmFyK0NvUE9SMlN3NXlpQjdlYmdqNEIybWlE?=
 =?utf-8?B?ZkJBS0hGUWNKUnVKTFRyVlRjMHJnQXYwb3dIa1BwQ0ZkclNhRUhnTjk4ME5m?=
 =?utf-8?B?YTNKb3ZwaGZSWVZ6dU5hT2hzQWVKOTRDWGVlZkJzTVcxeHBkSXQwb0lGRVVs?=
 =?utf-8?B?UlI2M0d6VlAwc2hkOE05dlhtVkppRktIN3NCWUVRRmZVNU9lcGI3dzNoaHNK?=
 =?utf-8?B?SVdaOUhkY2JtNGVLZE9UUCt6ZEtlRjV1bVJBVk41RUJLZDZrME81K29sVzVU?=
 =?utf-8?B?ckNtMmtYUkFnaWFXYkxDTUtTTElpeUdHV3I5VlU2Y0VzUTlXcWpKT1Nad3Jh?=
 =?utf-8?B?ZzhmV000bVNNMkNpOWFUU0pkNURkMVRpa2VLNW9aWk5WdlAwTUZSaWRCVHEy?=
 =?utf-8?B?RmhuazQ2a2VyRnlDL0x2b1Zha0ZicEQzbHpXZHliQ3Q1bU80YlBHSkl1MDNz?=
 =?utf-8?B?bXB4ZlUrRnlWbmFRV21PWFdFQWFqeFJmOEdscEhtM0xydjRCYU1keXNIdklZ?=
 =?utf-8?B?S3YvME9XWENCQUV0SkQ0cmVhS0g5K1ZIcnh3ZXpNKytBc2FxUzlOVE9DdXZa?=
 =?utf-8?B?UzhjMmNDNi9tdFFVclliMXJMQUNnYWhQS3YrQWtFZWk1YmpEYlZqTFg1bEVm?=
 =?utf-8?B?SXJ3VmZBc3p6eWlQQmpRQWhJbityOWhpbHQzU0s0R0JTczVHdHdUeEdjU0Yx?=
 =?utf-8?B?b2ZPUitiSCtOd3JRcHZ3WVVvQTkwN1FNUU9JbUJQeHBFTGZRQ2Y1eG1ZL0Zj?=
 =?utf-8?B?VERCcGNoRmFEc3FDd2xRVkRkTDZ4VzFOMmVpU01FclpSVDUxcStINDVxLytz?=
 =?utf-8?B?aFNFblQ3bS8vbUNTVHppbWZSRHp6M0JNRStLOEpiMDQ0ZU53bjhXY20zVXM5?=
 =?utf-8?B?RytVaDNPckVaVE93WWhFOW55YU1UK0p6TzRHY3plSFUrOW13dmhEcUE5SVdu?=
 =?utf-8?B?cVk5RWlZd0FaUVdzVTBpRE53YjJpN3dBRmUrb0ExbUpPUnNqUndyVGI5MDBy?=
 =?utf-8?B?Qk5KVTJ5cHBlcUNWR2dxalBZNVdmQUE1Qm1TV2prT29MSWhiNGplN1J0bzFT?=
 =?utf-8?B?R2RmSlhBQWtLRGlTeUJkMEt3UnFWV0FKQ2xkZ2UvNkhYNlVBTndRaTBrd2du?=
 =?utf-8?B?M0VKTXRaQWtxRW5oMWYxTDJ6SXhTZFg3aGFGM1QxbTA2eGk0THdyR2pzVkxi?=
 =?utf-8?B?L05TUlh2emJGYnJWWDYrN0lMalkxRmVJRGQ1RC9nOWl3cmNnbGtsUDlwcUxl?=
 =?utf-8?B?cVVaVkV6blhtQlhLaHBXTWpTOE5IckV3OGpSWlNobzJXcUpPVEZFZTl3dnBj?=
 =?utf-8?B?L3JnVEd6akZLMm5jcTBhOTAxSm5vU0xYcExvV0ZkUXU2Z0VpUVBuV1VFdnBN?=
 =?utf-8?B?azNVb2xicFZhZ2hJaFhURy9MbXhBUTlxMTRMbGJ4WFhpd29oQkE5THAyU25n?=
 =?utf-8?B?UytDRWJxVU1ldWxRT21qbWhGUHpwNmFBUnVacFhXaHhzK3hqS1RQVTBHVUJM?=
 =?utf-8?B?bjEvNEJGbFlKZDNWdGE1V1VIcEFLUjVaN2FDK2xNOHRUQzFNQThramU5cXB5?=
 =?utf-8?B?eGQrMnNReHI2MzdiRVBQRHpzMzNsWm4zM0k3NVBka1JSY3pVSkQvc3dUUkpq?=
 =?utf-8?B?aW9HV1lRTkRxSmZhbGM5YkNiY2VIR0R0ZG42WjRJUm1Ncm1HV3luZitDNXBp?=
 =?utf-8?B?MDF6WnVlZmNLTEx2Wi80QkVlMlJiQ01XekFkZWErUU5ETE41eUFVZkI4MGVN?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 043ef3e6-b814-4872-0870-08dc5a4dd9de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:35:59.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUXxyIl1/UFRe8r17/lLloCYkDSWdWCYxzXqOgnj+L9lPuP1MXUYfVtJXSeoBMl5CDBuXI+zaBs0vP6KMBdULC/E2GubwE5bOeLc44K4dsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:13 AM, Dave Martin wrote:
> On Tue, Apr 09, 2024 at 10:05:33AM +0200, David Hildenbrand wrote:
>> On 21.03.24 17:50, James Morse wrote:
>>> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
>>> searching closid_num_dirty_rmid") added a Kconfig option that causes
>>> resctrl to search for the CLOSID with the fewest dirty cache lines when
>>> creating a new control group. This depends on the values read from the
>>> llc_occupancy counters.
> 
> [...]
> 
>> It's weird to not see RESCTRL_RMID_DEPENDS_ON_CLOSID appear in any Kconfig file.
>> I guess it will all make sense once the refactoring is done :)
> 
> Agreed; a stub Kconfig item could be added, but since the file layout
> and naming conventions change after this patch, doing this would
> probably just create noise in the series though.
> 
> Looking at <linux/kconfig.h> (yikes!), IS_ENABLED() is designed to do
> the right thing for non-existing Kconfigs...
> 
> If nobody is too concerned about the temporarily dangling IS_ENABLED()s
> in this series, I won't propose any change here.

I am not concerned about this. Please note that these IS_ENABLED() checks
are not introduced in this series, they were introduced in the previous
portion of this MPAM work that can be found in upstream resctrl.

Reinette

