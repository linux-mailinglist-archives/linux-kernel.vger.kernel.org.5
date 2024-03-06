Return-Path: <linux-kernel+bounces-93528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE84873106
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCD7B25786
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42815D8EE;
	Wed,  6 Mar 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="nNRwse2e"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2372E641;
	Wed,  6 Mar 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714738; cv=fail; b=k4/0QuaSKARde0VmFxBq0jlNaLA4zY2HIgpbD+Rw7p8JYAomAqsLoPpqnlY9LuomEG1ylhVDYzQc3nwBZsLU9MBsRCRsZYystbUj/g0xSOjJ6uOni+fBw3Km2LajRyEUdIkSvHjufcGI+0RX+Z+Nn3udLkI9jJw32WeBu5m2m94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714738; c=relaxed/simple;
	bh=ob2otnfSPAmYzfdkvYKAXFO7sUsIIZKqKkhLZvm9428=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tBCudxp4vHibyX+FYmMpF9MSaJ++Qt3uPb0oYLd62RXNlIQtgfHI83joB3ggzpQ2mLMwDZkO0RuM8+cNtz/ywHgh3/G3PYYvtW7mgGRCm093KZczG7R9lkkEfwYsUEyyaZnZGFiKftAQxVHY0PAm6/29GgNlYmWXDvZd8Hf+4zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=nNRwse2e; arc=fail smtp.client-ip=40.107.117.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFi61XI6p20rMLP1EDqKtQn5O4yWpEiaKDvPM/kuR7ec4RNVNqoYHCYsEsp7IiF0AtkohGLs+liGgwk+ELlLwv1oQYU1R8aRbYsdNJ5nSfF7jyZ4ZP4i+tdVcfkSLj4j0AsG0ZCKyb0Ffc7Y9wNP3EhgHqpiFuCq554V146+/KdqnUKFGYaXv88b7cAxW8uhDKmmnlaNpT5v+4rm4zgQlGY7/7ImKGaBIGC3Ezo5carYQmawyXc4CGBqkBewbD79doBA68Qs1XHQGhfNYKIt6lFevklSE262y00qtSFyHiwfaZxkTWNks7wMgDORj9FBDzHPcKFl/e7MgAk3cJ7z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob2otnfSPAmYzfdkvYKAXFO7sUsIIZKqKkhLZvm9428=;
 b=jDu08MI7QImbKnlK0+m2OhxvNIshOXz75FYAMi5sJTMxWNzhIORH6CzyYsmobUdSxd8SUIFEs/lYPkFMxch5xbYnjsv8RC8u2iCu83wSN/JauZEJyfhOojgpeSgtH1oc5kslDR+PN1DU3EsUvPdMxEeRimKCiEKXX54tyieCHz3hVUMp/sv89SOoYiPbIXQ68vAQlq+zYNglUaCJnw6/upx78bHEPwRwGhjKyy3nNqOxc/mHRToqDB22P0YPp2EzP7Xk7U/mBwro9HQQ1n0LfLEVPvc/Pg9DuxWOi7xMnGEHYpjRYAtb9aVSgJb9qqHrF4rOxymBklup5LHuzw8Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob2otnfSPAmYzfdkvYKAXFO7sUsIIZKqKkhLZvm9428=;
 b=nNRwse2eITAK+PefKkly/pglfU9Y15GrUOrzg5F+fvg9nlFEPhre/00QolcR699atOrFqJ6ZQWKTtdU69zkIEN8I6K9cmQIKcTglGZq/Wrj6HvgMgdkAZRk07IsIAI3koe+uJ93Z5n/4LZKYUYqYK71kKJNL0CslQk30uujUcb8=
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
 by TYZPR02MB7289.apcprd02.prod.outlook.com (2603:1096:405:45::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 08:45:31 +0000
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75]) by KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75%7]) with mapi id 15.20.7316.023; Wed, 6 Mar 2024
 08:45:31 +0000
From: "Bolan Wang(Bolan)" <bolan.wang@fibocom.com>
To: Lars Melin <larsm17@gmail.com>, "johan@kernel.org" <johan@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Thread-Topic: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Thread-Index: AdpvoTys3NfocRUQSaSnRRCqeB1ziQ==
Date: Wed, 6 Mar 2024 08:45:31 +0000
Message-ID:
 <KL1PR02MB628382F4B33785C080A9ECA089212@KL1PR02MB6283.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR02MB6283:EE_|TYZPR02MB7289:EE_
