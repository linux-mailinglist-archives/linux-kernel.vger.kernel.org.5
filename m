Return-Path: <linux-kernel+bounces-3815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48D8172FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C6A1C24FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CD1D141;
	Mon, 18 Dec 2023 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="Bs+tGj7W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED13A1B7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553338313a0so1473752a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702908735; x=1703513535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8cqdiKL7lvjAvHclG17uyU4gdhcaWHfDov9IRBJKUs=;
        b=Bs+tGj7WIMIif2Kv3LYqCHHd3YLpzRpXJV2wKdfKrza8MAfK8rIUE7sxIeIZcPoeNE
         nRN4fNd/UZ2hRT9nQwYNVm4TdG+2rpZPSstHlkRqQk0oCI2+fndZ5MDVUIPeMYy0ChWA
         93hrBEQiNwjK3BhsinlcI59QoViIAQzGdqdlkGnrPpCiEJpYvlORLtUs1Z/p/zsvJBFD
         apI6UtfJyAPNA4gmztXTyTl6TCjwiGMFkzUgrR7wTnC7C1M3IbE5qZOfgG+ieD4Q4VHA
         GIgChEtB3eLSkXo7nYNp5MCo4WpBmHepzEOKo5nEZp1pnVZ5aEYk812QWm+kVCe13ew1
         mF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908735; x=1703513535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8cqdiKL7lvjAvHclG17uyU4gdhcaWHfDov9IRBJKUs=;
        b=OrgIRPacwTtbSdrtOfN5pSW+GHBLeDkBRHG1skkejkAq1NTQCifdTqc0aLRBAfMVo/
         cP8sNHshUMX3M4X3Cd/8LLjDynCfREv5j016sfp1hljGcKcxe8D1kj+TnIFjfK/zJF4M
         +z4j/RNmOrdRW8Z28+a3hPc3lpG/79EE5IokUzrAmnt4vA2PVPK/Jh3VTj8i7HbYh34y
         Iq3q2kHDBkfmjjX0TI3XxCtR/q7Zc0pufyIptpCWvfN9L1u6eCiLTGZjgso/jygkz/uI
         TUORKehSqAVBbLeqZ1ST4/j7kNTWmUiSmU17O8NpztPVK5UUA047HKxJSduWTFFjGDQw
         D4qQ==
X-Gm-Message-State: AOJu0YwHs54Tq1FGgl775giUC4Lp+dmdBfpA4B0oAj/7TW+npz+gkaat
	YrzsmyG3YsWcqZxTUI4J+e1h64aDJDt3q7efi2qw
X-Google-Smtp-Source: AGHT+IGjv/kzOnorPhuQnz0Ou4/L87P0yGXGgkhD/rJ2t80qQ4VWCN8a3NPmq0g/FHe5M3UlWHJ4/7vFew8vNBG7SHw=
X-Received: by 2002:a05:6402:2227:b0:547:9f26:e581 with SMTP id
 cr7-20020a056402222700b005479f26e581mr7348259edb.37.1702908735359; Mon, 18
 Dec 2023 06:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <CAK8Bye+VQshH-AUKmmwVPZ+peo1Ca5961UuC8UB2ATAa4oHLEA@mail.gmail.com>
 <CAK8ByeK_f++ceBJKU8e2ScQo7gpeSuS8Sk3SXnjwZLdBOeC=gQ@mail.gmail.com>
 <CAJfuBxwrObKe69zFgteFQR9GpUMd959BvT_X5v_j85d1Xr9UuA@mail.gmail.com> <CAK8ByeJ1PEOASY7ZZ8U644YwKrTzCW+3PvjUEP7CevLCNa4L0A@mail.gmail.com>
In-Reply-To: <CAK8ByeJ1PEOASY7ZZ8U644YwKrTzCW+3PvjUEP7CevLCNa4L0A@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Mon, 18 Dec 2023 15:12:04 +0100
Message-ID: <CAK8Bye+t8_neBC8eEuM+C_cb-=Aj01nABOQLCZ8DX0znbvL_eQ@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 00/11] dyndbg: add support for writing
 debug logs to trace
