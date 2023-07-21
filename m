Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED775C6F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGUMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGUMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:35:59 -0400
X-Greylist: delayed 658 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 05:35:57 PDT
Received: from m1313.mail.163.com (m1313.mail.163.com [220.181.13.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02A361737;
        Fri, 21 Jul 2023 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=FaztSCj5RQUHZ12KNK6cQyFKtJrGabzM7fea7HPnMFk=; b=S
        BSdH+OsNC8KFZgJUVFXI49cCTnOM/3ZivjEmGtt7RQ5lDuUIE/ESsbziFsxZHTsZ
        6+s6AQTMfKJ/V6M5YjRAWrKQpK2gfBdnu+lHouwOVGCD1tgxFDcteXqhsmjoPnJo
        H6uOT5jmfHCjC7Fhs+nq3l58O+Q9tQk9f2i2vhp6d0=
Received: from 18500469033$163.com ( [114.253.21.2] ) by
 ajax-webmail-wmsvr13 (Coremail) ; Fri, 21 Jul 2023 20:35:37 +0800 (CST)
X-Originating-IP: [114.253.21.2]
Date:   Fri, 21 Jul 2023 20:35:37 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <2023072105-lethargic-saddling-ad97@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
X-NTES-SC: AL_QuyTC/WfvUEo4SGebOkXkkYVgew6WsC4vf4k3IReOps0oCnt2g4hdFtKOWXR7+yPBgeFlDySWSpW1u1UebtIWanLWr2isHBC7zX7wiD4ePqw
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: DcGowABXZwuZe7pk998FAA--.52575W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1S2mDhmzy2SAXAWpcQAAsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDctMjEgMTk6MDQ6MjksICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDQ6NDA6MzlQTSArMDgwMCwg
RGluZ3lhbiBMaSB3cm90ZToKPj4gVGhlIHVzYmZzIGludGVyZmFjZSBkb2VzIG5vdCBwcm92aWRl
IGFueSB3YXkgdG8gZ2V0IHNwZWNpZmljCj4+IHN1cGVyc3BlZWRwbHVzIHJhdGUsIGxpa2UgR2Vu
MngxLCBHZW4xeDIgb3IgR2VuMngyLiBDdXJyZW50Cj4+IEFQSSBpbmNsdWRlIGFuIFVTQkRFVkZT
X0dFVF9TUEVFRCBpb2N0bCwgYnV0IGl0IGNhbiBvbmx5IHJldHVybgo+PiBnZW5lcmFsIHN1cGVy
c3BlZWRwbHVzIHNwZWVkIGluc3RlYWQgb2YgYW55IHNwZWNpZmljIHJhdGVzLgo+PiBUaGVyZWZv
cmUgd2UgY2FuJ3QgdGVsbCB3aGV0aGVyIGl0J3MgYSBHZW4yeDIoMjBHYnBzKSBkZXZpY2UuCj4+
IAo+PiBUaGlzIHBhdGNoIGludHJvZHVjZSBhIG5ldyBpb2N0bCBVU0JERVZGU19HRVRfU1NQX1JB
VEUgdG8gZml4Cj4+IGl0LiBTaW1pbGFyIGluZm9ybWF0aW9uIGlzIGFscmVhZHkgYXZhaWxhYmxl
IHZpYSBzeXNmcywgaXQncwo+PiBnb29kIHRvIGFkZCBpdCBmb3IgdXNiZnMgdG9vLgo+PiAKPj4g
U2lnbmVkLW9mZi1ieTogRGluZ3lhbiBMaSA8MTg1MDA0NjkwMzNAMTYzLmNvbT4KPj4gLS0tCj4+
ICBkcml2ZXJzL3VzYi9jb3JlL2RldmlvLmMgICAgICAgICAgfCAzICsrKwo+PiAgaW5jbHVkZS91
YXBpL2xpbnV4L3VzYmRldmljZV9mcy5oIHwgMSArCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvZGV2aW8uYyBi
L2RyaXZlcnMvdXNiL2NvcmUvZGV2aW8uYwo+PiBpbmRleCAxYTE2YThiZGVhNjAuLjJmNTdlYjE2
MzM2MCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy91c2IvY29yZS9kZXZpby5jCj4+ICsrKyBiL2Ry
aXZlcnMvdXNiL2NvcmUvZGV2aW8uYwo+PiBAQCAtMjc4Myw2ICsyNzgzLDkgQEAgc3RhdGljIGxv
bmcgdXNiZGV2X2RvX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+
PiAgCWNhc2UgVVNCREVWRlNfR0VUX1NQRUVEOgo+PiAgCQlyZXQgPSBwcy0+ZGV2LT5zcGVlZDsK
Pj4gIAkJYnJlYWs7Cj4+ICsJY2FzZSBVU0JERVZGU19HRVRfU1NQX1JBVEU6Cj4+ICsJCXJldCA9
IHBzLT5kZXYtPnNzcF9yYXRlOwo+PiArCQlicmVhazsKPgo+U2hvdWxkbid0IHRoaXMgbmV3IGlv
Y3RsIGJlIGRvY3VtZW50ZWQgc29tZXdoZXJlPyAgV2hhdCBhcmUgdGhlIHZhbGlkCj52YWx1ZXMg
aXQgY2FuIHJldHVybj8gIFdoYXQgaWYgaXQgaW4ndCBhIHN1cGVyc3BlZWQgZGV2aWNlPyAgV2hv
IGlzCj5nb2luZyB0byB1c2UgdGhpcz8KPgo+QW5kIHdlIGhhdmUgdHJhZGl0aW9uYWxseSBvbmx5
IGJlZW4gYWRkaW5nIG5ldyBpbmZvcm1hdGlvbiBsaWtlIHRoaXMgdG8KPnN5c2ZzLCB3aGljaCB3
YXMgbm90IGFyb3VuZCB3aGVuIHVzYmZzIHdhcyBjcmVhdGVkLiAgV2h5IG5vdCBqdXN0IHVzZQo+
dGhhdCBpbnN0ZWFkPyAgQXJlIHlvdSB3YW50aW5nIHRvIHNlZSBhbGwgb2YgdGhlIHN5c2ZzLXBy
b3ZpZGVkCj5pbmZvcm1hdGlvbiBpbiB1c2JmcyBhbHNvPwo+Cj50aGFua3MsCj4KCj5ncmVnIGst
aAoKMS4gQnkgc2F5aW5nICJiZSBkb2N1bWVudGVkIHNvbWV3aGVyZSIsIGRvIHlvdSBtZWFuIHRo
ZXJlIGlzIGV4dHJhCiAgICBkb2N1bWVudGF0aW9uIHdvcmsgd2hpY2ggbmVlZHMgdG8gYmUgZG9u
ZT8gU29ycnkgdGhhdCBJIG1pc3NlZCB0aGlzCiAgICBwYXJ0IHNpbmNlIGl0J3MgdGhlIGZpcnN0
IHRpbWUgZm9yIG1lIHRvIHdvcmsgb24gYSBrZXJuZWwgcGF0Y2guCjIuIElmIG5vIGVycm9yLCBy
ZXR1cm5lZCB2YWx1ZXMgYXJlICJlbnVtIHVzYl9zc3BfcmF0ZSIgZGVmaW5lZCBpbiBpbmNsdWRl
L2xpbnV4L3VzYi9jaDkuaAozLiBzc3AgcmF0ZSBpcyBvbmx5IHZhbGlkIGZvciBzdXBlcnNwZWVk
cGx1cy4gRm9yIG90aGVyIHNwZWVkcywgaXQgc2hvdWxkIGJlCiAgICBVU0JfU1NQX0dFTl9VTktO
T1dOLgo0LiBJIGZvdW5kIGluIGxpYnVzYiwgdGhlcmUgYXJlIHR3byB3YXlzIHRvIGdldCBzcGVl
ZCB2YWx1ZSBmb3IgYSBkZXZpY2UuCiAgICBPbmUgd2F5IGlzIHZpYSBzeXNmcywgd2hpY2ggaGFz
IHN1cHBvcnRlZCAyMEdicHMgbm93LiBBbm90aGVyIHdheSBpcwogICAgdG8gdXNlIGlvY3RsIFVT
QkRFVkZTX0dFVF9TUEVFRC4gVGhpcyBpcyB3aGVuIEkgZm91bmQgdGhpcyBpb2N0bCBjYW4gb25s
eQogICAgcmV0dXJuIFVTQl9TUEVFRF9TVVBFUl9QTFVTIGF0IG1vc3QsIGl0IGNhbm5vdCBkZXRl
cm1pbmUgY3VycmVudCBzc3AgcmF0ZQogICAgZnVydGhlciwgbm8gbWF0dGVyIEdlbjF4MigxMEdi
cHMpLCBHZW4yeDEoMTBHYnBzKSBvciBHZW4yeDIoMjBHYnBzKS4gU28gSQogICAgdGhvdWdodCBt
YXliZSBpdCdzIGdvb2QgdG8gcHJvdmlkZSBhIHNpbWlsYXIgd2F5IGxpa2UgaW9jdGwgVVNCREVW
RlNfR0VUX1NQRUVECiAgICBpbiBvcmRlciB0byBnZXQgc3NwIHJhdGVzLgo1LiBPa2F5LCBub3cg
SSBnZXQgaXQgdGhhdCBzeXNmcyBpcyBhIHJlcGxhY2VtZW50IGZvciB1c2Jmcy4gRXZlbiBpbiBs
aWJ1c2IsIHN5c2ZzIGlzIHRoZQogICAgcHJlZmVycmVkIHdheSwgdGhlbiBmYWxsIGJhY2sgdG8g
dXNiZnMgaWYgc3lzZnMgZG9lc24ndCBleGlzdC4gTXkgaW50ZW50aW9uIGlzIG5vdCB0byBzZWUK
ICAgIGFsbCBvZiB0aGUgc3lzZnMtcHJvdmlkZWQgaW5mb3JtYXRpb24gaW4gdXNiZnMgYWxzby4g
QW55d2F5LCBpZiB5b3UgdGhpbmsgdGhpcyBwYXRjaCBpcwogICAgcmVhbGx5IHVubmVjZXNzYXJ5
LCBJJ20gdG90YWxseSBmaW5lIHRvIHdpdGhkcmF3IGl0IHRvby4KCgpSZWdhcmRzLApEaW5neWFu

