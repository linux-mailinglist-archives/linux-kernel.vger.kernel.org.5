Return-Path: <linux-kernel+bounces-149542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AAA8A92A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76DAB21A09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EAC58119;
	Thu, 18 Apr 2024 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBGqP1ZJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37A54792
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419584; cv=fail; b=rUuYbq4n2rWPCKpI4WYtl9SrjBCE+naKN+uHtN9i2fKopZIoBH4M5jlNeZ8cXtQu75CPtn6SnYrwBf5cBRkVaAvbxv/WMonwiyeZOObm0H99Sb90CoPXlD3oC6pQ8ZvLQHaB+rrxSpSViIrQxCIyKIX+vvTnmpw0kMuEoXhhEeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419584; c=relaxed/simple;
	bh=NnVL1h4wKEM2YjC4orLhseD3TSwgVh1bSFt2WhIKgGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMCw3q3AZZhEK0HD6ouAmenOtXY5IEubAzT+kCD9lP7Tq9rnVkfLzBDwAXfbe8iEI4lmcxXNIHxomceGVzaeiGJvVjZuN0zYqWPavW7IK3Tc18n2EuWBhBbRrAfqe6MCiRqdw2HzIB16J0VJBioyvd16sunar67z84Gg/RG48Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBGqP1ZJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713419582; x=1744955582;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NnVL1h4wKEM2YjC4orLhseD3TSwgVh1bSFt2WhIKgGA=;
  b=IBGqP1ZJRSBFqDJAnMwImVAj0nyIM6CsO57SiPPjQ7CN+SdopkG2NjOF
   1e+/PKiyGPRSlCmM9P/3MS0brX+ZO1/r4Hgg9sf7U3CmpGi70+/5YGmzS
   S2UrKo/uwG+4pyy+eaY2sDi7l3Xy84qQbkydS5zcszNqOJrkhSFTvQqh9
   V6o5ZqlVwxJhRnW+2N7S+gC9AM6dSO34dL4YCf+4BClQ9Hz7Ofh6eQdkr
   OiMo/SIg+KfETVJspCen73RJtKXzvmqORTSDXcCSwlCMLMuNXwyH94N39
   kWJaOOO4WW7i4mWpoDAk0IEUcwk67/HzFOqNHIK5O1HBQ4q40/4Xg8JZ8
   g==;
X-CSE-ConnectionGUID: 2k10LshZTR2pLBWWgPCssA==
X-CSE-MsgGUID: O3SyzXVyQLOaEZvZMHWDkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12727297"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="12727297"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:53:01 -0700
X-CSE-ConnectionGUID: a619fSl8QkC6/c8fyeapWg==
X-CSE-MsgGUID: Nsf6dMkeRoaigtc6bsoiww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27498793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:53:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:53:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:53:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:53:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSLd9Wd2O90Kfvq+piKFYl4ZwaYCC4astvaUzdFSAzKEaWqzgjteueLQ3No05RRBCpoWWe2uYkB40Y/QBo1f2Vq2T0jNAvOUKRe5QyXBIOUCJWW43iq60ZOyAaZCbc4Cu3tO/mM3f0ISBlQJwaYfyGA/bl4oCX5DzQmUbcrI+sz7u7weKjBwhnRK7e6WNBAfsx55ietzrNgYgkaAFQz5pEyqgP8nB7hdW1iqGgnsPQV9bwoJNbdF8DoAKzZQXFdZW1LeY6EMuE3pQDDyNH7JuJ9jfIN1ykiwkrrn9uJ2D9lIG5zVRJrHszZZtJiyioh8Ejw0WEizLgw18uNVZHeZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ5bNSV5PVcw2+ryJ6MPz+W4izTVo9mBS3FjgP8MWFQ=;
 b=bI3/OfPdAeQCS80ORhLR0FijxISc8FVSEV4D98Nl8wj7wc/TI+FtXESSfGkaI21hn1cQppsCNJCO9qIi7UVbAtFMzHN7VR8++hb41/Bd714XTqSDPE7U7ObTHnVYySA7wfqDdsl3NvBCBx1EW5Epkerra2HBy0WUyONjPSeKactFUKFD2IXjuWvvKI8dcmH6hJB4Gg2jNfWal7k+THdzXhO97MInoYyUBjUTbIZeYgYcvwwbcpRHHq53YzXUJdkOCMhSccJbxwak+IczEXP946xgy11WfvaXuj+3bS2BXZ/DebQH0CpNELSWyN9WisTZ+MBVoPmZjG0JTNknT03/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Thu, 18 Apr
 2024 05:52:58 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 05:52:58 +0000