To: jim.cromie@gmail.com
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, bleung@google.com, 
	contact@emersion.fr, daniel@ffwll.ch, dianders@chromium.org, 
	groeck@google.com, jbaron@akamai.com, john.ogness@linutronix.de, 
	keescook@chromium.org, pmladek@suse.com, ppaalanen@gmail.com, 
	rostedt@goodmis.org, seanpaul@chromium.org, sergey.senozhatsky@gmail.com, 
	upstream@semihalf.com, vincent.whitchurch@axis.com, yanivt@google.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 18 gru 2023 o 02:01 =C5=81ukasz Bartosik <lb@semihalf.com> napisa=C5=
=82(a):
>
> sob., 16 gru 2023 o 04:09 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Thu, Dec 14, 2023 at 8:20=E2=80=AFAM =C5=81ukasz Bartosik <lb@semiha=
lf.com> wrote:
> > >
> > > sob., 9 gru 2023 o 01:31 =C5=81ukasz Bartosik <lb@semihalf.com> napis=
a=C5=82(a):
> > > >
> > > > pt., 8 gru 2023 o 01:15 Jim Cromie <jim.cromie@gmail.com> napisa=C5=
=82(a):
> > > > >
> > > > > hi Lukas,
> > > > >
> > > > > Sorry for the delay, I probably should have split this up.
> > > > > (also cc'g gregkh)
> > > > >
> > > > > Ive been banging on your v2 patchset:
> > > > > https://lore.kernel.org/lkml/20231130234048.157509-1-lb@semihalf.=
com/
> > > > >
> > > >
> > > > Jim, thank you for your thorough testing and review.
> > > >
> > > > > Things are looking pretty good, a few issues follow. And some pat=
ches.
> > > > >
> > > >
> > > > ;)
> > > >
> > > > > trivial:
> > > > >
> > > > >   dyndbg: export _print_hex_dump  # squash wo comment
> > > > >   dyndbg: tweak pr_info format s/trace dest/trace_dest/  # greppa=
bility squash
> > > > >   dyndbg: disambiguate quoting in a debug msg
> > > > >   dyndbg: fix old BUG_ON in >control parser
> > > > >
> > > > > Then:
> > > > >
> > > > >   dyndbg: change +T:name_terminator to dot
> > > > >   dyndbg: treat comma as a token separator
> > > > >
> > > > > 1st allows 2nd, 2nd allows simpler arg-passing, boot-args, etc:
> > > > >
> > > > >   echo module,test_dynamic_debug,class,L2,+p > /proc/dynamic_debu=
g/control
> > > > >   modprobe test_dynamic_debug dyndbg=3Dclass,L2,+mfl
> > > > >
> > > > > Given theres no legacy wrt comma, swapping it now with dot seems
> > > > > better semantically than "dot as token/list separator".
> > > > >
> > > > > Aside: /proc/dynamic_debug/control is always there (if configd), =
even
> > > > > when <debugfs> isn't mounted.  Its more universal, and copy-pasta=
ble.
> > > > >
> > > > >   dyndbg: __skip_spaces - and comma
> > > > >   dyndbg: split multi-query strings with %
> > > > >
> > > > > % allows escape-free multi-cmd dyndbg args:
> > > > >
> > > > >   modprobe test_dynamic_debug \
> > > > >     dyndbg=3Dopen,selftest%class,D2_CORE,+T:selftest.mf
> > > > >
> > > > >   dyndbg: reduce verbose/debug clutter
> > > > >   dyndbg: move lock,unlock into ddebug_change, drop goto - revisi=
t
> > > > >
> > > > > Ive just pushed it, I will bump my version here.
> > > > > To github.com:jimc/linux.git
> > > > >  + 20d113eb6f9a...66fa2e4cb989 lukas-v2.1 -> lukas-v2.1 (forced u=
pdate)
> > > > >
> > >
> > > hi Jim,
> > >
> > > I will squash the following commits to their appropriate peers:
> > > - dyndbg: export _print_hex_dump
> > > - dyndbg: tweak pr_info format s/trace dest/trace_dest/
> > > - dyndbg: change +T:name_terminator to dot
> > >
> > > I will also drop completely "dyndbg: move lock,unlock into
> > > ddebug_change, drop goto" and leave the remaining commits as is.
> >
> > cool. and yes, late ack.
> > I got distracted by move of flags-handler to the bottom of the fn.
> > Pls add note about moving the lock to protect open/close too.
> >
> > >
> > > > > SELFTEST
> > > > >
> > > > > Ive taken the liberty to write an ad-hoc test script (inline belo=
w),
> > > > > to exersize the parser with legacy command input, and with the ne=
w
> > > > > stuff mentioned above: comma-separated-tokens, %-separated-multi-=
cmds,
> > > > > while counting changes to builtin,etc modules, to validate agains=
t
> > > > > expectations.
> > > > >
> > > > > The change-count tests achieve some closed-loop testing, but chec=
king
> > > > > syslog for messages written always seemed too hard/unreliable.  Y=
our
> > > > > private trace-instances work promises a solution, by giving an
> > > > > observable closed system to build upon.
> > > > >
> > > > > I made some attempts to write messages to the trace-buf, but ran =
out
> > > > > of clues*tuits.  And I encountered a couple more definite problem=
s:
> > > > >
> > > >
> > > > Let me dig through test scripts you created and issues you run into=
.
> > > >
> > > >
> > > > > 1- modprobe/rmmod lifecycle probs
> > > > >
> > > > > Ive coded some blue-sky and not-so-proper "modprobe,+T:it,-T:it,r=
mmod"
> > > > > life-cycle scenarios, which can wedge a previously created instan=
ce.
> > > > > Once wedged, I cannot recover.  See the test_private_trace{,_2,_3=
}
> > > > > functions, and the error_log_ref() following each.
> > > > >
> > >
> > > The tests are very useful. I root caused the failures. Please see bel=
ow.
> > >
> > > > > This brittleness begs a question; should we have auto-open (mappi=
ng
> > > > > new names to available 1-63 trc-ids) ?  And non-close ? If it jus=
t did
> > > > > the right thing, particularly on rmmod, it would prevent "misuse"=
.
> > > > >
> > >
> > > I would rather not have auto-open. For me personal argument against i=
t is
> > > that I usually make a lot of typos and with auto-open if I don't
> > > verify what I wrote
> > > I won't know whether logs will be written to the "right" instance or =
a
> > > newly created instance
> > > with typo name. In case of open/close commands error pops up when I
> > > try to write logs
> > > to a trace instance which was not opened.
> >
> > yes. that is a value. auto-open was 1/2 baked speculation
> >
> > >
> > > > > I don't think auto-open obsoletes the open (& esp) close commands=
, but
> > > > > Id like to see scripted test scenarios using close in combo with =
the
> > > > > right /sys/kernel/tracing/* manipulations, to prove its not all j=
ust a
> > > > > fever dream.
> > > > >
> > >
> > > Would you please elaborate what you mean by close in combo with right
> > > /sys/kernel/tracing/* manipulations ?
> > >
> >
> > you detected the furious flapping, didnt you :-)
> >
> > lemme start with the global-events trace-buf, for analogy/comparison.
> > to use it one must do both:
> >  echo 1 > /sys/kernel/tracing/events/dyndbg/enable
> >  echo $some_selection +T > /proc/dynamic_debug/control
> >
>
> Currently if default destination is not set then +T will fail because
> it does not know
> what destination to use. Would you like in this case to use
> prdbg&dyndbg events as
> a default destination instead of failing ?
>
> > using +T:private_buffer no longer requires the enable (im guessing)
>
> It does not require to be enabled
>
> > but are there any other/corresponding setup actions / manipulations ?
> >
>
> We need to call trace_array_get_by_name, it will either create new
> trace instance
> or reuse existing one if it already exists. In both cases it also
> increases reference count of the requested trace instance.
> This is done as a part of open command.
>
> > if nothing else is needed, when does the instance open ?
>
> The open command calls trace_array_get_by_name
>
> > after test-dynamic-debug-doprints on +T:private callsites ?
> > is it detectable from a script ?
> > probably: if [ -e /sys/kernel/tracing/instances/foo ]
> >
> > if the instance is already open, I presume it is not cleared ?
> >
>
> Contents of instance will be preserved
>
> > any other play-nice-with-other-users stuff ?
> >
>
> I will take this into account when creating new tests.
>
> > conversely, to write a closed-loop test-script,
> > should the script just delete the instance/$name
> > after verifying its contents from the last doprints ?
> >
>
> Yes, it makes sense for the test script to delete trace instance at
> the end of a test scenario.
> It will simulate the user action of deleting the instance.
>
> >
> >
> > > > > Your expertise in opening, writing to, manipulating & destroying
> > > > > private (and the global) tracebufs, distilled into new shell func=
s,
> > > > > would be enormously helpful towards demonstrating the private-buf=
fer
> > > > > use case and its value.
> > > > >
> > >
> > > I will work on adding new tests for trace.
> >
> > nice!
> >
> > >
> > > > > 2- some new flags parse error:
> > > > >
> > > > > [ 1273.074535] dyndbg:  32 debug prints in module test_dynamic_de=
bug
> > > > > [ 1273.075365] dyndbg: module: test_dynamic_debug dyndbg=3D"class=
,D2_CORE,+T:foo%class,D2_KMS,+T:foo"
> > > > > [ 1273.076307] dyndbg: query 0: <class,D2_CORE,+T:foo> on module:=
 <test_dynamic_debug>
> > > > > [ 1273.077068] dyndbg: split into words: "class" "D2_CORE" "+T:fo=
o"
> > > > > [ 1273.077673] dyndbg: unknown flag 'c'
> > > > > [ 1273.078033] dyndbg: flags parse failed on 2: +T:foo
> > > > > [ 1273.078519] dyndbg: query 1: <class,D2_KMS,+T:foo> on module: =
<test_dynamic_debug>
> > > > > [ 1273.079266] dyndbg: split into words: "class" "D2_KMS" "+T:foo=
"
> > > > > [ 1273.079872] dyndbg: unknown flag '=EF=BF=BD'
> > > > > [ 1273.080228] dyndbg: flags parse failed on 2: +T:foo
> > > > > [ 1273.080716] dyndbg: processed 2 queries, with 0 matches, 2 err=
s
> > > > > : 0 matches on =3DTl
> > > > >
> > > > > I have a suspicion this relates to moving the parse_flags call in
> > > > > ddebug_query, but I havent dug in.
> > > > >
> > > > >
> > > > > I also have some reservations about the default dest; 1st that it=
 is a
> > > > > global state var, as noted at bottom of control:
> > > > >
> > > > >   [root@v6 lx]# ddgrep \\btrace\\b      # a better/narrower searc=
h-term ?
> > > > >   ...
> > > > >   Default trace destination: foo        # add a '#:' prefix to th=
ese lines ?
> > >
> > > Do you mean
> >
> > This.  it hides the info behind a # so any parser expecting just
> > callsites is safe.
> > and the following colon marks it as info for the clever ones.
> >
> > > #: Default trace destination:
> > > #: Opened trace instances: foo bar buz
> >
>
> Ack
>
> > But I would lalso ike the labels optimized for a tight grep, that wont
> > hit anything else,
> > and mostly thats easy to use.  "trace_dest" almost does it, is a
> > pretty good mark on the bikeshed.
> >
> > > > >   Opened trace instances:               # all values should be on=
 this line
> > > > >
> > >
> > > I will put all opened trace instance names on the same line
> > >
> > > > > Then theres the "preset" value, ie each site's dest_id (sorry I f=
orgot
> > > > > your fieldname).  I presume the default would override such a "pr=
eset"
> > > > > (otherwise it would have no effect).
> > > > >
> > > > > Is the default set on last open ? or on next use of +T:<foo> ?
> > > > >
> > >
> > > Default trace destination is set on [+-]T:<foo>
> >
> > unless foo hasnt been opened, Im guessing
>
> yes foo has to be opened otherwise the command will fail
>
> > does it matter if the last destination used resulted in a match ?
> >
>
> yes it does, if there was no match then such destination will not be
> used for setting default destination
>
> > >
> > > > > In the no-default world, a user/tester would decide how many
> > > > > trace-instances are needed, and map sets of callsites to them.
> > > > >
> > > > >   # configure drm-debug streams for this test scenario
> > > > >   cat<<EOF >/proc/dynamic_debug/control
> > > > >    open drm_core
> > > > >    open drm_mix
> > > > >    open driver_1        # we can separate by modname but not drvr=
-number
> > > > >    open driver_2
> > > > >    class DRM_UT_CORE -T:drm_core        # set dest_id, disabled s=
tate
> > >
> > > This sets default trace destination to drm_core
> > >
> > > > >    class DRM_UT_CORE +mf                # traces dont do prefixin=
g (should it?)
> > >
> > > In this case logs will be neither written to syslog nor trace because
> > > both pT flags are not set.
> >
> > I think my example fails to illuminate the corner I seek.
> >
>
> What corner case did you try to emphasize here ?
>
> > > I verified that both output to trace instance and trace events honors
> > > mf flags (prefixing) when they are set for a given callsite.
> >
> > Ok. that is good to know.  that sounds reducible to a test-fn.
> >
> > >
> > > > >    # mix KMS & ATOMIC into 1 stream
> > > > >    class DRM_UT_KMS -T:drm_mix
> > > > >    class DRM_UT_ATOMIC -T:drm_mix
> > > > >   EOF
> > > > >
> > > > > Then perhaps to turn on/off when needed: (legacy analogue version=
)
> > > > >
> > > > >   echo 0x15 > /sys/module/drm/parameters/debug_trace
> > > > >
> > > > > With those trace-dest presets honored, the configured drm_core &
> > > > > drm_mix streams persist.  If a later enablement applies the
> > > > > then-current default trace-dest, it would spoil this scheme.
> > > > >
> >
> > so each callsite has a dest, which is set individually when the
> > callsite is selected
> > and -T:name'd in the EOF block.
> >
> > I would *not* want enablements of those callsites to alter the dest
> > just because
> > the default-dest were altered in the interim.
> >
> > I think it would break the way drm.debug is supported, by only
> > touching the T bit.
> >
>
> If I understood you correctly -T: <trace_name> should preset only
> destination for a given callsite(s) and
> not a global default destination ?
>
> >
> > > > > Could you elaborate a scenario or 2 where the default behavior do=
es
> > > > > something specific, and that its the right thing ?  I dont unders=
tand
> > > > > it yet.
> > > > >
> > >
> > > I'm a bit lost here. Help me out please. What do you mean by default =
behavior ?
> >
> > default behavior is what happens when +T (wo a dest) is done,
> > after a default dest has been set.  w/o a default-dest, it would be jus=
t :0
> >
> > So having a default dest means implying the :default_dest_name.
> > whatever it is set to,
> > on whatever callsites are selected, unless the ddcmd gives a name, ie
> > +T:this_buf
> >
> > As of last writing, I dont see how the extra implication helps.
> > It feels like hidden state.
> >
>
> Yes it can be misleading.
>
> > I can squint at it and see a local / loop var, fwiw.
> >
>
> Maybe let's get rid of default global destination and when +T will be
> provided without a name
> then it will always default to trace events (:0). Apart from that we
> would have presetting destination with -T:<trace_name> but only for a
> given callsite(s)
>

My statements contradict each other. My proposal is to get rid of
global default destination and when +T will be provided without a name
then preset trace destination will be used. If there is no preset
destination for a given callsite then destination will default to :0
(trace events prdbg&devdbg).
Presetting would be done with -T:<trace_name>

> Thanks,
> Lukasz
>
>
> > > > > OTOH
> > > > >
> > > > > One limitation of the above: the drm.debug_trace (posited above) =
would
> > > > > turn on all Ts in all those class'd callsites across the whole
> > > > > subsystem, irrespective of their preconfigured destination.  That=
 was
> > > > > always inherent in drm.debug, but its less than perfect.
> > > > >
> > > > > It sort-of defeats the point of doing +T only on the useful calls=
ites.
> > > > >
> > > > > And global event buf is also enabled, it might be flood-prone.
> > > > >
> > > > >   echo 1 > /sys/kernel/tracing/events/dyndbg/enable
> > > > >
> > > > > It would help if we could filter on trace-instance names:
> > > > > (this sounds familiar :-)
> > > > >
> > > > >   ddcmd module '*' trace_dest drm_mix +T
> > > > >
> >
> > I think we need to implement this new keyword selector,
> > I think it addresses the flooding possible above,
> > when using both private traces and the global-trace.
> >
> > but we dont need it yet.
> >
> > > > > In reality, the dest-id is not even dependent on tracing per-se, =
it is
> > > > > a user classification system (in contrast to class <subsys-names>=
).
> > > > > It just happens to be tied by +T:name syntax to tracefs.
> > > > >
> > > > > No promise about +p:_alt_log_.mflt having meaning, or working.
> >
> > or not complaining, pr_notice ?
> >
> >
> > > > >
> > > > >
> >
> > I look forward to v3
> > Jim

