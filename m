Return-Path: <linux-kernel+bounces-149461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A378A916E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484111C20E50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5DF4F608;
	Thu, 18 Apr 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8QE9vOJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B499433D6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409762; cv=fail; b=GmIyrAjmwFxjYNR8sRoP+39+6It/YKQRb4pRlr2jNPWqo/qrMt+LcCqoMyhePQ+fhdt+19QJE0PyX45sKXSUKNBn1SWQR0MfMOpgjdxl0GbgVNIpgZ6nZS+KXdWjnyvim3YCg4YB80nCKMgEQgNcPhbEzAZL9oRJES9CS5nfs3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409762; c=relaxed/simple;
	bh=gdpvoPSSkaceUX91p44zx/T7T+yJtxFwZhYkjJcug88=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PfY0NSCRcJNpdyQYG9L+qTgl8jxHFTigC8PMRJxWAFrI/GuzX/zfiolpNSe4lPkW9yLYQopwgm/RG0C2i4XP+Aetqsprex+T1HDR/U5re6nIT8XJ1fQHQOMEDGpLwQLkHpPvUJAkjGpx47pZoPNyyTtW/IrwLhY/jj1JskeqFmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8QE9vOJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713409760; x=1744945760;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gdpvoPSSkaceUX91p44zx/T7T+yJtxFwZhYkjJcug88=;
  b=b8QE9vOJ9zVJyQi5xjbCQsbadt7YQyy9qhe/0l0yQfd+m+yBia4RTqKW
   ocv6mHEcK51yM9zV3ZBQ3B6236fCl2yXmfQP7RTqZrraEOYL89gUnyALv
   gLBW5H75Bpse1k6wT6qxVNL5wt6Q0xE2DGzyDTSYUiu/TQPLulAM3OmS6
   VkN9vsel9YiKQxrJ5loBkd4SALzoEGq4JlPs7uxO9SFTtKXRelU4qenqh
   SIiOopPfBzOxEHwRVJjBXVF/UspwrbywQEL8USFvDNEKWaPqXC2CsRlkV
   SZ/H309Xo3WJBjXJ7W16faQwOt6D+3vsDUEszJjs70Iv6rfHju9yfLqZG
   A==;
X-CSE-ConnectionGUID: f2dArqUYQWKSB9F1O+/Z8A==
X-CSE-MsgGUID: wJQEi+rxT9aA1raC0TAyOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12716537"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="12716537"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 20:09:19 -0700
X-CSE-ConnectionGUID: EYD7Z2KGT4qQcdiQWSj1yA==
X-CSE-MsgGUID: dLswo9SHTXmoDzkR8eD2TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27635960"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 20:09:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 20:09:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 20:09:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 20:09:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 20:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Idoh9mrHk4zWQA9uU5wauFGr7bfM336Zj+X4ortbyWGoMx2JHYcclmkVqCNpxcvzgFxmSoshmVrvoTX+jX+CXClGGGtRY9YTUkEhPmvB3kyaNQqvxWj1dTDn7aoToPU45ZOeEzeNAQL0yMnCg5npZDxpn+7cgiFgJhpi9CJkei7hFoJ8T+EixFJViFFWoCRpB4YLK1NGdck+NmpWGyg7NRLTg7MG0l13fZblAGUU7n74ED8H0tfjzZgJV00SRTFWyKNVCWd9CeNa6CYGsWXEc+F9S6VJmzpO2k6GojHJaOXRmzem58w58LEquB7Bz1R8sEQezQnRz+txDgbrsY8mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pEAoB40b5CFUpEX88P6E7/ji3occyzCX6CJZe5gP8g=;
 b=BTznwv+DssagR0IFiCCbeCFZUWq23GDGvoL0OMcz3cvdWtzO+MsEOLfns8Hx5s1vhhR0ZbET+d2hLMIKqn/mwsI9NSbd79TpOBelv5LigjM322BNzx62IFSKy8jgrLVr/RUhIbOKLidR34vb2rEsDBeVjYPEG8bWAJTVjxnYcBT5t7pmYcS9KHkAI1i2XYPZGFMFbjt+A0qqIrXZiUJe/RGKcS5Hm/aK/rl8xKZuidVNnODrMom5GgqCX4b9N4iljUl6zzek0T+Z4LSRnpGdHVtL0k/qOfyq4GXyCJZ7i0zctTA61YixAvtPLURxSf86ItcAhXAz32xyXIzwgy6WTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.53; Thu, 18 Apr
 2024 03:09:10 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 03:09:09 +0000
