Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F168134B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573771AbjLNP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573678AbjLNP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:27:02 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BD98E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:27:08 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b9dc3215d2so3524072b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702567628; x=1703172428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQPQZjgJy3gqYdaJqPCEjYdalaI4tsnH21GXtDs8Yzk=;
        b=cjkAX/ZUzi1qaBBJ9TkjPX8UnH7vSgrSoPu6n4PFnF27Kc2d5D0mCuaD26KX+KXR4f
         yY5TUvl5+zWEDz++P/OtBev1hI1GE4lInplYeMCA0LPsmMY0BXa7OmzeH20URAdhCQXB
         /I3hAThxz2A88+nmcDO9h5jRAbF7TD731CoPioYKAhsuuwyiFekj1LKM9AzzecLuBeor
         tnHeezKh1qqaUCxP38nxE6r9KMz4P66CbPSp5/GLdfmls8Dz6vC5SyO/xLmJ0+rZv9XB
         LJB0+HQ0px19C7/wquQhVlAizHuCpSpKudMFNfl4QNV4TERFMf1P2mxnlqw1h/h79Nn1
         hRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567628; x=1703172428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQPQZjgJy3gqYdaJqPCEjYdalaI4tsnH21GXtDs8Yzk=;
        b=IekpyGnCZVx4GxUL+UsaMZ5uAgmlo2yLJcR9UL/45ZouC7ksb/wV5HKISgC7mYxhvm
         xn3IxnwaZICONlrg0wSlfvQkTrAcz8hJGlyirlrJSGE9EQbFd9QsjsAHTSISf4GjTL9K
         0ANi5MWoKnmNVMoWx5MEGHA/WR4dk0fW+GJq+MY8VkG3EqOL3h4Jh4vUoDmGk7PqWBhj
         tZnOSpa6q4SzepU1xfIWN8JF/WHUCDO6yOFgMFIKKEGFWhqpM1IuJUNgOdo3UTkxydWr
         aiUAmFRPPtOX28YkinSAmMnhyJLuht8sr/UZKayha8JzVrkygdCFUlx6mqB9jEFehKF0
         DJdg==
X-Gm-Message-State: AOJu0Yz9nv6n5F490c1q4T5F8fW168a1iKb6Cor1xw7NsXRdRoMTKZvv
        n10Uk9l0+1tYnbcWtYN8bhbLgjA2FPrA2JkHy40MhqqG
X-Google-Smtp-Source: AGHT+IFxaUhMiZjLyo8TSQCHB2je7fkWGNaqTddpcZklvoyg8gxDKp/bPrzox5hejyW2il5ejMtz4rlwVUvZjrPf978=
X-Received: by 2002:a05:6870:171e:b0:203:5573:9f17 with SMTP id
 h30-20020a056870171e00b0020355739f17mr572625oae.115.1702567628088; Thu, 14
 Dec 2023 07:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20231214010154.47054-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231214010154.47054-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Dec 2023 10:26:56 -0500
Message-ID: <CADnq5_OK9+7VcXU9p1gyTcgmjAP=1p=WO1-UZKKEe8jyp83cgw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/pm: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Wed, Dec 13, 2023 at 8:02=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:1418:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7743
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index d409857fd622..c16703868e5c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1415,7 +1415,7 @@ static int smu_wbrf_event_handler(struct notifier_b=
lock *nb,
>                 break;
>         default:
>                 return NOTIFY_DONE;
> -       };
> +       }
>
>         return NOTIFY_OK;
>  }
> --
> 2.20.1.7.g153144c
>
