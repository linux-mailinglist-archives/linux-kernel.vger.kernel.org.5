Return-Path: <linux-kernel+bounces-146612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D658A682D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436C81C20B89
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D088127E05;
	Tue, 16 Apr 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJ4MgIhM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEB1272A0;
	Tue, 16 Apr 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262810; cv=fail; b=nDPnGXyf71xdXiFFE0p2tTTRV0QSKxjtAgLwP7XAw0ZeW7RE2pU86BJSu9oPP26z90248JSs8jcZF8TmPJP+Ye2E5bYkT45Xt3QuGoaCYdnj+LqJHHKHijqtuhnpuUtLEj4ob2dI3m9Kc2i0v0wXONo8a4VEpUYeNvGQqQaVLig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262810; c=relaxed/simple;
	bh=s8i3oCYEsqT6fSIrQ3yYvCtFIbKR0BCnS6rU4+tBXGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWO7ImXMuvc2Wh5lklNG8Ua7SibhTilgVrAIDQy/QDRB1z9uNK8lMJk1+8WKtqWKzm33B7nDIHp9Vr7XyXAzbOZEplK46YjwCuTZLnp8MweLzdQrV5iywp8XXLQdKqZQVYosa5ht5snQaFUEAGC1xmFu55KjEvDmi0ppjxvJeeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJ4MgIhM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713262809; x=1744798809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8i3oCYEsqT6fSIrQ3yYvCtFIbKR0BCnS6rU4+tBXGY=;
  b=TJ4MgIhMSxvNDHapRceeg/S8qKoQiGGnFnnG08I2Rups7m0mW9mr7EVb
   VepLny7Tzj5u1M3Nu/wpEERI8YgWbxlGeVvhji0fKX3+4PwKWa6TIJIoY
   FPYYoDKg+LkzmvfNgSMEblIjP2g/o0VbJPikcG0OJCc66a6p3c1liF6Aj
   GF6LPxKV/7wtGYxH3sTSIJSpTP7a+c+gQ/zOqzrxfOF0xXQx5HfHlkjfw
   CRSTz/98KeVKE5d1C0pGUiaO8T5tH9+OZUHZxg/yAAlDm4cxFCaDD4Y7J
   hv/o0HQyU2tG0id2jY7mv6uRkbm/MdL2K0a6IXv1B5OJweZ+z4FdD7h18
   Q==;
