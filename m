Return-Path: <linux-kernel+bounces-12887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30581FC1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AAB1C21223
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866410A1C;
	Fri, 29 Dec 2023 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="SqPXQgF+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731010A0A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e766937ddso4177042e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703808038; x=1704412838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw+biSFwKTFY6IcgtYFc1HH3o7YXLZRWKB85t2pUe2M=;
        b=SqPXQgF+yiXqasiLnsSz1rHoCaVea3p9nJHGV8gXYaysQil3toHDMBn/TiK+Jt6WmH
         lJXTXWJqyJzDV0AvGaI+/tgypodFnRm9XR5F7ZzeQcQ1bi4Lp1wB8t2MOb3FysMNOMdi
         CzkBENEoLTm17sCRmHqAYHYCRhSFF9bV4k1JVoZhItTHzoQ6xGTMpMivS1PvIGeq66Nr
         mBr7CO/3rRdjgk36xMXXFHfRy4TMNzQV2VU9s0DSGeNILTTXCjjZmUERhYFaWrSxCr4i
         uAml9DoTvqciFKvLMyuQfDh/1DUGxuo7nUWq0RKVn0sw6vM6zUMq3Za44DKfi2GT7UwJ
         gG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703808038; x=1704412838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw+biSFwKTFY6IcgtYFc1HH3o7YXLZRWKB85t2pUe2M=;
        b=hKP61NV4Nw/qXXmlqC/sKnwdcqOy2s6IRfhUpUBGyb3IMLnuRqv+1gNsgHbkKrcrZI
         hSZ9RJj0ejaHqCiuqO7BscTvok+wxsrp8BLaB1AAMQMCmI4iW6xhb2JkXTQT4Yz83M17
         0nCTAxvBLTZi1Rxf+tFEvi9FiGkoehVicUeHaZTipklsPOaq5t8rCrQzGwuVTx4HzubJ
         vHWmzlbLZCBNnWSmVez5j478HQtm/1Q2Jv8FSjO2alhURDxDrCnbv2r71c0zYyRZ5JRZ
         ijUQYePurNoG2Bg7fG3W2LgWnDy7Mu5DA4/MOOKExcj6F+YpxhufN+QyI3FmrBsQ+Y/7
         R+BA==
X-Gm-Message-State: AOJu0YyPUIzLXJQGEu38WPY/v6agZ8tOiDH1wu5Zm/Qq5XpL4jPxl7qR
	H5sgffiMi6Vt+fB1m53L+R68Yzo1JhP3LyY44qe8vQB2L61v
X-Google-Smtp-Source: AGHT+IFHQ3l4zzCFn37JWuKrl5i/RfPLKp3dnxi335d+DqrTAkTawfUJ+iKt825vLf3vT9mM0rl9rmtE/X50C3L9wm0=
X-Received: by 2002:ac2:548b:0:b0:50e:3e42:7422 with SMTP id
 t11-20020ac2548b000000b0050e3e427422mr4476142lfk.114.1703808037301; Thu, 28
 Dec 2023 16:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223015131.2836090-1-lb@semihalf.com> <CAJfuBxyN+t6OgzzX3ZT6MxdMT6Awr29orJAucVMDz2zmEFCDDQ@mail.gmail.com>
In-Reply-To: <CAJfuBxyN+t6OgzzX3ZT6MxdMT6Awr29orJAucVMDz2zmEFCDDQ@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Fri, 29 Dec 2023 01:00:26 +0100
Message-ID: <CAK8Bye+qsm6stNnREb__jhAqUukmkcf0Pt6W1y3VwXnz7tUbww@mail.gmail.com>
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

=C5=9Br., 27 gru 2023 o 05:23 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> re-adding gregkh, who fell off the cc's again.
> he is one of our upstreams.
>

hi Jim,

It's good to hear from you.

Thanks. I missed to add Greg.

