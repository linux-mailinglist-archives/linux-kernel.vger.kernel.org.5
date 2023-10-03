Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97F7B654A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbjJCJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjJCJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:18:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BAA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:18:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so1112734a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696324682; x=1696929482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZweY3Lsdh2ON/NBAsUVS47HS+cSQRRwsGeu87IY3ws=;
        b=WkAF4YW5pxPZ+kAhXsUO9HHLsLP3ujT040SyJ+wHowwImocACZxDiKf6qTXfrew3y6
         ZH7CBDpUdAzXBdvgZXa6rR7wpQ8ZZcIODK4UQYKQDlO69ftw6ojpxp22ndDbCOy292yq
         VLD97xOpOTRdVYFdiAShPv/WZdqxim2oFw/JN5l8hB8NY55yyMacOhwM0O3Reoh7whRB
         bsXt7knO1tMiqHJ6ovQ2UAx6dg+HdcBqMRWArzNx2ciZxSSTjrgsFw4iOMQGR6OWwTSw
         LIBJWXNheikLXdX2uVqyz1SbiAGmKlo4rSfvVddOIU/PNT+zX0kbQEYWVmpwX2a3U7Ui
         JxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324682; x=1696929482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZweY3Lsdh2ON/NBAsUVS47HS+cSQRRwsGeu87IY3ws=;
        b=dtBdZYppVuqIPTQ/zXoHlyGdg7h4jyG+746V/XA+XkBhYtUu4g/aDApo+1TiyZQkwe
         +s4uFjW1Q2XTV9ZbFfzSUujqZDsFaKb38aQiG4tu/PoXtW8IgzcPkNYlaAoikTMMnHry
         PxLelkgq+8+noU3FLYQJ6hIn7AhZCPoakgcxEyM5vVioTKVGUqZsqmsteS4eiO6YE9BL
         dPm+pwXkLnJ9CRwsiCboML/dEOx+wE4lo2d5XAOqKReinPpFuSBUSgSZKZE8Ehy6FN90
         jlQZWF5JfabsQj6bgMR+jK87l88VyQGnwtW9JJLpf/Xpl9rFcoeNn6hIWSYYpZbTQSON
         g+zA==
X-Gm-Message-State: AOJu0YzSmVT/47s2g0G2KErRlVyonr1BZWdm7jLOFIbt5PvPvn+Zwx6K
        Y/aVGqHoQxcT/dUMBkJoI38=
X-Google-Smtp-Source: AGHT+IGAXe7GNZ/L4nlbhqVlAWHaXMxizCMH5eIOPqdFVHQCXW7LUe57w4awEFuRUffj0nhKhg4yIQ==
X-Received: by 2002:a05:6402:1ac9:b0:525:469a:fc49 with SMTP id ba9-20020a0564021ac900b00525469afc49mr10954757edb.17.1696324681611;
        Tue, 03 Oct 2023 02:18:01 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id d5-20020a50fe85000000b0053443c8fd90sm535918edt.24.2023.10.03.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:18:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 11:17:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH v3] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Message-ID: <ZRvcRgv+HBY5+e9J@gmail.com>
References: <20230804023218.75544-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804023218.75544-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> perserved even if the task is being moved to a different cpuset. However,
> that affinity is also being inherited by any subsequently created child
> processes which may not want or be aware of that affinity.
> 
> One way to solve this problem is to provide a way to back off from
> that user provided CPU affinity.  This patch implements such a scheme
> by using an empty cpumask to signal a reset of the cpumasks to the
> default as allowed by the current cpuset.
> 
> Before this patch, passing in an empty cpumask to sched_setaffinity(2)
> will always return an -EINVAL error. With this patch, an alternative
> error of -ENODEV will be returned returned if sched_setaffinity(2)
> has been called before to set up user_cpus_ptr. In this case, the
> user_cpus_ptr that stores the user provided affinity will be cleared and
> the task's CPU affinity will be reset to that of the current cpuset. This
> alternative error code of -ENODEV signals that the no CPU is specified
> and, at the same time, a side effect of resetting cpu affinity to the
> cpuset default.

I agree that this problem needs a solution, but I don't really agree
with the -ENODEV ABI hack.

Why not just return success in that case? The 'reset' of the mask was
successful after all.

Thanks,

	Ingo
