Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525D37EE023
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjKPLwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:52:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF6EB0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:52:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28307847ea4so524047a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1700135524; x=1700740324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HELlPsqjg/Wefk5+wz/oWAt20BG/uf0xX6SQVFjDt18=;
        b=oVcB78IT4UdzUl4IX2xTaIGYzAlyMGjYmkJyx7znXZDLsofZ4xJMVGIyUqSkPfT4nX
         BhXAjW0q5yQkXxShgJa+9YJVaU3dcgSJvDvz+mpnMi0ZDZmmoSnJox3O2IKjC0UVo9uJ
         ccY9UqSUSlo3yNkqNCd9tm9T3K3BmPyFcty4ZOfx64fLuxaKSh+JBMV9MpshtHC+imMf
         g39NSbLVvR/YjO0kedLyUFM0zTGvMbPpiPOBVKq34wp1SNeOH/yxv0R5D6bDB9tDnyNG
         utqSV8mPU5AQvlfXouiU6QJhodO3hjD4TdiJ5wpL/Ja06BWLfSRK6Pqr6Q0+9FlK7F/p
         Jsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135524; x=1700740324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HELlPsqjg/Wefk5+wz/oWAt20BG/uf0xX6SQVFjDt18=;
        b=HqIm5FF2Hd9Hyoja08pK3R27CI486yh/3mmMLJ+VINlLXIa39cA/sVh8LjFxgn34ei
         OhxLlf65lpopxzbdqA1wdI0XZEMSRt1QiEa0gLtBA6cbgpQNOF7yVAyR7t4/U2poAKf3
         RRFPzK4W/k9Gmcfh+bdyymRy+yXBIGMGnxcCRw63L4hEuust9K9RlEQr3mbif4kLsFbR
         YnRmdUuein3dLi21K9TkRbrA3EJ0fUzrMSIB69OjInEtd1jEgw6QMsyCoDQrg9sDcORL
         w4G7T76HRwM/7XB4/b0mjzmh9038AcVlejf4TYbGS5+5Zfh51PCTNVUPmEUnlRrNncSA
         EXag==
X-Gm-Message-State: AOJu0YysRof15ASjiOcsVuIau1J1Gkaqn2GtSoCs6RJrWtr9Hk8oXBpK
        xZVPutjnLWObEf8plJoj+7OV7DhXXgnn3tXGrwluoQ==
X-Google-Smtp-Source: AGHT+IFgCut+bynCtvKeQGddj+t5nYD0UBTCfEVTs+udaQIi9PDDpeuZYnmLWJfo3BZcEYbkZ7f6eav48vkg/hOVLt0=
X-Received: by 2002:a17:90a:1951:b0:27d:669e:5a10 with SMTP id
 17-20020a17090a195100b0027d669e5a10mr14998332pjh.13.1700135524282; Thu, 16
 Nov 2023 03:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20231116105312.4800-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20231116105312.4800-1-joshua.yeong@starfivetech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Nov 2023 17:21:51 +0530
Message-ID: <CAAhSdy2EvimCN_RfzXY_iEv_d0MtzFmEk8-0SYbuWfcmGmt8Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] clocksource/timer-riscv: Add riscv_clock_shutdown callback
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 4:24=E2=80=AFPM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> Add clocksource detach/shutdown callback to disable RISC-V timer interrup=
t when
> switching out riscv timer as clock source
>
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Please include Rb tags obtained in previous revisions.

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
