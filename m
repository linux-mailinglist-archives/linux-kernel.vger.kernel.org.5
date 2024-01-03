Return-Path: <linux-kernel+bounces-15748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60774823144
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56301F22F05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC31C280;
	Wed,  3 Jan 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="UDFTWUbU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0B1BDC5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5553f251e3cso4926412a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1704299243; x=1704904043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+gXPoFj+xyvTeQBqLzl5xlRtosraSd9+y+s3mPe24s=;
        b=UDFTWUbUWx00vd1WB3/wQ/5I/LDnVdoeisfyLeNDhiI45vTUteSU7DqjNfY5G015b3
         WmrBfTBHM4g/+urGtG8eZ+Dhv8NlArGtDmscX/BxB8drBzSpJwOeX+IbagnLbYx4TIUD
         1FwUmXIL16QXDBqBUVPREaiObT6yXKtW/b10I4mVidpwjExQC0jIcPeiCJBlGacafDyO
         RN2lqZWJ+/ZjZLIzgc6mMVHJU/a1D6hJRn2sC/KkUjykBO0sV6/fB9+ui+Lvg96HjRkF
         0Ks3oPeyE/HVK/5HquzbyMoERhbveS8kSmj7vxcpx+qMEBfe9kpJIgrvRRqOio7DQ+CD
         S7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299243; x=1704904043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+gXPoFj+xyvTeQBqLzl5xlRtosraSd9+y+s3mPe24s=;
        b=qkRWBDuhEF53J9cqb98yKmpfSUsaNJwNLaaUM2CglFbMOf6TQEzKu+2+HkmAwaJyxW
         YbVSg3bGdP6p31cd2ibv7xOX4d7tCpc5WuejW3+JM2N2uppW6aSJ18CMSgF8G++AHL2w
         04ZRgNXwDO3jwa+V9UHwuIeQjeeKRlEKxJgcM3Kv7TbfYmvWSBqt8JEtsTLqQsa4agJi
         +q/lgbIpfpcWIUC7dkkoxowcEGkEoh6Huk8r5nt4OelVbVI501ZaZxX6TuOUoNOvScxN
         RPPEGogcflWvGaN2hxqueYyjEBgymWfovZjEBAqBfRFRYzuL5Bk935Gy/Rh0FJrN8BzN
         RcmA==
X-Gm-Message-State: AOJu0YyDqwjsJAGQLo9RCZASKfyBbCgsM43IGAsS0CXljjRgMc4dDnv8
	qNylpOop9AoWQEhLBw/kZpSF5PMcVd00dZsNgi6apKGnLI9Z
X-Google-Smtp-Source: AGHT+IGPr/EwlMq15oOB2u3V7FblerCEIaH3OPzKs3osZSkBZYcfP+0md/Dby06bmZH1CDR99Fb6HJpebhTq6yK/XLg=
X-Received: by 2002:a50:9f0f:0:b0:553:3b07:620a with SMTP id
 b15-20020a509f0f000000b005533b07620amr14441634edf.36.1704299242769; Wed, 03
 Jan 2024 08:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223015131.2836090-1-lb@semihalf.com> <CAJfuBxyN+t6OgzzX3ZT6MxdMT6Awr29orJAucVMDz2zmEFCDDQ@mail.gmail.com>
 <CAK8Bye+qsm6stNnREb__jhAqUukmkcf0Pt6W1y3VwXnz7tUbww@mail.gmail.com> <CAJfuBxz7LXmOujY5giqZ96hKYm3cMUMmbf3DnEm9sJMzJg9UzA@mail.gmail.com>
