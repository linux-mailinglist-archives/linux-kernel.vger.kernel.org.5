Return-Path: <linux-kernel+bounces-136001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE489CEC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA703B22FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94796144D3F;
	Mon,  8 Apr 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loaZiQYI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989438DEC;
	Mon,  8 Apr 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618058; cv=fail; b=pgCHWOivLFb3LA5ffb+Y5jDy/Htfk1PxiS+sKAY8IK6CSfrutaicgx2BCE6H0eJMuPoqtdzxJUVAdknbIcaYsOo/qmhlW1amZMefss3kX/d1BcIzXGfP+TuSAlDJn8qRWjoUv/4iaAtO7LX/QiJR8f9Kd/DKBt9c/JlIkvGzU+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618058; c=relaxed/simple;
	bh=y/3/f/edsJGyYVTwjivP9O+cii6XIltVjCo/MypeCY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R0hVk0mUUmlTeriPRmQlnhpX8u4gkJJXtzX0p9trMF+XmUc92/OCwTIt8BrPpkb4xPbN1aZ6AFODOyhHe/A6wpwFuvfJtuqjr/FJFhvB3pYTUKLHZQhrWJlsZRDcOAWq+MOQ7ZX57/rn4bfEmcn7ZlGk9G+aXrB9+JVAYWlqSEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loaZiQYI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712618057; x=1744154057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y/3/f/edsJGyYVTwjivP9O+cii6XIltVjCo/MypeCY4=;
  b=loaZiQYIwzMa66lyPG7x9BsUaBdpARLzZyUmEXj3fV04JQ4hKm81B17z
   Hzfti3lAv1GPIB3XyRNDPOQ6Q7jaq0tpG6knHthJI5VKPhHZX9wq9cUsB
   8ToGRokXlIe7rs/LqAcaSDcd10Y+AKrFHtAhQikue2WarsZml8jpWl2Rt
   jFVkHdo18Ew44xvNEw0V2QmQxh/BsODA7mxFH1EE2Dnh0503W6hLp/p2l
   EG2CgAkIt0D1tdK/VqoRrvF39CWsHIuLg/sSTK6zBTIfacGVoKPp16amC
   1bRDGaojHLUFjld8ZNRZp6ytQjlJzSjCoIfbcOohDY7wVlbtc3jv+Qm13
   Q==;
X-CSE-ConnectionGUID: KrdMdUimSceJROB1qlqgkQ==
X-CSE-MsgGUID: qg27mctrQA6f/bxoy+prgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7788978"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7788978"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 16:14:16 -0700
X-CSE-ConnectionGUID: bhH4W9MRSlCOltgtyW4tfQ==
X-CSE-MsgGUID: SaR2uu2FTTSgKvWpe+0dsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="51223539"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 16:14:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 16:14:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 16:14:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 16:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwPALRML/baLjQjysq11UCIsDhCZcypxz+P2JB5SB3dwN1aaR6GDfCbgF7WTejDUvtaHf7ox2nc2UVcexiBlnlu/uj5DKtAB0TqVym7igIwD9UYLqt9E0zoi0MSAHx3L+BhUn4oFtufSY1vGiJ/xwv4KzFJ+K3qTgiXS0SnVsjMQaKHoQISF6u2CMYeV+6NkU8Tz5/HmdRR4yCIbgEWvq0/mVyHMXhCFrwjdVEv9jtbGb6+/Fw3A2o3pWA4KsO8YCRWn0Q8+2XJ57nleKTVtsD23mAM8+wx8YH5kUlvUigQURu/eVy9vgT+RPn8ilVHj3PoJDYanAFG00SR+3WeWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdo6ZAYm/IhBFF+/LXx7koh+dp5mTZMDLKgt+V68gro=;
 b=NmmmDk0NUjHj4uAeOG5IIDZgHa8JWemhnEV9SU3AQWoXN2XDhpTOyIsUc8DsQxQVquTPxXKQz6Jlqj9d73t6ZIAEGlohOfOL2bQuvjnh/PYSKMb6cjcYgjUIHbrGSvHwQdxB1QCd0tBQ3I25e6thro5XP+EtcdsuEwS4xOMPOc36ZaXpfXyubxZVHcW6WU6fYmHj0fw6BVVL/EkCDNDRHFXZMsX7tAs91eSSGU0UH6rh2jbZuZf+XJhPNaGRpp8yfqxiwPNFoc6bG3lVC4PepJtAv1Y+uez8eh1ATVd+M1xsxq/+Kkz7x53fjA38quVkZT1NsqBG2XDt22MKAFu1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 23:14:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 23:14:10 +0000
