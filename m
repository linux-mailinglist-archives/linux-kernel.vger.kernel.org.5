Return-Path: <linux-kernel+bounces-129517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55695896BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF461F21943
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51911136650;
	Wed,  3 Apr 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUKc43UB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B223F13443A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139231; cv=fail; b=WK32glp0D2v0QKqX4FJ6ben/Dtd5ODN758pVDwWBuO/YkaE5aFn1Ar5f0QOSrruYS742GWcCGpqwThawz+/3n4ZxtQq/uA7kEOUYM3gZGsGZlHiRAvQYZAQ+S9SGpUDr2DcDc5NVyeSf3JnRKPcU7yTmdH5rJE9QwzZbz+NqYgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139231; c=relaxed/simple;
	bh=IqGIGu0DHn2rKfj9sQ++5OwZLgjWuooR0ELUbbUs7c8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ldaXh16SquE4v5m/nvuPLQRSEaUJBdkYLTfnzCWE169sIGk919jKBhvKqQD92LR7wYcJoV69zwRaNmn/KrKuedXCIdba7efu4UiCNFwXwmLb7R5riRpE14M6bjvMNN8qgV1vJ/DgE71E7QxUKg2WwaEqvGboNWh3zD/E/u8u5nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUKc43UB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712139230; x=1743675230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IqGIGu0DHn2rKfj9sQ++5OwZLgjWuooR0ELUbbUs7c8=;
  b=PUKc43UBFs8fbxWQo8G+imYI/M0TmPljvFmbi1WGDrGMrtqbAbcmhMIX
   U47zaqkWWCc4dnYH3SbUPFjBq2oPjWjdeXNFBienk4zVVIF+lkkjPlmhb
   a5X/UsFmPLrj54q2AffSr/4FanGI5Ah5XzlijtlDZe3KrNztL9j3yChaD
   ze2GxnF7noYwS31aOTlisr8EcDmAR+RA9sRwMyIjimCkdm9xDx4WytBgs
   ygXRBmeb6HYfZIUxbAWDAAyZ2ESRNVlD/3fPu8vLvH0bvFKrJbnyDPl3V
   s4HOYdIlDa+UPsI9f3fDw37s4P8Oaawla7RkgNyEWIg9sJ+v6GMhpR+gN
   A==;
