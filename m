Return-Path: <linux-kernel+bounces-154393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E88ADB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597AD1F22C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015A12E40;
	Tue, 23 Apr 2024 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiTAkqd3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C293FF4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835997; cv=fail; b=ivy6eXPmBF5K7mQ72v1Fp9MQys2yp+ffP9+sHWIvC/6RpmB+y5HVmypjpa19kZ76iaIApAzb74u71zLQrkhLAaKKuQFUgG4+bZuhW4CSVdND1xEp9vHps1zv+jthndVibHKZGm7KwBMfFzOlC4fbXs/mgJVqpD9HdNKW3zgqhK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835997; c=relaxed/simple;
	bh=cY4J1g5vgf2oHjXbin0ZPxqSYMzD01409NeDN/M4Ib4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HFjcIz+tSe5e2hkckwUeXFz4nKCG+auhuZO4Cfwnskeo4Q9tJCTPGIYa4XPjnp68/1GfrAGdI0Q7V3B3OvXvPc1YZuB3ZgJiuJAqXgNjHBsm8eSDnxyKyrQB4YSyvYLx1QmkOMlpnWM+geScufOIaBxfekL8D18S5thv74O6jhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiTAkqd3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713835994; x=1745371994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cY4J1g5vgf2oHjXbin0ZPxqSYMzD01409NeDN/M4Ib4=;
  b=RiTAkqd3jkmSHzRaI0VmDXiwm6+w9vTq/SgH84MJyxaPXickVZnPA5Vy
   v9VyhbIr/yZXUDbbeTtu75uznESIFJi1FXrccKLiX6Lw7dhPyn7S+EQBF
   SR+Mq9GDXIjX1z1Nfp5a8BT/+wNYX6E9D4OhkJg7hOqFhWPhaK5evUcII
   sUUkE0lGk+kgi6Q2pcm5iZqpeMMQnS14jxeTegfe3aqCvnSUeqoTwyqIc
   S1gSzYm6DQN+TcOfkwY4P4hcSlAa8yfRLG8z/73sDkR055E/t/QrgIb8a
   TUNDOGjM+UoZBkFBCR400iNuj6+4zpkiicOmRWbuRtIovt1RuZJb7ifzR
   g==;
X-CSE-ConnectionGUID: TzQpx631T2uwIeTKr9PM3Q==
X-CSE-MsgGUID: JQQ9lX8dRI6Za2f9e/zkYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9319819"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9319819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:33:14 -0700
X-CSE-ConnectionGUID: QyG7NvekQdGxHfI1YV32KQ==
X-CSE-MsgGUID: PQILOsViSReHVzrccolDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61650909"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 18:33:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 18:33:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 18:33:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 18:33:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 18:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bav4gxDcwcBMs+L9o8QaYZOWep73Dt63XX7+vdZxrPJP08AQayUyGafQcV/zTNHyRWpLyMw6C9exTmykTFlPWQSyPFG7MkXw2QIg5NUt7jUXupJpE+AnX9iTNG2QMh2lPs2+QtBmb3ABMPetJ78Tucp9n3DAVC7oErI/1tCy1n5MePGxST3D7DsbrWTQa0SacEBKbJ5UWatMZhY2NYyAK/nnuaygEdNi5Nrt05jEhY807xw4mVzIJMgYNnJT4OGNA/gwNTyaQop3NdfApM2N9pD7LdZ0zRq7jnjrMPleDMtFNQcWKksOoNqCj9vQfkJJ+TEMDuLz0FP9U6uv+AbMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L+glS4ZYwCT8nd7ILt9W9fToHRIcIO+XIoUZY7xw+4=;
 b=TU9rrZxLUKnbwguh80yy8YutabcqW6PrX4waZ7wFMHapDIuXn5L2IA5Rax8WQ+EL3PuZzd9XKc+vv/Jy1dKgUJ0NwcSzaR6c0ieoOvj1pn1T/YSX3LvhTbgmut66GKeTIPbkZgNvpOR34mUM8E95ci0XTlFhoFPejRspGSc6zH6i/ggG+2Q7lnpQC3H96JflnL+GV6PiA10jJklZsv5bGRfnzE4WPrRIESA4r0rOwTjtqzBMazEWF4z8dNm5h69Mr+6ZWmVbteLUJpbaaH5R/2bkWijLvswCqGgRiyURcYtotEUqJxIrvqVK+WOWJXEe4SkR8PlH1wWIfIqVsk17CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 01:33:10 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7519.018; Tue, 23 Apr 2024
 01:33:10 +0000
