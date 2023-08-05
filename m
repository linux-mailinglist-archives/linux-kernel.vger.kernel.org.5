Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76AF770D1F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHEBgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEBgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:36:49 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A3CE72
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 18:36:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d16639e16e6so2674010276.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 18:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691199407; x=1691804207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AujeCo6jm3AYe4qZ6y6dt+l/y9fmf46ls+zy0ks6uBk=;
        b=bpswymm8/aHd6mYtUujhG2QErdghxkdOBUSisUuXISL43iBt5anSiCY7npzyoUiEp/
         2r0DThfOtkG+yPEzC58xZLlele5B03sILA+y2PDwjAPMcXtkwUcFy5lrcWm18fIezCd2
         TvTlOQPRw7trWWi7TFwzUQOVcXl3hZGoUY/y3/OIyQgS+g5h8gNRs0QcE+lMY/pkkoXy
         Ns1q4mZuMDjIYZNsw7vuvEEABh4IA+p+ZsHCspKeMOXHkfvzh6yntnLUxWpgnw8t77Vi
         bBEHLKcSkpQzi5wly6AOeCVeTC0b886H1B0C1idctkdvu2YXbxSIRxaC+odXZzrzeWAu
         h22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691199407; x=1691804207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AujeCo6jm3AYe4qZ6y6dt+l/y9fmf46ls+zy0ks6uBk=;
        b=Vlgc6llBItZTf8tfWV/GcaHNKkRWURu35WeYKoA+n9oY+yQlpAZT4lZiufY+WwmjfG
         ZMllJz/cD4RhG7ECBDCzZQND/ovl7hE3XgTIJy9qIfArAJ0553wPqHOa4tRz1jOtNH7A
         fyfDaJo3E96B4wimGD0S9x3PAf60dwXGq8iDG5lJ4yuu9oVfFuiRYk9okUsY4/fPil32
         vMYKLAS2Ag60NYhlI4PP4LP4ZMGNkQA3uFcMNQraBiI3xATuTgdOqIGiSEVcdCJO8sSE
         G3onl/CtTjdnQzPgTS+W8GDpiAI24Qaf83TqlEMB14Mzmw+Xbox6gYfA1OaCNJyd9WEX
         l8cA==
X-Gm-Message-State: AOJu0Yz7r/g218sOmw5/SU3bS/thYwBj4IFcR0snWN6LvsOA1Q2qNxHt
        svSp3O22gfrTw5JcNlIQ2ncrN07JErzsc+e4rVGQUg==
X-Google-Smtp-Source: AGHT+IFJHUDmRmfkaGOcYBONV1HYLRgCo/dnuTAMETxoZRKS9/hRI1iaTAV07Qp4qriq/KEZCcwC9+dZWAiPFh/72cs=
X-Received: by 2002:a25:d08:0:b0:d1c:7549:4e8b with SMTP id
 8-20020a250d08000000b00d1c75494e8bmr2986579ybn.29.1691199407388; Fri, 04 Aug
 2023 18:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
 <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com>
 <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
 <CAJuCfpGWGsh2BRgwcJ7oVHnqZfrtiesvhzomK0ZmxE_KK=R7FA@mail.gmail.com>
 <CAJuCfpG6BBP+fjV9oyBx3SNiKhiafPzM9vV9bx_goO2aZzAptg@mail.gmail.com>
 <CAGudoHFrDG6-u-XXEmQoPS2CJ2Wpo4ETwhXc2R=jy78RSYw-Zg@mail.gmail.com>
 <CAJuCfpHYBqULvwNELO3Gkc0bkKDV7VJxMjvBru4zaAz4WKQNhw@mail.gmail.com> <CAGudoHGm2hbjSG-2kJevF=xGpz=4Sd0m5CjVO8Ntsahqz5NcGA@mail.gmail.com>
In-Reply-To: <CAGudoHGm2hbjSG-2kJevF=xGpz=4Sd0m5CjVO8Ntsahqz5NcGA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Aug 2023 18:36:34 -0700
Message-ID: <CAJuCfpH0tG8n5AUOqxOnKgXR_ge7rU4dpW3aw0hjOUN99+WXTw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
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

On Fri, Aug 4, 2023 at 6:17=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On 8/5/23, Suren Baghdasaryan <surenb@google.com> wrote:
> > On Fri, Aug 4, 2023 at 5:49=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> >> However, the other users (that I know of ) go through the mmap
> >> semaphore to mess with anything which means they will wait for
> >> dup_mmap to finish (or do their work first). I would be surprised if
> >> there were any cases which don't take the semaphore, given that it was
> >> a requirement prior to the vma patchset (unless you patched some to no
> >> longer need it?). I would guess worst case the semaphore can be added
> >> if missing.
> >
> > No, the only mmap_lock read-lock that is affected is during the page
> > fault, which is expected.
> >
>
> I have difficulty parsing your statement.

I was just saying that vma lock patchset did not touch any other
mmap_locking paths except for the page fault one where we try to skip
read-locking mmap_lock.

>
> I am saying that any 3rd parties which can trigger page faults already
> read lock mmap_lock or can be made to do it (and I don't know any case
> which does not already, but I'm not willing to spend time poking
> around to make sure). One can consider 3rd parties as not a problem,
> modulo the audit.
>
> Past that there does is no known source of trouble? In my original
> e-mail I was worried about processes up the chain in ancestry, perhaps
> some of the state is shared(?) and the locking at hand neuters any
> problems. I'm guessing this is not necessary.
>
> Bottom line though it looks like this will work fine?
>
> That said, I'm not going to submit a patch I can't confidently defend.
> As I did not dig into any of the VMA code and can't be arsed to audit
> all places which mess with "foreign" mm, I'm definitely not submitting
> this myself. You are most welcome to write your own variant at your
> leisure. :)

Ok, I see. I'll need to double check locking when a 3rd party is
involved. Will post a patch when I'm confident enough it's safe.
Thanks!

>
> --
> Mateusz Guzik <mjguzik gmail.com>
