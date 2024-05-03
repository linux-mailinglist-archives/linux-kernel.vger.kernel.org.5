Return-Path: <linux-kernel+bounces-168414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BB8BB84D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CED1F22C11
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F62F84A57;
	Fri,  3 May 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfBPjIia"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588884A40;
	Fri,  3 May 2024 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779133; cv=fail; b=B8MxNHOU0nfCUej3mKCaY7/YS/El3Wu3L0/878oNsrQ4v3hZSg34b2jPH0ZiN8l+ZH2yypIJxjApOgN4Vfhe1sTKfYIzv5IxfqblJEbbG671M774lDyWwuRSF5W33qhEYnLTL8zwS1cvLpFIdGCY9AlZanfjluQsoOft0Dt5rMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779133; c=relaxed/simple;
	bh=uHaBDdr1VZxSl/kAT9C8mejPtQN10YOEkdh1deTe52k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bekuj675fmpGPukJOY0bbUXcXSYRVGhBc9aWN+oOmEDea3wcP4dyYgsa7WX5YPKuEV0xgbEtcYvC+frDgbc9K3jDmihiD6+wzvcqOU4c//RajXAq453LYkkvCT7V9r7fo7L7zctccMjTMs/WHl1afKtLG1EQ/wRF9IZh+Pli8As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfBPjIia; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714779132; x=1746315132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uHaBDdr1VZxSl/kAT9C8mejPtQN10YOEkdh1deTe52k=;
  b=GfBPjIiaKv+zuyrHY7lNMaAkTA1UouDMdrnGH8bV8AcXZodmll93akQg
   av94pfmVTUJ5nBQpL2TeAPs2LnYMqrJG/Di59ppBXo9kUIwZs0rlrVkk6
   Q4o2B9aUpaEKmgxAuqNG+T+9iHRnR8ptb+grQciyKfM0wvXyxunPYNyLO
   2zg43ueI8ReSmYLPbAfpkwrOHcRmYiAGrwwqTADdRPbogLHYTFDbkVYSb
   cQiKi0qzlTy7lr4bYuhNmHA1G2GgRLDpqXxkVJkB/TVEbxFHuxoPn8M03
   vzZwlyR7jxqBApPL796aRqhetLXq23wtnRXdyq/a14dS7MPL/thTVFFtM
   g==;
X-CSE-ConnectionGUID: 8h5g3vJ/TvS6Ve0oE7rZhw==
X-CSE-MsgGUID: oHeqTLWlTjq3l/oabFfHTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10529498"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10529498"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:32:11 -0700
X-CSE-ConnectionGUID: fMCjQ9EcRvWbarAFzsjhsg==
X-CSE-MsgGUID: GfrlzSinTyaPe7T70h+2Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="32271729"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:32:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:32:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:32:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEPAt1zNQ8v6BMnYL+8qSPrt9ZuKL6LWkghhI2c7xLGwTsb2PTUDsfJ0zkPXmI4wG87/mhmI1iW0qiBAtngMBdBuE0OkZ96c92tyANH5SAmJtjw5ay4t41KtGub55ofwx8CK6WtPDgA7VtFEDv5LC3FNdDb07KDuMqlNPeUJ16PtE4BO7K53qKk0OSN4dD3sTfIW6vOm2adOGxdHCqD57/BLXz2lfyFjHrotrI3MFSkSK3VM/tCget66NcVtSG6ra3siC820l8IoVBM7M5pHSAmEDj/Z4J2ErW8eVA4fL5jWfHO4e1usVwnTN0VAi1pGs+Y3ZmK8iQX+2XZhlrNOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy271eixorS3EN5oR/u238pkWslZjHRtpz+amulNgOs=;
 b=N4YCAd8ZVQSD1Nh150cD+MalIf+MdaV0yX2phtjRzQ6LzdTwr+nieoI7YUGAW7QFzOPtm1Wm3YBBwzj5x3Jn2s91s6oPmbKeyOlYZD6+AUGmP7FkOUHup9ntv8LXOP0/JeeeC61h36nJLzLEiKIOvjT8Vr9H5Hpm2UKUIrsp5cdgUTNcO5UttNBCAWAtj8USIyOp0QSiGF2mImyfubUeJvpU8KYSwWWovc4u53rwRq+6ir56fWARcetecU3tbOJWTz1zPlKSpPlP6CxQDAdpCcoxsiasgWrsEUoRaODLp7U9q1p1Tm24piI9/nMn6DXKnE9gKh1cXAqgMMt7byYbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:32:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:32:07 +0000
