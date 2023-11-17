Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2AA7EF76E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjKQSWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:22:23 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E7B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:22:20 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af16e00fadso32961127b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700245340; x=1700850140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=67j9+17m/+Ov80pCnuJ4gd7d1de7FvoHgKDEaTGjv7Q=;
        b=kSGMeBntGpRqx80iSRFYbnKN4Yh1JeZxEE7yL38pqfk01AD503Hb6O7BpTj9k8DMOV
         xfq1mCWTdmypM1YKKWbyjHMoh1/XC87Uv6jdTNoBhzZD8b/tMShAveQMa1BMBQ+FgdbE
         RA0kxyNj3wg2Vmk0pfJhUcsrVYQpQ/W3SBV/h/oTwDENqGpBxWmi6v9jlgkSTlhxBDux
         QNXVgMkVjgW/EBLMhO206Z/50cedCfohosK0DHX12DAF9gajVAngkjkm8D/gjkOD/77B
         WPbPH+fh5ElwfXRBZ1/OHy4iAZ3JgUk9DLrezQWxzqgLLlMds0/x3dABznvLzBsMXewn
         VaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700245340; x=1700850140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67j9+17m/+Ov80pCnuJ4gd7d1de7FvoHgKDEaTGjv7Q=;
        b=c51KZDBOUOs9xNX0pc8ioPeL7Zs+LfIfCc4UEyABcvgaJeHoSuaQEYvjBoAS3tVj2w
         jI1UkdxNAr2230YDZQDwhIt6SwwyWtsDwPDcKeFheREo3QjGFMIYTRswqqsh3t+lK7+q
         VzSzuIloZjavnk3XyhHKQenlpXenBHkQpT/Q+mGzc7OAgIO0namXCsW1/H1v3k48xn5s
         zhCRdJFQowpiw8j41I4VbaKwW4P4DcQED+SQqxGVZYsjjxS4qn6Si4Lo6nfhu5baYlhn
         k1v2cSRGN4WHJkBkdTAK7fiemJT7iLDhFUpAENyMoYC4NkFQF0ohzALWGwpL9Mq5IQp1
         g0JQ==
X-Gm-Message-State: AOJu0Yywsl7Ond38HaHM5vTmpL8tZwrGx1mLMNIuc1KM2Tj4kQkj8d2G
        mUjFNFau/34vAaFoXpFmYtoLiwN7AV0Kiw==
X-Google-Smtp-Source: AGHT+IH7L/taQjdqofqQV9IwVstSBvW9UJq8dFBgbmoT3PvQXn1ozGa9Qj0rost66bwraph/3YhtM1xyxg+Ykw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:abe3:0:b0:d9c:c9a8:8c27 with SMTP id
 v90-20020a25abe3000000b00d9cc9a88c27mr2829ybi.13.1700245339605; Fri, 17 Nov
 2023 10:22:19 -0800 (PST)
Date:   Fri, 17 Nov 2023 18:22:17 +0000
In-Reply-To: <20231116022411.2250072-2-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com> <20231116022411.2250072-2-yosryahmed@google.com>
Message-ID: <20231117182217.q6nkynbh24wyti33@google.com>
Subject: Re: [PATCH v3 1/5] mm: memcg: change flush_next_time to flush_last_time
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 02:24:06AM +0000, Yosry Ahmed wrote:
> flush_next_time is an inaccurate name. It's not the next time that
> periodic flushing will happen, it's rather the next time that
> ratelimited flushing can happen if the periodic flusher is late.
> 
> Simplify its semantics by just storing the timestamp of the last flush
> instead, flush_last_time. Move the 2*FLUSH_TIME addition to
> mem_cgroup_flush_stats_ratelimited(), and add a comment explaining it.
> This way, all the ratelimiting semantics live in one place.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
