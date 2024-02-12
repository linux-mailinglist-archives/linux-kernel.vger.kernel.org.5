Return-Path: <linux-kernel+bounces-62524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D220852254
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C32840D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C44F214;
	Mon, 12 Feb 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="E8hi6jKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lV0RyuQI"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAF4EB49
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779690; cv=none; b=u3QgsOfyhqWu36pDRVArINUca0Vpb/wLjGCsnia7HgTcttmiyvobKPYWQmZ1lG2SIE7jX7FAPV4et4C7W4hv/oXTaApZKb+sS4e3gDBZpddRyZvCQ2DSuAmlLL5At/IESbZ14BiFctKUwubdD2GWWWp3W+qDhr6uHvQ4poovZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779690; c=relaxed/simple;
	bh=9nl15u7EBzbTLxafb5O8ds33OrCIC2ZYVzALBf14jdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqG0vxtKqdekJjnRaa7J93MuCcVQbDbX38koj4nkTTUfqPl9yoXtgj/x8abW9JwNGTUvZQ++tkJ/Ww0Zt9hg50cfqTQMvpVj1RFCyZkPv7LGw3i3azeVlEyP208w4Akfllvs0/fg3YXoF+MK9T9Sp5k9Mevc6hJDiW8OmzYVrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=E8hi6jKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lV0RyuQI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 234B511400BF;
	Mon, 12 Feb 2024 18:14:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Feb 2024 18:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707779687; x=1707866087; bh=QyGuhjRy2C
	AhPp7km2OtYzK7OMbyUKD1K9kuodelDyc=; b=E8hi6jKGC7rA0SsgSYRIHuVqRE
	IHWA3Wt/M2fbKg4GYN0xgmSMbTAEryvAN+aWjmxGCeeY6dID6tVAAM++UaaTG3I4
	A4qWcQl2mVq+2SvO4j2c7+3Gm98a9M2tRH1DX9xrr/E0vqd5X9JGc7UqFCMpi+sK
	t7htY3MBi5aPSALoKCvaMbAiEJfoDFE3lWcA7t+WmLC9bs+iLRYRHU8LAFfOEKvf
	YSlr+92GTQhZWrNFlPa54FbUi3jZJPz6DQyTWPgOTP/k/MCbMajTVz0KBGJNN2CG
	CMMsvolSfhnZ5b35+isqdvDSmnje4oK5Rd0s+OQVNy2tKi/gtxn2yDkR1CWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707779687; x=1707866087; bh=QyGuhjRy2CAhPp7km2OtYzK7OMby
	UKD1K9kuodelDyc=; b=lV0RyuQIiNznM5Xqt+T/9on7PaP5RtvH2+3ytxGoEAFQ
	4qusYD55GaO8fKcA2Py1QGjcx5Kr0ZtfxxA74CTdbxzuMAb168vOeEAlK0WhmKkS
	Ez2J2d241wfWw8wtEIUT6PnCI9EHviSjHOljJ8fWKGfHjfxetvCh5y0HdT51KHkj
	lvj7ElnBTJou78t/oonwNjzXPaOvVEwV1TrgYXx6MZReyBbvbFc/Hwk8VBTDUmj3
	Aeyz4/zUjTlMCxEZvL98Wsbks9XMKfdlDunfz78Mcwzzu+VKRHqFiOqIpXS6mfdm
	53+euS3cnDtFeYPGsGvFYYjXIADC97QxA4c7P80j3A==
X-ME-Sender: <xms:ZqbKZXKU-TTDGxNZSwiHmhJhSvQtXKCU35vYIK4JqMRCIXWIfdq26Q>
    <xme:ZqbKZbK8sMayL5pjBGojxMuJfXdtYdzQY6td4HQmcXZCd4lkGijYBDxizhhaAo2Ab
    IQTEp1eLq5Wh6asB0U>
X-ME-Received: <xmr:ZqbKZfubQKpnUnbq-b2UiqBXPCc99Bqo2W2uqd1lCpGxE2vSKAtu631dReL9StEEi_SnD5GN3L3xQyICTOmGqc9Tzhpl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeelveduteeghfehkeeukefhudfftefhheetfedthfevgfetleevvdduveet
    ueefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiii
    rg
X-ME-Proxy: <xmx:ZqbKZQZY7UN0XUknm3COUgmq_GIYdgkOp17MS38IP71pOEONaEcOvA>
    <xmx:ZqbKZeai7751ROZ2MRGLL2viN1edZsPLp35O1Cpl5A3Wp7zQ0_6-Vw>
    <xmx:ZqbKZUCcUbkMjvF4d0jwK6Fjd3Jhn_4U9SVXMYvAq1IVZL_Sz_Lm0w>
    <xmx:Z6bKZVU6BPTcrTDCqHKlDJSbm0XQB5ScZH09veozHma5scOvNj8J6g>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 18:14:46 -0500 (EST)
Date: Mon, 12 Feb 2024 16:14:45 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: user-trap: fix strict-aliasing warning
Message-ID: <ZcqmZdZ6x5w54nTI@tycho.pizza>
References: <20240212111737.917428-1-arnd@kernel.org>
 <170776334482.2557794.95461406898503535.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170776334482.2557794.95461406898503535.b4-ty@chromium.org>

On Mon, Feb 12, 2024 at 10:42:27AM -0800, Kees Cook wrote:
> On Mon, 12 Feb 2024 12:17:31 +0100, Arnd Bergmann wrote:
> > I started getting warnings for this one file, though I can't see what changed
> > since it was originally introduced in commit fec7b6690541 ("samples: add an
> > example of seccomp user trap").
> > 
> > samples/seccomp/user-trap.c: In function 'send_fd':
> > samples/seccomp/user-trap.c:50:11: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
> >    50 |         *((int *)CMSG_DATA(cmsg)) = fd;
> >       |          ~^~~~~~~~~~~~~~~~~~~~~~~
> > samples/seccomp/user-trap.c: In function 'recv_fd':
> > samples/seccomp/user-trap.c:83:18: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
> >    83 |         return *((int *)CMSG_DATA(cmsg));
> >       |                 ~^~~~~~~~~~~~~~~~~~~~~~~
> > 
> > [...]
> 
> Applied to for-next/seccomp, thanks!
> 
> [1/1] samples: user-trap: fix strict-aliasing warning
>       https://git.kernel.org/kees/c/9ad28ca5238d
> 
> Take care,

If you happen to update the trailers, looks good to me too:

Acked-by: Tycho Andersen <tandersen@netflix.com>

I also don't understand what changed, or why this really fixes it.
We're still "violating" strict aliasing as far as I can tell, since we
just introduce `int *fd_ptr` insted of memcpy()-ing out the fd into
an int?

But whatever shuts the compiler up works for me.

Tycho

