Return-Path: <linux-kernel+bounces-137740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16289E686
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E68328293F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BCB159211;
	Tue,  9 Apr 2024 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvLmxBIN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1431591F1;
	Tue,  9 Apr 2024 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707140; cv=fail; b=nv6cqx73X7hoaUm8M2dPDEhDyGdataLIYzuEOkMZNroIhOkaOlblRi8QiC+7Ump8ZneIVFHqVFbIK6Y7U02962WE0131ZMsGSk32Wb14B2MMVkLqODQInYrP6brJGPzv/TalLTb8oh7+taAfIHph6qnT/Hhyx2CGqlGq066Hc8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707140; c=relaxed/simple;
	bh=4jEQPMELjlqAVhjdHCofpZ1cD9FklvBXXVi2J2s4vqY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CAAKKGn8YtEy6kQ90DM2h+ZIv9JqF3EULwMPv18WXtJJOx/MDWKAywQJwwHAf/FUvMukMgs0mqzlZ9GPYcNcrPoAERjiiXVzWvSnKI7/fm+TYr0fMIGo9I9LU0Q81zmPao0jFuI0Ig+xQbWnV3VX3c3r8udCfkXN0o7g+vBrXhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvLmxBIN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707139; x=1744243139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4jEQPMELjlqAVhjdHCofpZ1cD9FklvBXXVi2J2s4vqY=;
  b=LvLmxBINMnJk88Ue8680kmW3LlB+Oc8aXvJjeW+fbYIxkUCfLRr/cVSa
   q5e+vvXakNuPukKPyfOtNmUpMMOShetAr+n7OmG4rksWrjuGXwBGPRNbI
   ZhUrnDR2TpaiwLLnpm8l6A24Dsx4isVxR4QLtf8ArD+bmiTnoSFsmt9jb
   pMPtrGBKNEziuwGVjk1PsKtBNVe9x1XXi2+EgKBLTyoMiAz+gT5nFvMl3
   vpn9GVR0s4VfSbYt4NSHfZdW9vMap5T01MZ0XZIaLG3z0+JoSwKcwwyFC
   ex3PuyAo+y0f0jdMDDIvmkRbkSGYS7rZ438Xv6mit2C2QIT+jVxnYdPZ4
   Q==;
X-CSE-ConnectionGUID: ILqOXeq8TNKct4DFNmXKfg==
X-CSE-MsgGUID: 2hPfRNSMQZ+RT6Y+a8rD0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8622044"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8622044"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:58:58 -0700
X-CSE-ConnectionGUID: 3D4aGu76Qe+7w01lKtuCgg==
X-CSE-MsgGUID: oWJuIRHZRsGy11BY9dZfnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20333499"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:58:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:58:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:58:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:58:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:58:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc0ljvrgc/LjrqGUPRcYaY+Rnjx8Ajbz+Jn9sUjNv+EYOD5+iJYYL9kkVVXtWnXWUTEYjM/jpdZlUiNrZVYw2GvFTTLDgiMUq/TQhxqQL4GtjYYEedMGf4zq/Eem9Dhb7kKUH6XeDcl0WVfPmrtRB8TXch/NbTN5xQi/ZyJ0hy2gFXi0IExaxRSmz1hcPcctYnRgJLqjx8nbdeQmOy+ZHYIiIQS6ho7gC8OFtKFF+fBx6y3amopY3AlTVYAVUm6bo1B2GQ2adbq2bJYyphGkCRYINctN+3f6tet8KnFd+bOYC6j4tDvJ1xj8eSJRc0pjxPrC3QTY0+j6D9LbWXNCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3053DY0p/uuFMWc8V1cu14cGTQ9tDyg4F/g0hoEI1Q=;
 b=ZWniCPBv0BaBBo8tpqhlxBj3Y/zajD5hmmACbJ9aYvvgFQJjiAtzDFKhfVkRkJaN/HJNvzZzNrTZi5GxZlZC0/8gX9L4Nru7pCf8Swcr2y3PRdQkVaaYuIINEPNly8/EpLjvm2aBbJIJXvBU4EEnCU7h26GNFTvb4W6alDv5MQqkHXcJEf8xT+UfZUhOfIvT6lZaqhYF2xYbks5vUt51Os970n/a7eKFOcgCkfmEe3HY/g2huTy9zA6AhdZVPqnOao7t6izJ2uzpoqzbUY4esBoEBtQ2PFEp5GpSV3xtZBdwidTiaMnJ7k9F3cqsk6UOYa23GFfDrknOYEycoeOukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:58:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:58:54 +0000
