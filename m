Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C88130B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573175AbjLNNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573145AbjLNNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:00:10 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2082.outbound.protection.outlook.com [40.107.9.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB81113;
        Thu, 14 Dec 2023 05:00:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyVKnKeQb2W7Ek63+En1QTQo4S2s/mvEybVo0ilwnCgvo1T0IlK7ZC54mD1F8Ldt2qSWayOBz30aFju08obLVPrDli5zZ7ipR/iDrX1oX/aJQvA0348Z1iNt1ynNXXvQ1Su0v7aKETHVIu7BnNKb4s0tnPhB/eKvkU8uUACrdHI0+YdvUwHNJEJeAJZb0UU54DpftZeLNQY+JPNi96wAo395TUNt4aK2I8ULdwVlxvNxKflF58yScoycg3O6tO7qbwf/FFBQMlJvmu7UZdD8f3jbJsoDLKNpDzE5Z+2Y3wz8QTvwejbOWsty4rtTLRUiMW2560uSGFO/VZv1xI6yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SrKoISf3DhIrftCTgqvNczMN5vP0iCy6qDdm6+cxoE=;
 b=POfG1nMc32j7/sv9L4HFFf2DR8jWzccVN9+ncryyzXwb0kgESCla7+z1ZT4UXA5JZ9hUFpkqtV+ZEENzg9f1CLaIvmSQkeWRibq6mFysf99OuhIoZfKolScNg0PMjg50ScbtoNiRN/uUtedrporvemY8mY+TBVDl6IpXwX8O2FFxJMWSr7yCNoaamzJ2dG0KE/1g8nsV02pm/PYI6QFBH6iHUj2X7nhetHpNdsLjsgu7WC4vRIjicO1QAs9qetv71E9Stpqu4oiZqLj+5y43FHXw5Hei2T/7RVaInPvPcpiW1A3e3mbKE+KuF7SZ0no5TqBE3rURJRWvG+eBGYfSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SrKoISf3DhIrftCTgqvNczMN5vP0iCy6qDdm6+cxoE=;
 b=Q0KlNlIijl1xqzS7qaWQP61yilSAOry65GDEc5ja28Q+Xi1HUahzWW4XJex0LG9qjdYNU0zxJ2c9oT05g//23L52bXgHnq7IpVx1SN1xpBAFA1ty/2ZzIukTWxilDEMQAdbRwev6BUhBs9tL/j725pNeJHRuq5hcVZN33vju7ik8eedq6n6ZCqDFjo8B1YLGJTOyvxj/JF3wRHSzrBwciM3fC2D9y/2mA2YGGhNfODMJqN45oF4fLI+MOFNoXnsE9UF/fHBvbSLKDaZLUJhk5vSrsKt5tOxClWpnwSW+voxLOuGYgOTHKDPSPfnyWPMP6IF88BzLaSUfs8KjFFCKow==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3042.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:00:12 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f788:32b4:1c5e:f264]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f788:32b4:1c5e:f264%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:00:12 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     George Stark <gnstark@salutedevices.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "vadimp@nvidia.com" <vadimp@nvidia.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "nikitos.tr@gmail.com" <nikitos.tr@gmail.com>
CC:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kernel@salutedevices.com" <kernel@salutedevices.com>
Subject: Re: [PATCH v3 03/11] devm-helpers: introduce devm_mutex_init
Thread-Topic: [PATCH v3 03/11] devm-helpers: introduce devm_mutex_init
Thread-Index: AQHaLhP7EUtTiJmPIEy5WnZk/rrl9LCoji8AgAAtSACAAANRAA==
Date:   Thu, 14 Dec 2023 13:00:12 +0000
Message-ID: <717727a1-6a99-43ff-b032-b7a20542cca8@csgroup.eu>
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-4-gnstark@salutedevices.com>
 <80881d5d-3ae9-4580-84c1-f25b421cc518@csgroup.eu>
 <99882775-af52-49ea-b17d-f3d1f23f8bbe@salutedevices.com>
In-Reply-To: <99882775-af52-49ea-b17d-f3d1f23f8bbe@salutedevices.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3042:EE_
x-ms-office365-filtering-correlation-id: c14cc2e6-15b9-4d2b-e5bf-08dbfca49c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKGni1D/hCPUh4d/so/FGHirL5QlGvyG7rg4pm2M6G7hvPodoEdPVrzBGOF927EflFjzcFZ+5bIry4DvWY0RLFMn0L7ba1XTzTDRtbW9pczNPRofEp/B6/iX260uwnjbXQ8c8X2hfbO1wBiT9QMG+mePmUSnbDfe+5tN5pzGZQvLgl3/02NyRhvFKUIZBi7D9HYNc4PJRWNgkWLBHcTm0Qx0lWuikDEQ2RSeElAkk56MkwLK5dmAc6YWpgbUS6z+Mzv91hcbOMJJKraqISxjluELXKkn0qIBif7E06aSFQOUhQE2igssXSEhXEhbbK5XhaCQ3DC3PdQvA0RsiA5s/8zuBlC5119hRKw7bHtromfByYahYabMdY/i3KXddo1/xM8IeBRurnjUVrsSo9lcwL39ceyQJH3TcADrdppkO9vozJVBCPjrWYlee2T/jrhrkng/0C/u8fLk+N0WBtt1b9W/KusUFP4kvhod2Fcwue6a5kCVFGZPUt4tCWpdukqf9lWPTcufRfwrD2p/7m1G0E6MgFkRFtH7U8nK2+dwzQyXiPeFN6VqdB+6RO+yOS7MjQzkOS6aqtzF/WLTgiLUBE4Z0zJqwgNNYA7vkb+LuJrv0fgZA2D6zYL6AldwIBPq5RUgmiSJfnJKlFmhpztabwwqEUH9rSK40X3Qu7LN3HRXNt12SkZ/vhRVIoF9zm0d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39850400004)(346002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(66446008)(66574015)(53546011)(6506007)(6486002)(2616005)(6512007)(122000001)(966005)(44832011)(4326008)(8676002)(41300700001)(8936002)(71200400001)(2906002)(316002)(5660300002)(7416002)(478600001)(64756008)(110136005)(54906003)(66476007)(91956017)(66946007)(76116006)(66556008)(31696002)(86362001)(36756003)(38100700002)(921008)(38070700009)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXdMT0JLNEIybDVCSWdob3BTTEIxK1UvWXVaSmpaaWxBQ2ZHcTFZMnN0dTlJ?=
 =?utf-8?B?RnhoT1JocjhIa1hjaThLSE5FRkFnczBZRk9JeDU5NHN5dW9GcDMvOVNyQTl6?=
 =?utf-8?B?UWQ0bFNabWlRNjgvNHBZVTR3WktqUHZJeFJkS2FWeEY3aU9kN2duVVFrbXNt?=
 =?utf-8?B?MngxRHU1RVNQNFNQVWsvMnpWSzdvQ0RjRjM3bmc1akY2ZTB3Mys0N05KKzdR?=
 =?utf-8?B?MnQrNjIwZVZHT2hKQ0NpY25ORDN5Zit4NmpNSFpidnZUMmVoS0FQdE9scnZV?=
 =?utf-8?B?Szc0MmdOSHFFWnRKcVZBQmh0OVk4ejFWSVJkVGdJbUNZWC9BQUN2T2VETm9t?=
 =?utf-8?B?dmk5eTZ4WS9yVDJzTzFVaFBqeDk3YXJuNDVzdmFBaXp3Y1FFT3dtNnh1dzNT?=
 =?utf-8?B?Z3ZrV1psc09wZjdNSm9pbjJDelUxb2VPTVkyRzBLVGhQdGtHV3NUcDhjTG1q?=
 =?utf-8?B?d0puNVcwL2x0UGlsTVZWWXBTU1lEbnFSbXB2a01Ob1RTVCtJWTc5ZUpadWo0?=
 =?utf-8?B?NktoWEFpUDJQQTJnZVhRT1VvQmlpcXN0NEFOdU9UR0pIcTZMUFVYMkhqcVho?=
 =?utf-8?B?Sng0aXNGcDR0Mm0zdlhDSFZuUmRvcXpSTWovZnIyTDNzVkFKSGFEYTVnRFo4?=
 =?utf-8?B?VjFQQ3VydVpOS1J0SXVzTlV5RmtUYzJMZ3pwSmRKRFM2NlQzejBCK0pVMWFm?=
 =?utf-8?B?SXVSTVV6WE9UWnI5ajBQVFVka2ZROGN6WVU0OHF4UHdzWU9SWDlmRGZZSDh1?=
 =?utf-8?B?citJZFg3RmMxTExldGtreEcvek1wbUx5NnFjVVdaU1ZiTlkwb1Z0NFBCcDY5?=
 =?utf-8?B?bDZlVm5QK0ZSdEpHSXZIa29VRElWcHhUbEhwOVk3UWZlVVB6elQvU3U1Uy81?=
 =?utf-8?B?aS90cUw3TkNra3IybWVQK0tYY1krNXUvNDhqckdOVjhJNlB6RzduNGxpZ0Rs?=
 =?utf-8?B?REt5ekt2OG9VS3FoZkdwVWN0R1Y5M3kzclJnOU00bW96L2t6YjZWMTF0MTNu?=
 =?utf-8?B?b0ZqdVJ5a1ZUV3BIYVhFQUkrKzIwajdaTUx4eXgzU21id0ZuemZHcEVTMTNE?=
 =?utf-8?B?d29yODk3ZDNJQXJobSsvbFBJaStSeUdHMndaRm12bVZmNWdkUDJxdFFXME0w?=
 =?utf-8?B?RnpzMC9iRjBUTnV4T1k3NnczWkNuS3ZXQWhEV2paVVhOall6V1hZeXhWTmRr?=
 =?utf-8?B?cDdacXRxOVJXWGowN1IxQVNDTHEzYlpNYUVhbU5CK1piYjhBeGJBTjdYcUpF?=
 =?utf-8?B?Z0hrUDVvczM1T3RRZ3RqNU4xZ1E3RDRqVUJ3UWNqcTFRdlhUcTNqVjRhdE9J?=
 =?utf-8?B?TjByN0pPOW03MkNOR0Q1Mi9ycXVyUDl5MEUycGNidHhhQnVPNWFoUHZmZ2JW?=
 =?utf-8?B?YmZIcS9TdDJ3ZGVGbnVkd1hZN1BBOW9jVCtURXBhZUdRRWpqK1hRdWRQcW5i?=
 =?utf-8?B?Z2RhcklsdkxJKy9POEp0OWN4K3hTcXM3SWE2VTdITzFzajcrdFFlTzA2NlRM?=
 =?utf-8?B?NGk2Y3lkcGdQaTgycUVMTmk1YTFvZVZlODRyQjI3Z3pncmg1aWVOREFIYVFK?=
 =?utf-8?B?bEpjV2RjQm9qTmRraWg5L2lBRWhkdzg2ZGFMVnpTcVMzN2grT0ZmeGVJVk5h?=
 =?utf-8?B?YlVKZXhoWnp0U2JPWmYybEx4TmsweFhTajFGMlMwM2lIZER5dy9KczNjTVlR?=
 =?utf-8?B?eXJ4Ukg4dktOeldhSHZSckROYzdwck5YOS9vYmUrSG4zcXdrMEc0cFBjRG11?=
 =?utf-8?B?LzNJNWM2MXpURDNURlhJTVZwSW5OS2c4c25PRy90WDdvZXhyZ3RBU0lXZHFP?=
 =?utf-8?B?OWtWVUFNdWY3WURpMmhjNXlPSGRPQ3RsazlRdXlmdUY4b2N0bmRUWTBkVUFo?=
 =?utf-8?B?UXFaL0FkdXRKY2xrL3RTc09sa011ZmhLVG9pN3pudGNnZjd5SXZ4emdYa0Er?=
 =?utf-8?B?bE1Kb0xoc0ZSbG5QVHlWYmhXL0JDbXlNLzNYRUNiY29EbUZNU09xRTlhV2ox?=
 =?utf-8?B?U3NoejRYUVYvNStPZWI3RzdlaHF0ZEFGSXBvaUJUYUFoOENRTFB5dW5IMnlF?=
 =?utf-8?B?cWIvdm9qM2ZsNG1McmtyelVIaWZVRjJFaTZBbmM0c1RLY3NNZ1FZRnc1UW5o?=
 =?utf-8?B?ckxoYmRJM0Mvbm1nWitOOG9NR0gzMUI0NHFzdi80bk9RVERHbGp4V1BMWlg4?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B2DB558CBD4AB4A802DA3E840E7D81E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c14cc2e6-15b9-4d2b-e5bf-08dbfca49c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 13:00:12.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynj/X6FCyDpZflc7dH1GIMLn1VTBRl8oVxYyGxEZ/TmxIK6SkVu9B5IFtsqy0Ws3Q7X94gzzJWP7+14BsRIFz5TIltDMTBbiCFGsVNKShi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE0LzEyLzIwMjMgw6AgMTM6NDgsIEdlb3JnZSBTdGFyayBhIMOpY3JpdMKgOg0KPiBb
Vm91cyBuZSByZWNldmV6IHBhcyBzb3V2ZW50IGRlIGNvdXJyaWVycyBkZSBnbnN0YXJrQHNhbHV0
ZWRldmljZXMuY29tLiANCj4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQg
w6AgDQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+
IA0KPiBIZWxsbyBDaHJpc3RvcGhlDQo+IA0KPiBPbiAxMi8xNC8yMyAxMzowNiwgQ2hyaXN0b3Bo
ZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPiAuLi4NCj4+DQo+PiBTbyB5b3UgYWJhbmRvbm5lZCB0
aGUgaWRlYSBvZiB1c2luZyBtdXRleC5oID8NCj4gDQo+IEknbSBub3QgdGhlIG9uZSB3aG8gbWFr
ZSBhIGNob2ljZSBoZXJlLiBUaGUgcGF0Y2ggWzFdIHlvdSdyZSB0YWxraW5nDQo+IGFib3V0IHdh
cyBzZWVuIGJ5IGV2ZXJ5b25lIGJ1dCBpdCBzZWVtcyBsaWtlIG5vIG9uZSBoYWQgc2hvd24gaW50
ZXJlc3QuDQo+IEZvciBtZSBwZXJzb25hbGx5IGFwcHJvYWNoIHdpdGggI2RlZmluZSBtdXRleF9k
ZXN0cm95IGlzIG5vdCB2ZXJ5IHVzdWFsDQo+IGJ1dCBpZiBldmVuIHNsaWdodCBtaXhpbmcgZGV2
aWNlIHdpdGggbXV0ZXguaCBpcyB1bmFjY2VwdGFibGUgd2hhdCBlbHNlDQo+IGNhbiB3ZSBkbz8g
QXZvaWRpbmcgdGhlIG5lZWQgdG8gYWxsb2NhdGUgZGV2bSBzbG90IGZvciBlbXB0eQ0KPiBtdXRl
eF9kZXN0cm95IGlzIG1vcmUgaW1wb3J0YW50Lg0KPiANCg0KV2h5IHdvdWxkIGEgZm9yd2FyZCBk
ZWNsYXJhdGlvbiBvZiBzdHJ1Y3QgZGV2aWNlIGluIG11dGV4LmggYmUgDQp1bmFjY2VwdGFibGUg
d2hlbiBpdCBpcyBkb25lIGluIHNvIG1hbnkgaGVhZGVycyA/DQoNCiQgZ2l0IGdyZXAgInN0cnVj
dCBkZXZpY2U7IiBpbmNsdWRlLyB8IHdjIC1sDQoxNjQNCg0KDQoNCj4gU2hvdWxkIEkgbWFrZSBz
ZXJpZXMgIzQgd2l0aCB0aGUgcGF0Y2ggWzFdIHRvIGdpdmUgaXQgYSBsYXN0IGNoYW5jZT8NCg0K
WWVzLCBsZXRzIGdpdmUgaXQgYSB0cnkNCg0KPiANCj4gWzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMzc3ZTQ0MzctNzA1MS00ZDg4LWFlNjgtMTQ2MGJjZDY5MmUxQHJlZGhhdC5j
b20vVC8jbTNmNmRmMzBmZmNjYWNjYjFkZjQ2NjlhMzI3ZjM0OTE2NGY1NzI5MzENCj4gDQoNCkNo
cmlzdG9waGUNCg==
