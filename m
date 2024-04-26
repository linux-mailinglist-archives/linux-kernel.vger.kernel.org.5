Return-Path: <linux-kernel+bounces-160678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BCE8B40F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385FD283CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87CC2C69B;
	Fri, 26 Apr 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXBk4F1k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D52C69A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164720; cv=fail; b=AmEP6rSAnpDk/3HYTJeM8pJtJJn1osWLoc7WXalu5FZS300ZHJig5HcD6bQ+2hZB17aNRUTZ55ZBL0YDlMfIF3U5f0JQbcX+z8ruhNzfQIgtPOqwVlRi0SbYhpQOaXuNXZw4GwMRgPdElE8POdaLrboLX7Ikaxk/N+I88wjQUIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164720; c=relaxed/simple;
	bh=c2/txzVhLs/QOBH2Ayuyjp0Gxiw6HeQIjU/BK6a4xtM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q2+DvtnEQm4aB/x7gL6R4DvNaz9iFhUg/CYMkdQzyf+EQsHK4AiCithvdud1gdM1f/kc7u/nJbFwZgd2zcwKvS0gMsac2/oN7hXUswBct8AioorIFx+oktPvmSHfLPjjdttU/Xegv/U8EdkmWc/8wrLsMWEUe84f6zoVQyD73ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXBk4F1k; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714164718; x=1745700718;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c2/txzVhLs/QOBH2Ayuyjp0Gxiw6HeQIjU/BK6a4xtM=;
  b=dXBk4F1kB272Uc1av0td/Uj2nl++PFMxH6gqaVLILtDYB/z+z7KQz1lu
   NnNgHSBIn2YaW1KjkCOWwDVvr2mpJD+KY8YtH5WOJ2NF7AWRUH/ijBQIA
   A/HVLk3dBpN32BSSk/gylvhRYSg7DmI8fsI/5ZbpcCJghQcxXr+8ogiyP
   ruXmy6o1Ssx2hfZJnTFdAQMkKuW3FLqm0UQkxDUaOSR/jhw3LHjuryv3c
   DumEHD/9FX7pXd1GuR2+RttrAqd1gUbEWHUMkXAP2J39E19IstdxSmTCQ
   nUSstE+f1MOLotxjkWWR+oUe44YqRqVFQtXSPnJZNQB9V1xaSYq0FLnp6
   A==;
X-CSE-ConnectionGUID: ttAc+l4mQhCrB/azh3iOCQ==
X-CSE-MsgGUID: ApFXF6arT7qL3l9Kzxx9aQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9787269"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9787269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:51:57 -0700
X-CSE-ConnectionGUID: Sl12nKOCRJ6LaEneigfx1g==
X-CSE-MsgGUID: zv0g6vKrTJ2+33iYGMzVHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25498074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 13:51:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 13:51:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 13:51:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 13:51:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 13:51:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMFTS4MKDF3YSsCaWgB0uctQpreSS16qPYLqi0u1ENNsi5Y2iUKyz0K254aodMit8fa3dx/UWSNFAaXUxBYYtYefb98Pt9gOYRyQ1fFDLo8ZLRPmt8e2UfU9qc/Rd98FyNnyFj93+gecLUhzCvpBZgREWZMlfkXQH+avJCCEpVA9EVfxLgpdA9t6CosDoEQTbOkpBHq9H6aERlGFMk4nXXJXBwCZDMY6QUS2xZ0KF6EECtZKfW03/LrXe+UucKQqoxFGYePvLSL+57z6brpkUWhg3GkxyUvV9XcSNZz2vZctDGRsUIheWJ7GO0nDQ0sNdpBKEZKAdxmngTiMyEK05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEUs/fExeccKAqbdKMMXN5SxZaJl2uMmbrntgXyDqz4=;
 b=mbqgIvEb4/yUICtZs+M7LZgUF+yAc76IPIJYI1gIpNwz/goang1pEAQx5vjV2CTUa9ed+h0bpeX2CXRTnfH33INCz0dcji2L9SNax5/HrjRqiR1GtNhB50XGYcovrvHCM9rlaqLpeHsKMM/cXdHG4vyJ2Ax2r8IihIJ+12HAEXomoABZM+wANHGn/d+J1RX9CRxDG9K1fsr+cuZrI8AaZ9mMLUnE8AtqJsUuNX0xg7icpn9TAhymgIiVJ+C6t9DM80u7J8KMMJ3wrJ8KFFpYQgGI7V7JT7n7T5LYCpH5QkrIViONLmufQ8xYAo2/u4MoWToQYOuDSvm2+g0a9FVhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Fri, 26 Apr
 2024 20:51:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 20:51:48 +0000
Date: Fri, 26 Apr 2024 13:51:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 11/15] configfs-tsm: Allow the privlevel_floor
 attribute to be updated
