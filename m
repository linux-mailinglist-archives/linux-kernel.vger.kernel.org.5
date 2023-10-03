Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA47B66D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbjJCKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjJCKzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:55:23 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667C5AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:55:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so855894276.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696330519; x=1696935319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLeNz/tHlH5fEkHGvlFYa80O2Py5PCvrgAn0bS6V+94=;
        b=YAFjnXfvoAAGMnQQKft0jjX/2ohqgWMTXeQMdOFUiufRzQIlbBJymRTPevIH7yjef2
         GGU95GxRFyW00wp944Xk63Hxz7M8HZm5RE/W6c39A76RDvwobkfWwWgg44s9C/ZgEdU7
         EPwfHTWcaJikUKUF3TrwTpxX8IzKuOEd01hM/YTs2E+KfeMohR2uGt/1XqHeWHXEk71I
         7SEffahAQYGzlz11jyca/fxRzczYNnARr+Ry3jxaQf/omEK90pkaP3n27dTeLaBPmxjs
         bMJcJ7zAA+QfY1dHNM+gGu+/xauEHUDWzq1cthbxHWqqSaMOOg8icJeCHQx6+bE9OYXO
         6Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696330519; x=1696935319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLeNz/tHlH5fEkHGvlFYa80O2Py5PCvrgAn0bS6V+94=;
        b=r/bWR+Bzf5oghgO7e8ZqC0Co/XotF366izNBKK/iiuZWNqztLdVb8vfx0sJkcPgbYm
         +40YgpUr0CiXv3s4owSwxG0L1nV8RrH70v36kAE34tl/KKL5so2UwiJHNmP297X2MI4K
         WvQm/Jy4PlXHoAZKFvYJJk24dR6K7f04Xj0KcugFk6LqgxUiAbKNENRKxUs3BcLNacod
         cENZBhIcBK0GAjJFQTz43WjQRYPg+ZlHkkYxo64+uk5N8BYalnCZsZ9dz9aa0CmniH5U
         tFSYVyXm2t9za8bwSaUW0Tl/LKJlbjVHfvZ8GEPhA4wp72xJsL7k7x72bvHami+xbjQx
         ZnWg==
X-Gm-Message-State: AOJu0YxkGJqn8TQymDIwLB6gnSyQK0fNczZ91A1/x2X5LXk9idddjo8t
        fuCqSQ+eaOOoChe5SNUsvDToWqyj65FzKd6gfrPBbJPr8Ef2kuWj
X-Google-Smtp-Source: AGHT+IFrFGToGxf9nxKtKo82sTPeWNmXCj92LurKD7PGWUUUM+68vClhvcFZ/h+l6UcJtbfIUE5SILg81GU06Cua91w=
X-Received: by 2002:a25:83d0:0:b0:d71:68e4:6db8 with SMTP id
 v16-20020a2583d0000000b00d7168e46db8mr12245016ybm.34.1696330519569; Tue, 03
 Oct 2023 03:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-14-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-14-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 12:54:43 +0200
Message-ID: <CAPDyKFrs1pjo0cxVU8m2ykc0x_t8+tRSNnQVTKNcMzopX8h8EQ@mail.gmail.com>
Subject: Re: [PATCH V12 13/23] mmc: sdhci-uhs2: add set_timeout()
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a UHS-II version of sdhci's set_timeout() operation.

This needs more explanations and justifications.

Other than that, the patch looks good to me!

Kind regards
Uffe

>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Updates in V8:
>  - Initialization be combined with declaration and realigned
>    in sdhci_calc_timeout_uhs2().
>  - Forward declare struct mmc_command in sdhci_uhs2.h.
>
> Updates in V6:
>  - Use GENMASK() and FIELD_PREP() in some case.
>  - Use sdhci_uhs2_mode() to simplify code.
>  - Remove unnecessary functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  2 +
>  2 files changed, 74 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 92fb69b7e209..d519e6ce6199 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/iopoll.h>
> +#include <linux/bitfield.h>
>
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -142,6 +143,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
>         }
>  }
>
> +static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
> +{
> +       /* timeout in us */
> +       unsigned int dead_lock_timeout = 1 * 1000 * 1000;
> +       unsigned int cmd_res_timeout = 5 * 1000;
> +       unsigned int current_timeout;
> +       u8 count;
> +
> +       /*
> +        * Figure out needed cycles.
> +        * We do this in steps in order to fit inside a 32 bit int.
> +        * The first step is the minimum timeout, which will have a
> +        * minimum resolution of 6 bits:
> +        * (1) 2^13*1000 > 2^22,
> +        * (2) host->timeout_clk < 2^16
> +        *     =>
> +        *     (1) / (2) > 2^6
> +        */
> +       count = 0;
> +       current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> +       while (current_timeout < cmd_res_timeout) {
> +               count++;
> +               current_timeout <<= 1;
> +               if (count >= 0xF)
> +                       break;
> +       }
> +
> +       if (count >= 0xF) {
> +               DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
> +                   mmc_hostname(host->mmc), count);
> +               count = 0xE;
> +       }
> +       *cmd_res = count;
> +
> +       count = 0;
> +       current_timeout = (1 << 13) * 1000 / host->timeout_clk;
> +       while (current_timeout < dead_lock_timeout) {
> +               count++;
> +               current_timeout <<= 1;
> +               if (count >= 0xF)
> +                       break;
> +       }
> +
> +       if (count >= 0xF) {
> +               DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
> +                   mmc_hostname(host->mmc), count);
> +               count = 0xE;
> +       }
> +       *dead_lock = count;
> +
> +       return count;
> +}
> +
> +static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
> +{
> +       u8 cmd_res, dead_lock;
> +
> +       sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> +       cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
> +       sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> +}
> +
> +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +       __sdhci_set_timeout(host, cmd);
> +
> +       if (sdhci_uhs2_mode(host))
> +               __sdhci_uhs2_set_timeout(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 8253d50f7852..ccf4e1834c2d 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -175,9 +175,11 @@
>  #define SDHCI_UHS2_VENDOR_PTR                  0xE8
>
>  struct sdhci_host;
> +struct mmc_command;
>
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>
>  #endif /* __SDHCI_UHS2_H */
> --
> 2.25.1
>
