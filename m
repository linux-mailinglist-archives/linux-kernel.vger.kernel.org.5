Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DC7C6860
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjJLIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjJLIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:39:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2114.outbound.protection.outlook.com [40.107.114.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EABCA9;
        Thu, 12 Oct 2023 01:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXw0X9n/cPqoNt0/ujAxkzSF4XQyxLuhQxy6cxtbBUg92gsqNlG5/fZSIkrYNqiHWe3YpEHQC3NMOaJBL36/LwtlVRAeOc6sdynqMKvbnD76kT8OhtUl+KZp3/j+iKJSRmFFTOpG6icUkEyTv9LEuf89wIdeNtZ2FDMn/eMGrAI2BXCWflx3/r08R8Oq1rdzEEBIdor1D+fywqDa1cII+NAPp1cSSMUGmLPXD7hcBwMeafpkBqe/YH3IYQp/dKdJXrtstlD4+qwkC6AKB8LRM55Gxx+TemFYOPeLuXa8vbkfan9YJfOI9lXadfkWPT0cblOR4HFBsWKjvMN6PLkhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/nfe+DA5RnBlEgcBgykJlfr7/LxRThRz5nRJROTndk=;
 b=ELXF2Yf+6E0c7qGJpEtdN9J8EiEyGH2rwM9Wwb9oq85PcgitnzMuVtbTODjtQd4jsTkIwy6wI44xV64wHD5gC/h56eyD3pvRKQjGHptUkG+qE50bdm2EbTV/Z+h+28SSlcL24Sy9wLXV6Wlr82yhm2sNzZ2aorj/gG6EJQj8IRetDHBs5KNr8XLlN4AyInibrW5Oh8dbdxxSk8ZGf+7GJ6ImNrnQ+lB7G3z7Dc7XS3egijV4xtQ350fyxn/JEs+az5ru6NN2vQjm+3QMiiR6bkpWcLgwfMMxilpElUhVtwcJXOgm+QyN7ZaPK1RO8s91AjPyU1E/JDJCDmoc+WiZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/nfe+DA5RnBlEgcBgykJlfr7/LxRThRz5nRJROTndk=;
 b=YIfYt8O5hq01MBHBfo8Z1SDRK9Nf5YoOqHTP8KTLj+dw8qz0TnYSzI08LwsPotEb4y01ekRoE/77FUJS1gCreu5oXvE2LKmnWGNyD7ICTGR8825EKEUqH1cV5LXuMitEL4JwQl9xH3MiR8vuOGBlQ5Q/xLu6sEZ4FUFVPqftDQI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB8376.jpnprd01.prod.outlook.com
 (2603:1096:400:150::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:39:41 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 08:39:41 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>
CC:     "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "lee@kernel.org" <lee@kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>
Subject: RE: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Topic: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Index: AQHZvqRVuDoCAQ7YqEiPPoP/ALhCca/LYswAgHgTDgCAAtT3EA==
Date:   Thu, 12 Oct 2023 08:39:41 +0000
Message-ID: <TYBPR01MB5341D3791E728E3D9EFC25D4D8D3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <de4ab49b-f1a7-5732-0970-13fd03407376@de.bosch.com>
In-Reply-To: <de4ab49b-f1a7-5732-0970-13fd03407376@de.bosch.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB8376:EE_
x-ms-office365-filtering-correlation-id: 79a15296-a722-4c71-8a17-08dbcafec6e6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HM9FjXk6OfeSLWPh4JNfUAF3C5TYSdbHMvLnVOEPG4nLcQ4JDNO4blnpK6XUQIZlZHlvpFnwcszxSfZCUWLFzC9x9QGprG8aNXxeUzXnIjHzvbM39R/bF8KTOl70idtcz8hcPRq4JGZIC50dLsjBbHE4BC2H4eRXsHY0c/yYT3uipCmspkKvGzcaTbVbQ4/HeAEK+1rsaJyxzv/GlMyMeBbOwCubPhjPdNanSWoeQoFhy0wyxLeEqjJaTgZnxxjsAAf9lCeAOxEuahFGvXiHcFs/GCUiBLVROpbiyStTUYV1EKnqjHDumjNbCtqVZN3+IRFgNkvYI2XjX6FsBomR+CzDc+FnD/jYN+8gI83mdT07GWyEZWB91WzcOCMHMnMnKZaKHb8JNJG+VYPDh9FKIiraXICVHa6xveLY9LC0ola6Ebm+C0kvGM+y3ewDG2VI1PiYEofMqN5A4VLiJ+FW6mvwTunwtf7wAIBlzoiKJ+qJLhITFd7OhebDiDxcgejt58Ysk9K1PVm32E+eyMtHnGhtq/1WdHcJt5bd7j6HGo97I1GwD8VoyhvLHC/kN/xUn6J3ipBQGBlyCH/uXjnqjwaccw5FAkyRU/tsdwjDfR4qQXMUx0gANcLo7m3JON5SeU++GBOSQWSwVLJMJf7CCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(33656002)(55016003)(53546011)(83380400001)(107886003)(38070700005)(6862004)(8676002)(8936002)(4326008)(7696005)(6506007)(9686003)(71200400001)(45080400002)(122000001)(966005)(478600001)(41300700001)(316002)(7416002)(2906002)(86362001)(5660300002)(52536014)(66946007)(66476007)(38100700002)(66556008)(54906003)(64756008)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGkveWlRZmVQQ2JTUko0L3ZVNHIwNXBBd3FMaUgvWmt5Z2xCbnhCekU2NXZ3?=
 =?utf-8?B?TmRXOG5JbDVaeG5SalFUcGlPYVo1VW0weElGNXVoMXdlT1c5TVlJYUEyQjFK?=
 =?utf-8?B?MkV6RnhIaWl2SUhtOFYyUUovckttc1o5ZFg1WHlOZVpFdkoxUk9saWt3cFFm?=
 =?utf-8?B?VjZiamhsMUN5ZmlocU9zSnRzdFRKRHo4dlJ5MGg0QjgvMTJmQnJkeG9MUm9a?=
 =?utf-8?B?Tmg1RFBxbEVFUDR2aUFOeFFOZ0dZL2JsNW1CMkdlZHNtUyt5VXA0NUd4RlZY?=
 =?utf-8?B?dEtYNjgzeFg4MVZSaHhrUUk0eXlQOGZIZjlXWTk2VWZuTTJzc1ZkejR5N3Bx?=
 =?utf-8?B?OWI1RUVrZzhJT3JvVGU5YkxLQVVWR0NOSGlIeXlhQTQzMklncVQ4dFVuYmYv?=
 =?utf-8?B?TTNyd3BZcHdvamNtaUl1TkhycGEvSHhHOEZpV2FUemNiK3FXRjI3bG9HZEJF?=
 =?utf-8?B?Slc4OVFwVVRvQlg3cUZoTjhHODlOL2VtZjZqaEkweXcwRWhoajVZMG5FVlBy?=
 =?utf-8?B?MXY4MTVlWkNNSDZXZ1pxU0FGNlF2cFRheVZod0g5N05RSlM2MHA3VDh0cUJS?=
 =?utf-8?B?NjJWczNBc0pXYzB2RGlmb1c3M21zZXd2R3FSWUJVUEFxcWRqeDZnSUVIblZR?=
 =?utf-8?B?anl4QTM2L3c0MWtiQklQWGs5dDI0K1dlUmZBQ3BaMW90azMwUzQraXQ2cHNs?=
 =?utf-8?B?U3VWcFhZSWZVMmU1cWJYZjdDSklNK01IbWlMZGt1VGdrSXJsMWZ4ZTlnQ216?=
 =?utf-8?B?UFFhcFJxMlJ0ejQ5OWdBUjV2b29TWXJabUwzYnl4bDA2UkhpdWlRdTNPTllG?=
 =?utf-8?B?QzJ4bVp6UlpESnI1dEZlY2xvd0RydjA3d1d5RGVwMFpWdzhwWjhJRDdnYVls?=
 =?utf-8?B?L2FGYk0vTklNRXIrZnFjdFdSTFRtKzczVjBnM1hnUmtsSEljdS8xV1k0ZzRQ?=
 =?utf-8?B?b1FmakNZK3MwbmV4d2lTcDFLZ084VDFGbGU5OFF2Qmh4ZURQZThJdWozMDk3?=
 =?utf-8?B?RkFURmRib2xseXJWTW1CaEpJYzJmSVNrU0g3aWUzZUk0WlJ3aXJ3V0ZEOGRy?=
 =?utf-8?B?RzdKaUZCcXFnWVhvMmtZQmRXUUNYYkxKM3NCS2JCczliSWlyV1hVYk1mV25H?=
 =?utf-8?B?cHcyckoyUHJkaGJCMmtFM0c0QzRsY3Y0aWMvaWFqQUFjQmNXUnV3TW5qU3V1?=
 =?utf-8?B?ck9CbEhtUTRPUHlVWk5QaElsTDk2Tlo0VFdTM1J4akNrcEh5dzFIL3pkbTJn?=
 =?utf-8?B?d3ZKNEhoRjg0VVE3Q2RmVTVoU3M5NG5ZVTVQMDQ3K1crVGZhQkV4TG1tK2gv?=
 =?utf-8?B?Y09YNWJXU3lVZGJZcEdnbC8wN1E0UW5PNEtRMEJVZHZxZXBybk4wZVFSMVFK?=
 =?utf-8?B?OU55ZXNndmFZL1Izb3hjSFFzYW5GeU5OaG5SUlNUK1QwNTNXcDNFaThpYndh?=
 =?utf-8?B?TzRjdXBvQkllTmtMMGw2ZWYwZ0xHdHVSWURrVkhGeXo4bGNTRDViQ2JkNWxS?=
 =?utf-8?B?VnRVL3E1cno1K0lFVU94dHlyL3MzR1NRaDJJRTNOaHgrWHdMMjlMSjdrYXpR?=
 =?utf-8?B?VlRoMFM2ZjlDcXpzcmg2cFlWcFRoQXpSR1ZnTDY0UEZKYjFGTDVyYlc2VnRr?=
 =?utf-8?B?ODF3eDhNZXNvT3JWZ0ZNQy9USGQwUE0yZGh6WkJVeDFwc1FLaXF3bm9YQUth?=
 =?utf-8?B?cEorMHEzSlpDZ2hFTDZEUTZEeGZZbU9zeUg5cHFac0hLQkk4aXpRMlRkeDVX?=
 =?utf-8?B?UzRVM2w3UDFnd01raHlQaGVXOGhvSFh0RUhjL0dIRVphd3R5NFM2VktZYmFO?=
 =?utf-8?B?Ym5YNk9QTzJYN0ZCUHdnNXFmNkNEaW9rNzZRdWM2UnpIa1BXOG1VNHJJUTBo?=
 =?utf-8?B?WnRDamE2c0hOeWZHbnB4Vlpuenl5UEJwUVlMMXFxWHU2VFp4KzVpWlRnR3NS?=
 =?utf-8?B?Uit2bmViU2RhdDYxWXFtYVJRcFNpa1hUWk9mc25jYXFNQlVZZG9yZlo5S2hT?=
 =?utf-8?B?dy9jcktqY2oyUk1JSGxjSFAxVTJJV2wvQ2FxRmpOaFlIVHBZVUVyOUhkMmNH?=
 =?utf-8?B?MXl5VFUzMS81ek5zNEdseE1kWHZJZldFVmFGaDVkNmN6Q09ZdlA5UHRxTGpk?=
 =?utf-8?B?Rno5MmdDZUdYTTBmdUVWQzVvUHVDV1MwVVN2M2dIRDdOcHBsV3dsRGNWWHlR?=
 =?utf-8?B?T2diVUh6ZnlvSG5uQjg5dTNnaE96RXZ2YUFnTG5yUitZTHdwUUs0TlU5anhY?=
 =?utf-8?B?NEdGMnBMVHJ1U1FZOEtUam0rUUdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a15296-a722-4c71-8a17-08dbcafec6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 08:39:41.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSMxKFwG/s3DZQ0xeDG7Uvwh9I12aeu7NGuGY3LAn4sv7cCPmt9KSFASynY2qG9EgS8bsQVx6pyb3c/t5PIhXaXA3JbJCTy5EAc1Tc8Fk+L/7SpI6djmKrCrYjy2yoVt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQmVobWUsDQoNCj4gRnJvbTogQmVobWUgRGlyayAoQ00vRVNPMiksIFNlbnQ6IFR1ZXNk
YXksIE9jdG9iZXIgMTAsIDIwMjMgOTo1OSBQTQ0KPiANCj4gT24gMjYuMDcuMjAyMyAwNToxOSwg
SmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IC4uLg0KPiA+IFRoZSBmYWN0IHRoYXQgcmF2Yl90eF90
aW1lb3V0X3dvcmsgZG9lc24ndCB0YWtlIGFueSBsb2NrcyBzZWVtcyBtdWNoDQo+ID4gbW9yZSBz
dXNwaWNpb3VzLg0KPiBEb2VzIGFueWJvZHkgcGxhbiB0byBsb29rIGludG8gdGhpcywgdG9vPw0K
DQpJIGJlbGlldmUgbXkgZml4ZWQgcGF0Y2ggWzFdIHJlc29sdmVkIHRoaXMgaXNzdWUgdG9vLiBM
ZXQgbWUgZXhwbGFpbiBpdCBpbiBkZXRhaWwgYmVsb3cuDQoNCkluIHRoZSB0aHJlYWQsIEpha3Vi
IGFsc28gbWVudGlvbmVkIFsyXSBsaWtlIGJlbG93Og0KLS0tDQpTaW1wbGVzdCBmaXggSSBjYW4g
dGhpbmsgb2YgaXMgdG8gdGFrZSBhIHJlZmVyZW5jZSBvbiB0aGUgbmV0ZGV2IGJlZm9yZQ0Kc2No
ZWR1bGluZyB0aGUgd29yaywgYW5kIHRoZW4gY2hlY2sgaWYgaXQncyBzdGlsbCByZWdpc3RlcmVk
IGluIHRoZSB3b3JrDQppdHNlbGYuIFdyYXAgdGhlIHRpbWVvdXQgd29yayBpbiBydG5sX2xvY2so
KSB0byBhdm9pZCBhbnkgcmFjZXMgdGhlcmUuDQotLS0NCg0KU2VyZ2V5IHN1Z2dlc3RlZCB0byBh
ZGQgY2FuY2VsX3dvcmtfc3luYygpIGludG8gdGhlIHJhdmJfY2xvc2UgKCkgWzNdLg0KQW5kIEkg
aW52ZXN0aWdhdGVkIGNhbGx0cmFjZSwgYW5kIHRoZW4gdGhlIHJhdmJfY2xvc2UoKSBpcyB1bmRl
ciBydG5sX2xvY2soKSBbNF0NCmxpa2UgYmVsb3c6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KcmF2Yl9yZW1v
dmUoKSBjYWxscyB1bnJlZ2lzdGVyX25ldGRldigpLg0KIC0+IHVucmVnaXN0ZXJfbmV0ZGV2KCkg
Y2FsbHMgcnRubF9sb2NrKCkgYW5kIHVucmVnaXN0ZXJfbmV0ZGV2aWNlKCkuDQogLS0+IHVucmVn
aXRlcl9uZXRkZXZpY2VfcXVldWUoKQ0KIC0tLT4gdW5yZWdpdGVyX25ldGRldmljZV9tYW55KCkN
CiAtLS0tPiB1bnJlZ2l0ZXJfbmV0ZGV2aWNlX21hbnlfbm90aWZ5KCkuDQogLS0tLS0+IGRldl9j
bG9zZV9tYW55KCkNCiAtLS0tLS0+IF9fZGV2X2Nsb3NlX21hbnkoKQ0KIC0tLS0tLS0+IG9wcy0+
bmRvX3N0b3AoKQ0KDQpyYXZiX2Nsb3NlKCkgY2FsbHMgcGh5X3N0b3AoKQ0KIC0+IHBoeV9zdGF0
ZV9tYWNoaW5lKCkgd2l0aCBQSFlfSEFMVEVEDQogLS0+IHBoeV9saW5rX2Rvd24oKQ0KIC0tLT4g
cGh5X2xpbmtfY2hhbmdlKCkNCiAtLS0tPiBuZXRpZl9jYXJyaWVyX29mZigpDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KDQpTbywgZHVyaW5nIGNhbmNlbF93b3JrX3N5bmMoKSBpcyB3YWl0aW5nIGZvciBjYW5j
ZWxpbmcgdGhlIHdvcmtxdWV1ZSBpbiByYXZiX2Nsb3NlKCksDQppdCdzIHVuZGVyIHJ0bmxfbG9j
aygpIHNvIHRoYXQgbm8gYWRkaXRpb25hbCBsb2NrcyBhcmUgbmVlZGVkIGluIHJhdmJfdHhfdGlt
ZW91dF93b3JrKCkuDQoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9uZXRkZXYvbmV0LmdpdC9jb21taXQvP2lkPTM5NzE0NDI4NzA3MTNkZTUyNzY4
NDM5ODQxNjk3MGNmMDI1YjRmODkNClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
MjAyMzA3MjcxNjQ4MjAuNDhjOWU2ODVAa2VybmVsLm9yZy8NClszXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9uZXRkZXYvNjA3ZjRmZTQtNWE1OS0zOWRkLTcxYzItMGNmNzY5YjQ4MTg3QG9tcC5y
dS8NCls0XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvT1NZUFIwMU1CNTMzNDFDRkRC
QjQ5QTNCQTQxQTY3NTJDRDhGOUFAT1NZUFIwMU1CNTMzNC5qcG5wcmQwMS5wcm9kLm91dGxvb2su
Y29tLw0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IEJlc3QgcmVnYXJk
cw0KPiANCj4gRGlyaw0K
