Return-Path: <linux-kernel+bounces-11818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E3781EC05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A942835E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74903523E;
	Wed, 27 Dec 2023 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ/B4f7/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACED5220
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-427ca22a680so23147351cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703651002; x=1704255802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju/BmQ6E5IQM24FAxbXEWx9tDsi+rPaCIw5qai1u11w=;
        b=fZ/B4f7/UMeXskaz4dnbcAvE7VRGSbV6yPEBQ6lealCcRgBkaxmaP6u3O4rbWLmYjN
         dYh8x1oKIbQ4BYuTtUPUuGP12AubNAK64Z150Eoc/JgDcKuvSqGe+69FKi7s0H2rP5bC
         agNPknSEMfkeTM/bxR2no77/1Evh7MqyI0ogyDtJXtTeMV0LGkUfOHcJY0ibI80rjk21
         7APFOSyDzdcwlE+Oxeg13q+CZYWcpei+2Bvq/6qk2x6ipOh3YXdizguvbFOdeeLRE/mz
         OBAb1df3dzH3uOkdNe1a85K9LuGzB4p2283wjz3i/DGTp02EM1PbehAiQbGcUPhhHHfa
         wbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703651002; x=1704255802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju/BmQ6E5IQM24FAxbXEWx9tDsi+rPaCIw5qai1u11w=;
        b=DN/I5eDS4pkdD8AiGvQ1m7g9GbH9cod9O3F9JnoqiH8nsFz34uWeANezSZ4WANvnR/
         hmx9E+MzvnLLPbJgWGRi7/aFwJ6AIjSiE5ZXXlY+Hey7zSFfMnIChTQ+cZV6tlKPg49K
         NDevHi4gYHuVWS1gAIA4UxeXOK6MVwyLWZAaV+B6JmDF/I5JE3HljlPTZi3wxCIcmfLM
         0FtYbU8rPecU9xQHuKqIjJks9leqjqgE071RBFHBPELXq9Z1Hx/HYsTJmN1Lk4u7qbhi
         zkJ0K6zM2gCXyLQUuaGvg8fa8qbVLH5mOlN7lOMNFjYTx37hzygtXqQVDZtdX/hpNIwm
         egCA==
X-Gm-Message-State: AOJu0YzBhvpChO4E2+/07h+1k66q6yf7IIoL7nDZBteHZKL2NcLBppHb
	9SVo21jCZCdJsGLV6tLsohlh/9/CGB0aICZqYB4=
X-Google-Smtp-Source: AGHT+IEIbwt/kipCxaNKQI+y179ENfsE9l+qZA12Evg64wl/ljlmMNRzmsIBOmYPZGslBEL48nl0HVSxoVlmGsEs/PQ=
X-Received: by 2002:a05:620a:112e:b0:781:1d7d:441f with SMTP id
 p14-20020a05620a112e00b007811d7d441fmr10907022qkk.49.1703651001594; Tue, 26
 Dec 2023 20:23:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223015131.2836090-1-lb@semihalf.com>
In-Reply-To: <20231223015131.2836090-1-lb@semihalf.com>
From: jim.cromie@gmail.com
Date: Tue, 26 Dec 2023 21:22:55 -0700
Message-ID: <CAJfuBxyN+t6OgzzX3ZT6MxdMT6Awr29orJAucVMDz2zmEFCDDQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] dyndbg: add support for writing debug logs to trace
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
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

re-adding gregkh, who fell off the cc's again.
he is one of our upstreams.

On Fri, Dec 22, 2023 at 6:51=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> Add support for writing debug logs to trace events and trace instances.
> The rationale behing this feature is to be able to redirect debug logs
> (per each callsite individually) to trace to aid in debugging. The debug
> logs output to trace can be enabled with T flag. Additionally the T flag
> accepts trace destination which can be provided to the T flag after ":".
> The trace destination field is used to determine where debug logs will be
> written.
>
> In order to redirect callsite debug log to a trace instance it has to be
> initialized first with a newly introduced "open" command. For example,
> "usb" trace instance in <debugfs>/tracing/instances/ can be initialized
> by issuing the command:
>
> localhost ~ # echo "open usb" >
>                                 <debugfs>/dynamic_debug/control
>
> If the trace instance <debugfs>/tracing/instances/usb already exists
> then it will be reused otherwise new usbcore instance will be created.
> Maximum 63 trace instances can be "opened". The trace instance name can
> include any of ^\w+ and underscore characters. There is also a special
> name "0" reserved for writing debug logs to trace prdbg and devdbg events=
.
> The reserved name "0" does not require to be "opened" before use.

