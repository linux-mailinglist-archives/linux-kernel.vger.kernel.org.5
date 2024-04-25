Return-Path: <linux-kernel+bounces-157873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB568B17DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212CC284406
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E712A34;
	Thu, 25 Apr 2024 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7oF2J19"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E81136E;
	Thu, 25 Apr 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003969; cv=fail; b=sxPUSFueog5yh2fc6+Qzi/FqBJwbem4nGghegvWvClK/1Z0W3FQIwklflLpSO3qTRasNHUnfRlLapnFKCQXVmB8eCnYFAmdbtNVn1O+UqpgkO/VNaocNeMcYn9dR7LAC/kz1NwizVnQSzZJj+XDpj8g1YezQYBvndBNKvbE+aVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003969; c=relaxed/simple;
	bh=7ImAgBBQMI2fMCLWLrxtbt4jeMOHsO3he336I8xXxVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPA85+2NVSH5gwbt4RmvCKlH+oy9R2OhfZ7CRWKVIblOWZT+npewmv1/K1RuSVITLfMC7xJnTZrD2x0ceoiY5zvuJp2reB9HOn+YeEeqNCMJiXL2jKOjQBvgHxU8P1xNsGW0PKrHkV65e4eh1qI+SixUko4DECk8hrnJHxYkdak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7oF2J19; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714003967; x=1745539967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ImAgBBQMI2fMCLWLrxtbt4jeMOHsO3he336I8xXxVE=;
  b=d7oF2J19GOipnaeyCJ59efQdD4Tl2DEALJm3jVaK6oQq6VpA13qdWsT1
   mgBQWa2yKkLAlQk99BrTnjWQb+dePW0qdPN42tWCa7GLU/r7Zu+DE3hQ7
   YKmT4WM7cDilgtwSXbhIoq/1ar1zHaXkJMgQLJeJn2Hgiw6XKWJGHY/4b
   +rG2mHcDouAloy1CfSbAxLDpAOtKf68N2nQMEuT/Si27TpQ48LPlKwZa1
   0rVspvDoGxEFLYDmF38tcFkzsT+2GFcm2Ak7O3jUmYaPtcFbd59wGLGym
   /TvIlh/ib7qKbpn97dCWcF8fHVanbAdlmuOInh19+jfga/br3Kuuw0Okv
   g==;
X-CSE-ConnectionGUID: mYHh5Q/GSFuVYSWyIJkzVQ==
X-CSE-MsgGUID: hSz1T92qQ1yrvKb3703mcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9777144"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9777144"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 17:12:47 -0700
X-CSE-ConnectionGUID: qsgigaAKQICh/gZjUY10UQ==
X-CSE-MsgGUID: 0w7JQEM/TKWuPT6a3n96eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="25389063"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 17:12:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 17:12:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 17:12:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 17:12:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ4EuIj8q+TJOhxWje8gajYeymTFH2tRq2YsAAH7mjJsrkqfyZ85em6LiSTIwRNEP0d4gl2HLHlpNi+FZBAT6EPJd5pXSNNRgi0fCh7aVrm3eR5pmitvkHlfi5wZfPAb54WZdauUT+VQrnhZSSVkKYSeDg4mOq5IpAvdAZBzhf6nFkF4U4azKN5B1ut95fRf+jOnTH27kMVX32lPi89zz1d01XRsmOodq8xWrxPX1/Rvb2hzIFYHWLZ8mP4Ag0pvXxts8+1c5YTvlh7FzqPgZIoZCbM53A5HEXNlH4k/ckBXRWs6ugomwAqRWSw4v9LUHAW0IMBuS8UP7U0LFpJhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6VV4/6D68P4Rc1TvqYj1ppyf9AUY3IoJee5SdVanwM=;
 b=UahBavwddeDlyKeASg6aux/3oxQO9zQ7u8PC8SugICgmNfTdFNxLVDAyBIsoF4HW05FUelLqxwzuP6441nwU+MXSqEzNs473gwpDCeIGnXLbqn79Lh8f7W8M7TAAhDQDNc0py1icWkp5fbuLhQ0vQZ+oEF52qP7ZnppeZhUeHvUQ9dZ9DcLayuBx2Ig1qTorbjbXCemF7Gnkr6FnWaJrWSUkqZeFiiBB3UGOTJ9U0DE7mPG896CPuYWCpB7m2/bkIbcm8/Nq40Xcu+erRZ/rUUNvbOjYpoCGQX6NyNuwe+q9La8jDAZbd346MqBpWM129o8eez3JOu3DRh3lzt8aew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 00:12:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7519.015; Thu, 25 Apr 2024
 00:12:42 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, "Rojewski, Cezary" <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood
	<liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, =?iso-8859-2?Q?Amadeusz_S=B3awi=F1ski?=
	<amadeuszx.slawinski@linux.intel.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v4 68/71] ASoC: Intel: avs: es8336: Switch to new Intel
 CPU model defines
