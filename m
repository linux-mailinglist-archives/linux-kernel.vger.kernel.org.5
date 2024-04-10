Return-Path: <linux-kernel+bounces-139427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE678A0335
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC7BB2472E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47EA184134;
	Wed, 10 Apr 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PV1BdBGC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7550168DC;
	Wed, 10 Apr 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787621; cv=fail; b=FN9ZYfgeRd76jLZlZ/Nc5b8qix/SAZfY5HfSgvgncAm69iWAVVkE2xYenqnCf+Psrxc9aLqhAGerWN160bZ2iLASWQA2mVR8/jzoWm2ysJqBH77S+EgqWTcECdLYoSi1+dsx1y6MC9ovp0K//O4O1Dg3ZArdRqoVhcAlcOMQTe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787621; c=relaxed/simple;
	bh=5PVb9Pb1X0xb2NBuNAs1Bim6OEHqVhei2PV3+uS/njQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lARwJHTTLlBJK3ajgqyOKsZ8EMY+3l4WffCemvpYRKygYUmahUaBSDNfwMM+60ZWmiCuyzIJeBkYzjJwvXZiteCFsj+LvqXwOwtHY3EvrklwM6IfmW73F1H4NN30IINOn7bfEAJGRgIZFKPECtzAhptW9mTkLn7RGKNcee6w0wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PV1BdBGC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712787620; x=1744323620;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5PVb9Pb1X0xb2NBuNAs1Bim6OEHqVhei2PV3+uS/njQ=;
  b=PV1BdBGCeVZjA1UlUXwzlqCgSFJG9EFF9WN4FTdb/1M/iTZW4VlLPj/n
   ht9ymtNxFvvA+q6Dc4/kHe63n8rujNXqEx6pShW0RyGEj71/7KlvnrZeO
   LOGRYQB5+o6p8+SV5JUPAwedI7PW357Edyf2uzbDguASxR0GFip5rBCjn
   Q+0qzNWitTgOgkxg91JpheGzpQbfG0NKlK9MxL2suVvs1o+h8zrXIHBre
   1yV0gWAi3oARrkiFZLir7DeECtIKC1HHDETCYn12pdls3a2m+IJ2glZb4
   8DqUSwqrqZWoo+3GOxNwR7xYUZLxvTSvV5dHTh+8eJ9eevX7Fbi2k0s0l
   A==;
X-CSE-ConnectionGUID: GBIHga9hSHyeK5WY+ioJhg==
X-CSE-MsgGUID: e+EBMOePRXKEfuyhPxTrxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30662552"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="30662552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:20:19 -0700
X-CSE-ConnectionGUID: 2AGw+AvESXyTkNp6fsE5HA==
X-CSE-MsgGUID: oEVxE4WCQlOUlXoQbyTeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25479649"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:20:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:20:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:20:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnHvcfugS9Vb0NzIL11sJ7SOn+3aOD8Nax2MEHSMdvcoLQPZ3RWZg99Dg+yWUx2IisL8TY+DTMCJEsu5InU/wQowW++uVFGu1EJjpbre9LXxxxzr39PwNISLNCWv0TKDylzV5UYGnDJ/IvNXeB4IgohniaJ+2SOHVMFoF/zgXf9xERAf8RoltHOEO2zHCbQ6T/2IXKKDFUh1UX85I5I8XbTSzCyCQaadFIrsWeu6AO7wkNqUSHeHbvnIkyFzyUNQoEC8oIk4+xBKQ2qF78NXQy/u0gCRBjdZDYbiNTqeQIdofeNTQRF+flH6QgD8Sn2EUdlRhJanGEXz9Lsl+0Kovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jIUqYoy6YUdbf9CDv7zkUq4wAE02MHjVeMHBmWhXq8=;
 b=CjKqMB0yAJTRznYg0q5y6DujVlmZexA5Q+fHBceKD7e+pWNSDmf9eFJOLvFBwedLCJ+8gRyjw4gd04zgznRY9lLOdCZ99BrpzwUhW8Aw4XVhMljtoUM6LFQZMxjVdgPtCqUcXQLjy9BgCef7fYxWuPYcSnwQ1uelCkhF4fn6WEkqH3gxU84b8QoGnuEWS29Z/mkXluMBPAhkJ6ZP3hQ+MHAEIsTN+xgFuOqsmpyotor3wCZ8NMdEE4CP6QlUElt9ulgp7PSLcnrvWUkdGckapfZGqPVgn3QQyk5ADnKZzzGeJLYPa7toMh9fioe1DVe6kbTM8BzHFgNFbtq51fhB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 22:20:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:20:16 +0000
