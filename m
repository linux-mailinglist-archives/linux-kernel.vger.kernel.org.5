Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4B754CF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 02:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGPA4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 20:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGPA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 20:56:30 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2146.outbound.protection.outlook.com [40.92.62.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212D271E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 17:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv7yziKbqcV/bTmBLaGX2kP5q5HIHR1ZRP226bWgnpAllyiNhOabFk/uAcd2z4o76KcA40ama67h4DlSFgkR7ujmWdRi3sXK9AW1kF5N+rdFbQxpTRoSewBYbHP3tgyzR4jebsRIZnGOhQpjlfHMvCQG1MK+nx6heSQuKeNJTDC5xGH9kVmLjHYaicYMJsEm4OsgcSNQt0QeSn4p3Zv6+EVSicBHlvPupYUOwXlYiTGrsOaeyH7lW9+dT9ZFNXLslo6uC2ry21wYCYOCgy24wRQ/XZLN4HogIX/ksNk2EFtQkgYGYGES5ik7Pit1fFo2E9NHpH7z8OISHw9laNEOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQgmnF4YLd4pqeJa6Veq9Hi3wCr6ouVg7wodCSW+Zss=;
 b=gx67m2IsondvjsIAa8MMLYzPdlhUmjPaom7yZ3GpF3z1IPLU+nAdSr6SHWcKF3hZGLShzv5l4LcRAdZeSD6dssvM3rDyeqdSK5q2nZxKlNIc/AhHcSlI1ESJBYVOfeGKRf78M1Tb7mrjKo5E5c4eBEhURG+t4MDKc+E8dHF4h86Pw9rYRU1IF1cBnT3rp44X39FO7CPY2Z5NB3/NKZxLZKpOlgWEQv3NRIN/ofY6il21h6rpM/U3m1WzeO0yy64EkICJGoqnQZi/sxQrZox/XyuW675in0x56MUjT/W/HIISrukSBxW7XFyoO/wqi8dSkh1UJpcOtmBobfuJNTmrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQgmnF4YLd4pqeJa6Veq9Hi3wCr6ouVg7wodCSW+Zss=;
 b=vTMGfmIZGgR9pfLlP2aYmXW8Rb3j0vnn0ovjXT0VLtMFrkQ1XDk7gF2t9OcW731SvOL8uyIXK7jQq3/ueCpMIsMfxf/EH2eKAIW0c5E3Nbtw5V+bJp68gsOy97iGqYviIFUR2oCFertO5xRt7weBD25a6T8mQ5wxrWlQ+eaIBOyYSkTpWkkaa5jfI0f4laVQjHd06f7izxDd0yLFKRz37m91Mhyjooi5HNcXltpy64gCxM/qPzHugdBkq6GiTYmbqi/Jii0pRL8ueSwgBc7GjyovZhvwLJNbnmdA4JZuixLtar0qVKSfPSAkkxREMaUywXRSxkt1vIbml5vsE6AaMQ==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by MEYP282MB3484.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 00:56:24 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 00:56:23 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>
Subject: Re: [PATCH v3] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH v3] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZs/4mjIR04u33F0GwdCBe+N7JRK+0n1oAgAARHgCAAKVZAIAGQtsA
Date:   Sun, 16 Jul 2023 00:56:23 +0000
Message-ID: <f4646728b497ce886e9b96e6b6ae19826bf6e60d.camel@hotmail.com>
References: <MEYP282MB2597B4BD3CDA1ED340691C9CD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <CAAhV-H56GhqETf=NAGzHRLk73F+-Kb=j+gzNMshVQijPi-Tc=g@mail.gmail.com>
         <3310eb5b3c944434b6e3b53750f1801f510811f2.camel@hotmail.com>
         <CAAhV-H4ZE3eXOaMSaCCH6pk40pwYTOs9QasjLbPRtos5V=fM-w@mail.gmail.com>
