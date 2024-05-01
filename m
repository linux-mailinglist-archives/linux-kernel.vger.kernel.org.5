Return-Path: <linux-kernel+bounces-165824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107DD8B9211
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339D41C20F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1179168B16;
	Wed,  1 May 2024 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChynwjVt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE4168AEB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605161; cv=fail; b=jnPGCE0ir72hTOyXmdwBLYtkim5ooDnysjy2WsuE1+0diV4N4HFYncYGnbuZCCxbHMKLn04i96n098FKR19ha2HjfS7BkQmyReh2z0EOYK3iQM1EX2XNwEFQYUi6jAhTDoudNDKQ6iVMbjTXVAzsCgHCWbjMbGNjmBZalten3E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605161; c=relaxed/simple;
	bh=8KKDsksNRMwXvgHII+oqIHGNN4R9aG0MF4vVAaTUACI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fNgcZQR+viKurif9Y6wosPLiu2hAex25D7mnC/IqjUBaP8TG2QjTOfXEuhXhgUvov3gO7azwSaFAe2bdPiK2LdIxodG9rydGqYJ5qSwrJJI7XMDC3sXmBQ/K5e21uhLPcU5ErJ3zM/kK2f814xPIoh2AD0iLXcO4pKQy1k6+keY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChynwjVt; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714605160; x=1746141160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8KKDsksNRMwXvgHII+oqIHGNN4R9aG0MF4vVAaTUACI=;
  b=ChynwjVtbLfSUwcYAydHm+NGeVYwMAop1fcbbPy49kuN1bno36s3GUgh
   ib//lSROCGCLTHt3Q7kdehrM8FoAuoy82dhcT5FmPhaxUNdtz9d62KhIi
   97X03vXbwhaKUMTYBYWbtOzp++1sCD8pCvsmnA00Op2q5JLkmjCTp4NyF
   iPsI2IuIXfUY2UN8F4SRlFIYr/O+Vj+nsWe8m5ih5ziq8uUPymYZfmoVk
   dMnZtzzxpDAm7HPLfV/euLjabQMz60kDlFgshSaJa7QwEG0/GG6rpmkfc
   ravodgN2uoUS416b0ccQrhKQ/GZ9M7WgVP1JJQz0AqKti+ZrZNpzComed
   Q==;
X-CSE-ConnectionGUID: +zoh39QqS/qdPCBn4b6k9Q==
X-CSE-MsgGUID: HpVuAIwfQpm4z9ew6DhGgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="20906382"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="20906382"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 16:12:39 -0700
X-CSE-ConnectionGUID: w/QOnI99TM2L20UyHulDPg==
X-CSE-MsgGUID: 73F5Lu3HQciZlUWQyel5Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="50129651"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 16:12:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 16:12:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 16:12:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 16:12:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbZRaxofsBLWUI7Db6zk4K5ZSSnfzP7CyzUWOAh3Tj2pFvPo/hCo44ggkZU/Q/SOJlYDOLnDteRXJU4rV0O6nlNF9IGjU98EQL3dmEsutNRitPr/pIOvOkGZLDqrSlLku8R+QhfZuoITZaZssjjJIrQp077lWEwY17am4fQuoYcQamRVYT0oTVef8thQ0MpNew7RK8XqJOwO/IbZlKEaejkLhrEC/9d3+0Nmc6j5AiHllVfZK19gieinCqwEZmQPufLF8usNf3Rm0mmKhSW4dTBtEJTfazDJMfe4ccAkxgMjEuur4dTeSjYo0Q1wELyvwY1c7d+P5i1aJSKAoVNRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KKDsksNRMwXvgHII+oqIHGNN4R9aG0MF4vVAaTUACI=;
 b=lwA2HYRcs/nXEkAUBux7j4Ka8BpQYou1TkQkVwVs5rgpC9ElUSx/d573GJHvTm+nBOWdOKgQsowg3AKGg8Fk0qjc89KK9tYErnQf69EopeV9AXTRcGDlATPxqdSAe+l92B51LGXBNrdBS9HnyWKLLnyixPEQpL2t2tZ+45HJKydXui+kKlLYgGA1FU8pxlm0KOLATikeSPzP4oB7PeRJ+UCFYDwBfmzQq+z+CbpQkkoCJCqDI9NY/Xjgnlf9rGgrF6VoO4+JQkvrMDcSeKtIwXp0w+YarDqYCcmBlptAVaZrBusUdq/cKD8wP4TJuCQi1ta0ctWDSuCvhdhQNnZQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 23:12:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 23:12:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "luto@kernel.org" <luto@kernel.org>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "Gao, Chao"
	<chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 0/5] TDX host: kexec() support
