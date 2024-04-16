Return-Path: <linux-kernel+bounces-146610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAD38A6820
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873041F21DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFD5127B66;
	Tue, 16 Apr 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGe+VElj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90771B30;
	Tue, 16 Apr 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262657; cv=fail; b=EmvauZfTepmbKfQ1gavv9FC1k85NFtHtRYyl4K1lWnmK5IugItQoEjx9oAeEYMLbR+rpZem7UStJjynBad1fyVHklPfgr6kdtpNCBCuBx2M6eENfo182dKldOux7o7YF0AwHLWCKoo/qncgzvOVbF9AVg7x45TrI6NNmpMoej4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262657; c=relaxed/simple;
	bh=5hf4uNjO8GvvKrxLON3sh3w3kcH0TVrzkXzTvVMUeow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YmnBWe+7z28v2rSgRHf1SAIwmVoZLS+w2b2s2IZ4Moa9mMyCnwNMEqJIxQsSAlVclRNIeQUWwEJe/PRQrvOe/qaJI71TgdY4GC0rI1aXfI+LfwOQoGJDVHhkF9+xvPajkiPtesaBaO9c4tlTbIYxX/zTXxiAyNthgb+wvgxEEAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGe+VElj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713262656; x=1744798656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5hf4uNjO8GvvKrxLON3sh3w3kcH0TVrzkXzTvVMUeow=;
  b=HGe+VEljJSfaVegJqSWsQn5kkafvgQ+ZD1ymJQzrd62ZICPBzA6eE76C
   DIHPzm8jNlWVDVt0FTYXU9xrI9Sz0WIpsv+MPJ0WoQ1Azv0szSLRPVL6K
   e7VzNk7tQRJ16oM3HUv1P9exmrfUpk48CQ5zHUvJl+7mNBdLKWLVt7KNp
   B+3POvA7pmKaTE9FvD998MQmsiM0oyNMsIv7g9NlwCtjc1tPjUaD6iYGH
   Kl+9XjxyhPM87ExUZ1jrGowcEqN1N+CCA3ZYYQ3H4dKxl+QxPhwJ4SFYm
   JqNlt7MNNe3HIOdE3fdMPegMM3M12IzI5LLC7Tsn/F8WO3E+hl5l/EK0L
   g==;
X-CSE-ConnectionGUID: bic3OcxkRqW1ExWcwyNvDQ==
X-CSE-MsgGUID: OCDm3hYxQ8+bZurFsqsnBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12468136"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12468136"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:17:35 -0700
X-CSE-ConnectionGUID: TSraOlvdQ6q8nXCuvxSZhA==
X-CSE-MsgGUID: lBpu6hCxTgyjwiwrELtOtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22695171"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 03:17:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:17:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:17:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 03:17:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 03:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBtxRkJwIUgpQyBaoVdtHbRwk7P3seLiZEZ7dDHR5DegG95Lr9grznJIVxB43rhaw5QjqVCdZisB1Lx2WlQfediYmMg4J4wbWg2XWrOew5m/0hziEkjMD+aa43b5GVMwg4EXyi6+IwZ3653OOsPVmgn4rssT7anCVKtvk1s8UpJydI+MvXfKls9r0eo33kqm3BTog8Q4tFKrkpe4a5CY8uKWYS4Z1H+0WBbHkhIvNmtpW4sqXSJfqtrBvxdOnX6lwZ4JaqBtLbZ0fDNCGJKxQIZYbirlCKmM428nHqGgDHLx8iH4XlkWyXOJ64V6HTOp2tz/HNUPIVZPzvpaijneOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw02epAEgxMJgxdAX7kEtUUs86ue5FMZWntv/V9gkWY=;
 b=DStEJ7EpgxQO1rNd+1D6BM8EWvm2k8+RGw4O/0AwR06e9PC7PAZitekSBLJn/p0g4tknsH+jceJEbwiJLGuLTY/Og6/MqSYl9e5HTlT2DgO04huaYHXanHTgc936QRWkOD06VOIhBC2UokXrKE+s6HoDGezTOACB3nII0SegLIwgZf8OojLgjiTrrV7wp2UfAvg0fl7/rMPX2fb6LW7pKD7UOSnUPaifIUIHcUoJcYOpYIQXqNZm81oZhQ88UMhseKValS+bOxrY0pVZITXieQ1FI8u2+GXGJFfpW7QQuHk2lpGlMxS+14DOVgqlRcLO5aZhOp5LzIjCfkWXXN+lTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Tue, 16 Apr
 2024 10:17:31 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:17:31 +0000
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
Subject: RE: [PATCH v6 08/11] timekeeping: Add function to convert realtime to
 base clock
