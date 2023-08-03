Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2405276E013
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjHCGOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjHCGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:14:15 -0400
Received: from m1319.mail.163.com (m1319.mail.163.com [220.181.13.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9514A272C;
        Wed,  2 Aug 2023 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=cZKYvK7GENrcvv8wShgW7ZbfXpqvhB7cEmA7abJwyA4=; b=k
        UK3d5zKZce1lQwywP377x2k7ajeGczYrIisCsc5xqne1leebmuaLvYGxG+5XivOJ
        qyUEWLWXMh8b4IOAKdCJtunnnjyiu7gn7tK2mDnrshYMahgsrc/Hx4QRYMoJ/maD
        xjJKNF/QezdA11qIoVKqRbpefvWvJOJrJkzAhcc8sk=
Received: from 18500469033$163.com ( [43.243.14.10] ) by
 ajax-webmail-wmsvr19 (Coremail) ; Thu, 3 Aug 2023 14:13:33 +0800 (CST)
X-Originating-IP: [43.243.14.10]
Date:   Thu, 3 Aug 2023 14:13:33 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     stern@rowland.harvard.edu, "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
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
In-Reply-To: <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
 <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
 <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
 <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
X-NTES-SC: AL_QuySA/yfvEoq5SWQZOkXkkYVgew6WsC4vf4k3IReOps0pinT3gQ5cWFfB0r7z/meNiCcrgaTdydv5Mp/f49FRpJC4VKEcX/F4xqOKLwNgUJv
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: E8GowAD39gCORctki40OAA--.52929W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbB5xbAy2BHLIrzYwAAsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDctMjYgMjI6Mzk6MzIsICJIYW5zIGRlIEdvZWRlIiA8aGRlZ29lZGVAcmVkaGF0
LmNvbT4gd3JvdGU6Cj5IaSBBbGwsCj4KPk9uIDcvMjYvMjMgMDU6MjAsIFhpYW9mYW4gQ2hlbiB3
cm90ZToKPj4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgNTozOOKAr1BNIE9saXZlciBOZXVrdW0g
PG9uZXVrdW1Ac3VzZS5jb20+IHdyb3RlOgo+Pj4KPj4+IE9uIDI2LjA3LjIzIDAzOjM3LCBYaWFv
ZmFuIENoZW4gd3JvdGU6Cj4+Pj4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTA6MjPigK9QTSBH
cmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+Pgo+Pj4gSGksCj4+
Pgo+Pj4+PiBTbyB1bmxlc3MgdGhlcmUgaXMgc29tZSBhY3R1YWwgbmVlZCBmcm9tIHVzZXJzcGFj
ZSB0b29scyBsaWtlIGxpYnVzYiAob3IKPj4+Pj4gYW55dGhpbmcgZWxzZT8pIHRoYXQgcmVxdWly
ZXMgdGhpcyBuZXcgaW9jdGwsIGxldCdzIG5vdCBhZGQgaXQgb3RoZXJ3aXNlCj4+Pj4+IHdlIGFy
ZSBzaWduaW5nIG91cnNlbHZlcyB1cCB0byBzdXBwb3J0IGl0IGZvciBmb3JldmVyLgo+Pj4+Cj4+
Pj4gSW50ZXJlc3RpbmdseSB0aGVyZSBpcyBQUiBpbiBsaWJ1c2Igbm93LCB3aGljaCB1c2VzIHN5
c2ZzIGZvciAyMEdicHMuCj4+Pgo+Pj4gVHJ1ZS4gTm93IHdvdWxkIHlvdSB3cml0ZSBhIHBhdGNo
IGZvciBsaWJ1c2I/Cj4+PiBUaGlzIGxvb2tzIHRvIGJlIHR1cm5pbmcgaW50byBhIGNoaWNrZW4g
YW5kIGVnZyBwcm9ibGVtLgo+Pj4KPj4+PiBNYXliZSB0aGlzIG5ldyB1c2JmcyBJT0NUTCBpcyBp
bmRlZWQgZ29vZCB0byBoYXZlIGlmIHdlIGNhbiBub3QgZXh0ZW5kCj4+Pgo+Pj4gTG9va2luZyBh
dCB0aGUgY29kZSBvZiBsaWJ1c2IgeW91IGNhbiBzZWUgdGhhdCBsaWJ1c2IgaGFzIHR3byBtb2Rl
cwo+Pj4gb2Ygb3BlcmF0aW9uLiBFaXRoZXIgaXQgZmluZHMgc3lzZnMsIHRoZW4gaXQgdXNlcyBp
dCwgaWYgbm90IGl0Cj4+PiBnb2VzIGZvciB0aGUgaW9jdGwuCj4+Pgo+Pj4gTm93LCBob3cgd2Vs
bCBzaGFsbCBpdCB3b3JrIHdpdGhvdXQgc3lzZnM/IFRoYXQgaXMgYSBkZXNpZ24gZGVjaXNpb24K
Pj4+IGFuZCB3ZSBzaG91bGQgbm90IGJlIGhhdmluZyB0aGlzIGRpc2N1c3Npb24gYWdhaW4gYW5k
IGFnYWluLgo+Pj4KPj4+IEJUVywgdGhhdCBpcyBub3QgYWltZWQgYXQgYW55Ym9keSBwZXJzb25h
bGx5LCB3ZSBhcmUganVzdCB0cnlpbmcgdG8KPj4+IGF2b2lkIGEgYmFzaWMgZGVjaXNpb24gYW5k
IGl0IHdpbGwgY29tZSBiYWNrLgo+Pj4KPj4+PiB0aGUgZXhpc3RpbmcgSU9DVEwgVVNCREVWRlNf
R0VUX1NQRUVEIChidXQgd2h5IG5vdD8pLgo+Pj4KPj4+IEl0IGRvZXMgbm90IGluY2x1ZGUgdGhl
IGxhbmUgY291bnQuCj4+PiBBbmQgc29ydCBvZiBmdWRnaW5nIHRoaXMgaW50byBzcGVlZCBpcyBh
IGJhZCBpZGVhIGluIHRoZSBsb25nCj4+PiBydW4gYmVjYXVzZSB3ZSBhcmUgbGlrZWx5IHRvIGhh
dmUgY29sbGlzaW9ucyBpbiB0aGUgZnV0dXJlLgo+Pj4KPj4+IFdlIGhhdmUgYSBiYXNpYyBpc3N1
ZSBoZXJlLiBEbyB3ZSByZXF1aXJlIGxpYnVzYiB0byB1c2Ugc3lzZnMgb3Igbm90Pwo+PiAKPj4g
QWRkaW5nIEhhbnMgZGUgR29lZGUgYW5kIFRvcm1vZCBWb2xkZXIgKGxpYnVzYiBhZG1pbnMpIGhl
cmUgaW4gdGhlIGRpc2N1c3Npb25zCj4+IGFzIEkgYW0gbW9yZSBpbnRvIHRoZSB0ZXN0aW5nIGFu
ZCBzdXBwb3J0IHNpZGUgb2YgbGlidXNiIGFuZCBub3QgYQo+PiByZWFsIGRldmVsb3Blci4KPj4g
Cj4+IGxpYnVzYiBkb2VzIHdvcmsgd2l0aCBvciB3aXRob3V0IHN5c2ZzIGFuZCB0aGVyZSBhcmUg
bXVsdGlwbGUgY29tbWl0cyByZWxhdGVkCj4+IHRvIHN5c2ZzIHZzIHVzYmZzLgo+PiAKPj4gQW4g
ZXhhbXBsZSBjb21taXQgZnJvbSBIYW5zIGluIFNlcHQgMjAyIHdoaWNoIGlzIHJlbGF0ZWQgdG8g
dGhpcyBkaXNjdXNzaW9uLgo+PiBodHRwczovL2dpdGh1Yi5jb20vbGlidXNiL2xpYnVzYi9jb21t
aXQvZjYwNjhlODNjNGY1ZTVmYmExNmIyM2I2YTg3ZjFmNmQ3YWI3MjAwYQo+PiArKysrKysrKysr
KysrKysrCj4+IGxpbnV4OiBGaXggbGlidXNiX2dldF9kZXZpY2Vfc3BlZWQoKSBub3Qgd29ya2lu
ZyBvbiB3cmFwcGVkIGRldmljZXMKPj4gCj4+IFdlIGRvbid0IGhhdmUgYSBzeXNmc19kaXIgZm9y
IHdyYXBwZWQgZGV2aWNlcywgc28gd2UgY2Fubm90IHJlYWQgdGhlIHNwZWVkCj4+IGZyb20gc3lz
ZnMuCj4+IAo+PiBUaGUgTGludXgga2VybmVsIGhhcyBzdXBwb3J0ZWQgYSBuZXcgaW9jdGwgdG8g
Z2V0IHRoZSBzcGVlZCBkaXJlY3RseSBmcm9tCj4+IHRoZSBmZCBmb3IgYSB3aGlsZSBub3csIHVz
ZSB0aGF0IHdoZW4gd2UgZG9uJ3QgaGF2ZSBzeXNmcyBhY2Nlc3MuCj4+IAo+PiBCdWdsaW5rOiBo
dHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE4NzE4MTgKPj4gUmVw
b3J0ZWQtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgo+PiBTaWduZWQtb2Zm
LWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgo+PiArKysrKysrKysrKysr
KysrKwo+PiAKPj4gVG8gSGFucyBhbmQgVG9ybW9kOgo+PiBEaXNjdXNzaW9uIHRocmVhZCBmb3Ig
cmVmZXJlbmNlOgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvZGE1MzZjODAt
NzM5OC1kYWUwLWEyMmMtMTZlNTIxYmU2OTdhQHN1c2UuY29tL1QvI3QKPgo+UmlnaHQsIHNvIHRo
ZSByZWFzb24gd2h5IElPQ1RMIFVTQkRFVkZTX0dFVF9TUEVFRCB3YXMgYWRkZWQgaXMgc28gdGhh
dCBhIGNvbmZpbmVkIHFlbXUgcHJvY2VzcyB3aGljaCBnZXRzIGp1c3QgYSBmZCBmb3IgYSAvZGV2
L2J1cy91c2IvIGRldmljZSBwYXNzZWQgYnkgYSBtb3JlIHByaXZpbGVnZWQgcHJvY2VzcyBjYW4g
c3RpbGwgZ2V0IHRoZSBzcGVlZCBkZXNwaXRlIGl0IG5vdCBoYXZpbmcgc3lzZnMgYWNjZXNzLiBU
aGlzIGlzIG5lY2Vzc2FyeSBmb3IgY29ycmVjdCBwYXNzLXRocm91Z2ggb2YgVVNCIGRldmljZXMu
Cj4KPlNpbmNlIFVTQkRFVkZTX0dFVF9TUEVFRCBub3cgbm8gbG9uZ2VyIHRlbGxzIHRoZSBmdWxs
IHN0b3J5IEkgYmVsaWV2ZSB0aGF0IHRoZSBwcm9wb3NlZCBVU0JERVZGU19HRVRfU1NQX1JBVEUg
aW9jdGwgbWFrZXMgc2Vuc2UuCj4KPlRoZSBjdXJyZW50IHBhdGNoIGhvd2V2ZXIgbWlzc2VzIG1v
dmluZyB0aGUgZW51bSB1c2Jfc3NwX3JhdGUgZGVjbGFyYXRpb24gZnJvbSBpbmNsdWRlL2xpbnV4
L3VzYi9jaDkuaCB0byBpbmNsdWRlL3VhcGkvbGludXgvdXNiL2NoOS5oIHNvIHRoYXQgbmVlZHMg
dG8gYmUgZml4ZWQgaW4gYSB2ZXJzaW9uIDIuIEFzc3VtaW5nIHRoYXQgd2l0aCB0aGUgYWJvdmUg
ZXhwbGFuYXRpb24gb2Ygd2h5IHRoaXMgaXMgbmVjZXNzYXJ5IEdyZWcgYW5kIEFsYW4gYXJlIG9r
IHdpdGggYWRkaW5nIHRoZSBpb2N0bC4KPgo+UmVnYXJkcywKPgo+SGFucwo+CgpIaSBHcmVnIGFu
ZCBBbGFuLAoKQ291bGQgeW91IHBsZWFzZSBzaGFyZSB5b3VyIG9waW5pb25zIGFib3V0IEhhbnMn
IGp1c3RpZmljYXRpb24/CgpSZWdhcmRzLApEaW5neWFuCg==
