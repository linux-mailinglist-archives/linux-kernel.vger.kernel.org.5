Return-Path: <linux-kernel+bounces-132245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D71A8991F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8143B1C21A29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6313C3DE;
	Thu,  4 Apr 2024 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9cSSAJQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4690D13A41A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272525; cv=fail; b=L51NkTED9jd4j7U3Lc39bia+EM1p24PebXooJa6Xew5LTzIGtmKnvYxKA4I2DIJZZ3S0DwxYU36yck8STN79BRZlVwgrOBhNf4nafeqqJx8OHT8yemyMlgmb00wtJ+IZLJADemzOKW8oRljWZmhmq443palhjy5UFG68dKq7xQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272525; c=relaxed/simple;
	bh=YHfLZjXEkZJ2VJPEEEvBd3EWX1fUcKYGcGEa8WRBvTg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MN7jzazF+TuiJVPeEtGQAN73oPFcHYdv3WQTnPOMbsIS28ROtt/FVkoP6gsuOpXoGRDh/9Vh51jqII10MnRgZADlpqDPb8vMiKyDqcmeQx9J4M8Ap4PzlJOapdOCVdTHZmgRC0BZgbvmDrL7H9jpyi3EBV8Geu/W59FZg2N2eB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9cSSAJQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712272523; x=1743808523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHfLZjXEkZJ2VJPEEEvBd3EWX1fUcKYGcGEa8WRBvTg=;
  b=M9cSSAJQ3Aix3h6BCY3QQJLIkKJ2qs9zGRx49MmwskHvd0WwRyBg/eUk
   0yaPVeNfMJuJBPTwKO4Hpx1zbXeEvg7w54emzgnWjnMcmVqFQLRwmrxjC
   YFse6UNMrWntQXfhGwF/sF7xgarbkGInAY3ZoFnD1MzVuYn7pnkCS+BCS
   iSxzSrJJbRh0Ra7qE9BNEduvZ1MYgENOk7M43rhc0D2Mrk+sypivmLKlH
   Vy8/jkOf/72MaIl5VvAV9/0yY0InOrnjgHDcDn4jZoUO5XC71OdvIXD94
   fkjdwbLbeCr1aziMnE85ZcrmXX316KFp4CBYK62IadGpnmAZbZcXXwQuz
   g==;
X-CSE-ConnectionGUID: Z9wQnlgVRiaOvshYvUbYUA==
X-CSE-MsgGUID: qqiv3Vo/SeWi0Z7LHy4VKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7777081"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7777081"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:15:22 -0700
X-CSE-ConnectionGUID: nTu17xDrT22ELHmCFLhd6w==
X-CSE-MsgGUID: PNmzINX/RvyL8zSIilV8NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18916472"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:15:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:15:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:15:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jqd0IrQOQ39kZOgcOh+DB662YBqJFm8+NDEQFyI77QFG5UrItbFO6Q+hGuoYQylq3zDSCtCk+agKTM4iFaTHyRNa/fc6feXPyLNHMyRRdi6dVxIsBJ7edyMrPk30Af5tcyTKv9wf6FclmgrOS+lzVt6XKRchl2M8tBfcxJ2+tJ5LSwIxv+0WmFwOUj2gR8xSoNTHLOpR5GnkSraIo/v9cREjEyqYFn071ZjfvhCh+0ZPJUl0uU2rgNRbeHDa0k4qMMl+chhJabzMorF4EaAgPa5fFK79xCS/J/j6BxH7qh3l6MYYAe9Ogkf41oqUjLNVrm+VJsZ22v+dUxGkG2IfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q84J5noxkIFhtRT3oKAry8w+gL7L3YAaXK61DOlsIx0=;
 b=ISZV2G9dhq3mTf3dH3nxzfuIOFbYpN48j05T5Ofc1LttRUR9mcZnnwehvlnECVv64yh5S9MFGQ6HE1u64MJ2YrAPW+UmZVz4PidFqmilk30G+WdJSG07hGX++jCXEy/BGzqW8c2czjvZ6FRfAQ+wEor/MI66Vn4j47qfd7+8v5DChyhEfBWtIHdZgUicM8F/eMOvKvnFpmMhXxR+7fE7fi345Rwptp32qlQ+U/UN7tZLQZL3XSgnXEtM4un+nDtvbfnH4s+Tfs0MEl5dzTR3Q2dN1DZfToZsn758aWiZA3++mHw9NShybcfOyWnerQl6pZUNDY+TiEAv+rld7DCx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 4 Apr
 2024 23:15:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:15:17 +0000
