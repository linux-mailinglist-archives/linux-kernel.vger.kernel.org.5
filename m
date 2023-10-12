Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5234A7C7621
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441922AbjJLStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbjJLSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:48:58 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B77B83
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:48:56 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7afc13d58c6so579978241.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697136535; x=1697741335; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kykyVVmR/6y2L/pYKKXrvrrzSR32PllJLijuEY0UolQ=;
        b=B42XAtY2tnGLUS84FHyhn/CylCgJiz2vesnZoU7I55xwtyNuxW7CcKLX/Ra5ENv8H2
         gGEp/eMQocN9/eSeuc9wV5sPArzHgEFnlhvs/B4LbdB4RL1JOMsI8vdA2Z02dS1C4u/2
         mZfCmljFxs7940YUxwd/Q1AfPpHSg2BMBSIkw0JhR5A385Y81MzZtiJ+S8W0BZF7ZcAm
         cZDkMwl8wJRa6wuIkmHBqqBFi1JsNBDC0YQo3c2fXFq/WO/VfgE9IFO7uE+BEIYJkq2J
         PaV1PNQ2DwmT5tFO6dpSveF42ZeEvweMdh/DoaBkzt290DjyDIpyA41j1xL9zH6wkCI1
         FikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697136535; x=1697741335;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kykyVVmR/6y2L/pYKKXrvrrzSR32PllJLijuEY0UolQ=;
        b=u8AWuYnbNurpjPix8W9oLRxqnPb5jzfJ28WNJFLV5mN6qAZd3TFi/cGvPeJ6Lw1kLK
         we59wPU9yK45kpZHxumUjfOIiNJcPOJTlB3/obR2UCPVuXaniQYs3tjKhCdl5WpciPZK
         NgwLl2SBiLrqTJXh7OS//7PN9Nz6q9JXox/uv5nRh/cPHWDuh3rXuXBfLlWCveT64u9N
         p2FvL7PBWVSoZwx6z8iJKPAF+AcDmXD9clTS+4weoY3O17HUFmJCy8tvsiXlosWYsMCf
         yQFhFnF/z1XDIKad/3CmQ0dJuT6Q0YCtbIh72QeqS6oD5+Za90SUyIcefgtOqnf0KEGl
         WXrQ==
X-Gm-Message-State: AOJu0YwI987oV0lwthMou6npIiHfstjbORZQg0QxLhZYE7MFdMESF1de
        0EsWRu1y+6bSVf2LCLI++hqy4M18ibgIG0cQfEw=
X-Google-Smtp-Source: AGHT+IG9Zn74JvBPzF7lyfSR9CSn6UISiUudD/+HAMbb5FjvDC8XozITeM4NEPDnrsdY5z3lxLfx+/QINq8yj2Vgu54=
X-Received: by 2002:a67:ea18:0:b0:452:f119:20f with SMTP id
 g24-20020a67ea18000000b00452f119020fmr22722856vso.8.1697136535192; Thu, 12
 Oct 2023 11:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
 <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
 <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
 <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
 <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
 <20231011114816.19d79f43@eldfell> <ZSZuACLwt5_XAL2n@phenom.ffwll.local>
In-Reply-To: <ZSZuACLwt5_XAL2n@phenom.ffwll.local>
From:   jim.cromie@gmail.com
Date:   Thu, 12 Oct 2023 12:48:28 -0600
Message-ID: <CAJfuBxytOcUDmPBO7uQ9mMRvpNvzA3tgg_-pSGmdXpjDPe5sNQ@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     Pekka Paalanen <ppaalanen@gmail.com>, jim.cromie@gmail.com,
        =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "wayland-devel@lists.freedesktop.org" 
        <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you want the kernel to keep separate flight recorders I guess we could
> add that, but I don't think it currently exists for the dyndbg stuff at
> least. Maybe a flight recorder v2 feature, once the basics are in.
>

dyndbg has   +p    writes to syslog
+T  would separately independently write the same to global trace

This would allow  graceful switchover to tracefs,
without removing logging from dmesg, where most folks
(and any monitor tools) would expect it.

Lukas (iiuc) wants to steer each site to just 1 destination.
Or maybe (in addition to +p > syslog) one trace destination,
either global via events, or a separate tracebuf

Im ambivalent, but thinking the smooth rollover from syslog to trace
might be worth having to ease migration / weaning off syslog.

And we have a 4 byte hole in struct _ddebug we could just use.
Unless the align 8 is optional on 32-bits,
I think we're never gonna close the hole anywhere.

is align 8 a generic expression of an architectural simplifying constraint ?
or a need for 1-7 ptr offsets ?




> > That's my idea of it. It is interesting to see how far the requirements
> > can be reasonably realised.
>
> I think aside from the "make it available directly to unpriviledged
> userspace" everything sounds reasonable and doable.
>
> More on the process side of things, I think Jim is very much looking for
> acks and tested-by by people who are interested in better drm logging
> infra. That should help that things are moving in a direction that's
> actually useful, even when it's not yet entirely complete.
>

yes, please.  Now posted at

https://lore.kernel.org/lkml/20231012172137.3286566-1-jim.cromie@gmail.com/T/#t

Lukas, I managed to miss your email in the send phase.
please consider yourself a direct recipient :-)

thanks everyone

> Cheers, Sima
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
