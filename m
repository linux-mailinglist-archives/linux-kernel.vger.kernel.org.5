Return-Path: <linux-kernel+bounces-31654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9C8331FB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64031F22E99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39651FBC;
	Sat, 20 Jan 2024 00:54:17 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FB17C1;
	Sat, 20 Jan 2024 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.89.151.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712057; cv=none; b=eV23HTgSPlXy9tgiZO5lHKxQhq/icoXgAWhfX4mqxXF0M4u7X9cPfbCFm7ZTrddey887H5fxkBQFI+JD5Kdb/wAxubNPU5Xoort1RUJ8773yIqBKdtynxGAlwpLw7wHcCkIrAFsTPnORK1WGHD44txfZSFJLX+o1ByKDKLf3HmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712057; c=relaxed/simple;
	bh=H0O5AZQsr7nxqSTjataz1x2Uq5qdVJnHuFKfvX+8w3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=pL/yrDVUgbb4k9NC7THPsgZOdCcr8CMWO8sk0Z+3N8NIfOKwBQm9Vw+2MraMcbk5E5xYXeMu7xO80b+FvAQkXf0dbs08ghcv6ESe5bcz4xg+2GuJLsZ8K2jjOtajnRQCskr3h6gEX+zN+E4/NRcQ/S1V1HR50UxVGQsaRukn8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.89.151.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [10.181.207.67] ) by
 ajax-webmail-mail-app3 (Coremail) ; Sat, 20 Jan 2024 08:53:50 +0800
 (GMT+08:00)
Date: Sat, 20 Jan 2024 08:53:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, razor@blackwall.org,
	leon@kernel.org, haleyb.dev@gmail.com, ja@ssi.bg,
	judyhsiao@chromium.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20240119195058.GA105385@kernel.org>
References: <20240119070847.5402-1-linma@zju.edu.cn>
 <20240119195058.GA105385@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3ddbc728.7c83.18d245c1152.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgC3nzueGatlRxZUAA--.9394W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQFEmWpc04QogAKsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gU2ltb24sCgo+IE9uIEZyaSwgSmFuIDE5LCAyMDI0IGF0IDAzOjA4OjQ3UE0gKzA4MDAs
