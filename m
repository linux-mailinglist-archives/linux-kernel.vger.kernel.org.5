Return-Path: <linux-kernel+bounces-162051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5C8B5548
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C76B22844
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1D3A28E;
	Mon, 29 Apr 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="i7svhM+g"
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDE2940C;
	Mon, 29 Apr 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386418; cv=fail; b=lBJweor6aKEvYkzl3cHukuHPxC4+wbINBQ4jqsiteL7TPQvRsTE4nwP9RtomQFw/hy2lFPZxl8lghft+rOxSOv162t1Ivxh8mz9kzeC01+R6ew80pzbMMfzKrvo6oXddJXq+TZ5xQ2Doekj66rdXcU6Mc+HLvXSFxaDQZigqALc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386418; c=relaxed/simple;
	bh=ZJhvFnqYQDolVW+AVtWsgxLMDca/9muDkYDmMFoAvNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnUpAMbwp+EsBnDM9m2KzFoiWd6I6jrrB6d5ydmrhGyA2GgVtN5XEq1mbWe7ZjUHFe2yglAQNkeRvn//NQ+C475+4unQVCjs3ip+wRHIu08xwQr5YIz7bLguHROHbITahjpakznUE8ssFgpOTHEjaoD6ge5gdADazL4mBYXF2Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=i7svhM+g; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714386414; x=1745922414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZJhvFnqYQDolVW+AVtWsgxLMDca/9muDkYDmMFoAvNg=;
  b=i7svhM+gFznvuTzzayJz/5TYrVHkcuiuY1+fnO4FNqdLvi5CKDNFk9WG
   XgwkILaT+22+bU2trxonLICmJX5o+YnzNp377JAWpXA5jb9FbDRbpJPH3
   mEHjIk27XMm25JeUFqi1KASe/Qru+ziTQyThdpJJI+4LQXHzjuzK641k4
   5pZjHQTy/wzCcF27erAkBeqabsSDWxXLw3GKGYkaNyT7pWwekmNkSXLlJ
   aKWqLGP39mcIUTAKuZGdIx4gP5sKZ+CkiwYvZhU5u6jGixM6QlFGfwk/0
   iUT5Wc1kp48PHxrsihF80z/gLLxdElrQZk0v4NHqxVRK4aOb1R9PQNS7V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="29305768"
