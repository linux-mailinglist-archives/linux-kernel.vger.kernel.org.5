Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6C7EBD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjKOHAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:00:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0EBB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:00:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso423558b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700031631; x=1700636431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBd2cbY+fwIsvYalDj9N2umWHVZP1YU3heVkt+n/fBg=;
        b=MYicLe+C+qT8ZNIqwyyLVRU8obOfbp1zqnrV3X8DUh7LDqLoh39cF5HRMloy1O+wJo
         /wkBw6Mx7LSkfBgY8rnJ/caKOIdB56f96A+INy1KQq8HoqayHNacV0D5+95jQ4A8WZbw
         AVUcBnScVzbXgXHxmCwEk4icQi8apJtuwiRx5QYQicDaUQugXJzQj7bN5lhxeFTgWhwL
         OAVmH/8Zvvjl/LoxmolfRPkDEUXo9m3uQAu1giqvo9sEQSRrA0fzzl8wPDr3oh3Ab91c
         wYymmVf+FtPgF4tEp1aaKOYme0MRI3JFDi+hJFTU3vNYn4LlJ3uDpgyA6V7unVk2HUOM
         XwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700031631; x=1700636431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBd2cbY+fwIsvYalDj9N2umWHVZP1YU3heVkt+n/fBg=;
        b=m1S1jQX+9TA/aG//LTiz40gIrkY0LoHIBZOKaf3hcOxY/vAmT1aJioEfsnN7BRE/sl
         yrkV+VcRqkLi+dzqKlhPCNObcffoiOQh7wE1Om3t9CuZ/jdRWgKQENv9yCQEOpzGe7Kf
         5ScrJV7j0AHX2ymPUGFgIB0RxDXHOMHJQFymIS2fSz7gAUvGwbczFlAGVN4u9paJeYhO
         N13KiM42F/JmtA0AyY1LFh5CqIumWhrxsxbC6QzrNAerLoSeqUMOY5oQUfgskbr5rvno
         yV3iNsaUt7qKYuyGaC8j1GU2r3zQuNjChBBTD1MyQoqCTHQd7vB4ERp5GRnwClq8q3Ba
         ZW3g==
X-Gm-Message-State: AOJu0YwPZaI6MNm5gQ+MuiuFtKRM1dOBS1QVTxCXD3REcyachxhwFMVZ
        OtTAKiTn7sjUWDFGdlnYE/0LVbUtSMzkTv8mhCU/zw==
X-Google-Smtp-Source: AGHT+IE8l94VPqR/L8cfktvkb9oSVY8ofXtchF4ZtmbhPwGleXc0uta/b/x+FF875m9JQ19/o074ejNR5fVWi/A/R24=
X-Received: by 2002:a17:90b:1b47:b0:280:280c:efe3 with SMTP id
 nv7-20020a17090b1b4700b00280280cefe3mr6609635pjb.14.1700031630913; Tue, 14
 Nov 2023 23:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20231115061811.10041-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20231115061811.10041-1-joshua.yeong@starfivetech.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 15 Nov 2023 12:30:18 +0530
Message-ID: <CAK9=C2VXxNjKOq1XqQ9t6iVELdj2fFi85K77xNCOfdf3WRdy8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] clocksource/timer-risc: Add riscv_clock_shutdown callback
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:49=E2=80=AFAM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> Add clocksource detach/shutdown callback to disable RISC-V timer interrup=
t when
> switching out riscv timer as clock source
>
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  drivers/clocksource/timer-riscv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index da3071b387eb..588a05459b6a 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -50,12 +50,19 @@ static int riscv_clock_next_event(unsigned long delta=
,
>         return 0;
>  }
>
> +static int riscv_clock_shutdown(struct clock_event_device *evt)
> +{
> +       sbi_set_timer(-1);

Use riscv_clock_event_stop() here.

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

Regards,
Anup
