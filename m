Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B3C7DF4C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjKBOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBOSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:18:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F11B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:18:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso558659f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698934730; x=1699539530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0q/WyUH/RO3Ia1/awVvdyA1n//Vy7px8qroeNCo7qY=;
        b=GCtHnkUVi4Z07t3eYioJpFGjdHOzjU5Sqb1JB3zzCDcuSf/Wq7FyDNtefPADd/sOX/
         jKZWwxVugV0YNO02xDdkXmIl4yFX/ChA2tSSfNNOvOUVcpR3cMx2svPyuVjavr9iWKs6
         0w4Yqt1SmWi0cjFGxKXgSp68A0t0KFxOHt++xXuyAghOSJdX1/Wd0zDuSNwBUSmw/ddP
         JDSjoInGbHzCVfKamcQMtUnQDleVBBXuqgJXh1NFU3Xb5bDJhCRsTb90TPGsx3Z6+JZQ
         orXNmpl/Q/LJH7vfUviCpGrgq8exPihczPr1F2UmMJko2eCAKOZAWKIsd83bs8YOjjay
         w21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934730; x=1699539530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0q/WyUH/RO3Ia1/awVvdyA1n//Vy7px8qroeNCo7qY=;
        b=g05+PD0ZWpnxmR9eP+IN6+AEHdSv5w1cZ6V96QQcA8AKE3gyKJbSRTEGik0IJLULDm
         FchSgYuvrLyCoi9C87Fe8Plg1v1Dg5DjqLWkxJtNeZUj/fpFgboiXqheZtSw8neeiNs9
         k/VDs5skRfP1e4uJ+pJAAMcEWsURYz98NyGIK69tJAf7x/L/rYeon3RshZOc7+URZ5mo
         +vSP3b/a0oCCjieVP/Sq9ljOReoIUYBiMI8sdop/XrRkKt8ESTwSR8oYw/a0GLV80CQP
         1ph8CAAFv6tBYFXhPGLrAw9Xa/FYf/HUb1bc9xvxrrrZaRKJfC+qOxcV9BHtPMkFkqJ9
         xvlQ==
X-Gm-Message-State: AOJu0Yy0O8FXUXAXmS/rinrLMsWz3WAnJTEPhfIAP8/0NHvcBDZSpPyL
        JukwYT8obiIio2iEnY437lRIOLxolGIJW9nTreHlhQ==
X-Google-Smtp-Source: AGHT+IE9g66qOV7GOOy1S2wL5cvjWoCQ/TUy5CUYM1yzJ8ywolWjVlb2pKYwaZJ0OWNxgmJis7/EiQjKKSB0nZgf8jE=
X-Received: by 2002:a5d:5272:0:b0:32d:be44:f70c with SMTP id
 l18-20020a5d5272000000b0032dbe44f70cmr14423665wrc.7.1698934729892; Thu, 02
 Nov 2023 07:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231027145623.2258723-1-korneld@chromium.org>
 <20231027145623.2258723-2-korneld@chromium.org> <e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com>
 <CAD=Nsqzg2zRNFx7E800vnpNH6bZeHv9zdAnZksJjiRcXOQ4t=A@mail.gmail.com>
 <63e54bfd-9bb3-423b-a965-e0a9b399671c@intel.com> <ZUOtAePhW5O_40wV@google.com>
In-Reply-To: <ZUOtAePhW5O_40wV@google.com>
From:   Radoslaw Biernacki <biernacki@google.com>
Date:   Thu, 2 Nov 2023 15:18:33 +0100
Message-ID: <CAM4=RnLqQPkMNPqFPeVnzrogcWNe3j-=hBWkFHgGovd97Y_FUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: cqhci: Add a quirk to clear stale TC
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 3:07=E2=80=AFPM Kornel Dul=C4=99ba <korneld@chromium=
.org> wrote:
>
> On Thu, Nov 02, 2023 at 01:01:22PM +0200, Adrian Hunter wrote:
> > On 2/11/23 11:21, Kornel Dul=C4=99ba wrote:
> > > On Mon, Oct 30, 2023 at 8:31=E2=80=AFPM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> > >>
> > >> On 27/10/23 17:56, Kornel Dul=C4=99ba wrote:
> > >>> This fix addresses a stale task completion event issued right after=
 the
