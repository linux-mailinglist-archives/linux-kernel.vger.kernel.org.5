Return-Path: <linux-kernel+bounces-167025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C718BA38E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485121C2209D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5CA1CAAE;
	Thu,  2 May 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0FXAMxQ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204748F5C;
	Thu,  2 May 2024 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690643; cv=none; b=Mkjye+gNDGJiPKi0inYIoVvs9u8G/VC+nuZnnpCav1L+1R3uIeLHMPX/tyTxnr1QvOnqNUq6EZj4rVxWSAN32vL7apzCZBH7zh8cltnYXx84ZUE+yz0a1DTPPpr+oVHrh5L/SstnCddQyfAIVNLIzFaGKkvcNy3CHAu6Kwb23ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690643; c=relaxed/simple;
	bh=Fmg57uEE4v11WR+5GNCzdhB87E5dXr1jA5UC3iRCnZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcsdrmN45v5ziw9w50nQfYVpRiJmYkN/PrMjQaQLman+XAQEJVUi4Q/My4sHCbFEvZmRnn69e6U3LtGeYSWVgt7lC2AN+bWzBtE/nGQDw/vKmsRoAZ5zwVmVpiywF1ikZyRWN23SQgu+oo4eI3wYlHgmlL/rCyygWUJkNpUCu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0FXAMxQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e242b1df60so1622951fa.1;
        Thu, 02 May 2024 15:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714690640; x=1715295440; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fmg57uEE4v11WR+5GNCzdhB87E5dXr1jA5UC3iRCnZI=;
        b=F0FXAMxQggnuJFMfoQz8sCHhLTxBMnJl5EokxSZ78TdxCXMJ8dSMo9Qovu64mA5X9R
         gxIk453dyBXKQPOkZWFcMwb8qqBiCPiHaRADcU6oEvOtxaPtGyK4i5DVGb6fcAyteS3z
         JG4Fx5fCN2PypoPvuRBH7JVmzwEQmKdvG1fELRXlNoYZ4zheFyFmna+eKCVqRtQtOQOz
         FJ1e86w5mVZUnQTvjb2+wfGI4O54W1rwx655Z5LCeAfmteEO/bysiI8jV1hIzFdczndj
         jbFs6C0wAbKiC7OXvK3z1KzRxO+Zg2pl+A5q7MZiVqkRSOw9ZnWeZ9ChEt7KU5hl82em
         cUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690640; x=1715295440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fmg57uEE4v11WR+5GNCzdhB87E5dXr1jA5UC3iRCnZI=;
        b=QBzXo7R9vKaGE8Id5polBkxgLulynWvrKVX1Eevuk7rltHea4Qvgc5j140nFVoMZa8
         iFHTDOYdtI8PcfM3QEehYgve2E7vU6z927krHuSV8sf+nZ0aaCRVeyPWi7YlkVQlnDMB
         L2v33jwilI3t6Zro2axAem7g51T8DiIZCq7hk0+4wZBHvJTATCk/esgIFAwcheQPxwAm
         gg9MbJaz7Z7OAXfeUQS7JGzv4AhQh5HiFX9ZQQAXJ7Z3T9uM35Kxgq2sb4QwvAzLtMKf
         EQtfgl1BupjZgO2AU+eFxMdxG1+P2N997nFBI8sPBFMwDlL7vGn0SMqaLJX61rvU9UX/
         9njA==
X-Forwarded-Encrypted: i=1; AJvYcCXMe4ntv/4shepNZlJ0IAedkJtGRbUSvLcTxi67ZnfrY7jT5fi8g55EHakrZUvczBFur8F0TF4TQsx5VruJRC5bXF9Jv1AD2T3fz1PxzAUyzFW5uZ2V290sbtid0UneKSyw4bE/CKWIkLuiEJzMrph4lY90wEPcv6B7193EzlZyG0x7kX0vqCsPsBvfnL44+Mxmca17IR5T
X-Gm-Message-State: AOJu0Yy0QHc/s0k2gMypn6YjVRKFViXhFpiwWMecRqXGjNNLkVVrOJ0O
	72NxEGOp9UU2R2V7sQL2YYKNcdkc/7gV8JwNmdtwEJavSBhYYXRJI5yeYehX
