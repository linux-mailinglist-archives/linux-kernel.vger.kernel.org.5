Return-Path: <linux-kernel+bounces-99914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DBF878F26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB891282BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0B69970;
	Tue, 12 Mar 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XRgI0KAO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FFF6995B;
	Tue, 12 Mar 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229529; cv=none; b=HhyJvUt+T/1O9DfJiYhKSg5o6lzjAIS2hQmz/5RSwlmDs0PWQbFnMBaQ5wuCIt8sI83dfQ4rjEDBvdt+dve6RRTtQBiJd01cFc0my5UVl/YX32slHb8vYdgI2HRPcFZ6k/SG9Nz6SwmXnSV5/zdeEDhvgaZJh3z3vyFW0ElXrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229529; c=relaxed/simple;
	bh=V/3C99+SjfBu6YxPC7xYaJOXeNA/MjKY6uwJ3NULtF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5qUNPi8/kePUP2foH7lSH41pI0qMG9ftEaXO9lkpiG1hBB8CNnQHfulBo0EDyX/DZVJNHHKnNs6U4P0oLiJ2+RW4YU92+lvQRwxKfnhUYtA+uS3c93WtVnq4srwikm3tDI+9LU6fUudhLIP6AWKIcxqNrboA6h77Ir+ePcyNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XRgI0KAO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FE3F40E0196;
	Tue, 12 Mar 2024 07:45:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QCbY7VwbVN0h; Tue, 12 Mar 2024 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710229516; bh=7t6+HTXOBDKap6sFQU1Tk7yBPukO7meCgLOVL8iHZos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRgI0KAOeKttbfKSRzrmvdCJmQbt8aPzytSyPsM59Lzrw18bWh08pFy0IUzmRojoC
	 +k/Se8AwizadmmSeOlKW/uMAXfmnmHJj1kpwxWwGRQ5npiP4QiWvxZh0O4WykkWGMQ
	 6XQd9IHwVXv7GyknoUrgzlio3piyIgekaRKplzMye7dfLSG7sw7OHi8RmIMphKgX//
	 j58fv6DpZpMI6/82hxcWng0c3fVchvQN0NJMNNr22oT2xYgP+7QXBX4BDOpOYuHoV9
	 Ei65WxRRTGnq6YRo1cx/iqzLZNvUigIvNavH/RQ4RgqA68IxnXaYG6cWa8kPQYEXaH
	 000GwG7gfPYLFPfEQ54n8a7xvWikZSEtdgjaMPmwNs/2506TmRxcUzNQjDUabPR4NS
	 CqdDRCkKTEzbmGr+vMSZcuoCPmooNwaPkzFcfpBxa6PZQ4j42P1IRZ92exwWftr+EL
	 gwS+kkVAbYces82pGBP6yAxl+9hr1dRPZ/CKpJsjYQjiPyyDBYBqplaDzI/3WxW3sV
	 i5g8qkFsUWUnjyoHJwAa51Kut8tsL8rC5Ab/YiGZf2/6+OklGPcf2sF66TwR+1UPEQ
	 mvpZxHOqlv1W55QZGunCVXTrSI1WTxv8tArNbHY9ZD+JiUJaf9ghV1QuMlu8Tf+yoe
	 uTVBrTEbv1zWhWw3fM4MqlZw=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDAB640E016B;
	Tue, 12 Mar 2024 07:45:11 +0000 (UTC)
Date: Tue, 12 Mar 2024 08:45:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC updates for v6.9
Message-ID: <20240312074504.GAZfAIANxTdC5Tb0vb@fat_crate.local>
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
 <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>

On Mon, Mar 11, 2024 at 06:12:54PM -0700, Linus Torvalds wrote:
> Ho humm. Lookie here:
> 
>     static inline unsigned int topology_amd_nodes_per_pkg(void)
>     { return 0; };
> 
> that's the UP case.
> 
> Yeah, I'm assuming nobody tests this for UP,

Unless it gets randomly enabled in my randconfig builds once in a blue
moon, I'd say pretty seldomly. I've heard people raise the question
multiple times whether we should simply make CONFIG_SMP default y on x86
and frankly, it'll get rid of a whole bunch of stupid corner cases like
that...

> but it's clearly wrong to potentially do that modulus by zero.

Yep.

> So I made the merge also change that UP case of
> topology_amd_nodes_per_pkg() to return 1.
> 
> Because dammit, not only is a mod-by-zero wrong, a UP system most
> definitely has one node per package, not zero.

Yap, that's the the straight-forward thing to do, thanks for fixing it!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