Date: Mon, 8 Apr 2024 16:14:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: Re: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Message-ID: <66147a3e5c55f_2583ad29433@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240216160113.407141-1-rrichter@amd.com>
 <b0f5e2ce-d39e-4a8e-8f2f-ffa67b604e02@fujitsu.com>
 <24b8b11d-a7ec-42ce-9fa6-8a24701cfe46@fujitsu.com>
 <20240405175711.000032c4@Huawei.com>
 <df850be7-a9d1-4737-bc64-3fb682cd5691@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <df850be7-a9d1-4737-bc64-3fb682cd5691@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0339.namprd04.prod.outlook.com
 (2603:10b6:303:8a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8444:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9s/6pqYLwCmgknXiHNazhyRR9iwmo3vq6DN0oq/E0YIuARObzjj1RlhzS4L9SeykqkvwK605Y1xzBNJx0GLEZW3kKxSKbIRae7mIr45xx08sleCZOEJBS+ou2inkd6rFvXhZ4+W5Z4v4XCDdTwz1fcictLVgKIJR4Itja8NeESAn/e4psETQ/KbP73f5KzbBBwsSoQ1fD0o2BcHDeXe7oUtmx6J4LOoX36w+g1xx/X1Cc39f0jXfGnIBvolXKgUPHtKYbbG7i00KxDRIPw9xThpeoYM4xqxMQ0sZ7wNBhxO+L4gEhogvyY6u2JPwG+5R9/ySjEO9HKjeFaS6p1Y7mkntvhVtkC5b57rJztA3DMPdO8yrw8wEyVfro1oXtCLNUPE36MHgYNZb9AwOSb0TsD2GzzDxOvw3cz+vCQhwCSdOUidFZIAC1+eOqzOovN8IwZFQ1g0BoMdMl8PtNEK91hclplGLFD2uKV46viayRRZ0MR5jhcWZbJHzXzVJcVswPxxm4zKaCSaiHUpj6b4vhNt2ZIT4fN/fvtyATdN1wlnBgHPD6R8B0VT0MAOvwKFWVxxEIu+dpb2xabTzhUkH15MMtNzExJwDYcXVxYQRHRH8L2BmYUJARGBqGywbe5rCeaT5pIYNlYVTMwJo8oOr2/YaRkmnEOZJinp/FikjQZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rms/2UuPmotwlHofeZACdSMUNpHMXx5PTomKn6rnYCXfNiWyD5O7W80QTYfq?=
 =?us-ascii?Q?ZJwnkF95QqIlRtYrvevhZM3OvbU7U55iWPTx41AzEmgYn4Z1QQ/6Wx9IzjOa?=
 =?us-ascii?Q?zZK5XEsnGcd4KNExHI23artZf/H0EITwhh+b4I3VcEVV3itays0GiBGiSWhS?=
 =?us-ascii?Q?PNyPnDMpO+YiQX5K1kmeeF6rMuzHOL+JFfS9Sjqc+h47xqRs5OpoMP3nOyyO?=
 =?us-ascii?Q?BBBUlfCstdy4TDkJq/h7EIo0LnWgnXLF+Bjof4dj7HFNH1BQMp+vZRt1prMg?=
 =?us-ascii?Q?Ikpx236lheCge6ue0f2xyLKdDyKM/OxVstQoAEQQwng9wNDcHhvtc/pIK6i/?=
 =?us-ascii?Q?JgSG89gpkYL4yPq9GmA0JwwwZ+EGQQ9S5pkdyTktO2JvR0VMmLOhGg1UkJ6a?=
 =?us-ascii?Q?O5+9F1FCBZUBu4Tr48+Iu53flNgw2TPrW/r3w83Bp47Tau5wwHHyj4JfPiKB?=
 =?us-ascii?Q?687MgqFmPGWAUmZ4WgbbFc4atoegt+8uw2N5uvfpJEd4ivL/rrnuU9lvfHCK?=
 =?us-ascii?Q?2bYmgGuklaNWLO5AL2SnEnuIM7pBrDrv2MeNc98B5nSaogWE5Rh0Ntw912tn?=
 =?us-ascii?Q?1Ms/pgkAf9idnTCfU5fPZXXLvFcn6Jtn+zlamGiFJxItebeHrImORFyeA6ri?=
 =?us-ascii?Q?StCyuWNp060luwlZVBAcdWu5VYIz+Nc2g+chP65nbRWrBQJAxjMfsaVk4qJQ?=
 =?us-ascii?Q?tTk18656o1ok6Ilfphy/2sLjFJpQfhD3aa2Z8yMdOqn8lf6hb0ztzpRBoCYE?=
 =?us-ascii?Q?vEC8BTXqfwW5qjhAcTUbN0AbNfK/V8Xp8rjRlHXsfs5dUxQA5DGYUnbgRqfu?=
 =?us-ascii?Q?XX7R84gEdNv/XuPliEnHlbYubldS71ybVW5U16JMCi8nSM9JCV2d6IxtDX44?=
 =?us-ascii?Q?PV03doar+Z5K6L+5wQwafRZpVcHGm+YmwKMs3DuUh0CCyC3i8fdinhcBQ93g?=
 =?us-ascii?Q?APRhiGvZkR7LU8tt+L7H0C0G1KBCvG/97Skfr254TbHuRgDwrpkbk+QWWQ7T?=
 =?us-ascii?Q?UlOhs+720yQcTmEa63jatX30wYecYuszdXLsDfKPmgxu9lp9+NX3dM2qnWoG?=
 =?us-ascii?Q?RZEfDUn3TVrvesqD84/aetFYNQj76TGcG/vIIwjLB4PKue7Kyr6UOeAlofuf?=
 =?us-ascii?Q?eYNQpZwi3anYbgfxttRb9vSonF12Ju5jFYicxY3f2RsHZ2Koebi66f/Sfldt?=
 =?us-ascii?Q?Ztd2QksbiPgvgnZfg/tCeeloQ/H3gSLxATAbZQ+9I9KSJuLyQVKFVxkkQBbZ?=
 =?us-ascii?Q?g0/S9O9pawj2jFm1/dIHDzOvmUYNcwUabh1p/zXtQvvddeXrzP+67UFOCE+J?=
 =?us-ascii?Q?MS/let2yfYqpCvJAtMH2mGRJvNXPc3+T+GMcEkvngjloxjuTLZITejqJczY1?=
 =?us-ascii?Q?sFqXH4Upmvojmpr0x97TgoTeu173BFn3YNb/H6QN6cT5wpUiqKPq/v47Vorf?=
 =?us-ascii?Q?OSUKv+5cmD+OPliQtRzVp6zEbnRpfWKEYTj8vX9ggaX2zdiPgcr48UBX8WTf?=
 =?us-ascii?Q?kgIPLOwS8Idl71vcAkmV6JcVdhuI9nRjvJn7Ki0Yhj4VJ7Lf/wJQvpWkA3kB?=
 =?us-ascii?Q?6zkNsa+Kd03Sy9oYQL87aUxo8G8NeixSQ+JIuSqr78dAaT3byFfYiUTi62AV?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b42b1e0-1646-4f30-b126-08dc58219804
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 23:14:08.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbZq6bNfUyKQgegK9Wp9jEWM+8y96gPbsnQDFTQvzJ5gbKiyw2TD+ylzxpVJb/uYqhWL6KUkDsw/EB2Q/X+rXOS9/TRksqrNF1euWMwolT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> 
> 
> On 06/04/2024 00:57, Jonathan Cameron wrote:
> > On Tue, 26 Mar 2024 08:26:21 +0000
> > "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:
> > 
> >> All guys,
> >>
> >> In order to make the CXL memdev work again, i have to modify the QEMU side
> >> where it resets the "DVSEC CXL Control" during reboot. A draft changes is as below:
> >>
> >> Per 8.1.3.2 DVSEC CXL Control (Offset 0Ch), Default value of BIT(2) is 0. So is it reasonable
> >> to have a reset dvsecs in QEMU during reboot?
> >>
> >> Any comments @Janathan
> > 
> > Hi,
> > 
> > Sorry it took me so long to get to this.
> > 
> > What are you attempting to do? Use an OS reboot on QEMU to check that the flows
> > meant for BIOS configuration work - 
> 
> 
> There is no doubt that *the OS rebuilds the state correctly* is the OS's responsibility.
> Providing the consistent device state is the *Device*'s responsibility.
> 
> So on reboot, the device should have a consistent device state with a fresh boot.
> My changes intended to let *Device* emulated by QEMU provide a consistent
> device state.

Why? Typically the QEMU CXL enabling is for basic checkout not for
real-world fidelity. If QEMU reboots do not result in restoring the same
device configuration as a re-launching QEMU, why is that worth fixing?
Just document it as a quirk. Now, if it is a simple fix, great, but it
seems low priority given the enabling is really only useful for kernel
development and relaunching QEMU is expected.

