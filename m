Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1B67A96EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjIURAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjIURAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:00:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C4C1724
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c131ddfeb8so11144151fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695315467; x=1695920267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4XnljMvhHSvDOl2lNXQmHCmuwyYv06P2O8ypwL5cCw=;
        b=LUZzA1an5zfwE6Ay164zBrHEB+IeK/jXit7eCnO2HJdZ2F9Idm9QbmV731+nIStTxg
         qWPoVLXS/r61MsvJXDHJkdgEWhhq2vSk9homV+wd4LtbEQfDHNDKOfWurSUTSAf6Q4Cf
         SioAr0LFOBZQiwdawUNrUBa6dmUuywe6yqr1iROrMdcCLUD7JAFPTWqtOc3OYxqV4FMo
         0nMHnzywTUHmswVPAOMf+Or7ByC9T5NYW6nbP6yQ4CMCiCW2bNVxumMKrrtep83U+V1r
         vPOdKQLXJEPFUFkM7hUEpfDdc2sgjmmQ30FXD3nTyf85z+BVp2oMPKU6dllvo1u/PUKp
         tcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315467; x=1695920267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4XnljMvhHSvDOl2lNXQmHCmuwyYv06P2O8ypwL5cCw=;
        b=ENmCSGGyR14BPvwYzuyTgYieGjrZCS9hQW2O+ML+1gd4xdgE7L/zKlhbJImN26hB93
         3fIdC1Iyd8obyqsbbXyhgeDyIQluGd9+GaUI6+WlK/KdTKic5OwRXmWK3o7xyCrIfJGx
         ONYYPwMGSDS6lEToC78ALfQ1BnFx4EKQ03O3pQbRNH+aIIU+nWaqy8wvj4cpah/oPi29
         UL21yWTTPShw7FRkYEvn7LnrMT8dDaDtREXgALRIwzTKXjMgvzvLeJmtmGf/P1p3T9Ky
         Nqnd3E1lAm+O9k4pcTNo+HQlKBRFOnB4rtC1yzRflK8HZbSzdP0UKG9EneW+5k8ohd99
         N1gg==
X-Gm-Message-State: AOJu0YwBDj1xakAJhomFOKS6Bx4QzAAncdBkDL5RJdy3sd9H1x7y+aAl
        0CRPtzbAaDS1wRDtveoS7pEwEgmZFz2pf2rEiULvkOUMJLpft1Sa
X-Google-Smtp-Source: AGHT+IESTkfakGFXWnCJ/VtMysL1yDXmOS36fBsROIV+3WuacHmCtVXaDl6X1Va+yd+Ft3/RcDg7ZIfby3Ha5Rd65D8=
X-Received: by 2002:a05:651c:90:b0:2bc:e882:f717 with SMTP id
 16-20020a05651c009000b002bce882f717mr5133603ljq.53.1695314978101; Thu, 21 Sep
 2023 09:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230920193801.3035093-1-evan@rivosinc.com> <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
 <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
 <CAOnJCU+YNOzw39JMjWmJFHY5QjcRrKEwULo+d9WhPfv7TejpbQ@mail.gmail.com>
 <CALs-HsvvnMFErCtShB-30xO8LR4M03riYomZy3FnvEghRua_3g@mail.gmail.com>
 <a94490f6b1dd43d5985a8b14aa93bd27@AcuMS.aculab.com> <CALs-Hsuuhmtg54TRSBtGFR9QGH4LWuO4TxUsg3NVzoPj3g6HzQ@mail.gmail.com>
In-Reply-To: <CALs-Hsuuhmtg54TRSBtGFR9QGH4LWuO4TxUsg3NVzoPj3g6HzQ@mail.gmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 21 Sep 2023 09:49:02 -0700
Message-ID: <CALs-HsuyJ41ohF3sodr5weASWLq2kCHf44Ks_bH=J0gcxKm-Ow@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
To:     David Laight <David.Laight@aculab.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 9:44=E2=80=AFAM Evan Green <evan@rivosinc.com> wrot=
e:
>
> On Thu, Sep 21, 2023 at 3:22=E2=80=AFAM David Laight <David.Laight@aculab=
.com> wrote:
> >
> > ...
> > > > For probing alignment speed, you just care about running it on that
> > > > cpu. Correct ?
> > >
> > > For this we care both about not migrating to other CPUs, and also
> > > secondarily minimizing disturbances while the test is being run.
> > > Usually I equate pre-emption with migration, but in this case I think
> > > the worker threads are bound to that CPU. So I'll keep the
> > > preempt_disable/enable where it is, since it's harmless for CPUs othe=
r
> > > than 0, but useful for 0. I also like it for readability as it
> > > highlights the critical section (as a reader, "is preemption disabled=
"
> > > would be one of my first questions when studying this).
> >
> > You need to disable pre-emption to get any kind of meaningful answer.
> >
> > But why do you need to run the test on more than the boot cpu?
> > If you've a heterogenous mix of cpu any code that looks at the answer
> > is going to behave incorrectly unless it has also disabled pre-emption
> > or is bound to a cpu.
>
> I don't think it's safe to assume misaligned access speed is the same
> across all cores. In a big.little combination I can easily imagine the
> big cores having fast misaligned access and the slow cores not having
> it (though hopefully the slow cores don't kick it to firmware). Since
> this info is presented to usermode per-cpu, I'd like it to be correct.
>
> >
> > One obvious use of the result is to setup some static branches.
> > But that assumes all cpu are the same.
>
> Right, this could be used to set up static branches, or in an ifunc
> selector. This is why we provide pre-computed answers for "all CPUs"
> in hwprobe. If the situation I describe above did happen, code asking

Correction: Not exactly precomputed answers, but cached vDSO data
capable of quickly answering usermode queries for systems with
homogeneous CPUs.
