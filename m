Return-Path: <linux-kernel+bounces-157418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C78B116D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B374B1C20823
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40416D4F2;
	Wed, 24 Apr 2024 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJygGHwI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669D143894;
	Wed, 24 Apr 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980815; cv=fail; b=s+SrVWGLfMNdYM+Y6u+Ugg1GjYCSqbRblohMgtmcuMhbmDJJmpFdgTLLb6nB+G9bpk0MvdhIj8XhqwMYteOcj/hmWYOLtW1fWzI4FyhQzOh6zFgDR8xVe2TSkpAkDhRKmtokqUJnxuUzJd7pe0b8geHX0EqmWsVrGVqtjK/GICA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980815; c=relaxed/simple;
	bh=2GCzyQzxiohATTSKFG8S8oQhVqJbi7aAtqjDWgNVezs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YK9YJTOMzF3YFJmrHU/GpQViW/yGAT9Pp8dZYA9shIXtUNXWIFMMUc/0RNuDgO6BR29KVnwQxlKAbUrebJotpznYvnuYqgZzgt69XSN4Gnumb9tLB5vBdsnTqfJt159UGWy8mdnQ7PiYAwvAFv2MFlWww+hKDmL+GRgEjnZH6/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJygGHwI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713980814; x=1745516814;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2GCzyQzxiohATTSKFG8S8oQhVqJbi7aAtqjDWgNVezs=;
  b=OJygGHwIHZYzQVtd/ZeWq4puowKeWbdfsjJIb6iAdtrTFyCYYQeK0IZS
   pCaSzB9YMbB9PG2RXWs+pRs415Z564QwVQklk33aOwC0Ny8Of0qg7rQ9i
   Zrzrs2bn4aBU9iogvIoHj4geYJ7QWIBudWwPBl6QUk//g4XoQQ9PYYpmP
   FG+CFkbKizXkWO7qeoKhWr3QCOZCeh3ND2AFm7P+dDroEYoJ3Gdp7+wX3
   R8C+GohMx4Rtsuylquyn0pK6wJTQmdHoO5lPUVZ66lhDppDa3io1Qe34n
   UnqiwgQu8JHDvC8oGjjR9iiWGmYS1sz6XGiUN7yYagqKeVH8jtO61BTUp
   A==;
