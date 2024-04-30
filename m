Return-Path: <linux-kernel+bounces-164801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C748B8316
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B2A1C228AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4A1C230F;
	Tue, 30 Apr 2024 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A81FlVOb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF381BED90;
	Tue, 30 Apr 2024 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520559; cv=fail; b=nFTsjugqdS4q6fLXtxHpbdAlxLCqTcQYWeC081pq5PJn/HSQ24fLmu7irIxr5uBGE6dZEk6b0yq/aJL8CY6Fxa1Nxp6TMV5a+/MTY9tjcXPkNKViP8eaLlAHR/G+TNDzN2gjlOHoslcFYiPUVExPDPfItwh2cEYa+fUc8ZF8AMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520559; c=relaxed/simple;
	bh=8pyI6/sa23OF4SYr3C7y8ZVbQGy4rYD+p6Z31pE4AoY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mWZcWNrEnBDhHylBexiDys4Q9xdAlBH80EHsZAC7GT1xu3dwPdjMZA6Ikv6z7vFwf89HoavUCD80qY6QZFBIT6AcVVlxDfgyT/coOsL4we6qpQ4qfhmhVt+onL3hOhllh1hCuuBp+0qSIobrl12vETEhQL7/gcBgeQQ0owTG5eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A81FlVOb; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714520557; x=1746056557;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8pyI6/sa23OF4SYr3C7y8ZVbQGy4rYD+p6Z31pE4AoY=;
  b=A81FlVOb5AUNfbQGvnS/nyS5dN4iB98BpRKsDN2LMe5yoBy6L3YQgtRh
   zw0s63rqCmNqsv+r0me5Mbkh2GndMfHuBVwr14DowvDji2x3pbK+f5+bL
   AfWQh3NYu8p7xxXlYTBpLURAJX7hvUWCxQZSAWKcZW/xTxudGi5ab9uSR
   0/YFPgtLFEKPu3KoYowV3OW9cTrqoFKJyoTBLFRQ6Mib34+NiqwPMs84s
   EXYNELrswTRZf3mVcAd6HyxPbQtaoM6bV2gD4485vGmtKcCcBp5Qjq9eu
   a2AALhpiFvi6Nkfl4xOqXT++Dvnqy1hii2lF/rHReDw9yf7CPXYKrnKPY
   A==;
X-CSE-ConnectionGUID: WHn+LJzOSFOKxbh4tDEqdA==
X-CSE-MsgGUID: c51wT23KRt++OCwFdFquTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10084292"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10084292"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 16:42:36 -0700
X-CSE-ConnectionGUID: /p962iEzQKW0hoYz3Lpl2Q==
X-CSE-MsgGUID: wZOKL6FCSe+mzOJFK670PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="49841541"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 16:42:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 16:42:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 16:42:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 16:42:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiwbN0Aa6iL36VPh7R7FRRaaLvdJMAmrvXZ5YZzkiq6ev73maUPLNL5cGxdl0mxbW2kh1uqL0y7IuAYcylQFuuuvtPEQmKOEKHMZdX0Gz+B/rJV0L6k9NRjLO1JPguVWg4h/vWUKCFaCEQoPFHW3/d/qX1boY5JJGI/ibZT5hb22I4U0cHwNqh5rRsuxF0ONytxjRCWWmpP5A69KLXn/ddbZvoXhvUsOxwXcYHDxIr97dP/Z9cSHuPxBwW73Oo5sHnLNO9NcsyifXT9NMZa/QKaxBCeAphXnFmXb0A8oac22NQxbbDRJxYlUF4uUDCYfO9Tht1Sy0t4xFnGC4yD3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ijf+uU1hjqISWGdJBKWWc7aBCRRixYXmjSSraX+yoY=;
 b=mG0fVh5q2GQYOaK9ZdgBDXU0saX2Bx7LJOjPLgFGjN5TACfXT8hssWAaCgHg4Ne48YpfWlLDZ+tw8oKc2WbrCpqGonO3Tdg9sYGjPdYyNyS/t9O2dOXn2NWnnpnlonrgQlS5skEhdU25ybNgjd4QMLyf/PApDjU/t1QbAnyoIrarBiaQIe9F7d2cIIqjBxqEuqGCz1rncgHjbQunIDwIqIfmECEK33ySE72NPp4fp4G6/c307dL34yWdYQbcBNlsrDSAhNLN7g9USY9mWIEDDrA9jEEL87wykHscPByft+pbXrRDrIBIASF6ga07zazs/ibruShBVCPwkgjtOT8NYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CH3PR11MB7251.namprd11.prod.outlook.com (2603:10b6:610:147::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 23:42:32 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::aff:f4:9dcc:3f5a]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::aff:f4:9dcc:3f5a%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 23:42:32 +0000
