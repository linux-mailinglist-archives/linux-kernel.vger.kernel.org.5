Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1D7B655E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjJCJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbjJCJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:22:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2EAB;
        Tue,  3 Oct 2023 02:22:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adb9fa7200so142942766b.0;
        Tue, 03 Oct 2023 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696324974; x=1696929774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmFmuhb3o4N93peu/dgTVubGPBS25MoLfRETsrWJw90=;
        b=BoV11+YrJPxx4qohFpLt+zRZJ7PoNeoG9TonnWyZP9yQ3Vmt2RnIGEToWP9BNfhsC6
         QdpvL2Tm7fHmSuiD9urgryPFmOT1fFD+8IkkO4GoqpMPy+hIDuLwNIqj1qjVvlUods+L
         gYgqBc22b5u2xc8tqx7E4LvuarJUiJ30mu7M3nncMD+qasaBlHkhF5PN5MSYebGRnjHO
         2ZgtkACZlREzpZJUlXaYL9nYZ/oQfDBRUa6FFAOCkIXV76cw2IP2MGfNRTwaUGHjfM1m
         jEymhFXNjyGXk478P93N+Ia0xzEITGiL7n4MEh4CJ9QBxmM544kNjA2zVlEk8ps2JK+e
         MThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324974; x=1696929774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmFmuhb3o4N93peu/dgTVubGPBS25MoLfRETsrWJw90=;
        b=k/RksNfIPpJUTLp/gX28/jOnq6nQ6ztfzYZBufNaZ0aJ5q3+1Ky2tux0DrXiPeV4/T
         30F8yYZsl/UthCG83TTqxx8g2QuepBYXTQzDKSfiKA9Ztq1verxOurBrbtF6Bybeol+l
         uacs69cVdFZ6YX1Za36o2JoC3PPwUOHYvnBGDPQRTiSurh4+ehw7MKYYE0y2jOqcuQuA
         iNGGb0IB/xUos4oDxXukmhf27nfCIAKDOH0IEzc95ZT5KSRWxiPetT4sNvmEbj3Jt2yH
         juL/khoSjLEZP4JsyJecDU/Z0ruUI3KqP5g6/gjYV011e77SwLi+4YclYbRaGa6MaKFQ
         PNFg==
X-Gm-Message-State: AOJu0YyugZ8cNiRd1yA20yM6lG3x932NmLNfHi3XCcCGpTYM60UKAkdE
        dz3Q7ph+HPopHF3NXAr0G68xNHPImlo=
X-Google-Smtp-Source: AGHT+IFD57PPr3QRwaAri1zjb70uxu4sLNgYbtg7CsIssMuw9sVz6vmAWwMUKwVOw/vC22+1PW72Iw==
X-Received: by 2002:a17:906:32d3:b0:9a1:b528:d0f6 with SMTP id k19-20020a17090632d300b009a1b528d0f6mr1739532ejk.27.1696324973680;
        Tue, 03 Oct 2023 02:22:53 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id sa18-20020a170906edb200b0098733a40bb7sm734169ejb.155.2023.10.03.02.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:22:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 11:22:51 +0200
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
Message-ID: <ZRvda2QwdFYCp1F1@gmail.com>
References: <20230803114613.1786849-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803114613.1786849-1-leo.yan@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Leo Yan <leo.yan@linaro.org> wrote:

> In the Linux perf tool, the ring buffer serves not only as a medium for
> transferring PMU event data but also as a vital mechanism for hardware
> tracing using technologies like Intel PT and Arm CoreSight, etc.
> 
> Consequently, the ring buffer mechanism plays a crucial role by ensuring
> high throughput for data transfer between the kernel and user space
> while avoiding excessive overhead caused by the ring buffer itself.
> 
> This commit documents the ring buffer mechanism in detail.  It provides
> an in-depth explanation of the implementation of both the generic ring
> buffer and the AUX ring buffer.  Additionally, it covers how these ring
> buffers support various tracing modes and explains the synchronization
> with memory barriers.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
> 
> Changes from v2:
> - Refined doc for Thomas's suggestions (Thomas Richter).
> 
> Changes from v1:
> - Addressed Ian's comments and suggestions (Ian Rogers).
> 
> 
>  tools/perf/Documentation/perf-ring-buffer.txt | 762 ++++++++++++++++++
>  1 file changed, 762 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-ring-buffer.txt

Nice addition!

If it hasn't been picked up yet:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