X-Google-Smtp-Source: AGHT+IGz2WXlMsuHP46rBYigVBAkKsVg1u7pbr6yf+o0r7Xce8qU4Ipgphj697TJ9RVIDJHMdo8Dxg==
X-Received: by 2002:a2e:9602:0:b0:2d9:fb60:9afa with SMTP id v2-20020a2e9602000000b002d9fb609afamr676609ljh.40.1714690640007;
        Thu, 02 May 2024 15:57:20 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:1ccc:88aa:cfeb:dfd7? ([2001:8a0:e622:f700:1ccc:88aa:cfeb:dfd7])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c450900b0041bd920d41csm3402462wmo.1.2024.05.02.15.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:57:19 -0700 (PDT)
Message-ID: <5d5073766f20f9fd5c88d09a710def6e84904838.camel@gmail.com>
Subject: Re: [PATCH v3] can: mcp251xfd: fix infinite loop when xmit fails
From: Vitor Soares <ivitro@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp
 <thomas.kopp@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>, Vitor Soares <vitor.soares@toradex.com>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 02 May 2024 23:57:17 +0100
In-Reply-To: <20240430-curassow-of-improbable-poetry-1611f8-mkl@pengutronix.de>
References: <20240311121143.306403-1-ivitro@gmail.com>
	 <20240430-curassow-of-improbable-poetry-1611f8-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gTWFyYywKCgpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suCgpPbiBUdWUsIDIwMjQtMDQt
