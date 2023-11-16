Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939807EDE06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbjKPJyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKPJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:54:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF34C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:54:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so9943a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700128453; x=1700733253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLQdK0PLkPgbZpmnpIM+hlNxS7X74nHsOVnDPoi/MMI=;
        b=gqakr0mJyyix209cnpqdAKE8rlVzuMRWwon8dFQIz4K5Dgl2AAnNlgEyqx9dBDylkw
         J6+bOyFRXm9maQEhmEQBBqeUHZXPK/Ghs86XWFh3HjtI2gD17xgSvfZm2eaBeB9+PGBm
         XebzVvN7hx03bLVl7RDFIkU9x2heqQmD21lRmy4XPcgs++6ikkQY1osuyBkapwJZ3Kbh
         KAAB59qdnI2rUzEVM5IzWu4mLN+0mZ24PWO7MFmfsHlrFQSg8RWVxDK9xntTimCC54/q
         pVhlxU21ahyLXxM8B5Y2gYR63uoU34M+p13K+dIgLZXmEuSI1UiUxCK/veTT11nWxI29
         JNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128453; x=1700733253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLQdK0PLkPgbZpmnpIM+hlNxS7X74nHsOVnDPoi/MMI=;
        b=iHWbYGSIe1JztdgOPeXCe22YHmEjaqznDQRdOjzu8lsslmidwLcjTBkWBlFJGCEj20
         EUCr9UnhSFJb2vPPFbLAoakcx350WZ8ZCmRAcR8EjbxQYlh2E0leyj/JbGeuW0HqBgGf
         MqaKaTyUf+1FqM6bh7M6feRti+WwWyOqrRanGG2cNOFeROh5uW/TYC/DX6BzIrjSp0+4
         eQfHsLYTOBhmlUuwAnquqfu/GPkIkNzTINWhalldzcE32mJN85YjFEhvCBFN9KJMDOLQ
         YLAHq220PnrQ2VVRPj1jh/ZVSVIUv0BiwIjANF6CBqrQ6SvZOsjoVPz4FKRJysiySrmj
         7MGQ==
X-Gm-Message-State: AOJu0Yz3fdnFyru0rPG02bw6kERLL0TdQUg3C7nK/YjQ58Pa7J9lky5H
        rHeDHn4cJLkEp1LhSnFdEMvAdbq6Mzo1FmZ2CkXwNXjVqadd3MdxXHUx9Q==
X-Google-Smtp-Source: AGHT+IEDR1q7Da+YvzRz4+svEYmFMPz1ROgkRbBFp+eFx4Jjr4wnvOnJi+lx8lSCvPW9fwl+a4axtp4udoCrAfJpjWM=
X-Received: by 2002:aa7:c78c:0:b0:545:94d:7b with SMTP id n12-20020aa7c78c000000b00545094d007bmr91808eds.4.1700128452617;
 Thu, 16 Nov 2023 01:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20231031093921.755204-1-guanyulin@google.com> <f75d6cd2-fa9f-4820-969f-2a8839d78c9e@rowland.harvard.edu>
 <CAOuDEK0NcijUKAL3fGtO=Ks+Y38TRhJcVx+ff-QUyUA0LcQ1Bw@mail.gmail.com>
 <3fe5414a-570f-4bfa-aa2f-909d7799551b@rowland.harvard.edu>
 <CAOuDEK3UuVGgP63NG9HtuJ0D2ERZsFGBwF5+GNynk=P7zSVUhg@mail.gmail.com> <CAJZ5v0j-JdoGADG6rYNOEY1ePtDz0vsV4T1wX2TO1t+5kPyJ8Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-JdoGADG6rYNOEY1ePtDz0vsV4T1wX2TO1t+5kPyJ8Q@mail.gmail.com>
From:   Guan-Yu Lin <guanyulin@google.com>
Date:   Thu, 16 Nov 2023 17:54:01 +0800
Message-ID: <CAOuDEK1hiVyFuZ__YFnOhfWV_JqMw83wCtPnX2a1xj6pb4Q5QA@mail.gmail.com>
Subject: Re: [PATCH] rpm: pm: enable PM_RPM_EXCEPTION config flag
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org,
        len.brown@intel.com, pavel@ucw.cz, heikki.krogerus@linux.intel.com,
        mkl@pengutronix.de, hadess@hadess.net, mailhol.vincent@wanadoo.fr,
        ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pumahsu@google.com, raychi@google.com, albertccwang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Nov 15, 2023 at 8:08=E2=80=AFAM Guan-Yu Lin <guanyulin@google.com=
