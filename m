Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D97CCB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjJQTAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:00:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D63FF0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:00:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4509090a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697569238; x=1698174038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6zU+/G0fP23qafLVgXPYoabYVzueZ80T6KGT9Ff4Tw=;
        b=4EbBp11tu/sJtaJ6ulBe28ZGLwETZgRLzlSqe35gIwtfb/nZhTJZQ2Fux/AsxL6w0e
         IJDrIP1LEPWyuzt38E0Hfp4Mq9s8bqnYy+mk0biJbcdaFsz6q/o2v6lGtlAxvGC6JJdc
         YV11vxovIHmLHkPC6Rm4jHjKCDk08WMQDCRGFVrE5Gdny1/pVGrBUpz4uvx7nXMYu210
         yst1dYXgwvixGMoNJtOzIwldJ871ydVHOt04qJ0ldVwXv/jslpOzegOhKSIpK3Sjtwtx
         J8q7LYX+tk9drxeZPXPiGgALli30WAiXM1M2HtSFTGzAScXDknzq4lDb0hxwGIjH5tDJ
         cy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569238; x=1698174038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6zU+/G0fP23qafLVgXPYoabYVzueZ80T6KGT9Ff4Tw=;
        b=mu39yh9qL4GhJvH5AsYrcnv1YWImXyDzYo/MoZlwsYzQCmTE8JGfFHT2YxmtDBKf+x
         VhwoMkCmJqFQZXlYi5rxT96pz4DNiJbOrAuR4+g5I7zdnYXDcxZ6ILuQiQIlfyw+CNl8
         DgTH7ztJ94KSSEC9xB+xeTvpcXWAM2T2wi1kUh4fr7N1jrYxcc0/NHIDwk7SwqI1F8Im
         79gNzSqx7huMqyKnNukVXjvtZy3BCUrAJ4dw0wVMdCZa0XEYugfY+C36/YkNeCu2J+12
         hgR1VDYJRZgg7EK9k0BCF9D6JujfBadhKCEtoPStQtNWBbYKnFbeScxT5cJntoaPYFW5
         L5Dw==
X-Gm-Message-State: AOJu0YxXhCayHz97U6WI22omLRe0P4pl3ub8N5KrCrOkIOidVeaadnwh
        CdHjn0dMScQ9SxyRhnP9WJI/B4pxKmSQOPrT0Om76Q==
X-Google-Smtp-Source: AGHT+IHTU7+y+/i2QvucVreAoygXMXFywopTenm8dCQDYCSoQ7p+jxaaBVPeaouHTasn1t8vl1XlijJtsFCUu/fOafY=
X-Received: by 2002:a05:6a21:a108:b0:154:a1e4:b676 with SMTP id
 aq8-20020a056a21a10800b00154a1e4b676mr2923899pzc.4.1697569237902; Tue, 17 Oct
 2023 12:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230929174442.1635558-1-bgeffon@google.com> <CAJZ5v0g6160NYtRQun0D_qS-R6NfoXrX47muWt+sTN3wnNyHeA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g6160NYtRQun0D_qS-R6NfoXrX47muWt+sTN3wnNyHeA@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 17 Oct 2023 15:00:01 -0400
Message-ID: <CADyq12y3dy3G2mhwTq2NDozpCJ6MCe4jzH66M7PysPNmhZGLQw@mail.gmail.com>
Subject: Re: [PATCH] pid: Allow frozen userspace to reboot from non-init pid ns
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Thu, Oct 12, 2023 at 5:48=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Sep 29, 2023 at 7:45=E2=80=AFPM Brian Geffon <bgeffon@google.com>=
 wrote:
> >
> > When the system has a frozen userspace, for example, during hibernation
> > the child reaper task will also be frozen. Attmepting to deliver a
> > signal to it to handle the reboot(2) will ultimately lead to the system
> > hanging unless userspace is thawed.
> >
> > This change checks if the current task is the suspending task and if so
> > it will allow it to proceed with a reboot from the non-init pid ns.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > Reported-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
>
> If the report is public, which I think is the case, having a Link: tag
> pointing to it here would be nice.
>
> > ---
> >  kernel/pid_namespace.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> > index 0bf44afe04dd..4a93a5063eda 100644
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -321,6 +321,15 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, in=
t cmd)
> >         if (pid_ns =3D=3D &init_pid_ns)
> >                 return 0;
> >
> > +       if (current->flags & PF_SUSPEND_TASK) {
> > +               /*
> > +                * Attempting to signal the child_reaper won't work if =
it's
> > +                * frozen. In this case we shutdown the system as if we=
 were in
> > +                * the init_pid_ns.
> > +                */
>
> Is the system guaranteed to be in the right state for a shutdown at this =
point?
>
> There is a system-wide suspend-resume or hibernation in progress, so
> system_transition_mutex should be held and that should cause reboot()
> to block anyway.  Do you know why it doesn't block and why the suspend
> task has any reason to call it?
>

Sorry for the delay in responding to these questions, I'm going to do
another pass through this code and respond with a more detailed
explanation in the next few days.

> > +               return 0;
> > +       }
> > +
> >         switch (cmd) {
> >         case LINUX_REBOOT_CMD_RESTART2:
> >         case LINUX_REBOOT_CMD_RESTART:
> > --
> > 2.42.0.582.g8ccd20d70d-goog
> >
