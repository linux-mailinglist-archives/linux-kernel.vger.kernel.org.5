Return-Path: <linux-kernel+bounces-112600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7F887BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B46B215A9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B31426E;
	Sun, 24 Mar 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LMmX2Wtf"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7CB1400B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259811; cv=none; b=jYjIdmpTaHcIv0YUeXLMppgljBkBKjbj0CfJYzrhJLgphZQjqmAjtgARUNtk/VhXcv6xn57Y9SFVqAZbL7E3SvHM+4H2D6vNRDdVPt2OMCIE3+hTsZisVqyG9bWLYAMMeZqXisrtHIlO7KPiq/t3VDes5HT9QbgvbjY92N3wCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259811; c=relaxed/simple;
	bh=80I/5pg3H1ehHV01Vk+ZHXcpFin7u2L7+MULyGoWeYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=T2NnOba8Te9p/SvI61Bx7lpKydDD8qJk5Q/2Z9IQCwoHToPujgtQmU9gFfjOzkTkTyLUiUhUHmHhjjUK+rjFDZrkScT6bocjCtRN/2WWryUETJh6dAyklz/IaRc/aDWOzVC8drvecFFM+Yf/uIPVD+NDX6Q3VN/vetjLp4WqYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LMmX2Wtf reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=biOXgItTq7jL61jZpF3CQmlemZXSC4W3Dg0pVfk+bm0=; b=L
	MmX2WtfUlC46Kg6ZUL0hM4NNkuFucKxo0wEwkMVcB9xlgQUUu+0kR6dEX/+lq43s
	yOuVjg+N7OcGCyDyZZZnCmPKspo4Zi9YW5AsxUU8q0SLye7FskngqsmqyaLqLu4j
	OUP08PwyFcT5LcBoBg/l+fX3PsBg4JILdLOuMEy8IM=
