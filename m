Return-Path: <linux-kernel+bounces-145678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D848A596A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D721C22434
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7CC1332A5;
	Mon, 15 Apr 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqSdfG6z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F6131E54
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203318; cv=fail; b=aesqw2B//kGEDAqcjVApJymvaUx1IQ1SlpKwFfOCRqwf8RWIOL2qO9943t6l8VevI6ENfRBQwqzrGgQISadyKnyhS2gd4WfXgKUqpv4SY2PIIFaQHGfnI5mOOy1YGTa19dl76sgXfGZDGno9EHzJAJHp5BxE3J8AxxQpTClju3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203318; c=relaxed/simple;
	bh=3UuZTE61auD1lJ/7auEUDnQkLmHQKCd+cbqQjkc8H+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qCC9euLO3qnXzTK/DLXxGPhZASYkIpV3z83b3TWwqUynyIKGSMVakL5DmDoTXCQeJTRhSbQ+Jkip8xIwBQXNzaIiE+qkQwrlr0BxuCEUomH0NeN/H6Bd6dyBPdet2crMD76IaEW4ETfCn+jg5t2cdxLbRPRoimBPh1WhdaQZ8Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqSdfG6z; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713203317; x=1744739317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3UuZTE61auD1lJ/7auEUDnQkLmHQKCd+cbqQjkc8H+g=;
  b=eqSdfG6z8XqO/LVeqABIUuzr8/1bgqSKFT22vxo/NIfHPnWSBBSBf2sY
   DcYvkuW4S3Pkw82oL77YOVp6SAaBjTfXgyDlhvNyAowqml9NRG6StQpQO
   NR+DOKf8rRlIFQU0XbjGO3ugWDcufZDfv4TS0fkHnZjkVAlDUV+3Q694k
   9L/0gwvDMBBrEYWj67YhNjy1s05hW0uh3l+qI+lVmxe20EjitrsY4y+ag
   jJQ6twLyhAzEyoQ+JPcluQfo7sW5f8gX9irk3AeuWJdT6Bb572uGg8f+j
   kgpiY3878UBSc2u3a8cUINdQNe8oJ7JtGKmdotGJ4htm/b2f1RCmzsJzd
   A==;
X-CSE-ConnectionGUID: BwCknoy8QXGPamFp+xKr4A==
X-CSE-MsgGUID: fxolYYABT9S5UlZYOjj+7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8443087"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8443087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:48:02 -0700
X-CSE-ConnectionGUID: mShcbFdZT0yHmpykNF9YPg==
X-CSE-MsgGUID: XTh4Ndf4Se+yy+DRL+P9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="45283078"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 10:48:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 10:48:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 10:48:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 10:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d43ADHyNb7rr7N1+qGu/8AjU9RA7ww2uwTJXBHddEwD9jUH+52JguwJnVkqvQI3L1DozxkuuRbH+nOcsvCfo98zP44kfe4evBHn6dNcTPhi491aSQdlaImanPCR80aNyQWGNUrTZnQUhuMIbDA01hAf4ROnloSAaer4ZpMbvRi5I14SyUZK7HlPa5vpA+G1BPqYRj5htSFa2A0cKw/wvYfMLygj/FFgftVb0pGjL/n18GYFIwXBq9mCnIMYoqkgSs2ka+eR2/EFrkMa8ceclzrBV+pez7+HRqpUKEKvXtWxULTBddAshuQMJb0kzQBa+4dxNDAS96tXAMklILKrphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI0ALnvm9xZ/asP2C+OB9DV7G1ZSoPiJz0pKufNGYGs=;
 b=irNeuPjBpp+8wbHP9eyjntHjCkybSkH/2Y+7QLzL4VpMCw2vr+2gCTxfiurAX6PrC+pqo00Db1pz2dU5S0XUannqlEBox+inc5basRNJ6FuQhlO7hR8OHa980Luh51Lhrc4wTRrFtL1KqDZXTCykohLMLKGksy46X5WMiecT2zQVI1Gs1TVfUyIUAViIe38o5waaVbGjgM4LS5FYPpDsXjCmV+zr6MnR/ymDKw7XhwWYchbqIKieKu8s3pLPc61xaJqmbDs/h5CCZR9Z67zvtmKnqOvGYgG7OnQpdaZtDuXMDqwFBffqVxX44I7qvqBfGyxOWUoVl8XDzutn47+QdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 15 Apr
 2024 17:47:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 17:47:58 +0000