Message-ID: <3149b62a-b9a4-49c6-a757-5a0e36df62df@intel.com>
Date: Fri, 3 May 2024 16:32:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/17] x86/resctrl: Add data structures for ABMC
 assignment
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
 <c3103dd30bc07070380a01922f66208759afe837.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c3103dd30bc07070380a01922f66208759afe837.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fb6b2d-a6d0-41b5-f332-08dc6bc93f4c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0FmbXVvM3hCd0xkRUM0MlRJV2lrTWRObExYa3FBTGlVNW1TbTFIdTMybUln?=
 =?utf-8?B?L0V4QXVQV3BVaWpmQm9ER3AvOUNpYnNkQk5hV2R5amk0OHJ4S2xnSFk1eWcx?=
 =?utf-8?B?ZG9tcGZFN2tzclFqRFJ5bmxLQTUzVlVrbmFkTEFiVk8rYU91TmV1QXJWUjF1?=
 =?utf-8?B?ZEFxMmwybElaUUFpd2UwSTR2WHlOSXRsclhia25tRlZQa0hyWEY2bEtqNXRG?=
 =?utf-8?B?YS9Td2kyTVVGZGhmWHRUTUlXUEdPazQ5NjNrYjB1UmNoTkZTRXJSbDI3YnZB?=
 =?utf-8?B?cUdHSTk0cHRGSEZDejl0QmlvbWR3WVRMOFYzRnllSFlRczJUczNvTk16YmJT?=
 =?utf-8?B?ejFWdUNLVkRXd245MXl3MHFUb0dFTzU5R1R6dEtnYWFkODNqRm1qU2g3NUlp?=
 =?utf-8?B?ZjBJbXo5ZkpkaWhCSVYwZllGZXlnZU9QK1lvdFg2WjcxbzFJYndpcnMzcVJp?=
 =?utf-8?B?cU1Pc205a1hjL3VYZ3pROFFCTTYvNDBXVDRkUjB3VlozTEd3MXVoMWZDZlNj?=
 =?utf-8?B?a3dYSEJjdkRYZmYyK2g5V2hpVFBJZjVkTFdhVm1jYVFOWnlPVVJaOEpxMndw?=
 =?utf-8?B?VFppVG4vdUo3QUdXcHlHWjRMcTZ5ejRtdEFVc0JFSU5lMXI0ZjFmMkRYaktS?=
 =?utf-8?B?ejdxRFRVL2EranFIZGdpZ0IwTlpHRytjZWduSnE5bEJlRzBNYUFodXl6QXli?=
 =?utf-8?B?TlNwYStWSXlhdkhOMDdpVVQ5VXo2WVlmaGhGaStqSWVxVDZ2WkIwL1RLTHZP?=
 =?utf-8?B?dVVPczlJb1NYZENBeFpjZ2oyR2R6R1hacmNJN0ZUdDBENGJqL01BZ2lJeC9D?=
 =?utf-8?B?WVR1OW9JbGo3c3B4TTE1WXlWdTlQVDB3UzN1a1ArUytRNFNuOVJ4UmhlK0Qw?=
 =?utf-8?B?YWxSNzF6RFJydmFERXhKandjVzU2TmNwK3lsR3JVWVdRb1M1RlgvUDhFeGZX?=
 =?utf-8?B?dHFsSHhkSzVsV1YzV2RnbnhRL1VhSGJYYm9LV3pTRWJTSklHSkNNeUJ6Q1Rx?=
 =?utf-8?B?dGRYTlh5M0JjaVdIaGVxSjRLUjdhTWhxMy90YVByMkgyUW01ZXdNZk45MVR6?=
 =?utf-8?B?VDNrVHBZd2hYZE5mR0M0QVgvYVhPNjFETHRadlROcjY1cE9TS0lFN2dNaits?=
 =?utf-8?B?bFpoeXRHUHZTYkJqY01EMDBHa3VOUGRkOHE0V2Q3RnV0VStKa09kODBkcEIy?=
 =?utf-8?B?M2pNY3IrUWVDMWlPUnpPaWM5WFY2c1hRM2dhZElhNGhjQWsyYzFGRGJtaWFw?=
 =?utf-8?B?OE5RMzZ5YWVISlU1VlQ1dlNKdFEzL0dTQTRCWkp3ZzZ0QVJTaW5jTkxOYkkw?=
 =?utf-8?B?ZGtONTBneWNMaFlNOTE4dS9vcEVlY1c0eDdKc205aW1vUzBZNmk3ek1TTVZT?=
 =?utf-8?B?QS9CbUlhSEZ6aHZRNnBjbGRYejl3blRsZVdFSU5YTjJmL2I0SFQ3MktlQ0ZK?=
 =?utf-8?B?SGtCakRqVW4vL0xlRGcreWdjM2h2UGc1OEVaZGliUEdqcFlTTVNtRUtEdXRK?=
 =?utf-8?B?OW94NXNRM28wY3ZvY3VXNzRPOStpaCtCVXVFbFVWYzNCbjhHS3lvVk1CMWla?=
 =?utf-8?B?elBPc0dGWmlpaDhwNjJ4dk9mOEMxbDE0Lzg3WnhmZGkyaURVZ3lGRHBIL2dP?=
 =?utf-8?Q?jnSFcQExnYyM4bS5+Yp0Mff1srXfKLSUvkZSLa3QiHAY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnUwUVdIeGt0WkNvK1FvaE1EVkwrYWVHdUdYT3FTNDlaRHkrZENqaiszenQ3?=
 =?utf-8?B?dUN0V2JyY1RYSjZ5VlZWOHNFcWljNUE5TGlja0JXV3FiYVc4aTVuSm02b0Vi?=
 =?utf-8?B?cUptNzJyU0hVNzdXeFdya3Y3WkVqQkJpYXRQU2NGd2w4Yk9pVWx3YjB1WVBP?=
 =?utf-8?B?MUlhaEFQaWYwQnBqenZGOUoybXN1YzNkN2JqQ2g3OUxUVk5rMERnZ002SzRq?=
 =?utf-8?B?dVNYdDdoSzUwVzQ3Y0czWHZtbWk0TUROK3YzQllhY2NMMGhpcDFJdHlLSXFQ?=
 =?utf-8?B?UjAvNzEzVUVjbWhXUEUwTWxmQlBncUkrS1M2V3lWd0ZJRFh5R0tYUzdXY3lY?=
 =?utf-8?B?cTJyTW90ekNBNU5qQ1BVeGRrc1picGF1NUo0ekxPcU1TcDMxamJ1YituTWdt?=
 =?utf-8?B?aUFOOXhBdzZlYjdqT29FNlZkRmNXYTJQUllBc0hXRlhjTVF6b2REczZWbXpP?=
 =?utf-8?B?a3A0OTBrelVMTE5sMVV2VnZCNk5sL0grbnJaRncwSStURnk4Lzd6bGxvSVlD?=
 =?utf-8?B?VWJ0VVY4aGZVL2VVWFcrVC93K3M0UXJDVWpNdFF0eDhjOFllR1U2YkhZcHR4?=
 =?utf-8?B?Q1lXalo3cGhiYitNeXNlRTRSK1N3ZWF3K1JyeWJDb2JyenNqcDE2blNzeDhh?=
 =?utf-8?B?NTFZWTFaWlY1ajUxcDdJODVMT1dKVVkrT2pHdXkzdHlKYnZtTUV2U0ZYZkpp?=
 =?utf-8?B?c2djbDZ0RWlUV3c3NFJSRiszTTFsQ0NkL3BGdUxYelFhZDhsOTRnS3oxeEVO?=
 =?utf-8?B?cmFSdUZHRHl5MVU5Q3V3QXU5MEJ3OGFSdUNET2dRV21odTA1WEwwckdDcHk0?=
 =?utf-8?B?cDNoM3dMUDd3TW9qa2FtZm13WUo5MlZNVU4wZ3ZPVk9LL1Rib0gxSmlHOStU?=
 =?utf-8?B?NG04czM1YnlXWjgyU0s2UmVuNnJhSjNUQTVrOUljSjQ0dHJRRnhuNGJjdHNr?=
 =?utf-8?B?ZDRqSEFXQlJrTHl0WG15U2M1VEFTOEVMQjBjTDM1aE5aZXhGZXpBaXVLVFJ3?=
 =?utf-8?B?Nnh6MHR6bU51SGtCR0RGMG1obHFvM1doU1JYTnVJbUx0NEZzWUNBdFhvR3lK?=
 =?utf-8?B?L0lyQUJJNVJLVFhJT1BjRFYvMWEwU3J3NWY3UzhYckk4bmJLUVNYVFlaSzg1?=
 =?utf-8?B?MzRVdXJYdWJJSW1JUUdCK1ZnYWlTZzVxR3ZKaHMzeU9NSDNOelNjNE4rRU9O?=
 =?utf-8?B?MXJLaDFLMHBNMXlIRWVLT2l2YXMzL1VmeVZ4U0JGSXg3Ulg0MDN3bXp0OVZt?=
 =?utf-8?B?UXU2TjlXMjcwa0JQTHhVb3RyYUZoN1ppektVdEp5MzI1cEptY0tHMWVnT3F0?=
 =?utf-8?B?SGQxRXRRa0NzUWt4ajRkN1dWRW1VNVpHTm1oMEJPOGJpK2hnMlZ3SzdseUJj?=
 =?utf-8?B?OXFRYUFQMzVMOXNMR1BoMTkySXVGVXV4bU9ickZUTFhZcFhmUW45anhlSHdW?=
 =?utf-8?B?U1NtTEZDY2NrcURnUnMvbm5FSDEzNXlOVWt0bU5MZ0VUaFF2UTBmREVsY05K?=
 =?utf-8?B?ZVpFeXJrY0FtMGgzMGRPNnM5RTY2Z05UdWVONEMrQ24yTkZMeEhtZVZ0SXpO?=
 =?utf-8?B?bzQxajRFR1h6bDlrZWpjT3lyWTZuNWFvenhnVWdBdDBoY0dEdXlyZ3R5Tnhw?=
 =?utf-8?B?eHNHYmlPSTByOUsrZkw5TFB0eHdscUpwd1JDVGZwbjVKcTdJemhpdVpEcTRt?=
 =?utf-8?B?SkJiMW9rWFVkbE4zN0FRWFRaaE5qZit4OXJCTmREeEo3b3pqTkpPV3NRZkla?=
 =?utf-8?B?T3JNd2dwOEhJZDA2dzl3L29RNk44OE03UDFrOFZaTi80TmgrdTg2c2lKRlB0?=
 =?utf-8?B?eDUxcytZMUZIYVlzbitVSjA5NUhBMEJ5Qnc1OHhFYWJXV1hkQkxZV293UnZ1?=
 =?utf-8?B?aSs2RFlFZnV2M0c2SXBTOHlrVUVGQ295Rjkvb2ZEaWlpb3pNUjRqSmExVUlQ?=
 =?utf-8?B?OHc4YWRXVTF4VityZHNRZ3dUaHQ5UVRRVWtsa2x6VnlhR3I4Zm5UbzdLb21a?=
 =?utf-8?B?MllRVDBqS0ZUb2dScVJuUko4eEswbWM5emJFN0Jra1RMSTZsaURtczA4Zlli?=
 =?utf-8?B?eHdKQlB1aW9lekplYmFETGFSblpTZ2NjdVFUczFRRFJwUWFmSWo0T0FNNGRh?=
 =?utf-8?B?QVI3Rll5eCtpYjR5NDgwblFFR2xWbFU3RG9pVWhlNm84QWZWUXFYQXFLcndp?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fb6b2d-a6d0-41b5-f332-08dc6bc93f4c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:32:07.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjE+aaEXOY3ReJ+SBfHA9Z1++cwqWMQ+lr5oMW16C4222vxq1vyk22/0FgK/AwzKZLq2MHN5fzZsVSBGn7Zeu2TpPq35u+uKbYydYPDDH+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> ABMC (Bandwidth Monitoring Event Configuration) counters can be configured
