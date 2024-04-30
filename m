Return-Path: <linux-kernel+bounces-163962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0A8B769E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289DF284A56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446F171666;
	Tue, 30 Apr 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXCPWDML"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C91171660
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482647; cv=fail; b=N3mFlq0ewUYAzaBVTlZfJCqj2+hyMjOCKOAg/RzQsqAIbaBrn+l2Nb2waWVUdMgo3UEBAwa68tXtj4l5woYs8GU6ajrxMxc0OB+VmMAbNgoskcMVOPE9l9YghOo3+jiOQJxkUfCjh6NhJbYu2iq4xueEnf/fKv2jPxllDT+F0wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482647; c=relaxed/simple;
	bh=VvPAFVmk9yGfpGkj7RvOzBZPyO7iLnNQTa04POTkUm4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sac4+CF1TPwerZqqBnfWK++oGaQhUVADhuNsq9WjfuqFPOnKs9iAt9wUpTpKoQri+V7PQ2pUfVKmw4iJ12JiceaIi8jCVMXhez8VWfnOIZl9GkHUwP7XJtHSeKFHb/aC5hBi2YEVTmcwcD1x8RAWwSlR35mfmh1T6gNNEmDQpXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXCPWDML; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714482646; x=1746018646;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VvPAFVmk9yGfpGkj7RvOzBZPyO7iLnNQTa04POTkUm4=;
  b=QXCPWDMLQ1fSlYWKpVFlu0n+UeU02m7P1X9IoQ8+8790fP2sXH6W5mbC
   5MSAOCa2KyMlJdnjJuTpgZDpvtkneDK+pqUs6OLSCThhDvtngVo4bYuV3
   vUV5+BJJfkv3tCUjL3vZ2PkKHeMbhyzzolCMFM/RqsYmxYqOhQ5gvv6p4
   Rz6HuoVF7WfdV7YsfQrr16UBP0ZzqZgpPR5FtI9DG1BMgx6Er+1j3jdd9
   +h6YO+LDO0YdLIU+MIhfRjPXqi2A55I6GWecGSF5V+DfuJFETjgXqeAi/
   iMS+cPXznMtr2kv815fY0Bx+vCYfISEkU78Qnm+8q/FEUIYTw75pdi1rW
   w==;
X-CSE-ConnectionGUID: xqk39U2wRBelOARQt9ZapQ==
X-CSE-MsgGUID: W2TP7PQEQ32KkzHJWYuBAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10349600"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10349600"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:10:01 -0700
X-CSE-ConnectionGUID: 92iZnua7Q0apKGTCxiSMDA==
X-CSE-MsgGUID: ObpcJTP6TOWtB1h9f/E5JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="49659836"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 06:10:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 06:09:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 06:09:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 06:09:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpyomEjQjsAoiYYHZx7Jkf5dxik5Tf0HkNR6Q3QU1NBuz6cT7a+5xX/SHJood244C2A1VyCpOk3m0OrQY58dCjTcn6moweE7lMQrUj6Isrul6J2i5VpYzR5W1ljSXR1uCgE+6uAv9RGXlt37RgHaVDljNTP7ThkdwpW6r0PXhL0nkiLlHta09Hslflo2BaTBMl/+AcVZ6v15DXKA04svt/xkh+SNYDYHbGxySmNnAHMwddhZK/hCkAg11NaVTArlHYMrJ1cKurqERkvff/CXb0MwOs/LUHarO1Xa8tfE5oSL6WBW5mIbWITpxM1eQMN/am0KICFVnU+KJ+S8/vN+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsSwZwGV+pWT9icAJQzyclozgxrEXDOFs0m0CiJA1qU=;
 b=J3pdaD05MtQeAVHkyjtAmixN8Yrik5WB2SyyjtyRdDu2WKlM9oti/hxv3adeUGycrCXkmYck63Qil8DHCwwOYMs0yfssVXLdg38GI9B4mBp2YQFiCoOtHGyULEBnQjgaq2YNlRXcPacKJzAHz1DW5ITl6lhj66XPlbUQf3HpCwtqWeU+WZQhwGR3w1AaLCVY5TOPxHQ8A/Jg87YqL+tVNm7VDM2tLFRo7IZDsfsr0+gRDdBTFnIPlDS1z2sHwJH1/UBej4Ct+Pzwni1xggl6vl169BlY/Nf/8FeOR6ZrsMG08uYU1WygnUSFfqqLR/SXhqMsyfpGOMc56hV7xttEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 13:09:27 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 13:09:27 +0000
