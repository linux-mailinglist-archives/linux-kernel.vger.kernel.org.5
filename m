Return-Path: <linux-kernel+bounces-157289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F378B0F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2591C22BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B81607B8;
	Wed, 24 Apr 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IInMrGfT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE515EFAC;
	Wed, 24 Apr 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974754; cv=none; b=Qm6iWpCUqabxlEBYR20k0Xm9ObLXsRUA5jCgpuOi+MikAbBDMW61u5i00n7aWShgwd2xq9mC+RAMT1v7K6zCS7+oAlzaRbPX3j+/y1GTg4poQ8quB2zi1gyDKdcPP4M8rmlmDnCOl9ibAZEp8PXsyLkK/N6GsDu5lGs4N8c2x2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974754; c=relaxed/simple;
	bh=Yem5qbHtxN0cJ/ytsfQ9VNOy5kHSWYu/mAE9kZGb0vI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UtUBeEoA+P4WDAizkOvlMMrSxk+5dzKkmHlJokXeXD/GBxhfecg05U3meT5x1jKsi3HJ+zcWfHh+aA5fm3I3cdNvIm3wKKd8qy5ib7bN/KGQudM7KYODDyT/VPHU4eCqRldfPh+cNjDVcXmnZHhePxjil+FZgtsxjs7Ojbv6ZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IInMrGfT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso45476091fa.3;
        Wed, 24 Apr 2024 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713974750; x=1714579550; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0x24o6hMGFGBnQfu7F8O4txKF88EkdHZ31y54DTNU68=;
        b=IInMrGfTlvwiVmBEmrYMrGlW2Yp9z+B9e9wHWcdN5qtpkoARqlk54vymjNqZ3+uTQu
         x7DiIGWuRX/LTqov1/gA7AIvlQ+zU1G84tE9YbWjYGkjCRLqZA2VP2VcN8EBZm1yhv6H
         RPXEpnrl3NlqV/hTUJQMC/UQHruGktJbgqjGOgGwvdMuL0E6QY4Ji5suavgBxjPrMuu+
         AjWx3alRpUakfsjRSATFkMsB8gAMp8NH8XMulhZamJSPiPUPfkIm8qOmlz0ee0rDlS4j
         H29TaKkVjdS2e4p5QKLMZVW91xXZb/FG1s6SLj4T0UT4C0b5hU177/mnE4xq7sTrC2qU
         AXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974750; x=1714579550;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0x24o6hMGFGBnQfu7F8O4txKF88EkdHZ31y54DTNU68=;
        b=Mc0Y7283SV61mXsZvSK7YdQ2Odfh0m4ln8Z7tf4E4jyuLMhpKASoRWhoHFDlbX5DVY
         52oy2csrI9+6FVY8foqegjDdWgBziiyisk0GFqchWj7XUkHIAklbm0BdN+eIifWkmF+w
         hUmkrilmjscupBPjo+PMHPzhW7eKrLmOyXB+bEeYQ2EANZ2DkhiurgtcLgzY0S494vzw
         /rNOF4FqgN0xgB8iDZDbXXEAG2izmFqchCcZpM+JY9qCbwk+9Z5TkaQOzaWg8xVIS+D/
         rLayGKYwa/9GBTNqcWBU8Pg65Wamv9gEIwMXaN1DxfKBDkZtAD/s1MEhsI5sGhzdXKdT
         AiGg==
X-Forwarded-Encrypted: i=1; AJvYcCXXH19yGr3dVugcbInvbzjLF8Jd8FXvZzs7ksfFfRZXe+VgrAX6KQci+gsc7a2qlkghwYz3LMhHMMCqQ46m31xWkw8F8HnNVQcPaOhPMkq1D1w0VafOwKrcFXYhUdYX5IH4DiJSf4qRZWI=
X-Gm-Message-State: AOJu0YzNLFI+tKLg1eVA7GI1ATQJvTfgIfFlGiMAQZcWvgYmNj0y/MA5
	MljDBeVqlzj5ZcxoWTeUiFH6lktmsXVy+2DEDPVj02LUHeXVq9hqpYSMCYINKSJYJXubcXNO9ny
	yXfVJTxYabUwvDc5I+XCB3XlMButAlg1J
X-Google-Smtp-Source: AGHT+IGiEOTkIS5Us1soeCARBGPKxlWm6WdKXlwdCsAqxyxtb8F/yXDmA6wQDCcy90KLueah/wb7zUHimGlk5FoxZ6g=
X-Received: by 2002:a2e:9c07:0:b0:2de:d00f:e656 with SMTP id
 s7-20020a2e9c07000000b002ded00fe656mr24507lji.37.1713974750346; Wed, 24 Apr
 2024 09:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aman Dhoot <amandhoot12@gmail.com>
