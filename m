Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077087EA3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjKMTtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:49:51 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2EAD46
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:49:46 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4ac211e5bbbso3787615e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699904986; x=1700509786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe9OybJJJuy/kJ6HuOFwiE8FBVrrMO46XlM/wh3Vpfk=;
        b=kazUnEGGyDH2iSakRXf4NU4xW7VFeePplZP6O2stfDycDqoHi7O8bEgD7lwpz1R0x7
         R+SLP5tC/ODzGMFw+OZpWpUQeJMvmRP+emDg1gTsEgBQSWN9CEbwllhpL/4udKSJPArU
         /MuCpF0mF8D59VWixaauGCIHaAVe/X99gqSj1kFrk3buDH0Dv4EdNfhqhHyrysl9rS9f
         1mFrOHkwW/f5+fp9fzcwzSHCyjOxYMMMrwpNOK4XjUxCkxZROfTfrMy1p5qmXoijrJh/
         IM/u0VG0VtZhVDqb81JqZjN7ZGGrCVuFvG0YTiLZY4pULwYzRXkOMVUNbTns0hdlG+65
         eo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699904986; x=1700509786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe9OybJJJuy/kJ6HuOFwiE8FBVrrMO46XlM/wh3Vpfk=;
        b=cVvpHYj4YE4UL3cpjEaWnEE4sr+IBwbS/DpgzBzdRQnRcbyRYejtpsFOAmABF9gy++
         cfJf75hWE/QdGjUoUymd58ECwtBIGRC4iHFWiMC23r40prMSK5ctPEet0TaILJNj3r9r
         /qouVOb9B+PZqFw+WrqsvFHvLp8m8oRd4eDyj4w4d32oLgT7vEo/eh6tu+BaKFiIOq3i
         3MS8ISpDHWnE5aTrrw6rgOKjCjsJYjhU/M19AMva0swQebEGMP1LjIkXe9ATxZ7PEjt/
         DOMchAqfwzpmGnqFCewe+hYOpjdkxBQI0hUAXG9N9Wkeu8OCFQmwV8iL3Qmlmb2ZX1Pw
         jMoA==
X-Gm-Message-State: AOJu0YyfSi6CcZZEJvxuyqxtanwcgrbx7gwki0nH7HeIEKfsP5J0psDG
        ep+IgdXvGbFHv8oQJmLZWpVDsDEi9p9c7xbdndav06HP
X-Google-Smtp-Source: AGHT+IH5spvIDl0ZGxDTBDLQFuEuCLDKaYaSLRRvTPgULA8YtCAkCCJfrGnJl5Kv7/T2XtF4D+/YwnW7wA5xBYunXJA=
X-Received: by 2002:a67:ec97:0:b0:45f:b0b8:1116 with SMTP id
 h23-20020a67ec97000000b0045fb0b81116mr360564vsp.16.1699904985970; Mon, 13 Nov
 2023 11:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-10-lb@semihalf.com>
 <CAJfuBxyvX41CCb27LWMDxZrQ5wwhuw36F_VmXyB3F9q7r1Kt2A@mail.gmail.com>
 <CAK8ByeKCcmd7-8Lsv5jQB-Po5UYeFRD-jB0e08BNBNUJ01UhNA@mail.gmail.com>
 <CAJfuBxxAnonb-+UrkVs=MiJ-g-5JDzzEn=GKs2gQvdqH8dGDVw@mail.gmail.com> <CAK8Bye+n=UBy60T56TJCat2n0LNfpfAeDG56QM41PWyUGzqRHg@mail.gmail.com>
In-Reply-To: <CAK8Bye+n=UBy60T56TJCat2n0LNfpfAeDG56QM41PWyUGzqRHg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 13 Nov 2023 12:49:19 -0700
Message-ID: <CAJfuBxzuEjp+PK75Upa7HoAJMs-Bx49knfjoEBTJXPsXkTDijw@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] dyndbg: add trace destination field to _ddebug
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 9:29=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> pt., 10 lis 2023 o 20:37 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Nov 10, 2023 at 7:52=E2=80=AFAM =C5=81ukasz Bartosik <lb@semiha=
lf.com> wrote:
> > >
> > > sob., 4 lis 2023 o 02:39 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > >
> > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@sem=
ihalf.com> wrote:
> > > > >
> > > > > Add trace destination field (trace_dst) to the _ddebug structure.
> > > > > The trace destination field is used to determine output of debug
> > > > > logs when +T is set. Setting trace_dst value to 0 (default) enabl=
es
> > > > > output to prdbg and devdbg trace events. Setting trace_dst value =
to
> > > > > a value in range of [1..255] enables output to trace instance.
> > > >
> > > >
> > > > should we do some expectation setting here ?
> > > > 255 is something of a promise to more than tom,dick,harry.
> > > > 16-64 is more suggestive of a limited resource,
> > > > might encourage more judicious use.
> > > >
> > >
> > > How about making it configurable in kernel Kconfig with default value
> > > set to 16 or 32 ?
> > >
> >
> > given the general dislike of extra knobs, it's not the battle I would c=
hoose.
> > ISTM we could start small, add bits later (if needed)
> > maybe 16 is too parsimonious; esp if DRM wants multiple instances per
> > driver (device?)
> >
>
> If we don't want the extra config knob then I would opt for 64.

I think I could live with that.
And I dont foresee other uses for spare bits atm.