Received: from lumingyindetect$163.com ( [106.39.130.76] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Sun, 24 Mar 2024 13:56:23 +0800
 (CST)
Date: Sun, 24 Mar 2024 13:56:23 +0800 (CST)
From: lumingyindetect@163.com
To: "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re:Re: [PATCH] tools:Fix a memory leak related to variable name
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240323182209.xqzb6rsswvfbg74n@treble>
References: <20240323084526.662556-1-lumingyindetect@163.com>
 <20240323182209.xqzb6rsswvfbg74n@treble>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3fd102c3.9f9.18e6f0812a1.Coremail.lumingyindetect@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v9qHwP9lYAwQAA--.6252W
X-CM-SenderInfo: poxpx0hj1l0vphwhu3i6rwjhhfrp/1tbiKRar92VOCH1F9QACsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsmbmJzcDt5b3UmbmJzcDtmb3ImbmJzcDt5b3VyJm5ic3A7cHJvbXB0Jm5ic3A7cmVzcG9u
c2UhJm5ic3A7SXQmbmJzcDtpcyZuYnNwO2luZGVlZCZuYnNwO2EmbmJzcDt3aXNlJm5ic3A7ZGVj
aXNpb24mbmJzcDtub3QmbmJzcDt0byZuYnNwO3JlbGVhc2UmbmJzcDtkeW5hbWljJm5ic3A7bWVt
b3J5Jm5ic3A7d2hlbiZuYnNwO3RoZSZuYnNwO3Rvb2wmbmJzcDtydW5zJm5ic3A7YnJpZWZseSZu
YnNwO2FuZCZuYnNwO2VuY291bnRlcnMmbmJzcDtlcnJvcnMuJm5ic3A7SG93ZXZlciwmbmJzcDtJ
Jm5ic3A7YWxzbyZuYnNwO25vdGljZWQmbmJzcDtpbiZuYnNwO3RoZSZuYnNwO2Rpc2FzX2Z1bmNz
Jm5ic3A7ZnVuY3Rpb24mbmJzcDtpbiZuYnNwO3RoZSZuYnNwOy9saW51eC90b29scy9vYmp0b29s
L2NoZWNrLmMmbmJzcDtmaWxlJm5ic3A7KGxpbmUmbmJzcDs0NjE3KSZuYnNwO3RoYXQmbmJzcDth
Jm5ic3A7dmFyaWFibGUmbmJzcDtuYW1lZCZuYnNwO2NtZCZuYnNwO3BvaW50aW5nJm5ic3A7dG8m
bmJzcDthJm5ic3A7ZHluYW1pYyZuYnNwO21lbW9yeSZuYnNwO2FyZWEmbmJzcDtpcyZuYnNwO25v
dCZuYnNwO2JlaW5nJm5ic3A7ZnJlZWQmbmJzcDsocmVnYXJkbGVzcyZuYnNwO29mJm5ic3A7d2hl
dGhlciZuYnNwO2FuJm5ic3A7ZXJyb3ImbmJzcDtvY2N1cnMpLiZuYnNwO0luJm5ic3A7dGhpcyZu
YnNwO2Nhc2UsJm5ic3A7d291bGQmbmJzcDtpdCZuYnNwO2JlJm5ic3A7bmVjZXNzYXJ5Jm5ic3A7
dG8mbmJzcDthZGQmbmJzcDthJm5ic3A7ZnJlZShjbWQpPwrlnKggMjAyNC0wMy0yNCAwMjoyMjow
Oe+8jCJKb3NoIFBvaW1ib2V1ZiIgPGpwb2ltYm9lQGtlcm5lbC5vcmc+IOWGmemBk++8mgpPbiBT
YXQsIE1hciAyMywgMjAyNCBhdCAwNDo0NToyNlBNICswODAwLCBMdU1pbmdZaW4gd3JvdGU6DQo+
IEluIHRoZSBlbGZfY3JlYXRlX3ByZWZpeF9zeW1ib2wgZnVuY3Rpb24gZGVmaW5lZCBpbiB0aGUg
L2xpbnV4L3Rvb2xzL29ianRvb2wvZWxmLmMgZmlsZSwgdHdvIHBvaW50ZXIgdmFyaWFibGVzIHN5
bSBhbmQgbmFtZSBhcmUgZGVmaW5lZC4gVGhlIHByb2dyYW0gYWxsb2NhdGVzIGR5bmFtaWMgbWVt
b3J5IGZvciB0aGUgcG9pbnRlciBzeW0gdXNpbmcgdGhlIGNhbGxvYyBmdW5jdGlvbiBhdCBsaW5l
IDgyMiwgYW5kIGZvciB0aGUgcG9pbnRlciBuYW1lIHVzaW5nIHRoZSBtYWxsb2MgZnVuY3Rpb24g
YXQgbGluZSA4MjQuIFdoZW4gdGhlIGlmIHN0YXRlbWVudCBhdCBsaW5lIDgyNiByZXR1cm5zIHRy
dWUsIHRoZSBwcm9ncmFtIHJldHVybnMgYXQgbGluZSA4MjguIFRoZSBjb250ZW50IG9mIHRoZSBp
ZiBzdGF0ZW1lbnQgYXQgbGluZSA4MjggaXMgaWYgKHN5bT09TlVMTCB8fCBuYW1lPT1OVUxMKSwg
d2hpY2ggY2hlY2tzIGlmIGVpdGhlciBzeW0gb3IgbmFtZSBpcyBOVUxMLiBJZiB0aGlzIGNvbmRp
dGlvbiByZXR1cm5zIHRydWUsIGl0IGluZGljYXRlcyBhIHNpdHVhdGlvbiB3aGVyZSBvbmUgb2Yg
dGhlIHBvaW50ZXJzIGhhcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIG1lbW9yeSBidXQgdGhlIG90
aGVyIGhhcyBub3QuIFRoZXJlZm9yZSwgaWYgdGhlIGlmIHN0YXRlbWVudCByZXR1cm5zIHRydWUs
IGRpcmVjdGx5IHJldHVybmluZyBtYXkgbGVhZCB0byBtZW1vcnkgbGVhayBpc3N1ZXMuIEhlbmNl
LCBpbiB0aGUgY29kZSwgSSBoYXZlIGFkZGVkIGNoZWNrcyBzZXBhcmF0ZWx5IGZvciB3aGV0aGVy
IHN5bSBhbmQgbmFtZSBhcmUgTlVMTCwgYW5kIGlmIHRoZXkgYXJlIG5vdCBOVUxMLCB0aGUgY29y
cmVzcG9uZGluZyBkeW5hbWljIG1lbW9yeSBzcGFjZXMgYXJlIGZyZWVkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTHVNaW5nWWluIDxsdW1pbmd5aW5kZXRlY3RAMTYzLmNvbT4NCg0KVGhhbmtzIGZv
ciB0aGUgcGF0Y2guICBJbiBnZW5lcmFsIHdlIGRvbid0IGNhcmUgYWJvdXQgbWVtb3J5IGxlYWtz
IGluDQpvYmp0b29sIChwYXJ0aWN1bGFybHkgaW4gZXJyb3Igb3IgZXhpdCBwYXRocyksIGFzIGl0
J3MgYSBzaG9ydC1ydW5uaW5nDQp0b29sLiAgV2hlbiBpdCBleGl0cywgYWxsIHRoZSBtZW1vcnkg
d2lsbCBiZSBmcmVlZCBhbnl3YXkuICBTbyBpdCdzDQpmYXN0ZXIgdG8gbm90IGZyZWUgdGhlIG1l
bW9yeSBtYW51YWxseS4NCg0KLS0gDQpKb3NoDQo=

