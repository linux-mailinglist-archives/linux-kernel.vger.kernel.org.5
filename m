Return-Path: <linux-kernel+bounces-145942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B38A5D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41CD286ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34ED157460;
	Mon, 15 Apr 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIx8h8MM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D16823CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217403; cv=fail; b=mUK3LBRlQEdT3hHXcMVH/r9OzChGYvhs0/QWCbvPM0D4nooHFADdQhobOx0peus/WSLS3aez0gTUjJ1Jo8s9ATulLVRHJaTehCmrgbY7NdEQ8emkHScV1VEaLh8mnLzxYqOFm706VgVbQLOp3TMgV6FAW54XWgmjNOx7FSzfmxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217403; c=relaxed/simple;
	bh=sLim0BBDGlyVTKzJnUC72fK77fM18ibaCKPM5z/IXv8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AkKSqHUPgkfrzcpXPKgpKCp43qVATOcdh4vc69icMc1sGDswBaF7y+tNCVdL41uf99YD/GMckKA8mHIviVAf3tmqJ/8zlz0gN6OflQZzlRAkLqdQJTf3441xhObFGrgmL+vfygFTq+gzxd9+ckQu7CYkfZMx2NJw/o24pwEIGp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIx8h8MM; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713217402; x=1744753402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sLim0BBDGlyVTKzJnUC72fK77fM18ibaCKPM5z/IXv8=;
  b=BIx8h8MMpRH0edVrERgDhpnPuVpP2cCGgP5XvEOHItpSd+zq7B+VQtC5
   Ncvqe9iOSo37YorfXqhb/dfOA+Lbr0bLazvhipsHD0qXF77ZLgaQmDKw5
   y2GWnEEfWcoh1XJud2RScIcebmw9Ddtao9Joy6T+OZp++qFtteiahSoiP
   Mtf6oI/xp5IDYNYuzWQDRbb3UMIZu0c7ez9hxabWyBAPe/fdLTchpahbu
   RRSSY21dFLWBMBZMCSQOXXYyohv3x39FYeLWlgw43kImR7aPHkK+LG4TS
   b6p+m8/my8/QUwORsFVHBce8usn/KOh28Mpbh8kOG/+68eFP3rWawV0OD
   w==;
X-CSE-ConnectionGUID: h1WLu27nSxyXNHYdOFlvKA==
X-CSE-MsgGUID: XY3r9ScuRee3gjbfUlMCZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12407956"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="12407956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 14:43:21 -0700
X-CSE-ConnectionGUID: N4Ds/B4TQW2C7vnl9wfS9Q==
X-CSE-MsgGUID: CrD3LAOISdSaOFCfcLR4Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26456301"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 14:43:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 14:43:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 14:43:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 14:43:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 14:43:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU4mUHcvNfVIiuFYLtbFpIjZcjH2n9950gVAYQHJrNtWvLLxxuxJ1H26OzXPU8oUxdxgPte1Pk5L1oc6ASbUBVA1tzuCX5kf8D4ZoLs5Nb/ZIOx+VinPGvRNscE0+vD6zGeU39CeDZ1D3h+Ycf0U75FP1BwjH9zKpbWSflrxEtS3AqvMIT8xR8LjTD7J/ieAB7inBKV10IJtCU9yEA6PJ5CqDqqf3UEtfrtP7O4GwjazpQRWrr/pMJpIYSTqiHfjCmRYFDpKpBNWcgUEzjg9WiJR/bv2CBLhYmT63iFTanf0UIRlIxHkb2upA14MopoCtfbin5hB672MbKtDnRJbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPppqBY8kacT0Vxhx7SAbfMmeFFNGuj4yOeroCKbCgo=;
 b=VEf2HdLe+3Ss/DuFizi5KhOuiLrm/GWOCvZWL3ejQLWx1hxu6zUYqJuXtN2LgPVml6jPdKRtnszZurD0PlXdBbftwFOFSwSjrDOBRffAZ+zIdvFIUwfiX1mdnWvjXD07MVIBDngVFRrTYrPh5BGivSB1PiqI2Qc1lUbHrsiyQATzuDiNBB4yXLn9UkTV8dTyR+EDS0txiqw+c2NvPjwgBcO43siM/Ha3w6WqAttTg5I12gX+9pSK5gm3iyKtxDIcm0T1h2+vR4elEn7X3dLQFMPvGNVaR1wSxfpU3Quhq4Grz43mOCVK1OK7t+QFObx2p0HAUrNglgsF0eh2m1udFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 21:43:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 21:43:18 +0000
