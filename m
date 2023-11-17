Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98717EF78A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjKQSr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:47:24 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F3EE6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:47:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso3052786a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700246841; x=1700851641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UYHVGwHTVzVuxM8RzUzotfpguJIJGc4DIOwNG3E4Vo=;
        b=ydMXmX9VI6EETb+u2Ct3ykw6onSgLSTBPV6I3Nt2+wRlL49TArtxz3b6kcaoczcOjC
         DEnoHWJrh5UxwFNs00zo68OkG3nWYAe2n49QMmevlccktsP1pBNgTfyPWdpn4BnQTJ+s
         Pu8SIQ53JQNAJ/txJv9+dOyzxaO3c2Fd8+LL37+ydyZ9Yojq3ae0PbAuuObdRM0UU+SK
         3ADVpAC6Hz1boPA4RASDtrMHR2U46wGPjQh+4oGheai6gZvPLuI2zVVuyWfmnOdaOgXL
         KSSGzHWC5AkBLf3lkMH7g/uc5pjXebyaQmBxp30Bx8NMkSQiPwfpC97FQqFmIZ7wVqMA
         TV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700246841; x=1700851641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UYHVGwHTVzVuxM8RzUzotfpguJIJGc4DIOwNG3E4Vo=;
        b=BkRnzG7mrSGUVRqDbWuaUrFuYMMN6ny2Hrfa0ICIkwq4qEr3jv/kmRSdR92tKIF2eW
         FNESTe1ioMWC++NSZA/Oo0oHxvTmArvamgjrCYvmKzwYXziHer/SNNSsB+0A1XMDex8C
         0zJNXP1vNX1JQX+D+g9qv/kGYMmFHmrRwzzB9Hz1lXyOIn5h31Jw8W+ttUCuq3mc3yxs
         GabcbWs6zkUhIkkFXmevd1r1tXx0UkOna460IGfNR0y1T5qmQ5fkgqmca+GBgySxXAe9
         /ayCyELArOuZEJ6tJ2KAh+VpSAc5gj+56s5CgRAVnazDjl/fBWpzoYWUJoIDwmPMGWwp
         jqOg==
X-Gm-Message-State: AOJu0YzwS85HDYIJkSgWuqNmAX+dEbhjK50wT8r9yVZkFEIT5GQAENTT
        5shyCbPzJwmTvhpwmpAbGn37KT9ZEnfaDA==
X-Google-Smtp-Source: AGHT+IELM4olyOpxFGTJoycJm0dmMIHlYYXJyWZCBmiWMx3xQe7D6wloetMKLDdP7EjqMkyPUX2yL468BKu59g==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a02:691:b0:5bd:bec3:316f with SMTP
 id ca17-20020a056a02069100b005bdbec3316fmr1467745pgb.11.1700246841320; Fri,
 17 Nov 2023 10:47:21 -0800 (PST)
Date:   Fri, 17 Nov 2023 18:47:19 +0000
In-Reply-To: <20231116022411.2250072-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com> <20231116022411.2250072-3-yosryahmed@google.com>
Message-ID: <20231117184719.2qz2ia6j7rlvq62o@google.com>
Subject: Re: [PATCH v3 2/5] mm: memcg: move vmstats structs definition above
 flushing code
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 02:24:07AM +0000, Yosry Ahmed wrote:
> The following patch will make use of those structs in the flushing code,
> so move their definitions (and a few other dependencies) a little bit up
> to reduce the diff noise in the following patch.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
