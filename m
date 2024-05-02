Return-Path: <linux-kernel+bounces-166699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49E38B9E50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008FA1C20A45
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936815CD7B;
	Thu,  2 May 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lS1dmT+4"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D015D5A2;
	Thu,  2 May 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666580; cv=none; b=EM9N54hYV8XnHsOVF7ATkwb8NqgmudeGt4vJqpWBwnlTj/NicUy2XDt2lUSomNYohfR5S8MOMAPi5VPdzqdWMSEOKWBmJ3IExq0Yeto+9gHfhqR/1rjtzmAnNJ4HQwZp3jPzTbCIDvurSaLrYmVQuYhI5GIIQlB525LjG6ESkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666580; c=relaxed/simple;
	bh=Z2OYISWByIYzD9+VFOy92tbxhQNUhGkkVQwpims5ZzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYT0Oi/uD9t/q9SBOTQ2uIbJx8C5zikWGRaNfuYZUofcUzYerKk/shXZyOLwM3C47MbJLlEZ8buhBV4F6Zjd7nzRdj53DEs2tpAZR8opRoh7+JBn/8fXfmuPOKtYz1aAFF3/rimNzkij+3NNP4go4Jc72Dp7eJ2pal6l9J1rAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lS1dmT+4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BF4A847C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714666577; bh=Z2OYISWByIYzD9+VFOy92tbxhQNUhGkkVQwpims5ZzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lS1dmT+4kkmazaFSuYX7qLUHNjOR2lDwQQBqpWZH5RBEKGx9bq5LYcWIiBEPqjOfg
	 h555z/2OTXG36oBqdrpFy5lGsjZ4qT7k9XSGVurs0GxKW3NYRiH8X8N0QOzNH0XJ5J
	 uzM/xx4nb4NPFtM2Aa0/gDoFhCkivBYGf52B3HSxKIXPkzK6aJXPRyDYnJ9h6A/h4s
	 qE6j62idbOoa6iI0FrE75a7toL1m6RbvDMLTL3GwrphGhDKuEWFkQvLAR2FtQasDlq
	 /MEmdZFydHFUBc3ju19MR+mPW1gyXAzrfkrq0oQZXDAQ26vKpSkp1aPtoJ27tPRgUw
	 gsKy9fLtAZOuA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BF4A847C39;
	Thu,  2 May 2024 16:16:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: remove two inconsistent spaces
In-Reply-To: <20240427053703.2339727-1-dzm91@hust.edu.cn>
References: <20240427053703.2339727-1-dzm91@hust.edu.cn>
Date: Thu, 02 May 2024 10:16:16 -0600
Message-ID: <87bk5o6vfz.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

RG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4gd3JpdGVzOg0KDQo+IFRoZSBzcGFjZXMg
b24gdGhlIGxlZnQgYW5kIHJpZ2h0IG9mIHRleHRzIHNob3VsZCBiZSBjb25zaXN0ZW50Lg0KPiBS
ZW1vdmUgdGhlc2UgcmVkdW5kZW50IHNwYWNlcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRG9uZ2xp
YW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9pbmRleC5yc3QgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy96aF9DTi9pbmRleC5yc3QNCj4gaW5kZXggNmNjZWM5NjU3Y2M2Li4yMGI5ZDQyNzBkMWYg
MTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJz
dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QNCj4g
QEAgLTI0LDggKzI0LDggQEANCj4gIOS4iueahGxpbnV4LWRvY+mCruS7tuWIl+ihqOOAgg0KPiAg
DQo+ICDpobrkvr/or7TkuIvvvIzkuK3mlofmlofmoaPkuZ/pnIDopoHpgbXlrojlhoXmoLjnvJbn
oIHpo47moLzvvIzpo47moLzkuK3kuK3mloflkozoi7HmlofnmoTkuLvopoHkuI3lkIzlsLHmmK/k
uK3mlocNCj4gLeeahOWtl+espuagh+eCueWNoOeUqOS4pOS4quiLseaWh+Wtl+espuWuveW6pu+8
jCDmiYDku6XvvIzlvZPoi7HmlofopoHmsYLkuI3opoHotoXov4fmr4/ooYwxMDDkuKrlrZfnrKbm
l7bvvIwNCj4gLeS4reaWh+WwseS4jeimgei2hei/hzUw5Liq5a2X56ym44CC5Y+m5aSW77yM5Lmf
6KaB5rOo5oSPJy0n77yMJz0nIOetieespuWPt+S4juebuOWFs+agh+mimOeahOWvuem9kOOAguWc
qOWwhg0KPiAr55qE5a2X56ym5qCH54K55Y2g55So5Lik5Liq6Iux5paH5a2X56ym5a695bqm77yM
5omA5Lul77yM5b2T6Iux5paH6KaB5rGC5LiN6KaB6LaF6L+H5q+P6KGMMTAw5Liq5a2X56ym5pe2
77yMDQo+ICvkuK3mloflsLHkuI3opoHotoXov4c1MOS4quWtl+espuOAguWPpuWklu+8jOS5n+im
geazqOaEjyctJ++8jCc9J+etieespuWPt+S4juebuOWFs+agh+mimOeahOWvuem9kOOAguWcqOWw
hg0KPiAg6KGl5LiB5o+Q5Lqk5Yiw56S+5Yy65LmL5YmN77yM5LiA5a6a6KaB6L+b6KGM5b+F6KaB
55qEIGBgY2hlY2twYXRjaC5wbGBgIOajgOafpeWSjOe8luivkea1i+ivleOAgg0KDQpBcHBsaWVk
LCB0aGFua3MuDQoNCmpvbg0K