Message-ID: <693842ee-67a7-4187-a02b-9041c3c7edd9@intel.com>
Date: Thu, 4 Apr 2024 16:15:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] x86/resctrl: Use rdtgroup pointer to indicate task
 membership
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	"Valentin Schneider" <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
	"Mike Rapoport" <rppt@kernel.org>, "Kirill A. Shutemov"
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
 <20240325172707.73966-5-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-5-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4847:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ET+Meo8VASnEcE1eu33WCY5Wo/ExwPIJMj3XRu7xQ6+k6qm+iwB+0g2uLd6KZvrIDGfAD4IXSwLGuyB3xNAW6zFqbqV842piXbonTxc9itvNt7+oD5u+ixaeiow7NjtVFyPzOuFowrxWuqQ9MxhfEkvVZdMnpFHY/RZB2V8T/AX3PWqWCq6dEJN8xiiHLBI5JTwV2h5+xOq4XgR5wcyy24Yp86ElN0UPEnxkzoMmCyaLvf2lbT1IOjWVb1amvWMKs73XTkBHJosu51prn6981zKMc7m46ooDvVOzqU6LS0L6HrwOdIZ/e6kXnqKw49prUjtKXm+TnpkbAdu6PjlRYQlJFooY6S1FmV6Cn81IrUwSUGbJ5TUX69IJqmd2pAWwA7uDKVLQxdfVRRsdQf/89xy9EMxIYcFFLoAaoBxlTERGINGKfKCyCD3KM5ANShBpKEXj7k4LmhoOqiPLBSX5sCm1syEQVwuvo1hJq0ybX7GRbPWsuxnS7+BG6mi1dVH6yRH4e78QtNIcgj5eBVuXi7Sdlrbjyk9qwv+49wusjQCmeAmR/WnrejLm+Nz/3P51mFbgao8oBAnBCZwUKLvVZbobsv5are1NUDZl2Yf0/q+AVtQpwFBH9fvAtJ5Cfy1eeruK9+l7BV5NK1XoPMCFsytw8mgdJANjWoxxgRG18Qs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJQMjUxMGQxNkxZRXdyMGJucnYyNjEyRXcxeDhhellWVGJBUUlvNjlVSVNX?=
 =?utf-8?B?RE5DVzRSdnRqOWtkWmkxaFd4U2F2VjJ1anhWWEJOTUlSTmR0U0pmd0RvL0hk?=
 =?utf-8?B?WG8zK2hkZmlvVVVtQTZYOWdYKzZjRTFITnZYaFBTS2pVNzIySGR3YU1tbWd3?=
 =?utf-8?B?NTNydktNZi93Wmc4a0pVQUxEZG9TVFRmWUpnRldPNkhNeTJsTU52U29TcEIx?=
 =?utf-8?B?ODk0eGJ1OFdNaXJIMmxXZkRiUDQ0dXJuZzBvcXlQb3BPazdHdlEyUGJrQ21B?=
 =?utf-8?B?WjJVSnU5dDhXRnFmaU0xUk0zM3BCSlRyOUtUd3ZaOWdzRjBOS2VBVUhSVjN6?=
 =?utf-8?B?Y2x6YnBwS05odDZ6U2lCc3VaYVkxbFNGaGFJM3RZRVU2ZjFmNDlNL01DSDlI?=
 =?utf-8?B?NmMxamR3aFphNDdndFRVNmdqS1ZRaDVxZFAwL1M1eWloWTl0VTlKdm9uTEYz?=
 =?utf-8?B?dmxOemRTRmtzUWF3WGV5U2JncXNmbG5PSW5jTXhZRWxtOEhuVVBoWWhmb0FC?=
 =?utf-8?B?TVF2bUlrTTFYU0g2UmJZaFp5elhnTEl4WDV1T08yRnhNaDhJUWl5ZVgxLytK?=
 =?utf-8?B?cWVGQjEwbVRZR1hLcXY5NHlsVUlGcWpNZnZaWGp2aFArL3JVeWdkSWsvY1g1?=
 =?utf-8?B?cFZjVW40Q2lVWU92M1dmdjc5SXZPTnZQNkJoa0hoeEMyOStWOE00NGpQUHNV?=
 =?utf-8?B?czVSaTJINzhjZk9aL3BGa0VnMUxLMEdQYmhYWkhURnZMVjlKR0FtZm1lYUNR?=
 =?utf-8?B?L0ZyNDJRbzNnajNYZlNuMFk5SVF4cnNKNGtyR0YxQjV1ZUNNbHJhQ0FUVkZh?=
 =?utf-8?B?cDI2aFBCdWlvNFRUYmJYOGlxWm9xTjRleEx0UC9sa2N2ZlFkbS9WamVpa1U0?=
 =?utf-8?B?ZzRXbGZWQlVmTzlLNXhtWlp0eGY2RkVRaGMxL0E1OG9YOEZyK0RhWlpsZzhn?=
 =?utf-8?B?dUtvRGc1d243TFdVR0lFbTBoK2U1MHp0ZnJXUElGZmpBREVmTjdaWGFjTzFW?=
 =?utf-8?B?TGJyTEwvN0ZVeVoveG5jcjFyVERFVmh6bEorRkU1NmViMTB5Y3lBNUxmNjll?=
 =?utf-8?B?UEVIZDljdldPclFDaHV6MERRZ0YzeGJTR1BCTGJXakViZjNMcjNzYm04TUdP?=
 =?utf-8?B?T0JIUjNnaUttM1lNVW9FR0FhQmNCR2d0MFR4dFVreTdrazErWitXWVdHbEx6?=
 =?utf-8?B?UGsvejJ6cGpMdXowVTQ4Z21rNnBZSDVjU0Q0M1hWYkxRM3JDRjVibFFYTWZ6?=
 =?utf-8?B?eFlIQXY5UktyWk5UZUE0YjVkOWtxaUY1NmY5ZGFGV0NoU2tOcVJkS1MxcFNk?=
 =?utf-8?B?N2VleVJRUncrVUFtb1UwWVZncjhCVnU3WkEwUUlDdHErOWFZa0JXR0lvRXQr?=
 =?utf-8?B?b3l0MkFZUG9nZCswVkgrV0M1SS9RTS9UaHFZdlNxMDJyNFhCZjBtVG8wZzk3?=
 =?utf-8?B?NTZrd2tKeXkwM0V0VUlIcTZDb1owTFJzS2NHQzk5WlhmRCtoTEZ5ZWVDTGpE?=
 =?utf-8?B?b2Vwd2RycmF4VUR2Ny9qSlF4SEM2SnBLZDFKUW9KSHJ6MzltN25HMjIwNkxM?=
 =?utf-8?B?M1pzaE5WczRaaFo4d0JPaDR4c3RNRkRtNlA1RTUvdDFNTmg3OUErNWI1WThw?=
 =?utf-8?B?Rnhqb1R5eDhEVXU0VENUaFJtemhZcEVEbzZ1ZmtVYnUxRTd5Q2RlVFZ5MUZY?=
 =?utf-8?B?S1ZUMUhCTFZIcFJpeXdvd2tEUE8raE95VUxub3lxM0pEWjNJZXVIWnVEQkg2?=
 =?utf-8?B?R1RrbmVnRUJwR2lGUC9HM1VhN3k2TndjSTgxLzhWaWxBK053UStxVDlOV3hV?=
 =?utf-8?B?Wm0xdnNjLzdreXdRL3g5YjdySGE4cWdXTmR6aVF3RVJNdGM5VFFIaDlYc2t1?=
 =?utf-8?B?OW9PNUEyYVNYNFBxUDNaUWVPcXdtYUhnaUoyNVFISDduL0NjVm0zU0QrYUZR?=
 =?utf-8?B?SzluR29vZS9Zc3JzYXhMZHU0NzNxRnJSUGQxVmJoNEVXRnZRMjRvQ2grdS9m?=
 =?utf-8?B?SVF5aHBPbXdwWWdXVlZXRGlHT0h1MEFKOTBtdkdsQ1lvNC9Ya1llWXErMW1D?=
 =?utf-8?B?d3BMMmxHelk3REpISGlRUUFSMHpOMkhnTUlzQklwL2wwbFRXbmZHRXpjTlZu?=
 =?utf-8?B?aE82THNpWk9sMVZyNUVvOEh6M2VsOUgvbGtDMjZwaEtIZVFydDB4dVZkL0wx?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 535b5009-cc37-40e2-2c17-08dc54fd176d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:15:17.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHyEZNmyp/RIEMC03H0aEYG2nfSBG07CqMFG2melIbIlLN92t4mk0aYsHnoQsVcKVGFKn5GV/cZKb65Kqq8YRNYhflvBh25mxuiRjXDUonA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> Caching the CLOSID and RMID values in all member tasks makes changing
