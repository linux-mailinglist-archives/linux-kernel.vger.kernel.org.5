Return-Path: <linux-kernel+bounces-37813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F067D83B5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CF81F227C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47447399;
	Thu, 25 Jan 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtlFVvih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB67F;
	Thu, 25 Jan 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141560; cv=fail; b=ewEnbxVW0b/XfmTRd1/GtvlHbvEpBYglXuCy+J3TXlXygGtqD++XSWo+yk7RD5yp3uGuBTaRaAGjuIbFTxlbCQ1DJkhIMf0x/ybixR0gIi8EIDuSaqrzEFpdKdjlCrlvPVsBSHO0ptGRPw+VWRbbPa+1e8EGIjjb5s2KvtTUnpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141560; c=relaxed/simple;
	bh=cfBEAa0gCzKd+9tf6sLtlLvFGnbBxMzeHGtz42hWnEk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCySHtnflzqALCeyjHpaLW/DWM4OsRljyx+h96ZGTSeQSYYm+h+VmI9K33UiK7mSO72JlxC35C1nI28/kyRCljnI0jcUsFt/x/tF99/FqKXZN5v/upXvTWttUljYtVB+CizJ3hd1m7UsYsgCo5DMUtF7pCo1LDLtvNxmxnCczHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtlFVvih; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706141558; x=1737677558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cfBEAa0gCzKd+9tf6sLtlLvFGnbBxMzeHGtz42hWnEk=;
  b=mtlFVvihIf6lQQx43plBbQt/t8yekZSSMIDFUymOjPee34w8CZVZ0tau
   ZwxJn3PcZn+bU0uQBwFj7SnSN5QRVXjR1NlFXeBSZN2cMe2jz79SEGPSE
   IMBSczj36kSLU6egOBZDkHjhUMnH3N9tSFWD1wLqjS2YT+7NBP7Vddf8i
   iiGlG02lRvY0faoLTD3NP0KSVDTQ/Vzs2OHxWcjkZTWkLaG3Fy2jkXKll
   plhvWMs0v/PqwhZ/4mUw5pq5Q4unEAavdiSCIb3gV7p9cZFng/H0XIksZ
   upKHebN8oEDsdGlvdqLvE6zDiR2P6rYuLYtnEgCqSHC5Co1ukj65m7mJF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1857546"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1857546"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 16:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905789913"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905789913"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 16:12:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 16:12:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 16:12:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 16:12:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtlpI9M6oKK4MxtVBMg1Q2j+nyg9sgEelSSWilUM64uxd9qMartjPurAYFlRdBaacRFex3J7S01AdRY+81TanQunoo0WeOukO2KL20v5rmlkn3wrrweI14bwmqG63wtbXdWXVyrhMK7qb5pkcXPxIoNtYHmNmMeako8HabIp9F9DT1fxV5U+k99T/33RC7eYQ4PldDIbkd2YWCQ8jpw0Mbf/Otx5BmQquntCOyJryeylcW5pIyxOXQgBVw4ZqsH/MB9kOb0GWEa0E2w6kOVCXucKUNpvnHnFahfuHGQwkSCHYZbL38yAPF2J+vetbutLUOuNhQDVDDB69CFHZ3ZbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5TOcOI8oLJngkxwH+1ThNde761+SO3VT91Oew1XpY0=;
 b=C21IVu7PMT3yIBw3Mw9Qnibcw0meQu/YJKglc0ZyF9aaCNaVfQm4y1fzSI/fR6oKpwEMoESetQmHh3KCye6XToOUzeiR43yLJbRzaZ+jCGzhG5sATNMqaRGshDNtW6KLfFsbH+T/3WmLbiZlVu03nRfJSXGbuaXwFxGSeKfeJ1A5H07qQHp8aL/fRMHDKeSY7JOxQNqqN3goJZoSEVhHWvgJtE6ZTU5BaBbR9MN2+JLtKii2aK1btFAGU2aiu0wAsVW6z4ulEaUk4FuS3kIlMm2d+BM+on9f30DQYgpasxs0leyInRjdJs5RWiO3JP+e0o040sKmldxSHRJQWZaueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 00:12:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Thu, 25 Jan 2024
 00:12:27 +0000
