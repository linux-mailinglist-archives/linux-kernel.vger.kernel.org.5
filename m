Return-Path: <linux-kernel+bounces-164825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347098B837B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2EB2847D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28904EC7;
	Wed,  1 May 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FI2SOuQx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B447E6;
	Wed,  1 May 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521987; cv=fail; b=hTN9fKcy5QmeB3sAluPkbgdvilWyv55nwGCrnwATOmGoZb/3Vs8IJOVcv9B97KtxcYFv/BcdwxPg81U5JqyOkZusd9PB213WUx3HyMzQT3aHf/x0r0fvTpHHgXN3V2whOT6TsKCjS9hJ6FHT4u/Et5/CawHtHQ23HMSrEGj7+p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521987; c=relaxed/simple;
	bh=RFlzx2519OtARJQMMZa5kduevrl2ZCMK6lrUrR2FPRA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hpZqaw85chKigL3SaxvXMgJqYIAe02QJLNa4QWjOvMMxe0am0ZuYrV2PjzW0avA9dUsWQizCbu6xBSrpQ0YhNz54g64lHDqECpiZ4OQmX56Ed2MTxybNsZcauLkk4/BK2h4wJdkrK2RCu3eJ6y/JwUTzR0XHNG8Oh0pS6ktubm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FI2SOuQx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714521985; x=1746057985;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RFlzx2519OtARJQMMZa5kduevrl2ZCMK6lrUrR2FPRA=;
  b=FI2SOuQx73lOx3rDTkxWyudsE/ZbbMZkK7M0GJ+CwuolWCgTLOGSaKGj
   3Wj9JuUXetSz5BjByhZN2Pnhl+XpgnF/5BpMmGM8g5/qzqu306lXz9eyc
   J9cPulwKavuNkbm9v80CFcPMfhCwUlEMoYAaMeR0YWnpEKIguAjiB2jnz
   tI5f4IJRqCpchxILNCkguiAaBawDpQ2dTxXYbrO9ukrFRMT27+3I+yPjY
   nX4K80/fDR4JjYWIZ6nB74pIxKnXnEDeOym5F5VsWwQTTnC8F2EYVUqz7
   CgYP8YyQoOgfcDKlNGwOWFhw9VRlniAUwbNhggGAmojREJffNTgvFa46q
   Q==;
X-CSE-ConnectionGUID: i697iWwARs6wkX6sIvjAbw==
X-CSE-MsgGUID: GCkANWluQzuLX+vHxrBoxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10118715"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10118715"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 17:06:25 -0700
X-CSE-ConnectionGUID: jEhpACHtTvK+Drwymh8sow==
X-CSE-MsgGUID: w/8+rNTWRmCvvwmaoth3DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31461198"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 17:06:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 17:06:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 17:06:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 17:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGnicQEYsSb1KDmD87J/gSgxZ5Ei4h58Yrlo7klM4SfG9ozsSbuf7JAZ2NYeKL4Pe3/vF3p48753xPI9SBPHTRvlFWGPFcHo5YXrCQbEpbPnp9ni2WN8Es46YHlNJBVIU2EtHYGxwxh6tzn4rolJD+HT6Pga9HN6HlFou3buA5ktvqDxm/1hbG55Rjp4yNjf1vXTjn8qTkCTiuWP7/JqV5TUqOp3kud0awa5Dc6yRfQQAocM3+1EsXU5UsNU9C0VUNExtN8chYjvbIcZR0e/PA3EMaJR/lVpnUIDjzJEQIOTJl2EFBInHvlN4yzP1/4YvdaOTwZInNl+eBjeFYn63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZPgZPCgodxa7uOh/5O0vOKuVEttCoe+45tRDbWcQvk=;
 b=oBUjIdAO+qVeakGRCvobggzzYzzhhXQWMplMQBOLRnzPn8EAOwgffS4NKnoySavjpPXMmiM8ZODUgNZrI5gQFk4McigqBMJ49xyncv3s+fihlFn593kthBA31joX0h1LmW4UNg0vldGZ9oBcxfHeC+blohWB/zTN+fpNXo76yAYPcrXlBVn32v2FjfDD3jDgb1vWQrwO5WKGYMHCavg7a3Mc2y8tKMxz5glY44u4woSLtU+BpI61ZHahUWsWnvIMJPkeEr02pofCx0/3vr/ger2S926xhU+AUWQeFB/JeEePK5bH7Qgnp1cKqSiVb/UYTc70p813VE0BRXff5WaHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 00:06:21 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::aff:f4:9dcc:3f5a]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::aff:f4:9dcc:3f5a%6]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 00:06:21 +0000