Date: Tue, 30 Apr 2024 21:09:20 +0800
From: Philip Li <philip.li@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 ipc_imem_handle_irq+0x292 (section: .text) -> .L0 (section: .init.text)
Message-ID: <ZjDtgFVuPv1ApZFj@rli9-mobl>
References: <202404301338.VtPxCQfW-lkp@intel.com>
 <78ae53dd-f927-43ce-8370-a437a9d0fdbe@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <78ae53dd-f927-43ce-8370-a437a9d0fdbe@kernel.dk>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|CH3PR11MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ae7d5d-939e-4909-7833-08dc6916c3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OLnn2J5IClzMy3nQtO4vrYiwTGWmRIPaMw4njbu2Zxb/Ua73CJ3rjj1TrbRq?=
 =?us-ascii?Q?kD0uddwNWqhymdZOVHvBvG+S7HlZ5bfPD81t4CC3+u2QDbnutXVQW7IqHGvg?=
 =?us-ascii?Q?AGBdJy1HOKm+nsQV8gg/GcS7hLLLCzuhDUwOaWHnTaKFHx5k9dJOtqi7Ci4x?=
 =?us-ascii?Q?H/5YGYWRYXg0vLP8VPf3ST4PnmUrladjQ3iwBNCOe3m1On97JyVkMPSJ7aRE?=
 =?us-ascii?Q?jHZPgJ0WXQexohT85R+26280bo6QTpLba6dwzkA0KxDGdBiVaqkEw4+Zso6H?=
 =?us-ascii?Q?+jSygj0mRt+ot5rmFkvflOzHp8laL3tJIzT+lZK6oNOAN/2T0DGf6xppffbm?=
 =?us-ascii?Q?GCIqQasJCeG5tbVN2AurvQfX4xVDS00U4VaaUsJvS1N/KfyCv+TKwWPCGt9y?=
 =?us-ascii?Q?xN94cYwW5LFb6NxtT9bSDko3pmBDBxiOFbw7LR1NpwQT/je23E5Wc1tZzx7q?=
 =?us-ascii?Q?4hRShwW0wWoBKnF3yni1D9/kCWv9sxoa3zG+DPxkCXw6MDSuEuoq/L0HUl1h?=
 =?us-ascii?Q?m0IBjcfQfIIKtsZzkVY+dEzAFmSJnTLEZE5G4/dDEtr1HAGhf13Vf9vWkHXN?=
 =?us-ascii?Q?rKGhOcQWcCrXKpCuvNymvUf4+OO2T0TxYPkql6DVTIjiS1Lg+p9J0dxhry66?=
 =?us-ascii?Q?ooFJxc5wgr8ypsFW7CSwUzzMYpT9Hb/YkDXh9pgGgO87+nRoY3t6szKue3ul?=
 =?us-ascii?Q?zZFaeO0WwQTjl0inUAKGLz9W4fFFiGwz0lcWE0QiA1hdLoTFoWXYPzJ/RW0S?=
 =?us-ascii?Q?bqTcW50zyZDUz6aAn9cWa/9Gvk8aeFBeEp4HcQN0IL9Psp4FCewQDA/DCqje?=
 =?us-ascii?Q?ffsxlawIH3mhqrGCronZxO8zZDhabhzjrItXTCxpa8RerTJ6havuspDYhTjY?=
 =?us-ascii?Q?AX/3ouLON3OLz75O6B1UxdrrywgWqGHLxt8zYe+XpKSRzHbPGqbGkDWHYnLq?=
 =?us-ascii?Q?rqxGeX0YjsuW0yAoeibkuh3PMAh9kjLK43Nx0/EbyCwcb8qFYG2dYNjqDL+m?=
 =?us-ascii?Q?bijqAebIIZ+IBiKDpyU7mAfxB1WrO+Acse720sTWJBCact1cpFdCHv4KUtwE?=
 =?us-ascii?Q?pw+3rZypJ64CeuRCZNPTd611Ex8tG3lNo3VrzQjMaXCmBYVsEcmULdaZrNMF?=
 =?us-ascii?Q?QEGTMdUhrBUJ4D67avSOmqNGnY85JF7pdz1rV+r5JzKtsKpGPmYJlynbp89Q?=
 =?us-ascii?Q?x8L1mSMW6OMMmZZnNzdmpC8kdoGujWKOTRjnZ0lBbjHAE0IXAn0rAKyW3os?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jM9PVPOmkh8lHmWb24+Z8vkWfTYkMOkN52lWinpSHT8arR/qITs2+QXIxASV?=
 =?us-ascii?Q?SNK+1IYNehsVg2hNIRcKm6qyM6uzC9kSITQCo5mEkFZSFRUy9gXdhjo2g5tN?=
 =?us-ascii?Q?2Gi0mxo1fFDtlX2QZN9J7fAy3Gb6iF2fZIHR9qK+AsSVLk7Zg2pYohnOeLiW?=
 =?us-ascii?Q?2riPEkPsIdoPTqA7uT/yJ7l9sPVhc2aV5utNtXvcTksYFSV6LEvOXwWmKELy?=
 =?us-ascii?Q?xlRVe6j7CZtzH991ybaOclhRpPTBUecvnv7avo58f5MsCsQwTmcWAFNMzfJR?=
 =?us-ascii?Q?RT86xRLYZ/P7qZ+JfwW2BO8W6ejSbEw8C/UNYwoLfD45IDAUhJByVv3fTBo2?=
 =?us-ascii?Q?EsPY5z+bSGJamvKAUPFQwwBRcnHqMYP2daKq7Gj5iUo7JK2IYvcP4uV7yy00?=
 =?us-ascii?Q?x0WPdgRoFgK/ObcnpOjGTaZJbULtoAphWvGV09NRxlT9FQsfrygREBdmM1cT?=
 =?us-ascii?Q?kLMQeXdK76P425UYfgwuJWQVmogcDY/zDnu8S9MiAZ95zsErVbeRd//Svlw6?=
 =?us-ascii?Q?4qw5VRmokqKWDS9rKsJr2UOk6H1nqExIn98c/O2eCSvTapQfzHiHHoLLlgwL?=
 =?us-ascii?Q?HLNA5hR/80lEzcW192MkebesYvjuKepY2aSszwUmwtmClCMe2l6046bfOjsZ?=
 =?us-ascii?Q?SJqZ4O0WQSfJli0jUhJYmPOla4BNjJ/W1ioEYZgfW7qKLpA5dqn0p7DaOBg0?=
 =?us-ascii?Q?IeIw54raLBXRGC+Oao6zOWQWnhduhSJF+oeMlq4J/zjRIQpRrHy/Pci2PXJ/?=
 =?us-ascii?Q?mmGqKma2MrW1K0aLNGnQLnb+yYf4WXXOqWYqL8Q9IhU1Djyw7XnNaUGVrmSJ?=
 =?us-ascii?Q?xw9B5ZWaMxiGDsKTijBijBKWHiky9D1hTyqMzYJU8Ox5D4F7JgRqJitsUd1h?=
 =?us-ascii?Q?5sHw8g4q8Vxzh/cDoxLsDtYuM1c09J7UO+/QUI2IanfDp0+JXKzSMPlE0pDM?=
 =?us-ascii?Q?+sZLFL9T+b0dVdBjN5JwQPrmLh/ovwyLYhku1XAQ+RsdkckaSzUnctc+6fuE?=
 =?us-ascii?Q?EvSiwu4EdLi+56GE9Wde0IBEr1t0aCbn339PeTYb+DFYocJFLnUmXfQqOW1y?=
 =?us-ascii?Q?BBbuh2GvjKa1vzz4YBZx7m7TJQ/OQ6N685rbkiWerGd3c3k5EfVs5vOaWuwd?=
 =?us-ascii?Q?1E0Pe/P/b+kiuWNZCWUVt82E15kwoWPWcyhSOShSlZnj6e9tdqkyWusAN6AN?=
 =?us-ascii?Q?J/85xkMkxviayIdPBGZ2E356x4XyXu3dith0bbk3rnrpufoF4TTqOm92AmvY?=
 =?us-ascii?Q?++Yi7Fzfxz0rrfHX2Ai+xHPC8IkKpcu9zeybsU5NWlh0EnVDthbCWnehMC6x?=
 =?us-ascii?Q?WXwbLJrb4irDNGDZWntTjgyo3NkQMIa1D0keae0XcZHcN2ezmwb9AWi7MXuD?=
 =?us-ascii?Q?ZcorMPgIPYIPhDiIvJsxNTr7jCDRCvFEsVeQxkmBFaPOCzeIp9LVz+sS0oHE?=
 =?us-ascii?Q?KtAQLN5slFzDzCfOIk0Qxay4i0iWWmZXs3m6HglXmDVn3CAFh+rpmIeBdhX3?=
 =?us-ascii?Q?AraJPnM3b21RqCDfcLYEQcY9i+h7F/pdBAoXGMxVtAV+MAy6917y20dzOrQI?=
 =?us-ascii?Q?gp4XADQrgLzj+tPb0WJ7XwnO+dm2MaRObSfi5FNZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ae7d5d-939e-4909-7833-08dc6916c3c3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:09:27.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCKM4dqlEGlvzPVqQzbHUt3mbZkYLMVjnMA/VS/zbqyL2CBJ1bRYZmOcBab4BSkQxCpSM6EKsJHhrcL8+XIKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com

On Tue, Apr 30, 2024 at 06:52:10AM -0600, Jens Axboe wrote:
> On 4/29/24 11:13 PM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
> > commit: 561e4f9451d65fc2f7eef564e0064373e3019793 io_uring/kbuf: hold io_buffer_list reference over mmap
> 
> Definitely not related at all.

Sorry about the false report. We will look into to fix the bot side.

> 
> -- 
> Jens Axboe
> 
> 

