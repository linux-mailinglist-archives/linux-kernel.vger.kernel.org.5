Return-Path: <linux-kernel+bounces-31299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57391832C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBA41F23E44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265145466A;
	Fri, 19 Jan 2024 15:10:06 +0000 (UTC)
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C667D54667;
	Fri, 19 Jan 2024 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677005; cv=none; b=vEZvtgZM0Y/qrEnN4kZXUeTyWUjSenCpjzMRamA90EM47JcxznCi46tGe2AC3nBBmRaNoqsumqQ0XS3q+8nUViab21X3xNCMEZUh2gqeerZdN612n7rcpVvjyiK8oXcVKCVkQntcGlIV8WJjBcNDWyKDDVMG87rCpEVVJR7R26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677005; c=relaxed/simple;
	bh=ba5iFZrEZbK7GW0T551/0XRnIqmHqQJuldW3vSrTCjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=itCyZPYyixEtNC/1inNFPpswPQ6usZEWH11AF0hmw/Di5aCUS/xqeeAUJRlnXtURJeEhL6hw2f2v7qPV+EzER1m0PlvAIN9iFx084umPOJoeOaKlDOp06lmvZtBEJD5ALM6BlIoQibDI/vIvHgoYsT4W5pcpF589hHodVrnfr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [10.181.209.189] ) by
 ajax-webmail-mail-app2 (Coremail) ; Fri, 19 Jan 2024 23:09:39 +0800
 (GMT+08:00)
Date: Fri, 19 Jan 2024 23:09:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Kalle Valo" <kvalo@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] nl80211/cfg80211: add nla_policy for S1G
 band
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <87v87pe5hu.fsf@kernel.org>
References: <20240119093724.7852-1-linma@zju.edu.cn>
 <6acb79fc.79d3.18d211a170c.Coremail.linma@zju.edu.cn>
 <87v87pe5hu.fsf@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7d20b254.7e26.18d22453bd2.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgA356WzkKplHXlmAA--.7489W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQFEmWpc04QogACsR
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gS2FsbGUsCgo+IAo+ICJMaW4gTWEiIDxsaW5tYUB6anUuZWR1LmNuPiB3cml0ZXM6Cj4g
Cj4gPiBIZWxsbyB0aGVyZSwKPiA+Cj4gPj4gT3VyIGRldGVjdG9yIGhhcyBpZGVudGlmaWVkIGFu
b3RoZXIgY2FzZSBvZiBhbiBpbmNvbXBsZXRlIHBvbGljeS4KPiA+PiAuLi4KPiA+Cj4gPiBJIG1h
cmsgdGhlIG5ldC1uZXh0IHRhZyBmb3IgdGhpcyBvbmUgYW5kIGEgcHJldmlvdXMgc2VudCBvbmUg
aW4gdGhpcwo+ID4gbW9ybmluZyAoW1BBVENIIG5ldC1uZXh0IHYxXSBuZWlnaGJvdXI6IGNvbXBs
ZW1lbnQgbmxfbnRibF9wYXJtX3BvbGljeSkuCj4gPgo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlm
IHN1Y2ggbmxhX3BvbGljeSBjb21wbGVtZW50aW5nIHNob3VsZCBnbyBuZXQgaW5zdGVhZC4KPiAK
PiBubDgwMjExIHBhdGNoZXMgZ28gdG8gd2lyZWxlc3Mgb3Igd2lyZWxlc3MtbmV4dC4KPiAKPiAt
LSAKPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3Mv
bGlzdC8KPiAKPiBodHRwczovL3dpcmVsZXNzLndpa2kua2VybmVsLm9yZy9lbi9kZXZlbG9wZXJz
L2RvY3VtZW50YXRpb24vc3VibWl0dGluZ3BhdGNoZXMKCk9LIEkgd2lsbCByZXNlbmQgYSB2ZXJz
aW9uIHdpdGggY29ycmVjdCBvbmUuCgpUaGFua3MKTGlu