Date: Tue, 30 Apr 2024 17:06:15 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tony.luck@intel.com>, <jithu.joseph@intel.com>, Ashok Raj
	<ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/ifs: Initialize AMX state for the
 scan test
Message-ID: <ZjGHdwDXxhhqXANq@a4bf019067fa.jf.intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240430212508.105117-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430212508.105117-3-chang.seok.bae@intel.com>
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fa8c8d-bd3d-4df5-e96d-08dc69728840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8vZzKw2K6gFb5gqXKihmzCErEBPY0ZjOCkfZ+Fl5eT2w9n+IbCdELALsHRY8?=
 =?us-ascii?Q?nq+T4xYktDc3oAoCi8bpewW9yVHRi+24c5iL2xNb9b+zT981Nu7rKYb0dGSk?=
 =?us-ascii?Q?QpVF6yQsZkGDSDzzUAjirjCeQTQr2lUorvKQO0v+vtw+fhFZ3nf473gGFG0w?=
 =?us-ascii?Q?A1ipcgDiNrNUdP/XP3ZL0KWf4UaxEfopHe4hVIg+fW8sNu3JIxOx1T6NOMiG?=
 =?us-ascii?Q?hiDpkVJmoHEYCWM/oCuS9fhn6OZNP4M5Pcthuop4ClbVShpcLPc4x3yBGLlw?=
 =?us-ascii?Q?25qSsWgCcTBGgx9AEy8qW3Hvt0JdHKrdSdac5pC/cpRGx2kXL4KxUIGO7Vjp?=
 =?us-ascii?Q?4chyzQmqbqdSo+MGgrceMNYRMVsXLZAInYz/NNy6QbkwD7HIF9aDEYKHLuYq?=
 =?us-ascii?Q?/VS5IGfw5X/cs+3lZnSkwpEvtkMZSt8Pfbyuh2oNfggIe3kXvDVix1F46vvo?=
 =?us-ascii?Q?0NWHYu98T5R4E6R2SG5ygXE1b6Do3L48bcmtYRxCzZcS0vDAsKqESfwZ51Aq?=
 =?us-ascii?Q?5X7mj8k5whm9xhBS/joejPTCMibwEPhynxJ+tV4xZ+LSfycvQcWshnfU3Rqo?=
 =?us-ascii?Q?dGEldJhrttkDLZotFIan/TNmnCxhFjxKKq5QIz6eysWR+8suUSqlJZFEIXWA?=
 =?us-ascii?Q?f2hhkz1JIQ/nrxulSUGZgKYw7gDNS2a3TSMU4vquVmCj2cwb/zy21rhEGKK9?=
 =?us-ascii?Q?jpi+TVjWnMTay1/C4m3CetYDA+K9KTvNLK/ZySQEUBPJQTBGocGSwUsKeJCu?=
 =?us-ascii?Q?GZrpqT4IDhwe6ZxMrp1P/JaEi9Ist1FTZEQuJoN0mAHJx66JQsLCVSLUPtqm?=
 =?us-ascii?Q?P+yFsK3yNeUpRAWpmuWSnreWUa+yX4EVdHjN4ThklVodPYq9/MAj/DjgM2mZ?=
 =?us-ascii?Q?rJcF6hICeybX8nVlOhWGlZ7cH5OlWWTKtmtjb1X3vtORpcEVm0C32zQcDkMA?=
 =?us-ascii?Q?SYL78S3Y9rBf1xTqNsmOCVx1KkP0dv/wBHHpJcj8Ax9TeGmwpJOracgA2Ot1?=
 =?us-ascii?Q?+/BKpTZK2DIb+I7BxVPANiFS86NewGe70+jz0zaeOaSNGOZ37iAvvUSOzkF9?=
 =?us-ascii?Q?SlopkRcZ/FyzoVPrsPb6y8AhrFQQvoPAZQ20XQmGh+CRF3QoBfJ2daX2mv6r?=
 =?us-ascii?Q?q+hL/ffkirbwGvJ6SS1M69s4yNy+qYgZiqTy1HEJX+BOqdGQ1xfqZl0tc7ci?=
 =?us-ascii?Q?X+Cr0kUKSWV29nlnxM7J1ctRvuYmXrUcv+3C8ua+wCGvlnMjSwRm9uqYCSkK?=
 =?us-ascii?Q?tGj46hNr5QRz9LgLnZXt1Ii6hE+IW0w70daKehWPgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?okWEOboQnmOt5A/Nn6GGGV0AMw5+7uQMCupQczhYAqiufvbeYuVU8J8QosHD?=
 =?us-ascii?Q?WVcGWzkhNggM7gy0d9ztZdaKUYgmi5n6itedpTVSaF9uZRhGzC6qGmT5uoKD?=
 =?us-ascii?Q?g+ZhM/rM2IBMljdrOS28HlnZutS739oInj2Upe2JaDFSz3RkWT4GpUQuPVql?=
 =?us-ascii?Q?uB1iQI/2OQeJM7LkkX+FPbmgnhr4azh9/3cXO3I6cmWpL4AEYEho3Soz7EcK?=
 =?us-ascii?Q?/+ngTRStlLCIU+uyTbkZUQ3laAURL9ueLxGPGKbFwHUJOpaWz0MXcv5Y65E3?=
 =?us-ascii?Q?4UAyPbUb2KjC2PEajtK3WMv9QlHuyqcCyns7DfLBc7Hb86JBQaZoGdmRRjns?=
 =?us-ascii?Q?W/1m9b++abI3g/fl/WfjLr+zO3ZQkjAbLCrIMUDNwZ3gOiE/DNjC3oaHlPZn?=
 =?us-ascii?Q?pkACKnskQFfHfklmCWnQZ6vQ+Xn/yuy6RSGdEOCXfoLdlQlV73YrqrQwepMp?=
 =?us-ascii?Q?lPpPP+M+VuxpD5wWu1SNQOPc1bEWofLkS8KjUpGIcIRg/9IY99ZNaIoa8oxX?=
 =?us-ascii?Q?lEFF21qyqFPUAhufCIYqWHKQXcftG2GR6xKNcY2536Dc6SM0LZbO1VuvPex1?=
 =?us-ascii?Q?odH95o9TVbD48/bXTIsr1RViDfxjyiruEfvyK4wgskbeC2MZ3uxU0vIOssx5?=
 =?us-ascii?Q?/MJ/3VliA1iHBONQytNSN/K4u2Ybhr6GCiM8CG3PnlfurmgE0KEvXcMnQd0X?=
 =?us-ascii?Q?BXkut/Lqo8Ota8ahTrxn7z85O3W/zGAAueOkqfsQf1cNmlnCJon2P0nNKIjg?=
 =?us-ascii?Q?OE8XeCPuZEMPCHjs7bSnY3s0O+qrcxTTVg2zjL9AXuaJbhT7MHDkZFoq9JqB?=
 =?us-ascii?Q?/kNA4ug5xt/RGi4DUfhczhXz3sOLs3hZ/xE1SsFb9l0Tcyr/4TLp8HvPmck+?=
 =?us-ascii?Q?oXL1+eV4i9vyudvLa8+d1XemMR+KjyJmKSM8lkGuYcEQm6BaVD+ehphiRz1n?=
 =?us-ascii?Q?oQsgS1RJlJIjTILD6Sb48fCz0XbqV4I46tjixi3WRSHajRyX41tl4l4yxcPc?=
 =?us-ascii?Q?DCNjvAcNq/rdO5/YsAv2TSTDkJYukKcYeL/LgtXJTkrKutSXNXrpWsNBORPr?=
 =?us-ascii?Q?zjjx8y1EOCInfg+4fNyXMVzSzPKeKx+ofVwtuUDNRaY7knF6ChosdO0O68vj?=
 =?us-ascii?Q?g6847hD4dTno4/h84a+1Bh5qQwK4+yg34cgZ54GPLF67VWGF5X+yVATrwDcx?=
 =?us-ascii?Q?a9R4TUZsEVcJGc23pFdDIfqW9MH16DjH3bA30kDjQc9J6ID8h7rJStTI5dsL?=
 =?us-ascii?Q?RLGU2G9h4qGOp5zqVXBbqv0ZUqdeK6phQf40aeyEOsNDpeRcHoJwJv5kkDG/?=
 =?us-ascii?Q?/rVJBv2xyzF8C7KRqWwblrJdlvHdqjCn4f3mH09UaSGqVmADqKs6e6BEvCl9?=
 =?us-ascii?Q?SBDwkOhIFP1BR6rvp9Ec+GGgs3ahXhEsAdgvN64Sj2Zlj3oMme5hMHx/2Nyu?=
 =?us-ascii?Q?5NB3d9vGPRSl75J4oRkZxfle7bOkqAI3Xy5YnjWM6n34XqzZhE/M3rCumDab?=
 =?us-ascii?Q?1gOtl27xWxmNFoVk1CkYrS9U3DSfaCI3Gq7Wyo1FgXJVO7XIgBJoeAu0xj1A?=
 =?us-ascii?Q?xl64ocyWMUYVQWuHlYCeyLMnbiW6jDrJuBIOCnhl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fa8c8d-bd3d-4df5-e96d-08dc69728840
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 00:06:21.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0TsIA0XlDgXOGKT2ij6aivF4vgQj/BcHBj4tXPra0cd2XxAIy5DPMOTy+tnu8wbP3+hC0kCjnP+AH1zUoJ/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

