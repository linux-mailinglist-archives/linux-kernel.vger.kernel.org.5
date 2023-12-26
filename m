Return-Path: <linux-kernel+bounces-11312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6781E46E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF9628280A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54CEED8;
	Tue, 26 Dec 2023 01:39:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2868A2A;
	Tue, 26 Dec 2023 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.60] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 26 Dec 2023 09:39:16 +0800
 (GMT+08:00)
Date: Tue, 26 Dec 2023 09:39:16 +0800 (GMT+08:00)
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
In-Reply-To: <CAM0EoMm8F3UE3N-PBZmJHQpYYjiV23JKf6jGsvzzWs0PBd+AWQ@mail.gmail.com>
References: <20231224165413.831486-1-linma@zju.edu.cn>
 <CAM0EoMm8F3UE3N-PBZmJHQpYYjiV23JKf6jGsvzzWs0PBd+AWQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6aab36aa.56337.18ca3c6af7a.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgBnb3PFLopl8M14AQ--.43750W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIBEmWJUnsR6QABsu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gSmFtYWwsCgo+IAo+IENhbiB5b3UgY2xhcmlmeSB3aGF0ICJoZWFwIGRhdGEgbGVhayIg
eW91IGFyZSByZWZlcnJpbmcgdG8/Cj4gQXMgbXVjaCBhcyBpIGNhbiBzZWUgYW55IHJlZmVyZW5j
ZSB0byBOTEFfVENBX0NIQUlOIGlzIGNoZWNrZWQgZm9yCj4gcHJlc2VuY2UgYmVmb3JlIGJlaW5n
IHB1dCB0byB1c2UuIFNvIGZhciB0aGF0IHJlYXNvbiBJICBkb250IHNlZSBob3cKPiB0aGlzIHBh
dGNoIHF1YWxpZmllcyBhcyAibmV0Ii4gSXQgbG9va3MgbGlrZSBhbiBlbmhhbmNlbWVudCB0byBt
ZQo+IHdoaWNoIHNob3VsZCB0YXJnZXQgbmV0LW5leHQsIHVubGVzcyBpIGFtIG1pc3Npbmcgc29t
ZXRoaW5nIG9idmlvdXMuCj4gCgpTdXJlLCB0aGFua3MgZm9yIHlvdXIgcmVwbHksIChhbmQgbWVy
cnkgQ2hyaXN0bWFzIDpEKS4KSSBkaWRuJ3QgbWVudGlvbiB0aGUgZGV0YWlsIGFzIEkgY29uc2lk
ZXIgdGhlIGNvbW1pdCBtZXNzYWdlIGluCmA1ZTI0MjQ3MDhkYTdgIGNvdWxkIG1ha2UgYSBwb2lu
dC4gSW4gc2hvcnQsIHRoZSBjb2RlCgpgYGAKaWYgKHRjYVtUQ0FfQ0hBSU5dICYmIG5sYV9nZXRf
dTMyKHRjYVtUQ0FfQ0hBSU5dKQpgYGAKCm9ubHkgY2hlY2tzIGlmIHRoZSBhdHRyaWJ1dGUgVENB
X0NIQUlOIGV4aXN0cyBidXQgbmV2ZXIgY2hlY2tzIGFib3V0CnRoZSBhdHRyaWJ1dGUgbGVuZ3Ro
IGJlY2F1c2UgdGhhdCBhdHRyaWJ1dGUgaXMgcGFyc2VkIGJ5IHRoZSBmdW5jdGlvbgpubG1zZ19w
YXJzZV9kZXByZWNhdGVkIHdoaWNoIHdpbGwgcGFyc2UgYW4gYXR0cmlidXRlIGV2ZW4gbm90IGRl
c2NyaWJlZAppbiB0aGUgZ2l2ZW4gcG9saWN5IChoZXJlLCB0aGUgdGNmX3RmaWx0ZXJfZHVtcF9w
b2xpY3kpLgoKTW9yZW92ZXIsIHRoZSBuZXRsaW5rIG1lc3NhZ2UgaXMgYWxsb2NhdGVkIHZpYSBu
ZXRsaW5rX2FsbG9jX2xhcmdlX3NrYgooc2VlIG5ldC9uZXRsaW5rL2FmX25ldGxpbmsuYykgdGhh
dCBkb2VzIG5vdCBjbGVhciBvdXQgdGhlIGhlYXAgYnVmZmVyLgpIZW5jZSBhIG1hbGljaW91cyB1
c2VyIGNvdWxkIHNlbmQgYSBtYWxpY2lvdXMgVENBX0NIQUlOIGF0dHJpYnV0ZSBoZXJlCndpdGhv
dXQgcHV0dGluZyBhbnkgcGF5bG9hZCBhbmQgdGhlIGFib3ZlIGBubGFfZ2V0X3UzMmAgY291bGQg
ZGVyZWZlcmVuY2UKYSBkaXJ0eSBkYXRhIHRoYXQgaXMgc3ByYXllZCBieSB0aGUgdXNlci4KCk90
aGVyIHBsYWNlIGdldHMgVENBX0NIQUlOIHdpdGggcHJvdmlkZSBwb2xpY3kgcnRtX3RjYV9wb2xp
Y3kgdGhhdCBoYXMgYQpkZXNjcmlwdGlvbi4KCmBgYApbVENBX0NIQUlOXQkJPSB7IC50eXBlID0g
TkxBX1UzMiB9LApgYGAKCmFuZCB0aGlzIHBhdGNoIGFpbXMgdG8gZG8gc28uCgpVbmZvcnR1bmF0
ZWx5LCBJIGhhdmUgbm90IG9wZW5lZCB0aGUgZXhwbG9pdCBmb3IgQ1ZFLTIwMjMtMzc3MwooaHR0
cHM6Ly9hY2Nlc3MucmVkaGF0LmNvbS9zZWN1cml0eS9jdmUvY3ZlLTIwMjMtMzc3MykgeWV0IGJ1
dCB0aGUgaWRlYQppcyBzaW1pbGFyIGFuZCB5b3UgY2FuIHRha2UgaXQgYXMgYW4gZXhhbXBsZS4K
Cj4gY2hlZXJzLAo+IGphbWFsCj4gCgpSZWdhcmRzCkxpbg==

