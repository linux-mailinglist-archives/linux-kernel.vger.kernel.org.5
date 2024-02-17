Return-Path: <linux-kernel+bounces-69991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDA859169
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80523B217B7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153E7E0F0;
	Sat, 17 Feb 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=orlives.de header.i=@orlives.de header.b="Zi9v1Lrj"
Received: from mail.orlives.de (mail.orlives.de [148.251.55.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE647D41F;
	Sat, 17 Feb 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.55.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708192704; cv=none; b=SbtcFnwrdyCsvNUa/ke0vz2/rLss/Xm6bM5UDm/KUjbNzeGuTpKZzlQ54N7dRBvwqkpaylNB3TAQsh5WmvqpC3npz1rXfFc9SPV0LpBmVY2SIhudWitP0/NeOzPnPGLTIddcVC6clylDCYPYTgpic656FRK4MhknGITooLTLZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708192704; c=relaxed/simple;
	bh=vOcL7fvdPQymRt5haVMB/0ti/PnZsWOVFGIxq1G7unw=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDnLZ6my83Ih1kt8Qy0Eiq7xbSBpet22yjCGYC4md7Y8VHFc6zKAvgyL6xJ0QJl+A/ZUHmvpSorXuhiPaePQINm7WWFfP8nfLJa4xCdGHVIj7lpHeBIw2zD/MMUaCBqdxBfeHyBmKxCJHxiL0tzlYklTGgKMo6jowCYJcMgKhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orlives.de; spf=pass smtp.mailfrom=orlives.de; dkim=pass (4096-bit key) header.d=orlives.de header.i=@orlives.de header.b=Zi9v1Lrj; arc=none smtp.client-ip=148.251.55.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orlives.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orlives.de
Received: from mail.orlives.de (localhost [127.0.0.1])
	by mail.orlives.de (Postfix) with ESMTPSA id DD361A008B;
	Sat, 17 Feb 2024 18:58:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orlives.de; s=dkim1;
	t=1708192698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vOcL7fvdPQymRt5haVMB/0ti/PnZsWOVFGIxq1G7unw=;
	b=Zi9v1LrjuCu0I5ldzpaaj5KG+j25bvhbhZ0kqMQ7V6CZIN9JYhXH/F/veM2RfBNSLXWS67
	RLixy0644yWwKQZeeWATYwLai5HXII8+U59hXr4yoj58j8JSYjyVAYHDszzKic0rnv5dE0
	udk2PGLq/8AzeF5NuqJVQVfjRl/HmcOjmEaWy8AOPILt0IHxTOM5ars29JdMzgvyAh6yTB
	T4o1K6b+vn6N7WtglXivmRScxW65/crOPGLruMXvvTuq4CaqIzAOhHzUq1wEWGVP9YHQuw
	GzZ7tlbS3OhqDYvS5s7JZza6/aDJ4erOWVZHa9SVDZgPJWmfblA/2SfSxFjLmLMoFLCrur
	RjAauR5WW2kMtna5CojrmEa7jsv/LmIJBo5guPIJQtDqdjgZVdJZpJpGfs1j8cCLmkZ31O
	nKCK9u4iK8sk7PW1Hy4XKiPDNaw9DkcwsOqmrtR3BU7Fo7uYTjNDMm5qTc0TJNj1GQN2W2
	9uX05eHStzzDObyVTlTW1qP/sqlQH+qraJvsAs9q4R0RFD4wawBTHl2/XZUNp4DeE/oDEt
	tDGkjwPtQNXbziAn9OfOqT+jIsC+MmDur0e6+WmoN7qr1ikiudlWpWUdhuK4p8aVMbxy/2
	E0N+bakK6FN/kAxBLuVfHivPgJhIL8H1JF6u+utwJiSgQ2ZakJDKs=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=t.schmittlauch@orlives.de smtp.mailfrom=t.schmittlauch@orlives.de
Message-ID: <da6fbbdc-5f6b-4bfe-816d-03477bf489a8@localhost>
Date: Sat, 17 Feb 2024 18:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a suspend hang on Framework 13
To: Mario Limonciello <mario.limonciello@amd.com>, Shyam-sundar.S-k@amd.com,
 hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240217005216.113408-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Trolli Schmittlauch <t.schmittlauch@orlives.de>
Autocrypt: addr=t.schmittlauch@orlives.de; keydata=
 xsBNBF4y2DoBCADCzwZ+V1tJOR2JK20uAVPkAOC5PdIe/UYCVZsYIbh8aIz0HsiqWeTCj3J8
 nZEVKKm6fQRtyMILZeWNHQ98ck+1tmr4a6UQ4UDl+Xb1VuhU4frZI/d75olkn2JNwYcJJcdn
 MJ4WUZ8BWhmia+8ng+7nJ1yOw1ad0uS8dL+w+m+eimFr7HjIXUV/Y5I8NGhkROFDu72byMn1
 OTaq4HFfgilYsDGu8AWUtn+ZBXmCDIYbvXANjDcyuGTTnS/vgyFx66rHOgZKqTafuSAC1k61
 dAYvLlo06yb4S4VNwkW17ho9L6sgqfY5rFd+zQYnXdau7AK7TLAFywHgafHU20Ffv6PbABEB
 AAHNGzx0LnNjaG1pdHRsYXVjaEBvcmxpdmVzLmRlPsLAiQQQAQgAMwIZAQUCXjLYQAIbAwQL
 CQgHBhUICQoLAgMWAgEWIQSJFhEikPObK3+nglaeUEWy+uvFawAKCRCeUEWy+uvFa6UPCACt
 EeMFD8HIbP6vIfs0dQdYw7SyG/Ws/ZEhi61+HfBeltem2LMbcY3B1UNGWWt1px1oFq0sCd12
 j8JhjTPyFoQv+vRDEygMk/OrXfnn32dl9Ttubgz68ktxjv6xQ2q+TGHStUCe9Q1opGqjWqV0
 bqFV9nbpX5DX3urG4eDqjUrvUMasp3/RBBC6dSzRcutbmnFEUhbnQcG2JhxkUqJxErJO7Rs7
 dw5wR+43zipZznrtP/W8nCmL7E8VYn3KWFSb4jSmMyYneqBrhSZMB/BfiOMrWnnMpPChRLyR
 GLqZoyhWDPZyAbKyjlVQVS3d9BtLn5PzNaYRAl9Gad8h+o/WWHGXzsBNBF4y2DoBCACmbQWs
 /CCONpIwsHxKt4fEfbW1XhQFoKPmGF2Xonas6kN3Oh8XXFekkXfnRQJX+fOuv7DbaUsmkPzd
 TB2YtfidZJ6xIYPzSgSMsA945dEOY5yYfeNCH1pQYcq1xfM7bHGSwaNervx0wnK/g7yBgp6E
 1stOwqoR9M3KgmQJPuaSISSfUH5NKcx38S6w+56I3//f1jyCRG5vkQzHsdioBWkAOfagQmcv
 6fMhDYCoxlTooxlj1/5mSkspCS7fDkVcZn48t+sPfQAywpUDrWBZhp1vrDHfl+wUvCSXPYEz
 9dkT9NmLz24H20tLV+btVgMsPXSlnM34lNjABg2x7isCoCZ9ABEBAAHCwHYEGAEIACAFAl4y
 2EACGwwWIQSJFhEikPObK3+nglaeUEWy+uvFawAKCRCeUEWy+uvFayO5CACDYH46Tay5BSwn
 FK3EwAYSpXIFzhQet7os7InGRS8/2yuqzsunRDbMy11rTGmXXA1LuTizqsgebQbALpkuHEpi
 gX9b20RfsfuZYbdbtLzzVDuOVuGP3+CSJrB1Z+nGeF1+L4m5n7VDPX0MyWKwhlWY9hVmNQ2+
 lMt+fb6+330M9cXCz6H2/k7b2BTEM9xZPytt2ICT8I9rX5+8tuHDrstr13P40QOR0Exh5EHw
 LA00FYsr0e+ijzxRP9EC3AA9Gt/518IRS7FGvszu4qWWRT33P2cABoVUPpsybrhvuApgpf5y
 DLO17h0Vxwoq2qqCO/RqIw+o8Lj89xOl4VkPpXe4
In-Reply-To: <20240217005216.113408-1-mario.limonciello@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nrK90jMcqGrp1cq5oWYcW3x7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nrK90jMcqGrp1cq5oWYcW3x7
Content-Type: multipart/mixed; boundary="------------5beBBwWG9elzcY3CUanl8u0g";
 protected-headers="v1"
From: Trolli Schmittlauch <t.schmittlauch@orlives.de>
To: Mario Limonciello <mario.limonciello@amd.com>, Shyam-sundar.S-k@amd.com,
 hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Message-ID: <da6fbbdc-5f6b-4bfe-816d-03477bf489a8@localhost>
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a suspend hang on Framework 13
References: <20240217005216.113408-1-mario.limonciello@amd.com>
In-Reply-To: <20240217005216.113408-1-mario.limonciello@amd.com>

--------------5beBBwWG9elzcY3CUanl8u0g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QXMgdGhlIHJlcG9ydGVyIG9mIHRoYXQgaXNzdWUsIEkgY29uZmlybSB0aGF0IHRoaXMgZml4
ZXMgc3VzcGVuZCBhbmQgcmVzdW1lIGZvciBtZSBhcyB3ZWxsLiBJJ3ZlIGFwcGxpZWQgdGhl
IHBhdGNoIG9uIHRvcCBvZiA2LjgtcmM0Lg0KVGhhbmtzIGZvciBnZXR0aW5nIHRvIHRoZSBi
b3R0b20gb2YgaXQgc28gcXVpY2tseS4NCg0KT24gMTcuMDIuMjQgMDE6NTIsIE1hcmlvIExp
bW9uY2llbGxvIHdyb3RlOg0KPiBUaGUgYnVmZmVyIGlzIGNsZWFyZWQgaW4gdGhlIHN1c3Bl
bmQgaGFuZGxlciBidXQgdXNlZCBpbg0KPiB0aGUgZGVsYXllZCB3b3JrIGZvciBhbWRfcG1m
X2dldF9tZXRyaWNzKCkuDQo+IA0KPiBTdG9wIGNsZWFyaW5nIGl0IHRvIGZpeCB0aGUgaGFu
Zy4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBUcm9sbGkgU2NobWl0dGxhdWNoIDx0LnNjaG1pdHRs
YXVjaEBvcmxpdmVzLmRlPg0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Jl
Z3Jlc3Npb25zL2VkMjIyNmZmLTI1N2ItNGNmZC1hZmQ2LWJmM2JlOTc4NTQ3NEBsb2NhbGhv
c3QvDQo+IENsb3NlczogaHR0cHM6Ly9jb21tdW5pdHkuZnJhbWUud29yay90L2tlcm5lbC02
LTgtcmMtc3lzdGVtLWZyZWV6ZXMtYWZ0ZXItcmVzdW1pbmctZnJvbS1zdXNwZW5kLXJlcHJv
ZHVjZXJzLXdhbnRlZC80NTM4MQ0KPiBGaXhlczogMmIzYTdmMDZjYWFmICgicGxhdGZvcm0v
eDg2L2FtZC9wbWY6IENoYW5nZSByZXR1cm4gdHlwZSBvZiBhbWRfcG1mX3NldF9kcmFtX2Fk
ZHIoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1v
bmNpZWxsb0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hbWQv
cG1mL2NvcmUuYyB8IDIgLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hbWQvcG1mL2NvcmUu
YyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FtZC9wbWYvY29yZS5jDQo+IGluZGV4IDg1MzE1
ODkzMzUxMC4uNGY3MzRlMDQ5ZjRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9hbWQvcG1mL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hbWQv
cG1mL2NvcmUuYw0KPiBAQCAtMjk5LDggKzI5OSw2IEBAIHN0YXRpYyBpbnQgYW1kX3BtZl9z
dXNwZW5kX2hhbmRsZXIoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIAlpZiAocGRldi0+c21h
cnRfcGNfZW5hYmxlZCkNCj4gICAJCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmcGRldi0+
cGJfd29yayk7DQo+ICAgDQo+IC0Ja2ZyZWUocGRldi0+YnVmKTsNCj4gLQ0KPiAgIAlyZXR1
cm4gMDsNCj4gICB9DQo+ICAgDQo=

--------------5beBBwWG9elzcY3CUanl8u0g--

--------------nrK90jMcqGrp1cq5oWYcW3x7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEiRYRIpDzmyt/p4JWnlBFsvrrxWsFAmXQ87gFAwAAAAAACgkQnlBFsvrrxWs8
twf+LJKLE6LplCdx0AkuwmvBT5w8HGpp6uHhV4z0V58pk2gBmd9COeotYyRYSy1JeLlH2wzklXVj
UTGqRAGtKl+LBwdPFV7pDdXad7rNAPWIpLiVkbM6uP+PyyzDU7OpuL9Od/fI37UFrphJSV+g16IW
0N05PumqlRBydD6GoKzHkvujA6YXqhkE4ZH/cVeqe0dPUQzZAm9mnJLYzq08UQ54p9yKG66HfXVv
sXKXypZLF4wFd1bnXShvSGuGClRqyTL1EGDn5axrctkPqsiB77Xr90amgX9x2Rtatb60MM3IKjkn
fAovSO955msFgIpOQQPUifYLc9L9XceF4u8J4XnJjQ==
=NO6F
-----END PGP SIGNATURE-----

--------------nrK90jMcqGrp1cq5oWYcW3x7--

