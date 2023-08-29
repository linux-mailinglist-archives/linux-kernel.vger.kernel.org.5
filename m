Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7F78C7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjH2OrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjH2Oqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:46:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222DFCC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:46:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso66536811fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693320406; x=1693925206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnQJ5RlFnma/9gchBlknmNpXDI6oKIUQEmJTsZOL0fk=;
        b=Lc3sdSLR154c/3Hz6IykxmZeUtriOVuO8zdwMjCZdu6tQVuq6JcvdP8P2c4fSG/vyb
         AMlmRh2yPXwJLZNVekbmX3JJjVt++10/HBLlE8sf4e1Evns0URcH0YxXKI3gtRR+TClG
         Te+WsJ55fkmBkOJ0DEhmRqNYfKVho8GMM78OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320406; x=1693925206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnQJ5RlFnma/9gchBlknmNpXDI6oKIUQEmJTsZOL0fk=;
        b=UCNoEXsucUtRr2H2CfwhSetGiOJg2W6phvHyZnby5SP+4flo3W3PmPFGSuq7jgb4Ij
         tWHQiBgo4lQ3GMkC6bJZQ/i/Uwo+0nZcD1nRbPlkcmkf0QyS3QTeZnLqtNrHRwflZTIW
         mNUoB3QicpNfUq+hpfq+Nsd0mtnaPi67WFRMw6d14SV1ptG4Wf2ACw0AA7FkEpFgIgBR
         7e0i8LdOrMKvkGGzFhjMDWgswOqRnSIQE0sHCIVuMKQ1xDMRQOzjI5cN13c4ocAuHGCg
         54tunII+oN/Jb5ZWybrQab7PWKOZTHuMZuWI8iUiPNi9G7YemXLx+4YKrAX+7YUk4iXZ
         QeEQ==
X-Gm-Message-State: AOJu0YyXRNqQNGC0C9LUV2Hn6ZJdbVqc5L4xyiN4BXltxfoPYx+PaGno
        SGOHUEUYCu6SxvrsQnypYqdhJRjR7ilzpFgstFl21xryl0vD+PaU
X-Google-Smtp-Source: AGHT+IHFIIs+B47JJP4BF26EqCYwygNc1qnS3IfDxU8w1ctm6bZur28At4kLq+yymeZAa0CznER413+aFnR+mTcnjew=
X-Received: by 2002:a2e:9649:0:b0:2bc:c28c:a2b8 with SMTP id
 z9-20020a2e9649000000b002bcc28ca2b8mr16902909ljh.27.1693320406233; Tue, 29
 Aug 2023 07:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
 <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com> <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
 <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop> <20230828133348.GA1553000@google.com>
 <142b4bff-6a2e-4ea0-928c-3cfe9befa403@paulmck-laptop> <CAAhV-H4MrUm2xZdZyAALV-r+aKMRQ50v6me6hybpR1pRijirqw@mail.gmail.com>
 <CAEXW_YT-z6s+4MnxTnwFk2-mPba65dbnZogdPDSr14LmOW-h-g@mail.gmail.com>
 <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
 <CAEXW_YTfV1NVb3tOhunHZK_6oeUHxz_azv6uVq3k0O2UEAX5OQ@mail.gmail.com> <CAAhV-H6oN69rV2OyGzUganRv4KbS7a3_gNyWhCqVp51Ay9Q_=g@mail.gmail.com>
In-Reply-To: <CAAhV-H6oN69rV2OyGzUganRv4KbS7a3_gNyWhCqVp51Ay9Q_=g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 29 Aug 2023 10:46:34 -0400
Message-ID: <CAEXW_YRpT8wcLmsaHA6yMQ-ZCNYG7v4b4m-qvLHVxcbOJJcrPg@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:08=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Joel,
>
> On Tue, Aug 29, 2023 at 4:47=E2=80=AFAM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > Hi Huacai,
> >
> > On Mon, Aug 28, 2023 at 11:13=E2=80=AFAM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> > >
> > [...]
> > > >
> > > > > [Huacai]
> > > > > I also think the original patch should be OK, but I have another
> > > > > question: what will happen if the current GP ends before
> > > > > nr_fqs_jiffies_stall reaches zero?
> > > >
> > > > Nothing should happen. Stall detection only happens when a GP is in
> > > > progress. If a new GP starts, it resets nr_fqs_jiffies_stall.
> > > >
> > > > Or can you elaborate your concern more?
> > > OK, I will test your patch these days. Maybe putting
> > > nr_fqs_jiffies_stall before jiffies_force_qs is better, because I
> > > think putting an 'int' between two 'long' is wasting space. :)
> >
> > That's a good point and I'll look into that.
> Another point, is it better to replace ULONG_MAX with ULONG_MAX/4 as
> Paul suggested?
>

I could do that but I don't feel too strongly about it. I will keep it
at ULONG_MAX if it's OK with everyone.

> > Meanwhile I pushed the patch out to my 6.4 stable tree for testing on m=
y fleet.
> >
> > Ideally, I'd like to change the stall detection test in the rcutorture
> > to actually fail rcutorture if stalls don't happen in time. But at
> > least I verified this manually using rcutorture.
> >
> > I should also add a documentation patch for stallwarn.rst to document
> > the understandable sensitivity of RCU stall detection to jiffies
> > updates (or lack thereof). Or if you have time, I'd appreciate support
> > on such a patch (not mandatory but I thought it would not hurt to
> > ask).
> >
> > Looking forward to how your testing goes as well!
> I have tested, it works for KGDB.

Thanks! If you don't mind, I will add your Tested-by tag to the patch
and send it out soon. My tests also look good!


 - Joel
