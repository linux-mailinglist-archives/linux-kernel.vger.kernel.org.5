Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2F752849
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjGMQ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjGMQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:29:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003C30D7;
        Thu, 13 Jul 2023 09:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd+MNrY4QbkZm+MGeSoEGT9s1U2jZ+iImXfi6Zr5Ubi96JW1YZ7GPUBOL0e870Jzsbr7FWjQRbmm9cxgv+omIOv7t3WRl+im/hKukLEm0hb2VqMXKe17CrOPpGocMqNXVro3KVaphYu6yZRHf6YRapokp5naAFVviDzmlSV1SsOOnWpWHFVqB8XQzhBoyjffkfhCWsSr1mzp6nNllq8hl6xeMaUk8bWxuH6MLaE31jA/i2y0tnhLjIKzpl2bRTSslA+PqmqNuZr35EYxe/Kvgoy8HU5iwasKbHXH9h9/ZF1/st/mBrUR9A50q1bqvdBgH/76Q5o2QYL/PclyI5MLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqeu/u/zEB6LsKvxYFaNUp/p5SuAuwIe84Z6Prv7ZAQ=;
 b=KH2BCLcDH/RZ25CpJbKUjq89oanI1Wk3KxFKYQfq0jp5Y1haI5TsIqf/fSDsFaQZsM/ckdx8mJopyJlUFtPJdf57UCMgOcaLs6Bu0IYXBxfEcCxEtGEo5h7QeKt88Fd9RtaiN+jis9rbIktbgrz5NLmwyZSo1XDo21gJ0ZQ5Fsajx/EfDECh0XIPq8KIKAqs8BphtAcDL+YBjcuEBbWSAZTre1uxmwqM3JhVtxRjbqwYk1FKCDZVqJhfpP13gItzi9xV4iGNiwBObQS6CJFit4O3f158BtRuuSwYqq/nWJoTigSxz8XWHciw8cXJHp4EGWvSQ1+pdQdAD/hNFoKSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqeu/u/zEB6LsKvxYFaNUp/p5SuAuwIe84Z6Prv7ZAQ=;
 b=Pgdu7JDJ86+GVXIlcxnF/YIeyO5D5rPVtd/FxVhhNH/iidU1dfU2+xe4TiUIGOA6bFOw7HDIZqFQJqUZknPAj62lGVPji0GdKbuuqJ491MjYer7O936Uv1yLMsOWJRnn5ESssWIoRX1M9MAJpdcWAbSdWeDGAbAgtBjOEVKvGsbv2LLkJZl2RIEMeKhg4LWO4IeZJaAm+VJvBh/ZpnZfVIAIz6+PEZoQXYGcqQ4oFa2joIJiELCElvdSQJsKbH3VlUb0fPcw4DaosjYrmNTmOGr6/XGDo0lb0Z7gvMBAoau2Ltmpd9Z6aMl43u8neBYbnwbZA4Ub4ZhKkcKBWOF2hw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 16:29:14 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 16:29:13 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "Haener, Michael" <michael.haener@siemens.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Topic: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Index: AQHZrkUWX/bXYZ1FgkKSbFgnrbI4rK+pMsOAgAEQEACAAg1RgIAK/ZiAgAAQt4CAAIQEgIAAD04A
Date:   Thu, 13 Jul 2023 16:29:12 +0000
Message-ID: <d1d3ac6fe99c6f54c82ae0c2f7e817d86b6e4075.camel@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
         <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
         <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
         <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
         <ZK+cvZJmYRkKKZ0d@shell.armlinux.org.uk>
         <d154d59edd2883b30de8f80fa9c08ec7700504d6.camel@siemens.com>
         <d7466827-7f39-495b-a129-91188e3d150f@lunn.ch>
