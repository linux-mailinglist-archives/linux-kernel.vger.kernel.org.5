Return-Path: <linux-kernel+bounces-130689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BBA897BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E04BB29063
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FF6F524;
	Wed,  3 Apr 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuF9pacA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1D1E4A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183627; cv=fail; b=oJpxdhGk0nJf06OmAoNCs57Wt2q8d8gbvzwQ1UdaLGyiGTv8chnl0WTH3fLpNOxX+dndZVvnqmLG+NNURW+l1q3s7tgTolLnKHMkvrGmxT+e9LuQ9GAdndZF8IxZwC0N74W19N99ticiTNHGpijolX/VMpVS1ec3Ng0xX7fZ0wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183627; c=relaxed/simple;
	bh=4FlDI/e7W8EMvAq62W2rFBDRFKrc+t/v28cfT2v3usc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTcX4L+WrmW890DNmi7R+nF+9KdYy12nHknByHQ4ASa5OxSr4z6V5l++Ksv7vg9fCH62+bd44K3E8p5zlibXiVtOr2Jdztohdsj2tpqfvjcVcYASoUsC1M78r080dbAxyYaj4GGZUzCR9yChZbUHdKXRyx+GsX+OmMVmhReyNFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuF9pacA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712183626; x=1743719626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4FlDI/e7W8EMvAq62W2rFBDRFKrc+t/v28cfT2v3usc=;
  b=WuF9pacAua+LiKOny6hT2ywBHcw5w/O7GSZZAfd0lpq1eisIeYRBZBr+
   vcu5RazHyNZAHAH1zGSLCl3BE7lP0T8pOO61IXSYp1NeuyDKnaBzhhPMv
   UC1qJs/Zuzde4hDTte2UMYgWAZYPSnlevGmLr6CN3znw6INKkgGRR/A4Q
   1uMN6P9STAQMgNMDo7en4/kgzGZ9A2X0mw1m29zB12uKTyLRwLvHYF7f3
   rZ5JpgNn9KtXlSSJV7RxFNJT0+Vhlqvc59u5TN5RswKwUf0ZUZSL76JWV
   HCG4yUII2ltgl5tmm7OlZCFUdEtwWUBjAWxIqrOE7OmC72304EIo/xHMO
   A==;
X-CSE-ConnectionGUID: 5hCKNyBpSJ+BrteUiFIWoA==
X-CSE-MsgGUID: HsgE6tJlRO2hUxTtxp/B/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24903454"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="24903454"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 15:33:45 -0700
X-CSE-ConnectionGUID: GPcS0GRLT9WTqF7MDDRX+g==
X-CSE-MsgGUID: sI5qRllwQgu5ugm90iTiwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="49531984"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 15:33:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 15:33:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 15:33:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 15:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRvqf41Z2Mjdln69QtujXbWmS7iYgMSwl8AU259rO0os2/vRxGCcHd9IMUTpTNI8FEDuFLu+HP/DtSzJ9IOCQyfNk396xswMuytcohacHm2NyJ1PYjLps3w2nKnLjr0YrjxmKHSyVwPC1y6kOBFzbmrubzdYPiw+421PnOFCN/H8nRdfro7QNskEWUbBomPt2MeinFH2pcL3PF09evvMPn8tdmsR6NI/eKkrZOYlj/A/WtTuJhQFR3RFXeLy2OlyJtCLej0QRm6h6ra7gkC3Jl0a1c6kpOtK3mtwPp8/wgRkSNkVzbFaLOEkN3pwMF4/kCvMIEcN7bxPzHfCUrBFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyHSGpaIZAjhRWoyJArkKbqSJrXdQUQ4khLXt1YIUjI=;
 b=eySkvnhx8MlLK75GuVHsgS/IPICHCyaiD5ykAorpQM+KOcDEoCk2mmC5W+ubHCk4ChCQ4TKro3ZhzArw4iiyjlYoChvM0as61KrSbyijeHaushqiKWNvkdu12ZlqRgwVF1h22HA7Rdrr29RtpQs5q1w9OiBA8WwRNDY03R3hog4AeY8qSbetZA4fFwC7uwPbMy3OCLOb+15XsCseMvQTziZbDJ4N4tW2TaZYDF73EDJCjjmxugHyAtCK/2kL6IZvVX6LDsKSABrs472bUtubTja+0MgdRzzpdU5Ao2mIWcAMO1WMYtyE+vX9uXXO8f8ncqKiV2AmEumCOACqdmcwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 3 Apr
 2024 22:33:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 22:33:42 +0000
