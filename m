Return-Path: <linux-kernel+bounces-161906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B348B531D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7998A1C212FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0934175A6;
	Mon, 29 Apr 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bb1HYU1u"
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC585C2C8;
	Mon, 29 Apr 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379264; cv=fail; b=ACwxISKUjhKtR5xIYhA9mjCxZQlx6Uey/HNbizYQGfOdY3u9W395BRKTG2WqmXE63sYjrwUZE7vdLUgA5R7w0ihrYCwTBlcZIPfPcKo+KLC+dllb+lwVBDHyGKHgX/oz/laHmpjjzlDRmp7FSj7LM37F1jG5uLA/VXe8MN1CGhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379264; c=relaxed/simple;
	bh=5cgNiMuFnrBi5mGqTatWwMgZDOUbFey2mJbhEqiyt8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLq6BgUh5R9AXzsBuwj08K1OYjJgXnnZVjuk4ADZkqzCfpnTEOmDUVQ3HeV9Jm1SdAjlkEFounXqUsng3lo9ELvlzpSADsTjLu8aEjRd4636fwR5YE8YR76jNK44j6qmNRBGiIxIJtiEVmEDFGj13uQuwVb+Lb4cl/LpjaVf1Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bb1HYU1u; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714379260; x=1745915260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5cgNiMuFnrBi5mGqTatWwMgZDOUbFey2mJbhEqiyt8I=;
  b=bb1HYU1ucNEEKajZth6rjftSQ3nljSi7CTmyvOlMJv15pGwiiehz1MCj
   z3NozqrKaszY5QLjAkrhnPi/HUKLMOFMevPuDvHNBcyTrXzdligBWVweV
   qwoWKLphEvXoKdD7dPSNP5zIvlUkMxg5FFxwzrHbm1Hd2ncCJYCf9EWmW
   PbPqnSmP1GUcMpWAl3bx9FZhL3rFHZk3fS31QlTZI2SkO7l9rb/EX1snp
   YDGDu2C1sHqKpvcoklD/S119G37VBmvp3EbpW5l0fEcyCo4q1pGAVOECV
   K+iIc2aX+BhiSwyx1d3wxAmC3K0BLjhTnvPX400F3lxGVnnMxUYPtdpdb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="118104616"
