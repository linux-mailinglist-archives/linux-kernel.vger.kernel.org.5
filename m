Return-Path: <linux-kernel+bounces-39700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC683D51B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BEDB2747D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183BB47F50;
	Fri, 26 Jan 2024 07:28:00 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D492111A2;
	Fri, 26 Jan 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254079; cv=none; b=DxpBjua+mgiTaGdSLubcczDOGD+CJVhDfjxR6bqvNc1D4omJzd1R5ESlvS6Yse8XCR3AvXSrqoFdkCjUqRD0degjSPP0cOHBB2fNqjwtweJOo6MS1gMuZczNmA/paz93KDNQwwI4CoSdvvU/I0cQMom0EddSnNnIWJCO4Gr823k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254079; c=relaxed/simple;
	bh=5QnklExlc4DdUFMJs23OBWqLW5U2p8WOgQXGSW6e8qQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SRPoV/ZJN+K62sSXR7inKULSJz0tB6Se3rmHzd8oSAcycHzZs8Dlkrs07kZ/cCAMyY8Qe9dWFChkmatUaTumrWT0xyQIJKjkwTIzlFoWaAPzShOIFGVTaXddD0bKw7cj6olFgyCqXuL3rIIPhkfrdj9fjrhy82LfvGS/MhV+69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [124.90.105.91] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 26 Jan 2024 15:27:35 +0800
 (GMT+08:00)
Date: Fri, 26 Jan 2024 15:27:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Simon Horman" <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Taku Izumi" <izumi.taku@jp.fujitsu.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] fjes: fix memleaks in fjes_hw_setup
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20240122210538.GJ126470@kernel.org>
References: <20240122172445.3841883-1-alexious@zju.edu.cn>
 <20240122210538.GJ126470@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <9c63817.dd25.18d44aab80c.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3k4LoXrNlOyemAA--.13255W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAg0MAGWyq+MR-wAAsy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCAwMToyNDo0MkFNICswODAwLCBaaGlwZW5nIEx1IHdy
