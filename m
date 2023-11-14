Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16797EB0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjKNNbr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 08:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKNNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:31:45 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA11B9;
        Tue, 14 Nov 2023 05:31:42 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58787a6583aso296215eaf.1;
        Tue, 14 Nov 2023 05:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699968701; x=1700573501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq3TFIR4bve78mwQTQtnI30TuVk/gpeezuxu6f7CCOQ=;
        b=qVCpo4gXtdv9+ecCIu9VR0oYNzbHB18bzG4F3+gDbBWipTv/5b0B64SPiY8JZIuoeK
         6NsZDGJgnHXb5dcVglSxN9/8ZqZ7ke5GFIaXmnLFhOgkQSAOcJOQgVWxOXRJZQzjR8qU
         oQx+X1FH78NajPMvjozQ0YlxXGRf487el6oepkQHa273N2MrZB8lUN7coJ/9ErWWulrP
         ahk/FbQx2R3+ZJzL6QcXHaAfgOxP1UExgNOz9U9PKYKx998Sm0vluTELSuHNBdXG+9fM
         hHiGv2h02rNE9j0GAfMnllK5bfWhzRg9yv5Ek6NX7QemcZr7a+KIlGuxUKLV90UURLuA
         Ueuw==
X-Gm-Message-State: AOJu0YzZCaUAAUW5qIpEAzAZaNQPgGns49qLs8qE6YCtS0cWSHpoDYHV
        Z8SS8YRoogglwdvHcyK2UQ6t6XRxNOy/HEgPSQc=
X-Google-Smtp-Source: AGHT+IH3bNA+igZ7XBPjf6UixfeM2kn1LQ7Fj4EIFd5iBf2RjIehC5eUluJSN8ozSaoZl4za8DrHWP+rsxPoaMpQ2B4=
X-Received: by 2002:a05:6820:d84:b0:58a:145:fef2 with SMTP id
 ek4-20020a0568200d8400b0058a0145fef2mr2378957oob.0.1699968701394; Tue, 14 Nov
 2023 05:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20231031093921.755204-1-guanyulin@google.com> <f75d6cd2-fa9f-4820-969f-2a8839d78c9e@rowland.harvard.edu>
 <CAOuDEK0NcijUKAL3fGtO=Ks+Y38TRhJcVx+ff-QUyUA0LcQ1Bw@mail.gmail.com>
 <3fe5414a-570f-4bfa-aa2f-909d7799551b@rowland.harvard.edu> <CAOuDEK1935=DmToUky8eXA5KxZFu+-phMjGB=Wv7Ox+k5fDvbQ@mail.gmail.com>
In-Reply-To: <CAOuDEK1935=DmToUky8eXA5KxZFu+-phMjGB=Wv7Ox+k5fDvbQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Nov 2023 14:31:30 +0100
Message-ID: <CAJZ5v0g_hg9pnnD1DXNPDM9v7kSoiEp-SKqAXcvEntXpxa5Nxw@mail.gmail.com>
Subject: Re: [PATCH] rpm: pm: enable PM_RPM_EXCEPTION config flag
To:     Guan-Yu Lin <guanyulin@google.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        gregkh@linuxfoundation.org, len.brown@intel.com, pavel@ucw.cz,
        heikki.krogerus@linux.intel.com, mkl@pengutronix.de,
        hadess@hadess.net, mailhol.vincent@wanadoo.fr,
        ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, pumahsu@google.com,
        raychi@google.com, albertccwang@google.com,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 10:08 AM Guan-Yu Lin <guanyulin@google.com> wrote:
>
> On Wed, Nov 8, 2023 at 11:56 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Nov 08, 2023 at 04:45:43PM +0800, Guan-Yu Lin wrote:
> > > Thanks for the questions. Let me first introduce my motivation for
> > > proposing this feature. We can discuss the implementation details later.
> > >
> > > Motivation:
> > > Currently, system PM operations always override runtime PM operations.
> > > As runtime PM reflects the power status of devices, there is a
> > > possibility that runtime PM states that a device is in use, but system
> > > PM decides to suspend it. Up to now, we have assumed that a device can't
> > > function without resources from the system, so the device should acquire
> > > a wakelock to prevent this from happening. However, what if the device
> >
> > [From the fact that you mention wakelocks, I assume that you're trying
> > to implement something for Android systems rather than Linux systems
> > in general.]
> >
>
> Apologies, I should use "wakeup source" here.
>
> > > does not need the system's support to function? Or only needs limited
> > > resources (e.g., only limited power source or clock) to function? In this
> > > situation, we would like to keep the device on but allow the system to
> > > suspend. This is an example where we would like devices to follow runtime
> > > PM rather than system PM.
> >
> > To put it more simply, you want a way to leave some devices in an active
> > state while the rest of the system is suspended.  It's not clear why you
> > have dragged runtime PM into the discussion (apart from the obvious fact
> > that you won't want to keep a device active if it isn't active already).
> >
> > This sounds like a major change, not something to be done with a simple
> > override.  You should discuss it with Rafael Wysocki and the linux-pm
> > mailing list before trying to implement anything.
> >
> > > Feature Supported:
> > > 1. Devices could control the priority of system PM and runtime PM during
> > >    runtime.
> >
> > This seems like a totally unnecessary side issue.  Forget about runtime
> > PM for the time being and concentrate instead on which devices you want
> > to keep active.
> >
> > > 2. The control should be at the device level, meaning that different
> > >    devices should control their own priorities.
> > >
> > > Goal of This Patch:
> > > 1. Design a framework to support features above.
> > > 2. Apply it into usb for demonstration.
> >
> > You may find that it is easier (and less work in the long run) to design
> > the general framework and get it working than to concentrate on one
> > particular subsystem.
> >
> > Alan Stern
>
> Hi Rafael,
> We'd like to implement a feature to allow system suspend with several
> devices still active. Do you have any consideration on this?

I will have more time to think about this when I'm back from the
conference I'm participating in now.

In the meantime, I would recommend you to address Alan's comments.
