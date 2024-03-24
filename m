Return-Path: <linux-kernel+bounces-112602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A34887BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E541F21397
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B614280;
	Sun, 24 Mar 2024 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="XuMoMBPP"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C4A1401B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259988; cv=none; b=UzXCZjZa6SjxY3uVSbMMHGsxoKxAEG6cJDANyAbUSgf2X5psjzkZIHxunTsjlirC5cIqBm7tDfKiV3ZKlzlXRiKzCoZspYExhEfcynKvqaGaX3YnjaHpLdErhAMgQ2khSkMkhZMmQ2vqgzKwuPvWUi0Vy4eXME0a5KcQcwwZqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259988; c=relaxed/simple;
	bh=PsuaDPqm8DQofOBUGVCnB35jZD2S7WLofCGY1/+Tg3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Pym+aOoi9e1GXBrG4l/agozmBJB4RAl/k3C/tDbEO/z9zA+gpeeeMHNKE4tTY5fDXvA+4Ef5zHUHwEG5qolZwKnlkWz+ZTugE2Iq1dgRVePfYgzynZaFxt+SvlQDxswpCccELjC9SO5bU6pOy+RWoAW/uR1nMRj3leJ85p5PlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=XuMoMBPP reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2fmT27jHvOGa6PS5j0CUeHGImW686mB4oZoue7hfT8c=; b=X
	uMoMBPPo1DzpN6UZpGc655Uznvr9k0NaqrbvNN4l352YSvRaQa4aKHyWzIjkzjj1
	xkMvcWxzYIaQJUP7yEQxcf/M5Pe/UUNt9047VRqP/klxwxjhK3h5X/kHDRovLAvs
	5a6BAYN/VOXPlXuQ46J6rFwpUnozhkh+UtrrBegSjc=
Received: from lumingyindetect$163.com ( [106.39.130.76] ) by
 ajax-webmail-wmsvr-40-119 (Coremail) ; Sun, 24 Mar 2024 13:59:24 +0800
 (CST)
Date: Sun, 24 Mar 2024 13:59:24 +0800 (CST)
From: lumingyindetect <lumingyindetect@163.com>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re:Re: [PATCH] tools:Fix a memory leak related to variable name
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240323182209.xqzb6rsswvfbg74n@treble>
References: <20240323084526.662556-1-lumingyindetect@163.com>
 <20240323182209.xqzb6rsswvfbg74n@treble>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <492c10a0.1aa3.18e6f0ad487.Coremail.lumingyindetect@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3Xx08wf9lPNMMAA--.65049W
