Return-Path: <linux-kernel+bounces-160713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCF8B417F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632F62833CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F5374DB;
	Fri, 26 Apr 2024 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1SxGGXV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD852C1B6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168150; cv=fail; b=XXnndjxKfVlaA4UUiMkMvBqQoEYpdSunXoKyJNuM2I4rma0G8sFqx0SM0OloavqUkzi6H5mHrpN5cNi+H4z9saSpV9OS2Ot9X5xo2BL7K8D7+WROyJxy6N2x1AuFV/M5J6WtF/7YxpyEKYRQ8h60JnMyJyjsVrTuVyKXfIn0awY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168150; c=relaxed/simple;
	bh=qFg3/VeD532bBWnGFnYe0gJCr/HmRlUfRGi4xpLbasY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dslZuFirOFKbAmGDZl6VPQfty5/siqKL8qDZ3tYwIeGHqZBwl2cAicB7Mu0nsP0FZTsKkzEG2RRFgM3XjAxqbWw5pQbSQDk3ePOfOgm4m7PqwN4yd3IrPnybrC//NvCqQ88/LKerpARe8V05/vUXYvSWWRAtWum8U+Ith/+QTXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1SxGGXV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714168148; x=1745704148;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qFg3/VeD532bBWnGFnYe0gJCr/HmRlUfRGi4xpLbasY=;
  b=C1SxGGXVZakaaSUcrC2U7QVSOZ0P2Y35tyGCPtrVW7Czhtki/E0kn/0K
   FF4IQZef0SRxiu7sfYx4HEX0gLyTqVVhfwmfQK1VxvlqAzlRrtoV861BJ
   wBi08l/fwDbn08Czdh5TDoS83Jx28FFELhoALRQ4KX+R/2wQD64bQCjuS
   lSSH/coI6DbdXEu2QcXJ/O7y1T9mmv9GLTyqkFAUJovZHor4R+rOBX6sD
   PffjQeoMzdH1E288tSn0rtiDMHwAtWOsllKcT2AGUCGoXq6cplBlYehr5
   mhB6LDsXyoprVFhdrFPnKmd/hGZL0QPeLeOglfVBOeUN5ZVjMh++BT/Yn
   A==;
X-CSE-ConnectionGUID: +vdb55xuQD2bp7Bk+3lC5Q==
X-CSE-MsgGUID: 9mfDuS5hRg+3S18SelxuuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20471814"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="20471814"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 14:49:04 -0700
X-CSE-ConnectionGUID: HQwFbIyjSq+yoy8jpZvbhg==
X-CSE-MsgGUID: Xtm1RZCzSzyFiOZmFRAiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56718523"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 14:49:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 14:49:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 14:49:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 14:49:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:49:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glfZWso0+qiQ0crzg4TTzHsgC/G0vRSPFWm3ozhALRQEHBtn9hHlspc4yak6kpqR9O+L+7mEbKvdiGvLenRcCF8ERYiN3h7+qPCg899AMaIqFEOqAyGRNjIQxGXp8t7lJ5x7vDh2uV9Ef7oi61IIYm2phQS4wIRaqN5QpxR1Xl7MZzphpNbCUVX+4MJD4lLphpTrAqG52E7bcDEdAe/jRdZdu52vQyhy9BjEnpeUHaSvmmxwldVCA6tkxn8qWDQc/6oy4dfFjed3A13ogpYeLqVzlUk5ieeu2AheUW2VVaHbHOBBc0waPChWTICDrFQC524Uek8GB+3IiOYU/EBfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM/aZlalz78c90H4MFXDH9aT12ZoTIarPnYT0KW1CZc=;
 b=UaYuewL7g4+Z2monkQ05bWz4Rx+jtOdlsaP/NmHEhU1kBUAgFFUx30k7+iP7jAq1bhotTrjJH0M7r9jt3qZb3giZA0nzCkxNHvL+pj9tCoXscCga022Rzltvp6mwHmcix7Q6pHTTn1GTEg3G6qMKWj+3sVfx/JfLWqm5mdCX1JkFGzEwgvq8jXbPflbtyqJCy9JPHzEIYNIMID2QAwBkUKQG0c4Rm3ajwoGAS92H76uCxu3tken4iXg+pYQoTali9y5l6QwwtpyTNXs29Yskqjf9fiBSn4WcPLXg7zlne7/GMItZqTNfGARo89FqDT6HSroLcAHpJ5whe2d5i2HdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8031.namprd11.prod.outlook.com (2603:10b6:a03:529::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 21:48:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 21:48:59 +0000
Date: Fri, 26 Apr 2024 14:48:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 12/15] fs/configfs: Add a callback to determine
 attribute visibility
