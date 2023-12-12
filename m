Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C080ED43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjLLNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376313AbjLLMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:40:55 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAB21705
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:40:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c55872d80so1655065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702384839; x=1702989639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEInFwXfrwxR4sFrknUGYX+rR0E8l6zymNGh3bpC2tI=;
        b=kUKZmeuoA2BL0arcRItjJDzqMaTmlQv0lcci51NmGBFDYhZp9CsKFs4L2WRg4WgDWC
         H9+XaJ8bMHk6oK7F17hfqsz5babIrB0xj8MMuM9gKd1dSWm0Wa5pUEzhZqRd7oCM4/fl
         9Ya5QVlswtcK76qJhGkM00oCefYa4ayJYOVg1C8MTKD3gt2mAXIgEvcPpfcmFJBuMU7U
         5wQFRloWBE4JDjMlBKeJrriHhPi0bI/+kJ21Lsq0oFo9s/xNJI+QXvi+vLYm1YIojGdd
         ye6JIZlHrdSdPaxrmW+bQxt64exh6mDlSfE+N3YevLrIxLuhID08liQsI9YTGcXfrJDi
         0AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384839; x=1702989639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEInFwXfrwxR4sFrknUGYX+rR0E8l6zymNGh3bpC2tI=;
        b=mcVpgDYYPa3xvujBGnY6vkKqSbrLI3Y2wImd2AMNb/MosxmrUnM3CampQKUbsngm8a
         maL5UHSmF74urbpexwncx5ZrjL8C+tzE2SZVUEdjfPWK6alTjZLhLuvIt79VJUTz3mr7
         7znAKuAnMPUr5vY5CB/QLVm1Y39GUlDncM3K9oDx2Dechsiu9X9Y3kYgi+1sevV4ctGG
         s0l+xwnvKntSX+2SPQdE+hFeKj8WClRqyUpjjn98bsdoD/175Cs2sDK4r24s+O9maQGW
         72p2T1bufxQJev1Ez56oDijYpDuDQlL4hufygePQWMh9i/aPTyofINfX7wcJA+k0C25p
         1R2Q==
X-Gm-Message-State: AOJu0YyfU587R1wGXyhDkXM9bjljt3XX10SnqOl5tWhSzgULfyLOepf3
        P4EwujzJvXpT28g3hvABnZKSnQ==
X-Google-Smtp-Source: AGHT+IEcP9feutn+YHeiAGhIg/+iM2mTSQxn08hnetlycIsYkr1ZTqWNunBC21LxXDYDPIOUkYtwPw==
X-Received: by 2002:a05:600c:3784:b0:40b:5e4a:235a with SMTP id o4-20020a05600c378400b0040b5e4a235amr2753723wmr.92.1702384839171;
        Tue, 12 Dec 2023 04:40:39 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040c4620b9fasm7999178wmq.11.2023.12.12.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:40:38 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:40:37 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212124037.at47izy5xp6lsxh2@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <CAKfTPtAKainBfpPOKTJ21zQmmYw7O0Z0v8utfg=QTBtE1L5O_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAKainBfpPOKTJ21zQmmYw7O0Z0v8utfg=QTBtE1L5O_w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 12:06, Vincent Guittot wrote:

> > @@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  enqueue_throttle:
> >         assert_list_leaf_cfs_rq(rq);
> >
> 
> Here and in the other places below,  you lose :
> 
>  -       } else if (decayed) {
> 
> The decayed condition ensures a rate limit (~1ms) in the number of
> calls to cpufreq_update_util.
> 
> enqueue/dequeue/tick don't create any sudden change in the PELT
> signals that would require to update cpufreq of the change unlike
> attach/detach

Okay, thanks for the clue. Let me rethink this again.


Cheers

--
Qais Yousef
