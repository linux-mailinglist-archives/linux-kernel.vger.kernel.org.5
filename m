Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600017D3C24
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjJWQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjJWQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:18:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477610E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:18:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27e0c1222d1so2190046a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077883; x=1698682683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPMyERwOm/NcnB3A4LMRfhfW5xHZDfVqvzjxqSuC/ik=;
        b=TugK/9Yxzol+hyQj1WRqfkuUOtiOWziDYe+MEsm66ysqkH5dOZYTSteZMUGl7pmZxG
         pWlOLj4Bjwcwq317aPo2S214xt2rKKPWUIr7KDLu9eOq5pEhXcQ5PdRGSjAuqUaPSYMu
         hO958nWYcvusg5TjzBh6094U6oZwX9Ls9h2E78F3c6A1KflI8b1a07COelw1ae2XjdVt
         +EJhFSUCOVlRlD6UrBmiWjCthyN5SwJqyspS3D+iqXKK5hb78qvBIjmoxvYBKGKdWyCj
         VNaU7D6BodU9C8JGVpdDFViAgcrDj1mfVM+/s34ltaa1GHLs4N2zAkQZevJi1TjNOlaS
         MEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077883; x=1698682683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPMyERwOm/NcnB3A4LMRfhfW5xHZDfVqvzjxqSuC/ik=;
        b=pmlQvupzmrong90EY8GVAZ/TBtpGxmS8n7cPqbsNCU2xTv0T+y+vxJhjshZWlaCHCk
         X32GgBUaFVrI77uw8YMLZ6cWY7Z/wpUJcNewZ0UCSiIaHfIHA9Qds9NTyXaOmVbqSDCc
         hF+5HKK1QnilDRrohuwkqf5D79i83L61XSmKjEz/+0zEwfRix40lHzk051Q+CeqxxOB6
         n3XwNJBM1K/Qgw5wdRT9k/dWk29+iNZwL3A0Zzul9dFgBucho1l6ufePAuhXh+iHXCaz
         6JfZ7gTQ2z7T8V4Ud8nYAl+PkY5Q4fkWtU/DU93n7AVm8dkxk2IMeQuE90UK3l7Idkz3
         uaZg==
X-Gm-Message-State: AOJu0Yyc5crSc3wLR/MW5k+nhvDBTujPiDMWlGBOargCob1LxRWOjSeT
        TaWRzus04O81z5A3T+GnEubpM9W8Ti9UnhQALCo=
X-Google-Smtp-Source: AGHT+IE5ETbhrd+Qz3X/nlheL6PwYn82j2ISE6ffyRQf9e0BfzUw0DqqFdMAtYaMQ17eb/+pgEAdEaITjOO5/dKN12k=
X-Received: by 2002:a17:90b:51d0:b0:268:b0b:a084 with SMTP id
 sf16-20020a17090b51d000b002680b0ba084mr7386877pjb.46.1698077882806; Mon, 23
 Oct 2023 09:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <6e2367e7693aa107f05c649abe06180fff847bb4.1694625260.git.andreyknvl@google.com>
 <CAG_fn=UZu3QpwTQYgXaYe8NVBsuqs8_Ado-+x4pJLaNE+Ph8Mw@mail.gmail.com>
In-Reply-To: <CAG_fn=UZu3QpwTQYgXaYe8NVBsuqs8_Ado-+x4pJLaNE+Ph8Mw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Oct 2023 18:17:51 +0200
Message-ID: <CA+fCnZdGUGd7cAvWVj_Y77W5+CsjguBWB2mQX-Nx4MsYGbVpRw@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] kasan: use stack_depot_put for tag-based modes
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 2:24=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> On Wed, Sep 13, 2023 at 7:18=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Make tag-based KASAN modes to evict stack traces from the stack depot
> "Make tag-based KASAN modes evict stack traces from the stack depot"
> (without "to")
>
> > Internally, pass STACK_DEPOT_FLAG_GET to stack_depot_save_flags (via
> > kasan_save_stack) to increment the refcount when saving a new entry
> > to stack ring and call stack_depot_put when removing an entry from
> > stack ring.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> (but see the two other comments)
>
> > --- a/mm/kasan/report_tags.c
> > +++ b/mm/kasan/report_tags.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/atomic.h>
> >
> >  #include "kasan.h"
> > +#include "../slab.h"
>
> Why?

This belongs to the previous patch, will fix in v3, thanks!
