Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DC8134E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573828AbjLNPhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573801AbjLNPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:37:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85998111
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:37:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28b02567a05so777896a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702568263; x=1703173063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVRxbeDpcmrUyduHgt0tz/jbYk1HVRrP36OEy6oLOv0=;
        b=urP6kZPyLOp99dLjr9wJSlcwC1axi9yzPnSQsZ8NhHfcDhh71J5ZAffvARyz3x6jCB
         wckNrTKdw1SasKRir8kuUwPoHZSM7nU11DHM5EaRZyGNb+KOa7myhSJNGHrkTz6g5PPB
         7H8fZkOlXfFixtxmIRkD9UhMIyJr/7DRfD7rs4Q/jwIJmzmu84pL3M3VjCfNGwUsoTDZ
         DwFi+MI2VJWWMLioLox7TH2UlH2JQkP6PXUZZGWwwNblKSJzhFQiCI90YXOY1mDEwrif
         9MBiBcQa4UFHa5IwezTVxm+17a+CzwMwXXYdoUXuMsEiHkKemfUuVbn82C1ryLtbuYxZ
         5gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568263; x=1703173063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVRxbeDpcmrUyduHgt0tz/jbYk1HVRrP36OEy6oLOv0=;
        b=vlf3upBtf1S2Xtc/Ax8HXMCxgakMu90tnsfHJFf15Li3Hg2MjzCTPWds6DdZfCi8Az
         RhYNREBtzSbeFif7o63XacZxHm2KBPO3a2zeWpFJKF2YzV06zEmGZEA98/vVP7GdnQwP
         WBjdCrcUJaWbDLq7V50n535yq1m2zIDanpQhSIbDArIXarKUOSBQVrtIETek+7siw7D0
         aXHFw71NXvX43zDFOUbPJPS2/8mBpMW+W3Fi5swapO+eP1U+AGJ24NjXeT0SYjYKM2QZ
         +wn6m5kEOHMCWdLH9yTNfbqykx1ZyPJyDeqmy5uWsFlTf0GA/SXjk2i+gGbClLMhoHpx
         N6Sw==
X-Gm-Message-State: AOJu0Yw4ym7ra0AhSFvbaOnzPl31miKChm0Lr1s3/PUmuO//fbmWGkxl
        JhuVOwUMvOCaS68aHEE1HHj3MwYNuzZmEPftXudtZA==
X-Google-Smtp-Source: AGHT+IFlfZ3ippMnu3n5lTTjsdPJgU139sxig5QTx9iHbcfAwBVwV7VAes0Gg3z8lQvZ5cKTLzKAWCJon4DTti+hw5I=
X-Received: by 2002:a17:90a:3002:b0:28a:e557:d516 with SMTP id
 g2-20020a17090a300200b0028ae557d516mr1173504pjb.37.1702568263002; Thu, 14 Dec
 2023 07:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-8-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-8-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:37:31 -0600
Message-ID: <CAPLW+4mNjCbJ+VbKR66DFSkiXHyxdjgvwjN7azxjJQ6UxQikEw@mail.gmail.com>
Subject: Re: [PATCH 07/13] clk: samsung: gs101: mark PERIC0 IP TOP gate clock
 as critical
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Testing USI8 I2C with an eeprom revealed that when the USI8 leaf clock
> is disabled it leads to the CMU_TOP PERIC0 IP gate clock disablement,
> which then makes the system hang. To prevent this, mark
> CLK_GOUT_CMU_PERIC0_IP as critical. Other clocks will be marked
> accordingly when tested.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/clk/samsung/clk-gs101.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs=
101.c
> index 3d194520b05e..08d80fca9cd6 100644
> --- a/drivers/clk/samsung/clk-gs101.c
> +++ b/drivers/clk/samsung/clk-gs101.c
> @@ -1402,7 +1402,7 @@ static const struct samsung_gate_clock cmu_top_gate=
_clks[] __initconst =3D {
>              "mout_cmu_peric0_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC0_BUS,
>              21, 0, 0),
>         GATE(CLK_GOUT_CMU_PERIC0_IP, "gout_cmu_peric0_ip", "mout_cmu_peri=
c0_ip",
> -            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, 0, 0),
> +            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, CLK_IS_CRITICAL, 0),

This clock doesn't seem like a leaf clock. It's also not a bus clock.
Leaving it always running makes the whole PERIC0 CMU clocked, which
usually should be avoided. Is it possible that the system freezes
because some other clock (which depends on peric0_ip) gets disabled as
a consequence of disabling peric0_ip? Maybe it's some leaf clock which
is not implemented yet in the clock driver? Just looks weird to me
that the system hangs because of CMU IP clock disablement. It's
usually something much more specific.

>         GATE(CLK_GOUT_CMU_PERIC1_BUS, "gout_cmu_peric1_bus",
>              "mout_cmu_peric1_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC1_BUS,
>              21, 0, 0),
> --
> 2.43.0.472.g3155946c3a-goog
>
