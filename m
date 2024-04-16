Return-Path: <linux-kernel+bounces-146285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2138A6335
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2541F21EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456433B7A8;
	Tue, 16 Apr 2024 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvSpzMQO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745B3A1BF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246377; cv=fail; b=Jv4XOTwIQYxDLk9Bf7qSMSLPpzMVjadwEdhTFzC1ydKbhuytIYThTrTQM1AYLMkJz+FdiqMg4Jwr2bPtaAA8axSELxxvKz7YsxzXYwBgTwcClqaPBfv8pA5iEGnYdMRiGd4D71bvGoYjWvyhDubo+ES3a0mgNpaup7Mf7zwPCCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246377; c=relaxed/simple;
	bh=n/cfkZ+paF4kOllDL4zziNwucxTSYvJXPwjbMiS8Ois=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hkOuTkpZyYIzY6SrZ0R3GlVjxcNABhlwNoI4UC8TQW7wdUJMvKgaXpF6yNWA3mjGRmO32iutxAm2DaEMr7OSaqtJO097B5lDhyndAHu9OLh1pVatj+HNBuKM12P147vHSFhATuEw+cKlEVFgSHEg9hMOjwtFUt/CX026eHEpqw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvSpzMQO; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713246375; x=1744782375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n/cfkZ+paF4kOllDL4zziNwucxTSYvJXPwjbMiS8Ois=;
  b=NvSpzMQOXhcgOV4Le7G6eQ5DAXaHHFQ+ZFpuCuboAlc+8cFMKEy2zSxh
   kHG0W9xVWhpY9INoHBlWsOTI3WNcgt9mjNwF3DJaTdWR15IqkvKSVvnfp
   lBX0VHr/KlXDnKTthHvRECoP5p7zclGI1StoycAMObcx0FM04cGZE8aBv
   VeLUKOWvc7RYd5eCHy6MY2+eo778g/YhcaCDGucl59rlpUnOaW8ytWR7j
   g+rcBOZDuHovT6/nCTpsT8AbDWjG++4RBEQwOc0BBzN36+sWNHvfsBSkj
   QvuuCEayKZ5UTriJTt/I9XAw3e7Hh2Rz9AzPbY28Ii2LKfHZqOI61tPHK
   A==;
X-CSE-ConnectionGUID: j3vPB4X1TAuSzWmgBWyMGQ==
X-CSE-MsgGUID: 8TgHrnJ5TqqumxefRseMYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8583880"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8583880"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:46:14 -0700
X-CSE-ConnectionGUID: oc/soXleTpiBzvCcO19VjQ==
X-CSE-MsgGUID: Eb9Vfwb+Sl+lgL4U0X0SAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22222992"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 22:46:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:46:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 22:46:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtJolMbidBbD+WIE+pyY3y+tx9gTlSyjUX4TN1cHsOFx3v4qyTAV3B0eiv8c6HisoozHPrD6h+DArYLTr/T7E3fahMJkK3C6FWiHlal9l30ZLPrETw+wXFWRZTD52BSBZBTJuHqVUwDHKE5FcgfXMgrWmRZNfIreiuqftKccpIscE4U+krlLYe9Z3FPUvYBhKgHkM9ENYT9yL+levECP5zc6MwCTXIRI1lwQYmxzwuzThr69CZyvsDfzq2z9i/Xiwr4HoBe7tfaQmyu+RDJEqvSJ7sL8YLU1lZWHOs5RitMFojGM+lflURc1ycRHL87NRwawS5T9FppZlTBLh16/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCS8fdOVVqOcKIGr+Ak95E5bnVEA+LjYz4t9afwAO/U=;
 b=CDiUCG+dxIMi+Do3vA0E2T7uKDvbxlfQLf9fqCHikq3CFZsC2BX3IkGpzKKVHW9lBj4FOzU0HhafAJrEDwDtKBCITANpxbo+/g+Q1hKCsmUa8nsStTaQ4/q29/Lxf27asw2Yi7JslsCIvcsjFoGU8ivpTCk8F/IrgqdL/qL8LSgcwFvhHQ69+oFi7jT4HJBfmc9OWBqllwfKW1wFAQlj2+PGe4xVj9IIWYKR9Watg8moWq8VCtmZCXYDTsfqBrOSdNpfHICEV/i4ZRGO3nsYRopdE3V3FntwE6cr7hXINFAKkHAdXpD3gbcMh+PFZrdRK9EkRwfXrbcxhtqBgTGDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Tue, 16 Apr
 2024 05:46:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 05:46:11 +0000
Date: Mon, 15 Apr 2024 22:46:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 12/14] fs/configfs: Add a callback to determine
 attribute visibility
