Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61649807A33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379635AbjLFVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLFVOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:14:06 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EBD5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:14:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso25944366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701897251; x=1702502051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmJEDBzKxyQU9MCwcJin0j3ArzElELYr7Bhn9rZHDMc=;
        b=HLsQjd6is8o1mLTgKgynRGGnavRhRCjDYmyDeS5fOmPhbbkV9ieLR5oyJDZ4JH1Bhy
         /tdnLN41SfG+6hv1kSIQtl2/t8Lt0/lGUjlFdZCO0K8CH5gAMqEkYpDn4doFV7eGr3/w
         5Iq9imXpSmWj5cVoPhnxliChrNdI3fySwk5P/ql2pEWIfhDapvUiIG/N9Ru0uCocL2rh
         31v7cCkSPZkmolPrPZcJBnxCPe5IhGJsWg8UhTwTW3L1VeKPUV9y0/U8e14fufjLFYc2
         WuoCQ+yldbFB+Y+CLSR4rnLG55r+4sOrbcDDimqxZk+WW34JOZ9lcWmPw5/W6AtZrz54
         v8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897251; x=1702502051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmJEDBzKxyQU9MCwcJin0j3ArzElELYr7Bhn9rZHDMc=;
        b=R1r1g8MZcW2M/Wq5kM+JscBFVfGJa+jFekc2TwLfES3ZlUiNuip3vLWIz0aKUJtsrT
         o2SOvFMM/bTRb7cWQO+2aZi/zhmZ+3Vvcy+iwwQJK0205oeGLxgLuFsSUX7GhEGXqaYp
         ydGdFrHzylruycOCXaVcRf0kV9q+ZObsA6f2QSfyPthVx1tGfPn6+mziMk0WA1oXiQwW
         WDIIRfdqr/G6qTqVgvj780REBRdkq8gO3hJc3h2WSDoPOtd+ggePtFUBmdwUy/Ff8CBy
         n6oF/NA+CsPif4+7EaXQraKdPITe+8cS2o6YESA1gThgn8GBbJhVRqXvMcIHP3Qlwsou
         5OBQ==
X-Gm-Message-State: AOJu0YyCMnft2LC4pENruIwFBfmZ/0RAjMHn/kcqnp1z3kwwC02gDPuN
        FPfPDO44vxK9AYnpxEosqX+T/fo+1NYN2lQoA/jIIg==
X-Google-Smtp-Source: AGHT+IGdUJ0U7LGEKJjGqt5itynfcSrlXa/hzW69+tBQz3ZKJeFsQ9wcSARFzKG7Hzt4JesxN71jS11/3dhzFfPH9sA=
X-Received: by 2002:a17:906:3518:b0:a19:a19b:78b1 with SMTP id
 r24-20020a170906351800b00a19a19b78b1mr730768eja.116.1701897251403; Wed, 06
 Dec 2023 13:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev> <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
 <CAKEwX=M8YThH8qOdHt5TV1E4PCiw2FSv7815O3fhqXNVMt5ezg@mail.gmail.com> <CAKEwX=OkZsPiv-A3Rg7Wh2TKcf0aKd-1Yi9wRyEzJK6o9=zXQA@mail.gmail.com>
In-Reply-To: <CAKEwX=OkZsPiv-A3Rg7Wh2TKcf0aKd-1Yi9wRyEzJK6o9=zXQA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 6 Dec 2023 13:13:35 -0800
Message-ID: <CAJD7tkZb71Tr=se96hrtEWc5oXXwdYOLMayNkkiP1ymcKBjNig@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Chengming Zhou <chengming.zhou@linux.dev>,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 11:47=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> [...]
> >
> > Hmm so how should we proceed from here? How about this:
> >
> > a) I can send a fixlet to move the enablement check above the stats
> > flushing + use mem_cgroup_flush_stats
> > b) Then maybe, you can send a fixlet to update this new callsite?
> >
> > Does that sound reasonable?
>
> I just sent out the fixlet. Yosry and Chengming, let me know if that
> looks good. Thank you both for detecting this issue and proposing the
> fix!

The fixlet looks good, and Andrew already took care of (b) before I
could send a followup fixlet out :)
