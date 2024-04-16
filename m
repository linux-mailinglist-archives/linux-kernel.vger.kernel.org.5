Return-Path: <linux-kernel+bounces-147224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA238A7134
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01019283A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3F131BD0;
	Tue, 16 Apr 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WG5DK3+S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F4131750
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284408; cv=fail; b=jqfy1mKWEUW672PeIhwH60OL4RS4o9xoJGdDbkrSXFZj5WbLFsRZ/QWPELZto+ZRzOcVGUqJM14x00jfEyI9wekAJ+00tAyGAclUaUYwqZlzmIXfkhoFZviAbENW5rignKUvwuD8bS2SaMHzJy0wme9XF7+jTygOu3LnrXIg6ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284408; c=relaxed/simple;
	bh=tqnHBt08iPmhzxbME0xHsYae6YSGaA7ncoXD6G3ZAB4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nEVumpxW9rubkbrug3Y7uxWA0OlfIX1Mo5HMcD4iyOZOWcGsUli4OwQfVrwm4FYC/tAtCsC+4udfYjU60PAHoiWoktMcK2L6ILk1LojURuMTXADX9yzxCKWy/U+6FpRltvL4kj8YnSW+N4l32AR0N7VR4P173+9eGFxRIb9FNF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WG5DK3+S; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713284405; x=1744820405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tqnHBt08iPmhzxbME0xHsYae6YSGaA7ncoXD6G3ZAB4=;
  b=WG5DK3+S59gzC6INaSFSIb0KYxn2QKe/xcrb9Yy5GQEunp3N/xifu7g9
   Xv7nWQFeCOjR2Yb4MhHY+GmDdu8xn8AIThD138YGKN61xOokdmIZVvoYO
   299ueB4NFoo62q9aSLc+tfms2Js77WulopKuSZHAtGKqUf6rweH2E//dV
   qNaO+0/f0MoQoCFETnrrdobQp4DEqpxCLoa87f6pYeH5/QOiLg3k/TTdo
   pG5bBsgBj2Bk8xJEC0hUaRJnscqhmcwOq6MKmz6Vk1OFaZE7HcMR8CtaV
   pF2/KevXyRc+GF3gUfMmvdXWHWtZW3zIq6F4EtD11oW4d81bW2+Nw9rU9
   w==;
X-CSE-ConnectionGUID: 5WycAkv7TVS+YnY38MvOqw==
X-CSE-MsgGUID: ZjdXGP2fSmGxmrekl+y1AQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8615160"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8615160"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 09:20:03 -0700
X-CSE-ConnectionGUID: vMVSO4A6S6STifvm7nD4fg==
X-CSE-MsgGUID: /yEsQkVjRtasZham0Sx9rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22380119"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 09:20:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 09:20:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 09:20:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 09:20:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 09:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2YxWBzSPsYK/TH6F/2BxoWGYsQ09T2dY76LbEdYhEQA5FDtedp48kKXT8Eu6Vgda3TcTSUDG0odqfOrSVDoV9ck+wkRMRggTD2tNeMlF9/K3LCX22vvvwy2ViCDPnQ8EUVk7CXXwR8TyUdxQnhRj2Gdg4igCQMcs94DRyFXdtk7aHVnHQBV5UzajeZ99CyiqUZSgPa0/iNJveoAs3kmpjr6TP2Wj9CV3AA5x50lZWxx9MZWWcQPVgL+YlIZeJbKFVETBr4tkV0EMGeVswifmdKD4cQN8lbfJNqy2pCrAc3SUSaF/NerKe1/8X8jgAfZ5T2i5bFGvoQGUraZBDXfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7beU0BVULEWkxfb/DMmOTEx/TdIliJ0sTn7ro4i/Mx4=;
 b=e9fgffA3lWd9+OeKL8KuMSx9UP117gx6IvlmxnRsomAwJ7di0I+lcKcdZw0qJ5gJ0aJwmAIvLiksIvBkyr42MNpXXIR4v/W90euSjFAz88/S/Ac1SpF120s9F23oijh+S6mIFXMM7wGYrQ8dzbQKIENitkbo7FLmOevseo0SvDok3rCLva/uxXhdiasLGMlBxU0cjgY65i+6UwP4pxLAG0KAjaE2bCQA6UMlkbI6bMXNbHz4JHnpQdzAYqpCC3mwhdgIodNajBGaH4XcGSCH/a7g1u2Msr08Xmkq22IaucoicW1fQGqe22LBoPOtLz4byDSxrES5uVA3BYLFNLodQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Tue, 16 Apr
 2024 16:19:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 16:19:57 +0000
