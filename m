Return-Path: <linux-kernel+bounces-137984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8C89EAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32151C2213B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61407288D1;
	Wed, 10 Apr 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3tXhfvI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551E2837A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730415; cv=fail; b=ISiNi5O1OVe7FjI7d+pswFoWBuXmyzRezF/HlI7mUT3mcGjnIEXPT23m8HtuNHlAtxWlG/Nx5NlHOuwJra0zbFdXbnlA46DCMWSS2evhhVTSgXif3ltyrfrj7mlXzew0pekfLIL0VLlpsuL3+e/IHJZjaWxyAUOUMy+Yc0t+IFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730415; c=relaxed/simple;
	bh=5ElWI1ReRw9NOM7pr1+CBwB6fVmj1VU2u5D9BIR1MFw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YE6WJEdWFpbs0Rhm/qMD1QVH0rzp6P1h9nUaM9j1NTFyygXY0HGhfEhVqUAJ14tiWSJKy0YkpKh1+kZy7HQN+hbtx/20Q18sFx/UFEMPna1pcRPELqWOyLDP9JU7zSZui9z61u+OGCuGoZ4lzbx2BhoLTqhMjWxus93grhqbMY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3tXhfvI; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712730414; x=1744266414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ElWI1ReRw9NOM7pr1+CBwB6fVmj1VU2u5D9BIR1MFw=;
  b=W3tXhfvIx+3P445UbYYI98uGJOX7uvNKN64MQ3o2u0ZYL2s0OSNcygyh
   +8H3/tzYcuXwZleAgQxEFNQzGN3j2u00tBkS6CB8Csq+xqEYoCZtriJqs
   auePWpG/u3f54M9bXuQwTZ9jepOVDjmS0AQ383nmp8eYNNGmLVRK6GuJ0
   X+aoUhQYTZU35y9EvxuBoJ9ke+5XGgJImdIZ4roW3OD2R2LMUpCcu4br6
   NcBnBkeatV0K9TWRHGocYJEvduj+QMlj1jcKM83uVAH+hR0BeWWU+sy+N
   W4IwS1t/OGRaAmrJuv2zelWdwpMdQA0prBZe+R4EG7RM5OeBiN6OQ+/Af
   w==;
X-CSE-ConnectionGUID: kYlZ3/FoSoqpyujYiPpm0g==
X-CSE-MsgGUID: 5buM+QQnTF6GteJvhoGhKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11915250"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11915250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:26:53 -0700
X-CSE-ConnectionGUID: emyr9f7eT2GOWyhA+RTmEg==
X-CSE-MsgGUID: dos2HPXHSoWctBavyz4iMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20520600"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 23:26:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:26:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 23:26:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 23:26:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 23:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApRR+1vMkC/ZWgGveo/O5t0vm+UuuGufaf3hrmgNQOW1PCmc7NuJNd1e4bUYm0931YN22sbFyV6LUSwQvs0a9wwFHKBFQLnKqE6ctr6Bt2VCjXo6XGh5SdDXsBHsAuIne5yRQzynwhzvh7aGeg6gaLPQD5zAjnIsgl6/OO1rC1LUu28hcrmacuIqYofjgT+4/sYwa2Li0MZ+mRVHnvExmhdfxwC7KYaHDO2bM42d6/M5Ga3MNRHfpPYI+oRrDXxKJGQO4e8aeLb4llBybll65nb2cUH20WEmxZve93U1Q2wTM+kA9f9pOlbnEaDCKYwClGOylvuGzpw78KVE1DZ3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qelPX0UbmNnNwXX21TLrDa5xUfK4HsUjeq3Ds/yO0/o=;
 b=D9Bb5zszxVK+fvzn0Dsc6nABxWacUuZek5bGz0cRiVOu7RgwVkbAnz6Nh8QymNP72H1xZIJdy9/DTph5JTY6pusPXP6+rG/QOLsrN3nHkKgG+WuQEswriSLcpvh6iyEiWFRIh5TNOQsNgVF8wf570m5wSfrW09qHd8Q/M1zdIda2QrTsIsq3Ra18s99IXdOwpFyXCH7FL9ND3uK9m+OfYir7r83p6uX62lzlLoDa81c8H6Roxyz/vvfCPO7Ihkgc1qveYROzTdziqSLavwdxtxTHftSWW0VPDRKiPaLqbXvwSZV3KHSlQ0obDot/7W/HTFfeXEuef9WQwgdEIH0/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 06:26:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 06:26:48 +0000
