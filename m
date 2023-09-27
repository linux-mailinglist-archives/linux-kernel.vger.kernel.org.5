Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE977AFB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjI0HB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjI0HB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:01:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12649F5;
        Wed, 27 Sep 2023 00:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2eheI5z/5TlzBPxKV23fwToVVmwKuf984UXOI2CEeD4AX/3E/G6/bW6pdMj6jBnjJ8JWxjiF8T2zExPMfiPPCq6XYq0rIy++9WJWKH1kiFUdwY9BDnZvQboJ/014uaHfhprSkqwIm/VhlIZjtC2Wint9I6f/NXWSsJX2ZjRi2A+PRssEnFUqiHxQVpP24fWymB0hJWNy9X08u/6R4clrSIu3E4RYqOLrson1V2gLUzPq00BuGguUp1APVtJzOemojpGsqkkauPfnINdSQil2IbwT1qw2g4edd1LUrvV5z+d4+563Wenq/rAQXziHAw5GMS4giREgK3DVg91zpSKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ9NVHf/ougz4VXLX3UCA2kIjB6xlxZ3d2MJQpdzr9U=;
 b=iTEW82jBTcfbVPxGX9Vq2D7CtiT+ym7uql5xQIIdUxck934cR+iCXJKgPR+Z+fZ6QzNFD+UIuVeShvI6fmltZwx9tkyV5eiU3UIunwBu0e6QevwEqj1uCbsP6EHZceQ6qze/hUfR0Z4++Gm/ItfWuZHYQP0hj1rAYj2n9ODWHNutYrq4g1YLr2CHSRvP+Q4g1q7lUjS2U5pYmT+0FEqQrAOF3dAIl6pn90RatWd553DnBxLq89uj0vun//UIE7E7jAv7vu4dVBLb+C5JVTzK+pIdej0qlnIDJ8BnL0XHnRogowOZdX+w0g7/KkbLfQRAKFXzuq/UZ6ew1A9W/IW9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ9NVHf/ougz4VXLX3UCA2kIjB6xlxZ3d2MJQpdzr9U=;
 b=p8FjgcZZmxHy2VvZKnVUpoov08u9nK6Lg20ieqbwwL/Z7cZ6sLG4vuv4834u1Hw6vr+RCTQEb3seVyLjJTGDddT9/ra6dx/vf3gNHYYWtbpZRR7+z8cUhs31WZGUtdREiSBc4TJmL/zrtezS+JlPvJl1ac7b6l1q2Ae7EakexCcGcPmWLz6w6mpY6Ey7qYJDugVVmhHhmBl8nMCZFH2nasB71w6IXbQ3RVeKh4tQiFW+XOImkRwB1AL0FaO8P51guXII+txpua3uXXfUcyxHWZxRd4apP8eAgMviet80DEvNlXpe5HlnWhziHGtZsS51FW6WoJYMbBNuEqRh9RPL0w==
