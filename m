Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BB7C42DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJJVpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjJJVpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:45:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E16D5F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:45:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so10460684a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696974303; x=1697579103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAWJva6tWSY0k+gPfLrvQkq9uvUdgcqwh9Gj/RrjVLc=;
        b=Ix8sa4aZoYAgeQ58A5JliWYPCUuwg+5wRODnVjzo+WyALK3MEqjlsDpMvT5JcLuVVd
         wIdSTcb6VLOOlvjB+7WPm6KLeXwBVGulabdT9OCmNJAJc2Wx3udoMwaRiKoKb4D39M9W
         Sa172Dsxitjs2aNl+vxKSgmG0B/YjJNg7OO1P7+D+D6LLoze23YjZgNGFR6lpSi3DTv0
         Q96phKjs1Hk9XWXqaVblZVDXUhIU7N6k2AGwDTvGd3ro7cvt25jIP9tLLlP42HIitg8I
         yApCFiL3DqrX/ikbJdrfOjcMkFFhyFS62/KJW6OuMFOHzDDnvx/0vsaSxuJLhMLfN5dL
         CZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696974303; x=1697579103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAWJva6tWSY0k+gPfLrvQkq9uvUdgcqwh9Gj/RrjVLc=;
        b=RBsBDV0YgPhWvunqU/LrkZ1iMPgbx8xHFEVJ1fmrzC0FBA8533aCAvmdYCKuNKJerp
         TuIo8PH6/hcSpxNfe/a3Vg4fhshPItHL9tG+4sOfj5MDZ8zDmJD2aE4YfIxlzNcqzN7p
         +YRdK4xthgtU5nKo6TPgORgzIMxXnLOxvYVFajDIGel7V+QFsOojM/Kcao7pPZ3LW0Rg
         V4MLzy/hpVkJcWJXTEAVthtRF173NEbWePzqX9G7fJGo+WWPvRn17SvB8MHiTrETLB2z
         qiaMleVQH/dDpz6If5m/BOPlGdu+lHar4JayUogqU8ZOzO8JoM+9iUC82fvPJz9NnQwE
         Vzuw==
X-Gm-Message-State: AOJu0YwaqCpy4xytrShnldWLbzZxcx+1deOWGtewyf+yNw3ddio91Yjf
        BEyAl3Xds1NzrudADP0wmIDcClJWdDY=
X-Google-Smtp-Source: AGHT+IGbMDNQ0zVsUjnpGSsTngnE24exVfG0GDRbi7Mwq4Facud21y7kuRRY0iirEUBaM/nmjdndyw==
X-Received: by 2002:aa7:c74a:0:b0:525:7234:52b7 with SMTP id c10-20020aa7c74a000000b00525723452b7mr16719670eds.19.1696974302584;
        Tue, 10 Oct 2023 14:45:02 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402516f00b0051e1660a34esm8190759ede.51.2023.10.10.14.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:45:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Oct 2023 23:45:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] sched/numa: Complete scanning of partial and
 inactive VMAs
Message-ID: <ZSXF3AFZgIld1meX@gmail.com>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
 <793eaa1a-c836-3f0d-7443-b2165a9c6ab9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793eaa1a-c836-3f0d-7443-b2165a9c6ab9@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Raghavendra K T <raghavendra.kt@amd.com> wrote:

> On 10/10/2023 2:01 PM, Mel Gorman wrote:
> > NUMA Balancing currently uses PID fault activity within a VMA to
> > determine if it is worth updating PTEs to trap NUMA hinting faults.
> > While this is reduces overhead, it misses two important corner case.
> > The first is that if Task A partially scans a VMA that is active and
> > Task B resumes the scan but is inactive, then the remainder of the VMA
> > may be missed. Similarly, if a VMA is inactive for a period of time then
> > it may never be scanned again.
> > 
> > Patches 1-3 improve the documentation of the current per-VMA tracking
> > and adds a trace point for scan activity. Patch 4 addresses a corner
> > case where the PID activity information may not be reset after the
> > expected timeout. Patches 5-6 complete the scanning of partial and
> > inactive VMAs within the scan sequence.
> > 
> > This could be improved further but it would deserve a separate series on
> > top with supporting data justifying the change. Otherwise and gain/loss
> > due to the additional changes could be masked by this series on its own.
> > 
> 
> Thank you Mel for the patches. I see Ingo already took to sched/core.
> Here is my testing detail FWIW.

Thank you for testing the series, I've added your Tested-by to the final 
two patches that change behavior materially:

   Tested-by: Raghavendra K T <raghavendra.kt@amd.com>

Thanks,

	Ingo
