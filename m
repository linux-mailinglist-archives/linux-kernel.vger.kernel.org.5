Return-Path: <linux-kernel+bounces-1979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2738156A2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3714C1F25544
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3EC1C32;
	Sat, 16 Dec 2023 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrJ9MRpJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D551869
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59171d44b32so893306eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702696181; x=1703300981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJNJGId9XLiB3veuwZOQOVh4Tn/Yy2SDp3NGJwB3Sy0=;
        b=VrJ9MRpJMtBcDFWyycnz3fPj4SHUSCrTC/JJyhkuugl0Hr6oPt6b2qM0uO6c2m7FJJ
         HzaGryMQMajfwS1xbLvDAVXaa179tWnIijqFN8xJNSvEahtcP45QtpvcXoCfTSqzZ6oc
         QkKvNO16x0VOY2Q4MNGQInXBd9OSEatGhGXg29sGJPCaxJhV73GOv7s9JFmQaNF5l/gj
         4k/vg6IsMQqMxKrbO1NO+JGLfxT+GKCf1WxM8PUUT54R43zB1N4LYTYsQldGOuFwTZf+
         TGvqxEm9ypTInIiFc75G3TeNSqv2bCTGqeKZ31MjfFkDm6upnbtTqSTspD2J+MNyKMRD
         9X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702696181; x=1703300981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJNJGId9XLiB3veuwZOQOVh4Tn/Yy2SDp3NGJwB3Sy0=;
        b=FhZ69TLJJNzCm4sbd3Q3xR8pcnD4q9W3Hu5t43GhaXW9BQqVSZE/c/l1sPrOMlpDjI
         OSwuIHrWpI2iw9o/3VfaR6fPLsvV/JeQapXN32rc0VAlzepGAFnSmBZM7QTGfAASBOwO
         Ygy7Gu4CNjl9zXgMpcJu530vL5v3rIEBAOPMj3892c0uFKEltrLJTG9uB2Y16FmLB0u8
         WXkmRUX2WWPttkJ0NmwBiGtTBEdhuZfurpwowIaw+iot2fGMCQWOIC7v3wh9dljqb/FI
         3v4KKDPRaqabBOQkQsdqLCuExFfQOYttS5ruQ+sayOtCagmHhMxVENJnJ+yF0pP2s+3y
         YERg==
X-Gm-Message-State: AOJu0Yz5TDGjby7nfYNsVXvjvgv9cUefnaPG3swIHzamH1J1wq8GkI6b
	KcBK5WE2UuB1fVkO05iEIQ7LUIK9ZIwJ0jWCcPM=
X-Google-Smtp-Source: AGHT+IEc/4/e9LAXqkSpPcVhhy19Qldf0S9jMynDhAf4FCORTQ/o/ramy7PN4zaC6zepEekbPRG8bwCDt5IxmjWBCcE=
X-Received: by 2002:a05:6358:78e:b0:170:9dd0:760e with SMTP id
 n14-20020a056358078e00b001709dd0760emr13438897rwj.63.1702696180638; Fri, 15
 Dec 2023 19:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <CAK8Bye+VQshH-AUKmmwVPZ+peo1Ca5961UuC8UB2ATAa4oHLEA@mail.gmail.com>
 <CAK8ByeK_f++ceBJKU8e2ScQo7gpeSuS8Sk3SXnjwZLdBOeC=gQ@mail.gmail.com>
In-Reply-To: <CAK8ByeK_f++ceBJKU8e2ScQo7gpeSuS8Sk3SXnjwZLdBOeC=gQ@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Fri, 15 Dec 2023 20:09:13 -0700
Message-ID: <CAJfuBxwrObKe69zFgteFQR9GpUMd959BvT_X5v_j85d1Xr9UuA@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 00/11] dyndbg: add support for writing
 debug logs to trace
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, bleung@google.com, 
	contact@emersion.fr, daniel@ffwll.ch, dianders@chromium.org, 
	groeck@google.com, jbaron@akamai.com, john.ogness@linutronix.de, 
	keescook@chromium.org, pmladek@suse.com, ppaalanen@gmail.com, 
	rostedt@goodmis.org, seanpaul@chromium.org, sergey.senozhatsky@gmail.com, 
	upstream@semihalf.com, vincent.whitchurch@axis.com, yanivt@google.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:20=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> sob., 9 gru 2023 o 01:31 =C5=81ukasz Bartosik <lb@semihalf.com> napisa=C5=
=82(a):
> >
> > pt., 8 gru 2023 o 01:15 Jim Cromie <jim.cromie@gmail.com> napisa=C5=82(=
a):
> > >
> > > hi Lukas,
> > >
> > > Sorry for the delay, I probably should have split this up.
> > > (also cc'g gregkh)
> > >
> > > Ive been banging on your v2 patchset:
> > > https://lore.kernel.org/lkml/20231130234048.157509-1-lb@semihalf.com/
> > >
> >
> > Jim, thank you for your thorough testing and review.
> >
> > > Things are looking pretty good, a few issues follow. And some patches=
.
> > >
> >
> > ;)
> >
> > > trivial:
> > >
> > >   dyndbg: export _print_hex_dump  # squash wo comment
> > >   dyndbg: tweak pr_info format s/trace dest/trace_dest/  # greppabili=
ty squash
> > >   dyndbg: disambiguate quoting in a debug msg
> > >   dyndbg: fix old BUG_ON in >control parser
> > >
> > > Then:
> > >
> > >   dyndbg: change +T:name_terminator to dot
> > >   dyndbg: treat comma as a token separator
> > >
> > > 1st allows 2nd, 2nd allows simpler arg-passing, boot-args, etc:
> > >
> > >   echo module,test_dynamic_debug,class,L2,+p > /proc/dynamic_debug/co=
ntrol
> > >   modprobe test_dynamic_debug dyndbg=3Dclass,L2,+mfl
> > >
> > > Given theres no legacy wrt comma, swapping it now with dot seems
> > > better semantically than "dot as token/list separator".
> > >
> > > Aside: /proc/dynamic_debug/control is always there (if configd), even
> > > when <debugfs> isn't mounted.  Its more universal, and copy-pastable.
> > >
> > >   dyndbg: __skip_spaces - and comma
> > >   dyndbg: split multi-query strings with %
> > >
> > > % allows escape-free multi-cmd dyndbg args:
> > >
> > >   modprobe test_dynamic_debug \
> > >     dyndbg=3Dopen,selftest%class,D2_CORE,+T:selftest.mf
> > >
> > >   dyndbg: reduce verbose/debug clutter
> > >   dyndbg: move lock,unlock into ddebug_change, drop goto - revisit
> > >
> > > Ive just pushed it, I will bump my version here.
> > > To github.com:jimc/linux.git
> > >  + 20d113eb6f9a...66fa2e4cb989 lukas-v2.1 -> lukas-v2.1 (forced updat=
e)
> > >
>
> hi Jim,
>
> I will squash the following commits to their appropriate peers:
> - dyndbg: export _print_hex_dump
> - dyndbg: tweak pr_info format s/trace dest/trace_dest/
> - dyndbg: change +T:name_terminator to dot
>
> I will also drop completely "dyndbg: move lock,unlock into
> ddebug_change, drop goto" and leave the remaining commits as is.

cool. and yes, late ack.
I got distracted by move of flags-handler to the bottom of the fn.
Pls add note about moving the lock to protect open/close too.

>
> > > SELFTEST
> > >
> > > Ive taken the liberty to write an ad-hoc test script (inline below),
> > > to exersize the parser with legacy command input, and with the new
> > > stuff mentioned above: comma-separated-tokens, %-separated-multi-cmds=
,
> > > while counting changes to builtin,etc modules, to validate against
> > > expectations.
> > >
> > > The change-count tests achieve some closed-loop testing, but checking
> > > syslog for messages written always seemed too hard/unreliable.  Your
> > > private trace-instances work promises a solution, by giving an
> > > observable closed system to build upon.
> > >
> > > I made some attempts to write messages to the trace-buf, but ran out
> > > of clues*tuits.  And I encountered a couple more definite problems:
> > >
> >
> > Let me dig through test scripts you created and issues you run into.
> >
> >
> > > 1- modprobe/rmmod lifecycle probs
> > >
> > > Ive coded some blue-sky and not-so-proper "modprobe,+T:it,-T:it,rmmod=
"
> > > life-cycle scenarios, which can wedge a previously created instance.
> > > Once wedged, I cannot recover.  See the test_private_trace{,_2,_3}
> > > functions, and the error_log_ref() following each.
> > >
>
> The tests are very useful. I root caused the failures. Please see below.
>
> > > This brittleness begs a question; should we have auto-open (mapping
> > > new names to available 1-63 trc-ids) ?  And non-close ? If it just di=
d
> > > the right thing, particularly on rmmod, it would prevent "misuse".
> > >
>
> I would rather not have auto-open. For me personal argument against it is
> that I usually make a lot of typos and with auto-open if I don't
> verify what I wrote
> I won't know whether logs will be written to the "right" instance or a
> newly created instance
> with typo name. In case of open/close commands error pops up when I
> try to write logs
> to a trace instance which was not opened.

