Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D747AA074
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjIUUh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjIUUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:37:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2889200
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:39:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ae093798c0so416161b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317974; x=1695922774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JKBCWQGoZXYISlj4ce5hI/hMxdBTdeB63Q+PfDkksMw=;
        b=CgtDFKhRELvuukHOVjL5ohuaThWsAFw3LUnPMjDoM7GpxNxxiZw4RncQgj93zqJjSe
         mFCNRnSZX3aDkcB8mzZaqAcLdYUGDd0Y4bCHp13DwNGVtQGEOhnq/tgDCkS4ZO1x//C5
         gHymp5nJa5qFTZNZ5G6kUGWH33aJBavfLn658ett59UJLHI8dCrYItbvmc14TPByHZbH
         0JDyqtjjHC6D8QzXizyPdQoxxgXY6rEjElrQl/PTDtvgXS2JQg/wY4or00wdK7tKw2iL
         nFgkZZkPFebAzU57kdvlhdSo3tSUMe906DMt+bfqgI5dVxhq3RXeSS8K70LnADiVFWri
         x3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317974; x=1695922774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKBCWQGoZXYISlj4ce5hI/hMxdBTdeB63Q+PfDkksMw=;
        b=ZOFNcONqpmAUjh0WsK+uMn8c3TqbpVZFMyu8qM5cfRx6lNt+kVfbxidf4OC7ePGWoi
         6XOSS30Uf41xUgGxMJoSw0qdFTpD7frh3ynLljosqxw8Tts8ZqM/pf8VEfoAEFnfYPQJ
         YOjUJt5KGdoKEF1OI/BNHbPA4Uet8YSOzOdKSTJ9eshqQTkZLvt1/xOWldBSt44vt+IG
         LUs8bVMu2mz0N9qVVe5zoHg5yIx3lSK4aS8gI6I9Xd5aswf+nCEl/ErkfT5GBO+oWDLI
         iOEk+ZhRZvXKb12UmXRE5cHm6WIiv335V7jkdLZ4e6FBWmDv+8J8tRPWcQfTloBiByjP
         PgJA==
X-Gm-Message-State: AOJu0YwSOdkezt3aQrVTCPZJCrsQ3QhtOFP3ZjqI4KcBclS4gVrfhDO2
        qMVsahF4r78QDNN0EJIuw4kAKuhmfKXzNvXJ4y9ZBnaiF9r2O3z6ZxE=
X-Google-Smtp-Source: AGHT+IF4etN+Lj1MoiBPYE9O7MxBCxBGEDBcLLZyD6+EOR0BOfhOgfmrV9Rjd46Xx5Okz8nIXqKXRgGlicgkoa5JBtk=
X-Received: by 2002:a25:cb14:0:b0:d44:af:3cce with SMTP id b20-20020a25cb14000000b00d4400af3ccemr5617959ybg.27.1695301892106;
 Thu, 21 Sep 2023 06:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230919121605.7304-1-ulf.hansson@linaro.org> <20230921113328.3208651-1-sudeep.holla@arm.com>
In-Reply-To: <20230921113328.3208651-1-sudeep.holla@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:10:56 +0200
Message-ID: <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Move power-domain driver to the
 pmdomain dir
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 13:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> To simplify with maintenance let's move the Arm SCMI power-domain driver
> to the new pmdomain directory.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Feel free to take it through your scmi tree!

Note that, we should move the Kconfig options too, but that requires
changes that I am carrying in my pmdomain tree. We can either wait
until the next cycle or you could send your pull-request to me this
time (instead of through arm-soc), then we can fix this as a late
minute change. The decision is yours.

Kind regards
Uffe

> ---
>
> Hi Ulf,
>
> If you are happy with this, please cck. I would like to take this along
> with your scmi_perf_domain change as part of you series.
>
> Regards,
> Sudeep
>
>  drivers/firmware/arm_scmi/Makefile                           | 1 -
>  drivers/pmdomain/arm/Makefile                                | 1 +
>  drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c (100%)
>
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index b31d78fa66cc..a7bc4796519c 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -16,7 +16,6 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
>
> -obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
>  obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
>
>  ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
> diff --git a/drivers/pmdomain/arm/Makefile b/drivers/pmdomain/arm/Makefile
> index 7128db96deac..cfcb1f6cdd90 100644
> --- a/drivers/pmdomain/arm/Makefile
> +++ b/drivers/pmdomain/arm/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
>  obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
> +obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
> diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> similarity index 100%
> rename from drivers/firmware/arm_scmi/scmi_pm_domain.c
> rename to drivers/pmdomain/arm/scmi_pm_domain.c
> --
> 2.42.0
>
