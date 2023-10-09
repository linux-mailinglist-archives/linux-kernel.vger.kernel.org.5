Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385517BDBB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376298AbjJIMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346489AbjJIMZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:25:01 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD0199
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:25:00 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1e5602c12e5so2714087fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696854297; x=1697459097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XMSmBSmrIghDRAMwSWs7YuLmGLdnz0rmjgVzyIhrZM=;
        b=ucsvcSIwxxBSjkrF+W4Dy8XDMtzGVfrR7SCBz2AuejbwVjB81oXCxWs3dskHri12NP
         A9QyXG5UUPsJ+zDXhrF+Hrq77ZpEKI2ap/GyPm3xV4g6fCatSHsqJx/f8tLouYhpIaDW
         zRhvVBdh82/m06q18atKyfDXL21RqJWiDVFu9DaDhiBWEKaMf7F2WxuE92NEy9FoZuf0
         nKWZdoN4wLqATyZ/4EkI07vt4DZAOdlGWbjBvuVsuQCZpquSaWlMXpAxjJKlhKETz3gI
         d/o/SAKmVRdxfU8fjXJRqyu3tdL5vszGQxunoal1SOPvZBNMzAg7nKmlXYAcGb+MMEJK
         P+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696854297; x=1697459097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XMSmBSmrIghDRAMwSWs7YuLmGLdnz0rmjgVzyIhrZM=;
        b=nvZ08hu+Q1mid4LKCNvNxkUK6PKCw8XV+UxPJPkF4PBxpoczn5oXMpXf1Pcz/At4ED
         WQEB8zMVfQ314nwGjm05UApdn9MnRnX9+/bxRSxG5XBbRrgRBYWXmHUcBC7fcpByuJDu
         tTyO7MzyqbaDReLjAe2ytw6chMHnukCjckwHsWc2LE4sRjItXb1k9bZo8lxytkUhBvz+
         qBKLRicxDyYMKPTwfhViHeFWPI/pPvyi7Oj43dVYhFbixJyp2nu0DQB17/dWRkdAd+Cv
         MJ0bWZontJ/IHrbpRM/nwXIyf/Gy7Up4bSQ/FmQEtfww3B3T2JJNnAFj0g77jqGnX1/C
         QzTg==
X-Gm-Message-State: AOJu0Yw+hyHJI0Qj597tUDbFqBp0wd1Mc/nrnt9dPRsseYNJMBskf59Q
        sgIu/opWMsSns8F1XpOzlb7jFXv07iZxBppE0QihsA==
X-Google-Smtp-Source: AGHT+IH6/QocEv3JYM+yilbyZ1Xl7cqTgYJqQlPc2w8elKWmV5kM+Lc10JwYbAVsPnJzVeUI1EZn0iGeXNJoP3bX9SE=
X-Received: by 2002:a05:6870:5252:b0:1e1:6cee:26b6 with SMTP id
 o18-20020a056870525200b001e16cee26b6mr19546563oai.8.1696854296959; Mon, 09
 Oct 2023 05:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <6e2367e7693aa107f05c649abe06180fff847bb4.1694625260.git.andreyknvl@google.com>
In-Reply-To: <6e2367e7693aa107f05c649abe06180fff847bb4.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 14:24:21 +0200
Message-ID: <CAG_fn=UZu3QpwTQYgXaYe8NVBsuqs8_Ado-+x4pJLaNE+Ph8Mw@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] kasan: use stack_depot_put for tag-based modes
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Wed, Sep 13, 2023 at 7:18=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Make tag-based KASAN modes to evict stack traces from the stack depot
"Make tag-based KASAN modes evict stack traces from the stack depot"
(without "to")

> Internally, pass STACK_DEPOT_FLAG_GET to stack_depot_save_flags (via
> kasan_save_stack) to increment the refcount when saving a new entry
> to stack ring and call stack_depot_put when removing an entry from
> stack ring.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(but see the two other comments)

> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -7,6 +7,7 @@
>  #include <linux/atomic.h>
>
>  #include "kasan.h"
> +#include "../slab.h"

Why?
