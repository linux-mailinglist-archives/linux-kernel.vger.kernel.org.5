Return-Path: <linux-kernel+bounces-151901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C538AB584
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250241F22434
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A513C816;
	Fri, 19 Apr 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2zSs67+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63A2206C;
	Fri, 19 Apr 2024 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554377; cv=fail; b=o7rL3DM2+R2MzzGbfWVRBImSRscw1lCBVZQOQnVWdGoDf+OkpXA1qeBL4QnnQhrM2jL6yN8Zi45rted4c60NFtVCQkCj7evHmTDwm0AjVNW9D7ch6Xg34BEOatfy6r14OwrOyIZe67PKSm6P+UDaR3fFlPaZIaW+UWOve0wtPQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554377; c=relaxed/simple;
	bh=4zjFI48VvWC8+oo7ahoXRjRoJDPE0LEA0JPSeW+VP4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2vIK3UqH1WjxWJmVwW3recALyYVsXgGtrvMy9eHkRR7EcUOIhATKoDNDHWTrj1P4KC0l+9p4fgyjBqj4TpXTCU2W+GTefyrTAxJrAE0wHgdhGy2h1YZORtuOWyuvPn8zlELOORSrsZyu+iFAadVi6THDKNwBDDRFkCgk4i0DSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2zSs67+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713554377; x=1745090377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4zjFI48VvWC8+oo7ahoXRjRoJDPE0LEA0JPSeW+VP4Y=;
  b=Z2zSs67+1t0TFmUdvLk7m6mZjd0tUTtp6JcFnhlzgVGKPUyJiZqnZnbh
   L3vaTOy8kseL2MRCvpdy+d7gGpJIbBWVA3iLmw7kVWQNRzJ3mC52stl7a
   0+MDlSpaHswzX565UJfCUxo6LZQHuKF8cW//eJ8nk+SsAergc7fQgmuLy
   lga+ZaHqg5NaXRUT5y7WKubVacJCqs2yIuy+mZnhMd8JnBdgJ5nyEqyDv
   WOsdgAv6XUY6Mz/1raXovEQk4YXR4RV2B4fStzkSiYY+huk2FrcWKGaFy
   EhZJPHqi0a/YazucsZCmECH7h+Zll7I4jHZCiyrgs6XAn2Z1qyY+0l6TL
   w==;
X-CSE-ConnectionGUID: yqQ0ChZIS7+6L538rxpslA==
X-CSE-MsgGUID: QkR7+IgcQ5uEhUtCrILTww==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26688655"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26688655"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:19:36 -0700
X-CSE-ConnectionGUID: t7ylD3RyQ16F8uBEE2DL8g==
X-CSE-MsgGUID: oJCc8HxrTN+4gizeoICwZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27956734"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 12:19:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 12:19:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 12:19:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 12:19:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 12:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9G31WcA7zl4JGPnoIrkDgXt5lkr7K9I2qhRXIeW93pGKIQKjItOIKoD4JRtbwmKWkPwubpcrLhqW/ULeM0aVO920KwFiizFCugQdrDLxnHCd4BZVNNZNXRMP1H6gn1+PUxUQfSP3QeY+bbpbWSL2rlT1BlCg1VSR/Aiv+JPq0Uw8ogo1ZbrvlWumHQKw0ivSt8562uNcdUHXgyio8+xC67WEO5a7V7chXQe1NA5qhmzf+TWbrXsrGJ/MkvCoS5A3dnK5UPhVwPW9IpiF7Xjf/T35mUmFLv/x9BOb/4Bj7MtkRhJF7K3eMTkAeNoBj8ogYVpnn+B2BviJca1MV6lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zjFI48VvWC8+oo7ahoXRjRoJDPE0LEA0JPSeW+VP4Y=;
 b=XYHEh4LjBKTU+zyp/1Z+FSpvktxwnguzen+3X08Ex8ORUs9YhQpRPOgqDU9D2NO++RddUrA5vnP2ybvskxafxeTXvt8u+4TTv5vsOpto0+bGRGnZxNTPpTSHeOgAbofGtxtf0JSxsh9Yj3NaSkG5b2wiFxAjgK3BKc4ZdTFdUn960hi3DR8e63nuwmVVaL8Jn9NpMstQUYVjkGmb2Qp22S/k0pBaKFJ0g+v4GYfB2mQlEPHC+2oWX852CKjhCQnIbWZSPtjeupWJZ/T+JAjT7aWpnYCMXsIpQluoP36AQq+JJncxoXroOaI1O5Vq3tvMa+XbILS4mQwCdxj/2r1RzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12; Fri, 19 Apr
 2024 19:19:28 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b%7]) with mapi id 15.20.7519.014; Fri, 19 Apr 2024
 19:19:26 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom"
	<trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Topic: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Index: AQHakdeskQoReb334EG4W8nSL0W2eLFvlguAgABjQIA=
Date: Fri, 19 Apr 2024 19:19:26 +0000
Message-ID: <ea0bb8be541a812ebc037da0765154d10c212878.camel@intel.com>
References: <20240329000429.7493-1-peter.colberg@intel.com>
	 <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
	 <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>
	 <ZiJwe1hgizRkWcdo@smile.fi.intel.com>
In-Reply-To: <ZiJwe1hgizRkWcdo@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SJ2PR11MB8449:EE_
x-ms-office365-filtering-correlation-id: 5196b0c9-1a0f-42f8-b082-08dc60a5a0f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: lzyYnk6v4WJX1qu2lVqpsKKm7pVKumPSrm6qQbjABa7MmhiJqhJOTCAgq5XzP3RFXVDH9eR5dW1JOWyCA5zw9G2Lo7YQjuvtv8Fkur2duyT6c162ch9euvDC7czmnQzZADQBPr25JXXLON9aUsOFC3VGYIMjfkArxPQ7iPWoIc5B7hCsLVuLvYklxKXRYPHGefgw/7fm7zhVaoLnjz/ljJtmdPOKcCbtMnH6ZKH63hcb5NAErGBKGCEPFV6iPxtyiljfOFJR3RKOuLv19moiocVC4jUBQXCLH0+DvfkwpjBnSv9q+6vdryjX40ChubRnkiTxcLoKWYr2+oNBA5a894ys+VqWSfawpiYHTodgQRXU7dn+otMVvRIQP4avKJdEP9kG/C4pDtXnvhIRc2QhqIgiGRo9lXXhBkEWsaV1UraWrLi+Gl+EHjmKUsZya/kzRD3K+W7no6Z1eHOhhGXbsbZ4bUR/jnXiEtStxyVbc6VNx8lB3gZS0oWeZJl5BZjFWG1Toh45tyrQzaS+5QbBtuqCIbgDQs6n6OTxrn260fbrneabbX3CVGexwJvZXU1fmDqIGmv1r+kgQKHF5FaXkIMyNmUuwfGkxxmGnWoywmzTb/c3p57gXMTOqPTbJ2Oy/jndJCEqV6TLrLAD1/+JrLlB46jdo5nyVZ3cZLZDkTYFcB9HGkdYxtZkpSLco3el0ddEoumL2aAMIiJxqi2TLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXYvN3ZtNUNoM3Y4d0M2V3h2S2VFN1NPN00renppT2duc21Dd2RTVHNiMHR0?=
 =?utf-8?B?d3hmNEQ0TmsvWW90bXlJWUR4UGt4NnRqMFphVG5VQkdRNG04ZGloT1R5RkRs?=
 =?utf-8?B?N1J2cG8xdGE1RmdHeWs3TVJETGZTak8yVVc0WUM3NE05OUNvUk9aczU0eDFK?=
 =?utf-8?B?MVdxdDQ5bjF3Y2k3M3hjL2pJVXAyTkowQk9peEhzM0xIRnJpdThnYTRoaitS?=
 =?utf-8?B?Mjk4dENmYUU4ZnR6WUNWWFZxS0kwdTRNN1BEUnBNYnhTczVpV0tLd3lqSVZB?=
 =?utf-8?B?NjJiUXQzWlBKY2xwbno2blhPb0FQWTBoSmtEelVlVkQ0ak9HRW9MNDVtVEEw?=
 =?utf-8?B?bnQwUHVSVkhkOTF3NWFJM3oyNWdZeVRxWTFnaWdEaFZ4NzFpNm45Nmo0a1FO?=
 =?utf-8?B?R3ovTzhSK25tLzVHZ2R1TExscjBIRm1UemVEK0wwZXBWNG12S2R3U3hHc3cx?=
 =?utf-8?B?ZHJxc0VKQ2V1cFVHbGwzSE5rQ2dDbjl5ZFl4dWVoaGJEY1MvWlBTWGxDYzhn?=
 =?utf-8?B?SDBsSytDcERId213T0U4b3NJb1lKY3o2cnFySkJxSVgzNVNGTUVoTW9nclc2?=
 =?utf-8?B?TkswRVBONFFFZWc0WjdSSEFXeXl3d1B2ZlBES2tPOTFkUnIrZ3NuVUNZcG5F?=
 =?utf-8?B?QlU4akgzKzVVVW5VaUM1a2tpSVVJRFhQeUR2cEpieC9vUTdLS2Yzb3g5dkFI?=
 =?utf-8?B?cyt5Mm5PbFdobHFLeHdMMjE3eWs0dDljam5tZnR6MkpXRE9OU1VrZzdQcDJO?=
 =?utf-8?B?eFhmRlV4bjlRUWdXS3pCS1ZpQnhMdE5MZFVyNVMzUHRuWVp6S05GU3BjZGJ3?=
 =?utf-8?B?N3BXRjBaNVFmWTBVTUdOVkFwRjVaQUlGRnh4U1pkWk9JTFFiQjg5RkpOa01O?=
 =?utf-8?B?ak84dndZMklEalpESmVuZkZjNGVCcy9sYUp2SGJveHNYelBJcHhMY0x2TnBP?=
 =?utf-8?B?VThNUnhTbWxnOTgxYmZCbVZPV2xZZlpJQThPWDM4cFRPazVHVG9STFZJbnN3?=
 =?utf-8?B?Q2dSU1pRTmFpQ3hxdTBoTEx6U3FlaEl2bE43SkJsYStVTEZBZHZLWDFQejhV?=
 =?utf-8?B?VzJOTkwxcEl0YU14WndyOTNRYlVwNXdXNlpqY04vZVFjUGY3Z29UaFlwTjNo?=
 =?utf-8?B?T2VQVWd5M3pRWWJ0VmdvUGxOSUtJTXRtNFIzS3RpQjdsWTE2RHg5Y1J3ZCtG?=
 =?utf-8?B?WS9yTlFrOVlESUI2NldhZDQ0RXFTYkRsUklXUlRtR2pOVnk5SDMySE04MWlN?=
 =?utf-8?B?WUVmVVB0dVNTQlFVVTBWcHI5bU55TElJYUp4YzRrYm5zQ2lvM3JUMk96ZFJM?=
 =?utf-8?B?STFkYzZMQkQ2S0FabGJYbzhuN2ZQSThhVFBDTlZ3TDFPQmlJNytybkthdFNn?=
 =?utf-8?B?VkdBanordlZScS9oNDRCaTJ4OFBkclluTWplMmZvNE95dlRuYWlnKzV5bWZr?=
 =?utf-8?B?VWtjcW5YbnBzZ2dNSjZuL3VTNzVGV1FqZEI5cUdvejhmYjF4Q2UyTWlnc0Z2?=
 =?utf-8?B?RlMwRzl3ci91VkZvc2pPMnpsU3QvR1c2VTJYaDRBelRacys2SDRTWU1mbTlZ?=
 =?utf-8?B?NDdEVVhZSjQ2eXBFWEdsMkN2R2d0T0RnT3k3ZHFVUkwvMzBablFSWmwvblF1?=
 =?utf-8?B?aFR4dTdhZmgyL0RDZVRhcjFVL09hRm4vYjhjT0x4WW8vc3NPNUFzU1ZvbXZi?=
 =?utf-8?B?RkIwMHBqN1JlT1lrOXpGdnR4cVVGTXpvdHFYY1BRTnZQYkEvVk1FUUJzdllt?=
 =?utf-8?B?QUFYbjN1VzNqVnV3VUJJVnFndnNLdjJXaHp0NUlFTG5tUzc3RDRER3YzalZB?=
 =?utf-8?B?ZEl1Nm9sOXpqNXRhU3YvOFlsVS9mVGZLQk9CUnFPSEhYZnZ5MFMzVkx2OU1m?=
 =?utf-8?B?bWFreGFINTh5Wno1NHNBcWNvMFFJczdiR0NNa1ozdEhPL0ZodjNOeklBZWNQ?=
 =?utf-8?B?WFlSa0RuQ0ZoSUVaay82L0VhSEplc29oN3loNjFRMVFMZkpQWW40NWRSVG01?=
 =?utf-8?B?LzdjckhvajVjblZkbUZ1MThRTGVYamk0eE5FL2lPRks5L3hmRnFnTkdObWov?=
 =?utf-8?B?TzhLMVpVdVhXejRWMzJ1L2FaRGFlUjN5eTV5Wkc3eEdnYlFXRlFKalBzRmpv?=
 =?utf-8?B?TWdmQnJQYVZTNWdOSVBLQzlSRWd5Y1N5bytsSWZJbERGbjg3RFUreEs1Nkdu?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EF5765B5265104E907C58BABC303CDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5196b0c9-1a0f-42f8-b082-08dc60a5a0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 19:19:26.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+iOeU77Dwh9O02OESzuMe8ENSCR/GkYMuKjKgGL9TmlnMQ1/x4HzzLc+O9n00kan8/JjDOEuVIy1GdaTC4LdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTE5IGF0IDE2OjI0ICswMzAwLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20NCndyb3RlOg0KPiA+IE9uIFRodSwgQXByIDE4LCAyMDI0IGF0IDA5OjMwOjQ4
UE0gKzAwMDAsIENvbGJlcmcsIFBldGVyIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjQtMDQt
MDIgYXQgMTE6MjkgKzA4MDAsIFh1IFlpbHVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gVGh1LCBN
YXIgMjgsIDIwMjQgYXQgMDg6MDQ6MjlQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90ZToNCj4g
PiANCj4gPiAuLi4NCj4gPiANCj4gPiA+ID4gJCByZyAtLXNvcnQ9cGF0aCAtYyBkZXZfZGJnIGRy
aXZlcnMvZnBnYS8NCj4gPiANCj4gPiBTaWRlIFE6IGlzICdyZycgYW4gYWxpYXMgdG8gYGdpdCBn
cmVwYD8NCj4gPiANCg0KTm8sIHJpcGdyZXA7IHRoYW5rcyBmb3IgdGhlIGhpbnQgdG8gcHJlZmVy
IGBnaXQgZ3JlcGAgZ29pbmcgZm9yd2FyZC4NCg0KVGhhbmtzLA0KUGV0ZXINCg==

