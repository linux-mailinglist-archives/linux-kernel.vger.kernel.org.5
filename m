Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0206075E0F4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGWJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:34:04 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A458E5E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:33:59 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.59] ) by
 ajax-webmail-mail-app3 (Coremail) ; Sun, 23 Jul 2023 17:33:54 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.59]
Date:   Sun, 23 Jul 2023 17:33:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230723050656-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgCn4gED9LxkLvqACw--.43663W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIFEmS8hHkFjgABs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
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

SGVsbG8gTWljaGFlbCwKCj4gPgo+ID4gVGhlIHZkcGFfbmxfcG9saWN5IHN0cnVjdHVyZSBpcyB1
c2VkIHRvIHZhbGlkYXRlIHRoZSBubGF0dHIgd2hlbiBwYXJzaW5nCj4gPiB0aGUgaW5jb21pbmcg
bmxtc2cuIEl0IHdpbGwgZW5zdXJlIHRoZSBhdHRyaWJ1dGUgYmVpbmcgZGVzY3JpYmVkIHByb2R1
Y2VzCj4gPiBhIHZhbGlkIG5sYXR0ciBwb2ludGVyIGluIGluZm8tPmF0dHJzIGJlZm9yZSBlbnRl
cmluZyBpbnRvIGVhY2ggaGFuZGxlcgo+ID4gaW4gdmRwYV9ubF9vcHMuCj4gPiAKPiA+IFRoYXQg
aXMgdG8gc2F5LCB0aGUgbWlzc2luZyBwYXJ0IGluIHZkcGFfbmxfcG9saWN5IG1heSBsZWFkIHRv
IGlsbGVnYWwKPiA+IG5sYXR0ciBhZnRlciBwYXJzaW5nLCB3aGljaCBjb3VsZCBsZWFkIHRvIE9P
QiByZWFkIGp1c3QgbGlrZSBDVkUtMjAyMy0zNzczLgo+IAo+IEhtbS4KPiAKPiBodHRwczovL2N2
ZS5taXRyZS5vcmcvY2dpLWJpbi9jdmVuYW1lLmNnaT9uYW1lPUNWRS0yMDIzLTM3NzMKPiAKPiAq
KiBSRVNFUlZFRCAqKiBUaGlzIGNhbmRpZGF0ZSBoYXMgYmVlbiByZXNlcnZlZCBieSBhbiBvcmdh
bml6YXRpb24gb3IgaW5kaXZpZHVhbCB0aGF0IHdpbGwgdXNlIGl0IHdoZW4gYW5ub3VuY2luZyBh
IG5ldyBzZWN1cml0eSBwcm9ibGVtLiBXaGVuIHRoZSBjYW5kaWRhdGUgaGFzIGJlZW4gcHVibGlj
aXplZCwgdGhlIGRldGFpbHMgZm9yIHRoaXMgY2FuZGlkYXRlIHdpbGwgYmUgcHJvdmlkZWQuCj4g
CgpZZWFoLCB0aGF0IENWRSBpcyBhc3NpZ25lZCB3aGlsZSBmaXggbm90IHVwc3RyZWFtIHlldC4g
RllJLCB0aGUgZml4IGlzIHBlbmRpbmcgdG9vLiAKU2VlLCBodHRwczovL21hcmMuaW5mby8/bD1s
aW51eC1rZXJuZWwmbT0xNjkwMDk4MDExMzEwNTgmdz0yLgoKCj4gCj4gPiBUaGlzIHBhdGNoIGFk
ZHMgdGhyZWUgbWlzc2luZyBubGFfcG9saWN5IHRvIGF2b2lkIHN1Y2ggYnVncy4KPiA+IAo+ID4g
Rml4ZXM6IDkwZmVhNWE4MDBjMyAoInZkcGE6IGRldmljZSBmZWF0dXJlIHByb3Zpc2lvbmluZyIp
Cj4gPiBGaXhlczogMTNiMDBiMTM1NjY1ICgidmRwYTogQWRkIHN1cHBvcnQgZm9yIHF1ZXJ5aW5n
IHZlbmRvciBzdGF0aXN0aWNzIikKPiA+IEZpeGVzOiBhZDY5ZGQwYmYyNmIgKCJ2ZHBhOiBJbnRy
b2R1Y2UgcXVlcnkgb2YgZGV2aWNlIGNvbmZpZyBsYXlvdXQiKQo+ID4gU2lnbmVkLW9mZi1ieTog
TGluIE1hIDxsaW5tYUB6anUuZWR1LmNuPgo+IAo+IEkgZG9uJ3Qga25vdyBob3cgT09CIHRyaWdn
ZXJzIGJ1dCB0aGlzIGR1cGxpY2F0aW9uIGlzIHByb2JsZW1hdGljIEkKPiB0aGluazogd2UgYXJl
IGxpa2VseSB0byBmb3JnZXQgYWdhaW4gaW4gdGhlIGZ1dHVyZS4gIElzbid0IHRoZXJlIGEgd2F5
Cj4gdG8gYmxvY2sgZXZlcnl0aGluZyB0aGF0IGlzIG5vdCBsaXN0ZWQ/Cj4gCgpTdXJlLCB0aGF0
IGlzIGFub3RoZXIgdW5kZXJnb2luZyB0YXNrIEknbSB3b3JraW5nIG9uLiBJZiB0aGUgbmxhdHRy
IGlzIHBhcnNlZCB3aXRoCk5MX1ZBTElEQVRFX1VOU1BFQywgYW55IGZvcmdvdHRlbiBubGF0dHIg
d2lsbCBiZSByZWplY3RlZCwgdGhlcmVmb3JlICh3aGljaCBpcyB0aGUgZGVmYXVsdApmb3IgbW9k
ZXJuIG5sYV9wYXJzZSkuIFRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB0aGVyZSBhcmUgc3RpbGwg
Y29uc3VtZXJzIGZvcgpubGFfcGFyc2VfZGVwcmVjYXRlZC4gQW5kIHdlIGNhbm5vdCBzaW1wbHkg
cmVwbGFjZSBhbGwgKl9kZXByZWNhdGVkIHRvIG1vZGVybiBvbmVzCmFzIGl0IG1heSBicmVhayB1
c2Vyc3BhY2UuIFNlZSB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gOGNiMDgxNzQ2YzAzICgibmV0bGlu
azogbWFrZQp2YWxpZGF0aW9uIG1vcmUgY29uZmlndXJhYmxlIGZvciBmdXR1cmUgc3RyaWN0bmVz
cyIpCgpJIGJlbGlldmUgaWYgd2UgY2FuIGRvIGVub3VnaCB0ZXN0IGFnYWluc3QgdXNlcnNwYWNl
IHRvb2xjaGFpbnMsIHdlIGNhbiB1bHRpbWF0ZWx5CnVwZ3JhZGUgYWxsICpfZGVwcHJlY2F0ZWQg
cGFyc2VycyB0byBtb2Rlcm4gb25lcywgd2hpY2ggY29zdHMgdGltZSBhbmQgZWZmb3J0cy4gVGhp
cwpzZW5kIHBhdGNoIGlzIGEgbXVjaCBzaW1wbGVyIChidXQgdGVtcG9yYXJ5KSBzb2x1dGlvbiBm
b3Igbm93LgoKUmVnYXJkcwpMaW4K
