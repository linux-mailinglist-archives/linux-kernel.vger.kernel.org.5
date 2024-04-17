Return-Path: <linux-kernel+bounces-147898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5D8A7B16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AC2282529
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F32260A;
	Wed, 17 Apr 2024 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIaXfKzG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC527701
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713325032; cv=fail; b=p4fuV0QoqOgLRXZg8a0pw+E0nFSXT36J6E5xq6Wpy/HqVs4PryeXxcYmI6/Hx3QKfqQjzjF0WJP2b1FrN+8xpMGjzIK2zOn+YGpOOTW+CKnJFOWZCEutd3wZDZtpe9fc5ajRK9426heD0iD9gWugYWLsqtq0TwvXHJ2pw/CI+u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713325032; c=relaxed/simple;
	bh=B0ZXP04fWjEjV4eNmb5DRpyFWlNpQgFKnjCwHuLx3hI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ci6EvdmDa226YUwPVZA8Nqjnwi0Q+O7+11/UckrWUuGRE0sH7eqIq/zm3NGqQS0NoBqwjHhGlj+0C0NphJbl2bIVnX0l77CVUmFC4v+vC2wdBwJviw6dZsD0Cp6X6qxledSTfPer0hF3ANdtJwcB51lwiCfNmYQDGD1ND13NMkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIaXfKzG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713325030; x=1744861030;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B0ZXP04fWjEjV4eNmb5DRpyFWlNpQgFKnjCwHuLx3hI=;
  b=bIaXfKzG2K2sXuI3JFGF/c0ObTdXgo/Wpi4MdKJL4OjD8Sxi91Kr0DI+
   FT3Q7WAhiaKZ9qRF5MwyV+oTjEQYlQCMFXsgB0Xm7FxK4kaM5lPzoRRGn
   O3jUL4PYOD9i0fQUtddP7A4/+O5CCyj4SGFeK5LMNrnQkt0GyZUM3HW29
   BCqvk97i8HUOCJaxV/as9n/HjewmR98xO2ISI6s2SEbqPX2/8OkQvBhTK
   SdbY+8uyCME0bF5kDTA5PSRBzo8I/+n4ypPhCxJY4eF8803S5aiFdW88A
   jMxU+siJ7Xl/ZUk3Ezu9M+kBz+8rs8goL/U9KKCqfQqDY2HiqX9MibvTT
   w==;
X-CSE-ConnectionGUID: ayY3KabfQreJ3v9hrvR//A==
X-CSE-MsgGUID: wCi3VemsThCaMZ6NvDUGIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31280696"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="31280696"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 20:37:10 -0700
X-CSE-ConnectionGUID: z7jSLtwkRwemtVtkDB6c7g==
X-CSE-MsgGUID: pyN+HXAxTpadhxnwRleWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="27042337"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 20:37:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 20:37:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 20:37:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 20:37:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 20:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTLu3EGBhb21FEQxwSwBTgktf3pUgM/+cZj/pD+OVf+aMhuuFifx1QkBJB4rXYFlkTfoXjdHkgZVz2EVg5KefdBh4HOJGC1BGsjNrmeIyoureJiCh1FzvyJc61UB1NKyHdT0lOdWhW8iozrueI4oZR9BkV4yVOguNK210d9DC7uycn3CeJmHzkS9BYpFizsAyjDce3td5djATOoBlymDxb4dajaaZHAkT7MGMewSabmJoYc3UZXnGfyxu5MBYd0fSj8fU0jgm89w3QJzWCgoAxS57SZGyqTSK8szjuZlYuyu3CMWV3LDGYemJpEBxCoF4Q/qXdeHBkDgWayZxpA1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZkbBVBiIpivOL7RGmRHFlApSfGLkqY6wLYrGQO5vg4=;
 b=c1KpUQ4UQOfCWCPJ6m0YS6qwL/xJeH/68vvu3CyTYIc6pwVBVE3NNfQ/19mGnC5G8xX8nPHoc7sMZNISbp4V5ZphV8bkFrSJp1HEtu4h7JsGdfIB71a9epb2brPLdE4G8R5Nl2/TKIEhyHERIXA9gIj9BWQ3yq9EK/nKn2zV//Byk0Eewd740i47K8tuwqZDWo7g5AFtFQuZPLt2lBZeLhLxhTPryPRInc8qPx6fIoVstfosXE9X5YDh+ItfF2wp2Qm3umBxukGcAWaoP8VN0Apkpn8qoKMSrxUAHs9S/LUux0qFGQ7niSYoEF2DMq9oSzAYlJan86CfeYcgXkdilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Wed, 17 Apr
 2024 03:37:06 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.7452.046; Wed, 17 Apr 2024
 03:37:06 +0000
