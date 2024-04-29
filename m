Return-Path: <linux-kernel+bounces-161916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21188B533D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7BC2815D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7EB179A8;
	Mon, 29 Apr 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TMtDghTj"
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7017BA7;
	Mon, 29 Apr 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379826; cv=fail; b=KiESFXqkJ0twAVDI20A9f53DKCpQmntYbLUQi65A8pj0XVCXzQLEgqaPU/UYt/A+b/C3NMsPqrnVSGRoVluoQ9UzEgCZSnHCg39oz24D/qASAfgo25CfwXdVYwIDFYCjU7gHu8bBRxE2gAOtt/I7djRMUsjwf99HBYg0J7pHBVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379826; c=relaxed/simple;
	bh=i29IKZWtgp5ITpNhvB4bdQPwi7r6uDVUVyuRkYelENs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J+eDJkO1yiBrmHMdGeO5B0NguuniQOmQaUb7GsZ1v91Ex8tyh9HGG7PgPvkHGlCbAcT8RBN8R0iLiUvEWOJNmqm3TgE7VhAymJTJbzezuWPYmOXNFwO++ztAYbEfd0PimEDMaFJatBAtaycWjekf/7msy44GyuG1nAUNJDFaxEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TMtDghTj; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714379822; x=1745915822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i29IKZWtgp5ITpNhvB4bdQPwi7r6uDVUVyuRkYelENs=;
  b=TMtDghTjuLd+F9LhOM0L1PQZsKekkSjL4kez/3yNifxnaWzndoWEpLmh
   qGzl0w25FvzpcfTNzf1DQPO7kurjvZXKRwzV7fh5G9a+XGF/p5hoSPVPM
   sy7XgtHsg8PaP1nA4s+iCR578De1BTnmj3B2KfWC5sf6z3E43/HRFtBCh
   mR/hZyx/HTrOP0QreW/QPHrT6pr4AaELVgaXyQYIlK80gm5IpbkyOLgTv
   DwosOGej2uikZtBRQe10dW+WsgHvoWSbVwzRqwhLJgNeBoJSq5ogoO5vK
   WvQcvvc1Drdq8B1EaRbIxGQ8wOFJVX2yTUfBS1q07ZZu9suGNEMNt6j5J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="31136649"
