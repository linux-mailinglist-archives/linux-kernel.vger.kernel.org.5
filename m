Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F4763278
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjGZJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjGZJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:37:47 -0400
Received: from m13116.mail.163.com (m13116.mail.163.com [220.181.13.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF044212C;
        Wed, 26 Jul 2023 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=nPGo1QuOhpm3dp/5fqMN+eMceLHx8jiOFAPOyxxO6Ds=; b=R
        NIshj+nIPpQm2DDzMteKA0bAoGqwPZCRmjtu3LzB0rqrOHd9+fxwAKi6lsFA9Gxe
        U556dYnUxvPbDSH2YPu1AEmje3D+OwfK622Ecngq3pDX0W8HQk62yS8Y/p8PvuMz
        uX72M2n845TIp1dja8JLkbBaHRSKrRwaoQ+/Is9tjY=
Received: from 18500469033$163.com ( [43.243.14.10] ) by
 ajax-webmail-wmsvr116 (Coremail) ; Wed, 26 Jul 2023 17:36:38 +0800 (CST)
X-Originating-IP: [43.243.14.10]
Date:   Wed, 26 Jul 2023 17:36:38 +0800 (CST)
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
In-Reply-To: <37ae1c44-fe7e-3f0f-0eea-0c684fe04d50@suse.com>
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
X-NTES-SC: AL_QuySAv+du0ki7iGdZekXkkYVgew6WsC4vf4k3IReOps0qivo8w8QYWR6H0vb/8imCwqFqwO5VwVXxMBHV4ZfZq4bE1j5G/KDeLX+ZsbHxY1l
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3a822c60.6ae8.189918ebd0a.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dMGowACHr1Qn6cBkmFQKAA--.58255W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBUQe4y1aEFBK1RwAAsD
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

QXQgMjAyMy0wNy0yNiAxNjozMzoyMiwgIk9saXZlciBOZXVrdW0iIDxvbmV1a3VtQHN1c2UuY29t
PiB3cm90ZToKPk9uIDI1LjA3LjIzIDE4OjExLCBEaW5neWFuIExpIHdyb3RlOgo+ICAKPj4gSW4g
cHJvY19jb25uaW5mb19leCgpLCB0aGUgbnVtYmVyIG9mIHJldHVybmVkIGJ5dGVzIGlzIGRldGVy
bWluZWQgYnkKPj4gdGhlIHNtYWxsZXIgbnVtYmVyIGJldHdlZW4gc2l6ZW9mKHN0cnVjdCB1c2Jk
ZXZmc19jb25uaW5mb19leCkgYW5kIGEKPj4gdXNlciBzcGVjaWZpZWQgc2l6ZS4gU28gaWYgd2Ug
b25seSBhcHBlbmQgbmV3IG1lbWJlcnMgdG8gdGhlIGVuZCBvZgo+PiBzdHJ1Y3QgdXNiZGV2ZnNf
Y29ubmluZm9fZXgsIGl0IHdvbid0IGltcGFjdCB0aGUgYnl0ZXMgaW4gdGhlIGJlZ2lubmluZy4K
Pgo+WW91IGhhdmUganVzdCBjYXVzZWQgbWVtb3J5IGNvcnJ1cHRpb24gaW4gdXNlciBzcGFjZSBi
eSBvdmVyd3JpdGluZyB3aGF0Cj53YXMgcmlnaHQgYmVoaW5kIHRoZSBidWZmZXIgb2YgdGhlIGFn
cmVlZCB1cG9uIHNpemUuIE9yLCBub3QgbXVjaCBiZXR0ZXIsCj5jYXVzZWQgYSBzZWdtZW50YXRp
b24gZmF1bHQuCj4KPglSZWdhcmRzCj4JCU9saXZlcgoKSG93IGNvbWU/CgpUaGUgYWN0dWFsIHJl
dHVybmVkIGJ5dGVzIG11c3QgYmUgc21hbGxlciB0aGFuIG9yIGVxdWFsIHRvIHVzZXIgc3BlY2lm
aWVkIHNpemUuCllvdSBjYW4gY2hlY2sgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djYuNS1yYzMvc291cmNlL2RyaXZlcnMvdXNiL2NvcmUvZGV2aW8uYyNMMTQ5MwoKUmVnYXJkcywK
RGluZ3lhbg==
