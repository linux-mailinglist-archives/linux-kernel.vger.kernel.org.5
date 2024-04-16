Return-Path: <linux-kernel+bounces-147494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B68A7532
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C617FB229E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6DF13A25F;
	Tue, 16 Apr 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCwbs3u6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7B139CF7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297843; cv=fail; b=uz34I0Y2wyf11aI/bIFladw5uLVFT/EoueZBq3AowvwgFWHjPxbV8bVNn6mo8nvVNkMOeIGVqh7XoYS5GoVl6afna6hts2Hqu3ZE80JVGLE0XsVaXeeINVrkqz5gyIrAg4jwrMt9QO3VBk2VsJTcxxVz9kzN5hCRePlGjTmzGgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297843; c=relaxed/simple;
	bh=0sIMIEA610kk/tFor5FPlu85UAO+Wb30TB2OEIaRzyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H8Pj8F+CETcOJEPNd0EuIfWmkvBravY+GBYRs2Mjqm8CkvtPcdpHmhQ6CIqPQRJrF0HPDbyME2WxbqmRvBnSBe7D/i4RPFER3BZ01pweGduDdPi8tbrviTkxQbAZs6um/lnWRz8s7tUa+/fNyYW5c0vPnJfWAq5mdvDMM/4OCTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCwbs3u6; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713297842; x=1744833842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0sIMIEA610kk/tFor5FPlu85UAO+Wb30TB2OEIaRzyA=;
  b=bCwbs3u69JDkwA+TNghOHpAseayH7ftl1vUGU2yAQ2n2rgVrOGFMXQvh
   w8lGEOmOOH+sq926ECgmRPaE+dHbDSdmiIpklpkr6TusMHW8uPKhLo2Gi
   DWz5HioAqSgTLS4BcdLLllBXbaatmV7yMtlrqLWdeTECtbYQzYa/0gv8A
   Sq1lLCS9U1sf8eAR65w1SzmuIMsF0QemGQxzNr72PFwHH5iMPrch5jZc0
   Fi4cAI2FL8z8o8T07VssH/JtVLHYIqkL2Bx47ZAy6s0NOXfm0Q9wtNY2T
   yBybXc6/yamfCjt66nEJjtDMH+eKiS75psSXMYGnCA4QBHYHEWD3Zrhdc
   A==;
X-CSE-ConnectionGUID: ml93NnO2Q4mcKTCMWA2msg==
X-CSE-MsgGUID: 4xWIARx/SEed/RQee6MIeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26224685"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26224685"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:03:59 -0700
X-CSE-ConnectionGUID: tiQMlkJwQZqYS1l+PjP0ig==
X-CSE-MsgGUID: k3svdKjSRLysFcLvGt7UcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22967032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 13:04:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 13:03:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 13:03:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 13:03:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 13:03:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX5bGghZEkLEmjAT7HhrUHq15JQGSAdkaLxdZtZjb5yusx6GUSBdEveQv4/DIlYVDaYM7awHa0j1vsyq9DwCTsBPGi/jCYm9N1gNBzkrLPPakYE4Gdw+vTby10UlLfh7kL+tv+zuUSloTcKkwzgVrXXav6pJfBq0NZMF/BkizxtHXgA6T0YUnUMmAgs/8DDmi0Wqvbo35Uz5o2TeCROx14dPhH0VPKfZWE0sBofjdbBtRYhcvQaZMqMnE4pYvsQfp/Ie4QBvArRrDofWan+X1qlloeK0WnlGE9xN6RRYIVKbLMm3aal5FL1gflLaU2DUFt6LEVltwm+toCZT6dWDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muzggy/SngsxmtWUp1uW0zbZNxkMGrzg/eAO13UtLBk=;
 b=J5LTsH3rudlTlw88qwSuvosJ537vK3OHExr7qRChQ1EpGEn24sHbtzoqtrsyeCPZoSXJleUnxRAepD3lbTZJJQ7SHB/pmIO9BD3ByC0qwXtb/OocEVK024CtbDsaQIldDeNT5/oM6dcg8iZlFtbSEyXpxpGaJJgsvGmcj1uJqNSdQT17TctLqi/liRy0XLGVpPHr+H3O4/rd953x9j1NI0e1EU8Vf6JN5P09gunVJNnnyw9JIIdMnhIBWwdItOv7Lq8v3A4MKdbqbtnpe0Ao6W+Nn1H+9bmWDxuvShBDor3720unFhEw6aOfa+cG+ovznNQVwwZ6+V26J64biIaaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Tue, 16 Apr
 2024 20:03:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 20:03:54 +0000
