Return-Path: <linux-kernel+bounces-105094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC087D906
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB21B1F21852
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A38F48;
	Sat, 16 Mar 2024 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LptSJUcs"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530C4C61;
	Sat, 16 Mar 2024 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710568271; cv=none; b=Chxrt+hOsUvwzDlOiUoNJyG6YButCf5kUVYln8fzhTWJKRXFOr9Cul+F00fb5EvEFByG9IMDaas+j4JAyUxaUzjI+7dsyWitlAU7dX0wFjBnaRnNqNdT5WYkkXxkCQiENhHD4ZOVVGFfhi8ZDj14aK2cQ9n2dxvhmzSJXP+SCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710568271; c=relaxed/simple;
	bh=PcvHHTSMBw117q5/ugEHQe5fTF6QB9/SiG4cfaolfFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dCEEBeOe9DKG6jsZKxUyUK+jann/qEsu2tJZ91Z7fcPkl3GcZomlwOUUEBfKK6Rmt7HSNjVmc03z9klDD4m28Xe1ZoIxlgt5iig4T0WYGnyMs/GJx9r0oI6C9iy6MWGJ9G8cVlhdlWwrJQ6v8wYyx5NRgJDY4IssOofdBh4fmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LptSJUcs reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=uFFZvRYf7/jGYNLrlL2FZXdrRg8lHe52BaTJPVTBtY4=; b=L
	ptSJUcs33GjUzP/xYBwwK6Iz5GTgvBR1fIr6wH/daATTWIBntUmWMoaUYjGXXwRM
	y6fmQkEqiumAJUospRt6CrFpvYKiNkAB0WHDVAStlY43soF56Koalaf63BCr5TRR
	SyOjMU7RNfjxQL4B12B/xYpR3HRuljEIFtNFWz3VMU=
Received: from 18500469033$163.com ( [114.250.139.10] ) by
 ajax-webmail-wmsvr-40-125 (Coremail) ; Sat, 16 Mar 2024 13:35:34 +0800
 (CST)
Date: Sat, 16 Mar 2024 13:35:34 +0800 (CST)
From: "Dingyan Li" <18500469033@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] USB: Use EHCI control transfer pid macros instead
 of constant values.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <2024030910-hurled-ibuprofen-1b52@gregkh>
References: <37bdd932-07a4-4514-a5cc-b70d48c962a6@rowland.harvard.edu>
 <20240309033709.14604-1-18500469033@163.com>
 <2024030910-hurled-ibuprofen-1b52@gregkh>
X-NTES-SC: AL_Qu2aAvmduEso4iibYukfm0cQhe89UcW5uf4i3YFTPptwjAzpygQDcWZaMGPb2+CVKxyTiAGOYhNjyPVVXoN3YLoy8R8I4H7Xg8T41AM0/Hb8JQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7ac221bb.256b.18e45c223ba.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_xamL_VlaxoCAA--.6777W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbiQA+jy2VOB6UU+gACsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wMy0wOSAxNToxNDo0OCwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4gd3JvdGU6Cj5PbiBTYXQsIE1hciAwOSwgMjAyNCBhdCAxMTozNzowOUFNICswODAwLCBE
aW5neWFuIExpIHdyb3RlOgo+PiBNYWNyb3Mgd2l0aCBnb29kIG5hbWVzIG9mZmVyIGJldHRlciBy
ZWFkYWJpbGl0eS4gQmVzaWRlcywgYWxzbyBtb3ZlCj4+IHRoZSBkZWZpbml0aW9uIHRvIGVoY2ku
aC4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IERpbmd5YW4gTGkgPDE4NTAwNDY5MDMzQDE2My5jb20+
Cj4+IFJldmlld2VkLWJ5OiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pgo+
PiAtLS0KPj4gVjEgLT4gVjI6IFJlcGxhY2VtZW50IGluIG1vcmUgcGxhY2VzIHdoZXJlIEFsYW4g
cG9pbnRlZCBvdXQuCj4+IAo+Cj5UaGlzIHNob3VsZCBiZSB2MywgYXMgeW91IGhhdmUgYWRkZWQg
QWxhbidzIHJldmlld2VkLWJ5LCBhbmQgYWRkZWQgdGhlCj5wcm9wZXIgdmVyc2lvbmluZyBpbmZv
cm1hdGlvbi4gIFBsZWFzZSByZXNlbmQgaXQgYXMgc3VjaCBhcyBvdXIgdG9vbHMKPmNhbid0IGRp
ZyBpdCBvdXQgZnJvbSB0aGUgZW5kIG9mIHRoZSB0aHJlYWQgbGlrZSB0aGlzIDooCj4KPnRoYW5r
cywKPgo+Z3JlZyBrLWgKCkhpIEdyZWcsCgpTb3JyeSB0aGF0IEknbSBub3QgcXVpdGUgZmFtaWxp
YXIgd2l0aCB0aGUgcHJvY2Vzcy4gIFNpbmNlIEkgaGF2ZW4ndApnb3QgYW55IGZlZWRiYWNrIGZv
ciBhIHdoaWxlIGFmdGVyIHNlbmRpbmcgdGhlIHYzIHBhdGNoLiBEbyB0aGF0IG1lYW4KdGhlIHBh
dGNoIGlzIGFjY2VwdGVkPyBPciBhbnl0aGluZyBlbHNlIEkgc3RpbGwgbmVlZCB0byBpbXByb3Zl
PwoKUmVnYXJkcywKRGluZ3lhbg==