Date: Tue, 23 Apr 2024 09:26:34 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Chen Yu <yu.c.chen@intel.com>
CC: Xuewen Yan <xuewen.yan@unisoc.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>, <di.shen@unisoc.com>,
	<linux-kernel@vger.kernel.org>, Sergei Trofimovich <slyich@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, Igor Raits <igor@gooddata.com>, Tim Chen
	<tim.c.chen@intel.com>
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
Message-ID: <ZicOSiEWHJJcahi/@yujie-X299>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
 <ZiYkI4qn2nvdmktq@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZiYkI4qn2nvdmktq@chenyu5-mobl2>
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4234ab-e712-463e-8a5b-08dc633555bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ecMVvlfTQbAwULfIj27U+501Zt6IMgYAnG//DXyhap6Fu6KIfdlaIb4JAtY?=
 =?us-ascii?Q?hLhyltc7dOoaiYsUfFeMIM6N46UDQj8xfk2VOOe9AT/m4R2xYfo4hrsEmxyL?=
 =?us-ascii?Q?ewfwAaVuKVn02Y6zl7Lh+IiLMjPKS0AKx/RQ3zKv7YhtGzMj1N6QmRG6gQzS?=
 =?us-ascii?Q?4C7RuJwVhiS6CHHUjKZ9a1tVj+ny11tf4u09MF5xTDormU1sKY/DDIOZt2lZ?=
 =?us-ascii?Q?t10caPtXnInPtj31wKArVj14uof+ipmMFOPgldge+OJZCVKTXaNij4XzQPle?=
 =?us-ascii?Q?rGPoP/pJSmODviExl/Ntf+OxIrIOa2dWc/ORfb23K31FZ4L70D0W2hQ6YKDB?=
 =?us-ascii?Q?nIDeZKT5AXp670f3xtfr8j0LEEqpy1Yuoq6qZw3D9EgBTWWj8pDSVMbUJ5LB?=
 =?us-ascii?Q?rwEDFjWEdmLiaaPS/AU5Oh3RWCytkcHEylcAu9LMiGAUOFhHOFyBeUhHBhuw?=
 =?us-ascii?Q?VCa9BYbqUkO3pNiQoocJeAhRhw+LKmC0B9mmI2ZIeOoLllihXBNTyzdNvtC3?=
 =?us-ascii?Q?lM/AP3mr9JSXrMVRLeYzfH8OeEoaTJMJZGwJLewgV5lzmW7kuR5KGa3sfbmZ?=
 =?us-ascii?Q?Hp0/6urT/5Vinwxkzc2S4rvKF90njhQXo9Wnu+2IKX8Jm8gP37RvA90yPF2i?=
 =?us-ascii?Q?1ME7yVAfEH55xILzVLttkye96HkzgUQmbvCIjGsMNLPYXltV0Edb8nIFtuSB?=
 =?us-ascii?Q?ZpYtRV0WvP/A+RL4oLBj9yMpD+b7j5gApnuFBZ1LxYS5SkesavSHiXls7s/Q?=
 =?us-ascii?Q?ebS3ayE25FjNA2JeTMhReDda4EaaTYfeq6Pn8s3hgHdzMRgfVXCA4vhY0xfj?=
 =?us-ascii?Q?rK4dSbDlzUGXjyubLV1o+xSEfoXU7N6qiKOZYAUMgPx37RkBMqiODQThX2Bg?=
 =?us-ascii?Q?Ju1O1QG+vK9CJjdxJDyrQ/CfCFDkRJdIqanyvjK7FpKMXQKCzxYGjNt7kuYY?=
 =?us-ascii?Q?V80d+usjIHk/aJVO1Ymt3Otbhp24W28gY08sAe0MpXG9Fm4cDkwC9y4HuEKZ?=
 =?us-ascii?Q?njMdUTOLmvajAFJV9UkzNIPePd2A8aJk34TmAZpWdF99fHYkSCCeMXL5wfQ3?=
 =?us-ascii?Q?RNayK3MTqmp2n3WYS4OPhaUm24RwP+6+Yox7USV51mJh2v38lnbU0uSbTeLr?=
 =?us-ascii?Q?D7IEp4e4F43yqG6CHX/4t+K5EIDGgMso77d3oy3qyZO/XjHynp1pfWNTSKaM?=
 =?us-ascii?Q?JI4o6vWiiUd8oeBq5uMMSAWpJwmTejKIOHw5+RSYvRLJMD37eyjTslMN4H0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sUd2EqudohJ72j/AETG/7L6WsbyRyseo7i2IsOSFDYL+4jN7XejZq0cGShMv?=
 =?us-ascii?Q?tVS2uh3zxZfmtklKp4wWKCuP1WvkRCF9Qx+/VCJOSFARvUvTeKoUTnAXvreC?=
 =?us-ascii?Q?bjm7WpFJDUpmfDgI3j5WVySX4g6KUAPSiXrkG7hb5iiWJvPM22WZb/oQtnQX?=
 =?us-ascii?Q?S6Ie455YicMFd3vxy5iNb8+/f7o+/OABZUFC2PEhdFz+P1gJRu0pPWiqF1u2?=
 =?us-ascii?Q?Bj+ZoSkZ1enGKlorUKQjF0lK0e8dDLn34sjj/0r1G1cb1E311a39Ypggyqe1?=
 =?us-ascii?Q?kWqWqJAQm/Zx+KHpcI2gM4f0OvsDlxfPmILqbib7CVo33OyZThm3xoDzXkuc?=
 =?us-ascii?Q?VKevHXkhy0JVXlbgaeXqqVx157xtgx2R6H/dtkMRf6V1akccn5jc9VbssMbB?=
 =?us-ascii?Q?8T4qdhktPxEsSy8juWh2znBfatr3CYsJomMEHHJDHBJsAzjpItrBktgkYZ7c?=
 =?us-ascii?Q?AnUpIxdu9G7bPlEbfGavrkmE2zYfdRssF0qr8xtu1d4Rsclkvw5CCTkj+UI9?=
 =?us-ascii?Q?r5rZfX6Qv8A0e6VJ/7BS1LMMO8C/yeMPBVmqAvPlWEwBw4/LBHaatNjPw97m?=
 =?us-ascii?Q?kyOIDW6V4HoP6UgnV0a8doJSg0HXN1sG+h4tQRpbleE9zz/ZlKAbNuyjXPp1?=
 =?us-ascii?Q?GzXpg9xMsGzUWRRMb5vRmOMslLIeaz6tVcjJB1dN6fLkhVtAsjJFuTf/Cdld?=
 =?us-ascii?Q?EPAvPz/32jlqhV9pAcDmaNq4YYkom9fRmpSrLOrtHJEER2dTnqgniOwFW/YJ?=
 =?us-ascii?Q?1ySwiCLW3aOXmaiNBcRkFdXF6lDmUmh2UiQQW4bj19bf2ak7H67BZCg48geE?=
 =?us-ascii?Q?Cl6gWkqCsFdMcuMxkD5BnxvB0PncQoacUZDdTtGxzzFDSeT6HbIuy6c4Kx33?=
 =?us-ascii?Q?+ay9HZEQ9BCEf8slAohYgT5CbCaJo7ov/JZRWLqLaCAHZlLH0XAtaH1sqN8n?=
 =?us-ascii?Q?MwTGmLBjRG0D3GcVByQybcOsMciOuMGot5MxF+5TzPVmrAjOF0YlLRycsh24?=
 =?us-ascii?Q?o+IC3+UUuMegO5hWVhMZRhguDqp/E7tqPDiFJjd6yssSwbsZbCPA4ZWEAAJZ?=
 =?us-ascii?Q?NBcvKMD032ozvqJZQSWapBYjha9B3ZN5Q8orlkPSEOsw9kKNED3KwhVKbf6J?=
 =?us-ascii?Q?Q0/aT8TrSw0w8cZMQbHgO6Bd4aso2UQwBOqdzteux9IqZrl/kVSK6WmE3M4/?=
 =?us-ascii?Q?6M/pwLGa81/j52cT+0Iomr1H2+ZyzefisQCc2BZFEyCZ7TcM/N6YSf8Jn6/v?=
 =?us-ascii?Q?vC5Wz70WNG8MnslIKtUyw7V3K5YZp56sTavbp07lNFcxWxNxQrc0bxp6h2+b?=
 =?us-ascii?Q?wiz3MLyXjPs399h8nG3XtnG0/iajmm0SBbfgKrYZdzvyuplxBo6TjNuZ1xA7?=
 =?us-ascii?Q?eK0pVsxti7vpB9Wz1jwTDN5HggdiMohczFxCyIeDC0D2f7pWphO4YQDwMRDE?=
 =?us-ascii?Q?v67bbDSFzzG6b5LAg90Sn7+B2TVs6vQ3HwSVQhOrdC8YvM1/dWmPEZkcQf7U?=
 =?us-ascii?Q?aAFtwHb1isEE/5bmSC5fxEHp5yBWBW9uPMsn9RCDRYJ5rTIMM1Ctud33s/bm?=
 =?us-ascii?Q?nmSu6iJhuEp/nGhHNbuja8c9f15OVl7P7R8PJJZP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4234ab-e712-463e-8a5b-08dc633555bd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 01:33:10.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TZbFkCbefBRrTD8wXU70OPlYSZTrn7Y4Yai1TaKMNGlOHI7g6JOx1ZBEFXLuEkSHkHt3UpUA6Zyyy9gAJePGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com