Message-ID: <661e10a01f1d8_4d561294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e881a70fda1da98882241fc46fd57c3063fde55f.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e881a70fda1da98882241fc46fd57c3063fde55f.1711405593.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbbdfe1-53ce-4edb-307a-08dc5dd8855c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/E71Ifh856uzU5E0siJwcB0ptnwaXCc2VnFwgsyjPD7KH8UnRdaoEKV+EEa6CwZE5jQP5iHrHM40WIU8TjMExaM/OO9VHvCofzb1LlFrvmRcSdCIYWZr4L4nuWqeyPSRtB3oifdGePrHcceCsP4wKOgHrymPaC2n1OrZHGi0uyIn5wypESwsYA90n/AvMLGZhiPSsjoTnZVglh0NfS//iLwgIe1C/XAo/wL3jTeNAO9AAUVk5S9/D5obgTK2+RRt5DPVT97sVBSWrLZONcmnevi9+l4aI6IgrqeG7dFmVZGceiUTLfPIGToSxPSr7g5EyaAiECfZ1j12DMfoa+7NwO1gZ/9SfygFDkTgVmuaGQybaahfYi4f+B5CrtxIg+BzTSkhWBzlTx+Tyik3j8zXeqWKur5In2Yv8ZXGojj9S4mvG1ZS0y170CZGdEda1NwfNEPwfWxdYyTddhQHvOs7bmAv5IQTZMYC5Av5GpqdqO89oP5k7Sg5p8Zf0Xko+QzHMx70zPMRdSQ2egA/eBeLTfo5gkxd9HHWsWeRlx4SD26Uy9AczP5TLrscfy4sm8dypViIIcUg+8aXKZisy36WkdPGjkyhxNEfRTow6JvMq7cODwWs57K3qtyGAWXFD5ER+C8xnbMT+BX/LqRcczFqnsi8oZdjw4LuQmr1ybJ3hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSfhtnvzhXaCXSfYYE3E9wxJ/8lehWGqbXpuZ7+2ewV4yLuGMDzL4tN3SB1U?=
 =?us-ascii?Q?7Fi+DRUDkiAVD3lyYf7VN4tWdjMJUp1QLTRoqzI1l38xszNbi6NRN4Hdz+PE?=
 =?us-ascii?Q?GOKPnjtqtLl69vqlYNqe0uW4SXx/NS4cFOIEkKRHY5zXaZgDzRBiqZLg3vai?=
 =?us-ascii?Q?qo0gb0Kh8s2Qiipzid0D+f4omaEj2hBHMCe8BLrrYxkbvkCnk2ELZ/gKeVWo?=
 =?us-ascii?Q?CjYNvJ9U+Ylo+NjeINp1dsCs9pbjpKlVuWHPmPRBKCYzSGAlRg5/AQMnkjZB?=
 =?us-ascii?Q?XcYyhuP8ZkKZBR/Nwmt+27zMmNYt71T40GzKo5gTLt9UJP1n971Td4BpdjLI?=
 =?us-ascii?Q?V28lwRfvUPHfXBUbtW7v5S7RtrkPqEeBdgLmrFQMZepL6Cl2d1fMRB1W54Xz?=
 =?us-ascii?Q?P1hCwYulf3D9OEcIfpS1Di04Z8dA3v1eaePWItarU69QjO5IPr8bNT3A4fRL?=
 =?us-ascii?Q?wAj8B4W/8DQvifOzXXg7bHQXgj/rrKiWTIynixChs0fXpT7ZVLSe5rz3FnQL?=
 =?us-ascii?Q?S/RUwhWVnIg2CKcVyEzvkZwCOz8A4VPUaEYPPJlSvVWTQgY8nBFMtw+jjJVw?=
 =?us-ascii?Q?Eh5uslDGEucZ1QssNDs2h6nwLGI+J2itHU2jJzc0PBPPVEtLA5d+gm+WHxFA?=
 =?us-ascii?Q?7/YTaegOACIp7R1G0QpJoQaU0XssmtaT4AEjQPVDocNFBZCJq8q8We+YlDrJ?=
 =?us-ascii?Q?44u2Jy4hqIDeg7iQTtlXA8ScxJiTMHNHRIEmBtRZ2/aje8Pji/cK93E1OATB?=
 =?us-ascii?Q?U9I6qt/G5p52Fh9BT7K7fxjYpM78ehswONTrxFrqoZ8z3j7+3gQBID7L/5Op?=
 =?us-ascii?Q?wArjlGZsp9519+Ehcwrx9jH9zKiQY9t42MdhoxjoTXmUETRgFEKdaOLcPhzk?=
 =?us-ascii?Q?y7k4gz1YwdFGjAGR/e2Xth7J3u9TLVJBCxO6gHHMQDn1IT08U4PKs533PMV+?=
 =?us-ascii?Q?P+gQB5U1FkRFqz/3IwhxqEXf3kRitMk3+rSGgjAYfEXxqz7ux1dx3awyC07g?=
 =?us-ascii?Q?dug5OeU3Z7aA2v7QCk8oCBHdXZg5WRjUZwM6eGs2vO8+UvX6ujlB4J0N1eeI?=
 =?us-ascii?Q?rSXHez7cxhx8kFNnuI7yzVkIV6FPvjNqkk3TPopLn8k0Np29T26CIn2SMLv+?=
 =?us-ascii?Q?hpIuYqgNPUtH76nqAed7DnToGzlbrv73jm1lMBR9IXMMsNo777jkKn05ipty?=
 =?us-ascii?Q?NbWdG/pAhQxNnsNZ8XLto2noixQLF+hZtYVV+DdW0Qdze7bRBjC3euYg62vc?=
 =?us-ascii?Q?Yt2ctWAV59iPflOdD+RXSxzASpiyZoiYObWsZ1sOsGNe2RmVL/mG82Qr8ESq?=
 =?us-ascii?Q?51IEzPoYJ1SGbY9MDAj0xIdOxnww+Fr5xcAJA2dBGJyOSBCxZ7gHxINmmgFA?=
 =?us-ascii?Q?vVXzuROM0PMFK88tVfDyXV2b4mMHV39HjyMCtWjKFOUnFf/GlPE+js2EB2Vs?=
 =?us-ascii?Q?3/I8xX9BBQlmwwK5ta4/xLTAVInkongn71hoPbZEJsSkUwMDNXSZWeHIl38C?=
 =?us-ascii?Q?UIoFRf2NLm4IEJ4WnFiOmMKJIfH55Cnyo87Mr9/DBrQSPhKf4POY/T8JpNtZ?=
 =?us-ascii?Q?r0fkxfq2sRPQBZgcabKn/DIETM/w0AssTVUfIgRW6Yij86zaAKYoy1Rtmlk4?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbbdfe1-53ce-4edb-307a-08dc5dd8855c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 05:46:11.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CzOTbw6SLpN8dRt+BJZWz2FRtD+KMZDVzjgzeIFUN45CkCpvMm2Boyk80pK7GN+PPJorzGvsEfZO9GgvA8peauQzzMxnNmuC0e4v4MtrRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> In order to support dynamic decisions as to whether an attribute should be
