Return-Path: <linux-kernel+bounces-167054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D18BA3ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C695428528A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CAF42077;
	Thu,  2 May 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="le3FRK9n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD7DDA1;
	Thu,  2 May 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692104; cv=fail; b=sRLcM73YzneyFULEsTgVWmoqrVjEflmwLyn7LvXz38W0tVmMgO1+3aUN+sa2gFxWDB3wR0HwJuSboDRb5TtzB23XVMAKch9e/uv6MYxW+uaBnYjK/V2iUqZdqfqPspIYkB2WEpOja1CJRqxFzHnlOtU9aBJURqvbbSluNJayG0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692104; c=relaxed/simple;
	bh=CZ+IEFrQ502GTAjqU2+b7b59X0a5pkmQckNGQaVc2T8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSUtrO4dcD0I9GNwNOvhWouodE4akraHJ0mEN9xk7KTQSbjjEzOZIlCKenu3UEkxPTOH4W1WgnC6pUL19BODOPRI9+YSQYlP6qls5pPr2uXeLXFLXyXkJWjXeV92Z/OklKx3otXWk02hIh2wRAzuetBvXujoov5lrvUpN1YYMIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=le3FRK9n; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714692102; x=1746228102;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CZ+IEFrQ502GTAjqU2+b7b59X0a5pkmQckNGQaVc2T8=;
  b=le3FRK9nYKuyFKGPAay7dQtJXeAfBpk6WMsfu2WRzc3cF3Mt/d/raKgk
   caaByPsFvCkGL2XpBJD82JTtwLh+4DVpvUsx0fmqruu207TWmKTFuHhpt
   5OxCeJ+Ifn9ocquK5DZqePUMjALtR+0NESgIXETMSR8xn9VG3aTBgbS7o
   Njvu0YeLa2to65t7Y8LNCPJwWhrx4xwajR+Tes3Jw6Z/P48jDmVbGsmQu
   6KZmYkW+UU55cpxXIEKdiiHjAKkHBOcXO91vcBdeZgj0arKmou22qEQUg
   /nwnStwrPEan1+ePbFRzSgYJkch7LQb4pXmJ3aFRLkpiuG9FPbm9OP+CM
   w==;
