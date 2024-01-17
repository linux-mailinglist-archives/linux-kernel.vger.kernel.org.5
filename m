Return-Path: <linux-kernel+bounces-29561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD783103D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F5C1F266AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1E288CE;
	Wed, 17 Jan 2024 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoxwNAtK"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C8225A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535957; cv=fail; b=P0mASPHRzWqVKQVGkkHavwlOnDtEc7Lw4nEDJ6ZyLi50lFuc96dwgs/gI4x6U5+8J3L3YKdJ6uiwbHMznltyAXmc+zvCAxflPLR+OzGNzqvIE0W4PWvULW3dDZVAJs9psfempE2AblhvNLgSj4TSgzONF5tjd43fNknNHgI73Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535957; c=relaxed/simple;
	bh=iUYz71Ldv9e1KGQlyD6V4BWaaM2JHHEDGjQqeSfRTlY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=LRL6QW6aVZzBRE8ookC0QOsg5fKVJrDzKPY7XHO+BEYSbpUvr671BYvcpGWnsvjQ3/J2yHt5FRZMP1IjlHInfayJH7S8/FV37XgeJmcyrhmqHWQQjnYfB1CXcsvt7bwkablQFSUW/u/U+J//TxKwFVJOHa7KjZO/+SUGwyFJvlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoxwNAtK; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705535956; x=1737071956;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iUYz71Ldv9e1KGQlyD6V4BWaaM2JHHEDGjQqeSfRTlY=;
  b=OoxwNAtKkn7cgMj0aaZBaoLAa+Bi0pXT1FB9Zht3wNt0dEiydmbbwn0G
   rZkldmQBUTu/Mn9TBq262QB7hpf3GX6hgoTh/tUmf6BvOYl+0KxwXKXd6
   tvJeM6oHDYuRfJoWrqXjDp8CdoOvYZjfLdk1xHT1M5bs75mvHr7Goi26T
   T02eGm1Bkt74DGWnYOQ80O3pUryEW94EeVUFY7U75hzQ1TEys4a5FVPFo
   XoTeERY1hW1/5bSB/tYHBETCM0ebbiRuuI7FDw/WysNoGGOuMx4K7TqCm
   4vBVjXW/a56TFAPlX9updDGEYuUerw57Hov3DZg6vVUNcUNlmaaUhtMIf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="390755723"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="390755723"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 15:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="760718404"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="760718404"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 15:59:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 15:59:12 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 15:59:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 15:59:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 15:59:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ5Oe5DuHDm1FjJ/lL+SbdLqNbBtv5m52XUxcrWZ/VhvKoHdRMn0+22pJgAq9VW2hJ36CvyL+JRaz6xEgxu5zP+Hit3J0j0nyIT5DELCRrAfHcLMYyfvTYPU6Gmpar5v7LUM2tVdq3sMJhytpP8Xp8EwccG2oZzlG5RH5X9ChP2v0WoQcWNhvZcru45cmiqdpICXp6NbpQ1lStrU9l/mBp/TPmeM0wZL2KX770mhsyvDaDOgq4luYRzTtKZUyUhBiEG2/mL1n4oDHQl9B76dJOBxVR+4zIts9x20bntOX9IjN2oiSuh9f0ioW09Je3me7YgTGV4Cs3qyQ6v+iCC6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUYz71Ldv9e1KGQlyD6V4BWaaM2JHHEDGjQqeSfRTlY=;
 b=k2Eb7zEA674VT2S2e4473wIQowBShzH/hnKX3JIJpVFvp89JWWSPnIKjCR8rhaCfh0qmsnsfcY2imo6wl2+jOAe3QK1iwtTctj3K0SAJpiqVbRI+jTWDnhKZVk+TLITMAZlUdmrBGVYZ5SedSbGhI6IBYHy4Rf04v9yA+5woXNnwelTFv4sQ/cdto8ujyI+2SocRNYqfn0DTciwFuGii053TBo8cDY8OtIccWdwL4v4RsQG59Dd9Ve5RSIrEoej+ry/+RQz8M/HceGA7xKZ+8v9JNjubAJfiUfXvfyuOyOxXo657KGXO605VE58CT8WU/y0POKjrQOroJ57wnMYWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 23:59:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 23:59:10 +0000
Message-ID: <9bd8848f-80ba-4afa-b438-026dd21c7ce7@intel.com>
Date: Wed, 17 Jan 2024 15:59:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] ARM: MPAM: add support for priority partitioning
 control
Content-Language: en-US
To: Amit Singh Tomar <amitsinght@marvell.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <james.morse@arm.com>, <gcherian@marvell.com>,
	<robh@kernel.org>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<jonathan.cameron@huawei.com>
