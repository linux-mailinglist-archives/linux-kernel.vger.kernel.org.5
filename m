Return-Path: <linux-kernel+bounces-7298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0B81A51C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE0B1F28CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8FC41862;
	Wed, 20 Dec 2023 16:29:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE247765;
	Wed, 20 Dec 2023 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [10.181.222.206] ) by
 ajax-webmail-mail-app3 (Coremail) ; Thu, 21 Dec 2023 00:29:16 +0800
 (GMT+08:00)
Date: Thu, 21 Dec 2023 00:29:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <horms@kernel.org>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231220161742.GM882741@kernel.org>
References: <20231220075914.2426376-1-linma@zju.edu.cn>
 <20231220161742.GM882741@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <55cdc6e4.49734.18c880f5a2f.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgAHD3NcFoNl+xI2AQ--.40161W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQJEmV5gHkUowAasU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gU2ltb24sCgo+IAo+IFRoYW5rcyBMaW4gTWEsCj4gCj4gSSBhZ3JlZSB3aXRoIHlvdXIg
YW5hbHlzaXMsIHRoYXQgdGhlIHByb2JsZW0gd2FzIGludHJvZHVjZWQgaW4gdGhlCj4gY2l0ZWQg
Y29tbWl0LCBhbmQgdGhhdCBpdCBpcyByZXNvbHZlZCBieSB5b3VyIHBhdGNoLgo+IAoKVGhhbmtz
IGZvciB0aGUgZW5jb3VyYWdlbWVudC4KCj4gSG93ZXZlciwgYXMgdGhlcmUgaXMgbm8gdXNlci12
aXNpYmxlIGJ1ZyBJIGRvbid0IGJlbGlldmUgdGhpcyByZWFjaGVzCj4gdGhlIGJhciBmb3IgYSAn
Zml4JyBmb3IgTmV0d29ya2luZyBjb2RlLiBBY2NvcmRpbmdseSwgSSB0aGluayB0aGF0Cj4gdGhl
IEZpeGVzIHRhZyBzaG91bGQgYmUgZHJvcHBlZC4gQW5kLCBpbnN0ZWFkIGNpdGVkIGNvbW1pdCBj
YW4gYmUgbWVudGlvbmVkCj4gdXNpbmcgc29tZXRoaW5nIGxpa2UgIlRoaXMgcHJvYmxlbSB3YXMg
aW50cm9kdWNlZCBieSBjb21taXQgLi4uIi4KPiAKPiBBbHNvLCBhcyBJIGRvbid0IHRoaW5rIGl0
IGlzIGEgZml4IEkgdGhpbmsgaXQgc2hvdWxkIGJlIHRhcmdldGVkIGF0IHRoZQo+IG5ldC1uZXh0
IHRyZWU6Cj4gCj4gCVN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCB2WF0gLi4uCj4gCgpDb3B5IHRo
YXQuIFllYWgsIG9uY2UgdGhlIGVudW0gSUZMQV9CUklER0VfQ0ZNX0NDX1JESV9JTlNUQU5DRSBh
bmQgdGhlCklGTEFfQlJJREdFX0NGTV9DQ19DQ01fVFhfSU5TVEFOQ0Uga2VlcHMgdGhlIHZhbHVl
IDEsIGV2ZXJ5dGhpbmcgc2hvdWxkIHdvcmsKYXMgdXN1YWwuIEkgd2lsbCByZXNlbmQgdGhlIHBh
dGNoIGFzIHRvbGQuCgo+IFRoZSBhYm92ZSBuaXRzIG5vdHdpdGhzdGFuZGluZywKPiAKPiBSZXZp
ZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgo+IAoKUmVnYXJkcwpMaW4=