Date: Tue, 16 Apr 2024 09:19:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 11/14] x86/sev: Extend the config-fs attestation
 support for an SVSM
Message-ID: <661ea52a53541_4d56129416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <1ca853e149fe37be748c028a9b0d00237eb73938.1711405593.git.thomas.lendacky@amd.com>
 <661e0e9418862_4d5612941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <3732b0d2-0471-48ce-89b8-43f425040846@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3732b0d2-0471-48ce-89b8-43f425040846@amd.com>
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b350771-add9-482d-19d6-08dc5e310e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXhMDVJmN/B8wAssoWK7XGlWf2sYQPKbUUdYva1jh0FoNXmgdAFvJj9+r/6aQOtjGk8sYoY4nKfBsq4fP7cTKKuj2zEk0t/MxfYdb+kgUAmQ4fVCr2TFfv/34SSXwIek7bY7ldN99qwGfFPkR5g/R9vXjATkuFfK0YQC3x9GLq93U7KE2CwdVrzC5wytZw783O4C1oH0H3SrJLgEDgLchWju0o8uVxJApeLhRqllfW0ZI2AZ45BxA89FHZ7b9DhLgi+Z2ZQBpQqWW6LIPMPhOoevxusGEUAvWCU09uPIxjvhYDlLPnBjKdwcvZXy5Z83ZwIIZ8nP6qpjH08btKrLBdesDgapGGtOTyJM3kAtdudLH3bDfcwe6JFsLnw5pvMLeQKj268sijvs/NCC87BBnTO7on6QWfmPk0tZtsB8RU4LKzo1XLY1lxZmCsBgDiSnkoEU/IkIO4dV0DCPTz7XRGjdc9hDAw6ZxTclYuixfGN5FgkZNvjEWFIA4qrdKzvV5hPBDITIwLW405XQdYp64z478kqjESrtBHiBLAZeKyCbH5pAQBJP10P2rKB76Y/QEUgZZ1fikKx6CmfU5steJG68ZVYG5gAOtqbH3S1DoFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DoqthFbhLYZDPWVxN4/uSSeJky44OhYmTaXvKJMx3Z6H9o2d0k/3QV2eGft3?=
 =?us-ascii?Q?dD6m5cAAxiIKALhYlLe/1Ab2HxmR9/RaSy7fxjm2umOE2fs4UZINo4evuzdZ?=
 =?us-ascii?Q?EYmVd0WDVLxPSs6gMgHrSN0nGcbfRvxwUeXUEaPSQlvoGMpKoEGPHZ1zMVHO?=
 =?us-ascii?Q?fOYHTpId7vugXGX4PMOxhZT/Yr709w1y7Z8wZuKIeztgnjYKEtfApfZm7wqk?=
 =?us-ascii?Q?ZrO5f48IeBnAt6Vo2FBIbLP1idRPQ0iFQmmsHAQkNkt5fJfkU8+LGRLYBLfC?=
 =?us-ascii?Q?lpmgqGqMoBrpmCyCBYsWcOkP+D6PvBkrOQ+tt2C+ukpE5bGoRKzUxatqM4qd?=
 =?us-ascii?Q?gMeYlswITTfRRcKNwmEQD0XQRqDx8JXGGqLcXspEVroX0fRtlRkoh/MRO1FW?=
 =?us-ascii?Q?zo/bCu3YK2AhFRu/YOaMFVM0im2EiayeWS7zhOPcV1J+egmOgonRp5Jphboi?=
 =?us-ascii?Q?fbAP3u+SLNQpSXkiBlmEQ1keDQziJkQskt86XjoFexMtuqlPJuE8zPQ882i0?=
 =?us-ascii?Q?GKG7j/F1C6tjIUfLhBGPukINGbWGKug5MTeP03tXU3Mj7Uyd51U8ekGMrwyz?=
 =?us-ascii?Q?LxKHyA2e61BXiODBZK+Pr7h0DXQC0Icu3gNt7xcs97n+XRQBSottzPydwV1z?=
 =?us-ascii?Q?LqhpU1OU72UKi05lnTDUBLEQhu0bwWytq+aMJeSzRy2VoAyhTZIynzqn06rO?=
 =?us-ascii?Q?Tmq6X3miAJOyFqCPkI+fPfYWn+v2K8JN5l+tqkgN2DcruE7O362qORbH4MqD?=
 =?us-ascii?Q?TUvFlowVSe/CZ4UWtpF15W52oyj+20QVi39ZWlSGi1wMcqN69nXIinkGXCAd?=
 =?us-ascii?Q?5LmPgH8ZwElc9KrfHUUjJXK4mlIzyr9HJ7ihbjKj0qYKRo0dKEgZIBUosD+g?=
 =?us-ascii?Q?8EbYob63HbzSIVIzQt14HV/MirBuT1LxP7GYhvxAVZeD6225j0+yZ+sBotD8?=
 =?us-ascii?Q?YVfiVWaFP1bsJlsP1GDy5sIy1V10sxv0OA+4CPVz3PsF2KNzCzj04QNMkg1R?=
 =?us-ascii?Q?ocMMahKYKaI5dRooOOUNCtahluvKm8u1u9ltfwgUtVJnBGneLYLUB4MbeQBK?=
 =?us-ascii?Q?rXlgLismyDlaAheMILyugYzYUHksv7BbutMUOnYnv7/gk5UdsFL+4vVUxtOm?=
 =?us-ascii?Q?tWumcMWCEwS9QmDWM5PI/zQn4U8VVABDp2bDca5MLun5HBJKhgfWID961dPt?=
 =?us-ascii?Q?7bcdF5Nbbp2NO1y0XDgGAbXVisCHWtpzAuCIzd8nnoIzkssHyi7u94FPNuP2?=
 =?us-ascii?Q?I1HzIgiMYEMCIgnIQssN8RhxjAlJ5t9wW/+hyzimtW9wUODM4SeUYWF59MuC?=
 =?us-ascii?Q?baO+Eqb2T46C7xJEXen/oqTzxt/NRoVeEpXKGQ39T486+JT/QheR1kBUMjt8?=
 =?us-ascii?Q?Z0V3tAE41SfIpdKy4qbGqBot7rN5Ok/7P9u7eUpT5mVnasX/XHTNaeD9Ju22?=
 =?us-ascii?Q?p7uTKTXbd/hiVEuIE+oli+hmTENyqMR0+bau5thhdnOdCdgmBwy9q7t/Pzwx?=
 =?us-ascii?Q?XR1z4Lk7baqWvKbeDVDZ2VR0LJOftrhD0IJoKmBVW4PmbX2DCVYo/VE92GZV?=
 =?us-ascii?Q?OuUDA6gTbV3vpaiRupBwqM4pJlwxeMHWkyFGFiHbdtHd+3/DxBzovaJa2/vc?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b350771-add9-482d-19d6-08dc5e310e92
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:19:57.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoThPnt/+o/H1K3m1K+9ihI3FjgDzQzUwxN0ENApeonUw3TXaOw/r9GXx5MADidKCNaof7AwNjmpAtzIBfQVG+G5S3WWDpFknsDj8Z7/lVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/16/24 00:37, Dan Williams wrote:
> > Tom Lendacky wrote:
> >> When an SVSM is present, the guest can also request attestation reports
> >> from the SVSM. These SVSM attestation reports can be used to attest the
> >> SVSM and any services running within the SVSM.
> >>
> >> Extend the config-fs attestation support to allow for an SVSM attestation
> >> report. This involves creating four (4) new config-fs attributes:
> >>
> >>    - 'service-provider' (input)
> >>      This attribute is used to determine whether the attestation request
> >>      should be sent to the specified service provider or to the SEV
> >>      firmware. The SVSM service provider is represented by the value
> >>      'svsm'.
> >>
> >>    - 'service_guid' (input)
> >>      Used for requesting the attestation of a single service within the
> >>      service provider. A null GUID implies that the SVSM_ATTEST_SERVICES
> >>      call should be used to request the attestation report. A non-null
> >>      GUID implies that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
> >>
> >>    - 'service_manifest_version' (input)
> >>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
> >>      represents a specific service manifest version be used for the
> >>      attestation report.
> >>
> >>    - 'manifestblob' (output)
> >>      Used to return the service manifest associated with the attestation
> >>      report.
> >>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[..]
> >> +What:		/sys/kernel/config/tsm/report/$name/service_provider
> >> +Date:		January, 2024
> >> +KernelVersion:	v6.10
> >> +Contact:	linux-coco@lists.linux.dev
> >> +Description:
> >> +		(WO) Attribute is visible if a TSM implementation provider
> >> +		supports the concept of attestation reports from a service
> >> +		provider for TVMs, like SEV-SNP running under an SVSM.
> >> +		Specifying the service provider via this attribute will create
> >> +		an attestation report as specified by the service provider.
> >> +		Currently supported service-providers are:
> >> +			svsm
> >> +
> >> +		For the SVSM service provider, see the Secure VM Service Module
> >> +		for SEV-SNP Guests v1.00 Section 7.
> >> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> > 
> > Given "SVSM" is a cross vendor concept should this explicitly
> > callout: "For provider.service_provider == sev_guest.svsm" as
> > preparation for other implementations defining their "svsm" manifest
> > format?
> 
> I'm not sure. Do we need to get that specific? If SVSM is cross vendor, 
> will it be using / adding to the existing SVSM specification? If not, 
> then each vendor is likely to have its own name for the SVSM concept 
> that would be unique enough...

