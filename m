Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CE678DD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbjH3Sse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbjH3HrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:47:09 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8DCD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:47:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5694a117254so3284858a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693381626; x=1693986426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCs5oUbQ1jJL1mASlnk3DDNvqxPdGJwje0jZ0qvyXiA=;
        b=o7JijE7FBykuYSQxJV7v18glR3nUlfw9UDMUeOUMrN5aJcZp5m+xZG8sbJexsMC2EK
         sdTLBnPH9ncTwKcro/EyhK5ces3/YUg/vfeKh5/IcM1yXllfv0ai9z4gQuqCe/G5TvFE
         J7TRXCuYVhsAkaEFNAlnKoZTtVqtKbjnMg6XIxz/ExG2oUku3OkAAXBptfkcA4VlV4qY
         tnrWfGEO8ql+XcH5PmmHfVNdPDWsiTqOoNLidUChoRlll/mVvL/LQXifBRbon7OUeIml
         l+xhexkX8AxJxPNatoSMEl7SQJ/IHuhEQmlv3Ef47mbTUrwaB3heZpOxnr8HmhxS20XP
         3hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381626; x=1693986426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCs5oUbQ1jJL1mASlnk3DDNvqxPdGJwje0jZ0qvyXiA=;
        b=BHZXwI8c6PpMTrvdWC95bXaMi0/xveVbU6YAAfd5R5m5ZdLSNKFeTmEkGWeifNFAxg
         fQd/utuNWBu/5QsoDpkkjr25kDdFD8VvmBgDb8014kyRPDJP3v4OwvqENly1QReMd7WA
         TD73i8jBsBmRB49oi/fc2KhZbGX0zfGF5pWkQcustgyyiTGpa1qRY5YKS4wafCyO9o5O
         d+M8iNzG9OZxa9hdQVpIkHHwKMyTTO0NdU572HVJVyrPxizwj3VNeOoqAFApgpCeyK1U
         1CiBi401PQTLBHWekswtzDki/KQ6WUrHYKGMAgIGDM9SlFrsrS3NV8IRxAwPfwIksu5s
         WUdQ==
X-Gm-Message-State: AOJu0Yz9QnobznyN1XTFmaGVuC/R5IdF4wAA5VMH65mZecjV2/EbAJwE
        WlwLpsv9Ur6kC177MM+br/F4Ok/KiG5ZTGCymhA=
X-Google-Smtp-Source: AGHT+IFzKz0Ti7vI4CKRwOqZP7MwOhQS4dbp7cvjcvGpgnK8C0GTkeCPqS/KzD/64rmO2llKXoRa/9f7xiFr7uo1dJw=
X-Received: by 2002:a17:90a:fe8b:b0:267:a859:dfef with SMTP id
 co11-20020a17090afe8b00b00267a859dfefmr1352320pjb.27.1693381625844; Wed, 30
 Aug 2023 00:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230827205641.46836-1-namcaov@gmail.com> <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
 <ZOyhozSq3S36eRSq@nam-dell> <ZOymDqhE9STgx4Mm@nam-dell> <87edjmz864.fsf@all.your.base.are.belong.to.us>
 <ZO4+/P9B29Bpb0Yz@nam-dell> <87il8xm1d1.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87il8xm1d1.fsf@all.your.base.are.belong.to.us>
From:   Nam Cao <namcaov@gmail.com>
Date:   Wed, 30 Aug 2023 09:46:54 +0200
Message-ID: <CA+sZ8B8uMqYOE56T3TqDnGGyaEo+sffC_7rWFH78M8OsWc6BSg@mail.gmail.com>
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
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

On Wed, Aug 30, 2023 at 9:32=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Nam Cao <namcaov@gmail.com> writes:
>
> > On Tue, Aug 29, 2023 at 08:14:59AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> >> Nam Cao <namcaov@gmail.com> writes:
> >>
> >> > On Mon, Aug 28, 2023 at 03:31:15PM +0200, Nam Cao wrote:
> >> >> On Mon, Aug 28, 2023 at 02:48:06PM +0200, Bj=C3=B6rn T=C3=B6pel wro=
te:
> >> >> > Nam Cao <namcaov@gmail.com> writes:
> >> >> >
> >> >> > > uprobes expects is_trap_insn() to return true for any trap inst=
ructions,
> >> >> > > not just the one used for installing uprobe. The current defaul=
t
> >> >> > > implementation only returns true for 16-bit c.ebreak if C exten=
sion is
> >> >> > > enabled. This can confuse uprobes if a 32-bit ebreak generates =
a trap
> >> >> > > exception from userspace: uprobes asks is_trap_insn() who says =
there is no
> >> >> > > trap, so uprobes assume a probe was there before but has been r=
emoved, and
> >> >> > > return to the trap instruction. This cause an infinite loop of =
entering
> >> >> > > and exiting trap handler.
> >> >> > >
> >> >> > > Instead of using the default implementation, implement this fun=
ction
> >> >> > > speficially for riscv which checks for both ebreak and c.ebreak=
.
> >> >> >
> >> >> > I took this for a spin, and it indeed fixes this new hang! Nice!
> >> >>
> >> >> Great! Thanks for testing it.
> >> >>
> >> >> > However, when I tried setting an uprobe on the ebreak instruction
> >> >> > (offset 0x118) from your example [1], the probe does not show up =
in the
> >> >> > trace buffer.
> >> >> >
> >> >> > Any ideas?
> >> >>
> >> >> >From my understanding, both uprobes and kprobes refuse to install =
break points
> >> >> into existing trap instructions. Otherwise, we may conflict with so=
mething else
> >> >> that is also using trap instructions.
> >> >
> >> > I just realize you probably ask this because uprobe can still be ins=
talled before
> >> > applying the patch. But I think that is another bug that my patch al=
so
> >> > accidentally fix: uprobes should not install breakpoint into ebreak =
instructions,
> >> > but it incorrectly does so because it does not even know about the e=
xistence of
> >> > 32-bit ebreak.
> >>
> >> FWIW, I can still install the uprobe at an ebreak with you patch. It's
> >> not hit, but succeeds to install.
> >
> > It seems uprobes install failures are completely silent (see uprobe_mma=
p() in
> > kernel/events/uprobes.c). So I think although uprobes install seems fin=
e, it
> > actually is not.
>
> Huh, so there's no check if the instruction is a valid one at event
> register point?

There are some checks (eg. if the probe is within the binary), but
they are not complete.

The actual checks for the validity of the instruction is not done
until installation.

Best regards,
Nam
