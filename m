Return-Path: <linux-kernel+bounces-163223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6418B6760
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA381F22CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF550525D;
	Tue, 30 Apr 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El1bG2yX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC581C33;
	Tue, 30 Apr 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440244; cv=fail; b=jmaZ1lDxtvfafOErhuEFxIkQnS6GgZjtk0RGZyRV1L3VumO7SPQe4/5zdIpxtUpbTjdjNgOdFl5yvhFDoqQpIKWx6sOq0DP7XohWWTykguqa0XPRdHAQiwzMVIBhHegFWubR0xJhrf8f7FQXvGefUg7iUMDcKPOO6imB+C4dlmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440244; c=relaxed/simple;
	bh=okZnQo+c+wHFKUkmmQ5vXAnUBeG9b4SoEe5PFBmrW9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L2OfKz+Lk6IZxe9o3k7/li4jx3PwE5h7xOb+hZIJv8vG3Fo+QVUjXSgqyz41AfYPjvW8Ur1XqKsK7tFmUx4BLGSPKtB5b8QsuQAZV4qSHGg0A+1B2kv7tcBgwXygGcryNwCEl7jPAgBlWrhiFyInCaDriqxKrOGDQRsrPh7nx74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El1bG2yX; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714440242; x=1745976242;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=okZnQo+c+wHFKUkmmQ5vXAnUBeG9b4SoEe5PFBmrW9c=;
  b=El1bG2yX/SseRuy9qpzCk5bqd8GIUiAf6iuKs0s2JT2S1RRl+Hxerj03
   cpkXR1qFxRD60jEaB4dX0lTJDEbNX69qyQ1kX9i2iairNAP5cvD/DX+vQ
   f4lb7qjJltBO31FJfSiShXNpbXvEXkCz3pAYhRmbZKMLTGtFFr2rGlZxK
   xBzOqiC8CtYdvm1MVOziR7BPNfGBBoCXj61b6ga54+QZd8EDmQMsMitaX
   UK+Ff08HqFR3Z1RM9rtu+fGW7FBuNYeuMHlxNiU6ffVgUckjSJ4pqZYI8
   sxrbJJwgHMVc2UuRCQ/5BCUsFyC5e+QRZZROkn5yYevj7eq+Xwi8pHXGX
   w==;
X-CSE-ConnectionGUID: CHCH79W/RJuHokTTrNf7Vw==
X-CSE-MsgGUID: nBicA/jnRzibm1M0sal0xQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10002227"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10002227"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 18:24:01 -0700
X-CSE-ConnectionGUID: nMkGle3yTLKVXNP62q49Pw==
X-CSE-MsgGUID: oCH6pVAcQG6UMlUn0MH0Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30762609"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 18:24:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 18:24:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 18:24:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 18:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et0M/FRR9pEnmUb5cJh7lsngQiywDNK4Sb4L/1dLTLA6BVFuOTrdXkZh4ziVlUD3KaSBPcdE6UQ2eTz9UeMvZTQSt5wHhRFlbAbMBqI7fIAYpPRT6Ge9rRce/MSEmDJX5GNYLYCECgePY5ISOCXJS/+ri2vZhPKjvHgpmaCoav+BdNR4qElQnF5kGFHtkESjd9i3UZ8An5id+f67BG0YXWH2jFm1WUrQMlyrsqZS/i/bCMXajdoAm1+pox7p34m05u1ZzS1lnfRgV8Hs9/a4iTW88kKHcOs1qphuAUaYWIMvLiB2YxHkOaAGgiLs8/IsEYYzBS/rSvF5zeERNY+cNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awogkJb6JTo/ZZoQbp/XIo+++I6hS20jm/UtmM2GpF4=;
 b=OLEUhuBLciclwSLh9oJ9o3wpHtoYA6nVxvnaOsp67pevO1hS2SHcGvMOIEQPhkt3F94rg+o2fhqP7X+vL9Gnrt9Xr8bKt8QnT9fslQL36LPvEZwcZMvcF5fJIvYTry5HwyVd2buYUpiSMqDMBX3QfZ6Q8am04Tqosy6LX/e/533cufsYUd8D18Ji6KL/WOu0LTAMRLKKVFKA7NMFVU8hllqBZ4G58wTKZa7ZAJviMbz+Sip/K4K3kRkx9mlInMVBO3hB1g+eYP/fXyQDONCfA7CeZmIVgWvfizMz+UwPjEsG+X2eqqFLpzv7TRtocjrJjEai5c9JryaeZsN4hBRb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 01:23:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:23:54 +0000
Date: Mon, 29 Apr 2024 18:23:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 1/4] dax/bus.c: replace WARN_ON_ONCE() with lockdep
 asserts