X-IronPort-AV: E=Sophos;i="6.07,239,1708354800"; 
   d="scan'208";a="118104616"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:26:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUBuYu+v55Db8DZ1UE459jqxA0+sjGr6CqEq6aFQkL//CeetdpJx0ji0pj5779S0ljhf8TWAPGKvreeWBAyiaSHZzp4AS0MsNin6WmrYuKMxSn5akkfS9HxalcQrpPOG8Kt+sPWRkcZe9gWp8t4sZiPp0T+eJvyJTw2t7gg2RlpDrbJLUUZSNsd/tKL2ME4paFpP3xVcI7N+NgN7R1u7WqGKMk9Q5nBpAQbZkdOuFyx0yZ/IUXsZcsgnnASErK6zEz2zfBXqwjJyLKQR8oNKxbFOarSoIvafBYUCEmwmzZKHA5bfhQt2mxrWOQ+JxBVZWMvm4Ut3MGpui2wfmWkEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cgNiMuFnrBi5mGqTatWwMgZDOUbFey2mJbhEqiyt8I=;
 b=jbPcEyVxxLQs+2N42FE8MMxXXX8GmKjbjJiW54okPMlV3vtsXdsm2Lip9hie8I0AvgNbbJyyQYo/LzEWIF79l8QZ2Fj6uyorfU9gkBjh89pCZiFCdgdF1tKn7k9N+O2w2CjId0UXdSdNirVnLQeC5irUkxFUKMdrPK0HF1koO448aFo87FG6n3ZPFgyes/qgZZnnKxn0zAl3Ikx5xoyvNQyfVzf6C+L+zshPjSZhwIQD9iidl/YZXNv2J2Ht3beUC9/egTnR0Oj4PQZQDE8ILHCPGMiWMTihSEVCVVKuUFU9b8Vf3vvmVJviRt8SwxKTEmdvSXgt/d0wUZemTPLBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB6646.jpnprd01.prod.outlook.com (2603:1096:604:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:26:19 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:26:19 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Vishal
 Verma <vishal.l.verma@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Topic: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Thread-Index: AQHamdUJ/baSUL4fTUadXbdXZxcbY7F+4uMAgAAHQoA=
Date: Mon, 29 Apr 2024 08:26:19 +0000
Message-ID: <2ea9506e-4be7-48a2-bcc8-4ae543a7f1b5@fujitsu.com>
References: <20240429013154.368118-2-lizhijian@fujitsu.com>
 <bdfa663d-9a00-484c-80f7-75d7fa130cd3@web.de>
In-Reply-To: <bdfa663d-9a00-484c-80f7-75d7fa130cd3@web.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB6646:EE_
x-ms-office365-filtering-correlation-id: be76f5da-dc55-4915-e483-08dc68260b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|1580799018|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2VKaG5RekFCU3kxejc2ck9iekR2Lzh4eUZ2Wko2bWhudmprTWZvWGVueUpn?=
 =?utf-8?B?d3ptOTJndG5Jd05QamVJWVlveVFWZEphKzFoTHowQSttTW42RWh3ZFNMeWVp?=
 =?utf-8?B?cS9tOUFYVjNXZEtIYUtYSG80WjgrY01XZllQTXppajVTU2MvU2VXUUV4T3lH?=
 =?utf-8?B?UG1KRHZDQUU4SXlWYTg1QkdWMjJMdHhIZXM3UEpjNmdOZmMxc0NqQnQzcjN6?=
 =?utf-8?B?YXNnenZXWlErNWRkamZiQ3NqSGNPcTI0SXQwUnNsZmVOZnNKMEd5blBXMHIv?=
 =?utf-8?B?WTQwcHRKRHliV0dVbmdUaDVPZWlPSzFBT0JvUXRCZGsydkIzS1JsdXNnYkNC?=
 =?utf-8?B?LzlLL1RlZWVod1JWK0NvUVZlaWxKOWJsR0htK0FVVTlPZmxGZnZqWEN0VmhN?=
 =?utf-8?B?RElSTk01cUpiS3hITWhxdHFsR1lEOFNMNlpNOEZNVG5aNnU4V2VMZjNnUXFO?=
 =?utf-8?B?LzdweXErYkxqZnFuSVk3WDdpb3YvRnBQSEtqVFdxU3p3NHNBZFh4cm1SUkVq?=
 =?utf-8?B?VUZseHJrS1JVclB3UFdZQmRaQllNd0t0V091UHc1cERhamJRWG1KcklhQ01O?=
 =?utf-8?B?SFpSb0pSZkJRVGk4TjdURkd6WXJuNEhRWDN3QXlZb1JESmNiTGRlbW1xcmNO?=
 =?utf-8?B?ZVozdHMvOStmd0x0NU5JeHNLMWVEOFY1QU1telB1TUNxOGs4RUtaZG5lcEpv?=
 =?utf-8?B?bnd1c1hDL2k3UFhQZW5HNHJPUUgxTlRtTVFQUEhweGJiMC9vQmFpb0R0azhQ?=
 =?utf-8?B?WTlBZjRXS2UwakQvYjgyVGN4elFBcnlZY2VQTjE3eGZlTHZqZ1VTeHJEb2Jh?=
 =?utf-8?B?MUZ6RWhXcmVVb0s1Yy9UQUErLzVGUnlGT0J6RzJjcXJrM1FlSGJTVjBjc21P?=
 =?utf-8?B?T0FBaStsenZuWEpKNUpzVExJTGZnanFBRVVZWFRyS0kvNkRsajFGYlUyMTBm?=
 =?utf-8?B?ZGtwaytoeXJPTW1JaFpGSTVLZFhJdi9FWW4zSEJPZ1JYVk9KVWxNaVhwcmtK?=
 =?utf-8?B?VHR4bzFCcUpyZmxHUEd6M1NDWVZKam9wOFRaQ1YzUnVWM3QvbUk2SloyNFdW?=
 =?utf-8?B?K2w0VjVyNlIwTlBsM1BkaFQ5UWJIVmpJVDYxRUphWnBhWTVwNC9Kd0xSSW93?=
 =?utf-8?B?WndJLzhyZ1BXUldjUlpyQjJJb2JOZHIwWGlLOTNJaFBIdC9GbmdMWW5VTVZC?=
 =?utf-8?B?L1BpU0lRdnc2RmJvVjhyWXhyWXdENGVyUXF4blFUQVIwaE0rQWQwNHM0VDV6?=
 =?utf-8?B?Mm12anc4d2p1YnRzUm1jQmJvZDRtcmh6bUozcHVpWVNPRUdmWHZtdUhoMkdp?=
 =?utf-8?B?MTk2Nm1KR3lFMUY4NzcwajBUYU9HS1dvSm1ER09VNmlDUVluOXlNL0RYWmly?=
 =?utf-8?B?cjZ1N244TFZDYStXZlRUbkEra20xSHdCcXRyYTI4MEFaeXJoQUc4eWI1bEpO?=
 =?utf-8?B?Tkk0OXVibGxiVXNvYkY5R1EvcytzZ3hXUTh4VEh3NngycW4wQTRvSzB4SDla?=
 =?utf-8?B?bTNpeDY0RnNzUlZuSjNIekxQdGdXb2I4Q3dKdE0xT251OTZHWEJ3cXJpaXZO?=
 =?utf-8?B?eitkYlNUUTFPdVEyQ2NHRTZsL1QwZENMYnlTVHZkU3NVQnBrRVkwZC9zdDJh?=
 =?utf-8?B?QVVFZ1o5MmpMc2o2a01KNnFoTHBpRUJ4MHdTaHdQVm5OM3ZIS2JXWFFLUy81?=
 =?utf-8?B?YndjWFZBWWM5UUZvUmUvckI4UW50ajViMUlDbmNrV0xOWklwcUZyVHNUUHRz?=
 =?utf-8?Q?8psqx68moBZtasN+bDkJ4bHj7OtNRDhQxc34Sam?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(1580799018)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG40R1V5eW9TMGZ0T2NjN3hIeFFZaGpNd1Z5VFlqVU41aHkyNUJnQnpvNE5S?=
 =?utf-8?B?Y011cDBrSUlVY09XQ242dkhTdW9iWTNhVVQvZmtPWlVPM2RJSjFtcitqWTRp?=
 =?utf-8?B?SzVnRFdPaXpzMHNFaTVGa2xyOFNKeVBzZEZXQy9FYVVhUWRLZ1c5UU5ZWUpJ?=
 =?utf-8?B?MjQybmo3RER1alpXWTdDNGw3WlRGZDJDT29ndWQybFY1U2MzbUkxWEJHVWVj?=
 =?utf-8?B?VkFXZ3QxZm9oTUhOZXJiS1Z1OTA5VmxFL0Y5UjVGT1JwQytRenBEMW9XY1ZD?=
 =?utf-8?B?VjdVNi9oYTlqTE1ZSFYzeGxWWkdYZGZFQjgyT2I5c2xiRk54MmFyTEovSVdq?=
 =?utf-8?B?SEJsc2E2aksyUzZWYVdvSkxIQnR2WDFDM1JDVTZKSTladWhVWUpTMTcrcXQ5?=
 =?utf-8?B?azlWcjRTSTdtdENCSU9ST3RWOWxCVkRaSDg5eUc5bFRTblFVL0FSWGZpVGh4?=
 =?utf-8?B?VHNPRkhsODVNT2hMZ0ZFNllkbHlwa0VjYXgwT0o5bGNScGM1VnBZNTMzTlhh?=
 =?utf-8?B?SDRCekppM3hqRTFKZzdwcjQrWUgrS2RZZ05uZnlJUWxzenJTSUxHTENGelJ5?=
 =?utf-8?B?RDJhNUhTVUF0Y0VGc3hVQU1CQmJta1l5MVpEYUl5Ui9uRWd0dGpQWDFVdFFO?=
 =?utf-8?B?Q0F5Z0FzNFZJTXlBelFvbTlqV2JQNDgwSHhmcm9KdmR0RCtVZWdyN3lDQkJy?=
 =?utf-8?B?Vk5jbllLd0k0ZTcwQ0tjNFhGM2FUTS9vY3A4QmZRMmZoNFZDMnJDZGhmZFhq?=
 =?utf-8?B?M0hKSExDVTNqNUtHcms4NEhLUHd6N3lQaERPVUoyUTE1NElSVmhvR0x0dG9R?=
 =?utf-8?B?SEtaNTJtSGRWemswZTAwNXU4bHFiM1FpL2lEN05zUUVoNittRnRLaHpxVkpo?=
 =?utf-8?B?c0pMQUs4d1JXSWE0eEsyU2VBeTV2RWxDdjFFSVQrMVdXUFNCSzFLOHFaaVNo?=
 =?utf-8?B?YmtHLzU2cjVZNkpaZ1BTMCtKZ3JOeW52NW8wNXRpdFFvY0prMGhaQkdodzFN?=
 =?utf-8?B?UVI2V3cvcEdXNnlCQzNRNkxQcmNaUXU4Yk5VU3EzaWlZN3RYUDIwa3hvTXBi?=
 =?utf-8?B?eG1OSUlrNGdwMjlPRGpwL29OTmdPOEd2T2xTdm1yMUNJRkhTODJIVStzaGVk?=
 =?utf-8?B?RHJiRGp1L3dML0kyV1BmRnFSVGYyVU1oQXJzLzhuU2V5ME1GeTByNXZkZ1VN?=
 =?utf-8?B?eHB6UmxqRi9NNVVkYTBxYlJFcXAzTHI2MU5WYmNaL3NvK2hzcHgxbGdLbFA5?=
 =?utf-8?B?bUVwZExhVVVsajA5NXlqWGRDM25nVVdXR3VDM3pzYkVJUFdRSTRJOWpQMnQx?=
 =?utf-8?B?T09rV29sY3p1L1JFS0txcTlNcnRwb0puWUFIVXhldlo1WXBVdE54LzJxMTV5?=
 =?utf-8?B?Q3RsazlUdDJmOTdidmVzeHFlb2txZWxZRUlUdFFCSkpDNTBMVVdHdmRDSm9S?=
 =?utf-8?B?d3RuTzNKZ21DbGtKUGlBcWRGZ2hsandjSitGRThlVmJ4TXNCM2d3aHVKeEt3?=
 =?utf-8?B?QXZTVGU0L2NwZnhQeURsT2k1eGxtVkVyb0tQMWd3ZmxMbUhzeWFhbXNFRWdH?=
 =?utf-8?B?Zk9Ld3JnTGZ5MGhlYVd5aldhTjF3RSs2TGs2Q2pkWHdiS1l3V3NQQzF0RWt4?=
 =?utf-8?B?dm01eWZzN29JT3phN0RaT0g3dkZTMnpwQWVXL2IzWHA0Mlk3TUhRZ3FGUHRS?=
 =?utf-8?B?S1JSM2RBM2lrczM1MUh6a2dSejRZSHJPUmU0ckJUamF4SVY0eGhvYTNRQWxS?=
 =?utf-8?B?ejVEam1Jck14SUc5b3REd0V5RTlLcVovMWdka1dlVkpjZVdieDBWNWhrdlgx?=
 =?utf-8?B?VGVlb3Y3N3Q0dFVVTTQxaWdmdW11VmpwTTYyYjJZWTRmUUlTUnlIb0NnSElr?=
 =?utf-8?B?dnM5ZnIwMnllZzdNblR2UkpFVnczUmVHakhTNDBJQmFnUEdsVldJM2NiVWxl?=
 =?utf-8?B?Nk5JdVNkTzVPUHRpNU5nc1dCeTJ5Z2luVHFWNGF0aXVnbFN2cDR4SUZkTEc0?=
 =?utf-8?B?MDd5L1I4cy9xaktZMnkwY2tNbldmOHBsMk40OHFkM1JVcS94d2ZZTWhMQkEv?=
 =?utf-8?B?cW12cUJzMFVScFhmbGZtckFibHllKzBWSXhpSnBNMW9TYmlYa29CQlV4eGRU?=
 =?utf-8?B?ZlZBSFlWUzBPVUxFcFg4c0wrNjdsWU5MMk43QXpPdlhtdjJOUENTQTF0U2VG?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2036A0960CA98C4E82B9D71AE77383A6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9rUi1bGYQSHliCUnB92hsqAJj8gCRfNwVnnoB7nXKEHv68xAv+m2NJjWV9WPWw3qX5SUpL7WJqZaqJh/zP5uxbF0CE3TCJ+qGvAMKLRC9LX/psqL/m4beZWy5Gx839Qa19ewwvHyL1PMLOujzT/OtYsj0dKBJvo0qBlBhQjUJCn4xKb4BPQ5c/ypWscMk0RAY72kJ6HjHkU6u6GGH1lygluuG7YxXW6CYz8nBeQbJk1sXDiMznLQyvrh0tVditgJ2fGi2CQ/ynbo4zyQRPTbedJ3S9cp4raiw0t0F0lT2WmjitWMoA7aKcT8HuGlq/hwTDvQKMLnCdz7yKeUUE9Ik6T2pVjzy735jsoVz9sDCNXWECoHu2bWb+fGM0yLyyX5pr9L5TVMbSoDqsMbk72RobswNEghw9XqTw5cdTY1xVTdd4Xu1nudtl46wflKEs+JLAF/k4lHtKLAGyAbya+cTi3025+ldN/RCqh/TcvxpNc8sjELo+ZhP+fXrdwSpfrVsqiupLnH5lacmRMSN5Tw5ABvchcAj85hhuB+9taWPX6ejbO2oSRokMZeRZbsbMguAz5i+cS4hsQBnYkWtT63TnM0h7kuSK81PBiNsN+C1+Am/0BxXlIrem/QdpdcWDmr
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be76f5da-dc55-4915-e483-08dc68260b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 08:26:19.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNJ/PAxOvp1y99qrxCGUeXU/d9tda8ski9FNWaaz1dly+DWs8yovojOnVKFJtGCMIbvizMZovuOB0r1K22fNEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6646

DQoNCk9uIDI5LzA0LzIwMjQgMTY6MDAsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiDigKYNCj4+
IFNpbXBseSBwdXRfZGV2aWNlKHJlZ2lvbl9kZXYpIGlmIHJlZ2lvbl9kZXYgaXMgdmFsaWQgaW4g
dGhlIGVycm9yIHBhdGguDQo+IA0KPiBQbGVhc2UgaW1wcm92ZSB0aGUgY2hhbmdlIGRlc2NyaXB0
aW9uIHdpdGggYSBjb3JyZXNwb25kaW5nIGltcGVyYXRpdmUgd29yZGluZy4NCg0KWWVhaCwgSSBh
bHdheXMgb3Zlcmxvb2sgdGhpcyBwb2ludC4gdGhhbmsgeW91Lg0KDQpUaGFua3MNClpoaWppYW4N
Cg0KDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBh
dGNoZXMucnN0P2g9djYuOS1yYzUjbjk0DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXM=

