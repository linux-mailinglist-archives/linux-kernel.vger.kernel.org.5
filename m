Return-Path: <linux-kernel+bounces-48096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD10845726
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7752F28C86F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849F15DBB5;
	Thu,  1 Feb 2024 12:13:33 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2113.outbound.protection.outlook.com [40.107.239.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76615DBBE;
	Thu,  1 Feb 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789612; cv=fail; b=RSxq0TDp3e/SJdoRei3oZ0bTqKGrskPEshC3v6tFN685TH2BWPu/Taz4l9kv+SeThKsqWdzwmOVmqs7Concps0XxodRK71H9nWmbjEf5bmvQtQOndPmKs/9QAojvaRLs8E3pH1/QDV1WOmb9/jFDQcvz42w6FZcQ4ey+K9QtY+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789612; c=relaxed/simple;
	bh=xkmCPoBO782oj4Jhn3DgAUz6MJdQRAiCrA1ST6ofuec=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+5SKWr2oUHry14oi346UTMO0IsjA399WFtqh/QemxTZs0XhcjPjUbogKAsXWZplOvHjtvuiCHtni9XvcaqcLd8F4/q717sR+HXHy3VDcx0AN/eOFbUzAswC9BSLczFXLfCHU+0MHBCklR2ytMbFpoj0x9Eyei6sawnTQG54ShQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imYDjnsg1ln9fButgZSGc3mP/BYAq8ownymbcDcstZfR+IkxQlXlUY7ym/diL4gd60N5rwwkT19B8yDHBlLmoG3Iu6FUhVq1HFbkbou4saGxqUbFSu1NBCye0i55v/20XC2dmdYzPXDACuG/QFT/FcPwwRD/mnRtXoPffBuXAvvy4e/7r5aGELWiWKGO9SqdHc5Ym0cNjMVO1EHw5m91wWD8tc09D5w4TJjI8ybZkTFgSzLzKFE6xuSApiAjOrz/Zvz+zsArXY5k8BP18CF91q9h/RetaEICuUehiiwA6eTOH95ev11Nv31E44RZ0hORD2eiEhkbCEAFMC3nvfKPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkmCPoBO782oj4Jhn3DgAUz6MJdQRAiCrA1ST6ofuec=;
 b=AknHNPina7wY1A0A4mu1z7fqRFHojhdPjYPxJf6ssavjA8bMhysOHWKMRwz/NS7YbXpCJCJq90sQMXEIcLA2ZCp4CaRi+vDqhAQ3NQtEbYGO1Fb3wilTbCiGwPff8AZNCNQo08mwrqqnnYjSIWBJG92UlR/C3TS7fVkYm9/wIk0EJ3niWd6MSRROEo80zXMuaOuSXfi/KW7BLYItiIEN8JOt1Z2TA/XBDRpKl3xbY4gAEUNDhvIdvRzAjFgU36o57zGqnD71bLAq6DFi0xwXWXdgHFVszSAWe7ggTUFT57ZZQCKV5UvxebtMk9LnCI0n/UO+QZLLalpEFKadbqAIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PN2PR01MB4394.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 12:13:25 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0%4]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 12:13:25 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Re: [PATCH] media: adv7180: Fix cppcheck warnings and errors
Thread-Topic: [PATCH] media: adv7180: Fix cppcheck warnings and errors
Thread-Index: AQHaOMmdPe9NxYhWWkOjigXD9AvXv7C+lJIAgAGuGp6ABNiHgIAwgHUq
Date: Thu, 1 Feb 2024 12:13:25 +0000
Message-ID:
 <MAZPR01MB695752E4ADB0110443EA695CF2432@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20231227133516.1356553-1-bhavin.sharma@siliconsignals.io>
 <170376380893.2881109.11558061738942135116@ping.linuxembedded.co.uk>
 <MAZPR01MB695797DF964AA599AF2D7D05F29DA@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
 <170412257392.923098.3453218353962810283@ping.linuxembedded.co.uk>
In-Reply-To:
 <170412257392.923098.3453218353962810283@ping.linuxembedded.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZPR01MB6957:EE_|PN2PR01MB4394:EE_
