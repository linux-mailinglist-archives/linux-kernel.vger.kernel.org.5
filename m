Return-Path: <linux-kernel+bounces-141227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC208A1B19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB721C22664
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6817BA2;
	Thu, 11 Apr 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPDanV/N"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAA17C79
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850475; cv=none; b=MdMmK+qddMi3MHNJUOg/Zw3W1vyNKQZhwbTLa7l53EWNR9YocqXxNNuOZH0m0U2Lup9L8WkJ4RI8Zm4780S68cTbvbQwxxw7KopHq6y0zKeZIJfDKug6gdrlwCQnr6imS7DG9Un7wZFU29tbJxsckdH4lLSXpKTA0YbnUMxj++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850475; c=relaxed/simple;
	bh=PzE+yYSOEJ4diQY4L54RVbdmvbw7Q4WJOH1i6rXSY4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlNFop9AQKNgysJAgLE7smd4t31XryjLypaBF1zzE3GtfdHgsDmALDU7oBugr+sZP/KJEqf/U9nApPH7WpxcTFSBSFTZL/OX+ewwAgm7rjZFKCvMFQhjXSR8km+aJaJWUH400r2Hcfk71WMho5fjestrtqnBs1d+7be8TOGf+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPDanV/N; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso2648b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712850473; x=1713455273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txRvtwl1sJfPVBbrOHJOF6lPrBYCV0WvIn/IYxdE2rg=;
        b=HPDanV/NSyx0MwJNXdwHrkQK4DiBksI3goDaPbKD7FWcXvcUGziqrE3nVl/z3f9e60
         fFiUIS5Oy1xBpnGe19kySa6OdDcu9/F/c90hHc5bd3EB76G7qMAw5sGtH9UvWiP1k7ea
         52LhGyUBIt692Mx5NJaVB90rq1m8TG2XyOCgTpozvnd8msiEWc1QWJ43NsfkMMbiMJ1x
         iQj/p72KhSmaHya6sQxwsGjDtAajc7n4p5vb5T5/9fdunlSmzaHSGjGoolYAt7DGodZI
         Uocx82mxDCXMTwhuQvF67RpHCMU9fc4hFsrysNRBE7VmMTdRa3mnHJX79M+HCL7ewstZ
         h2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850473; x=1713455273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txRvtwl1sJfPVBbrOHJOF6lPrBYCV0WvIn/IYxdE2rg=;
        b=uHOiXNSif8O2I/TCU9YUJUMhwG51eU2mo7b4sU5RP5V2AfOPbGfzMP4bX5Dps5i3op
         3j2gWvr+/CgzuJVkkpXfkjfAJ8YLwXn+X56jJSO1DRZzYeWhLeGszMB/rKvwGJthPqoy
         +d4rKF9pfZfz4zbuIcBy3kpWMSlpdURyVLtjWeoxAxX8ifUx2QMazK/JB//KBWVIUD35
         ponsJL8KQbCaJW9rOCxpOLy8uDHfxBFnK/MgHuPgcs3qDwM2NkxRaRk2hZ7bEi8FkdNp
         FD/vVuUDuggd7HpXrSEzme+Up4+S1aMW3ZQ947j6pohT263Md50F+nMkFrpI72avoyUS
         rXwg==
X-Forwarded-Encrypted: i=1; AJvYcCVZVRDV74e+oqBBSijpT8ratxhkqTwCXvsNwXuENXGhC/ezGhJvwffkdoBPAB6bAVZ55proChVY/L2OSMIERmZHCLc82bCJ8iu7JoSV
X-Gm-Message-State: AOJu0YyPjtpHFG2WNTsYo/lZIgnooJuZVcrqxiskcyiEpzYpXbZKQj5l
	vkv4VYoZu6ihog8tNqr5zjBRMbfMo7dZhQ5QluQyodZYYNnNBBlO