X-CSE-ConnectionGUID: LA6PRsKzSBuRMZ3x363+Uw==
X-CSE-MsgGUID: M7muFdwKTXqkHLSRv8OmEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7519771"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7519771"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:13:50 -0700
X-CSE-ConnectionGUID: PH1FxHKHRK2S4D4kVzO7nA==
X-CSE-MsgGUID: NQXa1rXLQ5CXHWVe1UzYRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23076114"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 03:13:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 03:13:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 03:13:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 03:13:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW3ktoWock5QzbeFCqNMhfMSJeX0gxZnIvb2V7T+fRgUNFS3ivUMLlfwQdfooix1cc3yoqqgONt1M0LsZWC2T2mz5A9cr1ftcTvSU1zmQDJF9qv2o3EznjqPuC+d2yDdJp59OPZp3ixpTlz/OjBwPbSj8bqSYtzT1sAb59AP7r4o8ACDo9mLXQa5Zx8NVYR6GVQzA+BxBzRXLvDiuec0sa6RMr+/Y0K7dCGu/yWmYRwswjPIfwFjuZRwAYN/Dlw4FZ6rHD3QHaL9dHe6QsCeAz8pPjxiswVcAdvTEaZLbv0GXGZGcTh+xSoPSSUFVCHqhNmgsUu5KNy2Fbd4M4DynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnDlI37q/+yMfE3zYVXizCYAoIwfDcZbRsrBHAw4zfU=;
 b=DAnkjYOw6gTUGc9nJJderVuLgZvYLkuOce+KqMFXqMj6aIsa9RhhFqHhNDhzpnSjhQbMCnbauzdaxNYqkQszD6c1kxOxRzv1VS6AOqTm5adLjryebDCp7L5vvLtUCX+uZJTHQMJDE4oVNwLSEDTO+77GXgHW8jHCmCZMhDe+PlIgjsM32+Qh+3BjcjtPJywRSkVDabCWyC0aVJWm3P5faCfctPw3sf5cQZHb9cEHtoBTaG5Cy9rXI505pGqUicBo3hQrQNDmxxdCY9tyIWsME9PFV5PGNivRyJt/htVO6Wsmjs0L9IBIA/lAu6IKTeAynh1DoVz8jv0kn0GdFZcdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7479.namprd11.prod.outlook.com (2603:10b6:510:27f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 10:13:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 10:13:41 +0000
Message-ID: <4bc04c7e-683c-4f33-b65e-6cf088e837b7@intel.com>
Date: Wed, 3 Apr 2024 12:12:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed:
 "struct bpf_fib_lookup size check"
To: Anton Protopopov <aspsk@isovalent.com>
CC: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>, <lkft-triage@lists.linaro.org>,
	Linux Regressions <regressions@lists.linux.dev>, Anders Roxell
	<anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, David Ahern <dsahern@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>,
	"Ard Biesheuvel" <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
References: <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
 <CAPyNcWeu+bzyQg9S3wDb43jbfk95Su5XcSRFPzUbS2ofZ=+5Fg@mail.gmail.com>
 <347bb21e-98db-4bd5-9ca1-550eac5be9f8@app.fastmail.com>
 <277decf7-d9cb-451c-a105-6ecc998f9f46@intel.com>
 <CAPyNcWeXpidnVsXgt4XpwXiA0CRFdZYFN9O2ys5oq9FQKXNxsw@mail.gmail.com>
 <CAPyNcWdPJYOtDbun-qUJApm9ndsVkEj-sHDfbMWK2yCT6FOwdA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAPyNcWdPJYOtDbun-qUJApm9ndsVkEj-sHDfbMWK2yCT6FOwdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sk4p9NK6eYpeMTLaffcA50sVA6VjruqS9a1aJfb7/MBA8cqv5ybDv5TytOlCZNU8YKxNNMGFTgWyWM/Ibwul1CWzaG+OrD+5/LM8P7G5GD6BlGl7PtKbjQB+Cq4r2mLquuFvcnHMIVq5WNubNhpChXYow705o0Rm+z8TiNhETex/IetD0NDFtTTBRFXmtQyHuFmkVFizbzR7wfG5q7iymE2dc0jPWi3UXdhflrg0kHsjyzOxmeBnwS2gAP02Jwn7yA+njTE7LmSnkghNO35/Sm/G0gize7TOe4lfh7kTxnOzbVNkzwC9R7cKy083i8/YIrER4eZxfCVQtjVlzj/osNxRUOZh3Qeb9dsQiE7G54GcCuSKbxG1gNAFyAHf5aZLtmzh9CLq7na+PTM8s7v550iaynL39WK2a4fK1nSNdNo/lOZGeyDymEewO66oE9S8HLVruIX9LOb3sSXtsNEbbN4odNUHFvCknkru9NBvTF8E0LZ91ILgrkgohj6rukZOZuvDTasTWLsxvFM18ZxYGXI5Y0ix5TbkeQf0NeC5tHJ5hY7NkKSZDQmlxN187L/Pv2mga/jHKyOASyyMxAdH1G3pRfSJrRWfqzmMoTE3a2cCr8somp7sE2AWVEAv3fKp26LmuiBJTpstaFVNADTA+nGwKiOs30N2CLccwHFz04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVhtdjg3QklRa3M2bnJsbnhGcTFIVktMdE96aWhnMWZaM204akhqcCswQU1Q?=
 =?utf-8?B?SjdHUml1dFExeGZlTm1pdmFmZ25PeDQxZVE4N1J2c3VFNDZBVG5xdkJZeG1H?=
 =?utf-8?B?eUxMNTE5Mzk4aVoyTXpNM1VWbnBqZVBPRnFsVWpKbTBHVFlOTmpGZzBJL0NY?=
 =?utf-8?B?TENyVlZQcWZiM0gzNlEyMFFzVXNGZ3VPcDIrT0d0V21iTWE0blpFdEhnVERT?=
 =?utf-8?B?TjhDcFlyVGdWNk44SXlYS0N3dldUVlFsRnFyejdReHdOQnBpcFBOZ2R3ckgy?=
 =?utf-8?B?d24xQ3NzeEl1aE1GaTBPVGpSUFp3WVBPSVdDSjF5WmxreW1vVFVVSE5HS3po?=
 =?utf-8?B?dGZ6dUE2cXA3MFJpSXk3NFVFU0ZGNmprWGt2YmlMV1dWb1p0RVp4bncvNy8v?=
 =?utf-8?B?eWh3QUVQSDM5dUFuUHVDdUlWeWhFNkJxSTFEZnp5TWt2c1lpcTJOVUVqQUZY?=
 =?utf-8?B?RmFIdkRZOW03MWN1a0J6QjBVWkFDN0EwNy9keUkvN2RDeDYwck04d0F1MUFt?=
 =?utf-8?B?MHVaZnJKVmpqa1pXZTRjdzVRVDJXdkhvMU5VckNrNTlsOHd2T0lXSmxXRHdS?=
 =?utf-8?B?WjlPazZmNC9uaXUvRWdVYTExeTBJTUtHYittWk9XeENVSlRGcCt3SEtzR0dK?=
 =?utf-8?B?MHI5NkgwS280T1QvUm9sRnpoZlNYNkc0dGJQazNVUXNrWnVVOVlaczhiWHVm?=
 =?utf-8?B?OHU0UmY2ZnRoNkVXMXU4Ky9ObjkrbnRuWTYzVkF2WHgyS0o4ak5FMnQyVVpx?=
 =?utf-8?B?TVpmS0gyWkRMRWR4dUkrcjZXc3lkbDJhTTlZTzZXL25rT0V0eVdJUnEzTHNu?=
 =?utf-8?B?Um5CUTRyOHErSzU4eDUzRVNyanRzazZ6TDZuRC8yQlJNWElmWlZKZjE2bk5n?=
 =?utf-8?B?SjRQN1J5ZkVKME5RdXVSamMyc1AwUlVMNk5UbmVWZWdJdTBXQVliSFZVMUNL?=
 =?utf-8?B?MjRJMlU3eFJWL01MVjN6eTg2SW5Eb0ZmMXdJeTRZT3RlUS96NS95aEJFZUx2?=
 =?utf-8?B?QUNkN2lpcGtuQmdpc2JyQSt5M3ZxZEhHdXg5ZkdmMzN1V3NJMncydEg5dmlI?=
 =?utf-8?B?ZHZid0xUYzloN1FFdldCeHJQTytCYTIyOWtaWXBmY3U3Zi8zam9takhITFVW?=
 =?utf-8?B?RjBVRDdSZ3MxUEU4TDYyMlo2YUN1RXcwSkRKaTBGV1ZoMlByNnZ3TGY4emc4?=
 =?utf-8?B?aloyZHdDTloxeEljL0lYczNOc1U1RHF0VGhzY2l5bTBjcTl6WUQwWFRORGlF?=
 =?utf-8?B?N0NybE1GVWNFVktCOXFZT3ZjMnpVMEwyUVpjUEV2aXN3OXhFb25XTTA2MFZr?=
 =?utf-8?B?TXJLWWRxRW92MXNOTklmTzUzb3FXN3VmN1BWRG9SZnphUDhCQzVQMDJ2MmhT?=
 =?utf-8?B?TEg3KzB6R2tpNnBZTE9OczZsVXZBYThDQUwzNVJTVXVVSnQ0ZFc1cGs2dDJG?=
 =?utf-8?B?ZWVyN2ZienoxMU9taXNBc2FEdjVDMjQzNFNjT2s5d0hYRUtMZ1dNRnlDZUtH?=
 =?utf-8?B?T1hucXdhQVJJQTU4UHhoRU8rZ0xxNEdCak1yTmc1M1dqZmcxUjBEc090VHFi?=
 =?utf-8?B?Mmt3aTZhT1BHN3F2MkVSZTJaampwalZJSFg2aG9YWkFrZmRhRExaenJUcGdH?=
 =?utf-8?B?U2RLRjlhcGdlUVFhcEVQZFFRL3c2MnlYL3dmNG5qMys0clNicFdTZ0dNYUh5?=
 =?utf-8?B?cGVpbW1LZWNJTVVhclVIdE5qZ1haQVFhUXQwSUdYQ0YxTVpaaTBPMmhQMCt4?=
 =?utf-8?B?aE50NGhjbXNIYzdheW9hVlpPK1dyaHUvaENab2RCY0JpdW9LditkNndLVkZa?=
 =?utf-8?B?NlJTbVRHQUNhcS8rQ05TYUFrZm9RdWI1VkwzU2xTWDJTLzZwY1NLcTJsYzZW?=
 =?utf-8?B?N1lTOGZ5MVFmRlp0eGVpeFVBZXA1SlQvUm1SQzk3blJvVnJMc0pCMkxNV2ph?=
 =?utf-8?B?dGVWWXhtbmlHUkp1L1dKV0dmcGhCemVzUGpSSFpxRUl6cDdqeXl4R0dpcHRx?=
 =?utf-8?B?T2pYUWVicmE3SDNHOHFyTnBzR1Q2Myt3R3BBcXd5NEJ5VGIrQWU5NTJsRjAy?=
 =?utf-8?B?Z0lYc3RUTk5BbS93Q01XeU1vZmdOL3F0YitVYjJaVC9kMmxWUXJtWmhqQTYy?=
 =?utf-8?B?TjhqZnZISXFjT0t1L2d3cUFXb3hPZ1I0N0JyUURnbVpIVDFsVnBTTndjSWVi?=
 =?utf-8?Q?oOCm/hv5ey7G5dIl2Z6vibo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a65f5818-a3ae-47e6-5177-08dc53c6bcbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:13:41.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yify9/2bn8J0UsslPjSQO/YzhRRruGK0QJSxXlzd5w4ZeByX81/Y/XzeopM3rpBq+cdpdFm3P23erV7QJVox/wsbB4ohPZlELRkfs25Xkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7479
X-OriginatorOrg: intel.com

From: Anton Protopopov <aspsk@isovalent.com>
Date: Wed, 3 Apr 2024 12:09:29 +0200

> On Wed, Apr 3, 2024 at 11:57 AM Anton Protopopov <aspsk@isovalent.com> wrote:
>>
>> On Wed, Apr 3, 2024 at 11:39 AM Alexander Lobakin
>> <aleksander.lobakin@intel.com> wrote:
>>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> Date: Wed, 03 Apr 2024 10:45:36 +0200
>>>
>>>> On Wed, Apr 3, 2024, at 10:10, Anton Protopopov wrote:
>>>>> On Wed, Apr 3, 2024 at 10:03 AM Naresh Kamboju
>>>>> <naresh.kamboju@linaro.org> wrote:
>>>>>>
>>>>>> The arm footbridge_defconfig failed with gcc-13 and gcc-8 on Linux next
>>>>>> starting from next-20240328..next-20240402.
>>>>>>
>>>>>> arm:
>>>>>>   build:
>>>>>>     * gcc-8-footbridge_defconfig - Failed
>>>>>>     * gcc-13-footbridge_defconfig - Failed
>>>>>>
>>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>>
>>>>>> In file included from include/linux/bitfield.h:10,
>>>>>>                  from arch/arm/include/asm/ptrace.h:13,
>>>>>>                  from arch/arm/include/asm/processor.h:14,
>>>>>>                  from include/linux/prefetch.h:15,
>>>>>>                  from arch/arm/include/asm/atomic.h:12,
>>>>>>                  from include/linux/atomic.h:7,
>>>>>>                  from net/core/filter.c:20:
>>>>>> include/linux/build_bug.h:78:41: error: static assertion failed:
>>>>>> "struct bpf_fib_lookup size check"
>>>>>>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>>>>>       |                                         ^~~~~~~~~~~~~~
>>>>>
>>>>> Thanks, I will take a look today
>>>
>>> Naresh,
>>>
>>> Could you please remove that static_assert() and dump bpf_bif_lookup
>>> layout from pahole?
>>>
>>> Anton unionized { smac, dmac } with __u32 mark. On x86_64, the offset of
>>> smac was 52 (aligned to 4) already, so I don't really get what AEABI
>>> does here. IIRC it aligns every structure to 8 bytes?
>>>
>>> Maybe we could just add __attribute__((__packed__))
>>> __attribute__((__aligned__(4))) to that anonymous union at the end.
>>
>> Yeah, I am sending a patch for this right now. Better not to depend on
>> compiler options
> 
> One __packed__ was not enough though. The problem was also with the
> union of two __u16's which is padded to be 32 bits when AEABI=n and
> the whole structure is packed (so total size is 66 in this case).

Hmm, on my setup it's 64 bytes. Since it's UAPI, it always must be of
the same size. There's probably a padding somewhere in the middle.

Also, don't forget to always set __aligned__(4 or 8) together with
__packed__, otherwise the compilers generate terrible code (they assume
the structure alignment is 1 and access to every field can be unaligned).

Thanks,
Olek

