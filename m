Return-Path: <linux-kernel+bounces-136195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE789D0FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF221C242B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319C54BCA;
	Tue,  9 Apr 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/DM/2va"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E541054794
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632854; cv=fail; b=SxN2o2vsD7HqzPVb0g0OWcU0hGp3IIkEN5yQgd9TR82WYj/79eknihkirFXiHaL571m8djkzV0/s+3itO2Q4rcQY0cmbwojxZwnviodj/kLHvTab8DWUnJCzM25cGiEKEpi7xfHM7VKKST36bHqgMUFGk3o6jVWzzndXIbBmYWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632854; c=relaxed/simple;
	bh=49HEM0OSc62IYide0IXhWsy3kz2uu12jBNdWkn4bqoc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ftfbytyPMa19snyo4hdhpfJwWIeGL/ZpiXZOAcCtJa3dVrYggrxJ4gAEtkBTGjFcgy2EdBQF2XRBWels3wgGu+IWf9VGsw2KW6A9mdfvd9DWrpkpP4axb5BMLvp6X7HGhqBWop7KviQW8LZlT4F9Gvf53VjnuHtYz5WWspQvzAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/DM/2va; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632853; x=1744168853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=49HEM0OSc62IYide0IXhWsy3kz2uu12jBNdWkn4bqoc=;
  b=O/DM/2vaSKvToKy59gc4xj+GWQaq8FV49NzxTe/8otzSvLQUvyczqk9+
   PzCrYCydsAqe4mlcNrFTLEZX74tA46tVdQqTX1Ohud+qqvJbOIleIAEcd
   FIQzfAh26Xgp4hMxgO8uUmSTepvdMUajNqXSWuYqudjEweLkWKhAYgMGQ
   UJJS2AGrh1Bapz55MWWPYLRAX7uaZWN7ig6og+IUJwTdGvXlc1J9+WGEy
   m2nptssCNMuWuS54vnexdUAfNKNi1bEc4p1+jZulhPRNoQBgERqcZlGJa
   oJN3zs0qgJEbi7Iawg28Vc6mS49jpcBhfVDXrVbSlOKtzz0qKidSe0f6O
   w==;
X-CSE-ConnectionGUID: Ebux5EyzSoil+F9Iw6tQuA==
X-CSE-MsgGUID: iIa6I/YHQ36QyhIKbh3wOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="33340792"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="33340792"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:20:52 -0700
X-CSE-ConnectionGUID: tJX6Nfq3RZq0NK4zJPMtPQ==
X-CSE-MsgGUID: BC3ErTCbTy66h5ObkdIbIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20141322"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:20:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:20:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:20:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:20:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLSua4XWVTP7zlzp98Xmr9eA7Bkwqr43vbWhsm9z+5+JTM/fDtveyHuU3QbwOGJWaIfnrtKX5v7Hw82D2C1SseY64dgae4wNYou0ea+z95NhTVdSeJZSInTz5HmkcJxeInBYC7MMoxJITABc+Hv4mq4Q2e7sJlha0iAb03VfJZQiYeUWngrOe9YytjBCH7KK3UGrOklfnSea46FEDhTvwoifObhCWZdPH+IxSJq9XDWm4+P7sMuOnlXePuNARTOzJBHKJqSaZfVUzGNjS4bSRdrxqh9rlEPHT/UEgQ2OLZ/QbHZI3gcfuxRJdv53FkkfB+DDodoLAMITpcZ6o/KiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxBnte2qKT0XRzCW7+vc701Kp2xQMGsWctzFcDo2j4Y=;
 b=XbviXs4GoZkR182oN6bpz4F/sZQMpd1zmUAO197B5QMNBbW2JbmNGpv0PgEqCglpbNooCSoFTA36xvGKlrOWcL7LAlGLgcop47E9nwZ+z+n9smWptRvQsWsNnS7BEF9ZXRR3fYZXJxEi6X/WvZHrxk2eZwx4/pN2lECn46g5PC/UjSt0RbM/us2FUgN3dQf8wE5xrDJM4wAqRvjL76w56ngRHFRtH0YDsiuFhsmVkGsGjLpCjYZcI6ljPgmm+/L7AxCFjyjCZndibhGPBNqUdxGhe0s/MZdpoR6lxWWyXGNBWtVISp9WGKXh4xaVTHfpe4nrQe4kCxu+fqxws3xaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:20:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:20:47 +0000
