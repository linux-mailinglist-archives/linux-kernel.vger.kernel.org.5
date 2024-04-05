Return-Path: <linux-kernel+bounces-133308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82489A20F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD486B24B57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBD17106C;
	Fri,  5 Apr 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEz/RNGv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C5171066;
	Fri,  5 Apr 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333202; cv=fail; b=nvUipT1nd6ng3ZMb/Pq4YovbuO3MR0KsK4Nr/yUnPalrHgzCirpz7vCnAY62HFHLu2UHEeLJUJFXFfFxr/ve0mYcnCv54pNcwa72dA5Bx9+yL493WVTja+xBuQbYLGBEh63FEuOEL9dm3cVT2Z7os12oPSGooJEyhEXd8sN02XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333202; c=relaxed/simple;
	bh=aLt6NpyAQ3z6ra1aTwTHuZj9dWky0+m3CMGaMtylQT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xy0G07/mzHaDwrxmlh4CZ7ow087QQDcY39JdJOqUO3ZIeDcY/WRtB4oKgYRtOr1NAhsC94hi7JNaLu6CO8+qaQx8lrNRD4M+C5pT0lMhD/wXykGDYQEsUO64XaMt9kGHFEeFUHX4jnYTzvLQAsh6plOIwTtM2I0Te7e9WJVUJlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEz/RNGv; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712333201; x=1743869201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLt6NpyAQ3z6ra1aTwTHuZj9dWky0+m3CMGaMtylQT4=;
  b=hEz/RNGvyE1/ChBdCkwjTdtcR2X4nSY2j9lDuu1XvKzRwrbE/FCR8hz6
   ZFbtzojzB88TZrAucyF/1EzH1pMVQ2Lg3pehgHsfWvaPrzKvFfdNoAK11
   5cORZnrQmQSLJBicDyR41WhzByBplOSPbgokPon0VguUWtw+160nt21c/
   DLNpPjfXe/xY2KkD40GGowVrw609OO4uh2vBq9MOuw9pLDdcatJlydJFH
   GfhSydcIx6bB8usw9CoMJJY57vwQR8ACFpIzGU8GXR3w/H6Ei1nEWKtvI
   5CkAomyq2UnJYQY5tsSXKlTvHpSLITbeS5NAYxPkIP9ySfqRHbOV2s2sD
   Q==;
X-CSE-ConnectionGUID: JdGlaMqlTiitcs4maGQGkA==
X-CSE-MsgGUID: IzxLgcl0TmadzrnXMwe0+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18278770"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18278770"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:06:40 -0700
X-CSE-ConnectionGUID: jWS8RWZnTVupQOWoS8C+iQ==
X-CSE-MsgGUID: 7WJjk6spT1aEluIVva0L5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19647311"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 09:06:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 09:06:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 09:06:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 09:06:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 09:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXHTx+YMyukhhpQsKYzsQyfGyL6zX/Co0Ntac6fMlxPdh69y1efOIFzBj9u9YZ9IdTAC16daLbhHgCTi6xRgzw0JIAuidMD8Dgunhd1IjMDy6SElLuIcaphFk304cUS42Rep33XnI9HD5sBMK6ntwBjcrA4xmDzobOvptbOy06yRNxlnHWb1pbzrVtvMaBAE1VW4+/9ePUDTkfS/XxsupLpuTixbVS3VK4X3Tros+JJK57QGu9IU+0xfbEjVcVOVjYICBoM68A4tqzFcTqrhEyWBukOlFjrir5m77Nr+vstriqY+iLzVNaEoOw3GgrPrgm0yV+zXm14cSSEFxqYRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p3aRrZ8Tz1pyw+2fCM4XbkiWB6IoaUpVa7F0wt6lwk=;
 b=HEXmaRm4fo3gDpikZ2totiQxNgDhXOyT3qfPVzC9u/MiSwLylJ/adl7aXKjCuYYA0dPWMsqO/j209/bF1M2xAZ/eBdtPb/Y6rdfFZhK3S9lvqbqBKFNgoDb514J2MXWP386AVpNILnc1xDE2+GwhPgBV5F7L8lCr1986Pd8eHIu6OyFaqCpbZKfHpEkofbhhGJ/lDjDySwsxFgE1yT42Wwi/iL9kR19YmDHZBuFDemI2cEm9SYzz4KnHw1iDfVnsQf5iVmVkZjy7Mb1XYg3h+w4pYnAIOgU2LURn9JxO0NnajlIwSDYcJwL+Wq1FwGN/z9cvzCYhNEicmY44es37tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Fri, 5 Apr 2024 16:06:36 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 16:06:36 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Avadhut.Naik@amd.com"
	<Avadhut.Naik@amd.com>, "John.Allen@amd.com" <John.Allen@amd.com>
