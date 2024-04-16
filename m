Return-Path: <linux-kernel+bounces-146604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CC8A67E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB12816C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C5126F37;
	Tue, 16 Apr 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhx8rVSN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6585280;
	Tue, 16 Apr 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262309; cv=fail; b=L+i6Oj1RmJy9uy/+amO55TksQeA8Kre5TLHy1jpSaEsL2986/qu/JJ5fW/OPmxb9wlYe14TA8+1AcFRVKxmz28SoP4xleRYEHWTcyyh7J1QGuGgRVeNC8ilzKQkZIwU2RoN59SfdPoroWqZ6kdJhrcvdAhQ8ODxrryioroIcJh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262309; c=relaxed/simple;
	bh=Q2wYUQV9T8KY5n72gGGnU8w4a5tbtfnBx00X22wVSWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GS1WfCmowMaDHyPPWuYNQ6Gs4PJkQr26VqHRI1+f1qXtnqZYzhEeLnOtppZQRJaBjP29MO/9/yiSaehRSMQkztq7PvNKHsfmLes7GkDcY/ToUteP0Hxe1eGKSD64zebe7wMB2DFeUNeI/DsHRtASN/xF0U8YckMsfzTfBzzuTpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhx8rVSN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713262308; x=1744798308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q2wYUQV9T8KY5n72gGGnU8w4a5tbtfnBx00X22wVSWI=;
  b=fhx8rVSNIFjp/a/smS3Zx1CaVTfYyx4qR1+GLVJSdJOwlC5lIDyjtL+4
   LN3f2UwJACD8bXhFNjD/ydz0jTr4Ev0XPl2AobhhXB4zjjxLc46NZaHMV
   Lh2ZGg3ak+ZemLBnwdNH+08OBwq1m7THmnMxUyf+0S/0TFVt9jL8+2dnm
   edRjlIsp8P6hmUBTyatrux9hJOX/V0gddb72Z92kIG2tZ9D227v8h9jQ3
   dd95bLEZ1uPicsGVbhfkUA85nD3AJXKyzM4RaC+fzk9sO1cgrdocsnxUl
   DoVk8gSl2Dfzu9tGpe0P0PTMRBkCJgd4C2zJnbU5msumMFKeaoH0IMA9j
   Q==;
X-CSE-ConnectionGUID: myYYixwnQLykYYN8ixDB9w==
X-CSE-MsgGUID: 4IPKBOtRSBqeAAj7q73u1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19294836"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="19294836"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:11:46 -0700
X-CSE-ConnectionGUID: pfK+cAb4TIOlN2oY9PH3Xw==
X-CSE-MsgGUID: LgRF8U8IQvGB1GNvcXz27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22250688"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 03:11:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:11:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:11:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 03:11:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 03:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2S4/y5uYIgxYCuVpPthYjr8GH2t3mjW+P5mOuXwRhgQaNVaTyzsgiJXq9QiM1VYUQo3IPns9Oi+XFhPo+1XG+U2Yhh9EmOH/IOqaY5OYEnwy++gUm9lQJwD2QSqsYio/Fj2w/o7GVfED12hxQuN7OiSc3gZxwCkw+7ojUiUytEgDTntHGCOJxpEw5GK5iQoWy93Q0dzCH5J5qAQBYWCy1jnuW4FSYwgZc/daPL61213mLwdZoIj+8EyjQwrs57tgugoAp3G6A9EWptDpu/GfApm1BI7xrSiWlPjmQI+38KbWp+lPp3xanIcj2kWcTc/pfYCOUZsfYOooVtHWcdq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS+0q0b5WuQOGG3y+nhE0HASV2Yy27PZgLWkqLVndGo=;
 b=L+jIifzpdxiUrvwC278HqO6jka2xCe+Ydq7AF1M020avrjS7e/DUpZ63liDIFOZrg5j64uwwuQKtGIxbX3ZFKAiB3JzdbHPSN9w2ac2L5W65RZJ5UAFYFFoufJj1u2URcoIcyZgD43coKPT/qWLvxsjO5ptXEhubGBlBpGaGPygR10ohSE6Z5w9t0YKTfP/+aOQhUbcxuV1PkoVyGzq5Bb5WVytgh79NvGxNp7mHhDGHjoDR0Uorh07liZJlOuZtq0CxYeaQJkr0Xe/SaiMIo5nE3SEB/8x2lbtk+mjHR8eAYQ4u7kN0oHNqfBbOoMP7dBUWEo2AzgNsaB6ZydDYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Tue, 16 Apr
 2024 10:11:42 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:11:42 +0000
