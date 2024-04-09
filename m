Return-Path: <linux-kernel+bounces-136192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8704A89D0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DAD1F26E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FD285943;
	Tue,  9 Apr 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wi/srD9P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4984A38
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632791; cv=fail; b=iwpWQwxRi8R/fMB+c9WJomOPRgJnlq+E3cClVD8jg7i3xQRzx/aKFEoEBOpm0a6T+H7rESaopbBfyboxf4t1rSay54J5pvnyC+w2fYFLZE61cHuvEOhVFAbcbIa2VVD80T4m0zntpwTLAblzkBLlx/uPDoStxyJrQ5KdGpS6RXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632791; c=relaxed/simple;
	bh=98YJf04oVFeLeg1BZJk6Anepf53m+rVRrg/aWqYGS60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TAPp5pqH0XxjlT2/zbIJwjFKXZc2JB4PTtRb+birxXBMPkfzro5cCOmedjiJIITBb8bL4m5fszwzMAHIe/kNGk06zikO3c743QZKCjrNdMrCR2QJyyba+IFdWTOsMn4LvTCOeFy1QXXZeYixF84pv0qSO1FvUsXA9F7SKBzCAZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wi/srD9P; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632790; x=1744168790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=98YJf04oVFeLeg1BZJk6Anepf53m+rVRrg/aWqYGS60=;
  b=Wi/srD9PJSWsyQn407VQbEE20aMUbHSZowEiWAaHkvm7uS9jAsb51QRR
   5i2pc4s1nbvLSrOLStgt8LC+5WcFNtWWqkazghy94daxt8hMxD7pbP9od
   1CBi5oczGL+XUJPVnt3vRLFyBRxJZyiDSWgyXONNshrFgHcAPYZXPgQeo
   V4pt3GicKxhUh4fza04J1pxqQ4GXXMt1NCG0iJls5cz0QKGcroNl63kle
   cyvrs6NI7FmhhPrJ6rYImnXfeED/xoTICgS0byIrDPZxrO95pvapICRtJ
   G+eeQlgEdNLhCnqjpg6xaejz1YycpCzsAajXl34XL+sE8Uqu45beEfddE
   g==;
X-CSE-ConnectionGUID: qIYEnA4jTM2hNs8UdLqjpg==
X-CSE-MsgGUID: lXjUUEOSRz2K42OgXehl9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25436063"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25436063"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:19:47 -0700
X-CSE-ConnectionGUID: fvmH+TvbRFqdnlJpdqikkg==
X-CSE-MsgGUID: 8AyR8xVhTiilhoaOXVuWPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51280880"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:19:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:19:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHGmu1JQrLW3q+HsthfFqgk+1YH3n3LiTs/OFCYtaGTcnLFclRhx1HAId2eJjWQefWGEb11Vlf/mzyyk1VoLWHm7LfyOYHotYeRVFv4ZikWZHRRFHbhQvk4qbQy7PW1pXKV/nCRJHS6ms9goBGzntNDb6bKR8texMzUF0Cygw7NEEcC/cT9Yxk5gbFUvQfVZmcv6bs+mwE/1OmEI2YyJEdF9h56ggZrpebL4sebDuNl5qlMd9vjxTxzBzB/BQZrRdpfAPSj5LL16OcWLV5fgKuZeUozhLsfqmpo8iVnOf4imKwFFJ+hLi+qX9M+Yrpusf7iVrZ7p8CwVWeI2gkpBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpiIO7KmcAzrmUMBLz0H7uysUKBNDrh5jm+lCkzZuqU=;
 b=Qo6KSdFR0fmF0ZZSuksuONgXG8rUJUBKQbRNeHjxcbsZ2WVdE3VvTp63KNsU7NfcLld6fNeOBhdsrcHZ0z42e0ZTLNUEbI+Fizw3kEs4o+uy5Mv26OB9CGm8X9vilVGmhRjwwCB2tpS7PrXCsy+FnbEjpR4z70GAjO7+iP1qHUd0Y1OAr4FOoHHufazGu6MFHucoQIOEuDPIV0Ajl8WGICw3hnHW+YCr/pYOnkARUGwgbyc96ksbOafUNq61vjIMBnhhYrngCsEqVK5V/q+AbABtJOHsp17xLOhK+8pruoE2OvFs3e59DOlk6Nnm883bG/7/K+pLRh+BR/WX8eRzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:19:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:19:43 +0000
