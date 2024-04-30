Return-Path: <linux-kernel+bounces-163225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0648B6766
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7591C1F22C70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49811211C;
	Tue, 30 Apr 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ha/2U9yk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210C1113;
	Tue, 30 Apr 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440323; cv=fail; b=iZB9dQQoyl/XoxhzNxASq5XgkSOTA4MwlHW9Wkmd8PHAzTkzdRxM2L4tN9OsjLYAAor2xVkRqpqv9dLznjoD7ZkwPGCs7VP1344OW87a8Hkh0qi1eKivPUHz+qM6Az0mU1nWhfHvcjN947rTJ9EeFYZtQ9qeQxPjPQdmzPFWxnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440323; c=relaxed/simple;
	bh=By+fJYk0A+l56gxea0ymoXCfvR1G2SpWbQIHV/Qq4pM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CMK3yITL9sTd6lpRnHlZczVK+xQUo4wfwB50AxSMmXx0uhPcPeWt9kGNZ3iatxgNf/Z4/YgHSbOyG3lOlIZPGR19EnRJ6AhJbupwBbIux5BTEC90PiAQ0m8xYnRGKoekmTv0X0Q0Ly7bG1rKVi1CBphWmzgqhWlqMe2WfiYcGRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ha/2U9yk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714440322; x=1745976322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=By+fJYk0A+l56gxea0ymoXCfvR1G2SpWbQIHV/Qq4pM=;
  b=ha/2U9ykKEDM8LnBLBD6uYptHvQO/JtzLdBNnKhgsf6Q/kx7GPGIkE9N
   gHyyY4FnVP0aCiVLvKYjLpwqtNpEHv+Eg9bj33pGCyS33uhWna10384Fk
   XV55zQHwH8+f7T1z/zYclYCtWN8BCXF2AJOEKDoYSqBUi6H+1MWu8SyJf
   JdXkALSF22jC9AU1301YQcM5HIttMF1SmP0eZHLGABiJ8twxygApscEal
   xmy91cE0uogtAfr76QCeeKfYX1Uqh43gQ0CuVnypBFnQEDb9K1uG+XGAH
   2csIihvWulLktSR+j/spOq61lf3aoOXngyUySu0XoHJf0le7okVetbO82
   Q==;
X-CSE-ConnectionGUID: cQECXylzTt6Nog4SIHazxQ==
X-CSE-MsgGUID: fUH2tLAFQvS2AULW93k5lQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10002315"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10002315"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 18:25:18 -0700
X-CSE-ConnectionGUID: VC1vc08dRHSClHBrg+as+g==
X-CSE-MsgGUID: hrAMC3kTQ4y8u3b9IDBf/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26156755"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 18:25:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 18:25:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 18:25:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 18:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PglubswbroxVcp9IqDJLA+khN3Cym2l5ZD+xgYFAL7RhixeHXzx+5nTytXNiaWyiMhqilobr9ROWRcA7z42jemzvNJTBFsXHhAc4lA041pPUKq1/nyr53wh4cwtXx3TDJpWczzpWHIATulsHbnlFHlYP9PuPMCOXImKyDbTbBf2mE9JU1BgdGjhxs1y0aSMmPcdw2b7ojPgHcC3Tsd2EAsreZjNlVeh1GjUG2yD2ZKLiHlgfdjxUPZNjqaaputHQXGVUvJJ+dgryKNz88+sn8JyEQQpWDnP2HLNcJMIoKtCUX//9yiQNzzs7CzIvlWK9ybOZZPSeAbfKNq+5twBhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSeSQ+sJcM/zLn3esdJO8TLDR5MsHC3ut2ye3ddPinw=;
 b=J5wiZUDPzE31F3rQ9+NmfUxRxT4h7k7nEha/fg2clCvVfBlBQTjkBrlaA+TXtJZwYDXfqeRiqzNmWwOtJSokJc6w2nr9eeRV1Z28mJsgG56Y14i/xw4m5FcQXdv6qSSdHQ4vp5UMPxGjK7ab5g3+0RKgyl3X2abJb1AfbTABJBOWGaWMQGfscm7h9ppGBLG7CMpf3UR+dZIFJzuQcxukkt0PPvn803pN5YMEbm/KHanq1lWwRxTcs93XlLtvmSSrRbYTekZ3gy4L6sj+0KgXzLQL9UNDF41iS+Y7RpZCPtRQQFed6EQ37uOuobepcz2rYrCYExCGKDMpvkYTr0U1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 01:25:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:25:15 +0000
