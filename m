Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902107D1B69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJUGu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 02:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUGuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 02:50:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB913E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 23:50:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53d82bea507so2330358a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697871049; x=1698475849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11a/aKEUviI8GdRYhbzbJOfh3iA/VK6ux5c587n3a5g=;
        b=OOhLdhT6Sv0O+SumshEc+efYsZkAT2cqMocBmsEHOO3hoRa1XrG1T95NJW7pbOtieO
         pLV0v2c3aJbc/R+6BKYv7uQ693cul799GBJ46KuiL/eF613HELCVAkqLupTpim74JWPi
         jpsJ2feQVvjbcoPagAdTcStRdsXRt7imCt7/r47dL+iWq5lXN4ppYGimtv+AzWhyzAgC
         YfNPCpFIJdu1PycvWQESO6X/lToS037Frw42j59EX4FeN27k8v989rqFnfUzCLNcVvsT
         MPf5c8T3AwpSdnf8IaQEjwKcYrAAJp1OH6CZINNFyGR0RjAmb0jOgWQtEhx8D5jJ3VkU
         c54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697871049; x=1698475849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11a/aKEUviI8GdRYhbzbJOfh3iA/VK6ux5c587n3a5g=;
        b=Jt45nA1sq1s3bRW+U9d8QUQj10V6G3DRB6WYrZfGc0xwT5sgRQow6m/Qx/ylPV4IEc
         erIlcp5AQQVtmLKic67FYEaa1oiDu8i9Av7RlzN0Sdj2QVYRGmLOWT1G/XFuqwtG9H+K
         fpDpNSG5R0wsMlN9dxHiZxsQ1vcDC/6FxbGdckcVmzd6H0iW9rm4qzOF6w4AkMyxldRX
         kA+RaB6VsFYCRqlP6AQzCXk1x31vYGLRGEgRx6tCkl6w7Yh2fBnbcPrcCIMHYhyBoHjg
         18wJNqexKmlIqpq/nTYhBNLxFGpAcP8164ZV+3+NPzqvBFPTfidiaQHDeo5NzuJLpa37
         rbAA==
X-Gm-Message-State: AOJu0Yx6yXVYvWBWzE+z+oXVnN4w4R546auLod7H/cU47D55k9lffl30
        WEkwnBvvTiwMVMSCm4E4vao=
X-Google-Smtp-Source: AGHT+IGYF4OGq1Y1Bo9IKAPm5wnIFsmbfmZGhzS/keuSgmJ1UY72dLyi4c5QnNBHC7Z6wJGZPSmiig==
X-Received: by 2002:a50:cc0c:0:b0:53e:10a1:21d with SMTP id m12-20020a50cc0c000000b0053e10a1021dmr2431375edi.35.1697871049359;
        Fri, 20 Oct 2023 23:50:49 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id o2-20020a509b02000000b0053db0df6970sm2914958edi.54.2023.10.20.23.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 23:50:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 21 Oct 2023 08:50:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during
 newidle balance
Message-ID: <ZTN0xgGNefllUm7Q@gmail.com>
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org>
 <ZTIyD8EuhSmF4JFr@gmail.com>
 <CAKfTPtD4eWKDT2pPDUHwfGPGC1kNy1qWnY4rJg2yyCHk9mdfvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD4eWKDT2pPDUHwfGPGC1kNy1qWnY4rJg2yyCHk9mdfvQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> Hi Ingo,
> 
> On Fri, 20 Oct 2023 at 09:53, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> 
> ...
> 
> > >                       curr_cost += domain_cost;
> > >                       t0 = t1;
> >
> > Okay, I'm applying patches #2 and #3, without #1: it should be safe
> > out of order, but let me know if I missed something ...
> 
> Could you hold on for patch 3 ? As replied to Joel, the patch had
> regression in the update of rq->next_balance

Yeah, patch #3 is gone already from tip:sched/core.

Thanks,

	Ingo
