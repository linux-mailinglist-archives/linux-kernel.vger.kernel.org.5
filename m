Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40397761E29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjGYQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjGYQNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:13:00 -0400
Received: from m13148.mail.163.com (m13148.mail.163.com [220.181.13.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3B6897;
        Tue, 25 Jul 2023 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=kuZoYAtGYMfrsgTMi+eUzJm+f9IAYVHs5vZy8nJyhGY=; b=Q
        13BnJMXao/BTG65GwyhdLxzFy2UiLK6z2D2DuwpLjyEO5v3D1RWZY20lMAzX7z0B
        mmUzboklBN7P6wn7+mB4va/geVt93T5Sehugu1O3nwZy4IvJHSuFxOBaSsI4E9NV
        BsxjIeyi6QDeSdtgjElIuD/tQykpN9mYkVNN5Tjf20=
Received: from 18500469033$163.com ( [114.253.21.2] ) by
 ajax-webmail-wmsvr148 (Coremail) ; Wed, 26 Jul 2023 00:11:48 +0800 (CST)
X-Originating-IP: [114.253.21.2]
Date:   Wed, 26 Jul 2023 00:11:48 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Oliver Neukum" <oneukum@suse.com>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] USB: add usbfs ioctl to get specific
 superspeedplus rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <2023072526-reissue-uplifting-5674@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
 <ca4ad735-5605-3fd4-c903-fe5b039cf6a8@suse.com>
 <3018cd33.7ee4.1898d7e4798.Coremail.18500469033@163.com>
 <2023072526-reissue-uplifting-5674@gregkh>
X-NTES-SC: AL_QuySAv+bvk0r7imRZ+kXkkYVgew6WsC4vf4k3IReOps0pyzQ9Acpdn16Nmnp98KiKg2IshqKYQZt6etDeZd9UamCHA8KPVUAy7SZeAKSturn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6be59e4e.8166.1898dd22d84.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lMGowACXWDNF9L9ksn8JAA--.10506W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBURe3y1aEFAiwKwABsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAyMy0wNy0yNSAyMzoxMjowMSwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4gd3JvdGU6Cj5PbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAxMDo0MDoxMFBNICswODAwLCBE
aW5neWFuIExpIHdyb3RlOgo+PiAKPj4gQXQgMjAyMy0wNy0yNSAyMjowODo0NCwgIk9saXZlciBO
ZXVrdW0iIDxvbmV1a3VtQHN1c2UuY29tPiB3cm90ZToKPj4gPk9uIDI1LjA3LjIzIDE1OjU0LCBE
aW5neWFuIExpIHdyb3RlOgo+PiA+Cj4+ID4+IElmIHdlIGNhbid0ICJkZXByZWNhdGUiIGlvY3Rs
cywgY2FuIHdlIGNoYW5nZSB0aGUgcmV0dXJuZWQgY29udGVudHMgb2YgZXhpc3Rpbmcgb25lcz8K
Pj4gPgo+PiA+Tm8uIEFic29sdXRlbHkgbm90LiBUaGF0IGlzIHRvdGFsbHkgdW5hY2NlcHRhYmxl
LiBJdCB3b3VsZCBiZSBtdWNoCj4+ID53b3JzZSB0aGFuIGp1c3QgcmVtb3ZpbmcgdGhlIHN1cHBv
cnQuCj4+ID4KPj4gPglSZWdhcmRzCj4+ID4JCU9saXZlcgo+PiAKPj4gR290IGl0LCBJIGd1ZXNz
IHRoaXMgaXMgZm9yIGJhY2t3YXJkLWNvbXBhdGliaWxpdHkuCj4+IAo+PiBJIGFsc28gaGF2ZSBh
bm90aGVyIHRob3VnaHQuIFVTQkRFVkZTX0NPTk5JTkZPX0VYIGlzIGtpbmQgb2Ygc3BlY2lhbCBh
bmQKPj4gdXNlZCB0byByZXRyaWV2ZSBjb250ZW50cyBvZiB2YXJpYWJsZSBsZW5ndGguIElmIHlv
dSBjaGVjayBwcm9jX2Nvbm5pbmZvX2V4KCksCj4+IEkgdGhpbmsgbWF5YmUgd2UgY2FuIGFwcGVu
ZCBhIG5ldyBtZW1iZXIgdG8gInN0cnVjdCB1c2JkZXZmc19jb25uaW5mb19leCIKPj4gd2l0aG91
dCBicmVha2luZyBiYWNrd2FyZC1jb21wYXRpYmlsaXR5Lgo+Cj5Ib3cgZXhhY3RseSB3b3VsZCB0
aGF0IHdvcms/ICBSZW1lbWJlciwgbmV3IGtlcm5lbHMgc3RpbGwgbmVlZCB0byB3b3JrCj53aXRo
IG9sZCB1c2Vyc3BhY2UgY29kZS4KPgo+Z3JlZyBrLWgKCkluIHByb2NfY29ubmluZm9fZXgoKSwg
dGhlIG51bWJlciBvZiByZXR1cm5lZCBieXRlcyBpcyBkZXRlcm1pbmVkIGJ5CnRoZSBzbWFsbGVy
IG51bWJlciBiZXR3ZWVuIHNpemVvZihzdHJ1Y3QgdXNiZGV2ZnNfY29ubmluZm9fZXgpIGFuZCBh
CnVzZXIgc3BlY2lmaWVkIHNpemUuIFNvIGlmIHdlIG9ubHkgYXBwZW5kIG5ldyBtZW1iZXJzIHRv
IHRoZSBlbmQgb2YKc3RydWN0IHVzYmRldmZzX2Nvbm5pbmZvX2V4LCBpdCB3b24ndCBpbXBhY3Qg
dGhlIGJ5dGVzIGluIHRoZSBiZWdpbm5pbmcuCgpGb3IgZXhhbXBsZSwgY3VycmVudCBzaXplb2Yo
c3RydWN0IHVzYmRldmZzX2Nvbm5pbmZvX2V4KSBpcyAyNCBieXRlcy4KTGV0J3MgYXNzdW1lIHRo
ZXJlIGlzIGFscmVhZHkgc29tZSBjb2RlIHVzaW5nIGlvY3RsIFVTQkRFVkZTX0NPTk5JTkZPX0VY
CmFuZCByZXF1ZXN0aW5nIGEgZnVsbCBzaXplLCB3aGljaCBpcyAyNCBieXRlcy4gTm93IHdlIGFw
cGVuZCBhIG5ldyBfX3UzMgptZW1iZXIgY2FsbGVkIHNzcF9yYXRlIGluIHRoZSBlbmQgb2Ygc3Ry
dWN0IHVzYmRldmZzX2Nvbm5pbmZvX2V4LiBGb3IgdGhlIG9sZApjb2RlLCB0aGUgbWVhbmluZyBv
ZiB0aGUgYmVnaW5uaW5nIDI0IGJ5dGVzIGlzIHN0aWxsIHRoZSBzYW1lLiBCdXQgZm9yIG5ldyBj
b2RlLAp3ZSBjYW4gbm93IHJlcXVlc3QgYSBmdWxsIHNpemUgb2YgMjggYnl0ZXMuCgoKUmVnYXJk
cywKRGluZ3lhbiAK
