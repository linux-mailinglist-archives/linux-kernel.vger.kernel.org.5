Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0711C8081B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377822AbjLGHRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGHRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:17:17 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47961193;
        Wed,  6 Dec 2023 23:17:21 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B77G47p84188847, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B77G47p84188847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 15:16:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 7 Dec 2023 15:16:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 7 Dec 2023 15:16:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 7 Dec 2023 15:16:04 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Yang Yingliang" <yangyingliang@huawei.com>,
        =?utf-8?B?UmljYXJkbyBDYcOxdWVsbw==?= 
        <ricardo.canuelo@collabora.com>, Roy Luo <royluo@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] usb: core: add phy notify connect and disconnect
Thread-Topic: [PATCH v3 4/4] usb: core: add phy notify connect and disconnect
Thread-Index: AQHaE5mWy2ByyOGB8E2Gd3l7rr7vdLCdakMA//+hewCAAIbuYA==
Date:   Thu, 7 Dec 2023 07:16:04 +0000
Message-ID: <fa4041d2a2ac4d6498938bfa10106dc5@realtek.com>
References: <20231110054738.23515-1-stanley_chang@realtek.com>
 <20231110054738.23515-4-stanley_chang@realtek.com>
 <4736a6933f3546c48f24a635c15a5e20@realtek.com>
 <2023120724-herring-filled-c32e@gregkh>
In-Reply-To: <2023120724-herring-filled-c32e@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KT2theS4NCkkgd2lsbCByZXN1Ym1pdCB0aGVzZSBwYXRjaGVzLg0KDQpUaGFu
a3MsDQpTdGFubGV5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogVGh1
cnNkYXksIERlY2VtYmVyIDcsIDIwMjMgMzoxMSBQTQ0KPiBUbzogU3RhbmxleSBDaGFuZ1vmmIzo
grLlvrddIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiBDYzogVmlub2QgS291bCA8dmtv
dWxAa2VybmVsLm9yZz47IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz47IEtpc2hvbg0K
PiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkBrZXJuZWwub3JnPjsgR2VlcnQgVXl0dGVyaG9ldmVu
DQo+IDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBKaW5qaWUgUnVhbg0KPiA8cnVhbmppbmppZUBodWF3ZWkuY29tPjsgQWxhbiBTdGVybiA8
c3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdT47IFlhbmcNCj4gWWluZ2xpYW5nIDx5YW5neWluZ2xp
YW5nQGh1YXdlaS5jb20+OyBSaWNhcmRvIENhw7F1ZWxvDQo+IDxyaWNhcmRvLmNhbnVlbG9AY29s
bGFib3JhLmNvbT47IFJveSBMdW8gPHJveWx1b0Bnb29nbGUuY29tPjsgSGVpa2tpDQo+IEtyb2dl
cnVzIDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA0LzRdIHVzYjogY29yZTog
YWRkIHBoeSBub3RpZnkgY29ubmVjdCBhbmQgZGlzY29ubmVjdA0KPiANCj4gDQo+IEV4dGVybmFs
IG1haWwuDQo+IA0KPiANCj4gDQo+IE9uIFRodSwgRGVjIDA3LCAyMDIzIGF0IDA0OjUwOjEwQU0g
KzAwMDAsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4gPiBIaSBHcmVnLA0KPiA+
DQo+ID4gUGxlYXNlIGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2guDQo+IA0KPiBUaGlzIHNlcmllcyBp
cyBnb25lIGZyb20gbXkgdHJlZSBhcyBvdGhlcnMgcmV2aWV3ZWQgaXQgYW5kIGFza2VkIGZvciBj
aGFuZ2VzLg0KPiBJZiB5b3UgdGhpbmsgdGhvc2UgY2hhbmdlcyBhcmUgbm90IG5lZWRlZCwgZmVl
bCBmcmVlIHRvIHJlc2VuZCBpdCB3aXRoIGFuDQo+IGV4cGxhbmF0aW9uIG9mIHdoeSB0aGF0IGlz
IHNvLg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
