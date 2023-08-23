Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28D784EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjHWCVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjHWCVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92EAE4B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692757260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Wd+9HuqUCEfQdvgPE3ApyuJjNlq3+0oy7KtDrGhF4c=;
        b=RdA8CmYZboYxW09IPwva9Yzm+vAMPkKVI5zNjIngQpMffhjAOYfB7zqrZ2BiAnpPQOJcV5
        bKsCDBc6cxiMIxpgrGq8KTrRuJBQTKo8SER5L0FfCcH3WJruYEeK52OX/q+0+5lz/RSzM8
        +0aeOm4R+sKIv5+xdzJV+qMBP7zzlS8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-EdG8zUvvPSyZ20Z2UX1Ndg-1; Tue, 22 Aug 2023 22:20:59 -0400
X-MC-Unique: EdG8zUvvPSyZ20Z2UX1Ndg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68a43131e50so4351694b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692757258; x=1693362058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Wd+9HuqUCEfQdvgPE3ApyuJjNlq3+0oy7KtDrGhF4c=;
        b=M9CcTquF09LI+rqTAu/79xiv7e+DmM4yzKPqZ9UoQhiGzDcQxkwx5Oey4apOLmOkw5
         S19azTEX2q85gxaBa1ITrNiA+lMq0/z1eJLNtJTpEnuFURzP7j/XSV6gPYner+JPbBTU
         GoqDsq3JS7MxkE60qdiNfNOALWNOtJ1xs1/U9mlKHb4sn2BEuq1LGsta3vr4YH5yUyHQ
         ZsuEoxdc69etjqwxmbob2jXDx9PyszPnciwwfHnggwBeJXb+ZiPPwaZ7dkSIOqwbqlku
         QOSwd/NCVqoK+09+X8LzpVXSLFpX5n4y/BDsPD8kXVFSa0t62CH2vyTtVXJEPHd0yulr
         nMNg==
X-Gm-Message-State: AOJu0YwNYFTnND8yjoxP1fl2UWAjkvuJk3T2rpCl96mDtElpXo7Pj3MI
        ZDyauRAOq6XXgxQiEhBddKGi3Y8BxDS04t2PVLFO+hm8P9ty795LKT7PBhbdPxtDFtVClrpPWEw
        q4xAeHpIqckVq6GKVc8nRxCOq6/FcfsyhKZwDAQo1AliMelDw44U=
X-Received: by 2002:a05:6a00:1885:b0:68a:49bc:e091 with SMTP id x5-20020a056a00188500b0068a49bce091mr9363391pfh.2.1692757258207;
        Tue, 22 Aug 2023 19:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF++hi+KyxP6UcT9dWWf/hS/LuaZrmo41F7h8KjG/JktBPtOw7zdl2zwJHAFzQr/fLjbf4F9bjFQae0JSBTQ8=
X-Received: by 2002:a05:6a00:1885:b0:68a:49bc:e091 with SMTP id
 x5-20020a056a00188500b0068a49bce091mr9363379pfh.2.1692757257914; Tue, 22 Aug
 2023 19:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com> <20230820090949.2874537-6-yukuai1@huaweicloud.com>
In-Reply-To: <20230820090949.2874537-6-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 23 Aug 2023 10:20:46 +0800
Message-ID: <CALTww28fa_LUVfzswTmpascZEYr-PdyjgoU88A+H9Q7CP04VXA@mail.gmail.com>
Subject: Re: [PATCH -next v3 5/7] md: factor out a helper rdev_is_spare() from remove_and_add_spares()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 5:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> There are no functional changes, just to make the code simpler and
> prepare to delay remove_and_add_spares() to md_start_sync().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index ceace5ffadd6..11d27c934fdd 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9169,6 +9169,14 @@ static bool rdev_removeable(struct md_rdev *rdev)
>         return true;
>  }
>
> +static bool rdev_is_spare(struct md_rdev *rdev)
> +{
> +       return !test_bit(Candidate, &rdev->flags) && rdev->raid_disk >=3D=
 0 &&
> +              !test_bit(In_sync, &rdev->flags) &&
> +              !test_bit(Journal, &rdev->flags) &&
> +              !test_bit(Faulty, &rdev->flags);
> +}
> +
>  static int remove_and_add_spares(struct mddev *mddev,
>                                  struct md_rdev *this)
>  {
> @@ -9217,13 +9225,10 @@ static int remove_and_add_spares(struct mddev *md=
dev,
>         rdev_for_each(rdev, mddev) {
>                 if (this && this !=3D rdev)
>                         continue;
> +               if (rdev_is_spare(rdev))
> +                       spares++;
>                 if (test_bit(Candidate, &rdev->flags))
>                         continue;

Hi Kuai

Why not put rdev_is_spare after testing Candidate?

Best Regards
Xiao

> -               if (rdev->raid_disk >=3D 0 &&
> -                   !test_bit(In_sync, &rdev->flags) &&
> -                   !test_bit(Journal, &rdev->flags) &&
> -                   !test_bit(Faulty, &rdev->flags))
> -                       spares++;
>                 if (rdev->raid_disk >=3D 0)
>                         continue;
>                 if (test_bit(Faulty, &rdev->flags))
> --
> 2.39.2
>