IExpbiBNYSB3cm90ZToKPiA+IEluIHRoZSBuZWlnaHRibF9zZXQgZnVuY3Rpb24sIHRoZSBhdHRy
aWJ1dGVzIGFycmF5IGlzIHBhcnNlZCBhbmQgdmFsaWRhdGVkCj4gPiB1c2luZyB0aGUgbmxfbnRi
bF9wYXJtX3BvbGljeSBwb2xpY3kuIEhvd2V2ZXIsIHRoaXMgcG9saWN5IG92ZXJsb29rcyB0aGUK
PiA+IE5EVFBBX1FVRVVFX0xFTkJZVEVTIGF0dHJpYnV0ZSBzaW5jZSB0aGUgY29tbWl0IDZiM2Y4
Njc0YmNjYiAoIltORUlHSF06Cj4gPiBDb252ZXJ0IG5laWdoYm91ciB0YWJsZSBtb2RpZmljYXRp
b24gdG8gbmV3IG5ldGxpbmsgYXBpIikuCj4gPiBBcyBhIHJlc3VsdCwgbm8gdmFsaWRhdGlvbiBp
cyBwZXJmb3JtZWQgd2hlbiBhY2Nlc3NpbmcgdGhlCj4gPiBORFRQQV9RVUVVRV9MRU5CWVRFUyBh
dHRyaWJ1dGUuCj4gPiAKPiA+IFRoaXMgcGF0Y2ggYWRkcmVzc2VzIHRoaXMgaXNzdWUgYnkgY29t
cGxlbWVudGluZyB0aGUgcG9saWN5IHRvIGVuc3VyZSB0aGF0Cj4gPiBldmVyeSBhdHRyaWJ1dGUg
YmVpbmcgYWNjZXNzZWQgaXMgcHJvcGVybHkgdmFsaWRhdGVkLgo+ID4gCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaW4gTWEgPGxpbm1hQHpqdS5lZHUuY24+Cj4gPiAtLS0KPiA+ICBuZXQvY29yZS9uZWln
aGJvdXIuYyB8IDEgKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvbmVpZ2hib3VyLmMgYi9uZXQvY29yZS9uZWlnaGJvdXIu
Ywo+ID4gaW5kZXggNTUyNzE5YzNiYmMzLi5lY2UwNDQ3Y2Y0MDkgMTAwNjQ0Cj4gPiAtLS0gYS9u
ZXQvY29yZS9uZWlnaGJvdXIuYwo+ID4gKysrIGIvbmV0L2NvcmUvbmVpZ2hib3VyLmMKPiA+IEBA
IC0yMjkzLDYgKzIyOTMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5sYV9wb2xpY3kgbmxfbmVp
Z2h0YmxfcG9saWN5W05EVEFfTUFYKzFdID0gewo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgbmxh
X3BvbGljeSBubF9udGJsX3Bhcm1fcG9saWN5W05EVFBBX01BWCsxXSA9IHsKPiA+ICAJW05EVFBB
X0lGSU5ERVhdCQkJPSB7IC50eXBlID0gTkxBX1UzMiB9LAo+ID4gIAlbTkRUUEFfUVVFVUVfTEVO
XQkJPSB7IC50eXBlID0gTkxBX1UzMiB9LAo+ID4gKwlbTlBUUEFfUVVFVUVfTEVOX0JZVEVTXSAg
ICAgICAgID0geyAudHlwZSA9IE5MQV9VMzIgfSwKPiAKPiBUaGlzIGRvZXMgbm90IGNvbXBpbGUg
YmVjYXVzZSBOUFRQQV9RVUVVRV9MRU5fQllURVMgaXMKPiBub3QgcHJlc2VudCBpbiBuZXQtbmV4
dC4KPiAKPiA+ICAJW05EVFBBX1BST1hZX1FMRU5dCQk9IHsgLnR5cGUgPSBOTEFfVTMyIH0sCj4g
PiAgCVtORFRQQV9BUFBfUFJPQkVTXQkJPSB7IC50eXBlID0gTkxBX1UzMiB9LAo+ID4gIAlbTkRU
UEFfVUNBU1RfUFJPQkVTXQkJPSB7IC50eXBlID0gTkxBX1UzMiB9LAo+IAo+IAo+ICMjIEZvcm0g
bGV0dGVyIC0gbmV0LW5leHQtY2xvc2VkCj4gCj4gW2FkYXB0ZWQgZnJvbSB0ZXh0IGJ5IEpha3Vi
XQo+IAo+IFRoZSBtZXJnZSB3aW5kb3cgZm9yIHY2LjggaGFzIGJlZ3VuIGFuZCB0aGVyZWZvcmUg
bmV0LW5leHQgaXMgY2xvc2VkCj4gZm9yIG5ldyBkcml2ZXJzLCBmZWF0dXJlcywgY29kZSByZWZh
Y3RvcmluZyBhbmQgb3B0aW1pemF0aW9ucy4KPiBXZSBhcmUgY3VycmVudGx5IGFjY2VwdGluZyBi
dWcgZml4ZXMgb25seS4KPiAKPiBQbGVhc2UgcmVwb3N0IHdoZW4gbmV0LW5leHQgcmVvcGVucyBv
biBvciBhZnRlciAyMm5kIEphbnVhcnkuCj4gCj4gUkZDIHBhdGNoZXMgc2VudCBmb3IgcmV2aWV3
IG9ubHkgYXJlIG9idmlvdXNseSB3ZWxjb21lIGF0IGFueSB0aW1lLgo+IAo+IFNlZTogaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9uZXh0L3Byb2Nlc3MvbWFpbnRhaW5lci1uZXRkZXYu
aHRtbCNkZXZlbG9wbWVudC1jeWNsZQo+IC0tCj4gcHctYm90OiBkZWZlcgoKTXkgYmFkLCBJIHBy
ZXBhcmUgdGhpcyBwYXRjaCBvbiB0aGUgbGludXgtc3RhYmxlIHRyZWUgYW5kIG5ldmVyIHRob3Vn
aHQgdGhpcyB3b3VsZCBoYXBwZW4uCldpbGwgYWxzbyBjb21waWxlIG9uIHRoZSByaWdodCB0cmVl
IG5leHQgdGltZS4KClNvIHNob3VsZCBJIHNlbmQgdGhpcyB0byBuZXQgd2hpY2ggaGFzIHRoaXMg
YXR0cmlidXRlIG9yIHNvbWV0aGluZz8KClRoYW5rcyBhcmUgcmVhbGx5IFNvcnJ5CkxpbgoK