X-Google-Smtp-Source: AGHT+IH9v6BA0i5KInsYOR9PJPeQoxuhkHpP9v9nVDSEk4lTlUuLmU4Bgwb3OF5cp+rpkMIdTb39iw==
X-Received: by 2002:a05:6a21:35c4:b0:1a3:dc86:40b1 with SMTP id ba4-20020a056a2135c400b001a3dc8640b1mr160425pzc.36.1712850472878;
        Thu, 11 Apr 2024 08:47:52 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020aa7860c000000b006eae2d9298esm1318251pfn.194.2024.04.11.08.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:47:52 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	rppt@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] init/main.c: Fix potential static_command_line memory overflow
Date: Thu, 11 Apr 2024 23:47:41 +0800
Message-ID: <20240411154742.258238-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412000858.7d81a7b946af172e6aed554d@kernel.org>
References: <20240412000858.7d81a7b946af172e6aed554d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 00:08:58 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 11 Apr 2024 22:27:23 +0800
> Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > On Thu, 11 Apr 2024 16:21:37 +0300, Mike Rapoport <rppt@kernel.org> wrote:
> > > On Thu, Apr 11, 2024 at 09:23:47AM +0200, Geert Uytterhoeven wrote:
> > > > CC Hiramatsu-san
> > > > 
> > > > On Thu, Apr 11, 2024 at 5:25 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > > We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
> > > > > static_command_line, but the strings copied into static_command_line are
> > > > > extra_command_line and command_line, rather than extra_command_line and
> > > > > boot_command_line.
> > > > >
> > > > > When strlen(command_line) > strlen(boot_command_line), static_command_line
> > > > > will overflow.
> > > 
> > > Can this ever happen? 
> > > Did you observe the overflow or is this a theoretical bug?
> > 
> > I didn't observe the overflow, it's just a theoretical bug.
> > 
> > > > > Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
> > > 
> > > f5c7310ac73e didn't have the logic for calculating allocation size, we
> > > surely don't want to go back that far wiht Fixes.
> > 
> > Before commit f5c7310ac73e, the memory size allocated for static_command_line
> > was 'strlen(command_line) + 1', but commit f5c7310ac73e changed this size
> > to 'strlen(boot_command_line) + 1'. I think this should be wrong.
> 
> Ah, OK. that sounds reasonable. 

:-)

> > 
> > > > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > > > ---
> > > > >  init/main.c | 8 +++++---
> > > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/init/main.c b/init/main.c
> > > > > index 2ca52474d0c3..a7b1f5f3e3b6 100644
> > > > > --- a/init/main.c
> > > > > +++ b/init/main.c
> > > > > @@ -625,11 +625,13 @@ static void __init setup_command_line(char *command_line)
> > > > >         if (extra_init_args)
> > > > >                 ilen = strlen(extra_init_args) + 4; /* for " -- " */
> > > > >
> > > > > -       len = xlen + strlen(boot_command_line) + 1;
> > > > > +       len = xlen + strlen(boot_command_line) + ilen + 1;
> > > > >
> > > > > -       saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
> > > > > +       saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > > > >         if (!saved_command_line)
> > > > > -               panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
> > > > > +               panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > > > > +
> > > > > +       len = xlen + strlen(command_line) + 1;
> 
> Ah, I missed this line. Sorry. So this looks good to me but you don't need any
> other lines, because those are not related to the bug you want to fix.
> Please just focus on 1 fix.
> 
> Thank you,

The other few lines of modification are some very small optimization.
I thought they were not worth posting a separate patch for at the time,
so I post them together. If necessary, I can separate them.

Thanks.

> > > > >
> > > > >         static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > > > >         if (!static_command_line)
> > > > 
> > > > Gr{oetje,eeting}s,
> > > > 
> > > >                         Geert
> > > > 
> > > > -- 
> > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > > > 
> > > > In personal conversations with technical people, I call myself a hacker. But
> > > > when I'm talking to journalists I just say "programmer" or something like that.
> > > >                                 -- Linus Torvalds
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

