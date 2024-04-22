Return-Path: <linux-kernel+bounces-152904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA678AC5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC12D1F2123C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9A34E1D5;
	Mon, 22 Apr 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoqiNFry"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F04CDEC;
	Mon, 22 Apr 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772182; cv=fail; b=i8EdY6h0nH8YWbbyz3q0zbQqnFoV4ZcsRVU2jNDUd8MvFBF4FubMASl7r4nk1c30UcS3/SSlNW/ZCfRpBXPBAAIruMiCqTCdiuOHKu/ZxQC0LHLEGg/HHDR0BvSNQ3VTJjE/E6eELKbJaLn81yzeGQA3dVKFUbfPoaOLKq6RUS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772182; c=relaxed/simple;
	bh=h4duz9S+7HidE2+0/QK7kg7PFJlF7KdgFXVo3Iyq9/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=peM/OVtfS/SPRKtFYsswWkqkuFeofV+CCm1RQlcCkX/ZHMTrRFHmxL8VCwAG6KyeNJ3E0ZbZydenN0AlEE1putxkuFyOXo8ZuaMeuV/sJRVnAOn3UJ5my+KYBfiQMuL6x1R2fxrKBkj5MqIOSDTiAfp5vIGlOqKct8FU8aNfTZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoqiNFry; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713772181; x=1745308181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h4duz9S+7HidE2+0/QK7kg7PFJlF7KdgFXVo3Iyq9/s=;
  b=SoqiNFryckq1sNe9B2b1KYttOtlE7+nb8TeCMvE0YDQE45uUoeDno+o2
   ssDqr9sgPm7CVCnQin8Fi7MrKovwDEASzrI83wE155HcyTA8oN9e9ZKvf
   dy0FMqUIL5cyyLW960NvxhyJMHRY+U60cxP0xKyJCv8aDajGkO/Mz4VyO
   IXQ0p1zBjgbHPTTGyG2lgOMVFy6miT7VUSUHXZhTrN5RjZfXy1jNWn+RW
   tx3sp1Lz5d7HrauQcT0/1nkB4rG2YdxSAuwu1ELpntphcQemBjQ8bqbWp
   SDwMcBE467k3i7ixnSXsoP646g4QqpIYzKm84DqIUFp9PIZanxPm8d26y
   w==;
X-CSE-ConnectionGUID: 9TR6BKLzRW+Ang4D40m9pw==
X-CSE-MsgGUID: 3dBLQ39YTrCgVgnkG2KOTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="19849914"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="19849914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:49:40 -0700
X-CSE-ConnectionGUID: ZWQAf4iOQL+7SpLvUoeYDw==
X-CSE-MsgGUID: izdn5ezMSD6Xhx0DG+PcVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28604299"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 00:49:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:49:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:49:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 00:49:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 00:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp/h7Ynu69Hm9MbFr4JwiTVeSt02NzdiOKNdpF04AlQ3JRmOlPQLl9xHw3R6XJZl2Cl/y/wJ8XHNVWyhD7YbzGrf0JFUrb1GdiygnQeQWfFAoThaMJui4x1grn9K1ZHOlIlYbB/XDbcnDeaueygRkV1/+d0Jw4/on4UhxLNgMeBqfpKLs3RDP2Q+xivYI3WOm5Wju5hwfHJK/gwusA8IkPZ4LMPIe2Q4Vz9TGX7cd5ktd5uasdEWbwtBbgpp1XZyvRmvcmJAsVEITQpxHrmRT9USLVaEhNpGvOeNsycPnRfhNNeAEwGRlTmNWWxd9dJKm6LuPhWlTKdr2EUeYxDyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YngkY8mThQaWB1qrmIc/8TxPpnapGlFJP+z/dq5wXg=;
 b=DD37+nPi7gjD2PbE+F1bx9xsPEiSaHvtvm0au5nQ0vukvxmfJpi6KcXqpG4zDg6IWyEfB0Ykes/Y7xXwbfQTWFBTtUkE+Phts0tJfiJOmSiOzH46G2bqwOYtCHLaPvky3kFccK76zStZWoICap6mDg0/k6n93VjdFahpYBk0ErUiYd8eKvwutcmkbWMfUsL1QzdDijjVGr+xr6StQlHnDnLo0c8flGowbdB+1FmIotiL6bvOL4TarvUA5a1EzhlCZrB9UbFr2iORhcfLuqt/nByQomspO7lNGMCeGEKODos8WbMbBReZq9UryzNTsVjPriuMlR3aCEIjF+JDKbcoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 07:49:35 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 07:49:35 +0000
