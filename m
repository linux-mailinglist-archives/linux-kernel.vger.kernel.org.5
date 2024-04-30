Return-Path: <linux-kernel+bounces-163217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805168B6751
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC151C21E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C7915AC4;
	Tue, 30 Apr 2024 01:16:28 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1F14AA9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439788; cv=none; b=CZmDWThRfWX+Y1ZJjIYiPKoJwXFQ2+Umf+K87lEX78xiDmLfzKjKlE+yNqsWkLCScULW3N3S/rkYcDxWASLcQB98upXKd9Wwf6riA6W/XswzZ0R02da5d9rkns97t/VWwIRwN1DicDJo0eQRXk+GfRhfICt15xVES6k69+soVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439788; c=relaxed/simple;
	bh=hb8ftXbxt9/7gZIYsOIxPuf4lvG4pH0PWvKeiX0MBzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IgIunj3aSJikmVoIQ/0mKSgSbtO67kx30y+IsyKVm53rm3GmtH6Zif/3kPH0FvqNzPnnSDjehnIAmabSQH5tISFzArBwgRcfmpu2fzO1towPvCbeOYZ5mavZt5ESDYnFj4ar+xVslqlY3JS0m9wHL75MDvn4Hd4ApJwtcWTKtxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from suijingfeng$bosc.ac.cn ( [219.141.235.82] ) by
 ajax-webmail-mail (Coremail) ; Tue, 30 Apr 2024 09:15:49 +0800 (GMT+08:00)
Date: Tue, 30 Apr 2024 09:15:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6ZqL5pmv5bOw?= <suijingfeng@bosc.ac.cn>
To: "Maxime Ripard" <mripard@kernel.org>
Cc: "Sui Jingfeng" <sui.jingfeng@linux.dev>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"David Airlie" <airlied@gmail.com>, 
	"Daniel Vetter" <daniel@ffwll.ch>, 
	"Douglas Anderson" <dianders@chromium.org>, 
	"Biju Das" <biju.das.jz@bp.renesas.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Re: drm/debugfs: Drop conditionals around of_node pointers
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT5 build
 20230627(00751abc) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <20240429-enchanted-cooperative-jacamar-cf2902@houat>
References: <20240321222258.1440130-1-sui.jingfeng@linux.dev>
 <caa6fb05-8080-444a-93c3-2d9283ccb74d@bosc.ac.cn>
 <20240429-enchanted-cooperative-jacamar-cf2902@houat>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6db82a3f.c7.18f2c927d9f.Coremail.suijingfeng@bosc.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwD3p9hFRjBmHUEjAA--.593W