On Mon, Apr 22, 2024 at 04:47:31PM +0800, Chen Yu wrote:
> On 2024-04-22 at 16:22:38 +0800, Xuewen Yan wrote:
> > kernel encounters the following error when running workload:
> > 
> > BUG: kernel NULL pointer dereference, address: 0000002c
> > EIP: set_next_entity (fair.c:?)
> > 
> > which was caused by NULL pointer returned by pick_eevdf().
> > 
> > Further investigation has shown that, the entity_eligible() has an
> > false-negative issue when the entity's vruntime is far behind the
> > cfs_rq.min_vruntime that, the (vruntime - cfs_rq->min_vruntime) * load
> > caused a s64 overflow, thus every entity on the rb-tree is not
> > eligible, which results in a NULL candidate.
> > 
> > The reason why entity's vruntime is far behind the cfs_rq.min_vruntime
> > is because during a on_rq task group's update_cfs_group()->reweight_eevdf(),
> > there is no limit on the new entity's vlag. If the new weight is much
> > smaller than the old one,
> > 
> > vlag = div_s64(vlag * old_weight, weight)
> > 
> > generates a huge vlag, and results in very small(negative) vruntime.
> > 
> > Thus limit the range of vlag accordingly.
> >
> 
> Thanks for the fix.
> 
> Might also add comments from Tim suggested here:
> https://lore.kernel.org/lkml/ec479251e6245148b89b226f734192f6d5343bbc.camel@linux.intel.com/
> 
> A fix tag might be needed.
> Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
>  
> > Reported-by: Sergei Trofimovich <slyich@gmail.com>
> > Closes: https://lore.kernel.org/all/ZhuYyrh3mweP_Kd8@nz.home/
> > Reported-by: Igor Raits <igor@gooddata.com>
> > Closes: https://lore.kernel.org/all/CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ftSix+KjiTVxg8nw@mail.gmail.com/
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
> > Reported-by: Yujie Liu <yujie.liu@intel.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> 
> Cced Sergei, Igor, Breno who have encountered this NULL pointer issue before.
> 
> From my testing, with this applied I did not see the NULL pointer exception
> after running trinity for 100 cycles, so
> 
> Reviewed-and-tested-by: Chen Yu <yu.c.chen@intel.com>
> 
> thanks,
> Chenyu
> 

