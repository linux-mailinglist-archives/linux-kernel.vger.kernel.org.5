Return-Path: <linux-kernel+bounces-110087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4E58859E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D561281942
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E884A5A;
	Thu, 21 Mar 2024 13:17:18 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73ED83CC3;
	Thu, 21 Mar 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027037; cv=fail; b=rvDRyB0b2+iLH5l6oPAGiBSahwiBVXXPIM8pMR0V+4wzbmAHuWWu5gbILXdQaCJllX+NMeJrepE55lYW1Z3ucCnEXRBQj7834Hr6kTfn+Dc5Gmrocff5NnCIOd2bOmd7F3EHUH1NsSpF9BRo5FCLrdit7Q/4m9rg14U/W1w8UVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027037; c=relaxed/simple;
	bh=BuEMAjHi8ReQXljESRZEIJ9qYqWLwqpo33UDqBeb20U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AhMVuCTZjaart5wMQAZrvQGuliVoHV1+PLJGwgADosForrowNCdQ7desyCx1K0nx4uDBU/mOZE5c5hP7Lsk1g/e8KuS0+jB2cQ6aqgFCHIskxareu2VgNUg4QKeloXCnwPwZeaOSuS+zzvVOEV3+U8yJv+Niigk6iOMxkAINVYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iONTgeeRoC3SJatUCaV975A5umbNDNwBanapXYoa2/DV6WyJfyZOILzTwNcD4fb88xrbjSg2YUoRT0YDAztAttPe9usJK7pf2xpMaS9IxJdB3Yv+n++0BCY+nVtC06L2eCRdQfPxYdCxj+RXR7E01Q4ZKqh+PR61muDdrMhTQK3qETgpD5tK/A4k0V+xlfMC4UabNhORx5sdPxFVSkChXhKeYSnKEle/KECWMU2Ez2SH4sV2mj3pNDNOUDbH6LWpdZz/ANCifd/aV2W1BBxgnzM6QLcMcgF+jRQE0vaf4p3KPemIvS7iL3BqS+fizellJ7ekridw6EQfaitZFfiJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuEMAjHi8ReQXljESRZEIJ9qYqWLwqpo33UDqBeb20U=;
 b=G2WTm5YBebLslezpNm90Ka5W5ZK5PREKTQM8eNDYB7ynu8jX7/NQug/TmGFosXIF0qN1W5Y5OcoGiWPeGClmfQRZmt1vN4eJdkMLa5h3J/V2R0PvU67qn7QfDxSn+e7wVtu39zsDdPx3L6f7T70DpFeO2BF0/PdylHG1yLnA2KlNorynFXjiwQYgfzTHHFJTJMvdAmVTgNRgTVQhVGsEqSxlkCzSTS++QBbD9TvG3uviVl2v5tvgxpT0K0/kNcJ2U2zMaOdsTwJ5MyeQ7jTSA7xTdIgk2RVf7MfH+tJpZGM1PAjXb+60LaRf3xdOjlrtfo72wJQXGLojBqvu52c8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0750.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 13:17:03 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Thu, 21 Mar 2024 13:17:03 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFt2MV0gc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZl?=
 =?utf-8?B?OiBSZW5hbWVkIGNhcHR1cmVfcmF3IHRvIGNhcHR1cmVfZHVtcA==?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbdjFdIHN0YWdpbmc6IG1lZGlhOiBzdGFyZml2ZTogUmVuYW1l?=
 =?utf-8?B?ZCBjYXB0dXJlX3JhdyB0byBjYXB0dXJlX2R1bXA=?=
Thread-Index: AQHaa6YnLa1tXVh+aUef9+vjDvqGG7FCFPIAgAAiCwCAAA4gAIAABzxw
Date: Thu, 21 Mar 2024 13:17:03 +0000
Message-ID:
 <SHXPR01MB0671467C1D3FF93B58B0C8F2F232A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240301070025.11144-1-changhuang.liang@starfivetech.com>
 <d741106e-5bff-441a-beb3-5ef1c81d912a@xs4all.nl>
 <SHXPR01MB0671C5F9FD505906E460FA2FF232A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <443e9909-7036-48a4-a1ea-c3908263282e@xs4all.nl>
