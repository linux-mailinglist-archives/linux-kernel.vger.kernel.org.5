Return-Path: <linux-kernel+bounces-95023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D38874850
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF97B22162
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA01CFAF;
	Thu,  7 Mar 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iOm/wjHk";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e91ZzcNF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9F1CD09;
	Thu,  7 Mar 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794018; cv=fail; b=j2qBXZ9BgMy93kmeJLWMpc/ySWcFqM5m4UTjJ/GAZ/WQnLGskRxFsBNrQ0+exFL/gD5wMWUwZ0cr0pFkQNIxn37rGkLKh8R1bmCyvwwmcSkDkmCqbwlzCjek3cjapuabeIGebHz/P/uIb8gnDN2Tj7sUe89sruo6URPg8EGbV1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794018; c=relaxed/simple;
	bh=dg7dIJF50c3jrrWIJF3dSuxykiZjLenAtFefN59BHCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LatTK4JyfxYISMshPtq+vRUTXM4LDP0SNvSgs59uYi/aO6I9/xgAYbpF4njlzzLcJGjVoQgDonbi34oQ8IWdPDO0t499qe0AD0R93D0UGtMqpKHMp31DItxDmr6T/38iyggiuAc205+Gn66OW2ugSwROpCXJ2H8D0vRTGG+KSfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iOm/wjHk; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e91ZzcNF; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709794017; x=1741330017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dg7dIJF50c3jrrWIJF3dSuxykiZjLenAtFefN59BHCw=;
  b=iOm/wjHkvLaQ/AAMembsQ4Cfw8cv5U61gvzSXrKPxn1x5ccTe4DipfRj
   d1PvcmwYe4nY3hSRFKWKjhalodwL3wyjucd+Tuzps+CdTAJpxVz4uRp1N
   +teKTRlRXWAvHGi8/Ueoq1LOedWzVixbFctpsYcVmnsiLhsGtjQEy7FGs
   SmtwcjjOWzVSH5OhWRqPwHkPb/JA4D03rtZlkHr8tnAu0uA83ej4mJuBf
   Fa2cvAR3TSKCbzNp32lZyFSFZK5QEoHMM3tiw66y/WJ10Iym0Gvs9RZbL
   2Gur3lgTKvbt050bydtvpvj7CMAB1453bxznHr1uB+5qIDimGeKFd+lR3
   g==;
X-CSE-ConnectionGUID: iHC9ARsyRIK739unNqnHoQ==
X-CSE-MsgGUID: UIt2QY5uQsSn98kgcd2mQg==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="scan'208";a="184601007"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 23:46:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 23:46:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 23:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brkqrbTZcyo3I3bl1X8m54cb/K1xDyp7fFW8M0emzMN4uMmWwrem7J8K3Up81LUNQb3oVaJZOH9aWGfLGohwDvEEwPWa/L0ZlVbXuPl2NBKf+jF9h8Cg4zVf9NTQ1sjAAugGFG7NLLX7BPX0tKqsLaLzm7l5v575DYkT3oBsy9J40ijxMTrSzlrRYPigE13CPTv2Xw0DAofGhOAM2MBRSB+o9ObVLXyxo2Mqp/JFeP7/dJtQX7NpFbgxT8P4AhiFp/x0/qbL5p0Vb2mY1sz3+aW8psjoDunPpIsVwidGwsGFGl1ZlzJdY8LmxApNXevMyxtP8VyCFzejEnvzzZW26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg7dIJF50c3jrrWIJF3dSuxykiZjLenAtFefN59BHCw=;
 b=dGNHrdOLOns/FuoMGuav2X/8paV0uyGhOZETcykThWKkSCBnRNq6ns+cJl2A7JUrgEhz2YsIku/4jAfiJszUXydtsxUbnunAkUXzaM5lTREhiDLVlQJMvINCBRcHwliZb+I/V6GWLQy2SvL7lmQOHiVYsyBkDlSIfTJ+Fb43itsavCYAoLvdNQKVdf6q54C66VAs5XYVTFi4Ju+GDRYutN3MixjGEusKW1IL4IyzwIiwuNkC4eCNdNY5uwNw9tOMI+Lh/fBaR/eypRnCpX/WAVuAL3+MjFESY7rWGJFEf8m0dVKaSE95Z5QaVatvNZ5+1+LxVMiAlAFv5v7/i+t7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg7dIJF50c3jrrWIJF3dSuxykiZjLenAtFefN59BHCw=;
 b=e91ZzcNFRVtGzqXbW17Tz/F6CxJXkfzhokXf36J5x/3o85TOrg7In25SXvLZGacB45O3mseX7G8Dtj1L/b0ZS+cqKMlrZpesfGnfPrdI5Z9ulyjVPIdPaJ6KWpCknlwHrRLH1HphfyOeHRQpwff9dtH+h/L5a05AXiuaxU5SNVxSyy3Y+8CPcLGkeeIQzquWBuJcjl/mIhybNKPoA/jaB1r3AhbN0JCXJPskLVsUyhWqJ+/Am2k7ZGSJj5LPtNvslAkIe3+gWkbGqvHdKJG6rMftpPKU/vXOgnDhomDFVrWqMV8yRCd0lS2Xw3PbHn7b6wpe81/VC1HL+S0G55sO+g==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 06:46:22 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 06:46:22 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Topic: [PATCH net-next v3 02/12] net: ethernet: oa_tc6: implement
 register write operation
Thread-Index: AQHab6NxRDEPfjZIw0eEz4ApKWffwLEquIyAgAEefQA=
Date: Thu, 7 Mar 2024 06:46:22 +0000
Message-ID: <6e649875-2032-4a5f-9749-e01f2cc1cc4b@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-3-Parthiban.Veerasooran@microchip.com>
 <43f49aff-ca74-4d10-a478-89ea7497ba83@lunn.ch>
In-Reply-To: <43f49aff-ca74-4d10-a478-89ea7497ba83@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB6476:EE_
x-ms-office365-filtering-correlation-id: 6d830074-c18d-4f0a-93c8-08dc3e724d8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OC3EL9OAaqooBL82nKI4VYoFZdyTTbTSMWW2OBL1aYJ1x3eDEX33t9YGANXLC9CVXGVZ29rOy4TUvvjxprvoxdJQMtmZwNb0mizf79BYU3F2nTgoClOgvS64Cr10YV8NZ+E29I4emgf7/11yuQpo8RA1SJzdz+dFapM8Au0tgZd0zHlTjjDRh4+Wcnxa3lk3LpdA5CaS+V9B2HRGWv97PO6acXzlPAuuN4pJ234yWXi7jc+Moyw6FeRl5D2YvzPQ9va5778Wu+/7FlfSwx4IB7+Kf+QJ1beSyyT84NEAGpwzdQ7XV7mZdOe4AErVcv4NQo8IlPLqxpgKAr3doeEDXpMW0nxluC39XJbcoynrElnGfUeonkIp3R7tlbZ46B8P2uTgat5KVn4mcQ9NZvxZB8YcGRY/kp7V3G6O4cBI+5nr53C5TkdS4x4LhmNyKOKBd+ESzDJiiYlIwCS3l6rIhhMIEp2yitfmWzh+NNNwjqy1QLdKIvwNYf58KKhr+8zxEo6kl/tUQwYYmJ1ivUUa1Wa9YaQ2fL5s/GELJjnwAGruKwHgDJ9SaQnEZqsOMV4OWYvKJqu3azold4FvXXzjI0A2wdE/D47COcOH7028rQUdZHtgDPymtcTzFX+wm4pAefhTWvHSgyjhM0nvwiqKW0i4AOZVmmgzlAM1Ih/xAc0IkUv5qKwC/9W8y6uJLP00cU5Uxs6A0ZkSxfJ5kABq0FFd8/kyqdQL7XvOWpw0cRY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzQ1S2dtNjVUOUo1WFB6aVBxYzFCaEorT0psajlHMDNEWXYyYlhuOG1GS0cr?=
 =?utf-8?B?RmtkcXZZc3Z5dTI4cjNPQkw0QWs1SUlsa3QzTDAvZjQxcjI2ekVYem1XWThS?=
 =?utf-8?B?WXNWSFRkdmpTZlo2bWYzdFU1aStSaTliSjdQcE1kVXJ4M2RrVDRaaW1CNi96?=
 =?utf-8?B?VGprTWpvMkQ3dDdIbEN6SjZTR2lSZCtaaU5KWGVUVEdaclI3enVDcnN4QThD?=
 =?utf-8?B?SWg4aG85YmVuQ3cxVzV6YjRtR3pVdzVKa2tCNjhHRi9sd09rMVRxcTdRZ0R3?=
 =?utf-8?B?QXlPK3lSVjJpV3JGcWhxbVFJT1pOM1RUQ3R6cVhmV0NVeThnWDJuUUF0U0g2?=
 =?utf-8?B?d0E1azdaUy83UEphdXBTYXhPU1V6NHRQT09JY0lCbzhJRGdJODdvYm5BYWdi?=
 =?utf-8?B?Wm54TkpycEpYY096eStxMjRVRzlDY0l6WnpsSWp1aWhpUFZybkVXUHRqQm41?=
 =?utf-8?B?TjBMUFFGNmRnYm5sVk92OCs2ZDI0U3ZCZlFjM2s4cW5GM0pYMHdZMElWQWZO?=
 =?utf-8?B?dm9zNVJ3dUt3REVFeGtjVzlnanp4WitpU1VMUGk3ZEkvODFBNkw0NkpuaVNl?=
 =?utf-8?B?dVdJenE4UU1sVjhRd3p1ZEUyL29tU0kwNmpYVmRYT084c2grUEhOMWVPSHhH?=
 =?utf-8?B?Ni9hSUNmVEdpczI0MzMyUjhDWHNiYTdWMjk3cE1KZVF6anlleUhvL3BZYkJY?=
 =?utf-8?B?dGczbnh3ayt3WHg5K280ZHZDbmE3MHZqZDVaWXhKM3VpRXdqZ0p0dUF6RHRi?=
 =?utf-8?B?WUJ2QnRVK1BIcFZNd0I3cVV5anFFaHQ1MG1EeTdQYjM4ZWd3L1l1bDhxcXpP?=
 =?utf-8?B?L240WSt4SkxXdmpWR3lXcDZGdXg0NitRMFRCQkFHVjdKK2pDcTNlanRHaWNt?=
 =?utf-8?B?TE8zYmhLdS85RE50cTZJNHB2VXU2RU44V2U1djRpU00yb0l3cDMyQTNLTU1p?=
 =?utf-8?B?R3NFY24rLzdvTFRkZTh6VmozdGk3N2tFR2hld01JRzVDaU1pazRxWEh2UVpV?=
 =?utf-8?B?alQrZDBUdUliQ3hWcjNXTWF4WmdmZ3c2N3ZYZEt1Q2plQ3dDdk8xaytWVjQz?=
 =?utf-8?B?bzF5Zkh1SlZlSXdxNkcwYkRtUm5BeGFjZlZKMVNZZGpDQXlYbjQzczNXSXp5?=
 =?utf-8?B?NG10U3FNZzl1ZjliMUhzN1Zma1dKa0FIMkJzdjd3Q1hFNTNNazd4TzlHSlZW?=
 =?utf-8?B?WWp3M3gwOU1td0FFaFB5RDB1NUNqWG9rQlRJdFlrMUxFZHVyRzg5UmhBbkZz?=
 =?utf-8?B?cTgzMmFXNjVUMVZDaUFkMmxqNUlaS25oQSszdXpObzB5N0VxRTFXZ3NNNHF5?=
 =?utf-8?B?RTVwNkpzVzh3ZUJiVlFLQlFnR0N5WVRvclNrU0NpQlNJTy9VWStpRUdzWWxh?=
 =?utf-8?B?VGlueUgrVUlIQ0p0OHRDVFM5SnBKeDZrMWlZOUdyUGI1a1lQdUN5ditrUkxP?=
 =?utf-8?B?cWhyNlBxL3RkK051c0RZR01MazZMVzR2MnBDWll0UDBpMzlYYXNXUVRNZFR1?=
 =?utf-8?B?c2krbmpmSUl4SFJsQlZZd2Nsd01qTnhZYWF3ZCtVTGhROWlyYXQ4cHY3QkVU?=
 =?utf-8?B?YnZ2ZG1MWUpzVy9YWTMzZlhidVdDMXhDa2ozWWNDelUvOXIxemFvRGV1bWxr?=
 =?utf-8?B?anAyYzFtaFh1RFZmemhoUW9qdGJ5TDVzMFBvUHFQVnh5SFBXZncvWmZ6R0JJ?=
 =?utf-8?B?b3ZXdXdFYkV3Tks5alY3T05zUjFXVm1kazNBMWJ4SnhoYnVnYXZKMHd2d2g4?=
 =?utf-8?B?RlY3MDZCNlJMTVhHdDZMQk1hVXR6dUZVWkJkWmNtckVjVjhPc1VZanduVzRk?=
 =?utf-8?B?U21nNGhYdmxsWjlocm0rS3FvMTRRdUdaMXVZcDBNZ1g4V1B5NUVqZHB4SHFn?=
 =?utf-8?B?NEh0MHg5N0daL3hIVHJSdFZGYXl2WkN6eTBCUElQM0YvRk5OUnlEeElBbHAy?=
 =?utf-8?B?eDRFUjBIdTNtUDdhSTdnWEJBMkxSQUVyYm1rVkVpcDQrUmJWZllHM3lKUlVQ?=
 =?utf-8?B?OGg3T3lYVFEyVjY2a1c3VmViUDMyUWxUOGdzZTN1b01CVEUxOUo1dzlXdTU5?=
 =?utf-8?B?TnQrN1UxaUZod3lYSVlpQkxwcFlvUlc5TUJ6MVNUcWxQY3Fmc1VQclh5cGpz?=
 =?utf-8?B?R0ZMMk0weDVMNHozWWF0dzV3SFlhS0JNYjlvb1FFWnBNVkdNcTJBTUhMdkcz?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD3926BA0D1BE47A34081FED03AD1F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d830074-c18d-4f0a-93c8-08dc3e724d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 06:46:22.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjYE9Ty3Fkx20bnPKu9ampiz+bk+FpIf0RF2JVxagOEqxy83x6qF5lyKf9AJ4P/q1Ixzc2A3qaxYamhG00nSquGqv42QE0OHolOlReOXlAknDgXlB2DR5rRYi28J6kIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476

SGkgQW5kcmV3LA0KDQpPbiAwNi8wMy8yNCA3OjEwIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK2NvbmZpZyBPQV9UQzYN
Cj4+ICsgICAgIHRyaXN0YXRlICJPUEVOIEFsbGlhbmNlIFRDNiAxMEJBU0UtVDF4IE1BQy1QSFkg
c3VwcG9ydCINCj4+ICsgICAgIGRlcGVuZHMgb24gU1BJDQo+PiArICAgICBzZWxlY3QgUEhZTElC
DQo+PiArICAgICBoZWxwDQo+PiArICAgICAgIFRoaXMgbGlicmFyeSBpbXBsZW1lbnRzIE9QRU4g
QWxsaWFuY2UgVEM2IDEwQkFTRS1UMXggTUFDLVBIWQ0KPj4gKyAgICAgICBTZXJpYWwgSW50ZXJm
YWNlIHByb3RvY29sIGZvciBzdXBwb3J0aW5nIDEwQkFTRS1UMXggTUFDLVBIWXMuDQo+PiArDQo+
PiArICAgICAgIFRvIGtub3cgdGhlIGltcGxlbWVudGF0aW9uIGRldGFpbHMsIHJlZmVyIGRvY3Vt
ZW50YXRpb24gaW4NCj4+ICsgICAgICAgPGZpbGU6RG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL29h
LXRjNi1mcmFtZXdvcmsucnN0Pi4NCj4+ICsNCj4+ICsgICAgICAgVGhpcyBvcHRpb24gaXMgcHJv
dmlkZWQgZm9yIHRoZSBjYXNlIHdoZXJlIG5vIGluLWtlcm5lbC10cmVlIG1vZHVsZXMNCj4+ICsg
ICAgICAgcmVxdWlyZSBPQV9UQzYgZnVuY3Rpb25zLCBidXQgYSBtb2R1bGUgYnVpbHQgb3V0c2lk
ZSB0aGUga2VybmVsIHRyZWUNCj4+ICsgICAgICAgZG9lcy4gU3VjaCBtb2R1bGVzIHRoYXQgdXNl
IGxpYnJhcnkgT0FfVEM2IGZ1bmN0aW9ucyByZXF1aXJlIE0gaGVyZS4NCj4gDQo+IFdlIGdlbmVy
YWxseSBkb24ndCByZWZlciB0byBvdXQgb2YgdHJlZSBtb2R1bGVzLiBXZSBrbm93IHRoZXkgZXhp
c3QsDQo+IGJ1dCB3ZSBkb24ndCB0YWtlIGFueSBzdGVwcyB0byBzdXBwb3J0IHRoZW0sIHRoZSBp
bnRlcm5hbCBBUElzIGFyZSBub3QNCj4gZml4ZWQgZXRjLiBTbyBpIHdvdWxkIGRyb3AgdGhpcyBs
YXN0IHBhcmFncmFwaC4NCkFoIG9rLCBzdXJlIEkgd2lsbCBkcm9wIHRoaXMgbGFzdCB0aHJlZSBs
aW5lcyBwYXJhZ3JhcGggaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+PiArc3RhdGljIGludCBv
YV90YzZfY2hlY2tfY3RybF93cml0ZV9yZXBseShzdHJ1Y3Qgb2FfdGM2ICp0YzYsIHU4IHNpemUp
DQo+PiArew0KPj4gKyAgICAgdTggKnR4X2J1ZiA9IHRjNi0+c3BpX2N0cmxfdHhfYnVmOw0KPj4g
KyAgICAgdTggKnJ4X2J1ZiA9IHRjNi0+c3BpX2N0cmxfcnhfYnVmOw0KPj4gKw0KPj4gKyAgICAg
cnhfYnVmICs9IE9BX1RDNl9DVFJMX0lHTk9SRURfU0laRTsNCj4+ICsNCj4+ICsgICAgIC8qIFRo
ZSBlY2hvZWQgY29udHJvbCB3cml0ZSBtdXN0IG1hdGNoIHdpdGggdGhlIG9uZSB0aGF0IHdhcw0K
Pj4gKyAgICAgICogdHJhbnNtaXR0ZWQuDQo+PiArICAgICAgKi8NCj4+ICsgICAgIGlmIChtZW1j
bXAodHhfYnVmLCByeF9idWYsIHNpemUgLSBPQV9UQzZfQ1RSTF9JR05PUkVEX1NJWkUpKQ0KPj4g
KyAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4+ICsNCj4gDQo+IEkgdGhpbmsgRVBST1RP
IG9yIEVJTyB3b3VsZCBiZSBiZXR0ZXIuIFRoZSBkZXZpY2UgbWlnaHQgaGF2ZSBjcmFzaGVkLA0K
PiBidXJuZWQgYW5kIGlzIGdvbmUsIGJ1dCBpc24ndCBhIGJpdCBmbGlwIG9uIHRoZSBTUEkgYnVz
IG1vcmUgbGlrZWx5Pw0KWWVzLCBpdCByZXN1bHRzIGJpdCBmbGlwIGluIHRoZSBTUEkuIFNvIEkg
dGhpbmsgaXQgbGVhZHMgdG8gIlByb3RvY29sIA0KZXJyb3IiLiBFUFJPVE8gd291bGQgYmUgYSBi
ZXR0ZXIgb3B0aW9uIGhlcmUuIEkgd2lsbCBjb3JyZWN0IGl0IGluIHRoZSANCm5leHQgdmVyc2lv
bi4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICAgQW5kcmV3DQo+
IA0KDQo=