In-Reply-To: <CAAhV-H4ZE3eXOaMSaCCH6pk40pwYTOs9QasjLbPRtos5V=fM-w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [sgaxg0ZIdJTd9GiEIzlmxHRVkh5EeE4xHRqdSO4vQXd7O8Q9OA9sQfdu9kADoLQl]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|MEYP282MB3484:EE_
x-ms-office365-filtering-correlation-id: bac9842e-389b-4aee-6edc-08db85977a2e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gV9nD6MPfqczggumJaZJ28I99Z0nyE0Z8Lkni/TURoJ0SzCTfWMjdOWE82LyOWekpQU/DRoEvPPX8urWbRR5EMY2hMd1XfTuOOeMqmvbtrc8GXMgrtSBepK/cjHzDPPXODFRqheD7qi8C2lBRE4gBCPPP8OSVh3W5QHzLMXfm2GYHWqwUfoQURS2lW1mx2aLbVxXiW6dLqCFvrPK1PanQGUKXREZiT9RsqeHS+5w+3eX54zjglD7TJ5Gva4Gvr1fP4jQ43s6MWuxbRHO6rc+rylauTLN0hFPMBtXmorhout7rHtnMUd3b30p3Jbd5qOH2RxknitA438GKTNh0h+XbAS0b06EkPld5gjZWmOhgq9e+SnjZrR2VK+3DqonRSXGvp+48CTd0dN2oGPClCLWaYbVwQyE1ONuq+eOPsqw+ZSqkRi2yfOJWTO7M8SulVXMbKGyAtYCYFC4FricsFj97GMqlNaEN1hNFE+DPJc+PCPFV/w1XASkrlBtT3KP8cdACdyPeLZECq47Qix0U31aOcFWyzIcQ07O5tHYPGkRAl5Qkvrx2XsFCszicBLa6REf
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzcydDRWdEMrNkNOczExUFVRWDRBSFNRRU9kWFlZcE51OVJ2SGdIU0FKdkpn?=
 =?utf-8?B?ZTFKVCtOYitRQnRTbXF3dHNpam1UM1MzeHMweXQ5TTQwdWdMTEMxNXBvTldl?=
 =?utf-8?B?VXJDT3o3SHN6SWNYa2I0RXJMdTF6NXhIOGtEU2ZLNkhwTUFneEl5MW53VVBp?=
 =?utf-8?B?OEI5cXU3cWhoU01DVHNLa2prRW5UaEp4WUpraW1GVFR4bVdybGVYTUQxQUhJ?=
 =?utf-8?B?eW45N0hDdmFVWnNXQnRhdU5KVkJhcU5uZUpDMFlBUnhVem01eFFoc3hWcWxo?=
 =?utf-8?B?NG9VejA1UGs2VlMwM3N0REJYc0dGT25lbFRDY2ViN3c5R045YkN3YktzVTJt?=
 =?utf-8?B?Sjl4UjBaOEt3dkJiTFF6OTJXZytiaWE1d3B2ZUd6YXRUQ0hPM0JadldoeUxR?=
 =?utf-8?B?TW9BcERkbWJBR25ScVNvUENXV1BGd0x3R0JqanNXK083SmdVaXhXOHQwbGlW?=
 =?utf-8?B?MWpHZEZpdHJJZFpQdUhvRE9lSjVBU2tMMWNNK2dIZHJqcHFvWklPT0NMM3FY?=
 =?utf-8?B?OGVUa0swRzRHQ1BWb1FhaUhSeDk2amIrNFdvOFh3OXZGb0pUZ2J6Szc5SCtn?=
 =?utf-8?B?TndJN1hZaUZUcC9PdTVDck9zcFh1STdkMC9LT2F6UUlxNW5oM3B5d1YvbU53?=
 =?utf-8?B?TGg4cFZVMElmNmIvdzY3ZTRsU1dqWVFWSUxyRCttTVN4SVFVNFI2ZXk3REVk?=
 =?utf-8?B?SVVaL0NxS2JvWDZHcHZxSk1XeTFBSU5ZYkZ6ZUpYWktZRUxFVUc2UU02UVlk?=
 =?utf-8?B?VzRqZ21KM01sTFFkdlRCMFdHS2JPbENlQkNHb3B2cjhuN3MyOER3U2VjSjFP?=
 =?utf-8?B?dkhmK1YxRkEvbXF6bjBTdjdId0JhdDdyOGtNTXg3czJJZGpjN0w0TlFSZmU4?=
 =?utf-8?B?UTRqTE1BWjBKTHFPdisxR0tReGhuSHRuMmI1Rk92Sm11Q1kxenVxcmNvdjBB?=
 =?utf-8?B?aSt5Z2l1dU9pclFYTW1yV2Q4aFBkMERxWi8zNkw1U1ZKdk9yd1d1WUhEcVd5?=
 =?utf-8?B?M29rZGc4L3gzZHd5RzB3SE1xVnlDVE9XTkwzNDhKOG5RSEcwd3BqaGdsRUtH?=
 =?utf-8?B?aXNQWDJMTW1NTXYwUmhHd1k5dVUwb0FXWHArOUZ6dms0bGdOenVkMVFVQXky?=
 =?utf-8?B?MVZkNGJBUXlYdDhGR2Y0YzNuN3FaMDhJUnpvOW5tY0xaVE1jek4wbDZBOVdh?=
 =?utf-8?B?N0N1bW1hUFRpaWRieHdxT0dMbVNwNjczdEcrQ1NTdzRxZ3Q5Qkt3aGJwL0Jh?=
 =?utf-8?B?ZmY5L1MySTFsU3FzZjU3QU83YUFOMWtFQXlPVmx4SUViV3F1UzRiQko4d1c1?=
 =?utf-8?B?TjNXWUZyM2VwSnp0T01NaERiZjRiZW5Bdy9FMlFkdjZ5ZUtPMHZZRkJjYy94?=
 =?utf-8?B?VnhNSjJxL1ZNZ2xKK1ZPQTBJR3dnQWFHOTdCRDlRelFwWTRMNHFrampFRCtj?=
 =?utf-8?B?dFJmZFQ2WXpPbUQ2d2VjV253WVNoU1gzVFZKWWdXZHR3UFErOHBhOVdaazlQ?=
 =?utf-8?B?K1Z6Y3hGZ0hJeG5MZjNHOXZIcnRndmJ6T0NPNElQbWN0WW9XejBNTjJBYVBV?=
 =?utf-8?B?YStUNVlraU1CdXBGcGRzM041bWRvMTFHVmpFc2poUEpWTmZkelpUVDV4eFBH?=
 =?utf-8?B?OU90RzBibWdCMzhMckFRbEExc09lMUdVVFVwdVp1VCtjbDFHSnh3c3lFVFBj?=
 =?utf-8?B?clRFakIwUTNycUU2RDRYOUhzN2tBSFhNZVhFM1lRa2Y5TkQ5WlorOVI4RTFn?=
 =?utf-8?Q?yMYkCTkQ5PM7wEabX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B2A6E97994EC744A0B5D74CE0EAD416@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bac9842e-389b-4aee-6edc-08db85977a2e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 00:56:23.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB3484
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMTLmmJ/mnJ/kuInnmoQgMDk6MTkgKzA4MDDvvIxIdWFjYWkgQ2hlbuWGmemB
k++8mg0KPiBPbiBUdWUsIEp1bCAxMSwgMjAyMyBhdCAxMToyN+KAr1BNIOKAjiBkb25tb3IgPGRv
bm1vcjMwMDBAaG90bWFpbC5jb20+IHdyb3RlOg0KPiA+IOWcqCAyMDIzLTA3LTEx5pif5pyf5LqM
55qEIDIyOjI2ICswODAw77yMSHVhY2FpIENoZW7lhpnpgZPvvJoNCj4gPiANCj4gPiAuLi4NCj4g
PiA+ICsgICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0NNRExJTkVfRVhURU5EKSkgew0KPiA+
ID4gPiArICAgICAgICAgICAgICAgc3Ryc2NweShib290X2NvbW1hbmRfbGluZSwgQ09ORklHX0NN
RExJTkUsIENPTU1BTkRfTElORV9TSVpFKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHN0cmxj
YXQoYm9vdF9jb21tYW5kX2xpbmUsICIgIiwgQ09NTUFORF9MSU5FX1NJWkUpOw0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgc3RybGNhdChib290X2NvbW1hbmRfbGluZSwgaW5pdF9jb21tYW5kX2xp
bmUsIENPTU1BTkRfTElORV9TSVpFKTsNCj4gPiA+IFlvdSBjYW4gc2ltcGx5IHRoZSBsb2dpYzoN
Cj4gPiA+ICAgICAgICAgICAgICAgIHN0cmxjYXQoYm9vdF9jb21tYW5kX2xpbmUsICIgIiwgQ09N
TUFORF9MSU5FX1NJWkUpOw0KPiA+ID4gICAgICAgICAgICAgICAgc3RybGNhdChib290X2NvbW1h
bmRfbGluZSwgQ09ORklHX0NNRExJTkUsIENPTU1BTkRfTElORV9TSVpFKTsNCj4gPiA+IEFuZCB0
aGVuIG1vZGlmeSB0aGUgY29tbWVudHMgYmVjYXVzZSB5b3UgYXJlIGFwcGVuZGluZyBidWlsdC1p
biBwYXJ0cw0KPiA+ID4gdG8gYm9vdGxvYWRlciBwYXJ0cy4NCj4gPiA+IA0KPiA+IEkgdGhpbmsg
dGhlIGNvbW1hbmQgbGluZSByZXRyaWV2ZWQgZnJvbSBib290bG9hZGVyIHNob3VsZCBiZSBwbGFj
ZWQgYWZ0ZXIgdGhlDQo+ID4gYnVpbHQtaW4gb25lIHNvIHRoYXQgaXQgY2FuIG92ZXJyaWRlIHBh
cmFtcyBpbiB0aGUgbGF0dGVyLg0KPiBjb25maWcgQ01ETElORV9FWFRFTkQNCj4gICAgICAgICBi
b29sICJVc2UgYnVpbHQtaW4gdG8gZXh0ZW5kIGJvb3Rsb2FkZXIga2VybmVsIGFyZ3VtZW50cyIN
Cj4gDQo+IFRoZSBmZHQgdmVyc2lvbiBhbHNvIHVzZXMgdGhpcyBsb2dpYywgYnV0IHlvdSBhcmUg
dXNpbmcgYm9vdGxvYWRlcg0KPiBwYXJ0cyB0byBleHRlbmQgYnVpbHQtaW4gcGFydHMuDQo+IA0K
SSBzZWUuIFNvIGlmIHRoZXJlJ3MgYSBtaXN0YWtlIGluIGJ1aWx0LWluLCB0aGUga2VybmVsIHdv
bid0IGJvb3QgZXZlbiBpZiBwYXNzZWQNCnRoZSBjb3JyZWN0IG9uZS4uLiBJJ2xsIGNvcnJlY3Qg
aXQsIGFueXdheS4NCg==
