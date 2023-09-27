Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F47B0209
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjI0KlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjI0KlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:41:02 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7871D13A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:40:59 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d84c24a810dso12471590276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695811258; x=1696416058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3NNfm4Je7/nE4q7Oqll1kvCkkttzLCgnEc8/NlXhfo=;
        b=Rfn0aAJ2bYTTBKZgKR838uiRQ04ufYCSuG3LdUxD2Np+cUZ5wBWQw/0ARSrYIzMRI7
         rbopCeuPcpJCQnsGaCwfY5cHiOJbayXIoBw1HKi/IKMwruyzAJ5HF82SrGe5fjOsQu21
         xA9nTJQoMwY7waysqURlJRtSZzq0bi9PS6O24nxRYlW/YOsTLkuol0PFOiILYXAkmsd/
         16xCoHosjnCAjwaVKNA45Fqvxhv6I7ss3am3DPC148kX48WH4ZUo62YqO3s3TE1U2+GL
         qPgQtS4PDIEbNH8sywNAP86SFly+u8mzVNq9Hwijo5I743bEfsX/iJB92IVtStVSj4Bo
         Nf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695811258; x=1696416058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3NNfm4Je7/nE4q7Oqll1kvCkkttzLCgnEc8/NlXhfo=;
        b=rVVBrt7inM+GGN8eqPjGahKvTrF8sQYNwr53wIFND5+bgR0u5pB3PIBPwV4vENkUq9
         EgN4q8q26haxcSCtJ5HqannfxTDwvxplqiVzsGgbyyqpC6UUUZmcjUi0Ho99+EOzGQ0Z
         N0wYL0WsiQgIXvmHzmO10zCcgV7/DKsKKPpXSGYiDaRE9r74YWIYojFHlbYLea0yw2q3
         oTlw2LMM2I19xa0ZAbLNtr1sn94IpChwqfvkn8uXLV+7XeiEnzBZH3MZ7x6aNMFtt1AY
         OrrPOkw5Gdvyoj89IFJbLjM+7G8mrrXeDmiQ9iLH6jRzS46bX/a6U/WIXeZtCWSkGDYU
         a/9Q==
X-Gm-Message-State: AOJu0Yw3xBnDMPOwiaMXw7R1dXarfImhujX/gPkBz37RT2oEDE6zuXG1
        vV47SO7L2iO89SZ57qsVNKrb8GSpOlQvGQSL4VkzEkWTT5GAiYqq
X-Google-Smtp-Source: AGHT+IHEhCnTUnZjApThCWz0JSq83eRUInpiinMPx97RC+PdIF5eBhf8j0FcFjicqFvXvz2XgJ1j+1rE4s0xhzji3zI=
X-Received: by 2002:a25:abac:0:b0:d81:a0c5:f275 with SMTP id
 v41-20020a25abac000000b00d81a0c5f275mr1838716ybi.15.1695811258566; Wed, 27
 Sep 2023 03:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230927-strncpy-drivers-mmc-host-vub300-c-v1-1-77426f62eef4@google.com>
