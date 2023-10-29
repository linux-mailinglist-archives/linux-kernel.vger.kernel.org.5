Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2917DAB3F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjJ2HJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2HJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:09:55 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8BE97
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9lN2ObqSL6Cmzxyrg8cFMqmAxXNAfu2kZGPVULsb8jI=;
  b=udaodB4Mhgae7NxN/Irls/ppHzYt1+VxqvYjrGqrBo66d1cU4GgHsvJy
   raSAH0dF9uGMHumLiBbm65irJtDWsGsvSeSgDhQvrM2+VfakpB2xgl5Uz
   e2ZDW2ti9u9h7b31wcYExjch4M2Gdrxp+gSztXI69fk9tA3KnssuCr+L2
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,260,1694728800"; 
   d="scan'208";a="70037883"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 08:09:46 +0100
Date:   Sun, 29 Oct 2023 08:09:45 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     David Vernet <void@manifault.com>
cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, joshdon@google.com,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, youssefesmat@google.com,
        greg.marsden@oracle.com, willy@infradead.org,
        andrea.righi@canonical.com, andrealmeid@igalia.com,
        changwoo@igalia.com, gpiccoli@igalia.com, tj@kernel.org,
        colin.i.king@gmail.com, ast@kernel.org, julia.lawall@inria.fr,
        himadrispandya@gmail.com, redha.gouicem@rwth-aachen.de,
        admin@ptr1337.dev, lucjan.lucjanov@gmail.com
Subject: Re: Sched Ext slack channel / office hours
In-Reply-To: <20231018205431.GA4176@maniforge>
Message-ID: <alpine.DEB.2.22.394.2310290809110.3136@hadrien>
References: <20231018205431.GA4176@maniforge>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-451953215-1698563386=:3136"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-451953215-1698563386=:3136
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 18 Oct 2023, David Vernet wrote:

> Hello everyone,
>
> The first RFC patch set [0] for sched_ext was sent to the upstream list
> almost one year ago, with three more revisions of the series having been
> sent upstream since. In that time, a number of individuals, companies,
> and organizations have begun to use and experiment with sched_ext. We
> want to make it easier to collaborate, so we’ve decided to set up a
> weekly office hours call, and create a Slack channel [1] that folks can
> join to ask questions, discuss features, etc.
>
> [0]: https://lore.kernel.org/lkml/20221130082313.3241517-1-tj@kernel.org/
> [1]: https://join.slack.com/t/schedextworkspace/shared_invite/zt-24c4on3sk-sHlozdLfCZBODfwU6t6dbw
>
> The Slack channel can be joined via the link in [1]. For office hours,
> we’ll start with 10:00 PDT / 17:00 UTC on Mondays (likely starting the
> week of 10/30), but we can change the time if it’s inconvenient for too
> many folks. The calls will likely take place through Slack, so you’ll
> have to join the Slack channel if you want to participate in the office
> hours calls. As a friendly reminder, you can access the sched_ext
> repository at [2].
>
> [2]: https://github.com/sched-ext/sched_ext

In Europe, we just changed to winter time.  I don't know if it is the same
in the US.  What time will the meeting be?

thanks,
julia
--8323329-451953215-1698563386=:3136--
