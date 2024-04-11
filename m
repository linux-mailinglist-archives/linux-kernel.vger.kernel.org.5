Return-Path: <linux-kernel+bounces-141699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F598A221A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518891F2191A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5747A64;
	Thu, 11 Apr 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmDNdbLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4847768;
	Thu, 11 Apr 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876925; cv=none; b=hG6hjEzIAf2YedLd8WT+YdXYjgVILWa/7OrwJaGB4W/g8zNeecSIuraYQve69NXZt0ruzm6tf3R1XuZyI4/QAfCRQFhmniLZoXJMfgEkkdu5WHjBL3zz9jdQ3eMKpXLR84XDft320rK1LER9LBpwcgzw05azCnh6XOMIp8QbMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876925; c=relaxed/simple;
	bh=9Be3q6JYHjv6MccnxSgMKyVuxFPrHvQDF/b6XL6yv+4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gqAOLdvoTmdfkPATTQJhTY7E/g2ElDYgYp32tf/Pdy36N6eh6V11yxzAhPCcfWcnB/obxuggAllklGEycKgYf6eMdBv1guKIgNFpr7q3cPSHiY+zjUawY2cRByBS3drd7v64AEIkoHgVyEvolgEaNPCiQzPY11JSptJgyaXzqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmDNdbLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53F9C072AA;
	Thu, 11 Apr 2024 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712876924;
	bh=9Be3q6JYHjv6MccnxSgMKyVuxFPrHvQDF/b6XL6yv+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmDNdbLnPV87ajGBPNUro9DeMRZXbKxg7Wz+kQadT70xWwn7eOKrD8ctGTrBs2tEd
	 BpZHZNTK1BVLwfiOzjvQz88Piqpv3Gr7D3rkcdr8lSVFs6RM5pBzKNLJjiB8ZlDEkq
	 fv8AF8uDhMqQ/n17o6Ktst2/vjHLZWmThH4cpARc3bGP5xJQeCoaTzHq1BCcA/0nEP
	 2K8h+QD885Ys0FyDjZxRgldz5hnmdtpl/2LThnQplOaATtf0SeJu/6pTnE3AHXIR86
	 qjF9hR6VSIORHVizuWpGcQNXCEaAhCRT1SRFhQ743rw3iBU6Fmjt+J1N26GM+Eob8Y
	 t14TcyC8lnEug==
Date: Fri, 12 Apr 2024 08:08:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, changbin.du@huawei.com,
 christophe.leroy@csgroup.eu, geert@linux-m68k.org, jpoimboe@kernel.org,
 kjlx@templeofstupid.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ndesaulniers@google.com,
 peterz@infradead.org, tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH] init/main.c: Remove redundant space from
 saved_command_line
Message-Id: <20240412080839.c903a0058bd6594d31bc1d3e@kernel.org>
In-Reply-To: <20240411152941.256666-1-ytcoode@gmail.com>
References: <20240411230745.dba6cfa97ec068d909550fd5@kernel.org>
	<20240411152941.256666-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 23:29:40 +0800
Yuntao Wang <ytcoode@gmail.com> wrote:

> On Thu, 11 Apr 2024 23:07:45 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 11 Apr 2024 09:19:32 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > 
> > > CC Hiramatsu-san (now for real :-)
> > 
> > Thanks!
> > 
> > > 
> > > On Thu, Apr 11, 2024 at 6:13 AM Yuntao Wang <ytcoode@gmail.com> wrote:
> > > > extra_init_args ends with a space, so when concatenating extra_init_args
> > > > to saved_command_line, be sure to remove the extra space.
> > 
> > Hi Yuntao,
> > 
> > Hmm, if you want to trim the end space, you should trim extra_init_args
> > itself instead of this adjustment. Also, can you share the example?
> > 
> > Thank you,
> 
> At first, I also intended to fix this issue as you suggested. However,
> because both extra_command_line and extra_init_args end with a space,
> making such a change would require modifications in many places.

You may just need:

if (extra_init_args)
	strim(extra_init_args);

> That's why I chose this approach instead.
> 
> Here are some examples before and after modification:
> 
> Before: [    0.829179] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1 '
> After:  [    0.032648] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1'
> 
> Before: [    0.757217] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1  arg1'
> After:  [    0.068184] Kernel command line: 'console=ttyS0 debug -- bootconfig_arg1 arg1'
> 
> In order to make it easier to observe spaces, I added quotes when outputting saved_command_line.

BTW, is this tailing space harm anything? I don't like a cosmetic change.

Thank you,

> 
> Note that the first 'before' ends with a space, and there are two spaces between
> 'bootconfig_arg1' and 'arg1' in the second 'before'.
> 
> > > >
> > > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > > ---
> > > >  init/main.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/init/main.c b/init/main.c
> > > > index 2ca52474d0c3..cf2c22aa0e8c 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -660,12 +660,14 @@ static void __init setup_command_line(char *command_line)
> > > >                         strcpy(saved_command_line + len, extra_init_args);
> > > >                         len += ilen - 4;        /* strlen(extra_init_args) */
> > > >                         strcpy(saved_command_line + len,
> > > > -                               boot_command_line + initargs_offs - 1);
> > > > +                               boot_command_line + initargs_offs);
> > > >                 } else {
> > > >                         len = strlen(saved_command_line);
> > > >                         strcpy(saved_command_line + len, " -- ");
> > > >                         len += 4;
> > > >                         strcpy(saved_command_line + len, extra_init_args);
> > > > +                       len += ilen - 4; /* strlen(extra_init_args) */
> > > > +                       saved_command_line[len-1] = '\0'; /* remove trailing space */
> > > >                 }
> > > >         }
> > > 
> > > Gr{oetje,eeting}s,
> > > 
> > >                         Geert
> > > 
> > > -- 
> > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68korg
> > > 
> > > In personal conversations with technical people, I call myself a hacker. But
> > > when I'm talking to journalists I just say "programmer" or something like that.
> > >                                 -- Linus Torvalds
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

