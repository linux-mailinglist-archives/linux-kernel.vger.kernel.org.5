Return-Path: <linux-kernel+bounces-160367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800488B3C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94AF8B23205
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0C152DE6;
	Fri, 26 Apr 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3sVjG65"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AB14884B;
	Fri, 26 Apr 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148216; cv=fail; b=hZp3ET1C/IPCIPRA0cznJ4juBju7j0k+GKG9tjJpGedN0uMKK9kjE2U6WSK7/B1T36AhxR8wtVcX0F2i1r0IVOKqiTdpc/aea+/0PvTdE2odPcy1RnQid3icuaNZqlSkCG3I0vuUoFA1QRKt+n8JzdKx3mhsxzsxfuSzkAdLowc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148216; c=relaxed/simple;
	bh=wDzzwAgHLu73DZwJ6gJh46hFuDnQdodzJIeQkZlEnXI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gjgKCL+82A11/BsCSqi8+qyjRyaCiyWRCNPHv6h4Rh6sdIyLDGPMRzt/mZSpDm8xkjhPnAeY59O+2QvCPXA111lLsGwm0PKPxD0FJQ5vugOd2mg+FORVD65vw3ioNRFloVTpqA4qLtZjkeDvmRRws+yBFeaDEQUY4ZRrIjfilP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3sVjG65; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714148214; x=1745684214;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wDzzwAgHLu73DZwJ6gJh46hFuDnQdodzJIeQkZlEnXI=;
  b=H3sVjG65MkGmOmtIedHgCd9CnL/dl4zXcKuPfX1iN7Ixh6BamshG+2Vt
   LI+z1WrNe/D5jYvh1nxD4h+8QeG1yeSlYOFvZA9LJTOslovqCWxV+xto2
   BmxsPtdVB+6flQUNUdyV0QwQMu3p//17g/JT69wk1hJuxHA+Su/+Merbt
   hU0b2q6fHKUiMhj5QC+PefmFwbcA+Cc4u1+bGV3zyhQNpc82KIV2da7zt
   iZj6wokHF1uI266GIIs2EexkCOM5UDvzW8ozo1vVvsazRiHoNW++Etz6D
   1I+5tD+Ye2lfMPsZ/WuqaNRfV++wzIm86hfFz4daYPE247KaBcJ6KAX1h
   g==;
