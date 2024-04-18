Return-Path: <linux-kernel+bounces-149518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DF8A924F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F37B21BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F554BED;
	Thu, 18 Apr 2024 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrRCZueR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E98EDF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417366; cv=fail; b=onFclOQnWFCc66u2zz8Tx8EROzEKx9QDN+7z/UvtsrsBOaVSVj7jHxUolo2UzIw0+kmH9v1qUT7/USMivL8SGPLbyUdqIrfGJ1Z05xuvabx/+uGMFRnWQno7iA6yqasl+rtK4nQ5LBIZoZmiZ7AlQlc+AHuRJN1wf9isKI8+zw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417366; c=relaxed/simple;
	bh=aZTYhjjQEhIr4ntmbHQ1x1KJokNVF4jsNgLm5GjFCfM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pe739cflFrnAS1snR9YgRvR5X17FQjM2vSJ/OgRDW4duikgkAHIhtyZmGWdDYm9KG7t8l7wBNTbK3QyJnaO8vcTlhYk4ZSMFnDPMkJuhVfNcIkmbkEsFD2OHfxkQQ5XPejV7AWOTTA9y+B912sZ+sEwXURq7ZUs71VAuJh4FBbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrRCZueR; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713417364; x=1744953364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aZTYhjjQEhIr4ntmbHQ1x1KJokNVF4jsNgLm5GjFCfM=;
  b=LrRCZueR/VjxEm/rO3eRdBP4F0TmepEOBZIA+smVwhDmpsAQqP01rRNj
   LhLvbem6o74+FL0rQrzpy20TBO/XT6DVBG79kwXQWmKHu2pRczd4cG99C
   oVCt7jre44sSfDAKY5pFyH5mgxsTmhD0QRctv17qdT8qrvweJPNbSq2O6
   qxL84rpsWbVhFjGScwX69TSUMGoj7SKad7MbSe4OBIqYZNMQQ/Zyl8GmY
   9gGTSAUGY/pw530k8Czr6GSN1jSUenrF/3Te6igjex1w9xqtkpOIC8k9M
   WH889ziKwyucBWCyjFpQnfnI+4wuxd8IWjAgBvKwexWiYq4aac+S4K0Fr
   Q==;
X-CSE-ConnectionGUID: j0GP1pt7QE2vYk3pIC9j5w==
X-CSE-MsgGUID: TkqMqItWSHqFuQrcaRduZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9490516"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="9490516"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:16:03 -0700
X-CSE-ConnectionGUID: QzwS1nU4SGaWM8r/uVhJIQ==
X-CSE-MsgGUID: bL7hC+vkQMyHQIeC94MKEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27517126"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:16:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:16:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:16:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:16:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPdEUGwkpmJkQgTzKJ3xa41yPp/9KQdYkyk6AUC+5/CDodMy9n8pS3wKA7qkzcHfymmkMTkQ7xEoIod0CrTXucDCfb02NV2vtXEgv0a8UeGGr97IKvCSEzbre1dYmoCaPQj0AvJCtBikKkTchUujRcH94433n40WF9q/WUfoDz8mOOFh0Qrearkm+mzUdmol321T9ATe63SD9NJmlpl54zuadyeTHUAOGmziKcHcfcKoBJqyvfdoSpGB946zvQGpWi+6OQtBaYggeFaVmD0OirLdRJ29I/RcfSyJLR2Js8cyGpG+IdwXV4qpuuxMNaGwHw/8cOlc01MaPCNbSq8gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPDWG2egMkAAYQRL/t7Cdf+VwdqBjyw1qSE/84KK/TA=;
 b=HoV4FPAs1v4MB2v3A/ghUXePqjvADwMWdiSRUNEk6gga4fc8FQSPmfKwhpNKN9ibDWZtRSJN+gnxnHQXhP94FI43RUn7pGvZbEBB/oFFPel1UGXaF1TAy1hnKtXuUNkLLisQWT+IqlWXO6PWuZdJtrJMk4IIh6e8jP65R9B5h8Kd5Zre4rImFBUgeeOqLDlttnqnwAJI3MkNCFeuhO8x/58f/+rlTBcay0NrNe6Wc91gsq/zw95toL30d0ODAU4rMexPSrh3kzd854czgelodMzt9KXEaBUuJUr/rPqdizxuIsHg4Tgc/iGiqmqt8HHVgkt0hUk1QSocqzlmpbX2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 05:16:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 05:16:00 +0000
