Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7678BEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjH2G4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjH2Gzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:55:47 -0400
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E836C0;
        Mon, 28 Aug 2023 23:55:45 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 51988118470C;
        Tue, 29 Aug 2023 09:55:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 51988118470C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1693292143; bh=3GHip7pyh6lVE2PBTfA91VbIjKp7JJeCoSn6Api8aHQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Xd4PNjR9pn/3i/OLno1FYVU0+afG+/tcmsksX+0oIJHV8YVJlO2a1VGnK/P/ephUC
         Ozt9zDXPXSxzPMarwqCHBxfsh2LhqvlgBjO0j/H+Xz2+PJKxmCtd5QQLt7o4MP/K0Y
         mBqntMR+qJr7oyAbLRdqQh37ZVJ82AKWP8ZdQirs=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
        by mx0.infotecs-nt (Postfix) with ESMTP id 4FEE23156D42;
        Tue, 29 Aug 2023 09:55:43 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
CC:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] ipv6: mcast: Remove redundant comparison in
 igmp6_mcf_get_next()
Thread-Topic: [PATCH net] ipv6: mcast: Remove redundant comparison in
 igmp6_mcf_get_next()
Thread-Index: AQHZ2kXU4vAKsCm3YECOhAX7UD97hA==
Date:   Tue, 29 Aug 2023 06:55:42 +0000
Message-ID: <1b0dc662-7d77-81a6-73cc-4f3f9c6cc915@infotecs.ru>
References: <20230828111604.583371-1-Ilia.Gavrilov@infotecs.ru>
 <cdc2183a-c79a-b4bd-2726-bd3a2d6d5440@kernel.org>
In-Reply-To: <cdc2183a-c79a-b4bd-2726-bd3a2d6d5440@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFC196D5C9EBDC4089E1A1F1BB5C9665@infotecs.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/08/29 05:18:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/29 04:09:00 #21767055
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yOS8yMyAwNTo0NCwgRGF2aWQgQWhlcm4gd3JvdGU6DQo+IE9uIDgvMjgvMjMgNToxOCBB
TSwgR2F2cmlsb3YgSWxpYSB3cm90ZToNCj4+IFRoZSAnc3RhdGUtPmltJyB2YWx1ZSB3aWxsIGFs
d2F5cyBiZSBub24temVybyBhZnRlcg0KPj4gdGhlICd3aGlsZScgc3RhdGVtZW50LCBzbyB0aGUg
Y2hlY2sgY2FuIGJlIHJlbW92ZWQuDQo+Pg0KPj4gRm91bmQgYnkgSW5mb1RlQ1Mgb24gYmVoYWxm
IG9mIExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXINCj4+IChsaW51eHRlc3Rpbmcub3JnKSB3aXRo
IFNWQUNFLg0KPj4NCj4+IEZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikN
Cj4+IFNpZ25lZC1vZmYtYnk6IEdhdnJpbG92IElsaWEgPElsaWEuR2F2cmlsb3ZAaW5mb3RlY3Mu
cnU+DQo+PiAtLS0NCj4+ICAgbmV0L2lwdjYvbWNhc3QuYyB8IDIgLS0NCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL25ldC9pcHY2L21jYXN0
LmMgYi9uZXQvaXB2Ni9tY2FzdC5jDQo+PiBpbmRleCA3MTRjZGM5ZTJiOGUuLjk2OTYzNDNkMGFh
OSAxMDA2NDQNCj4+IC0tLSBhL25ldC9pcHY2L21jYXN0LmMNCj4+ICsrKyBiL25ldC9pcHY2L21j
YXN0LmMNCj4+IEBAIC0zMDEzLDggKzMwMTMsNiBAQCBzdGF0aWMgc3RydWN0IGlwNl9zZl9saXN0
ICppZ21wNl9tY2ZfZ2V0X25leHQoc3RydWN0IHNlcV9maWxlICpzZXEsIHN0cnVjdCBpcDZfcw0K
Pj4gICAJCQkJY29udGludWU7DQo+PiAgIAkJCXN0YXRlLT5pbSA9IHJjdV9kZXJlZmVyZW5jZShz
dGF0ZS0+aWRldi0+bWNfbGlzdCk7DQo+PiAgIAkJfQ0KPj4gLQkJaWYgKCFzdGF0ZS0+aW0pDQo+
PiAtCQkJYnJlYWs7DQo+PiAgIAkJcHNmID0gcmN1X2RlcmVmZXJlbmNlKHN0YXRlLT5pbS0+bWNh
X3NvdXJjZXMpOw0KPj4gICAJfQ0KPj4gICBvdXQ6DQo+IA0KPiBhZ3JlZSB0aGUgY2hlY2sgaXMg
bm90IG5lZWRlZCwgYnV0IEkgYWxzbyBiZWxpZXZlIGl0IGRvZXMgbm90IG5lZWQgdG8gYmUNCj4g
YmFja3BvcnRlZC4gU2luY2UgbmV0LW5leHQgaXMgY2xvc2VkLCByZXN1Ym1pdCBhZnRlciA5LzEx
Lg0KPiANCj4gLS0NCj4gcHctYm90OiBkZWZlcg0KDQpJJ2xsIHJlc2VuZCBpdCBhZnRlciA5LzEx
Lg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IQ0K
