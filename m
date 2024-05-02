Return-Path: <linux-kernel+bounces-166015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE198B94D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444F81F225F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E94CA62;
	Thu,  2 May 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="yl/qs0VU"
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4FE1CAAE;
	Thu,  2 May 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632449; cv=none; b=Bkzqdx8OXzavWse7FIVfBFCbwviO9swCaPLulfyUwq42l7RxmcrypRAAQjr1vAsQ82CmR/ayYtaEAJjc3d62x7scW29NxueYz0aqbSHWFe7kXapgQ1mh8dXvj3/BCmR36taDYnNY3Bo3zJNgx6Rx7TfiOFRpytAGaIXwvnIi+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632449; c=relaxed/simple;
	bh=8nrCqHmR8DI15VzIKjBKRM4ja7aQLPI8bwpgUN0NccA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAC3F2SfeF8XCFHzctDmIVuELrkyHC8MTtc39atruyGNAHr48hiCza465tMnAxT74GJMiNnIQWdWSnHaXTt6lKM4WlKiUXmLyQ8PQfYCtAHpvY9pRkGYKMguZSzwwtQ6y2YlnNDKNJQVmXhs31j4+/lQbG6FYYsntu3SeO+a+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=yl/qs0VU; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1714631893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nrCqHmR8DI15VzIKjBKRM4ja7aQLPI8bwpgUN0NccA=;
	b=yl/qs0VUbvzyk5o1aXLXLSenJ+rz9Hxn0mrMmQSXDflrLmM++bulrv+qWq60zzNG8uooKp
	uqHLDYS0L7uOX9BQ==
Message-ID: <81f04913-36c5-4ef6-8089-abef9c458cab@hardfalcon.net>
Date: Thu, 2 May 2024 08:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5.15 00/80] 5.15.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103043.397234724@linuxfoundation.org>
Content-Language: en-US
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

WzIwMjQtMDQtMzAgMTI6MzldIEdyZWcgS3JvYWgtSGFydG1hbjoNCj4gVGhpcyBpcyB0aGUg
c3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA1LjE1LjE1OCByZWxl
YXNlLg0KPiBUaGVyZSBhcmUgODAgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcywgYWxsIHdpbGwg
YmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UNCj4gdG8gdGhpcyBvbmUuICBJZiBhbnlvbmUgaGFz
IGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWluZyBhcHBsaWVkLCBwbGVhc2UNCj4gbGV0IG1l
IGtub3cuDQo+IA0KPiBSZXNwb25zZXMgc2hvdWxkIGJlIG1hZGUgYnkgVGh1LCAwMiBNYXkg
MjAyNCAxMDozMDoyNyArMDAwMC4NCj4gQW55dGhpbmcgcmVjZWl2ZWQgYWZ0ZXIgdGhhdCB0
aW1lIG1pZ2h0IGJlIHRvbyBsYXRlLg0KDQpIaSwgNS4xNS4xNTgtcmMxIGlzIHJ1bm5pbmcg
ZmluZSBvbiBhIE5ldGdlYXIgR1MxMDhUIHYzICh0aGUgU29DIGlzIGEgDQpSZWFsdGVrIFJU
TDgzODBNLCB3aGljaCBoYXMgYSBNSVBTIDRLRWMgY29yZSkuDQoNCk5vdGUgdGhhdCBJIGhh
dmUgKm5vdCogdGVzdGVkIGJ1aWxkaW5nIHRoZSBrZXJuZWwgZG9jdW1lbnRhdGlvbiwgYW5k
IEkgDQpzdXNwZWN0IHRoYXQgYnVpbGRpbmcgdGhlIGRvY3VtZW50YXRpb24gd2l0aCBkb2N1
dGlscyA+PSAwLjIxIHdvdWxkIA0KbGlrZWx5IGZhaWwgd2l0aG91dCB0aGUgcGF0Y2ggZnJv
bQ0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZmFmNWZhNDUtMmE5ZC00NTczLTlk
MmUtMzkzMGJkYzFlZDY1QGdtYWlsLmNvbS8NCg0KVGVzdGVkLWJ5OiBQYXNjYWwgRXJuc3Rl
ciA8Z2l0QGhhcmRmYWxjb24ubmV0Pg0KDQpSZWdhcmRzDQpQYXNjYWwNCg==