Message-ID: <a32acb5a-a6e1-4de1-841e-9a1372d624a5@intel.com>
Date: Wed, 17 Apr 2024 22:15:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/31] x86/resctrl: Move resctrl types to a separate
 header
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-9-james.morse@arm.com>
 <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>
 <ZhlegNN3zZ4Q1lk6@e133380.arm.com>
 <fe8e56bb-55bf-4130-876f-3047da182da1@intel.com>
 <Zh6k9uagoaj9oTl6@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zh6k9uagoaj9oTl6@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6404d6-3b56-4fe2-ed3d-08dc5f66a2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyJgI7yLRQKjqiKtc+iC2mzKhlnziv6qmsEzbDlTEuwd384Advyzqk80l2keh4YglMifGlWz3ywi4sA/RZhSlWZyVguvQ5KCch1gzwXcA9ntyAtdDA1DJbxx4VAXa0AExfqTO1N4y8GucYZofw2Cvrjd8ZvmUNksVvOhCc0jvNFqfjFHQ8ItZoocISzKruBLosZiJSkJZ5APc3qboj4IflcCTWf4wVnhbjewMVvDGcKhbDlBqhHzRR7jDCa9MP+IDQhq+pwScz29nnQqZP9KITrIs9fWGo5OaXjCJUXUM5PJjFuH0WUgIM1BxA9mD1RY++XYfcSlS1tEaHPo41v7rZsB6Xy/55Dw5KgBQMancl9fcz/bktXoNzkQh2N8sMg0pFpoXridaP0c8ye1UmqK1ZyCJJ8HiItG9qiIInfDp+HX6JTiGrsCcLIfPsufHWxLZOxxOLNvkTvstOlhqyQD0z7eVu+YOTRjwZeGGABvAgwfQ2UFIOiIvUKYrMycOSy+rMa+CIMZkcbDhPhAm7VLfLnZHnndQvY+xBXSxSS9jvWR/AD1+PNGtLIVzQTllUi18X2KTkUQcBk1+WqHq/BV5F01utIBtnpK7DiKud8u9y8+V8lmPsGdT5gocCdseLCmzSQ2uZyTHc71lP8TaSzyzahbwlNgAHaHqgGnBFOErQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?USsxWGxpc0wvc0xwc0tNVy9wWjJwMHYreUllb1hqMjUxZGJSWHVFYXdpL2hT?=
 =?utf-8?B?eDYwQ0FaQWRiV2MyL3hEd1NuZzQzL1RQWVQvL2g5WEVmSCtUdVc4aUFXalVF?=
 =?utf-8?B?NnBnNFNlYlRUT2hqQ0Y3QVhMbFgzTkpWQ1BnUlJ6Z205N01jdXF0TUc3V1JB?=
 =?utf-8?B?QWdsZUNKTmZPbTZDbGZqNXpsOCtJWDUvb3kvZFRkQ211cDJpWW1PNXg3NTlZ?=
 =?utf-8?B?NjBMT0FybGVuL052US94SCtLTWVwNlhwVVhoTURUeTRTUEUwQlhselY0SW5k?=
 =?utf-8?B?YUg4Ykdremhzd015MFE0NzhCMHFqeFF1TVdHdVRWaStCVlVTL3VVUERTSUFX?=
 =?utf-8?B?YjNjZzM5aUhHNDUyZk56S1doSktCTThtdGZPODlXdWZmVEYweHdMWUZ6TGx6?=
 =?utf-8?B?ZVY2VWEyUEhTOWJZanNXMnAxMWpIek4xSlZWc25kM3VBMGx2RnFZeUJrNlNa?=
 =?utf-8?B?dnowNmREQ3FzaXVVd1c4ZmFZOGxPZ1o2eDhJazRINEpWQVVsdXplYzRnbEFB?=
 =?utf-8?B?UWVGVUZQRVJZVFVKL3VuaFZkTW4xVlgyOVB5Und0VTREVVVIMlVoTlkzUk5y?=
 =?utf-8?B?cjRiN3lwVHR4cUt1ekxwUDliUHYwckdOQ25ERDBCWDFOV2M5Y09kWEdmTVRK?=
 =?utf-8?B?SXRPTmdhY2RKUklkS3dNbndrOUhXN2R6cE1JUzRlZm9YZmxWcUNDKzJ3YmRv?=
 =?utf-8?B?ZnE2WHZWR0lvdTE3M0cwZlFsbndHOWhXMnRPaTZWdzk4Q083Q3F6M3FObEVE?=
 =?utf-8?B?Lzh1RTVETlkvK2lVZVFYWW1iMEFjMThYQk1qZWdZMFI5UkttOXdoUU5mYjdP?=
 =?utf-8?B?ekpTWHRxMVF2VURvRFVDdVVqYS9OUmptTkFXWUdtWnhBZ1VLS3hRUHNsSG0w?=
 =?utf-8?B?K0xLOGRkSExMcGZhdHovOVVnTWRDV2wreTM1bkJ3VFNJbFAzU3RzN2svbEJW?=
 =?utf-8?B?bVZMM0xWbDhTS2M5NlRPczY4VkJaWU55a2NwalZhTnNHWjhqSHFrQ1duc2Z0?=
 =?utf-8?B?Sy8rSVhXaGdTMVN2bEpwRmZnaWhlTU9vYlYrVlk5bkYyMk4xc0hJUHRUUmpw?=
 =?utf-8?B?L3Yvc2RaMFNTMFNIQlBHSGxIdkcvZkxOejdiK1JYNXBlY2dHYTBUUGNkUHFM?=
 =?utf-8?B?ZVVsRmdURVN3aTJML3FZSyszakFVU0liYkxxT3U3amFId090NEFqQk5VdEk2?=
 =?utf-8?B?WHFFaDRkSXBNNGdScWtsTTl6bEVVMXQ1L0UwYzNEYkxhdWJWcmNpNEYxKy91?=
 =?utf-8?B?MlZsZUhFRVNocWFmZ3JrVExHY2VxSzROWXdqeFJ3RWpualdmVEFUSmI0V3U5?=
 =?utf-8?B?YkgweDRTSW5heFJwMkpiM3Y3N3lDbGdEQlFiUlBvd3g4d3ZPYkd1U25mOVVq?=
 =?utf-8?B?QnQ5MTM3RGVNZXZOTXFUdU4yUkVPdjAvczg1VjBDdnFaeGtnZ2I3dy9CTEhK?=
 =?utf-8?B?V1VLSDhvUzJpQmhNWDJyYUFFUmlmRXp3RTJxbElLSHltbnRJZ0Jwd2hKbzdn?=
 =?utf-8?B?U2orc08rQU05MThzckR4S2E3emM1SWQ5cDZCeFk3REUyalBNaUFFd3ZGcnhT?=
 =?utf-8?B?Rml3MEdvNWNUbTNmRFNHWFk2Zy83MmhpeFhnYXdxWDRRZmxzQ0Z4cjlWcDNx?=
 =?utf-8?B?d2UwTnVuQmdCemlxbzlDbER3UmpzeUtUYzNQT3Q5aWNxZCtJNy9SNTQwMVZD?=
 =?utf-8?B?OU0yUzRKR0tsTSsza2ZaN3N2NWw0VjBsWnduV1Y0STB6dGdRcU91dUJ2K05q?=
 =?utf-8?B?T3A5N1NaSDFvSGdvUGlIcGFrc2VuOUpBVTJEV3M5UmtTd3d5QjlIam1HbmJY?=
 =?utf-8?B?WENqWkJzbUE0MExsak1FMlp2bElQbytWQnZTbGEyOWErRndzZEwvajEzanIy?=
 =?utf-8?B?RkEvcm1KbDJUUFZCaWx1emd0M21Ha2lDUWdVdERWYk1Bc0xMRXZnc0RFUTU2?=
 =?utf-8?B?bTFRblRGWDRvbDRJWEdLa1ExcGdQSnNoMGt6Ny9QQms3Y05vN3BsSUdodUNR?=
 =?utf-8?B?VHFuYjZncXd0b3FSa3pzVXNIOFZTWkdWT2dvam9EWHpqZFF2VXVzbTdLZXZP?=
 =?utf-8?B?QjYyMnBwQjIyZnpmeWhmdVE1Q3E5b0VNMVNiY0JXRVd0S2JnOFBHQStLcFp4?=
 =?utf-8?B?N1FrNy9MK3hGb2hCYkNXZU9SZ2dvcENGUjh5THJBb2gwT1RZcllwMXpLVm5E?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6404d6-3b56-4fe2-ed3d-08dc5f66a2d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:16:00.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEKHezc2/VCNMUuYmfN45oIPGbPOJ6WF7y7OJIPYwhdgBgN+1aj/7aF/aG1eP/IGZ0q0UL4WWTJIcGMO9XpzHl/1+Xyh4lsVFB7E8c511hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com

Hi Dave,

On 4/16/2024 9:19 AM, Dave Martin wrote:
> On Mon, Apr 15, 2024 at 11:03:05AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 4/12/2024 9:17 AM, Dave Martin wrote:
>>> On Mon, Apr 08, 2024 at 08:18:00PM -0700, Reinette Chatre wrote:
>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>>> To avoid sticky problems in the mpam glue code, move the resctrl
>>>>> enums into a separate header.
>>>>
>>>> Could you please elaborate so that "sticky problems in the mpam glue code" is
>>>> specific about what problems are avoided?
>>>
>>> Maybe just delete the the sticky clause, and leave:
>>>
>>> 	Move the resctrl enums into a separate header.
>>>
>>> ...since the next paragraph explains the rationale?
>>
>> In the x86 area changelogs start with a context paragraph to
>> provide reader with foundation to parse the subsequent problem and
>> solution statements (that are also expected to be in separate
>> paragraphs in that order). 
> 
> Acknowledged; I was hoping to avoid a rewrite, but ...
>>
>>>>> This lets the arch code declare prototypes that use these enums without
>>>>> creating a loop via asm<->linux resctrl.h The same logic applies to the
>>>>> monitor-configuration defines, move these too.
> 
> [...]
> 
> OK, how about the following:
> 
> --8<--
> 
> When resctrl is fully factored into core and per-arch code, each arch
> will need to use some resctrl common definitions in order to define its
> own specialisations and helpers.  Following conventional practice,

