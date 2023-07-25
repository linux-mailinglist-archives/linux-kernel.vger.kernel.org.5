Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B870761ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjGYN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjGYNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:55:57 -0400
Received: from m1344.mail.163.com (m1344.mail.163.com [220.181.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CDBE268D;
        Tue, 25 Jul 2023 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=w1BqlOtQMbujMWKorncDYQCEF9xZSLq3MzcjG+h0oFM=; b=q
        M6fTlEnxz8JgHrmK4yb7MEIg+RzjAMzgB62b2HPBSKg7dfSxj3dRiUjaS7qQsq/Z
        3kzvu/0kKzjmXkK4F8u+Z0hskIy0bEPVg2vj2q563OLcnBDiXaTK0fKK9E9Q9Ub/
        Q8KxsyIGSRCDsY2V6jGvekLdk5VX8VjBUbMczynetE=
Received: from 18500469033$163.com ( [114.253.21.2] ) by
 ajax-webmail-wmsvr44 (Coremail) ; Tue, 25 Jul 2023 21:54:26 +0800 (CST)
X-Originating-IP: [114.253.21.2]
Date:   Tue, 25 Jul 2023 21:54:26 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Oliver Neukum" <oneukum@suse.com>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <2023072546-denture-half-5ceb@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
X-NTES-SC: AL_QuySAv6SvEot4CObZOkXkkYVgew6WsC4vf4k3IReOps0hinw3BwPUnVhIUbWwMCGKhyeuhKKTBxk2sVbQaJjZ4KWP/goNaEbiKM6XasjvmCR
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LMGowAD3_48S1L9kcJ8JAA--.4908W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBZxK3y1et-riUWQAAs4
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

CkF0IDIwMjMtMDctMjUgMjE6MjQ6MzIsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMTE6NDc6NDlBTSArMDIwMCwg
T2xpdmVyIE5ldWt1bSB3cm90ZToKPj4gT24gMjEuMDcuMjMgMTY6NTEsIEdyZWcgS0ggd3JvdGU6
Cj4+IAo+PiA+ID4gMS4gQnkgc2F5aW5nICJiZSBkb2N1bWVudGVkIHNvbWV3aGVyZSIsIGRvIHlv
dSBtZWFuIHRoZXJlIGlzIGV4dHJhCj4+ID4gPiAgICAgIGRvY3VtZW50YXRpb24gd29yayB3aGlj
aCBuZWVkcyB0byBiZSBkb25lPyBTb3JyeSB0aGF0IEkgbWlzc2VkIHRoaXMKPj4gPiA+ICAgICAg
cGFydCBzaW5jZSBpdCdzIHRoZSBmaXJzdCB0aW1lIGZvciBtZSB0byB3b3JrIG9uIGEga2VybmVs
IHBhdGNoLgo+PiA+IAo+PiA+IEl0IG5lZWRzIHRvIGJlIGRvY3VtZW50ZWQgc29tZXdoZXJlLCBv
dGhlcndpc2Ugbm8gb25lIGtub3dzIGhvdyB0byB1c2UKPj4gPiBpdC4KPj4gPiAKPj4gPiA+IDIu
IElmIG5vIGVycm9yLCByZXR1cm5lZCB2YWx1ZXMgYXJlICJlbnVtIHVzYl9zc3BfcmF0ZSIgZGVm
aW5lZCBpbiBpbmNsdWRlL2xpbnV4L3VzYi9jaDkuaAo+PiA+ID4gMy4gc3NwIHJhdGUgaXMgb25s
eSB2YWxpZCBmb3Igc3VwZXJzcGVlZHBsdXMuIEZvciBvdGhlciBzcGVlZHMsIGl0IHNob3VsZCBi
ZQo+PiA+ID4gICAgICBVU0JfU1NQX0dFTl9VTktOT1dOLgo+PiA+IAo+PiA+IE9rLCB0aGF0IHNo
b3VsZCBiZSBkb2N1bWVudGVkLgo+PiAKPj4gRG9jdW1lbnRhdGlvbiB3b3VsZCBiZSBnb29kLgo+
PiBXaGVyZSBzaG91bGQgaXQgZ28sIHRob3VnaD8gVGhlc2UgZW51bXMgYXJlIHBhcnQgb2YgdGhl
IHVhcGkKPj4gaGllcmFyY2h5LiBOb3csIGRvY3VtZW50YXRpb24gZm9yIHVhcGkgd291bGQgYmUg
Z29vZCwgYnV0IHdlCj4+IHNob3VsZCBub3QgbWl4IGl0IHdpdGggZG9jdW1lbnRhdGlvbiBmb3Ig
aW9jdGwKPj4gVGhhdCBpcyBpZiBhbiBpb2N0bCB1c2VzIGFuIGVudW0gb3V0IG9mIHVhcGkgaXQg
bmVlZHMgdG8gYmUKPj4gZXhwbGljaXRseSBtZW50aW9uZWQgYnkgbmFtZSwgYnV0IGRvY3VtZW50
aW5nIHRoZSBzZW1hbnRpY3MKPj4gb2YgdGhlIGVudW0gX3RoZXJlXyB3b3VsZCBiZSB3cm9uZy4K
Pj4gCj4+ID4gCj4+ID4gPiA0LiBJIGZvdW5kIGluIGxpYnVzYiwgdGhlcmUgYXJlIHR3byB3YXlz
IHRvIGdldCBzcGVlZCB2YWx1ZSBmb3IgYSBkZXZpY2UuCj4+ID4gPiAgICAgIE9uZSB3YXkgaXMg
dmlhIHN5c2ZzLCB3aGljaCBoYXMgc3VwcG9ydGVkIDIwR2JwcyBub3cuIEFub3RoZXIgd2F5IGlz
Cj4+ID4gPiAgICAgIHRvIHVzZSBpb2N0bCBVU0JERVZGU19HRVRfU1BFRUQuIFRoaXMgaXMgd2hl
biBJIGZvdW5kIHRoaXMgaW9jdGwgY2FuIG9ubHkKPj4gPiA+ICAgICAgcmV0dXJuIFVTQl9TUEVF
RF9TVVBFUl9QTFVTIGF0IG1vc3QsIGl0IGNhbm5vdCBkZXRlcm1pbmUgY3VycmVudCBzc3AgcmF0
ZQo+PiA+ID4gICAgICBmdXJ0aGVyLCBubyBtYXR0ZXIgR2VuMXgyKDEwR2JwcyksIEdlbjJ4MSgx
MEdicHMpIG9yIEdlbjJ4MigyMEdicHMpLiBTbyBJCj4+ID4gPiAgICAgIHRob3VnaHQgbWF5YmUg
aXQncyBnb29kIHRvIHByb3ZpZGUgYSBzaW1pbGFyIHdheSBsaWtlIGlvY3RsIFVTQkRFVkZTX0dF
VF9TUEVFRAo+PiA+ID4gICAgICBpbiBvcmRlciB0byBnZXQgc3NwIHJhdGVzLgo+PiA+IAo+PiA+
IElmIGxpYnVzYiBkb2Vzbid0IG5lZWQgdGhpcyBpb2N0bCwgd2hvIHdvdWxkIHVzZSBpdD8gIFdl
IG9ubHkgYWRkIGFwaXMKPj4gPiB0aGF0IGFyZSBhY3R1YWxseSBnb2luZyB0byBiZSB1c2VkLgo+
PiA+IAo+PiA+IFNvIGlmIGxpYnVzYiBkb2Vzbid0IHVzZSBpdCwgd2UgbmVlZCBhIHJlYWwtd29y
bGQgdXNlciBmb3IgdXMgdG8gYmUgYWJsZQo+PiA+IHRvIGFkZCB0aGlzLgo+PiAKPj4gSSBhbSBz
b3JyeSwgYnV0IHRoYXQgbG9va3MgcHJldHR5IG11Y2ggbGlrZSBhIHF1ZXN0aW9uIG9mIEFQSSBk
ZXNpZ24gdG8gbWUuCj4+IFRvIHdoYXQgZXh0ZW50IGlzIGxpYnVzYiBzdXBwb3NlZCB0byBiZSBm
dW5jdGlvbmFsIHdpdGhvdXQgc3lzZnM/IFRoZXJlIGlzCj4+IG5vIHRlY2huaWNhbCBhbnN3ZXIg
dG8gdGhpcy4gSXQgaXMgYSBxdWVzdGlvbiBvZiBkZXNpZ24gZ29hbHMuCj4+IAo+PiBJZiB3ZSBm
b2xsb3cgdGhlIHByZWNlZGVudCBvZiBjMDFiMjQ0YWQ4NDhhCj4+ICgiVVNCOiBhZGQgdXNiZnMg
aW9jdGwgdG8gcmV0cmlldmUgdGhlIGNvbm5lY3Rpb24gc3BlZWQiKQo+PiB0aGVuIHdlIHNob3Vs
ZCBhcHBseSBhbiB1cGRhdGVkIHZlcnNpb24gb2YgRGluZ3lhbiBMaSdzIHBhdGNoLCBwcmVmZXJh
Ymx5Cj4+IGNvdXBsZWQgd2l0aCBhIHBhdGNoIGZvciBsaWJ1c2Igb3Igd2UgZ28gYW5kIGRlcHJl
Y2F0ZSBzb21lIGlvY3Rscy4KPgo+V2UgY2FuIG5ldmVyICJkZXByZWNhdGUiIGlvY3Rscywgc29y
cnkuCj4KPlNvIHVubGVzcyB0aGVyZSBpcyBzb21lIGFjdHVhbCBuZWVkIGZyb20gdXNlcnNwYWNl
IHRvb2xzIGxpa2UgbGlidXNiIChvcgo+YW55dGhpbmcgZWxzZT8pIHRoYXQgcmVxdWlyZXMgdGhp
cyBuZXcgaW9jdGwsIGxldCdzIG5vdCBhZGQgaXQgb3RoZXJ3aXNlCj53ZSBhcmUgc2lnbmluZyBv
dXJzZWx2ZXMgdXAgdG8gc3VwcG9ydCBpdCBmb3IgZm9yZXZlci4KPgo+dGhhbmtzLAo+Cgo+Z3Jl
ZyBrLWgKCklmIHdlIGNhbid0ICJkZXByZWNhdGUiIGlvY3RscywgY2FuIHdlIGNoYW5nZSB0aGUg
cmV0dXJuZWQgY29udGVudHMgb2YgZXhpc3Rpbmcgb25lcz8KCkkgZm91bmQgZXZlbiBpbiB1c2Jm
cywgd2UgZ290IHR3byBkaWZmZXJlbnQgaW9jdGxzIHdoaWNoIGNhbiBiZSB1c2VkIHRvIGdldCBk
ZXZpY2Ugc3BlZWQsCmluY2x1ZGluZyBVU0JERVZGU19HRVRfU1BFRUQgYW5kIFVTQkRFVkZTX0NP
Tk5JTkZPX0VYLiBNYXliZSB3ZSBjYW4gcmVkdWNlCnNvbWUgcmVkdW5kYW5jeSB0aGVyZS4KCkFu
ZCBieSBzYXlpbmcgYWN0dWFsIG5lZWRzLCB5b3UgbWVhbiBpdCdzIG5vdCBlbm91Z2ggdG8ganVz
dCBhZGQgdGhpcyBuZXcgaW9jdGwgdG8gbGlidXNiIGFuZAppbWFnaW5lIHRoaXMgcGFydCBvZiBs
aWJ1c2Igd2lsbCBiZSB1c2VkIGJ5IGFueW9uZSBpbiB0aGUgZnV0dXJlLiBUaGVyZSBtdXN0IGJl
IHNvbWUgcmVhbC13b3JsZApyZXF1ZXN0cyBmb3Igbm93IHdoaWNoIG1ha2UgbGlidXNiIGhhdmUg
dG8gdXNlIHRoaXMgbmV3IGlvY3RsLCByaWdodD8KCgpSZWdhcmRzLApEaW5neWFu
