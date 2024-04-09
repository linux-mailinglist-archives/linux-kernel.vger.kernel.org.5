Return-Path: <linux-kernel+bounces-137734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773B89E677
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061C92875C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1B1591F3;
	Tue,  9 Apr 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMRjkcLv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1E158DAA;
	Tue,  9 Apr 2024 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706761; cv=fail; b=MOv4uE9B0EN8oGNcMSJB7LrBej/5N5gRzZ0B3ZsR2KBuXeYGukGjsUdbb0uPzkDI/y2FWTwfhZHTiMJMhn3QtnCCq8jrFZkFE6B2J9MAa0J/DZammW36RhuohQkKSOrKv0+jBfPt0II8wan4SCxnHz5alEFdlIC9oS2zLfH2P68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706761; c=relaxed/simple;
	bh=82/UWOssttji7WrDc7cvqHf+TZSHn12QWJyiUxWplQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBNLkSAezBL7fQtfRLc/9w7W/4eT/WirWs8BihCL+u7iWMLne9F4Y9hH2o0/ZGeacr2DJXojePyyhUhhAWl8aP2h6d0zyZBQr7lG5EYNeQjQv44eTIaqoABn0wwJHZ5lkHWcaWGlsG0x+rvFlaxZuXK8t9g/IYu66DaLiWMxeB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMRjkcLv; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706757; x=1744242757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=82/UWOssttji7WrDc7cvqHf+TZSHn12QWJyiUxWplQo=;
  b=BMRjkcLvHYENKHMKmvl2qaiJbt/KcfdEWYUci07A7UHn3Ijn1YGlGCQq
   uRKLnbwUwI4cX4dzIzkt6BWj4e2JTnsSvCE8dza5mSxTj97CZV1MOzHKE
   C6OiM1J8Dd4HtYUk8meuFxJ8U7qYbGIDwzkR6rJmA9GfNGsmFpgOt4ofE
   dDDi8BRS6WWOFca4Cm1VPyZ8LuppoFfDOifLregxzHMbQ3FF3epdEffDo
   FqgA8eoyHUrHQgrx21EVTkuOvmQycYrxCUceVKssg2BHnqNzCZ5vNDJxG
   Cyf2ptLSKwd6mdvWYjOPc8hKvBKAJMkOew/EugTGGyqL6vwgxoLaYaElS
   w==;
