Return-Path: <linux-kernel+bounces-147956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25618A7BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A9F1C22862
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00752F65;
	Wed, 17 Apr 2024 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXSQbURO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD3C524BC;
	Wed, 17 Apr 2024 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331592; cv=fail; b=sxqWBLpduTWaNH8cWvyuKB0eCg1zGtDLlShjAaIXdw6HeX269EVX6RXaHeiJgklSmLeC+74uNUXuu++Fd3pxlV/CBreI136mTfyI0i6Ao1TAqf/OsughTOsOh2zJWc5zyt5Dj0TuNDr5PFPNYMhxR7o5lbcPZ+Q8X4EPPtgGckU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331592; c=relaxed/simple;
	bh=mJTeAn6dh9FwVaV4FXZEKN2VxtSaX0jAZIzQhOxqZms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ditGSDNDGpKlrECH9mIl8Gzat9975NT3kMIlmPUebxkYYlBNIraVzhuMtl4SFs3GGE3jR+KKToEOyCv8zkRN3C4GlHfAgQAIT8k6XjJGcL8TEVqp+4CuPbQ7b3ixGq1BduWj5xZxfpVjoO7J4sJaK69uXqHDVF81gnarUqRlzmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXSQbURO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713331591; x=1744867591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mJTeAn6dh9FwVaV4FXZEKN2VxtSaX0jAZIzQhOxqZms=;
  b=FXSQbURODpIGlz/IOdkd9HPuvbBCr+1wlae1My6Ezzp7OssG6Hd4YRo3
   GNAosZ21RgrUr6waxhh3u30W4agT9cjsOaHh0ZK36zTPIxTIKProN9nPD
   4KKZeN584MMBAXJl8jGcUitDxq9jT3rEOtGIIkSodjGcoW2dBjwzPm32z
   EOrKjHB0XvtXiBXsGmkIE1eqY2Op+/gMHgGA0xXa3ZVRkTo3VFY12hZl3
   fcHV1C230GJ4icQTZvmhR1rmVMrCDZ++gd/5R0gHHHk/iyhUSrWHwxulU
   Hw+WA1GEqhRAtriKo7exIfq5iWaW0VhTVnFOjv7l3d9PA2SE6iWCbPCWx
   g==;
X-CSE-ConnectionGUID: Le3c7DngRaS2IpBjtpq+1g==
X-CSE-MsgGUID: VPyGBPSLT5WPRIhmhnOu3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8928063"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8928063"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 22:26:30 -0700
X-CSE-ConnectionGUID: xHkS6PePQgm3PnQcdFGfdg==
X-CSE-MsgGUID: u3IZ1RWsRHKg1soUFRGylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22983532"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 22:26:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 22:26:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 22:26:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 22:26:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 22:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwWLIaZnlEurBDmyszl4I66xLyuZGAIiPaqNt6lPHbKCZP/tBt6zUH7Y/HQNkDLib6IJpUNnM6YOK7I3riLis8YRBGAiLMyPIHxKYwWKpX9XSRtu4ooHo4i6tbFJHPMARt8KhsJPXmNoA6bUBO343QkQtp4AjHXuMTopWGX4MNz1zNpg0lSbOcedPTrG3mCAkPK+rqYuYm9+UDebK5QGznBCFOxLPZeNH2clj5ZtUum5E8eb9C0UgZRIi2BOnLBI7LKr8J5SHBgm17jq8Eu8isQ4JnSyeHLxQhb/+yf3T3OldVOir/lq3YujV0bKG7QUUOaoLoJ1Ly0deWRTtOLmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJTeAn6dh9FwVaV4FXZEKN2VxtSaX0jAZIzQhOxqZms=;
 b=SEUO2mfKac2XCW4BLmQGNb0PSvzB7A/XHbHEFLDAVh2KrI5xCm93PjIdi2Drd/k6/TTrsVjag9NjkEcXEr3SU1K1YYHzmxE2+gL/KklUZdrFZe6hLx29k6izg40M+DO4Oj3coIVilCh+XAcwtuHQgtxyRO+weIayu2xEwDO2GJfE/YK5zRUkNv7qB4p5Us+Zv+c3RB7aspLzKTHoy5ig2cvNhsnf/KaF5E8YyR2B+nh/TzBjn7tbfzHv8B7iMD9Exocf0e0Q5KTp7bWTMZo+DjbYZ3smQdlRe15GVGw+udpveC7OPr4N6kp5JquTuTj7SCdjIf3XfWI1288EzjYfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Wed, 17 Apr
 2024 05:26:22 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 05:26:22 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>
Subject: Re: [PATCH V2 2/3] powercap: intel_rapl: Introduce APIs for PMU
 support
Thread-Topic: [PATCH V2 2/3] powercap: intel_rapl: Introduce APIs for PMU
 support
Thread-Index: AQHaiWg0oypv/wNTnU2s511hM6NRXbFq+X6AgAEDQAA=
Date: Wed, 17 Apr 2024 05:26:22 +0000
Message-ID: <0e345bdd91f90d1141e4114f55a8626fd0fad212.camel@intel.com>
References: <20240408035141.248644-1-rui.zhang@intel.com>
	 <20240408035141.248644-3-rui.zhang@intel.com>
	 <CAJZ5v0hDdTS++iWLYDnoVotV3=e=Vn2di4EjUBJzHiNLzrbaig@mail.gmail.com>
In-Reply-To: <CAJZ5v0hDdTS++iWLYDnoVotV3=e=Vn2di4EjUBJzHiNLzrbaig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB5279:EE_
x-ms-office365-filtering-correlation-id: d66ef058-6aed-4366-49b6-08dc5e9eeb6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSuQv2zI4Q6mW7rIKuyF5UqSWcFx5PzzjlUaRvw8j6ffaHzSNugonHJ9wpOQ2navoyWyH2pvnkOHTNYq4Ip5aoZG1ueLkf6sd5Y+QmEA8enTKBsY1Xa6euf0EnCdGuDomNewcl8golbCXbOzIoFypadcN2vEFPVfqqVZWcA+4/fT7dTLQMcdohWXctwJHKfnhLFK7OLhWxeGaIDNSTpArbl2yrx9MIC/QQexYycJFx5w6S+l8rpAi3YY/dgvbNayWVaBaoYp0TV/SqO1ohJXI8xfUxdKd0QsS+2olRnROdhMkQCD81lULQRr43UG4tcbsmFqywVUplMKGS2i+bqsf1+pI4VK+IyGUIrj5aW38Ie5v5JWqEZyPkaCPEZ703vU1O/v6T3mKRHpav6NLvOoQP5Z7uSiGG4z7gcYcSFkQLOymoZxvO30HIPZe5LieCOe4IvG+pd7vec9AHxJbFSRgWD9AHkq08GhKRakpeAFPYOfKCwpdCREGRX6DBZCjul6ZA+Q5sctb+INyH4Ra9CfkExa8WEIRTD7cADawI5HHv4CUhS7L5JgUHdxz1Ix+zrMlU6PvPBMYGc2+kTlAGNOAQ3J3jT+ANupDkshh3/qSOSqFqpvej+XcWWZR7Ac+p2kdg9QVxre99Ip1BSUk7KoU/LnSfto68KFzRbQNfIjCb1PpE1oRg+ngWqeg914cC7vCmU3D4s38fhYmwK6ZCo8Cc+Xj0oEu4EYO5suZAniT+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czdCQ0VPeWt2Um9mbi9NNGRHREdEOHFoSWxWMUJYd3VqM0trYmg5YkRBUUgz?=
 =?utf-8?B?MSs5Mm5hQ2M1ZjNMZWovT0N6OTRUc3k5R3VoRGxyRnlnU2F3R3E5RTU5Smxm?=
 =?utf-8?B?RzdmOTYwdiszQ2dRdnVEU01RSzlpQ3pFTGxwM29vQ1lkUkVpbmc2QkRKRG1K?=
 =?utf-8?B?Q25GNGo1SHNKVHB6SEdTcklDb2p1aGR3ekV3WXdiUnQveU9EUlpmeTMwZ3J0?=
 =?utf-8?B?TU0xQmpTOHRqTThCYXN3V3ZkUFNaSjJHNHdmZVBqOE1VM0dMck5POEZFWExS?=
 =?utf-8?B?V0FncFhQT05TZVNWTEpLZ09kTUk5Z2V2dlJXU3hNQ3poSEpMRlk4ZmJXUUJp?=
 =?utf-8?B?Q3BEUU9PempVbUpFK1dFaitQVUgzS0lCU3pwTGxFWVZxMFo3YjhMUUVweW5t?=
 =?utf-8?B?ZGw0SzM1V3hsYUJLQUhEVFlVRGZrVDgzT2RsOW5YNkhkS3Mrelh1QXdsWlZX?=
 =?utf-8?B?MlNUT2V3bVo1UndzL2dSTVNubkRVMmFXWFBPTVJHaW9BUTUvamRFZkxTWWty?=
 =?utf-8?B?dERkaEdPeHFvMXowbkxpeENMYWFYM2IrYkhhMkthUUFFVDZySElXOHFkR2Jq?=
 =?utf-8?B?dG1MYVBZZE4zNnl1Q1ozdit1WktNNXBPT0o5MDZOVTREQmRRNzZqWDlJemV6?=
 =?utf-8?B?YWFjTGY1RDZZUzZSdUd6M1Y5Mi94M0JVM1UvRDI5anRDMXBrT0tRdmVrUHQv?=
 =?utf-8?B?QW9SNkRLMU1jMk5rYzZrTkxHdzBEVFZCdHIzNUNBenVTTWRWVWF5Z2VpMmpF?=
 =?utf-8?B?SmJHRGJqTVg3WVZwaHY0QTBvZXNXdHVpOU1jdDVIOHhUVGFDV3gybGhEYUxt?=
 =?utf-8?B?R2dWRGg1NTJKd2dBSGVHR2JPSVdUcnRJQUVjWWs5cTZLeDJ1TXg5UUltc1RK?=
 =?utf-8?B?YlFqRXllaVMrRGF0YUo2QlNveXY3YVBtb0VCUnZNN3BPMjQvMWs4cU9hSTdG?=
 =?utf-8?B?RlA1OWNjU3E1dk1jbnZMOGxMYmdHSzA5U0dFVkxMQjJCZW9Lcy91LzM3Smo0?=
 =?utf-8?B?LzBLVkptUWkzdzJvY29MVkVHYVM5WGhBRVNlbmYvc2dPTXRqcGxJc2ZMUDlQ?=
 =?utf-8?B?RUZBNlhZYjFPUWVObWdnMXY4eW9VMWMrVDFXVDFNRVVOM0V1dDBIUUVqQ1Jr?=
 =?utf-8?B?bW9LVmFLQy90MjMwbmxFUitVSEd1dzdLNUFxRG5xNVdCUUNtcEJpMGhFNkpu?=
 =?utf-8?B?bm5kWnpWL3QxZXVtdTBINWdRaWNVZnBLSDVQZTR5aFZsNXBzQnhVbjdIOWpN?=
 =?utf-8?B?ZDFWQ2cwVG5vaklpWmgrQ2hJRGM0WTg3NDZ5WmpLWG1GK3E5N2FiTis5WGta?=
 =?utf-8?B?cSt2TkcrSFQwbEd1UEdQdUhPd1ZtS2xFcWxlQnRQSHZLMnFWeHhDWXd6My83?=
 =?utf-8?B?UjRVUjB3MXViRkRwczhhWkcrRmV0SXBvNGY3aVV4T3p3UmRkZldKN0ZyL3FF?=
 =?utf-8?B?dWJVTDRmWlZQck1zYlFrUHlJYll5aEV1a2l4Qm1zRUVWVURqVWErSTNUOXFy?=
 =?utf-8?B?TVhpTHB5Y3IvMzNiamJQKzNHcG1kbGppZzBnWU9xRW5vUDduUWxNc3hsZ1JC?=
 =?utf-8?B?TDBCL1IyTVRYMjdtUHhCcTliaEIxUU0wanZXbTlJeEJHeXJ5Y01xTEt3b1hP?=
 =?utf-8?B?TERxTUpvUlBmd1QyWnNSMXQrUWxxU3FyTDNkT2V3UXp2QWsybE80MlpFZDY1?=
 =?utf-8?B?M0NMbllyWVJ6ZzVjSUhsSXo3WWJVdUl5dW0zUzRIWk1DcGs1QTZaWWIxbjhD?=
 =?utf-8?B?N1Q0cXp1NUFvZGp4YmE2YThZZzN5TG9GcTh6NEtDaUxyYmhKZ3NwUlpEbnRC?=
 =?utf-8?B?TDljVEJTeGQ2MmlzWmx4OW1NSEdOLzFUZTlVaSthUnV2aGdBUkt0UmovU3Fm?=
 =?utf-8?B?VWw5VHc5aitsenBIU29GK0pqbWc4aXNoWk96cnJLKzRMdTZMeU5Cc05Fcytu?=
 =?utf-8?B?SzVpZWhSamJRZmZJRkNWQ2Z5c1cyN2JzclE1V2ZKaGNOMS9aUEJ2TW9BK0pC?=
 =?utf-8?B?TmltVWZUd0M2bTVCbkY4ZFZqWWFuK3FVWnlYRmFzNmJrcXowczAvN0tlS2xG?=
 =?utf-8?B?dzBiSEY4ZE5aRXBxUnZEUzlYUENoc0xaZmZxRGtyZVZHSkpuaTcxQ3ViQ25l?=
 =?utf-8?Q?X5p3LNArbdrsc/YSrCO0gOMry?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F812CA82FD7004595E0CCA0717203EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66ef058-6aed-4366-49b6-08dc5e9eeb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 05:26:22.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73ZPQnc0bHhwJAVg8808SEIiITp0mMLCDq18eAUkJeqdN8lXhOflJVDt5eSAQguQG9+TK98rFas5fhtjDKf1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