yes. that is a value. auto-open was 1/2 baked speculation

>
> > > I don't think auto-open obsoletes the open (& esp) close commands, bu=
t
> > > Id like to see scripted test scenarios using close in combo with the
> > > right /sys/kernel/tracing/* manipulations, to prove its not all just =
a
> > > fever dream.
> > >
>
> Would you please elaborate what you mean by close in combo with right
> /sys/kernel/tracing/* manipulations ?
>

you detected the furious flapping, didnt you :-)

lemme start with the global-events trace-buf, for analogy/comparison.
to use it one must do both:
 echo 1 > /sys/kernel/tracing/events/dyndbg/enable
 echo $some_selection +T > /proc/dynamic_debug/control

using +T:private_buffer no longer requires the enable (im guessing)
but are there any other/corresponding setup actions / manipulations ?

if nothing else is needed, when does the instance open ?
after test-dynamic-debug-doprints on +T:private callsites ?
is it detectable from a script ?
probably: if [ -e /sys/kernel/tracing/instances/foo ]

if the instance is already open, I presume it is not cleared ?

any other play-nice-with-other-users stuff ?

conversely, to write a closed-loop test-script,
should the script just delete the instance/$name
after verifying its contents from the last doprints ?



> > > Your expertise in opening, writing to, manipulating & destroying
> > > private (and the global) tracebufs, distilled into new shell funcs,
> > > would be enormously helpful towards demonstrating the private-buffer
> > > use case and its value.
> > >
>
> I will work on adding new tests for trace.

nice!

>
> > > 2- some new flags parse error:
> > >
> > > [ 1273.074535] dyndbg:  32 debug prints in module test_dynamic_debug
> > > [ 1273.075365] dyndbg: module: test_dynamic_debug dyndbg=3D"class,D2_=
CORE,+T:foo%class,D2_KMS,+T:foo"
> > > [ 1273.076307] dyndbg: query 0: <class,D2_CORE,+T:foo> on module: <te=
st_dynamic_debug>
> > > [ 1273.077068] dyndbg: split into words: "class" "D2_CORE" "+T:foo"
> > > [ 1273.077673] dyndbg: unknown flag 'c'
> > > [ 1273.078033] dyndbg: flags parse failed on 2: +T:foo
> > > [ 1273.078519] dyndbg: query 1: <class,D2_KMS,+T:foo> on module: <tes=
t_dynamic_debug>
> > > [ 1273.079266] dyndbg: split into words: "class" "D2_KMS" "+T:foo"
> > > [ 1273.079872] dyndbg: unknown flag '=EF=BF=BD'
> > > [ 1273.080228] dyndbg: flags parse failed on 2: +T:foo
> > > [ 1273.080716] dyndbg: processed 2 queries, with 0 matches, 2 errs
> > > : 0 matches on =3DTl
> > >
> > > I have a suspicion this relates to moving the parse_flags call in
> > > ddebug_query, but I havent dug in.
> > >
> > >
> > > I also have some reservations about the default dest; 1st that it is =
a
> > > global state var, as noted at bottom of control:
> > >
> > >   [root@v6 lx]# ddgrep \\btrace\\b      # a better/narrower search-te=
rm ?
> > >   ...
> > >   Default trace destination: foo        # add a '#:' prefix to these =
lines ?
>
> Do you mean

This.  it hides the info behind a # so any parser expecting just
callsites is safe.
and the following colon marks it as info for the clever ones.

> #: Default trace destination:
> #: Opened trace instances: foo bar buz

But I would lalso ike the labels optimized for a tight grep, that wont
hit anything else,
and mostly thats easy to use.  "trace_dest" almost does it, is a
pretty good mark on the bikeshed.

> > >   Opened trace instances:               # all values should be on thi=
s line
> > >
>
> I will put all opened trace instance names on the same line
>
> > > Then theres the "preset" value, ie each site's dest_id (sorry I forgo=
t
> > > your fieldname).  I presume the default would override such a "preset=
"
> > > (otherwise it would have no effect).
> > >
> > > Is the default set on last open ? or on next use of +T:<foo> ?
> > >
>
> Default trace destination is set on [+-]T:<foo>

unless foo hasnt been opened, Im guessing
does it matter if the last destination used resulted in a match ?

>
> > > In the no-default world, a user/tester would decide how many
> > > trace-instances are needed, and map sets of callsites to them.
> > >
> > >   # configure drm-debug streams for this test scenario
> > >   cat<<EOF >/proc/dynamic_debug/control
> > >    open drm_core
> > >    open drm_mix
> > >    open driver_1        # we can separate by modname but not drvr-num=
ber
> > >    open driver_2
> > >    class DRM_UT_CORE -T:drm_core        # set dest_id, disabled state
>
> This sets default trace destination to drm_core
>
> > >    class DRM_UT_CORE +mf                # traces dont do prefixing (s=
hould it?)
>
> In this case logs will be neither written to syslog nor trace because
> both pT flags are not set.

I think my example fails to illuminate the corner I seek.

> I verified that both output to trace instance and trace events honors
> mf flags (prefixing) when they are set for a given callsite.

Ok. that is good to know.  that sounds reducible to a test-fn.

>
> > >    # mix KMS & ATOMIC into 1 stream
> > >    class DRM_UT_KMS -T:drm_mix
> > >    class DRM_UT_ATOMIC -T:drm_mix
> > >   EOF
> > >
> > > Then perhaps to turn on/off when needed: (legacy analogue version)
> > >
> > >   echo 0x15 > /sys/module/drm/parameters/debug_trace
> > >
> > > With those trace-dest presets honored, the configured drm_core &
> > > drm_mix streams persist.  If a later enablement applies the
> > > then-current default trace-dest, it would spoil this scheme.
> > >

so each callsite has a dest, which is set individually when the
callsite is selected
and -T:name'd in the EOF block.

I would *not* want enablements of those callsites to alter the dest
just because
the default-dest were altered in the interim.

I think it would break the way drm.debug is supported, by only
touching the T bit.


> > > Could you elaborate a scenario or 2 where the default behavior does
> > > something specific, and that its the right thing ?  I dont understand
> > > it yet.
> > >
>
> I'm a bit lost here. Help me out please. What do you mean by default beha=
vior ?

default behavior is what happens when +T (wo a dest) is done,
after a default dest has been set.  w/o a default-dest, it would be just :0

So having a default dest means implying the :default_dest_name.
whatever it is set to,
on whatever callsites are selected, unless the ddcmd gives a name, ie
+T:this_buf

As of last writing, I dont see how the extra implication helps.
It feels like hidden state.

I can squint at it and see a local / loop var, fwiw.

>
> > > OTOH
> > >
> > > One limitation of the above: the drm.debug_trace (posited above) woul=
d
> > > turn on all Ts in all those class'd callsites across the whole
> > > subsystem, irrespective of their preconfigured destination.  That was
> > > always inherent in drm.debug, but its less than perfect.
> > >
> > > It sort-of defeats the point of doing +T only on the useful callsites=
.
> > >
> > > And global event buf is also enabled, it might be flood-prone.
> > >
> > >   echo 1 > /sys/kernel/tracing/events/dyndbg/enable
> > >
> > > It would help if we could filter on trace-instance names:
> > > (this sounds familiar :-)
> > >
> > >   ddcmd module '*' trace_dest drm_mix +T
> > >

I think we need to implement this new keyword selector,
I think it addresses the flooding possible above,
when using both private traces and the global-trace.

but we dont need it yet.

> > > In reality, the dest-id is not even dependent on tracing per-se, it i=
s
> > > a user classification system (in contrast to class <subsys-names>).
> > > It just happens to be tied by +T:name syntax to tracefs.
> > >
> > > No promise about +p:_alt_log_.mflt having meaning, or working.

or not complaining, pr_notice ?


> > >
> > >

I look forward to v3
Jim

