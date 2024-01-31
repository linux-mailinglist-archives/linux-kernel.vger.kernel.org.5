Return-Path: <linux-kernel+bounces-46430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCF843F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58ED428D7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4079DC4;
	Wed, 31 Jan 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="lNCg89IJ"
Received: from m13147.mail.163.com (m13147.mail.163.com [220.181.13.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714424F5F9;
	Wed, 31 Jan 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.13.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704704; cv=none; b=ebkcMHJBMsGt8361dTBIwUEn09YElpgvwjFm+3CEs5V7AqPnmdKgy7mpsAkpu/YgRv/tJbH4l66g7MOPVepmUTpuFi0jKZzGAf/t3Bi/A7LdSdB9OMT4McMV8oNKLlsn5IEPhVthzjI5z4c2gWoUY942e8y8nhP1EZCrNEYcxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704704; c=relaxed/simple;
	bh=mHd9d/FH2MtCVIYFyEe5ixjfipGnRGfuJ5BcSa6KzPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=oeKorFgPx7Mf5MsHSzpsAlIdYNaTvlsvtdk1UlfSU6gmwAIUtn7S1TCr/mP1LPK7egUWL1EuDjD2C0nI1QlnqjpZRHKQPlQ1Saf9AITvhnTz6Sw8H1epY6Id+GWxaxYElQWvQSrgLV2SdjYJGNuBOgmBqAaEdwTlaXO+K0iU58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=lNCg89IJ reason="signature verification failed"; arc=none smtp.client-ip=220.181.13.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OsSUrux52qy4us14QjKFN5r4cn3VE00WM1oRo7fpI4g=; b=l
	NCg89IJAh3LAg5UcF+fuwzSgcF0WHIqwvyiOEn2rvnS1k+t7yvXp60mzYbrGNhC0
	YfRFdRC7G+a/C+wOHNEUafVeogkqRdSIh7bnyD4ng5FTIdYCsoVE5Oz4ptKahMSR
	lIIZa1A1y4fEY2VIqd7Gy3EsgjHab5/8S1d8YKj89Q=
Received: from andyshrk$163.com ( [58.22.7.114] ) by ajax-webmail-wmsvr147
 (Coremail) ; Wed, 31 Jan 2024 20:21:56 +0800 (CST)
Date: Wed, 31 Jan 2024 20:21:56 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re:Re: [PATCH 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host
 regulator for Cool Pi CM5 EVB
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <00ed78ea06aecde202a11a23c80f80af@manjaro.org>
References: <20240127092034.887085-1-andyshrk@163.com>
 <20240127092034.887085-3-andyshrk@163.com> <2798389.3c9HiEOlIg@diego>
 <23650d42.ecb.18d4ad89c0c.Coremail.andyshrk@163.com>
 <00ed78ea06aecde202a11a23c80f80af@manjaro.org>
X-NTES-SC: AL_Qu2bBPubvE8q4CSZY+kXn0kXhec2W8Czvvgg34JRP5k0pizz/zEdYVBPHkbv9dK1EgWQnzemVhRP8sVDe4tfW5mcBBZtnLa8bqKg/AxG5W1t
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1e98352e.2dd2.18d5f780043.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:k8GowADnDwNkO7pln4MHAA--.45483W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h12XmWXvz1f5gACss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEhlaWtv77yaCgrlnKggMjAyNC0wMS0yNyAyMTowOTo0Nu+8jCJEcmFnYW4gU2ltaWMiIDxk
c2ltaWNAbWFuamFyby5vcmc+IOWGmemBk++8mgo+T24gMjAyNC0wMS0yNyAxMzoxNSwgQW5keSBZ
YW4gd3JvdGU6Cj4+IEF0IDIwMjQtMDEtMjcgMTg6MzY6NDAsICJIZWlrbyBTdMO8Ym5lciIgPGhl
aWtvQHNudGVjaC5kZT4gd3JvdGU6Cj4+PiBBbSBTYW1zdGFnLCAyNy4gSmFudWFyIDIwMjQsIDEw
OjIwOjMzIENFVCBzY2hyaWViIEFuZHkgWWFuOgo+Pj4+IEFjY29yZGluZyB0byB0aGUgc2NoZW1h
dGljLCB0aGlzIHJlZ3VsYXRvciBpcyB1c2VkIGJvdGggZm9yIFVTQjMwIGFuZAo+Pj4+IFVTQjIw
LCBzbyBnaXZlIGl0IGEgbW9yZSBhcHByb3ByaWF0ZSBuYW1lLgo+Pj4gCj4+PiBJIGRvbid0IGhh
dmUgdGhlIHNjaGVtYXRpY3MsIHNvIEknbGwgbmVlZCB5b3UgdG8gYW5zd2VyIHRoaXMsIGJ1dCB3
aGF0Cj4+PiBpcyB0aGUgcmVndWxhdG9yIGNhbGxlZCBfaW5fIHRoZSBzY2hlbWF0aWNzPwo+PiAK
Pj4gVGhlcmUgYXJlIHR3byByZWd1bGF0b3JzIGNhbGxlZCBWQ0M1MF9VU0JfSE9TVDEgYW5kIFZD
QzUwX1VTQl9IT1NUMiwKPj4gYW5kIHRoZXkgYXJlIGJvdGggY29udHJvbGxlZCBieSBHUElPMV9E
NQo+PiBUaGV5IGJvdGggZm9yIHR3byB1c2IgMi4wIGhvc3RzLCAgbm90IHVzYiAzMCwgdGhlIHNj
aGVtYXRpY3MgbWFrZQo+PiBtZSBhIGJpdCBjb25mdXNlZC4KPgo+SW4gdGhhdCBjYXNlLCBJJ2Qg
c2F5IHRoYXQgcmVuYW1pbmcgdGhlIHJlZ3VsYXRvciB0byB2Y2M1djBfdXNiX2hvc3QgaXMKPmZp
bmUsIGJ1dCB0aGVyZSBzaG91bGQgYWxzbyBiZSBhIGNvbW1lbnQgaW4gdGhlIGJvYXJkIGR0cyBm
aWxlIHRoYXQgaXQncwo+YWN0dWFsbHkgdHdvIHNlcGFyYXRlIHJlZ3VsYXRvcnMuCgpIb3cgZG8g
eW91IGZlZWwgYWJvdXQgdGhpcyDvvJ8gT3Igc29tZSBvdGhlciBzdHlsZSBsaWtl77yaCnZjYzV2
MF91c2JfaG9zdDE6IHZjYzV2MF91c2JfaG9zdDLvvJp2Y2M1djAtdXNiLWhvc3QtcmVndWxhdG9y
IHsKCgo+Cj4+PiBJLmUuIHdlIHdhbnQgcmVndWxhdG9ycyB0byByZWFsbHkgYmUgbmFtZWQgdGhl
IHNhbWUgYXMgaW4gdGhlIAo+Pj4gc2NoZW1hdGljCj4+PiBzbyBwZW9wbGUgY2FuIGxvb2sgdXAg
dGhpbmcgZnJvbSB0aGUgZHRzIGluIHRoZSBzY2hlbWF0aWNzIGFuZCB0aGUgCj4+PiBvdGhlcgo+
Pj4gd2F5IGFyb3VuZCB0b28uCj4KPkFoLCB0aGF0J3MgdmVyeSBoZWxwZnVsLgo+Cj4+Pj4gRml4
ZXM6IDc5MWMxNTRjMzk4MiAoImFybTY0OiBkdHM6IHJvY2tjaGlwOiBBZGQgc3VwcG9ydCBmb3Ig
cmszNTg4IAo+Pj4+IGJhc2VkIGJvYXJkIENvb2wgUGkgQ001IEVWQiIpCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogQW5keSBZYW4gPGFuZHlzaHJrQDE2My5jb20+Cj4+Pj4gLS0tCj4+Pj4gCj4+Pj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTg4LWNvb2xwaS1jbTUtZXZiLmR0cyB8IDYg
KysrLS0tCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCj4+Pj4gCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAv
cmszNTg4LWNvb2xwaS1jbTUtZXZiLmR0cyAKPj4+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9j
a2NoaXAvcmszNTg4LWNvb2xwaS1jbTUtZXZiLmR0cwo+Pj4+IGluZGV4IDFiNTY4MWZlMDQ3MS4u
NWY0MmYxMDY1ZDczIDEwMDY0NAo+Pj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2No
aXAvcmszNTg4LWNvb2xwaS1jbTUtZXZiLmR0cwo+Pj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcm9ja2NoaXAvcmszNTg4LWNvb2xwaS1jbTUtZXZiLmR0cwo+Pj4+IEBAIC04NCw3ICs4NCw3
IEBAIHZjYzN2M19sY2Q6IHZjYzN2My1sY2QtcmVndWxhdG9yIHsKPj4+PiAgCQl2aW4tc3VwcGx5
ID0gPCZ2Y2MzdjNfc3lzPjsKPj4+PiAgCX07Cj4+Pj4gCj4+Pj4gLQl2Y2M1djBfdXNiMzBfaG9z
dDogdmNjNXYwLXVzYjMwLWhvc3QtcmVndWxhdG9yIHsKPj4+PiArCXZjYzV2MF91c2JfaG9zdDog
dmNjNXYwLXVzYi1ob3N0LXJlZ3VsYXRvciB7Cj4+Pj4gIAkJY29tcGF0aWJsZSA9ICJyZWd1bGF0
b3ItZml4ZWQiOwo+Pj4+ICAJCXJlZ3VsYXRvci1uYW1lID0gInZjYzV2MF9ob3N0IjsKPj4+PiAg
CQlyZWd1bGF0b3ItYm9vdC1vbjsKPj4+PiBAQCAtMjAwLDEyICsyMDAsMTIgQEAgJnUycGh5MyB7
Cj4+Pj4gIH07Cj4+Pj4gCj4+Pj4gICZ1MnBoeTJfaG9zdCB7Cj4+Pj4gLQlwaHktc3VwcGx5ID0g
PCZ2Y2M1djBfdXNiMzBfaG9zdD47Cj4+Pj4gKwlwaHktc3VwcGx5ID0gPCZ2Y2M1djBfdXNiX2hv
c3Q+Owo+Pj4+ICAJc3RhdHVzID0gIm9rYXkiOwo+Pj4+ICB9Owo+Pj4+IAo+Pj4+ICAmdTJwaHkz
X2hvc3Qgewo+Pj4+IC0JcGh5LXN1cHBseSA9IDwmdmNjNXYwX3VzYjMwX2hvc3Q+Owo+Pj4+ICsJ
cGh5LXN1cHBseSA9IDwmdmNjNXYwX3VzYl9ob3N0PjsKPj4+PiAgCXN0YXR1cyA9ICJva2F5IjsK
Pj4+PiAgfTsKPgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cj5saW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKPmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=

