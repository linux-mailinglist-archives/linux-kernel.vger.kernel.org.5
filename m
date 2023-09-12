Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028F879C776
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjILHBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjILHBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:01:35 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403E8E75;
        Tue, 12 Sep 2023 00:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSyAKVc5qR5Jez76JGaTrkF6bTQuavUww45AgIZ4aMhS8TP+Uu/InOnK+BZFkUNyGMjcv/d5UHbChj5iJ9U3FLaPdCJCA+XcG9oo+JsIUUkjhpPhZcbD3d1PNllKD7PDGgRTmg7wyU24QG4YsvFM/GZW6sXAmHTeT+B/c8d9xsbhre3Rr77xhyTZFu42FmNXqpkKY0qdXZ6CDTKLLb0fGCAd7knWZRRSn205AQYT3IO4lqu9auMfCXNIriQYe9jwfNpCspII1FxKMPiscWhbZM89MNYnM2Nm/3kdgZVDXgiCVXEppmpKyCxYHNugNwVunoVHQGE+FEitMxFG8UdrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTK8WKaiZtW0EJUzVySS6Ds5XtV+Wr1820MS8CQF3d0=;
 b=ZmYpczsycpPwz0dG0P/p+0man1BJgBsAPf41aD6S4Pv82cGfbaGqNzAyVwjVX70D8rfTVriuGAIRgGEa+k/cWBoj8vASS14nahlZ8UO0kSAQulEtl2hR5nixDSWCkGIN/noruiId3yul/ZVUvFMzeEQKviVqqA9bzzi0AHbb1eCkIlNdiHx8oX+YgM7yv35NS9oTO/0sfy2NhA7OufmEpQi/gDSpn1C8JvX580x9RUr36Rmz9+YTVT6nAR1pc4OEd+7s7msSgNELxc86uR0ZFxa9ce4A19+h1wYaEbEN8iKS7rqfxt/PXBIYxzAJv7bGgdRSubdX2ciuLEiSz/hQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTK8WKaiZtW0EJUzVySS6Ds5XtV+Wr1820MS8CQF3d0=;
 b=WwaWcVzy8ArEbXKACqXGQAt6lDqRC2SjfwUBXsbLNgoL6Sbxi9WnhdXlx5jc9MC6wxa7tTKokKk5eikpjMVm08s22YbSb58gQyXKPKe01G18I6s0tmQZZk7aWN2NjeFOen2epwmbvQRhVuRMp8w+HHXWO84bvo4k6qhRdVdC7/w=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 07:01:28 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 07:01:28 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoIABXXYAgAHcP6CAABZdgIAHn6dggAFXQACAAE0GQA==
Date:   Tue, 12 Sep 2023 07:01:28 +0000
Message-ID: <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
 <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
