Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E980B104
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574885AbjLIAbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIAbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:31:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5131705
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:31:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf32c0140so3026363e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 16:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702081894; x=1702686694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUl0cCMTeM+tkAI9b5weno5Ko28t23m8VMKXzPCwqt4=;
        b=fszchoQKm8o0ajsjr+vnMS6SPimf0Yj4RUY++2pdtg7YQhwVKgbPh3JIAQp/AFPbp6
         zu7K9v2qNkinIW2SYzXdJHQcZT+iN4Ig8ksiJoQyoRMKyxmU6doi+DJmiQkcICRw6nsp
         HHykj4Jzy5TXics5BZJPasPJPwms/4aiP2uIEMJi5Fu8gby1MtlUYTpvzpn0FDwY/ZLZ
         vPXDTsqtC7NUiy7kpmopeTP6ZTnhBxsYIZBmbFGYWhadRuEbfjBVPxUix95C4Cgrzh9q
         bMfmoynExQ72ThjN1K7AZy9SGwempvzoRJoSvaVR8thR5PgbUhHryMh1CtYN/rjhPEw1
         Xacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081894; x=1702686694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUl0cCMTeM+tkAI9b5weno5Ko28t23m8VMKXzPCwqt4=;
        b=ixxeunwmP3C0B2BtJZ71iXyvRj2ntFzCUT8VIzMgKrWPXhUNiAdR/o0wWS8zcOuXtt
         HDG8lnGYDRdsyEzmRZAlFhRIRLJYKxVyp++NRvh0cW860zWv9LVSGBwXV7d7JvJRa+vj
         dg9g1lZ3Dy2JYJAQjL8i62sHgBbVdSlo8gsAJ5zslQ8h+q0crVnJ+bWMg0a5GRD08uMg
         GZSgvlAy1gWifsKfBEPp9FUVxy3Dmdmnwy0/cBfk3f6+9+j3YE3S/MYVZHFngfsSQRuB
         jlBdsbAFqoImfcS2w+Rk0afruvkf/gsugz5W+CAo3cPVCT5Cw67uqxoW0ihxpWpkmGH/
         KSrQ==
X-Gm-Message-State: AOJu0YzQJ+yMcXCohqRZp2G+GOKvm+K9t6+RkxNWnNFvsLqEBp350Wy5
        qV1BNWbObxu1OKOn76UvZphRvIV/PFf6SxOwqATj
X-Google-Smtp-Source: AGHT+IFh0r27JdIx4NGxOxI27SEgQGknrj8Tz18hQpOW2NG8Zlw5ucg8Ld+wJkAwckK/wtCo8LmCiroPS8pJTtmPhn4=
X-Received: by 2002:a05:6512:60a:b0:50c:bbb:e3ce with SMTP id
 b10-20020a056512060a00b0050c0bbbe3cemr311141lfe.112.1702081893126; Fri, 08
 Dec 2023 16:31:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com>
In-Reply-To: <cover.1701993656.git.jim.cromie@gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sat, 9 Dec 2023 01:31:21 +0100
Message-ID: <CAK8Bye+VQshH-AUKmmwVPZ+peo1Ca5961UuC8UB2ATAa4oHLEA@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 00/11] dyndbg: add support for writing
 debug logs to trace
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        bleung@google.com, contact@emersion.fr, daniel@ffwll.ch,
        dianders@chromium.org, groeck@google.com, jbaron@akamai.com,
        john.ogness@linutronix.de, keescook@chromium.org, pmladek@suse.com,
        ppaalanen@gmail.com, rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 gru 2023 o 01:15 Jim Cromie <jim.cromie@gmail.com> napisa=C5=82(a):
>
> hi Lukas,
>
> Sorry for the delay, I probably should have split this up.
> (also cc'g gregkh)
>
> Ive been banging on your v2 patchset:
> https://lore.kernel.org/lkml/20231130234048.157509-1-lb@semihalf.com/
>

Jim, thank you for your thorough testing and review.

> Things are looking pretty good, a few issues follow. And some patches.
>

;)