Message-ID: <7e78917f-f84c-4e98-a612-73b8013ae367@intel.com>
Date: Wed, 10 Apr 2024 14:30:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Content-Language: en-US
To: Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
CC: Kevin Tian <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240410055823.264501-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6545:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQ2jyazQl5j4vyfu2cKoGej1yQqZGFcwHu/8OqBoz6MXZtDAEwEJWTQV1WHo7auTuQoZz9+Rem3/ysXueZZomYyAz7wzahoxn+UsrYmsdg5H1YdlGBGlBQWK3IqkzzZijJJdJePZYPEZDVkDoot962J1KDJm+BR/CsSRjfR0N6Z5elzsrrQYHNAeBC2NK8plh2IKg8W+rgSlYAbW27HNw2B2idwX2qHy5iiXenvitiGRRol8dMjdj+ALvFVrf0Jx0MM/AdYbasd9AIfQDZ4o7560qzhTZFc34ZWFHT/wXdd144H8ISP+PDFWsd5XgkRlfAvWVZdpr4QQckCWGyYg53ySR9JKJYQnMwcF4VHSjDH9JDDv0D9L6rrLjIvlrqjz7+MYHBIJPQZ8lQsoRysWMQTjiQOO1hoJ+qrYqXaXbRGrN/t8zAdtFOsPlAgO7SnU0boioU0nTn7Qjq+EMZ+jeXoThIvKOJF5qrJMWkr3VvwWqco4pc3wSYyZSYQi5xpm9tUYESuqQGwTAJjLj4umxCbiQI1GyO7j26oFKJ4cTRfGtQ2O8ARgjFxO7fTWuI7To1iiKdYlglBZqDzoNGJ4w34YO99t1wpG0GQy7jz3msz8n4yYPRtHqy+X0AyW/ry7RWhk3wYuNW6eOOpptqCk7wxtV/HQhJGY2AdUt3sGVLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStCb0RDUjdWSTNEQ1UyKzZJR3RSR2Z2Q1gvbVBTZDhGS2dmRmE5Znh2S05u?=
 =?utf-8?B?eHlEUFl3VGxsc2JFV1hsaWE1ZnlzOTFYM29kMUdwR0QwdUh1RW5TSFV3d2ZN?=
 =?utf-8?B?c3VvbzhXZ2FDd29XcHNSRk5TRlFMOWl5YVlyMmlKWGdkYnJoNzRWUXRwYVd4?=
 =?utf-8?B?UFpMUkVRL1ljMnowYWdaUnVVSFNabGlQT3ZiYkoxc0xOcjdxRDF6NDdpOXFC?=
 =?utf-8?B?WnYvU09MaFV0aEZWcjU5eUZ4eGtIQkpaTG5pMnpBTzhXdGZxWlQ2eXZxNFNF?=
 =?utf-8?B?REdWRk9PbTdPMkw2TGFsd0VHM25yWFdMR1NuZk42VHowNjRMT1VhbW94ZSt5?=
 =?utf-8?B?QURxSC9NM3lJR3pUSTlhV3dvWk5XSFRkWGZHb0p1dm5iV3lMOXR3d1BMb3F4?=
 =?utf-8?B?ZGdCM2hXdlhWWndQSTJtNGliYUNXUmpwY0hlZ1ppakZPbXowNVQxb015M0Zm?=
 =?utf-8?B?eTViTnNaYUJyYzhDTjcxTEg2elh3L21QekxBTWdjUVZQeG5oK09Bd255Tlhh?=
 =?utf-8?B?UTVVZFFFSUlSNTFWa2I5V2VwVGJxbi9DZmFXMmlQbTBqNGw3a0p0TXFEZVov?=
 =?utf-8?B?ZGZyZC9Rdm1QR05mbVYzbmdLNmxhOStNNGUzdTVVTmtMSnhWT05jM1pTODdD?=
 =?utf-8?B?eDhmZFNrUmR1MGdHQXlhaGIxeDRPNHNpTFcvYnA2MVRjTFE0RndVTEQ3ZDAw?=
 =?utf-8?B?bFJ1dHk5eXFyVjhMYTRrMTF6azRzNld2WXVlUkM2SjdIakRiYXpValF5bFF4?=
 =?utf-8?B?dkd4eU1xRG9WSE0zRGpnVWJHaUZXR3FXWTFxcmxJemZFbk9iUzMycU9FNjdz?=
 =?utf-8?B?ZjlwL0JaSzZ4NlFrMklNSHJQTmZBRXFrQU1ISS9qaUgzSTNVbzRPOVByTDJi?=
 =?utf-8?B?Tno2by8vY2crSUVVbFJVTEpTNkt5c0pxQlEyMCt2Uk5MTFdodERKaTc1OVZQ?=
 =?utf-8?B?b1lqR1JRdndueThBbkY0QzVhaU9pWHZHQTQ3VDZTN1hIamZOOU1rVFo0RmlG?=
 =?utf-8?B?eUFTTktJSURiV0ZKMDNmditYTDNDRXNwMHJOOXRKb2tjL2JDWkZGZU1CQ1RO?=
 =?utf-8?B?REo2OURPVmZSUU5oNEZBeVZmNTZTU0xieDJuWTlZRVFCdGJNUkJyMzd2WTc4?=
 =?utf-8?B?a0FXUXJ2U2JEazAyTnNLK3VBYlRNZy9UcnB1ajg4VGVUY3NLcUtaL0M2VTA0?=
 =?utf-8?B?SmlVaHZvREdzR1R0M2U4dWhUdzZKbHRieWp0SWJFcGZCbWNaQW1naDRVRm53?=
 =?utf-8?B?aldQU1pYdXRqTVFxVVFxU2NxTHhCeWQ2OCtrVnFkM3l4U3ZwR3hrL1V5RWJ6?=
 =?utf-8?B?K0xvRnE5WEQ1MEhrb2w2Q0ZhU1VsaUNQWXlNQXZabStWdzdWNjg1QXdRRWRY?=
 =?utf-8?B?a3o3RHdtWVFiSGdLNndmZjVxcENmSUxaSW1paDR0QU9tVVdVM0g0clEwUEdy?=
 =?utf-8?B?R1g3NmloS09FSmpXRXcxSmtSeFhDRWhjalE3YUlNSG82b1lVRElhcHczY2FO?=
 =?utf-8?B?dk5QNGlQaG1XWW1XUDd0Q3VMWHU4a0VCYy96ZFBMQjIrS21NY3lOdzVZdHZE?=
 =?utf-8?B?U0dEaXpIbnl5U2Rmd3NNS29mMkkrN2FuUDh2ZzdpUmlXMk9CcnNlekVVWkg2?=
 =?utf-8?B?aFNVa2t2SmNPd3lmRDBjeFhvYWJpYk45azVLTm44RDZCRVJ0YVYzWjNQZEFF?=
 =?utf-8?B?cW9SajFEWWRtRDgrTENjdy9aRTgxNVVla1lQbUlCampkQ2dyT3NUdWVzaHVZ?=
 =?utf-8?B?Qnp5UHNyTXliTE5VWVhkL3V4ZDBOc3hVSFpET2R0c3VtOUVBaVg3cXJYK0o1?=
 =?utf-8?B?T05Lbm80VkVDUzB6S01kNWJ6YU5QMmliaWFyaWtNM1ZoUUlsdzdUZEtCMG9Z?=
 =?utf-8?B?SHdyR0FGY2ZmNzZ3Y1YxSWw2bGJEMGhkTHZISW5oVWhiZERGczNUOUpyNWpM?=
 =?utf-8?B?aEZsTTlPMGtvZlo0aGR2TU5aSVI2WHN0UzZHbHluQnJ5Z3hSUTM1WkNrTFY0?=
 =?utf-8?B?bEFLVytGRkRxV2lUWFlFd1FIL2dJVWFiMUdybTZ6TlpTVjk3WFBJSUEvYVVm?=
 =?utf-8?B?bGN4em5GSEpDRE9WK05ibkhwNlhJZ2t0aE4zOFhNZTZhd21JcDJxdXlQUDB3?=
 =?utf-8?Q?iVDqyu3hhMTOEF0xHnaq8npmK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1975f6e8-59f3-4cc3-098f-08dc59273382
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:26:48.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWQ2d3xfvt/qM6HGH5xHOym+0FkxFolkEMA/mpdjN13YACuZSFL/IqVRjxfHL5y2c4ZhRoOJGntqWIFnnXDWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com

