Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F66755BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjGQGcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGQGcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:32:00 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2146.outbound.protection.outlook.com [40.92.63.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0325911C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz83ZaQihNnUMR7tpRlH93UTSE8vRoW0vYLqXudKJYo+mE2wCIJq4CQi3vr1zSRO3L2jxjfERsPLGulERSfYF/MH8SYuOLvakZtyobMa8dm+T7/Xny/reEZ6v/Z3rvt4qog/zaaAsgrREXr+9UK7rA5LOGgz3X8S1DvVGvso3Wj6fSVDR/ZfVOOvtZr8/JbKOAIRPJmH+9Bb88B28cyYisqeZkXaWj+dq+wwERK9AK3EDkWdFYTreIA8K7gzvRBjm46O/8FN+3DP1zITA4gVkynEmm003bxCoEAOsGg8phzcQ2Hq7UuQKAwqXwQ5NxXYmlaymXxXypb9qf5wXc0cxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UJuREPddrXcH7F6e2HBlPCa/1GiR5ebJfD+qWTy2YE=;
 b=ZQK1KcNDQaRy+lFqdL5xeWTw/mrIUM5K2nlCiHzQbEA0piwpv4zBNjXiL5ftMRLtGJ+1ptZn6di2IHeRWyIdasD1OB4InmgLpqNkq3uvajXOiq74ZcNaoLDr1c9a8qPoW0mVbHZwNS9guyzBJIE/9YZkKhtu4zGmpVYkJsPS9ZzaBKBdJ9blzxNMU+NVktJ16IrQ1NlILKvqiwSzDaZcOqf8rsnLU7L0rIol10h9R3GCYyJq9lYiGNlVVKvQK4uL3IWZcUipMHYvPZz8Yyo1+tB78j3UNNLgJlKgjOROOizU1iQRCkrsu3PdO8mO+2hy5OtVxqIyerJdBDhbYO+i6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UJuREPddrXcH7F6e2HBlPCa/1GiR5ebJfD+qWTy2YE=;
 b=gqFNOi/4qzboYn1uKKghtUCHl1waDErAVjOt/elrgY87DDGiPVhsJQXreUWwvgObDfSHQDtIjfVqPVE/2Or5jzHeNWwHmLJDyjkUj7SJs2KFmWt5lP12vx+NnpAXm+Q9GBV4YmGZjzqh8czrAgp3cP57eK2SXR+OOfIXCj2xcyngusSlQaulONxDwxfF71TQ6E2WtCS4lJ/44gR6AhXf2zS8I2VZYYpSOO0ACom6yFiqcPx4B9EroYkXNK1ZSCwjtxQP5Jb6/PPOrhcGFW86ZnyY1E2ncJyiHwDxUKtNaQmzMRU3nFBY9C9KbJUMBdVzFQdcVQpZ0mugoM9b3AmwYQ==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by MEYP282MB1447.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 06:31:52 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f263:312b:1b6c:512b%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 06:31:52 +0000
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
Subject: Re: [PATCH v4] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH v4] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZuGRyL245AJkbQECOXzGMXch81q+9ffwAgAAB84A=
Date:   Mon, 17 Jul 2023 06:31:52 +0000
Message-ID: <141523b3b34a622bb4376f006574a87fcd33bc82.camel@hotmail.com>
References: <MEYP282MB2597514C7A4697A72F829B78D93BA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <CAAhV-H6u5WBVC36OyNsFZVfmZ9_Nk+_ASFrYyxd5fsEEdNRaMQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6u5WBVC36OyNsFZVfmZ9_Nk+_ASFrYyxd5fsEEdNRaMQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [PzpwRsW3SLhRyPtDNNcTC2eOJVjpLWB4oS7DEQs+LHEBMeWbLKDY0yAYcBTQ8ioF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|MEYP282MB1447:EE_
x-ms-office365-filtering-correlation-id: 6eddac5d-b2c1-4806-48b0-08db868f8252
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7pzw/CJn1H12Tc0XdPKNK/m0NyZyYDdiAH3IRYpKEdcbPaLI238anZB+w5xNbznoJBhJx/JojCpoMW8TS65OEu0EjD/CN4m2QsAqS99WkgUTtHGtzRJYyjSIN0KKYRVXaXv01B2kACLY8qLR2i9xwbY1iJGAi0WBZRsojr0DyZv3I/Zql4nP+cHvsu1kLNx9DZ/4LVEyezLFJyyd2sXmuUdRaUciPQPnkpv8KobZjx1rN6jqtiV6qsy8s1a0UL9iveWLGAu/ViMhZNKj/DUC7JF49w4ZOKUyqG1cLfpQlJpA2HVqYUSsIgEhhzNYFo+K/+aU/skg44mHMXdwOTLHNvbVPtXuJzaBxqaMK8gGJOOGv3OtrBHUMCug1obPnFUqudDTuQl+vrixBctf97LWeEXp78a84Mkd32Le8AXBOmAAeeHI1frT1ORoyUgOqwmfeNYaaiDW3hIikDVpmij0i0JWYZs3hVy0F4FWAXYvBedqV0MlixsuMX0sICtc6Oo8ccB7jhlDGiAlb1bSOgAn9Lb2r3W6HmlTHN9mCMub8JCzBG8ermOiHh14VXZjL32
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmJLVzZ4dzE4SEd3cEplNjFIUXRmaWE1RnJMeUVhMlR1T1BzYUtYcUlUbXY2?=
 =?utf-8?B?VklZOGdWOEhURUpXN01lZ2VtNVlHSXZqZU1jRFcwWXd2WDdDT0VTWGxVRjNJ?=
 =?utf-8?B?ckQwdzY2Wml1c2xad0hYRU80ZFYxVHZka2tLeW5YVUlUQ1dMUlJBU1ZDT1NW?=
 =?utf-8?B?QUdKdXVHTnZQRnNlVWxpWFJ3YmtvVE15V1htcWhHbnN0eWxQS2R0MXVWQWlE?=
 =?utf-8?B?NE9jZXJ6bHo4K05zS2IvZ3ZFZXJ5c2RpY3JqaEhOblV3SEdJZzJCM01wblNK?=
 =?utf-8?B?cnhxdFZEQ0h4L0NzbXFsU3FPdU5VMWZEaFhYQWFWOWVKY1JaNW0xZncrbFAw?=
 =?utf-8?B?K2ZGVTB6RkplTm9YTWFRdU9JM2h5bzMvUUcvdExpWG9BWkdMN0NqRWJLd3FK?=
 =?utf-8?B?K293UHB6em8zUGg0VW9TOE82eHY0ZE8waHFmOVVyVzhkMWhkMVNmcTdiaW01?=
 =?utf-8?B?clhlSHRJSmhZZktaV0I1WWoxMDcveEZCTEFITk51cFVaSUlyV3ZENkQrd0Fo?=
 =?utf-8?B?Vm90NlJqY0NvMXFFZ01tYlVTNmh4QXlORDJ2YUJaRGlSTTJwVjdoNW1HTGJK?=
 =?utf-8?B?WkxHVVJtaXZyMmM0TnhZMFhBcGhoZjZPWTgxUGxEYUFZVGFWRGxMS2w2T1ZF?=
 =?utf-8?B?ZExlc09pYm5oRC9BSU1CemtlTWhmZ3NtdmVDOTdTQ1BSQnFjWGxCbUlPRFFI?=
 =?utf-8?B?cDFoanRCSjk4U3JienhOMm5wUGJqMzZaRitBV3RhVnRJbUhrbGR2dzViTmdP?=
 =?utf-8?B?TUJMb05MdmdxbWRrSWpkaUVtRTFGOTRzbXR0eEZvcXAyRjBCZ0pYbGUyNlBm?=
 =?utf-8?B?Ykt3OC9TOFRaMVdYY2RQbWs4Z1YzbzdsQnFzV3Rpa3JkQlM1SUVjMFBXa0Qr?=
 =?utf-8?B?SG52TWxlT0R4NFZPMVVaVDg3OEJvdDhiczBablZsMnA2NmJjTDZ6dkJQQW5M?=
 =?utf-8?B?dHV2Uk9BNDRkMXVFaFh5dDh5M0ZpZnRwN0Eyc2x6Z2tVTGh6SnZmUGh1KzlE?=
 =?utf-8?B?T1JXcnlzQi85QlhBajJYZExwUGhUWHJoVUkrVVdrMlJKaDUwdkRXV3FZOFQw?=
 =?utf-8?B?eVF2ejIyYTZTZ01CUW5tQUx2NWZYb056TUJFVHc5bnladHFEY0NiVXYyREMy?=
 =?utf-8?B?WVdlSVBHRUFqWUJvWUlycW5vY0tOaURtQ2U1d1NyRk5ncm1TUXVJOU9ZTE1G?=
 =?utf-8?B?VHpQQ01lVzNqSWkvSWVsMm8xa1JwWnF4RkYwbkR6MjliK0p3VUwzdU53Mlk5?=
 =?utf-8?B?ZGVHQXFHTkk0WjUrZHRaYWlIUTROZlVwczgyYi9SQStHanMwdDlUblQvZ1BE?=
 =?utf-8?B?ODFXdGtSQkFaWEpkTjV5TkxTRzRieG9SWXNnUFg2ZkVhdzlMWU9nSjhzWUdP?=
 =?utf-8?B?d1Nwd0RRWU03bWxyNjFnWGpPeWo2Q1ZrVmdKbmhOUVpVV2VhUldQbHlHell4?=
 =?utf-8?B?TnpXbk5rMmRTNDhCeFV4eVRndUg5YXpOVDZhY2w2a0ZqUktyN25UV3JYRzFS?=
 =?utf-8?B?QUpZKzNYS01qMlVwY0J1azkwM0VKU09MbWxpY3I0dUpGelJaRkJ4TVJiREJq?=
 =?utf-8?B?cVZOY3NwV3QwVlZiUHhTby9pak9LTmJ2THV2bWhHZWZxanUwODJEdisyajFN?=
 =?utf-8?B?S2IrTGM5M0x3bWhiMUZWMm91UjJhMjlYWEpPZ1hsR2l1VXFGaXc2Y2Y3QUxw?=
 =?utf-8?B?bW05OWhlWUl4WTJscFdQRWVZNU5VNmRHS3B6d3BmbFZuNExIY0ZTUE8xM0dN?=
 =?utf-8?Q?vQMxJ5QwGjo/skxIrU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F6E49B35BA734BBED5F0298EF48177@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eddac5d-b2c1-4806-48b0-08db868f8252
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 06:31:52.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1447
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMTfmmJ/mnJ/kuIDnmoQgMTQ6MjQgKzA4MDDvvIxIdWFjYWkgQ2hlbuWGmemB
k++8mg0KPiBPbiBNb24sIEp1bCAxNywgMjAyMyBhdCAxMjowOeKAr1BNIERvbmcgWmhpaG9uZyA8
ZG9ubW9yMzAwMEBob3RtYWlsLmNvbT4gd3JvdGU6DQo+ID4gTWFrZSBDT05GSUdfQ01ETElORSB3
b3JrIHdpdGggQ09ORklHX0NNRExJTkVfRVhURU5EIGFuZA0KPiA+IENPTkZJR19DTURMSU5FX0JP
T1RMT0FERVIuIFRoZSB0b3VjaGVkIGZ1bmN0aW9uIGlzIGJvb3RjbWRsaW5lX2luaXQoKWAuDQo+
ID4gVGhlcmUncyBhbHJlYWR5IGNvZGUgaGFuZGxpbmcgQ09ORklHX0NNRExJTkVfRk9SQ0UsIHdo
aWNoIHJlcGxhY2VzDQo+ID4gYGJvb3RfY29tbWFuZF9saW5lYCB3aXRoIENPTkZJR19DTURMSU5F
IGFuZCBpbW1lZGlhdGVseWBnb3RvIG91dGAuIEl0J2QgYmUNCj4gPiBzaW1pbGFyIHdheSB0byBo
YW5kbGUgQ09ORklHX0NNRExJTkVfRVhURU5EIGFuZCBDT05GSUdfQ01ETElORV9CT09UTE9BREVS
LA0KPiA+IHNvIHNvbWUgY29kZSBpcyBhZGRlZCBhZnRlciBPRl9GTEFUVFJFRSBwYXJ0IHRvIGhh
bmRsZSB0aGVtLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmcgWmhpaG9uZyA8ZG9ubW9y
MzAwMEBob3RtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiB2NCAtPiB2MzogTWFrZSBDT05G
SUdfQ01ETElORSBhcHBlbmRlZCB0byB0aGUgZW5kIG9mIGNvbW1hbmQgbGluZSAoSHVhY2FpKTsN
Cj4gPiAgICAgICAgIFJlbW92ZWQgdW5uZWNlc3NhcnkgI2lmZGVmIHNpbmNlIENPTkZJR19DTURM
SU5FIGlzIGFsd2F5cyBhIHN0cmluZyBvbg0KPiA+ICAgICAgICAgbG9vbmdhcmNoDQo+ID4gdjMg
LT4gdjI6IFJld29yZGVkIHRoZSBjb21taXQgbWVzc2FnZSBhZ2FpbiB0byBtYWtlIGl0IGltcGVy
YXRpdmUgKFJ1b3lhbykNCj4gPiB2MiAtPiB2MTogUmV3b3JkZWQgdGhlIGNvbW1pdCBtZXNzYWdl
IHNvIGl0J3MgbW9yZSBpbXBlcmF0aXZlIChNYXJrdXMpOw0KPiA+ICAgICAgICAgQWRkZWQgYGdv
dG8gb3V0YCB0byBGRFQgcGFydCAoSHVhY2FpKQ0KPiA+IA0KPiA+ICBhcmNoL2xvb25nYXJjaC9r
ZXJuZWwvc2V0dXAuYyB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNo
L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC9sb29uZ2FyY2gva2VybmVsL3NldHVwLmMNCj4gPiBpbmRl
eCA3OGEwMDM1OWJkZTMuLjNjYWZkYTFhNDA5ZSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2xvb25n
YXJjaC9rZXJuZWwvc2V0dXAuYw0KPiA+ICsrKyBiL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1
cC5jDQo+ID4gQEAgLTMzMiw3ICszMzIsMjQgQEAgc3RhdGljIHZvaWQgX19pbml0IGJvb3RjbWRs
aW5lX2luaXQoY2hhciAqKmNtZGxpbmVfcCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJsY2F0KGJvb3RfY29tbWFuZF9saW5lLCAiICIsIENPTU1BTkRfTElORV9TSVpFKTsNCj4gPiAN
Cj4gPiAgICAgICAgICAgICAgICAgc3RybGNhdChib290X2NvbW1hbmRfbGluZSwgaW5pdF9jb21t
YW5kX2xpbmUsIENPTU1BTkRfTElORV9TSVpFKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBv
dXQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJ
R19DTURMSU5FDQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogSWYgQ09ORklHX0NNRExJ
TkVfQk9PVExPQURFUiBpcyBlbmFibGVkIHRoZW4gd2UgdXNlIHRoZWkgYnVpbHQtaW4NCj4gPiAr
ICAgICAgICAqIGNvbW1hbmQgbGluZSBpZiBubyBjb21tYW5kIGxpbmUgZ2l2ZW4sIG9yIHdlIGFw
cGVuZCBnaXZlbiBjb21tYW5kDQo+ID4gKyAgICAgICAgKiBsaW5lIHRvIHRoZSBidWlsdC1pbiBv
bmUgaWYgQ09ORklHX0NNRExJTkVfRVhURU5EIGlzIGVuYWJsZWQuDQo+ID4gKyAgICAgICAgKi8N
Cj4gPiArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19DTURMSU5FX0VYVEVORCkpIHsNCj4g
PiArICAgICAgICAgICAgICAgc3Ryc2NweShib290X2NvbW1hbmRfbGluZSwgQ09ORklHX0NNRExJ
TkUsIENPTU1BTkRfTElORV9TSVpFKTsNCj4gPiArICAgICAgICAgICAgICAgc3RybGNhdChib290
X2NvbW1hbmRfbGluZSwgIiAiLCBDT01NQU5EX0xJTkVfU0laRSk7DQo+ID4gKyAgICAgICAgICAg
ICAgIHN0cmxjYXQoYm9vdF9jb21tYW5kX2xpbmUsIGluaXRfY29tbWFuZF9saW5lLCBDT01NQU5E
X0xJTkVfU0laRSk7DQo+ID4gICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKElTX0VO
QUJMRUQoQ09ORklHX0NNRExJTkVfQk9PVExPQURFUikgJiYgIWJvb3RfY29tbWFuZF9saW5lWzBd
KQ0KPiA+ICsgICAgICAgICAgICAgICBzdHJzY3B5KGJvb3RfY29tbWFuZF9saW5lLCBDT05GSUdf
Q01ETElORSwgQ09NTUFORF9MSU5FX1NJWkUpOw0KPiA+ICAjZW5kaWYNCj4gPz8/V2hhdCBpcyB0
aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIFYzIGFuZCBWND8NCj4gQW5kIHRoZSB0aXRsZSBjYW4gYmUg
Ikxvb25nQXJjaDogRml4IENPTkZJR19DTURMSU5FX0VYVEVORCBhbmQNCj4gQ09ORklHX0NNRExJ
TkVfQk9PVExPQURFUiBoYW5kbGluZyINCj4gDQo+IEh1YWNhaQ0KPiANCj4gPiAgb3V0Og0KPiA+
IC0tDQo+ID4gMi4yNS4xDQo+ID4gDQoNCkxvb2tzIGxpa2UgSSBtaXNzZWQgLWEgb24gY29tbWl0
Li4uIEknbGwgcmVzZW5kIGl0IEFTQVAuDQo=
