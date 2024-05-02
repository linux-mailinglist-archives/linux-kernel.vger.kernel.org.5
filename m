Return-Path: <linux-kernel+bounces-167029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DD8BA398
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EF7B22566
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC71CD26;
	Thu,  2 May 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ngt4p1Ds"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126131BF3B;
	Thu,  2 May 2024 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690829; cv=fail; b=crLk6erON7rbPO2d1TIoBIK/Y5LuNundji4ssvUFVmqhEOaMZYgqfsjtI2cf5pVEk0xWHn24c9ViCMMWmuPiGciICbTVg0+cRLXWYKCXC9befjqH/zW6EYtud55u7wDQfM3SB+0NVxjENnOkItpuH7wKn/N2mJmkEMIQfjejByY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690829; c=relaxed/simple;
	bh=rJMz56x8EY1Dc6ntRblpt65X/59vb3J/MJ4EvatJUCI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnVu/XoyYT15/gGluUASxsjtT9TyZDdGV/hiISfVUqU9akZ21feL7F13wwO49DTcawQoGktj0eawl1H3H6uzHGs9D2dhDnP4ozSdcIVChn6mKEuda6qGWtrKFQygLS8M3J8/CB+g2M39rZVEw5GuxNqLiCAxB6sQJkEuyCw/faw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ngt4p1Ds; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714690827; x=1746226827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJMz56x8EY1Dc6ntRblpt65X/59vb3J/MJ4EvatJUCI=;
  b=Ngt4p1DseF+Y4uWfRxcHCihXEliUF0z6F6zqLlRcBVianjJjLNQrC+Ao
   lkeQnkGiQjl9rMVzED50uVBdbaZ1LHcCW2cBQd3GMFc/Mzjo/6BISn9CO
   pPgvOt5vya1QUzeZ5/UE+sFvq4Pblqg6cMO9ybcVoElY49VzcJKhg9zW1
   ruWamonmMMMmqHGNvsxfngl8nuRuGbx4Ez7iDoWl6VVDdDfbx2/1rAH7/
   7z4B8sI2m1VrGyNmeVEw1s1Ve83ZOd02Ep8JIqxOLiMqnGuh2NpSKVfWF
   cZinpjP/OKkNjhdEt9OhNyreKnDlNTYvTAdw711R19mErAaMHKuYLenyl
   A==;
X-CSE-ConnectionGUID: 5ZZ/zmcRS/GJ0tV/AJB+jQ==
X-CSE-MsgGUID: wVlmHvANS4Ky9jarmRvWvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21898043"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21898043"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 16:00:26 -0700
X-CSE-ConnectionGUID: 1KLoelieT5iK6N/An6/Fkw==
X-CSE-MsgGUID: 28U4IfyXTU6lGsEvSQPzgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27246529"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 16:00:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 16:00:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 16:00:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 16:00:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCEMs814My3/jsc2a2tqRPv1FY2vlDqIwYoOjTdZqU4zU+f+igUXzSWAIxgCh1f8N96TrxuILQNhhZwJYWSB2h5e4h5C+JSU6cuz0VFa3UbpOBLJapO2fJlZjcozosbwR4V+BWU9xUswv3+vNEToA9+QPGZpJ5vpnHyix5Xo1NPHx5FhOdfhEQt3dP5pr1Wz+84tw5IDyE1oQSFeOwdGG/SmFRwUbQ92qWs6t8HBNnTZ+yhTPMxpKs/NwA4MyLnOgVoxGzNT/tO2z1zVoOUx7g/V9qZqIBObS1wIpVW7jssgCsfXqIZaJZhtbiH0DyfZprp9U6ebfK7cpB/QLhjoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72/Fe0xzwM7jUwDdapyohlfmeUZ6B38DSapawEGJ/vU=;
 b=ekamenA148h+/2XlVDm7FVEwwh/WPpBww18ZpvFMSCfAQIGjOxum4D0PbNXGybGt3MnKJ4ofx5ZZVaFEnt3l4Awhbjy/WccmlmpkY2p5ghopsfMoZFPYRbUsKWkab3DqbCNhBuJuWoxbt8LZUCgJkRcxTmrpCc6KrBwgqo6A0KW1mpUzZCj0j46BrCpOeCxByGHCOsjZpOakoDcajUdPbX/+dEx7DWJ+qo9CV7sczhS+Dzj0jv5bfXUrYLbbWUUY3lVHMWXZtnP/paYZTMeyGpwicIyxjNElA/8NoLHcXnGMKfngxvfGjPdouJEjc9XcEDqKyPWmppjle6yYZtLQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 23:00:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 23:00:21 +0000
