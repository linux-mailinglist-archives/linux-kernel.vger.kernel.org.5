Return-Path: <linux-kernel+bounces-146603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF54C8A67E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B3AB22864
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6CE126F38;
	Tue, 16 Apr 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJMP13Eq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9486250;
	Tue, 16 Apr 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262232; cv=fail; b=NIXyXwNwSCUpzg1gIOgasXuBGDAu9HScwwPGD4oWsZ0+2baU5x03/aHsduXlkyBL605GqH2mE8xO35R3o3QiWG3XfsyrMCbC7xtsw0EdgegmqV7v3mjqlruVOSFjfODOCW87S9xwbFEtnn279Q9h0jE8pt0ow6EjnZSXNkBZAqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262232; c=relaxed/simple;
	bh=MMIYebeu+dDlQKXx09cmRZVC4onTFT+ZqrRTeijtzHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SCRgaIjV+rVd9zn1K2mQyi0ryE2rewRsNoD1uyK6tT3yrZdq39AEvzQiWGM0FDiIjymeNrE6ax00hlJJojC5TZFcPxhfr3wyfj98+zwCkUyb0FHY15M1Us828oMaDb7P1wJBie6beviRzBkqxe6ISPTxQ85bSywsQ3PXEZq3Kww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJMP13Eq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713262230; x=1744798230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MMIYebeu+dDlQKXx09cmRZVC4onTFT+ZqrRTeijtzHo=;
  b=aJMP13EqesjY16cotX3CJ4t4ptp2cubv7OSNg7fLdKTO8C89FYinZ5zW
   o4vBsWMakmTHpZVNBDGf2+E0cu3MobSXyquMlxEEy0HqlBJU4HWQrqnrt
   D6+oOeMBJcl4ysM0lWusqsobuulCUxXmA7vc/BrJO4hqIpiakf+ZcIi58
   nngt1NswBxwSjB5+CmfYmwAkPzs64s1hsHhP5V6fxYX+4zv/Iic1yab0H
   zgb557cAj+PsGHysrkxJnluajlud9Qa/IX9wS7xozse7CLemkP+1RVHa6
   /lA2LtpjFr3V9QG/TOdyoIugUWjfbcn7CjMFXSVQ7e4Bq2wBDl4F3KQwU
   w==;
