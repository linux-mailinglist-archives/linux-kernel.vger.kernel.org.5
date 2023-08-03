Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7242976EEFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjHCQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHCQHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:07:09 -0400
Received: from m13116.mail.163.com (m13116.mail.163.com [220.181.13.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C6061FCF;
        Thu,  3 Aug 2023 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=w5CQQ06HohigWmso7gDwXFWT7ldvmSUYfTFTwRWzylE=; b=g
        FPLMs5PzKtmeR9ahPHczcsWDA08K+yXgnH8WmKPaPbYowk90N/7j7QdjsjRqFDTK
        KnBtHVrHUFO1pw+cdWm9TunrI4xOVWJYQTSdKjNNQFJbSpUC6J7IKyK6BWCpUeHL
        6qxJ615fOFi7dN4dnbWbrQoJ4ZOq8yy9gXLsxalnA4=
Received: from 18500469033$163.com ( [114.250.138.216] ) by
 ajax-webmail-wmsvr116 (Coremail) ; Fri, 4 Aug 2023 00:06:15 +0800 (CST)
X-Originating-IP: [114.250.138.216]
Date:   Fri, 4 Aug 2023 00:06:15 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Alan Stern" <stern@rowland.harvard.edu>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>,
        "Xiaofan Chen" <xiaofanc@gmail.com>,
        "Oliver Neukum" <oneukum@suse.com>,
        "Tormod Volden" <lists.tormod@gmail.com>,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <a31ee75e-6a8e-fe7b-aadc-f118d9ab60f9@redhat.com>
References: <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
 <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
 <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
 <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
 <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
 <51926ee6-ee81-4543-a1f7-338e65a26670@rowland.harvard.edu>
 <a31ee75e-6a8e-fe7b-aadc-f118d9ab60f9@redhat.com>
X-NTES-SC: AL_QuySA/yct08s4yeQZukXkkYVgew6WsC4vf4k3IReOps0qivB2gU/YWRAN2Tn/8ioIgGFqwOaSQR2yuB+T61VQI6bNN6rfZd1hcKTSeLEeX6i
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <67b68375.80b5.189bc2653e9.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dMGowACnz1R30Mtk8PkOAA--.20896W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1S2mDhfAy2SAXJ88VAAAsd
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

CkF0IDIwMjMtMDgtMDMgMjM6Mzk6NTYsICJIYW5zIGRlIEdvZWRlIiA8aGRlZ29lZGVAcmVkaGF0
LmNvbT4gd3JvdGU6Cj5IaSwKPgo+T24gOC8zLzIzIDE3OjEwLCBBbGFuIFN0ZXJuIHdyb3RlOgo+
PiBPbiBUaHUsIEF1ZyAwMywgMjAyMyBhdCAwMjoxMzozM1BNICswODAwLCBEaW5neWFuIExpIHdy
b3RlOgo+Pj4KPj4+IEF0IDIwMjMtMDctMjYgMjI6Mzk6MzIsICJIYW5zIGRlIEdvZWRlIiA8aGRl
Z29lZGVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+IAo+Pj4+IFJpZ2h0LCBzbyB0aGUgcmVhc29uIHdo
eSBJT0NUTCBVU0JERVZGU19HRVRfU1BFRUQgd2FzIGFkZGVkIGlzIHNvIAo+Pj4+IHRoYXQgYSBj
b25maW5lZCBxZW11IHByb2Nlc3Mgd2hpY2ggZ2V0cyBqdXN0IGEgZmQgZm9yIGEgL2Rldi9idXMv
dXNiLyAKPj4+PiBkZXZpY2UgcGFzc2VkIGJ5IGEgbW9yZSBwcml2aWxlZ2VkIHByb2Nlc3MgY2Fu
IHN0aWxsIGdldCB0aGUgc3BlZWQgCj4+Pj4gZGVzcGl0ZSBpdCBub3QgaGF2aW5nIHN5c2ZzIGFj
Y2Vzcy4gVGhpcyBpcyBuZWNlc3NhcnkgZm9yIGNvcnJlY3QgCj4+Pj4gcGFzcy10aHJvdWdoIG9m
IFVTQiBkZXZpY2VzLgo+Pj4+Cj4+Pj4gU2luY2UgVVNCREVWRlNfR0VUX1NQRUVEIG5vdyBubyBs
b25nZXIgdGVsbHMgdGhlIGZ1bGwgc3RvcnkgSSBiZWxpZXZlIAo+Pj4+IHRoYXQgdGhlIHByb3Bv
c2VkIFVTQkRFVkZTX0dFVF9TU1BfUkFURSBpb2N0bCBtYWtlcyBzZW5zZS4KPj4+Pgo+Pj4+IFRo
ZSBjdXJyZW50IHBhdGNoIGhvd2V2ZXIgbWlzc2VzIG1vdmluZyB0aGUgZW51bSB1c2Jfc3NwX3Jh
dGUgCj4+Pj4gZGVjbGFyYXRpb24gZnJvbSBpbmNsdWRlL2xpbnV4L3VzYi9jaDkuaCB0byAKPj4+
PiBpbmNsdWRlL3VhcGkvbGludXgvdXNiL2NoOS5oIHNvIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQg
aW4gYSB2ZXJzaW9uIAo+Pj4+IDIuIEFzc3VtaW5nIHRoYXQgd2l0aCB0aGUgYWJvdmUgZXhwbGFu
YXRpb24gb2Ygd2h5IHRoaXMgaXMgbmVjZXNzYXJ5IAo+Pj4+IEdyZWcgYW5kIEFsYW4gYXJlIG9r
IHdpdGggYWRkaW5nIHRoZSBpb2N0bC4KPj4+Pgo+Pj4+IFJlZ2FyZHMsCj4+Pj4KPj4+PiBIYW5z
Cj4+Pj4KPj4+Cj4+PiBIaSBHcmVnIGFuZCBBbGFuLAo+Pj4KPj4+IENvdWxkIHlvdSBwbGVhc2Ug
c2hhcmUgeW91ciBvcGluaW9ucyBhYm91dCBIYW5zJyBqdXN0aWZpY2F0aW9uPwo+PiAKPj4gSW5z
dGVhZCBvZiBhZGRpbmcgYSBuZXcgaW9jdGwgb3IgbW9kaWZ5aW5nIGFuIGV4aXN0aW5nIG9uZSwg
aG93IGFib3V0IAo+PiBpbmNyZWFzaW5nIHRoZSBzZXQgb2YgY29uc3RhbnRzIGluIGVudW0gdXNi
X2RldmljZV9zcGVlZD8gIFRoZW4gdGhlIAo+PiBleGlzdGluZyBpb2N0bHMgY291bGQgcmV0dXJu
IHRoZSBuZXdseSBkZWZpbmVkIHZhbHVlcyB3aGVuIGFwcHJvcHJpYXRlLCAKPj4gd2l0aCBubyBv
dGhlciBjaGFuZ2VzIG5lY2Vzc2FyeS4KPgo+UmlnaHQsIEkgd2FzIHRoaW5raW5nIGFsb25nIHRo
ZSBzYW1lIGxpbmVzIGJ1dCBJIHdhcyBub3QgZW50aXJlbHkKPnN1cmUgdGhpcyB3b3VsZCB3b3Jr
IGJlY2F1c2UgSSBsb29rZWQgYXQgdGhlIHdyb25nIGJpdHMgb2YKPmluY2x1ZGUvdWFwaS9saW51
eC91c2IvY2g5Lmggd2hpbGUgd3JpdGluZyBteSBmaXJzdCBlbWFpbCBvbiB0aGlzLgo+Cj5Mb29r
aW5nIGFnYWluIEkgc2VlIHdlIGFscmVhZHkgaGF2ZSBhIHN0cmFpZ2h0IGZvcndhcmQKPmVudW0g
dXNiX2RldmljZV9zcGVlZCBmb3IgdGhpcyB3aGljaCBjYW4gZWFzaWx5IGJlIGV4dGVuZGVkLgo+
Cj4+IChUaGlzIGRvZXNuJ3QgbWVhbiBqdXN0IG1vdmluZyB0aGUgZGVmaW5pdGlvbiBvZiB1c2Jf
c3NwX3JhdGUgZnJvbSBvbmUgCj4+IGhlYWRlciBmaWxlIHRvIHRoZSBvdGhlci4gIFRoZSB1c2Jf
ZGV2aWNlX3NwZWVkIGVudW1lcmF0aW9uIHNob3VsZCBiZSAKPj4gZXh0ZW5kZWQgd2l0aCB0aGUg
bmV3IG1lbWJlcnMuICBQZXJoYXBzIG9taXR0aW5nIFVTQl9TU1BfR0VOX1VOS05PV04gCj4+IHNp
bmNlIHdlIGFscmVhZHkgaGF2ZSBVU0JfU1BFRURfU1VQRVJfUExVUywgb3Igc2V0dGluZyB0aGUg
Zmlyc3QgZXF1YWwgCj4+IHRvIHRoZSBzZWNvbmQuKQo+PiAKPj4gSSBkb24ndCB0aGluayB0aGVy
ZSB3YXMgZXZlciBhIHJlcXVpcmVtZW50IGluIHRoZSBBUEkgdGhhdCB0aGUgc2V0IG9mIAo+PiB2
YWx1ZXMgaW4gdXNiX2RldmljZV9zcGVlZCBjb3VsZCBuZXZlciBpbmNyZWFzZSAoYW5kIGluIGZh
Y3QgaXQgaGFzIAo+PiBpbmNyZWFzZWQgaW4gdGhlIHBhc3QpLiAgU3VjaCBhIHJlcXVpcmVtZW50
IHdvdWxkbid0IG1ha2UgYW55IHNlbnNlLCAKPj4gZ2l2ZW4gaG93IHRoZSBVU0ItSUYga2VlcHMg
ZGVmaW5pbmcgbmV3ZXIgYW5kIGZhc3RlciBVU0IgYnVzIAo+PiBpbXBsZW1lbnRhdGlvbnMuCj4+
IAo+PiBIYW5zLCB3b3VsZCB0aGF0IHBsYXkgd2VsbCB3aXRoIGxpYnVzYj8KPgo+SXQgc2hvdWxk
LCB0aGlzIGlzIGhvdyBsaWJ1c2IgdXNlcyB0aGUgVVNCREVWRlNfR0VUX1NQRUVEIGlvY3RsOgo+
Cj5zdGF0aWMgZW51bSBsaWJ1c2Jfc3BlZWQgdXNiZnNfZ2V0X3NwZWVkKHN0cnVjdCBsaWJ1c2Jf
Y29udGV4dCAqY3R4LCBpbnQgZmQpCj57Cj4JaW50IHI7Cj4KPglyID0gaW9jdGwoZmQsIElPQ1RM
X1VTQkZTX0dFVF9TUEVFRCwgTlVMTCk7Cj4Jc3dpdGNoIChyKSB7Cj4JY2FzZSBVU0JGU19TUEVF
RF9VTktOT1dOOglyZXR1cm4gTElCVVNCX1NQRUVEX1VOS05PV047Cj4JY2FzZSBVU0JGU19TUEVF
RF9MT1c6CQlyZXR1cm4gTElCVVNCX1NQRUVEX0xPVzsKPgljYXNlIFVTQkZTX1NQRUVEX0ZVTEw6
CQlyZXR1cm4gTElCVVNCX1NQRUVEX0ZVTEw7Cj4JY2FzZSBVU0JGU19TUEVFRF9ISUdIOgkJcmV0
dXJuIExJQlVTQl9TUEVFRF9ISUdIOwo+CWNhc2UgVVNCRlNfU1BFRURfV0lSRUxFU1M6CXJldHVy
biBMSUJVU0JfU1BFRURfSElHSDsKPgljYXNlIFVTQkZTX1NQRUVEX1NVUEVSOgkJcmV0dXJuIExJ
QlVTQl9TUEVFRF9TVVBFUjsKPgljYXNlIFVTQkZTX1NQRUVEX1NVUEVSX1BMVVM6CXJldHVybiBM
SUJVU0JfU1BFRURfU1VQRVJfUExVUzsKPglkZWZhdWx0Ogo+CQl1c2JpX3dhcm4oY3R4LCAiRXJy
b3IgZ2V0dGluZyBkZXZpY2Ugc3BlZWQ6ICVkIiwgcik7Cj4JfQo+Cj4JcmV0dXJuIExJQlVTQl9T
UEVFRF9VTktOT1dOOwo+fQo+Cj5JIHRoaW5rIHRoYXQgR0VOXzJ4MSBzaG91bGQgcHJvYmFibHkg
YmUgbWFwcGVkIHRvCj5VU0JGU19TUEVFRF9TVVBFUl9QTFVTIHNvIGFzIHRvIG5vdCBicmVhayB0
aGlzIG1vc3QgY29tbW9uIGNhc2UKPmFuZCB0byBrZWVwIGFwcHMgcmVwb3J0aW5nIGVpdGhlciBT
dXBlciBTcGVlZCBQbHVzIG9yIDEwR2Jwcwo+KG1vcmUgY29tbW9uKSBmb3IgdGhpcy4KPgo+R0VO
XzF4MiArIEdFTl8yeDIgY2FuIHRoZW4gYmUgbWFwcGVkIHRvIG5ldyB2YWx1ZXMsIHdoaWNoIHdp
bGwKPmNhdXNlIGxpYnVzYiB0byBsb2cgYSB3YXJuaW5nICsgcmV0dXJuIExJQlVTQl9TUEVFRF9V
TktOT1dOCj51bnRpbCBsaWJ1c2IgaXMgdXBkYXRlZCB3aGljaCBzZWVtcyBoYXJtbGVzcyBlbm91
Z2guCj4KPlJlZ2FyZHMsCj4KPkhhbnMKPgoKU28gYWZ0ZXIgdXNiX2RldmljZV9zcGVlZCBpcyBl
eHRlbmRlZCB3aXRoIEdlbjJ4MSwgR2VuMXgyIGFuZCBHZW4yeDIsCml0IGZlZWxzIHRoYXQgZW51
bSB1c2Jfc3NwX3JhdGUgYmVjb21lcyB1c2VsZXNzLiBJcyBpdCBva2F5IHRvIGp1c3QgZGVsZXRl
IGl0PwpJJ20gYXNraW5nIHRoaXMgc2luY2UgaXQgaXMgYWxzbyB1c2VkIGluIHNldmVyYWwgb3Ro
ZXIgc291cmNlIGZpbGVzIHNvIHRoZSBmaXggbWF5Cm5vdCBiZSBhcyB0cml2aWFsIGFzIGl0IGxv
b2tzLgoKUmVnYXJkcywKRGluZ3lhbgo=
