Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344CC7B6027
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjJCFA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjJCFA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:00:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D296AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 22:00:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c724577e1fso3877905ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696309223; x=1696914023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+nfCohsf0IBpk4VGOH7juW9pyfIB5x24Be0mmL+VZE=;
        b=a+fY2aLy6vOKPsj6iMlnwP/J6zcbY57TL7Pg7gAEtL3UEGTMkjeXTdJxeUwR6eYC9H
         C4tmjdgQCYpou4LPaYj2yXcZ1W+lj0p63JiuvU8QY4PpRmyd34C7AH1npV2hGpNo661z
         /YcmqHyEaPEMUEHn23WSViob3ARbRHn33v79mDr30K09EdnyeW4V2SePkeKSVh8yXvxa
         10VnQxzpaz56hzRVG6x9qepOucrqNaIXgy1y0scv9BzwCJGuvPaIv5UN315vPubDBZDT
         r49MEqv3vKT0+CrrqwIsRtIi+96oytN6PQlXJVLHa9aXPX5YLpQEx1H1zNkCYGo16eIX
         WcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696309223; x=1696914023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+nfCohsf0IBpk4VGOH7juW9pyfIB5x24Be0mmL+VZE=;
        b=pqaNFSRY1Xu0RhxmeSaijIXtgEAWGvigJfm7+8gMRs8o5dKhHsTlUnSwCYC/dP+QSh
         aVbSdOMPFJyCfUZC8iaQU/zY33F5IrvM5BScCZFklrHeKAMR0JJrQasYJpx0FB8ijzlQ
         MuVgPxDVkKOAEgCMc9vKgF9me5wF6A+ejltVt/6WiZr1W9fvfhriNJehPS7H3afxxMYO
         LArXJb9z16MYXgjVm3qUBdjmhxROcJOPaFalz05fYRVOSEQfjz7/H/QgUW5stcku4767
         r8dafB4XwxbjUlFIvaZLlqkASsymw7JmMzPsQr4R1LV/NM4tun6/5G8vzso9lwuSKO0c
         FRUA==
X-Gm-Message-State: AOJu0Yy865TLJcyY/3ssVbNTCE97MZSwoH6c85SawuIK7nP4JarqRAw7
        c18817FTNPEMbCCQphDqtZOCUQ==
X-Google-Smtp-Source: AGHT+IGV8BafNbY23Sj91HQExmnOCTvnlpXWNS0/VLWcWWpENSZR05eOYIfmerdwQTZsWs4wrSMLBA==
X-Received: by 2002:a17:902:c408:b0:1c5:f0fd:51b5 with SMTP id k8-20020a170902c40800b001c5f0fd51b5mr17458750plk.40.1696309222686;
        Mon, 02 Oct 2023 22:00:22 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id o19-20020a170902779300b001bc675068e2sm388299pll.111.2023.10.02.22.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 22:00:21 -0700 (PDT)
Date:   Tue, 3 Oct 2023 10:30:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com,
        amiettinen@nvidia.com
Subject: Re: [Patch v2 1/2] cpufreq: tegra194: save CPU data to avoid
 repeated SMP calls
Message-ID: <20231003050019.a6mcchw2o2z2wkrh@vireshk-i7>
References: <20230901164113.29139-1-sumitg@nvidia.com>
 <20230901164113.29139-2-sumitg@nvidia.com>
 <20230928070545.b7l367qi2q4rynji@vireshk-i7>
 <8cb33679-5056-8983-9334-3ab3d170568a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cb33679-5056-8983-9334-3ab3d170568a@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-23, 19:47, Sumit Gupta wrote:
> 
> 
> On 28/09/23 12:35, Viresh Kumar wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 01-09-23, 22:11, Sumit Gupta wrote:
> > > @@ -131,19 +132,10 @@ static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
> > >   static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
> > >   {
> > 
> > > +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask)
> > 
> > (Yes this is existing code, but ..) you don't need to perform AND with
> > cpu_online_mask as policy->cpus should only contain currently online CPUs.
> > 
> > Please check if you ever see it differently.
> > 
> 
> I think this was kept to be safe.
> Should I removed the AND in v3 or send separate patch?

Sending it separately would be ideal.

-- 
viresh
