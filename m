Return-Path: <linux-kernel+bounces-147752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544CD8A7898
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE141F2291D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D013AD0E;
	Tue, 16 Apr 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgS9XE+e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94013A898;
	Tue, 16 Apr 2024 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310196; cv=fail; b=BT7Li2MkxTUv8WFFEtHTREQEXCEmp4iEgjA+q2S/vy4KDfGeaJbsopyTBHwNOq+9fGGXPHl7zO9T4bINXFV0E6stSvwIm6QCfdi9rljq4mwRaGcAZz8yxyjLPvlA1BLE7n5V+UYX3UfEdwQXKA9N2sAEuYRCKIjkDffpMdZ8epc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310196; c=relaxed/simple;
	bh=HnQiCeEjQTNFaHU8B8Fhsy8WS0/JRyVNbWof6XA3wHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCn+bKus+dIBj323+8VmxfxLXG/UXwoZ2mMych8PJ7OtomBJpcEFfQztLptSgt6aY5sFtOedNynebWMzRlcTzk28IQhDJyZ/R4jUUFv2EcjDCUpiSijzjM+Bm/MKNGdhl7DcfFK1cLuR6dXfjK+fb0AJugMj2JikBrdxC6Uuvvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgS9XE+e; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713310195; x=1744846195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HnQiCeEjQTNFaHU8B8Fhsy8WS0/JRyVNbWof6XA3wHM=;
  b=FgS9XE+el+qvkOymdKntlePMoCXCCyOS06HU1GZwU5GDMvKIUXN5Coq3
   V1/3RbLBo1InaAHyWFZvYSwGg2b1UALK4mpsXZvfYASx0t7l3DN86qSTC
   4sZ6OqFaRnd3KY0fn2pc48KlppEOEJvs7+XB3KJGmXhbhLSw+nGQsNDaI
   /LsjQroEcL8EMdrveQPPoa/m+hekSP/9M4rOOfw7bocwnMpRVned3Xjos
   HeZUYkFjAHw7AmmSrws9b0AokL0GKxKPnCGK/VSBCs/cR4WLEbCTizxSY
   j2NF536gNi2hwKN75w5Rjw0Oy60PEg8MuVJ0Dfev92f04IqpnPoNet4qr
   g==;
X-CSE-ConnectionGUID: GjF1JM6ZS0CpnWth79m+RA==
X-CSE-MsgGUID: /NNx+QFGS9i2p6UBfLFrIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19488222"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19488222"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:29:55 -0700
X-CSE-ConnectionGUID: QVzhDlDrSmOK5DXp+HqqEw==
X-CSE-MsgGUID: dIuUrXJbQYOTyNyKTaI25g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22427381"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 16:29:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:29:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 16:29:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 16:29:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjhB1urQUqWtSutxKReGFn3luL4/DzZRWSuZ7oSMw3axNS2a9bHJQuWtTLkH9XcGm5OUvekwPXackc4Q9BFfMO+nk+w4+s+yHRWMG1iSpWvMFfGefx3ke7WBacSO5jCdkpSkzDI1Eh9Cx2EddxoeChUc3xuwRzJFlcbw7cXJBOlmvPOYkucoIL3AjdAV7wEghvbw41XcbWPoEda6woo1SXIfIX7VgVamI1bvrOC/f7/oWJuLW0mnAbib0llQjl42N9QbxxDXqVhonXl6m2mn3pgigBBB1UBTS3BgkzmMvIZwcul/hC9naRsdOiQ0AJspD+7QZ/PJvqXOpmbLza/OvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBiAe99LWde7tNTzlIJQuvuAEQ7XAKVq/C0vZZSagU0=;
 b=Wz8MuXxbaXyhUiHPlTOGp+8P9M5jb5OVUkt2PUUuDrUZqELXfj93UpVr+2rCC9U33Xaa4/b3KcetMH8zdnL2naJCoU1EjFDTMudyjfhwqgWJt6fjovoNqngoBMkxLGNVSrWG+P39EYDBF4XBIZ+OitEXcw78fREoEcXBBLfYwrodRDccH2OBoTn+BDJt3Y4Of2JglysHH3q91zfHSGg9H/5Mz4d97oli90vKd2Gb3FZAKf3DxVz9ub80c4m9fc9HgQyhrkHEo8FNS0/6SqA83RX0dPuOp5WvZgral6SImFzIIBfBaicygdWasgKgxn9Eso07jT0n+YKObWvEzoOy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH8PR11MB6730.namprd11.prod.outlook.com (2603:10b6:510:1c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Tue, 16 Apr
 2024 23:29:52 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38%5]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 23:29:52 +0000
Message-ID: <29daff1f-b5da-42bb-a70d-dfc649e22f74@intel.com>
Date: Tue, 16 Apr 2024 16:29:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 54/74] x86/cpu/vfm: Update
 drivers/platform/x86/intel/ifs/core.c
