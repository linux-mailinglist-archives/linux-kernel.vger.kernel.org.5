Return-Path: <linux-kernel+bounces-162098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77248B55CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E802860CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F33CF73;
	Mon, 29 Apr 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NojWQOY7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6B3A1A8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387802; cv=fail; b=bRUhDKSXyTB68Z6UI3kg9uNp2jzntzL9LxVXC2ifSv78y9EbVYUsXgAZ7sXMxrPYRcSWhDFXvX2mFExdRBv91SQyZosTr6nKnpYD7dCKKtg7vPSgWD7ko4krmcGSg1ci+Q7OqnJdfBj+LUsXDHm8fl5bZFRoB7jZwvMoO6YWWCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387802; c=relaxed/simple;
	bh=RTyg49QEeG3s4Vtdbze/wT2l0jJwILZMhmfh2Mth2MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cR6oGU1yZ1ZKzmO+VC7Td4xVmlpft5zSQMXWLcl/v6ND8MmfHLkmMoVvnrCiAnsRctJb670eivUP8DaZGCbYoX2ErwZACt7Pbbglx4Loi4l5QerKp6+IzUX5QpOH2tRoFL9JmJDL0QJI3QXcmvZd8/qKp6hhcU+1yXMURW4/xBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NojWQOY7; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387801; x=1745923801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RTyg49QEeG3s4Vtdbze/wT2l0jJwILZMhmfh2Mth2MY=;
  b=NojWQOY7fD0Ofb6c3vIaY4pkaOSDm5Ll0kjhjQEvhgd4Vul/TKeQVMfk
   qu4TcM2vn4DePZVrit94Vrz1Ze9QDMIR5gBYalJ92i8LDsAIe1AMIGPs1
   dNPaEL2pR136dqsWWPm6ENUjRlNwB26EDef6WIgSZqHTvOcj48nF07yNh
   r3ZZj+8XVE1dEBjnq9+GKZ4G+CCuPdPNiEMTDtgFY+CJxb9MgTHnxDVf4
   /MU03nZkHEWPintMobBGeP6Lv3Ot6pX4cqPX31Yxcz5bnfSbtGJ4rw3zL
   iMQVUnH0SdWzEqt0iJdpf6zSiIjfG9wJ7Yd6q2N53NT9GomsInllXIDw7
   Q==;
X-CSE-ConnectionGUID: 5M8GI2sPQO6U8aqPP4xZOg==
X-CSE-MsgGUID: nJSyU1cUQGCwH3FWYTwGBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20729611"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="20729611"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:50:00 -0700
X-CSE-ConnectionGUID: zRx99GVhR56V7Kamc0pIIw==
X-CSE-MsgGUID: wSRp9zPJSv6jyRVEwMSyxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26067823"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 03:50:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 03:50:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 03:50:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 03:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXmt/XGpJQmu0HKrWQQr8V9yvpuwCSI11RlHQjGGJThTWrV6j/ZSnhly13oa/wNsruLpdOFez15M5/6s1V68b2/bc3JDqvEOYy/h6ujPMD2YElAS0Rb22Q3dyN0kGZUbqd5roN8jCFugiKAAn8fqRfI4rqSVj8J2d2m+Dg/xaLe+vd9hjtLPd6MPk4B91+v7oKMamUHrApL5/G0DZgdVHIM6Gchc90aUyLTNNiG0b7/ANqc10bDoBxkwN2j3Vi1pVctCpycS7pyaybWjwsJJDlmfdFvhvDoIUXlPketFxjKnuPNxxFdbS94+RVeHNoDiIgD22QRpFztn8lC3tJtGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTyg49QEeG3s4Vtdbze/wT2l0jJwILZMhmfh2Mth2MY=;
 b=cxS1ZLud4bPrhrSTiGJI5x8tWSQ8YWGCST5LN99pFxVqK6lZB6v/9ev7ykjj/6k2gLlf/vPwOgE3KNr/GbFQQnxhT5NkQaN0JYVLW43IdCy4BzXiaSZ6e5z1CQdQeHhnXL1zx5XAbcKocOX9cA2xW5tylH5pPoNbuUArt7fBDuT1Fw9MthMMhmTmE27BzV0n78JmUYLZQ/tZuDrk5ByMjPr8ybSRQOLDr/9rLnVo7f483xYysdVcFyj3sXdW/9N2EBTNkh17QJ9tqeQRaIsBXBOJZ+9BHvyCoFuOknKx1yQ4QZ6rKZeM9t0X5oScIzVjkaOlnsmZLFBJ79cOsIRmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 10:49:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 10:49:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "Schofield, Alison"
	<alison.schofield@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kai.huang@linux.intel.com"
	<kai.huang@linux.intel.com>
