Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD757D3C21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjJWQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjJWQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:18:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442F1707
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so1766595a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077857; x=1698682657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZyP39z6xvoSIY5Cv54i5pfq0RfQpmz8NTDav/yNwTk=;
        b=AVVWmb3OMGhSW6C1x3vXig8U38435IutaqFDv8WOQzW1Og8ZWVV6MQa0jKobeyEiWX
         /Bq1Sejummy5hWge75AqGK3nzpXGNGXF6GEpQXpzxOj1vs4zKkuqKtinIlHg/Q3DHRkl
         JBwV8RVK+YPRjWH9sgXQXpLxlXimaHNW351eQ6RHaLynb+qqAfIo/0/PJkej0yQBi6yF
         IS21FxnKxeMqD9ZCyMfc8/9XuI3JaUy/o8nZltIF1vSJZx7f+aCly/o7a9YYY6MqkU63
         +qAjX47NPfFCJHEUwxYtXoKGa/f+lOnzybN4Xh4yI8Fbxmbj6LwauVcc99Qc4yjQVuHE
         jKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077857; x=1698682657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZyP39z6xvoSIY5Cv54i5pfq0RfQpmz8NTDav/yNwTk=;
        b=eoqKD1huZFY8VS528r8D8/6+BxujHyGliku6XfZP9Va1UpXxfzeILFSPI7gRAvHpiV
         o81QDMi1H+1ucqi/BTqf7UtfFwz2u/UqwOYezVljNAMbkPXnLIYt2EKSAEkn5leIpuin
         A7rCXerbTy8xu80zdbqvgfM/Mb3Yl4yBVLCzc3wQMkbnzUq+awl/dmlssVDAHIfei5z+
         6U50AvGsr4hlvOV5AqTAMP1cMC/S16WTaqAICUgyu+gSl3waouYwPpoEvsop0pHp1Xm4
         CNHZCdv7yXkb0n986PXeQQuL2MOXZe6b+93ZnWaWMZPr21r+jMH4VJaSzNpaim8WIxco
         cQiw==
X-Gm-Message-State: AOJu0YxlnyU+xnLinRqKfjM13dadHlDzxQXGN4UTHd8euwoI/GmIkbhX
        8JzFnJf+yr7AaXErzgVzVeUE0vxsN8iUajOMRcY=
X-Google-Smtp-Source: AGHT+IEfifli79cwbVQ+6TNZdsR3mB4FmfsPsSQK0R3HjgJ2Z1fXeHzkNtCWKDBQ/vBQZ0l//EWdSfTkizgQt0QxwrQ=
X-Received: by 2002:a17:90a:f315:b0:27d:1f5c:22cb with SMTP id
 ca21-20020a17090af31500b0027d1f5c22cbmr6881409pjb.20.1698077857064; Mon, 23
 Oct 2023 09:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <556085476eb7d2e3703d62dc2fa920931aadf459.1694625260.git.andreyknvl@google.com>
 <CAG_fn=VJtzkvrMu84BuNtbjkmRuQx7aLLSsew-Hns5bAdSnm2Q@mail.gmail.com>
In-Reply-To: <CAG_fn=VJtzkvrMu84BuNtbjkmRuQx7aLLSsew-Hns5bAdSnm2Q@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Oct 2023 18:17:26 +0200
Message-ID: <CA+fCnZcLL9vapkMv292FnQdxbUY=_q8-r6aQ+9=okjk8ua7JLg@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] kasan: remove atomic accesses to stack ring entries
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

On Mon, Oct 9, 2023 at 2:05=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> On Wed, Sep 13, 2023 at 7:17=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Remove the atomic accesses to entry fields in save_stack_info and
> > kasan_complete_mode_report_info for tag-based KASAN modes.
> >
> > These atomics are not required, as the read/write lock prevents the
> > entries from being read (in kasan_complete_mode_report_info) while bein=
g
> > written (in save_stack_info) and the try_cmpxchg prevents the same entr=
y
> > from being rewritten (in save_stack_info) in the unlikely case of wrapp=
ing
> > during writing.
>
> Given that you removed all atomic accesses, it should be fine to
> remove the inclusion of atomic.h as well.

Not all of them are removed: stack_ring.pos is still accessed via atomics.

> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>

Thanks!