Message-ID: <5e53c574-5059-4c5a-9a0b-59298df370a5@intel.com>
Date: Wed, 17 Apr 2024 11:40:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
 <MW5PR11MB58818970CB8E9A37A6AF563889092@MW5PR11MB5881.namprd11.prod.outlook.com>
 <f3502244-5f37-4f44-94a5-39939ba20eec@intel.com>
 <a5c4b57b-c1f8-4f75-95e4-9a462f4673c9@linux.intel.com>
 <66c09ac9-0107-4b86-993b-70ab6907fc21@intel.com>
 <2b8a3145-1f34-48e4-9822-a95c27f60ba1@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2b8a3145-1f34-48e4-9822-a95c27f60ba1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 0715dd2d-0c19-43cb-51b1-08dc5e8fa72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8Za0aTjQj8xE5K/Hv/kLeT9kvBOBzSLFHBNOT87v+5uuPMrXzeb7Vv8Gg0XLKvjbplJJ06z27PZ0g8tVKCWEf5k1Pjpzwn53NZcr+EnKwyj/HtIHuXPc6WiIXpu+wI5wzW4rsSWnmJo0AZ9WPhHV2M0SUMskUFmgmvlMkPsp6JuU81Gbe6zzIXf5kGvsMp/+SDc9VAHSqyESgEGFtzb+HtNYlrjimKi6LqyuOgPXNFe5iG6wzm9T9eJmyW65L4GVu4sHh064rvqqv4sUjDh/h2h6av88XBVgc1ji1wpWuf7VJd9LJhuv1GTuLOgBy9SyueVrawX2D8Y3fQTAONGZ5v35V18xpStHcWoUsGTtUsSQElJPDMQ+cDmCPao1yEtV7NwNz3guv6v1mHPu6a29v31urLArNfDHb9H9/E8WB1S5/XjCVc6M8GyewRzR1BLlch1zMa7Gf0zxoe6F4BwqIjE02rM3raSjmpcRB0s/3PDo0sn5YpTQkp5qQIgsGr/jl2NzCvjaBELchnrxnNDQUbux7RsP1grhFa9Yrgq9WSkFLg/ua4RbohKWFo2H2r6XN539/+AD4MMDOAensGCK23i2rJMEA8W9dCGAWQVVjGJg1hBX48NQKJgxaYpqHh4eryvboPudvX83XTYcUS+bJlU7oQmQzwTpOCltqY9fDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpYOEVPQndIRjNLUm9BU05XdS9MUXd3Slp4S2ZGNFNMVEk0Y2VXb1JkeWFn?=
 =?utf-8?B?TkNBVmg2dVpOb2JJV0EwZEt6YW95aUwvTXBRNHdHK3ZjeEpLMnZwcmRMZm12?=
 =?utf-8?B?WUUzT2t4VzRaSFR0RDdiN0VWNHJVOGtGYk1zdDRHdUdoRThZR1VLNFBVc0Y5?=
 =?utf-8?B?ZFlwQjNHSG5SbU8rQWVseFh4YlB2d1JHNFFscjdoN2ZFNjVPYjI0ZGlCdDUr?=
 =?utf-8?B?RzhncHorQkQ2d20xQm9WTy9vZTFML2RGZ2huZzZrN1VqQWI5UDdZMEZnekJ1?=
 =?utf-8?B?ZXA5WFFvZFhrK1d3UUNQTnVEUTlrcVdZaU9NTGxaQUZtMnRaUDFpZE9Ca090?=
 =?utf-8?B?RDMrWnFxNkZmN0lPSVhaOTNkMDR1R05NOWVjQ0M4dk11ME5nVXJvdkdTMUVy?=
 =?utf-8?B?U1dESTBBREJjREtSL2k2UTdwMXRoN2ZwQXhmODZ6S1lDdklESkJvdWc0d1U2?=
 =?utf-8?B?ZVBYY0o5WFpWL1pEQVh1TFNjOVJYUlV2a1pvRmpkTWFtVzAxS0NtdjRkQlZ1?=
 =?utf-8?B?a1FGWW1OeUVJczY0TzQ0OG1WdXBzSVc2RDEvM1BvRldwVzdDT21iVEI2YWtx?=
 =?utf-8?B?RGhock9MdVcvTjBJV203UU8xZDE2Zm0va1htSENMOGJ6N1grVmUwOWxwelF1?=
 =?utf-8?B?MkhRc1phZnd2SUw1K2M2eDhJK3AvSTB3NDU1cVM5MHJCUTJDZnVvZDVzczZS?=
 =?utf-8?B?WjNQSGtMSkR0dWtiREM0dDBjUVdDZlVVRVdwK2k4MjhkMUtRYXRYTGZFM3Zn?=
 =?utf-8?B?NzV6NHlDMHMzZGpvdXZDZmFId3R6TkJqa0NteTNtYnVRVEdnZjQ2M1JTby9D?=
 =?utf-8?B?THJ6YjhDSXN5aVhaSVBBR0lzQlV1d2IyUmk4c0FNSUxiaTNsMlpYRFBjR3Zi?=
 =?utf-8?B?VzlmSFE5WjVSTkVjVXA0Y1l2SXIyNkFWbkdaWUJGVVQzN2RyN05nbFhjekpI?=
 =?utf-8?B?ak1JbGErU3VPVnMxdmx1U3hvMFN0Vmc3QzBuc3o5NmllVllqem9za3lLSGdx?=
 =?utf-8?B?V3B3c2l0K3gwTDZLcndiaUpLTGRtWm8wNklocEhpV1VjV2hBd2lTZTNzOVkr?=
 =?utf-8?B?MWFjcXFjS2MrODVGTUNwQXZUb0xCYmFZR3plV0Fqb2hLMDFqRjFlY3pIb050?=
 =?utf-8?B?amJ5dU9lMjNYT2M4RDA3RCtpZHo5bDUxVUgrYTB1QlRiT0taR3NjQzEwTnlK?=
 =?utf-8?B?MytSb3QzVDQvM1FjOHFGdGMrbUVJYWJSMFF6TFJSRy9XWEZNanlwVDZuSTBm?=
 =?utf-8?B?K1haQmJPTWdVN050K3lRZVlVQWRxMWtuZlpRRytMZjdreCt4Q2p6REc0bU1l?=
 =?utf-8?B?VDJLNEEwbklVK3NaOXhCMERFUExLVWE4VXFYSkVjTXU0K3RYL3ZCR0dOWjYw?=
 =?utf-8?B?RWNaY2lMUUVpenk1SlRvdkpYU1VMSktxNGNYdHFZY0MrT05sSXdROWVxRDgv?=
 =?utf-8?B?dEsxRVEzZzZtQWxVYTdqQ3U4NmlnbVVnaFJTQUllNHV0dC9CVjBaeTBiL0JW?=
 =?utf-8?B?THZ4NEpocCtCREdMSmxFK0lGTDc0ME81VFhpblJGdHVDMzhhaW1odDlYbGlJ?=
 =?utf-8?B?QnIzUVlCL1V3emdxLzk2blpVelpIVjFlTE5tVXVtN1N2ZTVtdmxZVERFYXps?=
 =?utf-8?B?aFNhUFhIUk9PMC9oRndWRzVwR00zZDh4cUtpQ3JLdHVrUUMwUkNoa3lpaFAv?=
 =?utf-8?B?MnhZNnAwZGRhaWVsRHV5VDcrZUdteXN5a2xQc3kyKy9KbnVDWFRIbEZzZnhs?=
 =?utf-8?B?UnlqbTdDSTZkY0ZtWUMwQXQ1ZUxLYzNhc2VKRnhidGFjNXhobGltcWdjWFMy?=
 =?utf-8?B?WU5tYVo1M2ZsZHVkditHN2FOdEVMdVRaRnZ2STd4YzVXUUFtMm1iODVJend4?=
 =?utf-8?B?N1Z5OXJRUVlBQzBWQzBXUnhqSjdZcUR3b2Ezanp1NGl3eEdVSVVjUTE1bEVk?=
 =?utf-8?B?RFlNTWcwOVVNYjZJOWJRZjFkMFpoaHZzYkNTbHdIekFkMm9zSWhxYUxRbEYr?=
 =?utf-8?B?K1Z0QkhTcDhOUWp1UkZYUVh4ZWpzZ2E4cmNXR21mbVl6eDdwV1BnbXhJUDNi?=
 =?utf-8?B?a1FMM04vWEpjOWE1N3dzSjlBUTB5QUR2MlVWSlYxK3poRmxiUzRwQ1MyRHhL?=
 =?utf-8?Q?6S3XRe4dT7sYfCK6eS4baJOlc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0715dd2d-0c19-43cb-51b1-08dc5e8fa72a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:37:06.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1p3wbteTXBLFKv8k4Xr6HIVndb76x3PKv6z9rqRYQvDn12jbGZCqQ32/+9mnGwhOjObHedDcu6bf1GBmawKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-OriginatorOrg: intel.com

