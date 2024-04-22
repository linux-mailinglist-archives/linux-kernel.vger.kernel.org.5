Return-Path: <linux-kernel+bounces-154063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D38AD6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324DAB2202D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B21CF8D;
	Mon, 22 Apr 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpfaahlW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4141C6B7;
	Mon, 22 Apr 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822531; cv=fail; b=N9JfauGdTgObDVBW4C63pcBYldgaYmTeXYyFNROrVQCTGe2cWXrWZbMhnF44Rc2uFoau/FnnMrCigqFKR6W+VKKK0aFE3nr9LTiCGkZCeDeLzzi/h/AoPgA2rH31amcSUzJfl4T+SD2+o0nC33uSk5svEGCedYM4SwsUmeGub3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822531; c=relaxed/simple;
	bh=UT7Y2Mr8AGvM7vg29ORuQthu/WabBYPHtWl8YPqS0Oc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDbx8BwgQhjx+vCXvQ7ZE1p5DhGwEHgRsdJB4mcSh2ALDs9niMpIuovm/CfmfSvwbXbzj4aXtcxHlqPUFnQXfymO/P5Uv8ADGMWxvlrFW+VvhMsCjQI5t60U1Xb44JrZVL2q+GrdOoipsneD8TpI+LNr7tYzp1dRhhyZ+tfPMWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpfaahlW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713822530; x=1745358530;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UT7Y2Mr8AGvM7vg29ORuQthu/WabBYPHtWl8YPqS0Oc=;
  b=hpfaahlWO3RLusZilDkJ8CQ8B/XJiEMErAt1jqKkXsm8ibUrQ5UZESeb
   GGiZp9Q81Cpk9dTFAy6q2Aors3klfnFRKYYFTneQc5a2Ga+Jl3Ou7RWsH
   NcYL90ON2o1aCV84H63Uc9Bg5TARR37lnRFaP49hWUEjXcFMlXtYSEtvT
   KOiy8DafT8XaU4nareZ6pRR+hvmCciOiiFgUroZKB1dx177m7o50gsYa0
   xwCpjcNEpwlg0l0N27//B/WP/LfYteyFcE2mN3ChrlWBIpSb0/aeK2p3s
   tyFyKAs3NK6o2dQaHJ8lZPBgnQCpnOEkzjPVuq4HSoHZNQzYpkjaGy/ea
   g==;
X-CSE-ConnectionGUID: WKEvgIHyR1SMpeOFGNTd4Q==
X-CSE-MsgGUID: OT9+f6R6TcG6xNnLgPOaQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="34783616"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="34783616"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:48:49 -0700
X-CSE-ConnectionGUID: pD8c/uHfQAaj+y8b4okNFQ==
X-CSE-MsgGUID: OgxtCCIJQdySzSbCKwNuNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24196527"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 14:48:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 14:48:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 14:48:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 14:48:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 14:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYPsXEPTER/I/EMlUZTOHULr7AfzyAVspKPfdytlJXdJckh9U5kmT8EmPXF8rNwW+29GXbi4GNKb7Zvc8AyIrfox4cYE2AWBuWJMBcqFhshcJlAIwWRXjtOcdhaL2P1ogZ57qgzrygjlHneQ7C3RPY+RIMVuPGX1e4e3TnqrlDDb8aR2BFHepxeZkwkCtmJUXtwJvzcdjDiJHzoBvmgP/3V4QJs1ljLEQqwfsiv242uOH4x+/N4Yp6osw1WHUwxtyG3KpxFO95d4aQbiqyQ2Zl2tKVId9nDY3qzd4NYbzj/FIPshiB7Cj3JisxvVO9+NcGpfM8bNInOdPRH1KFc7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNgcodKGmNQKTJuxwE0s8SWpQBVnNJDka09HaWTVCgI=;
 b=gCORXeQKUorMFci07xTGJMxALQKDjHtpt4j+SLD7HiqTGMn8fXDWt35a4EeiOGhFcRqimJzyhPcGHsLRBk+5TolTM+6jZ89E7tzNZjNKpYTEHVV4qrPjMH09Y97KVoKwsUjbRwkn3Jr0ayVpDy8MOPPw9F7VgSXCG8WOdJHfKYGbMvt9+lqMXaV5LwNiULVU8/fGcmxAAINYCjPMK+UDgYsFmUN0nEqHy1cyjEOOu564igEzrJWMWlw7HT8JmiZtdqBqOBt+lGbDuMbqDA/6WX9KTtLo+O2rSLyE0M8UTMELycCPf88TvHhbJUjDYkqBYXRpQIKixY6Vf0IVmxASGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 21:48:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 21:48:45 +0000