Subject: RE: [PATCH v2 16/16] EDAC/mce_amd: Add support for FRU Text in MCA
Thread-Topic: [PATCH v2 16/16] EDAC/mce_amd: Add support for FRU Text in MCA
Thread-Index: AQHahqLS7zyVgK2sqUK2yq9QKfANxrFZ2C2w
Date: Fri, 5 Apr 2024 16:06:36 +0000
Message-ID: <SJ1PR11MB6083683CAEA79F935BFA1B31FC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-17-yazen.ghannam@amd.com>
In-Reply-To: <20240404151359.47970-17-yazen.ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB5990:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXyaaZy6NTUXQenvWeLtRUfvbZdSi+Jl1KSgHACZhveCvZyK1bkBuSm2M6o2pT0q+b4FLjsFvPBub6oo0dDow+ve1QmCI9QR0DAWEdoLpMPG1SHckmWSPHdeeRo4SemKQNbU3u0qOqnfwA+kTC94ZBpV8yp70EE4oZ++v2YuT1j0e99h4XbWGc1gK5P7VPlp0J4Eg7a9T7tb9U6Ua3KYMiFm2N3CZdUBVAoSGiKvqghhnZJcHKLE2ECgu42BwzW/K3R48dfg2Gq8jxDPhDj61XfnnPIVT57SF+kXjtfmT9NwNpndQSApNkC1hnHVWx1RwNP4sMgdcpW38fn4BVUbIB23fv9/txejRIbM/VpprF6Llh90L2Sq+VbCb+oaB/ZWIznquVsxy4CT98izJGn0gTCaH1uq5tSr+iwrkjQF+NRTkKgm98TNx186zZ8iXbaJ9mOe9QKS0BC2wVJJ9OeIRvocRSZIw5dIn+tTVmKpVmY/XPqmq8p4Pnllqz4Ak0oYkgMRlKvT1NJtaQQ2yCqHYAfDejOSYm6GHuVlzhlHRNZXZtC4uxF1+zcaF52u30bZ9TaQiX4Gw8vBU72AbEcDFHnFqXbDssC+a6cN9yq+0XRpyQ9Y2QP+8wJJ11ZxN77XU9Lggh68/Ifg2yash2k5a8VK5VBjvg3CDP8Ce8EYKzk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MfD5p+ujzIwE+9VGJySOG4LYMI4maccolN88RsUnZKcUwArIMKUptChmQ5eV?=
 =?us-ascii?Q?jemIAXFqH5SE6uNOatB4t3VEdzW423kbZeJO5GPmX8R1ZPPYzN67Q6pku0D4?=
 =?us-ascii?Q?2nZLXXVFhrXo7Q4HlqFdPC4RbqqMDCkDNK3b/RePIFl8bwBuqYZ4eiT7KnjQ?=
 =?us-ascii?Q?dwhXi9JyKrjaNFFtmXYmnYntZsJTigDDE5FjwCshWfhQ8n1rdFYBQ6hqnxOS?=
 =?us-ascii?Q?fmIdP3lxPAHduBrcsS/wIwew0r5AL+PqT8ynBRlTjWob7phrVVmxSPRLsFKk?=
 =?us-ascii?Q?YlmxsBsZR6sgGKelo4sk35Qm5tChVrnyGexC5ul28VtQyLCp3VSvNl1NbI/d?=
 =?us-ascii?Q?9V0tXcJ0RVCw2uI0zzij0mcNT8nUWykeruqZDNia47T7jb9vJwAse3Fap2J/?=
 =?us-ascii?Q?WcXdoUg+N8N1Nj+VxWhqYFd6lZnkRPYNDSCxjFPYk8fGjD/Z2NjHrD+hSCxV?=
 =?us-ascii?Q?F/3egnpkvPeNLEObXWNFb9+GWCI7SxIz7p0IGbBmV6clXmCyG6mQBzki3gT0?=
 =?us-ascii?Q?+03YAAXyZO0aoh9jNFcCRvY6al/BX4uCM86FmRk2nsfeYOTz2EBnTf8iXzvy?=
 =?us-ascii?Q?3EbcWQHElDsgeOg98gj8NYNK+EM+2q/swxomFMEodhxslCOZqnZnilYM09ZQ?=
 =?us-ascii?Q?RFQ8C3Yj4QllvuVnssyrNKvEC7L59EtKuNpccT0pS6ErXFx9ZO97kMt2Bs8G?=
 =?us-ascii?Q?z1+3zXj8foSJBBMmKl8MrlZLHLWLkdAygFiOUlC5/6nRLLYKWoIcTIxObLLX?=
 =?us-ascii?Q?FjLgc1mcUAxmLjmtFpTKK/W/9A6HodvQbNcD9iRfF+LKbMpbSjLMABnjyMoF?=
 =?us-ascii?Q?qmnLjqcxPUQUw3/QANfhbf2iLBWscjeVz77XwrHuF7ckmndOwhTQA9u3AVgu?=
 =?us-ascii?Q?Di+B4NLIWCBAvpuo7EdqXrbOEhtnRFQI0k33hN4KPIPN3jaTEL8yVbGIX0jd?=
 =?us-ascii?Q?8G7cyZLtUhdmv8vEdKVGSTD2x0/VuehHus0rHpst+HpfUh4qRifGj0sPxnSQ?=
 =?us-ascii?Q?RXGYo4ozIX6m6CYCn5s/q54AelEApZyX6PbBcTSiTce8TI8YRau6sZ9KWvc4?=
 =?us-ascii?Q?Ny7zmGxRmCzQINOfHr7+2295KYRIHdlKwzg/y9uFMrgbagIKmfKlsRIiS8uM?=
 =?us-ascii?Q?VGnehbbYr3ZepSAQhYTIqZCw8mantTY8YT559xykyGlt/Pyw5JonvASmTIS7?=
 =?us-ascii?Q?KwFDT7jQygEx4rWsk3osN/Xn28L8Ij23/KyI6VMFPkjJHGjLZ/LAFkb5213r?=
 =?us-ascii?Q?dYIrfHMkQL0BXLwv8AEebE0zN5sxwa4hH3vN6o3MLozjWAcr5fQCz8kPa6Ce?=
 =?us-ascii?Q?sYnBeNIn8VKwMYUl2Fq86w+H2FlwBC4oVu4hQr9lG6MeMSc5DXY7CGwOVcXq?=
 =?us-ascii?Q?VDCA3xeBOgOCASos4e9lkLk2oJcAoHQMUE00Rz+z8hwoc0RAabA9pqTV3te9?=
 =?us-ascii?Q?xzt/2MP3Rh+GJYnCMR2R2GPBtHFnbSAGpjFMaV0KtXDjZl8UV7/2nyeGVoQ7?=
 =?us-ascii?Q?XsgZmd+HEXbT1dAAo3wg2qI3IE531sa4ug7GHKkxZzabPY2Qi2gmPqXhN0Yn?=
 =?us-ascii?Q?ATgSIHR7jBTqa1JouqWnOYT75hLNkiQ+PAe0AQTN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af00bd7-6760-46c5-eddd-08dc558a5eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 16:06:36.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6jZhLNpYUjR9ECXkL7nJt0bvYcYMrC1pAMeBDQ8gKe+8Wyomf2N/U8RfpSpdeBAUtF7U+Nj6JmfjQLuUt5WBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index aa27729f7899..a4d09dda5fae 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -207,6 +207,8 @@ static void __print_mce(struct mce_hw_err *err)
>                       pr_cont("SYND2 %llx ", err->vi.amd.synd2);
>               if (m->ipid)
>                       pr_cont("IPID %llx ", m->ipid);
> +             if (err->vi.amd.config)

This is in common code. If other vendors start adding their own stuff to th=
e
"vi" union you might incorrectly print this.  Add a vendor check before loo=
king
at values inside "m->vi".

> +                     pr_cont("CONFIG %llx ", err->vi.amd.config);
>       }
>
>       pr_cont("\n");

