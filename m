Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29977DA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbjHPF5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241956AbjHPF4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:56:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972B2123
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:56:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-525597d891fso4381677a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1692165406; x=1692770206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzayyJZrpiuik7Awn0EQI35WlV9Oze6Arm7htxVYask=;
        b=fhV4xYgvE3lIh8gfbuMeh8o3oNXgNx5hLj56Bw2mERpz9/+bu1LPWzhHkB8lR4GOvb
         DViGP7bfiWDmPiXnCmlTqTnAYEaI8mAVymkWiTtRpMusqMHYAY/8Hz0eRIjPO1xVJ2q0
         gD8c7kLGL6Yl1xnVAHFflUImrilMZ9qU3zBsR1l/2MvQGCb0BY5xrf/3lMah3w8SOOQy
         M93i48vtjFTzv8sdCXUcalR+tfJ41124R1bUJcxjenVEN9Whte8ZBHdG63Q0zp7bOdv0
         dQ6GQn3GsGfGN5Ofo5RTLqeDQ1YsenJPEffAvBV9hP6iP07VUjJPZ3CB86kpSGvFiEvG
         /R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692165406; x=1692770206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzayyJZrpiuik7Awn0EQI35WlV9Oze6Arm7htxVYask=;
        b=Me9UqIKU12vjiV0hGycNc2KImHNY4TxrcRVtsFTwyZWBSvIhyjLOKmEgZ1SfECoZ0L
         W3CPamqsKIuyCaQMIoDnrG/Q1J8EvwqYVFkHH5TC6c/QajajCjUOVii73oQGLYOUUkny
         jhprMxU+AywSLTnbBU0VhzjNa9dQSFqLKO8TCUG+GiqyzFlXND7NJ4JEIekcyMmoINWm
         25miKt2KuWyKJF8PEMllIe5iR7ev6hVGLm7mepdrmNyu4pypTWed8pSB6AMSwTFF29EG
         vfS7LPD39N84e79LwW9hElSKYSo/7977fs/3vCmNsXywjxmlURUnYGtJMggmpxxDZDEe
         zm2Q==
X-Gm-Message-State: AOJu0YzJXpyGFVbQjfjvyrdK/hjZeXMuu/NEYRwGXkfn72iMHWTViYs2
        zkoa/k1tWq2J1DBU6ZuB9l8yWVXlqjBGFtBd8cQeOw==
X-Google-Smtp-Source: AGHT+IFf15M1gi7SSH3751Yics0V/U6f9ZEbkW8+Huwx9M2Cw5kwU8GJbbQexKCDmi58IVfcuKTugtAGJQERrf0uG14=
X-Received: by 2002:aa7:d443:0:b0:523:b225:701a with SMTP id
 q3-20020aa7d443000000b00523b225701amr725956edr.11.1692165406677; Tue, 15 Aug
 2023 22:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230816022210.2501228-1-lizhijian@fujitsu.com>
In-Reply-To: <20230816022210.2501228-1-lizhijian@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 16 Aug 2023 07:56:36 +0200
Message-ID: <CAMGffE=uzdnCjewjXXm67js9mgeWYUbBAJ3J2VTh_QZYosoaww@mail.gmail.com>
Subject: Re: [PATCH] drivers/rnbd: restore sysfs interface to rnbd-client
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, Ivan Orlov <ivan.orlov0322@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 4:22=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> Commit 137380c0ec40 renamed 'rnbd-client' to 'rnbd_client', this changed
> sysfs interface to /sys/devices/virtual/rnbd_client/ctl/map_device
> from /sys/devices/virtual/rnbd-client/ctl/map_device.
>
> CC: Ivan Orlov <ivan.orlov0322@gmail.com>
> CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> CC: Jack Wang <jinpu.wang@ionos.com>
> Fixes: 137380c0ec40 ("block/rnbd: make all 'class' structures const")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
oh, right, thx for the fix.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnb=
d-clt-sysfs.c
> index c36d8b1ceeed..39887556cf95 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -25,7 +25,7 @@
>
>  static struct device *rnbd_dev;
>  static const struct class rnbd_dev_class =3D {
> -       .name =3D "rnbd_client",
> +       .name =3D "rnbd-client",
>  };
>  static struct kobject *rnbd_devs_kobj;
>
> --
> 2.29.2
>
