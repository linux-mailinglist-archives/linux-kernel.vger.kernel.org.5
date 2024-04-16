Return-Path: <linux-kernel+bounces-147190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5778A70C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2E71F2308B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB01327F0;
	Tue, 16 Apr 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC1W3waF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C6131E25
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283092; cv=fail; b=aasHVJaY+RGeLqAJbmBOKnX/ROCWke4oS/DSd+BfPhOBM9cMRhJPuclDRPOyyNH6D+Dk8d74CUD5fLXo3A8rJ+YhLs44U7DEKybEfQw9CjH2Lv3/LyseeS/XuQcwDx8gTy8pAcPuns8dD7jR1BiDz/GLO3IzDkc8PkG5L4g17H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283092; c=relaxed/simple;
	bh=p9TgbAlhq0QodmjAnHh32o48RWj41XUd95FJn0nxmMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kKC5jCAp6/0K+lH2rZ33O7wtZLl7TuNwYwR+uTtphsOI9BKDsyI0QZVfw32kKfL4zFVlAb1pfsUPdVTzqPkbDaDe2KM3Wg4KMF0V5BT53COhMBOGOzIoexvkOLrFzudcY/ZXlPib1moufuI5b06v5heJF3kPkBfn6SFcOA0kcIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YC1W3waF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713283090; x=1744819090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p9TgbAlhq0QodmjAnHh32o48RWj41XUd95FJn0nxmMQ=;
  b=YC1W3waFgRwXrKPXN5YdT2xRXaWvgYJZx3bY2kZgTP/3Mydg1oH9vxDP
   LzL8de8TxI5nCc6FiRH1DC2XfJOQlYX8mc+sO224zGEFrTwr1RxJ1BSv7
   vi5UuzLAwVobNQKMfGh4BfbIqwtLiDt7XbMhEqNveKbIE8wzQMRER4mc1
   75CdEyTNMBE/wBAXQqKsjzmRLTXzgoU5BTfWbPTZlf/RXFn/hGFGgGcgw
   xC9IP0ZGMDCgEbEMOR2O5mLQHLDXa6TKsrO00vZFJFOy8yxANF0d7MmPS
   leIHaDxWv0OmS4IgwHECdEAa38LIR7wHdjA8Xz53Aa4R/h84jD1kB0fz3
   A==;
X-CSE-ConnectionGUID: 4PkUvLoNTQmqULmcI2agXA==
X-CSE-MsgGUID: 6kAEAByqQJiVdEJB4aDbcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19879547"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="19879547"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:58:09 -0700
X-CSE-ConnectionGUID: gAfiEmiaQOaMpj/vz/ZxAw==
X-CSE-MsgGUID: SuNV4c2ASxyN6KWO5gFMbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22366164"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 08:58:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 08:58:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 08:58:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 08:58:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 08:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRf9yi0PxRsKPIFfuIuJp2CkmqfVTw4sPWUXoQuLD9uDeNpevSMla7CwjbrgbxNIMpdCH4ZzfXm4Q/PNFX4DGmGN0ZJG0TJNAOE7+RMAA+hEv78X7VGmmN6LCC6UHCZB98+o2r/ZJVSMIULtasmKUubAM+a0jhvMFnhbCqmZziwrh02Dgs4ezSUioKs+ZiItJhQ5Cz56v0CjsaE6mco9kamqoXbJq1lvli/tLFmKIx5EXAY4UebU6IPoyLJqHm6Dy912sSX4AEYsOe/6Ovr6yDRHum3zoFOTq3HXgOjPv8G8C8pNXOWiF45U9YIg8q9whdotKzI4gIAYTLINS3XaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9mB+ffJrtbfaJCzOVfHBIYlqkEVC8gVfXekJzWZyGY=;
 b=mSumA66HkPajdKF6bvrniHuBJgGb7bCmMs0xXuCO1M3u1tFd4YzTKfger/mEIFRDFBrZuREG/MjmiBRMmvo9dX1tdb9rwDBZt7xLAsYrn62Hwi6BLsWJ47J8ua8Hmi5+0WqbWh9HxHlHc2lJ4R/pMF1WM9G3CfZTSrUMR+S/wCoT8j14XssDBYVpdnDwWNFY46FwyEFkgNN5nPPr1dsWwqgld3YWOtBjohPu/mJzYDzi/bmBgiuOdscoLNkBnvikRsuArwmSwLmGjizb8fuhOO2HWHz4xkbpi+gRzzFoZYm6OXwNr0D6Je8czUCxgT6JOX07mERtDLeaV+zqiJQ9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8743.namprd11.prod.outlook.com (2603:10b6:408:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 16 Apr
 2024 15:58:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 15:58:02 +0000
Date: Tue, 16 Apr 2024 08:57:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 10/14] configfs-tsm: Allow the privlevel_floor
 attribute to be updated
