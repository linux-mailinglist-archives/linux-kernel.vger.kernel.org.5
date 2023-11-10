Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B9C7E84A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjKJUrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjKJUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:47:18 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D26A57
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:17:05 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b99bfca064so1373012a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699607825; x=1700212625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNAKGQcfwtX1sEelGFUcCMMKPbFCHvv7FrRIow0M5oA=;
        b=kD6KlBtSOJVn76Un+S+8+g470XuA8EJZrddiREBhESrNY0fbt/Y1vffed70qYBc588
         h7ZLU8TTYLzI1PR/Kldxv93K7V7U3tBYCWroM/DbGWbLN3v1EkNt9Wm/Bd6IG7Cq1wHz
         nZn6pg1ha6XLBUOpohzb49L0Bh1dcuBH8mCzdahf00F9mffrOT0n9RLBtWNrRxlGfbZ8
         RISoGBcRIR/3S+2uOzYRbKcwx/1Li34xeCNi2r95xhyz7LjZgK/D5yhDSct7XcQbtqKv
         RoT9XDxdKbkitmXVrUwbuF4uWkRLRu5mbflxDvc5fjlRN1tnlfxWaChRXZ9u+KU5xowm
         HSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607825; x=1700212625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNAKGQcfwtX1sEelGFUcCMMKPbFCHvv7FrRIow0M5oA=;
        b=rYkyvIp3ibcaJe4R1u0o3kFU99kJa3Z7DP9fV3t0p0DNjVOepp2n6wfxUUkNtI4Vf/
         C8WbLZYRgaZRlhsPVZagt8XjOvFnp4v3912gMYAgxRTA4W6VBYH3RIN49I9nCV2ZaCL3
         gBWI919t1M8mJ2hovZZqvtX4j5z4IZrNN2LQ1/1JWUsHdn+sFLp9siZRHVC/1qrmxoM+
         /FOZSrZhmeplLJAATIPtcv7XP1MJtToPmWHwfAF161TD/r3J0abizcUUc7xbzgwLeJF4
         3IVszfOj0yZUBk3B8qVlB/+8G+F2RgC+54t5ywJNdaBwCUp0jeSiiEhdVQa6dcGD5oKi
         B5VA==
X-Gm-Message-State: AOJu0Ywd+tot5qyeWGnUkmP8xFdN1P3hqwo+lfO7dX9hzMC7+peQfrCX
        l752qu7hILzbzOKZiTfJkLUAIQ==
X-Google-Smtp-Source: AGHT+IEex3kLeiwKyEz2es872zjMNmrevn40/2l4PbaRjQ1owa57zfxwzE3YTcFU8WWcXat6tXWPLw==
X-Received: by 2002:a17:90b:4b82:b0:280:74fc:ac2c with SMTP id lr2-20020a17090b4b8200b0028074fcac2cmr4523903pjb.13.1699607825201;
        Fri, 10 Nov 2023 01:17:05 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a7f9100b0027ce254fed8sm5666457pjl.0.2023.11.10.01.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:17:04 -0800 (PST)
Date:   Fri, 10 Nov 2023 14:47:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 3/7] cpufreq/schedutil: Use a fixed reference frequency
Message-ID: <20231110091702.z3phucnffoe44kxy@vireshk-i7>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-4-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-23, 11:14, Vincent Guittot wrote:
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different than the one that has been
> used when computing the capacity of a CPU.
> 
> The new arch_scale_freq_ref() returns a fixed and coherent reference
> frequency that can be used when computing a frequency based on utilization.
> 
> Use this arch_scale_freq_ref() when available and fallback to
> policy otherwise.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