In-Reply-To: <443e9909-7036-48a4-a1ea-c3908263282e@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0750:EE_
x-ms-office365-filtering-correlation-id: f5535278-c36d-4b5d-0eed-08dc49a932ff
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r7J65Q0fKt9uX8+nxNB7SRj6Z64u2MNGePbBGfm7vPiv13a3LZa93CZRQWIvq6RSS10qaQyuCj2f8Ymb1J+kBG4qvpUbyvhI0QDq+anodW5YHagXR2u43PDowqUHxaR4Rk9d1eqWAbKFm9HgdGNa05kA8tdcEV669pHjJticEPX/dDbIxFawWfygH6ufNX0TQQo3G/F67xHKufAsYanvGaa3vSqgzB6ekbr+egJlZz34WB8o6naHTmSEkRbjVrihefm6XBuFYypOl6eXce8w0H5pu29mFgT00tLhyZXYXFmuAstP6XgxWqz436HgvGihUwfr8eX4iVDhhqxqefv2CYGK5DyKPD03VQd4pZPMKG9iMTzV5lbLLiN2C9GQmpg4NUhzcFQTA88NQRY5MFmpY4KehLoNNV+teWqKBqC0IRqJlVwkcK129SQhlHmBNLqIpeit1hx5ipaoDvfBscISR76TjZpeyCJmhi5WQd2YCqdmD8fzWpHQdcgYZEwiP8lCsmODdeuPu76yf+NDcdTy+oagWX8+TaBp+WqBoMh6JkL6Zu3C5wLEMhQbucnxO4Exdh4DXv3EBgL+ZcOOPCt3Tek1ocx3CSrBZhEULrl9hUObSis082FD9msqFyWupocg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1dHYk1zR3VpaGE2ODlQQnQwSXNMc2NndzE1c2RqZk1DRGw3MnBQdVVVVmlX?=
 =?utf-8?B?d3N5RWgzVWZrQUlJMU5pNUxDZ09wUmpqNU40L21jMDdrYzdSOG1HRlp5MG41?=
 =?utf-8?B?RDBhRWlDRUNXZUJHUUV2a0ljdE1OcVlUNFh0SzdicGR5MStkbjE1TEJiTTNS?=
 =?utf-8?B?L0ZtUXpDaWRKb0QrY3V3QkxDS2drRE9qTWJhMnBJYm44eFVxQ3ZOSmZFOFRz?=
 =?utf-8?B?RFpSQk43alhDeUF5WXZzc2J2S3Q2OFNCbHMzUFlFMG5YTEJDcjZzY1RKSmpJ?=
 =?utf-8?B?NzZHSmFNbDI0UCtTRlFBTkZlaEpDS2NsZ3k5ZDJIOVdxUW9qdTRPbTUxNCtH?=
 =?utf-8?B?b2VQVTVFUnJkQkFWVFBiNHI4K2FLVnk5NnFRbmtnZjdFMGtxdlM0SHRtYXZ0?=
 =?utf-8?B?M1gvOVN2QTNvdG5SaGgzQjI0ejJUTUlxQ29CVFB0NVBMaU1VQ3YwbHRZeVlx?=
 =?utf-8?B?b2I5Vjk0RXcwQ3hVYUNtaTdFN3Y2bkNOclI2eG91MnFiSFMyVkpkNUlQK1pR?=
 =?utf-8?B?Y1h4R2dtOUhpUHpZNTh0SHA2UUpOK0NiOEtVYmFUNndhUDc3ZE1QU3FQdlJo?=
 =?utf-8?B?Y3h6blY3ZTVrWmEvWFU3bEdqVUlxem9mYkwrRndxamQ2V29TWmVDYzZRU2xE?=
 =?utf-8?B?V0d0ckxLWXhURk1xd0pTdlFZMzYxSU0rR0FOTHg0QVVnYzhqL3BuVm9Wcm55?=
 =?utf-8?B?NTVpYS93WTJSZUJmYmtnc2tuUC9JaUtMV2oxTTRrVjVKT0MvZEY0NUFnOHBW?=
 =?utf-8?B?V2Z5SjJid1A1ZlBocUFzNXlpNFZOUC9MS2JoUlpLVlhIREs0dmZ6aWtCZnZU?=
 =?utf-8?B?bmo5NzRoUGFqdGdsTit1eTBRLzZVU2diNWwyRXRTUXBtZVduamJVZDA3WjRu?=
 =?utf-8?B?eURWTE5lTWhBek00VkQ4TWFoWXREWTR1UnJyYVppY2l4RDdkRVNYVS80M0Qw?=
 =?utf-8?B?R2R5UlRqbVpScUhQaWVoOTRIeEJFS2pNL1pXMk9KMmVnT01LRmZxYlVobU0w?=
 =?utf-8?B?dHdiTEVmMjRZWGtwanZ4UVl2aDZRRjRrMkhHbFJWV2g5OTdkdmY2YjgxckJI?=
 =?utf-8?B?dGNKYUNVakJXN05lb2llRjdkekVRNjRwbVFOZkg5MEVnRXJKbmFUdm1iQ0ti?=
 =?utf-8?B?S1JYdnMxMlUvRzFyU2toZjNBaDAyNGMxaVlTS3N3cVZPM2toUHdIRkdUUTVq?=
 =?utf-8?B?c2QyWHdvWFFoNzROVVB5SHcwcHp5QzFqZTlOUGRncW1MSVFMZW1WMjdjMU5k?=
 =?utf-8?B?UTk4NXUydFZTVUhOZlVxemhTM2daR1JPenkyaDFoUmV4OUpXOWdiL2dUNHl5?=
 =?utf-8?B?VU1aYnBrSkZpUS9WRGUyelhkSGxkR2x0K0FlV0RDV0hnNDh0L1BXQzQzam9m?=
 =?utf-8?B?NEh6M2s2VlZ3UHhqYWhNcUcrenU3Vnk0cStrZTVVZWtYMG0zNElzTGpOMlJr?=
 =?utf-8?B?V1V6aGZmb2t4Umxzb0pYRmpkd1RPRkJ0N0ZRTDR4NXhPWGlxWXFBdmNJdTAw?=
 =?utf-8?B?QWFVQ0FmRG1JQmdub3RGdHpjZWlQeURISENoL3lrNjJSRjVwZXJkdWpWaDJQ?=
 =?utf-8?B?c2h5cXQ5eXJnMGNGcG9YU0FTQW9IanFYVGgvNk1TNnU3THUzWWRqUU5JRTVy?=
 =?utf-8?B?VmxBV2EyMTJpbzJzcE1TOHB1Z1p5dm51aElOS3Q3RStaMjRYdG5ZRWVhOFJE?=
 =?utf-8?B?cVpzMVgxWTMzc3RtR0NhSW1Neko1cXE1RllGbHBJWnRFZWNia1Njc3Z1VUtE?=
 =?utf-8?B?NGIzZVlLQ0hyd053MDVMdnNVOVJoa25zek5Xc3Q3YmFBNmhXNmM5TTQ5dTc2?=
 =?utf-8?B?Wkp0WTFvL1M4akpKb1NmOWtOelhRaXNNV0FSa3ZXNTRnUEJOb2JQZVF6UFI5?=
 =?utf-8?B?N1FBdEkrWnA5VmJIOCtHWTBVb01NdTVDcjRMY2tVbDRyRXkwbWkzd3p3QTNN?=
 =?utf-8?B?UWc2QTZwL1U1M2tockNUS3ZEQkFqWE1wNDdveEtsMUxrMVJvRUt5WVNIbm4v?=
 =?utf-8?B?TTZDZStjYzdKMDNFRFdLRWlwd3l0R2ZjcmlET2lDeDJXS0tPY1B4ZHd6R0xi?=
 =?utf-8?B?d28wZ3pyZTJNOE4zUnRSR1ZrZE5JbHJ6NkwyRVFzSGYwRzJURVBZVGZqT1kw?=
 =?utf-8?B?dC9RWUNmdkN4WXlsLzMxOTdHQXRkS3A0VCtvUUowdEZHYjBQeTdNWUcwTG9y?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: f5535278-c36d-4b5d-0eed-08dc49a932ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 13:17:03.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n15/Fj8JDY4NTW0kOKgWUfAkmbciT+P8f7YXnE78iDVJu/jOdEnHMuoNBogMg+u4bYYgvZASvALZZONFv7NzTWlHhLYQzS5n0rzk8na8Ob0OgAAjXGQmIDrSmtA8Lc7x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0750