> > >>> CQE recovery. As it's a hardware issue the fix is done in form of a
> > >>> quirk.
> > >>>
> > >>> When error interrupt is received the driver runs recovery logic is =
run.
> > >>> It halts the controller, clears all pending tasks, and then re-enab=
les
> > >>> it. On some platforms a stale task completion event is observed,
> > >>> regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.
> > >>>
> > >>> This results in either:
> > >>> a) Spurious TC completion event for an empty slot.
> > >>> b) Corrupted data being passed up the stack, as a result of prematu=
re
> > >>>    completion for a newly added task.
> > >>>
> > >>> To fix that re-enable the controller, clear task completion bits,
> > >>> interrupt status register and halt it again.
> > >>> This is done at the end of the recovery process, right before inter=
rupts
> > >>> are re-enabled.
> > >>>
> > >>> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> > >>> ---
> > >>>  drivers/mmc/host/cqhci-core.c | 42 +++++++++++++++++++++++++++++++=
++++
> > >>>  drivers/mmc/host/cqhci.h      |  1 +
> > >>>  2 files changed, 43 insertions(+)
> > >>>
> > >>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci=
-core.c
> > >>> index b3d7d6d8d654..e534222df90c 100644
> > >>> --- a/drivers/mmc/host/cqhci-core.c
> > >>> +++ b/drivers/mmc/host/cqhci-core.c
> > >>> @@ -1062,6 +1062,45 @@ static void cqhci_recover_mrqs(struct cqhci_=
host *cq_host)
> > >>>  /* CQHCI could be expected to clear it's internal state pretty qui=
ckly */
> > >>>  #define CQHCI_CLEAR_TIMEOUT          20
> > >>>
> > >>> +/*
> > >>> + * During CQE recovery all pending tasks are cleared from the
> > >>> + * controller and its state is being reset.
> > >>> + * On some platforms the controller sets a task completion bit for
> > >>> + * a stale(previously cleared) task right after being re-enabled.
> > >>> + * This results in a spurious interrupt at best and corrupted data
> > >>> + * being passed up the stack at worst. The latter happens when
> > >>> + * the driver enqueues a new request on the problematic task slot
> > >>> + * before the "spurious" task completion interrupt is handled.
> > >>> + * To fix it:
> > >>> + * 1. Re-enable controller by clearing the halt flag.
> > >>> + * 2. Clear interrupt status and the task completion register.
> > >>> + * 3. Halt the controller again to be consistent with quirkless lo=
gic.
> > >>> + *
> > >>> + * This assumes that there are no pending requests on the queue.
> > >>> + */
> > >>> +static void cqhci_quirk_clear_stale_tc(struct cqhci_host *cq_host)
> > >>> +{
> > >>> +     u32 reg;
> > >>> +
> > >>> +     WARN_ON(cq_host->qcnt);
> > >>> +     cqhci_writel(cq_host, 0, CQHCI_CTL);
> > >>> +     if ((cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)) {
> > >>> +             pr_err("%s: cqhci: CQE failed to exit halt state\n",
> > >>> +                     mmc_hostname(cq_host->mmc));
> > >>> +     }
> > >>> +     reg =3D cqhci_readl(cq_host, CQHCI_TCN);
> > >>> +     cqhci_writel(cq_host, reg, CQHCI_TCN);
> > >>> +     reg =3D cqhci_readl(cq_host, CQHCI_IS);
> > >>> +     cqhci_writel(cq_host, reg, CQHCI_IS);
> > >>> +
> > >>> +     /*
> > >>> +      * Halt the controller again.
> > >>> +      * This is only needed so that we're consistent across quirk
> > >>> +      * and quirkless logic.
> > >>> +      */
> > >>> +     cqhci_halt(cq_host->mmc, CQHCI_FINISH_HALT_TIMEOUT);
> > >>> +}
> > >>
> > >> Thanks a lot for tracking this down!
> > >>
> > >> It could be that the "un-halt" starts a task, so it would be
> > >> better to force the "clear" to work if possible, which
> > >> should be the case if CQE is disabled.
> > >>
> > >> Would you mind trying the code below?  Note the increased
> > >> CQHCI_START_HALT_TIMEOUT helps avoid trying to clear tasks
> > >> when CQE has not halted.
> > >
> > > I've run a quick test and it works just fine.
> >
> > Thank you!
> >
> > > Your approach looks better than what I proposed, since as you
> > > mentioned, doing it like this avoids some weird side effects, e.g. DM=
A
> > > to freed memory.
> > > Do you plan to include it in the other series that you posted yesterd=
ay?
> >
> > Yes I will do that
>
> Feel free to add "Tested-by: Kornel Dul=C4=99ba <korneld@chromium.org>" a=
nd
> maybe "Reported-by".

I do not want to be you advocate Kornel, but I think you earned a
Co-developed-by
That was a lot of work.
