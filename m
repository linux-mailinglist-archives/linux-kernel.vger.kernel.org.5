Return-Path: <linux-kernel+bounces-140251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10528A1039
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7EB289C72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEDE148300;
	Thu, 11 Apr 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALpXl2UD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40A1474CF;
	Thu, 11 Apr 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831488; cv=fail; b=KsHfUOEu8vlE70vy35ckTrReyA7Nk9RBzoqAIrVe2N6IPqFh0Lql9dieumSbty9c5bIVuQoHauQr3uKPGk5Mzf3+Nt6HCX/AjT0EcnV9ifKpA9EN8Moyc3YQ0HgF3COuZ6xjvjan4mOWXAfCOZrioHiNxJIMXcPNakkqxlEO98I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831488; c=relaxed/simple;
	bh=CXwZ+kHuAIzf8UvVNiYFpyeFw7hkMcZ6gRol7mTTdlY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kPZENFmyahfWP9wI53HQtr0kPpv4SAjCcXK1SAAZvmUnrHy9BAP5GGzxDm+psTw472nHAnQ6+FQR4WWLfAYhBnukdmw1pAjDbMHB9FPt67R2/z5PqJn/Y2seckS7a7N5o1N3DOI0XAw2Pb36Z0QN6VhcBuquzK5Wk25IdYZ/TvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALpXl2UD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712831487; x=1744367487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CXwZ+kHuAIzf8UvVNiYFpyeFw7hkMcZ6gRol7mTTdlY=;
  b=ALpXl2UDYLMRhlLaBRogfzQJV2Wc8lVj+71WsE2WTtmbSnoK7t1qrqI4
   ZsSfD8CnA/dx2d5lxTWtw3SiNBJhq9r2KVoS84VD4E9YZuRuSwb0UJC3j
   hJhnFtfoXT4ypqXlHhg3K2xYUW1/lljHD7sb5qNlBYxJ6Tyk7Q3Nv2Ba2
   /DOOtAO7ko2FmMoY7aC87Ij4C9MqRFkZ7I76NsRLn1grewfWji5VkBcUa
   NQ7b6iDRMrR6QOVqzW+qIY8K7+pQZcH8t+GAF9egDc9PZbND2UhanFIZT
   JiLe0+e59ZwUD2L4wmmxkBm4HuNnBNg163IdP2E4MrperUbrae89chMzo
   w==;
X-CSE-ConnectionGUID: MDupAyZMT3uleFNH1WYkFg==
X-CSE-MsgGUID: RGmcUvF3RQe0rxaSigWVWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8453383"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8453383"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:31:25 -0700
X-CSE-ConnectionGUID: Vjaje6l0SHKKJ4CZE7JP5g==
X-CSE-MsgGUID: WZY8fkhGQ+OpaHZAHBgrEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25513583"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 03:31:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 03:31:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 03:31:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 03:31:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 03:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ3sEzpwkUhJCYmTh/kVG4zfnalz989lMwGbKTHdFKAQWptldUMDKy0DEVDIs27u0j40oFNhzPTCLx8YUCN0JcA9demujDkps6G1KZJZIHDEbTj8Mz3xfmQSyAchenmnE1uDlYjldOcdMCZjTVKZfAu6O2Mu9ihhCC6zJwRdnyFL+wxN2AT5lcVCb/+ngSvxzy4Q+ZAQ8uOcCNzpdmwlCg9WDJxL8sdrHQgK6mSCNk+ktoL8SkfEmam5NPQ7Ow2vOwiW3/yYkuAusTE0LQ9KswLltn+I/+02V0WZlhr7CyeOK4onyQWOJIqlKyuEzOGHcgH6UnTPx0YdHzt/ln+ajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4Cn5oJ98//LvVkj4skmB5afVFpSDSRqYHdwYMAxhGw=;
 b=T68kMZr+XmZSSpRi0rhwkWP6v0wdqdLjWMbsp0j2W48eQmdzXlMjy/N60mKCjZQ5EXTCpnavRY/EDu5zmgCreulRk0ve4t1UUba3PDMUy6gBs8aW+zEFEIaOZntLnZPDaQqeQxYwOVEcMRNzMKqXiWRsNEChYTi/rhweqYEN+pSBu5aDmaljgD72CGpvi4gUUD3aYRnRlCqP1xo4yt0Hgk6qjUv7j+nXVInm9ffhHWdiioQd+kyBb+3VRGcsy2+U0TFLWaYgznZG2vySTUcADQT3G4Ezh+Y4hvftjZAqyX/3CzTmYh1C7fPWZUWZaMyZ8euSE4sfHR8Xax0CTJE6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 11 Apr
 2024 10:31:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 10:31:22 +0000
