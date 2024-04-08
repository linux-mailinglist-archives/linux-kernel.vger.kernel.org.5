Return-Path: <linux-kernel+bounces-135928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6C289CD28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868AB2857FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065821474A9;
	Mon,  8 Apr 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cjm0SrOa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EC146D6F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609974; cv=fail; b=mXkXC49WGqsEknm3HLtGxD8rKQILCzWTM7V3mONHzkEGeK3k0MijhD5LwbvBRAwOjIX/ELWudR3lXoU5QMDf1ZJKebN/trHgwHdgq9nZDBq1X5cb4bxCgOUw9aoJKg2WJSHmccJxuGY2d0DIGWy3eoNfal0N0M3GuEtrg16M1xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609974; c=relaxed/simple;
	bh=c6czUcSu3cYb5R+W5bODDu+lZxR4KGAKA+YQYJTuXQk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n5Q0Ky/Vf1Ud6bNyR7nStNQywZdtKKNhAnDPzBr7XNKP83tbkVYrnj/1+M7UdtVD+G7iKKM1SdyHeku0qFt8QvLP45gGD7HtCYGDHh4N7lPwIGzdzlp6INHy35dy9E/aUNBCSLRpww90/Eln9X4NOEOvUh8qsj/IXX87nPJz3Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cjm0SrOa; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712609972; x=1744145972;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c6czUcSu3cYb5R+W5bODDu+lZxR4KGAKA+YQYJTuXQk=;
  b=Cjm0SrOaJ8b6gwbCmyTVNQHrmfhTvWLYnisnILLRRubR6ijfKvb06Nm8
   qaVeFTX1ATPoI+j0rQpdyC8/JwA8WpfEuEM/bSYBfcRxE+L31qjvd9Le3
   XLwhB35qed+yxqsUU2YA3hfRjgnTDmO78JpkYtpaXe0LWutyxmS45z4xL
   NHOoQgWeteCyQ52JF+o7fi1rwdglwOCI3fNbLnQUraJ/uNIgDZPCZU/YQ
   aFwNf8JutWyvNf6IK5BinQcV34dLPShrdFfIthYO2JDAyQDkUXq4J6Mcw
   nK7giNJI7tOiILkFY4aq8ePKG1DboRz35i7EqoZfxZnr9vB9QxlzObvyq
   w==;
X-CSE-ConnectionGUID: KUVsvvcIRaOcvpkhD8nYfg==
X-CSE-MsgGUID: BSy1bO6RT+iN1km6IzL5FQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19056444"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19056444"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:59:31 -0700
X-CSE-ConnectionGUID: W7lLerMqQHeo6Xsw4Kil0w==
X-CSE-MsgGUID: w4EcgQMrR7K39dEL1RVsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20033109"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 13:59:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 13:59:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 13:59:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 13:59:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJA0ubtcaSgNFkM4gLwbs9M/HVx2rYG1DWIo4D4Ws12J5JcB6ZH0UgXhWfOk0Xde7BypCk09xtqUf9KVPwgercuOmT4OtKlYhdXXA/mzzMu3pMD/xDa1kQ4rW9n7JKBWTq+cWlTGkU58Xr2r/FFZ0jrorLvzV5+9SJ2zBJAA5H2nw9sChAjRQBGIDwmwvkGZ2gdAObM5GbCTO6Cxw9Hf9qkiSKgusjzGN2v3u2ijIgUMObow07d2rrqPk8Lr9ZUnRzXA1mPxrJHWoalsOCwEF3TYWV8iXI+j6fD3e8ZR7Hlyc8ft8zHGAoD8+msfakarIiAdBdec4cKl40zO/nr0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGXiU50IinsACjWvIs6Wmjg3KLXudRLqkBq+pDGbEt4=;
 b=ML9rmLFhejrrwim0S/xjflk/MbAfDPqeQF3pRhsgGr6KGAzRzOdE/mJF42Kled9oGj66mJbSzaRE+xLpr4qnkmMgwafInMaZy8TOX+FscReJjInXehiJtHeeIfFk6VjGA0HKR+WWYCojU1zJOoUgbhVPKctKFwWF0i7NaUunIqskxSCNwnlU6ztieXRTosBy0guNk6DcaAuBbNwGYGCAtWDyxJD9lWOs//qiF9OgQaNibnLJAtuRCkCoh2R5YtNQNkpPVuMKDpJxAonW8uWlhwf3/Xm2kXj79QHqUpJRmyYM4IJlSbgXMcn4aNLRW5uBJ/lFya+7DL4he1y/vNgO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Mon, 8 Apr
 2024 20:59:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 20:59:26 +0000