theres implication here that p only works when :0.
Is that intended ?
it seems wrong, or at least unnecessary.

In fact, theres no specific reason to exclude +p:trcbuf.mf,
esp if we keep default-trace-buf
since +pTfml  could have that meaning implicitly.
We can call it allowed and "unimplemented until proven useful" on +p

+p completely independent of +T is a simplicity,
lets keep that until proven useful otherwise.

>
> To enable writing usbcore module debug logs to the "usb" trace instance
> opened above a user can issue the command:
>
> localhost ~ # echo "module usbcore =3DpT:usb" >
>                                 <debugfs>/dynamic_debug/control
>
> Please note that output of debug logs to syslog (p flag) and trace (T fla=
g)
> can be independently enabled/disabled for each callsite. Therefore the
> above command will enable writing of debug logs not only to the trace
> instance "usb" but also to syslog.
>
> When trace destination is followed by another flag the next flag has to
> be preeceded with ".", for example
>
> localhost ~ # echo "module usbcore =3DpT:usb.l" >
>                                 <debugfs>/dynamic_debug/control
>
> To simplify processing trace destination can be omitted when default
> trace destination is set, for example the command
>
> localhost ~ # echo "module usbcore =3DpTl" >
>                                 <debugfs>/dynamic_debug/control
>
> will use default trace destination. If default trace destination is not
> set the above command will fail. The default trace destination is set
> when a command with any of the flags [-+=3D] and explicitly provided trac=
e
> destination matches at least one callsite, for example the command
>
> localhost ~ # echo "module usbcore -T:usb" >
>                                 <debugfs>/dynamic_debug/control
>
> will disable trace for all usbcore module callsites (if any was enabled)
> and will set "usb" instance as default trace destination. To enable writi=
ng
> thunderbolt module debug logs to the "usb" trace instance as well a user
> can issue the command:
>
> localhost ~ # echo "module thunderbolt =3DT" >
>                                 <debugfs>/dynamic_debug/control
>
> Since default trace destination was previously set therefore "usb" instan=
ce
> name does not have to be explicitly provided.
>
> When no callsite writes debug logs to a trace instance then it can be
> released (its reference counter decrased) with the "close" command.
decreased

> Closing a trace instance make it unavailable for dynamic debug and also
makes
> allows a user to delete such a trace instance at convenient time later
> with rmdir command. For example when "usb" instance is not used anymore
> a user can issue the command:
>
> localhost ~ # echo "close usb" >
>                                 <debugfs>/dynamic_debug/control
> and then to delete it with:
>
> localhost ~ # rmdir <debugfs>/tracing/instances/
>
> To enable writing usbcore module debug logs to trace dyndbg:prdbg and
> dyndbg:devdbg events user can issue the command:
>
> localhost ~ # echo "module usbcore =3DT:0" >
>                                 <debugfs>/dynamic_debug/control
>
> Then dyndbg trace events can be for example captured with the command:
>
> localhost ~ # trace-cmd start -e dyndbg
>
> And displayed with the command:
>
> localhost ~ # trace-cmd show
>

is there a recipe to show private traces ? prolly worth a mention here.


>
>
> Jim, I made a few changes to the test script dd-selftest.rc you created
> and I also added new test scenarios. You can find the entire patchset
> with the test script changes on top here
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs=
/sandbox/ukaszb/dyndbg_trace_v3
> I wonder where would be the proper place to store the test script
> (upstream, your github.com:jimc/linux.git)
> Do you have a suggestion for that ?
>

I got it (your HEAD), renamed and put it in:
tools/testing/selftests/dynamic_debug/
and copied & modified Makefile and config from ../users/
I added your SOB, that seems proper.

nice additions.  and I like the colors.  maybe they belong in lib.mk,
but thats 4 later.