Message-ID: <22153526-f764-420e-84f1-851006c67e76@intel.com>
Date: Wed, 10 Apr 2024 15:20:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: sparx5: flower: fix fragment flags handling
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	<netdev@vger.kernel.org>
CC: Steen Hegelund <Steen.Hegelund@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20240410095224.6372-1-ast@fiberby.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240410095224.6372-1-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6349:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43jgfCwanTOHtKWyTGYUa2pIZHOuBdkwzqcRKDfpY4uu6Jxo/VtLeIg6poWpworXG72bNlTG5plxVLNsPBDxVt1JM4D8OVrt4X8dZSEuIZdcRRDDgiU0LWqHMp4Axq8eTs0WMH2jPbpq0i1ogVFkStxiMuOOOsAt/LZNHk1R8IhWreP2GaN7pCb3wspkvokIQnVNMpNhANVkF6yKeTz/QDhPAD0aYySoSZE0EdsWH03fsQiQB7rppdDJAJ6HmreilUst9CwCEzAmr8HenDY1tK7HA3fxZT4xvNYacyzkuIinuUKWBGlUSNNzu/XyEjeLD4hYGDZeZP6EPI9H1DJPFWKVQmwVLLKxx2sUrqZBTpMmBQ2QEUI8R5x99pSNpMEpzvvByAti87xPyT0PRHiJvIVMZGhcajma74dm9KSCjY9NShjpBVqyqvHBRLVFHOy1nXuz4Kxq5bWCl2rIrqLy/i0mdlID7BcxJm7KxtW/FEnSDSj122cnoSCt/qEwOrmmDuR+MaI4TGIaG4MTnAFEtS9mgZzakg+FmDbEgqn4xEYZvtwFHMVuikX2CdiAcW1MVQZ9j8YPsgmcwHtiTHaXSkL+6S7NKoyjMyFz/FZELke6/EDGnZ/9CSPXSxS6YnkGiEpWQyDaqVnYdp9gMaj/WkO9nb2tLDexsegtEkOFcL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RklDeXQvK3RzamdNNkwyMll1aVEwaERlRTF5azQ1TitYREZqTVdVUktBL004?=
 =?utf-8?B?SEp5S3kzUTNwUTlRdGxyVEVyODM4eGMraVJNUTg1MG9OR3ZsSisrUHhBbDMy?=
 =?utf-8?B?cmUvWlBhZklGWFNhTGR3OE5iYWtrcjJOV3k5aHd2U2NsdW9iMkR6NlU3Umdt?=
 =?utf-8?B?eCtnb0ZmRGhEZHRxSVBLUlFqNjFZQTVxYVgwSmdEcEVQRFdNV3Bjcnc2NEJC?=
 =?utf-8?B?N0NGMTJKdmw5a1NPNEdKeXR2QnFIUzBTWExrQkRubkJGUEhtS3h5SDlCc3Vw?=
 =?utf-8?B?K2xWcFV2YjROUlV5cW95MW4zZnduWHZpVTA3bHZUZDl1cG1mTWdrOEo3VDl1?=
 =?utf-8?B?c3lmNDJKYnNIdFVCdUhjTWc2cVR1ZWVHa2EwWGRQaXQrMlhNZmh2WXNsOTlk?=
 =?utf-8?B?L3hoamQycElweGJGaWNDSmFuN0trekNEcUVxaDIyRUdkUUZvNnhyNVpzRDd6?=
 =?utf-8?B?c3doVWwwTEZSRUdrQ3dSbW1XR1htdFhEbFVycmROSHhFUlo1ZTM3bXJjcEsr?=
 =?utf-8?B?azlidHQvT0NMN3RmSCtySG1BbCtadXZwa0JoNWlkL091SW45d1RzS0hUSWhw?=
 =?utf-8?B?em5vZjRaMmN6YkIxRldmdUZBNHZ6S2dFTmpEaFZqVlR4TEdLYlJ1ZlhjRzJW?=
 =?utf-8?B?QnJJZUM3UDVNd3M0V0xkZS82MW04V0FRNGhTaGVRT2VMSU9ZYjhVWUFGbytJ?=
 =?utf-8?B?R2xDbzB0SldXQkV5bklaalQyZ1BBbTRLMXRQRDBVNTRBdGRpclRFdkNTbFdr?=
 =?utf-8?B?TDUwME9EbGRLMExlREkwM0o5UzkwRU9qTXpmSTM2WFpNYkVOaDVuV3Z5YjRy?=
 =?utf-8?B?aitCaUlNVTlYcFVKMmJod1JCVWJMUXQ1azdYQ3c4MHZDdHJZKzlsanRjSGdu?=
 =?utf-8?B?UU40dnV0Ym44MUJiNnBUR1p3dE0zVG82Tmt1Y2FJd3hlYzBFeFl1cXFoZ08y?=
 =?utf-8?B?YkVueC9qMFlLaHpkV3BWaDQzbW1GNHlXWlEzQS8vcmQ0dGlkTis5YjlJOFg0?=
 =?utf-8?B?UXVJS1M3UVVOZHM2b2hyK3RiWHphY1ZOazBuQ3RIR0FGSUNQNi9rMGs3SUJy?=
 =?utf-8?B?MHNEVk0xUmN3L0V6dFViQjFDRjBxeENMKzZ0ZGFrKzM4c2NuTjZiTWtCQ0gx?=
 =?utf-8?B?SWluM1htZC9sdzZZd3pnUDlTR3dGeXc0YTREN3daT012aVhDYXU0RWZnazRm?=
 =?utf-8?B?elA2MWNucllaVXFsUXVMR2NCYjlDWDZjT3hSVEVJeU0rTXd2MVlaTFV0V2c0?=
 =?utf-8?B?UFl3RWJMVnYxWWJ3T0ZlMkhEbFJFcGhxclBvUmhLUUVHWmRkSHhUcytLSzVi?=
 =?utf-8?B?R0NwSUY0UFI1TnYzUHZDZ1IxRmtEbEgvVHBUYU5KVDREYTJOa3UzK2loUGdx?=
 =?utf-8?B?VisrQTZFbURvSEtmZ01Zc2E4Sk1ocHByRFE1azlqMWQ3Vmd1cUxqU3pIVHJv?=
 =?utf-8?B?cWRGRkhpUVFIQ1pCT2JqaWhwR3J6UzFQejMwQWZRcXVCNFZTb29QKzRJOUY4?=
 =?utf-8?B?b0dtZ2M0anhsUi95c1VveCtFVGNrV1Nmb0RtS1ZISHJGSE1DblNMSFVCdVN6?=
 =?utf-8?B?N1lwU09LdnFibDBUYitCejZMRHl0ZThLbnZPS3VVYzRsVGxtWFdpWnRWNWl1?=
 =?utf-8?B?ZzFIWkxtcHVCaE9BRlBkY1huSWZFVG8yMGpYWDd0bmVlSUFEcGJnWE0wWGhP?=
 =?utf-8?B?eDFCaWd2cm9ZVkZCazI2N0wwc2FqSHNoMUpUL2xBZFBOYUNaUmYxZU5WWGt5?=
 =?utf-8?B?dDQ0c0NCT1BrYXVscHk0b2dLVGxCRU1nWVdySTlrYytmbDJRR2FGODhPRFBw?=
 =?utf-8?B?SmhWUjM1cHQxS0NaMGNVOVgyQlo0NUVjSk9EQlBiWXVjODIrYUREYXRZQ0VW?=
 =?utf-8?B?dGJuNnIyOXprblVLU0d2WThKbjdzZ2U2ZFFwekRJQ1JBZEZZODhsMG1GTVF3?=
 =?utf-8?B?T0Q3NFpyR0ZqOVRibFJ0bHNUelZzbW9EdzNOazJqZzNsSjRCT3hVanVVTEQ4?=
 =?utf-8?B?ZjNLVkh2NVJQR2l5azgzQ1gwUFFDV01FeU8vdDdUS1pBWVY0Rk9oRjR1dkxq?=
 =?utf-8?B?Vm96UGxkd2hmSHNvdW4xdjAyY3Rlb3R2eTUxTk9Hd2dnSXlsSllsNzFxWEVG?=
 =?utf-8?B?WDVmV2tHQ002enBvZ296SWJ5ZlE4bWFTTVRnWU5kaVdQVmFPMFNqR0hrbWxn?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7267e43-9fdf-4ba7-8b85-08dc59ac6670
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:20:16.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbYyZ29/jiX3dxjP0j4tLSn0POdYLpCVhFwBuLAK20DYdhCY8e+m0oLsLc/GA18izC/kyWC3tTo2XfYx0p2GS5Qi2mO5MEcgtBCICUn0rj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-OriginatorOrg: intel.com



