Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F676A66D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjHABgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHABgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:36:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78970114;
        Mon, 31 Jul 2023 18:36:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so5528197e87.3;
        Mon, 31 Jul 2023 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690853770; x=1691458570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTN64aQK1aLiDWyd71+xyKuSM4NGn6Hr4yVjOFLrX4Y=;
        b=BuEGdnqVDsbrkk14K1tG6Ztj9Mi2l4o012+wxn8qUuWF0/XG7f/mKSUanj8c8KVPPf
         6c5p6ZdK9XObNVdd0SjD0+yQJir6m0pDPmYWZBLefbuHr2UjoHWhVzZGPrETjphG4xOc
         3NPHCL24vfW4MvA2R/fv2Z3/htkPcP/8fPYgPpKpkbLqaA08n0kZ5OpTGzMw0zIrdE/E
         Yf6ZFuBvkTfRedDlshcL5co95VoGSev45ZEKi2Um0w7rMnxFRbaoSdZTYsZmtyYVS0gC
         t5iHTKAthad36u9khz/tzFXDvBov+NEi6rfAEEOzqMSfg1rQu7GcnLm4G+Eo53jcTRSX
         224w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690853770; x=1691458570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTN64aQK1aLiDWyd71+xyKuSM4NGn6Hr4yVjOFLrX4Y=;
        b=NPU1y/oAyQxcN/331Wni/S02qgx6pUf+9ziAzTf34tyZrNAuBUCq7qxXUZYrNfmOTn
         Z+XA+dYSFejPszspq0+wA3GkYzmjYF1y6skZfMLjbLAnxFMaFAqVVX1iWoZZYZw7FHTv
         HOJR49nnlpppra/okM7RY9BusiaqEFraQd5ouvhkWfwAeH4fTxzMhMnbfmM2gqwVg2of
         aFprrLb7zhduJP6nXRiK29ruFc9FyJ5kJ8wR5DmCfKZKXBfGA1xiRoyVWE1yw06Ehxfs
         p6YEW5whC1It43cwDfz3D59kZWsKBKbByWyersqvM7V6YE0IyEm2RwkQ0c8SYsS4BbNG
         HWCA==
X-Gm-Message-State: ABy/qLbkYzeKEuWg4754aUKpho4dtjPGpIzQqGZOm/ey+y9Onvn+a/kZ
        a/VW6oTUx06NIZv26gcbfmB5Rt206vqC0xsBN3E=
X-Google-Smtp-Source: APBJJlFUaediJqXSE+1MQonIwaYh18YkYgKOOVYB4/tx6z3KZnFQ6py22N11b0aG6Hykpk8xq9dxOWPVIwRhDkaS4EI=
X-Received: by 2002:ac2:4d97:0:b0:4f9:5404:af5 with SMTP id
 g23-20020ac24d97000000b004f954040af5mr991330lfe.46.1690853769397; Mon, 31 Jul
 2023 18:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121618.19198-1-zegao@tencent.com> <20230726121618.19198-2-zegao@tencent.com>
 <20230731113807.1a4a455c@gandalf.local.home>
In-Reply-To: <20230731113807.1a4a455c@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 1 Aug 2023 09:35:58 +0800
Message-ID: <CAD8CoPAym8fuL50vevxBxPy6-RU4kU49KV+Sz4OO0+Xh_doDCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] sched, tracing: add to report task state in
 symbolic chars
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

Thanks Steven,

Indeed this did not consider the struct alignment. I left the field order i=
ntact
because I was not sure whether the order here matters for reporting or pars=
ing.
Now I will fix this and send a v3, and again thanks for pointing it out.

Thanks,
Ze

On Mon, Jul 31, 2023 at 11:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 26 Jul 2023 20:16:16 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > @@ -231,41 +253,29 @@ TRACE_EVENT(sched_switch,
> >       TP_STRUCT__entry(
> >               __array(        char,   prev_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  prev_pid                        )
> > -             __field(        int,    prev_prio                       )
> > -             __field(        long,   prev_state                      )
> > +             __field(        short,  prev_prio                       )
> > +             __field(        int,    prev_state                      )
> > +             __field(        char,   prev_state_char                 )
> >               __array(        char,   next_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  next_pid                        )
> > -             __field(        int,    next_prio                       )
> > +             __field(        short,  next_prio                       )
> >       ),
>
> The above adds a bunch of holes. This needs to be reordered to condense t=
he
> event, we don't want to increase it. libtraceevent will handle reordering=
.
>
> The above produces:
>
> struct {
>         char    prev_comm[16];
>         pid_t   prev_pid;
>         short   prev_prio; <-- 2 character padding
>         int     prev_state;
>         char    prev_state_char;
>         char    next_comm[16]; <- 3 character padding
>         pid_t   next_pid;
>         short   next_prio; <- 2 char padding
> };
>
> (all events are at least 4 byte aligned, and are multiple of 4 bytes in
> size, thus that last short of next_prio did nothing)
>
> The above is a total of 56 bytes (note, that is the same as the current
> sched_switch event size);
>
> What the above should be:
>
>         TP_STRUCT__entry(
>                 __field(        pid_t,  prev_pid                        )
>                 __field(        pid_t,  next_pid                        )
>                 __field(        short,  prev_prio                       )
>                 __field(        short,  next_prio                       )
>                 __field(        int,    prev_state                      )
>                 __array(        char,   prev_comm,      TASK_COMM_LEN   )
>                 __array(        char,   next_comm,      TASK_COMM_LEN   )
>                 __field(        char,   prev_state_char                 )
>         ),
>
>
> Which would be:
>
> struct {
>         pid_t   prev_pid;
>         pid_t   next_pid;
>         short   prev_prio;
>         short   next_prio;
>         int     prev_state;
>         char    prev_comm[16];
>         char    next_comm[16];
>         char    prev_stat_char; <-- 3 characters of padding
> }
>
> which would be 52 byte. Saving us 4 bytes per event. Which is a big deal!
>
> -- Steve
>
