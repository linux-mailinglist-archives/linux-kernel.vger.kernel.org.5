Return-Path: <linux-kernel+bounces-2898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C86F8163F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708661C21DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71201FC8;
	Mon, 18 Dec 2023 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="GRA6ppOH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC051FA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so2944252a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702861649; x=1703466449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhMdaoACdYyyW3Y2keeWXLw8Vi+Bjyqnf8GikiW7HhE=;
        b=GRA6ppOHaoYcZSVBFbcUcJ6ZKoSi6gjJIWkDIVwP7XRO+2ZL+gPF1QqEdyqQkwP9Kr
         9ybwCDHWb4iXnwH9IIQFcHrsgmOpVEVIp2fdaBSaJDJmJwFtXaglMrvceTisNFEFZ83k
         qKf49hXTnPpmV2XtJ4PE4zp2Q/mcGV4F48Mrfz00r7xHmdljfzf3EckQOJhftOTz/e30
         mXwbN0h6AX9KP9zSdMMB/0lAqmhw/55PP663BUt7GW3LYmR4vkczrFweY6YatUI+4ye0
         0x9GgqWpcd0eTK82JgvXVeeQ2aw0V3d9ZxMFB7jxDUz93I+uXZVTL0W8mpX9iCTnRZNe
         PWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861649; x=1703466449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhMdaoACdYyyW3Y2keeWXLw8Vi+Bjyqnf8GikiW7HhE=;
        b=M7QCx1EgWD7qxN4zFrgcybqOMgwPUJzrA+0cvxUwrci1UHFnVFIX0n5Ld5JwZWn+Db
         AFdzA3F2FHabJGs3bO2MGEwTZ8SsWu0G7yBl2cXt8qQ2AVFQl91+O7PMd3raaH4KJP7T
         Q+Fbe51nD9N0EM11ZFuVWSINgCTb1uWymt+uA2P8gtovkUTd+cLQ+JUCJ5LvsCxGzP8w
         R280Wr8IkL3j16BhnQJoguodA0mxEMxYdICRHh/WvOvtH/OGSEW5Y05yicD+mcQLghMN
         52N6NBAhex2KTzSOMeWtzJeZNyO4I17QDEiJzVYQ8+M6f1sFjxuCXSRcTVQC7Ho8JxVy
         K1RA==
X-Gm-Message-State: AOJu0YwtINjAMSv9JWFcjwu+7JNVz2vIpNR3kHF4Vt/XF869sOcJ+pg6
	whRw0/M/3YGUpeCihNsHEDb2sQuXyvLxDUki3LZL
X-Google-Smtp-Source: AGHT+IF6Awjl7gqPKFuetm0KmiiwLOmRZjITdFgbB0ZKgnTzpIKqCiUcbahsEnY7m+ljpLd8rotUav/EPdKZNQQottc=
X-Received: by 2002:a05:6402:5c1:b0:54c:b2e6:1c7a with SMTP id
 n1-20020a05640205c100b0054cb2e61c7amr5901531edx.0.1702861648933; Sun, 17 Dec
 2023 17:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130234048.157509-1-lb@semihalf.com> <20231130234048.157509-11-lb@semihalf.com>
 <CAJfuBxwYhidyr0Fmjbf8Sp1H0-f8yWx4eazE301HtkzrboThqA@mail.gmail.com>
