Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC17603A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGYANE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGYANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:13:02 -0400
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3329D115;
        Mon, 24 Jul 2023 17:12:57 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.162.208.50] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 25 Jul 2023 08:12:42 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.208.50]
Date:   Tue, 25 Jul 2023 08:12:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        ast@kernel.org, martin.lau@kernel.org, yhs@fb.com,
        andrii@kernel.org, void@manifault.com, houtao1@huawei.com,
        laoar.shao@gmail.com, inwardvessel@gmail.com, kuniyu@amazon.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230724151507.6b725396@kernel.org>
References: <20230723075452.3711158-1-linma@zju.edu.cn>
 <20230724151507.6b725396@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4e56edca.e264e.1898a641853.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBXX4t6E79kW1WACg--.28456W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMHEmS91fkWAgAAs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFrdWIsCgo+IAo+IFlvdSBjYW4gbW92ZSB0aGlzIGNoZWNrIGVhcmxpZXIsIHdoZW4gdGhl
IGF0dHJpYnV0ZXMgYXJlIGdldHRpbmcKPiBjb3VudGVkLiBUaGF0IHdheSB3ZSBjYW4gYXZvaWQg
dGhlIGFsbG9jL2ZyZWUgb24gZXJyb3IuCgpHb29kIHBvaW50LCB3aWxsIGZpeCB0aGF0IGFuZCBw
cmVwYXJlIGFub3RoZXIgcGF0Y2gKClRoYW5rcwpMaW4=
