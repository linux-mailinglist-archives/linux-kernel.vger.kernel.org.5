Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47976A497
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjGaXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGaXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:12:29 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A42213C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:12:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d2b8437d825so2764676276.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690845131; x=1691449931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aSUlR+SDHyoudPduOpoIhkwapimZgmTp8fIG9ADB4Q=;
        b=KiRclaJ020M5km1rqDy5NohJgS+QzqMm6yp5lX2uUUqHUJQUtOeDEpShsn/pAinsP/
         PTHGUIaFR9PAH+wpyz46BKmGXXCA6MecR8VPAFsKNisS0QfM6ZbF2AipxshUMc0FTmcy
         eQjqtt7GmdtZmTN2Km/0yUj17Fh9LH5wh03PWRhLPi29DcYjnzUpa4pKnv26EgaKCazQ
         FZGFBJGd2t7sYsj01AVkC3iphPsRfRX4PVlMk3hcpFXqWvLctnsBw9AAWeM1qvL+4xDV
         OGSBhH9ejA23J/iKD9DWCN7v/Z9WfKZrK9w2t0cWVUr/AQEPpyir+V+AL+9J8jvzmw/Z
         cBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690845131; x=1691449931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aSUlR+SDHyoudPduOpoIhkwapimZgmTp8fIG9ADB4Q=;
        b=aapdT2MpPka93h8vwvjq70CbZEur5c49oWTIs4oxyxXsb33kN8vvhEjtDHxQOUP+MB
         MWdeRkLW7PnrrPWFISCxGbmgQxSw3ARyLUcQ6fAmgvtnS0uPb3Drns49lHv8vIl+uOSA
         TFAIMvq8f9Y3NPMXhJDMt5PHypNhfiqby4buZ3hta+I6bE8JgR2AFQCC3UVMf+wZRnpI
         MVDL/2REcu74np5Z3Qp/4hadaK57mY0QjqJOTMb3NxoNi6LqtPBtEpp8nH3nsr+laKrC
         ww9M9fBFtFfCzprZB4F9SwDnjtza42FmXSrD3NYPTF5ALHRbkYfprVwi9otmKlW26wox
         Dxmg==
X-Gm-Message-State: ABy/qLZtJz8pcnjlap/kYPfcw7Yn7MsfEpq4BEcJn1OKjdEXdPolrogK
        HN7u8yj09uQ9Yce0XAsw2UF3WaV4qNyQCvoYT7bD8g==
X-Google-Smtp-Source: APBJJlHh+LlC4j1M0JXSf0XS+j3eIbROjGDGFaLWOqMmSB1I5jLNEPo/YW6J5CzonHErb4E3oSv8DWMCvbw3Ht1RKV0=
X-Received: by 2002:a25:cc4a:0:b0:d07:87b0:f2a8 with SMTP id
 l71-20020a25cc4a000000b00d0787b0f2a8mr11375648ybf.21.1690845131480; Mon, 31
 Jul 2023 16:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230728120909.234244-1-ram.safiullin2001@gmail.com> <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
In-Reply-To: <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 16:12:00 -0700
Message-ID: <CAJuCfpEjozCfqfPPttcnWdzhQBCGnr+MzWGN8FT40YObZf_mGA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add documentation to PSI section
To:     Ramazan Safiullin <ram.safiullin2001@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
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

On Mon, Jul 31, 2023 at 4:10=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Jul 28, 2023 at 5:09=E2=80=AFAM Ramazan Safiullin
> <ram.safiullin2001@gmail.com> wrote:
> >
> > While creating a patch for the psi documentation I noticed that
> > MAINTENERS was missing an entry in psi.
> >
> > Add entry for psi documentation.
> >
> > Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>

CC'ing Peter to pick up into his tree.

>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a5c16bb92fe2..2da6643b9488 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17103,6 +17103,7 @@ PRESSURE STALL INFORMATION (PSI)
> >  M:     Johannes Weiner <hannes@cmpxchg.org>
> >  M:     Suren Baghdasaryan <surenb@google.com>
> >  S:     Maintained
> > +F:     Documentation/accounting/psi.rst
> >  F:     include/linux/psi*
> >  F:     kernel/sched/psi.c
> >
> > --
> > 2.25.1
> >
