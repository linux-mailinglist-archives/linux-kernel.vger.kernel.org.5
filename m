Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C08809DED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjLHINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLHINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:13:22 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FF491712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:13:26 -0800 (PST)
Received: from alexious$zju.edu.cn ( [124.90.104.65] ) by
 ajax-webmail-mail-app3 (Coremail) ; Fri, 8 Dec 2023 16:12:59 +0800
 (GMT+08:00)
X-Originating-IP: [124.90.104.65]
Date:   Fri, 8 Dec 2023 16:12:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   alexious@zju.edu.cn
To:     "Suman Ghosh" <sumang@marvell.com>
Cc:     "Jakub Kicinski" <kuba@kernel.org>,
        "Chris Snook" <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Simon Horman" <horms@kernel.org>,
        "Yuanjun Gong" <ruc_gongyuanjun@163.com>,
        "Jie Yang" <jie.yang@atheros.com>,
        "Jeff Garzik" <jgarzik@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [EXT] [PATCH] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <SJ0PR18MB5216F502703DA2B49B013BC7DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231207143822.3358727-1-alexious@zju.edu.cn>
 <SJ0PR18MB52161F73B08DA547F7A8F3B8DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <20231207094220.77019dd0@kernel.org>
 <SJ0PR18MB5216F502703DA2B49B013BC7DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <54c0af4f.28cff.18c487cab21.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgBnb3ML0HJl3TOWAA--.20190W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgMDAGVxlxRG4AABsy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+T24gVGh1LCA3IERlYyAyMDIzIDE3OjA4OjE1ICswMDAwIFN1bWFuIEdob3NoIHdyb3RlOgo+
ID4+ID4rCQlrZnJlZSh0eF9yaW5nLT50eF9idWZmZXIpOwo+ID4+Cj4gPj4gW1N1bWFuXSBJIHRo
aW5rIHdlIHNob3VsZCBkbyB0eF9yaW5nLT50eF9idWZmZXIgPSBOVUxMIGFsc28sIHRvIGF2b2lk
Cj4gPnVzZSBhZnRlciBmcmVlPwo+ID4KPiA+SXQncyB1cCB0byB0aGUgZHJpdmVyLiBTb21lIG1h
eSBjYWxsIHRoYXQgZGVmZW5zaXZlIHByb2dyYW1taW5nLgo+IFtTdW1hbl0gQWdyZWUuIEkgcG9p
bnRlZCBpdCBvdXQgc2luY2UgdGhpcyBkcml2ZXIgaXMgdXNpbmcgdGhpcyBhcHByb2FjaCBhdCBv
dGhlciBwbGFjZXMuIEJ1dCBzdXJlLCBpdCBpcyB1cCB0byBaaGlwZW5nLgoKW1poaXBlbmddIEkg
dGhpbmsgU3VtYW4ncyBzdWdnZXN0aW9uIGlzIHZhbHVhYmxlLCBpdCBwcmV2ZW50cyBwb3RpZW50
aWFsIHVzZS1hZnRlci1mcmVlIGFuZCBpcyBjb25zaXN0ZW50IHdpdGggb3RoZXIgZnJlZSBvcGVy
YXRpb25zIGluIHRoZSBzYW1lIG1vZHVsZS4=
