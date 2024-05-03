Return-Path: <linux-kernel+bounces-168409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D78BB842
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D468628350F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519A84A4F;
	Fri,  3 May 2024 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgs+htxO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC5290F;
	Fri,  3 May 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778916; cv=fail; b=atMVkH4i95+obuTS1uICXsJ3ZjqcRp0EPNuIvL9lm0mcdIv7E+eohch2y8uyIcEjHVkDpSvn54yr0IOg3QzCTVpxuI+g1euGLtAAQemItgZYKlGKbt87n83eDBMOx4215LCOXBJP3rTYg7bQ+ZQ0RboyuBg0E+BmAi2rGK14/lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778916; c=relaxed/simple;
	bh=xyfDdv+quamlpmQ2bn6t17zNIY42I0OMQKEd/Da8Rdk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GKLhCnkABka4Eb/v7kV6oZ5fv65rbOz6eVcYnHFSzN+sIIgav9iVkvCcBslvC4sjZso03ci4eb0h1w2E8kLjd/kfjjht1OiasczFh+t+6+reGYX200GnkBHBTmkHgbG9NAErozQHohnvMXIpM0kCH2UQVKXOEWlU3HAl6iESztg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgs+htxO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714778914; x=1746314914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xyfDdv+quamlpmQ2bn6t17zNIY42I0OMQKEd/Da8Rdk=;
  b=hgs+htxOaJDudmr4U7opV+EwnzA9SyLER2ngIwBmQyB8tJVXOQtwFgJb
   +H18SMGwfzE2PiK/rNwF/lNcIWSZdw1Uo307ecnKTAw4wBdthMmdenHsx
   2IzeVuTkYbNDFxqNN1OkUxUhjQ8xp8/0NSn3bg9qjfEMMnYZ/IlsR8vlZ
   aPkxmX1UBO7eyNpk8iWMaJQWIqBJrZWwAD3Z6aUpTqKoOgD64vVFsiDZ0
   euglsEct3+D8X2yqXH9q9YBXkiMjaERGNxJhcK934XpKd9uOhWybOYSmu
   6F3cxAplVFv7zsA7N2f3fkOIpiWcUdp/H6mO+EVgcuR/7RvvSJ0xwOW8i
   A==;
X-CSE-ConnectionGUID: AJUYAkqlRMWcpSSaptl6tA==
X-CSE-MsgGUID: aZQD7Se/QG6ehUutdH6p7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10452717"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10452717"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:28:34 -0700
X-CSE-ConnectionGUID: YSdlZXXvRjGpHRxvQNIelg==
X-CSE-MsgGUID: I9JMMX0DS+WBjajn0Mx2PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="58790570"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:28:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:28:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:28:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:28:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdEfqvQzP26JzAhN3PqBWlZ9lNKIjL/tkVBMDBvJLQUhKa9tRbW0j12EkRjzDletK6FCSq225iJCRf2ZSN/A4hC4bxQsSZ1WmETBIcshp9GYffqYquMN8gFXEhgngRzY8Ll49TxnBGxYXh8jZkbT8hA47u/+wQFpLVNjT012g9Q5oDRekYg9YtKk1GBpeLCbnJvalqsQ9iCVChyu8KfKfOFWEXTEn4ohRpu7d/hS46xcxUpUdpeNtdkoY7cwi1LK0pCR7LxAMt2Eb3Ix6hd/yr071wyoEUrvcfrokbcaaAd1hZOsEWol6guWh3GA91CQWwFiX1QuFKM8obGYSj3Vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa8F6tLcDh/tpU8zpzhvQoAU5HxxWy5bPdcXXZpD2tk=;
 b=NXJAR37jOxNnLfF+SLPLpHqJmIebkLYgjU/9WE2ITBO3frCUSxFx6ojJzioxMuOESKLT2LgdOvSwx6PDnCL9DIvoap3sB5po6sBPCQkrF8n+Yyb8lAELu3uIFdRknd/dfcEBNCmsQtIAykZX0x7Swk6J6+8HAq7Cln2CAkXqOyIFUTVS6DmhHDK6ze/Z0MmIh1vO2ajfEDgfExp2z8Wycvxv3mgNYqUlef7VH0PLj2BYVUygCd/GX4ClSG8Yp0IlyHd8zP0m8X4z6vOx89bhVTfd36YxkXkiZRCA21bhgtEChE4y+ZHtkmKACHCiRAsPBJKTzXw0bd7eMW/YdCM7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:28:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:28:27 +0000
