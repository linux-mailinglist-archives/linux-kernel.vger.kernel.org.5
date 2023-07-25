Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D787609B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGYFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGYFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:48:27 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49613BC;
        Mon, 24 Jul 2023 22:48:22 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.62] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 25 Jul 2023 13:47:55 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.62]
Date:   Tue, 25 Jul 2023 13:47:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Hangbin Liu" <liuhangbin@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
        lucien.xin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZL9hWEs4GNhm8xVY@Laptop-X1>
References: <20230725022151.417450-1-linma@zju.edu.cn>
 <ZL9hWEs4GNhm8xVY@Laptop-X1>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <164730e5.e7cf6.1898b96fb76.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgB3fxcLYr9kG2APCg--.50759W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQHEmS-J3oE-QADsu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSGFuZ2JpbiwKCj4gCj4gSWYgd2UgZ290IGF0dHIgdElGTEFfQlJJREdFX0ZMQUdTIGZp
cnN0LCBpdCB3aWxsIGJyZWFrIGhlcmUgYW5kIG5vdCBjaGVjawo+IHRoZSBsYXRlciBJRkxBX0JS
SURHRV9NT0RFLgo+IAo+ID4gKwo+ID4gKwkJCWlmIChubGFfdHlwZShhdHRyKSA9PSBJRkxBX0JS
SURHRV9NT0RFKSB7Cj4gPiArCQkJCWlmIChubGFfbGVuKGF0dHIpIDwgc2l6ZW9mKHUxNikpCj4g
PiArCQkJCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsJCQl9Cj4gPiAgCQl9Cj4gPiAgCX0KPiAKPiBU
aGFua3MKPiBIYW5nYmluCgpZZWFoLCB5b3UgYXJlIHNvb29vIHJpZ2h0LCB3aWxsIGZpeCB0aGlz
IEFTQVAKClJlZ2FyZHMKTGluCg==
