Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0399E76F8DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjHDEQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHDEQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:16:44 -0400
Received: from m13116.mail.163.com (m13116.mail.163.com [220.181.13.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 398713588;
        Thu,  3 Aug 2023 21:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=xPv6x3VKKmuPQmQBUPGKVTtXryPMYLurev9bA83bwtQ=; b=R
        7F9LxoRdITnZ8Yz3XjtGnCZujJIU3X1rKEWLYhvYVLFYEF8MbXmtUhO1zbaB4zLH
        p5MBYA1nDN3q3C0+b7M8BdyGkji2vjkdu5YIWflLcQPfzWBWSNlvp5dLvdJjtaaU
        9WtpwMLETCRB3Iz+QN3VR9OUPFR7PbUbayXn+A0seA=
Received: from 18500469033$163.com ( [114.250.138.216] ) by
 ajax-webmail-wmsvr116 (Coremail) ; Fri, 4 Aug 2023 12:16:19 +0800 (CST)
X-Originating-IP: [114.250.138.216]
Date:   Fri, 4 Aug 2023 12:16:19 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Alan Stern" <stern@rowland.harvard.edu>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Xiaofan Chen" <xiaofanc@gmail.com>,
        "Oliver Neukum" <oneukum@suse.com>,
        "Tormod Volden" <lists.tormod@gmail.com>,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] USB: add usbfs ioctl to get specific
 superspeedplus rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <c10dd3c1-efab-47d6-904f-3b211965be44@rowland.harvard.edu>
References: <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
 <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
 <CAGjSPUDtn-YMqmNrmku+hkyXCKys4XRue4wdzQwr+yGxe2cJSQ@mail.gmail.com>
 <2a82ba01-38dd-fad9-98b9-ac8591107921@redhat.com>
 <151a5748.3e99.189ba07b110.Coremail.18500469033@163.com>
 <51926ee6-ee81-4543-a1f7-338e65a26670@rowland.harvard.edu>
 <a31ee75e-6a8e-fe7b-aadc-f118d9ab60f9@redhat.com>
 <67b68375.80b5.189bc2653e9.Coremail.18500469033@163.com>
 <c10dd3c1-efab-47d6-904f-3b211965be44@rowland.harvard.edu>
X-NTES-SC: AL_QuySA/2ZvU0s7ySeY+kXkkYVgew6WsC4vf4k3IReOps0qivP2gE/YWR8H1fw/8iLJAGFqwORfh1CzPtYfIB8f660DLQ3rFydgckgdgh5fAWT
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5ccfaa7e.3180.189bec2b80e.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dMGowACnwFWTe8xkH0APAA--.29697W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBURPBy1aEFHuregAAsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDgtMDQgMDE6NTY6MDMsICJBbGFuIFN0ZXJuIiA8c3Rlcm5Acm93bGFuZC5oYXJ2
YXJkLmVkdT4gd3JvdGU6Cj5PbiBGcmksIEF1ZyAwNCwgMjAyMyBhdCAxMjowNjoxNUFNICswODAw
LCBEaW5neWFuIExpIHdyb3RlOgo+PiBTbyBhZnRlciB1c2JfZGV2aWNlX3NwZWVkIGlzIGV4dGVu
ZGVkIHdpdGggR2VuMngxLCBHZW4xeDIgYW5kIEdlbjJ4MiwKPj4gaXQgZmVlbHMgdGhhdCBlbnVt
IHVzYl9zc3BfcmF0ZSBiZWNvbWVzIHVzZWxlc3MuIElzIGl0IG9rYXkgdG8ganVzdCBkZWxldGUg
aXQ/Cj4+IEknbSBhc2tpbmcgdGhpcyBzaW5jZSBpdCBpcyBhbHNvIHVzZWQgaW4gc2V2ZXJhbCBv
dGhlciBzb3VyY2UgZmlsZXMgc28gdGhlIGZpeCBtYXkKPj4gbm90IGJlIGFzIHRyaXZpYWwgYXMg
aXQgbG9va3MuCj4KPkFzIGxvbmcgYXMgdGhlIGZpbGUgaXMgYmVpbmcgdXNlZCBieSBvdGhlciBz
b3VyY2UgZmlsZXMsIGRvbid0IGRlbGV0ZSAKPml0LiAgSWYgeW91IHdhbnQgdG8gZml4IHVwIGFs
bCB0aG9zZSBvdGhlciBwbGFjZXMgYW5kIHRoZW4gZGVsZXRlIHRoZSAKPmZpbGUsIHRoYXQncyBm
aW5lLiAgQnV0IG9mIGNvdXJzZSwgaXQgd291bGQgaGF2ZSB0byBiZSBhIHNlcGFyYXRlIHNldCBv
ZiAKPnBhdGNoZXMuCj4KPkl0IHdpbGwgYWxzbyBiZSBuZWNlc3NhcnkgdG8gYXVkaXQgdGhlIHBs
YWNlcyBpbiB0aGUga2VybmVsIHRoYXQgCj5jdXJyZW50bHkgdXNlIHVzYl9kZXZpY2Vfc3BlZWQu
ICBTb21lIG9mIHRoZW0gbWF5IG5lZWQgdG8gYmUgZXh0ZW5kZWQgdG8gCj5oYW5kbGUgdGhlIG5l
dyBlbnRyaWVzIHByb3Blcmx5LiAgKEluY2x1ZGluZywgb2J2aW91c2x5LCB0aGUgcGFydHMgb2Yg
Cj50aGUgY29kZSB0aGF0IHN0b3JlIHRoZSBkZXZpY2UncyBzcGVlZCBpbiB0aGUgZmlyc3QgcGxh
Y2UuKQo+Cgo+QWxhbiBTdGVybgoKQW5vdGhlciBpc3N1ZSBpcyB0aGF0IFVTQl9TUEVFRF9TVVBF
Ul9QTFVTIGhhcyBiZWVuIHdpZGVseSB1c2VkIGluCnNvIG1hbnkgZmlsZXMgdG8gZXhlY3V0ZSBj
b25kaXRpb25hbCBiYW5jaGVzLiBPbmNlIHdlIGV4dGVuZCBhbmQgc3RvcmUgZGV2aWNlJ3MKc3Bl
ZWQgd2l0aCBuZXcgdmFsdWVzIGluIHRoZSBmaXJzdCBwbGFjZSwgd2UgbWlnaHQgbmVlZCB0byBj
aGVjayBhbGwgcGxhY2VzIHdoZXJlClVTQl9TUEVFRF9TVVBFUl9QTFVTIGlzIHVzZWQgaW4gY2Fz
ZSBvZiBhbnkgcmVncmVzc2lvbi4KCkkgdGhpbmsgbWF5YmUgd2UgY2FuIHRyeSB0byByZW1vdmUg
dGhlIGRlcGVuZGVuY3kgb24gZW51bSB1c2JfZGV2aWNlX3NwZWVkCmluIHVzYmZzIGFuZCBkZWZp
bmUgYSBzZXBhcmF0ZSBzZXQgb2Ygc3BlZWQgdmFsdWVzIHNpbWlsYXIgdG8gcHJldmlvdXMgZGVz
aWduCmF0IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXVzYi9tc2cxNTc3MDku
aHRtbApCeSB0aGlzIHdheSwgaW4gdXNiZnMgd2UgZ2V0IG1vcmUgZnJlZWRvbSB0byBkZXRlcm1p
bmUgaG93IHRvIGV4cGxhaW4KdXNiX2RldmljZV9zcGVlZCBhbmQgdXNiX3NzcF9yYXRlLCB3aXRo
b3V0IHRoZSByaXNrIG9mIGJyZWFraW5nIGFueXRoaW5nCmVsc2V3aGVyZS4KCkZvciBleGFtcGxl
LCBkZWZpbmUgYW4gVVNCREVWRlNfU1BFRURfU1VQRVJfUExVUyB0byBpbmRpY2F0ZQpVU0JfU1BF
RURfU1VQRVJfUExVUyB3aXRoIHNzcCByYXRlcyBHRU5fVU5LTk9XTiwgR0VOXzJ4MSBhbmQKR0VO
XzF4Mi4gVGhleSBhbGwgc3RhbmQgZm9yIDEwR2JwcyBhbmQgd2UgZG9uJ3QgbmVlZCB0byB0ZWxs
IG9uZSBmcm9tCmFub3RoZXIsIHNpbWlsYXIgdG8gaG93IGl0IHdvcmtzIGluIHN5c2ZzLiBUaGVu
IGRlZmluZSBhbgpVU0JERVZGU19TUEVFRF9TVVBFUl9QTFVTX0JZMihtYXliZSB0aGVyZSBpcyBh
IG1vcmUgcHJvcGVyIG5hbWUpCnRvIGluZGljYXRlIFVTQl9TUEVFRF9TVVBFUl9QTFVTIHdpdGgg
c3NwIHJhdGUgR0VOXzJ4Miwgd2hpY2ggc3RhbmRzCmZvciAyMEdicHMuCgpSZWdhcmRzLApEaW5n
eWFu