Message-ID: <17264fcc-5db9-41c8-b57c-9bd62ef544ce@intel.com>
Date: Mon, 8 Apr 2024 13:59:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] x86/resctrl: Move __resctrl_sched_in() out-of-line
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-2-peternewman@google.com>
 <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
 <CALPaoCjWDKM9VYXexDt2+zh2srTotuaErFHXkWzH1w0c_KWDjw@mail.gmail.com>
 <d3ef1a5a-a7ee-477c-8697-d64b91726d91@intel.com>
 <CALPaoCieXQfgEL-7CK2pB5xgrRzTTWBkbic7OXxdKbh-ipWTpw@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCieXQfgEL-7CK2pB5xgrRzTTWBkbic7OXxdKbh-ipWTpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7686:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzfBOznliBq73r60dH5MIVow/wNpDQJHjRyxZyslx1iE6b9bisesO8tyhjYPLGWzsOD/mGevTA0kYVRJKOsFeiPCGic/ixwZHITg59Wl5BDJP7laBkQvsPWJmVjQIOL2uO3Kl1vpZ1yUmCIk8lWVBAxceYg3Oo01sTxtYfxfuERrWDeCauQ5L933wH0IjQxS+9931OoRxVhus0j1fswAH4eMZTsoRiqFTYkryJWLQmJBp3Q7F6cJ70GWwNOWRafhGHWsBTizpuI1+F1z/Hz2wynwIKuXTVRL8Bp7BmWyk39AFKiUEKaVQgLo9LDiDtCaHT9MQdJ5UqW64AFqhHHd3pif1wzZBvqF105Ns8x5kSVZ+OfoyC3TWY/xzAbrpyj8J+uI0IAVqDT1uZCJ0l4MK8azUGCI+BEq0NJf5j50osygOnPNqqGSeAqaOFrFsmZaAN9/GuzJwz5065MOHHFRhFjzg556YQuqO/scb7fh3Pev024u8Vz1CIzHGmCsR2NLUVfkG79BX8v0iZDBvUYflLTKPq80Q2zOg3+zToH9FxoDtbOpet8kEEDfnBuqhoA00uS09sBvXlt2FBTg2RfbPlmf3wby/hU9HW0Gjl505fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBHS1BhSkNKQVZjQll5NEtGUEVGNDk2UzJZN1hoaVNXSEtReE5FMmdERXJS?=
 =?utf-8?B?WjMrdEt6d3hYa3RJSTZMbE9TWEo5bEY0NG1RdjEvWHVsUk5wM1ZYdUljemxl?=
 =?utf-8?B?TVlxYWszcDJBN2htYVNjRnZHakxxZGVES1R5TjFHWHBxdWVNYjYyNGVXelhP?=
 =?utf-8?B?bUtWVkdMVTdYR0Q4SWw1bDJVanMrMkEycVIyQUF3c1J5d3dKWmVVOW5scEJs?=
 =?utf-8?B?VXdwTlFrQjIxM1BsSUtGOHBBM1VjamRjZlYrajYrT0t4VnB0NC8xdlNMOXJZ?=
 =?utf-8?B?bXhhSTUvaW5SRmJFL0lWV1hlbEpIZHVvOC9KQjBjTmRta25kL0lhMHpxdmU4?=
 =?utf-8?B?cW0yMjdDdUVETnlXRFFnR3JISGc2KzdrVXJMT2ZhU01RV2NubWt6S1JWaDUz?=
 =?utf-8?B?RVhPd1BQNjFaeWh3T3VhWnFaLzZON0o5Z3YvTktoOW5zZ3lXUUxpNUp4TGRR?=
 =?utf-8?B?c0FPS05GbFdURjlPS2dsU1dlOTdRNnJ0RURmQkgwM0VHYzFyZHY3clk5cE5z?=
 =?utf-8?B?T3U5eVdrS25BYWhGeEdoRlp3SjR3OEZWajA1RSs2Sk8xQUhzdnQ2WU81dm42?=
 =?utf-8?B?WlBYTUQzcmlSTHZ4QmUyZVpUaW5tRnlGZGxPNDdaZWx0cW1TUTE0WmpTbU50?=
 =?utf-8?B?Rmp5d2xvS0p5SkdYaTZOTGdLKys3ckxwMzRSUjVsYWJJLy8yMVlvL3ZFUGR1?=
 =?utf-8?B?TE0rck51OVhJM0MzUUFGcjZ0c2tqRzhwMnpkOWU3SmhsNUczazFvelBTK3NN?=
 =?utf-8?B?TlJ1K1A3ZXhzS2dzM0tNc055RE9PeHluVmV4YXg2TWVSZlhQTHozMDR1M09G?=
 =?utf-8?B?dnRXVGFLRVlwVk1YSnVlNFY3UkdjQ25ENVd0WGxGWCtHNnpsYUxMWFp6TzJN?=
 =?utf-8?B?d2RVNG0vNnpWRWZJNXo1dHg4Q0JWMllDdndxZTZheVhwMEovb2ZTRHJlZ09V?=
 =?utf-8?B?SGxhNWFQWVBsY1BIbE8zc3FoQUg0RG9LOHpuTktzSHFpSFhQYUVDNGI4UVp0?=
 =?utf-8?B?UjMwNDhXZXI5MVpWZWJnZVp2czFieWI1YkR2RGxkYzBNSXdsd2ZnTzFrL2lE?=
 =?utf-8?B?aW13d1hMZ3diUE53ZjYzSmtyWm9LaWk4djdGcE00cW84a1hNcExUaEZOYm5M?=
 =?utf-8?B?Rzk2bks1ZTdnam0xd2drcUZvUjl0TjkyM3FSVDNQS2M4QlRXMVJyL0srZEs2?=
 =?utf-8?B?ZFpya0RZaERiRmxDY0ZHKzdHUy9MODQ1ZFB2OVF1M3BaYURvejRwaTdCdnpU?=
 =?utf-8?B?cnBoNkFPYjl1TkJhRk9vaWlnRFM0ZWxUM2RNUElkNjBBc2Iydy9vaFFWeFZT?=
 =?utf-8?B?RmZBYkgwS1dGSEx1eUhQeUl0cE10Z05QcFdqRHdLQkdZTjUvYlhYVnFWWFZ5?=
 =?utf-8?B?NCtaenNDV0Fsa2ptY3EyZWswTDdJZlpPVndGbmtOSnNXaVF6TEJUQ2p2Sllk?=
 =?utf-8?B?UXJGU1NMM3VVNG9PTFJjTGdYZ1VVbHozdnVBZjdvYTkyZXMvRWV0a3FUcExB?=
 =?utf-8?B?RmFXUDJGZlZwMzcxQVhYeDlFMGN3OGtPcE92dUtVSTJCak51WDc4dmJjLzd4?=
 =?utf-8?B?VG03cGVXem1FNmNwZzB6Vkt6Um9WaFhOWmc3YTFIZjdveXRUT2QvT0pOVHpi?=
 =?utf-8?B?MlU5MmdtcVVUaVJJU2JPSS93UU1GYXF6OEZVeDlhcUQ3bzNZWnBKSTFtL3pN?=
 =?utf-8?B?UWV3TkR5QlI5Z1hTN0s5WHgvMGNGN0h3ckl0RytJcVJmbVZVaGZvY0h1WUlZ?=
 =?utf-8?B?VGdzQldrR3ZjRmpkR3cveVR3M256UG9yUGFrU0x1NkowSWQ3VFRaRDdHWDlG?=
 =?utf-8?B?cmJNbmcvUnZLZVorN1RLR0s1M3EvdVBsNkJkOVZUckg0dENMZTl2TlhsVXJI?=
 =?utf-8?B?SWpyaXpsNFpzdXN6MTR0WlRaTGZPUzdoYmdmdmRUWUJDWEVodnE3V0padUk3?=
 =?utf-8?B?TWNXSCswVE0xNFdMYXd4Q0ZRa284NHJGYmRVMTBLYVdCeEFlc3FJSTh5bkNq?=
 =?utf-8?B?SzRZL2NUcC9Hb2lmK2J3QjdJOGVvaXVTQzlmR1VuN0RpUlRTUkpIeFhaTGNC?=
 =?utf-8?B?OFdyQUtmZlZ5elFJQkxXb1BvTkk1RStYbnQ5T0NLTEJNUGNOV0Z6SHQ4ajkz?=
 =?utf-8?B?bTNnTFZ6MGVXU1p5dDhOK1psd1ZIZExRQjBmaFRnTDRON29lMVlMR1ZLOFZi?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f335732-c3bd-4424-73cf-08dc580ec6b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:59:26.8069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG83n1jRhZKrctHBMNkreblJY1DIn2FQ9t3ExJ5OU9EBJUxx8bzo5ghC81RtSGO9acT1BDbcRq8OaSpUF0rJApk2e57PusYQSRCW7AhTO+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com