Yeah, I guess we can kick can that down the road and see what other
vendors do. I know the coconut-svsm project is cross vendor, but I do
not know the details.

> >> +
> >> +What:		/sys/kernel/config/tsm/report/$name/service_manifest_version
> >> +Date:		January, 2024
> >> +KernelVersion:	v6.10
> >> +Contact:	linux-coco@lists.linux.dev
> >> +Description:
> >> +		(WO) Attribute is visible if a TSM implementation provider
> >> +		supports the concept of attestation reports from a service
> >> +		provider for TVMs, like SEV-SNP running under an SVSM.
> >> +		Indicates the service manifest version requested for the
> >> +		attestation report. If this field is not set by the user,
> >> +		the default manifest version of the service (the service's
> >> +		initial/first manifest version) is returned. The initial
> >> +		manifest version is always available.
> > 
> > ...and that number is zero? Is there any expectation that the kernel
> 
> Yes, that number is zero.
> 
> > sanity checks this version, or how does the user figure out they need to
> > roll this request back?
> 
> Right now there aren't any non-zero versions, so there is nothing for 
> the user to figure out. However, the service will determine when it 
> creates a new version and then the user will need to understand what the 
> reason for that is and decide. I'm not sure I can give you a specific 
> answer at this stage, but we need to allow for a change in the manifest 
> without affecting existing users.