Message-ID: <662c2147c4fa3_b6e02948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <53e67e416fb4da085f32d8a3626c5c6e656554f9.1713974291.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53e67e416fb4da085f32d8a3626c5c6e656554f9.1713974291.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:303:83::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e9d478-5c62-4bb3-5e26-08dc663aae02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WFE64FXF4c3LLDA1e5hxJD2Z/NR9yFvtJ9RFhM4YWXVr2+OMTHK0n7r1geGs?=
 =?us-ascii?Q?zUDKuVdMDviwUGPPCTinT2wiubW4adm8J/RDyeDXm3rrIcdJCRIiND/ceR38?=
 =?us-ascii?Q?xnesIB0+xhVLi7OBAIBqndsLnRymQsWiiED37sTVSQzncys0oxcjNUNxZdPF?=
 =?us-ascii?Q?qANIJU3qnI5u5r7B52kbFsNqpIw2tEjN5Bkez2Bhtbn4hGHPhpYNfxndmzF7?=
 =?us-ascii?Q?VwZrFfYURjItTk540Uvjy5tTamHAUgHtPjwvVcNAgW+7H55XRrmx+zXRYZE9?=
 =?us-ascii?Q?QxjwREYhAdzwSx4KPWy6qgx1MapAxfCRs47GtvcAuDobkg/p4Mww3/X7+CzI?=
 =?us-ascii?Q?PunDJ1rZ5unkibZgJCnxRrpeczfSYCyhPfQkU3VxNxo3kLWrVWSV6nTi4dQb?=
 =?us-ascii?Q?D1CHt3JPmluSKfbStG3Q0gQQrwuht49KGUZ+0isReMf4bl6jbVPK5OwvMFpw?=
 =?us-ascii?Q?HgP8i9e1wqXAaIlfLxWWvW0vTzyIrhwfrg7Fp6iu8+ZxerZcyOS4tElv4PBj?=
 =?us-ascii?Q?OpBVdygaWCiAI+whaVx/CV0gxQJNm+3jcLfzbdm7tc6GBKwrPGp70frdQ4yY?=
 =?us-ascii?Q?1tadw70KHGbysLMgWWRe/zaq4dqCBV86pQXmfAV9v96b2YbKB+WFzztn33s7?=
 =?us-ascii?Q?UpfYe7VDSwIRfX7HkE56FclH4DbU9fhCxFTL/JUoJeTr4ROAEieNizndWafo?=
 =?us-ascii?Q?v3IQ90/WXRoqz6lH4qQMJ4TQg1jh8XGzOUkfS6skcnPMnBfMmiUsyz50GLHJ?=
 =?us-ascii?Q?UBEGzbLLFP11kYe7GSBlgeb2jODd6e/9bgEotZZBLr/FHht7PrJtcxZ0CoG6?=
 =?us-ascii?Q?hJ7K5y9DRLpSy1nWRPE0+gks2NwHC4OCV8SESyXVFnRlFnhFaH/MdQj/umB0?=
 =?us-ascii?Q?cFq/gs90eM61hEuNfbrErxBf+YVVnQIRPGkg+l5D/J+b75V1P+ZkqbOCxMdw?=
 =?us-ascii?Q?gJMPTjV1xPXZccM7d1WbJNjLjzcl9EulDb2CGQkd5GaJLaRqE/YjzKrPnAGd?=
 =?us-ascii?Q?h36J7J9i1rTd6kfRnP4EqQ+KyXA7IosijhA0q927zAK3lrFytlDnjqk3eVgF?=
 =?us-ascii?Q?PFrU5HVSGpOlStNciq0VkB9QO6cYzuKRzLlCwI4ZGEYcB+rEUjv44qnFZ/i0?=
 =?us-ascii?Q?SxlvkStEOMw3H+c6xpO/aNWxwlVGXINUl0oJi9DEtDDFU4uEB5QCTjDnl7iU?=
 =?us-ascii?Q?WWtp0d7m+4BCSls8QChW/EHS8AC9QaXJ0gzQtl+4RlNh0GJEqKjypCv2eYY1?=
 =?us-ascii?Q?sf56PTwnrkV5Mr2kShn5ci5PBul2C+I9b5ks1A+vTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwqZoQylQduGp4Vcnbo+70d9/Hoz2k5T9ABmB/J/sj0ZtdkuKPf9Ks6DNaVT?=
 =?us-ascii?Q?zRIv9gBaXLGKteZVgq2dd2y3SU4+of4h7lz5No7MyopgitaDiL6X6lnuLZCH?=
 =?us-ascii?Q?t/echR0xihmEnU5PV5xqiN0bzY/C+fYni6cww8UC99nIOlazBcmyZy5lMkdQ?=
 =?us-ascii?Q?VEOWePcq1oJKDFPiAVB+wlJDA+43ZRxZpeT4McfkKJEGWGmvgxSfpckYFP4Z?=
 =?us-ascii?Q?i6WDS5Wcf+1esrgMSeX4Q6u04Lyt6E71TB5f45husC2qFRXbXWUkYanDq6oE?=
 =?us-ascii?Q?53XiKxj1yYzpbS2vX6Y2vBKpBqtJVSTybMuTj5H7GCIL2uywl9EvPPDh3ZNj?=
 =?us-ascii?Q?kGhQ8F1FUMu46DuK6BPW4AWp5I7vHcddoZ5ahYaGsIYsOLjNSgocyyQIlIHR?=
 =?us-ascii?Q?BH1Plpi8b73/9YbhbIbLZDqpiEN3bC7tUf/Ab+fhj62xOsa7BO2IWoN4+F2a?=
 =?us-ascii?Q?RVjRCK9zXF3iittZ+ORvnCcJkKsqEMX/I9Cclar6YLs/9cw7IkFePH2zcT4l?=
 =?us-ascii?Q?crGJrfCxdoQlQVKwMJzg8d3cKnWw+FBjNUti8XEGxBxhhHXDiTEF7jYzjcca?=
 =?us-ascii?Q?0PU5ysPlazl/GngU+GkmVBpWaU1Um7vgrfcoie5TlGugIZqYP7CUWc/3iytp?=
 =?us-ascii?Q?l3zsyXcRfJURH+JqQ2zjm+bcXGlkEhwJfvu7urx8YptQ8Atv1cYQyDjhsAOj?=
 =?us-ascii?Q?Y2oDXnZEIRp6v2bUPNLhdrZqWV4YkjiDwwBHEnq3XNkHbTCJFomnkC0q1JWu?=
 =?us-ascii?Q?RoR22DtzmDJrrCSDmJPVLokjKdA77FcJHy9zR+lPlZwseRmKvnmm2tBgY8FQ?=
 =?us-ascii?Q?D6Pntn4/hYvgUJKEmAx4c8TgIRJ3LMGi1TY7WGgxgIQBt9y0D2ltOBpsQ8OS?=
 =?us-ascii?Q?t9eHfY24I1eZSg8e71999QkgUf14Ae90aIVBzUKox0BbJWIvtHCZ9XT7viyP?=
 =?us-ascii?Q?jZRYuw8dexCTKTqk6yaBSWuNHSi3v9IeD4JYt0F2U6zxVymxizqxNg4K8Smd?=
 =?us-ascii?Q?rI4OXnGgibWrTFleA0ZLYprKnNkkOtfPph4+VxkTWPZ4ZagLshXCYmcx43Za?=
 =?us-ascii?Q?PMflDwnIu7gCj6WWtOd5VAwazOgfLeiD4iV0c78jlCsCzCXIXYi5uqCiOSyP?=
 =?us-ascii?Q?jaLQsOkKf49oRWVVfYdewcUr3CjlIawYoJZue5mQ1z0CPPw7i8b949Zc6Sm1?=
 =?us-ascii?Q?XQU/wWO+wVaTgT9i6x5IHfL2t+lk5SlK8u0Pp0P013nQDMvQ/sSf3gik1gMx?=
 =?us-ascii?Q?y4YH+hKUvDL++mFrEswsVtdZ04qGTKEFMyv/KRrVDlM69Z/+Ejx8sKvDRGjs?=
 =?us-ascii?Q?hhVMTElvs21nc5n5+RPksESzx/Gk+Qh8Frf0Z9kYGrdFCgo9tdbmLAp0+vu8?=
 =?us-ascii?Q?9VxPuo7F1zXrU5XMeRk4cgCxYo+7wdaLToqH6L5CqhkgXNffOjy0mbcIjIpt?=
 =?us-ascii?Q?0/zQOEmf56LFH+5wqWtyE9PaHjIWPLqWTJdx4lrBaP8an9xvHnr/rcn3gTVm?=
 =?us-ascii?Q?CFeb5suO32tEs2LTUQqAxdzA1fNqRpl2eNZ+ztx9rmBiVcpylWZXYFpTqQGx?=
 =?us-ascii?Q?27b/rEOgClChuJDEWRYsOXpyO7yFD5rGARdfuyUjd0W1GHShWi/HYTpQNMjl?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e9d478-5c62-4bb3-5e26-08dc663aae02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 21:48:59.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4OGgPq4ZvAxY2xutFEMhCtIHtgJGpE6pACWPLCHb/kaTKyPa8CNLyc6Zdd1/xJoAjI8VwHFYyPwGXJpqnaEzVFcQc7rQkwp7r+EyHCHX84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> In order to support dynamic decisions as to whether an attribute should be