Date: Thu, 18 Apr 2024 11:08:57 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Abel Wu <wuyun.abel@bytedance.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, "Tiwei
 Bie" <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu
	<yujie.liu@intel.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZiCOybMoVyNK6gPT@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA3PR11MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd2b759-3ca7-4357-6981-08dc5f54ea59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3MJ0xNrUAE+CSGM1Cz83znxhadYfcFeVqu0zFUz4v58zokWA7m/fe3Bf816qTZcMQaaZbsMwKsz13t2/I6r/4L0yCnuBCtkbmuDvq2qFLcj+jS+8fR+H5pXRucxJtyMMA9KEwYdh47Bz2saFFdyJx6cXcM29T3drxFSYdoXa9b1EvzI1k1knRHUsYbfEcHOPJhmPAW4AL7C03/I1luLiMlYDlUrjEaOEEBp76oiNHuGUbtaWgJFJoiCA5eo9fUQ3CvikLAd3B7X3w09df5QygG+YaJsIE1fReyPjsXllqeNm6vnQVs40JSyVq2UUENK5qzXLqrIoIpM9YWt8wbKk1Mw4D34C5EgfhRK+6Ewf1+ILyV6ptlGuKfIoQK67tXCxLGctmuF3szlxtpwWoRTIja6064YSGiiK6CgdLFZl3zNsRstVuBKK8pupDp5ae0NDnK+gxYyZ+8w6woswEapknu1XnjlGBxE5F/b3eJZXzYS4V4+UPgqH4m3BD0QkVpuJdq0y86FROMfhbLlTsVUhXRiLNprRBay7OdvLGaqWPr078n65yiuuaZ0HkyrfvEKxo2Cwss3zcNBZkINNXvBves0T2/Dou4k+ZQJ2tp4NfxROUqNe61ZhEe27xQe/a39DIOdusi+xIQFnDvWXBCt0Bh6AuqunG13KM2NpL6S98k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjNPVHFQbk9yWVYvV2gzUWVLRUd4STRtWGIwT25qQk16dmNDcVQ2enVQaEll?=
 =?utf-8?B?dVlyZW1MRWtITUdPcGl6N1pDS0M5ci9ONGpvWE1PVDd6VkdHU3hsNmc3cFZp?=
 =?utf-8?B?eU9sRkhzaG93Z0hJdjFSdHhIS2Jza3R3L1ZwWml1VFpBTVcvc2IvL284aVlQ?=
 =?utf-8?B?NG4rZ2NPQ3ZpQUZFMnhLY2pVSzZnNDN5TTl2UzVNNkZwRUpqQ3hEK2dyOWFi?=
 =?utf-8?B?KzdHTUgzUFNINzJEN3dybmdVK0pEdGlNRVNNdW1zUy81eW9LUGc5NVcwS2xE?=
 =?utf-8?B?N09Tb3g4OVRaMXRtQjJhVW1nZTJ5Ri9SdHhyaU9HMzRvbXFVQ2JEUk4zS1dT?=
 =?utf-8?B?cGVCclluQlVUL0p0Rk5zbERrWW9aMkFkSzM5MHpvWGV3LzlQVm9iTFpMTnA4?=
 =?utf-8?B?dmNPc0pzSGFNeG4zVmxGL01NdzNqWkszLzFreWR6U3ZQdHgzV3lKMmw4bStz?=
 =?utf-8?B?OEVHUFlaNXRVVk1TZWI0VmtzUS95bTkvb2trOGI5VFNTZjVsODRBVlluQ0ND?=
 =?utf-8?B?U2lRdFVLNnFHQm9HTVZsWWNHWWdJcEVkVUd2Nnl5aVJoUnNwOVo3UFZYWnVn?=
 =?utf-8?B?OUdRclV3emtaZ0NESEh4ZlJyWTgvVXhpcFZoTEcxa0lUb1o4WFNqZjFGRXA1?=
 =?utf-8?B?OUs5anFnM0hCUVp2eXhlZ0dNYThLejNLVlhJWTFIbjFiMXMvalhML0QrcXhN?=
 =?utf-8?B?RVlOQyt0QW03U3ZSbEY4V2l1U0p5WFNIMVNEb0crNHg0OW12cGhSVkJ1WWtu?=
 =?utf-8?B?Q1RxUFZIZG1IVWs1NGRsVllqbzNLa2pnTnJPUUwxQmtwSXMrM1FKaUhFaVgv?=
 =?utf-8?B?ait4WnRPbU0xWWxTTTdzQkJqMS95eWFrTG9UZjdFaFpFcWllem0xWVQwb0F1?=
 =?utf-8?B?WkxJdmRjaEpDYkhIZkVleGdCYmY3aGtMOWM4T280VllKUkxKdVFaeG5nTkM5?=
 =?utf-8?B?Mlh3dHFVOXRrL2lsZS9vdmc5TEYxaWxFUkw4cXduRFFadUtiZUo2MEptSmNs?=
 =?utf-8?B?c0kxWTZCVmtnK2MwcmorWis5aUZZMldRS0JCUDNqQnFYZ25FdzlCZVdXSS9F?=
 =?utf-8?B?V1hRYUZLR3hmTkNjaFZZTEs5VElwNnZJVktrbnNpcHhpZEp2aExPbkVvaFlP?=
 =?utf-8?B?UXVWQVNscXh0WHQxcFpEd1Y0MWwyeWRqRVovbnpPMThheEhSbUtpcjBuS0FX?=
 =?utf-8?B?ZnY1aDJ4SklkT09vVExUYVF2YUlyWUFCVnp4Q1FEL01iTWNRR3cwa042a1NS?=
 =?utf-8?B?UkZkZkRLWit5MG1kMUhVdlViNWdFWjQwNDdNMW1JaTREdDYzWFcyaUN0bjVh?=
 =?utf-8?B?UlN0Z2RMd3BsSSs3TmhNZ2ZxOEpOdWFoUkVNZkE4Wk55OHhkYVZ1bW1id0dN?=
 =?utf-8?B?aWZhWGVwenBySDdLUTc4YzgvMEtITHE4MWRqS0RCRFU2eDZxdHRvdllRb2pN?=
 =?utf-8?B?QkVKYUFMdG5yMkVaelBNeDFXT1ZvVWQrWGVTUmxKVGRkYTBwUzM4RnUrY2tw?=
 =?utf-8?B?cVRjSGhSK21mTVFDY0w3bDZuMVJYK2h6eEFINFl6WkRPL2c5N21meDFYY01T?=
 =?utf-8?B?UnR4ZFQ5dGRmQ3ZMb2N1SXp5OThOa1grY2xjRlc3MlJBQ0RpallwQmZIOXBm?=
 =?utf-8?B?TWFqUTBhKysyTnIzUkgvNFc0OGdrNkhWU1ZYMzhreEhmRVY2L3JqdjhEaU1t?=
 =?utf-8?B?THZTajNoUk9TSXYzSDFzbm5ubzlBRlRSOUZ5TEhnRkVSczFaNExIU005QXFO?=
 =?utf-8?B?TG1RdWpZZDZsN0F3czVlMVVNdDVCVWU4eVlQRDlGYjV5UVY2N3loVWtqd0RQ?=
 =?utf-8?B?ank2bHRRL3NaK3ZDczJQSkFXU3JKR3hta2ppTXA5dTRsQWluMTU3WW15TFFa?=
 =?utf-8?B?R2tIWjU4bklTaWlQbVMxMnBqSjJpYkZpejhXby8wQXdqSlFvRDVZSWtScG03?=
 =?utf-8?B?K2d2MTlEbG1TcTAwT2pjbGpaa2haeDBVZ0JmTmFGRjFIRkp3b1orZFY0cXpx?=
 =?utf-8?B?SHo3Vy94c3ZoUldIZkZ3dk5XNmdBRTJxMWs1Y3I5d1ZmSXU0THFvZjQrbklL?=
 =?utf-8?B?b1JUUHhYQWZkN25GRktWYSt0bGNvV1UxZEtFTUZHWmFya0VFQktGT1kvWDVv?=
 =?utf-8?Q?+G3JbVwf5/GaPxb8lrstjsC1O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd2b759-3ca7-4357-6981-08dc5f54ea59
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:09:09.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d3nZEeFEfFIgWqWC1HDLMOiS2YumWrntDDLs9UNJoNk535V0aGIa7uCV8V4Py6883o+Fe+2tdfPZ4dB1lzgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

