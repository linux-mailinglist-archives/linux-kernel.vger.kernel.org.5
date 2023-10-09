Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4514A7BEAD6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378465AbjJITuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbjJITuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:50:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F794
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:50:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5890aa0573aso2322966a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696881018; x=1697485818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8wgkR84iWM9wxhviglgJUbOlzdCkXj/+h+ORKDao4Y=;
        b=csENhR/Nyz2ClMCKc7JRU4Bvimzri0c4R5dqdKEfJgaxgJLZQ2H5rDNmCrKw/FO9AU
         wdAKDcNsM6VkLQmPLWfZ4xy9LCYrdjNLo7sUbnsOf6QjkPQp74T4MgJEFDcIj71g9l+E
         54p3IR8jtNnjxMFAHx++VOm0k+mgzdP0i0s9skDw5iKiBGxpkcOi+LlbwrZxTrlBWn6i
         F1azN1Ow/NHq/nP0s+ewsYWE2ILAXtrLMeg+DWNlkoNjoSl7kVs56REsiCLXwOMnhN+l
         IS7rkCSJCe4meeDqP5xEilVLciNwMi7oEVqiHjURJYU7O4iKRoPz9EZdn1QHhn0skGZd
         n16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881018; x=1697485818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8wgkR84iWM9wxhviglgJUbOlzdCkXj/+h+ORKDao4Y=;
        b=BK5uGLlSntHd7dYUAemrZwBPwUXioXBwJCsJEg6GzNE+EPwyHc7HrTw6AyHRITrOzg
         gqh3ccxtbRNyDFoQZfmiPP/1x9Nq/pdiNliQbXaKPQYxJGKY1n+5iyZp+jOn5KbZ3xY8
         kI22sWfQHwy23yCZclw8CBvRbe3hOnZowF5Y09jvPLhGRA/XNdUKYDsu86lm/OKyz9Y8
         cAPXY2MZwdthynm4LDuIIMzBENFrCrUG8Fc1jPsebrHpQ9UafqDB6xkXwHX13i5M1pvr
         1P4kyQRCuysBWR+2AaSoWDsf9zc7zDhpo3SuVlFyNzibIwqmqPyz3UCaWyXepvNtMmMC
         IdKA==
X-Gm-Message-State: AOJu0Yx62o+hgCsQXoqY/4wdJ15UNJuaPi3sCRcSYLmhdoyGGVYY8nz0
        8dIaqOmAlfBNHJ2i+/dZ7bSM+6pwUslsBJaiuYvpZqkMXWfdAh1Y
X-Google-Smtp-Source: AGHT+IHkheL0g3ZGB52fFGNOzJ6Kj9LAtixQZ7+kZQ+spP/PH7eHPuBlCXDPM6lMAjTqqFHKSQgbkQBVESUgi3jz/gA=
X-Received: by 2002:a17:90a:b97:b0:273:4672:98b5 with SMTP id
 23-20020a17090a0b9700b00273467298b5mr12577856pjr.42.1696881018348; Mon, 09
 Oct 2023 12:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696605143.git.andreyknvl@google.com> <6f621966c6f52241b5aaa7220c348be90c075371.1696605143.git.andreyknvl@google.com>
 <CANpmjNOHPRHOOPNwx04S_CE5OoQMAmfxHjxqeqy=YUpU+sY7yA@mail.gmail.com>
In-Reply-To: <CANpmjNOHPRHOOPNwx04S_CE5OoQMAmfxHjxqeqy=YUpU+sY7yA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 Oct 2023 21:50:06 +0200
Message-ID: <CA+fCnZc+JVdxzfiaSon+0V6-5c7SsXv8pNUvjWsfiLPyvMr9Ow@mail.gmail.com>
Subject: Re: [PATCH 3/5] kasan: use unchecked __memset internally
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:46=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Fri, 6 Oct 2023 at 17:18, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > KASAN code is supposed to use the unchecked __memset implementation whe=
n
> > accessing its metadata.
> >
> > Change uses of memset to __memset in mm/kasan/.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Do we need a "Fixes" tag?

Good idea, let's add them:

Fixes: 59e6e098d1c1 ("kasan: introduce kasan_complete_mode_report_info")
Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real
shadow memory")

> Reviewed-by: Marco Elver <elver@google.com>

Thanks!
