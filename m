Return-Path: <linux-kernel+bounces-103955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1AA87C700
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35F5281F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984E4C8D;
	Fri, 15 Mar 2024 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TBjflf7y"
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41967D266;
	Fri, 15 Mar 2024 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465371; cv=fail; b=IvBKVTS0e54vFrJi4P+qm8FvjIj8ZcTArC+WVwDL6Ksv1TBgWJJOiI5ysVYuzdVTDfclYVyf6SRnjfecnoUxMyxSmaIhG3O3Eka0oagqrH/779F9GivQuPNmNb8E9wi3hnHnANU0O65g/prwoS+9WEb2C2ARPBOydLUEup10kuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465371; c=relaxed/simple;
	bh=v3elT8wfdrKN9gBRGcujZnbb7qinFV91m2infSqeIao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LieTwtH6f4L1+MORlqazWMRrc0IwztvzLR/eTJ3FvWwu2oRhzHNQCjwFvoKhbvMPjsTUKnUbhusgwJyE54aZc2N9gH6ObWSEfxMptYfkSnu9UcioRTzHXbvP12DX7CSARZ/rk/wMfWbsZxqVLj/H7r59sQaRXe9qaJ3VRTyMqTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TBjflf7y; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710465368; x=1742001368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v3elT8wfdrKN9gBRGcujZnbb7qinFV91m2infSqeIao=;
  b=TBjflf7yVeerZt58s01CyuP4fy4EYPBAhiMAMqi5aqWat7RnbAFkJ6cp
   gdP2VQ2E929JgIGGN6wk+EKjrlksGn8VLD1AHQzKTQTrBIqzN2+lhBzgE
   D031zxhFwRzWmvpGWzJ1d1xj6zjKLPIIhzHOEcmvtMOCl4n7ODvvIwabs
   QOKPascEHbwWcExBsKnXCbcM+U6yy6Hbz17mgL70e9MIngKrmdqlV7HB2
   q+L3jyu7IQUP8KYzqjs+IoSYOrGMmXPn0l93cuTspHZ4ytwWNksXk1YbL
   YykuYUoQvuTG01NwBb6Qy2GYUzeoLVqyWRZyP1z7ciR4kqjXqcRaXMKn3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="114014226"
X-IronPort-AV: E=Sophos;i="6.07,127,1708354800"; 
   d="scan'208";a="114014226"
Received: from mail-japanwestazlp17011004.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:14:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnlrB7IH1TsDcn+pvloPO6R8HA9mPDDPv2eVp5HtiyCsxg2q/rsWbqhWrP4WkbwVAJ+S5dQb5UMVqSMjIIRtJ4bjIweLA0NXVprqohVPvBfJw2v5cQBTGVwGPsEC3VNwIAAtHbE9aGurCEMrfsPGe6ZF3cYFua1jNU1d3Ok/m/C0KujDJOBTszz6Y0dYbEwxN71NFMgCFau3B5tRxi0tokhbYEcZw4Eu0S/U6es229Ws2gWpY3lNuPZzwT8iE81fS6+/K4y4o6ZrXyPVgpo2HW9LaBbtTA/TD2RgKzW7uYhqgURZ4o0ZxD9ATFQ7P88cM23c958WNAGZ0WhvgQ1Chw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3elT8wfdrKN9gBRGcujZnbb7qinFV91m2infSqeIao=;
 b=dIWPJPf58Fc4zIvYOAloZQ0327JggEVCAIOg2U7/rkA1LyVmLw8FD1lJ+zThXMu6wkHFfFxYBM42eYXNi+SogCq8ZuzyetLN+5fdoESSlF8fF+Le9CiA4yFa9Nu4Fkmg713PxTdjECTzwMw6sxbMoXW91sugXrRUhBkKQTEbyXQTILsft0K/Zu+it5K9dseNczi5eWrY5e4ekcbhrj7G19BibrOG9AA/72eg+0CnLtIR7aKkgzwBr1ueyRrTAZlKv6iCz0MtK3ZijP54KC3GkdZsQjJCIocmsdY+JA0dGdLwA1LvuTeIlyYujOKWOAxibz/q6Rc5w/i39OEs3XYTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYWPR01MB9311.jpnprd01.prod.outlook.com
 (2603:1096:400:1a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 01:14:50 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 01:14:50 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina
	<jikos@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] HID: hid-sensor-custom: Convert sprintf/snprintf
 to sysfs_emit