From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, "jstultz@google.com"
	<jstultz@google.com>, "giometti@enneenne.com" <giometti@enneenne.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "Dong, Eddie" <eddie.dong@intel.com>,
	"Hall, Christopher S" <christopher.s.hall@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "peter.hilber@opensynergy.com"
	<peter.hilber@opensynergy.com>, "N, Pandith" <pandith.n@intel.com>, "Mohan,
 Subramanian" <subramanian.mohan@intel.com>, "T R, Thejesh Reddy"
	<thejesh.reddy.t.r@intel.com>
Subject: RE: [PATCH v6 01/11] x86/tsc: Add base clock properties in
 clocksource structure
Thread-Topic: [PATCH v6 01/11] x86/tsc: Add base clock properties in
 clocksource structure
Thread-Index: AQHaiz0PazTrRHQXt0yKbKUcSArdGrFiBscAgAiuGPA=
Date: Tue, 16 Apr 2024 10:11:42 +0000
Message-ID: <CY8PR11MB73648707296EE27BF4CC6F8AC4082@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-2-lakshmi.sowjanya.d@intel.com> <87cyqw3nup.ffs@tglx>
In-Reply-To: <87cyqw3nup.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|MW4PR11MB6617:EE_
x-ms-office365-filtering-correlation-id: 07d6207c-e559-43cd-87fe-08dc5dfd9d16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krLrfVozxZjWRr4OAVN2B9wa4z+nFG6YAvc+6Vt38HcIFAk5s+sp18axAsAc/RlxGjL8xRH4CNTXZMTzDPVvgMr9iuNGjKcy6Wv2Ywjr9ThhhvxSLWFrOHX0KQQWmwfh5F5Y9t7hPZUgaTMzmQ+FxRO7Wf1huPNSQ8cE4Maw0jCUW0yuUYpUqgpl2m1w5uCxmAhpa+CrOL/eSqo/cziums1Lr4/J8QroriHhbL1j2W8r4+ORkgivCmbLuvyD8wr0adWjPGscW/1gbFUDlh0XfK6VCZfB0fKQYT/+7Dm3FeO9/85Lbk9PQQ8I18fPWkOfaKYgUzzBgtPYMA/cuirTtseHRaaMH1EK8xBLncuGfKXdyCTaij4DkXriJtcj2Yk+Vi4H1lHiFGP7H9FWa3PAw53bs4YuZit1z25g1UvuXEsxI78i4JpagwNFSlZ1QziI/FCO2E/Y3xm4Z4Wdj6bmcVh4mnKsbC7SEHVFNk2SmFRAqPgqzbYkLRcIAoZhoz8bG0KeTMwRIPCyGDleaH9L4nJ0YFGy+ObUNv8d8wFhQFTj+CIikyCLvbbQViXxbENoYDSdOdwve4cXQiDBgfjxBXneOO6UIzHjROHY3RbH3qoUMhwlOltWlZMcDBMdVtecSyNfT/RCn1WMYxNHLAhQquQ0Tv+73d6gUN7AhN/XvyPGcWKxJD+NBttXj1UUtVA7lcqZPD3KP6bctjEZig7yYsOy7H5460ionK74meC5xFM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZA7M4/oYxkSo/ZjYlnBDW24roWcLAAX91UsF31ABUeCtSAlKpOTkhbHaAj3B?=
 =?us-ascii?Q?P42UqtpJWALNFSricGdcMbXZSY3XQ3EekK4bPwkWOKUdeDz9q0bPXEzlHdXI?=
 =?us-ascii?Q?8BFUPBOgTtJfRsE3himz03BSp/kKSFecUMh2Y77IiKaCnvc186Kfva+J+xho?=
 =?us-ascii?Q?Wkv1VvGxGINhSKzJUUDDNrDBHp1N2tKOUFdZgweKZYjr4gjwqFuL5GiEpEvk?=
 =?us-ascii?Q?Und6MS5fuk7ZrxxUkQmB0VPx6W2znjERI6LBGIh31C7JwZ8uxgRzQhNPX5z+?=
 =?us-ascii?Q?S96DhQw+Wu3bFvgxuaK2hElCyYpy/hxSKxw/gDGhfBcE1GRkJeNgsz7Bw6Rq?=
 =?us-ascii?Q?IPATcH2gf9Q/+UTE0u0IegOgNRoepmO5Q3pMfLuLmzloBJjNmjMyQ5HLoVeQ?=
 =?us-ascii?Q?+Vi2cbAd9PgAydwmZffHeF80lMSGeOvTx5yKu3gqIsmToWjg1QvukJnI52aj?=
 =?us-ascii?Q?wmKJuq38ADYj5IWqOcwUvpwnx5WwNp5JK1vb6Rxxw9bM9TcfSsUTn1hXQIo7?=
 =?us-ascii?Q?tzWMNnf4BK17Xe+/dd7IubdqPuTtkUAmldrYw2STb+Y+cLReUXEQxPj59Gzx?=
 =?us-ascii?Q?Uwx76sDmmxtxgo7S3nXg5dK9ZisB2s2fTfHhCoOGNX+/7lSmwxz9yGhm/Zym?=
 =?us-ascii?Q?teZtarUdUTDKhcrAySplq5r0JoZ+tPS+vbKIb3RylJufn5ghA72SMn55DmbC?=
 =?us-ascii?Q?jYDo+ysohf6tv1KTP7sqX7U/tXx0im4Qaz6h0/k5viyatvg2iT3xIiauKJym?=
 =?us-ascii?Q?ruNHeKPoC7gUEibZKsNdB9aa+j4LwcBseb4AiTVbpNRQZQtqhPkd+i2S3t3L?=
 =?us-ascii?Q?/Tq2tU1+fn89WZR+6LbHz9Vm/L5XaXPA+cWq1SsShCUyGkxL4UwQMXTNndHM?=
 =?us-ascii?Q?/UdGRurFQvlpZ0oywfQTXQ0kKr92XFcSAt3U1T1JtBu3ftNBvuu/I0MBdGB3?=
 =?us-ascii?Q?+agolXdAqMsdnICcRD6sZ1BO5yF0NnmqKZ/OkO/LkUDUKqs6YuXEGKokNlTk?=
 =?us-ascii?Q?5ugwB2W+hFkqlVkebv4eCcAl31VYlXNZ7N42Jfpfm28Q8EJcA316oZPlrtiO?=
 =?us-ascii?Q?niLtlQoUx0icjUQaJGmdhibz0MBrF2c7hhC7DfuT9IYgR0Fg+rmL5oFdXj87?=
 =?us-ascii?Q?mbb4SLrKBedVyM27lQ5XbcRhD2XkyAqqNClIgRLd5EBK2iGgUDBnIOwqqn7B?=
 =?us-ascii?Q?RnBBITAMH8zh9v0cm5cHsazFxqqTQsUJa3BFUhOZAD1RNOALPyctu8oeR2fk?=
 =?us-ascii?Q?peHrer49RYKNl5Lmwc2+R0jM6Afth6K15EVJuyYTGG5TVO7psLBSPlzotkTR?=
 =?us-ascii?Q?T+ryndD+ZVMyEh6OTIMAmhGzoGlIae96EWTWtozXliaUR9I4rZlLY71KmOAX?=
 =?us-ascii?Q?Y5W3YQ0LNvEuu/6hg8D2Zgs/ygUrooL5EcigW1UZLxopw8PT+ATKQsDCbTtv?=
 =?us-ascii?Q?D0N7XCfgcZoHXgiUY6RkcLGiiblXLbL1JoYEMQ4vnhmBUd7vHq2/rPx3uAiM?=
 =?us-ascii?Q?pFnhBfFxfgExitHT+bDOjM5FAcsuSyNOY6Efezu/Z0EG5R27jtNLY2lwE3co?=
 =?us-ascii?Q?tThszknHmA5NQdumfFjM2wpsb4fZWOuTDzGEPqzKURcnoD3BK84F/zpuT5l8?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d6207c-e559-43cd-87fe-08dc5dfd9d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:11:42.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WB3gGtc2km70pDzq5wp+V4BWeEVKAY2cOsxaCrpznaISjYZYs5+zvStj3LB0shAsKH8VsBi+9Q7I6lSbOd7NFahowjvVhK5rxgt3Pvfu+LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, April 11, 2024 3:03 AM
