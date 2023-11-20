Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA37F1CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjKTSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjKTSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:53:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F1C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:53:07 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so83964266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700506386; x=1701111186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CBhC1m0OhsuzwJIA2sP5RLtq30X0JjG4f15SHsDupg=;
        b=1VYh8PRsnpa+tRsrWdJOj0O9M5QlZEdSm0fA9bAJUQi8zXYJdebGSyayU8GyNH6yFW
         NXqMCf30ok6wmRjTFPApaT0B2FkVBzbMC6qUv1hwt6eojcDtRyf0Sc6pff522wwTHK+M
         dYMJ8x9u3JK2b2X3ZiJABPrBMaXLrK8s0uxv+0c6IEIcQ1mfslWkaQBhvYG9J5Xw8Nm7
         QZSPTIZvyQxJ1uhi4RhVORycUKZPyftskEoxVP7I+SAUTU1qdBIxpzqVFsqiqiywI5gy
         GWsYFLkNiZhu+vBSVcOxQyBltcHLtaVPjODkUaDUp/OQxWiWkmN3FLR4n1gqEciLA3r1
         Rr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700506386; x=1701111186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CBhC1m0OhsuzwJIA2sP5RLtq30X0JjG4f15SHsDupg=;
        b=xGEKC8SXLGksAkl650eICcax4G9VbpbuT7JXyDFK1p+bR5DxjFsW/drJML33CneKKf
         hERtqtIKh15szspL+1ODKZdhWzm6LBV5Cfze+Q/WF6wuZufSoJqE7N+RGLJDcBX2Yur+
         j7K8sPhtNqk4gyofGUpuQV2BnXOS5aQ3PSExnACBKe58Ci66ghMaIQUqDsz+bHKnQPHA
         2tODBkuGcmn0OgFlmuDn3OlPa6br5b3e+bpdfz7DFb0AR+ek01FwZIovWc0sX8EOhz/x
         DhBlvaU6JjbkS+n2gHw0VIBKW+YU8DJDke8e+I/vvZsIuUBQeQvSqtWdbSaNkaAlxeLe
         zdMg==
X-Gm-Message-State: AOJu0Ywc5oCciXdznxckjV1uStQT62dlTXtcHroAUqSuQwu/AZK/BLNj
        Ru1iQ3tOgYOye3zudIDW6BCiowrfgWYnzjPJlsu84gjf8leLr+l/pnPC7FaV
X-Google-Smtp-Source: AGHT+IFgxqrtHRBfQhtaT65udIR9IUe1v9BKLhGOQFwasQm69jVp7/yuqde7t4blz4WxygyCw6vdNKG6xTKPO86+yM4=
X-Received: by 2002:a17:906:52c1:b0:9dd:d85e:b23f with SMTP id
 w1-20020a17090652c100b009ddd85eb23fmr5763192ejn.67.1700506385805; Mon, 20 Nov
 2023 10:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com> <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 20 Nov 2023 10:52:25 -0800
Message-ID: <CAJD7tkbfjhC8SHZ=KspVfrTECZyY8BYrPGcLVLJcJRwXXdYDrw@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Chris Li <chriscli@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chriscli@google.com> writes:
>
> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> >>
> >> Not bypassing the swap slot cache, just make the callbacks to
> >> invalidate the zswap entry, do memg uncharging, etc when the slot is
> >> no longer used and is entering the swap slot cache (i.e. when
> >> free_swap_slot() is called), instead of when draining the swap slot
> >> cache (i.e. when swap_range_free() is called). For all parts of MM
> >> outside of swap, the swap entry is freed when free_swap_slot() is
> >> called. We don't free it immediately because of caching, but this
> >> should be transparent to other parts of MM (e.g. zswap, memcg, etc).
> >
> > That will cancel the batching effect on the swap slot free, making the
> > common case for  swapping  faults take longer to complete, righ?
> > If I recall correctly, the uncharge is the expensive part of the swap
> > slot free operation.
> > I just want to figure out what we are trading off against. This is not
> > one side wins all situations.
>
> Per my understanding, we don't batch memcg uncharging in
> swap_entry_free() now.  Although it's possible and may improve
> performance.

Yes. It actually causes a long tail in swapin fault latency as Chris
discovered in our prod. I am wondering if doing the memcg uncharging
outside the slots cache will actually amortize the cost instead.

Regardless of memcg charging, which is more complicated, I think we
should at least move the call to zswap_invalidate() before the slots
cache. I would prefer that we move everything non-swapfile specific
outside the slots cache layer (zswap_invalidate(),
arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
mem_cgroup_uncharge_swap(), ..).  However, if some of those are
controversial, we can move some of them for now.

When draining free swap slots from the cache, swap_range_free() is
called with nr_entries =3D=3D 1 anyway, so I can't see how any batching is
going on. If anything it should help amortize the cost.

>
> --
> Best Regards,
> Huang, Ying