Message-ID: <0698418a-aede-40d6-90ce-dbf6e8796916@intel.com>
Date: Mon, 15 Apr 2024 10:47:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
To: Dave Martin <Dave.Martin@arm.com>
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-6-james.morse@arm.com>
 <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>
 <ZhldWJVck7VmU3G3@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhldWJVck7VmU3G3@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:907::44)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad78344-1947-4942-331c-08dc5d743011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKfEMid/5FMMceIgbCWLhZ1uTgi2X9w0qWbCln5Njnv6tEpl+NxvxlXFodiJn19jZseIgrbHUj/9r7MUY1eOuukGawYPaDPK4OckImiwsMkAoxQ84yIoKqYBrurqrokLo7gHPCWOqEADi7syOXIYExfb5E7nD+RTL3hLR/z4cIzsKFQpuO92x0rgaIOI2CpkUB1T2rtCsF5tng4hNvoYzQyIJhXCHZsXQ990kepqzhgRI6xP+O9MMdLIHyhq0yLmh/1VyV81PqT+XYrTEm5gK3Q5Tfhu1ehlDn3rPIrE3SW3nYgZUuPY2VGKZ7Mmxroeo+dlA+rsa1ldAPx+QwVqNJ3N0MX0aPG2Ly3dl3hu5EHOJR4Jsmxi/4vbiQWlDyzEdWSKh3PfJtpiVgsuLOewJN6BUEn7tMS/+F/WRpPVwZhRvgaT2fGy8HV6oXT3sVPLnmdD5l+qb3eI6EW+L32WdceIQQKCGt0rixPn3njLYhzL+UYcILSuIeYCy60LHRtsZoZDA0Jg7V4gHJ+TL6AieJih3g5XY5pXL2RclS4Y6l4BSHtqjJ66xQKMekuLxScs7Cbq4qpg8q9QeQV0wUN4Qu3P3IdzHWr5UbXas2467cSq62JSERteYdJT17SmxtL2qSD8DqsZms6mcdokRG2USo5v3MVN751i2eXSjB/6Ty8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alJ0dHNuVmVEbTdkbHAxNXdXZHA3SkVMYkpXMUNNejd2SWNIUDVaV0FFdGkx?=
 =?utf-8?B?K0tNbHBBRjJUUThxNmphbDZWT0tsTFVLWDFjN3JoS0VCR1dYSVlkbmRYQjlV?=
 =?utf-8?B?cDZtdkFjZnBMQWlKSHliWU0zMkIvVThpaWR5UjhPSDY5WEo1NW0yQm0xRHN3?=
 =?utf-8?B?RXpGVFNZUFg0MGgrZ0JhWWJKRk1mSnVIVE5JUmMwUDYyNmpUY2hiVTk4V0pU?=
 =?utf-8?B?cnpCU3kyTkczYnVDbXVnYlVBc2s4TmQ0SGhPL0QvaHR6OGFWclVaRHltQzJv?=
 =?utf-8?B?SENXOVNaYnh6dnU1dE1wRnRKcFhJdDNaOHNPWGlBNEdZcFRZMmlUSzl0YkxU?=
 =?utf-8?B?L1UxNnl6TUlUMlA0R0pTSUFoeTZzb2gxb2ZaeDRvTEgwOW44SFpKQ2k3akVi?=
 =?utf-8?B?eVl2eE9IYXRaUzk4bGtnUHp3dzV2cjFKTkorNHc1M3d4WU9YaDJQOWQxeGxr?=
 =?utf-8?B?M2dFVEZrQzZHTytPZmxRM3ZKeTJhdktXcDBPd25VSlIvWGpPZ1FqNmYzWUdX?=
 =?utf-8?B?Y2ZaNVJvYW9GTkwyS3doNkt2WFptaTVZbzNvbnpDU0xvcGZSSDBNb2xVZjZs?=
 =?utf-8?B?TmIrK2FXVDQvOFJPRjhyZTI1WnduMzRkVWo1UEJ6TEdmb3JlbHlTNVRySkdP?=
 =?utf-8?B?UEFsWEdhOHFTdUUzKzJlcEJnSFFCbDExeEdjQXZ4eDBtMEVPczA5bXBUSTJ2?=
 =?utf-8?B?UXpwR3QzMXNKelpVVzRidUJpZGNXZG82WWxjUWY0WGVaSFJKcnp6Y3owQ09Y?=
 =?utf-8?B?WEVBeGFBQU9YTkhyVlBaYUwraDlhV3ZwWTdlcWVtb1lXL09aNGo3MGJhN2xs?=
 =?utf-8?B?TmdNVUM0RENDUWdzdVpuMGhTOGNYK2RsSEJmaCtmMEJRYWNTR2tSdkRVSVRE?=
 =?utf-8?B?YUg3TXpldW94Mk00Q05ld0VjN0JrKzRwN3hxWDRYNjNIbThzZ3VZWlJ3Mlc2?=
 =?utf-8?B?UHlZOHZPZ0NVZjJTdGkvZmtoVWhCa0xxNWtmbEVmM1NtSE8wUmN5RkhLMUlp?=
 =?utf-8?B?TkdnS2pGU1oyTzQwbTk3RzFRVkMrM3ZKa3IzRDhUTEZZWEs2T0pnWi9YS0JZ?=
 =?utf-8?B?ZnBwcVViTXl1MmZ2U3NIbkZjKzdGZlhBSE50b1dLakVsenpCb0t0bTZpZ3cx?=
 =?utf-8?B?VDFDMHczVSs2RWQxNTg2RVBWbXpSaW5FeW8yVlgzaVBBY0tTRW1oc0lZY2JY?=
 =?utf-8?B?UUE5OUJxY3VPUzRtTmp4M3NhQnFiQWthVUNpVG9TTjRIaWVxTzRhTGFjUHpQ?=
 =?utf-8?B?cjlwODFlVzVBR3ExNC9QQVNRRnpLb3Z4K2R3ZktpU2RHL3ZJOE9YK3UrNnhi?=
 =?utf-8?B?WkxPeTBKK2VnNXVCTnlqMmN1NUhGdGtUaEZLVGxkaThhTVczeEFNQjFVYlpJ?=
 =?utf-8?B?UE9nQzBwN2dZcDhQMWJrN0VoRGhuRVVpaXBWenV6bG5Jd1gvUTVKa0hzK1Ji?=
 =?utf-8?B?WW50UjlhRUEzTGFwZVNOV3RhUVpwYWJpM3ZEWjNNZHNBVUNTYU4rTEw1MGc3?=
 =?utf-8?B?T0ErQlpvSlRjTFJmOTZMTEZ4TkdZV2hJR1FNS3d0cW8xT08rSnk4a3AyOHQ2?=
 =?utf-8?B?UTBMbFNnekNWZlowN0Z5NUJDeWROa044SlRuSDlRMk4zZkVFOVNScVlYSEpl?=
 =?utf-8?B?YzRyTUhJZGFtM1EyMHI2UmxGQzMwK0NjVzZkTXVwSlBLZlMzOUxodmRRTkJa?=
 =?utf-8?B?VFUyWjIyVkJBWFU3V0lrSjJYTDQ3ckg1cVRsNm5VU2Q0Wk1oc2hrSlhsTExM?=
 =?utf-8?B?MzNRTm94b0RnNnJaYTVuOXBnTzltRmZxTmFUTlY3dlFkOVgvN0ttZ0V0bzlZ?=
 =?utf-8?B?cWlDSlVjaUFOMldqZThsQUZhdG5pSkp2akVOWW1jVE9yNlVBL0J6a1kraGx5?=
 =?utf-8?B?T2lOR0REZHJCb0FrbE90WHhDc1FyUkJJZGYvdnA4b0lHeFVTZ2xOTWxvMUVw?=
 =?utf-8?B?R1JIdzNWS3RKWi9WQjkwaSt6K1RYS2NXZjUvRHRQR2E4T1QvMUEvMk1JeWk0?=
 =?utf-8?B?eG5nTkxRdVVYUEVTbzRiMExSY1A3aytNODMrV3BsS0VVTmVHaWxNRzBzKy9h?=
 =?utf-8?B?U1gyaC9XNU1ibW9tQTFiWUNBUm9YYWxHRDFnclN2eGpRVEx1OUJMYkdBazZw?=
 =?utf-8?B?NXk3T2RjNGUxNk1pNFVCKzU4RHl2MUdjMnZPZk9FS3B6dC80c3ptT3BLMVA1?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad78344-1947-4942-331c-08dc5d743011
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 17:47:58.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP58Z8h9fTNbeNpAQTCbt6IsGptELxR7Jwpn+nvdTziXaMuwZIokqzVPBf9CcKxOdG6i6WXHiHRVRI1F7R4M6ALcdC4VpjziVhyISY8kSm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com

