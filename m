Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2A78CC96
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbjH2TAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbjH2TAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:00:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF6FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:00:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso44517665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693335599; x=1693940399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQv+UTRFhSMbpmPTehmGRoiqZutf1xuJxcjK90giC9U=;
        b=pgTdcyDAn0AeDDMc4PckIzMULtg5iBBaxWOEH5nUz6RPYAIRtZZLP1hGoVf0lJcBfY
         /t2WW/tndrmbyV3hmP7MhbSsKHyBb4FJWBapKlTV0IU3n+a17CiMUYv3mjXHGMDV1yfL
         x5GQFQUVWArw5kLMtLYpPN0qsQFZeitONFussFJ6ILAFWe9yflTmAxlZoAdGXLrijv+s
         e6VpMcBtL+dpeDPUBjBe8e8c5CA3XKIisVWWk9xBMoVT5vxIPrbYfg5buCu7AttITbL6
         JPQ1iuyHcZGBIzqyJPi2A4n8Gx5uYK3LLwOC75G3CGmg0H4jzWqz0DVQJ7rowoTZjGwd
         8NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335599; x=1693940399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQv+UTRFhSMbpmPTehmGRoiqZutf1xuJxcjK90giC9U=;
        b=INU3YcdoUNHVJUF0RqihJtPa8c6UblLvJAnYILFwNHZWW7Ms5ilkFb07HKoqs+Mgz/
         OcCyeR4LuaaFIqjcHW+jeewQQF7eqz2QTzS/2v+YfV2eBhnsmZTqxS5Re38PJrogFN8B
         NdIwZl7uabwmNxzfv7HSM/WoruBi62ux19A7r6MRJ6NJS2OynykZ8HhWpg70bjYCbQQC
         VhVHQW7PXR1pG3q54MkHdS89KtvBgrxa+4OhUdzZnMZv/djEfaLXas1B04H+niaa/art
         KOCsWgCtzoP9nvgOpDeB0GGdJnFi1fOldHweBgaT9w5nOnEh/C9UpH1q9f6CJcyb8Qqt
         6jDA==
X-Gm-Message-State: AOJu0Yy2AiZC+9ULDZVbsOMo5hGj7V5e7whAcVyzT0BCdZokHLBL/YY7
        LOXnZxF1K3uotHU4+75irgM=
X-Google-Smtp-Source: AGHT+IEl1Y1WZSjpQoeZ02EP8mF4Ci+9vijI2tQ2jF6UR3othcVr1cSUb4OOmsaHTulZceiUMRVmUQ==
X-Received: by 2002:a05:600c:b4e:b0:3fe:dcd0:2e10 with SMTP id k14-20020a05600c0b4e00b003fedcd02e10mr133543wmr.17.1693335599449;
        Tue, 29 Aug 2023 11:59:59 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003fefcbe7fa8sm14711171wmc.28.2023.08.29.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:59:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 29 Aug 2023 20:59:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dapeng1.mi@linux.intel.com,
        zhenyuw@linux.intel.com
Subject: Re: [PATCH 0/6] Cleanup Intel PMU initialization code
Message-ID: <ZO5ALPl/Li+Fr1SC@gmail.com>
References: <20230829125806.3016082-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829125806.3016082-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The patch set is to clean up the Intel PMU initialization code. There is
> no functional change.
> 
> Kan Liang (6):
>   perf/x86/intel: Use the common uarch name for the shared functions
>   perf/x86/intel: Factor out the initialization code for SPR
>   perf/x86/intel: Factor out the initialization code for ADL e-core
>   perf/x86/intel: Apply the common initialization code for ADL
>   perf/x86/intel: Cleanup the hybrid CPU type
>   perf/x86/intel: Add common intel_pmu_init_hybrid
> 
>  arch/x86/events/core.c       |   6 +-
>  arch/x86/events/intel/core.c | 397 ++++++++++++++++++-----------------
>  arch/x86/events/intel/ds.c   |   4 +-
>  arch/x86/events/perf_event.h |  37 ++--
>  4 files changed, 226 insertions(+), 218 deletions(-)

Applied, thanks.

	Ingo
