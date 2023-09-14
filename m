Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57E7A013A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjINKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbjINKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:06:42 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2083.outbound.protection.outlook.com [40.107.12.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3381BF0;
        Thu, 14 Sep 2023 03:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4lHK0grV4HFyN9KufugUyoc8UMshCulEZIZq5fYNkNJ1s5beCqh4pPvCd1Z5m+S75PBgkyasYRsPA5IVfqBYJKtUiEugfBidvPwc8IW+hcytqkFWRi9VRQQbuebRhQYyBaWJcee/DpoApyHXr8OSgTjke8C3LsiXgkPnKSTE0ZdelyuDmKqIaiZrrHyNaY3zuMPtmJMd2mtX6Twi05LhQa05U/99JidfGxJnBoJhabwfeQviypWZw2vHlf1yDyzwzqtaOKmSVrNJ2cLC5fduLL8nxGN4uEjshscJptqmg4NARjrTe41ivGNVwFOxD8LqMWdqzgPS/Wrm26LmQjzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMJ4BXmOzXttyKXqXGjwW5ZbPeGZEpW9C+5S0LH+qDc=;
 b=gXozdmfaZstBLy6ltaNvsMRHgWdtgz5yO2l6CVOZG/n/UzTvk25OmXgaoI86nc+JRnV7i7vUIgvxruY0nQusoq4eTFYn5hjJikc7Spxyz6dTTywYphfBitBuCRAY35DV3xyjxQptj64uTcnSReqB9VBRNO1x0CdABQM7k7ZQppkQ9Gx7JcKHUFXkNqzDCZXDp2vmHWlQS65UyRX53dl0pAAcK+e9tldPQLW23V/okPa+ET2/S/4cveSl82y/WEiN7ZikhLP0lbr3/MwaE3ouBTvj4+1HJg27zdxVjJCefxNDqzZlh/uWShT3AArZ1z7T18PkvTlipGM3+z/lDvQy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMJ4BXmOzXttyKXqXGjwW5ZbPeGZEpW9C+5S0LH+qDc=;
 b=Oi3f9EvgUjOAKhi4Kr8n3iGRdEJjUtM59wDWkdYlKqqKOECuzTc33YS+jLLX51lRH5DWJZ+GIHso3Q+1XqzV1AooC9SI/ZdAd/9Uxui4Lq/5z8SQDT88fE7GlkUfwRmwuPd3V1iZn91OVBWGl5v7W/C2atyZu3CMvFL8nhZ/OWBSmYvjyMuFhKxrJmPf00wAy/qaULjUMemiiTgK6xjPo49YfqEJYkiohueDJtTVLjMRln8da1gLUfwWsDGU5IdoEeoCvQMvizjX6Vk/bhokxJQpiejXFJUlcW3xMuwTMmQr0E7gpbfBjZrcGX02jATS2wZ7tXslq2QCYbsPLPXzZQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3232.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:06:34 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:06:34 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?utf-8?B?Tmljb2zDsiBWZXJvbmVzZQ==?= <nicveronese@gmail.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Thread-Topic: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Thread-Index: AQHZ4W0RWdxRGxfXIkarEAw9CalDdrAaI2sA
Date:   Thu, 14 Sep 2023 10:06:34 +0000
Message-ID: <e7b49a60-4422-4f3f-3e77-d924f967e939@csgroup.eu>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB3232:EE_
x-ms-office365-filtering-correlation-id: 54ebf0d6-62c9-42f3-31df-08dbb50a4698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNXQIuHYd1MAk3ybFfo/C408XoWBfW4keOb8nKUimUZ0ciC7Occ1ToJeuDCocGW2jWiNLdLUbdSEktv0p1yb//0hLLVjlmeamvWOdDk4ywxdC/m6K7TxQ1KR9a+qgW+HsVVAz6jHlZw/E+XBVhz5frbkBm9oriKE5Asr3z5RxmBCsB3havSECAb8og0JlwklsRCh0zChy4SAs8WYPKwdq/jfZJ9H9CP7KdzjhlGzU3SuEZ2iHZcPr8HEbSs+1v+EB17sZuPUrMNLJ99ot+UYfH19ebFI7QhLCBT2jbmFtx6GCu3hNx7X4na9QEdzxjdw9/vqYPTKIFAonaBk7SoQVcptE5wTb1denon9xDNTJupCuci4F/LZDapC7EB8kujNSH7RZwRNWAEu0tLq91+7JJRFPGyG+cY2j3gPWNdxWt1ty70S3QL1uNxUBK+uc6RGvfFZSUvVlvH586Kpc4rzVOlO9GvF7FbgWJkf+IXU3R5rgFc91DqzghAxiDJxJoJzbAuLqZZuP3Gggh7YS/gF3+NwkXvnnupyxHT/Sac4UxnKJY+G0YlaHvnQVAwWwILVwM5nt4pK3VzcTYB9KEF0Qq/IxdhU3Y86H4xzO/ec95k+mgBIGJGOwAtF4bEbt64cPUJfb3NMF/JwjOPSVBTC7OS6yJEl2Q+uXP05tmx9WGzoOLEOE3dC8Z3cEonzlOmi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39850400004)(136003)(346002)(366004)(1800799009)(451199024)(186009)(66574015)(71200400001)(2616005)(26005)(66446008)(66476007)(76116006)(54906003)(64756008)(66556008)(316002)(66946007)(110136005)(91956017)(8936002)(8676002)(4326008)(41300700001)(5660300002)(44832011)(6486002)(966005)(478600001)(6506007)(6512007)(7416002)(2906002)(86362001)(122000001)(36756003)(31696002)(38100700002)(38070700005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtoenhCSzAzZmY2ZmlnSlVvSVVLRWhvUUM3ZnlFditDWm9Wd2RkamZkb0xt?=
 =?utf-8?B?UHdnYzE4dWZVWWpzNWl3NzVVMDNuSFAxOUtHMEdnUlByRXZJd0JIZWlyNXBj?=
 =?utf-8?B?WDZCNHM2ZlBza0xKdCt3Y3Bab0hVZmk2SDBpY1JyYXVKZU5VRkNvcm93dm9r?=
 =?utf-8?B?NzhaZzhHQ3dKdHpxMjRtYUUrZkcrd21EQUoxSUhPNmZKT3VNemdUZnNMSmU2?=
 =?utf-8?B?cVdtZkRnb3ZoMEpCMGdzKzNBRWZiSDF6WUx1eTZXd2pmd2ZLQVJEZk1BTmd3?=
 =?utf-8?B?YWpaTll0SnN2V0hudHpnMko3SWNEcmQ4OGNWajd3SUtCSmdXT1FGRG5CWEFX?=
 =?utf-8?B?UkxsNVprL1ZPUkNEcUx1NDFkUXBPTWdCVnBMb1hwRElMQnpDYnVzVUxhL2NJ?=
 =?utf-8?B?K0dTRURObTllQ1BscWw3eHVRMEVmUGxJQ0UxWTVNYnUreWx1TEpyQkF4ZVk0?=
 =?utf-8?B?VXdxTGtoNW9UeC9vcmJ0M0F5Z29BazNIWVBwTmZjYmJzQy9TUWUvMzdyWCtx?=
 =?utf-8?B?MkhjTVpFckdPQThCUFRhbURxS1poTktPOTgzaGc2YWtoZ2pLdkVDNVkxd3lz?=
 =?utf-8?B?ZHhnVzBaSDA0WlZqMHJDN3BvbE5vMWE3ZzRVK1FTU0pFeTE3MDF2a0d5Y1Bw?=
 =?utf-8?B?WEhTRHRkcXc5R0NmZ3dQb3NOMFp3Uy9zbHRtOENrckdJME5yZlhKaGVNRi9x?=
 =?utf-8?B?OEJwaC9Bdmo4YmYzaTMxU3pSb1Y3UHhzVVgvQVJIOTF5Q1R0dER6S243R0hM?=
 =?utf-8?B?NzN2d3lWVm1EbzNhL3dSeUd0d0lqSjJUZ05tbFVGeUxrOEFMVXhUUzNMcng0?=
 =?utf-8?B?cno2QzA4RE1NMzRNakoyYzdGOGdQN0lzWGxpMGxsYjgxVHNmeFZaVThSWWV4?=
 =?utf-8?B?SVloOFRSVkhtU0xJN0M2WFBocE5nV1FGVGNZSGg3VWxmdmlmemVxWGk3bkxz?=
 =?utf-8?B?Q0E4bUlrYS9SRUhVRVhlY1l0dWNLbHFKcFd0WVJYUC9LRXdhcWRWK0hzaVQ0?=
 =?utf-8?B?M3FBQVhTR2ZOdFptdmhDYVNnaTBHc0ZGMkg4bmQ3WklYdUc4elNqbHkyUGtW?=
 =?utf-8?B?cVlkSGNmaVZQczhJd09JSWs2MnVoUG9GNEVndVUvNjlValAzOEh0NDMwNEpL?=
 =?utf-8?B?MFAyY1JGclFxZXI3YUxKcExBY2EyVmlZKzA4SVIrcWFtYXZ2aWNnYWtmMlY2?=
 =?utf-8?B?aTNRcEFvLzh4TGpJM1lvTXVhOWQ1Tzdjck1ITEZYYjRDWUh4RURDQ0VvZjlm?=
 =?utf-8?B?aEIxZTBtTFV4WGJOblpGSzdCRXNmMk9zVnZkWnNJVXFzRDl4S0NBOWdVeWpM?=
 =?utf-8?B?RkVPcUphZGc3T2JGOXZkamxiNjFFVEV3YmhONjEyUTFkYlFRdEJPZTVKRER3?=
 =?utf-8?B?SFRhNmV1YlhobU9tMVRBYjBhaGdLTE5pNnJkaTJCL3VjaHZ0WjZKSHZEVFVw?=
 =?utf-8?B?cGkzKzIrTlJqMGIreW9DN0l4cVdhUW9NdFl2dlJ4K082TXE4eUZubWV3QkR2?=
 =?utf-8?B?d3ZRNzVWUWp5NHJFU0kxZ2cvRmxCSXRaWXFrQUNYSWxoQzlYWkY0dk0yTkRG?=
 =?utf-8?B?TWphSGxYeDgrd0FhMVYzcGl5VFV5MTFPN2NueklFUUhETUJzOHZsaE53dW9m?=
 =?utf-8?B?NG9wQ0x5aUF1QytWNDNJaExBMHRVaFpOMDZZYXNxVWdUcmVjdlEvbmFDLzZN?=
 =?utf-8?B?WkcxUTdlOTQ1UStIMXZZWCszd1hzbXB4S29KdGtNNnY0OVV5MmJtcTBKYkNT?=
 =?utf-8?B?cVFPeFhvb090Yk1JUHFRYVcreERjMTMwcFhoTy9CVnkvSVhLL00xQXRhOFV4?=
 =?utf-8?B?c3BsaXBveWcwSGxOMFJ3NnJkQXpaMkc4bk9QNFpMd1pzLzZLRDA0NkpncVlM?=
 =?utf-8?B?UnpWZnFFeW5PYk9VYm5ZRFptUE00V0o2ME9FN3V2bDVMY0NNUHUvTExaSlM0?=
 =?utf-8?B?cElSNWs3S3l6T3FJOW55Vm9xcy9mZjY2V214TEZwSFM2STJDS0FPZjNiRmxp?=
 =?utf-8?B?R0VlRkVudUU3V2szcnk2RkdZR3JiOE9NRG1lK1FnSTBmdjNtbkcrZzBzUGNK?=
 =?utf-8?B?a01YQW1jYXlsN3BvSjkySmJaS1ROQkkwU1lUeVBnSStWM3BucEZyOHlhdjBz?=
 =?utf-8?B?dU9XZmlWNGx0VzU3c3FZMEpIMnBkT2RzOVBiSHg0ZHVDcERHNlp0TUd0L1Fx?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D05E35020C99D4BBACD5102044A59A5@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ebf0d6-62c9-42f3-31df-08dbb50a4698
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 10:06:34.1457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0HUVRJV2Cc3/t0Ze8SMPMdYAdm6UhkJdFBfYidq0yvxxRbKgb38DjDQeDwGJL9zoDEX2acEMDQhOd1dU5i9maIGvmZUhw4OVciBzcgwb+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3232
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA3LzA5LzIwMjMgw6AgMTE6MjMsIE1heGltZSBDaGV2YWxsaWVyIGEgw6ljcml0wqA6
DQo+IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIG1heGltZS5j
aGV2YWxsaWVyQGJvb3RsaW4uY29tLiBEw6ljb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9y
dGFudCDDoCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0K
PiANCj4gSGVsbG8gZXZlcnlvbmUsDQo+IA0KPiBUaGlzIGlzIHRoZSBmaXJzdCBSRkMgc2VyaWVz
IGludHJvZHVjaW5nIGV0aGVybmV0IFBIWSBudW1iZXJpbmcsIGluIGFuDQo+IGVmZm9ydCB0byBi
ZXR0ZXIgcmVwcmVzZW50IHRoZSBsaW5rIGNvbXBvbmVudHMgYW5kIGFsbG93IHVzZXJzcGFjZSB0
bw0KPiBjb25maWd1cmUgdGhlc2UuDQo+IA0KPiBBcyBvZiB0b2RheSwgUEhZIGRldmljZXMgYXJl
IGhpZGRlbiBiZWhpbmQgdGhlIHN0cnVjdCBuZXRfZGV2aWNlIGZyb20NCj4gdXNlcnNwYWNlLCBi
dXQgdGhlcmUgZXhpc3RzIGNvbW1hbmRzIHN1Y2ggYXMgUExDQSBjb25maWd1cmF0aW9uLA0KPiBj
YWJsZS10ZXN0aW5nLCBzb29uIHRpbWVzdGFtcGluZywgdGhhdCBhY3R1YWxseSB0YXJnZXQgdGhl
IHBoeV9kZXZpY2UuDQo+IA0KPiBUaGVzZSBjb21tYW5kcyByZWx5IG9uIHRoZSBuZGV2LT5waHlk
ZXYgcG9pbnRlciB0byBmaW5kIHRoZSBwaHlfZGV2aWNlLg0KPiANCj4gSG93ZXZlciwgdGhlcmUg
ZXhpc3RzIHVzZS1jYXNlcyB3aGVyZSB3ZSBoYXZlIG11bHRpcGxlIFBIWSBkZXZpY2VzDQo+IGJl
dHdlZW4gdGhlIE1BQyBhbmQgdGhlIGZyb250LWZhY2luZyBwb3J0LiBUaGUgbW9zdCBjb21tb24g
Y2FzZSByaWdodA0KPiBub3cgaXMgd2hlbiBhIFBIWSBhY3RzIGFzIGEgbWVkaWEtY29udmVydGVy
LCBhbmQgaXMgd2lyZWQgdG8gYW4gU0ZQDQo+IHBvcnQgOg0KPiANCj4gW01BQ10gLSBbUEhZXSAt
IFtTRlBdW1BIWV0NCg0KRldJVyB3aGVuIHRoaW5raW5nIGFib3V0IG11bHRpcGxlIFBIWSB0byBh
IHNpbmdsZSBNQUMsIHdoYXQgY29tZXMgdG8gbXkgDQptaW5kIGlzIHRoZSBTSVMgOTAwIGJvYXJk
LCBhbmQgaXRzIGRyaXZlciBuZXQvZXRoZXJuZXQvc2lzL3NpczkwMC5jDQoNCkl0IGhhcyBhIGZ1
bmN0aW9uIHNpczkwMF9kZWZhdWx0X3BoeSgpIHRoYXQgbG9vcHMgb3ZlciBhbGwgcGh5cyB0byBm
aW5kIA0Kb25lIHdpdGggdXAtbGluayB0aGVuIHRvIHB1dCBhbGwgYnV0IHRoYXQgb25lIGluIElT
T0xBVEUgbW9kZS4gVGhlbiB3aGVuIA0KdGhlIGxpbmsgZ29lcyBkb3duIGl0IGxvb3BzIGFnYWlu
IHRvIGZpbmQgYW5vdGhlciB1cC1saW5rLg0KDQpJIGd1ZXNzIHlvdXIgc2VyaWVzIHdvdWxkIGFs
c28gaGVscCBpbiB0aGF0IGNhc2UsIHdvdWxkbid0IGl0ID8NCg0KQ2hyaXN0b3BoZQ0K
