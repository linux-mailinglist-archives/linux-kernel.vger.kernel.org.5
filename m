Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBC7D0883
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbjJTGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbjJTGbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:31:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F1BD49
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:31:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso122515ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697783500; x=1698388300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qeeYz5V48ireqFEi+ywjuz8ashXtpLODjwuWX4lfJE=;
        b=AmGgd8Dv//R+QfIGgm1xNuknYwDcjvJ/g4koRbyZHiNSyeNx878n4s+/lo9As/iMRT
         8JOA0ufseATQa2n/jGH7UCEUaBvI4Laf6lP0YX5I+tTej1vI0aiEE4hbDtCxXJ2N+K9M
         2Oc1/9ex8rABgdCHep4Rrpvc8n1WZFlsjejsHHNfB30r1DTyyqEiW1F1UTgZS3CY5res
         iD0pJC+eS29SXHrLzY0sXubw3nKU67sSSfTpqrhANkqAqsXVxtNe3xhGbpeyIN2btq1K
         5+YfPjZPS3pqs6V4hPA2sbOmuRtlD55DMwpsw1ydMime0EmDkLVxVt6euj5/m5SuOFZo
         z6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697783500; x=1698388300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qeeYz5V48ireqFEi+ywjuz8ashXtpLODjwuWX4lfJE=;
        b=xRJR7G27cpEq67js8lqPpIqLpom0+jiP4v2AvU4NNuZZRkzOFXPjaGjLjynYvho59y
         NyLE1+luZZhVn+CZ2UbKZicL4BfbcEj6GCro/zs4h2/kvKh/tl+HRUNhlKR49MPQAYoU
         GpNoak5Zapo7Psek2RwjaeOyDxHglgztC+JQEOGEVyYcjEz6JwIOzj4y6Cm0uyWuYUL4
         kGU5ytXS1o9pBG2JPm2VJfKYQ3xsqBXl1k25SL5bjU4z+sIFyWcu6ft7rqWCqqMOJrVD
         g3Y3OOgXS9ZYJiy5e2EMH/bwH8aMvXf5oH/OuwaafLqIIPxq8ZMv34Q5vrGKKMXrAgc2
         nZZg==
X-Gm-Message-State: AOJu0Yx6chyVIMDD0wpLhFdC6A/8dXgwSltTY4TA1lbSvypO+tVof7TA
        DOcg32RswBbWR4ZEQGzjcChObwoIUHYa1xtAa5dDJg==
X-Google-Smtp-Source: AGHT+IEV87PSEZnNQs7z3oFbyuV1txN/MwORzwAyr5f2vLqQcxrpEiA3daUgZkoV+qaBa67byOF4TwXuDZEG8DKfJoE=
X-Received: by 2002:a17:903:8c4:b0:1c9:e53b:4099 with SMTP id
 lk4-20020a17090308c400b001c9e53b4099mr147617plb.8.1697783495364; Thu, 19 Oct
 2023 23:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231019225346.1822282-1-roman.gushchin@linux.dev> <20231019225346.1822282-7-roman.gushchin@linux.dev>
In-Reply-To: <20231019225346.1822282-7-roman.gushchin@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Oct 2023 23:31:23 -0700
Message-ID: <CALvZod4EWoH7HGMWU+f6svP9gjDUh==GUS3GuD7CxhnB+mq9wA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: kmem: reimplement get_obj_cgroup_from_current()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 3:54=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Reimplement get_obj_cgroup_from_current() using current_obj_cgroup().
> get_obj_cgroup_from_current() and current_obj_cgroup() share 80% of
> the code, so the new implementation is almost trivial.
>
> get_obj_cgroup_from_current() is a convenient function used by the
> bpf subsystem, so there is no reason to get rid of it completely.
>
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeelb@google.com>
