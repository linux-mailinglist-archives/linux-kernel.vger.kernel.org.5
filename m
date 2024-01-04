Return-Path: <linux-kernel+bounces-16301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28394823C74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E551F25ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BAF1DFE9;
	Thu,  4 Jan 2024 07:05:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6F1DDE7;
	Thu,  4 Jan 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.48] ) by
 ajax-webmail-mail-app4 (Coremail) ; Thu, 4 Jan 2024 15:04:56 +0800
 (GMT+08:00)
Date: Thu, 4 Jan 2024 15:04:56 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jeremy Kerr" <jk@codeconstruct.com.au>
Cc: "Jakub Kicinski" <kuba@kernel.org>, matt@codeconstruct.com.au, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: mctp: use deprecated parser in
 mctp_set_link_af
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <e5e0640094a4e594eda8c3f8a54eca6728e58510.camel@codeconstruct.com.au>
References: <20231228070258.3052422-1-linma@zju.edu.cn>
 <20240103174719.2b2c1565@kernel.org>
 <7cbc3044.688a7.18cd32c5f14.Coremail.linma@zju.edu.cn>
 <e5e0640094a4e594eda8c3f8a54eca6728e58510.camel@codeconstruct.com.au>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1ad2eb4b.68b90.18cd34a146c.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgAH2Z2ZWJZluXA8AA--.8668W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIKEmWVL-wSTQACsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gSmVyZW15LAoKPiAKPiBIaSBMaW4sCj4gCj4gPiAoMSkgd2lsbCBnZXQgQUZfTUNUUCB3
aXRoIG5sYV90eXBlKC4uLikgY2FsbCwgYW5kICgyKSB3aWxsIHRoZW4KPiA+IHBhc3NpbmcgYGFm
YCB0byBgbWN0cF9zZXRfbGlua19hZmAsIHdoaWNoIHdpbGwgZXhwZWN0IHRoZQo+ID4gYE5MQV9G
X05FU1RFRGAgZmxhZy4KPiAKPiBZb3UgY291bGQgc2V0IHRoYXQgZmxhZz8gSXQncyBub3QgZXhj
bHVzaXZlIHdpdGggdGhlIGF0dHJpYnV0ZSB0eXBlLgo+IEZyb20gbmV0bGluay5oOgo+IAo+ICAg
LyoKPiAgICAqIG5sYV90eXBlICgxNiBiaXRzKQo+ICAgICogKy0tLSstLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSsKPiAgICAqIHwgTiB8IE8gfCBBdHRyaWJ1dGUgVHlwZSAgICAg
ICAgICAgICAgICB8Cj4gICAgKiArLS0tKy0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKwo+ICAgICogTiA6PSBDYXJyaWVzIG5lc3RlZCBhdHRyaWJ1dGVzCj4gICAgKiBPIDo9IFBh
eWxvYWQgc3RvcmVkIGluIG5ldHdvcmsgYnl0ZSBvcmRlcgo+ICAgICoKPiAgICAqIE5vdGU6IFRo
ZSBOIGFuZCBPIGZsYWcgYXJlIG11dHVhbGx5IGV4Y2x1c2l2ZS4KPiAgICAqLwo+IAo+IFdoaWNo
IGlzIHdoYXQgd2UgZG8gd2l0aCBleGlzdGluZyB1c2Vyc3BhY2U6Cj4gCj4gICBodHRwczovL2dp
dGh1Yi5jb20vQ29kZUNvbnN0cnVjdC9tY3RwL2Jsb2IvNmFhNGIwNTJkL3NyYy9tY3RwLmMjTDU2
OUMxLUw1NjlDMQo+IAo+IENoZWVycywKCk9vcHMsIG15IGJhZC4gSnVzdCBrbm93IHRoYXQgdGhl
IG5sYV90eXBlIHdpbGwgbWFzayB3aXRoIGBOTEFfVFlQRV9NQVNLYC4gCgpTb3JyeSBmb3IgdGhl
IGJvdGhlci4gVF5UCgo+IAo+IAo+IEplcmVteQoKVGhhbmtzCkxpbg==