X-CSE-ConnectionGUID: Ab0qcz+UQtytlp16r5YMzQ==
X-CSE-MsgGUID: 06nLPq5LQFSqfGWqzbf/mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10710914"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10710914"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 16:21:41 -0700
X-CSE-ConnectionGUID: 4awbM4j6TveLQ8W+Blh8EQ==
X-CSE-MsgGUID: B+3i9w/4Qma0JnB/0cY6kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31783020"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 16:21:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 16:21:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 16:21:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 16:21:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 16:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7SEVY8XmwHiVbM6qiuDjZRN9LyglNcKUwtLlkTEgK5/g4Dhlx0DraUq+Q958BFkt67CHP1NmYZhMZ1BbQmUdflBilDNQOl4yuLY1nW8ZOuhoS4zVMiq0CEAXH7OBQUZ5oDfMicHq8WDYx1A6timBMhgkkVhYLbpqpFnhp0JlK/pJE/ivUaXn0GPaTM1Fy1EZn5xYeV34WZvidepx2YWPPwU8wbCq8t4z1WEPfT6s9SMnUyOupn1UgMVeYjJu1A37Zwf81zpaXb3ds7ofOu80QmmLdQc7zSB+7HnwOi+b/G2WYr1xI0IyNfxSwqQ0sbVF7Fu91CMbHT9fsnYFwGsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXRWZmDpYmwwwsaDPdSl95/v+m18CcHDYQOiDywM2xQ=;
 b=nK3PzRvX/WW4ofvAwMIEvhATOXf5JsHu5SR9PSfyohIBGmYsWUtRH5AsdkCRh9SJz7Rdg6MxD2J15kQ0UgCAnxOAwkuAEK8UgSvBm8tF+v+qMLSDHeuiQUKQKeiW/YvC7JEABVMNPB66d4HBUqRG9Wzyhvi87tj7S76QqYGk3cdMHhtDBxTho8C46M0LAWi+3yHRk67y+c9kGKo1D2oO3Ky0evcybujAHbY/yIyzMI3uANL1ziboyYkdLP2Q1VTvnTdXrYvfOeOB2slu59ECkkC798B8EahD5wlv1cAWWkXKxfXI5nB83nXaxuBGv2Mgb7+o4yehZ5wgeUPPYMRgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7003.namprd11.prod.outlook.com (2603:10b6:510:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 23:21:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 23:21:37 +0000
Message-ID: <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
Date: Thu, 2 May 2024 16:21:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd75d29-6196-4d5b-71f1-08dc6afe9d5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFFYbEhlbXdqM2N0S3N6anZDb29BeEdvOU42c3pySEJ2eFd5ZUZwZXU1aDk5?=
 =?utf-8?B?SVpwWWFGRThBSnRzbk01UWxyRmlQTEx0R0drNFVTQk03UmJObmhkVGVKNkFt?=
 =?utf-8?B?bEVaazRuQXZLQ3kvRDNxU1BBQlRkQ1VWdVlFdHBtZUV1MkhQWGJmYTRsV3pk?=
 =?utf-8?B?ajhKM2RvaUlVQkNzM05XS3l1Q2F0S2hmTStHQTl2Q2JURTVsWTY2c09iZTJI?=
 =?utf-8?B?bXNFdGF5VmFQZ3ZXTkFBVFViMk9BeTRQcHNZWXZKRzNrN1VzcFJzTXQ0VU16?=
 =?utf-8?B?aW9rTXZvYWVYbFdzWXBrNTJQdXUxSlZLS1FBMzk4NzNiNG5iSmZONXVYZVN0?=
 =?utf-8?B?QzBIVGZhWG4vNVQ4eWh2UEk2L0FXRGVKdFlSYWUzSGZWU21lbjZmQ0hIdnF1?=
 =?utf-8?B?aXB5eVc1VUduWmtoNUtHTHBsTnZjVWhzMnRQSVVMOVBrMTVSZHdPcFgxRUsz?=
 =?utf-8?B?ek9yYSs3NkFOekVIcGtBQVlEcnc0cjd4Um5XQnc3T1ZER0VoVXpmYm95M0l1?=
 =?utf-8?B?ZEU3dlB0UVlpV0tYRUxUT1o4QWZSYUwxRVFDNjRleGdGMWI0cFZGdWRSMjJu?=
 =?utf-8?B?ZU9Gd05CUDdDNkt6QzMzM1FxeklxMHE1eWxvN090bEhra3JmaGYzbnZsUVA0?=
 =?utf-8?B?VnV5NVVEVFBaR2JmWjVNR0FxWjB3ek9KYTZybDRsQ3YxVExJcFhHVzBYNWZz?=
 =?utf-8?B?bEdGcVE0ak5keVQ3Z0ZOM1lhWnNmNHpHMlNId1NWa0NYZk9wYlQrQWxTdTJI?=
 =?utf-8?B?TFBxeWV0QjJNMWc2cFlYUXlPclBQZHVUNWhmMjdjekljTHJNRVoyeC9Rb3hC?=
 =?utf-8?B?SU8vcG9MaWM1SmpkWmc0V2hhUUZjWE1yWkszWnBic0lMSklxeWMwK2VQWk9W?=
 =?utf-8?B?YkFiakJacTU4SzZYODVWamRwdm1Eam0wemtNdWtDQW8zT1NPYjdQV1lOaGN4?=
 =?utf-8?B?OFZkSzU3V2VwNmxjcXhaVVc4TXA0WXg0WDd6Y1JwcUxIL05uKzlUSGVXbkxK?=
 =?utf-8?B?cHdTMkk0c0c0NFI0d256VUI4cVEzZnZiRkVvQzUxV0JiS3Myd1hMbDg3a3d2?=
 =?utf-8?B?LzlqaXZtdkZ6bXNyQTR0YWZDY245bG00T0lvQk9DWXhxQ29wczEzNmRISDBJ?=
 =?utf-8?B?Y3NuQkd3amZxak1DOUE0WllXb0lmZmhjczY0elVlc0ZVUWpPZ1JTVVNaeVlL?=
 =?utf-8?B?N3pxZHJwRVBlVDBOY0g4OTliWVBMNVdjZUhOSmh2T01vVDMxWGkrMDlZemJG?=
 =?utf-8?B?TlkwUlVzRFZpdkdpUU5ZRkpicE5qTjJoSGN4NEVnQ2NyOEhYMlRyOEpuZy9F?=
 =?utf-8?B?ZGZRcU5Ed0RaY1hjMzRzaWtWSjhpZHJpRUIyNDhpRy9HUEZVUURjcnBTSlRK?=
 =?utf-8?B?RHV1K1huZmgvd3RXRjc0TXA5QndTRFViMFdFSlI2a3I5RkZwZG5nZHBlY3pJ?=
 =?utf-8?B?UWVnT2Q2b3lqRFZPU1hjVnBodCtkT2l4aitaRTV6VlZCbW8yVFpHb1BjK0NC?=
 =?utf-8?B?Szl0bHJ5bmx1MWZMalhXemRrekoxTDVGZ0QveGVoaXBuMTBtRGhIbjZ4OHhm?=
 =?utf-8?B?UFlFZGI5YlFTTWlsNnRpa044WE9LTE1DVUtpU3M4UzczaXFSSEJscVV3dnVQ?=
 =?utf-8?Q?xVa4DoNaYul5It3xmdDOgk3CSpUcEExpiuMAyLgUx9GM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkhheUUyWVZOMXlPbkxDUVZhdTFJc1Uya3pxNDYrRHJmRXdNMXZibitVTTQx?=
 =?utf-8?B?bUxTOGZ3SlRoT0JwWTA2QkFvU0szeUdzeW54V1BWdUhvTWdHNWhHZ0xLc0FC?=
 =?utf-8?B?WmkxQUhveU41aTI1V1drVSt6dXR5eHhDdnFFajBVa2FWOVA1NnhsZ0dNT0N5?=
 =?utf-8?B?YmZtZVN2N1RUVFFvVGwwbDZOalBUSWlrQjlRVlVlY1ZJRmRMRVdIOHdXWCtl?=
 =?utf-8?B?ellDTFV0cVZheDB1ODJzUjJwMUdPQzFEZVg3NGRJeGYxeTFYaWNES0lrNEtB?=
 =?utf-8?B?YkRSdndENzB0WG9LNm9vVnhsVVRMUFRMaG9mcm85a2ROSVhObjlpUkJ4TVZZ?=
 =?utf-8?B?eEdiaU1lblpjRUUybDhyVkx1aFh0ZEhaM3YxTTkxNGRDbTAvaXMyNzlweXUr?=
 =?utf-8?B?bzN1S3N5czJSdmhLcHVzMnFwUTZhRUVyOHQ2RUxSVmVHQy91MlZkaUI2VjJl?=
 =?utf-8?B?Z2VzZ2xGTnJxak8zZzdhcUhUTEZXaEZ4aHFka0tzVHV5eE5rYlBHWnh0dnVJ?=
 =?utf-8?B?bmxSTldMNHRmd01YYS8wcVlHNWtqOUs2Q3hoQ1F6SHUyZTZtTCtVNUhaNUxN?=
 =?utf-8?B?WmVqL0NaS3Z6Z0tMQXZtcmFydmhtSk91eTR1eE81L2dBSFFmZnFTRlQ5eVQy?=
 =?utf-8?B?cmVVNG1HN1NrR3BQQ2wzYldCbnNYSGFJTU1QZGF0eXEvVWVzRExKQk1wbEY4?=
 =?utf-8?B?Sk1ZSnJaRDZxV3A5a2lqUEZkeFZ0ZmE4VGhOSDhMOVlzTm5RQzVKZDNKeHFz?=
 =?utf-8?B?VDIvQStHTnJiUHVBclhKVXNQejVKSm95bmVLc2pJelVTS3NXUFIwQytxbXp0?=
 =?utf-8?B?cW9hTEtobXBmT1Y2VTRUanhrZk9BS25BNHl2VE4vanRrMGt2c1VXbzJrTGs2?=
 =?utf-8?B?NU9FVExRN295ZmxORHdLSzNlWU4wc3pvUzRXa2JvcUZ3eFpxeUNtekR3dGs2?=
 =?utf-8?B?RU9aKzRXaVdiUFdlUVZKYUFOTWxSNDFGeEdhWmtGL09vZWplcklUU3BDK3R0?=
 =?utf-8?B?ak1tYkU2R21lWFZwWjFxSXViaXg4WXRqRG8rYkpKV2NrSkx6LzduaU1kbUFx?=
 =?utf-8?B?Q0hRTS8zNFhOZENDMklDNkFEa24xdVBvM0tqZ3o1L3lEdUF6cDlOZ1IrZFpM?=
 =?utf-8?B?Rm4wV3NQc3NYRjNOVDBrZU5iempqblYzOTdwS2RkZVBjdlR1WWVRa1dTNnF1?=
 =?utf-8?B?R296TlluWXQ3QmxibiszOUlHZjdVSXZ4SFQ5MDkzck41RHNoWFQyd3V5akth?=
 =?utf-8?B?bzh6SUtpU3JCQjVYWDhVdk9KWkkwdXI4ckZYWGtJem81eU5iSEtMRzNyaUVU?=
 =?utf-8?B?My84OGVoZHM5bGx6TG1zNGhzd2ZyanFkU3BMcm1GRnk0QnpXZFJmci85KzN1?=
 =?utf-8?B?bVp3d3o3TnA5Vjg0bmJKMVlmUTJrN0kwdXltdnRiVjVjRG90dkNzMlAySzBD?=
 =?utf-8?B?ajN6T21XSlg0YUVNVTdUOFZqbXZXa2R0OGNaQUlJcndCY25KdDN4alFUVDBH?=
 =?utf-8?B?OC9FRlhtZTF6MHV3M3RQWGgyb29jVEUwczliRFdJMDQxem8yTWZmVlVDaXBH?=
 =?utf-8?B?alpSMzNBNVFaNXowSTVnWjZSZHNZV1FSODNRVG5NUkFWd2NETUpiRXF0aG1t?=
 =?utf-8?B?ZWFHU3VOaG1taUpCZmsrUG5wdnA5M0gxWC9vTmsxTG90MXg2UmxUWUc0TXZ0?=
 =?utf-8?B?R0t1OXl0Rkt0RnlVVDVMMHBGNEpNcUxVeHBob2poeXhpNURXZldGTnVIYlB5?=
 =?utf-8?B?M3pnVllqTWhsLzN6Y2loaG9rOUd1MGgxVDFuS3I3NFgxOHRWU05Hc0I5b1ZB?=
 =?utf-8?B?WTZJSkJHQTBncDRsQ3l2QlI3OWc1aDVLU2RWaFRqT283TTlSMDlVWnpSWjZq?=
 =?utf-8?B?VWpDN3YxekVQN1lJeVE0Zm44aEpDTEZtNzJ1M1p0RjN2NDRSaElNWVgvVGI1?=
 =?utf-8?B?U1RjRkFvMG1MTUZqQnlRUGpxKzEwWkJLWHJZczBzdVRPMFBucVFjVlZXQ3pJ?=
 =?utf-8?B?U0J6bU1yWjhTTGcwb09aV29ZaXpHb1h5NGhjamIxZmlWOWxFcXRPQ3FrWFVD?=
 =?utf-8?B?VXNLRVpmdkV6Mytza2JkZmxXL3RPdTh4OGxsVDZjbVc1cGw4VGhlc0JIUkxa?=
 =?utf-8?B?MTA1NENyV2pDTzhwbnNaVG4vdjk1dC93NUNvL00wYkFJenpZOFdnTWh3cEpC?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd75d29-6196-4d5b-71f1-08dc6afe9d5f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:21:37.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzNpp0BdRDQmPIrbPOiZpsspDPI5KXc7+0W3UDg6SXZSY/Kpx4hD64aIpKCbA+ygW7ZIrNqG4gDpKwhDJ5xJvsvfsVdDaYufNQ+e7PozfPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7003
X-OriginatorOrg: intel.com

Hi Peter and Babu,

On 5/2/2024 1:14 PM, Moger, Babu wrote:
> On 5/2/24 12:50, Peter Newman wrote:
>> On Thu, May 2, 2024 at 9:25 AM Moger, Babu <babu.moger@amd.com> wrote:
>>> On 5/1/24 12:48, Peter Newman wrote:
..

>>>> I chose to make this a mount option to simplify the management of the
>>>> monitor tracking data structures. They are simply allocated at mount
>>>> time and deallocated and unmount.
>>>
>>> Initially I added it as an mount option.
>>> Based on our earlier discussion, we decided to use the assign feature by
>>> default if hardware supports it. Users don't have to worry about the details.
>>>>
>>>> I called the option "mon_assign": The mount option parser calls
>>>> resctrl_arch_mon_assign_enable() to determine whether the
>>>> implementation supports assignment in some form. If it returns an
>>>> error, the mount fails. When successful, the assignable monitor count
>>>> is made non-zero in the appropriate rdt_resource, triggering the
>>>> behavior change in the FS layer.
>>>>
>>>> I'm still not sure if it's a good idea to enable monitor assignment by
>>>> default. This would be a major disruption in the MBM usage model
>>>> triggered by moving software between AMD CPU models. I thought the
>>>
>>> Why will it be a disruption? Why do you think mount option will solve the
>>> problem? As always, there will be option to go back to legacy mode. right?
>>>
>>>> safest option was to disallow creating more monitoring groups than
>>>> monitors unless the option is selected. Given that nobody else
>>>
>>> Current code allows to create more groups, but it will report "Monitor
>>> assignment failed" when it runs out of monitors.
>>
>> Ok that should be fine then.
>>
>> However, I don't think it's necessary to support dynamically changing
>> the usage model of monitoring groups without remounting. I believe it
>> makes it more difficult for the FS code to generically manage monitor
>> assignment.
> 
> Are you suggesting to enable ABMC by default when available?

I do think ABMC should be enabled by default when available and it looks
to be what this series aims to do [1]. The way I reason about this is
that legacy user space gets more reliable monitoring behavior without
needing to change behavior.

I thought there was discussion about communicating to user space
when an attempt is made to read data from an event that does not
have a counter assigned. Something like below but I did not notice this
in this series.

# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
Unassigned

> 
> Then provide the mount option switch back to legacy mode?
> I am fine with that if we all agree on that.

Why is a mount option needed? I think we should avoid requiring a remount
unless required and I would like to understand why it is required here.

Peter: could you please elaborate what you mean with it makes it more
difficult for the FS code to generically manage monitor assignment?

Why would user space be required to recreate all control and monitor
groups if wanting to change how memory bandwidth monitoring is done?

From this implementation it has been difficult to understand the impact
of switching between ABMC and legacy.

Reinette

[1] https://lore.kernel.org/lkml/e898059f3c182886b1c16353be7db76d9b852b02.1711674410.git.babu.moger@amd.com/

