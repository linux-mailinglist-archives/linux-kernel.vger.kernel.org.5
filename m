Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F476EF88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjHCQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjHCQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:32:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB11734
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:32:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-687087d8ddaso1011419b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691080372; x=1691685172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYYdr/1So7112CLMqwU1LIAwaDshgf8gao4QKvTkcRo=;
        b=M+ZKqYU8fXEel9JjCi2XZLWMGoWnIK/qOCrJvERH7Q/SxLUJQd0CB2YUBa7SxDVrXw
         SiBxtQ4Q5bEINOPwKrPOtjmL65gdGKMnYHSASNj31HsGY+xvFVdOLglYLW0rzSsjgqNX
         AeQDJSTuvXPi6/Sr70bXpDqS/nLz4QZWSrKfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080372; x=1691685172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYYdr/1So7112CLMqwU1LIAwaDshgf8gao4QKvTkcRo=;
        b=JQKyr9F5ZkmjFUqQ7jiE6uPUqHZHe4InFoHLdyzYiLp5juF1HT5R0GKuAJRzBOACyP
         A57Pg4aYPvfbB6krGAH58jqzhbsRHY9eheCajqyI4cDCKOUDeFYjkJySSYAY5zt4/ZfV
         +cIOXuVzbK1SOgof+z8ZqZppkabFeZnhKqka9Yljacw3Pomj4PdWXzwRW7JAU4FZ9zYI
         dlgOPpC9Kv18f7plevOAaHbOLbXO5zGntVKhsCYuAGhaGRykHq6kdhNFhHeKFtpuXnF5
         2/IHoxEIYVA3/vOipw4W1vQk3GIFmkuRmKZLsQzx9ZbORsN+G9v1ghELoDj2XYS9UZwr
         Fm9g==
X-Gm-Message-State: ABy/qLYrpfL9y8N5ytx6e2fcIyqyDVHubxZa0LLghnKJQNJhOZxUm2DD
        byNkXOPsdEcOi6UoPWa7YEBkaRMeXLPbcT2ioc+mBw==
X-Google-Smtp-Source: APBJJlEQinzR/ZwMkC8+PIX0jJqMJbe4ONAXQnmB+TG480giwzrr/DGf1KUR3Ju0EQ7Q/fBoYKbnHmKp0bMB/VzgPs8=
X-Received: by 2002:a17:90a:690f:b0:267:7021:4e3c with SMTP id
 r15-20020a17090a690f00b0026770214e3cmr19045564pjj.8.1691080371817; Thu, 03
 Aug 2023 09:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net> <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
 <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
 <CANk7y0hRYzpsYoqcU1tHyZThAgg-cx46C4-n2JYZTa7sDwEk-w@mail.gmail.com>
 <CAADnVQJJHiSZPZFpu1n-oQLEsUptacSzF7FdOKfO6OEoKz-jXg@mail.gmail.com>
 <ZMuLvKRbPfOK0IpN@FVFF77S0Q05N> <CAADnVQJvtLjByy2E6Cy1JO8REiUVtBDSfsLMgN3OvHrDwWOykw@mail.gmail.com>
In-Reply-To: <CAADnVQJvtLjByy2E6Cy1JO8REiUVtBDSfsLMgN3OvHrDwWOykw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 3 Aug 2023 18:32:40 +0200
Message-ID: <CABRcYmLAjezx+awDicxYQkoim6JS1CQ-G_9+tJADudxNe3sutg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 6:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 3, 2023 at 4:13=E2=80=AFAM Mark Rutland <mark.rutland@arm.com=
> wrote:
> >
> > Hi Alexei,
> >
> > On Wed, Aug 02, 2023 at 02:02:39PM -0700, Alexei Starovoitov wrote:
> > > Mark, Catalin, Florent, KP,

Maybe you've missed my Acked-by for the series Alexei ?
https://lore.kernel.org/all/CABRcYmLAzhG=3Do2wcBNBtFP34Aj3+eYsEMtMREDT7SqNz=
Bc9-qw@mail.gmail.com/

> > > This patch set was submitted on June 26 !
> >
> > I appreciate this was sent a while ago, but I have been stuck on some u=
rgent
> > bug-fixing for the last few weeks, and my review bandwidth is therfore =
very
> > limited.
> >
> > Given Puranjay had previously told me he was doing this as a side proje=
ct for
> > fun, and given no-one had told me this was urgent, I assumed that this =
wasn't a
> > major blocker and could wait.
> >
> > I should have sent a holding reply to that effect; sorry.
> >
> > The series addresses my original concern. However, in looking at it I t=
hink
> > there may me a wider potential isssue w.r.t. the way instruction memory=
 gets
> > reused, because as writtten today the architecture doesn't seem to have=
 a
> > guarantee on when instruction fetches are completed and therefore when =
it's
> > safe to modify instruction memory. Usually we're saved by TLB maintenan=
ce,
> > which this series avoids by design.

But I must say that this sits firmly outside of my knowledge of the
arm architectural details and I would totally miss this sort of nuance
so this is best handled by arm64 maintainers :)

> > I unfortunately haven't had the time to dig into that, poke our archite=
cts,
> > etc.
> >
> > So how urgent is this?
>
> The performance wins are substantial.
> We'd like to realize them sooner than later.

I've worked with Mark before, I know for a fact that he is dragged in
all directions. Until we figure out a way to clone him we should try
to not burn him out too often... :)