Right, but it feels odd that userspace could write UINT_MAX to this
value and the kernel says, "yup, looks like a valid manifest version to
me".

> And since the spec has been approved already, I can't really go back and 
> add a requirement that manifest format always be additive.

Those breaking changes have not arrived yet so still a chance to
influence, no?

The documentation here at least guarantees that the initial manifest
version is always valid, and I expect the spec authors to realize that
the kernel has a role to play in not breaking existing userspace. I.e.
it is not in the spec's interest to disallow fallback to any
version between 0 and N-1 where N is the latest.

The kernel need not tolerate version induced breakage from ACPI
specification updates because that spec is committed to compatibility,
why does this spec need to be less disciplined than that?

> >> +
> >> +		For the SVSM service provider, see the Secure VM Service Module
> >> +		for SEV-SNP Guests v1.00 Section 7.
> >> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> > 
> 
> >> +static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
> >> +						 const char *buf, size_t len)
> >> +{
> >> +	struct tsm_report *report = to_tsm_report(cfg);
> >> +	size_t sp_len;
> >> +	char *sp;
> >> +	int rc;
> >> +
> >> +	guard(rwsem_write)(&tsm_rwsem);
> >> +	rc = try_advance_write_generation(report);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	sp_len = (buf[len - 1] != '\n') ? len : len - 1;
> > 
> > This feels like it wants a sysfs_strdup().
> 
> If there start to be more string oriented operations in the file, then 
> it might be worth it. For now I don't really see a reason.

To be clear I was thinking of occurrences of this patten outside of this
file. Turns out this pattern is not as prevalent as I would have
guessed, resource_alignment_store() was the only occurrence I could
find. Skip for now works for me.