> To: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>;
> jstultz@google.com; giometti@enneenne.com; corbet@lwn.net; linux-
> kernel@vger.kernel.org
> Cc: x86@kernel.org; netdev@vger.kernel.org; linux-doc@vger.kernel.org; in=
tel-
> wired-lan@lists.osuosl.org; andriy.shevchenko@linux.intel.com; Dong, Eddi=
e
> <eddie.dong@intel.com>; Hall, Christopher S <christopher.s.hall@intel.com=
>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; davem@davemloft.net;
> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
> mcoquelin.stm32@gmail.com; perex@perex.cz; linux-sound@vger.kernel.org;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> peter.hilber@opensynergy.com; N, Pandith <pandith.n@intel.com>; Mohan,
> Subramanian <subramanian.mohan@intel.com>; T R, Thejesh Reddy
> <thejesh.reddy.t.r@intel.com>; D, Lakshmi Sowjanya
> <lakshmi.sowjanya.d@intel.com>
> Subject: Re: [PATCH v6 01/11] x86/tsc: Add base clock properties in clock=
source
> structure
>=20
> On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> > @@ -48,6 +49,7 @@ struct module;
> >   * @archdata:		Optional arch-specific data
> >   * @max_cycles:		Maximum safe cycle value which won't
> overflow on
> >   *			multiplication
> > + * @freq_khz:		Clocksource frequency in khz.
> >   * @name:		Pointer to clocksource name
> >   * @list:		List head for registration (internal)
> >   * @rating:		Rating value for selection (higher is better)
> > @@ -70,6 +72,8 @@ struct module;
> >   *			validate the clocksource from which the snapshot was
> >   *			taken.
> >   * @flags:		Flags describing special properties
> > + * @base:		Hardware abstraction for clock on which a clocksource
> > + *			is based
> >   * @enable:		Optional function to enable the clocksource
> >   * @disable:		Optional function to disable the clocksource
> >   * @suspend:		Optional suspend function for the clocksource
> > @@ -105,12 +109,14 @@ struct clocksource {
> >  	struct arch_clocksource_data archdata;  #endif
> >  	u64			max_cycles;
> > +	u32			freq_khz;
>=20
> Q: Why is this a bad place to add this member?
>=20
> A: Because it creates a 4 byte hole in the data structure.
>=20
> >  	const char		*name;
> >  	struct list_head	list;
>=20
> While adding it here fills a 4 byte hole.
>=20
> Hint:
>=20
>   pahole -c clocksource kernel/time/clocksource.o
>=20
> would have told you that.
>=20
> >  	int			rating;
> >  	enum clocksource_ids	id;
> >  	enum vdso_clock_mode	vdso_clock_mode;
> >  	unsigned long		flags;
> > +	struct clocksource_base *base;
>=20
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index b58dffc58a8f..2542cfefbdee 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -1193,6 +1193,40 @@ static bool timestamp_in_interval(u64 start, u64
> end, u64 ts)
> >  	return false;
> >  }
> >
> > +static bool convert_clock(u64 *val, u32 numerator, u32 denominator) {
> > +	u64 rem, res;
> > +
> > +	if (!numerator || !denominator)
> > +		return false;
> > +
> > +	res =3D div64_u64_rem(*val, denominator, &rem) * numerator;
> > +	*val =3D res + div_u64(rem * numerator, denominator);
> > +	return true;
> > +}
> > +
> > +static bool convert_base_to_cs(struct system_counterval_t *scv) {
> > +	struct clocksource *cs =3D tk_core.timekeeper.tkr_mono.clock;
> > +	struct clocksource_base *base =3D cs->base;
> > +	u32 num, den;
> > +
> > +	/* The timestamp was taken from the time keeper clock source */
> > +	if (cs->id =3D=3D scv->cs_id)
> > +		return true;
> > +
> > +	/* Check whether cs_id matches the base clock */
> > +	if (!base || base->id !=3D scv->cs_id)
> > +		return false;
> > +
> > +	num =3D scv->use_nsecs ? cs->freq_khz : base->numerator;
> > +	den =3D scv->use_nsecs ? USEC_PER_SEC : base->denominator;
> > +
> > +	convert_clock(&scv->cycles, num, den);
>=20
> Q: Why does this ignore the return value of convert_clock() ?
>=20
> A: Because all drivers will correctly fill in everything.
>=20
> Q: Then why does convert_clock() bother to check and have a return
>    value?
>=20
> A: Because drivers will fail to correctly fill in everything

Agreed.
Will add a check for error case:

	if (!convert_clock(&scv->cycles, num, den))
             		return false;

Thanks,
Sowjanya

>=20
> Thanks,
>=20
>         tglx

