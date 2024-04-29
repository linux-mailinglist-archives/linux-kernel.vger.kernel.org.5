Return-Path: <linux-kernel+bounces-161683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B18B4F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3641F217C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017751851;
	Mon, 29 Apr 2024 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s9WHkqZa"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B8376
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714357832; cv=none; b=G2jH4HTiM2yP9lCiqausTRhKLOrxXmxReLEEnZkuAP3GL4jt12j0iVeZYEY+YxJSUXzIQPTH6rqZ+t6fQc+sDEquZ6qbC6HooRVJxV4pHOmpMjJ7MGmRK+T65g7g9J2ZwYdjam3RxWRN1vtXfOZaK6szhKslsd0y/cVVQGny6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714357832; c=relaxed/simple;
	bh=3ohJ3/2hrxmI8wIW26hyhWEdxBpoWnozaUBh1OBgC5Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WIFk6n2VhXaNz3FnJV5SxGtEol/jL7UB1fEcuX6xdjGGOlouTBDJ2vl6fAY6/yrv+MCykpWFUSP4y3mxWla2Qh/5pojyCNW0Hxg5WmBoIdG7ML57o0hL9TFNgwOE5yQQX5ShJJwXMDgm/DHcY4ca1sQ8Xk0XLJjIf0+zj71yoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s9WHkqZa; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714357520; bh=g/W9MeVv6E272U0RiQZkE7LuD/jReUyY/39514QJAjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s9WHkqZabR7FnhMdajGDJsc2ZQV7/ayoAB2V9pV6ARj9uCPus1HASJKRO3hr5YWwB
	 dcsBqlpSSljqPDwyJzb+iaxCa0pQQyGKGfwursq2mOLUVuniAplGOsiQQcJJ/TtJdx
	 Tx3eAD2ziQazXR8HLobnlQtSdcBvhyQTfih2+bms=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 65112406; Mon, 29 Apr 2024 10:25:17 +0800
X-QQ-mid: xmsmtpt1714357517t7qfl32cq
Message-ID: <tencent_7D666329DA16C3E9303F1DB5A06B0AB2A407@qq.com>
X-QQ-XMAILINFO: MtM+4b/on8CsByaGpei1ONbA9jExRLHmGwvWQNPx1a1uCjbAKj/xXbClsNv0o8
	 3umyoJS4ldbaSd7SoT8O5UAf6YRKtdBXqx3duoBuonlLxIYw0QfW389Ua1sWmT+z2kvYHmjcKkfe
	 81g+BjWE8HZmYbnh8IfdFaLFlKEEapFwtpfIDBeDYYt4wJFcI7A1IiPEBBPsvkhmVhrdvhXf09fJ
	 GG+g/W2CVvp6JfFmBv1agMW/irYwz6i2N1+ohSGvgMJdfaVPXoNypK44jnVJoStqyf1jhZP/zJFK
	 PCRmtf3tD01Le3RSkn5pyyFXEUtN96pvhWFzZJY+KYSWYlH47njqDpK551vPXoWOylmaz1+bAshm
	 bQ3zN1GRtfTjpn4qn2dI3ATFelqbkBrtV8ruhaohoR8toffpMaTZRyNFVmjScmNb19X1X6qO1M/A
	 xJ6TVqrugZcdgJvWNKJJvf07IH92TNiuSR9/yfaVmxkiUwrXERu5FcwA6peAprU8DQRV4QHdnEc0
	 rARL1e7iYe1YrNo7bwBXstf9epaHVRoaQf4MD5sc5IPcjSvxeWKlyqnfHxTMyW3SjBWCg0Dq0SVy
	 WYt1pAmymRH92o9ySe2foKr2P8E/Yu9chGwfm9nQsqYTlAiSFp38wRMjjyIVQyV9ydqX+KWPj0T3
	 Bl18NzMuMhra8MydwE77rLXKP4SWPG5iw4Sy7rR7BsCmaD726M440s+bijJ5AVcojA4vmlHn7N3M
	 zGluW+fTjwaFTEIN9WZ9Wi24CtY7qVLhoBEf2LVTva8/NLqziXTyzs7D2uwFDfx2cQ3FAHkiHA7u
	 LAqJsfHqfQnyL92xC4NrwA+WAhxI/590o5NtaC31pj89kq0+bWOWqlLW7bP57xaJk1j+eiU1FIzx
	 lDJX7br0ZOm2Nv367huOeE5zoT5kNaQhNY2EyDnVVKR5I21PcCjepkTuV87izSS14niJhu3dLYAJ
	 VKuK5trBXN+hJuXHx5HRl93jOubGZWDYhwgEd3mRf97hyDj273obqMmk9TrnjirkELwcb1C8umtW
	 drcaQ1r3Ewt0WtA/Z+P8NOZNqIt9mv+lbez3fE5A==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: linke li <lilinke99@qq.com>
To: rientjes@google.com
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	penberg@kernel.org,
	roman.gushchin@linux.dev,
	vbabka@suse.cz,
	xujianhao01@gmail.com
Subject: Re: [PATCH] mm/slub: mark racy access on slab->freelist
Date: Mon, 29 Apr 2024 10:25:15 +0800
X-OQ-MSGID: <20240429022515.46685-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <1096134d-df6f-185d-240f-8a774d66f98f@google.com>
References: <1096134d-df6f-185d-240f-8a774d66f98f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks!  Do you have a data race report to copy+paste into the commit 
> description so people can search for it if they stumble across the same 
> thing?

I don't have a data race report, just try to analyze the code statically
and then check it manually. I hope I could help in some way.


