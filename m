Return-Path: <linux-kernel+bounces-58343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFBB84E4F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D8F28EBF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE437E594;
	Thu,  8 Feb 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJqbXUJ+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774A7BAF2;
	Thu,  8 Feb 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409365; cv=fail; b=lAeqx5X0uOW38Wd53ixW58DHom39hOmzvMf1bchyTj0DL0obyrcEW19iwlNfGt1VndxmkQE80732E9rRQb8/YFu5mSgdaPrMDr9s2C2FcEsO2bXXuF8i1KunV/tWoRnzQDisG3JEu4kseoKGqQDtneOvOeUEJx32xlciJMNqUCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409365; c=relaxed/simple;
	bh=HiG3vESMCs4OWQ8x6sOxmGdsfGqWfLGYpFTT2ubWlmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sEhdgaEBRoI0Hk06pCQLP5fI3dzaI6dNqxNRWY/eReoM15X2GN3bqS9RxCDzVebhFG6ZhPzqH+lk+CpRRdMm8m/qmwvYBCR/Si+rWBAIrohNl6aBz2Pqh55U311wAZ3oiMcQvFTHzBF00YF57L2Sc0Hw4F90I/6hn3isDJnF3Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJqbXUJ+; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707409362; x=1738945362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HiG3vESMCs4OWQ8x6sOxmGdsfGqWfLGYpFTT2ubWlmQ=;
  b=TJqbXUJ+Io+I2kPtIKdPOfpblTKDPkbONphz/jBzizuNwysBwC4N25Kr
   s8gdColfhcGP6TBMN4JPkhkWv3koc7IbLT5tNV/Ckpm8SehiFmoP/KgvL
   c1V25atBwLMKjG2LmJIr6tw7mnUt72CFqXIVwtA8LhppBTbXTLGw4Ib2v
   UfxlpHFZ0yeGsFB012gi2RYgTkjaNQ2qE2aVQNj6TG4UNiUYQfZMhp8sL
   8Q+IuH0E8dsybZgGXk6vHRqpG4O2+H3Pv7G4YlGzCCKhfkbtGss77n0zn
   AthbY5eFocBfh5GclY5Mokez0F53SMinrF18qvc92dFrQA6aojtzJnAaA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="436387936"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="436387936"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:22:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="824880091"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="824880091"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 08:22:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 08:22:17 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 08:22:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 08:22:09 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 08:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI8HWEW6ekcY77mFsHOWZjnuB5dXCwCr74nsWGDTbghEqW5w7+hcqCXiNYxO+HyEAsOyPqaYIqOy52Nz6EjvmfJN4CEdsRd9wepcJP1FRX7QCQcfD9y2BVq1d77msLIQ5JO3BH4AVeHJYTav0+/BmWllaUlK+EPQWdJIMrTroS20rOeXUlSp2CfM6EOkGYMvC5WFZLLOLRc4jYVKhd2P3PkT8b2oDW6g8h8bK8IMtDXBPgjk53CS5DPz3PITac0FqwhZJBeT9+QvCW0szJcz0eTSsTAxHo+47JHp7cSVJK2UfJZG0gaIv6a2IYBoyNnHEIxFX9aIk1+SEatNbKmfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpkeJ5oEX4gQ5+scbRE+MoSoYFSFkl7LJOz0FB7J/WQ=;
 b=jalga50OpJfSxgpK0QlBizYG2VT6lDCXOFog9a2e5pkL//aYClsy2cDe0ikR5opgEet3rIby16eVkMz6mDPKOAB1NMFS0PqI4omEEsMc+n8VzDNodLd4VVEnrsqeqOup/zDTsLVSz2x4UkJtEUHmni3epIArYtOO/7qn4FikniFnwadPh4PnNX83aEzKl7up74AoPy6/GuFKfDrF3uy1/Ntw/SxqSYRwuNaKgbAiyN6yrX6oEOT126x2xqHSGmfaoKHLAvBkcUJYYrW+hyuDhfdWkVegxcac7t4KntpYOc1hM/1Qv6NO9q5m/PNkLZktITnVZJl+zG7FCzWBEKCMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 16:21:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 16:21:28 +0000
