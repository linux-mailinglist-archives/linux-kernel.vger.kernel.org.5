Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17945784672
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjHVQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjHVQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:00:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CC2BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:00:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a19bf6ab66so260486666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692720043; x=1693324843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rWz75d47k1ZaMKSZ8edfmuuQmWRaz5rkymhn45IF0k=;
        b=15DCdBwX9G07pujOr3Nbx+i2bQ13Rphta48yDKVMfOIAUrZfp2m22HFbnXuC7Oprxc
         42lqBtGWYqaLduCFwdCo1FynweYmtDURInMRPCUhGUVgu5oG6stOtXegP48Q3A1ICaKY
         mLXJqLzKp6NFvac+PoOcfeHDT0Ie8vy0eeyyqIA1UQwwnJr8+OV0+tZwBa6fFKNNajbx
         /R3v6DMUGqUbo0C/VZjwBMI/FVX+Kt7H3Q/NXSv6GsmwHD3pN0N2pSB8V2M4uwhGCThg
         5KSOGPPN5e+K+6w4K5ICQ5i34gRorsUI8RcNwjR34ZQoyFdkIT0jWtcp9wAs94exiQYO
         Zklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720043; x=1693324843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rWz75d47k1ZaMKSZ8edfmuuQmWRaz5rkymhn45IF0k=;
        b=VOKcKsIwT14nbCwV7oJHQc+PNrKHfkislDpaZaEJPGPVrxSxTeYHTU1NwXxh3wzPc0
         Nzxzjs6L/pYrDjpXrhftkpZgZAyLcn2nQ8TM8TjQnfsI+dUoUiWDd4jB7I4+qDOt6Dw/
         Z3FLve/jhNFXSQ3B0dMHnbqQccrhqcaEJTAByKnBbB7DmuW4+gdk1m/fXtxutRCY2i+v
         Iz/Gk+AqMtoTZGBEhC0TDFHz+YUIZG2xpCKMMfUqnLtVfUAuLUOz5fPHZGNO+ZGH256s
         eC6F6VrnLbz9jZPakx+nfpTAn7q0lX5MENPrN8iU268JfrV0fqZ5pUpGvfZhcrsepuY3
         d+9g==
X-Gm-Message-State: AOJu0YzhcTRBGXwlrpY8zyhXk4Ellxy06HHCRNOQx5/+SEu+EF0Qy+bT
        wxLXJEUXGx7czZgK6YCgjrnZbQW5Dw4ygcnGl1z2bQ==
X-Google-Smtp-Source: AGHT+IEt/X5C1XEK0W3JF+CDHSqXvExt9Z0Cc0UCTv1JvWTAaDy2qDS+2xdx2UgqhZArlLDuCUYZ3r87ssJ2HmPdBKI=
X-Received: by 2002:a17:906:32d3:b0:9a1:8a54:145f with SMTP id
 k19-20020a17090632d300b009a18a54145fmr5088359ejk.40.1692720042815; Tue, 22
 Aug 2023 09:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-3-yosryahmed@google.com> <y7vvyndehadwy5ouounm5oyo52bqhsysiizuphzki2h3bwpdpc@3hvaq6sp6f4k>
In-Reply-To: <y7vvyndehadwy5ouounm5oyo52bqhsysiizuphzki2h3bwpdpc@3hvaq6sp6f4k>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 22 Aug 2023 09:00:06 -0700
Message-ID: <CAJD7tkaVuiMU-ifJiyH5d_W1hi9DnAymYJxzBxEKCVX+tU=OCA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: memcg: add a helper for non-unified stats flushing
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 22, 2023 at 6:01=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Aug 21, 2023 at 08:54:57PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > +static void do_stats_flush(struct mem_cgroup *memcg)
> > +{
> > +     cgroup_rstat_flush(memcg->css.cgroup);
>         if(memcg =3D=3D root_mem_cgroup)
>                 atomic_set(&stats_flush_threshold, 0);
> > +}
> > +
> >  /*
> >   * do_unified_stats_flush - do a unified flush of memory cgroup statis=
tics
> >   *
> > @@ -656,7 +667,7 @@ static void do_unified_stats_flush(void)
> >
> >       WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> >
> > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> > +     do_stats_flush(root_mem_cgroup);
> >
>   -     atomic_set(&stats_flush_threshold, 0);
> >       atomic_set(&stats_flush_ongoing, 0);
>
> You may reset stats_flush_threshold to save the unified flushers some
> work.

We can probably also kick FLUSH_TIME forward as well. Perhaps I can
move both into do_stats_flush() then. If I understand correctly this
is what you mean?

static void do_stats_flush(struct mem_cgroup *memcg)
{
       if (mem_cgroup_is_root(memcg))
               WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);

       cgroup_rstat_flush(memcg->css.cgroup);

       if (mem_cgroup_is_root(memcg))
               atomic_set(&stats_flush_threshold, 0);
}

  static void do_unified_stats_flush(void)
  {
          if (atomic_read(&stats_flush_ongoing) ||
              atomic_xchg(&stats_flush_ongoing, 1))
                  return;

          do_stats_flush(root_mem_cgroup);
          atomic_set(&stats_flush_ongoing, 0);
  }

, or simplify it further by just resetting stats_flush_threshold
before we flush as well:

static void do_stats_flush(struct mem_cgroup *memcg)
{
       /* for unified flushing, root non-unified flushing can help as well =
*/
       if (mem_cgroup_is_root(memcg)) {
               WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
               atomic_set(&stats_flush_threshold, 0);
       }

       cgroup_rstat_flush(memcg->css.cgroup);
}

  static void do_unified_stats_flush(void)
  {
          if (atomic_read(&stats_flush_ongoing) ||
              atomic_xchg(&stats_flush_ongoing, 1))
                  return;

          do_stats_flush(root_mem_cgroup);
          atomic_set(&stats_flush_ongoing, 0);
  }


What do you think?