Message-ID: <9fd1c700-fa24-4290-aa77-a6eda9758ace@intel.com>
Date: Fri, 3 May 2024 16:28:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/17] x86/resctrl: Introduce the interface to
 display the assignment state
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <e50e1e55c2ef4f5e1609960e573b30a125a59e5c.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e50e1e55c2ef4f5e1609960e573b30a125a59e5c.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6e0528-45b0-41d5-933e-08dc6bc8bc5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkMzblJlVUhPNE9HbkhxMGF3ZnFoOC9JRjhzdWdqVHdoaGxNaUx3Mk42T1ZH?=
 =?utf-8?B?MlExblFTUTJpUGgwWFNkdEd2UUIwVXI3aUVzcWlud0pXdEtkcVpKd0NzZ3Ar?=
 =?utf-8?B?WGJSM0NmNEs4N201ekVIR2NFVmFXUTROOElGMHA3V3liZzV4aS9qN2V3NTF1?=
 =?utf-8?B?OThtdFJUS0pKbWVnU0NoOUxKb09XbTdEZ2lpS2xFd0NUbmlDUGtlNld0VFUz?=
 =?utf-8?B?dDRWUkdtaXJZMjRVMnJxTE0rdHNkWWo5MUhMSkk4bFNDRjFkUURVemZWZ1JT?=
 =?utf-8?B?NlF6YmMxd1YyVGd5REcyWVo0djBzaEhPbEdoYzVNVVlYY0x1OUh0c29QdlVv?=
 =?utf-8?B?czg5MUgyekRTZHB4RENJZ2xwa1FYTmtaRUVsT0tGYlZnWVIvWUszaHNwM3hB?=
 =?utf-8?B?NDJLcTlWOHRqVXZiM0ZKSklPbkZacGg1QmZVdVVScTd5WnhmZGlzbWRlSjNT?=
 =?utf-8?B?THRwT0pBZXFNRzhXK1NxU2ZRVDlqaGc1VEFGVHRKdCsxbG9TYmpYeE1TU0Fp?=
 =?utf-8?B?NWNvTVZVY2o4RncxZW9OdDhyTG03Tkd0TjhSb1FCYUozNHpPL2h0ZDZDbk0z?=
 =?utf-8?B?bEgrcklDcUFMelpoQWNHbDNoL2szaVBQMUY1YlphM25xNEtIWVBIUWlKTFlv?=
 =?utf-8?B?ZEVRTndVOG5jLzR1M3NLOHcwVjhwMklTRDdVOXJNQWFqRXdSZ0FQcVJ1aklZ?=
 =?utf-8?B?cXVXK0thb3o4U0pYMHV3M2xpRDgveEtYbkZ4L2ZLNlZ4dVRhRjdoQk9XR2xT?=
 =?utf-8?B?RnVZUk5NUDdrd1h2Uk9OT09JWjI5ei8rMnRKbnV5SmFtU0Fhdy8yZ1Qremdv?=
 =?utf-8?B?azdGcmdyVmxraEphRk10aFVEUnhtVlJlN2xNYzRTSnorTEdDSnZUSloxZE9K?=
 =?utf-8?B?dUI2bWRMN0htNXFMRGQwRE8rUzI0cmNNcnBtMEZxMzl0aXRIU3EvY0JVNERk?=
 =?utf-8?B?RWdXM3c3STEwUmNQTlUyeWx5N1VBaVM1SWRjckRCOG9EdXVSSE4yZ2toNUNN?=
 =?utf-8?B?MzdjOW9vaFFYb0RMU2p4RFk3OVZMS213ZGlUeml5R3dzb0t5bnQrRlBLWEZp?=
 =?utf-8?B?YTRxc1NscnE0UFJFc2VhTDNoWW9sekt5eDZDb3JWcVl5NEp1NUF1cllNTjF4?=
 =?utf-8?B?NWVWMi9hdVFsWGVqRTlUWXdtd3JoNURWVWZNZ2Jna1NOTCsvVFhXL0VPcDl1?=
 =?utf-8?B?T21vTzY4cGR1YXE5a0ZFcXdBZEtxNHd1ZzB5Z1lya01hekNCcE4zTHhzdDJL?=
 =?utf-8?B?Y1M0d0lkUzlnS3lNZW9pWXZnR1UwUTRad2EyUXV0R1kyd1ZYeEZuVy81T0Qr?=
 =?utf-8?B?QXhsUys2U01Fak1kVDhSeXBXTHlTN1FCSVUxY2NTcFFQN3l2SkRjMURKL0c0?=
 =?utf-8?B?VTRsYjlYbGdFaEFaSHFWemFodXBsTkJKTExrazluY0haQkxnOTl4d2Jsc0w2?=
 =?utf-8?B?TjFJWURLckJFM1FuMTRiSXFXQXpDVkk3dU9nNEtHRU1jTFlmZ1ZzS09aSjFR?=
 =?utf-8?B?TndpNWpTbDZ0YTR6czl5V0YxUU8raHd6WDJUYjNXWmpsSEJsMUp0dysrb1k1?=
 =?utf-8?B?NTU2UEg2Wkh0TWNKQ0NvTFEzU29HdDI1ZUxXM0RYakZMbXZvbGl3RTczZlo3?=
 =?utf-8?B?MmtWQnRQbTZvajN3RW5EREhBZTdvVjJ6a2JiREtVdkR5Q1l4YXE2SnhIdjV0?=
 =?utf-8?B?S05JMldtbk5LeituNzU4NnVIZnA4T0M4MmFDKzZjVXRIY3I1ZENKL1p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpjTVRhbURrVDRNQXoxZHdNcUJydFVoUG4ybUZkdE9Udk1vT3RJZ2hoVVJD?=
 =?utf-8?B?RVhySmdIa0pJaDMyaDFmOHhveVBzOCtOdzNvNWlXMDFaMXJBcGhMaXRYUG5K?=
 =?utf-8?B?LzlGazgwRHE0ZFZRM0c4UWtORHhnT21zUS9JSEJ4aVc5TkgvcTgrSmJnVVg4?=
 =?utf-8?B?RGtqQ0U1TXBuUGRxY1FGQmtKRGxrMmV3d1hwV2ZITG5uekNRTGlST0Y2bjQ4?=
 =?utf-8?B?R0h3c01jWSthUVhxdkdzbC9NNUczKzNONC9ZTU4vWlZuMTNpTCt2WEFITTJ1?=
 =?utf-8?B?OUV6ZXRzb0p0c0xwZkEwb1pOV0dGZWcyMDdQZGZxcU9FeDFWdFEzMzJyVjBw?=
 =?utf-8?B?S3pCQldwaEdwcUg3YUlkWTNjWERtWVkzbFJsczU4SzBWWElsS1BUMzgrNmxL?=
 =?utf-8?B?eW1rZTh2MTM3a0JXYWFNMHNRSWduTHF0L3VKVG12Z2NoTzlkQXZXcTk1T1pU?=
 =?utf-8?B?S0xYQVVIcFhZU2NMQkswT3NWcHZNdlMyRERzekY0TExBK0I3WExHNXlZZi8y?=
 =?utf-8?B?TzgxeUxIc0pGUmRpazNabHpkdUEwVDYzRlA5U0sxaThIZlRyTXVZUzA0amJp?=
 =?utf-8?B?RTVPRk9qaXBDMVh1NlNNaVdZdTdIeUcxbzFhWGxMSDlXck1hYm9yMDlwWE1y?=
 =?utf-8?B?Z05FZ3hMeEp4OUlQL1EyVFNIZXBWRnZlM0Mwa2lDNUQwVGJYQWdPbEE5Qm8v?=
 =?utf-8?B?cW43dWhUK3ZPVmEySjgzL21ockNTT0xYc0tndDFJdXVvWFQ2S01OL052NXYz?=
 =?utf-8?B?MGdqVjdaY2tIeWJVdG1kaitaWGpYWW5jR3BJUitWOS8xQ21EdXJDa1UxTnkz?=
 =?utf-8?B?M2g2Yk5QS0VHbU95Zm1HaUtvcXpYbU0vaFpzSmxZTG8vMUdSMHpPZkxaVTg5?=
 =?utf-8?B?b2VuQkFQYzZGSkZHVDNDZ1VWZDdhd0ZpUnYxakZmMGZUbWV6cS8wSWNlYlFT?=
 =?utf-8?B?Z3UxZUhtSHBKMjdBVitYSU9DeTZ0blV1VDdueXpTYW1VSCtZalppc09hWFU1?=
 =?utf-8?B?L2hsNEV4SGhCSkJNaHExeHZXREgwKzloL3B0NG44NzlpMzluUWZkd3lzOTRC?=
 =?utf-8?B?dVNrWGtCOFZSYlBCcWVhQjE2RU9wbm96eXJBSG8rUXJyZzJKbjRWenp3VFdk?=
 =?utf-8?B?MW51amRvRlhUUVJ1Y1ZzSjQ5MU9IeUVEeFY2NXRqKzlWaWg5WnlvVGdJUHo1?=
 =?utf-8?B?NE1PNSs2L002OGpqc2ZPY29rRlNtS3diV2xuYy8xYXRGZFovakhQS0ZJOVFY?=
 =?utf-8?B?ZGcvbHY4YXBlZGN0RmdzYjY3UnZobTdZeVo5aytzSVIxYzZWTVc3U1BpR1ZJ?=
 =?utf-8?B?OGp6L2UzNVlvNHVPcTBLWGxhL0djTUZiMUttVWhBTU5QOEpHeUlTTUtzd2ZD?=
 =?utf-8?B?V0cydTdKMVBNQW1DSWRjSGVpajArdENIVHMvOERBbjJhY2MyYWhuYUhBdml4?=
 =?utf-8?B?ZjQxVDByQWpIbmw1eTA3WTRBdFBmZ2tyL2c0UTI4aUQ2TnA4UEVVcjh1d1Jn?=
 =?utf-8?B?MmZnN1JpaUN6UEV2dVBhNk4raHNYM1NDdkJDQUUwNmVBeHZhdktSMzVJOFFM?=
 =?utf-8?B?WjlxV1ZEdW9UajBXN3hqMmxQS0lLSWlNYWsxQkw1T2lTbnpDajRwVnVvdisv?=
 =?utf-8?B?d3dUakxmOVl1enJEMGJFTXhNdGl4dnZKVWhKUkduVWhkekxWd0tQV3BqMDF1?=
 =?utf-8?B?cXV4UzdGcGhyWm53bWlsSHFhTDVLOGFGRDd3ZU1TbVNybmUxeStIUmw1ZHpH?=
 =?utf-8?B?NkVyVW5QTnN3TnpOTkFBdmZKT3VRcmhINy9WcW80azI5Q1pOa09aWDNLUXRC?=
 =?utf-8?B?WGE4K2I4ejc1NDAzdzdtejc5SGhuWHVIdnNvaUN0elI5VEdmSDU5b0Ixc0hx?=
 =?utf-8?B?eFMrcng1bHdHTFRZbEpydTQ5ODRsaGNBbDBkM2J1dmxlM3VmRFpNejh5QTlI?=
 =?utf-8?B?ZzZPTXFUcGEyVzcvejlrRUdIUFNybjBPbVJ5UE00QitCTitKbTVybTRZWXVr?=
 =?utf-8?B?UXlGaWlteWtlMzNCc012OGFlZFdDRkF0b2pHYVpIdktQMHRWdHJqWXhCcXg0?=
 =?utf-8?B?ZHlhOHU2RjZSYU9GUExjQyszVGJXemxjNE5lTXRrSzVBZFE2Rno3YjdadEFw?=
 =?utf-8?B?eDBUZVJDYU5YTWhscDUzQyt6dUdJL2E1UjMydFd3K3MyTy9zbXg2SEdHUjR5?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6e0528-45b0-41d5-933e-08dc6bc8bc5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:28:27.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKm9DhSIeo7nGDRQDIKlsgexZo9udGbqZ8WpGxCUbRYbdeI/aPpmstJjAFBsqSln/Si6XuJWj0o43hSlQ9Lpqg3TK3BBjQRU2bJXSmY3Rg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign an RMID
