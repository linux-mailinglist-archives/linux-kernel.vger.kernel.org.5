Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2176771C69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHGIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHGIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:39:49 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CE210EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:39:48 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-48719854eb9so1218927e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691397587; x=1692002387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPzZTlICzLYEHMNh2iGs7nTLC2Ztxao8NLG8OMNUOK0=;
        b=FM53P8h7ve9is3BOG/5+xvjnPTfH5lB0YQcOp3ZovLoZKpjTgwypoT9loSaVciRU4V
         +P0bzq1sFOpMZCn66RaRdve2DTdRn47tBO+7nlmCcY7GHBV96ISMSWhef3k26Gy7Mcfp
         AqPBxGhncfT8VH91Y+JagWTYuQ+veYPbZI1I0kXUjF8HRs8A8cD/1znwNCoZNE3rDJ4l
         7zGtBVY7Ah+t38pnjZF+B8oVo+FKOd7cKl/UYgEfvo3HLpy2KDJcUikhuPtVIDJ8pJK9
         JMC0L15Snj6ToehTMzpjJaAg31eQy9LLS48Q4RRn8rFMBrLMztV7efxHsC9EzXRSkEkl
         1Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691397587; x=1692002387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPzZTlICzLYEHMNh2iGs7nTLC2Ztxao8NLG8OMNUOK0=;
        b=HhWo/pDAayF+DMzXy3CCXmfxvYQiEIjhfu6YybAsIouMWCh8lrv6PCZvhvNTgCw0tJ
         Cguw4PdOIrhnMTZxLq0/93VO5rGg5rBN/J2pBodQHxIh88V/H1QxX8BPHWri+ZmVvJBr
         6QBxT0uL5S+zCr4EIJTu2+HbJiMt3qoNy4SLTPCQ9m4JQjyw5K7DeHtX+3YMyBJgA2ad
         V/HdjybdBhTYEScKCdkiEKckJn+kJxp+GYLUWcvhqZyPssfs8wM3X7EjZ+qMffHI8Eja
         FkyaY9CMsZTZjAD6j/7FuDctXTTuj35ZjryZLC7F+Nm1s6ggQvPPzJ43GIHmtX2I0sBd
         Vj7A==
X-Gm-Message-State: AOJu0YzMIBbzlsDAoQBqqxZaH8+iVN29nvmAX1nQNl7T07NOA15Y32av
        k0qodDadSMeCvqhKTnMj6SfXS3JSnwVS2VsJmCo=
X-Google-Smtp-Source: AGHT+IHL5u3t52XLQEfHjY0HO8ytpXExG0xmtQIZn6rLE5AItd5HTGIYn8AxhWWp1BT4sRC/YFbTfh8JxD1CjlWRyQs=
X-Received: by 2002:a1f:3d95:0:b0:485:e984:779e with SMTP id
 k143-20020a1f3d95000000b00485e984779emr3965774vka.2.1691397587074; Mon, 07
 Aug 2023 01:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230723190906.4082646-1-42.hyeyoo@gmail.com> <20230723190906.4082646-3-42.hyeyoo@gmail.com>
 <1f88aff2-8027-1020-71b2-6a6528f82207@suse.cz>
In-Reply-To: <1f88aff2-8027-1020-71b2-6a6528f82207@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Mon, 7 Aug 2023 17:39:35 +0900
Message-ID: <CAB=+i9R52jLzD9eAMxhRTMHTFDmAGPDPcD0pwCxxDwq5yFZbxQ@mail.gmail.com>
Subject: Re: [RFC 2/2] mm/slub: prefer NUMA locality over slight memory saving
 on NUMA machines
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Binder Makin <merimus@google.com>, aneesh.kumar@linux.ibm.com,
        tsahu@linux.ibm.com, piyushs@linux.ibm.com, fengwei.yin@intel.com,
        ying.huang@intel.com, lkp <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:54=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/23/23 21:09, Hyeonggon Yoo wrote:
> > By default, SLUB sets remote_node_defrag_ratio to 1000, which makes it
> > (in most cases) take slabs from remote nodes first before trying alloca=
ting
> > new folios on the local node from buddy.
> >
> > Documentation/ABI/testing/sysfs-kernel-slab says:
> >> The file remote_node_defrag_ratio specifies the percentage of
> >> times SLUB will attempt to refill the cpu slab with a partial
> >> slab from a remote node as opposed to allocating a new slab on
> >> the local node.  This reduces the amount of wasted memory over
> >> the entire system but can be expensive.
> >
> > Although this made sense when it was introduced, the portion of
> > per node partial lists in the overall SLUB memory usage has been decrea=
sed
> > since the introduction of per cpu partial lists. Therefore, it's worth
> > reevaluating its overhead on performance and memory usage.
> >
> > [
> >       XXX: Add performance data. I tried to measure its impact on
> >       hackbench with a 2 socket NUMA  machine. but it seems hackbench i=
s
> >       too synthetic to benefit from this, because the skbuff_head_cache=
's
> >       size fits into the last level cache.
> >
> >       Probably more realistic workloads like netperf would benefit
> >       from this?
> > ]
> >
> > Set remote_node_defrag_ratio to zero by default, and the new behavior i=
s:
> >       1) try refilling per CPU partial list from the local node
> >       2) try allocating new slabs from the local node without reclamati=
on
> >       3) try refilling per CPU partial list from remote nodes
> >       4) try allocating new slabs from the local node or remote nodes
> >
> > If user specified remote_node_defrag_ratio, it probabilistically tries
> > 3) first and then try 2) and 4) in order, to avoid unexpected behaviora=
l
> > change from user's perspective.
>
> It makes sense to me, but as you note it would be great to demonstrate
> benefits, because it adds complexity, especially in the already complex
> ___slab_alloc(). Networking has been indeed historically a workload very
> sensitive to slab performance, so seems a good candidate.

Thank you for looking at it!

Yeah, it was a PoC for what I thought "oh, it might be useful"
and definitely I will try to measure it.

> We could also postpone this until we have tried the percpu arrays
> improvements discussed at LSF/MM.

Possibly, but can you please share your plans/opinions on it?
I think one possible way is simply to allow the cpu freelist to be
mixed by objects from different slabs
if we want to minimize changes, Or introduce a per cpu array similar
to what SLAB does now.

And one thing I'm having difficulty understanding is - what is the
mind behind/or impact of managing objects
on a slab basis, other than avoiding array queues in 2007?
