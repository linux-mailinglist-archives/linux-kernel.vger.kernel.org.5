Return-Path: <linux-kernel+bounces-145689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64A8A5988
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DE7B2242A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6974139D1D;
	Mon, 15 Apr 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCIUhwr8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BC213793F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204225; cv=fail; b=O1ITMkIWyUyxISr8N/GDOmW+ERF58kJdLKDEYByixDgmqmtB1zZF/jQm2VhJo6g71xP3FQNuRj5Ywbt0knssznGJqX7k//lTypVdWwR4OmmEEIKBNO6aXlEVok9SLSKN/HWC53vXg5BmQcHF3imdcrkVRYVZ/pjQ+HCy2RvZWfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204225; c=relaxed/simple;
	bh=BJFbFwkSFlaoYQyxMB5YJWlLo5IIv3N2u3ey0CbUw6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDWkUQRpBbHyHbLtZZ9QjAgVkQW3ZXZn1DSecWyKpQIRIAR3TZnJJqmlaoMVgOOoo0hyc4/PdML/UuSoI2ZIE7FEIXdiZNfd/78jn34SKMCAYqOPDZTdVnmSlBmD8mcpCDAh+tVgdsTbzVODdKECSqO4hbGyXzYwp+gk4liy3/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCIUhwr8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713204224; x=1744740224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BJFbFwkSFlaoYQyxMB5YJWlLo5IIv3N2u3ey0CbUw6U=;
  b=kCIUhwr8GUktdBVQ8eT39P6JIK6AwE+IUUJjS9jIyXOG12Ud3ioNLdif
   oN61imqNZIoNtXXRxvGAVtUbduNxCg4KQupNGlmJ+yMkamc0wJGJojAJT
   HA3gx8ONg7m3MFfJP7Dfr+fEqTfEFn9eFXYYO0TH6VhxfDNnrridi68Hj
   IiCOp6er3XLnRT4pSRImJJ6FSasfkzZD5bqixDTvxf0gx4wKPzAzb8x6n
   8qQOV2xnui73CWd0ca2Ir8T838yr+ydUWu6tNeYq3N4gOU7iAWzYmVjJq
   CdNz3XW3e4DciPmO4TTGE0ISsP3Od3Dfg/2a5umtLiBuyVrCQCCGTEmfR
   g==;
X-CSE-ConnectionGUID: nXuRwRGlR5e8Q4ymr0XqTA==
X-CSE-MsgGUID: SVwvhRi9Tlye+upskLVCtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="9159364"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="9159364"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 11:03:43 -0700
X-CSE-ConnectionGUID: slTp2O9mTPSTcB/1yohKDQ==
X-CSE-MsgGUID: PC0YBoNGSCO2Ry8zB4zPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="21988807"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 11:03:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 11:03:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 11:03:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 11:03:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 11:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvO4a9GPiDitQhlEjAyDoCF6S3+UsQ9U4lnCTkbUbQeCsUO5YO+a7VPBaJ+HA2UQIysGARf3217cwhCdtkw008V743/zeyZbCX/8iIyXaq0OITVlOd9HWlEWNsTTThEqwJYaTy0JA065I389PsSD4I5zG1Z0JlcA+0QZ/+bdV+OvvZhzEv4tJdO/VnfbHc3SYghiwU3rH0h+42N3022J4iloBFzsuRcZDgzhJzcD2SoqXvmPfnGLwtmv6CnwvtkEE4St2S3H49HrL4QnDrhXNkYIt8a7W9rtWVWBxujrfv+P1AMArc5EO2EW4HVYGGyeBYn245Um2MMKx+M0UvV/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCnQNkxJQ2sTCcJJHoIPG0SdMvXKIk8OTANhvnvc1/8=;
 b=XHLWm1laVIpxis5kd9TXi/uQAPHj4d7l9HPeYJ2d0ntjTzcQCXr+e/neS9BS9Nm5h/6vgwOTEPlQiojcWdPRpd7DBkrxmDv3sZYoj3rzZ5bDN8mUJQpYQG98R7wnoACgZFnoL5VBTdv3r7XrtX5p7vJ1qMrMiJN79Lmx9F3NFHKRyzKaCImgvHz0UZalIsvD97jYsG2kGdLWEHdLch4cvwvCxfpmKNWqe+3tWrFzacJSYlwy2fx51O+5FcVT7U9rjeG8/cSiRZIz1Q9hPaps6bGsKxONgBauWdwgDJ1KusoC0J9KZ2X8AQ54sEeDZK4pfJIV3t5rWfAAQZy2w8J3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 18:03:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 18:03:35 +0000
