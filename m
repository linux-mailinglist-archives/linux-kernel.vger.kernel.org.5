Return-Path: <linux-kernel+bounces-166950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC88BA263
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31F51C219EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272118411A;
	Thu,  2 May 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbrjQ17a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744B1836CB;
	Thu,  2 May 2024 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685735; cv=fail; b=rr6ifLaEyobggCiN0lWCTCym8J3G6XBtfQBf8xeYMldakSJ/e7x8X/qV58bilBoiJcwxnjp7WW6X/1Tqxm0AB4LmdwiteOMoL/TswiUtqebTCtABMlFouSR7M909ICiFfQ4yQWaD4oFRpycLT6yJv1Y1cIyxEByt0fLWanMDw4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685735; c=relaxed/simple;
	bh=UIia+ToP4fEbgQG8oXkTMioMPYWIs88iKbvRL5TJogo=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4uuGCoDUMFwa+wWye8U0z19UD9kPKQjYNfJyb2zmYAXClARB+cXroTi7w2d8kiBBOdMvGmcbF3+PxfM/bue68ElGeEQOYSbVXhCSEi9CkgMWHlSUHHFwqfO7tDDL5Hvm/GmD6ALjKSL3nQHt4QpHmSEe25Wc17PQ+gE7yhnmao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbrjQ17a; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714685734; x=1746221734;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UIia+ToP4fEbgQG8oXkTMioMPYWIs88iKbvRL5TJogo=;
  b=YbrjQ17aNeyUUlTFuDGbHgSNzthOZTYM0ZH+25cPNlhem4a/msTavgcS
   TmetvkuuKV0455Q6aFtAuwDU8V3JKzCQ5LHQlZ0mZzEp2845xs+mAjLQ8
   VUg7VCwZ/lm88LuCyn0iXxpvBqhPzxhgkdDOxas8BxPp0yaBgjIAhfGw3
   R1xkKdCYLTe388j1xg3MllVEQKtDBAI7IH1va/1i4PJEGaTPEDesfxHUc
   l6H4Lt79/LgQosLFYUONR7/B1+qo7rLFc+w1EX5e2hzLNvJXsr0l9tXsI
   dHYro7iQq6K55YVeubzcOjgMWnaWuRTViAVv0FwOr3Saf6bgAlw45p0VD
   Q==;
X-CSE-ConnectionGUID: ZrpBrBGyTxi+fAxH0JzOow==
X-CSE-MsgGUID: EB/Fz/myTPe0z0iLgntKYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10607069"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10607069"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 14:35:33 -0700
X-CSE-ConnectionGUID: 8pmQ/7f0QHmELy4W0+4ldg==
X-CSE-MsgGUID: 9nI9+u5xTMixOZfEOHcM7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27278685"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 14:35:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 14:35:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 14:35:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 14:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6sNRHna5cvgEyBsl4YMds+Cmm5GG3zL3KsDxcDgTdClXCI99TJ5etor6CuLyDOgMt9m7gL85a1LQC2cEV2Io+WXaERat6oSQLM1zwl033nWnn0zVhTKqA6XixlQYWrxBUBJIXh9WnnG/zNNDhkSI6NSVR/+EeZ4COVQDMLfTdTJDW029NjlcqvGHXYq5BN6nAF5A8wVytX+Z8agzXUzjaqceaS+UAQFdCpBitKvX5oorENcvUHTwJu1xGJ4j1WDajMb0EMk2A3IqV+eCGPoI358zaeUP215q4k2uJp+Yr4GKdWh4JuUgmtEgfQmyyAjdcDZDKxNseJf1M2zKFbOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuEZdGySnhU0ecLpLaaSWGOlERd/miEvIvbgO0mpRn4=;
 b=cirLO+VcmcZhHFwcczg6IHku6Qckwd+NczAfDyemM6zatJIpLxf1MDEkSIC4/0E5FrE/q7toPSwuvDWx45sKuHK+aZ9NS4Np3gauBn3C8DdHUJi0cpYWpxFEqR815RlfwkVLG9OyV1aPHmQEHmiQeyKy/zEcrY4+Yh8brb1Gsa8TdMfPM1nHO+3em9+U0Gly2rMtFB0j2LAvbfLypyuig/olV1OA3KGHZkWrLsA0ocVyuSqW3MBy+Osxu9Eb44A8Ej2vaIBZsKUsBAMUt2qGvGanqPVmiMZ6aIPwhZi5Z0qkZV9Sw8X94sGfIB3IQGHzUbdQ83cF3XJj7SVLSfeiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 21:35:28 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 21:35:28 +0000