> wrote:
> >
> > On Wed, Nov 8, 2023 at 11:56=E2=80=AFPM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Wed, Nov 08, 2023 at 04:45:43PM +0800, Guan-Yu Lin wrote:
> > > > Thanks for the questions. Let me first introduce my motivation for
> > > > proposing this feature. We can discuss the implementation details l=
ater.
> > > >
> > > > Motivation:
> > > > Currently, system PM operations always override runtime PM operatio=
ns.
> > > > As runtime PM reflects the power status of devices, there is a
> > > > possibility that runtime PM states that a device is in use, but sys=
tem
> > > > PM decides to suspend it. Up to now, we have assumed that a device =
can't
> > > > function without resources from the system, so the device should ac=
quire
> > > > a wakelock to prevent this from happening. However, what if the dev=
ice
> > >
> > > [From the fact that you mention wakelocks, I assume that you're tryin=
g
> > > to implement something for Android systems rather than Linux systems
> > > in general.]
> > >
> > > > does not need the system's support to function? Or only needs limit=
ed
> > > > resources (e.g., only limited power source or clock) to function? I=
n this
> > > > situation, we would like to keep the device on but allow the system=
 to
> > > > suspend. This is an example where we would like devices to follow r=
untime
> > > > PM rather than system PM.
> > >
> > > To put it more simply, you want a way to leave some devices in an act=
ive
> > > state while the rest of the system is suspended.  It's not clear why =
you
> > > have dragged runtime PM into the discussion (apart from the obvious f=
act
> > > that you won't want to keep a device active if it isn't active alread=
y).
> > >
> >
> > The determination of which device should remain active when the system
> > suspends can be based on various factors. One straightforward approach
> > is to consider the device's runtime pm state.
>
> Not really.  The runtime PM status has no bearing on whether or not
> the device should remain active over a system suspend/resume cycle.
>

Thanks for the information.

> > Alternatively, we could
> > explore more elaborate techniques that consider additional criteria.
>
> In fact, the device's driver decides what is going to happen to it
> during the system suspend transition.  It very well may decide to
> leave the device in the operational state, but it needs to take
> dependencies between into account.

Seems like it would be better for each device to modify its suspend/
resume code rather than designing a generic framework. As the specific
use cases of each component are not yet fully understood, the device
driver provides ample flexibility for customization at this stage.

>
> > > This sounds like a major change, not something to be done with a simp=
le
> > > override.  You should discuss it with Rafael Wysocki and the linux-pm
> > > mailing list before trying to implement anything.
> > >
> > > > Feature Supported:
> > > > 1. Devices could control the priority of system PM and runtime PM d=
uring
> > > >    runtime.
> > >
> > > This seems like a totally unnecessary side issue.  Forget about runti=
me
> > > PM for the time being and concentrate instead on which devices you wa=
nt
> > > to keep active.
> > >
> > > > 2. The control should be at the device level, meaning that differen=
t
> > > >    devices should control their own priorities.
> > > >
> > > > Goal of This Patch:
> > > > 1. Design a framework to support features above.
> > > > 2. Apply it into usb for demonstration.
> > >
> > > You may find that it is easier (and less work in the long run) to des=
ign
> > > the general framework and get it working than to concentrate on one
> > > particular subsystem.
> > >
> > > Alan Stern
> >
> > The big picture is "a way to leave some devices in an active state
> > while the rest of the system is suspended", I think it could be
> > separated into:
> > (1) Each system should be able to choose which device(s) is included
> >     in this feature.
> > (2) For devices chosen in (1), each of them should have the flexibility
> >     to determine when it will not suspend with the system, not just
> >     always being active when the system suspends.
>
> A specific use case, please.

We have a sub-system sharing some devices (e.g., usb controller, host
controller) with the main system. In the current system power
management framework, when the main system suspends, the devices will
suspend, too. However, sometimes these devices are still used by the
sub-system, so we don't want the main system to always suspend the
devices.

Regards,
Guan-Yu