PiBPbiAyMS8wMy8yMDI0IDE6MTcgcG0sIENoYW5naHVhbmcgTGlhbmcgd3JvdGU6DQo+ID4gSGks
IEhhbnMNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCj4gPg0KPiA+PiBPbiAw
MS8wMy8yMDI0IDg6MDAgYW0sIENoYW5naHVhbmcgTGlhbmcgd3JvdGU6DQo+ID4+PiBUaGUgcGl4
ZWwgZm9ybWF0cyBjYXB0dXJlZCBieSB0aGUgY2FwdHVyZV9yYXcgdmlkZW8gZGV2aWNlIGRlcGVu
ZHMNCj4gPj4+IG9uIHdoYXQgcGl4ZWwgZm9ybWF0cyBjb21lIGZyb20gdGhlIHNvdXJjZSBkZXZp
Y2UuIEl0IGlzIGFjdHVhbGx5DQo+ID4+PiBkdW1wIHRoZSBzb3VyY2UgZGV2aWNlIGRhdGEuIFNv
IHJlbmFtZWQgaXQgdG8gY2FwdHVyZV9kdW1wLg0KPiA+Pg0KPiA+PiBJIGRvbid0IHRoaW5rICdk
dW1wJyBpcyBhIGdyZWF0IG5hbWUuIEkgdGhpbmsgd2hhdCB5b3UgcmVhbGx5IHdhbnQgdG8NCj4g
Pj4gc2F5IGlzICd1bnByb2Nlc3NlZCcuIEFuZCB1c3VhbGx5IHRoYXQgaXMgaW5kZWVkIGNhbGxl
ZCAncmF3IGNhcHR1cmUnLg0KPiA+Pg0KPiA+DQo+ID4gU3RhckZpdmUgSkg3MTEwIFNvQyBhbHNv
IHN1cHBvcnRzIHRoZSBvdXRwdXQgb2YgdGhlIHJhdyBmb3JtYXQgZGF0YSBmcm9tDQo+IElTUCBw
b3J0LCBzZWU6DQo+ID4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAzMDYw
OTMzMzQuOTMyMS0xLWNoYW5naHVhbmcubGlhbmdAc3RhDQo+ID4gcmZpdmV0ZWNoLmNvbS8NCj4g
Pg0KPiA+IFNvIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIGNhbGwgdGhlIElTUCBvdXRwdXQgcG9y
dCAiY2FwdHVyZV9yYXciLg0KPiANCj4gSWYgaXQgaXMgcHJvY2Vzc2VkIGJ5IHRoZSBJU1AsIGhv
dyBjYW4gaXQgYmUgJ3Jhdyc/IE9yIGRvIHlvdSBtZWFuIHRoYXQgdGhpcyB1c2VzDQo+IEJheWVy
IHBpeGVsZm9ybWF0Pw0KPiANCj4gVGhlIG5vcm1hbCBjb252ZW50aW9uIEFGQUlLIGlzIHRoYXQg
dGhlIHRlcm0gJ3JhdyBjYXB0dXJlJyBnZW5lcmFsbHkgbWVhbnMNCj4gdGhhdCB0aGUgc2Vuc29y
IGJheWVyIGRhdGEgaXMgY2FwdHVyZWQgd2l0aG91dCBiZWluZyBwcm9jZXNzZWQgKG9yIG9ubHkN
Cj4gbWluaW1hbCBwcm9jZXNzaW5nKS4NCj4gDQo+IExvb2tpbmcgYXQ6DQo+IA0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAzMDYwOTMzMzQuOTMyMS02LWNoYW5naHVhbmcubGlh
bmdAc3RhcmZpDQo+IHZldGVjaC5jb20vDQo+IA0KPiBJIHRoaW5rIHlvdSBpbmRlZWQgbWVhbiB0
aGF0IHlvdSBjYW4gZ2V0IHRoZSBwcm9jZXNzZWQgSVNQIGRhdGEgaW4gYmF5ZXINCj4gZm9ybWF0
IHRocm91Z2ggYSBzZXBhcmF0ZSB2aWRlbyBkZXZpY2UuIFNvIEkgd291bGQgY2FsbCB0aGF0IHBv
cnQNCj4gJ2NhcHR1cmVfYmF5ZXInIGFuZCBrZWVwIHRoZSAnY2FwdHVyZV9yYXcnIG5hbWUgZm9y
IHRoZSBwb3J0IGZyb20gdGhlIENTSQ0KPiByZWNlaXZlci4NCj4gDQoNCk9LLCB3aWxsIHVzZSB0
aGlzIHdheS4NCg0KUmVnYXJkcywNCkNoYW5naHVhbmcNCg0K

