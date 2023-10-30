Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FBF7DB890
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjJ3Kzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjJ3Kzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:55:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF5B3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:55:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40842752c6eso33958465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698663328; x=1699268128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCas6hX2kWduGAI2JdLIbnqmVCVWVtcBGMd04qHlJPc=;
        b=Q76O3BjSDQ6dzoC5914LmTsg6VW3PvS1woczVL43dumq85QWqqtjLuyeKFDv3VVdvq
         669eCtAcR5bK3pRVoxiv+KBYOHScUt2Ev71dbd9DkkHW7eIiPbhc71Y7xTFAWrCcTylI
         ymqyVUr6LXW8h4yZhedrljuxwRTQmPJXjD2Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698663328; x=1699268128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCas6hX2kWduGAI2JdLIbnqmVCVWVtcBGMd04qHlJPc=;
        b=gFy3svowoLDor714J4t18jcvKr4pLCfEKKFJnNd8ly5NRUqrW9NWBHuE9J2/EFKUwG
         zChqHu0hHfvBl++109PbYaiGbnRhnHYh1IvDujvoCbhkKlSeyXV++je5IqZuXUq0dgRl
         i09pbJwWXa1jFHqIazP2IH7gG1L5o/jGlaG7hT/LMDxsW3g9+xcL3uITxE/ALgtLo4ac
         L1Uzvmzx6sOPPEjV65t63brP+JJV1366EQ14Z4OBsHwm9ECllRTOl34Dg8M3OqWuc77s
         SLCl6NNDHbznkjqrb/PMAy4j00V66h051A+OWrPJIn9xRHzuCxQQ188n9uamyIdISPM0
         NIAw==
X-Gm-Message-State: AOJu0Yz4CcO3SWYBcmX20DJws7VoVFQ+iWRPn4bes9lhjgwwrUxHzM0W
        A2bwZNSXoHY0dUivSDujDMHKxswZny+BsNaovWU=
X-Google-Smtp-Source: AGHT+IFIG2JmRgjFPuNmavfl608xo7vwagG+rRyO7KWjwBMy103Q5/luicy3F5CrXm+aarJh9c4Nog==
X-Received: by 2002:a05:600c:a0b:b0:401:c338:ab96 with SMTP id z11-20020a05600c0a0b00b00401c338ab96mr7814466wmp.34.1698663328414;
        Mon, 30 Oct 2023 03:55:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:482a:b779:b769:fa72? ([2001:8b0:aba:5f3c:482a:b779:b769:fa72])
        by smtp.gmail.com with ESMTPSA id q1-20020a056000136100b003143867d2ebsm7925824wrz.63.2023.10.30.03.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:55:27 -0700 (PDT)
Message-ID: <ba1369810b39f79c0b092151bfa062dd0cf505b3.camel@linuxfoundation.org>
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Oct 2023 10:55:26 +0000
In-Reply-To: <20231030082644.GK26550@noisy.programming.kicks-ass.net>
References: <ZT6narvE+LxX+7Be@windriver.com>
         <20231030082644.GK26550@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-30 at 09:26 +0100, Peter Zijlstra wrote:
> On Sun, Oct 29, 2023 at 02:41:46PM -0400, Paul Gortmaker wrote:
> > The TL;DR is that the Yocto folks encountered a regression in their
> > automated QA tests (after a move from v6.4 --> v6.5) where non-KVM
> > enabled boot tests on 32 bit x86 would (with ~2% frequency) splat with:
>=20
> You're sure you're not running into this here:
>=20
>   https://lkml.kernel.org/r/20230706170537.95959-1-richard.henderson@lina=
ro.org
>=20
> ?

We're using qemu 8.1.0. Whilst I will get us updated to 8.1.2 and see
if that helps, I think those commits are in 8.1.0:

$ git show cb62bd15e14e304617d250158b77d0deb032f03
commit cb62bd15e14e304617d250158b77d0deb032f032
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Jul 6 08:45:13 2023 +0100

    accel/tcg: Split out cpu_exec_longjmp_cleanup
[...]
$ git tag --contains cb62bd15e14e304617d250158b77d0deb032f03
v8.1.0
v8.1.0-rc0
v8.1.0-rc1
v8.1.0-rc2
v8.1.0-rc3
v8.1.0-rc4
v8.1.1
v8.1.2

Similarly for:

commit deba78709ae8ce103e2248413857747f804cd1ef
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Jul 6 17:55:48 2023 +0100

    accel/tcg: Always lock pages before translation

and

commit ad17868eb162a5466d8ad43e5ccb428776403308
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Wed Jul 26 12:58:08 2023 -0700

    accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow
[...]
    Fixes: deba78709ae8 ("accel/tcg: Always lock pages before translation")

Both of which are also in 8.1.0.

Is there any other patch related to those we might be missing?

Cheers,

Richard
