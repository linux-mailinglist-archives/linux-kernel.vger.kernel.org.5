Return-Path: <linux-kernel+bounces-2110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACA18157FE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717B1282287
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503E156C2;
	Sat, 16 Dec 2023 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFLUsH/8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A012154A0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4259c7dfb63so9354141cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702707450; x=1703312250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9funWxOfefT592Dy2FEP5WAfCVFqoc4vYrUREvWZCE=;
        b=YFLUsH/8e65bkYNqA/8Yrw+xspc2FPfIvx2/HW81g03eTwmXFm5nfMfR1BlfH+EeuV
         6SXPLOYX8YNJBSKvKb6VmViVb7+uzSiG0NNhzJHkmh9tO7+XuF+PiFtf3gv1NzgXwcyT
         oC7aC+7yPRDAqugS/wcHYAdEn8rrnaucQOdIDwgCwlP2YP3REM9Cs4SfBeSBLktG4J8C
         1sLd5b3G8v4pjCgOnh0Rid20nWZs1bQ2P9GS4J7H8ZN3GWRRcjUXxLwpPpHB0umm+w0e
         bnEq4iJMwxachL5KKbsZEuZEpvVwFUXt5bwxg7bs/hlvOGIq972qDPsilbLmuzLqppBT
         W7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702707450; x=1703312250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9funWxOfefT592Dy2FEP5WAfCVFqoc4vYrUREvWZCE=;
        b=nQV7VwAG5w5sCp33StTJXWmPM1Z+yxXe12QqncIprwVJSJ+DkOXiOpPU96RQ+ltXZH
         na58b+keml3FzMwy5HYdUNtQo8SBpl0g4baF12XZIRGiFXIQwRgRPnHfE+LXGsKrz6PT
         yuT5aGq+veJgnqIXbAuMAd2Vnw2NMXxEo/iFWzQvpp9VyehkYneOr6+9/p6gW42FMh3v
         WfbNo9zzw0UWdFv7G8wlh7Gvk5O2kyvWR5t4eYcGheGMg6JqUglxWfMA3KT3e0cGFukt
         wcRsOqHJfyQjeNXS6XCGXYmtxaXpORtTwsfWYWNeR2qtc0V5tVXg+rbSu3EZ+LDWQNG+
         skrg==
X-Gm-Message-State: AOJu0Yw4VXIckEUH+EHU13tj83sKc645qyVtr3a5eUyTELZ4Y773WF3/
	U72+vY+pm233Uu5JPvRElF4Ht+uas5qU5UaKAjs=
X-Google-Smtp-Source: AGHT+IEaotvTCxqhBjSXXcBpjOh1c8M/RGYsnJyQVcd2jNQEGN5VxtrcbwXy9jWLBwy/BsnPdWLW/A/TYI/5pv6gcdw=
X-Received: by 2002:a05:620a:11b9:b0:77f:8be6:25f7 with SMTP id
 c25-20020a05620a11b900b0077f8be625f7mr7641347qkk.8.1702707450110; Fri, 15 Dec
 2023 22:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130234048.157509-1-lb@semihalf.com> <20231130234048.157509-11-lb@semihalf.com>
In-Reply-To: <20231130234048.157509-11-lb@semihalf.com>
From: jim.cromie@gmail.com
Date: Fri, 15 Dec 2023 23:17:03 -0700
Message-ID: <CAJfuBxwYhidyr0Fmjbf8Sp1H0-f8yWx4eazE301HtkzrboThqA@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dyndbg: add open and close commands for trace
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Guenter Roeck <groeck@google.com>, Yaniv Tzoreff <yanivt@google.com>, Benson Leung <bleung@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

** entering the bikeshed **

