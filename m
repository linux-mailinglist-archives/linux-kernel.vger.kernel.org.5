Return-Path: <linux-kernel+bounces-166790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891118B9F83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F39228C213
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A916FF49;
	Thu,  2 May 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIEimyef"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133D16FF39
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671004; cv=fail; b=R8QjG8EVAdTLliLhbwXQ2iJ3B0O9ypeGoM9QP/l9ehaXYz2wj5Kw4Pw6Ikyeb1hYbDfpjdOVhbxHQx8AQLKCIyTpY5bPnI5UWKNsVwfeLcU27k7+5gtrDWxGXr3RDvW0QqEjuTPisZBfVV6aJrvpzrBe4V17MjnfEDiOT9hdJ34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671004; c=relaxed/simple;
	bh=Mgfc6IXCSZTUf6HA+pe63+mOjVvJsQUoDTI5o4F5irc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxWeWZAsr7cZI7EuKNokW+JAWlTDTIrUEd6lm/2h+CLlZcq8Gi24hYqyLUqDUq+dc+2rRnTaLfrtSqOvOZRpDQWrDfnVvTag0JLFcPnVsOJmouR9NE4O4mUuNeKlGpr+xMn93hYzCBu1H0aUj/zQVMNs5fsNAPEDiFsvonb64Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIEimyef; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714671002; x=1746207002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mgfc6IXCSZTUf6HA+pe63+mOjVvJsQUoDTI5o4F5irc=;
  b=SIEimyef6t9zWONzsQqiWOYX8gly2rJjuqbn6/2CSoOsHbOujTXa+ifX
   A6b6lt2pD1N2uPrsjaLMcPPka9ur99V3/nTUcywG0Sg4Sf+z+LYaR4ZrV
   Pk7erUPFZBMVcTg8CjX9spX6Iio3cqE8gV2QZr0Y60dJbJotEPkmraFe1
   YJjvzitWH1tWAFGKb88h2d5UdeM1qzziNmFr11boET6Zobz/6CDxzZXVK
   9VikhUJtMhkzJpsCzNvtPlazshbqEQk+KcHAxa8I9yV3TNdrBDcFKpA2q
   bvqknGeAWNZfWvUAkKP6aol+22AqrcKBP+qfZUEPTMVQNOkUf9aOrKU4Z
   w==;
X-CSE-ConnectionGUID: wmRNvietQw6UZf0AxiWTwQ==
X-CSE-MsgGUID: jtKUrj76RYm1AQG+XoXS7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10579026"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10579026"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:30:02 -0700
X-CSE-ConnectionGUID: DEjczX1aTHaquH3J/2AEEw==
X-CSE-MsgGUID: 78zrjoBZQM2mCOC3jbG4NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27201813"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 10:30:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 10:30:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 10:30:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKohFs7bBSwbTwAlTUJeTJiu5Mf8VRFJUtTq7EnluDH55gk61jmlz2VSyTLfdWt9myn5h+Fc5ZfOZeLR+aYBoIcH9R9DO9dDPAx3y32JwFnpVkjGCUa9zTaCWArvAnkzA+Y7/XSnH1ocUNj6iWTJo7Ijy5hybvCtrQbvBA9llo6t+yy4iJ6RtQcl1NIXXQLoWHSyAvYe2ICTja35mBKaNxD8KUUwoW1UlZlTpHozHv7lDLAp2k44nfVaRGWXGqd3q1pE3cydT5WlHVTLZIAX28R7SWVWMu11sfYgnwn/1SFeyrksdg2ghAnX5DxK7vo7vCEl0q/kN7zhWsNE9v/EYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mgfc6IXCSZTUf6HA+pe63+mOjVvJsQUoDTI5o4F5irc=;
 b=KlRpmESqWMOjI5poG5FlzRMhvjIELactEULS5LX39a1K+/M+dzmwXCWrW9bCksZVStK6hkLEVrBZI9lC46jb/S7rISnFOAWd/SJqulf00DBkqcHvKhj3D2Bba2YLHdu2RQEu0Beya/JeiZsbMztbP5EiJkaVcmODlk31+ukWxbCIuTJXEN5JiOf9JRAIu/SVuM4QCIiCqbLy0lYoXeMe/kRZz0rcmJn3EcPXYFFoATG5W0XhbDBtLC/hAkdzYZ+6vYjDp8rZhkfYKFvCsEKbuw1pF76SEhGqtCOitrDy4D+jX4dr7sRScK8fz57FHV7J1DBR4tlWndzzv7jVB5kZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 17:29:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 17:29:58 +0000
