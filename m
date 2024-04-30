Return-Path: <linux-kernel+bounces-163226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CFA8B6768
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D481C211EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E54211C;
	Tue, 30 Apr 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJNNpw3g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0D1113;
	Tue, 30 Apr 2024 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440365; cv=fail; b=V/46nHGjQnxRHKPA0tM0IWokwLz3OBQvIHqqZ3JEUrk/tCVRLg6KjP5kxPSk2nqkdvTLizkeZ/xWSX6gZdcDXunb5/iU0lsw5lf7UKkyB4TP1ZoQMASCxlB71ZffUkt8O6UMqRzkAuOwR6Ssw1OtnGHEiPG3YpGYcoro2RX1fZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440365; c=relaxed/simple;
	bh=j54XTLRjpFaTttnEVfaRxXN1W4d60j9Ddn0LN8mpwrM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YeD2LhtObOiBi10ILcsmagkJGya59wCOzfsAk5+4hmwB2wX/tsvEHHLUdta7+RUmvk/BYYt70Mys7X/i60PskOUM69SFmeSEqwGi1wFj2baHpJF737C3xqsZy79BG7iuDb+lKBHnpJLQ6ZIdxhlFVL+i45V8Hxtiigv0nQQEdno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJNNpw3g; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714440364; x=1745976364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j54XTLRjpFaTttnEVfaRxXN1W4d60j9Ddn0LN8mpwrM=;
  b=fJNNpw3gUKCYBeF8E4L3RgJ+NhsrUchZ30XfwWJ/gn2i2/PMMQReRuTF
   RItLFZ7OuNrEveUFDPKQfZYaEgImJ6ikPC0n5wExel9D+OA3qkD9rS0Jt
   mpmchpBlwrLnpTXA2stcd9ze2jTLjljD3m9uWqRr8KW5qBzxhs14IIuwu
   Q05IXdht6W0GTGdxmG3gToR9RGJ3HzMZ+8XsVQv4MP7JG9VRUTHdMXZIq
   t2dFsDj5gQhdgjPLhNqF8KRJfJNbV0Gq0E9ULRLkWkuKe1zFx/HPz6o56
   avY4/lVX06xFKQM+/R4hNWOxTJjOsIjkLg2GnejxEUEXT6vS0zguAFP62
   w==;
X-CSE-ConnectionGUID: 5DNce8KUSqWgZamGK0CDNQ==
X-CSE-MsgGUID: O0JPLJCiRWynDmxbxd0Bjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10002389"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10002389"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 18:25:55 -0700
X-CSE-ConnectionGUID: 6kcStUEbQxK3hiAnIBsafA==
X-CSE-MsgGUID: KWOEVk/mRBOuOI5eeafVHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26156905"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 18:25:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 18:25:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 18:25:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 18:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbYz31gfE49doaWFuMzNGY4Iw+MRMslUaoY820mPZna/RAAo8CHZJfRnRcu9v94bl6CRfAWRr9CkHalmpPxfj5CVYzO+vgy8DqT+ux7h/Hz2cc2WslvsLp0p0+pvMqP6By9PWLaa/leUigF8HjvIxP1eqMw3NQ75kK6Jo6MeGepnqvrvKjzokcf1XQtFGVtgHm+oKlr6mCynHKgDVBgtWJBjkE908SJV8rYz+Oy+4NVGD8RLT4hq/vYdD+fq7tZMFSWs46heJFfzUWCGkKPj0Hl25avN/H8Ky6BXcZk/D1eYkYm1AzwBxuBoZeszBachosLiyrKJd+GTIyqH/zZl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRtAMkeiXbbJS4yZfUM4tp205ZtTYaHA2TBDB2izwLQ=;
 b=UCiJ53XN8oiKZP6zU5oYgwuzWoFcZ0UOCRkWFzBghh415Frer2bJS8GJRhG7xcAqDGwBogPrrgvZYVPKQIEhnwkYWIqLI2TOM6VI7SlXM9ECRKO+sCG1bJspWTLGuwbMXdijRUHglTq+tLDCD2BEKFli4XwEryWUw6KeizailMi3PNYzm+GaNJ6qg0FeFo9iEB41Xy/RctNtDiLVIQWOJKKHpTEYwlLpFAv7E0Vs8s8v4deihjwc4mS8XuzpNv64B6UVSGmZQDJ34FB+DSERSbcfRZGJAFHyG1iSb70SlhGydfsiK4SZQvaHyN42uGhmK+4Kp/ciTjzyrt6vlYJ6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 01:25:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:25:53 +0000
Date: Mon, 29 Apr 2024 18:25:50 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 3/4] dax/bus.c: Don't use down_write_killable for
 non-user processes