On 2024/4/16 11:00, Baolu Lu wrote:
> On 4/15/24 2:56 PM, Yi Liu wrote:
>> On 2024/4/15 13:00, Baolu Lu wrote:
>>> On 4/15/24 10:43 AM, Yi Liu wrote:
>>>> On 2024/4/15 10:22, Zhang, Tina wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>>> Sent: Monday, April 15, 2024 9:39 AM
>>>>>> To: iommu@lists.linux.dev
>>>>>> Cc: Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L 
>>>>>> <yi.l.liu@intel.com>; Jacob
>>>>>> Pan <jacob.jun.pan@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; 
>>>>>> Will
>>>>>> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
>>>>>> kernel@vger.kernel.org; Lu Baolu <baolu.lu@linux.intel.com>
>>>>>> Subject: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
>>>>>> device TLB flush
>>>>>>
>>>>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>>>>> implementation caches not-present or erroneous translation-structure 
>>>>>> entries
>>>>>> except for the first-stage translation. The caching mode is 
>>>>>> irrelevant to the
>>>>>> device TLB, therefore there is no need to check it before a device TLB
>>>>>> invalidation operation.
>>>>>>
>>>>>> Remove two caching mode checks before device TLB invalidation in the 
>>>>>> driver.
>>>>>> The removal of these checks doesn't change the driver's behavior in 
>>>>>> critical
>>>>>> map/unmap paths. Hence, there is no functionality or performance impact,
>>>>>> especially since commit <29b32839725f> ("iommu/vt-d:
>>>>>> Do not use flush-queue when caching-mode is on") has already disabled
>>>>>> flush-queue for caching mode. Therefore, caching mode will never call
>>>>>> intel_flush_iotlb_all().
>>>>> The current logic is if the caching mode is being used and a domain 
>>>>> isn't using first level I/O page table, then flush-queue won't be 
>>>>> used. Otherwise, the flush-queue can be enabled.
>>>>> See https://github.com/torvalds/linux/commit/257ec29074
>>>>>
>>>>> In other words, if the caching mode is being used and a domain is 
>>>>> using first level I/O page table, the flush-queue can be used for this 
>>>>> domain to flush iotlb. Could the code change in this patch bring any 
>>>>> performance impact to this case?
>>>>
>>>> This seems to have performance deduction in the nested translation case.
>>>> The iommufd nested support bas been merged in 6.8, while the Qemu side
>>>> is wip. So this performance deduction does not happen until Qemu is
>>>> done. Should this also be considered as a performance regression? TBH.
>>>
>>> Caching mode is irrelevant to first-stage and nesting translations. If
>>> the QEMU implementation still relies on caching mode for nesting
>>> support, it's already broken.
>>
>> For first-stage, yes, caching mode is irrelevant. But for nesting, still
>> be relevant. Because it relies on caching mode to capture the mofifications
>> of the pasid entry. Without caching mode, vIOMMU device model within QEMU 
>> will miss the newly setup pasid entries, hence no way to setup nested
>> translation at all.
> 
> Okay, it's reasonable that nesting translation still uses second-stage.

the key point is not nesting uses second-stage, it is because of the guest
pasid entry capturing :)

> But the removed checks in this patch don't impact the pasid table change
> capture, right?

yes. The removal in this patch is irrelevant to it.

So Tina's concern makes sense. But I don't know if it should be considered
as a performance regression since nesting is not really fully ready (QEMU
side is not there yet).

BTW. I'm not sure if you have considered to correct the other caching mode
checks before dev-TLB invalidation. e.g. the CM check in 
drivers/iommu/intel/pasid.c.

-- 
Regards,
Yi Liu

