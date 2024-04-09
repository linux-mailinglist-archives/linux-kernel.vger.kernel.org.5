Return-Path: <linux-kernel+bounces-136176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8684789D0CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CC91C23DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8956454;
	Tue,  9 Apr 2024 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBACIhbZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152455E40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632446; cv=fail; b=CwYSl5dUjfO9lBiiRSB/HX9KCM7WQmIt2388qv/v6LyazP+h0+YX2CD6cKrBgeN59JD2zyBX6lj0KIy4Tceys7Zl+no1mxZPQoG3S/BiBnUvS/zg7hvMu8SQO9LAOA+gTmiQReMUzp9eIMoQWIjnSuBA6EUa+yxWpeNYARNDeJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632446; c=relaxed/simple;
	bh=WHkh0eUMntN5q7CqfQK8wy9FbduIc36R4g8PW/+JmEI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=chEi2QcgXutWVUzTGOpMA5K+gwSYjYrU6A7HmyWbmqpLcvothNR/2woH7+0HMAaf+dNJvmgEGZ1WpXjGIAlIlNy2jcwox7/tPFXDj4pLorBFLbKVpSJ41ECQ9zBXrMNDc8UNgG++yY09uuatLNJPjQgSSZZvU9FGQSptRuVv08Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBACIhbZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632444; x=1744168444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WHkh0eUMntN5q7CqfQK8wy9FbduIc36R4g8PW/+JmEI=;
  b=YBACIhbZYJfiHwE+CHKPX0x0xh3xwGwmaY57BY0XozyFfsPc/jGowMUl
   T7swxY4fRoMPZwM7Q9kPRgaRDyNTJ2ePt9/Oyvc4moHi1U76s/WJmj0Nk
   3ezjrZem1qnEvsxzu0f7GJxpU3V9M0FaRSbaeAE/5t+rMVshgk0RVe+6q
   lGppg9AFJFvae4vtcubsqtJFKVbhCreB/lPUmx1z6926XLp9Kl0TFXhfn
   l8LgHUtxZYeFkiDNdL8IGA5P0FxH7qXfdfWYKDvoN3qLOCCjXRnRzTt73
   LJMgjbdYghSKo5hv0SGXWLSf+FV/om4IrsHsV3ISYcBXnOBkzn5JsK/8W
   w==;
X-CSE-ConnectionGUID: 4djobNz4QlmWZlFhhCz0yA==
X-CSE-MsgGUID: pCBj+gw6SfWmTSTWvsfwBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7798981"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7798981"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:14:03 -0700
X-CSE-ConnectionGUID: xKnDt2UpSDi++w5TCidX1w==
X-CSE-MsgGUID: Br8w9RZ6Qs+j00rs6O21rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20207627"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:14:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:14:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:14:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:14:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMxIYU9sKR78N1UDPPb07lYPNq55U445lr90b7CG8KrXCLh9WqBIRnHXhe9vmPy0zIRiTdE2Cla/OOplsQQ5SZXqT1LATGsZWJ/DUVv2Apir6k13Axlje5Goxst5/Cc5c1RwlLMmxSY790tjNltmnb/+DYVJqTEc8I+ac1j7ko1OFIAFbqpX/n1/POREZpT2Hva1k6CF7dhdBwcnxJGQz3qH7CGmbQqFRSAtRv4ndqW12OEo3mixUg+vOwLSZ1bk/Do1e53KchCq+0m8LgX9nwnV+oTktCfYofTamtLVdxXq63FpPzx8/9BwY/3chTCPHf6io+bM4ZMZIjuto6ZfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+3jPXCDcQEPudzH4TRvhzGDWgeMYFqCSHPLv/i8ps0=;
 b=JmgeW8CzU6AlTiF85NwJPWe1Fb7HP9U2lhzcR5IOk6opSUT4RKMHFouoNuGqqdjC1l4btBCF4IUc/O7pQTv8CE/qPeT0fFM1pBRzDKJYLgM10bqeIY8GLx9xQ5dMLUV7vtrejJxYqD+NHbZ/GkaAYAjdOUbTX+m1gqz9ekIHfl6FjVqudOMrWku54/NtgiwAiB30mdxgncWxtWasOMaK6OUiYLHXNIC+aAjuNm2euWd7E3QRByd8z3pck0YGUYDDvWzQfuvxqaUglqzOy7YL306j54+8C9GZ/Pm1QhMICFIo8tGgowTW0x8LTJoN87RnVtzhxywM2448uQ56KV5OeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Tue, 9 Apr
 2024 03:14:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:14:01 +0000
