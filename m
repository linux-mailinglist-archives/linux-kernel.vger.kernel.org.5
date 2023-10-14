Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7611A7C9388
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjJNIoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjJNIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:44:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F2BB;
        Sat, 14 Oct 2023 01:44:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so5165675a12.2;
        Sat, 14 Oct 2023 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697273052; x=1697877852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfAieePA5vpkTsm3Lg9DT3eg6wz3q+Z/kvUk23qNav0=;
        b=U3Hn33vxApfL4089fjDVQZAr/zME6ZioR7bTXpE/vVYj3pRhUL5cDGXIi7VVKib9bI
         uuIgKL94wPUut8PfYp7FR8n9Da7EmAtADg7pBoWCHu/T+uno5bF90/QB/19oQmLgDyJa
         VagGTLXUlUJSSa3UGaSMGrbJkwn1+Svdcd9Owt+5sEm6aRrtJD68PSjFrmz1Oo0jtxU7
         csAycMFk0xmDyW1wrmEzCb1ySa9b7qPOGqdI2ZKgLy3NfX7HqEC5Hey5jrcJph0kVHQe
         yyLDxh4+AdGWAM9LCZQgSg2iCdzP3pAeVA7aZiep2nD8irUR1oyMVdZ8Me9WZBTX2Z/Q
         3GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697273052; x=1697877852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfAieePA5vpkTsm3Lg9DT3eg6wz3q+Z/kvUk23qNav0=;
        b=Xk/JoljJAHYSfmXPIPOLkjLZWzLV5XGGT5lDuLhAjan/QsI5xT6GQbcbueEEiWpIYi
         YwtVFcPyJmHFGbXtBLFfm0xIVednb65oBVJ3pzbFFK9DohgQMYnQ0ouFk1E2Y3IE5gjX
         E7J+IzMWk0fQ5EUh4VeXGF+/nYdyCnWJ4XcZOMPhnT6ms9cs7DyXUnnTxQbopKQe3tUj
         7sHqSqyCN38h9/NprPZ41cHHDULQlAsgSjVhPdGHbyP1ubySHGNzoM37J2iVVoLSDdCJ
         mp0WgTaL6dIHdW0WpRHqXB9BHlCKjUIwhOO1lOITuql2YGkJK2Jpr+kQXm7SYBpHCmSB
         /zvQ==
X-Gm-Message-State: AOJu0YwkD7VVFClPwCm2a4drtmyMuZEGUwEbuVNz3AG4I5NT0FpLaroe
        ZdDBLu5D0Q8xjhFS98Mjhus=
X-Google-Smtp-Source: AGHT+IH8YDbJYQgUkAJbgWUajcrExCf6li6de+ubUIq9v+AxEjK8XIgv1EvmMvJHWOgL69PSHU3+8A==
X-Received: by 2002:a17:906:1d:b0:9b2:9a0e:9972 with SMTP id 29-20020a170906001d00b009b29a0e9972mr26994917eja.13.1697273051953;
        Sat, 14 Oct 2023 01:44:11 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b009b65a698c16sm639989ejc.220.2023.10.14.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 01:44:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Oct 2023 10:44:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZSpU2Q7A9ViZe7DB@gmail.com>
References: <20231013232435.1012585-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013232435.1012585-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Namhyung Kim <namhyung@kernel.org> wrote:

> +	cgrp_send = cgroup__new(p, /*do_open=*/true);
> +	if (cgrp_send == NULL) {
> +		fprintf(stderr, "cannot open sender cgroup: %s", p);
> +		goto out;
> +	}

Maybe in this case print out a small suggestion of how to create this 
particular cgroup?

Most distro users and even kernel developers don't ever have to create
new cgroups.

Maybe even allow the creation of new cgroups for this testing, if they 
don't already exist? As long as we don't delete any cgroups I don't think 
much harm can be done - and the increase in usability is substantial.

> +static void enter_cgroup(struct cgroup *cgrp)
> +{
> +	char buf[32];
> +	int fd, len;
> +	pid_t pid;
> +
> +	if (cgrp == NULL)
> +		return;
> +
> +	if (threaded)
> +		pid = syscall(__NR_gettid);
> +	else
> +		pid = getpid();
> +
> +	snprintf(buf, sizeof(buf), "%d\n", pid);
> +	len = strlen(buf);
> +
> +	/* try cgroup v2 interface first */
> +	if (threaded)
> +		fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
> +	else
> +		fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
> +
> +	/* try cgroup v1 if failed */
> +	if (fd < 0)
> +		fd = openat(cgrp->fd, "tasks", O_WRONLY);
> +
> +	if (fd < 0) {
> +		printf("failed to open cgroup file in %s\n", cgrp->name);
> +		return;
> +	}
> +
> +	if (write(fd, buf, len) != len)
> +		printf("cannot enter to cgroup: %s\n", cgrp->name);

The failures here should probably result in termination of the run with an 
error code, not just messages which are easy to skip in automated tests?

Thanks,

	Ingo
