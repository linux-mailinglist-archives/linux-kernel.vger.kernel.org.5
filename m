Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06A7FACAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjK0Vll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjK0Vlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:41:37 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ED010CA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:41:41 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-357d0d15b29so1515ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701121301; x=1701726101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIiUOLs4B5FYCz4BIBDodRBLizz4WQxtB5imEZ+H1Ys=;
        b=gian3Wn7W3tsv5oiZuo/6dSuIE+2x8BsNSyq/SBASxG8/kGx7Vp87qXj3UkSx4TLho
         MWzK6Z1eaWckyuXVD1WFrOu0jKF/KK8FPh9fOSHdHI4iK+2qdyh/H2RfuF/akvjKR0Ek
         5aPiB3Kpjz5VGV1XbmDN5xctZEGE/OlpBRm04Ie/Z/IO/qOTxoTuOTzxORZhqCiqZ391
         KOIyHJKyNthhCE8iH8XdysMBwml9Khb4LK2Pgc5bMjPFt/EzOKgNz9bgwAk9CXeAhMg8
         /uNxTo4k4ct/Y6TgTEzm1NzkSLhe80Op3h//0MxZ+Zf/boq7+OeFBHFHRh05NRbq2nPi
         NB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121301; x=1701726101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIiUOLs4B5FYCz4BIBDodRBLizz4WQxtB5imEZ+H1Ys=;
        b=Vri/pY9Uj4gSnJSAVmigtIWezz8HtHJSP48qQbzK1P+Iv2kAd0HZC0hSlxJ5dGqFDa
         brwpOnkilntb/YpESyCHtqDmjLz7FMwl6S1oyoqX0FOW42w4FBLWAB1SeIy8mkMtxFDX
         fapsTCxXvzc47JaR+lgzoMzhmuRHHSlB312FiJbTCFjiN6n568vcYhqK/GTmDdMzASI4
         F+gzOn9CslDFgdak1sr+IBRs/1/xGGr5e1j3kzD7ZiSWXfYhFdAygRMPh9T6Yj/Ilovw
         g3Mfd0Q1mSefckNpnXTQxkM1y739s8fv1mVHx0XDlfzblHTTkBhnzAp0QmU3gR2Z6vls
         QCQA==
X-Gm-Message-State: AOJu0YxquzXGxpqSr4Ci6dms8GRecuKqZyQICUNFR8et3YCH6g9pkiwj
        Gb6fNyajh0+Nf6+6tJS9cKbNrdzOyCTNXuEBEqxeRg==
X-Google-Smtp-Source: AGHT+IGbIr/R+htW7xaVZXcb1VijRsa9rXR3s4S6dUyOEpmr2hZBOp1GOfigsseF1e08qY1EZCsyy9k88qjMupsCCfE=
X-Received: by 2002:a92:da04:0:b0:35c:e49d:3e65 with SMTP id
 z4-20020a92da04000000b0035ce49d3e65mr211441ilm.11.1701121301101; Mon, 27 Nov
 2023 13:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20231122221526.2750966-1-rananta@google.com> <d5cc3cf1-7b39-9ca3-adf2-224007c751fe@redhat.com>
In-Reply-To: <d5cc3cf1-7b39-9ca3-adf2-224007c751fe@redhat.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 27 Nov 2023 13:41:29 -0800
Message-ID: <CAJHc60zinMfkjFF=QS5R6YO0B8_Anmyw2cZ2f0QEnW0i=hWHcQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: aarch64: Remove unused functions from
 vpmu test
To:     Shaoqin Huang <shahuang@redhat.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaoqin,

On Wed, Nov 22, 2023 at 10:43=E2=80=AFPM Shaoqin Huang <shahuang@redhat.com=
> wrote:
>
> Hi Raghavendra,
>
> Those functions might be useful for other pmu tests. Recently I just
> wrote a pmu_event_filter_test[1] and use the enable_counter().
>
> There may have more pmu tests which can use the helper functions, so I
> think we can keep it now. And in my series[1], I have moved them into
> the lib/ as the helper function.
>
> [1]https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.c=
om/
>
Thanks for the pointer. If you are planning to use it, then we can
abandon this patch. However, disable_counter() may need fixing. I'll
comment directly on your patch.

Thank you.
Raghavendra

> Thanks,
> Shaoqin
>
> On 11/23/23 06:15, Raghavendra Rao Ananta wrote:
> > vpmu_counter_access's disable_counter() carries a bug that disables
> > all the counters that are enabled, instead of just the requested one.
> > Fortunately, it's not an issue as there are no callers of it. Hence,
> > instead of fixing it, remove the definition entirely.
> >
> > Remove enable_counter() as it's unused as well.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >   .../selftests/kvm/aarch64/vpmu_counter_access.c  | 16 ---------------=
-
> >   1 file changed, 16 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c =
b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> > index 5ea78986e665f..e2f0b720cbfcf 100644
> > --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> > +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> > @@ -94,22 +94,6 @@ static inline void write_sel_evtyper(int sel, unsign=
ed long val)
> >       isb();
> >   }
> >
> > -static inline void enable_counter(int idx)
> > -{
> > -     uint64_t v =3D read_sysreg(pmcntenset_el0);
> > -
> > -     write_sysreg(BIT(idx) | v, pmcntenset_el0);
> > -     isb();
> > -}
> > -
> > -static inline void disable_counter(int idx)
> > -{
> > -     uint64_t v =3D read_sysreg(pmcntenset_el0);
> > -
> > -     write_sysreg(BIT(idx) | v, pmcntenclr_el0);
> > -     isb();
> > -}
> > -
> >   static void pmu_disable_reset(void)
> >   {
> >       uint64_t pmcr =3D read_sysreg(pmcr_el0);
>
