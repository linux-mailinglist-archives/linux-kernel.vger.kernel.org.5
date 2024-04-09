Return-Path: <linux-kernel+bounces-137100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151E89DC68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBC9B20C18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A4347B6;
	Tue,  9 Apr 2024 14:36:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5A2836A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673380; cv=none; b=t5hDEBfITC9x06NLoPLSMQFigu94egjXyPynZdUPpTvmACtBOi4Aay+HuDack+SfZJYGfMtK2HnCdLdPIVlDL7/dkruw2D6ci4lL+IKeLKx+mVZTuSh8Hg6u6wlJlJWuaBDCaJrg9DtoqOtp1XknQTQ1oQikfd/SDgwtsRjTuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673380; c=relaxed/simple;
	bh=qTJ7Npe3rxJEDPC2nptV7Bl4EgMVk2rZmo8ah4g96es=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XghysGVE9LYWppgsBIgWF8aPRtXk6DGxdLKXZSW9hZCj5kDnBCVo2bgdP0BTXdSXV1HWjSgvxGnio6iYSOLs7xKlondQCQtAfQ/D9iIIGcSf2C72Rw6ABmNxhVV8H6TpnvgkiUDyJ60FwOsqo3xXapnsm5RWM5+SWfAHq54mjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1ruCZv-0000tX-2w; Tue, 09 Apr 2024 16:36:03 +0200
Message-ID: <fcd6acc268b8642371cf289149b2b1c3e90c7f45.camel@pengutronix.de>
Subject: Re: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power
 domain parent
From: Lucas Stach <l.stach@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 09 Apr 2024 16:36:01 +0200
In-Reply-To: <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
References: <20240409085802.290439-1-ivitro@gmail.com>
	 <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
	 <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

