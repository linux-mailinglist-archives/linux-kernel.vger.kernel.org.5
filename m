Return-Path: <linux-kernel+bounces-140601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91E8A16BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C128C3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241414EC66;
	Thu, 11 Apr 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVMeqrSo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082D14E2F4;
	Thu, 11 Apr 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844472; cv=none; b=OFdtXybWuUsAZq3KlsiUp9bggGPetBedoa6SA1ylNEU4p/3+nBLPbant1ohED1pnfc8AKJgyY5yQNW0rT+idGP49nvPJwXWcQSi91jGLCSiZa1KFJ/zRc8pjRos45ULkosFqRzuvcfdroq8mF+19WZUDXJ7Q748Q6JzjwUrqZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844472; c=relaxed/simple;
	bh=BPmT92KF/HjYiJCEk7DpLeaA43uZzuo5q9+GlepQGN0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=erE1BCUzSFsb5bToVVTRpk0GXRYnL2gBHCjzN1nYhhafTgzHiLV2E3k0/8auMWP1KsLPP+9lRuGFanuCz0kIjIZSK7BKGqVZ9C4gxXRDTk3LmIfL+g7Q5INJMk97ygWMwueOtYDmlzxnzBqcozq8Hjqt0sO6nvQXtqPbx4zwYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVMeqrSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BCFC113CD;
	Thu, 11 Apr 2024 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712844471;
	bh=BPmT92KF/HjYiJCEk7DpLeaA43uZzuo5q9+GlepQGN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aVMeqrSotjKFvJlnF81f+NIRpPwPzd+z/VdTfdJ4Cwuq5N3nljmrSKX/2KPy91nH5
	 k4YU34dDx1Jhek+s8TUIU9cgIqtXI2aBKh+LsxjJlTwDXbQCwXppKzMrmBKPFgFB8a
	 GlzqSbetZqLMCoWaMOczqXtRDayOJQNhy85fyWwJgLnPiO6o/nlYcBbaBrq5KLNW+d
	 27pYqyGA4x2cQjGyibYtw63yHtDWflPzEYx28ITOJtpyPAS6sFs3/4mQazL6Wx98i1
	 7Vz21BG6Ek1DDPmkf+mHPHbEN4f7rXksA2M/MhERf9ZXCE+/RQHEUHNOsHMP/sPVrO
	 ogto9Qw/siiIA==
Date: Thu, 11 Apr 2024 23:07:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yuntao Wang <ytcoode@gmail.com>, linux-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, "ndesaulniers@google.com"
 <ndesaulniers@google.com>, Tejun Heo <tj@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Krister Johansen <kjlx@templeofstupid.com>,
 Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Masami
 Hiramatsu <mhiramat@kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] init/main.c: Remove redundant space from
 saved_command_line
Message-Id: <20240411230745.dba6cfa97ec068d909550fd5@kernel.org>
In-Reply-To: <CAMuHMdU1-F0eZAXUyVCt2ik2w9J+vTm1DnvTVwx2hNz1CDZc1g@mail.gmail.com>
References: <20240411041200.225356-1-ytcoode@gmail.com>
	<CAMuHMdU1-F0eZAXUyVCt2ik2w9J+vTm1DnvTVwx2hNz1CDZc1g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 09:19:32 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> CC Hiramatsu-san (now for real :-)

Thanks!

> 
> On Thu, Apr 11, 2024 at 6:13 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > extra_init_args ends with a space, so when concatenating extra_init_args
> > to saved_command_line, be sure to remove the extra space.

Hi Yuntao,

Hmm, if you want to trim the end space, you should trim extra_init_args
itself instead of this adjustment. Also, can you share the example?

Thank you,

> >
> > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > ---
> >  init/main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 2ca52474d0c3..cf2c22aa0e8c 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -660,12 +660,14 @@ static void __init setup_command_line(char *command_line)
> >                         strcpy(saved_command_line + len, extra_init_args);
> >                         len += ilen - 4;        /* strlen(extra_init_args) */
> >                         strcpy(saved_command_line + len,
> > -                               boot_command_line + initargs_offs - 1);
> > +                               boot_command_line + initargs_offs);
> >                 } else {
> >                         len = strlen(saved_command_line);
> >                         strcpy(saved_command_line + len, " -- ");
> >                         len += 4;
> >                         strcpy(saved_command_line + len, extra_init_args);
> > +                       len += ilen - 4; /* strlen(extra_init_args) */
> > +                       saved_command_line[len-1] = '\0'; /* remove trailing space */
> >                 }
> >         }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68korg
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

