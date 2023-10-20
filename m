Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291417D166D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjJTTkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:40:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7DD61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:40:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53d82bea507so1803512a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697830804; x=1698435604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgSR78Y5iW6fUNSAk+Ec5zBGBhE6zMbcclrxXV+8asg=;
        b=Qc/dD5c96p/AfnRzl92TiembOzSgE/b188kVcPfi4zGWy0kK1wpk96Jp3ADHRIVsDS
         wRkMjYz5S5dVRtS7Y7XtneyHP6/fdOSRgaGtxrsOBWjScXwqgsgq447VAb8na4SJ0Qa8
         Yj3sPYWX/9a7ZHmAYYRYPJRXvWCSbqO0AkGi33X10ZutHPr5j6YkdXV+DrGQgZOfRrUs
         0qrvNjlQ12OBA/wonO3+kwc6l5G/5Cv9tkx1cPJUmpiSm+ebiQ+e3yHK9FExUCo09Iwm
         RSo2qhH0eDtvXp8TXZBxXGpO9fDfGUY/xKu36IeIEJVtL4eJ/wdVIWxLrKVLhQBFbGvf
         H9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697830804; x=1698435604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgSR78Y5iW6fUNSAk+Ec5zBGBhE6zMbcclrxXV+8asg=;
        b=Ed/pfeE0AKuO6hGWB+PCbHRmtZsVpVPB9ss7n5ux9CfKgSvxcOoJzP3b2UK263MMdt
         p+ht6d1LAf3T0vsTt2LBUf+D1nZjF9byc80QqpfBxY24wSOSW1Pj7NGT4RNvCIXn1EA+
         VgGIcG6CK/cK3lhNs8fji+bUQ8JheuED56ZJZDa6Bdb7CpCApRcAbk0B/gPov/heCA9r
         WaydywfPI5mr1lX9mDEjZdpaOVk2N7lEBFMyEH52tz9oKEPNJWxt+QxpwSOBo0vC8s8L
         z3WQkMVpNKCByLmPI3hr59EYCgqqT1L4NlKhAKbKRxhPCbTt+iyYxtB3TR7uHlyhQezv
         hpAw==
X-Gm-Message-State: AOJu0YzSaeQuuYkP7YJtvYKREBvI0kmiqfRTnMFEoGs8xVULs7/5AB6q
        of/eMFyrNYX85Mny09b/Emn78aHkyLCJeI4LDmNG/Q==
X-Google-Smtp-Source: AGHT+IFTEQobdtzxPAwaayqWrS4ZbZc4xYWbr52usrp2lJE1NRzN7GrvR7+j17KbToBH/AuVe46bdUQ2lvuVKJOjTIQ=
X-Received: by 2002:a50:9ec4:0:b0:53d:9471:76b3 with SMTP id
 a62-20020a509ec4000000b0053d947176b3mr2125116edf.7.1697830804202; Fri, 20 Oct
 2023 12:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231020-strncpy-drivers-power-supply-surface_battery-c-v1-1-cabaea50e667@google.com>
In-Reply-To: <20231020-strncpy-drivers-power-supply-surface_battery-c-v1-1-cabaea50e667@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 20 Oct 2023 12:39:51 -0700
Message-ID: <CAFhGd8pZYrQNCLA1LHckHQYFtAffSAwpf6uKx6cbf_rVPS_+jg@mail.gmail.com>
Subject: Re: [PATCH] platform/surface: aggregator: replace deprecated strncpy
 with strscpy
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the subject line in [v2].

On Fri, Oct 20, 2023 at 12:35=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect bat->name to be NUL-terminated based on its usage with
> strcmp():
>
> power_supply_core.c:
> 445: return strcmp(psy->desc->name, name) =3D=3D 0;
>
> ... and also by the manual `... - 1` for the length argument of the
> original strncpy() invocation.
>
> Furthermore, no NUL-padding is needed as bat is zero-allocated before
> calling spwr_battery_init():
> 826: bat =3D devm_kzalloc(&sdev->dev, sizeof(*bat), GFP_KERNEL);
> 827: if (!bat)
> 828:   return -ENOMEM;
> 829:
> 830: spwr_battery_init(bat, sdev, p->registry, p->name);
>
> ... this means any further NUL-byte assignments (like the ones that
> strncpy() does) are redundant.
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Let's also opt to use the more idiomatic strscpy() usage of:
> (dest, src, sizeof(dest)).
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  drivers/power/supply/surface_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/suppl=
y/surface_battery.c
> index 19d2f8834e56..196d290dc596 100644
> --- a/drivers/power/supply/surface_battery.c
> +++ b/drivers/power/supply/surface_battery.c
> @@ -722,7 +722,7 @@ static void spwr_battery_init(struct spwr_battery_dev=
ice *bat, struct ssam_devic
>                               struct ssam_event_registry registry, const =
char *name)
>  {
>         mutex_init(&bat->lock);
> -       strncpy(bat->name, name, ARRAY_SIZE(bat->name) - 1);
> +       strscpy(bat->name, name, sizeof(bat->name));
>
>         bat->sdev =3D sdev;
>
>
> ---
> base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
> change-id: 20231020-strncpy-drivers-power-supply-surface_battery-c-b0c84b=
05ac28
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[v2]: https://lore.kernel.org/r/20231020-strncpy-drivers-power-supply-surfa=
ce_battery-c-v2-1-29ed16b2caf1@google.com

Thanks
Justin