Thread-Topic: [PATCH v4 68/71] ASoC: Intel: avs: es8336: Switch to new Intel
 CPU model defines
Thread-Index: AQHalnNypAm37i9ZEk6+7LiAmvGSwbF4GbEAgAABFJA=
Date: Thu, 25 Apr 2024 00:12:41 +0000
Message-ID: <SJ1PR11MB6083B93F3972A5A41EAB5AA6FC172@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181550.42466-1-tony.luck@intel.com>
 <Zimcol_3kmP2Bv_J@finisterre.sirena.org.uk>
In-Reply-To: <Zimcol_3kmP2Bv_J@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7849:EE_
x-ms-office365-filtering-correlation-id: 64b094fc-0c61-426f-a846-08dc64bc6cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-2?Q?t+YEzK/xGtMAmR8QoX+awtoVzvL9u3Xz2KX6IjhSmcebxMqJfDNPlQdxSe?=
 =?iso-8859-2?Q?AuMhQcJRllKf/ANLEBCwlDshm3g/XLvI819hWE1Y0vcCdrbILhkF03r+z+?=
 =?iso-8859-2?Q?dxbFyza/1va0evBvAemQ4sYLDvdJl67KYcLRbhWvGUBF3r51BcRgkoTv7t?=
 =?iso-8859-2?Q?hJi3bWmq4en+0t317FvZSvJdxy5uxtNsT9JqMrhCLS8XimpAzZrAA0l7+G?=
 =?iso-8859-2?Q?N7uKG/8edhD/SDwPnbfhEAK007iwpFrWbwCW8YCsP651/3YFA3KkGJvwey?=
 =?iso-8859-2?Q?2Yu6rBlt6Ji7oRfFipwVWjFYBmkIa63ItmcQZSw8TZBNAyR42hUty9ZmsN?=
 =?iso-8859-2?Q?MvshcXAkMocM8ONg5gOgznBHAx39k5j6QunXVebiCNVI793+uAW0/vg2S1?=
 =?iso-8859-2?Q?nPpV3cqDpRvDlyxtoN9btBKB5OUdUzRsoLfFw/SDWxCzI7CuCaRPu1GW2i?=
 =?iso-8859-2?Q?EibprZanED8OtAocaUQYUOTFvZ7y4zlI8H0SsIw+wh4fjZEzFrYoQDbFPF?=
 =?iso-8859-2?Q?drIpeFxVx99lE4DgJS5vZQxP42In8OfkveoJ8ExxXnIKEr5jJSbYoxuQ2+?=
 =?iso-8859-2?Q?VhJbvsz90ymGPp7HBR5pazcpCO4BaZzYERtUZr6ryKikhzshdu/GVnd45r?=
 =?iso-8859-2?Q?IoVi5kzkHAgAVJl119aht1nBmTziBemOrqZ8a11/YKyp4PXIM3B07Pn9Gv?=
 =?iso-8859-2?Q?aO6d+vWecNCAttupnk2snPwM/xCmVlIhZjoBDTu8dcBy2Q3YsvPr7ut+sE?=
 =?iso-8859-2?Q?8wA9LKCwHswRFZb2Wb/VA+ItXN10zxqu8qC+8TUcLHl4remAEvDM8k+uFn?=
 =?iso-8859-2?Q?0LrgDNW6uWBBHC08gfPENkXiGcQkRPAPYOg4W2aZGa4o0lrCGSR6vG4R74?=
 =?iso-8859-2?Q?qTN5WgE6iEMfkSNviSiiJfJRW85gCIhlVLTf8NXg4O1CnIz4Lc+TOTBOqF?=
 =?iso-8859-2?Q?86m5PctyUknTnA8EVTWEhtFHJbkKN39I854DxjnVgr5euigsWiNykc/2Qh?=
 =?iso-8859-2?Q?xPynLqcFf16sijQON44coyqahsuGZPZpl8BaQnvVRaPrmvI5AUBm9xSKBd?=
 =?iso-8859-2?Q?BrKkWnr9BXH6ss/Q0IiZ1ORMQXwotGKW7/xzwdcR16uSgQ4uHVi2feRc1j?=
 =?iso-8859-2?Q?ocfAUZq/aoJSDB7AVwVcIUXedu9RTmGwWPvxDA0n5DxiF+Dgd2SMnZzRz6?=
 =?iso-8859-2?Q?Vc6XWZW1M/YhpYfdFeNhTh5TzMGIda29yRyLGH4dskOhscxVVPAN1YZhfu?=
 =?iso-8859-2?Q?lMdPQBbgcEgVoM+pS1WIhNrejoOtLHVtPSbLVaOUtH8sZkNwkmGM8h3961?=
 =?iso-8859-2?Q?Rg4o27TSoITmzmcDPprLNMI3Rp7eeY8HJG5gcbDKwBeka07j5///pWhR8g?=
 =?iso-8859-2?Q?4/8k4d1LIOw49Bg1uLP2qnERD8BdTRTg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?vTYN3OrBk33M1DuK0qwHslH7BZLWKpVm2ZqVFZSeofWv8aRWq0ByrkmMkG?=
 =?iso-8859-2?Q?DrVP7+r2KPNZ0GZM71GfJPeIA+2WlMKOQRfhW2id66LeyQOOGaepcW/Tpc?=
 =?iso-8859-2?Q?TjSuWGCu4g54Cc+vDK/hIf/Z5cO7Oci6CXCWIWZ3QPPlYRD3fpa+0EsSD9?=
 =?iso-8859-2?Q?RGR0eq5LcBIizlEX8PezEZKRM8c2sL8VzChI+uOYIPc8Hly0vzjLjamhX4?=
 =?iso-8859-2?Q?KI4+9HBZjBM9GCj2wzlxOt1bFcVEHb/svEE36GoKd0o/bLjAwIH+xmZn4a?=
 =?iso-8859-2?Q?aLClDF1M3nqXd8LK5D8hd2hiz2rBs/Pt4rfXq0RljjzUy04OutFH2M7T+L?=
 =?iso-8859-2?Q?q3MtmnunDhABvCXRmxcheB8lTI+p5N+PVytn7vanGot4BYJ2jsIdn+2BQl?=
 =?iso-8859-2?Q?C/i064s+FkOTfZLPIKJdJmPNZHkfRheyhogW+Ymv2zoE5mDf5niL/q7Ygx?=
 =?iso-8859-2?Q?1wKOePtGPJ4kD/fE7YX+vFF2/U7Uv6o4d8AyyFip+h3opRtBQMqrQOXJZH?=
 =?iso-8859-2?Q?F1DivsSYd4sX7PLKRH9CS+hNLP650cUSQp/JHZGlwKVTM4L+v2RIMO+8vc?=
 =?iso-8859-2?Q?ccxajNKmFkoT7Fbd04OA25U3R9JFop7a9IHt0+rlREAUcFGjvaSqGNgsm3?=
 =?iso-8859-2?Q?EBp4JLmWFnRM/Vu30DvONTH/+uyvU5gh02akLudzA29hooieFJnitTugAt?=
 =?iso-8859-2?Q?7P3Q3FQAg2n8XrXsy1W5pV6IsLj5TIH0gcRGk/4Dasj3O0Dz3DVSflfOc1?=
 =?iso-8859-2?Q?HpZT1PZ9fm8Hd7VmHRCVvLgxleU0Y/1IxNIdiBwaSzinzRwnyL8pQ+hO/E?=
 =?iso-8859-2?Q?XWlBU4m1KiJPqGmHeLe/OeKUYHvVbpfsIYO6OnOXmI9bM04lBAjxXlsaCi?=
 =?iso-8859-2?Q?FB38/6rp87aZUd8hZzLPZ4o7WMU5/51IVDAB+OP/O43XdyQikUgw4KMcTD?=
 =?iso-8859-2?Q?FwKXLNExPSgTUqwiEs/8mDwUfFjAUusMs+NSO9EsLeAD+jH2tqVcWY5TwC?=
 =?iso-8859-2?Q?BipVBLzyXcf/YvOpfLB/QGPCmuO0Q0WzrqmyqqyYDz6MPDd1xDKN2ec8ms?=
 =?iso-8859-2?Q?njJSLu0bcpHcCzmobsQvsOIsqkyp9eThHuvRkS+s073NLp2aJtsFk4h+gg?=
 =?iso-8859-2?Q?SJgOk4IOPkT5ZCOPmewOTVlZtoCAnF4ctIVOjFTHMrHuILDok+JTzHM9tx?=
 =?iso-8859-2?Q?o3TxXDS4bh3g2zszlemdt4o+zcU+QnurZL//Wj+NIC2KvwYV+n0RnpIjeA?=
 =?iso-8859-2?Q?nwmVnkwg3hhMXBcGxCEI36ZThDl5eirVYqXh9eq7NLovajQiubs1xvvRke?=
 =?iso-8859-2?Q?FNkisaakqYgDDQiF+WAFCcZgMtEb06VpBvwEGX2/7dEqcvJZj+O/ceM/5V?=
 =?iso-8859-2?Q?IdJNIgM+tN7w4Nc3E1znvJxQQ59LenwpEvgb6niKBtB5XMbnQZDFvyJ26n?=
 =?iso-8859-2?Q?42+2UAAwp//tIF1PQD/0Fe4DZ3eaeqTBQOpP3dWhYH2sHa/zR7qrT2GSRK?=
 =?iso-8859-2?Q?MFDp+uoQ7bEdFiIDtzFZ8R1Lcym+EP/JoTwOOKUujQ803Yt+GUHwVpuyIw?=
 =?iso-8859-2?Q?8M+36tubjgeEFD3QeuErF029TmlSML7hMwhlVztj2vI3oF6IH9VjP5deTJ?=
 =?iso-8859-2?Q?1Fwco3PNYnCBAeFEMokhJA/hLbo1H7M00T?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b094fc-0c61-426f-a846-08dc64bc6cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 00:12:41.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+fs+vCQWOiBqW26MpCQ5gtkjIxAhL5j+m2ARe+isKEQRlO5RF4eLlBJKCFIpbRIvre3P7htO5bp3PyMfCdvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com

>> New CPU #defines encode vendor and family as well as model.
>
> This appears to be part of a series but I've no cover letter or anything
> else from it.  What's the story for dependencies and merging?

Sorry. I should have at least added a link to the individual patches to
provide some pointers. It's my first time with a patch bomb of this size,
so I'm learning as I go.

You can pick up the cover letter, and the whole series, from lore with:

$ b4 am 20240424181245.41141-1-tony.luck@intel.com

or pull from: git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git =
new_families_v4

The dependencies for this patch are already in tip x86/cpu, and in linux-ne=
xt.
Basically these three patches:

f055b6260eb3 x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h
e6dfdc2e89a0 x86/cpu/vfm: Add new macros to work with (vendor/family/model)=
 values
a9d0adce6907 x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x8=
6

For merging. This can either go through tip with the rest of the series.
Or you can take it through your own tree after the dependencies get
merged into v6.10-rc1 (I'm expecting this to take a couple of release
cycles to complete).

-Tony



