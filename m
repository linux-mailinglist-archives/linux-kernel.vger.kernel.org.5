Return-Path: <linux-kernel+bounces-139444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB58A036F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1241F23A25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090DF10971;
	Wed, 10 Apr 2024 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPY4cNsn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0C28FD;
	Wed, 10 Apr 2024 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788392; cv=fail; b=o2BF8WWi0w65satcMOLjAY0WiugIzayHNOFuOptm4u3oknvyWT14IkfZ3toWTvGgvGE4tekSfWOKPUJgw1OJ8cuLGVKp6a+byuUZZEzA6ZWKfhvlNOrP4hLjhbiOQFpNIyK3A8rNdD5O2c+wd4ErzG4ozHhk4aG//7Ct/eHtu2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788392; c=relaxed/simple;
	bh=Un7gFYvf3JWEA7OJUZLRXBelmRB2Raxp6LAnGFR/BvA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ii2a9d1DunbVY08pQO5Dn43/Ouy1AguDj/i/I+Mq1ZQntnRP97tlMoiNq/lQ2XxiUR4JCeQodCyKO7wGoBXVuVzAdbY8p8Vqy6XvPyz8/K6ZqHIX9c+FUNUaWvimUUz7YO1ny7h+RHxIlseC8DzNQOpiahjrV9KDT8C6T47TUSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPY4cNsn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712788392; x=1744324392;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Un7gFYvf3JWEA7OJUZLRXBelmRB2Raxp6LAnGFR/BvA=;
  b=fPY4cNsnXsHF1Z0c0P7I7pl5He5F1PAhqpApgw+25Odhmb4znbbeAcBL
   MdVFYGtmBJYVD2+TXRZB4bqLm+eClhznrmEzrVzxYn3DlqLhjVxqvE+T8
   G6MT5Q1k//Hs1zZ1rWbgrP7HwiIcsWjk3vxHI7/dtWQ6flNB74HkX2TSX
   cUBafL5dVG50z5QDDaboSvT06dUHVCtAtnhWWybN6FFolEwpOg14TgRu8
   aRISH55FHesTRqSoxiD6xuB3JwI1cPJ/SsRA/m0cJ+4HurN3fgN2PhwOV
   +fQ0B6DauBJHisvSVIH7XFaIZkycKZBT/GjTO9Xh7yXcslSXSYAqcYapZ
   A==;
X-CSE-ConnectionGUID: Xw8WxQqiROecVUQmRivrGw==
X-CSE-MsgGUID: tVhWfcMXQTC6FLAvYDfRqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25634081"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25634081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:33:11 -0700
X-CSE-ConnectionGUID: aiWXG0IEQ4mZ5AXe6i0/pw==
X-CSE-MsgGUID: YqD7mFypRc+CHLlbzpM/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21208072"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:33:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:33:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:33:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL/4lBpqGyzhkW7sWtfhTkt/+WY+EKQZLoRPyOh1PegFj6JunvuR0Jhe+q1OL5Xc10RG+p6jbB6kj8Lf/PtS6PDQw+59vPB4LIouDgHU1Ch9dOpWgt2YectY7XxhbyExjQuYbtjyfahoQKKwerUfrX6b8JWe7X3SB7yYDE5MwBIEQtY7mMEmNyXmElEYvKleHG0Xu/pzMrHuzAKFzrb8s/oPNEjFYcfiznCV5u6j+dJfizgpS6kd0EUlOlDyrNYSzxcV/ECntlvnZ6W/Ze5IDQmWI8MacFPT1N5OPB/LU0diDqxOUjic6jcYMfqsxVCWf5tsCACLsocJfGb9Gc+jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I07Rvu7MFU/99AWURMEmbUKWkeFQ1zRo48TjtwZ/DY=;
 b=JEwBszLHYN27O47gl62/I5xsMN4BSVLeie8qIgPO5O498vcCPiuH0M2IOsRGOrwj+iWZqiR0S9maRynaVuqDyqTVPgKvI4XVTze+8C/AIEu7iKP95bYEjnZ+v25WShFpl4bQaWiN7pm6Q4Oy+2GpjvFOc3wHuiuRPRYG3BUx5OnLKuk+JFnVTdPA1PiUcU96rnKeJo6q6ghAGC6SLHuPsOWQlHbWl5hzOFuWr1XR0JhxHZ8B6Jkcnr7yVwUrqB5wIp1thrnUtLoaX8r6d0Vf4nYLi7MYFKnXzD+848h7MWnoMtX3hl5EUkGoyFnyG4WF4yHc2bXD2TRdbAKiuvR6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 22:33:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:33:07 +0000
