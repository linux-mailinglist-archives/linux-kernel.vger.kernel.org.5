Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9844E756C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGQS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjGQS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:27:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55131A5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:27:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78362f57500so263016439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689618447; x=1692210447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQ9yfJu4ToUim/mdKZa5jp7hrHAt2Uj1W8EuAIttR2E=;
        b=A1i4Vng4GHAH0jyXIZYEM3EJwiQsnsUZt3Bhlb1edmQ7dEFDpfZL4PE1/MZlDGfZ32
         6huAhUfDZY6jq05rJl2qvvDqP8uJs4ganWG4QbSzR0qz8cOI0nhp2W1RTOM13jxOWuCv
         Ko6xBuOaCrWGOgouq01Tjic1h9cOo+qLV+uQ8OrTnWOtb8vFsb3P3OOlMP4ZlvPOI4pW
         vY9xLBVKw1rLq5Iho63lhtyfucJSh+n5/PH3swXAUCk6+j6bwRZNRmrgmdER+8LvLrr/
         q571DwsHYrQCjqcV+2AF0BXt8/70Y3Rl8DZ+Yy5gcoF5Kpo+4OCvGkdhj8FTLlwCR2mi
         mY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689618447; x=1692210447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ9yfJu4ToUim/mdKZa5jp7hrHAt2Uj1W8EuAIttR2E=;
        b=DlPOTO8c6tgRdM9WMEEfr55EC5g2/P5jwuiwCkoJ8d5e6TMQ4VYwDZ+gxpFRMwnxHm
         C5zpdC30lwETEz/FgIMqsTL1GOAmUbrTgjKY0DwWT1cYzAiKyzXvmWzUA4S/e916IDEQ
         NkT7DUcCZZ5bKoNXnncboBvWflqkUbwLR5I88vdDv/C1zDpSny4g61SegJSjyjvu+oRP
         8mD75wyCjrXg7t10FeA2wNzWJTvcb55svD5DFd5jZD+MJ3w2EZK/ZVMHotO7RFrrucbO
         7h0pKSL5mGSLNhy6Zofzd3aoHlbcqLDQtEUnI2x5k2BoJD5oi+WikjZRnzAyhsAX/P2Y
         dmQA==
X-Gm-Message-State: ABy/qLYY17H1mrSrSg+Tzvy1heFl//dRSYf2YxYJc6kbGuHJbIlfrouK
        phVeQuxcboJ601I9oUnnvYo=
X-Google-Smtp-Source: APBJJlHRzcm9jiOD2oLjX5RxdEnOBiE+58np5LiTMJfpWnGMr0trtYJINKArj/V5D9mgXZPhOuUfnQ==
X-Received: by 2002:a6b:da07:0:b0:787:6ae:46fa with SMTP id x7-20020a6bda07000000b0078706ae46famr557513iob.1.1689618446969;
        Mon, 17 Jul 2023 11:27:26 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id i5-20020a6b7e05000000b0078337cd3b3csm17762iom.54.2023.07.17.11.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:27:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 08:27:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
Message-ID: <ZLWIDC2nlG8cb3VE@slm.duckdns.org>
References: <xm268rbkg4tg.fsf@google.com>
 <20230714125746.812891-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714125746.812891-1-pauld@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 08:57:46AM -0400, Phil Auld wrote:
> In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
> groups due to the previous fix simply taking the min.  It should
> reflect a limit imposed at that level or by an ancestor. Even
> though cgroupv2 does not require child quota to be less than or
> equal to that of its ancestors the task group will still be
> constrained by such a quota so this should be shown here. Cgroupv1
> continues to set this correctly.
> 
> In both cases, add initialization when a new task group is created
> based on the current parent's value (or RUNTIME_INF in the case of
> root_task_group). Otherwise, the field is wrong until a quota is
> changed after creation and __cfs_schedulable() is called.
> 
> Fixes: c53593e5cb69 ("sched, cgroup: Don't reject lower cpu.max on ancestors")

Does this really fix anything observable? I wonder whether this is more
misleading than helpful. In cgroup2, the value simply wasn't being used,
right?

> Signed-off-by: Phil Auld <pauld@redhat.com>
> Reviewed-by: Ben Segall <bsegall@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

> +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> +		 * inherit when no limit is set. In both cases this is used
> +		 * by the scheduler to determine if a given CFS task has a
> +		 * bandwidth constraint at some higher level.

The discussion on this comment is stretching too long and this is fine too
but what's worth commenting for cgroup2 is that the limit value itself
doesn't mean anything and we're just latching onto the value used by cgroup1
to track whether there's any limit active or not.

Thanks.

-- 
tejun
