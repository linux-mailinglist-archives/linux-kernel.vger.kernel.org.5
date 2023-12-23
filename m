Return-Path: <linux-kernel+bounces-10604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4381D736
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169EF1F21E27
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829451D52D;
	Sat, 23 Dec 2023 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mjo02yQS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A638171B1;
	Sat, 23 Dec 2023 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703373633; x=1734909633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+KhPZsRbblVB5TlZ9Os7h40uFhyo0WJh9bKeRzhbeI=;
  b=Mjo02yQSjvs/R8FO1jOQbdttCkDqR71HbmzXXWJuh4wCvWQuAaJtfSxs
   RKS3CO3b8mRI0l7f7VTCxD6hiWX00gS0ja7/wFukwNSWTpuoEXGalFvY1
   m8z9oDfPCqt8lZ8b8xmW1HRsw8GDizjpovECUrdCcs/Ny3gBkZP1v28Kt
   o=;
X-IronPort-AV: E=Sophos;i="6.04,300,1695686400"; 
   d="scan'208";a="385480696"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 23:20:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 45BE440D5B;
	Sat, 23 Dec 2023 23:20:26 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:32696]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.220:2525] with esmtp (Farcaster)
 id 4e3d549d-4556-4d0e-b7ed-87d0eaff99ca; Sat, 23 Dec 2023 23:20:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4e3d549d-4556-4d0e-b7ed-87d0eaff99ca
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 23 Dec 2023 23:20:25 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 23 Dec
 2023 23:20:19 +0000
