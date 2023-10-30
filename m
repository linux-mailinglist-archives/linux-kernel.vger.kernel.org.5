Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D797DBB63
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjJ3OHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjJ3OHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:07:03 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D2C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:07:01 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso3862982276.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674820; x=1699279620;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r2EU33FC3tvkju4g7ttecb3uzQbVR6EQt+LBLKNDv4=;
        b=uFGbB+fkQQb2MIGjl32c2QvKP3IhcL11UfgbUGS8ghoYy+rroyQzIRCbas3BMFIqNZ
         FA0zO3Wps5Jkee/skIVcYtQGAebCJXlfuHQff5NeOFkUCqSiEPkJb6EcGFgorwS88K6K
         ki2RmZ9UiHF4qU1xWC/NQ3GKt0kDgMJjZ0yCoEvbQWLxSNQaTkpoLXOQ1Y7IeQavuvLn
         9yDq3D1wInFBsUrifqCVGn9beNA6mVR+rmVBw6VHZTIyicAdvtIWSbisidfqDejdgOlE
         G267GMAV64l+pqAWz9qnJce4m4P8hXC7WCj8wIPjC3udSwxmY7brL4B5mzd4NvAaSlvn
         JMhw==
X-Gm-Message-State: AOJu0YwZ3J3kDd3yaYKSwDjznuE/rEurnlZTElNeOqfkf8D8e/Yyj9Sb
        y55DFNMvOheWHcPHAYZWC/0=
X-Google-Smtp-Source: AGHT+IHgEgePAFlmZngtoBKX85G6XO/ZhspoS57t/9aeuwp/6Ru63xorm6OMBzk9vWY+pTaiezNtgw==
X-Received: by 2002:a5b:b44:0:b0:da0:76eb:3d31 with SMTP id b4-20020a5b0b44000000b00da076eb3d31mr7980479ybr.15.1698674820036;
        Mon, 30 Oct 2023 07:07:00 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id v8-20020a2583c8000000b00d9caf6f7539sm3767107ybm.1.2023.10.30.07.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:06:59 -0700 (PDT)
Date:   Mon, 30 Oct 2023 09:06:54 -0500
From:   David Vernet <void@manifault.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, joshdon@google.com,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, youssefesmat@google.com,
        greg.marsden@oracle.com, willy@infradead.org,
        andrea.righi@canonical.com, andrealmeid@igalia.com,
        changwoo@igalia.com, gpiccoli@igalia.com, tj@kernel.org,
        colin.i.king@gmail.com, ast@kernel.org, himadrispandya@gmail.com,
        redha.gouicem@rwth-aachen.de, admin@ptr1337.dev,
        lucjan.lucjanov@gmail.com
Subject: Re: Sched Ext slack channel / office hours
Message-ID: <20231030140654.GA2355@maniforge>
References: <20231018205431.GA4176@maniforge>
 <alpine.DEB.2.22.394.2310290809110.3136@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2310290809110.3136@hadrien>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 08:09:45AM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 18 Oct 2023, David Vernet wrote:
> 
> > Hello everyone,
> >
> > The first RFC patch set [0] for sched_ext was sent to the upstream list
> > almost one year ago, with three more revisions of the series having been
> > sent upstream since. In that time, a number of individuals, companies,
> > and organizations have begun to use and experiment with sched_ext. We
> > want to make it easier to collaborate, so we’ve decided to set up a
> > weekly office hours call, and create a Slack channel [1] that folks can
> > join to ask questions, discuss features, etc.
> >
> > [0]: https://lore.kernel.org/lkml/20221130082313.3241517-1-tj@kernel.org/
> > [1]: https://join.slack.com/t/schedextworkspace/shared_invite/zt-24c4on3sk-sHlozdLfCZBODfwU6t6dbw
> >
> > The Slack channel can be joined via the link in [1]. For office hours,
> > we’ll start with 10:00 PDT / 17:00 UTC on Mondays (likely starting the
> > week of 10/30), but we can change the time if it’s inconvenient for too
> > many folks. The calls will likely take place through Slack, so you’ll
> > have to join the Slack channel if you want to participate in the office
> > hours calls. As a friendly reminder, you can access the sched_ext
> > repository at [2].
> >
> > [2]: https://github.com/sched-ext/sched_ext
> 
> In Europe, we just changed to winter time.  I don't know if it is the same
> in the US.  What time will the meeting be?

Hello Julia,

The meeting will start in ~3 hours from now at UTC 17:00. This can be
adjusted for future sessions if it turns out to be inconvenient for
folks.

For now, we'll be conducting the meeting over Zoom. I'll post details of
the meeting into Slack. Anyone who would like to join the meeting but is
not on Slack may ping me privately, and I'll send them the Zoom meeting
information.

Thanks,
David