Message-ID: <66304827d2095_14872943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
 <20240416-vv-dax_abi_fixes-v2-1-d5f0c8ec162e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416-vv-dax_abi_fixes-v2-1-d5f0c8ec162e@intel.com>
X-ClientProxiedBy: MW4PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:303:b6::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: bb352971-4e8f-4150-55d2-08dc68b43323
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RoYcEL96eIC7wSZ8L35jQQyQCUCYx5kYH5IAmLEZ9LTanpaJ76RLpaesLK4S?=
 =?us-ascii?Q?R9d24wC6YDEV0ip4o8MHYrxruMeuKLRq1Uhu1CkdjdMbd0LANJUOKtcAhP7k?=
 =?us-ascii?Q?BJ9Ynj5G4V1aSCJUoCEvhQyz17CiQ9B7B/7V9td4MK7yOZrwqWyw+ASlrqdL?=
 =?us-ascii?Q?eo1ATX1wsHEMHI/C7qfXeIqumyQBXbEJYiUVKK7NyGmL0RR+O3SmvPK2Q5Me?=
 =?us-ascii?Q?R8UHHPyHEXmY0cqfiStEaNaTDEB/Kb4VGO98v4caK9+Gwk10ygmilSHe0Iog?=
 =?us-ascii?Q?+s17AGXDQovV17ub7SUGoo+zN4rOG4giDqdrFVW13nn9XJaAgRsil7eiUcgw?=
 =?us-ascii?Q?VsEyRZnO3bNRmlzTneHd3b9ed0DlbWmfz722PzuKJ5ZUjJDbGvmz+nR4REv4?=
 =?us-ascii?Q?Zd1yM31fAXXlMPD90rPY4zmrQqpc268GZzgEuHrERj1WuHUPAA7b+cxK4VPg?=
 =?us-ascii?Q?CoiZiUWGtGJO3Y+SjVUWqMddxd0/it0sl1hp7sMMA0Ow+VzkDkd8xM3b+Zug?=
 =?us-ascii?Q?XbiD85Yooki0h4EjtdIe+862EXSlCdPdyhK7yXxJO+/XH6Qan6kU9Rh75TX/?=
 =?us-ascii?Q?M2RvVYXU6oazLmJ3dEglNTmGzrpHlAb2EqUXiH1WKD5CQvIE+bccEusZjGNN?=
 =?us-ascii?Q?83Jtye+EHmRutpUwP2H2vL2eRNvvqDYi6FGeQj4xuO9YKQrKYi08VKDqZ2Ij?=
 =?us-ascii?Q?/NdahQAJU10/kSOIDPKSw9zgWYx5VZsTnhCNAcyeK/RXTW7ueV0NAaNjb2oE?=
 =?us-ascii?Q?VlX7gwwJG5FaSB6U8mDe19MjhugvB8Ud0XU7GorULROsryY6ImeMH4UATJ9I?=
 =?us-ascii?Q?atZUegpXW/vvGRyDvAxAyJtWE6rAR3YNB4puDDDsdVnGM0ubayRwKHxLbk5f?=
 =?us-ascii?Q?V8qMufWY98n/K15qqVhgZqEd7IDAFNdUdX3WwMvflHzEWjA611JTSl1xYOYU?=
 =?us-ascii?Q?z9qUegUh351EXnLFlO91m9nYk34h46rZnT3G2+GghGqrBJgb+B8e99vuJyOd?=
 =?us-ascii?Q?N2UhFoFycwfPVI5PIcXIWS8toW/3N6oqbGJRiJvIkVv8QrkqJJXtjGmhUnaZ?=
 =?us-ascii?Q?exnSzpWzOAUVLHZkG8jSA+eekK310bElzp74NNQCorpqgipGQq2e4zPgD6ux?=
 =?us-ascii?Q?Z3UQHMMLxzqNshD32PeS3IpTbaDZk4RmM5Mh7Q08ED1f071Xmj1G8J4f93d9?=
 =?us-ascii?Q?4cUcdANWssFcy9yQZdCzBvCVZApLhz2RZ7L3z75OSG/7B1oqXdN6+q8Lfps?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jySzYJdCBGNTCUMzEQ0plU3pdEXSwIoLs2Ze3bEEdPbaKpHGY9eBseZhAsKk?=
 =?us-ascii?Q?HCSqNbstwLQwkV0RO6Iuz41lZYkkPyWNw0yHTHKhkrCUVVK+xTuW4E/Aow/2?=
 =?us-ascii?Q?y+gS4vKvk5+2xXWNbCKDWRiEYdZveit0pRfGqOpxA9ogGAqrsq2k/keRaYWD?=
 =?us-ascii?Q?0AByDZGKR12ADoQhpvyV0/7XMFKqRg8GKS28pE2g/yaomhto8AqU4T7gi1fN?=
 =?us-ascii?Q?1Of7o0auUf80D/3lco5XzWZjSmEigcQiEIweKd5Sh6RoMr4vUoew4SsbnRJ1?=
 =?us-ascii?Q?uRnQiNx0lTH2LxeTNRpNddDqbBj9QIwbH5ji0G5/nJFRme2Eg8zBPJOmUrYF?=
 =?us-ascii?Q?YXVIN70Lq2YyC6Lqf6QsibYhveVWb9c/WY4FdgtTzn/kDaLfKgpuDb/7VMPg?=
 =?us-ascii?Q?+DMM94ZSMiYagQxnIoKaXTk7Gvf/tePdT0fV4yHIHidOw6XF9gc+6/u9ray5?=
 =?us-ascii?Q?RjwD6onKHDwmQCRsabLGg/I4onO3UkOFH/E79b5AheEgcEvyTz/cmcXbxHG8?=
 =?us-ascii?Q?HoKqZQD7As22T/SgjlA/Ty1bV2USEFU7XXMLUDQbTBjkys4v88I8dsmafGNT?=
 =?us-ascii?Q?IKlNSrD2hC3QfICzKDWipjMa1A/yN9txebq011mtgFEd+ysavG5jsAlTrtLL?=
 =?us-ascii?Q?VPr2uaqZolCkM+d1zUPI6ZcD4CHMmDLBAcE5eM/lKXg12ipeGli/KUtTPFKa?=
 =?us-ascii?Q?RjPfpkQD/NiRBVwYP7a/NF7Q3MrMlYWc3tj/oghXjshJDwVH6VHlORVurtC9?=
 =?us-ascii?Q?+zl5OAWxRudXObPs+fslmEbf6/NTWVC1fj586ZudMuqhgzFUmyh4tHv9Nend?=
 =?us-ascii?Q?xlLnxDl6fpf9fyX+0A1txJp+iqdMJ7R8EkBku9H7wyLeA4MJJAybU1VEHDbB?=
 =?us-ascii?Q?r9S4LmAhmBHGePXGhi1Ft+xuiuZ3dUP9doUVnSxj5zAVNvI2i/S5b/lVhYSH?=
 =?us-ascii?Q?+kLTrLv8i7qmh9A3d8L3o3IGtCGjwj3bW5WNW6JwOH0V63Z5A6a2vNlPwhOP?=
 =?us-ascii?Q?KEjouu5TzD+7TigyVCviwkWfcFlyjovUu6QB37dqQs4DSJBL1LBQP05fWzmr?=
 =?us-ascii?Q?tXSKePB8hl3tPa2iiaoLW31athJoH5DWCL4OzGXfSTdN6vDnVLbbwdiJGxVU?=
 =?us-ascii?Q?XwIwJ+qopvNzYldU3aNgs8mm90Xqgx+NLSXQpCjMqx9GNsRUthwQzWi2+stS?=
 =?us-ascii?Q?QyaADWzq5JtbvlV5xYWsdN8wCHwRWUBfJWnrl2H+GjaBWP7Fvp/QxcqmKmuN?=
 =?us-ascii?Q?IQikiRfyFHnJ/Bk0XXy9pDQJH7rbUNLtsOy+zTbLi9+U49vh3Hasr9LXaobZ?=
 =?us-ascii?Q?cDvbUOyZM5+yry7sH4i57MnAprhsyfeIDtNSIQATJ0lkH3E7AmNEHRNvFHFL?=
 =?us-ascii?Q?pykgNRTPn7sWVfPT85m0woDvx+gyHbFsXdjHHR4feqP46NvzT5coxa2YVb75?=
 =?us-ascii?Q?KLjR34cerfudTjFLm1pwLeu2I4FZOYBTYTJkA2Zl448W1jyaRxAR46LD/iAf?=
 =?us-ascii?Q?Yj/Uxt6nocA0I6r0EX5pYZlrPc/c3PYklKrKbJvZajrmHotCIMHR3rSK8QGU?=
 =?us-ascii?Q?Dpgoro6vOzDWGEHL5xF8k4yyF8uffdmJY2fORNCXMsIZX3HQlXRqItTHMag+?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb352971-4e8f-4150-55d2-08dc68b43323
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:23:54.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i/3hqKpMsCnPXeoAdBTFErYzLZfbDeHc5G/SgKQO4W3B9SDYEmoyOtPDaQ8JSFTYTOnNetzWP5yhRtWn1OD05eHHHN2PfZS9plVAUlp3iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com

Vishal Verma wrote:
> In [1], Dan points out that all of the WARN_ON_ONCE() usage in the
> referenced patch should be replaced with lockdep_assert_held, or
> lockdep_held_assert_write(). Replace these as appropriate.
> 
> Link: https://lore.kernel.org/r/65f0b5ef41817_aa222941a@dwillia2-mobl3.amr.corp.intel.com.notmuch [1]
> Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