Message-ID: <c8a23c54-237c-4ebb-9c88-39606b9ae1ab@intel.com>
Date: Thu, 2 May 2024 16:00:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
 <9d59d38b-af1a-46d8-81c4-b426d47d4ed6@amd.com>
 <CALPaoCgFEybS5MhsPx4EaJmsfBe8Es_6QwWBXpoctdaNf0NcMQ@mail.gmail.com>
 <80c56417-3d74-7d68-1228-9cd944567b4e@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <80c56417-3d74-7d68-1228-9cd944567b4e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: deaa6f48-0e7a-400b-7fa7-08dc6afba479
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVFWRmkwSlBIRmFhVUswMm9ZSHNkbWVQSEdGRk1rRG41MjhTQ0Rpd1Q1MXlj?=
 =?utf-8?B?eTRKSEc4dUVVMm1XdnRKL1BaYTNuVzlvVVNKWXRuL01TZ3lKeDlWU0ZmSDFT?=
 =?utf-8?B?OC9NWjNCSWdkWnlJTE9nbmNhSjZzY1M0NWlVdmtWNCt5clFqRU5MekJrUzJw?=
 =?utf-8?B?Mnh2Rk9xM0hQYlMvRnp5Z1dlcUlsa2tmU3pQaEJzSWpWTk5PVThVMzZlclgr?=
 =?utf-8?B?V2IwNnJ4N2t2NFQvbUsxYVBWc0FRUEUrSTJXb2wvKzAzYnFRRjlobXN2Wko1?=
 =?utf-8?B?R3haVlQ0RTY1aWZ4SmlKbG1KK09QRHh6WFhLMXM4UWt4QXNtSCtCalZLalR2?=
 =?utf-8?B?WW93enJuOExMTjBNQURpVXVZckU5T2pydUdEeTdlU0lKaHBtQnBzRHRmU29S?=
 =?utf-8?B?Z0Erd2ZFQVpMRG1UbmREZitqVld5cUpSTHRDb2x0SUNsN0FaVUZEMFo1WWxE?=
 =?utf-8?B?NExHeU15MTJkRHZRc3A2N21NYm5ueGxodDJJZVpKVHNZajJ0RXE4cHFNbDFL?=
 =?utf-8?B?dlo5UHdWN2NabThhSGwwTDNhckwzeXpWVVdrZHFqYUF4dVZCMk0rcEdwUGJX?=
 =?utf-8?B?YU1iMnFkbFdzbkdVTmJWdEFHNmVDN0hyQjRJZ2RQRCsvckxRdHV0R1E2eUtT?=
 =?utf-8?B?QUJCa1NNYk1NdE4zZ3QxM2dJZStqdFNsRHByOVlQcU04aXNHTzBpL2xMaE9F?=
 =?utf-8?B?dmZ0SS8wdkI0K05FSDA4b0o4K0s4YXIwSFhyL2M5RC90aDQxeTJRYTRkc2lL?=
 =?utf-8?B?T0VwUnFMN2pxRzR4R1I4L2hhWmY4T2NTQUQrMnUzZi9xYmRITTEwQzJsTTlN?=
 =?utf-8?B?TDZOU3l6VjZTMFpMVHRScERkMkEyNjFrT2N3ckthUWtZUkE1VmEzYmpOVG9J?=
 =?utf-8?B?Q3hKVUx3OEsyN1IzaUtZV3NmaHhHa1gyYjNoVk9IQ0FJcUtEZEZyakRDc3Fx?=
 =?utf-8?B?N3BaNlMvMEV4aml5M2ozUkxPbmhiK1NtSE14YndjajlTa2ltMXlHd1RRYUdN?=
 =?utf-8?B?NjBVOW9pRzBUWmdybS9uNG5HRnhxYXV6TktaUEttV3hKc01ITisvVWhkaUJT?=
 =?utf-8?B?T2tKYW5Fai82WXpwWENLSDdrS2RmNmFRakVzcHdiSmc4WEs4NHVUV1pPdjQy?=
 =?utf-8?B?Rzk2SnZLbUJSaUpkdmFqTXNBZ2xyYk04WEFVb0xwSUcrL0R0TWtOVVQySGVy?=
 =?utf-8?B?NDBnUGZodVJUQ2oycUpnbUNRVjVaSjNRaXdidFJ1V2NTYU9FUDFLWURrSHRn?=
 =?utf-8?B?RHc3eUZ2RENxckJ6NWVMOWxzR0o2YnM0QVlxem10eVEraGloTitJYm9yd0o5?=
 =?utf-8?B?TXppVDlydDZ0OXFNNHhxMThnQi9zQ3hVeFdpY0Z3Mm00RDlESTZoT3g4ZGRX?=
 =?utf-8?B?TkoycDEzaGxHb0c4aDdaSmtUdnlRRjBFcVNVTFo5d2hwV005TlhLaWdCaEVv?=
 =?utf-8?B?TTdBNEpQbFlOYzU3M2hJU1NQbFJLWGx5V1k5M1hpWjRkVGY1bm1BUTBSTVBo?=
 =?utf-8?B?UEZ6S3V2dkphdjJFSDJYY3hRSmlYWDBjaU1NWUc2UDFLenh3bHVhdlJPa0lG?=
 =?utf-8?B?ejlQOEgvb3EveU9ubm5qUktSNmE0dmlUeGVmelE2NjBHSzF4b2d6SW5vL3VL?=
 =?utf-8?B?WFRkL2Z2N0M5RlQ3Mlg2UlBKaUM1V3RYNWNKQUlBR0tCMkxNV2J1dDF5NjI2?=
 =?utf-8?B?K0tSbFhKU3dCRmZWaWphOVliVlhWdlZnY3greThKOVc3U1hJTEt0NTZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmdQQnora2FDU0c5Q01ZTXpHeXozaEdXM2xoTnVjcmdUUGx6WkJlZnM4TmZq?=
 =?utf-8?B?RWdjenBkblJtWXZwSXRrazYrNzc1RzZwYk1PMzVteWJTd3ZVKzVSekVSYXQz?=
 =?utf-8?B?c2Z2TlplMlU5NTBFYjVrZkpmOFJJMG9rd2hHczI2VE81Vjd6R0t5TmV5eURl?=
 =?utf-8?B?eDVHVWZVS2x0RGRqZTZVVEFISlhaT0N0NSt0YW1QdTBHazdGNktQekZaakZ3?=
 =?utf-8?B?SXZ6KzlCa1d3a2Fqc0Q2V1VvUzRuUkxINDdMRU53eXdKNkxrVzl4TExyNjA2?=
 =?utf-8?B?M05CNjA2anBOVUVpQzhuaXB2S0VlanhFZnZnV1FZcmZOY3IvTURNREZTQlZV?=
 =?utf-8?B?RW1mRDRJcG5RSW5zVjMxcUZoVlJWclBmcGRrQUk2dWF0M25GRmtwTlBDOHBo?=
 =?utf-8?B?YjJiUU9HQVJtenhQVDFwMkNVa1c3bkFsNzgxNXdtbks4WjhScU11SEZEbGJq?=
 =?utf-8?B?T2ZtMjRqakZjcmhDQjlWdndRWE9veUgxTC9jY0pDblc4L2xncC9BTGt3dTE2?=
 =?utf-8?B?YVF4S1AzcHBtZld1WW8xTzV4VC9QanYvOHZZcU5QR1dhNHV3ZjIycWcyQ0Rl?=
 =?utf-8?B?WmF3aXU1eG9UWlRycmFnTmYrb0Mwdk5TTUFPUEJQT0xtaVBwbFI1Q2ttUWJC?=
 =?utf-8?B?bmswSjVGWldta1o3UVUyMjZpOFVhdnZJQTBVYzNqd3loTk9ZV09qaE5kOFo5?=
 =?utf-8?B?VVVyTE5ocHhqSXpneStsQXdHNFJxK3FCc2dGQ1k5UHRhb1U0cDI3UlVKOW1F?=
 =?utf-8?B?MlFoU0lnWWVZaEVOU2o4OWtGOVozR3VyOGRQYTFpS1dteFdHSlRCNWgvR0lz?=
 =?utf-8?B?ZkM5MWtteUdGTS9xRWcxcjFWc0dlTXF5Q3pJZXp5NGRpUzAycEtNUXVoNmJO?=
 =?utf-8?B?TG5SWnpGWFJOVTNaTm5vWjJWUS9UbVc3ZmtsdzQ3ZGZEcVEvWUIzRE1qNE5C?=
 =?utf-8?B?VmpyRWs0SjVYR05lMm1QbGlLR3BteENQQ1F1U0YvVDBSUHVENDNUSVNUU1kw?=
 =?utf-8?B?cGROeVRvRiswQmpGOUhpRjhMK2ZFMjV5YkpMSG1hQ0dTZTBIUFIvT0MxZm1Z?=
 =?utf-8?B?SVlaVjBxTVNOTVhOaldQV2c4bmZDbVUxMmFkS05JWTJNNUZTWEVMMUhBeVB5?=
 =?utf-8?B?T2hBMFc4cC9TVXpjNDBDeHZONnJpSXlFYTFPUkVDZWRQaS9EWm52d1hYUXc0?=
 =?utf-8?B?eksyazgwOHM3SmZtNkxmai9zd3ZEcm9kWjhSOXFLNWl2bnBRTSt5OWg2SXRM?=
 =?utf-8?B?NUhER2VDczNSamw4YjVRSlRSZ3dKaTdxUGZ4dGlwTW5pSVEzS3J2V3RQS3Ez?=
 =?utf-8?B?ZnM0M2kzOExuU0pJUmF1NVRqd0pYcEhjdktETzU4OXMyeXduMmxUdkltVHdP?=
 =?utf-8?B?bkJPbnE3ck95czd5RjBYUVdadndQUGcxc3R5ajlud3dRTEQ0a3ZISDB0STlq?=
 =?utf-8?B?N3ozYk1nVk5qTlplcjBWOEExSGZ3Szg1eFhpU1VFRkhCNUFjNmdpeVc2Z21N?=
 =?utf-8?B?UVkwWnZVYjgyTWlhVWs2QVFFWGk1NUlZVW00RGxtOG9BdlRYcS90UURTNDRW?=
 =?utf-8?B?NEF6Q1owVks2T3FPcE05MWhCbVFieXczTTViRnRqRTR4L2VDZ3l1OHZDNFV3?=
 =?utf-8?B?bEtYTTNsVmZWQ2l4M1RuZUNrYkNnMXl1UnkxWlNtY0V3VFA1U21Qd2ZJYWRB?=
 =?utf-8?B?aXN4ZkZoK2hVd1g2QWtxbzlyMHVueG9ib3NObmVRTVFjZ3poSXFpTlJMc0hx?=
 =?utf-8?B?M0Q4VXFqRTRDS1pCM0IvNmdQcXREY1VYaVJCOVhPYTdlYzc5OHBWem94NW9i?=
 =?utf-8?B?VFVPQXdJUWFiQ2V0VE8xSkE0N2tNdytkUnREYVdpSjJXYWJyY0kyRWRmSDZ5?=
 =?utf-8?B?ZUppSTNycVg2SGYwUUpRdktSeitsYTdRcXlHazBBTUpnNXFrbUpPbXJLeHJL?=
 =?utf-8?B?NW5ZVDBrQjUwMDhzbFl5b3gxZnowaWNETFBkRFB3SHVKb1FiMWxlaGdsVXhj?=
 =?utf-8?B?Q2Vlc3k1VUIwcllOc1liVG1lQ0ltQndwaldGcEdzSE1oRXlkbDE5WENQUnBz?=
 =?utf-8?B?aEtpamRybEEyb0M0dFUvZC9LNjkyUXNFb3pHYXFKQjhwL0hJZ0dqZmVvMGFk?=
 =?utf-8?B?bWxZMCtpNGxra0g0TjB6Y0hTajZ5RnlBdkpQMzczVGRRNVhPeEcxS0JlZ2NX?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deaa6f48-0e7a-400b-7fa7-08dc6afba479
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:00:21.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGctgyM7+BVlkFvEo/M6hCOnhK4gXvpFUzH4deq9aEsGA3C1Tv0F/9ty5TD17gD5Qc9nsK6LZ9x3xtekZalINUNjhlYPBHgplPui79xV80I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com