In-Reply-To: <20230927-strncpy-drivers-mmc-host-vub300-c-v1-1-77426f62eef4@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 12:40:22 +0200
Message-ID: <CAPDyKFp7NYL5JNdopqUc3x0S8voh1W1meQzmqJJBuc+EYmLZfw@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: replace deprecated strncpy with strscpy
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sept 2023 at 08:41, Justin Stitt <justinstitt@google.com> wrote:
>
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect `vub300->vub_name` to be NUL-terminated based on its uses with
> format strings:
> |       dev_info(&vub300->udev->dev, "using %s for SDIO offload processing\n",
> |                vub300->vub_name);
>
> NUL-padding is not needed. We can see cleaning out vub_name simply
> consists of:
> |       vub300->vub_name[0] = 0;
>
> Considering the above, for all 11 cases a suitable replacement is
> `strscpy` [2] due to the fact that it guarantees NUL-termination on the
> destination buffer without unnecessarily NUL-padding.
>
> To be clear, there is no existing bug in the current implementation as
> the string literals are all small enough as to not cause a buffer
> overread. Nonetheless, this gets us 11 steps closer to removing strncpy
> uses.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Note: build-tested only.
> ---
>  drivers/mmc/host/vub300.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 9ec593d52f0f..de3f443f5fdc 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -512,7 +512,7 @@ static void new_system_port_status(struct vub300_mmc_host *vub300)
>                 vub300->card_present = 1;
>                 vub300->bus_width = 0;
>                 if (disable_offload_processing)
> -                       strncpy(vub300->vub_name, "EMPTY Processing Disabled",
> +                       strscpy(vub300->vub_name, "EMPTY Processing Disabled",
>                                 sizeof(vub300->vub_name));
>                 else
>                         vub300->vub_name[0] = 0;
> @@ -1216,7 +1216,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                 dev_err(&vub300->udev->dev,
>                         "corrupt offload pseudocode in firmware %s\n",
>                         vub300->vub_name);
> -               strncpy(vub300->vub_name, "corrupt offload pseudocode",
> +               strscpy(vub300->vub_name, "corrupt offload pseudocode",
>                         sizeof(vub300->vub_name));
>                 return;
>         }
> @@ -1250,7 +1250,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                                 "not enough memory for xfer buffer to send"
>                                 " INTERRUPT_PSEUDOCODE for %s %s\n", fw->data,
>                                 vub300->vub_name);
> -                       strncpy(vub300->vub_name,
> +                       strscpy(vub300->vub_name,
>                                 "SDIO interrupt pseudocode download failed",
>                                 sizeof(vub300->vub_name));
>                         return;
> @@ -1259,7 +1259,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                 dev_err(&vub300->udev->dev,
>                         "corrupt interrupt pseudocode in firmware %s %s\n",
>                         fw->data, vub300->vub_name);
> -               strncpy(vub300->vub_name, "corrupt interrupt pseudocode",
> +               strscpy(vub300->vub_name, "corrupt interrupt pseudocode",
>                         sizeof(vub300->vub_name));
>                 return;
>         }
> @@ -1293,7 +1293,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                                 "not enough memory for xfer buffer to send"
>                                 " TRANSFER_PSEUDOCODE for %s %s\n", fw->data,
>                                 vub300->vub_name);
> -                       strncpy(vub300->vub_name,
> +                       strscpy(vub300->vub_name,
>                                 "SDIO transfer pseudocode download failed",
>                                 sizeof(vub300->vub_name));
>                         return;
> @@ -1302,7 +1302,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                 dev_err(&vub300->udev->dev,
>                         "corrupt transfer pseudocode in firmware %s %s\n",
>                         fw->data, vub300->vub_name);
> -               strncpy(vub300->vub_name, "corrupt transfer pseudocode",
> +               strscpy(vub300->vub_name, "corrupt transfer pseudocode",
>                         sizeof(vub300->vub_name));
>                 return;
>         }
> @@ -1336,13 +1336,13 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                 dev_err(&vub300->udev->dev,
>                         "corrupt dynamic registers in firmware %s\n",
>                         vub300->vub_name);
> -               strncpy(vub300->vub_name, "corrupt dynamic registers",
> +               strscpy(vub300->vub_name, "corrupt dynamic registers",
>                         sizeof(vub300->vub_name));
>                 return;
>         }
>
>  copy_error_message:
> -       strncpy(vub300->vub_name, "SDIO pseudocode download failed",
> +       strscpy(vub300->vub_name, "SDIO pseudocode download failed",
>                 sizeof(vub300->vub_name));
>  }
>
> @@ -1370,11 +1370,11 @@ static void download_offload_pseudocode(struct vub300_mmc_host *vub300)
>                  vub300->vub_name);
>         retval = request_firmware(&fw, vub300->vub_name, &card->dev);
>         if (retval < 0) {
> -               strncpy(vub300->vub_name, "vub_default.bin",
> +               strscpy(vub300->vub_name, "vub_default.bin",
>                         sizeof(vub300->vub_name));
>                 retval = request_firmware(&fw, vub300->vub_name, &card->dev);
>                 if (retval < 0) {
> -                       strncpy(vub300->vub_name,
> +                       strscpy(vub300->vub_name,
>                                 "no SDIO offload firmware found",
>                                 sizeof(vub300->vub_name));
>                 } else {
> @@ -1758,7 +1758,7 @@ static void vub300_cmndwork_thread(struct work_struct *work)
>                          * has been already downloaded to the VUB300 chip
>                          */
>                 } else if (0 == vub300->mmc->card->sdio_funcs) {
> -                       strncpy(vub300->vub_name, "SD memory device",
> +                       strscpy(vub300->vub_name, "SD memory device",
>                                 sizeof(vub300->vub_name));
>                 } else {
>                         download_offload_pseudocode(vub300);
>
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230927-strncpy-drivers-mmc-host-vub300-c-b7b39f82e584
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
