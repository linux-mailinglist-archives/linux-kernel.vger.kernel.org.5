Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A447DCB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjJaLLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjJaLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:11:18 -0400
Received: from hmat.qianxin.com (hmat.qianxin.com [220.181.41.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C33C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:10:47 -0700 (PDT)
Received: from hmat.qianxin.com (unknown [10.44.121.89])
        by hmat.qianxin.com (SkyGuard) with ESMTPS id 4SKS9c5kS5z2LZp4;
        Tue, 31 Oct 2023 19:10:44 +0800 (CST)
Received: from qax-bjmail06.ESG.360ES.CN
 (2402:d040:0:8425:2849:52e7:3abe:7096) by qax-bjmail03.ESG.360ES.CN
 (2402:d040:0:8425:dab:9a82:67c8:970d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 31 Oct 2023 19:10:45 +0800
Received: from qax-bjmail06.ESG.360ES.CN ([fe80::2849:52e7:3abe:7096]) by
 qax-bjmail06.ESG.360ES.CN ([fe80::2849:52e7:3abe:7096%5]) with mapi id
 15.01.2507.031; Tue, 31 Oct 2023 19:10:45 +0800
From:   =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
To:     Marco Elver <elver@google.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "secalert@redhat.com" <secalert@redhat.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: A null-ptr crash in linux-6.4 usb driver
Thread-Topic: A null-ptr crash in linux-6.4 usb driver
Thread-Index: AdoL6r5FKpnYmf2vSnCXUQyf7Z0zPw==
Date:   Tue, 31 Oct 2023 11:10:45 +0000
Message-ID: <b60e7642b76b464ca4acddcba5329a3d@qianxin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.110.51.215]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T0ssIEkgdG9vayBhIGxvb2sgYW5kIGl0IG1heSBiZSB0aGUgc2FtZSByZWFzb24gdGhhdCBjYXVz
ZWQgdGhlIGNyYXNoLGJ1dCBJIGp1c3QgdGVzdGVkIGl0IG9uIHRoZSBsYXRlc3QgTGludXgtNi42
LGl0IGFsc28gY3Jhc2hlZCB3aGlsZSBydW5uaW5nIHRoZSByZXByb2R1Y2VyLGl0IGRpZG4ndCBi
ZSBmaXhlZC4NCg0KPiBMb29rcyBsaWtlIHRoaXMgcmVwb3J0IGZyb20gb3ZlciBhIHllYXIgYWdv
Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMDAwMDAwMDAwMDAwYmI3ZjFjMDVkYTI5
YjYwMUBnb29nbGUuY29tLw0KDQoNCkl0IHNlZW1zIHRoYXQgdGhpcyBpc3N1ZSB3aWxsIG5vdCBi
ZSBmaXhlZCBiZWNhdXNlIGl0IG11c3QgcmVseSBvbiBmYXVsdC1pbmplY3QsIHJpZ2h0Pw0KSSBh
bSBub3QgZmFtaWxpYXIgd2l0aCB0aGlzIHBhcnQgb2YgdGhlIGtlcm5lbCBjb2RlLCBhbmQgaWYg
Zml4aW5nIHRoaXMgaXNzdWUgaXMgdmVyeSBkaWZmaWN1bHQsIEkgbWF5IG5vdCBiZSBhYmxlIHRv
IHByb3ZpZGUgYW4gdXNlZnVsIHBhdGNoLHNvcnJ5Lg0KDQo+IEdyZWF0LCBwbGVhc2Ugc3VibWl0
IGEgcGF0Y2ggdG8gcmVzb2x2ZSB0aGlzIGFuZCB3ZSB3aWxsIGJlIGdsYWQgdG8gcmV2aWV3IGl0
Lg0KDQo=