In-Reply-To: <CAJfuBxz7LXmOujY5giqZ96hKYm3cMUMmbf3DnEm9sJMzJg9UzA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Wed, 3 Jan 2024 17:27:11 +0100
Message-ID: <CAK8ByeKpOxp-nZKWh3+H-aYg+EgeEVxXzx9aheBzb41KQR4dNw@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] dyndbg: add support for writing debug logs to trace
To: jim.cromie@gmail.com
Cc: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Guenter Roeck <groeck@google.com>, Yaniv Tzoreff <yanivt@google.com>, Benson Leung <bleung@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Simon Ser <contact@emersion.fr>, 
	John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, 
	upstream@semihalf.com, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 2 sty 2024 o 20:13 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> ok, to catch up here,
> Lukas & I have been nudging the test script forward,
> some of this is settled..
>
> On Thu, Dec 28, 2023 at 5:00=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > =C5=9Br., 27 gru 2023 o 05:23 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > re-adding gregkh, who fell off the cc's again.
> > > he is one of our upstreams.
> > >
> >
> > hi Jim,
> >
> > It's good to hear from you.
> >
> > Thanks. I missed to add Greg.
> >
> > > On Fri, Dec 22, 2023 at 6:51=E2=80=AFPM =C5=81ukasz Bartosik <lb@semi=
half.com> wrote:
> > > >
> > > > Add support for writing debug logs to trace events and trace instan=
ces.
> > > > The rationale behing this feature is to be able to redirect debug l=
ogs
> > > > (per each callsite individually) to trace to aid in debugging. The =
debug
> > > > logs output to trace can be enabled with T flag. Additionally the T=
 flag
> > > > accepts trace destination which can be provided to the T flag after=
 ":".
> > > > The trace destination field is used to determine where debug logs w=
ill be
> > > > written.
> > > >
> > > > In order to redirect callsite debug log to a trace instance it has =
to be
> > > > initialized first with a newly introduced "open" command. For examp=
le,
> > > > "usb" trace instance in <debugfs>/tracing/instances/ can be initial=
ized
> > > > by issuing the command:
> > > >
> > > > localhost ~ # echo "open usb" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > >
> > > > If the trace instance <debugfs>/tracing/instances/usb already exist=
s
> > > > then it will be reused otherwise new usbcore instance will be creat=
ed.
> > > > Maximum 63 trace instances can be "opened". The trace instance name=
 can
> > > > include any of ^\w+ and underscore characters. There is also a spec=
ial
> > > > name "0" reserved for writing debug logs to trace prdbg and devdbg =
events.
> > > > The reserved name "0" does not require to be "opened" before use.
> > >
> > > theres implication here that p only works when :0.
> > > Is that intended ?
> > > it seems wrong, or at least unnecessary.
> > >
> >
> > I don't see clearly the implication that p only works when :0.
> > Which statement implies this to you ? Please keep in mind that English
> > is not my native.
>
> heh - Im not sure now - its mostly me probing for unseen inconsistencies.
>
> > > In fact, theres no specific reason to exclude +p:trcbuf.mf,
> > > esp if we keep default-trace-buf
> > > since +pTfml  could have that meaning implicitly.
> > > We can call it allowed and "unimplemented until proven useful" on +p
> > >
> > > +p completely independent of +T is a simplicity,
> > > lets keep that until proven useful otherwise.
> > >
> > > >
> > > > To enable writing usbcore module debug logs to the "usb" trace inst=
ance
> > > > opened above a user can issue the command:
> > > >
> > > > localhost ~ # echo "module usbcore =3DpT:usb" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > >
> > > > Please note that output of debug logs to syslog (p flag) and trace =
(T flag)
> > > > can be independently enabled/disabled for each callsite. Therefore =
the
> > > > above command will enable writing of debug logs not only to the tra=
ce
> > > > instance "usb" but also to syslog.
> > > >
> > > > When trace destination is followed by another flag the next flag ha=
s to
> > > > be preeceded with ".", for example
> > > >
> > > > localhost ~ # echo "module usbcore =3DpT:usb.l" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > >
> > > > To simplify processing trace destination can be omitted when defaul=
t
> > > > trace destination is set, for example the command
> > > >
> > > > localhost ~ # echo "module usbcore =3DpTl" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > >
> > > > will use default trace destination. If default trace destination is=
 not