Date: Tue, 30 Apr 2024 16:42:25 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tony.luck@intel.com>, <jithu.joseph@intel.com>, Ashok Raj
	<ashok.raj@intel.com>
Subject: Re: [PATCH 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
Message-ID: <ZjGB4WPJWj58TF4r@a4bf019067fa.jf.intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240430212508.105117-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430212508.105117-2-chang.seok.bae@intel.com>
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CH3PR11MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de85443-25b8-4986-4830-08dc696f340c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kwzg/vnj1EUHrHinJY6jO2FsVcuWNCNWqcFw365josgx16owv8HshLch8l1I?=
 =?us-ascii?Q?XdsSKB7U/hN3woZ3vTEifbDiDFYNDXm/s6eW0WbjXrvYelOblgXOqwBFryzm?=
 =?us-ascii?Q?ay+4WDo+/XFYcYCuzRt33xnc9tBIPrk22pyodUy7o1TRuMlsUFDNr9R2dxXI?=
 =?us-ascii?Q?l8aJEokX1GoG0goQpoaXuiUjAC+Mdhbuthm0mu3mUoou246GOML1lbuJttv7?=
 =?us-ascii?Q?yoBqGWD3/d+tfeBPNS1fk5SE7gmY2kDneR4MCVuCZJa5+yZfyIk7w9eTDXc0?=
 =?us-ascii?Q?+ATiaqP5yUFnViAXeNJCrT6gr9oyANeDRr62cNIEMDsYq0B1RPxXr33odQKK?=
 =?us-ascii?Q?HQsGUTCe+MfMEblm2X/JK9Rgc55DZyP0DdOOdWsbeN3yKdpsJvVfqqdm/r0c?=
 =?us-ascii?Q?9AFR/194XK9vpyY/3/7DeqAkf2CnckacxbqpxGYxfXEcBQOr4XloCTKjNUkL?=
 =?us-ascii?Q?HOJUeoHGWMBuSkPUniLC/ZxsA1E9i819Z3Q8GcgBNh1H5dlIjEuyaTj5AWNt?=
 =?us-ascii?Q?8alnjkRSNh6t2ontHLTE0fjw3t/8HwDxFjJWSr0Sl+oUaCBPQnvTHJ9MiwyS?=
 =?us-ascii?Q?IeYhARAWjfCHHRIfZEZr1ZK7fl+RTD+RN9Q/RzlzH2axs03AGzGXKRObFb/B?=
 =?us-ascii?Q?OAsg+13aFHd5DYRwG1qrINSis/fZZP/sZffL/WQGldKB7m6jKU7ln/sg13pj?=
 =?us-ascii?Q?rrt0gQvc3IsLTldQjEk5fDXkltI/bRgW+sTnOxWsKaT2BmqB800ViPs2Ak0m?=
 =?us-ascii?Q?wBeBIxr7UUGaY6ivhN6jSok7C17Agr+g2dC9cbtBYfUKsWSh1s4kP27zl0wo?=
 =?us-ascii?Q?zjLzWBVH93zuCw7tlh29G1+roQu8kKTC4agWS3LVyQ+u/3xW9/vOtuwm8KeC?=
 =?us-ascii?Q?TjMHl3HJkoO6vqSi7aOEScKXCn+3o/cOx5tp5+QclseJScBXQbNBZPr01P8Y?=
 =?us-ascii?Q?PQcIpSKAiRXHRV0wQqENaP7dwlt2WkHORGNJXLpnTaY/pmvRxiewmg83Xfzl?=
 =?us-ascii?Q?A0zw0NmbKliA0yO1Z2mULgnW+q9gcNvKThUvDypkSG5sXmvcU3nrG+kVF61s?=
 =?us-ascii?Q?P7jGWhZlYrtF5XshvciXPQRfQozD2OQBJQDlnYt0eUxdE+2ab8+olMd2rYkk?=
 =?us-ascii?Q?+BTihZYJUr+AZ4CBz4Z2jonV38OGUhnPS8eCBT+INoSBLoCbvY8Xqo4Ks+Oj?=
 =?us-ascii?Q?dy12pmozX5u3+3eYkHqjpBegDf7h9Wi9M9vgAMnikZbGKIkyuoyElZ0DrGPh?=
 =?us-ascii?Q?PDs8j6PP4cAp10qOoWDppvchShqk5U30fMh3iX3H8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?viligf1tSKeLlLsskSNYmqKyiM8baG87ZhpS3W+epbnie3FCws2p/HjBD41e?=
 =?us-ascii?Q?I22F1BItqsbpc8zwxnuhtt4hanP56l8CZo6CYyCDLSxoVwq4tZiZqw4j2fNX?=
 =?us-ascii?Q?1qkiiAdJ22nSm02R+jXLO0LeAYKmXaP7aIKpxZG4nsuF6nuYlrmftc5PonPr?=
 =?us-ascii?Q?elHMAFVtyUFCy+axPwAOxQONdnWAx1uCpiwodWlg7GZCyUNMrxoBSeqLqvtN?=
 =?us-ascii?Q?Tys5eOiDGQ5TRl5VGOUi+BQ79A/IWftFMvCU3Fg0knfrBS+C8PiBUT9H/LXZ?=
 =?us-ascii?Q?SGR+1++KSDXo13LJ4VRpUaW7wd/3FoSYHEjkpYpRXA6NwiLwmJ7ZyOcUr97j?=
 =?us-ascii?Q?oWb2bpm9oW2u+p4a/P153LTAK1M6GqSaucB92v76f6KiBXZzLcuNyS+OCCnV?=
 =?us-ascii?Q?tvXXkK3/RrbT/Ntp/yv1Cug6i9ik8C5riTVxAbnpOn6YSZxFIoklbS1xkxcT?=
 =?us-ascii?Q?rJ0lL4cH5uOeiE/6q9hPdrJisv+1VXa8EYc6bp5l7SiemmG5MB51kqcdizpg?=
 =?us-ascii?Q?p8AJrEmhUZne2ePAbcekzGPpSOlK8fWChfyyYXcJ/XlYQXE3XpepV3cDkL/5?=
 =?us-ascii?Q?3g+z5LoKz0xlAuqdTo3oHe109Lrd6Yrq2/w+rA1wDwf3Y5/ahk3ArR5ecngP?=
 =?us-ascii?Q?noqa383kWJKxhQDtF8wrsJXYCIYToZcMN/rK6FMG/1tUD4dQ+51soWqnlr+i?=
 =?us-ascii?Q?xTZHH4IhbXj8CyM41r5fi/XWMVkHrB3qltkT5KzSxWcD1gFYQscV8cqPgniI?=
 =?us-ascii?Q?+2QWbmxrEWJzXL/WLykWB8G8bkOcw2qtPPsjIyzWaXsuIHds0TbLuu4UWVPd?=
 =?us-ascii?Q?QQn9ihvCC6GHui7wLR+s8qvKa2nmmtQp6Bl5Q/9YXPymIeYfpAWbL7C0d0Xz?=
 =?us-ascii?Q?Jvy6CHCsaOKtAF1wJelxIktmXEFBGtSN20urFRPBU9ZXF1NFR0ah6J0UHQdt?=
 =?us-ascii?Q?+1DfT4k122PaKH2gLU2NegNkqzKej72mM88glk1DvjMZinAm1d/+EP9RVgDN?=
 =?us-ascii?Q?tV2ROjhJocYuFzj39NWFlktt6RSWrXYr/OXUI/ZJ0J57E8k8MTAlAKAd+pQn?=
 =?us-ascii?Q?TmvQen5Wh3rwQ5KVKZITcL2Knss1k0bbChefdK9zYX7IiTzj/NmYjOZD+OFj?=
 =?us-ascii?Q?a5WXyfJDlNOXQQizod6De0W0vQ82HEhGPL7AIf0TXGtVlCOhLE9rVpabH/bd?=
 =?us-ascii?Q?83xB0DqI5kJy/WtfVSpD39v/9MryV0j+6IplZTGkDd5bL6qviBaB2YdCO2xD?=
 =?us-ascii?Q?33fah+OfD90XiCgIcoUh4LpKt2hD4qOIaTiJt5DCGOgfpdjcdWd6+rkigEmE?=
 =?us-ascii?Q?1G1V39EcLZIY0eL8YF+7dHfLwyOoXy/XdAMpLuZ0cOgpzkPTwu/5nDo+mmjL?=
 =?us-ascii?Q?bahDB1RUXT+CgDspW6bHOHcymxweFuFcp8HJWjeF6Jpiu9LEyUhEWeuU2HJg?=
 =?us-ascii?Q?AM1+Ocy0YuL7f6gHCiR34jBjQHzTIPiqpE2ochQH9Gi3RAxJDZBSqe/445OG?=
 =?us-ascii?Q?19wNbDpJ0omwJIRZK5lgIWvojWm63D2I5lToNd8rpUVUAuuBkexFnXYgzPC/?=
 =?us-ascii?Q?FBTmhS+Ddrc2npfvM/WW5K+RINHBIElg8Wx+vgGg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de85443-25b8-4986-4830-08dc696f340c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 23:42:31.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzwZztIjPk+ZBB1hhRg2czYkpnbbPyiDq8+I1N10ozgOIEsfcES/tXf0ZNUF2PNlclXA/5k0s0aFHL9y0ZVnwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
X-OriginatorOrg: intel.com

On Tue, Apr 30, 2024 at 02:25:07PM -0700, Bae, Chang Seok wrote:
> The In-Field Scan [1] test does not start its operation when the CPU is
> unprepared. If the AMX state is uninitialized, the scan test will
> immediately terminate. Therefore, a proper initialization of the AMX
> state is necessary to run the test.

Instead of using new terminology like "unprepared", maybe use the
term "non-initialized state" as in the SDM for clarity? 

	Maintaining AMX state in a non-initialized state will prevent In-field
	Scan test [1] to abort without making progress.

> 
> Although fpu_idle_fpregs() initializes the state, its usage should be
> limited to specialized cases, primarily before entering the sleep state.
> The restore_fpregs_from_fpstate() function offers a suitable mechanism
> for initializing fpstate in general, which remains within the core code.
> 
> Extend kernel_fpu_begin_mask() to include AMX state initialization,
> providing the in-field scan driver code access to the appropriate
> initialization method while maintaining compliance with established FPU
> API semantics.

Maybe simplify the above paragraph with

Extend kernel_fpu_begin_mask() to allow In-field scan driver to initialize
AMX state before running tests.

> 
> [1] https://docs.kernel.org/arch/x86/ifs.html
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> The necessity for AMX initialization is clarified in the Intel Software
> Development Manual as of March 2024, particularly in Section 18.2
> RECOMMENDATIONS FOR SYSTEM SOFTWARE of Vol. 1.
> 
> Side note: restore_fpregs_from_fpstate() also sets the x87 state to a
> fixed value. However, this only applies to AMD CPUs with the FXSAVE_LEAK
> quirk.
> ---
>  arch/x86/include/asm/fpu/api.h | 1 +
>  arch/x86/kernel/fpu/core.c     | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index a2be3aefff9f..67887fc45c24 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -25,6 +25,7 @@
>  /* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
>  #define KFPU_387	_BITUL(0)	/* 387 state will be initialized */
>  #define KFPU_MXCSR	_BITUL(1)	/* MXCSR will be initialized */
> +#define KFPU_AMX	_BITUL(2)	/* AMX will be initialized */
>  
>  extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
>  extern void kernel_fpu_end(void);
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 520deb411a70..0c0235b4a901 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -440,6 +440,9 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
>  
>  	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
>  		asm volatile ("fninit");
> +
> +	if (unlikely(kfpu_mask & KFPU_AMX) && boot_cpu_has(X86_FEATURE_AMX_TILE))
> +		restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_XTILE);
>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
>  
> -- 
> 2.34.1
> 

-- 
Cheers,
Ashok