X-CSE-ConnectionGUID: fqInHwgCSmCVqPSWBa8v8g==
X-CSE-MsgGUID: SZatr+YWRqy/aTTRd+n2Tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8817353"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8817353"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:19:54 -0700
X-CSE-ConnectionGUID: dPvGC5PiTHSOcM78l9SJlA==
X-CSE-MsgGUID: jMnbD4wFT9K5Sax/QV9vuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22284905"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 03:19:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:19:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:19:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 03:19:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 03:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYXl0kyW+i+KpIcEj3yzcAtvTvb0b6ES0MBv63cj1900mcn4wZ5wC0MbZteNNikEQ7us49voGlMuygyCofNZ2FpBYwk0lS3OORf4OZNRBzDj4P5N+xDlEt6/aNgL1Ow3akJQYUjjm0amc88H3ykgAAZxTe/VPB7tef1dKr6mvxsq5gzBMiuZXuY9n+qPzb8P/0ap7re+KEQ4XHFwpo98hPOR2MKEDPj5Szs1zR6sRRHRFKnpw1AKoJmu+ETgsniARVpLsNnOoYPd22BuqFfG3BwjDgjl17THZY4h2r3mjDZCmJAPqn3rKO+ru4R0d8QjaMdF0wJh3Bk4+eGxGg7RYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fx0jEHQxvz9OxIotTBy9KW3UW2bzyJNhQ1VAc5D/7c=;
 b=ZA+1zLIm1Ta+uj92c+Pyn4OAaJrFFso+rnEJ49YyHFFrs390pqn9wHKsFYzOoDixtMPuYNUYBQoPYRHfXTakiTdXktBOOqpB3xG1W/R4+1+DEh580kw/oWLYMOsF6gPWopybuom1UX6BRuS3Lyb2hISBjIMlfT40iKCLd0WuxLEXNvo7RhTskSttYIPb828/1aLjMA0JvXUDnsSSFZmbN9OIR0602Fbc65nzmGHIR+jRXRMusHlQ14A4C67CNbUgPfpf8WCAoridGqtOsR/qNe3PAUO7hp6ZK+Bocpf3GEXVNme55ZyU+Gl65P7MnO9LzBeSHLSbz6ZyA8Ut02kYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 16 Apr
 2024 10:19:45 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:19:45 +0000
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
Subject: RE: [PATCH v6 09/11] pps: generators: Add PPS Generator TIO Driver
Thread-Topic: [PATCH v6 09/11] pps: generators: Add PPS Generator TIO Driver
Thread-Index: AQHaiz0vASRBRbSJ8kCIgRN774y8wLFiFmmAgAihucA=
Date: Tue, 16 Apr 2024 10:19:44 +0000
Message-ID: <CY8PR11MB7364070B11D5D9E4711613F0C4082@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-10-lakshmi.sowjanya.d@intel.com> <874jc83l9g.ffs@tglx>
In-Reply-To: <874jc83l9g.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|CY8PR11MB7315:EE_
x-ms-office365-filtering-correlation-id: c9efa102-a957-4c44-0214-08dc5dfebcc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fLHT95oM8QHV5yV9wO42yDx+I58pvu5yNatoNf1iDkT5Nm9N1/lznrl4GYjq7LjLpYoWv60dIFf2g7R3gROWPnpHfOsnH73CVYGOOaqW5JBEtF7/9hkCSmh9OiUTGJSeg81cd/jAUDVuFWsUQ4Dl2YvjKt5X6hFaoF6pQqoUThQpO9HQswN5T3UXlR0MrAnXZ9XhCBG8QSGZkfgThqK1bW3MUcW4RXksSEYkMSF1/CKmm/0TL7z6AbjQGN23PsHmNlCT0ntSX4VMVb//2BIsAUALr/OAw9cFZ7ZqB3QDE8wjpzfsSZ00zwQtr+bD8a5yjM0Ud6dmOBx3L6wjISRtnZ6y1frq3dnDP5TFLjg1qVVcJi5uMgiMi7Ql4yK9duF6pGE9iAS+fzr71NQELHTfj9lFj8rcERYTrvtt3/zjguhgsMbaupVUwg/as6EUkEvZnjLBVnapusyciUSInmajVRgDxCOwcEsG55fNJB0ITzLKBQNfVOUL7T15HNi9oK06KA03N1QfJnWEjLT+KebyAlOk0rM8OTDbfCPOnuPKKUiVUULyKvdod1wyYF/66Y9D8qaLu7dr3TawQUI3He6RX2kA8gUqbUU1kupoYy0g66MaeI8md/t6QvsF880wU6jke9kf9AunNfTMm0A7XVexEVO1bsWQwlZiil342Pw0xKTWJzKECxgl2gram2gMD7d/LbFIIxhqoERp4UYBEqWrmfSHvCqePiZas1IlTBnnrxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvrCfjbqUOpRQ+famMB8/lG+OgQf8Zk3q/Da7PxtnPSGUIeS+Uh3ag63NQqc?=
 =?us-ascii?Q?Z990GHyRVhSNWRNxeIzGgbna8/1sPcv4IDkusvyvwA06ZJ0PrUnmTH00J59c?=
 =?us-ascii?Q?oEZLZ8zDSo5CJUHSCtnnXrb2nE0mnjesGjkEQBfT3zbDygK1qhHEZQKElWZN?=
 =?us-ascii?Q?JvwmfnOVbDrUe+MsQLkzcHJ8M5HweDNalNApy5jWJeZDBJgbJymXR68icuGZ?=
 =?us-ascii?Q?NM3LkQFI+RZHnHtiBARo9CW791F31IdbTtqKXkg439PKatK9WIkR/hgJ9PUo?=
 =?us-ascii?Q?NqW/jpoHRk57pSGe4mFUA4WVwiJa7l8AS+XbjAXUXpw/Buie2JG0v9DEi6kY?=
 =?us-ascii?Q?udG+5urO0yHtbd3KCcl5nt1a9ZKG/MhCOzvDOzBVkELqQCltfHBvr01qFlSX?=
 =?us-ascii?Q?9dIa5nIfpUVe2uJ9l7gsQvkFMR8pvjz/9j+SnU3NwZuFE0Z/9BbN7QhaHBAW?=
 =?us-ascii?Q?8veZf9hLPCq1QMUOBIRxTNoerwGpDeCKAVXsp5+Nh7IwVLwXz3MwlZQyz+ZY?=
 =?us-ascii?Q?8GoC6D8wTWrEp9peQQiGq44Mf1efwc+hf55N8dOkgBkVv7hxBBY892bBpsOD?=
 =?us-ascii?Q?4n43PcycP9RIKV0d1RpoWyqUHfugb9ke7/ZxjnCg8blAOoRoQExguCt2/ui6?=
 =?us-ascii?Q?mnBYVMUxNAKrSHxUSNQo2MFQJVD8zZjXZHWF6YgbI57kbZ1pPj9rsGGmrWQU?=
 =?us-ascii?Q?1WXloD0sPYKHGumt/BzhrjPNOStY6ryyb9uC3Mdr0RHVCy4VswkH45dF4xQN?=
 =?us-ascii?Q?iXr1G/Ai8VZdgfR3LBZJIMyTt9n0bMEJ0MRmvUBQstCMNFOiWLv52rR8NskL?=
 =?us-ascii?Q?iafbrZoSZA8r7ShiD4FOdNhmsspquf3GUywX52X7+JjFz/SvB/NkNWKamlAJ?=
 =?us-ascii?Q?GaENPRN6shKH7+mbhZ26EPS1nK2pMCht6FwWBJVDcxM7h0++dalEl4/tcM3m?=
 =?us-ascii?Q?uyMWlzDjOlDLaLWVtC/TN5n0UN5jkkca0pWEmgFKk9CGbWaVk1NiKO/FoiwX?=
 =?us-ascii?Q?zD9xGiSZiRZGfYvrM5kcPMVg4O1tmgAWf6LdpA8tvoDozh8Bd9ZEhilTJF0d?=
 =?us-ascii?Q?PasisG5LrCQ+SnATr+D2Bqx7j3mhJgFkkT4ViUDsoFdiilvh9LMdjnRC1Vfh?=
 =?us-ascii?Q?7JafI3W+HPsxg3diJdOx928CbV9j3CgDPFfjkSbGG8URvi1GaeNwFOp1/Mut?=
 =?us-ascii?Q?68OGi1kJILFyUS5fMrR/MmxswZaBN57QMurgTiWqp9GX84c7h8LbAotkMJvv?=
 =?us-ascii?Q?n4fowCXULO4VsPm2YjWm+7RQlhya7WhFbVizB94bZKowN5OK7l1Fi/66OzLH?=
 =?us-ascii?Q?6blvDAIpDHlf98mfwMhjLEMCNCA4j3AWbE/Klveq7irM87VDVxIpLx9uXqVb?=
 =?us-ascii?Q?tLFQDLHj8aAvGHw7eES+7YxcGKND3qU4Ttdjzx5DV9egAjBjz/y12bp17ZHv?=
 =?us-ascii?Q?EF6PJE4UuVomlToeGx0fiXYX3hJXh42BSXEZKA8Tly8OPOyqdSOpdv/hSD+u?=
 =?us-ascii?Q?u9F8trhwSWfsYkwLSAI6jx5SMQ1996Gawnzl65woxvtY+pJZpjfSzMFXdfdo?=
 =?us-ascii?Q?I1rC4VsYQlVSeT5lBKm4fDc+azJwGOsalb7XTAVg+igWjjVDfm3+goLptjBg?=
 =?us-ascii?Q?Qw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9efa102-a957-4c44-0214-08dc5dfebcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:19:44.9280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5REHUYtmJMdoF0AcWK0gxgwYsQ4EXPHBjnm40YKiiFSUgJbggcUnB6hosUcVeDxlHrHAmsnAIipAwLsBTFnqKJv8pBTZ5e5iy7Twst0xXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, April 11, 2024 3:59 AM
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
> Subject: Re: [PATCH v6 09/11] pps: generators: Add PPS Generator TIO Driv=
er
>=20
> On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> > +static bool pps_generate_next_pulse(struct pps_tio *tio, ktime_t
> > +expires) {
> > +	u64 art;
> > +
> > +	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
> > +		pps_tio_disable(tio);
> > +		return false;
> > +	}
> > +
> > +	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
> > +	return true;
> > +}
> > +
> > +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer) {
> > +	struct pps_tio *tio =3D container_of(timer, struct pps_tio, timer);
> > +	ktime_t expires, now;
> > +	u32 event_count;
> > +
> > +	guard(spinlock)(&tio->lock);
> > +
> > +	/* Check if any event is missed. If an event is missed, TIO will be
> disabled*/
> > +	event_count =3D pps_tio_read(tio, TIOEC);
> > +	if (!tio->prev_count && tio->prev_count =3D=3D event_count)
> > +		goto err;
> > +	tio->prev_count =3D event_count;
> > +	expires =3D hrtimer_get_expires(timer);
> > +	now =3D ktime_get_real();
> > +
> > +	if (now - expires < SAFE_TIME_NS) {
> > +		if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
> > +			goto err;
> > +	}
>=20
> If the hrtimer callback is invoked late so that now - expires is >=3D SAF=
E_TIME_NS
> then this just forwards the timer and tries again.

Yes we will introduce a return HRTIMER_NORESTART if the time is expired.

>=20
> This lacks any form of explanation why this is correct as obviously there=
 will be a
> missing pulse, no?

We had added an event count check to detect the missed pulse(i.e if we had =
programmed an expired time).=20
Timed I/O hardware has an event count register to log the number of pulses =
generated.

>=20
> > +	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
> > +	return HRTIMER_RESTART;
> > +err:
> > +	dev_err(tio->dev, "Event missed, Disabling Timed I/O");
> > +	pps_tio_disable(tio);
>=20
> Why does this disable it again? The failure path in
> pps_generate_next_pulse() does so already, no?

will remove disabling twice in the next version of patchset.

>=20
> > +	return HRTIMER_NORESTART;
> > +}
> > +
>=20
> Thanks,
>=20
>         tglx

