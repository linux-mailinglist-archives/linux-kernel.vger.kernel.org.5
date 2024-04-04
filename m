Return-Path: <linux-kernel+bounces-131893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DDC898D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922EA1C23338
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64CC12DD8E;
	Thu,  4 Apr 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xa74VqeZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA18F1C6A0;
	Thu,  4 Apr 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252157; cv=fail; b=c3Rsx2nszFc1iFPaUPGrjXps52sIL90NA2yHXKtjB44OVLWs0tVHXZ1Q6Nowb6w1b1DFiLYqIuhZI+Td/bZSXdFjFfa4zn2UU+f8jaGF8pJwh8X4O+B82UDdQEnFWHTomWiwCBAHivNVDPoOLNvOyj9qhwxmLKDiemLixIgGKj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252157; c=relaxed/simple;
	bh=31vY7GjmOGRtQCUmZqchPG6NXH5CrbvRfiDMdPd8sz0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I7qM3pObpZ4tEpaOuOd72gZKzaFhwXv67jWtRZcwp09MkeP6y5TdriIqPSiw1nNBp9Qc+ID5UzK2RvDaiDNIDSZWP+X5optz3/24jFKsVJ6IITPmuZLl4O3S/J+/0HYkHeJMCK+mDmWV8GDEt1/azK4/sgvzNFCbxMdeI2Ofx1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xa74VqeZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712252156; x=1743788156;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=31vY7GjmOGRtQCUmZqchPG6NXH5CrbvRfiDMdPd8sz0=;
  b=Xa74VqeZ2jNcPV5fLsgYCtuqT7yTgNX3gvpBbEtZFBWuf6UI0Ytf+S8v
   dzqE2MIln+rcJNBLRy/gI1DIIKeuwh8VCBaPhgxeOsETZIH7hYtFfZc1o
   tY7m/w0u8NCdA115hlHCEb1eKWlB3Fl6y1ArVoG/U1iXnoPEGZnsL1FEa
   pwZf4ydKmglnF9v3eUM44svPffpWNNKabso/FAGU43gIm/poOspWqwj60
   NG0icEYFyzTet2OLJEhnc5Ln5RDe2sTbcRVB4B/6aSdhIyJeZbA668D0E
   lsQEXOvTv1kou8tEJT60GiQkc4+bCVgeM5a8am6dnbj/i5QO6lVfkvgHF
   A==;
X-CSE-ConnectionGUID: VbJxi1QlQBSZvCYwDQIXgg==
X-CSE-MsgGUID: zw6zzohbSKuep+kTjWZfUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7792351"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7792351"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:35:52 -0700
X-CSE-ConnectionGUID: D+iS5NBgTPGxKFHqGkCGsg==
X-CSE-MsgGUID: zazxk8RGS0i4f8fh/A9MEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="42020362"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 10:35:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 10:35:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 10:35:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 10:35:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 10:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXAIdHgpfuFA1lyW4c5VFZgEx87iPG96q/GuF7PrunRPODfRKHd/WXo2eU+AdNctUiA0lWenT7dVJL6zRoOEmKI561X6BIrFUJsHdeFjCdCaWxBBILkFvILvKeMO8qTOxihLbzXQW2GQ0cKFecbTIaKij4XZXm+vUVOuy+UgTZT53/mwkKoh6mRV7gl/MYNHqBwJHOuiUv/HtjIcYwsJk5ecEJXZmMQDSLyjSSxAe0FUDsIuF9UJHOy/NYW2o+OsLuu0xPtSFzaBZCDlKfdkjGovv8mdMQBr1d4LlUeStSGW9Q7t/zZQYzDGnC7ykUJG6pLLLdELnrrLG7/9DnGD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9jgikcq8pdgD5Z8cxGO2HwZ7RM3L17Xt79AqEKmHNs=;
 b=QCWEYZia+bPrggBHGo8H6hqZIj7+rFeIfm1wIZxrS8Delq581ra5Wk+FFgp3QWvcsswpdgeOvZd3+sSeX9iPVtnsYD0yPjW2TyTEmzgFbrNJGJ5oQBdQ/lp49PPY/tPy5gNzJW99S11pRbsKh9ucQbVlXnqFklmpH0aG/BSJFBeT/ru89sR3zGUtEfH8UaJas0XVHp587KDKLTIGgmCMfjZ3xMXMX92RbF6Fph1ZB7YI0dwTx50BsNPhcgf/5jpwTd7mkcLn3tQcPEcE40mpk2sRrFKHPVGsdE+19Lmeu7ogQbjeELhhkmsD8u5Qw3nKb+PD49K9yhJpOe5uhidwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Thu, 4 Apr
 2024 17:35:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 17:35:46 +0000