X-CSE-ConnectionGUID: H8Aj4aKmR92pU6sgk8wLbw==
X-CSE-MsgGUID: Tg6zsrI5T5WBWIk1GTU8tA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13414579"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13414579"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:46:54 -0700
X-CSE-ConnectionGUID: CyNGTg8QRLWwPuDfposaSw==
X-CSE-MsgGUID: 9d04EtFJQ0C1CeedNqRhqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24835182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 10:46:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:46:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 10:46:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 10:46:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciJhUEnEErc/BD4Q6CsblimcD2FZNqtm3VYkNSMIaHFDW/sFKWuE+utOsXjShA02LGqwZkTa91Z0WcjvpIXY9cJ0lb8KuTk6g9sApJlKB+pk7HmrHroigfnWWbGO1Flpvp5owbnaDd1v7Itxoga+1kTOLGfsvYVa8kX7Yb4I4cmnTEtz4p1uNAEAICkUpwdieUeyI6C6c2gXtCbhQeRXo4xPco602y154IKAqkfxKOqQyX6JLckNLNDg7dkiDKab4jMgBOCBE24zihx3aHe5bRSD30IZsVtmkszliOQ6ywpbFZXMw+GCftJJVlCoD9l/8Qgkd89FrhRz1xk7VT/agA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEDk2y3oU5sccwnwOtfE7LRFmMz6rHHLXV64Dcdybdk=;
 b=caBjkckeTxRYhQsxu5OptGxV5hy20q/moQkR7Re801hGKjF3ZULArFC7Z4V1cpsRSeXH4ay8hW17dZBU/9+dITyRAYoNahjIg4wZeUOHZbziUDaVzv0mKnu2BVPte5OHhy7Tm0k4GlNa1ko6LfFEpRoCmlYbNT/nncTegzvwoWHKIHx11oOJkqUBVT2Bw/hqJXoLwMTtv6rviI/vIEFBjKpvGH7AOK/En4LWQFAxZD/gwq4NSrIF1kOm/Sht+Qz2rNPf+sVRavzSz7YKd1PrTTyvBbruExi0Q8wxk+OGlx4SAfpmI/D/YkO2uxYCf8H5xyt0vbx8ToRLUjyStzBjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6505.namprd11.prod.outlook.com (2603:10b6:208:38c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 17:46:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Wed, 24 Apr 2024
 17:46:47 +0000
Date: Wed, 24 Apr 2024 10:46:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 0/7] SRAT/CEDT fixes and updates
Message-ID: <66294584e3869_b6e0294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240424154846.2152750-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424154846.2152750-1-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:303:87::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dac91ac-c39b-4caf-bed7-08dc64868381
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QLdLaclGoQ9IVa2++LKFUM3dFrrFixHsSfO8FUWGVJ1SqwvrkeZMhaU1txzt?=
 =?us-ascii?Q?qoFB3dOHWfIept5riac/gUddkf7v3aIQmi9A9vj9zjx3AFhXcQ1evv3InQzG?=
 =?us-ascii?Q?bcs2vp19Is8hNG8KwrPhZ5qP3IPXEc2Ux/e+jW51tt2iOV4JkgwOecwm3/v6?=
 =?us-ascii?Q?TUsF8pdvO4gzEfGZiFZjaLCV8/x6r6McPAYoLBEukfv7oeDB31PKQG6ajFLV?=
 =?us-ascii?Q?RAJ9FmQmcSoz3vLYOEKLhLBBzmlW/cVsq/iC5Ohbpd3K1E/BaM1ZArbbBk6K?=
 =?us-ascii?Q?eVUGLliRQJOgq0T5UXiqLS64FmjR3Lm55+VgCzFzbW/OUJEpwpqLKNhCzI3h?=
 =?us-ascii?Q?UTJBKc5OYEqBvnjy55Vd/iCnwFUeytx+NN6Vfk3ZS7qqnV3DKzCbxZ5xbJ/v?=
 =?us-ascii?Q?NfOocFyLfgvBeFSFVEBBCKF7rypXyQVATrHYQhIQzjhOjmgaRWsJaor+bjkx?=
 =?us-ascii?Q?Z7glsvYQKZ/J/vg1kaTeDcK2c2T7tUr53DivCNAtEowCGfBu0GBXNY3/46M3?=
 =?us-ascii?Q?ZeuaNB5gAGZB3aJaGoc21x/GCLuj4z8Xb9AYrbgvO2ST4uuBodbILePCtf2U?=
 =?us-ascii?Q?CzwZtQC94zDwgC36mpdlRHVpH3pzchEiYQltld4CPfqYEeGqIqCO/UcNJMUS?=
 =?us-ascii?Q?qXiOjpB1SyHN6NacODFjPD4YfyJDpGlIwFTYnED4/hrtJsznFIqEJBa3KTiF?=
 =?us-ascii?Q?o3+AWpO+SY1p4wimrc9qISP23i/NWu6evqh9QH3IRSdQJ28iQog/SCPIKXXw?=
 =?us-ascii?Q?Sisbj4s5Owv0W1AyRImWPKYxE68+WBwdHOcfkYWgtb4fz9R4bxLvW2/FIG82?=
 =?us-ascii?Q?jbPzBZs0JEzWScf6KHr0bfKv1VnDghGQ8KHC1EhhM0Vg8bG97nWWJsdhl6Kt?=
 =?us-ascii?Q?y7SP9PwRclMN5t8XBMnr9QDU4vdwfOUV4RR1iboi03NOcp4F9zIrIIa1tW9u?=
 =?us-ascii?Q?buI6SptF9Aa8P8XQw8G1C6UDLlDnkX1qqyVhlMwzNlR9UxEB3V1gwEs0PR4C?=
 =?us-ascii?Q?K/BWCRq4wbNx8qNwKsEhG+HNoa3DwhZ8o2/z6S6Y2KZROFCuRv4Ww/jLwz0m?=
 =?us-ascii?Q?ykdkiq+SEIJZS/YFpzuej90qF2TnzcKwk0nNRfm+2S760VeLZrsPvLOlbE9V?=
 =?us-ascii?Q?+IEqVJeAKMsm1Uyo7U6pIys9oPswhhG7/hixKGnTHMuwYrjOkQcb8wGsJbWd?=
 =?us-ascii?Q?lliNxSha7wzCJzExfuaX8BKIySXR26nwawCoSl0/kL4vCKQvZTcefORScpDN?=
 =?us-ascii?Q?b9lSrnUP4XqTuEb/TJlnyL2FOXHheWDz7g9qEvl3IQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcX/Y//17h90c/rvVIWEbDJb0dOJJEHo+OZFflNP39H9hx5JqIuTV+L7slb/?=
 =?us-ascii?Q?dRs7E7cY1ZS02U1oiM4/MNGBy4Cy/slNCvDJR05WGotq01etsLi3huF6Ym3Q?=
 =?us-ascii?Q?6e28I8Pwg+gm/OMh5GheolgLqvplYHxiziuaXWLnAMSlq+OotDeNuvZnISqr?=
 =?us-ascii?Q?pD8LFJEW7E8E6rk3H/gnibm5ClbSOLRjdzUuDrNsXGeuWwnayMcyajioH6yM?=
 =?us-ascii?Q?DV0LjIO0TQUFVeKoQYGAQCgfvXRt4J35JYG7sP4umaBbG0xsgr40yeW7PmKF?=
 =?us-ascii?Q?Rr0WuE4ryG2iTMsFAJVusUx4ZsV2DIweoVFExzZOo6m249Eml9o1XspY5qn+?=
 =?us-ascii?Q?NgLwTkp6K5nRvNVDJgRL+EtAXUWl2tK5SKtjYGTZ+9/vg3BRcx/2NTffCOFk?=
 =?us-ascii?Q?j6mWNOx1X+ER80paUQnrv0Gi8DvcZa+hC1W+rB8J7LlhUPlOPXbIsNTiQjT5?=
 =?us-ascii?Q?rE1pkAffETnMZS7F63nRiuBnj/Zhis2Rz0u9O5Iyzpbi8N3JvXmf7khQi5vH?=
 =?us-ascii?Q?oiqmLBnZfDhdmRvIhhf7fhwuKyzD61LkAGc/uU0i92uD2md8uDkel+5XaSHd?=
 =?us-ascii?Q?YFMxYQLszd1jygmwqhtFnzzKcxK+ndDpUIUWBbI/MZZGMt+C57GFAODoTRCb?=
 =?us-ascii?Q?6o7LtWciVKoQosedo6nQtGS0K+6ec6QCmd2dU2rPdTzPZZe3P9+qX13tJAmY?=
 =?us-ascii?Q?iFPuC34UJhutJ+j/L2egcVB8W+ex1bMR3/HaY5ZIz0XXoUmQpEqZPUlW8HeW?=
 =?us-ascii?Q?0TGu9K4xMuKDMT0n1/KtVsGY1k6Q/KM6RKzADoczukg+xaRozo5SQakWJUNm?=
 =?us-ascii?Q?ENbh7hOgMV/2HjHrIApjbd7vPMliHvfBPFzXZSs+tkYKliUwUDgZb6yYYIOf?=
 =?us-ascii?Q?eJOc0+tIzyQTVCUqf2Iy79T/Uc8Vlp+CCV1bKGJtm8aMJda3cy7zJ0L836Hy?=
 =?us-ascii?Q?4odxt06ekGSORZ8yw3NgFmBoQF53JCrUNJTDehdy4DuA76+z2BYJKciA8T8K?=
 =?us-ascii?Q?0+1fU9a+6kaCH8V2fDtUmqizY2wgRrNNiDTX9Gs51sxayfHgXEk8Yo5WNa8g?=
 =?us-ascii?Q?/ZRsYtuqM3H8P5B9uTta8BTKWwaNn670sStoh3uPwQCbH18kbAgTXsUtIlRF?=
 =?us-ascii?Q?9UpvsCdUzC9pnOLXNrwsNIUySCkBlx8mEv4HaCQ3PjomMXTKmhiQz9vpeQxj?=
 =?us-ascii?Q?gN4Dzv6jTT9zL6VgujMcmyOk+Q/20JzPNlFItZi/yFz50sHQFaS33v5wIjL/?=
 =?us-ascii?Q?N/pImF86jGF1a/rOz9gB0esdtoZgvl+4eL+9XGosy0QwSu4CzJlFc7+Issji?=
 =?us-ascii?Q?vLBZTvVYXtIL72g1Rbt2K4jOqhe/9zUVMWkInbqyZ+cLabTBauAV1LiYfZDQ?=
 =?us-ascii?Q?C/kIDcS1fHlQPT8l9NuXZKdHJC3GH//+etRMcl439wm3oUVjbv8zTEccdgPj?=
 =?us-ascii?Q?Q4v6yUU7nZ6ER4E46BppJCW/offS1/T2cPXpUwrlKzVFBKXUwllvg6X3F9EG?=
 =?us-ascii?Q?6xhlmhN8kIxchyr8thiy4DibNgmHRrhDOoTKeLRsKrS5kEaT91sAClG2Jh50?=
 =?us-ascii?Q?kynbF/0neqwalixQLhauKmwmAG1P9ybFJqdXe7+zdMyn52mJtGdTGfneFaRL?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dac91ac-c39b-4caf-bed7-08dc64868381
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 17:46:47.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2NTX2dqnpVkaPf/NbbGNHJeHeUnQDEInfraBPu0JQyiqmFbMTOXOOl++XluMlm++eA+INAjzNNsyM56jdbVkYdxzkd71JVcdVptW8FaYT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Some fixes and updates for SRAT/CEDT parsing code. Patches can be
> applied individually and are independent.
> 
> First patch fixes a page fault during boot. It should be marked
> stable.
> 
> 2nd patch reworks the code around numa_fill_memblks() (Dan's
> suggestion).

Just squash these 2 together. The -stable maintainers continue to assert
that fixes should do the right thing by mainline mainline standards and
let the -stable backport process decide if a different change needs to
be made for older kernels. I see no benefit for tracking 2 changes for
how numa_fill_memblks() is defined.