Message-ID: <4dd19ba2-d247-46ae-b860-53d3403d4ee8@intel.com>
Date: Thu, 2 May 2024 14:35:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/fpu: Extend kernel_fpu_begin_mask() for the
 In-Field Scan driver
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>,
	<ashok.raj@intel.com>, <jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <2ea9e144-7d94-4dee-b642-657306a0f9b3@intel.com>
Content-Language: en-US
In-Reply-To: <2ea9e144-7d94-4dee-b642-657306a0f9b3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|CY8PR11MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2caaa3-fec3-488e-b947-08dc6aefc910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGRTNy9mM3JOWFJERFZUcFZRYkNDQnNIMGFBNzUwRGZPVVpRemhha1IvVUcz?=
 =?utf-8?B?VkNIeW9TVjY5SVVUWjN4cUJGUUs3Uno1UTlaYm1KUWxhZlIvbzZzL1RpdFV5?=
 =?utf-8?B?RHZackZNa3JIVTBIdDJ6MEcwNllULzdoMXkvd1dJdDlWblorcThXVUlsZHJl?=
 =?utf-8?B?TEhOcG04WXJwUkExM3NzVVJMWXpzemdYSWV5RlpyVWRNcnNDbGVkUEZpQWpt?=
 =?utf-8?B?SXJna0RHY2o1MjdzeW1ONnNNQUZ3cVVhT2ZuNTU3RHpBb1I2eXpVWGkybE5i?=
 =?utf-8?B?Q2x6T0NZR0RENUE4UldZSmtYUmdWdkdwM0NzVVdtaUtLZTl0V2YrRnB4YTVs?=
 =?utf-8?B?OWx6UzRjUnFXQ2xGWXJMK0NWc1NBUlBPdlF4L3cyYjIyYVlsZlgrbHdmNVRi?=
 =?utf-8?B?MzRmMXU5Z24rT2hRMUMvUEpmTERMWDNrdk1YNjFhemdDZ01BRHB2a0djSGJl?=
 =?utf-8?B?cU9Qc3FiSUNSSHFIVE5mRVFYM2FBalNYSFYrSjBCczRQQ3h1RWhKdndTVDVk?=
 =?utf-8?B?K0Zvc3ZEbjhCVzQzdVBZcHd4MzN6UUx1QXZHNTBhbUthWmhPUVdCRXpHM1Zo?=
 =?utf-8?B?YTFyeWw4LzMyYWl6YkhWMmpBS0tLWTAvQXhnblI1M3ZHaUZlUzZhR01DT1NY?=
 =?utf-8?B?NTB1OGVyVjFVanhoV3hYZGlmR0lpaGtGZUhrV2pEOXNKTW10Uy9keDZ5Z2pn?=
 =?utf-8?B?U3VZT1lFTmQzWmZCTlpEZ1lqbjNxcmlZUXB1MnlLRGlDMWx4U094VDZUdXJM?=
 =?utf-8?B?ZXBVUEdaeHVRMmRXTXhxdDMyRkczdVIza0tPY1gzR1Vvbm14czdtcktpVkZX?=
 =?utf-8?B?aEQ1K2tvVHl2K1hLajlCaTdjeVNpbnUrWXBBS3Z3OGRlOGJyNFFzUTNBWHZu?=
 =?utf-8?B?S2REd1Z1ZTVaejF0WHFVNWVQVTRrY1I4VEcvNXpuQmdnaFdEd3I1NEhmUlRy?=
 =?utf-8?B?eEFGc21oMG40Qk11aDZ5NG9VWUNuMlNWQkhBWWFvNHRDRVhJNzRJMi93d2ZS?=
 =?utf-8?B?THQ2U1BIR1NIZkpFUUM0Y2k3OEdNUlE3U2ZZOHBDQUR4b2lURXlSODN5cHJp?=
 =?utf-8?B?WUxhZXE0aFo1OGp0MEhIZFBlMkxTSHFmanRMNCtqY0tGU0s0eXk1SFZyVU55?=
 =?utf-8?B?V1JSQytsSXl4bngvaHBXWW5jWHh3V3RDd2puL3U3NlIrM1FZckNubG5NN0VZ?=
 =?utf-8?B?TTZoUU9XeVVFMTdiY1R4SzNYaHB3SWpyR0lYKzV1cWN6TUx5MSs0L1BPMUpL?=
 =?utf-8?B?VTlaeHkxSXVyYXovZVY2RWVwQ3J4WUt4TWlQb0FmL29pMitQcGZPZHQxeDdk?=
 =?utf-8?B?UkFrMFZNaFdhVUxZNXNldWFyZm5IZlloVnhKOFFiQlRKY2U3bFpyaUVCY3RK?=
 =?utf-8?B?Q1RITDlXOTFMbG1mVUcwKzk0ZFcrUC9Wbm02d2Q3RHM5RndXMENWWXlWZCtn?=
 =?utf-8?B?SzhRZUVDVG5aZ1RaclBzK01HSTRDVVhGSURtWW5CblBsZytCNEE1TFFvTFF2?=
 =?utf-8?B?ZnhnQ1U4bE50UEMzaTZZSE5sdVFCZlRIbldwZytuckVXSjBvVE43N3NkVEIz?=
 =?utf-8?B?cmRQZkF2TFlGNHcvTHpZdW15RS81Mk9yMDB2NGRYWnRpZnQ0eFZkWXdCVHEz?=
 =?utf-8?B?NFd3bTdqV3dOeEhFVkJFKzdvU2pVWjhiVkdjWVV5ekVUTE13d2U5QmJkWXdD?=
 =?utf-8?B?cDVWeGhWTEhkOXFIN0JacHJYMGVCODk3bEMweUVkYTlwTUxLQ3FEalRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1aTndSL0J3MEEyNnZ2bTBNb29KUlZBZVpqRlk1bVRqRXp2R0Npa05rUFov?=
 =?utf-8?B?MVBoa2dDOGNZMDZOeSs4aUFML1AxWjQvSkFYNTYrUG9wQnJPRGdQU3NVUTZa?=
 =?utf-8?B?RTYrL1BNTTF4MGw0K3BWNXBaZWFhdnNVTWFHazhldkZrOUhudUd6RkQyMkZr?=
 =?utf-8?B?YndiUWc0UVVyTmVYOTlDVXo1UGUrRnUrYmVUUlY3R0pRdmdCaE5wRStlWjIv?=
 =?utf-8?B?c0FJcUp0MzlSNVpraGRzb2tXWkNhZU5pSm9CTVBxeDl5QzAvU0RDS2FVbkNm?=
 =?utf-8?B?NCtraUloL3lWRjBRWGpLMm5QVXJkTUwxNlVUZHRUSkVSd1RHVWp2Qm10QVBQ?=
 =?utf-8?B?R2s4Q1VOVndsVllybHlZWWhTRVNhakRHN1NIVk9PRTlnYkEvRzNueHgwa1d1?=
 =?utf-8?B?dG1kbW5WVUhUMEhJL3N2cXpxY1FER3BhL1Z3RGVYZmNzNnkrcytjbXpFSU1x?=
 =?utf-8?B?bmQ3RXFHY1hmU1hhb0ZmV21vM0xaQlB2Yml1T3B0eklXKzgvMzgvSzhlS1Rz?=
 =?utf-8?B?c0w1d3ViV2hKU3RpeGkzUk5xQ2thT0pWSVdNNmEwTDZmVC9xU0F6NVJzcGk4?=
 =?utf-8?B?YWdsTHRTOHNjcXBpWDhENUZnYjdJM0hTSGVXNTExR0kzRlovcVJJcEE3VHlK?=
 =?utf-8?B?dXVwZkpWWldpMlVCUmUvYU5BTDFHeUNrNmkrR1UySUtpeGhHNWJ2c21LazdB?=
 =?utf-8?B?TWIvcXNPN2NBU0VSN0toNmNBK2o4dkdFdWprd3B2RjFYeHU0UXg1WE14eSth?=
 =?utf-8?B?UE5RNDJXUkhQcEtRcU5vTFU5dkwvOWJYMG5QSmMvRnpSZkVtNDJtM1RlLzVz?=
 =?utf-8?B?YktXYXJpM20zVGc2cWRSa1kyK0N1dUxYaXkrUkZ6OTNERjk0OFZwaTJYRFNM?=
 =?utf-8?B?YTVtcXkxTG4xVnBXbnlIQmU2T1pYQ0E3NG9rdFE2NWNrYmx6S0hKdndHUkZN?=
 =?utf-8?B?WVVySzVaNGNoamlSZ2JqNGlwY1RWSkNoVnVITG4rNi80SUt3YnVlVmorK1JD?=
 =?utf-8?B?UEZWSjZUWGU4YzhpK2UyVlBTbW5LY3o4ZG1zV3lIbmhmQ2dEMFhJU0Mwb0E2?=
 =?utf-8?B?Ym9EVis3WGphQTZJYURubm9ZU2JvUVNzeUtmd2tsdll1LzIzb0pBQ1A4Wnc5?=
 =?utf-8?B?MXNFMFpuVTM0dWhWYUpvQlYraThDVmlidk9XamF3Y3RhTnZxVVRRZ2ZzMURv?=
 =?utf-8?B?R2FDb3ViM2FXbUlkaGpBVFpxbEthbjBrczJzdy9Hc2F4WmlMUmdaTTlpVGNG?=
 =?utf-8?B?eVFRZm05djJYQzBnV1k5eHJLWVl5czYwczFTWVNHaFVLQVRWRmNnVW15blA5?=
 =?utf-8?B?cSs4L1dKRkxoZTdTVjY3YTZ0S1U4NXhFTzZTeThGUzRta3ZOdUhhT1B4V05x?=
 =?utf-8?B?Rm5TNnU4UzlKQ3pYanhSTWF6cEZLZ25wNXNCQlo5YUJGMk5MR3pQZVBBRU8x?=
 =?utf-8?B?Sng5ajF1Zzh3bTViZzBiNE9PNEsyMmFEVk1SWnpSMTlIbHc5M0I1M29qbXla?=
 =?utf-8?B?cm9HYlRBMkR5UEZnVU5ZVlN4ajEyQkdVVmtYalBGTEtxZFlhUWlmRG9QRXcv?=
 =?utf-8?B?M1NsZFNxWnhlM2JpeU9tRmRxL05qUGNsSDJraVdubk1BTUtmQWw2L3JJSXNY?=
 =?utf-8?B?dlo0SjcwdU95Q1ZRWWZrTHBOOS9CbkJJdnJiaGw1V0NGVzN0N2hFTllaY0ho?=
 =?utf-8?B?cFlVaXBYa2xYeU1WanJMc3RaQkRiWVdaTkZRcm5ncnVnaEg4VXU5dk00UUxZ?=
 =?utf-8?B?bkVRY2xOdURPcU84VEFJZVJhZXhONjB0dFM0WkJHbFRpRWRNUlNjYUtUV2pn?=
 =?utf-8?B?RUFvUHlrY1hrK3FEaHBQWWV3QnM5QzdhQ2ZrakxXblY3MXU0eGlOMFBtMDJp?=
 =?utf-8?B?VHI4UkdMdVFhbXVaSUVRYndKVFdlakFhdGxLenQrTW1zOHp2SndsbXZsV2FF?=
 =?utf-8?B?b00wU09XMGNhSDJMTC9XZmlJWDMyVFRFVXlOTjA3Z2k5Zys5QXVDd1ZoSmFW?=
 =?utf-8?B?cnNCOHFIZUlDMUdqSDVVc2VGVm1CTXlxVUMxYWlQRjJuNTEwMnZYTmZtUng5?=
 =?utf-8?B?TXdxTzB6MzU1MGpuRXlvbmNMUWVmeDF4b3lGWGxGbEo1ejRUbXAvSlY3MUJ2?=
 =?utf-8?B?MUJHa0l6eFM1VEhVV3N1Wm9pQTVOMzlOanZtYWJQOXMyR2xJbWFISnQ1b0lx?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2caaa3-fec3-488e-b947-08dc6aefc910
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 21:35:28.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRJrO0X+SnE/scKD6xJzRVxQ3krmRpgL1tgxgBOzcS0iNV+Vmibcm4V5nBVUYPgGd0F/VTWlKO/Qbm6Bo3rQd9fQXuphfjMxBjdA621HhKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-OriginatorOrg: intel.com

On 5/2/2024 1:52 PM, Chang S. Bae wrote:
> 
> This brief mention may prompt questions about why the hardware must 
> refuse to run the test under these conditions. Because this is part of 
> its internal, we'd go back to folks who wrote this test and will grab 
> their write-up to provide the logic behind this requirement.

Okay, I got the write-up sooner than expected:

In-Field Scan (IFS) is a destructive test meaning that it will overwrite 
the existing state to achieve the goal of testing the logic. IFS must 
ensure that it is able to return the CPU back to the OS in the same 
architectural state as it was prior to IFS start. To do this 
architectural state (register state visible to the OS) is saved in a 
cache [*]. The cache has a limited size. When AMX is in use, the state 
of the AMX logic that needs to be saved is too large to be accommodated 
in the cache. Therefore OS must clear the AMX logic from being in use 
prior to IFS start.

[*] This cache is software-inaccessible space.

Thanks,
Chang