b3RlOgo+ID4gSW4gZmplc19od19zZXR1cCwgaXQgYWxsb2NhdGVzIHNldmVyYWwgbWVtb3J5IGFu
ZCBkZWxheSB0aGUgZGVhbGxvY2F0aW9uCj4gPiB0byB0aGUgZmplc19od19leGl0IGluIGZqZXNf
cHJvYmUgdGhyb3VnaCB0aGUgZm9sbG93aW5nIGNhbGwgY2hhaW46Cj4gPiAKPiA+IGZqZXNfcHJv
YmUKPiA+ICAgfC0+IGZqZXNfaHdfaW5pdAo+ID4gICAgICAgICB8LT4gZmplc19od19zZXR1cAo+
ID4gICB8LT4gZmplc19od19leGl0Cj4gPiAKPiA+IEhvd2V2ZXIsIHdoZW4gZmplc19od19zZXR1
cCBmYWlscywgZmplc19od19leGl0IHdvbid0IGJlIGNhbGxlZCBhbmQgdGh1cwo+ID4gYWxsIHRo
ZSByZXNvdXJjZXMgYWxsb2NhdGVkIGluIGZqZXNfaHdfc2V0dXAgd2lsbCBiZSBsZWFrZWQuIElu
IHRoaXMKPiA+IHBhdGNoLCB3ZSBmcmVlIHRob3NlIHJlc291cmNlcyBpbiBmamVzX2h3X3NldHVw
IGFuZCBwcmV2ZW50cyBzdWNoIGxlYWtzLgo+ID4gCj4gPiBGaXhlczogMmZjYmNhNjg3NzAyICgi
ZmplczogcGxhdGZvcm1fZHJpdmVyJ3MgLnByb2JlIGFuZCAucmVtb3ZlIHJvdXRpbmUiKQo+ID4g
U2lnbmVkLW9mZi1ieTogWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVkdS5jbj4KPiAKPiBIaSBa
aGlwZW5nIEx1LAo+IAo+IEl0IGxvb2tzIGxpa2UgdGhlIGxhc3Qgbm9uLXRyaXZpYWwgY2hhbmdl
IHRvIHRoaXMgZHJpdmVyIHdhcyBpbiAyMDE2Lgo+IFNvIHBlcmhhcHMgaXQgaXMgYmV0dGVyIHRv
IGxlYXZlIGl0IGJlLgo+IAo+IEJ1dCBpZiBub3QsIHRoaXMgcGF0Y2ggZG9lcyBsb29rIGNvcnJl
Y3QgdG8gbWUuCj4gCj4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9y
Zz4KCkkgdGhpbmsgdGhpcyBwYXRjaCBkb2Vzbid0IGNoYW5nZSBhIGxvdCBzaW5jZSBpdCBqdXN0
IHJlZmFjdG9yIHRoZSBkZWFsbG9jYXRpb24Kd2F5cyBpbnRvIHVud2luZCBsYWRkZXJzIHdoaWxl
IGZpeCBhIG1lbWxlYWsuCgo+IAo+IC4uLgo+IAo+ID4gQEAgLTI3Myw2ICsyNzcsMjUgQEAgc3Rh
dGljIGludCBmamVzX2h3X3NldHVwKHN0cnVjdCBmamVzX2h3ICpodykKPiA+ICAJZmplc19od19p
bml0X2NvbW1hbmRfcmVnaXN0ZXJzKGh3LCAmcGFyYW0pOwo+ID4gIAo+ID4gIAlyZXR1cm4gMDsK
PiA+ICsKPiA+ICtmcmVlX2VwYnVmOgo+ID4gKwlmb3IgKGVwaWR4ID0gMDsgZXBpZHggPCBody0+
bWF4X2VwaWQgOyBlcGlkeCsrKSB7Cj4gPiArCQlpZiAoZXBpZHggPT0gaHctPm15X2VwaWQpCj4g
PiArCQkJY29udGludWU7Cj4gPiArCQlmamVzX2h3X2ZyZWVfZXBidWYoJmh3LT5lcF9zaG1faW5m
b1tlcGlkeF0udHgpOwo+ID4gKwkJZmplc19od19mcmVlX2VwYnVmKCZody0+ZXBfc2htX2luZm9b
ZXBpZHhdLnJ4KTsKPiA+ICsJfQo+ID4gKwlmamVzX2h3X2ZyZWVfc2hhcmVkX3N0YXR1c19yZWdp
b24oaHcpOwo+ID4gK2ZyZWVfcmVzX2J1ZjoKPiA+ICsJa2ZyZWUoaHctPmh3X2luZm8ucmVzX2J1
Zik7Cj4gPiArCWh3LT5od19pbmZvLnJlc19idWYgPSBOVUxMOwo+ID4gK2ZyZWVfcmVxX2J1ZjoK
PiA+ICsJa2ZyZWUoaHctPmh3X2luZm8ucmVxX2J1Zik7Cj4gPiArCWh3LT5od19pbmZvLnJlcV9i
dWYgPSBOVUxMOwo+ID4gK2ZyZWVfZXBfaW5mbzoKPiA+ICsJa2ZyZWUoaHctPmVwX3NobV9pbmZv
KTsKPiA+ICsJaHctPmVwX3NobV9pbmZvID0gTlVMTDsKPiA+ICsJcmV0dXJuIHJlc3VsdDsKPiAK
PiBGV0lJVywgSSdtIG5vdCBzdXJlIGl0IGlzIG5lY2Vzc2FyeSB0byBzZXQgdGhlc2UgcG9pbnRl
cnMgTlVMTCwKPiBhbHRob3VnaCBpdCBkb2Vzbid0IGRvIGFueSBoYXJtLgoKSSBzZXQgdGhlc2Ug
cG9pbnRlcnMgdG8gTlVMTCBzaW5jZSBpdHMgY2xlYW4gdXAgZnVuY3Rpb24gZmplc19od19jbGVh
bnVwCmRvIHNvLiBQZXJzb25hbGx5LCBJIHRlbmQgdG8gZm9sbG93aW5nIHRoZSBleGlzdGluZyBj
b2RlIHN0eWxlIGluIHRoZSAKc2FtZSBtb2R1bGUuCgo+IAo+IEFsc28sIGlmIHRoaXMgZnVuY3Rp
b24gcmV0dXJucyBhbiBlcnJvciwKPiBkb2VzIHRoZSBjYWxsZXIgKGZqZXNfaHdfaW5pdCgpKSBs
ZWFrIGh3LT5od19pbmZvLnRyYWNlPwoKV2VsbCwgeWVzLCBpdCdzIGEgbGl0dGxlIGJpdCB3aXJl
ZCB0aGF0IGZqZXNfaHdfaW5pdCBkb2Vzbid0IGhhbmRsZSAKZXJyb3JzIG9mIGZqZXNfaHdfc2V0
dXAgYW5kIHZ6YWxsb2Mgb2YgaHctPmh3X2luZm8udHJhY2UgYXMgbm9ybWFsCmZ1bmN0aW9ucyBk
by4KTWF5YmUgYW5vdGhlciBwYXRjaCBuZWVkIHRvIGJlIHN1Ym1pdHRlZCB0byBkZWFsIHdpdGgg
dGhpcyBwcm9ibGVtLgoKPiAKPiA+ICB9Cj4gPiAgCj4gPiAgc3RhdGljIHZvaWQgZmplc19od19j
bGVhbnVwKHN0cnVjdCBmamVzX2h3ICpodykKPiA+IC0tIAo+ID4gMi4zNC4xCj4gPiAK