X-CSE-ConnectionGUID: Owj6tgl0Qh2Te0BkDvCxBA==
X-CSE-MsgGUID: d42zhZY5RJiNfPbiZgj35A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7903528"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7903528"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:52:36 -0700
X-CSE-ConnectionGUID: SMQWnGT5SOGiAPsiz8Dq7A==
X-CSE-MsgGUID: nYseLVUFQhSwAyPSWjGCqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20814191"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:52:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:52:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:52:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrfJbp+Q19cOINj5fOtXD59PZv5/EPO6sTqIK+dQrCJbCO0kIAkssDIvWCgqVDTZyAvIAzIywYYeHF4YE4cv3eOSd50bGzgjmJsy9oYp4+GR91l64FZY1Wt8rijf+6MsbkpRz52D/UrjnYqejUIlb2nQ/rTxBSR/2fj+fQbnYVqd0nu3lmBxTfw8/Y4q38V0dv3IwrfrILGr45sQpbT1kqhWGwAlPZH58tQ4o1JObBMpbUDr5IRPbBWwvl8Z1PunzVwzagYO2EH7KOLZWW8ulMTh/QAkk+x7Jqe6mc7mQu4MuqIc7bKEivADomLRUJC6EHDzWSlsantwEvGPxmidlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82/UWOssttji7WrDc7cvqHf+TZSHn12QWJyiUxWplQo=;
 b=jdcYHILgPtN1qqByif0pJkSxv/R3/i9k8ClDXybfm11JiryOIAp4Mwtgs9lu1mjyUwPh0CLFbtFZCedCY2pHRmnzgXkam0YcMq5ciQkOaPvoWKRodB/QpFhzSXsFATWz+lYh3K6E0nRRkfIf9BA8jm6tLhZ6dsuWwKcUa5J3UgUuTF3tJkJwIfZtbp/QJYfTcUMQJ+CIJq5NmKpeM721dlI607dFnxTGagU0bL5WPARu2OMdbXI2Wd/kKUVn/LKRm21EFL1zWABymmNBkWowZ2wkJArgAA9U9VqICpl6KGJxlVPbpaVqxBy8iRBNPQiYpq0oaxyVvczpkCvKwUiH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5147.namprd11.prod.outlook.com (2603:10b6:806:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 9 Apr
 2024 23:52:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:52:27 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
	<vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Ross
 Zwisler" <zwisler@google.com>, "wklin@google.com" <wklin@google.com>, Vineeth
 Remanan Pillai <vineeth@bitbyteword.org>, Joel Fernandes
	<joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>, "Linus
 Torvalds" <torvalds@linuxfoundation.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: RE: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Thread-Topic: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Thread-Index: AQHaisJ+v0vo99/TW0W5001BvMsHNLFgcvIAgAAPmQCAAAEJsIAAFJUAgAADKHA=
Date: Tue, 9 Apr 2024 23:52:27 +0000
Message-ID: <SJ1PR11MB60838302CF7A80B660B30F2AFC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240409210254.660888920@goodmis.org>
 <20240409172358.34ea19f0@gandalf.local.home> <202404091519.B7B2221@keescook>
 <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <202404091628.BEC1FAC8@keescook>
In-Reply-To: <202404091628.BEC1FAC8@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5147:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ADBSE7h7gCCxIi3+N1AC3+MDv0qzYCsYXRvzFoNXLq0wCrmFaao5xHjmr19h9HUx+C1Hi7hgCHJUnEHint0bVNSCoxUP0yTGQ6InHyE2SRTyASjR23PjrBVuBB2FpeoDFnkVErGqkBiXXKRtDDUoNZfvwuI0L+BLJgZnGzjw3lR2jR/Y+dYMkPGrRMtdFCFsC05pf4wO/UG24CimClXJP8Ed5JNTNo9aCSwXZHB7WknfYHg/Nh5h53xXi8m5LafbxNFZekIHhpNlWrEPj2tAHnNi7nLFy9J6taNrFra88PaXTpany1XpwLDCp0PLTD37GXjps4+YbfyPejK8x3m2WGdSxUDqGf+1j0Ac90SZ6OAMlTu9mKVlprZ269tB23r4A4qyUSARdmIiElJuuXf2DaPOclyv2997DxN/lCgrAAagMb15fvT1eNpJgJjRAkVzTIh1hDFPV31adurpw7uymWL3dBS14cs+fFXGItyjcXU6QtwdsVIE2kdMF1zN8dM48aZQJ4QwgTJrmOzDDzq69/R3mvsfoZS0Inhr9tVQhSLvUDAZh+DjCwLa9AsUQERyjq16/XZo+BUXtZyv3EsAvqjZPROVY2+3t+ku7C+F6QRGMEWwtR3Sk/J930rZRFCL4+n1CLbGW6Z4hxwks3qrJ7oV5mbrzIDI3LzqxnzmO4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XRHJqh1rJqNyl65FNqc92fppWgrLRrPldFXFOB7ZN65tCbti4f3PhLIRFmrm?=
 =?us-ascii?Q?qhDxiTPrwPFkDihDXMYo1/xd6fLrzD/O2DhOfShWP3wz0NdCTS/69CKVy9aA?=
 =?us-ascii?Q?uHWoViA4zL1zZZ8YPBdEM0K5ja212f8fpFhebU2lUmWRwJL+rgEs8LgRoQt8?=
 =?us-ascii?Q?+C73G+aT0JWjh/Gjo2R42PfP4amxvAcJfkNmTl36V36dDNFWzuMZ61PoWovZ?=
 =?us-ascii?Q?9uZKE6wfc5jir5LPsOeIUwFft1AVnKw7fNdXQuhQ5e1WNiO012Cxgi1GJU64?=
 =?us-ascii?Q?0sv6iBp772HJZA+pKIfYnpVbgoJef9NWhLVD/0MgRi626HaBlSDk1vVymRop?=
 =?us-ascii?Q?DabFZcl4oEKRtb+g1XA+29Br30N1r3Qpct4ml9mkYBAoWEDTjk7BvSN9W48W?=
 =?us-ascii?Q?hYIqYZNhQxK6P1JyGqL9M/OoKas00jcO5aS52HjPtpxjQfhAPmOYqV6EdwKN?=
 =?us-ascii?Q?bAFn+dMuWi1qW6AhFfyg27A0RabprXRM+WXOLcb2DAw1puUtq80vpKfruki0?=
 =?us-ascii?Q?fOMe0ONPWPBL/J+piJRWc7LX9QdJpntLzI4N9IWVRrRJZl5xRNJuAhA9z43n?=
 =?us-ascii?Q?WqE1A4S23raN//r8TDSw6hQQewoW89pPxI43Ag7YD11B8X3QDelA2YI2DEX1?=
 =?us-ascii?Q?02XJSSodlb6ccHcTEi9L/f1Bm0c936lNAC0b1f0tpm1rApvrp6c5g3mHKHAM?=
 =?us-ascii?Q?wmzffYdxmQEBJ0g408cbOApKfMONk2daGgVkrIDA7CSeJZyywDbitOaf8u5/?=
 =?us-ascii?Q?OrK/KMp++B4Kp8udz/nBIfpEEaLdRoD/+ksNj1A5WfswXJ3421AK3PtJw65M?=
 =?us-ascii?Q?rsjJuBeCX8/DFB7fzfBOLuqHrcvGhvczBzEezE1VrmfkSA5xOXt+UQjzimaK?=
 =?us-ascii?Q?c1G9XJb0EhjX4g/O+EPz5yfdkWZeMX3h7oEvD/wt9MGPiWekm7IDqAu7AH/q?=
 =?us-ascii?Q?lXMdG8AbWAU3ylRE7xbvL6WMNQ3IG+5TIUKeHi1ROahIVNMAyPo4bvIkEutS?=
 =?us-ascii?Q?lZilGYvCK3D6nBtpPCKvx/s4TV9scUo8IHFJDKCLMpwqCnQdrqcIAtaHiQua?=
 =?us-ascii?Q?pa1+I21Jd7uNFUEHdIvNsXhaM60TEl4DCyM7r29sdmNOhqx6Re8S2pSAeI5c?=
 =?us-ascii?Q?Tq4RA6+VpGT5kKsIOwHnjax+4KSdfmW0ia7SAouDwo99MD1+T+kO6ThQvs3K?=
 =?us-ascii?Q?J5ozQ1A+GSkCufnEsV83JYfXax6BxN5J+qIKG3PCfxF3KNRMjCdEv/R8dor4?=
 =?us-ascii?Q?wkXXF9QWyk0l1R8ZVVcDeipmbKQHa7dR6YpjgWKbNltKWBxoGJITHtVhmdl+?=
 =?us-ascii?Q?Ra4JAYS22RqwkF95hrUKWxK8k8M/Y4WcKaFfSGCOFsX0BV8i9M9qiKS/eet+?=
 =?us-ascii?Q?lLCNbcbsmP9zBUi/8/1uoMA4KlmwlQEsw9zf/AnI7icxDK/uHskhm0OzLqGZ?=
 =?us-ascii?Q?GrsGXZVFEHh94XzWE4DnUVoVaiiV/DXmoA5W080q6rZiTXnnMSMUle7Y/yqf?=
 =?us-ascii?Q?PeAS6KUKanPpIvGD7IKezHjFXBe+62+ibKiXLPVOWscIUXcLVJeohucE3GJL?=
 =?us-ascii?Q?81W08FeA5eltZGRswDr+/65MZkAbSYjgINXBI/LO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3770a1f2-b632-4687-a9fa-08dc58f01cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 23:52:27.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F05yrOI83QLIx6bZo6HH46pWmZxFxuElBr5rIGHC3TEER/4wierrybOnPXbQNswl2xouE3hEZzBKWP6S8x/lag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5147
X-OriginatorOrg: intel.com

> Do ECC servers wipe their RAM by default? I know that if you build with
> CONFIG_RESET_ATTACK_MITIGATION=3Dy on an EFI system that supports the
> MemoryOverwriteRequestControl EFI variable you'll get a RAM wipe...

I know that after I've been running RAS tests that inject ECC errors into t=
housands of
pages, those errors all disappear after a reboot.

I think some BIOS have options to speed up boot by skipping memory initiali=
zation.
I don't know if anyone makes that the default mode.

-Tony