X-IronPort-AV: E=Sophos;i="6.07,239,1708354800"; 
   d="scan'208";a="31136649"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:35:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9NjHR2Og7H694uBfa0JKuS37l4s+mthTBBWjZ5hr8z0e3nkg/cSpYl9c1IsgxxE3nmO9h5tcscCaF+FcWGvE11sy1sGJk/i5HzMq7ifPp09xOhHS5nOjRCKwAw7AMAjg4qwPgQWU5klLm+WpeYahKVXXkQig309vr9l1qRVi3ldjiw/8790cbPV+4eU8ltBF6JW9qG5UoNqCBG+0l7HpBNOjn9St3iUEDr7UhtksN0LRz9gKI8H2NxbTeNYYkI9wNENTN1BMlfl8h6wCq82bDnVDpK4hIltRNVhhFDfYihNzwBOvcpEJ0LAb3mL5qUPzDVyVDnG6/48sNRxn5imfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i29IKZWtgp5ITpNhvB4bdQPwi7r6uDVUVyuRkYelENs=;
 b=Oy5rIBi3yJDsXiZ/PtWr2BoriVjMiQZ/a8MWBD0p4HoNWTPP0Svs2UYtLqTv+8f58zzfkNsle+3tIcDnDAYUf6RRHgVU2VNRaSwCx6jo5EvNyb4rjPG+BRrd0rMffeuWfNpCEQURtS/dEJ8yUBzIdIDmXvP/If8k1L7HoRVgFKxC/1pnWfUK6UbdzPZ/1fC+7ZCEfPZ8+e2ut7nzbLJbu0+Wy3ALWUj+DTlS8iACU7Kqf05DhkfBgysAMgFlU9hdLPLQWrfc8aOMwQ7aUjpu8d/Bcnoq5WAsbre/7cb7NJCrz1S1IwmfxHEIikKh1OpVUGWZm4DioaCcd1zrvuHe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB5989.jpnprd01.prod.outlook.com (2603:1096:604:d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:35:43 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:35:43 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Topic: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Index: AQHamdUJ/baSUL4fTUadXbdXZxcbY7F+7McA
Date: Mon, 29 Apr 2024 08:35:43 +0000
Message-ID: <70eb72e0-16c6-4b8e-94f6-a2bae5158502@fujitsu.com>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <20240429013154.368118-2-lizhijian@fujitsu.com>
In-Reply-To: <20240429013154.368118-2-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB5989:EE_
x-ms-office365-filtering-correlation-id: ef8005e0-7c5c-49d8-a527-08dc68275bcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dy9YVUJhaFd0d3BLMWk0aUVndFF4NjZQZU5idDN5UDNQNTFWaHc0MEtkZGFU?=
 =?utf-8?B?dTNlTitRTGFGaXNWY3FXVzZNWTA5TVNsMVJPRVBacWtxTUM1WmJ6ZzlaSjFJ?=
 =?utf-8?B?dXRRak9mQ0RqTGZPa3RKYkJsMlFDNXBMSXBUNWtDSjl5Y25JUllyWW4wU0Ey?=
 =?utf-8?B?OE5VbStadUttNUZwcUlkbGZQMGNkZGd6QlhRMzV1SzJmMWVIbHhHZEUvSGMy?=
 =?utf-8?B?eDNubWJFR0VjWWJkM3Zma1BveWZoY0xUR08xNGZPOWpxeHNKVHB4UkhaMXBQ?=
 =?utf-8?B?UnIxaXZNRDZtMWxqWE1UUys2QU9PcmkyT0RldDhWV2ZWK3NiOFNhKzNaamhn?=
 =?utf-8?B?Q3JEVElUb3NXRS9TU0J6ODJWd3REbG5OUGJwdFJ4S05IUmRWdlppYWVLclJT?=
 =?utf-8?B?dkVVcklrbGNwZ0ZxaUMyTjdLazd5VHI3dVUxQ2lTS1lBSFlJc1ZjR1QxU3dJ?=
 =?utf-8?B?TElLQWFvRFVIa0o5Sk1UNGNJZVVrRlRkSmREcHVxYy9HQlFxMjdUbTJFRGk1?=
 =?utf-8?B?N212RWJENlUxYjdRd3RLVS9tSFduRHQxdGdwWkxvaHE1U1dsSWxZNi91eUho?=
 =?utf-8?B?cUx1Wjd6QmtiK09kZmJEc3pKUWQwUFNxOEFpTzZlQjBucnREdlNiVkhJZjlu?=
 =?utf-8?B?b24yUWZDRjY0MzlkNDB0bFhCeHBZeXdhbDE0OTJKODlYdDd0K2FPSjMrKzV1?=
 =?utf-8?B?US90YitteWpEUXZFTmlNZnBaa05hVW9DVW95T0o5Uk4zYjYwQmxydjB3MERr?=
 =?utf-8?B?SXdMb0E1S3Z2MENLaXprN0IrVFA2b1hlOURnaTZ2Y2NzL0tkOVRrUnFvcDFT?=
 =?utf-8?B?Z3BheTllK3VSMWV3eml3TkdLYzhOZzU3U08yVVJuR21MVVBBYWpQN1JWT1ds?=
 =?utf-8?B?alExRTFGaGIxWFFCdGtTY3FodTNzMWd2ZWo1WjVOVnFEaDU2UFhZZy9JeWJs?=
 =?utf-8?B?N2xpbW04Ym5nWWxHV24xclJVNnZOYmpvOGRZT3dBQzJXQU1sZkhVNE9IbFI1?=
 =?utf-8?B?TkkyNnl3T3lycmN3dHlHQy9EOU1NaUkvZHdrRmNoNkxscElwU2ZRWTVibXRP?=
 =?utf-8?B?QmRET1E3eWJKWm1RNXl2Q0ZaYUhnaWMzaGZibmpXWCtmeGQ0eDRRazFTTFlz?=
 =?utf-8?B?UTJBMXo1UjNwNVFoSVFLV3B5SUtzb2E3enNHcnY2T29XQ2R1cFZ6YlkyRUxS?=
 =?utf-8?B?aXhlQm43dnBzWlFBV2ZZNS9IeWVJYjVzd2pqblBmQ3BqTE1hOUxrRmY3Ri9F?=
 =?utf-8?B?R1dHenRzVGVTSG0za3RXd2pJQXZoc0JjRTNYRkYzcW9wMloyL1Q2MTRNSmVq?=
 =?utf-8?B?ay93VGZIb3VjRWI1RHBoY2NzMWtEU2pMQlNUR01FdnFaTnhYRDc2RE9FVkJm?=
 =?utf-8?B?aFhPR09vWDRuQWR6Ly9xQXZVZE05VWFHSDFJOElJaWUxZk81NUlFUEY2K2FU?=
 =?utf-8?B?SUZZbXdZeEY4TGpldlIzSUU5MFFmbjRJc1lDTUU3eGFTQXA0ckJCQjNTMTV5?=
 =?utf-8?B?am1EQjliak9FcmpMTGw3L2hrMUtmc3NxSWVoSm90ZGFPTnZjQ01PMmp4bDJL?=
 =?utf-8?B?enJYK1BqMTFRblVlbHhGalZnMVliZWt1d2JDNFFwYXhJNGkwYmdpTVFNVHM1?=
 =?utf-8?B?N0F1TEt3aDZ4a2RYdDNMbkE3VDBWT1h3MnRVOFNNSUR6SEp5K0p2WEJXQytn?=
 =?utf-8?B?VXhUaElxVndrTXUwSUtFVGlMUSthRllML0V3Skp0Y1ExS3paaTdzVjdOb1dl?=
 =?utf-8?B?TVg5NHJXNGQ2cy9NSnZZQlF2ZkUva3BYc2pMV2pzVmZXei9sRUVrdG1QMUl0?=
 =?utf-8?Q?mHcdh0ie3v36sGVAvhfP5A+yQ5ewlqYdvhnoU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlY5ZXRPQmR1MFRvZi96cDVpN0htVmltSmFkTTkvY0ZsQnJ6TUNGeTZRQ21R?=
 =?utf-8?B?MUxNZ3ZsY2NEeDY2VVY5TmhLbzE5THJFUzVtdEpCaFdDUG02Q2tseFhPR0lY?=
 =?utf-8?B?ZzgxanFkNzhsd3FpVFRUNkFoL0FjbkNzdXdMYyt3U3FxWU5CZGIvcjJUWXV4?=
 =?utf-8?B?RWt6QjIremdnc1kwK2p1U0UrKzlObE02UlBaWHNTcXppM2JuOS9aWjJ3cDRU?=
 =?utf-8?B?RnF0TDMvZE50RU1ZdGl1UFpxQ2ZHR1M0aDEwVDBZUXRWS2VNNGI1WUVaRC96?=
 =?utf-8?B?ZkdOTVJDSWxoTmY5MjBYT1N4eVJ6VjhVTlJPTXZYSFRHaURCRnBXYy9XK2dy?=
 =?utf-8?B?U003VlZiVlFpcVJIOXNXc25ORUZla3FDUUdFR1RsdkY1dTQxaXVlRzArY3Jw?=
 =?utf-8?B?UEROdWpkbkxWbnNqcjJzY3ArRzBYelg4S1l2cDZLZUt5cDhzV0hYdmZJNmt5?=
 =?utf-8?B?d1BxZ0RZTWtyWUZMV3IzaXU1Y09paTBEV21NSkxvWjNLMCs4UzJ1akNzL3Bv?=
 =?utf-8?B?N3hxeDVPcCtaU1dqL2RucW1CR29NYlRLR0xMZHMyS0crLzBvK0J2QlhyYk9P?=
 =?utf-8?B?aEd3c3ZqTFg3QlAzSnZWL2VYdXRFUDZxYzhUdFZ6dFA2Z3Z5NjFnNlFtZE40?=
 =?utf-8?B?Tk16ZFhvMVd2cWRMTFBPLzNBTzZFdWJtYXhDRGcrK0IyM3gxQmRKcVEvNFdT?=
 =?utf-8?B?emRRUnR3b0tmVmcwLzh5VEttR0ZTWkdDeG90b1NNL2tDUDJYYjRiUFlHL05q?=
 =?utf-8?B?Zk9zR2RyeFNPam01VDV6VFNSb2gvbjZlaUt3YUxwNlhobEtxTHBCb2w2UWto?=
 =?utf-8?B?a3pmQ3JLUkdTbzR3aTNPYmNPWWdJQnVHdlRqbUh5OFovTHRGcjQ4VE1oYnpB?=
 =?utf-8?B?NmVrMm04Uk1UdDNTYzVzOW11NXF4eEoxUHRQYkphNXJ5SnA5QVByL1JzTHFp?=
 =?utf-8?B?K3ZGRjlHMVU5S2xGRjZzeGh0eHFXdlkwSHZpUWtKUTA4YytvMUVxbDRoR1dB?=
 =?utf-8?B?NE9CRUF5WUt6VG5ZM3NNb2lZY0o1bUU4OFhJREFOdUw2ZlpIWXFEd0t6VlVV?=
 =?utf-8?B?OElxNjlMMkcrcEFHOGtVWm5MR0wzUSs3Ymc2THdyelA2R2x5VU51VG02SkdX?=
 =?utf-8?B?VStPNStXaVdZSElQSXNKb0l1eS9mT3Uxc3Y2MFk1UTNBMTJGYlpQQXlaOFZB?=
 =?utf-8?B?ckhaeEtkenQ3cE5YeWl3cEx3N2hkaUhyMGQvOUx5VWVQaWxsbm01aXlNamkz?=
 =?utf-8?B?TWRUZ25VR2pDTms1aW5FbkxUeXdqd005QkprQXB1emo1QXVQeGMycUoxc2dy?=
 =?utf-8?B?Mm9qQUw0a0c4VVNPNk15K004Rm9BQndMRHh6dmJ6OWI2cVE4V1htM3JkbHJU?=
 =?utf-8?B?L3ZYNGFkZk15d2Rta0hTcExrMDRjTll3S3drbWZManp0RXFLR05USGRIMWpF?=
 =?utf-8?B?RlRLL0IxRTE3UEwycTFsRWEvaXFjamtpNk1nNkFqZHBJejZjNmZNZi9nTEVK?=
 =?utf-8?B?bE1YMy9oODZ1eHdXQ1YyWDFvM0F3MEJiUUJFY3dHOHRrU2lzQUU2QmF2ZjJa?=
 =?utf-8?B?SXE0NmtJNlZ6R3JVRWxRME14aWYvZVBiRzdyaGxOWVFyalQ5aXlCNlFOVkdh?=
 =?utf-8?B?Qk0yTkg5bFV2WkxZKzBJejErY3VTVnlQaWJEdEpheFQ0SE5PQ1l2ZTFES0kx?=
 =?utf-8?B?Q1Jpa0ZZbm1ZNXpPYkhmb1dGTUNGaWhWYWpsNjFYbTZIK1NOQ3FoYko4b3Fl?=
 =?utf-8?B?OTdSUktOM2lHeGRqS0g3UUdkMUtwc0RManp4YjRLL0hYdEF1V3AwRmwyRTRq?=
 =?utf-8?B?MnBFb3RyTkNMbWJwWCt3RnVkZDdZM1F5VGkzaDdlTituc0V1QnNhQ1krT2RB?=
 =?utf-8?B?ME5RQ2lYUVBhb293SWZQUkVRdzhGS1NGRmxJaXU3WDM3WXp2QUpOSFhoUXlj?=
 =?utf-8?B?UnpORGVjTHZtUHR5ZlpmaXJkekRrT01VdWRwcmlhZjJwRiticzM1a0FYN2JO?=
 =?utf-8?B?UkRqemZsNEhYd28vYWtnZVRuaGdJczJNalNzSVpUaEFaanBLbUloeWRTdnhp?=
 =?utf-8?B?MGFRNHlYbXdLTUYvNWpIUFUxWEczRi9XZ3lkYWdIblE2aCsxZ1oxR2kwMHFQ?=
 =?utf-8?B?S3ByRnh0Mnd5Szd6U29RdVFuMklpZHRWN0ZRdkJ0Ujdnb3NVcDJjMDdocmJO?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7462C8DBED9C8D4CB5B572BE7A97F108@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uc2dqMENeWm9bpyVUfTqho8BNH6kChbgFXrqNRMOYpYBzCAOTimzp3RE4xRsk7qpNwLgpm1HSg+01Nc2qP88Gqh6Pj5D3TOE6xls43VXrNrdGdXPJnC4fkr0M2s89sVzTBsesaL+Sh7UuCF3je21AN7yspz+zWI4Yy+ZClwxuHRwAzAre06R3tx8bpFcSZAcHi5cXWnyc6OvGIfk9Hwjot7xF5P+gEGp5CJsK2D+paRDUqgJoIiYjTNCr7cQXNJ9xJUMBGAEAHKdaNM96ORyUgt2eT/+oWgeGo7Nf2VrU77cFaO1+dPYBwoVE1vGOSjnhZX4UE4539GBNsKJURokje4BHf8ZzSZqgoXoq5qfs/M2AjbV6QaiqQeWx/68RyAAWEASMVozNZRxTffDC2VWO8Gw8On9fgYSHyY1ZGNlEY/yej6sNW8R322sQ/mxhSaoKylqcRmET0RMtpaUoqKsE0aeb62wKaB3dBdLTWezLeOK4CTT9uJbRsnmNLEY9sQ52yLhwX9Mvtp+sWm0FQ9fyxZMglBBd7ytiZxeYPOv0UR4krPEkObuBfpIzUITqpbZnLdiVHa9Nr4RGKTprStvit23Ng1qFZmqlIHgcDP57aM7h38/28LUBo7Y5/mQRb5w
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8005e0-7c5c-49d8-a527-08dc68275bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 08:35:43.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4m7M8rbC5XDI1yawypj9k5hvuBuaPlJg4srL/6tMdKev7u8xRIuR5QZuuRffq3LvIKjbm+I9EI+H84J7t7B0sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5989

DQoNClRCSCwgZXZlbiB0aG91Z2ggdGhpcyBwYXRjaCBzZWVtcyBjb3JyZWN0LCB0aGVyZSBhcmUg
c3RpbGwgYSBmZXcNCnRvX2N4bF9yZWdpb24oKSBjYWxsZXJzIHdoZXJlIHRoZXkgZGVyZWZlcmVu
Y2UgdGhlIHJldHVybiB2YWx1ZSBkaXJlY3RseQ0Kd2l0aG91dCBjaGVja2luZyBpZiBpdCdzIE5V
TEwuDQoNClNvIEknbSBmaW5lIHRvIGRyb3AgdGhpcyBvbmUgYmVjYXVzZSB0b19jeGxfcmVnaW9u
KCkgd2lsbCB0cmlnZ2VyIGEgV0FSTiBiZWZvcmUNCnJldHVybmluZyBOVUxMLg0KDQpzdGF0aWMg
c3RydWN0IGN4bF9yZWdpb24gKnRvX2N4bF9yZWdpb24oc3RydWN0IGRldmljZSAqZGV2KQ0Kew0K
ICAgICAgICAgaWYgKGRldl9XQVJOX09OQ0UoZGV2LCBkZXYtPnR5cGUgIT0gJmN4bF9yZWdpb25f
dHlwZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICJub3QgYSBjeGxfcmVnaW9uIGRldmlj
ZVxuIikpDQogICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQogICAgICAgICByZXR1cm4gY29udGFpbmVyX29mKGRldiwgc3RydWN0IGN4bF9yZWdp
b24sIGRldik7DQp9DQoNCg0KTGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCg0KVGhhbmtzDQpa
aGlqaWFuDQoNCk9uIDI5LzA0LzIwMjQgMDk6MzEsIExpIFpoaWppYW4gd3JvdGU6DQo+PiAgICAg
ICAgICBtdXRleF9sb2NrKCZjeGxyZC0+cmFuZ2VfbG9jayk7DQo+PiAgICAgICAgICByZWdpb25f
ZGV2ID0gZGV2aWNlX2ZpbmRfY2hpbGQoJmN4bHJkLT5jeGxzZC5jeGxkLmRldiwgaHBhLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hdGNoX3JlZ2lvbl9ieV9y
YW5nZSk7DQo+PiAgICAgICAgICBpZiAoIXJlZ2lvbl9kZXYpDQo+PiAgICAgICAgICAgICAgICAg
IGN4bHIgPSBjb25zdHJ1Y3RfcmVnaW9uKGN4bHJkLCBjeGxlZCk7DQo+PiAgICAgICAgICBlbHNl
DQo+PiAgICAgICAgICAgICAgICAgIGN4bHIgPSB0b19jeGxfcmVnaW9uKHJlZ2lvbl9kZXYpOw0K
Pj4gICAgICAgICAgbXV0ZXhfdW5sb2NrKCZjeGxyZC0+cmFuZ2VfbG9jayk7DQo+Pg0KPj4gICAg
ICAgICAgcmMgPSBQVFJfRVJSX09SX1pFUk8oY3hscik7DQo+PiAgICAgICAgICBpZiAocmMpDQo+
PiAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4NCj4+ICAgICAgICAgIGlmICghcmVnaW9u
X2RldikNCj4+ICAgICAgICAgICAgICAgICAgcmVnaW9uX2RldiA9ICZjeGxyLT5kZXY7DQo+IA0K
PiBXaGVuIHRvX2N4bF9yZWdpb24ocmVnaW9uX2RldikgZmFpbHMsIHB1dF9kZXZpY2UocmVnaW9u
X2Rldikgc2hvdWxkIGJlDQo+IGNhbGxlZCB0byBkZWNyZWFzZSB0aGUgcmVmZXJlbmNlIGNvdW50
IGFkZGVkIGJ5IGRldmljZV9maW5kX2NoaWxkKCkuDQo+IA0KPiBTaW1wbHkgcHV0X2RldmljZShy
ZWdpb25fZGV2KSBpZiByZWdpb25fZGV2IGlzIHZhbGlkIGluIHRoZSBlcnJvciBwYXRoLg0KPiAN
Cj4gRml4ZXM6IGEzMjMyMGI3MWYwOCAoImN4bC9yZWdpb246IEFkZCByZWdpb24gYXV0b2Rpc2Nv
dmVyeSIpDQo+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCj4gLS0tDQo+ICAgZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8IDMgKystDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lv
bi5jDQo+IGluZGV4IDNjODBhYTI2M2E2NS4uNzUzOTA4NjUzODJmIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9u
LmMNCj4gQEAgLTMxMTcsOCArMzExNyw5IEBAIGludCBjeGxfYWRkX3RvX3JlZ2lvbihzdHJ1Y3Qg
Y3hsX3BvcnQgKnJvb3QsIHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQpDQo+ICAg
CQkJCXAtPnJlcyk7DQo+ICAgCX0NCj4gICANCj4gLQlwdXRfZGV2aWNlKHJlZ2lvbl9kZXYpOw0K
PiAgIG91dDoNCj4gKwlpZiAocmVnaW9uX2RldikNCj4gKwkJcHV0X2RldmljZShyZWdpb25fZGV2
KTsNCj4gICAJcHV0X2RldmljZShjeGxyZF9kZXYpOw0KPiAgIAlyZXR1cm4gcmM7DQo+ICAgfQ==