QW0gRGllbnN0YWcsIGRlbSAwOS4wNC4yMDI0IHVtIDE0OjIyICswMTAwIHNjaHJpZWIgVml0b3Ig
U29hcmVzOgo+IEhpIEx1Y2FzLAo+IAo+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4KPiAKPiBP
biBUdWUsIDIwMjQtMDQtMDkgYXQgMTE6MTMgKzAyMDAsIEx1Y2FzIFN0YWNoIHdyb3RlOgo+ID4g
SGkgVml0b3IsCj4gPiAKPiA+IEFtIERpZW5zdGFnLCBkZW0gMDkuMDQuMjAyNCB1bSAwOTo1OCAr
MDEwMCBzY2hyaWViIFZpdG9yIFNvYXJlczoKPiA+ID4gRnJvbTogVml0b3IgU29hcmVzIDx2aXRv
ci5zb2FyZXNAdG9yYWRleC5jb20+Cj4gPiA+IAo+ID4gPiBUaGUgcGdjX3ZwdV8qIG5vZGVzIG1p
c3MgdGhlIHJlZmVyZW5jZSB0byB0aGUgcG93ZXIgZG9tYWluIHBhcmVudCwKPiA+ID4gbGVhZGlu
ZyB0aGUgc3lzdGVtIHRvIGhhbmcgZHVyaW5nIHRoZSByZXN1bWUuCj4gPiA+IAo+ID4gVGhpcyBj
aGFuZ2UgaXMgbm90IGNvcnJlY3QuIFRoZSB2cHVtaXggZG9tYWluIGlzIGNvbnRyb2xsZWQgdGhy
b3VnaAo+ID4gdGhlCj4gPiBpbXg4bW0tdnB1LWJsay1jdHJsIGFuZCBtdXN0IG5vdCBiZSBkaXJl
Y3RseSB0cmlnZ2VyZWQgYnkgdGhlIGNoaWxkCj4gPiBkb21haW5zIGluIG9yZGVyIHRvIGd1YXJh
bnRlZSBwcm9wZXIgcG93ZXIgc2VxdWVuY2luZy4KPiA+IAo+ID4gSWYgdGhlIHNlcXVlbmNpbmcg
aXMgaW5jb3JyZWN0IGZvciByZXN1bWUsIGl0IG5lZWRzIHRvIGJlIGZpeGVkIGluCj4gPiB0aGUK
PiA+IGJsay1jdHJsIGRyaXZlci4gSSdsbCBoYXBwaWx5IGFzc2lzdCBpZiB5b3UgaGF2ZSBhbnkg
cXVlc3Rpb25zIGFib3V0Cj4gPiB0aGlzIGludHJpY2F0ZSBtaXggYmV0d2VlbiBHUEMgYW5kIGJs
ay1jdHJsIGhhcmR3YXJlL2RyaXZlcnMuCj4gIAo+IEknbSBuZXcgaW50byB0aGUgdG9waWMsIHNv
IEkgdHJpZWQgdG8gZm9sbG93IHNhbWUgYXBwcm9hY2ggYXMgaW4gaW14OG1wCj4gRFQuCj4gClRo
YXQncyBhIGdvb2QgaGludCwgdGhlIDhNUCBWUFUgR1BDIG5vZGUgYWRkaXRpb25zIG1pc3NlZCBt
eSByYWRhci4gVGhlCmRpcmVjdCBkZXBlbmRlbmN5IHRoZXJlIGJldHdlZW4gdGhlIEdQQyBkb21h
aW5zIGlzIGVxdWFsbHkgd3JvbmcuCgo+IEkgYWxzbyBjaGVja2VkIHRoZSBpbXg4bXEgRFQgYW5k
IGl0IG9ubHkgaGF2ZSBvbmUgZG9tYWluIGZvciB0aGUKPiBWUFUgaW4gdGhlIEdQQy4gSXQgc2Vl
bSBibGstY3RybCBhbHNvIGRlcGVuZGVzIG9uIHBnY192cHVfKiB0byB3b3JrCj4gcHJvcGVybHku
Cj4gCj4gVGhlIGJsay1jdHJsIGRyaXZlciBoYW5ncyBvbiBpbXg4bV9ibGtfY3RybF9wb3dlcl9v
bigpIHdoZW4gYWNjZXNzIHRoZQo+IGlwIHJlZ2lzdGVycyBmb3IgdGhlIHNvZnQgcmVzZXQuIEkg
dHJpZWQgdG8gcG93ZXItdXAgdGhlIGJlZm9yZSB0aGUKPiBzb2Z0IHJlc2V0LCBidXQgaXQgZGlk
bid0IHdvcmsuCj4gClRoZSBydW50aW1lX3BtX2dldF9zeW5jKCkgYXQgdGhlIHN0YXJ0IG9mIHRo
YXQgZnVuY3Rpb24gc2hvdWxkIGVuc3VyZQp0aGF0IGJ1cyBHUEMgZG9tYWluIGFrYSB2cHVtaXgg
aXMgcG93ZXJlZCB1cC4gQ2FuIHlvdSBjaGVjayBpZiB0aGF0IGlzCmhhcHBlbmluZz8KClJlZ2Fy
ZHMsCkx1Y2FzCgo+IERvIHlvdSBoYXZlIGFuIGlkZWEgaG93IHdlIGNhbiBhZGRyZXNzIHRoaXMg
d2l0aGluIGJsay1jdHJsPwo+IAo+IEJlc3QgcmVnYXJkcywKPiBWaXRvcgo+IAo+ID4gCj4gPiBS
ZWdhcmRzLAo+ID4gTHVjYXMKPiA+IAo+ID4gPiBBcyB0aGVzZSBQVSBkb21haW5zIGFyZSBuZXN0
ZWQgaW5zaWRlIHRoZSB2cHVtaXggZG9tYWluLCBsZXQncwo+ID4gPiByZWZlcmVuY2UKPiA+ID4g
aXQgYWNjb3JkaW5nbHkuIEFmdGVyIHRoaXMgY2hhbmdlLCB0aGUgc3VzcGVuZC9yZXN1bWUgaXMg
d29ya2luZy4KPiA+ID4gCj4gPiA+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25p
eC5kZT4KPiA+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+ID4gPiBDbG9zZXM6Cj4g
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9mY2NiYjA0MDMzMGE3MDZhNGY3YjM0ODc1
ZGIxZDg5NmEwYmY4MWM4LmNhbWVsQGdtYWlsLmNvbS8KPiA+ID4gRml4ZXM6IGQzOWQ0YmIxNTMx
MCAoImFybTY0OiBkdHM6IGlteDhtbTogYWRkIEdQQyBub2RlIikKPiA+ID4gU2lnbmVkLW9mZi1i
eTogVml0b3IgU29hcmVzIDx2aXRvci5zb2FyZXNAdG9yYWRleC5jb20+Cj4gPiA+IC0tLQo+ID4g
PiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgMyArKysKPiA+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPiA+IAo+ID4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kKPiA+ID4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQo+ID4gPiBpbmRleCA4YTFi
NDJiOTRkY2UuLjk3ZDBjNmQyM2FkOCAxMDA2NDQKPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kKPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kKPiA+ID4gQEAgLTczOSwxNiArNzM5LDE5IEBAIHBnY192
cHVtaXg6IHBvd2VyLWRvbWFpbkA2IHsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZ2Nf
dnB1X2cxOiBwb3dlci1kb21haW5ANwo+ID4gPiB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCNwb3dlci1kb21haW4tY2VsbHMKPiA+ID4gPSA8MD47Cj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9Cj4gPiA+IDxJTVg4
TU1fUE9XRVJfRE9NQUlOX1ZQVUcxPjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwb3dlci1kb21haW5zID0KPiA+ID4gPCZwZ2NfdnB1bWl4PjsKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gPiDCoAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHBnY192cHVfZzI6IHBvd2VyLWRvbWFpbkA4Cj4gPiA+IHsKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI3Bvd2VyLWRvbWFpbi1jZWxscwo+ID4gPiA9IDww
PjsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0KPiA+
ID4gPElNWDhNTV9QT1dFUl9ET01BSU5fVlBVRzI+Owo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBvd2VyLWRvbWFpbnMgPQo+ID4gPiA8JnBnY192cHVtaXg+Owo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiA+IMKgCj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcGdjX3ZwdV9oMTogcG93ZXItZG9tYWluQDkKPiA+ID4gewo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjcG93ZXItZG9tYWluLWNlbGxzCj4g
PiA+ID0gPDA+Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZWcgPQo+ID4gPiA8SU1YOE1NX1BPV0VSX0RPTUFJTl9WUFVIMT47Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcG93ZXItZG9tYWlucyA9Cj4gPiA+IDwmcGdjX3Zw
dW1peD47Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ID4gwqAKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwZ2NfZGlzcG1peDoKPiA+ID4gcG93ZXItZG9tYWluQDEwIHsK
PiA+IAo+IAoK