Message-ID: <2ac5e173-fee0-4f4d-a52c-17fbe554434c@intel.com>
Date: Wed, 10 Apr 2024 15:33:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	<netdev@vger.kernel.org>, Suman Ghosh <sumang@marvell.com>
CC: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>
References: <20240410134303.21560-1-ast@fiberby.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240410134303.21560-1-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5977:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AtduXUdwjUebWBtd9EA5VV+aBwOSxzH9m8Txuz3o8h3LfKJRHCp+ImSHFqzF0GR35b7XRoHakNF1B4K4u6NAycmstOcLuUeGGh1MnJri4Ni1VGrXlqvB14Gb9WZuSVZJTkYllsMqAv84XHVjKoeQVeRMje6cASe3MOwU4B/f+jTx+Ddaxw3GCbSbOvCVBvfvwyknQsGw/kifUHIjvzAQ+ndEyy731lGUfbMM/VeNTEmoTCesfFp27ArLkZIzJ25ugjB1QA5Xs6iADvExL4RcdZmYD/tUxmLxPU2l69xCpulIRRjtysq240zHx+DEdhidibekhCEnP2Xx9cJd7rMlbWNCF6qZnPXENUa7HuOmXFBXl5LfzCUmITjzXpjrvxXsMfnWPcBwJOzXI9XI+GWK7i18hzgFNSWDHXqWXDV0s7Ss9LOY5Ksmgyda+JImNbXnog9F1XC+haVsm7JOhEZLd5cdi6YKodTnusflzcsHPWqOnbwrrb9yuIavNifG+Bs4c67K2AD8BhHigc2UTJIRr3PKQZJAQamihDV/GJ8/61DRqTROC2dNTku72Q54YCGyeE8SkYZWwnAeaVByEF7aM0FVOygY+Rl3/1KZ5aAmsYAzAutVBzqM2YnI+/ZHIUSDMJlhdsxrnR48HezXn7S4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FTdXBzUy9iZDVxQmlab0F1cTlHUG93TVpSeWIvdG5yR2EwUkhaTXdiQkdR?=
 =?utf-8?B?RDgyMTZscktkeVZtYmt0WjhORGY5V2xNTVN6bnhDT0VDa3E0RnhCVk5uQ0lm?=
 =?utf-8?B?Y3lla0cwSS9zUnY4ZkVpTVJuaVBpb29XZWM2bG0vLzRBV3JBSEVRN1ovS0ZL?=
 =?utf-8?B?RlhGR2Z1M3IvR01rUndHeWp5YTVObjZibGNTRFp6TmszbWIyeVVkN09VWjJO?=
 =?utf-8?B?RkZ1Z2RIQXgwSGV2MEhMSlN0YlAzamZzRWN6SzEveEFvVGE2SGMrS0pFenlK?=
 =?utf-8?B?czFTcG9PODQvM1M3OEtOQ0dVWWxPejFCekZzYmFNNjAxWmxjZ0tZVW9ZSHVW?=
 =?utf-8?B?Wmx5VTlOTFF3VGFGckNvQk5yaUdBZ1NkL0hlMHIzaWpIdG9aR25sVER5Uysr?=
 =?utf-8?B?RDdIQnoyLzh1MTk5SFRvZG10Vmd3SUJyTDl2aER4aTlWSEk4U21aQUhoMWtu?=
 =?utf-8?B?bFh6b2lGcWw3RjJtUXNiNitxU0tyTFJRN3RsMnhZQ09QRzcxOTRWVmc5a0VD?=
 =?utf-8?B?TXdEcEw1STBiTi8wYXVSQXZKaWYxZTZHbHRLT2twWmJuZzVYamhoZ1dPcGhw?=
 =?utf-8?B?eHlWVHlFZXJxMDlqT3V3dnZ4YkJPWmdjMTVUbzZlZG5ENHY4WUFodFdRUWQ1?=
 =?utf-8?B?TlZQbTRnV1ZHODFSY1JJRzgxYXdOeG9yeFFUNThYVWJ5eVVITTBuMWtHcDdk?=
 =?utf-8?B?OERrc2RjU01mMlh3cWFpN2x4N1J0QnZ6K1dmMXZVWkdlV1RqeG1HazlyVE5l?=
 =?utf-8?B?RnVqbGQyN2swU2V4cDZ0MUIrYUI1YThtdnFTRmtUNUlFM3BHVllwWkdMTkR4?=
 =?utf-8?B?QVozdzFmMnludHVEaEk2dlZEbEtTYmVIL1F3S0pHNjVDSFJFeXFlZFQvUWt5?=
 =?utf-8?B?dVFjbG41M3FldlFHWmVXOWRmRnNiSDRHYng2RHo1R0VScjEvckJyRzZtTXlG?=
 =?utf-8?B?MkZrMW1uSVJ2OFN0MFhQamFPNzhzbEVtZjMyMjN6NFY5cWt0UmdMQUpYMmkx?=
 =?utf-8?B?WExkYkJSMU9FV1ZOVU5vVDMvQ2NwQUZKT0pxcnhKK1FIZjgwR1pwZXBkaHJD?=
 =?utf-8?B?VnNoZ3d6L0RQbkFIdTZYaEZaYUlld3FKWHhzcFBhMzJYQnNyV0tjbDhuR1c4?=
 =?utf-8?B?enlvbTh6QVY5bFkrZDlUM0ZIVmp0US9NcEVpM3lvblkwRVVPSHFtblB5Y2pt?=
 =?utf-8?B?aTRrNWVKOCtLUmxhZ1k1VEVMZmhxbkVMVTdKaTFKWEU1TXEzS0VRcXFJTldk?=
 =?utf-8?B?d1ltdnNQRnhVUTNFbnlKYk1oMVNpMkJHbTFFSnJGTFk4MG5wbW9OeG0rQ2p5?=
 =?utf-8?B?VnQxc2ZCNGlRTm0yK2s2cXo1Mnc1eHlQOTBrdHljNVBVdWNUa1BENXp6bEpr?=
 =?utf-8?B?TkpmbG1Ydm95Q2UwZEdmaVNRNWd6bmRkVC9PQUtFR3hYeTU2RzVJK1dyeFln?=
 =?utf-8?B?Sk1pdldvZUdOV3NLR3ZDMkVkOGdRSDB0Um01YnhIb3VzMWk3UHA5NE5IM08v?=
 =?utf-8?B?aW8yeERVZWxxa0hxYlV4SFl2azJFWmV5cWIySDhEZEJxazR5dUZqeWFHZFhH?=
 =?utf-8?B?OS9YWHVyWEtNdkw3dmo0c05VYkcrQkpVL2FOd2ZmZEpKNFluMkpUQlFZV01U?=
 =?utf-8?B?RFd1bDB0enUvbTMzd0ZwdTI4aWRZb01Ka1pxcmhjeU9maWhNN1FvTGRhZWxS?=
 =?utf-8?B?cXBlZ3l3MEEra2NYN2dGSXQzWlJub0FncGdIYW9UVWE2amVZQTVQT2VvdzJR?=
 =?utf-8?B?QTMzWExhSUVHbktVNkRoRlNJam13eGJmdzQ5ZXlsVGs3b2tnaG9mQXRIdlZD?=
 =?utf-8?B?aGVsWUtiUmhPT1JzRHRZNnV2N2VxeUdGOWZXazljK3ZLay9xcEpJNGMyUGpR?=
 =?utf-8?B?cWd0cVM2NzczNkFNVmRRYkFHNVFsVUNSRFBhZWlJZDNVb1RyRFUwSlVJa3Ir?=
 =?utf-8?B?WWVPZGFMOVlIcmVXUi9wSFNqWmlWa3JRNjhVVEFYaTIzUWhkajd6V3UrM1Jk?=
 =?utf-8?B?a2JJUmphZ0VQVDl4Mms3UGt3citndzU0WEtHMWttNE5zTTZwUlYxSkVpdDJk?=
 =?utf-8?B?TVNJNExtc2FNa2htTi9TUDNTTnJ3RnZXNTdoMDNnTXdIWkZkU0Q5eFRrZisw?=
 =?utf-8?B?OCtQVkRJN3RFQi9yWGZtOGVqdjJtTlo3MWUxb044V1pJdllQeTU2eU4vVGR5?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1a067e-2966-4a1d-c604-08dc59ae31f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:33:07.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrtqyVmaioaCL/U3oN2VSbze2kKRHWA2+ofoeAVQJcyS1rcIgyYKR9zSThM0T+TYz6zR6Yo86S4ZYtSmxvNGBDBpqgJhfx9ncaLFsnf869s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com



On 4/10/2024 6:43 AM, Asbjørn Sloth Tønnesen wrote:
> Upon reviewing the flower control flags handling in
> this driver, I notice that the key wasn't being used,
> only the mask.
> 
> Ie. `tc flower ... ip_flags nofrag` was hardware
> offloaded as `... ip_flags frag`.
> 
> Only compile tested, no access to HW.
> 
> Fixes: c672e3727989 ("octeontx2-pf: Add support to filter packet based on IP fragment")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> 

I know nothing about this hardware, but the change does match your
description. Hopefully someone from Marvell can comment on the hardware
aspect.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> This is a best guess on a fix, I don't know if it will work,
> but hopefully someone at Marvell can test it.
> 
> The more certain alternative would be to set an error msg.
> and return -EOPNOTSUPP, when `tc flower ip_flags nofrag`
> is used.