To: Tony Luck <tony.luck@intel.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Ashok Raj <ashok.raj@intel.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212223.9681-1-tony.luck@intel.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <20240416212223.9681-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH8PR11MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 5332c19f-bceb-44ab-7600-08dc5e6d1d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiyepKF/ozJ4G8ZihOEgG4otPwaHOyEMnRiM+Ls8GJdv3v32IJPEHz+gA9Qouyxaz1z1bSRm2sGfq5lQW5rxxd2UAY173/HLjIuojQpCCnHO4qXX5dQiFvw/GHeHEBd1JZbKftKGwrHIJ5YPqO+jZ55heberbrE6BbEwCL36Uhkf263tt/H3hZKlpzRimQLOe/+8BcsNdJC3nNS1AZAb5Mz6XDYFy6g5wpv1BJHKy9FSkjnKG9rV5H6ahzn5ZP19p6FQEzNuex1ZlFbFcS9jHpIJOvF8PXsmQHZVWriPmEi7Lnsvnvq7J9hHrJU9tiAEcyLVKcif4tEJSycRmo8UYchDacvbMnQEGy1r/FZ4BbfaIW5Zsy1OiKcQvw3xgsUszE99vs0iTCZpfdWDH+8V2/oejmzjkIrs2PuV5qB8SsryP9soXrdp0yx9n1HxCsp9yTU5sqrzAkkP8ni8gS8DunGewiuQ0MVPH/HCK0XLo5D7LKDzlzQConEcz9gWDs5RMiT/Hemaml0gYm97aEPwHce1669CPtKuGSPPOqfxtQ6G0jRleG6JlkRtfFOjF1v2jcLjOh9v42zdeDqMyvXJ4m9+Z2B+ME8xfbSQa82SCm7HIDbcTeNpaosm2c3w7/miwZ4olJplWML3TrNLVQWVSdDBPVQbsj0vc9S20rlhpCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjdxdXBlTG1JVnkyeTVxWW1DeUxoZTVKamZFQUQvaG9ySC9mT2UzcTQ5V21j?=
 =?utf-8?B?a0ZyK1QyTmgyNWd6bVNKUmZCeGFheHVtSFRQQm1YOHYrb00yeWkwWC9JVzF4?=
 =?utf-8?B?ekZDeDUxM1l1Y2g1WlZYZmlDdWVaTGd5VWlmWVFFcnphT2t3UXVkR0FIR3NS?=
 =?utf-8?B?ZWx4RFFmUnlCRFdqbC9MT2NIRndtdFBRNVdrbEI1ZSt5YUZoRFhwcC9qeVpY?=
 =?utf-8?B?eDhHUjBNQTdxSVZkdURKNXZLSHBIZ0JFZ1JBMTNHQ24xcCtVRnp4QUhrUTdN?=
 =?utf-8?B?ZkhWRTE0QTRIV2FqYzJ0ZUsxR1Jka2hkY2ptRElUSDQwL21HaHlmRUhhRkhT?=
 =?utf-8?B?VUszR1pPY0RWYjl5bkpPUnlTMW9kY2NoYmVUL2FUWDN5OXp3cXlYVkloelAy?=
 =?utf-8?B?SHQ0RTlMZGZpcmhucjVTc1dsWkN5RkN0eEQrZTVuY0tQRlpGMlUvdVQ0eVJP?=
 =?utf-8?B?UmJ6RTk2OEdUN21mVE9mVW9sVTZCdVQ1U3FiYk42TllZa21rMW5tWDUwakty?=
 =?utf-8?B?ZHoyNEFaOFZNYlZYVVJiUDBkdTc1dE1JcnlWTThGaXBmMVF6S1psdGp6VmJ3?=
 =?utf-8?B?NnFST3hIN0IzSXBGZ2krQ2MxNVEraWU1TGd4cG9hbGtpbW5wc0lXcmRKM0lY?=
 =?utf-8?B?emx0TWU4a3NTVm1uSlNXeEZtTld4dEdsMlpNL1Q4Zi9rUFEya1QxSjExWXBR?=
 =?utf-8?B?cmVsNmFQaHpkNElFMkJLUWhTL0VVblJKS08xNys0WFJ3azBvWkxubi9Tckxy?=
 =?utf-8?B?aHRhSEkzN0k5SjZEeXpldVN0M2FtOUxzWEJQUjZFNExDbHI1K3VJaWYramdK?=
 =?utf-8?B?bDNkQzhBSzFBbEZlR3VobEpKT3RWUkZMWGV6bml0eGF2ZlRpWEg0ZXNLQnZk?=
 =?utf-8?B?elFXajZsRjdGS0wwd3ZzUjduUmpMRmtMd3lNdm5KaFFxVCs1TURGUkRhT3lD?=
 =?utf-8?B?MVhmUGR3bHZiaEpFaHhJV0duRTI1eVlFanBuWHZuS3pNNjFjb1NadTV2Yytq?=
 =?utf-8?B?dlA3NDQ1bUdvY1dTSExBWDRXQnQzeW8xSWJaZzNaWjBhMk9UUE9mVFFJREhH?=
 =?utf-8?B?SlJ3U2c3bDQ2cXUwNVdId2JQRGhRK1pQQjJxSHdqajY4S0RDRTdzWHNJMkQ5?=
 =?utf-8?B?MzNxL3V0OFpQY2ZabVJqK0JvYjZjS0lqVlJvQjFwTzZyZW82ODVCZ09Zalp1?=
 =?utf-8?B?VlJ0MnNJUCtOeVpGNzVsdE4xUFU4SkpTY1ZWekxEZDJPeVNRTms2c2U3UWlC?=
 =?utf-8?B?clRwT1gwRDVER0NORHY3N2thS1dwMU03S2YyOE03WmtpQTJ6b21NSGMzVjlB?=
 =?utf-8?B?anM0cTNFaHNrTEJCVVk2L2ZadWZBSDZCeC94UnRidmZCNkRjbjNQaEJHT3Nw?=
 =?utf-8?B?cXQyeEptd0dDa0tlckxvZTZXeWFlSGhneS81Q2laRHYrTTRPUUFrWDRQbkx4?=
 =?utf-8?B?ZXNwdGNnbjYwWGFlMWw4RTVUU1J4NXZ2MFhxLzZkVUxyQ3hEcWpiRTdFWWk1?=
 =?utf-8?B?MnVMNERGQjZBNmJhVktLSEhHWkgvT01hclBzQks0Zkh2N0xQNWRXZkx4bHda?=
 =?utf-8?B?WDRqVEd5SCtSVXVWeFIyRnFEcEtSdEFKbk1WS3JYZ3dsRnhLUVR3d2N1Q2F1?=
 =?utf-8?B?SitJaWxvaEZDc2ZsMDNyK2dlWEJJWExPUCtjYkl3RU5SSk1FK1dtd2tXd01l?=
 =?utf-8?B?WkQzN2ZZUVBQamZrM1U1eGRLb3EwWXVWM2VndmQwUmVWVTZ6aFQ5U0xBcTBr?=
 =?utf-8?B?T3E1My9KNitaSWh3b2JxOTJZMHU2QU04L0xvT0drWlZtd2lRZVp5bE9PT1BW?=
 =?utf-8?B?TkNXcXFmMW5mZFRLV29pS1QvSHBQQ2lJN2lOSHpIaWpoQU9IQ3B2ME9uV3J5?=
 =?utf-8?B?WWVxcGNiQncybWVRU0g4WUFrVTNFK1JYN1NvZHRjVjI4LzVpVUNSdHBhcEkr?=
 =?utf-8?B?Q1pSNmY3clBMRDVMUG9yaG1MS0dkOFRyWWVzNE9UYWthOGZpMFdnRkRFeVY2?=
 =?utf-8?B?d2hHL0ZWZ0h1UG5oRTd2cFpZNTJCZG03OXlZUnhadytaYlU2RFg2Zmhwc1BO?=
 =?utf-8?B?Q2doN3d0aWRRNmdaUENrbXpYa3JVbXdaU1BjakpyNmk1ekZJeS9hNTBkbXZ2?=
 =?utf-8?B?cUJqakNrdHNqdnY3T1BkV2h1SG5yWVRDQmV6TU9NMk5GaUUxejFhTy9QVG9h?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5332c19f-bceb-44ab-7600-08dc5e6d1d73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 23:29:51.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNzIUqWd8VcXRu+9VzaIwgcfH0853Pvs7ytm5cnlDVG6QODt0Te7FcRQNQfxWoLvHckJ3ox+4/NyLT7GKUJByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6730
