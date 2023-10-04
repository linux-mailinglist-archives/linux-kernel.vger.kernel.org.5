Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E57B83EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbjJDPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbjJDPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:42:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00FCC1;
        Wed,  4 Oct 2023 08:42:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso3907094a12.1;
        Wed, 04 Oct 2023 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434172; x=1697038972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TZ0cLLVJr73B5tC0V7kuMDaUss3xsEKn1sTfrrLPDo=;
        b=apH7J2DY9hhG+W69C2WZA3J3bKdaaa3eofRF3R6zMNnhkC48b/K02fEUkUPkHtRFoR
         TP5QW56HblG0byG3ZZSzzWS5kUlwlH4cERz0jnhMROdrKmClZK1l7it3MQCo9ntBO/KI
         4/KCbsLn/FouSMc3AEDLnCNb05X+e9fi1zGQBUsRoGAW7p2GiVqGTKgk85pGvJlKVJN6
         h96wAaV8VrgCM9HERX+VBNpf01fSp3D6DvCSACYvlEzf5HETlahw9DhsTCHKVL1mWqtG
         RvPe531ccVoLJfRSas3goJzut3yE+71q4yNaingIRwovjAnhW5HnOmkv3kgk78M09C7E
         oO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434172; x=1697038972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TZ0cLLVJr73B5tC0V7kuMDaUss3xsEKn1sTfrrLPDo=;
        b=dR5IhdgudszR+HZ1toxyP1XkVwhgdiT9WX42PSV2WeVZ2kB/70egVXUTX6I8emrnrq
         vYxYLOE4/8Rzow/nlNOhNv7jqxsuukIgDh7Lq9A0Z0JuNIbkH0st1opmWrYSvpJJ64Ad
         Uz6aOdWeM4IFnX7Fcn5+8vO0WLkCZYwnfQPiUhvTv1xWdoyohFx70o+H6hB0FmV2JOGv
         82CzYhvFEAnZlYPSL+BiPuEyk4Nu+GIROKYniZff+czo7aAqelrsHSJ9Qa7MkMYLvCDn
         Fhzcl8OdXvo3Hsn4IJzYUy3nerimMaNkyhs4kX1ib+5tf8PgTrTIwnlNJi9Jd8nI8LUm
         J8bw==
X-Gm-Message-State: AOJu0YzbKKRDBljYYXrVr42fCXGuWKmhuIxsXXDJqLq4tiPNtYqSmuhj
        F/8DsvqSRa2WPh1vhAj5UBw=
X-Google-Smtp-Source: AGHT+IF/GlvH2fDgX6S4Y/ycALdmg9uA2Z1lYYAC0apmWMwpZz5d1uaOJZ4OeUfS4TopmxPDKmLyQw==
X-Received: by 2002:a17:906:2215:b0:9ae:4536:728e with SMTP id s21-20020a170906221500b009ae4536728emr2636706ejs.72.1696434171812;
        Wed, 04 Oct 2023 08:42:51 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id dv8-20020a170906b80800b009ada9f7217asm2968686ejb.88.2023.10.04.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:42:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 17:42:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
Message-ID: <ZR2H+WtRexpOffTw@gmail.com>
References: <20231004040844.797044-1-namhyung@kernel.org>
 <ZR0TtjhGT+Em+/ti@gmail.com>
 <CAM9d7cjvs_CYZH6rGdujSQ8d+MBa616t95dr9oAFs-Nzr_XUOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjvs_CYZH6rGdujSQ8d+MBa616t95dr9oAFs-Nzr_XUOQ@mail.gmail.com>
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

> Maybe I can add an option to perf bench sched to place
> senders and receivers in different cgroups.

That would certainly be useful to measure cgroups overhead.

Thanks,

	Ingo
