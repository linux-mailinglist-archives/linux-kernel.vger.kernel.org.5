Return-Path: <linux-kernel+bounces-105747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0387E3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF8E1F21593
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8922087;
	Mon, 18 Mar 2024 06:40:54 +0000 (UTC)
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FC1CA89;
	Mon, 18 Mar 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744053; cv=none; b=cOcsSUDHTOO0W3OCfILPGXqXlzFhzGbaKsY2xZMOOsxh24gJDZe/bpk/6uR3vUVyAaVmuIrJBBaRSUlSh+8bzedw2I6knmg3efywNwzqI6+vc8a5wgJDnMAuw/2xjSVkaa8jrKc9igJj+rYEi43kxSbnpmOMhrGMJqa+ZErl3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744053; c=relaxed/simple;
	bh=lET+dV2s3vXLx1JgKudTV/IW94Mh55GR7FFuMfyGQe4=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=Au2GXJXT/NzMxluZFIQC71Yw/9MiuZqBkpdfZko5VpQEYOgyIbsBmLho412jB037umkHbRdx/fYWVfo+EdDVEoqqnJHJsj8TrpWeRAKj0g3fAeJgOZpM62JgtCcOFKOT7dwXzYu+kTCZY+d4pSbfh9doYZTgd0U0dUCzq+7x4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ubisectech.com; spf=pass smtp.mailfrom=ubisectech.com; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ubisectech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubisectech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0738943|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00229654-6.04429e-05-0.997643;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=bugreport@ubisectech.com;NM=1;PH=DW;RN=3;RT=3;SR=0;TI=W4_0.2.3_v5_21475FC9_1710743712799_o7001c80k;
Received: from WS-web (bugreport@ubisectech.com[W4_0.2.3_v5_21475FC9_1710743712799_o7001c80k]) at Mon, 18 Mar 2024 14:35:25 +0800
Date: Mon, 18 Mar 2024 14:35:25 +0800
From: "Ubisectech Sirius" <bugreport@ubisectech.com>
To: "Jens Axboe" <axboe@kernel.dk>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>
Reply-To: "Ubisectech Sirius" <bugreport@ubisectech.com>
Message-ID: <922a9ee9-9da6-4219-9e96-fe7d7198c0b6.bugreport@ubisectech.com>
Subject: =?UTF-8?B?5Zue5aSN77yaS0FTQU46IG51bGwtcHRyLWRlcmVmIFdyaXRlIGluIHRjdHhfdGFza193b3Jr?=
  =?UTF-8?B?X3J1bg==?=
X-Mailer: [Alimail-Mailagent revision 13][W4_0.2.3][v5][Chrome]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4fb30f6c-cd4c-4fcc-97ad-7132a503f7f7.bugreport@ubisectech.com>,<30d89cd2-7748-4285-a1c5-e1724bf5ec31@kernel.dk>
x-aliyun-mail-creator: W4_0.2.3_v5_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEyMi4wLjAuMCBTYWZhcmkvNTM3LjM2vN
In-Reply-To: <30d89cd2-7748-4285-a1c5-e1724bf5ec31@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

