Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C34D7D8DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjJ0Eba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJ0Eb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:31:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9D186
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:31:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-578b4981526so1363548a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698381085; x=1698985885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXE3BdGbiJaMW1JfePn5Fd+c7S292LcnRGSXMgQcGgQ=;
        b=JKu+P0kqNqOaQhkdXcWJNTm/frFmBIDLGGQs2bw/IRQ1L85t7CK/JtvxlMEUMyvW4Y
         nXBAdkqZwxoFpTh/AdVuo/3joKfq8EZbDAs8OgJZa9D8FVkTIGpgwpHwgtuM4OcwQajZ
         ynruBHXATwjEXeIpZysQuvD1iPK8uU6GvMYrO9ut7MQvvMD8rct7A+kAl31uk+Id7j+T
         /Jz83kgO8aYShaDRLjAWg7as3OlGtQypF9zMxIYi56zyRJe0GKmQZzxuHK4PyPq+E62t
         n++3XeSqIoep1RYFwxUUTEHI0pKCrG1S4eNjelJ8kCG+ihhzMvbggD/TKZiw3rNe4s3n
         GD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698381085; x=1698985885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXE3BdGbiJaMW1JfePn5Fd+c7S292LcnRGSXMgQcGgQ=;
        b=Y6ZDW2YQfssiVkQPV9ud/nxwACAPlWOl6wlxY8q+lVoW6rp9MTSi+jZ3TmAgPPlBap
         Kq+2QweHkhdg8rOulBqLORywVP+euhzu2I8VfX40Rbi7orhwF09gE0e+jqPAhWPufK/R
         LDEWcJ7mK1tLSfodV9NR5vk1dHhYb0aiHAeVVXhHPPzweo8Wa7N0GA8TtTUOgzYH0Ci/
         AA+5qayXKrj/h78n6qto8T94EFEef/uu/GcU2hwoEGGd4uOn2+v2b69AkjubkDvwoB0p
         yPNVruPkDJSGflSAGsedFh5txMoskeNHSKumVlHdtovpTZ28rAOMELiH70m3dTyeRwVe
         30+A==
X-Gm-Message-State: AOJu0Yxh5MmL4zmrIzhQkzTbvldRLtEt0b9WYBKAcBqX/ZSpExsBDp8G
        FVEipZH9VXsPhRl22Fh4PbH88lq9FsIb4Yh+HcSYUg==
X-Google-Smtp-Source: AGHT+IH1j7xyXqP3DwCFQTDS24OX+TDA2FWVupF1IKZuhrioGAIBHjfcPDT07LBSWZnf/5UobIfplJw/wsvQA5VZ8/w=
X-Received: by 2002:a17:90a:f198:b0:27d:60b1:4f2c with SMTP id
 bv24-20020a17090af19800b0027d60b14f2cmr1442918pjb.4.1698381085180; Thu, 26
 Oct 2023 21:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231026101957.320572-1-bjorn@kernel.org> <CAK9=C2Vcbq_ReGcK51uOYp+M2hakz=9=RNHaHFMbfxhth_4cnA@mail.gmail.com>
 <87a5s5z44x.fsf@all.your.base.are.belong.to.us> <87fs1x3re9.ffs@tglx>
In-Reply-To: <87fs1x3re9.ffs@tglx>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 27 Oct 2023 10:01:12 +0530
Message-ID: <CAK9=C2Xou_sZKX96c8Z7RXPCnmdf-_DPHZ8rfPmNdBqx8s_30Q@mail.gmail.com>
Subject: Re: [RFC PATCH] genirq/matrix: Dynamic bitmap allocation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Oct 27, 2023 at 4:47=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Oct 26 2023 at 19:26, Bj=C3=B6rn T=C3=B6pel wrote:
> > Note that the per-device domain support is already upstream, it's only
> > the ARM cleanups that are not.
> >
> > IOW, there's no need to wait for the ARM cleanups. :-)
>
> Correct. The &*@^@#%$ delayed ARM link was only meant as a reference on
> how this is implemented and obviously as a reminder to the ARM folks to
> get this finally done...
>
> The main point is not to introduce new users of this failed programming
> model and instead make them use the more future proof implementation
> right away - which of course might to turn out to be completely wrong
> 5-10 years from now :)
>

We have three types of MSIs on RISC-V platforms:
1) PCI MSIs (handled by the IMSIC driver of the RISC-V AIA series)
2) Platform MSIs (handled by the IMSIC driver of the RISC-V AIA series)
3) Wired IRQs converted to platform MSIs (aka wired-to-MSI bridge, which
    is handled by APLIC driver of the RISC-V AIA series)

The RISC-V AIA series needs the generic IRQ framework changes
related to #2 and #3 (above) from your series hence my suggestion
to rebase on your series.
(https://lore.kernel.org/all/20221121135653.208611233@linutronix.de/)

Is there a way to have your genirq changes merged before all ARM
drivers have been moved to the new programming model ?
OR
Any other way to deal with this dependency ?

Regards,
Anup
