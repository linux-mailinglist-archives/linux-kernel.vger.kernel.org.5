Return-Path: <linux-kernel+bounces-141776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF58A2357
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5832854B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57253A7;
	Fri, 12 Apr 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsyRmwQT"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38334C8E;
	Fri, 12 Apr 2024 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886415; cv=none; b=sSKZIXfvT2ob6OcdqwC94Cs/rAz+V8kgiyEOL0kLfoYS4tm4DK3MfsXLU9BZ0a5dqClXI+Imz849wqHHyIVsWJVfRGpZpI0UqWCvEPDgR+H85SyhS8uN5mjr6K1DtfhvwuAtA5T0+C33XQ1H65UY5TqoqoxHrg40d3x+7A8evwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886415; c=relaxed/simple;
	bh=FP/Afpm40jBtMSr+7mRP+khV1HHCSLPWOtraxZmTWng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiOhgMHD23ECjOPTvMNzU9wDCy5ZkMTVPMJ995o+Hqy6RDz/gSi2mBY6fV6hfTlpb3K8Ahd2WlNiD6cfxZNHxhBDS6fVE2AAR/1qfP2G/MZnLkBejHZ4cCoT/Cqf1WOs1pfw5MPzLQazkqDHU4DGg0rPMCnx77DVGTYKKgXr2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsyRmwQT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4149e7695so3646625ad.0;
        Thu, 11 Apr 2024 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712886413; x=1713491213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTNINKBvYGsXPh2qmr+1Mo5tVIYZJuJC9faeb17b8gA=;
        b=gsyRmwQTomnmPr6c+jRZMtkmZxw+EC/mMQcsTubTHEs3OyEgz3kpqqCQm9N62npJMA
         JhG9JyhjHbDJJABucdM3DOa/8wqZXv/a52+yJ9eJFrG6jTSJPyWYRhz6caODOMtfHKvI
         dLX0xvx5NX/5lS9nTj7x5pBpeCkH2QYyzmRiWJnv3sZUUOfHdNOU+1/8NqOK0qil+2IL
         ja1ePXgoYEVQqyg/EbJRq7OiCmG3iaOBqO1wSyEZz7XNHZAjxgTY4v9nYO8uRqTwrbZ8
         PdEJASI36NjK5IpjeX0udkCcSskMDgDbjYaGDvsTtBJMHJsZAeqvRrQxVZp0fdZXSLas
         LMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886413; x=1713491213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTNINKBvYGsXPh2qmr+1Mo5tVIYZJuJC9faeb17b8gA=;
        b=XzGWnHYdVbyGiVRgUbCqzYiw0AhB0PpLli3AAFm9KmeBkaO+2fwOOV5/8MyDk7ja4d
         Kimf5fU5cJYK96XKtJRJ2cpo9FeuseHWaS2SoDQElewhnVUf8C6qY1FKcG0l3FzO2CeG
         Zs1ZALdUOY7KS960kRNJBm+wVAIMYdPT1phoTdXFSy13N6WX0PoUPdGi69tC4jQ0b0yC
         UPSteTkz5bQwHjxYr2I2QmebNkvo2UFUsToSLtrUSr8IXFcYP/u3k4XhKEc/pGkUkRgw
         xhQloAfeM0dy9DyXRa8q+Jqowd4GC8QJb83aC+7Lzg85M53HwxK0cR4aA6fhY24Gv+AF
         tVYw==
X-Forwarded-Encrypted: i=1; AJvYcCXBDBNt6+2D/zmxsEOQMp/dileH9Y4vGGvYD7JcO4uciG6xMpUw7V5Mj2Inb2Boit3AFXjMyeW2cIgf9q3jnr1oNNRuGQeisbxJmq3xZSzxGM4gk5Xx6IGmacQPeNymy0OTBpzlvH1WHyXtiolo1OBw
X-Gm-Message-State: AOJu0YwJGIj12JRts3HzB/jGC27qTqHGkIQ1PS8D/mHCVwCVJjk8b3/A
	czX2L/JuxSLtikVGyDEYPZJxqYk5t6+1n98LGGNOiv1M+M/ADLp6
