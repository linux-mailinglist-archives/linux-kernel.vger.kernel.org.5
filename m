Return-Path: <linux-kernel+bounces-127884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFF895239
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024B11F2553E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6CE69D27;
	Tue,  2 Apr 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILUGu5K2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6142032C;
	Tue,  2 Apr 2024 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058906; cv=fail; b=IlyUREkF+8LFwIYt4X024+refHV8npa0jrUSWL98wb+CvUNcB8ym8EkQNirt+v1VKjLjvNzMU5iMzwDWNIbPDNjezry9xVBnTTfhuZZ88wfDoZHAhtU/wFJhSU33fHr0HUb2jVpWkcgn8SXGw4IkuEz/W6x+c7bRbpSqmqg2GMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058906; c=relaxed/simple;
	bh=VB+T9NvCLLR2uYxryYUbVpgB6M0iYDUFflS7Hwj9DW0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZl/zna7ikJVzGKWkKo3RxEfsAtSh54EA0oNKijpzv/NWJ4YcVbkDw9DZFqtI+jOVupit6rXMRpN16aCYsa/WblLujSowXssi3BgslJROvTVsOLWF9I8FSRoWTWhOxG5AVwSwL8SAiK2234PxXv9TW8L0Lfv1cgWSmPMmrIZoDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILUGu5K2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712058904; x=1743594904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VB+T9NvCLLR2uYxryYUbVpgB6M0iYDUFflS7Hwj9DW0=;
  b=ILUGu5K2TKzmfYd9Y0xNltQ0N7pSNojnQMsw5otJvS7MtMULzQy/RDgG
   6w62UXZ+KnwoSU4TeP2lserWzbzixShuUeXE6oWL3/f3WQUvF5zzoesVV
   gp2/RAaV1eMu4lwpUYOJkpIDIEGpnnBjUrYON85/2r3Jwh0mHjJGO7UIP
   kJhBnzz91R3Rb4f2BHvmanEq2foF+8TgTuOCYXnvXnQ5VXT3/d+o9Kh1u
   48gIXFCWYGiteUY/9LbEx5LyuT4bnSSX6BX39AubM3+VRRNuPGf5BGKno
   MhENN0Eyjjyb5Eo7Y5xuQCL/aN1U/WJLL9KFSDehmAmWpmGZQ/aoRewRp
   A==;
X-CSE-ConnectionGUID: Hjf89ftHTBmZxGK673q6Tg==
X-CSE-MsgGUID: fWaD6YrFQJ2X7DA/JBQi4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10186569"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="10186569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:55:02 -0700
X-CSE-ConnectionGUID: p10IpZotSji3/KFriwlurw==
X-CSE-MsgGUID: /e7Zl9o5Rwac9xumeorV+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22730395"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 04:55:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 04:55:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 04:55:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 04:55:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 04:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+EDWWiwP3eDjbr/DnrtNFoG8mJYuDVAWXrMmwe624BqU2f8P+IzEiT+yIQ1jc/TcYaaQIzjZW7L17DSk407WrjSWD/PNYR8UQr7z1SL3QxCpyuMZY+en0q5M7BB1A/eSNAKFBz+VlgRsWyccjyd0P1lQxfhZ8+Xknrd2FId+IeJvNXAZRXIs/Y6E+dgoQ6RhmxGolz7nNsH2wl89JZ04/FIVI1O5NoFV1+OZpgJwlMZa0YC4opEaXRivNiSu52Ei2G3gPPPBgfS+dAVbWyElo1Zj+x4MDZo3xTmIfKcRHWkREWKWxTYABLLM2nyHBffISZca5aO43ANhaOlOVmveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2tZ0QjBf63rnS1xUedjI/DT4qXvZQpgcFoYnGCb3Qs=;
 b=UWcho1ZIbApPuujoUYqGE77StMKKkNpGCMpWS0pKW7mvYQqdzyu7nA8dbd5DekCGJLL9dJa/uMLUqix8JX8dvJHA4L4Rk7nOiqFWTzomhR1cRJDDK/EP9vFkUXPXxV6prhQ2F/vaZBpEmqHyE2N74ht3SBn7VcfXYdlbrlR0u8aYnpFi4gI2+s2r/V2zfkNxcQQBscn2BObdAYeIHBhKbu+X9It4Qtb32LwQ52kAplMjWXpGAEBXUosVVhtUAnsZPsM8OPZWGEnkOP+oMr07/N/jSA78+CfHl/kB1pWCXect6+5gMVikcs+IsCE4gaRuRmdYeOJEDIazd5WKMBMIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.25; Tue, 2 Apr 2024 11:54:58 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 11:54:58 +0000
Message-ID: <912d1f9f-a88d-4751-8d91-b82a75f82a32@intel.com>
Date: Tue, 2 Apr 2024 13:53:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse shadow
 warnings throughout the file
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
	<0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
 <20240329170000.3241460-3-aleksander.lobakin@intel.com>
 <20240329131857.730c6528@kernel.org> <20240329135344.1a310f31@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240329135344.1a310f31@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB7738:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxhWUrihIZRr2ufbmCPyxQwjkcxLSWvDTGuyrbWrYwybg8z/fEoWnaWcGy85jtVXqk1olw/lD4clkFhcLK5FN7ZdfRBmvnM/HW4cm1+QASIMcLucTPm9krXt7r1wsS6L6jaBRuZMA5DLSY56nZtq2wA8v9cyOB9KEC1FWK/yskpF5xYiTVoSrteVoaKXZiAC65Lj/gk2qk0s7HLsPHUmtsIk8zZS6KMlpeR9l1zf5WTZMi43N75elpWVmmdFYa8bxIug48ZLmWLBs8itoRFbUSrk0A0Sihx+8gsAVS201RPAnYBW0f5VizlQOmHqGHFygM9Tng/CBwgID0lxcSJKXsS8siPWvkyjQsSeimD0sbaV/RHJCBC8sOm15hIFV90KhpTHHl7FZVmbpeb2vM0ymNuRw9jL0cG4DC5NpoII08XiYyE6mV2xZWdi2+EtRn3goGBG4wYDBdj2F34uKjobGfzAkMtqzwjKEw/VHG7ZdnPyF82m37tGJ2bea84OkplPjDJhITjgq4zT/UfWya7by22sKivYPLQbrc920rVaTGGVJTG2i68mR/RctslZHCehAoXGHyAoCRCP2omQGqPZpo8b9X92nh1bSQT+3zEegTcNn2ZRt5JaTmQcWDs4LV/++zpyneVWHnib6FskjcnQxkvMqjyyTRkfXp2xGf2Yogo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUlzVmpkNTc1aWRlaTFldU5JV3hPZXFEbmcwZjEzRDQvdGo4a1J0WEw4ZHFQ?=
 =?utf-8?B?cGhtVlozcGhzNndGdjVUczRUOWhlRlMvOXVNN3dTZ3pDWDFhMzdNeWtHOXA2?=
 =?utf-8?B?V0xWNEltK2hFK29mNW54dXVWajgxbmxYTEtSSnJvSDhSblN4Z0pMNGk5S3Za?=
 =?utf-8?B?djNxK1YrSjc5WUFia3BYaENMNDZhYkJEWmhCeVhxM3Y4RERzQ3FQUGZ6d05t?=
 =?utf-8?B?eVhwZW9xOW9iZTAzeWo5Q25Jams1T3FrVU1xN3c0YWZzWjdwSTM2YzNwRVVx?=
 =?utf-8?B?VHVZalIyQ0Nwdi9COTVnbW5ham9mQjdWNGNrZ0FhYnBmcDdFQ3MwOTVIbXRY?=
 =?utf-8?B?bmd0TThvTStZQVBobGkwaFpOQU5hajQzNU9JYlRzWmVrWkdkZytSVEpxQUpG?=
 =?utf-8?B?NDNQSmFEMEV2Tk11dlE1Q3BCR1Mxbnk4MHM5TWhjNU5nU0tRV0pmVTdIc09S?=
 =?utf-8?B?OEtOUktKajdMdm0zZ1djOUFuNFFKRDQ4Ym5xMUFrMVdMcDdMRkxIeUdDR0lX?=
 =?utf-8?B?Q3RSVUlzV0FMQnZzTisyaS9ZY2NXV2dpa1IwNG5qcW1sVXYxNHRrMElPZ2NW?=
 =?utf-8?B?MjRkbVhPNCtoQzBINGFWbFpGcmNNZkNNcE9qdkt0RHQ4RDYzZUdPVDFLR3B5?=
 =?utf-8?B?QWFJUnBhaEkxMzFkY1d6Z2ZNY2UyNFlJR0NWZUxwTVhRY1hIcUNydmRSV0Mv?=
 =?utf-8?B?UEtqVHUzTDFkTVEyUjgvRlEyTzVwQ1Z6L1lzNHdoWVVhVmdGalNEYUZrUW5D?=
 =?utf-8?B?eDZIMTRWNVpNL1hKeXRaWjFhWTMyek52cWpIdkJsZnVicWpHMThDajA2NkYv?=
 =?utf-8?B?enBIaVdZQVRKeE8zQlBIT0t2WjZNNURkbERGS1ZHVXFpbzJyajY4VTl3YWNt?=
 =?utf-8?B?SWdEK25CRjg0K2svUUpHSUhDc00zYTNROXhNbU5NYlNmcXJ3S2hhWGdNRHNk?=
 =?utf-8?B?ME1GWGcxMUJFVFR5RFZUckl5elJab1J6U2RKUnRaZXFLeHl4a3JxR1htRTJR?=
 =?utf-8?B?V0dhS0JtRXExUCtIMy9qOWZtZGtPdk5GeWt0Z2lCZW9VRzJhSGo5L1hScEZ6?=
 =?utf-8?B?RCs1TGZrc1BhV0I3cGtJZkhiYmhWZUdlbkZNcEZ5SFhuMWJ4ZlZ4Z1VCYjdn?=
 =?utf-8?B?SU1vM2l6ekVoV0VpYVRxYXNwdFdkR3lmMGhoalIxM25ZZXRZQjNTbno5UXMx?=
 =?utf-8?B?Y2NqTkEyZ2h1V3AzMjZTUU93cmdydFAzWGpvb0F5TjFRY3RzdkZiSFhiVmdD?=
 =?utf-8?B?SWFFMHRVYXpIUDdqdW1CRElJeklQOEFSc3dSNXdtdXFac3N2RDlOQVg0Mkw3?=
 =?utf-8?B?ajJwNU9RSUR6L1ZyNURYWkY2NjJtYWFnNDA2ZVNQUXphajFaaDNWeEI0dkZj?=
 =?utf-8?B?dDQrWnRkS24xaHBaOURuWU85VVllM0hSem81TTFxeEpZaXljby9oVlBUbFNk?=
 =?utf-8?B?UDRFVythVEtHMnYwUXZkZGVRVnZrYlk1dmVFL1U4eUE1WXhnRTRoRUdHT2Ew?=
 =?utf-8?B?ZGo1ZjJLckFUZ3dENHVNeWdkM2VQVjdUZ2ZFdlBNNlFJcGtxdlprRjlQRng4?=
 =?utf-8?B?UWpsbVZmSjNjZTQvNFlPS3hUbjlUeFpkVXlJckx0TjJkQUtpNlB4RVRkUE9Z?=
 =?utf-8?B?ZU9SNktGL0NSM1ZRQk9ja3p5cXFjSWY1a2gzb3l5NlRHcnRoczc0UFQ0VUZ0?=
 =?utf-8?B?dFM5czh0QUZmeENacXJHTUMxSkcyUzdBcFVzTEdYMlFUZ0x0TnJGTGFKV0NG?=
 =?utf-8?B?elQ1Uit5NjdyMHI4cFNCTTljMkNTQU9Yb1AvZmgxQ09NTWh1cGpaWk40dmZm?=
 =?utf-8?B?RFI0aGRKRjlIbHcvdGRXcHhvZ2FjT2NCZGhqVUt6U3ZCUTc2aHE0U3JncEFE?=
 =?utf-8?B?YXpjRk9RYmVhYlVYQWxmVEhrQ0svUk4zTEY4YU9sc2RlL2l6M0h6ZEwzVWM4?=
 =?utf-8?B?OTQwc2tRVzB3ekZKbUc1QTUvVW80S1hucm85M0krRjRPcXBHVk5CM1NyOTBC?=
 =?utf-8?B?YzBEaUxvZmN0THEzQjVnN29ML3hLTStmZXdWV2U5L296T2NJOFB3RWZTQWVZ?=
 =?utf-8?B?ZUJDV2xGY1hqQVhid3FQckJidGU1L0Z2a2pwVGtCWm4rcFhMUkZiSFlqcTJW?=
 =?utf-8?B?Sy9yOWlMb3FjdXExUDhMemc2S1RKVmNrRmVMdy9qZXBSVGtYZ0oyQXkrNEFQ?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c89d9562-1040-4f86-62f1-08dc530bb80d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:54:57.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdEoA/06d8Gy1brZg/ILuwbrnhBzXy++Xb4g1gHukJqKt9M1TBNBRWcPwyuK1TbkLBluiLZiatZ4Hu9e6fcGCkNmWAR5lrEu0rthIeuL+Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7738
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 29 Mar 2024 13:53:44 -0700

> On Fri, 29 Mar 2024 13:18:57 -0700 Jakub Kicinski wrote:
>>> Sparse:
>>>
>>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_res' shadows an earlier one
>>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared here  
>>
>> I don't see these building with LLVM=1 W=12 C=1
>> and I really don't like complicating the code because the compiler
>> is stupid. Can't you solve this with some renames? Add another

It's not the compiler, its warnings are valid actually. Shadowing makes
it very easy to confuse variables and make bugs...

>> underscore or something?
> 
> I'm stupid I tried on the test branch which already had your fix..

:D Sometimes it happens.

> 
> This is enough:
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 1ec408585373..2270fbb99cf7 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -89,7 +89,7 @@ struct netdev_stat_ops {
>  
>  #define netif_txq_try_stop(txq, get_desc, start_thrs)			\
>  	({								\
> -		int _res;						\
> +		int __res;						\
>  									\
>  		netif_tx_stop_queue(txq);				\
>  		/* Producer index and stop bit must be visible		\
> @@ -101,12 +101,12 @@ struct netdev_stat_ops {
>  		/* We need to check again in a case another		\
>  		 * CPU has just made room available.			\
>  		 */							\
> -		_res = 0;						\
> +		__res = 0;						\
>  		if (unlikely(get_desc >= start_thrs)) {			\
>  			netif_tx_start_queue(txq);			\
> -			_res = -1;					\
> +			__res = -1;					\
>  		}							\
> -		_res;							\
> +		__res;							\
>  	})								\
>  
>  /**

But what if there's a function which calls one of these functions and
already has _res or __res or something? I know renaming is enough for
the warnings I mentioned, but without __UNIQUE_ID() anything can happen
anytime, so I wanted to fix that once and for all :z

I already saw some macros which have a layer of indirection for
__UNIQUE_ID(), but previously they didn't and then there were fixes
which added underscores, renamed variables etc etc...

Thanks,
Olek

