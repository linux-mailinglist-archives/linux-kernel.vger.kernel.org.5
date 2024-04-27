Return-Path: <linux-kernel+bounces-160921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B035B8B448D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11D81C227D7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781340875;
	Sat, 27 Apr 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="l369HSdO"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB41EB35;
	Sat, 27 Apr 2024 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714199802; cv=none; b=A2MtyPM1hwjynczKXuCGuCzso5wQs555oXB0isBoLy8Bm23wp8IF1vaIt3uaQOCYS68PYyFxc9ZuAZhIl/JG83GtXUoDPhC5j5iUQLO82TFS6YepYZFPes/VZeO9sG21z929+Rc9JWZRk94T1iIGw6R1C0BwIc8wcG705mEaPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714199802; c=relaxed/simple;
	bh=a1bsn8LeW8WYaCSjhSgQLzRN0bgswEy2GGuv3tEl1t4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=O0jAxtuqSwKwZJNtuMzMDLXS97qkGv4pZif6Gzs2bHl5CgO/js9cdO3IwaBOvU5Pfcl06KveJvcYIpU79eqzkDzRtCij83W6UiBRWaTggxcURASBHZGjLd86meghyYMo/mfPtAEX/ejpXcB++jq/iYRgytM9tmaVzFiNgXAznlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=l369HSdO reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Ph77mHkMAV6EC8WUFVL2f78n/OpbjO5BdB30c0GglaQ=; b=l
	369HSdOADlKtFv1bAurSuWm9XzoXL6r4uX6RH/XVwvSe4uuR7CwHrBb/uUDsQnUP
	uWp7imTJ6FXUW185ymadA8Z3RfKxNHeRKIb4s5Sm8VhYoJF0GwZ5M2u/B7EQqLf9
	CIqJk1VUl0NVuJdeGNyLf7e6nqRbEmf7/2kW1MhNWU=
Received: from slark_xiao$163.com ( [223.160.226.109] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Sat, 27 Apr 2024 14:35:33 +0800
 (CST)
Date: Sat, 27 Apr 2024 14:35:33 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH net] net: wwan: Add net device name for error message
 print
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <6f7c4b67-a6bd-4fc2-a7da-e4bb0c2b6f50@lunn.ch>
References: <20240426080733.819633-1-slark_xiao@163.com>
 <6f7c4b67-a6bd-4fc2-a7da-e4bb0c2b6f50@lunn.ch>
X-NTES-SC: AL_Qu2aBv2Stk8o5SecZukfmk8Sg+84W8K3v/0v1YVQOpF8jDzp9yw9XnB5OVHM/OS0Jw6ikSKtURNP8vlFR6BcXZMKVCnfz0I7ZBXCT/XekeCpMw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c5a7151.250c.18f1e4425f4.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H1y1nCxmmPgbAA--.35217W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRx-NZGV4JAZFkwABsZ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI0LTA0LTI3IDA2OjIxOjAzLCAiQW5kcmV3IEx1bm4iIDxh
bmRyZXdAbHVubi5jaD4gd3JvdGU6Cj4+ICAJaWYgKHNrYi0+bGVuIDwgc2l6ZW9mKHN0cnVjdCB1
c2JfY2RjX25jbV9udGgxNikgKwo+PiAgCQkJc2l6ZW9mKHN0cnVjdCB1c2JfY2RjX25jbV9uZHAx
NikpIHsKPj4gLQkJbmV0X2Vycl9yYXRlbGltaXRlZCgiZnJhbWUgdG9vIHNob3J0XG4iKTsKPj4g
KwkJbmV0X2Vycl9yYXRlbGltaXRlZCgibWJpbTogZnJhbWUgdG9vIHNob3J0XG4iKTsKPgo+SSBk
b24ndCBrbm93IHRoaXMgY29kZSBhdCBhbGwsIGJ1dCBpIHRoaW5rIHlvdSBjYW4gZG8KPgo+ZGV2
X2Vycl9yYXRlbGltaXRlZCgmbWJpbS0+bWRldi0+ZGV2LCAiZnJhbWUgdG9vIHNob3J0XG4iKTsK
Pgo+VGhhdCB3YXksIGl0IHRlbGxzIHlvdSB3aGljaCBvZiB0aGUgNDIgbWhpIGRldmljZXMgaGFz
IHJlY2VpdmVkIHRvbwo+c2hvcnQgYSBmcmFtZS4KPgo+ICAgICAgQW5kcmV3CkkgdHJpZWQgaW4g
bXkgY2FzZSwgYW5kIGl0IHdpbGwgcHJpbnQ6Cm1oaV93d2FuX21iaW0gbWhpb19JUF9IVzBfTUJJ
TTogZnJhbWUgdG9vIHNob3J0CgpJIHRoaW5rIGl0J3MgbXVjaCBtb3JlIGNvbXBsaWNhdGVkLCBp
c24ndCBpdD8KClRoYW5rcw==