On 4/10/2024 2:52 AM, Asbjørn Sloth Tønnesen wrote:
> I noticed that only 3 out of the 4 input bits were used,
> mt.key->flags & FLOW_DIS_IS_FRAGMENT was never checked.
> 
> In order to avoid a complicated maze, I converted it to
> use a 16 byte mapping table.
> 
> As shown in the table below the old heuristics doesn't
> always do the right thing, ie. when FLOW_DIS_IS_FRAGMENT=1/1
> then it used to only match follow-up fragment packets.
> 
> Here are all the combinations, and their resulting new/old
> VCAP key/mask filter:
> 
>   /- FLOW_DIS_IS_FRAGMENT (key/mask)
>   |    /- FLOW_DIS_FIRST_FRAG (key/mask)
>   |    |    /-- new VCAP fragment (key/mask)
>   v    v    v    v- old VCAP fragment (key/mask)
> 
>  0/0  0/0  -/-  -/-     impossible (due to entry cond. on mask)
>  0/0  0/1  -/-  0/3 !!  invalid (can't match non-fragment + follow-up frag)
>  0/0  1/0  -/-  -/-     impossible (key > mask)
>  0/0  1/1  1/3  1/3     first fragment
> 
>  0/1  0/0  0/3  3/3 !!  not fragmented
>  0/1  0/1  0/3  3/3 !!  not fragmented (+ not first fragment)
>  0/1  1/0  -/-  -/-     impossible (key > mask)
>  0/1  1/1  -/-  1/3 !!  invalid (non-fragment and first frag)
> 
>  1/0  0/0  -/-  -/-     impossible (key > mask)
>  1/0  0/1  -/-  -/-     impossible (key > mask)
>  1/0  1/0  -/-  -/-     impossible (key > mask)
>  1/0  1/1  -/-  -/-     impossible (key > mask)
> 
>  1/1  0/0  1/1  3/3 !!  some fragment
>  1/1  0/1  3/3  3/3     follow-up fragment
>  1/1  1/0  -/-  -/-     impossible (key > mask)
>  1/1  1/1  1/3  1/3     first fragment
> 
> In the datasheet the VCAP fragment values are documented as:
>  0 = no fragment
>  1 = initial fragment
>  2 = suspicious fragment
>  3 = valid follow-up fragment
> 
> Result: 3 combinations match the old behavior,
>         3 combinations have been corrected,
>         2 combinations are now invalid, and fail,
>         8 combinations are impossible.
> 

Appreciate the detailed analysis with the lookup table. This is a bit
more opaque but a maze of combinations would be even less readable and
maintainable.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

