Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62814760192
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjGXVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGXVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:53:46 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26806118
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:53:45 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b05d63080cso3804532fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235624; x=1690840424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4SHNWvonq3pTdPu5w/9lA9SaPd7vXM0OcBb+UX7Zcc=;
        b=Totw2DOP+aVvqwlywvLYSHlv7/hFnTw5PoZMFmPdshevUEe+e96+tR5JCJrBTv/7AR
         5H5ZZNZagYQ3qPvvNO2xhWG0QzO0Y90y/UUIvYFpOuVn3YAkv5LE7HTfyd59/lGlqf8x
         trnruv82xA7s3X1xOVLk7oLBCU0dI0p6bukMxZrIbeA2FxMFPYiZJdDwsTJis4Coze1J
         x2624MmavfBFkqursl/yboRQGV2e9bNu+pkNR7/ZdNjxNxQTS4Op9t0qPNAsHqc2Szm9
         HWeHrHDA32xz0vFCCAi4MH0qIr3vac7JLQ9ZDwYq6uRa5Y0gDWTZU8isLOk/Bwi1dH37
         9LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235624; x=1690840424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4SHNWvonq3pTdPu5w/9lA9SaPd7vXM0OcBb+UX7Zcc=;
        b=bcJQk9uuoPY/VbYZY682ZJ9LpggatvDVI+lDb9+jcWTWcWD3UFdcjqZXZ6t43m1yF6
         AQ/tkzs4NJNXM057Pbsh3Ro1Li6lR3xVyZ7ZD8uHBKRM6i0/0brelL19yaxLIwe1oe2u
         pSxdhhrGQi8IREfu6UFeLTlDhA5dsTM3u2kecpB/MGjn6m6EbwBAliBgowjZYtRjaGTB
         LJjgb1zY6zrEJ490zlUhm2itdk8EgGf/FsnN1BWo7hUJVu1JFUDdPpA6/1TWPTbEBx7a
         bB880SQjjJDpyeY4IGJT1Au8dzdCVJPx5nOcLpyRdpx2DQSkL5vNkH9dZ51vY1r5GCgU
         8byw==
X-Gm-Message-State: ABy/qLZ17DHjGOFt0Moi2gp8PvHa4ZZsxyV0krusY6+o2PbJE4DZDw8P
        osipqBTSoxS698r5T8fkJjHQwc4uIzDrxj0C074=
X-Google-Smtp-Source: APBJJlFIfsDwrK83y95RbhA0I4iIT2y/sEJO0jQBfv+G0amgLdB9nh2cRiNGnstNhk1bHnNuKe9VEbs5ZY6xrwU4tWw=
X-Received: by 2002:a05:6870:b50b:b0:1b3:eec8:fa87 with SMTP id
 v11-20020a056870b50b00b001b3eec8fa87mr12990007oap.42.1690235624460; Mon, 24
 Jul 2023 14:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230724084109.9496-1-xujianghui@cdjrlc.com> <7fde0c4213bf401813918ac05f313fbb@208suo.com>
In-Reply-To: <7fde0c4213bf401813918ac05f313fbb@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:53:33 -0400
Message-ID: <CADnq5_MUvvpznMhVB5DabVuNYgiyjbn_QEvTRr=ne7-8Ypc+xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: that open brace { should be on the previous line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 24, 2023 at 4:42=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> index beab6d7b28b7..630132c4a76b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> @@ -52,8 +52,7 @@ static unsigned int DbiPrbs7[] =3D
>
>
>   //4096 bytes, 256 byte aligned
> -static unsigned int NoDbiPrbs7[] =3D
> -{
> +static unsigned int NoDbiPrbs7[] =3D {
>       0x0f0f0f0f, 0x0f0f0f0f, 0x0f0f0f0f, 0xf0f00f0f, 0x0f0f0f0f,
> 0x0f0f0f0f, 0xf0f0f0f0, 0x0f0f0f0f, 0x0f0f0f0f, 0xf0f00f0f, 0xf0f00f0f,
> 0x0f0f0f0f, 0xf0f0f0f0, 0xf0f0f0f0, 0x0f0f0f0f, 0xf0f00f0f,
>       0x0f0f0f0f, 0xf0f00f0f, 0xf0f0f0f0, 0x0f0f0f0f, 0xf0f0f0f0,
> 0xf0f00f0f, 0xf0f00f0f, 0xf0f00f0f, 0x0f0ff0f0, 0xf0f0f0f0, 0xf0f0f0f0,
> 0x0f0ff0f0, 0x0f0f0f0f, 0x0f0f0f0f, 0xf0f0f0f0, 0xf0f00f0f,
>       0x0f0f0f0f, 0xf0f00f0f, 0x0f0ff0f0, 0x0f0f0f0f, 0xf0f0f0f0,
> 0x0f0ff0f0, 0xf0f00f0f, 0xf0f00f0f, 0xf0f0f0f0, 0x0f0ff0f0, 0xf0f0f0f0,
> 0xf0f00f0f, 0xf0f0f0f0, 0x0f0f0f0f, 0x0f0ff0f0, 0xf0f00f0f,
> @@ -121,8 +120,7 @@ static unsigned int NoDbiPrbs7[] =3D
>   };
>
>   // 4096 bytes, 256 byte aligned
> -static unsigned int DbiPrbs7[] =3D
> -{
> +static unsigned int DbiPrbs7[] =3D {
>       0xffffffff, 0xffffffff, 0xffffffff, 0x0000ffff, 0xffffffff,
> 0xffffffff, 0x00000000, 0xffffffff, 0xffffffff, 0x0000ffff, 0x0000ffff,
> 0xffffffff, 0x00000000, 0x00000000, 0xffffffff, 0x0000ffff,
>       0xffffffff, 0x0000ffff, 0x00000000, 0xffffffff, 0x00000000,
> 0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffff0000, 0x00000000, 0x00000000,
> 0xffff0000, 0xffffffff, 0xffffffff, 0x00000000, 0x0000ffff,
>       0xffffffff, 0x0000ffff, 0xffff0000, 0xffffffff, 0x00000000,
> 0xffff0000, 0x0000ffff, 0x0000ffff, 0x00000000, 0xffff0000, 0x00000000,
> 0x0000ffff, 0x00000000, 0xffffffff, 0xffff0000, 0x0000ffff,