Thread-Topic: [PATCH v6 08/11] timekeeping: Add function to convert realtime
 to base clock
Thread-Index: AQHaiz0o6CjMPgXR0k2hr8rZRMmrIbFiEriAgAikcQA=
Date: Tue, 16 Apr 2024 10:17:31 +0000
Message-ID: <CY8PR11MB73647AF3A8845F5C13D58331C4082@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-9-lakshmi.sowjanya.d@intel.com> <877ch43lvg.ffs@tglx>
In-Reply-To: <877ch43lvg.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|MW4PR11MB6617:EE_
x-ms-office365-filtering-correlation-id: 07dd53ad-0628-4ca3-eb40-08dc5dfe6cf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yJku76CFOkUDZ3VV+Rcjp70Yoob7if04cZWQIbIBcKB/LQpcGdLGRJ9+v4lf/kmRUvqbc9xDa+j81lK90J8Z2SiVLh3hLfcTbLGK6S/U8Efa/i+ekEVWt0g6PDCK6yYjWS7gZojANg2yzhxAghH+X5qc23gyQ3bx+J+IFWPGzu9LdJu8W6UIZq4i2PdAvfl3+zpcZVi58OYFevGWm9vk1xvik/TsB8hbMce6F3AFAJ/GC28pvfkhaKDsKdmOAj8cRkVPsgppd/YYp1jcXnv8QuqhjAyJ2YHw7FcL3lFUrg83HEONpHhJbpYNhD6cr66nh/PmqfCMgbNm8sCSnmFVxDVSAR50nNu5exiXnokJhU4dxkX8xd/pPUuGeq1UgBHJjGrEZZZ7oQ8WxDWESMwh4bKUbSHs+nu8RNiWDIO44VNrZxnCq3s/COrzVtas3n1rv9jP0d5JYOoFEbFCqXFuic0lXi/6YTacZqYg9QqOav0qz7Wvrw78B/bVJSVik+zJPY3Jfa2ucyoyCVLH7EKCp2kZ6PpfOMdnjgalmR+dX9DGjJvcoFOGBKGyKodRMfRMpsKprqJ2su9+vcx85nuu/rm7oGRqkroL2o7uAP/MNPHHl5J3Y3jXY4zlkW/obG5JWe+3JVUYXaFGQhEGyjHYXWBq7YvhINKowcJnDkTTFHFaGSXf6gfgT2BvmS+3xG8GNic+Xl6Tht8erqbdqlIJOOtv0uxr/LKRB48CmONXDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oBqYfVYXMtIUd5/yrQ3X4h+KIKt9P4WmtohViV2STmpr9k+XOjYhCPE4B7YL?=
 =?us-ascii?Q?QSW50Ry8pNOr5uoZugmr0niowqB02/zbHYAM4Slebx1+Rtz5I7oNX7vE4781?=
 =?us-ascii?Q?aZdVxXC1TdvYrlhzV8WTGqzbn0U+FNKWiz/0ZiHfKwAv3wE3Xm2R7uNyLN71?=
 =?us-ascii?Q?Hc2c1eQxTIEDdAqs5VKGHYddfqLieqfuCBfOCarc51uwMhuO2waoAa5I59U8?=
 =?us-ascii?Q?ByiL8vghsDNlsqQUkWy3ORYNEzwFsGL8AlcN2jXYMJf+gyCfCNX/k0SmBMIQ?=
 =?us-ascii?Q?uAUxp4gdZy03+jbFbbFmyI96uuBVd4x9i1XJU+uMvcSBEEekkJ6mNoUXopz3?=
 =?us-ascii?Q?72yOat14LExWfUGDDEXW7RhdJIu9/QcPh/rNMGh6OHzsnW1uMW0OzMV3gojT?=
 =?us-ascii?Q?3R3Nr2GIIu0mSdJpTVZYUKzJFJFTnlA3bgBpSHQfc/YTqWS3vv0Kd2lr3hzH?=
 =?us-ascii?Q?2lj/F34qf5j6ePRN5dnqArR88cSi59pd6RCx+MAC7KE6LuAf7h3AsMqBl4IU?=
 =?us-ascii?Q?7BSFHkSt2ZlSgavHN54l4yFHQT5K2Ky0rHHCibZIddbb+iubPiSDbM36mv+B?=
 =?us-ascii?Q?3ocve4AuFbRoCc5u4OdzYXdnFIclP9dSAJlFfefXjjKTTgqoTEfI6+RPHSPv?=
 =?us-ascii?Q?e/C17ryhc53SWD2wOg/T8mlATqvOugUsr2R0iscajta99XxaLQjOJy93Hull?=
 =?us-ascii?Q?eIMYALEJNe3ChvvtOkjlGUZC/U6DAiM42D7jaBA+iKnpkpH7WWyPabH4dLOQ?=
 =?us-ascii?Q?47RRR7XCbSvefetz/PX2pOynHkmB1kxxWTHayrX1Uqe7v+S+xsDobwljH4nY?=
 =?us-ascii?Q?iORq7tAkNGr02W6wF1hRlPSKLEpRQifGK84zPdNLrswmx514MyA3aJJE9cAc?=
 =?us-ascii?Q?5iBjxr1qJsD18v+ROmJ9kUT5eKPQR4fP8VJmuPbD8I8mRiK45yJBEdsC3g68?=
 =?us-ascii?Q?U/S365S9hBfzZgc+fthTDA+U1Cqjg8xz/zU9DOHuiHQ0Ebzvc35bFQKRxBSO?=
 =?us-ascii?Q?TwwJBurWZ8OHnZBH9BaoGGcCIFACvXw2Iof7i7RwqC900PrBI0q8PM4YPkrZ?=
 =?us-ascii?Q?90Y+ew3ZA4End3lO1fPYfK6mjpab2o5g0dHeAq1O5ZQERWzS9ydM+DZS/46S?=
 =?us-ascii?Q?MFHJP9trIo0iAi26RNJOKJLU9euz7jer7jcJjffNn9B5bKnuHAW9yrv7FqEt?=
 =?us-ascii?Q?Bs7aFl4BryOHo5bt07N1wzfLxBtNQwp53rp1N4yyB6n3U0XPrCqVHBTQQsOB?=
 =?us-ascii?Q?HcHQkyjzX5HhCfl9FCioHl6MbRZfs7PUalMTZ3CUuP6A9ongboWTib86Vz+/?=
 =?us-ascii?Q?vAQQvRv6sNgev4+g5y3ZuZ3uAYkfBZTbeKM+QhOxfhb6nKJb8UtEEMkwCr/4?=
 =?us-ascii?Q?i4gu4JCRIJnLAqOyaqhLfLBi+2cs26f4grmy2y6kYwlULaUv1KVf3a3MjykF?=
 =?us-ascii?Q?cZtHMpx0cU49fuhhEZM+nkk3LlwUfGVNth2tBpbT4bubiYKAbB7rEExf61Bh?=
 =?us-ascii?Q?WBCf6SxTfRUlsVs0bBa7d2vcKtxWMLYHz0kgzvLG7tyrJ5Ix2tOM1y1GKrjP?=
 =?us-ascii?Q?dl3oDyix7Y1pXDW36bZQylaElNkYnqZ08OQLEhIdqkrYSHDrkIMC7WC4cEde?=
 =?us-ascii?Q?rA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd53ad-0628-4ca3-eb40-08dc5dfe6cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:17:31.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwdbKqGCQ5yddly6TcsZZfgPUpEdmixCxsunVkSWrIYjcLDRFGcG7m+6vL9yrgxC7wDaEyNyuT5KsfrcgEZFw8u4ulgirMiKw/G5V+4Vk1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, April 11, 2024 3:46 AM
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
> Subject: Re: [PATCH v6 08/11] timekeeping: Add function to convert realti=
me to
> base clock
>=20
> On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> >
> > PPS(Pulse Per Second) generates signals in realtime, but Timed IO
>=20
> ... generates signals based on CLOCK_REALTIME, but ...
>=20
> > hardware understands time in base clock reference.
>=20
> The hardware does not understand anything.
>=20
> > Add an interface,
> > ktime_real_to_base_clock() to convert realtime to base clock.
> >
> > Add the helper function timekeeping_clocksource_has_base(), to check
> > whether the current clocksource has the same base clock. This will be
> > used by Timed IO device to check if the base clock is X86_ART(Always
> > Running Timer).
>=20
> Again this fails to explain the rationale and as this is a core change wh=
ich is
> hardware agnostic the whole Timed IO and ART reference is not really help=
ful.
> Something like this:
>=20
>   "PPS (Pulse Per Second) generates a hardware pulse every second based
>    on CLOCK_REALTIME. This works fine when the pulse is generated in
>    software from a hrtimer callback function.
>=20
>    For hardware which generates the pulse by programming a timer it's
>    required to convert CLOCK_REALTIME to the underlying hardware clock.
>=20
>    The X86 Timed IO device is based on the Always Running Timer (ART),
>    which is the base clock of the TSC, which is usually the system
>    clocksource on X86.
>=20
>    The core code already has functionality to convert base clock
>    timestamps to system clocksource timestamps, but there is no support
>    for converting the other way around.
>=20
>    Provide the required functionality to support such devices in a
>    generic way to avoid code duplication in drivers:
>=20
>       1) ktime_real_to_base_clock() to convert a CLOCK_REALTIME
>          timestamp to a base clock timestamp
>=20
>       2) timekeeping_clocksource_has_base() to allow drivers to validate
>          that the system clocksource is based on a particular
>          clocksource ID.

