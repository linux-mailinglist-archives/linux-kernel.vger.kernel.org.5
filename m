Return-Path: <linux-kernel+bounces-146176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050E8A61B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9591D1C21428
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8B817550;
	Tue, 16 Apr 2024 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlRryzta"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C911C92;
	Tue, 16 Apr 2024 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713238166; cv=fail; b=a07xMnJp00szk3n+o4XPPNm01FEZHkmoHHS4d14xjeF+WnfQ9NufBzuz8P+IM1GzP0T0WpdjXzmJ6p7uZlo7GuJ680TetowmCZ2YpigACUco9MFKTLWMA+QiA27/ANystMOJAB9a5DGFP57pQ723Kp8tgTL6YqUYsn+8W3eyd/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713238166; c=relaxed/simple;
	bh=t2nXUvxhGl78/71g2/0XYLCW832N4G1YvVW3ZVzf7FM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IXoj4yDb8MIqi4Wsk79gI7z0ymdZMPHBTEZEP5pSXmsWcvTNT35mR4nnYCn6sWu5nOxYxX8lsGe3F4YfN6oovJ+ERPHfijQH8ejEUpC0kYYDnt3OekDVrGwTxTXlKh6DJcXXH40wz26+6MYBaWQiVJ9Kl7QcmmpvH9fW1Y987Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlRryzta; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713238159; x=1744774159;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=t2nXUvxhGl78/71g2/0XYLCW832N4G1YvVW3ZVzf7FM=;
  b=MlRryztaHBOxpMz2uRfYalLCiUD3Ph5DJIY3KDNw8807qnumi2wXUlf0
   /uYzbXDuUoEVvI2/36eKSCdSwxwt6zaQm7JQNNoGiPJmQbtqTzL0hZ+IS
   mENCuDEkTCdaBiZcR4i9QoYm6ddOxJneleQgSU1QQXN9Byh9p5oLYZstU
   Vb0rFCiGbsn8yr8sMNBsy3mjwTeD0AC3NU5qVFKLZXEF8RvN6JRtpct3B
   R+IhQg4HVU+COfzDjXXq5vtmW8TpR+avmOvX3IvwGzMZXJ9w7R5McAaTT
   GTVnK6we3G9tPRluGjH/7k8Zl+QwFCkZy0w0Lml0hAcAxMoPzPsvVM8uq
   A==;
X-CSE-ConnectionGUID: QLolEZKgTnmzXKJCOibNeQ==
X-CSE-MsgGUID: v0t9CrVKRPCQkPHJAqWD3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12444088"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="12444088"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:29:16 -0700
X-CSE-ConnectionGUID: +GZq6t6wQiSoOkHl7NnHog==
X-CSE-MsgGUID: Qmno+xApQt+uTuRNQ9iEWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="53304763"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 20:29:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 20:29:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 20:29:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 20:29:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 20:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUefbGEkEdWsI2jNIpsbL2KFr0G8uwlZxgP++mUCgE44wvVB8cNDGRy7Uic8Cc4+GPcWnHWK8FlCq93YVE1Qy8dP2LFXbj0v2CtXlfYVsl21yS7DEc+Ox+e5raxRcEYoFyT5sMJWZdEty0X3faWzF5RUsjIj+5euMKG6clWAmkJ9dOCVmk59LqqzC4MSCq75Pjl0n2al6X1557Qxm6vBJxEnEx8yKreS9pBA7Sr6ElV0qyk9RJ08unU6e5+FZyA95KanhytktbKnCn9JT8YsV++V8Pccm5LIbvPT81WDm/Iz9qdXuWC9NQ3Y5ofw9fNPtbGhiLkYVbaHNBN+fbrrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrDF2qiuvjXAMZZWyerV3cUQyXqPnBiLBNvKynBo6K8=;
 b=ONfK9MFbSql8Y1BOAyp/kmV1v2xzmH6RA3usj8Mc3xu8W2iUm73I0MiA39OUtWxCOrAdNteoY38Q9d2Tun6N/B/0ekC2AOl9UKgtr5raCIKulYzsucdRf8V+ZAoHCpQgd0oI24puWCsw23l2WuYmlquXeebfeg5vKdktIaL1L8I9n2EtHMwawkk3Ohc1Tz0/r/HUo6KsxKutd7a40fOTQ2qDljOEaiQ7/PXO6G15/ioS1YRkNavlA0X9eKBJ7fRUaz/DjpqRArO4AASMPZHkHmf84q3LNIZ+aPVyVKd7iFCt6//jqWHjiNo8MqJM5kDKRm9IYCZgvo930mO0IPahBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Tue, 16 Apr
 2024 03:29:08 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:29:08 +0000
Date: Tue, 16 Apr 2024 11:24:19 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Kumaravel Thiagarajan
	<kumaravel.thiagarajan@microchip.com>, Tharun Kumar P
	<tharunkumar.pasumarthi@microchip.com>, Russell King <linux@armlinux.org.uk>,
	Vineet Gupta <vgupta@kernel.org>, Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Alexander Shiyan <shc_work@mail.ru>, Baruch Siach <baruch@tkos.co.il>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Taichi Sugaya
	<sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Orson
 Zhai" <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller"
	<davem@davemloft.net>, Hammer Hsieh <hammerh0314@gmail.com>, Peter Korsgaard
	<jacmet@sunsite.dk>, Timur Tabi <timur@kernel.org>, Michal Simek
	<michal.simek@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
Message-ID: <Zh3vY99GFFyKJF0B@xpf.sh.intel.com>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <20240405060826.2521-13-jirislaby@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405060826.2521-13-jirislaby@kernel.org>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CO1PR11MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 3775fd2b-9a97-4aaa-4fa9-08dc5dc55fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z206Hl/tnL41kHEe5ZIANg6dBmAqBokm018Y5LeNRmVvIE/RV4ufFb6EVFJW98PPRtsdfbHUm0Pc/hPrhjK0H9cxfVaJS4Mz/blNhuMFrU4hQfA55eVXSjpmjXBpI2Fr/Mi7VgPcx8vHKKAkLz3icCUuJYBMit0LRGGH9EKU+Gsrc8DJv3mtRkTHlvGukO2cj8FgdWTndKQ3Bj6obTDfd87nTxRizqkb9LxsIaQ/9b0tYPjqDemvJwpwxxAH6c6LG6L2KYJu+OxViYoXvlZ+bGdBWQ024xhroj25cm7+vNk6tIdFqmUb068VyJ9KonI2TYi10ArKP+lxZ2k/zA2zrLxaA/zCDkXERYXVL4vR/paktCDpp/E5ioqQoHyl3Xjj5TjJAGm2NileNvZPbYtpMBHHbhJy54hyGSayV54RqG8r8URXOibrOnZFiOIQwC2yO/NLiHmmr64ad2a7Q8/D/W3oXMGNKq9EIedH0meMU6cKRMsZ/UCbq/hunJ8YBbxGP0klALmqhpAyHdEapFGw7bZWZehqqlnGtY4/cV9DCx0DUV1gon38B6Glxk6TgmOvTaSoyfM8qVbxgVfLhzVKzilGRlz5YU62H7LT8KJbBbH3hRM2kKSAPsaPQWfA4ihMHkgtI5G6NyYy+UIJtOwQqkyjWWasSrPEsCaxHxPeXWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?m3VFjDGbk3AuJ4LENg2tK+vDb4M4k4Ff97ItCRAzmVNp2L+FwyiVJtYrWd?=
 =?iso-8859-1?Q?Nturyahdya+giovVEJ4nX3P1UhXzUy4VMuF6kycpf93aNHL7hYmDFi1ULe?=
 =?iso-8859-1?Q?nGp3oS7M9KyxAqB9sYvxyswbMWbwrDfPU7CgjhSZFDk2Xs6G39roqheyy5?=
 =?iso-8859-1?Q?wMW/m+XOkACYYd2BuNIgWsZn/EETmwLNntBWj1mk+O2HXY7kTgsiFHmZ3X?=
 =?iso-8859-1?Q?QMXHsxcU5ahnlgu8xtr0wY7+QV6uLdK06xNmEHguxD+cHksmY8Fn9Usth7?=
 =?iso-8859-1?Q?ve8mFJWpBVbIoUfFYpcoTQwnmSp0bo+ilUjh8H88iKEGtDI3rbBtlSKl5k?=
 =?iso-8859-1?Q?V9Fba8xgSskPsRWCTNJLfMfJ07mXNBZII1xn9+CvBWCAanu7vuctgF+tpo?=
 =?iso-8859-1?Q?Ft3MuEyxErVEQW/7A2R9fnnCvOhzQV7gNeaBunqkxFDUTEUFMRlhuat+3e?=
 =?iso-8859-1?Q?fNm6AUPhEbgBpO9nnDAAitwb+75lDQ+NNATBvaHJktpPm2YAt/B9SYHvo8?=
 =?iso-8859-1?Q?Pc1Nx7LNAhWHCy242koCK2GzFHDdfPbnjWD9AWBBJVaWXTPiWE+hiKgs6Y?=
 =?iso-8859-1?Q?cQOax+aDwHfa7uryCiy5KG8hGC5+/Z5it3L2hDRa4VTzGUBfw4iLE+BeBj?=
 =?iso-8859-1?Q?wNcU9R7wSoEj3x9OzwJKUwwsuBV8nQXygXdcz6w9kpa0fwatgkHEu1AEZ4?=
 =?iso-8859-1?Q?gdwAj7rHrqeUjK6f3qWyFroZ9PhCz/as5bDLCQG6fOxfQ4sIDtNm9cF2KY?=
 =?iso-8859-1?Q?ofXfL4SkFSIZIn5emXs7w5IhHJeU3flgAucbyEFz4nI7bYIhpDVCxO04Vu?=
 =?iso-8859-1?Q?V5Tcb7zN5N6j+pAKBQbk7fZfEHGLrQmCnXHawRsyqhdVZMCO8kZwrKqfFX?=
 =?iso-8859-1?Q?+ykGyaLhurKsTm8/FdIVrqIyjcPRfcxXLNdZNCtalvEJEcJ9nsHZyzV1Pf?=
 =?iso-8859-1?Q?gq+zUCc7dfOcKDMUu7jyTiSTzhdX/WJ2DNxHsmEDcQ0j90AW+BJ3Fvkdg8?=
 =?iso-8859-1?Q?Ill43WXpueMAQTo9IknHnEmDmDKii0ok0KRh0WU7FNXRijPBW4LQKQfwav?=
 =?iso-8859-1?Q?fGr36XkVV5KcUpFOSy3x0u4NwYLpAjz2bNA5SR5+MV8xvfmJU5LOKGAFW/?=
 =?iso-8859-1?Q?gzH4YdI1uIl6X6vKqwVkNoLfcpMB01YxsyMYU2trBioXgzAERyYJwuvI8D?=
 =?iso-8859-1?Q?jIwW5Sr2LZcsUyqnvE2Wqvf4OyhLxNJ3j7WVapX8elXXyf8IfvjS9gMhZT?=
 =?iso-8859-1?Q?ZjE4uWhRjhO6FV77Q0mZk15Jo5uM+i7ueWHAUy0VEi5L57bm5IBCsf2ChR?=
 =?iso-8859-1?Q?6vYnKcoL0JnPiKg4NAAW7+LhEzAXQCJo59nqLDmGsfiaQlqPDspAmJaGx9?=
 =?iso-8859-1?Q?1ztIQdnLLp9arRYtClh3qmx465lvXQ/DiGPzwiKfaA4nXtOvhcgq8xH+ul?=
 =?iso-8859-1?Q?kw02x58JYgfSo2HKMwEbe8EXA+wXlTWkyB8DCpI3AaoZBJv8u6u1lEk/KG?=
 =?iso-8859-1?Q?MARBwMywkBaDS7AL4mp+LADZmVB/HftziKqFlSaZGcerABstpDH0o4n7Fq?=
 =?iso-8859-1?Q?wz87UvEnWggrZ4/7z+2ai9iSIa58nrhybFBHYc3akD422DcXkq9eVldRSn?=
 =?iso-8859-1?Q?S3gO7NSyqS9X5O0DErmJqlfLL0Z45Por7z55kU8iF9rBvvDcfVE/ZbuQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3775fd2b-9a97-4aaa-4fa9-08dc5dc55fdb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 03:29:08.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubTLmDaeTbi58RFOuE9fEOi46PYsy0wM6qMjQcrGFpj/l3ybT8qCshilT8xk7oz9IyW5iEVSpwU6XgioBUQSWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com

Hi Jiri Slaby,

On 2024-04-05 at 08:08:23 +0200, Jiri Slaby (SUSE) wrote:
> Switch from struct circ_buf to proper kfifo. kfifo provides much better
> API, esp. when wrap-around of the buffer needs to be taken into account.
> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
> 
> Kfifo API can also fill in scatter-gather DMA structures, so it easier
> for that use case too. Look at lpuart_dma_tx() for example. Note that
> not all drivers can be converted to that (like atmel_serial), they
> handle DMA specially.
> 
> Note that usb-serial uses kfifo for TX for ages.
> 
> omap needed a bit more care as it needs to put a char into FIFO to start
> the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
> do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
> out if it is worths to do DMA at all -- size >= 4), the second time for
> the actual transfer.
> 
> All traces of circ_buf are removed from serial_core.h (and its struct
> uart_state).
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Cc: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
> Cc: Takao Orito <orito.takao@socionext.com>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Hammer Hsieh <hammerh0314@gmail.com>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> ---
>  drivers/tty/serial/8250/8250_bcm7271.c  | 14 +++---
>  drivers/tty/serial/8250/8250_core.c     |  3 +-
>  drivers/tty/serial/8250/8250_dma.c      | 23 ++++++----
>  drivers/tty/serial/8250/8250_exar.c     |  5 ++-
>  drivers/tty/serial/8250/8250_mtk.c      |  2 +-
>  drivers/tty/serial/8250/8250_omap.c     | 47 +++++++++++++-------
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 50 ++++++++++------------
>  drivers/tty/serial/8250/8250_port.c     | 22 ++++++----
>  drivers/tty/serial/amba-pl011.c         | 46 +++++++++-----------
>  drivers/tty/serial/ar933x_uart.c        | 15 +++----
>  drivers/tty/serial/arc_uart.c           |  8 ++--
>  drivers/tty/serial/atmel_serial.c       | 57 +++++++++++++------------
>  drivers/tty/serial/clps711x.c           | 12 +++---
>  drivers/tty/serial/cpm_uart.c           | 20 +++------
>  drivers/tty/serial/digicolor-usart.c    | 12 +++---
>  drivers/tty/serial/dz.c                 | 13 +++---
>  drivers/tty/serial/fsl_linflexuart.c    | 17 ++++----
>  drivers/tty/serial/fsl_lpuart.c         | 39 ++++++++---------
>  drivers/tty/serial/icom.c               | 25 +++--------
>  drivers/tty/serial/imx.c                | 54 ++++++++++-------------
>  drivers/tty/serial/ip22zilog.c          | 26 ++++++-----
>  drivers/tty/serial/jsm/jsm_cls.c        | 29 ++++---------
>  drivers/tty/serial/jsm/jsm_neo.c        | 38 ++++++-----------
>  drivers/tty/serial/max3100.c            | 14 +++---
>  drivers/tty/serial/max310x.c            | 35 +++++++--------
>  drivers/tty/serial/men_z135_uart.c      | 26 +++++------
>  drivers/tty/serial/meson_uart.c         | 11 +++--
>  drivers/tty/serial/milbeaut_usio.c      | 15 ++++---
>  drivers/tty/serial/msm_serial.c         | 30 ++++++-------
>  drivers/tty/serial/mvebu-uart.c         |  8 ++--
>  drivers/tty/serial/mxs-auart.c          | 23 +++-------
>  drivers/tty/serial/pch_uart.c           | 21 +++++----
>  drivers/tty/serial/pic32_uart.c         | 15 +++----
>  drivers/tty/serial/pmac_zilog.c         | 24 +++++------
>  drivers/tty/serial/qcom_geni_serial.c   | 36 ++++++++--------
>  drivers/tty/serial/rda-uart.c           | 17 +++-----
>  drivers/tty/serial/samsung_tty.c        | 54 ++++++++++++-----------
>  drivers/tty/serial/sb1250-duart.c       | 13 +++---
>  drivers/tty/serial/sc16is7xx.c          | 40 +++++++----------
>  drivers/tty/serial/sccnxp.c             | 16 ++++---
>  drivers/tty/serial/serial-tegra.c       | 43 ++++++++++---------
>  drivers/tty/serial/serial_core.c        | 56 +++++++++---------------
>  drivers/tty/serial/serial_port.c        |  2 +-
>  drivers/tty/serial/sh-sci.c             | 51 +++++++++++-----------
>  drivers/tty/serial/sprd_serial.c        | 20 ++++-----
>  drivers/tty/serial/st-asc.c             |  4 +-
>  drivers/tty/serial/stm32-usart.c        | 52 +++++++++-------------
>  drivers/tty/serial/sunhv.c              | 35 ++++++++-------
>  drivers/tty/serial/sunplus-uart.c       | 16 ++++---
>  drivers/tty/serial/sunsab.c             | 30 +++++++------
>  drivers/tty/serial/sunsu.c              | 15 ++++---
>  drivers/tty/serial/sunzilog.c           | 27 ++++++------
>  drivers/tty/serial/tegra-tcu.c          | 10 +++--
>  drivers/tty/serial/timbuart.c           | 17 +++-----
>  drivers/tty/serial/uartlite.c           | 13 +++---
>  drivers/tty/serial/ucc_uart.c           | 20 +++------
>  drivers/tty/serial/xilinx_uartps.c      | 20 ++++-----
>  drivers/tty/serial/zs.c                 | 13 +++---
>  include/linux/serial_core.h             | 49 +++++++++++++--------
>  59 files changed, 688 insertions(+), 780 deletions(-)
> 

Greeting!
I used syzkaller and Internal v6.9-rc4 kernel which include Linux next kernel,
and found deadlock in console_flush_all issue, bisected the commit is:
"
1788cf6a91d9 tty: serial: switch from circ_buf to kfifo
"

All info: https://github.com/xupengfe/syzkaller_logs/tree/main/240415_195447_console_flush_all
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240415_195447_console_flush_all/repro.c
Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240415_195447_console_flush_all/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240415_195447_console_flush_all/repro.report
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240415_195447_console_flush_all/bisect_info.log
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240415_195447_console_flush_all/kconfig_origin
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240415_195447_console_flush_all/df0b4fecf9eb384062e52e3b572ee8c431afc63b_dmesg.log
Issue bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240415_195447_console_flush_all/bzImage_df0b4fecf_v6.9-rc4_next.tar.gz

