Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A379C7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjILHSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjILHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:18:09 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2079.outbound.protection.outlook.com [40.107.12.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68615B9;
        Tue, 12 Sep 2023 00:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXKG4ris8SkRObydfDR8WeFRgyETlELbCsbTPCGDdaJxhYhi893khXmG1i7vArgAwVLUBUq1YXLPkw8YBGonCa1XREbYIzE3xQnSaDVG8W3WhADd6xrnrJGEXaoqdnajOAhl6h5/qIFi8j5Qyrkj/39dM1StHMGHhcPbqazYpCOn8Qw2DO6bwL9lldB2ieifksnpvzPsU8FspVOt8aygk5Vnv2npPqbhn1q0uhNRFpSxTyXIYSQxtDZ0xLDj+Q6rEHDEIrNUse0p8hqdpc1Xvm3TsaUJ2l/LbcAp5fknCO3sXlebF03mOcHxIgR8VSTUx5NNsHQCnbXWaj94yVhG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRyrdulwq6leM6h9GEz2xnVNRE7vdbLaRtNaota86Og=;
 b=K9oCpqlfmzhxZ2WU+TGBOwaZKvyY5ewGeh8S876SVqX5VnIGq8F8sIRQ74qmypNDuAuPwgCpW0yMRh7/IddacJp6yosnhptTJzM1aJ9Omb7nf+bsIMyAfPD6+YujFjYwZ5gvr+qF+Wwm5vwo30QKaooKel5uIUAuvOEJlIik7x+eVsVWHurvSe003Rl8sIgD3JLk3ywBmPMhTUqOuZIlPwh6htk92yAvjCZfBECW2/hxsuPNTF254c27HGU+aKwz7bUyi2CHvCPJBV1Dny4H+jH8CDm2Kfv3XgrHfAyGAPEVFqtpReUZkfxD9c5Czl5kfPGbeCoMrUji2BrWghv2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRyrdulwq6leM6h9GEz2xnVNRE7vdbLaRtNaota86Og=;
 b=FbBY9fy+2oICSTUtoJlkhfch0DYL8F8aGgaZBoSUO4SZEJDT/v4sJjKSTvGNOdiBunNtVBeNdk9hrZ/Qpky8hdiK5AI5D9WZCh0ZlMQ/U2KCbBnPHvzb0ujaKXhouJgcbmU9Lr7XaZmNGVgfny1cIcWiSB3WmLfjXts7LgGhLUlBSbIuGOKUZNaKJ+yLayE9cGVCoK38d+KyTVOCvKi8dLy+sUxTKQ+ZLKcvGSzHfcZ69wLwAdf6v+Y+lqoasoHiKRFY8+92t9Bv6jwkZXJEc6dD53ZqyCayXGpsc2MSYFQ4ZY6ceToH6q4QAtD/xq+EO5JadSGWjUF2VovF7G/www==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2037.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 07:18:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 07:18:01 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 11 [drivers/tty/serial/cpm_uart.ko]
Thread-Topic: linux-next: Tree for Sep 11 [drivers/tty/serial/cpm_uart.ko]
Thread-Index: AQHZ5PN+V1tr74rPaUiOWAPSpV7qirAWyJ2A
Date:   Tue, 12 Sep 2023 07:18:01 +0000
Message-ID: <89194056-cd44-82ec-c39b-393b2a93ee9d@csgroup.eu>
References: <20230911121131.006d3fec@canb.auug.org.au>
 <22d044d8-581f-0694-f7e1-b6caf11de089@infradead.org>
In-Reply-To: <22d044d8-581f-0694-f7e1-b6caf11de089@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2037:EE_
x-ms-office365-filtering-correlation-id: a4234547-3d0c-4877-31a3-08dbb3606617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4XyD8XXUfLUJMSCmg1zyP7EChp8SswQkmrx+4mL7Sak+jF/KzvgSqu/FEF15alxGf65x/jrMLAQhXa0D45um4JdqUi+3I/7z7ge6ANUTc+dCNgXR7PnbN1m9j1kxUfjPf7AYfUQxy0sNnjzoMizbp7Wz2utKGr5VUNwnLnYrGSwht7Ua8Mvt6Uh+a3oIH3RP3AncmI4gxh91RHwyKNLrKlIxyCSKNjyacwfpi3LPn/WQcBIzRI0C7Wzle19u18yiZVc9Ws6CI2OGb3D7tiPy9CrqN0zO7Tv/OkW2o3ta9ztlC7YPZIOCG2LBKe+GC6SnyKpQ4MknuRGBWvX7RCh4cBu7EyXvhlvf2e0BD+GQWmp4eDuRCENPoPnBpDct/5Qur4q9sIzq64F7hjRkjPwH3qtnkuNIVPHr67bKpb711eDkqdPMdUQ/42bfD3FpJTVWKE53LccUvVoxGAbNr962rcs0bCPtkhnX2CL/6xyjEsK7naguUZcvaJ5yFRZ4WkX2qH+UjGWxVM2MK3zkiGjTX6WBwjRrpnuxz05jCk19vZlPReW9ewe9GKAT7UbK6h1tSEO4zuJbrALwFyuaF22jZ4393HfX4AMt6s+mUFWDI3Cj7azTire3m6yOzlNq3lN15BPh8O9NaN1cUqVtEfAeeb0TY8ayXUoQFiRQf4+nZMrkMy/6/GcocIH5R+wGgqC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(186009)(451199024)(1800799009)(6512007)(31686004)(5660300002)(71200400001)(53546011)(6506007)(6486002)(26005)(4744005)(478600001)(2906002)(2616005)(83380400001)(44832011)(4326008)(8936002)(66946007)(8676002)(41300700001)(76116006)(122000001)(38100700002)(110136005)(91956017)(36756003)(64756008)(66446008)(54906003)(66476007)(316002)(38070700005)(31696002)(86362001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUUrbkdMUi9tekhWL09adVlZMnljdkdWOUM5Z2NZK0JQQUMvTGRKaGtZZmJB?=
 =?utf-8?B?L3RsWEo3aWtnTFhRU1k5cWZwbXFOb2RhbHFuSXhZekRKSHlqcm1RWk9CZEdS?=
 =?utf-8?B?bytxN2pVcVhTYmR0ZUNMMXZpOVhZaWMzWi8rL1FUT2NtU1JERWpmd0NtdG5z?=
 =?utf-8?B?TU5DL0wrNnJkT1pCRUo3MWdXRmNqZ1N2N0VhUjc0amdxVlViUFIrR0pvcW1p?=
 =?utf-8?B?VEd6N2FIVDBBUGU5ZVlZM3JwZXkxMnJzVnBxVTNpQzJ3SngzbWw4UFh2NjZa?=
 =?utf-8?B?YW9JRmlqaVh1MGp3T1JvdzJZbUtaem1jVU9SU2hWWGpoVm9TR2gyaTlWV2lI?=
 =?utf-8?B?Smk1elI1M3dJYlN5MUJLWHpzK0QzS29ZVFRvVE11VWpyRStESVdTM3BZOE9C?=
 =?utf-8?B?L0c2azZRNzhLVk1KaHFkOWVSVEJ2U211VER3V1FCSkhjM0ZDdFo0dmFrUmtL?=
 =?utf-8?B?QXpCdGo2ZjNhZkFqT1VSTHRSeEtpN0xVVXNwRlh5cldjWTRMNkJUWUVGc3o4?=
 =?utf-8?B?elhpS0lHOGVSbEN1QnFZcWJKUWloMmpNcytFWGNkV3o1a0p0QnBTdEZsOGUv?=
 =?utf-8?B?SDlTcFVZSVRubjlGT0NaU3RyWThQKzlnbjVyYzhaYXM3L0RXblpuMlZwRi9j?=
 =?utf-8?B?dFZnWWpUblFlQlIxWWxuQ1R6K3RxaCtIVk0rMHF3Qkx6UVZQM2ROMGJNY01l?=
 =?utf-8?B?ZEE2Y0ExNHhZOGc5Q0F1Rk1FeHJGeWExUjdLNU05dHJuUjFCaGkvMitpUFU3?=
 =?utf-8?B?aUJYV1JKR1d6eUJDQ1NoZitZY3pzR2FPMk9qWnVnQ2tIYWJOUk9ZRlFiMk1x?=
 =?utf-8?B?eUtyVGliMnJyZHVIaWl1RERwSUpaZGtVVHVJM1hEM1dZSGhaVEZrL1loUlow?=
 =?utf-8?B?RHJqcWJsL0RDNFUwSWJKUzE0ZG9UaTdLVjc1NllmSnQ4UWlRSjhTM0xGT2Ny?=
 =?utf-8?B?NCtCWWkwZkNWaXh0NlBNRVdxUytUQlg0Tm1FKzVVcy9EeGJXUExqcnhjOHBX?=
 =?utf-8?B?bit0ZFFlOGJDRUtCc3IyWWxwK2VTaUcwOUlBVENNT3FMYmRPaGJsUTRsajVv?=
 =?utf-8?B?RHNGYWdGeXRpZzcvamtuZm5xU0s2QmJoUmw4bi9kWllZNXE5b1cwVzNUZ21T?=
 =?utf-8?B?ZU1rNHg5cExyTUxlUFhGTEJwNWdURUJWZVBocWJ2UTJIQ0VUNmJVYXdEVGdq?=
 =?utf-8?B?dlBRdGVycGdZTitiZEZCUVFqby83dDBpZGFUTHJtOGNFMjVRVmJFS1ZlQyta?=
 =?utf-8?B?VElTdmkveCt0NitqY2RLaTUxdFc1YjB3MFkxSGkyb2x2MmFMNmNkWm5WdkV0?=
 =?utf-8?B?K0wwV2pOdTBJMzZCUW1PaW5yajllWDdCTlJRNnZQbjZJQkJMSWRKWEpSaTht?=
 =?utf-8?B?NmZ1UW5WdmxWT0FuZ3RpQldTVXIwN2NpK2tFNDJxZ1lvNVU1Rkp0N0NHS0Zw?=
 =?utf-8?B?THY5MG5wSjArSTNRREtPQSttc0MySDJ1R3RFYnJuNVZQbElKV1NwakNOZmFz?=
 =?utf-8?B?N1JhT0tIaWVFeVJxWFNOUWJMN0RsRFRVaFJCNU9USWVvWlhRQS9iNWtUdUVT?=
 =?utf-8?B?MldQREc2TmNGNm9XU21qdnNsZWhySlVKMlBHYW8vTCtlcFFUNUhnaFlnbHc5?=
 =?utf-8?B?SC9uYkpzMzF0UThDOVZUVW9aT2hCa1VmMk5yVStRQ1kyM2lJTHBNRTFTL2tM?=
 =?utf-8?B?V29SMkJ3VzYrSThaSHB6QXpGOFNuUnIzQko5Njh4Sm8yVmZvemM1V0hINHlM?=
 =?utf-8?B?NEhDc0ZDVVg2RCtBajBCVzNJcVMrMld1Qkp5Qm9XTUlEenI3WHJDbG1Pa05K?=
 =?utf-8?B?WnExZzZqYlBBVlBURGZEejdRMkhXTlduNzMzMW9JeURoRjl2NmViSGVXR1F2?=
 =?utf-8?B?bUwrdUV0ZGVsV0R0c2ZGaEFlSkdGb0piQmVGT3dQM1BKVFdSNHZHakxPQnFE?=
 =?utf-8?B?NlFjRENFdXAvQkorcHVyQndOeVRBdU5oQUFEQTE4S2tRb3F3QlpjOWlMTkpN?=
 =?utf-8?B?ZmtXTnlNbm4vOU43clhPQmw2Yk5QbWM1OEt4Z09JU3EzSEN5SmRJQnVvNGZu?=
 =?utf-8?B?UEU1MXEzT0wwd0FieDR1dzlvRmlJb3Q0eldFWHhQYy9iTlAwVFEyVzZPUmxh?=
 =?utf-8?Q?BNMaRYXOWnVOzRv3k13UrjPQn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72F06FD2911F184CB4DD67180CA6EB6C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a4234547-3d0c-4877-31a3-08dbb3606617
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 07:18:01.4043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBrQP/TEwYPeKDXsCgDpR9HyAaPf6mj11przQ98zeAnKTgiaQgY5fmiZGE6r+jtOCT3imWRSWKDtQ+w9dWJA9TQta4D6Ex9gFiyOcr5g5cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDExLzA5LzIwMjMgw6AgMjM6MDMsIFJhbmR5IER1bmxhcCBhIMOpY3JpdMKgOg0KPiAN
Cj4gDQo+IE9uIDkvMTAvMjMgMTk6MTEsIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+PiBIaSBh
bGwsDQo+Pg0KPj4gUGxlYXNlIGRvICpub3QqIGluY2x1ZGUgbWF0ZXJpYWwgZGVzdGluZWQgZm9y
IHY2LjcgaW4geW91ciBsaW51eC1uZXh0DQo+PiBpbmNsdWRlZCBicmFuY2hlcyB1bnRpbCAqYWZ0
ZXIqIHY2LjYtcmMxIGhhcyBiZWVuIHJlbGVhc2VkLiAgQWxzbywNCj4+IGRvICpub3QqIHJlYmFz
ZSB5b3VyIGxpbnUtbmV4dCBpbmNsdWRlZCBicmFuY2hlcyBvbnRvIHY2LjUuDQo+Pg0KPj4gQ2hh
bmdlcyBzaW5jZSAyMDIzMDkwODoNCj4+DQo+PiBOb24tbWVyZ2UgY29tbWl0cyAocmVsYXRpdmUg
dG8gTGludXMnIHRyZWUpOiA2NDMNCj4+ICAgNjE0IGZpbGVzIGNoYW5nZWQsIDIyNzk5MCBpbnNl
cnRpb25zKCspLCA5NTAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gDQo+IG9uIHBwYzMyOg0KPiANCj4gRVJST1I6IG1vZHBvc3Q6ICJnZXRfYnJnZnJlcSIgW2Ry
aXZlcnMvdHR5L3NlcmlhbC9jcG1fdWFydC5rb10gdW5kZWZpbmVkIQ0KPiANCj4gDQo+IEZ1bGwg
cmFuZGNvbmZpZyBmaWxlIGlzIGF0dGFjaGVkLg0KPiANCj4gDQoNCkJpc2VjdGVkIHRvIGViNWFh
MjEzNzI3NSAoInBvd2VycGMvODJ4eDogUmVtb3ZlIENPTkZJR184MjYwIGFuZCANCkNPTkZJR184
MjcyIikNCg0KU2VlbXMgbGlrZSBwcmV2aW91c2x5IEZTTF9TT0Mgd2FzIGFsd2F5cyBzZWxlY3Rl
ZCB0b2dldGhlciB3aXRoIENQTTIuIA0KQWZ0ZXIgdGhlIG1lbnRpb25lZCBjb21taXQgaXQgbG9v
a3MgbGlrZSBpdCBpcyBub3cgcG9zc2libGUgdG8gc2VsZWN0IA0KQ1BNMiBtYW51YWxseSB3aXRo
b3V0IEZTTF9TT0MuDQoNCkknbGwgdHJ5IHRvIGZpbmQgYSB3YXkgdG8gZml4IHRoYXQuDQoNCkNo
cmlzdG9waGUNCg==