Message-ID: <661ea007d1844_4d5612948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <bb088b1409283cd323515138feda224759a247ec.1711405593.git.thomas.lendacky@amd.com>
 <661e04cd345af_4d56129468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <061802e1-7c95-f1f0-b462-3aca27583d76@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <061802e1-7c95-f1f0-b462-3aca27583d76@amd.com>
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 9544c3a2-6c03-4eb1-3231-08dc5e2dff22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U37BMvWOojRl9ZblKn6NWkoDy19T8g1PBhpHu8vZlUFZsvvBx4OHDI5cNrAKCPkBwLDlsj6f2TBYCiN3CKzwj0XtZcmUWlPUvOuVt/W8RajNLRcewJmfytRWppEA1Kw22ZPFgRItME0k/R/jRBOvM9n0qcVr/Ah84yWRin1WtftOuNJGFwQ+w6lXRhsPspMiJH2PybKlkVYdfO5FOfbhYHETw/xuZDvNIkGksdxO9K95zzoWHE7TotqiEDlRcR8N75GZYy2WfHuRnucExGF+XPyOrH3RYrYUkWCXVPXmuTu7ZNpKOT1qYMR/xMJnZeJDMxnRbOY5oIUB4QDeGwreHrE26fycDEweFTlHphWaydcuwcm+5utWwJdM+P1H4gA+Gfzl5spVIx2kxm/b3k4S4iBHaX+FV1pXDeO9kZbmZGf92TMQRbzGwOJiYw1qOemW36chiBCMXlDaW8hkxIhxY19h8pg4K8GJSNqeTLqR/RC/BsdqttIeU9qBDemkz0W3Uu+hRhNoNyVEJWF0PXE1zBCraIOg+llUygXU2VDctGpn+J8gqvriv4kn2XHWEdopoBTMffdy9hE6G6YlY9VaUL03wi9f1rTCj9fm4bvwy7ul8KCO8IfaWVAidP9EamyqrUtwpExqcpjhQU26VlzSOYo0GbDtvlKCusHm0SxrhAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqRiBqqVMNHItc5IkRZjjqKW97tn9xzwX0G891lysbHKaHzXYB+yLFyx+l+s?=
 =?us-ascii?Q?SyejBbfN+di9/uTk4VsYXJdtxAl0qsdrS5wEaHZPIKD16YR4WDDduNn6RktY?=
 =?us-ascii?Q?zpo4uUnYyfh6meB3GKTjxtldkOHgt0kFAIwoJc9It6ox61RxTWNldCk/GDda?=
 =?us-ascii?Q?hXgi9PL1vHm91oTyl8xzTLpH2vc3fVh3Fw/3n6sc0ImPfYEiiw9yaXiETFEX?=
 =?us-ascii?Q?cxuCg494RF4CflhvDiegbGrpIBN+RtV+8ZGv7b1eWms8ZMlkJ2eEgAd+OAzq?=
 =?us-ascii?Q?3Cn3fmY9CiVAiE0GNSdxmQMIvcjZQJcIzUmXi3d4CR8Wx8gRaEgQZQ2sD10y?=
 =?us-ascii?Q?WGdzSbHmtsOsB9QCkrMArMr17nopINSZ5B7z82TDXzcfpnqOSxZ87N/aywQp?=
 =?us-ascii?Q?qMXCU9X926JRvg0T7GsAuhAZqfrcJeh9PQhj4k6AcuXjjO4AM/UKb9e0tXq7?=
 =?us-ascii?Q?xZvxzuF7TusaWP+t0jPeaUVUey4kSZ1KhX8/Z7sfdvFK3I4mPLVPHaDsruFp?=
 =?us-ascii?Q?8bCTviaPKrSwyfzxCztq1Wvh7QRHBk3q8NwdpMtu8znqlnAU7o/oQkVNOBa8?=
 =?us-ascii?Q?wCeAvJAEZzz0qjUAPFXZ+MMpXe9VzuER1P5tSqFhJ6KV8suKwt6CZCWNPmaq?=
 =?us-ascii?Q?kJDjkAlFdL1ZNdiH32FP8OKNoGKvfrKUITVWbp5BiHIVmPpDJkrl5IuwrmZ4?=
 =?us-ascii?Q?/pgOM9vnZ3WmUm6hmdXgujjWvy5d3Glq6gMQ9kDXe43fllLy+vtnpkEEmmUb?=
 =?us-ascii?Q?jIFu2iyCQUeWgT9i1pLREEb88dvkiaG7e9BS9YTVboO4ymWqyuzYceGy4BWU?=
 =?us-ascii?Q?1It2xOdwjn6J9lKHwjwH+vsvN5UN/8VxqFPQskasEIiBHz6TWK4PWjPfkz/A?=
 =?us-ascii?Q?h7G6zbTvz7yNMNOMVRQSyNjeZZj8BaIPe078XfKwwYpHTUdeV5NWJVGXoqb6?=
 =?us-ascii?Q?pFUEla2oXCW80U7FifQw3oGGvIhEIEo3xu8pz52H6l7XbY/mFNWJQzgAswot?=
 =?us-ascii?Q?VUV/P4R14PaY7XzVqfknLU7Tt8Toz90hEGCamsstMaDUYz0iF7sqMglWMsv/?=
 =?us-ascii?Q?osWTAR3EWp5lLGX4zvesgN9D8TLDQgN1PGeueanH6lfHkjVvhdapWxd2rR6i?=
 =?us-ascii?Q?tt8XnWQQsupzvFPU0V0qGZsODursxfiRmnjsdGqZdjwmPceLC5S8jou8RkT5?=
 =?us-ascii?Q?tTd6aAHqDDcL7x8dDxTRGbYm11A2taHQ0PjQaFUfG0wvkxpcSaDrCvkvdLlc?=
 =?us-ascii?Q?yMD4MiOMj32ucK3LJRhoHf3UkgJW8HieqHsWW43m5uacFd4fKu+XGXd7DUBW?=
 =?us-ascii?Q?AcIUIaiY908CxCQlUXmoZ7coVqnGRnAUcNmto9nKHJb05X1AzqV9lLwsLIu7?=
 =?us-ascii?Q?SxF6Sp6H8bU+bGUJwsSWJfzWc+T1ZckDNlAuqAmOrUK1yP2FB1tTYCCFLMgq?=
 =?us-ascii?Q?gnfDm/f+NOQjok5mRAakVaCLzQW/lM3W2TQHUbw55AW9NQV9tS862MPfaOTI?=
 =?us-ascii?Q?pwxcGOEw/yPPdaT6IqSlvO+m6067cGPnrUMQsYzG9qSu2zB1Xk8OS07M+Z3M?=
 =?us-ascii?Q?g51R1ejvobD1F9oLpx1WU4TiRpkdx5vj4D6gi5ofs/q51OhT9hMCT+LD959M?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9544c3a2-6c03-4eb1-3231-08dc5e2dff22
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:58:02.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tuGNzSA4TQ7wS3PgZf6ZSFtPN97BLhXpPMm2PiV/UgRflBjq7jy14XtJsi63y1yxOaqoi+iwTjDqV5oEXHS7KcBeLzq9cWHIUOCKaM9c90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8743
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/15/24 23:55, Dan Williams wrote:
> > Tom Lendacky wrote:
> >> With the introduction of an SVSM, Linux will be running at a non-zero
> >> VMPL. Any request for an attestation report at a higher priviledge VMPL
> >> than what Linux is currently running will result in an error. Allow for
> >> the privlevel_floor attribute to be updated dynamically so that the
> >> attribute may be set dynamically.
> >>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >> ---
> >>   drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
> >>   include/linux/tsm.h                     | 2 +-
> >>   2 files changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> >> index 1ff897913bf4..bba6531cb606 100644
> >> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> >> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> >> @@ -885,7 +885,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
> >>   	return 0;
> >>   }
> >>   
> >> -static const struct tsm_ops sev_tsm_ops = {
> >> +static struct tsm_ops sev_tsm_ops = {
> >>   	.name = KBUILD_MODNAME,
> >>   	.report_new = sev_report_new,
> >>   };
> >> @@ -972,6 +972,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
> >>   	snp_dev->input.resp_gpa = __pa(snp_dev->response);
> >>   	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
> >>   
> >> +	/* Set the privlevel_floor attribute based on the current VMPL */
> >> +	sev_tsm_ops.privlevel_floor = snp_get_vmpl();
> > 
> > Why is this not vmpck_id?
> 
> Good catch, this probably should be pulled out separately and submitted 
> as a Fixes: against the current support. If you think it's important 
> enough, I can do that and put this at the beginning of the series. Or I 
> can just modify this to use the vmpck_id value. Any preference?

I dunno, you tell me. What breaks if privlevel_floor is mismatched vs
vmpl and/or vmpck_id? If it warrants a "Fixes:" it should probably be
broken out.

However, I *guess* it is just adding some sanity checking precision to
userspace requests and makes some input validation not catch errors when
userspace tries to generate reports from the wrong level, right? I.e.
privlevel_floor may be lower than expected, but userspace should not be
depending on that since the report generation will fail.

