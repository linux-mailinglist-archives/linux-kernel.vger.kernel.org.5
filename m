Return-Path: <linux-kernel+bounces-75140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899985E3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ACD1F254BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199D839F7;
	Wed, 21 Feb 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TtIh+KFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7eS6y4Y"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BE7FBC4;
	Wed, 21 Feb 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534314; cv=none; b=YUC/cke21QQ4GnqVwIVNv+DHpmosemKUivEOtckGsc9EJd7BNSA7947pmE+ojSxdqL0/43KzQFzUvDrb0JJkSgK63MR4nJY4/C6KpYVE6kOYppQSa0BqdtF0TEQyQMeWB1a1WfJ9KxGoDP7X4jUeKxcVQQadc4eWfJIkCOiMekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534314; c=relaxed/simple;
	bh=2B3cm4x5f3k4huErcoSt8JiDBfGjHHMnN6/fCcegqYs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=T5SGrV7WiKz/1K6YpxUSxt0uwMcZjGX0fPljYCgftxpxkNefy0vnZuvuFREnI2vgp1c2wa4w2IpSBq2a48x3npZrExrnbouBy8gw9VKH0r3J9RdB5bAiBbve1t6lDCUc7xC9LdtJwUwRlHj5G9Hu9gmAKhjyeE66ckQCF0/AJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TtIh+KFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o7eS6y4Y; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2EC6632000EB;
	Wed, 21 Feb 2024 11:51:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 11:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708534310; x=1708620710; bh=eSn5xhAHi3
	xo/ygEBFEx2vlBfX3dDaFRWNt84Lii+ww=; b=TtIh+KFNlcpoiMVT9JYs3TJ82h
	FCPBXrrg3YbThVJJaZP9ySk8dVkOATUzjT4qnlHVg07WHCKj93DD6iU5rUoJKQy2
	AhnzsMWsvgIueFXt7FrzCvOQLoXFUovcf6wBgI1urfXhHfHnpVQWWWOEufO68dPM
	SF9Iikry56Gz3JEORdnvVEa7oyw4RuEsj7NyXLCglnOkT6H3HiJAF2V/uFh/Qpha
	1YOS/fvEjVzNAmFD3AWGHap8UPkq3kDkmRgvIvkYz8hK73Nb3GugB1dEJUvGEAr+
	9QU0BHVXKpF/3d/e3IMLMgQMXN9B5qyQf8YnKr8QSu0KzsnzwANMKhjGKb1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708534310; x=1708620710; bh=eSn5xhAHi3xo/ygEBFEx2vlBfX3d
	DaFRWNt84Lii+ww=; b=o7eS6y4YROWJ2CBZaF1INj2TnQmpqx8/fP7QHjbujumf
	7soDq96w8g3sXP4J4LMHom6ve8eCk41rWRnn4KuBBbiB+W3tAtTaLKtf+Uf7uxkn
	zBhcvuRrHxlE1vgSM7oC6TE+VYkpxnM2//tUJYhU44a2ipaSi2OwtQLxd5M0onQi
	stzcbznVgY3E91cm8elsgYSj3X7dVBbdLfS3pG6WTovxrxUR6Z/RQ52DDX4fXYub
	+EKF1erBq1+a9aWOJByCiWbHTw1Ik6kOFWKtN6/WEcA4uz47xI9Ag2fg2o8bLUuv
	uAXM0XC2BCpXlFPXJ+fdQmGfqVDrfi38Ati6ag+sGg==