> trivial:
>
>   dyndbg: export _print_hex_dump  # squash wo comment
>   dyndbg: tweak pr_info format s/trace dest/trace_dest/  # greppability s=
quash
>   dyndbg: disambiguate quoting in a debug msg
>   dyndbg: fix old BUG_ON in >control parser
>
> Then:
>
>   dyndbg: change +T:name_terminator to dot
>   dyndbg: treat comma as a token separator
>
> 1st allows 2nd, 2nd allows simpler arg-passing, boot-args, etc:
>
>   echo module,test_dynamic_debug,class,L2,+p > /proc/dynamic_debug/contro=
l
>   modprobe test_dynamic_debug dyndbg=3Dclass,L2,+mfl
>
> Given theres no legacy wrt comma, swapping it now with dot seems
> better semantically than "dot as token/list separator".
>
> Aside: /proc/dynamic_debug/control is always there (if configd), even
> when <debugfs> isn't mounted.  Its more universal, and copy-pastable.
>
>   dyndbg: __skip_spaces - and comma
>   dyndbg: split multi-query strings with %
>
> % allows escape-free multi-cmd dyndbg args:
>
>   modprobe test_dynamic_debug \
>     dyndbg=3Dopen,selftest%class,D2_CORE,+T:selftest.mf
>
>   dyndbg: reduce verbose/debug clutter
>   dyndbg: move lock,unlock into ddebug_change, drop goto - revisit
>
> Ive just pushed it, I will bump my version here.
> To github.com:jimc/linux.git
>  + 20d113eb6f9a...66fa2e4cb989 lukas-v2.1 -> lukas-v2.1 (forced update)
>
> SELFTEST
>
> Ive taken the liberty to write an ad-hoc test script (inline below),
> to exersize the parser with legacy command input, and with the new
> stuff mentioned above: comma-separated-tokens, %-separated-multi-cmds,
> while counting changes to builtin,etc modules, to validate against
> expectations.
>
> The change-count tests achieve some closed-loop testing, but checking
> syslog for messages written always seemed too hard/unreliable.  Your
> private trace-instances work promises a solution, by giving an
> observable closed system to build upon.
>
> I made some attempts to write messages to the trace-buf, but ran out
> of clues*tuits.  And I encountered a couple more definite problems:
>

Let me dig through test scripts you created and issues you run into.