Message-ID: <0d63a41b-10b8-4c28-9919-877cc394a96c@intel.com>
Date: Thu, 4 Apr 2024 11:33:30 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 09/17] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
	"Rick Edgecombe" <rick.p.edgecombe@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Nikolay Borisov <nik.borisov@suse.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-10-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240325103911.2651793-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB7322:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZ49fS7pmAfKEgZH47MS93SAa9CI0SrV/1ygXK2ZR7nF73JxED6GiSK9NmVZrIwVQAlAf9lsG3QrsB1yJSMrHEP6oqAbB8Y7CPchq71YGJKgxfESIGzNBLpkgRKWNKL5OuTEqo9H3XKSFIvPUMth1MVCp9GrRmjHlZheGX4mjkm5IhzFUSsqQ0S6Lf7TIfv8eyKKO/uMfftLkicaNoUWgDGJ+RN251I6gNfSI/6mDjmLdpsL8U4utqc1jliR6GsAs7/VJm9gY4XAhWhoXRXl0IvAztuEHJ9PFJ6jcJf1uxuKNRPbDGeYg+CCg9Zln18MLv/gSj5nBtISzTpuCLB2BOuVAPzKHfGSi702/UCZQkT3of2PBhX+QWRX5A/EK4hDcelwfNbiieFfFfemiG84p/SR3xGtfotn9ZuCUn+R5aJTAHe9NTTOVtbd47W1PNWta8NkbPVdJkov8Ut0PX3pCICtgrVc7Z2VHAy+DJhQ3BIgPA86lkUmG3zODze1G29TYeZRYLoVX/GhQhH2XgMZu7qYnDgkNrk/6eeAfimO92SS8d08UCJBxKz9uCpe+qEzkCMOuMAN8TFot+i31WAnwcMwZ9Q5oDtGbbBJUdopv/nts/j+9Zr8DT8xO/HNTAMyxdvP6BappR41aFjVBFhHPpQXhf0TzJ6e9fy5PWS0X3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxxZEtUWGFoM1d2RWdHaXkzMFJiWWVDSjFlVUJqdE9wbkpjTGxsVWVZTUJF?=
 =?utf-8?B?SVErU3FmUFozQ1RrRlBGdHF4SCtycnI3dXJZVWdEN1lEeER2WUNORFBIb1pq?=
 =?utf-8?B?eEl1ZVJFWU85VVJLS0diYU1TS2tVQ1hUL1VDdHRCM0pCTVJXLzcrSmROZ0ZS?=
 =?utf-8?B?cDBDTVNOejgrWGdTbzNrRmNTek5VczJzR2VuaVdEcE51VDR4OVkwMCtheG5D?=
 =?utf-8?B?ZTlNZW9JVTY4d0pXUElIT1E1Z1hqS2dvOXhESHN6ek9aOWxBb0hPQldUenJD?=
 =?utf-8?B?dWdLMmZJV0l4OEZpekcwYmZkOHovR0w4U1pPTHZSOUdER1BOOC80WlBKbnkz?=
 =?utf-8?B?Z0E3cTBPYUlXZ3RhYlpxU2FLYVIxQkhCZ3lzZ1dKVTJ0OGwzQUMyckRhVkFM?=
 =?utf-8?B?N1d5VG5pd1lLcWFSZHZYN1hxWTVSZk52aWpWUEtTK3RiUVhPaHQyLzFqUTFo?=
 =?utf-8?B?U2JPMEdjK1I3ejRoVkFWUEoyYWNkMmNBdW1HWVNOUWpKd3BYbk9NSFJjcTNi?=
 =?utf-8?B?aGR1RnBYSzNoSndHSXlJTEliRTRJRDl3UVRCdFg0OHpyQWxZdS9XZjdNVVJl?=
 =?utf-8?B?cEhWVXdETVEyWXJYOWhobE5DeDNlRXB4VytjWWd1QlZ4MHAwcWo0YXhGSEFy?=
 =?utf-8?B?VkNDSVh1eXltSzhYZExJS050ZXkvMzE5OHRQd1B1QkRGcW4xazdDT3NRZmk5?=
 =?utf-8?B?d1REQld2ZmFKMEIzRG50dTlMbndZMUhyRXFmMVRKeVJTdTM2YXFQbVRtNldE?=
 =?utf-8?B?TzgwS0E3RUVFaEUxa2tpVERrQ3VuSndsNEw2SlVPcml1YUQxV1ZmRFQ2L3dM?=
 =?utf-8?B?TDdMY3FYTkdobmE3akVjZnYzQldlYnk1Mm9QUzRKeGtaSnJ4NmZPSVJSeEVF?=
 =?utf-8?B?SjcxY1FZd1A0bEZPOEdvN3AwVzNQYnd2dkFZS3FHYmFZNitLSnF1cDc1ZklF?=
 =?utf-8?B?V2dFRVB0aXdlUzRRVkNVWTZzNFJzUzhFeS9MK0JQcG45NU9na2ZJZHBmVWI2?=
 =?utf-8?B?ZWRnTC9SdGo0cmE1WkVYaUQwNHFtVDB5MlJTeXJ6eG5UNmpSUTJkSEZkVllh?=
 =?utf-8?B?aWlVdGlkUlJiUjNkcG1uRUwxanFrZVFSZGJwWkdTQ2pZNVlYYm5hcWR1YW1Z?=
 =?utf-8?B?bWtTSjhob3JYbjVHQVkxaUphUHdTNzBGMThRYytHWDZSOW1NYnBtbHlmd01I?=
 =?utf-8?B?dUdyVDFvS1p2ZWtENTVQRnlaenZKb09HcW5QZUx0d0ZZZXp5WnRoaWpkZGdW?=
 =?utf-8?B?K3o1dC9rdExXWGkvYzR1S0FXZWRVTitvSG0ya3NtMHhEWDNpemtLcEIzY1gz?=
 =?utf-8?B?ckZZSXZ3WW1GRDJQRHBSa01WV3NNTkM3U3E4WGV6Q2IvZGQvZU9LY1ZiWk9P?=
 =?utf-8?B?bFNlUHEzNm9icS9KcE40eGNzNHZ3OVU0RHpSd01DN1hQdHFOV3RJV1JFYUVE?=
 =?utf-8?B?SFgvUnYxTTVoSWRlRFJta3JIM2NNNVg1QjhRZHZ0UkZSa1Q2UkRLbXBIRGE5?=
 =?utf-8?B?TTdiV1dOamszMDYwbERKeTZQQjRsVVBtSHkvdXhOcGR6WE82MVU0NDNKaDVR?=
 =?utf-8?B?VFZjcGUzcjE1dFpNSWdmOUtSN2txU3NDa3JBWlBua2JXOTlOQ3hvZGhVVXJw?=
 =?utf-8?B?Nkc0MHhtR1F1eEZQSG80UFR1eGVHQkR5WHhmK0YzMWJ0SU1Pa21iNVBNZ2V3?=
 =?utf-8?B?L3VpZFdMWDBUbWxiME9QZ0JIOFZhL2pCTjU5azIzUjZmWHd4K0hIeWhibjA2?=
 =?utf-8?B?S3hwWUozeERVOE41NTFEU0FYUXFqb05pbnlScHJrODZmdThvUmpESi8vMWIr?=
 =?utf-8?B?U0hRdlpWaVJhLzdWN09QVlZnZ09wSmRRK0NReVk4VmxCd0hibzFVNmRja3ZR?=
 =?utf-8?B?ZE9UdTFJaGxCdFVkSGhidzJUV0wzdnlzU2JQUEpEMzF6bnRUUVlmcGtxOG1R?=
 =?utf-8?B?UGlFcmxRNFVlaEhtdDZUK0ppTnlsRHhSNUhVdlVlRXpBai9KSGNFdEsrSmdC?=
 =?utf-8?B?WDNFOXNkTmptMUVvWks0OGIrWWVibTVXSVNOKzlnMmpYTElERlRxOWNGVi9v?=
 =?utf-8?B?T281eTFrUnpnK21oVEVlZEpRR0E1SmNta0RsVEx3K21keWZqRkFIWVVWMTVm?=
 =?utf-8?Q?ArHaRUnvvqHmiS5Np0DVf6iEl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53002539-b671-4fb5-87e9-08dc542e1dd5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 22:33:42.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQr7q60Tb9vDTPkOE8CjdXiT4Bb8odnVAHbmovCzxnzk/TZEU8Uo0pNGLe3GP53kadU3dqG2WzxvxWxSZ8N9iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
X-OriginatorOrg: intel.com



On 25/03/2024 11:39 pm, Kirill A. Shutemov wrote:
> AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
> This is done by allocating pages normally from the buddy allocator and
> then converting them to shared using set_memory_decrypted().
> 
> On kexec, the second kernel is unaware of which memory has been
> converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
> memory as private is fatal.
> 
> Therefore, the memory state must be reset to its original state before
> starting the new kernel with kexec.
> 
> The process of converting shared memory back to private occurs in two
> steps:
> 
> - enc_kexec_stop_conversion() stops new conversions.
> 
> - enc_kexec_unshare_mem() unshares all existing shared memory, reverting
>    it back to private.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>x
> ---

Reviewed-by: Kai Huang <kai.huang@intel.com>

