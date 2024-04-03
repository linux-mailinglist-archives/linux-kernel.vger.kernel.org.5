Return-Path: <linux-kernel+bounces-129439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF554896AD2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D5428A885
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB513441E;
	Wed,  3 Apr 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0fk1fjH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD86EB73
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137144; cv=fail; b=QSrV+ALfBF6Lu4l3usb6S5NV0nspnfgSMOJ37rc5WjBW02oFUW+Hq2WIzq5F2hZITeyW7xwSM3Hn5pdlOisX8YK7Hy5P6mPmfQZ6Hi8nywoKnX6YjKPwC9RVZdbPD+8KorahzbrWaj3P51JHwcH6vPndz2qtXi+Ej4oS+RXb7tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137144; c=relaxed/simple;
	bh=Wb4jkrsGWHvoHN/mE6V3hmGTBeYvN125TuWxNnJKniA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+szZV51dcvkpdGqWrtLvVIICKK2a6DRaMqxmv137f8SF/OiVNzH3Fhs+w6kY8VKvZBJ13YasNYiFm1B77HprHfbLFaGKb3yh02kJv77aQQHJryzpZJvSLWYBAWLq3SMr77Nd+Ac8CZW+gy9Po5GiEBGmpXo0m/4kZclAcsBIro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0fk1fjH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712137143; x=1743673143;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wb4jkrsGWHvoHN/mE6V3hmGTBeYvN125TuWxNnJKniA=;
  b=d0fk1fjHjDSMHD2afkJeDe7bNRiTCVdUHiFLnKQC9oGP5oTrdTgbJIyl
   nd9JoAn+XSVnSSm7WFSEl8OnVbcr6ZvLFc/2Jy8rfMZ0sP46Kp+O0HrU8
   zzo/+m2XZJVJJnaYhw1A7Gn0QMv+NXbV7lq6pIVTQm7M+77iT4GqyYHZA
   2HuXvoiVceUuMeq3pFRpSGBG2E6QuH+pRyMSZTVtPpVkyRyms8M1Pp8Py
   g753XYiwC58DRtpIbMeb/YiHX64V7+gwenVTAg8OsKRQVhYOvVuTny2at
   dHqJw8OZLU+l3W1+ZQ22H60Z2M3KpGdOeQIYAd/Cd3GikpxGomh0YETGF
   Q==;
