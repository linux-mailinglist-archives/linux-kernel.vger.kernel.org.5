Return-Path: <linux-kernel+bounces-136848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEBF89D8F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10811F21F75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0412C12C531;
	Tue,  9 Apr 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ooLazIGZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212A86651;
	Tue,  9 Apr 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664720; cv=none; b=pIjCFFwxuHt8XFqonv2mnV6TuPXgTFmOo6fmh2y9l4g5adQGdm+2ptERCCzchHGjDBRKXi0vOKFl/aR7xC1nLnkb20PgJs8kin+zWqnuQNBbR0UtYdvf3nUB/qDVRXcys9OQvpJ0quEYNc0O0El5WJzpa4hEowvRBgSwMdBJEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664720; c=relaxed/simple;
	bh=BVrLcFdYPUDEWEn5KDV423hxP0oT8V4yLUiWZ5gAH/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEV8HXpe5jZ6E+w1gPSZ/WVzsEjHmIwWTRoCGuy82gk7gCMmkDxys90niedzSg43wIx4QqGZbzBXsrAP2hvqvmOtYebXxpK8+0LWh6CiTukfHEZf6UOoIO5nw0hi1TOM7uPokkOKV8K7ypxmyDB+K5AOWeRbKUvGqTNSiP/nM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ooLazIGZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712664716;
	bh=BVrLcFdYPUDEWEn5KDV423hxP0oT8V4yLUiWZ5gAH/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ooLazIGZqE3OaFF6d+Ilz7NVeVx8eJIxOh2mbgysLKU5kS1Xy1WZHP+Upx+0xJlc+
	 m6jB+h/LEox8y7O2NEqE2sWa1uZEHjur17z/65/ePxGRvPgjqkqRjTaU9aIFIY/sC/
	 o1XEc0KavHkF+mfQfskvEcsNoUQe0RwCwA1lWOgWNpC8cjvjbJsT6INFZhfJtYI7u6
	 kbU558Fo2sTzdjwQIfMLTsvo0eFUMbpNPW15H6mzzj0Q5yus3XsIPzWGLhoiJuTE33
	 F7SWQd1CxPabfYNAqhuynrP4N6vXO9j/gDePIeJkKcI2oKNv4Je0GTZwjpa93U29xi
	 sLS1RPRloeXuQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C820137820F5;
	Tue,  9 Apr 2024 12:11:55 +0000 (UTC)
Message-ID: <66237505-d84f-483e-b088-b8fd7c34ab9f@collabora.com>
Date: Tue, 9 Apr 2024 14:11:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8974: Use proper compatible for
 APCS syscon
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240408-msm8974-apcs-v1-0-90cb7368836e@z3ntu.xyz>
 <20240408-msm8974-apcs-v1-2-90cb7368836e@z3ntu.xyz>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240408-msm8974-apcs-v1-2-90cb7368836e@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SWwgMDgvMDQvMjQgMjE6MzIsIEx1Y2EgV2Vpc3MgaGEgc2NyaXR0bzoNCj4gVXNlIHRoZSBh