Date: Thu, 18 Apr 2024 13:52:46 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
CC: Xuewen Yan <xuewen.yan94@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Abel Wu <wuyun.abel@bytedance.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Aaron
 Lu" <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu
	<yujie.liu@intel.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZiC1LuqGAXGHgeDo@chenyu5-mobl2>
References: <ZiCOybMoVyNK6gPT@chenyu5-mobl2>
 <c3959f3e-ca17-4c27-9dd2-504b95f2653c@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3959f3e-ca17-4c27-9dd2-504b95f2653c@linux.alibaba.com>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f50a45-c82d-40d7-0d2d-08dc5f6bccf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NqLy+XP7+VM5hqgQWjQU/EGQwnlp+ptW6rXSJbzews/Z4OLUd3k1xlDnoerVLq6ypxztwdJMehCye/FHhDXW1QoT3DKApSLee/1kVdg/dn4UbRD/o9UjuHyNJoW/JUb69pehDSGJsdz3t7rPnPXOmCx+D7Au7BpgpsQmHPp52K6CXoJvn1+cyETLfWQMaXL7j3Q9W2UEgPq03uQ0pvttZGO+niJ6kdJNCqGyj/f0MS/NXgwVxiwkP1iohaZjTycMZ5w09ajmgSEUVezkpyedoH2TTTfdV91IOgxqRi/qrSWz3HB+dTgjInpjpHLjJk7OvXxhwOuQJYm9yOfIlm8VFEaAmYm/VjVX7WN7JoTAGM9UNe012+JfELp0ePrNdfVHKId8wP50+dK3mqBhZSLyegXv8ikPjb33Yb7Wi5FuL6i4jch0CcFZSzR6OLbomaL8lTVKB+U1jtFKGdINrRDBLkK/exlmgE/hPjp5YF5AC+hs4khNMF9lZZVnkkIdaG1S0FfOAhCLbHlWVccsVQhFzp2iBzDsZf6Ewc+FLBOEfromunozwgvRyh+7zhAuuYsIdPWmrC0GgCAhh0FmIjwzPj5CxVQhhWAyWOqf+FmZrUK/7DhylsxCsnuHziM3v/LTMqR7Y1TI7HXl+QIKdMtw4S1tdaFBM8hEidf2CdwPnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gVJESWxFBqM12irG7pkfZtM0W9W47ymDPwJ44MQn82Wd+VHhxpJZAAVSY9KE?=
 =?us-ascii?Q?5ZawHDz9cbVIrUAW3vTUCK4+xWDYb4uVTw1nzryOg9hZF+7t1xNxUHL3B2Oy?=
 =?us-ascii?Q?WHIYayC8VqGtXC5No2PWfcEL3skj+jUgIke6YD3B7F2rsTsSunQgHfykQzTQ?=
 =?us-ascii?Q?C88DQf2iWwdv99Q5rIAeKapLjQht5LZ23zsK5UVplkedr84clmw7t9CQbb+h?=
 =?us-ascii?Q?MHFohGV7RXOk8oOHhiAquRQdCI/hjXgK8TTYjvsCtLCpxGRif4AhLhz4tmiM?=
 =?us-ascii?Q?51iJLXJv20MUnlPhgFRn6n+a8h1EEiEw2NdzZbAwNVUhWYsr0KSchsFJJUOg?=
 =?us-ascii?Q?NQVdWG1/67IvaQV/SMqTOuSTZU3ON+OIdHSiPxvCrXmKAuFRzxZCMt9aJGCq?=
 =?us-ascii?Q?GTcHaQVV4bebjOgmPMLEPKRX+W9patn4PK5TBThtRLl/9fG7TwysBRAdJa/d?=
 =?us-ascii?Q?ZxJIIGvya4IrDHrndKDJ97LUB/fAjjVgO9rmNCddDSNbrLhsw3wyOBVZRc3f?=
 =?us-ascii?Q?0Tw5kFlyUHWSSgim6wgB/RQGf9hVm0d2p3nLR5PdR2h/B1qqAaGS/4Ed+rCO?=
 =?us-ascii?Q?ti8xVaTdO5Y1DQgLKCncHdQrWTsnQ9DNSy7zXcjvlXMpL9wMK4vtXlcqTZTY?=
 =?us-ascii?Q?7P2m6r8AHasyTnbEqIZVRi3uqR/omBZJ6QuoKdOxyl+T78q6gSdR/u6MCpC2?=
 =?us-ascii?Q?NoCKiXLenGQA8tSADVXkMjvvV8r+LQmXsfzFrj5ExNP0rGTRtUMzqBWLg2xo?=
 =?us-ascii?Q?CaLMeZOY9wJh5y2tIhEQaKDLuSyDO0OfMUwNgNdw/2o5pk0kfzACyFCtcfX8?=
 =?us-ascii?Q?LzZDd3AzCJ/z7qR6LE67OogRMqf++/gg+MGB+NtF13v9qp3mHElyuM0wZUYE?=
 =?us-ascii?Q?M3wP0BekT2t7c+T3crZhpwsMzTO+UZI3vXbscwtuEq5/N+FZsVW0dW738xkh?=
 =?us-ascii?Q?sx27BoU1kBvIDgN3N05LSgGKRJbHwY+bd7ozpwBI0j5U/0PG2h2bRklX6Uu4?=
 =?us-ascii?Q?3E7IxiXJS2BJDOUTZRvzHvdYjfdYNGBQ745Rrhoy8y5M4Xe6y/YskJV6xBsH?=
 =?us-ascii?Q?yUaai0xnm/ULTgwzzQTm6WaeTYvKd3pqhXZIxNrhR8RIqum6BtxKM1MutlzD?=
 =?us-ascii?Q?Krb2LLK1FCRSkMbqiYEHxTZngh363UqP5MQmVEWpU6CBlIbkRYsIRo/SQ0Ma?=
 =?us-ascii?Q?pZL6+crDEoOl/AzfB5lXs069kIMPdPO9+qNmOvMRqvQ2VxSABTXQzlhjgEcB?=
 =?us-ascii?Q?hCUhNvhAfB0eh29Q6PZsNCSrPdsVUJ3o8TeN9gz+AEG6wo7g0HbuxQ2WniPu?=
 =?us-ascii?Q?AO2RxkdnK26VjxaKRUxIvexrUibbB3Lf+AbbQkjlzSiyMRYJirrZf8YLkfwc?=
 =?us-ascii?Q?PXHcBqQmwQQ4VLfAdsxgrpEH34ILRwpkWWyM9v42WZhHSAFW13sVJH0ruhkA?=
 =?us-ascii?Q?u30Sy90mOJ43MWbob0Of/McNoKzqVv6ESRsgvAX5ypimmklPbcGr0kczL2yc?=
 =?us-ascii?Q?Od/Tez8Abb7grO0CmzOBu2XZq30sbgh3+iEUF9O42YTo+X0s4xaxqpSEJdMc?=
 =?us-ascii?Q?O8iKP+C+Mk3t4ErxKIZLxT7lY2HdIf26hU9VB06W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f50a45-c82d-40d7-0d2d-08dc5f6bccf7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:52:58.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31dYwwPsKeZWmXPxH2KRzdBarWhfsnLiHquTvtVl0YdlMN9NRKY59lkE8/fGOrM6tXkPlp3VBk0BHX11nYI0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
X-OriginatorOrg: intel.com

On 2024-04-18 at 11:37:31 +0800, Tianchen Ding wrote:
> Hi, we've found a bug about reweight_eevdf(). Would you also please try this
> patchset?
> 
> https://lore.kernel.org/all/20240306022133.81008-1-dtcccc@linux.alibaba.com/
>

Sure, I'll have a try after I test Xuewen's patch. I assume your fix is mainly in
2/2 which adjusts the se->vruntime in reweight_eevdf() by using the correct
avg_vruntime(), although it might not be directly related to the s64 overflow issue
here, it is worthy a fix.

thanks,
Chenyu 

