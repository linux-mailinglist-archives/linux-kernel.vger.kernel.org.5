Return-Path: <linux-kernel+bounces-149627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1518A93A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111571F22D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D839FDD;
	Thu, 18 Apr 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kHMXESl3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXh/6N4b"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E52CCC2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423624; cv=none; b=rT/8hZ9d7SZGucwUBdjSfnMgsLtXTqPyKiLtvU0TWUVyaB65ZglqDh4zzMfmpNsTJrdK6K6HN2IyepJm0RIcFnmakUZx4Ukz/lSt2PTPo/BpmnOvWB8stMwlUxezqb+anpC2tRWmw04ETHHjznXtDw0wA0nykSf/YO9w02B9xSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423624; c=relaxed/simple;
	bh=60KQnMRsZltNeF3WdPaOHWiTq74SekOkOIysB6X5Wv0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ffixiDQ9o3dazzbL+thV3Bt54ovQ8ufBWmPBT8tYtUFI7MeM7O8O5bYku8yh7CbYtnyuXJYh9cOCjTBNtX3GAGoLW/2cJ0mgkDFqioSH/lH3vQFpHPmhJI14sOKsXuxS6FI0nVhewzS/nMzACDv7KAIIyYSQTLTfEhJ0IONrvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kHMXESl3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXh/6N4b; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A8A881C00191;
	Thu, 18 Apr 2024 03:00:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 18 Apr 2024 03:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713423614; x=1713510014; bh=KbwfIs/6Rd
	Z169pWLYEvYHb3ipb41NqCczuUbSCEOtU=; b=kHMXESl38JFREZFyRJU/hhID99
	e5wf7SLLXpyo9VQI/ZfBb8n8s2Io+riBvulUuy7sycVkoy/p142vHqKuuUEAwroU
	3/P7QIMsgmHPxDQNIm0FWJQf224unfL7BKe/Vf6H08e2oQZQ89OnxIDhES5tX2I1
	KARD2IrClQHpPDpW7iu2Fklbbp+yoexldewV0MsdSl9FlTGi/WenvIVGVZN+0hmh
	BlEFF29+wsml8l5RYhDbdNYFxuQ2It6SF4d75ZVLMD8tVDR/XEjw+BLNnj3DOjM5
	NqjcXK5uEIWElTEyIy+oIJcitcxZzxxHcWDOHtUGi63L3IdN6GpgU/TQGulA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713423614; x=1713510014; bh=KbwfIs/6RdZ169pWLYEvYHb3ipb4
	1NqCczuUbSCEOtU=; b=iXh/6N4bWlks9FcbDfFX3qRLp7064tMTwKDCO3ZNY+J4
	h9b8HTUpragYfJmZOR6RKhkxnroEx5sf+EqpyiKOzuMprP5AY/uiRysmwEt20c+z
	k1EJ9fInFWstN5A200FDv/5RMXTg0XTK8uyIysqkqnvsBLWNKCx7OI1ZUTHkoeGm
	ha3rvRvXYptu6IwWi5qvUp2XdvFvQa1z8b7IiwclKASuHdyz8Dzz3qHytC5orvdo
	sNqgYGlaM31f/NMd7lveKdFSGwQ8hpZLrlAqkjqTDaH2Z3PXJg+wopIyQV3Z2jRM
	LBzS0B4xZkuTl/TSy8ZCrQ0gWWpONKGtTAcNlt+ROQ==
X-ME-Sender: <xms:_cQgZtExQWF1vEtmI-j1NgrNOOK6QYI4hbm8iz3ZZDL9Z-KpUWjX0A>
    <xme:_cQgZiUYJm5yGmRI7W1bIqb4eG9Jm_Sjli87tqqmYkqYHnCxel-5uDm9kmAeHBBAD
    jKvnfc1QbK4CfkeYTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejledgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_cQgZvLdZW-AwjeAIS_AGEYOBjLQVGOJ7Nt3QE2kBw1gNc2b2-5FMw>
    <xmx:_cQgZjFYwq9Rk9HXz6uYzviwGUjGLIAL1uRoLpRc2Dopi5Rj_4Qp4Q>
    <xmx:_cQgZjVXa3huu584Ghls8Qm-9KeqHgKrFKF9pAfJjmbcdpUEA7808A>
    <xmx:_cQgZuNb0JHfCZpnJfAeqD1EonV81n3gs2Hx9whI0l7rebP5Jm2UGw>
    <xmx:_sQgZg2KJAffrwszZxlTZgPiracHu0cXhTyNKvm7rj0Fj7JIu9eirDus>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 96D7EB6008F; Thu, 18 Apr 2024 03:00:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <59473eb6-1707-4bbf-85a3-ba4835f3ee7f@app.fastmail.com>
In-Reply-To: <878r1bb2zj.fsf@mail.lhotse>
References: <20240416153331.1617772-1-arnd@kernel.org>
 <878r1bb2zj.fsf@mail.lhotse>
Date: Thu, 18 Apr 2024 08:59:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Kees Cook" <keescook@chromium.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 clang-built-linux <llvm@lists.linux.dev>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Baoquan He" <bhe@redhat.com>, "Mike Rapoport" <rppt@kernel.org>
Subject: Re: [PATCH] powerpc: drop port I/O helpers for CONFIG_HAS_IOPORT=n
Content-Type: text/plain

On Thu, Apr 18, 2024, at 08:26, Michael Ellerman wrote:
> Arnd Bergmann <arnd@kernel.org> writes:

> @@ -692,6 +692,7 @@ static inline void name at                          
>         \
>  #define writesw writesw
>  #define writesl writesl
>
> +#ifdef CONFIG_HAS_IOPORT
>  #define inb inb
>  #define inw inw
>  #define inl inl
> @@ -704,6 +705,8 @@ static inline void name at                          
>         \
>  #define outsb outsb
>  #define outsw outsw
>  #define outsl outsl
> +#endif // CONFIG_HAS_IOPORT
> +
>  #ifdef __powerpc64__
>  #define readq  readq
>  #define writeq writeq

I had included this at first, but then I still ran into
the same warnings because it ends up pulling in the
generic outsb() etc from include/asm-generic/io.h
that relies on setting a non-NULL PCI_IOBASE.

      Arnd

