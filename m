Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98D7CA074
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjJPHZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJPHZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:25:17 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C1AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:25:14 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-457c2d81f7fso1099826137.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697441114; x=1698045914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aaq5gGSXXFhrvTLVP4/6JBiex67TLmoZv6JITqT6ub0=;
        b=GiJXhH5HaQDPuXXycEANmjbh5fQuSmfyhWORx6aqrdUTWmdUZNa7oThSMNe8grKN/A
         2ImBPu+vBPSVLlVwKbXwTWKhUbeghd/O6b9x1MCXarZXwRd8hvVLJf9ti+/8ecIRYtgu
         OLTNJYsTfpLUoTk1s6VgBqAkUrXdrDZ637yCoXgE0bAS8EbocVjYLvwZwxKBzxGZU1i7
         ptStMBTYhx4x+YtG6wxMaTgqhHgpWgjGKc19F+Kebi97l4+EYKkjDTjj7S643fySQUOv
         vq9bmiESQTthhRA2DU0SvixlbS0CcBN1yEnCmdZZd0yFsRYk6Tvj/WvKUIPncsl05onz
         /w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697441114; x=1698045914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aaq5gGSXXFhrvTLVP4/6JBiex67TLmoZv6JITqT6ub0=;
        b=SNrSAxnV1R8nanPL5Y9N0HbbPLFqEJIp5Igm6BiC/bReJaoC76KPKOIaEmzTfwuxWr
         Y1/wgTRdnYLqiMXaSf2mNr4HoqJFSZ6Cn8l57Dcr9D82S6C7xq/9gdzBhSmi88tbJ1Xv
         XwNNNhGRNro00P/ve70fxRqxOg7vC8lsBiwvl658BJBRk2WoxxNKf1Kq3p8xSVVGnct7
         aPH7IEHJ4DHMdiztuxPJi5UF0MijxVgzpFbBhhwyaBmOnEsso0v59YknKnRjhVWgxV7j
         lxHjlsjvkGQMu0zR6cleyRDkGFZ5CaMuhfCJvqrxl+4nXriDYMZNwEyQZLNYDIPHA66S
         zG9Q==
X-Gm-Message-State: AOJu0YwpRwB93ntUv5A2MutxYETe/pULF8r3LV3uD7KYjIV/gtTzg+SL
        gZy2q5UVjrQiZuGEVhP6NCpY/BkgFfr4KmePQzErLg==
X-Google-Smtp-Source: AGHT+IHM6KHt6t7x5t8fil1Plwgk0EsM4WTEYEIj9ZZGHoZ/I6lKkTvCIA4i9QP2W1cZcN11E/Wv3rB9KseVrX4b+qA=
X-Received: by 2002:a67:e00b:0:b0:457:c052:1949 with SMTP id
 c11-20020a67e00b000000b00457c0521949mr6953894vsl.25.1697441113556; Mon, 16
 Oct 2023 00:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231015202650.85777-1-pedro.falcato@gmail.com> <CAKbZUD01au=HoDe=yXSLtxJgYdivZccqqBfpmnmQ04R1Y1orvg@mail.gmail.com>
In-Reply-To: <CAKbZUD01au=HoDe=yXSLtxJgYdivZccqqBfpmnmQ04R1Y1orvg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 16 Oct 2023 09:24:37 +0200
Message-ID: <CANpmjNNq9X+n=WFsa-p31gKJG5vLH6PXGmLt0eEmWoHwMN0scg@mail.gmail.com>
Subject: Re: [PATCH] mm: kmsan: Panic on failure to allocate early boot metadata
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Sun, 15 Oct 2023 at 22:35, Pedro Falcato <pedro.falcato@gmail.com> wrote=
:
>
> On Sun, Oct 15, 2023 at 9:26=E2=80=AFPM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> >
> > Given large enough allocations and a machine with low enough memory (i.=
e
> > a default QEMU VM), it's entirely possible that
> > kmsan_init_alloc_meta_for_range's shadow+origin allocation fails.
>
> Ugh, forgot to run checkpatch.pl until it was too late :/
>
> > Instead of eating a NULL deref kernel oops, check explicitly for memblo=
ck_alloc()
>
> If there's no need for a v2, please wrap the above line and...

Probably easier to send v2.

Otherwise looks good.

> > failure and panic with a nice error message.
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  mm/kmsan/shadow.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> > index 87318f9170f..3dae3d9c0b3 100644
> > --- a/mm/kmsan/shadow.c
> > +++ b/mm/kmsan/shadow.c
> > @@ -285,12 +285,18 @@ void __init kmsan_init_alloc_meta_for_range(void =
*start, void *end)
> >         size =3D PAGE_ALIGN((u64)end - (u64)start);
> >         shadow =3D memblock_alloc(size, PAGE_SIZE);
> >         origin =3D memblock_alloc(size, PAGE_SIZE);
> > +
> > +       if (!shadow || !origin)
> > +               panic("%s: Failed to allocate metadata memory for early=
 boot range "
> > +                     "of size %llu",
>
> unwrap this string like this:
>     "%s: Failed to allocate metadata memory for early boot range of size =
%llu",
>
> Silly mistake...
>
> --
> Pedro
