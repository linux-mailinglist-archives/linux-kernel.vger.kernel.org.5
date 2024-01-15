Return-Path: <linux-kernel+bounces-26024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3282DA10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C3A1F2209C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA91171BC;
	Mon, 15 Jan 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p0Alr4oY"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF6168DE;
	Mon, 15 Jan 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705325281; x=1736861281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CRE66M5NAo6zqtyZQM3AWAf6gOvFh/lPcxTLxUzKJu0=;
  b=p0Alr4oY/WE/6zqqOWFg7Z3U/IC92V2UVasniiWWKeSy9aC9xZIhh9oa
   tDZ2gvXgjw7DDKATFNaTnEdxr3Hd7lejDwMP9f4UVhbT3liyVCGObcKm0
   I0cisZ7x6wgiKs5OJDFx6aVhL0qN33BfWwKKLF4rt5k79GExlnLgi04pD
   0=;
X-IronPort-AV: E=Sophos;i="6.04,196,1695686400"; 
   d="scan'208";a="697876050"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 13:27:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 18BD5A0A25;
	Mon, 15 Jan 2024 13:27:44 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:24915]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.210:2525] with esmtp (Farcaster)
 id 00e71d69-8a91-48a6-b14b-66e164da46e8; Mon, 15 Jan 2024 13:27:44 +0000 (UTC)