On Tue, Apr 30, 2024 at 02:25:08PM -0700, Bae, Chang Seok wrote:
> The scan test does not start when the AMX state remains active and is not
> re-initialized. With the extension of kernel_fpu_begin_mask(), the driver
> code can now initialize the state properly.

Avoid "re-initialized" and maybe use the same SDM language here as well?

	Infield Scan aborts if AMX state is not in initialized state. Use
	the kernel_fpu_begin_mask(KFPU_AMX) to ensure AMX state is initialized.

> 
> Introduce custom FPU handling wrappers to ensure compliant with the
> established FPU API semantics, as kernel_fpu_begin() exclusively sets
> legacy states. This follows the EFI case from commit b0dc553cfc9d
> ("x86/fpu: Make the EFI FPU calling convention explicit").

The EFI and commit mention is worthy of prior use, but the first line
isn't reading well... Maybe

	Introduce custom FPU handling wrappers to ensure compliance with the 
	established FPU API semantics.  This change follows the EFI case from 
	commit b0dc553cfc9d ("x86/fpu: Make the EFI FPU calling convention explicit").

I dropped the note about legacy states, I didn't quite know how to word
that.

> 
> Then, use these wrappers to surround the MSR_ACTIVATE_SCAN write to
> minimize the critical section. To prevent unnecessary delays, invoke
> ifs_fpu_begin() before entering the rendezvous loop.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
> Tested-by: Jithu Joseph <jithu.joseph@intel.com>