Message-ID: <8bc4cc50-ca1d-404b-9cb2-db31c89fbb13@intel.com>
Date: Mon, 8 Apr 2024 20:20:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/31] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-17-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-17-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb7c14BZY5ZmTb+YUi1YmT5Ubsfl9tpEFTYmLG5hUqaPEJ8F8Y/jI8+db4pt0Ia4+7MI8QzfM8wevrbA8YUgRL/vmljx9+iQ2WaNpXNmKHX7L4Fe/V7Te27QSZVRVLOEghX0fGOVp8AIriENiIV2vM5HF4AcscvK2mLY3jvN1aKd2y9YWnQdOaAmVC6dH1kWiPFk8C3b6YEXU6N44uxWMPiJSFN7pgEjZS5ZZui0IxYHmaa72Pcp/fz+k4KSLJeDSVbGJe9B8dAPeZsusSiCJclN2sdvYI9VlzJCTHS5XfaZO1Abz9fYRGe0xImM/XbYEIe/9yB1BTU/sQL+1aFAjuU6w8mXv6GQdNdSgkc1hcklbuf5WU6I187n8mg7GqL+lLwJGIlTr05F2WTTBFflvgxClWmR3T8YW/c/3Cb8hdFagDvI0LYgeGtTBsFwba4mOqvLBwsqyv7dPXSeOP+ewAH7FkxzhYDCJTV3fmbT688maPKx5aoA/h1EbFtQ77xFZTbBTpOw+OAWkxpHpS4GP8ydSnRPz4jWNsiElz5rDgSylEhSFdsI91FTjD+pVIQGi0G6UnXlnhbc7HhNcg5qKTSLmwP7vLbBybwLdxh2ZyRl+j0zpHesNwNmvye4Gufy7gakpPzSE+atyZ2g0pe8MYEZjoveFhdfh82W4J2KPxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJxUXFFNTRlTzhVYmtpZXVHcFlsRzZnelVBNEY2ekhEZEltRVdGdWZwekpX?=
 =?utf-8?B?aVl4MG5scDF6OEVGYy9uVFVhd0R4SXp1aW8yN0dSTC82YkJ0dGRuWFo2eTBJ?=
 =?utf-8?B?NU9PeXFBNUpDTUE2L0lMU05aUkFnM3kxKzJTOG5sQzVnOGx5SHFPbVRHa3Fo?=
 =?utf-8?B?YVN0eEx2THF4ZUxRWmJ5KzJ2KzVsNTJOSW1IanhyYm45cUhQd1VKeWpydEZO?=
 =?utf-8?B?RFRMalpweC9VYS9RWkZ6VzdmVFlGeUVPRDRwUGtyYk1KM2dSNmhPYWYzblVF?=
 =?utf-8?B?NlJ6dTRnT2R5SWttODBCVStmSWtxVzJNaWR2RERsbldpaUl4aittR2srZk80?=
 =?utf-8?B?L1dmU2NpWFNwcm5VbGZab0NrU0RUWlYzVlJaNzZtMlg0MlBNZlYvM1ZaRHF0?=
 =?utf-8?B?eDQ3RUhsQm84RVhzTk42UU1vMWltaXI2QVkrVmgxMFRmbVNqYU5maE5kdDZS?=
 =?utf-8?B?aG9LR010S1EvTkFSK3EzUk1wNGlabmZ5OEtaazZGRStiME1VRllEcGpPVTFW?=
 =?utf-8?B?UnBHMUJ6TXNjcFowSE8xbm5NNEhDYzBycmdJdzJwMG9neld5OE5qZ2tVUUFn?=
 =?utf-8?B?dC96NnU5d0MvWWhtVERLMVN2OVZCdGVWcE1YNWVPYkN1SCtiWm5HdkRJYUJi?=
 =?utf-8?B?ZW5sLzllcDg0OXBsanM0SXpCdkdHd2xhVk8rVkNpcnVOb0tJUGVmc2wrSHZ6?=
 =?utf-8?B?WFFUajZNZEdGaVRGb1M1d2pYS01KcjZNY1pVcFY3ZWdLMDJjZHMwTHhJdHhF?=
 =?utf-8?B?SU90d1F4MW1zVnZsTGFuMVBBMFJsQ051YllibUxTOGtKeUJ6OGY3aldkRGxD?=
 =?utf-8?B?bk1INHd5RWh6c1J3NzdyM1UrclI0T2t4YS80emU2dDRQK2JyaUFseU1nd1VB?=
 =?utf-8?B?RExuNFZvcGpISVBmSzR2NWVvc3RrcVF6MGp3Y0JXK0tPakQ1WmFwSnZUV1ZY?=
 =?utf-8?B?NTB3SGQ3T05xcVYvTldqWGJxbFcySHNrNFZvZ2VtaUhyZlFoSGJ6Tm5PK3g4?=
 =?utf-8?B?Z2pzMVZQZEV0eGEvaGdodmJWUG5uUkordzdScnFTTVhKQ0pXd3Yra2tHbXUw?=
 =?utf-8?B?SXFRMkVITXVQVnpkWVI0eVZpOU51ZnZjcEVJR3Y2U1NBNTlMSmRKMGZjRWtR?=
 =?utf-8?B?SlBxcnVPM1FJNll1YnZ2R0JuRnVKOTRxOGVOQzRKUmZyWXVsRXJWVitGblpi?=
 =?utf-8?B?MC9qQ2tBSFBLcWNHOXF5Zks4bDBQbmU1UXlTbXJJcU1hYTNJNTU3Yk1wWVdR?=
 =?utf-8?B?SnBNUVYzTzQ5VVhmc0tCb05XWlNKSWdqR3A5WEVhQUpOMDhNelZta1htZEpz?=
 =?utf-8?B?WThoUlBBRXA3UWZzaENQUEdLR3hjaklIc0hHOUozUDQ1dWs4bGs2NDk0eTJ5?=
 =?utf-8?B?bkoyNmV2dk5Wa3VzTHJTdWZsR2craVltd1VPem5uZ3BEMEF2Tm1QcHhpRm1Z?=
 =?utf-8?B?d2VadkQvMm84T1pHZUpjWDFzaWQ3OXpkSVBFdkM5TkQzV0dYUDVSS2hXemJa?=
 =?utf-8?B?RjUwVXRhZ3hTb2d4eThPQTdZYklNaERZZHZ6YW45anRRSUpUZUg3V2MrOW5W?=
 =?utf-8?B?dmJRbjlJT3lCcVVVVVIwVFJyajNlVHYzbE9JS1RVU0QzVVhoaWdJOFpYNmJY?=
 =?utf-8?B?NmdiRjk1UlhTVXNydk5TSmxneFU3UTBIQnFWYWl5UkJaaTNDdmJzY1M4ZEhC?=
 =?utf-8?B?SjZZYUR6QTR0WnhiRVVWWmdLMkJqamZ5THh5ZG9FRnNDTjMwQm0zbWJIZmJN?=
 =?utf-8?B?ZVovWitLeTZVVEtPbnUxbWFaNHEwMzc5RkdMQS9Qb2VDbno4OVJsNkZSNW5R?=
 =?utf-8?B?RlNTbFV2cFdWd0xwajZSbHlEQkZXNGdteElVVkw1eHRBM25rNC9tdGVCWm05?=
 =?utf-8?B?KzdZOVZzR1JZb1BkMkZDdlVzQU5GcW9ZdXc2OUhoUUxsZzV1Z0llNzR0Z3ZK?=
 =?utf-8?B?S1lGR2xSUEF3NWx3TkpMMGU1a1hzSW40d05FTjhvbWFVeTRzd2J2d091VlNn?=
 =?utf-8?B?Z1p4Mk9DRVZ5YVR6cWxSaFMrS3E1cks5MVBVVTQzTTQ1bDExbG1zYS94Q3dt?=
 =?utf-8?B?WVBHVGNySFpUUzZkbFNrOFdrYVU3amFIblpsOGZnbTIxaDZKdnp5UFhPandu?=
 =?utf-8?B?WmNueXB6ZHhwenJLWGduMXJzQ21mbEdnQkVRc0ozQW9wb1BOVGdMcnBaK2lF?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2555a43a-3119-4d8e-4aa3-08dc58440ca1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:20:47.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dEwE7NSJSa+GenIzn7RN/Rr/GdXUToE0QY0a67b88WG4U/L2JM2wJTXh6eNKP415yuvQq4uxWktaXSqTb5T47XO/Ui+eSHl8BWVae3F2bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> mon_event_config_{read,write}() are called via IPI and access model
> specific registers to do their work.
> 
> To support another architecture, this needs abstracting.
> 
> Rename mon_event_config_{read,write}() to have a resctrl_arch_ prefix,
> and move their struct mon_config_info parameter into the restrl_types

Looks like this change is actually moving the struct into include/linux/resctrl.h,
not resctrl_types.h.

> header. This allows another architecture to supply an implementation
> of these.
> 
> As struct mon_config_info is now exposed globally, give it a 'resctrl_'
> prefix. MPAM systems need access to the domain to do this work, add
> the resource and domain to struct resctrl_mon_config_info.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

..

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index bfc63e8219e5..975b80102fbe 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -192,6 +192,13 @@ struct resctrl_cpu_sync {
>  	u32 rmid;
>  };
>  
> +struct resctrl_mon_config_info {
> +	struct rdt_resource *r;
> +	struct rdt_domain   *d;
> +	u32                  evtid;
> +	u32                  mon_config;
> +};
> +

Please use tabs consistently in this file.

Reinette

