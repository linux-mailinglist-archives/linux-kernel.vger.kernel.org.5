Return-Path: <linux-kernel+bounces-136931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1689DA0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FDEB231BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05912F383;
	Tue,  9 Apr 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq1/UOt5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493512DD8A;
	Tue,  9 Apr 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668943; cv=none; b=Uotw7R0EebwqMKT16YW0XC++lKMXk7rtAONVT1fixwDFgtBXx7tM8K171XfuWNYvB00+vMMlNIcyKtldhvKTJJH9mjLe7qKDlyO2ZJzO5KAPZlG5hPLlJt97BsLSXq6cpQUXD0uvrSmidddNUxd/dsuZ4Nq5BHlPsr1I3P6DrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668943; c=relaxed/simple;
	bh=cWuDlkVeaUEV0K6gKq/8fei9t5lcZ6BdfywJ4z5hing=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0AB9WInwSQCpiy/ZkuH6pOmqDg1dEONe4UDiUnhsoZjD5fmcBriYmyn75t8y0lU5/4ctJuBplu2pidqzJV/H6/I9xn9aO3nacF8l1annTIeyt0NdUUApDXg6O/Lyx2MrfeMSki1C2tTiUbkgLlR6K5DpMugoqVo6BF4cYo+ghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq1/UOt5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41691fb4c8fso11274565e9.1;
        Tue, 09 Apr 2024 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712668940; x=1713273740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWuDlkVeaUEV0K6gKq/8fei9t5lcZ6BdfywJ4z5hing=;
        b=Nq1/UOt55FpSb032kgwf5teMM9nrX2Wo/lsDAkzyxTa/c2GgLEHcFYdo/novDSBVKc
         V9SOd8vdCFwt+Z4zJnI0k0jL6qnJYxVBQYix03/wSu9sYoLk09KAj4FmC6CZL1wir4PT
         KIa1XanVTvmbuUfznQ+RZTr0u1E5V7wZgB/7P+awqZ8OvOUzo4eQv1hzZx0hJxAWeZ2G
         WN/7HlOKP3qgJLOO0SToJmadIfWnd0mKr5IDKgTJpY2K+y8Wjoqm09kUTkuBsFAzIOx+
         32pzu7XZuXtPLkpKIpu/q3QwrEKNeLOPBefhS9eyXVyRRpdrUo0/2UFxC6smdKCbgCsW
         /7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712668940; x=1713273740;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWuDlkVeaUEV0K6gKq/8fei9t5lcZ6BdfywJ4z5hing=;
        b=q/s5QjFxRgLuhSmzOFitidolvGv5+Y/0soreZqaLPssU3db8o9+p1e08bdGt/c8DUU
         o3w874k2Rrgy/wtly2MSdn44Ja03sG9Z2hCbQUGKIeQhMe6oWO8zmbkSHQDw3KUwXE/9
         +KmnXuHhlHCPBDLfIFOFAcCoadePostMJ5lAfAMrsfFi5PnDj+Nj2H4u4RuebRSfozfz
         yo1hE+mDbjAeiZysQqdCmKS6nEbNIErPXCST88vhXO1ObTo1xL/DngpOfL4sFdDlQBAl
         oWQhY97pCh6xaG4A1Qewl8mH5bIioDI2D+GfYdPof+5o2QP+xrSRpLXQf9i/4o1+vzxb
         Xlbg==
X-Forwarded-Encrypted: i=1; AJvYcCV6zMtgPlAqqMFp3/BlKmvsLpXbY6kTIbe2DzhJy2tUEKnY+EJ1qUXtAz1a9Weuk9s1xVz1Zj10r0xgTh1SbcT2hWIIBcL2uGYvzz6275mT4tiaRPieqahuBwNQJ43CI2H4HZHDE3Ef/tXSYnC+jXPwTfoVpksOOvlCLSfy6BCFZQ==
X-Gm-Message-State: AOJu0YxM8hTslnG1DzLvb5QQ0Ck1NW+m/oYPH1jyNiGbG/RD+B2iR7UI
	w9fVCgecew+LKXCrFq/DfXY8aiQpBg6gFVVqhs+St/s+DE1iNPo8
