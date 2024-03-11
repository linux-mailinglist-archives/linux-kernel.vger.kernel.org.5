Return-Path: <linux-kernel+bounces-99275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE78785C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3FD1C21ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC6448CF2;
	Mon, 11 Mar 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="uC0i47A1"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2638F87;
	Mon, 11 Mar 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176007; cv=none; b=QGPRZsFYWv3NvZ24ziMG6UMG3YYGDrojTb+MijWjiDmtNGS5u7XomtbRVuKtYzPOp72FNE6+Wu0BUqhCYzMaSF/7FPu6HnoLsGZ4zwcXgWQxccjRPSmA59u9SOWln6Qnhojyrod6k3cZWOe5joSEEYF86kdnf1Lxjro6jHv+TeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176007; c=relaxed/simple;
	bh=o47Vto4njf9GW8bxbC7snCn0lPZuwOrA7a5y8GBvXjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JueDl03soOgRR3GELqYG5ARCS9hbDaDtzG3Lu97jMN9dePvOEacYiZP6txog0BqarZaXo8yr1dZM/HRJSsjsrDTBOA5a4qU4k8NvXll6bUNWu+QNyzu1wzbyrsaTVWXytHSqbaQoUE7I3Nr1cY590agK9guQztspgIAvBHPUNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=uC0i47A1; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710175998; bh=o47Vto4njf9GW8bxbC7snCn0lPZuwOrA7a5y8GBvXjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uC0i47A14Bo9xf+y4xVJ9VBDBN8K2ICsBVPY1gIin5m90D22USZiZKYioPuToQiQS
	 SnNxIByKufL8I0Jxn2QYp3zKttBPCigO/SnFFP1Hh+mj7Cu6XbP6xp8Delq//7u/t/
	 B0rpcaqOQriErtDfFli0yL8iD26h/R00y2DQ+Tbo=
From: Luca Weiss <luca@z3ntu.xyz>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
 phone-devel@vger.kernel.org, Adam Honse <calcprogrammer1@gmail.com>
Subject: Re: [PATCH 0/2] Add Samsung Galaxy Note 3 support
Date: Mon, 11 Mar 2024 17:53:17 +0100
Message-ID: <2720455.mvXUDI8C0e@g550jk>
In-Reply-To: <171016679093.1126634.17115825771533066372.robh@kernel.org>
References:
 <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
 <171016679093.1126634.17115825771533066372.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"

