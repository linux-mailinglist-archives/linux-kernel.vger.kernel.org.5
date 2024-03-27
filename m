Return-Path: <linux-kernel+bounces-120325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A1688D5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC251F2C091
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B212E68;
	Wed, 27 Mar 2024 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="dkrxDGys"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A312B93;
	Wed, 27 Mar 2024 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711516409; cv=fail; b=mTkFr90FsCFyw0NmxF0zx2Q/8wMtRX1wB93Bv7htZzDnlwHMGG7cbL5AYtHEk019kaqmtzV8d/fF35Enil1ynRPCHaNzrsZY2nx8H/9yHmMnFn8VppHRMzCBOe4BUiTT/D3FFzdfTPjcxyZOmr/EJxnHodvNiR31ttq/AIAnh2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711516409; c=relaxed/simple;
	bh=odK3Idc5IqtZaw6ifwXJ3LnaMLW0r5JDHnxpBp+R090=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h967B6AWDnd/75pVjsIU5rR9vKRrZuwqWmMC0xVQ0awiFzi2vUMKtenjOSd7D9GJ1eYtzb7VnabXjxEGjB+oQ0icRUp3mIN+vwgBPhkexVJ4Ps7asYVEd6VWy5tDvfFuWG9u4YHv0TuvZwteLt3gLwVrEtoAYcHFeYVfZWGquvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=dkrxDGys; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R2QnJ5000629;
	Tue, 26 Mar 2024 22:13:08 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x4ap80fnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLOzwsF2RuPUap8d9jMFrO2iXHxAMUM2VMxJ7Hbw99SS4YHW0M29vHzCKJv0D0RFOmYu7UC/kRO9tw/R0ALgfN+9MGxwVRtxQ2L1Rc00wuIju7/Xf45vpE+PN4rW196VgmPgJpUEjxhPsA1dlwBHY9/DBxBcGBXfqNiiPlPrn22eE7ZSG/rdvAwZIF4LKj3mI39kwWj+RlxRw/3A0mf94KnFdwswT/FtNytJRV2TuCKFVuU4yNNCh7/GcUhfKbETFJAsGatYl5TDfS9ljArS3Y9UmHuFD1qj7MzHTd4J+wyDKdHxfZdQ5dgoI+xHZ1pWFONo/HnSZPK/RfAdFYk8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odK3Idc5IqtZaw6ifwXJ3LnaMLW0r5JDHnxpBp+R090=;
 b=IJjl95eFeI5Bt5fVsi4NCo1JoAL9HdMV8ZK5pVRd9PciCSL1ZD87Ah5cuKwbt0MfS8O+XwYqpY57WIctgHy7Up76IS+6Lbj0rx3m00a9ZIJUmTre01XaJVGawlYLWUJLJf7Ai0IcY8H390/eLP8fnxi1p2moS6u2jsaKPJrf/jUfjDBH4WwqZSywjdRfBu7pqjBhtKhwcyTPGWVFB1vlo3FoNlP40NmmCQf2sJoWcQ+2kuoGWqzJVM0Hd1u3l7wcEK5YbWrHMRx++rzB6tA2cFIL35cA/6fVcitcLrJ1jwyvKUiBfOcaIfqmPPs1s4qbz5vvO0ymf5XJUtrQn/l1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odK3Idc5IqtZaw6ifwXJ3LnaMLW0r5JDHnxpBp+R090=;
 b=dkrxDGysdopbjO41nHKKc9W8yOW4elDhxHKdEmig7go+82ttVmwB0XP18sIB56psFDw3CCLT4jVMTsbbG2V39YD1K8ULgtjSVXjdzX8Biq4cRDS/CT3BVwBMBpahhJ21/OG0bK68lAZ1y1DGlkBGF+6pyyvlgpNaaqe6FsG+EZ8=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by PH0PR18MB4006.namprd18.prod.outlook.com
 (2603:10b6:510:2e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 05:13:05 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 05:13:03 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
CC: Nikita Kiryushin <kiryushin@ancud.ru>, Michael Chan <mchan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2] tg3: Remove residual error
 handling in tg3_suspend
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2] tg3: Remove residual error
 handling in tg3_suspend