Message-ID: <afe34183-4320-488f-bc03-075589bb6065@intel.com>
Date: Tue, 16 Apr 2024 09:43:06 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
To: Borislav Petkov <bp@alien8.de>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <ashish.kalra@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <a4o4wlaojm5am4hc5yhr2mpn7clm3sjy5vx3w76ahm52lhxvwr@msdcnkcj3i6k>
 <4875349a-90e5-4a04-8a56-7d172b17e245@intel.com>
 <20240415175912.GAZh1q8GgpY3tpJj5a@fat_crate.local>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240415175912.GAZh1q8GgpY3tpJj5a@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:303:87::19) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: ea07818a-6aad-4fdb-fd00-08dc5d951053
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmi/4KniFa26jLDSvcTW8m6M5et7LneiQOlK+RarDVRww9eD4STegkab5XxrwxdX0xIde9u/Jn0tbpsS7vIuPpNNH8y9zmysG2ds0R+PpdNzAPUexGBxeDFHMhpAjyWbs/dkW1rcMrg4ffVnS+fm2K9Zb6LELhqM5gl7GrH6GG9Jyupc8Ng0mZAv5kInZ6H+Z84Wr1WzgYVrPDJF3RiqMb924b5BEK0cqjP7D3soDpftnDDU4FiHZ1GCd5mSVT4Ynsm8UYhE+JTC77mCjWa7Cn5/o4NQOA2EgLb9QnCcIe7qanU2fvKdmlxUn8njzO3xpbGsNoLcGgoZmlNMFeu/jzbTaISzKw1+kq4qfjmswibMwq9NSw4Lt4nnuOInZ4Hafum60JmsQ6dS6WGvcc/2FCKm5w7e+UHCbaFWjbZjosIspvdDDlyThhqI1K57TcnVNq9neq9UUMHYe2k+4ql0ROs3bzBCCGcvngxWDQdzbSZhcN0PFUGpHcZdl8I+RP1ccANmvFOGmdBCgNtJF69Mfb8YqJvBdrXgSoJG9y/tytVc0wrnp686D1Ry+UHoiAbteQ8BcT2Etq/X05XzYq5KnG+wXiUwbF5gTRhxwVSOvIfxVJPBNj7/yeYS+aTe5CYArKP5EGYwewN/0ckz9Tr0txHQbptLD/jgdR5PwJiJ4ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1yRUNqdlpZSEhZL3RkQVZyd0JSSmFkdm1Ld3pnUnE1Sk50dkRHOG5hMGs0?=
 =?utf-8?B?MmoyYko4ZWh6UVd4UkpyNU5oTXduNGZPbG8yMlM5NHhydHl4Z2JqTUFpSkpn?=
 =?utf-8?B?cXNXS3pIU2VIZm9oK05tUjhVOGpKRnh4YWlVUElmbStqRE9IZFpSK3JPSnZ3?=
 =?utf-8?B?anRXbjQ3TVo2VjFYeEtvakNzYkY0SHNob1NMdlVscHBLTjlvUDVzKzVWNEI2?=
 =?utf-8?B?cktqRlJmeVAwQUhIZ2xQMVJoODczZkxqNFE0dFd0RHRKSkk2UjFtS3Y1V2Jq?=
 =?utf-8?B?dXVYNGNXdEkwMldqUENYaGcxUUFnT1NieEpybitPS2hrSS8zRFBBVGF4dlli?=
 =?utf-8?B?aG9hSFhYRkNveXZHY3BabjQwN3JpUGVSZWhoVjJHdEpMMlpJaGkzNFFMY2FM?=
 =?utf-8?B?YzZJeFU2MkJ2V0srR0dPb3RxSmE2RnlBdm5zQlhnMGNvaGh6a0NuR1B2YmE1?=
 =?utf-8?B?Nyswb2NKTHFjbkRaa0lTcEptS1VNOXhOb1lNWkdUUTVML0ZNcDBQNmFseHE5?=
 =?utf-8?B?OHkwS2Rkckt2UWlpakJBNi93cFoveXQ5YXE0WSt3d3NCZFVBTGIyQUxOZlB2?=
 =?utf-8?B?WWN1Mnk3UllMQ2lKT1QxdjNQUEZpQ2JlcTY5UnhYNGc0YjZJci9Ub3RlVlE0?=
 =?utf-8?B?cjdPQ2VhZTNPTVBCTHBKQTJhUWhvSGRaN25OYnpQaDQrR0dqdjhTZVhlT2JL?=
 =?utf-8?B?TitwSTMyb0ZBQW1OS29JSElVVTJsZ0MyQldVN3FMdFhyRHVRM1I5aEViSnd3?=
 =?utf-8?B?bEdyZ1RUS2NrQ1pEMVh4Wm9seXBtcUtWWnJpUjhsV2tWRmRLcnYrcklPWnNy?=
 =?utf-8?B?YnhlZHZzSjRraVlIeGcvV2c0UFQ4M0VvRDg1WjhiNEVPeEVNdzd2UFQyMXdL?=
 =?utf-8?B?Rno0NllZb28xbG5MY3lielg5ckxrS2h6YW5vMktNVWZPMm9HUEcxWmlHYkFn?=
 =?utf-8?B?RkQzYXlnSVRqSFRpM3F4eUdIL09uRzhncS80UmxPYnNmZGN6UVRFYVJEUUFX?=
 =?utf-8?B?KzVJUms2aUlpMVhBbTduWXVOSllFYWV3eTRYaWpid1g0SndGVk01dUVWSVZ5?=
 =?utf-8?B?Z1JkZGVrMFBsb1Vtc3pMbWhFTkJsRmgzbUhob1d5T202SXFuZUdpeXV4Qlc3?=
 =?utf-8?B?MlloQ1pLY3dPVlNOaWRXWHEydEZBNDlFbEhIVllraXZIZHovZm5jUzVvNkpw?=
 =?utf-8?B?VE9rUzZ5NWdMOGs2eWliUUdiRStmNWp4anJPV0oyaFAxcUVySEd3YmE5RjFB?=
 =?utf-8?B?WExNQXJHaVBzRmdURWgvYUl1VFRGblJRWUtTOUw4MGtUVy9PUEpBanUwbjhq?=
 =?utf-8?B?OTAzRGNkczVKL3VmYlpyeUYyM1h2YmxxTWtmODJXRmxnaHlDeDdvZTVYMnM3?=
 =?utf-8?B?aU1lUFJRcWp2czNaOXFRZk1lOVJuTTg0V1YxTFZDcWhPMUo5TnlQR1YvemVl?=
 =?utf-8?B?VTZWeUNvdWw3cVVHdllzci8vaDF5WTJ1MzZnTm5CQ0Nta2ZnejN3eXNOT1BS?=
 =?utf-8?B?eWc3ck9GckFINmdiM0JIZVVEVXI5UkJoSG84eTN5TDd6ajh3b0lOc3BTdWUv?=
 =?utf-8?B?RDNpWXdhSVE4YlBkZ3k0Qm8rNnBaWTd3UHlCWHVZcWRrY3g2ZEp4WENLQjZY?=
 =?utf-8?B?K2RJUkJUNDIvUzZ2RlVFWS9McG1FSitKSUszUm1sKzJrVzZoN0RxVzIvSXdz?=
 =?utf-8?B?a1R1WVdoLzNTRVhoZGlNRXJkREJYMThtejgvNlBTcU82a0ozMG5LYndhZjUz?=
 =?utf-8?B?ck9Ja0tKeTVQaWhMR2djTG50dW9xdkpzdlRZdVhzYjFTU1N1a2NRZXdxRGM4?=
 =?utf-8?B?VkhMQTJ4bFY2am9HYVZMNk9aaGdVSVpFVHZ0b0FJTHNsbG1MVG93Qy94MkNV?=
 =?utf-8?B?SzVnMmNSemVyNVFySGxKaVl1T1E5VUlueDhRV2dUMVBsNUh3b3JId05sNnNH?=
 =?utf-8?B?Z2dRY2x6cVB5R3FkTDJOSWJjTXpZVmxmQjFWc2xtc1Z4YmpZR0lXWkczUDRr?=
 =?utf-8?B?REpxVjk3TURZWGw2d3NhSTcvSEN3ZmRjTHdlTThhQmFldHpQeGVtZTZYUEZO?=
 =?utf-8?B?ZFVSOEhYejM1SzJvVnFFQ005UGhaRTdJaXdlMjVrSTZ0NGhoSzVIT1FMZFQw?=
 =?utf-8?Q?faAFknEAHabyTecChQ/ww86Jb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea07818a-6aad-4fdb-fd00-08dc5d951053
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:43:18.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbfBVW+M6bIG8xcl3F1M1s5AYC++mUDBtc58dK7XJT/zCzn87N8fn3g+KEawKifH8RoV+ZLsPtBZT/mKqcregg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com



On 16/04/2024 5:59 am, Borislav Petkov wrote:
> On Thu, Apr 11, 2024 at 09:54:13AM +1200, Huang, Kai wrote:
>> Could you be more specific?
>>
>> I was following Boris's suggestion to summerize all the discussion around
>> the "unconditional WBINVD" issue.
>>
>> https://lore.kernel.org/linux-kernel/20240228110207.GCZd8Sr8mXHA2KTiLz@fat_crate.local/
>>
>> I can try to improve if I can know specifically what should be trimmed down.
> 
> No, keep it this way. I've yet to see someone complaining from too
> verbose commit message while doing git archeology.
> 
> If it is too verbose to a reader, then that reader can jump over the
> paragraphs.
> 

Yeah as replied to Kirill I am keeping it.  Thanks for the feedback.

