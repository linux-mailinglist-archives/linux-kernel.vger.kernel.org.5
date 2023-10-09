Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047897BD9AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346292AbjJIL01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346291AbjJILZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:25:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04ADD5A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:25:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40684f53d11so44151765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696850727; x=1697455527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBNpO06xDlLtemDkhIFD5UcIdTdCSdjnqaYsWe9vtps=;
        b=V9In6ZTJ4YaXCgX2Zyi8UxnM8E3JIURn5WfzsdbSSJ6XyDu6eC8iOWK9ZOAbCY4tKy
         /rJURhtdY4+HDrQDbCWEPA0d7at2CJJAhZdpnruWV6+P0Gt1WmuX0VaGzfSavVLJluA0
         jRza+3KMOcoQyCCUJGAVaOHaR57T+Rkhb56hu1YiOK9zTY/EXztElOYntuj7ZK5lCpvA
         vCt/jHOHJ+B01rLiG+tEuGPZmZJM3UdeY15LKloUKr2OCEBjitcXIr1xQwpSAaInJ2OF
         GcaVIDL/wOpdODnFQFfk4GsuzgoqN6X5noFbzqvDC48q/c2pEkxpRT/REiz0DH7/SwXe
         dPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850727; x=1697455527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBNpO06xDlLtemDkhIFD5UcIdTdCSdjnqaYsWe9vtps=;
        b=pqUBd6q1j61g9C8J8kA/PdoQZpELegKrm+Wj434CYmVup3K7rnM1tmBaUrdq+IjbX+
         9rTbJP6Eso44KhYP5BOjkLhLkkCdIMP/PS6CobolYWnTmggnjbJfKVc6AI4Ccw9aVf+w
         RGvScYh7C1Ell3Tdn8+dOttTaE9nybvFAR2dnF53+HkCtgdKYcGOBWh3fV5P9zodmhI8
         Z9n54i4W/b3MHJxJhz/R6D9sHPSanBXJU4xqwnC7tHtZVVTx1WiHRdBKcdAIOKMKeIO/
         nlbV3TweSyT0oIEPV9G/rUX20vU1S1D3fWRyPvaZnJfuVrs5WanDxt4vrYnCgI6/BehM
         46MQ==
X-Gm-Message-State: AOJu0YySLPSZ2Wk8gGkYC+Om5ZUzhiPaEbDhCdZ4tkqoqtGnLjI/G/uj
        EGnjYlXmUqovv/7MFFpd+vA=
X-Google-Smtp-Source: AGHT+IH5Tlq3h4iu5WAA4aadlRX//LfTIMeJ6T7QMkoc1zj0mv+gfP5DnMbdXC+FPY9L9o21xGRDCQ==
X-Received: by 2002:a05:600c:220b:b0:406:7029:c4f2 with SMTP id z11-20020a05600c220b00b004067029c4f2mr13012322wml.26.1696850726540;
        Mon, 09 Oct 2023 04:25:26 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id j31-20020a05600c1c1f00b004068e09a70bsm10946714wms.31.2023.10.09.04.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:25:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:25:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <ZSPjIwWxSdKAsKZD@gmail.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <20231006200129.GJ36277@noisy.programming.kicks-ass.net>
 <20231008163912.GA2338308@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008163912.GA2338308@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Fernandes <joel@joelfernandes.org> wrote:

> > > Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
> > 
> > Hurm.. does this really warrant a Fixes tag? Afaict nothing is currently
> > broken -- this is a pure optimization question, no?
> 
> IMHO it is a breakage as it breaks NOHZ -- a lot of times the ILB kicks 
> back the CPU stopping the tick out of idle (effectively breaking NOHZ). 
> The large number of IPIs also wrecks power and it happens only on 6.1 and 
> after. Having the fixes tag means it will also goto all stable kernels >= 
> 6.1. Hope that sounds reasonable and thank you for taking a look!

So it's basically a fix of a NOHZ performance regression, introduced by 
7fd7a9e0caba or so, correct?

As long as the fixes have a good hope of being backported with a low amount 
of overhead, a Fixes: tag for a ~2 years old performance regression is 
unusual but not unprecedented.

We just need to make sure we don't put too much of a burden on the 
shoulders of -stable maintainers ...

Thanks,

	Ingo
