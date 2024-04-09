Return-Path: <linux-kernel+bounces-136188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2389D0F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03751C2435F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35A54BFD;
	Tue,  9 Apr 2024 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T075cat9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C254BCB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632687; cv=fail; b=G6xtxLXFY0L7Gu5dNJRMRCD5qJDKqvCZ4/qtdGkqUXo+wWfbc9gLjFz0TfzBDoxAs/ZsioCabUIcdoJs7+X8w93ovIYkld8yCIoA61mcIwpXAXNjSKn0TLUptIvO46lNJ8CuHM9jCkFAE6ARhFLnd3jHUW+enxJfgCnQ/4otaZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632687; c=relaxed/simple;
	bh=/66vM5gmiJhBvyWyjIdaJeQJS8TbSeef5cKxApZTTf8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKowYR4yXUgEokvUHvGcTUQ+QmXNUxwuwudhkirdDJk71TOHh/p9WUskE26tsRY6DDt3aRaP+B4kZCopdlFJNnTURG360ogwKt2Khb8n6keV3ijWLJFM2w3UV4qg8o82A0AM34H/xeXZzvGAMSOp7TO5dZITqzm6AQTcorOYXq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T075cat9; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632686; x=1744168686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/66vM5gmiJhBvyWyjIdaJeQJS8TbSeef5cKxApZTTf8=;
  b=T075cat92xSpkx1JlP4VNjKENmSHE9YEHcS9u2SzKzS9c8gPus51JiyV
   S2gY9LetmUvcMRl2sHhS0q/ZdDclJiJlgsjlii0RW83jbjoX6VMBpDbG2
   mwOE7IExolx/fiMEwA1g37xguMTHOMsLcEsyOOezx+TdkSYSvMKbs1il4
   D9G97Fz0GDREnmkKzlFjR32j8UR4GrGIvUzkweSGueLpZHk6nS93LJ2y1
   saWKb5adgr1fOAsagkigQetErX43sZqna90NzZHs4emBNhQ/Ge9lYObO1
   ITLHiOHaMWXDztkp8t2YBJiXpA0w+FkimS7qVmqDiCl4wCZ3Oxp/Fyj3S
   w==;
X-CSE-ConnectionGUID: qpaEZobJTdaBz4LDEcpraw==
X-CSE-MsgGUID: 87iBeUFaTrmhxAy+/kvPhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7799293"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7799293"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:18:05 -0700
X-CSE-ConnectionGUID: yzOAt+73Q4mllFfSeM6LCg==
X-CSE-MsgGUID: uzAkDDXcR5Wc6u0pP45wng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20208798"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:18:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:18:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:18:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:18:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaNyvlNz0ec0GLDgs2qduASr6goAlbyP9R2WDWOkLgaGSL8W96e3BxQmrbaI5fGBgb+nODoV8OuCD/eTOqYml0K7Oi5gNKiPt0ed894aCcoEHx5erCzvgyPdDh6Zy+XEgcOLSClgbWMGNcti9FfSmcYOOmQbnzUwH8UPc8OXqAqhASVq3oCYSwggp692nVRPZpRkCmdpQzwJ7hARic/Bm4JmDN4NrA6axp1EoaPV4G8+cD67JS7Fw3flx78nYmJDyCM8AGCKi4ySTuk01h4xqSturPMzZEnRQvgbT3y54VZf7lfk5W0TfNPZYsL7wvyZnbrR2Bv+B+DvGkPG24+XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1j1Co02TCG4sGit/V2NFiCQoIPqhy/zc7HemrwJ+hU=;
 b=KG4Bu1OP0NuiV1iTt7U15H08RZASzPQ0rMap4kkKMFcKrjLnve5ckmR6q5WMlrQ3r4NEd/iWbvvG4npaa34Oc0JxKcd5EFpb+XZe7ufJDhwwi7L2998c2ihRwzWedKAWp4KYHkxXgqRxuuw6v53ApcO+58kET2AW7u1SsjnKcbBkDB8Nm5kIzHVoAvCIu+jBodazK2ozFxQE+BwWDuZi22fzOi49dfVPPkKhC15C8FEIVOplLoXOwRIGpYSASTYDOfmOzTuUPtvm3NlINnqT9x4svEYAAvE4z/erLkJWTGEncMQdh2TrEvghg0UbxjDlViXlSIr/DDJ0vcfaqhnNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:18:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:18:02 +0000
Message-ID: <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>
Date: Mon, 8 Apr 2024 20:18:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/31] x86/resctrl: Move resctrl types to a separate
 header
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-9-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcF1cg2ur/9rZeZ7DZwdIiYpQX5xknfhIoa0pOr+E36u5ZYvLGcBpuge4Qa1veabQuJSLsOW+NuB2z5vJOsgUVVI0KtPnXgtBry4SkDlcvxWYTHBKo0RFUDLJ3hwzkZlVJGfWi7cKAOBAoQFNAeaq7GypiwdHbp+MxOwR+KK4+/VXQh/sR75NsHcdJdS/wF1v4nccaFLd9B9/dprJfimY8hywX0WyN2sEhVx3uGkVfjIrxu9gP2t6IMqZMgI+vGtj5NaCqhBMho6lRXP81L3G0xjzOID2Lh1YI6f1ZKL2FnopRQ/1dZpKLED+ZPtfnehJmoD8Nxuel0o9PtVBTxVwXq+uBcM9mL1uRhnAz2iVl5RzT3hD+8cHH4Xi8bKJ89NHu0vVJ5hTSe3lG1OwgSwRxCOsMm33zRT/COLIt9xyiIdGvTLLc9SNzIglJRBb422w+hOVJHipDrWPcf9uRIE2N5RxsHcqFAyfpZZxmgi+NWDToUzuvuomFvrw3SsFdnb9NzZ4OK8ZwnzHNeiB/0Cl8d8r2Zniyc6CAsDmVtEhA9WHd3QxZaY+CsOjAQey0kimGM7Fl6JMkIrIBRwAyl7lx9COT3mtZAsbkgtVC5UiA2QbPZEMp0BoRTNgWu3+WOSFRxUEq6qdETswFTdxBr+8ICy08FcBvIXsr5rXdgpY+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2xZWGl2UUh1d2NNZ2JqaGJVeE1jOEhGc0x1WThESEpncWFnbFYwWmxHbERG?=
 =?utf-8?B?RmRXMVhFMlJrS1hzNExoQXpTdDMvZmx3cHMzMWpRZGVQVHZkUklTd0dPdlRI?=
 =?utf-8?B?NkxpL3FZN2l0ZVg2eDhRdzlydEhwOTJLVkdIazNaM3d4RitGblAxYUZFdGZv?=
 =?utf-8?B?Tmd6bFV3dGVaeVBRMnZkRFJRSTd5Sys4OGYzaFltY2hRLzB6RkZWM1RpWXIv?=
 =?utf-8?B?b0E0SEhDVHVhZkI3YzNDNGZia2pXbzdYV3puWDNvUk1ZTGhvMVBRNmg1dUls?=
 =?utf-8?B?ajlhVTdUV2JjMnJFVHR3SU8rZ1BmR2xBdFZnS1lXRW1VUFEwSmIrSnZpbStq?=
 =?utf-8?B?MVNjSEE2eVoxWjBUWG1yTzFicTFBSDBXWWNDb2ZrWGhoSHBWVG0rRGhESWRk?=
 =?utf-8?B?eUJaUHRORlJRdzhXTGk5ajB5OCtvR3FKQlJDMG4waGlab3d2VDREUTVUMnh5?=
 =?utf-8?B?Ums5QXpWUDdpTGFRZDRxeTMwdzZkWXlGUHE1VzBVRVE0UXRWTUhFN0RUenVl?=
 =?utf-8?B?TWtvcllKUDJiMUNQZEI5VittWVRxOGFzaG1IdGR5STRNMG1yVUNNSlRZNmZP?=
 =?utf-8?B?L0V6aUh2eHFQQlBFaVpySEJsK0xTWWdLQlJjVFc5M1pYRmg3d3NDN0hTL21Y?=
 =?utf-8?B?ZUJvdkFzeGNSZGxneGloeTZVNVNXekxCQnlqaXV3QkgvM0orM2thY0dYbHNa?=
 =?utf-8?B?U0xFYTUyODBka3piTW51T1pPOTN0OUVVckRBS2diaFBoeHVmVS9Jdkh3Zm0w?=
 =?utf-8?B?M2lYR2o0TjFjU2RONGNnK0ZQK1BmbDFtMnh2bFg1cGZpWEIzUVROZEprOHJG?=
 =?utf-8?B?MTVZU3plTENNZG5WbHJVSWRxWUNzY0sraW5UdnhmcDZuS3M5NGFoRnNXQU5x?=
 =?utf-8?B?TjMrblkwOU5QcjQ3SkhmbS9yZnlWUjF1RmdVVmpBOUdEWmowV1p6RmRGZklo?=
 =?utf-8?B?MC8yYU9BTXU0Q3JtK2VCbmhWWmt5MnJPWHVXVTBJYTNZYksxVmM0eFkzZjZB?=
 =?utf-8?B?SjJReFA4ckw0b0c0SHhja0hzOW5lUkRWRjVEZ3RZaVZ1RzNhNGt4QUVFZUdB?=
 =?utf-8?B?OEgrdjRJZVo2SDZ0RWRBeUc3WUdjU3cwczlRWTZ0OTMzS2xTcmRLRlZET09B?=
 =?utf-8?B?ZjFWdFZxaU1zVkNKMXZ5ZGRDMGVKVEM5dVJjQktaVFRrVGk2dTM1U3JJYkwx?=
 =?utf-8?B?cTlROEltN2UwcW9leHNIUVEwajQrUEJpUWI4RkNLYmlPTmF4c1VDOFM4NkJs?=
 =?utf-8?B?cllHdE9jaWF3TU1vSGFyU1M0cmtBY3RGQk1zSmpQWmNlTmdjcFREVmI3cGJ3?=
 =?utf-8?B?ZGlNTlZoVFU1eG1tWVB4N2Y4dVNUMCtyRGNGUTgxVVZGdm1RT3hPYzNsRDc0?=
 =?utf-8?B?ZGxDNWVmVHVVNXNMdWYvbDVOQVZRL2g0NTd1ZmwzUUxJN1pteWdjK090cGI0?=
 =?utf-8?B?dGovc05mY0MzQ0YzdzBKYXJCUU5qd0NaWVg2UlVPQWxYTDdYektqeGRkbWVT?=
 =?utf-8?B?SU5LMTZzWFNzYjA5MzB2RFgyWmlraVpCQkNRWXlLTmx2UEc0Umo1UVV0V3FN?=
 =?utf-8?B?VVoyUG9lSXd0eDVCVzE5ZU8zS1c3VFEwWC9qZkswbzM3Y2FTVnZkb0UrQlpu?=
 =?utf-8?B?OE5KcWFZNnFlWGVzbHN6TXVCZjB5RkUveTUxRU9RR2QvVGxtNXB1WnlBbHph?=
 =?utf-8?B?eUN3SnFDbjUyMDFteVBmcGpTajlubk9JUVFLQ045TFVuY1pxY2ZnaGk2c293?=
 =?utf-8?B?SWtZRDQ1eU9oc3lFa0duN0xZNm5KbGF1SG0rbjN3N1g4YXlNNmNraktnaFdw?=
 =?utf-8?B?VHpSWUdGMTQzWEZKVFNlWGxYd0I5bGxFVVNFbkZqSUNkMXlqaG9ZSzJEZDU2?=
 =?utf-8?B?d2xicnhxL1ZEeU5WM05hcm45Y2xPRFczYVZxWDZDQUF6cU45U3FmdVE4VW9B?=
 =?utf-8?B?TkZyR1pTeXpxcjJlTXhxaDBVOTZWNFFWRThwL0pmWHVqNVptV1FkeWxqeWQ2?=
 =?utf-8?B?Tlljc1laekJEWFJVYW9PalNVZllKcFFJWk9NTW9taVUzSThEanFvM1M4Q0NH?=
 =?utf-8?B?ZnR6THFzVGxjR0JsRDM0NXFMeG9UenZHbXFzdi9FK0pQa1I4ZnhMc05PUmJE?=
 =?utf-8?B?c2Uwb3FXRDQ0N2dUdWVXWHpJTjl0TXBaYWF2d085RFUyV3NDRXhpaEsyM2hH?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0505c2f2-46b4-4d88-b1b6-08dc5843aa6a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:18:02.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMMEJu+nkjb7R871rcTEly4sc48ZGSzXxTwwpLOOaaEoawhd0HI7HmNV4hcsruSJUoQyG4PI4vIgDegrZJuosy5CGdAwwaWH/apNaLjVvGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> To avoid sticky problems in the mpam glue code, move the resctrl
> enums into a separate header.

Could you please elaborate so that "sticky problems in the mpam glue code" is
specific about what problems are avoided?

> 
> This lets the arch code declare prototypes that use these enums without
> creating a loop via asm<->linux resctrl.h The same logic applies to the
> monitor-configuration defines, move these too.
> 
> The maintainers entry for these headers was missed when resctrl.h
> was created. Add a wildcard entry to match both resctrl.h and
> resctrl_types.h.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

..

> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> new file mode 100644
> index 000000000000..4788bd95dac6
> --- /dev/null
> +++ b/include/linux/resctrl_types.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Arm Ltd.
> + * Based on arch/x86/kernel/cpu/resctrl/internal.h
> + */

Could this header please explain how this file is intended to be used?
What is it intended to contain?

Reinette