X-OriginatorOrg: intel.com



On 4/16/2024 2:22 PM, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/core.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 7b11198d85a1..33412a584836 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -11,16 +11,15 @@
>  
>  #include "ifs.h"
>  
> -#define X86_MATCH(model, array_gen)				\
> -	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
> -		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, array_gen)
> +#define X86_MATCH(vfm, array_gen)				\
> +	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_CORE_CAPABILITIES, array_gen)
>  
>  static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> -	X86_MATCH(SAPPHIRERAPIDS_X, ARRAY_GEN0),
> -	X86_MATCH(EMERALDRAPIDS_X, ARRAY_GEN0),
> -	X86_MATCH(GRANITERAPIDS_X, ARRAY_GEN0),
> -	X86_MATCH(GRANITERAPIDS_D, ARRAY_GEN0),
> -	X86_MATCH(ATOM_CRESTMONT_X, ARRAY_GEN1),
> +	X86_MATCH(INTEL_SAPPHIRERAPIDS_X, ARRAY_GEN0),
> +	X86_MATCH(INTEL_EMERALDRAPIDS_X, ARRAY_GEN0),
> +	X86_MATCH(INTEL_GRANITERAPIDS_X, ARRAY_GEN0),
> +	X86_MATCH(INTEL_GRANITERAPIDS_D, ARRAY_GEN0),
> +	X86_MATCH(INTEL_ATOM_CRESTMONT_X, ARRAY_GEN1),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);

Looks good to me:

Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>


Jithu