Message-ID: <6630489ea2b63_14872949@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
 <20240416-vv-dax_abi_fixes-v2-3-d5f0c8ec162e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416-vv-dax_abi_fixes-v2-3-d5f0c8ec162e@intel.com>
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 433418a1-6f51-4b91-76e1-08dc68b47a07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5kvGLvOWC8+GRiAW8GRj6gysXWvCop4GItnxKeB9rD/c74eTjpmSbRS+6tXx?=
 =?us-ascii?Q?5cEygzQVHqKfGYU+qMJWa7UjEBlL3pURw6IvNVbPXCuTCEHBaLx+ZKVYicxq?=
 =?us-ascii?Q?y3HCHoyBiuIuX0mEYv9ZlTHjFtDwA1rVq4xCWCE7s84v6pLGt4rYXueQEzlL?=
 =?us-ascii?Q?wcOigkTax7WMSfo7BlV/e8+FsmNz6rYbRyTsGrhrAf6Ku+eyT8r9uJK8HBHR?=
 =?us-ascii?Q?haEfdBV5N1yU88mIMtZksveJqGJeTw9VMgJJJyrmrlJSqoM70ndl2p8diLJs?=
 =?us-ascii?Q?EqP4EBkyTexg0ewiqEqHEf+l3RkSdTjjCsbcFrkt5tdGxitDpGdnll6qBE8n?=
 =?us-ascii?Q?zfVXOzgr/3nXxVE7yiTMj770knjWw0BVcyKSsDSCB4e8xjAhsdb4Dd4O9j6A?=
 =?us-ascii?Q?QpoJ3WSlxgmpnZKSHJb6Hnz6kyP+gK+sTHhb1tjxXMqTk3TpdjSAMtrthOFg?=
 =?us-ascii?Q?SlpWdvPHLkOszXtuUwO5GouyQcSKjwDeecb/MfechIxXCJfgMcunKv7WyuzZ?=
 =?us-ascii?Q?SXpAiU/Ftp4oTMSR2PuXDkQw1VVzFbEgQVVZDFrBrqQ4us/bta9m1OqDRPTp?=
 =?us-ascii?Q?saq7xcKzdjfGmgqtlHbWqkBtcGCizyYSLDTRIbwbk6STp99z1QMOe6N6zRA6?=
 =?us-ascii?Q?TLGd6nMko/5yhEE0TLRHUw4FzXesg59O91sx0vF4zdZ1cAWOgOxXNG5q/m9w?=
 =?us-ascii?Q?gW8pN89C/9h4p8TlQocR1UNKvbjieRY4pBYe4uKNhzajoXndqk/iOR+urcLa?=
 =?us-ascii?Q?2xgbRP60aeJmLhCxRvg/lkNs0jjw03+LwV/EBfVbm79q6JBRi6H6/xMzVcqx?=
 =?us-ascii?Q?jVHCcyZeQJMqemMxAGv/ywCWPvWPRzVoDvHdwwSBfebMo1arISFZ2rdDfOk1?=
 =?us-ascii?Q?xUJff80q9AM1AQmcr7t+8oyzUvk7kqOI+JqBpafAooe15w5nLi5fczNEncSq?=
 =?us-ascii?Q?z7Cozjcxf5nYiCj56RUBpKmyASII3kQ7qZWSe7z6vS4hZCqAbE+KC9tJCjUV?=
 =?us-ascii?Q?Ou5hYNCrHPTDMWSkK8aeBibZ6p3QU+04URcDcAXLew+Kcd5HJdwMBdjd7Raw?=
 =?us-ascii?Q?BBCL1jgqDFrFJjt7WHCV9wJQjGx8feXMaxmGbsSUae7XLdVFtmQdem0Jt3dW?=
 =?us-ascii?Q?rUyoY4jAdqAHG4XwUNSh//DvopXM0etANa9czExVz4GQa/jkw2+Na5WwAAGt?=
 =?us-ascii?Q?4hQ8dUNgJ0FZbourMxZiWiI/cBlP87RddXJfOATx6/tkP0jGLdtQg+fcxeh9?=
 =?us-ascii?Q?SutOm7O8aEIrdh8r/nVLAWNyflH3Zh2RexOu06bJRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJksVOuKiKU+f+KVzGPkn5JQigQR/2uEfT+f3tx8D6uRmkMQbZw0BP0fmlrI?=
 =?us-ascii?Q?pEXycMJaKDlvKgBRj9BnDTzl1lUGDNVBEGQZmGhPNQxQcCkHpzDiolyOUBQd?=
 =?us-ascii?Q?fO0Cdyrox2DsKGbm8soQ7RWoqXEG+eq2kORv5hOXZbnx9drEbhqCk9RIin7F?=
 =?us-ascii?Q?B1JNTv9SXOf/TJ8mLAGEoLroj0AR79PXN58WKFo1SVCky4qPmfPdTBi1lYRd?=
 =?us-ascii?Q?RzSqde1+6NEBhcMSld0FQEt91u6Q91A4J/XvQftg5CAliC26wWvcrR3gGvue?=
 =?us-ascii?Q?k2/3a5DBiD2zSgw7FJZOZ/S/d1vFEU0xDqvA3fJT+VMcmMRdiyP8DdpkikbA?=
 =?us-ascii?Q?lYg21Xw1akxZ7v2COZSykIkNXzQE8z4X7IbptbqnZnfAB+mpQnJZg3HeGH+G?=
 =?us-ascii?Q?Av8oASq0Ysl2KmnsFAgi6b6ArXh+AUWMJntZtZCIxbtE1DyLbHOoNi+TcTCs?=
 =?us-ascii?Q?QCjyD97HJ/Rz2/wZ43Kvec3lC2CgIMPKcxccREdK7l9fe0qvnAkFBtG30yTh?=
 =?us-ascii?Q?GR3Oj5gty6MvTKQoHAQTr2hOUT9hNuQh6T1QH8HC85BJstXrrq4uUYugQLiV?=
 =?us-ascii?Q?GMI2/dQ+dPWlUmZbQdN4sAwVDCiALbw03aVlnu2nloELPFomka7512BT5Qh7?=
 =?us-ascii?Q?3Df0PPR+CRS9YwJj5xwDS/NjiWR5MCB1iFd/9l/T8jcc6yFFQ57+qRD7e0lm?=
 =?us-ascii?Q?HF3Bk2Th1yN2uzysMgKHJAkmvGYe/4cQ7BAIBIV2W0t6NGkZ5hLh3jKrtuJ6?=
 =?us-ascii?Q?LNIAgZ3DhRRbBXPF9avZBYobVijOWuN1AxNxrHhL2b+8F5gUCrFQ+ewND2Le?=
 =?us-ascii?Q?bvEZgbs/qdQyzFP67wT0T4R+DumqmjRQMVy2RaH1kSR38tFID0gW2oFqZ9tu?=
 =?us-ascii?Q?EspCadkjWaVhjUxzhaQUz8tN2rVZRHbtKb7Uni2qH8N39R9wB+/5+R86oChj?=
 =?us-ascii?Q?pG67MsdLXorRUKVdW6YDxbA2bWkWWCTQleeefzXTeHDSfHqyn4UkPnpq6WBd?=
 =?us-ascii?Q?yAZ6ogih7fBwDr8dldGwMwqTqTprrYeWTfmBhhJaO8HHbGborFf69nufXr8r?=
 =?us-ascii?Q?f0rmN+Cve988+WXblhQFeOCBqQgjiRmdJlH9ouAdoxHTQtyVlgiK9tUBPJEM?=
 =?us-ascii?Q?HvOH20Vnjo0PtKVJgUKuSMyIy4gbaj81psuEL3SHVM/4scVlylimfurCe8Xn?=
 =?us-ascii?Q?TnCE9T87i6abjWjy2mntvkdgVhSt1zQRUCyLRwLgBzPVhDIGqhn4dnWgCVdp?=
 =?us-ascii?Q?+RIXpyKeZOggFaNbKgsuxNBPYsJkrhjLgUmKRtGBYUxqvUhkKqtS94vPTseh?=
 =?us-ascii?Q?ngJ4TLkXGf1Is42z9c2f32SEtwWK2hDeSBIGo9T7DYVLpwooW9vG3euiSTeV?=
 =?us-ascii?Q?bFnel4BQw2cKJgYb4NOlcdkJo0DI021uLwqxWCidiM7Q2D5IphfKa8yttnda?=
 =?us-ascii?Q?TdjX9k4CVvzh80vR2m116LXPMH0u26zxBf9nriRcsexPKwohyJKtApiJ8Cj/?=
 =?us-ascii?Q?4Na6VSQLkhfLU8ojvk9PNwT8b6IzpA222L6N91kCJPY4TEsFniZG89pqBMBS?=
 =?us-ascii?Q?XBfuRHPHf/2WLojPveXJuG9dyIyLEAA0cL8ZyKx6GrSGPQw0Ioo2JKLubvb+?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 433418a1-6f51-4b91-76e1-08dc68b47a07
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:25:53.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XZ5m+k0JE1Ajtg+dbESnxQYhC3GrpOnkv6mAzRbGl0M/7nnooRH+YjK6lNJDV9WpT7LaAIMTAO/FzhHqNg67ZFLaHd0xAGP4FatQqxaJMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com

Vishal Verma wrote:
> Change an instance of down_write_killable() to a simple down_write() where
> there is no user process that might want to interrupt the operation.
> 
> Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

