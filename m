Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628C07D3C08
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjJWQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjJWQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:16:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10989110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:16:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d3c886671so3008733a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077804; x=1698682604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgO08PRy6IyNU2zj7g2IPBwXTxM3jF14s2Iin9hZx7o=;
        b=TWO10BX8fal2h2C4AcHEq8pw5BoMGvrFJvVAOac20KBLU5mIXadL2iSpeLcPYXyuAY
         BeQSc1/QKn0ONgIUUWkHjk8xniwkD388RMCbUj6MqsbB/z0oHgw6vppl4AkLYIGCnzLB
         7YSt31Kqxe2V/TRcPn5J9oHEUV8Rm5orX0yDOxrMf1iUmpnaF6xacx2dVRnt8NsaO2B9
         eNA3fHtsFM0+GaVGPD39xzJ22ZlLUrXHlo/yKMcfR7Mv0afkxMAdCnIb1aComDWhyFKj
         HQ63S8RddW2IcY4bhWz8TPKeaW2WFqR9GjbOIgVHs98DYVAPsIDqAJhAyu8YpKpMq80Q
         5/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077804; x=1698682604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgO08PRy6IyNU2zj7g2IPBwXTxM3jF14s2Iin9hZx7o=;
        b=bv832SCWz1xBWJxft5YbCisJuaPDoVyvzlTVh9LsmO7uhbrVTZq7m96y+XBK79pRo5
         dbHA+9zruHY3YNk5BYegWxyPbq6jd6xvwuQSppj3ykmfP9X/aEp6esAD1sWqinEDxxk6
         VjmQiRClWjsiXs2bLR1Vro3bksbIWvcU1St+JUPK/3OtCpcearCkDEzOCD+v8GayQTY8
         rCyqDq3McXuwmW2hyWhV01vaMv6oyY19+SW6H9X9ZQ4gmZOBxIMuTD1ji9etPmxaOqNX
         E4VU1TrmE7Av62Y9JKIENJySCoF7fRDnQHfeeZMLwjmSPLN+7+SUe6axtnyS+pzOAkbW
         6mOQ==
X-Gm-Message-State: AOJu0YzNo58kTComn5Tq4tWYxbZNT8cIYy4nKdVzerWPGhNwXPcd3efk
        n25gFqLAC4MauDBa41FbDFIy/RAHKT54oDLmiqo7hZHJtd4=
X-Google-Smtp-Source: AGHT+IHU8vWzMm3Qu76s5FUntH87DK+b9fMCqsfGw9STYJqnf7wjxC7ijlxvgKyRU4gMl6MQp2SUfOD5j06vnDV1260=
X-Received: by 2002:a17:90a:195b:b0:27c:f845:3e3f with SMTP id
 27-20020a17090a195b00b0027cf8453e3fmr9585255pjh.1.1698077804386; Mon, 23 Oct
 2023 09:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <bbf482643e882f9f870d80cb35342c61955ea291.1694625260.git.andreyknvl@google.com>
 <CAG_fn=VspORKG5+xdkmnULq3C64mWCb-XGDvnV9htayf5CL-PQ@mail.gmail.com>
In-Reply-To: <CAG_fn=VspORKG5+xdkmnULq3C64mWCb-XGDvnV9htayf5CL-PQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Oct 2023 18:16:33 +0200
Message-ID: <CA+fCnZfp7V411qf_6miCzSg_5w7HwkHwH+NWLLy8C62P0hEN-g@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] lib/stackdepot: rework helpers for depot_alloc_stack
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:00=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:
>
> > +static void depot_keep_next_pool(void **prealloc)
> >  {
> >         /*
> > -        * If the next pool is already initialized or the maximum numbe=
r of
> > +        * If the next pool is already saved or the maximum number of
> >          * pools is reached, do not use the preallocated memory.
> >          */
> >         if (!next_pool_required)
> It's not mentioned at the top of the file that next_pool_required is
> protected by pool_lock, but it is, correct?
> Can you please update the comment to reflect that?

I'll add a clarifying comment above this access to the previous patch.
I don't think it's worth to describe all locking intricacies of the
existing code in other places, as atomic accesses are removed
altogether later in the series anyway.

Thanks!