X-Farcaster-Flow-ID: 00e71d69-8a91-48a6-b14b-66e164da46e8
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 13:27:43 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 13:27:34 +0000
Message-ID: <64047065-41a1-4235-b600-bf3530c76722@amazon.com>
Date: Mon, 15 Jan 2024 14:27:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] kexec: Add KHO parsing support
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring
	<robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222193607.15474-5-graf@amazon.com> <20240101033301.GA765@skinsburskii.>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240101033301.GA765@skinsburskii.>
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDAxLjAxLjI0IDA0OjMzLCBTdGFuaXNsYXYgS2luc2J1cnNraWkgd3JvdGU6Cj4gT24gRnJp
LCBEZWMgMjIsIDIwMjMgYXQgMDc6MzU6NTRQTSArMDAwMCwgQWxleGFuZGVyIEdyYWYgd3JvdGU6
Cj4+ICsvKioKPj4gKyAqIGtob19yZXNlcnZlX3ByZXZpb3VzX21lbSAtIEFkZHMgYWxsIG1lbW9y
eSByZXNlcnZhdGlvbnMgaW50byBtZW1ibG9ja3MKPj4gKyAqIGFuZCBtb3ZlcyB1cyBvdXQgb2Yg
dGhlIHNjcmF0Y2ggb25seSBwaGFzZS4gTXVzdCBiZSBjYWxsZWQgYWZ0ZXIgcGFnZSB0YWJsZXMK
Pj4gKyAqIGFyZSBpbml0aWFsaXplZCBhbmQgbWVtYmxvY2tfYWxsb3dfcmVzaXplKCkuCj4+ICsg
Ki8KPj4gK3ZvaWQgX19pbml0IGtob19yZXNlcnZlX3ByZXZpb3VzX21lbSh2b2lkKQo+PiArewo+
PiArICAgICB2b2lkICptZW1fdmlydCA9IF9fdmEobWVtX3BoeXMpOwo+PiArICAgICBpbnQgb2Zm
LCBlcnI7Cj4+ICsKPj4gKyAgICAgaWYgKCFoYW5kb3Zlcl9waHlzIHx8ICFtZW1fcGh5cykKPj4g
KyAgICAgICAgICAgICByZXR1cm47Cj4+ICsKPj4gKyAgICAgLyoKPj4gKyAgICAgICogV2UgcmVh
Y2hlZCBoZXJlIGJlY2F1c2Ugd2UgYXJlIHJ1bm5pbmcgaW5zaWRlIGEgd29ya2luZyBsaW5lYXIg
bWFwCj4+ICsgICAgICAqIHRoYXQgYWxsb3dzIHVzIHRvIHJlc2l6ZSBtZW1ibG9ja3MgZHluYW1p
Y2FsbHkuIFVzZSB0aGUgY2hhbmNlIGFuZAo+PiArICAgICAgKiBwb3B1bGF0ZSB0aGUgZ2xvYmFs
IGZkdCBwb2ludGVyCj4+ICsgICAgICAqLwo+PiArICAgICBmZHQgPSBfX3ZhKGhhbmRvdmVyX3Bo
eXMpOwo+PiArCj4+ICsgICAgIG9mZiA9IGZkdF9wYXRoX29mZnNldChmZHQsICIvIik7Cj4+ICsg
ICAgIGlmIChvZmYgPCAwKSB7Cj4+ICsgICAgICAgICAgICAgZmR0ID0gTlVMTDsKPj4gKyAgICAg
ICAgICAgICByZXR1cm47Cj4+ICsgICAgIH0KPj4gKwo+PiArICAgICBlcnIgPSBmZHRfbm9kZV9j
aGVja19jb21wYXRpYmxlKGZkdCwgb2ZmLCAia2hvLXYxIik7Cj4+ICsgICAgIGlmIChlcnIpIHsK
Pj4gKyAgICAgICAgICAgICBwcl93YXJuKCJLSE8gaGFzIGludmFsaWQgY29tcGF0aWJsZSwgZGlz
YWJsaW5nLiIpOwo+IEl0IGxvb2tzIGxpa2UgS0hPIHByZXNlcnZlZCByZWdpb25zIHdvbid0IGJl
IHJlc2VydmVkIGluIHRoaXMgY2FzZS4KPiBTaG91bGQgS0hPIERUIHN0YXRlIGJlIGRlc3Ryb3ll
ZCBoZXJlIHRvIHByZXZlbnQgS0hPIG1lbW9yeSByZWdpb25zCj4gcmV1c2UgdXBvbiByb2xsYmFj
az8KCgpHb29kIGNhdGNoLiBJJ2xsIHNldCBmZHQgdG8gTlVMTCBpbiB0aGF0IGNhc2UgaW4gdjMu
CgoKPgo+PiArCj4+ICt2b2lkIF9faW5pdCBraG9fcG9wdWxhdGUocGh5c19hZGRyX3QgaGFuZG92
ZXJfZHRfcGh5cywgcGh5c19hZGRyX3Qgc2NyYXRjaF9waHlzLAo+PiArICAgICAgICAgICAgICAg
ICAgICAgIHU2NCBzY3JhdGNoX2xlbiwgcGh5c19hZGRyX3QgbWVtX2NhY2hlX3BoeXMsCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgdTY0IG1lbV9jYWNoZV9sZW4pCj4+ICt7Cj4+ICsgICAgIHZv
aWQgKmhhbmRvdmVyX2R0Owo+PiArCj4+ICsgICAgIC8qIERldGVybWluZSB0aGUgcmVhbCBzaXpl
IG9mIHRoZSBEVCAqLwo+PiArICAgICBoYW5kb3Zlcl9kdCA9IGVhcmx5X21lbXJlbWFwKGhhbmRv
dmVyX2R0X3BoeXMsIHNpemVvZihzdHJ1Y3QgZmR0X2hlYWRlcikpOwo+PiArICAgICBpZiAoIWhh
bmRvdmVyX2R0KSB7Cj4+ICsgICAgICAgICAgICAgcHJfd2Fybigic2V0dXA6IGZhaWxlZCB0byBt
ZW1yZW1hcCBrZXhlYyBGRFQgKDB4JWxseClcbiIsIGhhbmRvdmVyX2R0X3BoeXMpOwo+PiArICAg
ICAgICAgICAgIHJldHVybjsKPj4gKyAgICAgfQo+PiArCj4+ICsgICAgIGlmIChmZHRfY2hlY2tf
aGVhZGVyKGhhbmRvdmVyX2R0KSkgewo+PiArICAgICAgICAgICAgIHByX3dhcm4oInNldHVwOiBr
ZXhlYyBoYW5kb3ZlciBGRFQgaXMgaW52YWxpZCAoMHglbGx4KVxuIiwgaGFuZG92ZXJfZHRfcGh5
cyk7Cj4+ICsgICAgICAgICAgICAgZWFybHlfbWVtdW5tYXAoaGFuZG92ZXJfZHQsIFBBR0VfU0la
RSk7Cj4+ICsgICAgICAgICAgICAgcmV0dXJuOwo+PiArICAgICB9Cj4+ICsKPj4gKyAgICAgaGFu
ZG92ZXJfbGVuID0gZmR0X3RvdGFsc2l6ZShoYW5kb3Zlcl9kdCk7Cj4+ICsgICAgIGhhbmRvdmVy
X3BoeXMgPSBoYW5kb3Zlcl9kdF9waHlzOwo+PiArCj4+ICsgICAgIC8qIFJlc2VydmUgdGhlIERU
IHNvIHdlIGNhbiBzdGlsbCBhY2Nlc3MgaXQgaW4gbGF0ZSBib290ICovCj4+ICsgICAgIG1lbWJs
b2NrX3Jlc2VydmUoaGFuZG92ZXJfcGh5cywgaGFuZG92ZXJfbGVuKTsKPj4gKwo+PiArICAgICAv
KiBSZXNlcnZlIHRoZSBtZW0gY2FjaGUgc28gd2UgY2FuIHN0aWxsIGFjY2VzcyBpdCBsYXRlciAq
Lwo+PiArICAgICBtZW1ibG9ja19yZXNlcnZlKG1lbV9jYWNoZV9waHlzLCBtZW1fY2FjaGVfbGVu
KTsKPj4gKwo+PiArICAgICAvKgo+PiArICAgICAgKiBXZSBwYXNzIGEgc2FmZSBjb250aWd1b3Vz
IGJsb2NrIG9mIG1lbW9yeSB0byB1c2UgZm9yIGVhcmx5IGJvb3QgcHVycG9yc2VzIGZyb20KPj4g
KyAgICAgICogdGhlIHByZXZpb3VzIGtlcm5lbCBzbyB0aGF0IHdlIGNhbiByZXNpemUgdGhlIG1l
bWJsb2NrIGFycmF5IGFzIG5lZWRlZC4KPj4gKyAgICAgICovCj4+ICsgICAgIG1lbWJsb2NrX2Fk
ZChzY3JhdGNoX3BoeXMsIHNjcmF0Y2hfbGVuKTsKPj4gKwo+PiArICAgICBpZiAoV0FSTl9PTiht
ZW1ibG9ja19tYXJrX3NjcmF0Y2goc2NyYXRjaF9waHlzLCBzY3JhdGNoX2xlbikpKSB7Cj4+ICsg
ICAgICAgICAgICAgcHJfZXJyKCJLZXhlYyBmYWlsZWQgdG8gbWFyayB0aGUgc2NyYXRjaCByZWdp
b24uIERpc2FibGluZyBLSE8uIik7Cj4+ICsgICAgICAgICAgICAgaGFuZG92ZXJfbGVuID0gMDsK
Pj4gKyAgICAgICAgICAgICBoYW5kb3Zlcl9waHlzID0gMDsKPiBTYW1lIHF1ZXN0aW9uIGhlcmU6
IGRvZXNuJ3QgYWxsIHRoZSBLSE8gc3RhdGUgZ2V0cyBpbnZhbGlkIGluIGNhc2Ugb2YgYW55Cj4g
cmVzdG9yYXRpb24gZXJyb3I/CgoKSXQgZG9lcywgd2hpY2ggaXMgd2hhdCB0aGUgZXJyb3IgY2Fz
ZSBoZXJlIGRvZXMsIG5vPyBPciBhcmUgeW91IApyZWZlcnJpbmcgdG8gdGhlIGZhY3QgdGhhdCB3
ZSdyZSBub3QgdW5yb2xsaW5nIHRoZSBtZW1ibG9jayAKcmVzZXJ2YXRpb25zPyBJZiB3ZSBjYW4n
dCBtYXJrIHRoZSBzY3JhdGNoIHJlZ2lvbiwgSSdkIHJhdGhlciBsZWF2ZSAKZXZlcnl0aGluZyBl
bHNlIGFsb25lLiBJdCBtZWFucyB0aGUgc2NyYXRjaCByZWdpb24gaXMgaW4gYSBob2xlLCB3aGlj
aCAKc2hvdWxkIG5ldmVyIGhhcHBlbi4KCgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


