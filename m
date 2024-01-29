Return-Path: <linux-kernel+bounces-42856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43CF8407C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9811F273C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68465BA4;
	Mon, 29 Jan 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="kd9we4ei"
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C8657BD;
	Mon, 29 Jan 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536935; cv=none; b=brwcNFxN2hC+Fssp5ewyBwc8fOfM7k3W6LbJlA89htQTxw9dDfvoe5K6i+Y7Dy6PuXJJUmDa7xcj+ZC2nFrCb10NGHs/MU0kptvsZONnPlVvi0Tv7XdhJKbSKjnzk/t5QaqL0/Fh8G+GqETNlh96Lnj74BhlqiJlVeP+70Snoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536935; c=relaxed/simple;
	bh=+VoVBN2iZqimRDp8AEtjDqCiyh8Yx8XdDbWDp0n2jVE=;
	h=Message-ID:Date:MIME-Version:To:References:From:Cc:Subject:
	 In-Reply-To:Content-Type; b=tjqic8G0nzRhFEnVzO25xr1wwrm3E5w168K16Sd0ZDIK8z6/yEXpEXXFp+Lo+Bodotk0M9EmefA9byrWLBdCugw0t6sjOlN+kJ383Op/hStcivUSJK7n2QtHygeA4iNb1DOTJE8Q2ecEmGmXsaAiOna+HylBwOhC+6ZhOUIUP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=kd9we4ei; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:129d:0:640:2432:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTP id 2585260FCB;
	Mon, 29 Jan 2024 16:55:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QtYC59BOqSw0-34llu7cb;
	Mon, 29 Jan 2024 16:55:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706536527; bh=+VoVBN2iZqimRDp8AEtjDqCiyh8Yx8XdDbWDp0n2jVE=;
	h=In-Reply-To:Cc:To:References:From:Subject:Date:Message-ID;
	b=kd9we4eiJPi8VQTaK4wys6z5O+WS/jmzOGlufs6QuWtjF2CHYYsl7+3q/kEP9yIsX
	 Ty0X6XvoGGKyhFLPN6AsuvpLJLEpaDnS0t7jL6JcGZw/9vzvtE+85hKZjuqOSdk1f9
	 RkQGTGekSWU8GxSRPbc26zBqXJfB84qef62yqKk0=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <59378600-8d36-4958-8882-fa693fcad4d6@yandex.ru>
Date: Mon, 29 Jan 2024 16:55:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
References: <xebnh5c5rnfequ6khyhieugefrtt5mdftr6rsw522ocpg3yvln@tarta.nabijaczleweli.xyz>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: memcpy: detected field-spanning write (size 101) of single field
 "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2251
 (size 1)
In-Reply-To: <xebnh5c5rnfequ6khyhieugefrtt5mdftr6rsw522ocpg3yvln@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMS8yNi8yNCAyMjo0NywgQWhlbGVuaWEgWmllbWlhxYRza2Egd3JvdGU6DQoNCj4gWyAg
IDQxLjMxNDYzNF0gbWVtY3B5OiBkZXRlY3RlZCBmaWVsZC1zcGFubmluZyB3cml0ZSAoc2l6
ZSAxMDEpIG9mIHNpbmdsZSBmaWVsZCAiZXh0X3NjYW4tPnRsdl9idWZmZXIiIGF0IGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9zY2FuLmM6MjI1MSAoc2l6ZSAxKQ0K
DQpTaG9ydCBhbnN3ZXI6IGlmIHlvdXIgZGV2aWNlIHdvcmtzIGFzIGV4cGVjdGVkLCBtb3N0
IGxpa2VseSB5b3UgY2FuIGlnbm9yZSB0aGlzLg0KDQpMb25nIGFuc3dlcjogdGhpcyBpcyBj
YXVzZWQgYnkgdXNpbmcgQ09ORklHX0ZPUlRJRllfU09VUkNFIHdpdGggb2xkIHN0eWxlIG9u
ZS1lbGVtZW50DQooaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UpIG9yIHplcm8tbGVuZ3RoIGFy
cmF5IG1lbWJlcnMuIFNlZSAiWmVyby1sZW5ndGggYW5kIG9uZS1lbGVtZW50DQphcnJheXMi
IGF0IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3MvZGVw
cmVjYXRlZC5odG1sLiBVbmZvcnR1bmF0ZWx5DQptd2lmaWV4IGlzIG5vdCBjb21wbGV0ZWx5
IG1pZ3JhdGVkIHRvIEM5OS1zdHlsZSBmbGV4aWJsZSBhcnJheSBtZW1iZXJzOyBpZiB5b3Un
cmUgYnJhdmUNCmVub3VnaCwgeW91IGNhbiBoZWxwIHRoZSBtYWludGFpbmVycyBieSB0cnlp
bmcgdGhpczoNCg0KLS0tIGxpbnV4LTYuNi4xMS9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2
ZWxsL213aWZpZXgvZncuaAkyMDI0LTAxLTEwIDE5OjE3OjAyLjAwMDAwMDAwMCArMDMwMA0K
KysrIGxpbnV4LTYuNi4xMS9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgv
ZncuaAkyMDI0LTAxLTI5IDE0OjIxOjU1LjU3NDI4MDcxOSArMDMwMA0KQEAgLTE1ODYsNyAr
MTU4Niw3IEBADQoNCiAgc3RydWN0IGhvc3RfY21kX2RzXzgwMl8xMV9zY2FuX2V4dCB7DQog
IAl1MzIgICByZXNlcnZlZDsNCi0JdTggICAgdGx2X2J1ZmZlclsxXTsNCisJdTggICAgdGx2
X2J1ZmZlcltdOw0KICB9IF9fcGFja2VkOw0KDQogIHN0cnVjdCBtd2lmaWV4X2llX3R5cGVz
X2Jzc19tb2RlIHsNCg0KRG1pdHJ5DQoNCg==

