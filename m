Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FBA7D3C23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjJWQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjJWQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:18:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0A10CB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5aed4f0e90bso1974122a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077872; x=1698682672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yATWwHsptne51eJuPF88jokz2oPp7uVzj/nBvs3wVg=;
        b=hmfZgI8641yBXOZP+ZTMleLdrrQwju7SpvGzcSQ+ozsP256J8enhB4F/7KkwOMOoq3
         nWCIw3ziQRfTN6/unMIN9GILx+2F9EDEzOyySonKIjlxXaDbVvxL3RKs6iaA2p/9VgRd
         3IijCzzSWmOmKLCSEnK1srQyGNQQNfyrWmHobHjjDTnJ9RS0m5Uiw5llDeOZRs3OT0Ne
         r5ty/37O+o5qXBkTUjYk6So5U+kv4RXnkctv+UCJ09LukS6BszGzguKeACfLcdUIz2SI
         UtwgQxoD6YJPIDKXXV8RSGNKd+x+GxcmmtfEBz04hh7qbma1NXHuR1zv/7W+cgIYCFwK
         zRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077872; x=1698682672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yATWwHsptne51eJuPF88jokz2oPp7uVzj/nBvs3wVg=;
        b=wdIrIA4mS7PLSMRMf04y4dJeHaay66Kv2ut8nCwbR29U5k1v0nxrdFlJXN8+aMh9U7
         3/39Re/dV0EuRfp6NbFBRvf9gndQS+0BCs4oDaXC0KpWx+m93zjhEOAj6T2/fjnZlRL9
         /osSktT+UlmhENkP+BzDfRIW09flILrLVTC3fPtuqQEfB/uKhBKEUE+Sjy5zjtceRY1A
         WrJ2A+xXDg558Vlk1ZEOqfj6OHnordy1o7UDZmkNUQfykIzNX8t5MZ2IK1IfRksF+e+u
         Yz4xuanOBDrmFNYRALG4l2Jql6nknfUZ9VwnmPBEjSw+gh5mPpEUBB9RfUx+D36oD7Fn
         xZwA==
X-Gm-Message-State: AOJu0YzofocDa15SNdUzCskN/yDiiwuEkPAoerjyZvqMIwOV95bHNv9i
        kenJtCxUfjTsIlxN0UCBkXeBbJrmPP0sGpjAQok=
X-Google-Smtp-Source: AGHT+IFXVb9U4SM4HwA3U46Mat4CbYSvspwWg7CriO0BHYKCNOqWiRma5uHwBcmlkoNHTK6PPF5WWh4PGgFxANz7WII=
X-Received: by 2002:a17:90a:19c5:b0:27d:e73:3077 with SMTP id
 5-20020a17090a19c500b0027d0e733077mr7197699pjj.1.1698077872354; Mon, 23 Oct
 2023 09:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <d94caa60d28349ca5a3c709fdb67545d9374e0dc.1694625260.git.andreyknvl@google.com>
 <20230916174334.GA1030024@mutt> <20230916130412.bdd04e5344f80af583332e9d@linux-foundation.org>
 <CAG_fn=W0OO4GGS0-pnHFpnWGsBN3dZJ9tnRxPmEKRkkP4Vh48A@mail.gmail.com>
In-Reply-To: <CAG_fn=W0OO4GGS0-pnHFpnWGsBN3dZJ9tnRxPmEKRkkP4Vh48A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Oct 2023 18:17:40 +0200
Message-ID: <CA+fCnZfRh=a1VQx7CaHAjTQw9888jxFHB0dJv5hkBW6v3njdkQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/19] lib/stackdepot: use list_head for stack record links
To:     Alexander Potapenko <glider@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>, arnd@arndb.de,
        sfr@canb.auug.org.au
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

On Mon, Oct 9, 2023 at 2:16=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> On Sat, Sep 16, 2023 at 10:04=E2=80=AFPM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Sat, 16 Sep 2023 19:43:35 +0200 Anders Roxell <anders.roxell@linaro.=
org> wrote:
> >
> > > On 2023-09-13 19:14, andrey.konovalov@linux.dev wrote:
> > > > From: Andrey Konovalov <andreyknvl@google.com>
> > > >
> > > > Switch stack_record to use list_head for links in the hash table
> > > > and in the freelist.
> > > >
> > > > This will allow removing entries from the hash table buckets.
> > > >
> > > > This is preparatory patch for implementing the eviction of stack re=
cords
> > > > from the stack depot.
> > > >
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > >
> > >
> > > Building on an arm64 kernel from linux-next tag next-20230915, and bo=
ot
> > > that in QEMU. I see the following kernel panic.
> > >
> > > ...
> > >
> > > The full log can be found [1] and the .config file [2]. I bisected do=
wn
> > > to this commit, see the bisect log [3].
>
> I am also seeing similar crashes on an x86 KMSAN build.
>
> They are happening when in the following code:
>
>         list_for_each(pos, bucket) {
>                 found =3D list_entry(pos, struct stack_record, list);
>                 if (found->hash =3D=3D hash &&
>                     found->size =3D=3D size &&
>                     !stackdepot_memcmp(entries, found->entries, size))
>                         return found;
>         }
>
> `found` is NULL
>
> @Andrey, could you please take a look?

Found a bug, will fix in v3. Thank you!