> created, add a callback that returns a bool to indicate whether the
> attribute should be display. If no callback is registered, the attribute

s/display/displayed/

> is displayed by default.
> 
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  fs/configfs/file.c       |   7 +++
>  include/linux/configfs.h | 111 +++++++++++++++++++++++++++------------
>  2 files changed, 84 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 0ad32150611e..a976c183756c 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -451,6 +451,9 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
>  	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
>  	int error = 0;
>  
> +	if (attr->is_visible && !attr->is_visible(item, attr))
> +		return 0;
> +
>  	inode_lock_nested(d_inode(dir), I_MUTEX_NORMAL);
>  	error = configfs_make_dirent(parent_sd, NULL, (void *) attr, mode,
>  				     CONFIGFS_ITEM_ATTR, parent_sd->s_frag);
> @@ -470,9 +473,13 @@ int configfs_create_bin_file(struct config_item *item,
>  {
>  	struct dentry *dir = item->ci_dentry;
>  	struct configfs_dirent *parent_sd = dir->d_fsdata;
> +	const struct configfs_attribute *attr = &bin_attr->cb_attr;
>  	umode_t mode = (bin_attr->cb_attr.ca_mode & S_IALLUGO) | S_IFREG;
>  	int error = 0;
>  
> +	if (attr->is_visible && !attr->is_visible(item, attr))
> +		return 0;
> +
>  	inode_lock_nested(dir->d_inode, I_MUTEX_NORMAL);
>  	error = configfs_make_dirent(parent_sd, NULL, (void *) bin_attr, mode,
>  				     CONFIGFS_ITEM_BIN_ATTR, parent_sd->s_frag);
> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
> index 2606711adb18..c836d7bc7c9e 100644
> --- a/include/linux/configfs.h
> +++ b/include/linux/configfs.h
> @@ -116,35 +116,57 @@ struct configfs_attribute {
>  	const char		*ca_name;
>  	struct module 		*ca_owner;
>  	umode_t			ca_mode;
> +	bool (*is_visible)(const struct config_item *, const struct configfs_attribute *);
>  	ssize_t (*show)(struct config_item *, char *);
>  	ssize_t (*store)(struct config_item *, const char *, size_t);
>  };
>  
> -#define CONFIGFS_ATTR(_pfx, _name)			\
> +#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
>  static struct configfs_attribute _pfx##attr_##_name = {	\
>  	.ca_name	= __stringify(_name),		\
>  	.ca_mode	= S_IRUGO | S_IWUSR,		\
>  	.ca_owner	= THIS_MODULE,			\
> +	.is_visible	= _vis,				\
>  	.show		= _pfx##_name##_show,		\
>  	.store		= _pfx##_name##_store,		\

Shouldn't this operation live in configfs_group_operations? That would
mirror the sysfs organization, and likely saves some memory.