SGksIFJhZmFlbCwKClRoYW5rcyBmb3IgcmV2aWV3aW5nLgpXaWxsIHJlZnJlc2ggdGhlIHBhdGNo
IGJhc2VkIG9uIHlvdXIgZmVlZGJhY2ssIGp1c3QgYSBmZXcgY29tZW50cwpiZWxvdy4KCj4gPiAr
Cj4gPiArc3RhdGljIGJvb2wgaXNfcnBfcG11X2NwdShzdHJ1Y3QgcmFwbF9wYWNrYWdlICpycCwg
aW50IGNwdSkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgIGlmICghcnAtPmhhc19wbXUpCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgIGlmIChycC0+bGVhZF9jcHUgPj0gMCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBjcHUgPT0gcnAtPmxlYWRfY3B1Owo+IAo+IFNvIGlmIHRoZSBnaXZl
biBDUFUgaXMgbm90IHRoZSBsZWFkIENQVSwgYnV0IGl0IGlzIGxvY2F0ZWQgaW4gdGhlCj4gc2Ft
ZQo+IHBhY2thZ2UgYXMgdGhlIGxlYWQgQ1BVLCB0aGUgZnVuY3Rpb24gd2lsbCByZXR1cm4gJ2Zh
bHNlJy7CoCBUQkgsIHRoaXMKPiBpcyBzb21ld2hhdCBjb25mdXNpbmcuCj4gClRoZSBhYm92ZSBj
b2RlIGFjdHVhbGx5IGFwcGxpZXMgdG8gTVNSIFJBUEwgYmVjYXVzZSBUUE1JIFJBUEwgaGFzCmxl
YWRfY3B1IDwgMC4KCkluc3RlYWQsIEkgY2FuIHVzZSBzb21ldGhpbmcgbGlrZSBiZWxvdyB0byBh
dm9pZCB0aGUgY29uZnVzaW9uLgoJaWYgKHJwLT5wcml2LT50eXBlICE9IFJBUExfSUZfVFBNSSkK
CQlyZXR1cm4gZmFsc2U7CmFuZCBkbyBmdXR1cmUgaW1wcm92ZW1lbnRzIHdoZW4gYWRkaW5nIHN1
cHBvcnQgZm9yIE1TUiBSQVBMLgoKPiA+ICtzdGF0aWMgdm9pZCBfX3JhcGxfcG11X2V2ZW50X3N0
YXJ0KHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgIHN0
cnVjdCByYXBsX3BhY2thZ2VfcG11X2RhdGEgKmRhdGEgPQo+ID4gZXZlbnRfdG9fcG11X2RhdGEo
ZXZlbnQpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKCEoZXZlbnQt
Pmh3LnN0YXRlICYgUEVSRl9IRVNfU1RPUFBFRCkpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBldmVudC0+aHcuc3RhdGUg
PSAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBsaXN0X2FkZF90YWlsKCZldmVudC0+YWN0aXZl
X2VudHJ5LCAmZGF0YS0+YWN0aXZlX2xpc3QpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBsb2Nh
bDY0X3NldCgmZXZlbnQtPmh3LnByZXZfY291bnQsCj4gPiBldmVudF9yZWFkX2NvdW50ZXIoZXZl
bnQpKTsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCsrZGF0YS0+bl9hY3RpdmUgPT0gMSkKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhydGltZXJfc3RhcnQoJmRhdGEtPmhydGltZXIs
IGRhdGEtPnRpbWVyX2ludGVydmFsLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhSVElNRVJfTU9ERV9SRUxfUElOTkVEKTsKPiA+
ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgcmFwbF9wbXVfZXZlbnRfc3RhcnQoc3RydWN0IHBl
cmZfZXZlbnQgKmV2ZW50LCBpbnQKPiA+IG1vZGUpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoCBz
dHJ1Y3QgcmFwbF9wYWNrYWdlX3BtdV9kYXRhICpkYXRhID0KPiA+IGV2ZW50X3RvX3BtdV9kYXRh
KGV2ZW50KTsKPiA+ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZkYXRhLT5sb2NrLCBmbGFncyk7
Cj4gPiArwqDCoMKgwqDCoMKgIF9fcmFwbF9wbXVfZXZlbnRfc3RhcnQoZXZlbnQpOwo+ID4gK8Kg
wqDCoMKgwqDCoCByYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGF0YS0+bG9jaywgZmxhZ3Mp
Owo+IAo+IFdoeSBkb2VzIGl0IG5lZWQgdG8gYmUgcmF3X3NwaW5fbG9ja18/Cj4gCj4gV2hhdCBl
eGFjdGx5IGlzIHByb3RlY3RlZCBieSBkYXRhLT5sb2NrPwo+IApUaGlzIGlzIGNvcGllZCBmcm9t
IE1TUiBSQVBMIFBNVSwgd2hpY2ggZXhpc3RzIGZyb20gZGF5IDEgb2YgdGhlIGNvZGUuCgpMZXQg
bWUgZG91YmxlIGNoZWNrLgoKPiAKPiA+ICsKPiA+ICtzdGF0aWMgc3NpemVfdCBjcHVtYXNrX3No
b3coc3RydWN0IGRldmljZSAqZGV2LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNo
YXIKPiA+ICpidWYpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgcmFwbF9wYWNrYWdl
ICpycDsKPiA+ICvCoMKgwqDCoMKgwqAgaW50IGNwdTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAg
Y3B1c19yZWFkX2xvY2soKTsKPiAKPiBJcyByYXBsX3BhY2thZ2VzIHByb3RlY3RlZCBieSB0aGlz
PwoKeWVzLgo+IAo+ID4gK8KgwqDCoMKgwqDCoCBjcHVtYXNrX2NsZWFyKCZyYXBsX3BtdS5jcHVf
bWFzayk7Cj4gCj4gSXQgZG9lc24ndCBsb29rIGxpa2UgcmFwbF9wbXUuY3B1X21hc2sgaXMgdXNl
ZCBvdXRzaWRlIHRoaXMgZnVuY3Rpb24sCj4gc28gd2h5IGlzIGl0IGdsb2JhbD8KCkdvb2QgY2F0
Y2gsIHdpbGwgZml4IGl0Lgo+IAo+ID4gK3N0YXRpYyBpbnQgcmFwbF9wbXVfdXBkYXRlKHN0cnVj
dCByYXBsX3BhY2thZ2UgKnJwKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgaW50IHJldDsKPiA+
ICsKPiA+ICvCoMKgwqDCoMKgwqAgLyogUmV0dXJuIGlmIFBNVSBhbHJlYWR5IGNvdmVycyBhbGwg
ZXZlbnRzIHN1cHBvcnRlZCBieQo+ID4gY3VycmVudCBSQVBMIFBhY2thZ2UgKi8KPiA+ICvCoMKg
wqDCoMKgwqAgaWYgKHJhcGxfcG11LnJlZ2lzdGVyZWQgJiYgIShycC0+ZG9tYWluX21hcCAmCj4g
PiAofnJhcGxfcG11LmRvbWFpbl9tYXApKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCAvKiBVbnJlZ2lzdGVyIHByZXZp
b3VzIHJlZ2lzdGVyZWQgUE1VICovCj4gPiArwqDCoMKgwqDCoMKgIGlmIChyYXBsX3BtdS5yZWdp
c3RlcmVkKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZXJmX3BtdV91bnJl
Z2lzdGVyKCZyYXBsX3BtdS5wbXUpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bWVtc2V0KCZyYXBsX3BtdS5wbXUsIDAsIHNpemVvZihzdHJ1Y3QgcG11KSk7Cj4gPiArwqDCoMKg
wqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgcmFwbF9wbXUuZG9tYWluX21hcCB8PSBy
cC0+ZG9tYWluX21hcDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgbWVtc2V0KCZyYXBsX3BtdS5w
bXUsIDAsIHNpemVvZihzdHJ1Y3QgcG11KSk7Cj4gPiArwqDCoMKgwqDCoMKgIHJhcGxfcG11LnBt
dS5hdHRyX2dyb3VwcyA9IHBtdV9hdHRyX2dyb3VwczsKPiA+ICvCoMKgwqDCoMKgwqAgcmFwbF9w
bXUucG11LmF0dHJfdXBkYXRlID0gcG11X2F0dHJfdXBkYXRlOwo+ID4gK8KgwqDCoMKgwqDCoCBy
YXBsX3BtdS5wbXUudGFza19jdHhfbnIgPSBwZXJmX2ludmFsaWRfY29udGV4dDsKPiA+ICvCoMKg
wqDCoMKgwqAgcmFwbF9wbXUucG11LmV2ZW50X2luaXQgPSByYXBsX3BtdV9ldmVudF9pbml0Owo+
ID4gK8KgwqDCoMKgwqDCoCByYXBsX3BtdS5wbXUuYWRkID0gcmFwbF9wbXVfZXZlbnRfYWRkOwo+
ID4gK8KgwqDCoMKgwqDCoCByYXBsX3BtdS5wbXUuZGVsID0gcmFwbF9wbXVfZXZlbnRfZGVsOwo+
ID4gK8KgwqDCoMKgwqDCoCByYXBsX3BtdS5wbXUuc3RhcnQgPSByYXBsX3BtdV9ldmVudF9zdGFy
dDsKPiA+ICvCoMKgwqDCoMKgwqAgcmFwbF9wbXUucG11LnN0b3AgPSByYXBsX3BtdV9ldmVudF9z
dG9wOwo+ID4gK8KgwqDCoMKgwqDCoCByYXBsX3BtdS5wbXUucmVhZCA9IHJhcGxfcG11X2V2ZW50
X3JlYWQ7Cj4gPiArwqDCoMKgwqDCoMKgIHJhcGxfcG11LnBtdS5tb2R1bGUgPSBUSElTX01PRFVM
RTsKPiA+ICvCoMKgwqDCoMKgwqAgcmFwbF9wbXUucG11LmNhcGFiaWxpdGllcyA9IFBFUkZfUE1V
X0NBUF9OT19FWENMVURFIHwKPiA+IFBFUkZfUE1VX0NBUF9OT19JTlRFUlJVUFQ7Cj4gPiArwqDC
oMKgwqDCoMKgIHJldCA9IHBlcmZfcG11X3JlZ2lzdGVyKCZyYXBsX3BtdS5wbXUsICJwb3dlciIs
IC0xKTsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHByX3dhcm4oIkZhaWxlZCB0byByZWdpc3RlciBQTVVcbiIpOwo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoCByYXBsX3BtdS5yZWdpc3RlcmVkID0gIXJldDsKPiAKPiBXaHkgZG9uJ3Qg
eW91IHNldCBycC0+aGFzX3BtdSBoZXJlPwo+IAo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+IAo+IEl0IGxvb2tzIGxpa2UgdGhpcyBjb3VsZCBiZSByZWFycmFuZ2VkIG92ZXJh
bGwgZm9yIG1vcmUgY2xhcml0eToKPiAKPiByZXQgPSBwZXJmX3BtdV9yZWdpc3RlcigmcmFwbF9w
bXUucG11LCAicG93ZXIiLCAtMSk7Cj4gaWYgKHJldCkgewo+IMKgwqDCoMKgwqDCoMKgIHByX3dh
cm4oIkZhaWxlZCB0byByZWdpc3RlciBQTVVcbiIpOwo+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBy
ZXQ7Cj4gfQo+IAo+IHJhcGxfcG11LnJlZ2lzdGVyZWQgPSB0cnVlOwo+IHJwLT5oYXNfcG11ID0g
dHJ1ZTsKPiAKPiByZXR1cm4gMDsKPiAKU3VyZS4KCkluIG15IHByZXZpb3VzIGRlc2lnbiwKcmFw
bF9wbXVfdXBkYXRlKCkgdXBkYXRlcyBnZW5lcmljIFJBUEwgUE1VLgpyYXBsX3BhY2thZ2VfYWRk
X3BtdSgpIHVwZGF0ZXMgYSBnaXZlbiBSQVBMIHBhY2thZ2UuCnRoYXQgaXMgd2h5IEkgcHV0Cgly
cC0+aGFzX3BtdSA9IHRydWU7CmluIHJhcGxfcGFja2FnZV9hZGRfcG11KCkuCgo+IEFsc28sIHRo
ZSAiRmFpbGVkIHRvIHJlZ2lzdGVyIFBNVVxuIiBtZXNzYWdlIGlzIG5vdCBwYXJ0aWN1bGFybHkK
PiB1c2VmdWwgQUZBSUNTLsKgIEl0IHdvdWxkIGJlIGdvb2QgdG8gYWRkIHNvbWUgbW9yZSBjb250
ZXh0IHRvIGl0IGFuZAo+IG1heWJlIG1ha2UgaXQgcHJfaW5mbygpPwo+IApzdXJlLgoKPiA+ICt9
Cj4gPiArCj4gPiAraW50IHJhcGxfcGFja2FnZV9hZGRfcG11KHN0cnVjdCByYXBsX3BhY2thZ2Ug
KnJwKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IHJhcGxfcGFja2FnZV9wbXVfZGF0
YSAqZGF0YSA9ICZycC0+cG11X2RhdGE7Cj4gPiArwqDCoMKgwqDCoMKgIGludCBpZHg7Cj4gPiAr
wqDCoMKgwqDCoMKgIGludCByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGlmIChycC0+aGFz
X3BtdSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUVYSVNUOwo+
ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBndWFyZChjcHVzX3JlYWRfbG9jaykoKTsKPiAKPiBXaHkg
ZG9lcyB0aGlzIGxvY2sgbmVlZCB0byBiZSBoZWxkIGFyb3VuZCB0aGUgZW50aXJlIGNvZGUgYmVs
b3c/Cj4gCgpUaGlzIGd1YXJhbnRlZWQgdGhhdCB0aGUgUkFQTCBQYWNrYWdlIGlzIGFsd2F5cyB2
YWxpZCBhbmQgcmFwbF9wbXUKZ2xvYmFsIHZhcmlhYmxlIGlzIHByb3RlY3RlZCB3aGVuIHVwZGF0
aW5nIHRoZSBQTVUuCgo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBmb3IgKGlkeCA9IDA7IGlkeCA8
IHJwLT5ucl9kb21haW5zOyBpZHgrKykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IHJhcGxfZG9tYWluICpyZCA9ICZycC0+ZG9tYWluc1tpZHhdOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGRvbWFpbiA9IHJkLT5pZDsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCB2YWw7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoIXRlc3RfYml0KGRvbWFpbiwgJnJwLT5kb21haW5fbWFwKSkKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogVGhlIFJBUEwgUE1VIGdyYW51bGFyaXR5IGlzIDJeLTMy
IEpvdWxlcwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRhdGEtPnNjYWxl
W106IHRpbWVzIG9mIDJeLTMyIEpvdWxlcyBmb3IgZWFjaAo+ID4gRU5FUkdZIENPVU5URVIgaW5j
cmVhc2UKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9IHJkLT5lbmVyZ3lfdW5pdCAqICgxVUxMIDw8IDMy
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvX2Rpdih2YWwsIEVORVJHWV9V
TklUX1NDQUxFICogMTAwMDAwMCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
YXRhLT5zY2FsZVtkb21haW5dID0gdmFsOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFyYXBsX3BtdS50aW1lcl9tcykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByYXBsX3ByaW1pdGl2ZV9pbmZvICpy
cGkgPQo+ID4gZ2V0X3JwaShycCwgRU5FUkdZX0NPVU5URVIpOwo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIENhbGN1bGF0ZSB0aGUgdGltZXIg
cmF0ZToKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogVXNlIHJlZmVyZW5jZSBvZiAyMDBXIGZvciBzY2FsaW5nIHRoZQo+ID4gdGltZW91dCB0byBh
dm9pZCBjb3VudGVyCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqIG92ZXJmbG93cy4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogbWF4X2NvdW50ID0gcnBpLT5tYXNrID4+IHJwaS0+c2hpZnQgKyAxCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG1heF9l
bmVyZ3lfcGogPSBtYXhfY291bnQgKiByZC0KPiA+ID5lbmVyZ3lfdW5pdAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBtYXhfdGltZV9zZWMgPSAo
bWF4X2VuZXJneV9waiAvCj4gPiAxMDAwMDAwMDAwKSAvIDIwMHcKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcmFwbF9wbXUudGltZXJfbXMgPSBtYXhf
dGltZV9zZWMgKiAxMDAwCj4gPiAvIDIKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdmFsID0gKHJwaS0+bWFzayA+PiBycGktPnNoaWZ0KSArIDE7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsICo9IHJkLT5l
bmVyZ3lfdW5pdDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkb19kaXYodmFsLCAxMDAwMDAwICogMjAwICogMik7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFwbF9wbXUudGltZXJfbXMgPSB2YWw7Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJf
aW5mbygiJWxsdSBtcyBvdmZsIHRpbWVyXG4iLAo+ID4gcmFwbF9wbXUudGltZXJfbXMpOwo+IAo+
IHMvb3ZmbC9vdmVyZmxvdy8KPiAKPiBBbmQgdXNlIHByX2RlYnVnKCk/Cj4gCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcl9pbmZvKCJEb21haW4gJXM6IGh3IHVuaXQgJWxsZCAqIDJeLTMyIEpvdWxlc1xu
IiwKPiA+IHJkLT5uYW1lLCBkYXRhLT5zY2FsZVtkb21haW5dKTsKPiAKPiBwcl9kZWJ1ZygpIGhl
cmUgdG9vPwoKVGhlc2UgYWxsIGZvbGxvdyB0aGUgTVNSIFJBUEwgUE1VIGNvZGUsIHNvIHRoYXQg
d2Ugc2VlIHRoZSBzYW1lIG91dHB1dApubyBtYXR0ZXIgdXNpbmcgTVNSIFJBUEwgb3IgVFBNSSBS
QVBMLiBJIGNhbiBjaGFuZ2UgdGhlbSB0byBwcl9kZWJ1ZygpLgoKVGhhbmtzLApydWkKCg==

