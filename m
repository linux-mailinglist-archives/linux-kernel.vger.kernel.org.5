Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E587BC42D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjJGC1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJGC12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:27:28 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498ABD;
        Fri,  6 Oct 2023 19:27:27 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65b0557ec77so15066696d6.0;
        Fri, 06 Oct 2023 19:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696645646; x=1697250446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNDhtLOEKcYAnbXxDszSP4U1anKPaHCaiVOg9N7z6KQ=;
        b=Mvs9FlG6CjgFiLAjDkwDiSi0P1MKXpEiRJbcueJFrWKA1qtAAnuGQ093cyu/RLxlq8
         k9FnHh7KX9tkPHpLGBsGYWkqEQahZOSpeIemR7satPmskvNzSPuW4bXGof3M+86L1D+D
         EVf3+SGJWznoqRC103+/wMBXHBFMSLQ5fIaRopQ7MkLYLh83aZDmzn1Yz9ziaZelCjJl
         3kgQczaLKVM7GnqG3423fzNfpih6SfDP9xdSPG+X9vq3LwajdonT9IWWkpoaCmij6Ld4
         OcaepBGQXVT1ZvTU2cUKRe/LypF2gsjwNGpc/3kDWPHI1AYl8/fA7LV8WAhTkzklaZeR
         v4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696645646; x=1697250446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNDhtLOEKcYAnbXxDszSP4U1anKPaHCaiVOg9N7z6KQ=;
        b=We+DH0vH9qzlXDhP0pbvQQzuieKftbzj/4lmUBBk4fTt/Zuu+iwPxCFFycnU/iC9yV
         gKym11OI333lmCPyLi+7rPX2dnEGFM5CamXb1SYbLxi113eO5rfAnnIOa3BOk1SZd2j9
         lxgLZ7vDkLiFuZuH30/kw8i+YfV0jDw/9aq6QaNg63FZbOLjbPw5LEXOX7W9j0ehuZK+
         aaTUg0RTOgb7SVeceIuUs/cz+8ibzjgTlMyVR0U/9lm7HkXJq4xdYbEypR9wOwVXAnfp
         SxjL3uoMOOe280gJpeHD/suhlKOkabvSMzPYYlhw+v5eFpm9+ItqUnXWB/Mlu73csEwM
         cEbQ==
X-Gm-Message-State: AOJu0Yzvooj1p0lqKKkcuexUj5uArOwgVqguR9gr4nifUX8ycKjdiBor
        KrXEZ6KTkEay0DZvI+kJeMIKkEQmdwBhNkjkkBK1H7XAt8s=
X-Google-Smtp-Source: AGHT+IGfrIoyKbqF/4x8tCVuCkxWlvb9G7XOFRkJZ1RzOuA5QP98zms/OUwmW4RtEOnfYQR/KT1O8qDl551WOuaPTBk=
X-Received: by 2002:a05:6214:310f:b0:658:59e7:aac5 with SMTP id
 ks15-20020a056214310f00b0065859e7aac5mr8793292qvb.23.1696645646459; Fri, 06
 Oct 2023 19:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com> <20230929-mmc-caps-v2-2-11a4c2d94f15@axis.com>
In-Reply-To: <20230929-mmc-caps-v2-2-11a4c2d94f15@axis.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Sat, 7 Oct 2023 10:27:15 +0800
Message-ID: <CA+Da2qy=6CVEkuP5t2dPQVk_eHex-U4-BzJuQ2Y6ozZMfSEbuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: debugfs: Allow host caps to be modified
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sept 2023 at 21:17, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> During board verification, there is a need to test the various supported
> eMMC/SD speed modes.  However, since the framework chooses the best mode
> supported by the card and the host controller's caps, this currently
> necessitates changing the devicetree for every iteration.
>
> Allow the various speed mode host capabilities to be modified via
> debugfs in order to allow easier hardware verification.  The values to
> be written are the raw MMC_CAP* values from include/linux/mmc/host.h.
> This is rather low-level, and these defines are not guaranteed to be
> stable, but it is perhaps good enough for the intended use case.
>
> MMC_CAP_AGGRESSIVE_PM can also be set, in order to be able to
> re-initialize the card without having to physically remove and re-insert
> it.
>
>  /sys/kernel/debug/mmc0# grep timing ios
>  timing spec:   9 (mmc HS200)
>
>  // Turn on MMC_CAP_AGGRESSIVE_PM and re-trigger runtime suspend
>  /sys/kernel/debug/mmc0# echo $(($(cat caps) | (1 << 7))) > caps
>  /sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
>  /sys/kernel/debug/mmc0# echo auto > /sys/bus/mmc/devices/mmc0\:0001/power/control
>
>  // MMC_CAP2_HS200_1_8V_SDR
>  /sys/kernel/debug/mmc0# echo $(($(cat caps2) & ~(1 << 5))) > caps2

$(($(cat caps2) & ~(1 << 5))) looks complicated, does it use echo DDR52 > caps2?

>  /sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
>  /sys/kernel/debug/mmc0# grep timing ios
>  timing spec:   8 (mmc DDR52)
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/mmc/core/debugfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 2c97b94aab23..1642ea72d22c 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -12,9 +12,12 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/fault-inject.h>
> +#include <linux/time.h>
>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
>
>  #include "core.h"
>  #include "card.h"
> @@ -298,6 +301,49 @@ static const struct file_operations mmc_err_stats_fops = {
>         .release = single_release,
>  };
>
> +static int mmc_caps_get(void *data, u64 *val)
> +{
> +       *val = *(u32 *)data;
> +       return 0;
> +}
> +
> +static int mmc_caps_set(void *data, u64 val)
> +{
> +       u32 *caps = data;
> +       u32 diff = *caps ^ val;
> +       u32 allowed = MMC_CAP_AGGRESSIVE_PM |
> +                     MMC_CAP_SD_HIGHSPEED |
> +                     MMC_CAP_MMC_HIGHSPEED |
> +                     MMC_CAP_UHS |
> +                     MMC_CAP_DDR;
> +
> +       if (diff & ~allowed)
> +               return -EINVAL;
> +
> +       *caps = val;
> +
> +       return 0;
> +}
> +
> +static int mmc_caps2_set(void *data, u64 val)
> +{
> +       u32 allowed = MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V;
> +       u32 *caps = data;
> +       u32 diff = *caps ^ val;
> +
> +       if (diff & ~allowed)
> +               return -EINVAL;
> +
> +       *caps = val;
> +
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps_fops, mmc_caps_get, mmc_caps_set,
> +                        "0x%08llx\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps2_fops, mmc_caps_get, mmc_caps2_set,
> +                        "0x%08llx\n");
> +
>  void mmc_add_host_debugfs(struct mmc_host *host)
>  {
>         struct dentry *root;
> @@ -306,8 +352,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         host->debugfs_root = root;
>
>         debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
> -       debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
> -       debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
> +       debugfs_create_file("caps", 0600, root, &host->caps, &mmc_caps_fops);
> +       debugfs_create_file("caps2", 0600, root, &host->caps2,
> +                           &mmc_caps2_fops);

Would it be better to use "S_IRUSR | S_IWUSR" instead of "0600"?

>         debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>                                    &mmc_clock_fops);
>
>
> --
> 2.34.1
>