Received: from SEYPR03MB7046.apcprd03.prod.outlook.com (2603:1096:101:d0::15)
 by TYZPR03MB5995.apcprd03.prod.outlook.com (2603:1096:400:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 07:01:05 +0000
Received: from SEYPR03MB7046.apcprd03.prod.outlook.com
 ([fe80::59de:bf6b:c22:4f8d]) by SEYPR03MB7046.apcprd03.prod.outlook.com
 ([fe80::59de:bf6b:c22:4f8d%7]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 07:01:02 +0000
From:   Cancan Chang <Cancan.Chang@amlogic.com>
To:     Oded Gabbay <ogabbay@kernel.org>
CC:     Jagan Teki <jagan@edgeble.ai>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: =?utf-8?B?5Zue5aSNOiBrZXJuZWwub3JnIDYuNS40ICwgTlBVIGRyaXZlciwgLS1ub3Qg?=
 =?utf-8?Q?support_(RFC)?=
Thread-Topic: kernel.org 6.5.4 , NPU driver, --not support (RFC)
Thread-Index: AQHZ7TUhgs72H8AZFkqdmOUY4AB+vbAmlr0AgABcLACABCyLj4AB9zwAgADn60g=
Date:   Wed, 27 Sep 2023 07:01:02 +0000
Message-ID: <SEYPR03MB70463AEED951A0E2C18481099AC2A@SEYPR03MB7046.apcprd03.prod.outlook.com>
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
 <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
 <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com>
In-Reply-To: <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7046:EE_|TYZPR03MB5995:EE_
x-ms-office365-filtering-correlation-id: 1db52e50-37cb-4854-39b5-08dbbf2782bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIlzzOxCTgGk59pV45MDTRa9ceXIggB8AGkGO6Tjh5BZM3H8Bi2RP4JjynhA4AwzrpeHAoSP4dfjkEp58ctKrO7WwHQWkFhFxuDBgRJSa/rCNb6iOzJiOEfKj6DVaFnYSVOEKMdpWVbCU/8yEwpZCCkAnC/H3Utn3O+w18AxmtR777Mu3muPDcpIMi6mt8JEDxsbr3r3r9xcu8NYqVYBagqad+OEJ3+Eva9GOW4BGhbM1z5NmEKdKv88oWZrdUwQWYgAx3+ac5YluaTtO1ClsnN6F1XMs1ZMD3uyTHT2Tv4S9DLbb3wGDjfKaeue1VVA7RDc9ktBt5w+dY2uTGxSeR4kfgQe1FvYwaA9t276pO8azFoa0ns/xhKyLtQSD5snrq42bwAbwuDHDikfAMkt+eHSfbGaDxnAd56sJZwdu7logLg0TE73rRyKr/dMkEhz1Kc1/n6HB5Mza9MKx6B9kLG/3X6Jf426xUo3EzF7J/OuPcZzstzqIF42jiQwMG52LTeAEFJa2y4lhwwGEDS6nbmZqxGDnUyHBe6eSG7+f0f8doe0XFqyeRWMKt+2mEKdUIs+C0IgTeuXjMYvHu0mJ9cTjwp4JiNBoUDE7IogAe6DpWILgfDyZF5IJsm5lJP7uu/89yYVfHEfeDdewNtuOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7046.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(2906002)(4326008)(41300700001)(52536014)(66556008)(5660300002)(8936002)(66446008)(64756008)(6916009)(54906003)(66476007)(66946007)(316002)(76116006)(91956017)(966005)(478600001)(71200400001)(6506007)(7696005)(53546011)(9686003)(26005)(83380400001)(224303003)(38100700002)(122000001)(38070700005)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFN3dTV3c20xa1g3U1drK2J3ZldYSnpnVFRPaXhSYXY1b1BpY09ieDA2Q0oz?=
 =?utf-8?B?OS9XZmlhekxnZWYxdnJHZVJBQXhoRE5aMTRuZVRlSmpXRWE0U1poMDRQUmdL?=
 =?utf-8?B?OG5ncktWdk5udVdWV2dDYzZHMkJ4VHZSV2hHT00xM3FReThLTXZ0VFVETzJv?=
 =?utf-8?B?Rm9kM0N2dFlPUWh2V2dLS1lsZGJNNElhMTNrbmYwbEUyS0hmUThEYTVMN2xx?=
 =?utf-8?B?K1pVM2FjT3lHZGxHSy80L3FqeUtUdFdvQ1dMWGhhSGFkM3QvcS9lMkdEamdM?=
 =?utf-8?B?NC9LQnBwSm1MVGNXc0Iwb0RqYjFzbndRY2xRNVp4bS9vR0NXNmVObHBudDha?=
 =?utf-8?B?V1pOSXg0bjJjMVA2S2Jrb2dSb1Q3ZGRkcUp0WWN1c21LY2ZqMks0NlhsRDZy?=
 =?utf-8?B?eS95VlhDZURhdnl2bkZvS25QY0xuUE8zb3pOdkNtQnpuK1QxVTl3ZTFIUmFS?=
 =?utf-8?B?YUtONGgrMzZGMW1HcE16dC9VU2svREhrQlUwYThVTjh3cjFtdis3YTdWUGlC?=
 =?utf-8?B?aHhTaFord2tkczRFRGRZSDdaR1ZTL1Vnb1RjalkwRWxhSDdQWU1MVXlQNkp5?=
 =?utf-8?B?RXpCYUxYQ0tmbUx2Y3IwSHl5MjFIU2d0K2Z3NUdDMUxiRlg3QzN6SXd0VFlZ?=
 =?utf-8?B?NFJCdVFaU3RQNG9zL002ZC8vZXZ6UmRYTlpoT3g4dlJibzV6N3gvRWdUNWlD?=
 =?utf-8?B?aWI1dlNGRityMDl4Yk1wcVduSktmOVI5QVZGVEpjM2VUVW4rSHFDRHFnRmw3?=
 =?utf-8?B?Z0o5VXdKQUtwR1ZHTWJsSUFFZ0I3WGFzNTJoWG4zUDVraDF4V01YT0pEQnZG?=
 =?utf-8?B?d3ArR1oxdlFRNXJPQ0xEYmZNRmIyUXh5VmxWbHB6WEptMElaZjVjQ2s2djVx?=
 =?utf-8?B?OFFna1BoZEV3dmxrNjZzK2M5S1JPbXZ0MWhvR2NUSGJQSG5KQnFPRGRsMFYw?=
 =?utf-8?B?RE0wT2dib3A5N3BjZWVPeWFEUWt1TTFIODg1UGozWThiMDhhbGY5YURJcXlp?=
 =?utf-8?B?a0JYd3djU3NObTYzWEtZR3NRWmd1QlRGRStjV09HeE9hM0JTVDh0SzRpaHVB?=
 =?utf-8?B?eWh5ZlFYRHhiV2ZWM2x0aHgxZy8wcGs3VkxiczZZcHdRNGlLQWVPbU5GQk52?=
 =?utf-8?B?THc4MHJBRHo5R3dFL3dpeU9OQ3BaM2hiN3R4RStvYlBhRE16R2JjYmhVYlZx?=
 =?utf-8?B?SzVINVF4aFZrZXErR0x1VnVuaTBKekJkb0M0eG1WSi9tZUFoQzR4R3loQzg3?=
 =?utf-8?B?SXdqaFlGOWJWL0NXVWRZYmVqcHROOUN0RHJNMWZJdko0d051d2YxdnRMdFNs?=
 =?utf-8?B?a2lHblBVaHdVMk1NMVY5QTdVRU9lcHR0MHhPdnJnKytKMnQ5WndqR3h3T1dR?=
 =?utf-8?B?Qm5scWdMY28rdUltQXozMVBoTzB2YWN0RmJhSjJHalJWUnlmQ0VId0wyVTUw?=
 =?utf-8?B?NVBPVU5iWWdjUkVZSnI4QlUrQ2k5VXVPaGNjUjJDYjA4Q2RIVzZ0ZGRFRkls?=
 =?utf-8?B?dGQydndCb0QyU3dMRmFONHk3T3NWUGdRYVhTZUdnMG45S1dhOFYxVzFQU2Q1?=
 =?utf-8?B?TFZCeXZwaDErVjRJd1RuOFdkT1dyelZVTTd2L1Y3cUM4RVcrc2hrVi84bi9U?=
 =?utf-8?B?U0gwaElGWWRIaXJsbjFmYzZwd1VzOG9UMWtKT0VJaUxmSnN4V1Z6L3U1YzR5?=
 =?utf-8?B?NWxCVUNrVjFzSzFDOUFUVzd3ZlgrUDBmUGJTQllNU01nb2hSWlp4UnE5eWRN?=
 =?utf-8?B?UG8wU1N6VDlkODI1Zkx1VTdISUNpczFKZWc1empRYWFTaDFJbExXVEFvUWNI?=
 =?utf-8?B?cEkzcEpCcm5xS1lkeTVuK0JxeEJDM29FbDd0THVlUnRYU0RoRXFNRUNvTi9E?=
 =?utf-8?B?aHF1SStBR3dTK3RnY0RwcVhmSlpkenY0Y3BaWmdjcGtVVmtvdk9mTWtGR0Rn?=
 =?utf-8?B?dTUzUVJzcWZLeDJpUjdzNGZHamc0R1lwN0lrQ1VsZDhrem1ZaW9zWXBKNnpQ?=
 =?utf-8?B?eU96OGhVeUsxRWt5WjFjNU1aT0dJT01Ud3lYRnR0M0V6T0NWMVBna1M1UXU0?=
 =?utf-8?B?aXdiOGpEWTdCbnhOd1dkeVd3MzNtYURLMmdNK3A2RnF3b1VOVFQ0WXljVnln?=
 =?utf-8?Q?+8KGIP1mHfwwzw/Muh5DxLJ1S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7046.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db52e50-37cb-4854-39b5-08dbbf2782bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:01:02.1045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAxnu48/+kWR7bo61i9cT1YfWlsKhxBgR/G9RHP2FP+avIVb4qrKklvcLeehm+RLCVJQVC6VbeGgpImakWWfPgYxlRlHC32FvJ+wYieUdLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4oCcT3IgZG8geW91IGhhbmRsZSBvbmUgY21kIGF0IGEgdGltZSwgd2hlcmUgdGhlIHVzZXIgc2Vu
ZHMgYSBjbWQgYnVmZmVyDQp0byB0aGUgZHJpdmVyIGFuZCB0aGUgZHJpdmVyIHRoZW4gc3VibWl0
IGl0IGJ5IHdyaXRpbmcgdG8gYSBjb3VwbGUgb2YNCnJlZ2lzdGVycyBhbmQgcG9sbHMgb24gc29t
ZSBzdGF0dXMgcmVnaXN0ZXIgdW50aWwgaXRzIGRvbmUsIG9yIHdhaXRzDQpmb3IgYW4gaW50ZXJy
dXB0IHRvIG1hcmsgaXQgYXMgZG9uZSA/4oCdDQogIC0tLSB5ZXPvvIwgdXNlciBzZW5kcyBhIGNt
ZCBidWZmZXIgdG8gZHJpdmVyLCBhbmQgZHJpdmVyIHRyaWdnZXJzIGhhcmR3YXJlIGJ5IHdyaXRp
bmcgdG8gcmVnaXN0ZXIsDQogICAgICAgIGFuZCB0aGVuLCB3YWl0cyBmb3IgYW4gaW50ZXJydXB0
IHRvIG1hcmsgaXQgIGFzIGRvbmUuDQoNCiAgICBNeSBjdXJyZW50IGRyaXZlciBpcyB2ZXJ5IGRp
ZmZlcmVudCBmcm9tIGRybSwgc28gSSB3YW50IHRvIGtub3cgaWYgSSBoYXZlIHRvIHN3aXRjaCB0
byBkcm3vvJ8NCiAgICBNYXliZSBJIGNhbiByZWZlciB0byAvZHJpdmVyL2FjY2VsL2hhYmFuYWxh
YnMuDQoNCnRoYW5rcw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQrlj5Hku7bkuro6IE9kZWQgR2FiYmF5IDxvZ2FiYmF5QGtlcm5lbC5vcmc+DQrlj5HpgIHml7bp
l7Q6IDIwMjPlubQ55pyIMjbml6UgMjA6NTQNCuaUtuS7tuS6ujogQ2FuY2FuIENoYW5nDQrmioTp
gIE6IEphZ2FuIFRla2k7IGxpbnV4LW1lZGlhOyBsaW51eC1rZXJuZWw7IERhdmUgQWlybGllOyBE
YW5pZWwgVmV0dGVyDQrkuLvpopg6IFJlOiBrZXJuZWwub3JnIDYuNS40ICwgTlBVIGRyaXZlciwg
LS1ub3Qgc3VwcG9ydCAoUkZDKQ0KDQpbIEVYVEVSTkFMIEVNQUlMIF0NCg0KT24gTW9uLCBTZXAg
MjUsIDIwMjMgYXQgMTI6MjnigK9QTSBDYW5jYW4gQ2hhbmcgPENhbmNhbi5DaGFuZ0BhbWxvZ2lj
LmNvbT4gd3JvdGU6DQo+DQo+IFRoYW5rIHlvdSBmb3IgeW91ciByZXBseSBmcm9tIEphZ2FuICYg
T2RlZC4NCj4NCj4gSXQgaXMgdmVyeSBhcHByb3ByaXRhdGUgZm9yIG15IGRyaXZlciB0byBiZSBw
bGFjZWQgaW4gZHJpdmVyL2FjY2VsLg0KPg0KPiBNeSBhY2NlbGVyYXRvciBpcyBuYW1lZCBBRExB
KEFtbG9naWMgRGVlcCBMZWFybmluZyBBY2NlbGVyYXRvcikuDQo+IEl0IGlzIGFuIElQIGluIFNP
QyxtYWlubHkgdXNlZCBmb3IgbmV1cmFsIG5ldHdvcmsgbW9kZWxzIGFjY2VsZXJhdGlvbi4NCj4g
SXQgd2lsbCBzcGxpdCBhbmQgY29tcGlsZSB0aGUgbmV1cmFsIG5ldHdvcmsgbW9kZWwgaW50byBh
IHByaXZhdGUgZm9ybWF0IGNtZCBidWZmZXIsDQo+IGFuZCBzdWJtaXQgdGhpcyBjbWQgYnVmZmVy
IHRvIEFETEEgaGFyZHdhcmUuIEl0IGlzIG5vdCBwcm9ncmFtbWFibGUgZGV2aWNlLg0KV2hhdCBl
eGFjdGx5IGRvZXMgaXQgbWVhbiB0byAic3VibWl0IHRoaXMgY21kIGJ1ZmZlciB0byBBRExBIGhh
cmR3YXJlIiA/DQoNCkRvZXMgeW91ciBoL3cgcHJvdmlkZXMgcXVldWVzIGZvciB0aGUgdXNlci9k
cml2ZXIgdG8gcHV0IHRoZWlyDQp3b3JrbG9hZHMvY21kLWJ1ZnMgb24gdGhlbSA/IEFuZCBkb2Vz
IGl0IHByb3ZpZGUgc29tZSBjb21wbGV0aW9uIHF1ZXVlDQp0byBub3RpZnkgd2hlbiB0aGUgd29y
ayBpcyBjb21wbGV0ZWQ/DQoNCk9yIGRvIHlvdSBoYW5kbGUgb25lIGNtZCBhdCBhIHRpbWUsIHdo
ZXJlIHRoZSB1c2VyIHNlbmRzIGEgY21kIGJ1ZmZlcg0KdG8gdGhlIGRyaXZlciBhbmQgdGhlIGRy
aXZlciB0aGVuIHN1Ym1pdCBpdCBieSB3cml0aW5nIHRvIGEgY291cGxlIG9mDQpyZWdpc3RlcnMg
YW5kIHBvbGxzIG9uIHNvbWUgc3RhdHVzIHJlZ2lzdGVyIHVudGlsIGl0cyBkb25lLCBvciB3YWl0
cw0KZm9yIGFuIGludGVycnVwdCB0byBtYXJrIGl0IGFzIGRvbmUgPw0KDQo+DQo+IEFETEEgaW5j
bHVkZXMgZm91ciBoYXJkd2FyZSBlbmdpbmVzOg0KPiBSUyBlbmdpbmVzICAgICAgICAgICAgIDog
d29ya2luZyBmb3IgdGhlIHJlc2hhcGUgb3BlcmF0b3JzDQo+IE1BQyBlbmdpbmVzICAgICAgICAg
OiB3b3JraW5nIGZvciB0aGUgY29udm9sdXRpb24gb3BlcmF0b3JzDQo+IERXIGVuZ2luZXMgICAg
ICAgICAgIDogd29ya2luZyBmb3IgdGhlIHBsYW5lciAmIEVsZW1lbnR3aXNlIG9wZXJhdG9ycw0K
PiBBY3RpdmF0aW9uIGVuZ2luZXMgOiB3b3JraW5nIGZvciBhY3RpdmF0aW9uIG9wZXJhdG9ycyhS
ZUx1LHRhbmguLikNCj4NCj4gQnkgdGhlIHdheSwgbXkgSVAgaXMgbWFpbmx5IHVzZWQgZm9yIFNP
QywgYW5kIHRoZSBjdXJyZW50IGRyaXZlciByZWdpc3RyYXRpb24gaXMgdGhyb3VnaCB0aGUgcGxh
dGZvcm1fZHJpdmVyLA0KPiBpcyBpdCBuZWNlc3NhcnkgdG8gc3dpdGNoIHRvIGRybT8NClRoaXMg
cHJvYmFibHkgZGVwZW5kcyBvbiB0aGUgYW5zd2VyIHRvIG15IHF1ZXN0aW9uIGFib3ZlLiBidHcs
IHRoZXJlDQphcmUgZHJpdmVycyBpbiBkcm0gdGhhdCBoYW5kbGUgSVBzIHRoYXQgYXJlIHBhcnQg
b2YgYW4gU09DLCBzbw0KcGxhdGZvcm1fZHJpdmVyIGlzIHN1cHBvcnRlZC4NCg0KT2RlZA0KDQo+
DQo+IHRoYW5rcy4NCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiDlj5Hku7bkuro6IE9kZWQgR2FiYmF5IDxvZ2FiYmF5QGtlcm5lbC5vcmc+DQo+IOWPkemA
geaXtumXtDogMjAyM+W5tDnmnIgyMuaXpSAyMzowOA0KPiDmlLbku7bkuro6IEphZ2FuIFRla2kN
Cj4g5oqE6YCBOiBDYW5jYW4gQ2hhbmc7IGxpbnV4LW1lZGlhOyBsaW51eC1rZXJuZWw7IERhdmUg
QWlybGllOyBEYW5pZWwgVmV0dGVyDQo+IOS4u+mimDogUmU6IGtlcm5lbC5vcmcgNi41LjQgLCBO
UFUgZHJpdmVyLCAtLW5vdCBzdXBwb3J0IChSRkMpDQo+DQo+IFvkvaDpgJrluLjkuI3kvJrmlLbl
iLDmnaXoh6ogb2dhYmJheUBrZXJuZWwub3JnIOeahOeUteWtkOmCruS7tuOAguivt+iuv+mXriBo
dHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27vvIzku6Xkuobop6Po
v5nkuIDngrnkuLrku4DkuYjlvojph43opoFdDQo+DQo+IFsgRVhURVJOQUwgRU1BSUwgXQ0KPg0K
PiBPbiBGcmksIFNlcCAyMiwgMjAyMyBhdCAxMjozOOKAr1BNIEphZ2FuIFRla2kgPGphZ2FuQGVk
Z2VibGUuYWk+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCAyMiBTZXB0IDIwMjMgYXQgMTU6MDQs
IENhbmNhbiBDaGFuZyA8Q2FuY2FuLkNoYW5nQGFtbG9naWMuY29tPiB3cm90ZToNCj4gPiA+DQo+
ID4gPiBEZWFyIE1lZGlhIE1haW50YWluZXJzOg0KPiA+ID4gICAgICBUaGFua3MgZm9yIHlvdXIg
YXR0ZW50aW9uLiBCZWZvcmUgZGVzY3JpYmluZyBteSBwcm9ibGVt77yMbGV0IG1lIGludHJvZHVj
ZSB0byB5b3Ugd2hhdCBJICBtZWFuIGJ5IE5QVS4NCj4gPiA+ICAgICAgTlBVIGlzIE5ldXJhbCBQ
cm9jZXNzaW5nIFVuaXQsIEl0IGlzIGRlc2lnbmVkIGZvciBkZWVwIGxlYXJuaW5nIGFjY2VsZXJh
dGlvbiwgSXQgaXMgYWxzbyBjYWxsZWQgVFBVLCBBUFUgLi4NCj4gPiA+DQo+ID4gPiAgICAgIFRo
ZSByZWFsIHByb2JsZW1zOg0KPiA+ID4gICAgICAgV2hlbiBJIHdhcyBhYm91dCB0byB1cHN0cmVh
bSBteSBOUFUgZHJpdmVyIGNvZGVzIHRvIGxpbnV4IG1haW5saW5lLCBpIG1lZXQgdHdvIHByb2Js
ZW1zOg0KPiA+ID4gICAgICAgICAxLiAgQWNjb3JkaW5nIHRvIG15IHJlc2VhcmNoLCBUaGVyZSBp
cyBubyBOUFUgbW9kdWxlIHBhdGggaW4gdGhlIGxpbnV4IChiYXNlIG9uIGxpbnV4IDYuNS40KSAs
IEkgaGF2ZSBzZWFyY2hlZCBhbGwgbGludXggcHJvamVjdHMgYW5kIGZvdW5kIG5vIG9yZ2FuaXph
dGlvbiBvciBjb21hbnkgdGhhdCBoYXMgc3VibWl0dGVkIE5QVSBjb2RlLiBJcyB0aGVyZSBhIHBh
dGggcHJlcGFyZWQgZm9yIE5QVSBkcml2ZXIgY3VycmVudGx5Pw0KPiA+ID4gICAgICAgICAyLiAg
IElmIHRoZXJlIGlzIG5vIE5QVSBkcml2ZXIgcGF0aCBjdXJyZW50bHksIEkgYW0gZ29pbmcgdG8g
cHV0IG15IE5QVSBkcml2ZXIgY29kZSBpbiB0aGUgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbWxv
Z2ljLyDvu78sIGJlY2F1c2UgbXkgTlBVIGRyaXZlciBiZWxvbmdzIHRvIGFtbG9naWMuIGFuZCBh
bWxvZ2ljIE5QVSBpcyBtYWlubHkgdXNlZCBmb3IgQUkgdmlzaW9uIGFwcGxpY2F0aW9ucy4gSXMg
dGhpcyBwbGFuIHN1aXRhYmUgZm9yIHlvdT8NCj4gPg0KPiA+IElmIEknbSBjb3JyZWN0IGFib3V0
IHRoZSBkaXNjdXNzaW9uIHdpdGggT2RlZCBHYWJieSBiZWZvcmUuIEkgdGhpbmsNCj4gPiB0aGUg
ZHJpdmVycy9hY2NlbC8gaXMgcHJvcGVyIGZvciBBSSBBY2NlbGVyYXRvcnMgaW5jbHVkaW5nIE5Q
VS4NCj4gPg0KPiA+ICsgT2RlZCBpbiBjYXNlIGhlIGNhbiBjb21tZW50Lg0KPiA+DQo+ID4gVGhh
bmtzLA0KPiA+IEphZ2FuLg0KPiBUaGFua3MgSmFnYW4gZm9yIGFkZGluZyBtZSB0byB0aGlzIHRo
cmVhZC4gQWRkaW5nIERhdmUgJiBEYW5pZWwgYXMgd2VsbC4NCj4NCj4gSW5kZWVkLCB0aGUgZHJp
dmVycy9hY2NlbCBpcyB0aGUgcGxhY2UgZm9yIEFjY2VsZXJhdG9ycywgbWFpbmx5IGZvcg0KPiBB
SS9EZWVwLUxlYXJuaW5nIGFjY2VsZXJhdG9ycy4NCj4gV2UgY3VycmVudGx5IGhhdmUgMyBkcml2
ZXJzIHRoZXJlIGFscmVhZHkuDQo+DQo+IFRoZSBhY2NlbCBzdWJzeXN0ZW0gaXMgcGFydCBvZiB0
aGUgbGFyZ2VyIGRybSBzdWJzeXN0ZW0uIEJhc2ljYWxseSwgdG8NCj4gZ2V0IGludG8gYWNjZWws
IHlvdSBuZWVkIHRvIGludGVncmF0ZSB5b3VyIGRyaXZlciB3aXRoIHRoZSBkcm0gYXQgdGhlDQo+
IGJhc2ljIGxldmVsIChyZWdpc3RlcmluZyBhIGRldmljZSwgaG9va2luZyB1cCB3aXRoIHRoZSBw
cm9wZXINCj4gY2FsbGJhY2tzKS4gb2ZjIHRoZSBtb3JlIHlvdSB1c2UgY29kZSBmcm9tIGRybSwg
dGhlIGJldHRlci4NCj4gWW91IGNhbiB0YWtlIGEgbG9vayBhdCB0aGUgZHJpdmVycyB1bmRlciBh
Y2NlbCBmb3Igc29tZSBleGFtcGxlcyBvbg0KPiBob3cgdG8gZG8gdGhhdC4NCj4NCj4gQ291bGQg
eW91IHBsZWFzZSBkZXNjcmliZSBpbiBhIGNvdXBsZSBvZiBzZW50ZW5jZXMgd2hhdCB5b3VyDQo+
IGFjY2VsZXJhdG9yIGRvZXMsIHdoaWNoIGVuZ2luZXMgaXQgY29udGFpbnMsIGhvdyB5b3UgcHJv
Z3JhbSBpdC4gaS5lLg0KPiBJcyBpdCBhIGZpeGVkLWZ1bmN0aW9uIGRldmljZSB3aGVyZSB5b3Ug
d3JpdGUgdG8gYSBjb3VwbGUgb2YgcmVnaXN0ZXJzDQo+IHRvIGV4ZWN1dGUgd29ya2xvYWRzLCBv
ciBpcyBpdCBhIGZ1bGx5IHByb2dyYW1tYWJsZSBkZXZpY2Ugd2hlcmUgeW91DQo+IGxvYWQgY29t
cGlsZWQgY29kZSBpbnRvIGl0IChHUFUgc3R5bGUpID8NCj4NCj4gRm9yIGJldHRlciBiYWNrZ3Jv
dW5kIG9uIHRoZSBhY2NlbCBzdWJzeXN0ZW0sIHBsZWFzZSByZWFkIHRoZSBmb2xsb3dpbmc6DQo+
IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2FjY2VsL2ludHJvZHVjdGlvbi5odG1sDQo+IFRoaXMg
aW50cm9kdWN0aW9uIGFsc28gY29udGFpbnMgbGlua3MgdG8gb3RoZXIgaW1wb3J0YW50IGVtYWls
IHRocmVhZHMNCj4gYW5kIHRvIERhdmUgQWlybGllJ3MgQk9GIHN1bW1hcnkgaW4gTFBDMjAyMi4N
Cj4NCj4gVGhhbmtzLA0KPiBPZGVkDQo=
