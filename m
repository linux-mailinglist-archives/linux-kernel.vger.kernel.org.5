Return-Path: <linux-kernel+bounces-137665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD389E5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65362283EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAD4158D97;
	Tue,  9 Apr 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1/mMTJ3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC969158D8F;
	Tue,  9 Apr 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701551; cv=fail; b=Kv6dplcBITMpqdW58umIrlLK4gYhS1Bryx4tphIhB06IWuAdyj9rxc0XOT7edZ4WeTJ2E1u0eb9joebIZvjUZ2Pqw3bDqujgWF+qUQZzpMydh2h4SBCPjO5XD6DBeUaLoAr/JuoKDWxRzlB9NJjDmg91K6g6p3kMja1hQ1S5ACM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701551; c=relaxed/simple;
	bh=RLXEa6Z4oNnXwJLlwJECryOPvbHopoJcmtnH1p1uPsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+6CGPPEGcXn2CA47GtKZ4dx4BTXeZYZYE2uNO1oYiXRA527l3ZSso+y/7/d/yA1lghyk2P0riSPgte37KIEV/Ogo6hioBqzUcuc4ZA+XdJM714TxkhS2v1QVIF9RVir84zLOKDJJ2D51jaGlRYOz6ls1krCez5YBzpBcml8LDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1/mMTJ3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712701550; x=1744237550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RLXEa6Z4oNnXwJLlwJECryOPvbHopoJcmtnH1p1uPsQ=;
  b=b1/mMTJ35M0d+PhvL87Wu5+XkBonec2gvFqv+ygePFlM9OfQYjmCyCsJ
   JWmPBeL9LQBbpsNcYjQHuuKmxxrrTFLuaEK9rFpUxi47O7u+0Tj3BDhsW
   u1uFlCzntlYRRK6SxvP5qSGF+fvcLdg7Jg4+hC34jCDYGp2FfoWZWMiCV
   CizKNvOzmJmiYtyWZ5Ing88lqlZ6M8AYu+HuJQ4m57gJloVBCLoCvQsWb
   e2V25zmpG8UG7idVhHC4SsJiEyerWwCWEXIOwHiYT/l5E/+EVuc9s64VP
   wSTACvBa2s644/tuM+obzPqeO6ViCC7pyUB/Wv/zx3O9SeaGMwptNj+4y
   Q==;
X-CSE-ConnectionGUID: OZy7BVYHQRCqPYv8oRsWfA==
X-CSE-MsgGUID: rpdoXh7aSHydANgHDha+0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18648648"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18648648"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 15:25:36 -0700
X-CSE-ConnectionGUID: Jos91A68S1qXg8nZRc1Djg==
X-CSE-MsgGUID: HcTdRF3rSEm56NXH4tOeSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24971095"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 15:25:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:25:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 15:25:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 15:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNOUHSTYt1g2KW63I8/Z+ljbMOAcYSB6acKk2K34OOwv5WoCKkyEnpLUJhbFUrLcZogCXeqXJ0tdPmvQmYNvhFFWlW+KMxg4pcU7fvSPJUfMip1OP7NUNP1Vz4uVF0YY6vb1JanX3RcuNy/miN0IuQhrPakxngKq2+fHevYHzSBrjEjf+OeNSZPzRmrLsJUHZBGhy0J3vnr+bL2XJTeuJW+RgXXDvp1adxxPMXxVEkL1UGchqL3Yy2PZdZDwLN7iPqqiOJholBqdbDWrp6XEKUqzNoMmRISX2oXVcjKWDKN72zKMNiDOTj+WAnxjFgW9nKLknyBoe5dBYDDUUHIZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLXEa6Z4oNnXwJLlwJECryOPvbHopoJcmtnH1p1uPsQ=;
 b=XchT/H/tWBQ2jceSvcmkjt/2BZB8ArphxmyZ27gJ5eVX5Yy6hn43pqK8cKGNskAQhXK1yTL18NmpMw6hZNG4Aq5jSbf6Mi6ZtOEz5P5YZ1g2AwPI3nJD9lYJR40TsFd8c686DjLclcmsgNp3CBe/r2M+5+4YPp9NuaeZlArjEM5a49e1hsBzLgRoF7Niiq6QxyluWtzj1Q5kwrCT7csQk4narV6K0hM86VB551uMMT8gkOneSIdAHGL15T1ZdBH9RJDfEti6s9Xm/DqtMfK5MUKn9406nb/ENShLB9cb0umjLo2xaRuvvbESxGYI5FIgvuTnjecOQnhhiPHmijynvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7985.namprd11.prod.outlook.com (2603:10b6:510:240::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 9 Apr
 2024 22:25:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 22:25:33 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Kees Cook <keescook@chromium.org>, Steven Rostedt <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Guenter
 Roeck" <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
	"wklin@google.com" <wklin@google.com>, Vineeth Remanan Pillai
	<vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>, "Suleiman
 Souhlal" <suleiman@google.com>, Linus Torvalds
	<torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: RE: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Thread-Topic: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Thread-Index: AQHaisJ+v0vo99/TW0W5001BvMsHNLFgcvIAgAAPmQCAAAEJsA==
Date: Tue, 9 Apr 2024 22:25:33 +0000
Message-ID: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240409210254.660888920@goodmis.org>
 <20240409172358.34ea19f0@gandalf.local.home> <202404091519.B7B2221@keescook>
In-Reply-To: <202404091519.B7B2221@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7985:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7YjJ8FBkhTb/ALcTIO1XbblHWjEhwsYI0Dex1lbKyU9agf99i81SeDph90USVRw5iU6/eNPTny3SyeqM+Os/8UY7fqqvOryStBaWdJLBCwsuZuXsjJbtgp3Am65HdCMNlIQD6+7cTrfo35RMInQpMaQ1FoTT8fcidW0IH9QGvmNuMMcCFjBeaEp8cICEy9dvY2lys1/JumHiIFHIOWEBF1wJ0zH47xBMeMh54cuU1gbp/OarB3CwRpeiPsOsKniNeDzRdtC2BDAVQSe/pKNZuo9OPMmkeNwsMIArP09jxnPGhbJDlEbnuomZBupsmwkksd8kOy7vGg5rUlesPgtCeo3+iG+74Zwujo1EdXXrZ/aCxvf9OWyD1bL/LZPo0vUmEJSATucjGdphhkOT6qRf0sDezFpbA+Et0jjh/MPYb/sy/UShg9HErm2neCndVg+LbigY8fxc715/PYhRiu5jSsMwIRdYmObt7TLGmdGGMCITr3PH2KwYOYarnHHCA6+soUePawUo0tIIY+4ggUnBO+tWK3L17K8tDRyQbePXCP8sS5T6+UkJqWsqXwYuJ0VUAL3O7DYZGAOooik71iLQFDqaLGbjN7KQ4Qh6kjk/XXu4gKmPpAtVSW3+fkRmFXeb3kM9H0xV4QT+jbBVQpH4NbZsm46vWMED1fBXiGjB2nk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RfbZNWD/a81Y8SfzAOltlvdN9TJpAQC3MlGd905Buzty8a9SrCbr2GMEZbEI?=
 =?us-ascii?Q?K6J5AMewCN/ONqTY+VBg7mqm1PwmqsjuXQujVXIwlsnkclWCcwZpCC/hwDKY?=
 =?us-ascii?Q?AKQkOi11cKv+MH7C+R3BnM6qpGoNmXg9IFBbm9BX4YzoBs85lu6jSP+kUizw?=
 =?us-ascii?Q?gm6Ldrf5NPwaNFTr8iXjESN90PaMol3jzYxAWXz1wYp85grsjnqDlJWtCJtp?=
 =?us-ascii?Q?xPMvJAoR79SWvlel01OBd/aoEIKfYizGQ1ycfSaXIhxLNTUb3MrQ3lvmnlWC?=
 =?us-ascii?Q?YC2Ll3Czg1Y93AdChABlwQRqRuEO3qTvRpPX9j5+8xBow8Ns84BUDGVt1h8g?=
 =?us-ascii?Q?5T5xAXq51imAiKprOtAEp056ipKLk/xLpdtuIW6k8h/PKs/Y+/+PaKMzyirw?=
 =?us-ascii?Q?M/RiD3EjsYt7V5zzOpo91EiC8WnJiDjxd/QuZnIA0sZyj6LrsSsOExj1KU1w?=
 =?us-ascii?Q?DYkGrz9EkmyR3Aqbvv0E7lRTSUOwm/a2/VKj4x6A6mh5jj+GJBL1zEXKuwYj?=
 =?us-ascii?Q?hWcsKyIte5KIC3Itg79mw6RgC64rm1J7S68HSjbiPMPCl+ypX6SWmJBnTmxg?=
 =?us-ascii?Q?wmPI9FFTPTIJpAu+2aXCN82Bbf6WfPBS3MtIqLtryPNE05hy8Bv8jlKVH2qw?=
 =?us-ascii?Q?Jww5ks22l1pfgtkOwdO4iy4mnL2GBJA94S0vO+YkM7SS5a6lV+fl5yGBYw2a?=
 =?us-ascii?Q?gEhogm/nfah8F8ievXDgTSK3phWE/KdTkCFF9Ue3RDflWKixZI7zfa19/ZP9?=
 =?us-ascii?Q?ytEBfEIOdjCf9QHKIIW7Z1lgwPw45n0C6WvsNZ07dicfWFUxqdQzYuUcQBXK?=
 =?us-ascii?Q?rnp5UdDbcikZUhE/IyZMMJY5YPPnr/bL4Tr4NemDNPixSnEy+OoJtWEd79Zt?=
 =?us-ascii?Q?FQ999n/0P3sB07qc6U2D5jHAX0GVKWAyDIH0CHU9w8UdFbZjx0buoujR4Q4c?=
 =?us-ascii?Q?q/HSHWKtXTyEAeM6pbATGQ9FLXtQnY8ccCXjQF66uZR7h8oMu127d3Ox3LUP?=
 =?us-ascii?Q?w0EZ37jdfHkrX6tcGOIB6RdBOb26lYW8WUesYYnTt9t3JsWvI7usDeLrBGyu?=
 =?us-ascii?Q?t1p83VCx/aF8HCLNyjwcxYtqUrTpcjngt3VWNfcdUGR697+lSvWTZDS/Awey?=
 =?us-ascii?Q?KDC+DTY/yqROOK8EltUAPLONqBIBGInqAdV/aHSExGQhZg90adJwndhPGcXb?=
 =?us-ascii?Q?1O89j08Fw92tA9ppO6BgoNfCenlLtVs1HG8QDhlMRsuJB5C9I/p6RXqogttY?=
 =?us-ascii?Q?3yYE6190oShOMorMJgN9umnBvuMx0BvheltOPx5c7k/N4VfctZjmLFzk9XTm?=
 =?us-ascii?Q?BFbMpOJ6scGuTW9uXjM0sRhaeDefBIEQCJjWhx/xYFzEIz8e3ft3dEB4HH4A?=
 =?us-ascii?Q?mD2g9TxdYwwLwR7vs578iWdUjbHc5qWdHoowETd2gLOyh/TGK0BnzULh3ugT?=
 =?us-ascii?Q?VVk/dBSou9iqdhLXBNvTjLHAbSheOk+bvjNd03HIqDTi2KzUWNIefShKGVjT?=
 =?us-ascii?Q?30wffshtzcjB2/1BChsGj7tmHkuPJCW9tYFyf8pfoyXuXckl1BnD0cCSIVb/?=
 =?us-ascii?Q?d9jJDGVxZDsr5attIckce7U7rKlWQopXYtZY5a7/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4d32d8-3f9e-4ff8-2abe-08dc58e3f8a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 22:25:33.1884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ia8EKEvz5dssTvct9o+OS/UZpsvLSUZP4wjkleDXK930sLBD2uv3d0KOAPaiCoCMRkkXKxkuQXUGW0axZl5UcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7985
X-OriginatorOrg: intel.com

>> I forgot to mention that this makes it trivial for any machine that does=
n't
>> clear memory on soft-reboot, to enable console ramoops (to have access t=
o
>> the last boot dmesg without needing serial).
>>=20
>> I tested this on a couple of my test boxes and on QEMU, and it works rat=
her
>> well.
>
> I've long wanted a "stable for this machine and kernel" memory region
> like this for pstore. It would make testing much easier.

Which systems does this work on? I'd assume that servers (and anything
else with ECC memory) would nuke contents while resetting ECC to clean
state.

-Tony