Subject: Re: [PATCH 2/2] x86/pconfig: Remove unused MKTME pconfig code
Thread-Topic: [PATCH 2/2] x86/pconfig: Remove unused MKTME pconfig code
Thread-Index: AQHal5HISgqwEmRol02qAXZoCzzg87F/Fs2A
Date: Mon, 29 Apr 2024 10:49:57 +0000
Message-ID: <1314b726ac899a1c492c0753e27dbb3ae5a29c4c.camel@intel.com>
References: <cover.1713929290.git.alison.schofield@intel.com>
	 <029c84dd5743c8d56734593455ae3d576387f72b.1713929290.git.alison.schofield@intel.com>
In-Reply-To: <029c84dd5743c8d56734593455ae3d576387f72b.1713929290.git.alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6523:EE_
x-ms-office365-filtering-correlation-id: 76fe4a9c-f830-4dd6-fba5-08dc683a1cce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SFVGYWRWQ0lFaDJuNVhEelZIaGdZdlpRTlJIeDZ2QlBURmd5cURjSkNlVTBZ?=
 =?utf-8?B?eUpVVk5OUGpOeUhyYXRGSzdGVkVLZ1pWZkF2V0RIL1M2Tk9XR092a09HUmRs?=
 =?utf-8?B?SUt6QUlleGgrcHZoSUlyRVpORnB6d1Frcld1UndQSTJBWHRvQ25BZHBkbW82?=
 =?utf-8?B?WTRBSzhxaGlpMGVFN0lCaUFMSmZWQ2ZtSmx4aktWK3Nwdjh2WjRaSTlWZ1hk?=
 =?utf-8?B?NUVsVVJsNURuNFh1elpUTmh0WVJGYUFUeC9PVXpVNjdoM0ZJU2xTWmJ3aFQ5?=
 =?utf-8?B?YllPYTlNZ3ZBSVhRcmRobUlGUllPcitPNVlzTTlOSm5GQ3MzOGpiNlA3Zmty?=
 =?utf-8?B?bFpwSWpiVStSa0s4aW5BMk16Vnh3MEJNV0VONGxWN1Y4ckpiV0xXeFpBUGdu?=
 =?utf-8?B?Uzl3RzNwMURmd25TRytDUmRzaWZhczYyM2F2eTV4S0hBbHJRb2FNRTlvc3Av?=
 =?utf-8?B?bjVqM1IyTlJYeEVkdmhHM24rbWt2QXE3QzBUdG40YUpYMkcyM1ZyaGdCcEdh?=
 =?utf-8?B?d1pGR1dWQ2N6TTlQeFlZMDFyTFd3dkdYd2FwZjNVUklIWTE1TzFmczhEa29i?=
 =?utf-8?B?RTlUdzEwWldWNTJSMFFIUzhKNzdIL05DUFVtNGpYMWFLcXdZdi8xbWZuSnls?=
 =?utf-8?B?eEtXeFpSbW00UndXMkszcXpWMFc4eFN0Z3BpRTVsYmNRUUhCYnVvd0gyamt3?=
 =?utf-8?B?MkJGc2VCU2tWODErSGx6ODF6c24yMVVpS2FBQ0FrNkxpTlIyVnArYVFCWGhQ?=
 =?utf-8?B?WEpybWdBUHVYTzlBMGl1TFNLRjMxSDVTNG1MTzdjTXl3dUk2YzhhK25GanRW?=
 =?utf-8?B?NWdOWUFOaG4vczJKVnVCQ2lxb3JqeEp1aE1iNkJlbGtCV0Fmd0o2NDFGOGpT?=
 =?utf-8?B?MWxwd3FWTk5aZHNWRVg5YVhPUzR0NmxWd254T050aWxlblQ2dmxjLzBrZmph?=
 =?utf-8?B?djlPQm5HK3lMa3ZOMGM5emNJakVjbUI0KzVxUjNiZGZNZlpkZllLNXcrb2Y3?=
 =?utf-8?B?UTVxd05KcGR1R0hycDk1aDJ1K0hOUzNZd0pDMkVQZXFYR0VWbDdVRTZmOTFF?=
 =?utf-8?B?bVZLeG5EcXV1Z2lqbTg1OVBYVEpPeVhxMm90b29pL1BMa2Y5S2g1alhBY3R6?=
 =?utf-8?B?WklMd3FQYTg2OThZYUJmNFk2UTA3RzhYWDkvUDQvL004SFllbG5rZkNkcllJ?=
 =?utf-8?B?aVJxVlpzZVRZbGxod3hDN01oUExtMjVqVkJCMDBIMnowTmNOVVljY3Y1OEZa?=
 =?utf-8?B?bHM4bTUyOVlUMHE3amlNMmpXUldpSTZmNUlpY1dvdlAvTnhVZE1Zb1FZZnNP?=
 =?utf-8?B?WEtINENtZ0RBeWExb01LajBtZTBHRHRRb1RrdXdQdFEvLzBJRjdBanBiR2hW?=
 =?utf-8?B?YWNVWHkwanV5ZjQrZlNuSFU2bktLK3VTdDBpOEJqbEdPQWJTcjgzU1lhL05M?=
 =?utf-8?B?bWk2RGQ5Wlg4TXpFUDJ6L1hJYlF1TEorWCtJQ1cyRlNTZ1cvdythZEZpU0Vp?=
 =?utf-8?B?dG5ueG0rTENERnJVbEVzdzduUUlqZU5ibjE4QWZTOTFleWxIbXdoVXROTy9w?=
 =?utf-8?B?UHBBVFdWOEZUM0l2QU5qMU51dnhKSWl1TTZIQ1dtbjlkNXp5cWlYU0Zoa29t?=
 =?utf-8?B?V0swK3NZdTNWbWI2aGxWWVRoUVZZZHZmZ3dHcG9PSk1TaVAxb1k5N2EzWDhu?=
 =?utf-8?B?Z0ExWVFkcXpvSWFpMkd4T1B2bmUrWUZmc1pkMkVtTVpWM3dQamFlTExkTW9l?=
 =?utf-8?B?YkpHeVdjRWVYRFcvM2FqM3FTRUwyNEVuOTNQQVNQSjAvY25nUTF3dlRiT2pY?=
 =?utf-8?B?MlBReHFza3U1bnRVY2FLQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1BZWFgwQ1R3dEV4Qm5nRU1pWVJ6azMwaGNYTmxBSUNUSTVtamRsVE5yK3Zk?=
 =?utf-8?B?TkovZEFWckMxaDdaVHdhZWZrMVg1OTFYeDV6WFIzV1lpS3Z3aEd2YllYNkFK?=
 =?utf-8?B?NHhOZUVQOGtVTm56Tkt3elhreGhlQUJick5rWVh4ZGpObWxzdGFYcGtjcjM3?=
 =?utf-8?B?Mm9oTWY3ZWZUKzhZVTM2RklXMzdWVS9vaTdiYUk4aFI5Q3NOK2h0OVFtbHpu?=
 =?utf-8?B?QXhZV1luNUQxRjV4OFJqVFJBU1BOdCs1eHpSWXRwSEEzbnlRejU4QXNPL0Vl?=
 =?utf-8?B?aHJvam1rOGJESEVIVGdwRWhhMm9YSTZDbGUvUkFERnptRWRibTZuQ1Y5SEhP?=
 =?utf-8?B?bXNlSVFnTU9YVXE5WkNibnhRMnl2STBrWWFkT3dFOEdpbHh0d29PRFJ4SDVv?=
 =?utf-8?B?L0ppSVc3dndodG9NMkhOc0lFQ3ZrcG1na0tPZFRodGo1V2RNelowUjQreTUy?=
 =?utf-8?B?dms0SENQcGJtem51eTc2Y3poOVpoVWROVy9kYVNhbmEyT2dwRDJyTXlUWWVG?=
 =?utf-8?B?dVdIbUtIL2k1blkwZjh4b0VMQUtWdCszYlByOWx3ell6bEZPRmVSbWNJVHhr?=
 =?utf-8?B?anpLY09MVGpnVUFUbjd4dUFUdmRqb3NuRFpGaTNMQzF3SHdiYXNGTmdBNVIw?=
 =?utf-8?B?RFdYRDhXdXNDaEFTMlU1M2JwWTE0b09pNWJSVjcvbS9QcUoyN0FmVW1mK3Ux?=
 =?utf-8?B?bEN3Zk5xek8wSjdnZjhxWDU1YWxhM25Fd3YzRVUxSWdzSmlLdkY5VXZYZWpW?=
 =?utf-8?B?c1M1TG5JbmV1bnlQbkFPdjVKTnRDam5NVE9JVVBLTzZNTWtKRG5jQlgzZWNQ?=
 =?utf-8?B?THI2SUZXclFZNk4vRVArdnFjOFl3MlMzRitCWG5mRzFVOEpGN2REdzdUTjJJ?=
 =?utf-8?B?d0RDL0tDM05WNy9ZR25IaTBDU1c4aGt6YnE4VGgrZlhsclZFM2JYdXd6Y1JE?=
 =?utf-8?B?M0xxK2JUcXRjY21pS3d5a1V0WTFDS1RYa3YzQjVPdEU2bUdzQllQMlpQT3l1?=
 =?utf-8?B?QmhORXdmSDNaNWswQ3VjcnBsbEZubnZVZWwxRTA1M004ZDRIazFndUd4a3pJ?=
 =?utf-8?B?QXpxZEUxM3JXQkFvdjVueUNIci9SKzBDdFJma2hxbnRyY29yUFFIejcxUkNq?=
 =?utf-8?B?b2NhV2RQc0FuMXBwWVhlbTNYUCtBWUx6Q1ZZM2RoSlJsU3FZbmRKZ3U2STBQ?=
 =?utf-8?B?a1VYRUZKQWdsaU42RHQ4Y1h4MTVrem1yYU1oMEF5REpvNVorY1g5ZWMzTC9p?=
 =?utf-8?B?VEJUTVFVdlNINkpHOGhpeHA2bWUxb3dNMUhCUExXb2ZXOHkyVzFjZGlTdTZa?=
 =?utf-8?B?b2d1dFk1Qy9JZFB1MmFIcllFdGVpdGdMbTc4RjdaQU4vYUpLNzJPam9yNXN0?=
 =?utf-8?B?bmFTalM1L05UYXJrNGxwMUN4VGdOTWRZZXltTVgvL3FMTWFZYy96VTVXSzZk?=
 =?utf-8?B?Y2N6R1JzZnpQSUdmckYyMVpQQkx0UGR3WVBDa0ZOSGZoejZpclZObHNsUjdj?=
 =?utf-8?B?NUswcVkrRExvSC9KU3loUU54UnFvTVEyOE5ibFY4OU5mZWtaeTBuS0JRaWIv?=
 =?utf-8?B?MWFFWTBTZnJVS0xFMmJaVEZidGhWcmRTSDIyNmNoakNzeWdoMkhzbUZ4NXhT?=
 =?utf-8?B?RjJQT3lZYlJLZ2ZsUkplejEzRFpwcndLekFKdUY4QUMrOU92UHVFVi8zTEdq?=
 =?utf-8?B?aW5qZXRnc1BrekUwZzRjeGhwWGZXYmRnODhDWFRmN3AwYlFRNmJQcmxUbHd5?=
 =?utf-8?B?eHljdHJwdkF1cWhwdnBUTzN4Z2FGZVJ3bGRMdGRkVGVVOERISzBKWlFUbWpw?=
 =?utf-8?B?MlBDUER3djIxUTF6b2ZnUWFqWFpSdndEMXUzWDhhN0MyRGJhRlJKeFQ3cm0x?=
 =?utf-8?B?NmpGSDJWTEpsVFRISUxTQlNYOFhoQUhORlVsVi8vUkFSc1VreGhGekxzN1Yw?=
 =?utf-8?B?anlibW4wOUNEN2l6eW1WYWZHSENoUHErY0wxQ1JEZU1SV1hDNWN6YUtxb2RT?=
 =?utf-8?B?SzF2YnJwbGN2WTNSRkZlR04xdXFSUDlTbVZUa3BEdXQyV2ZDajRBdDR4UHRL?=
 =?utf-8?B?UW0ranEzMFRPaXJ3bFlMWkppNi9oUEVYYldKVGRBQVJSV24rcG9VaG80Z0Mz?=
 =?utf-8?B?V2pYVlVRVnlCUS95ZkJKdmJwMW9vQ0dNMlBLOTJ1eGRZTkpKNnh0V2tiOEs0?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03520E50AA33A04F93BEC119312FB900@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fe4a9c-f830-4dd6-fba5-08dc683a1cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 10:49:58.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvE9bFtalNfsPDCwfS1crL/kAv+UiOwTn7GE/YXY6qLzTIChNcIczP7qvibbe7Xla9gx5ZJxiVOGSrG7t3DvcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDIxOjI0IC0wNzAwLCBhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBp
bnRlbC5jb20+DQo+IA0KPiBDb2RlIHN1cHBvcnRpbmcgSW50ZWwgUENPTkZJRyB0YXJnZXRzIHdh
cyBhbiBlYXJseSBwaWVjZSBvZiBlbmFibGluZw0KPiBmb3IgTUtUTUUgKE11bHRpLUtleSBUb3Rh
bCBNZW1vcnkgRW5jcnlwdGlvbikuDQo+IA0KPiBTaW5jZSBNS1RNRSBmZWF0dXJlIGVuYWJsZW1l
bnQgZGlkIG5vdCBmb2xsb3cgaW50byB0aGUga2VybmVsLCByZW1vdmUNCj4gdGhlIHVudXNlZCBQ
Q09ORklHIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlz
b24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gDQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQo=