X-Google-Smtp-Source: AGHT+IGKkscy7aoUv+qJZqUTTamPos4GYD3Z5IltXF6F/wYw6XZvZsafjUTFYKbNNYBQ3TrLqtEPgA==
X-Received: by 2002:a17:902:c94c:b0:1e4:fd4:48d4 with SMTP id i12-20020a170902c94c00b001e40fd448d4mr1479843pla.32.1712886412825;
        Thu, 11 Apr 2024 18:46:52 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001e0c91d448fsm675904plh.112.2024.04.11.18.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:46:52 -0700 (PDT)
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
Date: Fri, 12 Apr 2024 09:46:34 +0800
Message-ID: <20240412014642.290764-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412080839.c903a0058bd6594d31bc1d3e@kernel.org>
References: <20240412080839.c903a0058bd6594d31bc1d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 08:08:39 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 11 Apr 2024 23:29:40 +0800
> Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > On Thu, 11 Apr 2024 23:07:45 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > On Thu, 11 Apr 2024 09:19:32 +0200
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > 
> > > > CC Hiramatsu-san (now for real :-)
> > > 
> > > Thanks!
> > > 
> > > > 
> > > > On Thu, Apr 11, 2024 at 6:13 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > > extra_init_args ends with a space, so when concatenating extra_init_args
> > > > > to saved_command_line, be sure to remove the extra space.
> > > 
> > > Hi Yuntao,
> > > 
> > > Hmm, if you want to trim the end space, you should trim extra_init_args
> > > itself instead of this adjustment. Also, can you share the example?
> > > 
> > > Thank you,
> > 
> > At first, I also intended to fix this issue as you suggested. However,
> > because both extra_command_line and extra_init_args end with a space,
> > making such a change would require modifications in many places.
> 
> You may just need:
> 
> if (extra_init_args)
> 	strim(extra_init_args);

Okay, I'll post another patch, making the changes as you suggested.

> > That's why I chose this approach instead.
> > 
> > Here are some examples before and after modification:
> > 
> > Before: [    0.829179] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1 '
> > After:  [    0.032648] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1'
> > 
> > Before: [    0.757217] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1  arg1'
> > After:  [    0.068184] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1 arg1'
> > 
> > In order to make it easier to observe spaces, I added quotes when outputting saved_command_line.
> 
> BTW, is this tailing space harm anything? I don't like a cosmetic change.
> 
> Thank you,

I think this modification is necessary.

If saved_command_line is only used internally in the kernel, having extra
spaces, while not perfect, is acceptable to me. However, since saved_command_line
can be accessed by users through the /proc/cmdline file, having these extra
spaces here and there makes it look too casual.

> > 
> > Note that the first 'before' ends with a space, and there are two spaces between
> > 'bootconfig_arg1' and 'arg1' in the second 'before'.
> > 
> > > > >
> > > > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > > > ---
> > > > >  init/main.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/init/main.c b/init/main.c
> > > > > index 2ca52474d0c3..cf2c22aa0e8c 100644
> > > > > --- a/init/main.c
> > > > > +++ b/init/main.c
> > > > > @@ -660,12 +660,14 @@ static void __init setup_command_line(char *command_line)
> > > > >                         strcpy(saved_command_line + len, extra_init_args);
> > > > >                         len += ilen - 4;        /* strlen(extra_init_args) */
> > > > >                         strcpy(saved_command_line + len,
> > > > > -                               boot_command_line + initargs_offs - 1);
> > > > > +                               boot_command_line + initargs_offs);
> > > > >                 } else {
> > > > >                         len = strlen(saved_command_line);
> > > > >                         strcpy(saved_command_line + len, " -- ");
> > > > >                         len += 4;
> > > > >                         strcpy(saved_command_line + len, extra_init_args);
> > > > > +                       len += ilen - 4; /* strlen(extra_init_args) */
> > > > > +                       saved_command_line[len-1] = '\0'; /* remove trailing space */
> > > > >                 }
> > > > >         }
> > > > 
> > > > Gr{oetje,eeting}s,
> > > > 
> > > >                         Geert
> > > > 
> > > > -- 
> > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68korg
> > > > 
> > > > In personal conversations with technical people, I call myself a hacker. But
> > > > when I'm talking to journalists I just say "programmer" or something like that.
> > > >                                 -- Linus Torvalds
> > > > 
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