X-Google-Smtp-Source: AGHT+IGgbrNoEZ8Sup1xX5K7cB+lPmat/joPV2/YgazjQyOKyqAmRzoIEAzbms/1DuSoDkYfKuwXZQ==
X-Received: by 2002:a05:600c:1ca1:b0:416:a8a7:9505 with SMTP id k33-20020a05600c1ca100b00416a8a79505mr1068121wms.5.1712668939657;
        Tue, 09 Apr 2024 06:22:19 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:2455:df03:b036:54c9? ([2001:8a0:e622:f700:2455:df03:b036:54c9])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b0041665b6e111sm8601000wmq.12.2024.04.09.06.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:22:19 -0700 (PDT)
Message-ID: <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power
 domain parent
From: Vitor Soares <ivitro@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 09 Apr 2024 14:22:17 +0100
In-Reply-To: <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
References: <20240409085802.290439-1-ivitro@gmail.com>
	 <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTHVjYXMsCgpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suCgpPbiBUdWUsIDIwMjQtMDQtMDkg
YXQgMTE6MTMgKzAyMDAsIEx1Y2FzIFN0YWNoIHdyb3RlOgo+IEhpIFZpdG9yLAo+IAo+IEFtIERp
ZW5zdGFnLCBkZW0gMDkuMDQuMjAyNCB1bSAwOTo1OCArMDEwMCBzY2hyaWViIFZpdG9yIFNvYXJl
czoKPiA+IEZyb206IFZpdG9yIFNvYXJlcyA8dml0b3Iuc29hcmVzQHRvcmFkZXguY29tPgo+ID4g
Cj4gPiBUaGUgcGdjX3ZwdV8qIG5vZGVzIG1pc3MgdGhlIHJlZmVyZW5jZSB0byB0aGUgcG93ZXIg
ZG9tYWluIHBhcmVudCwKPiA+IGxlYWRpbmcgdGhlIHN5c3RlbSB0byBoYW5nIGR1cmluZyB0aGUg
cmVzdW1lLgo+ID4gCj4gVGhpcyBjaGFuZ2UgaXMgbm90IGNvcnJlY3QuIFRoZSB2cHVtaXggZG9t
YWluIGlzIGNvbnRyb2xsZWQgdGhyb3VnaAo+IHRoZQo+IGlteDhtbS12cHUtYmxrLWN0cmwgYW5k
IG11c3Qgbm90IGJlIGRpcmVjdGx5IHRyaWdnZXJlZCBieSB0aGUgY2hpbGQKPiBkb21haW5zIGlu
IG9yZGVyIHRvIGd1YXJhbnRlZSBwcm9wZXIgcG93ZXIgc2VxdWVuY2luZy4KPiAKPiBJZiB0aGUg
c2VxdWVuY2luZyBpcyBpbmNvcnJlY3QgZm9yIHJlc3VtZSwgaXQgbmVlZHMgdG8gYmUgZml4ZWQg
aW4KPiB0aGUKPiBibGstY3RybCBkcml2ZXIuIEknbGwgaGFwcGlseSBhc3Npc3QgaWYgeW91IGhh
dmUgYW55IHF1ZXN0aW9ucyBhYm91dAo+IHRoaXMgaW50cmljYXRlIG1peCBiZXR3ZWVuIEdQQyBh
bmQgYmxrLWN0cmwgaGFyZHdhcmUvZHJpdmVycy4KIApJJ20gbmV3IGludG8gdGhlIHRvcGljLCBz
byBJIHRyaWVkIHRvIGZvbGxvdyBzYW1lIGFwcHJvYWNoIGFzIGluIGlteDhtcApEVC4gSSBhbHNv
IGNoZWNrZWQgdGhlIGlteDhtcSBEVCBhbmQgaXQgb25seSBoYXZlIG9uZSBkb21haW4gZm9yIHRo
ZQpWUFUgaW4gdGhlIEdQQy4gSXQgc2VlbSBibGstY3RybCBhbHNvIGRlcGVuZGVzIG9uIHBnY192
cHVfKiB0byB3b3JrCnByb3Blcmx5LgoKVGhlIGJsay1jdHJsIGRyaXZlciBoYW5ncyBvbiBpbXg4
bV9ibGtfY3RybF9wb3dlcl9vbigpIHdoZW4gYWNjZXNzIHRoZQppcCByZWdpc3RlcnMgZm9yIHRo
ZSBzb2Z0IHJlc2V0LiBJIHRyaWVkIHRvIHBvd2VyLXVwIHRoZSBiZWZvcmUgdGhlCnNvZnQgcmVz
ZXQsIGJ1dCBpdCBkaWRuJ3Qgd29yay4KCkRvIHlvdSBoYXZlIGFuIGlkZWEgaG93IHdlIGNhbiBh
ZGRyZXNzIHRoaXMgd2l0aGluIGJsay1jdHJsPwoKQmVzdCByZWdhcmRzLApWaXRvcgoKPiAKPiBS
ZWdhcmRzLAo+IEx1Y2FzCj4gCj4gPiBBcyB0aGVzZSBQVSBkb21haW5zIGFyZSBuZXN0ZWQgaW5z
aWRlIHRoZSB2cHVtaXggZG9tYWluLCBsZXQncwo+ID4gcmVmZXJlbmNlCj4gPiBpdCBhY2NvcmRp
bmdseS4gQWZ0ZXIgdGhpcyBjaGFuZ2UsIHRoZSBzdXNwZW5kL3Jlc3VtZSBpcyB3b3JraW5nLgo+
ID4gCj4gPiBDYzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cj4gPiBDYzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Cj4gPiBDbG9zZXM6Cj4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvZmNjYmIwNDAzMzBhNzA2YTRmN2IzNDg3NWRiMWQ4OTZhMGJmODFjOC5jYW1l
bEBnbWFpbC5jb20vCj4gPiBGaXhlczogZDM5ZDRiYjE1MzEwICgiYXJtNjQ6IGR0czogaW14OG1t
OiBhZGQgR1BDIG5vZGUiKQo+ID4gU2lnbmVkLW9mZi1ieTogVml0b3IgU29hcmVzIDx2aXRvci5z
b2FyZXNAdG9yYWRleC5jb20+Cj4gPiAtLS0KPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1tLmR0c2kgfCAzICsrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bW0uZHRzaQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0u
ZHRzaQo+ID4gaW5kZXggOGExYjQyYjk0ZGNlLi45N2QwYzZkMjNhZDggMTAwNjQ0Cj4gPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQo+ID4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kKPiA+IEBAIC03MzksMTYgKzcz
OSwxOSBAQCBwZ2NfdnB1bWl4OiBwb3dlci1kb21haW5ANiB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHBnY192cHVfZzE6IHBvd2VyLWRvbWFpbkA3Cj4gPiB7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjcG93ZXItZG9tYWluLWNlbGxzCj4gPiA9IDwwPjsK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9Cj4gPiA8SU1Y
OE1NX1BPV0VSX0RPTUFJTl9WUFVHMT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHBvd2VyLWRvbWFpbnMgPQo+ID4gPCZwZ2NfdnB1bWl4PjsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBnY192
cHVfZzI6IHBvd2VyLWRvbWFpbkA4Cj4gPiB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAjcG93ZXItZG9tYWluLWNlbGxzCj4gPiA9IDwwPjsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9Cj4gPiA8SU1YOE1NX1BPV0VSX0RP
TUFJTl9WUFVHMj47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBv
d2VyLWRvbWFpbnMgPQo+ID4gPCZwZ2NfdnB1bWl4PjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBnY192cHVfaDE6IHBvd2Vy
LWRvbWFpbkA5Cj4gPiB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAjcG93ZXItZG9tYWluLWNlbGxzCj4gPiA9IDwwPjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9Cj4gPiA8SU1YOE1NX1BPV0VSX0RPTUFJTl9WUFVIMT47
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBvd2VyLWRvbWFpbnMg
PQo+ID4gPCZwZ2NfdnB1bWl4PjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+IMKg
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBnY19kaXNwbWl4Ogo+ID4gcG93ZXItZG9tYWlu
QDEwIHsKPiAKCg==


