Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFCD79EFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjIMRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMRJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:09:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD64F2698
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:09:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26f57f02442so55242a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624947; x=1695229747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp3RFNUyA36WKs+LwiEbI6IPse2t1rgKYPkaJa9C0u8=;
        b=l6iHoEqiHmB+5EyqIZH2iCAfePHVATuunNVv3G9TJhy1QPkbrqgXn9Hh2myLc9Tcvr
         v6cTZ02np5aGyHuZ2rLnTJ1dEpRBiKl03dolp57DWqcT8lkbJqppw4rdJd/a2FrDwgp2
         UhjwprFIxntcm6kgA9UhjCVLnIuHZdh8o8OV5h9vP/OJnZ9z8cCBSiIjl/Ce2paHH/Dm
         j2iwQmUX3oC3j0Aq78yUcDj6KJ39xsgeiai/dKkWGBk93za9GqVsawihCVocrO8Sksj2
         Li2z+HlV8TRN5jM1PB95kAcUPbASgEhroswmvi0/IgDbf22GMyEcj7LYMwOU1nZr9chN
         db2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624947; x=1695229747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wp3RFNUyA36WKs+LwiEbI6IPse2t1rgKYPkaJa9C0u8=;
        b=eZw2cML++FJkHXbYigObbZjrEkto/jtkaEdb2KkTcTFm1DM2Zf9hkZjVNsPy2raiHI
         jSxkBuObq5ELZqVk1Oq2JPx5P/quADfmjD+sUfmFZ3m59Z4BaBD7QHJ0kkkEfBqO2BhH
         XdHu0PCCMu6pXx4Z4rg8yf8jHmbr/m0NHO04bKH7FcdbA/5rm2p3/PvQLZff9laFBxuT
         dndW0xB8IxBT7JDvrXUnnIQJjgcmDT0KdaTuC4BeU6wJVKhWA0JflQR1X0T85yCcbNQj
         zCSBG55X4xRc+G6beytv9gJJZkXHpZeK71+a8ukKPPTrGt6oYFwppfQjc5EP2sK13Kgl
         82YQ==
X-Gm-Message-State: AOJu0YxQTbwXNCBMuadlpygzxsRDTtgGVCIm1vmSZ6a/PKxABFPBGd+8
        hVH+WEZPV0hSZ/bnM5+RWqO6G5MHxL5gtIaaKUHQBJ6K
X-Google-Smtp-Source: AGHT+IFnTsfCCAvjTTXF0tw2ZjaYgJSLdBeKAwtaOvthb4sutpsXgC+kai/BftmKmoVEf73flhLQZSaEOoNtYm/UprA=
X-Received: by 2002:a17:90a:c584:b0:26d:d2d:1a90 with SMTP id
 l4-20020a17090ac58400b0026d0d2d1a90mr2912368pjt.1.1694624947292; Wed, 13 Sep
 2023 10:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <6db160185d3bd9b3312da4ccc073adcdac58709e.1693328501.git.andreyknvl@google.com>
 <ZO8IMysDIT7XnN9Z@elver.google.com> <CA+fCnZdLi3g999PeBWf36Z3RB1ObHyZDR_xS0kwJWm6fNUqSrA@mail.gmail.com>
 <CANpmjNNtT1WUpJu_n5x_tA2sL4+utP0a6oGUzqrU5JuEu3mowg@mail.gmail.com>
In-Reply-To: <CANpmjNNtT1WUpJu_n5x_tA2sL4+utP0a6oGUzqrU5JuEu3mowg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Sep 2023 19:08:56 +0200
Message-ID: <CA+fCnZdAUo1CKDK4kiUyR+Fxc_F++CFezanPDVujx3u7fBmw=A@mail.gmail.com>
Subject: Re: [PATCH 11/15] stackdepot: use read/write lock
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 6:19=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> > Good suggestion. I propose that we keep the rwlock for now, and I'll
> > check whether the performance is better with percpu-rwsem once I get
> > to implementing and testing the performance changes. I'll also check
> > whether percpu-rwsem makes sense for stack ring in tag-based KASAN
> > modes.
>
> I think it's quite obvious that the percpu-rwsem is better. A simple
> experiment is to measure the ratio of stackdepot hits vs misses. If
> the ratio is obviously skewed towards hits, then I'd just go with the
> percpu-rwsem.
>
> The performance benefit may not be measurable if you use a small system.

I started looking into using percpu-rwsem, but it appears that it
doesn't have the irqsave/irqrestore API flavor. I suspect that it
shouldn't be hard to add it, but I'd rather not pursue this as a part
of this series.

So I still propose to keep the rwlock for now, and switch to
percpu-rwsem later together with the other perf changes.