Date: Thu, 8 Feb 2024 08:21:24 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v4] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c4ff84640de_3f44ac294f5@iweiny-mobl.notmuch>
References: <20240208130424.59568-1-fabio.maria.de.francesco@linux.intel.com>
 <20240208130424.59568-2-fabio.maria.de.francesco@linux.intel.com>
 <20240208140403.0000238f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208140403.0000238f@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 0193086d-ad10-4f6c-56c0-08dc28c200e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFpzx+kk0ARp0dIpD2c/iUGRM3aRoexMSBNRzajpfSKJxSZqWnLIwc2UJCLLCBwy3VEAkjMZ/OUpqYqgX0BqNRvNp/rgYl8OT7jtlgWhbB8ZJIZAkZKJVpgxrAOv+UjAC3T+g0p/mqwVmEvGxvN2CTMxLe2I7TeHZH36RwDXvS7o9YkjVDrMgoMlRE+7DabUIg+qKMVqwWQqt3ltVaZV9XGy6+Ky0koiJkBp2sAYJ0f3UMytGIFs4BCVbXqS0J8rg5jsw9p3xHDM/THX2V+u2Sm7O8tDPANMVRpkD1cRGyLGiLm/WBqxnYPQfVO8XGLSeUZbiqyt+L8bfFKDcMupeelxx5YJuHLkWTjtAV80iPxqH5rJtvp1CiaUc1m5QTQMt+ONXyiF0kD83ZqrskFQDdSjavetaG/nYmWXULWO3CmicQ8GbgxauxKnAWdsm61dhGiTSxw5iyINAJAT7L8ibg3P7cgIesI0rVIBGuW0EDiKVaxspIxrqro5wGwka/FxI0LsYS3RfecTMRaxJSSA2E4PePD9TY7XFd88rS8hQgW4E2sowvUCmRWzNxbPGAKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82960400001)(83380400001)(38100700002)(41300700001)(6666004)(6506007)(478600001)(8676002)(316002)(110136005)(8936002)(54906003)(66946007)(66476007)(4326008)(44832011)(66556008)(26005)(6486002)(9686003)(6512007)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iT9AVBBng91XyY6Lp+Dm7kfN1CiK88OmGURoMBgYdNFwOziGUGp5YcPbFncR?=
 =?us-ascii?Q?vMRVjdRCvuevceVOSRkec3N9+tJ+h47Xr1KZVC2r4ZT6TzIIun5UdKcIR+fO?=
 =?us-ascii?Q?yfnRvHoUcqfYOWZ5zScijT7UWikfDyag2Ikh7NnJm8xSfFPOL0ULVAqWHlr5?=
 =?us-ascii?Q?3RPkXk6JuI9eAqUESLfcaRwH77XYaXcYiXIuGY+GgYNFlwVn+6+OzjJuDw36?=
 =?us-ascii?Q?C5O+gNaPlqC5/8mznIHHWECMxxKLZgGm+RSYB7jYhNDgPsYXsFT7iBc6lwfa?=
 =?us-ascii?Q?2nI7FWPwfoysxbpBekRK5w7S2mVzINbIo8FJJI4UI+btezoC+6fhCtNkbil0?=
 =?us-ascii?Q?sO+Sgc+iGUrdwRzdTQ37nQ7zc125kmiqCHaC2TwkiBQQgi7RMhI3ZfR8DV/R?=
 =?us-ascii?Q?HjsWUZXrrHiMGYkkwvE92i0OapUH4WxgbG3QFTQKie5EEd43oWw3wxRKfif8?=
 =?us-ascii?Q?t3XumKvVUqtWjTez+Pg82vBz0nASrYUTO7MKAaWrtIKi53IJeJC8fmAdI26b?=
 =?us-ascii?Q?QmScIk6sGT7PIFhWszLqNdVwINXoX4by3+uG7l6QRYotSEd0rxWKxW3nFlFT?=
 =?us-ascii?Q?7sk4ivf7TU0YowD7ZQqk64/QLFx26AkA3pAQkiMhUqT+FJHGKcTiHcOrV7mi?=
 =?us-ascii?Q?JCLZ6u37xWhtB82fIDE8p28oxQMYZhoOxWLTrlYD7bkzupqcFhMi5l7UdY3l?=
 =?us-ascii?Q?1jwovM0fDvwsJA0OXaB/wEh+eUHQlQvoLQ8M2E+jH+YcpOBxYC9vsek35qIb?=
 =?us-ascii?Q?LENSZDGXUlNvWq4pJIeDLgr6Bp9AsAyYvkr6rsuxGleyP4wMZaj1kYK53yJn?=
 =?us-ascii?Q?5D//oUZik76AzOppeG2sjrpu292Y7c4BfNw0yucZAW9d7meUpwHsnFpMP2br?=
 =?us-ascii?Q?o3jFi1GMb95eNP0JQJaFHuESNtVgxjG+9NTe+yx3bJjd4K+UAYpKamv+IyKv?=
 =?us-ascii?Q?fQbVlVfgJbPvFfg+9c6Sl2Y4+NsL1J4A/fR01oIntxv97TfUvWpslDBRV2iw?=
 =?us-ascii?Q?Py6v32Vyq6DHrtZo1PdsGZ42Gs1zXT2Svl81mf/5dESpWRPSGtbcc30+O7i6?=
 =?us-ascii?Q?PILDVx364vuUzm15FJ/KcoBqsLj4pwZGaSwNGMeAzUm5RUs0fciweCsN2OvR?=
 =?us-ascii?Q?y6qEN94tGIeIyrgoS1N1LW0BfAlbIOcWIK+iaMROQAMo7sntb1Nb/HsZc++N?=
 =?us-ascii?Q?LMPKRvbiGBUsGYFwUuEo90C+EkvM3CnesTcGPX4CjbddLDQ4ZzT089olVk9Q?=
 =?us-ascii?Q?K1GyLKseX2CZJAtrxvDO4+N65AI58cbdmwqrfyJL/jKcRhjnYCTRhs3jvRZj?=
 =?us-ascii?Q?diAac3Yo03KOPBUG4ETxHLHtkLUNCrgm3NJNueBn2g9+mLTfkc8Y5TlIybnV?=
 =?us-ascii?Q?BCeTKng1ogACuRM2iuROBnp4hv2bDFmpQYhSl503hNb3jhNmsCI1g5DoQR0I?=
 =?us-ascii?Q?sepIV1PMdZju88ceEl0ANsjS5E+R9swj+E+r//+Z67IoIeb9iDCLf6BfVXDQ?=
 =?us-ascii?Q?pTtVKMIHqHbRdFxuDeSSwvf8L0XTuDtCX3elOeMANWvMMYnFTga/caeqvXjV?=
 =?us-ascii?Q?g2zxYoWFLR7BlyJ7djylTLNACBVnjM2SNlCYV0ZQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0193086d-ad10-4f6c-56c0-08dc28c200e3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 16:21:28.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02BVOxRlZ8buQXVNwOj+TcqbSNlG2JIo6JSZIaiCVa57h/Hj4kpmJ3KxhNAUODk/1cz4NeMIPpYr+wLryHrPPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu,  8 Feb 2024 14:04:23 +0100
