Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21447C8F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJMVni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMVng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:43:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB9BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:43:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405459d9a96so8375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697233413; x=1697838213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3zoiWUdkneBEaFk5I7hrAkCBa7NtffBoDcVnMT2q3A=;
        b=tNHg9IkarHtwex26EQje5icpzQNnK3ambPpCUGxgPZi1qKTFVGuNHSK41XkUxZ4Yrn
         /pQoVWv6j4L2P/No55OSE7qtRQYWHfrJ0REUzN3d3Rhe6FJKV16j9iJbhRtMbVU06hAX
         8LAbWjyMCu5Yp9P9FZczd68WJL6YaFUIAUo7eDC0yS6BrqJ5rudKLdFRwOilENxymofN
         IgCLEGrEPFppZKZ8XHnPz5XOqK0JVLFfMX+CijXMNipW+7kRaqcX03dUlxS+G9BR/+fA
         ZadMpQukzYmspKt3gC7RU5PP21f4BpyKiuOl40ya4Rfi1Hved6dQlKWI7idc0CIEBSI7
         K1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233413; x=1697838213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3zoiWUdkneBEaFk5I7hrAkCBa7NtffBoDcVnMT2q3A=;
        b=ihP5mK/hT3ADrBe/R8H5VzdU+YBJQ7es5toTHQyTIcWsys59MTSwBT1o1vcnNZb8+h
         O0P2HLv/Qddv8bRO3PTg7a81ZJId+fOmaLhfY49whD4r5jROGux+VeQMaClli3RwrB+D
         Tnx1eOz6XN1Y2CHELHygb8jKXlbl4P/Fu41rYe4zaMm/7e8R7TrSGl4ssKlYl7x93mXa
         YGms1y3vV+UIPQg//i3NLFt0cDu4sg/BKuRnNFOw/yHImLjPBRzmKThNHOWblF0tB5+M
         yuKYxv06pxdKsUpPo9+O6FlUu/8rqmaTNmXWcSI5yug4hul6rKHAzQkNqCJ/bwkjbOch
         CaWg==
X-Gm-Message-State: AOJu0Yyj2zM42jyy/SK4oK95iNX14BKaS2SIAxpzUS8zQzTVQQ1U6Jm1
        /hdqsBFtUKQt74g0n0UleGd2QjvWsdSI8joDpvg2Aw==
X-Google-Smtp-Source: AGHT+IFimHHzZbvU27tVl2xC9YG2acwdrMwexMXiYTK79YTRh5LQhvVTDZSNNk1zlbKIPyNm0adqtMZ7FEM9z5lCQ6Y=
X-Received: by 2002:a05:600c:4e09:b0:3fe:eb42:7ec with SMTP id
 b9-20020a05600c4e0900b003feeb4207ecmr5476wmq.1.1697233412882; Fri, 13 Oct
 2023 14:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091844.804310-1-yangcong5@huaqin.corp-partner.google.com> <20231013091844.804310-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231013091844.804310-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 13 Oct 2023 14:43:12 -0700
Message-ID: <CAD=FV=UVP22ANJD5xEB6MRHCDjXN6SZhQWQshPxwhi51YRkEjQ@mail.gmail.com>
Subject: Re: [v4 2/3] drm/panel: ili9882t: Avoid blurred screen from fast sleep
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi,

On Fri, Oct 13, 2023 at 2:19=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> At present, we have found that there may be a problem of blurred
> screen during fast sleep/resume. The direct cause of the blurred
> screen is that the IC does not receive 0x28/0x10. Because of the
> particularity of the IC, before the panel enters sleep hid must
> stop scanning, as i2c_hid_core_suspend before ili9882t_disable.
> If move the ili9882t_enter_sleep_mode function to ili9882t_unprepare,
> touch reset will pull low before panel entersleep, which does not meet
> the timing requirements.. So in order to solve this problem, the IC
> can handle it through the exception mechanism when it cannot receive
> 0x28/0x10 command. Handling exceptions requires a reset 50ms delay.
> Refer to vendor detailed analysis [1].
>
> Ilitek vendor also suggested switching the page before entering sleep to
> avoid panel IC not receiving 0x28/0x10 command.
>
> Note: 0x28 is display off, 0x10 is sleep in.
>
> [1]: https://github.com/ILITEK-LoganLin/Document/tree/main/ILITEK_Power_S=
equence
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

As talked about in response to the previous version [1], we can work
to see if we can improve the sequencing. However, for now this seems
fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DW_LT9mPYKjaKP3OvUDeNpsZxkhVN9NP_hQ=
+Es6Fe3dVw@mail.gmail.com
