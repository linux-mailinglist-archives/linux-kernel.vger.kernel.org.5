Return-Path: <linux-kernel+bounces-4460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC23D817DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC884B22074
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40256760AD;
	Mon, 18 Dec 2023 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N+ox8I/y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE87608B;
	Mon, 18 Dec 2023 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702940485; x=1734476485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BKnuJnSOr7AXqCS4JEaUZGmhItcYW0ApYK2shnoxWNA=;
  b=N+ox8I/yPWHigBUo8dJWBaKE+wRhHBCS8te42gDuHFkPDkv9x9UG8pRt
   E1EbderHnK/fu+PXZsZnovjcZVodRaTblVEJyH7XHybbH7FC5foo4a6Ql
   nQwPIRg/gJKjdP2NwMDI9favyPMe7wedaH2DYOWPxeFiq5IBshEPckjxH
   4=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="52164912"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:01:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id D02B4C605B;
	Mon, 18 Dec 2023 23:01:10 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:5473]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id 5f7bb7c5-6180-43fc-ad28-77aacdf6c520; Mon, 18 Dec 2023 23:01:10 +0000 (UTC)
X-Farcaster-Flow-ID: 5f7bb7c5-6180-43fc-ad28-77aacdf6c520
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 23:01:10 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 23:01:04 +0000
Message-ID: <d843596e-0def-439b-966a-a0f10a1b7f6d@amazon.com>
Date: Tue, 19 Dec 2023 00:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] arm64: Add KHO support
To: Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-7-graf@amazon.com>
 <20231214223604.GA1045434-robh@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20231214223604.GA1045434-robh@kernel.org>
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IFJvYiEKCk9uIDE0LjEyLjIzIDIzOjM2LCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBXZWQs
IERlYyAxMywgMjAyMyBhdCAxMjowNDo0M0FNICswMDAwLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToK
Pj4gV2Ugbm93IGhhdmUgYWxsIGJpdHMgaW4gcGxhY2UgdG8gc3VwcG9ydCBLSE8ga2V4ZWNzLiBU
aGlzIHBhdGNoIGFkZHMKPj4gYXdhcmVuZXNzIG9mIEtITyBpbiB0aGUga2V4ZWMgZmlsZSBhcyB3
ZWxsIGFzIGJvb3QgcGF0aCBmb3IgYXJtNjQgYW5kCj4+IGFkZHMgdGhlIHJlc3BlY3RpdmUga2Nv
bmZpZyBvcHRpb24gdG8gdGhlIGFyY2hpdGVjdHVyZSBzbyB0aGF0IGl0IGNhbgo+PiB1c2UgS0hP
IHN1Y2Nlc3NmdWxseS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEdyYWYgPGdyYWZA
YW1hem9uLmNvbT4KPj4gLS0tCj4+ICAgYXJjaC9hcm02NC9LY29uZmlnICAgICAgICB8IDEyICsr
KysrKysrKysrKwo+PiAgIGFyY2gvYXJtNjQva2VybmVsL3NldHVwLmMgfCAgMiArKwo+PiAgIGFy
Y2gvYXJtNjQvbW0vaW5pdC5jICAgICAgfCAgOCArKysrKysrKwo+PiAgIGRyaXZlcnMvb2YvZmR0
LmMgICAgICAgICAgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
Pj4gICBkcml2ZXJzL29mL2tleGVjLmMgICAgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+PiAgIDUgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9LY29uZmlnIGIvYXJjaC9hcm02NC9LY29uZmlnCj4+
IGluZGV4IDdiMDcxYTAwNDI1ZC4uMWJhMzM4Y2U3NTk4IDEwMDY0NAo+PiAtLS0gYS9hcmNoL2Fy
bTY0L0tjb25maWcKPj4gKysrIGIvYXJjaC9hcm02NC9LY29uZmlnCj4+IEBAIC0xNTAxLDYgKzE1
MDEsMTggQEAgY29uZmlnIEFSQ0hfU1VQUE9SVFNfQ1JBU0hfRFVNUAo+PiAgIGNvbmZpZyBBUkNI
X0hBU19HRU5FUklDX0NSQVNIS0VSTkVMX1JFU0VSVkFUSU9OCj4+ICAgICAgICBkZWZfYm9vbCBD
UkFTSF9DT1JFCj4+Cj4+ICtjb25maWcgS0VYRUNfS0hPCj4+ICsgICAgIGJvb2wgImtleGVjIGhh
bmRvdmVyIgo+PiArICAgICBkZXBlbmRzIG9uIEtFWEVDCj4+ICsgICAgIHNlbGVjdCBNRU1CTE9D
S19TQ1JBVENICj4+ICsgICAgIHNlbGVjdCBMSUJGRFQKPj4gKyAgICAgc2VsZWN0IENNQQo+PiAr
ICAgICBoZWxwCj4+ICsgICAgICAgQWxsb3cga2V4ZWMgdG8gaGFuZCBvdmVyIHN0YXRlIGFjcm9z
cyBrZXJuZWxzIGJ5IGdlbmVyYXRpbmcgYW5kCj4+ICsgICAgICAgcGFzc2luZyBhZGRpdGlvbmFs
IG1ldGFkYXRhIHRvIHRoZSB0YXJnZXQga2VybmVsLiBUaGlzIGlzIHVzZWZ1bAo+PiArICAgICAg
IHRvIGtlZXAgZGF0YSBvciBzdGF0ZSBhbGl2ZSBhY3Jvc3MgdGhlIGtleGVjLiBGb3IgdGhpcyB0
byB3b3JrLAo+PiArICAgICAgIGJvdGggc291cmNlIGFuZCB0YXJnZXQga2VybmVscyBuZWVkIHRv
IGhhdmUgdGhpcyBvcHRpb24gZW5hYmxlZC4KPiBXaHkgZG8gd2UgaGF2ZSB0aGUgc2FtZSBrY29u
ZmlnIGVudHJ5IHR3aWNlPyBIZXJlIGFuZCB4ODYuCgoKVGhpcyB3YXMgaG93IHRoZSBrZXhlYyBj
b25maWcgb3B0aW9ucyB3ZXJlIGRvbmUgd2hlbiBJIHdyb3RlIHRoZSBwYXRjaGVzIApvcmlnaW5h
bGx5LiBTaW5jZSB0aGVuLCBsb29rcyBsaWtlIEVyaWMgRGVWb2xkZXIgaGFzIGNsZWFuZWQgdXAg
dGhpbmdzIApxdWl0ZSBuaWNlbHkuIEknbGwgYWRhcHQgdGhlIG5ldyB3YXkuCgoKPgo+PiArCj4+
ICAgY29uZmlnIFRSQU5TX1RBQkxFCj4+ICAgICAgICBkZWZfYm9vbCB5Cj4+ICAgICAgICBkZXBl
bmRzIG9uIEhJQkVSTkFUSU9OIHx8IEtFWEVDX0NPUkUKPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQva2VybmVsL3NldHVwLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+IGluZGV4IDQx
N2E4YTg2YjJkYi4uODAzNWI2NzNkOTZkIDEwMDY0NAo+PiAtLS0gYS9hcmNoL2FybTY0L2tlcm5l
bC9zZXR1cC5jCj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMKPj4gQEAgLTM0Niw2
ICszNDYsOCBAQCB2b2lkIF9faW5pdCBfX25vX3Nhbml0aXplX2FkZHJlc3Mgc2V0dXBfYXJjaChj
aGFyICoqY21kbGluZV9wKQo+Pgo+PiAgICAgICAgcGFnaW5nX2luaXQoKTsKPj4KPj4gKyAgICAg
a2hvX3Jlc2VydmVfbWVtKCk7Cj4+ICsKPj4gICAgICAgIGFjcGlfdGFibGVfdXBncmFkZSgpOwo+
Pgo+PiAgICAgICAgLyogUGFyc2UgdGhlIEFDUEkgdGFibGVzIGZvciBwb3NzaWJsZSBib290LXRp
bWUgY29uZmlndXJhdGlvbiAqLwo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9pbml0LmMg
Yi9hcmNoL2FybTY0L21tL2luaXQuYwo+PiBpbmRleCA3NGMxZGI4Y2UyNzEuLjI1NGQ4MmYzMzgz
YSAxMDA2NDQKPj4gLS0tIGEvYXJjaC9hcm02NC9tbS9pbml0LmMKPj4gKysrIGIvYXJjaC9hcm02
NC9tbS9pbml0LmMKPj4gQEAgLTM1OCw2ICszNTgsOCBAQCB2b2lkIF9faW5pdCBib290bWVtX2lu
aXQodm9pZCkKPj4gICAgICAgICAqLwo+PiAgICAgICAgYXJjaF9yZXNlcnZlX2NyYXNoa2VybmVs
KCk7Cj4+Cj4+ICsgICAgIGtob19yZXNlcnZlKCk7Cj4+ICsKPiByZXNlcnZlIHdoYXQ/IEl0IGlz
IG5vdCBvYnZpb3VzIHdoYXQgdGhlIGRpZmZlcmVuY2UgYmV0d2Vlbgo+IGtob19yZXNlcnZlX21l
bSgpIGFuZCBraG9fcmVzZXJ2ZSgpIGFyZS4KCgpZZWFoLCBJIGFncmVlLiBJIHdhcyBzdHJ1Z2ds
aW5nIHRvIGZpbmQgZ29vZCBuYW1lcyBmb3IgdGhlbS4gV2hhdCB0aGV5IApkbyBpczoKCmtob19y
ZXNlcnZlKCkgLSBSZXNlcnZlIENNQSBtZW1vcnkgZm9yIGxhdGVyIGtleGVjLiBXZSB1c2UgdGhp
cyBtZW1vcnkgCnJlZ2lvbiBhcyBzY3JhdGNoIG1lbW9yeSBsYXRlci4Ka2hvX3Jlc2VydmVfbWVt
KCkgLSBQb3N0LUtITy4gQ3JlYXRlcyBtZW1vcnkgcmVzZXJ2YXRpb25zIGluc2lkZSAKbWVtYmxv
Y2tzIGZvciBwcmUtS0hPIGhhbmRlZCBvdmVyIG1lbW9yeS4KCkZvciB2MiwgSSdsbCBjaGFuZ2Ug
dGhlbSB0byBraG9fcmVzZXJ2ZV9zY3JhdGNoKCkgYW5kIApraG9fcmVzZXJ2ZV9wcmV2aW91c19t
ZW0oKSB1bmxlc3MgeW91IGhhdmUgYmV0dGVyIGlkZWFzIDopCgoKPgo+PiAgICAgICAgbWVtYmxv
Y2tfZHVtcF9hbGwoKTsKPj4gICB9Cj4+Cj4+IEBAIC0zODYsNiArMzg4LDEyIEBAIHZvaWQgX19p
bml0IG1lbV9pbml0KHZvaWQpCj4+ICAgICAgICAvKiB0aGlzIHdpbGwgcHV0IGFsbCB1bnVzZWQg
bG93IG1lbW9yeSBvbnRvIHRoZSBmcmVlbGlzdHMgKi8KPj4gICAgICAgIG1lbWJsb2NrX2ZyZWVf
YWxsKCk7Cj4+Cj4+ICsgICAgIC8qCj4+ICsgICAgICAqIE5vdyB0aGF0IGFsbCBLSE8gcGFnZXMg
YXJlIG1hcmtlZCBhcyByZXNlcnZlZCwgbGV0J3MgZmxpcCB0aGVtIGJhY2sKPj4gKyAgICAgICog
dG8gbm9ybWFsIHBhZ2VzIHdpdGggYWNjdXJhdGUgcmVmY291bnQuCj4+ICsgICAgICAqLwo+PiAr
ICAgICBraG9fcG9wdWxhdGVfcmVmY291bnQoKTsKPj4gKwo+PiAgICAgICAgLyoKPj4gICAgICAg
ICAqIENoZWNrIGJvdW5kYXJpZXMgdHdpY2U6IFNvbWUgZnVuZGFtZW50YWwgaW5jb25zaXN0ZW5j
aWVzIGNhbiBiZQo+PiAgICAgICAgICogZGV0ZWN0ZWQgYXQgYnVpbGQgdGltZSBhbHJlYWR5Lgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9vZi9mZHQuYyBiL2RyaXZlcnMvb2YvZmR0LmMKPj4gaW5k
ZXggYmY1MDJiYThkYTk1Li5hZjk1MTM5MzUxZWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvb2Yv
ZmR0LmMKPj4gKysrIGIvZHJpdmVycy9vZi9mZHQuYwo+PiBAQCAtMTAwNiw2ICsxMDA2LDQ0IEBA
IHZvaWQgX19pbml0IGVhcmx5X2luaXRfZHRfY2hlY2tfZm9yX3VzYWJsZV9tZW1fcmFuZ2Uodm9p
ZCkKPj4gICAgICAgICAgICAgICAgbWVtYmxvY2tfYWRkKHJnbltpXS5iYXNlLCByZ25baV0uc2l6
ZSk7Cj4+ICAgfQo+Pgo+PiArLyoqCj4+ICsgKiBlYXJseV9pbml0X2R0X2NoZWNrX2tobyAtIERl
Y29kZSBpbmZvIHJlcXVpcmVkIGZvciBrZXhlYyBoYW5kb3ZlciBmcm9tIERUCj4+ICsgKi8KPj4g
K3ZvaWQgX19pbml0IGVhcmx5X2luaXRfZHRfY2hlY2tfa2hvKHZvaWQpCj4+ICt7Cj4+ICsjaWZk
ZWYgQ09ORklHX0tFWEVDX0tITwo+IGlmICghSVNfRU5BQkxFRChDT05GSUdfS0VYRUNfS0hPKSkK
PiAgICByZXR1cm47Cj4KPiBZb3UnbGwgbmVlZCBhIGtob19wb3B1bGF0ZSgpIHN0dWIuCgoKQWx3
YXlzIGhhcHB5IHRvIHJlbW92ZSAjaWZkZWZzIDopCgoKPgo+PiArICAgICB1bnNpZ25lZCBsb25n
IG5vZGUgPSBjaG9zZW5fbm9kZV9vZmZzZXQ7Cj4+ICsgICAgIHU2NCBraG9fc3RhcnQsIHNjcmF0
Y2hfc3RhcnQsIHNjcmF0Y2hfc2l6ZSwgbWVtX3N0YXJ0LCBtZW1fc2l6ZTsKPj4gKyAgICAgY29u
c3QgX19iZTMyICpwOwo+PiArICAgICBpbnQgbDsKPj4gKwo+PiArICAgICBpZiAoKGxvbmcpbm9k
ZSA8IDApCj4+ICsgICAgICAgICAgICAgcmV0dXJuOwo+PiArCj4+ICsgICAgIHAgPSBvZl9nZXRf
ZmxhdF9kdF9wcm9wKG5vZGUsICJsaW51eCxraG8tZHQiLCAmbCk7Cj4+ICsgICAgIGlmIChsICE9
IChkdF9yb290X2FkZHJfY2VsbHMgKyBkdF9yb290X3NpemVfY2VsbHMpICogc2l6ZW9mKF9fYmUz
MikpCj4+ICsgICAgICAgICAgICAgcmV0dXJuOwo+PiArCj4+ICsgICAgIGtob19zdGFydCA9IGR0
X21lbV9uZXh0X2NlbGwoZHRfcm9vdF9hZGRyX2NlbGxzLCAmcCk7Cj4+ICsKPj4gKyAgICAgcCA9
IG9mX2dldF9mbGF0X2R0X3Byb3Aobm9kZSwgImxpbnV4LGtoby1zY3JhdGNoIiwgJmwpOwo+PiAr
ICAgICBpZiAobCAhPSAoZHRfcm9vdF9hZGRyX2NlbGxzICsgZHRfcm9vdF9zaXplX2NlbGxzKSAq
IHNpemVvZihfX2JlMzIpKQo+PiArICAgICAgICAgICAgIHJldHVybjsKPj4gKwo+PiArICAgICBz
Y3JhdGNoX3N0YXJ0ID0gZHRfbWVtX25leHRfY2VsbChkdF9yb290X2FkZHJfY2VsbHMsICZwKTsK
Pj4gKyAgICAgc2NyYXRjaF9zaXplID0gZHRfbWVtX25leHRfY2VsbChkdF9yb290X2FkZHJfY2Vs
bHMsICZwKTsKPj4gKwo+PiArICAgICBwID0gb2ZfZ2V0X2ZsYXRfZHRfcHJvcChub2RlLCAibGlu
dXgsa2hvLW1lbSIsICZsKTsKPj4gKyAgICAgaWYgKGwgIT0gKGR0X3Jvb3RfYWRkcl9jZWxscyAr
IGR0X3Jvb3Rfc2l6ZV9jZWxscykgKiBzaXplb2YoX19iZTMyKSkKPj4gKyAgICAgICAgICAgICBy
ZXR1cm47Cj4+ICsKPj4gKyAgICAgbWVtX3N0YXJ0ID0gZHRfbWVtX25leHRfY2VsbChkdF9yb290
X2FkZHJfY2VsbHMsICZwKTsKPj4gKyAgICAgbWVtX3NpemUgPSBkdF9tZW1fbmV4dF9jZWxsKGR0
X3Jvb3RfYWRkcl9jZWxscywgJnApOwo+PiArCj4+ICsgICAgIGtob19wb3B1bGF0ZShraG9fc3Rh
cnQsIHNjcmF0Y2hfc3RhcnQsIHNjcmF0Y2hfc2l6ZSwgbWVtX3N0YXJ0LCBtZW1fc2l6ZSk7Cj4+
ICsjZW5kaWYKPj4gK30KPj4gKwo+PiAgICNpZmRlZiBDT05GSUdfU0VSSUFMX0VBUkxZQ09OCj4+
Cj4+ICAgaW50IF9faW5pdCBlYXJseV9pbml0X2R0X3NjYW5fY2hvc2VuX3N0ZG91dCh2b2lkKQo+
PiBAQCAtMTMwNCw2ICsxMzQyLDkgQEAgdm9pZCBfX2luaXQgZWFybHlfaW5pdF9kdF9zY2FuX25v
ZGVzKHZvaWQpCj4+Cj4+ICAgICAgICAvKiBIYW5kbGUgbGludXgsdXNhYmxlLW1lbW9yeS1yYW5n
ZSBwcm9wZXJ0eSAqLwo+PiAgICAgICAgZWFybHlfaW5pdF9kdF9jaGVja19mb3JfdXNhYmxlX21l
bV9yYW5nZSgpOwo+PiArCj4+ICsgICAgIC8qIEhhbmRsZSBrZXhlYyBoYW5kb3ZlciAqLwo+PiAr
ICAgICBlYXJseV9pbml0X2R0X2NoZWNrX2tobygpOwo+PiAgIH0KPj4KPj4gICBib29sIF9faW5p
dCBlYXJseV9pbml0X2R0X3NjYW4odm9pZCAqcGFyYW1zKQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9vZi9rZXhlYy5jIGIvZHJpdmVycy9vZi9rZXhlYy5jCj4+IGluZGV4IDY4Mjc4MzQwY2VjZi4u
YTYxMmU2YmI4Yzc1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL29mL2tleGVjLmMKPj4gKysrIGIv
ZHJpdmVycy9vZi9rZXhlYy5jCj4+IEBAIC0yNjQsNiArMjY0LDM3IEBAIHN0YXRpYyBpbmxpbmUg
aW50IHNldHVwX2ltYV9idWZmZXIoY29uc3Qgc3RydWN0IGtpbWFnZSAqaW1hZ2UsIHZvaWQgKmZk
dCwKPj4gICB9Cj4+ICAgI2VuZGlmIC8qIENPTkZJR19JTUFfS0VYRUMgKi8KPj4KPj4gK3N0YXRp
YyBpbnQga2hvX2FkZF9jaG9zZW4oY29uc3Qgc3RydWN0IGtpbWFnZSAqaW1hZ2UsIHZvaWQgKmZk
dCwgaW50IGNob3Nlbl9ub2RlKQo+PiArewo+PiArICAgICBpbnQgcmV0ID0gMDsKPj4gKwo+PiAr
I2lmZGVmIENPTkZJR19LRVhFQ19LSE8KPiBkaXR0bwo+Cj4gVGhvdWdoIHBlcmhhcHMgaW1hZ2Ut
PmtobyBpcyBub3QgZGVmaW5lZD8KCgpDb3JyZWN0LCBpdCBpcyBub3QuIEJ1dCBJJ20gaGFwcHkg
dG8gaGF2ZSBhIGZldyBsb2NhbCB2YXJpYWJsZXMgdGhhdCBJIApzdGFzaCB0aGUgaW1hZ2UtPmto
byBjb250ZW50cyBpbnNpZGUgYW4gaWZkZWYgaW50byBzbyB3ZSBjYW4gYXQgbGVhc3QgCmNvbXBp
bGUgY2hlY2sgYWxsIGxpYmZkdCBpbnZvY2F0aW9ucy4KCgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2Vz
Y2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5n
ZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIK
U2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