Message-ID: <f287424f-c749-408e-92af-1717baf1718d@intel.com>
Date: Mon, 15 Apr 2024 11:03:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-31-james.morse@arm.com>
 <8f4a05d5-2040-4cf2-8c05-a190c25d64db@intel.com>
 <ZhfznA2Sp3KFdjrA@e133380.arm.com>
 <0baf690b-4ed4-4dad-9f50-e5df93d599fd@intel.com>
 <ZhlfV446640jF/rd@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhlfV446640jF/rd@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: 1878998d-86e8-4ef6-f860-08dc5d765e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwkKWCcbtpv30mJoKLZWWyCopJ7ISxdTGOREvzrOmTYEp7h4EiV2qoHie9STSplcj/LDIdODVh74Jur5Jbr58IlF0q1Mlll7xT9F/JRw3q7MoIcTyPHJkuPHBs+ZIsmDUibPTVIvwiAainyviT2dvLiUUTiXdmF/LPtNR4YbFA48P0I2IIgXdfvdJDbQGc1Wu7lkBT9YuBYdphQYHiN+BRJTS9LsEGhRWSGL0yDoWlOH/UOaFH8ENyxh2jPkgOcpXGf68PiuIfmEZuHbL0Z+nNFr2jqxn42MJwvNdgNNpFmCqrsKxkX36ncyRSjIqjci/zWe9IJ7cSBf0Y3vjwS8RYGLMsckfyFYpyXSfT72J0U4lnz+XqHq4ga2PzA0LJfia5PYFf8yVBhpKZnHjSI2r7yJSbnaT+KeR4z8z2uze3bH5fbSjP6IPXGCq1G0e/NMxLPuvsmD7vaT8HwiViht8vJGgz92wDBvcxRlv3xB9pvl6rwU4wj1mu9wOKLUXU7iyB5WttvyMvkyVq1VyUHE2n+DcwNJNs0N2zmXMdM9zPcxFmiIFfK+iv5SYMvV0fSWD/RJ3RD2H24hemzVLvYh97/40Ve1PPO2GuaCOFvOhN6GhnPwJAtQj1B9c8lcrPHHMI72mPniKPC4Xg5rvw9NobNLymXYBTmB8jNE0l94PpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dGM1BiVTVhYks4M2oxdVRYUERXK3dnU1ZYaVFiWVY2QktVcG1XbkpOM2Va?=
 =?utf-8?B?cnFEc2V4QjNGRmwySnAzcDQ4cndBclJZdE1paHdTUVZJMGJ1WWJMaGdaNmpJ?=
 =?utf-8?B?R2kvSDJtRjZuc1pLbEwwQ0Zma1AxdlhBdDBXaTd6YTVPNWx4bDI0OGZ2Tkw1?=
 =?utf-8?B?eTJaV0FYSVJOakFqbDZmYWk2dCtLNzNTTDJtN0Fzdms3M01JT3JLc3dHRXdo?=
 =?utf-8?B?T2trN1BiUEJvbUFKNkw4ODBndmtkZTkvTzVIZUpTTEpZa2N2RUtxVS9BRk5l?=
 =?utf-8?B?QUsvUzRSNk44VnNrUkllWXhodURBZkFiOCtZZ3dnUXJIc0FMMXdvZERUNGVI?=
 =?utf-8?B?OWJpMGxCb0JXWStpcmZiK3BUMGVIZEQ4WDRkOU1KY3djeDloL3hCU0tPSEs0?=
 =?utf-8?B?TU5mMDlrNW41R2FSVEpxKzR1bk5PSEpkbVhSTjZVbEZmdm9HM2xMaGQ2cS92?=
 =?utf-8?B?T1FuYkUwZE5PODdjOE5lNnVLY3NhbFB6d0tlL0I0ekVTb0FyczRDNUE3WStE?=
 =?utf-8?B?Y21GVXd0QW5sMFJlNGY1ajlYMVVSL1ZqQlZ3RDBhZVdGejFUNEZrVUp0bk1k?=
 =?utf-8?B?bVhGYXBadk4vY0pmSE1tOWZrK210RlFMS2FFT2NCaURRMXptdVdiNzZoOW9S?=
 =?utf-8?B?LzQ0a2JGcGc2bTFMQ1duOFpxMzAyTFYyUi82RG1RVGRmTGpta1ZKTUlYalRU?=
 =?utf-8?B?aFFzaFhGYTNERFF0VUFOendNWmxCMDBKY1lNZDQ4cmNhWXJXWklOUnk3b0Yx?=
 =?utf-8?B?UWFiRTdRQmprRHFKWnJYMGdIUDAwSFBoMndyTXdNeGxVRTZRVDRtTUNsaUVZ?=
 =?utf-8?B?SHpkd2RyN0w3eUdMU0x3MkhQR0pNcE1MYlQvK3RLc2JuaXRaL05UdjUzR29G?=
 =?utf-8?B?aDZMU3BaRHdDU2RacktyVVhoaUNKdnZkWU8wL3RKbGlwS0k5NGlYVXJKQ05Z?=
 =?utf-8?B?YVpTeGUweGh3a3RTQ1paeU1FMWx2OUdrWU5JdnR0TTRsMldsc3hFcnZwRzZV?=
 =?utf-8?B?dHk4SVgrLzBWcnpncWdlaGxiaFRGVDFJZkN1SlpKQS96eTBIQnBWeTJJWWFq?=
 =?utf-8?B?T0pIWithYkN6Zi9ZcUtSOG5QbWpJRElQTVpzZXlQVUNYN3ZYUFJKUGZ0Zmwv?=
 =?utf-8?B?aHhlSC9TTTFONXlyaE91bE9kUEtkZnB0Q0V3aE9aRE54UFlIVDAvcXdBU05p?=
 =?utf-8?B?UnExNytMVzFYQnAxSGZ1UlpEdFpRU25jaVZuaENSYzhGT29LWkc2SXQvMlJU?=
 =?utf-8?B?N2dsazhHSjhDNmdMWHk2M1M1TS9Wand6OTArZk04NGptT2kvM3QyN2hDT1dX?=
 =?utf-8?B?bHlna0V5dEdqVlA5ZEtaMnVwNWxUYTVucGxMZDlBN1VIalNlSzRpRnlLK0o3?=
 =?utf-8?B?Zng0dFVKb2VwV1dqTFdNejhmaUJJWVpoa2hUajhoWlNrWGQzcEp6SXlFbmlH?=
 =?utf-8?B?c1B6YnAwRk1IUUs4NWczODJpdVM2WGNBd3Z6YUJXRW1zYmdYcEF6cjd6cVU1?=
 =?utf-8?B?UkIxZ1NkUk9EM3lmc1JmVkVaNHhNNzVyWlpLak95UmhuVG41TkRNUUk5V3l6?=
 =?utf-8?B?MTlhSHFkQ00wOE1nd285OTAxUzNiRktHa1hEOERGdlZGbUpPL0FSbXQ5NXJr?=
 =?utf-8?B?UGFmbkUyNE82ZnJySlY5cmZ5SWNwUEl2QTV6QzN2RERMcU42NHJEMmwzbzJK?=
 =?utf-8?B?OTFVc1E3U1B5bW56YW16QlZXMUJBL0JqVkVxNXp6TmYxZ0JVbFJTdEtrWXVy?=
 =?utf-8?B?NUVNaXRvZzZ2QlluNjltdkp4L2k0NFAySklIZ2xVaG0wQldXcXh0aDRqYito?=
 =?utf-8?B?bWcyTWJRWGxwS1dSUGk0bjhhVXY2MEFxQlp0cFpPT1hyL09GSjM0UTlXZjRq?=
 =?utf-8?B?aHcyTlRWRVl4RUF4Wk9tcUVMbS9Zbm9aYnFPUnFrejNvTzdlSVNlVnVHWGRU?=
 =?utf-8?B?Nm9rZlFWSm1QTFY2Q0RyQlZ3WXFyMDh2Y3N4cUQzRHgzc0pZUlZmSzIwZnU0?=
 =?utf-8?B?WVF6V2ovNnF5SkFKYVlrTDdpc1hPeE5CWW1UT01Zc2hSY1FTSXF1MDVqREI3?=
 =?utf-8?B?ZzVJZVZNMGRMVEpzbjlNeFUvL29wZThXRXdUdERIT0J6MUJaRUdCTFV6V2N1?=
 =?utf-8?B?TTRwb2s0cjY3VzVBdGJGZzVyd2Q5L2E5VzJLcEtETzJ5TmFvVW1qNjIySW4y?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1878998d-86e8-4ef6-f860-08dc5d765e8c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 18:03:35.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGYVCSo2Xd8OK94pVlNNxn9UxG/FJoTWDAuuoq+7/97tQNho6JFuAeu3QitaYU+tUFuwBpCBDpKlOoMLqxHSAgyyvGos9CiN9Q7K5G8tXAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-OriginatorOrg: intel.com

