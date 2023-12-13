Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3F8113BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441832AbjLMNxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379386AbjLMNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:52:47 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D29719AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:27 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0b2752dc6so61267195ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702475487; x=1703080287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFL9Q8QzauxiWuAYIkvIszXQXc3FR7WIblGrI+LLQgk=;
        b=ZHR3vdgDqC30dLSxVCwBYtaUj1vupWXEC+qokSLG7tpEaMAm8GdbQ8Dp/xm4mmrg6c
         +dbWgeymIeRhKEPMXaQ21LvaPaxV4ehMWBADAclVbEwrDwxTmm0wscn3A0+lIbano/HB
         Quk3cvR1H7r98titrJVZJ9htskJXYHh5dlHGuE9HJEwycrw/nshQTgydoXyDtfeSsAei
         ZGBNQ/ZjdklFM0nToQUTm3rLKmljBrvUD9SJmOd1Yq7KZ7szACu4AUZ8aLJHiIMGIupA
         kRiziURYWypsrkalbv+tKA1R/zk9BjZNCZdfaSFM3g/Q4rdk3Yc/AEOfLAEcrp8e7cMe
         6ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475487; x=1703080287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFL9Q8QzauxiWuAYIkvIszXQXc3FR7WIblGrI+LLQgk=;
        b=aCFcRVfZHODxiYQYNXuxjkN8HX6ngutndItB2izcsR4Nwa6XDlicAvC0ozoYV1Qv4c
         C1Ye/vhFHDmSHQ+Lm5Hnyi6tlOtqqDT6HkU0GlwGpxte9N0ublrpGMwqK3CiDEmgGoTO
         7zUR2OxIa0+ls9kkzILD1PVA7d8axqkR08baWEiJ4toInCt3gcger44NMqzDXN2jex4b
         h2ESYeA1CA+6C80J7OxTZ5q0q2EZc+/9xL/oVyye9uVwTBrDwzze7af+x5eIgsktvPW+
         +snnE+MgntwrAf59okZgDvZA5Bs2UiyfmDrcW30JHwxUR7jHzYXFqCa7cpOZNkSwtzck
         H1fA==
X-Gm-Message-State: AOJu0Yz5TDfokXGKtsjWI+jD4lQBR7O31l20QSqKvVcSOLyXsN0zG2uK
        OlL2rAVevMVPWXn7kg1Q9vajnw==
X-Google-Smtp-Source: AGHT+IHiVudgJ8w2j94doVUAeUrPN3IQZZONJ1H0nTCdQmnfLcj1Y9/u4v+/r2IXJzbGgIB0D0PAAg==
X-Received: by 2002:a17:902:be17:b0:1d0:9a64:e511 with SMTP id r23-20020a170902be1700b001d09a64e511mr6891352pls.73.1702475486604;
        Wed, 13 Dec 2023 05:51:26 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001c9d011581dsm10531995pls.164.2023.12.13.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:51:26 -0800 (PST)
Date:   Wed, 13 Dec 2023 21:51:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 4/5] perf mem: Clean up perf_mem_event__supported()
Message-ID: <20231213134911.GB3895246@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-5-kan.liang@linux.intel.com>
 <20231209061723.GC2116834@leoy-yangtze.lan>
 <2865c1b4-a003-44df-a734-1e1c90bfa14d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2865c1b4-a003-44df-a734-1e1c90bfa14d@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:44:54PM -0500, Liang, Kan wrote:
> 
> 
> On 2023-12-09 1:17 a.m., Leo Yan wrote:
> > On Thu, Dec 07, 2023 at 11:23:37AM -0800, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> For some ARCHs, e.g., ARM and AMD, to get the availability of the
> >> mem-events, perf checks the existence of a specific PMU. For the other
> >> ARCHs, e.g., Intel and Power, perf has to check the existence of some
> >> specific events.
> >>
> >> The current perf only iterates the mem-events-supported PMUs. It's not
> >> required to check the existence of a specific PMU anymore.
> > 
> > With this change, both Arm and AMD archs have no chance to detect if the
> > hardware (or the device driver) is supported and the tool will always
> > take the memory events are exited on the system, right?
> 
> Currently, the Arm and AMD only check the specific PMU. If the PMU is
> detected, the memory events are supported. The patch set doesn't change
> it. It just moves the check to perf_pmu__arch_init(). When the specific
> PMU is initialized, the mem_events is assigned. You don't need to do
> runtime sysfs check. It should be an improvement for ARM and AMD.

Okay, I understand now.  For Arm SPE, it has a dedicated PMU so if the
PMU is detected, then we can assume the memory events are supported.

For other cases, you need to check furthermore if PMU has supported
specific memory events.

This patch is fine for me, you could ignore my comment for the
regression caused by this patch.

Thanks,
Leo