> by writing to L3_QOS_ABMC_CFG MSR. When ABMC is enabled, the user can
> configure a counter by writing to L3_QOS_ABMC_CFG setting the CfgEn field
> while specifying the Bandwidth Source, Bandwidth Types, and Counter
> Identifier. Add the MSR definition and individual field definitions.
> 
> MSR L3_QOS_ABMC_CFG (C000_03FDh) definitions.
> 
> ==========================================================================
> Bits 	Mnemonic	Description		Access Type   Reset Value
> ==========================================================================
> 63 	CfgEn 		Configuration Enable 	R/W 		0
> 
> 62 	CtrEn 		Counter Enable 		R/W 		0
> 
> 61:53 	– 		Reserved 		MBZ 		0
> 
> 52:48 	CtrID 		Counter Identifier	R/W		0
> 
> 47 	IsCOS		BwSrc field is a COS	R/W		0
> 			(not an RMID)
> 
> 46:44 	–		Reserved		MBZ		0
> 
> 43:32	BwSrc		Bandwidth Source	R/W		0
> 			(RMID or COS)
> 
> 31:0	BwType		Bandwidth types to	R/W		0
> 			track for this counter
> ==========================================================================
> 
> The feature details are documentd in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).

This changelog is purely a summary of the hardware architecture. I have not come
across a clear explanation on how this architecture is intended to be supported
by resctrl. When would resctrl need/want to set particular fields? What is
the mapping to resctrl?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> ---
> v3: No changes.
> v2: No changes.
> ---
>  arch/x86/include/asm/msr-index.h       |  1 +
>  arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index f16ee50b1a23..ab01abfab089 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1166,6 +1166,7 @@
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>  #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
> +#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
>  
>  /* MSR_IA32_VMX_MISC bits */
>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index b559b3a4555e..41b06d46ea74 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -106,6 +106,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  #define ASSIGN_TOTAL			BIT(0)
>  #define ASSIGN_LOCAL			BIT(1)
>  
> +/* Maximum assignable counters per resctrl group */
> +#define MAX_ASSIGN_CNTRS		2
> +
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> @@ -210,6 +213,7 @@ enum rdtgrp_mode {
>   * @crdtgrp_list:		child rdtgroup node list
>   * @rmid:			rmid for this rdtgroup
>   * @mon_state:			Assignment state of the group
> + * @abmc_ctr_id:		ABMC counterids assigned to this group
>   */
>  struct mongroup {
>  	struct kernfs_node	*mon_data_kn;
> @@ -217,6 +221,7 @@ struct mongroup {
>  	struct list_head	crdtgrp_list;
>  	u32			rmid;
>  	u32			mon_state;
> +	u32			abmc_ctr_id[MAX_ASSIGN_CNTRS];
>  };
>  
>  /**
> @@ -566,6 +571,24 @@ union cpuid_0x10_x_edx {
>  	unsigned int full;
>  };
>  
> +/*
> + * L3_QOS_ABMC_CFG MSR details. ABMC counters can be configured
> + * by writing to L3_QOS_ABMC_CFG.

There are many fields in this structure ... how is resctrl expected
to set these fields in order to configure a counter? Please expand the
comments.

> + */
> +union l3_qos_abmc_cfg {
> +	struct {
> +		unsigned long  bw_type	:32,
> +			       bw_src	:12,
> +			       rsvrd1	: 3,

Considering how "reserved" is spelled it is
unexpected to see "rsvrd"


> +			       is_cos	: 1,
> +			       ctr_id	: 5,
> +			       rsvrd	: 9,
> +			       ctr_en	: 1,
> +			       cfg_en	: 1;
> +	} split;
> +	unsigned long full;
> +};
> +
>  void rdt_last_cmd_clear(void);
>  void rdt_last_cmd_puts(const char *s);
>  __printf(1, 2)


Reinette