Message-ID: <34e78a84-a29d-4b01-a860-cac3959f6cb6@amazon.com>
Date: Sun, 24 Dec 2023 00:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
 <39a33f9b-0290-428d-ab1f-f90856cdb31d@kernel.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <39a33f9b-0290-428d-ab1f-f90856cdb31d@kernel.org>
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGkgS3J6eXN6dG9mIQoKVGhhbmtzIGEgbG90IGZvciB0aGUgZmFzdCByZXZpZXchCgpPbiAyMy4x
Mi4yMyAxNTozMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKPiBPbiAyMi8xMi8yMDIzIDIw
OjUxLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToKPj4gV2l0aCBmdHJhY2UgaW4gS0hPLCB3ZSBhcmUg
Y3JlYXRpbmcgYW4gQUJJIGJldHdlZW4gb2xkIGtlcm5lbCBhbmQgbmV3Cj4+IGtlcm5lbCBhYm91
dCB0aGUgc3RhdGUgdGhhdCB0aGV5IHRyYW5zZmVyLiBUbyBlbnN1cmUgdGhhdCB3ZSBkb2N1bWVu
dAo+PiB0aGF0IHN0YXRlIGFuZCBjYXRjaCBhbnkgYnJlYWtpbmcgY2hhbmdlLCBsZXQncyBhZGQg
aXRzIHNjaGVtYSB0byB0aGUKPj4gY29tbW9uIGRldmljZXRyZWUgYmluZGluZ3MuIFRoaXMgd2F5
LCB3ZSBjYW4gcXVpY2tseSByZWFzb24gYWJvdXQgdGhlCj4+IHN0YXRlIHRoYXQgZ2V0cyBwYXNz
ZWQuCj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0
IG9mIG5lY2Vzc2FyeSBwZW9wbGUKPiBhbmQgbGlzdHMgdG8gQ0MgKGFuZCBjb25zaWRlciAtLW5v
LWdpdC1mYWxsYmFjayBhcmd1bWVudCkuIEl0IG1pZ2h0Cj4gaGFwcGVuLCB0aGF0IGNvbW1hbmQg
d2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQKPiBlbnRyaWVz
LiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91IGJhc2UgeW91ciBwYXRjaGVzIG9uIHJlY2Vu
dCBMaW51eAo+IGtlcm5lbC4KCgpBaCwgdGhpcyBpcyBhYm91dCBkaXJlY3RseSBDQydpbmcgbWFp
bnRhaW5lcnM/IEkgd2FzIHNsaWdodGx5IHBpY2t5IG9uIApDQ3Mgc2luY2UgdGhlIENDIGxpc3Qg
aXMgYWxyZWFkeSBhIGJpdCBsb25nIGZvciB0aGlzIHBhdGNoIHNldCwgc28gSSAKbGltaXRlZCB0
aGUgQ0MgbGlzdCB0byBtYWlsaW5nIGxpc3RzIGFuZCBwZW9wbGUgdGhhdCBJIGtub3cgd2VyZSAK
ZGlyZWN0bHkgaW50ZXJlc3RlZC4gSGFwcHkgdG8gQ0MgeW91IG5leHQgdGltZS4KCgo+Cj4gUGxl
YXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0uIFlvdSBjYW4g
Z2V0IHRoZW0gZm9yCj4gZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RP
UllfT1JfRklMRWAgb24gdGhlIGRpcmVjdG9yeQo+IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcuCj4K
PiBBIG5pdCwgc3ViamVjdDogZHJvcCBzZWNvbmQvbGFzdCwgcmVkdW5kYW50ICJiaW5kaW5ncyIu
IFRoZQo+ICJkdC1iaW5kaW5ncyIgcHJlZml4IGlzIGFscmVhZHkgc3RhdGluZyB0aGF0IHRoZXNl
IGFyZSBiaW5kaW5ncy4KCgpIYXBweSB0byBmaXggdXAgZm9yIHYzIDopCgoKPgo+PiBTaWduZWQt
b2ZmLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+PiAtLS0KPj4gICAuLi4v
YmluZGluZ3Mva2hvL2Z0cmFjZS9mdHJhY2UtYXJyYXkueWFtbCAgICAgfCA0NiArKysrKysrKysr
KysrKysKPj4gICAuLi4vYmluZGluZ3Mva2hvL2Z0cmFjZS9mdHJhY2UtY3B1LnlhbWwgICAgICAg
fCA1NiArKysrKysrKysrKysrKysrKysrCj4+ICAgLi4uL2JpbmRpbmdzL2toby9mdHJhY2UvZnRy
YWNlLnlhbWwgICAgICAgICAgIHwgNDggKysrKysrKysrKysrKysrKwo+PiAgIDMgZmlsZXMgY2hh
bmdlZCwgMTUwIGluc2VydGlvbnMoKykKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2toby9mdHJhY2UvZnRyYWNlLWFycmF5LnlhbWwKPj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2to
by9mdHJhY2UvZnRyYWNlLWNwdS55YW1sCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9raG8vZnRyYWNlL2Z0cmFjZS55YW1sCj4+Cj4+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mva2hvL2Z0cmFjZS9m
dHJhY2UtYXJyYXkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9raG8v
ZnRyYWNlL2Z0cmFjZS1hcnJheS55YW1sCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4
IDAwMDAwMDAwMDAwMC4uOTk2MGZlZmMyOTJkCj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2toby9mdHJhY2UvZnRyYWNlLWFycmF5Lnlh
bWwKPj4gQEAgLTAsMCArMSw0NiBAQAo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQ
TC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpCj4+ICslWUFNTCAxLjIKPj4gKy0tLQo+PiArJGlk
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9raG8vZnRyYWNlL2Z0cmFjZS1hcnJheS55
YW1sIwo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwjCj4+ICsKPj4gK3RpdGxlOiBGdHJhY2UgdHJhY2UgYXJyYXkKPj4gKwo+IE1pc3Npbmcg
ZGVzY3JpcHRpb24uIENvbW1pdCBtc2cgYWxzbyBkb2VzIG5vdCB0ZWxsIG1lIG11Y2guIFRoaXMg
bXVzdAo+IHN0YW5kIG9uIGl0cyBvd24gYW5kIG11c3QgZGVzY3JpYmUgdGhlIGhhcmR3YXJlLiBX
aGF0ZXZlciB5b3UgaGF2ZSBpbgo+IGNvdmVyIGxldHRlciwgZG9lcyBub3QgbWF0dGVyLCBlc3Bl
Y2lhbGx5IHRoYXQgeW91IGRpZCBub3QgQ2MgdXMgb24gaXQuCgoKQWxyaWdodHksIEknbGwgYWRk
IGRlc2NyaXB0aW9ucyBhbmQgbWFrZSB0aGUgY29tbWl0IG1lc3NhZ2Ugc3RhbmQgb24gaXRzIApv
d24uCgpGb3IgcXVpY2sgcmVmZXJlbmNlOiBLSE8gaXMgYSBuZXcgbWVjaGFuaXNtIHRoaXMgcGF0
Y2ggc2V0IGludHJvZHVjZXMgCndoaWNoIGFsbG93cyBMaW51eCB0byBwYXNzIGFyYml0cmFyeSBt
ZW1vcnkgYW5kIG1ldGFkYXRhIGJldHdlZW4ga2VybmVscyAKb24ga2V4ZWMuIEknbSByZXVzaW5n
IEZEVHMgdG8gaW1wbGVtZW50IHRoZSBoYW5kIG92ZXIgcHJvdG9jb2wsIGFzIApMaW51eC10by1M
aW51eCBib290IGNvbW11bmljYXRpb24gaG9sZHMgdmVyeSBzaW1pbGFyIHByb3BlcnRpZXMgdG8g
CmZpcm13YXJlLXRvLUxpbnV4IGJvb3QgY29tbXVuaWNhdGlvbi4gU28gdGhpcyBiaW5kaW5nIGlz
IG5vdCBhYm91dCAKaGFyZHdhcmU7IGl0J3MgYWJvdXQgcHJlc2VydmluZyBMaW51eCBzdWJzeXN0
ZW0gc3RhdGUgYWNyb3NzIGtleGVjLgoKRm9yIG1vcmUgZGV0YWlscywgcGxlYXNlIHJlZmVyIHRv
IHRoZSBLSE8gZG9jdW1lbnRhdGlvbiB3aGljaCBpcyBwYXJ0IG9mIApwYXRjaCA3IG9mIHRoaXMg
cGF0Y2ggc2V0OiAKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMTIyMjE5NTE0NC4y
NDUzMi0yLWdyYWZAYW1hem9uLmNvbS8KCgo+Cj4+ICttYWludGFpbmVyczoKPj4gKyAgLSBBbGV4
YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+PiArCj4+ICtwcm9wZXJ0aWVzOgo+PiArICBj
b21wYXRpYmxlOgo+PiArICAgIGVudW06Cj4+ICsgICAgICAtIGZ0cmFjZSxhcnJheS12MQo+PiAr
Cj4+ICsgIHRyYWNlX2ZsYWdzOgo+IFVuZGVyc2NvcmVzIGFyZSBub3QgYWxsb3dlZC4gRG9lcyBu
b3QgbG9vayBsaWtlIGdlbmVyaWMgcHJvcGVydHkuCgoKTGV0IG1lIG1ha2UgaXQgInRyYWNlLWZs
YWdzIiB0byBub3QgaGF2ZSB1bmRlcnNjb3Jlcy4gQ291bGQgeW91IHBsZWFzZSAKZWxhYm9yYXRl
IG9uIHdoYXQgeW91IG1lYW4gYnkgZ2VuZXJpYyBwcm9wZXJ0eT8KCgo+Cj4KPj4gKyAgICAkcmVm
OiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzIKPj4gKyAgICBkZXNjcmlw
dGlvbjoKPj4gKyAgICAgIEJpdG1hcCBvZiBhbGwgdGhlIHRyYWNlIGZsYWdzIHRoYXQgd2VyZSBl
bmFibGVkIGluIHRoZSB0cmFjZSBhcnJheSBhdCB0aGUKPj4gKyAgICAgIHBvaW50IG9mIHNlcmlh
bGl6YXRpb24uCj4+ICsKPj4gKyMgU3Vibm9kZXMgd2lsbCBiZSBvZiB0eXBlICJmdHJhY2UsY3B1
LXYxIiwgb25lIGVhY2ggcGVyIENQVQo+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IHRydWUKPiBO
bywgdGhpcyBtdXN0IGJlIGZhbHNlLiBBbmQgaXQgZ29lcyBhZnRlciByZXF1aXJlZDoKCgpPaywg
bWFraW5nIGl0IGZhbHNlIGFuZCBhZGRpbmcgcGF0dGVybiBtYXRjaGVzIGluc3RlYWQgZm9yIHN1
Ym5vZGVzLgoKCj4KPgo+PiArCj4+ICtyZXF1aXJlZDoKPj4gKyAgLSBjb21wYXRpYmxlCj4+ICsg
IC0gdHJhY2VfZmxhZ3MKPj4gKwo+PiArZXhhbXBsZXM6Cj4+ICsgIC0gfAo+PiArICAgIGZ0cmFj
ZSB7Cj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZnRyYWNlLXYxIjsKPj4gKyAgICAgICAgZXZl
bnRzID0gPDEgMSAyIDIgMyAzPjsKPj4gKwo+PiArICAgICAgICBnbG9iYWxfdHJhY2Ugewo+IEFn
YWluLCBubyB1bmRlcnNjb3Jlcy4KCgpPayA6KQoKCj4KPj4gKyAgICAgICAgICBjb21wYXRpYmxl
ID0gImZ0cmFjZSxhcnJheS12MSI7Cj4+ICsgICAgICAgICAgdHJhY2VfZmxhZ3MgPSA8IDB4MzM1
NDYwMSA+Owo+PiArCj4+ICsgICAgICAgICAgY3B1MCB7Cj4+ICsgICAgICAgICAgICBjb21wYXRp
YmxlID0gImZ0cmFjZSxjcHUtdjEiOwo+PiArICAgICAgICAgICAgY3B1ID0gPCAweDAwID47Cj4g
RHJvcCByZWR1bmRhbnQgc3BhY2VzLgoKCkkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSdyZSBy
ZWZlcnJpbmcgdG8gYXMgcmVkdW5kYW50IHNwYWNlcz8gRG91YmxlIApjaGVja2luZywgSSBiZWxp
ZXZlIGluZGVudGF0aW9uIGlzIG9mZiBmb3IgZXZlcnkgbGluZSBiZWxvdyAiZnRyYWNlIHsiLiAK
SXMgdGhhdCB3aGF0IHlvdSdyZSByZWZlcnJpbmcgdG8/IEZpeGluZyA6KQoKCj4KPj4gKyAgICAg
ICAgICAgIG1lbSA9IDwgMHgxMDEwMDAwMDBVTEwgMHgzOFVMTCAweDEwMTAwMDEwMFVMTCAweDEw
MDBVTEwgMHgxMDEwMDAwMzhVTEwgMHgzOFVMTCAweDEwMTAwMjAwMFVMTCAweDEwMDBVTEw+Owo+
ID8gRG8geW91IHNlZSBhbnkgb2Ygc3VjaCBzeW50YXggaW4gRFRTPwoKCkkgd2FzIHRyeWluZyB0
byBtYWtlIGl0IGVhc3kgdG8gcmVhc29uIHRvIHJlYWRlcnMgYWJvdXQgNjRiaXQgbnVtYmVycyAt
IAphbmQgdGhlbiBwb3RlbnRpYWxseSBleHRlbmQgZHRjIHRvIGNvbnN1bWUgdGhhdCBuZXcgc3lu
dGF4LiBLSE8gRFRzIGFyZSAKbmF0aXZlL2xpdHRsZSBlbmRpYW4sIHNvIGR0YyBhbHJlYWR5IGhh
cyBzb21lIGRpZmZpY3VsdGllcyBpbnRlcnByZXRpbmcgCml0IHdoaWNoIEknbGwgbmVlZCB0byBm
aXggdXAgd2l0aCBwYXRjaGVzIHRvIGl0IGV2ZW50dWFsbHkgOikuIEknbGwgCmNoYW5nZSBpdCB0
byBzb21ldGhpbmcgdGhhdCBsb29rcyBtb3JlIDMyYml0J3kgZm9yIG5vdy4KCgpBbGV4CgoKCgpB
bWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDEx
NyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhh
biBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBI
UkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