Message-ID: <65e1a55f-eac7-4804-900e-abf1bc0a9041@intel.com>
Date: Mon, 8 Apr 2024 20:13:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/31] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
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
 <20240321165106.31602-3-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0329.namprd04.prod.outlook.com
 (2603:10b6:303:82::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKe06dDUfviHaexi2teD2lQ/PlbaOnOkfFznLnMreUvcihIzLiQp3wNa10jlrtl8O97LshiJuFWPHPY6gjBiAQdxOFFrjJxYr2IDU9bB1ho6k2PJpve5SkQRa1JWjvb278F938A7iI/uYRDIOcAkwZhFmMn3FugWIjhmlAttYLI/tvHluIFxA3TZu4+0mgcA6OMh2NO1WbiZUXgv/nzEOKrzLv3eIqF+Hjluy/S59RiX0+5Z0JnHO7Geo4RJDchNp3+mABVg0aQU6wUrKJ9C8NGfUr2021saxn4zgBuASzSNfD5NrQiV6oiK5sQclK4mHyuhD70hbZV+XZf2AwbMdVpL8DNG1O0vVcAHxwSyyVP938mx6eHrqToJmboC2xEenmittyUm/duYQbBK+XW+VH4Y5Byd4ZvrZUFfW0FV5LDXDUxNWmLSaw6ohgb6W1KayXXCGAQG/rx0AXpDADg2SOXwI20ZS/lMdO/XVm5SQBlS4peHXQvQE9w9+VUcG9xKZNtuYcXA8GWHOym2Il5357iLdXjWpfh/QEhgWqiUdBQ4K9vkhYOj7oQVZhBfePjUKwPn9naA/5fLbjKiA7cQEbg/gY7H7DqyFCKvIYT89EdhhVVnj7EfuIcnAi0ENWt1uciLpXg3pyXEuQOI6d9FsD7sKWrHBQuDGHl13ioG110=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5MRmQyQ0k3RjM0ZXFEVzErcDBEY2hIL3NIQ0pUZHZiUHdIY2srUk9sK1Ur?=
 =?utf-8?B?NkZvK0U2YnEwTUIxcEtxRys1cCtXem1BNHBjbTAyOE4rUFArOEhIbUJENlpJ?=
 =?utf-8?B?dlFaT001Q0I1VEcrUjlpdDhlbG9BK0hkRFVYUGtMbmEvRWRsZ3YyYk1yalNh?=
 =?utf-8?B?MDVVb1BJT2Nhb1dnM3paTnlUWGtuNkZiQTV0QlZXMTJqZG5La1VHaEsvdDE4?=
 =?utf-8?B?M1NNenZQRU1QNzc5Rk9GeTFvb3hIU0FlNG1zL3FjeWg2Z0NUNER0MU9JV3lH?=
 =?utf-8?B?TXErNHJha3ROWnE2SmFKRCtNOXB3TENKUU1oZWttVmFESGNpZWxiNDlDV0J3?=
 =?utf-8?B?RFo4VHBka3ZFaWRCdmZ4eUJuV0NwMVp2ajg0VjBVSzZDQ3loZlNYVkpCMzEz?=
 =?utf-8?B?SGJ1V2kzWjNUOVYzRkpBaUUzWWIxYmlkNDJRczFpUU9zb1piRXdqR3NDMmMr?=
 =?utf-8?B?L3NVSWIrcWZTV2J4eWlZdWtqd25ObytVOTRHQUZ2Vi91RGZwYk1yOXRCNEZ0?=
 =?utf-8?B?VHlNUU5aYU5xM1RiM2NqZ1JBMWhOTDRESFBCYStBK2F3Y2drSzF6QzZnam1u?=
 =?utf-8?B?bjlCL0diaktOME9HYlhVaDVQZXNIeklpRVFIczhOTWx6ZVg2TlJwOGExd1NU?=
 =?utf-8?B?bXlNcHZMc2NPWTdpQysxN3B3NTd6K1pGME1xT1cyWnBubEgrKzFsT2dqOURG?=
 =?utf-8?B?Wm9QQUVJMU00Y0JJblBuMGVXZVVndU1BTHN1Smk5OU5kemZSUHlwQzdVL29v?=
 =?utf-8?B?ZWZCRk9IbEZLOWRpYXJYNlZFbUwvb2M2OVRjRTBqL1FUeEdxZGkvcGc0SGhU?=
 =?utf-8?B?VHZ4WncwSCtQbXJmeThzSnNwOWdDakZzZTVGdmJidlRhSnM4VkNoeFhnVkNv?=
 =?utf-8?B?ZDJHRnFyUTN0bDl4aEhhczVSUEl6TDB4TmUrRzAvdjgwVmZ3U1VRbVB6enhH?=
 =?utf-8?B?aXc3QytIZU12LzBqcnJKVHVubWxwRWxmdWJUdFZKUEtaNDJycVBnRDNLOElF?=
 =?utf-8?B?TXM0UU5tUUd4QjFvbHI0V0VKTlhwQzIrbFJjR1hRSVkzQSszYW1TeGdFdkND?=
 =?utf-8?B?S1hTS2tqU255ei9zekE3WXVPR1JwV0lEcDdQQWpPZGxnTWFYSlZVcmpLclhY?=
 =?utf-8?B?Q2hRZ1BPNUNwZCtFcmsrM1FMaGw0MmFxZTNFRThFdVVJYVpPeXgyMXdYYXlv?=
 =?utf-8?B?RmdGSVBOM2NmM1dVZGpyc2lXTmxwVE5CcGNFZ0lOU2h3cWljR2p3U0NTNFJi?=
 =?utf-8?B?RjNwTkpGakdJVlhFajZOSWI0aWF2VUV0ZDFFcjJwODRrMjA2bkExUHhNVzE2?=
 =?utf-8?B?b2N4Nnl2WXE2WUZXdVQxOXFMWUFtVkZ5VStZRTk3WS91amF2NGlxRytRa1U1?=
 =?utf-8?B?WDRSbzdVOU5rZm43Vm16ZmVLbUo2cUpBRWgrZ2toTlJGTS9abXREZFJtSURB?=
 =?utf-8?B?Vm9CS2E0OU9BTTdIa3pTdXpjbzNIWGhxMW9ZSzU5UjFlSXVBZU4yOGUxbTg0?=
 =?utf-8?B?UG4wYTJnWEdab1N3YWdxL3NYeEtiQXFSTUJlZGh4MU1KeHhFdDZGc2YremlK?=
 =?utf-8?B?ZlZuQ084TkgrUXF2ZnlPaU93MkhtcVpjeVlyRUkzU0drUFpGckFYdWdtZVJq?=
 =?utf-8?B?TWR2eDJscm16NUQreGE3SVRVSWVhVVhqOEczQ1doazZiMXZjRW9IRWtkME0y?=
 =?utf-8?B?K1FtLzlHbXIvY1k2cXlrTkgwWURxdjhkZzJLYjJhb0NycEpnWnZHdnlqVGdm?=
 =?utf-8?B?NHI1VGRxTEFoYTdsblJMVWtYYk1qZHFDdFpRblZUakp2VE02Njd6K2lpZ2Ja?=
 =?utf-8?B?NGhEeXpKZ1YrRkwrVTdvN0dBOEdvNVdQTzZqYUtLSWx5UnZQQlZnaUZTL08v?=
 =?utf-8?B?KzBaVE5YQ2tQc3JWQTV0YWEzeU1FR0REUkRHeXJ5UUM4QjJIeGdzUVdvWVRH?=
 =?utf-8?B?RUp1NkFVK1dsdnRjYmxwdzNUSFlXeXZ0V0dUR3psRDdoUDN1dEhuaGxqM2ht?=
 =?utf-8?B?Vit0U25SclVOalNiU2F0TldnUkh3Nmc0R21uUjMrNCtoYlZvNGUySEw0ckcz?=
 =?utf-8?B?TW5Hd2Q4TUNBSWtYQ1JJTk9Zc0t3SThURjJBTmRWREozMmxiZGxRZlFuZWR3?=
 =?utf-8?B?ZnNaTElSWjVEZU9xWnVyRy82RGhJVElxRVJJcWlQTml5dXMvdnNmajltZlVn?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf9f2e9-a3dd-4425-bcd8-08dc58431a8e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:14:01.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxvDYwRe6CEKw8xzANGcOK1Ew4kJXTMqLoWi0vlkl6UH9qvYtrXzQ0E23N3iXXYzdZmbZ+QIdsCUFQW0bw7lc7e8WPGdSlFlXLOiDeWkeio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> Resctrl occasionally wants to know something about a specific resource,
> in these cases it reaches into the arch code's rdt_resources_all[]
> array.
> 
> Once the filesystem parts of resctrl are moved to /fs/, this means it
> will need visibility of the architecture specific struct
> resctrl_hw_resource definition, and the array of all resources.

rdt_hw_resource?

> All architectures would also need a r_resctrl member in this struct.
> 
> Instead, abstract this via a helper to allow architectures to do
> different things here. Move the level enum to the resctrl header and
> add a helper to retrieve the struct rdt_resource by 'rid'.
> 
> resctrl_arch_get_resource() should not return NULL for any value in
> the enum, it may instead return a dummy resource that is
> !alloc_enabled && !mon_enabled.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Patch looks good to me.

Reinette