Thanks for the commit message.=20
I will update as suggested.

>=20
> > +static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids
> > +base_id) {
> > +	struct clocksource *cs =3D tk_core.timekeeper.tkr_mono.clock;
> > +	struct clocksource_base *base =3D cs->base;
> > +
> > +	/* Check whether base_id matches the base clock */
> > +	if (!base || base->id !=3D base_id)
> > +		return false;
> > +
> > +	*cycles -=3D base->offset;
> > +	if (!convert_clock(cycles, base->denominator, base->numerator))
> > +		return false;
> > +	return true;
> > +}
> > +
> > +static u64 convert_ns_to_cs(u64 delta) {
> > +	struct tk_read_base *tkr =3D &tk_core.timekeeper.tkr_mono;
> > +
> > +	return div_u64((delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
> > +}
>=20
> > +bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids
> > +base_id, u64 *cycles)
>=20
> As this is a kernel API function it really wants kernel-doc comment to ex=
plain the
> functionality, the arguments and the return value.

Will add the following documentation:

" ktime_real_to_base_clock()- Convert CLOCK_REALTIME timestamp to a base cl=
ock timestamp.
@treal: 	CLOCK_REALTIME timestamp to convert.
@base_id: 	base clocksource id.
@*cycles: 	pointer to store the converted base clock timestamp.

Converts a supplied, future realtime clock value to the corresponding base =
clock value.

Return:  true if the conversion is successful, false otherwise."

>=20
> > +{
> > +	struct timekeeper *tk =3D &tk_core.timekeeper;
> > +	unsigned int seq;
> > +	u64 delta;
> > +
> > +	do {
> > +		seq =3D read_seqcount_begin(&tk_core.seq);
> > +		if ((u64)treal < tk->tkr_mono.base_real)
> > +			return false;
> > +		delta =3D (u64)treal - tk->tkr_mono.base_real;
>=20
> In the previous version you had a sanity check on delta:
>=20
> >>> +		if (delta > tk->tkr_mono.clock->max_idle_ns)
> >>> +			return false;
>=20
> And I told you:
>=20
> >> I don't think this cutoff is valid. There is no guarantee that this
> >> is linear unless:
> >>
> >>       Treal[last timekeeper update] <=3D treal < Treal[next timekeeper
> >> update]
> >>
> >> Look at the dance in get_device_system_crosststamp() and
> >> adjust_historical_crosststamp() to see why.
>=20
> So now there is not even a check anymore whether the delta conversion can
> overflow.
>=20
> There is zero explanation why this conversion is considered to be correct=
.

Adding the following check for delta overflow in convert_ns_to_cs function.

	if (BITS_TO_BYTES(fls64(*delta) + tkr->shift) >=3D sizeof(*delta))
			return false;
				=09
>=20
> > +		*cycles =3D tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
> > +		if (!convert_cs_to_base(cycles, base_id))
> > +			return false;
> > +	} while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +	return true;
> > +}
>=20
> > +/**
> > + * timekeeping_clocksource_has_base - Check whether the current
> clocksource
> > + *     has a base clock
>=20
> s/has a base clock/is based on a given base clock
>=20
> > + * @id:		The clocksource ID to check for
>=20
> base clocksource ID
>=20
> > + *
> > + * Note:	The return value is a snapshot which can become invalid right
> > + *		after the function returns.
> > + *
> > + * Return:	true if the timekeeper clocksource has a base clock with @i=
d,
> > + *		false otherwise
> > + */
>=20
> Thanks,
>=20
>         tglx

