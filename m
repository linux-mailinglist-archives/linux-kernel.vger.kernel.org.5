Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330467B7212
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbjJCTwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbjJCTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:52:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FC9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:52:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a9f139cd94so226327266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362745; x=1696967545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sFl+PgZTi5H/tq/vNQ7bb3Je3y5ediHExPSrKbXhkc=;
        b=CsOg8lmfwb20B7jgUfoky+x/d1/98G3F0swyWTRo0DeAua3wcJ6eVsMvMfImKqxFdT
         /SFilhNc1g+cvBwvb1Zm3GQDhBYprjMolgvaH2Y/OYGNmNxlwMcmcqqz2qAvot3QZviN
         F9cUE8NRKBc8ADzY29gmk9QicOmsiYEo9ent+RHhiTj7px7t6pAMkN3UoCZvAJfl6ng5
         onjCbLSs822+ugASUMv9fnELURL4O1ZiGuDTslzo3fgAsC1i4JAjlP3i3UnsUsIjX52A
         J1qCfc5Yx0I2KIKy4EIr14BWGaValdxLBifBYvZU8Rl3yXJJGfHuLwTs1NvTpB+RGhnu
         TEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362745; x=1696967545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sFl+PgZTi5H/tq/vNQ7bb3Je3y5ediHExPSrKbXhkc=;
        b=c2k6umIycizolxoTQV7SeoP/MNkPdcMclgHa2etEPS0VsDvikazyoG2DP7nJplqKOs
         ywrIw84uQyZJrVbETNwPqaAYUaI6nPy+Cy83z/HIpIb3gUeu//GMt04yrpW2Vz1KzV2s
         OnjH0IA2kDZnN/Fs+0K/S9/dz4n4oqIJI/OdFoviQrwZdNAB1hngFp3w6Jq3V3iSyR7M
         6/Gkcyg+wIvIW7nKwsyj3NcDIsAANr8nx87nG5gqdL33fCc8qxrUja/m3MuszPWsrnCN
         GTuFymleNZ+ba5vlmmarPJSdqcVn3p/TTKv2mGebSjkwKBFtMrTSi3CZcJoBnUPyQ0yk
         G44A==
X-Gm-Message-State: AOJu0Yz+2a0KcXV0phP+N/NE8qLosyiY/rtn9l/4Pjmv2wTX16n1A5u2
        JUxCrEJPmm0ilTUo8hseLnghqV1oK7RurssgVyXYsw==
X-Google-Smtp-Source: AGHT+IGwxXJCirR+VKpaM868xSVnDoCsjqHYCyDOfreMvQLZ/FRz2tiYTixuwDIhUm7h8JfAE1H/9yRjEIZvuJoTeL4=
X-Received: by 2002:a17:906:8465:b0:9ae:6bef:4a54 with SMTP id
 hx5-20020a170906846500b009ae6bef4a54mr166358ejc.3.1696362744926; Tue, 03 Oct
 2023 12:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-3-yosryahmed@google.com> <qejogc2nxbcekhujsh56zlyqssgxolf7vboxwyr7dk7zjznhzy@yt7bqkxefjyp>
In-Reply-To: <qejogc2nxbcekhujsh56zlyqssgxolf7vboxwyr7dk7zjznhzy@yt7bqkxefjyp>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 3 Oct 2023 12:51:49 -0700
Message-ID: <CAJD7tkbsgDxTYED8Yp3DJ8e552Zou+DVEutHsr2PLXssm-V9YA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: memcg: normalize the value passed into memcg_rstat_updated()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 11:22=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Fri, Sep 22, 2023 at 05:57:40PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > memcg_rstat_updated() uses the value of the state update to keep track
> > of the magnitude of pending updates, so that we only do a stats flush
> > when it's worth the work. Most values passed into memcg_rstat_updated()
> > are in pages, however, a few of them are actually in bytes or KBs.
> >
> > To put this into perspective, a 512 byte slab allocation today would
> > look the same as allocating 512 pages. This may result in premature
> > flushes, which means unnecessary work and latency.
> >
> > Normalize all the state values passed into memcg_rstat_updated() to
> > pages.
>
> I've dreamed about such normalization since error estimates were
> introduced :-)
>
> (As touched in the previous patch) it makes me wonder whether it makes
> sense to add up state and event counters (apples and oranges).

I conceptually agree that we are adding apples and oranges, but in
practice if you look at memcg_vm_event_stat, most stat updates
correspond to 1 page worth of something. I am guessing the implicit
assumption here is that event updates correspond roughly to page-sized
state updates. It's not perfect, but perhaps it's acceptable.

>
> Shouldn't with this approach events: a) have a separate counter, b)
> wight with zero and rely on time-based flushing only?

(a) If we have separate counters we need to eventually sum them to
figure out if the total magnitude of pending updates is worth flushing
anyway, right?
(b) I would be more nervous to rely on time-based flushing only as I
don't know how this can affect workloads.

>
> Thanks,
> Michal
