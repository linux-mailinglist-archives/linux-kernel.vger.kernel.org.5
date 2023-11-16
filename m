Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37387EDE38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjKPKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKPKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:12:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A319E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:12:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2800c221af2so474044a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700129548; x=1700734348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhaFfpVqJgGoKXCozqLAMmf/sLVC3yUm3pzsgBTdMG4=;
        b=YKz4seFq2A99m3DtPEcz6audqpi6dM+BwkTTNFoLdnezZcj5gUbvwSJFmwprtFWX9k
         CgMVKfcfbvQAth6B919KuIZ3eKJJETJyZYAZepF0wDjISvufUiwxXx+d/tRNijJXPfK0
         Oo5guKeuuyADEaKg+5cc0SkEq9C2sQ+UmY4kWJVfWVCWZ2pT1ZVkXFR5DP0gqT5S8jLy
         B38AVcVpI1XFCcsjjCM9EszCCauH6Zv/2wjMrwYEolpZARhO4clytdE2cbtLPssaOxsB
         ZY4xHtzz2d8UpaRABJ4n9j8CuWNjyyLsIqx6d4fZPlMAfIu1k7OgteJ5JtaVzURwbWsZ
         v5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129548; x=1700734348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhaFfpVqJgGoKXCozqLAMmf/sLVC3yUm3pzsgBTdMG4=;
        b=q0NfwjQkjGZSfpASce5YFJRKNROdnt9TyUUIxSnU/eRP7K5+0sd9yKU8uyemtjkzi0
         E5hUgcFuHs2fqC6aAv0nYtlNSKdwHQmGGVEfnSUM1hXviocqiHUXYhLxkZrXHY2Abr+2
         360+s4P2hBBPzT32f5/dKcLzScZmBkn6Dt/hhLLh/W7SJ1j4F69gANHiGUN0DXdexN0v
         OYB+JSd/ykSQHX2Zxw0FpghNvEgZl4WhOdG0+v7HzkVVh82yqHkDmZBgpzHoxvAsrGZU
         TrOV5SFX4tg098b83kZFpI8FlP0H+bwtWWNDhdWC8cGeo5VtV1YbJ5vObCmjfzkCs1qj
         E9VQ==
X-Gm-Message-State: AOJu0Yxpz4YdDdzkPdIkeD52rzqGqanLTJNZndue3Suqi7vgf1yuRHcd
        7+zlfggGa+3mGoluA2/Q0r5MD+vjm6qM74Bu2GYwYA==
X-Google-Smtp-Source: AGHT+IGO493FTH5Nga22fHGWOfhfWijW+qFSfcR7qeGsqzA6k31EsikJ0C3BCeQcR0M5rGmr1UDLtKQpgrLpfjDTJf8=
X-Received: by 2002:a17:90b:3b83:b0:280:cc73:4c79 with SMTP id
 pc3-20020a17090b3b8300b00280cc734c79mr12707187pjb.7.1700129547996; Thu, 16
 Nov 2023 02:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20231116040749.8430-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20231116040749.8430-1-joshua.yeong@starfivetech.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 16 Nov 2023 15:42:15 +0530
Message-ID: <CAK9=C2UDF+osNRNp4V8JgAK7DKEdOY18s-8dKQUnBZ++fdK8DA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] clocksource/timer-risc: Add riscv_clock_shutdown callback
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 9:38=E2=80=AFAM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> Add clocksource detach/shutdown callback to disable RISC-V timer interrup=
t when
> switching out riscv timer as clock source
>
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Typo in patch subject: s/timer-risc/timer-riscv/

Otherwise, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/clocksource/timer-riscv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 57857c0dfba9..e66dcbd66566 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -61,12 +61,19 @@ static int riscv_clock_next_event(unsigned long delta=
,
>         return 0;
>  }
>
> +static int riscv_clock_shutdown(struct clock_event_device *evt)
> +{
> +       riscv_clock_event_stop();
> +       return 0;
> +}
> +
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) =3D =
{
>         .name                   =3D "riscv_timer_clockevent",
>         .features               =3D CLOCK_EVT_FEAT_ONESHOT,
>         .rating                 =3D 100,
>         .set_next_event         =3D riscv_clock_next_event,
> +       .set_state_shutdown     =3D riscv_clock_shutdown,
>  };
>
>  /*
> --
> 2.25.1
>
