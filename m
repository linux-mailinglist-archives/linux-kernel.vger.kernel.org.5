Return-Path: <linux-kernel+bounces-16332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25480823CF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91278B223B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F2200B8;
	Thu,  4 Jan 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="r0Y+08Dw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2093.outbound.protection.outlook.com [40.92.102.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB51F951;
	Thu,  4 Jan 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDhoJfmGeMJpfGTvjhOQn/gtEeJDDB1SWNS84BCijNe/bmch90OVXY/yJ3k6ajjszb5bxIJ0ROMXMFlXMe5IoI7BuClIMn406GTm7rsdtIOOLg6i7pZ2K1YKn/DLVplcCW1jnbLLGroQ7RGp3nm5NaAUSesepS+rmuY9wfC6GO4PPmSBAJRL5Wr1OhiYiJawzc3/oROwCrNldFhuXnx1NVolCd8p8EeSZIGN3/AQjRC2ynaqKuZiCFeL7CvKlYxbUtfugfbgxPRdgZVRAk0BMd0vq29wIbGSvuYRysyQrIO5CUlbS23b+AC2P7U1u+it6FPqFysYKBQD240hknt4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njjivt4ZmqseCNQUD1hDs1eFP70r2Lk+dHq1ZU1//l4=;
 b=ZsTbfX0Ys8TVmkb5I42bQGdvX4sK5utk0ooMufNd4lTsSx/Es6XYpVoBwX9U21uPqkTrLV70UYgztxNpqehHVIedM7pdSO8QjAuV+YtwYZVcHPwztmVxd03BEsorgppHA0XpqBntXGAfCCo2v84aOaV6kf96HILJW5khsgx8aidihY5QNlGf7vOvkehb0GSIbMY7rxhr9abKqUdV7OMmTHXYqIeo8XwZv1w+GJjLjuMpKWpl7vi6qpbwJhoB0IHApgU/77K+uQGUTeBgdlJWXfAhH/sCtW0UWVHxZu+sH8U+gdZkoM6ZaHf6b5lHzzeZUC77SX86X3Wa6H3by9+U0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njjivt4ZmqseCNQUD1hDs1eFP70r2Lk+dHq1ZU1//l4=;
 b=r0Y+08DwmIS02qk/2DrNDfGWRDkUSewhg/groYbGRupHX/CfPcxfNpzd7wYD9WBXPnd16rW12wY13j2Md93Cl9xQ44Yf0sFQFmxB5dt8+KejslyJy1Fd+uO/fnQoek4uCmwwxwQ62YM0utP0hab9pUoOD7YC0Q11KRCkwVnEWhZJi0b0SUVRlA5DMGOwbrwQiSMvib323Q45MxrDPlHEjl2YU4WXgi1EZ7btSz7LAbI+RKtNeMEf/XLSiGm5qhGbYY9i6yl1DaL/Fv4cjA1lPRLIbamYdA0LAq56kwochi1P7V/il/fWDv21PjOuX3QwnWiVMzXsxl7tgFzZCoPkWg==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB0070.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:ad::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.14; Thu, 4 Jan 2024 07:47:38 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 07:47:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Johan Hovold <johan@kernel.org>
CC: Sven Peter <sven@svenpeter.dev>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Felix Zhang <mrman@mrman314.tech>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Johan Hovold <johan+linaro@kernel.org>, Hector
 Martin <marcan@marcan.st>, Bagas Sanjaya <bagasdotme@gmail.com>, Alyssa
 Rosenzweig <alyssa@rosenzweig.io>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"kekrby@gmail.com" <kekrby@gmail.com>, "admin@kodeit.net" <admin@kodeit.net>,
	Janne Grunau <j@jannau.net>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Thread-Topic: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Thread-Index: AQHaOXLZp5wR1/nwLkmlVTCDisNjXbC+muaAgAq2x24=
Date: Thu, 4 Jan 2024 07:47:38 +0000
Message-ID:
 <MA0P287MB021769BC136ED0B947683709B867A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <AB87C916-9CF9-4B8C-AFF5-74CA4151C4FC@svenpeter.dev>
 <ZY1ly_uB8huYl5jO@hovoldconsulting.com>
