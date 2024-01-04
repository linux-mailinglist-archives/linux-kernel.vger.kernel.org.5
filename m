Return-Path: <linux-kernel+bounces-16336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ED9823D03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F0B28759A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3E200AC;
	Thu,  4 Jan 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B3J2jDzx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37A200AA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso292327a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704354855; x=1704959655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VQTPnc2scC2p/Xz7rneNoVMYUc8L6JHpXSaKT9OYeg8=;
        b=B3J2jDzxNyivsb/TxS80ILJOhCrctHZNh4QJKD2WSErd9gdOs1v8SP8y2hbdKvU3h2
         HXJqtLKA+et1ae9RG9xodQV7rB9av4FpEB4CcZezfLn9q907eEvoG7h5pfCeA6n8SZkZ
         jEtOiwBq6z7NrxcwJdMCk49lJwNqQXVEqO7RMgp7bJfwgQpNHEZ/pytuQpq2OcPU+n3w
         DKK8ZmxqOFaM0UTjYDSeXth9czccqXD7tSY+DkUA1i4+hP1MoyEb8nu3COlochfpL6in
         0V9cJdO6gdOCN7mmfwQiafxeZ1c7timCchIyinfmLA8Rvq5ppb/0VISSGonc5o9rA8Ly
         XCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354855; x=1704959655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQTPnc2scC2p/Xz7rneNoVMYUc8L6JHpXSaKT9OYeg8=;
        b=wq8BzsdFt5j579x6N1b8RjZOWwxaWLzdB3OI6C2UKi4/vF0/gpQQxY01TXk7cP1EbP
         KfbvFwFGzfA8nyg1UCPoBXQlkZ2JD4OJR6ZQo7RjO6QLGGOJD6Y1RnVsTw5S+yG6Pnh4
         SosSI8+xJVnpChziVVXILe/bRkp1VZS/XtN0MTc91EmpILh16bISvUFCKapdc3ppFn3h
         +Frg3nYXXt4SFpXK5be9DIH5OQ4ZjUlSl4ALfDzIVo1JZ/VKcR7fABCtnLnVstX677NR
         LIkjN8w3sV+HEKpHykmcYLDvIP5xcmRLU0/7F8hE2rrsEFwwRLkikGqm8e97o4E1Pkka
         GcnA==
X-Gm-Message-State: AOJu0YzxsLPOu3nVHUB6qW1jOu1Pc6Js9EPYiGUocDp1tSMGSSed66nr
	mEVlPcU7aO4sqHyJR8ERBG/vSRQ9Q8EaFg==
X-Google-Smtp-Source: AGHT+IE7ov4R1SsE9KPnFfjJ3NIOH90YVtXi4IGB03mqoJJha6LJGH+ARnJsdsoleZ/49JYx3ZZv5g==
X-Received: by 2002:a50:d6db:0:b0:554:1072:d5dc with SMTP id l27-20020a50d6db000000b005541072d5dcmr79413edj.105.1704354855432;
        Wed, 03 Jan 2024 23:54:15 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ef7-20020a05640228c700b00556cf2545desm1859311edb.16.2024.01.03.23.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 23:54:15 -0800 (PST)
Date: Thu, 4 Jan 2024 08:54:12 +0100
From: Petr Mladek <pmladek@suse.com>
To: jim.cromie@gmail.com
Cc: lb@semihalf.com, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
	daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
	jbaron@akamai.com, john.ogness@linutronix.de, keescook@chromium.org,
	ppaalanen@gmail.com, rostedt@goodmis.org, seanpaul@chromium.org,
	sergey.senozhatsky@gmail.com, upstream@semihalf.com,
	vincent.whitchurch@axis.com, yanivt@google.com,
	gregkh@linuxfoundation.org
Subject: Re: [re: PATCH v2 00/15 - 03/11] dyndbg: disambiguate quoting in a
 debug msg
Message-ID: <ZZV_2hTP1VQB3VZm@alley>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com>
 <674f65e71c5c3e874b6b72b6f9d8cdd7a091b6d0.1701993656.git.jim.cromie@gmail.com>
 <ZYB0gyz-2M3k2kbD@alley>
 <CAJfuBxyOpPfks69LKOfiz7TPeSmqhCvHzv2qrCwn2CXfZLHJFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxyOpPfks69LKOfiz7TPeSmqhCvHzv2qrCwn2CXfZLHJFA@mail.gmail.com>

On Tue 2023-12-19 16:38:31, jim.cromie@gmail.com wrote:
> On Mon, Dec 18, 2023 at 9:34 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Thu 2023-12-07 17:15:06, Jim Cromie wrote:
> > > When debugging a query parsing error, the debug message wraps the
> > > query in escaped-double-quotes.  This is confusing when mixed with any
> > > quoted args where quotes are stripped by the shell.
> 
> (with dynamic_debug.verbose=3)
> nobody will be looking at this unless their query doesnt work.
> 
> > > So this replaces the \"%s\" with <%s> in the format string, allowing a
> > > user to see how the shell strips quotes:
> > >
> > > lx]# echo  module "foo" format ,_ -f > /proc/dynamic_debug/control
> > > [  716.037430] dyndbg: read 26 bytes from userspace
> > > [  716.037966] dyndbg: query 0: <module foo format ,_ -f> on module: <*>
> >
> > Could you provide a real life example, please? It is hard to imagine
> > what '"foo" format' means in a real life.
> 
> yes, sorry.  that was a poor selection from a bunch of output:
>      cat control-fuzz-cmds > /proc/dynamic_debug/control
> 
> that said, it was well formed input:  <module "foo" format ,_ -f>
> 
> >
> > Also could you please provide output before and after?
> 
> will do.
> 
> > Honestly, Using <> as quotes looks pretty non-standard and confusing
> > to me. Also this changes only one place but '\"' is used in many
> > other locations which would make dyndbg messages even more confusing.
> 
> perhaps I was myopic.
> 
> >
> > I do not understand how this would help. The double quote is gone
> > even in this variant.
> >
> 
> let me find a more compelling example.
> If I dont, maybe I'll drop (or shelve) this, I dont need it anymore.
> 
> > BTW: It is a bit funny that this patch is supposed to make the debug
> >      message better readable. For me, the echo command is hard
> >      to read in the first place. I would use:
> >
> > lx]# echo "module $my_module ,_ -f" > /proc/dynamic_debug/control
> 
> someone doing it in a script might want to control / quote $vars more actively:
> 
>    echo module "$modname" func '*' "$flagmods" >  /proc/dynamic_debug/control

This example uses: "$modname"

> if those vars arent set, it errs like this:
> 
> [root@v6 lx]# vx 3 # verbose=3
> [root@v6 lx]# echo module ' "$modname" ' func '*' "$flagmods" >
> /proc/dynamic_debug/control
> [ 3114.654016] dyndbg: read 26 bytes from userspace
> [ 3114.654314] dyndbg: query 0: <module "$modname" func * > on module: <*>
> [ 3114.654759] dyndbg: split into words: "module" "$modname" "func" "*"
> [ 3114.655319] dyndbg: expecting pairs of match-spec <value>
> [ 3114.655714] dyndbg: selector parse failed  # s/selector/filters/
> [ 3114.655981] dyndbg: processed 1 queries, with 0 matches, 1 errs
> bash: echo: write error: Invalid argument
> 
> or in old form, like this:
> 
> [root@frodo wk-test]# echo module '"$modname"' func '*' "$flagmods" >

and this one uses '"$modname"'

> /proc/dynamic_debug/control
> bash: echo: write error: Invalid argument
> [root@frodo wk-test]# [1387800.269898] dyndbg: read 26 bytes from userspace
> [1387800.269902] dyndbg: query 0: "module "$modname" func * " mod:*
> [1387800.269904] dyndbg: split into words: "module" "$modname" "func" "*"
> [1387800.269909] dyndbg: bad flag-op *, at start of *
> [1387800.269911] dyndbg: flags parse failed
> [1387800.269912] dyndbg: processed 1 queries, with 0 matches, 1 errs
> 
> in that query 0, theres a lot of double-quotes, not quite looking right.
> the following split-line adds its own quotes, which might clarify, or not,
> but is verbose=3, where others are verbose=2 or 1

The string "$modname" is here only because of the outer single quotes ''.
Otherwise, $modname would be substituted to the value here.

IMHO, this example does not look realistic.

Or if you think that it is realistic then a better solution would be
to print either:

	'module "$modname" func * '

or

	"module \"$modname\" func \* "

because the already substituted string is written to
/proc/dynamic_debug/control.

> >
> > Maybe, this change fixes the output to match some personal style.
> > I wonder how common is the style. I can't remember seeing:
> >
> >     $> echo param param param
> >
> > Instead I frequently see:
> >
> >     $> echo "bla bla bla".
> 
> I suppose you could call it taste / personal preference.
> I did document the bareword form to the howto,
> but the form was always accepted input.
> It is the point of the 1st paragraph in the "Command Language Reference"

Yes, both variants work because "echo" would write all parameters
on the same line. The only difference is how the white space characters
are handled:

   echo bla    bla    bla   # would print: bla bla bla
while
   echo "bla    bla    bla"   # would print: bla    bla    bla

> commit ace7c4bbb240d076a9e2079027252420d920d0d0
> Author: Jim Cromie <jim.cromie@7gmail.com>
> Date:   Sun Sep 4 15:40:56 2022 -0600
> 
>     doc-dyndbg: edit dynamic-debug-howto for brevity, audience
>     Rework/modernize docs:
>    (trimmed)
>      - alias ddcmd='echo $* > /proc/dynamic_debug/control
>        focus on args: declutter, hide boilerplate, make pwd independent.
>      - simplify - drop extra words, phrases, sentences.
> 
> but I only added 1 example, other single-arg examples are materially preserved
> (modulo the ddcmd usage, again for brevity)

Anyway, all the real life examples in Documentation/admin-guide/dynamic-debug-howto.rst
are using quotes, for example:

<paste>
  // enable the message at line 1603 of file svcsock.c
  :#> ddcmd 'file svcsock.c line 1603 +p'

  // enable all the messages in file svcsock.c
  :#> ddcmd 'file svcsock.c +p'

  // enable all the messages in the NFS server module
  :#> ddcmd 'module nfsd +p'
</paste>

:#> ddcmd 'file svcsock.c line 1603 +p'

> Antoine de Saint-Exupéry is credited with the quote,
> "Perfection is achieved, not when there is nothing more to add, but
> when there is nothing left to take away"

I do not remember in which context this was used. But I think
that this definition is not valid in all situations. For example,
a perfect home might be a prison cell from this POV. But only few
people would like to live there.

I still thing that using "echo" in the form of

     $> echo param param param

is uncommon and even misleading.

Best Regards,
Petr

