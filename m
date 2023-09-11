Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09379C318
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbjILCjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbjILCjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB4D9151C7F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694484207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BH+/X6+us+C2Sv1WTpowJCU4Y6vxr+AqH+IpewujWXA=;
        b=TkdzB8yCZBVDvATrGftxMpM+FB+C0mQnHCzZhNT8qxe/bscYchz88XTZPbVq8BP4nw6Gg6
        QxJ+l5E6X6GuljSoFqUA/ZPxO5Q33VX1+VpFE5+fTLJgEUYe4mwVE5lggj+pL5HuSF7S/J
        g69v7CFpgOcJ/Q9M6O4gJrVJWftxtGU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-ztDfMtWbOg6avSkAEeE-lw-1; Mon, 11 Sep 2023 19:43:26 -0400
X-MC-Unique: ztDfMtWbOg6avSkAEeE-lw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-79524453b83so327538239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 16:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475805; x=1695080605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BH+/X6+us+C2Sv1WTpowJCU4Y6vxr+AqH+IpewujWXA=;
        b=ncsMGdFleyobfBgJWk4akFvhZP1kCo3xDA/yYG45CAWQ0YgYxMv41x+MS5dbdzKLwZ
         yYMc+m8W98l/ujDbxV83NVhnqi95eG/q9IcF5Oz08qT5xXtl1+3bP75/4oh1PbWBs20e
         rxKHX/dGXXqkyW0AKv85NsvBN89AgxQsUYHw8hcE1psi452KTcFzsvRIqh2JJxNLq2TF
         Twdx/Kq75q7cYlv6WFiXLNq+AQ8o6kkzk5lKJoGy3rBkyBMfMNtZuMKybTWDENET/Pxq
         cv2euv0NJlNlZlfyzg5siBTvMUoAsZ0lItn7tQMdnVmHGWmD5aV/jguYaY4zFAKI/PMw
         DuUw==
X-Gm-Message-State: AOJu0YwJWO7c4FF8qBu6JOAuAvTBlwqFZJwARQwgmZKDHpaeSilfbJzz
        HUIDH003EXjsRjC7NesDMrj7XMLk2RneyQSax98afyLjSJ/ce6ans6kmLDXgII5GF1DjdzZJj71
        4jkW22c0iVVs4lhkfiNFJd6LEO/n4Xdwf4r51vfcRhWS+VCYv
X-Received: by 2002:a5d:9d18:0:b0:794:eaef:f43e with SMTP id j24-20020a5d9d18000000b00794eaeff43emr13267123ioj.1.1694475805277;
        Mon, 11 Sep 2023 16:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn7eAyTlkQCrUG+tz74oJzeVrF1RuMLnJWV4zMybfdK4nys8wn27JtmSwAkBl96ENakLemQeTLp2nPL32bjuk=
X-Received: by 2002:a05:620a:4416:b0:76d:83ae:fdcd with SMTP id
 v22-20020a05620a441600b0076d83aefdcdmr13700304qkp.57.1694475364812; Mon, 11
 Sep 2023 16:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230911193752.27642-2-leobras@redhat.com> <85563fd1-b9c1-60a9-24bc-4e5f7ee3bea4@infradead.org>
In-Reply-To: <85563fd1-b9c1-60a9-24bc-4e5f7ee3bea4@infradead.org>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Mon, 11 Sep 2023 20:35:53 -0300
Message-ID: <CAJ6HWG4D9LcChS3_LY7JaFm8wrOwzvyRcU2K_A8q+UgFVY15qQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] scripts: Introduce a default git.orderFile
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 7:58=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 9/11/23 12:37, Leonardo Bras wrote:
> > When reviewing patches, it looks much nicer to have some changes shown
> > before others, which allow better understanding of the patch before the
> > the .c files reviewing.
> >
> > Introduce a default git.orderFile, in order to help developers getting =
the
> > best ordering easier.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >
> > Please provide feedback on what else to add / remove / reorder here!
> >
> >  scripts/git.orderFile | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 scripts/git.orderFile
> >
> > diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> > new file mode 100644
> > index 000000000000..3434028be2f2
> > --- /dev/null
> > +++ b/scripts/git.orderFile
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +# order file for git, to produce patches which are easier to review
> > +# by diffing the important stuff like header changes first.
> > +#
> > +# one-off usage:
> > +#   git diff -O scripts/git.orderfile ...
> > +#
> > +# add to git config:
> > +#   git config diff.orderFile scripts/git.orderfile
> > +#
> > +
> > +MAINTAINERS
> > +
> > +# Documentation
> > +Documentation/*
> > +*.rst
> > +
> > +# build system
> > +Kbuild
> > +Makefile*
> > +*.mak
>
> Can we have Kconfig* here also?

Sure!

Thanks for reviewing!

> thanks.
>
> > +
> > +# semantic patches
> > +*.cocci
> > +
> > +# headers
> > +*.h
> > +
> > +# code
> > +*.c
>
> --
> ~Randy
>