> 1- modprobe/rmmod lifecycle probs
>
> Ive coded some blue-sky and not-so-proper "modprobe,+T:it,-T:it,rmmod"
> life-cycle scenarios, which can wedge a previously created instance.
> Once wedged, I cannot recover.  See the test_private_trace{,_2,_3}
> functions, and the error_log_ref() following each.
>
> This brittleness begs a question; should we have auto-open (mapping
> new names to available 1-63 trc-ids) ?  And non-close ? If it just did
> the right thing, particularly on rmmod, it would prevent "misuse".
>
> I don't think auto-open obsoletes the open (& esp) close commands, but
> Id like to see scripted test scenarios using close in combo with the
> right /sys/kernel/tracing/* manipulations, to prove its not all just a
> fever dream.
>
> Your expertise in opening, writing to, manipulating & destroying
> private (and the global) tracebufs, distilled into new shell funcs,
> would be enormously helpful towards demonstrating the private-buffer
> use case and its value.
>
> 2- some new flags parse error:
>
> [ 1273.074535] dyndbg:  32 debug prints in module test_dynamic_debug
> [ 1273.075365] dyndbg: module: test_dynamic_debug dyndbg=3D"class,D2_CORE=
,+T:foo%class,D2_KMS,+T:foo"
> [ 1273.076307] dyndbg: query 0: <class,D2_CORE,+T:foo> on module: <test_d=
ynamic_debug>
> [ 1273.077068] dyndbg: split into words: "class" "D2_CORE" "+T:foo"
> [ 1273.077673] dyndbg: unknown flag 'c'
> [ 1273.078033] dyndbg: flags parse failed on 2: +T:foo
> [ 1273.078519] dyndbg: query 1: <class,D2_KMS,+T:foo> on module: <test_dy=
namic_debug>
> [ 1273.079266] dyndbg: split into words: "class" "D2_KMS" "+T:foo"
> [ 1273.079872] dyndbg: unknown flag '=EF=BF=BD'
> [ 1273.080228] dyndbg: flags parse failed on 2: +T:foo
> [ 1273.080716] dyndbg: processed 2 queries, with 0 matches, 2 errs
> : 0 matches on =3DTl
>
> I have a suspicion this relates to moving the parse_flags call in
> ddebug_query, but I havent dug in.
>
>
> I also have some reservations about the default dest; 1st that it is a
> global state var, as noted at bottom of control:
>
>   [root@v6 lx]# ddgrep \\btrace\\b      # a better/narrower search-term ?
>   ...
>   Default trace destination: foo        # add a '#:' prefix to these line=
s ?
>   Opened trace instances:               # all values should be on this li=
ne
>
> Then theres the "preset" value, ie each site's dest_id (sorry I forgot
> your fieldname).  I presume the default would override such a "preset"
> (otherwise it would have no effect).
>
> Is the default set on last open ? or on next use of +T:<foo> ?
>
> In the no-default world, a user/tester would decide how many
> trace-instances are needed, and map sets of callsites to them.
>
>   # configure drm-debug streams for this test scenario
>   cat<<EOF >/proc/dynamic_debug/control
>    open drm_core
>    open drm_mix
>    open driver_1        # we can separate by modname but not drvr-number
>    open driver_2
>    class DRM_UT_CORE -T:drm_core        # set dest_id, disabled state
>    class DRM_UT_CORE +mf                # traces dont do prefixing (shoul=
d it?)
>    # mix KMS & ATOMIC into 1 stream
>    class DRM_UT_KMS -T:drm_mix
>    class DRM_UT_ATOMIC -T:drm_mix
>   EOF
>
> Then perhaps to turn on/off when needed: (legacy analogue version)
>
>   echo 0x15 > /sys/module/drm/parameters/debug_trace
>
> With those trace-dest presets honored, the configured drm_core &
> drm_mix streams persist.  If a later enablement applies the
> then-current default trace-dest, it would spoil this scheme.
>
> Could you elaborate a scenario or 2 where the default behavior does
> something specific, and that its the right thing ?  I dont understand
> it yet.
>
> OTOH
>
> One limitation of the above: the drm.debug_trace (posited above) would
> turn on all Ts in all those class'd callsites across the whole
> subsystem, irrespective of their preconfigured destination.  That was
> always inherent in drm.debug, but its less than perfect.
>
> It sort-of defeats the point of doing +T only on the useful callsites.
>
> And global event buf is also enabled, it might be flood-prone.
>
>   echo 1 > /sys/kernel/tracing/events/dyndbg/enable
>
> It would help if we could filter on trace-instance names:
> (this sounds familiar :-)
>
>   ddcmd module '*' trace_dest drm_mix +T
>
>
> In reality, the dest-id is not even dependent on tracing per-se, it is
> a user classification system (in contrast to class <subsys-names>).
> It just happens to be tied by +T:name syntax to tracefs.
>
> No promise about +p:_alt_log_.mflt having meaning, or working.
>
>
>
> anyway, Ive gone on long enough.  heres that/those scripts
>
> cat dd-tools.rc
> #!/bin/bash
>
> function ddcmd () {
>     echo $* > /proc/dynamic_debug/control
> }
> function ddcat () {
>     cat $1 > /proc/dynamic_debug/control
> }
> function vx () {
>     echo $1 > /sys/module/dynamic_debug/parameters/verbose
> }
> function ddgrep () {
>     grep $1 /proc/dynamic_debug/control
> }
> function doprints () {
>     cat   /sys/module/test_dynamic_debug/parameters/do_prints
> }
>
> cat dd-selftest.rc
> #!/bin/bash
> # dd-selftest.rc: shell-fns & test-script for dynamic-debug
> # mostly run as:
> # vng --force-9p -v -e ./dd-selftest.rc
>
> . dd-tools.rc
> # vx 3
>
> function check_matches {
>     let ct=3D$(ddgrep $1 | wc -l )
>     echo  ": $ct matches on $1 "
>     [ "$2" =3D=3D "-v" ] && ddgrep $1
> }
> function check_instance {
>     # 1. trace instance name 2. -v for verbose
>     if [ -e /sys/kernel/tracing/instances/$1 ]; then
>         if [ "$2" =3D=3D "-v" ] ; then
>             echo "ls -l /sys/kernel/tracing/instances/$1: "
>             ls -l /sys/kernel/tracing/instances/$1
>         fi
>     else
>         echo "no instance: $1"
>     fi
> }
> function tmark {
>     echo $* > /sys/kernel/tracing/trace_marker
> }
> function read_trace_instance {
>     # get traces opened, default
>     tail -n9 /proc/dynamic_debug/control | grep -P \\w+ | grep -vP ^drive=
rs/
> }
> function error_log_ref {
>     # to show what I got
>     : echo "# error-log-ref: $1"
>     : echo cat \$2
> }
> function ifrmmod {
>     lsmod | grep $1 || echo $1 not there
>     lsmod | grep $1 && rmmod $1
> }
>
> echo LOADING TEST FUNCS
> echo SHLVL: $SHLVL
>
> function basic_tests {
>     echo \# BASIC_TESTS
>
>     ddcmd =3D_ "# zero everything (except class'd sites)"
>     check_matches =3Dp 0
>
>     # there are several main's :-/
>     ddcmd module main file */module/main.c +p
>     check_matches =3Dp 14
>     ddcmd =3D_
>     check_matches =3Dp 0
>
>     ddcmd module mptcp =3D_
>     ddcmd module mptcp +pmf
>     check_matches =3Dpmf 120
>     ddcmd =3D_
>
>     # multi-cmd newline separated with embedded comments
>     cat <<"EOF" > /proc/dynamic_debug/control
>       module main +mf                   # multi-query
>       module main file init/main.c +ml  # newline separated
>       module kvm +fl                    # comment prefixed
>       module kvm_intel  +flt            #
> EOF
>     # the intersection of all those main's is hard to track/count
>     # esp when mixed with overlapping greps
>     check_matches =3Dmf 27
>     check_matches =3Dml 0
>     check_matches =3Dmfl 6
>     check_matches =3Dfl 29
>     check_matches =3Dflt 16
>     ddcmd =3D_
> }
> basic_tests; # run
>
> function comma_terminator_tests {
>     echo \# COMMA_TERMINATOR_TESTS
>
>     # try combos of space & comma
>     ddcmd module,mptcp,=3D_
>     ddcmd module,mptcp,+mf
>     ddcmd " module, mptcp, +mfl"
>     check_matches =3Dpmf 120
>     ddcmd module , mptcp,-p
>     check_matches =3Dmf 120
>     check_matches =3Dp 0
>     ddcmd ,module ,,  mptcp, -p
>     ddcmd ",module ,,  mptcp, -p"
>     ddcmd =3D_
> }
> comma_terminator_tests; # run
>
> function private_trace_test {
>     echo \# PRIVATE_TRACE_TEST - proper lifo cycle - open, enable:named d=
isable:named close
>
>     ddcmd open usb_stream
>     check_instance usb_stream
>     ddcmd module usbcore +T:usb_stream.mf
>     check_matches =3DT:usb_stream.mf 161
>     ddcmd module usbcore -T:usb_stream.mf
>     check_matches =3DT:usb_stream.mf 0
>     read_trace_instance
>     ddcmd close usb_stream
>     read_trace_instance
>     ddcmd =3D_
> }
> private_trace_test; # run
>
> function test_percent_splitting {
>     echo \# TEST_PERCENT_SPLITTING - multi-command splitting on %
>     ddcmd =3D_
>     modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+pf%class,D2_KMS,+=
pt%class,D2_ATOMIC,+pm
>     check_matches =3Dpf -v
>     check_matches =3Dpt -v
>     check_matches =3Dpm -v
>     ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add s=
ome prefixes"
>     check_matches =3Dpmf -v
>     check_matches =3Dplt -v
>     check_matches =3Dpml -v
>     doprints
>     ifrmmod test_dynamic_debug
> }
> test_percent_splitting; # run
>
> function test_actual_trace {
>     echo \# test_actual_trace
>     ddcmd =3D_
>     ifrmmod test_dynamic_debug
>     echo 1 >/sys/kernel/tracing/tracing_on
>     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
>
>     modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+T
>     check_matches =3DT -v
>     tmark here comes the WARN
>     doprints
>     cat /sys/kernel/tracing/trace
> }
> test_actual_trace; # run, hits 1313:  WARN_ON_ONCE(!arr)
>
> error_log_ref test_actual_trace <<"EO_LOG"
> [    6.587595] dyndbg: read 3 bytes from userspace
> [    6.588174] dyndbg: query 0: <=3D_> on module: <*>
> [    6.588842] dyndbg: processed 1 queries, with 3236 matches, 0 errs
> [    6.726160] dyndbg: class[0]: module:test_dynamic_debug base:22 len:8 =
ty:3
> [    6.727052] dyndbg: class[1]: module:test_dynamic_debug base:14 len:8 =
ty:1
> [    6.728158] dyndbg: class[2]: module:test_dynamic_debug base:10 len:3 =
ty:2
> [    6.729112] dyndbg: class[3]: module:test_dynamic_debug base:0 len:10 =
ty:0
> [    6.729969] dyndbg: module:test_dynamic_debug attached 4 classes
> [    6.730729] dyndbg:  32 debug prints in module test_dynamic_debug
> [    6.731494] dyndbg: module: test_dynamic_debug dyndbg=3D"class,D2_CORE=
,+T"
> [    6.732350] dyndbg: query 0: <class,D2_CORE,+T> on module: <test_dynam=
ic_debug>
> [    6.733291] dyndbg: processed 1 queries, with 1 matches, 0 errs
> [    6.734224] ------------[ cut here ]------------
> [    6.734811] WARNING: CPU: 1 PID: 472 at lib/dynamic_debug.c:1309 ddebu=
g_printk+0xde/0xf0
> [    6.735814] Modules linked in: test_dynamic_debug(E+) intel_rapl_msr(E=
) crc32_pclmul(E) intel_rapl_common(E) ghash_clmulni_intel(E) crct10dif_pcl=
mul(E) crc32c_intel(E) joydev(E) serio_raw(E) pcspkr(E) i2c_piix4(E) [last =
unloaded: test_dynamic_debug(E)]
> [    6.738594] CPU: 1 PID: 472 Comm: modprobe Tainted: G        W   E    =
  6.6.0-tf2-virtme-00026-g20d113eb6f9a-dirty #220
