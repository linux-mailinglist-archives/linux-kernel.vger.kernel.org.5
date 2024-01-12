Return-Path: <linux-kernel+bounces-24299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA682BA95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838011F25D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C405B5C0;
	Fri, 12 Jan 2024 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e+dXlrz0"
Received: from m13147.mail.163.com (m13147.mail.163.com [220.181.13.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D25B5B9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NHxktqG/f66mPydOSWSUf0yLZRu2tHfLC5IFIGeGNEg=; b=e
	+dXlrz0msQq2gp9A4FOgaRMjNOYKtWwrDxAEtMvZUihrFji181xj3fl9oO/o9x/f
	CrTU/wri+wrBmBwn1WGGVCmrnWeLgCR3NIKvl+vYZmqzpdWAyKQBcCrc0AQQe22L
	UWqhQTC2NVe1uV977JjBtNBI2tkmsU8aU9sglGtDP8=
Received: from sensor1010$163.com ( [36.4.236.25] ) by ajax-webmail-wmsvr147
 (Coremail) ; Fri, 12 Jan 2024 13:03:47 +0800 (CST)
Date: Fri, 12 Jan 2024 13:03:47 +0800 (CST)
From: lizhe  <sensor1010@163.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] hrtimer.c : Remove redundant thread state settings
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <877ckfkefv.ffs@tglx>
References: <20240110141349.52718-1-sensor1010@163.com>
 <877ckfkefv.ffs@tglx>
X-NTES-SC: AL_Qu2bB/yYukAp4SeRbekXnEYbhes6WcawuPUn34ZXN5E0pizNyy0tYVBsFlza9dKJNxKXnzeOWgNM8uJqe4ZaeaQfy1TWhmCFc5ADusj+CHcm
Content-Type: multipart/mixed; 
	boundary="----=_Part_19914_641272657.1705035827801"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <257fc950.14ca.18cfc0e0a5a.Coremail.sensor1010@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:k8GowAD3Xzg0yKBlRfwCAA--.29994W
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiWBZjq2VOA+EtEwACsz
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

------=_Part_19914_641272657.1705035827801
Content-Type: multipart/alternative; 
	boundary="----=_Part_19916_1101272449.1705035827801"

------=_Part_19916_1101272449.1705035827801
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

CgoKCgoKSGksIAogICAgUGxlYXNlIHJldmlldyB0aGlzIHBhdGNoLCBJdCBkb2VzIG5vdCBjaGVj
ayB0aGUgY29uZGl0aW9uIHdoZW4gZXhlY3V0aW5nIHRoZSBzY2hlZHVsZXIoKSBmdW5jdGlvbi4K
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTGl6
aGUKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoYW5rcwoKCgoKCgoKCgoKCkF0
IDIwMjQtMDEtMTIgMDA6NDQ6MjAsICJUaG9tYXMgR2xlaXhuZXIiIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+IHdyb3RlOgo+T24gV2VkLCBKYW4gMTAgMjAyNCBhdCAwNjoxMywgTGl6aGUgd3JvdGU6Cj4+
IEFmdGVyIGEgdGhyZWFkIGlzIGF3YWtlbmVkLCBpdHMgc3RhdGUgaXMgYWxyZWFkeSB0YXNrX3J1
bm5pbmcKPgo+VGhhdCdzIGNvcnJlY3QsIGJ1dCBwbGVhc2UgbG9vayBhdCBocnRpbWVyX3dha2V1
cCgpIGFuZCB0aGUgY29uZGl0aW9uYWwKPnNjaGVkdWxlKCkgaW52b2NhdGlvbiBpbiBzY2hlZHVs
ZV9ocnRpbWVvdXRfcmFuZ2VfY2xvY2soKS4gWW91IGJyZWFrIHRoZQo+Z3VhcmFudGVlIHRoYXQg
dGhpcyBmdW5jdGlvbiByZXR1cm5zIHdpdGggdGFzayBzdGF0ZSA9PSBUQVNLX1JVTk5JTkcuCj4K
PlRoYW5rcywKPgo+ICAgICAgICB0Z2x4Cg==
------=_Part_19916_1101272449.1705035827801
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwIHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9wPjxwIHN0eWxl
PSJtYXJnaW46IDA7Ij48YnI+PC9wPjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPkhpLCZuYnNwOzwv
ZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPiZuYnNwOyAmbmJzcDsgUGxlYXNlIHJldmlldyB0
aGlzIHBhdGNoLCBJdCBkb2VzIG5vdCBjaGVjayB0aGUgY29uZGl0aW9uIHdoZW4gZXhlY3V0aW5n
IHRoZSBzY2hlZHVsZXIoKSBmdW5jdGlvbi48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij4m
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDs8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij4m
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDs8c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxNnB4OyI+PGI+TGl6
aGU8L2I+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6IDE2cHg7Ij48Yj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDs8
L2I+dGhhbmtzPC9zcGFuPjwvZGl2PjxwIHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9wPjxwIHN0
eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9wPjxkaXYgc3R5bGU9InBvc2l0aW9uOnJlbGF0aXZlO3pv
b206MSI+PC9kaXY+PGRpdiBpZD0iZGl2TmV0ZWFzZU1haWxDYXJkIj48L2Rpdj48cCBzdHlsZT0i
bWFyZ2luOiAwOyI+PGJyPjwvcD48cHJlPjxicj5BdCAyMDI0LTAxLTEyIDAwOjQ0OjIwLCAiVGhv
bWFzIEdsZWl4bmVyIiAmbHQ7dGdseEBsaW51dHJvbml4LmRlJmd0OyB3cm90ZToKJmd0O09uIFdl
ZCwgSmFuIDEwIDIwMjQgYXQgMDY6MTMsIExpemhlIHdyb3RlOgomZ3Q7Jmd0OyBBZnRlciBhIHRo
cmVhZCBpcyBhd2FrZW5lZCwgaXRzIHN0YXRlIGlzIGFscmVhZHkgdGFza19ydW5uaW5nCiZndDsK
Jmd0O1RoYXQncyBjb3JyZWN0LCBidXQgcGxlYXNlIGxvb2sgYXQgaHJ0aW1lcl93YWtldXAoKSBh
bmQgdGhlIGNvbmRpdGlvbmFsCiZndDtzY2hlZHVsZSgpIGludm9jYXRpb24gaW4gc2NoZWR1bGVf
aHJ0aW1lb3V0X3JhbmdlX2Nsb2NrKCkuIFlvdSBicmVhayB0aGUKJmd0O2d1YXJhbnRlZSB0aGF0
IHRoaXMgZnVuY3Rpb24gcmV0dXJucyB3aXRoIHRhc2sgc3RhdGUgPT0gVEFTS19SVU5OSU5HLgom
Z3Q7CiZndDtUaGFua3MsCiZndDsKJmd0OyAgICAgICAgdGdseAo8L3ByZT48L2Rpdj4=
------=_Part_19916_1101272449.1705035827801--

------=_Part_19914_641272657.1705035827801
Content-Type: application/octet-stream; 
	name=0001-drivers-dm-crypt.c-remove-redundant-state-settings-a.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-drivers-dm-crypt.c-remove-redundant-state-settings-a.patch"

RnJvbSA4MWE2OTIwNTE3ZTVlMmQ5YWM2ZjViM2U0NjRiNjRiNTUwZjA3MDQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaXpoZSA8c2Vuc29yMTAxMEAxNjMuY29tPgpEYXRlOiBUaHUs
IDExIEphbiAyMDI0IDIwOjU3OjAxIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gZHJpdmVycy9kbS1j
cnlwdC5jIDogcmVtb3ZlIHJlZHVuZGFudCBzdGF0ZSBzZXR0aW5ncyBhZnRlcgogd2FraW5nIHVw
CgpUaGUgdGFzayBzdGF0dXMgaGFzIGJlZW4gc2V0IHRvIFRBU0tfUlVOTklORyBpbiBzY2hlZHVs
ZSgpLgpObyBuZWVkIHRvIHNldCBhZ2FpbiBoZXJlLgoKU2lnbmVkLW9mZi1ieTogTGl6aGUgPHNl
bnNvcjEwMTBAMTYzLmNvbT4KLS0tCiBkcml2ZXJzL21kL2RtLWNyeXB0LmMgfCAxIC0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9kbS1jcnlw
dC5jIGIvZHJpdmVycy9tZC9kbS1jcnlwdC5jCmluZGV4IDg1NWI0ODJjYmZmMS4uYWIxZTMwNjMw
ZTY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL21kL2RtLWNyeXB0LmMKKysrIGIvZHJpdmVycy9tZC9k
bS1jcnlwdC5jCkBAIC0xOTQ4LDcgKzE5NDgsNiBAQCBzdGF0aWMgaW50IGRtY3J5cHRfd3JpdGUo
dm9pZCAqZGF0YSkKIAogCQlzY2hlZHVsZSgpOwogCi0JCXNldF9jdXJyZW50X3N0YXRlKFRBU0tf
UlVOTklORyk7CiAJCXNwaW5fbG9ja19pcnEoJmNjLT53cml0ZV90aHJlYWRfbG9jayk7CiAJCWdv
dG8gY29udGludWVfbG9ja2VkOwogCi0tIAoyLjI1LjEKCg==
------=_Part_19914_641272657.1705035827801--


