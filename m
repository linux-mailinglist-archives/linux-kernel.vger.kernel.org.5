Return-Path: <linux-kernel+bounces-56020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FF84C500
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282031F23BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF11CD31;
	Wed,  7 Feb 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mf0noyJQ"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05A1CD26
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707287457; cv=none; b=fMKGrp4JZk/6TzNUymhWEMln34ofEwG4EFeLW9UTvano4H/rw/NZUrgv4+8iiABbcY9Nq5CPfGrCtJ01ixgye3XilIzmuQAgJzhOBt+yT0qhcjKXTxEmH/6ykWFs/DIxj4rFSm6eK84W4aAqJqXbbVDr03G4FjEdcSznnp63wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707287457; c=relaxed/simple;
	bh=zjUyccO5kmtnrNZbXgtpxlpwxekTnpaqHlECgsnZcgQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Em8EQAZcUVUvJcM52EWSyGfLpooyunOEYO/tibPwj/FpaBaHXl6Ma5LBGcW1oFMtB7dizA0az08Ib2c9NrNpi+u5YNpz/P6LMrZqS5V3KK0FTwFjhTwvdImsNUF5lUzdT1UidOEOuv3yP6cNf60I/OaIIJoY1VBIcq1OWen/38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mf0noyJQ; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 4D1E61C0006E;
	Wed,  7 Feb 2024 01:30:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Feb 2024 01:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707287452; x=1707373852; bh=fVw80QJFLPYfWbj4U+oHv7nKjKhE
	pJo5GSFwl//HtDQ=; b=mf0noyJQ3Bn4VWIfZ7NXg/B2I3uVlcJHSYda4lTfoDzD
	5NnpjeyZnuuYImDXLTmr2B11pAcGnnVTjC8csx3l5drIh6oTLHDSbA+XtvTabj4n
	NMGdEY6PQcdbV2mFTyDiGegRgLSsDuEO9UkG58j4FjF1ag5qzYHOzoGGZNl2Y29W
	S7ogfsQfphH57UM/2cOPFTDlocfZLnB0fN2xAtpSYPg9JgUmnByM18njP9gdib/K
	5GcM92sIpRcFBRL5r/azFJ1eZnP6171lSHxefGQgDN2vN416cgBggsaN4k9dn9eA
	E0nmWNMkUJ7m8RZmRPucHh6LoezoE94fJfD38NucIg==
X-ME-Sender: <xms:myPDZY95qD8LBMsOf29A9ZYGyB2Jz6rJoQvfst-5IW5213b41e2pQw>
    <xme:myPDZQtYvNG8C4-diJspRWr3U578BJ02esnipOh6rIb0s0YG7jMjjBeHFEJlw19qv
    _7MSNoegHYfXNFnWGk>
X-ME-Received: <xmr:myPDZeC2zy-ZtpP5MuMMHS2Ed7SogVAnYFr_7q1Spcvi1s0uZQtfirlx-ojAZuKoZc475zWChpnJ6MedIErakmZY7t4jEt82Ivo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:myPDZYeJIRVhzNos9TaAtbCBFZuzcsNgt3RCtKo3JhLHrKwN69iKSA>
    <xmx:myPDZdOcjjfvA8O2uuR_EZzcGcXOaecgeUmxRV_j_r2NnbJPwGcpvA>
    <xmx:myPDZSn0CNYwor8j0cYNNViF-te9y7UZwsUQBaPMsCOrYVHHXC88hQ>
    <xmx:nCPDZezsi9dlmzAfzlICL4EfiW2fWA6vGVBKvhIZFv3MZ1hA1XruHLSJe2E>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 01:30:49 -0500 (EST)
Date: Wed, 7 Feb 2024 17:31:08 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
cc: David Laight <David.Laight@aculab.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Yury Norov <yury.norov@gmail.com>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Douglas Anderson <dianders@chromium.org>, 
    Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Marco Elver <elver@google.com>, Brian Cain <bcain@quicinc.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    "Paul E . McKenney" <paulmck@kernel.org>, 
    "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
In-Reply-To: <CAMZ6RqLkCPuy+mQxp0HuVBgfSiFgFOwimYm1Ro7ESANyF-fRyg@mail.gmail.com>
Message-ID: <ca9bd701-1cd0-94b9-e8cb-4a4328dea58a@linux-m68k.org>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr> <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org>
 <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com> <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com> <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com> <77831c6f-7fc9-c42d-b29b-c3b2f3f5e687@linux-m68k.org>
 <CAMZ6RqLyRxvUiLKZLkQF1cYFkdOqX73V2K=dGbNROMDj61OKLw@mail.gmail.com> <002675b0-6976-9efa-6bc5-b8bad287a1d2@linux-m68k.org> <CAMZ6RqKx=EO9kcOmxRyBuhULdDyTCeAXz25j_uF7TSy72Jahpw@mail.gmail.com> <00a7e866-23ff-fc63-b6df-364580f69c78@linux-m68k.org>
 <CAMZ6RqLkCPuy+mQxp0HuVBgfSiFgFOwimYm1Ro7ESANyF-fRyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Mon, 5 Feb 2024, Vincent MAILHOL wrote:

> On Mon. 5 Feb. 2024 at 18:48, Finn Thain <fthain@linux-m68k.org> wrote:
> > On Mon, 5 Feb 2024, Vincent MAILHOL wrote:
> >
> > If clang support is important then clang's builtins are important. So 
> > why not improve those instead? That would resolve the issue in a 
> > win-win.
> 
> I am deeply sorry, but with all your respect, this request is unfair. I 
> will not fix the compiler.
> 

Absolutely. It is unfair. Just as your proposal was unfair to maintainers. 
That patch would make a compiler deficiency into a maintenance burden.