Date: Mon, 29 Apr 2024 18:25:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 2/4] dax/bus.c: fix locking for unregister_dax_dev /
 unregister_dax_mapping paths
Message-ID: <6630487879c61_148729427@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
 <20240416-vv-dax_abi_fixes-v2-2-d5f0c8ec162e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416-vv-dax_abi_fixes-v2-2-d5f0c8ec162e@intel.com>
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d89ae9-95d5-4c9a-2909-08dc68b4633c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zk1Jvl//vVVi2c37qwohXu0KQRU5Im3UeSIylOSLDTIzvTM5NlmSdCVsPPc3?=
 =?us-ascii?Q?4KJzZhO1UxUkv8UfSWd7PlvX7PS+mv39rD4k1PnNmEEfWLp6+AWqylwUgeNu?=
 =?us-ascii?Q?4bWmm8Fz9VVsa/ZDHrY5TdT9dZuhxypjDhgHMTF3RoQELaKhFXRqyQkzVkiZ?=
 =?us-ascii?Q?AxoJMYmYCpZyYzYq1PLllUUtQyYXW5FKUsuE9NOxTjFwk7I+W1mo3uOTyNpC?=
 =?us-ascii?Q?a4XrunmDbB3KQQQuTzO08B2DyfqSQ9uKoxL5krbn5NFRyL2DTeAcDp55zLfh?=
 =?us-ascii?Q?1m1tH4tH5CsO2JgWDdWerSKcqoeU+JzLvzmGtkI0q9pRviFfqs4PS1eKyidO?=
 =?us-ascii?Q?XFrO2IEhmUzLNQYsRkXIVDxBgGiKvkDi0JiEK2JmVMB8y4qSAN6T2O1cd9V5?=
 =?us-ascii?Q?O1e/s47iB8Lg+Ui2Afsl0EAthcXuH8nHlPmj+NRDGScNq7kD0eUwbQpBNE9X?=
 =?us-ascii?Q?feWHgrJdEyjzyO8HmdkUBiCZDN1g8eEJEZl4eDAoskRWyPUdM3WlWlOZO74S?=
 =?us-ascii?Q?K7CmZeDLhjMCI23LYOePHsRnSwhy6igesnSZNQDr/47+RiLnRchzEzPS1hzY?=
 =?us-ascii?Q?Cz/7XNE8YEF1I+QoGd4ynk8BM3nF5X3b12mCULQuxJ/wtNjSZM+ipUvr9ggq?=
 =?us-ascii?Q?v6QpyD4ejdSjxguQuVADS63vv+RJbWKVq0cziUdW5RcZ0PGeTCPbn+b7oDvX?=
 =?us-ascii?Q?TJd6qywgRLKosgd2p7UqR5Ji4E+neAFYQOndSFl4cjRWqfsQfikTQxwuSsLY?=
 =?us-ascii?Q?eGRyTf251+ZwCJSvBg3DEPSe7/A9Y+UF5ZdDO+1JHh4Qdma0euNnZsCK+aRO?=
 =?us-ascii?Q?bowStXO4smCAieiF3nEPTBlPmXIBkXECMSDcBpYQ7o9F8GxRiR2Wu+szBC00?=
 =?us-ascii?Q?us8zcV8b4TCnwpNcnq00iGXzpTAdQyczNuEej9hlaGZleJ0rbDLdPAwCXewt?=
 =?us-ascii?Q?hZ96Z73mqjpMBYuiFF0Li0VSDDj/mH9Avg5vz0QZGk3CrY4wUdIlDl15R2Z8?=
 =?us-ascii?Q?3LTaWQZ+jHwdwI+92mZ9Smy1OJwk1WWrF2/aCAhFYry0gTqp4opHZGytjos4?=
 =?us-ascii?Q?D1ayrozX/vbGWuVxhD3mo8moftMzLTZtTSBFH8PyOV38o0wbgN/IwgoZiX/c?=
 =?us-ascii?Q?gmRBN3yvalPttZwcVmgDGnJh+uDHRxX5s9pAYt7eXlfFTk1d1t/Ntqgo6L8P?=
 =?us-ascii?Q?0+8GunAMByx46lJRI9am3BLPuXFZ+1D82/ibJbB4BgGEdQO/VNqDBfvPL9tx?=
 =?us-ascii?Q?Mz+nDNkfO8/MmPF1gqoqSVXHtrJAL1hdBaGok39rLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KyTwiwpp8Xq4QI09eo/m+ea6JsBxsg3nwHB6a1IPRhQqPL26QHa2wNL2Bfap?=
 =?us-ascii?Q?CbdL2lPbyHi7YN9DsmZUvlClvNPnRyXZ0eqh7AN5tzisOxplk2W0lWcrXRoh?=
 =?us-ascii?Q?XsH8eP0yTkzGVVHXV1B2Yxd2K/Cqa3qbv8E7HzgFp+46Kt2Jf8kismcBkxsZ?=
 =?us-ascii?Q?ofkA01kXZkLuEsgb1N+jl0/8vECuXIPL20pM9NyZfYVKvJI0NcO0fvFqwNVA?=
 =?us-ascii?Q?ArP+D6TwyJ2En0amev1OYYEreWGyMnEObSaI8Lr7MCntIrZqJhtSoAY83B9h?=
 =?us-ascii?Q?A4lPR89Bc29DGaSCLt9JLkpOkT0Ge8aMMD909SS+oy6DXCC2pybZE119TmMa?=
 =?us-ascii?Q?IdllBQ8d6DWu6xXJEj7SM2wZw0fe6kppbL15Bisik6ApRY+KRFBCDZ3MUqMB?=
 =?us-ascii?Q?QU3dtK3LTOJev6dTGTWX+aSPjir2c8jPyUw/YT1BfpgKr31nQCHW5ijVOjWz?=
 =?us-ascii?Q?yw8SKhXhuapjok50trBDbqXPFXsrmYLm04PEVNIu08EcAgKc8+YT93dxxYk8?=
 =?us-ascii?Q?3YifL7YKTxSIuZPqLvgg4M1EG2svINWahrwxpbZi08i3rxcFbDhiDDHsDMEM?=
 =?us-ascii?Q?vvFGt6SpLV6TdOOf2j/K31hF0io1PjPbehE/fQ99lmBBdE4Rsk3WYFnyADHB?=
 =?us-ascii?Q?H2Vn4f/GFjgXJioFvCfBNqztvGDIZh4wYQQmFtl0j+2hkZCNKEImdtPUZLP1?=
 =?us-ascii?Q?uVcs6S/3LJ2CN11plCGMRQ1hySZeOpdjO0rgXonT9AScjLR3tR1mC1NW4Y3N?=
 =?us-ascii?Q?jAOyWGFl1u5XAE6UOmAt82Sc1r8OX7HemCrtZBUzVfbmkgd4qKzzYJar2GKi?=
 =?us-ascii?Q?jXpj2DlyOMy7DsjJEkMWhRfv9qCoVXqW+NTw5GbaGjIM7D8qjtwRLChovHWc?=
 =?us-ascii?Q?6rppqaoPrd/35XvvXi/X5PnFnDQns74kk/mKJthJlIt0ztoW97IObUIorWfH?=
 =?us-ascii?Q?PMQ3dIBU+3vZXeEvdiSxGmmAPnvFOQ1XbggA9eTAXormUTzxhM3nEyvPYu/m?=
 =?us-ascii?Q?WAki7vtA4U4tVVZ9C8Ro0dH5lc1CcmuBJ951EEY19aWnm3SKwd+GlXPz5bT5?=
 =?us-ascii?Q?PqQLCJjYTIZEcDmhYknH6xDyc+DE6GvJ/4gnzHRwcHCuXknxetcizsbkrqMF?=
 =?us-ascii?Q?4F7nYiHkK0sqT/9Kb01gsOo/aJmH6cx5CVLBWugbKTs02pMzsFu0eRITnvr1?=
 =?us-ascii?Q?IuiGg6L47kwuD1b+xUXmkk/DIknvTZi9LMFPF2m5uJnhMW4MwAgd/G7vKe5Z?=
 =?us-ascii?Q?BVgmQiTYQhjddQM3RW9a9wf34ujkE/HT5lhpZ5kaC1c38bJeYuvIezebLdwT?=
 =?us-ascii?Q?//16yV0Hr44fJ/0ZdOrbOnYLVN2V+/UOmyUfsyNVODNuIZ5HfpBQeTFDg4DD?=
 =?us-ascii?Q?CQfeDem/MdBjVkiuqvSnVlLHbC0+4rReoy+m7MC2anxTNwxHhp+Vc6ZiLIi2?=
 =?us-ascii?Q?qPcYR0rFJw/bJPf3y2eEXNykBjguoeWwgnlB8gGuJC1npfMyHlgG63Fg/Wk+?=
 =?us-ascii?Q?+Y83Udj7hEbIhIvy8UJRP6i7wFx84HIRERH+37+EuIKdh377nLLBFCboe393?=
 =?us-ascii?Q?pk5SGeuvbDk9Gcsj6f1o3BXq/JfZJ4xhirPeDOISCNQyv62UpiGkHHQwxr4l?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d89ae9-95d5-4c9a-2909-08dc68b4633c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:25:14.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/xbv/ygoo3XC2IzTQ4Ys7Yxroo1VTsy5BizWR8eacoB4bhYBLR13NR6/a3hIpCias1T54Sq4i9B5W3KZ2Mf50gDB9WtDFSXnEAAQBZFTT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com

