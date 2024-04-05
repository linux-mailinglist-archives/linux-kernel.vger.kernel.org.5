Return-Path: <linux-kernel+bounces-132292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B0899298
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F4C1C22F97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184815258;
	Fri,  5 Apr 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="a5f+AcMH"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022019.outbound.protection.outlook.com [52.101.154.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DC632;
	Fri,  5 Apr 2024 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276834; cv=fail; b=qouzSaU5aL3j8OHZN904ZPugz3ZZuiypkfEeUsKWEIL/4TpApHTFKKTKZJpDqLrfVwUSs4dCA7ESCu8AIO2iXpqF65pWRfA2E/ykNg7ybRlxnk0faSE9G9cbK3cfdoDEMDzP1fYUUOvCukE1L/B/aTexMBvpLCtchbywqBk9fcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276834; c=relaxed/simple;
	bh=cIlZIvB3DezyoiMEqX3+cv/Kk1hI3j4PXJPFjjcdYiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FARaIKs2JSyi4opD0I8EBzc0U+8Rh/rCQmls3WAJ/PqmwwncPUOIqC254aMyRFlCdI4kDUNN8QfJPx3fBNNqAClovEp0DczPlSZ43elEWls9iWg2pmUXbTp6XtLkI0zWDc9Lg/PjeeVFM/7Y41pdwVwkG+F6GOBmyJ/1Mm4WzqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=a5f+AcMH; arc=fail smtp.client-ip=52.101.154.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM8woVnQowF/lBXYSdejF0EL5NNVwQw4tExBdMBFxu0vrtO7hOVUiBumWB7vwshQeOknshLG9nBrWZCcEIgsl22TKsVVMPtNK069NehMoo0NjcQIwaAwMlh0HaJVhIIM9a/AsdSCFk60eArE2l6psIhIKOwlMPIn9AY9x64BUKFY+TF2H+ht2JvsMENf76rbir7m7+33MALgaL0Kgki9QPRKDMyUVLmFjNj5vVTRwupxWRrl6jiOHGgHxRre5VxtU8B48Q2d1fy9Uf4dYFzr+twQH8Ke35WGVwNDprBMlj6lsdUnnCKV+dQHLy75itdkJgKgoGPdo3IfFJKmBdQO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIlZIvB3DezyoiMEqX3+cv/Kk1hI3j4PXJPFjjcdYiI=;
 b=PW07xXd8pLcyox2a93vtlaRv5YoWjA61yOHSfL8RhX3h/FSE0961yzIYgMRTsVFmKuo7+2sOfYbCGQQrNqNx47FCGH50Ll2GaYFngdygWAfiYSZUVZYTcjgUuLj4MP03afmbjzNB3U3Wrujt4BUNPrd7VMZz8+9goprmVQmvARVy2mcLj9xuIazLQ365B5AMhiklZ7W0AD3Wb7GlisrQuqQo5wjcP6MGTWZ+9jHmvuTsKNk5XSx368I+kR7LEXgk1AGO9z5b6ffa/Zg8Mu/CaL/ihlj+Q9WQoi1cwhcyhW2Pe2//sSKWZx7o38pWxQO+2T6X5ksGbBFTHDYjViFwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIlZIvB3DezyoiMEqX3+cv/Kk1hI3j4PXJPFjjcdYiI=;
 b=a5f+AcMHRwI54MEXaPkewmnIbgrRgwve9SzPawTlS6KwLI4inkXZUpU0MKaJt/BH55FGc3BD4Kspd44hJyTrtA9G2WWSZej2+Z2dhvrFqsjiHVUYX9mIZOJWT30RDjIbPFSOcpoWQqLPRo3hvzUnkUYrQJy8LpVwHd1KG7lVte0=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE2P216MB1476.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 5 Apr 2024 00:27:08 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 00:27:08 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
CC: "mchehab@kernel.org" <mchehab@kernel.org>, "nicolas@ndufresne.ca"
	<nicolas@ndufresne.ca>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nas Chung
	<nas.chung@chipsnmedia.com>, lafley.kim <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>
Subject: RE: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
 format,SPS/PPS generation for each IDR
Thread-Topic: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
 format,SPS/PPS generation for each IDR
Thread-Index: AQHac6LGzHawQ158fESNuZ0k+bm+6bFIEONwgA/QRQCAARdhYA==
Date: Fri, 5 Apr 2024 00:27:08 +0000
Message-ID:
 <SE1P216MB13037EA4E86A78AEB12C94F7ED032@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
 <SE1P216MB1303D2A884C6F904553E4432ED362@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
 <20240404074634.fcxv62xi73ie2nhz@basti-XPS-13-9310>
In-Reply-To: <20240404074634.fcxv62xi73ie2nhz@basti-XPS-13-9310>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SE2P216MB1476:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YkzZIZdbW5RjZKVKQCoALwcM4quUma0HSlp5oCrRd2mlbQMT+cGwhL3er0m4eSvq4C53JG+euT/5Rt4qQ+knTFimHVoG5yfIuEWTfDED9GNubLETrdOko5AftG1nX6J+55jNpqVn13caFAS1LOnQucKhxZsSZ2zREbmOfFia0XBX0FxAKY8kewO2pT8cMar2WONdwG1E9jiHbAzW8gu5hXrM5rzU4gN8hVMUPh23B3ip9+AWf166LWsAmPxsewKUQ49WoFtme9NK+JTwQDIGLHM8Vc9eHDriA8wqbPbesXe38MIjwv5hnQOH0bSzkNqcpnJ75n6hYgQJD1t0v7ze/3n4SrgHwGjlcEB0vb4srpPYyos4Pwef3I3AVwA+FkaFir8fP/3wamqO0gXPLeMGy06xWNzh+ffpamVsXqfdjdSxmRweEDTr40oplhW6hNUz5pxIPwhM6btiaM6spLIB/o+52/CKjMXgrBQJ4h9LRlcZ9RTcGPojXh4uX4sH0nX4QbR2lqp45Dm5qYI+Cl8RZrJ674ay0keTMHjOlPWUf4jCe0roOoltyzja5RhHDRPNXrXTg7Fl0FMtKS526hm3rvVYpX3C5Fv54xB0kxDzJn0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlpySjJsMVBjRUdKYUZVNUYxd0JzRG5rT01DUmp0cmR1WDJCT0VyTGNNTXVx?=
 =?utf-8?B?RVRaM05lbWpvaU03K0R2T2JnNFNpMisrSjN5WEVUd240ZFU1SmlZeXQ0UGRH?=
 =?utf-8?B?ZE83Z2tKSzh4TndRY1FTajU0ZFo1QlJPQ0hKYWFtU243emloVng3S1dXSzh3?=
 =?utf-8?B?emlkNVBXcVNuYTFybU5UcWxsbm5SR21SRTVmVEF3SnFNOUNIMzVVamgvQytL?=
 =?utf-8?B?ekRJVFdjMUJUcXRuQ2NRQnVmTnVTUUUzKzJxTEoyKzRZMk1Vcm1sRXVnb2di?=
 =?utf-8?B?L0NvRHZXUHhIS2xWVWNKYXp2R1QzN3JIQ3lKalNSVGY5RmFjSlBWa08rZWlt?=
 =?utf-8?B?bU1zeEkzK3gwTHRaaUhSMWNuTmY1K1lXcWJHVEdwbGgwTldwaWhZK1EzVVla?=
 =?utf-8?B?MkFFWFZGaTVVaVVVYjNNd2FvV3FDV2ZtRGpsR1lldi9vZ2ZKQ3dnYzZNVHlZ?=
 =?utf-8?B?RkxhK0NTdEpMMGRnWVpxWFQ5MnJsS2UrRzJBb0pTbEZubEJZUnArajFXWVMv?=
 =?utf-8?B?ZzVTZVVidFNDa1VsWDZHTnkySnZCN3k3WWsxazY4ZUFMN2dTYWVEQm94SVBy?=
 =?utf-8?B?SUs2Rm5xVnlpcVp1ZW55SXVRRjY3NzZwYzVQMkZaNm1QY1pTRXc5UFh0ZlVp?=
 =?utf-8?B?Y0FsZHhUZzhTL212aTBoWTRWUmRzM2d2OXNRWmpEeXVjUUpwVmJxZDBNdGdq?=
 =?utf-8?B?WUY1Mndta2ZONElyVU0yNnBKbFIzZzQ3N2czQlFNRHByc0lKaVlPUGx0ZTZx?=
 =?utf-8?B?amx1OW1IdGs4ZlJ4ZmM1UTRaQ1l5UEcxUHZ2S1BhRVg1Zkx6dlFPbkUxVjl2?=
 =?utf-8?B?cURoU2g0RFh3UkxZL0c3Q014YXVLUWJGaGhhc1U3Q25zd3gxNWgvdlZhUGg1?=
 =?utf-8?B?M0NsVTdPaUM2WlZYb1VFa2pubndRd3hLWUpjV2k1SmJadFZ5QUpCTHUvRTU5?=
 =?utf-8?B?V3lkekZCbGVqSGIySkpBUUVuL0FtY2ZXdTNQdHA3YmtBWDNMVUFGOEVCcU1C?=
 =?utf-8?B?K3ZjQm1WemhUdmZJd1VTVDhXajJwQ0YweHlmWStxUzQybzhXcEFrNGRPQVdH?=
 =?utf-8?B?K00vRjBiMlFaR20wSTFyR0JUaFIwYWxTeFZWdzhCbnVZZ3JiYW50TjNCVzZX?=
 =?utf-8?B?Q2tDQXBXbjRaOHlyYzlaNmlaZXNBbkhjK0h3MXlPd2lPUUQ3TFVXMzdUaUEy?=
 =?utf-8?B?TUpNc1REYW9IbENHYnJJaHd2RU1iWUI1UVlnSWdQM3g3Ly9zd3NQNWxpaG1i?=
 =?utf-8?B?SGFtOHJKZCtMTlg2Z2ZmRnBRemtQVnZYbi9jdXdjY0xQQm91NTNKb1Nud3ZR?=
 =?utf-8?B?OGd0OVJlOWMxWlhSTWhyRi9aN1J1N0U5TVRTdnhPaDdrV2R5QlZiK2JFMWhP?=
 =?utf-8?B?VllrMDBWRU9SYVlJQW84SzIyQTUrcGxjRWtCVDdJUTdCZk9obi9KYTlMWWFo?=
 =?utf-8?B?MHlvc21aeHRsM0VibUc4ZEFEQnBCeFFmZUtXT0xaRmYvT3RYTTdVSldPd293?=
 =?utf-8?B?bk90K2NxM2hNNEgybCtqNndOQjFoYjNoMTJMWU9uNitkVGxKUExublY4YWcy?=
 =?utf-8?B?ajg3WENCUUFwNHdxOE10VmxoWiswekJBRUVvS1N3b2s2eUMyci9VYXNQRVpY?=
 =?utf-8?B?UWpjMjd1K1l4Rmc3ck5tZGYrM0dXUVFqTHYwU041Mlp3RkEvWGRwMEJja3pa?=
 =?utf-8?B?YjhzV1k5bllzTlk5USt6MlVJQzVNU1N5Y2c3NkJRb0lPUlNoMmZ5RnV2SkpG?=
 =?utf-8?B?M2ZDSEQyalpaaThYdTRVWCtwNXh3aHhHb0Y2Ty9BcUFKZis4aThaK1lCZDBP?=
 =?utf-8?B?VEU1YTRRUkIvdTAvZ05oU0hIZnZHK3ZrQlNBT1FaN25taEJCZE5jeWxEcjcx?=
 =?utf-8?B?TzVVenVhL3JxSU1Rb3VrOVNYbnM1QmJGcGIzd2lVUDhKNnZUQjU3YUVvNk5k?=
 =?utf-8?B?OWpiaGJsaW9mMVJCOHVaY25xd25QMm5LL2F2NnFXYUo3dFFGTkNnWTdJeTVs?=
 =?utf-8?B?M0Z6eCt5RVhwZys5aWRwR2J0eFRRMWZOVnVNSHZsblBmRllSSTNHTW10TkE3?=
 =?utf-8?B?dU5FMDc5cnQ0WFl2MTVjekpUSTZFWVB2cWJheXF3Tk1jV2pYSkMrTVZvcjIx?=
 =?utf-8?B?Vk5JOGRuK0E3dVdYRTJrbkVKdlZmRllldVJtQ056NC9YbENGemQ5NG9IaVZ1?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 347aa852-43b0-4672-375d-08dc550720dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 00:27:08.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skKXdL1JEZp8pzlzXFaINEW9mDVm7+Rfdyq1vWzaj002xms+MZjpFX+rVKwxJUCtmHywbTwRQSgv0gmPIYoA9tmA7bq6ZCubdteNgVTE5Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1476

SGVsbG8gU2ViYXN0aWFuDQoNClRoYW5rcyBmb3IgeW91ciByZXBseS4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzZWJhc3RpYW4uZnJpY2tlQGNvbGxhYm9yYS5jb20g
PHNlYmFzdGlhbi5mcmlja2VAY29sbGFib3JhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmls
IDQsIDIwMjQgNDo0NyBQTQ0KPiBUbzogamFja3Nvbi5sZWUgPGphY2tzb24ubGVlQGNoaXBzbm1l
ZGlhLmNvbT4NCj4gQ2M6IG1jaGVoYWJAa2VybmVsLm9yZzsgbmljb2xhc0BuZHVmcmVzbmUuY2E7
IGh2ZXJrdWlsQHhzNGFsbC5ubDsgbGludXgtDQo+IG1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTmFzIENodW5nDQo+IDxuYXMuY2h1bmdAY2hpcHNu
bWVkaWEuY29tPjsgbGFmbGV5LmtpbSA8bGFmbGV5LmtpbUBjaGlwc25tZWRpYS5jb20+OyBiLQ0K
PiBicm5pY2hAdGkuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5EIFBBVENIIHYyIDAvNF0gQWRk
IGF1dG8gc3VzcGVuZC9yZXN1bWUsWVVWNDIyDQo+IGZvcm1hdCxTUFMvUFBTIGdlbmVyYXRpb24g
Zm9yIGVhY2ggSURSDQo+IA0KPiBIZXkgSmFja3NvbiwNCj4gDQo+IE9uIDI1LjAzLjIwMjQgMDY6
MTksIGphY2tzb24ubGVlIHdyb3RlOg0KPiA+SGVsbG8gU2ViYXN0aWFuLCBIYW5zIGFuZCBOaWNv
bGFzDQo+ID4NCj4gPkNvdWxkIHlvdSBwbGVhc2UgcmV2aWV3IHRoZSBiZWxvdyBwYXRjaCBzZXJp
ZXMgPw0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxheSwgbWUgYW5kIE5pY29sYXMgYXJlIGN1cnJl
bnRseSBxdWl0ZSBidXN5LiBTbywgdGhlDQo+IHJldmlldyBvZiB0aGUgcGF0Y2hzZXQgd2lsbCBi
ZSBkZWxheWVkIGEgYml0IGxvbmdlciwgY3VycmVudCBnb2FsIHdvdWxkIGJlDQo+IHJldmlldyB0
aGlzIHVudGlsIHRoZSAyMHRoIG9mIEFwcmlsLiBJJ2xsIHRyeSB0byBrZWVwIHlvdSB1cGRhdGVk
Lg0KPiANCj4gR3JlZXRpbmdzLA0KPiBTZWJhc3RpYW4NCj4gDQo+ID4NCj4gPg0KPiA+aHR0cHM6
Ly9wYXRjaHdvcmsubGludXh0di5vcmcvcHJvamVjdC9saW51eC1tZWRpYS9saXN0Lz9zZXJpZXM9
MTI0MDQNCj4gPg0KPiA+DQo+ID50aGFua3MNCj4gPkphY2tzb24NCj4gPg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBqYWNrc29uLmxlZSA8amFja3Nvbi5sZWVA
Y2hpcHNubWVkaWEuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE1hcmNoIDExLCAyMDI0IDc6NTYg
UE0NCj4gPj4gVG86IG1jaGVoYWJAa2VybmVsLm9yZzsgbmljb2xhc0BuZHVmcmVzbmUuY2E7DQo+
ID4+IHNlYmFzdGlhbi5mcmlja2VAY29sbGFib3JhLmNvbQ0KPiA+PiBDYzogbGludXgtbWVkaWFA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBodmVy
a3VpbEB4czRhbGwubmw7IE5hcyBDaHVuZyA8bmFzLmNodW5nQGNoaXBzbm1lZGlhLmNvbT47IGxh
ZmxleS5raW0NCj4gPj4gPGxhZmxleS5raW1AY2hpcHNubWVkaWEuY29tPjsgYi1icm5pY2hAdGku
Y29tOyBqYWNrc29uLmxlZQ0KPiA+PiA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEuY29tPg0KPiA+
PiBTdWJqZWN0OiBbUkVTRU5EIFBBVENIIHYyIDAvNF0gQWRkIGF1dG8gc3VzcGVuZC9yZXN1bWUs
WVVWNDIyDQo+ID4+IGZvcm1hdCxTUFMvUFBTIGdlbmVyYXRpb24gZm9yIGVhY2ggSURSDQo+ID4+
DQo+ID4+IEZyb206ICJKYWNrc29uLmxlZSIgPGphY2tzb24ubGVlQGNoaXBzbm1lZGlhLmNvbT4N
Cj4gPj4NCj4gPj4gVGhlIHdhdmU1IGNvZGVjIGRyaXZlciBpcyBhIHN0YXRlZnVsIGVuY29kZXIv
ZGVjb2Rlci4NCj4gPj4gVGhlIGZvbGxvd2luZyBwYXRjaGVzIGlzIGZvciBzdXBwb3J0aW5nIHl1
djQyMiBpbnB1eSBmb3JtYXQsDQo+ID4+IHN1cHBvcnRpbmcgcnVudGltZSBzdXNwZW5kL3Jlc3Vt
ZSBmZWF0dXJlIGFuZCBleHRyYSB0aGluZ3MuDQo+ID4+DQo+ID4+IHY0bDItY29tcGxpYW5jZSBy
ZXN1bHRzOg0KPiA+PiA9PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPj4NCj4gPj4gdjRsMi1j
b21wbGlhbmNlIDEuMjQuMSwgNjQgYml0cywgNjQtYml0IHRpbWVfdA0KPiA+Pg0KPiA+PiBCdWZm
ZXIgaW9jdGxzOg0KPiA+PiAgICAgICAgICAgICB3YXJuOiB2NGwyLXRlc3QtYnVmZmVycy5jcHAo
NjkzKTogVklESU9DX0NSRUFURV9CVUZTIG5vdA0KPiA+PiBzdXBwb3J0ZWQNCj4gPj4gICAgICAg
ICAgICAgd2FybjogdjRsMi10ZXN0LWJ1ZmZlcnMuY3BwKDY5Myk6IFZJRElPQ19DUkVBVEVfQlVG
UyBub3QNCj4gPj4gc3VwcG9ydGVkDQo+ID4+ICAgICB0ZXN0IFZJRElPQ19SRVFCVUZTL0NSRUFU
RV9CVUZTL1FVRVJZQlVGOiBPSw0KPiA+PiAgICAgdGVzdCBWSURJT0NfRVhQQlVGOiBPSw0KPiA+
PiAgICAgdGVzdCBSZXF1ZXN0czogT0sgKE5vdCBTdXBwb3J0ZWQpDQo+ID4+DQo+ID4+IFRvdGFs
IGZvciB3YXZlNS1kZWMgZGV2aWNlIC9kZXYvdmlkZW8wOiA0NSwgU3VjY2VlZGVkOiA0NSwgRmFp
bGVkOiAwLA0KPiA+PiBXYXJuaW5nczogMiBUb3RhbCBmb3Igd2F2ZTUtZW5jIGRldmljZSAvZGV2
L3ZpZGVvMTogNDUsIFN1Y2NlZWRlZDoNCj4gPj4gNDUsDQo+ID4+IEZhaWxlZDogMCwgV2Fybmlu
Z3M6IDANCj4gPj4NCj4gPj4gRmx1c3RlciB0ZXN0IHJlc3VsdHM6DQo+ID4+ID09PT09PT09PT09
PT09PT09PT09PQ0KPiA+Pg0KPiA+PiBSdW5uaW5nIHRlc3Qgc3VpdGUgSkNULVZDLUhFVkNfVjEg
d2l0aCBkZWNvZGVyDQo+ID4+IEdTdHJlYW1lci1ILjI2NS1WNEwyLUdzdDEuMCBVc2luZyAxIHBh
cmFsbGVsIGpvYihzKQ0KPiA+PiBSYW4gMTMyLzE0NyB0ZXN0cyBzdWNjZXNzZnVsbHkgICAgICAg
ICAgICAgICBpbiA5NC43ODIgc2Vjcw0KPiA+Pg0KPiA+PiAoMSB0ZXN0IGZhaWxzIGJlY2F1c2Ug
b2Ygbm90IHN1cHBvcnRpbmcgdG8gcGFyc2UgbXVsdGkgZnJhbWVzLCAxIHRlc3QNCj4gPj4gZmFp
bHMgYmVjYXVzZSBvZiBhIG1pc3NpbmcgZnJhbWUgYW5kIHNsaWdodCBjb3JydXB0aW9uLCAyIHRl
c3RzIGZhaWwNCj4gPj4gYmVjYXVzZSBvZiBzaXplcyB3aGljaCBhcmUgaW5jb21wYXRpYmxlIHdp
dGggdGhlIElQLCAxMSB0ZXN0cyBmYWlsDQo+ID4+IGJlY2F1c2Ugb2YgdW5zdXBwb3J0ZWQgMTAg
Yml0IGZvcm1hdCkNCj4gPj4NCj4gPj4gUnVubmluZyB0ZXN0IHN1aXRlIEpWVC1BVkNfVjEgd2l0
aCBkZWNvZGVyDQo+ID4+IEdTdHJlYW1lci1ILjI2NC1WNEwyLUdzdDEuMCBVc2luZyAxIHBhcmFs
bGVsIGpvYihzKQ0KPiA+PiBSYW4gNzcvMTM1IHRlc3RzIHN1Y2Nlc3NmdWxseSAgICAgICAgICAg
ICAgIGluIDM3LjM2NCBzZWNzDQo+ID4+DQo+ID4+ICg1OCBmYWlsIGJlY2F1c2UgdGhlIGhhcmR3
YXJlIGlzIHVuYWJsZSB0byBkZWNvZGUgIE1CQUZGIC8gRk1PIC8NCj4gPj4gRmllbGQgLyBFeHRl
bmRlZCBwcm9maWxlIHN0cmVhbXMuKQ0KPiA+Pg0KPiA+Pg0KPiA+PiBDaG5hZ2Ugc2luY2UgdjE6
DQo+ID4+ID09PT09PT09PT09PT09PT09DQo+ID4+DQo+ID4+ICogRm9yIFtQQVRDSCB2MiAwLzRd
IG1lZGlhOiBjaGlwcy1tZWRpYTogd2F2ZTU6IFN1cHBvcnQgU1BTL1BQUw0KPiA+PiBnZW5lcmF0
aW9uIGZvciBlYWNoIElEUg0KPiA+PiAgLSBkZWZpbmUgYSBtYWNybyBmb3IgcmVnaXN0ZXIgYWRk
cmVzc2VzDQo+ID4+DQo+ID4+ICogRm9yIFtQQVRDSCB2MiAxLzRdIG1lZGlhOiBjaGlwcy1tZWRp
YTogd2F2ZTU6IFN1cHBvcnQgcnVudGltZQ0KPiA+PiBzdXNwZW5kL3Jlc3VtZQ0KPiA+PiAgLSBh
ZGQgYXV0byBzdXNwZW5kL3Jlc3VtZQ0KPiA+Pg0KPiA+PiAqIEZvciBbUEFUQ0ggdjIgMi80XSBt
ZWRpYTogY2hpcHMtbWVkaWE6IHdhdmU1OiBVc2UgaGVscGVycyB0bw0KPiA+PiBjYWxjdWxhdGUg
Ynl0ZXNwZXJsaW5lIGFuZCBzaXplaW1hZ2UNCj4gPj4gIC0gdXNlIGhlbHBlciBmdW5jdGlvbnMg
dG8gY2FsY3VsYXRlIGJ5dGVzcGVybGluZSBhbmQgc2l6ZWltYWdlDQo+ID4+DQo+ID4+ICogRm9y
IFtQQVRDSCB2MiAzLzRdIG1lZGlhOiBjaGlwcy1tZWRpYTogd2F2ZTU6IFN1cHBvcnQgWVVWNDIy
IHJhdw0KPiA+PiBwaXhlbC0gZm9ybWF0cyBvbiB0aGUgZW5jb2Rlcg0KPiA+PiAgLSByZW1vdmUg
dW5uZWNlc3NhcnkgY29kZXMNCj4gPj4NCj4gPj4gQ2hhbmdlIHNpbmNlIHYwOg0KPiA+PiA9PT09
PT09PT09PT09PT09PQ0KPiA+PiBUaGUgREVGQVVMVF9TUkNfU0laRSBtYWNybyB3YXMgZGVmaW5l
ZCB1c2luZyBtdWx0aXBsZSBsaW5lcywgVG8gbWFrZQ0KPiA+PiBhIHNpbXBsZSBkZWZpbmUsIHRh
YiBhbmQgbXVsdGlwbGUgbGluZXMgaGFzIGJlZW4gcmVtb3ZlZCwgVGhlIG1hY3JvDQo+ID4+IGlz
IGRlZmluZWQgdXNpbmcgb25lIGxpbmUuDQo+ID4+DQo+ID4+IEphY2tzb24ubGVlICg0KToNCj4g
Pj4gICBtZWRpYTogY2hpcHMtbWVkaWE6IHdhdmU1OiBTdXBwb3J0IFNQUy9QUFMgZ2VuZXJhdGlv
biBmb3IgZWFjaCBJRFINCj4gPj4gICBtZWRpYTogY2hpcHMtbWVkaWE6IHdhdmU1OiBTdXBwb3J0
IHJ1bnRpbWUgc3VzcGVuZC9yZXN1bWUNCj4gPj4gICBtZWRpYTogY2hpcHMtbWVkaWE6IHdhdmU1
OiBVc2UgaGVscGVycyB0byBjYWxjdWxhdGUgYnl0ZXNwZXJsaW5lIGFuZA0KPiA+PiAgICAgc2l6
ZWltYWdlLg0KPiA+PiAgIG1lZGlhOiBjaGlwcy1tZWRpYTogd2F2ZTU6IFN1cHBvcnQgWVVWNDIy
IHJhdyBwaXhlbC1mb3JtYXRzIG9uIHRoZQ0KPiA+PiAgICAgZW5jb2Rlci4NCj4gPj4NCj4gPj4g
IC4uLi9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS1oZWxwZXIuYyB8ICAyNCArKw0K
PiA+PiAgLi4uL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LWhlbHBlci5oIHwgICA0
ICsNCj4gPj4gIC4uLi9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS1ody5jICAgICB8
ICAyMyArLQ0KPiA+PiAgLi4uL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1kZWMuYyAgICAg
ICAgIHwgMjYxICsrKysrLS0tLS0tLS0tLS0tLQ0KPiA+PiAgLi4uL2NoaXBzLW1lZGlhL3dhdmU1
L3dhdmU1LXZwdS1lbmMuYyAgICAgICAgIHwgMjYwICsrKysrKysrKy0tLS0tLS0tDQo+ID4+ICAu
Li4vcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1LmMgICAgfCAgNDMgKysrDQo+
ID4+ICAuLi4vcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1LmggICAgfCAgIDQg
LQ0KPiA+PiAgLi4uL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdWFwaS5jIHwg
IDE0ICstDQo+ID4+ICAuLi4vcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1YXBp
LmggfCAgIDEgKw0KPiA+PiAgLi4uL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdWNvbmZpZy5o
ICAgICAgIHwgIDI1ICstDQo+ID4+ICAuLi4vbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2
ZTUvd2F2ZTUuaCAgfCAgIDMgKw0KPiA+PiAgMTEgZmlsZXMgY2hhbmdlZCwgMzI5IGluc2VydGlv
bnMoKyksIDMzMyBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gLS0NCj4gPj4gMi40My4wDQo+ID4N
Cg==

