Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59778FA7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbjIAJJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjIAJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:09:13 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE691;
        Fri,  1 Sep 2023 02:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6xh2s+yJaRi45hhxdcJq/Os74GRRX1y2lvX+eezz9mHW3huf/DPRbpRv3O4dAujYO/z0A+vvqIMpltz/iL5MDFi+sMXo2/MvriEdUJH2DupIiK3Qtk2ewIxM2203vf2imltuQKNP79Opwf9Jfko6SLyC72s+u/MDSg/WoNXVuup/w/eDZAx6rtXfSOPM7msV9qogeRJ4u1iQBFjSDdCLnVTMA0SKuTMPf6lwLIeZ2YxXwJ0uXiqmXmmiy6UHSd9nXyI51fOK5vUGDCM4sJ+XyElFQMThVKbJAfcRpWcCaDJHV/kGwkSKSuihffq56xe+NePWhAiYuFEGLe92Ww90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilT4LvAZs25Ka4tswcUCfLCs3rjc3Bs+OWSbqKnZviQ=;
 b=lYrYzE+5cFPXZK+3h4aI3jbCqTBODpREu7i4zU36t7EAN6vWvWAUsmbjK0lo1kxtFUYQzIJq2jEQPsXGVcgmop+osR0/9LgsWM79hhQ1upPtA+ZkFpGzfPIxU6zpZ7t27TMYsMRWvdy5xzrHQE3hdlAQc3PXp3voGi4kiis/eqzC79aHzYEBUdSHQvx8GegaRY3G6D8GeesYQ+PHF7E7R2yNKHSgbLkW70L2PZQT8UVl0o+BuLPsq7Fleqv1n/3lrtmTO36K9pd4nRwQGSWeDG5aswsX0TtYh+jP0ijVGMr83xQJ1fFD81GkyObLlZS4H7TIrzntvrssVzzN0LYTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilT4LvAZs25Ka4tswcUCfLCs3rjc3Bs+OWSbqKnZviQ=;
 b=kUCDEDJlpBVWa+Zio9PjLh88f8ATf9GiOEeRk+ncYYxzSnvlcvg9zYTfh1P5anba8/zUj52AGjEe7fH7/i3nS9iZAdWcoFDSrlsgU3vFN/aFXgJMbttnQu3iJDfEbWfu1IfV1tsd/T5F4izjR64X7rdYkB67PTls4oxU9yKBgE0=
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 09:09:06 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6745.021; Fri, 1 Sep 2023
 09:09:06 +0000
From:   Radu Pirea <radu-nicolae.pirea@nxp.com>
To:     "atenart@kernel.org" <atenart@kernel.org>,
        "Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        "sd@queasysnail.net" <sd@queasysnail.net>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Thread-Topic: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Thread-Index: AQHZ1mu4tG1uTW2DJUag1r75iZMRuQ==
Date:   Fri, 1 Sep 2023 09:09:06 +0000
Message-ID: <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
         <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
         <ZOx0L722xg5-J_he@hog> <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
         <ZO8pbtnlOVauabjC@hog>
