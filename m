Return-Path: <linux-kernel+bounces-150837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F028AA570
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38D51C21266
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1FB199E9D;
	Thu, 18 Apr 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwQ/QTEX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40116168B06
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479046; cv=fail; b=ZEXazfl4QEdA0n0BCHYLnGVJLIy6UrZje9XA8Iw/BDKLup/LwUpH4Z+c7ysI5lm6m5v/dEFqd0UHvLK4K0frd/wFUpvOOyfsYHN3rmh7b8rkuINoj4XSc4BBZ6l77dFJ3CWAcXvxNcuRvKDuqG9WkAXmIiBk8CGL5rL7izVD1AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479046; c=relaxed/simple;
	bh=7sM8RDnNkVDnJSUgZsgOrur2vKei7UDmHQ36Ds27EtU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dvKtRMlBZEg8/46gNfhOPJn9Y79cytB4BwCJuiog6BQntMR0naeJbjScuiNqqFSGid3d4EY/0K90/CnKbGGTkTXfliNHBAyVJNn223lam1jcEt9C8QSjPpH5h1jGiVocKvm6uxvSkvJyTmJnRteMruNKWCfzF5+eAcmBtuDGl2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwQ/QTEX; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713479045; x=1745015045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7sM8RDnNkVDnJSUgZsgOrur2vKei7UDmHQ36Ds27EtU=;
  b=QwQ/QTEXSRAqMCqAwS1S+YQ9wJ4q447dbxA76lIeU0glmQCAtZbmpJIF
   6QOCo1c7oQ4tn1hWdyB0Mp4RPX7/kjQyN7sWjy33EZTEXVuxocX3kkIf9
   FRkh6hbWUsNQzvPL/QFOdtAkC0/Q50v4YEdLVTnQKJQgktgpwZG9jtSPP
   2BkRT4xsQhUPZ7LN3Naw/z0zH1encYXqhlPNQSSwujwrH9qFyJK3tzRjc
   IghRnAQx9/MPNhi3sXSYDHK16WJ16yLLzkP90OdEpYSSzrkdHKs92maPr
   mMZtN0KoLXlpod0W9Ej/n5EAfuxThUkoJAlnVXY5bM5vru1aGkPL8fdNs
   A==;
X-CSE-ConnectionGUID: t8wbXQssRhaXr5FYtZmPUA==
X-CSE-MsgGUID: vIsNPMSHRj2IaYnuS+ZP1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31539834"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="31539834"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 15:24:04 -0700
X-CSE-ConnectionGUID: sUN7H4kqTo6Q6knDh0LJJA==
X-CSE-MsgGUID: DOJqGLf0Q3uoD6BWcVtG8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27972631"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 15:24:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 15:24:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 15:23:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 15:23:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 15:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgukc+Cv8Rpyfn3gZ0whP3MbxtBVW/65ltgODhjy3eDIWXHSVhiGLcFBOdKna0z8RW4HzcSWHAx+P7LLRhnWtS35a1yrDydXRN+OIeiQd5MPYakpi3vNEVsx4gtl7wC5ADnfAaTf4PDx8ClTa4x2SNJDyIblnC7JVF/Q9PdzybVcbSTZUniy6kdfnnf0ORqwBZy4gJl23Z86Li0RWpE+dB4OeM7ddVYu3K8w3JzArwCx9r8Q/II1kz/5TEwGHxmgsLWTK6StrBc/Gv4XdhoGrl1iIpNs4dTPmUsfJKYWZ/eZ3XwxEtzSWFDFmKgcgzxMRTTqxWkunhcCJYs3mUPOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvRJc/1YyMjTnGrUTd9RATtKdtCLn8h1y9JqIBZCYAM=;
 b=HMvQdjdgo33PPYNpNG9HtbQ52ToDX6QWj5S5c8m/1akJDjM3Rl9wEaAQL/3LWmg3sfLVkaT0nF4Jb6TapglmV9K5G/p2L4RtN0TmLm1pCQut/nYNuYbbKlMCxP6kYNdNQpcDMVsYJziuaUkUApsaBRPj0XUYCEk0qWiOTM7PD6JcCti5Cc/ixTviWGBtdWa2x7gFbM8BE61lEVVbMX/aQyxS+8fYoRS97FGPOtnWv1Di5I6+ENXC/1+SMzShqDD8eEyIBIFBxBwisWntCXoxFcFrWiqxOcy3OlNZM7hWbTwdw4QE0U6Uj/twPZC+QI13aZ55368uW9xogTUs6pT0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 22:23:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 22:23:55 +0000