X-CSE-ConnectionGUID: /V2/jqfQSvWV//ipx3ARbg==
X-CSE-MsgGUID: ymSh7mKBTQORHS+MY50rEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10421783"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10421783"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:16:52 -0700
X-CSE-ConnectionGUID: Gi5jF28bTqSvTOWxjfjLSQ==
X-CSE-MsgGUID: SIF7CAjMSouWRqw6l05ktg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25344775"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 09:16:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 09:16:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 09:16:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 09:16:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 09:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2ul9K4D+/tmWuXLooFRFho4QikNfSuGpbrNEiJ/Ek1mEsRwYYHD1cUJ1ZFVsv/ijZeOIHC3Ramoph6K+jLgtfgw0r5ugpGBimU/LF3WlLcrhemEPaueEWuBsNxNkreCqbpycR2eVZzvBlVeu7CZOM6hhDf0jjIEh+btdeBxfBU1qzmmC4XMBnm+pgOIjhLP4Fco+yUxNXeQF5iSyBt198K+W6pVKdjGrMyOACE7uSLurTq7eu+KJJvYaZggS5hBJIt7gZkzfGpK66fBXBaHb0ya1kWNmOQhetKxIONT/6VEeiWhRqr/Y6tdt5vt96+fqB5+cKToHdeVJm4rqUDpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0mNwRDvo0wPUB3f2NWJw/W7cMW5F5K5VTUGLp7zuNs=;
 b=VJmnXmvGkrk2R2sV/OAm3Keenbg0QHGRzQV0j3dhjz3QDMBRPgLeEFna96e6ArLCW4VAISQUW+k31hd3Cm0O1CJOjV9mJaYw4RVDWfCeoqMMOjqGD2AAsqM1J+s2xanOl63cnjVO33IOaUKnZoMYwLvV6g4uBBz/BD/pPYHgCfXTdWob6rPFarqzbMg4mVIAnIwpP5yEVc6003fCZzdVN+blLZitf2DoIM7gyQqD17Mmu3lc+E4w4SZ2mnRJzao8zMRZBBepnQ4osOVxj1TOqfCntPKl0U6qbeMO8agDSbnrR84HQn8yhWx4CLDhBGmVsitqt6kC8FRPcRAGc+Najw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8427.namprd11.prod.outlook.com (2603:10b6:806:373::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Fri, 26 Apr
 2024 16:16:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 16:16:48 +0000
Date: Fri, 26 Apr 2024 09:16:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
 <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
 <20240410124517.000075f2@Huawei.com>
 <66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
 <20240425123344.000001a9@Huawei.com>
 <662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240425182605.00005f22@Huawei.com>
 <662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426094550.00002e37@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240426094550.00002e37@Huawei.com>
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1a3cc4-cafa-42bd-3974-08dc660c45ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GjwlzicIOBFD81jxf/zStQGNpThdoU0KKSuxQT3Te8qcG9vDS4Bgvu++Hmu+?=
 =?us-ascii?Q?jnz6zhF0BhQ57gZpDgQWUM/+paW3G2fi3KYYWYz8m2bHpTH7ro5GrzabacWH?=
 =?us-ascii?Q?33AIpGAmeBe9NDJpdG5tK1DYTS47JPC0QI4fimlSGfVw1UnXzyYClpBELorI?=
 =?us-ascii?Q?FMwB7GBYigCPqFr1T5XgmwgA5WMwKwNpDawvXCPcCZHF2jOG0zZnQkOhWyfk?=
 =?us-ascii?Q?gD8+Rl5JWU2Bd3o8QsA0hub4kIE9lKKWqXE47h7d1zZZuONyLBPZX9f/2wZ3?=
 =?us-ascii?Q?cph2JfOA1648eqXNb7mGyH6oqiU4D2KIrrvUKtAS3y0r2vh0yQ7sGkXqX7FN?=
 =?us-ascii?Q?u/zVmoqv5ndZTVgOXKasAA9j7Qh+nb91eNPm5Xov1S70/kwWtWgR47q0Eq+P?=
 =?us-ascii?Q?6KzjDnTya1lG/Rho21vIj5RUcVkDigR6f1GJYxGNaHzU+6kzVL1eofZNC3bb?=
 =?us-ascii?Q?6yBSBcYOThq9f6vKMT0mWLgFG1ObWFpnyXXstrG/LexktHHM/Jzsoie2EIEa?=
 =?us-ascii?Q?fRZN0T1Fh+4r1KuhY9PQ5CquZPrM0f0rYYfnI7i0RIiVrqMzIBVHeWH/BSAi?=
 =?us-ascii?Q?OokfgQhHavVP0+yRFLEo2i0yn162BSmupGjjMkS09Ys/rq8248SJOObi/7PJ?=
 =?us-ascii?Q?Sk/FYBSXi7m/jd3rqDJAsj/u5OqYXPvmItRbhITWKhpWWKmdDrjH1QLh2Hgm?=
 =?us-ascii?Q?ol2lekVavuFM9xYjFQCnQ30fmBXWmeI4mc28+dGN33JEcmnuyEv7uQ7YpZfm?=
 =?us-ascii?Q?IsGUzEwOSVCSOKRCpIeEdnMrrmi8JlhwuGdgbRilL2v+VdekJyUOtBihc0w6?=
 =?us-ascii?Q?ZjMHRf0QA/zX/35OcAUG0kk/qZ/E1isAxMkyvFwT4eB45BvVm/Q41v5kFoIR?=
 =?us-ascii?Q?zVO3Qggmgv2qvvfYEPF+Sg/T/jP7bCkIs6IROpovJln6WTLUrPQZxwfjjnSh?=
 =?us-ascii?Q?LZyILBDKXP1eRFKZnH/oE/Siito63V4nBUZrTvZkGaGSOEeNvvmod/f69Tsi?=
 =?us-ascii?Q?a0npyoVg1HPOTUPA1Mn/jrCXSlDN4DqCYWrB+1x3NwlZKFR5mQHTC8YT8ZFG?=
 =?us-ascii?Q?rvK4QvVhCTEBIdflPujKfhiaO13RgAx33rrH4uUDm1gErGKNLNj0wzK2scPf?=
 =?us-ascii?Q?ERljMUpVSWOpTqdxFVwYamasKK49Haz2PYrR5cehGP9IL5weVRGuNDsSpd3f?=
 =?us-ascii?Q?NAf1fJ+38HinViQEKdJJAhBeUu6Pf/3ipE1yzWKbzepoTrjmVp0rmJaz2jpk?=
 =?us-ascii?Q?lg7HMDkGsS2Bdfl++Usld2u8v5WgTVU3ox82ZL0xqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ukYii3PDl1ROHptUSZbKvXyXHU0hfe7hRpQA1eK3IO7isq/aKxe4bIgFvNk4?=
 =?us-ascii?Q?Wwv630EpzWvgikxExgL7QwR3yyKsLy8CHb9JGbN0D+iya+vbYspBDiwK69/h?=
 =?us-ascii?Q?DkRiuRg/zjBXh6z1yYxWP6HI5EmV5o659wcQiFEqjxhmDwG9ssmhs4txKw9K?=
 =?us-ascii?Q?Jg5M7h/tFCxpV+PVfNvhGq053uY6E5UaYs9p4PZSfjbdDBKtnb+4aHk7yc8C?=
 =?us-ascii?Q?mL47Arz1utB1XuOf5o03KTEFDdWzgxo7I+Vu9aTphISMyWlFUFaoasnZJJJQ?=
 =?us-ascii?Q?bzSHajHUuuQWzGg2grlvwxOEnHG8NEj021tMuPEbcTVBiUa7ambx+OTRWq8F?=
 =?us-ascii?Q?VqBTEDJebJqYpJ/nG1hKzPcqukKtKI6g1uLJ2UCWY8f6adbmZg3WZg4HESh+?=
 =?us-ascii?Q?2ABTdB5weO0Rc3CHmaAByRqRioyi84sVNoHwmF7xGvzHUfkZG8oLm4qW9TqD?=
 =?us-ascii?Q?jEzM4Jb7l3VuxVshR6eHpNRXJ1F02kGkcHe5bU4ahcxCZcMlk1f/DCu4t/4d?=
 =?us-ascii?Q?OLNkawueY9T9qgjtNu3cwavtlna8GiMD9OGs6vewDTI4doBS0/Zyc0pHhLOn?=
 =?us-ascii?Q?J0/kLpQIxefBH6gN6UqZJhNEqKpyrUk7i1oW5kH3tuLQDhFBp3lhoHvBfAlO?=
 =?us-ascii?Q?J+1YOMN47mCuiXvlSU45mAPOl7PCuLon04SY96UQ4VnHt2pIwvqKFVAt2S2d?=
 =?us-ascii?Q?Mwwz8qC0LPpDIatwncEtnsVzt6YUOuzqPKLxzwvwHlesrFXGwvJhDFLLZElm?=
 =?us-ascii?Q?V7q+ObJ6Ptx2pVRzMy9R1TVSeSb99x6Z7h3igpLKAKgPMMEshIfcZfDAhm5g?=
 =?us-ascii?Q?GxtugqZl4BkvERYVgx0IK2wvUKVYZizxEV+vkqZ4Tf15Tqm7X3E23trcUrFm?=
 =?us-ascii?Q?pMVkxyh295zztNzfpLSQSyG5b1SZtzfl4AwQymUzyi1idiYgbj1LzUWhtkA+?=
 =?us-ascii?Q?A476edEx20Vmha7+CpCDdsSr7nLtw3E1YEgn5GvVmKtP/y7S1+JzrWVyvvox?=
 =?us-ascii?Q?+G1jVi4g3qAFuCun9iED2O9LiisaYY26fTQE5sgjs4Z1VK6XWyeUHbE5RMQP?=
 =?us-ascii?Q?ZNtzYNQrLHjQ9ZS8aJ+ccWrZTFib+jBkGb1Zvqz4jX5mUqhvONFn4LC+5FHY?=
 =?us-ascii?Q?hxexJJOsXnuPCE8kLbMdgO94rjDJUBy215w8YUIoVeBmhbhygjTHwo6+QL8z?=
 =?us-ascii?Q?P6dQ7Km9EpxjEx+2mF8g58UR7NIS0h5F/evVkt0gxz2KxprRykGN7QMrPq3S?=
 =?us-ascii?Q?b1CToaIT+u4IE1YeE03jz2O2ZImQ/Dp2AzOl3FnreFUMB5zrCTw9afzzh4wj?=
 =?us-ascii?Q?92bs7H06pJnNwVWplQW4H7UM7+JywiHssyMFMZGFlYvF7A8y1xincfmV+ypd?=
 =?us-ascii?Q?N6BluENhLMCV6hDELLxbeicFJACJwfXKNiKIoev5mVhDb5WKXavxx7pmvjjA?=
 =?us-ascii?Q?6nBsLhNLOKvUcrq3A1ojJjos45BQhioSvSlS0OHOY5/22lBhmyfPjyfSJd57?=
 =?us-ascii?Q?6FLXoVVp1nWARfJAaUyDLBLeclxRyzglXbySEs7+NaH0PyO5O9P9pg68p5M5?=
 =?us-ascii?Q?29j68dyZjODAOTWu/keA1rkcwMdp4EaJPcV1wCB2LYGnlO8b5L1hDT/OFTNj?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1a3cc4-cafa-42bd-3974-08dc660c45ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:16:48.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaz5P/3gHDiHnlbLgPub2WDwzb9iaQh0TmMLHDtK7s4VVLis3yojwi1+KGzu1IXq9o+8NYjC02qTGG97O+vNhSTTKi4uXtRkJC+aS/NsMX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8427
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> To give people an incentive to play the standards game we have to
> provide an alternative.  Userspace libraries will provide some incentive
> to standardize if we have enough vendors (we don't today - so they will
> do their own libraries), but it is a lot easier to encourage if we
> exercise control over the interface.

Yes, and I expect you and I are not far off on what can be done
here.

However, lets cut to a sentiment hanging over this discussion. Referring
to vendor specific commands:

    "CXL spec has them for a reason and they need to be supported."

..that is an aggressive "vendor specific first" sentiment that
generates an aggressive "userspace drivers" reaction, because the best
way to get around community discussions about what ABI makes sense is
userspace drivers.

Now, if we can step back to where this discussion started, where typical
Linux collaboration shines, and where I think you and I are more aligned
than this thread would indicate, is "vendor specific last". Lets
carefully consider the vendor specific commands that are candidates to
be de facto cross vendor semantics if not de jure standards.