Thread-Topic: [PATCH v4 0/5] TDX host: kexec() support
Thread-Index: AQHakYWocHOi7TlILEKJ8pBMSC8KG7GDFwkA
Date: Wed, 1 May 2024 23:12:34 +0000
Message-ID: <82f74b996315b4a94b956eaee554ae0a694e6af3.camel@intel.com>
References: <cover.1713439632.git.kai.huang@intel.com>
In-Reply-To: <cover.1713439632.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB7993:EE_
x-ms-office365-filtering-correlation-id: 5a0b8352-3a41-45bb-94eb-08dc6a342f86
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SzJlQ1VDbDA1NVVmMXJrajZLbkZaUWhaSXgvWk1UTk1xczVlQk1NWkI2cjhq?=
 =?utf-8?B?WldLWnE3WHA4VHJYVlBDZDA0dFdDbzA4My9uUENPNUtIU1owMmNsMkpyVG5X?=
 =?utf-8?B?eHhISjZ4dmluRXpTVm5DU3FaSUF5YkhXeU5PL09rbDkwMXF2RGRaWkNzOXRF?=
 =?utf-8?B?amVLZjdtL1IzZHFEdnNxU1VmZW1zRzNOdzRLZUUrUXR1Y1JyNHZhUVJLS3Jj?=
 =?utf-8?B?MERXMk5iUjFNWFNTTlVzYjBxTGVZaXhKVGFrYTNaQ0NQTVdBUmNMMEVQZHBn?=
 =?utf-8?B?dkJ2SWhuNGF5R0Y0d0dzYmxrUnU5NDZuOCtJVUZYMGRWRC93dGtVWU1JTmFa?=
 =?utf-8?B?QzRIWVFaNFdZa29hRWU1N1BZdE1Ib0JnMFZrQjVldU9yYXVmT3RSV21CUEEx?=
 =?utf-8?B?bktpTWdNQVd3LytQSTduS2dCMUFzeDNiZnRjNFlRNTg5b2xvbXIxdFdvdFZ6?=
 =?utf-8?B?TENaUW1HNjVWT056cjFyM0plOVAzWEFMdy9zVTJWdmJ4M3ZzSWZzanZOaXZ5?=
 =?utf-8?B?VkgvTWMxYXgvZzR0bHdPYjZlWUluVlRXV0VnajgxanBmaFdZK1ZnZFppbysr?=
 =?utf-8?B?a1d4MFhkaEFseFZWNFRuUnNHcXF3c1REano3TnRiTnEvTHJPbDFQNy9WRHdh?=
 =?utf-8?B?c0UvUGZJeVJoT0FFUU12MVlrZ2FXUWdoa2FXR29wYXlubzh0RldxQS8wbG9Z?=
 =?utf-8?B?MDFnSlI3NmhnNGdUN1pkSXpMMXNENUorTE9DZXJOYUVnRE9yY0pyQWJoSFI5?=
 =?utf-8?B?aDNLalBHQUhHTHNWSVVVQ1lrUDkzMVMvRUJvSFNpM0NWa2I3bjJqMWNlOUpw?=
 =?utf-8?B?b0pYV2hMbC9TelFMYmFzMUJ4YkYrSVlsY0IrK3FzaWQ4ZlBNYkhOK2VERktp?=
 =?utf-8?B?bVM2aWRLMWVFZTAyYjBjYUE2NDI4SHp5ZWdZNm85aTVFR2dOVGxscFhUbTk1?=
 =?utf-8?B?ZTVtaGsvSmRhQVRKUldNUks4Y05WTncwZkZzb2ZhOU1LWXUreUVQQ2h2Rjly?=
 =?utf-8?B?YisvRExXbkFmVVVMRHNGMTF4aVgvR09sTURmZjNRWHJmTFU4cnlGYk1DcWNq?=
 =?utf-8?B?ZldhTXdnbW94enhQUC9wNUZ5aXFON1lIb1BhaU1uUXBUUWFxWElFdHdKMG92?=
 =?utf-8?B?dEdaUnI1M3JKajFhcjE5akg2WDVSQnY4QkNldytuT2VkWU9vencvZEJYSHlM?=
 =?utf-8?B?d2lmSXkrdWQvcVNHS2hpTVM4S21rVTZwaC9VVDlkYmRldGhsMmJPSlpxTmdt?=
 =?utf-8?B?UXVpSy8wUWZCWDVYMnVoQktHaEIrYmxmaGFGVlEvNitsSUJaZGphU0JvUkti?=
 =?utf-8?B?cTB4ZW9iUVZEelBEZk5ROW15Smt4Qjl0MXhJZGc2a1YvZkJnVnpkOHJ2Z1Vz?=
 =?utf-8?B?U1VCTUFGT2VjVTNIMWtEQS9YaGlvaExzSC9GYTZxRDNPc2hSaDJ1QTRqdjVn?=
 =?utf-8?B?N052QU01bTZzNVlGQndYYTZKWGFleXV1Vm1GTWhNTGI4RFR4OERPbmxpMzZB?=
 =?utf-8?B?TWg0aUZBMUNwMHpEVU9vK2ZUZjVQSlhGbW1PUXFYaUlyUS9DOUZOdlRlbFZG?=
 =?utf-8?B?djFDem1oSDNMdktyQUw1N2ZidmNTUEdGTzA2djdEL3R5VzZuQytQLzhmUnZH?=
 =?utf-8?B?bms4MjlFMjNmQ29BL1Y0d1N4anhuSS92SzIzaURuUUF2ejhFRFB4TnprVldQ?=
 =?utf-8?B?TUNCWE4xNWRhTDloNm1LSnN1RkR5c0QzNVBBV083eDJ5QnIyblZDdkxrLzNl?=
 =?utf-8?B?UFF6MXF0OEErRW9qUEhYQWt0aTUwNUJRZCtQZk9JTk5RMWR1YVVSM0pNZCs3?=
 =?utf-8?B?V2NrNGF6S2d6Uk5zc1NzUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkdqeE5tQkVuMnVpNEdHY1UzT1dkR0NEQitsUkd2Q2FQdFRITmFZRlRjSjFB?=
 =?utf-8?B?aVY3UzJoYjZmSDlmNkFoSEVLSHMxSUZJdXVlVmI0c2NNdUNCMS80dWNianhG?=
 =?utf-8?B?L3NHRGJ5TXFBSzNpcTdCTVBDTDhsSmM3YmVrZmJRTktwOERSNUo5N2I5TjVB?=
 =?utf-8?B?aGNSako1T1RIRTh0eTVucEFidGxxVVVrSWhMMHE5MkNpclBGbXptZUxGeXdE?=
 =?utf-8?B?NVhsS3MrMGNFR2M2dmV4OExBMDROTmNQbGZuaHExQy9sQit5dWxPbzVETVRZ?=
 =?utf-8?B?T2RZU2VleVpoaVpONGJjZUVCT1NXREtEZUwzdUx0ZFNyb1hRM2ZHOGVjeFFs?=
 =?utf-8?B?LzFrSlJKQ1AyQzR4VXZTZExOMWt5RSt6cThKU1dBTWRiQWVFTFg1Smg4aFhj?=
 =?utf-8?B?cWNsWVdvMG1hSTZ2bXhQNE5WN2R1TjRIWkNDUWlSRlF5SlFOT2ZMTjNvYjlN?=
 =?utf-8?B?N2d3TzhteDVINk53dkhjSmg5MWJFS1RtL0F2cEVFNjd6TFp3eUtkUjd2Skxr?=
 =?utf-8?B?d1kxRnR1aWlGS2Zocm0rUU0yd0g0Mk5BN2tnZDJoeU8zSzI2WWpHS0w4cytr?=
 =?utf-8?B?cHZ0eno2WjZMMEpBNExDVmdDS2JBK2pUMStnSkZSanRRb2JhckkyaVB2Z3Ey?=
 =?utf-8?B?cTB3d1J1NTFBQWlKUkJUb0VodHNvSDVkQVlSMmsxQ080NUEwakREZnJOc0h4?=
 =?utf-8?B?Q0tkK25OU1dnaGlob0VzNW1lR09KTFJleGF6MUlETm53emswMkNNZy9aK2dZ?=
 =?utf-8?B?VlB5NlRyaFF4ZVhjdlRRY0lzMjlQMmIyUVNVbWFFQUlDc1E1aHU0VHA2bUxn?=
 =?utf-8?B?bUdxTXZEbGJiSzJLS05WMWJqajNHbUNtd0VBbDJQZlBtY09TZTBOdVRSN2JE?=
 =?utf-8?B?VWwyYXRGNlY3REk2VEpsZURMbmxHZmQxNDdhUHBvVmdSNzZUcmJiVzdCU1pm?=
 =?utf-8?B?NE92OTJMdkwrNStMQjVZQmNETkVJZ0NUMjEyeDdudENRTFNsL29MbDBraVRE?=
 =?utf-8?B?UnVoL0U2TzNFOUJuanBETHRLRXUweXd4dThoVVVaWlI5YTlhZ1c2Q0w4Nmx1?=
 =?utf-8?B?aVVwTzk0amdXbHNnY1lETUZ4SkwveEV0ODN6QVhPbG9RSTNKTnJoMGVGSjJy?=
 =?utf-8?B?cnNTZ3VYRWpFQ1EyT0dBV0s1TEcrdk1hckw1OUNVdURJblBpckhuNjVsQnQ1?=
 =?utf-8?B?bU5LTjVGSVdka3ErN21td3JZUlpHeFdNVFVqdUs4TXJoNG1YYlpLUjZRYWtp?=
 =?utf-8?B?cjZvUW02NFg4ZEl3bzBxWDZORVoyVEVpZHc0eG9IeWFCbFh0dGF0UWpvc2s0?=
 =?utf-8?B?bXFVTVZkTis5UjJGMlRYbE1uWlpXbjVTSEk5Qnd5ZnNHMWJNVGxQaW5iWi9X?=
 =?utf-8?B?eit5ZENTS3QzWm81T3gwc2tSSUJBNlNHUTdYUUpZQlpmNENxQnBRTEZHVlc1?=
 =?utf-8?B?V2FuMVBOYXdqSkVVdDY1ZXdiMmVIRGVHYytaUlBSVG9LdDFzOE91Rm15M2pG?=
 =?utf-8?B?aHdGOEkzTTVxQVFKZllhOVVpUUQ2Yk1XZUZSclAwVXhtcE1TSmNFY2ZoNjlV?=
 =?utf-8?B?ZmpoQ0pIa2lZV01iOFphRWY0aEVyS0YvSmo0RUdXRVZMWmpSYmxYNm93TDho?=
 =?utf-8?B?SklYSmhuWlNiTTJuWEcxMnlpMm1DalNZUjU5d3VHMko4K3hFeXZpUnJ2WTBz?=
 =?utf-8?B?U1cvZkNGS3I5ZFh2MGp0VHpoVUt3RVdpcGk1Y3NaVmtxVjl0RXJlYW56SGd1?=
 =?utf-8?B?ZDJwSDg2RFZrZzJ1clExeGcyelBtRzlXRTZ1Z0JJaGRyYjc3R3BXSEdVVG5C?=
 =?utf-8?B?WDAzanA4ZndwY1hnRjdBdGdqaU1kYnp3N1drN3hLTm5NSUdOazI1YWJERFQz?=
 =?utf-8?B?c0tCa0NrYjNLMGh4MDFoNkV1QVMyRXBYNnphdm9EL2dpT013Q0dINzhyVkQw?=
 =?utf-8?B?aVRHSzBPNUdOY0hYMkxldkFtWVpXaXNScU5nbTZaNi9DbEE5cUxIalpDbTVD?=
 =?utf-8?B?ZlVYeUtrZmp5YU4vRjg2M1hPeU1jMEt2MytLVnhldnNSWGpGL21UQ3pZM1RU?=
 =?utf-8?B?WVVLRHpLV3RLRTUvTzF6dldqL0VHN0ZIQWtrZklvMCtoQmI2N2E5VDFMVTRG?=
 =?utf-8?Q?nJSCNbkWi/WEIhRIfNDYrktZE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E29A63C5524D634CBDB52505BB99BA3B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b8352-3a41-45bb-94eb-08dc6a342f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 23:12:34.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYe/14FdoktClOm76GcmdsKkVT1soz7HJkvo9/2xW+yqq8CkDFBPwEo8eAX0p6SVz9sMcyt5zArbQp8kmOJKdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTE4IGF0IDIzOjQ4ICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IEN1
cnJlbnRseSBrZXhlYygpIHN1cHBvcnQgYW5kIFREWCBob3N0IGFyZSBtdXR1cmFsbHkgZXhjbHVz
aXZlIGluIHRoZQ0KPiBLY29uZmlnLiAgVGhpcyBzZXJpZXMgYWRkcyB0aGUgVERYIGhvc3Qga2V4
ZWMgc3VwcG9ydCBzbyB0aGF0IHRoZXkgY2FuDQo+IHdvcmsgdG9nZXRoZXIgYW5kIGNhbiBiZSBl
bmFibGVkIGF0IHRoZSBzYW1lIHRpbWUgaW4gdGhlIEtjb25maWcuDQo+IA0KDQpIaSBNYWludGFp
bmVycywNCg0KSSBhcHByZWNpYXRlIGlmIHlvdSBjYW4gaGVscCB0byB0YWtlIGEgbG9vay4gIFRo
YW5rcyENCg==