In-Reply-To: <CAJfuBxwYhidyr0Fmjbf8Sp1H0-f8yWx4eazE301HtkzrboThqA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Mon, 18 Dec 2023 02:07:17 +0100
Message-ID: <CAK8ByeLwbYZW6zLnjy4UZsjvoDNkiudAgiNxRCbOPg8DLKGe0Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dyndbg: add open and close commands for trace
To: jim.cromie@gmail.com
Cc: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Guenter Roeck <groeck@google.com>, Yaniv Tzoreff <yanivt@google.com>, Benson Leung <bleung@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sob., 16 gru 2023 o 07:17 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> ** entering the bikeshed **
>
> On Thu, Nov 30, 2023 at 4:41=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > Add open and close commands for opening and closing trace instances.
> > The open command has to be mandatory followed by a trace instance name.
> > If a trace instance already exists in <debugfs>/tracing/instances
> > directory then the open command will reuse it otherwise a new trace
> > instance with a name provided to the open will be created. Close
> > command closes previously opened trace instance. The close will
> > fail if a user tries to close non-existent trace instances or an
> > instance which was not previously opened.
> >
> > For example the following command will open (create or reuse existing)
> > trace instance located in <debugfs>/tracing/instances/usbcore:
> >
> >     echo "open usbcore" > <debugfs>/dynamic_debug/control
> >
> > Signed-off-by: =C5=81ukasz Bartosik <lb@semihalf.com>
> > ---
> >  lib/Kconfig.debug   |   1 +
> >  lib/dynamic_debug.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 194 insertions(+)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 5bc56c7247a2..f184c3c91ba3 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -181,6 +181,7 @@ config DYNAMIC_DEBUG_CORE
> >         bool "Enable core function of dynamic debug support"
> >         depends on PRINTK
> >         depends on (DEBUG_FS || PROC_FS)
> > +       depends on TRACING
> >         help
> >           Enable core functional support of dynamic debug. It is useful
> >           when you want to tie dynamic debug to your kernel modules wit=
h
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 0dc9ec76b867..43e94023a4eb 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/device.h>
> >  #include <linux/netdevice.h>
> > +#include <linux/trace.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/dyndbg.h>
> > @@ -73,6 +74,25 @@ struct flag_settings {
> >         unsigned int mask;
> >  };
> >
> > +#define DD_OPEN_CMD    "open"
> > +#define DD_CLOSE_CMD   "close"
> > +#define DD_TR_EVENT    "0"
> > +
> > +struct ddebug_trace_inst {
> > +       const char *name;
> > +       struct trace_array *arr;
> > +};
>
> can we bikeshed the struct name here ?
> inst is not a great abbreviation, its hard to say,
> and tends to look like a spelling error.
>
>  _tr_ appearing later on in function names isnt great either.
>

Would like me to replace all _tr_ with _trace_ ? Or do you other
suggestion to names ?

> dd_private_tracebuf ??
>

I will change the name

> I could get used to EVENT for the global tracebuf,
> but I dont find it entirely natural.
> Is it a convention in any way ?
>
> FWIW, I chose "class" as synonymous with (modelled after)
> drm's category, but spelled different (and shorter)
>
>
>
> > +
> > +/*
> > + * TRACE_DST_MAX value is reserved for writing
> > + * debug logs to trace events (prdbg, devdbg)
> > + */
> > +struct ddebug_trace {
> > +       struct ddebug_trace_inst inst[TRACE_DST_MAX-1];
> > +       DECLARE_BITMAP(bmap, TRACE_DST_MAX-1);
> > +       int bmap_size;
> > +};
>
> some kind of tbl in the name ?
> struct _ddebug_info contains descriptors and classes,
> struct dd_tracebuf_tbl_info ??

Ack

> (maybe not, but hopefully it prompts better)
>
> Also, since it touches on the 0 as EVENTS global trace-buf,
> does it simplify if we just waste index 0 in the inst[] array,
> and change MAX to LAST ?
> Or is it too much magic in 0 this way ?
>

Wasting index 0 might work. I will verify if there are no major
obstacles and will change if nothing pops up.

> > +
> >  static DEFINE_MUTEX(ddebug_lock);
> >  static LIST_HEAD(ddebug_tables);
> >  static int verbose;
> > @@ -80,6 +100,8 @@ module_param(verbose, int, 0644);
> >  MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
> >                  "( 0 =3D off (default), 1 =3D module add/rm, 2 =3D >co=
ntrol summary, 3 =3D parsing, 4 =3D per-site changes)");
> >
> > +static struct ddebug_trace tr =3D { .bmap_size =3D TRACE_DST_MAX-1 };
>
> cryptic name.
> it does appear ~20x in kernel/trace/trace_events.c
> usually as trace_array_put(tr)
>
>    trc_tbl ?
>

Ack

> and where is the map itself established ?
>

DECLARE_BITMAP(bmap, TRACE_DST_MAX-1); in struct ddebug_trace

