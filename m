Return-Path: <linux-kernel+bounces-143375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC58A37CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A862B210B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3614152169;
	Fri, 12 Apr 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oECjtoEw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB44438E;
	Fri, 12 Apr 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956786; cv=fail; b=IqMt2JMjtC5/bqjArfou+cOJKLAXSgU457karkPtimYsX2vnHbso2BnfA6v8Y6j0eafJxm+PNhfOmh6qukIgdQW0qPLdSMOvhChh7DjAEp74XgwTIRAT0Q8DGIf30ubezj18YxiQmuiEkHXkckaSebmRNTIN0J7X63b0pgVw4RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956786; c=relaxed/simple;
	bh=c+qE6ODzoLIg+viN7fk7G1Kw7vIU2mdTj6xwLY4sea8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/7JvypAYVWG5WRgOvJIMgmoxqoT2TjQAB+TidKHZOTbNBSubfFZnr2iwaujB1I69kvCpKwl6rfO7AzmX5L2P2KEk20T7IgnvD55EvyC5DNqMnW1q9SWpGDA0AjlJ9QKsl6LU9AKwlOpfzcMjb2rE7aajJ+VVJswBl90Y03VTsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oECjtoEw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956786; x=1744492786;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c+qE6ODzoLIg+viN7fk7G1Kw7vIU2mdTj6xwLY4sea8=;
  b=oECjtoEw/jDH0Okx0cBFI3Cx6L8GcIlL5vtwF1BsH/NraHYdeEPcoleA
   ChLTrZcKwXrIyUKJXIhJWJ4PO5oiKizzs77uFB29Ihc2PCHXzJoPZRVWd
   lpH/xHKmbCdvGhMRNN2Gc4TcMCkJks/4zzXTyxDBWimVanL84ftY9KGaM
   zPIeH2xYdLcvgAbEMGCZw7jhgQ5PN6I8Y8tps1K6+6xMwQ43Cx9kO9r1s
   h+UzyC1QEXI1OJbaBBLB5I2IOLInllwQdqQ8I0YW7SJpdYT/6HyFF7nKG
   e1C7N0AjOZuK4rms6eSR5tsKdW2n5djakanV2aom4FXV7BqI5YlRdbE1i
   g==;
X-CSE-ConnectionGUID: CGhEuIX3QoyqY9dk0uv+wQ==
X-CSE-MsgGUID: DdwPM5hmRdy42OKYjSYOjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8346403"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="8346403"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:19:45 -0700
X-CSE-ConnectionGUID: Qy7XEYR3RaWGF3wAdHtbqg==
X-CSE-MsgGUID: C1URBrYCTV64NyUxVVTruA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21268348"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 14:19:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 14:19:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 14:19:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 14:19:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 14:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXqqzFgukHkmTwCoFKxX3D5wS4A8BEjnTvxpYg9moSpq95L0GsIOgZ/1skESMgy3xk3Epdfbd1344VtnPggBp3EjcxkbwAjt2igKdFaGujYw+Z4DyCS5yRLA5uEU+pPJy8zmTaeF0OfBXyxqnWlWDf/AQi7mpVCLJgPXglfoKAKJwrkqZbtReV4ZgOGUjWOPEbP5zQG12qhTB7H0DmGns8j8OmHd11BuOh2OmR0IIUfhNnUH6N1YbUWqppzry++1/vQFHPLX5kc+ec2fa30EOLDOsr8WeUa/iWDbIlUN2KYZ/wz25RNOrvC0MtTKiVNk1rzs/yuLKK4CBYBinrg/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1cnE2FxzESX4c1N+lh4JAhK57OAeZFDELnVtb4aQ1M=;
 b=SM8zKH+Iv7eiXxybHlHHtSuMhacAboAjCEvB+keG5cagQe33BqI23AJP9CsA6890PYsrB/11pZhaFkRgHAf02sNerhRgshaV5KEOIUUon6a8myfLFY9rRnN8vpAiL1jb0PIBBJZfU7iJx+5WP6UKH9IN3eCyibzNZnsVkxM1BSV2aQ65Cmb0/XJ2SgCAbZAdSu4zckSB4Q4/n0R8tN5sza2rdnbAwY8snw1C8964GYmW0yVLSNAup6k8K+r8sv+HjWzWyfqCXMcUi0XBMTLG9o8+hriE+cxNPA6/xZJGAL/SPPHL8d6FAi7fo3SasZe3rwgkbpbYh7Jq+R4IybnAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Fri, 12 Apr
 2024 21:19:40 +0000
