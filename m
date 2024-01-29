Return-Path: <linux-kernel+bounces-42740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105E8405D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1711281059
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD0627F0;
	Mon, 29 Jan 2024 12:57:08 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283D627EB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533028; cv=none; b=dbGdA+UHZ+uqFLDaMdC+3GqmiEd1t4hbiZnaR7nAi46W7OLcAzAXOZSb7GWt2ghX4Ej1YDZfdMf7wBZnOedInSxNetjzXCfms8/Jm9U3rVOMiDDjKLwocbqNCvmdVvkDrv5llZ4jUOMI9cBqPqsUqfZNKEZI4bIpVtF2WlIyHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533028; c=relaxed/simple;
	bh=vR0ArKJ2th+NhUTmkgYK4TmELLECOMJ7bjwvwhPRXXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=g333GlA5FP3sfHF2FfNI2Xum+Q94eFrux46Ri5W+HzUp+h6no2A1sA0HCZG13ATzLSTFvB8mFjiVBeLuynlorMVUilPeH1lP0Zugaq24qorxXU11dQpaV11smgcnJfKQGYaWODD9wz9I0WKMKDPCxd2bJ98VWDIQuuShYWFfIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.77.58] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 29 Jan 2024 20:56:52 +0800
 (GMT+08:00)
