Return-Path: <linux-kernel+bounces-137744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523C89E69E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22BD1C21322
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121F633;
	Wed, 10 Apr 2024 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SREB63kS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6CB7F;
	Wed, 10 Apr 2024 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707745; cv=fail; b=DIzPoPaFuzGK47dy+XntBjXMPj2595j5jv0Px1P4u6LBGk84SI+IpjDTWu0XBjzdfImLNX0qUH+PVESFgz4DdjU33h2n41Gi7BmoSP8jkyKl9ErUciudaXQKbbp3Y37YzG/+UcntEnaDigh5ArYlmyJ8lKnWdy66gehkNmtDhJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707745; c=relaxed/simple;
	bh=xwRD/Jc/UrJaM3fjxo+Ygp/eagjvC+9Pc4RYd9cofbs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jWaeG5jsZAKaq6PuUOnZoEaqVERlcKN95QG54Dyf0ywV7iwZKhkKVeSu24EEJ3j27dYamDshPaypSlbcdjfZjEebX8R+KHI7lPEi3iiOLMcjl37ud8VxFTHvBzYKhSnbog6/vzAYoumU2TxyQ+eahMuq+RELlKmkSrtg9Y1v6jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SREB63kS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707744; x=1744243744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xwRD/Jc/UrJaM3fjxo+Ygp/eagjvC+9Pc4RYd9cofbs=;
  b=SREB63kSGdYsGL90DFQ3gAlYv0+tHi5p7yRYsoPpYlQJdT65/t9owVGA
   COXhoUxgm/THLqM6AQHmi8OVS0MK7IyWOuwytrSgYBV/21fuhmBid9ffq
   2FTVS08Oq8/XN0GhdzWblS4OK82TS0GhvgUhGiUrooVAjKs9JbitdFKTg
   iYAgBme79KGjulNMcQxB1oR0lPHGOm2RbZt4hUJ2tZDrJcbUSOTDddS/Y
   onmpzSRqkESvEed2JYZXSyZr7Agm4OK0Fe1MN4wSfrWBSRP9tGQ6T9Tnl
   6KeWhG6z7mjLrwuJe7ONe+TP0frs3jZiynkAAIrInl/XjygE4Bz7lQTTh
   g==;
X-CSE-ConnectionGUID: H96GMkHdQjaBFi4+MoWmgQ==
X-CSE-MsgGUID: 92PVvjNJSMCdLgBFf5KA6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7910373"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7910373"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:09:04 -0700
X-CSE-ConnectionGUID: lySWAio3Qbq55HUg9uqtuA==
X-CSE-MsgGUID: LfUE2qC4TgOzStSrHndMCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25063286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:09:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:09:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:09:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8DbnJIqP9CGzGGevzv4RbgmMgHfLRMLgY6tqzlUvpoUj4kMQ0Tw4ksCKHu313iEtXXzy8qzhJYFpw5MX3z+Gvp6fnf7E7SCeYoDHvKG/2XzUAtHVQZfbsyCn7sOvgPM6v29vrO2AMLreaOKAJy1JQ2l3MdsQfY/8u/8c01gdOZOzL9fwgsWTTdlv5KugQT/mQY0XIdYOrxbI44eh5Bqdp+lRO6OhywJKuItkThS/YpKCQqdMOxbiHTIn9YM0dIfDLaOjRberjjFUs4b6wBsyg+d+0BVGvpWRQhaMPEG1K9uu8N+zToWa5pwu9HYV1fpHCTPJZfbCJuES4wRllsuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Fc+sQGZSVoaY9JNG/WIUfYXWc2CPVHlldcOiw5Kc1c=;
 b=CYoW9YIXXO5SWkSSttI5K0sQaRTF3xyNVGQCkawCIprvLdh37jFhzWdEjlTjzb3jw8yQLYEPNE4MvE7yIJzqukStwGM4fWI0Stu5n5LHCPeJgUk1VlEleoV4W1zKykgBhozpuGSh3xsSbhKaJOLAQIT1mNGSqaNdyaUYmlnCQchp7+QV/99XPs+qELQ3LK9OrVBLKJzfZVUIMszmdFzPyvdeA0z4QXJgtF9qidNOUGfodfr77fAQRIk/GkW2r80EMrlRIiV6vYyQvQzNb0YWuTI4A5ZTVUt/G7FeoePoa0rddccv7h6OWfwPLLPRnF++YlCxfASTZ15a0TLIwAgUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 00:08:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:08:55 +0000