Date: Tue, 16 Apr 2024 13:03:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, Joel Becker <jlbec@evilplan.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 12/14] fs/configfs: Add a callback to determine
 attribute visibility
Message-ID: <661ed9a781e80_4d56129495@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e881a70fda1da98882241fc46fd57c3063fde55f.1711405593.git.thomas.lendacky@amd.com>
 <661e10a01f1d8_4d561294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <7fc4e7d4-dfa8-b626-76c7-1f8993304a2d@amd.com>
 <661ec2968fa55_4d56129470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <3cb02504-4854-8bc6-7962-e590e656856d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cb02504-4854-8bc6-7962-e590e656856d@amd.com>
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaaae74-3030-4fc6-ab6b-08dc5e5057cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6T15eANhxGnR0ZKjH1OcUM7PS3PmkUfLH6b1U9kgmhXPu10yvOIsF/qWNeCd3R5HVwxR3ainsFTHrONAiDpLsb+HREmMJ7cGB2DJI8xrQfYtz7pW/UjCw27ut4OD7A4glkP3q8XctGxsE9M5rVNkO+OPElXmhAQu8qNnZfj6+GlgxDJmtWDFXGUUP9T1DQXrWL8hyLrx3intkepzs9T4PkRTiGXm+LHKWjDdDgmCCpAAUrwxU6w5bKlRXscpeTiyL8bwvjsvEYVh8ulbYE376uVGdqX+XRGI1DsvkJ3hQCGd3m/CDcb2+kmERZX5v8Sx+d6zsDNjCeolziTs0z9lOiP1x0sOzYlwLZ+z1vZ6to+7wdiC2IjjzIX+CgGdk1fm9Nq+18/tKkkVQwOP1khH0dTPwPYsAsTnvwOyWl7RZvOEd65LZUW8MP+9JQji9pqS7jqS6Vhxe70GSY2Zx9v5018AKSdllikvP/XFOlhjrWF6y9WEepS5b3/Tzb/6aoS9cFMX9PK09ovokTAbvNBCzAoFgb90lVYT+XiYL/HbMrXYdfBNDn2JT/qGfTs+H3ZyswdZ+OGQHV808m7TrxgSTJqv87zM3AC5ptMiCzpQiYTSlFroyGI3tJD9rHLEZq3fQ4YwGLGkVfSJOz1bIlQvURJcjOKL3vbMtFKcaZvHvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t48M1k3mf4LIdWm0lRNKuiXYOE89yyOy+UxkIcvVfYbyXqg+xY5jiuGimhDH?=
 =?us-ascii?Q?9QovGNvgsqVpBZ65UpHvjgJ2pQK8uaOoMLZcuyivrhyZN1fnccV9QdJtYxE1?=
 =?us-ascii?Q?K4NjwV8Tth6ecC+VBABLDUlcu4XKN0TP6g1UZLYJRmJcTcvF3zP/gasTC8vf?=
 =?us-ascii?Q?4ZEFWpuZYhJkw7hrpWpW0OEACeRyA8sPiS0vZRdY8K9s3KeT5vQeMyCdVHVE?=
 =?us-ascii?Q?FspvW0ALxYs2cQP2p0SEgIQHeTITw37go/dm7dnfV+dUbHhvSnXUWbg9/pb4?=
 =?us-ascii?Q?rq6XGdN8RlQhzIjvYzsqYPSwsjtqySZ8TZLDuZ+VJQa6X6tRXN06LOi2i+hX?=
 =?us-ascii?Q?RRQzdpS8XB1aXkNnkvGrz0c8ELK521QAo5aqDn1M4GqpfcmX+gZxK/DQnYIv?=
 =?us-ascii?Q?snEQJvL3rQyTq0HzjeeREKOkhJVoPq1vD1tlijjGIxX/DlUbwtyKyXqeZBno?=
 =?us-ascii?Q?SlRssGpFV0lLJO37MUdrluYk0AN7MZ3OD55rTDU1D+KvIX6ifGQzFQOcLaDQ?=
 =?us-ascii?Q?Cx5hlGlxFE+HBJ9bIv7T7QCM2G40MmEDribUOmiSM9i8HdCCcRHP/QQRu9H6?=
 =?us-ascii?Q?H2aHWGn87Y8sjxR2M0Zc3cT+WHP/EpYPpPEUAVGRdMu1s/Imh0l3o4kB+WJb?=
 =?us-ascii?Q?cprBacVamByo+iLuIjwMf/+7QWdFpLK1YBXS2eHmhqGkwGGTAJKgFzB6yDjm?=
 =?us-ascii?Q?oVLrrzYDlZe/HoJRLGdgjZJ0M/hCC6KqFlLu4Qf0KLuW1p69b1/ynt8jzenS?=
 =?us-ascii?Q?abvCwb8qy5uh4N6NckzXEjuh13/PRRF5qKAvQc7UMlgcxDv0Hdsi/J04xX53?=
 =?us-ascii?Q?lQ8+T7oCQ8sUQEW8H4WlYfH5M5aCLRggBaI5Zvxa8vL0XUfNtFbjlty8IZff?=
 =?us-ascii?Q?QSP8Q01wo53DYyO9nlbjAFaDYVqerl29vGpF1lXOenasSSGEpE9NXKFrzISc?=
 =?us-ascii?Q?NgjAr78q2OpgwxqsswCZOYPoCunY82SEBjm/KEsEH3Jpq/aEApWE0okjAZf7?=
 =?us-ascii?Q?RZns6w1xRqhD+JWLsPWNIcLtQfkGDXiuaCL+CiVkyUeu3UREpck3UF/S6rEY?=
 =?us-ascii?Q?QYGXGtv6UMZ6umwYbWQFyvO/1L/8nNhz1c6tIuEdx4MIMCL9LhaQUwggSu5E?=
 =?us-ascii?Q?On8OxCQhzXOJzgivdwEjd/Q30bRBryXUbvrHd2jTYCvQLDcGn280cn9/2WCM?=
 =?us-ascii?Q?jen3Dgdg4fre93E5FmnS/ccznC4Z5Z+GipmRPqpvH87Mqmgu6h23h5njgY1K?=
 =?us-ascii?Q?eZCftIlXJE/WemyV4YZV6HWXTCoEBU8OlM7GUdzBe3PtaUtnYZT2gemitc8V?=
 =?us-ascii?Q?8CcXZ0wJX1Nq48ZcgYoYdm7Mx6bojuPNmQVkTF0lSRgwhnzoAmml/DaqLolM?=
 =?us-ascii?Q?ThWVzeJ08zHrbynnUrllyqWQOUXaosKNPQfI1dBUJPXM19x4aOuQEDWe/ug4?=
 =?us-ascii?Q?mF6ORh9iMRvkLm1p9HfBv0eH1AYJUnUPiI8KwQgeqkoTp/xasuKncHJK+mYZ?=
 =?us-ascii?Q?pV4mQSUW8H4tFcheLQp+d4BDbJRxA8+M1hQrkvP2JnTU/Lq3RjedrRaJ2Tfl?=
 =?us-ascii?Q?M/5dJd/90xmxH3+O7tRvIHvrxU/DXTzjrqKi4jB6uRLpi687SsMIjhoyFt2a?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaaae74-3030-4fc6-ab6b-08dc5e5057cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:03:54.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYEqVlafqR3W6BGjonkpzlhTjkn79HC2G0lRDL7sQcLLoUjkoKDqAS6hd743ssFmYRj4twMZO8UfDpki4+APxLraOKmKX7dmMCt/OzfMx8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/16/24 13:25, Dan Williams wrote:
> > Tom Lendacky wrote:
> >> On 4/16/24 00:46, Dan Williams wrote:
> >>> Tom Lendacky wrote:
> >>>> In order to support dynamic decisions as to whether an attribute should be
> >>>> created, add a callback that returns a bool to indicate whether the
> >>>> attribute should be display. If no callback is registered, the attribute
> > [..]
> >>>> Cc: Joel Becker <jlbec@evilplan.org>
> >>>> Cc: Christoph Hellwig <hch@lst.de>
> >>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>>> ---
> >>>>    fs/configfs/file.c       |   7 +++
> >>>>    include/linux/configfs.h | 111 +++++++++++++++++++++++++++------------
> >>>>    2 files changed, 84 insertions(+), 34 deletions(-)
> >>>>
> > [..]
> >>>> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
> >>>> index 2606711adb18..c836d7bc7c9e 100644
> >>>> --- a/include/linux/configfs.h
> >>>> +++ b/include/linux/configfs.h
> >>>> @@ -116,35 +116,57 @@ struct configfs_attribute {
> >>>>    	const char		*ca_name;
> >>>>    	struct module 		*ca_owner;
> >>>>    	umode_t			ca_mode;
> >>>> +	bool (*is_visible)(const struct config_item *, const struct configfs_attribute *);
> >>>>    	ssize_t (*show)(struct config_item *, char *);
> >>>>    	ssize_t (*store)(struct config_item *, const char *, size_t);
> >>>>    };
> >>>>    
> >>>> -#define CONFIGFS_ATTR(_pfx, _name)			\
> >>>> +#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
> >>>>    static struct configfs_attribute _pfx##attr_##_name = {	\
> >>>>    	.ca_name	= __stringify(_name),		\
> >>>>    	.ca_mode	= S_IRUGO | S_IWUSR,		\
> >>>>    	.ca_owner	= THIS_MODULE,			\
> >>>> +	.is_visible	= _vis,				\
> >>>>    	.show		= _pfx##_name##_show,		\
> >>>>    	.store		= _pfx##_name##_store,		\
> >>>
> >>> Shouldn't this operation live in configfs_group_operations? That would
> >>> mirror the sysfs organization, and likely saves some memory.
> >>
> >> I suppose it can, but then you lose the grouping of attributes within
> >> the same directory, right? A configfs group will result in moving the
> >> entries into a subdirectory, right? If we go with the group level, then
> >> we will be moving the existing TSM extra attributes and the new TSM SVSM
> >> attributes into new, separate sub-directories.
> > 
> > I am not following the concern about "losing the grouping"? Here is what
> > I was thinking with having the visibility routines in group operations.
> > This is just the broard strokes, it compiles, but still needs the finer
> > detail work to make tdx-guest skip all the attributes that do not apply
> > to it.  Might need to be broken up a bit more, but hopefully conveys the
> > idea. Does this address your grouping concern?
> 
> Yes and no. Basically the is_visible()/is_bin_visible() callback will 
> have to check every index value for a "group" against the passed in 
> value. I was trying to group the values together using an enum in order 
> to make it a bit easier and more readable in the callback. Adding 
> another attribute to the group requires updates in multiple places. But 
> thats just how I was looking at it. I can also see where you might want 
> to selectively hide/show entries and this method works well for that.
> 
> I'll follow this approach (add you as Co-developed-by: or Suggested-by:, 
> whichever you prefer) and submit a v4.

Sure, you can add:

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

..if you want to reuse any of this sample patch.