Date: Thu, 4 Apr 2024 10:35:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel_team@skhynix.com>
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out
 in get event
Message-ID: <660ee4f023cd7_7702a294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
 <20240402081404.1106-2-kwangjin.ko@sk.com>
 <660d6d64a50bd_7702a29466@dwillia2-xfh.jf.intel.com.notmuch>
 <20240404143049.00005635@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404143049.00005635@Huawei.com>
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8067:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvAi6Cc2VTW0bNoM3m7zHcjTWfE/P3eDgk7Tt8k2f7pH+uoIL/jvkwedJxFXP39Q71/6APzzJ1tF1S4vibnMUFTH8miw9OYihXG+rcfbJzvyG3ddlWPiAz5jk3k9CTtXdhc9dpT7JWoq2Ltesh5HHL5rXNCGYthyvTnAAJTWDwNoz+l8afnaz7/zZCFgA1AGnXico5mAdsHzNN23HPEP02T/F9JUa6KU+GA8S7cja6OxUqAyV+WcDDumKhGomjvdWaMEHYQKj4dmA+DmREHIbJpXwL5UCdXpWu2Pqm7dgj2o1/LVYCcjUxxm1sbYpMpsg4A/JkZi1TDcUkMy1gcDD8BKS5z6sci/lbz03bst/lSiAUmz8kdujhIr18U27SDyuN7RS8I8nKg8/GSRwDoc2tKPbXlyh1UoiHbL08/yhVznzf7vweLhZBXWypIn3ZsG1CJ20+/RHgGCW6JTwF4PNOq6SbqZKqMI0LaUU7TLxQZGumXfeZBsd2H4zuui3LyaXgWIkRstJFgXlvpJD1HJiu8/1MuoVDgi7zwgN2k1rDEbJJaQjX8V2/OYje7De5Ii/7KKqNwXY6QKaO0HWitEGHExXHdBRvJ15YFNm4id+UxEoCwxu9yPtMzWcuOKDtN7jyVgaOSebzu65AgDny6jiUP4KFiaBoCfdkLaYtGSvKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LO1v4/oJl+yY8jGvwKYlgo1VpWFIojLi61NMxxV24WKDEnVoVYPUUBy6TqIZ?=
 =?us-ascii?Q?o3kVO8VkeVBOjebeaEQ6Jgq86oKEOmNAODNw/MVMIf8R/7+OmLWhvGIn4I6o?=
 =?us-ascii?Q?bA4hLW0OpRWaUmz1/DLj8P6iCvq1VEu9tKNuTqhHXTDNaUyhIQLlm1zCRdKy?=
 =?us-ascii?Q?OhYPqGPNWxjcmaSoxGA0e5KirYwrMnON/XOBHjTPo6+R3/KpYP8RWp+uuOBh?=
 =?us-ascii?Q?JURNMIfI9idwPLMvLvdDr+Ahj3f1qtYQkgL27DPybunPiIAtpU1AdF0E/fEx?=
 =?us-ascii?Q?aZjG/NK+rR/tSLEh8qJc4ybO16bH1+KNsI6I8RiLfgJvUd6Hp7aA4oFjoCbR?=
 =?us-ascii?Q?kEuXrJDEtZ9FKKIjytZfCnAHQ06kttcyRi1kiY53NIAOajKpZyx+ZY5drkAz?=
 =?us-ascii?Q?4BPENHn9sCF0yh6aDju29hYxNZeEZr1QW41FpzJt42U3MlyRsEeEDsOrh/jd?=
 =?us-ascii?Q?L+ZTeRqzPDXtIsFEabxPk7d//vMsrtijMewDDfqUiKM3tIU0CVq4fWUFhiIw?=
 =?us-ascii?Q?HisPXVH3HkSzgE6l+X6GidHao7NN+taA4jMJUX9kesHWSqbcSq9kwjwtx00m?=
 =?us-ascii?Q?d5WgirlVaJw1UyTtKHtqSJ0ipb1DCPMh0BKplKAbvLWvv6/ExuAaVq58+jW6?=
 =?us-ascii?Q?4NCARkdPmoKO1qBGMzyzeAEyvUXZEbpmfjNlXyVyoVp7rVB2+KiMStlWU/ql?=
 =?us-ascii?Q?BEIqzGXU9P235encRg6tk6SFXEV+fbrHZeegHFLwZqSn6IBOC1s4tpgyr/TF?=
 =?us-ascii?Q?KhibkOkTwxcC4whC8447YC4FZpG4Rc9qRas/FbKYKcbPgmYx6zbOO52B7UO+?=
 =?us-ascii?Q?x8KHbJ9c1DD+HLzJBsCgn5QWtYu1TUDQObs8LETDE462FVsp3KRSVVm1+BZm?=
 =?us-ascii?Q?Y2wbf85Mcsu78cMJt/nh+IGQKZXxx0P/3JHyOqH6VMkdSy26VBwsZ00GM2lf?=
 =?us-ascii?Q?DM8/HyuzomimN3qny+CS6ONNa8n5qo/Bfng+AllSBiBNKQNzfBJ5K88gsziy?=
 =?us-ascii?Q?UxKppAkPaKjz+5ZUyuSOyyMemFNilqRJCF1NjuEkZw3GE8UOzcV++BcKY1HG?=
 =?us-ascii?Q?3u0recYmDaIfDEt3KKuUL5KU7suaMhq/d6GvyEgzywz9z19Anx6vXYVHLKy+?=
 =?us-ascii?Q?TAbXYZbk6dFH24NHWAHF2lD3dw78sgqxR7WsS4BweG8CMDv1CQA4oOI+9ZoY?=
 =?us-ascii?Q?whqM2aQxC0Oh7cNikuA/dyhyIOcMTG5yUGKB2k4Ytp15re2FCCWNoWySBBhL?=
 =?us-ascii?Q?BieMc6ATS/EiPDZ6q8zEknw5t85ihR0PB2RV0A9XbGV4T4tZ/izcWIdR11RK?=
 =?us-ascii?Q?xVwzcSpuunLjzZ676GMZ0mipA+Gb7zHzId7ryonKRragrFvyguS+W08opU+j?=
 =?us-ascii?Q?hTffFJWTF9l4wf9sSAkRztCko2EjPAa+PMQUjBJ5UhoFj9ga8MyY5Q/WFeZZ?=
 =?us-ascii?Q?uwixHObvo9ttkyR0eBAXqV4IJ0ffnAVouMbio+Vza1TxYwTO9LEzvmATugD4?=
 =?us-ascii?Q?Q3VvEXTUccVVuYzhMlG6YqttKy1BRV/dg4/wyBPBh6esqNnSTmOpsC4AmnWZ?=
 =?us-ascii?Q?Q6EQLlo/6hn273H33KQbaSbbJNH5HAFRyEaiqpGk1I5Iwo++ufjPQj9xPVSU?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bee57d38-2f7c-47b9-cb4d-08dc54cda944
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:35:46.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH6i57JZgk5yr3KFDQEQT+l2XBqaTRxRPsj0CpCPS4/try9W8dG3KeD0FheT8ywyXwyyOy9kGSe2m7nguDYghf3IsQRjhoB+tP0GtrQZV4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > 
> > Fix looks correct, but I am concerned it is a band-aid for a more
> > general problem. For example, if I am not mistaken, we have a similar
> > bug in cxl_mem_get_poison().
> > 
> > So perhaps a convention to always define @mbox_cmd immediately before
> > cxl_internal_send_cmd() like this:
> 
> Makes sense to me.  These aren't hot paths, so safe code is worth the
> possible extra writes.

Yeah, the before and after size wise is small:

   text	   data	    bss	    dec	    hex	filename
  15407	   2129	     49	  17585	   44b1	drivers/cxl/core/mbox.o

   text	   data	    bss	    dec	    hex	filename
  15461	   2129	     49	  17639	   44e7	drivers/cxl/core/mbox.o

..which I think is worth the peace of mind, and it matches what is
currently done in cxl_xfer_log()

I will send a follow on with this since this patch is already in
cxl-fixes.