> created, add a callback that returns a bool to indicate whether the
> attribute should be displayed. If no callback is registered, the attribute
> is displayed by default.
> 
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  fs/configfs/dir.c        | 20 ++++++++++++++++++++
>  include/linux/configfs.h |  3 +++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 18677cd4e62f..463e66258507 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -580,6 +580,7 @@ static void detach_attrs(struct config_item * item)
>  static int populate_attrs(struct config_item *item)
>  {
>  	const struct config_item_type *t = item->ci_type;
> +	struct configfs_group_operations *ops;
>  	struct configfs_attribute *attr;
>  	struct configfs_bin_attribute *bin_attr;
>  	int error = 0;
> @@ -587,14 +588,33 @@ static int populate_attrs(struct config_item *item)
>  
>  	if (!t)
>  		return -EINVAL;
> +
> +	ops = t->ct_group_ops;
> +	if (!ops) {
> +		struct config_group *g = item->ci_group;
> +
> +		/*
> +		 * No item specific group operations, check if the item's group
> +		 * has group operations.
> +		 */
> +		if (g && g->cg_item.ci_type)
> +			ops = g->cg_item.ci_type->ct_group_ops;

Oh, I would not have expected to need to consider any alternate group
ops for attribute visibility beyond t->ct_group_ops. However in my RFC
example I made this mistake:

  static struct configfs_group_operations tsm_report_group_ops = {
         .make_item = tsm_report_make_item,
+        .is_visible = tsm_report_attr_visible,
+        .is_bin_visible = tsm_report_bin_attr_visible,
  };
 
Which in retrospect is the wrong level, and I suspect only reachable if
you do the the above awkward indirection ("ops =
g->cg_item.ci_type->ct_group_ops"). Instead, I was expecting symmetry
with sysfs where the object that carries ->attrs also carries
->is_visible, so something like this:

+ static struct configfs_group_operations tsm_report_attr_group_ops = {
+         .is_visible = tsm_report_attr_visible,
+         .is_bin_visible = tsm_report_bin_attr_visible,
+ };

  const struct config_item_type tsm_report_type = {
          .ct_owner = THIS_MODULE,
          .ct_bin_attrs = tsm_report_bin_attrs,
          .ct_attrs = tsm_report_attrs,
          .ct_item_ops = &tsm_report_item_ops,
+         .ct_group_ops = &tsm_report_attr_group_ops
  };
  EXPORT_SYMBOL_GPL(tsm_report_default_type);

..because is_visible() at the g->cg_item.ci_type->ct_group_ops level
would seem to mean parent directory visibility which is mismatched.

However as I stare at this a bit more it sinks in that configfs "group"
!= sysfs "group". So I am open to the suggestion that ci_item_ops is the
right place to house item attribute visibility callbacks, or even a new
"ci_attr_ops" expressly for this purpose. Either way my expectation is
that config_item_type can get to the visibilty callbacks for its
attributes without needing to traverse any other groups or items.

