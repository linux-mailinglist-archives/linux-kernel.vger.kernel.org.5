Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3D76332F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjGZKLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGZKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:11:06 -0400
Received: from m13148.mail.163.com (m13148.mail.163.com [220.181.13.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C592DB;
        Wed, 26 Jul 2023 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=kEzGDktM/+2dFVyyjFPbzcIhb2/BgMV5dxaADC7RoBc=; b=G
        GXnMYaqo/NQHEFimQiMRBKbu4ttbjVqI1u3GeodzQ6xsbta5PcuKTfDcC/m+Dqrv
        ZPEi1SOfWZTZP6LQgE0gijV6RT12xK5j7JaF6+V1Dombzx5D5IhXhWRbEaLrZK5o
        9iCjjjbLc9jXL5N1tK0ZhrOHPiRnctNJfOX44ku8Ts=
Received: from 18500469033$163.com ( [43.243.14.10] ) by
 ajax-webmail-wmsvr148 (Coremail) ; Wed, 26 Jul 2023 18:10:30 +0800 (CST)
X-Originating-IP: [43.243.14.10]
Date:   Wed, 26 Jul 2023 18:10:30 +0800 (CST)
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
In-Reply-To: <7d6a6443-b463-b26e-4bb3-3100e6874683@suse.com>
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
 <6be59e4e.8166.1898dd22d84.Coremail.18500469033@163.com>
 <37ae1c44-fe7e-3f0f-0eea-0c684fe04d50@suse.com>
 <3a822c60.6ae8.189918ebd0a.Coremail.18500469033@163.com>
 <7d6a6443-b463-b26e-4bb3-3100e6874683@suse.com>
X-NTES-SC: AL_QuySAv+duUoo5iSRYOkXkkYVgew6WsC4vf4k3IReOps0pyzO4CY6YUZkLXv76+WNNRqIiSG0TQNH7vtdXZBZR4ZFtLyg/rNM2vliTBoA+dCA
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <46fe0641.6f30.18991adbfe3.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lMGowACXWDMX8cBk_hkKAA--.14881W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1S2mDhe4y2SAXDvUnQAAsg
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

QXQgMjAyMy0wNy0yNiAxNzo0OToyNiwgIk9saXZlciBOZXVrdW0iIDxvbmV1a3VtQHN1c2UuY29t
PiB3cm90ZToKPgo+Cj5PbiAyNi4wNy4yMyAxMTozNiwgRGluZ3lhbiBMaSB3cm90ZToKPj4gQXQg
MjAyMy0wNy0yNiAxNjozMzoyMiwgIk9saXZlciBOZXVrdW0iIDxvbmV1a3VtQHN1c2UuY29tPiB3
cm90ZToKPj4+IE9uIDI1LjA3LjIzIDE4OjExLCBEaW5neWFuIExpIHdyb3RlOgo+Pj4gICAKPj4+
PiBJbiBwcm9jX2Nvbm5pbmZvX2V4KCksIHRoZSBudW1iZXIgb2YgcmV0dXJuZWQgYnl0ZXMgaXMg
ZGV0ZXJtaW5lZCBieQo+Pj4+IHRoZSBzbWFsbGVyIG51bWJlciBiZXR3ZWVuIHNpemVvZihzdHJ1
Y3QgdXNiZGV2ZnNfY29ubmluZm9fZXgpIGFuZCBhCj4+Pj4gdXNlciBzcGVjaWZpZWQgc2l6ZS4g
U28gaWYgd2Ugb25seSBhcHBlbmQgbmV3IG1lbWJlcnMgdG8gdGhlIGVuZCBvZgo+Pj4+IHN0cnVj
dCB1c2JkZXZmc19jb25uaW5mb19leCwgaXQgd29uJ3QgaW1wYWN0IHRoZSBieXRlcyBpbiB0aGUg
YmVnaW5uaW5nLgo+Pj4KPj4+IFlvdSBoYXZlIGp1c3QgY2F1c2VkIG1lbW9yeSBjb3JydXB0aW9u
IGluIHVzZXIgc3BhY2UgYnkgb3ZlcndyaXRpbmcgd2hhdAo+Pj4gd2FzIHJpZ2h0IGJlaGluZCB0
aGUgYnVmZmVyIG9mIHRoZSBhZ3JlZWQgdXBvbiBzaXplLiBPciwgbm90IG11Y2ggYmV0dGVyLAo+
Pj4gY2F1c2VkIGEgc2VnbWVudGF0aW9uIGZhdWx0Lgo+Pj4KPj4+IAlSZWdhcmRzCj4+PiAJCU9s
aXZlcgo+PiAKPj4gSG93IGNvbWU/Cj4KPlNvcnJ5LCBJIG1pc3JlYWQgdGhlIGNoZWNrIGF0IHRo
ZSBzdGFydC4KPgo+PiBUaGUgYWN0dWFsIHJldHVybmVkIGJ5dGVzIG11c3QgYmUgc21hbGxlciB0
aGFuIG9yIGVxdWFsIHRvIHVzZXIgc3BlY2lmaWVkIHNpemUuCj4+IFlvdSBjYW4gY2hlY2sgaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNS1yYzMvc291cmNlL2RyaXZlcnMvdXNi
L2NvcmUvZGV2aW8uYyNMMTQ5Mwo+Cj5ZZXMsIHdlIGNhbiBhZGQuIEJ1dCB3aGVyZSBpcyB0aGUg
cG9pbnQ/Cj5Vc2VyIHNwYWNlIGhhcyB0byBiZSBjaGFuZ2VkIHRvIHVzZSBuZXcgc2l6ZXMuCj4K
Ck5vdCBuZWNlc3NhcmlseSwgYnkgdGhpcyB3YXkgYXQgbGVhc3Qgb2xkIHVzZXIgc3BhY2UgY29k
ZSBoYXMgYSBjaGFuY2UgdG8gc3RheQpwdXQgc2luY2UgaXQgY2FuIHN0aWxsIGdldCBiYXNpY2Fs
bHkgdGhlIHNhbWUgYnl0ZXMgbGlrZSBiZWZvcmUsIGp1c3Qgbm90IGluY2x1ZGUKdGhlIG5ld2x5
IGFwcGVuZGVkIGZpZWxkcy4gT2YgY291cnNlLCBpZiBhbnlvbmUgd2FudCB0byBhY2Nlc3MgdGhl
IG5ldyBmaWVsZHMsCnRoZXkgaGF2ZSB0byB1c2UgdGhlIG5ldyBzaXplLgoKPlRoZSBwcm9ibGVt
IGlzIG5vdCB5b3VyIHBhdGNoLiBBZGQgZG9jdW1lbnRhdGlvbiB0byBpdCBhbmQgaXQgaXMgZmlu
ZS4KPldlIGhhdmUgYSBiYXNpYyBpc3N1ZSBoZXJlLiBEbyB3ZSByZXF1aXJlIGxpYnVzYiB0byB1
c2Ugc3lzZnMgb3Igbm90Pwo+CgpZZWFoLCBhZ3JlZSB3aXRoIHRoaXMuCgpSZWdhcmRzLApEaW5n
eWFuCg==