x-ms-office365-filtering-correlation-id: b8c7a8bf-4a6a-4461-a60d-08dc3db9c805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4n8wZkL2zUgPegFtJii05L/c0M1Y1WzWk4RICci+fxzcl7b5olpPg+Kbsr7/q2E44OkKz6e1/ur42KPTwGykcThxxFJ6G2gsGfmMZ0YR/8bb+GkvObwicPcaq9aQ6XHcUb31w8IyXtWhEgSlOmg9uoxgzHXf6xj9JqLee4j7cr2AEvj4V5HDAPINWe7W2MqFBbjEjDlLANQp8Yfhj/cpi7TRtiuD+3+WZkJgVUX9IHEmYV0Y6qaocRFsawgJ2Yu+MC8fQXdrhVpiOYXjyD6gc4iM0FxRouHxVzFxjOd5tvZJ4b4cAgqOsLqLHy6zZK+eeEzh7OT+gGH22rx0tUOxDR5sD5D/u3alBs4dgFi9QCrnpomO1CqU+dkx0TiAw8cJrP8mxKaECtZp+dZphmoGPwrF/aTwNwxFnu4mmKFyQeXfcw7Tf2Nca5N7tXPU12V4L56hyoLcI+KtQtMYR4jvBfRRdWk0G7h+LlXNxfuohlpIgY5Ow5SYwVL++0r0KPHnXLoIFnsfY8hN5eseR9uycK21oMFiOpnXG2VzAFmbb23VTKW+/cUrn8p/cYfRtLd6zp7oUao5iXWrRrFla6IbgA/PlU8os+69FWv7jfyWSqDL4E5MEG5OE4JED1VTJfLa5PH1G7dACDcaCzgRIRvf43SDMzGQ4O7OdWZZluKtM2W6smyxlrgrN/fkRjJfiEkkxMrt2PlFQfCPwCzwoWWwBTWzXN/DWqL5B0CpFMUbNVw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6283.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEFLcEhES05CL1FNckozWGlxMVZNK2Q1dXdITTVhZVFjN3pJYUpkcWR1ZVU4?=
 =?utf-8?B?SjZtTVJ1ekVkUEU3MmRZWGt4U2liN0RiZkhYQUJINlF6N3dMVGRJUFRjTWk1?=
 =?utf-8?B?bE50d2RyV09qU0owVGlUL0l4WFQ0T2h3eGFHZ2FUV0lrT2lXVWtzeDlWYkdZ?=
 =?utf-8?B?R09ZVDJDSUhOckFtQ0pMdHl4V1EybVhMMk5CS0NUWDhleTREdjE2T3ZCbVYr?=
 =?utf-8?B?RGpuaFcwbGFVWmlndG5xVDZ0bm13RDF0VktkUW5icnp6U1pEeVNiNmVCanhB?=
 =?utf-8?B?cjBVcWlpb3F2WUEvWGRpbm5HaVBPckNIY3dYdFp4dXo1OFVtRDIxbUxsZmVF?=
 =?utf-8?B?ZklpVDlwZ3BuNEZoSHg2ZFhweXZ3bHk3TTNOdENVb2dDMnhWcW9pY094WXF1?=
 =?utf-8?B?dy9id1A1ZGVxQmc3ZkdLTTNvOWJ2NnQzMGVWWnN4QlRjSEl4TUFVRjU1VFVD?=
 =?utf-8?B?cldZTmZlZi9nUU9XdzZMbUE1ZmhyN2xlaVh1V0ZaUlQ3eWVlS1JNcmNZSTg3?=
 =?utf-8?B?Ylhsc1ZrRHF4cE1vRDRCbTNGMVExU1dwUUwya1FWMXN4T0R0MUtyMEVhVkNQ?=
 =?utf-8?B?djBIT0J5dklNNE5seUVudzQ5b0hRMG9iS090OHdZKzhPSjVnVXplVk9taEU2?=
 =?utf-8?B?OStwZlY1MHhnVUtNNitwZkc3QlVLaXM4MWIwOGFTZ0hEcEloU2hqWjNNV1Z1?=
 =?utf-8?B?ZG03MS9BeDRIVjNWUThjcW9HN1UwcGRzTmVsYitZU1RyZ1M3YUpRZFZuQUlp?=
 =?utf-8?B?RHI3eDYwT2tGQ1BnRlp1TTJRdHAvZzBNZ0VrR0VzanR2MnlhYkpMV3U1RHdB?=
 =?utf-8?B?cVpmSWp5WnJmc09uUlZ1RXlJdDRvWTZRd3ZBaTFsMHJlQXV5OWlxTWJuUURr?=
 =?utf-8?B?ZjZTVGNvajNDTUI3cDJ4R1BrUHFxeHRzWWhGcGFsRDJ4NHNpUDFmRXBHd2tv?=
 =?utf-8?B?bncvMmc0b2ZUUWQ5QXhxeFJ5WFNiT1dUWC9ZdkREZXBJZTFyR09IaDJOMXIw?=
 =?utf-8?B?dzBqSDBaVk9FcHplZlV2WlMxdHZsWlJ0WEVQd1pjSUtTQ1U3ejl6NGVKYnFx?=
 =?utf-8?B?ZXJDSmcrRituQkJ1QW5JUkd5dnFSRnBRSHJUamxrZ3hKaFZCb2lKTVpNS1Q2?=
 =?utf-8?B?bTZIVWN0T1oxQnpQUmRpTFVLWVFFOFN0L3BITUo0Q0pYWDdPeVVvSjYxNDNm?=
 =?utf-8?B?bTlQRTFNcU83c0w4Y1czT2xrUURVNmJjN3pkdlkzTFJwMVlWZUxiaXYwWExF?=
 =?utf-8?B?Y3NGUytubzFHMDVRWFhWY2pCR3NWbEFQYVB6cllKVGFoendZZ25XZmtYbmJl?=
 =?utf-8?B?bDNCVlUyZUpWUEdVQ2FCeVJOSzUvZ0ZsZlBqRjVYazR5ODQ3NEdrcXNSdzho?=
 =?utf-8?B?TklzcjV4QWtBa3FwSG1EWXFrQ09FcUtnUGh0Slh4UDI1SDhPSnBHN2RRUElo?=
 =?utf-8?B?MTJVUURxRGxQTFVVVWhYcG9hT3BLOGQrM3FDTnUzTXViMGhRWnFoMzdXT0Zo?=
 =?utf-8?B?dmdPWWp2cGVzMHVCL200UjUxeTM0WnJUYUIrRGFocjBSTVdJZVBuYTNNdUpi?=
 =?utf-8?B?OGpuNmQvRTBOL3RQWDV0ZjBPeFZsbVN3ZVhGYzNhaStSUWxLTm9WL2c4RE9x?=
 =?utf-8?B?Zzl6S1NuNkZibWVlU1drWkJSVW9CS3p3QzgzTkpwdFlrc3dMZTJPbG9DdVZq?=
 =?utf-8?B?MjhlWW5qZVlqZWRVUHNmbGVSYnZhV2dpYitweHhxL2kvcnByWHhCVUdoWVcz?=
 =?utf-8?B?ZEF6U2VmajRDT09RMjdNSDFGUG81MWtMSDQyWENvdzBmZVFpa1daWXU5U2hM?=
 =?utf-8?B?c2YyaXJrMXpuN3VQNDJIRVZOZEV3SlRDTm11d20xZXFMSVdQTkpsY2xPcEta?=
 =?utf-8?B?ZW9SMk83N0orM01STE54ZWordy9mRVIrWkJVTjlOS3U0eU9SRy95NVdTUEl4?=
 =?utf-8?B?U3ZyZS9hK0VRblJJTU93cnVmbXlSMjZscDJvOVhLQ2p4T2NabXZkVy8rQmlo?=
 =?utf-8?B?QWRvZ0lDbXowcHhLcko4RUc5eEFQcWY1OEp1bTBsUVJ4OHJJVWxuMlY3SG8x?=
 =?utf-8?B?VTRsUERmcnE4V1d2NW1SdWZ5V0paNWZaNDd6ejFCL1JXZy9CVDZmRjZXZHpa?=
 =?utf-8?Q?/L8E2W9xYWZJXfddLalU/EjR9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6283.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c7a8bf-4a6a-4461-a60d-08dc3db9c805
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 08:45:31.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvwJg21kUzXy0+34ObEkM6ApzxOCxfL4t3ZqStqvw0fr19GefTcB5hcRevUI8qT9jCFPePWPUCQxRILCk8UUew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7289