On 2024/4/10 13:58, Lu Baolu wrote:
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except the first-stage translation. The caching mode is
> irrelevant to the device TLB , therefore there is no need to check
> it before a device TLB invalidation operation.
> 
> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
> mode check before device TLB invalidation will cause device TLB
> invalidation always issued if IOMMU is not running in caching mode.
> This is wrong and causes unnecessary performance overhead.

I don't think the original code is wrong. As I replied before, if CM==0,
the iommu_flush_iotlb_psi() is only called in unmap path, in which the
@map is false. [1] The reason to make the change is to make the logic
simpler. :)

[1] 
https://lore.kernel.org/linux-iommu/ac7fdf0f-ecb9-415f-9c1b-600536b92ca5@intel.com/

> The removal of caching mode check in intel_flush_iotlb_all() doesn't
> impact anything no matter the IOMMU is working in caching mode or not.
> Commit <29b32839725f> ("iommu/vt-d: Do not use flush-queue when
> caching-mode is on") has already disabled flush-queue for caching mode,
> hence caching mode will never call intel_flush_iotlb_all().
> 
> Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for domain ID 0 in caching mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> Change log:
> 
> v2:
>   - Squash two patches into a single one.
>   - No functionality changes.
> 
> v1: https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50eb9aed47cc..681789b1258d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	else
>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>   
> -	/*
> -	 * In caching mode, changes of pages from non-present to present require
> -	 * flush. However, device IOTLB doesn't need to be flushed in this case.
> -	 */
> -	if (!cap_caching_mode(iommu->cap) || !map)
> +	if (!map)
>   		iommu_flush_dev_iotlb(domain, addr, mask);
>   }
>   
> @@ -1579,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
>   			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>   						 DMA_TLB_DSI_FLUSH);
>   
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);

why not one more step to move it out of the iommu_array loop? There is
no more reason to keep it in the loop.

>   	}
>   
>   	if (dmar_domain->nested_parent)

-- 
Regards,
Yi Liu