X-CM-SenderInfo: poxpx0hj1l0vphwhu3i6rwjhhfrp/1tbiKRar92VOCH1F9QAFsI
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsgeW91IGZvciB5b3VyIHByb21wdCByZXNwb25zZSEgSXQgaXMgaW5kZWVkIGEgd2lzZSBk
ZWNpc2lvbiBub3QgdG8gcmVsZWFzZSBkeW5hbWljIG1lbW9yeSB3aGVuIHRoZSB0b29sIHJ1bnMg
YnJpZWZseSBhbmQgZW5jb3VudGVycyBlcnJvcnMuIEhvd2V2ZXIsIEkgYWxzbyBub3RpY2VkIGlu
IHRoZSBkaXNhc19mdW5jcyBmdW5jdGlvbiBpbiB0aGUgL2xpbnV4L3Rvb2xzL29ianRvb2wvY2hl
Y2suYyBmaWxlIChsaW5lIDQ2MTcpIHRoYXQgYSB2YXJpYWJsZSBuYW1lZCBjbWQgcG9pbnRpbmcg
dG8gYSBkeW5hbWljIG1lbW9yeSBhcmVhIGlzIG5vdCBiZWluZyBmcmVlZCAocmVnYXJkbGVzcyBv
ZiB3aGV0aGVyIGFuIGVycm9yIG9jY3VycykuIEluIHRoaXMgY2FzZSwgd291bGQgaXQgYmUgbmVj
ZXNzYXJ5IHRvIGFkZCBhIGZyZWUoY21kKT88YnIvPjxici8+LS08YnIvPkx1TWluZ1lpbgpBdCAy
MDI0LTAzLTI0IDAyOjIyOjA5LCAiSm9zaCBQb2ltYm9ldWYiIDxqcG9pbWJvZUBrZXJuZWwub3Jn
PiB3cm90ZToKPk9uIFNhdCwgTWFyIDIzLCAyMDI0IGF0IDA0OjQ1OjI2UE0gKzA4MDAsIEx1TWlu
Z1lpbiB3cm90ZToNCj4+IEluIHRoZSBlbGZfY3JlYXRlX3ByZWZpeF9zeW1ib2wgZnVuY3Rpb24g
ZGVmaW5lZCBpbiB0aGUgL2xpbnV4L3Rvb2xzL29ianRvb2wvZWxmLmMgZmlsZSwgdHdvIHBvaW50
ZXIgdmFyaWFibGVzIHN5bSBhbmQgbmFtZSBhcmUgZGVmaW5lZC4gVGhlIHByb2dyYW0gYWxsb2Nh
dGVzIGR5bmFtaWMgbWVtb3J5IGZvciB0aGUgcG9pbnRlciBzeW0gdXNpbmcgdGhlIGNhbGxvYyBm
dW5jdGlvbiBhdCBsaW5lIDgyMiwgYW5kIGZvciB0aGUgcG9pbnRlciBuYW1lIHVzaW5nIHRoZSBt
YWxsb2MgZnVuY3Rpb24gYXQgbGluZSA4MjQuIFdoZW4gdGhlIGlmIHN0YXRlbWVudCBhdCBsaW5l
IDgyNiByZXR1cm5zIHRydWUsIHRoZSBwcm9ncmFtIHJldHVybnMgYXQgbGluZSA4MjguIFRoZSBj
b250ZW50IG9mIHRoZSBpZiBzdGF0ZW1lbnQgYXQgbGluZSA4MjggaXMgaWYgKHN5bT09TlVMTCB8
fCBuYW1lPT1OVUxMKSwgd2hpY2ggY2hlY2tzIGlmIGVpdGhlciBzeW0gb3IgbmFtZSBpcyBOVUxM
LiBJZiB0aGlzIGNvbmRpdGlvbiByZXR1cm5zIHRydWUsIGl0IGluZGljYXRlcyBhIHNpdHVhdGlv
biB3aGVyZSBvbmUgb2YgdGhlIHBvaW50ZXJzIGhhcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIG1l
bW9yeSBidXQgdGhlIG90aGVyIGhhcyBub3QuIFRoZXJlZm9yZSwgaWYgdGhlIGlmIHN0YXRlbWVu
dCByZXR1cm5zIHRydWUsIGRpcmVjdGx5IHJldHVybmluZyBtYXkgbGVhZCB0byBtZW1vcnkgbGVh
ayBpc3N1ZXMuIEhlbmNlLCBpbiB0aGUgY29kZSwgSSBoYXZlIGFkZGVkIGNoZWNrcyBzZXBhcmF0
ZWx5IGZvciB3aGV0aGVyIHN5bSBhbmQgbmFtZSBhcmUgTlVMTCwgYW5kIGlmIHRoZXkgYXJlIG5v
dCBOVUxMLCB0aGUgY29ycmVzcG9uZGluZyBkeW5hbWljIG1lbW9yeSBzcGFjZXMgYXJlIGZyZWVk
Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBMdU1pbmdZaW4gPGx1bWluZ3lpbmRldGVjdEAxNjMu
Y29tPg0KPg0KPlRoYW5rcyBmb3IgdGhlIHBhdGNoLiAgSW4gZ2VuZXJhbCB3ZSBkb24ndCBjYXJl
IGFib3V0IG1lbW9yeSBsZWFrcyBpbg0KPm9ianRvb2wgKHBhcnRpY3VsYXJseSBpbiBlcnJvciBv
ciBleGl0IHBhdGhzKSwgYXMgaXQncyBhIHNob3J0LXJ1bm5pbmcNCj50b29sLiAgV2hlbiBpdCBl
eGl0cywgYWxsIHRoZSBtZW1vcnkgd2lsbCBiZSBmcmVlZCBhbnl3YXkuICBTbyBpdCdzDQo+ZmFz
dGVyIHRvIG5vdCBmcmVlIHRoZSBtZW1vcnkgbWFudWFsbHkuDQo+DQo+LS0gDQo+Sm9zaA0K