Hi Peter,

On 4/8/2024 12:05 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Sun, Apr 7, 2024 at 12:21 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> I think this needs more thought. rdt_enable_key is x86 specific now and should not
>> be in the fs code. Every architecture will have its own task switch code, with
>> __resctrl_sched_in() belonging to x86 and thus not something to be directly called
>> from the fs code.
> 
> I think we will need to discuss whether __resctrl_sched_in() is really
> arch or FS code following the changes in this series. This series
> removes the explicit MSR access and James has already provided inline

Indeed, I missed how resctrl_arch_update_cpu() introduced in
"x86/resctrl: Abstract PQR_ASSOC from generic code" results in
__resctrl_sched_in() being architecture agnostic.

(sidenotes ...  it is not obvious to me why resctrl_arch_update_cpu()
is not consistently used, for example, in clear_closid_rmid(),
and it also seems a better candidate to be inline within
arch/x86/include/asm/resctrl.h)

> wrappers for the mon and alloc enable keys[1], so I can only assume
> they are architecture-independent in concept.

The wrappers are intended to be architecture-independent, but the keys
are architecture dependent. Quoting the commit you linked to:
"This means other architectures don't have to mirror the static keys"

Reinette
 
> https://lore.kernel.org/r/20240213184438.16675-18-james.morse@arm.com

