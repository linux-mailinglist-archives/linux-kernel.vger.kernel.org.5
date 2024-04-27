Return-Path: <linux-kernel+bounces-160913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0B8B4474
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2C91F22C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EEE40856;
	Sat, 27 Apr 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XP1msSCN"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D33613E;
	Sat, 27 Apr 2024 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714197601; cv=none; b=HJPK/Ya33EI4tBoBWeW7LBht8lYXYGL6Pnl1Uq2LGhDfBHo7yezSYLbVOChY5j8Q16+dyhJS3MFttQDCZ2tPoq9WYNVo2GkvCa1Kd9eh7OeqprO6iI2wWqz9eMSA9VKetODZCI1evSadYQalgKBcqlxlFZKfG4I3IcqZAMsgGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714197601; c=relaxed/simple;
	bh=BEP1UJpkxNSXEb7iK6TfpqEbFyfdQwsT3a8nHvQpbrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Fnft87jRQWg8vqIndcis5uXHfpUvn2pC72+YiK+Gd0szLRlegzOKnqSnRNtp+3sLIJ301r4VXqJNIJf0WBcAB4/mduVmGJ3egjj1xKsBE+g4i+jYX3rCL2ZkKcia/EMXRPEe2QHk2q8CMoC2ohNbu4nDkg7ZGUQ8ZMyvbdSvFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XP1msSCN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=BEP1UJpkxNSXEb7iK6TfpqEbFyfdQwsT3a8nHvQpbrg=; b=X
	P1msSCNdY8l98usDKt8qzWoPa9z4OmTinB98jxTdBOu8BurYCQLDcz21pehBR4ch
	A32Bsmv2cJUpX+Li4048UfLzGHefHKPUlg92JvtL75fr6C1yttMlFBCisMa51/KR
	XSw71WglAiQ/1PVHq/oVXABbHwvWGUKPsUqUJaM0IU=
Received: from slark_xiao$163.com ( [223.160.226.109] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Sat, 27 Apr 2024 13:57:36 +0800
 (CST)
Date: Sat, 27 Apr 2024 13:57:36 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@linaro.org>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Hariprasad Kelam" <hkelam@marvell.com>
Subject: Re:Re: [PATCH net v2] net: wwan: Fix missing net device name for
 error message print
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAMZdPi-VNEUJK+AUcyCXii5in6OLfKjxrNM1KHwQf=9QV_cqJA@mail.gmail.com>
References: <20240426092444.825735-1-slark_xiao@163.com>
 <CAMZdPi-VNEUJK+AUcyCXii5in6OLfKjxrNM1KHwQf=9QV_cqJA@mail.gmail.com>
X-NTES-SC: AL_Qu2aBv2SuEwu4CGfYOkfmk8Sg+84W8K3v/0v1YVQOpF8jDzp9yw9XnB5OVHM/OS0Jw6ikSKtURNP8vlFR6BcXZMKdLcRdJpHTKV5VL8XE7Ps7g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7f434e77.2191.18f1e216533.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_5jQkyxmjzgxAA--.45239W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRwPMZGV4I-vjXQADsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDQtMjYgMjA6MDQ6MzksICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5AbGlu
YXJvLm9yZz4gd3JvdGU6Cj5IZWxsbywKPgo+T24gRnJpLCAyNiBBcHIgMjAyNCBhdCAxMToyNSwg
U2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cm90ZToKPj4KPj4gSW4gbXkgbG9jYWws
IEkgZ290IGFuIGVycm9yIHByaW50IGluIGRtZXNnIGxpa2UgYmVsb3c6Cj4+ICJzZXF1ZW5jZSBu
dW1iZXIgZ2xpdGNoIHByZXY9NDg3IGN1cnI9MCIKPj4gQWZ0ZXIgY2hlY2tpbmcsIGl0IGJlbG9u
Z3MgdG8gbWhpX3d3YW5fbWJpbS5jLiBSZWZlciB0byB0aGUgdXNhZ2UKPj4gb2YgdGhpcyBuZXRf
ZXJyX3JhdGVsaW1pdGVkKCkgQVBJIGluIG90aGVyIGZpbGVzLCBJIHRoaW5rIHdlCj4+IHNob3Vs
ZCBhZGQgbmV0IGRldmljZSBuYW1lIHByaW50IGJlZm9yZSBtZXNzYWdlIGNvbnRleHQuCj4+Cj4+
IEZpeGVzOiBhYTczMGE5OTA1YjcgKCJuZXQ6IHd3YW46IEFkZCBNSEkgTUJJTSBuZXR3b3JrIGRy
aXZlciIpCj4KPlRoaXMgaXMgbW9yZSBhIGNvc21ldGljIGNoYW5nZSB0aGFuIGEgYnVnZml4LCB5
b3Ugc2hvdWxkIHRhcmdldCBuZXQtbmV4dCBJTU8uCj5BbHNvIGFzIHNhaWQgaW4gYW5vdGhlciBm
ZWVkYmFjaywgdGhlIGNvbW1pdCBtZXNzYWdlIGRvZXMgbm90IG1hdGNoIHRoZSBjaGFuZ2UsCj5z
aW5jZSB5b3UncmUgbm90IHByaW50aW5nIHRoZSBkZXZpY2UgbmFtZS4KQWdyZWUuIEJ1dCBpbiBz
b21lIGZ1bmN0aW9ucywgd2UgY2FuJ3QgY2FsbCB0aGUgbmV0IGRldmljZSBuYW1lIGRpcmVjdG9y
eSBmcm9tIHRoZQpwYXJhbWV0ZXJzIG9mIHRoaXMgZnVuY3Rpb24sIHN1Y2ggYXMgbWJpbV9yeF92
ZXJpZnlfbmRwMTYoKS4gVGhlcmUgaXMgbm8gKm1iaW0gb3IKKm5kZXYgb3IgKm1oaV9kZXYuIA==