> > > > set the above command will fail. The default trace destination is s=
et
> > > > when a command with any of the flags [-+=3D] and explicitly provide=
d trace
> > > > destination matches at least one callsite, for example the command
> > > >
> > > > localhost ~ # echo "module usbcore -T:usb" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > >
> > > > will disable trace for all usbcore module callsites (if any was ena=
bled)
> > > > and will set "usb" instance as default trace destination. To enable=
 writing
> > > > thunderbolt module debug logs to the "usb" trace instance as well a=
 user
> > > > can issue the command:
> > > >
> > > > localhost ~ # echo "module thunderbolt =3DT" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > >
> > > > Since default trace destination was previously set therefore "usb" =
instance
> > > > name does not have to be explicitly provided.
> > > >
> > > > When no callsite writes debug logs to a trace instance then it can =
be
> > > > released (its reference counter decrased) with the "close" command.
> > > decreased
> > >
> >
> > Ack
> >
> > > > Closing a trace instance make it unavailable for dynamic debug and =
also
> > > makes
> >
> > Ack
> >
> > > > allows a user to delete such a trace instance at convenient time la=
ter
> > > > with rmdir command. For example when "usb" instance is not used any=
more
> > > > a user can issue the command:
> > > >
> > > > localhost ~ # echo "close usb" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > > and then to delete it with:
> > > >
> > > > localhost ~ # rmdir <debugfs>/tracing/instances/
> > > >
> > > > To enable writing usbcore module debug logs to trace dyndbg:prdbg a=
nd
> > > > dyndbg:devdbg events user can issue the command:
> > > >
> > > > localhost ~ # echo "module usbcore =3DT:0" >
> > > >                                 <debugfs>/dynamic_debug/control
> > > >
> > > > Then dyndbg trace events can be for example captured with the comma=
nd:
> > > >
> > > > localhost ~ # trace-cmd start -e dyndbg
> > > >
> > > > And displayed with the command:
> > > >
> > > > localhost ~ # trace-cmd show
> > > >
> > >
> > > is there a recipe to show private traces ? prolly worth a mention her=
e.
> > >
> >
> > Trace-cmd stat shows among other things open trace instances. I will ad=
d it.
> >
> > >
> > > >
> > > >
> > > > Jim, I made a few changes to the test script dd-selftest.rc you cre=
ated
> > > > and I also added new test scenarios. You can find the entire patchs=
et
> > > > with the test script changes on top here
> > > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+lo=
g/refs/sandbox/ukaszb/dyndbg_trace_v3
> > > > I wonder where would be the proper place to store the test script
> > > > (upstream, your github.com:jimc/linux.git)
> > > > Do you have a suggestion for that ?
> > > >
> > >
> > > I got it (your HEAD), renamed and put it in:
> > > tools/testing/selftests/dynamic_debug/
> > > and copied & modified Makefile and config from ../users/
> > > I added your SOB, that seems proper.
> > >
> >
> > Great, thanks ;)
> >
> > > nice additions.  and I like the colors.  maybe they belong in lib.mk,
> > > but thats 4 later.
> > >
> > > and tweaked the modules / DUTs to *hopefully* get stable callsite cou=
nts
> > > from the tests on them, in virtually any usable config.
> > > DUTs: file init/main, module mm_init, and module test_dynamic_debug (=
a
> > > config constraint)
> > > The ref-counts are taken from a default virtme-ng -k config on my x86=
-64 box
> > >
> > > I now pass tests up to:
> > >
> > > [root@v6 wk-proof]# ./tools/testing/selftests/dynamic_debug/dyndbg_se=
lftest.sh
> > > ...
> > > # TEST_PRIVATE_TRACE_6
> > > [ 1009.296557] dyndbg: read 3 bytes from userspace
> > > [ 1009.296876] dyndbg: query 0: <=3D_> on module: <*>
> > > [ 1009.297171] dyndbg: processed 1 queries, with 1559 matches, 0 errs
> > > [ 1009.311621] dyndbg: read 39 bytes from userspace
> > > [ 1009.312032] dyndbg: query 0: <open
> > > A_bit_lengthy_trace_instance_name> on module: <*>
> > > [ 1009.312569] dyndbg: instance is already opened
> > > name:A_bit_lengthy_trace_instance_name
> > > [ 1009.313063] dyndbg: processed 1 queries, with 0 matches, 1 errs
> > > : ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:454
> > > ddcmd() expected to exit with code 0
> > > Error: 'File exists'
> > >
> > > it seems invocation dependent
> > > I suspect 2 possibilities:
> > > 1-  invoking as shell-script, repeatedly vs vng -e script-name
> > > (one-shot per boot)
> > > 2- virtme-ng's minimal-default config has no CONFIG_USB.
> > >    this changes post-conditions of the script, affecting precondition=
s
> > > of the next run.
> > >
> >
> > I guess you must have enabled CONFIG_USB in your setup otherwise
> > dyndbg_selftest.sh should fail earlier in TEST_PRIVATE_TRACE_5 ?
> >
>
> Its usually on, but I have at least one config,
> IIRC from default vng -vk, that left it off.
>
> whats the shell syntax to check CONFIG_MODULES ?
>

