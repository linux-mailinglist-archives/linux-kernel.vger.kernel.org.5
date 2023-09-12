Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A85C79C86D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjILHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjILHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:43:32 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58EB9;
        Tue, 12 Sep 2023 00:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQR7F9kMr4iZlW4lDKZ0qMSFUSo3fMMSL8RjsJxQBwQUP6aejoupgN7liXUV9oDcRRot7PcsJ+ml3kak6hfXJrGfcxNkJjGbe5+s1yB0zuOoJ3bevDVA3HJPSQFMBsSkzXBnaInzI/mlXgkHAyuIEGHWlUECiWhzXJ4SPQ/toBPTEyS1HJLdjAI1vx8JIC/2tqRHwnR6ZzQVkfxJ9uOrWbVx/5My9UrNpqSuGNvolpnuJ+72OVfS8/OJKoZcm3AL4cWkzLksYP7k5ciX6OZuy8STx1PltT2iaPBDp4jpAhzoDARCNM9CdpdwnBBuyzxahA4byFmfPDmZH/1TUXeNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHsHvpgpes0OI1H82ZRuwA9F56qqS5uQPrqtbCrQGoM=;
 b=eFUbj1WZTQ9VCvBlAeU9fE8Qk0lvqcp7jB53s0fLLlGcQbWo+Fg57DGCRVtrmdKsP5YhLR+9eeNxw0StNBSZ6cs5QdnPA/pHI0bsShBOzAahK8Iv/zNXs3qoHUsX7HEAdzjgwxDrdb0AoolvhJ+fBTZy9EwwPWtPK0zz5vICemICYoEMxIs8onYEoDoGkvZ0A6akxoNbCgvfDOYKCjZ61B3eYjOHbjaOC1sv1ZApyxUiwsCQtBHnZWOXDTD2GzJLqOd4qpQAAN46XG7faURV5FmQhb6cfhffsYT2XTlM4oZBZ+USCNpVm8CULeoeRxqA9szkNSv8ybeYEGdJ3bFkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHsHvpgpes0OI1H82ZRuwA9F56qqS5uQPrqtbCrQGoM=;
 b=bfTn7Vp7DeiFd4RBQmymrC6I0ZtCS2jeaaXMrNfCJ/OwCdinlvKEzZEaXwvOfD9fN5zBDDZtAQrMkT+6sfN5oIwSI5lSLf+HPKCcZSjoqvv2WKx2eyOWV1S0UA8xoKEy1mjqnYJIILOWJtj23PXZzkXsUQoyheKE7ulifyBH2/g=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by PR3PR04MB7433.eurprd04.prod.outlook.com (2603:10a6:102:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 07:43:25 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 07:43:25 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoIABXXYAgAHcP6CAABZdgIAHn6dggAFXQACAAE0GQIAAA6qAgAAHETA=
Date:   Tue, 12 Sep 2023 07:43:25 +0000
Message-ID: <DB9PR04MB9284404C1E1F1300EEF5A70487F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
 <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
 <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com>
In-Reply-To: <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|PR3PR04MB7433:EE_
x-ms-office365-filtering-correlation-id: 443844f6-9d02-4350-bd89-08dbb363f270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjseKmsStyvfGxhzdi7w98tZu74fJ6ny9ghjoNg/MzGVHClsIFf1omQgqvpPQEDmQE0UZvmz/YR3g+VF6OEgVkgv8bdkrLp2yuiuecXUkb+W5Td2Totb/jVG4HwVX4v9nrxOllVA+esR564dfZb2PpI9SxxbGFzVKlfKR2BKrqlcKrWJNGOeOl4i0tMF5+Z2qXNyQYSr5Jdnvc2U66Q7rlIZtHlYCdw/Zp7o4qzK7PCh2h//u6n7K/1hLAdalgRH4QfYqi5gQZvj5vvocuwBx94rd3KUy3QYoir3Y4Z9KJKYZRxaD8WYdUy1aKbpu6FoSCUeSPOPjscowutPaAZMO8i71z+8AsSsHoIa+w2aKZ1mM4x7GclDQ1KZeSfmtNg3kZM1ZQHWfHOXRcGMEfLUfLFP5ZMnM0n1fNI0B9Hrv/nHSAkyFq2SgSNxWa78l8UwkdYG96mnWcY3dvPnSg/osN+kVo/danZOQl91TUQPz6Aw7kRAF7GvLHu+pf0mgR2qwP3gAeLtwVqohk8gzeiJevbJKZtYdFQ2BcrDDDRqtTabwB7QBxuDjlKHBbTTPMSOrgF4qjzI73F/hZleSfcaShOQU+YsA8E2Y4lmqzh2lwJ19oHdEmKRoXDez0H9jwVY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199024)(1800799009)(186009)(71200400001)(53546011)(7696005)(6506007)(9686003)(86362001)(33656002)(55016003)(122000001)(38070700005)(38100700002)(26005)(2906002)(4744005)(478600001)(44832011)(5660300002)(4326008)(52536014)(316002)(8936002)(41300700001)(8676002)(6916009)(66556008)(66446008)(64756008)(66946007)(66476007)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFNjQWVqVVo1ZWJBVWFnM2RlMzNDQ3hTZVFWNE02ZWJpbkNoMVBGdm02Sitx?=
 =?utf-8?B?RVFPQlRGWGpqbjZlVEQyT0N1aDNuZFhLRWlzWCtXNGtyS3Z6Ym5JcUU0TE1i?=
 =?utf-8?B?MndCbkVMZVhBeWUzNUFyQ24vR3hNWnY2K1lkK2dQbXM5eXozNmdjT3BPLzNn?=
 =?utf-8?B?c2k0UzJOazI5K3h1UmZBQ1BlYkoxSnFla3BpcTR6VWk5cEx2RmpFelo4K0wz?=
 =?utf-8?B?NStoM0QrTjZlTm5WbkJ4ZUhCL25CMjBtYmlveVFPcTU2TVN0Qi81d2Rvcmx6?=
 =?utf-8?B?cE00VVJlc1AvMzRLNnRYZ1lDNDRZY1cxSnpPaE1DMG5YVVVRaEdsL1Y1K3dC?=
 =?utf-8?B?WGxpdU1LcHc4cENkT1NLVzhDSnhTcVh4QWhuUGFqaDlkVkVLVXNkZWVNWHRG?=
 =?utf-8?B?MTc0N081S3lxUXhkbmNyVEp0NUF3WjNHaXIzQkdxNmxRWnBlS1pTUmJrUmFi?=
 =?utf-8?B?L2dORE9ibE5iVE9XZ21GbkhKU3JIVlp3YXRyYjBUVndYRWEzTk1xWVFVMTZs?=
 =?utf-8?B?M1R5a0hNMnFCS0k0NHdpbWkwcXIweDBXLzZkL3l4YWNYZjIrZWUzdnNVV2pC?=
 =?utf-8?B?dENldHdRL1IyUE5rcDBjaWszZnUwbkEraEhRYVNVeGtFT3gxYXVCUjFrZ3FP?=
 =?utf-8?B?dmRJY2pLeXhzNnRva3NjdExRTnFyaGxFUXE3MXFoNEpHOHEyZEluaW1OY3VN?=
 =?utf-8?B?aXpYRDhFcDdpWFhpd2pVTW9hSWJrTkJCcmh2aGFCTnF2YmtHTzdIMzVlb2NR?=
 =?utf-8?B?VExZekd3Y29DUDFoUDJVUHk3Qkl2QjZYNVZRUURBYjJJUXBkZk9WME5iMW9x?=
 =?utf-8?B?MW5PUEJuNXJOYVY5bGNhSDZocUpVRSs0VHcvU0JUcG5KbmRESTU4QU5HdnVo?=
 =?utf-8?B?Sk1rQ2lqVW0xcGVhdzF4TjhLdUd2NSt2VnQ5MVphTEZwelNScWhqbTI0dHB1?=
 =?utf-8?B?QmJWbHUxUTlBb29Gdm5BSGc2Z2liTmdOOWszS3pqWjZ6UU9rZHB5OWFXRXI4?=
 =?utf-8?B?SlFwbHlwb3ljbnBNWEE2Tm9kQnU0b2ZuVXk5aXRJK3gza2VVa2VKRTZGZHha?=
 =?utf-8?B?ZDZ5R3BqT2Y1UmxBUDMvUmt5dURZZitNUHJ3VkVwVnk1K1o4Z1VQQmhRSjNq?=
 =?utf-8?B?TllNZHdGUlIzVnpJcjhFcm11VDF1NUEybmkzdlN4M3JMcHNiQnF2Y2hrUTRD?=
 =?utf-8?B?K3BDUFB3aDFqNXpBeFFlM2tIWDg3QjgzMGNpdzltczV5WTh6QXQxMVFWUDZH?=
 =?utf-8?B?a05HYVkyTnBoQzNiYWlJVnhZYkdoTmdRUjIvVmhGTDRvRWw0Y29wd3U0Z21i?=
 =?utf-8?B?MnRkR2VnbERmRlVYcnlSeG43d3A2TU1xalBpVnQ2SDlmaUZsR0EvQUppeUZ3?=
 =?utf-8?B?VGdOWHAyZUorRlpuYUtwckhpdnE4ekhXeG91bzJkeUx6c2N1Mk1SU2RyRUpT?=
 =?utf-8?B?UHlTRzZWOXM2bFAxNUxXY3lsclkzdTVOTWRyeDFBcnBkOEoxY2pOakRxM2tS?=
 =?utf-8?B?S0Vvd0V5WEEvUVlqS1AweUtoRDZ2R1c5RU1SMDdhMFZsYzFUZzRvZmg2RjVP?=
 =?utf-8?B?Q2Zld1N6Rlp0SmxENmI3NDAyRWlJUmtqRkM4bCsxQkUycWJ4SkF2N0JwaE5W?=
 =?utf-8?B?ZWNwNkc3b0dQMWlJaTVqTFp6VEZsQmtBd2pVODM2bzR0clg1bGh1NW1zT0NZ?=
 =?utf-8?B?anI4OGJHVEVjRWtiSDM3c1BxNVhKaG8vczlzM1IvRzdQcllTRk5wb01aWEtN?=
 =?utf-8?B?a3RTOFVrM2paT0txTmFhek1kR0w0OWtONFd1MXRraVNPUEdBUTAzZ0FBR2lO?=
 =?utf-8?B?N3QxNHpmVTdPd010Y3pkOVVFYlBoRndKelp6aXRCbHNYYUE5Q05Eb0FpZ2FT?=
 =?utf-8?B?b3hwOGZ3cEhwRTlFN04xTG5nMjF2RVpacFdxcklNUVliV0hnaXp4aE5VK0Vk?=
 =?utf-8?B?azBBM1lNTHlHSDdKOERzdzBVYUJMNWdNU2Z0bU1rU2QxTWZrS1R0SXdPM0g0?=
 =?utf-8?B?M2pZUXc0NnlJTXZSOWVRS3BYWmk2R25vOUpvVWJhc2RxYWU5OTBoRHZoL3h5?=
 =?utf-8?B?Y21vSjIvQVdTLzFQYmVJd1IzWkw4Zm1BbCtwYitNMytUSXRzeTZRNGxnQjg0?=
 =?utf-8?Q?TKQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443844f6-9d02-4350-bd89-08dbb363f270
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 07:43:25.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8segje2tNQlynW4E8TcgsZBaSAwKhFC37YZfKERRAun2+GdXRspecliUebkWBGHimJS5oK058yjFNNIesaqcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7433
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgNDoxMeKAr1BNIFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiBJcyB5b3VyIERNQSBkZXZpY2UgcmVzdHJpY3RlZCBvbmx5IHRv
IHRoZSBib3R0b20tbW9zdCA0IEdCICgzMi1iaXQgRE1BDQo+IGFkZHJlc3MpPyBJZiB5ZXMsIHdv
dWxkIGl0IG1ha2Ugc2Vuc2UgdG8gYWxzbyBhbGxvY2F0ZSBmcm9tIHRoYXQgYXJlYSByYXRoZXIN
Cj4gdGhhbiBib3VuY2luZyB0aGUgbWVtb3J5Pw0KDQpUaGUgRE1BIGRldmljZSB1c2UgMzItYml0
IERNQSBhZGRyZXNzLg0KRnJvbSB1c2VyIHNwYWNlLCBjYW4ndCBjb250cm9sIHRoZSB2NGwyIGJ1
ZmZlciBhZGRyZXNzLCBtYXkgc3RpbGwgY2hhbmdlIHRoZQ0KY29kZSBvZiB2YjJfZG1hX3NnX2Fs
bG9jKCkuDQoNCkJScywNCkZhbmcgSHVpDQo=