PiBJIHRoaW5rIHlvdSBzbmlwcGVkIHRoZSBmYXVsdCBpbmplY3Rpb24gdGhhdCBjYW1lIGJlZm9y
ZSB0aGlzLiBJdCBsb29rcwo+IGxpa2UgYW4gYWxsb2NhdGlvbiBmYWlsdXJlLCBzbyB3ZSBkb24n
dCBnZXQgdHNrLT5pb191cmluZyBzZXR1cCBmb3IgdGhlCj4gU1FQT0xMIHRocmVhZC4gTm90IGEg
Z3JlYXQgd2F5IHRvIGhhbmRsZSB0aGlzLCBidXQgY2FuIHlvdSB0cnkgdGhlCj4gYmVsb3c/IFdv
dWxkIGJlIG5pY2VyIGlmIHdlIGNvdWxkIGp1c3QgcHJ1bmUgdGhlIHRhc2sgcmF0aGVyIHRoYW4g
d2FrZQo+IGl0IGFuZCBoYXZlIGl0IGVycm9yLgoKSGkuCiAgVGhlIGlzc3VlIGRvZXMgbm90IGFw
cGVhciBhZ2FpbiB3aGVuIEkgYXBwbHkgdGhlIHBhdGNoIHRvIHRoZSBMaW51eCBrZXJuZWwuCgoK
T24gMy8xNy8yNCA2OjU5IFBNLCBVYmlzZWN0ZWNoIFNpcml1cyB3cm90ZToKPiBIZWxsby4KPiBX
ZSBhcmUgVWJpc2VjdGVjaCBTaXJpdXMgVGVhbSwgdGhlIHZ1bG5lcmFiaWxpdHkgbGFiIG9mIENo
aW5hIFZhbGlhbnRTZWMuIFJlY2VudGx5LCBvdXIgdGVhbSBoYXMgZGlzY292ZXJlZCBhIGlzc3Vl
IGluIExpbnV4IGtlcm5lbCA2LjguMC1nZTVlMDM4YjdhZTlkLiBBdHRhY2hlZCB0byB0aGUgZW1h
aWwgd2VyZSBhIFBPQyBmaWxlIG9mIHRoZSBpc3N1ZS4KPiAKPiBTdGFjayBkdW1wOgo+IAo+ID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQo+IEJVRzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIGluc3RydW1lbnRfYXRvbWlj
X3JlYWRfd3JpdGUgaW5jbHVkZS9saW51eC9pbnN0cnVtZW50ZWQuaDo5NiBbaW5saW5lXQo+IEJV
RzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIGxsaXN0X2RlbF9hbGwgaW5jbHVkZS9saW51eC9s
bGlzdC5oOjI2NiBbaW5saW5lXQo+IEJVRzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIHRjdHhf
dGFza193b3JrX3J1bisweDdkLzB4MzMwIGlvX3VyaW5nL2lvX3VyaW5nLmM6MTI2Nwo+IFdyaXRl
IG9mIHNpemUgOCBhdCBhZGRyIDAwMDAwMDAwMDAwMDAxYzAgYnkgdGFzayBpb3Utc3FwLTIxNTYw
My8yMTU2MDQKPiAKPiBDUFU6IDAgUElEOiAyMTU2MDQgQ29tbTogaW91LXNxcC0yMTU2MDMgTm90
IHRhaW50ZWQgNi44LjAtZ2U1ZTAzOGI3YWU5ZCAjNDAKPiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0
YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE1LjAtMSAwNC8wMS8yMDE0
Cj4gQ2FsbCBUcmFjZToKPiAgPFRBU0s+Cj4gIF9fZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5j
Ojg4IFtpbmxpbmVdCj4gIGR1bXBfc3RhY2tfbHZsKzB4MTE2LzB4MWIwIGxpYi9kdW1wX3N0YWNr
LmM6MTE0Cj4gIGthc2FuX3JlcG9ydCsweGJkLzB4ZjAgbW0va2FzYW4vcmVwb3J0LmM6NjAxCj4g
IGNoZWNrX3JlZ2lvbl9pbmxpbmUgbW0va2FzYW4vZ2VuZXJpYy5jOjE4MyBbaW5saW5lXQo+ICBr
YXNhbl9jaGVja19yYW5nZSsweGY0LzB4MWEwIG1tL2thc2FuL2dlbmVyaWMuYzoxODkKPiAgaW5z
dHJ1bWVudF9hdG9taWNfcmVhZF93cml0ZSBpbmNsdWRlL2xpbnV4L2luc3RydW1lbnRlZC5oOjk2
IFtpbmxpbmVdCj4gIGxsaXN0X2RlbF9hbGwgaW5jbHVkZS9saW51eC9sbGlzdC5oOjI2NiBbaW5s
aW5lXQo+ICB0Y3R4X3Rhc2tfd29ya19ydW4rMHg3ZC8weDMzMCBpb191cmluZy9pb191cmluZy5j
OjEyNjcKPiAgaW9fc3FfdHcrMHgxMmEvMHgxZDAgaW9fdXJpbmcvc3Fwb2xsLmM6MjQ1Cj4gIGlv
X3NxX3RocmVhZCsweDhkNy8weDE4YTAgaW9fdXJpbmcvc3Fwb2xsLmM6MzA4Cj4gIHJldF9mcm9t
X2ZvcmsrMHg0NS8weDgwIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmM6MTQ3Cj4gIHJldF9mcm9t
X2ZvcmtfYXNtKzB4MWEvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI0Mwo+ICA8L1RB
U0s+Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Cj4gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEtBU0FOOiBwYW5p
Y19vbl93YXJuIHNldCAuLi4KPiBDUFU6IDAgUElEOiAyMTU2MDQgQ29tbTogaW91LXNxcC0yMTU2
MDMgTm90IHRhaW50ZWQgNi44LjAtZ2U1ZTAzOGI3YWU5ZCAjNDAKPiBIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE1LjAtMSAwNC8w
MS8yMDE0CgpJIHRoaW5rIHlvdSBzbmlwcGVkIHRoZSBmYXVsdCBpbmplY3Rpb24gdGhhdCBjYW1l
IGJlZm9yZSB0aGlzLiBJdCBsb29rcwpsaWtlIGFuIGFsbG9jYXRpb24gZmFpbHVyZSwgc28gd2Ug
ZG9uJ3QgZ2V0IHRzay0+aW9fdXJpbmcgc2V0dXAgZm9yIHRoZQpTUVBPTEwgdGhyZWFkLiBOb3Qg
YSBncmVhdCB3YXkgdG8gaGFuZGxlIHRoaXMsIGJ1dCBjYW4geW91IHRyeSB0aGUKYmVsb3c/IFdv
dWxkIGJlIG5pY2VyIGlmIHdlIGNvdWxkIGp1c3QgcHJ1bmUgdGhlIHRhc2sgcmF0aGVyIHRoYW4g
d2FrZQppdCBhbmQgaGF2ZSBpdCBlcnJvci4KCmRpZmYgLS1naXQgYS9pb191cmluZy9zcXBvbGwu
YyBiL2lvX3VyaW5nL3NxcG9sbC5jCmluZGV4IDM2MzA1MmI0ZWE3Ni4uZGI3YjBmZGZlMWNiIDEw
MDY0NAotLS0gYS9pb191cmluZy9zcXBvbGwuYworKysgYi9pb191cmluZy9zcXBvbGwuYwpAQCAt
Mjc0LDYgKzI3NCwxMCBAQCBzdGF0aWMgaW50IGlvX3NxX3RocmVhZCh2b2lkICpkYXRhKQogIGNo
YXIgYnVmW1RBU0tfQ09NTV9MRU5dOwogIERFRklORV9XQUlUKHdhaXQpOwogCisgLyogb2ZmbG9h
ZCBjb250ZXh0IGNyZWF0aW9uIGZhaWxlZCwganVzdCBleGl0ICovCisgaWYgKCFjdXJyZW50LT5p
b191cmluZykgeworICBnb3RvIGVycl9vdXQ7CisKICBzbnByaW50ZihidWYsIHNpemVvZihidWYp
LCAiaW91LXNxcC0lZCIsIHNxZC0+dGFza19waWQpOwogIHNldF90YXNrX2NvbW0oY3VycmVudCwg
YnVmKTsKIApAQCAtMzcxLDcgKzM3NSw3IEBAIHN0YXRpYyBpbnQgaW9fc3FfdGhyZWFkKHZvaWQg
KmRhdGEpCiAgIGF0b21pY19vcihJT1JJTkdfU1FfTkVFRF9XQUtFVVAsICZjdHgtPnJpbmdzLT5z
cV9mbGFncyk7CiAgaW9fcnVuX3Rhc2tfd29yaygpOwogIG11dGV4X3VubG9jaygmc3FkLT5sb2Nr
KTsKLQorZXJyX291dDoKICBjb21wbGV0ZSgmc3FkLT5leGl0ZWQpOwogIGRvX2V4aXQoMCk7CiB9
CgotLSAKSmVucyBBeGJvZQoK

