Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5576EE52
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbjHCPiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjHCPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:38:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A8E1723
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:38:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbdc05a93bso8001095ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691077104; x=1691681904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QvK5qLFHmDLYgmxeLVpHf8hOEC5ENBQua82Fe9j6mw=;
        b=RaDdMNGHVBiDOw5FJ7FnpNp7JDEPA3rmoZZARR0MqdZBedo4Aa7wjec/zk94WFTD9A
         n5yIlrryCLjvPzw3JqLMR2ek0cU5+zlLq86tMwiFc3SfFoWuxSAUFOqHPS3KVXy9qsg3
         PAe09TqVnh0qg0qGWPsRTqiSUIyJUOpecWgiIx/m7J8kCAf3kWP8s6Kv9QIBZR48cjG+
         auQ0gaALf15tGTxx79k+JI3B1MaHeLIvqe8/MbJh9CpsGCD54vUnGd7ahE1G2GnzoXJ1
         eUd1s/9eiqe8eAcN6k54kVtUiZ8L+M7jOX2mJbgTom4RZ/XQGTNCUxP30t1IRoMnyIEJ
         sYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691077104; x=1691681904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QvK5qLFHmDLYgmxeLVpHf8hOEC5ENBQua82Fe9j6mw=;
        b=MI/Bo24pZIzu6v5Qt0eYVVf/xNu5K+JWumQqawyqZN6N+oOi6eR6kG73QKTcroBV7H
         yyqTX4TOYFhv+611wA1RgOWwJnqNk91Vbs5AfYK3k/eoU2u/BxB1lEjNX8zO/gasB9gw
         FCgYPgY77XoG0g/MwV6SJJA2tyjOEBeBLyTc8D91YdF5/zrlrxne+phlvSEr1vN9WDFR
         h/8k5ygotkyucPd9KK+TR9MGmm1ku07V3TYc2qeHmi+75GhwjK2hyzoAPUfP22OtwLiQ
         zig0yi+S+zq8FjtCIOv9+9Bz7UN9TdVU86uQFKR7Nx9f5F7tSUaB2p6nVDGr1q8PoiIS
         UE/Q==
X-Gm-Message-State: ABy/qLaMbCdZchRLfd0qSiyfsFEaeWvY5HEQWJdWbK3kcPHl/5FQ2h6T
        b2EWJoZdfOWsPAVys1hPBm+HiTN4TH50kEFwTIeopBXHjzOqsI5rq/y7CEMwntY=
X-Google-Smtp-Source: APBJJlFi3FG0mAvcMB9URJbwWzw7i1zKH1Hu2Qv4hQ03Ohnz0WVeZbzZgJo+XDAz8aN7gZRHOMPt1IZFV5uBcYVsoeU=
X-Received: by 2002:a17:902:ab0c:b0:1b3:ea47:796c with SMTP id
 ik12-20020a170902ab0c00b001b3ea47796cmr15680373plb.29.1691077104397; Thu, 03
 Aug 2023 08:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230803132818.2092166-1-luxu.kernel@bytedance.com>
 <20230803-curtly-sandbox-9ff8c7aafb85@spud> <CAPYmKFsbGMRY7S6WguDHkkY1futTS7+piKf83Pb+aktO2yLXpw@mail.gmail.com>
 <20230803-sage-mongoose-2452dbe3109d@spud>
In-Reply-To: <20230803-sage-mongoose-2452dbe3109d@spud>
From:   =?UTF-8?B?5pet6Lev?= <luxu.kernel@bytedance.com>
Date:   Thu, 3 Aug 2023 23:38:09 +0800
Message-ID: <CAPYmKFsQxA+TpecdmK6rcOnH+AeF0PmGMNriowZ=aK1=vfetBg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RESEND] riscv: Fix local irq restore when
 flags indicates irq disabled
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:24=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Aug 03, 2023 at 11:20:53PM +0800, =E6=97=AD=E8=B7=AF wrote:
> > On Thu, Aug 3, 2023 at 10:36=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > Hey,
> > >
> > > On Thu, Aug 03, 2023 at 09:28:18PM +0800, Xu Lu wrote:
> > > > When arch_local_irq_restore() is called with flags indicating irqs
> > > > disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> > > > implementation based on csr_set() function only sets SR_IE bit of
> > > > CSR_STATUS when SR_IE bit of flags is high and does nothing when
> > > > SR_IE bit of flags is low.
> > > >
> > > > This commit supplies csr clear operation when calling irq restore
> > > > function with flags indicating irq disabled.
> > > >
> > > > Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> > > > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > > > ---
> > >
> > > There's no changelog or explanation, so what is the reason for the
> > > resend?
> > >
> > > Cheers,
> > > Conor.
> >
> > Sorry for disturbing you.
>
> Nah, tis fine.
>
> > I haven't received any response since the patch was sent last week. I
> > think maintainers are busy and thus I want to have a ping. This patch
> > was resent because I found it is said that resending patch is one of
> > the methods to ping maintainers in this kernel doc:
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html.
>
> Right, resending is a valid way to do that - but leaving a comment about
> why you are resending under the --- line is advised so that people know
> why it is that you are resending.
>
> Thanks,
> Conor.

Got that. Thanks very much.