specializations

> it would be desirable to put the dependent arch definitions in an
> <asm/resctrl.h> header that is included by the common <linux/resctrl.h>
> header.  However, this can make it awkward to avoid a circular
> dependency between <linux/resctrl.h> and the arch header.
> 
> To avoid solving this issue via conditional inclusion tricks that are
> likely to be tricky to maintain, move the affected common types and

To help with motivation please be specific (somebody may interpret above
that it may not be tricky to maintain). So just ... "that are difficult
to maintain ...".

> constants into a new header that does not need to depend on
> <linux/resctrl.h> or on the arch headers.
> 
> The same logic applies to the monitor-configuration defines, move
> these too.
> 
> -->8--
> 

This explains the motivation for this file well, but its contents
is not obvious to me and after reading [1] I am more weary of including
code before use. Not all of these definitions are needed
by the end of this series so there needs to be a good motivation for
making things global without any visible user.

I do understand that in the next stage of this work we may need to deal
with potentially three subsystems when making changes and there is thus 
a strong motivation for laying a good foundation now. I do not think this
should be an excuse to not be diligent in ensuring the changes are
required.

> Then:
> 
>>>>>
>>>>> The maintainers entry for these headers was missed when resctrl.h
>>>>> was created. Add a wildcard entry to match both resctrl.h and
>>>>> resctrl_types.h.
>>>>>
>>>>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> The last paragraph looks like it can stand as-is.
> 
> Does that look OK?

Yes.

Reinette

[1] https://lore.kernel.org/lkml/ZhecyLQsGZ9Iv8wU@gmail.com/