X-IronPort-AV: E=Sophos;i="6.07,239,1708354800"; 
   d="scan'208";a="29305768"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:25:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5h+pgqJNxbyNal4QH7EWoyWflb5GKyNXTVYd/t/NrGvWZYpSMycuieR2SCNH2DxeEek5q8u7f9IqnHVDpZ2a6eFahV/J3iqanNnQ1jXEMjyUd/CRcHyZe4aQEe5wFBRFNxH7lhvC4Jr8dTPhC7ee4MZ1+dXsjB01CgPUcqjaXlMAY3hQfYXEDQz4XXmXMH/+Yp75RbidKUHT7G63xOn/dm82nkcQ7dsYGi783scUZm0r1MKQ70Z/hij/1KUeZIk/YM40vEHRuMfL23EmeCWp1QvjKXzC2pw0rCsAHxbxk7oJdhpLOXFc08oNjNJKZqBdLEKiAwXe76Hlx9GX1lkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJhvFnqYQDolVW+AVtWsgxLMDca/9muDkYDmMFoAvNg=;
 b=ZRC3F5zUuidCf3htRyOW5V8zH1UuDPF3rTt5426ch3y/lgZU/0yITIdnAnBVg0VNO/QUsA+iLGb4Jt/dGFtgAOKziZwCwRUUl00FopmAkOvoNyAJIDPyCQvKlzRaHsCtHxFDy/Ox0Qrae+kWmeUE29MHJtwxAtvLACO+9zd9hCe0xZrvQ9oxHSF+JRI4y9bSmBb21KN5pZp3hl0dCM1/35L+NL3AG6VXi2NDyGLyZuAg89c6ZgO+5lkdThLxeqAHTDMlXDpnWpWIb/gAik2qHFuCNEMpO79tz9TaazTD+OxRI9+wKUeBl15bKo06wBrCHM6lPHvTAebc8iyXHi3EPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB10138.jpnprd01.prod.outlook.com (2603:1096:604:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 10:25:36 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 10:25:36 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Thread-Topic: [PATCH 1/2] cxl/region: Fix potential invalid pointer
 dereference
Thread-Index: AQHamdUJpJYyJtkDbUeNFeBCzHKRtLF/B10AgAAEHAA=
Date: Mon, 29 Apr 2024 10:25:35 +0000
Message-ID: <576dccd9-1f8d-4c69-bc7f-497413b87b9d@fujitsu.com>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <18a295a2-b734-45dd-9c95-660a9e1f58e4@moroto.mountain>
In-Reply-To: <18a295a2-b734-45dd-9c95-660a9e1f58e4@moroto.mountain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB10138:EE_
x-ms-office365-filtering-correlation-id: b34fe062-2a24-4daa-6f59-08dc6836b53e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVNZbkJjRzgyZHc5cmkxNWlRdjUwZzYyaDhQdWhkQk95UzB1a0lSVGh3cndI?=
 =?utf-8?B?bjlXWlg5eW1sZ0diOXBYeXVjOExQTUcyYnc5KzhCRXdJS0FBQnRoZGpRWWRv?=
 =?utf-8?B?Rnh2TUJMZTZtSk1yT1B6RXVyQ0xSNXVLbis5ZDlxVndFcjFYK2tVaHU0MndZ?=
 =?utf-8?B?anBmcE40d204ZkNLcjhBSzJCOFZoaHIwREY0UTBROVUzSFViZmJxbW01ODh6?=
 =?utf-8?B?QncyRmoxeTgzUGhHaExnd05iQkdIbWw2eHJhOHJxZk00S0Y0TWdKbTdjNzla?=
 =?utf-8?B?SEFzNENXbkFRZVU2MnI0VythdWlVTzlKQTJERndXUXp3QysvSjZKS0lkektm?=
 =?utf-8?B?QzFvM3ZSWnQwbGZwdDRMTGFvRWs1N2h0OXZuQzNtYk00Ym1ZMS9BM1ZIUWZI?=
 =?utf-8?B?ckhBYVpOOXBzblNFWTRWdUt6a0dQU2VwSDR5LzdzRFErZEZOeEJ2MVF5dnQ2?=
 =?utf-8?B?NGdocWUvdEs0V2x2OGZyNzh6dEJhNDZRK24wUHRMUDlzUmZKajdDRk5RQ1hN?=
 =?utf-8?B?YW9UbUlGT28rTVhwQUs3TG0rTkRFSEU1cHovbDlvdndxMktOaHkxQ3JON2FD?=
 =?utf-8?B?WkRwWXdhL1NmRGdqci9TZHhaMnJqRzNjS28vZGV4dHdOekIvU1BWU3ZMcUpv?=
 =?utf-8?B?V1AwMzcwVUdEcEx1NDFNdzZldVdibHhJbEF5elBRSGdFSCtlQU10WU1UU2Nw?=
 =?utf-8?B?M1dGOWJBL2ZXaG0yTkh1REhMTElwYkVIM0pKbnJuREl1S3FCdzM2Q2RMZEh0?=
 =?utf-8?B?NXNXby9ZYnpVMXFTUUZtODM0cjVoZVU0UjlwNUVCWVhPeWhUMm8raEhubkNa?=
 =?utf-8?B?SklaWHdBUS9ocllxenVGSEpBdElEVkNZalRqeVJOQldiWWhXakNoamJCMVMx?=
 =?utf-8?B?bk81NmowMGVKNHpaWlJxd2pLL2xUY3NjYmZ3cWxWKzVFOU1SQ0hvZ055NEdK?=
 =?utf-8?B?QVBRSEp2M2tTZ3YxeDhXK0Jqd3A5OTZVZk52U01wVjlaNkQxNTUrZ2JONzY5?=
 =?utf-8?B?Y0dZdzJFNmZ2OVFOQTBKUW9obDVhdnFLQU1BeDU5aGVkRjZsTWwzTXFDT3Aw?=
 =?utf-8?B?WFJsdkEwK2dTYlgyeFBlVURRelN0K1JFK0FTQjViYmlndVVwZ3hEL2liTmk0?=
 =?utf-8?B?cnlnNGRNelYreW1lMXREeDFUaXUvaElTNDlHbXd4dEdQZjJiTjdRY1pVUGNk?=
 =?utf-8?B?T2xYTkdGNXMreDlQUDdraERFcjRkdkUyRjZhbTllM0NHSFJNWldqTkRlcGNn?=
 =?utf-8?B?M0FDZ1B0c2J1WEVwZGlRcC9zelJOb1UrY0RncEZGejVNYmx4NThRYXV0UVlL?=
 =?utf-8?B?eVM5UU94SVBDUWU3cEliTE1DUktHQ3hIUHVEdUI1aWo4djN6Tnhza2VCdG5L?=
 =?utf-8?B?dGs1NDNsT1BkU1V0TlVtcXA3VTI4NTR2NVBPZ25lc20zSytPaUhnM240bmtv?=
 =?utf-8?B?MWxSaFFjbXFrSmI5VkwwMG9BbEtaWTJCWFJMOWtnUDdpdFZPZ2RmOFZWRGxB?=
 =?utf-8?B?QWs4Y2VWSGRIU2YwQWhpWWMvQk1kWDJBdkJXNFRDVkYrMWM4OERZZkprUEdT?=
 =?utf-8?B?VFRuMDJRd2t0SkdsL05UWkFZM2hRYy9Mdlk2cnNhTXBZbkdRcUtoQVdGSzI0?=
 =?utf-8?B?QS95S1RnNnlGVzNxelB5eEIrSG9TSHRGUUNUWHJIRC9pYWxJOHMraldDQ0Y1?=
 =?utf-8?B?N2JkanIxTFpMWG5Oa2ZzZHFqU3M2TDJIWWdnb3JNWFZBZyt3eTFmTWdzUXE3?=
 =?utf-8?B?eHk2V2gvby9aQlVmTWFVbjZCRlVHdXRHOGU5eVR6VmZmN2hTb2hSSEkrQ1lr?=
 =?utf-8?Q?ix7i+w4y1MnEoWaGxm1VosR1tLZsOat5Bwbb0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmtTMmh6L2ZubWIvOFV1OUNCMmFrK3h3THJmZXZlRGFoYTVjUHBrVVF4ZTFF?=
 =?utf-8?B?TDZGbHlrUlhNNG00RHRzL1AzbmZEbFNwMnJIMFRvbGVNeVp2M2NMYk9Pc1J4?=
 =?utf-8?B?Wll1ZFg4bjRqbG0yUTNwOTlwb3p1K1o3dkJ0MGpDYS9hS3h4d1VGUnEwa21m?=
 =?utf-8?B?czZ0T3ZXSlErQzcvNmJtb1pieXRiOXhuQ1RGVlMrQm5qMUxrR3dEYWFIeldF?=
 =?utf-8?B?bHhheVdSRFY5cVRjUXV0UmdQZVdmVHVZdzRuM2IxUm8rQWFJVXl6cGpYbExG?=
 =?utf-8?B?My9NbEZNUHpSQ3M1VnJ4ZlZ4OTdFZHlsd1Vkc2lNRXE2TGNkbStPcnA1Ky9Y?=
 =?utf-8?B?TEVjbUIxalpnQmg1alV3cWkzNzdnSi9MRFB5K2k2UlZxTS9KaFZ1RUI4QTR4?=
 =?utf-8?B?d3dkWDFsNjd1cE12VG1PMXgwWlZvRkRzVmdtWkVsZFNUUU5SYzdNTnFQR1M1?=
 =?utf-8?B?c0NhTCtZaUZYZzNqaGwxdDJvbGhJV0cyNTcyYXJ3WFl6d2YrZE8ydkdGTW5m?=
 =?utf-8?B?LzJDMTF1QVJ2N2NBY3VobWhobVV6MEVWeFovSTBZbU9yWHBsYXJTeWVFRUhJ?=
 =?utf-8?B?amtoNVpWdUVGMU95SHdZdDRINVMzaTdxajc3QXNYRlgvZkRLYm81dVpLU1ZH?=
 =?utf-8?B?aVkvaVNURDgrek9LNmIzdU42MzNIR0UwTGpKN256bWxkR1l3M2h6cVJkZDJJ?=
 =?utf-8?B?VWNGSE9UaVJFNERITTdPbk1YQU9KZG5jVVEveVFmeHBaSSsvcnRiZy8vMXhJ?=
 =?utf-8?B?dE1LY290enc1aE5IZlBiVm01MEJpeExPNzdPbmtaa05pcEoyVmd4eHRiemtm?=
 =?utf-8?B?N09RREwxczhiamRvemlzVW91eGN3VFBvN0k2QlFOamVIcitidXBhSEkwRkNI?=
 =?utf-8?B?RXZKdjBXQ2Y0VVJ3OEFtREhsQ0t6STdMMVBVTENPRkN6dXpqdFV2KzMzYTdE?=
 =?utf-8?B?UDNlRE1FYXBqOE9VcGx6L1o4OENlTE55cEJqWmtnblBWSDZ6azh6UDFDZlpt?=
 =?utf-8?B?Q25DeHI4ZStBMDNCa3NvZDA0bnVkQ0FjcDlrTlQwU21QVi93UytyOHBCblNC?=
 =?utf-8?B?d00rSnhMYkZTNnBqK1lHdHBlM2wrOWllUFVINGVKMmZBNFZoRmppakluSjVE?=
 =?utf-8?B?ZitQYVhkWHpYNTFYWUwybnRZUFVQNWtoRzdudmtDcnhnU0VvZDFDR0Mxc2I5?=
 =?utf-8?B?amVIQkdlTmZjWEl1bGpwOFk3b1BVekZBd0ZpL3VoTVhxYkRLNm5zeXZUMW9l?=
 =?utf-8?B?ZnN6clhyMGhuZUlHWm5IRDYzN0g2V0dqUEVyU3hWV2ZmR2R0MjlEZjNONVdv?=
 =?utf-8?B?RUtEQllYZSs1SGVwS2h5aDBRS29IdmE3bnljcDRudFBKclpDaStpZ3JOVDZF?=
 =?utf-8?B?N3BQblA0WGRnaldJWVlJSzhtaVBlZzZlNGU3cWZzT0pnSSs2aWc2aGZvU1Vs?=
 =?utf-8?B?QWgvQXN0WjBKejdLakZKMEY4YzEySFVvTVhjSVNBdWFnNEQ5V0lqWUxEY05h?=
 =?utf-8?B?Vk1oVlM1RXhieE8zWjNZMHp4OHoxb1F1cW9Ma3FkclJlYTh4ZlB5ZFZpZ29l?=
 =?utf-8?B?ZTdjL3FiR0NtV2JjWHR1OWlqUjBFMmtBSjZFMkxrakFBWlBKMXZHeHh6bzBS?=
 =?utf-8?B?Syt1MHRxYkQ2eHVzd1B1Q3VSclRUQW0xQTFFUkFPZFhRK3UrK2pYZDhjdXA0?=
 =?utf-8?B?QXl3N0IwYW9uL0hIYjNqT0RQQXIyc2Q4dVJjWU5iYk9IcmVSYkJNUndla3Yx?=
 =?utf-8?B?cXRxWlZhSjAyUW52TjBYVHdGakJCNmNRUnRVOTlnODl4UTUrRDJ5Z1lsamF3?=
 =?utf-8?B?ZE4vcU1uQzd2M0Zjemg4L0hyV21FNlV0K3BrNEZSUGtxZ0xDOGxZRWg5Mzdm?=
 =?utf-8?B?RjdjaDU0ZU12MGZNaVQvbjJaYzVyYmhmejhYckxTdGowd0dXMUloMkRBVDgw?=
 =?utf-8?B?RnhWS05NNEwwQUhXMVg3NHh4ZEs5UXY4WFhzS25YQWpFNFNuTTVleHNWN0dQ?=
 =?utf-8?B?QnRsVFlvamk1VTJQbXhmazYxanpXbThhUTJyQlVPUklzS3VIdTIxQWdCdGps?=
 =?utf-8?B?NThhRUFoNEJrazVFNTZnaEwvNndmcXB4Q0x4bGRMWlJnek8rem1yOE5SNzlC?=
 =?utf-8?B?ampLOXl5cG96a2lXeDlKVUJRRzk4ajUxZW4rSDJEVWN2OGhITTFvRzFoMWQx?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <154DD3C63543B94B8B1EDF0526384BF5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9LHiy0sDV0XcIkFgzbpk+9aTkkybJh/CwXJ0Fd+/tYu4DDU0s2vKmckhtK8/0MxUyK1h+Ca4Y9z2SllwV2YCvmNaCTR3oZNLIAndYxEBnO5mOqyauTRU+mZMfZJti0KmccLjkQDUK/Lreid84MX6CPQpkRUVTmi53vPG/frYbEK+sm+iOpfHMliwdLNFykc+F8eLbG0WgtlGDEJ50LgFUfZW5rzrnUcu0qWC8wZ3HEzA0t8Z8q3aHX8REOiP8G7ImID4qAoGwUK6T+tkLiM8MbzeOi+3YkOruYcfBlgGuFUN2kihLdjPahoRW+5oVPAR4FYcBLMf2Bn1CwrfPrbV2j4Vd40KkaFK9WHRlgurRRIi2qkZQIb8lF9PzXAw2/c09AXFw5su86fXuESRBgyZzK3wgM9fk8FwoNs027QgD2Li1YYqxVPY3VyS5+eUPOjAMiQEk3ou/omWmENWOz4dTtG9idynkY0q6WNEDrp7q9xb2AdFj3llZ8fSkpeTQoJYRdR3RTmxCd9GYxtwGig9q0JjNkfea9OooaaLxTW6EUM40qAha1WuQdHomBufuHth5JhFVM2xd8rkTz8v7v3aKdJrAZpBH01Nu4D7/GWmsKbDzTHd7rmgrIXJGtNsuu0L
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34fe062-2a24-4daa-6f59-08dc6836b53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 10:25:35.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hegL7JDs46ecByuBbPgO3ZR8+00JUfI8R3lvEUJI4xoBTLkx2pqw+YBdTURtblOeopWm6SETFfjA683zgyHA0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10138

DQoNCk9uIDI5LzA0LzIwMjQgMTg6MTAsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IE9uIE1vbiwg
QXByIDI5LCAyMDI0IGF0IDA5OjMxOjUzQU0gKzA4MDAsIExpIFpoaWppYW4gd3JvdGU6DQo+PiBj
b25zdHJ1Y3RfcmVnaW9uKCkgY291bGQgcmV0dXJuIGEgUFRSX0VSUigpIHdoaWNoIGNhbm5vdCBi
ZSBkZXJlZmVybmNlZC4NCj4+IE1vdmluZyB0aGUgZGVyZWZlcmVuY2UgYmVoaW5kIHRoZSBlcnJv
ciBjaGVja2luZyB0byBtYWtlIHN1cmUgdGhlDQo+PiBwb2ludGVyIGlzIHZhbGlkLg0KPj4NCj4g
DQo+IE5vLCB0aGlzIHBhdGNoIGlzIHVubmVjZXNzYXJ5Lg0KDQpBZ3JlZSwNCg0KDQo+IA0KPiBk
cml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ICAgIDMwODAgICAgICAgICAgLyoNCj4gICAgMzA4
MSAgICAgICAgICAgKiBFbnN1cmUgdGhhdCBpZiBtdWx0aXBsZSB0aHJlYWRzIHJhY2UgdG8gY29u
c3RydWN0X3JlZ2lvbigpIGZvciBAaHBhDQo+ICAgIDMwODIgICAgICAgICAgICogb25lIGRvZXMg
dGhlIGNvbnN0cnVjdGlvbiBhbmQgdGhlIG90aGVycyBhZGQgdG8gdGhhdC4NCj4gICAgMzA4MyAg
ICAgICAgICAgKi8NCj4gICAgMzA4NCAgICAgICAgICBtdXRleF9sb2NrKCZjeGxyZC0+cmFuZ2Vf
bG9jayk7DQo+ICAgIDMwODUgICAgICAgICAgcmVnaW9uX2RldiA9IGRldmljZV9maW5kX2NoaWxk
KCZjeGxyZC0+Y3hsc2QuY3hsZC5kZXYsIGhwYSwNCj4gICAgMzA4NiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbWF0Y2hfcmVnaW9uX2J5X3JhbmdlKTsNCj4gICAgMzA4
NyAgICAgICAgICBpZiAoIXJlZ2lvbl9kZXYpIHsNCj4gICAgMzA4OCAgICAgICAgICAgICAgICAg
IGN4bHIgPSBjb25zdHJ1Y3RfcmVnaW9uKGN4bHJkLCBjeGxlZCk7DQo+ICAgIDMwODkgICAgICAg
ICAgICAgICAgICByZWdpb25fZGV2ID0gJmN4bHItPmRldjsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXg0KPiBUaGlzIGlzIG5vdCBhIGRlcmVmZXJl
bmNlLCBpdCdzIGp1c3QgcG9pbnRlciBtYXRoLiAgSW4gaW4gdGhpcyBjYXNlIGl0J3MNCj4gdGhl
IHNhbWUgYXMgc2F5aW5nOg0KPiANCj4gCQlyZWdpb25fZGV2ID0gKHZvaWQgKiljeGxyOw0KDQoN
CllvdSBhcmUgcmlnaHQsIGEgZXF1aXZhbGVudCBjb2RlIGNvdWxkIGJlOg0KCQlyZWdpb25fZGV2
ID0gKChjaGFyICopY3hscikgKyBvZmZzZXRvZihzdHJ1Y3QgY3hsX3JlZ2lvbiwgZGV2KTsNCg0K
DQpUaGFua3MNCg0KDQo+IA0KPiAgICAzMDkwICAgICAgICAgIH0gZWxzZQ0KPiAgICAzMDkxICAg
ICAgICAgICAgICAgICAgY3hsciA9IHRvX2N4bF9yZWdpb24ocmVnaW9uX2Rldik7DQo+ICAgIDMw
OTIgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZjeGxyZC0+cmFuZ2VfbG9jayk7DQo+ICAgIDMwOTMN
Cj4gICAgMzA5NCAgICAgICAgICByYyA9IFBUUl9FUlJfT1JfWkVSTyhjeGxyKTsNCj4gICAgICAg
ICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4gVGhpcyBjaGVjayBtZWFu
cyB0aGF0IGlmIGN4bHIgaXMgYW4gZXJyb3IgcG9pbnRlciB0aGVuIHdlIHdpbGwgY2xlYW4gdXAN
Cj4gYW5kIHJldHVybiBhbiBlcnJvci4NCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBjYXJwZW50ZXIN
Cj4gDQo+ICAgIDMwOTUgICAgICAgICAgaWYgKHJjKQ0KPiAgICAzMDk2ICAgICAgICAgICAgICAg
ICAgZ290byBvdXQ7DQo+ICAgIDMwOTcNCj4gICAgMzA5OCAgICAgICAgICBhdHRhY2hfdGFyZ2V0
KGN4bHIsIGN4bGVkLCAtMSwgVEFTS19VTklOVEVSUlVQVElCTEUpOw0KPiAgICAzMDk5DQo+ICAg
IDMxMDAgICAgICAgICAgZG93bl9yZWFkKCZjeGxfcmVnaW9uX3J3c2VtKTsNCj4gICAgMzEwMSAg
ICAgICAgICBwID0gJmN4bHItPnBhcmFtczsNCj4gICAgMzEwMiAgICAgICAgICBhdHRhY2ggPSBw
LT5zdGF0ZSA9PSBDWExfQ09ORklHX0NPTU1JVDsNCj4gICAgMzEwMyAgICAgICAgICB1cF9yZWFk
KCZjeGxfcmVnaW9uX3J3c2VtKTsNCj4gICAgMzEwNA0KPiAgICAzMTA1ICAgICAgICAgIGlmIChh
dHRhY2gpIHsNCj4gICAgMzEwNiAgICAgICAgICAgICAgICAgIC8qDQo+ICAgIDMxMDcgICAgICAg
ICAgICAgICAgICAgKiBJZiBkZXZpY2VfYXR0YWNoKCkgZmFpbHMgdGhlIHJhbmdlIG1heSBzdGls
bCBiZSBhY3RpdmUgdmlhDQo+ICAgIDMxMDggICAgICAgICAgICAgICAgICAgKiB0aGUgcGxhdGZv
cm0tZmlybXdhcmUgbWVtb3J5IG1hcCwgb3RoZXJ3aXNlIHRoZSBkcml2ZXIgZm9yDQo+ICAgIDMx
MDkgICAgICAgICAgICAgICAgICAgKiByZWdpb25zIGlzIGxvY2FsIHRvIHRoaXMgZmlsZSwgc28g
ZHJpdmVyIG1hdGNoaW5nIGNhbid0IGZhaWwuDQo+ICAgIDMxMTAgICAgICAgICAgICAgICAgICAg
Ki8NCj4gICAgMzExMSAgICAgICAgICAgICAgICAgIGlmIChkZXZpY2VfYXR0YWNoKCZjeGxyLT5k
ZXYpIDwgMCkNCj4gICAgMzExMiAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycigmY3hs
ci0+ZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSwgcmFuZ2U6ICVwclxuIiwNCj4gICAgMzExMyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwLT5yZXMpOw0KPiAgICAzMTE0ICAgICAgICAg
IH0NCj4gICAgMzExNQ0KPiAgICAzMTE2ICAgICAgICAgIHB1dF9kZXZpY2UocmVnaW9uX2Rldik7
DQo+ICAgIDMxMTcgIG91dDoNCj4gICAgMzExOCAgICAgICAgICBwdXRfZGV2aWNlKGN4bHJkX2Rl
dik7DQo+ICAgIDMxMTkgICAgICAgICAgcmV0dXJuIHJjOw0KPiAgICAzMTIwICB9DQo+IA0KPiA=

