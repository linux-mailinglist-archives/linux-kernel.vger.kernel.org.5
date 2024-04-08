Return-Path: <linux-kernel+bounces-135715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6D89CA27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB05D1C244AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7B14387A;
	Mon,  8 Apr 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNYbLIqA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B21428E5;
	Mon,  8 Apr 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595351; cv=fail; b=q1OYntb2W7b0usr27d/FiZQkaFOoN0lARh6k+/oiJVSS0q0h1fFoCP3E+XUrnHF0eoiqocLf5wTwta21owwXm9Bd/+jl0g7aVsXrtU5ALbU1wzkA2p2mww1uX0q+wsVTMxBOBjtdZlUxAOrxNsTU323WI/OHpAgwr/g3g0eLYmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595351; c=relaxed/simple;
	bh=Q2YCEPOKD27Kvgu9XUHs8Bjpbsaq2++WyzqYDR18FP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SG3PVqiikGSntgy+AdnovlAUqutWXT/N2NbwoxDZMimtKE/KHSiaKw4PnQagXz8bCl/3sUoiHyBXERFYFwPLzd6tUSAiQOowCZJPKQSuGj8wMt9Z9u+jNai88dwBce3/0zfP4RoFLsEfUIsJG4LHUzxEkkHa8rPKmnMAF3QeiY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNYbLIqA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712595350; x=1744131350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q2YCEPOKD27Kvgu9XUHs8Bjpbsaq2++WyzqYDR18FP8=;
  b=VNYbLIqAJuc41zUE55CaiOsi0cGWWScBDRQY2cBFbuuZkuqoDQwUzgDx
   ZNyq9GK5pTM3XhY8XqFkdnU3dmgvzim4IeERVsRM2EKUEpV+OuuEW8SLS
   WSSLkc8R77ssLF5t9cfK/UbJgcdi/R7IfvGdL7FfksenFFJhg7bb1lrvU
   oIc6lKqXavhXTY9wL4I5RYi3WikDt1YVk9TwqK0r+Kh8cM6iDgIpWZSaW
   Tac1QYfV6X6Z5iyiqjN5oCLFIUvFlB6L6LVd3KrBBm4k/txb5loyyivQS
   2+mB+5N6Hp/hMR5WHWjITTGT7QzX2cV5dPN3NnR0KoGJgSs2X1+8GdRqI
   w==;
