Return-Path: <linux-kernel+bounces-160722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6048B41B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8DD1F22A46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CAB2CCB4;
	Fri, 26 Apr 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5ShIp4s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AB36B17
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168736; cv=fail; b=XpZ4uSU3oSAUy7qhni9TNMeHti49BNGJeRfxtL6fo8gflhaaptces8mTisYv8Y0h0HkqjblTz47Uas85aZk3BY4HNBKLzhC9lZ9qfUDZdNm9vAPDMW6ezSjRPuwZWbQmTU72YB7gYaWTPXb8DYtA9F23QCdwG7vCI6sZ2oUwx9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168736; c=relaxed/simple;
	bh=GmmfsK5O/zlp7INMUA7Ywz9NUb5G3rW31M5aUneI1C8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mxeuaw5hyQZP8En9o3QVDV5YKUjblvVTK121XurZwfWz8mji6eeFUFxxK1qXtFKOeCfNs2il8bETb9BZxFlCcNAtKFv0GS+8y+0IMuejwqUnzBqal6fIMXVwSieK9hNLuQUqloBQSR5ki7SE4+P6s7r0eObsXU1E4KgYepcMoAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5ShIp4s; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714168733; x=1745704733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GmmfsK5O/zlp7INMUA7Ywz9NUb5G3rW31M5aUneI1C8=;
  b=j5ShIp4scjepS+ASmRiJNh/kc4xmp35L4sY7nHpdRwzGFZoOvcUvs/qL
   F536VEEuvPgFu1O5ifkpFeABJWxjUANCOWO8xwJTqn6R/75NzrFprXFBj
   ekO9+cGFgdl7hA2H7v9rN9mRVUWddE/hpnn0D1ZU3ZdHs//eUswBF/JwY
   9OYTWYT6dAOyZh/kPsVj8J7Kdk/5A1Y8SOM3ha83whSo0XIUrHCseOvLx
   DmgHWDABTEIRoWzV23kgIhtZkTep0I5/iGG4aLayh2D3UODwzWl+zaK0q
   HGZLjo/r8f7OFpVQ6H5vgD649q95ZRTiv/ZpxbmOnbOjYTsukTJuG/6gk
   Q==;