> to the hardware counter and monitor the bandwidth for a longer duration.
> System can be in only one mode at a time (Legacy Monitor mode or ABMC
> mode). By default, ABMC mode is disabled.

"By default, ABMC mode is disabled." seems to contradict later work.

> 
> Provide an interface to display the monitor mode on the system.
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>     abmc

This example seems to contradict earlier statements in two ways:
(a) it only shows one mode vs. there are two modes (legacy or ABMC)
(b) there is no active mode vs. one mode is always active.

> 
> When the feature is enabled
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>     [abmc]
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: New patch to display ABMC capability.
> ---
>  Documentation/arch/x86/resctrl.rst     |  5 +++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 68df7751d1f5..cd973a013525 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,11 @@ with the following files:
>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>  	    0=0x30;1=0x30;3=0x15;4=0x15
>  
> +"mbm_assign":
> +	Available when assignable monitoring features are supported.
> +	Reports the list of assignable features supported and the enclosed brackets
> +	indicate the feature is enabled.

"indicate the feature is enabled" -> "indicate which feature is enabled" or
"indicates the currently enabled feature" or ...?

> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 735b449039c1..48d1957ea5a3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1058,8 +1058,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>  		}
>  
> -		if (resctrl_arch_has_abmc(r))
> +		if (resctrl_arch_has_abmc(r)) {
>  			r->mbm_assign_capable = ABMC_ASSIGN;
> +			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);

I think this will need some more thought when considering the fs/arch split.
The architecture can be expected to set r->mbm_assign_capable as above but
having the architecture meddle with the fs flags does not seem like the right
thing to do. I think that RFTYPE_MON_INFO may not be accessible to arch code
anyway.

> +		}
>  	}
>  
>  	l3_mon_evt_init(r);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index dda71fb6c10e..5ec807e8dd38 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -846,6 +846,17 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
> +				    struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	if (r->mbm_assign_capable)
> +		seq_puts(s, "abmc\n");
> +
> +	return 0;
> +}

Should it print "legacy" if not mbm_assign_capable? Or actually, I think
the expectation is that this file will only be accessible if 
r->mbm_assign_capable is true ... so having that if (r->mbm_assign_capable)
check is not clear to me ... if that is false then it would be a kernel
bug, no?

> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  /*
> @@ -1903,6 +1914,12 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= mbm_local_bytes_config_show,
>  		.write		= mbm_local_bytes_config_write,
>  	},
> +	{
> +		.name		= "mbm_assign",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_mbm_assign_show,
> +	},
>  	{
>  		.name		= "cpus",
>  		.mode		= 0644,

Reinette