In-Reply-To: <d7466827-7f39-495b-a129-91188e3d150f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7142:EE_
x-ms-office365-filtering-correlation-id: ae90bf48-a741-4f60-c08b-08db83be4b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3rSzSbJMvOoA1sWXGox8GmuVDbEScdLotmwwFLNJWLpVan4l9Ghe7kBrHZtaB263cndujqV8+MYYjw6bmlsiVGkgxnke7Ee4UKDmkH/SBVVuGGGMLoRp7Xx0y9PJpWgXNWO9PW6mmBZcudvTH0hleDVoT4iT3Gz14rv5Xetw6L1SadUOf0goZisAPJVwM03mW6tsUw8h+tkXIMJHS2nBWtP3/Df28jhZxYnwdHJXjt7Zndcsv5jFYXkVyJ2vHZjbfSMsfBdF7fCN+QYPxC3lAqJBM5JWYZxrnQONriwkqxjcxXvRr5l6e/X/Q53R1Hiq8z8iGfUY1+WuDoQ2iH/UHWsvehuMX6fe7qH3CVuXbybj6KyWET1amQC75nZGBSkQ/HEej2Hh2PE9IIZKdmo8aG0SCFbdLC286ymQAoW4RiuXfA/+5RWNOZIC3CR2KXSMBswN0wrjro1yfj6aERO7yiHySY1TUCtKPUFCQpT9VOElHCRD+8DqP4Us+cgf5I4SqyxkVQvxwzaO/kZ+BL35fB03UGdblhFDCR8J/S21UUFM7Y8FK7D3LuMRJP3+/K4DiINrop2iC2I8gzgXHyas7vE8VaeU8DRhF4JwARCfxx/srCP0dXidiIqBpD6Jw3SSTINd9Y+kZJYiXaO96tKQlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(8936002)(8676002)(83380400001)(15974865002)(2906002)(4744005)(82960400001)(2616005)(36756003)(38100700002)(38070700005)(122000001)(86362001)(7416002)(5660300002)(6506007)(186003)(316002)(71200400001)(91956017)(64756008)(66446008)(6486002)(66556008)(76116006)(66946007)(66476007)(4326008)(6916009)(478600001)(6512007)(41300700001)(54906003)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmN0cHNNMDRuVzM2bzZtVy9zMi82aUNFNitaN01Id1VvbGtBZG11clJPRGhT?=
 =?utf-8?B?ZWNTU3ltRUFrMWVXVUlEUGNDdVdpSmk1YlZ1N2JueUtqUDhpWld4c0tKKzBF?=
 =?utf-8?B?cGtJNWk5T0hmVU4rUEpyZ1FTMWl5Zy9JZS9qellhcXZSVG5lNXVtK0pnajJE?=
 =?utf-8?B?TUVPdGRBM2hua1BkbzdoWGFOdGMyOThBdzdUWWtteVpxUEZvWExiNStzREl1?=
 =?utf-8?B?YWpoMkV0NC9SSk1oZlNQYWMrOFNqd09aTUcxeG80eWtKamJwZEJUV3h0QW9W?=
 =?utf-8?B?NnJPbEgyelQ3cWJmRW5nRDBjRW4vVTNDQ1MyZHZxVnJCcCt6R2QxZmp0SUxG?=
 =?utf-8?B?bzRyYThQK29IY0kzTm5LczVyQjJVV0Q4WVZVS05IcmJ2Zk5zTTJxTXg2eldT?=
 =?utf-8?B?NWRRS0x0Zm5Sc0V4V3NkMmNKbWlsNnA2YkZwbW5DS1piWk9MdHdreVdFTEFU?=
 =?utf-8?B?OHJnTUQwN0R5UzliWVNUU04rN2QvSi8vR2g5K25YSHAzWFMwV2FxempCVCtB?=
 =?utf-8?B?aGdscXhlV2pXUisyWEtBUDd3d213N3ltQmpmMml1dnYrUG5rQUszMXoyY3lV?=
 =?utf-8?B?amkyOHkxemNSUEJtbkwxdk8wNVd6ajVseGxQdGtFSTVqNHRyTTFGQ3FDUkZV?=
 =?utf-8?B?d0FYTzJhVkhiaTJ4Q0V6b2VoOTdWcnVlZ3JvU1pva05qdFFoSEFVUEllWkxH?=
 =?utf-8?B?ZUw1dmwzY1ZNaVJBcStYdzdMWlRJQXRaUnFJRjM0bW9URGpmdDh4K2dUYnRU?=
 =?utf-8?B?VmJZWURrbU5wZGNkeWRxOWh1WnVEN1FXSGZrYTY2VEdWZnJvZ01NdkVVTUtW?=
 =?utf-8?B?OWUybFBBNkVmWlZ0YjNqdEp4eXAxQVdvc1hNVmMzN2RHK3JsLzl2RGZIUEY3?=
 =?utf-8?B?a09KWlZBZUZYSFhsN0oyOGwzQytEeFdaSGNkdlFpQytuUGdzRGtQd081RlZZ?=
 =?utf-8?B?VjRLd3YvSjMyeCtsNFhNYlFWeEJ2NzcvZERpQ0tNbzJjaTZRa1ZpU09mOGJk?=
 =?utf-8?B?Tno0bmFFU3UrM1JMUk5YNU1DN01UaFNkcWFydTBCb3VrSzdubjY4dWxnV0VB?=
 =?utf-8?B?TGQzcldoNmhIWGM3SCtBd2RxN3Y0WkdjLzB3Y25DYkRteWtnWU81SjVZZ0hT?=
 =?utf-8?B?eE1Tclg1OVFETFRpUkIzZEV6cDJyaHRvdndINFNpWk1ySHFGcDByR2hvK1Bu?=
 =?utf-8?B?S2NOeEZ0eFhLNWlqdGtmWE5BNHFaV1d3Y3gxMllRT3NNbCtsemNkbm9FVmJm?=
 =?utf-8?B?NkZWUUdQMHEzek9MZWxHd2FDd01abXZ1ZmVaOGFtRHpNZjZJSW12TUY2M2xz?=
 =?utf-8?B?MGVDMG1UUEQ3K01WL0lzaERsaWN0d3BwcUdjYkJaUEF4TVZUY21zOE5uSmdU?=
 =?utf-8?B?WEovQ0NFd0hBeGtHYTAwMlZIWHF4aHBNZitkdU1KUnBrU1NvSC9VWkpncitV?=
 =?utf-8?B?Y1FxajZCcnYrM2x4eTFhVmNQa21kaEdxYWFPVHdnOU9XM3NObXZZc1UvWVcx?=
 =?utf-8?B?ZzNHS2tXdzVVcUVxSmRzODE3T0lyMDBPSUd2WHE1UVNTNUNMYnkzbjV5d2h2?=
 =?utf-8?B?MFMxMW1NVlFRcExuMnRzVS9JdjdUTWszTlcycjE2UXZqTjlZSkZ2Nng4Q2RU?=
 =?utf-8?B?SUhPbmlYMGhlWko0YTYxQ29kWDFHQW1tRCtOMGNMUWduaFNYdFZWU1M2RjFI?=
 =?utf-8?B?VGxFUGo4T3FqbVJWUUpLaFgyS0xsZjYzTDMvQWxQNjNnSitkZ3JYVEsvYS9R?=
 =?utf-8?B?bEpaMWkyQUk3cTdVMjNXejlSV05PQUlTc3doaWhxRUdSa1NJWHNoTml1K201?=
 =?utf-8?B?clFGbWNuRWRqT1oxUTZ2MkZNRFhmTXJBZnR3S05kUklVOFBuTUJyZTNyRWxi?=
 =?utf-8?B?OHRYY0laVXhNVE16cExTREJOOHQvdjNXTEZYZnpEUzQ1bUJWSnNJMTI3ZWN4?=
 =?utf-8?B?cWZwbGNwazlyUzNtRHVNMTBRWTF6TXMyQTlTMUxIREpHYk5DUGJ5eEY4K2ww?=
 =?utf-8?B?QkhhV1BMOHU3R0N1ZEUrVXkvZVBhZ2xBSXoxWW1UTHg5OGpYR3dPbWc2d291?=
 =?utf-8?B?SGp2KzdSKzEwZ0ptNXpyNCtXTXlGdGJLS05hNXFmd0pxVlVkb1RGV0poRGlv?=
 =?utf-8?B?bGtrLzFaR1MvaG14a2ZhekhtMkJKUnY2TU1IKzVUeUl2SW9HTUtGTDhiN00w?=
 =?utf-8?B?Mjg2UmNHNERhbVVkWUdvNlJ6WmlIVWQxWFE2UlpBclJtZFJoelFNRVExczEy?=
 =?utf-8?Q?KKwZIt4liC9pUh3c+erhwGtuTpQgLdUuLCe2yUlioY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4432F547492FCE4AAAAD0791384F8ECA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae90bf48-a741-4f60-c08b-08db83be4b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 16:29:12.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVwfIp3ufreNd5izUPRPt+x4rLAnjTeetVEz5sWvkujIPr/GOiGEe2TcIIGgE+SXDnrT+SU1oKSX9jZBuK6rXFHIw5Mbo5QIBj8ZFmEMqmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiBUaHUsIDIwMjMtMDctMTMgYXQgMTc6MzQgKzAyMDAsIEFuZHJldyBM