On Thu, Nov 30, 2023 at 4:41=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> Add open and close commands for opening and closing trace instances.
> The open command has to be mandatory followed by a trace instance name.
> If a trace instance already exists in <debugfs>/tracing/instances
> directory then the open command will reuse it otherwise a new trace
> instance with a name provided to the open will be created. Close
> command closes previously opened trace instance. The close will
> fail if a user tries to close non-existent trace instances or an
> instance which was not previously opened.
>
> For example the following command will open (create or reuse existing)
> trace instance located in <debugfs>/tracing/instances/usbcore:
>
>     echo "open usbcore" > <debugfs>/dynamic_debug/control
>
> Signed-off-by: =C5=81ukasz Bartosik <lb@semihalf.com>
> ---
>  lib/Kconfig.debug   |   1 +
>  lib/dynamic_debug.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 194 insertions(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5bc56c7247a2..f184c3c91ba3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -181,6 +181,7 @@ config DYNAMIC_DEBUG_CORE
>         bool "Enable core function of dynamic debug support"
>         depends on PRINTK
>         depends on (DEBUG_FS || PROC_FS)
> +       depends on TRACING
>         help
>           Enable core functional support of dynamic debug. It is useful
>           when you want to tie dynamic debug to your kernel modules with
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 0dc9ec76b867..43e94023a4eb 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -36,6 +36,7 @@
>  #include <linux/sched.h>
>  #include <linux/device.h>
>  #include <linux/netdevice.h>
> +#include <linux/trace.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/dyndbg.h>
> @@ -73,6 +74,25 @@ struct flag_settings {
>         unsigned int mask;
>  };
>
> +#define DD_OPEN_CMD    "open"
> +#define DD_CLOSE_CMD   "close"
> +#define DD_TR_EVENT    "0"
> +
> +struct ddebug_trace_inst {
> +       const char *name;
> +       struct trace_array *arr;
> +};

can we bikeshed the struct name here ?
inst is not a great abbreviation, its hard to say,
and tends to look like a spelling error.

 _tr_ appearing later on in function names isnt great either.

dd_private_tracebuf ??

I could get used to EVENT for the global tracebuf,
but I dont find it entirely natural.
Is it a convention in any way ?

FWIW, I chose "class" as synonymous with (modelled after)
drm's category, but spelled different (and shorter)



> +
> +/*
> + * TRACE_DST_MAX value is reserved for writing
> + * debug logs to trace events (prdbg, devdbg)
> + */
> +struct ddebug_trace {
> +       struct ddebug_trace_inst inst[TRACE_DST_MAX-1];
> +       DECLARE_BITMAP(bmap, TRACE_DST_MAX-1);
> +       int bmap_size;
> +};

some kind of tbl in the name ?
struct _ddebug_info contains descriptors and classes,
struct dd_tracebuf_tbl_info ??
(maybe not, but hopefully it prompts better)

Also, since it touches on the 0 as EVENTS global trace-buf,
does it simplify if we just waste index 0 in the inst[] array,
and change MAX to LAST ?
Or is it too much magic in 0 this way ?

> +
>  static DEFINE_MUTEX(ddebug_lock);
>  static LIST_HEAD(ddebug_tables);
>  static int verbose;
> @@ -80,6 +100,8 @@ module_param(verbose, int, 0644);
>  MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
>                  "( 0 =3D off (default), 1 =3D module add/rm, 2 =3D >cont=
rol summary, 3 =3D parsing, 4 =3D per-site changes)");
>
> +static struct ddebug_trace tr =3D { .bmap_size =3D TRACE_DST_MAX-1 };

cryptic name.
it does appear ~20x in kernel/trace/trace_events.c
usually as trace_array_put(tr)

   trc_tbl ?

and where is the map itself established ?

> +
>  static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
>  {
>         return &desc->ctrl;
> @@ -171,6 +193,148 @@ static void vpr_info_dq(const struct ddebug_query *=
query, const char *msg)
>                   query->first_lineno, query->last_lineno, query->class_s=
tring);
>  }
>
> +static bool is_ddebug_cmd(const char *str)

is_dd_trace_cmd()

> +{
> +       if (!strcmp(str, DD_OPEN_CMD) ||
> +           !strcmp(str, DD_CLOSE_CMD))

single line < 80 chr ?

> +               return true;
> +
> +       return false;
> +}
> +
> +static bool validate_tr_name(const char *str)

something less procedural sounding, and more is-ok?
dd_good_trace_name ?