Hi Babu,

On 4/17/2024 3:52 PM, Moger, Babu wrote:
> Hi Peter,
> 
> On 4/17/2024 3:56 PM, Peter Newman wrote:
>> Hi Babu,
>>
>> On Wed, Apr 17, 2024 at 12:39 PM Moger, Babu <babu.moger@amd.com> wrote:
>>> On 4/17/24 12:45, Peter Newman wrote:
>>>> On Thu, Mar 28, 2024 at 6:10 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>> index 2d96565501ab..64ec70637c66 100644
>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>> @@ -328,6 +328,77 @@ with the following files:
>>>>>           None of events are assigned on this mon group. This is a child
>>>>>           monitor group of the non default control mon group.
>>>>>
>>>>> +       Assignment state can be updated by writing to this interface.
>>>>> +
>>>>> +       NOTE: Assignment on one domain applied on all the domains. User can
>>>>> +       pass one valid domain and assignment will be updated on all the
>>>>> +       available domains.
>>>> How would different assignments to different domains work? If the
>>>> allocations are global, then the allocated monitor ID is available to
>>>> all domains whether they use it or not.
>>> That is correct.
>>> [A] Hardware counters(max 2 per group) are allocated at the group level.
>>> So, those counters are available to all the domains on that group. I will
>>> maintain a bitmap at the domain level. The bitmap will be set on the
>>> domains where assignment is applied and IPIs are sent. IPIs will not be
>>> sent to other domains.
>> Unless the monitor allocation is scoped at the domain level, I don't
>> see much point in implementing the per-domain parsing today, as the
>> only benefit is avoiding IPIs to domains whose counters you don't plan
>> to read.
> 
> In that case lets remove the domain specific assignments. We can avoid some code complexity.
> 

As I understand counters are scoped at the domain level and it is
an implementation choice to make the allocation global. (Similar to
the decision to make CLOSIDs global.)

Could you please elaborate how you plan to remove domain specific
assignments? I do think it needs to remain as part of the user interface
so I wonder if this may look like only "*=<flags>" is supported on
these systems and attempting to assign an individual domain may fail
with "not supported".

Reinette