Thread-Index: AQHaf/ZXkSM+OgywqkWRSFb4c7mQl7FLCe2AgAAA0MA=
Date: Wed, 27 Mar 2024 05:13:03 +0000
Message-ID: 
 <MWHPR1801MB1918E81A947684F6B86A1A41D3342@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: 
 <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
 <20240326183544.488242-1-kiryushin@ancud.ru>
 <20240327024430.GA1370891@maili.marvell.com>
 <20240326202442.6e80cf1a@kernel.org>
 <CACKFLi=Ax0+2dYKPXMR7OEsyJsPK13ZpXY763AFzFH0OBbhHVg@mail.gmail.com>
In-Reply-To: 
 <CACKFLi=Ax0+2dYKPXMR7OEsyJsPK13ZpXY763AFzFH0OBbhHVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|PH0PR18MB4006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 C1LGVe6ENV9g0t/snsaq4uljtuhkG3I3xUwoTABaSVRQdsWM9yXQU5zlTbNVIpxEyNjH5NZ1FdGDS4kXT1oYit3CZmgYAtNUJiG89O9KQi5opCuI4OnQM4EeGEnCOP0lRmyg1eGjo8J+CRo+4TF8D5CUChgD9ILtme44n59itHLqBVcgt9dUtc0OmYa94VdDcXgNz1egjGdBeeckLeS+6mKuJFF+ri2l/Uv+SH581Rpb9wNSMISQz23xeTF/ihS+iGRezYBc8FZsSnBT1EWbF5ypsVweBL1hM6Ev8yxkq+fdKFRnABRFR5W+EGb0yfLdLtjfZ7WC3gKoHB6DuKQ+i/qOD/hUcs8c79WOd9D5g8Z/qSWFoNsDGBnXMwEgBWDMTqzDbdlJ3s8rJcL+dBrUG25RgZqiDIaJv8c9j1LKflq/DFpudR7AF48blNebtxYf5k6/DLCQt1+l+5Q2BcJ2RP9oO75NaxrLIp4DfChwqlQPzc2UJlq3xECELI58ydtfKSstfQ5nhFl0YusTA+8hS/zCATvq44ejo+YAoBRIadlopLnUAF0Cv8pBoNQaINEGOV5XoKhXykWALFSKCNin0JEGuEsdZT/szYvAvU1N6as=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NVdFR1N1djQ1T1NTMnZBVHFEU05wK1JGRnA3WFdsTjAza1lvZDRrMHdmS0pM?=
 =?utf-8?B?WUZxMUhHbGlhcXptamdDbVJEOEEwYjVtd3lhUlJCbFJRN1NObC9zSFl3MFg0?=
 =?utf-8?B?QmxMYnhpWXBCVjlIOGRZaFBiUTlmcEZTbGFCUHBKMVlKRW84aUFpcDRBVlFC?=
 =?utf-8?B?RHJyWGwwaURzZkxyNlFxZnVzaVNLWHlFR2tPSDdpUzVLZXQwNm5oOTlHVUFk?=
 =?utf-8?B?clFyUXBHanpvVjhmYkFXK3E0NVI1d1IyNkNIb0RZR2JoUTY5ZWpoamV6UEhD?=
 =?utf-8?B?N21UTEE0MWl2Q3I5NWx2NkVqbFI3d1AzWXp1WUY2VGhqSXVFVVRRZ1pQMDVo?=
 =?utf-8?B?aGtGaE5qRXFYU05NYkNVMndtZElGdXVqNE5rUHpWRjlaK3Q4N0MvRkVpbVJQ?=
 =?utf-8?B?Y1ZybEQrQ2lFMjJwVWdoczFRZ040WmZuVmxPVS9KSWdpUDN5U3ZGWEVLK29n?=
 =?utf-8?B?Y0tqWGlrOVoxeS9jZ3RzRUtwRXN3L21KeExrSzZqU3ExTXMrMy9KUDROMXRy?=
 =?utf-8?B?cW8yVWVLZlFaMTZqYmZYUFl6WDZzSHlhYVp5WmMwVnVPTWNsR0c5UGF4Q0xz?=
 =?utf-8?B?eVBIUGVxaXRFN21IV0c0eHdNckdYQ3hOOFhOS0Y3b1k5QTNsdmFoYjkvd1gw?=
 =?utf-8?B?bzRYUUVYQllmWXVqQ21XVWVFQnFGMzVpOUp6OG5qZDM3ZU8zVTZoK3I3azNt?=
 =?utf-8?B?dTR6WHp0NVFwa3hOWkNkTVoyWlgwVmxMMXlseHVFZ1crTVk5WG84R3NPS2VQ?=
 =?utf-8?B?Y3cvc1daVmNacTdHVkpobWJVODFhRk52N0lJTzNFb1NpRGxXajZlMzBhbGlu?=
 =?utf-8?B?RFdqMnlOZ1BSNTlsdjRQZzVWdmR0d3krVUc4R0RBeWNRK2REcU5aUUZRaTBu?=
 =?utf-8?B?KzhzMTVFWWpWZG5EeFlhNC9DMDc0SjRXT0Rzd1I3YW1UbE5WSElaNmdlSUVx?=
 =?utf-8?B?Q3FoWFpwTnV1Q09OTUE1VHIycjZPTytNR2p4L0pQY3NvSHlZbTdjZWNRbjFX?=
 =?utf-8?B?TmFNNy9NbldvZWg2Lzg4eEhkdnhWYTh1NW5EODlnRDJaN2JQOFNjbitlamJy?=
 =?utf-8?B?elAxeitreVM0QjBWdzcxWSs3a1BVRGtBU1E5TG1xSWRRQTJaOUJ3RmZLeGly?=
 =?utf-8?B?RWhqUEQ2V1pkakY4a2o4clpUVVQxc0VNWGNRdXZHeXVlbUt6eVgxd3dqdjR6?=
 =?utf-8?B?M0lGcXNlV3Z0bVZFQ2JHUmJ4YmZTNzQ4Z1dXTTMvbHhkek1jVW5WSHBnTDBa?=
 =?utf-8?B?T1M3d1dMdFJPSEJsOEtKWHZVK1VadmFUWTJ3d24yY1psSjR0dkJmRU02Q2Jn?=
 =?utf-8?B?aTBVY1FFUVdHcTZ5MFR6VDB3N0FMZ3h1c2hXMGsvMzFFWGVXNDlPMDZXUkdi?=
 =?utf-8?B?SW13NmdPYlhaMVltNzRCT0pDU3lxZ3FnUm5lKzVmSGEzZlFDK0o1bnFTR01n?=
 =?utf-8?B?WEo3TU9lVnFMVUs1dGtoNEJkQ3BSWU8yZFVPN3ZNTVZmS3V3b09nTGZ1amlT?=
 =?utf-8?B?NDFXNkUzNTk3bGJqYTJMbDVPZGxkNEJoSU5TQks3OUt3MVpieUhnb3BIaEVW?=
 =?utf-8?B?a1pzRHBidnBHU0tORnhZUm90d0R5bkVXVVpxMnMzMDBEUUR2KzJJOWhsTE5L?=
 =?utf-8?B?MUd5NzgzYzlaVFY2RkZTUURBN0pva3JtdXJmKys0cnZ0Q0tyTnRObHlRbHRw?=
 =?utf-8?B?eWZCMDNtdk1yY3R5N1ZVaGRKZVk2dTNtUEVrdlpLZUliMFJXTUZUbW1BS2R1?=
 =?utf-8?B?N3M0ZWhtL0JQcnU2Ry9LMTY1SE9CYzcra1pCUXAyWG1QeHVBNThoczRWaThD?=
 =?utf-8?B?R2RPbUhRVzlnSzJWMUQxU3p1YlpxdkpOdE9zUHVnUjA2TDJjcm9ndzZJeUMy?=
 =?utf-8?B?WWRZSkZOcFZVWWJHQi9oTDhBME02UmM1UVhFQmx0ZHlneDhTU2pCMm1YMGFE?=
 =?utf-8?B?SnBEUENya0ZkT0NRekQwMEczNmZhTmVpalZsL3NTRW9KN3hHYVNNejhBakgx?=
 =?utf-8?B?ZTNXUFhEV2RiN3gxdGhaU1YvZzFzYWFvL0tJOEt4aEhQbXFGcnVBTjE3dHZj?=
 =?utf-8?B?eDJvdlRsa2pFYTdZQ0JrM3U1Q3QrK3N0UzdtZS9xRzNkc0ZubXppdFBjZWgv?=
 =?utf-8?Q?UFD1EvC1MWL1gBoafQ1lcgrIX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2701529-d45a-46d1-3d49-08dc4e1c9482
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 05:13:03.7129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1gmTNGe2/6D8LDg5A4ShrU1pSb6N5zDRgwzYn5jcsAYguSVI4CBdbZqv4HYRT6PCm11KmuJvqGUHMKN1xDiSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4006
X-Proofpoint-GUID: texZyr1GCXq8DMFgPeoPUqeulujhy6hO
X-Proofpoint-ORIG-GUID: texZyr1GCXq8DMFgPeoPUqeulujhy6hO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_02,2024-03-21_02,2023-05-22_02

