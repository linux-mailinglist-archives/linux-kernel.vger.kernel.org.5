Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A887CA43E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJPJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJPJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:35:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D987AB;
        Mon, 16 Oct 2023 02:35:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c3aec5f326so183312366b.1;
        Mon, 16 Oct 2023 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697448938; x=1698053738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z29M6zjVLJvKiOvklGlopVyqGb27pfDVnnDzs1mArTs=;
        b=Z5elJXu8fQ6kBoMUxzCZrbjl3NBKH1BJPPdOHTRt4A0wAc2nG4xNZktqexiFx5nVhK
         r375YmBtdVwC9VF/TP++r688ZwNN/MeY/6K5Y9WvWlJTU+NEEnYNABEXKQ1xszoC/eI5
         TIms1s6bdwgi94nKRP0+KJ88itYlZ4a5MWmqcIQkb6kr2qozKqRvnE3+vSpdgfHQhC4e
         4n2C4ZMhJDMOBS8rnCr5uUrgXpTB9EAegImMi2GED7NFoHBEAIaRhpAVj4jE1VFF9sq1
         zd5FjPyVCZO8fIiCAF0X/+tSNJdtiAhm+CtC6yRD15Y/nWlSjzw5PkWthon7t36N9ns9
         k6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448938; x=1698053738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z29M6zjVLJvKiOvklGlopVyqGb27pfDVnnDzs1mArTs=;
        b=wNcg2+OURERETW0gJq4f2N9Uw1Itlc4ESAv1H6dIU2cqdOYr04bQcLoYWI2Fshorvy
         T1A0Z7H9IxUpplbEIUi0c/zje1AUQkNXdh4KYwufUkibBYTmFCJpXtUaOBgWlvG9SUwC
         yfAcuSk3dcAc+ah8dpCqspwwyx0C2M03rMsfDAH0SC/HOMYEfijDkbbai40uv2eDUvmV
         evcUzg087bqB6R15B8SOkwHiHKnA6AjMKVCoCPMGquHEbYuBiAFQ+Yy3ixMnUH63zX3P
         1ci23014RYtsRE/Ot+U9AywfhJKKwAO9/+u3MCGxVY1iAdCzj/YWFLv3FQqqAP17M6Bl
         Zyvw==
X-Gm-Message-State: AOJu0YzgNBf/sxIxReQt5ULMpbR2z51w88k7bSzqqu6C6Ge0fiAWREl7
        zBm9utvF01/K591BUIO1WYxwwxRA3XY=
X-Google-Smtp-Source: AGHT+IGMn74+LMNY2vOSX9tQvqNnbhNqi37ZWp6TLuX7i534K16ZNXfF6KakjydlceFfgwpw97gubw==
X-Received: by 2002:a17:907:dab:b0:9a1:b85d:c952 with SMTP id go43-20020a1709070dab00b009a1b85dc952mr5986039ejc.12.1697448938409;
        Mon, 16 Oct 2023 02:35:38 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id dk6-20020a170906f0c600b009c3827134e5sm2070082ejb.117.2023.10.16.02.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:35:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Oct 2023 11:35:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS0D53ckVx356k4o@gmail.com>
References: <20231016044225.1125674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016044225.1125674-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



* Namhyung Kim <namhyung@kernel.org> wrote:

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
> +		char mnt[PATH_MAX];
> +
> +		printf("Failed to open cgroup file in %s\n", cgrp->name);
> +
> +		if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") == 0)
> +			printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
> +			       mnt, cgrp->name);

Ok, this works too I suppose.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
