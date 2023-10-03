Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677F7B65D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbjJCJsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjJCJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:48:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9EAB;
        Tue,  3 Oct 2023 02:48:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso906865966b.0;
        Tue, 03 Oct 2023 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696326480; x=1696931280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSO0bN4wxCWQoR1ffLDq1SwoPvsZiN1HuMrXKXx4kYs=;
        b=LPDrvq6LQodPlTaidG9rx7MK6i4od4lNdtNHfW4s9uVnOjCOc1cQUbUHoR8BgR80Su
         uiznrVB3+OHWJuI2idrzKUciihKxpUuj0VQWz16L16+8YyUGe7EFcOCP0/3uGsvXQYC7
         NSi+pEf2hUJgCLuX+wQbnaiDY/M9egHDa0UoAH09zr7G7l5kxs2Jn35M/voIFi11aqDS
         vFEcK9AJ84HYrO217bX6G3cbVN8gywpCn+yLZpOz55YK9UV4fNor3A69UfFOwuyUOlw2
         6Itbf0r0+wn69d77iHWitXyPE7QDgu5bshzdAikW7GrpJ3WLf370sTIZ4BX/O10P+PyO
         7vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326480; x=1696931280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSO0bN4wxCWQoR1ffLDq1SwoPvsZiN1HuMrXKXx4kYs=;
        b=EKJ3roTexaa313Hbtfoxy0HfJr1Cdn4XcBZF1erJUjFJrkEHC254E3r361WgsCyOth
         DUQY9bH5GQnpgnkLJhNcAUMGvl7WRtqYZB59hnSAGe/iDOlqY4+eIJBvkcec3fIET2uI
         DOAO/k+qyzB3yzHdrkz2QtjYtpxumdt1jJmxs1w35hm+CYmwkbUQK0o4Gjmq4T5+YZyt
         f8xFHavo/5zeeH/mfiSdqD1xTsfFQ+1LzsN/+Ms0WKCI1TJA4m2mERQ7dfMq3697i4eb
         T6VIsEp+HbdZWPg3IbusgxCnaIqQgj+E2A/kHCfUQMuxiAujTu6Kk9kZ6raEduzq7c1n
         fMEQ==
X-Gm-Message-State: AOJu0YzEummC44M35bSnz1EE3Z/rgTwhPGxSrCGxG0T9tmKPAejRor1X
        andkhL0ynxeUJTihg6huTUc=
X-Google-Smtp-Source: AGHT+IEN69vXY6H/V81B5pwO5LsN5OeXTGJm5dn5NQmdMicTNk7eguebs0y066OCE8Zz0MKL8YE3Ng==
X-Received: by 2002:a17:906:13:b0:9ad:8a9e:23ee with SMTP id 19-20020a170906001300b009ad8a9e23eemr2112990eja.13.1696326479613;
        Tue, 03 Oct 2023 02:47:59 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b009b2cc87b8c3sm760511ejb.52.2023.10.03.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:47:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 11:47:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] perf doc: Document ring buffer mechanism
Message-ID: <ZRvjTW4PACGaU2h+@gmail.com>
References: <20230803114613.1786849-1-leo.yan@linaro.org>
 <ZRvda2QwdFYCp1F1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRvda2QwdFYCp1F1@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Leo Yan <leo.yan@linaro.org> wrote:
> 
> > In the Linux perf tool, the ring buffer serves not only as a medium for
> > transferring PMU event data but also as a vital mechanism for hardware
> > tracing using technologies like Intel PT and Arm CoreSight, etc.
> > 
> > Consequently, the ring buffer mechanism plays a crucial role by ensuring
> > high throughput for data transfer between the kernel and user space
> > while avoiding excessive overhead caused by the ring buffer itself.
> > 
> > This commit documents the ring buffer mechanism in detail.  It provides
> > an in-depth explanation of the implementation of both the generic ring
> > buffer and the AUX ring buffer.  Additionally, it covers how these ring
> > buffers support various tracing modes and explains the synchronization
> > with memory barriers.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> > 
> > Changes from v2:
> > - Refined doc for Thomas's suggestions (Thomas Richter).
> > 
> > Changes from v1:
> > - Addressed Ian's comments and suggestions (Ian Rogers).
> > 
> > 
> >  tools/perf/Documentation/perf-ring-buffer.txt | 762 ++++++++++++++++++
> >  1 file changed, 762 insertions(+)
> >  create mode 100644 tools/perf/Documentation/perf-ring-buffer.txt
> 
> Nice addition!
> 
> If it hasn't been picked up yet:
> 
>   Acked-by: Ingo Molnar <mingo@kernel.org>

Note that my ack is conditional on the conversion to RST and moving to 
Documentation/ - this documents an important aspect of the primary perf 
ABI, it deserves to be on the kernel side.

Thanks,

	Ingo
