Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD27EBD54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKOHHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:07:17 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9574EE9;
        Tue, 14 Nov 2023 23:07:14 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-586753b0ab0so3575729eaf.0;
        Tue, 14 Nov 2023 23:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700032034; x=1700636834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DD6loysLm1if0z26gUfJWR92/8dI2bMs4fySErE1LEY=;
        b=GWViByNOB6QFa47gtiwgot+lcOC2McHU/geONAV6dDG5dydanxRUngS9lLTcRvqAbL
         FptC+PJNItd/bIMJKjoDsZgP4TGQnx3mVu59RVWeqUd8MTd5GgX4uYFm/TN/gbmhB/ZI
         4DmlkmODWyveOOem/MmROEr6iBT0BckkTQumj/8Hfs4wox7X0ytCIovPvF+8WnXqBsMN
         QHALUi5HLt57LsTilQxc2MEwsnBfsFZorKg0dTfs/5/7glwJjg5Dk/7GbWBHtAGcUFZU
         XJbI13DXnuj1q17N0yYpxVnnKZ4gCq/Rh5aSEjBgCXkpUA7VVDG80BhNBzI4v/4xAw1u
         DWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700032034; x=1700636834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD6loysLm1if0z26gUfJWR92/8dI2bMs4fySErE1LEY=;
        b=vpQ0dK19hqAR+xKgOpHh6LmMU9VIM0FO7igVz2NDVF78tT7d1jkI5ZSm/KtuxSMXPN
         9+rJDtmPq5G3AuDoKclrwDUAt+5PPf1mZR870UiIh3krezSlT/zioegWF5ibW4BVxe7I
         sy0pYSt+64tWf7AdnUPa9jzoKpshqFrk0sVSzZdiSangNgL6EVs0AoIv2K251LNcO5PI
         xh8hEj9C0wwpOcb+fD9OT4tn8yGn5J28isi9LwZP0S4mL3e4P9sU6iUrcWt/QDJvyDGQ
         pWmbW3dRLAY4hL1/NdVz2//eg28CEU9ZeWYjW45DBAtz8x2rURjdjs1fxvD/qYF2vK99
         W/kw==
X-Gm-Message-State: AOJu0Yy6tDfgTyUqJy8NlZ5kulmo/ioKpWSqE4LpEwkl3RVpQ51erDhw
        p4DdfGpqXaxnYGabtrtrgIZ5KjogatcdvUaB2wU=
X-Google-Smtp-Source: AGHT+IGraImbABbVnYg6Ry57RVFnd3IqKf02szE055lgCefoqqyZvE2zfw+kuPwbsXcgZfPjjXz5Afh8lqooVZbQ9JU=
X-Received: by 2002:a4a:305e:0:b0:58a:211:acf8 with SMTP id
 z30-20020a4a305e000000b0058a0211acf8mr10912431ooz.7.1700032033893; Tue, 14
 Nov 2023 23:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20231115033459.1228900-1-sashal@kernel.org> <20231115033459.1228900-2-sashal@kernel.org>
In-Reply-To: <20231115033459.1228900-2-sashal@kernel.org>
From:   Frediano Ziglio <freddy77@gmail.com>
Date:   Wed, 15 Nov 2023 07:07:02 +0000
Message-ID: <CAHt6W4cdQSXbBf4gO_jR-q-Q8SAonNDoQ0f2cO7LsnT__priWA@mail.gmail.com>
Subject: Re: [Spice-devel] [PATCH AUTOSEL 6.5 2/6] drm/qxl: prevent memory leak
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        maarten.lankhorst@linux.intel.com, virtualization@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>,
        Zongmin Zhou <zhouzongmin@kylinos.cn>, kraxel@redhat.com,
        tzimmermann@suse.de, spice-devel@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno mer 15 nov 2023 alle ore 06:57 Sasha Levin
<sashal@kernel.org> ha scritto:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> [ Upstream commit 0e8b9f258baed25f1c5672613699247c76b007b5 ]
>
> The allocated memory for qdev->dumb_heads should be released
> in qxl_destroy_monitors_object before qxl suspend.
> otherwise,qxl_create_monitors_object will be called to

Minor, typo: otherwise -> Otherwise.

> reallocate memory for qdev->dumb_heads after qxl resume,
> it will cause memory leak.
>
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> Link: https://lore.kernel.org/r/20230801025309.4049813-1-zhouzongmin@kylinos.cn
> Reviewed-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 6492a70e3c396..404b0483bb7cb 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1229,6 +1229,9 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
>         if (!qdev->monitors_config_bo)
>                 return 0;
>
> +       kfree(qdev->dumb_heads);
> +       qdev->dumb_heads = NULL;
> +
>         qdev->monitors_config = NULL;
>         qdev->ram_header->monitors_config = 0;
>

Frediano
