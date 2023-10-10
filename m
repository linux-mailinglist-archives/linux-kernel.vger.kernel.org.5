Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A557C4407
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjJJW2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjJJW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:27:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0CAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7742da399a2so409717385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976861; x=1697581661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkLtTpyq6hhRKA1Cd8NmRte6SMNGKfwrDP5J91+SqxM=;
        b=sOLzgyavxmNPuIxJT66RHVRJKPM4L7Y9mosU4527HC4w8KJRNktEAYHaiOvOQgSk1W
         WgDXRkFGo2xLRGU3Eek+jCG4D0655oAzIpaEmUvKLlz9gC4+1srsdf640xGp/hMxnMJB
         VI6e4mzHz8VGpe7Gibg3n7Nox0eAy4azTsx1/hd74JY/Sh2gbeQnrqmWf0Ug4VMud0gp
         gEZoVEoqLrmoJQLPyNKJcNMdeMj4uAIYxWDoVlT9WrATIxVQb0axKhX8KXqvTlezx/0T
         CxZSH2FaCGcV1lUwERDBgx6SFAqdgeW6kzeRn+UnLXDocf6UZXePvumzIzchPf/o7XlC
         de5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976861; x=1697581661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkLtTpyq6hhRKA1Cd8NmRte6SMNGKfwrDP5J91+SqxM=;
        b=Lrvur1YoBYHh5rJZv9+xU2jezwYhXgjWPTafEKqjuYzeo+AcwAA5t2Axrm2H/N3AY1
         qYlDEaXLIQma1bQPED2mEnbLEQS4Bp/qsl/u745URYyHkAXj03UXwsW6cZmwTAnUkf6h
         XMjZzttTLfSJoI2N1N5K20uBTkKDGo1e+lX9cWJmEn93xYY3mlFzdHVjPvdjXl/2bBT/
         bjjMoiK2PgXzj8swKIOb1Qb9RUBG3Z+nU2s+M08L8D/ryeZlwcg9aF4RkWzAj73m1Gig
         wMW33d/s0IdrF/1ZY0WRESm4ffSNNDwecB6CczsbLUkQOFxCMg8ppPA/+VQQ/t0HSXZp
         RK8A==
X-Gm-Message-State: AOJu0YwWRpGq2gPPcTgxZTJk3FR7MPl1JAt1wk3cuGxYp9eNuaYx7kTe
        RU6nyxG3ioMrnYBZ1YlVW2VOU/wh6/OwToNAmZOQSg==
X-Google-Smtp-Source: AGHT+IFxlqxkA6VpJQ6lG3e6PyJG8lq0tpawjVN6OqIO8lL7DWTY3wjUGELV0v4sDHNRAaW6jqwWvjwYUgNF1SZ5uZw=
X-Received: by 2002:a0c:8cca:0:b0:656:3317:b926 with SMTP id
 q10-20020a0c8cca000000b006563317b926mr16022671qvb.17.1696976861005; Tue, 10
 Oct 2023 15:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com> <20231010151404.3f7faa87@hermes.local>
In-Reply-To: <20231010151404.3f7faa87@hermes.local>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Tue, 10 Oct 2023 15:27:05 -0700
Message-ID: <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
        dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com,
        morleyd@google.com, mfreemon@cloudflare.com, mubashirq@google.com,
        linux-doc@vger.kernel.org, weiwan@google.com,
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

On Tue, Oct 10, 2023 at 3:14=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 10 Oct 2023 12:23:30 -0700
> Haiyang Zhang <haiyangz@microsoft.com> wrote:
>
> > TCP pingpong threshold is 1 by default. But some applications, like SQL=
 DB
> > may prefer a higher pingpong threshold to activate delayed acks in quic=
k
> > ack mode for better performance.
> >
> > The pingpong threshold and related code were changed to 3 in the year
> > 2019 in:
> >   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> > And reverted to 1 in the year 2022 in:
> >   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> >
> > There is no single value that fits all applications.
> > Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> > optimal performance based on the application needs.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>
> If this an application specific optimization, it should be in a socket op=
tion
> rather than system wide via sysctl.
Initially I had a similar comment but later decided a sysctl could
still be useful if
1) the entire host (e.g. virtual machine) is dedicated to that application
2) that application is difficult to change
