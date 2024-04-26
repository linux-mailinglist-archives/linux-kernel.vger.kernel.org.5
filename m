Return-Path: <linux-kernel+bounces-159406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F078B2E37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E756CB233FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7DDEDC;
	Fri, 26 Apr 2024 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lyk8aJuF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5CEBB;
	Fri, 26 Apr 2024 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093660; cv=fail; b=qH+LbRylHdyLzXZBoKlplWsZ5uaECsyMmbL9bInBW2fgCJ53fV2PlO+wiVSX71m6YcS4MGQWnI0DWjg4aEzAVkTJBOmsywKeSuzp8aLmgpCl9luNakXrkfwlio353mJpCuVQR4NkM0B1+NbXtGANC3qpWPpyNcD1ZGE6CLayJF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093660; c=relaxed/simple;
	bh=3teEPcV7y5xFN6pz1A3CNv21XnDvhYjJgiDZ1GzKhmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EACkXWWUO+NnbmubBE5It2xjZKOoOMrJeb63I4wRcFWtxDWddGNTNla7hOd3mMByouGCJKY8PSdfgO1s7i1VW2NAn5tnIQXxJFJaVIOsyEba4nbob9GCnIJJCUdeWs8Z/Ji0mJ0Jhkt88FKf43H811ckr8PKjOwiNa/m8nd0Tkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lyk8aJuF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714093658; x=1745629658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3teEPcV7y5xFN6pz1A3CNv21XnDvhYjJgiDZ1GzKhmo=;
  b=Lyk8aJuFqh0WRUuOOt8/9/9T9fbvqOBVjnIv7V0s8dk8yRdow6f3EciI
   sJfFbslU4x/sCv8wZlZYLbtXa3jBnFpjyJP0dulaUpI8NvNGhZsVNQiiM
   z7zHUvddaJVPrJhHeA/ES7QnuOaLnPAMRru67MwOP67pQiGFwDBlWAdFs
   xuWM2Gf1yVUP6C+P7dn1rSaXZmqqbq+SgkovKLplB3aXRjjo3TYoQmHtr
   6ME1GiKB2tjQ4cJCDRYIh3x9uS9goIyXbR/A3Pl41lzCC6oM+TL0Jqjh3
   P1xkTFUbgdSMcDY8hcYPKBKnduFrahHHy9A0TE/bw0CfnTObA2dLPDrD4
   w==;
