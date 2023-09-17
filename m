Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676997A3E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjIQWhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 18:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjIQWg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:36:58 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708A12B;
        Sun, 17 Sep 2023 15:36:53 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-79277cfc73bso151980239f.1;
        Sun, 17 Sep 2023 15:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990213; x=1695595013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLRM/TAMPnfDX5GZAC/AEGiWMOUjKCNWXjIA3i3tRnU=;
        b=L4cneqAr7GaoAwtHvpOo7tLR+Klqug1AxEX8a4em4qOxSpmg/C1+ZGJ78ZssK3J+Dn
         MB1OLYH+V4WkXMX34TdFuv41ySVDEV55W4nv71zCMm7+2F/9jcc3IXy9CoR4oE4znOwg
         oTDg1Eo/mle4o277r7mTs+f5IZSOLPOMfgbvfas4FaPa830/4OLEtwElOvIAZT1PuEYF
         7GkZR1N/s5bE8Gtn+Mgc52ODSru55heWs2rxQzSom0LQc9r6cmWhnZZybCb/geZ1ReW4
         yELAEjfrFxoZVcmpkTo7TWftsrweCYpeKrhXu7luZ8s6mo9CJgdBkVpJkBISTEQ3xH46
         0kUQ==
X-Gm-Message-State: AOJu0YzyuHzwBlqzmLagS+TS34X2x3Lz2bZCtvfSQA71U1s21LsL4Myp
        yNCzh5eqMweKTgzzwl/5W2Tjy06xEP7m/KYQ8wxS3Mo0
X-Google-Smtp-Source: AGHT+IH28xpssG5qbD4AzgGrj5T2kb9k7dSRcpkbF7UwdpnEAHIuo0ksNj4A1ZieDVpsKkahA/+K8haE7lkaKhxL5bg=
X-Received: by 2002:a5d:9842:0:b0:787:1d0a:ce81 with SMTP id
 p2-20020a5d9842000000b007871d0ace81mr7838610ios.13.1694990212927; Sun, 17 Sep
 2023 15:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230918074952.7dbd75ea@canb.auug.org.au>
In-Reply-To: <20230918074952.7dbd75ea@canb.auug.org.au>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 17 Sep 2023 15:36:40 -0700
Message-ID: <CAM9d7cjtKNhdktrdm0x=jUX=WzDihfqvmC-3id4ri=mGOM12kA@mail.gmail.com>
Subject: Re: linux-next: Fixes tags needs some work in the perf-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Sep 17, 2023 at 2:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   927265904c8f ("perf pmu: Ensure all alias variables are initialized")
>
> Fixes tag
>
>   Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> In commit
>
>   89f492007445 ("perf jevents metric: Fix type of strcmp_cpuid_str")
>
> Fixes tag
>
>   Fixes: 9d5da30e4ae9 ("perf jevents: Add a new expression builtin
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line.  Also, please keep
> all the commit message tags together at the end of the commit message.

Ok, I'll fix it and re-upload.

Thanks,
Namhyung
