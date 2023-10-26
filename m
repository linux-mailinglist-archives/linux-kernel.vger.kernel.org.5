Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2957D7C40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJZFct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZFcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:32:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6068DC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:32:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so482924b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698298365; x=1698903165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBEAEsZN4djiQ3228v8fI+FpEgZGRwVs54ro+ujbLE8=;
        b=rCOJ8SEQNCsKyfcnC1fNGPkGLEvHjyro90ohjhc+WsqQOJGz1lPESKmpxgPdKUOYDs
         N1ZzZymhMTtnBZxYSRz1pEfCrc0URTH9eepcX2qsCsVzUcOAulQSsmOoFq6Z7EeBm8nV
         Chs3O+jWqzQND9RZuSjxc3y5ELMYZriav4BLgXdhVN5kDF1uTHrYUn5SaY6XAE9UbY/d
         orPhslPkoeNL7aC5fW1T39V/xM/x4R/6I0Q9zkUe3R45tAY4sqqAODU8Vkq8G0qsub4F
         Wr3QhBLenssHkjJPtg/pEiQSWS8aRcKSPMiwdXflnah8Ctl6DBBNUghfVt0bPL05ATzs
         hRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298365; x=1698903165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBEAEsZN4djiQ3228v8fI+FpEgZGRwVs54ro+ujbLE8=;
        b=VJs5HejldmxzIFvIruB3ZJJEaGGb4yCi7/Oyb949RbGcD7KoFbGWcMSq+0VgDrR1K0
         2QWveOvBv+EjZteyOHQEaQa3eQfrZr2ObLeWY+psSR2bxeC6LPgSrReckpVnQDxEI7QI
         2y6OQ0xNz8SFLZTQX1LBZV9o4PkFcFWSenWw4SB4c1SQrCvZcpB3/Mf8bgIIKBFebd1B
         gLoo2NBzJJcSf0iNhOgVqXXPgz0r7zwv8uBbUv5f1CyV8OKPyGYR8hdEL2MGMjtmIA+u
         3f6DzASqEZ5bZNC0PodVWMBcf2mTW99yA1KbW7Kf45g4CSa2sNCFS+go2hQpvvw8J0Dt
         WI6g==
X-Gm-Message-State: AOJu0YzbwOKJIIv1ofKr0/kAnbknZCtrd+X1uaOb5nTeujgGnIjdS87v
        F48ta9jqZTiV/Tk+8CiqrVksCQ==
X-Google-Smtp-Source: AGHT+IFi79EC7J/PZyT8aPuF3e72CbPEci6W2qWDbfoUzWTFvPv6/KSJviE1GdJ+D1eqdcl62hwo3Q==
X-Received: by 2002:a05:6a00:248d:b0:6b2:5992:9e89 with SMTP id c13-20020a056a00248d00b006b259929e89mr20526019pfv.9.1698298365176;
        Wed, 25 Oct 2023 22:32:45 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-209.hinet-ip.hinet.net. [211.75.219.209])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79f82000000b00692cac7a065sm10258284pfr.151.2023.10.25.22.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:32:44 -0700 (PDT)
Date:   Thu, 26 Oct 2023 13:32:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, atrajeev@linux.vnet.ibm.com,
        tianruidong@linux.alibaba.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf tests: test_arm_coresight: Simplify source iteration
Message-ID: <20231026053238.GB111732@leoy-huanghe.lan>
References: <20231023131550.487760-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023131550.487760-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:15:49PM +0100, James Clark wrote:
> There are two reasons to do this, firstly there is a shellcheck warning
> in cs_etm_dev_name(), which can be completely deleted. And secondly the
> current iteration method doesn't support systems with both ETE and ETM
> because it picks one or the other. There isn't a known system with this
> configuration, but it could happen in the future.
> 
> Iterating over all the sources for each CPU can be done by going through
> /sys/bus/event_source/devices/cs_etm/cpu* and following the symlink back
> to the Coresight device in /sys/bus/coresight/devices. This will work
> whether the device is ETE, ETM or any future name, and is much simpler
> and doesn't require any hard coded version numbers
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Looks good to me.  And I did a test for it:

Tested-by: Leo Yan <leo.yan@linaro.org>