X-CSE-ConnectionGUID: Cj0uKZt4Rl+3PLGIIPNjYg==
X-CSE-MsgGUID: KZidoLJkRsehVwWqIdiUgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19251680"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="19251680"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:10:29 -0700
X-CSE-ConnectionGUID: Gi72GF/BShS87ivh+ZN3kA==
X-CSE-MsgGUID: cRtgRmxVSCWRoaUY/XSeuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="27008272"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 03:10:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:10:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 03:10:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 03:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyg2RNKWp/63sAWaCrovgfUu3Jmlc+itgqZ+vRX0hhHm1tQSpSlzvuHEm3fuVw9+9r7+FSBeOqpzDG/0nYfuwk335b2XVVytY3PwDKtbK2PwiVPnr39zZD7FwGbdUU7u32KoB0RWxj/1vxEgraR39t/n3CGEiWfeuJl6pHXBhoijm8lhkt/rukkuZFjns2db14SJGZF6re9rxUwyIIgxkDAGWmWaqCsZwTmf00t8uod0iz0NwbTkkuovHD0Svb1YXNNbA1hD8Uo/elHuqXL5PD5SEuK8AQHwxVDMrUsaDZWW1zP0mhE01k62BFtehvpTthEnq2WpD/bpB2zhPHHmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnVz6ESopbQxq+Ko0NebdCvA29iAVUVzwTPfiWasmoU=;
 b=FhFuoLLNpW0rTNYpTkRGKA3WonC6ocu15enFnBROsJUILGQspYBQJjJvP13mJ62dfp5f7ZLw9gF3UXcsiQcQMdYsxj9WR6YyZUm35x91Gowi/NZPPm88Mq49KalHykOKhaiBOnEvO/lK4Va2gi/Tn4TVSiQ6OKwMYQdf7VAin2AR6qZtm+bS7stytaXA10778n2OCBn2GGtUNJYPkjQMv6I2dLKiy622X+HIgS9dAGgT1ihW3zLlMAfWGdfc+Q4Wocv+zGPQcKolzb+hGNU4Yz0jQGXN4ytCmSBQNkZl/64D8DVgz7K9rZ8jmL9JfsALPEV9jamR/3/i0WLeK3U8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Tue, 16 Apr
 2024 10:10:24 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::6a93:4191:4aa3:6f7d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:10:24 +0000
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
Thread-Index: AQHaiz0PazTrRHQXt0yKbKUcSArdGrFiA2oAgAiwZpA=
Date: Tue, 16 Apr 2024 10:10:24 +0000
Message-ID: <CY8PR11MB7364EAD4BE0E1038A13C695DC4082@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-2-lakshmi.sowjanya.d@intel.com> <87frvs3oer.ffs@tglx>
In-Reply-To: <87frvs3oer.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|MW4PR11MB6617:EE_
x-ms-office365-filtering-correlation-id: 877dfa4a-73c9-4314-a941-08dc5dfd6e9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7X2j3Sr+sPvm66KH+R59lMGm9DP3RJljiynYa8B+z1IHTrBdeI/cHyR6q3EmbRzqdwMVuxFyL1CliVAGauLaociz6MvM9pHIW0xpgc4qYW0GUUpG5NsFx5SI89n5EtBm5z6EPJhpOD+AEB2N9RHUPpgSx5C6578pkoZjtj9G9gXwmvB55RjzZVCneIcSf9j91wb/6mUB25ry911rrarC02R1W3SmFNjwkgwomYd1PjdESlN0TYX+Ht7huRHHnPMnZSQS7oiC5Uqw6Qrfhv3s+p32XJEuYwyVvoEUuk+VRObEV96C2ja74vZipMnJ8oyekchpsbH6gP3Q/sQ8JMa4VM2eo5YhhtHptEyO849dGyHVseOqiadpYsuFtR+m0q3x7/pAWxYZKLonhW52yQtHOXc8N/oox5BW7K/MgDOonbjRMBXzwHQ68OFwO24erlZm8Dqo36er+hIw9v0w7INBXcYpsOg2qwdoWD0UG1YAtCXp04hpJ4rroEOi+dmTa3I/0L3xB3t6jmDJe6yVAu9pzmQUEUL1G6G6QlpSp1DE4pGF+v/x2NfX7v/USWXEUd5NLcQ1OYHYvoqnIBNUksOTNEpQ/QXblaDaQ3ZPm/JSeuaLZctwBSL+R4iHd5ts8dP5an7tyhaqiPgnUvYkmShZINGkop6wl1tabdGQDKK8HFSL+fC6utuzphAqjKsFJ4eoXg2GKdamO5RFlyFnBZMEzbNYghoLEwirVtF9+DvfK2c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fZCem3OfmRUeadGxLm3Cl0AeviwAjXW5YG+w0oxua+WA9hjGMqE0BfrDlo6y?=
 =?us-ascii?Q?92eqSYfM+RNGb0JjvK4J5rtMWReKzT07+My3BawvUndpu1gD0eWfz9XH9sAy?=
 =?us-ascii?Q?VjetWVWFYOP4QJlM+cTuzu0UeFJgMkTD1kzONoKA5QxquFgByHqm3eEwsvDa?=
 =?us-ascii?Q?p3IPSlULX6CDsDe625iHADPPcU8cnpc5kZnU0svE9s6oHwDD+untMDsvbudk?=
 =?us-ascii?Q?jRnrCfYvzIQkPrG0mzDT4AcA9AigWhh9s9hieHhhy0DSG+hfAoba3nwimka6?=
 =?us-ascii?Q?UElYmswymiWadqtPnyqNvzqNnsE3198+An0AsjPFz3fiUUYX5wGvH4Mcr7zl?=
 =?us-ascii?Q?2aNueSyftcMni63kE1+cDwIx5qd5h5rgreICmWWLvAL0IHhXKywDQhY3jsjF?=
 =?us-ascii?Q?swWhpi1Jid+nbtX8hP2J7s0Qc4kBlibuxIqM4RNPqjLsxptPtn5WtKgQ+Bpu?=
 =?us-ascii?Q?8NXIk6OJwTzv0PE+LxAyIwquVS8/yg8HmyM14Q3Invnt4mwc0eJ54xZnuE6J?=
 =?us-ascii?Q?YvHDGcUg51F5OkjP6CGsWM/Iz582QMjBPWv2cK25hPOIEt5dlwIVMo1uqb2u?=
 =?us-ascii?Q?9stDOd6AF2dQd5oUJF/4QyKbNpchF08/H3GzciWHjSHO14Kl5PUUpSnqxc7k?=
 =?us-ascii?Q?omeywCAE8tAUvP48Hkbe6UlxFAl76WJXwTce8w3vIUZjMpiwU7JISob0cOUg?=
 =?us-ascii?Q?D4+bcgMLpBIStFVelZBHBBZ528KXhXRO9+m7J//1yN3+OpEavF9OfOSUdySP?=
 =?us-ascii?Q?razx7TtZqETjFF+WJwEixeofBnIruVGVby8cVKaV5PIZ5BlyCFAtCX11t45K?=
 =?us-ascii?Q?JHRNreLVaVpXo51ysG9/JDH4KeoJcSv+afXabEJrmPajIL+O7n9HGh2AaMC7?=
 =?us-ascii?Q?Mx9Jf7XITKvTUE3DnlYINouTmm4bmDiQ22ui/YflZfA/fZJecpHCnwo4HBXN?=
 =?us-ascii?Q?mYdY7ZG/NLhidlYk5XpIhpJGpFZh7eUP/sj8hhvxkhX1nR82eFuI88Wb5xvo?=
 =?us-ascii?Q?SHKPtB8+h44fCmOJ0i3XTlRaYId6lEaUC4FnSzqvoH/32EotFMdoRZIIfEp3?=
 =?us-ascii?Q?7Hf5AudjdKu6qSGMd3wz+PWyxXYaWLVLJhj78jvK0AwLM0KdKv6bD7+sUnot?=
 =?us-ascii?Q?N+r92W0a6Qid1B3wE8YmP+j0JyJmbdCZ1o70c9+HA1fbrBb1Zc2VIpuBZ6Ve?=
 =?us-ascii?Q?ZEQoB78v3+/XvQSyV7VJyycPyN8VvKzh+hsy50Q1qPqfmz6ZF5grEpIm8qoo?=
 =?us-ascii?Q?EUq4nhmRX3LU+3xtTJrM8UpHOAx16yURlk+t2Fz0qzdEqZublLyY1vpoTU8k?=
 =?us-ascii?Q?13351P8f9v9ONJx/RyJ4QWO2v8Sl/IG2mzrTyJir0qRLG20lE5m/XP1tCBIr?=
 =?us-ascii?Q?13xodUGY6qI81OeMoqU21v55PRHPGniie0tgKAoo3KUo9JLvj4K2BT8OUR5S?=
 =?us-ascii?Q?4yNiSt9d9WSkc7ygwQFsiO3yGnz7rK5S6rUFItCQkicLbVDxFPxhMth/VMh0?=
 =?us-ascii?Q?B8Vo7C3UWiRnX5UhC+Tw1sSMvcodGJPDLTbobL9LcIDu0MotgpPbnwWxqmQZ?=
 =?us-ascii?Q?iPJcs5ZFFsSB6EXW/1TW3jwckqPFq+AMz/mzuGWlLMBNcSQlKv0O+oBFF7NS?=
 =?us-ascii?Q?Hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 877dfa4a-73c9-4314-a941-08dc5dfd6e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:10:24.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlzBk8Cqa+5gwmqz/F/tMSwkbRX9lwjASXOtiD8h+SSsQWVci8DLT37rC8fgTqk2vjmLs/k8kQ9RcKb/U4z2+QB+mZ7YuLvmvA0Jacg00Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, April 11, 2024 2:51 AM
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
> > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> >
> > Add base clock hardware abstraction in clocksource structure.
> >
> > Add clocksource ID for x86 ART(Always Running Timer). The newly added
> > clocksource ID and conversion parameters are used to convert time in a
> > clocksource domain to base clock and vice versa.
> >
> > Convert the base clock to the system clock using convert_base_to_cs()
> > in get_device_system_crosststamp().
>=20
> In https://lore.kernel.org/all/875xxhi1ty.ffs@tglx I asked you to provide=
 a