X-CSE-ConnectionGUID: gvCiyLw9Q8Od+qX0t6Jupg==
X-CSE-MsgGUID: IEX+ObDtSLWXk3D8nKDILQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10352456"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="10352456"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 18:07:37 -0700
X-CSE-ConnectionGUID: h2tP0k8lQ7uq0brKNu0Jag==
X-CSE-MsgGUID: qVl9LRHVRPOYtml4BFrhig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25349103"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 18:07:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 18:07:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 18:07:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 18:07:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 18:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeOYuEhr2ULA1QsOlZN4d1ziXxoAhrXkMrqi2Vy9GiXLnPB8UZMt39+24KDmDXMuE55Cg2Y55XJ04PUK55hYf+KJpHTANs+KUvhYSjcBBzcL6vyAMHkDLvddGf4xDr6Hgy8dl+AM8RwW5JX8FAfWyZNqUrK51BO1SphhG0lKqbSnRZqxKVzH4fx2C6h6frgz5kA+rqzJt03y9cp86OLvyKsED5386jHS1SEi+Y5Fvzlxxbb9ouxpR/RGVrn+gVI5ZgEbsFB0x9u7CUoUdh0h9WhQHFxhlZnORUeMDngs2FCEmyGoZd+pwL3VoII95wvD4bamH7rW+TddhxHjv/QROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3teEPcV7y5xFN6pz1A3CNv21XnDvhYjJgiDZ1GzKhmo=;
 b=l/SLsWYeNzmauD7pB8xahGgCBGgPMZE0FpaE09FB2PhtTkb+BMy6rwQa/aQM7Wpu+1qsyrTpg34f9ENrY7qLIoKOyVfdZrTthMV/LAZWReUE5zLEos4RbI0SmoGvgPyeNTxuNunlP3pPhNusobmzdu2Pf1qf8MO3wF/yEF+/kNanNUZAf1onCsbK/VSr22OGBelsO93G5f/WpLc6khDVXqs3M3baqnQACOPpUGUs1+XePAlo0RnteLfYH6zDRWuByF0ptqUKM69Z5E16TTsVGfxantUgO8HAk+EhUtd/2+w1IocgSA6qwIgx43x7SAqBsple6kZH3Q9AUbN0QRlGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by MW4PR11MB6665.namprd11.prod.outlook.com (2603:10b6:303:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Fri, 26 Apr
 2024 01:07:33 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 01:07:33 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "jdelvare@suse.com"
	<jdelvare@suse.com>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
Thread-Topic: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
Thread-Index: AQHalnNrTnyThiuBq0ybKM8VogMEprF310iAgAAG0wCAAYsAAIAAVjcA
Date: Fri, 26 Apr 2024 01:07:33 +0000
Message-ID: <2fe8fce0d553eed5c27c51596f5bce780bbd9395.camel@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
	 <20240424181534.42216-1-tony.luck@intel.com>
	 <8b138aec-9565-4847-8c7c-8a1fe6972a04@roeck-us.net>
	 <SJ1PR11MB6083E8AFB8E001855DE4162EFC102@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <Ziq2AMcJUyikTtxK@agluck-desk3>
In-Reply-To: <Ziq2AMcJUyikTtxK@agluck-desk3>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|MW4PR11MB6665:EE_
x-ms-office365-filtering-correlation-id: 6f5e0dd9-d9d1-41df-635e-08dc658d40e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RnpLTUxwWmhLaENBRmZXbnM0c2dRZUgxUEE1emRwOEQzMUltV3lmRHlPVXM2?=
 =?utf-8?B?NFNUZWsxVGV6RDFTMUVhQmd1dm9qYTQ4NXdJa1hMbzZGaFRRekVoam1FUHcv?=
 =?utf-8?B?Mm1mVlZhNkxyTWxTMWVEZ3pRQ3hhQ28yc2RJMXNZd3Y3Q0xSR0o2RExoQThu?=
 =?utf-8?B?Y3hXOVJxWldaa2RGRUhCQjBVQmZyV21IVFg1MitWTndXY0NWSjduUm8vbmFC?=
 =?utf-8?B?U2tudnZ1SEZMOE94NUppNWwwaWQzZlMwVHpIMzZNQVVpcDM0QVdTZG9mNVB4?=
 =?utf-8?B?clY3VXhCTVNXK3lCUVdESmZnZWNtd01wR3ZyNUZUN3U1ZExiWFU5Q01BOWFJ?=
 =?utf-8?B?U1VjbzNxWmtkSWNmTGZQNHEyQ3NHN2JDTTlIdVNKQWpZSWpRSFNtRFJZNnBL?=
 =?utf-8?B?akVkem5neExXTTFSRkFRNTJsYnBrbmdCVml6UGg5bElDZTdwdDFCd0pkTHZC?=
 =?utf-8?B?WE5XYVk2RjdRcVpaVWFqQ2xLbWlCWEdiNjQzTjdxRS91WEhHTXpiNzJkQVd2?=
 =?utf-8?B?blRHcWRWVUJGNzFBMHJlODc3MDgxUU5vb25YdFh5MzZ0NXBFWHFvUkRXcmtx?=
 =?utf-8?B?Wm9MWG1QRDU3MG10TlR0cUhkSTVBOW1nbUt6d0lwc09tNUxORFlLNG9iR0xl?=
 =?utf-8?B?Ump0a3kyRWszZGNHL1NvcWNGbXdwY0FOYzdqVVQ2MklRY1JJZ2dqSS9WczlQ?=
 =?utf-8?B?WW5zSzZJQ0QwaEllaVV2Y1lnS1NEcjFvck5Ib0JlOHFodjJHUy9ncjZEd2Ux?=
 =?utf-8?B?akxWQnlMQzNKNkUxM253T2NINU9ZaFc4TDRUVHdZR0dJb3ZDVUgrV2lLTEda?=
 =?utf-8?B?Mm9TNUg4eXBxSDgwWVBsUmlkalc4alJUb1VEY2pRdGtCQlk2WFFmcERMR0FI?=
 =?utf-8?B?Wm5XdHVqZWg1SjNUbDZsUG92cWErMjhTZ1gvb2l0OG1hRWpzRGNnL3JUN2Vx?=
 =?utf-8?B?T1FrL1M2azU5N3dtd1NmOVBKWXo1bWlnVEVsUStYNktLY0dwZ3BnMWtsQnBP?=
 =?utf-8?B?NExvVFRkY0c5UmZPSGVOZS9yS01WaXNRbmh5dnowOXZ3Vmg2bEQyTGF1WGVq?=
 =?utf-8?B?UGszaHpqeTNqZmJla1ljcmIxdGFsQkh1cnA4QUJ0aXpocUI5S2VEMDQxKzBa?=
 =?utf-8?B?MEU4VFdQM0s5YU5aY0wzRWJPT1NJRTdQV3F1ZkNSQ3U0Z0dGaEdKRW5UaGti?=
 =?utf-8?B?ZllNTmxwNVZPSHRrME9OVzFqc1g4NFV6ZEJGc3FqSDNrUFBoU0s3ZDJBaExj?=
 =?utf-8?B?cktwM0hZSFRsaGIrNlQ2clNEU2hoV1RBRldhMngzTmt3UUNJUHlBS3FwOXhF?=
 =?utf-8?B?VlUxMzN5WE5QWlltZ3NOQ0hoY1BFenEyYlZGR3JKQXY3VE9kMnVTT3dXa2ZD?=
 =?utf-8?B?Qm1FNjBUenJnbmlHeFhsZ3luLzJkQUxVVnRLaWNGOVB0RGxmSnozOFFDakp0?=
 =?utf-8?B?SmY5TG5lM1IyUnJ5VUZ0L1h0ZzcwVE1DbytDMmk4dWdKaTUzay9DUEc5SjVh?=
 =?utf-8?B?S1N0cFVibG9GZStvcTVKSzZGTnoxZkFlZTVlRy9KazZPSzIxSzl2UkZadHJp?=
 =?utf-8?B?Uk5IcEpaTFBQSG5HM0t3VjZsUGtFSW9oaVN5c2crZFM2N29TQUw2bE53Si9s?=
 =?utf-8?B?RXluVjV1czB2VkxJSWxObmc0TUppWitsdWkyTnhmajE2dkJZNktYK1RnOWlW?=
 =?utf-8?B?ZDh0cEpvVXZnU1Zoa0Z6U1lJRExhVWlrSlpYckJoeXg2T05ESVQ1YTgreGR6?=
 =?utf-8?B?MWJvczNDT25ISkV6NDkyUUFteDg0Z3YwMUVtdVI4cE5qNDBncWRMWUl0WGta?=
 =?utf-8?B?NW5BTVlML0pmMFNudVFqUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2xSRzdzeFg1VmVZOEhmbDIzQUJzazZVd0dDTzRLWFZVSGwvU0QvSDlHanRn?=
 =?utf-8?B?aVNoY2xjdURyeVlkTVhMWHVwdXVOL3g1WFM4Ti9RcXZVeWdQakIyVGVDWXFX?=
 =?utf-8?B?T2gzR0JJaUZlUXJ5RVZISWJTK2dubkJKNTBHT0ZhaTF4UkwyRllrMXBJcG1M?=
 =?utf-8?B?TXZVbjZCdVNzRytGUlZQMFA0TWUyWVJUYmlwU3I3OHlDSjMzTnd4V2xqN3dh?=
 =?utf-8?B?b0M0V2M4Z3pWWkVmMzY4T2k5NmgxN1huYjZiT2YzSnVaVlVJU05Sc0ZmcXcx?=
 =?utf-8?B?eDRFeUk1N1ZldmNGaWVNS1hnS0xaZjFJUTJoOTVCVWc5NTJTbkJXa3VRdmR1?=
 =?utf-8?B?Skw4VER0STNFWXp2S1RwUkhKYmZxVlFjQ0JGS1FPaDF0RVVDYWs5SGxjc1Uz?=
 =?utf-8?B?Nkg1QnJCeEVrQmRuZEZxWkV5L0pIQjBLdm5mczJWbld3VE1mS0hpdGsxWmlu?=
 =?utf-8?B?NUVHYjBrMlJTVGxyeHE1ZXNjaVVPL1crRnRJbUZ3T0tVdC9rd240dnAyc0lE?=
 =?utf-8?B?NHNETG1xYm5TTTZ4bUFxanU5UVF2cnZhOWxva2hJMThQVy90eTczUVpJS2dx?=
 =?utf-8?B?TlR0UWdQclROV3FCeUF1SndQUSt0RXFVUWd6YkNFV3R5TUlSbFJSRENEU2cv?=
 =?utf-8?B?SFoveXM3LzdqTzZvaUdxbXNtWUZ4NmNlbjZCUnRSNzdNYjhPZEdXbGV4TVk2?=
 =?utf-8?B?OW1YOEg5TklCdUtpUXQwTGt2aytlUXhUeXAwcEdDOXI4S3VNSjROYmtKQVpW?=
 =?utf-8?B?eVhBa0F1VDdUa01WMUl5OFFHVjI2WThGY2Yxc1VxNHpvNG9FQktQYkwyY0Fu?=
 =?utf-8?B?QjdXYmlRK3p0YlpBckw3R2RYc2NmeG94US9BaHdING9jYlNLQ24vWU15ZGFX?=
 =?utf-8?B?bXZmamsreHNESmsrNlhxZGpQSnF0N1pkazZ2cmwxOXloVDNVaENibHNlL29F?=
 =?utf-8?B?c2VvcFhZdjVTNmhtTFdoSVg1ZkRkK0xtSWpJRy92U0J3NWhKeHhuT0c0NDY4?=
 =?utf-8?B?SlBWQ2xYTVhkWUtxbUEwTEh0OXh3SDhlL1NVNUJWNk1XcWpEcDlUTEMxZ015?=
 =?utf-8?B?L0hYZ1drUFc5L0UxaWY4KzhmUzF1S1pVWlhXRTVkSGpENEVZRVRCUTdzNlUr?=
 =?utf-8?B?R0grcWpienZLS0xyaE9qRVd0M2ZhMWlHWm9HWWdSTUdiUUJZQTRFQWJKTFJs?=
 =?utf-8?B?OENBZngrUnJWMVJqbzcvNFlQUmFHQ2ZyOWh0TDRYeWljaWt4S3NDOTlZWVlM?=
 =?utf-8?B?aTFCdmxBVmFzclYxWjRqWi9NZmtzQjBmUVJ4YjdxUlFYU3l3OHRZNGE2NkRl?=
 =?utf-8?B?MmgyWU1CbjJDUVhwMExYTEVQMTNSMUFYUjkxc2g5Ry92bUY0ZHRVWUUvdis2?=
 =?utf-8?B?bjdIZ2FkTnlFTlFzMjZ2Q3l5VDU3OS9RbUcwNzJ0d0xuSGkvVGx1N3ZiN1R2?=
 =?utf-8?B?MVV4NzdIejNMcDI0SVZsU0QzcUJKYTQ1ZWJDc2hpdnd3SnpqNEJhbzB6YXdD?=
 =?utf-8?B?bXZJNTBSVmE0NlRlZG5Ub0lMSkFQejZoMld6TDUzNyswQ0Rtdmo2ak45UWpL?=
 =?utf-8?B?SDN4VU10RVQrQU44elBRZ2s2eEt6UWxHTFZWK0I0bkRBSlNrUEpSbWtmUVdI?=
 =?utf-8?B?OUlaSHhPVDlsRjJjVVhRNytTcG9pcnZUWHY0QmpaUllTUEQ5SDM4QkVnYUdM?=
 =?utf-8?B?MEhOTUJrek43L0N1NDFvV2MwNzJBUDJMb1IvTVFXTE9RdnBKcUlJSi9ORHVq?=
 =?utf-8?B?VUM1U0RKUjZFUG5QcXdLUm5ZZzNaeTFhNjNzTklSWmZrY0FHUEljbnRMcWMr?=
 =?utf-8?B?ZnpZZVEvMTd3clZzcVUxeUZLSTEzV1dYNTg3YVJGRGp3QkgremluR0NOREYw?=
 =?utf-8?B?V0ZqYnNhVDNyaTE1WkdkQVVQYTk1Y282MnhDQWtlYkNkYkZUVGFuVFBkdTNw?=
 =?utf-8?B?dWR2Q3hFRTJNNnVmSWRxSGd5bE50Vkw5b2RMakdwQ2ZMQzNwRUZqUk85dm1y?=
 =?utf-8?B?T1puQURrOG05RG1UMVc2cllFc05zdlpCbXV4MWtjMHBIUmNPUnRXc1dkcXdp?=
 =?utf-8?B?R1JoZmhXeTJiVlFnR1pqbTFuN2NXNUN2a0tFZTFrSlgrWTZCLzVLdGhzelV2?=
 =?utf-8?B?UUZMUmJyUHd2Yi9CY0NCcEJXS1NrMGY0dFo1ZTBaTUkzMkFUbmVESmJTMW5K?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B613E58DDB09E44B69A40E6446F7CA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5e0dd9-d9d1-41df-635e-08dc658d40e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 01:07:33.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZr5Llujhps0PyZkpPNSY8pMQEdR1rSHc/unaBYzk4YWfq0Tfw+KrqEpG9r6C52sWrnSrTBnKIRWnr1d3Xf9mdmwzpWHVU+Vn435AHcSvhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6665
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEyOjU4IC0wNzAwLCBUb255IEx1Y2sgd3JvdGU6DQo+ID4g
SXMgZHJpdmVycy9wZWNpL2RldmljZS5jOiBwZWNpX2dldF9jcHVfaWQoKSBzcGVjaWZpYyB0byBJ
bnRlbCBDUFVzPyBJdCBzZWVtcw0KPiA+IHRvIHJldHJpZXZlIGEgdmFsdWUgaW4gdGhlIGZvcm1h
dCBvZiBDUFVJRChFQVg9MSkuRUFYIHRoYXQgd291bGQgYXBwbHkgdG8NCj4gPiBib3RoIEludGVs
IGFuZCBBTUQuIFlldCBJIGRvbid0IHNlZSBhbnkgY2hlY2tpbmcgb2YgdmVuZG9yIGlkIGJlZm9y
ZSBsb29raW5nDQo+ID4gYXQgdGhlIG1vZGVsIGlkLg0KPiANCj4gU29tZSB3ZWIgd2VhcmNoaW5n
IGluZGljYXRlcyB0aGF0IFBFQ0kgaXMgYW4gSW50ZWwgc3BlY2lmaWMgcHJvdG9jb2wsIHNvDQo+
IG5vIG5lZWQgZm9yIHZlbmRvciBjaGVja3MuDQoNCkNvcnJlY3QuDQoNCj4gDQo+IEkndmUgcmUt
d29ya2VkIHRoZSBwZWNpIHBhdGNoZXMgKGNvbWJpbmluZyB0aGUgY29yZSBhbmQgaHdtb24gYml0
cykgdG8NCj4gc3dpdGNoIGZyb20gc2VwYXJhdGUgImZhbWlseSIgYW5kICJtb2RlbCIgZmllbGRz
IGFuZCBjaGVja3MgdG8gdXNpbmcNCj4gdGhlIHNhbWUgeDg2X3ZmbSBjb21iaW5lZCB2YWx1ZS4N
Cj4gDQo+IFRoZSBwZWNpIHBhdGNoIGlzIGluY2x1ZGVkIGJlbG93LiBCdXQgeW91IGNhbiBzZWUg
aXQgaW4gY29udGV4dCBpbjoNCj4gDQo+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9hZWdsL2xpbnV4LmdpdA0KPiBuZXdfZmFtaWxpZXNfdjVfd2lwDQo+IA0K
PiBUaGUgeDg2IGJ1aWxkIG9mIHRoZXNlIGJpdHMgd29ya3MuIEJ1dCBJIGRvbid0IGhhdmUgY3Jv
c3MtY29tcGlsZQ0KPiBlbnZpcm9tZW50IHRvIGNoZWNrIG5vbi1YODYgYnVpbGRzLiBBbHNvIG5v
IHdheSB0byB0ZXN0Lg0KDQpDb21waWxlLXRlc3RlZCBmb3Igbm93LCBidXQgaXQgbG9va3MgZ29v
ZCB0byBtZSBpbiBnZW5lcmFsLg0KT25lIHNtYWxsIGNvbW1lbnQgLSB0aGUga2VybmVsZG9jIGZv
ciBzdHJ1Y3QgcGVjaV9kZXZpY2VfaWQgaW4NCmRyaXZlcnMvcGVjaS9pbnRlcm5hbC5oIGFsc28g
bmVlZHMgdG8gYmUgdXBkYXRlZC4NCg0KVGhhbmtzDQotSXdvbmENCg0KPiANCj4gLVRvbnkNCj4g
DQo+IC0tLQ0KPiANCj4gRnJvbSAzNGNjMDkzY2JlYmFmNTk2YTUyYjEyM2M0ZjhjM2VmMmRmNDVh
MjQwIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPiBGcm9tOiBUb255IEx1Y2sgPHRvbnkubHVj
a0BpbnRlbC5jb20+DQo+IERhdGU6IFRodSwgMjUgQXByIDIwMjQgMTI6Mjc6MzkgLTA3MDANCj4g
U3ViamVjdDogW1BBVENIXSBwZWNpLCBod21vbjogU3dpdGNoIHRvIG5ldyBJbnRlbCBDUFUgbW9k
ZWwgZGVmaW5lcw0KPiANCj4gVXBkYXRlIHBlY2kgc3Vic3lzdGVtIHRvIHVzZSB0aGUgc2FtZSB2
ZW5kb3ItZmFtaWx5LW1vZGVsDQo+IGNvbWJpbmVkIGRlZmluaXRpb24gdGhhdCBjb3JlIHg4NiBj
b2RlIHVzZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRl
bC5jb20+DQo+IC0tLQ0KPiDCoGluY2x1ZGUvbGludXgvcGVjaS1jcHUuaMKgwqDCoMKgIHwgMjQg
KysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgaW5jbHVkZS9saW51eC9wZWNpLmjCoMKgwqDC
oMKgwqDCoMKgIHzCoCAzICstLQ0KPiDCoGRyaXZlcnMvcGVjaS9pbnRlcm5hbC5owqDCoMKgwqDC
oCB8wqAgMyArLS0NCj4gwqBkcml2ZXJzL2h3bW9uL3BlY2kvY3B1dGVtcC5jIHzCoCA4ICsrKyst
LS0tDQo+IMKgZHJpdmVycy9wZWNpL2NvcmUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKy0t
LQ0KPiDCoGRyaXZlcnMvcGVjaS9jcHUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjEgKysrKysr
Ky0tLS0tLS0tLS0tLS0tDQo+IMKgZHJpdmVycy9wZWNpL2RldmljZS5jwqDCoMKgwqDCoMKgwqAg
fMKgIDMgKy0tDQo+IMKgNyBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAyNyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BlY2ktY3B1LmggYi9p
bmNsdWRlL2xpbnV4L3BlY2ktY3B1LmgNCj4gaW5kZXggZmY4YWU5YzI2YzgwLi42MDFjZGQwODZi
ZjYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvcGVjaS1jcHUuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L3BlY2ktY3B1LmgNCj4gQEAgLTYsNiArNiwzMCBAQA0KPiDCoA0KPiDCoCNpbmNs
dWRlIDxsaW51eC90eXBlcy5oPg0KPiDCoA0KPiArLyogQ29waWVkIGZyb20geDg2IDxhc20vcHJv
Y2Vzc29yLmg+ICovDQo+ICsjZGVmaW5lIFg4Nl9WRU5ET1JfSU5URUzCoMKgwqDCoMKgwqAgMA0K
PiArDQo+ICsvKiBDb3BpZWQgZnJvbSB4ODYgPGFzbS9jcHVfZGV2aWNlX2lkLmg+ICovDQo+ICsj
ZGVmaW5lIFZGTV9NT0RFTF9CSVQJMA0KPiArI2RlZmluZSBWRk1fRkFNSUxZX0JJVAk4DQo+ICsj
ZGVmaW5lIFZGTV9WRU5ET1JfQklUCTE2DQo+ICsjZGVmaW5lIFZGTV9SU1ZEX0JJVAkyNA0KPiAr
DQo+ICsjZGVmaW5lCVZGTV9NT0RFTF9NQVNLCUdFTk1BU0soVkZNX0ZBTUlMWV9CSVQgLSAxLCBW
Rk1fTU9ERUxfQklUKQ0KPiArI2RlZmluZQlWRk1fRkFNSUxZX01BU0sJR0VOTUFTSyhWRk1fVkVO
RE9SX0JJVCAtIDEsDQo+IFZGTV9GQU1JTFlfQklUKQ0KPiArI2RlZmluZQlWRk1fVkVORE9SX01B
U0sJR0VOTUFTSyhWRk1fUlNWRF9CSVQgLSAxLA0KPiBWRk1fVkVORE9SX0JJVCkNCj4gKw0KPiAr
I2RlZmluZSBWRk1fTU9ERUwodmZtKQkoKCh2Zm0pICYgVkZNX01PREVMX01BU0spID4+IFZGTV9N
T0RFTF9CSVQpDQo+ICsjZGVmaW5lIFZGTV9GQU1JTFkodmZtKQkoKCh2Zm0pICYgVkZNX0ZBTUlM
WV9NQVNLKSA+PiBWRk1fRkFNSUxZX0JJVCkNCj4gKyNkZWZpbmUgVkZNX1ZFTkRPUih2Zm0pCSgo
KHZmbSkgJiBWRk1fVkVORE9SX01BU0spID4+IFZGTV9WRU5ET1JfQklUKQ0KPiArDQo+ICsjZGVm
aW5lCVZGTV9NQUtFKF92ZW5kb3IsIF9mYW1pbHksIF9tb2RlbCkgKAlcDQo+ICsJKChfbW9kZWwp
IDw8IFZGTV9NT0RFTF9CSVQpIHwJCVwNCj4gKwkoKF9mYW1pbHkpIDw8IFZGTV9GQU1JTFlfQklU
KSB8CQlcDQo+ICsJKChfdmVuZG9yKSA8PCBWRk1fVkVORE9SX0JJVCkJCVwNCj4gKykNCj4gKy8q
IEVuZCBvZiBjb3BpZWQgY29kZSAqLw0KPiArDQo+IMKgI2luY2x1ZGUgIi4uLy4uL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2ludGVsLWZhbWlseS5oIg0KPiDCoA0KPiDCoCNkZWZpbmUgUEVDSV9QQ1Nf
UEtHX0lECQkJMMKgIC8qIFBhY2thZ2UgSWRlbnRpZmllciBSZWFkDQo+ICovDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3BlY2kuaCBiL2luY2x1ZGUvbGludXgvcGVjaS5oDQo+IGluZGV4
IDliM2QzNmFmZjQzMS4uMGRiOGI1ZGQwOWQ5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3BlY2kuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3BlY2kuaA0KPiBAQCAtNzQsOCArNzQsNyBA
QCBzdGF0aWMgaW5saW5lIHN0cnVjdCBwZWNpX2NvbnRyb2xsZXINCj4gKnRvX3BlY2lfY29udHJv
bGxlcih2b2lkICpkKQ0KPiDCoHN0cnVjdCBwZWNpX2RldmljZSB7DQo+IMKgCXN0cnVjdCBkZXZp
Y2UgZGV2Ow0KPiDCoAlzdHJ1Y3Qgew0KPiAtCQl1MTYgZmFtaWx5Ow0KPiAtCQl1OCBtb2RlbDsN
Cj4gKwkJdTMyIHg4Nl92Zm07DQo+IMKgCQl1OCBwZWNpX3JldmlzaW9uOw0KPiDCoAkJdTggc29j
a2V0X2lkOw0KPiDCoAl9IGluZm87DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BlY2kvaW50ZXJu
YWwuaCBiL2RyaXZlcnMvcGVjaS9pbnRlcm5hbC5oDQo+IGluZGV4IDlkNzVlYTU0NTA0Yy4uN2Vh
ZDUzZTU1OThmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BlY2kvaW50ZXJuYWwuaA0KPiArKysg
Yi9kcml2ZXJzL3BlY2kvaW50ZXJuYWwuaA0KPiBAQCAtNzEsOCArNzEsNyBAQCBzdHJ1Y3QgcGVj
aV9yZXF1ZXN0ICpwZWNpX3hmZXJfZXBfbW1pbzY0X3JlYWRsKHN0cnVjdA0KPiBwZWNpX2Rldmlj
ZSAqZGV2aWNlLCB1OCBiYQ0KPiDCoCAqLw0KPiDCoHN0cnVjdCBwZWNpX2RldmljZV9pZCB7DQo+
IMKgCWNvbnN0IHZvaWQgKmRhdGE7DQo+IC0JdTE2IGZhbWlseTsNCj4gLQl1OCBtb2RlbDsNCj4g
Kwl1MzIgeDg2X3ZmbTsNCj4gwqB9Ow0KPiDCoA0KPiDCoGV4dGVybiBzdHJ1Y3QgZGV2aWNlX3R5
cGUgcGVjaV9kZXZpY2VfdHlwZTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vcGVjaS9j
cHV0ZW1wLmMgYi9kcml2ZXJzL2h3bW9uL3BlY2kvY3B1dGVtcC5jDQo+IGluZGV4IGE4MTJjMTU5
NDhkOS4uNWE2ODIxOTViOThmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h3bW9uL3BlY2kvY3B1
dGVtcC5jDQo+ICsrKyBiL2RyaXZlcnMvaHdtb24vcGVjaS9jcHV0ZW1wLmMNCj4gQEAgLTM2MCwx
MCArMzYwLDEwIEBAIHN0YXRpYyBpbnQgaW5pdF9jb3JlX21hc2soc3RydWN0IHBlY2lfY3B1dGVt
cCAqcHJpdikNCj4gwqAJaW50IHJldDsNCj4gwqANCj4gwqAJLyogR2V0IHRoZSBSRVNPTFZFRF9D
T1JFUyByZWdpc3RlciB2YWx1ZSAqLw0KPiAtCXN3aXRjaCAocGVjaV9kZXYtPmluZm8ubW9kZWwp
IHsNCj4gLQljYXNlIElOVEVMX0ZBTTZfSUNFTEFLRV9YOg0KPiAtCWNhc2UgSU5URUxfRkFNNl9J
Q0VMQUtFX0Q6DQo+IC0JY2FzZSBJTlRFTF9GQU02X1NBUFBISVJFUkFQSURTX1g6DQo+ICsJc3dp
dGNoIChwZWNpX2Rldi0+aW5mby54ODZfdmZtKSB7DQo+ICsJY2FzZSBJTlRFTF9JQ0VMQUtFX1g6
DQo+ICsJY2FzZSBJTlRFTF9JQ0VMQUtFX0Q6DQo+ICsJY2FzZSBJTlRFTF9TQVBQSElSRVJBUElE
U19YOg0KPiDCoAkJcmV0ID0gcGVjaV9lcF9wY2lfbG9jYWxfcmVhZChwZWNpX2RldiwgMCwgcmVn
LT5idXMsIHJlZy0+ZGV2LA0KPiDCoAkJCQkJwqDCoMKgwqAgcmVnLT5mdW5jLCByZWctPm9mZnNl
dCArIDQsDQo+ICZkYXRhKTsNCj4gwqAJCWlmIChyZXQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BlY2kvY29yZS5jIGIvZHJpdmVycy9wZWNpL2NvcmUuYw0KPiBpbmRleCAwZjgzYTljNjA5M2Iu
LmIyZDdhZGYwNWJhMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wZWNpL2NvcmUuYw0KPiArKysg
Yi9kcml2ZXJzL3BlY2kvY29yZS5jDQo+IEBAIC0xNjMsOSArMTYzLDggQEAgRVhQT1JUX1NZTUJP
TF9OU19HUEwoZGV2bV9wZWNpX2NvbnRyb2xsZXJfYWRkLCBQRUNJKTsNCj4gwqBzdGF0aWMgY29u
c3Qgc3RydWN0IHBlY2lfZGV2aWNlX2lkICoNCj4gwqBwZWNpX2J1c19tYXRjaF9kZXZpY2VfaWQo
Y29uc3Qgc3RydWN0IHBlY2lfZGV2aWNlX2lkICppZCwgc3RydWN0IHBlY2lfZGV2aWNlDQo+ICpk
ZXZpY2UpDQo+IMKgew0KPiAtCXdoaWxlIChpZC0+ZmFtaWx5ICE9IDApIHsNCj4gLQkJaWYgKGlk
LT5mYW1pbHkgPT0gZGV2aWNlLT5pbmZvLmZhbWlseSAmJg0KPiAtCQnCoMKgwqAgaWQtPm1vZGVs
ID09IGRldmljZS0+aW5mby5tb2RlbCkNCj4gKwl3aGlsZSAoaWQtPng4Nl92Zm0gIT0gMCkgew0K
PiArCQlpZiAoaWQtPng4Nl92Zm0gPT0gZGV2aWNlLT5pbmZvLng4Nl92Zm0pDQo+IMKgCQkJcmV0
dXJuIGlkOw0KPiDCoAkJaWQrKzsNCj4gwqAJfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZWNp
L2NwdS5jIGIvZHJpdmVycy9wZWNpL2NwdS5jDQo+IGluZGV4IGJkOTkwYWNkOTJiOC4uMTUyYmJk
OGU3MTdhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BlY2kvY3B1LmMNCj4gKysrIGIvZHJpdmVy
cy9wZWNpL2NwdS5jDQo+IEBAIC0yOTQsMzggKzI5NCwzMSBAQCBwZWNpX2NwdV9wcm9iZShzdHJ1
Y3QgcGVjaV9kZXZpY2UgKmRldmljZSwgY29uc3Qgc3RydWN0DQo+IHBlY2lfZGV2aWNlX2lkICpp
ZCkNCj4gwqANCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHBlY2lfZGV2aWNlX2lkIHBlY2lfY3B1
X2RldmljZV9pZHNbXSA9IHsNCj4gwqAJeyAvKiBIYXN3ZWxsIFhlb24gKi8NCj4gLQkJLmZhbWls
eQk9IDYsDQo+IC0JCS5tb2RlbAk9IElOVEVMX0ZBTTZfSEFTV0VMTF9YLA0KPiArCQkueDg2X3Zm
bSA9IElOVEVMX0hBU1dFTExfWCwNCj4gwqAJCS5kYXRhCT0gImhzeCIsDQo+IMKgCX0sDQo+IMKg
CXsgLyogQnJvYWR3ZWxsIFhlb24gKi8NCj4gLQkJLmZhbWlseQk9IDYsDQo+IC0JCS5tb2RlbAk9
IElOVEVMX0ZBTTZfQlJPQURXRUxMX1gsDQo+ICsJCS54ODZfdmZtID0gSU5URUxfQlJPQURXRUxM
X1gsDQo+IMKgCQkuZGF0YQk9ICJiZHgiLA0KPiDCoAl9LA0KPiDCoAl7IC8qIEJyb2Fkd2VsbCBY
ZW9uIEQgKi8NCj4gLQkJLmZhbWlseQk9IDYsDQo+IC0JCS5tb2RlbAk9IElOVEVMX0ZBTTZfQlJP
QURXRUxMX0QsDQo+ICsJCS54ODZfdmZtID0gSU5URUxfQlJPQURXRUxMX0QsDQo+IMKgCQkuZGF0
YQk9ICJiZHhkIiwNCj4gwqAJfSwNCj4gwqAJeyAvKiBTa3lsYWtlIFhlb24gKi8NCj4gLQkJLmZh
bWlseQk9IDYsDQo+IC0JCS5tb2RlbAk9IElOVEVMX0ZBTTZfU0tZTEFLRV9YLA0KPiArCQkueDg2
X3ZmbSA9IElOVEVMX1NLWUxBS0VfWCwNCj4gwqAJCS5kYXRhCT0gInNreCIsDQo+IMKgCX0sDQo+
IMKgCXsgLyogSWNlbGFrZSBYZW9uICovDQo+IC0JCS5mYW1pbHkJPSA2LA0KPiAtCQkubW9kZWwJ
PSBJTlRFTF9GQU02X0lDRUxBS0VfWCwNCj4gKwkJLng4Nl92Zm0gPSBJTlRFTF9JQ0VMQUtFX1gs
DQo+IMKgCQkuZGF0YQk9ICJpY3giLA0KPiDCoAl9LA0KPiDCoAl7IC8qIEljZWxha2UgWGVvbiBE
ICovDQo+IC0JCS5mYW1pbHkJPSA2LA0KPiAtCQkubW9kZWwJPSBJTlRFTF9GQU02X0lDRUxBS0Vf
RCwNCj4gKwkJLng4Nl92Zm0gPSBJTlRFTF9JQ0VMQUtFX0QsDQo+IMKgCQkuZGF0YQk9ICJpY3hk
IiwNCj4gwqAJfSwNCj4gwqAJeyAvKiBTYXBwaGlyZSBSYXBpZHMgWGVvbiAqLw0KPiAtCQkuZmFt
aWx5CT0gNiwNCj4gLQkJLm1vZGVsCT0gSU5URUxfRkFNNl9TQVBQSElSRVJBUElEU19YLA0KPiAr
CQkueDg2X3ZmbSA9IElOVEVMX1NBUFBISVJFUkFQSURTX1gsDQo+IMKgCQkuZGF0YQk9ICJzcHIi
LA0KPiDCoAl9LA0KPiDCoAl7IH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVjaS9kZXZpY2Uu
YyBiL2RyaXZlcnMvcGVjaS9kZXZpY2UuYw0KPiBpbmRleCBlNmIwYmZmYjE0ZjQuLjVlYjU3YjUw
M2M4MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wZWNpL2RldmljZS5jDQo+ICsrKyBiL2RyaXZl
cnMvcGVjaS9kZXZpY2UuYw0KPiBAQCAtMTAwLDggKzEwMCw3IEBAIHN0YXRpYyBpbnQgcGVjaV9k
ZXZpY2VfaW5mb19pbml0KHN0cnVjdCBwZWNpX2RldmljZQ0KPiAqZGV2aWNlKQ0KPiDCoAlpZiAo
cmV0KQ0KPiDCoAkJcmV0dXJuIHJldDsNCj4gwqANCj4gLQlkZXZpY2UtPmluZm8uZmFtaWx5ID0g
cGVjaV94ODZfY3B1X2ZhbWlseShjcHVfaWQpOw0KPiAtCWRldmljZS0+aW5mby5tb2RlbCA9IHBl
Y2lfeDg2X2NwdV9tb2RlbChjcHVfaWQpOw0KPiArCWRldmljZS0+aW5mby54ODZfdmZtID0gSUZN
KHBlY2lfeDg2X2NwdV9mYW1pbHkoY3B1X2lkKSwNCj4gcGVjaV94ODZfY3B1X21vZGVsKGNwdV9p
ZCkpOw0KPiDCoA0KPiDCoAlyZXQgPSBwZWNpX2dldF9yZXZpc2lvbihkZXZpY2UsICZyZXZpc2lv
bik7DQo+IMKgCWlmIChyZXQpDQoNCg==

