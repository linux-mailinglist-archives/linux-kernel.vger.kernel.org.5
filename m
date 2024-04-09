Return-Path: <linux-kernel+bounces-136198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FF89D0FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C381C21FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791354FAB;
	Tue,  9 Apr 2024 03:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Stoe/rgH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7654794
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633025; cv=fail; b=qhi61qAKIu9P4eYSMYR9JG9PP34avQN/I1eJk1LWpa0a1T1QDZTUeRXsLwbF6cjlrZkjqjt3GofpZgCHnIiVbTMVKMso4d4NtK/miRyqHV2lccPECOdJ0esbqfPd1y3URGaEXTj4Pxz+IkrFp3yGr4bWugfyFpUsOLJQUKch/pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633025; c=relaxed/simple;
	bh=Xwws8Ot7s9/LBO30qMq3MBFZ40qUjDjkcdn4Kp4TPWA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Of7Cs+np7R3M2JTl0bfB2aBvXHape1hX7REo8a/g4lUJzwWkPObNArKtgrixYGeWDqV8cj/g6NMSh9Zc5uAtcAU+jQzbeXd//lymAYXVRZOEm2kR8gzHMHXeBVwG+Xg3D+l50XH4kPUAyaHIhU9EvFNJ7mmDB4Tt6N7fzti06ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Stoe/rgH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712633024; x=1744169024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xwws8Ot7s9/LBO30qMq3MBFZ40qUjDjkcdn4Kp4TPWA=;
  b=Stoe/rgHMlIjJupDut+qMSdGJITbAZciRw1knLT7YH+lq5pEQTa7bN/+
   VJnWUMWNYfU8XXlz283faiwWQ3Fow1iMGl0BtnfedHcyayILlFXGqaHqE
   BV9HqkQBprXLWEZReCEAXlrqJbECIKgCL5qaL4NAlIf5NNZ3OpugX2FTR
   gPNDZvbPKO35ussPEMsF7GfRb5nUB/fKa8n8L23BiyNzHJo06BC6ASuH6
   bTJxU6uqDJA6d0ICReA7YqERiGr+0QZ4YQwfWThBLnxu4y8WLTAZ+4sH8
   dmlXlouwtQDXdEz0cEdVE6Dn60HXeYhGa7R7vHaaWWPbVvsDSE/ds+IlM
   w==;
X-CSE-ConnectionGUID: kM7TaYteQ8uzHcwGCgU4+w==
X-CSE-MsgGUID: iA1UpJWWSRKVnRWL4S3Cwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="33341180"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="33341180"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:23:42 -0700
X-CSE-ConnectionGUID: RaqD1c1gQNe6GgfIWUFVjA==
X-CSE-MsgGUID: u7H9qAb3R+2oHStdFj4Eig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20142007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:23:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:23:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:23:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKycordsIIv7R/5l/uqdS8l62nNy5BBY5rozesgj6+BHSEcHaTE1CwpCHk+jLcfv0P5Mbh/bSPwlJ1sIfgXtXNmKByif2qRCwgfeKTap37dXi0pZQKblMSYVMW9NyrvVk7/SvWCtnF9Tg471uLTjIWyA8F/5U7u03GyQXy2YouIKqLcONrtlWhSmiLKzFgv/gb5BrA6JVD2FPOIjRBrJuDjXFo87MyYToSFMy789g1HYHAI+D5kKU/wxrXggTfR5Z2Xw0ofW1nqDshYEkyg60WQM4JPfRHfP+C/8dBFHuYx561wIGhrZVhRmBfmkk5OookBK3b6DNZrTqYWJLSoerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sisN5cc6pXQcSybcsK8sD5Cb5SDZtfQfm5gATSatZV0=;
 b=m8ZU5b/46BAvlZRbW2Bzm9IWo8dDw7+PeNd6m7E3287lyqXNVjFnb5gxZgaiUHp7dsBs67Y2lQkof8jB8RJA8c6S51Y7ZGAoMcbyNQwvMumAUGwT4g8PziUG3at4HZCRshmalS6zSQbLVtpmd1tEyJ4AhuRlB79M1XxNHsXWNfLzyBpNLMmPXhkR5Vmeg1RJlHo4NFJf8WCQ+RMrLN7/PZ3LRCN4kb/WpK9RQX9agwnDBfXMFtOfj56cUNlGTMX3cEbPzSqkbReal+WJiiEvMBb0mJeXLTCEUPn475D6+O8WZis09TVJHYpvu1sDPFVa+sL5bHIK8ru+iD8QS5GmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:23:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:23:39 +0000