> +{
> +       /* "0" is reserved for writing debug logs to trace events (prdbg,=
 devdbg) */
> +       if (!strcmp(str, DD_TR_EVENT))
> +               return false;
> +
> +       /* we allow trace instance names to include ^\w+ and underscore *=
/
> +       while (*str !=3D '\0') {
> +               if (!isalnum(*str) && *str !=3D '_')
> +                       return false;
> +               str++;
> +       }
> +
> +       return true;
> +}
> +
> +static int find_tr_instance(const char *name)

is this finding a slot ?
not that slot is meaningful, but instance is at risk of overuse.

> +{
> +       int idx;
> +
> +       for_each_set_bit(idx, tr.bmap, tr.bmap_size)
> +               if (!strcmp(tr.inst[idx].name, name))
> +                       return idx;
> +
> +       return -ENOENT;
> +}
> +
> +static int handle_tr_opend_cmd(const char *arg)

handle_open_?trace_cmd or  handle_trace_?open_cmd ?

> +{
> +       struct ddebug_trace_inst *inst;
> +       int idx, ret =3D 0;
> +
> +       mutex_lock(&ddebug_lock);
> +
> +       idx =3D find_first_zero_bit(tr.bmap, tr.bmap_size);
> +       if (idx =3D=3D tr.bmap_size) {
> +               ret =3D -ENOSPC;
> +               goto end;
> +       }
> +
> +       if (!validate_tr_name(arg)) {
> +               pr_err("invalid instance name:%s\n", arg);
> +               ret =3D -EINVAL;
> +               goto end;
> +       }
> +
> +       if (find_tr_instance(arg) >=3D 0) {
> +               pr_err("instance is already opened name:%s\n ", arg);
> +               ret =3D -EEXIST;
> +               goto end;
> +       }
> +
> +       inst =3D &tr.inst[idx];
> +       inst->name =3D kstrdup(arg, GFP_KERNEL);
> +       if (!inst->name) {
> +               ret =3D -ENOMEM;
> +               goto end;
> +       }
> +
> +       inst->arr =3D trace_array_get_by_name(inst->name);
> +       if (!inst->arr) {

any advice (pr_notice) worth giving if this happens ?
conversely, does this get need a corresponding put ?
yes - I see it in the close-cmd-handler
if so, can we check the inst->arr before (re-)calling get-by-name ?

Or does doing this tie up the instance,
blocking the user from deleting it ?

> +               ret =3D -EINVAL;
> +               goto end;trace_array_get_by_name
> +       }
> +
> +       ret =3D trace_array_init_printk(inst->arr);
> +       if (ret) {
> +               trace_array_put(inst->arr);
> +               trace_array_destroy(inst->arr);
> +               goto end;
> +       }
> +
> +       set_bit(idx, tr.bmap);
> +       v3pr_info("opened trace instance idx=3D%d, name=3D%s\n", idx, arg=
);
> +end:
> +       mutex_unlock(&ddebug_lock);
> +       return ret;
> +}
> +
> +static int handle_tr_close_cmd(const char *arg)
> +{
> +       struct ddebug_trace_inst *inst;
> +       int idx, ret =3D 0;
> +
> +       mutex_lock(&ddebug_lock);
> +
> +       idx =3D find_tr_instance(arg);
> +       if (idx < 0) {
> +               ret =3D idx;
> +               goto end;
> +       }
> +
> +       inst =3D &tr.inst[idx];
> +
> +       trace_array_put(inst->arr);
> +       /*
> +        * don't destroy trace instance but let user do it manually
> +        * with rmdir command at a convenient time later, if it is
> +        * destroyed here all debug logs will be lost
> +        *

aha.  thx for this comment. it clarifies something I asked somewhere

> +        * trace_array_destroy(inst->arr);
> +        */
> +       inst->arr =3D NULL;
> +
> +       kfree(inst->name);
> +       inst->name =3D NULL;
> +
> +       clear_bit(idx, tr.bmap);
> +       v3pr_info("closed trace instance idx=3D%d, name=3D%s\n", idx, arg=
);
> +end:
> +       mutex_unlock(&ddebug_lock);
> +       return ret;
> +}
> +
> +static int ddebug_parse_cmd(char *words[], int nwords)
> +{
> +       int ret;
> +
> +       if (nwords !=3D 1)
> +               return -EINVAL;
> +
> +       if (!strcmp(words[0], DD_OPEN_CMD))
> +               ret =3D handle_tr_opend_cmd(words[1]);

  just return handle_() ?
  and drop following else

> +       else if (!strcmp(words[0], DD_CLOSE_CMD))
> +               ret =3D handle_tr_close_cmd(words[1]);
> +       else {
> +               pr_err("invalid command %s\n", words[0]);
> +               ret =3D -EINVAL;

just return here.

> +}
> +
>  static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_ta=
ble const *dt,
>                                                           const char *cla=
ss_string, int *class_id)
>  {
> @@ -567,6 +731,11 @@ static int ddebug_exec_query(char *query_string, con=
st char *modname)
>                 pr_err("tokenize failed\n");
>                 return -EINVAL;
>         }
> +
> +       /* check for open, close commands */
> +       if (is_ddebug_cmd(words[0]))
> +               return ddebug_parse_cmd(words, nwords-1);
> +
>         /* check flags 1st (last arg) so query is pairs of spec,val */
>         if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
>                 pr_err("flags parse failed\n");
> @@ -1191,6 +1360,20 @@ static struct _ddebug *ddebug_iter_next(struct dde=
bug_iter *iter)
>         return &iter->table->ddebugs[iter->idx];
>  }
>
> +/*
> + * Check if the iterator points to the last _ddebug object
> + * to traverse.
> + */
> +static bool ddebug_iter_is_last(struct ddebug_iter *iter)
> +{
> +       if (iter->table =3D=3D NULL)
> +               return false;
> +       if (iter->idx-1 < 0 &&
> +           list_is_last(&iter->table->link, &ddebug_tables))
> +               return true;
> +       return false;
> +}
> +
>  /*
>   * Seq_ops start method.  Called at the start of every
>   * read() call from userspace.  Takes the ddebug_lock and
> @@ -1281,6 +1464,16 @@ static int ddebug_proc_show(struct seq_file *m, vo=
id *p)
>         }
>         seq_puts(m, "\n");
>
> +       if (ddebug_iter_is_last(iter) &&
> +           !bitmap_empty(tr.bmap, tr.bmap_size)) {
> +               int idx;
> +
> +               seq_puts(m, "\n");
> +               seq_puts(m, "Opened trace instances:\n");
> +               for_each_set_bit(idx, tr.bmap, tr.bmap_size)
> +                       seq_printf(m, "%s\n", tr.inst[idx].name);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