In-Reply-To: <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AM9PR04MB7633:EE_
x-ms-office365-filtering-correlation-id: 2ba0181a-67ef-46b0-e336-08dbb35e1662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DB/CPKKJH0KyWXZaXsmMg7+IHuVAAduV5KGbTO5iPRirMGprTq3Kuhft4KMWX+VR1+vKWgN2fkJ8I38CZQD+U8S2VW9rLwOjIPW1XvQr4hvt9gb5akHpOUkMqajFJCKOLJz/u5oDhRWwJ5DOeAJHpEYCINqgP6PzvAtJ8Y8Z07D9RG5ULryolYzfeQ3NTNfTU7hol0+InGNtjn0PBL+dFbWam0N4CeQwgp3+I7A3wvMTzvmm+UHY+gV29mY7SDM1/4CEwMSEFSLscnAX8rRHO3gkyXj0Ph7+vJQ5yPksWLbfkn4GntYDERKwMRNreOECYbRaZG5hkSzz4ttJ3748AI7i4Nr/Opiuh1oFn9KoOowplfJiwves4FedhRBxfjHOcEvGMHKEJ5RezNi0kKmpfXMZMXkt1LVwaNLzfh7rtC9zXufJ7JD3HN7Hx2Ff269YtYkX258d7AXL1QJ3SRW6EldkQ8WPAN+Wd7A5HXkBRftmQFyu2g5i50tksyoUx50wpxv+WOXhJsPBk+BfVY8lqzsRTDntaDwl7p8UyewUD5E0krYY+46oD4fZfWol4MHKsZPd28b6hdk9iyE45lvsSAd2Vpuk18J3j2j4m5J/wzqaZA/WFv5aUYi0tJH04AXxtU5MYqDETQEAQa/0sn7n8XDzH6A0+1/lDQ3d9uUdipY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199024)(186009)(1800799009)(9686003)(71200400001)(6506007)(7696005)(53546011)(55016003)(26005)(38100700002)(8676002)(44832011)(33656002)(4326008)(5660300002)(8936002)(52536014)(86362001)(2906002)(4744005)(76116006)(41300700001)(66946007)(66446008)(66476007)(64756008)(6916009)(54906003)(66556008)(122000001)(316002)(38070700005)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1JvajIxa0NxeDlEM1BVRGxxMnVuUklNMTdPM3Ezb3NQUHBVdndyVWJWUEJz?=
 =?utf-8?B?Q3hIYVJ4MTBveFAxaGVHTXJtWUtYOGZjeHI2MDUxK0RiNDlwZHFoWlExR3hz?=
 =?utf-8?B?M3ZTTkl1a3ovWlRESnBPWUcxRWVySm91MmUrWWVkODB3TXFySHR6ZzY4WjJD?=
 =?utf-8?B?RitEdGJjS2w1Qk1RZHZoSWowVmwxUmFKcjVVdFBUcGR5U3R3VkxlNWR3UFkv?=
 =?utf-8?B?Z1Ezb0x2TUFFZWVkR3VhWmhodkZiZFFjNmtQcmpSanZ2eWsxVGRlMjFBanJp?=
 =?utf-8?B?YUR2bEJUNWVNOVlEN0x0SlVRbTNuN3J0NklEVy9RQUlCZ2Z0cThIL3RuTFEy?=
 =?utf-8?B?dU9JWEt0ZnlDRklqYVkrNmtZd01wR29Va2RFaTBncGhyOE9PemJ1MTFvb29N?=
 =?utf-8?B?Y1dHNjRtcU9scExvU01mMmx6VHlnck0yVm5NY0cvaWxobzlRMnlsaElydnRJ?=
 =?utf-8?B?c2NVSDJib0xYaXlCS2RQc2djQXR5QjJmSDlUZ2hrUnp3RVZVUGZscytPOENp?=
 =?utf-8?B?QWk5cGVadXhWaFZWUTFUSTNwNUVoYmo1MW5UY0MwTzhhSSsvVW5iaXR6c0Z4?=
 =?utf-8?B?WnRHMElXMDN4RlYxVlBaRkM3VWVIMnltUk9XYVgrb3NnWDh0YjhoMHRNc01y?=
 =?utf-8?B?TWFSVU9zOFFpSzhDS0djRXdZemlhWXZtUjNObTFyL1hEaStlU1hsR0VFMjlL?=
 =?utf-8?B?cXFreVcrNGZyK0NiSGRPTm1jTjJnQ2lwcWg1emNFSjl6OEFwZnltcktYYUwr?=
 =?utf-8?B?b3BjRzdQd2lrQ09nN2dVaWtnNHo3dGg4eDZoMlRJaGlGc2pHcnRXd3psQS9H?=
 =?utf-8?B?UVF3N3pzY0ZCc0ViajJ1NkgzRFpHamxhMW0rV0cwSndpc3pWK1M1TVM0NUpV?=
 =?utf-8?B?Q09XVnZWT1p5cXVCWkJPZ2hUNDlHQUhIdHdCMUsxMGRrZURSM25Cak9TaVBz?=
 =?utf-8?B?RWx4elRGb1YxVTVpN0xMdjNEVG94aXFQZDdyVHBmYzFBMml5TG1CUmNoUVdt?=
 =?utf-8?B?SlRoVkNST3F6RSs3TkNRZmtwSmhXMy9GUEFkd2ZUNllrbEFTNHNtODBjZTRx?=
 =?utf-8?B?Wmc2a01NMDgvTDNSZFBEUjgwWDhEdDlKem5YK2ROblJxNkZuNWhBQ0VYYllJ?=
 =?utf-8?B?eHY1VEhra2hEMjZUSkJkWTB1YWR6UHNqeXBNbWVhWVVIVC9odXljQzMzNVlL?=
 =?utf-8?B?ZkhzUHNsdmVDWFF5TXV4L2NGV3VHK1VIVVpNckdqcG50ejliNDJMWkJSUmxl?=
 =?utf-8?B?MmRmdkV3R05BQ0dnQ3VnVE5VWElJRjlyWE1KSVlNelUzd3N4THNQMUNWcW9s?=
 =?utf-8?B?d0N3UDlsTno2dkxiUlFNTGtodk1wMW1halBtMGsvdnBVOTYraHZEZXB5V2NM?=
 =?utf-8?B?TllZRXJ2eHlBQS84ZGdyZVZtZE1POUFRcE9IbHZiSnpEQy9mYW9ZVXA1ZzFG?=
 =?utf-8?B?ZHZUMHR5Zlo0YmRlcHovNDlZMW1yMVZkYUx5UWs5Nlg0N3R0eFVMUzJ6Um9m?=
 =?utf-8?B?TTVmMDV4eFh0QVBSOS8xY0pHb3pYKzAwenlNelQxUzFIVzc2L2tyZ3JRbGFk?=
 =?utf-8?B?YUhtbkRRN25JaHcxUURpdUYvWmh2VXF6L0dPZzlzczh1N01kOGlMdjdkWWtu?=
 =?utf-8?B?b0x0L01EeHpJeTNZMnBZTjJBRVFDTENMSnJwaVRQWUxObG9IcG9zT29kUW9i?=
 =?utf-8?B?MTlOUFVBbFNFSHFrNm1ENU1EUzhrQzBxRXQ0NkgyZ2JaakpDRUM2MStRTXFW?=
 =?utf-8?B?bmVock12TWxrc3V0eldWNmJsWTVBSEcrSFJhZ0J3K0FxWDZVWnk4QjRFOXZ4?=
 =?utf-8?B?aFdqNGhtUlk5QlJtMzJGNGRjc1lweEJWN3REZmxOWm9WTjAwR2cweUhwK2tr?=
 =?utf-8?B?YTVlS3A2MWZxem85MjR4bk5lYWtHNnArckl1aTBzWjc0bEx0SWVnS2w1djJI?=
 =?utf-8?B?UXdwWk9YeDJCUkhmNDhVZHp0MlUyQ2xOZlZ4L1N3Yk1YMkh3QmhiRXI5V3h3?=
 =?utf-8?B?ZHFlemp4MFZadW9lS0UvcEhUTlV4VEl2a3lPOFdnZlJLNXdHVDJ2T3U3WERX?=
 =?utf-8?B?MEM2c3VLeUNTcXhVeFhqMHZDelJyVUFveVN6WWx1UFpwUDlKTzZrSFhIU2dZ?=
 =?utf-8?Q?5rQo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba0181a-67ef-46b0-e336-08dbb35e1662
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 07:01:28.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvngY98t6QsGmVZw3/NUUeSfB70bQ+z3bHBBbwZZDNitp9urdQxO0drMbRmwyLu6u+RJAYi2wNWnR938RF8N3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIgMjAyMyBhdCAxMToyMuKAr0FNIFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJv
bWl1bS5vcmc+DQo+IE9uIE1vbiwgU2VwIDExLCAyMDIzIGF0IDM6MTPigK9QTSBIdWkgRmFuZyA8
aHVpLmZhbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIFNlcCA2LCAyMDIzIGF0
IDE4OjI44oCvUE0gVG9tYXN6IEZpZ2EgPHRmaWdhQGNocm9taXVtLm9yZz4NCj4gd3JvdGU6DQo+
ID4gPiBUaGF0IGFsbCBtYWtlcyBzZW5zZSwgYnV0IGl0IHN0aWxsIGRvZXNuJ3QgYW5zd2VyIHRo
ZSByZWFsIHF1ZXN0aW9uDQo+ID4gPiBvbiB3aHkgc3dpb3RsYiBlbmRzIHVwIGJlaW5nIHVzZWQu
IEkgdGhpbmsgeW91IG1heSB3YW50IHRvIHRyYWNlDQo+ID4gPiB3aGF0IGhhcHBlbnMgaW4gdGhl
IERNQSBtYXBwaW5nIG9wcyBpbXBsZW1lbnRhdGlvbiBvbiB5b3VyIHN5c3RlbQ0KPiA+ID4gY2F1
c2luZyBpdCB0byB1c2Ugc3dpb3RsYi4NCj4gPg0KPiA+IEFkZCBsb2cgYW5kIGZlZWQgaW52YWxp
ZCBkYXRhIHRvIGxvdyBidWZmZXIgb24gcHVycG9zZSwgaXQncyBjb25maXJtZWQNCj4gPiB0aGF0
IHN3aW90bGIgaXMgYWN0dWFsbHkgdXNlZC4NCj4gPg0KPiANCj4gWWVzLCB0aGF0IHdlIGFscmVh
ZHkga25vdy4gQnV0IHdoeT8NCg0KDQpUaGUgcGh5c2ljYWwgYWRkcmVzcyBvZiB2NGwyIGJ1ZmZl
ciBpcyBsYXJnZSB0aGFuIDRHICg1NTA0MTM5MjY0KSwgc28gdGhlIHN3aW90bGIgaXMgdXNlZC4N
CiJbICA4NDYuNTcwMjcxXVsgIFQxMzhdIHNvZnR3YXJlIElPIFRMQjogPT09PSBzd2lvdGxiX2Jv
dW5jZTogRE1BX1RPX0RFVklDRSwNCiBkc3QgMDAwMDAwMDA0NTg5ZmEzOCwgc3JjIDAwMDAwMDAw
YzZkN2U4ZDgsIHNyY1BoeSA1NTA0MTM5MjY0LCBzaXplIDQwOTYiLg0KDQpCUnMsDQpGYW5nIEh1
aQ0K