X-ME-Sender: <xms:JirWZVbWPmJ9GNOOm_mJMPP9tUZqS6uudq54rVXLlkpqAr08Z4ff7Q>
    <xme:JirWZcaikLxuDlV1YYA5JAiLjcV7LWq1PKjhJ9sy1CYkB46cbQtb3DqNZzuo6aHRk
    UT01lcWwO5p3jpQ_1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JirWZX-Ku_VetAJ_2sUwnZ9Wq4npbouy_ACHghyDpFEYtX5ixKtpdA>
    <xmx:JirWZTp-PzPCT53yTxPuvkUkyyOEAAcEFkyEyiaMi9muM6h-UbIq8w>
    <xmx:JirWZQqfLMOrKjLVENli9pmFvsvLwyVWzvPoPtM7jCdJ7kWPDKjD_g>
    <xmx:JirWZccQ7nQC7MV1qyCI0qDnpPB668qnfr5xxsbjSIVTppK9fVfXYQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 45CEFB6008D; Wed, 21 Feb 2024 11:51:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <211c9e57-ed0b-4945-9194-ad776bc386bd@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtNbgy7C0bFhsptk9HfE-kxPf+gEpviL4=o1YePoY8xSw@mail.gmail.com>
References: 
 <CA+G9fYtNbgy7C0bFhsptk9HfE-kxPf+gEpviL4=o1YePoY8xSw@mail.gmail.com>
Date: Wed, 21 Feb 2024 17:51:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 lkft-triage@lists.linaro.org
Cc: "Kees Cook" <keescook@chromium.org>, "Hao Luo" <haoluo@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Justin Stitt" <justinstitt@google.com>
Subject: Re: x86: fortify-string.h:63:33: error: '__builtin_memcmp' specified bound
 exceeds maximum object size
Content-Type: text/plain

On Wed, Feb 21, 2024, at 16:32, Naresh Kamboju wrote:
> The x86 / i386 compilations encountered errors due to additional Kconfigs
> incorporated from the selftests/net/*/config in the Linux next version.
> The issue first appeared with the next-20240213 tag. This problem affects
> the Linux next branch, but not the mainline Linus master branch.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> The bisection points to the following commit id,
> # first bad commit: [64259ce2a20ce2dcc585a2cb83d1366fb04a6008] ubsan:
> reintroduce signed overflow sanitizer
>
> Build errors:
> -------------
> In function 'memcmp',
>     inlined from 'nft_pipapo_insert' at
> /builds/linux/net/netfilter/nft_set_pipapo.c:1258:7:
> /builds/linux/include/linux/fortify-string.h:63:33: error:
> '__builtin_memcmp' specified bound 18446744071562067968 exceeds
> maximum object size 9223372036854775807 [-Werror=stringop-overread]
>    63 | #define __underlying_memcmp     __builtin_memcmp
>       |                                 ^
> /builds/linux/include/linux/fortify-string.h:655:16: note: in
> expansion of macro '__underlying_memcmp'
>   655 |         return __underlying_memcmp(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

The size 18446744071562067968 is equal to (u64)INT_MIN, so something
goes wrong with the length conversion when a negative length
might be passed into memcmp().

I don't see any relevant changes to this file that
are likely causes, but these warnings are sometimes
sensitive to compiler optimization, so it's possible that
some unrelated change such as 7395dfacfff6 ("netfilter:
nf_tables: use timestamp to check for set element timeout")
just changed the inlining behavior in a way such that
either a warning is now detected when it was previously
hidden and the compiler now sees more about the
state, or it seems less about the state and can no longer
prove that this does not happen.

I have so far not seen the same issue in randconfig builds
on today's linux-next with gcc-13.2.0, but I would guess
that a patch like

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index aa1d9e93a9a0..c284522f64c4 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1252,11 +1252,12 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
        start_p = start;
        end_p = end;
        nft_pipapo_for_each_field(f, i, m) {
+               unsigned length = f->groups / NFT_PIPAPO_GROUPS_PER_BYTE(f);
+
                if (f->rules >= (unsigned long)NFT_PIPAPO_RULE0_MAX)
                        return -ENOSPC;
 
-               if (memcmp(start_p, end_p,
-                          f->groups / NFT_PIPAPO_GROUPS_PER_BYTE(f)) > 0)
+               if (memcmp(start_p, end_p, length)) > 0)
                        return -EINVAL;
 
                start_p += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);


will hide the issue again.

     Arnd