Message-ID: <9d339257-97c3-4d9f-aa02-c43713fd33df@intel.com>
Date: Mon, 8 Apr 2024 20:19:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/31] x86/resctrl: Stop using the
 for_each_*_rdt_resource() walkers
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
 <20240321165106.31602-14-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:303:2b::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
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
X-Microsoft-Antispam-Message-Info: MJfE7mgw4Y4dqFw2dtON3zXYPlgH4Xafza6eDaq3mY47bpN7IL3SexI3van5qyVdki/jEE7Ns12BnIRvRtOMCrHVZDF2KqNkM/VFpUMaapJBf/PqcjA8feso5tmA5ID3VbrHGDAoQE0KpMcRyNiZJPh5f8g+efxcvsJfIyEaATt72bYQou6YOo2YgY6ThIKyDOI3ghELM3O/ACvdiKQrS09n7WYWzrmHe2uJiZU+NLuHPf6XQhLo5///e9CizvHMg9ZFqyjR0AK0K2O43CmK0jkRacqnIu3u3bR+UoyPh87inXHD/TUs7g4GpAxdf6wrbGl5mAn3YogZReqTqLv/TCTJe90BMBpXT9XU4E0TCw1HRQT76zhbVIE3aMS/8WtoMGsMj0kvWQ39M/xburcEd+YRDih9a/cgIMWQ9veDEyK+sYKLlaVypmpYiZUSUNZvPEwVX6ov5XDdCar4+1Dn/KWd6tB9VGb38mNdENGlVApN71My2eqfamddZGcka3lHN4EEXMHZlePLQyIulCGnrnSfJ+Oi7FTdz3c2Akt0wIx0JlDJ28D8OXgOHh6Xl8OZ6181e18a5W1VmcU1fdaSx1pD13VdYfjETSMk3yKTk3RiLiryX/pgZQkvtyXrjAxzKJmXq2nJ6KRRpUK0xLA6XVu4K3gOYZZNz6gHVipMk6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVl2a2tzZ0lwVThGZmMzVW1adHZjazRKbW82c1crbkZ2akNBaHhTNjFrR0J1?=
 =?utf-8?B?VUNLMkhCNjFWOW51c3ZUTUVEOEI0UnlreUNnV1pvMER5SkdqcFB0TnlZbjQv?=
 =?utf-8?B?bzdHTTNuNHlCNVJUSm9pNDRycURINkZlb3NCTlk0Q2IxaGJ6NmNhaUpwVHk0?=
 =?utf-8?B?NXBNYXZxRjVYbG13eEw5dytqRmlnZmk2K01wbXJQbk5OcHNPTWtXeWd3OEEr?=
 =?utf-8?B?Vk9ISVJhZWZSMWl3UU14RzRiaHVZSTMycVFaQ3YrNEhKL1VnM1pwaDlJZmhS?=
 =?utf-8?B?TUVKajRqVXFRd0p2aG5aU0ZmelhqL2JTWjNXUnVpVzc1ZWhheHNvMVBhWURQ?=
 =?utf-8?B?d1BuaGx3VkVVVHpwVXJvOXBJL2hOcWg4NDZpeVRSTHdScG5CQkRjTGYrSjRo?=
 =?utf-8?B?b2NPeWNleEZpVmozYng0NHRkdStITjZSakxpd2RCVWx0MGpaMElMWDBWZEI5?=
 =?utf-8?B?OUxLSkJpSUFua25QM24xVjREcXdmamoyd2RsM0ZYSTVEUDNmbnlkNTdHeG13?=
 =?utf-8?B?TEI4QzN6b3hXa1VLN0hMQ0Y2YWxyMldNbzB3Sm1uUGQvcHYrM2lITFl1SFh6?=
 =?utf-8?B?L2JLdUp2bXBZN3VPb3ZyTVdnSjR0Si8wYkVOSkd2T2tWNkFIY2pSZzBaSEJF?=
 =?utf-8?B?aUhERk5OV2ZDTkNIaURtYzdJbndMV2owd0h0dDVaakRtVys0NHYxV3RrRlpQ?=
 =?utf-8?B?bnNqSGpYUFc4UTEvL2w2WFRnK0tJK3FGa3krRjZkbnZicnRVY3hzUk1oMXQv?=
 =?utf-8?B?bkQ5VDhKS3N6SWtnQWlUd24yTzIxdEpVN3ZhMm15dVZSOUhuYis5ZDVUcTlx?=
 =?utf-8?B?VjJkRWVUOENuR2NIK3B1dEJ4UDlXb1lnakVNMFFQMGJBTmdCNFBSVFhCODVB?=
 =?utf-8?B?Z0liTFBKSG5GRTlYYmtJVmdoOVBiaVdjMHBobEJ4Wlk2Y3pnL3ozR1p4N2l3?=
 =?utf-8?B?YXFLaENhNktPMzhQa2ZOUGltMjZjMDYrRzA4VksvZXZrY3R4elkzYmo5MmhV?=
 =?utf-8?B?V2dRQ1pGcVZlLzI4dXBwWjc3SFFtVWU1aEx0a2MxMFhSbDNnS21DQUJCOU9L?=
 =?utf-8?B?MGZ1U1hCSEh1RWMrU2JiTVFiSXlDaVFJdDE4MXRmVFBadDJtaDlBclA4QzBN?=
 =?utf-8?B?SW5ucjFSbnB5SHc3YmlFbFhjUmxocWRvV29TZDJabk80QmdmeU1BeFFyUlNm?=
 =?utf-8?B?MFVtQ2JicEFoN1NHM05jck1zVDBmUXR2eUVHbFROQjNGamk2bWxkSXhKdUtR?=
 =?utf-8?B?Vkh5Nnl6RXZJSjYySFhXWDg1aGlQUkNXU0dIS1QwMzV4V3REbThKcWN6dUJp?=
 =?utf-8?B?NWRNakN5Ti92LzlReDRXYy9ESU45bXZLYlY2SEdtRjlvWC9Ga0ZkNk5JYnB4?=
 =?utf-8?B?Y1EzdTFnSWRHeDhUa3Y1OHpEUFF5bDBzUHVScVFXRjZadzdmRnJSSWZ5NW95?=
 =?utf-8?B?eUdETWx5ZFByTEpudVpBTVZXRlRhTjlHRThTdExGYlp4NWY5a1dWUEszSS9E?=
 =?utf-8?B?VkF3cTQwbGdtQWVCVXpVbGpqcUNXZW5Ea1BaelBPd2RwaHpzVUZLTU51ZEky?=
 =?utf-8?B?VWhHYUVJSm1UQ1dXWmtEODd1OTZMSG1kbEpPcDZ2MVU1Rjgzempnc0RTTFlU?=
 =?utf-8?B?cUM4R0NFL1UzRk9yZHNxQVN5RkFSOXl1YTJQOC9pd1BRS3AxdHo1bTRULytn?=
 =?utf-8?B?OHRXVmsxcENqSzR2czJNdi9Cc1ZHZ2o1b2RYR3hDRHZza1lHbjZ3c21FZ1VG?=
 =?utf-8?B?ZE0vdzNtSjdYY3FGVTAvaDlWUS9lc0picU80NGEwc25qQ1ZzNzdnNHB1ZjVY?=
 =?utf-8?B?U0d5YkJ5SzFQNjlvTTkxRnJ2VFo3UDNIRzNUOFBwemVZWG1VWmppWW10bm5L?=
 =?utf-8?B?U2tYbnh6UTZrNUdJeUd5Nll5Vi9NOCtkZW1OaytzZUFOU0tvdTBGQTJOaEQ2?=
 =?utf-8?B?VVNxcCtiWXE3TmFYVm1CUlhpOFU4UkNXeGM1ODNRZk9lN0p2NjBJLzZvNXVv?=
 =?utf-8?B?RXdVRGljczlIQjVvYWZnTzAzc0Yxc010SWo3aERjbnRpNkhJcGFZQktsMVZE?=
 =?utf-8?B?QUxYNlc4WWpjek03WWk2WGp1WDlsb2ZzZVZKeDVuOFo2T3dHV1Y0SGdGbENh?=
 =?utf-8?B?cTVnZTE1NExKMFhYTUticXFJZzhCS3BlZ0FKRDZqQXBlWElUWGttYzRaK01o?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d8ff20-0b5c-450c-00e9-08dc5843e675
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:19:43.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/OvORPlmlXnUsg8jPDVKqath0wHGXjdwqhnaNR2KeVjN2b/EXFMsZu7fE6tkCEX4l0P+4yH+eRpz3zw08uCL5dpEeJCKuHfplDKqBdPhiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> The for_each_*_rdt_resource() helpers walk the architectures array

