Return-Path: <linux-kernel+bounces-162128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90D8B5651
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534BE1C203AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4F944C7B;
	Mon, 29 Apr 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTwkjQrx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92D3FE3E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389440; cv=fail; b=by2wOWxVJ1N0Vb0JVD55gRW0cgi6NqN/LlDAfVhG82TeAkJyj9evNPhWBAMAJ4yqJh2DIZeCCMWnsEblSzv1MLJHa1494+DPjfm5wklK0yO+UP3J4pcjj+G7mY9grH+JMtsD8MVVKM1ist/g/TZO8qR/Ngqm0t2t80ySyhWVHyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389440; c=relaxed/simple;
	bh=TyziZaT/oftVot1MoVTR+gYEjbBwFw7BJ9z2539vcaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHs0oPUtb+ajKqCtfCescBhQV6Vq5CGNKMQy3NHLOLtBjIf4O1Ht4RhQddhN1XIpNbUkMuzsWkwN9Ek2zSDBnGIi7b0t/hnU0kz4OczLGX4xYva3JI2oplbJoJdIxd7kyW3A+oETQrmgufbqAJfUA6ysy109KmbX2XG+CpX3P2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTwkjQrx; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714389438; x=1745925438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TyziZaT/oftVot1MoVTR+gYEjbBwFw7BJ9z2539vcaM=;
  b=GTwkjQrxtPls8hl0jk5ZdHy0Sb62E0fjhXGougLCsyTojTZQ7gsrhE57
   VQrTO3rXw0/hXrgZuRRPb1/3PkXx2Df8wwkTsp+pbZdVxxNVgG3k/xe1k
   fqOHcZ2dTlS04KdFY3PqfkzztyMjoNHFziKItp1aJ0nkdZT5C2qtCPMl4
   1QjogZN17EtPDw7tTYQqvs5QzFRyyKbGjwglZIX/Kz3p7ms23j7DjT42F
   uUEVn3nZcILWPIIEuu/ZxVgHASG3VGMz9zEU+fN2Oj3jNnWKZoYjwOeo4
   HElsb4/n9DRPBHOfq6MunM6iwGFP5wWnNyTfMI5GRHg4BWDoCCLspcH8M
   g==;
X-CSE-ConnectionGUID: /t3xAK1BT3qo3qkEtFElxg==
X-CSE-MsgGUID: +Dl5GlinTymwB4AYCs0EDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9918090"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9918090"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 04:17:16 -0700
X-CSE-ConnectionGUID: snskjIKtSHuxWmlbIDMf0w==
X-CSE-MsgGUID: QCwYv/kwQJ+aYaqUSlS3PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30881256"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 04:17:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 04:17:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 04:17:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 04:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0/gbwabnpgqCqF/mlfKLHAo7MQzHdtOOlrJ5t96BegUjYZdj88D39Z+AixV5tBJb3HLgD+eU8+nc1GmUGQtfCue3aM+/X7mQoTHFbvdQkWERb++a1LkmrQHgc1L+B11i37yOR1mhI5R+y7sApkqakQjXucq6ML6nNLunhaDXmZwTBtnXWfuyUP8xLq8WJ6G3Kar0/xq1yYk0Id6wt+nvV+XlqyewEAPRsBKy5zYOsvsZ6f7Nm49oq3as/nDAPq6gVGa23tMN1Ez0pwxWc9wyNGHr91jpq1RY4/W1N/FDmAbN3Mo4aoUt81TQqt4RJ2kq+DFZCeQ3uiK3I5Ly3UiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyziZaT/oftVot1MoVTR+gYEjbBwFw7BJ9z2539vcaM=;
 b=lRyTUiGpj9LW8ubDYUW6i8Airvzu2pJ7XHYJrehktN8z5Np8BhsZd3hpVNIMBgTydTcf8IWxV4NSfBGTud/pNs7nwXll4rANN0U8y1Mb7AGykQHbjchZBBvkp6mu9qfGs7OOHV1VMACKpqhU3omBkJrJY3ehYrB2bg7ggv3hHRo9uCA8Zw1dNQDzF2E0AUr+3gQFIzLF/XNHyAWElh/wgG6gGzSbRx/DasJpQhA8CbIGfrrnPnICs43w+yMEQKUeSIeoJy6IGDBNF6YfStE4g0png3heK+5+9Yn1TlcH35RN+tB7DGbKvM9PCeF0Qa7jXeIH7u5iQCVz60WfGZbTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 11:17:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 11:17:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "Schofield, Alison"
	<alison.schofield@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kai.huang@linux.intel.com"
	<kai.huang@linux.intel.com>