On 2024-04-18 at 10:57:22 +0800, Xuewen Yan wrote:
> Hi Yu
> 
> On Thu, Apr 18, 2024 at 2:35 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On 2024-04-09 at 11:21:04 +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 08, 2024 at 09:11:39PM +0800, Chen Yu wrote:
> > > > On 2024-04-08 at 13:58:33 +0200, Peter Zijlstra wrote:
> > > > > On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:
> > > > >
> > > > > > > According to the log, vruntime is 18435852013561943404, the
> > > > > > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > > > > > > thus:
> > > > > > > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> > > > > > >      delta * 2677 = 7733399554989275921
> > > > > > > that is to say, the multiply result overflow the s64, which turns the
> > > > > > > negative value into a positive value, thus eligible check fails.
> > > > > >
> > > > > > Indeed.
> > > > >
> > > > > From the data presented it looks like min_vruntime is wrong and needs
> > > > > update. If you can readily reproduce this, dump the vruntime of all
> > > > > tasks on the runqueue and see if min_vruntime is indeed correct.
> > > > >
> > > >
> > > > This was the dump of all the entities on the tree, from left to right,
> > >
> > > Oh, my bad, I thought it was the pick path.
> > >
> > > > and also from top down in middle order traverse, when this issue happens:
> > > >
> > > > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 cfs_rq->min_vruntime:763383370431
> > > > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> > > >                     min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> > > >
> > > >
> > > > [  514.536772][ T8390] Traverse rb-tree from left to right
> > > > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible  <-- leftmost se
> > > > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > >
> > > > [  514.538539][ T8390] Traverse rb-tree from topdown
> > > > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible   <-- root se
> > > > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > >
> > > > The tree looks like:
> > > >
> > > >           se (0xec1234e0)
> > > >                   |
> > > >                   |
> > > >                   ----> se (0xec4fcf20)
> > > >
> > > >
> > > > The root se 0xec1234e0 is also the leftmost se, its min_vruntime and
> > > > vruntime are both 763383370431, which is aligned with
> > > > cfs_rq->min_vruntime. It seems that the cfs_rq's min_vruntime gets
> > > > updated correctly, because it is monotonic increasing.
> > >
> > > Right.
> > >
> > > > My guess is that, for some reason, one newly forked se in a newly
> > > > created task group, in the rb-tree has not been picked for a long
> > > > time(maybe not eligible). Its vruntime stopped at the negative
> > > > value(near (unsigned long)(-(1LL << 20)) for a long time, its vruntime
> > > > is long behind the cfs_rq->vruntime, thus the overflow happens.
> > >
> > > I'll have to do the math again, but that's something in the order of not
> > > picking a task in about a day, that would be 'bad' :-)
> > >
> > > Is there any sane way to reproduce this, and how often does it happen?
> >
> > After adding some ftrace in place_entity() and pick_eevdf(), with the
> > help from Yujie in lkp, the issue was reproduced today. The reason why se's vruntime
> > is very small seems to be related to task group's reweight_entity():
> >
> > vlag = (s64)(avruntime - se->vruntime);
> > vlag = div_s64(vlag * old_weight, weight);
> > se->vruntime = avruntime - vlag;
> >
> > The vlag above is not limited by neither 2*se->slice nor TICK_NSEC,
> > if the new weight is very small, which is very likely, then the vlag
> > could be very large, results in a very small vruntime.
> >
> >
> > The followings are the details why I think above could bring problems:
> >
> > Here is the debug log printed by place_entity():
> >
> >
> > [  397.597268]cfs_rq:0xe75f7100
> >               cfs_rq.avg_vruntime:-1111846207333767
> >               cfs_rq.min_vruntime:810640668779
> >               avg_vruntime():686982466017
> >               curr(0xc59f4f20 rb_producer weight:15 vruntime:1447773196654 sum_exec_ns:187707021870 ctx(0 73)
> >               leftmost(0xeacb6e00 vruntime:332464705486 sum_exec_ns:78776125437 load:677)
> > ..
> >
> > [  397.877251]cfs_rq:0xe75f7100
> >               cfs_rq.avg_vruntime:-759390883821798
> >               cfs_rq.min_vruntime:810640668779
> >               avg_vruntime(): 689577229374
> >               curr(0xc59f4f20 rb_producer weight:15 vruntime:1453640907998 sum_ns:187792974673 ctx(0 73)
> >               leftmost(0xeacb6e00 vruntime:-59752941080010 sum_ns:78776125437 load:4)
> >
> >
> > The leftmost se is a task group, its vruntime reduces from 332464705486 to
> > -59752941080010, because its load reduced from 677 to 4 due to update_cfs_group()
> > on the tree entities.
> >
> > Back to reweight_entity():
> > vlag = avruntime - se->vruntime = 689577229374 - 332464705486 = 357112523888;
> > vlag = vlag * old_weight / weight = 357112523888 * 677 / 4 = 60441294668044;
> > se->vruntime = avruntime - vlag = -59751717438670;
> >
> > the new se vruntime -59751717438670 is close to what we printed -59752941080010,
> > consider that the avg_vruntime() vary.
> >
> > Then later this leftmost se has changed its load back and forth, and when the load is 2,
> > the vuntime has reached a dangerous threshold to trigger the s64 overflow in
> > eligible check:
> >
> > [  398.011991]cfs_rq:0xe75f7100
> >               cfs_rq.avg_vruntime:-11875977385353427
> >               cfs_rq.min_vruntime:810640668779
> >               cfs_rq.avg_load:96985
> >               leftmost(0xeacb6e00 vruntime:18446623907344963655 load:2)
> >
> > vruntime_eligible()
> > {
> >
> >    key = se.vruntime - cfs_rq.min_vruntime = -120977005256740;
> >    key * avg_load overflow s64...
> > }
> >
> > As a result the leftmost one can not be picked, and NULL is returned.
> >
> > One workaround patch I'm thinking of, if this analysis is in the
> > right direction, maybe I can have a test later:
> >
> > thanks,
> > Chenyu
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6e0968fb9ba8..7ab26cdc3487 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3965,8 +3965,13 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
> >          *         = V  - vl'
> >          */
> >         if (avruntime != se->vruntime) {
> > +               s64 limit;
> > +
> >                 vlag = (s64)(avruntime - se->vruntime);
> >                 vlag = div_s64(vlag * old_weight, weight);
> > +               /* TBD: using old weight or new weight? */
> > +               limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> > +               vlag = clamp(lag, -limit, limit);
> >                 se->vruntime = avruntime - vlag;
> >         }
> >
> 
> According to previous discussion:
> https://lore.kernel.org/all/CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xbx94w@mail.gmail.com/
> 
> Could this patch avoid this problem?
>

Ah, right, I did not notice your previous patch has also addressed the overflow in
reweight_eevdf(), as I was trying hard to reproduce the issue. Let me check your
patch in detail.

thanks,
Chenyu
 
> BR
> 
> > --
> > 2.25.1
> >
> >
> >