Date: Mon, 22 Apr 2024 14:48:42 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl: Fix use of phys_to_target_node() for x86
Message-ID: <6626db3a92695_ab56529463@iweiny-mobl.notmuch>
References: <20240419140109.1996590-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140109.1996590-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c96f49e-b525-414a-a597-08dc6315fc3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UlLFy4jSfXTwhXKesWIou6yXpqsRji0BVRcOiTe9xUuIoQgouB64OxZRS55f?=
 =?us-ascii?Q?pfj5AVqq+4qULDBx8902rjoRdIDExMZJsdxkarKvnWlSxjR6/n5uzL1x19ph?=
 =?us-ascii?Q?xzocr//XdPON30DiqzgWtooGm108yl9ZSMBzRQzBi+Iu3mHC1M+Bw26uvHhR?=
 =?us-ascii?Q?ID48Jj0JGZ0iaG+euTwARoPZ9i+l/TSa7gqi6GdS7Fm49sbx+yQdADzCUBfp?=
 =?us-ascii?Q?sNvT8Q6J9hAebbRyI+ckccrb1BWPFJGHn1RVu6jZxMBKsE6LidEMN7KXRd+o?=
 =?us-ascii?Q?USoUmDOuXBwhccNEBQgy0R8t46Jka9wyarqWVGM4mvKqkzU/7Z2dJGymuExt?=
 =?us-ascii?Q?ZNDG5tm7myVy2S7Y/YvoVInW1vFXbg6tuOytAhvONRMqxVsB+J8WtaKHY0jq?=
 =?us-ascii?Q?Gvpac2fDq+8r8ixRv3i+hOchG2Yh9ZnIM8cVonMQISS3BQu1lIKD1Tmwidln?=
 =?us-ascii?Q?4t7Pi5ejbAWIlJ3Pe9pzrkNlVzSzo+ruNqUuM5BzOOmU4xe1rfGBMIegrnpW?=
 =?us-ascii?Q?+pQWtNhZPVS/4yv11sDuR1qRTOKl4du83K3MWh1783t5PiUrzzqluWhf5NZL?=
 =?us-ascii?Q?qHQ/fqbqb78GA++4eWYhpb091xZkUHy4ETmL4gd+9nAZsG8EuAojvPvSzGjU?=
 =?us-ascii?Q?jXz0g4qey5DqSuyZMYzw5HwwotztSWlpVE9CIKXMLuycMFzwQJ2WuAzhd4g9?=
 =?us-ascii?Q?mAWuVmFgwB+NlOfxZj2NyygNPmclJesgW3rlHeBquQtk6zzhZUKyX1l6/a46?=
 =?us-ascii?Q?vYXDJ+HyWHx2qbRJLJWO629tpE27operiI0UKRSSXZxyUh4FULqtkkBxYLm+?=
 =?us-ascii?Q?weCToS6FXxA0M+G1nb34S5X+mHIVG17GUhaGIzsDJHniNRd2r6xosgQ885pR?=
 =?us-ascii?Q?gZONvm/O14QjP3H19eq6jfAI/82WnkQWoJ1+IvxFvp8G788gNDRQc5EWEzcE?=
 =?us-ascii?Q?Bzq11nY05rxFyvs1Oj1KzbZ/gURzcc/gcrPXiUSSGWtwWNAarExAxZ5/bldZ?=
 =?us-ascii?Q?LgWPU/EPbgulIcFuY0OwbXvPIgZSLBQ9fEiNC2kX72JsTgFGoxe+X9vtYA1k?=
 =?us-ascii?Q?M6xq+Mj2bwGhj6xjSbk+Zla/J3ZFJchHpHL3x6BdE4Fxu99MdWYmjhnM40ic?=
 =?us-ascii?Q?K+YpGaD0F0PjgNzR1Bv4nsW6zqrrujih3ODEgyf9iP0maeVBqi3Lff775BbQ?=
 =?us-ascii?Q?QVuAD9PhnkE/w+WG9B0fHu8exevKKi1lA29XidIIDPWxe0j+HAW6DtnYeyD0?=
 =?us-ascii?Q?07jCPCKQgJCgQLoHeO/QiwIt24EP+Jsg45iS2ql+HA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9dh5ib8tUqfCYsKg0sCUDuOXn7wrMLIzJRClLoc8n5PFm6keQqctmBmYmTae?=
 =?us-ascii?Q?Ydndu+S7u0bvq2xBT/VOIN48IA8pmf2V1Lz4NGMdfU9rzF5voulgPnYaVLBj?=
 =?us-ascii?Q?hLDT994qkItr4HLfwlVv3aH2PXa+0axyh/Mlld5EJoZp3Gdd2Ypr4a+8TgXw?=
 =?us-ascii?Q?nH3AhxBGxwK8zTdfLms8g20CH27vKvFaNo9acHG4sL1lpCf/vsgnz7W+RPlB?=
 =?us-ascii?Q?Uqsx6LyYSpu3+6uv5PU2pfRcR2BWbs0Wz9elV0MNQV61mvMFHvjl2xQk3Qsk?=
 =?us-ascii?Q?9m89WdpakIX+i+qh3Itp0xI/y3PF8XahvmzACMp8dmXCUwap+tI9Lymowvqf?=
 =?us-ascii?Q?K8ZP0kU0vs7nODsjkdkepDVCWz4OaSxeiBzl/p2kLYqNCFzm5kZc2XYvy1z6?=
 =?us-ascii?Q?ODhxMcSqbqGiCurp5fUolCSCC9iwsl38vGac5oG/JnHVIk31TiPbW5Co6J+1?=
 =?us-ascii?Q?u29SKT91MmhNJnaBvaXw3skJudjAF9HK27nBfqVKV8yzwEY/Md1nkOpK3zSY?=
 =?us-ascii?Q?A4l+oa0N7zWc6BNgU9MraSkBBjlPRgIas/Bh126tQSC03Q8vEtDwZp9/O0Qj?=
 =?us-ascii?Q?6DKt/r0q3450MgehrhoftMzzvMJkJgzlaGm4p/ergdD5M7MvwxUwRyCWmf26?=
 =?us-ascii?Q?Y3KXJ69HNjLTlr5Pto+nTCF1jWqZGgoUVVafXyQUlbQlEI58tV6KXdSp2pCb?=
 =?us-ascii?Q?JjU8khZflfSDBrsK/oIvKC+5My3xP7iLC5zfoK83P3pc0z6E1Y4S7xOg02A8?=
 =?us-ascii?Q?c0TzdD/T9dFhfCmh3/cs8mWRAvS27xd9TxeEtSL5ZS1Ef8v80VdUhoC06ZaM?=
 =?us-ascii?Q?/3D6A+VBuIrKCYY1edQ8+ZW5S0y9g5zERY9AunacjN4B0yWYhZSQWCHxKhz9?=
 =?us-ascii?Q?Ug28wzl4T2HUtpyN67YiXlsyg/kfjo06eNzFfYqTfUcRO71NuzP+BKqp+ldW?=
 =?us-ascii?Q?injNp2CRRMETay2rUHUJ3tcxvbNJd8/vjCTlBV4OwYD2G+b9RjZoXwvB0XAQ?=
 =?us-ascii?Q?c1Q/a/VkGz9VVasTXSYZKMWTfdXfGU4fpjPYTJWiqIRlbOZaAmLLv0Zbo65W?=
 =?us-ascii?Q?T532UrjCRgFtFOoDl7SbdqGiOOA1o5rxQkmGzNz4WRr/VYNiasg7jRdCcYnm?=
 =?us-ascii?Q?rnhefe2CKm6d6NZnhqhKrL3HnFGFEWZZhF5hEoob0X/UhJbUMG23CTZ0+LiH?=
 =?us-ascii?Q?rZ/iRaWx/gyBSSaOisd244nMB9bKRuKHYaKfVk5PVPtXCgCH8qiiEtmqvQms?=
 =?us-ascii?Q?vrSVr4Pu1MHuRVhD+TpBUFt45UD4qpf5QaYv0GGFU1oD4f+URIqCIdOQJSWz?=
 =?us-ascii?Q?pZaTyiIamJ/6SjTCCN4Kv51ADH3NkP7SGsuD5kdIJI81Lwst/UirUqwpHyk0?=
 =?us-ascii?Q?xcp0OECJRB1oSnRfpYFUFkni9G3wr7pkQ7XbtvUHS6D6ShURZyVk/mxPGPhE?=
 =?us-ascii?Q?gmnGZ8zEYe1UdrJNNo4WU//9Yk8EWZQpCLpIs16BjacUxdC3LLid1r6aG/5y?=
 =?us-ascii?Q?z+UlYA+aEdlNmGwmKD72LKgeI0rR0q12ZIfj98Ua1/nDYOOSeP11hGKEhzDA?=
 =?us-ascii?Q?elN82Rz3XlBqqogH59n5CA8YZNOBIzIzmYC99f3J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c96f49e-b525-414a-a597-08dc6315fc3b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 21:48:45.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxK0YBNL6fHANMF4GsAtD0P13Jp6K7aCntkhYFX0RwSdWEp6kxqr8snADYpWnctUkDdepvia9fSaYNyUxERcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The CXL driver uses both functions phys_to_target_node() and
> memory_add_physaddr_to_nid(). The x86 architecture relies on the
> NUMA_KEEP_MEMINFO kernel option enabled for both functions to work
> correct. Update Kconfig to make sure the option is always enabled for
> the driver.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

