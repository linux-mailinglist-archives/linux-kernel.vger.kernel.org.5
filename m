Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE07DBF88
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJ3SKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjJ3SKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:10:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780DC1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:10:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso738826966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698689418; x=1699294218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2d8Ze80/l8xhZWIXdh5kYVoTnRG5aBbLbFUQdcB14xY=;
        b=AAzIKv3ZABH9ABnOgXx/WlJS9sFvwmpgcHU/q2OL0D0AQdL25hypf6ZUabozGESxLn
         JI+OPK1dt9FJaZj12j9ol2H4nUBTK8aMSX3XSWjp2CiDcCxerobBmEWqMjgXxv+XKRnh
         ZZa63NeR5fG4ihakNlmHK/fvPoD+E6Gsy4FKXXkuKM7YfqHrnv9eF2n5/5GAUUIRTpPU
         YjD+8aDNv8+lEbyLB4gSDTL/FciscTm4uVl5jxGrnR/y41vkq9I9ZgYDJFl/xz1MyCEI
         XG+te9xZONDzFg+IWN188YCouukflYdMKLI+irU4M28uCwk5BglgSAMCpfFAe0tuOoBl
         cf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698689418; x=1699294218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2d8Ze80/l8xhZWIXdh5kYVoTnRG5aBbLbFUQdcB14xY=;
        b=VmmzK3ScoJvdG4EPEgmpsORyBKovrfIPG1oiJpjmeINJTO1vJTtVh+obEZ4SLmIzZg
         I/9VuHDR8dpUxtq0+l0ahuiyvMa1PsG8MKw+rOkmLnbJ2fQtY0eq4xe7cMKIkAEt4EOO
         gk9KEvkwxnvaSq+ROEPZjid87lbSw6gfTOiQrEGTjqSff2LmbJC0BUj5hIlR9e7TXEa4
         +b90TLl/fO6mL+Zauh1kWkI3jjLOmyBl0UY0mzTTx3z4hwKJXjsibOqR07ahHs36OsMZ
         431YO5qeMq0BhIEUUrnpEEUDvXLyOP3MQp5Gc3tTaXCvJlqF2vUBqJC7XUOLtooG2f7I
         gQog==
X-Gm-Message-State: AOJu0YwzZOzv5YdW9BgczXAsbwSidWW9qL/wh5mnsx2+bkJMM6fC03Ii
        nQvZqNLh/dIDhvBV971CA1/bJnE5v6H2dA2lF1G2Sw==
X-Google-Smtp-Source: AGHT+IGZKrl5mPtmgSXHHhvfTGHe7yQT3kXyL86uBVfedzx2WedG/vdGDMSszPP2v8GagU2lhc5ySgsfcBcgo9yjWIQ=
X-Received: by 2002:a17:907:3fa2:b0:9c6:1143:b73 with SMTP id
 hr34-20020a1709073fa200b009c611430b73mr9123495ejc.51.1698689418436; Mon, 30
 Oct 2023 11:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231024233501.2639043-1-nphamcs@gmail.com> <CAJD7tkZMn6x9Y2DZiNzSuM0TCvEGSoMp1q15=T3ENAFBtz1WuA@mail.gmail.com>
 <CAKEwX=PjGeqa_zLf6FV24iQLaH8EQ81HfKy3=e0fGrjZTvLiKw@mail.gmail.com>
In-Reply-To: <CAKEwX=PjGeqa_zLf6FV24iQLaH8EQ81HfKy3=e0fGrjZTvLiKw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 30 Oct 2023 11:09:40 -0700
Message-ID: <CAJD7tkaOZpKBF6wY86+RiX1Lvj-E-72sZiYLtYMvPWQq4a=WiQ@mail.gmail.com>
Subject: Re: [RFC PATCH] memcontrol: implement swap bypassing
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 1:27=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Oct 24, 2023 at 7:09=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Oct 24, 2023 at 4:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > During our experiment with zswap, we sometimes observe swap IOs due t=
o
> > > occasional zswap store failures and writebacks. These swapping IOs
> > > prevent many users who cannot tolerate swapping from adopting zswap t=
o
> > > save memory and improve performance where possible.
> > >
> > > This patch adds the option to bypass swap entirely: do not swap when =
an
> > > zswap store attempt fail, and do not write pages in the zswap pool ba=
ck
> > > to swap. The feature is disabled by default (to preserve the existing
> > > behavior), and can be enabled on a cgroup-basis via a new cgroup file=
.
> >
> > I think the word "bypass" here is fairly confusing because zswap is
> > considered as swap for all purposes, so we are not really bypassing
> > swap. I think it should be something like memory.swap.disk or
> > memory.swap.writeback or whatever the correct terminology is for
> > non-zswap swap (which I honestly don't know). Writing 0 to such an
> > interface would give the desired effect.
>
> I'm honestly not very good at naming things... especially a novel
> name that I cannot steal from a precedent...

Neither am I :)

>
> I want something that means "going to zswap is acceptable, but please
> don't go to slow swap". Hence, swap bypassing (swap in my mental
> model is the slow thing that is under zswap).
>
> (but I imagined memory.please.don't.go.to.slow.swap won't be very
> popular either...)
>
> memory.swap.disk is... acceptable, I guess? It technically could still be
> wrong, as there's still zram, but we can sort of ignore that special case=
.
> I still prefer memory.swap.bypass,  but I wouldn't be opposed to this
> renaming.
>
> Anyone with better naming suggestions should absolutely speak up!
> Otherwise, I'll send a v2 renaming this to "memory.swap.disk" or
> "memory.swap.disk_used"
>

Hoping someone else chimes in for the naming here, this is not going
to be changeable anytime soon.
