Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087847D10C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377468AbjJTNsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377372AbjJTNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:48:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3F193
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:48:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9b1e3a809so6115755ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697809713; x=1698414513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a5mDz0w1FkPWB+d9zJA1eDcjQhxGyuEHR2BmV0zbEO8=;
        b=XRhUeeYTTzfr96KjjAIRsuIhwQP/bzwMjGGbFlSqPLc4vVlyccoTXd1K7EOTbPI5Aq
         nPhW+Oipg5/qmE47a0t+nxT/iAXjn3tFyRgz+d1nL61knJv1WZ3tZH8cUbLRgDBCBpZX
         wGDCV15NkhYexFnMBYxEfNEmk4b26acCscG9UEI32NYVXpPBfYSfzOaZ6BOV6Qi34etq
         9FlOGNoMZLFzrwrOAKPrEItjeUbunfnLHd3SW8rfA9j7kLa1hu+avOwGUvQxCi3diADB
         eryIs02mfr7Yk4oaqDszwxcZvCEfytTshXeCtoPeaWYzgEa/dZN/2C3ZBbilN4GkM1wU
         H0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809713; x=1698414513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5mDz0w1FkPWB+d9zJA1eDcjQhxGyuEHR2BmV0zbEO8=;
        b=uTXSN37ryfi/T4iQetoEs7BRWa9EgdpF1EziHGxmwFDcHJ9J68BlYtLGh1IOb2sMn3
         G/ZuN97EURtZePLy8C9gMSp853mDKLrF3OEVlr/pkiqhECqnugIwQLKLaixDXSTRZN8r
         Bp4AnIqLv0W2444iSNqMdPPZiR/4oXsHyZJBZHe0RHXtPGJvJo9jeBsT+N1aqm2JNGzc
         7ubphnq7kSE9IDSMZOxehISa5Lgrmt4ssN9vih9srYPuq/rqTJNXHU3SKtEalleozu3N
         NMw0GRD33kk9z6k6Y47D7O/iYvwCTaFFDW4zIO1K/eISC/NhrZ0xGEGvtaX7QWA4AZtZ
         vspA==
X-Gm-Message-State: AOJu0Yz/rBwkaX6Mj0+gOx8SpZkkNFi+EfTomLU91+O++7YMmszCPE2Z
        /Twj7vW5WifEtdXqOi9obiNzVBn+NiitI3hZY2tRRQ==
X-Google-Smtp-Source: AGHT+IF94maXpOmx/Ai+mFFW1as4nozNIV0mFrfVUOT7VidUVaags9AVe5jd4kXPCo+2TVIyi1/llgb4L0N7sGNyVXY=
X-Received: by 2002:a17:90b:1c08:b0:27d:3a2a:1e2c with SMTP id
 oc8-20020a17090b1c0800b0027d3a2a1e2cmr2039521pjb.15.1697809713636; Fri, 20
 Oct 2023 06:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org> <ZTIyD8EuhSmF4JFr@gmail.com>
In-Reply-To: <ZTIyD8EuhSmF4JFr@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Oct 2023 15:48:21 +0200
Message-ID: <CAKfTPtD4eWKDT2pPDUHwfGPGC1kNy1qWnY4rJg2yyCHk9mdfvQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during newidle balance
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Fri, 20 Oct 2023 at 09:53, Ingo Molnar <mingo@kernel.org> wrote:
>
>

...

> >                       curr_cost += domain_cost;
> >                       t0 = t1;
>
> Okay, I'm applying patches #2 and #3, without #1: it should be safe
> out of order, but let me know if I missed something ...

Could you hold on for patch 3 ? As replied to Joel, the patch had
regression in the update of rq->next_balance

>
> Thanks,
>
>         Ingo