Message-ID: <a85f6896-cc7d-4cba-a5eb-96f20c901c57@intel.com>
Date: Wed, 24 Jan 2024 16:12:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
 <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
 <7d6e3d39-ce53-40e4-bba5-242911a1522a@intel.com>
 <20240124224657.GKZbGTYTjN2m8VirbF@fat_crate.local>
 <abf569d6-9634-424f-97b3-a71716b3cde5@intel.com>
 <20240124233424.GLZbGegG_5eUaGBOlz@fat_crate.local>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240124233424.GLZbGegG_5eUaGBOlz@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:303:2b::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 068e3772-1245-438b-0155-08dc1d3a5076
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQjFmm5b9U0NHoRjcXvhpkGvbbz5HNJisu82QLKsxrXt5SXEgl80yXxVr7UJ+WDUcZfbOfeMBrxqbA33TGtf3GQvEYw5kiiuqzivIVBIrrbbRES/bd0d7/t3UMnVbkw0+90oLWBsH6fVfcUMWxx2TIki5VcRJJtzKSxu51HG7sdhl2OVPxWjBJM5Nr5n+FTwmg9x3K+TsLTHRlm6QcDJvumJmmmtMJcnm5Yqz5bDY7v/ihHnlM4XE65FnWrsPeVWHqHH0CpYY1Updw4V3x20fDtctwM9R3kgNfPw4KYm2TnMTm3mnD+FnYzZxEnY27OznaEiBJop+9s0pDtGkz3JfjOl7k92LH0O3vr/tU9GAUyYeN2jbISG1cuXn0eMCn9geGZ3bkYlzNDVMxv6WPiMfBnAl74QL5jy2rU5c+NAV0Vw16LcdCtoK1eyWzys9ZO9Y9j7j7fUzA76Juv2xJIll7/XI3EvIHfJxdGq8YH03rmKiZfcUXHhquPqNESbb9b29txQFH6oD/8eiz5LAXnC/n4ZzbthKTX30zeXWzdC2n7ylA3bExcvioKPuNpFtl85nj5jnPFsrHpSxrUztmeVIkpq15xL92/H/4MpXUkWXDR3eqsoIsevXpLtdqtDpPh1BRIG3Yko+fkDLLcAhZQMLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(6506007)(6512007)(41300700001)(4326008)(53546011)(6666004)(36756003)(316002)(2616005)(66556008)(5660300002)(66476007)(4744005)(66946007)(6916009)(8676002)(82960400001)(44832011)(2906002)(7416002)(6486002)(31696002)(478600001)(38100700002)(86362001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGphbjlRT240Y1d5aW1ObytydGFEMmZ2Um81ekw4YXBTZCtmeTNScHAzdnBY?=
 =?utf-8?B?TlJPN1VDOWFMQTV2RnR1ZnB6Y3FzbklUTEJNdWhwTkxCVmNRcDF6ei9lekZL?=
 =?utf-8?B?VnJIWkR0ZTgrTVRBQnVBTkppQjdadWRBOU5tWFFJMFA3Ti9ZOEs2S0RzVDk4?=
 =?utf-8?B?QUNKNDRrb2FmY09YWnkvVEtzUWdXY3lwUUtnUWwxQTlad2ZVNDcyUUhuQkZZ?=
 =?utf-8?B?Wlc5cWV4Q0dzSGlZNzFnRWxoVWFPUTc2bHdRaG9NV2pCODVGWThFNE9YTDVO?=
 =?utf-8?B?YmMyRUI1OWp4NGxHbnp0WmZTRjBRYmFFNjFVd0hybVNENUtlTStFWCtFWVFx?=
 =?utf-8?B?dGx5THNZMkRxTk1LVG1ScUd2Qko4eEFYZzVzWXB1QUtTWWJRTXM5d3Rib3Ev?=
 =?utf-8?B?OFVML28rNlhNcnR2K2cxZ1hCQ3pveFJPL2hNbkVNenRsakJZU1JJQ1hTbWhM?=
 =?utf-8?B?UmVmWEMyOW1NOHRvdlRySmxiaHpkSU5BSlk5QXhsWDIzQ3VqeDlMV3Y2K3FN?=
 =?utf-8?B?dEFZS2dtS080dFdwUm9zVHZLdWtIZVNOaXVaeVdYekRJcE9sQWtoRkh5MXN4?=
 =?utf-8?B?ZDRVYXlyQjVOQTkzMk8ybjBYeGxEc2d5SUlTRDQrQ012ZytpV3dxS1VDNUtK?=
 =?utf-8?B?bmpvb2t6M3NsRDF1WGlaUHF0MDhaMHpQZ1NHRmlsdTJTZWQzNDJjc2FGRVFF?=
 =?utf-8?B?dHQrMEplMllDVEpsWXg0eE8vVVpzQnF5WTBmRlQzSVdVSW82bG83L0E3MW1V?=
 =?utf-8?B?cG9FVU5VaTNQNmpHMk45NkFmamN2czJqRG5EeXg5OStpYzdvNkV3blVMa2Jv?=
 =?utf-8?B?UVZqZ2djL1ppbTA0RFp1VzNNSmg5VlQzVS8xMkJDTTY5TGRNazlDZ0FMRVBN?=
 =?utf-8?B?K2hyRDhOdDZxdFdMaVEyb251bjJBWnIzbnhiYjZuNHp6SnUxalQ5Q29JU2x0?=
 =?utf-8?B?Tlp0T09ab2dLZW5OdHFJQjlWeWZML3NDeXNkVGtzekVEQkcyVjJvMHJqNUlz?=
 =?utf-8?B?dGVDeUZNNXBEMWxiWE5LZzltdXltSzhqVWFzMXFXcXUrejdyS1N2QXVieUZv?=
 =?utf-8?B?a3JVUHE3M3U3NXo3NEFFWmpXd21qa2RmWjZ5aUx0YXdaN1ArM1RsTStqY2tv?=
 =?utf-8?B?eFhQMEJDZnRxMnJDNzNncjk3M1FjelpDR0UvOHN5dFZVNmsyZXZJUm1NQW0w?=
 =?utf-8?B?UU1lRG1ob1FTZnNmNVQwdzRUeGI3NktCb3B6M2g0MTRKREMzelZFSStSekhW?=
 =?utf-8?B?MjRmajVqcEloTmhkcytJNFk4Uzl1Y1FnL2FKR0k2d1A5SEh1VWJ1TlNvSTFr?=
 =?utf-8?B?RG5XV3NHdW52d2cwZzNhbzBFSUZScmtjblhSNnRXMHhRalJWOGVOQlIzZnVF?=
 =?utf-8?B?TFNoUFRScWdUd0JHWS9ONWV0Z1JXQ293VnJkb01LdzVLRWlya2s2ZFJFWkZN?=
 =?utf-8?B?dytCWWxsaEowTkFpVTIwRFJ5ZkdROEpWOG9ia3N0R2FYRTRucUtRWDREMlBt?=
 =?utf-8?B?aXRqaTdCWHNzc0I5aERqa2dMS09SbXY0MnZTajBJcjROM0tIQUpjU3JKSGxs?=
 =?utf-8?B?TzVDNkFnY3V6NnlyWVRKdU9Lc0tReEx5MzVFTkxxMnlXaU15c2RnNGxDNjBZ?=
 =?utf-8?B?NzZIR0FPNVF0WktZeVczR3ZtK3NyNGp6OG01b09HQStOenRtU2lGbnN5OXN2?=
 =?utf-8?B?c0wxdmFJUStWSWQ1S3lsY09tUHlwaDIrQUYxSXRYRGZ1MGdZSWhvckk3azZD?=
 =?utf-8?B?Q0Yybzg3UFUrYU9udmpIb2wzZHVSZXZKVTM1dGZIakxpSHBJR1p5QXFEU2FG?=
 =?utf-8?B?a0tEV2hzYWF1ZHJXRnUrakdFa2t2bm5XaUViV0loZUFTcHk2emZqZlFiT3pX?=
 =?utf-8?B?SGJxaUtwOURUMHllR0pFa1B5QjZOMFRUd0owZ25UU0VuQkwrUmt2UDkxUzcr?=
 =?utf-8?B?QmFYQkNKVThzN0RmellMNVlITlIxUmhWY3M5OVdtaXRXMmVRMDlWM1JzdFZI?=
 =?utf-8?B?RHZIMHZrTWQvdU5TNVpCNHVqMlRMSk9mblVvU2VmcFhTTmJmbXplVHdjZWxF?=
 =?utf-8?B?UC8zWFVpSWIyWTU3N3ErcmplcjVhaXU5MUpqSGpuNzVqVkRuWTI3bzFjdG5U?=
 =?utf-8?B?MldsQ0lGME1TZUtQWkJuV09qYjlqakZEVklTUXN6OE42SklTNjFnNVRQNTBB?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 068e3772-1245-438b-0155-08dc1d3a5076
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 00:12:27.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7S5O2+I/ScOlAuRACXRMIk9/83oZ/f6xi8PMR+48X60U04wkBuZ40geHaM54i+f78pwHiaboO5CRekW+pQww8XpTsa42jHfseTtWJdgL7nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-OriginatorOrg: intel.com

Hi Boris,

On 1/24/2024 3:34 PM, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 03:03:15PM -0800, Reinette Chatre wrote:
>> Since you are the one that decides the rules for inclusion you can make this
>> check to be one where checkpatch.pl can be ignored. No objection from me if
>> you choose to do so (and I will note the precedent for future patches).
> 
> Nah, that's not nearly as important for you to change your workflow.
> 
> What I'd suggest, though, is to sanity-check what checkpatch suggests and
> ask yourself whether it always makes sense.

Will do. Thank you for considering and discussing this detail. The final
patch you just merged looks good to me. Thank you very much for fixing this.

Reinette