> "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:
> 
> > Add cond_guard() macro to conditional guards.
> > 
> > cond_guard() is a guard to be used with the conditional variants of locks,
> > like down_read_trylock() or mutex_lock_interruptible().
> > 
> > It takes a statement (or statement-expression) that is passed as its
> > second argument. That statement (or statement-expression) is executed if
> > waiting for a lock is interrupted or if a _trylock() fails in case of
> > contention.
> > 
> > Usage example:
> > 
> > 	cond_guard(mutex_intr, return -EINTR, &mutex);
> > 
> > Consistent with other usage of _guard(), locks are unlocked at the exit of the
> > scope where cond_guard() is called.
> > 
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> I like the defensive else {}

Agreed.

Re-

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> > ---
> >  include/linux/cleanup.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index c2d09bc4f976..7b54ee996414 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >   *	an anonymous instance of the (guard) class, not recommended for
> >   *	conditional locks.
> >   *
> > + * cond_guard(name, fail, args...):
> > + *	a guard to be used with the conditional variants of locks, like
> > + *	down_read_trylock() or mutex_lock_interruptible. 'fail' is a
> > + *	statement or statement-expression that is executed if waiting for a
> > + *	lock is interrupted or if a _trylock() fails in case of contention.
> > + *
> > + *	Example:
> > + *
> > + *		cond_guard(mutex_intr, return -EINTR, &mutex);
> > + *
> >   * scoped_guard (name, args...) { }:
> >   *	similar to CLASS(name, scope)(args), except the variable (with the
> >   *	explicit name 'scope') is declard in a for-loop such that its scope is
> > @@ -165,6 +175,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >  
> >  #define __guard_ptr(_name) class_##_name##_lock_ptr
> >  
> > +#define cond_guard(_name, _fail, args...) \
> > +	CLASS(_name, scope)(args); \
> > +	if (!__guard_ptr(_name)(&scope)) _fail; \
> > +	else { }
> > +
> >  #define scoped_guard(_name, args...)					\
> >  	for (CLASS(_name, scope)(args),					\
> >  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
> 
> 



