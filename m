Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FD76ECBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjHCOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbjHCOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:35:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63889421F;
        Thu,  3 Aug 2023 07:35:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D981A31A;
        Thu,  3 Aug 2023 14:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D981A31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691073291; bh=9FpXj138aLwSMechytCcdOziH9ecwbVXLIo416cCJSM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OqmViMk8ildYMdSqsIn1qFF3QJMBez6U4ObHC76vmvX24eEC+yx8/+lpKG5VHhDYg
         gmIHTKk8XdXdVU3046ESQJOpMZBM6c8/vrKqETraoGzZx3+G5CtihQYk6mMdLGZ4HW
         UDfSWWZ9BQrHXcKFGieWTKGjujM6EsuzlMQS+cyBXWxAsCh/9FG8rIMsgl0GPzUzlF
         eZ72rcwhKRCfOj5mIi+O5QAQjQs2Yu/6hALnQH00151kqPLu6DXZjlwxt+DVWIRWWo
         vwlmaQqLm276AbaMksBITB/y0Frcx6humpWOLYquHNZOV72tf8rPrBu0AFLb0DX6bf
         XM3XLoZUKNPHA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2] perf doc: Document ring buffer mechanism
In-Reply-To: <20230803035037.1750340-1-leo.yan@linaro.org>
References: <20230803035037.1750340-1-leo.yan@linaro.org>
Date:   Thu, 03 Aug 2023 08:34:50 -0600
Message-ID: <87v8dw6vp1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo Yan <leo.yan@linaro.org> writes:

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

So this seems like good material from a very brief scan.  I do have to
ask, though: why is it not in RST, and why not put it into the
user-space API book?

Thanks,

jon