Hi Dave,

On 4/12/2024 9:12 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:16:08PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:50 AM, James Morse wrote:
>>> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
>>> it uses to update the local CPUs default pqr values. This is a problem
>>> once the resctrl parts move out to /fs/, as the arch code cannot
>>> poke around inside struct rdtgroup.
>>>
>>> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
>>> to be used as the target of an IPI, and pass the effective CLOSID
>>> and RMID in a new struct.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++----
>>>  include/linux/resctrl.h                | 11 +++++++++++
>>>  2 files changed, 26 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 5d2c1ce5b6b1..18f097fce51e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -341,13 +341,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>>>   * from update_closid_rmid() is protected against __switch_to() because
>>>   * preemption is disabled.
>>>   */
>>> -static void update_cpu_closid_rmid(void *info)
>>> +void resctrl_arch_sync_cpu_defaults(void *info)
>>>  {
>>> -	struct rdtgroup *r = info;
>>> +	struct resctrl_cpu_sync *r = info;
>>>  
>>>  	if (r) {
>>>  		this_cpu_write(pqr_state.default_closid, r->closid);
>>> -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
>>> +		this_cpu_write(pqr_state.default_rmid, r->rmid);
>>>  	}
>>>  
>>>  	/*
>>> @@ -362,11 +362,22 @@ static void update_cpu_closid_rmid(void *info)
>>>   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
>>>   *
>>>   * Per task closids/rmids must have been set up before calling this function.
>>> + * @r may be NULL.
>>>   */
>>>  static void
>>>  update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
>>>  {
>>> -	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
>>> +	struct resctrl_cpu_sync defaults;
>>> +	struct resctrl_cpu_sync *defaults_p = NULL;
>>
>> Please maintain reverse fir order.
> 
> Or, more tersely as follows?
> 
> 	struct resctrl_cpu_sync defaults, *defaults_p = NULL;

Sure.

> 
> "Reverse fir order" seems to be documented as a preference rather than a
> rule.

This does not seem to be a place that warrants an exception to this
preference. Note how this function is not consistent with any other
in the file.

> The declarations can be swapped, but defaults_p is in some sense a weak
> pointer to defaults, so it feels a bit strange to declare them backwards.
> 
> Alternatively, could we rename defaults_p to p?  Given the size of this
> function I don't think that impacts clarity.

Do you imply that this would maintain the order in this patch? It does
not look to me that it would but I may be looking wrong.

sidenote: the "on_each_cpu_mask()" in update_closid_rmid() can be on
one line.

> 
> I'll wait for your opinion on this.
> 
> 

..

>>> + * struct resctrl_cpu_sync, or NULL.
>>> + */
>>
>> Updating the CPU's defaults is not the primary goal of this function and because
>> of that I do not think this should be the focus with the main goal (updating
>> RMID and CLOSID on CPU) ignored. Specifically, this function only updates
>> the defaults if *info is set but it _always_ ensures CPU is running with
>> appropriate CLOSID/RMID (which may or may not be from a CPU default).
>>
>> I think resctrl_arch_sync_cpu_closid_rmid() may be more appropriate
>> and the comment needs to elaborate what the function does.
>>
>>> +void resctrl_arch_sync_cpu_defaults(void *info);
> 
> That seems reasonable, and follows the original naming and what the
> code does:
> 
> What about:
> 
> /**
>  * resctrl_arch_sync_cpu_defaults() - Refresh the CPU's CLOSID and RMID.
>  *				      Call via IPI.

Did you intend to change function name?

How about "Refresh the CPU's ..." -> "Refresh this CPU's ..." I think it
makes it more obvious how this function is called.

>  * @info:	If non-NULL, a pointer to a struct resctrl_cpu_sync specifying
>  *		the new CLOSID and RMID for tasks in the default resctrl ctrl
>  *		and mon group when running on this CPU.  If NULL, the default
>  *		CLOSID and RMID are not changed.

"If NULL, this CPU is not re-assigned to a different group." ?

>  *
>  * This is how reassignment of CPUs and/or tasks to different resctrl groups
>  * is propagated when requested by the resctrl fs core code.

Could you please use imperative tone here?  For example, "Propagates reassignment
of CPUs and/or tasks to different resctrl groups."

>  *
>  * This function should typically record the per-cpu defaults specified by

"should" sounds like there may be cases when this is not done? Maybe just
"Records the per-CPU defaults specified ..."

>  * @info (if any), and then reconfigure the CPU's hardware CLOSID and RMID
>  * for subsequent execution based on @current, in the same way as during a
>  * task switch.
>  */
> 
> ...?

Reinette