References: <20240117141405.3063506-1-amitsinght@marvell.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240117141405.3063506-1-amitsinght@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:303:85::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 6355fbb1-3c26-4905-5556-08dc17b84c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgjH8wVoe6cQ+ZY/H/D0wPsuofleAd0vewZa4asgayCiptXLNgaRmYviISb6EFU8WG/8Ww3fdeABBEbGKsIN7SCOwj2SS+5giJEj6xZCLtDEQwE/l40TAWfzHFUZt9ZTM61AqDWasHzr8b5gPE0A/hlNdxtn+iGtYG5af1FQntuBuVkCUtPq2rY/VBqgJXK/H0J3EilRwr2F2daJkX5zhbObJPF9Kx3IE4POoy3TMF5CCowjpRQZ7aEpoGt1aYQrX4JsiIhOJhb1wAM1H6UBMzmtuwYuuxEa2qYHD5/84BPQoMczD/fMN96qzVnaNPlOJev3yAG4L34z7sCPxlcpSXZPAfBSXiY7Gkpytip0JOHQR2GPu/2hPRYiJnaJtQ7uUWNRNQF0OCWXxUlNOv7FVYXtOwx2UFd07uurjkr5tc7tFOGX9wkkDi4FrsSOSo+NQr5BqBbP74a1WHkAk//mlrhhwd8KAEggHWFo/8JBNXNkvHNPFvFkOncPjI86OEQOUNfy9Gag75O9w8Tw1xxkvtVCO0BmdqJ0GcJu0gl6dPOmBU628N472GAJcdugHSqFWgJ0j2EJ0BPGQywmhfgwGZy/ztC8my9PQEBg9CYBKqzeMDBqPpJRfGUVJ7F3s8MC7x3GAkkvMFPXrcIjMIjLR4MTWhR3h5SJI/3U/HDoFTCx80mvdx/f+7sXElZpvEj8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82960400001)(41300700001)(31686004)(36756003)(86362001)(38100700002)(31696002)(8676002)(8936002)(66556008)(316002)(66946007)(66476007)(26005)(4326008)(5660300002)(478600001)(6486002)(4744005)(45080400002)(44832011)(966005)(2616005)(6506007)(6512007)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGU2bFN4QUEvQ1hEK05LKzZiRW5xU3BuVm05M0tFTU5Kak1uMmFnVFVtRk9E?=
 =?utf-8?B?NmxINDNVUEs2T28xZTl3Mlo4MktkTUE4VGFkZDlzM0xIaVpSQ3N2STZtbHR2?=
 =?utf-8?B?b2IvNnJJNW5Yb1hqK1YxNGducnF6S1FqY2RmVng1Y05aR1NMV3dsb2hyVXNB?=
 =?utf-8?B?TnNEYy9KY0Y1b2tELzlIZWNOaGtKd1M0amxMTHZUSjBZVGlWdHBMajcrNjVC?=
 =?utf-8?B?NnVZWWxoclA5NHRoSkEraUxpSERlRGNPazVXQkFnUW4yaEtvRmZsOWxzT2VG?=
 =?utf-8?B?ZmRjdE00TEwrQ05WbjRULzhHRHRtMmExSDdURFkwZ2RSQzJla1JhZ0VTM2pO?=
 =?utf-8?B?dzhkemE3Kzl4REcyWloxdXVYdHRvVk91WTJmc0JCOUs1VGNOSGpuaEp2MGhF?=
 =?utf-8?B?b3BKeUJVaWtoTmIvbzFsOGV2RFdoVi9LVFZ6Tk5XN0ZoUGhsRG5Cd3p4Vjdv?=
 =?utf-8?B?d0U2ODJGNFdIeDV4MVE4d1pQcjBJTUtNYTY2OXZOMC84RzFrZE9Id0NwTzdl?=
 =?utf-8?B?WXZkc2tzTnArWUQ2TFpSeWdyZm1RWUhmZWJBWEJ4T0JETmtTSkJLcnZiajQw?=
 =?utf-8?B?VFBVeVFnREo0QXdPemduWHl1N2JSSUVqMUcxT3c1MU5qYlE0dXBybXFaSmIr?=
 =?utf-8?B?OHBIb0M1czlzL0pWRXpvOUx0Qk8za0IvckJ0dnFBTTJSYkV1UkVYYkZza0hx?=
 =?utf-8?B?VHM2QlRTTTBsUUxFL3VBRnE4TEJLSnVXenBaQTRPcGl6MTBINEdhaEFUYkRk?=
 =?utf-8?B?czA1ZXEzQ1JqWHljVUNkZmtMNlBKeklrL1M5Wm9DcG1ZRjlQK2o4K01RZTIx?=
 =?utf-8?B?eitTcUNRajhHUXkrdUJGVWNCZlFKK2cyOE5iTm14MThscVJzU1liKzBDYktJ?=
 =?utf-8?B?Z0dpR3lvOGllSUpsNHc3SHVSUGtqQWwzYmw2YXUzakRiWGZ2dDRXdkJBVnps?=
 =?utf-8?B?ZWtoTWxPdDI0eFZvV0JCQk15N1Bxd3I5L2tIc2k4R08wVVN0T0hmV0tHbitl?=
 =?utf-8?B?aERPSDJ2NFRkMUN5TTB4SE5leWlJbDdSd21BbWg5dWpFU0p3c1l5Z2Y2SFU0?=
 =?utf-8?B?ckd0WVNydFptMEMvQ1FrMDdRelNUVHRrNnYrSnR6RGxUVm1KaWZDRFVhcVNC?=
 =?utf-8?B?ejhFN0FERGEyWU8zeTJwMzdZNmoyTnY4NHQ4Tm5QZkMwOHpSaWIvRENndGY3?=
 =?utf-8?B?bTh2QmNjNERLbzhuUmpuKzhweTg1Q3pEZjZvMEdJYm9ZdHQzR1BzcncvcSs0?=
 =?utf-8?B?VWsyMEJQNkdZUlJQdmJCZTVsRnpKY2FiNjJ3OGdjUkdxTDFUd0k2b0x4TlNW?=
 =?utf-8?B?eG1uZVk1Y2Y0SXZOcTQ3YldjRXIwMkw0cVYvNHNrc1NRTk5PWEVBa3gydHcv?=
 =?utf-8?B?bjF6ZzlXTjRkekVmcVFDOVM4aUVsUHMyVkpiUG5wY0lhZCtjbGtrMzcva2tB?=
 =?utf-8?B?MGdaNDNKTG1aeGpFcVg5Rlh1SGxtYnQ3YWJ6ZVI3d0w4OThwRXVXQnptbjU0?=
 =?utf-8?B?TWRTejFRd3RYU3dPTmlBK0ViS0pRRVNzSENRbU9tNlFaTURvTm9XZC9QMCtu?=
 =?utf-8?B?SXhJdVNibnJzMXY0RDlNVXZwVThUTVE5MHBJMncvT096L2FBTVlYelB4Rmhy?=
 =?utf-8?B?Zkpuck45eDN1cVQvY0ZudHVLZ3dFbk42cjRRV1dwZWtvbWFqL1RVZk9VUEc4?=
 =?utf-8?B?L3N2YlNaZUo3QnVPYTJnQko4R1RCbElwTS9ZV3NWQUttRnBBWGJ5Qm1yUzBB?=
 =?utf-8?B?SCs3QkM5MHltM09TRlN5SlA5WUtOOHo5TStucXJpc1FNeFY3YnhEZzFtcndv?=
 =?utf-8?B?VkFPUzdTaXRqZjBBZmxkUXdJMHkzSnU5V0tLS05yRU82WSttKzh6N3FBS2VU?=
 =?utf-8?B?dWladlgxeDNOOHltaVc1eERFNDNoTWl1ZGwyQ25SWE0vSlVaMkhtK01ScE5V?=
 =?utf-8?B?MXpSOXRTVzZMVkRpUmhSRnRiQ005OHMveXlpOVVkSFJXbnU5S2Q0b1gzR2FL?=
 =?utf-8?B?b2Q3NUF5ZUhOYkFtVm90SzJNcnRvR1VkR0FmK1prU092SXc5eHZzajdOWGFn?=
 =?utf-8?B?c29pTGhPUGQyTjNmVlQ2dVVhZTRENTdHQ3A3WGJEMUxSMkJOYnp3STI2Wmpq?=
 =?utf-8?B?YUViYWdkT08vaElUd0xaNTVkRldxcXdBd0lYVW9ISDB6UVBqZ2pVUmhFVE5E?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6355fbb1-3c26-4905-5556-08dc17b84c58
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 23:59:10.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC+SWNuKSZSnmgzzkQYkhCVMZ1Z6wT3l6v/JIWuFqlxpHb7ezy+CJjquVhgqUfxmNVNeQm/NuVCuWYOQx8yqa7fIpqWjMlMNOwdA8RpEJG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com

Hi Amit,

On 1/17/2024 6:13 AM, Amit Singh Tomar wrote:
> Also, these patches[3] are still based on older MPAM tree[3] from James, as facing some
> trouble setting up the resource control with latest snapshots.

Is this related to the issue you mention in [1]? James did respond
asking for the splat you are encountering. Could you please follow
up with that? If it is some other issue, could you please share the
details in response to the most recent MPAM submission [2]? If there
are known issues with this work it would be better to resolve before
merged.

Thank you very much.

Reinette

[1] https://lore.kernel.org/all/MW4PR18MB5084AC18E19386E5B83C0F0EC6A0A@MW4PR18MB5084.namprd18.prod.outlook.com/
[2] https://lore.kernel.org/lkml/20231215174343.13872-1-james.morse@arm.com/