> > +
> >  static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
> >  {
> >         return &desc->ctrl;
> > @@ -171,6 +193,148 @@ static void vpr_info_dq(const struct ddebug_query=
 *query, const char *msg)
> >                   query->first_lineno, query->last_lineno, query->class=
_string);
> >  }
> >
> > +static bool is_ddebug_cmd(const char *str)
>
> is_dd_trace_cmd()
>

Ack

> > +{
> > +       if (!strcmp(str, DD_OPEN_CMD) ||
> > +           !strcmp(str, DD_CLOSE_CMD))
>
> single line < 80 chr ?
>

Ack

> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> > +static bool validate_tr_name(const char *str)
>
> something less procedural sounding, and more is-ok?
> dd_good_trace_name ?
>

Ack

> > +{
> > +       /* "0" is reserved for writing debug logs to trace events (prdb=
g, devdbg) */
> > +       if (!strcmp(str, DD_TR_EVENT))
> > +               return false;
> > +
> > +       /* we allow trace instance names to include ^\w+ and underscore=
 */
> > +       while (*str !=3D '\0') {
> > +               if (!isalnum(*str) && *str !=3D '_')
> > +                       return false;
> > +               str++;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> > +static int find_tr_instance(const char *name)
>
> is this finding a slot ?

This function finds index of trace instance which was previously
"opened" (with open command)

> not that slot is meaningful, but instance is at risk of overuse.
>

What is your suggestion for a function name ?

> > +{
> > +       int idx;
> > +
> > +       for_each_set_bit(idx, tr.bmap, tr.bmap_size)
> > +               if (!strcmp(tr.inst[idx].name, name))
> > +                       return idx;
> > +
> > +       return -ENOENT;
> > +}
> > +
> > +static int handle_tr_opend_cmd(const char *arg)
>
> handle_open_?trace_cmd or  handle_trace_?open_cmd ?
>

I will change to handle_trace_open_cmd

> > +{
> > +       struct ddebug_trace_inst *inst;
> > +       int idx, ret =3D 0;
> > +
> > +       mutex_lock(&ddebug_lock);
> > +
> > +       idx =3D find_first_zero_bit(tr.bmap, tr.bmap_size);
> > +       if (idx =3D=3D tr.bmap_size) {
> > +               ret =3D -ENOSPC;
> > +               goto end;
> > +       }
> > +
> > +       if (!validate_tr_name(arg)) {
> > +               pr_err("invalid instance name:%s\n", arg);
> > +               ret =3D -EINVAL;
> > +               goto end;
> > +       }
> > +
> > +       if (find_tr_instance(arg) >=3D 0) {
> > +               pr_err("instance is already opened name:%s\n ", arg);
> > +               ret =3D -EEXIST;
> > +               goto end;
> > +       }
> > +
> > +       inst =3D &tr.inst[idx];
> > +       inst->name =3D kstrdup(arg, GFP_KERNEL);
> > +       if (!inst->name) {
> > +               ret =3D -ENOMEM;
> > +               goto end;
> > +       }
> > +
> > +       inst->arr =3D trace_array_get_by_name(inst->name);
> > +       if (!inst->arr) {
>
> any advice (pr_notice) worth giving if this happens ?

I will add

> conversely, does this get need a corresponding put ?
> yes - I see it in the close-cmd-handler
> if so, can we check the inst->arr before (re-)calling get-by-name ?
>

The open/close commands make sure that we won't call trace_array_get_by_nam=
e
on the same trace instance again before it is closed. The open command
will fail if it is called again for already opened instance.
The open command increases reference count of the instance and close
command decrements it.
Checking inst->arr without holding its reference would be risky.

> Or does doing this tie up the instance,
> blocking the user from deleting it ?
>

Function trace_array_get_by_name also increases reference count of a
given trace instance
which prohibits a user from deleting it.

> > +               ret =3D -EINVAL;
> > +               goto end;trace_array_get_by_name
> > +       }
> > +
> > +       ret =3D trace_array_init_printk(inst->arr);
> > +       if (ret) {
> > +               trace_array_put(inst->arr);
> > +               trace_array_destroy(inst->arr);
> > +               goto end;
> > +       }
> > +
> > +       set_bit(idx, tr.bmap);
> > +       v3pr_info("opened trace instance idx=3D%d, name=3D%s\n", idx, a=
rg);
> > +end:
> > +       mutex_unlock(&ddebug_lock);
> > +       return ret;
> > +}
> > +
> > +static int handle_tr_close_cmd(const char *arg)
> > +{
> > +       struct ddebug_trace_inst *inst;
> > +       int idx, ret =3D 0;
> > +
> > +       mutex_lock(&ddebug_lock);
> > +
> > +       idx =3D find_tr_instance(arg);
> > +       if (idx < 0) {
> > +               ret =3D idx;
> > +               goto end;
> > +       }
> > +
> > +       inst =3D &tr.inst[idx];
> > +
> > +       trace_array_put(inst->arr);
> > +       /*
> > +        * don't destroy trace instance but let user do it manually
> > +        * with rmdir command at a convenient time later, if it is
> > +        * destroyed here all debug logs will be lost
> > +        *
>
> aha.  thx for this comment. it clarifies something I asked somewhere
>

;)

> > +        * trace_array_destroy(inst->arr);
> > +        */
> > +       inst->arr =3D NULL;
> > +
> > +       kfree(inst->name);
> > +       inst->name =3D NULL;
> > +
> > +       clear_bit(idx, tr.bmap);
> > +       v3pr_info("closed trace instance idx=3D%d, name=3D%s\n", idx, a=
rg);
> > +end:
> > +       mutex_unlock(&ddebug_lock);
> > +       return ret;
> > +}
> > +
> > +static int ddebug_parse_cmd(char *words[], int nwords)
> > +{
> > +       int ret;
> > +
> > +       if (nwords !=3D 1)
> > +               return -EINVAL;
> > +
> > +       if (!strcmp(words[0], DD_OPEN_CMD))
> > +               ret =3D handle_tr_opend_cmd(words[1]);
>
>   just return handle_() ?
>   and drop following else
>

Ack

> > +       else if (!strcmp(words[0], DD_CLOSE_CMD))
> > +               ret =3D handle_tr_close_cmd(words[1]);
> > +       else {
> > +               pr_err("invalid command %s\n", words[0]);
> > +               ret =3D -EINVAL;
>
> just return here.
>

Ack

Thanks,
Lukasz


> > +}
> > +
> >  static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_=
table const *dt,
> >                                                           const char *c=
lass_string, int *class_id)
> >  {
> > @@ -567,6 +731,11 @@ static int ddebug_exec_query(char *query_string, c=
onst char *modname)
> >                 pr_err("tokenize failed\n");
> >                 return -EINVAL;
> >         }
> > +
> > +       /* check for open, close commands */
> > +       if (is_ddebug_cmd(words[0]))
> > +               return ddebug_parse_cmd(words, nwords-1);
> > +
> >         /* check flags 1st (last arg) so query is pairs of spec,val */
> >         if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
> >                 pr_err("flags parse failed\n");
> > @@ -1191,6 +1360,20 @@ static struct _ddebug *ddebug_iter_next(struct d=
debug_iter *iter)
> >         return &iter->table->ddebugs[iter->idx];
> >  }
> >
> > +/*
> > + * Check if the iterator points to the last _ddebug object
> > + * to traverse.
> > + */
> > +static bool ddebug_iter_is_last(struct ddebug_iter *iter)
> > +{
> > +       if (iter->table =3D=3D NULL)
> > +               return false;
> > +       if (iter->idx-1 < 0 &&
> > +           list_is_last(&iter->table->link, &ddebug_tables))
> > +               return true;
> > +       return false;
> > +}
> > +
> >  /*
> >   * Seq_ops start method.  Called at the start of every
> >   * read() call from userspace.  Takes the ddebug_lock and
> > @@ -1281,6 +1464,16 @@ static int ddebug_proc_show(struct seq_file *m, =
void *p)
> >         }
> >         seq_puts(m, "\n");
> >
> > +       if (ddebug_iter_is_last(iter) &&
> > +           !bitmap_empty(tr.bmap, tr.bmap_size)) {
> > +               int idx;
> > +
> > +               seq_puts(m, "\n");
> > +               seq_puts(m, "Opened trace instances:\n");
> > +               for_each_set_bit(idx, tr.bmap, tr.bmap_size)
> > +                       seq_printf(m, "%s\n", tr.inst[idx].name);
> > +       }
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >

