Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407F88042FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbjLDX6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjLDX6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:58:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EEE107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:58:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db54a19c7d6so3751689276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 15:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701734338; x=1702339138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bc3wWZdTIWXynHMDoBBnLgT0pYzNdNHfaXI4uKulM+I=;
        b=FLAhgsNetn2k0Xo7OHCrDXsmBVkNiGRf/sj8OrCyNH87DQyF7GsvikfhBxabA6cj5P
         ceHWjEps0QH6FBamV8TRnY5uCO9YmDJrDJI2Ym9xmvTghiFqhhEdAIk85hwwGwo/XBjC
         HWQFuico5tD0R88HpPgV6WrTsUgh2noPCL44LWW2ff9uzDxS86a5pVIGpgRZOQnBOJn2
         VTusOSrHttduU9Cmz8H/YwkqInN1VMB/nmUWt/ymvQ+801qEZAEFQWny2TUlGnJOZhMi
         Jch62C4/I62+EtF7aNMzeMOmUJd8lzBnyo6V+DiFtWPLCFNvPKWuFKVtaSvDZBhjR6ys
         AJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734338; x=1702339138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc3wWZdTIWXynHMDoBBnLgT0pYzNdNHfaXI4uKulM+I=;
        b=GERzrsE+kgUrQhMa8o5Ocd3wBW0DggV98XhpwTVMj5akqkvp2TzvNxnkDsOWmI4DH/
         1HHXp+C/NaCN4hCUVMLfXYmauwY8GgwqeNyVNWOA7ET30IZo0uGcx7LQAlwG8smCuTkv
         ChqzV6flCgU0lSK0V+55HDcrRF7plYeGMBoK+2YhDCbmFVcJWBO5v+/VlzIA1uxW5/dY
         qmM2CBsWh7INlEz5qW5X+3AFJTvYcCbVZXQhpLJG69QMOtk+q011gfTpMq0VMa/ow1BF
         UTXui/Wo1VoT3beVVXDVmXkcbdiBDo974YDQDgdZNJhegCx1gp5drevjrKSaGbAivAv6
         fk1w==
X-Gm-Message-State: AOJu0Yz8t0ZcXq+IQkF0FYP80ELs8+2K7uTtBABYYDWa9isnoW2sFGL/
        vGC4MVle1TfhVXoXTh5iOGqF+qOSU0PfFA==
X-Google-Smtp-Source: AGHT+IFDrcTevAMTdK5aY6ZCZm5tMFx5J7z5a1aKvWzleHwEj72AE5vypmyjwIltbbArECOAHx0hRe9bNnWWtw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:cf51:0:b0:db7:dce9:76d6 with SMTP id
 f78-20020a25cf51000000b00db7dce976d6mr189881ybg.2.1701734338283; Mon, 04 Dec
 2023 15:58:58 -0800 (PST)
Date:   Mon, 4 Dec 2023 23:58:56 +0000
In-Reply-To: <CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
 <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
 <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
 <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
 <CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com> <CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com>
Message-ID: <20231204235856.k4izppfsrpg2rng7@google.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:49:01PM -0800, Yosry Ahmed wrote:
[...]
> 
> From 19af26e01f93cbf0806d75a234b78e48c1ce9d80 Mon Sep 17 00:00:00 2001
> From: Yosry Ahmed <yosryahmed@google.com>
> Date: Mon, 4 Dec 2023 23:43:29 +0000
> Subject: [PATCH] mm: memcg: remove stats flushing mutex
> 
> The mutex was intended to make the waiters sleep instead of spin, and
> such that we can check the update thresholds again after acquiring the
> mutex. However, the mutex has a risk of priority inversion, especially
> since the underlying rstat lock can de dropped while the mutex is held.
> 
> Synthetic testing with high concurrency of flushers shows no
> regressions without the mutex, so remove it.
> 
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