x-ms-office365-filtering-correlation-id: d6b7d246-5211-4c25-caff-08dc231f3110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YerGD/xH72KVUgBjcHIuyICocKG4Exi51LgRDXziu+Cz625h663+61ZkArFIFyChJu7yPgBXG/J07T9sy4EGaDcIxu1csEwfvU7iBchPWkbUUSMTOkH2WTnNepGucfkXylc2GbTO9HDAKLy5pQ40YuMpPUkMka0hCa8nSxM4DjUa9JG3K0+JFqDMg5+htOz39SYxQhrhuxA6g3pCMSTNiE3rf6UDSH/9LBoUxu9ipO1iJWmmVOfRi3Nw5wrw8S1ljplCJDlSjDfQukrA4C2O+0P1gL3ZgRAOXwlZ1ub3tas5wGo1NOAQCt8pjN/BiKpO9DoMC9a7gb6UjtvVfc6Q+wqebB3RSjda9GunWwBeQUIDcG2F1cRy+o7Mmpfxtp7Jx3mt/dqK0s+usPyN1pEFQWvDCcNflMKrdcBGaDbNiMDdj2ouOjwn+xB1dCM4BxfAbckx3CB9JhJnCsMudDmF3gSGJm8twNf4E0lwcVEttS4C5VpKNGP1k36cINkeSo9e5+Eh3IU/J73PfQHG0rDU5K/BWakeVgJSoxMyFZEodbhpEY/0EksmqaGtGo8yXt7SXc8Tc3wGE9C9Y6P+7OPRmmEafBnEwIEGZsN4FSycSBPwCBWYhMJgoUrVJOY2g8cIHD+2X7qz77NeHxGJC5p6YMYngE0dW+GIV5KoasLOgH4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39830400003)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(41300700001)(83380400001)(26005)(33656002)(86362001)(38070700009)(122000001)(52536014)(8936002)(9686003)(38100700002)(7696005)(2906002)(66446008)(316002)(4001150100001)(6506007)(71200400001)(76116006)(110136005)(64756008)(66946007)(91956017)(66556008)(44832011)(8676002)(567974003)(478600001)(66476007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk5KL2pkR0ZYTEhsaEgrSjl2bTUwV3QrTkx4K2hpMFlOZ2Z0cDhrQ3F0enZM?=
 =?utf-8?B?a09SeFFDUDVmTDFNVkpnaHpPeEExeXM5SjZ1M3pYNWVjZENSaWlUTmRiUTJO?=
 =?utf-8?B?RDY1RCtMVkt3QVBRYmlmaklvZmFZTzlrRDNPbUUvZDZYYVF2dlNPNGhJUUNl?=
 =?utf-8?B?WkJJRUNlWldDZ3l6MlJibzc5aHlLT0cwMjVEVWtCdC9oaVdTdjdGMkFaUFhJ?=
 =?utf-8?B?Q1c5clVoK1NhUmJvaU8ybFM5azhXTUMycFZBMWhzSHhPenc1Z2FNNnREaEZv?=
 =?utf-8?B?Z0grMWRmKzU1cDc3MUE2VVZtOXZjUzNRRWMzTTVtczBERXltSXo5c3A2WDZs?=
 =?utf-8?B?cHVmVFMvdzBoTkNQNkpXbTQ4TWZ6MmNsZVBlQzh1bUYzTW1WOElRWGVMUWYv?=
 =?utf-8?B?RGZHOEkwVVdtc1dOR3hQRVNEQi9aNzh3ZlRxVUdzMWtZc3BpTEFic3lDVkhQ?=
 =?utf-8?B?V2ROTHJuaG8zbUNFM3ZkQUF4QU13OW9NVVBpMVM4NzhRNmo3WnRnMk5Gc1g3?=
 =?utf-8?B?eHJPQkZobnZzR3NkN2JDeEVrWm5QUGJ3LzgzSHQ0WnY0dnBXNHl1bWZiYWFi?=
 =?utf-8?B?UTcySnJ6eDRhRWUxQjhUczJTY0RLQjI5MkV5RHQ4cmZvOU1kVHpsMmlHa0ZF?=
 =?utf-8?B?aFZqM01ORVVOckkxcGJadTcxT3lRb3kwdFpVNmZwRHNReFF3YWQyTXVLQmtT?=
 =?utf-8?B?S3FTdFgzeDRzbnpPK1lnT3JGU29GTHpZVVBUUElraUFLc0dYU1FKa0VBa05x?=
 =?utf-8?B?Q3NRd01Ma0t0MTY4VmhLeXNvNWhFdU9OWldxQU9hOVp3Y0JWVTB4UUtMeGEx?=
 =?utf-8?B?dTBhQ0s0blNuZjFBSlI4Tm5FdVN5M0diYk1JZUo2WGtXcGJ6STdWTzVjOU9G?=
 =?utf-8?B?bnpGK3RCTjRTdHpCakREN28rYTB1VnV2bXlabkJBSmR3MFJCS0lhMnlwMGdK?=
 =?utf-8?B?U0YzdVMxVnYyTFNnYWFFcDJIY3REZStCTUZFeDNZS25LY1FYeEphLytyYzBP?=
 =?utf-8?B?MkxnWmRpb2ZQbi9Ha0pSd2doQWlFZEFwVDBWUnRydzVJcWoyUGZXK0c4MUR1?=
 =?utf-8?B?ZXBJc1k1bHpPV2FCZkJMeUd5WU9YcHh6Y0RnWGZiUys4amxrRkZzL216b3ZZ?=
 =?utf-8?B?MmFnS05OVVFMR1dNR1gwS2d2Ri8rQmlkMGQzRmRXL1lQUTdhVWh6NU1RNDRS?=
 =?utf-8?B?MnluVi9BUUFVQ2hzSVI3VlBlSTVWdGVsZkEvSTU5OHFac0lvTjA1SXhPTEto?=
 =?utf-8?B?bnBQK2gwWU5tUk5tdWV5SSt6M0NaMy9ocG9KU3RERlJ4V2xEc1dDTE5uOXd3?=
 =?utf-8?B?NmdQUTY3VHJadEgxb0dvMzlIdHJUbzd5U1gvamFCdVhZZ0N1WUJrdng2eE1l?=
 =?utf-8?B?R1E4NWNFdER0b1FnTmJrZ1grMGZtTnEzWVBBY0llTGdCV1BjM3pWRjR3RGR0?=
 =?utf-8?B?d3EyS0p0M3hUenE0RDhRZmRJWDVPMjI2cVEwQW55cVoyZGo1MXA4NUZSbXAx?=
 =?utf-8?B?azlTSG9lY25zdkdGMllVSGRESFlHWkdXVHVrdW5paW45TEdhbTRlOElESVJZ?=
 =?utf-8?B?YVd6bEJjRWpueVJMN00wcnBWbnZST1lNWnQ2TXo1Uk0xOEh4OWl0eWJvT2o0?=
 =?utf-8?B?SVppb1c2TFBEWTVsdy9sUzBuN2ZkV25BWGxHZXdVcjYrYW5UWnhlRUZUaTh5?=
 =?utf-8?B?MmNwSi8vVUlDSmtwQ2NxMkRhY1hac1ZmMWtxQ095VlJpS1h1QzFCbzhWWmtT?=
 =?utf-8?B?MzlKeEcxcVVndGJqbTZMeUtTMFd4dHMxNFZMSDJsVm4xNFlsRHVjU2RZS2pS?=
 =?utf-8?B?SkJwZGtjZnRBK0xuSWd6dTl6ZWFKNUl2MzljSDA2OXRjblZsdEdLdDBjOWUz?=
 =?utf-8?B?bW1Tc04xYXBEQTczL0w3U3RWYmdaYVE0STA2c1NYWDdSOFg5aG9HRDdMdi9n?=
 =?utf-8?B?bjNIT2VHTE1BQ2JUVXZIdFQvR3JUYzlGclQ3bG92SmNONXZ2ZDlwcVcwUVVZ?=
 =?utf-8?B?VFlHK1phalY5OVFaUnJvVjNNY3V1WkJsckNBRU41WVJXYVM1SVd5a2ZZaVhn?=
 =?utf-8?B?dUhIKzM5bEVWdHl5a3krVXo0bkdXMEphaEVTRWpTSlZjVU9EczFSTFErZWMx?=
 =?utf-8?Q?RLiUl4rpocQXAk2pw8fbDwUWa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b7d246-5211-4c25-caff-08dc231f3110
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 12:13:25.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AS2xPwZf9IAAc5dvTa8k0n+EAMH62I4DZDW3xKKLfelvKaPJDLFDr+U+nzP0RPrZWZTd4e+hNr8f4rgy03McFNqKD8ZywJ4eU95xwuQFLLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4394

SGksCgo+wqBRdW90aW5nIEJoYXZpbiBTaGFybWEgKDIwMjMtMTItMjkgMTM6Mzc6MTQpCj4+IFRo
YW5rcyBmb3IgdGhlIHJlcGx5LO+/vUtpZXJhbgo+Pgo+PiA+PiBXQVJOSU5HOiBNaXNzaW5nIGEg
YmxhbmsgbGluZSBhZnRlciBkZWNsYXJhdGlvbnMKPj4gPj4gRVJST1I6IGVsc2Ugc2hvdWxkIGZv
bGxvdyBjbG9zZSBicmFjZSAnfScKPj4gPj4KPj4gPj4gU2lnbmVkLW9mZi1ieTogQmhhdmluIFNo
YXJtYSA8YmhhdmluLnNoYXJtYUBzaWxpY29uc2lnbmFscy5pbz4KPj4gPj4KPj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVkaWEvaTJjL2FkdjcxODAuYyBiL2RyaXZlcnMvbWVkaWEvaTJjL2Fk
djcxODAuYwo+PiA+PiBpbmRleCA1NDEzNDQ3MzE4NmIuLjkxNzU2MTE2ZWZmNyAxMDA2NDQKPj4g
Pj4gLS0tIGEvZHJpdmVycy9tZWRpYS9pMmMvYWR2NzE4MC5jCj4+ID4+ICsrKyBiL2RyaXZlcnMv
bWVkaWEvaTJjL2FkdjcxODAuYwo+PiA+PiBAQCAtMzU3LDYgKzM1Nyw3IEBAIHN0YXRpYyBpbnQg
YWR2NzE4MF9xdWVyeXN0ZChzdHJ1Y3QgdjRsMl9zdWJkZXYgKnNkLCB2NGwyX3N0ZF9pZCAqc3Rk
KQo+PiA+Pu+/vSB7Cj4+ID4+77+977+977+977+977+977+977+977+9IHN0cnVjdCBhZHY3MTgw
X3N0YXRlICpzdGF0ZSA9IHRvX3N0YXRlKHNkKTsKPj4KPj4gPj5QZXJzb25hbGx5LCBJIHdvdWxk
IGtlZXAgdGhlIGlmIChlcnIpIGh1Z2dpbmcgdGhlIGxpbmUgaXQncyBhc3NvY2lhdGVkCj4+IHdp
dGguCj4+Cj4+IElmIHdlIGZvbGxvdyB0aGUgY29kZSBiYXNlIHBhdHRlcm4gZm9yIHRoaXMgZGl2
ZXIsIHdlIGFyZSBnZXR0aW5nIHNhbWUgb25saW5lIHNwYWNlIGluIGNvbmRpdGlvbmFsIGlmIHN0
YXRlbWVudHMuCj4+IFNvLCB3ZSBuZWVkIHRvIG1ha2UgY2hhbmdlcyB0aGVyZSBhbHNvLgoKPsKg
SWYgdGhlcmUgYXJlIG11bHRpcGxlIHBsYWNlcyBpbiBhIGZpbGUgZm9yIHRoZSBzYW1lIGZpeHVw
LCB0aGVuIGluZGVlZCAtCj7CoG1ha2UgdGhlbSBhbGwgaW4gYSBzaW5nbGUgcGF0Y2ggYXMgYSBz
aW5nbGUgY2xlYW51cC4KCgo+PiA+Pu+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBpbnQgZXJyID0g
bXV0ZXhfbG9ja19pbnRlcnJ1cHRpYmxlKCZzdGF0ZS0+bXV0ZXgpOwo+PiA+PiArCj4+ID4+77+9
77+977+977+977+977+977+977+9IGlmIChlcnIpCj4+ID4+77+977+977+977+977+977+977+9
77+977+977+977+977+977+977+977+977+9IHJldHVybiBlcnI7Cj4+ID4+77+9Cj4+ID4+IEBA
IC00MTEsNiArNDEyLDcgQEAgc3RhdGljIGludCBhZHY3MTgwX2dfaW5wdXRfc3RhdHVzKHN0cnVj
dCB2NGwyX3N1YmRldiAqc2QsIHUzMiAqc3RhdHVzKQo+PiA+Pu+/vSB7Cj4+ID4+77+977+977+9
77+977+977+977+977+9IHN0cnVjdCBhZHY3MTgwX3N0YXRlICpzdGF0ZSA9IHRvX3N0YXRlKHNk
KTsKPj4gPj7vv73vv73vv73vv73vv73vv73vv73vv70gaW50IHJldCA9IG11dGV4X2xvY2tfaW50
ZXJydXB0aWJsZSgmc3RhdGUtPm11dGV4KTsKPj4gPj4gKwo+PiA+Pu+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/vSBpZiAocmV0KQo+PiA+Pu+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/vSByZXR1cm4gcmV0Owo+PiA+Pu+/vQo+PiA+PiBAQCAtMTA0Niw4ICsxMDQ4
LDcgQEAgc3RhdGljIGludCBhZHY3MTgyX2luaXQoc3RydWN0IGFkdjcxODBfc3RhdGUgKnN0YXRl
KQo+PiA+Pu+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBBRFY3MTgwX1JFR19FWFRFTkRFRF9PVVRQ
VVRfQ09OVFJPTCwKPj4gPj7vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73v
v73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73v
v73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gMHgxNyk7Cj4+ID4+77+9
77+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+9
77+977+977+977+9IH0KPj4gPj4gLe+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/vSB9Cj4+ID4+IC3vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73v
v70gZWxzZQo+PiA+PiAr77+977+977+977+977+977+977+977+977+977+977+977+977+977+9
IH0gZWxzZQo+Pgo+PiA+PkkgdGhpbmsga2VybmVsIGNvZGUgc3R5bGUgcmVxdWlyZXMgYW4gZWxz
ZSBjbGF1c2UgZm9sbG93aW5nIGEgbXVsdGlsaW5lCj4+IHNjb3BlIHRvIGFsc28gaGF2ZSBpdHMg
c2NvcGUgZW5jbG9zZWQgaW4gYnJhY2VzIGV2ZW4gaWYgaXQncyBhIHNpbmdsZQo+PiBzdGF0ZW1l
bnQuCj4+Cj4+IE9uIG1hbnkgcGxhY2VzIGluIGRyaXZlciB0aGVyZSBpcyBzaW5nbGUgc3RhdGVt
ZW50IGFmdGVyIGVsc2Ugd2l0aG91dCBjbG9zaW5n77+9Cj4+IFNvLCB3ZSBoYXZlIHRvIG1ha2Ug
Y2hhbmdlcyBpbiB0aG9zZSBwbGFjZXMgYWxzby4KPj4KPj4gU28sIGJldHRlciBJIHNob3VsZCBt
YWtlIGNoYW5nZXMgaW4gYWxsIHBsYWNlcyBhbmQgbWFrZSB2ZXJzaW9uIFYyIHBhdGNoLgoKPsKg
WWVzLCBidXQgeW91IHNob3VsZCBwcm9iYWJseSB0YWNrbGUgYm90aCBjbGVhbnVwcyBhcyB0d28g
cGF0Y2hlcwo+wqBjb3ZlcmluZyB0aGUgd2hvbGUgZmlsZSBmb3IgZWFjaCBjbGVhbnVwLgoKSSBo
YXZlIHN1Ym1pdHRlZCB0d28gZGlmZmVyZW50IHBhdGNoZXMgZWFjaCBmb3Igc2VwYXJhdGUgY2xl
YW51cHMuwqAKCkFueSB1cGRhdGUgb24gdGhvc2UgcGF0Y2hlcz8KClRoYW5rIHlvdSwKQmhhdmlu
IFNoYXJtYQ==