> change log which explains the WHY and not the WHAT. The new change log st=
ill
> fails to explain WHY this change is needed and which problem it is trying=
 to
> solve.

Rephrased the commit message to:
" Add base clock hardware abstraction in clocksource structure.

The core code has a mechanism to convert the ART base clock to
the corresponding tsc value.=20
Provide the generic functionality in convert_base_to_cs() to convert
base clock timestamps to system clocksource without requiring
architecture specific parameters.

Add the infrastructure in get_device_system_crosststamp()."

>=20
> I further asked you to do:
>=20
>     1) Add the clocksource_base struct and provide the infrastructure in
>        get_device_system_crosststamp()
>=20
>     2) Make TSC/ART use it
>=20
> But this still does #1 and #2 in one go.
>=20
> If you don't understand my review comments, then please ask. If you disag=
ree
> with them then please tell me and argue with me.
>=20
> Just ignoring them is not an option.

Sorry Thomas, that was a mis-understanding. We had split only realtime as s=
eparate patch.
We will split the first patch as suggested.=20
	1. Timekeeping part(convert_base_to_cs() and infrastructure in get_device_=
system_crosststamp())
	2. x86(TSC/ART values update into the structure)

Thanks,
Sowjanya

>=20
> Thanks,
>=20
>         tglx