DQo+IFRoZSBvcHRpb24gZHJpdmVyIHdpbGwgYmluZCBiZWNhdXNlIHlvdSBoYXZlIG1hdGNoZWQg
b25seSBvbiBDbGFzcyBmZiAieyBVU0JfREVWSUNFX0lOVEVSRkFDRV9DTEFTUygweDJjYjcsIDB4
MDFhMSwgMHhmZikgfSINCj4gVGhlcmUgYXJlIG90aGVyIG1hY3JvcyB0aGF0IHlvdSBjb3VsZCBw
b3NzaWJseSB1c2UgYnV0IEkgY2FuJ3QgdGVsbCB5b3Ugd2hpY2ggc2luY2UgeW91IGhhdmUgbm90
IHNob3duIGFuIHVzYi1kZXZpY2UgbGlzdGluZyBmb3IgdGhlIGRldmljZS4NCj4gWW91IGNhbiBh
bHNvIGJsYWNrbGlzdCBhbiBpbnRlcmZhY2UgKFJTVikuIFRoZSBvcHRpb24gZHJpdmVyIHNvdXJj
ZSBpcyBmdWxsIG9mIGV4YW1wbGVzIG9mIG1hY3JvIHVzZSBhbmQgY29tYmluYXRpb25zLg0KDQoN
CkhpIExhcnM6DQoNClRoZSBJbnRlcmZhY2VOdW1iZXIgb2YgdGhlIGFkYiBpbnRlcmZhY2UgaXMg
MDUsIHNvIHRoZSBmb2xsb3dpbmcgY29kZSBjYW4gYmxhY2tsaXN0IGFuIGludGVyZmFjZSAoUlNW
KT8gSXMgdGhpcyBhcHByb3ByaWF0ZSBmb3IgYWRiIGludGVyZmFjZT8NCg0KKwl7IFVTQl9ERVZJ
Q0VfSU5URVJGQUNFX0NMQVNTKDB4MmNiNywgMHgwMTE1LCAweGZmKSwNCiAuZHJpdmVyX2luZm8g
PSBSU1ZEKDUpICB9LAkJCS8qIEZpYm9jb20gRk0xMzUgKGxhcHRvcCBNQklNKSAqLw0KDQoNCnRo
YW5rcw0KYm9sYW4NCg==

