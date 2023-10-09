Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713A27BDAAB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbjJIMGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346463AbjJIMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:05:58 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43CB4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:05:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66b024d26e2so20636376d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696853156; x=1697457956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VY/6yygJv/miZhZ8h6odHp72SB3kIR4yZRTmobOqWU=;
        b=2JiYUGmNMPoiRRQcqDMsqbLFqH4KdbSOT+SsSA+IlIYQ7mHhB9/8VSZ8onSNOaWiuP
         nYWons8LGBk39JnPxtjP6B1vL48Tv27Kol5tVMdt7IDkhq6QhxhJln0D51l1ZRl+NnGR
         1qutiXL7VhmtNfuTP8ZFg7OPKlNvwZj51L7LXSjvIzuGGewedI/3Gc7VSnJD4n69KSFU
         FBeT8zczXAntT4joG6UYDLmbiQ9aRsIHRsy5Twey4TJvjApaHnHFosQ6XxGiE8gXNqlU
         dItCYOKrT9yW5OS6xCjxvqnnBtKxVOrt8n4M+aKkyCWHX/STjDc6qstmfUebI2SR9ZxS
         0ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696853156; x=1697457956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VY/6yygJv/miZhZ8h6odHp72SB3kIR4yZRTmobOqWU=;
        b=TPdIZeaUfOH3FohzxiiHQWuM1UzqIlfDVY+T6crrbF8/oX6jh1ZmbsC38v+2ejBthK
         JVJ6hEodWP3e6FXVXusHUWksehKL1CjzC2svI8eRog9FPRN1MT0q3FcrsBrQZqihkylB
         Esmui7IA0nEnzsVT7R9oYD/5X1MHBEZ+xpzTNpLnIQIFl2Idi2ZYG3JrgVNr9IHiBh74
         y5ldJVVpdgWwQQju6GVc0DmBSHB7IzaQt5wbhrAumWniwXMskFssI3wIUFJtw6/jaO89
         GC8OiYwgfTLpNDlkng4GqbhwkxbbbTNGX4s0DGiva82I21OHjnn1HkjiZ7j7MhYq3Cmb
         NCzA==
X-Gm-Message-State: AOJu0YxeVsQtwc4VyULagJJPx3h3VmU9rMupsBl+qvw90ZKfAhkjbrXL
        VqrXmmVWXnweOR9OqTIBtC1IjjLOa2AMl9Z+2aQbuQ==
X-Google-Smtp-Source: AGHT+IFrjSRXPfPjjYka+W0FmZBdaoIIqHaKOgYlAXf2BmSBCfxr3bTODKn0BMDjv6ZYP+4c+W/Dec/C3Izyg7gfKm0=
X-Received: by 2002:a05:6214:762:b0:65b:72a:78df with SMTP id
 f2-20020a056214076200b0065b072a78dfmr16256736qvz.10.1696853156331; Mon, 09
 Oct 2023 05:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <556085476eb7d2e3703d62dc2fa920931aadf459.1694625260.git.andreyknvl@google.com>
In-Reply-To: <556085476eb7d2e3703d62dc2fa920931aadf459.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 14:05:16 +0200
Message-ID: <CAG_fn=VJtzkvrMu84BuNtbjkmRuQx7aLLSsew-Hns5bAdSnm2Q@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] kasan: remove atomic accesses to stack ring entries
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

On Wed, Sep 13, 2023 at 7:17=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Remove the atomic accesses to entry fields in save_stack_info and
> kasan_complete_mode_report_info for tag-based KASAN modes.
>
> These atomics are not required, as the read/write lock prevents the
> entries from being read (in kasan_complete_mode_report_info) while being
> written (in save_stack_info) and the try_cmpxchg prevents the same entry
> from being rewritten (in save_stack_info) in the unlikely case of wrappin=
g
> during writing.

Given that you removed all atomic accesses, it should be fine to
remove the inclusion of atomic.h as well.

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