Message-ID: <c4976cb1-ef18-42f5-acbe-0c053bc4b141@intel.com>
Date: Tue, 9 Apr 2024 16:58:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net: remove napi_frag_unref
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, "Boris
 Pismenny" <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20240408153000.2152844-1-almasrymina@google.com>
 <20240408153000.2152844-4-almasrymina@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240408153000.2152844-4-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6945:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGUF9ppc7+mW6JL5mtQzOV4C798zhq/FrQh0AnstCcVsVj75qjoPGHziGuvfQiKZXh9d021T7hYBs74y7ikVXs5de+ohcdgeSNdZaaG2GzRgBpsDpYbN6QyNqRrJ2Bnz468XOT6wrLA+zk0giRq/GfJzaqOV98hg/FlcUs3X43WpoQpe1i8AJ6AxGWbPnBep8mXR8TcQ/xcjGzFJx6i4emNRxaC5swhihN3UxMm+5Y+XOY0gMDmL/6sbgM/X3xIFE+tiDDRvYep3GztZ999z/f+YAV6eGXy6rfT7jeOegAfpbprkkiwsUR/GvoSlkBGLMofuFNMuP0aZ1NLSDDbgF8C8Lxq63/nZqxdKPW35bPMIML+aAXzg/TT9CZmjx8ByYN/aXVr5wt5gpG9Q/D69cU8rda6ojEigNvjO1TdZ9FSkTCkRexs9g5gE95nV9Iwkyx/i8aaZhKO21Avt4Ce/lN8lUgbbRuH5UX2Ch2SOwh78lomKFOeScCffQTzzVvnTJx5H2x2dJsTfjvGz/RyKCTq7Oeq2cYzvb7FJSuS6rrimSVvm7GtVDld5OflpVpILwk3ByU6SxaMuyJi3lKJql+swo1nZlC/+C2Ei/37nMVj+AMRmXboPCm7kK+kJnbS4v3A4bU5DEOn6jOQsiSl8whu+I8IfalMvKAc72yIkHzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak4zN0tTaGpib3djQzdjbDg0ZTE4MysxWGxtRjNoeHFhMXkxSmpDbGdVL2pj?=
 =?utf-8?B?N2hFcTYwV3BQYUZ0bXVjb3VuL0UwTkoyeDRRYXNiMHVUdVZIMitmc0dDTk9w?=
 =?utf-8?B?eHpSNHM2RFBScmFPWEVUTUYrS1BRM1B3SGJLK3hmVlEzYnpKTVhLeXdXNUJZ?=
 =?utf-8?B?VXkwbmxHK0FJSHNETUlJRFRpK2VadTFOTFQ1bmhXTW1OeG9PZEhMRzcrOXhI?=
 =?utf-8?B?U1NrSU8rK1F4N2xRcVRaUUdadC9hcGErMFk4dmc4OUpIbmNhREtuKy9leFRC?=
 =?utf-8?B?L3N4WVk4aDhQK0lHYTBkYm5udXZvaVJJcGN3ZkFLa1lVaVg5bjgwem0yc2du?=
 =?utf-8?B?bnFNdDBDek5DdHJiODFRL3VIejJjSUJSd1hGUlpwRHkybm5ENnZVcXZBNmtE?=
 =?utf-8?B?d2ovMWZpTFdoWTFtTzZkNThsZGs2M2tQWUk3N2FmMWxrZ21pMi9RR2s3Q2Q2?=
 =?utf-8?B?SVh0QlEyMUxNQ0JsRGN1anlFNThiNHJjYk1UYVdvQkhOdHlpb3BQSitTV0hD?=
 =?utf-8?B?TnQ2Y3BsOXdkdkE0R3dSWHRWaWhpZkt6amZONW5CSXFWNEt4VmpzNC9pKysz?=
 =?utf-8?B?SmdNWTluLzVaVDZKZWVrMDBlVXcrdjRGSkNvZEtPSnZOUk4rVGZ3R2ZMWDdi?=
 =?utf-8?B?MDRwdEVHYUFoMzhmd0sxQ0VsWGEyMFB4dE1ZbXV3bEh2NDJEYXRuVk9PcGl4?=
 =?utf-8?B?VzJHd0ZnUjQwdTh4U3F5bXREVnRRREQ0dEpYazdubGl5RmVnWDZubkMvSTh5?=
 =?utf-8?B?RHBFQ2lDUGgwZFNiZzB0Vnk2UnRTb0VtSHB1MGFpdEF2VjJmTk5sN2xTdzA4?=
 =?utf-8?B?UFVWK1c2dnhSZGtXZnF4ZEdBODhkc3hxRzdQbVVZR1REbE56ZHZLRXpsL3Zj?=
 =?utf-8?B?cWVDWE5mR2owN1pHQjZha2hIVW02YXJqT0d1Z200TEhpQ2tBN1E0WXNBMXpx?=
 =?utf-8?B?MHIrKzQ0SUxCVVVVSUt6UXRJUHB6NlNYVHk0cUsxNnljMWJQM3VGUnZDbk5P?=
 =?utf-8?B?QVU0RjFhY0Y3K2dUdU4vbWwvOWxzSmhXT2ZTU213cWsvNU5UMWxzaU5yN3Bo?=
 =?utf-8?B?YW1zcmdFSHYwSEJhL1RtREdtUjZOaGxHT2hFN3h5OFlUQ1VwRXl1S3RCNUlG?=
 =?utf-8?B?NXVmdVpBOVhQV29mbDV4SXh4cDVib29lUVFOUC9ycUpnbnNwbHlybkhaenNR?=
 =?utf-8?B?U3EycEhDOHB1ZTVGMFcyZUhubzNtVkdUUm0yc3QyNWw0UzNzYXpHZDVSNFRi?=
 =?utf-8?B?WCthR0JRZFA1bmQ4Z3c5Y2lnOFE5QzJYUFpvZGtTL2xkNFg2TkJvdTFVb3Jr?=
 =?utf-8?B?aGVZY1hsdVNEUUlVMzBYZ1E0Tzh6QVlkV1N0UExENlpkM05vZTE1SEw5Q3Vs?=
 =?utf-8?B?emZtTU9INCtaa0ZBYmROOFl1TW9ETVVQNm9QdjZwRUtVODB0QndRWCtCZzc3?=
 =?utf-8?B?L2NYelhQbWdaZk5PYzVkNUo5S204WWpIbVc0cllIQjErV0hWV3NuR2F3dWUz?=
 =?utf-8?B?Y0cvYU5SL25xQ2dJU2VDOE5DeStrRUVXR2VlMDhwb1RoMmhKRUxhVzNMS0h2?=
 =?utf-8?B?Rkp3WUJOcHZDSnllc1pJZzNxb2lFNTVsejZENHdxRzY2TVdxeFBDYjZuSmJT?=
 =?utf-8?B?QkcrczhvYXpTdUthanBHMHZxc21tREJ3dUJYeEFQcE50ZkRDSVU3V3pjUWla?=
 =?utf-8?B?YitSa2t0SUlnK1o5SVp3Sm1xYU96a1B0M2hHY1pIRDZ4Z1FnL0ZmbTZ6QWlG?=
 =?utf-8?B?MzRqeUx1SFZOeXVqekk3OWNIRWRtZ1lEUGV2cFZPL092ek5UajBrV3JpVkJh?=
 =?utf-8?B?cU4wcVBkNy9Ua2RZaUhnc2I5TmJYenBsU3lwTGJqU2Z6TzE4ZWhibFlHb1V2?=
 =?utf-8?B?TWNIeDJVQkptZVY2UjdIT3pjcktZNmFhQTBaYTFUeFJIQ0Iyeis4OVV3MEov?=
 =?utf-8?B?c2x5YTI4Mmhvd0tGQkFsd1d6c2tHWlFBMUxzaCtUVm5vaHJlMXZQR0QxM2gv?=
 =?utf-8?B?ZllkYkFaTnlZeThpRGRuWjRFVjBwZDV3TlB3QzVIWmppcUNvYzBZWGFDZTVD?=
 =?utf-8?B?Rm15K3F3dFRaRnpJWnVsTG9WTlVPRHFHZkpHMCtRTFd0QjlkbzdxYmY0Wmhh?=
 =?utf-8?B?M3RuTDdWRzRvMXg4SjlkV3Q2cTdMVllXNm94Znc0SzVNdTFwWjZvOFRON2RS?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9ba04a-22d4-452e-eea0-08dc58f1034f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:58:54.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUz+1ZS4bSytAlRncisLQ5FYwW9DkvWTBjALoh2ifTm4R5bu0Xue/VyAAzL80DEgbmZuLktKBQyF8V0SuyhHzpklyrCB6DFpIv3DU4Q+lvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com



On 4/8/2024 8:29 AM, Mina Almasry wrote:
> With the changes in the last patches, napi_frag_unref() is now
> reduandant. Remove it and use skb_page_unref directly.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