> either ID for a group expensive, as all task_structs must be inspected
> while read-locking the tasklist_lock.
> 
> A single rdtgroup reference from the task_struct can indicate the
> mongroup and ctrl group membership of a task. In the case of mongroups,
> the parent pointer can be used to determine the CLOSID indirectly,
> avoiding the need for invalidating a cached CLOSID in all task_structs.
> 
> This also solves the problem of tearing PARTID/PMG values in MPAM, as
> the parent pointer of a mongroup does not change. Therefore an atomic
> read of the rdt_group pointer provides a consistent view of current
> mongroup and control group membership, making __resctrl_sched_in()
> portable.
> 
> Care must be taken to ensure that __resctrl_sched_in() does not
> dereference a pointer to a freed rdtgroup struct.

"care must be taken" ... could this be expanded to describe how care 
is taken?

> Tasks may no longer be
> reachable via for_each_process_thread() but can still be switched in, so
> update the rdt_group pointer before the thread is removed from the
> tasklist.
> 
> Co-developed-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/include/asm/resctrl.h         |  18 ---
>  arch/x86/kernel/cpu/resctrl/core.c     |   3 +-
>  arch/x86/kernel/cpu/resctrl/internal.h |  13 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 205 +++++++++++++------------
>  include/linux/sched.h                  |   3 +-
>  5 files changed, 110 insertions(+), 132 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 99ba8c0dc155..be4afbc6180f 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -64,24 +64,6 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
>  	return val * scale;
>  }
>  
> -static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
> -						u32 closid, u32 rmid)
> -{
> -	WRITE_ONCE(tsk->closid, closid);
> -	WRITE_ONCE(tsk->rmid, rmid);
> -}
> -
> -static inline bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
> -{
> -	return READ_ONCE(tsk->closid) == closid;
> -}
> -
> -static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
> -					   u32 rmid)
> -{
> -	return READ_ONCE(tsk->rmid) == rmid;
> -}
> -
>  static inline u32 resctrl_arch_system_num_rmid_idx(void)
>  {
>  	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 83e40341583e..ae5878d748fc 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -600,8 +600,7 @@ static void clear_closid_rmid(int cpu)
>  {
>  	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
>  
> -	state->default_closid = RESCTRL_RESERVED_CLOSID;
> -	state->default_rmid = RESCTRL_RESERVED_RMID;
> +	state->default_group = &rdtgroup_default;
>  	state->cur_closid = RESCTRL_RESERVED_CLOSID;
>  	state->cur_rmid = RESCTRL_RESERVED_RMID;
>  	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 56a68e542572..0ba0d2428780 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -334,14 +334,8 @@ struct rftype {
>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> - * @cur_closid:	The cached Class Of Service ID
> - * @default_rmid:	The user assigned Resource Monitoring ID
> - * @default_closid:	The user assigned cached Class Of Service ID
> - *
> - * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
> - * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
> - * contains both parts, so we need to cache them. This also
> - * stores the user configured per cpu CLOSID and RMID.
> + * @cur_closid:		The cached Class Of Service ID
> + * @default_group:	The user assigned rdtgroup

What is meant with "user assigned rdtgroup"? How about "Resource group
to which this CPU is assigned." (still sounds awkward, please feel free to
improve). It may help if the header is "Per-CPU state cache ...". 

The naming is potentially confusing though because there is already
rdtgroup_default ... and frequently assigning default_group to
rdtgroup_default gets confusing quickly. How about "cpu_group" or
even "this_cpu_group"?

>   *
>   * The cache also helps to avoid pointless updates if the value does
>   * not change.
> @@ -349,8 +343,7 @@ struct rftype {
>  struct resctrl_pqr_state {
>  	u32			cur_rmid;
>  	u32			cur_closid;
> -	u32			default_rmid;
> -	u32			default_closid;
> +	struct rdtgroup		*default_group;
>  };
>  
>  DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 8d6979dbfd02..badf181c8cbb 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -348,25 +348,55 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>  void __resctrl_sched_in(struct task_struct *tsk)
>  {
>  	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
> -	u32 closid = state->default_closid;
> -	u32 rmid = state->default_rmid;
> -	u32 tmp;
> +	u32 closid = state->cur_closid;
> +	u32 rmid = state->cur_rmid;
> +	struct rdtgroup *rgrp;
>  
>  	/*
> -	 * If this task has a closid/rmid assigned, use it.
> -	 * Else use the closid/rmid assigned to this cpu.
> +	 * A task's group assignment can change concurrently, but the CLOSID or
> +	 * RMID assigned to a group cannot change.
>  	 */
> +	rgrp = READ_ONCE(tsk->rdt_group);
> +	if (!rgrp || rgrp == &rdtgroup_default)
> +		/*
> +		 * If this task is a member of a control or monitoring group,
> +		 * use the IDs assigned to these groups. Else use the
> +		 * closid/rmid assigned to this cpu.

Please consistently use caps for acronyms.

> +		 */
> +		rgrp = state->default_group;
> +
> +	/*
> +	 * Context switches are possible before the cpuonline handler
> +	 * initializes default_group.
> +	 */
> +	if (!rgrp)
> +		rgrp = &rdtgroup_default;
> +
>  	if (static_branch_likely(&rdt_alloc_enable_key)) {
> -		tmp = READ_ONCE(tsk->closid);
> -		if (tmp)
> -			closid = tmp;
> +		/*
> +		 * If the task is assigned to a monitoring group, the CLOSID is
> +		 * determined by the parent control group.
> +		 */
> +		if (rgrp->type == RDTMON_GROUP) {
> +			if (!WARN_ON(!rgrp->mon.parent))
> +				/*
> +				 * The parent rdtgroup cannot be freed until
> +				 * after the mon group is freed. In the event
> +				 * that the parent rdtgroup is removed (by
> +				 * rdtgroup_rmdir_ctrl()), rdt_mon_group would
> +				 * be redirected to rdtgroup_default, followed
> +				 * by a full barrier and synchronous IPI
> +				 * broadcast before proceeding to free the
> +				 * group.
> +				 */
> +				closid = rgrp->mon.parent->closid;
> +		} else {
> +			closid = rgrp->closid;
> +		}
>  	}
>  
> -	if (static_branch_likely(&rdt_mon_enable_key)) {
> -		tmp = READ_ONCE(tsk->rmid);
> -		if (tmp)
> -			rmid = tmp;
> -	}
> +	if (static_branch_likely(&rdt_mon_enable_key))
> +		rmid = rgrp->mon.rmid;
>  
>  	if (closid != state->cur_closid || rmid != state->cur_rmid) {
>  		state->cur_closid = closid;
> @@ -385,10 +415,8 @@ static void update_cpu_closid_rmid(void *info)
>  {
>  	struct rdtgroup *r = info;
>  
> -	if (r) {
> -		this_cpu_write(pqr_state.default_closid, r->closid);
> -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
> -	}
> +	if (r)
> +		this_cpu_write(pqr_state.default_group, r);
>  
>  	/*
>  	 * We cannot unconditionally write the MSR because the current
> @@ -624,49 +652,61 @@ static void update_task_closid_rmid(struct task_struct *t)
>  
>  static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
>  {
> -	u32 closid, rmid = rdtgrp->mon.rmid;
> +	struct rdtgroup *task_group = READ_ONCE(tsk->rdt_group);
>  
> -	if (rdtgrp->type == RDTCTRL_GROUP)
> -		closid = rdtgrp->closid;
> -	else if (rdtgrp->type == RDTMON_GROUP)
> -		closid = rdtgrp->mon.parent->closid;
> -	else
> -		return false;
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	/* Uninitalized rdt_group pointer implies rdtgroup_default. */
> +	if (!task_group)
> +		task_group = &rdtgroup_default;
> +
> +	if (rdtgrp == task_group)
> +		return true;
> +
> +	/* Tasks in child mongroups are members of the parent ctrlmon group. */
> +	if (task_group->type == RDTMON_GROUP &&
> +	    task_group->mon.parent == rdtgrp)
> +		return true;

This does not maintain existing behavior. Note that current behavior
(captured in removed snippet below) is that CLOSID _and_ RMID must
match. The consequence seems to be that the only used of this function,
which is to support moving of groups, can no longer move a task
from one monitor group to another within the same control group.

>  
> -	return resctrl_arch_match_closid(tsk, closid) &&
> -	       resctrl_arch_match_rmid(tsk, closid, rmid);
> +	return false;
>  }
>  
>  static int __rdtgroup_move_task(struct task_struct *tsk,
>  				struct rdtgroup *rdtgrp)
>  {
> +	struct rdtgroup *task_group = READ_ONCE(tsk->rdt_group);
> +
>  	/* If the task is already in rdtgrp, no need to move the task. */
>  	if (task_in_rdtgroup(tsk, rdtgrp))
>  		return 0;
>  
>  	/*
> -	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
> -	 * updated by them.
> +	 * NULL is used in the task_struct so it can be overridden by a CPU's
> +	 * default_group
> +	 */
> +	if (!task_group)
> +		task_group = &rdtgroup_default;
> +
> +	/*
> +	 * Set the task's group before the CPU can be updated by them.
>  	 *
>  	 * For ctrl_mon groups, move both closid and rmid.
>  	 * For monitor groups, can move the tasks only from
> -	 * their parent CTRL group.
> +	 * their parent CTRL group or another mon group under the same parent.
>  	 */
> -	if (rdtgrp->type == RDTMON_GROUP &&
> -	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
> +	if (rdtgrp->type == RDTCTRL_GROUP) {
> +		WRITE_ONCE(tsk->rdt_group, rdtgrp);
> +	} else if (rdtgrp->type == RDTMON_GROUP &&
> +		   (task_group == rdtgrp->mon.parent ||
> +		    task_group->mon.parent == rdtgrp->mon.parent)) {
> +		WRITE_ONCE(tsk->rdt_group, rdtgrp);
> +	} else {
>  		rdt_last_cmd_puts("Can't move task to different control group\n");
>  		return -EINVAL;
>  	}
>  
> -	if (rdtgrp->type == RDTMON_GROUP)
> -		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
> -					     rdtgrp->mon.rmid);
> -	else
> -		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
> -					     rdtgrp->mon.rmid);
> -
>  	/*
> -	 * Ensure the task's closid and rmid are written before determining if
> +	 * Ensure the task's group is written before determining if
>  	 * the task is current that will decide if it will be interrupted.
>  	 * This pairs with the full barrier between the rq->curr update and
>  	 * resctrl_sched_in() during context switch.
> @@ -684,19 +724,6 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  	return 0;
>  }
>  
> -static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
> -{
> -	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
> -		resctrl_arch_match_closid(t, r->closid));
> -}
> -
> -static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
> -{
> -	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
> -		resctrl_arch_match_rmid(t, r->mon.parent->closid,
> -					r->mon.rmid));
> -}
> -
>  /**
>   * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
>   * @r: Resource group
> @@ -712,7 +739,7 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
>  
>  	rcu_read_lock();
>  	for_each_process_thread(p, t) {
> -		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
> +		if (task_in_rdtgroup(t, r)) {

Looks like task_in_rdtgroup() was modified to combine these two checks but care needs
to be taken for existing usage of task_in_rdtgroup().

>  			ret = 1;
>  			break;
>  		}
> @@ -830,7 +857,7 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
>  
>  	rcu_read_lock();
>  	for_each_process_thread(p, t) {
> -		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
> +		if (task_in_rdtgroup(t, r)) {
>  			pid = task_pid_vnr(t);
>  			if (pid)
>  				seq_printf(s, "%d\n", pid);
> @@ -924,53 +951,34 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
>  		      struct pid *pid, struct task_struct *tsk)
>  {
>  	struct rdtgroup *rdtg;
> -	int ret = 0;
> -
> -	mutex_lock(&rdtgroup_mutex);
> +	struct rdtgroup *crg;
> +	struct rdtgroup *mrg;
>  
>  	/* Return empty if resctrl has not been mounted. */
>  	if (!resctrl_mounted) {

resctrl_mounted needs to be checked with rdtgroup_mutex held, no?

>  		seq_puts(s, "res:\nmon:\n");
> -		goto unlock;
> +		return 0;
>  	}
>  
> -	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> -		struct rdtgroup *crg;
> +	mutex_lock(&rdtgroup_mutex);
>  

..

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 3c2abbc587b4..d07d7a80006b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1236,8 +1236,7 @@ struct task_struct {
>  	struct list_head		cg_list;
>  #endif
>  #ifdef CONFIG_X86_CPU_RESCTRL
> -	u32				closid;
> -	u32				rmid;
> +	struct rdtgroup			*rdt_group;

(I'm thought about whether this should be an architecture-independent name
considering the goals of this series and the visibility of task_struct... but
on the other hand we are still stuck with that name for the struct.)

>  #endif
>  #ifdef CONFIG_FUTEX
>  	struct robust_list_head __user	*robust_list;

Reinette

