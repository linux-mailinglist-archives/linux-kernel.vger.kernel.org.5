Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C087AAE97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjIVJqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjIVJq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:46:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D308F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:46:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so7927005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695375980; x=1695980780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUA/mCVKETHVeKPilnMQwh1npNRNUxijAiM43LdtxFw=;
        b=lS2R3yhIpiCcFLiTLtsSyq1/EXIdxkJLLP+Mx1Xw8DJR7xt6gIOQip/oMEz/y/b0Mq
         fygc3IJn9wszJkf0+mMt+e6SeZGtLVZMBo3KU6+ui3koFLW5HWT3zPRBWegjdpAtworr
         HvcO0OiYLW6pXK8cT7RUycOlTqZKA2DEX5DPbof6DQIL0QZYzdaXo5XnK/dBT3cQWToO
         9yo8Im4woLP3x9tQ8niE33D3y/EgUdmYlMWEEwF4Z4Y2oY/Mh9N/sgIYSxhUwNRb1Fd4
         4W92io9yEHZLVAm04A4s89wceEM81c0Xj0P4zEBZ0lHJQaTapn0/mTbtxQ51VOtU/bmF
         /jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375980; x=1695980780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUA/mCVKETHVeKPilnMQwh1npNRNUxijAiM43LdtxFw=;
        b=gS94we8G0HMoBPAtIJ3jX2EbI2aKPUHq2OxuS5WFr79mgGPU4yOjEgaJFilGP/xVR1
         eQp4WgKXnLtM4Wa0Xk9H9t/pjwh94OQO+y+jirc8bXgY8uV4I1mKuHypoUe9nKjIKsQo
         rMSCFtHtNquzIx+HQ10BUgxJk6vckaCHv3LtmTABa+OpwfZfs2t0CpneEaLlOJmteWll
         bM66eJl6HwoGpxvKG4RHVcN7xAs8bRw0okzfMUcbK9q6TJVqnstfB9mNaYs0AiusS3ax
         F/jWYBfoY27R/uWRgVMI3F/i2VkAvej7rjlRAKK49tusmC0n2PtQTUam6FytkUePWOxT
         12wg==
X-Gm-Message-State: AOJu0YxoOFFrB1VZnHXf7okXrX5Zwk1YjJNtB4bDULbCDlJ1fUo0Go8X
        ciInpSFrwmkPutoiiYuzkOg=
X-Google-Smtp-Source: AGHT+IHC/lkFQ5wP8FgrtEHxdTFGpcGfLQxRq3yofp9mRyN/G33P5JRbEFkIhPDYYUj1v503ZbgOfA==
X-Received: by 2002:a1c:6a04:0:b0:405:1baf:cedd with SMTP id f4-20020a1c6a04000000b004051bafceddmr6772220wmc.1.1695375980270;
        Fri, 22 Sep 2023 02:46:20 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id o7-20020a1c7507000000b004051f8d6207sm4207822wmc.6.2023.09.22.02.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:46:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 11:46:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Petr Vorel <pvorel@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] sched/rt: Disallow writing invalid values to
 sched_rt_period_us
Message-ID: <ZQ1iabFEs93OZMSE@gmail.com>
References: <20230901154355.5351-1-chrubis@suse.cz>
 <20230901174529.GB364687@pevik>
 <ZPIqsmTbJh7z-LcO@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPIqsmTbJh7z-LcO@yuki>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Documentation/scheduller/sched-rt-group.rst [1] specifies this as values from -1 to
> > (INT_MAX - 1), I guess due int range. Looking into proc_dointvec_minmax() [2]
> > even INT_MAX would pass the check. I suppose we can do nothing about that,
> > because there is no value in sysctl_vals[] which would represent INT_MAX - 1.
> > 
> > And you specify in LTP test range: from -1 to INT_MAX.
> > 
> > But even much shorter value than INT_MAX fails:
> > 
> > $ echo 1234567 > /proc/sys/kernel/sched_rt_runtime_us
> > sh: echo: write error: Invalid argument
> 
> That is because runtime_us must be < period_us by definition, since
> runtime_us defines how much time is allocated from the period_us. I
> guess that this is not described good enough in the kernel docs.

Mind adding a second patch to your series, clarifying 
Documentation/scheduler/sched-rt-group.rst?

Thanks,

	Ingo
