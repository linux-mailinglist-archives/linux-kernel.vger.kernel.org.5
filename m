Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490F37A9F56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjIUUVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjIUUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:20:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E34F933
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c008042211so20400621fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695316516; x=1695921316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFcwkCsyNvb3+F2dBflUU/e2F/txYXL9uZkq7j4g1FI=;
        b=wdF2OsQpDO8CaaI+CjYLhKaPJgdE+ZAkmkgRCfRpUi3L/+/AHl16BBz9sOb72x91DW
         W8Yj2YDh9dacDQWDFTZTNHcCJZt9/CkgqH5/5+pfBdEWgtZ48mZO4rKpVsTbKG9NAGCX
         lNdr+ve1E1ZMvVIW1UW+z8GU6ZV+ru+o3YSJFq7s0/+LylyhWMaQwRl4+MS/ZS4bTIUj
         bL3LFWHWMctNbWIv+ML6irjYGOU3QFzcNC+yOov6HxygK73SCEeJZyFqybiR/cPy8uWZ
         PW6crdhOV1m/jgPRTsjebimVWy/0m/f1GyOj+qLbvFSYhmmfz9HMiouL6Q7rUERg1IjW
         Gyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316516; x=1695921316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFcwkCsyNvb3+F2dBflUU/e2F/txYXL9uZkq7j4g1FI=;
        b=pSMlcVJs8IIAwDxpC89FcdVDohP/RLsJXmOTZDRdo8pFQecCeYuLVZpA0w0X7eQDTT
         uSWvo0TXQPCOpQwpeXkXoXuCQO3uJFKTu429W5DkDIZrJ90MTVJ/OkaEzs32+m4U6jEH
         Qlj9DvcyIbdJuvrNd3kB9eg5VjzZwjBFxfi9ewl+HLmLHiMto0mpMDHnB23avKFzG57T
         0elR28jAeoGfrafAqWZ0tjQ1ObBCI2vTDPGVS3eHGJTtuwfkuRNUmcXOhOCusj18dMk5
         cFle9MDPPMLPUu/GtS+84wu1NIkzYAS13N3x+RphiNZE4+kgPafrbmIO+5fpjsTbEFWR
         Rf0Q==
X-Gm-Message-State: AOJu0YxI4lgsdhcjlO+BiuvWsbZcIjnvlxsjKVgeHT7gRaOI3pLpqn1h
        uNsOmsJOS0GRaQpdLR1QK02zUkGr0ZE57KC2cX5nK2NUMcKhNlpx
X-Google-Smtp-Source: AGHT+IFNezL7iZrcu9U0R/PCxUbFl1VTTxffcH3c3kpwj9r61fMAUV/sWK+nSgSyoGMEtsvb1Pu8+P6qFlABdx1A6ro=
X-Received: by 2002:a2e:3306:0:b0:2bc:dfab:5dc8 with SMTP id
 d6-20020a2e3306000000b002bcdfab5dc8mr4897815ljc.37.1695314735888; Thu, 21 Sep
 2023 09:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230920193801.3035093-1-evan@rivosinc.com> <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
 <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
 <CAOnJCU+YNOzw39JMjWmJFHY5QjcRrKEwULo+d9WhPfv7TejpbQ@mail.gmail.com>
 <CALs-HsvvnMFErCtShB-30xO8LR4M03riYomZy3FnvEghRua_3g@mail.gmail.com> <a94490f6b1dd43d5985a8b14aa93bd27@AcuMS.aculab.com>
In-Reply-To: <a94490f6b1dd43d5985a8b14aa93bd27@AcuMS.aculab.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 21 Sep 2023 09:44:59 -0700
Message-ID: <CALs-Hsuuhmtg54TRSBtGFR9QGH4LWuO4TxUsg3NVzoPj3g6HzQ@mail.gmail.com>
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

On Thu, Sep 21, 2023 at 3:22=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> ...
> > > For probing alignment speed, you just care about running it on that
> > > cpu. Correct ?
> >
> > For this we care both about not migrating to other CPUs, and also
> > secondarily minimizing disturbances while the test is being run.
> > Usually I equate pre-emption with migration, but in this case I think
> > the worker threads are bound to that CPU. So I'll keep the
> > preempt_disable/enable where it is, since it's harmless for CPUs other
> > than 0, but useful for 0. I also like it for readability as it
> > highlights the critical section (as a reader, "is preemption disabled"
> > would be one of my first questions when studying this).
>
> You need to disable pre-emption to get any kind of meaningful answer.
>
> But why do you need to run the test on more than the boot cpu?
> If you've a heterogenous mix of cpu any code that looks at the answer
> is going to behave incorrectly unless it has also disabled pre-emption
> or is bound to a cpu.

I don't think it's safe to assume misaligned access speed is the same
across all cores. In a big.little combination I can easily imagine the
big cores having fast misaligned access and the slow cores not having
it (though hopefully the slow cores don't kick it to firmware). Since
this info is presented to usermode per-cpu, I'd like it to be correct.

>
> One obvious use of the result is to setup some static branches.
> But that assumes all cpu are the same.

Right, this could be used to set up static branches, or in an ifunc
selector. This is why we provide pre-computed answers for "all CPUs"
in hwprobe. If the situation I describe above did happen, code asking
on behalf of all CPUs would come back "unknown", which is true (though
would probably default to the byte-copy version). More specific
environments might choose to curate their scheduling a bit more, and
this info per-core would be useful there.

-Evan