Date: Thu, 2 May 2024 10:29:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<svsm-devel@coconut-svsm.dev>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Michael Roth" <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
Message-ID: <6633cd93cd0bc_138462942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
 <CAC41dw-g2=jKkevGOJUqnzYTpxQ8+Z_JxnNNuoLR+CM_yqfRzA@mail.gmail.com>
 <6632a2e0738d_1384629442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAC41dw_Dnm=suyue+jFx2z8f+YT1K_aWfQEijrU=WH4OLWpOqQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAC41dw_Dnm=suyue+jFx2z8f+YT1K_aWfQEijrU=WH4OLWpOqQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:303:b6::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d00b07f-6dd8-47e7-75fb-08dc6acd7d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?atN3FSFxXBlFhCpsOFg6QS8cZXpDf6RbVR4RN0uj7+IgsAh2XXf1puzfgMD4?=
 =?us-ascii?Q?UqjhUQIUzw3QvBbkngQCltAHEBIFZ+5z+lhR8KCgWPuCo9OnGAjnyauSNfEl?=
 =?us-ascii?Q?UfN5RSB2glHuuZ5qlCT8TNkKlgT/UBR4lZFMEuI4G2lLb6hOvsUtQlP3TZ4B?=
 =?us-ascii?Q?o7JwEX+eWo+4PxRn8DIvhIKS5z5bV5mk9fN1wlxED49r06P5vGPlspHqdiqq?=
 =?us-ascii?Q?+IBYvSDlWzZPKyXUUwfrNM848fOPqf3mkgXvk3nW+PGvaD8370pwDrE4IjUh?=
 =?us-ascii?Q?u8YvWFjA1gwH32/7t6Wpx7AVsyZ1zRwKDm0oN2qLKzAkLzkvBN8oxiMgM+4W?=
 =?us-ascii?Q?iNCj2NoeXY1Dk4ohpLsoPZKo6fj44uqSzZA0EpfDKoyOerpwHRsGKaUdX6DU?=
 =?us-ascii?Q?hLV7fDapFHw3fWZWdkjmMc2lu+1lZwDe+JEHj84IABhjEwygc+LobwTX4Lge?=
 =?us-ascii?Q?S51FiLFihv1wDClnkCHAYCKm8ND7XgGe8y2iRUlo7t6U392Nrs9b1Iy4FL9S?=
 =?us-ascii?Q?LgrhAH+7KlPm/+bdQ/W1O8+lvL1eMe0+9ySBWnEqrdI7CdDn/RLEEuvuNGSg?=
 =?us-ascii?Q?zP4/O2inhtKwyvfqJEnlJOkEnkQEV0y99Ch+uIk3TSh9a3VUBp0aI43M5UmX?=
 =?us-ascii?Q?jF+423T0w3vpmF4UbGNWY1DHK8jnT7T7kbVtzcNPn+PbLlbXw95t93M5QMpg?=
 =?us-ascii?Q?12VAS0llTHuOb9YdUvtcnQNnjj1WoD9bpfZ629cwMEK0ATABDkOlXEvjOOWc?=
 =?us-ascii?Q?lPgAfyxVFTid5JCwW7oOJMuWQ+A5NM49X+4mRZFrC/zjaBHqcQZNOw/EQ/qy?=
 =?us-ascii?Q?8z5ZRwlp6VHIiwPcb0q5BwNGhHGodK9Xdcbl1/ZLpRqPB7i6xf93F5MxPK0O?=
 =?us-ascii?Q?Zu93snK6KDrBQcG3Uw9ZiL8egwL8i3SgY+SuV9S7BCyULTG/8DLNmfDVOdL7?=
 =?us-ascii?Q?VvG2j8zXnCKpEm3amtdyjnIHZxESKXbxJTDvtSUBtvPB0hltCcIXUPurCYkg?=
 =?us-ascii?Q?q1V8FSE5Ii/wOMxUhLJwjbaZdVgVtIwxUEQB9BjBkkp3oiOW1Rvm64gNtube?=
 =?us-ascii?Q?iZ8lzor/9F1gc19/7Pa0xJan5BPLjjTRUOmyk5ENNqO0+za7dgqUDOrufWjp?=
 =?us-ascii?Q?n9wrnD/ZfZwGWmU0KKjcSYSPbMOV9uGiAkGVmHVv94trq3l2FlfTzA9eFSRK?=
 =?us-ascii?Q?ywTKtWqNAS7ucZx26LIipeZwJO3zsHHZdfsnBHm4BapfAys2nFKpCh9mlBhV?=
 =?us-ascii?Q?samgCH8cCezqG+CjqBeZP5cCEqjrsjzFFVpxeuHTTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Xd6X1F4KXHMOPWZ4G/pBfxDgVsB24YtOnzbazaLeUOCdor577CHxdfQxYmm?=
 =?us-ascii?Q?oExTkFWcFblR9RDDwb+b/+DFPWkL2gLzSVT6PQy8d/CTI6/panpkzv7gDpOt?=
 =?us-ascii?Q?2l+iiLjkvLzmWZoR4IPB+QVeVXNG007ZPMAwmPARVubFlcPc7ixXwlrZy0hn?=
 =?us-ascii?Q?Y0AINXQE74E90Gmfatcl9aWEVko1pRmqFCFxnm8PexlaEO37H1W6vGByh9Vx?=
 =?us-ascii?Q?jhH5Zx67o/rvOlS1r4/PzEPhmvPDuRQAmFucdcb7A+EPZHqlxoOWvFzkljBf?=
 =?us-ascii?Q?rbrv4z97m2cB/x5FZc0Iq324rchEpI/5mG/mTyXu8VQRcDOAiSyry7Xnuk/o?=
 =?us-ascii?Q?eUNosQgQF8C9gacrkpJlcjRn4LEdmhFvpi+KznzduoXPvWjXRYHPlK6NuzCt?=
 =?us-ascii?Q?XgvobMNHgYyfH8JBk73+MdYTcoC7wBuQeprs7Ees4tIhLgwfOllgbKWobOsA?=
 =?us-ascii?Q?X88pBS3B22HZw7BMSn3AqEZBt/5k8LPZ9voAxUm4WZ8MZGa9j2+Nb/MjhscC?=
 =?us-ascii?Q?4JcShPxJ684C0UYD/g45/t1ieQqIlLQ1Nn6kWg2bRF/sGv8kq9Sv193mfvdw?=
 =?us-ascii?Q?ObkC6OLsMAr5ASEDZpj2/oYKYa8dHQYGrciLjvcETViTD8mo/c5KAHgySF57?=
 =?us-ascii?Q?Dr5JzfG0ZfC0YhDyeDLTVlC1TcoyURwj0TsbhQOVh/Mz9udFyPHD1aCQdh5A?=
 =?us-ascii?Q?cGl6DEzK3RMhAA/os2YyoiHvXiTm/vnnl3il4WkvzM8NlVjAH/8/76WozAyW?=
 =?us-ascii?Q?5LOH2/7n74tBkJ4lbqVl2wzLaJGpB0wNO4mP97fwGjUXLm4x1pWSy7zPACdz?=
 =?us-ascii?Q?Ol/N9AxHZsKMBnrt9imi99/xNOqUSYfkU2aq05ErsAQoR2sDj/Ckm3V2oHeM?=
 =?us-ascii?Q?1In9Wocsz3xrTmTD34gjmdFS2uMgJWYd+UWefYN2o17DQBJq4cK2GmYQ37o1?=
 =?us-ascii?Q?7jf6n3tWG7tkZ3My3W+eKVCY3Y+ovF/bPJPrBluur01tcWdSxtFdWN5Gb1Wo?=
 =?us-ascii?Q?8EIJjpamnKOXJkxkKLHnWT2+9cd0B0F0w5WISELb0Gj6PPxFug0R0RMQgc4x?=
 =?us-ascii?Q?lUdDANv2EFWDHJ6qjVXMcTBMLNCnDPLY6aKc7oH4/THXOeaPTuLJHKbZ2Y9Q?=
 =?us-ascii?Q?3qRt6UUtzMRssG7fw9lGJS/2nln14qdXCSzarXVmLhFltDhq9MJdmPQIS6Rq?=
 =?us-ascii?Q?y0VvogJnn8AsVdsdlcZKS/18kmSpfTzg3fkL/tOOtzRWpZ0SEAsOKImZ4ruK?=
 =?us-ascii?Q?MPH3C8i4IG0Gd0sXnppOqQXMVgVAAlMQUNcjonXLW6qzBk2jkwvJwlbImkiY?=
 =?us-ascii?Q?UdOQNn4HMvGY52Q1mMYJC9MNgfnI6lAG/ZDDJY6I0DgI+Jzy/fxFYKQdW9CA?=
 =?us-ascii?Q?3aTK1m5/WxEyb9BUteP8ZgWI/7etzRF0cMC7H4uIpfB4xnnKd5EvJglV+W/J?=
 =?us-ascii?Q?ebI4nEax9TsojuxDZmnG+piNY9IbrR0U4Bswf/6zuF5kMtjx25qC4bihRFJa?=
 =?us-ascii?Q?wNaw3F0kIph7bciegL7Lmf/3cuhsNcqJjNSL99xc8kgFpY5hzt5vFHalFJHc?=
 =?us-ascii?Q?CvtOSEKDPzIY2G0xDY6DJZQsmushFlDEpX6MZErfRtt+cggyXZTEjIRCG8Tk?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d00b07f-6dd8-47e7-75fb-08dc6acd7d7b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 17:29:58.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5KWNrZdCkRjJPvHDY7zYhu1Y+splibXOI/QoQkZ4QwndpFEg0OyXq4UmR9Vi27XzQOMNs208mG1P1pUd0JaA6t08DLw9Md6kG0gLvOnA+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
X-OriginatorOrg: intel.com

Kuppuswamy Sathyanarayanan wrote:
[..]
> Got it. Makes sense. It is simpler to do it this way. I am just
> worried that the vendor driver might mistakenly disable some core
> attributes like inblob, outblob, provider and generation.

Then it gets to keep the pieces it broke.