Message-ID: <5cd26a3a-4cca-4a35-8a4e-22d1d5dad945@intel.com>
Date: Tue, 9 Apr 2024 17:08:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] crypto: chtls: Fix possible null pointer dereferences
To: Aleksandr Mishin <amishin@t-argos.ru>, Atul Gupta <atul.gupta@chelsio.com>
CC: Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Michael Werner <werner@chelsio.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240409090507.21441-1-amishin@t-argos.ru>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409090507.21441-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To CO1PR11MB5089.namprd11.prod.outlook.com
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
X-Microsoft-Antispam-Message-Info: mlNZAbIUGy5ZuNuO3/ZuZdy3ms1EVo89VWcHTgE+RxVvbzi5vfGYSaJgrQUKQpyrze5wR09x1PdE1GWO7HxBMN/ey6QB2xf1djc6B4ZP+zj1tIzajQiph/0xCXT2lqY6NY2dH9DzwZiFpa+pZfS8Lu9DryP3fWMwt4kjHzqaJaIQLYAETIoJvZmMtNMIwZuELPTN8kZB81MHaevqjuIPAC0cQthov8FMX0XjqPvtUQvW3ua8o6xewXdLsjd6CLDUsxqF6BzVfXUB9BqmfxYFrPvoCLOvm3oaEnWs7yJsV/VlfEMX5bzMhgWmw8jumQj7TwiPrZ5JlJKkszZtuNOYEbgTzDVxFlPdYuXuTXg87emgAprK/BPTzIHzTGQZGRQuG/p5+xEwVkBLlO3zwBfHmn8EP1U2VoOCp1mVsUB7YPmEJSMiSMQEG2E2TkDGmteeFL16ZI+hqOV+DsdpdvMHpSrG/sFnWGXBxjoD47ZcNIg+Q2l3o9pRT/6lREAGVlJi/VDs8EXhj9YlL1b1ZNfoBDnFtCL5jnwraavvFXL4RzKskezjAz/lUWJ9/EJ/0pJjw+9gIwXofDlUelMZ8gMsrvgsPOQ0UFZhzvFWHgKI15Zihk58BwHKagz7ppBkcIb54i9ZdvFbo9uNdqfXlvgXeRFXEyaiivEaS95pjo+KH6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0thZTRuUUlaRjF0TndIaHVqdDlhNWVubUV6ZzJyb0ZsNHIydnR2Y0RBVDZP?=
 =?utf-8?B?RlpKSWxESExkTlNiNEM3YlVlNFpoTFJLSE85dXdBQnpYaEUyRzd2MFpXTFhX?=
 =?utf-8?B?UlQzMjVZa2t0Q0wzSzUrb3BEOHpNWnJ3aTNUWDdrMURXZFlZQXdqTEx5c0R4?=
 =?utf-8?B?dEtUSDQyZEhxVURjbzRDVnJ2Um9vQVk0dEg4Qk5SYXlLRDFLTEJ1ckorUExh?=
 =?utf-8?B?c2E1d0xQSDQ2R2pvYUp4bzQ1cmJaRXFDMnY5RWJDaklMbjZrYWxrNmZ4RG1o?=
 =?utf-8?B?VS9SQzIzaVJIQ2lSZGY0T2tabTYrQ1hURVhnMGsxWjBmejhQM09scUZNaVo3?=
 =?utf-8?B?dnVwUjVGRUNhdWM2K1B5MisxeFVEVWVtOVdmMEM4aksrTEpzY0EyejFVUmN4?=
 =?utf-8?B?QmwxT2lyRFNCQVJ4VnJFUHA4RHVtR3loa2JDQmdrZ1EvTUJyeGNpUk9DR1Fz?=
 =?utf-8?B?bENyYzBCRlIyeHUrWUpXMGJrbWhKRkpDMi9CYkNqZU5EMHdJTEhPUGxyWnd5?=
 =?utf-8?B?NUlHWXlWS2wyYkJBSjVJeS9hMGV4Tmh1UkNDSnlTOC9MRVowWmcwVEJRYkll?=
 =?utf-8?B?S0t2eHZJdi9FRCs1WUZLZHQyQVZzWEtPejlFakdONlI1SUJCUUN6ak9FVXFB?=
 =?utf-8?B?MDRvY0N2elFBM3FKQURWRnRueWdudW15c3BvUWtCU1ExbVdrSEFGanZvSHJs?=
 =?utf-8?B?UzRaRFgvSHBuR0xRYXh6T1FGRCtEeUNEY1FtdVJrUkE4YjF3WFhzU2NncUha?=
 =?utf-8?B?VmtMRlJ3cXpyWk5vQ2w0d21EZEhkS1RqcUhuUUxLU2J6d0hrVDFVcDJ4Q2Nh?=
 =?utf-8?B?NG41OVRFS3FxVUVnb01CZFJ0aWQxNDJlcU1abmVxcldWenVyOW1BYlp3S3N1?=
 =?utf-8?B?VVIxeGcxUjg1ZjBobXRQcDNhMjdrVHNOV2d2andkcTNVTWo4SzgyRnFseUtt?=
 =?utf-8?B?YXEwL1EwVW5Xd0xXVHBtLytneFcxc01KeGczY3JkTTR5SHgzOTJjb24zYjdY?=
 =?utf-8?B?WVRZd05aempBa1JyZm1pcVluYW5hV29wa1Erb2dyR09sempBMGtqZkhKb203?=
 =?utf-8?B?bnErWW9PTGU2YXBReWZWTkF1dmxWOGdpUXI5YmgxTFVNbVZFQUFIdW5rclZD?=
 =?utf-8?B?a3pVbUgrUVk2MW9VMjAzR0RmTEhBMktNam5qaFZMNjdYQVF3bjVwWHFseG12?=
 =?utf-8?B?aEh4NFFadVB4eVRybVlOZHdNNm1Fc2J1N1I5amZHQVI5M0EzY1h0Wjc5eWpa?=
 =?utf-8?B?SFhOYXRYalRlSldnaHZaakNrU3VMWVo1dHFJOFJUVHorYWU5WXVXckdsOU1S?=
 =?utf-8?B?SWZ2Q1MxOUt5K1cyVVArMEN4bHNRNnRZWVBJbWZ0dWlZRVIzV3dETFozdGJ1?=
 =?utf-8?B?NGgzMFArUVphU3VtdVpaZjhCbU1icCtrN0M3L2k3V0JkUlVXTVpnanozZktF?=
 =?utf-8?B?R2g5SDVCbVF5L2ZFaU1OK2FYRHlrTVBnZ3ZkaVRpZ2lFMHNNK1lVT0hWQ25D?=
 =?utf-8?B?Uk5Kc3FZcDFSNUQ5SzBxdGcvSklVSk44b1IxcE0vK1kxR2dzNHFIVlBCcE9h?=
 =?utf-8?B?aUJFQk1rQUJWWmsyMzg2cHhqMVVOQ0hQd2N5akpOTXkrMUkyQUt2aXE3RjJJ?=
 =?utf-8?B?Rjg5U3FzNm9oSUN4cE1CVFo4TWpadzd2R3NqVkdJRzgwQkZ1cE42djVHUnJ0?=
 =?utf-8?B?Y2ZyVVdjUHhiMC9obzVYbXl3U2FnZ01XLzZ6c0xIQlVkQk9ESmFoWkZYeFov?=
 =?utf-8?B?ZnppcXJkNE1LV0lxV25wRWFHRVdpUmpGWHZuNmM1azNGeVREWjdoMncwM0R1?=
 =?utf-8?B?dEp1Wk1kSkVZcFBQbTRtZEwyL01YZG5QUytMQktKOHFjMy9LWllzamhieGF6?=
 =?utf-8?B?SHd0WVViQWRhclk2OW9Pc25OZERtWmNDdTAwS29PZjIrd2N0bGpXQkhKa0xY?=
 =?utf-8?B?eEVUUEY4ZkFjekVudmg0Q3ZHT3dYdTFhaXNsOWN1Z0FKTlFmMWZXM3liTXdx?=
 =?utf-8?B?emltL3ROcFU5YVhTbUVuSmZTVmgxK1VzRzNrbis0a0VQejhnM1ByRlA1OUFE?=
 =?utf-8?B?OGg3OHRDU0ZibXJlQlVJekRXa2tuNWZyOHgyUjUybk85ZDRjOGNkQWhOM2Vk?=
 =?utf-8?B?emNkSGxJVXZnRi9RYlhWYUFmeWs3R0t2NVd1Tmp6UFE3MjlpdGh2eFlQcmxk?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf22c7ca-8daa-4805-966d-08dc58f2698f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:08:55.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE3DvZH7r2mehnOmNQzG3tQWfjq/i70DWbxJmyuAyFLxg8yHQXXotApY0QCgIiZW/qTMEeCTL2GTdQSKA1KFp0I0Vr9yu9quqS+tJVYX6Mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com



