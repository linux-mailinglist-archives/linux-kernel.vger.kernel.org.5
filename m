Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D1176A670
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjHABhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHABhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:37:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D56A114;
        Mon, 31 Jul 2023 18:37:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31771bb4869so5336310f8f.0;
        Mon, 31 Jul 2023 18:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690853828; x=1691458628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyXrFrMGa5vDv1JXbFyGkaG6866MRSC88OmLGwPocMw=;
        b=VKfZWhFq52c6OvI9vU4cseSRxVuvU0E8af3iFDOR71GbqAD922EXpiKXitjh2F31pu
         YRzb72EySjkdNdjBUVWbue8Ia5FCSY/Fw5LkdlqqKOO3wxJlrWhFio1zKVKc7lbDUbQO
         k4uwtClPU9qCjx3QvCKGWrMc2EEuCflgKKc7P0mqkESSHqK2UHCbtdNjW+R5bbS0qQ89
         3oPZKiIeAXfOQfjKYJN+/++HQOjJ4ohehQQVOT7bBO8vQ7MU6J/SBLvLzn/+DK8Ie5C6
         cFPwW9/k0av7o53A3e68vAaGmzY5Q8Wz9JGQTjAHgGay+vVoMY0+IQW87wZDpO5UeT4Q
         Da5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690853828; x=1691458628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyXrFrMGa5vDv1JXbFyGkaG6866MRSC88OmLGwPocMw=;
        b=WCnoI1nHGRtxGexylTV2LU94OonH3DbVB16nS7o1v4LCA8Gfd3NlRCjIhFETf9WhO8
         wiK0qclbWVmWXlnI9r8PIh3Q2fbz/BDw2SZpd9NVk1qmb7ZqoUln00CnqVLGdSDPpkUC
         4AUmUqjLR3Ov8Hfo3y+Ox98HoeUhK2FYNlDf7Vy4AyeM19IkF0TXBHwb1MowDy0IUXuu
         9cZAMSaScc/n+flM31Ea0iCRPzkGl8JNE75EyqhIZQ68JcgkTTEyqjqWFyp89jvlxOfs
         WH3ZeUbGBtfqryqyKfXTRxxeokmvvWUrkxcIAbetkNXSajTilqMPRaLDlM3KxA9Ml8Ec
         5Ckg==
X-Gm-Message-State: ABy/qLaLMAlXTlrRN23XAaYLAVOK71oFpTm+eb8rLhvWUh5AGCesC1YA
        orMkzmQ6cGzJ4950hhJthgo/oehvVtwfHYbXFbw=
X-Google-Smtp-Source: APBJJlEbsLzxcwW0UPQPfoX9lY/xBDed6oSWGp+RCvL9uW91SfU8JefEyAGw2SqpuW2C6c+T8VeyRvu+l12nKPf8pkk=
X-Received: by 2002:a5d:67c6:0:b0:317:6f5b:2fbe with SMTP id
 n6-20020a5d67c6000000b003176f5b2fbemr1047722wrw.69.1690853827446; Mon, 31 Jul
 2023 18:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121618.19198-1-zegao@tencent.com> <20230726121618.19198-4-zegao@tencent.com>
 <20230731114003.43842c8e@gandalf.local.home>
In-Reply-To: <20230731114003.43842c8e@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 1 Aug 2023 09:36:56 +0800
Message-ID: <CAD8CoPB1hRZb5eRWBxw3SRH+Hcd7JWfDNqGMadB4+5mibJ17qg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] libtraceevent: use the new prev_state_char
 instead in tracepoint sched_switch
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger that!

Thanks,
Ze

On Mon, Jul 31, 2023 at 11:40=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 26 Jul 2023 20:16:18 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Since the sched_switch tracepoint introduces a new variable to
> > report sched-out task state in symbolic char, we switch to use
> > that instead to spare from knowing internal implementations
> > in kernel.
>
> This needs to be changed to check if the "prev_state_char" field exists,
> and if not, then it must use the old method. Same for perf. The tools mus=
t
> work with older kernels.
>
> -- Steve
>
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  plugins/plugin_sched_switch.c | 29 ++++-------------------------
> >  1 file changed, 4 insertions(+), 25 deletions(-)
> >
> > diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switc=
h.c
> > index 8752cae..5dbdc28 100644
> > --- a/plugins/plugin_sched_switch.c
> > +++ b/plugins/plugin_sched_switch.c
> > @@ -9,27 +9,6 @@
> >  #include "event-parse.h"
> >  #include "trace-seq.h"
> >
> > -static void write_state(struct trace_seq *s, int val)
> > -{
> > -     const char states[] =3D "SDTtZXxW";
> > -     int found =3D 0;
> > -     int i;
> > -
> > -     for (i =3D 0; i < (sizeof(states) - 1); i++) {
> > -             if (!(val & (1 << i)))
> > -                     continue;
> > -
> > -             if (found)
> > -                     trace_seq_putc(s, '|');
> > -
> > -             found =3D 1;
> > -             trace_seq_putc(s, states[i]);
> > -     }
> > -
> > -     if (!found)
> > -             trace_seq_putc(s, 'R');
> > -}
> > -
> >  static void write_and_save_comm(struct tep_format_field *field,
> >                               struct tep_record *record,
> >                               struct trace_seq *s, int pid)
> > @@ -97,10 +76,10 @@ static int sched_switch_handler(struct trace_seq *s=
,
> >       trace_seq_printf(s, "%lld ", val);
> >
> >       if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) =3D=
=3D
> > 0)
> > -             trace_seq_printf(s, "[%d] ", (int) val);
> > +             trace_seq_printf(s, "[%d] ", (short) val);
> >
> > -     if (tep_get_field_val(s,  event, "prev_state", record, &val, 1)
> > =3D=3D 0)
> > -             write_state(s, val);
> > +     if (tep_get_field_val(s,  event, "prev_state_char", record,
> > &val, 1) =3D=3D 0)
> > +             trace_seq_putc(s, (char) val);
> >
> >       trace_seq_puts(s, " =3D=3D> ");
> >
> > @@ -115,7 +94,7 @@ static int sched_switch_handler(struct trace_seq *s,
> >       trace_seq_printf(s, "%lld", val);
> >
> >       if (tep_get_field_val(s, event, "next_prio", record, &val, 1) =3D=
=3D
> > 0)
> > -             trace_seq_printf(s, " [%d]", (int) val);
> > +             trace_seq_printf(s, " [%d]", (short) val);
> >
> >       return 0;
> >  }
>