Subject: Re: [PATCH 1/2] x86/cpu: Remove useless work in detect_tme_early()
Thread-Topic: [PATCH 1/2] x86/cpu: Remove useless work in detect_tme_early()
Thread-Index: AQHal5HHKtLtLpT4uk+zeTKk+P4iM7F/HmmA
Date: Mon, 29 Apr 2024 11:17:12 +0000
Message-ID: <25da8fb143b361740660bccff3973e04f1506b39.camel@intel.com>
References: <cover.1713929290.git.alison.schofield@intel.com>
	 <4e159cdb00907dd7884c191acdab3a028d2f4857.1713929290.git.alison.schofield@intel.com>
In-Reply-To: <4e159cdb00907dd7884c191acdab3a028d2f4857.1713929290.git.alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA3PR11MB8046:EE_
x-ms-office365-filtering-correlation-id: 101fde62-604d-46fa-0b0d-08dc683deb27
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aFJKdUk0SzBDaDlMQW8wMFMvd3RzdmN6V2ZpVWhDNDl3ZnE4cTNBME9RazNv?=
 =?utf-8?B?OXNnYkNvelRHT3N1TzV0UytQdWZOM2lxZ1g4dE14aW1UOS8rZXU2OEM3K0FW?=
 =?utf-8?B?SHAyWEVrZ3BYS3hhckFSVXRaTDNtekkyYU1aRWIvT2U3Sm1GOEhRdjlCbHpu?=
 =?utf-8?B?Y0NEdndxN3Z1cWFXd0ExclBOaU93MStLSVhRMnpRNVJHSE5VSElycjcyN1ZR?=
 =?utf-8?B?ZVBLdlFLTXRYZ2ZqMVNMeU5LSDJhNk1iaGkrczAzK3doVXVQSEh6WXdOMnhw?=
 =?utf-8?B?TlZhZ09EcUlic3puME1vUkRlRnF4TnhIQzJlMlJPT2pHcVVHbmRVazBGRjFx?=
 =?utf-8?B?MUJHUkF4Zzl5Z2FqRVhHaXNMUFY4emg4bjhNSGJYRm5rdDAwKzBDOU13ZEM2?=
 =?utf-8?B?SXJXM053OExyeTkwaCtBL2lzNWNNOFR2ZWtzbzNSdDJOUVhodEdjZnBiUzZm?=
 =?utf-8?B?c2hxUEl2dEE4bU9Sd0ZjdDYvSWRPNE0xU1JIVEw2VytkOVpENGp4ck1CTjBR?=
 =?utf-8?B?RktsUzFYa29ONjFxVlNVREtoblZoaThCQStEM2xBWG8wVzRPNVVZaU5FWXJp?=
 =?utf-8?B?TlhrRWl6Rnlkd0FSV3Y5cWdxRVpzYWl6Q2dUeDVCL0pyUGQ5MHNGNDlLSTA1?=
 =?utf-8?B?Z0F1NGxlN2xVejB1SnFSNnlzdWdUVkVaWmxFeTBzcjF6dU83WnVtdG5KaWdv?=
 =?utf-8?B?dEZWTXgvTG45RWNIOVdoaXVxbUtIY3RvVzBhMEordTE2RG9xRTBYT3RnMWdy?=
 =?utf-8?B?ZHhWL1FZTWFSVmVSTHVjVkwxQlNFaWM0MFBycDR4ZkV3R09pWHpkWVBFcEpP?=
 =?utf-8?B?emdaU2djMDhNU3BoV1RDNVM3b1hmVFdxSFVQZzg0YzN5ZHNidVdRMzVmZm9S?=
 =?utf-8?B?MHBuSVpaclQ5cmtnWHI1RmhROUYzQS9qT013c2ZtNVhUZklrTDZZNktncUY5?=
 =?utf-8?B?cDRhRGdvd3VRbFIwbmhYekR1dCtVYUJJRWlwNFFWRlNuK2s2dHJvSGhqaER4?=
 =?utf-8?B?bVd6K1luRWQzUzJ1MnJpM3c1cldiZjRsVGVEVlJsM3Z3Mk55SitDaWlkZlIy?=
 =?utf-8?B?Q1JIc1E5dm03ODVRNllQYi96SHN0aGYvdFhiUXo2cXJrYjRGM250cXdnMC9H?=
 =?utf-8?B?b2U0RldlaEQrNWtUaE9xd3R5Z1N4RzRWWTZzdTZTTVM4dEF2UEIrNC82RXBR?=
 =?utf-8?B?RTBEcWJ0aDE4eWt2U1hmV04wSFZJYStTVWprM3Rzd0o1MTFzWGdNNGNtTEQz?=
 =?utf-8?B?TTVSMERnYXkveUtEVnJFejcwSkFOT3FGTDJFZ2RDYzBzQXpuaTdFZytWTXBP?=
 =?utf-8?B?OHJOT0NYS2ppVmg3T2Y5T0JWY0ZWV1NURmJ0WllFN01XelF3L0Y0S09QVnVW?=
 =?utf-8?B?VlhxdEZwNmpYOGxCNXZXTTQ5VXpHWmEyc3l4VFNha2kvalVTdzNydkdvNHpD?=
 =?utf-8?B?SWpVRUhvMHE5djZ5bWRIcUZhc2RRaENnN1Ixc0dPYjdZL1JWUXB4OXVCVkNW?=
 =?utf-8?B?Z29vV0k5bUtzS3pmVGRycGRhdmlsV04yN3hxQkk1ZUt6cU1GK3hzR3pUVmRh?=
 =?utf-8?B?NzJYeHg1WXFhaUhXaUQwc3pnMzh2bTJuZXBNcGlVMVBZbjZxV0YvVlNKTStq?=
 =?utf-8?B?T2xCVi9mK2svK3orelRmQ0J4Q1RSR2RsQlRmRzdMWWVhN095MzlnMFgvSEdr?=
 =?utf-8?B?Y21lWjRGZG9QSGROeUFlaGRwbHVQVkZpM1JSY3l4N3daNitydWxyZlJwaFFz?=
 =?utf-8?B?dnZsVGQwb0hHSzhmSWNtUHJjYVhJcXdXNGtaVEsyK0dacERKVjRDUXBiUjJ0?=
 =?utf-8?B?cG1adWhxbEY3YWNMclJyQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEkxUjZtNTVTTVBWZWkwbVpYUTZBYTFxUWorNk1uR2VmRk1BSFdZcTF0M0pZ?=
 =?utf-8?B?V3NPc3dVTWgvaEZZbXVlaFlOSEt1dnI0c1B4dmx3Y21GWFN1UDh2NlhmSnZp?=
 =?utf-8?B?SEhvTnRHMjZ6Y0FNSWowLzJUcnhGRXhJZGlsQ3JPSjFocjRsdG1rdUE1cExK?=
 =?utf-8?B?UGhsSkxTQ1plVnM0b0ZYeHZ2TjQzamZZRUFlSTFBRVFFZzB5TkJBVUM3d0Fu?=
 =?utf-8?B?Z2RvcndwbVJzNWl5V1E3NlRrdDlMTTcyWCtzcTlMNjY5cnkvd3JXd1FpY1Mw?=
 =?utf-8?B?NlliazltVG54MzdUZDFIcmVDKzdlbjlwQVNDSkxqZkh3U093MFozRlJ0UFdB?=
 =?utf-8?B?MlVUSlVTRXgrR1EyakZZb2FhQzNkM1dmWW5TSmlqanp0cC9DRXpNZTdTTG9u?=
 =?utf-8?B?NHp2ZUJCc0xDdEQrdUM5Ym42dEM2ZXRtNFdUTjlvUXAzWkF0eC9iMHJpRFd6?=
 =?utf-8?B?dk40U3lFUjFYVHFIVDFBZmcxZHY5bHNVcGdvMHNDVW43MGpCazJqWDBnRktG?=
 =?utf-8?B?UHJtMlRvRll4TXc3U0R0Z1BscGV1MW9LY2oxaDE4dERQZFZDRkViSUdCMVFi?=
 =?utf-8?B?QjBxVGxsUHFDRlhoWHM3MW9CTTUxU0QzQm1RKzVpU085SzZHb255amoyQVpC?=
 =?utf-8?B?WjNlZ3V3Y2JvdE51RVN1NWgzdHRzbzJrakJYZ2lpTEFnWll6NTlNdFk3ZjlU?=
 =?utf-8?B?dTNMRWRXNXNiWmpSb3J4RFZQdHdiSlgwd0ZVTVJFcTBrQUNXcXdWc0JHNVpN?=
 =?utf-8?B?NTlYbENFdHV1RmtmV3RIbVliQlY2UVhuazFUcXVzS2xKbGNLZnlDVEZNYmtW?=
 =?utf-8?B?R1hqeVFhLzBBVlFFQnhFeS9YNUZuYlNsU2FNWHVxS3hxK2IrMzc1SGpOZFJz?=
 =?utf-8?B?eGkvWEovVFV6MHJjdGFwb1FIZzZBRG9mdzlZVVFZRkQ3bHRrRS8yYzErVUpa?=
 =?utf-8?B?Ykgva0g3cHl6a002WTNJd210T3QrU2s1Y1VLc0orTnhyTmV4K014YTh2V2dw?=
 =?utf-8?B?WG43NlRvVEpqQTVoN1I1Y0luWjlJUTBjalFtL0p4bk93VGZmVHU3RjdYUFRt?=
 =?utf-8?B?V29mSWpEa3c3ZFFreGZaOEN3Mmg0K245ZVYwODVaa2RjMWZNRmpIN1pTMmpS?=
 =?utf-8?B?N01lOXc4QzdrS29jZ3VobFRYSnBUV29mL1NFSmZpcStidnRJWVQ0TzZSUjVJ?=
 =?utf-8?B?Z0tIN2pRUkc5MCtQUy95b2dRWFBUbVdJRDJiQ05tMmI3c3hEcUZENG83ZzNO?=
 =?utf-8?B?aVMzeXpJVFZ2SGh6MnpCdW1KV2dmMkFvdllxVGQ0TXJleVJrT2d1d0IxZ21x?=
 =?utf-8?B?RG5LYmg0d25LM21hbzFHcXpLaDRyU0pSNzhsRVNkcVNXb0Z4M1EvMy9naXY0?=
 =?utf-8?B?bzVhV0IzeUNxZUMrWUxIcVdpdzhocmdYbkMyOWJRMytNb2cvMzRWdUFYa3dE?=
 =?utf-8?B?QzltTVlpSm1YSG13MTMxZmwxTFdhaTQzbE9sdU92ZGNCYWFRb0VHVE5SZFZD?=
 =?utf-8?B?QmpxNWFjMDVneVFjUE9lUVBIQXdnckh0MmoxcUtraVduYkRmaDYyUHpsTkNL?=
 =?utf-8?B?YTM4VGZmRG1VcHZWb1N5RXFGSzRMYXp4SHlyeWQrN0twdGxGYjBHWjNXRW1r?=
 =?utf-8?B?b2RKU2I2OXlkdTlHRTh6YUF2eERFTzRhVlFjK2xsY1ZRMGxhc2MvbFJHQ01K?=
 =?utf-8?B?VU1JU2JTNktGR3IrTDRjM0Jrblp5a0VmMlZ1OGxTK2ZFYitzR2F2eXcra1lr?=
 =?utf-8?B?VTd4eVRVQUsybnRzS2Z5VDZsRlF1NkY0U0p4VDR3TUFXZU0wbERaWXRmeGkr?=
 =?utf-8?B?ZDdqWGc0SU55WW9wUUVQNHdXRm1SbDYyNkZYT2s0Zk1mUm85d0RJcGszVGw0?=
 =?utf-8?B?ZVNKL0NnZ2w2VThtR09ySzlneGJRT2lKQnVzWllWU3RyQWRRMlg0OS9BeWZW?=
 =?utf-8?B?RTJieG1TaDdLM1ArQXEzZ3RnMkhLay93VDRwY0FrMHBFT3pBSTlmQmNieTBO?=
 =?utf-8?B?WG4wV1BXOWJoby91MFNrSnhIZG1CczZlSTBuZEx2bWJxVHhmSWppeDFDNVgr?=
 =?utf-8?B?Y1IxTnhCM3l6dmhOYTBmVmlxNURsM3JXWUwzQ2h2aUYzUStKWC9zcllBdnFT?=
 =?utf-8?B?bllDeEFDTjZyYjFzbmsyM0trUjczTFBmNkpKSzhEbXh0aWt4TmtPdk5SMkZX?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <457B02B63DEAA646BB5122ACEE456218@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101fde62-604d-46fa-0b0d-08dc683deb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 11:17:12.7044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aujF8sH37lFLibEQIu6E2gGr1EHL17voU3IQ5C06u0PPHoA9x6SZTX9nHFwoKuURU7Pb5brohxWP7fshlz5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDIxOjI0IC0wNzAwLCBhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBp
bnRlbC5jb20+DQo+IA0KPiBUTUUgKFRvdGFsIE1lbW9yeSBFbmNyeXB0aW9uKSBhbmQgTUtUTUUg
KE11bHRpLUtleSBUb3RhbCBNZW1vcnkNCj4gRW5jcnlwdGlvbikgQklPUyBkZXRlY3Rpb24gd2Vy
ZSBpbnRyb2R1Y2VkIHRvZ2V0aGVyIGhlcmUgWzFdIGFuZA0KPiBhcmUgbG9vc2VseSBjb3VwbGVk
IGluIHRoZSBJbnRlbCBDUFUgaW5pdCBjb2RlLg0KPiANCj4gVE1FIGlzIGEgaGFyZHdhcmUgb25s
eSBmZWF0dXJlIGFuZCBpdHMgQklPUyBzdGF0dXMgaXMgYWxsIHRoYXQgbmVlZHMNCj4gdG8gYmUg
c2hhcmVkIHdpdGggdGhlIGtlcm5lbCB1c2VyOiBlbmFibGVkIG9yIGRpc2FibGVkLiBUaGUgVE1F
DQo+IGFsZ29yaXRobSB0aGUgQklPUyBpcyB1c2luZyBhbmQgd2hldGhlciBvciBub3QgdGhlIGtl
cm5lbCByZWNvZ25pemVzDQo+IHRoYXQgYWxnb3JpdGhtIGlzIHVzZWxlc3MgdG8gdGhlIGtlcm5l
bCB1c2VyLg0KPiANCj4gTUtUTUUgaXMgYSBoYXJkd2FyZSBmZWF0dXJlIHRoYXQgcmVxdWlyZXMg
a2VybmVsIHN1cHBvcnQuIE1LVE1FDQo+IGRldGVjdGlvbiBjb2RlIHdhcyBhZGRlZCBpbiBhZHZh
bmNlIG9mIGJyb2FkZXIga2VybmVsIHN1cHBvcnQgZm9yDQo+IE1LVE1FIHRoYXQgbmV2ZXIgZm9s
bG93ZWQuIFNvLCByYXRoZXIgdGhhbiBjb250aW51aW5nIHRvIGVtaXQNCj4gbmVlZGxlc3MgYW5k
IGNvbmZ1c2luZyBtZXNzYWdlcyBhYm91dCBCSU9TIE1LVE1FIHN0YXR1cywgcmVtb3ZlDQo+IG1v
c3Qgb2YgdGhlIE1LVE1FIHBpZWNlcyBmcm9tIGRldGVjdF90bWVfZWFybHkoKS4NCj4gDQo+IEtl
ZXAgb25lIGltcG9ydGFudCBwaWVjZTogd2hlbiB0aGUgQklPUyBpcyBjb25maWd1cmVkIHdpdGgg
TUtUTUUNCj4gJ29uJyBhbnkgQklPUyBkZWZpbmVkIEtleUlEIGJpdHMgZG8gdGFrZSBhd2F5IGZy
b20gdGhlIHBoeXNhZGRyIGJpdHMNCj4gYXZhaWxhYmxlIGluIHRoZSBrZXJuZWwuIEFkZCBhIHBy
X2luZm9fb25jZSgpIGluZm9ybWluZyBhYm91dCB0aGUNCj4gZW5hYmxlZCBrZXlpZHMgc28gdGhl
IHVzZXIgY2FuIGFkZHJlc3MgKGJ5IHJlYm9vdGluZyB3aXRoIE1LVE1FIG9mZikNCj4gaWYgdGhl
IHVzZXIgbmVlZHMgdG8gcmVjb3ZlciB0aGUgTUtUTUUgY29uc3VtZWQgYml0cy4NCg0KTml0cGlj
a2luZ3MgYmVsb3c6DQoNClRoZSBvcmlnaW5hbCBjb2RlIGNoZWNrcyB0aGUgTVNSIHZhbHVlIGNv
bnNpc3RlbmN5IGJldHdlZW4gQlNQIGFuZCBBUHMsDQpidXQgdGhlIG5ldyBjb2RlIHJlbW92ZWQg
dGhhdC4NCg0KSSB0aGluayB0aGUgY2hhbmdlbG9nIHNob3VsZCBtZW50aW9uIHdoeSBpdCBpcyBP
Sy4NCg0KSSBndWVzcyBwZXJoYXBzIHdlIGNhbiBzYXkgc29tZXRoaW5nIGxpa2UgdGhlIG1hY2hp
bmUgc2hvdWxkbid0IGJlIGFibGUgdG8NCmJvb3QgaWYgQklPUyBjb25maWd1cmVzIFRNRSBhY3Rp
dmF0ZSBNU1IgaW5jb25zaXN0ZW50bHkgYW1vbmcgQ1BVcywgc28NCmRvbid0IGJvdGhlciB0byBo
YXZlIHRoZSBjb25zaXN0ZW5jeSBjaGVjay4NCg0KPiANCj4gVGhlcmUgaXMgbm8gZnVuY3Rpb25h
bCBjaGFuZ2UgZm9yIHRoZSB1c2VyLCBvbmx5IHRoaXMgY2hhbmdlIGluIGJvb3QNCj4gbWVzc2Fn
ZXM6DQo+IA0KPiBCZWZvcmU6DQo+IFtdIHg4Ni90bWU6IGVuYWJsZWQgYnkgQklPUw0KPiBbXSB4
ODYvdG1lOiBVbmtub3duIHBvbGljeSBpcyBhY3RpdmU6IDB4MiANCj4gW10geDg2L21rdG1lOiBO
byBrbm93biBlbmNyeXB0aW9uIGFsZ29yaXRobSBpcyBzdXBwb3J0ZWQ6IDB4NA0KPiBbXSB4ODYv
bWt0bWU6IGVuYWJsZWQgYnkgQklPUw0KPiBbXSB4ODYvbWt0bWU6IDEyNyBLZXlJRHMgYXZhaWxh
YmxlDQo+IA0KPiBBZnRlcjoNCj4gW10geDg2L3RtZTogZW5hYmxlZCBieSBCSU9TDQo+IFtdIHg4
Ni9ta3RtZTogQklPUyBlbmFibGVkIDEyNyBrZXlpZHMNCg0KUmVnYXJkaW5nIHRvIHdoYXQgdG8g
cHJpbnQ6DQoNCjEpIElNSE8sIGl0J3Mgc3RpbGwgYmV0dGVyIHRvIHByaW50IHRoZSBhbGdvcml0
aG0gaGVyZS4gIFRoZSB1c2VyL2FkbWluDQptYXkgd2FudCB0byBrbm93IHdoYXQgYWxnb3JpdGht
IGlzIGVuYWJsZWQgYnkgdGhlIEJJT1MgKGVzcGVjaWFsbHkgdGhlcmUNCmFyZSBtb3JlIHRoYW4g
b25lIHRoYXQgY2FuIGJlIHNlbGVjdGVkIGluIHRoZSBCSU9TKS4gIEUuZy4sIHRoZSB1c2VyIG1h
eQ0KZmluZCB0aGUgZGVmYXVsdCBBRVMtWFRTLTEyOCAoMCkgaXNuJ3Qgc2VjdXJlIGVub3VnaCBh
bmQgd2FudHMgdGhlIG1vcmUNCnNlY3VyZSBhbGdvcml0aG0gdXNpbmcgMjU2LWJpdCBrZXkuDQoN
CkkgdW5kZXJzdGFuZCB3ZSBtaWdodCBub3Qgd2FudCB0byBtYWludGFpbiBhICJ2YWx1ZSB0byBu
YW1lIiB0YWJsZSBmb3INCnRoaXMgc28gdGhlIGtlcm5lbCBjYW4gcHJpbnQgdGhlIGFsZ29yaXRo
bSBpbiBuYW1lLCBidXQgaXQgd291bGQgYmUgc3RpbGwNCmhlbHBmdWwgaWYgd2UganVzdCBkdW1w
IHRoZSByYXcgdmFsdWUgaGVyZSBsaWtlOg0KDQogIHg4Ni90bWU6IHBvbGljeSBhY3RpdmF0ZWQ6
IDB4Mg0KDQoyKSBHaXZlbiB0aGUga2VybmVsIGRvZXNuJ3Qgc3VwcG9ydCBNS1RNRSwgSSB0aGlu
ayBwZW9wbGUgbWF5IGJlIG1vcmUNCmludGVyZXN0ZWQgaW4gdGhlIHJlZHVjZWQgcGh5c2ljYWwg
YWRkcmVzcyBiaXRzLCBpbnN0ZWFkIG9mIGhvdyBNS1RNRQ0Ka2V5SURzIGFyZSBhY3RpdmF0ZWQu
DQoNCiAgeDg2L3RtZTogTUtUTUUgZW5hYmxlZCwgcGh5c2ljYWwgYWRkcmVzcyBiaXRzIHJlZHVj
ZWQgZnJvbSA8eHg+IHRvIDx4eD4uDQoNCj4gDQo+IFsxXSBjYjA2ZDhlM2QwMjAgKCJ4ODYvdG1l
OiBEZXRlY3QgaWYgVE1FIGFuZCBNS1RNRSBpcyBhY3RpdmF0ZWQgYnkgQklPUyIpDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNv
bT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2ludGVsLmMgfCA3MSArKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgNTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9pbnRlbC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5jDQo+IGluZGV4IDNj
M2U3ZTU2OTViYS4uODM4NjU4OTdhMmE3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2ludGVsLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5jDQo+IEBAIC0x
OTAsODMgKzE5MCwzNiBAQCBzdGF0aWMgYm9vbCBiYWRfc3BlY3RyZV9taWNyb2NvZGUoc3RydWN0
IGNwdWluZm9feDg2ICpjKQ0KPiAgI2RlZmluZSBUTUVfQUNUSVZBVEVfTE9DS0VEKHgpCQkoeCAm
IDB4MSkNCj4gICNkZWZpbmUgVE1FX0FDVElWQVRFX0VOQUJMRUQoeCkJCSh4ICYgMHgyKQ0KPiAg
DQo+IC0jZGVmaW5lIFRNRV9BQ1RJVkFURV9QT0xJQ1koeCkJCSgoeCA+PiA0KSAmIDB4ZikJLyog
Qml0cyA3OjQgKi8NCj4gLSNkZWZpbmUgVE1FX0FDVElWQVRFX1BPTElDWV9BRVNfWFRTXzEyOAkw
DQo+IC0NCj4gICNkZWZpbmUgVE1FX0FDVElWQVRFX0tFWUlEX0JJVFMoeCkJKCh4ID4+IDMyKSAm
IDB4ZikJLyogQml0cyAzNTozMiAqLw0KPiAgDQo+IC0jZGVmaW5lIFRNRV9BQ1RJVkFURV9DUllQ
VE9fQUxHUyh4KQkoKHggPj4gNDgpICYgMHhmZmZmKQkvKiBCaXRzIDYzOjQ4ICovDQo+IC0jZGVm
aW5lIFRNRV9BQ1RJVkFURV9DUllQVE9fQUVTX1hUU18xMjgJMQ0KPiAtDQo+IC0vKiBWYWx1ZXMg
Zm9yIG1rdG1lX3N0YXR1cyAoU1cgb25seSBjb25zdHJ1Y3QpICovDQo+IC0jZGVmaW5lIE1LVE1F
X0VOQUJMRUQJCQkwDQo+IC0jZGVmaW5lIE1LVE1FX0RJU0FCTEVECQkJMQ0KPiAtI2RlZmluZSBN
S1RNRV9VTklOSVRJQUxJWkVECQkyDQo+IC1zdGF0aWMgaW50IG1rdG1lX3N0YXR1cyA9IE1LVE1F
X1VOSU5JVElBTElaRUQ7DQo+IC0NCj4gIHN0YXRpYyB2b2lkIGRldGVjdF90bWVfZWFybHkoc3Ry
dWN0IGNwdWluZm9feDg2ICpjKQ0KPiAgew0KPiAtCXU2NCB0bWVfYWN0aXZhdGUsIHRtZV9wb2xp
Y3ksIHRtZV9jcnlwdG9fYWxnczsNCj4gIAlpbnQga2V5aWRfYml0cyA9IDAsIG5yX2tleWlkcyA9
IDA7DQo+IC0Jc3RhdGljIHU2NCB0bWVfYWN0aXZhdGVfY3B1MCA9IDA7DQo+ICsJdTY0IHRtZV9h
Y3RpdmF0ZTsNCj4gIA0KPiAgCXJkbXNybChNU1JfSUEzMl9UTUVfQUNUSVZBVEUsIHRtZV9hY3Rp
dmF0ZSk7DQo+ICANCj4gLQlpZiAobWt0bWVfc3RhdHVzICE9IE1LVE1FX1VOSU5JVElBTElaRUQp
IHsNCj4gLQkJaWYgKHRtZV9hY3RpdmF0ZSAhPSB0bWVfYWN0aXZhdGVfY3B1MCkgew0KPiAtCQkJ
LyogQnJva2VuIEJJT1M/ICovDQo+IC0JCQlwcl9lcnJfb25jZSgieDg2L3RtZTogY29uZmlndXJh
dGlvbiBpcyBpbmNvbnNpc3RlbnQgYmV0d2VlbiBDUFVzXG4iKTsNCj4gLQkJCXByX2Vycl9vbmNl
KCJ4ODYvdG1lOiBNS1RNRSBpcyBub3QgdXNhYmxlXG4iKTsNCj4gLQkJCW1rdG1lX3N0YXR1cyA9
IE1LVE1FX0RJU0FCTEVEOw0KPiAtDQo+IC0JCQkvKiBQcm9jZWVkLiBXZSBtYXkgbmVlZCB0byBl
eGNsdWRlIGJpdHMgZnJvbSB4ODZfcGh5c19iaXRzLiAqLw0KPiAtCQl9DQo+IC0JfSBlbHNlIHsN
Cj4gLQkJdG1lX2FjdGl2YXRlX2NwdTAgPSB0bWVfYWN0aXZhdGU7DQo+IC0JfQ0KPiAtDQo+ICAJ
aWYgKCFUTUVfQUNUSVZBVEVfTE9DS0VEKHRtZV9hY3RpdmF0ZSkgfHwgIVRNRV9BQ1RJVkFURV9F
TkFCTEVEKHRtZV9hY3RpdmF0ZSkpIHsNCj4gIAkJcHJfaW5mb19vbmNlKCJ4ODYvdG1lOiBub3Qg
ZW5hYmxlZCBieSBCSU9TXG4iKTsNCj4gLQkJbWt0bWVfc3RhdHVzID0gTUtUTUVfRElTQUJMRUQ7
DQo+ICAJCWNsZWFyX2NwdV9jYXAoYywgWDg2X0ZFQVRVUkVfVE1FKTsNCj4gIAkJcmV0dXJuOw0K
PiAgCX0NCj4gLQ0KPiAtCWlmIChta3RtZV9zdGF0dXMgIT0gTUtUTUVfVU5JTklUSUFMSVpFRCkN
Cj4gLQkJZ290byBkZXRlY3Rfa2V5aWRfYml0czsNCj4gLQ0KPiAtCXByX2luZm8oIng4Ni90bWU6
IGVuYWJsZWQgYnkgQklPU1xuIik7DQo+IC0NCj4gLQl0bWVfcG9saWN5ID0gVE1FX0FDVElWQVRF
X1BPTElDWSh0bWVfYWN0aXZhdGUpOw0KPiAtCWlmICh0bWVfcG9saWN5ICE9IFRNRV9BQ1RJVkFU
RV9QT0xJQ1lfQUVTX1hUU18xMjgpDQo+IC0JCXByX3dhcm4oIng4Ni90bWU6IFVua25vd24gcG9s
aWN5IGlzIGFjdGl2ZTogJSNsbHhcbiIsIHRtZV9wb2xpY3kpOw0KPiAtDQo+IC0JdG1lX2NyeXB0
b19hbGdzID0gVE1FX0FDVElWQVRFX0NSWVBUT19BTEdTKHRtZV9hY3RpdmF0ZSk7DQo+IC0JaWYg
KCEodG1lX2NyeXB0b19hbGdzICYgVE1FX0FDVElWQVRFX0NSWVBUT19BRVNfWFRTXzEyOCkpIHsN
Cj4gLQkJcHJfZXJyKCJ4ODYvbWt0bWU6IE5vIGtub3duIGVuY3J5cHRpb24gYWxnb3JpdGhtIGlz
IHN1cHBvcnRlZDogJSNsbHhcbiIsDQo+IC0JCQkJdG1lX2NyeXB0b19hbGdzKTsNCj4gLQkJbWt0
bWVfc3RhdHVzID0gTUtUTUVfRElTQUJMRUQ7DQo+IC0JfQ0KPiAtZGV0ZWN0X2tleWlkX2JpdHM6
DQo+ICsJcHJfaW5mb19vbmNlKCJ4ODYvdG1lOiBlbmFibGVkIGJ5IEJJT1NcbiIpOw0KPiAgCWtl
eWlkX2JpdHMgPSBUTUVfQUNUSVZBVEVfS0VZSURfQklUUyh0bWVfYWN0aXZhdGUpOw0KPiAtCW5y
X2tleWlkcyA9ICgxVUwgPDwga2V5aWRfYml0cykgLSAxOw0KPiAtCWlmIChucl9rZXlpZHMpIHsN
Cj4gLQkJcHJfaW5mb19vbmNlKCJ4ODYvbWt0bWU6IGVuYWJsZWQgYnkgQklPU1xuIik7DQo+IC0J
CXByX2luZm9fb25jZSgieDg2L21rdG1lOiAlZCBLZXlJRHMgYXZhaWxhYmxlXG4iLCBucl9rZXlp
ZHMpOw0KPiAtCX0gZWxzZSB7DQo+IC0JCXByX2luZm9fb25jZSgieDg2L21rdG1lOiBkaXNhYmxl
ZCBieSBCSU9TXG4iKTsNCj4gLQl9DQo+IC0NCj4gLQlpZiAobWt0bWVfc3RhdHVzID09IE1LVE1F
X1VOSU5JVElBTElaRUQpIHsNCj4gLQkJLyogTUtUTUUgaXMgdXNhYmxlICovDQo+IC0JCW1rdG1l
X3N0YXR1cyA9IE1LVE1FX0VOQUJMRUQ7DQo+IC0JfQ0KPiArCWlmICgha2V5aWRfYml0cykNCj4g
KwkJcmV0dXJuOw0KPiAgDQo+ICAJLyoNCj4gLQkgKiBLZXlJRCBiaXRzIGVmZmVjdGl2ZWx5IGxv
d2VyIHRoZSBudW1iZXIgb2YgcGh5c2ljYWwgYWRkcmVzcw0KPiAtCSAqIGJpdHMuICBVcGRhdGUg
Y3B1aW5mb194ODY6Ong4Nl9waHlzX2JpdHMgYWNjb3JkaW5nbHkuDQo+ICsJICogS2V5SUQgYml0
cyBhcmUgc2V0IGJ5IEJJT1MgYW5kIGNhbiBiZSBwcmVzZW50IHJlZ2FyZGxlc3MNCj4gKwkgKiBv
ZiB3aGV0aGVyIHRoZSBrZXJuZWwgaXMgdXNpbmcgdGhlbS4gVGhleSBlZmZlY3RpdmVseSBsb3dl
cg0KPiArCSAqIHRoZSBudW1iZXIgb2YgcGh5c2ljYWwgYWRkcmVzcyBiaXRzLg0KPiArCSAqDQo+
ICsJICogVXBkYXRlIGNwdWluZm9feDg2Ojp4ODZfcGh5c19iaXRzIGFjY29yZGluZ2x5Lg0KPiAg
CSAqLw0KPiAgCWMtPng4Nl9waHlzX2JpdHMgLT0ga2V5aWRfYml0czsNCj4gKwlucl9rZXlpZHMg
PSAoMVVMIDw8IGtleWlkX2JpdHMpIC0gMTsNCj4gKw0KPiArCXByX2luZm9fb25jZSgieDg2L21r
dG1lOiBCSU9TIGVuYWJsZWQgJWQga2V5aWRzXG4iLCBucl9rZXlpZHMpOw0KDQpJZiBJIHJlYWQg
Y29ycmVjdGx5LCBpZiB5b3UgcHJpbnQNCg0KICBwaHlzaWNhbCBhZGRyZXNzIGJpdHMgcmVkdWNl
ZCBmcm9tIDx4eD4gdG8gPHh4Pi4gDQoNCmluc3RlYWQgb2YgdGhlIG51bWJlciBvZiBLZXlJRHMs
IHlvdSBjYW4gZXZlbiBnZXQgcmlkIG9mIHRoZSAnbnJfa2V5aWRzJw0KdmFyaWFibGUuDQo=

