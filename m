Return-Path: <linux-kernel+bounces-51930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EEA849171
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B469282888
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696EBE5D;
	Sun,  4 Feb 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCmEcMdh"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D292BE49
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088403; cv=none; b=Ixxm+n+ozHplzzsnc6hsHmUl0pGZZYcUQKIb9zAiC5DhCY8NsE4bAxSpx7cwUcsVmMTADBweJqbat3YVN7f2cGSqvg1R1tqUb1MoqrOG+901qOdtEAlD9bKS+4AC4ivsNrnR5BGQcYK0nhAmgXG9ENNlDbs0FJ9aaVk6ga6/BEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088403; c=relaxed/simple;
	bh=ip3/aLvpwB6hh59hlGaCKqqPuqApfThsV9cH/ZQcw0A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QRe2SPEgxGV0yfJhsetGPNYBI93X7szqA4KvEZ6EheQSUiQxEHd22JMNIUmTNZrEHzg2rdzI0eGLEBTUIH3R+J83xfznOC82wXgSMJDJ0dKkLGrDBj+6bAJh0j9dhNSEG0YoVEQMzSVK4bSGtRGAI7wYyjA4Zjb7n2FgFHSK2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCmEcMdh; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id BD8C032002D8;
	Sun,  4 Feb 2024 18:13:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 04 Feb 2024 18:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707088398; x=1707174798; bh=oNkBOhK2M/xkfV+ZHmGOMVnjckv8
	IiPoAgUeewZaHlo=; b=mCmEcMdhttWavMs/bUZGT3gXSu1BdyYEOPbN7sxehE4T
	Dotka4LmTGURKACazRnoeWyJ1MnLZpAOSUw6wdQ/QsKhSeBri/PfZrY0z0SpJ/i0
	H426bNPEznV7xErv/dOBS59BmRU6bQpgD/0MD+KJzHBlgme+zGgIyosefYoWSTB9
	kGWUz/vRmOjrrIE46EszHZM5d9ZlhUrvQU06LCcOmVKgBeDyOEXAztiSAbbLU1u4
	0O8diF92lB45dOIrLEVsbm0JnVNtYsW8ez9eXhthCcrZrXX5VHfsCfq6zbSYQxul
	IMOmLhIS3i+1I8p5zFqrr53ZUy6j7uU5Wq0xDJeQLg==
X-ME-Sender: <xms:DBrAZTIh3MGNRIbT5wzgeagScl_QVb_KAbCJsXMWuM0oFJr0NZtGog>
    <xme:DBrAZXIqm45S-VB4Cs8qRyVhpA9uYGE5WOqT2md2zitQgusoSoscG8BZlkK0SICIF
    SjIH858vs-Gbfk1GkA>
X-ME-Received: <xmr:DBrAZbvWqxSoTqbPW4Ahu61ZOJt1lKHPrDdGvADGFc42wt3XOpSgwx4loTlNR_IZxo81YCMxmGdTG0t0IbbiEYZgUq2CQy9-PUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetueekgffgudeitdekiefhffeiheekffffveffgeeitefgteegjeeigeel
    tdehkeenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmhei
    kehkrdhorhhg
X-ME-Proxy: <xmx:DBrAZcbbXZP7Ubt2GWnsTfdqfmRJrHR9tI4ka-JQhi-BqzNNB33z2g>
    <xmx:DBrAZaY7Np2axbhYBeACq4cH8wRwcimAJp0PofOVVWGmntOhQbivJg>
    <xmx:DBrAZQAmnRstNkxEUWkFuLb2-oIkLi1A52OziIu9tNNxSfvTnmSCjw>
    <xmx:DhrAZfJ43rGvoT01Zpy89jpvDdNmS23G_2smVb9lPOArxMHmzCPing>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 18:13:12 -0500 (EST)
Date: Mon, 5 Feb 2024 10:13:26 +1100 (AEDT)
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
In-Reply-To: <CAMZ6RqLyRxvUiLKZLkQF1cYFkdOqX73V2K=dGbNROMDj61OKLw@mail.gmail.com>
Message-ID: <002675b0-6976-9efa-6bc5-b8bad287a1d2@linux-m68k.org>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr> <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org>
 <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com> <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com> <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com> <77831c6f-7fc9-c42d-b29b-c3b2f3f5e687@linux-m68k.org>
 <CAMZ6RqLyRxvUiLKZLkQF1cYFkdOqX73V2K=dGbNROMDj61OKLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 4 Feb 2024, Vincent MAILHOL wrote:

> Sorry for the late feedback, I did not have much time during weekdays.
> 
> On Monday. 29 Jan. 2024 at 07:34, Finn Thain <fthain@linux-m68k.org> wrote:
> > On Sun, 28 Jan 2024, Vincent MAILHOL wrote:
> > > > > The asm is meant to produce better results when the argument is not
> > > > > a constant expression.
> >
> > Is that because gcc's implementation has to satisfy requirements that are
> > excessively stringent for the kernel's purposes? Or is it a compiler
> > deficiency only affecting certain architectures?
> 
> I just guess that GCC guys followed the Intel datasheet while the
> kernel guys like to live a bit more dangerously and rely on some not
> so well defined behaviours... But I am really not the person to whom
> you should ask.
> 
> I just want to optimize the constant folding and this is the only
> purpose of this series. I am absolutely not an asm. That's also why I
> am reluctant to compare the asm outputs.
> 

How does replacing asm with a builtin prevent constant folding?

> > > ... The only thing I am not ready to do is to compare the produced
> > > assembly code and confirm whether or not it is better to remove asm
> > > code.
> > >
> >
> > If you do the comparison and find no change, you get to say so in the
> > commit log, and everyone is happy.
> 
> Without getting into details, here is a quick comparaisons of gcc and
> clang generated asm for all the bitops builtin:
> 
>   https://godbolt.org/z/Yb8nMKnYf
> 
> To the extent of my limited knowledge, it looks rather OK for gcc, but
> for clang... seems that this is the default software implementation.
> 
> So are we fine with the current patch? Or maybe clang support is not
> important for m68k? I do not know so tell me :)
> 

Let's see if I understand.

You are proposing that the kernel source carry an unquantified 
optimization, with inherent complexity and maintenance costs, just for the 
benefit of users who choose a compiler that doesn't work as well as the 
standard compiler. Is that it?

At some point in the future when clang comes up to scrach with gcc and the 
builtin reaches parity with the asm, I wonder if you will then remove both 
your optimization and the asm, to eliminate the afore-mentioned complexity 
and maintenance costs. Is there an incentive for that work?