Message-ID: <1627f034-7748-4e10-8110-5156a90ced5a@intel.com>
Date: Thu, 11 Apr 2024 12:29:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 3/7] netdevice: introduce IFF_LOGICAL as
 (IFF_NO_QUEUE | IFF_LLTX)
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-4-aleksander.lobakin@intel.com>
 <20240408193214.20df8d40@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240408193214.20df8d40@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0182.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: e39b88e5-bd37-43c5-c682-08dc5a12882e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENbsS6oAxh2L+69RvvtTr9mHgiie6ekitI+qj3CRHjwR8RX5BawbfHEO6NIksF+eIqO9Z1wbeyYX6ybscXa1Gpf+O75wo045LEB5krHYzhIY295C4ik9jJVucOEe0vn4eAUEgsNFdk6T4wMO7f4vlt/M7HPwQsXKsUEVJQzeDI7vDexv/bxwplTsf5dgY2Wnpdyf3ims90QzVFsDmSi2LAUxlQsaAukwp3DlM4yCY3ImeRKMZqZ1Xnbysas69WApQ9Iwwm4aKzDgmXLVzjzPbJzPBk8qyp8RDYpPKl4kCY+uAXMteTAOaRnPUKdDJ4hxpOGeAZIrZx+o4dVrgRxOUjiC/wuVpPyXEaR1bPsGfEpw5hcRsKeTm4WEHQTaTfxh+GrBtm3sIHxZ29/MQPEjs2WhLOuiM+8a/k3jgmR0jQmQlnsiQNgUQwOZ3DCAfJzDmZ2Xs0Kob//539ThTijeQ2nhJLpB1jG0jQywXiVpwHkIL3g/gx8d1h9wOVnklKOVdVadM99WsUwreRB2pqQqMel0XsPEeBWWMJCDFbx+TfgdjVpfwcQSp05cYxPhsUAALU/cFafN5fXUPDcUTkkzafKIB14Dsvz8Z/YKCkGJyW5ejMhKFqd8h84Fqs1jRgFZFAd1+GkZEcPO2IOxGPHBurP+F5SyQTQZrgfWCzPF1TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2FnSGpkdkRQTWJJTGhlaXp2OWtyZHZBOWpGK0JsV2t1ZkFYREtUTlpPdVVU?=
 =?utf-8?B?REYrNG1MQWZHaENXbEl5Lzk3MlJhVloyZXdHNTB0dlMrbTV6RStoSHRHR3pV?=
 =?utf-8?B?VEszcU55YWprWXlxMTNJeVQvTFVyVHUralJtaVgvSlc5YjlDRytNS2dNempM?=
 =?utf-8?B?ekpkWEhBa1BtVjB0RTFjOVljeVp6K0Z5ZmM5TzllS1U0OXRMRjZEaW53Y0c4?=
 =?utf-8?B?Q2ZUT3paZU1oc3M2YTlsaGMrNVpzM1NEV2hrSHZzWE5OQ2VQRHFxOUthcGk4?=
 =?utf-8?B?USt4WXIveXVsWnFNNWIvWS9lUFJVeS9NcjNPTmRScVhJTHdISHRReW01M1A1?=
 =?utf-8?B?WTQ3b0NNUW1EeG1vaG9iMWV1cmpWOTI4QXpEMHpLZlZ0WWhaUm15RmlWekJD?=
 =?utf-8?B?S3ovcHBRclZ1aEJKT091V2JvbUVCMVVRdjgxdHdYbGlrQ3BQV2pLS0VjUlFh?=
 =?utf-8?B?STFuUFQrU3JNSTJnMUs0d3EvV3BST1ZaQW9TdE5pTWUrY2hXNng2ZFRIWjh2?=
 =?utf-8?B?UTBjbUgwalBUcWF2eDNPbUxRZUtPajdNRHZ2U0JJWHJib2JaQUhzbDNlQ25k?=
 =?utf-8?B?b0EycEkxSk9QeGxYVk9qTzNtUHpSRkFFVDRTMWVubGdSTjMzYVdGTXBmZGlP?=
 =?utf-8?B?eVk5N2FnWi94WjFzaFJFRThUMkR6cFFCLzhUZTlBWFJ6N2ZjU2Y0UlBlMDU2?=
 =?utf-8?B?QVN2eWlaTFV2MmM1eDdDbElZK1VMdEtFN2oyUEp2REdmMXZDT09xZWFNRkty?=
 =?utf-8?B?Tk5MTnJsU3d6bHRWNzVJdjBZZXdraWtuRXIvQ2VGWU9HOW9ZZEtHcCtLazRR?=
 =?utf-8?B?RkJkSWNVTGF4RU5CSmQ0M3A2dDRkVHBwTVVvWGRnWlVMc01odkRmRjdMQUhZ?=
 =?utf-8?B?V2ZYWWxUL1dTUUV2d0RKY2x5ZldYY2FsK1ZuMS9TVVJRTS85cXBKUm1PNmM2?=
 =?utf-8?B?WDdVVnkwWnVpdWhVYS9Xd3JPWWNzdjlDZTA3bDQxLzlCc1RKT1RQZXU3UGFW?=
 =?utf-8?B?MjhjaUVDNW52WGFOb1pYT2hMcnY0OWhrd1N0cVlXa0ZSZmRnZG05MWZLSlRo?=
 =?utf-8?B?anQ3MlJkYzJ3ekVsQnl1Q2V3WTYvZWZjYTYreE1MQzYyTklQaGNPOStLc3hm?=
 =?utf-8?B?QVdtZ1VEZ2EwRnNZcitvWEpWOVB0aGUzQTNnMWIrQWM0S0dPWHhGQUxXbFV0?=
 =?utf-8?B?Vk9wa0hPdXd0eWJZMktLSnRrM05hK01maTgyUEZ6bDhISVhEbDVEa1NocUFY?=
 =?utf-8?B?VHpnUTlNL2hSVjhWUTJoT1pJd214ZytQeTNZUlpPelpPY3lQVERsbXR2ejBS?=
 =?utf-8?B?YjBOcjJ6ekFteGNZVDZYek1BQXZlY1IyTzlIWXo5Zkc2ZmJQcVY3Myt0Vlhq?=
 =?utf-8?B?cUZmdVhaSlVQMjlFOXFZUm5BVEJwUGdKTzRoQlE3L0RZcFhiMi9uZDNJV2Z0?=
 =?utf-8?B?L2wyU0dZWDEzZHJ0OWJnOGl1SjV1WUVyU01kRnp1RjNqUVZBZVEzWmN4YVZX?=
 =?utf-8?B?RTRkSy9iYWxYZnNRd3hrVktQek1vWmpwTHkxaGVyZFdZUUVtaFR6OTNWdUpi?=
 =?utf-8?B?L2x0SWxYMGYxRE1uVG9OeXZISjdQZXZkb1NrdWtQWUhnSVREUDdkSHg1QW5s?=
 =?utf-8?B?aU84d09lMzBiOEFJRDM0NGRHZHQ3eGE0Q2VKK2hJUE9pRi9hQ0R1Smd5YUYz?=
 =?utf-8?B?blJteFFzMmVVK1pIK21pUVdKYkJjNld6QUtiUnlXcmhtZXo4TG90K0VmUXVq?=
 =?utf-8?B?OTE2dGYxU2dWcWYyUXB0RDR4QUdSWEZOSE5uOUx2aTVUbmJSa2paeTNwSUtH?=
 =?utf-8?B?bkdJcVF0RDU0eDZ4bFo2VERVSmpBSVM5RjJvdnFTY1dHcjF4UmJBTXlqa2lm?=
 =?utf-8?B?T1JHQVhoRGdKTG1FQ05Zc3dkWkoyWHJjcHdLT1QxSUZYeG52UHk4OGxyS2l0?=
 =?utf-8?B?Z1dnTVdGVFNTWkRsQmJqcVNJMnZRdmp4a2N6c1luSTJtZGhwM0lYbHp5cFBn?=
 =?utf-8?B?TzBWaWRVaXpRdnhCbWZ4d1QzMnQxSDJqNHNlUFR4b0QvZVY3ZEZzRnhJN3pw?=
 =?utf-8?B?ZlR0S2xXZjFpL2t5b2t4UXdxOWdpOTNmR2R1QXNUOVA2d0c3MUV4UHlZK2NM?=
 =?utf-8?B?eFJiMXA4clI1T094OExDWFI3NTE1VzluaEpERWY5MWJaNmJ6QnBJL0JWbUpP?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e39b88e5-bd37-43c5-c682-08dc5a12882e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 10:31:22.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3yPxZ0XmAvaeOWMv0CvDcncmaTgZHdDm0AolmuI00bUyfUoTjCzX21GiAZB3g5prGFS+vLjUUO63pSrxG8Su2j0ZxIgRdeOVWZmUjrQFFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 8 Apr 2024 19:32:14 -0700

> On Fri,  5 Apr 2024 15:37:27 +0200 Alexander Lobakin wrote:
>> + * @IFF_LOGICAL: combines @IFF_NO_QUEUE and @IFF_LLTX, used by logical
>> + *	interfaces to avoid overhead from locking and Qdisc.
> 
> 🤷️🤷️🤷️

¯\_(ツ)_/¯

