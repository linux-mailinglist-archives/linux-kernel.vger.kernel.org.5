Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAC7AA9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjIVHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIVHVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:21:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C2C2;
        Fri, 22 Sep 2023 00:21:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-503065c4b25so2883852e87.1;
        Fri, 22 Sep 2023 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695367265; x=1695972065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J09BkyKjJxxQZQkhZ/+lLdlfpR0Mi3cmWdD7ssW7VS8=;
        b=BIqpCH/yq3vJOuGkZXyUZ+YyMGcABKP64iKtkBWfON+QFWlX7g1BMCTyI3HAjKa9KD
         sIAnDvNUWtFN0rA7iH+QG01OnnvV/nMIsp87iXl8xjPNs2O5vvfAUOP38iPi3ava9KhT
         Vq30X1jdyawpkDRtSiX7v7OqsEdBQi9M3Is1f4omzlwPNSyzxEqH+YaFqGng8q6dHTaI
         2p3RUfO+V2sF7+kGBezt4LFi81fD3B/ZhlkxYi4NKW+rKUHOry+2Ch8q61EizWeV+Qrg
         MKp7bTq8bCV0S2G2Q6WN7SgceIR0AqZ+EX03Z/IMP/kCUGGJQsJcT07rYLgYcFSf7Uhx
         e5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695367265; x=1695972065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J09BkyKjJxxQZQkhZ/+lLdlfpR0Mi3cmWdD7ssW7VS8=;
        b=GqqHKtOcl26wzFH7dkTs/6jNWZWg9UALS/ylIjiAxkGgL3abODQyDSTj7zW/M+SQCn
         yFv4sFyutF2oj3/9HMnsxahNie+4rW5r2YrXcSG0Qi58joLdr5oiOL5zZNhw9mXNID6p
         cjsQjsRUTztM2P62C6Wj5bvMFf8RNcRowKugRX/THxNwL26CkTieIcRTSRRcZTMACgCQ
         Lk8d16BGjkEV6ISAel2BWjEPtvXUuSL7TOnErx08gaQMmpjh0FciL6JslTqLwnbkKmmu
         hejhHYndgFYlRS4JRIedAyb+6v2YP3cWR2zdSsVS1z9bdBHzpP230cmY9vt+kD7csXSg
         qLNg==
X-Gm-Message-State: AOJu0YyVOk0zfK9pOxoXjjPvqBawPVi1DyhN1K/N+6Ab+nr5HewOhsmL
        kASrjtiWS60oTHGwTnPVM2movkun0+UbQ//5O90=
X-Google-Smtp-Source: AGHT+IHfKyoNl9gq1bvrek/hvmuNXoP8wM8iLrZy91tHkq6lpuVBkur3FuFTQdmrKy3Ax1+ghjltqcwsRRKPSUFCAAM=
X-Received: by 2002:a05:6512:3702:b0:503:3644:4a99 with SMTP id
 z2-20020a056512370200b0050336444a99mr6491595lfr.51.1695367264891; Fri, 22 Sep
 2023 00:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de> <CAAfh-jPc+UWMcLPFbYy6rYUh4OU36frkVYVbkhNPNX4L6RG5sA@mail.gmail.com>
 <2023091547-mug-unlikable-571f@gregkh> <ZQSHJ_786kZNjEDX@alley>