and tweaked the modules / DUTs to *hopefully* get stable callsite counts
from the tests on them, in virtually any usable config.
DUTs: file init/main, module mm_init, and module test_dynamic_debug (a
config constraint)
The ref-counts are taken from a default virtme-ng -k config on my x86-64 bo=
x

I now pass tests up to:

[root@v6 wk-proof]# ./tools/testing/selftests/dynamic_debug/dyndbg_selftest=
.sh
...
# TEST_PRIVATE_TRACE_6
[ 1009.296557] dyndbg: read 3 bytes from userspace
[ 1009.296876] dyndbg: query 0: <=3D_> on module: <*>
[ 1009.297171] dyndbg: processed 1 queries, with 1559 matches, 0 errs
[ 1009.311621] dyndbg: read 39 bytes from userspace
[ 1009.312032] dyndbg: query 0: <open
A_bit_lengthy_trace_instance_name> on module: <*>
[ 1009.312569] dyndbg: instance is already opened
name:A_bit_lengthy_trace_instance_name
[ 1009.313063] dyndbg: processed 1 queries, with 0 matches, 1 errs
: ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:454
ddcmd() expected to exit with code 0
Error: 'File exists'

it seems invocation dependent
I suspect 2 possibilities:
1-  invoking as shell-script, repeatedly vs vng -e script-name
(one-shot per boot)
2- virtme-ng's minimal-default config has no CONFIG_USB.
   this changes post-conditions of the script, affecting preconditions
of the next run.

2 means that we should replace usbcore with some other always *builtin* mod=
ule.

I chose module params, on the idea that its builtin, but also invoked later=
,
when modules are modprobed with params, so its callsites can be enabled &
then invoked via do_prints, to test for writes to the private trace-buf.

I've pushed it to lukas-v3.0 at jimc.github.com/linux

Would you look at err on _6, above,
and figure out if its insufficiently robust to test preconditions, or
something else ?
and also:
rename test_private_trace_N() to better names
- and/or comments to intent & pattern of use
more tweaks invited in its commit-msg

since cycle_test_problem() is not actually a problem, whats a better name ?
_not_best_practices ?

I think the final test script enhancement needed is (maybe separately):
private-buffer-expected-write-verification after do_prints,
and around modprobe test_dynamic_debug dyndbg=3D$multicmd
subject to 2 below.

> TODOs:
> - update dynamic debug documentation,
> - finalize discussion related to default trace destination
> (whether we want it at all, if yes then conclude on the details)
>

good list. before docs;

wrt default-trace, at least in some details, it seems extra rules to know.
for example, if the default were set on successful open,
rather than successful rule application (iirc), then it would read a lot
like "with" or "using" blocks, esp with <<EOX form

with that new form, it might be pretty expressive:

echo <<YMMV > /proc/dynamic_debug/control
  open sesame # ie with
    module magic_carpet function forward +Tfml
    module magic_lamp function rub_vigorously +Tfmt
  open voicetrace
    module voice2ai function text2cmdprompt +T
    module undo function oh_crap +T
YMMV

I think set-default-on-good-rule-applied is flawed:
it relies on the most complex expression in the grammar to be correct
and without spelling errors, where module unknown is
OK grammatically, but nonsense.
set-default-on-open is simpler to explain and test separately.

We should probably consider modifying the continue-looping behavior
of ddebug_exec_queries, depending upon the return-code.
open, close errors could reasonably warrant different treatment,
like terminating the mult-cmd loop prematurely on open/close errs.
Esp if we keep the set-default-on-good-rule-applied
What do you think ?

I'm inclined to reword a commit-msg or 2, drop RFC, obsolete comments etc.

I can do that in a lukas-v3.1, or as in-thread responses,
do you have a preference ?
some inline below..

> Changes:
> V3 -> V2
> - squash "dyndbg: export _print_hex_dump" with "dyndbg: add support for h=
ex_dump output to trace",
> - squash "dyndbg: tweak pr_info format s/trace dest/trace_dest/"  with "d=
yndbg: add processing of T(race) flag argument",
> - squash "dyndbg: change +T:name_terminator to dot" with "dyndbg: add pro=
cessing of T(race) flag argument",
> - fix setting default trace destination,
> - decrease use count when callsite is being disabled as a part of module =
removal,
> - fix parsing of T flag argument,
> - update __get_str_strip_nl macro per Steve's comment,
> - drop commit "dyndbg: move lock,unlock into ddebug_change, drop goto" an=
d add comment explaining why ddebug_parse_flags
> and ddebug_change have to be run in critical section,
> - add "depends on TRACING" for "DYNAMIC_DEBUG",
> - update DYNAMIC_DEBUG_BRANCH macro which is used when CONFIG_JUMP_LABEL =
is not set,
> - change structure name ddebug_trace_inst to dd_private_tracebuf,
> - change structure name ddebug_trace to dd_tracebuf_tbl_info,
> - rename is_ddebug_cmd to is_dd_trace_cmd,
> - rename validate_tr_name to dd_good_trace_name,
> - rename handle_tr_opend_cmd to handle_trace_opend_cmd and handle_tr_clos=
e_cmd to handle_trace_close_cmd,
> - refactor ddebug_parse_cmd,
> - add pr_err when trace_array_get_by_name or trace_array_init_printk fail=
s in trace_array_init_printk,
> - add static prefix to show_T_args,
> - rename TRACE_DST_MAX to TRACE_DST_LAST and change its value to 64, rese=
rve index 0 for trace events in dd_tracebuf_tbl_info (index 0 will be waste=
d),
> - add "#: " prefix to "Default trace destination" and "Opened trace insta=
nces" and print all opened trace instances on the same line,
>
> V2->V1
> Major rework after receiving feedback in
> https://lore.kernel.org/all/20231103131011.1316396-1-lb@semihalf.com/
>
> This includes among other things:
> - addittion of open/close commands,
> - use names instead of numbers for trace destinations,
> - change prdbg and devdbg trace events to strip newline
> on the slow path (read side),
> - change prdbg and devdbg trace events to stores actual values
> instead of pointers because if a pointer becomes invalid then
> the TP_printk call will cause a crash,
> - add support for default trace destination.
>
> V1
> Major rework after receiving feedback in
> https://lore.kernel.org/all/20230915154856.1896062-1-lb@semihalf.com/
>
> Jim Cromie (14):
>   dyndbg: add _DPRINTK_FLAGS_ENABLED
>   dyndbg: add _DPRINTK_FLAGS_TRACE
>   dyndbg: add write events to tracefs code
>   dyndbg: add 2 trace-events: prdbg, devdbg
>   tracefs: add __get_str_strip_nl - RFC
>   dyndbg: use __get_str_strip_nl in prdbg and devdbg
>   dyndbg: repack _ddebug structure
>   dyndbg: disambiguate quoting in a debug msg
>   dyndbg: fix old BUG_ON in >control parser
>   dyndbg: treat comma as a token separator
>   dyndbg: add skip_spaces_and_coma()

probly just squash this with prev, its not separately tested,
and not worth isolating a test for it.
s/coma/comma/ otherwise.

>   dyndbg: split multi-query strings with %
>   dyndbg: reduce verbose/debug clutter
>   dyndbg: id the bad word in parse-flags err msg
>
> =C5=81ukasz Bartosik (8):
>   dyndbg: move flags field to a new structure
>   dyndbg: add trace destination field to _ddebug
>   dyndbg: add open and close commands for trace
>   dyndbg: don't close trace instance when in use
>   dyndbg: add processing of T(race) flag argument

tweak subject   s/T(race)/+T:prv_trcbuf_name./   - might as well use
legal flag syntax.


>   dyndbg: add support for default trace destination
>   dyndbg: write debug logs to trace instance
>   dyndbg: add support for hex_dump output to trace
>
>  .../admin-guide/dynamic-debug-howto.rst       |   5 +-
>  MAINTAINERS                                   |   1 +
>  include/linux/dynamic_debug.h                 |  57 +-
>  include/trace/events/dyndbg.h                 |  54 ++
>  include/trace/stages/stage3_trace_output.h    |  13 +
>  lib/Kconfig.debug                             |   2 +
>  lib/dynamic_debug.c                           | 736 ++++++++++++++++--
>  7 files changed, 775 insertions(+), 93 deletions(-)
>  create mode 100644 include/trace/events/dyndbg.h
>
> --
> 2.43.0.472.g3155946c3a-goog
>