Message-ID: <05ce2bb1-46c2-48af-83c3-911f00f290d9@intel.com>
Date: Mon, 22 Apr 2024 00:49:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9a 10/14] x86/cpu/keylocker: Check Gather Data Sampling
 mitigation
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<ebiggers@kernel.org>, <luto@kernel.org>, <dave.hansen@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>, <x86@kernel.org>,
	<herbert@gondor.apana.org.au>, <ardb@kernel.org>, <elliott@hpe.com>,
	<dan.j.williams@intel.com>, <bernie.keany@intel.com>,
	<charishma1.gairuboyina@intel.com>, Dave Hansen <dave.hansen@intel.com>
References: <20240329065742.fc5of75e776y2g4b@desk>
 <20240407230432.912290-1-chang.seok.bae@intel.com>
 <20240419000113.2tjvyigx7nlyymrw@desk>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240419000113.2tjvyigx7nlyymrw@desk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: a032c475-ea4e-46f5-51ff-08dc62a0c11e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2dnMnpFYTRiUHpHWUhCOVE0SDNiTjkrSzFRa3hNeC9kRGZ4cWR3Nzdmd1hh?=
 =?utf-8?B?NXJuNGRMbmd2c1U1MThubDFrNHlMRWdnUjhTeXFDYm9IQXRjKytVUkQyK2Ru?=
 =?utf-8?B?ZkVaN1FaNEFUNi9lV1BtYmFveTNxaGlLdUI0a1lnL3NXbWNLcmhKdFNpUEVx?=
 =?utf-8?B?blQ0NmQ0LzBNMXFMMkpVODh6cFVBRHVHaXp2dDFLOFhYUmlPUUliVWhUOFFi?=
 =?utf-8?B?Yi9tbmpCeGcxZjdOTDNQM24yemV3MVE2OEJ0Qk9adTVST1NzMU1QV2dKU0Zv?=
 =?utf-8?B?OUhoZkdzcEw2WDRkYmJ3QzM4eUtDdXIvWmV3empKNG0wb2pHaUxjUzlZenJw?=
 =?utf-8?B?cUlSemlzR2VTbHpJY0VqbFpoTU1PMHJyMk1FeUtpcXhqTjRRWjR2T05pOGJk?=
 =?utf-8?B?TjYvRi9YNzNEU2lybllhL0h3SE5rU0E2a1pVblRncWg2bWhUVk1hZHc1c3RH?=
 =?utf-8?B?Q25qRVUwTlA5UUpMYWxXSzFRRmJvS2wrTmx3amxzL2MxZG1EWWlPcnh1c1ZS?=
 =?utf-8?B?Rit5TjV2Y2s3dHc3QW55QmRFUUg1bmlubUNkZnRidjZGMDlVaFRiRGo0K0R4?=
 =?utf-8?B?YThVemg1cFloOS9FNHBsdGFJdGhEamlucGVGVnNMU3pmL3ZGa1QxVGpBazRx?=
 =?utf-8?B?dE9ibzRRSGZ0UVdnTmFBb2FEQko4YzU1eWsyY2VxNmNIY01wRTBTNElqMzgw?=
 =?utf-8?B?L2RsTWQ4UWo3a2NvZzNrd3BwSnd6R0pKTythSmxhamgyYWJ5S3FxVmc1eG1a?=
 =?utf-8?B?enQ4RkQ2TW1meDl6ZHZrcmFQZGQwL2QrdFBpa2VYSnNXcnR1N0kyT1dXek9z?=
 =?utf-8?B?L1Q1bE1SdUpxNFNPVWl2L1RNbVp3RTJ1OTVxM3dZd2d6YkNNT0JnZC83WDVq?=
 =?utf-8?B?MGROTk5tdEpoR2pMMXlpKytZcXRuNHVtZFAzajF3ZGZIczB0d2w3cVYxQ1ht?=
 =?utf-8?B?L05IN2FaL25xV0RMR0FEd2lGeE52VGxiT295Q1U3RUgwY1dtN21DT0Z3cmo1?=
 =?utf-8?B?aFhnei80VHUxVVpQb2pkVWZDNUpuY2pTUCtlRXNOQ0xsVTJTVmJybWZYUFBu?=
 =?utf-8?B?MEhabUNWUkd4MXpVUlNqbVVzUUhJenFoVURQN0RId1REZGpuQWprWXUyRzRW?=
 =?utf-8?B?dm5WL2wzdUZSdld5YlE2NmRSbko3Smo1NDBLV0greTNSN0NHYnA1eGlaNWEv?=
 =?utf-8?B?TDIwSk4zald1N3JnU3BHdytYQ1ZRcWhGZGIxUEN6NjJwbEV5NkpXYzM5VjVC?=
 =?utf-8?B?ekVkM3hiRFdWemxYUk5aZWRMUHpYWWZ1VWMyYnFPN09wZ0wzSFcwcjJkREJ2?=
 =?utf-8?B?UVhxVjZabS9FZlRDVDVoRmNHdDhQQzVEaVJNOGRnQ0lJRnI1bVZFanFseGxx?=
 =?utf-8?B?SWg2OHhpYmFyZUd3aXNwRytscUFVNytUdmlOMSs1ZVpGZG00M2FEQmI5Q010?=
 =?utf-8?B?bi84TVgvR0liWkh6WlU1R1dZNHV1RysxWVExS1phM2FHQnU3cnlKdGxITjhH?=
 =?utf-8?B?ejhidk1ac2FtNC81ZG9TaHBxZnJodWhPcy81ZXRHei9uMHY2bzhlY1JYdWNx?=
 =?utf-8?B?djlzY1p4S1NjOWxtTHUwTGFFM0FnSjFCMzNpMWIvTTVFaEpKdnhOZFh3TGZv?=
 =?utf-8?B?RkdOTm1hSEFXWWV3U1hHUWVPSzMyQkFrOSthaHUwTy8wVFVOdnF4T0VhaGNJ?=
 =?utf-8?B?SEJoNDJmRUN3MitEU2xxd2xjYzdmMHJHb2s4NDFjVWRUNUxFM2Q2VG93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uzg0dVFxdnh3S3pxc1RYWUVHVVd3SlFlNmtROFBlYW5MRTlhTElGU3k2N3Rj?=
 =?utf-8?B?MVd0SWJ2UDlJQkFYNUl1dnpQOFFROWNxNFF2aVlxb3VKR3ZyNnhhVTlUVVY0?=
 =?utf-8?B?N1BIRTdIUlpGWDliYmZ1bis3Ny8zaTFMNlhKTTdOQTByekVhK21rdHZGanUv?=
 =?utf-8?B?RHlJczYxUS9vOTQzVFZZSE0yN2xMeU1MUkVWdm43TXh1VlcrTXR2L2Z1YW1h?=
 =?utf-8?B?dkNTTTdnQ3Vka1dobU1ZblpKcWRhMndaZ3o5TEhpTFJhOHhQVEltckJkWGZv?=
 =?utf-8?B?UkxQNlpWUmZYNmRVQ1c5WEFmOTJwTFJ3cjR0WTV1TVgvb2ZDelJKaWlvdHdT?=
 =?utf-8?B?ay9USnliTENVTjRxM2ZBRWRQUE1KeWR5UW5TcUlRTkpSUnZaK0J1U01ZejNV?=
 =?utf-8?B?dzBWcGRTNlhibHhrVytVZUo2WlMxN011c3NBRzQyN2N2VDg1eTlRQnBhNHNr?=
 =?utf-8?B?MDRHMHBNUkxnSWZyVkFSNnRHUXFDVzhGa2ZNS1k2YlBIcGVFUmdQN0FGbHVZ?=
 =?utf-8?B?M2xzRUxtWnY2VlZLTjg2TlVsVWdMVmtBZnNzc1IxZzdXQ1VCWUNyR1p6aEY2?=
 =?utf-8?B?SENuRm5kRXAzUGxFckEraS8xTy9BRE1tNUE1Qm9qMWxJUzNoU09ZM04yMGoz?=
 =?utf-8?B?K0hqeU5qUFdJQjlJRkU3N2JNa2ZKNkU3eXlnTGFtVlFVRUhWTWdoOEJCcVZv?=
 =?utf-8?B?YWRSS0FFSjRTL20zVXdTYlY0NVJyYkowU3czVEVEZjRGa090VFB6aFBBOXJm?=
 =?utf-8?B?NDE5dkkrMUROZWRNdlBzcFh2cllKNEp5anFHRERwTkdjRnM3QXpJZHM3YXlp?=
 =?utf-8?B?RkxiVzEwMTBMbzRXQzhIZVlJd3FCUG5CUDBVbDJQMXMzak9ZQmVOK3pCZk5F?=
 =?utf-8?B?a29odHE1MytJRXAxSVBCVTZLNmxxc1Z2YUZmZnY1aU5XQUV3em5wRmJ5SEY2?=
 =?utf-8?B?S1RncUhBMEJ0SUoybWw5eXplRXUxbGJBUUw4bXRuZ3ZYSzcwNnFBTDJ4OHJV?=
 =?utf-8?B?RzlIeVo3cE9PaHVUeFcwcnJaRmUzaytRMzE0Nm1BeWFacUdwZTV1YVN1UExN?=
 =?utf-8?B?QU5FRVkrZG1ZUElDVU5sc0VjM0xoQlpieVNCc2FETUhGL1c4VmR1VTBMK1VM?=
 =?utf-8?B?VStJbGE1ZXJHVE9jUFd2Y1JnWDc4Skt2SHlWZDVzSldUTC85bkhZUUFtd3FG?=
 =?utf-8?B?eE5HNkxCNkIzcVd0ZE5Ha24xQnRQc1Zlcmpyd29YMVVWWnB2WFFjNkVaRXVu?=
 =?utf-8?B?Qk9wclB0Zi9RbExCMDZzZzZwa2E0TVNQVm41eXAwdmFFZmpOV1dSY1ljNDBm?=
 =?utf-8?B?ajhaUEt4YWxLNGsvR0xUOUpQa3JLa2F2d1FaVWVWWm5JTTRQM0dQKzgwamV0?=
 =?utf-8?B?Ujh4MmRvLzNBcE96ZURQZEhJenRENjhMMGlSd1EzUllNYjl0czllUmhpSWMz?=
 =?utf-8?B?dDV3TWp2NGlMcUVkdk5wb3BtOFV3QUNlaU9lQWMzWm9TSjFSS05ldmljMmgr?=
 =?utf-8?B?TDJ4cEFXVXFZN2NJalJXeEFoOVFreXFtd1FCakZEV3plN2g2R0ErN0xWUDZZ?=
 =?utf-8?B?UG1BdUNaV2pCVEdsQ203ZlhhMkhBbStiTTAyV3hXdHlyZGhSOTQ3ZFBhM1NX?=
 =?utf-8?B?bzZKUDA5cHNjSk8zMXNPMTNqd1VsSU5VRGM1dTNNZVhKb2x6dW9oRENRaEZ2?=
 =?utf-8?B?akVGMllOZzg3N3ZiaWxmRFpCMGJkSmVZV2wrNXpDSWhOYlFibEcvQ2E5cFpv?=
 =?utf-8?B?UTRZVU1IeEsyQnR4c0FFS2QvTkowdnJJVmh5dTcrK080V3M3aEZNTndCclJ0?=
 =?utf-8?B?Z0duVzJibUlLU2pNbjBueWxyWGpEQUY1Vi82eHJZNFJTeDB1ekNMT2lSV0Zp?=
 =?utf-8?B?S3JTOEIwaDI3RGNadFRDdUgwSklqbG5VbnRDdUg0MVFDdnFoYTQxb3h1dlcr?=
 =?utf-8?B?Qzh4ZlZMbGxHaWFDQm1HY0kwVk1XUkhLUDEyLzdDU0t1QkFzVklIb0JENytv?=
 =?utf-8?B?ZVgwM0JaYlVhanNRRExjVjByS2VXdGk1U3p3d2lYYTJFcENkbGd2QVBDbXlC?=
 =?utf-8?B?RUFGc1dKZHRvZ0R5OWwxSVMrd0tXc2lhZXU5aStTdGJTeENuOWRweHVpMkRH?=
 =?utf-8?B?d2lneU02YXVwMXc4eFB6OUFWaStXYlMyKzlVUjFvcDFBUnp3Z1d6TVg2aEtV?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a032c475-ea4e-46f5-51ff-08dc62a0c11e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 07:49:35.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukSxAxHMSXtZE03M3okyP4KORiMxfECjNElvwsLfJhI4n5DmhnUWdAf6loUUwrZYlg3IoolVIXXDw/uZIfH8d3Xb/5h3TliGep9aSC9CjdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

On 4/18/2024 5:01 PM, Pawan Gupta wrote:
> 
> Repurposing gds_ucode_mitigated() to check for the locked state is
> adding a bit of a churn. We can introduce gds_mitigation_locked()
> instead.

I thought this option but I was less convinced about adding a new 
function for every new but slightly different check.

Thanks,
Chang

