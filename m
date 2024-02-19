Return-Path: <linux-kernel+bounces-70666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06186859ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E841C20F25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F973D7B;
	Mon, 19 Feb 2024 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="QBTww7cr"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F12103
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311437; cv=none; b=mRnFWh5DdnHN+tkt7I6aAiSmV/yy6Xg3+MbJ6eSzy8IIb5rfnSS3HVqbQtq1HriZob4mokwfNRK8TRuzvpArbT06G4KUS/Ptid3dEd7+VMLXGBRSzNvJ3PD+dWe7GFxduZF0O2AvzZMdjNGxJgc0B7kv8AIh1eUXsstZ1cGM4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311437; c=relaxed/simple;
	bh=/sT628QU7hhhOgu/cwt/DOFforB7kkTOr1NUg6K+gJ0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msvve7wfvLI4ZUC4Vgz/S7Ior/cjBByKRo8i+mt9IlH0oeGvsKhXMggQw8KSH31s5u34lF8hKEIWGMTZp9zZWqf6jwSKdKoPI5gwF1mA6vPIi+Hi6BoqKCWEa3rRm7GSjW90WjicyMiV6koR25GI5h+grXxihCaZtavVYw7Lddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=QBTww7cr; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3C72A2C0270;
	Mon, 19 Feb 2024 15:51:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708311118;
	bh=/sT628QU7hhhOgu/cwt/DOFforB7kkTOr1NUg6K+gJ0=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=QBTww7cryoBEcwLYtR6q5ueAEMVVHO9gaxqHKqynPL4t6Pn5apTeWv+hO4QSRl8iK
	 zdvXwPjZdIj3SF9pQ4gAcCgfmiiv2SLbO6QLgE2tg+yfDc14LgRqtP1HGUrQyCIyrN
	 580U7SGWXEo7xynot121kxFct1zrEHzYypnBVuT7mtOupZ5YcVReYSUE546tvTCGhI
	 RplUvB6YkDP/gURV6XFUVoG6he6jbnTHR70aTkudprxmOr2Jw6dK/mVTkg1EcQxrFE
	 28CahbBREBl+uutmJEcC2jHEMkWEvgqyQA05wKD6NI2N7+D3XhS1Om50SHs4fOfWEV
	 i8p8Oo2G/Oq6Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d2c24e0001>; Mon, 19 Feb 2024 15:51:58 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 15:51:57 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 19 Feb 2024 15:51:57 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Alessandro Zummo
	<a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Jean Delvare" <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] rtc: max31335: add driver support
Thread-Topic: [PATCH v9 2/2] rtc: max31335: add driver support
Thread-Index: AQHaYt6aqhqsMvt9rUeZpcrpI3oGpA==
Date: Mon, 19 Feb 2024 02:51:57 +0000
Message-ID: <1a51a8ac-e2a6-4054-b91d-c860913b7385@alliedtelesis.co.nz>
References: <20231120120114.48657-1-antoniu.miclaus@analog.com>
 <20231120120114.48657-2-antoniu.miclaus@analog.com>
In-Reply-To: <20231120120114.48657-2-antoniu.miclaus@analog.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D9684104BB159439CC41F4F009C1578@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d2c24e a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=_jlGtV7tAAAA:8 a=gAnH3GRIAAAA:8 a=FVfxCX4UZNgzJca5yKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0

SGkgQWxsLA0KDQpJJ20gbG9va2luZyBhdCBmb2xkaW5nIHRoaXMgaW50byB0aGUgcmVzdCBvZiB0
aGUgbWF4MzEzeHggc3VwcG9ydCAoYnV0IA0KSSdsbCBzdGljayB3aXRoIHRoZSBtYXgzMTMzNSBu
YW1lIHNpbmNlIHRoYXQncyBsYW5kZWQpIGFuZCBJIG5vdGljZWQgYSANCnByb2JsZW0uDQoNCk9u
IDIxLzExLzIzIDAxOjAwLCBBbnRvbml1IE1pY2xhdXMgd3JvdGU6DQo+IFJUQyBkcml2ZXIgZm9y
IE1BWDMxMzM1IMKxMnBwbSBBdXRvbW90aXZlIFJlYWwtVGltZSBDbG9jayB3aXRoDQo+IEludGVn
cmF0ZWQgTUVNUyBSZXNvbmF0b3IuDQo+DQo+IFJldmlld2VkLWJ5OiBHdWVudGVyIFJvZWNrIDxs
aW51eEByb2Vjay11cy5uZXQ+DQo+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8YW50
b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo8c25pcD4NCj4gKw0KPiArc3RhdGljIGJvb2wgbWF4
MzEzMzVfdm9sYXRpbGVfcmVnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHJlZykN
Cj4gK3sNCj4gKwkvKiB0aW1lIGtlZXBpbmcgcmVnaXN0ZXJzICovDQo+ICsJaWYgKHJlZyA+PSBN
QVgzMTMzNV9TRUNPTkRTICYmDQo+ICsJICAgIHJlZyA8IE1BWDMxMzM1X1NFQ09ORFMgKyBNQVgz
MTMzNV9USU1FX1NJWkUpDQo+ICsJCXJldHVybiB0cnVlOw0KPiArDQo+ICsJLyogaW50ZXJydXB0
IHN0YXR1cyByZWdpc3RlciAqLw0KPiArCWlmIChyZWcgPT0gTUFYMzEzMzVfSU5UX0VOMV9BMUlF
KQ0KPiArCQlyZXR1cm4gdHJ1ZTsNClByZXN1bWFibHkgdGhpcyBzaG91bGQgYmUgc29tZXRoaW5n
IGVsc2UgYXMgTUFYMzEzMzVfSU5UX0VOMV9BMUlFIGlzIGEgDQpiaXRmaWVsZCBvZmZzZXQgbm90
IGEgcmVnaXN0ZXIuwqAgQmFzZWQgb24gdGhlIG90aGVyIGNoaXBzIEknbSBndWVzc2luZyANCnRo
aXMgc2hvdWxkIGJlIGByZWcgPT0gTUFYMzEzMzVfU1RBVFVTMWAuIEknbGwgdHJ5IHRvIGluY29y
cG9yYXRlIGEgZml4IA0KaW50byBteSB1cGRhdGUgYnV0IHNvbWVvbmUgbWlnaHQgd2FudCB0byBm
aXggaXQgdXAgZm9yIHN0YWJsZS4NCj4gKw0KPiArCS8qIHRlbXBlcmF0dXJlIHJlZ2lzdGVycyAq
Lw0KPiArCWlmIChyZWcgPT0gTUFYMzEzMzVfVEVNUF9EQVRBX01TQiB8fCBNQVgzMTMzNV9URU1Q
X0RBVEFfTFNCKQ0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKw0KPiArCXJldHVybiBmYWxzZTsNCj4g
K30NCj4gKw0K

