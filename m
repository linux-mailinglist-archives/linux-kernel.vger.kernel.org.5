Return-Path: <linux-kernel+bounces-134089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453F89AD17
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2AB9B2174B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA4B4EB56;
	Sat,  6 Apr 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/zz+As5"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D283D0C5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712439498; cv=none; b=r1FbgW0bEeMyD5wPOIciFxfz820ha6w1lM3YXoJdxayyPqJ7nc64EbkTFlYLXld5IiN6j0Xps6DsGewfgFlC7/b5gpxY+fRZ1GRforG33JrhP1UxWaMWFDAVGRNNt6+VZAijULYCQqr3MtKJyhH5QA4uH2/Ez8WmicTU8Vw6Rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712439498; c=relaxed/simple;
	bh=mjNFYTaBY73y2ozYo7or/Op+Vg7N+GOw1btVYU5HJlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN+60j6QfUt+uuE/wgWi5r1UVPPDXL04ZuqFpigv65ahao9lNzsiRBZ7Cu5ov1/Mnxc2xtv+xKTs90vxGD2Xe+7znFuyn+m/uuSrNI3DgHMhM5W/DlQjc6Y7foLfCAxV7mNpuYn5F02bESomGUzsRiy6sf4EAih/f6FX6BhnHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/zz+As5; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Apr 2024 17:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712439493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dlnv5I4qWyf3Lu2lvWtlu9fYGTs9HNpCetI8IYnZPMw=;
	b=M/zz+As5utgnCcSEwo3F8GhIxMB8DuESCbcSLocnoDFPAzVy9kyjJ09rEGR1Kt8uON1RVW
	6C1lE/LveU338Gn1XeA/Uo62JhFBqh/lbYL0S16JywIlQSWwIQGxBE32iW81S+00UNPqSg
	c8MgKk5hNhbMqCN2WNLBe7NxJuPVjnk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Rename struct field swap to prevent macro
 naming collision
Message-ID: <aihoh7frnx5pf2qxlvcntfx4jazdn5m3vnse6q7yqexhqaaul3@luxph6dm5tbz>
References: <20240406141919.248148-2-thorsten.blum@toblux.com>
 <wvui43l6pcfexoglhyy4xfdjs4mrjzmbcwupnb4djlgvrebn7s@l22gudock5d6>
 <E5B1C1FA-0B85-49ED-8EE6-4F01FBA2AC99@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E5B1C1FA-0B85-49ED-8EE6-4F01FBA2AC99@toblux.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 06, 2024 at 11:21:37PM +0200, Thorsten Blum wrote:
> On 6. Apr 2024, at 20:48, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > On Sat, Apr 06, 2024 at 04:19:20PM +0200, Thorsten Blum wrote:
> >> The struct field swap can collide with the swap() macro defined in
> >> linux/minmax.h. Rename the struct field to prevent such collisions.
> > 
> > Same as in lib/sort.c, so what's the actual reason?
> 
> I included <linux/minmax.h> in arch/m68k/include/asm/bitops.h (to use the min()
> macro), but received the following error:
> 
> fs/bcachefs/eytzinger.c: In function ‘do_swap’:
> fs/bcachefs/eytzinger.c:128:69: error: macro "swap" passed 3 arguments, but takes just 2
>   128 |                 ((const struct wrapper *)priv)->swap(a, b, (int)size);
>       |                                                                     ^
> In file included from ./arch/m68k/include/asm/bitops.h:16,
>                  from ./include/linux/bitops.h:68,
>                  from fs/bcachefs/eytzinger.h:5,
>                  from fs/bcachefs/eytzinger.c:3:
> ./include/linux/minmax.h:270: note: macro "swap" defined here
>   270 | #define swap(a, b) \
>       |
> fs/bcachefs/eytzinger.c:128:47: warning: statement with no effect [-Wunused-value]
>   128 |                 ((const struct wrapper *)priv)->swap(a, b, (int)size);
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> make[4]: *** [scripts/Makefile.build:244: fs/bcachefs/eytzinger.o] Error 1
> make[3]: *** [scripts/Makefile.build:485: fs/bcachefs] Error 2
> 
> I thought about using #undef swap, but renaming it seemed to be the least
> disruptive change. Maybe there's a better solution?

No it's fine, I was just curious - I'll go ahead and apply it