From 0-Day testing, with this patch applied on v6.9-rc5, we no longer
see the NULL pointer issue in 999 cycles of trinity test.

Tested-by: Yujie Liu <yujie.liu@intel.com>

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb/trinity/debian-11.1-i386-20220923.cgz/i386-randconfig-004-20240122/clang-17/300s/group-03/5

commit:
  v6.9-rc5
  v6.9-rc5+patch ("sched/eevdf: Prevent vlag from going out of bounds when reweight_eevdf")

        v6.9-rc5              v6.9-rc5+patch
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         41:999         -4%            :999   dmesg.BUG:kernel_NULL_pointer_dereference,address
         24:999         -2%            :999   dmesg.EIP:pick_next_task_fair
         17:999         -2%            :999   dmesg.EIP:set_next_entity
         41:999         -4%            :999   dmesg.Kernel_panic-not_syncing:Fatal_exception
         41:999         -4%            :999   dmesg.Oops:#[##]

> > changes of v2:
> > -add reported-by (suggested by <yu.c.chen@intel.com>)
> > -remork the changelog (<yu.c.chen@intel.com>)
> > -remove the judgement of fork (Peter)
> > -remove the !on_rq case. (Peter)
> > ---
> > Previous discussion link:
> > https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
> > https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com/
> > ---
> > ---
> >  kernel/sched/fair.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 03be0d1330a6..64826f406d6d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -696,15 +696,21 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
> >   *
> >   * XXX could add max_slice to the augmented data to track this.
> >   */
> > -static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > +static s64 entity_lag(u64 avruntime, struct sched_entity *se)
> >  {
> > -	s64 lag, limit;
> > +	s64 vlag, limit;
> > +
> > +	vlag = avruntime - se->vruntime;
> > +	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> > +
> > +	return clamp(vlag, -limit, limit);
> > +}
> >  
> > +static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > +{
> >  	SCHED_WARN_ON(!se->on_rq);
> > -	lag = avg_vruntime(cfs_rq) - se->vruntime;
> >  
> > -	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> > -	se->vlag = clamp(lag, -limit, limit);
> > +	se->vlag = entity_lag(avg_vruntime(cfs_rq), se);
> >  }
> >  
> >  /*
> > @@ -3761,7 +3767,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
> >  	 *	   = V  - vl'
> >  	 */
> >  	if (avruntime != se->vruntime) {
> > -		vlag = (s64)(avruntime - se->vruntime);
> > +		vlag = entity_lag(avruntime, se);
> >  		vlag = div_s64(vlag * old_weight, weight);
> >  		se->vruntime = avruntime - vlag;
> >  	}
> > -- 
> > 2.25.1
> > 