Message-ID: <07cedd93-a9af-4877-9c60-aeeff63f973c@intel.com>
Date: Fri, 19 Apr 2024 10:23:45 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
To: Tom Lendacky <thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Gao, Chao"
	<chao.gao@intel.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
References: <cover.1713439632.git.kai.huang@intel.com>
 <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
 <cd6bfe66-a49b-1af3-f329-ac7985a39be6@amd.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <cd6bfe66-a49b-1af3-f329-ac7985a39be6@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b930ce-b5a1-42cc-3870-08dc5ff63bd5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umyLRqUK7jjawTgee9ZV6ePHtbzT7gZ04Rr+xmFNt1Vn/fvarkNJO6DiJz65BMZ81dimPdv01NQ4BCm2E5mwgDiDCvuufPvI0UWRF3hGUrc5CTUplOjPlIn3qSszbNSR9yVe1SmX6y6fLHM+GrVksLvUZLokRwOucL8CNf/nWE1gHkSYnFqikf5XHFXG4yNGkDr6e/JlBjbXUEhoanYzWXqvhw63t4q5E0NAlRcyhF0DFFGwEu1l5RsBYbfH9OdUkO8R7bFmg0akTwOvXabn/eb1VLQKfH5v3121PiaOjM2NHsRyPOnf6l/R2ZAU6oSU8bsXNASDcFcY7hxuQ8qmhuS7wwFstv4UDEEOxZur7/2C4wDshSFHWbCaJ+WEzoBvLhXqK0BOt3YaF/qecSkJFJ17m5ANM6NdszOSmgpzcmdOL3eP+heaK/0LQiMyBflLcik4itfrk/haXiUOk63J7g2HoegDhN+cVT0un77juWu13XbzcP5fkanukh2ZL8IwJFbSQsOd2/byN7k9Kv5lF6m/qEH+wDU1nsU1/WEU8NR3Ir/UCJtiJpCJPtqB7PCRZDV2q1P4fHUkRU1vSFgXO1nkAOeLiu6D3oeSIRs/H/tDt6jEZkDjqBnsMv3sra+GkeB1BPCY17JIWwm6VcP3L4PXWF4jPtM0iDhnyPFHbVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZUS0ZkY0h6MlpQamx3SHdzdXJJVTBtRWRXVFZiRGE2SUhOdVcraEs4SXBE?=
 =?utf-8?B?Tjl0MlZ6ZDQxcUlCRytsV2phRU5oZkxLWk9XMUF0QnlybGk0MktSTmRKQWxt?=
 =?utf-8?B?WTdXeVJHanNLVUkvRDJWWVArR1FUTExEaENGT1JJYzNlNGMwU0ZVa0NtaGVF?=
 =?utf-8?B?MG41T0JwVXhSWSsrSGphT0hCYi84QXJrS2Rac01KS0JPK1UyeFlrTU5nWjJz?=
 =?utf-8?B?RWEzdWpUMzhrU2RaR3d1c093Q1d3VCtTYUczMjAvVmh6Mm1iMzRXWlhyMEdN?=
 =?utf-8?B?eG43L2hKUlZzN3hBSmhjUndCdENFMGN6M2VOQ2luMEZmaFlIQTZkcTQ1ZkRJ?=
 =?utf-8?B?cytsdVhHcnF5OXFDeFVIQStTaHpnMlVIRkUrenY1UmlkTHBzMEhDSFNEVnFV?=
 =?utf-8?B?R2NKaEgzdGlka0pZZ3dneHFvZE1GMEpVcTNiSmRpWnEzeUZOekFPODJLMW5B?=
 =?utf-8?B?MXR3TGVhZ0J2ak1QWE9jZkZKS3FaMmVVcStQeGZ1QlFpY2xxcWxXWHRtb0dZ?=
 =?utf-8?B?dTV4ckFvR1lWMkNXUURoQmVnTFJqaGg3NU4yckE3Z1VaTGl1SXB4T0RDYjhJ?=
 =?utf-8?B?bEl2OW5NMWxycDlYRUV0NGJONnpQa2pkWFM0ZkVqZiswOVhjZG51eXozQnZq?=
 =?utf-8?B?RWNDMjRzcGJQdzRlK09iK1ZvWjYxSU5LZytHcnplQ0E1ckJCZDhzRksvVU5Z?=
 =?utf-8?B?em9SUjFVQTlYSWtESlkyNGxwK0NnY0ZBa21yVTNnVTZZRFRaKzBTRlA3T040?=
 =?utf-8?B?MHdWWDc0NUtvOTc0R3B1RnNxMjNMbnkwZXkwa2RxU2l6Tis5bzZFYVR6NHZF?=
 =?utf-8?B?YzN2ZjdRSlJuUG16T01ESUhiS1N3U3hDTktFVGxxRHlnNkppOHdaSE1PSlpR?=
 =?utf-8?B?VWhwbElqNCtpNFVGWmo1Q1ZOdHdCcnlqUENmQmlOQTFycVlvUGw2a2xtTFFy?=
 =?utf-8?B?aHBQenJyOGJOQUZXc3pKbGtMbnRVaVFRMnVlZlRDWEhTUzJmYXZEYUNRNERk?=
 =?utf-8?B?RVFwb3lSRWtCMGZNRkorZmR3ZExKMUIvd2twTFd2NHM0UEVHZGZkeDcvblJM?=
 =?utf-8?B?SFJqY3RTcE9rY29PdVpocXZGTmcxYnREdzlibGhpck5SQXJKRjBEcTBmSWI3?=
 =?utf-8?B?eUlML0ZsY3dZb0tXYlEya3g3dTkzbnhLZWpSbkJqWGJqemJjMnE4Zmxldm1i?=
 =?utf-8?B?YmVpWGZnVHM5UzZ6SDlMMmRKNmZSQUpxTGpXSGhqWHhWcUpPTVJMcUJpWkxT?=
 =?utf-8?B?MGVSWE5TU29pbmRpbWw2SlY1QXFQV1VUSmJZMUpITGllMWZUd0lhL0Y3bm42?=
 =?utf-8?B?NXVvM0sxaW5MdmF1aFFyTC9WejMvQnJTd0lXTnVoK0swQk15NWN4c1p5WWxP?=
 =?utf-8?B?dVpjcDE0eGwxNFAzYm50cXZVTU9LbUJRUDNMMUh4S2RoazFlZk1nMGQvdmRL?=
 =?utf-8?B?RWRiL08zb3NPZ2VGc3N3cGpQSmxjbE1zYnFkYXplNjIySXM2SUpaSHdCRHhj?=
 =?utf-8?B?UzhBaGdYeVNVb2NCcXZBQW5PcTJyMGo5bFlscGt5MTg1R1c1K01iSURNQitB?=
 =?utf-8?B?RGhXZjZkNlBLL2dTSktzUkcwNGJ6Y2dacDdSYU0xM3NXai93Skx5Qmt5WEI2?=
 =?utf-8?B?VHpPblBUYzRHY1ZtY2w1OWI2OWdFUE5iOHAzNjhLUFVaUTNVZTRwdWYzQ080?=
 =?utf-8?B?a2N5UmFoQnlsdENZT1NzYWVwVnRvam9ycUdObWdxM01mV2JaS0QzYm94eU1G?=
 =?utf-8?B?TFdoeS85dkI0VEYzYjFlK1AyK3MrNDNoVFV6UUVHcjkyNHJOTllhUFFPZEx1?=
 =?utf-8?B?K3dibVVrVWY0QytkYXpZV0t0ajVnUTFzdXg2TW9xZEQxZDdCR0gwWEdjSlh2?=
 =?utf-8?B?a05oNU9OQ3o2SW05T2VjZEs4MytiNEZNVTRyYlk2dkdlelZnMDh3TklsZjlM?=
 =?utf-8?B?RnJyQ1JTTWtYbm5FNGxlQWM1SWEzTXhTdjlvR3FHYTJkcklmZmdsMUNRbjl3?=
 =?utf-8?B?cCsvemRtbVFrRTdPYlN3MS9lNG9DOGQ0ckpqUEFnNy82ZWdLSjZsV2RHTTdP?=
 =?utf-8?B?RHVveG5STWFZc0lLeFNVNkhqVWdHUUtlNjJxcXFtWisyODd1QXBmcTd3b3U3?=
 =?utf-8?Q?t7CDuDPHIfqZ3qJhowoq8/5bW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b930ce-b5a1-42cc-3870-08dc5ff63bd5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 22:23:55.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoFzXvtDVywYE41rqHizM67LK/fL5/kel9Vp9ii3DS6pFPA36ziM/hRULw81v2iP2y1NK0hpFWbO9DjCZ0EpdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
X-OriginatorOrg: intel.com



On 19/04/2024 1:47 am, Tom Lendacky wrote:
> On 4/18/24 06:48, Kai Huang wrote:
>>
> 
> ...
> 
>> Signed-off-by: Kai Huang <kai.huang@intel.com>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Dave Young <dyoung@redhat.com>
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 

Thanks Tom!


