Return-Path: <linux-kernel+bounces-132533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1789965B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC49F283546
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287702C68B;
	Fri,  5 Apr 2024 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3bIWWY/"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166426AFD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301316; cv=none; b=R+4bdjcSVP3l4hJL1+642vvgkAmLwtATk/s83yWT5/4zeoFE/2pwXnzRCG+RV8IpsoOlxCZ/S/E0CDJdvCI4pRjwp79q4x2Xb5+ARCoHA/o/qSmDb1Lf02X7Ev2ogp5MSp4Y7gu9UetGECZdjkEUQNrO112MPeGpzDv9ddRGz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301316; c=relaxed/simple;
	bh=ZQRZDYqA6aP2iutVThlq5tpmCslswP1QsB6CFhMiTH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEqLIefFZqTahMmTRdwNay/petyY/GirT9VbaYjkXTP+yejYNHOAH9RcVIkrT+qoTdbxgSrSdhEkSV3xQcV3cfAdPqCOzRyzui73UL+eTEWtxJoksc8geEZfvtmvZSclLdECkkyv0mMywhPb1RcA3Z8vIgPxzDJG/JOZuFE7Gqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3bIWWY/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343d4f250f1so336720f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712301311; x=1712906111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQRZDYqA6aP2iutVThlq5tpmCslswP1QsB6CFhMiTH0=;
        b=l3bIWWY/IFYuc9EnYBDUw2KNP/3XIc3wx3uNdkURRHVYFjj4+ptGWAAtrRwUM26XNB
         rCLITauGDpFeNUG3dzdOJrOlZjxLMA8CD6jfaVETR2gWzgRHQ9RXQRl9eH82NWwcgqru
         a2LzHgRINeHxgjKYAOmbiFTawM28I8aUgbr8f2SILPfQogLU67k06aUni3AusZcmFzqH
         p+fDEZFI+FzbzpSBDj87riWTP0e6YDXfRizDGrtNx2Vi+Ui8zbz7tZx3zEceV6tRnUZZ
         j5uxLjfr9ZF0oFK8VEq5m852GbgPEhSKEbwuW2kCuq1wpoSl+2v+OSoe3wDCEvSGWs4D
         LV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301311; x=1712906111;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQRZDYqA6aP2iutVThlq5tpmCslswP1QsB6CFhMiTH0=;
        b=V+XoSa4eNypRGTHg8zywnU/KusOEOLyYUyU3FCp90CLXONkOHyybAl7+xKcV3fc2Vb
         weWud/EdcF5QlNQjGBPhOpZ0hvx3ThhhexWEvuHCd7RJhkDkFzUhKFMbWuKN4//qymUu
         aJj5ktWas1oC9pJ4toLrkJZL8lmOloZHH6X5YPrfNcfATTrXdj39ojFUaQ0GUHWIGDlf
         vN9PwiGAGlIWqwD1OhlxmiMer9o1MU4rKS8Pw8E+PbUIEoA76pBqvTMBx+2noyS9ys6P
         bhL+XRWNBbuXe5RHzFqs/WUhYHUasiVvPs0BNUvAJOq4u+Ivq34BFdCUKOoA2kXatWN9
         b0IA==
X-Forwarded-Encrypted: i=1; AJvYcCWd1kGxF3Dmmhy6LEOMByq/mRDp0yaF8g0C0fo6TXohy5eBRbbcGHIy3QiKSjVdFJ5aZTe8k1CUSBpqe1UzphdMpGj2+/p3eDW4ytST
X-Gm-Message-State: AOJu0YzIOsheR1Lhzb2cJSapxjQNSB+WFSMPP8g1tyU37xSfV3BsV5rb
	yKME1cG1NSKVUsU7GeGbiC9pM6PeyL9LdCLclM7WZXLGK5ikdlafR5qtJztok3Y=
X-Google-Smtp-Source: AGHT+IF3TQ9xIZ1T/P0vZPLv2tjkqzrrnsOBy+FFNKa6jwX5G7cmYjLQCMB/2P2Fzf20qbcX8C+AiQ==
X-Received: by 2002:adf:f184:0:b0:343:d06e:51c8 with SMTP id h4-20020adff184000000b00343d06e51c8mr387939wro.18.1712301311433;
        Fri, 05 Apr 2024 00:15:11 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d568b000000b00343c9ce4b50sm1279358wrv.53.2024.04.05.00.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:15:11 -0700 (PDT)
Message-ID: <d1aaa3a350315b8eb60aaee416fad4382385ca3a.camel@linaro.org>
Subject: Re: [PATCH 01/17] dt-bindings: clock: google,gs101-clock:  add HSI2
 clock management unit
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
 avri.altman@wdc.com,  bvanassche@acm.org, s.nawrocki@samsung.com,
 cw00.choi@samsung.com,  jejb@linux.ibm.com, martin.petersen@oracle.com,
 chanho61.park@samsung.com,  ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Date: Fri, 05 Apr 2024 08:15:09 +0100
In-Reply-To: <20240404122559.898930-2-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
	 <20240404122559.898930-2-peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUGV0ZSwKCk9uIFRodSwgMjAyNC0wNC0wNCBhdCAxMzoyNSArMDEwMCwgUGV0ZXIgR3JpZmZp
biB3cm90ZToKPiBBZGQgZHQgc2NoZW1hIGRvY3VtZW50YXRpb24gYW5kIGNsb2NrIElEcyBmb3Ig
dGhlIEhpZ2ggU3BlZWQgSW50ZXJmYWNlCj4gMiAoSFNJMikgY2xvY2sgbWFuYWdlbWVudCB1bml0
LiBUaGlzIENNVSBmZWVkcyBoaWdoIHNwZWVkIGludGVyZmFjZXMKPiBzdWNoIGFzIFBDSWUgYW5k
IFVGUy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBHcmlmZmluIDxwZXRlci5ncmlmZmluQGxp
bmFyby5vcmc+Cj4gLS0tCj4gwqAuLi4vYmluZGluZ3MvY2xvY2svZ29vZ2xlLGdzMTAxLWNsb2Nr
LnlhbWzCoMKgwqAgfCAzMCArKysrKysrKysrKysrKysrKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dvb2dsZSxnczEwMS1jbG9jay55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dvb2dsZSxnczEwMS0K
PiBjbG9jay55YW1sCj4gaW5kZXggMWQyYmNlYTQxYzg1Li5hMjAyZmQ1ZDFlYWQgMTAwNjQ0Cj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dvb2dsZSxnczEw
MS1jbG9jay55YW1sCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Ns
b2NrL2dvb2dsZSxnczEwMS1jbG9jay55YW1sCj4gQEAgLTMyLDE0ICszMiwxNSBAQCBwcm9wZXJ0
aWVzOgo+IMKgwqDCoMKgwqDCoCAtIGdvb2dsZSxnczEwMS1jbXUtbWlzYwo+IMKgwqDCoMKgwqDC
oCAtIGdvb2dsZSxnczEwMS1jbXUtcGVyaWMwCj4gwqDCoMKgwqDCoMKgIC0gZ29vZ2xlLGdzMTAx
LWNtdS1wZXJpYzEKPiArwqDCoMKgwqDCoCAtIGdvb2dsZSxnczEwMS1jbXUtaHNpMgoKQ2FuIHlv
dSBrZWVwIHRoaXMgYWxwaGFiZXRpY2FsIGFuZCBhZGQgaHNpIGJlZm9yZSBtaXNjIHBsZWFzZS4K
PiDCoAo+IMKgwqAgY2xvY2tzOgo+IMKgwqDCoMKgIG1pbkl0ZW1zOiAxCj4gLcKgwqDCoCBtYXhJ
dGVtczogMwo+ICvCoMKgwqAgbWF4SXRlbXM6IDUKPiDCoAo+IMKgwqAgY2xvY2stbmFtZXM6Cj4g
wqDCoMKgwqAgbWluSXRlbXM6IDEKPiAtwqDCoMKgIG1heEl0ZW1zOiAzCj4gK8KgwqDCoCBtYXhJ
dGVtczogNQo+IMKgCj4gwqDCoCAiI2Nsb2NrLWNlbGxzIjoKPiDCoMKgwqDCoCBjb25zdDogMQo+
IEBAIC0xMTIsNiArMTEzLDMxIEBAIGFsbE9mOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAt
IGNvbnN0OiBidXMKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogaXAKPiDCoAo+
ICvCoCAtIGlmOgo+ICvCoMKgwqDCoMKgIHByb3BlcnRpZXM6Cj4gK8KgwqDCoMKgwqDCoMKgIGNv
bXBhdGlibGU6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBjb250YWluczoKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBlbnVtOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGdvb2dsZSxn
czEwMS1jbXUtaHNpMgoKdGhpcyBibG9jayBzaG91bGQgYWxzbyBjb21lIGJlZm9yZSBtaXNjIHBs
ZWFzZS4KCk9uY2UgZG9uZSwgZmVlbCBmcmVlIHRvIGFkZAoKUmV2aWV3ZWQtYnk6IEFuZHLDqSBE
cmFzemlrIDxhbmRyZS5kcmFzemlrQGxpbmFyby5vcmc+CgoKPiArCj4gK8KgwqDCoCB0aGVuOgo+
ICvCoMKgwqDCoMKgIHByb3BlcnRpZXM6Cj4gK8KgwqDCoMKgwqDCoMKgIGNsb2NrczoKPiArwqDC
oMKgwqDCoMKgwqDCoMKgIGl0ZW1zOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gZGVzY3Jp
cHRpb246IEV4dGVybmFsIHJlZmVyZW5jZSBjbG9jayAoMjQuNTc2IE1IeikKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBIaWdoIFNwZWVkIEludGVyZmFjZSBidXMgY2xv
Y2sgKGZyb20gQ01VX1RPUCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9u
OiBIaWdoIFNwZWVkIEludGVyZmFjZSBwY2llIGNsb2NrIChmcm9tIENNVV9UT1ApCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogSGlnaCBTcGVlZCBJbnRlcmZhY2UgdWZz
IGNsb2NrIChmcm9tIENNVV9UT1ApCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBkZXNjcmlw
dGlvbjogSGlnaCBTcGVlZCBJbnRlcmZhY2UgbW1jIGNsb2NrIChmcm9tIENNVV9UT1ApCj4gKwo+
ICvCoMKgwqDCoMKgwqDCoCBjbG9jay1uYW1lczoKPiArwqDCoMKgwqDCoMKgwqDCoMKgIGl0ZW1z
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG9zY2Nsawo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC0gY29uc3Q6IGJ1cwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29u
c3Q6IHBjaWUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiB1ZnNfZW1iZAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG1tY19jYXJkCj4gKwo+IMKgYWRkaXRpb25h
bFByb3BlcnRpZXM6IGZhbHNlCj4gwqAKPiDCoGV4YW1wbGVzOgoK


