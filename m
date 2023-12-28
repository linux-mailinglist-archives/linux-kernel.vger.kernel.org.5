Return-Path: <linux-kernel+bounces-12388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3C81F40F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D0A1F21744
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239B137B;
	Thu, 28 Dec 2023 02:09:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C41EA9;
	Thu, 28 Dec 2023 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.51] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 28 Dec 2023 10:09:06 +0800
 (GMT+08:00)
Date: Thu, 28 Dec 2023 10:09:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/sched: cls_api: complement
 tcf_tfilter_dump_policy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <CAM0EoMm5ruiBfJC1C+Jvz=vuKz03e_KOS_jgbS7ETkSfV-SKDA@mail.gmail.com>
References: <20231224165413.831486-1-linma@zju.edu.cn>
 <CAM0EoMm8F3UE3N-PBZmJHQpYYjiV23JKf6jGsvzzWs0PBd+AWQ@mail.gmail.com>
 <6aab36aa.56337.18ca3c6af7a.Coremail.linma@zju.edu.cn>
 <CAM0EoMmBp6SWDGhPkusnx0jh4y=1k9ggS+5UpV+0MtEccDgyXw@mail.gmail.com>
 <CAM0EoMm5ruiBfJC1C+Jvz=vuKz03e_KOS_jgbS7ETkSfV-SKDA@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1869ff03.57bb7.18cae2eb8ad.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgDnDirD2IxlFBoTAQ--.46830W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIDEmWL9XsNeAABsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gSmFtYWwsCgo+ID4KPiA+IFNvcnJ5LCBzdGlsbCB0cnlpbmcgdG8gZm9sbG93IHlvdXIg
cmVhc29uaW5nIHRoYXQgdGhpcyBpcyBhICJuZXQgaXNzdWUiOgo+ID4gQXMgeW91IHBvaW50IG91
dCwgdGhlIHNrYiB3aWxsIGhhdmUgZW5vdWdoIHNwYWNlIHRvIGNhcnJ5IHRoZSAzMiBiaXQKPiA+
IHZhbHVlLiBXb3JzdCBjYXNlIGlzIHdlIHJlYWQgZ2FyYmFnZS4gQW5kIHRoZSBkdW1wLCB1c2lu
ZyB0aGlzIGdhcmJhZ2UKPiA+IGNoYWluIGluZGV4LCAgd2lsbCBub3QgZmluZCB0aGUgY2hhaW4g
b3Igd2lsbCBmaW5kIHNvbWUgdW5pbnRlbmRlZAo+ID4gY2hhaW4uIEFtIGkgbWlzc2luZyBzb21l
dGhpbmc/CgpUaGFua3MgZm9yIHlvdXIgcmVwbHlpbmcuIAoKSSBpbnZlc3RpZ2F0ZWQgdGhlIGNv
ZGUgYW5kIHllcywgYXMgeW91IHNhaWQsIHRoZSBza2IgZGF0YSB3aWxsIGNhcnJ5CmEgdGFpbGlu
ZyBzcGFjZSB1c2VkIGZvciBwdXR0aW5nIGBzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvYC4gSGVuY2Us
IDMyCmJpdCBpcyBub3QgZW5vdWdoIGhlcmUgdG8gY29uZHVjdCBhbiBvdmVyZmxvdyByZWFkIHRv
IG5leHQgb2JqZWN0LgoKSGVuY2UgSSBndWVzcyB5b3UgaGF2ZSBub3QgbWlzc2VkIGFueXRoaW5n
IGJ1dCBJIGRvLiBGb3IgdGhlCkNWRS0yMDIzLTM3NzMsIHRoZSByZWFkIHZhbHVlIGlzIGR1bXBl
ZCB0byB1c2VyLXNwYWNlIHNvIHRoZSBsZWFrIGlzCmRpcmVjdC4gQnV0IHNpbmNlIHRoZSBjaGFp
biBpbmRleCBpcyBub3QgZGlyZWN0bHkgZHVtcGVkCmludG8gdXNlcnNwYWNlLiBUaGUgYXR0YWNr
ZXIgY2FuIG9ubHkgZXhwbG9pdCB0aGlzIHZpYSBhIHNpZGUtY2hhbm5lbAptYW5uZXIuIEFzc3Vt
aW5nIHRoZSBhdHRhY2tlciBjb3VsZCBjcmVhdGUgYXMgbWFueSBjaGFpbiBhcyBoZSBjYW4KKDIq
KjMyIG1heWJlIDtQKSwgdGhlbiB0aGUgZHVtcCBmcm9tIHRoZSBnYXJiYWdlIGNoYWluIGluZGV4
IHdpbGwgbGVhawp0aGUga2VybmVsIGRhdGEgaW5kaXJlY3RseS4KCj4gPgo+ID4gQ2FuIHlvdSBz
ZW5kIG1lIGEgcmVwcm8gKHByaXZhdGVseSkgdGhhdCBhY3R1YWxseSBjYXVzZXMgdGhlICJoZWFw
Cj4gPiBkYXRhIGxlYWsiIGlmIHlvdSBoYXZlIG9uZT8KPiAKPiBUbyBjbGFyaWZ5IHdoYXQgdHJp
Z2dlcmVkIG1lIGlzIHlvdXIgdGllIG9mIHRoaXMgYXMgYW4gZXhwbG9pdCBhbmQKPiBxdW90aW5n
IENWRXMuIE1heWJlIG5vdCBzbyBtdWNoIG5ldCB2cyBuZXQtbmV4dC4KClRoZXJlIG1heSBiZSBh
IG1pc3VuZGVyc3RhbmRpbmcgaGVyZS4gSSBkaWRuJ3Qgd3JpdGUgc3VjaCBhIHNpZGUtY2hhbm5l
bApleHBsb2l0IGhlcmUgYW5kIGFzIHlvdSBwb2ludCBvdXQsIHRoaXMgaXMgbm90IGFuIGVhc3kg
YW5kIHdvcnRoeSB0YXNrLgooYnV0IElmIHlvdSBhcmUgYXNraW5nIHRoZSBleHBsb2l0IGZvciBD
VkUtMjAyMy0zNzczLCBJIHdpbGwgaW5mb3JtIHlvdQogd2hlbiBpdCBpcyBzZW5kIHRvIG9zcy1z
ZWN1cml0eSkKCkFueXdheSwgSSBiZWxpZXZlIHlvdSBhcmUgcmlnaHQuIEdpdmVuIHRoZSBmYWN0
IHRoYXQgSSBpZ25vcmUgdGhlCmRpZmZpY3VsdHkgb2YgdGhpcyBleHBsb2l0YXRpb24sIHN1Y2gg
YSBidWcgcmF0aGVyIHRoYW4gYSB2dWxuZXJhYmlsaXR5CnNob3VsZCBnbyB0byBuZXQtbmV4dCBp
bnN0ZWFkIG9mIG5ldC4gCgpTaGFsbCBJIGFkZCBhbnkgdGFnIGZyb20geW91IGxpa2UgU3VnZ2Vz
dGVkIG9yIFJldmlld2VkPwoKPiBjaGVlcnMsCj4gamFtYWwKPiAKClRoYW5rcwpMaW4=