Date: Wed, 24 Apr 2024 21:36:42 +0530
Message-ID: <CAMTp=B+3NG65Z684xMwHqdXDJhY+DJK-kuSw4adn6xwnG+b5JA@mail.gmail.com>
Subject: Patch for mute led of HP Laptop 15 da3001TU
To: tiwai@suse.com, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002628c50616d9d881"

--0000000000002628c50616d9d881
Content-Type: multipart/alternative; boundary="0000000000002628c30616d9d87f"

--0000000000002628c30616d9d87f
Content-Type: text/plain; charset="UTF-8"

Hello there,

This patch is for fixing the volume mute LED on HP Laptop 15 da3001TU,
this patch adds SND_PCI_QUIRK for HP Laptop 15-da3001TU, please review this
patch & add this patch to the mainline kernel.

I have tested this patch on the latest kernel 6.8.7 & it is working without
any problem.

--0000000000002628c30616d9d87f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello there,<div><br></div><div>This=C2=A0patch is for fix=
ing the volume mute LED on=C2=A0HP Laptop 15 da3001TU, this=C2=A0patch adds=
 SND_PCI_QUIRK for HP Laptop 15-da3001TU, please review this patch &amp; ad=
d this patch to the mainline kernel.</div><div><br></div><div>I have tested=
 this patch on the latest kernel 6.8.7 &amp; it is working without any=C2=
=A0problem.</div></div>

--0000000000002628c30616d9d87f--
--0000000000002628c50616d9d881
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Fix-mute-led-of-HP-Laptop-15-da3001TU.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-mute-led-of-HP-Laptop-15-da3001TU.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lve0a2at0>
X-Attachment-Id: f_lve0a2at0

RnJvbSAxMjEwOGNlNzk0NDY1OTI1YzlkYzE4NDI1MzM1NmQxZGFhYTlmNTA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWFuIERob290IDxhbWFuZGhvb3QxMkBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgMjIgQXByIDIwMjQgMTg6MDg6MjMgKzA1MzAKU3ViamVjdDogW1BBVENIXSBGaXgg
bXV0ZSBsZWQgb2YgSFAgTGFwdG9wIDE1LWRhMzAwMVRVLgoKVGhpcyBwYXRjaCBzaW1wbHkgYWRk
IFNORF9QQ0lfUVVJUksgZm9yIEhQIExhcHRvcCAxNS1kYTMwMDFUVSB0byBmaXhlZCBtdXRlIGxl
ZCBvZiBsYXB0b3AuCgpTaWduZWQtb2ZmLWJ5OiBBbWFuIERob290IDxhbWFuZGhvb3QxMkBnbWFp
bC5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
cmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggZDFjMzVjZDVh
Nzc2Li40MTg5ZWIzMDQ4NGEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRl
ay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC05OTM3LDYgKzk5Mzcs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtd
ID0gewogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDg2MGYsICJIUCBaQm9vayAxNSBHNiIsIEFM
QzI4NV9GSVhVUF9IUF9HUElPX0FNUF9JTklUKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4
NjFmLCAiSFAgRWxpdGUgRHJhZ29uZmx5IEcxIiwgQUxDMjg1X0ZJWFVQX0hQX0dQSU9fQU1QX0lO
SVQpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDg2OWQsICJIUCIsIEFMQzIzNl9GSVhVUF9I
UF9NVVRFX0xFRCksCisJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODZjMSwgIkhQIExhcHRvcCAx
NS1kYTMwMDFUVSIsIEFMQzIzNl9GSVhVUF9IUF9NVVRFX0xFRF9DT0VGQklUMiksCiAJU05EX1BD
SV9RVUlSSygweDEwM2MsIDB4ODZjNywgIkhQIEVudnkgQWlPIDMyIiwgQUxDMjc0X0ZJWFVQX0hQ
X0VOVllfR1BJTyksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODZlNywgIkhQIFNwZWN0cmUg
eDM2MCAxNS1lYjB4eHgiLCBBTEMyODVfRklYVVBfSFBfU1BFQ1RSRV9YMzYwX0VCMSksCiAJU05E
X1BDSV9RVUlSSygweDEwM2MsIDB4ODZlOCwgIkhQIFNwZWN0cmUgeDM2MCAxNS1lYjB4eHgiLCBB
TEMyODVfRklYVVBfSFBfU1BFQ1RSRV9YMzYwX0VCMSksCi0tIAoyLjM5LjIKCg==
--0000000000002628c50616d9d881--

