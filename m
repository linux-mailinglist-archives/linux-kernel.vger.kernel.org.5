Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1D7D6225
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjJYHK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:10:26 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B88A6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:10:24 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d4453ba38so33423986d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698217823; x=1698822623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJCSH9eDJwpsxO6Ut9LCRybVZdABQ/WkcuHbj4Jy4YQ=;
        b=ecq3Ml8/MHhR3zMUeb1ZazPBbEz28oolxZMzRAExpB6uHzmXDrr/CuoXFrrznI01r5
         hf3mP4FvLOE8gD8xwc67h9GCTlyqojFTdrkr6r0fMLFxJFywzwpsnWEPpr7hk4iP15N8
         /9aIH49KcDdCr/HoYYB9fk/QfL/z6JUa4i77cv0mgVb9Uuh2f10o9BOrHFVx/ByRhuiq
         iz0bGoK9kdxr7/hVFyLlsuH8mNrR3lMx4DOgqGKWBpMsp12UDON2O++yn2MXk/FqmW4G
         6Qi36703rr8f4EL6F8INukZLlihBngFfjnHilanBNEbMlc8gtIQK/T0lpqbMstcsIvWV
         NF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698217823; x=1698822623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJCSH9eDJwpsxO6Ut9LCRybVZdABQ/WkcuHbj4Jy4YQ=;
        b=mfLrQic/6ZAVykGMPfOZTVLfimz/heLOivfothyvrAVbPd4hIaXpdUJjp73GVeM4Ba
         YeAdwffJkXTdrYPqVUayH24XpAC4tD6XGQDfdaNklRv7XvQUErl+Cn6kVT6jCwICHFh1
         dASc1/FM7D9RSaTQGU3FbptFcdqdaHmrAs4njovBog5WdCMHLTEn9SuzqgppKUFkjRZ5
         ndjgeRGztgnVq9Woc3ieoiw6N4+PN1SkR2Tka2qN0uH3uez1ZdHo2ZFzw9YWlJUQMrKG
         TcDCXQkn7W4ZcouxLXhqOIiIpXyF+blcDPxOvIsYqAzVHLQerrReqsc0jGjUQAb/q6N8
         gG4w==
X-Gm-Message-State: AOJu0YylDWwc7zQxiIlFi4J1TB5ZOrCn07L1CJos9K/sEdwHoQ8uGykO
        fG4uLN1jSFrxUyzgkPEAvbxDaToO5+o37ubYCAD3J2+j7FvVCC0w
X-Google-Smtp-Source: AGHT+IE5+fQ18+D6cW9YARivR4qTXWB+X5H68UlxAUDmI5BhZc1Tl/cmpWDwIgiJJ4DW15lrPoDSgvxY7aKKXZ4kNNU=
X-Received: by 2002:ad4:5e8e:0:b0:66d:9f68:219f with SMTP id
 jl14-20020ad45e8e000000b0066d9f68219fmr14628955qvb.3.1698217823454; Wed, 25
 Oct 2023 00:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com> <20231024-ffa-notification-fixes-v1-1-d552c0ec260d@arm.com>
In-Reply-To: <20231024-ffa-notification-fixes-v1-1-d552c0ec260d@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 25 Oct 2023 09:10:11 +0200
Message-ID: <CAHUa44GvCeihX8KQkXELOAkZpYVq6=3M06MT8GEd3COA3GPhTw@mail.gmail.com>
Subject: Re: [PATCH 1/4] firmware: arm_ffa: Allow FF-A initialisation even
 when notification fails
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:56=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
>
> FF-A notifications are optional feature in the specification. Currently
> we allow to continue if the firmware reports no support for the
> notifications. However, we fail to continue and complete the FF-A
> driver initialisation if the notification setup fails for any reason.
>
> Let us allow the FF-A driver to complete the initialisation even if the
> notification fails to setup. We will just flag the error and continue
> to provide other features in the driver.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa=
/driver.c
> index 07b72c679247..b4ba52d674e5 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -1390,20 +1390,20 @@ static void ffa_notifications_cleanup(void)
>         }
>  }
>
> -static int ffa_notifications_setup(void)
> +static void ffa_notifications_setup(void)
>  {
>         int ret, irq;
>
>         ret =3D ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NUL=
L);
>         if (ret) {
> -               pr_err("Notifications not supported, continuing with it .=
.\n");
> -               return 0;
> +               pr_info("Notifications not supported, continuing with it =
..\n");
> +               return;
>         }
>
>         ret =3D ffa_notification_bitmap_create();
>         if (ret) {
> -               pr_err("notification_bitmap_create error %d\n", ret);
> -               return ret;
> +               pr_info("Notification bitmap create error %d\n", ret);
> +               return;
>         }
>         drv_info->bitmap_created =3D true;
>
> @@ -1426,10 +1426,11 @@ static int ffa_notifications_setup(void)
>         ret =3D ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_=
handle,
>                                        drv_info, true);
>         if (!ret)
> -               return ret;
> +               return;
>  cleanup:
> +       pr_info("Notification setup failed %d, not enabled\n", ret);
>         ffa_notifications_cleanup();
> -       return ret;
> +       return;

This return is redundant.

Thanks,
Jens

>  }
>
>  static int __init ffa_init(void)
> @@ -1487,13 +1488,9 @@ static int __init ffa_init(void)
>
>         ffa_set_up_mem_ops_native_flag();
>
> -       ret =3D ffa_notifications_setup();
> -       if (ret)
> -               goto partitions_cleanup;
> +       ffa_notifications_setup();
>
>         return 0;
> -partitions_cleanup:
> -       ffa_partitions_cleanup();
>  free_pages:
>         if (drv_info->tx_buffer)
>                 free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
>
> --
> 2.42.0
>
