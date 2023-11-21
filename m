Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF097F3462
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjKURAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjKURAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:00:14 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4B1D4B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:00:10 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59b5484fbe6so60685687b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700586009; x=1701190809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwIj+KbJ7PvCuBNGXgfvFvqUe/IcvSlmM6N9QvJC8BI=;
        b=DrBiEdv0Yimn4zkyUhBMPxnBBoAs+eZ5uVmACEjeb99WgLKlWalKQh2GwAISBL92sP
         p9kCI3CUCLI9aq0GCMVXScgCECuIeb6gGN/XnL9OD8GM9JOItmL9kU3UDSSQmRt+i695
         ARR8m6YRkpQNfSxgD05WnkWO+kJGrXQmQVEeeWkFIwcnrIN9T6ymKN7pvjvDbJK4yNGX
         LO4bDJ7kEjL/oDIcm73mt0cShUaTG/OV5vxU+PZvatCbQ68Fbn2i4KDR8skzskjlpELS
         cdBesW3S/rmZELJFiQYgo4P36sNl9vSrHlUZ8MssHT9PEZwfZ5KEoYtOAc0QY+qa8t15
         QE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586009; x=1701190809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwIj+KbJ7PvCuBNGXgfvFvqUe/IcvSlmM6N9QvJC8BI=;
        b=fw6f/U0KHGH/5t8Tl+vbf57DpKU84QTjJNvQDMYmtd6wvcr9xtRvDHzC8fwvKvbrp9
         qDHfg/ewRbatxek8W9QO6rFbjuzy3CxFMcKzlAohtp9ArypHJ8Qwi03Ok1SzACJQJetq
         oRxdGPO2d8LcgN6WbTLwGHZ9TDBLZNqPemnQxSWn+AiPwjQM0VVnSt0n+RwSo0A0A6+x
         2+fiqMVFEq1r+S04/xFX+ZKo5UyRQglQobF5QYgK/i7JWBoTYkA4inKIKM+1kWjswCQm
         0qZLglKmLPoJFBr4xz5eig0gGRwdU53uHJCQVj+MlD0kfE6YybwcUbj76QTdwbjlFQDg
         QX9Q==
X-Gm-Message-State: AOJu0Yyj/Yx9cQ9IS2CjkeWw3Mxc0bAT9r6/PJIY2aQACZ3sSbEr1VLr
        5x86hTYoMHtfXp5gMI0W2g4=
X-Google-Smtp-Source: AGHT+IFKHJ10XhorcfTO+RXaMwjjgAn1HCiRI6yoc10rnpZTOOHRaIBRoQaBzxf5zMv7/t/if+Vspw==
X-Received: by 2002:a81:c803:0:b0:5cb:4404:49c4 with SMTP id n3-20020a81c803000000b005cb440449c4mr4157340ywi.43.1700586009340;
        Tue, 21 Nov 2023 09:00:09 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id g4-20020a81d444000000b005cb0d7c2e46sm936191ywl.19.2023.11.21.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:00:08 -0800 (PST)
Date:   Tue, 21 Nov 2023 09:00:08 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 04/34] sched: add cpumask_find_and_set() and use it in
 __mm_cid_get()
Message-ID: <ZVziGOcUW0ljEZZr@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-5-yury.norov@gmail.com>
 <20231120113105.GR8262@noisy.programming.kicks-ass.net>
 <1eb9435a-aa1c-4c30-ab1a-9167b73d1b83@efficios.com>
 <ZVyxMrisyuBtQ+2Y@yury-ThinkPad>
 <985aff40-97cc-4234-98c5-84dd21c324b7@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985aff40-97cc-4234-98c5-84dd21c324b7@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:44:17AM -0500, Mathieu Desnoyers wrote:
> On 2023-11-21 08:31, Yury Norov wrote:
> > On Mon, Nov 20, 2023 at 11:17:32AM -0500, Mathieu Desnoyers wrote:
> > 
> [...]
> > 
> > Sure, I can. Can you point me to the work you mention here?
> 
> It would have to be updated now, but here is the last version that was posted:
> 
> https://lore.kernel.org/lkml/20221122203932.231377-1-mathieu.desnoyers@efficios.com/
> 
> Especially those patches:
> 
> 2022-11-22 20:39 ` [PATCH 22/30] lib: Implement find_{first,next,nth}_notandnot_bit, find_first_andnot_bit Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 23/30] cpumask: Implement cpumask_{first,next}_{not,}andnot Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 24/30] sched: NUMA-aware per-memory-map concurrency ID Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 25/30] rseq: Extend struct rseq with per-memory-map NUMA-aware Concurrency ID Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 26/30] selftests/rseq: x86: Implement rseq_load_u32_u32 Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 27/30] selftests/rseq: Implement mm_numa_cid accessors in headers Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 28/30] selftests/rseq: Implement numa node id vs mm_numa_cid invariant test Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 29/30] selftests/rseq: Implement mm_numa_cid tests Mathieu Desnoyers
> 2022-11-22 20:39 ` [PATCH 30/30] tracing/rseq: Add mm_numa_cid field to rseq_update Mathieu Desnoyers

OK, I'll take a look.

Thanks,
Yury
