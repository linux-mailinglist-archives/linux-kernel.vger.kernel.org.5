Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CAF7EACA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjKNJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjKNJIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:08:49 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017641980
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:08:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so7087a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699952921; x=1700557721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBqGDewyQb1wIg3vSqoaW/U1G0Rs3GT3EROexmJYFD4=;
        b=qFAYzuRO4Tri8pcZlpOaqz3ocjTp/5191Q0dwFaRpXSsaarU3QhWBrDoFtucUW7/RG
         gJiEamrtVJElKv8+tIOwNoSOnnUys21RiI+s2VEfqLM2y7UubeYuZy/GTTbtaE35+Gu/
         Apc/t8qgqJUZBFj2BbHDVip4llFeHFCnbLnWKgf51g5PC/3VUMOwPieR7f0QgobP2o0f
         p6gczxBaE1VLdWGQlB/XW6xRCCTsYf4mtO8ASlEVhGgQ52aws4jdD6HA8RVfksC7sznC
         s+lr1mGYbykyHaQnFkPIi+1jfmgnxZO7iVko4iWfkaDNQB1ELi66aajwoir2Trc4eH+F
         +YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952921; x=1700557721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBqGDewyQb1wIg3vSqoaW/U1G0Rs3GT3EROexmJYFD4=;
        b=hPclcLf2oxQFCGyIbuu4RgRDs9agfMk21n+8flr8gd9jhLSCCOtiicGQIxmR6mBd6G
         E/SfqWcllpNgqMwMaBFKqYvXG/kCAiXplvwpEZtJan5nJD/javJhEgNRfVUKcW7qV8pk
         o2XNWN3+ObrKmL5k2N6L/EhnjdNI8eteezGUP7Kxma1JVO4hejSiifMiPnJwjxYNX38A
         89VT9JBy3epSfIQKNbj3u5QLk2z8hvosfqeQWecSMMTBl5W2/UKWuFK/osW/+eCUUGoh
         yuGWqNHoVELDhOabVKf55r51ikVkXdWFyaNhMjTZ6Ysf2soJ80j/d7FASnkE2eFB0Be1
         IHFg==
X-Gm-Message-State: AOJu0Yy+AI6ZNDQiADZBVBlBbamzqo2NFbd2Ts9LT0IpxEQxpI5Exgwx
        pfh7QTwISDRmX+Zt2JV4OUTpLRbx9CFiCueD5k8VQg==
X-Google-Smtp-Source: AGHT+IEM89+rvpoYdVEvpOvoyQvbxLoJZXGfsA++k6fh+jX9l9VBf8QUHCETEiq8I3BkHbE+15Kb97BCpgmg9wRPams=
X-Received: by 2002:a05:6402:1cc8:b0:545:279:d075 with SMTP id
 ds8-20020a0564021cc800b005450279d075mr108521edb.1.1699952921166; Tue, 14 Nov
 2023 01:08:41 -0800 (PST)
MIME-Version: 1.0
References: <20231031093921.755204-1-guanyulin@google.com> <f75d6cd2-fa9f-4820-969f-2a8839d78c9e@rowland.harvard.edu>
 <CAOuDEK0NcijUKAL3fGtO=Ks+Y38TRhJcVx+ff-QUyUA0LcQ1Bw@mail.gmail.com> <3fe5414a-570f-4bfa-aa2f-909d7799551b@rowland.harvard.edu>
In-Reply-To: <3fe5414a-570f-4bfa-aa2f-909d7799551b@rowland.harvard.edu>
From:   Guan-Yu Lin <guanyulin@google.com>
Date:   Tue, 14 Nov 2023 17:08:29 +0800
Message-ID: <CAOuDEK1935=DmToUky8eXA5KxZFu+-phMjGB=Wv7Ox+k5fDvbQ@mail.gmail.com>
Subject: Re: [PATCH] rpm: pm: enable PM_RPM_EXCEPTION config flag
To:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     gregkh@linuxfoundation.org, len.brown@intel.com, pavel@ucw.cz,
        heikki.krogerus@linux.intel.com, mkl@pengutronix.de,
        hadess@hadess.net, mailhol.vincent@wanadoo.fr,
        ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, pumahsu@google.com,
        raychi@google.com, albertccwang@google.com,
        Alan Stern <stern@rowland.harvard.edu>
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

On Wed, Nov 8, 2023 at 11:56=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Nov 08, 2023 at 04:45:43PM +0800, Guan-Yu Lin wrote:
> > Thanks for the questions. Let me first introduce my motivation for
> > proposing this feature. We can discuss the implementation details later=
.
> >
> > Motivation:
> > Currently, system PM operations always override runtime PM operations.
> > As runtime PM reflects the power status of devices, there is a
> > possibility that runtime PM states that a device is in use, but system
> > PM decides to suspend it. Up to now, we have assumed that a device can'=
t
> > function without resources from the system, so the device should acquir=
e
> > a wakelock to prevent this from happening. However, what if the device
>
> [From the fact that you mention wakelocks, I assume that you're trying
> to implement something for Android systems rather than Linux systems
> in general.]
>

Apologies, I should use "wakeup source" here.

> > does not need the system's support to function? Or only needs limited
> > resources (e.g., only limited power source or clock) to function? In th=
is
> > situation, we would like to keep the device on but allow the system to
> > suspend. This is an example where we would like devices to follow runti=
me
> > PM rather than system PM.
>
> To put it more simply, you want a way to leave some devices in an active
> state while the rest of the system is suspended.  It's not clear why you
> have dragged runtime PM into the discussion (apart from the obvious fact
> that you won't want to keep a device active if it isn't active already).
>
> This sounds like a major change, not something to be done with a simple
> override.  You should discuss it with Rafael Wysocki and the linux-pm
> mailing list before trying to implement anything.
>
> > Feature Supported:
> > 1. Devices could control the priority of system PM and runtime PM durin=
g
> >    runtime.
>
> This seems like a totally unnecessary side issue.  Forget about runtime
> PM for the time being and concentrate instead on which devices you want
> to keep active.
>
> > 2. The control should be at the device level, meaning that different
> >    devices should control their own priorities.
> >
> > Goal of This Patch:
> > 1. Design a framework to support features above.
> > 2. Apply it into usb for demonstration.
>
> You may find that it is easier (and less work in the long run) to design
> the general framework and get it working than to concentrate on one
> particular subsystem.
>
> Alan Stern

Hi Rafael,
We'd like to implement a feature to allow system suspend with several
devices still active. Do you have any consideration on this?

Thanks,
Guan-Yu