X-CSE-ConnectionGUID: Yu6k1zatRqOXJrKlOUEtQQ==
X-CSE-MsgGUID: yIe4M1QrT3S70IIsWCuRmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8010674"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8010674"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:55:50 -0700
X-CSE-ConnectionGUID: YH43KSESSgiD1p3NZN4wfA==
X-CSE-MsgGUID: KolsLDCiRsyGcKIO2sAJgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="50944487"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 09:55:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 09:55:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 09:55:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 09:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaYr9R2SCZjeUoQce437tFibl4D9BCFy8rdtK8VqW27H8QFQXeocPmq8e0G52e6U9s3kiY/mdrkz6SDoFS/MfKXMGn3YPZyKUzUNLMtM9TkFJ4eXjfrv6yGtUjAIaxPkNdiBiE4E+TV58HDogoTTZsdFcNe7h0m0A9iiIees9n8d3PxgwKIle4x4UZpwdTAxdL4VzBvecoy53Zkh2nVeGFMXJxxCe3GRAbMz0MT+PfCq2XdwU+Q9/ffiso2WCXzEoSncVDzlcppunurT1NyZayUx2NMwX9xkDjEz8/3l3MAjHyGHWT/lxXNa5N7QzES6KIqAXEVOqLmFWJeJ4XiWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW6ezPALpRs7mjlp4axSstSpA7R049Xvkul7g3La70Y=;
 b=XS5lq33OFNJb+GqXtJXy82GYW3EJu1o5OYRbMaQ2hmAZtMU4bF12dMn7ec9rqoOnfoyX5MC+Qgj2LusZZttmsfdB+xgkrHs2ulP8Eiaar5e34/dedA7uxyjkhX4xd1e7tUxT7rVvGdW5Jvb2Y3NE2qHW4USQKjzBeFgD9C6jMwxTvL1w5oz9dh8rEk6xkbEJzuYJIF1mxG87/vwa4vzTOT15uFPgfKuvDP2v3ognehZ7fgXsQfRPpYnelzlglAy9mLKfhr3YDLeO8n43NkgSmbW/fvH2o6Xsv/47HWyIhxV/KKZpIToA6Vjvmb2Tzzqn+I+60CmEEN7Y84w4W29AZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW5PR11MB5812.namprd11.prod.outlook.com (2603:10b6:303:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 16:55:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 16:55:45 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/skx_common: Allow decoding of SGX addresses
Thread-Topic: [PATCH 1/1] EDAC/skx_common: Allow decoding of SGX addresses
Thread-Index: AQHaia2f2CNS23nXgUuxV811MB56urFel4XA
Date: Mon, 8 Apr 2024 16:55:45 +0000
Message-ID: <SJ1PR11MB6083B84EB8178FDF6C5582CAFC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240408120419.50234-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20240408120419.50234-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW5PR11MB5812:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ljvef6Bw+E6hvfdrmqNV1mxVs1ZEiLZpBpKcTHMfVyELiezgkD2oLmDgJHpXdJEvRNqerElbfzuDds/a5Y0BQcgyS/h4M6OtdHZhM/izh9RhK9M59WC56V3K1fdjXykyJ66hFPiXFHFqRgo9jMFQeuLj2Nu9EU8OLgJzvRefVyOSqSwNTDkOGw5iXdaayFd9ki8uzC18bynjnl2ML7XEsLTfJWO97i7njhN0ATWTvrV5yvymmRluAfaxvccfU23A1rLaouMRUsP1WdPR4OXXsdVbvrftU19du3bHj539SStDT9/4vsTLNWGJyTILaoEqzUeZxOvcWeDIfNIA5zcN68iphi0zXN7y3ZhDEbLSbMSCQUJAQuQHMYOTyXWTuaExS9gaArF9krMS6VYjzuGW5lQ9F4bHYQViy53vb5FxNptJj2A/fY+LKjZ/ffKCJ8iS6u4duAubpytubH/bvxrIMVsOV2iV0QlWqEMSfKNX21zKhFHhOJ8DmMufJHSzXX1QVD8eHBpuXxEpuah7QMxmkI/g2LY55dF+bBStBIn4Aa7cd3CXWY9BaAv21kF4MVfuPNjqx1ES9R63yaP87l7t2GU3qvNA4Wpg+t0N/auSg63XDzV0ldH0EQxWo51sKflDyTzrvOntl1q1P4u4UO2E+EXqMxMI+iu/aWWtQDROHIw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bjmb3TOMhUXIvIvRyfpEFKSNZKKLcp0bhlFbbZHDyiTKiUzI4nCoEy6ABqe6?=
 =?us-ascii?Q?klL9/jgj4/0u6pKy2EjQf6LmBoP99Z/TdTPj7rE4SUTxl1rTlImXIGH3XS2L?=
 =?us-ascii?Q?y+BtF6pRPqE/ouuKhRbqXRIvlMRTmegx9avP5Qjf41MaoN4TxN1MFwxPYfpW?=
 =?us-ascii?Q?Clu1sn5h5U4R5ehQo2UrTmaTwrJitz6XAFV1KfTUQ57WlslOLE2l5RlAlQZs?=
 =?us-ascii?Q?4Li6JVrvr/XdsTw2ElFM5cc2b/Np6XJ7j9iWrxgLwY4EIWlg5jO2281cyVXJ?=
 =?us-ascii?Q?uBo3CAxPeg4KizYHtEz3BWuTfspRrZ0PP2vrMn/5ImNpeuljbij5Fi02/enN?=
 =?us-ascii?Q?tvwJ4aP3dGE1kytpav81wvHQZ90yrwnWXGBr77KhdStLw8ukqE4Vg1eR9OmI?=
 =?us-ascii?Q?f88VdNcnXDA5XPLB2pwyFIcjmYGKyFwtvEtyNyXuQVtn29ZlHBr4jwa4kZme?=
 =?us-ascii?Q?bg8VvC/GcQ9IZhSkuyit7a4BYOe7hPtkh4SkVMB9jk1vsRjWPgvyHx/YG75M?=
 =?us-ascii?Q?MePxl0GLBazBbAxB4sBjcpsrauBUHcBwJWv+YlG1J0Uw+axp8Y2XUJmhcsaw?=
 =?us-ascii?Q?bopAUE7pTI1Qe+ZnyfZwbOtILLCzoy26O8pjh6v6skPxm0MQvZCbd5HTyY6M?=
 =?us-ascii?Q?9Kpcqc/bzXae6Sfvz0K4W+FBTT3rt9zgy0z/vHmbGgu/4EG7svLGGqunM+lj?=
 =?us-ascii?Q?PiRGQ2dmTdRWFSRtDKD+deMl3zXBMQb/7JRzec0gNJBCCFy1lY7Z7goPdh76?=
 =?us-ascii?Q?Pc+qbOl188ALiJunuOh1TNl+m+AT18jhBq4fOtpQS5F6OZvpKGqJNaws6GtQ?=
 =?us-ascii?Q?ZtzIugYCWCYwj/kQSXJITAlabFQvaIv+w/T3URLUl0zXE6NZNHzZfOXCVgy2?=
 =?us-ascii?Q?2svjtaMe3yj+VT9Le6qqBVym4LH87on4vMGTpnL7p+yF0ovhGySrSv6bZKso?=
 =?us-ascii?Q?YOcYhCwDB+spyjfmzGuhElL4BV+9F93RiC6Rj16oTW4kipx/cW/3tm4N6LDV?=
 =?us-ascii?Q?vnf0gHXxOJmYtARgur+aOtLC73uYWU1zc7rmlQgm4Ylyk+AKTBRwccBkvBgg?=
 =?us-ascii?Q?JCX0u2kiSMPKIg4aDuK4DgecupXCDQ4E5MABR/3XMatbRym3fSoY184Gkbv4?=
 =?us-ascii?Q?ibq0wMH4ySDmr4JqqdQKLDpfAPGeuyOZiMeaTnaQ1zAfehqfpLeHm7ULAccp?=
 =?us-ascii?Q?GZIAfqfvVscA2suCrIjdgvdbNcb99wUfjX5Ey2D8vtpdaL5+IiKm96/JTr01?=
 =?us-ascii?Q?kCBnl+ignokacKBulIZMW4taWIdxtASb0jzGcteN75eRcpuhcojARG7H/MPX?=
 =?us-ascii?Q?tp2xePZlyFP5I52vfC097ZXEV0lOF8QWsVT1UH8AsUze1QtehozbvZ7HFFWH?=
 =?us-ascii?Q?BS1rkDZIqlbQY85DEgpFTGKv7m9ftY8i0iqWlfBi5ISLNgu0c5j0TfoGbj37?=
 =?us-ascii?Q?b2nNtzCsuf5m59HIlGd+wmSrLFtPWHT3XrSF/Qe389D3Vsjx10aDnwmiMLRq?=
 =?us-ascii?Q?CBzaElvSfMjTrFsQLvslCEDMyOBVR54s3oaTi0RnsbVXttyRzvTKeJALALlK?=
 =?us-ascii?Q?jFe3F909WFRu00bpDqmaU3kR5FZsj8zkZbmql5PL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5a1db2-1ffc-4221-3bd8-08dc57ecbbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 16:55:45.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqvg/hdK2790FOyS5q/151HpfAZKX4EZfF70ZehWEo0UwwbpR8BloQfPWZHH2IpW2BzJpkEfqHIswPL/fAFkuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5812
X-OriginatorOrg: intel.com

> There are no "struct page" associations with SGX pages, causing the check
> pfn_to_online_page() to fail. This results in the inability to decode the
> SGX addresses and warning messages like:
>
>   Invalid address 0x34cc9a98840 in IA32_MC17_ADDR
>
> Add an additional check to allow the decoding of the error address and to
> skip the warning message, if the error address is an SGX address.

Applied. Thanks.

-Tony