X-CSE-ConnectionGUID: 5eHH7j43SzOC1x/cPMlvyA==
X-CSE-MsgGUID: 9kAjilMIRNCBzS7cV0ATfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="12856327"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="12856327"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 14:58:52 -0700
X-CSE-ConnectionGUID: Xcr6PPIvSGGPHU2hWuLBwQ==
X-CSE-MsgGUID: Nz2XHTBCTPG/badvjrR87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="30343288"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 14:58:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 14:58:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 14:58:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3ba7Jubmo+1RqlERlRtA43OiUBEkZkn5Mr0TI9hFSFR/g3t9knHPXiTwQuuU6bcCdw1bd4Bl+yxTFy8OHa2+tV8n0bnMrET2qCt+OAFwKqaxNfPQ+mcMFluOcHbRE/Mpo0TQlBS5REkpnIxM0Ad7cl9sqoJkGREVit2HMdqvDCoP1/dClw0CNqvUeW2Bm8+h3j7VAtS6fFPUWoCUaEDvfHA0Nw9a+JloO711emYDAHCOZpme8iIfVJJvV4+kUZj5/IMGFVno/tU14P9s1fLhc9tl9QRt7w5LdY3VnjxIYLAHS+ORhALFCufgvgDa+f/Dsz8hXiwkXTDW6bijFEJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSqBHZFpMANnUK1XJvXzCJ57ysgwHuKgupsElfSa/oA=;
 b=XUHzanX8iC9eZYLqsDMXKRw2uobErBuQ4a9zsHUQJkLvSO7500kU6rdr32agL1y9j2Zb2XMQIzQDl/Bx+EXmTo+2zfMTrbPg6RNS2MRR0Y4H5FVur/nPZbYdW7slEemi3SARIc7eKqO/R1kJWqST6rzKYJ7K08cUHaS39o8PUnfod7OpSpLxCn00oMn42T5f3S5PZMuSaV7gvWenf0ai550viIPlDufbyW5Q7ciF4nibhNj2/hX+1aALmxKMSlvoFM+mK3lpn015AYHvnyBVrqa+LjC8aPUqWbfz8uq34sBgqTzUttpwD8cz043BPnOwOunN+KMly88dDQSLJUD8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5795.namprd11.prod.outlook.com (2603:10b6:510:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 21:58:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 21:58:49 +0000
Date: Fri, 26 Apr 2024 14:58:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
Message-ID: <662c239680842_b6e02944b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 033ce2a1-b6e5-4207-8fd9-08dc663c0dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QvBOraZf7tkF6+w/IkYJ4jeG/gzx8H/p50MIMIUwVouHU4hOIgO1jtWaWZ59?=
 =?us-ascii?Q?3P5lHQLDYn7afgWgyJ9uVPPoYIfCeDsId1p02jOCQTKRYkToEZjP+PnHwhFu?=
 =?us-ascii?Q?h07ivA5KVeai4Ttlx/hM5NTuju5ZnkELLYzsXpnrqZ1MjEn6X3BubyWdqAl3?=
 =?us-ascii?Q?7DJwgv3fcVqJwui6PggVGahhcKwYeURZS+b92Yzo8/Wo6z7YSVDjM4qaWo9P?=
 =?us-ascii?Q?CxGkLr4oop9wj7LbE8HXiRyr6Wpoa6f6TrUCKymmPYX7p3Ci1PbNQlxt42WO?=
 =?us-ascii?Q?71S1CqACEEQlHAe/t6WJxhC5WNyVYk/fRnmqqypocm/UzVjpXUF8Xpn7LPMF?=
 =?us-ascii?Q?nniJJRysr7FcN2B9PH7n3qDlwg47RTQXaoFpZY0DHM7XSAeILuWluF47etdI?=
 =?us-ascii?Q?F3jww03Q5fW1cFFo0NB3JcJRpQ0Gl0vIMWPQSayTNHcCbTtxeObkYUIgf5Rl?=
 =?us-ascii?Q?TqgbNzt63b+FRptmK2l8Kgd0eQaap8tkzn9fXqo52rkTUNy0UrNvtJqG5PQE?=
 =?us-ascii?Q?QWAWkG051Q8h+5SfQ8AX0SUwJY31FAy7udHGHPGL4yV18acbPpRwilXqekuw?=
 =?us-ascii?Q?95eDaMu2pV3yonpyptTFlcjetzaG7O9+bdPynEdBCzO4oZYUDpOIsJwlkbl0?=
 =?us-ascii?Q?ZRjMmT7UfRxT8xMrcLBYw5w/4/XDSbrmNBy5yz4xytosLg4Piw1eNVRFcDSL?=
 =?us-ascii?Q?ns0murov4FswUlbwHmHhT/ZYjJAbjL8f2DXJrrGrFg01JEXP97cF4l27jVwK?=
 =?us-ascii?Q?ys7/KGqsWkHmLUF1cW7NpyCvrJjRKmfF1o0MPX3e0k+cLVxfg6vU2iaOtJPo?=
 =?us-ascii?Q?B5MTCjNJ8A4SZOwvN1qUWhEV9N8MnFqifqszikM0Cj8VhRqUlu/Md1nCZL97?=
 =?us-ascii?Q?+LR3+ll4/AWzNgI1f8JlQiHh1c+NaT5bCKqV8z5qbkiJroA7RRqKxuub3ETW?=
 =?us-ascii?Q?4L4vuEc44dmbOLLjxtw2trci/n+Au30CC5UDjBFIdXRsSV15Hx9aey87mPSp?=
 =?us-ascii?Q?506CWGOs4QqFWSv5daS2hECiFWTZ4PbyUXRN7Dh0ifW1mSK0DbEr1PlrQy05?=
 =?us-ascii?Q?LNRiFUzPBjp3j2ERkXzNUDAdc4V3hrePYfh1zXAfwHXdhPagpAhXuGd3swMC?=
 =?us-ascii?Q?RNxUjUOQk3XbdToJjSAKa+t4ldcA+1XkS+PADC5r8alRKuMd2RR6wBlOTbnB?=
 =?us-ascii?Q?sTQnt1sGUEc5a4KFXn+rQpf3yR4v+We1VMXXY0fF4rUk/bLodOLQR2jf9wtX?=
 =?us-ascii?Q?LykR3a7W2as4LR/eRC/JXfJvKk16gRi7YPdaX5Jzuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZbSC18IFJbRpOW+JVZZOf4nFlYAHbc15+0DhJxR1HeTYyCrjqGa9SixeTgm?=
 =?us-ascii?Q?RJffpjYttd34HmtAMzzZsuNWIeTgTcGKiVnnbmMDFnKLx5TVeCFiFPlKFf8c?=
 =?us-ascii?Q?RRKhNswnXEIoNDmuo+RR6y1nJndDfwt5ASf30Dbj1rzsShaS8Dn3k8sO8kUi?=
 =?us-ascii?Q?TMUZlIy3xhXsB3tLsqYNH/t2qoW2o7QMfgoSOUxMhftDPB6ICV3A/ucPzfXz?=
 =?us-ascii?Q?zn/aM+IqaYR5TPguppaz9vdQCNiYiO/GjtpA2FWED12HSffhkWzJG60PofSX?=
 =?us-ascii?Q?sAeyhyvPsQ3acn+rh/a9GqwVeTP+KYmd+ZOG+XNeiZcy9n57plXsCX7KFVdw?=
 =?us-ascii?Q?AgyMlzfwMW/2PUl+llYqQqkhI062bCJcURYhmsFdSeDS4rkLjHUKDZ8igeV7?=
 =?us-ascii?Q?RQlyz5ytf8h8XinTb8JWyc1c9ixj0WvXGiQe72xgLBO2iW9n/P/Rq30Gh/IF?=
 =?us-ascii?Q?6RUPJ73IvQu2oQZevkMX7Ijzz3pdTxCKbq/mijYMe+0/RGKVhcdI6mxou7Ek?=
 =?us-ascii?Q?h8SVvkMzrS6LATuRUoc49Mkh3JbPSAzThv13qVLgr4ZujCdRY+/XM1qOkfLs?=
 =?us-ascii?Q?iy3XMh/P8XkAbb0IuppdUHFuieNd6ShzRM9wKuXidtVfzxuuH2/WpEvcnn+d?=
 =?us-ascii?Q?6AvvUpO7cc08iLPjoNlJiKJ6bMpWSlF+3lx7RjRUUj/wP+HFdVVAdDy4TXcI?=
 =?us-ascii?Q?s4RfdEH32h1CVKdGRAiX4WyrRvLL9+VB9VwSkqhRCh5x6Z9b63hB6Muv0iup?=
 =?us-ascii?Q?hSeijzFsc6wj9ZMC887wfPYGIJBD4Ye1RZYiHuWoDGc3Dnmrmrl17PNiP4sw?=
 =?us-ascii?Q?GrCiSVeddmUTElC1RGgJzsHfMTDLawpRLuFcpMD5xUB9kL5UatcjVnU7S+dL?=
 =?us-ascii?Q?xoQswcMZLUiUyFEynCD5kyS6HgxU1+FqibrnaJqZtQ/rAmSrpgXqiM6A8x++?=
 =?us-ascii?Q?UNGjoGg8+gPVl5P+IsizqFIBEoOSImUcpUuoj6URJiiukF2B6g+zELCIZmPp?=
 =?us-ascii?Q?S5nvjvBY4+2Q1nmFVjr2yrSS/cIR6M/jUxMF0lF8k7C/pJdoAgcGnVSYBvV3?=
 =?us-ascii?Q?CXvwkJopEZX0yyrjXYqe0WobpM6tuhqvvJVt1y96gmSwGQizxAdZ65iHvkxx?=
 =?us-ascii?Q?zC3Masv0XEnapZP+cudR8zFPHslodliRngDPAZqvdtEcZqf6MsHZGkGsaz/G?=
 =?us-ascii?Q?YZp4UbLBT+BWKBOCDF0dD7ESqHIkvSei3kZxmMz1r4wkWqTlHA/xKcAEjW1U?=
 =?us-ascii?Q?i5FTcsHemgkjF0LcrtAUe5xLgLX5MaTgj12TJ1ErA7pyhWkBiD6UCwCW1Gl/?=
 =?us-ascii?Q?a5QJ/0QRV+bYeOnKdGir5Ye8I2JPhiARZzLhxEshJ5zXlaDpsjuawwGn+YFX?=
 =?us-ascii?Q?u/6hNiPZzaOvdI7WVPjdYw6QaC4QR/jdjmHZOnBkBVOe/RQb5eSOHms1glvG?=
 =?us-ascii?Q?54pQtnloFSl/5pJ97XodSpIzvtDNRLuVG293g9FpoCerTEmW3/HZwzr+xJdz?=
 =?us-ascii?Q?1D3LfXKFG1mjt+F/yoqMfDzB5nNdbRpBD5FZZO7yfvy6tAs11ayEkUbobSeh?=
 =?us-ascii?Q?miDWgmnLaPgdx4lbHWdG3XtAqERtEnxjTiVd/xRL54WyibkAxH8Wn5yuoXKZ?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 033ce2a1-b6e5-4207-8fd9-08dc663c0dc0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 21:58:49.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ug64GT8UG5i2WX2E501+aDuwozCE7dZ3W+8+LbcfjKQ2Yjyu6OIDpiPqcMpKjqgmYSZ13rQGtOba6Q/QCraSqyxetmiFYCnkLfrgwacuTew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> The TSM attestation report support provides multiple configfs attribute
> types (both for standard and binary attributes) to allow for additional
> attributes to be displayed for SNP as compared to TDX. With the ability
> to hide attributes via configfs, consoldate the multiple attribute groups
> into a single standard attribute group and a single binary attribute
> group. Modify the TDX support to hide the attributes that were previously
> "hidden" as a result of registering the selective attribute groups.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 29 ++++++++-
>  drivers/virt/coco/tsm.c                 | 82 ++++++++++++-------------
>  include/linux/tsm.h                     | 41 ++++++++++---
>  4 files changed, 102 insertions(+), 53 deletions(-)
[..]
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 1253bf76b570..964af57f345c 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
[..]
> @@ -249,6 +250,30 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>  	return ret;
>  }
>  
> +static bool tdx_report_attr_visible(struct config_item *item,
> +				    struct configfs_attribute *attr, int n)
> +{
> +	switch (n) {
> +	case TSM_REPORT_GENERATION:
> +	case TSM_REPORT_PROVIDER:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool tdx_report_bin_attr_visible(struct config_item *item,
> +					struct configfs_bin_attribute *attr, int n)
> +{
> +	switch (n) {
> +	case TSM_REPORT_INBLOB:
> +	case TSM_REPORT_OUTBLOB:
> +		return true;
> +	}
> +
> +	return false;
> +}

Why do these callbacks need @item and @attr?

[..]
> +static bool tsm_report_is_visible(struct config_item *item,
> +				  struct configfs_attribute *attr, int n)

Per the comment on where to find the is_visible() callbacks for a given
item type, I expect the need to pass @item here goes away when this can
assume that there is only one way to have is_visible() invoked for
@attr, right?

Other than that, this conversion looks good to me.

