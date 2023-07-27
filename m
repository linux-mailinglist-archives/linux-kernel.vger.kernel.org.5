Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DE7652BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjG0Lms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjG0Lmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:42:45 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90819A0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:42:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583f837054eso8902047b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690458163; x=1691062963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqCebh/KFlS0UIqXs9quxfYZXHFv+69FJab+9MuZfBk=;
        b=qDHeyVwOM5HVTO8lzAAXKb7PLcX3XLyW/igC+kpEvHC/0aQd01LagzchWrGZY2btE6
         Wu/9Q59BTiZOm6IX/mWuVS0g9KKddLH7Er7Q/LCzUxyjdn/usuofuwjoXmPEnfSgWE+A
         pz0oezzgmgr3EeVMQaVCMTbFM+ZLrA0FYO/GInPDIZyAf7+0vgNg9mRkOn9lGCyeBt3a
         0dHlbTlpq50jUNmuvWYBk/9hwxkN12GB5ryBwiAa3+ePSbuq527JPoBI8Gp1JrgR5ao2
         BbTuhRGa4fc/DyJhYcchavk+9tEXWgfXU3Qkh7aIaHtUwSqVGskQpv2ZUesMt1EL5E25
         GQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458163; x=1691062963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqCebh/KFlS0UIqXs9quxfYZXHFv+69FJab+9MuZfBk=;
        b=bT+ElKqtrVAHQlAJGawIXTSTOf65PknuA//jgV+8lhJE+tJhTCBCi21MqGtbtdv2o3
         97CAmoQG8gNKLK4kLbFj0GJs/AYrWp3mDxKApCBRUve5AW6G9+DURTE4zVzmi1GUt3H8
         3jmqld4lKjAXhNJ4mP5yr22HgD3rRJCN+pqdTZYZ1/+gCECgXS9HhDVB4COHLyWlYcPL
         oElESAmjIco0ijOwbQ4TFXCn8V5Lo0gN41RtUhiEcy7sBGth4QZ8/iyVPo84B/vV2Iuk
         R98/p9OxwDv2h8FC7tGHhzCnQmdbJ6zA46p9tU1o0I36axu6SNhm4rHfAxMOkNL0lJ/S
         JlHw==
X-Gm-Message-State: ABy/qLYj5IAgEkDyREdPNBhDOBHGdYF+verXMpENCw2WEdkXy0AiFzzv
        AHB531NvitGVEiXi0YD/p9TScayWWD3BQtQItUyTzA==
X-Google-Smtp-Source: APBJJlGx+GAxitWd80E9DMwXB823E1WceDKNLYAIk/BrVGXwdEQAPtxnRnnfZSWLnJIAwzumG3krOjZlgCawHMAfvuo=
X-Received: by 2002:a25:c583:0:b0:d22:4547:39cf with SMTP id
 v125-20020a25c583000000b00d22454739cfmr1835900ybe.59.1690458163261; Thu, 27
 Jul 2023 04:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230720091701.517197-1-peng.fan@oss.nxp.com> <20230720091701.517197-5-peng.fan@oss.nxp.com>
In-Reply-To: <20230720091701.517197-5-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Jul 2023 13:42:06 +0200
Message-ID: <CAPDyKFqz2irmBdV0CsqgzqnYLXWVAS9_pKpkUZ3RG4z7kSVQFQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] genpd: imx: scu-pd: do not power off console if no_console_suspend
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 11:12, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Dong Aisheng <aisheng.dong@nxp.com>
>
> Do not power off console if no_console_suspend
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/genpd/imx/scu-pd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
> index 08583a10ac62..6770be51d234 100644
> --- a/drivers/genpd/imx/scu-pd.c
> +++ b/drivers/genpd/imx/scu-pd.c
> @@ -52,6 +52,7 @@
>   */
>
>  #include <dt-bindings/firmware/imx/rsrc.h>
> +#include <linux/console.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/firmware/imx/svc/rm.h>
>  #include <linux/io.h>
> @@ -324,6 +325,10 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
>         msg.resource = pd->rsrc;
>         msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
>
> +       /* keep uart console power on for no_console_suspend */
> +       if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)
> +               return 0;

By returning 0, genpd belives that the power off has successfully succeeded.

Should we return -EBUSY here instead?

> +
>         ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
>         if (ret)
>                 dev_err(&domain->dev, "failed to power %s resource %d ret %d\n",
> --
> 2.37.1
>

Kind regards
Uffe