Received: from PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::c8f:b939:aa0f:717d]) by PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::c8f:b939:aa0f:717d%7]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 21:19:39 +0000
Message-ID: <3bd08423-18cd-6e12-38ab-4d9656c9ecf1@intel.com>
Date: Fri, 12 Apr 2024 14:19:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next v2 0/7] i40e: cleanups & refactors
To: Ivan Vecera <ivecera@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mschmidt@redhat.com>, <aleksandr.loktionov@intel.com>,
	<jesse.brandeburg@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240327075733.8967-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:303:8f::29) To PH7PR11MB6449.namprd11.prod.outlook.com
 (2603:10b6:510:1f7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6449:EE_|DM6PR11MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: d6839c63-1307-4522-0ce2-08dc5b364355
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UDwHM+Lsw4HUwemiyBohWh8gH5CZmpMm9rNK+aMIq816cY27tDjCmU2XYWAhujVIcCmTPYvrsm3yWgqjkH0iCejU8JS0vLPgEptB6X/1gln8wofGXn/5QJDnyS51NQUakljUuUbgC8aHsGyCxRtwYJzO7xtVKTVJYj4H7Ma575OkhvwGnOLZj9a5reuk8YTxpGBfqr0RjS4CuPpLNKajz1EkFgD7hqTPb8P665iimYSrs8w07/yxhVzibUkR7ysiqz3lRJZeAPL77GSJhRN1LauNtvm4IesEFpM+M8+IcOBsnsR6m1YwkVxBcJv3FsvBredpzR1n4ZwjvCVTDsrPZ3bDYbBLMnQR2uqBRi4dKzJ4A+bhxjeypDu4dosgEwoQxptE1NV181bHd7HOT/kr6/n81Cju/1Rx9uLisUvyKwOVF6keiVQZ5+ueHx1uR7EWaQSu1z+DMyI4dbZWXQJKqFs5csH+qMtEuaTh9ogyXGR7F8QMKskyG7Wl50j5b4A8c8a8Ie3WjF7dBJWOo8s/jxilqpR5Axjrp7ciTcxTrO/KEu5Jmab0+FUuFLaxgZhyaIesKxyb40Hl4E39fOvsx9DXdVZDPbKN8nKlLwUx4PgSVXJbd8P29mOSIwWYkOibTYJqOXQhR9zm9/40XgnTZPpL1GAb1kLCkzLJLSPiOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6449.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFubXQ1QmovZ3o1MXhNeUJ5bzVSQWJySGJTdng0bUpFbE9NcCtEdnozQTBP?=
 =?utf-8?B?UGMrL0pINXhDY1Fnd1Z0VlV2OFNkWk9XMDRRYkU3c2RZRDRZZUJ0SHRtTXNM?=
 =?utf-8?B?YkxoTlJKdU9jaFdPRUpGY0NRQXpxb0VuRytRdjBMSHJ3a05wenJsTmROc2Rr?=
 =?utf-8?B?bUlmYURxdG9pTUtKYnN6eXRNVVA1V2YrYlJPOXpmendwSVhSWUJKaHMrdVZB?=
 =?utf-8?B?L2ZXdHQwbHJwUXBKbFdYYWI3ZVhUaWx3dzdsQVp3dHJXa2wwelhMcndaTG5j?=
 =?utf-8?B?NWRDempvdDNnc2QyYWdTTUV0WG9vR2dmNmhUbFcyLzhtWklKMDAxU3FKQmx2?=
 =?utf-8?B?RmV3blJnRjF0ZkZDUmJjd25kWFRIeit6TjM0c2xPK00ydUQzN1oyUUNSTXlw?=
 =?utf-8?B?SnkwUmJKTGlGeVNwWGhDaHozQW9iL0RKTm9yWmtma1hIcVFlcVNaTytGemV4?=
 =?utf-8?B?STZIV3BCazBiOHVnTGhWVzV5NG5YWFFMaUh0WlJVdXNoUytRWjU3dlR0dmpx?=
 =?utf-8?B?d0pCbFRrWXRwTDhUWnZDN2hRdUlwSFkvMTFUVmZ4MkVMM1dMVlhCMG0xeWNE?=
 =?utf-8?B?Z0Q2ckRwWVRqcjlJR0QwVlljM2RoVzJyRjJMbFpsSlZOT2swWi93R1NTbHdQ?=
 =?utf-8?B?V3lWNHl1S0JjYnRoSitYMm04QTJCa21BbTM4dWV2TXJjeFhtb0dvanpzUmNQ?=
 =?utf-8?B?UDN6d3pidGl2UjRkQnl4azlEdlFRZzlCMkNlK3RFVXpaWFpScXdFQjBUZXBN?=
 =?utf-8?B?QS9LOThNMHNsaHNLbU9Bd0pITnY4SGxjZkNtWXJJeU1EL0ZuaDJpM01iZSts?=
 =?utf-8?B?Z3l2ak16VEJ0aElNajUrbDkrZURKRjJNOFIvYWZ0ZmoxaGx1ZlQ5NkZIN1ZT?=
 =?utf-8?B?SGd6clYyeHc2YUdzSVVLUEpaM1M3NmhQVGZ2NHFZNDhhZ0pDamVlMHNDUXE4?=
 =?utf-8?B?QzFyL1FZTWZaWnBFQUIzQUNIcmpFbCs4Wkh6Z05nVWJDNDVZTlpUZG1aUnov?=
 =?utf-8?B?WmtlTmxMS2RNdkJCR2hNOCtaeFNzVWliUm9ybThOR1lyMm50QnQ5d25DRGx4?=
 =?utf-8?B?b0w1YjdZR1MweUZjdmhVUnVTVkk5Z3g3V21tRDYrS1JLWVcxNmRzWmNFZ2JN?=
 =?utf-8?B?cUdibE44WGJWQ0dLYnFIMDlkQWJzM2pXNmVyMnRrSzNwNGJwcWRzQkFCWjEw?=
 =?utf-8?B?eHRmaVBrVFd6bytEb0xhME5MSFM1SDI2Y3h0SFFsRVNpZmduNmdDczkwVVQw?=
 =?utf-8?B?Yk84ZmxiSFJYaUk1elRpN1VLc05peGFVZXB5THk2d0xSSGJscEhVelc5cE9G?=
 =?utf-8?B?Rk5ySC9sMGJSa0gvSmo3T3ltTXVsMXRoaktTK3ZVaWVBUFhEbzloZFBiNzhj?=
 =?utf-8?B?WlB4eXcwb0RFcVFyYXk3ZWN5TnlSM3k5bUZkVWZjazRNbk9QaE1aK3l0RjRL?=
 =?utf-8?B?TW9yc1E4UzRoS1RTRU1zbWNvSzlNNHRuY01iRUlMTUttY0YwRFZFVncxaUdm?=
 =?utf-8?B?a0tCQ29sV1pDRUw4UTdTdkZDVFlnT3RLNDRBMkxybGhZUzFseE5XbmJHL0JW?=
 =?utf-8?B?cHNMMU9IdTJ0RXZOUk9CdmJyeGlRWGxkV0M4KzFEY1QvdWxYQVFNQjU4ZnFt?=
 =?utf-8?B?UkYxQStFRkhob1lJRFpPL09ZUEpZV1FZYS8zU2JjWUFPcXpkSmdiOFI3bVFM?=
 =?utf-8?B?bWtNRTRFN3NwMnJxN2FBWWZRNEFJbjgxamJQQjVoTHVNQTNta3VhRmlMNEJs?=
 =?utf-8?B?SlRUeXhDQUFCK1h2bVpwdk1yZmVianhPNlM5V2hZT2pFNE1QOWNLcDIvWk9W?=
 =?utf-8?B?dVpBSzU1L2dRVk5pSlNpWE9HT2t5MkE2cFVhZGlnZWVRVGsrbGgzdEFVNGFK?=
 =?utf-8?B?aHJpVXM0eW9PMVlGT1pEWUJJU080bTNqZ1VDMTU5SHZ6ZWxtWEVkMFR2dGQ1?=
 =?utf-8?B?dXdFcDZyMDJCUlBteGVPWWQzakFNMWJ3cVE0eDlsODg4S1Z3RUlnZXJZdlFi?=
 =?utf-8?B?V3ZzTVQ1bkw2b0R5aHk4YTArcGE4bGE4R0FEbC9PMTFzeEE4LzBkRHE3L2VD?=
 =?utf-8?B?QjdiWUN6SHEzRGhTV2JrREcrQmU4QkRqQ3I2aHI3Qlp0VVFvREVwYkpONVVi?=
 =?utf-8?B?a1R1MWs5TUo2cFNNVUVVVmNlbEE3VTIzTjR6U0pKWmhFaE1CS3UwZWpWL2NF?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6839c63-1307-4522-0ce2-08dc5b364355
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6449.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 21:19:39.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxeozmfzsJuZu3+CmlE0aWn8DO8HUtaXXhQ8/O4lwU5ECRvZxLJEDm27dbGAksVYUt5ByEpMEDfNhlOlbcQFULWfknxWDW5GQ73l8FxFzJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com



On 3/27/2024 12:57 AM, Ivan Vecera wrote:
> This series do following:
> Patch 1 - Removes write-only flags field from i40e_veb structure and
>            from i40e_veb_setup() parameters
> Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
>            and i40e_notify_client_of_netdev_close()
> Patch 3 - Refactors parameter of i40e_detect_recover_hung()
> Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
>            in existing code
> Patch 5 - Consolidates checks whether given VSI is the main one
> Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
>            in existing code
> Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
>            particular and uses it to replace existing open-coded pieces

Hi Ivan,

With the new checks on kdoc [1], this now reports issues. Can you fix 
those? Feel free to send the new version to 'net-next' as our validation 
has finished their testing on this series.

You can add my

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Thanks,
Tony

> Changes since v1:
> - adjusted titles for patches 2 & 3
> 
> Ivan Vecera (8):
>    i40e: Remove flags field from i40e_veb
>    i40e: Refactor argument of several client notification functions
>    i40e: Refactor argument of i40e_detect_recover_hung()
>    i40e: Add helper to access main VSI
>    i40e: Consolidate checks whether given VSI is main
>    i40e: Add helper to access main VEB
>    i40e: Add and use helper to reconfigure TC for given VSI
> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |  30 ++-
>   drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
>   drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 +--
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 205 ++++++++++--------
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
>   .../net/ethernet/intel/i40e/i40e_register.h   |   3 +
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  98 ++++++---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   3 +-
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
>   11 files changed, 282 insertions(+), 173 deletions(-)

[1] https://lore.kernel.org/netdev/20240411200608.2fcf7e36@kernel.org/

