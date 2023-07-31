Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFBF76A1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGaUYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:24:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723E133
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:24:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so3928828276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690835073; x=1691439873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1ItbffeIwZatJkOZRxPmlzNWTmdUBzSgiuAZZzzuKQ=;
        b=BxOFecJBQJRZe+ru1tsCnhNh41LoO0SH1sfYo82MsHDKiV5uzmMH2HV+rTpo0iS9Je
         XV6gP/58PgpC3Qr9n/EHWn6ilLCXZ0j9zjGEuHGAWO/Dz6IBJh1Kqt1StNOfp8+RpXOI
         GgEwLhTUHO5jAGIIo5EWWUn+PqTCnm7yVoYaltoik4VvIWD+HzhCG5VdajSSGM04voKL
         /cPaXj9R9e+qsqDunrlt6YB9rpDt1SdwAazZ1v0AZKoFj84PdW4QKh/8/zzdEgBccfUS
         VHVuaJOHKMS2G0RqmsfSypuvki1rMJ0MQkde+syLEvRa/yQqbkmnT1tZLFvyyRjOS6YP
         vv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835073; x=1691439873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1ItbffeIwZatJkOZRxPmlzNWTmdUBzSgiuAZZzzuKQ=;
        b=eqFo3QnOrYT7Ye0POZ6RC4X07Afh79xhPrVHeDif7NhFNqWqx0TrkUJmgV3/WqlblI
         KbAHZFOCWG22DX0q0k9qc7Efm+fcwPHy5Rbxltysx9S19viWlGPErnL9FdLCqcocVo+J
         gzwnN3zKsus+qzj9TLth6StU4FETP7DlxXe0W2oNiktgQHb4+k/HAZR3uwNW0Y2l64JD
         CQMqmoKrRYh6kF3jKzRx2/2fEGGh84CV9JIGmsO1iag74TGXEqUQR9zl/I/0jhQC8tKg
         h0t8YoXu/w+2BGa5rRMwK6ghSPBE32Ck1mXq1blUdXsua5CtCHssHtwk7tNsc2uXb9rR
         1gIQ==
X-Gm-Message-State: ABy/qLYafm4u1UyMyNQ6YPn10MLBhVHCVVxRbvY/DPbvOije2aEzA0aC
        +vlIbv/MPLzVmjruKhWQT+cCayKT2kpNQUrNlgm8Yw==
X-Google-Smtp-Source: APBJJlGuj8kX+bBpv83ZDzm2NJ6dmZvExyNUG7wdBXD6gLrKUP8Lg+v96RvFbCwdUYG16WEMseHl5z4ySmZTFe1KZeo=
X-Received: by 2002:a25:54b:0:b0:d09:2cba:bcac with SMTP id
 72-20020a25054b000000b00d092cbabcacmr8248520ybf.65.1690835072954; Mon, 31 Jul
 2023 13:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
 <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com> <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
In-Reply-To: <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 13:24:21 -0700
Message-ID: <CAJuCfpG4Yk65b=0TLfGRqrO7VpY3ZaYKqbBjEP+45ViC9zySVQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:33=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 31 Jul 2023 at 12:31, Suren Baghdasaryan <surenb@google.com> wrot=
e:
> >
> > I got the idea but a couple of modifications, if I may.
>
> Ack, sounds sane to me.

Ok, I'll wait for more feedback today and will post an update tomorrow. Tha=
nks!

>
>              Linus
