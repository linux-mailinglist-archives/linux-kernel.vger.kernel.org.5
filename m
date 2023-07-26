Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3E762EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGZH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGZH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:57:29 -0400
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B89A7687;
        Wed, 26 Jul 2023 00:49:35 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.60] ) by
 ajax-webmail-mail-app4 (Coremail) ; Wed, 26 Jul 2023 15:49:02 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.60]
Date:   Wed, 26 Jul 2023 15:49:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Nikolay Aleksandrov" <razor@blackwall.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, idosch@nvidia.com, lucien.xin@gmail.com,
        liuhangbin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
References: <20230725055706.498774-1-linma@zju.edu.cn>
 <6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHjAnvz8BkdjkkCg--.52320W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIIEmTAePoLZAAAsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmlrb2xheSwKCj4gCj4gUGF0Y2ggbG9va3MgZ29vZCBub3csIHlvdSBzaG91bGQgcHJvYmFi
bHkgcmVtb3ZlIHRoZSBleHRyYSBjaGVja3MgZG9uZQo+IGJ5IGVhY2ggZHJpdmVyIHRoYXQgYXJl
IG5vdyB1bm5lY2Vzc2FyeSAobmV0LW5leHQgbWF0ZXJpYWwpLiBBcyBIYW5nYmluCj4gY29tbWVu
dGVkIHlvdSBzaG91bGQgdGFyZ2V0IHRoaXMgZml4IGF0IC1uZXQsIHdpdGggdGhhdDoKPiAKPiBB
Y2tlZC1ieTogTmlrb2xheSBBbGVrc2FuZHJvdiA8cmF6b3JAYmxhY2t3YWxsLm9yZz4KCkNvb2ws
IEkgYWdyZWUgd2l0aCBIYW5nYmluIHRoYXQgYW5vdGhlciBwYXRjaCB3aGljaCByZW1vdmVzIHRo
ZSByZWR1bmRhbnQKY2hlY2tzIGluIGRyaXZlciBpcyBuZWVkZWQuCgpCdXQgSSBoYXZlIGEgc2lt
cGxlIHF1ZXN0aW9uLiBJIHdpbGwgc2VuZCB0aGlzIHBhdGNoIHRvIG5ldCBvbmUgYW5kIGFub3Ro
ZXIKdG8gbmV0LW5leHQgb25lLiBIb3cgY2FuIEkgZW5zdXJlIHRoZSBsYXR0ZXIgb25lIGRlcGVu
ZHMgb24gdGhlIGZvcm1lciBvbmU/Ck9yIHNob3VsZCBJIHNlbmQgYSBwYXRjaCBzZXJpZXMgdG8g
bmV0LW5leHQgdGhhdCBjb250YWlucyB0aGUgZm9ybWVyIG9uZSA6KQooSSBjdXJyZW50bHkgY2hv
b3NlIHRoZSBtZXRob2QgMiBhbmQgcGxlYXNlIGxldCBtZSBrbm93IGlmIEkgZG8gdGhpcyB3cm9u
ZykKClJlZ2FyZHMKTGlu
