Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037F676F02C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjHCQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjHCQ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:57:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4144691
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:56:45 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso1021890b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691081803; x=1691686603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yF5iQrEfo52tfmrVUbalVYIcokRwhlgV2+zRKbvqOFM=;
        b=DLFBzikqXRjO8aIxqeA3Ghsjj9G6YE7rWs7PXc2XeN8OHgnL7+98GEk7X1mpo9WmDr
         u8Jye2DcKHwYN/VBmXHspQ88kTgZczhrbnJZFg8ExZggfBOZjQb4eQxS5GXU4NY9ssOF
         6kF6DZE1zpt5L6rgS6YgI0Va4yqnl3t6EudlQi+mM5OHn4fJayuOC8kjbo3eeD+iGg+t
         cvT8hXfUF86dws/P/BzW7wkqGQTTG6KMNsAmWOmUgIJOWhUH3weI02G49rGJV1ifKoW1
         gdCQvZgXt7Gp1AtdwBYaZbKKH0lW3eaiXtpeO2fyhNCOJwj1mG4KnWVnvZHhineu3Ywq
         B1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081803; x=1691686603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF5iQrEfo52tfmrVUbalVYIcokRwhlgV2+zRKbvqOFM=;
        b=F8BB9iLEWrhHMm0hSPctnUgZMqtVhmc/TsV5b19hJhRoFfaHbzXw28f+ME1d5C+s8z
         V+RDB+j2jZy3ZkFKJuLk9Y9Nr/w+Lh0mBdZm5fGUZvRHmaCUqEAYtjfl/NPX5pUTuF8D
         6fXxgcyAlZunmqJhweiaWdRj+O+8bf33uiUXVua3YtNYcXTv0tsx+nF75Ob7WkTrvQk/
         1lXX1oNlPAyej6LOoqV2YHuSX56QZUD3n9YzRT5Alqg5K9ELQyZtHv0N09MJH4vX68CH
         HISdseCzohHSzSNcQ4mVx/Q7F9nIAbzBo97xCS8T27vYc321im0MMEeEZZoF4QDadMK/
         IQhg==
X-Gm-Message-State: ABy/qLYteslz7dYNEWVg6cH3qGow18Oqnjl8P8iJ3kv0OQOaNFvxNk6n
        umUK1OHQdd4YC4oEMgP4nuHE/g==
X-Google-Smtp-Source: APBJJlFo80PDH4xMdM5+Al+USUFkGWPutqXeBsPA9BpTVp0jH2AaGJhVIQUSn5ubrf3ontdYMnP5nw==
X-Received: by 2002:a05:6a00:18a5:b0:686:24e1:d12e with SMTP id x37-20020a056a0018a500b0068624e1d12emr23614520pfh.30.1691081802601;
        Thu, 03 Aug 2023 09:56:42 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b006871859d9a1sm99853pfo.7.2023.08.03.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:56:42 -0700 (PDT)
Date:   Fri, 4 Aug 2023 00:56:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf doc: Document ring buffer mechanism
Message-ID: <20230803165636.GB1783639@leoy-huanghe.lan>
References: <20230803035037.1750340-1-leo.yan@linaro.org>
 <87v8dw6vp1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8dw6vp1.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Thu, Aug 03, 2023 at 08:34:50AM -0600, Jonathan Corbet wrote:
> Leo Yan <leo.yan@linaro.org> writes:
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
> 
> So this seems like good material from a very brief scan.  I do have to
> ask, though: why is it not in RST, and why not put it into the
> user-space API book?

This documentation is Perf related topic, so my instinct is to place
it into the folder tools/perf/Documentation/.

Strictly to say, the doc doesn't give formal introduction for the
user-space APIs.  Given perf ring buffer is a mechanism for exchanging
data between the kernel and user space, I am open for placing it in the
folder Documentation/userspace-api/.

I would like get opinions from the perf maintainers if possible, if we
have agreenment I am glad to convert it to RST format.

Thanks,
Leo
