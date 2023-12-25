Return-Path: <linux-kernel+bounces-11118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807F881E185
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E265282005
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E251952F73;
	Mon, 25 Dec 2023 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="go7oppXX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FE52F61;
	Mon, 25 Dec 2023 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703520462; x=1735056462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qHYtE5J76pY6+pfStg0q/+w1NticYUAenhuLViOG8j0=;
  b=go7oppXXAXdpj6B2mMPhsQbOoB3Z1T6BliySbtS5bU36kPes+W/guVwF
   gTfh2IJSwN4znx33KtlUtsG5Jzsam9OKZNTr027RL3FrHaul9xX3ckCQQ
   HOVH3c9oipsiceHha9nROPoXgNoAw97/GyvnsgGwHafBdYwi8W8K+VXlg
   U=;
X-IronPort-AV: E=Sophos;i="6.04,303,1695686400"; 
   d="scan'208";a="627635697"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 16:07:40 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id 92C198071B;
	Mon, 25 Dec 2023 16:07:36 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:42133]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.144:2525] with esmtp (Farcaster)
 id f49d12a5-aaa6-4630-a218-ea8017a839ed; Mon, 25 Dec 2023 16:07:35 +0000 (UTC)
X-Farcaster-Flow-ID: f49d12a5-aaa6-4630-a218-ea8017a839ed
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Dec 2023 16:07:35 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Dec
 2023 16:07:32 +0000
Message-ID: <363ca575-f01a-4d09-ae9d-b6249b3aedb3@amazon.com>
Date: Mon, 25 Dec 2023 17:07:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] misc: Add Nitro Secure Module driver
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, Olivia Mackall
	<olivia@selenic.com>, Petre Eftime <petre.eftime@gmail.com>, Erdem Meydanlli
	<meydanli@amazon.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Jason Wang <jasowang@redhat.com>, "Xuan
 Zhuo" <xuanzhuo@linux.alibaba.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
References: <20231011213522.51781-1-graf@amazon.com>
 <20231225090044-mutt-send-email-mst@kernel.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20231225090044-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IE1pY2hhZWwsCgpPbiAyNS4xMi4yMyAxNTowNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+IE9uIFdlZCwgT2N0IDExLCAyMDIzIGF0IDA5OjM1OjIyUE0gKzAwMDAsIEFsZXhhbmRlciBH
cmFmIHdyb3RlOgo+PiBXaGVuIHJ1bm5pbmcgTGludXggaW5zaWRlIGEgTml0cm8gRW5jbGF2ZSwg
dGhlIGh5cGVydmlzb3IgcHJvdmlkZXMgYQo+PiBzcGVjaWFsIHZpcnRpbyBkZXZpY2UgY2FsbGVk
ICJOaXRybyBTZWN1cml0eSBNb2R1bGUiIChOU00pLiBUaGlzIGRldmljZQo+PiBoYXMgMyBtYWlu
IGZ1bmN0aW9uczoKPj4KPj4gICAgMSkgUHJvdmlkZSBhdHRlc3RhdGlvbiByZXBvcnRzCj4+ICAg
IDIpIE1vZGlmeSBQQ1Igc3RhdGUKPj4gICAgMykgUHJvdmlkZSBlbnRyb3B5Cj4+Cj4+IFRoaXMg
cGF0Y2ggYWRkcyBhIGRyaXZlciBmb3IgTlNNIHRoYXQgZXhwb3NlcyBhIC9kZXYvbnNtIGRldmlj
ZSBub2RlIHdoaWNoCj4+IHVzZXIgc3BhY2UgY2FuIGlzc3VlIGFuIGlvY3RsIG9uIHRoaXMgZGV2
aWNlIHdpdGggcmF3IE5TTSBDQk9SIGZvcm1hdHRlZAo+PiBjb21tYW5kcyB0byByZXF1ZXN0IGF0
dGVzdGF0aW9uIGRvY3VtZW50cywgaW5mbHVlbmNlIFBDUiBzdGF0ZXMsIHJlYWQKPj4gZW50cm9w
eSBhbmQgZW51bWVyYXRlIHN0YXR1cyBvZiB0aGUgZGV2aWNlLiBJbiBhZGRpdGlvbiwgdGhlIGRy
aXZlcgo+PiBpbXBsZW1lbnRzIGEgaHdybmcgYmFja2VuZC4KPj4KPj4gT3JpZ2luYWxseS1ieTog
UGV0cmUgRWZ0aW1lIDxwZXRyZS5lZnRpbWVAZ21haWwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+IEFsZXggYXJlIHlvdSBnb2luZyB0byBw
dWJsaXNoIHRoZSBzcGVjIHBhdGNoIGZvciB0aGlzIGRldmljZT8gIEltcG9ydGFudAo+IHNvIHdl
IGRvbid0IG5lZWQgdG8gZ3Vlc3MgYXQgYmVoYXZpb3VyIHdoZW4gZS5nLiAgbWFraW5nIGNoYW5n
ZXMgdG8KPiB2aXJ0aW8gQVBJcy4gIEFsc28sIHdoaWNoIHRyZWUgZG8geW91IHdhbnQgdGhpcyB0
byBnbyB0aHJvdWdoPwoKClRoZSBzcGVjIHBhdGNoIGluY2x1ZGluZyBwaW5nIG1haWwgYXJlIHNp
dHRpbmcgb24gdGhlIHZpcnRpby1jb21tZW50cyAKbWFpbGluZyBsaXN0IHNpbmNlIE9jdG9iZXIu
IEkgaGF2ZW4ndCBzZWVuIGFueSByZXBseSB1bmZvcnR1bmF0ZWx5IDooCgpodHRwczovL2xvcmUu
a2VybmVsLm9yZy92aXJ0aW8tY29tbWVudC8yMDIzMTAyNTIzNTM0NS4xNzc4OC0xLWdyYWZAYW1h
em9uLmNvbS8KCkhhcHB5IHRvIHJlYWQgZmVlZGJhY2sgaWYgeW91IGhhdmUgYW55IDopLgoKVGhp
cyBwYXRjaCBoZXJlIGlzIGFscmVhZHkgYXBwbGllZCBpbiBHcmVnJ3MgbWlzYyB0cmVlIHdoaWNo
IEknbSBoYXBweSAKdG8gaGF2ZSBpdCB0cmlja2xlIHRvIExpbnVzIHRocm91Z2guCgoKQWxleAoK
CgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgK
MTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9u
YXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50
ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK


