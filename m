Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8740F7D3E58
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjJWRxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:53:37 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A394
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:53:34 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d2f3bb312so24021276d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698083613; x=1698688413;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERLSWz/ypvqXGSZyE17fjYBr7llZ/Hi7Sfb+XxapjGg=;
        b=IZaKK2LUx04q+tjSanJ3w7TIXwkZ5Xiawf4leNv7oi5prI0RPXsXAaB8HQG7/rIZ/M
         L4sPamdD6kQfv0MpjSyDBEYp2a1dJGytQ5rm38KWmV+om2+HFK7OoC4CY7q8QkJR40qe
         x1p3OlGaBuo7eHcxHk6auHOHfHeTG8zAdQHbA3tQKENq8onPRJ3zBCxmQFPTgF9RBW5T
         1KnSklWlMoXrxggE2IKX1542kjKPp+lTwNQ2lR2IAZV54lqu64MQzRpSXJwfxP/6uWJX
         QeGWjrByqe1cIpC0b+HCX5t0c8+3ZklEB7PE9LHz1zP0FUhMl8bXiH7LM24HJh0UZppK
         EQhA==
X-Gm-Message-State: AOJu0Yyth9BWq/bFRGbGtHVsbIiZHHi/oSSkaJXlnxeycK5ACqXz32ns
        N7L4tyiMfPBQgzv/7gOlY8A=
X-Google-Smtp-Source: AGHT+IE3O3VGuh3IXx5i4No3wjvPiK++fsw6GrmLl3v8ax7Y7BlQB0/U+TP+03qY+yHu1CaMhpFq6Q==
X-Received: by 2002:ad4:5b84:0:b0:66d:1c3a:4a5f with SMTP id 4-20020ad45b84000000b0066d1c3a4a5fmr13368741qvp.42.1698083613304;
        Mon, 23 Oct 2023 10:53:33 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cab12000000b0065afe284b3csm3068360qvb.125.2023.10.23.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:53:30 -0700 (PDT)
Date:   Mon, 23 Oct 2023 12:53:26 -0500
From:   David Vernet <void@manifault.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        youssefesmat@google.com, greg.marsden@oracle.com,
        willy@infradead.org, andrea.righi@canonical.com,
        andrealmeid@igalia.com, changwoo@igalia.com, gpiccoli@igalia.com,
        tj@kernel.org, colin.i.king@gmail.com, ast@kernel.org,
        julia.lawall@inria.fr, himadrispandya@gmail.com,
        redha.gouicem@rwth-aachen.de, admin@ptr1337.dev,
        lucjan.lucjanov@gmail.com
Subject: Re: Sched Ext slack channel / office hours
Message-ID: <20231023175326.GA4055@maniforge>
References: <20231018205431.GA4176@maniforge>
 <20231019093109.4c4406b2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019093109.4c4406b2@gandalf.local.home>
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

On Thu, Oct 19, 2023 at 09:31:09AM -0400, Steven Rostedt wrote:
> On Wed, 18 Oct 2023 15:54:31 -0500
> David Vernet <void@manifault.com> wrote:
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
> I just have to state that there's a significant amount of people on this
> list (myself included) that will not use slack (I don't have it installed
> on any of my machines, and will not install it). Perhaps an open source
> platform (matrix) or simply an IRC channel would work for us. Although that
> still would not guarantee that anyone would show up.
> 
> That said, I do host a Linux schedule monthly meeting on Google meets if
> you would like to join that.

Hi Steven,

Yes, it could be beneficial to attend your meeting as well. Please feel
free to send us an invitation to any instance of your meeting that is
related to sched_ext.

Thanks,
David