cGNzLWtwc3MtZ2xvYmFsIGNvbXBhdGlibGUgZm9yIHRoZSBBUENTIGdsb2JhbCBtYWlsYm94
IGJsb2NrDQo+IGZvdW5kIG9uIHRoaXMgU29DLg0KPiANCj4gVGhpcyBhbHNvIHJlc29sdmVz
IGEgZHQtYmluZGluZyBjaGVja2VyIHdhcm5pbmc6DQo+IA0KPiAgICBhcmNoL2FybS9ib290
L2R0cy9xY29tL3Fjb20tbXNtODk3NHByby1mYWlycGhvbmUtZnAyLmR0Yjogc3lzY29uQGY5
MDExMDAwOiBjb21wYXRpYmxlOiAnYW55T2YnIGNvbmRpdGlvbmFsIGZhaWxlZCwgb25lIG11
c3QgYmUgZml4ZWQ6DQo+ICAgICAgICAgICAgWydzeXNjb24nXSBpcyB0b28gc2hvcnQNCj4g
ICAgICAgICAgICAnc3lzY29uJyBpcyBub3Qgb25lIG9mIFsnYWxsd2lubmVyLHN1bjhpLWE4
M3Qtc3lzdGVtLWNvbnRyb2xsZXInLCAnYWxsd2lubmVyLHN1bjhpLWgzLXN5c3RlbS1jb250
cm9sbGVyJywgJ2FsbHdpbm5lcixzdW44aS12M3Mtc3lzdGVtLWNvbnRyb2xsZXInLCAnYWxs
d2lubmVyLHN1bjUwaS1hNjQtc3lzdGVtLWNvbnRyb2xsZXInLCAnYW1kLHBlbnNhbmRvLWVs
YmEtc3lzY29uJywgJ2JyY20sY3J1LWNsa3NldCcsICdmcmVlY29tLGZzZy1jczItc3lzdGVt
LWNvbnRyb2xsZXInLCAnZnNsLGlteDkzLWFvbm1peC1ucy1zeXNjZmcnLCAnZnNsLGlteDkz
LXdha2V1cG1peC1zeXNjZmcnLCAnaGlzaWxpY29uLGRzYS1zdWJjdHJsJywgJ2hpc2lsaWNv
bixoaTYyMjAtc3JhbWN0cmwnLCAnaGlzaWxpY29uLHBjaWUtc2FzLXN1YmN0cmwnLCAnaGlz
aWxpY29uLHBlcmktc3ViY3RybCcsICdocGUsZ3hwLXN5c3JlZycsICdpbnRlbCxsZ20tc3lz
Y29uJywgJ2xvb25nc29uLGxzMWItc3lzY29uJywgJ2xvb25nc29uLGxzMWMtc3lzY29uJywg
J21hcnZlbGwsYXJtYWRhLTM3MDAtdXNiMi1ob3N0LW1pc2MnLCAnbWVkaWF0ZWssbXQ4MTM1
LXBjdGwtYS1zeXNjZmcnLCAnbWVkaWF0ZWssbXQ4MTM1LXBjdGwtYi1zeXNjZmcnLCAnbWVk
aWF0ZWssbXQ4MzY1LXN5c2NmZycsICdtaWNyb2NoaXAsbGFuOTY2eC1jcHUtc3lzY29uJywg
J21pY3JvY2hpcCxzcGFyeDUtY3B1LXN5c2NvbicsICdtc3Rhcixtc2MzMTMtcG1zbGVlcCcs
ICdudXZvdG9uLG1hMzVkMS1zeXMnLCAnbnV2b3Rvbix3cGNtNDUwLXNobScsICdyb2NrY2hp
cCxweDMwLXFvcycsICdyb2NrY2hpcCxyazMwMzYtcW9zJywgJ3JvY2tjaGlwLHJrMzA2Ni1x
b3MnLCAncm9ja2NoaXAscmszMTI4LXFvcycsICdyb2NrY2hpcCxyazMyMjgtcW9zJywgJ3Jv
Y2tjaGlwLHJrMzI4OC1xb3MnLCAncm9ja2NoaXAscmszMzY4LXFvcycsICdyb2NrY2hpcCxy
azMzOTktcW9zJywgJ3JvY2tjaGlwLHJrMzU2DQo+ICAgOC1xb3MnLCAncm9ja2NoaXAscmsz
NTg4LXFvcycsICdyb2NrY2hpcCxydjExMjYtcW9zJywgJ3N0YXJmaXZlLGpoNzEwMC1zeXNt
YWluJywgJ3RpLGFtNjItdXNiLXBoeS1jdHJsJywgJ3RpLGFtNjU0LWRzcy1vbGRpLWlvLWN0
cmwnLCAndGksYW02NTQtc2VyZGVzLWN0cmwnLCAndGksajc4NHM0LXBjaWUtY3RybCddDQo+
ICAgICAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2No
ZW1hcy9tZmQvc3lzY29uLnlhbWwjDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWNhIFdlaXNz
IDxsdWNhQHozbnR1Lnh5ej4NCg0KUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQoNCg0K