dW5uIHdyb3RlOg0KPiA+IHdlIGRpZCB1bmRlcnN0YW5kIEFuZHJldydzIHJlcXVlc3QgaW5kZWVk
LCBob3dldmVyIHdlIHdlcmUgbm90IGFibGUgdG8NCj4gPiBiYWNrcG9ydCB5b3VyIHNlcmllcyBx
dWlja2x5IHRvIHRoZSB2ZXJzaW9uIHdlIGFyZSBhYmxlIHRvIHRlc3Qgb24gdGhlDQo+ID4gSFcu
DQo+IA0KPiBCdXQgeW91ciBvd24gcGF0Y2hzZXQgaGFzIGJlZW4gdGVzdGVkIG9uIG5ldC1uZXh0
IGJ5IHlvdXJzZWxmPyBTbyBpdA0KPiBzaG91bGQgYmUgdHJpdmlhbCB0byB1c2UgImI0IGFtIDx0
aHJlYWRpZD4iIHRvIGdldCBSdXNzZWxscyBwYXRjaHNldCwNCj4gYXBwbHkgdGhlbSBvbiB0b3Ag
b2YgbmV0LW5leHQsIGFuZCB0aGVuIGFkZCB5b3VyIHBhdGNoZXMgYXMgd2VsbC4NCg0KdW5mb3J0
dW5hdGVseSBpdCBoYXMgYmVlbiBvbmx5IGJ1aWx0IG9uIG5ldC1uZXh0IGFuZCB0ZXN0ZWQgb24g
YSA1LjE1Lnggd2l0aCBzb21lDQpsaW1pdGVkIGJhY2twb3J0cyBzbyB0aGF0IFJ1c3NlbGwgc2Vy
aWVzIHdvdWxkIHJlcXVpcmUgZXZlbiBtb3JlIGJhY2twb3J0aW5nLg0KDQotLSANCkFsZXhhbmRl
ciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