Hi Dave,

On 4/12/2024 9:20 AM, Dave Martin wrote:
> On Thu, Apr 11, 2024 at 10:43:55AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 4/11/2024 7:28 AM, Dave Martin wrote:
>>> On Mon, Apr 08, 2024 at 08:42:00PM -0700, Reinette Chatre wrote:
>>>> Hi James,
>>>>
>>>> On 3/21/2024 9:51 AM, James Morse wrote:
>>>> ..
>>>>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
>>>>> index 4788bd95dac6..fe0b10b589c0 100644
>>>>> --- a/include/linux/resctrl_types.h
>>>>> +++ b/include/linux/resctrl_types.h
>>>>> @@ -7,6 +7,36 @@
>>>>>  #ifndef __LINUX_RESCTRL_TYPES_H
>>>>>  #define __LINUX_RESCTRL_TYPES_H
>>>>>  
>>>>> +#define CQM_LIMBOCHECK_INTERVAL	1000
>>>>> +
>>>>> +#define MBM_CNTR_WIDTH_BASE		24
>>>>> +#define MBM_OVERFLOW_INTERVAL		1000
>>>>> +#define MAX_MBA_BW			100u
>>>>> +#define MBA_IS_LINEAR			0x4
>>>>> +
>>>>> +/* rdtgroup.flags */
>>>>> +#define	RDT_DELETED		1
>>>>> +
>>>>> +/* rftype.flags */
>>>>> +#define RFTYPE_FLAGS_CPUS_LIST	1
>>>>> +
>>>>> +/*
>>>>> + * Define the file type flags for base and info directories.
>>>>> + */
>>>>> +#define RFTYPE_INFO			BIT(0)
>>>>> +#define RFTYPE_BASE			BIT(1)
>>>>> +#define RFTYPE_CTRL			BIT(4)
>>>>> +#define RFTYPE_MON			BIT(5)
>>>>> +#define RFTYPE_TOP			BIT(6)
>>>>> +#define RFTYPE_RES_CACHE		BIT(8)
>>>>> +#define RFTYPE_RES_MB			BIT(9)
>>>>> +#define RFTYPE_DEBUG			BIT(10)
>>>>> +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>>>>> +#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>>>>> +#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>>>>> +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
>>>>> +#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
>>>>> +
>>>>>  /* Reads to Local DRAM Memory */
>>>>>  #define READS_TO_LOCAL_MEM		BIT(0)
>>>>>  
>>>>
>>>> Not all these new seem to belong in this file. Could you please confirm?
>>>>
>>>> For example:
>>>> Earlier in series it was mentioned that struct rdtgroup is private to the
>>>> fs so having RDT_DELETED is unexpected as it implies access to struct rdtgroup.
>>>>
>>>> CQM_LIMBOCHECK_INTERVAL seems private to the fs code, so too
>>>> RFTYPE_FLAGS_CPUS_LIST.
>>>>
>>>> Reinette
>>>>
>>>
>>> I'll flag this for James to review.
>>>
>>> These have to be moved out of the x86 private headers, but you're right
>>> that some of them seem logically private to the resctrl core.
>>>
>>> I guess some of these could move to fs/resctrl/internal.h?
>>
>> It looks to me that way.
>>
>>>
>>> OTOH, might it be preferable to keep all the flag definitions for a
>>> given member together for ease of maintenance, even if some are for
>>> resctrl internal use only?
>>
>> Indeed, those RFTYPE flags really seem to be fs code but I agree that
>> architectures' use of RFTYPE_RES_CACHE and RFTYPE_RES_MB does make this
>> complicated and having these in a central place is reasonable to me.
>>
>> Reinette
> 
> Maybe we could split these into two groups, and clearly comment the ones
> that have no user outside resctrl as internal use only?

Another option to consider, which I think you hinted about earlier, is
to add an enum that maps to the RFTYPE_RES_CACHE and RFTYPE_RES_MB
flags. Just like, for example, RDTCTRL_GROUP maps to RFTYPE_CTRL.
The new enum can then be used similar to enum rdt_group_type to pick the
appropriate files based on RFTYPE_RES_CACHE or RFTYPE_RES_MB. 

> 
> That's not as clean as removing those definitions from a shared header,
> but at least would help document the issue until/unless a better
> solution is found...
> 
> Cheers
> ---Dave