X-CSE-ConnectionGUID: zoIk59Q6SmGtD1ek/Nfbbg==
X-CSE-MsgGUID: 9E8Hy93bQkK0hrRfGthDUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7937386"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7937386"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:39:02 -0700
X-CSE-ConnectionGUID: EcELvYM+TN2B02/cIdeaUw==
X-CSE-MsgGUID: 63i389QySBOOUgIdoxCoAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18819028"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 02:39:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 02:39:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 02:39:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 02:39:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 02:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEahc+6BCt5Gm5m5ND9DEhhTcmJnzL5BkX7aGswga+XR94HxaxNd6ivXxqsUrXkwhkeG0lOd5VmjJCV83DVkHnUDl2zeo8Sz17gntRTA2ocdLZ2n7LIeYsaNlBF0+Zx6+Hq/cQOovp+jreQI+hr2VzPj3EJTGlvsh0y9zE0gPjHe+CsXV14YRLykQiBGug1MpoquMCpWjIRx085SmWlH/EocPmdrLaQdPe4QIqvcdywyRUdjl3cMsxnKmShVQIY6vyOJW4kGwOfO4FZBg455vRbEN0zpzGpt+szQCd17f7HHiUQfgbpiW+Nn2+0Av5OFoyDjUYm6GsTfWns0dz1ygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BoPPX/kHKPrSjzFLNW8mSxXek1ERKBSaB8wEyjGK2M=;
 b=UW2z4KRa++m3qWN+gODiQ1lFLEd1S/h21ky9pQooGskI+52vPP6ZuGVnRFELu6CrCB/lmz8j2GlLxv6KSnsR5DtbMDhF12gt/h8A+14EyYsUvfYajlAfgcHwbarQMrC65CB8FSlKo+yTO14ocg1ahp82VEAH9TL8RPhPalgwaibcuw0r2yFv264AklyV0Y3cnzEPt6n8Kq9pn14huGomO2M4FSyHVbnK1CbxdfcdEeC+lotU7TIl03oeDA4jrHS/tklNc3EPDBhdfTVJTb+P6EoAna8n7rY/3nQ0PLHmuQ4wBaIgDE3WIB2mqog3/0cWymryJuBHJ/OcOBnS4GDslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB5946.namprd11.prod.outlook.com (2603:10b6:806:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Wed, 3 Apr
 2024 09:38:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 09:38:57 +0000
Message-ID: <277decf7-d9cb-451c-a105-6ecc998f9f46@intel.com>
Date: Wed, 3 Apr 2024 11:37:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed:
 "struct bpf_fib_lookup size check"
To: Arnd Bergmann <arnd@arndb.de>, Anton Protopopov <aspsk@isovalent.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
CC: open list <linux-kernel@vger.kernel.org>, <lkft-triage@lists.linaro.org>,
	Linux Regressions <regressions@lists.linux.dev>, Anders Roxell
	<anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, David Ahern <dsahern@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Ard
 Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
References: <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
 <CAPyNcWeu+bzyQg9S3wDb43jbfk95Su5XcSRFPzUbS2ofZ=+5Fg@mail.gmail.com>
 <347bb21e-98db-4bd5-9ca1-550eac5be9f8@app.fastmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <347bb21e-98db-4bd5-9ca1-550eac5be9f8@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB5946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fv/xyRHA7i5aSukQmCmcgXEKZWLTLXd7r+PsTFzcbYRphM1WwO0BBG9LPSr1jFseZ7ONqItaYAEZf5Wpg7eMUxMflVBP7jbGc6UKeTw9eIcMudoGnk4UvPP44aFmj9zmQEbU7xgpBb08ETfbE4Fwba0l2W2gPb2E2MZROF4Vfz7gdIveC6HVT1AL8zq7wTHfIzwsegaS8ZLF8LEphd6+nfLVwFACviaEnrc4pry2DyshMzWFnLh6ddbFwRXf98hSRIOHvaJ3Wk32A5VEdJSKEJcu6b2nQCO6YT6AQjIflIC23SohUJmXJRdnScGAOkOaM1TLwNw30QIoIMe6O1+O4F3nIdR/9kmnvW/qAJcTM4O6UvKPcKa05ok2/t+MjvhMX0yuf5el6KhN2tSc+cDil8TpTDJEhV5Z4toL5oGXNdAn6GyMnPKVD6PbwnloERflOJ74HhGqnbHiG9xhxWnlK13oCR7RJRj98VdlqQQ4/WNU0bTK1G6ysLo4Q7i3SzsW2dNLsJSQN+OtiUn3IQhFBQImyy+NaUZvKCb2aT6UDRKiR4Y+X8vNAkAYHxIE7Uj0X0yrKHuRrFYkftF063yGTUwSRDcf+pGUO7TrQVEdiQYrL3fdA9hAdMSr/NDh/Hba05IalkFxNdH9xFQpmSk/DBCdXBNYot+ZSEgLDwmahEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNhRnFYWGFXaDdDNW15RTZPNk9HanlyOWU3MnNwMjRKMFZad2ROTCsrT3dz?=
 =?utf-8?B?Q1BzMTFsYTNDdU5iVWIyVDRwOGxsNWZvdkk5VnhES0RqK2F0alB0NTV5ellL?=
 =?utf-8?B?UW5vVGN0ZzJiRU4wemtrMWY4c3NGd053UEpiU1RVMlhnVjZ6UkRkdzEvNG5P?=
 =?utf-8?B?ckhxSkFLUVZrWnpOd0Z1WXY2ZkhjSnNtVWJMcWxTYnpyT1g5eC9MRUNUeUZi?=
 =?utf-8?B?anlnamhQbUdtWFIyQ2lTdUVWbU1tdUIyZVY0a0ZaNmVsSmkyUnFRNE8zTHdV?=
 =?utf-8?B?NkFLbVoxV1BpTkFob1F2MW1EaCtacVF0KzhmRmg3Smx3eDVNK1ltMDFYcGJq?=
 =?utf-8?B?eTZBZThuTkNHQ3FrN1pCRlJpOW8yY3NPQU1xVmRoQjZkWldtTTd4RDJOZnR6?=
 =?utf-8?B?REl1U1pNSjJDWjM3UXVyQ3JlUkxKN2tBY28rV29BcjE1d2RhelNZY3VBV0w5?=
 =?utf-8?B?akNOQS9EZ2dTaVZrSG1sZlBZVSt2ODJXN01iNERaUGJ0c3prYXBwUXBLRzJD?=
 =?utf-8?B?aTNzekx0aXgyb24zczlvY2ZSN1RUZ3RSekZxcktyZE90UWovSmxUSWQvYjZJ?=
 =?utf-8?B?d0JqSWQyUEs3NTJpNmJ1ZDRHR2FZQ3NCbDM1SnZpVmUwczQxYmdTbUxuUzMx?=
 =?utf-8?B?eUVIcUVlT3FvWThjZXViNnEwR2xMWjJPZ0NSaXduUE1xWkYxaUtGZWxUVnV1?=
 =?utf-8?B?L1hHY2RYb2w3eVN6YytWMjdDMHdwRkFEclUrbi9jeFpNV1JwMkxzTEM2Z3V2?=
 =?utf-8?B?eXJZNzRBdW9rY29MdzRwSmFqZlRHZy9TZDNyMWZPTWUySUxrOGVONlN5MmNu?=
 =?utf-8?B?dnBXcGp1bTI3VEw0SVVSTEtPUWlwc3NsY0djemlqTUhmQ0MyWlVTOWl2QTN1?=
 =?utf-8?B?OVV3TkxIRm5ReUZNK2RQdUM0b1puNlArQTVuRXBqWHU4dWNpTXpBNnVJWWtz?=
 =?utf-8?B?d29zL2xISFVqcVhVenBja1FkYnZNOVRURmFXUGVqNHdlajN3Sm9pL084VUxH?=
 =?utf-8?B?SHVDY1hRQys5WGJlcmRlRmlJY0JTWityNU9HVUpxQ2QvWnZXUXQ1ODU2eFZ4?=
 =?utf-8?B?Tk9NZUUrbE1HOXNDSUw1SExNVGIrSGlpdzRxY2ZTd2FidVZMTjYycE0rK25u?=
 =?utf-8?B?QUgrbWd2eUlJdmxWQzV4TmIzQ1lLdGdXaFA1YVljQVk0MWZLU0V6UVdoaEo4?=
 =?utf-8?B?d3NUZXRoUmNxV25qVVFwUVBWN3F3d045V04zNlg4WVR3dXJabi9xOUZBbGlD?=
 =?utf-8?B?OXJHRWJxc09SSVlZNVRVcldSN01KeFFlR3dPZU83Y05KUGpETSt5R3FVY1J3?=
 =?utf-8?B?UlNuT0Nvb1JaUzNLVGhqWVU1Wkx5b0MxejBRc0FlV0RLelczOWl2dVBIODVK?=
 =?utf-8?B?M2VUeHdNVDhJRDBVNWZRWVFjNDB0QXpPdTFjdDJHRGt2d2xhUktURkpLS1dU?=
 =?utf-8?B?d0RHZlNrUGdRSkplbzg2SCtSdkRsajl0UnlxRTRsa2duTVA0bUlPWkw4Q1VL?=
 =?utf-8?B?cUdFVWxseGdON3NNZnBGSVVZRzdvNTFDYVN5eHF3MVhVbkpVajU3aHVRcXo5?=
 =?utf-8?B?dVhMR0FuK0xxa3dPWFB4YU1GRzVEaXlDcHA3Y2tiUnJYTHNoaWRlYVI2em16?=
 =?utf-8?B?bllpdzJtNjIvK3JNazdxaUJzZXIvVVNyNEc5djUwMisrc1hrUE9sR2lQaVZt?=
 =?utf-8?B?MlVnL1Y2OE5PQ0xqVzJYWXhWSFZDWGcwM2k1RitibEpNL2RjOTVOeHEwQlM3?=
 =?utf-8?B?akpiSUNjM0lueFdZaXpqelpPSGZwaXhDTkgyanpjM0JuQ04vc2xJa2dNZU5Y?=
 =?utf-8?B?TDdveG1VaW5rY1NVZEZmMnN6VG1ZU1N5U0dCUEc3NlI2Y0JlWlYvb1ltRlhK?=
 =?utf-8?B?aGJQVHNsd0FtRGdWbWhIVFhGZmFHYjZCRVZpbWlLcVJ4YldPb2tEUXRPbDdF?=
 =?utf-8?B?MHNQQzNSemFQa2llNG4yUnd1Nmc0NmUrUGV5dENLYjJ3QnlXQks3OFlZVWlY?=
 =?utf-8?B?VHRUQzJKckxCWmp2N0J5c2tKeENCY0xwNXorZWpWcUpJcEU3S0tUOVdvSDI4?=
 =?utf-8?B?TklZN25Mci9OWTNJeGlFeFdoVUVwb2V2cFUwOTAxTkp0N2VZaE04MVJLZmtB?=
 =?utf-8?B?Qy9pOXJFVHpCSklQRG82WmdjVnRtaVRPU2VLRVkzWVlqWkIzK0tZVjl1dkM5?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6ac31d-a972-4b8a-dffb-08dc53c1e2a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:38:57.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFFHUWp9how0vjPI4XEXzggOgqWXifU2XtF4znVA2gpKKGK1XSab3pRvfBqI0z15+sGZqQlVqlexQsjVL4tgmOL6ZNXR0Vs9w+gyoFqXfQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5946
X-OriginatorOrg: intel.com

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 03 Apr 2024 10:45:36 +0200

> On Wed, Apr 3, 2024, at 10:10, Anton Protopopov wrote:
>> On Wed, Apr 3, 2024 at 10:03 AM Naresh Kamboju
>> <naresh.kamboju@linaro.org> wrote:
>>>
>>> The arm footbridge_defconfig failed with gcc-13 and gcc-8 on Linux next
>>> starting from next-20240328..next-20240402.
>>>
>>> arm:
>>>   build:
>>>     * gcc-8-footbridge_defconfig - Failed
>>>     * gcc-13-footbridge_defconfig - Failed
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> In file included from include/linux/bitfield.h:10,
>>>                  from arch/arm/include/asm/ptrace.h:13,
>>>                  from arch/arm/include/asm/processor.h:14,
>>>                  from include/linux/prefetch.h:15,
>>>                  from arch/arm/include/asm/atomic.h:12,
>>>                  from include/linux/atomic.h:7,
>>>                  from net/core/filter.c:20:
>>> include/linux/build_bug.h:78:41: error: static assertion failed:
>>> "struct bpf_fib_lookup size check"
>>>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>>       |                                         ^~~~~~~~~~~~~~
>>
>> Thanks, I will take a look today

Naresh,

Could you please remove that static_assert() and dump bpf_bif_lookup
layout from pahole?

Anton unionized { smac, dmac } with __u32 mark. On x86_64, the offset of
smac was 52 (aligned to 4) already, so I don't really get what AEABI
does here. IIRC it aligns every structure to 8 bytes?

Maybe we could just add __attribute__((__packed__))
__attribute__((__aligned__(4))) to that anonymous union at the end.

> 
> The problem is CONFIG_AEABI=n, which changes the alignment
> of sub-word struct members. I had assumed that AEABI is enabled
> by default for everything already, but it looks like footbridge
> and a couple of other defconfigs still have it turned off:
> 
> $ git grep -l  CONFIG_ARCH_MULTI_V7.is.not arch/arm/configs/* | xargs git grep -L AEABI
> arch/arm/configs/assabet_defconfig
> arch/arm/configs/collie_defconfig
> arch/arm/configs/footbridge_defconfig
> arch/arm/configs/h3600_defconfig
> arch/arm/configs/jornada720_defconfig
> arch/arm/configs/neponset_defconfig
> arch/arm/configs/netwinder_defconfig
> arch/arm/configs/rpc_defconfig
> arch/arm/configs/spear3xx_defconfig
> arch/arm/configs/spear6xx_defconfig
> arch/arm/configs/spitz_defconfig
> 
> Russell still has machines with an OABI toolchain, but I'm not
> aware of anyone else relying on it. It does cause other
> problems as well, so I already turned it off a long time ago
> for my randconfig testing.
> 
> We should probably make it the default for everything, except
> whichever defconfig Russell uses:
> 
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1159,7 +1159,7 @@ config ARM_PATCH_IDIV
>  config AEABI
>         bool "Use the ARM EABI to compile the kernel" if !CPU_V7 && \
>                 !CPU_V7M && !CPU_V6 && !CPU_V6K && !CC_IS_CLANG && !COMPILE_TEST
> -       default CPU_V7 || CPU_V7M || CPU_V6 || CPU_V6K || CC_IS_CLANG || COMPILE_TEST
> +       default y
>         help
>           This option allows for the kernel to be compiled using the latest
>           ARM ABI (aka EABI).  This is only useful if you are using a user
> 
> Or we could go one step further and make it 'depends on
> EXPERT', short of removing it entirely.>
>      Arnd

Thanks,
Olek

