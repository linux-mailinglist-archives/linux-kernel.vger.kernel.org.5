Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB479EFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjIMRH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjIMRHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:07:36 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA81BD4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53482b44007so4991453a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624852; x=1695229652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAHlwDQj5aLs+kNJzI19rDW68TVeu+jwDvk+z6Yfntc=;
        b=USZyy0qZ4kxahSLbvU+aUff1ZxPjz2gkGEw9o4gOHFFJ4cgUSwSBCikL8p2IwQe3yC
         lOZUT6sJkdwcIskTqerzeVM2MAW8bkhkhOFzsJLz8P8qTjYZ38vdcCwOMP3OWUZtRRK0
         7Z3Ezcw4lyC111QSlwQhppUKEdg/I2Q0o9/pZTApVvDeuxzMBFecX2fFxwvJ6Pluc17n
         5KBYfgWk6EimnFvTnyOUriDl/q30JZqhaunNxCXQQtibOm6r8lT4RNdbmIaHt7hQXNpC
         wpf60VKUBkr0xVbrKo1eiYlMmCsODiDUeKagZncqmO7qi6R4B+6+ylvLSzHsz7tNIiPJ
         SSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624852; x=1695229652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAHlwDQj5aLs+kNJzI19rDW68TVeu+jwDvk+z6Yfntc=;
        b=bIkufHBe/hk2qWiVd6uHRYTbCGIBaFbhxAtrQbLGUJTKN8EHHF4CNyXMH4RK6zD2+Y
         KitOlYud+OMCIO+iRdUK2UgKOq5Xg92ZiNfao/aHRE0Ijvat7yGAOjaOT2bQMHVsNrwB
         yewMManRS1q4XJpVD46Y6nH2Hp3egvYYsTrU67et+niXx+btr9w1fs6WgKr8pJ6PMtWI
         FAC3OTAax/AZedJg/svK8lY8LHjXBTvG9NY2/ItmerMJT5sVzLQ/SdenYa9AT6eE5/j8
         WyudOIhmTPvyq6R7s1L660qtil3Xfat6ISEARsw1Lw9E3+sQUtVt+DMRt1OZUs9DWT04
         a4tg==
X-Gm-Message-State: AOJu0YwPCDGDDFqIbSmbdmFQnw+iKhVEHhNGgDAQqZ5SozUdZb/Pu2Rc
        jpbGqbEsAykF6lbUDPMZRNYLxfxyv82h8+Rjq7cAlSNy
X-Google-Smtp-Source: AGHT+IGPAMD8g5fjPw1Tth1zv1pzrljIB/knnIK7hezCiVeflWmosEgEj9S+4EQXjFPVd786gIDuhMQt4oggmeoLt9Y=
X-Received: by 2002:a17:90a:887:b0:268:37b:a10e with SMTP id
 v7-20020a17090a088700b00268037ba10emr2692968pjc.11.1694624852255; Wed, 13 Sep
 2023 10:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <89c2f64120a7dd6b2255a9a281603359a50cf6f7.1693328501.git.andreyknvl@google.com>
 <CAG_fn=WsYH8iwHCGsoBRL9BRM-uzKJ3+RDgrB5DEGVJKLPagVw@mail.gmail.com>
In-Reply-To: <CAG_fn=WsYH8iwHCGsoBRL9BRM-uzKJ3+RDgrB5DEGVJKLPagVw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Sep 2023 19:07:21 +0200
Message-ID: <CA+fCnZftKPJ7zDWmPRjxYXQK91DX2eEw0nDNtYW856399v__Hg@mail.gmail.com>
Subject: Re: [PATCH 05/15] stackdepot: use fixed-sized slots for stack records
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
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

On Wed, Aug 30, 2023 at 10:22=E2=80=AFAM Alexander Potapenko <glider@google=
.com> wrote:
>
> On Tue, Aug 29, 2023 at 7:11=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Instead of storing stack records in stack depot pools one right after
> > another, use 32-frame-sized slots.
>
> I am slightly concerned about the KMSAN use case here, which defines
> KMSAN_STACK_DEPTH to 64.

Hm, indeed. KASAN also defines the depth to 64 actually.

I think it's reasonable to change the default value to 64 to cover all
the existing users. And whoever wants to save up on memory can change
the Kconfig parameter (I'll add one as you suggested).

> I don't have a comprehensive stack depth breakdown, but a quick poking
> around syzkaller.appspot.com shows several cases where the stacks are
> actually longer than 32 frames.

Whichever value we choose, some of stack traces will not fit
unfortunately. But yeah, 64 seems to be a more reasonable value.

> Can you add a config parameter for the stack depth instead of
> mandating 32 frames everywhere?

Sure, will do in v2.

> As a side note, kmsan_internal_chain_origin()
> (https://elixir.bootlin.com/linux/latest/source/mm/kmsan/core.c#L214)
> creates small 3-frame records in the stack depot to link two stacks
> together, which will add unnecessary stackdepot pressure.
> But this can be fixed by storing both the new stack trace and the link
> to the old stack trace in the same record.

Do you mean this can be fixed in KMSAN? Or do you mean some kind of an
extension to the stack depot interface?