> On Fri, Dec 22, 2023 at 6:51=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > Add support for writing debug logs to trace events and trace instances.
> > The rationale behing this feature is to be able to redirect debug logs
> > (per each callsite individually) to trace to aid in debugging. The debu=
g
> > logs output to trace can be enabled with T flag. Additionally the T fla=
g
> > accepts trace destination which can be provided to the T flag after ":"=
.
> > The trace destination field is used to determine where debug logs will =
be
> > written.
> >
> > In order to redirect callsite debug log to a trace instance it has to b=
e
> > initialized first with a newly introduced "open" command. For example,
> > "usb" trace instance in <debugfs>/tracing/instances/ can be initialized
> > by issuing the command:
> >
> > localhost ~ # echo "open usb" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > If the trace instance <debugfs>/tracing/instances/usb already exists
> > then it will be reused otherwise new usbcore instance will be created.
> > Maximum 63 trace instances can be "opened". The trace instance name can
> > include any of ^\w+ and underscore characters. There is also a special
> > name "0" reserved for writing debug logs to trace prdbg and devdbg even=
ts.
> > The reserved name "0" does not require to be "opened" before use.
>
> theres implication here that p only works when :0.
> Is that intended ?
> it seems wrong, or at least unnecessary.
>

I don't see clearly the implication that p only works when :0.
Which statement implies this to you ? Please keep in mind that English
is not my native.

> In fact, theres no specific reason to exclude +p:trcbuf.mf,
> esp if we keep default-trace-buf
> since +pTfml  could have that meaning implicitly.
> We can call it allowed and "unimplemented until proven useful" on +p
>
> +p completely independent of +T is a simplicity,
> lets keep that until proven useful otherwise.
>
> >
> > To enable writing usbcore module debug logs to the "usb" trace instance
> > opened above a user can issue the command:
> >
> > localhost ~ # echo "module usbcore =3DpT:usb" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > Please note that output of debug logs to syslog (p flag) and trace (T f=
lag)
> > can be independently enabled/disabled for each callsite. Therefore the
> > above command will enable writing of debug logs not only to the trace
> > instance "usb" but also to syslog.
> >
> > When trace destination is followed by another flag the next flag has to
> > be preeceded with ".", for example
> >
> > localhost ~ # echo "module usbcore =3DpT:usb.l" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > To simplify processing trace destination can be omitted when default
> > trace destination is set, for example the command
> >
> > localhost ~ # echo "module usbcore =3DpTl" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > will use default trace destination. If default trace destination is not
> > set the above command will fail. The default trace destination is set
> > when a command with any of the flags [-+=3D] and explicitly provided tr=
ace
> > destination matches at least one callsite, for example the command
> >
> > localhost ~ # echo "module usbcore -T:usb" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > will disable trace for all usbcore module callsites (if any was enabled=
)
> > and will set "usb" instance as default trace destination. To enable wri=
ting
> > thunderbolt module debug logs to the "usb" trace instance as well a use=
r
> > can issue the command:
> >
> > localhost ~ # echo "module thunderbolt =3DT" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > Since default trace destination was previously set therefore "usb" inst=
ance
> > name does not have to be explicitly provided.
> >
> > When no callsite writes debug logs to a trace instance then it can be
> > released (its reference counter decrased) with the "close" command.
> decreased
>

Ack

> > Closing a trace instance make it unavailable for dynamic debug and also
> makes

Ack

> > allows a user to delete such a trace instance at convenient time later
> > with rmdir command. For example when "usb" instance is not used anymore
> > a user can issue the command:
> >
> > localhost ~ # echo "close usb" >
> >                                 <debugfs>/dynamic_debug/control
> > and then to delete it with:
> >
> > localhost ~ # rmdir <debugfs>/tracing/instances/
> >
> > To enable writing usbcore module debug logs to trace dyndbg:prdbg and
> > dyndbg:devdbg events user can issue the command:
> >
> > localhost ~ # echo "module usbcore =3DT:0" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > Then dyndbg trace events can be for example captured with the command:
> >
> > localhost ~ # trace-cmd start -e dyndbg
> >
> > And displayed with the command:
> >
> > localhost ~ # trace-cmd show
> >
>
> is there a recipe to show private traces ? prolly worth a mention here.
>

Trace-cmd stat shows among other things open trace instances. I will add it=
.

>
> >
> >
> > Jim, I made a few changes to the test script dd-selftest.rc you created
> > and I also added new test scenarios. You can find the entire patchset
> > with the test script changes on top here
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/re=
fs/sandbox/ukaszb/dyndbg_trace_v3
> > I wonder where would be the proper place to store the test script
> > (upstream, your github.com:jimc/linux.git)
> > Do you have a suggestion for that ?
> >
>
> I got it (your HEAD), renamed and put it in:
> tools/testing/selftests/dynamic_debug/
> and copied & modified Makefile and config from ../users/
> I added your SOB, that seems proper.
>

Great, thanks ;)