architecture's ?

> of structures, using the resctrl visible part as an iterator. These
> became over-complex when the structures were split into a
> filesystem and architecture-specific struct. This approach avoided
> the need to touch every call site.
> 
> Once the filesystem parts of resctrl are moved to /fs/, both the
> architecture's resource array, and the definition of those structures
> is no longer accessible. To support resctrl, each architecture would
> have to provide equally complex macros.
> 
> Change the resctrl code that uses these to walk through the resource_level
> enum and check the mon/alloc capable flags instead. Instances in core.c,
> and resctrl_arch_reset_resources() remain part of x86's architecture
> specific code.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  7 +++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 30 +++++++++++++++++++----
>  2 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 884b88e25141..f2315a50ea4f 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -840,6 +840,7 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
>  bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>  {
>  	cpumask_var_t cpu_with_psl;
> +	enum resctrl_res_level i;
>  	struct rdt_resource *r;
>  	struct rdt_domain *d_i;
>  	bool ret = false;
> @@ -854,7 +855,11 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>  	 * First determine which cpus have pseudo-locked regions
>  	 * associated with them.
>  	 */
> -	for_each_alloc_capable_rdt_resource(r) {
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->alloc_capable)
> +			continue;
> +
>  		list_for_each_entry(d_i, &r->domains, list) {
>  			if (d_i->plr)
>  				cpumask_or(cpu_with_psl, cpu_with_psl,
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e736e4d20f63..3f16e7854411 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -98,12 +98,17 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>  
>  void rdt_staged_configs_clear(void)
>  {
> +	enum resctrl_res_level i;
>  	struct rdt_resource *r;
>  	struct rdt_domain *dom;
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	for_each_alloc_capable_rdt_resource(r) {
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->alloc_capable)
> +			continue;
> +
>  		list_for_each_entry(dom, &r->domains, list)
>  			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>  	}
> @@ -2181,6 +2186,7 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>  
>  static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>  {
> +	enum resctrl_res_level i;
>  	struct resctrl_schema *s;
>  	struct rdt_resource *r;
>  	unsigned long fflags;
> @@ -2205,8 +2211,12 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>  			goto out_destroy;
>  	}
>  
> -	for_each_mon_capable_rdt_resource(r) {
> -		fflags = r->fflags | RFTYPE_MON_INFO;
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->mon_capable)
> +			continue;
> +
> +		fflags =  r->fflags | RFTYPE_MON_INFO;

Please check spacing.

>  		sprintf(name, "%s_MON", r->name);
>  		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
>  		if (ret)
> @@ -2615,10 +2625,15 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>  
>  static int schemata_list_create(void)
>  {
> +	enum resctrl_res_level i;
>  	struct rdt_resource *r;
>  	int ret = 0;
>  
> -	for_each_alloc_capable_rdt_resource(r) {
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->alloc_capable)
> +			continue;
> +
>  		if (resctrl_arch_get_cdp_enabled(r->rid)) {
>  			ret = schemata_list_add(r, CDP_CODE);
>  			if (ret)
> @@ -3166,6 +3181,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  			     struct rdtgroup *prgrp,
>  			     struct kernfs_node **dest_kn)
>  {
> +	enum resctrl_res_level i;
>  	struct rdt_resource *r;
>  	struct kernfs_node *kn;
>  	int ret;
> @@ -3184,7 +3200,11 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  	 * Create the subdirectories for each domain. Note that all events
>  	 * in a domain like L3 are grouped into a resource whose domain is L3
>  	 */
> -	for_each_mon_capable_rdt_resource(r) {
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->mon_capable)
> +			continue;
> +
>  		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
>  		if (ret)
>  			goto out_destroy;

Reinette