Please elaborate what would you like to check ?

> ATM, basic-tests uses "module main" (maybe worth narrowing)
> comma-terminator-tests uses "module params"
> test-percent-splitting uses test_dynamic_debug to demo a useful case,
> so it needs MODULES
> so does the self-start-various-end tests
>
> the private-trace tests appear to use a mix of
> test_dynamic-debug, & module params,
> maybe that can be materially improved, I dont know.
>
> IIRC for builtins I think we're now using 'file kernel/

We can narrow further check conditions when there are different
results on different kernel versions.

> > > 2 means that we should replace usbcore with some other always *builti=
n* module.
> > >
> >
> > Sounds good. Do you have a module candidate ?
>
>
>
> >
> > I'm also concerned that we might need to validate dyndbg_selftest.sh
> > against specific kernel version because
> > I took the dyndbg_selftest.sh from lukas-v3.0 branch and I had to do
> > the following changes to make it work on kernel v6.6:
> >
>
> Yes, I hit this one too.
> I decided to avoid using mm_init for this reason.
> (without actually looking whether it was a config-based variance,
> which I assumed, or a commit-based one)
> I chose 'module params' instead,
> despite the need to escape the brackets in the search:
>
>     check_match_ct '\[params\]' 4
>

When I took dyndbg_selftest from top of dd-classmaps2-on-lukas-v3.1
branch I had two check_match_ct errors but these were caused by too
loose check conditions.
After narrowing conditions all tests passed on top of v6.6 kernel.

> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > @@ -166,12 +166,12 @@ EOF
> >  function comma_terminator_tests {
> >      echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
> >      # try combos of space & comma
> > -    check_match_ct mm_init 5
> > +    check_match_ct mm_init 4
> >      ddcmd module,mm_init,=3D_            # commas as spaces
> >      ddcmd module,mm_init,+mpf          # turn on non-classed
> > -    check_match_ct =3Dpmf 5
> > +    check_match_ct =3Dpmf 4
> >      ddcmd ,module ,, ,  mm_init, -p    # extra commas & spaces
> > -    check_match_ct =3Dmf 5
> > +    check_match_ct =3Dmf 4
> >      ddcmd =3D_
> >  }
> >  function test_percent_splitting {
> > @@ -350,7 +350,7 @@ function test_private_trace_3 {
> >      ddcmd class D2_CORE +T:foo \; class D2_KMS +T:foo
> >      ddcmd "class,D2_CORE,+T:foo;,class,D2_KMS,+T:foo"
> >      ddcmd class,D2_CORE,+T:foo\;class,D2_KMS,+T:foo
> > -    check_match_ct =3DT 2 -v
> > +    check_match_ct =3DT 3 -v
> >      check_match_ct =3DTl 0
> >      check_match_ct =3DTmf 0
> >      echo 1 >/sys/kernel/tracing/tracing_on
> > @@ -379,7 +379,7 @@ function test_private_trace_4 {
> >      modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+T:foo%class,D2=
_KMS,+T:foo
> >      check_match_ct =3DTl 0
> >      check_match_ct =3DTmf 0
> > -    check_match_ct =3DT 2
> > +    check_match_ct =3DT 3
> >      echo 1 >/sys/kernel/tracing/tracing_on
> >
> > What kernel version did you use for the testing ?
>
> turns out Im on top of -rc7
> (I suppose I should pay closer attention :-)
>
>
> > > I chose module params, on the idea that its builtin, but also invoked=
 later,
> > > when modules are modprobed with params, so its callsites can be enabl=
ed &
> > > then invoked via do_prints, to test for writes to the private trace-b=
uf.
> > >
> > > I've pushed it to lukas-v3.0 at jimc.github.com/linux
> > >
> > > Would you look at err on _6, above,
> > > and figure out if its insufficiently robust to test preconditions, or
> > > something else ?
> >
> > The following change fixes failure in TEST_PRIVATE_TRACE_6:
> > @@ -455,7 +455,7 @@ function test_private_trace_6 {
> >      ddcmd open $name
> >      is_trace_instance_opened $name
> >      check_trace_instance_dir $name 1
> > -    ddcmd "module module =3DT:$name.l" -v
> > +    ddcmd "module usbcore =3DT:$name.l"
> >      check_match_ct =3DT:A_bit_lengthy_trace....l 164
> >
> > When dyndbg_selftest.sh completes with success which is announced by th=
e line
> > # Done on: Thu Dec 28 23:04:17 CET 2023
> > then it leaves dynamic debug and trace in a state where next
> > dyndbg_selftest.sh run should also complete with success.
>
> yes .this works well for vng -e <script-path> runs
>
> > But when any of the tests fails manual intervention or reboot is
> > required at the moment.
> > Do you think we should have a cleanup function and call it whenever
> > dyndbg_selftest.sh fails in order
> > to prepare dynamic debug and trace for the next run of dyndbg_selftest.=
sh ?
> >
>
> yes, I think so.
> In part to prove that we can "un-wedge" whatever's wrong w/o a reboot.
> and/or a rmmod, modprobe cycle.
> self_end_* are doing various unwinds,
> but a full-powered cleanup fn, with diagnostics and hints
> would be a good addition, with demonstration value.
>

I will create such a cleanup function.

>
>
> > > and also:
> > > rename test_private_trace_N() to better names
> > > - and/or comments to intent & pattern of use
> > > more tweaks invited in its commit-msg
> > >
> >
> > I will rename the functions and add description of the tests.
> >
> > > since cycle_test_problem() is not actually a problem, whats a better =
name ?
> > > _not_best_practices ?
> > >
> >
> > Ack
> >
> > > I think the final test script enhancement needed is (maybe separately=
):
> > > private-buffer-expected-write-verification after do_prints,
> > > and around modprobe test_dynamic_debug dyndbg=3D$multicmd
> > > subject to 2 below.
> > >
> >
> > Ack
>
> we definitely have this in part, spread around the dozen or so functions
>

I will create new test to match the criteria above.

> >
> > > > TODOs:
> > > > - update dynamic debug documentation,
> > > > - finalize discussion related to default trace destination
> > > > (whether we want it at all, if yes then conclude on the details)
> > > >
> > >
> > > good list. before docs;
> > >
> > > wrt default-trace, at least in some details, it seems extra rules to =
know.
> > > for example, if the default were set on successful open,
> > > rather than successful rule application (iirc), then it would read a =
lot
> > > like "with" or "using" blocks, esp with <<EOX form
> > >
> > > with that new form, it might be pretty expressive:
> > >
> > > echo <<YMMV > /proc/dynamic_debug/control
> > >   open sesame # ie with
> > >     module magic_carpet function forward +Tfml
> > >     module magic_lamp function rub_vigorously +Tfmt
> > >   open voicetrace
> > >     module voice2ai function text2cmdprompt +T
> > >     module undo function oh_crap +T
> > > YMMV
> > >
>
> I was hoping this example was stupid enough to goad someone
> into responding (with a better one).  Alas no.
>
> How might DRM want to use this ?
>
> one practical example is to segregate hi-rate drm_dbg events to a
> separate buffer,
> so theyre not cluttering your trace-cmd view until you want them.
>
> But thats a little contrived, cuz vblank events are already trace-events
> into the global buffer, they dont have drm_dbg's for this.
>
>
> echo <<DRM_TRACE_BLK > /proc/dynamic_debug/control
>
>    open vblank_stream      # segregate noisy/hi-vol stuff
>
>      module amdgpu format *_vblank            +:vblank_stream   # one
> way to select them
>      module amdgpu format "[DML]:DML_"   +:vblank_strem   # pretty
> much same set ?
>
>    open drm_generic
>        class DRM_CORE +:drm_generic.mf
>        class DRM_DRIVER_ +:drm_generic.tmf
>
> DRM_TRACE_BLK
>
>
>
> > > I think set-default-on-good-rule-applied is flawed:
> > > it relies on the most complex expression in the grammar to be correct
> > > and without spelling errors, where module unknown is
> > > OK grammatically, but nonsense.
> >
> > in case of "unknown" module default trace destination will not be
> > updated because
> > the code checks for nfound before updating  default destination:
> > if (nfound)
> >     update_tr_default_dst(modifiers);
> >
> > > set-default-on-open is simpler to explain and test separately.
> > >
> >
> > Actually I think we discussed set-default-on-open some time ago (in
> > the beginning).
>
> we could have - I miss a lot :-}
> anyway youve named our choices:
>
> > But to sum up the default trace destination there were 3 directions
> > proposed/discussed:
> > - set-default-on-open,
> > - set-default-on-good-rule-applied,
>
> note in my DRM_TRC_BLK example above, I made a  subtle error.
> DRM_DRIVER_ doesnt exist cuz of the trailing _.
> non-matching keywords are silently skipped. (not just class)
> the rule wont apply.
> If Id misspelled it as DRM_DRIVERS it would be just as quiet.
>
> So now the good/bad status creates an order-dependence;
> if the rule is 1st in a set, good/bad chooses the new/old default-dest.
> and this affects any following rule, unless that has an explicit dest.
> This sounds complicated.
>

I agree but I think the order-dependence issue also applies to open.
Let me explain below.

> set-default-on-open  doesnt have these problems:
> each rule gets the same setting
>

Let's assume the following multi line command:
echo "open usb" > /proc/dynamic_debug/control  # usb becomes default
trace destination
echo "module usbcore =3DT" > /proc/dynamic_debug/control # use usb as
trace destination
echo "open tbt" > /proc/dynamic_debug/control
echo "module thunderbolt =3DT" > /proc/dynamic_debug/control

Now the thunderbolt debug logs will be written to tbt trace (when
"open tbt" succeeds) or to usb trace (when "open tbt" fails)

> > - preset-default-per-each-callsite with -T:trace_dest_name,
>
> this doesnt have a default-setting, it keeps what it had
>
> >
> > All 3 pass information explicitly but IMHO
> > preset-default-per-each-callsite is most confusing as user would have
> > to remember what was preset for a given callsite when later passing a
> > T flag for the same callsite.
> >
>
> thats true, but for:
> We could display the current destination in control, independent of the f=
lags
> (with the :0. default elided)
>
> init/main.c:1117 [main]initcall_blacklist =3DpT:startup_trc.mf
> "blacklisting initcall %s\n"
> init/main.c:1156 [main]initcall_blacklisted =3DT:startup_trc.mf
> "initcall %s blacklisted\n"
> init/main.c:1351 [main]run_init_process =3D:startup_trc.mf "  with argume=
nts:\n"
>
> 1st line writes to syslog and to private startup_trc, both with
> "module:function:"  dynamic-prefix
> 2nd only to the private trace, with same prefix
> 3rd is not enabled, but has its dest preset to the private trace,
> again with the prefix.
>

Yes we can display preset trace destination even when T flag is not
set for a given callsite.
I just wonder how much this approach of presetting trace destination
per callsite would be helpful to users ?

> And the part I glossed over:
> a new "trace_name" keyword would allow selection on the composed set
> of sites with that preset.
>
>    ddcmd  trace_name drm_generic +Ts     # enable the set which is
> pointing at drm_generic
>

How in this case drm_generic would be created ? Or is it just a
string/regexp which is used to select callsites ?

>
>
> > Then if it comes to set-default-on-open vs
> > set-default-on-good-rule-applied I don't have strong opinion but I
> > would
> > lean towards set-default-on-open because in this case it is pretty
> > straightforward, I mean last successful open sets default trace
> > destination.
>
> of the 1st 2 options, I lean strongly to on-open.
>

I realized there is one IMHO major advantage of
set-default-on-good-rule-applied over set-default-on-open because
it allows to change default destination without any side effects (
-T:trace_name on callsite which does not have T flag set) while
set-default-on-open causes side effect to change default destination
as new trace instance is opened as a result.

> To test the limits, what if we renamed "open" to "using" ?
> using could:
> a) force a dest update, from any previous state.
> b) only upgrade from :0.  dont change :foo.
>
> a is unnecessary, since +T:dest.  explicitly does that.
> b is more subtle, but more useful.
>

Or instead of using all this magic to implicitly set trace default
destination with set-default-on-open or
set-default-on-good-rule-applied we could create "using" command
to explicitly set default trace destination ?

> >
> > If you also hesitate which one to choose maybe we should start with
> > very simple approach like that +T always defaults to trace events (:0)
> > ?
>
> that makes sense.
> keep-presets-per-callsite does need keyword to be complete.
>
> >
> > > We should probably consider modifying the continue-looping behavior
> > > of ddebug_exec_queries, depending upon the return-code.
> > > open, close errors could reasonably warrant different treatment,
> > > like terminating the mult-cmd loop prematurely on open/close errs.
> > > Esp if we keep the set-default-on-good-rule-applied
> > > What do you think ?
>
> this is still open, and worth a review, but minor.
>

It makes sense to me to end multi command loop on open or close error.

> > Let's first conclude on default destination.
> >
> > > I'm inclined to reword a commit-msg or 2, drop RFC, obsolete comments=
 etc.
> > >
> > > I can do that in a lukas-v3.1, or as in-thread responses,
> > > do you have a preference ?
> >
> > Please go ahead and make changes in the lukas-v3.1 branch. I find it
> > very convenient. I will just grab your changes from the branch.
>
> excellent, it does feel pretty smooth.
> is your repo also public, or did I just miss the clonable url?
>

Please try this:
git clone https://chromium.googlesource.com/chromiumos/third_party/kernel

kernel$ git ls-remote origin "refs/sandbox/ukaszb/*"
bdd057746b50a2f1c54b45274c60a51e64040b1f refs/sandbox/ukaszb/dyndbg_trace_v=
1
d07d243aba25650fc791c8af0c95d3904c64e043 refs/sandbox/ukaszb/dyndbg_trace_v=
3

git fetch origin refs/sandbox/ukaszb/dyndbg_trace_v3

> I'll write some trace-thing for howto in the next few days,

Great.

> (in particular, I'll stay out of dyndbg_selftest.sh, I think its your tur=
n :-)
>

Yeah, it's my turn to add more colors ;).

> theres also s/coma/comma/ in the comma-separator patch.
>

Thanks for reminding me.

Thanks,
Lukasz


>
> thats all I got now,
> Thanks!!
> Jim

