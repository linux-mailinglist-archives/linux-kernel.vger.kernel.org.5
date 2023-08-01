Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5976B2CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjHALM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjHALMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:12:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6755B81
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:07:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99357737980so862768666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690888041; x=1691492841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J60o5PFiGGlxEE9h4Oj5q/VshfYP5C1TH1vntST7SXs=;
        b=X9mAERXs7M5anajTRTNYO4P561sc08ONCp2TEZofj7udcYl2UpMFrbotb22ghM0TnT
         G7W72OWRCz4AS8jCC1sds6k3wuwtgfjP0Pb3vl3MAMrWral2wz24aE1A1KKwU97tdCVr
         xGSPo1RhsWE/4jH056lxTYcw0TvTl2mzomE2w17OGgJOaL5rcLyINVksGnoJnSnih7Td
         PS4Ykcbk56ba+u7FYNhZ1vttN2YJAL1BxqFS9lIG8CpmZj7W5JyYhS6Yu90Q4xW5wKvw
         6c8/u5XzRZR8loMTWVofSpvTTu9UWQz9QVa8j02Lm4aDn1CqnQaykeYJTQWdKl+VXxH1
         dBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690888041; x=1691492841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J60o5PFiGGlxEE9h4Oj5q/VshfYP5C1TH1vntST7SXs=;
        b=X/fnVcif2/r1zMq0mYskaw173s8ZORTuLXSs1Pm8r0aZNj/18PGvVVRuzMELTy1OYd
         lw0lZw0CD8zEp9xoe19ZyntlLT9Ixpk90eejRiTck7qvr08qqNcrjG/SegErd2XOLYiq
         nF+E8E5DVESdFhv5dRPuzLxv/lR7Cb4andaP7mJkBX9inNYbd9XQI6bGMRG3c7WsiHhI
         yKJwYZVJezVSz5LV7NEZj0vUdob5xrSfbtsBIcgt5px0817l2wQvj9D7YysDSjOSH2dI
         l/EngxzKZYlLvY3zcdHgZY+DPjto4uutOWNjXz/ED4Vqs2qzaZ8aveyevZbRS52gZY9s
         w8Tg==
X-Gm-Message-State: ABy/qLYNIWO354bw579PnwIAdnIk0jqCPFQ7fOxvc0itCvfl1fZ6FaDm
        G1T9BWwOANcBjm/kWwTubzRoRW2Tn5TBbikwQNA=
X-Google-Smtp-Source: APBJJlHIp8zA9hn4mNFJpVDxaAC12lPnUR8zFSo4mmms+0fFcaDeHGGZHQJ8SN5oP0dk0eb41Ob/ti6o9JhcjrQHlMY=
X-Received: by 2002:a17:906:2250:b0:993:e695:b589 with SMTP id
 16-20020a170906225000b00993e695b589mr2157715ejr.20.1690888040603; Tue, 01 Aug
 2023 04:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
 <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
 <CAJuCfpEjozCfqfPPttcnWdzhQBCGnr+MzWGN8FT40YObZf_mGA@mail.gmail.com> <20230801103936.GA79828@hirez.programming.kicks-ass.net>
In-Reply-To: <20230801103936.GA79828@hirez.programming.kicks-ass.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 1 Aug 2023 13:07:09 +0200
Message-ID: <CAKXUXMwJk2bB-mPpeAj8dU3DVhdX-TRRV6eXSjMVO16Xsivj3g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add documentation to PSI section
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Ramazan Safiullin <ram.safiullin2001@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 12:39=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 31, 2023 at 04:12:00PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Jul 31, 2023 at 4:10=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 5:09=E2=80=AFAM Ramazan Safiullin
> > > <ram.safiullin2001@gmail.com> wrote:
> > > >
> > > > While creating a patch for the psi documentation I noticed that
> > > > MAINTENERS was missing an entry in psi.
> > > >
> > > > Add entry for psi documentation.
> > > >
> > > > Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>
> > >
> > > Acked-by: Suren Baghdasaryan <surenb@google.com>
> >
> > CC'ing Peter to pick up into his tree.
>
> Well, I'd need the actual patch email, otherwise I can't apply. Either
> bounce the thread or have it be resent.
>

Speaking on behalf of Ramazan, who I am working with:

Suren, Peter, should we actually better just add you, Peter, as a
reviewer to PSI in MAINTAINERS, so that you get all the patches to psi
stuff in your mailbox and you just need to wait for an Ack from Suren
or Johannes?

Then, we could fix this up in the PSI section and just send out a v2
with the current Ack from Suren and Peter in CC.

And we will fix the typo in the commit message above:
s/MAINTENERS/MAINTAINERS/

Lukas
