Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851597B8E47
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjJDUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjJDUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:44:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FBAC6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:44:40 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41983b83e53so1320511cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696452279; x=1697057079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsTHf1RxRwyrCT7iXJgHTlu9ULLERBCmiy3t5RYublw=;
        b=ejpowT72cbHCwTCoyvwcjZx8IdYjV2Amscu1qZ3Nn7yKaLvTSp/2yYv9eJICAarjgh
         ul1YFeWMCtKS9e6tJbz1/EGW8xjp9AsTAYO5E8Pk+Kad/U2P1psPbvuv+KUPipDXc7ca
         A7xhTdF94WlCzlVhsgpUf7B5ezCaC/P29gYwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696452279; x=1697057079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsTHf1RxRwyrCT7iXJgHTlu9ULLERBCmiy3t5RYublw=;
        b=dvEgKKbinxyLn3Qr4aQD+H3p097c+M4Xc7HBnp9LNp4GwQ0awzv33ZrK/r9k+ptmMo
         YTUGmy5qR3R37h/V263y1cK9LNmE4Vi3EFJQvQmNTshPALl+jl6QnMU3hRjMSvzLJDpG
         U8ypuIkhug6BC7qJ0CDkO1zwjaVhX8cwW3Ocl0AHm8P5QfhwAW7FH8rfivgtQUwP0Mqg
         z0rVnsKKVQe+RQxpLO+fPtw4T2qNhRECt72oD3b06mjbkpkUXASgjPmk7E4lguN+Ooq/
         Vzv3X3ahRETxmMqlekyu9bJQUsdqz25A5PaTrjCCBrA+sN0OjzxT0CsgNqrgqXUorG97
         GQ0A==
X-Gm-Message-State: AOJu0YxXA59+boV3cqxduzPJ/dvsE2V5Op8fqDnm8yc2fXPKaT2nF24h
        OIit49f+F7LnnpRPccN6MfID8IxSQUSQmsa5hUaYAg==
X-Google-Smtp-Source: AGHT+IHc7TqC5oKuPmbxt1kOS8T9mt08qtsrKtF4I/TQ9q59kAv7XXZDPGfZr2V4UU7oH/oOurE+ww==
X-Received: by 2002:a05:622a:548:b0:417:b45b:84c3 with SMTP id m8-20020a05622a054800b00417b45b84c3mr3723369qtx.65.1696452278792;
        Wed, 04 Oct 2023 13:44:38 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id w28-20020a05620a149c00b0076ef29f3429sm1525839qkj.120.2023.10.04.13.44.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:44:37 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-419768e69dfso100171cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:44:37 -0700 (PDT)
X-Received: by 2002:a05:622a:100e:b0:417:5a8c:a104 with SMTP id
 d14-20020a05622a100e00b004175a8ca104mr69912qte.26.1696452277267; Wed, 04 Oct
 2023 13:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
In-Reply-To: <20230928015858.1809934-1-linan666@huaweicloud.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 4 Oct 2023 13:44:26 -0700
X-Gmail-Original-Message-ID: <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
Message-ID: <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     linan666@huaweicloud.com
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 7:05=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> When the throttle of bps is not enabled, tg_bps_limit() returns U64_MAX,
> which is be used in calculate_bytes_allowed(), and divide 0 error will
> happen.
>
> To fix it, only calculate allowed value when the throttle of bps/iops is
> enabled and the value will be used.
>
> Fixes: e8368b57c006 ("blk-throttle: use calculate_io/bytes_allowed() for =
throtl_trim_slice()")
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+Vt6idZtxfU9jF=3DVSbu145Wi-d-Wn=
AZx_hEfOL8yLZgBA@mail.gmail.com
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-throttle.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 38a881cf97d0..3c9a74ab9f0e 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -730,8 +730,10 @@ static u64 calculate_bytes_allowed(u64 bps_limit, un=
signed long jiffy_elapsed)
>  static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>  {
>         unsigned long time_elapsed;
> -       long long bytes_trim;
> -       int io_trim;
> +       long long bytes_trim =3D 0;
> +       int io_trim =3D 0;
> +       u64 bps_limit;
> +       u32 iops_limit;
>
>         BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
>
> @@ -758,11 +760,14 @@ static inline void throtl_trim_slice(struct throtl_=
grp *tg, bool rw)
>         if (!time_elapsed)
>                 return;
>
> -       bytes_trim =3D calculate_bytes_allowed(tg_bps_limit(tg, rw),
> -                                            time_elapsed) +
> -                    tg->carryover_bytes[rw];
> -       io_trim =3D calculate_io_allowed(tg_iops_limit(tg, rw), time_elap=
sed) +
> -                 tg->carryover_ios[rw];
> +       bps_limit =3D tg_bps_limit(tg, rw);
> +       iops_limit =3D tg_iops_limit(tg, rw);
> +       if (tg->bytes_disp[rw] > 0 && bps_limit !=3D U64_MAX)
I don't think this change is sufficient to prevent kernel crash, as a
"clever" user could still set the bps_limit to U64_MAX - 1 (or another
large value), which probably would still result in the same crash. The
comment in mul_u64_u64_div_u64 suggests there's something we can do to
better handle the overflow case, but I'm not sure what it's referring
to. ("Will generate an #DE when the result doesn't fit u64, could fix
with an __ex_table[] entry when it becomes an issue.") Otherwise, we
probably need to remove the mul_u64_u64_div_u64 and check for
overflow/potential overflow ourselves?

Khazhy
> +               bytes_trim =3D calculate_bytes_allowed(bps_limit,
> +                            time_elapsed) + tg->carryover_bytes[rw];
> +       if (tg->io_disp[rw] > 0 && iops_limit !=3D UINT_MAX)
> +               io_trim =3D calculate_io_allowed(iops_limit, time_elapsed=
) +
> +                         tg->carryover_ios[rw];
>         if (bytes_trim <=3D 0 && io_trim <=3D 0)
>                 return;
>
> --
> 2.39.2
>
