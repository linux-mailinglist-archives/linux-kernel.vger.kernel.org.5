Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43583781759
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 06:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjHSEdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 00:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjHSEdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 00:33:24 -0400
Received: from m1319.mail.163.com (m1319.mail.163.com [220.181.13.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBA364211;
        Fri, 18 Aug 2023 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=iz1kc/+jTr35gcMc4FDnO3H2sC+Z+IBN0qSrWXZCvrc=; b=d
        vCEAFIWMis2eTc7P/ZCwc3Kr3M9cKWhlOcPfCk3Rix+ewAyZjWabP28pyIWxwRRK
        8gNwbP3JKX7DOL3D/+OGB/0c8uZSmIUd3f9S2cZCJ/0SvpWnmqsqlkDaUO3bGVeF
        DUJyyzGq8rR7i3uOcukIrA9KYvrnb2BhuFZliW5V1Y=
Received: from 18500469033$163.com ( [114.250.138.216] ) by
 ajax-webmail-wmsvr19 (Coremail) ; Sat, 19 Aug 2023 12:32:43 +0800 (CST)
X-Originating-IP: [114.250.138.216]
Date:   Sat, 19 Aug 2023 12:32:43 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Alan Stern" <stern@rowland.harvard.edu>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Xiaofan Chen" <xiaofanc@gmail.com>,
        "Oliver Neukum" <oneukum@suse.com>,
        "Tormod Volden" <lists.tormod@gmail.com>,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: Re: Re: [PATCH] USB: add usbfs ioctl to get specific
 superspeedplus rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <daa39dd3-4e8b-4d69-8ad3-5ec73fa12f8c@rowland.harvard.edu>
References: <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
 <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
 <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
 <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
 <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
 <51926ee6-ee81-4543-a1f7-338e65a26670@rowland.harvard.edu>
 <a31ee75e-6a8e-fe7b-aadc-f118d9ab60f9@redhat.com>
 <67b68375.80b5.189bc2653e9.Coremail.18500469033@163.com>
 <c10dd3c1-efab-47d6-904f-3b211965be44@rowland.harvard.edu>
 <5ccfaa7e.3180.189bec2b80e.Coremail.18500469033@163.com>
 <daa39dd3-4e8b-4d69-8ad3-5ec73fa12f8c@rowland.harvard.edu>
X-NTES-SC: AL_QuySAPiatk0t5SSbZelS/T5Xw5RfLaTO5axEmsQBSeEQpj7O2S0yZkBGJHjL1Pn2ppozhKLZruPb8jACaZKe
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <79f3ec25.fa3.18a0c111fa9.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: E8GowAAXFwHrReBkbTcXAA--.35294W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbB5xDQy2BHLU7TTgABs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDgtMDQgMjI6NTU6NDksICJBbGFuIFN0ZXJuIiA8c3Rlcm5Acm93bGFuZC5oYXJ2
YXJkLmVkdT4gd3JvdGU6Cgo+PiBBbm90aGVyIGlzc3VlIGlzIHRoYXQgVVNCX1NQRUVEX1NVUEVS
X1BMVVMgaGFzIGJlZW4gd2lkZWx5IHVzZWQgaW4KPj4gc28gbWFueSBmaWxlcyB0byBleGVjdXRl
IGNvbmRpdGlvbmFsIGJhbmNoZXMuIE9uY2Ugd2UgZXh0ZW5kIGFuZCBzdG9yZSBkZXZpY2Uncwo+
PiBzcGVlZCB3aXRoIG5ldyB2YWx1ZXMgaW4gdGhlIGZpcnN0IHBsYWNlLCB3ZSBtaWdodCBuZWVk
IHRvIGNoZWNrIGFsbCBwbGFjZXMgd2hlcmUKPj4gVVNCX1NQRUVEX1NVUEVSX1BMVVMgaXMgdXNl
ZCBpbiBjYXNlIG9mIGFueSByZWdyZXNzaW9uLgo+Cj5DZXJ0YWlubHkuICBUaGF0J3MgcGFydCBv
ZiBhdWRpdGluZyBhbGwgdGhlIGN1cnJlbnQgdXNlcnMgb2YgCj51c2JfZGV2aWNlX3NwZWVkLgoK
VGhpcyBtaWdodCBub3QgYmUgYSBnb29kIGlkZWEgYW5kIGZlZWxzIGtpbmQgb2YgZHJpZnQgYXdh
eSBmcm9tIHdoYXQgd2Ugb3JpZ2luYWxseQp3YW50IHRvIGRvLiBCZXNpZGVzLCBzdXBwb3NlIGxh
dGVyIG5ldyBzcGVlZCB2YWx1ZXMgYXJlIGFkZGVkLCBzb21lb25lIHN0aWxsIGhhcwp0byByZXZp
c2l0IGFsbCB0aGUgZmlsZXMgdG8gbW9kaWZ5IHRob3NlIGNoZWNrcy4gSSB0aGluayB3ZSBzaG91
bGQgdHJ5IHRvIGF2b2lkIHRoaXMgc2l0dWF0aW9uLgoKPj4gSSB0aGluayBtYXliZSB3ZSBjYW4g
dHJ5IHRvIHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBvbiBlbnVtIHVzYl9kZXZpY2Vfc3BlZWQKPj4g
aW4gdXNiZnMgYW5kIGRlZmluZSBhIHNlcGFyYXRlIHNldCBvZiBzcGVlZCB2YWx1ZXMgc2ltaWxh
ciB0byBwcmV2aW91cyBkZXNpZ24KPj4gYXQgaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMv
bGludXgtdXNiL21zZzE1NzcwOS5odG1sCj4+IEJ5IHRoaXMgd2F5LCBpbiB1c2JmcyB3ZSBnZXQg
bW9yZSBmcmVlZG9tIHRvIGRldGVybWluZSBob3cgdG8gZXhwbGFpbgo+PiB1c2JfZGV2aWNlX3Nw
ZWVkIGFuZCB1c2Jfc3NwX3JhdGUsIHdpdGhvdXQgdGhlIHJpc2sgb2YgYnJlYWtpbmcgYW55dGhp
bmcKPj4gZWxzZXdoZXJlLgo+PiAKPj4gRm9yIGV4YW1wbGUsIGRlZmluZSBhbiBVU0JERVZGU19T
UEVFRF9TVVBFUl9QTFVTIHRvIGluZGljYXRlCj4+IFVTQl9TUEVFRF9TVVBFUl9QTFVTIHdpdGgg
c3NwIHJhdGVzIEdFTl9VTktOT1dOLCBHRU5fMngxIGFuZAo+PiBHRU5fMXgyLiBUaGV5IGFsbCBz
dGFuZCBmb3IgMTBHYnBzIGFuZCB3ZSBkb24ndCBuZWVkIHRvIHRlbGwgb25lIGZyb20KPj4gYW5v
dGhlciwgc2ltaWxhciB0byBob3cgaXQgd29ya3MgaW4gc3lzZnMuIFRoZW4gZGVmaW5lIGFuCj4+
IFVTQkRFVkZTX1NQRUVEX1NVUEVSX1BMVVNfQlkyKG1heWJlIHRoZXJlIGlzIGEgbW9yZSBwcm9w
ZXIgbmFtZSkKPj4gdG8gaW5kaWNhdGUgVVNCX1NQRUVEX1NVUEVSX1BMVVMgd2l0aCBzc3AgcmF0
ZSBHRU5fMngyLCB3aGljaCBzdGFuZHMKPj4gZm9yIDIwR2Jwcy4KPgo+WW91IGNhbid0IHJlYWxs
eSBkbyB0aGF0LiAgVGhlIHZhbHVlcyByZXR1cm5lZCBieSB0aGUgVVNCREVWRlNfR0VUX1NQRUVE
IAo+aW9jdGwgYXJlIHRoZSBvbmVzIGRlZmluZWQgaW4gaW5jbHVkZS91YXBpL2xpbnV4L3VzYi9j
aDkuaC4gIFRoZXkgYXJlIAo+VVNCX1NQRUVEX1VOS05PV04sIGV0Yy4sIG5vdCBVU0JERVZGU19T
UEVFRF9VTktOT1dOLCBldGMuICBUaGUgb25seSB3YXkgCj50byBleHRlbmQgdGhlbSBpcyBieSBh
ZGRpbmcgbmV3IGVudHJpZXMgdG8gZW51bSB1c2JfZGV2aWNlX3NwZWVkLgo+Cj5Gb3IgZXhhbXBs
ZSwgeW91IG11c3Qgbm90IGRvIGFueXRoaW5nIHRoYXQgd291bGQgYnJlYWsgYSB1c2VyIHByb2dy
YW0gCj53aGljaCBkb2VzIHNvbWV0aGluZyBsaWtlIHRoaXM6Cj4KPiNpbmNsdWRlIDxsaW51eC91
c2JkZXZmcy5oPgo+I2luY2x1ZGUgPGxpbnV4L3VzYi9jaDkuaD4KPgo+Li4uCj4KPgllbnVtIHVz
Yl9kZXZpY2Vfc3BlZWQgczsKPgo+CXMgPSBpb2N0bChmZCwgVVNCREVWRlNfR0VUX1NQRUVEKTsK
PglpZiAocyA9PSBVU0JfU1BFRURfSElHSCkgLi4uCj4KPkFsYW4gU3Rlcm4KClNpbmNlIHRob3Nl
IHNwZWVkIGRlZmluaXRpb25zIGFyZSBqdXN0IGludCB2YWx1ZXMsIHdlIGNvdWxkIG1hbmFnZSB0
byBtYWludGFpbiB0aGUgY29tcGF0aWJpbGl0eQpieSBrZWVwaW5nIHRoZSBzYW1lIHZhbHVlLiBC
dXQgYW55d2F5LCBteSBsYXRlc3QgaWRlYSBpcyBub3QgdG8gZXh0ZW5kIGVudW0gdXNiX2Rldmlj
ZV9zcGVlZC4KVGhlcmUgYXJlIHRocmVlIGJhc2ljIGNhc2VzOgoxKSBXaGVuIHNwZWVkIGlzIGxl
c3MgdGhhbiBVU0JfU1BFRURfU1VQRVJfUExVUywganVzdCByZXR1cm4gZGV2LT5zcGVlZDsKMikg
V2hlbiBzcGVlZCBpcyBVU0JfU1BFRURfU1VQRVJfUExVUyBidXQgc3NwX3JhdGUgaXMgbGVzcyB0
aGFuIFVTQl9TU1BfR0VOXzJ4MiwKcmV0dXJuIGRldi0+c3BlZWQ7CjMpIFdoZW4gc3BlZWQgaXMg
VVNCX1NQRUVEX1NVUEVSX1BMVVMgYW5kIHNzcF9yYXRlIGlzIFVTQl9TU1BfR0VOXzJ4MiwgYSBu
ZXcKc3BlZWQgZm9yIHVzYmRldmZzIHNob3VsZCBiZSAjZGVmaW5lZCBhbmQgbGV0J3MgY2FsbCBp
dCBVU0JERVZGU19TUEVFRF9TVVBFUl9QTFVTX0JZMi4KVGhpcyB2YWx1ZSB3b24ndCBiZSBvdmVy
bGFwcGVkIHdpdGggYW55IHZhbHVlIGluIGVudW0gdXNiX2RldmljZV9zcGVlZCwgZm9yIGV4YW1w
bGUgNy4KSW4gdGhpcyBjYXNlLCByZXR1cm4gVVNCREVWRlNfU1BFRURfU1VQRVJfUExVU19CWTIu
CgpUaGUgY29kZSBjb3VsZCBiZSBsaWtlOgoKICAgICAgICBjYXNlIFVTQkRFVkZTX0dFVF9TUEVF
RDoKICAgICAgICAgICAgICAgIHJldCA9IHBzLT5kZXYtPnNwZWVkOworICAgICAgICAgICAgICAg
aWYgKHJldCA9PSBVU0JfU1BFRURfU1VQRVJfUExVUyAmJgorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHBzLT5kZXYtPnNzcF9yYXRlID09IFVTQl9TU1BfR0VOXzJ4MikKKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0ID0gVVNCREVWRlNfU1BFRURfU1VQRVJfUExVU19CWTI7CiAgICAg
ICAgICAgICAgICBicmVhazsKCkJ5IHRoaXMgd2F5LCBubyBuZWVkIHRvIGFkZCBhIG5ldyBpb2N0
bC4gTm8gbmVlZCB0byB0b3VjaCBzbyBtYW55IGZpbGVzLiBBbmQgd2hlbiBuZXcKc3BlZWRzIGFy
ZSBhZGRlZCBsYXRlciwganVzdCAjZGVmaW5lIG5ldyB2YWx1ZXMgYW5kIGV4dGVuZCB0aGUgY2hl
Y2tzIGluIGFib3ZlIGNvZGUuCkNvbXBhdGliaWxpdHkgaXMgYWxzbyBtYWludGFpbmVkLiBCZWZv
cmUgdGhpcyBjaGFuZ2UsIFVTQkRFVkZTX0dFVF9TUEVFRCBjb3VsZApyZXR1cm4gMC02LiBBZnRl
ciB0aGlzIGNoYW5nZSwgd2UgY2FuIHN0aWxsIHJldHVybiAwLTYgZm9yIG1vc3Qgb2YgdGhlIGNh
c2VzLCBhbmQgNyBmb3IKR0VOXzJ4MiBkZXZpY2VzLgoKUmVnYXJkcywKRGluZ3lhbgo=