Date: Mon, 29 Jan 2024 20:56:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Parthiban Veerasooran" <parthiban.veerasooran@microchip.com>,
	"Christian Gromm" <christian.gromm@microchip.com>,
	"Dan Carpenter" <error27@gmail.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] most: fix a memleak in audio_probe_channel
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <4e065b3a-240e-4cd9-acd8-53e5a56abed0@moroto.mountain>
References: <20240122172044.3840976-1-alexious@zju.edu.cn>
 <4e065b3a-240e-4cd9-acd8-53e5a56abed0@moroto.mountain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1eef96d5.2150.18d554b44ca.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgAXooCUoLdlyr3DAA--.13596W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgAPAGW2oGMXhwACsP
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCAwMToyMDo0NEFNICswODAwLCBaaGlwZW5nIEx1IHdy
b3RlOgo+ID4gV2hlbiBnZXRfY2hhbm5lbCBmYWlscywgYXVkaW9fcHJvYmVfY2hhbm5lbCBzaG91
bGQgZnJlZSBhZHB0IGxpa2UgYWxsCj4gPiBpdHMgZm9sbG93aW5nIGVycm9yLWhhbmRsaW5nIHBh
dGhzIGFmdGVyIGdldF9jaGFubmVsLiBPdGhlcndpc2UgdGhlcmUKPiA+IGNvdWxkIGJlIGEgbWVt
bGVhay4KPiA+IAo+ID4gRml4ZXM6IDE1NjAwYWVhMjc1NCAoInN0YWdpbmc6IG1vc3Q6IHNvdW5k
OiBjcmVhdGUgb25lIHNvdW5kIGNhcmQgdy8gbXVsdGlwbGUgUENNIGRldmljZXMgcGVyIE1PU1Qg
ZGV2aWNlIikKPiA+IFNpZ25lZC1vZmYtYnk6IFpoaXBlbmcgTHUgPGFsZXhpb3VzQHpqdS5lZHUu
Y24+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL21vc3QvbW9zdF9zbmQuYyB8IDMgKystCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tb3N0L21vc3Rfc25kLmMgYi9kcml2ZXJzL21vc3QvbW9zdF9zbmQu
Ywo+ID4gaW5kZXggNDVkNzYyODA0YzVlLi42Y2NjYzljMjY3OTYgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL21vc3QvbW9zdF9zbmQuYwo+ID4gKysrIGIvZHJpdmVycy9tb3N0L21vc3Rfc25kLmMK
PiA+IEBAIC01NjQsNyArNTY0LDggQEAgc3RhdGljIGludCBhdWRpb19wcm9iZV9jaGFubmVsKHN0
cnVjdCBtb3N0X2ludGVyZmFjZSAqaWZhY2UsIGludCBjaGFubmVsX2lkLAo+ID4gIAlpZiAoZ2V0
X2NoYW5uZWwoaWZhY2UsIGNoYW5uZWxfaWQpKSB7Cj4gPiAgCQlwcl9lcnIoImNoYW5uZWwgKCVz
OiVkKSBpcyBhbHJlYWR5IGxpbmtlZFxuIiwKPiA+ICAJCSAgICAgICBpZmFjZS0+ZGVzY3JpcHRp
b24sIGNoYW5uZWxfaWQpOwo+ID4gLQkJcmV0dXJuIC1FRVhJU1Q7Cj4gPiArCQlyZXQgPSAtRUVY
SVNUOwo+ID4gKwkJZ290byBlcnJfZnJlZV9hZHB0Owo+IAo+IE5vLCB0aGlzIGRvZXNuJ3Qgd29y
ay4gIFNvbWVvbmUgc2hvdWxkIGFkZCBhIGNvbW1lbnQgaGVyZSBleHBsYWluaW5nCj4gd2h5Lgo+
IAo+IFRoaXMgZnVuY3Rpb24gaXMgYSBiaXQgY29tcGxpY2F0ZWQgYmVjYXVzZSB3ZSBzb21ldGlt
ZXMgYWxsb2NhdGUgImFkcHQiCj4gYW5kIHNvbWV0aW1lcyB3ZSBkb24ndC4gIFdoeSBjYW4gd2Ug
bm90IG1ha2UgaXQgY29uc2lzdGVudGx5IG9uZSB3YXkgb3IKPiB0aGUgb3RoZXI/ICBUaGlzIGlz
IG5vdCBteSBjb2RlIGFuZCBJIGRvbid0IGtub3cuICBCdXQgcHJlc3VtYWJseSB0aGVyZQo+IGlz
IGEgZ29vZCByZWFzb24uICBJIGxvb2tlZCB1cCB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBvZiB0
aGlzIGFuZCBmb3VuZAo+IHRoaXMgdGhyZWFkLgo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC83OGNjNTliMzEwNDJmODY1ZTk0N2EyYzA5YTVkMTBjYzYwZGRjMDFjLmNhbWVsQG1pY3Jv
Y2hpcC5jb20vCj4gCj4gQW55d2F5LCBpbiB0aGUgZW5kLCB3ZSdyZSB0cnlpbmcgdG8gY2xlYW4g
dXAgYW5kIG9uIHRoZSBvdGhlciBlcnJvcgo+IHBhdGhzIHdlJ3JlIGFsbG93ZWQgdG8gZnJlZSAi
YWRwdCIgZXZlbiB0aG91Z2ggd2UgZGlkbid0IGFsbG9jYXRlIGl0Lgo+IAo+IEhvd2V2ZXIgb25j
ZSBpdCdzIGdvdCBhIGNoYW5uZWwgbGlua2VkIHRoZW4gd2UgY2Fubm90LiAgQXQgdGhhdCBzdGFn
ZQo+ICJhZHB0IiBpcyBhbHJlYWR5IGFkZGVkIHRvIHRoZSAmaWZhY2UtPnAtPmNoYW5uZWxfbGlz
dCBsaXN0LiAgVGhlCj4gcmVsZWFzZV9hZGFwdGVyKCkgYWRhcHRlciBmdW5jdGlvbiB3aWxsIGZy
ZWUgaXQgd2l0aG91dCByZW1vdmluZyBpdCBmcm9tCj4gdGhlIGxpc3Qgc28gaXQgbGVhZHMgdG8g
YSB1c2UgYWZ0ZXIgZnJlZS4KPiAKPiBIb3dldmVyLCBtZW1vcnkgb24gdGhpcyBwYXRoIGlzIG5v
dCBsZWFrZWQgYXMgeW91ciBjb21taXQgbWVzc2FnZSBzYXlzLgo+ICJhZHB0IiBpcyBzdGlsbCBv
biB0aGUgbGlzdHMuICBUaGUgc3R1ZmYgaXMgaW4gYSBtZXNzZWQgdXAgc3RhdGUgc28gdGhlCj4g
dXNlciB3aWxsIG5lZWQgdG8gdGVhciBpdCBhbGwgZG93biBtYW51YWxseSBhbmQgcmVjcmVhdGUg
dGhlCj4gY29uZmlndXJhdGlvbi4gIFF1b3RpbmcgdGhlIGVtYWlsIEkgbGlua2VkIHRvLCAiVGhp
cwo+IGludm9sdmVzIHRoZSBjYWxsIHRvIG1kZXZfbGlua19kZXN0cm95X2xpbmtfc3RvcmUoKSB0
aGF0IGNsZWFucyB1cAo+IGV2ZXJ5dGhpbmcuIgo+IAo+IFNvIHdlIGNhbid0IGFwcGx5IHlvdXIg
cGF0Y2ggYmVjYXVzZSBpdCBsZWFkcyB0byBhIHVzZSBhZnRlciBmcmVlLiAgQnV0Cj4gd2UgY291
bGQgYXBwbHkgYSBwYXRjaCB3aGljaCBhZGRzIGEgY29tbWVudCBsaWtlOgo+IAo+IAkvKgo+IAkg
KiBUaGlzIGVycm9yIHBhdGggZG9lc24ndCBsZWFrLiAgSWYgdGhlIGNoYW5uZWwgaXMgYWxyZWFk
eSBzZXQKPiAJICogdXAgdGhlbiBzb21ldGhpbmcgaGFzIGdvbmUgYmFkbHkgd3JvbmcuICBUaGUg
dXNlciB3aWxsIGhhdmUKPiAJICogdG8gdGVhciBldmVyeXRoaW5nIGRvd24gYW5kIHJlY29uZmln
dXJlIGZyb20gc2NyYXRjaC4gIFRoZQo+IAkgKiBtZW1vcnkgd2lsbCBiZSByZWxlYXNlZCB2aWEg
bWRldl9saW5rX2Rlc3Ryb3lfbGlua19zdG9yZSgpLgo+IAkgKgo+IAkgKi8KPiAKClRoYW5rIHlv
dSBmb3IgeW91ciBjb3JyZWN0aW9uIGFuZCBhZHZpc2UuIApXZSB3b3VsZCBsaWtlIHRvIHN1Ym1p
dCBhIG5ldyBwYXRjaCB0byBhZGQgc3VjaCBjb21tZW50LlwKClJlZ2FyZHMsClpoaXBlbmcuCgoK
PiByZWdhcmRzLAo+IGRhbiBjYXJwZW50ZXIK

