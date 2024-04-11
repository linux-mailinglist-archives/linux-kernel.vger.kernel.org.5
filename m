Return-Path: <linux-kernel+bounces-140751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10F8A18E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44410B2905E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3F11400B;
	Thu, 11 Apr 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2AIrLuq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3117548;
	Thu, 11 Apr 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849395; cv=none; b=mhGxppWH1hsZiYmXp5UVX/e2p4/++HdxOoXnxJsv5ReTaR5HOWJ/ZIlGOUY5tUSj9xpdq1YNZwOd/rJTY+kmGlvJIV13WeDN0LQDjRwrm8SAQsAG8Q7ztS0IBMTL+EwEAYvO6gC+QdXLC4WbIQFc3Ev/Gn2YTegiL53pOHTNVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849395; c=relaxed/simple;
	bh=Zm/vcpuplR7w6S6FRhzsBkm9DUzxgScoWkdpSq0iFho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vA6RcGI3fRIgYLSj6C+dPcjm/XHEW3rq+c/kjR/VywBghP0yM+XSyNkna4iIwomR0I/KhZvQNtoJZhEv0o7UNJOg20LGIpKCKxZw4K5emoBpZwod/8dN1IklzNnhkS3jQH3sI0llYmSxV5FFy+mA0ed/RSKd1wBPOAxpfvDSy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2AIrLuq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso7073856b3a.2;
        Thu, 11 Apr 2024 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712849393; x=1713454193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAlR7G4/I/wq7zvBwkr4mw2FcueO9c+kMR0wO3p0h8c=;
        b=J2AIrLuqMFMqcpU7R5D2ElcO7MANlOKTm7lbp1F3SuB5s3ReFNwuO/MZoXmGs3vylg
         dJ/3BCP/+/uCfb8soIGmUnhZfQRdU+Y2N4lYzJoeWkXX/JvfgdXR6dr2NDzxaSM0PKVV
         lwCsRM7NNmRo8dtTaybKEyeIKexUbLhAHXnYHmvDEPKylTNrQ334gtcEBqHxWtTbvO3Y
         iw0FtHY5Gk+4ltOgBh+eorskVG3rLJWbOlt5DyZnAq5YYnpqzPmczjvkqefm2hLLpdEW
         +6bFqZJPUMrwNrWJ7TAfkAIUOPJWs9zXkYzoy11qOrCF82xbIH/Pi8wtN2iNbGNrbDXH
         umBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849393; x=1713454193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAlR7G4/I/wq7zvBwkr4mw2FcueO9c+kMR0wO3p0h8c=;
        b=VBQpeeQmQ05YN/nf6ZiUwRjw3nVVYFs6VZuchAcXG3Z0XpaEorxi2132ncXT5+kxqD
         YsgPwWGQtSgr1tXygSopEle9BidaDs1+cOp3S7M06LpX1k7nnKwINa7HyhGOQtGIZ6e0
         6zsqXX7w4vFoCAc2H21MY385Wp880DduLi266n8GUlmsMd3baoYRmTOnlO8S4KBlYjdI
         KuqRkkZK5lzMOuAwP0xACP8crxycJPiHeZZHZmTwFB+G6I+eyuQZfSHiR7uYuBQmFNUS
         CbEDfVzvYuAhmX17Vj1CjYJRd1EJCHA6F+5Y07skat6KNBZt5mH1+CTgj0RpgiT7bS9J
         Hhkg==
X-Forwarded-Encrypted: i=1; AJvYcCV0vrF8hTsfaMdIuNaOC92SotqPfClQRcYC17Zlm46ly6uozqQHF/opFX6FXQH8gX5UQui0UznsmiOjszLu5BBEdvhE/Jx6425xcbnM/2kxSoN0tpFbsl6bcZFvvlCOZStrkl6sCd6kVeAex0I1NOZn
X-Gm-Message-State: AOJu0YzBHoVGjAaIaI/pHiVDCyTv3cnl+EjLwvz7LWxJ1nI53sSsgkYG
	IEP2AM4p26Dt/4rXydgv9Rp+mZXZqifJSSpTh29MvnrW6Kq5mt+7
X-Google-Smtp-Source: AGHT+IHga0oebP9bS/ubJI1wSs/FmQSHMr+qoybPPWro18uXOk2Kq+Db6uYM70JTN7Cb8NAsnmJVKw==
X-Received: by 2002:a05:6a20:918a:b0:1a3:cb50:b52d with SMTP id v10-20020a056a20918a00b001a3cb50b52dmr190568pzd.31.1712849392951;
        Thu, 11 Apr 2024 08:29:52 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id n3-20020aa78a43000000b006ed0d0307aasm1305480pfa.70.2024.04.11.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:29:52 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	changbin.du@huawei.com,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] init/main.c: Remove redundant space from saved_command_line
Date: Thu, 11 Apr 2024 23:29:40 +0800
Message-ID: <20240411152941.256666-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411230745.dba6cfa97ec068d909550fd5@kernel.org>
References: <20240411230745.dba6cfa97ec068d909550fd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 23:07:45 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 11 Apr 2024 09:19:32 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > CC Hiramatsu-san (now for real :-)
> 
> Thanks!
> 
> > 
> > On Thu, Apr 11, 2024 at 6:13 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > > extra_init_args ends with a space, so when concatenating extra_init_args
> > > to saved_command_line, be sure to remove the extra space.
> 
> Hi Yuntao,
> 
> Hmm, if you want to trim the end space, you should trim extra_init_args
> itself instead of this adjustment. Also, can you share the example?
> 
> Thank you,

At first, I also intended to fix this issue as you suggested. However,
because both extra_command_line and extra_init_args end with a space,
making such a change would require modifications in many places.
That's why I chose this approach instead.

Here are some examples before and after modification:

Before: [    0.829179] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1 '
After:  [    0.032648] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1'

Before: [    0.757217] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1  arg1'
After:  [    0.068184] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1 arg1'

In order to make it easier to observe spaces, I added quotes when outputting saved_command_line.

Note that the first 'before' ends with a space, and there are two spaces between
'bootconfig_arg1' and 'arg1' in the second 'before'.

> > >
> > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > ---
> > >  init/main.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/init/main.c b/init/main.c
> > > index 2ca52474d0c3..cf2c22aa0e8c 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -660,12 +660,14 @@ static void __init setup_command_line(char *command_line)
> > >                         strcpy(saved_command_line + len, extra_init_args);
> > >                         len += ilen - 4;        /* strlen(extra_init_args) */
> > >                         strcpy(saved_command_line + len,
> > > -                               boot_command_line + initargs_offs - 1);
> > > +                               boot_command_line + initargs_offs);
> > >                 } else {
> > >                         len = strlen(saved_command_line);
> > >                         strcpy(saved_command_line + len, " -- ");
> > >                         len += 4;
> > >                         strcpy(saved_command_line + len, extra_init_args);
> > > +                       len += ilen - 4; /* strlen(extra_init_args) */
> > > +                       saved_command_line[len-1] = '\0'; /* remove trailing space */
> > >                 }
> > >         }
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > -- 
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68korg
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

