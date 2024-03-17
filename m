Return-Path: <linux-kernel+bounces-105411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360887DD88
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E4928134E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C5179B1;
	Sun, 17 Mar 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="d++mfXKP"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9491370
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686990; cv=none; b=eG6zZu4if2YuAl8SsJtI7W6HXZ4oATeHWQgO/A4/rvSZ41kg5bSLNxjLRSgeZFiO0yfN4LCAgRe0VyZIPqH7cynNoSXn6dz4aVSf5FoBjcs0Tzn3IZZ0Cb2NL9KQHX/xQDK3cmgyrE52SZXiGRZ47GGFGrG/bmpyv3U2bjiQujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686990; c=relaxed/simple;
	bh=I/2I6GO1ABrZISXKJlTvH42fIJoP4ISS9lq18Gfz4fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k7qXIh9WWThZd+b/px42SRiQZ0PkImQp9EM3uK//FAwet0ILT3BcQByrz6exkDo1LRI+aXRPSa3vM8BzM/0UKt1jeFh2s0x215mBtTR0FOA0goIxL1rsfPpLWvDR6HA5n3J2VSqSjlZ8RxgFviJ3BBEOnN+PvkvFy3vAodtnHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=d++mfXKP; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id lroJrJQ3lykpTlroJrgbHG; Sun, 17 Mar 2024 15:48:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710686916;
	bh=HoAJ2N+lKPSB/EwqfVG9puZB7cvWePgKg8IcOh52WhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=d++mfXKPIGGGbwfARQr2ZQeNXZ124wRdtELB2zugPXUs8GPrsJXCxsZH8dvYWwG5d
	 WK+ptk0Xo2RDFYY0P7fXlaCuVlnat8IL2ooBoGI0ExdmFAFCeKVXMOA8A6TmwEHCo8
	 XiQyK7+0eGJOBKtQPFOCs6Tl6qboN0bO8Avlh/5LTdIPH7RrZF11JZXVmKwOCS91tb
	 KUQr7mQ2Tekg38daENiQUelkA/029iGyIA8vtEnHQz55n8glNQjJnp3koICsyTijW5
	 Few30LWBPPrTYOOj7SdMYvgtpcK/S1ZS0BZmbEjIOQ2yoyeB6doKH6R/u7AYtDVDPQ
	 YMwC/3K4ANqKA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Mar 2024 15:48:36 +0100
X-ME-IP: 92.140.202.140
Message-ID: <7e5d6e69-5f65-4b70-8220-6d98457ed17a@wanadoo.fr>
Date: Sun, 17 Mar 2024 15:48:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/14] fork: zero vmap stack using clear_page() instead of
 memset()
Content-Language: en-MW
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
 brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
 dave.hansen@linux.intel.com, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
 jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
 kent.overstreet@linux.dev, kinseyho@google.com,
 kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
 peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
 rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
 urezki@gmail.com, vincent.guittot@linaro.org
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-7-pasha.tatashin@soleen.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240311164638.2015063-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/03/2024 à 17:46, Pasha Tatashin a écrit :
> In preporation for dynamic kernel stacks do not zero the whole span of

Nit: preparation

> the stack, but instead only the pages that are part of the vm_area.
> 
> This is because with dynamic stacks we might have only partially
> populated stacks.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   kernel/fork.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

..