Message-ID: <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>
Date: Mon, 8 Apr 2024 20:23:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/31] x86/resctrl: Allow
 resctrl_arch_mon_event_config_write() to return an error
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-19-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-19-james.morse@arm.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuQtqwdWA6SytyLg8Edcr+LM7+df9WYLfZRMDWF1OKmRLSO8PQwqUYefgdkNIIG16KZ8jMRN1yZy/XyeE5WP8zUYaqx4kWUmEkmYU0SbaqAxC9RMjDG+gv2TtnsObg1CYkYUeuRItY1qR1aL5W28Leso3q5Q0DNLX1+4rdeOH7sIFCyKup3wxibjWmNrYRys0FYO6y+7HFg5RtPTJIW6Nqi4O6CL81ynwWZLjQgA1x8kVPFrfCZwqMe1p6Cuz6zHkAX1Q6j2OELNtDIRpKMyopR32+Z1sJhCeqIQ3pWXyO9VB0TV4tdF0xztBVuBspbM7hk5ginuG3P9xLPIMWYy57jHhDu6yvRD2rvEi/mvBb8tVcoh/ftnv8P0oomP+477CCo/easnsMKUm1FouTt2VLgOhh466J/ELg4FJF9NapuJnjtNdI4yTIj8n/rg+bMGJgqfk8DJRYfgRm6OuHhrCN0t7hXnrNzxX9q74FNB/NEtI0vGffcWSLRKTMztOdm2owc7jbGd3UCh2dq2sykHXHPsc0rBmpDOFmJOFPhh+l9RYYNmLWVuap7gxjCVCkUr4AMFDH4+T41L3374sKcf03wAVmdlL5U0f1yRV0cQTF+eB/3I0VA7hzDtM88gtcjpmoU2/nc1e4Az7/FXeBrgzCuZjpT55/DoRO9ihvnpxlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWpndXlhTW1GeE5IZzkxaHRPUFhRREI1SnBTS29pMElBM2xTV3VIYTNZaE0z?=
 =?utf-8?B?dTMxS2RkTDJmL0FYV1VES2VhWnNqUnpCSXU2a1p5dkpIM2kyeEhvcmxLcXZo?=
 =?utf-8?B?RHpOQ3IvMmdldytsUDd2MlBPZ0VCVkI2OURBQVgvTng0NUVlVG13YjRuczZz?=
 =?utf-8?B?TnhLTUJYL0ZxME5Na0MwZzR3VkY2WGxjZ1FDa1NkWDY3dE5nNjg2Nkc0L3Ix?=
 =?utf-8?B?WHd6eGlIV3JVR0FWR1VoUzJnTyt1OUlhQkVYTDUyOC9Pb0dLRXROaTU2WWM5?=
 =?utf-8?B?SytjK09QREJpMWwrZ0ZJR29LazROUHV5bUQxeVRqMG92RzI2Vi9jOFlCYTc0?=
 =?utf-8?B?VEl6a3NmSUpjZ2xRUjRzUVMwNDRrSFlXWDg4RVJnY29JMHZGaGhCekZWZSto?=
 =?utf-8?B?ZUFtZy80eUo4SkltSEN5bDAwT3hFU1g4QnBLM3hMUHRPOWVRb0xXQUVJMERa?=
 =?utf-8?B?QldMNURSTVBOc3A2cFg3ZTVCdTEvWEh6VXgxb1lYWmNYdmtReVg2TTBXUjVz?=
 =?utf-8?B?OHFGN29UakJrK2ZHRTdQdTczWHRaMGFILzZQbHh6WW9hM1RrWmRQNWRUaCtK?=
 =?utf-8?B?aDlvQVZlbXloOUpFRWVuNjEzYjJJalhhcjZjWjhxb0FlQ29RaklOUVo5RCsz?=
 =?utf-8?B?WjhrWnhMUnk0QWVtbmNUQUZrU2VGUWRvVjBuQ2ZpK1Z1N3pkamFDVTRtOEZZ?=
 =?utf-8?B?NE1OeTRxN2RIRHVRUXB2L21wa3RxRThFdzBRWkdGTUQ2U1pFam80aklZNGRl?=
 =?utf-8?B?b0lPVlJSWVc3Z3JTTE1SYkJWc3Z5cTlHWmJ5bXBTVVlMY1ZZRFQ0Q2VWTkFy?=
 =?utf-8?B?TFBQQWRPaXh0MmpkR29KTFhXZ3hxOXJKcUgyQnFPVGxGNlZpQ1pFbkdhcEVB?=
 =?utf-8?B?VHJEYlZ6TUtxVEJWeEZkeHZFU0RFMVZ6UUdjRldRR3RTNE93SnR5R0x3SnVU?=
 =?utf-8?B?SmJqVmd6SnNISHR4VGwrUFR0c0JmL3k4Zmx2VDBWUk1SV21JSDE2czJ4U21R?=
 =?utf-8?B?bC9vWE9HREIwZzdTdEpCc1BaaWhKNGxjM29MS1NOVkZrSGMzWTI1aEFwcXVY?=
 =?utf-8?B?VlBOVUMxZ3JvV2Jnc0ZFYm9VeE84MW5QK280dmVBS0JPZDZkcjY0Y1Mzcy9k?=
 =?utf-8?B?S1hlb3hjTHRvMkpVZys4RXllbzlTVnhhUXZadHdpMFRFcWltLzBiOGxkRFhO?=
 =?utf-8?B?ZGt2MTlHaVgzKzBqVHVhbElwQzA2Y1lKclBkMHN0QkdaMFpNY29mTFVEanlN?=
 =?utf-8?B?NGw4Mk9PUmhtaFNSdDgzSmZjTU84UzZwWDNhMllzZXNYVm5qcG43dnorSnFW?=
 =?utf-8?B?eG5ST2tTM0ZmY0ZoQzFPWTZOT2dPcGlIMWFJN2lZQ0tzSjNpd3NIWU9EQzhN?=
 =?utf-8?B?c0Y2RExaWEpubVJtaTRJcW4rZXl6MHEzL2pQUGkrdklqTGZTMHB2UnR3eUpK?=
 =?utf-8?B?OUtmemFnRFJrM2NDYjFwWlNMVTJHcG8zNERLTnIva20vL2RFZjQyNllQdU5X?=
 =?utf-8?B?eUtMQnJLZm42bElZY2JEQkViNHBFcTIrdmVXSEtlaTU2dVZLcVcxakJVT0Ev?=
 =?utf-8?B?ZkNFUnU2WTVkNFE5ak1GS3VRMDh6dFVpeWtxcVZEM2puVm9jSWNzOU9NUkdm?=
 =?utf-8?B?SDJ4MXZOVk9tQlBBbFBZRWc4OWFDNGI3aUYzTFBwMWhtVmZmNXlBRFFOT3hz?=
 =?utf-8?B?QVVHb3hBbFZYK0MyeGs3S1lkbGFIWWg3WExmUVIzVHZyQThTeDRRcmk0Qmdy?=
 =?utf-8?B?d2JQVzUzY0d1cmdoeHFtZHFGYjd4K2VOUTFnM0tETzdYdGVtM25VZHpoSkFB?=
 =?utf-8?B?RzlwSXFTU0s1SGJoMUtVNXFyb0xNUkZaVHF6eUtTOE1Jb1hjUTR6VkVNakU3?=
 =?utf-8?B?VmpaR3Y3aEVOSlVFMDJnV2RTVmZCb0pnL1NOeTdDYzV4aGE3SURzVVB0QjdZ?=
 =?utf-8?B?bUkzS2t6L0lBQTlGdkVUSzM1TUQrUkt1dlIvUnBmWE9DNDIyUG15SUsvZHpa?=
 =?utf-8?B?M1JsaXN1NlhRNC9SRE1jbTd3VGpWNlcwZWsxb05Cd1JYSGROVEZRUVNNeERU?=
 =?utf-8?B?RjlMeDdMMzc0dHdmYkFrTDM3WmJxZVp5YVROekI3VDFvZ0pybUQ2bitjRWgx?=
 =?utf-8?B?ZWY0RGNWZEh6S2g4c0RSODE1am5kRVJseEludy9EWEJNN3BPRWRVRExPUzdT?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a001ba28-1019-4660-6c0d-08dc58447315
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:23:39.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv5z/M6HOMp/5kbHDwEde3sxs+HGqgitkvaIgu9iObUlhdrVVZcJGQThJr59aGOamusM1PnwIrFYPz9Ir9DzfEvBNGcLdgZN1e1E4omeb8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> resctrl_arch_mon_event_config_write() writes a bitmap of events provided
> by user-space into the configuration register for the monitors.
> 
> This assumes that all architectures support all the features each bit
> corresponds to.
> 
> MPAM can filter monitors based on read, write, or both, but there are
> many more options in the existing bitmap. To allow this interface to
> work for machines with MPAM, allow the architecture helper to return
> an error if an incompatible bitmap is set.
> 
> When valid values are provided, there is no change in behaviour. If
> an invalid value is provided, currently it is silently ignored, but
> last_cmd_status is updated. After this change, the parser will stop
> at the first invalid value and return an error to user-space. This
> matches the way changes to the schemata file are made.
> 

Is this needed? With move of mbm_cfg_mask to rdt_resource I expect
MPAM would use it to set what the valid values are. With that done,
when user space provides a value, mon_config_write() compares user
provided value against mbm_cfg_mask and will already return early
(before attempting to write to hardware) with error
if value is not supported. This seems to accomplish the goal of this
patch?

> Signed-off-by: James Morse <james.morse@arm.com>
> ---

..
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8a7367d1ce45..6705d7960dfd 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -200,6 +200,7 @@ struct resctrl_mon_config_info {
>  	struct rdt_domain   *d;
>  	u32                  evtid;
>  	u32                  mon_config;
> +	int                  err;
>  };

Please take care to use consistent spacing.

Reinette