MzAgYXQgMTE6MTAgKzAyMDAsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOgo+IE9uIDExLjAzLjIw
MjQgMTI6MTE6NDMsIFZpdG9yIFNvYXJlcyB3cm90ZToKPiA+IEZyb206IFZpdG9yIFNvYXJlcyA8
dml0b3Iuc29hcmVzQHRvcmFkZXguY29tPgo+ID4gCj4gPiBXaGVuIHRoZSBtY3AyNTF4ZmRfc3Rh
cnRfeG1pdCgpIGZ1bmN0aW9uIGZhaWxzLCB0aGUgZHJpdmVyIHN0b3BzCj4gPiBwcm9jZXNzaW5n
IG1lc3NhZ2VzLCBhbmQgdGhlIGludGVycnVwdCByb3V0aW5lIGRvZXMgbm90IHJldHVybiwKPiA+
IHJ1bm5pbmcgaW5kZWZpbml0ZWx5IGV2ZW4gYWZ0ZXIga2lsbGluZyB0aGUgcnVubmluZyBhcHBs
aWNhdGlvbi4KPiA+IAo+ID4gRXJyb3IgbWVzc2FnZXM6Cj4gPiBbwqAgNDQxLjI5ODgxOV0gbWNw
MjUxeGZkIHNwaTIuMCBjYW4wOiBFUlJPUiBpbiBtY3AyNTF4ZmRfc3RhcnRfeG1pdDogLTE2Cj4g
PiBbwqAgNDQxLjMwNjQ5OF0gbWNwMjUxeGZkIHNwaTIuMCBjYW4wOiBUcmFuc21pdCBFdmVudCBG
SUZPIGJ1ZmZlciBub3QgZW1wdHkuIChzZXE9MHgwMDAwMTdjNywKPiA+IHRlZl90YWlsPTB4MDAw
MDE3Y2YsIHRlZl9oZWFkPTB4MDAwMDE3ZDAsIHR4X2hlYWQ9MHgwMDAwMTdkMykuCj4gPiAuLi4g
YW5kIHJlcGVhdCBmb3JldmVyLgo+ID4gCj4gPiBUaGUgaXNzdWUgY2FuIGJlIHRyaWdnZXJlZCB3
aGVuIG11bHRpcGxlIGRldmljZXMgc2hhcmUgdGhlIHNhbWUKPiA+IFNQSSBpbnRlcmZhY2UuIEFu
ZCB0aGVyZSBpcyBjb25jdXJyZW50IGFjY2VzcyB0byB0aGUgYnVzLgo+ID4gCj4gPiBUaGUgcHJv
YmxlbSBvY2N1cnMgYmVjYXVzZSB0eF9yaW5nLT5oZWFkIGluY3JlbWVudHMgZXZlbiBpZgo+ID4g
bWNwMjUxeGZkX3N0YXJ0X3htaXQoKSBmYWlscy4gQ29uc2VxdWVudGx5LCB0aGUgZHJpdmVyIHNr
aXBzIG9uZQo+ID4gVFggcGFja2FnZSB3aGlsZSBzdGlsbCBleHBlY3RpbmcgYSByZXNwb25zZSBp
bgo+ID4gbWNwMjUxeGZkX2hhbmRsZV90ZWZpZl9vbmUoKS4KPiA+IAo+ID4gVGhpcyBwYXRjaCBy
ZXNvbHZlcyB0aGUgaXNzdWUgYnkgZGVjcmVhc2luZyB0eF9yaW5nLT5oZWFkIGlmCj4gPiBtY3Ay
NTF4ZmRfc3RhcnRfeG1pdCgpIGZhaWxzLiBXaXRoIHRoZSBmaXgsIGlmIHdlIHRyaWdnZXIgdGhl
IGlzc3VlIGFuZAo+ID4gdGhlIGVyciA9IC1FQlVTWSwgdGhlIGRyaXZlciByZXR1cm5zIE5FVERF
Vl9UWF9CVVNZLiBUaGUgbmV0d29yayBzdGFjawo+ID4gcmV0cmllcyB0byB0cmFuc21pdCB0aGUg
bWVzc2FnZS4KPiA+IE90aGVyd2lzZSwgaXQgcHJpbnRzIGFuIGVycm9yIGFuZCBkaXNjYXJkcyB0
aGUgbWVzc2FnZS4KPiA+IAo+ID4gRml4ZXM6IDU1ZTViOTdmMDAzZSAoImNhbjogbWNwMjV4eGZk
OiBhZGQgZHJpdmVyIGZvciBNaWNyb2NoaXAgTUNQMjV4eEZEIFNQSSBDQU4iKQo+ID4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IFZpdG9yIFNvYXJlcyA8dml0
b3Iuc29hcmVzQHRvcmFkZXguY29tPgo+ID4gLS0tCj4gPiAKPiA+IFYyLT5WMzoKPiA+IMKgIC0g
QWRkIHR4X2Ryb3BwZWQgc3RhdHMuCj4gPiDCoCAtIG5ldGRldl9zZW50X3F1ZXVlKCkgb25seSBp
ZiBjYW5fcHV0X2VjaG9fc2tiKCkgc3VjY2VlZC4KPiA+IAo+ID4gVjEtPlYyOgo+ID4gwqAgLSBS
ZXR1cm4gTkVUREVWX1RYX0JVU1kgaWYgbWNwMjUxeGZkX3R4X29ial93cml0ZSgpID09IC1FQlVT
WS4KPiA+IMKgIC0gUmV3b3JrIHRoZSBjb21taXQgbWVzc2FnZSB0byBhZGRyZXNzIHRoZSBjaGFu
Z2UgYWJvdmUuCj4gPiDCoCAtIENoYW5nZSBjYW5fcHV0X2VjaG9fc2tiKCkgdG8gYmUgY2FsbGVk
IGFmdGVyIG1jcDI1MXhmZF90eF9vYmpfd3JpdGUoKSBzdWNjZWVkLgo+ID4gwqDCoMKgIE90aGVy
d2lzZSwgd2UgZ2V0IEtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgZXJyb3IuCj4gPiAK
PiA+IMKgZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4ZmQvbWNwMjUxeGZkLXR4LmMgfCAzNCAr
KysrKysrKysrKystLS0tLS0tLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4v
c3BpL21jcDI1MXhmZC9tY3AyNTF4ZmQtdHguYwo+ID4gYi9kcml2ZXJzL25ldC9jYW4vc3BpL21j
cDI1MXhmZC9tY3AyNTF4ZmQtdHguYwo+ID4gaW5kZXggMTYwNTI4ZDNjYzI2Li4xNDZjNDRlNDdj
NjAgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXhmZC9tY3AyNTF4
ZmQtdHguYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4ZmQvbWNwMjUxeGZk
LXR4LmMKPiA+IEBAIC0xNjYsNiArMTY2LDcgQEAgbmV0ZGV2X3R4X3QgbWNwMjUxeGZkX3N0YXJ0
X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG5ldF9kZXZpY2Ug
Km5kZXYpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWNwMjUxeGZkX3ByaXYg
KnByaXYgPSBuZXRkZXZfcHJpdihuZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZXRf
ZGV2aWNlX3N0YXRzICpzdGF0cyA9ICZuZGV2LT5zdGF0czsKPiA+IMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgbWNwMjUxeGZkX3R4X3JpbmcgKnR4X3JpbmcgPSBwcml2LT50eDsKPiA+IMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgbWNwMjUxeGZkX3R4X29iaiAqdHhfb2JqOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoHVuc2lnbmVkIGludCBmcmFtZV9sZW47Cj4gPiBAQCAtMTgxLDI1ICsxODIsMzIgQEAgbmV0
ZGV2X3R4X3QgbWNwMjUxeGZkX3N0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwKPiA+IMKg
wqDCoMKgwqDCoMKgwqB0eF9vYmogPSBtY3AyNTF4ZmRfZ2V0X3R4X29ial9uZXh0KHR4X3Jpbmcp
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoG1jcDI1MXhmZF90eF9vYmpfZnJvbV9za2IocHJpdiwgdHhf
b2JqLCBza2IsIHR4X3JpbmctPmhlYWQpOwo+ID4gwqAKPiA+IC3CoMKgwqDCoMKgwqDCoC8qIFN0
b3AgcXVldWUgaWYgd2Ugb2NjdXB5IHRoZSBjb21wbGV0ZSBUWCBGSUZPICovCj4gPiDCoMKgwqDC
oMKgwqDCoMKgdHhfaGVhZCA9IG1jcDI1MXhmZF9nZXRfdHhfaGVhZCh0eF9yaW5nKTsKPiA+IC3C
oMKgwqDCoMKgwqDCoHR4X3JpbmctPmhlYWQrKzsKPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChtY3Ay
NTF4ZmRfZ2V0X3R4X2ZyZWUodHhfcmluZykgPT0gMCkKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBuZXRpZl9zdG9wX3F1ZXVlKG5kZXYpOwo+ID4gLQo+ID4gwqDCoMKgwqDCoMKg
wqDCoGZyYW1lX2xlbiA9IGNhbl9za2JfZ2V0X2ZyYW1lX2xlbihza2IpOwo+ID4gLcKgwqDCoMKg
wqDCoMKgZXJyID0gY2FuX3B1dF9lY2hvX3NrYihza2IsIG5kZXYsIHR4X2hlYWQsIGZyYW1lX2xl
bik7Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWVycikKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBuZXRkZXZfc2VudF9xdWV1ZShwcml2LT5uZGV2LCBmcmFtZV9sZW4pOwo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgdHhfcmluZy0+aGVhZCsrOwo+ID4gwqAKPiA+IMKgwqDCoMKg
wqDCoMKgwqBlcnIgPSBtY3AyNTF4ZmRfdHhfb2JqX3dyaXRlKHByaXYsIHR4X29iaik7Cj4gPiAt
wqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGdvdG8gb3V0X2VycjsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChlcnIpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0eF9yaW5nLT5oZWFkLS07Cj4gPiDCoAo+ID4gLcKgwqDC
oMKgwqDCoMKgcmV0dXJuIE5FVERFVl9UWF9PSzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoZXJyID09IC1FQlVTWSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5FVERFVl9UWF9CVVNZOwo+ID4gwqAKPiA+IC0g
b3V0X2VycjoKPiA+IC3CoMKgwqDCoMKgwqDCoG5ldGRldl9lcnIocHJpdi0+bmRldiwgIkVSUk9S
IGluICVzOiAlZFxuIiwgX19mdW5jX18sIGVycik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3RhdHMtPnR4X2Ryb3BwZWQrKzsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAobmV0X3JhdGVsaW1pdCgpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZXRkZXZfZXJyKHByaXYtPm5kZXYsCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICJFUlJPUiBpbiAlczogJWRcbiIsIF9fZnVuY19fLCBlcnIpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgfSBlbHNlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIg
PSBjYW5fcHV0X2VjaG9fc2tiKHNrYiwgbmRldiwgdHhfaGVhZCwgZnJhbWVfbGVuKTsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWVycikKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV0ZGV2X3NlbnRfcXVldWUocHJpdi0+
bmRldiwgZnJhbWVfbGVuKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAvKiBTdG9wIHF1ZXVlIGlmIHdlIG9jY3VweSB0aGUgY29tcGxldGUgVFggRklGTyAqLwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChtY3AyNTF4ZmRfZ2V0X3R4X2ZyZWUo
dHhfcmluZykgPT0gMCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbmV0aWZfc3RvcF9xdWV1ZShuZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiAK
PiBPbmNlIHlvdSBoYXZlIHNlbnQgdGhlIFRYIG9iamVjdHMgdG8gdGhlIGNoaXAsIGl0IGNhbiB0
cmlnZ2VyIGEgVFgKPiBjb21wbGV0ZSBJUlEuIFRoaXMgaXMgbm90IHZlcnkgbGlrZWx5IGFzIHRo
ZSBTUEkgc2VuZHMgYXN5bmNocm9ub3VzbHkKPiBhbmQgdGhlIHhtaXQgaGFuZGxlciBjYW5ub3Qg
c2xlZXAuCj4gCj4gVGhpcyBtZWFucyB5b3UgaGF2ZSB0byBjYWxsIGNhbl9wdXRfZWNob19za2Io
KSBhbmQgc3RvcCB0aGUgcXVldWUgaWYKPiBuZWVkZWQsIF9iZWZvcmVfIHlvdSBjYWxsIG1jcDI1
MXhmZF90eF9vYmpfd3JpdGUoKS4gSW4gY2FzZSBvZiBhbiBlcnJvciwKPiB5b3UgaGF2ZSB0byBy
b2xsLWJhY2sgdGhlc2UuCgpEb2luZyB0aGlzIHdheSwgSSBoYXZlIHRvIGNhbl9mcmVlX2VjaG9f
c2tiKCkgYW5kIGl0IHdvbid0IGJlIHBvc3NpYmxlCnRvIHJldHVybiBORVRERVZfVFhfQlVTWS4K
CkRvIHlvdSBrbm93IGhvdyBjYW4gd2UgcmV0dXJuIE5FVERFVl9UWF9CVVNZIHdoZW4gc3BpX2Fz
eW5jKCkgPT0gRUJVU1kKdG8gYWxsb3cgdGhlIG5ldHdvcmsgc3RhY2sgdG8gcmV0cnkgdG8gdHJh
bnNtaXQgdGhlIHBhY2thZ2U/CgpCZXN0IHJlZ2FyZHMsClZpdG9yIFNvYXJlcwoKPiAKPiByZWdh
cmRzLAo+IE1hcmMKPiAKCg==