Message-ID: <662c13e1bb59d_b6e029460@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <731690ebf2434c553a08bb06e5bc6cd8fe48a4bc.1713974291.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <731690ebf2434c553a08bb06e5bc6cd8fe48a4bc.1713974291.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad2f0a5-42ba-40c7-1acb-08dc6632b126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9iWxFUva+xVMJ+hX996hDySLzndDJLliz2T3Y943HsmAis93m9027EoVENkF?=
 =?us-ascii?Q?sTsHgqQnz234qfiAbT9Dk4nNfUK5zKQHYP5YHXYzphoBYKRCO449fnpLE91D?=
 =?us-ascii?Q?2k0Ym7y7KAts1gUiCRyvIj6VGtCMOYuPgehC/PY4t3pVMsTfk/selayT0mKn?=
 =?us-ascii?Q?EA7ogFUhAdMTy1FxnKo4zpjY04yfBgvhAtSNbRsvi/98MTlSS5x6Dy7VZcTQ?=
 =?us-ascii?Q?Ly9FsUUjv6VgffpbcvVphqqp3eS+kjC1slOhPNvMSJJNvuuH46XglmxrbN8g?=
 =?us-ascii?Q?O4TCkT911PP0gYHZTFoDyQ56fS3vESpxX4ig6Wlj5iqBSUH2B2aJ5Xj5rpc4?=
 =?us-ascii?Q?hNWdjGmgWaL2+23NkhST602TaKliZGJfLYBruRe3/Ru324MYVGyvaFwQmgFY?=
 =?us-ascii?Q?T/dSHfTg1DML2hBMladSpni7onIHSeUIdYn53TEIqISu9q7dLikxZ9CAfO1J?=
 =?us-ascii?Q?6No3Yk1YqhJXa/qWve/OpvVTBewQG4iRW5eZqGl0YHSxJIwg9Tu5H3sllHHD?=
 =?us-ascii?Q?pyeDfCb/abmMnzn3KJDWj++cvzGUuBwIubBLN3+rsttcF0qnGEVwMAuq1sIC?=
 =?us-ascii?Q?uRk2ONOr8JZkSD32GYiUB4NbLlJfYyuUr9/wKcHqXbr/5pZCQTK7snSfhuQ5?=
 =?us-ascii?Q?kADhbw5ocr+vmmZmcfAfYGTbQVXeHdzwSFOkI7wFH6PFM8cUcnK2vQchCz+2?=
 =?us-ascii?Q?OuBo6M+wOHJOg97d28vQuNXZ9gLiU/i6Zm813/mrDCrDHyMwujpc2qHEIsUE?=
 =?us-ascii?Q?YE9ZDavmTE70LlrJxuHXNBd3HTPjmuHvJe3GKDIeclW28OjW6yJB1IDlimcp?=
 =?us-ascii?Q?uFmWQ78cHCNCkExBmRPoSDdOOJe0km7Le8hS1uH6+5uzI+qE5fa10zB3jhSU?=
 =?us-ascii?Q?tP7k2Y6NjObx/nL3DvM/10H9Kw5yAA49RgW7RrGGA2g9Aw7412kWhyl4kcp7?=
 =?us-ascii?Q?9bIRB8J16TKgAt/oPG32SeWd01O+JLnW2fw4QjyZuCnAM+hbzMXWAUOKJt7H?=
 =?us-ascii?Q?95nsHDr0CXbs3/q8fgoh9v6S7L/JIEABmlUjZjaIDHRSKp7PwLtjBDamiS6x?=
 =?us-ascii?Q?Vbzahkt7ffptV8XEBUTpja5hhD81TDw+8yqEOb28JY/r8xAG1Wm9LrKovt6m?=
 =?us-ascii?Q?UZKjD/58ApHnnNNg2czUm/v32q/CyiymkE/p2Z8ICeYU1FyZgEl5fkgyFiiL?=
 =?us-ascii?Q?hkdUf4dO08BV6gWLvvuLNDjPJ8iHoEZEUNUrGOV06OM6Yl4vlsxEApJn/AQ3?=
 =?us-ascii?Q?IVzDwT7TnRVYM9i6dc6gyz4Nkn8wGBBBVY2urvcXtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9++cC5MlToG40xoPn6IvXsd+PvyD4PKRpP8iT3b/Tb+UIgkkhwz5DaglQSp2?=
 =?us-ascii?Q?J8Axgjk+jpHzjkHvK5Xg4hmGaeGZMYoHAmQRnXzH7xJa6PZYbC5Xb0SckvHq?=
 =?us-ascii?Q?QyMfNnVP2KtCgKZ4fQ/6vJMcPuZcxEBL9lxUX6b0YEnEjJs1n30ffkh8dwxv?=
 =?us-ascii?Q?r9AB4FVz/XzwO9TPf1nrltKeQNWMQgLxByhAxhMx1dipfz6JEKkVX5Yqv87c?=
 =?us-ascii?Q?v2QXxPE1ckfnYwnywDtFzkzuQJKw7rrJ9S9ioXy3pzmvFicK/KE6VC1sHxuQ?=
 =?us-ascii?Q?5jci0J0zMUfE5Amosrwb5NaT1yYHlXNXXT2/erzrA3o8+QicKZWRXwYHCd0L?=
 =?us-ascii?Q?/O6/hApSQ5/wLPYuDzX48QApHQELRYfTo/ahhhzZ0Q2CyETpDD5E25mUJjXG?=
 =?us-ascii?Q?Lf3GJop8CVl5aqMFkuoZfk56onXYJRgeX/QLVdI7IBMbRHrnJ0RtdPOOLsZM?=
 =?us-ascii?Q?6kPgcTf/ibgshn7dQUdVpk5TauX7SycDWOnrEXY6fz6nNMOR3g3CaRlmAoiU?=
 =?us-ascii?Q?Sn3f2jdkyhL07wxso3Uu2l9+ojdJs0ih6H6pnNsyCgXbyAMtLkkYPpNGg3NS?=
 =?us-ascii?Q?a2iJGjNoQXbv5j21Bf48IDcO+mqQKk1zkIW2+YJvCXjTs9TaIWy82S1kYgHz?=
 =?us-ascii?Q?8dLFljmC6qhdiT7QBUkx9KB7UL2VoQgigdeKM4LzPA3oBoGbtv/nURr34dNo?=
 =?us-ascii?Q?4nezPGEuqSYdtUVAFSU9pd+35oj/JWdvWNL9mXs2rWr4SPkZ/wuCXZS/nW6S?=
 =?us-ascii?Q?A6+7waQioegP784il3s1gvGvLn6nhl//NNtFzMbssOUs3Sr6+X3Bvo+xqk4J?=
 =?us-ascii?Q?VonFAijXWf3IqjNmDaVtaOrQfY8tbQZNmGzvFYCUvAVe5oxPpjyJ2tn7qN2r?=
 =?us-ascii?Q?6o8iGD6UGb0s3rEVr9PxVl6fs/PuG4GPxCX5cHCa78Kip1+DYAhuPr1VVADs?=
 =?us-ascii?Q?IHszNRvfKWiZFEhML4ij38UqVYbfwxMgebeKvPfrwj8NJsYNnbsci93wVknO?=
 =?us-ascii?Q?M0J4ojQ1uNFjUpcFziBO/P0oXzRwVrp1iPWxP1ls6uO5KDO1hh7uHUUHwcBA?=
 =?us-ascii?Q?BsiXbSCB4hBJ3W13xCYosREY+ej5L3tPPLUjKkZBL3LcVajA+jfET8Rgjqnp?=
 =?us-ascii?Q?7WUSfOvegrmMpFcKiZQvdQtcsmZKgprvQH9KR0e0JWi6uz1KzBqcgWUezibG?=
 =?us-ascii?Q?d6Xx3G2vzv2zJEd1Ey7dwK2cxGQvjzgU1m5fm5wEj8Ql/PGhi4yUHJBRvUmh?=
 =?us-ascii?Q?mmv0M1pxVXWLq7/R42X+1QWd6ddJVsEDrL1IhlWB8JrqldPCJD3ktWTTQu1w?=
 =?us-ascii?Q?3WGfuZKZTSrXRGAbmB9QQI5BcK0kDgrw4DF5zILAi5D5nmwuo1W8JAyQsEZ3?=
 =?us-ascii?Q?cU8qgUZa7ARlOpXEe9TQHjoDwbMSGKwgkAFV3fLZidE6M6QAUttpSl3anKJ6?=
 =?us-ascii?Q?6dX7YUHfl/4cav1ZQkBSUqRitmEpgqCCgfMzh0dnW/1rEb76NSJCtwn8NZsz?=
 =?us-ascii?Q?gm5/YfLP3ILxXRSWgyLgtxYNKyi7MuwjC8/n9nReyXCVVdNW2bRNR6oKjrha?=
 =?us-ascii?Q?bqD7inArgXm/yR92WDJ+ptQzcu6VT3udQeZGK10npx2ElUbBj0xrfdd5k2P/?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad2f0a5-42ba-40c7-1acb-08dc6632b126
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 20:51:48.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTrNt6MDTRdc0WMOBtVJKxVqtit6p6elvgw2hzUkpzyxHqTOo1J3onXUZN/wiz82nPTsci3VWnxsGtKZIDQqfCD70ORoPxZRVB5yz9gPXKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> With the introduction of an SVSM, Linux will be running at a non-zero
> VMPL. Any request for an attestation report at a higher privilege VMPL
> than what Linux is currently running will result in an error. Allow for
> the privlevel_floor attribute to be updated dynamically so that the
> attribute may be set dynamically. Set the privlevel_floor attribute to
> be the value of the vmpck_id being used.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

This addresses my comment on the last version.

Acked-by: Dan Williams <dan.j.williams@intel.com>