In-Reply-To: <ZQSHJ_786kZNjEDX@alley>
From:   Enlin Mu <enlinmu@gmail.com>
Date:   Fri, 22 Sep 2023 15:20:37 +0800
Message-ID: <CAAfh-jMvgYfDrgcbj7o4bv83syAhL2d+1r2vn1Yz+FY_Ws81Pw@mail.gmail.com>
Subject: Re: [PATCH] printk: add cpu id information to printk() output
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Enlin Mu <enlin.mu@outlook.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, enlin.mu@unisoc.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8816=E6=97=A5=
=E5=91=A8=E5=85=AD 00:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 2023-09-15 11:53:13, Greg KH wrote:
> > On Fri, Sep 15, 2023 at 04:46:02PM +0800, Enlin Mu wrote:
> > > John Ogness <john.ogness@linutronix.de> =E4=BA=8E2023=E5=B9=B49=E6=9C=
=8815=E6=97=A5=E5=91=A8=E4=BA=94 16:34=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> > > > > Sometimes we want to print cpu id of printk() messages to console=
s
> > > > >
> > > > > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > > > > index c34173e6c5f1..6700bd9a174f 100644
> > > > > --- a/include/linux/threads.h
> > > > > +++ b/include/linux/threads.h
> > > > > @@ -34,6 +34,9 @@
> > > > >  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> > > > >       (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> > > > >
> > > > > +#define CPU_ID_SHIFT 23
> > > > > +#define CPU_ID_MASK  0xff800000
> > > >
> > > > This only supports 256 CPUs. I think it doesn't make sense to try t=
o
> > > > squish CPU and Task IDs into 32 bits.
> > > Yes, it is not good way,
> > > >
> > > > What about introducing a caller_id option to always only print the =
CPU
> > > > ID? Or do you really need Task _and_ CPU?
> > >    Yes, I need it.Because I need to know which CPU is printing the
> > > log, so that I can identify the current system operation, such as loa=
d
> > > situation and CPU busy/idle status
> >
> > The cpu that is printing the log isn't the one that added the log
> > message, so I think you will have incorrect data here, right?
>
> We already store some metadata about the caller:
>
>  * All fields are set by the printk code except for @seq, which is
>  * set by the ringbuffer code.
>  */
> struct printk_info {
>         u64     seq;            /* sequence number */
>         u64     ts_nsec;        /* timestamp in nanoseconds */
>         u16     text_len;       /* length of text message */
>         u8      facility;       /* syslog facility */
>         u8      flags:5;        /* internal record flags */
>         u8      level:3;        /* syslog level */
>         u32     caller_id;      /* thread id or processor id */
>
>         struct dev_printk_info  dev_info;
> };
>
> The 32-bit caller ID is generated using:
>
> static inline u32 printk_caller_id(void)
> {
>         return in_task() ? task_pid_nr(current) :
>                 0x80000000 + smp_processor_id();
> }
>
> We could add more metadata and always store the CPU ID and something
> like:
>
>    [CTXT][ Tpid][  Ccpu]
>
> for example
>
>    [TASK][  T234][    C4]
>    [ IRQ][ T4567][   C17]
>    [SIRQ][    T5][    C0]
>    [ NMI][  T356][  C128]
>
Greate!
Do you have a plan to push it to linus?
>
> The biggest problem is that it would change the format of the
> ringbuffer so that it would require updating external tools,
> working with crashdump, especially crash but there are also
> alternative python extensions for gdb.
>
>
> See below POC of the kernel part. It is not even compile tested. The size
> of the buffers is updated by a guess. Comments are not updated, ...
>
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 7d4979d5c3ce..e3e0a9fdc0cf 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -15,7 +15,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, =
int write,
>  #ifdef CONFIG_PRINTK
>
>  #ifdef CONFIG_PRINTK_CALLER
> -#define PRINTK_PREFIX_MAX      48
> +#define PRINTK_PREFIX_MAX      64
>  #else
>  #define PRINTK_PREFIX_MAX      32
>  #endif
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7e0b4dd02398..bb393ccbd5e9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -621,16 +621,20 @@ static void append_char(char **pp, char *e, char c)
>                 *(*pp)++ =3D c;
>  }
>
> +char printk_caller_ctxt_txt[][] =3D { "TSK", "IRQ", "SIRQ", "NMI"' };
> +
>  static ssize_t info_print_ext_header(char *buf, size_t size,
>                                      struct printk_info *info)
>  {
>         u64 ts_usec =3D info->ts_nsec;
> -       char caller[20];
> +       char caller[40];
>  #ifdef CONFIG_PRINTK_CALLER
> -       u32 id =3D info->caller_id;
> +       struct printk_caller_info *ci =3D info->caller_info;
>
> -       snprintf(caller, sizeof(caller), ",caller=3D%c%u",
> -                id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
> +       snprintf(caller, sizeof(caller),
> +                ",caller.ctxt=3D%s,caller.pid=3D%d,caller.cpu=3D%d",
> +                printk_caller_ctxt_txt[ci->ctxt],
> +                ci->pid,ci->cpu);
>  #else
>         caller[0] =3D '\0';
>  #endif
> @@ -996,11 +1000,16 @@ void log_buf_vmcoreinfo_setup(void)
>         VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
>         VMCOREINFO_OFFSET(prb_data_blk_lpos, next);
>
> +       VMCOREINFO_STRUCT_SIZE(printk_caller_info);
> +       VMCOREINFO_OFFSET(printk_caller_info, ctxt);
> +       VMCOREINFO_OFFSET(printk_caller_info, cpu);
> +       VMCOREINFO_OFFSET(printk_caller_info, pid);
> +
>         VMCOREINFO_STRUCT_SIZE(printk_info);
>         VMCOREINFO_OFFSET(printk_info, seq);
>         VMCOREINFO_OFFSET(printk_info, ts_nsec);
>         VMCOREINFO_OFFSET(printk_info, text_len);
> -       VMCOREINFO_OFFSET(printk_info, caller_id);
> +       VMCOREINFO_OFFSET(printk_info, caller_info);
>         VMCOREINFO_OFFSET(printk_info, dev_info);
>
>         VMCOREINFO_STRUCT_SIZE(dev_printk_info);
> @@ -1111,7 +1120,7 @@ static unsigned int __init add_to_rb(struct printk_=
ringbuffer *rb,
>         dest_r.info->level =3D r->info->level;
>         dest_r.info->flags =3D r->info->flags;
>         dest_r.info->ts_nsec =3D r->info->ts_nsec;
> -       dest_r.info->caller_id =3D r->info->caller_id;
> +       dest_r.info->caller_info =3D r->info->caller_info;
>         memcpy(&dest_r.info->dev_info, &r->info->dev_info, sizeof(dest_r.=
info->dev_info));
>
>         prb_final_commit(&e);
> @@ -1329,13 +1338,16 @@ static size_t print_time(u64 ts, char *buf)
>  }
>
>  #ifdef CONFIG_PRINTK_CALLER
> -static size_t print_caller(u32 id, char *buf)
> +static size_t print_caller_info(struct printk_caller_info *ci, char *buf=
)
>  {
> -       char caller[12];
> +       char pid[12];
> +       char cpu[12];
>
> -       snprintf(caller, sizeof(caller), "%c%u",
> -                id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
> -       return sprintf(buf, "[%6s]", caller);
> +       snprintf(pid, sizeof(pid), "T%u", ci->pid);
> +       snprintf(cpu, sizeof(cpu), "C%u", ci->cpu);
> +
> +       return sprintf(buf, "[%s][%6s][%6s]",
> +                      printk_caller_ctxt_txt[ci->ctxt], pid, cpu);
>  }
>  #else
>  #define print_caller(id, buf) 0
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_rin=
gbuffer.c
> index fde338606ce8..66be9b47be46 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -431,7 +431,8 @@ static enum desc_state get_desc_state(unsigned long i=
d,
>   */
>  static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
>                                  unsigned long id, struct prb_desc *desc_=
out,
> -                                u64 *seq_out, u32 *caller_id_out)
> +                                u64 *seq_out,
> +                                struct printk_caller_info *ci_out)
>  {
>         struct printk_info *info =3D to_info(desc_ring, id);
>         struct prb_desc *desc =3D to_desc(desc_ring, id);
> @@ -480,8 +481,8 @@ static enum desc_state desc_read(struct prb_desc_ring=
 *desc_ring,
>         }
>         if (seq_out)
>                 *seq_out =3D info->seq; /* also part of desc_read:C */
> -       if (caller_id_out)
> -               *caller_id_out =3D info->caller_id; /* also part of desc_=
read:C */
> +       if (caller_info_out)
> +               *ci_out =3D info->caller_info; /* also part of desc_read:=
C */
>
>         /*
>          * 1. Guarantee the descriptor content is loaded before re-checki=
ng
> @@ -1251,14 +1252,22 @@ static const char *get_data(struct prb_data_ring =
*data_ring,
>         return &db->data[0];
>  }
>
> +static bool same_caller(struct printk_caller_info *cur_ci,
> +                       struct printk_caller_info *last_ci)
> +{
> +       return (cur_ci->cpu =3D=3D last_ci->cpu &&
> +               cur_ci->pid =3D=3D last_ci->pid &&
> +               cur_ci->ctxt =3D=3D last_ci->ctxt)
>  /*
>   * Attempt to transition the newest descriptor from committed back to re=
served
>   * so that the record can be modified by a writer again. This is only po=
ssible
>   * if the descriptor is not yet finalized and the provided @caller_id ma=
tches.
>   */
>  static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring=
,
> -                                        u32 caller_id, unsigned long *id=
_out)
> +                                        struct printk_caller_info *ci,
> +                                        unsigned long *id_out)
>  {
> +       struct printk_caller_info last_ci;
>         unsigned long prev_state_val;
>         enum desc_state d_state;
>         struct prb_desc desc;
> @@ -1272,8 +1281,8 @@ static struct prb_desc *desc_reopen_last(struct prb=
_desc_ring *desc_ring,
>          * To reduce unnecessarily reopening, first check if the descript=
or
>          * state and caller ID are correct.
>          */
> -       d_state =3D desc_read(desc_ring, id, &desc, NULL, &cid);
> -       if (d_state !=3D desc_committed || cid !=3D caller_id)
> +       d_state =3D desc_read(desc_ring, id, &desc, NULL, &last_ci);
> +       if (d_state !=3D desc_committed || !same_caller(&last_ci, ci))
>                 return NULL;
>
>         d =3D to_desc(desc_ring, id);
> @@ -1348,7 +1357,7 @@ static struct prb_desc *desc_reopen_last(struct prb=
_desc_ring *desc_ring,
>   *            @r->info->text_len after concatenating.
>   */
>  bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_rin=
gbuffer *rb,
> -                        struct printk_record *r, u32 caller_id, unsigned=
 int max_size)
> +                        struct printk_record *r, struct printk_caller_in=
fo *ci, unsigned int max_size)
>  {
>         struct prb_desc_ring *desc_ring =3D &rb->desc_ring;
>         struct printk_info *info;
> @@ -1359,7 +1368,7 @@ bool prb_reserve_in_last(struct prb_reserved_entry =
*e, struct printk_ringbuffer
>         local_irq_save(e->irqflags);
>
>         /* Transition the newest descriptor back to the reserved state. *=
/
> -       d =3D desc_reopen_last(desc_ring, caller_id, &id);
> +       d =3D desc_reopen_last(desc_ring, ci, &id);
>         if (!d) {
>                 local_irq_restore(e->irqflags);
>                 goto fail_reopen;
> @@ -1377,11 +1386,11 @@ bool prb_reserve_in_last(struct prb_reserved_entr=
y *e, struct printk_ringbuffer
>         e->id =3D id;
>
>         /*
> -        * desc_reopen_last() checked the caller_id, but there was no
> +        * desc_reopen_last() checked the caller_info, but there was no
>          * exclusive access at that point. The descriptor may have
>          * changed since then.
>          */
> -       if (caller_id !=3D info->caller_id)
> +       if (!match(ci, &info->caller_info)
>                 goto fail;
>
>         if (BLK_DATALESS(&d->text_blk_lpos)) {
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_rin=
gbuffer.h
> index 18cd25e489b8..9934353965d4 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -6,6 +6,18 @@
>  #include <linux/atomic.h>
>  #include <linux/dev_printk.h>
>
> +#define PRINTK_CTXT_TASK       0
> +#define PRINTK_CTXT_HARDIRQ    1
> +#define PRINTK_CTXT_SOFTIRQ    2
> +#define PRINTK_CTXT_NMI                3
> +
> +
> +struct printk_caller_info {
> +       u32     ctxt:2;         /* context */
> +       u32     cpu:24;         /* CPU number */
> +       u32     pid;            /* PID of the process */
> +};
> +
>  /*
>   * Meta information about each stored message.
>   *
> @@ -19,8 +31,7 @@ struct printk_info {
>         u8      facility;       /* syslog facility */
>         u8      flags:5;        /* internal record flags */
>         u8      level:3;        /* syslog level */
> -       u32     caller_id;      /* thread id or processor id */
> -
> +       struct printk_caller_info caller_info;
>         struct dev_printk_info  dev_info;
>  };
>
