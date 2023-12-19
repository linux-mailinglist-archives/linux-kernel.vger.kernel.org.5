Return-Path: <linux-kernel+bounces-6105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947648194AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B735282F92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062A3DBA0;
	Tue, 19 Dec 2023 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo852vYw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB803DB80
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-466a2e4fd18so535984137.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703029138; x=1703633938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfOmyIzTc6yC+411XEfhViPmm5S/8N3m6bdotSuQkZo=;
        b=lo852vYwYbVLlyGuSdAQv1M++gRV3szMh0gWmfE21BVncXp9vxNNIdwIVZiqoZk/F6
         p/hSRTPzh70GPP8Ggz/QYI1GRaMxieQHDLQ9tjhhjh8A0QlAwx3bjnAcFG3etQ9/2v1f
         Ih5bF9Blws/m0/47lLikgCKuS8Hi2I1SJrrQ+vt6Ke30C7lGzuk5NuGjJU23VQzS28gf
         lR4KYGlvIPOKq7C3E28cnvszNYpD5wG2fe6I5fd66RtBeVqFR6o0ynjntrJo9l7PITKX
         nIT92zsEaaN/iVHZQgbodsudnZ7H5rdcvkztzENsmpg0VXq4w/F4Zt8azlzUDAp1rTlS
         uxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703029138; x=1703633938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfOmyIzTc6yC+411XEfhViPmm5S/8N3m6bdotSuQkZo=;
        b=h4BthBjfsiOY0Ar3Fr5Mthk1pBKenSEt3BdXys7a+fup7SJoINe1iDsx+mQTaOYQ6n
         nnzKNgfABxToAVBSTNhISc/MqeCpEQOKRKFCqmxXPrX0mXLQyrs6LEVKzU/B74r2phjJ
         7fSYFluezjuwHFyDF/V2Pv3gBlhEkH4WNeWf/r7J+5hHkW2YYMARsOsMb+NQQ+smAfeA
         3cN3B2joiw6X1fb7elcVHcy8N1N6N55qdDNLT2e2DsD+ofjpEK1v/YQf8J1KNDV3AYr/
         MHMcPEYlU7d22/J2zOFr+pf/UIKbF6QMLYWjSyhFBRmfeYFl+f7BDsgp3uKm7bxGi/gt
         kA7A==
X-Gm-Message-State: AOJu0YxpscVpyVAIsU50zJyctEPzHAcP2DwHFYs4rk/XvcC+P13X35BQ
	YNPK6Qypd+9KYwTTt5GTf5vNZdR61WSp6CcorI0=
X-Google-Smtp-Source: AGHT+IEAamr/ZCha8C40C7SKpV393xjzKpSqy+iz0E/xhAHpzFNBDzrg1v5cuPjTo1wOAi3rJwSD1jDECHn656/Dzb4=
X-Received: by 2002:a05:6102:dcb:b0:466:bc68:ff4b with SMTP id
 e11-20020a0561020dcb00b00466bc68ff4bmr477569vst.1.1703029138226; Tue, 19 Dec
 2023 15:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <674f65e71c5c3e874b6b72b6f9d8cdd7a091b6d0.1701993656.git.jim.cromie@gmail.com>
 <ZYB0gyz-2M3k2kbD@alley>
In-Reply-To: <ZYB0gyz-2M3k2kbD@alley>
From: jim.cromie@gmail.com
Date: Tue, 19 Dec 2023 16:38:31 -0700
Message-ID: <CAJfuBxyOpPfks69LKOfiz7TPeSmqhCvHzv2qrCwn2CXfZLHJFA@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 03/11] dyndbg: disambiguate quoting in a
 debug msg
To: Petr Mladek <pmladek@suse.com>
Cc: lb@semihalf.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	bleung@google.com, contact@emersion.fr, daniel@ffwll.ch, 
	dianders@chromium.org, groeck@google.com, jbaron@akamai.com, 
	john.ogness@linutronix.de, keescook@chromium.org, ppaalanen@gmail.com, 
	rostedt@goodmis.org, seanpaul@chromium.org, sergey.senozhatsky@gmail.com, 
	upstream@semihalf.com, vincent.whitchurch@axis.com, yanivt@google.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 9:34=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2023-12-07 17:15:06, Jim Cromie wrote:
> > When debugging a query parsing error, the debug message wraps the
> > query in escaped-double-quotes.  This is confusing when mixed with any
> > quoted args where quotes are stripped by the shell.

(with dynamic_debug.verbose=3D3)
nobody will be looking at this unless their query doesnt work.

> > So this replaces the \"%s\" with <%s> in the format string, allowing a
> > user to see how the shell strips quotes:
> >
> > lx]# echo  module "foo" format ,_ -f > /proc/dynamic_debug/control
> > [  716.037430] dyndbg: read 26 bytes from userspace
> > [  716.037966] dyndbg: query 0: <module foo format ,_ -f> on module: <*=
>
>
> Could you provide a real life example, please? It is hard to imagine
> what '"foo" format' means in a real life.

yes, sorry.  that was a poor selection from a bunch of output:
     cat control-fuzz-cmds > /proc/dynamic_debug/control

that said, it was well formed input:  <module "foo" format ,_ -f>

>
> Also could you please provide output before and after?

will do.

> Honestly, Using <> as quotes looks pretty non-standard and confusing
> to me. Also this changes only one place but '\"' is used in many
> other locations which would make dyndbg messages even more confusing.

perhaps I was myopic.

>
> I do not understand how this would help. The double quote is gone
> even in this variant.
>

let me find a more compelling example.
If I dont, maybe I'll drop (or shelve) this, I dont need it anymore.

> BTW: It is a bit funny that this patch is supposed to make the debug
>      message better readable. For me, the echo command is hard
>      to read in the first place. I would use:
>
> lx]# echo "module $my_module ,_ -f" > /proc/dynamic_debug/control

someone doing it in a script might want to control / quote $vars more activ=
ely:

   echo module "$modname" func '*' "$flagmods" >  /proc/dynamic_debug/contr=
ol

if those vars arent set, it errs like this:

[root@v6 lx]# vx 3 # verbose=3D3
[root@v6 lx]# echo module ' "$modname" ' func '*' "$flagmods" >
/proc/dynamic_debug/control
[ 3114.654016] dyndbg: read 26 bytes from userspace
[ 3114.654314] dyndbg: query 0: <module "$modname" func * > on module: <*>
[ 3114.654759] dyndbg: split into words: "module" "$modname" "func" "*"
[ 3114.655319] dyndbg: expecting pairs of match-spec <value>
[ 3114.655714] dyndbg: selector parse failed  # s/selector/filters/
[ 3114.655981] dyndbg: processed 1 queries, with 0 matches, 1 errs
bash: echo: write error: Invalid argument

or in old form, like this:

[root@frodo wk-test]# echo module '"$modname"' func '*' "$flagmods" >
/proc/dynamic_debug/control
bash: echo: write error: Invalid argument
[root@frodo wk-test]# [1387800.269898] dyndbg: read 26 bytes from userspace
[1387800.269902] dyndbg: query 0: "module "$modname" func * " mod:*
[1387800.269904] dyndbg: split into words: "module" "$modname" "func" "*"
[1387800.269909] dyndbg: bad flag-op *, at start of *
[1387800.269911] dyndbg: flags parse failed
[1387800.269912] dyndbg: processed 1 queries, with 0 matches, 1 errs

in that query 0, theres a lot of double-quotes, not quite looking right.
the following split-line adds its own quotes, which might clarify, or not,
but is verbose=3D3, where others are verbose=3D2 or 1

>
> Maybe, this change fixes the output to match some personal style.
> I wonder how common is the style. I can't remember seeing:
>
>     $> echo param param param
>
> Instead I frequently see:
>
>     $> echo "bla bla bla".

I suppose you could call it taste / personal preference.
I did document the bareword form to the howto,
but the form was always accepted input.
It is the point of the 1st paragraph in the "Command Language Reference"

commit ace7c4bbb240d076a9e2079027252420d920d0d0
Author: Jim Cromie <jim.cromie@7gmail.com>
Date:   Sun Sep 4 15:40:56 2022 -0600

    doc-dyndbg: edit dynamic-debug-howto for brevity, audience
    Rework/modernize docs:
   (trimmed)
     - alias ddcmd=3D'echo $* > /proc/dynamic_debug/control
       focus on args: declutter, hide boilerplate, make pwd independent.
     - simplify - drop extra words, phrases, sentences.

but I only added 1 example, other single-arg examples are materially preser=
ved
(modulo the ddcmd usage, again for brevity)

Antoine de Saint-Exup=C3=A9ry is credited with the quote,
"Perfection is achieved, not when there is nothing more to add, but
when there is nothing left to take away"

extraneous unnecessary quotes are one thing to take away.
then the remaining quotes are doing something,
like preventing shell expansion, protecting inner quoting, etc

OTOH, the single whole-query arg, in single quotes has its own clarity.
Almost all examples are preserved - only 1 was changed to quote-less form

and seeing <> in legitimate input should be exceptionally rare, so
pretty unambiguous as balanced quotes

#> echo module dunno format ' "looking for <foo> in format" ' +p >
/proc/dynamic_debug/control
[1400065.833314] dyndbg: read 53 bytes from userspace
[1400065.833324] dyndbg: query 0: "module dunno format "looking for
<foo> in format" +p" mod:*
[1400065.833331] dyndbg: split into words: "module" "dunno" "format"
"looking for <foo> in format" "+p"
[1400065.833345] dyndbg: op=3D'+'
[1400065.833348] dyndbg: flags=3D0x1
[1400065.833351] dyndbg: *flagsp=3D0x1 *maskp=3D0xffffffff
[1400065.833356] dyndbg: parsed: func=3D"" file=3D"" module=3D"dunno"
format=3D"looking for <foo> in format" lineno=3D0-0 class=3D(null)
[1400065.833403] dyndbg: no matches for query
[1400065.833406] dyndbg: no-match: func=3D"" file=3D"" module=3D"dunno"
format=3D"looking for <foo> in format" lineno=3D0-0 class=3D(null)
[1400065.833412] dyndbg: processed 1 queries, with 0 matches, 0 errs

new form (w combined op-flags-mask-dest patch too)

[root@v6 lx]# echo 'module dunno format "looking for <foo> in format"'
+p > /proc/dynamic_debug/control
[  737.645791] dyndbg: read 53 bytes from userspace
[  737.646374] dyndbg: query 0: <module dunno format "looking for
<foo> in format" +p> on module: <*>
[  737.647226] dyndbg: split into words: "module" "dunno" "format"
"looking for <foo> in format" "+p"
[  737.648069] dyndbg: op=3D'+' flags=3D0x1 maskp=3D0xffffffff trace_dest=
=3D0x0
[  737.648673] dyndbg: no matches for query
[  737.649162] dyndbg: no-match: func=3D"" file=3D"" module=3D"dunno"
format=3D"looking for <foo> in format" lineno=3D0-0 class=3D(null)
[  737.650481] dyndbg: processed 1 queries, with 0 matches, 0 errs


>
> Best Regards,
> Petr

Am I materially closer to what youd want to see?
thx, Jim

