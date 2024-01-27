Return-Path: <linux-kernel+bounces-41185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 290DC83ED10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4D6B22F05
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3720DDD;
	Sat, 27 Jan 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="mWiJavxc"
Received: from m13139.mail.163.com (m13139.mail.163.com [220.181.13.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A69D51B;
	Sat, 27 Jan 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.13.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706358700; cv=none; b=gq/Fs+OYvoqVh0DHLM4CVuc/DfXwT9rt0GdEqU1dkQwOvtvEIxSRgjnNE/gK/aabHoWfoRCTlzlkDujcryvjtroQnXwwH8r/bEJxLJ5RGJYuSYTxaI6Qg3E6akmhWQF7rmTD72H2rm7C5pLS66cM6iymhzjexgGNNQeWDF7cVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706358700; c=relaxed/simple;
	bh=VpaYJg611pNFtLcu4PHL8FORu4w1VV9s+dRZqRr9IOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Nz914lCKJ1QhkS2ro7ostRcI2oMQMxxaM39jSdnXQq8WYv/P2mHL6EB1cLrny90imdxmQ43Fw2p0FcSaQ1qYABtNvtSwugNyqhi2WIePcCOiLVRClbA73og5TvSUpzLMvQwgX3SoIL+LhIc1v6oOmLEPDYrOOw+nJDCCb/JPHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=mWiJavxc reason="signature verification failed"; arc=none smtp.client-ip=220.181.13.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ma9o5iWSbDq/1Z3hTE/8/k25l4jdI+7Y+bhwozoNTcw=; b=m
	WiJavxcnTrDgrQJlFkqw6eMWHjSHG+eVZh3ErJQVYKz/mzpuljqv6C/mvzgslaIt
	4/Jhd8snrHrSsgs0cm55DAvLHBfYU+ZTC5cSsKOaHDzDJI9YBdwC7EYrS2NLPyYr
	RtUQN5qRM4a0rhk+dlGk/okiZRM44CJ3bb7Oq1nIU8=
Received: from andyshrk$163.com ( [58.22.7.114] ) by ajax-webmail-wmsvr139
 (Coremail) ; Sat, 27 Jan 2024 20:15:26 +0800 (CST)
Date: Sat, 27 Jan 2024 20:15:26 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re:Re: [PATCH 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host
 regulator for Cool Pi CM5 EVB
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <2798389.3c9HiEOlIg@diego>
References: <20240127092034.887085-1-andyshrk@163.com>
 <20240127092034.887085-3-andyshrk@163.com> <2798389.3c9HiEOlIg@diego>
X-NTES-SC: AL_Qu2bBP+euE8p4CKZYulS4DxUw7xtJb7F8ohRo94OW8gAvCTt6w8Db1tdMXT1/NOI5AfO+aK8YQzQdyUxQsjv
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23650d42.ecb.18d4ad89c0c.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:i8GowAD3n2Le87RlFZ0GAA--.64795W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g1yXmWXvvpVlwACsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKSGkgSGVpa2/vvJoKCkF0IDIwMjQtMDEtMjcgMTg6MzY6NDAsICJIZWlrbyBTdMO8Ym5lciIg
PGhlaWtvQHNudGVjaC5kZT4gd3JvdGU6Cj5IaSBBbmR5LAo+Cj5BbSBTYW1zdGFnLCAyNy4gSmFu
dWFyIDIwMjQsIDEwOjIwOjMzIENFVCBzY2hyaWViIEFuZHkgWWFuOgo+PiBBY2NvcmRpbmcgdG8g
dGhlIHNjaGVtYXRpYywgdGhpcyByZWd1bGF0b3IgaXMgdXNlZCBib3RoIGZvciBVU0IzMCBhbmQK
Pj4gVVNCMjAsIHNvIGdpdmUgaXQgYSBtb3JlIGFwcHJvcHJpYXRlIG5hbWUuCj4KPkkgZG9uJ3Qg
aGF2ZSB0aGUgc2NoZW1hdGljcywgc28gSSdsbCBuZWVkIHlvdSB0byBhbnN3ZXIgdGhpcywgYnV0
IHdoYXQKPmlzIHRoZSByZWd1bGF0b3IgY2FsbGVkIF9pbl8gdGhlIHNjaGVtYXRpY3M/CgpUaGVy
ZSBhcmUgdHdvIHJlZ3VsYXRvcnMgY2FsbGVkIFZDQzUwX1VTQl9IT1NUMSBhbmQgVkNDNTBfVVNC
X0hPU1QyLCBhbmQgdGhleSBhcmUgYm90aCBjb250cm9sbGVkIGJ5IEdQSU8xX0Q1ClRoZXkgYm90
aCBmb3IgdHdvIHVzYiAyLjAgaG9zdHMsICBub3QgdXNiIDMwLCB0aGUgc2NoZW1hdGljcyBtYWtl
CiBtZSBhIGJpdCBjb25mdXNlZC4KCj4KPkkuZS4gd2Ugd2FudCByZWd1bGF0b3JzIHRvIHJlYWxs
eSBiZSBuYW1lZCB0aGUgc2FtZSBhcyBpbiB0aGUgc2NoZW1hdGljCj5zbyBwZW9wbGUgY2FuIGxv
b2sgdXAgdGhpbmcgZnJvbSB0aGUgZHRzIGluIHRoZSBzY2hlbWF0aWNzIGFuZCB0aGUgb3RoZXIK
PndheSBhcm91bmQgdG9vLgo+Cj4KPlRoYW5rcwo+SGVpa28KPgo+Cj4+IEZpeGVzOiA3OTFjMTU0
YzM5ODIgKCJhcm02NDogZHRzOiByb2NrY2hpcDogQWRkIHN1cHBvcnQgZm9yIHJrMzU4OCBiYXNl
ZCBib2FyZCBDb29sIFBpIENNNSBFVkIiKQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFlhbiA8YW5k
eXNocmtAMTYzLmNvbT4KPj4gLS0tCj4+IAo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hp
cC9yazM1ODgtY29vbHBpLWNtNS1ldmIuZHRzIHwgNiArKystLS0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtY29vbHBpLWNtNS1ldmIuZHRzIGIvYXJj
aC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtY29vbHBpLWNtNS1ldmIuZHRzCj4+IGlu
ZGV4IDFiNTY4MWZlMDQ3MS4uNWY0MmYxMDY1ZDczIDEwMDY0NAo+PiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1jb29scGktY201LWV2Yi5kdHMKPj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtY29vbHBpLWNtNS1ldmIuZHRzCj4+IEBA
IC04NCw3ICs4NCw3IEBAIHZjYzN2M19sY2Q6IHZjYzN2My1sY2QtcmVndWxhdG9yIHsKPj4gIAkJ
dmluLXN1cHBseSA9IDwmdmNjM3YzX3N5cz47Cj4+ICAJfTsKPj4gIAo+PiAtCXZjYzV2MF91c2Iz
MF9ob3N0OiB2Y2M1djAtdXNiMzAtaG9zdC1yZWd1bGF0b3Igewo+PiArCXZjYzV2MF91c2JfaG9z
dDogdmNjNXYwLXVzYi1ob3N0LXJlZ3VsYXRvciB7Cj4+ICAJCWNvbXBhdGlibGUgPSAicmVndWxh
dG9yLWZpeGVkIjsKPj4gIAkJcmVndWxhdG9yLW5hbWUgPSAidmNjNXYwX2hvc3QiOwo+PiAgCQly
ZWd1bGF0b3ItYm9vdC1vbjsKPj4gQEAgLTIwMCwxMiArMjAwLDEyIEBAICZ1MnBoeTMgewo+PiAg
fTsKPj4gIAo+PiAgJnUycGh5Ml9ob3N0IHsKPj4gLQlwaHktc3VwcGx5ID0gPCZ2Y2M1djBfdXNi
MzBfaG9zdD47Cj4+ICsJcGh5LXN1cHBseSA9IDwmdmNjNXYwX3VzYl9ob3N0PjsKPj4gIAlzdGF0
dXMgPSAib2theSI7Cj4+ICB9Owo+PiAgCj4+ICAmdTJwaHkzX2hvc3Qgewo+PiAtCXBoeS1zdXBw
bHkgPSA8JnZjYzV2MF91c2IzMF9ob3N0PjsKPj4gKwlwaHktc3VwcGx5ID0gPCZ2Y2M1djBfdXNi
X2hvc3Q+Owo+PiAgCXN0YXR1cyA9ICJva2F5IjsKPj4gIH07Cj4+ICAKPj4gCj4KPgo+Cj4KPgo+
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0Cj5saW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKPmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=

