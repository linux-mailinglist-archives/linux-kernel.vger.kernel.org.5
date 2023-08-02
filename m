Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B037076C81E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjHBIMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjHBIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:12:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CA10F5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:12:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcd6c0282so985067966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690963950; x=1691568750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbfWfMV50AarvWD5inw6HeTT4LJutE3Rh+ubSQUN7nw=;
        b=A7CXYSrzdB5JXUD+7TCbtjYXqsDsijx1Qdih2Ww0e826+V/wI+JeaBTYRRV/cOs7yL
         15UHOQr5FA1Sx0dmaVxVTdw+klq5kFNneo6tqFVCNM4hFZLZCKgk2utxHXdGIvlPgZLa
         3dEZUaL+11e8wHIVj5u5stdyVVQM22KYzS/H4AYYeyTqrtkdVY76SxyKBSvcEEXB2sJu
         QUE2bQoTGJXp4/Gw1pzCfyUMM8pEEBvcN/Xg3y3sJrL56Me5G8XV4GI9Auc269FYZD4V
         0WwHsAbVbENXuGd6QRWFeGdXWdSGTGshDHcFjYRwqbkvlUFwGwJKWgwsXKuxzbI0+hWa
         Iecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963950; x=1691568750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbfWfMV50AarvWD5inw6HeTT4LJutE3Rh+ubSQUN7nw=;
        b=fLSe0+Rj+20L0ju8EPfgG6Zbpc1FsY+TUozaDdpjvbzU9ThVUgqKFrY/CA3kkMHq1D
         eYIywfet9Q/45gHPZLrtvT4C3e0CX6c1yDHqG34ent6iav+XqksPJQAQfFDs06HErUFP
         3fqA4FRA0mE45f61e86tq4jDjObwsslIXhLPWjVUZh729/ykpW6utkNC+LsO1+nhGAl2
         djq/ytJN5/mu9XazTY9Oge3liAlgYLitP5yqzDk0JR5mYMCJofSDQOUqdR+50JZiy01P
         wrvH7CFnmiMYbQ5pRCLeMLAbyi2Zi9rql/viZB160tGjuPYvQkJl6sWkR3bqRV2BQW36
         QNUw==
X-Gm-Message-State: ABy/qLY7UBQiVqXUI+5InyuLxMl5E2QSVZ+L6CVNjx/zpnYl5ednx9zI
        quTTik5YxdboQ8peKycGpEpf89sAoJW/vShkMHvkPg==
X-Google-Smtp-Source: APBJJlH17ZJkr9XN41pMawh6L7L6NKX+Z1Ok4kwtDpQPfUYS94l+Xz6GAxuT+FR3wt51KLj2CMrhDx7WzA1fFAo+guk=
X-Received: by 2002:a17:907:7618:b0:977:ecff:3367 with SMTP id
 jx24-20020a170907761800b00977ecff3367mr4685802ejc.40.1690963949700; Wed, 02
 Aug 2023 01:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230726153223.821757-1-yosryahmed@google.com>
 <20230726153223.821757-2-yosryahmed@google.com> <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
 <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
 <CAJD7tkbZi16w4mYngVK8qA84FMijmHvwzMjHfrJiCsV=WjixOA@mail.gmail.com> <ZMoIYLwITUZzXp4C@dhcp22.suse.cz>
In-Reply-To: <ZMoIYLwITUZzXp4C@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 2 Aug 2023 01:11:53 -0700
Message-ID: <CAJD7tkY4hTTCfqSGa_XexbH=WSTJ4WXWeMXSU+6KW8qfr7agfQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: use rstat for non-hierarchical stats
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 12:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 01-08-23 10:29:39, Yosry Ahmed wrote:
> > On Tue, Aug 1, 2023 at 9:39=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> [...]
> > > > Have you measured any potential regression for cgroup v2 which coll=
ects
> > > > all this data without ever using it (AFAICS)?
> > >
> > > I did not. I did not expect noticeable regressions given that all the
> > > extra work is done during flushing, which should mostly be done by th=
e
> > > asynchronous worker, but can also happen in the stats reading context=
.
> > > Let me run the same script on cgroup v2 just in case and report back.
> >
> > A few runs on mm-unstable with this patch:
> >
> > # time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
>
> Is this really representative test to make? I would have expected the
> overhead would be mostly in mem_cgroup_css_rstat_flush (if it is visible
> at all of course). This would be more likely visible in all cpus busy
> situation (you can try heavy parallel kernel build from tmpfs for
> example).


I see. You are more worried about asynchronous flushing eating cpu
time rather than the synchronous flushing being slower. In fact, my
test is actually not representative at all because probably most of
the cgroups either do not have updates or the asynchronous flusher got
to them first.

Let me try a workload that is more parallel & cpu intensive and report
back. I am thinking of parallel reclaim/refault loops since both
reclaim and refault paths invoke stat updates and stat flushing.

>
> [...]
>
> > It looks like there are no regressions on cgroup v2 when reading the
> > stats. Please let me know if you want me to send a new version with
> > the cgroup v2 results as well in the commit log -- or I can just send
> > a new commit log. Whatever is easier for Andrew.
>
> Updating the changelog should be good enough.
> --
> Michal Hocko
> SUSE Labs