> nice additions.  and I like the colors.  maybe they belong in lib.mk,
> but thats 4 later.
>
> and tweaked the modules / DUTs to *hopefully* get stable callsite counts
> from the tests on them, in virtually any usable config.
> DUTs: file init/main, module mm_init, and module test_dynamic_debug (a
> config constraint)
> The ref-counts are taken from a default virtme-ng -k config on my x86-64 =
box
>
> I now pass tests up to:
>
> [root@v6 wk-proof]# ./tools/testing/selftests/dynamic_debug/dyndbg_selfte=
st.sh
> ...
> # TEST_PRIVATE_TRACE_6
> [ 1009.296557] dyndbg: read 3 bytes from userspace
> [ 1009.296876] dyndbg: query 0: <=3D_> on module: <*>
> [ 1009.297171] dyndbg: processed 1 queries, with 1559 matches, 0 errs
> [ 1009.311621] dyndbg: read 39 bytes from userspace
> [ 1009.312032] dyndbg: query 0: <open
> A_bit_lengthy_trace_instance_name> on module: <*>
> [ 1009.312569] dyndbg: instance is already opened
> name:A_bit_lengthy_trace_instance_name
> [ 1009.313063] dyndbg: processed 1 queries, with 0 matches, 1 errs
> : ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:454
> ddcmd() expected to exit with code 0
> Error: 'File exists'
>
> it seems invocation dependent
> I suspect 2 possibilities:
> 1-  invoking as shell-script, repeatedly vs vng -e script-name
> (one-shot per boot)
> 2- virtme-ng's minimal-default config has no CONFIG_USB.
>    this changes post-conditions of the script, affecting preconditions
> of the next run.
>

I guess you must have enabled CONFIG_USB in your setup otherwise
dyndbg_selftest.sh should fail earlier in TEST_PRIVATE_TRACE_5 ?

> 2 means that we should replace usbcore with some other always *builtin* m=
odule.
>

Sounds good. Do you have a module candidate ?

I'm also concerned that we might need to validate dyndbg_selftest.sh
against specific kernel version because
I took the dyndbg_selftest.sh from lukas-v3.0 branch and I had to do
the following changes to make it work on kernel v6.6:

--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -166,12 +166,12 @@ EOF
 function comma_terminator_tests {
     echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
     # try combos of space & comma
-    check_match_ct mm_init 5
+    check_match_ct mm_init 4
     ddcmd module,mm_init,=3D_            # commas as spaces
     ddcmd module,mm_init,+mpf          # turn on non-classed
-    check_match_ct =3Dpmf 5
+    check_match_ct =3Dpmf 4
     ddcmd ,module ,, ,  mm_init, -p    # extra commas & spaces
-    check_match_ct =3Dmf 5
+    check_match_ct =3Dmf 4
     ddcmd =3D_
 }
 function test_percent_splitting {
@@ -350,7 +350,7 @@ function test_private_trace_3 {
     ddcmd class D2_CORE +T:foo \; class D2_KMS +T:foo
     ddcmd "class,D2_CORE,+T:foo;,class,D2_KMS,+T:foo"
     ddcmd class,D2_CORE,+T:foo\;class,D2_KMS,+T:foo
-    check_match_ct =3DT 2 -v
+    check_match_ct =3DT 3 -v
     check_match_ct =3DTl 0
     check_match_ct =3DTmf 0
     echo 1 >/sys/kernel/tracing/tracing_on
@@ -379,7 +379,7 @@ function test_private_trace_4 {
     modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+T:foo%class,D2_KMS=
,+T:foo
     check_match_ct =3DTl 0
     check_match_ct =3DTmf 0
-    check_match_ct =3DT 2
+    check_match_ct =3DT 3
     echo 1 >/sys/kernel/tracing/tracing_on

What kernel version did you use for the testing ?

> I chose module params, on the idea that its builtin, but also invoked lat=
er,
> when modules are modprobed with params, so its callsites can be enabled &
> then invoked via do_prints, to test for writes to the private trace-buf.
>
> I've pushed it to lukas-v3.0 at jimc.github.com/linux
>
> Would you look at err on _6, above,
> and figure out if its insufficiently robust to test preconditions, or
> something else ?

The following change fixes failure in TEST_PRIVATE_TRACE_6:
@@ -455,7 +455,7 @@ function test_private_trace_6 {
     ddcmd open $name
     is_trace_instance_opened $name
     check_trace_instance_dir $name 1
-    ddcmd "module module =3DT:$name.l" -v
+    ddcmd "module usbcore =3DT:$name.l"
     check_match_ct =3DT:A_bit_lengthy_trace....l 164

When dyndbg_selftest.sh completes with success which is announced by the li=
ne
# Done on: Thu Dec 28 23:04:17 CET 2023
then it leaves dynamic debug and trace in a state where next
dyndbg_selftest.sh run should also complete with success.
But when any of the tests fails manual intervention or reboot is
required at the moment.
Do you think we should have a cleanup function and call it whenever
dyndbg_selftest.sh fails in order
to prepare dynamic debug and trace for the next run of dyndbg_selftest.sh ?

> and also:
> rename test_private_trace_N() to better names
> - and/or comments to intent & pattern of use
> more tweaks invited in its commit-msg
>

I will rename the functions and add description of the tests.

> since cycle_test_problem() is not actually a problem, whats a better name=
 ?
> _not_best_practices ?
>

Ack

> I think the final test script enhancement needed is (maybe separately):
> private-buffer-expected-write-verification after do_prints,
> and around modprobe test_dynamic_debug dyndbg=3D$multicmd
> subject to 2 below.
>

Ack

> > TODOs:
> > - update dynamic debug documentation,
> > - finalize discussion related to default trace destination
> > (whether we want it at all, if yes then conclude on the details)
> >
>
> good list. before docs;
>
> wrt default-trace, at least in some details, it seems extra rules to know=
.
> for example, if the default were set on successful open,
> rather than successful rule application (iirc), then it would read a lot
> like "with" or "using" blocks, esp with <<EOX form
>
> with that new form, it might be pretty expressive:
>
> echo <<YMMV > /proc/dynamic_debug/control
>   open sesame # ie with
>     module magic_carpet function forward +Tfml
>     module magic_lamp function rub_vigorously +Tfmt
>   open voicetrace
>     module voice2ai function text2cmdprompt +T
>     module undo function oh_crap +T
> YMMV
>
> I think set-default-on-good-rule-applied is flawed:
> it relies on the most complex expression in the grammar to be correct
> and without spelling errors, where module unknown is
> OK grammatically, but nonsense.

in case of "unknown" module default trace destination will not be
updated because
the code checks for nfound before updating  default destination:
if (nfound)
    update_tr_default_dst(modifiers);

> set-default-on-open is simpler to explain and test separately.
>

Actually I think we discussed set-default-on-open some time ago (in
the beginning).
But to sum up the default trace destination there were 3 directions
proposed/discussed:
- set-default-on-open,
- set-default-on-good-rule-applied,
- preset-default-per-each-callsite with -T:trace_dest_name,

All 3 pass information explicitly but IMHO
preset-default-per-each-callsite is most confusing as user would have
to remember what was preset for a given callsite when later passing a
T flag for the same callsite.

Then if it comes to set-default-on-open vs
set-default-on-good-rule-applied I don't have strong opinion but I
would
lean towards set-default-on-open because in this case it is pretty
straightforward, I mean last successful open sets default trace
destination.

If you also hesitate which one to choose maybe we should start with
very simple approach like that +T always defaults to trace events (:0)
?

> We should probably consider modifying the continue-looping behavior
> of ddebug_exec_queries, depending upon the return-code.
> open, close errors could reasonably warrant different treatment,
> like terminating the mult-cmd loop prematurely on open/close errs.
> Esp if we keep the set-default-on-good-rule-applied
> What do you think ?
>

Let's first conclude on default destination.

> I'm inclined to reword a commit-msg or 2, drop RFC, obsolete comments etc=
.
>
> I can do that in a lukas-v3.1, or as in-thread responses,
> do you have a preference ?

Please go ahead and make changes in the lukas-v3.1 branch. I find it
very convenient. I will just grab your changes from the branch.

> some inline below..
>
> > Changes:
> > V3 -> V2
> > - squash "dyndbg: export _print_hex_dump" with "dyndbg: add support for=
 hex_dump output to trace",
> > - squash "dyndbg: tweak pr_info format s/trace dest/trace_dest/"  with =
"dyndbg: add processing of T(race) flag argument",
> > - squash "dyndbg: change +T:name_terminator to dot" with "dyndbg: add p=
rocessing of T(race) flag argument",
> > - fix setting default trace destination,
> > - decrease use count when callsite is being disabled as a part of modul=
e removal,
> > - fix parsing of T flag argument,
> > - update __get_str_strip_nl macro per Steve's comment,
> > - drop commit "dyndbg: move lock,unlock into ddebug_change, drop goto" =
and add comment explaining why ddebug_parse_flags
> > and ddebug_change have to be run in critical section,
> > - add "depends on TRACING" for "DYNAMIC_DEBUG",
> > - update DYNAMIC_DEBUG_BRANCH macro which is used when CONFIG_JUMP_LABE=
L is not set,
> > - change structure name ddebug_trace_inst to dd_private_tracebuf,
> > - change structure name ddebug_trace to dd_tracebuf_tbl_info,
> > - rename is_ddebug_cmd to is_dd_trace_cmd,
> > - rename validate_tr_name to dd_good_trace_name,
> > - rename handle_tr_opend_cmd to handle_trace_opend_cmd and handle_tr_cl=
ose_cmd to handle_trace_close_cmd,
> > - refactor ddebug_parse_cmd,
> > - add pr_err when trace_array_get_by_name or trace_array_init_printk fa=
ils in trace_array_init_printk,
> > - add static prefix to show_T_args,
> > - rename TRACE_DST_MAX to TRACE_DST_LAST and change its value to 64, re=
serve index 0 for trace events in dd_tracebuf_tbl_info (index 0 will be was=
ted),
> > - add "#: " prefix to "Default trace destination" and "Opened trace ins=
tances" and print all opened trace instances on the same line,
> >
> > V2->V1
> > Major rework after receiving feedback in
> > https://lore.kernel.org/all/20231103131011.1316396-1-lb@semihalf.com/
> >
> > This includes among other things:
> > - addittion of open/close commands,
> > - use names instead of numbers for trace destinations,
> > - change prdbg and devdbg trace events to strip newline
> > on the slow path (read side),
> > - change prdbg and devdbg trace events to stores actual values
> > instead of pointers because if a pointer becomes invalid then
> > the TP_printk call will cause a crash,
> > - add support for default trace destination.
> >
> > V1
> > Major rework after receiving feedback in
> > https://lore.kernel.org/all/20230915154856.1896062-1-lb@semihalf.com/
> >
> > Jim Cromie (14):
> >   dyndbg: add _DPRINTK_FLAGS_ENABLED
> >   dyndbg: add _DPRINTK_FLAGS_TRACE
> >   dyndbg: add write events to tracefs code
> >   dyndbg: add 2 trace-events: prdbg, devdbg
> >   tracefs: add __get_str_strip_nl - RFC
> >   dyndbg: use __get_str_strip_nl in prdbg and devdbg
> >   dyndbg: repack _ddebug structure
> >   dyndbg: disambiguate quoting in a debug msg
> >   dyndbg: fix old BUG_ON in >control parser
> >   dyndbg: treat comma as a token separator
> >   dyndbg: add skip_spaces_and_coma()
>
> probly just squash this with prev, its not separately tested,
> and not worth isolating a test for it.
> s/coma/comma/ otherwise.
>

I will squash it.

> >   dyndbg: split multi-query strings with %
> >   dyndbg: reduce verbose/debug clutter
> >   dyndbg: id the bad word in parse-flags err msg
> >
> > =C5=81ukasz Bartosik (8):
> >   dyndbg: move flags field to a new structure
> >   dyndbg: add trace destination field to _ddebug
> >   dyndbg: add open and close commands for trace
> >   dyndbg: don't close trace instance when in use
> >   dyndbg: add processing of T(race) flag argument
>
> tweak subject   s/T(race)/+T:prv_trcbuf_name./   - might as well use
> legal flag syntax.
>

Ack


>
> >   dyndbg: add support for default trace destination
> >   dyndbg: write debug logs to trace instance
> >   dyndbg: add support for hex_dump output to trace
> >
> >  .../admin-guide/dynamic-debug-howto.rst       |   5 +-
> >  MAINTAINERS                                   |   1 +
> >  include/linux/dynamic_debug.h                 |  57 +-
> >  include/trace/events/dyndbg.h                 |  54 ++
> >  include/trace/stages/stage3_trace_output.h    |  13 +
> >  lib/Kconfig.debug                             |   2 +
> >  lib/dynamic_debug.c                           | 736 ++++++++++++++++--
> >  7 files changed, 775 insertions(+), 93 deletions(-)
> >  create mode 100644 include/trace/events/dyndbg.h
> >
> > --
> > 2.43.0.472.g3155946c3a-goog
> >