> [    6.740008] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    6.741669] RIP: 0010:ddebug_printk+0xde/0xf0
> [    6.742220] Code: 48 8d 44 24 28 48 89 44 24 20 e8 ed 71 9c ff 48 83 c=
4 58 5b 41 5c 5d c3 48 8d 56 02 48 8d 4c 24 10 31 f6 e8 84 f9 ff ff eb b5 <=
0f> 0b eb a0 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 57 48 89
> [    6.745072] RSP: 0018:ffffb38140453bd0 EFLAGS: 00010246
> [    6.745914] RAX: 0000000000000000 RBX: ffffffffc03b97e0 RCX: ffffb3814=
0453c50
> [    6.747002] RDX: ffffb38140453be0 RSI: ffffffffb26f8150 RDI: 000000000=
0000000
> [    6.747883] RBP: ffffb38140453c38 R08: 0000000000000020 R09: ffffffffb=
3370ce4
> [    6.748753] R10: 0000000000000001 R11: 0000000000010000 R12: ffffffffb=
26f8150
> [    6.749586] R13: ffff9b68029bc440 R14: ffff9b6805640800 R15: ffff9b680=
5c9d640
> [    6.750497] FS:  00007f7cdc453740(0000) GS:ffff9b683ec80000(0000) knlG=
S:0000000000000000
> [    6.751537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.752310] CR2: 000055ce7a609ae0 CR3: 000000000575a000 CR4: 000000000=
0750ee0
> [    6.753238] PKRU: 55555554
> [    6.753604] Call Trace:
> [    6.753910]  <TASK>
> [    6.754240]  ? ddebug_printk+0xde/0xf0
> [    6.754772]  ? __warn+0x7d/0x130
> [    6.755197]  ? ddebug_printk+0xde/0xf0
> [    6.755669]  ? report_bug+0x189/0x1c0
> [    6.756176]  ? handle_bug+0x38/0x70
> [    6.756642]  ? exc_invalid_op+0x13/0x60
> [    6.757112]  ? asm_exc_invalid_op+0x16/0x20
> [    6.757635]  ? ddebug_printk+0xde/0xf0
> [    6.758123]  ? 0xffffffffc03c0000
> [    6.758533]  __dynamic_pr_debug+0x133/0x170
> [    6.759066]  ? 0xffffffffc03c0000
> [    6.759438]  do_cats+0x127/0x180 [test_dynamic_debug]
> [    6.760063]  test_dynamic_debug_init+0x7/0x1000 [test_dynamic_debug]
> [    6.760890]  do_one_initcall+0x43/0x2f0
> [    6.761399]  ? kmalloc_trace+0x26/0x90
> [    6.761904]  do_init_module+0x9d/0x290
> [    6.762377]  init_module_from_file+0x77/0xd0
> [    6.762877]  idempotent_init_module+0xf9/0x270
> [    6.763439]  __x64_sys_finit_module+0x5a/0xb0
> [    6.764040]  do_syscall_64+0x35/0x80
> [    6.764474]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [    6.765089] RIP: 0033:0x7f7cdc56b5ad
> [    6.765522] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 53 48 0c 00 f7 d8 64 89 01 48
> [    6.767763] RSP: 002b:00007fff198e28d8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [    6.768781] RAX: ffffffffffffffda RBX: 000055ce7bb53980 RCX: 00007f7cd=
c56b5ad
> [    6.769611] RDX: 0000000000000000 RSI: 000055ce7bb72930 RDI: 000000000=
0000006
> [    6.770598] RBP: 00007fff198e2990 R08: 0000000000000000 R09: 000000000=
0000002
> [    6.771447] R10: 0000000000000006 R11: 0000000000000246 R12: 000055ce7=
bb72930
> [    6.772328] R13: 0000000000040000 R14: 000055ce7bb53bc0 R15: 000055ce7=
bb72930
> [    6.773252]  </TASK>
> [    6.773532] ---[ end trace 0000000000000000 ]---
> : 2 matches on =3DT
> drivers/cpufreq/intel_pstate.c:1912 [intel_pstate]core_get_max_pstate =3D=
_ "max_pstate=3DTAC %x\n"
> lib/test_dynamic_debug.c:109 [test_dynamic_debug]do_cats =3DT:(null) "D2_=
CORE msg\n" class:D2_CORE
> did do_prints
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:4
> EO_LOG
>
> # that 2nd =3DT match has :(null) in the control-line. I didnt chase it.
>
> function test_early_close () {
>     ddcmd open usb_stream
>     ddcmd module usbcore +T:usb_stream.mf
>     check_matches =3DT:usb_stream.mf 161
>     echo ":not-running # ddcmd module usbcore -T:usb_stream.mf"
>     ddcmd close usb_stream
> }
> # test_early_close - works, unused, refactored below.
> function self_start {
>     echo \# open, modprobe +T:it
>     ddcmd open selftest
>     check_instance selftest
>     modprobe test_dynamic_debug dyndbg=3D+T:selftest.mf
>     check_matches =3DT:selftest.mf -v
> }
> function self_end_normal {
>     echo \# disable -T:it, rmmod, close
>     ddcmd module test_dynamic_debug -T:selftest # leave mf
>     check_matches =3Dmf -v
>     ifrmmod test_dynamic_debug
>     ddcmd close selftest
> }
> function self_end_disable_anon {
>     echo \# disable, close, rmmod
>     ddcmd module test_dynamic_debug -T
>     check_matches =3Dmf -v
>     ddcmd close selftest
>     ifrmmod test_dynamic_debug
> }
> function self_end_disable_anon_mf {
>     echo \# disable, close, rmmod
>     ddcmd module test_dynamic_debug -Tf
>     check_matches =3Dm -v
>     ddcmd close selftest
>     ifrmmod test_dynamic_debug
> }
> function self_end_nodisable {
>     echo \# SKIPPING: ddcmd module test_dynamic_debug -T:selftest
>     rmmod test_dynamic_debug
>     echo FAIL_COMING on close
>     ddcmd close selftest
> }
> function self_test_ {
>     echo "# SELFTEST $1"
>     self_start
>     self_end_$1
> }
>
> function cycle_tests_normal {
>     echo \# CYCLE_TESTS_NORMAL
>
>     self_test_ normal           # ok
>     self_test_ disable_anon     # ok
>     ddgrep selftest
>
>     self_test_ normal           # ok
>     self_test_ disable_anon_mf  #
>     ddgrep selftest
> }
> cycle_tests_normal; # run
>
> function cycle_tests_problem {
>     self_test_ nodisable        # write error: Device or resource busy
>     ddgrep selftest             # still used, defaulted - prob
>
>     self_test_ normal   # open error, write error persists
>     ddgrep selftest     # still used, defaulted
>
>     ddcmd close selftest # too late ??
> }
> # cycle_tests_problem;
>
>
> function test_private_trace {
>     echo "# TEST_PRIVATE_TRACE"
>     ddcmd =3D_
>
>     ifrmmod test_dynamic_debug
>     echo 1 >/sys/kernel/tracing/tracing_on
>     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
>
>     ddcmd open foo
>     modprobe test_dynamic_debug
>     ddcmd class,D2_CORE,+T:foo,%class,D2_KMS,+T:foo
>
>     check_matches =3DTl -v
>     check_matches =3DTmf -v
>     echo 1 >/sys/kernel/tracing/tracing_on
>     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
>     tmark test_private_trace about to do_prints
>     doprints
>     cat /sys/kernel/tracing/trace
>
>     ddcmd class,D2_CORE,-T:foo
>     ddcmd close foo
>     ddcmd close bar
>     ifrmmod test_dynamic_debug
> }
> test_private_trace; # run
>
> error_log_ref test_private_trace <<EOF
> # test_private_trace
> [    7.803744] dyndbg: read 3 bytes from userspace
> [    7.804329] dyndbg: query 0: <=3D_> on module: <*>
> [    7.804844] dyndbg: processed 1 queries, with 3236 matches, 0 errs
> rmmod: ERROR: Module test_dynamic_debug is not currently loaded
> [    7.838191] dyndbg: read 9 bytes from userspace
> [    7.838858] dyndbg: query 0: <open foo> on module: <*>
> [    7.872066] dyndbg: processed 1 queries, with 0 matches, 0 errs
> [    7.991723] dyndbg: class[0]: module:test_dynamic_debug base:22 len:8 =
ty:3
> [    7.992488] dyndbg: class[1]: module:test_dynamic_debug base:14 len:8 =
ty:1
> [    7.993178] dyndbg: class[2]: module:test_dynamic_debug base:10 len:3 =
ty:2
> [    7.993873] dyndbg: class[3]: module:test_dynamic_debug base:0 len:10 =
ty:0
> [    7.994560] dyndbg: module:test_dynamic_debug attached 4 classes
> [    7.995174] dyndbg:  32 debug prints in module test_dynamic_debug
> [    7.998426] dyndbg: read 42 bytes from userspace
> [    7.999169] dyndbg: query 0: <class,D2_CORE,+T:foo,> on module: <*>
> [    8.000126] dyndbg: query 1: <class,D2_KMS,+T:foo> on module: <*>
> [    8.000956] dyndbg: processed 2 queries, with 2 matches, 0 errs
> : 0 matches on =3DTl
> : 0 matches on =3DTmf
> did do_prints
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 2/2   #P:4
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>   dd-selftest.rc-375     [003] .....     6.876234: tracing_mark_write: he=
re comes the WARN
>   dd-selftest.rc-375     [003] .....     8.168406: tracing_mark_write: sh=
ould be ready
> [    8.093538] dyndbg: read 21 bytes from userspace
> [    8.094156] dyndbg: query 0: <class,D2_CORE,-T:foo> on module: <*>
> [    8.094924] dyndbg: processed 1 queries, with 1 matches, 0 errs
> [    8.095560] dyndbg: read 10 bytes from userspace
> [    8.096038] dyndbg: query 0: <close foo> on module: <*>
> [    8.096565] dyndbg: trace instance is being used name=3Dfoo, use_cnt=
=3D1
> [    8.097198] dyndbg: processed 1 queries, with 0 matches, 1 errs
> dd-tools.rc: line 4: echo: write error: Device or resource busy
> [    8.097850] dyndbg: read 10 bytes from userspace
> [    8.098356] dyndbg: query 0: <close bar> on module: <*>
> [    8.098887] dyndbg: processed 1 queries, with 0 matches, 1 errs
> dd-tools.rc: line 4: echo: write error: No such file or directory
> EOF
>
> function test_private_trace_2 {
>     echo "# TEST_PRIVATE_TRACE_2"
>
>     ddcmd =3D_
>     rmmod test_dynamic_debug
>     echo 1 >/sys/kernel/tracing/tracing_on
>     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
>
>     ddcmd open foo \; open bar  # 2nd fails
>     modprobe test_dynamic_debug
>     ddcmd class,D2_CORE,+T:foo
>     ddcmd class,D2_KMS,+T:foo
>     ddcmd class D2_CORE +T:foo \; class D2_KMS +T:foo
>
>     echo \# this breaks ??
>     ddcmd "class,D2_CORE,+T:foo;,class,D2_KMS,+T:foo"
>     # ddcmd class,D2_CORE,+T:foo\;class,D2_KMS,+T:foo
>
>     check_matches =3DTl -v
>     check_matches =3DTmf -v
>     echo 1 >/sys/kernel/tracing/tracing_on
>     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
>     tmark test_private_trace_2 about to do_prints
>     doprints
>     cat /sys/kernel/tracing/trace
>     #rmmod test_dynamic_debug
> }
> test_private_trace_2;  # run
>
> # a real parse error in this log, with same input as worked above.
> # the unkown flag 'c' error conflicts with what the following error
> # says is the flags token
>
> error_log_ref test_private_trace_2 <<EOF
> [    8.107982] d# test_private_trace_2
> yndbg: read 3 bytes from userspace
> [    8.108490] dyndbg: query 0: <=3D_> on module: <*>
> [    8.108997] dyndbg: processed 1 queries, with 3241 matches, 0 errs
> [    8.139645] dyndbg: removed module "test_dynamic_debug"
> [    8.152344] dyndbg: read 20 bytes from userspace
> [    8.152952] dyndbg: query 0: <open foo > on module: <*>
> [    8.153610] dyndbg: instance is already opened name:foo
> [    8.153610]
> [    8.153612] dyndbg: query 1: <open bar> on module: <*>
> [    8.185399] dyndbg: processed 2 queries, with 0 matches, 1 errs
> dd-tools.rc: line 4: echo: write error: File exists
> [    8.300750] dyndbg: class[0]: module:test_dynamic_debug base:22 len:8 =
ty:3
> [    8.301509] dyndbg: class[1]: module:test_dynamic_debug base:14 len:8 =
ty:1
> [    8.302189] dyndbg: class[2]: module:test_dynamic_debug base:10 len:3 =
ty:2
> [    8.302876] dyndbg: class[3]: module:test_dynamic_debug base:0 len:10 =
ty:0
> [    8.303550] dyndbg: module:test_dynamic_debug attached 4 classes
> [    8.304147] dyndbg:  32 debug prints in module test_dynamic_debug
> [    8.307165] dyndbg: read 21 bytes from userspace
> [    8.307754] dyndbg: query 0: <class,D2_CORE,+T:foo> on module: <*>
> [    8.308914] dyndbg: processed 1 queries, with 1 matches, 0 errs
> [    8.310076] dyndbg: read 20 bytes from userspace
> [    8.310916] dyndbg: query 0: <class,D2_KMS,+T:foo> on module: <*>
> [    8.311915] dyndbg: processed 1 queries, with 1 matches, 0 errs
> [    8.312764] dyndbg: read 43 bytes from userspace
> [    8.313597] dyndbg: query 0: <class D2_CORE +T:foo > on module: <*>
> [    8.314697] dyndbg: query 1: <class D2_KMS +T:foo> on module: <*>
> [    8.315687] dyndbg: processed 2 queries, with 2 matches, 0 errs
> # this breaks ??
> [    8.320048] dyndbg: read 41 bytes from userspace
> [    8.320904] dyndbg: query 0: <class,D2_CORE,+T:foo> on module: <*>
> [    8.321925] dyndbg: unknown flag 'c'
> [    8.322525] dyndbg: flags parse failed on 2: +T:foo
> [    8.323348] dyndbg: query 1: <class,D2_KMS,+T:foo> on module: <*>
> [    8.324428] dyndbg: processed 2 queries, with 1 matches, 1 errs
> dd-tools.rc: line 4: echo: write error: Invalid argument
> [    8.325536] dyndbg: read 41 bytes from userspace
> [    8.326305] dyndbg: query 0: <class,D2_CORE,+T:foo> on module: <*>
> [    8.327415] dyndbg: unknown flag 'c'
> [    8.328138] dyndbg: flags parse failed on 2: +T:foo
> [    8.328993] dyndbg: query 1: <class,D2_KMS,+T:foo> on module: <*>
> [    8.330035] dyndbg: processed 2 queries, with 1 matches, 1 errs
> dd-tools.rc: line 4: echo: write error: Invalid argument
> : 0 matches on =3DTl
> : 0 matches on =3DTmf
> did do_prints
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3/3   #P:4
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>   dd-selftest.rc-375     [001] .....     6.934983: tracing_mark_write: he=
re comes the WARN
>   dd-selftest.rc-375     [003] .....     8.208645: tracing_mark_write: te=
st_private_trace about to do_prints
>   dd-selftest.rc-375     [003] .....     8.539307: tracing_mark_write: te=
st_private_trace_2 about to do_prints
> EOF
>
> function test_private_trace_3 {
>     echo "# TEST_PRIVATE_TRACE_3"
>
>     ddcmd =3D_
>     rmmod test_dynamic_debug
>     echo 1 >/sys/kernel/tracing/tracing_on
>     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
>
>     ddcmd open foo # gets already open err
>     modprobe test_dynamic_debug dyndbg=3Dclass,D2_CORE,+T:foo%class,D2_KM=
S,+T:foo
>     # triggers:
>     # dyndbg: query 0: <class,D2_CORE,+T:foo> on module: <*>
>     # dyndbg: unknown flag 'c'
>     # dyndbg: flags parse failed
>
>     check_matches =3DTl -v
>     check_matches =3DTmf -v
>     echo 1 >/sys/kernel/tracing/tracing_on
>     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
>     tmark should be ready
>     doprints
>     cat /sys/kernel/tracing/trace
>     #rmmod test_dynamic_debug
> }
> test_private_trace_3;
>
> echo -n "# done on: "
> date
>
>
> Jim Cromie (11):
>   dyndbg: export _print_hex_dump
>   dyndbg: tweak pr_info format s/trace dest/trace_dest/
>   dyndbg: disambiguate quoting in a debug msg
>   dyndbg: fix old BUG_ON in >control parser
>   dyndbg: change +T:name_terminator to dot
>   dyndbg: treat comma as a token separator
>   dyndbg: __skip_spaces
>   dyndbg: split multi-query strings with %
>   dyndbg: reduce verbose/debug clutter
>   dyndbg: move lock,unlock into ddebug_change, drop goto
>   dyndbg: id the bad word in parse-flags err msg
>
>  lib/dynamic_debug.c | 52 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
>
> --
> 2.43.0
>
