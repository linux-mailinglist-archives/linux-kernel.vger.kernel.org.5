Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9762F7B8485
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjJDQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjJDQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:10:16 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D151A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:10:10 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae35773a04so6310b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696435809; x=1697040609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNYKpmrejstcC/CnIXfG563/nf9/VhnGAT8OJ/NcfkA=;
        b=1jtT8nloMf548j+gjjiQ1dvMB1eYbafg8NjYKBiW+m5sLPkf/On49RBp0FJCzv4K5Q
         LAOL0yk8KNXQ+s4wc/TFr/iNiUrXv/ZYyTZZErsNgWS6tm/SOfpZY2wYfPORsVESEm27
         iJmPA+FTuOmcB9TzQdsUjedOo1SuVTpPJHUOU6Z7zpTaYJftumWfYwVfdVo4zOg+ivVa
         e+SppcfAuBipK/gCsIOG/VqXTgpKL+iiG286dUlwEZ3tdPnUvIUIGWepCgeyVsPG3QbH
         d4LTVGxTjexSqr4giusZ0MTOnDs672YDHtJTt4PfX87TWm4BKs2qWo2nPYGUdl/pHomV
         nKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696435809; x=1697040609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNYKpmrejstcC/CnIXfG563/nf9/VhnGAT8OJ/NcfkA=;
        b=lFEUrzflxDGfKdsLD9hSsM0L0fZweDYEbnoGlbchXa0Zs9zu05TER6LA8l1PJXCu9/
         OByjB+2520DIgKWhEN6bGLj5PnPDzmU4s/h4T9cY2z1T6tNPz0mrPTtMOYD+uNYOzvuz
         OtqawqQ3rfb9U8oQ7qh1Bx9eXTlh579upVUfw5k03BF/luKx8Aa5fhoN8r9rkWWCNIq/
         N9EjQPad7064p9dXaA1sGpB4lgmAjDOhfGEDEIo1f4TFaqRWuwv2HO4gDSJSwIhHZp2o
         mg9zbD7jw/UF5KVLOwOVo0PhUR0AyTkjat5bQy5JIDhaR7PwClFX2D8/yAUarltqVDCO
         BD5A==
X-Gm-Message-State: AOJu0YxYFN/UkqEbv5ovR9pzfzjLCLWTaCiGtEDfj5DbFe2xGPkpWEuz
        y59y6/cv5WiTvMhSorpUbQmzxYxYE0YudpVhJuss5g==
X-Google-Smtp-Source: AGHT+IFmjhQr4tKG5BawhhJAcNC4YsiURTWQm2riMOHhACOtrROazRUFy+LVKCOhxu+n8gvZnfpVhNwuElqFZPsj09I=
X-Received: by 2002:a05:6358:91c:b0:134:c8cb:6a00 with SMTP id
 r28-20020a056358091c00b00134c8cb6a00mr3419638rwi.12.1696435809080; Wed, 04
 Oct 2023 09:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <CABCjUKBXPLNaBjELHqz=Oke_JsxXLQauTWrsNmTp3KToW3-9MQ@mail.gmail.com>
 <CABCjUKCRXeT2eExm6+y7cZCX4yEbj5MbjFnCHv4xvRPL5ce13g@mail.gmail.com>
In-Reply-To: <CABCjUKCRXeT2eExm6+y7cZCX4yEbj5MbjFnCHv4xvRPL5ce13g@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 4 Oct 2023 12:09:58 -0400
Message-ID: <CAJWu+opvq3dTk4dQmmR+7fs2KcrMELvt0iJcDeRQ9o9cnAVHWA@mail.gmail.com>
Subject: Re: NOHZ interaction between IPI-less kick_ilb() and nohz_csd_func().
To:     Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Frederic Weisbecker

On Wed, Sep 13, 2023 at 10:32=E2=80=AFAM Suleiman Souhlal <suleiman@google.=
com> wrote:
>
> (I forgot to also add Vincent...)
>
> On Wed, Sep 13, 2023 at 9:49=E2=80=AFPM Suleiman Souhlal <suleiman@google=
.com> wrote:
> >
> > Hello,
> >
> > I noticed that on x86 machines that have MWAIT, with NOHZ, when the
> > kernel decides to kick the idle load balance on another CPU in
> > kick_ilb(), there's an optimization that makes it avoid using an IPI
> > and instead exploit the fact that the remote CPU is MWAITing on the
> > thread_info flags, by just setting TIF_NEED_RESCHED, in
> > call_function_single_prep_ipi().
> > However, on the remote CPU, in nohz_csd_func(), we end up not raising
> > the sched softirq due to NEED_RESCHED being set, so the ILB doesn't
> > end up getting done.
> >
> > Is this intended?
> >
> > Thanks,
> > -- Suleiman