Thread-Topic: [PATCH v2 2/4] HID: hid-sensor-custom: Convert sprintf/snprintf
 to sysfs_emit
Thread-Index: AQHadexiWjRptlyYqkuH8sMGz7jp87E3XhAAgACibwA=
Date: Fri, 15 Mar 2024 01:14:49 +0000
Message-ID: <470cd110-b9d0-4973-8149-3a9678f8d84a@fujitsu.com>
References: <20240314084753.1322110-1-lizhijian@fujitsu.com>
 <20240314084753.1322110-2-lizhijian@fujitsu.com>
 <20240314153326.2126d3df@jic23-huawei>
In-Reply-To: <20240314153326.2126d3df@jic23-huawei>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYWPR01MB9311:EE_
x-ms-office365-filtering-correlation-id: 655689a9-e7ba-4c4f-1541-08dc448d4fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DORu8H1IXzJqQmK2H9gxAV4CcAvRDOz6k29DdxaCZlf6Tgi8MWE15dpGDpII3qv08dnavQ6s+xRASMNxYwfhilmovu2ZxouboFnWMfU22TcFN2tzlZkr7blTbatSfSymilHsdAIYNTPB3y1lJMib0sk3R4assGIp3YYv9V6KjTOpr1R3BUPtpI1BSpiaW4V/Ni6Fl/OAmTXJo1dlNUeuy0evhkyl+7s+0wEastRlVBLOM3um/3PmJ5L4iqNLFLC5F6LliAO8L62WGzrwe28T2K+4EfNx4PvYEWcILKebI8IIqjlfrENyHFHgvbp/kANYXJi5H5GNbOl9WIi25pkoMezs/XkIiySa2dpg1+TQG0+xeSr/WVHQULkRiYqLBGxlGFE+MFGkELDSds5UdtCbAfb8b/AWatz23iip/uwqk5bkD6K9J0c1EE/YNXmbzbIva+opDniCJRI0q6hZK47jcUh0EnAakOAE4Y0BOP9Tu1ac7RYXJ2gsd3gIED1DBVAgZ9obUIH/QuKSVIWOBsv14d+xcyIUhkSRaoCJhgEW2xJ34KCi/MQ8sGeINSYxOBzWhdgr10tK7tz/5NNzotx95tQj+IYHzoi/LAOiwviC5ElRI0YL4aLdpNc1gPKO98uwvQL+wi7T7PjkMORTVz+Zojil0yCRA3zNjno2MD0lzG8CbjvONuQYaorT5GrHhcmu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RURMS1dJbW9UU0N1Y2twUnFaeFY0TEpLZkY1R3VQam5kR3Fxd0o5Z0JlUzZX?=
 =?utf-8?B?UnBaV1h6aWVmOEdUdFp0QVFYbFZwZFpESnlRTXVvalJkYmFka1hReFFvWkNB?=
 =?utf-8?B?WTRLYS9TU1ErcWtoYWo3Nmd0STVydk4yU2dkaFV0RXVBbEFxb0RCZW5rMDht?=
 =?utf-8?B?QldNcHJMS2FxWlNQVHF3TlNkUFNOcVkydjhDbXU4ZTZ0VDFYUjNPNmUxcVVZ?=
 =?utf-8?B?WDdOOWhqRjBmNWRCOGd6WlFlZDh2dlc4VDJtcXRjK0E2MUdSRnhDV0hzbUxm?=
 =?utf-8?B?aFJvbXdNcjd5ckpSOGlaejVQZ3JKbEtaUmQwT1p3VXV5dVNhUWZBaGhXRXM3?=
 =?utf-8?B?TzZpZUdmUTg0SGlZUmZDNVRudkNiVXArTzk0NHNDL01QTHFtT0tMekRxbkRQ?=
 =?utf-8?B?WExCa21DNnl1dWFIRjZNQlVRK2ZJUDNyNFNpdGFLSGxZWFdkSU95TUgrdm5E?=
 =?utf-8?B?SGl3QUtHVko1dVM2TDA2bllmL1AzZXVZaGx6b3VQaVRnSy9FeENIZ1UzT0cx?=
 =?utf-8?B?MExIUHBNTVRqQ0NoYWlHT1RBVjlVbGFnK3daMnV3bnF3b2d3VHRZMFZkMmU0?=
 =?utf-8?B?ZzhYME5SOHlsT3JwclJzV2oxckdRSzZCVzE0NVNBd3J6NGNxQVJrMEpaQ1A2?=
 =?utf-8?B?OG5hSTBUL2FVLzkydVpJZEhPcklmdm83aUNCSVNqMVFhend0eDA1a0FNMU5N?=
 =?utf-8?B?NXJtVzFNMVRGRFVMRFB6V2U1V2ZUQVQzVXdxRkVMVVM1U0Q2bHllLys3M0tp?=
 =?utf-8?B?bEtsSldobW83REVVUWdsd3BRVTNoMnVmWTdHZHdLaGVBOTYyclFXZ2pIczFB?=
 =?utf-8?B?eW8vTUdQZmpJWGFIYWlaVkZaL1lMRVpxZ1k2S3Z6c0xnT05uUmJmbjFUTy9C?=
 =?utf-8?B?bWVmK0FINWxPU25URkdpVm1vYUdCeDB6ZGZ2MlhHaUlGNzFVR1pQazVqdU9m?=
 =?utf-8?B?THBVdE5SRWZpTW1hS1p6bkd2WjRWb2pyOUpkU09qVEFuSWJVcXZjUGRwejdm?=
 =?utf-8?B?TGJ5WWZCTlJUNW9NWjJ3dmdjTW02T3pOOGVMZnoweUxreElmMjdKQ1lwdVd3?=
 =?utf-8?B?S1dGa1NyMS9vQXBmR0lRNGlZYzBEL1lSQ2pFcnYvZHhJRi9SVTlDR09KUGlI?=
 =?utf-8?B?NnVxZDVaWHo3Sk5yNlh0ZzZMMTNtUndjZE5tdzJuMHhZbms3VDNXdU9ZYnY0?=
 =?utf-8?B?dW9hTHlyRXR2ejBTQWRSc1dBdEd4MlB3dm9lWm5BUjBOOW42bHBHT1hiTkQ4?=
 =?utf-8?B?Vk1QOTlwK2pPMUEwbSt2dm5wd2tLVCtBMFBrUm52ejZITEZ0VFhpU1NmOWdW?=
 =?utf-8?B?aVhITGtIbkEwbFpkVEJ0UVN6NTJrVGdyNk5mUHJTcUY5RW5wUGQ2b3ZYWTNs?=
 =?utf-8?B?ZGo4ZFJxbUkrak1ic1FoWFJPaDJMVWVnVVVLUHQvNXFIN1gvYXlWa29TK1lh?=
 =?utf-8?B?aGdlcnJxMWtLQkZjdGtOUW8wWlJlUDVTb2pPVng2RytQQ0RJUUhTMExLbVI0?=
 =?utf-8?B?RzNoSXROWFllUHVHbzlrR1ZLMVA5QSt6TTZEUFhBZ3JIcWk5eWZ3SmdtU3NW?=
 =?utf-8?B?Y2dpMU13SkJ0YU1KMFJ3L0xjMDQ0Yk1XbUNjTU1SZklscEJzUWJNYnUzTlIz?=
 =?utf-8?B?QTE1Um9NYWg0RHZXQ3l6Tnh3ZmJQbE5FbFRkd0xOeVpGTDQ5dXZNdnJyVFBo?=
 =?utf-8?B?U2ZWNmNYTVlGN200QmREZWx0eUp2TUJacTZJN2RGbW5DSjNCVHhaci82N1lw?=
 =?utf-8?B?VStoVThjakpTL25Db3FzSFBRMjRIdDBYRGw3RDFJWUI1Q2EyWGJGWm9JazdU?=
 =?utf-8?B?TU1HRjVsek9INlgxaUhXVytvYURYR0E1Mmpxa09GV2ErZnBueHV0Zm5Bd2Vx?=
 =?utf-8?B?aDdieDRnOGRROEwwcHhUQ1RmMmtSdlZqZHRZcWF1NUs1L0kyd1dndnA3aGRM?=
 =?utf-8?B?aDZ4alJNN05kMUlYR0FLSU1lU0ZQU1FGU3V6SHE0TmZuVC9tdmdndE1odUhl?=
 =?utf-8?B?Mms5K1hzN0JzUzNtU1M5MkN0eTUyejFOd0o4cjB2M2lvNFNxNS9PZmlwRHFi?=
 =?utf-8?B?WHJ6cVE1Z01mTEw0R2Vad09RZEFhQlV4UE5uQkw5amVLOUQ1K04xV1NxZzVT?=
 =?utf-8?B?TVVKTFFRamsxZ3B3aVhmbUppM2F3YjhuWXM0dHV6NGFQeWQ1YTh6TXB1NUdE?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1324A01DA3A0747BE865316929A2616@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VHEO7NsuMkVxIALKox4pnePwdVK187OICTO2rDUuZG1jpOl84veuWRBm5lyL51bDQTUL94vIRjIhrYYxPb3f1l0fMpcH+ALhfMs7Kg6vhiHBn0EbLy4iDOxqFby5RqgIPpGms6hCUxsN9/lcxoPnk35KQsCdkzA52GlfL70e0W9U/S7VWa7CQPogfp2aITXHlAbidDliPIzOZchK6lu9NHrY9gOzNTpwrYOSvBWDtKUR1HEYYj0c9+SFLzNLWLSf4V5ZO07hplAxW4L4+na3vquzstY01alK6y3D6Hb7rKp+HND1397N00s+IDQyqLuIhreHaFbKUnnIp3Opw6f8N/cvoguGaUWatd4jnpem6O2YL/a3DhxQxFb6ADKHfeGE/30FjifaAEC08a7wlWmB/r1KNJPzDaU0v8qjdwW8RQoih/kRUGflrUPvSgMOf1V9XH+nMm0q6nKRVYz57s5io/CRePf39zUJy6t4IBwDf6IyMmyBbxJPLE6tXRiTx99piW7R5sXiz5EZVlPodp65YKS34nrfWDOWhKbsF9jGeiGInmr83goBnjkoejqV8DMTc0tdqqDIozyjga87suaWqutcxMS84XjHMPvMLuDuB0cVP1kxPMnnCDXr9vwvGNoh
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655689a9-e7ba-4c4f-1541-08dc448d4fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 01:14:49.9912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krWgtY48lBLrkukEbFRLoY6G4+/JUXqLBXhNuBL9SBx4hFWcF56FEac84NwZiPVHwkdN5wwgw6jpn28fRA47fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9311