On 4/9/2024 2:05 AM, Aleksandr Mishin wrote:
> In chtls_pass_accept_rpl() and chtls_select_mss() __sk_dst_get() may
> return NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

This seems to do a lot more than simply adding a NULL check, though I
guess thats because it needs to pass the return out somehow properly? I
would have liked more explanation of the requires changes.



> ---
>  .../chelsio/inline_crypto/chtls/chtls_cm.c    | 24 +++++++++++++------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> index 6f6525983130..6d88cbc9fbb0 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> @@ -939,15 +939,15 @@ static void chtls_accept_rpl_arp_failure(void *handle,
>  	sock_put(sk);
>  }
>  
> -static unsigned int chtls_select_mss(const struct chtls_sock *csk,
> +static bool chtls_select_mss(const struct chtls_sock *csk,
>  				     unsigned int pmtu,
> -				     struct cpl_pass_accept_req *req)
> +				     struct cpl_pass_accept_req *req,
> +					 unsigned int *mtu_idx)
>  {
>  	struct chtls_dev *cdev;
>  	struct dst_entry *dst;
>  	unsigned int tcpoptsz;
>  	unsigned int iphdrsz;
> -	unsigned int mtu_idx;
>  	struct tcp_sock *tp;
>  	unsigned int mss;
>  	struct sock *sk;
> @@ -955,6 +955,9 @@ static unsigned int chtls_select_mss(const struct chtls_sock *csk,
>  	mss = ntohs(req->tcpopt.mss);
>  	sk = csk->sk;
>  	dst = __sk_dst_get(sk);
> +	if (!dst)
> +		return false;
> +
>  	cdev = csk->cdev;
>  	tp = tcp_sk(sk);
>  	tcpoptsz = 0;
> @@ -979,11 +982,11 @@ static unsigned int chtls_select_mss(const struct chtls_sock *csk,
>  	tp->advmss = cxgb4_best_aligned_mtu(cdev->lldi->mtus,
>  					    iphdrsz + tcpoptsz,
>  					    tp->advmss - tcpoptsz,
> -					    8, &mtu_idx);
> +					    8, mtu_idx);
>  	tp->advmss -= iphdrsz;
>  
>  	inet_csk(sk)->icsk_pmtu_cookie = pmtu;
> -	return mtu_idx;
> +	return true;
>  }
>  
>  static unsigned int select_rcv_wscale(int space, int wscale_ok, int win_clamp)
> @@ -1016,8 +1019,13 @@ static void chtls_pass_accept_rpl(struct sk_buff *skb,
>  	struct sock *sk;
>  	u32 opt2, hlen;
>  	u64 opt0;
> +	struct dst_entry *dst;
>  
>  	sk = skb->sk;
> +	dst = __sk_dst_get(sk);
> +	if (!dst)
> +		return;
> +
>  	tp = tcp_sk(sk);
>  	csk = sk->sk_user_data;
>  	csk->tid = tid;
> @@ -1029,8 +1037,10 @@ static void chtls_pass_accept_rpl(struct sk_buff *skb,
>  
>  	OPCODE_TID(rpl5) = cpu_to_be32(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL,
>  						     csk->tid));
> -	csk->mtu_idx = chtls_select_mss(csk, dst_mtu(__sk_dst_get(sk)),
> -					req);
> +	if (!chtls_select_mss(csk, dst_mtu(dst),
> +					req, &csk->mtu_idx))
> +		return;
> +
>  	opt0 = TCAM_BYPASS_F |
>  	       WND_SCALE_V(RCV_WSCALE(tp)) |
>  	       MSS_IDX_V(csk->mtu_idx) |