In-Reply-To: <ZY1ly_uB8huYl5jO@hovoldconsulting.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [saRNkJfKLqoKrQ9yLgL19kF2cyJFPa3CfizjOCFlYxRAprTgkdMo+TAGlNzS9e5lQB27hs7xYgU=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB0070:EE_
x-ms-office365-filtering-correlation-id: 6ef50cbd-4c6c-435f-d9d8-08dc0cf96c44
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KbxRH8Anp+fIAlQ8JxpGhrvSVJTyTtxsNKu6VDWHlbij2eAHVhCJOX4VMUCAkQge8Ok21ul6M3wUF8GdgkgvMGyZydMP3sef2cyUHxi9z72mvRGtKfZrU96HFhPFrU0UroACMpvC84y/bBYBj6Ya5t1ID4wUHxN6llXvuRoqiDZB/WjVNfHRn41NxWm4Istx0uywB+C71yB4miTzgAAoflngSB5U4v6+3b1gUpjHMbH643OwH82ViXAA2nxpI8/0iK5cgxr9a45GhjRQ2qjYyWaZlYLWurCE8qOPXpSMP7PCylB6Rhn9SA7c8KY6C/cGKQgkj3caQ+XQsKUuIAlYdJBvBuQYIxFUQJBZVaBMr+BS7bgLkNtgCPr4Vk8tCvQxP+T/tQMufRe1bh/FcH9+D/6/uiQq7BFQ0mV379leMS2t79lAcOK/49hj11mwA4tDvXjBDD4kfs+I+s/hBgmfW+HDJjmGS71hzPYjc8iVEdG2qAd/R0+/tkoYgk2ez19pVCZzObZq2tjt73YQ+alwz7+xiBc9kQloEgUNN06h47vF7NomqxuzEAa1Tc8Rym/vOPTJL7HrZCA+WFJSYjWa3/9L9lT9S42O/xLOl6+SHRk=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXVrRjNNYWRiaWZxZUJmbWk2L2lOZmNnYmpReGlGQ3RFZG5VZVoyK3p4MG5x?=
 =?utf-8?B?RjRydEdzbU82VkQxd0taMVdzNVFURldkb2xaTE94WWZ1aElsNUVBTHM4dTdX?=
 =?utf-8?B?UHZreTRWR2d2bUR1UjVrUXh4THpUODY1cTk0dGNXMjAwcDk3VWdJMVQ2b3Ba?=
 =?utf-8?B?MENQRUZTTWdXS1lKRmdwL0ZRU3NydkJ5bDJkS3dMN1ozZ1RiN25LYWhlb0Fx?=
 =?utf-8?B?VVZDUmZUUUdKTndqRVcrbnJFRCsvZ25ZR0Uyb1FMNGYzUVMzTnZLVkVXQ0pm?=
 =?utf-8?B?TUNwL0tUdnErRi9ySVl3cGJiU05USms0QUtNVGJsL3U3VUJhODZpSUJMcDI5?=
 =?utf-8?B?aFZEaDR1My9TencyOC82cGlvZWhwcDRnV2U1R2NPT3ljNlR1YTZOc0plcGxk?=
 =?utf-8?B?UE5DVHVzbUJwUFRFQ3VmNlFyMkZWbDZka3EraWZ6aG11K3M2OFJ4dy9jeTNN?=
 =?utf-8?B?dmM1UlZYRnA0c3V0blp5WnJMeVh1S3RxOWZla2JYaG1WMUw2QmIveFJlS2pB?=
 =?utf-8?B?OGxKcERta3JTdnovT3V5QXVxaDBSdTgxcjNJVmZhRVcwUzljeFBQQnN4Sm9Z?=
 =?utf-8?B?SGZHaVlzb2tueGxlZ09SVVZHczZta1BHbmxxODVVcGpaYitKVi9GVEhBbG5u?=
 =?utf-8?B?UVdsOU9DTGNjTkpEMmlURUQzV1VLWloyZkRjOHFpZ0VYT3Q5bCtlTDdZQWVm?=
 =?utf-8?B?WUdsMVZRbWpMYjYxTWJnTHd1Qk55TUdna3BZUFN4L3V6Z3crZGJLWUVrOE1S?=
 =?utf-8?B?QWVDLzVHTUZYNnRhWXE4NW5RNTk1Um9pS29wSkJpd2hZbVVFVWRqQTBCcjdZ?=
 =?utf-8?B?MzFiUncwUENDMWNxc0NRcTcyMFBYSG5GaVVwdk42Z25BanBPRDBHcnludkM2?=
 =?utf-8?B?NmxOaW1xQVN1dDBGRXIwVWpPR0JRNitleSs5ZEs0ckVFTDE0bUFLMUtqQVg0?=
 =?utf-8?B?V01RTVY0NDFCd2w4Z0xWR1B0dDJOVWRpSGJxOFZlUmUrRlpJWjRTd3ptZzg3?=
 =?utf-8?B?Nm5OeEd6N3dodmtaU3p1SGpWdXJWeTBuT01hV1Foa21TMVh2UzROT1docnBO?=
 =?utf-8?B?TjBPVmxrMndnUS8wRUJ4bUl3cXpvcUtrVWkwcU1NalVUcW5OMXhHdXJRRE9a?=
 =?utf-8?B?Yi9NMDJONVJiN1N6VTV6Vkt2N1FoNndSL3RYQUs0M05aa2pWWmdvRFhDT2RF?=
 =?utf-8?B?b0dMMllVWjNxYU5ZcmtwcWgwc3JJN1NhcXhSeHVOWklNdHF1RnBHMzkrZTBM?=
 =?utf-8?B?cFVNVG5GR002Y1hQM202L09HdUhoWkhZUDcrMGdUaU5Oak8wNzlQNVNucnRr?=
 =?utf-8?B?d3ltVC9SWmJHdzgyOHNnZW1PU091NUt4MkRNMlFtVG1GYXc1OExVUE82QnRI?=
 =?utf-8?B?NDBiVUFseVp1dDNxWndsa3ZIeDZUa0xTQ1NEYUE4OFZvMmRpMjA2MUphOVZ1?=
 =?utf-8?B?ZTZScGMvRUNYQzRGLys5UnFleU9XcGxnMVUwWTYxS2NGVUZ3aVFIQVhBVFVo?=
 =?utf-8?B?K041c25GRlczRmFSN1hZNTFjSjdLT1pVajJwZlF4NVBYT3EwZUhsYTVoY1hN?=
 =?utf-8?B?UGJjRHlzSk1URm5BaE54aE9SVitvZytjeVVYbHFkNFNXbDZ5Zjc0YzB0NTdm?=
 =?utf-8?B?YnY5Um9hMmhCMnorQmJiK1lvTXMzOFQrc09HaG94eGVVaSszTXV0ZWkwRVF3?=
 =?utf-8?B?TFU2Z0xPZ3hQRjRvcXlTZVpTTElkWmhLRHF3MGdzajNadFhSTmpjZWhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef50cbd-4c6c-435f-d9d8-08dc0cf96c44
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 07:47:38.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0070

DQoNCj4gT24gMjgtRGVjLTIwMjMsIGF0IDU6NDHigK9QTSwgSm9oYW4gSG92b2xkIDxqb2hhbkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSwgRGVjIDI4LCAyMDIzIGF0IDEwOjQ2
OjU3QU0gKzAxMDAsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IA0KPj4+PiBPbiBEZWMgMjcsIDIwMjMs
IGF0IDExOjMwLCBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+
Pj4+IFRoZSBjb21taXQgeW91IHRyYWNrZWQgdGhpcyBkb3duIHRvIHJlc3RvcmVkIHRoZSBvcmln
aW5hbCBzZW1hbnRpY3MgZm9yDQo+Pj4gSENJX1FVSVJLX1VTRV9CREFERFJfUFJPUEVSVFksIHdo
aWNoIG1lYW5zIHRoYXQgaXQgc2hvdWxkIG9ubHkgYmUgc2V0DQo+Pj4gZm9yIGRldmljZXMgd2l0
aCBhbiBpbnZhbGlkIGFkZHJlc3MuDQo+Pj4gDQo+Pj4gVGhlIEJyb2FkY29tIEJDTTQzNzcgZHJp
dmVyIGhhcyBzbyBmYXIgYmVlbiBzZXR0aW5nIHRoaXMgZmxhZw0KPj4+IHVuY29uZGl0aW9uYWxs
eSB3aGljaCBub3cgcG90ZW50aWFsbHkgcmVzdWx0cyBpbiBhbHNvIHZhbGlkIGFkZHJlc3Nlcw0K
Pj4+IGJlaW5nIG1hcmtlZCBhcyBpbnZhbGlkLg0KPj4+IA0KPj4+IEkndmUganVzdCBzZW50IGEg
cGF0Y2ggdGhhdCBtYWtlcyBzdXJlIHRvIG9ubHkgbWFyayBpbnZhbGlkIGFkZHJlc3NlcyBhcw0K
Pj4+IGludmFsaWQ6DQo+Pj4gDQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIz
MTIyNzEwMTAwMy4xMDUzNC0xLWpvaGFuK2xpbmFyb0BrZXJuZWwub3JnLw0KPj4+IA0KPj4+IE5v
dGUgaG93ZXZlciB0aGF0IHRoZSBmbGFnIHN0aWxsIG5lZWRzIHRvIGJlIHNldCBpbiBjYXNlIHlv
dXIgZGV2aWNlDQo+Pj4gbGFja3Mgc3RvcmFnZSBmb3IgYSB1bmlxdWUgZGV2aWNlIGFkZHJlc3Mg
c28geW91IGNhbm5vdCBzaW1wbHkgZHJvcCBpdA0KPj4+IGZvciBzb21lIGRldmljZSBjbGFzc2Vz
IGFzIHlvdSBkbyBiZWxvdyAodW5sZXNzIHlvdSBhcmUgY2VydGFpbiB0aGF0DQo+Pj4gdGhlc2Ug
ZGV2aWNlcyB3aWxsIGFsd2F5cyBoYXZlIGEgdmFsaWQgYWRkcmVzcykuDQo+IA0KPj4gV2UgZG8g
a25vdyB0aGF0IHRob3VnaC4NCj4+IA0KPj4gQkNNNDM3NyBpcyBwcmVzZW50IG9uIEFwcGxl4oCZ
cyB4ODYgTWFjcyBhbmQgYWx3YXlzIGhhcyBpbnRlcm5hbCBzdG9yYWdlDQo+PiBmb3IgdGhlIGFk
ZHJlc3MuIElmIHRoZSBib2FyZCBjb21lcyB1cCB3aXRob3V0IGFuIGFkZHJlc3MgdGhlcmXigJlz
IG5vdGhpbmcNCj4+IG11Y2ggd2UgY2FuIGRvIGJlY2F1c2UgdGhlIGFkZHJlc3MgaXNu4oCZdCBw
cm92aWRlZCBieSBBQ1BJIG9yIGFueXRoaW5nDQo+PiBlbHNlIGFuZCBzZXR0aW5nIHRoZSBpbnZh
bGlkIGFkZHJlc3MgcXVpcmsgZm9yIHRoYXQgc2l0dWF0aW9uIHNlZW1zIGFwcHJvcHJpYXRlLg0K
Pj4gDQo+PiBCQ000Mzc4LzQzODcgaXMgcHJlc2VudCBvbiBBcHBsZeKAmXMgQVJNIE1hY3MgYW5k
IG5ldmVyIGhhcyBpbnRlcm5hbCBzdG9yYWdlLg0KPj4gVGhlIGFkZHJlc3MgaXMgYWx3YXlzIHBy
b3ZpZGVkIGJ5IG91ciBib290bG9hZGVyIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4+IFRoZXNlIHNo
b3VsZCBhbHdheXMgdW5jb25kaXRpb25hbGx5IHNldCBIQ0lfUVVJUktfVVNFX0JEQUREUl9QUk9Q
RVJUWQ0KPj4ganVzdCBsaWtlIHRoaXMgcGF0Y2ggZG9lcy4NCj4gDQo+IE9rLCBnb29kLCB0aGVu
IHRoaXMgcGF0Y2ggYW5kIHRoZSBvbmUgSSBwb3N0ZWQgYXJlIG1vc3RseSBlcXVpdmFsZW50DQo+
IGFzc3VtaW5nIHRoYXQgdGhlIEJDTTQzNzgvNDM4NyByZXR1cm4gYW4gaW52YWxpZCBhZGRyZXNz
IGR1cmluZyBzZXR1cC4NCj4gDQo+IFRoaXMgcGF0Y2ggbWF5IGJlIHByZWZlcnJlZCBhcyBpdCBk
b2VzIG5vdCBuZWVkIHRvIHJlbHkgb24gc3VjaA0KPiBhc3N1bXB0aW9ucywgdGhvdWdoLg0KPiAN
Cj4gSm9oYW4NCg0KU28gd2hhdCdzIHRoZSBmaW5hbCB0YWtlIG9uIHRoaXM/IFdoaWNoIG9uZSBp
cyBnb25uYSBiZSBtZXJnZWQgdXBzdHJlYW0/