DQoNCk9uIDE0LzAzLzIwMjQgMjM6MzMsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFRo
dSwgMTQgTWFyIDIwMjQgMTY6NDc6NTEgKzA4MDANCj4gTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPiB3cm90ZToNCj4gDQo+PiBQZXIgZmlsZXN5c3RlbXMvc3lzZnMucnN0LCBzaG93
KCkgc2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKQ0KPj4gb3Igc3lzZnNfZW1pdF9hdCgpIHdo
ZW4gZm9ybWF0dGluZyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS4NCj4+
DQo+PiBjb2NjaW5lbGxlIGNvbXBsYWlucyB0aGF0IHRoZXJlIGFyZSBzdGlsbCBhIGNvdXBsZSBv
ZiBmdW5jdGlvbnMgdGhhdCB1c2UNCj4+IHNucHJpbnRmKCkuIENvbnZlcnQgdGhlbSB0byBzeXNm
c19lbWl0KCkuDQo+Pg0KPj4gc3ByaW50ZigpIHdpbGwgYmUgY29udmVydGVkIGFzIHdlZWwgaWYg
dGhleSBoYXZlLg0KPj4NCj4+IEdlbmVyYWxseSwgdGhpcyBwYXRjaCBpcyBnZW5lcmF0ZWQgYnkN
Cj4+IG1ha2UgY29jY2ljaGVjayBNPTxwYXRoL3RvL2ZpbGU+IE1PREU9cGF0Y2ggXA0KPj4gQ09D
Q0k9c2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZpY2VfYXR0cl9zaG93LmNvY2NpDQo+Pg0KPj4g
Tm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQNCj4+DQo+PiBDQzogSmlyaSBLb3NpbmEgPGpp
a29zQGtlcm5lbC5vcmc+DQo+PiBDQzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9y
Zz4NCj4+IENDOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4
LmludGVsLmNvbT4NCj4+IENDOiBCZW5qYW1pbiBUaXNzb2lyZXMgPGJlbmphbWluLnRpc3NvaXJl
c0ByZWRoYXQuY29tPg0KPj4gQ0M6IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZw0KPj4gQ0M6
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4g
PGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gSGkgTGkgWmhpamlhbiwNCj4gDQo+IE9uZSB0cml2
aWFsIGNvbW1lbnQgaW5saW5lLg0KPiBPdGhlcndpc2Ugc3RyYWlnaHQgZm9yd2FyZCBzbw0KPiBS
ZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29t
Pg0KPiANCj4+IC0tLQ0KPj4gVGhpcyBpcyBhIHBhcnQgb2YgdGhlIHdvcmsgIkZpeCBjb2NjaWNo
ZWNrIGRldmljZV9hdHRyX3Nob3cgd2FybmluZ3MiWzFdDQo+PiBTcGxpdCB0aGVtIHBlciBzdWJz
eXN0ZW0gc28gdGhhdCB0aGUgbWFpbnRhaW5lciBjYW4gcmV2aWV3IGl0IGVhc2lseQ0KPj4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDAxMTYwNDExMjkuMzkzNzgwMC0xLWxp
emhpamlhbkBmdWppdHN1LmNvbS8NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2hpZC9oaWQtc2Vuc29y
LWN1c3RvbS5jIHwgMTAgKysrKystLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9o
aWQtc2Vuc29yLWN1c3RvbS5jIGIvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1jdXN0b20uYw0KPj4g
aW5kZXggZDg1Mzk4NzIxNjU5Li5lZTFhMTE4ODM0ZjAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jDQo+PiArKysgYi9kcml2ZXJzL2hpZC9oaWQtc2Vuc29y
LWN1c3RvbS5jDQo+PiBAQCAtMTU1LDcgKzE1NSw3IEBAIHN0YXRpYyBzc2l6ZV90IGVuYWJsZV9z
ZW5zb3Jfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBoaWRf
c2Vuc29yX2N1c3RvbSAqc2Vuc29yX2luc3QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4+ICAg
DQo+PiAtCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBzZW5zb3JfaW5zdC0+ZW5hYmxlKTsN
Cj4+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJWRcbiIsIHNlbnNvcl9pbnN0LT5lbmFibGUp
Ow0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgaW50IHNldF9wb3dlcl9yZXBvcnRfc3RhdGUo
c3RydWN0IGhpZF9zZW5zb3JfY3VzdG9tICpzZW5zb3JfaW5zdCwNCj4+IEBAIC0zNzIsMTQgKzM3
MiwxNCBAQCBzdGF0aWMgc3NpemVfdCBzaG93X3ZhbHVlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+PiAgIAkJCQkgICAgIHNpemVvZihzdHJ1Y3Qg
aGlkX2N1c3RvbV91c2FnZV9kZXNjKSwNCj4+ICAgCQkJCSAgICAgdXNhZ2VfaWRfY21wKTsNCj4+
ICAgCQlpZiAodXNhZ2VfZGVzYykNCj4+IC0JCQlyZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJ
WkUsICIlc1xuIiwNCj4+IC0JCQkJCXVzYWdlX2Rlc2MtPmRlc2MpOw0KPj4gKwkJCXJldHVybiBz
eXNmc19lbWl0KGJ1ZiwgIiVzXG4iLA0KPj4gKwkJCQkJICB1c2FnZV9kZXNjLT5kZXNjKTsNCj4g
cmV3cmFwIHRoZSBsaW5lIGFzIHdpbGwgYmUgdW5kZXIgODAgY2hhcnMuDQoNCkdvb2QgY2F0Y2gs
IGkgd2lsbCB1cGRhdGUgaXQuDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPj4gICAJCWVsc2UN
Cj4+IC0JCQlyZXR1cm4gc3ByaW50ZihidWYsICJub3Qtc3BlY2lmaWVkXG4iKTsNCj4+ICsJCQly
ZXR1cm4gc3lzZnNfZW1pdChidWYsICJub3Qtc3BlY2lmaWVkXG4iKTsNCj4+ICAgCSB9IGVsc2UN
Cj4+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICAgDQo+PiAtCXJldHVybiBzcHJpbnRmKGJ1Ziwg
IiVkXG4iLCB2YWx1ZSk7DQo+PiArCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCB2YWx1
ZSk7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIHN0YXRpYyBzc2l6ZV90IHN0b3JlX3ZhbHVlKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+IA==