Vishal Verma wrote:
> Commit c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
> was a bit overzealous in eliminating device_lock() usage, and ended up
> removing a couple of lock acquisitions which were needed, and as a
> result, fix some of the conditional locking missteps that the above
> commit introduced in unregister_dax_dev() and unregister_dax_mapping().

I think it makes sense to tell the story a bit about why the
delete_store() conversion was problematic, because the
unregister_dev_dax() changes were just a knock-on effect to fixing the
delete_store() flow.

Something like:

---
commit c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
aimed to undo device_lock() abuses for protecting changes to dax-driver
internal data-structures like the dax_region resource tree to
device-dax-instance range structures. However, the device_lock() was legitamately
enforcing that devices to be deleted were not current actively attached
to any driver nor assigned any capacity from the region.
---

..you can fill in a couple notes about the knock-on fixups after that
was restored.

> Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 44 ++++++++++----------------------------------
>  1 file changed, 10 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 7924dd542a13..4e04b228b080 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -465,26 +465,17 @@ static void free_dev_dax_ranges(struct dev_dax *dev_dax)
>  		trim_dev_dax_range(dev_dax);
>  }
>  
> -static void __unregister_dev_dax(void *dev)
> +static void unregister_dev_dax(void *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  
>  	dev_dbg(dev, "%s\n", __func__);
>  
> +	down_write(&dax_region_rwsem);
>  	kill_dev_dax(dev_dax);
>  	device_del(dev);
>  	free_dev_dax_ranges(dev_dax);
>  	put_device(dev);
> -}
> -
> -static void unregister_dev_dax(void *dev)
> -{
> -	if (rwsem_is_locked(&dax_region_rwsem))
> -		return __unregister_dev_dax(dev);
> -
> -	if (WARN_ON_ONCE(down_write_killable(&dax_region_rwsem) != 0))
> -		return;
> -	__unregister_dev_dax(dev);
>  	up_write(&dax_region_rwsem);
>  }
>  
> @@ -560,15 +551,12 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
>  	if (!victim)
>  		return -ENXIO;
>  
> -	rc = down_write_killable(&dax_region_rwsem);
> -	if (rc)
> -		return rc;
> -	rc = down_write_killable(&dax_dev_rwsem);
> -	if (rc) {
> -		up_write(&dax_region_rwsem);
> -		return rc;
> -	}
> +	device_lock(dev);
> +	device_lock(victim);
>  	dev_dax = to_dev_dax(victim);
> +	rc = down_write_killable(&dax_dev_rwsem);

This begs the question, why down_write_killable(), but not
device_lock_interruptible()?

I do not expect any of this is long running so likely down_write() is
sufficient here, especially since the heaviest locks to acquire are
already held by the time rwsem is considered.

Other than that this looks good to me:

You can include my Reviewed-by on the next posting.

