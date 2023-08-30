Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB978DDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbjH3S4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbjH3H4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:56:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836A193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:56:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdbf10333bso41408595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693382209; x=1693987009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qffhXBI//HA0r55HhLgsB/tbzSiNc1A7y5JWtmP+Ocg=;
        b=mG1IuHf1sIPHD/JqYjTUoAi5a6Kg9Fm2Rw9w4hA19bC48GbqKo8APAE6of7gms0C6y
         OrC1yGOtr1VLpe2t3YrtR7OaOW2izW+cK76Ba/xHwWCYedL3DvFRFUVci9hujOzPvy/Q
         vqUkjtnZBWN8uEgRq3+2110sGPLyVwuWUnbl8Qbuap/KvUeVQl+GUpSdVNN19TqyXrJ7
         dxjBl2Q+sGHLNVBQnCKcSmWoET8o+kNc9mNssSX4DnE3D1iSa+vH7LeqlJSAb1g3ssTh
         9kAoXnXAKFpq1Jpt9CFXIQ7zs9Efh2WwEkjEpj1f0o2VEBozrDbA0vg4ysysalt/qlbc
         eHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693382209; x=1693987009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qffhXBI//HA0r55HhLgsB/tbzSiNc1A7y5JWtmP+Ocg=;
        b=Nxfpr5wuYk8pLKhk2vBtCI/5QM1jhhcH+i5eTNEFgQkRyjn9GuTZh1JFc178pqJ41/
         Zf8mR6axu5na4UUt3mm2UuzLrZlLti8IhIBRoTS2dcAOoxEvd14oLqg7VTiI8CGattmU
         16RPbSfYaYOllvkFMeM3mfAJMXQ/eJbngkWNbIFzQc/sYbomnMqFRR4V/96sx381COmE
         QZ0DOTsLiMkw8ifWSMGTJh2tZTUrz7KnEytQaIif3kDFr0iahoN57tg7siHpP/J3OW2b
         80VprxBoDPNIOZ/Ri1HLkT6lsaHxcXRPaHD5Njv107Y1h3WdyBAKELrlDNQA8iRdvkHL
         Aumg==
X-Gm-Message-State: AOJu0YzicKqYJKBqlTHcOXqenFfmChbU7HCvYhfawBWC5S2yCOoQ1Bdg
        vvmlgl7mAPVOaZxqwTZEiV6A/VPdl+7UiF73zKyQaB9g
X-Google-Smtp-Source: AGHT+IEWITQ8cCSo6yBOlFLP7t/DijKVX6fkKNAXUjjVQldwp/KfjLTZU2VFz3Y6VC1neo/ubxeJKFeimikmWbAjzPc=
X-Received: by 2002:a17:90a:7345:b0:26b:4a9e:3c7e with SMTP id
 j5-20020a17090a734500b0026b4a9e3c7emr1446738pjs.4.1693382208658; Wed, 30 Aug
 2023 00:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230827205641.46836-1-namcaov@gmail.com> <874jkjl4e1.fsf@all.your.base.are.belong.to.us>
 <ZOyhozSq3S36eRSq@nam-dell> <ZOymDqhE9STgx4Mm@nam-dell> <87edjmz864.fsf@all.your.base.are.belong.to.us>
 <ZO4+/P9B29Bpb0Yz@nam-dell> <87il8xm1d1.fsf@all.your.base.are.belong.to.us> <CA+sZ8B8uMqYOE56T3TqDnGGyaEo+sffC_7rWFH78M8OsWc6BSg@mail.gmail.com>
In-Reply-To: <CA+sZ8B8uMqYOE56T3TqDnGGyaEo+sffC_7rWFH78M8OsWc6BSg@mail.gmail.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Wed, 30 Aug 2023 09:56:37 +0200
Message-ID: <CA+sZ8B-K6KP_W+HOkjCC+7C-YmMyLVVcJv-w1PDR+ZZedfTUPQ@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 9:46=E2=80=AFAM Nam Cao <namcaov@gmail.com> wrote:
>
> On Wed, Aug 30, 2023 at 9:32=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
> >
> > Nam Cao <namcaov@gmail.com> writes:
> >
> > > On Tue, Aug 29, 2023 at 08:14:59AM +0200, Bj=C3=B6rn T=C3=B6pel wrote=
:
> > >> Nam Cao <namcaov@gmail.com> writes:
> > >>
> > >> > On Mon, Aug 28, 2023 at 03:31:15PM +0200, Nam Cao wrote:
> > >> >> On Mon, Aug 28, 2023 at 02:48:06PM +0200, Bj=C3=B6rn T=C3=B6pel w=
rote:
> > >> >> > Nam Cao <namcaov@gmail.com> writes:
> > >> >> >
> > >> >> > > uprobes expects is_trap_insn() to return true for any trap in=
structions,
> > >> >> > > not just the one used for installing uprobe. The current defa=
ult
> > >> >> > > implementation only returns true for 16-bit c.ebreak if C ext=
ension is
> > >> >> > > enabled. This can confuse uprobes if a 32-bit ebreak generate=
s a trap
> > >> >> > > exception from userspace: uprobes asks is_trap_insn() who say=
s there is no
> > >> >> > > trap, so uprobes assume a probe was there before but has been=
 removed, and
> > >> >> > > return to the trap instruction. This cause an infinite loop o=
f entering
> > >> >> > > and exiting trap handler.
> > >> >> > >
> > >> >> > > Instead of using the default implementation, implement this f=
unction
> > >> >> > > speficially for riscv which checks for both ebreak and c.ebre=
ak.
> > >> >> >
> > >> >> > I took this for a spin, and it indeed fixes this new hang! Nice=
!
> > >> >>
> > >> >> Great! Thanks for testing it.
> > >> >>
> > >> >> > However, when I tried setting an uprobe on the ebreak instructi=
on
> > >> >> > (offset 0x118) from your example [1], the probe does not show u=
p in the
> > >> >> > trace buffer.
> > >> >> >
> > >> >> > Any ideas?
> > >> >>
> > >> >> >From my understanding, both uprobes and kprobes refuse to instal=
l break points
> > >> >> into existing trap instructions. Otherwise, we may conflict with =
something else
> > >> >> that is also using trap instructions.
> > >> >
> > >> > I just realize you probably ask this because uprobe can still be i=
nstalled before
> > >> > applying the patch. But I think that is another bug that my patch =
also
> > >> > accidentally fix: uprobes should not install breakpoint into ebrea=
k instructions,
> > >> > but it incorrectly does so because it does not even know about the=
 existence of
> > >> > 32-bit ebreak.
> > >>
> > >> FWIW, I can still install the uprobe at an ebreak with you patch. It=
's
> > >> not hit, but succeeds to install.
> > >
> > > It seems uprobes install failures are completely silent (see uprobe_m=
map() in
> > > kernel/events/uprobes.c). So I think although uprobes install seems f=
ine, it
> > > actually is not.
> >
> > Huh, so there's no check if the instruction is a valid one at event
> > register point?
>
> There are some checks (eg. if the probe is within the binary), but
> they are not complete.

Oh wait, ignore that, just tested, this is also not checked.

> The actual checks for the validity of the instruction is not done
> until installation.
>
> Best regards,
> Nam