In-Reply-To: <ZO8pbtnlOVauabjC@hog>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8954:EE_|DBAPR04MB7367:EE_
x-ms-office365-filtering-correlation-id: 36a4065c-8d12-4416-345a-08dbaacb1843
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTJ+Wex0xy9nsY5eHHCIVtH5TcbRNC7Jdt3fhhiohA5JGs9c6ZUubHmtcTM8nx+dc+KSTjrz6CZYFdKVVrpJVKqNfNewTE9N9HkCLrR2CEuY8/ScagR7kBD1SZDVO7SSMJ+tDfbhyw5z/W+iC21lGlE4fZs7dnsCy5JmrgoA8p/yPd4LBdnv8X8ExbSmjLiUDuzrtM8jinZ3m88GuIBTsMbJahEicOrK/lhSwv1+lP2KpAG43+rVwUfI5M8SbPwJyJqqA4/Yz8R8h1RvuqQwBVBkv+FO32KyzAHkyfDWLRZkl5JX2ZhkYEoTBleJ9Sfuf/7XD+LnWk6NOdSWGUYQYQpT1ke4rfV3T2Xj0TDzWdMrgV2B4tB9faSd5vj10cJbiVvJAQXyKuEXny3zbCrh8Vb7JRik0lV//SWacKuOahvwC+vvqMBTCJHI/JSfvmi5lnrf6FbRyY2QQ1p4R/zRcCNz6DQi9XZeMX6kgZdqehGBUsY1BSXYExqeDYAV7DBdctrWP1AdWPdhcK3KzpmwxEtm3zfsjKpBRmeS6eEHGGrzNj85zXvkeHAVP13HGp05bMhyMd9x3zuChEYq3LpP2YOr2Iekvwgz2c136NJK7MTgnXgRYNn5brsLU0vYSn9N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(1800799009)(186009)(451199024)(6486002)(6506007)(71200400001)(6512007)(478600001)(83380400001)(2616005)(26005)(2906002)(7416002)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(41300700001)(66946007)(76116006)(110136005)(5660300002)(4326008)(8676002)(8936002)(36756003)(86362001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWtWQyszUEh0UjVSdlYyU0VYUzFaWC8wdjBqMzhPTVArQmNDVSt6SlZjVkJt?=
 =?utf-8?B?bWg1cHBXNG93V0VObjRmVDNYSnY3QktUOXFEWXIxTjF6TzNrMlVndFJweGtP?=
 =?utf-8?B?Z1JMRjkra2xFbkZiOUhIOWpaTlN2L0dZaU41ckZRS2VGTTVJd1VDc1JWVlFR?=
 =?utf-8?B?UytycGY1d0tqTVFZaURIbSs1RHBjZ2taOW1SYXdBeDlWRDJDeSsxYy9jdXFO?=
 =?utf-8?B?anVZTURBNkpWakNOYzZ1dzdzcmZadkxGTnBhdEdBKzdDb1lzTDh5QWpXNW55?=
 =?utf-8?B?eUpQV05WUjBVd0pjeHNkMElKNmVjRStObmhUeXcvczY0Q2tuYUlSbTh5TSty?=
 =?utf-8?B?ZWtMaXp4bE1CaG9WbXkvSjgvZmU5M2ZHaE1EUDFmTnZhazdhdWxWZTloallq?=
 =?utf-8?B?TlA0VjcvV0xGeFdsOXhNd1hubVNxNEtxdTN2MFYyTWt6UmxpTnJaZzBROG8v?=
 =?utf-8?B?TjI1SXpiY2tXRGpRemw3dDhZWi9nK0ZzQzVKWWJ0VHlNUmVFVFhQZmcwNXkv?=
 =?utf-8?B?aWxhMjh5VE9DT1R5a3krb01veTByNURyV2hsSHJVVGVrMitRczgzNVd0R20w?=
 =?utf-8?B?ZGUwMXErYi9wM2s4SHkzeUJLWFkvd3YzUW9KeG02a1RtQzNpZEhock1xTVpK?=
 =?utf-8?B?U09XeXVFc3dIRHU5UG16d1kzL1NnemJpOHcvUzE2N2krWCt4ZE44UjdOd3Rh?=
 =?utf-8?B?NG9RVVBzakVRTWVaV0RUNTZVYkRCanc4TklkbDJVN0FmektyaktiSTIydFhI?=
 =?utf-8?B?YjlwVkkxM2JwN0tFbDhOUnR6K25ZRnFWVUNkNUtwUllRUE42NlFVL204Z1dM?=
 =?utf-8?B?M1lZTmtzSDVHZE5BbDAzak9RNkhiMWZwRUp4NURHc2VRSENsZlJVUEZLM3BJ?=
 =?utf-8?B?akx3cXAzUlk3cFZPOVdTeE1qYVJyWFZoeE9jN3FqWFdpeDBwbi84andHRGdM?=
 =?utf-8?B?V2RNelRDMHpiK1NxSVBHdm02R3BLZmF5MExUVG5GY0hVS0FwVndxQ1dZRnps?=
 =?utf-8?B?ejYzeXJrZnBhb1lZY3hJOHpsN3NpZkEya0hDUkRXOVN3bFEzN0U5TVQzbDBS?=
 =?utf-8?B?alBNNjVmMGhJVjdSZmpqaCtYMUsrbTEvSmU4T0lxUzVDd0tuY0JiM3J0REdp?=
 =?utf-8?B?bVdrYTJ0UWFVbUticW1nWXlzSis3d0oreFU0RkNoTFdIWGxZcnBFK0QrWHBV?=
 =?utf-8?B?b0p1Tjk4QUNnZGsvSXREdU1UYkh2NHMrVzRDT1FlNzZNdURVNHZ0TjVZc0cx?=
 =?utf-8?B?TEY5STFBZkowV00rNFVBdnZWY2tKdklSdjZGa0x1ZXJ5WElKRy9VaW5MZDRO?=
 =?utf-8?B?K2ZiZEoyeUtyOURpd2dFWXluWXUrbTJ5VEZJK0pLZXVRNERIam5BR0tlOUxY?=
 =?utf-8?B?L3F1YTZMT096cHJuR2VpTWFudkZzdnE3RFdzRmdHMmlQYkZXMkNadHl6aE1y?=
 =?utf-8?B?SWR0dUxHQlo0bkFGM09rTWxhYSt5eHE4K3JpZlN0VGVQNTJMUUpwT1dINjBK?=
 =?utf-8?B?ZDczU1BEeG1tQm1RRzRTdUZZc2diYUJ6djZNYnNXWGRaWUN3L2l2TCttRG03?=
 =?utf-8?B?TFRsWjFFM1ZiS3B2aUlpUDFEOE1jdjdxWjJ5R0h3aTNJVk82ZHZkRWN5dVov?=
 =?utf-8?B?QjZxNGtzQkRmVjBzZE94bUdiamxUYkU1Q3JFVUtLam9iTkQ3bkk2czlvZ2tn?=
 =?utf-8?B?VWhzcE1FdnVRQnRqbURhZ3NFUXdWamJ6WnRRZWNsazNtYWpCYTBPRGlwSHZy?=
 =?utf-8?B?VmJRUFl3MjhZV1JLaWhqangzdXB1dkJBTDJPVGVLZXFBTnd0V3d4anFWWlFM?=
 =?utf-8?B?SWtGN3NGUE1OKzFLVTlrUmQraVVxY1NaejRCdktNejl4WXhBb3MzSloyK2NY?=
 =?utf-8?B?WDg0Rjg3RnZsL0ZDN3BYNXRUcGg1UnR6TXhNaTY3NHd1NStKbXl6dlZob2hC?=
 =?utf-8?B?T0JmeG9ra0RlL3hIT3AvQWpvaENjeStESzRxMnRXeTVFa1pqcENOdldYVFlN?=
 =?utf-8?B?SGhSOUhOZVNuS3ZhRUJjTlZXalQzb21EUzJWMWY5U1hGaHNHMkxKalZaaDUv?=
 =?utf-8?B?WFZCc2pCNkl3VTFZbXN5TlBsZGZpeXh6ODZSUTBMWFQ5RjhOcXBKUGFoT0Fl?=
 =?utf-8?B?MTA2eW5jcVliazUwTXBvOXdQc2RrOS9zK1hIWmdKL0FBU1VkeVBER01YNHQ4?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C862C79A644C45912B6BB3CF5BBCB1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a4065c-8d12-4416-345a-08dbaacb1843
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 09:09:06.4734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtvnJhF1AOAX8K/H/CiH7De6FAxfqMrDzaPT6PYf9e+FMx9TPbv83e0UCE++P6NL6NcKMzNEDm6IBFsmTi2py39ptTjDS/SEe2Xzd6OxgVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDEzOjM1ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQouLi4NCg0KPiBBbmQgaXQncyBub3QgcmVzdG9yZWQgd2hlbiB0aGUgbGluayBnb2VzIGJhY2sg
dXA/IFRoYXQncyBpbmNvbnZlbmllbnQNCj4gOi8NCj4gRG8gd2UgZW5kIHVwIHdpdGggaW5jb25z
aXN0ZW50IHN0YXRlPyBpZSBkcml2ZXIgYW5kIGNvcmUgYmVsaWV2ZQ0KPiBldmVyeXRoaW5nIGlz
IHN0aWxsIG9mZmxvYWRlZCwgYnV0IEhXIGxvc3QgYWxsIHN0YXRlPyBkbyB3ZSBsZWFrDQo+IHNv
bWUgcmVzb3VyY2VzIGFsbG9jYXRlZCBieSB0aGUgZHJpdmVyPw0KDQpZZXMuIFdlIGVuZCB1cCB3
aXRoIGluY29uc2lzdGVudCBzdGF0ZS4gVGhlIEhXIHdpbGwgbG9zdCBhbGwgc3RhdGUgd2hlbg0K
dGhlIHBoeSBpcyByZXNldGVkLiBObyByZXNvdXJjZSBpcyBsZWFrZWQsIGV2ZXJ5dGhpbmcgaXMg
dGhlcmUsIGJ1dCB0aGUNCmNvbmZpZ3VyYXRpb24gbmVlZHMgdG8gYmUgcmVhcHBsaWVkLg0KDQo+
IA0KPiBXZSBjb3VsZCBhZGQgYSBmbHVzaC9yZXN0b3JlIGluIG1hY3NlY19ub3RpZnkgd2hlbiB0
aGUgbG93ZXIgZGV2aWNlDQo+IGdvZXMgZG93bi91cCwgbWF5YmUgbGltaXRlZCB0byBkZXZpY2Vz
IHRoYXQgcmVxdWVzdCB0aGlzIChJIGRvbid0DQo+IGtub3cNCj4gaWYgYWxsIGRldmljZXMgd291
bGQgbmVlZCBpdCwgb3IgbWF5YmUgYWxsIGRldmljZXMgb2ZmbG9hZGluZyB0byB0aGUNCj4gUEhZ
IGJ1dCBub3QgdG8gdGhlIE1BQykuDQoNCkFncmVlZC4NCldlIGNhbiBkbyBhIGZsdXNoIHZlcnkg
c2ltcGxlLCBidXQgdG8gcmVzdG9yZSB0aGUgY29uZmlndXJhdGlvbiBtYXliZQ0Kd2Ugc2hvdWxk
IHRvIHNhdmUgdGhlIGtleSBpbiB0aGUgbWFjc2VjX2tleSBzdHJ1Y3R1cmUuIEkgYW0gbm90IHN1
cmUgaWYNCnRoZSBrZXkgY2FuIGJlIGV4dHJhY3RlZCBmcm9tIGNyeXB0b19hZWFkIHN0cnVjdHVy
ZS4NCg0KPiANCj4gQW5kIHdoYXQgaGFwcGVucyBpbiB0aGlzIGNhc2U/DQo+IMKgwqDCoCBpcCBs
aW5rIGFkZCBsaW5rIGV0aDAgdHlwZSBtYWNzZWMgb2ZmbG9hZCBwaHkNCj4gwqDCoMKgIGlwIGxp
bmsgc2V0IGV0aDAgZG93bg0KPiDCoMKgwqAgaXAgbWFjc2VjIGFkZCBtYWNzZWMwIHJ4IHNjaSAu
Li4NCj4gwqDCoMKgIGlwIG1hY3NlYyBhZGQgbWFjc2VjMCB0eCBzYSAwIC4uLg0KPiDCoMKgwqAg
IyBldGMNCj4gwqDCoMKgIGlwIGxpbmsgc2V0IGV0aDAgdXANCj4gDQo+IFdpbGwgb2ZmbG9hZCB3
b3JrIHdpdGggdGhlIGN1cnJlbnQgY29kZT8NCg0KKHRoZSBpbnRlcmZhY2Ugd2FzIHVwIGJlZm9y
ZSkNCltyb290QGFsYXJtIH5dIyBpcCBsaW5rIGFkZCBsaW5rIGVuZDAgbWFjc2VjMCB0eXBlIG1h
Y3NlYyBlbmNyeXB0IG9uDQpvZmZsb2FkIHBoeSANCltyb290QGFsYXJtIH5dIyBpcCBsaW5rIHNl
dCBlbmQwIGRvd24NCltyb290QGFsYXJtIH5dIyBpcCBtYWNzZWMgYWRkIG1hY3NlYzAgcnggcG9y
dCAxIGFkZHJlc3MNCjAwOjAxOmJlOmJlOmVmOjMzDQpSVE5FVExJTksgYW5zd2VyczogT3BlcmF0
aW9uIG5vdCBzdXBwb3J0ZWQNCg0KQnV0IGxldCdzIGNvbnNpZGVyIHRoZSBuZXh0IGNhc2U6DQog
ICAgaXAgbGluayBhZGQgbGluayBldGgwIHR5cGUgbWFjc2VjIG9mZmxvYWQgcGh5DQogICAgaXAg
bGluayBzZXQgZXRoMCBkb3duDQogICAgaXAgbGluayBzZXQgZXRoMCB1cA0KICAgIGlwIG1hY3Nl
YyBhZGQgbWFjc2VjMCByeCBzY2kgLi4uDQogICAgaXAgbWFjc2VjIGFkZCBtYWNzZWMwIHR4IHNh
IDAgLi4uDQogICAgIyBldGMNCg0KSW4gdGhpcyBjYXNlLCBhbnkgSFcgY29uZmlndXJhdGlvbiB3
cml0dGVuIGJ5IC5tZG9fYWRkX3NlY3kgd2lsbCBiZQ0KbG9zdC4NCg0KPiANCj4gPiBUaGUgb25s
eSBkcmF3YmFjayBpcyByZWxhdGVkIHRvIHRoZSBQVFAgZnJhbWVzIGVuY3J5cHRpb24uIER1ZSB0
bw0KPiA+IGhhcmR3YXJlDQo+ID4gbGltaXRhdGlvbnMsIFBIWSB0aW1lc3RhbXBpbmcgKyBNQUNz
ZWMgd2lsbCBub3Qgd29yayBpZiB0aGUgY3VzdG9tDQo+ID4gaGVhZGVyIGlzDQo+ID4gaW5zZXJ0
ZWQuIFRoZSBvbmx5IHdheSB0byBnZXQgdGhpcyB3b3JrIGlzIGJ5IHVzaW5nIHRoZSBNQUMgU0EN
Cj4gPiBzZWxlY3Rpb24gYW5kDQo+ID4gcnVubmluZyBQVFAgb24gdGhlIHJlYWwgbmV0ZGV2Lg0K
PiANCj4gQ291bGQgeW91IGFkZCBzb21lIGRvY3VtZW50YXRpb24gZXhwbGFpbmluZyB0aGF0PyBV
c2VycyBuZWVkIHRoaXMNCj4gaW5mb3JtYXRpb24gdG8gbWFrZSB0aGUgcmlnaHQgY2hvaWNlIGZv
ciB0aGVpciB1c2UgY2FzZS4gTWF5YmUNCj4gZGlyZWN0bHkgaW4gdGhlIGRlc2NyaXB0aW9uIG9m
IHRoZSBtb2R1bGUgcGFyYW1ldGVyLCBzb21ldGhpbmcgbGlrZToNCj4gIlNlbGVjdCB0aGUgVFgg
U0MgdXNpbmcgVExWIGhlYWRlciBpbmZvcm1hdGlvbi4gUFRQIGZyYW1lcyBlbmNyeXB0aW9uDQo+
IGNhbm5vdCB3b3JrIHdoZW4gdGhpcyBmZWF0dXJlIGlzIGVuYWJsZWQuIg0KPiANCj4gSWYgaXQn
cyBpbiB0aGUgbW9kdWxlIHBhcmFtZXRlciBJIGd1ZXNzIGl0IGNhbid0IGJlIHRvbw0KPiB2ZXJi
b3NlLiBPdGhlcndpc2UgSSBkb24ndCBrbm93IHdoZXJlIGVsc2UgdG8gcHV0IGl0Lg0KPiANCj4g
QW5kIHRoZSBwYXJhbWV0ZXIncyBuYW1lIGFuZC9vciBkZXNjcmlwdGlvbiBzaG91bGQgcHJvYmFi
bHkgaW5jbHVkZQ0KPiBtYWNzZWMvTUFDc2VjIGlmIGl0J3MgdmlzaWJsZSBhdCB0aGUgbGV2ZWwg
b2YgdGhlIHdob2xlIG1vZHVsZSAoaWUgaWYNCj4gbWFjc2VjIHN1cHBvcnQgaXNuJ3QgYSBzZXBh
cmF0ZSBtb2R1bGUpLCBqdXN0IHRvIGdpdmUgY29udGV4dCBhdCB0bw0KPiB3aGF0IHRoZSBUWFND
IGlzIChhbmQgd2hhdCB0aGUgZW5jcnlwdGlvbiBmb3IgdGhlIFBUUCBmcmFtZXMgcmVmZXJzDQo+
IHRvKS4NCg0KSSB3aWxsIGltcHJvdmUgdGhlIGNvbW1lbnQgYW5kIGNoYW5nZSB0aGUgbmFtZS4g
VGhhbmsgeW91Lg0KDQoNCg==