[   17.841572] ------------[ cut here ]------------
[   17.841624] 
[   17.841628] ======================================================
[   17.841631] WARNING: possible circular locking dependency detected
[   17.841632] 6.9.0-rc4-df0b4fecf9eb+ #1 Not tainted
[   17.841636] ------------------------------------------------------
[   17.841638] repro/726 is trying to acquire lock:
[   17.841641] ffffffff86d6da80 (console_owner){....}-{0:0}, at: console_flush_all+0x51a/0xc40
[   17.841665] 
[   17.841665] but task is already holding lock:
[   17.841667] ffffffff89aa52b8 (&port_lock_key){-...}-{2:2}, at: uart_put_char+0x118/0x510
[   17.841684] 
[   17.841684] which lock already depends on the new lock.
[   17.841684] 
[   17.841686] 
[   17.841686] the existing dependency chain (in reverse order) is:
[   17.841687] 
[   17.841687] -> #1 (&port_lock_key){-...}-{2:2}:
[   17.841695]        _raw_spin_lock_irqsave+0x52/0x80
[   17.841707]        serial8250_console_write+0xad4/0x10a0
[   17.841715]        univ8250_console_write+0x6f/0x90
[   17.841723]        console_flush_all+0x55c/0xc40
[   17.841730]        console_unlock+0xb6/0x240
[   17.841738]        vprintk_emit+0x2d0/0x680
[   17.841745]        vprintk_default+0x2f/0x40
[   17.841752]        vprintk+0xd0/0x170
[   17.841758]        _printk+0xc4/0x100
[   17.841764]        register_console+0xcb4/0x13e0
[   17.841771]        univ8250_console_init+0x41/0x60
[   17.841783]        console_init+0xae/0x5a0
[   17.841793]        start_kernel+0x275/0x510
[   17.841799]        x86_64_start_reservations+0x1c/0x30
[   17.841807]        x86_64_start_kernel+0xa0/0xb0
[   17.841815]        common_startup_64+0x13e/0x141
[   17.841826] 
[   17.841826] -> #0 (console_owner){....}-{0:0}:
[   17.841833]        __lock_acquire+0x2fc1/0x5ca0
[   17.841843]        lock_acquire+0x1c8/0x550
[   17.841850]        console_flush_all+0x52f/0xc40
[   17.841857]        console_unlock+0xb6/0x240
[   17.841864]        vprintk_emit+0x2d0/0x680
[   17.841870]        vprintk_default+0x2f/0x40
[   17.841877]        vprintk+0xd0/0x170
[   17.841884]        _printk+0xc4/0x100
[   17.841889]        report_bug+0x26a/0x4b0
[   17.841897]        handle_bug+0xa2/0x130
[   17.841905]        exc_invalid_op+0x3c/0x80
[   17.841912]        asm_exc_invalid_op+0x1f/0x30
[   17.841923]        uart_put_char+0x3ac/0x510
[   17.841929]        tty_put_char+0xce/0x170
[   17.841937]        do_output_char+0x164/0x890
[   17.841947]        __process_echoes+0x225/0xb30
[   17.841954]        n_tty_receive_buf_common+0x4cb/0x16c0
[   17.841960]        n_tty_receive_buf+0x3a/0x50
[   17.841966]        tty_ioctl+0x529/0x1740
[   17.841973]        __x64_sys_ioctl+0x1b9/0x230
[   17.841983]        x64_sys_call+0x120d/0x20c0
[   17.841990]        do_syscall_64+0x6f/0x150
[   17.841996]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.842004] 
[   17.842004] other info that might help us debug this:
[   17.842004] 
[   17.842005]  Possible unsafe locking scenario:
[   17.842005] 
[   17.842007]        CPU0                    CPU1
[   17.842008]        ----                    ----
[   17.842009]   lock(&port_lock_key);
[   17.842013]                                lock(console_owner);
[   17.842016]                                lock(&port_lock_key);
[   17.842020]   lock(console_owner);
[   17.842023] 
[   17.842023]  *** DEADLOCK ***
[   17.842023] 
[   17.842024] 7 locks held by repro/726:
[   17.842028]  #0: ffff888018b120a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3f/0x50
[   17.842042]  #1: ffff88800c6d0ca0 (&buf->lock){+.+.}-{3:3}, at: tty_buffer_lock_exclusive+0x39/0x50
[   17.842059]  #2: ffff888018b122e8 (&tty->termios_rwsem){++++}-{3:3}, at: n_tty_receive_buf_common+0x97/0x16c0
[   17.842074]  #3: ffffc90000bd2380 (&ldata->output_lock){+.+.}-{3:3}, at: n_tty_receive_buf_common+0x495/0x16c0
[   17.842088]  #4: ffffffff89aa52b8 (&port_lock_key){-...}-{2:2}, at: uart_put_char+0x118/0x510
[   17.842103]  #5: ffffffff86e4e0e0 (console_lock){+.+.}-{0:0}, at: vprintk_default+0x2f/0x40
[   17.842118]  #6: ffffffff86e4e150 (console_srcu){....}-{0:0}, at: console_flush_all+0x14d/0xc40
[   17.842133] 
[   17.842133] stack backtrace:
[   17.842136] CPU: 0 PID: 726 Comm: repro Not tainted 6.9.0-rc4-df0b4fecf9eb+ #1
[   17.842143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.842146] Call Trace:
[   17.842150]  <TASK>
[   17.842153]  dump_stack_lvl+0xea/0x150
[   17.842162]  dump_stack+0x19/0x20
[   17.842168]  print_circular_bug+0x477/0x740
[   17.842179]  check_noncircular+0x2f4/0x3e0
[   17.842189]  ? __pfx_check_noncircular+0x10/0x10
[   17.842200]  ? lockdep_lock+0xd0/0x1d0
[   17.842207]  ? __pfx_lockdep_lock+0x10/0x10
[   17.842217]  __lock_acquire+0x2fc1/0x5ca0
[   17.842232]  ? __pfx___lock_acquire+0x10/0x10
[   17.842243]  lock_acquire+0x1c8/0x550
[   17.842252]  ? console_flush_all+0x51a/0xc40
[   17.842261]  ? __pfx_lock_acquire+0x10/0x10
[   17.842269]  ? __pfx_lock_release+0x10/0x10
[   17.842278]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   17.842289]  console_flush_all+0x52f/0xc40
[   17.842296]  ? console_flush_all+0x51a/0xc40
[   17.842307]  ? __pfx_console_flush_all+0x10/0x10
[   17.842316]  ? lock_acquire+0x1d8/0x550
[   17.842326]  console_unlock+0xb6/0x240
[   17.842334]  ? __pfx_console_unlock+0x10/0x10
[   17.842342]  ? do_raw_spin_unlock+0x15c/0x210
[   17.842349]  ? _raw_spin_unlock_irqrestore+0x45/0x70
[   17.842357]  ? vprintk_default+0x2f/0x40
[   17.842366]  vprintk_emit+0x2d0/0x680
[   17.842377]  vprintk_default+0x2f/0x40
[   17.842385]  vprintk+0xd0/0x170
[   17.842394]  _printk+0xc4/0x100
[   17.842400]  ? __pfx__printk+0x10/0x10
[   17.842408]  ? __pfx___lock_acquire+0x10/0x10
[   17.842417]  ? lockdep_unlock+0xf5/0x250
[   17.842424]  ? report_bug+0x25e/0x4b0
[   17.842430]  ? report_bug+0x253/0x4b0
[   17.842437]  ? uart_put_char+0x3ac/0x510
[   17.842444]  report_bug+0x26a/0x4b0
[   17.842451]  ? uart_put_char+0x3ac/0x510
[   17.842461]  handle_bug+0xa2/0x130
[   17.842469]  exc_invalid_op+0x3c/0x80
[   17.842479]  asm_exc_invalid_op+0x1f/0x30
[   17.842487] RIP: 0010:uart_put_char+0x3ac/0x510
[   17.842495] Code: 49 8b bc 24 08 01 00 00 31 c9 ba 01 00 00 00 be 03 00 00 00 48 81 c7 a0 03 00 00 e8 ce 78 e4 fd e9 63 ff ff ff e8 44 b8 0b fe <0f> 0b e8 3d b8 0b fe 4d 8d ac 24 08 01 00 00 4c 89 f6 4c 89 e7 e8
[   17.842502] RSP: 0018:ffff888010ec7a40 EFLAGS: 00010093
[   17.842509] RAX: 0000000000000000 RBX: ffff88800c6d0be8 RCX: ffffffff81420511
[   17.842514] RDX: ffff88801cd8ca00 RSI: ffffffff83590dec RDI: ffff88800c6d0f48
[   17.842518] RBP: ffff888010ec7a80 R08: 0000000000000001 R09: ffffed10021d8f34
[   17.842522] R10: 0000000000000003 R11: 0000000000000001 R12: ffffffff89aa52a0
[   17.842527] R13: ffff88800c6d0f84 R14: 0000000000000293 R15: ffffffff83590a40
[   17.842532]  ? __pfx_uart_put_char+0x10/0x10
[   17.842542]  ? do_raw_spin_lock+0x141/0x280
[   17.842549]  ? uart_put_char+0x3ac/0x510
[   17.842560]  ? __pfx_uart_put_char+0x10/0x10
[   17.842567]  tty_put_char+0xce/0x170
[   17.842574]  ? __pfx_tty_put_char+0x10/0x10
[   17.842581]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   17.842589]  ? lockdep_hardirqs_on+0x89/0x110
[   17.842599]  do_output_char+0x164/0x890
[   17.842609]  __process_echoes+0x225/0xb30
[   17.842622]  n_tty_receive_buf_common+0x4cb/0x16c0
[   17.842629]  ? __pfx___mutex_lock+0x10/0x10
[   17.842643]  ? __pfx_n_tty_receive_buf+0x10/0x10
[   17.842650]  n_tty_receive_buf+0x3a/0x50
[   17.842658]  tty_ioctl+0x529/0x1740
[   17.842667]  ? __pfx_tty_ioctl+0x10/0x10
[   17.842674]  ? lock_release+0x415/0x800
[   17.842683]  ? __pfx_lock_release+0x10/0x10
[   17.842694]  ? __this_cpu_preempt_check+0x21/0x30
[   17.842703]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   17.842715]  ? lockdep_hardirqs_on+0x89/0x110
[   17.842723]  ? trace_hardirqs_on+0x51/0x60
[   17.842732]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   17.842741]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   17.842751]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   17.842759]  ? security_file_ioctl+0x9d/0xd0
[   17.842771]  ? __pfx_tty_ioctl+0x10/0x10
[   17.842781]  __x64_sys_ioctl+0x1b9/0x230
[   17.842793]  x64_sys_call+0x120d/0x20c0
[   17.842799]  do_syscall_64+0x6f/0x150
[   17.842807]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.842817] RIP: 0033:0x7f53ca43ee5d
[   17.842823] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   17.842829] RSP: 002b:00007ffce9c89108 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   17.842835] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f53ca43ee5d
[   17.842839] RDX: 0000000020000000 RSI: 0000000000005412 RDI: 0000000000000003
[   17.842843] RBP: 00007ffce9c89120 R08: 0000000000000800 R09: 0000000000000800
[   17.842849] R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffce9c89238
[   17.842853] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007f53ca71e000
[   17.842863]  </TASK>
[   17.879899] WARNING: CPU: 0 PID: 726 at drivers/tty/serial/serial_core.c:561 uart_put_char+0x3ac/0x510
[   17.880328] Modules linked in:
[   17.880477] CPU: 0 PID: 726 Comm: repro Not tainted 6.9.0-rc4-df0b4fecf9eb+ #1
[   17.880808] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.881320] RIP: 0010:uart_put_char+0x3ac/0x510
[   17.881538] Code: 49 8b bc 24 08 01 00 00 31 c9 ba 01 00 00 00 be 03 00 00 00 48 81 c7 a0 03 00 00 e8 ce 78 e4 fd e9 63 ff ff ff e8 44 b8 0b fe <0f> 0b e8 3d b8 0b fe 4d 8d ac 24 08 01 00 00 4c 89 f6 4c 89 e7 e8
[   17.882367] RSP: 0018:ffff888010ec7a40 EFLAGS: 00010093
[   17.882610] RAX: 0000000000000000 RBX: ffff88800c6d0be8 RCX: ffffffff81420511
[   17.882935] RDX: ffff88801cd8ca00 RSI: ffffffff83590dec RDI: ffff88800c6d0f48
[   17.883260] RBP: ffff888010ec7a80 R08: 0000000000000001 R09: ffffed10021d8f34
[   17.883588] R10: 0000000000000003 R11: 0000000000000001 R12: ffffffff89aa52a0
[   17.883913] R13: ffff88800c6d0f84 R14: 0000000000000293 R15: ffffffff83590a40
[   17.884239] FS:  00007f53ca6d7600(0000) GS:ffff88806ca00000(0000) knlGS:0000000000000000
[   17.884606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.884872] CR2: 0000000020000040 CR3: 00000000118de000 CR4: 0000000000750ef0
[   17.885198] PKRU: 55555554
[   17.885329] Call Trace:
[   17.885448]  <TASK>
[   17.885554]  ? show_regs+0xa8/0xc0
[   17.885724]  ? __warn+0xee/0x380
[   17.885888]  ? report_bug+0x25e/0x4b0
[   17.886064]  ? uart_put_char+0x3ac/0x510
[   17.886254]  ? report_bug+0x2cb/0x4b0
[   17.886431]  ? uart_put_char+0x3ac/0x510
[   17.886622]  ? handle_bug+0xa2/0x130
[   17.886798]  ? exc_invalid_op+0x3c/0x80
[   17.886985]  ? asm_exc_invalid_op+0x1f/0x30
[   17.887186]  ? __pfx_uart_put_char+0x10/0x10
[   17.887397]  ? do_raw_spin_lock+0x141/0x280
[   17.887604]  ? uart_put_char+0x3ac/0x510
[   17.887795]  ? uart_put_char+0x3ac/0x510
[   17.887987]  ? __pfx_uart_put_char+0x10/0x10
[   17.888193]  tty_put_char+0xce/0x170
[   17.888367]  ? __pfx_tty_put_char+0x10/0x10
[   17.888566]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   17.888801]  ? lockdep_hardirqs_on+0x89/0x110
[   17.889014]  do_output_char+0x164/0x890
[   17.889203]  __process_echoes+0x225/0xb30
[   17.889403]  n_tty_receive_buf_common+0x4cb/0x16c0
[   17.889629]  ? __pfx___mutex_lock+0x10/0x10
[   17.889836]  ? __pfx_n_tty_receive_buf+0x10/0x10
[   17.890055]  n_tty_receive_buf+0x3a/0x50
[   17.890244]  tty_ioctl+0x529/0x1740
[   17.890417]  ? __pfx_tty_ioctl+0x10/0x10
[   17.890608]  ? lock_release+0x415/0x800
[   17.890797]  ? __pfx_lock_release+0x10/0x10
[   17.891002]  ? __this_cpu_preempt_check+0x21/0x30
[   17.891227]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   17.891526]  ? lockdep_hardirqs_on+0x89/0x110
[   17.891737]  ? trace_hardirqs_on+0x51/0x60
[   17.891933]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   17.892227]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   17.892460]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   17.892715]  ? security_file_ioctl+0x9d/0xd0
[   17.892921]  ? __pfx_tty_ioctl+0x10/0x10
[   17.893111]  __x64_sys_ioctl+0x1b9/0x230
[   17.893303]  x64_sys_call+0x120d/0x20c0
[   17.893487]  do_syscall_64+0x6f/0x150
[   17.893664]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.893904] RIP: 0033:0x7f53ca43ee5d
[   17.894075] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   17.894904] RSP: 002b:00007ffce9c89108 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   17.895249] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f53ca43ee5d
[   17.895578] RDX: 0000000020000000 RSI: 0000000000005412 RDI: 0000000000000003
[   17.895903] RBP: 00007ffce9c89120 R08: 0000000000000800 R09: 0000000000000800
[   17.896229] R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffce9c89238
[   17.896553] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007f53ca71e000
[   17.896884]  </TASK>
[   17.896993] irq event stamp: 3868
[   17.897152] hardirqs last  enabled at (3867): [<ffffffff856c5e05>] _raw_spin_unlock_irqrestore+0x35/0x70
[   17.897582] hardirqs last disabled at (3868): [<ffffffff856c5ab0>] _raw_spin_lock_irqsave+0x70/0x80
[   17.897994] softirqs last  enabled at (1736): [<ffffffff811172dd>] fpu_flush_thread+0x2fd/0x3e0
[   17.898396] softirqs last disabled at (1734): [<ffffffff8111721e>] fpu_flush_thread+0x23e/0x3e0
[   17.898797] ---[ end trace 0000000000000000 ]---

Hope reproduced code and bisection is helpful.


---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
./configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!


> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index 5daa38d9c64e..de270863eb5e 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -413,20 +413,18 @@ static int stop_tx_dma(struct uart_8250_port *p)
>  static int brcmuart_tx_dma(struct uart_8250_port *p)
>  {
>  	struct brcmuart_priv *priv = p->port.private_data;
> -	struct circ_buf *xmit = &p->port.state->xmit;
> +	struct tty_port *tport = &p->port.state->port;
>  	u32 tx_size;
>  
>  	if (uart_tx_stopped(&p->port) || priv->tx_running ||
> -		uart_circ_empty(xmit)) {
> +		kfifo_is_empty(&tport->xmit_fifo)) {
>  		return 0;
>  	}
> -	tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  
>  	priv->dma.tx_err = 0;
> -	memcpy(priv->tx_buf, &xmit->buf[xmit->tail], tx_size);
> -	uart_xmit_advance(&p->port, tx_size);
> +	tx_size = uart_fifo_out(&p->port, priv->tx_buf, UART_XMIT_SIZE);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&p->port);
>  
>  	udma_writel(priv, REGS_DMA_TX, UDMA_TX_TRANSFER_LEN, tx_size);
> @@ -540,7 +538,7 @@ static void brcmuart_tx_isr(struct uart_port *up, u32 isr)
>  	struct brcmuart_priv *priv = up->private_data;
>  	struct device *dev = up->dev;
>  	struct uart_8250_port *port_8250 = up_to_u8250p(up);
> -	struct circ_buf	*xmit = &port_8250->port.state->xmit;
> +	struct tty_port *tport = &port_8250->port.state->port;
>  
>  	if (isr & UDMA_INTR_TX_ABORT) {
>  		if (priv->tx_running)
> @@ -548,7 +546,7 @@ static void brcmuart_tx_isr(struct uart_port *up, u32 isr)
>  		return;
>  	}
>  	priv->tx_running = false;
> -	if (!uart_circ_empty(xmit) && !uart_tx_stopped(up))
> +	if (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(up))
>  		brcmuart_tx_dma(port_8250);
>  }
>  
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index b62ad9006780..3a1936b7f05f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -280,7 +280,8 @@ static void serial8250_backup_timeout(struct timer_list *t)
>  	 */
>  	lsr = serial_lsr_in(up);
>  	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
> -	    (!uart_circ_empty(&up->port.state->xmit) || up->port.x_char) &&
> +	    (!kfifo_is_empty(&up->port.state->port.xmit_fifo) ||
> +	     up->port.x_char) &&
>  	    (lsr & UART_LSR_THRE)) {
>  		iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
>  		iir |= UART_IIR_THRI;
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 8b2c3f478b17..8a353e3cc3dd 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -15,7 +15,7 @@ static void __dma_tx_complete(void *param)
>  {
>  	struct uart_8250_port	*p = param;
>  	struct uart_8250_dma	*dma = p->dma;
> -	struct circ_buf		*xmit = &p->port.state->xmit;
> +	struct tty_port		*tport = &p->port.state->port;
>  	unsigned long	flags;
>  	int		ret;
>  
> @@ -28,7 +28,7 @@ static void __dma_tx_complete(void *param)
>  
>  	uart_xmit_advance(&p->port, dma->tx_size);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&p->port);
>  
>  	ret = serial8250_tx_dma(p);
> @@ -86,7 +86,7 @@ static void dma_rx_complete(void *param)
>  int serial8250_tx_dma(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma		*dma = p->dma;
> -	struct circ_buf			*xmit = &p->port.state->xmit;
> +	struct tty_port			*tport = &p->port.state->port;
>  	struct dma_async_tx_descriptor	*desc;
>  	struct uart_port		*up = &p->port;
>  	struct scatterlist sg;
> @@ -103,18 +103,23 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>  		uart_xchar_out(up, UART_TX);
>  	}
>  
> -	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
> +	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {
>  		/* We have been called from __dma_tx_complete() */
>  		return 0;
>  	}
>  
> -	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> -
>  	serial8250_do_prepare_tx_dma(p);
>  
>  	sg_init_table(&sg, 1);
> -	sg_dma_address(&sg) = dma->tx_addr + xmit->tail;
> -	sg_dma_len(&sg) = dma->tx_size;
> +	/* kfifo can do more than one sg, we don't (quite yet) */
> +	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
> +					   UART_XMIT_SIZE, dma->tx_addr);
> +
> +	/* we already checked empty fifo above, so there should be something */
> +	if (WARN_ON_ONCE(ret != 1))
> +		return 0;
> +
> +	dma->tx_size = sg_dma_len(&sg);
>  
>  	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1,
>  				       DMA_MEM_TO_DEV,
> @@ -257,7 +262,7 @@ int serial8250_request_dma(struct uart_8250_port *p)
>  
>  	/* TX buffer */
>  	dma->tx_addr = dma_map_single(dma->txchan->device->dev,
> -					p->port.state->xmit.buf,
> +					p->port.state->port.xmit_buf,
>  					UART_XMIT_SIZE,
>  					DMA_TO_DEVICE);
>  	if (dma_mapping_error(dma->txchan->device->dev, dma->tx_addr)) {
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 0440df7de1ed..f89dabfc0f97 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -214,7 +214,7 @@ static void exar_shutdown(struct uart_port *port)
>  {
>  	bool tx_complete = false;
>  	struct uart_8250_port *up = up_to_u8250p(port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	int i = 0;
>  	u16 lsr;
>  
> @@ -225,7 +225,8 @@ static void exar_shutdown(struct uart_port *port)
>  		else
>  			tx_complete = false;
>  		usleep_range(1000, 1100);
> -	} while (!uart_circ_empty(xmit) && !tx_complete && i++ < 1000);
> +	} while (!kfifo_is_empty(&tport->xmit_fifo) &&
> +			!tx_complete && i++ < 1000);
>  
>  	serial8250_do_shutdown(port);
>  }
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 9ff6bbe9c086..c365a349421a 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -199,7 +199,7 @@ static int mtk8250_startup(struct uart_port *port)
>  
>  	if (up->dma) {
>  		data->rx_status = DMA_RX_START;
> -		uart_circ_clear(&port->state->xmit);
> +		kfifo_reset(&port->state->port.xmit_fifo);
>  	}
>  #endif
>  	memset(&port->icount, 0, sizeof(port->icount));
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 879e77b30701..c07d924d5add 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1094,7 +1094,7 @@ static void omap_8250_dma_tx_complete(void *param)
>  {
>  	struct uart_8250_port	*p = param;
>  	struct uart_8250_dma	*dma = p->dma;
> -	struct circ_buf		*xmit = &p->port.state->xmit;
> +	struct tty_port		*tport = &p->port.state->port;
>  	unsigned long		flags;
>  	bool			en_thri = false;
>  	struct omap8250_priv	*priv = p->port.private_data;
> @@ -1113,10 +1113,10 @@ static void omap_8250_dma_tx_complete(void *param)
>  		omap8250_restore_regs(p);
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&p->port);
>  
> -	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port)) {
> +	if (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(&p->port)) {
>  		int ret;
>  
>  		ret = omap_8250_tx_dma(p);
> @@ -1138,15 +1138,15 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma		*dma = p->dma;
>  	struct omap8250_priv		*priv = p->port.private_data;
> -	struct circ_buf			*xmit = &p->port.state->xmit;
> +	struct tty_port			*tport = &p->port.state->port;
>  	struct dma_async_tx_descriptor	*desc;
>  	struct scatterlist sg;
> -	unsigned int	skip_byte = 0;
> +	int skip_byte = -1;
>  	int ret;
>  
>  	if (dma->tx_running)
>  		return 0;
> -	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
> +	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {
>  
>  		/*
>  		 * Even if no data, we need to return an error for the two cases
> @@ -1161,8 +1161,18 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  		return 0;
>  	}
>  
> -	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	sg_init_table(&sg, 1);
> +	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
> +					   UART_XMIT_SIZE, dma->tx_addr);
> +	if (ret != 1) {
> +		serial8250_clear_THRI(p);
> +		return 0;
> +	}
> +
> +	dma->tx_size = sg_dma_len(&sg);
> +
>  	if (priv->habit & OMAP_DMA_TX_KICK) {
> +		unsigned char c;
>  		u8 tx_lvl;
>  
>  		/*
> @@ -1189,13 +1199,16 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  			ret = -EINVAL;
>  			goto err;
>  		}
> -		skip_byte = 1;
> +		if (!kfifo_get(&tport->xmit_fifo, &c)) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		skip_byte = c;
> +		/* now we need to recompute due to kfifo_get */
> +		kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
> +				UART_XMIT_SIZE, dma->tx_addr);
>  	}
>  
> -	sg_init_table(&sg, 1);
> -	sg_dma_address(&sg) = dma->tx_addr + xmit->tail + skip_byte;
> -	sg_dma_len(&sg) = dma->tx_size - skip_byte;
> -
>  	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
>  			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc) {
> @@ -1218,11 +1231,13 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>  		dma->tx_err = 0;
>  
>  	serial8250_clear_THRI(p);
> -	if (skip_byte)
> -		serial_out(p, UART_TX, xmit->buf[xmit->tail]);
> -	return 0;
> +	ret = 0;
> +	goto out_skip;
>  err:
>  	dma->tx_err = 1;
> +out_skip:
> +	if (skip_byte >= 0)
> +		serial_out(p, UART_TX, skip_byte);
>  	return ret;
>  }
>  
> @@ -1311,7 +1326,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
>  	serial8250_modem_status(up);
>  	if (status & UART_LSR_THRE && up->dma->tx_err) {
>  		if (uart_tx_stopped(&up->port) ||
> -		    uart_circ_empty(&up->port.state->xmit)) {
> +		    kfifo_is_empty(&up->port.state->port.xmit_fifo)) {
>  			up->dma->tx_err = 0;
>  			serial8250_tx_chars(up);
>  		} else  {
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 2fbb5851f788..d3930bf32fe4 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -382,10 +382,10 @@ static void pci1xxxx_rx_burst(struct uart_port *port, u32 uart_status)
>  }
>  
>  static void pci1xxxx_process_write_data(struct uart_port *port,
> -					struct circ_buf *xmit,
>  					int *data_empty_count,
>  					u32 *valid_byte_count)
>  {
> +	struct tty_port *tport = &port->state->port;
>  	u32 valid_burst_count = *valid_byte_count / UART_BURST_SIZE;
>  
>  	/*
> @@ -395,41 +395,36 @@ static void pci1xxxx_process_write_data(struct uart_port *port,
>  	 * one byte at a time.
>  	 */
>  	while (valid_burst_count) {
> +		u32 c;
> +
>  		if (*data_empty_count - UART_BURST_SIZE < 0)
>  			break;
> -		if (xmit->tail > (UART_XMIT_SIZE - UART_BURST_SIZE))
> +		if (kfifo_len(&tport->xmit_fifo) < UART_BURST_SIZE)
> +			break;
> +		if (WARN_ON(kfifo_out(&tport->xmit_fifo, (u8 *)&c, sizeof(c)) !=
> +		    sizeof(c)))
>  			break;
> -		writel(*(unsigned int *)&xmit->buf[xmit->tail],
> -		       port->membase + UART_TX_BURST_FIFO);
> +		writel(c, port->membase + UART_TX_BURST_FIFO);
>  		*valid_byte_count -= UART_BURST_SIZE;
>  		*data_empty_count -= UART_BURST_SIZE;
>  		valid_burst_count -= UART_BYTE_SIZE;
> -
> -		xmit->tail = (xmit->tail + UART_BURST_SIZE) &
> -			     (UART_XMIT_SIZE - 1);
>  	}
>  
>  	while (*valid_byte_count) {
> -		if (*data_empty_count - UART_BYTE_SIZE < 0)
> +		u8 c;
> +
> +		if (!kfifo_get(&tport->xmit_fifo, &c))
>  			break;
> -		writeb(xmit->buf[xmit->tail], port->membase +
> -		       UART_TX_BYTE_FIFO);
> +		writeb(c, port->membase + UART_TX_BYTE_FIFO);
>  		*data_empty_count -= UART_BYTE_SIZE;
>  		*valid_byte_count -= UART_BYTE_SIZE;
>  
> -		/*
> -		 * When the tail of the circular buffer is reached, the next
> -		 * byte is transferred to the beginning of the buffer.
> -		 */
> -		xmit->tail = (xmit->tail + UART_BYTE_SIZE) &
> -			     (UART_XMIT_SIZE - 1);
> -
>  		/*
>  		 * If there are any pending burst count, data is handled by
>  		 * transmitting DWORDs at a time.
>  		 */
> -		if (valid_burst_count && (xmit->tail <
> -		   (UART_XMIT_SIZE - UART_BURST_SIZE)))
> +		if (valid_burst_count &&
> +		    kfifo_len(&tport->xmit_fifo) >= UART_BURST_SIZE)
>  			break;
>  	}
>  }
> @@ -437,11 +432,9 @@ static void pci1xxxx_process_write_data(struct uart_port *port,
>  static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> +	struct tty_port *tport = &port->state->port;
>  	u32 valid_byte_count;
>  	int data_empty_count;
> -	struct circ_buf *xmit;
> -
> -	xmit = &port->state->xmit;
>  
>  	if (port->x_char) {
>  		writeb(port->x_char, port->membase + UART_TX);
> @@ -450,25 +443,25 @@ static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
>  		return;
>  	}
>  
> -	if ((uart_tx_stopped(port)) || (uart_circ_empty(xmit))) {
> +	if ((uart_tx_stopped(port)) || kfifo_is_empty(&tport->xmit_fifo)) {
>  		port->ops->stop_tx(port);
>  	} else {
>  		data_empty_count = (pci1xxxx_read_burst_status(port) &
>  				    UART_BST_STAT_TX_COUNT_MASK) >> 8;
>  		do {
> -			valid_byte_count = uart_circ_chars_pending(xmit);
> +			valid_byte_count = kfifo_len(&tport->xmit_fifo);
>  
> -			pci1xxxx_process_write_data(port, xmit,
> +			pci1xxxx_process_write_data(port,
>  						    &data_empty_count,
>  						    &valid_byte_count);
>  
>  			port->icount.tx++;
> -			if (uart_circ_empty(xmit))
> +			if (kfifo_is_empty(&tport->xmit_fifo))
>  				break;
>  		} while (data_empty_count && valid_byte_count);
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	 /*
> @@ -476,7 +469,8 @@ static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
>  	  * the HW can go idle. So we get here once again with empty FIFO and
>  	  * disable the interrupt and RPM in __stop_tx()
>  	  */
> -	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
> +	if (kfifo_is_empty(&tport->xmit_fifo) &&
> +	    !(up->capabilities & UART_CAP_RPM))
>  		port->ops->stop_tx(port);
>  }
>  
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index fc9dd5d45295..0c19451d0332 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1630,7 +1630,7 @@ static void serial8250_start_tx(struct uart_port *port)
>  	/* Port locked to synchronize UART_IER access against the console. */
>  	lockdep_assert_held_once(&port->lock);
>  
> -	if (!port->x_char && uart_circ_empty(&port->state->xmit))
> +	if (!port->x_char && kfifo_is_empty(&port->state->port.xmit_fifo))
>  		return;
>  
>  	serial8250_rpm_get_tx(up);
> @@ -1778,7 +1778,7 @@ EXPORT_SYMBOL_GPL(serial8250_rx_chars);
>  void serial8250_tx_chars(struct uart_8250_port *up)
>  {
>  	struct uart_port *port = &up->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	int count;
>  
>  	if (port->x_char) {
> @@ -1789,14 +1789,19 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  		serial8250_stop_tx(port);
>  		return;
>  	}
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		__stop_tx(up);
>  		return;
>  	}
>  
>  	count = up->tx_loadsz;
>  	do {
> -		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> +		unsigned char c;
> +
> +		if (!uart_fifo_get(port, &c))
> +			break;
> +
> +		serial_out(up, UART_TX, c);
>  		if (up->bugs & UART_BUG_TXRACE) {
>  			/*
>  			 * The Aspeed BMC virtual UARTs have a bug where data
> @@ -1809,9 +1814,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  			 */
>  			serial_in(up, UART_SCR);
>  		}
> -		uart_xmit_advance(port, 1);
> -		if (uart_circ_empty(xmit))
> -			break;
> +
>  		if ((up->capabilities & UART_CAP_HFIFO) &&
>  		    !uart_lsr_tx_empty(serial_in(up, UART_LSR)))
>  			break;
> @@ -1821,7 +1824,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  			break;
>  	} while (--count > 0);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	/*
> @@ -1829,7 +1832,8 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  	 * HW can go idle. So we get here once again with empty FIFO and disable
>  	 * the interrupt and RPM in __stop_tx()
>  	 */
> -	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
> +	if (kfifo_is_empty(&tport->xmit_fifo) &&
> +	    !(up->capabilities & UART_CAP_RPM))
>  		__stop_tx(up);
>  }
>  EXPORT_SYMBOL_GPL(serial8250_tx_chars);
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 2fa3fb30dc6c..51b202eb8296 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -535,6 +535,7 @@ static void pl011_start_tx_pio(struct uart_amba_port *uap);
>  static void pl011_dma_tx_callback(void *data)
>  {
>  	struct uart_amba_port *uap = data;
> +	struct tty_port *tport = &uap->port.state->port;
>  	struct pl011_dmatx_data *dmatx = &uap->dmatx;
>  	unsigned long flags;
>  	u16 dmacr;
> @@ -558,7 +559,7 @@ static void pl011_dma_tx_callback(void *data)
>  	 * get further refills (hence we check dmacr).
>  	 */
>  	if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
> -	    uart_circ_empty(&uap->port.state->xmit)) {
> +	    kfifo_is_empty(&tport->xmit_fifo)) {
>  		uap->dmatx.queued = false;
>  		uart_port_unlock_irqrestore(&uap->port, flags);
>  		return;
> @@ -588,7 +589,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>  	struct dma_chan *chan = dmatx->chan;
>  	struct dma_device *dma_dev = chan->device;
>  	struct dma_async_tx_descriptor *desc;
> -	struct circ_buf *xmit = &uap->port.state->xmit;
> +	struct tty_port *tport = &uap->port.state->port;
>  	unsigned int count;
>  
>  	/*
> @@ -597,7 +598,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>  	 * the standard interrupt handling.  This ensures that we
>  	 * issue a uart_write_wakeup() at the appropriate time.
>  	 */
> -	count = uart_circ_chars_pending(xmit);
> +	count = kfifo_len(&tport->xmit_fifo);
>  	if (count < (uap->fifosize >> 1)) {
>  		uap->dmatx.queued = false;
>  		return 0;
> @@ -613,21 +614,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>  	if (count > PL011_DMA_BUFFER_SIZE)
>  		count = PL011_DMA_BUFFER_SIZE;
>  
> -	if (xmit->tail < xmit->head) {
> -		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], count);
> -	} else {
> -		size_t first = UART_XMIT_SIZE - xmit->tail;
> -		size_t second;
> -
> -		if (first > count)
> -			first = count;
> -		second = count - first;
> -
> -		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], first);
> -		if (second)
> -			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
> -	}
> -
> +	count = kfifo_out_peek(&tport->xmit_fifo, dmatx->buf, count);
>  	dmatx->len = count;
>  	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
>  				    DMA_TO_DEVICE);
> @@ -670,7 +657,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>  	 */
>  	uart_xmit_advance(&uap->port, count);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&uap->port);
>  
>  	return 1;
> @@ -1454,7 +1441,7 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
>  /* Returns true if tx interrupts have to be (kept) enabled  */
>  static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>  {
> -	struct circ_buf *xmit = &uap->port.state->xmit;
> +	struct tty_port *tport = &uap->port.state->port;
>  	int count = uap->fifosize >> 1;
>  
>  	if (uap->port.x_char) {
> @@ -1463,7 +1450,7 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>  		uap->port.x_char = 0;
>  		--count;
>  	}
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(&uap->port)) {
>  		pl011_stop_tx(&uap->port);
>  		return false;
>  	}
> @@ -1472,20 +1459,25 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>  	if (pl011_dma_tx_irq(uap))
>  		return true;
>  
> -	do {
> +	while (1) {
> +		unsigned char c;
> +
>  		if (likely(from_irq) && count-- == 0)
>  			break;
>  
> -		if (!pl011_tx_char(uap, xmit->buf[xmit->tail], from_irq))
> +		if (!kfifo_peek(&tport->xmit_fifo, &c))
> +			break;
> +
> +		if (!pl011_tx_char(uap, c, from_irq))
>  			break;
>  
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -	} while (!uart_circ_empty(xmit));
> +		kfifo_skip(&tport->xmit_fifo);
> +	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&uap->port);
>  
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		pl011_stop_tx(&uap->port);
>  		return false;
>  	}
> diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
> index 7790cbc57391..f2836ecc5c19 100644
> --- a/drivers/tty/serial/ar933x_uart.c
> +++ b/drivers/tty/serial/ar933x_uart.c
> @@ -390,7 +390,7 @@ static void ar933x_uart_rx_chars(struct ar933x_uart_port *up)
>  
>  static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
>  {
> -	struct circ_buf *xmit = &up->port.state->xmit;
> +	struct tty_port *tport = &up->port.state->port;
>  	struct serial_rs485 *rs485conf = &up->port.rs485;
>  	int count;
>  	bool half_duplex_send = false;
> @@ -399,7 +399,7 @@ static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
>  		return;
>  
>  	if ((rs485conf->flags & SER_RS485_ENABLED) &&
> -	    (up->port.x_char || !uart_circ_empty(xmit))) {
> +	    (up->port.x_char || !kfifo_is_empty(&tport->xmit_fifo))) {
>  		ar933x_uart_stop_rx_interrupt(up);
>  		gpiod_set_value(up->rts_gpiod, !!(rs485conf->flags & SER_RS485_RTS_ON_SEND));
>  		half_duplex_send = true;
> @@ -408,6 +408,7 @@ static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
>  	count = up->port.fifosize;
>  	do {
>  		unsigned int rdata;
> +		unsigned char c;
>  
>  		rdata = ar933x_uart_read(up, AR933X_UART_DATA_REG);
>  		if ((rdata & AR933X_UART_DATA_TX_CSR) == 0)
> @@ -420,18 +421,16 @@ static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
>  			continue;
>  		}
>  
> -		if (uart_circ_empty(xmit))
> +		if (!uart_fifo_get(&up->port, &c))
>  			break;
>  
> -		ar933x_uart_putc(up, xmit->buf[xmit->tail]);
> -
> -		uart_xmit_advance(&up->port, 1);
> +		ar933x_uart_putc(up, c);
>  	} while (--count > 0);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&up->port);
>  
> -	if (!uart_circ_empty(xmit)) {
> +	if (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		ar933x_uart_start_tx_interrupt(up);
>  	} else if (half_duplex_send) {
>  		ar933x_uart_wait_tx_complete(up);
> diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
> index 1aa5b2b49c26..5c4895d154c0 100644
> --- a/drivers/tty/serial/arc_uart.c
> +++ b/drivers/tty/serial/arc_uart.c
> @@ -155,7 +155,7 @@ static unsigned int arc_serial_tx_empty(struct uart_port *port)
>   */
>  static void arc_serial_tx_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	int sent = 0;
>  	unsigned char ch;
>  
> @@ -164,9 +164,7 @@ static void arc_serial_tx_chars(struct uart_port *port)
>  		port->icount.tx++;
>  		port->x_char = 0;
>  		sent = 1;
> -	} else if (!uart_circ_empty(xmit)) {
> -		ch = xmit->buf[xmit->tail];
> -		uart_xmit_advance(port, 1);
> +	} else if (uart_fifo_get(port, &ch)) {
>  		while (!(UART_GET_STATUS(port) & TXEMPTY))
>  			cpu_relax();
>  		UART_SET_DATA(port, ch);
> @@ -177,7 +175,7 @@ static void arc_serial_tx_chars(struct uart_port *port)
>  	 * If num chars in xmit buffer are too few, ask tty layer for more.
>  	 * By Hard ISR to schedule processing in software interrupt part
>  	 */
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	if (sent)
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 85667f709515..5bb5e4303754 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -857,7 +857,7 @@ static void atmel_complete_tx_dma(void *arg)
>  {
>  	struct atmel_uart_port *atmel_port = arg;
>  	struct uart_port *port = &atmel_port->uart;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct dma_chan *chan = atmel_port->chan_tx;
>  	unsigned long flags;
>  
> @@ -873,15 +873,15 @@ static void atmel_complete_tx_dma(void *arg)
>  	atmel_port->desc_tx = NULL;
>  	spin_unlock(&atmel_port->lock_tx);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	/*
> -	 * xmit is a circular buffer so, if we have just send data from
> -	 * xmit->tail to the end of xmit->buf, now we have to transmit the
> -	 * remaining data from the beginning of xmit->buf to xmit->head.
> +	 * xmit is a circular buffer so, if we have just send data from the
> +	 * tail to the end, now we have to transmit the remaining data from the
> +	 * beginning to the head.
>  	 */
> -	if (!uart_circ_empty(xmit))
> +	if (!kfifo_is_empty(&tport->xmit_fifo))
>  		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
>  	else if (atmel_uart_is_half_duplex(port)) {
>  		/*
> @@ -919,18 +919,18 @@ static void atmel_release_tx_dma(struct uart_port *port)
>  static void atmel_tx_dma(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct dma_chan *chan = atmel_port->chan_tx;
>  	struct dma_async_tx_descriptor *desc;
>  	struct scatterlist sgl[2], *sg, *sg_tx = &atmel_port->sg_tx;
> -	unsigned int tx_len, part1_len, part2_len, sg_len;
> +	unsigned int tx_len, tail, part1_len, part2_len, sg_len;
>  	dma_addr_t phys_addr;
>  
>  	/* Make sure we have an idle channel */
>  	if (atmel_port->desc_tx != NULL)
>  		return;
>  
> -	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
> +	if (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(port)) {
>  		/*
>  		 * DMA is idle now.
>  		 * Port xmit buffer is already mapped,
> @@ -940,9 +940,8 @@ static void atmel_tx_dma(struct uart_port *port)
>  		 * Take the port lock to get a
>  		 * consistent xmit buffer state.
>  		 */
> -		tx_len = CIRC_CNT_TO_END(xmit->head,
> -					 xmit->tail,
> -					 UART_XMIT_SIZE);
> +		tx_len = kfifo_out_linear(&tport->xmit_fifo, &tail,
> +				UART_XMIT_SIZE);
>  
>  		if (atmel_port->fifo_size) {
>  			/* multi data mode */
> @@ -956,7 +955,7 @@ static void atmel_tx_dma(struct uart_port *port)
>  
>  		sg_init_table(sgl, 2);
>  		sg_len = 0;
> -		phys_addr = sg_dma_address(sg_tx) + xmit->tail;
> +		phys_addr = sg_dma_address(sg_tx) + tail;
>  		if (part1_len) {
>  			sg = &sgl[sg_len++];
>  			sg_dma_address(sg) = phys_addr;
> @@ -973,7 +972,7 @@ static void atmel_tx_dma(struct uart_port *port)
>  
>  		/*
>  		 * save tx_len so atmel_complete_tx_dma() will increase
> -		 * xmit->tail correctly
> +		 * tail correctly
>  		 */
>  		atmel_port->tx_len = tx_len;
>  
> @@ -1003,13 +1002,14 @@ static void atmel_tx_dma(struct uart_port *port)
>  		dma_async_issue_pending(chan);
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  }
>  
>  static int atmel_prepare_tx_dma(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct tty_port *tport = &port->state->port;
>  	struct device *mfd_dev = port->dev->parent;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
> @@ -1031,11 +1031,11 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	spin_lock_init(&atmel_port->lock_tx);
>  	sg_init_table(&atmel_port->sg_tx, 1);
>  	/* UART circular tx buffer is an aligned page. */
> -	BUG_ON(!PAGE_ALIGNED(port->state->xmit.buf));
> +	BUG_ON(!PAGE_ALIGNED(tport->xmit_buf));
>  	sg_set_page(&atmel_port->sg_tx,
> -			virt_to_page(port->state->xmit.buf),
> +			virt_to_page(tport->xmit_buf),
>  			UART_XMIT_SIZE,
> -			offset_in_page(port->state->xmit.buf));
> +			offset_in_page(tport->xmit_buf));
>  	nent = dma_map_sg(port->dev,
>  				&atmel_port->sg_tx,
>  				1,
> @@ -1047,7 +1047,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	} else {
>  		dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
>  			sg_dma_len(&atmel_port->sg_tx),
> -			port->state->xmit.buf,
> +			tport->xmit_buf,
>  			&sg_dma_address(&atmel_port->sg_tx));
>  	}
>  
> @@ -1459,9 +1459,8 @@ static void atmel_release_tx_pdc(struct uart_port *port)
>  static void atmel_tx_pdc(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
> -	int count;
>  
>  	/* nothing left to transmit? */
>  	if (atmel_uart_readl(port, ATMEL_PDC_TCR))
> @@ -1474,17 +1473,19 @@ static void atmel_tx_pdc(struct uart_port *port)
>  	/* disable PDC transmit */
>  	atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
>  
> -	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
> +	if (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(port)) {
> +		unsigned int count, tail;
> +
>  		dma_sync_single_for_device(port->dev,
>  					   pdc->dma_addr,
>  					   pdc->dma_size,
>  					   DMA_TO_DEVICE);
>  
> -		count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +		count = kfifo_out_linear(&tport->xmit_fifo, &tail,
> +				UART_XMIT_SIZE);
>  		pdc->ofs = count;
>  
> -		atmel_uart_writel(port, ATMEL_PDC_TPR,
> -				  pdc->dma_addr + xmit->tail);
> +		atmel_uart_writel(port, ATMEL_PDC_TPR, pdc->dma_addr + tail);
>  		atmel_uart_writel(port, ATMEL_PDC_TCR, count);
>  		/* re-enable PDC transmit */
>  		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
> @@ -1498,7 +1499,7 @@ static void atmel_tx_pdc(struct uart_port *port)
>  		}
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  }
>  
> @@ -1506,9 +1507,9 @@ static int atmel_prepare_tx_pdc(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  	struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
> -	pdc->buf = xmit->buf;
> +	pdc->buf = tport->xmit_buf;
>  	pdc->dma_addr = dma_map_single(port->dev,
>  					pdc->buf,
>  					UART_XMIT_SIZE,
> diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
> index 7927725b8957..30425a3d19fb 100644
> --- a/drivers/tty/serial/clps711x.c
> +++ b/drivers/tty/serial/clps711x.c
> @@ -146,7 +146,8 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
>  {
>  	struct uart_port *port = dev_id;
>  	struct clps711x_port *s = dev_get_drvdata(port->dev);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned char c;
>  
>  	if (port->x_char) {
>  		writew(port->x_char, port->membase + UARTDR_OFFSET);
> @@ -155,7 +156,7 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
>  		return IRQ_HANDLED;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		if (s->tx_enabled) {
>  			disable_irq_nosync(port->irq);
>  			s->tx_enabled = 0;
> @@ -163,18 +164,17 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
>  		return IRQ_HANDLED;
>  	}
>  
> -	while (!uart_circ_empty(xmit)) {
> +	while (uart_fifo_get(port, &c)) {
>  		u32 sysflg = 0;
>  
> -		writew(xmit->buf[xmit->tail], port->membase + UARTDR_OFFSET);
> -		uart_xmit_advance(port, 1);
> +		writew(c, port->membase + UARTDR_OFFSET);
>  
>  		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
>  		if (sysflg & SYSFLG_UTXFF)
>  			break;
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	return IRQ_HANDLED;
> diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
> index df56c6c5afd0..a927478f581d 100644
> --- a/drivers/tty/serial/cpm_uart.c
> +++ b/drivers/tty/serial/cpm_uart.c
> @@ -648,7 +648,7 @@ static int cpm_uart_tx_pump(struct uart_port *port)
>  	int count;
>  	struct uart_cpm_port *pinfo =
>  		container_of(port, struct uart_cpm_port, port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
>  	/* Handle xon/xoff */
>  	if (port->x_char) {
> @@ -673,7 +673,7 @@ static int cpm_uart_tx_pump(struct uart_port *port)
>  		return 1;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		cpm_uart_stop_tx(port);
>  		return 0;
>  	}
> @@ -681,16 +681,10 @@ static int cpm_uart_tx_pump(struct uart_port *port)
>  	/* Pick next descriptor and fill from buffer */
>  	bdp = pinfo->tx_cur;
>  
> -	while (!(in_be16(&bdp->cbd_sc) & BD_SC_READY) && !uart_circ_empty(xmit)) {
> -		count = 0;
> +	while (!(in_be16(&bdp->cbd_sc) & BD_SC_READY) &&
> +			!kfifo_is_empty(&tport->xmit_fifo)) {
>  		p = cpm2cpu_addr(in_be32(&bdp->cbd_bufaddr), pinfo);
> -		while (count < pinfo->tx_fifosize) {
> -			*p++ = xmit->buf[xmit->tail];
> -			uart_xmit_advance(port, 1);
> -			count++;
> -			if (uart_circ_empty(xmit))
> -				break;
> -		}
> +		count = uart_fifo_out(port, p, pinfo->tx_fifosize);
>  		out_be16(&bdp->cbd_datlen, count);
>  		setbits16(&bdp->cbd_sc, BD_SC_READY);
>  		/* Get next BD. */
> @@ -701,10 +695,10 @@ static int cpm_uart_tx_pump(struct uart_port *port)
>  	}
>  	pinfo->tx_cur = bdp;
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		cpm_uart_stop_tx(port);
>  		return 0;
>  	}
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
> index e419c4bde8b7..2ccd13cc0a89 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -179,8 +179,9 @@ static void digicolor_uart_rx(struct uart_port *port)
>  
>  static void digicolor_uart_tx(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned long flags;
> +	unsigned char c;
>  
>  	if (digicolor_uart_tx_full(port))
>  		return;
> @@ -194,20 +195,19 @@ static void digicolor_uart_tx(struct uart_port *port)
>  		goto out;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		digicolor_uart_stop_tx(port);
>  		goto out;
>  	}
>  
> -	while (!uart_circ_empty(xmit)) {
> -		writeb(xmit->buf[xmit->tail], port->membase + UA_EMI_REC);
> -		uart_xmit_advance(port, 1);
> +	while (uart_fifo_get(port, &c)) {
> +		writeb(c, port->membase + UA_EMI_REC);
>  
>  		if (digicolor_uart_tx_full(port))
>  			break;
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  out:
> diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
> index 6df7af9edc1c..eba91daedef8 100644
> --- a/drivers/tty/serial/dz.c
> +++ b/drivers/tty/serial/dz.c
> @@ -252,13 +252,13 @@ static inline void dz_receive_chars(struct dz_mux *mux)
>  static inline void dz_transmit_chars(struct dz_mux *mux)
>  {
>  	struct dz_port *dport = &mux->dport[0];
> -	struct circ_buf *xmit;
> +	struct tty_port *tport;
>  	unsigned char tmp;
>  	u16 status;
>  
>  	status = dz_in(dport, DZ_CSR);
>  	dport = &mux->dport[LINE(status)];
> -	xmit = &dport->port.state->xmit;
> +	tport = &dport->port.state->port;
>  
>  	if (dport->port.x_char) {		/* XON/XOFF chars */
>  		dz_out(dport, DZ_TDR, dport->port.x_char);
> @@ -267,7 +267,8 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
>  		return;
>  	}
>  	/* If nothing to do or stopped or hardware stopped. */
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(&dport->port)) {
> +	if (uart_tx_stopped(&dport->port) ||
> +			!uart_fifo_get(&dport->port, &tmp)) {
>  		uart_port_lock(&dport->port);
>  		dz_stop_tx(&dport->port);
>  		uart_port_unlock(&dport->port);
> @@ -278,15 +279,13 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
>  	 * If something to do... (remember the dz has no output fifo,
>  	 * so we go one char at a time) :-<
>  	 */
> -	tmp = xmit->buf[xmit->tail];
>  	dz_out(dport, DZ_TDR, tmp);
> -	uart_xmit_advance(&dport->port, 1);
>  
> -	if (uart_circ_chars_pending(xmit) < DZ_WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < DZ_WAKEUP_CHARS)
>  		uart_write_wakeup(&dport->port);
>  
>  	/* Are we are done. */
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		uart_port_lock(&dport->port);
>  		dz_stop_tx(&dport->port);
>  		uart_port_unlock(&dport->port);
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index 5426322b5f0c..e972df4b188d 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -174,17 +174,18 @@ static void linflex_put_char(struct uart_port *sport, unsigned char c)
>  
>  static inline void linflex_transmit_buffer(struct uart_port *sport)
>  {
> -	struct circ_buf *xmit = &sport->state->xmit;
> +	struct tty_port *tport = &sport->state->port;
> +	unsigned char c;
>  
> -	while (!uart_circ_empty(xmit)) {
> -		linflex_put_char(sport, xmit->buf[xmit->tail]);
> -		uart_xmit_advance(sport, 1);
> +	while (uart_fifo_get(sport, &c)) {
> +		linflex_put_char(sport, c);
> +		sport->icount.tx++;
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(sport);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		linflex_stop_tx(sport);
>  }
>  
> @@ -200,7 +201,7 @@ static void linflex_start_tx(struct uart_port *port)
>  static irqreturn_t linflex_txint(int irq, void *dev_id)
>  {
>  	struct uart_port *sport = dev_id;
> -	struct circ_buf *xmit = &sport->state->xmit;
> +	struct tty_port *tport = &sport->state->port;
>  	unsigned long flags;
>  
>  	uart_port_lock_irqsave(sport, &flags);
> @@ -210,7 +211,7 @@ static irqreturn_t linflex_txint(int irq, void *dev_id)
>  		goto out;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(sport)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(sport)) {
>  		linflex_stop_tx(sport);
>  		goto out;
>  	}
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index bbcbc91482af..ae5e1ecc48fc 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/circ_buf.h>
>  #include <linux/clk.h>
>  #include <linux/console.h>
>  #include <linux/delay.h>
> @@ -473,7 +474,7 @@ static void lpuart32_stop_rx(struct uart_port *port)
>  
>  static void lpuart_dma_tx(struct lpuart_port *sport)
>  {
> -	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct tty_port *tport = &sport->port.state->port;
>  	struct scatterlist *sgl = sport->tx_sgl;
>  	struct device *dev = sport->port.dev;
>  	struct dma_chan *chan = sport->dma_tx_chan;
> @@ -482,18 +483,10 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>  	if (sport->dma_tx_in_progress)
>  		return;
>  
> -	sport->dma_tx_bytes = uart_circ_chars_pending(xmit);
> -
> -	if (xmit->tail < xmit->head || xmit->head == 0) {
> -		sport->dma_tx_nents = 1;
> -		sg_init_one(sgl, xmit->buf + xmit->tail, sport->dma_tx_bytes);
> -	} else {
> -		sport->dma_tx_nents = 2;
> -		sg_init_table(sgl, 2);
> -		sg_set_buf(sgl, xmit->buf + xmit->tail,
> -				UART_XMIT_SIZE - xmit->tail);
> -		sg_set_buf(sgl + 1, xmit->buf, xmit->head);
> -	}
> +	sg_init_table(sgl, ARRAY_SIZE(sport->tx_sgl));
> +	sport->dma_tx_bytes = kfifo_len(&tport->xmit_fifo);
> +	sport->dma_tx_nents = kfifo_dma_out_prepare(&tport->xmit_fifo, sgl,
> +			ARRAY_SIZE(sport->tx_sgl), sport->dma_tx_bytes);
>  
>  	ret = dma_map_sg(chan->device->dev, sgl, sport->dma_tx_nents,
>  			 DMA_TO_DEVICE);
> @@ -521,14 +514,15 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>  
>  static bool lpuart_stopped_or_empty(struct uart_port *port)
>  {
> -	return uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port);
> +	return kfifo_is_empty(&port->state->port.xmit_fifo) ||
> +		uart_tx_stopped(port);
>  }
>  
>  static void lpuart_dma_tx_complete(void *arg)
>  {
>  	struct lpuart_port *sport = arg;
>  	struct scatterlist *sgl = &sport->tx_sgl[0];
> -	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct tty_port *tport = &sport->port.state->port;
>  	struct dma_chan *chan = sport->dma_tx_chan;
>  	unsigned long flags;
>  
> @@ -545,7 +539,7 @@ static void lpuart_dma_tx_complete(void *arg)
>  	sport->dma_tx_in_progress = false;
>  	uart_port_unlock_irqrestore(&sport->port, flags);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&sport->port);
>  
>  	if (waitqueue_active(&sport->dma_wait)) {
> @@ -756,8 +750,9 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
>  
>  static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
>  {
> -	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct tty_port *tport = &sport->port.state->port;
>  	unsigned long txcnt;
> +	unsigned char c;
>  
>  	if (sport->port.x_char) {
>  		lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
> @@ -774,18 +769,18 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
>  	txcnt = lpuart32_read(&sport->port, UARTWATER);
>  	txcnt = txcnt >> UARTWATER_TXCNT_OFF;
>  	txcnt &= UARTWATER_COUNT_MASK;
> -	while (!uart_circ_empty(xmit) && (txcnt < sport->txfifo_size)) {
> -		lpuart32_write(&sport->port, xmit->buf[xmit->tail], UARTDATA);
> -		uart_xmit_advance(&sport->port, 1);
> +	while (txcnt < sport->txfifo_size &&
> +			uart_fifo_get(&sport->port, &c)) {
> +		lpuart32_write(&sport->port, c, UARTDATA);
>  		txcnt = lpuart32_read(&sport->port, UARTWATER);
>  		txcnt = txcnt >> UARTWATER_TXCNT_OFF;
>  		txcnt &= UARTWATER_COUNT_MASK;
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&sport->port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		lpuart32_stop_tx(&sport->port);
>  }
>  
> diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
> index a75eafbcbea3..29e42831df39 100644
> --- a/drivers/tty/serial/icom.c
> +++ b/drivers/tty/serial/icom.c
> @@ -877,10 +877,10 @@ static void shutdown(struct icom_port *icom_port)
>  static int icom_write(struct uart_port *port)
>  {
>  	struct icom_port *icom_port = to_icom_port(port);
> +	struct tty_port *tport = &port->state->port;
>  	unsigned long data_count;
>  	unsigned char cmdReg;
>  	unsigned long offset;
> -	int temp_tail = port->state->xmit.tail;
>  
>  	trace(icom_port, "WRITE", 0);
>  
> @@ -890,16 +890,8 @@ static int icom_write(struct uart_port *port)
>  		return 0;
>  	}
>  
> -	data_count = 0;
> -	while ((port->state->xmit.head != temp_tail) &&
> -	       (data_count <= XMIT_BUFF_SZ)) {
> -
> -		icom_port->xmit_buf[data_count++] =
> -		    port->state->xmit.buf[temp_tail];
> -
> -		temp_tail++;
> -		temp_tail &= (UART_XMIT_SIZE - 1);
> -	}
> +	data_count = kfifo_out_peek(&tport->xmit_fifo, icom_port->xmit_buf,
> +			XMIT_BUFF_SZ);
>  
>  	if (data_count) {
>  		icom_port->statStg->xmit[0].flags =
> @@ -956,7 +948,8 @@ static inline void check_modem_status(struct icom_port *icom_port)
>  
>  static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
>  {
> -	u16 count, i;
> +	struct tty_port *tport = &icom_port->uart_port.state->port;
> +	u16 count;
>  
>  	if (port_int_reg & (INT_XMIT_COMPLETED)) {
>  		trace(icom_port, "XMIT_COMPLETE", 0);
> @@ -968,13 +961,7 @@ static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
>  		count = le16_to_cpu(icom_port->statStg->xmit[0].leLength);
>  		icom_port->uart_port.icount.tx += count;
>  
> -		for (i=0; i<count &&
> -			!uart_circ_empty(&icom_port->uart_port.state->xmit); i++) {
> -
> -			icom_port->uart_port.state->xmit.tail++;
> -			icom_port->uart_port.state->xmit.tail &=
> -				(UART_XMIT_SIZE - 1);
> -		}
> +		kfifo_skip_count(&tport->xmit_fifo, count);
>  
>  		if (!icom_write(&icom_port->uart_port))
>  			/* activate write queue */
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e14813250616..56b76a221082 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2004 Pengutronix
>   */
>  
> +#include <linux/circ_buf.h>
>  #include <linux/module.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> @@ -521,7 +522,8 @@ static void imx_uart_dma_tx(struct imx_port *sport);
>  /* called with port.lock taken and irqs off */
>  static inline void imx_uart_transmit_buffer(struct imx_port *sport)
>  {
> -	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct tty_port *tport = &sport->port.state->port;
> +	unsigned char c;
>  
>  	if (sport->port.x_char) {
>  		/* Send next char */
> @@ -531,7 +533,8 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) ||
> +			uart_tx_stopped(&sport->port)) {
>  		imx_uart_stop_tx(&sport->port);
>  		return;
>  	}
> @@ -555,26 +558,22 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
>  		return;
>  	}
>  
> -	while (!uart_circ_empty(xmit) &&
> -	       !(imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL)) {
> -		/* send xmit->buf[xmit->tail]
> -		 * out the port here */
> -		imx_uart_writel(sport, xmit->buf[xmit->tail], URTX0);
> -		uart_xmit_advance(&sport->port, 1);
> -	}
> +	while (!(imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL) &&
> +			uart_fifo_get(&sport->port, &c))
> +		imx_uart_writel(sport, c, URTX0);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&sport->port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		imx_uart_stop_tx(&sport->port);
>  }
>  
>  static void imx_uart_dma_tx_callback(void *data)
>  {
>  	struct imx_port *sport = data;
> +	struct tty_port *tport = &sport->port.state->port;
>  	struct scatterlist *sgl = &sport->tx_sgl[0];
> -	struct circ_buf *xmit = &sport->port.state->xmit;
>  	unsigned long flags;
>  	u32 ucr1;
>  
> @@ -592,10 +591,11 @@ static void imx_uart_dma_tx_callback(void *data)
>  
>  	sport->dma_is_txing = 0;
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&sport->port);
>  
> -	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&sport->port))
> +	if (!kfifo_is_empty(&tport->xmit_fifo) &&
> +			!uart_tx_stopped(&sport->port))
>  		imx_uart_dma_tx(sport);
>  	else if (sport->port.rs485.flags & SER_RS485_ENABLED) {
>  		u32 ucr4 = imx_uart_readl(sport, UCR4);
> @@ -609,7 +609,7 @@ static void imx_uart_dma_tx_callback(void *data)
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_dma_tx(struct imx_port *sport)
>  {
> -	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct tty_port *tport = &sport->port.state->port;
>  	struct scatterlist *sgl = sport->tx_sgl;
>  	struct dma_async_tx_descriptor *desc;
>  	struct dma_chan	*chan = sport->dma_chan_tx;
> @@ -624,18 +624,10 @@ static void imx_uart_dma_tx(struct imx_port *sport)
>  	ucr4 &= ~UCR4_TCEN;
>  	imx_uart_writel(sport, ucr4, UCR4);
>  
> -	sport->tx_bytes = uart_circ_chars_pending(xmit);
> -
> -	if (xmit->tail < xmit->head || xmit->head == 0) {
> -		sport->dma_tx_nents = 1;
> -		sg_init_one(sgl, xmit->buf + xmit->tail, sport->tx_bytes);
> -	} else {
> -		sport->dma_tx_nents = 2;
> -		sg_init_table(sgl, 2);
> -		sg_set_buf(sgl, xmit->buf + xmit->tail,
> -				UART_XMIT_SIZE - xmit->tail);
> -		sg_set_buf(sgl + 1, xmit->buf, xmit->head);
> -	}
> +	sg_init_table(sgl, ARRAY_SIZE(sport->tx_sgl));
> +	sport->tx_bytes = kfifo_len(&tport->xmit_fifo);
> +	sport->dma_tx_nents = kfifo_dma_out_prepare(&tport->xmit_fifo, sgl,
> +			ARRAY_SIZE(sport->tx_sgl), sport->tx_bytes);
>  
>  	ret = dma_map_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
>  	if (ret == 0) {
> @@ -653,8 +645,7 @@ static void imx_uart_dma_tx(struct imx_port *sport)
>  	desc->callback = imx_uart_dma_tx_callback;
>  	desc->callback_param = sport;
>  
> -	dev_dbg(dev, "TX: prepare to send %lu bytes by DMA.\n",
> -			uart_circ_chars_pending(xmit));
> +	dev_dbg(dev, "TX: prepare to send %u bytes by DMA.\n", sport->tx_bytes);
>  
>  	ucr1 = imx_uart_readl(sport, UCR1);
>  	ucr1 |= UCR1_TXDMAEN;
> @@ -671,9 +662,10 @@ static void imx_uart_dma_tx(struct imx_port *sport)
>  static void imx_uart_start_tx(struct uart_port *port)
>  {
>  	struct imx_port *sport = (struct imx_port *)port;
> +	struct tty_port *tport = &sport->port.state->port;
>  	u32 ucr1;
>  
> -	if (!sport->port.x_char && uart_circ_empty(&port->state->xmit))
> +	if (!sport->port.x_char && kfifo_is_empty(&tport->xmit_fifo))
>  		return;
>  
>  	/*
> @@ -749,7 +741,7 @@ static void imx_uart_start_tx(struct uart_port *port)
>  			return;
>  		}
>  
> -		if (!uart_circ_empty(&port->state->xmit) &&
> +		if (!kfifo_is_empty(&tport->xmit_fifo) &&
>  		    !uart_tx_stopped(port))
>  			imx_uart_dma_tx(sport);
>  		return;
> diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
> index 320b29cd4683..c2cae50f06f3 100644
> --- a/drivers/tty/serial/ip22zilog.c
> +++ b/drivers/tty/serial/ip22zilog.c
> @@ -355,7 +355,8 @@ static void ip22zilog_status_handle(struct uart_ip22zilog_port *up,
>  static void ip22zilog_transmit_chars(struct uart_ip22zilog_port *up,
>  				    struct zilog_channel *channel)
>  {
> -	struct circ_buf *xmit;
> +	struct tty_port *tport;
> +	unsigned char c;
>  
>  	if (ZS_IS_CONS(up)) {
>  		unsigned char status = readb(&channel->control);
> @@ -398,20 +399,18 @@ static void ip22zilog_transmit_chars(struct uart_ip22zilog_port *up,
>  
>  	if (up->port.state == NULL)
>  		goto ack_tx_int;
> -	xmit = &up->port.state->xmit;
> -	if (uart_circ_empty(xmit))
> -		goto ack_tx_int;
> +	tport = &up->port.state->port;
>  	if (uart_tx_stopped(&up->port))
>  		goto ack_tx_int;
> +	if (!uart_fifo_get(&up->port, &c))
> +		goto ack_tx_int;
>  
>  	up->flags |= IP22ZILOG_FLAG_TX_ACTIVE;
> -	writeb(xmit->buf[xmit->tail], &channel->data);
> +	writeb(c, &channel->data);
>  	ZSDELAY();
>  	ZS_WSYNC(channel);
>  
> -	uart_xmit_advance(&up->port, 1);
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&up->port);
>  
>  	return;
> @@ -600,17 +599,16 @@ static void ip22zilog_start_tx(struct uart_port *port)
>  		port->icount.tx++;
>  		port->x_char = 0;
>  	} else {
> -		struct circ_buf *xmit = &port->state->xmit;
> +		struct tty_port *tport = &port->state->port;
> +		unsigned char c;
>  
> -		if (uart_circ_empty(xmit))
> +		if (!uart_fifo_get(port, &c))
>  			return;
> -		writeb(xmit->buf[xmit->tail], &channel->data);
> +		writeb(c, &channel->data);
>  		ZSDELAY();
>  		ZS_WSYNC(channel);
>  
> -		uart_xmit_advance(port, 1);
> -
> -		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  			uart_write_wakeup(&up->port);
>  	}
>  }
> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
> index ddbd42c09637..6e40792f92cf 100644
> --- a/drivers/tty/serial/jsm/jsm_cls.c
> +++ b/drivers/tty/serial/jsm/jsm_cls.c
> @@ -443,20 +443,14 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>  
>  static void cls_copy_data_from_queue_to_uart(struct jsm_channel *ch)
>  {
> -	u16 tail;
> +	struct tty_port *tport;
>  	int n;
> -	int qlen;
>  	u32 len_written = 0;
> -	struct circ_buf *circ;
>  
>  	if (!ch)
>  		return;
>  
> -	circ = &ch->uart_port.state->xmit;
> -
> -	/* No data to write to the UART */
> -	if (uart_circ_empty(circ))
> -		return;
> +	tport = &ch->uart_port.state->port;
>  
>  	/* If port is "stopped", don't send any data to the UART */
>  	if ((ch->ch_flags & CH_STOP) || (ch->ch_flags & CH_BREAK_SENDING))
> @@ -467,29 +461,22 @@ static void cls_copy_data_from_queue_to_uart(struct jsm_channel *ch)
>  		return;
>  
>  	n = 32;
> +	while (n > 0) {
> +		unsigned char c;
>  
> -	/* cache tail of queue */
> -	tail = circ->tail & (UART_XMIT_SIZE - 1);
> -	qlen = uart_circ_chars_pending(circ);
> -
> -	/* Find minimum of the FIFO space, versus queue length */
> -	n = min(n, qlen);
> +		if (!kfifo_get(&tport->xmit_fifo, &c))
> +			break;
>  
> -	while (n > 0) {
> -		writeb(circ->buf[tail], &ch->ch_cls_uart->txrx);
> -		tail = (tail + 1) & (UART_XMIT_SIZE - 1);
> +		writeb(c, &ch->ch_cls_uart->txrx);
>  		n--;
>  		ch->ch_txcount++;
>  		len_written++;
>  	}
>  
> -	/* Update the final tail */
> -	circ->tail = tail & (UART_XMIT_SIZE - 1);
> -
>  	if (len_written > ch->ch_t_tlevel)
>  		ch->ch_flags &= ~(CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
>  
> -	if (uart_circ_empty(circ))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		uart_write_wakeup(&ch->uart_port);
>  }
>  
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index 1fa10f19368f..e8e13bf056e2 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c
> @@ -474,21 +474,21 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>  
>  static void neo_copy_data_from_queue_to_uart(struct jsm_channel *ch)
>  {
> -	u16 head;
> -	u16 tail;
> +	struct tty_port *tport;
> +	unsigned char *tail;
> +	unsigned char c;
>  	int n;
>  	int s;
>  	int qlen;
>  	u32 len_written = 0;
> -	struct circ_buf *circ;
>  
>  	if (!ch)
>  		return;
>  
> -	circ = &ch->uart_port.state->xmit;
> +	tport = &ch->uart_port.state->port;
>  
>  	/* No data to write to the UART */
> -	if (uart_circ_empty(circ))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		return;
>  
>  	/* If port is "stopped", don't send any data to the UART */
> @@ -504,10 +504,9 @@ static void neo_copy_data_from_queue_to_uart(struct jsm_channel *ch)
>  		if (ch->ch_cached_lsr & UART_LSR_THRE) {
>  			ch->ch_cached_lsr &= ~(UART_LSR_THRE);
>  
> -			writeb(circ->buf[circ->tail], &ch->ch_neo_uart->txrx);
> -			jsm_dbg(WRITE, &ch->ch_bd->pci_dev,
> -				"Tx data: %x\n", circ->buf[circ->tail]);
> -			circ->tail = (circ->tail + 1) & (UART_XMIT_SIZE - 1);
> +			WARN_ON_ONCE(!kfifo_get(&tport->xmit_fifo, &c));
> +			writeb(c, &ch->ch_neo_uart->txrx);
> +			jsm_dbg(WRITE, &ch->ch_bd->pci_dev, "Tx data: %x\n", c);
>  			ch->ch_txcount++;
>  		}
>  		return;
> @@ -520,38 +519,27 @@ static void neo_copy_data_from_queue_to_uart(struct jsm_channel *ch)
>  		return;
>  
>  	n = UART_17158_TX_FIFOSIZE - ch->ch_t_tlevel;
> -
> -	/* cache head and tail of queue */
> -	head = circ->head & (UART_XMIT_SIZE - 1);
> -	tail = circ->tail & (UART_XMIT_SIZE - 1);
> -	qlen = uart_circ_chars_pending(circ);
> +	qlen = kfifo_len(&tport->xmit_fifo);
>  
>  	/* Find minimum of the FIFO space, versus queue length */
>  	n = min(n, qlen);
>  
>  	while (n > 0) {
> -
> -		s = ((head >= tail) ? head : UART_XMIT_SIZE) - tail;
> -		s = min(s, n);
> -
> +		s = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, n);
>  		if (s <= 0)
>  			break;
>  
> -		memcpy_toio(&ch->ch_neo_uart->txrxburst, circ->buf + tail, s);
> -		/* Add and flip queue if needed */
> -		tail = (tail + s) & (UART_XMIT_SIZE - 1);
> +		memcpy_toio(&ch->ch_neo_uart->txrxburst, tail, s);
> +		kfifo_skip_count(&tport->xmit_fifo, s);
>  		n -= s;
>  		ch->ch_txcount += s;
>  		len_written += s;
>  	}
>  
> -	/* Update the final tail */
> -	circ->tail = tail & (UART_XMIT_SIZE - 1);
> -
>  	if (len_written >= ch->ch_t_tlevel)
>  		ch->ch_flags &= ~(CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
>  
> -	if (uart_circ_empty(circ))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		uart_write_wakeup(&ch->uart_port);
>  }
>  
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 5efb2b593be3..b83eee37c17d 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -257,10 +257,11 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
>  static void max3100_work(struct work_struct *w)
>  {
>  	struct max3100_port *s = container_of(w, struct max3100_port, work);
> +	struct tty_port *tport = &s->port.state->port;
> +	unsigned char ch;
>  	int rxchars;
>  	u16 tx, rx;
>  	int conf, cconf, crts;
> -	struct circ_buf *xmit = &s->port.state->xmit;
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  
> @@ -290,10 +291,9 @@ static void max3100_work(struct work_struct *w)
>  				tx = s->port.x_char;
>  				s->port.icount.tx++;
>  				s->port.x_char = 0;
> -			} else if (!uart_circ_empty(xmit) &&
> -				   !uart_tx_stopped(&s->port)) {
> -				tx = xmit->buf[xmit->tail];
> -				uart_xmit_advance(&s->port, 1);
> +			} else if (!uart_tx_stopped(&s->port) &&
> +					uart_fifo_get(&s->port, &ch)) {
> +				tx = ch;
>  			}
>  			if (tx != 0xffff) {
>  				max3100_calc_parity(s, &tx);
> @@ -307,13 +307,13 @@ static void max3100_work(struct work_struct *w)
>  			tty_flip_buffer_push(&s->port.state->port);
>  			rxchars = 0;
>  		}
> -		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  			uart_write_wakeup(&s->port);
>  
>  	} while (!s->force_end_work &&
>  		 !freezing(current) &&
>  		 ((rx & MAX3100_R) ||
> -		  (!uart_circ_empty(xmit) &&
> +		  (!kfifo_is_empty(&tport->xmit_fifo) &&
>  		   !uart_tx_stopped(&s->port))));
>  
>  	if (rxchars > 0)
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 14dd9cfaa9f7..f0eb96429dae 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -747,8 +747,9 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
>  
>  static void max310x_handle_tx(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned int txlen, to_send, until_end;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned int txlen, to_send;
> +	unsigned char *tail;
>  
>  	if (unlikely(port->x_char)) {
>  		max310x_port_write(port, MAX310X_THR_REG, port->x_char);
> @@ -757,32 +758,26 @@ static void max310x_handle_tx(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
>  		return;
>  
> -	/* Get length of data pending in circular buffer */
> -	to_send = uart_circ_chars_pending(xmit);
> -	until_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> -	if (likely(to_send)) {
> +	/*
> +	 * It's a circ buffer -- wrap around.
> +	 * We could do that in one SPI transaction, but meh.
> +	 */
> +	while (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		/* Limit to space available in TX FIFO */
>  		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
>  		txlen = port->fifosize - txlen;
> -		to_send = (to_send > txlen) ? txlen : to_send;
> -
> -		if (until_end < to_send) {
> -			/*
> -			 * It's a circ buffer -- wrap around.
> -			 * We could do that in one SPI transaction, but meh.
> -			 */
> -			max310x_batch_write(port, xmit->buf + xmit->tail, until_end);
> -			max310x_batch_write(port, xmit->buf, to_send - until_end);
> -		} else {
> -			max310x_batch_write(port, xmit->buf + xmit->tail, to_send);
> -		}
> +		if (!txlen)
> +			break;
> +
> +		to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> +		max310x_batch_write(port, tail, to_send);
>  		uart_xmit_advance(port, to_send);
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  }
>  
> diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
> index 8048fa542fc4..4bff422bb1bc 100644
> --- a/drivers/tty/serial/men_z135_uart.c
> +++ b/drivers/tty/serial/men_z135_uart.c
> @@ -293,17 +293,14 @@ static void men_z135_handle_rx(struct men_z135_port *uart)
>  static void men_z135_handle_tx(struct men_z135_port *uart)
>  {
>  	struct uart_port *port = &uart->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned char *tail;
> +	unsigned int n, txfree;
>  	u32 txc;
>  	u32 wptr;
>  	int qlen;
> -	int n;
> -	int txfree;
> -	int head;
> -	int tail;
> -	int s;
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		goto out;
>  
>  	if (uart_tx_stopped(port))
> @@ -313,7 +310,7 @@ static void men_z135_handle_tx(struct men_z135_port *uart)
>  		goto out;
>  
>  	/* calculate bytes to copy */
> -	qlen = uart_circ_chars_pending(xmit);
> +	qlen = kfifo_len(&tport->xmit_fifo);
>  	if (qlen <= 0)
>  		goto out;
>  
> @@ -345,21 +342,18 @@ static void men_z135_handle_tx(struct men_z135_port *uart)
>  	if (n <= 0)
>  		goto irq_en;
>  
> -	head = xmit->head & (UART_XMIT_SIZE - 1);
> -	tail = xmit->tail & (UART_XMIT_SIZE - 1);
> -
> -	s = ((head >= tail) ? head : UART_XMIT_SIZE) - tail;
> -	n = min(n, s);
> +	n = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
> +			min_t(unsigned int, UART_XMIT_SIZE, n));
> +	memcpy_toio(port->membase + MEN_Z135_TX_RAM, tail, n);
>  
> -	memcpy_toio(port->membase + MEN_Z135_TX_RAM, &xmit->buf[xmit->tail], n);
>  	iowrite32(n & 0x3ff, port->membase + MEN_Z135_TX_CTRL);
>  	uart_xmit_advance(port, n);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  irq_en:
> -	if (!uart_circ_empty(xmit))
> +	if (!kfifo_is_empty(&tport->xmit_fifo))
>  		men_z135_reg_set(uart, MEN_Z135_CONF_REG, MEN_Z135_IER_TXCIEN);
>  	else
>  		men_z135_reg_clr(uart, MEN_Z135_CONF_REG, MEN_Z135_IER_TXCIEN);
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 6feac459c0cf..4587ed4d4d5d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -141,8 +141,8 @@ static void meson_uart_shutdown(struct uart_port *port)
>  
>  static void meson_uart_start_tx(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned int ch;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned char ch;
>  	u32 val;
>  
>  	if (uart_tx_stopped(port)) {
> @@ -158,21 +158,20 @@ static void meson_uart_start_tx(struct uart_port *port)
>  			continue;
>  		}
>  
> -		if (uart_circ_empty(xmit))
> +		if (!uart_fifo_get(port, &ch))
>  			break;
>  
> -		ch = xmit->buf[xmit->tail];
>  		writel(ch, port->membase + AML_UART_WFIFO);
>  		uart_xmit_advance(port, 1);
>  	}
>  
> -	if (!uart_circ_empty(xmit)) {
> +	if (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		val = readl(port->membase + AML_UART_CONTROL);
>  		val |= AML_UART_TX_INT_EN;
>  		writel(val, port->membase + AML_UART_CONTROL);
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  }
>  
> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
> index da4c6f7e2a30..fb082ee73d5b 100644
> --- a/drivers/tty/serial/milbeaut_usio.c
> +++ b/drivers/tty/serial/milbeaut_usio.c
> @@ -72,7 +72,7 @@ static void mlb_usio_stop_tx(struct uart_port *port)
>  
>  static void mlb_usio_tx_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	int count;
>  
>  	writew(readw(port->membase + MLB_USIO_REG_FCR) & ~MLB_USIO_FCR_FTIE,
> @@ -87,7 +87,7 @@ static void mlb_usio_tx_chars(struct uart_port *port)
>  		port->x_char = 0;
>  		return;
>  	}
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		mlb_usio_stop_tx(port);
>  		return;
>  	}
> @@ -96,12 +96,13 @@ static void mlb_usio_tx_chars(struct uart_port *port)
>  		(readw(port->membase + MLB_USIO_REG_FBYTE) & 0xff);
>  
>  	do {
> -		writew(xmit->buf[xmit->tail], port->membase + MLB_USIO_REG_DR);
> +		unsigned char ch;
>  
> -		uart_xmit_advance(port, 1);
> -		if (uart_circ_empty(xmit))
> +		if (!uart_fifo_get(port, &ch))
>  			break;
>  
> +		writew(ch, port->membase + MLB_USIO_REG_DR);
> +		port->icount.tx++;
>  	} while (--count > 0);
>  
>  	writew(readw(port->membase + MLB_USIO_REG_FCR) & ~MLB_USIO_FCR_FDRQ,
> @@ -110,10 +111,10 @@ static void mlb_usio_tx_chars(struct uart_port *port)
>  	writeb(readb(port->membase + MLB_USIO_REG_SCR) | MLB_USIO_SCR_TBIE,
>  	       port->membase + MLB_USIO_REG_SCR);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		mlb_usio_stop_tx(port);
>  }
>  
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 7bf30e632313..ae7a8e3cf467 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -452,7 +452,7 @@ static void msm_complete_tx_dma(void *args)
>  {
>  	struct msm_port *msm_port = args;
>  	struct uart_port *port = &msm_port->uart;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct msm_dma *dma = &msm_port->tx_dma;
>  	struct dma_tx_state state;
>  	unsigned long flags;
> @@ -486,7 +486,7 @@ static void msm_complete_tx_dma(void *args)
>  	msm_port->imr |= MSM_UART_IMR_TXLEV;
>  	msm_write(port, msm_port->imr, MSM_UART_IMR);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	msm_handle_tx(port);
> @@ -496,14 +496,14 @@ static void msm_complete_tx_dma(void *args)
>  
>  static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>  {
> -	struct circ_buf *xmit = &msm_port->uart.state->xmit;
>  	struct uart_port *port = &msm_port->uart;
> +	struct tty_port *tport = &port->state->port;
>  	struct msm_dma *dma = &msm_port->tx_dma;
>  	int ret;
>  	u32 val;
>  
>  	sg_init_table(&dma->tx_sg, 1);
> -	sg_set_buf(&dma->tx_sg, &xmit->buf[xmit->tail], count);
> +	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, count);
>  
>  	ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
>  	if (ret)
> @@ -843,8 +843,8 @@ static void msm_handle_rx(struct uart_port *port)
>  
>  static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
>  	struct msm_port *msm_port = to_msm_port(port);
> +	struct tty_port *tport = &port->state->port;
>  	unsigned int num_chars;
>  	unsigned int tf_pointer = 0;
>  	void __iomem *tf;
> @@ -858,8 +858,7 @@ static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
>  		msm_reset_dm_count(port, tx_count);
>  
>  	while (tf_pointer < tx_count) {
> -		int i;
> -		char buf[4] = { 0 };
> +		unsigned char buf[4] = { 0 };
>  
>  		if (!(msm_read(port, MSM_UART_SR) & MSM_UART_SR_TX_READY))
>  			break;
> @@ -870,26 +869,23 @@ static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
>  		else
>  			num_chars = 1;
>  
> -		for (i = 0; i < num_chars; i++)
> -			buf[i] = xmit->buf[xmit->tail + i];
> -
> +		num_chars = uart_fifo_out(port, buf, num_chars);
>  		iowrite32_rep(tf, buf, 1);
> -		uart_xmit_advance(port, num_chars);
>  		tf_pointer += num_chars;
>  	}
>  
>  	/* disable tx interrupts if nothing more to send */
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		msm_stop_tx(port);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  }
>  
>  static void msm_handle_tx(struct uart_port *port)
>  {
>  	struct msm_port *msm_port = to_msm_port(port);
> -	struct circ_buf *xmit = &msm_port->uart.state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct msm_dma *dma = &msm_port->tx_dma;
>  	unsigned int pio_count, dma_count, dma_min;
>  	char buf[4] = { 0 };
> @@ -913,13 +909,13 @@ static void msm_handle_tx(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		msm_stop_tx(port);
>  		return;
>  	}
>  
> -	pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> -	dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	dma_count = pio_count = kfifo_out_linear(&tport->xmit_fifo, NULL,
> +			UART_XMIT_SIZE);
>  
>  	dma_min = 1;	/* Always DMA */
>  	if (msm_port->is_uartdm > UARTDM_1P3) {
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 0255646bc175..5de57b77abdb 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -219,12 +219,10 @@ static void mvebu_uart_stop_tx(struct uart_port *port)
>  static void mvebu_uart_start_tx(struct uart_port *port)
>  {
>  	unsigned int ctl;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	unsigned char c;
>  
> -	if (IS_EXTENDED(port) && !uart_circ_empty(xmit)) {
> -		writel(xmit->buf[xmit->tail], port->membase + UART_TSH(port));
> -		uart_xmit_advance(port, 1);
> -	}
> +	if (IS_EXTENDED(port) && uart_fifo_get(port, &c))
> +		writel(c, port->membase + UART_TSH(port));
>  
>  	ctl = readl(port->membase + UART_INTR(port));
>  	ctl |= CTRL_TX_RDY_INT(port);
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 4749331fe618..144b35d31497 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -517,7 +517,7 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s);
>  static void dma_tx_callback(void *param)
>  {
>  	struct mxs_auart_port *s = param;
> -	struct circ_buf *xmit = &s->port.state->xmit;
> +	struct tty_port *tport = &s->port.state->port;
>  
>  	dma_unmap_sg(s->dev, &s->tx_sgl, 1, DMA_TO_DEVICE);
>  
> @@ -526,7 +526,7 @@ static void dma_tx_callback(void *param)
>  	smp_mb__after_atomic();
>  
>  	/* wake up the possible processes. */
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&s->port);
>  
>  	mxs_auart_tx_chars(s);
> @@ -568,33 +568,22 @@ static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
>  
>  static void mxs_auart_tx_chars(struct mxs_auart_port *s)
>  {
> -	struct circ_buf *xmit = &s->port.state->xmit;
> +	struct tty_port *tport = &s->port.state->port;
>  	bool pending;
>  	u8 ch;
>  
>  	if (auart_dma_enabled(s)) {
>  		u32 i = 0;
> -		int size;
>  		void *buffer = s->tx_dma_buf;
>  
>  		if (test_and_set_bit(MXS_AUART_DMA_TX_SYNC, &s->flags))
>  			return;
>  
> -		while (!uart_circ_empty(xmit) && !uart_tx_stopped(&s->port)) {
> -			size = min_t(u32, UART_XMIT_SIZE - i,
> -				     CIRC_CNT_TO_END(xmit->head,
> -						     xmit->tail,
> -						     UART_XMIT_SIZE));
> -			memcpy(buffer + i, xmit->buf + xmit->tail, size);
> -			xmit->tail = (xmit->tail + size) & (UART_XMIT_SIZE - 1);
> -
> -			i += size;
> -			if (i >= UART_XMIT_SIZE)
> -				break;
> -		}
> -
>  		if (uart_tx_stopped(&s->port))
>  			mxs_auart_stop_tx(&s->port);
> +		else
> +			i = kfifo_out(&tport->xmit_fifo, buffer,
> +					UART_XMIT_SIZE);
>  
>  		if (i) {
>  			mxs_auart_dma_tx(s, i);
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 89257cddf540..c7cee5fee603 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -808,7 +808,7 @@ static int dma_handle_rx(struct eg20t_port *priv)
>  static unsigned int handle_tx(struct eg20t_port *priv)
>  {
>  	struct uart_port *port = &priv->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	unsigned char ch;
>  	int fifo_size;
>  	int tx_empty;
>  
> @@ -830,9 +830,9 @@ static unsigned int handle_tx(struct eg20t_port *priv)
>  		fifo_size--;
>  	}
>  
> -	while (!uart_tx_stopped(port) && !uart_circ_empty(xmit) && fifo_size) {
> -		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
> -		uart_xmit_advance(port, 1);
> +	while (!uart_tx_stopped(port) && fifo_size &&
> +			uart_fifo_get(port, &ch)) {
> +		iowrite8(ch, priv->membase + PCH_UART_THR);
>  		fifo_size--;
>  		tx_empty = 0;
>  	}
> @@ -850,14 +850,14 @@ static unsigned int handle_tx(struct eg20t_port *priv)
>  static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  {
>  	struct uart_port *port = &priv->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct scatterlist *sg;
>  	int nent;
>  	int fifo_size;
>  	struct dma_async_tx_descriptor *desc;
> +	unsigned int bytes, tail;
>  	int num;
>  	int i;
> -	int bytes;
>  	int size;
>  	int rem;
>  
> @@ -886,7 +886,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  		fifo_size--;
>  	}
>  
> -	bytes = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	bytes = kfifo_out_linear(&tport->xmit_fifo, &tail, UART_XMIT_SIZE);
>  	if (!bytes) {
>  		dev_dbg(priv->port.dev, "%s 0 bytes return\n", __func__);
>  		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_TX_INT);
> @@ -920,10 +920,10 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  
>  	for (i = 0; i < num; i++, sg++) {
>  		if (i == (num - 1))
> -			sg_set_page(sg, virt_to_page(xmit->buf),
> +			sg_set_page(sg, virt_to_page(tport->xmit_buf),
>  				    rem, fifo_size * i);
>  		else
> -			sg_set_page(sg, virt_to_page(xmit->buf),
> +			sg_set_page(sg, virt_to_page(tport->xmit_buf),
>  				    size, fifo_size * i);
>  	}
>  
> @@ -937,8 +937,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  	priv->nent = nent;
>  
>  	for (i = 0; i < nent; i++, sg++) {
> -		sg->offset = (xmit->tail & (UART_XMIT_SIZE - 1)) +
> -			      fifo_size * i;
> +		sg->offset = tail + fifo_size * i;
>  		sg_dma_address(sg) = (sg_dma_address(sg) &
>  				    ~(UART_XMIT_SIZE - 1)) + sg->offset;
>  		if (i == (nent - 1))
> diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
> index bbb46e6e98a2..f5af336a869b 100644
> --- a/drivers/tty/serial/pic32_uart.c
> +++ b/drivers/tty/serial/pic32_uart.c
> @@ -342,7 +342,7 @@ static void pic32_uart_do_rx(struct uart_port *port)
>  static void pic32_uart_do_tx(struct uart_port *port)
>  {
>  	struct pic32_sport *sport = to_pic32_sport(port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned int max_count = PIC32_UART_TX_FIFO_DEPTH;
>  
>  	if (port->x_char) {
> @@ -357,7 +357,7 @@ static void pic32_uart_do_tx(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		goto txq_empty;
>  
>  	/* keep stuffing chars into uart tx buffer
> @@ -371,21 +371,20 @@ static void pic32_uart_do_tx(struct uart_port *port)
>  	 */
>  	while (!(PIC32_UART_STA_UTXBF &
>  		pic32_uart_readl(sport, PIC32_UART_STA))) {
> -		unsigned int c = xmit->buf[xmit->tail];
> +		unsigned char c;
>  
> +		if (!uart_fifo_get(port, &c))
> +			break;
>  		pic32_uart_writel(sport, PIC32_UART_TX, c);
>  
> -		uart_xmit_advance(port, 1);
> -		if (uart_circ_empty(xmit))
> -			break;
>  		if (--max_count == 0)
>  			break;
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		goto txq_empty;
>  
>  	return;
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 05d97e89511e..63bc726273fd 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -347,7 +347,8 @@ static void pmz_status_handle(struct uart_pmac_port *uap)
>  
>  static void pmz_transmit_chars(struct uart_pmac_port *uap)
>  {
> -	struct circ_buf *xmit;
> +	struct tty_port *tport;
> +	unsigned char ch;
>  
>  	if (ZS_IS_CONS(uap)) {
>  		unsigned char status = read_zsreg(uap, R0);
> @@ -398,8 +399,8 @@ static void pmz_transmit_chars(struct uart_pmac_port *uap)
>  
>  	if (uap->port.state == NULL)
>  		goto ack_tx_int;
> -	xmit = &uap->port.state->xmit;
> -	if (uart_circ_empty(xmit)) {
> +	tport = &uap->port.state->port;
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		uart_write_wakeup(&uap->port);
>  		goto ack_tx_int;
>  	}
> @@ -407,12 +408,11 @@ static void pmz_transmit_chars(struct uart_pmac_port *uap)
>  		goto ack_tx_int;
>  
>  	uap->flags |= PMACZILOG_FLAG_TX_ACTIVE;
> -	write_zsdata(uap, xmit->buf[xmit->tail]);
> +	WARN_ON(!uart_fifo_get(&uap->port, &ch));
> +	write_zsdata(uap, ch);
>  	zssync(uap);
>  
> -	uart_xmit_advance(&uap->port, 1);
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&uap->port);
>  
>  	return;
> @@ -620,15 +620,15 @@ static void pmz_start_tx(struct uart_port *port)
>  		port->icount.tx++;
>  		port->x_char = 0;
>  	} else {
> -		struct circ_buf *xmit = &port->state->xmit;
> +		struct tty_port *tport = &port->state->port;
> +		unsigned char ch;
>  
> -		if (uart_circ_empty(xmit))
> +		if (!uart_fifo_get(&uap->port, &ch))
>  			return;
> -		write_zsdata(uap, xmit->buf[xmit->tail]);
> +		write_zsdata(uap, ch);
>  		zssync(uap);
> -		uart_xmit_advance(port, 1);
>  
> -		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  			uart_write_wakeup(&uap->port);
>  	}
>  }
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index f9f7ac1a10df..7814982f1921 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -505,7 +505,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>  		 */
>  		qcom_geni_serial_poll_tx_done(uport);
>  
> -		if (!uart_circ_empty(&uport->state->xmit)) {
> +		if (!kfifo_is_empty(&uport->state->port.xmit_fifo)) {
>  			irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>  			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
>  					uport->membase + SE_GENI_M_IRQ_EN);
> @@ -620,22 +620,24 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>  static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
> -	struct circ_buf *xmit = &uport->state->xmit;
> +	struct tty_port *tport = &uport->state->port;
>  	unsigned int xmit_size;
> +	u8 *tail;
>  	int ret;
>  
>  	if (port->tx_dma_addr)
>  		return;
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		return;
>  
> -	xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
> +			UART_XMIT_SIZE);
>  
>  	qcom_geni_serial_setup_tx(uport, xmit_size);
>  
> -	ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
> -				  xmit_size, &port->tx_dma_addr);
> +	ret = geni_se_tx_dma_prep(&port->se, tail, xmit_size,
> +				  &port->tx_dma_addr);
>  	if (ret) {
>  		dev_err(uport->dev, "unable to start TX SE DMA: %d\n", ret);
>  		qcom_geni_serial_stop_tx_dma(uport);
> @@ -853,18 +855,16 @@ static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
>  					     unsigned int chunk)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
> -	struct circ_buf *xmit = &uport->state->xmit;
> -	unsigned int tx_bytes, c, remaining = chunk;
> +	struct tty_port *tport = &uport->state->port;
> +	unsigned int tx_bytes, remaining = chunk;
>  	u8 buf[BYTES_PER_FIFO_WORD];
>  
>  	while (remaining) {
>  		memset(buf, 0, sizeof(buf));
>  		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
>  
> -		for (c = 0; c < tx_bytes ; c++) {
> -			buf[c] = xmit->buf[xmit->tail];
> -			uart_xmit_advance(uport, 1);
> -		}
> +		tx_bytes = kfifo_out(&tport->xmit_fifo, buf, tx_bytes);
> +		uart_xmit_advance(uport, tx_bytes);
>  
>  		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
>  
> @@ -877,7 +877,7 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
>  					    bool done, bool active)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
> -	struct circ_buf *xmit = &uport->state->xmit;
> +	struct tty_port *tport = &uport->state->port;
>  	size_t avail;
>  	size_t pending;
>  	u32 status;
> @@ -890,7 +890,7 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
>  	if (active)
>  		pending = port->tx_remaining;
>  	else
> -		pending = uart_circ_chars_pending(xmit);
> +		pending = kfifo_len(&tport->xmit_fifo);
>  
>  	/* All data has been transmitted and acknowledged as received */
>  	if (!pending && !status && done) {
> @@ -933,24 +933,24 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
>  					uport->membase + SE_GENI_M_IRQ_EN);
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(uport);
>  }
>  
>  static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
> -	struct circ_buf *xmit = &uport->state->xmit;
> +	struct tty_port *tport = &uport->state->port;
>  
>  	uart_xmit_advance(uport, port->tx_remaining);
>  	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
>  	port->tx_dma_addr = 0;
>  	port->tx_remaining = 0;
>  
> -	if (!uart_circ_empty(xmit))
> +	if (!kfifo_is_empty(&tport->xmit_fifo))
>  		qcom_geni_serial_start_tx_dma(uport);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(uport);
>  }
>  
> diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
> index 82def9b8632a..663e35e424bd 100644
> --- a/drivers/tty/serial/rda-uart.c
> +++ b/drivers/tty/serial/rda-uart.c
> @@ -330,8 +330,8 @@ static void rda_uart_set_termios(struct uart_port *port,
>  
>  static void rda_uart_send_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned int ch;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned char ch;
>  	u32 val;
>  
>  	if (uart_tx_stopped(port))
> @@ -347,19 +347,14 @@ static void rda_uart_send_chars(struct uart_port *port)
>  		port->x_char = 0;
>  	}
>  
> -	while (rda_uart_read(port, RDA_UART_STATUS) & RDA_UART_TX_FIFO_MASK) {
> -		if (uart_circ_empty(xmit))
> -			break;
> -
> -		ch = xmit->buf[xmit->tail];
> +	while ((rda_uart_read(port, RDA_UART_STATUS) & RDA_UART_TX_FIFO_MASK) &&
> +			uart_fifo_get(port, &ch))
>  		rda_uart_write(port, ch, RDA_UART_RXTX_BUFFER);
> -		uart_xmit_advance(port, 1);
> -	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (!uart_circ_empty(xmit)) {
> +	if (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		/* Re-enable Tx FIFO interrupt */
>  		val = rda_uart_read(port, RDA_UART_IRQ_MASK);
>  		val |= RDA_UART_TX_DATA_NEEDED;
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index a2d07e05c502..dc35eb77d2ef 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -329,7 +329,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>  {
>  	struct s3c24xx_uart_port *ourport = args;
>  	struct uart_port *port = &ourport->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>  	struct dma_tx_state state;
>  	unsigned long flags;
> @@ -348,7 +348,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>  	uart_xmit_advance(port, count);
>  	ourport->tx_in_progress = 0;
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	s3c24xx_serial_start_next_tx(ourport);
> @@ -431,17 +431,15 @@ static void s3c24xx_serial_start_tx_pio(struct s3c24xx_uart_port *ourport)
>  }
>  
>  static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
> -				      unsigned int count)
> +				      unsigned int count, unsigned int tail)
>  {
> -	struct uart_port *port = &ourport->port;
> -	struct circ_buf *xmit = &port->state->xmit;
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>  
>  	if (ourport->tx_mode != S3C24XX_TX_DMA)
>  		enable_tx_dma(ourport);
>  
>  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
> -	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
> +	dma->tx_transfer_addr = dma->tx_addr + tail;
>  
>  	dma_sync_single_for_device(dma->tx_chan->device->dev,
>  				   dma->tx_transfer_addr, dma->tx_size,
> @@ -468,11 +466,11 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>  static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
>  {
>  	struct uart_port *port = &ourport->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned long count;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned int count, tail;
>  
>  	/* Get data size up to the end of buffer */
> -	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	count = kfifo_out_linear(&tport->xmit_fifo, &tail, UART_XMIT_SIZE);
>  
>  	if (!count) {
>  		s3c24xx_serial_stop_tx(port);
> @@ -481,16 +479,16 @@ static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
>  
>  	if (!ourport->dma || !ourport->dma->tx_chan ||
>  	    count < ourport->min_dma_size ||
> -	    xmit->tail & (dma_get_cache_alignment() - 1))
> +	    tail & (dma_get_cache_alignment() - 1))
>  		s3c24xx_serial_start_tx_pio(ourport);
>  	else
> -		s3c24xx_serial_start_tx_dma(ourport, count);
> +		s3c24xx_serial_start_tx_dma(ourport, count, tail);
>  }
>  
>  static void s3c24xx_serial_start_tx(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
>  	if (!ourport->tx_enabled) {
>  		if (port->flags & UPF_CONS_FLOW)
> @@ -502,7 +500,8 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
>  	}
>  
>  	if (ourport->dma && ourport->dma->tx_chan) {
> -		if (!uart_circ_empty(xmit) && !ourport->tx_in_progress)
> +		if (!kfifo_is_empty(&tport->xmit_fifo) &&
> +				!ourport->tx_in_progress)
>  			s3c24xx_serial_start_next_tx(ourport);
>  	}
>  }
> @@ -868,18 +867,19 @@ static irqreturn_t s3c24xx_serial_rx_irq(int irq, void *dev_id)
>  static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
>  {
>  	struct uart_port *port = &ourport->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> -	int count, dma_count = 0;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned int count, dma_count = 0, tail;
>  
> -	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	count = kfifo_out_linear(&tport->xmit_fifo, &tail, UART_XMIT_SIZE);
>  
>  	if (ourport->dma && ourport->dma->tx_chan &&
>  	    count >= ourport->min_dma_size) {
>  		int align = dma_get_cache_alignment() -
> -			(xmit->tail & (dma_get_cache_alignment() - 1));
> +			(tail & (dma_get_cache_alignment() - 1));
>  		if (count - align >= ourport->min_dma_size) {
>  			dma_count = count - align;
>  			count = align;
> +			tail += align;
>  		}
>  	}
>  
> @@ -894,7 +894,7 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
>  	 * stopped, disable the uart and exit
>  	 */
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		s3c24xx_serial_stop_tx(port);
>  		return;
>  	}
> @@ -906,24 +906,25 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
>  		dma_count = 0;
>  	}
>  
> -	while (!uart_circ_empty(xmit) && count > 0) {
> -		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)
> +	while (!(rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)) {
> +		unsigned char ch;
> +
> +		if (!uart_fifo_get(port, &ch))
>  			break;
>  
> -		wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
> -		uart_xmit_advance(port, 1);
> +		wr_reg(port, S3C2410_UTXH, ch);
>  		count--;
>  	}
>  
>  	if (!count && dma_count) {
> -		s3c24xx_serial_start_tx_dma(ourport, dma_count);
> +		s3c24xx_serial_start_tx_dma(ourport, dma_count, tail);
>  		return;
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		s3c24xx_serial_stop_tx(port);
>  }
>  
> @@ -1118,7 +1119,8 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  
>  	/* TX buffer */
>  	dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,
> -				      p->port.state->xmit.buf, UART_XMIT_SIZE,
> +				      p->port.state->port.xmit_buf,
> +				      UART_XMIT_SIZE,
>  				      DMA_TO_DEVICE);
>  	if (dma_mapping_error(dma->tx_chan->device->dev, dma->tx_addr)) {
>  		reason = "DMA mapping error for TX buffer";
> diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
> index dbec29d9a6c3..b4e1b90e5960 100644
> --- a/drivers/tty/serial/sb1250-duart.c
> +++ b/drivers/tty/serial/sb1250-duart.c
> @@ -382,7 +382,8 @@ static void sbd_receive_chars(struct sbd_port *sport)
>  static void sbd_transmit_chars(struct sbd_port *sport)
>  {
>  	struct uart_port *uport = &sport->port;
> -	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct tty_port *tport = &sport->port.state->port;
> +	unsigned char ch;
>  	unsigned int mask;
>  	int stop_tx;
>  
> @@ -395,19 +396,19 @@ static void sbd_transmit_chars(struct sbd_port *sport)
>  	}
>  
>  	/* If nothing to do or stopped or hardware stopped.  */
> -	stop_tx = (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port));
> +	stop_tx = uart_tx_stopped(&sport->port) ||
> +		!uart_fifo_get(&sport->port, &ch);
>  
>  	/* Send char.  */
>  	if (!stop_tx) {
> -		write_sbdchn(sport, R_DUART_TX_HOLD, xmit->buf[xmit->tail]);
> -		uart_xmit_advance(&sport->port, 1);
> +		write_sbdchn(sport, R_DUART_TX_HOLD, ch);
>  
> -		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  			uart_write_wakeup(&sport->port);
>  	}
>  
>  	/* Are we are done?  */
> -	if (stop_tx || uart_circ_empty(xmit)) {
> +	if (stop_tx || kfifo_is_empty(&tport->xmit_fifo)) {
>  		/* Disable tx interrupts.  */
>  		mask = read_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2));
>  		mask &= ~M_DUART_IMR_TX;
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 929206a9a6e1..c6983b7bd78c 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -676,9 +676,9 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
>  static void sc16is7xx_handle_tx(struct uart_port *port)
>  {
>  	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned int txlen, to_send, i;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned long flags;
> +	unsigned int txlen;
>  
>  	if (unlikely(port->x_char)) {
>  		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
> @@ -687,40 +687,30 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		uart_port_lock_irqsave(port, &flags);
>  		sc16is7xx_stop_tx(port);
>  		uart_port_unlock_irqrestore(port, flags);
>  		return;
>  	}
>  
> -	/* Get length of data pending in circular buffer */
> -	to_send = uart_circ_chars_pending(xmit);
> -	if (likely(to_send)) {
> -		/* Limit to space available in TX FIFO */
> -		txlen = sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
> -		if (txlen > SC16IS7XX_FIFO_SIZE) {
> -			dev_err_ratelimited(port->dev,
> -				"chip reports %d free bytes in TX fifo, but it only has %d",
> -				txlen, SC16IS7XX_FIFO_SIZE);
> -			txlen = 0;
> -		}
> -		to_send = (to_send > txlen) ? txlen : to_send;
> -
> -		/* Convert to linear buffer */
> -		for (i = 0; i < to_send; ++i) {
> -			s->buf[i] = xmit->buf[xmit->tail];
> -			uart_xmit_advance(port, 1);
> -		}
> -
> -		sc16is7xx_fifo_write(port, s->buf, to_send);
> +	/* Limit to space available in TX FIFO */
> +	txlen = sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
> +	if (txlen > SC16IS7XX_FIFO_SIZE) {
> +		dev_err_ratelimited(port->dev,
> +			"chip reports %d free bytes in TX fifo, but it only has %d",
> +			txlen, SC16IS7XX_FIFO_SIZE);
> +		txlen = 0;
>  	}
>  
> +	txlen = uart_fifo_out(port, s->buf, txlen);
> +	sc16is7xx_fifo_write(port, s->buf, txlen);
> +
>  	uart_port_lock_irqsave(port, &flags);
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		sc16is7xx_stop_tx(port);
>  	else
>  		sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
> diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
> index f24217a560d7..6d1d142fd216 100644
> --- a/drivers/tty/serial/sccnxp.c
> +++ b/drivers/tty/serial/sccnxp.c
> @@ -439,7 +439,7 @@ static void sccnxp_handle_rx(struct uart_port *port)
>  static void sccnxp_handle_tx(struct uart_port *port)
>  {
>  	u8 sr;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct sccnxp_port *s = dev_get_drvdata(port->dev);
>  
>  	if (unlikely(port->x_char)) {
> @@ -449,7 +449,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		/* Disable TX if FIFO is empty */
>  		if (sccnxp_port_read(port, SCCNXP_SR_REG) & SR_TXEMT) {
>  			sccnxp_disable_irq(port, IMR_TXRDY);
> @@ -461,16 +461,20 @@ static void sccnxp_handle_tx(struct uart_port *port)
>  		return;
>  	}
>  
> -	while (!uart_circ_empty(xmit)) {
> +	while (1) {
> +		unsigned char ch;
> +
>  		sr = sccnxp_port_read(port, SCCNXP_SR_REG);
>  		if (!(sr & SR_TXRDY))
>  			break;
>  
> -		sccnxp_port_write(port, SCCNXP_THR_REG, xmit->buf[xmit->tail]);
> -		uart_xmit_advance(port, 1);
> +		if (!uart_fifo_get(port, &ch))
> +			break;
> +
> +		sccnxp_port_write(port, SCCNXP_THR_REG, ch);
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  }
>  
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index 525f3a2f7bd4..1183ca54ab92 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -484,18 +484,18 @@ static void tegra_uart_release_port(struct uart_port *u)
>  
>  static void tegra_uart_fill_tx_fifo(struct tegra_uart_port *tup, int max_bytes)
>  {
> -	struct circ_buf *xmit = &tup->uport.state->xmit;
> +	unsigned char ch;
>  	int i;
>  
>  	for (i = 0; i < max_bytes; i++) {
> -		BUG_ON(uart_circ_empty(xmit));
>  		if (tup->cdata->tx_fifo_full_status) {
>  			unsigned long lsr = tegra_uart_read(tup, UART_LSR);
>  			if ((lsr & TEGRA_UART_LSR_TXFIFO_FULL))
>  				break;
>  		}
> -		tegra_uart_write(tup, xmit->buf[xmit->tail], UART_TX);
> -		uart_xmit_advance(&tup->uport, 1);
> +		if (WARN_ON_ONCE(!uart_fifo_get(&tup->uport, &ch)))
> +			break;
> +		tegra_uart_write(tup, ch, UART_TX);
>  	}
>  }
>  
> @@ -514,7 +514,7 @@ static void tegra_uart_start_pio_tx(struct tegra_uart_port *tup,
>  static void tegra_uart_tx_dma_complete(void *args)
>  {
>  	struct tegra_uart_port *tup = args;
> -	struct circ_buf *xmit = &tup->uport.state->xmit;
> +	struct tty_port *tport = &tup->uport.state->port;
>  	struct dma_tx_state state;
>  	unsigned long flags;
>  	unsigned int count;
> @@ -525,7 +525,7 @@ static void tegra_uart_tx_dma_complete(void *args)
>  	uart_port_lock_irqsave(&tup->uport, &flags);
>  	uart_xmit_advance(&tup->uport, count);
>  	tup->tx_in_progress = 0;
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&tup->uport);
>  	tegra_uart_start_next_tx(tup);
>  	uart_port_unlock_irqrestore(&tup->uport, flags);
> @@ -534,11 +534,14 @@ static void tegra_uart_tx_dma_complete(void *args)
>  static int tegra_uart_start_tx_dma(struct tegra_uart_port *tup,
>  		unsigned long count)
>  {
> -	struct circ_buf *xmit = &tup->uport.state->xmit;
> +	struct tty_port *tport = &tup->uport.state->port;
>  	dma_addr_t tx_phys_addr;
> +	unsigned int tail;
>  
>  	tup->tx_bytes = count & ~(0xF);
> -	tx_phys_addr = tup->tx_dma_buf_phys + xmit->tail;
> +	WARN_ON_ONCE(kfifo_out_linear(&tport->xmit_fifo, &tail,
> +			UART_XMIT_SIZE) < count);
> +	tx_phys_addr = tup->tx_dma_buf_phys + tail;
>  
>  	dma_sync_single_for_device(tup->uport.dev, tx_phys_addr,
>  				   tup->tx_bytes, DMA_TO_DEVICE);
> @@ -562,18 +565,21 @@ static int tegra_uart_start_tx_dma(struct tegra_uart_port *tup,
>  
>  static void tegra_uart_start_next_tx(struct tegra_uart_port *tup)
>  {
> +	struct tty_port *tport = &tup->uport.state->port;
> +	unsigned char *tail_ptr;
>  	unsigned long tail;
> -	unsigned long count;
> -	struct circ_buf *xmit = &tup->uport.state->xmit;
> +	unsigned int count;
>  
>  	if (!tup->current_baud)
>  		return;
>  
> -	tail = (unsigned long)&xmit->buf[xmit->tail];
> -	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	count = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail_ptr,
> +			UART_XMIT_SIZE);
>  	if (!count)
>  		return;
>  
> +	tail = (unsigned long)tail_ptr;
> +
>  	if (tup->use_tx_pio || count < TEGRA_UART_MIN_DMA)
>  		tegra_uart_start_pio_tx(tup, count);
>  	else if (BYTES_TO_ALIGN(tail) > 0)
> @@ -586,9 +592,9 @@ static void tegra_uart_start_next_tx(struct tegra_uart_port *tup)
>  static void tegra_uart_start_tx(struct uart_port *u)
>  {
>  	struct tegra_uart_port *tup = to_tegra_uport(u);
> -	struct circ_buf *xmit = &u->state->xmit;
> +	struct tty_port *tport = &u->state->port;
>  
> -	if (!uart_circ_empty(xmit) && !tup->tx_in_progress)
> +	if (!kfifo_is_empty(&tport->xmit_fifo) && !tup->tx_in_progress)
>  		tegra_uart_start_next_tx(tup);
>  }
>  
> @@ -628,11 +634,11 @@ static void tegra_uart_stop_tx(struct uart_port *u)
>  
>  static void tegra_uart_handle_tx_pio(struct tegra_uart_port *tup)
>  {
> -	struct circ_buf *xmit = &tup->uport.state->xmit;
> +	struct tty_port *tport = &tup->uport.state->port;
>  
>  	tegra_uart_fill_tx_fifo(tup, tup->tx_bytes);
>  	tup->tx_in_progress = 0;
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&tup->uport);
>  	tegra_uart_start_next_tx(tup);
>  }
> @@ -1169,15 +1175,14 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
>  		tup->rx_dma_buf_virt = dma_buf;
>  		tup->rx_dma_buf_phys = dma_phys;
>  	} else {
> +		dma_buf = tup->uport.state->port.xmit_buf;
>  		dma_phys = dma_map_single(tup->uport.dev,
> -			tup->uport.state->xmit.buf, UART_XMIT_SIZE,
> -			DMA_TO_DEVICE);
> +			dma_buf, UART_XMIT_SIZE, DMA_TO_DEVICE);
>  		if (dma_mapping_error(tup->uport.dev, dma_phys)) {
>  			dev_err(tup->uport.dev, "dma_map_single tx failed\n");
>  			dma_release_channel(dma_chan);
>  			return -ENOMEM;
>  		}
> -		dma_buf = tup->uport.state->xmit.buf;
>  		dma_sconfig.dst_addr = tup->uport.mapbase;
>  		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>  		dma_sconfig.dst_maxburst = 16;
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index ff85ebd3a007..3c0931fba1c6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -272,9 +272,10 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>  		return -ENOMEM;
>  
>  	uart_port_lock(state, flags);
> -	if (!state->xmit.buf) {
> -		state->xmit.buf = (unsigned char *) page;
> -		uart_circ_clear(&state->xmit);
> +	if (!state->port.xmit_buf) {
> +		state->port.xmit_buf = (unsigned char *)page;
> +		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
> +				PAGE_SIZE);
>  		uart_port_unlock(uport, flags);
>  	} else {
>  		uart_port_unlock(uport, flags);
> @@ -387,8 +388,9 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	 * can endup in printk() recursion.
>  	 */
>  	uart_port_lock(state, flags);
> -	xmit_buf = state->xmit.buf;
> -	state->xmit.buf = NULL;
> +	xmit_buf = port->xmit_buf;
> +	port->xmit_buf = NULL;
> +	INIT_KFIFO(port->xmit_fifo);
>  	uart_port_unlock(uport, flags);
>  
>  	free_page((unsigned long)xmit_buf);
> @@ -552,22 +554,17 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
>  {
>  	struct uart_state *state = tty->driver_data;
>  	struct uart_port *port;
> -	struct circ_buf *circ;
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	circ = &state->xmit;
>  	port = uart_port_lock(state, flags);
> -	if (!circ->buf) {
> +	if (WARN_ON_ONCE(!state->port.xmit_buf)) {
>  		uart_port_unlock(port, flags);
>  		return 0;
>  	}
>  
> -	if (port && uart_circ_chars_free(circ) != 0) {
> -		circ->buf[circ->head] = c;
> -		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
> -		ret = 1;
> -	}
> +	if (port)
> +		ret = kfifo_put(&state->port.xmit_fifo, c);
>  	uart_port_unlock(port, flags);
>  	return ret;
>  }
> @@ -581,9 +578,8 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
>  {
>  	struct uart_state *state = tty->driver_data;
>  	struct uart_port *port;
> -	struct circ_buf *circ;
>  	unsigned long flags;
> -	int c, ret = 0;
> +	int ret = 0;
>  
>  	/*
>  	 * This means you called this function _after_ the port was
> @@ -593,24 +589,13 @@ static ssize_t uart_write(struct tty_struct *tty, const u8 *buf, size_t count)
>  		return -EL3HLT;
>  
>  	port = uart_port_lock(state, flags);
> -	circ = &state->xmit;
> -	if (!circ->buf) {
> +	if (WARN_ON_ONCE(!state->port.xmit_buf)) {
>  		uart_port_unlock(port, flags);
>  		return 0;
>  	}
>  
> -	while (port) {
> -		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
> -		if (count < c)
> -			c = count;
> -		if (c <= 0)
> -			break;
> -		memcpy(circ->buf + circ->head, buf, c);
> -		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
> -		buf += c;
> -		count -= c;
> -		ret += c;
> -	}
> +	if (port)
> +		ret = kfifo_in(&state->port.xmit_fifo, buf, count);
>  
>  	__uart_start(state);
>  	uart_port_unlock(port, flags);
> @@ -625,7 +610,7 @@ static unsigned int uart_write_room(struct tty_struct *tty)
>  	unsigned int ret;
>  
>  	port = uart_port_lock(state, flags);
> -	ret = uart_circ_chars_free(&state->xmit);
> +	ret = kfifo_avail(&state->port.xmit_fifo);
>  	uart_port_unlock(port, flags);
>  	return ret;
>  }
> @@ -638,7 +623,7 @@ static unsigned int uart_chars_in_buffer(struct tty_struct *tty)
>  	unsigned int ret;
>  
>  	port = uart_port_lock(state, flags);
> -	ret = uart_circ_chars_pending(&state->xmit);
> +	ret = kfifo_len(&state->port.xmit_fifo);
>  	uart_port_unlock(port, flags);
>  	return ret;
>  }
> @@ -661,7 +646,7 @@ static void uart_flush_buffer(struct tty_struct *tty)
>  	port = uart_port_lock(state, flags);
>  	if (!port)
>  		return;
> -	uart_circ_clear(&state->xmit);
> +	kfifo_reset(&state->port.xmit_fifo);
>  	if (port->ops->flush_buffer)
>  		port->ops->flush_buffer(port);
>  	uart_port_unlock(port, flags);
> @@ -1064,7 +1049,7 @@ static int uart_get_lsr_info(struct tty_struct *tty,
>  	 * interrupt happens).
>  	 */
>  	if (uport->x_char ||
> -	    ((uart_circ_chars_pending(&state->xmit) > 0) &&
> +	    (!kfifo_is_empty(&state->port.xmit_fifo) &&
>  	     !uart_tx_stopped(uport)))
>  		result &= ~TIOCSER_TEMT;
>  
> @@ -1788,8 +1773,9 @@ static void uart_tty_port_shutdown(struct tty_port *port)
>  	 * Free the transmit buffer.
>  	 */
>  	uart_port_lock_irq(uport);
> -	buf = state->xmit.buf;
> -	state->xmit.buf = NULL;
> +	buf = port->xmit_buf;
> +	port->xmit_buf = NULL;
> +	INIT_KFIFO(port->xmit_fifo);
>  	uart_port_unlock_irq(uport);
>  
>  	free_page((unsigned long)buf);
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> index 22b9eeb23e68..3408c8827561 100644
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -23,7 +23,7 @@
>  static int __serial_port_busy(struct uart_port *port)
>  {
>  	return !uart_tx_stopped(port) &&
> -		uart_circ_chars_pending(&port->state->xmit);
> +		!kfifo_is_empty(&port->state->port.xmit_fifo);
>  }
>  
>  static int serial_port_runtime_resume(struct device *dev)
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index e512eaa57ed5..97031db26ae4 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -585,7 +585,7 @@ static void sci_start_tx(struct uart_port *port)
>  			sci_serial_out(port, SCSCR, new);
>  	}
>  
> -	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
> +	if (s->chan_tx && !kfifo_is_empty(&port->state->port.xmit_fifo) &&
>  	    dma_submit_error(s->cookie_tx)) {
>  		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
>  			/* Switch irq from SCIF to DMA */
> @@ -817,7 +817,7 @@ static int sci_rxfill(struct uart_port *port)
>  
>  static void sci_transmit_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned int stopped = uart_tx_stopped(port);
>  	unsigned short status;
>  	unsigned short ctrl;
> @@ -826,7 +826,7 @@ static void sci_transmit_chars(struct uart_port *port)
>  	status = sci_serial_in(port, SCxSR);
>  	if (!(status & SCxSR_TDxE(port))) {
>  		ctrl = sci_serial_in(port, SCSCR);
> -		if (uart_circ_empty(xmit))
> +		if (kfifo_is_empty(&tport->xmit_fifo))
>  			ctrl &= ~SCSCR_TIE;
>  		else
>  			ctrl |= SCSCR_TIE;
> @@ -842,15 +842,14 @@ static void sci_transmit_chars(struct uart_port *port)
>  		if (port->x_char) {
>  			c = port->x_char;
>  			port->x_char = 0;
> -		} else if (!uart_circ_empty(xmit) && !stopped) {
> -			c = xmit->buf[xmit->tail];
> -			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		} else if (port->type == PORT_SCI && uart_circ_empty(xmit)) {
> -			ctrl = sci_serial_in(port, SCSCR);
> -			ctrl &= ~SCSCR_TE;
> -			sci_serial_out(port, SCSCR, ctrl);
> -			return;
> -		} else {
> +		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
> +			if (port->type == PORT_SCI &&
> +				   kfifo_is_empty(&tport->xmit_fifo)) {
> +				ctrl = sci_serial_in(port, SCSCR);
> +				ctrl &= ~SCSCR_TE;
> +				sci_serial_out(port, SCSCR, ctrl);
> +				return;
> +			}
>  			break;
>  		}
>  
> @@ -861,9 +860,9 @@ static void sci_transmit_chars(struct uart_port *port)
>  
>  	sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		if (port->type == PORT_SCI) {
>  			ctrl = sci_serial_in(port, SCSCR);
>  			ctrl &= ~SCSCR_TIE;
> @@ -1199,7 +1198,7 @@ static void sci_dma_tx_complete(void *arg)
>  {
>  	struct sci_port *s = arg;
>  	struct uart_port *port = &s->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned long flags;
>  
>  	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
> @@ -1208,10 +1207,10 @@ static void sci_dma_tx_complete(void *arg)
>  
>  	uart_xmit_advance(port, s->tx_dma_len);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (!uart_circ_empty(xmit)) {
> +	if (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		s->cookie_tx = 0;
>  		schedule_work(&s->work_tx);
>  	} else {
> @@ -1424,10 +1423,10 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
>  	struct dma_async_tx_descriptor *desc;
>  	struct dma_chan *chan = s->chan_tx;
>  	struct uart_port *port = &s->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned long flags;
> +	unsigned int tail;
>  	dma_addr_t buf;
> -	int head, tail;
>  
>  	/*
>  	 * DMA is idle now.
> @@ -1437,10 +1436,9 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
>  	 * consistent xmit buffer state.
>  	 */
>  	uart_port_lock_irq(port);
> -	head = xmit->head;
> -	tail = xmit->tail;
> +	s->tx_dma_len = kfifo_out_linear(&tport->xmit_fifo, &tail,
> +			UART_XMIT_SIZE);
>  	buf = s->tx_dma_addr + tail;
> -	s->tx_dma_len = CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE);
>  	if (!s->tx_dma_len) {
>  		/* Transmit buffer has been flushed */
>  		uart_port_unlock_irq(port);
> @@ -1469,8 +1467,8 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
>  	}
>  
>  	uart_port_unlock_irq(port);
> -	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
> -		__func__, xmit->buf, tail, head, s->cookie_tx);
> +	dev_dbg(port->dev, "%s: %p: %u, cookie %d\n",
> +		__func__, tport->xmit_buf, tail, s->cookie_tx);
>  
>  	dma_async_issue_pending(chan);
>  	return;
> @@ -1585,6 +1583,7 @@ static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
>  static void sci_request_dma(struct uart_port *port)
>  {
>  	struct sci_port *s = to_sci_port(port);
> +	struct tty_port *tport = &port->state->port;
>  	struct dma_chan *chan;
>  
>  	dev_dbg(port->dev, "%s: port %d\n", __func__, port->line);
> @@ -1613,7 +1612,7 @@ static void sci_request_dma(struct uart_port *port)
>  	if (chan) {
>  		/* UART circular tx buffer is an aligned page. */
>  		s->tx_dma_addr = dma_map_single(chan->device->dev,
> -						port->state->xmit.buf,
> +						tport->xmit_buf,
>  						UART_XMIT_SIZE,
>  						DMA_TO_DEVICE);
>  		if (dma_mapping_error(chan->device->dev, s->tx_dma_addr)) {
> @@ -1622,7 +1621,7 @@ static void sci_request_dma(struct uart_port *port)
>  		} else {
>  			dev_dbg(port->dev, "%s: mapped %lu@%p to %pad\n",
>  				__func__, UART_XMIT_SIZE,
> -				port->state->xmit.buf, &s->tx_dma_addr);
> +				tport->xmit_buf, &s->tx_dma_addr);
>  
>  			INIT_WORK(&s->work_tx, sci_dma_tx_work_fn);
>  			s->chan_tx_saved = s->chan_tx = chan;
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 15f14fa593da..3fc54cc02a1f 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -227,13 +227,13 @@ static int sprd_tx_buf_remap(struct uart_port *port)
>  {
>  	struct sprd_uart_port *sp =
>  		container_of(port, struct sprd_uart_port, port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned char *tail;
>  
> -	sp->tx_dma.trans_len =
> -		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	sp->tx_dma.trans_len = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
> +			UART_XMIT_SIZE);
>  
> -	sp->tx_dma.phys_addr = dma_map_single(port->dev,
> -					      (void *)&(xmit->buf[xmit->tail]),
> +	sp->tx_dma.phys_addr = dma_map_single(port->dev, tail,
>  					      sp->tx_dma.trans_len,
>  					      DMA_TO_DEVICE);
>  	return dma_mapping_error(port->dev, sp->tx_dma.phys_addr);
> @@ -244,7 +244,7 @@ static void sprd_complete_tx_dma(void *data)
>  	struct uart_port *port = (struct uart_port *)data;
>  	struct sprd_uart_port *sp =
>  		container_of(port, struct sprd_uart_port, port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned long flags;
>  
>  	uart_port_lock_irqsave(port, &flags);
> @@ -253,10 +253,10 @@ static void sprd_complete_tx_dma(void *data)
>  
>  	uart_xmit_advance(port, sp->tx_dma.trans_len);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit) || sprd_tx_buf_remap(port) ||
> +	if (kfifo_is_empty(&tport->xmit_fifo) || sprd_tx_buf_remap(port) ||
>  	    sprd_tx_dma_config(port))
>  		sp->tx_dma.trans_len = 0;
>  
> @@ -319,7 +319,7 @@ static void sprd_start_tx_dma(struct uart_port *port)
>  {
>  	struct sprd_uart_port *sp =
>  		container_of(port, struct sprd_uart_port, port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
>  	if (port->x_char) {
>  		serial_out(port, SPRD_TXD, port->x_char);
> @@ -328,7 +328,7 @@ static void sprd_start_tx_dma(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		sprd_stop_tx_dma(port);
>  		return;
>  	}
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index a23e59551848..f91753a40a69 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -387,9 +387,9 @@ static unsigned int asc_get_mctrl(struct uart_port *port)
>  /* There are probably characters waiting to be transmitted. */
>  static void asc_start_tx(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
> -	if (!uart_circ_empty(xmit))
> +	if (!kfifo_is_empty(&tport->xmit_fifo))
>  		asc_enable_tx_interrupts(port);
>  }
>  
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 58d169e5c1db..8c66abcfe6ca 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -696,18 +696,23 @@ static void stm32_usart_transmit_chars_pio(struct uart_port *port)
>  {
>  	struct stm32_port *stm32_port = to_stm32_port(port);
>  	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
> +
> +	while (1) {
> +		unsigned char ch;
>  
> -	while (!uart_circ_empty(xmit)) {
>  		/* Check that TDR is empty before filling FIFO */
>  		if (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
>  			break;
> -		writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
> -		uart_xmit_advance(port, 1);
> +
> +		if (!uart_fifo_get(port, &ch))
> +			break;
> +
> +		writel_relaxed(ch, port->membase + ofs->tdr);
>  	}
>  
>  	/* rely on TXE irq (mask or unmask) for sending remaining data */
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		stm32_usart_tx_interrupt_disable(port);
>  	else
>  		stm32_usart_tx_interrupt_enable(port);
> @@ -716,7 +721,7 @@ static void stm32_usart_transmit_chars_pio(struct uart_port *port)
>  static void stm32_usart_transmit_chars_dma(struct uart_port *port)
>  {
>  	struct stm32_port *stm32port = to_stm32_port(port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	struct dma_async_tx_descriptor *desc = NULL;
>  	unsigned int count;
>  	int ret;
> @@ -728,25 +733,8 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
>  		return;
>  	}
>  
> -	count = uart_circ_chars_pending(xmit);
> -
> -	if (count > TX_BUF_L)
> -		count = TX_BUF_L;
> -
> -	if (xmit->tail < xmit->head) {
> -		memcpy(&stm32port->tx_buf[0], &xmit->buf[xmit->tail], count);
> -	} else {
> -		size_t one = UART_XMIT_SIZE - xmit->tail;
> -		size_t two;
> -
> -		if (one > count)
> -			one = count;
> -		two = count - one;
> -
> -		memcpy(&stm32port->tx_buf[0], &xmit->buf[xmit->tail], one);
> -		if (two)
> -			memcpy(&stm32port->tx_buf[one], &xmit->buf[0], two);
> -	}
> +	count =	kfifo_out_peek(&tport->xmit_fifo, &stm32port->tx_buf[0],
> +			TX_BUF_L);
>  
>  	desc = dmaengine_prep_slave_single(stm32port->tx_ch,
>  					   stm32port->tx_dma_buf,
> @@ -792,14 +780,14 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
>  {
>  	struct stm32_port *stm32_port = to_stm32_port(port);
>  	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	u32 isr;
>  	int ret;
>  
>  	if (!stm32_port->hw_flow_control &&
>  	    port->rs485.flags & SER_RS485_ENABLED &&
>  	    (port->x_char ||
> -	     !(uart_circ_empty(xmit) || uart_tx_stopped(port)))) {
> +	     !(kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)))) {
>  		stm32_usart_tc_interrupt_disable(port);
>  		stm32_usart_rs485_rts_enable(port);
>  	}
> @@ -826,7 +814,7 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		stm32_usart_tx_interrupt_disable(port);
>  		return;
>  	}
> @@ -841,10 +829,10 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
>  	else
>  		stm32_usart_transmit_chars_pio(port);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		stm32_usart_tx_interrupt_disable(port);
>  		if (!stm32_port->hw_flow_control &&
>  		    port->rs485.flags & SER_RS485_ENABLED) {
> @@ -967,9 +955,9 @@ static void stm32_usart_stop_tx(struct uart_port *port)
>  /* There are probably characters waiting to be transmitted. */
>  static void stm32_usart_start_tx(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
> -	if (uart_circ_empty(xmit) && !port->x_char) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char) {
>  		stm32_usart_rs485_rts_disable(port);
>  		return;
>  	}
> diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
> index 8d612ab80680..7f60679fdde1 100644
> --- a/drivers/tty/serial/sunhv.c
> +++ b/drivers/tty/serial/sunhv.c
> @@ -39,10 +39,13 @@ static char *con_read_page;
>  
>  static int hung_up = 0;
>  
> -static void transmit_chars_putchar(struct uart_port *port, struct circ_buf *xmit)
> +static void transmit_chars_putchar(struct uart_port *port,
> +		struct tty_port *tport)
>  {
> -	while (!uart_circ_empty(xmit)) {
> -		long status = sun4v_con_putchar(xmit->buf[xmit->tail]);
> +	unsigned char ch;
> +
> +	while (kfifo_peek(&tport->xmit_fifo, &ch)) {
> +		long status = sun4v_con_putchar(ch);
>  
>  		if (status != HV_EOK)
>  			break;
> @@ -51,14 +54,16 @@ static void transmit_chars_putchar(struct uart_port *port, struct circ_buf *xmit
>  	}
>  }
>  
> -static void transmit_chars_write(struct uart_port *port, struct circ_buf *xmit)
> +static void transmit_chars_write(struct uart_port *port, struct tty_port *tport)
>  {
> -	while (!uart_circ_empty(xmit)) {
> -		unsigned long ra = __pa(xmit->buf + xmit->tail);
> -		unsigned long len, status, sent;
> +	while (!kfifo_is_empty(&tport->xmit_fifo)) {
> +		unsigned long len, ra, status, sent;
> +		unsigned char *tail;
> +
> +		len = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
> +				UART_XMIT_SIZE);
> +		ra = __pa(tail);
>  
> -		len = CIRC_CNT_TO_END(xmit->head, xmit->tail,
> -				      UART_XMIT_SIZE);
>  		status = sun4v_con_write(ra, len, &sent);
>  		if (status != HV_EOK)
>  			break;
> @@ -165,7 +170,7 @@ static int receive_chars_read(struct uart_port *port)
>  }
>  
>  struct sunhv_ops {
> -	void (*transmit_chars)(struct uart_port *port, struct circ_buf *xmit);
> +	void (*transmit_chars)(struct uart_port *port, struct tty_port *tport);
>  	int (*receive_chars)(struct uart_port *port);
>  };
>  
> @@ -196,18 +201,18 @@ static struct tty_port *receive_chars(struct uart_port *port)
>  
>  static void transmit_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit;
> +	struct tty_port *tport;
>  
>  	if (!port->state)
>  		return;
>  
> -	xmit = &port->state->xmit;
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +	tport = &port->state->port;
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
>  		return;
>  
> -	sunhv_ops->transmit_chars(port, xmit);
> +	sunhv_ops->transmit_chars(port, tport);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  }
>  
> diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
> index f5e29eb4a4ce..abf7c449308d 100644
> --- a/drivers/tty/serial/sunplus-uart.c
> +++ b/drivers/tty/serial/sunplus-uart.c
> @@ -200,7 +200,7 @@ static void sunplus_break_ctl(struct uart_port *port, int ctl)
>  
>  static void transmit_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
>  	if (port->x_char) {
>  		sp_uart_put_char(port, port->x_char);
> @@ -209,22 +209,24 @@ static void transmit_chars(struct uart_port *port)
>  		return;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		sunplus_stop_tx(port);
>  		return;
>  	}
>  
>  	do {
> -		sp_uart_put_char(port, xmit->buf[xmit->tail]);
> -		uart_xmit_advance(port, 1);
> -		if (uart_circ_empty(xmit))
> +		unsigned char ch;
> +
> +		if (!uart_fifo_get(port, &ch))
>  			break;
> +
> +		sp_uart_put_char(port, ch);
>  	} while (sunplus_tx_buf_not_full(port));
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		sunplus_stop_tx(port);
>  }
>  
> diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
> index 1ea2f33a07a7..1acbe2fba746 100644
> --- a/drivers/tty/serial/sunsab.c
> +++ b/drivers/tty/serial/sunsab.c
> @@ -232,7 +232,7 @@ static void sunsab_tx_idle(struct uart_sunsab_port *);
>  static void transmit_chars(struct uart_sunsab_port *up,
>  			   union sab82532_irq_status *stat)
>  {
> -	struct circ_buf *xmit = &up->port.state->xmit;
> +	struct tty_port *tport = &up->port.state->port;
>  	int i;
>  
>  	if (stat->sreg.isr1 & SAB82532_ISR1_ALLS) {
> @@ -252,7 +252,7 @@ static void transmit_chars(struct uart_sunsab_port *up,
>  	set_bit(SAB82532_XPR, &up->irqflags);
>  	sunsab_tx_idle(up);
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(&up->port)) {
>  		up->interrupt_mask1 |= SAB82532_IMR1_XPR;
>  		writeb(up->interrupt_mask1, &up->regs->w.imr1);
>  		return;
> @@ -265,21 +265,22 @@ static void transmit_chars(struct uart_sunsab_port *up,
>  	/* Stuff 32 bytes into Transmit FIFO. */
>  	clear_bit(SAB82532_XPR, &up->irqflags);
>  	for (i = 0; i < up->port.fifosize; i++) {
> -		writeb(xmit->buf[xmit->tail],
> -		       &up->regs->w.xfifo[i]);
> -		uart_xmit_advance(&up->port, 1);
> -		if (uart_circ_empty(xmit))
> +		unsigned char ch;
> +
> +		if (!uart_fifo_get(&up->port, &ch))
>  			break;
> +
> +		writeb(ch, &up->regs->w.xfifo[i]);
>  	}
>  
>  	/* Issue a Transmit Frame command. */
>  	sunsab_cec_wait(up);
>  	writeb(SAB82532_CMDR_XF, &up->regs->w.cmdr);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&up->port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		sunsab_stop_tx(&up->port);
>  }
>  
> @@ -435,10 +436,10 @@ static void sunsab_start_tx(struct uart_port *port)
>  {
>  	struct uart_sunsab_port *up =
>  		container_of(port, struct uart_sunsab_port, port);
> -	struct circ_buf *xmit = &up->port.state->xmit;
> +	struct tty_port *tport = &up->port.state->port;
>  	int i;
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
>  		return;
>  
>  	up->interrupt_mask1 &= ~(SAB82532_IMR1_ALLS|SAB82532_IMR1_XPR);
> @@ -451,11 +452,12 @@ static void sunsab_start_tx(struct uart_port *port)
>  	clear_bit(SAB82532_XPR, &up->irqflags);
>  
>  	for (i = 0; i < up->port.fifosize; i++) {
> -		writeb(xmit->buf[xmit->tail],
> -		       &up->regs->w.xfifo[i]);
> -		uart_xmit_advance(&up->port, 1);
> -		if (uart_circ_empty(xmit))
> +		unsigned char ch;
> +
> +		if (!uart_fifo_get(&up->port, &ch))
>  			break;
> +
> +		writeb(ch, &up->regs->w.xfifo[i]);
>  	}
>  
>  	/* Issue a Transmit Frame command.  */
> diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> index c8b65f4b2710..67a5fc70bb4b 100644
> --- a/drivers/tty/serial/sunsu.c
> +++ b/drivers/tty/serial/sunsu.c
> @@ -396,7 +396,8 @@ receive_chars(struct uart_sunsu_port *up, unsigned char *status)
>  
>  static void transmit_chars(struct uart_sunsu_port *up)
>  {
> -	struct circ_buf *xmit = &up->port.state->xmit;
> +	struct tty_port *tport = &up->port.state->port;
> +	unsigned char ch;
>  	int count;
>  
>  	if (up->port.x_char) {
> @@ -409,23 +410,23 @@ static void transmit_chars(struct uart_sunsu_port *up)
>  		sunsu_stop_tx(&up->port);
>  		return;
>  	}
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		__stop_tx(up);
>  		return;
>  	}
>  
>  	count = up->port.fifosize;
>  	do {
> -		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> -		uart_xmit_advance(&up->port, 1);
> -		if (uart_circ_empty(xmit))
> +		if (!uart_fifo_get(&up->port, &ch))
>  			break;
> +
> +		serial_out(up, UART_TX, ch);
>  	} while (--count > 0);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&up->port);
>  
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		__stop_tx(up);
>  }
>  
> diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
> index c99289c6c8f8..71758ad4241c 100644
> --- a/drivers/tty/serial/sunzilog.c
> +++ b/drivers/tty/serial/sunzilog.c
> @@ -453,7 +453,8 @@ static void sunzilog_status_handle(struct uart_sunzilog_port *up,
>  static void sunzilog_transmit_chars(struct uart_sunzilog_port *up,
>  				    struct zilog_channel __iomem *channel)
>  {
> -	struct circ_buf *xmit;
> +	struct tty_port *tport;
> +	unsigned char ch;
>  
>  	if (ZS_IS_CONS(up)) {
>  		unsigned char status = readb(&channel->control);
> @@ -496,21 +497,20 @@ static void sunzilog_transmit_chars(struct uart_sunzilog_port *up,
>  
>  	if (up->port.state == NULL)
>  		goto ack_tx_int;
> -	xmit = &up->port.state->xmit;
> -	if (uart_circ_empty(xmit))
> -		goto ack_tx_int;
> +	tport = &up->port.state->port;
>  
>  	if (uart_tx_stopped(&up->port))
>  		goto ack_tx_int;
>  
> +	if (!uart_fifo_get(&up->port, &ch))
> +		goto ack_tx_int;
> +
>  	up->flags |= SUNZILOG_FLAG_TX_ACTIVE;
> -	writeb(xmit->buf[xmit->tail], &channel->data);
> +	writeb(ch, &channel->data);
>  	ZSDELAY();
>  	ZS_WSYNC(channel);
>  
> -	uart_xmit_advance(&up->port, 1);
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&up->port);
>  
>  	return;
> @@ -700,17 +700,16 @@ static void sunzilog_start_tx(struct uart_port *port)
>  		port->icount.tx++;
>  		port->x_char = 0;
>  	} else {
> -		struct circ_buf *xmit = &port->state->xmit;
> +		struct tty_port *tport = &port->state->port;
> +		unsigned char ch;
>  
> -		if (uart_circ_empty(xmit))
> +		if (!uart_fifo_get(&up->port, &ch))
>  			return;
> -		writeb(xmit->buf[xmit->tail], &channel->data);
> +		writeb(ch, &channel->data);
>  		ZSDELAY();
>  		ZS_WSYNC(channel);
>  
> -		uart_xmit_advance(port, 1);
> -
> -		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  			uart_write_wakeup(&up->port);
>  	}
>  }
> diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
> index d9c78320eb02..21ca5fcadf49 100644
> --- a/drivers/tty/serial/tegra-tcu.c
> +++ b/drivers/tty/serial/tegra-tcu.c
> @@ -91,15 +91,17 @@ static void tegra_tcu_write(struct tegra_tcu *tcu, const char *s,
>  static void tegra_tcu_uart_start_tx(struct uart_port *port)
>  {
>  	struct tegra_tcu *tcu = port->private_data;
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned long count;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned char *tail;
> +	unsigned int count;
>  
>  	for (;;) {
> -		count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +		count = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
> +				UART_XMIT_SIZE);
>  		if (!count)
>  			break;
>  
> -		tegra_tcu_write(tcu, &xmit->buf[xmit->tail], count);
> +		tegra_tcu_write(tcu, tail, count);
>  		uart_xmit_advance(port, count);
>  	}
>  
> diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
> index 4bc89a9b380a..43fa0938b5e3 100644
> --- a/drivers/tty/serial/timbuart.c
> +++ b/drivers/tty/serial/timbuart.c
> @@ -95,14 +95,11 @@ static void timbuart_rx_chars(struct uart_port *port)
>  
>  static void timbuart_tx_chars(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> +	unsigned char ch;
>  
>  	while (!(ioread32(port->membase + TIMBUART_ISR) & TXBF) &&
> -		!uart_circ_empty(xmit)) {
> -		iowrite8(xmit->buf[xmit->tail],
> -			port->membase + TIMBUART_TXFIFO);
> -		uart_xmit_advance(port, 1);
> -	}
> +			uart_fifo_get(port, &ch))
> +		iowrite8(ch, port->membase + TIMBUART_TXFIFO);
>  
>  	dev_dbg(port->dev,
>  		"%s - total written %d bytes, CTL: %x, RTS: %x, baud: %x\n",
> @@ -117,9 +114,9 @@ static void timbuart_handle_tx_port(struct uart_port *port, u32 isr, u32 *ier)
>  {
>  	struct timbuart_port *uart =
>  		container_of(port, struct timbuart_port, port);
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
>  		return;
>  
>  	if (port->x_char)
> @@ -130,7 +127,7 @@ static void timbuart_handle_tx_port(struct uart_port *port, u32 isr, u32 *ier)
>  		/* clear all TX interrupts */
>  		iowrite32(TXFLAGS, port->membase + TIMBUART_ISR);
>  
> -		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  			uart_write_wakeup(port);
>  	} else
>  		/* Re-enable any tx interrupt */
> @@ -141,7 +138,7 @@ static void timbuart_handle_tx_port(struct uart_port *port, u32 isr, u32 *ier)
>  	 * we wake up the upper layer later when we got the interrupt
>  	 * to give it some time to go out...
>  	 */
> -	if (!uart_circ_empty(xmit))
> +	if (!kfifo_is_empty(&tport->xmit_fifo))
>  		*ier |= TXBAE;
>  
>  	dev_dbg(port->dev, "%s - leaving\n", __func__);
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 10ba41b7be99..68357ac8ffe3 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -189,7 +189,8 @@ static int ulite_receive(struct uart_port *port, int stat)
>  
>  static int ulite_transmit(struct uart_port *port, int stat)
>  {
> -	struct circ_buf *xmit  = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
> +	unsigned char ch;
>  
>  	if (stat & ULITE_STATUS_TXFULL)
>  		return 0;
> @@ -201,14 +202,16 @@ static int ulite_transmit(struct uart_port *port, int stat)
>  		return 1;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +	if (uart_tx_stopped(port))
> +		return 0;
> +
> +	if (!uart_fifo_get(port, &ch))
>  		return 0;
>  
> -	uart_out32(xmit->buf[xmit->tail], ULITE_TX, port);
> -	uart_xmit_advance(port, 1);
> +	uart_out32(ch, ULITE_TX, port);
>  
>  	/* wake up */
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	return 1;
> diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
> index 397b95dff7ed..53bb8c5ef499 100644
> --- a/drivers/tty/serial/ucc_uart.c
> +++ b/drivers/tty/serial/ucc_uart.c
> @@ -334,7 +334,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
>  	unsigned char *p;
>  	unsigned int count;
>  	struct uart_port *port = &qe_port->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  
>  	/* Handle xon/xoff */
>  	if (port->x_char) {
> @@ -358,7 +358,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
>  		return 1;
>  	}
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		qe_uart_stop_tx(port);
>  		return 0;
>  	}
> @@ -366,16 +366,10 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
>  	/* Pick next descriptor and fill from buffer */
>  	bdp = qe_port->tx_cur;
>  
> -	while (!(ioread16be(&bdp->status) & BD_SC_READY) && !uart_circ_empty(xmit)) {
> -		count = 0;
> +	while (!(ioread16be(&bdp->status) & BD_SC_READY) &&
> +	       !kfifo_is_empty(&tport->xmit_fifo)) {
>  		p = qe2cpu_addr(ioread32be(&bdp->buf), qe_port);
> -		while (count < qe_port->tx_fifosize) {
> -			*p++ = xmit->buf[xmit->tail];
> -			uart_xmit_advance(port, 1);
> -			count++;
> -			if (uart_circ_empty(xmit))
> -				break;
> -		}
> +		count =	uart_fifo_out(port, p, qe_port->tx_fifosize);
>  
>  		iowrite16be(count, &bdp->length);
>  		qe_setbits_be16(&bdp->status, BD_SC_READY);
> @@ -388,10 +382,10 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
>  	}
>  	qe_port->tx_cur = bdp;
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (uart_circ_empty(xmit)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo)) {
>  		/* The kernel buffer is empty, so turn off TX interrupts.  We
>  		   don't need to be told when the QE is finished transmitting
>  		   the data. */
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 5f48ec37cb25..de3487206bcb 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -425,32 +425,32 @@ static void cdns_uart_handle_tx(void *dev_id)
>  {
>  	struct uart_port *port = (struct uart_port *)dev_id;
>  	struct cdns_uart *cdns_uart = port->private_data;
> -	struct circ_buf *xmit = &port->state->xmit;
> +	struct tty_port *tport = &port->state->port;
>  	unsigned int numbytes;
> +	unsigned char ch;
>  
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
>  		/* Disable the TX Empty interrupt */
>  		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
>  		return;
>  	}
>  
>  	numbytes = port->fifosize;
> -	while (numbytes && !uart_circ_empty(xmit) &&
> -	       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
> -
> -		writel(xmit->buf[xmit->tail], port->membase + CDNS_UART_FIFO);
> -		uart_xmit_advance(port, 1);
> +	while (numbytes &&
> +	       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL) &&
> +	       uart_fifo_get(port, &ch)) {
> +		writel(ch, port->membase + CDNS_UART_FIFO);
>  		numbytes--;
>  	}
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
>  	/* Enable the TX Empty interrupt */
>  	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
>  
>  	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
> -	    (uart_circ_empty(xmit) || uart_tx_stopped(port))) {
> +	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
>  		cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
>  		hrtimer_start(&cdns_uart->tx_timer,
>  			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
> @@ -723,7 +723,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
>  	status |= CDNS_UART_CR_TX_EN;
>  	writel(status, port->membase + CDNS_UART_CR);
>  
> -	if (uart_circ_empty(&port->state->xmit))
> +	if (kfifo_is_empty(&port->state->port.xmit_fifo))
>  		return;
>  
>  	/* Clear the TX Empty interrupt */
> diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
> index 65ca4da6e368..79ea7108a0f3 100644
> --- a/drivers/tty/serial/zs.c
> +++ b/drivers/tty/serial/zs.c
> @@ -606,7 +606,8 @@ static void zs_receive_chars(struct zs_port *zport)
>  
>  static void zs_raw_transmit_chars(struct zs_port *zport)
>  {
> -	struct circ_buf *xmit = &zport->port.state->xmit;
> +	struct tty_port *tport = &zport->port.state->port;
> +	unsigned char ch;
>  
>  	/* XON/XOFF chars.  */
>  	if (zport->port.x_char) {
> @@ -617,20 +618,20 @@ static void zs_raw_transmit_chars(struct zs_port *zport)
>  	}
>  
>  	/* If nothing to do or stopped or hardware stopped.  */
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(&zport->port)) {
> +	if (uart_tx_stopped(&zport->port) ||
> +			!uart_fifo_get(&zport->port, &ch)) {
>  		zs_raw_stop_tx(zport);
>  		return;
>  	}
>  
>  	/* Send char.  */
> -	write_zsdata(zport, xmit->buf[xmit->tail]);
> -	uart_xmit_advance(&zport->port, 1);
> +	write_zsdata(zport, ch);
>  
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(&zport->port);
>  
>  	/* Are we are done?  */
> -	if (uart_circ_empty(xmit))
> +	if (kfifo_is_empty(&tport->xmit_fifo))
>  		zs_raw_stop_tx(zport);
>  }
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 0a0f6e21d40e..8cb65f50e830 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -11,7 +11,6 @@
>  #include <linux/compiler.h>
>  #include <linux/console.h>
>  #include <linux/interrupt.h>
> -#include <linux/circ_buf.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched.h>
>  #include <linux/tty.h>
> @@ -699,7 +698,6 @@ struct uart_state {
>  	struct tty_port		port;
>  
>  	enum uart_pm_state	pm_state;
> -	struct circ_buf		xmit;
>  
>  	atomic_t		refcount;
>  	wait_queue_head_t	remove_wait;
> @@ -723,12 +721,35 @@ struct uart_state {
>   */
>  static inline void uart_xmit_advance(struct uart_port *up, unsigned int chars)
>  {
> -	struct circ_buf *xmit = &up->state->xmit;
> +	struct tty_port *tport = &up->state->port;
>  
> -	xmit->tail = (xmit->tail + chars) & (UART_XMIT_SIZE - 1);
> +	kfifo_skip_count(&tport->xmit_fifo, chars);
>  	up->icount.tx += chars;
>  }
>  
> +static inline unsigned int uart_fifo_out(struct uart_port *up,
> +		unsigned char *buf, unsigned int chars)
> +{
> +	struct tty_port *tport = &up->state->port;
> +
> +	chars = kfifo_out(&tport->xmit_fifo, buf, chars);
> +	up->icount.tx += chars;
> +
> +	return chars;
> +}
> +
> +static inline unsigned int uart_fifo_get(struct uart_port *up,
> +		unsigned char *ch)
> +{
> +	struct tty_port *tport = &up->state->port;
> +	unsigned int chars;
> +
> +	chars = kfifo_get(&tport->xmit_fifo, ch);
> +	up->icount.tx += chars;
> +
> +	return chars;
> +}
> +
>  struct module;
>  struct tty_driver;
>  
> @@ -764,7 +785,7 @@ enum UART_TX_FLAGS {
>  		       for_test, for_post)				      \
>  ({									      \
>  	struct uart_port *__port = (uport);				      \
> -	struct circ_buf *xmit = &__port->state->xmit;			      \
> +	struct tty_port *__tport = &__port->state->port;		      \
>  	unsigned int pending;						      \
>  									      \
>  	for (; (for_test) && (tx_ready); (for_post), __port->icount.tx++) {   \
> @@ -775,17 +796,18 @@ enum UART_TX_FLAGS {
>  			continue;					      \
>  		}							      \
>  									      \
> -		if (uart_circ_empty(xmit) || uart_tx_stopped(__port))	      \
> +		if (uart_tx_stopped(__port))				      \
> +			break;						      \
> +									      \
> +		if (!kfifo_get(&__tport->xmit_fifo, &(ch)))		      \
>  			break;						      \
>  									      \
> -		(ch) = xmit->buf[xmit->tail];				      \
>  		(put_char);						      \
> -		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;		      \
>  	}								      \
>  									      \
>  	(tx_done);							      \
>  									      \
> -	pending = uart_circ_chars_pending(xmit);			      \
> +	pending = kfifo_len(&__tport->xmit_fifo);			      \
>  	if (pending < WAKEUP_CHARS) {					      \
>  		uart_write_wakeup(__port);				      \
>  									      \
> @@ -974,15 +996,6 @@ bool uart_match_port(const struct uart_port *port1,
>  int uart_suspend_port(struct uart_driver *reg, struct uart_port *port);
>  int uart_resume_port(struct uart_driver *reg, struct uart_port *port);
>  
> -#define uart_circ_empty(circ)		((circ)->head == (circ)->tail)
> -#define uart_circ_clear(circ)		((circ)->head = (circ)->tail = 0)
> -
> -#define uart_circ_chars_pending(circ)	\
> -	(CIRC_CNT((circ)->head, (circ)->tail, UART_XMIT_SIZE))
> -
> -#define uart_circ_chars_free(circ)	\
> -	(CIRC_SPACE((circ)->head, (circ)->tail, UART_XMIT_SIZE))
> -
>  static inline int uart_tx_stopped(struct uart_port *port)
>  {
>  	struct tty_struct *tty = port->state->port.tty;
> -- 
> 2.44.0
> 