PiBGcm9tOiBNaWNoYWVsIENoYW4gPG1pY2hhZWwuY2hhbkBicm9hZGNvbS5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgTWFyY2ggMjcsIDIwMjQgMTA6MzkgQU0NCj4gVG86IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBSYXRoZWVzaCBLYW5ub3RoIDxya2Fubm90aEBtYXJ2
ZWxsLmNvbT47IE5pa2l0YSBLaXJ5dXNoaW4NCj4gPGtpcnl1c2hpbkBhbmN1ZC5ydT47IE1pY2hh
ZWwgQ2hhbiA8bWNoYW5AYnJvYWRjb20uY29tPjsgUGF2YW4NCj4gQ2hlYmJpIDxwYXZhbi5jaGVi
YmlAYnJvYWRjb20uY29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0
PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgUGFvbG8NCj4gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPjsgUmFmYWVsIEouIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0PjsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bHZjLQ0KPiBwcm9qZWN0QGxpbnV4dGVzdGluZy5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIIG5ldC1uZXh0IHYyXSB0ZzM6IFJlbW92ZSByZXNpZHVhbCBlcnJvcg0KPiBoYW5k
bGluZyBpbiB0ZzNfc3VzcGVuZA0KPiANCj4gUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJu
YWwgZW1haWxzOiBDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkNCj4gYmVmb3JlIGNs
aWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMNCj4gDQo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gT24gVHVlLCBNYXIgMjYsIDIwMjQgYXQgODoyNOKAr1BNIEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCAyNyBNYXIgMjAyNCAwODoxNDoz
MCArMDUzMCBSYXRoZWVzaCBLYW5ub3RoIHdyb3RlOg0KPiA+ID4gPiBAQCAtMTgwOTAsNyArMTgw
OTAsNiBAQCBzdGF0aWMgaW50IHRnM19zdXNwZW5kKHN0cnVjdCBkZXZpY2UNCj4gKmRldmljZSkN
Cj4gPiA+ID4gIHsNCj4gPiA+IFBsZWFzZSBhZGRyZXNzIE1pY2hhZWwgQ2hhbidzIGNvbW1lbnQg
dG8gbWFrZSB0aGlzIGZ1bmN0aW9uIHJldHVybiB0eXBlDQo+IHRvICJ2b2lkIg0KPiA+ID4gaW5z
dGVhZCBvZiAiaW50Ig0KPiA+DQo+ID4gSXQncyB1c2VkIGFzIGEgY2FsbGJhY2sgaW4gU0lNUExF
X0RFVl9QTV9PUFMoKSwgaG93IHdvdWxkIHRoYXQgd29yaz8NCj4gDQo+IEl0IHdvbid0IHdvcmsu
ICBJIG9ubHkgcmVxdWVzdGVkIHRvIGNoYW5nZSB0ZzNfcG93ZXJfZG93bl9wcmVwYXJlKCkgdG8N
Cj4gdm9pZCBhbmQgaXQgd2FzIGRvbmUgaW4gdjI6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvQ0FDS0ZMaW56SmpxZTBqNE9Ga2NDVitGeUgwSmlVcG5qM2oyYXpaaw0KPiBH
YUM5amZ2RlhyUUBtYWlsLmdtYWlsLmNvbS8NCkdvdCBpdC4gVGhhbmtzLiANCg0KDQo=

