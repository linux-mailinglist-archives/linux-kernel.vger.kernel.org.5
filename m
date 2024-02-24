Return-Path: <linux-kernel+bounces-79750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05443862634
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A8E1F21886
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D91E3F8FB;
	Sat, 24 Feb 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="TGsnKLPT"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974951EF1E;
	Sat, 24 Feb 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794032; cv=fail; b=uf0yjwnpTHR9iDqDkhRyja7O6t5FXABf6ql0Vzvi3q9jOAjTbr8mkaWVpXb/+Vj5gCT9QVkrmJ5SNEmmksWoBfmc7DooDxSaZKUSKhWm4+9vTKAc7WXXXN+MjWZBfk80f9BeZ9eY3M5I+jVVZXdFEaOLWEMvuMn21hqN3TFEuqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794032; c=relaxed/simple;
	bh=TrxjSPSFo7HwIWTfig3pqWNhAV2SzwYVrG/fxgc+7hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j9uRPEqb9/j9h1vzUkhISJqil5uuHNhbwQH9qXaymCAGfIQC5ghkPrhaa5mfMBL6MzfE+KS9KXJDcZSYHopXRnvIG3w1DuW6j0tt/yN/WmYBmQVU1+XtkIpX8QyqM0NffT58p84zFS2sCHpqBRssXJxHXia494x/nKF1mAyc16c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=TGsnKLPT; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.17.1.24/8.17.1.24) with ESMTP id 41O9ghVt010340;
	Sat, 24 Feb 2024 17:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=TrxjSPSFo7HwIWTfig3pqWNhAV2SzwYVrG/fxgc+7hk=; b=T
	GsnKLPTP62Vkd+3v0Zv6Jec/OBXT+rD36n7gunUSGivnYFx7eBamLHp/v1zNqT3g
	V+npjjw/AMNogBa/6HRR3krWdBUmaLEv/jX+sKsj2XKesN2T3D+B581zu/sh4PXT
	RNgCTD7b2XdfBy76o62XQ9wyCR/MR3gLiFQJThtDl8PvJ797Cc7FoL0j8g/qsx+I
	obhpKj1IPJhKEKNwnAM1HmI6yXHhmQBlOKXC0ED/cIuNKzC005EB77FYigIaBlBX
	rHL/ItVpJqCWbf9rTeBiHOCnmqqbPyUgyRbKO2jSoHezPsheA1DmanHJ9kgO4Y6Z
	bxdcfVaBUniVc3dcrHjxw==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by m0355088.ppops.net (PPS) with ESMTPS id 3wf1a7h7xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 17:00:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEaJoP/SoAEr5o0umLIoXFVOZnx8h7b2WdBy2IvKTV6yS+BGYBI7On/tTxr/jzOdyx/hXlttiluIOgemEw9sQJkGqN4b9rOdZcki1B6UvK3sOLpo5n+1aK8dTZxwpkT+xJ+MpvP4jejnCtWG2IqhjykYzerfj+NTBpjqGRZGh7UOSPou1cbc0xCI50nOBZfgds6FReQhCuMqR7hAfFBidQNq71PLzsp2DTAi4Jw3zjIwaqoh+VQLhlUn3RTCt3r+80Bm6eYU7ratVZrjg1baemjLo/b4DWjgIl3N8fgZ7lCHnluNj2C9WaUoT7zjiHdX0mNP5XIWFZHtMn1vzShEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrxjSPSFo7HwIWTfig3pqWNhAV2SzwYVrG/fxgc+7hk=;
 b=ZD6zLS1CdOGV5H6NroXYlV/lDTGo47XxNLdf0npo7a1XnuiQqAl1/qH5+i1GOpk4s5CUnXCG+oToXYd/HkFaYgwUW6ZW089/+7W3g7gdjxeGYvvwy1LloL7Uh+Xcsb2PpGV7oesULUPNg0Yd/ZKPZ/wMPKnepPhBJ9Ls08XqEO03pi+ttSdpx6B2nPbqNJDKG+Juu7ldhWFn/2xJgy3CwC/gED4pGB9ZsT3OmzrzS/vFNwGnM8MGlMVn4K0bnf64kslo2iJSJ66wS29C6sHhoxm1ClTYb/864g3pYbPU80kcOW+jbR5+0Mc/gScRMTqqilHrRKnhfiJGb1QQzSXMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB7192.apcprd03.prod.outlook.com (2603:1096:101:d5::9)
 by TYZPR03MB7081.apcprd03.prod.outlook.com (2603:1096:400:33b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Sat, 24 Feb
 2024 17:00:04 +0000
Received: from SEYPR03MB7192.apcprd03.prod.outlook.com
 ([fe80::b1d4:28a7:9984:bf28]) by SEYPR03MB7192.apcprd03.prod.outlook.com
 ([fe80::b1d4:28a7:9984:bf28%7]) with mapi id 15.20.7316.031; Sat, 24 Feb 2024
 17:00:04 +0000
From: David Ober <dober@lenovo.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Mark Pearson
	<mpearson-lenovo@squebb.ca>,
        David Ober <dober6023@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [External] Re: [PATCH v2] watchdog: add in watchdog for nct6686
Thread-Topic: [External] Re: [PATCH v2] watchdog: add in watchdog for nct6686
Thread-Index: AQHaMrbHNN/AxXlpS0ST/DVYrvGFcLEYvXcAgAFXlICAAAqXUA==
Date: Sat, 24 Feb 2024 17:00:04 +0000
Message-ID: 
 <SEYPR03MB7192ED993D9A15244EF22D9FDA542@SEYPR03MB7192.apcprd03.prod.outlook.com>
References: <20230912112747.285393-1-dober6023@gmail.com>
 <78da7ad0-cc11-4e6f-bf25-12bd5ec247a0@app.fastmail.com>
 <8458d626-8862-44ed-8966-2f60852c92bb@app.fastmail.com>
 <e6d0fda7-09db-4955-92dd-def2df768da6@roeck-us.net>
In-Reply-To: <e6d0fda7-09db-4955-92dd-def2df768da6@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7192:EE_|TYZPR03MB7081:EE_
x-ms-office365-filtering-correlation-id: 3794147a-b691-46cb-2503-08dc355a0bc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dxOLhL21IuwK+b0ONjmyWyykh9hAmxjF53GrhUhVW8Sf+zJ5WZGlIiInWTzzb3TI+Kb6wCGvM11vhoCZMGaHA5ZtioAP5WYPy1MYq6khUbS+uJcSRiUF19iYrrp62wyEyHaPcjfUlsIQrYZ31IjvRf3dcY2lYO3AehzVzQuY49j1dyy3Br/G4oMC8T4voWQZpr3NMly/6cPYdTtI1YQg64zkA9b6hFOQxMlCXPayZ1pQ3dJujDREcnUbsCp+mRqqRGS231a23SvvsZtIYCnMjcm4bebWuiktyGDOz3SjHP83Sz/FQYHt+nhg+6ooC4H4ldAvwEJKX4+bSMy8qGFaASHdYSRACrimuyqbJ9QImfpZSkEm/TxhB1bIYiUL9Zdc8CCE9f5+jQDBwQomg1yAHloWbxYafoZELwJ3ulZ4Cq7hHvRn6xRepghu3SvkehB5PHon7UsfBARoX1Kxpu0oOfd8irvBQtzACH4fVScp1IyCv4t0kQnCHfq8q2drcbArYPAkeQ/FieIN6pjljPdQL2H0Ec6/kixMTrb6atJ6cgUgKjdIPrbY1vBOjnNqhhnCjMtTa0nDSMjb1ACbojQsfjDek7IOAMNgH6qq3I+4+lCbX8P9F9o3rrw1ICYwwVtM
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7192.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d3VOOHdSaW9nWCt1TEJxRndaczFxL2F1VHM4T3ZTcEU1YXUyTFFGWWRmWmNE?=
 =?utf-8?B?K0xwSTlJaFNxQXA4M2tDWmlsWHRmT3JhSnNXaTgrTmU5OUQ5WkxKdHJZL1FF?=
 =?utf-8?B?dmhCUGxuZGJIRGtweWZZS3p3cFZnaHRKVjJEaWcyeG45QzFMWWx1QXE2dXQy?=
 =?utf-8?B?NU1aUkV3SDM1dHl6NFV5RWYyTWdNVnd0bTR6N1VTR0lSa3B3RFhWdHo5VUlT?=
 =?utf-8?B?cVpLSmNIazhoYkdnbm5Qckk3TVZ1d0JUYU55SjZCempKanhGNTArSldyeEpR?=
 =?utf-8?B?d0EyZ3hNa1R5Z29CdmIzNGNHdkhjbGNJczE0SDBHTWhtVkRsVXBKdDVXZlRo?=
 =?utf-8?B?Y2pNSkRVUWlNTmlWOXdWOUhCeU4zTXlVdEtXdTVDNVk1THNHNDlBbUpkQ0hD?=
 =?utf-8?B?cy9SSHcrL0FIdmhGVUYvMWlic1NvRkdTcmxlQ0tsblN0ZVdTUlhFRE9zOHlv?=
 =?utf-8?B?Q0JzRkNOM2syTkQ2NUFMM1kwVzV5bXFJQlFLam4xeVZrNlpYMTQyVGpYQ1hI?=
 =?utf-8?B?V2FVYnczZ2V1S250blJ6TW95RDdHalFPWTlnOWd2L1hxU3ljY1JSNnlrcUZJ?=
 =?utf-8?B?WUY2SmlFSEZJTTBmMlFITGxWRDJMYy9ud2phRWRCV0RKWk5QYndiWEphMEVs?=
 =?utf-8?B?Q1pGajBoc2N3KzhxSzZqL0tEWVdaeHN3cFFCU2tWTWlDZTkxRmIxVUxYS3Yz?=
 =?utf-8?B?ODZLa3FQR24wa3A4bWhqS3J4UzVjaDFYR2hDcW5HQW1LVDV4dVZyZTZidGoy?=
 =?utf-8?B?UWJjWXNJenR2Z05xSGFYTnczQUZYQUphcUJtU1FMNGxmdE1COFZJZnZPOGVY?=
 =?utf-8?B?VFNobmNpWVV3SU5qRk9rOWhlUHJSOUc5K1dsSnVWZThiQktMdUJsY1hGZk8w?=
 =?utf-8?B?dFZLMUxzZERJWGxXNlBoMFdKQlBwemVOQ2hOLzV6QVkxZEQ0MWF6NXNEVEhG?=
 =?utf-8?B?bmozdUVNMmtZSG9vTW5ibCs4NFN0cDdPQ092RWIvN0NwU1N5SE05ZHpsYjNh?=
 =?utf-8?B?QVA4b1EvYTFhUExDZCtaZE8wdWJqTkYvdmtLcjBuRWJkcVNoc2RZQlFWY1VD?=
 =?utf-8?B?STBQTGFFUWE0b2d1S1lhWnY4RXJaTXptdHFlWXM1R3hzL1RRQUsxbllGU09h?=
 =?utf-8?B?TTQvZmM1bmU0b3BJR2FDNHY4MGpTTmNhZlhlWUE0Mi9wZ3RBSnJDUnJSaE8r?=
 =?utf-8?B?M2c1WlJ0RWc0UTVNTUxzZEUrdlUrRGM2MlVZcXR5eTNkQlhsMzFVS3JraTJo?=
 =?utf-8?B?T0JzYkwxM2YyeVZtdGd4QVpJZUF3N0xHdzJJY0I5SnNHR0JNYlNET0dZaGk5?=
 =?utf-8?B?amlqRHowNENuL0RjcVJRTDk3RWVrUFIvR2liYm5tNkJxNEM0Yk4yeWpXOS9Z?=
 =?utf-8?B?SElHVlRuQ203Q2k5MEdldjNCRStQeCtCT0Mwd1ZOZDlqQnNUcDA4dkdoSWQz?=
 =?utf-8?B?NkE2bndjaHZLalI0WFg0OVFEbXljcHNqdFBuZElvZEhwU2VjQWFiZHZOT1Fs?=
 =?utf-8?B?L0xkU25NQ2xKbDdWdEE5R0l2QklsWW9nYzNzUjhzRGVuTU4vK29iUjlQSXhI?=
 =?utf-8?B?c3A3K0NsYUVOTG5NRXRudk8wdmcvVHNLMFl1U016eHdoNDhNK3daTVdJWjJZ?=
 =?utf-8?B?L1hmRWhoQ1Q0MXZkSWp1ZXZnK0NwQlVIdCtENWdtSGpiYmhTNWpYMU5oUU9W?=
 =?utf-8?B?MjN2Y21rcDMyK3BMdklBbm5DWExYVGRSbGVtN3ZCTnhjSUdOa2dheC91bENm?=
 =?utf-8?B?MmlIZWF1V1hGL0YvNkN3R2JGb1Mrbllub21xSVhHUkVYQXBKeUs0bENjalNO?=
 =?utf-8?B?aTZJZi9hOWZFbHRUQm9nRXI1YjZPRjNGQ01KWmtpWS9haGR2UXZZWERwaTJj?=
 =?utf-8?B?cGhmdWV5a0ZRTWJPZGZ4bm1kY0lDSDVGdnIzOUdGcld1UnhlK1RyWGFhbDdU?=
 =?utf-8?B?MVBRL0xGU29HSnY5d2VyOXJUMWZJbG9QNVB6a2VpWjJXa21wUEtBQklSbHlD?=
 =?utf-8?B?N01MYWtWTXFMbXhVQnJpQjZrRWhyUkJiUHBVaktvY3E1OEYvMW5QaThWNUM3?=
 =?utf-8?B?QVgzUGlqdjY4dDE1T1A2a09UYXk1TzAzcVBRdGpuUmNpTlJtTHBoc1VSWktD?=
 =?utf-8?Q?+lWM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7192.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3794147a-b691-46cb-2503-08dc355a0bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 17:00:04.0268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ReqFmVqLTKZ/HDPRsOQN5eza0zXFt8RKkdXVAZQBFGx8V3+ZjuttpArI+3kMOgLOa5nARsHGqyM40IOOHQ4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7081
X-Proofpoint-GUID: DvWkxfsnWNL0_bYlZgIQlzQZ1IffLYpj
X-Proofpoint-ORIG-GUID: DvWkxfsnWNL0_bYlZgIQlzQZ1IffLYpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=-20 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402240142

SGkNCg0KICAgSSB1bmRlcnN0YW5kIHRoZSBpc3N1ZSBvZiB0aGUgZmlyc3QgY29tZSBmaXJzdCBn
cmFiIGJ1dCB3aGVuIEkgYXR0ZW1wdGVkIHRvIGFkZCB0aGlzIHRvIHRoZSBod21vbiB5b3UgaW5z
aXN0ZWQgdGhhdCB0aGF0IHdhcyBub3QgdGhlIGNvcnJlY3QgcGxhY2UgYW5kIHRvIGNyZWF0ZSBh
IHdhdGNoZG9nIG1vZHVsZSBzbyBpZiBib3RoIGNhbiBub3QgYmUgbG9hZGVkIHRoZW4gd291bGQg
aXQgaGF2ZSBub3QgYmVlbiBiZXR0ZXIgdG8gYWRkIGl0IHRvIHRoZSBod21vbiBsaWtlIHNvbWUg
b2YgdGhlIG90aGVyIGNoaXBzLg0KDQpEYXZpZA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBHdWVudGVyIFJvZWNrIDxncm9lY2s3QGdtYWlsLmNvbT4gT24gQmVoYWxmIE9m
IEd1ZW50ZXIgUm9lY2sNClNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAyNCwgMjAyNCAxMToxOSBB
TQ0KVG86IE1hcmsgUGVhcnNvbiA8bXBlYXJzb24tbGVub3ZvQHNxdWViYi5jYT47IERhdmlkIE9i
ZXIgPGRvYmVyNjAyM0BnbWFpbC5jb20+OyB3aW1AbGludXgtd2F0Y2hkb2cub3JnDQpDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtd2F0Y2hkb2dAdmdlci5rZXJuZWwub3Jn
OyBEYXZpZCBPYmVyIDxkb2JlckBsZW5vdm8uY29tPg0KU3ViamVjdDogW0V4dGVybmFsXSBSZTog
W1BBVENIIHYyXSB3YXRjaGRvZzogYWRkIGluIHdhdGNoZG9nIGZvciBuY3Q2Njg2DQoNCk9uIDIv
MjMvMjQgMTE6NDksIE1hcmsgUGVhcnNvbiB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiBUdWUsIERl
YyAxOSwgMjAyMywgYXQgMzowNSBQTSwgTWFyayBQZWFyc29uIHdyb3RlOg0KPj4gT24gVHVlLCBT
ZXAgMTIsIDIwMjMsIGF0IDc6MjcgQU0sIERhdmlkIE9iZXIgd3JvdGU6DQo+Pj4gVGhpcyBjaGFu
Z2UgYWRkcyBpbiB0aGUgd2F0Y2hkb2cgdGltZXIgc3VwcG9ydCBmb3IgdGhlIG5jdDY2ODYgY2hp
cCANCj4+PiBzbyB0aGF0IGl0IGNhbiBiZSB1c2VkIG9uIHRoZSBMZW5vdm8gbTkwbiBJT1QgZGV2
aWNlDQo+Pj4NClsgLi4uIF0NCj4gDQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGdldCBmZWVk
YmFjayBvbiBpZiBhbnl0aGluZyBlbHNlIGlzIG5lZWRlZCBmb3IgdGhpcyBwYXRjaCBwbGVhc2U/
DQo+IFdlIGhhdmUgY3VzdG9tZXJzIHdhbnRpbmcgdG8gdXNlIGl0LCBhbmQgd2UndmUgZW5kZWQg
dXAgaGF2aW5nIHRvIHByb3ZpZGUgaXQgYXMgYW4gb3V0LW9mLXRyZWUgbW9kdWxlLiBXb3VsZCBs
b3ZlIHRvIGdldCB0aGlzIGludGVncmF0ZWQgaW50byB0aGUga2VybmVsIHByb3Blcmx5Lg0KPiAN
Cg0KVGhlIGxvY2tpbmcgaW4gdGhlIGRyaXZlciBpcyBwcmV0dHkgbXVjaCBwb2ludGxlc3Mgc2lu
Y2UgYWNjZXNzZXMgd2lsbCBiZSBzZXJpYWxpemVkIGJ5IHRoZSB3YXRjaGRvZyBjb3JlLiBBdCB0
aGUgc2FtZSB0aW1lLCBhbGwgZHJpdmVyLWxvY2FsIGxvY2tpbmcgd2lsbCBub3QgcHJldmVudCBh
Y2Nlc3MgdG8gdGhlIGNoaXAgZnJvbSB0aGUNCm5jdDY2ODMgaHdtb24gZHJpdmVyICh3aGljaCBh
bHNvIHN1cHBvcnRzIG50NjY4NikuIElmIGJvdGggYXJlIGluc3RhbnRpYXRlZCwgSSBkb24ndCBp
bW1lZGlhdGVseSBzZWUgaG93IHRoZXkgd291bGQgbm90IGNvcnJ1cHQgZWFjaCBvdGhlci4NCg0K
T3RoZXIgdGhhbiB0aGF0LCB0aGVyZSBpcyB1bmV4cGxhaW5lZCBjb2RlIHN1Y2ggYXMgbmN0NjY4
Nl93ZHRfc2V0X2JhbmsoKSwgd2hpY2ggd3JpdGVzIHR3byBieXRlcyBpbnRvIHRoZSBjaGlwLCBh
bmQgbmN0NjY4Nl93ZHRfcmVzZXRfYmFuaygpLCB3aGljaCBvbmx5IHdyaXRlcyBvbmUgYnl0ZSwg
YnV0IG9ubHkgY29uZGl0aW9uYWxseSBpZiB0aGUgYmFuayBpcyAhPSAwLg0KVGhhdCBkb2Vzbid0
IHJlYWxseSAicmVzZXQiIHRoZSBiYW5rOyBhdCBiZXN0IGl0IHNlbGVjdHMgYmFuayAweGZmIHVu
bGVzcyBiYW5rIDAgd2FzIHJlcXVlc3RlZC4gSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCBob3cg
dGhhdCB3b3VsZCBiZSAicGxheSBzYWZlIiBzaW5jZSBpdCBpcyBub3QgZXhwbGFpbmVkIHdoYXQg
dGhhdCBtZWFucy4gQmVzaWRlcywgdGhlIGh3bW9uIGRyaXZlciBkb2Vzbid0IGRvIHRoYXQsIHNv
IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgaW1wbGljYXRpb25zLg0KDQpBY3R1YWxseSwgbG9va2lu
ZyBpbnRvIGJvdGggdGhlIHRoaXMgcGF0Y2ggYW5kIHRoZSBod21vbiBkcml2ZXIsIGl0IHNlZW1z
IHRoYXQgdGhleSBhcmUgbG9ja2luZyBvdXQgZWFjaCBvdGhlciwgd2l0aCAiZmlyc3QgZHJpdmVy
IHRvIHByb2JlIHdpbnMiLCBieSByZXNlcnZpbmcgdGhlIGFjY2VzcyBtZW1vcnkgcmFuZ2UgZm9y
IHRoZW1zZWx2ZXMuIFRoYXQgaXMgbm90IGFjY2VwdGFibGUuDQoNCkknbGwgaGF2ZSB0byBzdHVk
eSB0aGUgY2hpcCBkYXRhc2hlZXRzIGluIGRldGFpbCB0byB1bmRlcnN0YW5kIGlmIHRoZXJlIGFy
ZSBvdGhlciBwb3RlbnRpYWwgaXNzdWVzLCBhbmQgSSBoYXZlIG5vdCBoYWQgdGhlIHRpbWUgdG8g
ZG8gdGhhdC4NCg0KR3VlbnRlcg0KDQo=