T24gTW9udGFnLCAxMS4gTcOkcnogMjAyNCAxNToyMzozMCBDRVQgUm9iIEhlcnJpbmcgd3JvdGU6
Cj4gCj4gT24gU3VuLCAxMCBNYXIgMjAyNCAxNToxMzozNSArMDEwMCwgTHVjYSBXZWlzcyB3cm90
ZToKPiA+IEFkZCB0aGUgZHRzIGZvciAiaGx0ZSIgd2hpY2ggaXMgYSBwaGFibGV0IGZyb20gMjAx
My4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTHVjYSBXZWlzcyA8bHVjYUB6M250dS54eXo+Cj4g
PiAtLS0KPiA+IEFkYW0gSG9uc2UgKDEpOgo+ID4gICAgICAgQVJNOiBkdHM6IHFjb206IG1zbTg5
NzQ6IEFkZCBTYW1zdW5nIEdhbGF4eSBOb3RlIDMKPiA+IAo+ID4gTHVjYSBXZWlzcyAoMSk6Cj4g
PiAgICAgICBkdC1iaW5kaW5nczogYXJtOiBxY29tOiBBZGQgU2Ftc3VuZyBHYWxheHkgTm90ZSAz
Cj4gPiAKPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3Fjb20ueWFt
bCAgICB8ICAgMSArCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKwo+ID4gIC4uLi9ib290L2R0cy9xY29tL3Fjb20tbXNtODk3NC1z
YW1zdW5nLWhsdGUuZHRzICAgIHwgNDAzICsrKysrKysrKysrKysrKysrKysrKwo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgNDA1IGluc2VydGlvbnMoKykKPiA+IC0tLQo+ID4gYmFzZS1jb21taXQ6IDkw
ZDM1ZGE2NThkYThjZmYwZDRlY2JiNTExM2Y1ZmFjOWQwMGViNzIKPiA+IGNoYW5nZS1pZDogMjAy
NDAzMTAtc2Ftc3VuZy1obHRlLTc4ZDFhMjg3YjBhOAo+ID4gCj4gPiBCZXN0IHJlZ2FyZHMsCj4g
PiAtLQo+ID4gTHVjYSBXZWlzcyA8bHVjYUB6M250dS54eXo+Cj4gPiAKPiA+IAo+ID4gCj4gCj4g
Cj4gTXkgYm90IGZvdW5kIG5ldyBEVEIgd2FybmluZ3Mgb24gdGhlIC5kdHMgZmlsZXMgYWRkZWQg
b3IgY2hhbmdlZCBpbiB0aGlzCj4gc2VyaWVzLgo+IAo+IFNvbWUgd2FybmluZ3MgbWF5IGJlIGZy
b20gYW4gZXhpc3RpbmcgU29DIC5kdHNpLiBPciBwZXJoYXBzIHRoZSB3YXJuaW5ncwo+IGFyZSBm
aXhlZCBieSBhbm90aGVyIHNlcmllcy4gVWx0aW1hdGVseSwgaXQgaXMgdXAgdG8gdGhlIHBsYXRm
b3JtCj4gbWFpbnRhaW5lciB3aGV0aGVyIHRoZXNlIHdhcm5pbmdzIGFyZSBhY2NlcHRhYmxlIG9y
IG5vdC4gTm8gbmVlZCB0byByZXBseQo+IHVubGVzcyB0aGUgcGxhdGZvcm0gbWFpbnRhaW5lciBo
YXMgY29tbWVudHMuCj4gCj4gSWYgeW91IGFscmVhZHkgcmFuIERUIGNoZWNrcyBhbmQgZGlkbid0
IHNlZSB0aGVzZSBlcnJvcihzKSwgdGhlbgo+IG1ha2Ugc3VyZSBkdC1zY2hlbWEgaXMgdXAgdG8g
ZGF0ZToKPiAKPiAgIHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUKPiAKPiAKPiBOZXcg
d2FybmluZ3MgcnVubmluZyAnbWFrZSBDSEVDS19EVEJTPXkgcWNvbS9xY29tLW1zbTg5NzQtc2Ft
c3VuZy1obHRlLmR0YicgZm9yIDIwMjQwMzEwLXNhbXN1bmctaGx0ZS12MS0wLWU5YjU1YmY5OGE0
OEB6M250dS54eXo6Cj4gCj4gYXJjaC9hcm0vYm9vdC9kdHMvcWNvbS9xY29tLW1zbTg5NzQtc2Ft
c3VuZy1obHRlLmR0YjogLzogbWVtb3J5OiBGYWxzZSBzY2hlbWEgZG9lcyBub3QgYWxsb3cgeydk
ZXZpY2VfdHlwZSc6IFsnbWVtb3J5J10sICdyZWcnOiBbWzAsIDBdXX0KPiAJZnJvbSBzY2hlbWEg
JGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9yb290LW5vZGUueWFtbCMKPiBhcmNo
L2FybS9ib290L2R0cy9xY29tL3Fjb20tbXNtODk3NC1zYW1zdW5nLWhsdGUuZHRiOiBsMi1jYWNo
ZTogVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdxY29tLHNhdycgd2Fz
IHVuZXhwZWN0ZWQpCj4gCWZyb20gc2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvY2FjaGUueWFtbCMKPiBhcmNoL2FybS9ib290L2R0cy9xY29tL3Fjb20tbXNtODk3NC1z
YW1zdW5nLWhsdGUuZHRiOiBpZGxlLXN0YXRlczogJ3NwYycgZG9lcyBub3QgbWF0Y2ggYW55IG9m
IHRoZSByZWdleGVzOiAnXihjcHV8Y2x1c3RlciktJywgJ3BpbmN0cmwtWzAtOV0rJwo+IAlmcm9t
IHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2NwdS9pZGxlLXN0YXRl
cy55YW1sIwo+IGFyY2gvYXJtL2Jvb3QvZHRzL3Fjb20vcWNvbS1tc204OTc0LXNhbXN1bmctaGx0
ZS5kdGI6IHN5c2NvbkBmOTAxMTAwMDogY29tcGF0aWJsZTogJ2FueU9mJyBjb25kaXRpb25hbCBm
YWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVkOgo+IAlbJ3N5c2NvbiddIGlzIHRvbyBzaG9ydAo+IAkn
c3lzY29uJyBpcyBub3Qgb25lIG9mIFsnYWxsd2lubmVyLHN1bjhpLWE4M3Qtc3lzdGVtLWNvbnRy
b2xsZXInLCAnYWxsd2lubmVyLHN1bjhpLWgzLXN5c3RlbS1jb250cm9sbGVyJywgJ2FsbHdpbm5l
cixzdW44aS12M3Mtc3lzdGVtLWNvbnRyb2xsZXInLCAnYWxsd2lubmVyLHN1bjUwaS1hNjQtc3lz
dGVtLWNvbnRyb2xsZXInLCAnYW1kLHBlbnNhbmRvLWVsYmEtc3lzY29uJywgJ2JyY20sY3J1LWNs
a3NldCcsICdmcmVlY29tLGZzZy1jczItc3lzdGVtLWNvbnRyb2xsZXInLCAnZnNsLGlteDkzLWFv
bm1peC1ucy1zeXNjZmcnLCAnZnNsLGlteDkzLXdha2V1cG1peC1zeXNjZmcnLCAnaGlzaWxpY29u
LGRzYS1zdWJjdHJsJywgJ2hpc2lsaWNvbixoaTYyMjAtc3JhbWN0cmwnLCAnaGlzaWxpY29uLHBj
aWUtc2FzLXN1YmN0cmwnLCAnaGlzaWxpY29uLHBlcmktc3ViY3RybCcsICdocGUsZ3hwLXN5c3Jl
ZycsICdpbnRlbCxsZ20tc3lzY29uJywgJ2xvb25nc29uLGxzMWItc3lzY29uJywgJ2xvb25nc29u
LGxzMWMtc3lzY29uJywgJ21hcnZlbGwsYXJtYWRhLTM3MDAtdXNiMi1ob3N0LW1pc2MnLCAnbWVk
aWF0ZWssbXQ4MTM1LXBjdGwtYS1zeXNjZmcnLCAnbWVkaWF0ZWssbXQ4MTM1LXBjdGwtYi1zeXNj
ZmcnLCAnbWVkaWF0ZWssbXQ4MzY1LXN5c2NmZycsICdtaWNyb2NoaXAsbGFuOTY2eC1jcHUtc3lz
Y29uJywgJ21pY3JvY2hpcCxzcGFyeDUtY3B1LXN5c2NvbicsICdtc3Rhcixtc2MzMTMtcG1zbGVl
cCcsICdudXZvdG9uLG1hMzVkMS1zeXMnLCAnbnV2b3Rvbix3cGNtNDUwLXNobScsICdyb2NrY2hp
cCxweDMwLXFvcycsICdyb2NrY2hpcCxyazMwMzYtcW9zJywgJ3JvY2tjaGlwLHJrMzA2Ni1xb3Mn
LCAncm9ja2NoaXAscmszMTI4LXFvcycsICdyb2NrY2hpcCxyazMyMjgtcW9zJywgJ3JvY2tjaGlw
LHJrMzI4OC1xb3MnLCAncm9ja2NoaXAscmszMzY4LXFvcycsICdyb2NrY2hpcCxyazMzOTktcW9z
JywgJ3JvY2tjaGlwLHJrMzU2OC1xb3MnLCAnCj4gIHJvY2tjaGlwLHJrMzU4OC1xb3MnLCAncm9j
a2NoaXAscnYxMTI2LXFvcycsICdzdGFyZml2ZSxqaDcxMDAtc3lzbWFpbicsICd0aSxhbTYyLXVz
Yi1waHktY3RybCcsICd0aSxhbTY1NC1kc3Mtb2xkaS1pby1jdHJsJywgJ3RpLGFtNjU0LXNlcmRl
cy1jdHJsJywgJ3RpLGo3ODRzNC1wY2llLWN0cmwnXQo+IAlmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21mZC9zeXNjb24ueWFtbCMKClVuZm9ydHVuYXRlbHkg
YWxsIGV4aXN0aW5nIHdhcm5pbmdzIGZyb20gdGhlIC5kdHNpLgoKUmVnYXJkcwpMdWNh