X-CM-SenderInfo: xvxlyxpqjiv03j6e02nfoduhdfq/1tbiAQAEAWYvsboF9QABs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGksCgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiTWF4aW1lIFJpcGFy
ZCIgPG1yaXBhcmRAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6IDIwMjQtMDQtMjkgMTk6MzA6
MjQgKOaYn+acn+S4gCkKPiDmlLbku7bkuro6ICJTdWkgSmluZ2ZlbmciIDxzdWlqaW5nZmVuZ0Bi
b3NjLmFjLmNuPgo+IOaKhOmAgTogIlN1aSBKaW5nZmVuZyIgPHN1aS5qaW5nZmVuZ0BsaW51eC5k
ZXY+LCAiTWFhcnRlbiBMYW5raG9yc3QiIDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5j
b20+LCAiVGhvbWFzIFppbW1lcm1hbm4iIDx0emltbWVybWFubkBzdXNlLmRlPiwgIkRhdmlkIEFp
cmxpZSIgPGFpcmxpZWRAZ21haWwuY29tPiwgIkRhbmllbCBWZXR0ZXIiIDxkYW5pZWxAZmZ3bGwu
Y2g+LCAiRG91Z2xhcyBBbmRlcnNvbiIgPGRpYW5kZXJzQGNocm9taXVtLm9yZz4sICJMYXVyZW50
IFBpbmNoYXJ0IiA8bGF1cmVudC5waW5jaGFydCtyZW5lc2FzQGlkZWFzb25ib2FyZC5jb20+LCAi
QmlqdSBEYXMiIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4sIGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiDkuLvpopg6IFJl
OiBkcm0vZGVidWdmczogRHJvcCBjb25kaXRpb25hbHMgYXJvdW5kIG9mX25vZGUgcG9pbnRlcnMK
PiAKPiBPbiBTdW4sIEFwciAyOCwgMjAyNCBhdCAwNDo1MjoxM1BNICswODAwLCBTdWkgSmluZ2Zl
bmcgd3JvdGU6Cj4gPiBwaW5nCj4gPiAKPiA+IOWcqCAyMDI0LzMvMjIgMDY6MjIsIFN1aSBKaW5n
ZmVuZyDlhpnpgZM6Cj4gPiA+IEhhdmluZyBjb25kaXRpb25hbCBhcm91bmQgdGhlIG9mX25vZGUg
cG9pbnRlciBvZiB0aGUgZHJtX2JyaWRnZSBzdHJ1Y3R1cmUKPiA+ID4gdHVybnMgb3V0IHRvIG1h
a2UgZHJpdmVyIGNvZGUgdXNlIHVnbHkgI2lmZGVmIGJsb2Nrcy4KPiAKPiBUaGUgY29kZSBiZWlu
ZyB1Z2x5IGlzIGFuIG9waW5pb24sIHdoYXQgcHJvYmxlbSBpcyBpdCBjYXVzaW5nIGV4YWN0bHk/
Cj4gCj4gPiBEcm9wIHRoZSBjb25kaXRpb25hbHMgdG8gc2ltcGxpZnkgZGVidWdmcy4KPiAKPiBX
aGF0IGRvZXMgaXQgc2ltcGxpZmllcz8KPiAKPiA+ID4gCj4gPiA+IEZpeGVzOiBkOGRmY2NkZTI3
MDkgKCJkcm0vYnJpZGdlOiBEcm9wIGNvbmRpdGlvbmFscyBhcm91bmQgb2Zfbm9kZSBwb2ludGVy
cyIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1aSBKaW5nZmVuZyA8c3VpLmppbmdmZW5nQGxpbnV4
LmRldj4KPiAKPiBXaHkgZG8gd2Ugd2FudCB0byBiYWNrcG9ydCB0aGF0IHBhdGNoIHRvIHN0YWJs
ZT8KCk15IGNvbW1pdCBtZXNzYWdlIGlzIHdyaXR0ZW4gYmFzZWQgb24gY29tbWl0IG9mIGQ4ZGZj
Y2RlMjcwOQoKJCBnaXQgc2hvdyBjOWUzNThkZmM0YTgKICAgIAogICAgVGhpcyBwYXRjaCBpcyBi
YXNlZCBvbiBjb21taXQgYzllMzU4ZGZjNGE4ICgiZHJpdmVyLWNvcmU6IHJlbW92ZQogICAgY29u
ZGl0aW9uYWxzIGFyb3VuZCBkZXZpY2V0cmVlIHBvaW50ZXJzIikuCiAgICAKICAgIEhhdmluZyBj
b25kaXRpb25hbCBhcm91bmQgdGhlIG9mX25vZGUgcG9pbnRlciBvZiB0aGUgZHJtX2JyaWRnZQog
ICAgc3RydWN0dXJlIHR1cm5zIG91dCB0byBtYWtlIGRyaXZlciBjb2RlIHVzZSB1Z2x5ICNpZmRl
ZiBibG9ja3MuIERyb3AgdGhlCiAgICBjb25kaXRpb25hbHMgdG8gc2ltcGxpZnkgZHJpdmVycy4g
V2hpbGUgdGhpcyBzbGlnaHRseSBpbmNyZWFzZXMgdGhlIHNpemUKICAgIG9mIHN0cnVjdCBkcm1f
YnJpZGdlIG9uIG5vbi1PRiBzeXN0ZW0sIHRoZSBudW1iZXIgb2YgYnJpZGdlcyB1c2VkIHRvZGF5
CiAgICBhbmQgZm9yZXNlZW4gdG9tb3Jyb3cgb24gdGhvc2Ugc3lzdGVtcyBpcyB2ZXJ5IGxvdywg
c28gdGhpcyBzaG91bGRuJ3QgYmUKICAgIGFuIGlzc3VlLgogICAgCiAgICBTbyBkcm9wICNpZiBj
b25kaXRpb25hbHMgYnkgYWRkaW5nIHN0cnVjdCBkZXZpY2Vfbm9kZSBmb3J3YXJkIGRlY2xhcmF0
aW9uLgoKPiBNYXhpbWUKCkknbSBqdXN0IHN0YXJ0IHRvIGNvbnRyaWJ1dGUgYnkgbWltaWMgb3Ro
ZXIgcGVvcGxlJ3MgdG9uZSwgdGhlcmUgc2VlbXMgbm8gbmVlZAp0byBvdmVyIHJlYWQu

