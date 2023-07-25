Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98AA761C09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjGYOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjGYOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:41:38 -0400
Received: from m13148.mail.163.com (m13148.mail.163.com [220.181.13.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BA7D2689;
        Tue, 25 Jul 2023 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=n8RN2LeHuyQLewQVgikaE+mv7gglBurfr1Oy3pNDegs=; b=q
        DGvcG/WaJXSxkLAoSwW0/kn/ItnZyfMiJTHXChN6SCfdzn2nIN1y6oKEauRC+bw6
        Nc6qRUrpPNSsZUILugnyORsG94TmaufwiHrpFYhI0oMYBBs/6y6CGbHmC4ZYTUrL
        v3Zbul3f4zCCChrpUnGqIQ5WHNNJ5CLUR3Hnmcbon8=
Received: from 18500469033$163.com ( [114.253.21.2] ) by
 ajax-webmail-wmsvr148 (Coremail) ; Tue, 25 Jul 2023 22:40:10 +0800 (CST)
X-Originating-IP: [114.253.21.2]
Date:   Tue, 25 Jul 2023 22:40:10 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Oliver Neukum" <oneukum@suse.com>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ca4ad735-5605-3fd4-c903-fe5b039cf6a8@suse.com>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
 <ca4ad735-5605-3fd4-c903-fe5b039cf6a8@suse.com>
X-NTES-SC: AL_QuySAv6SuUgq5iacZukXkkYVgew6WsC4vf4k3IReOps0pyzy0yYpdn1MHmrp98KlOQmxshqMdjJLwcVkXYJAUalIgNO15SOEnADG2j+fGlEt
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3018cd33.7ee4.1898d7e4798.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lMGowAC3nzLK3r9keXwJAA--.10896W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbB5xK3y2BHLCLnLgABso
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

CkF0IDIwMjMtMDctMjUgMjI6MDg6NDQsICJPbGl2ZXIgTmV1a3VtIiA8b25ldWt1bUBzdXNlLmNv
bT4gd3JvdGU6Cj5PbiAyNS4wNy4yMyAxNTo1NCwgRGluZ3lhbiBMaSB3cm90ZToKPgo+PiBJZiB3
ZSBjYW4ndCAiZGVwcmVjYXRlIiBpb2N0bHMsIGNhbiB3ZSBjaGFuZ2UgdGhlIHJldHVybmVkIGNv
bnRlbnRzIG9mIGV4aXN0aW5nIG9uZXM/Cj4KPk5vLiBBYnNvbHV0ZWx5IG5vdC4gVGhhdCBpcyB0
b3RhbGx5IHVuYWNjZXB0YWJsZS4gSXQgd291bGQgYmUgbXVjaAo+d29yc2UgdGhhbiBqdXN0IHJl
bW92aW5nIHRoZSBzdXBwb3J0Lgo+Cj4JUmVnYXJkcwo+CQlPbGl2ZXIKCkdvdCBpdCwgSSBndWVz
cyB0aGlzIGlzIGZvciBiYWNrd2FyZC1jb21wYXRpYmlsaXR5LgoKSSBhbHNvIGhhdmUgYW5vdGhl
ciB0aG91Z2h0LiBVU0JERVZGU19DT05OSU5GT19FWCBpcyBraW5kIG9mIHNwZWNpYWwgYW5kCnVz
ZWQgdG8gcmV0cmlldmUgY29udGVudHMgb2YgdmFyaWFibGUgbGVuZ3RoLiBJZiB5b3UgY2hlY2sg
cHJvY19jb25uaW5mb19leCgpLApJIHRoaW5rIG1heWJlIHdlIGNhbiBhcHBlbmQgYSBuZXcgbWVt
YmVyIHRvICJzdHJ1Y3QgdXNiZGV2ZnNfY29ubmluZm9fZXgiCndpdGhvdXQgYnJlYWtpbmcgYmFj
a3dhcmQtY29tcGF0aWJpbGl0eS4KCkJ5IHRoaXMgd2F5LCB3ZSBjYW4gYXZvaWQgYWRkaW5nIGEg
bmV3IGlvY3RsLiBPciBldmVuIG1vcmUgYWdncmVzc2l2ZWx5LApkcm9wIFVTQkRFVkZTX0dFVF9T
UEVFRCBhbmQgZm9yY2UgZXZlcnlvbmUgdG8gdXNlIFVTQkRFVkZTX0NPTk5JTkZPX0VYCnNpbmNl
IGl0IGNhbiBhbHNvIHJldHVybiBkZXZpY2Ugc3BlZWQuCgoKUmVnYXJkcywKRGluZ3lhbg==
