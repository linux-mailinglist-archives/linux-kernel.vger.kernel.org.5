Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56E7D45C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjJXC7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjJXC7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:59:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F0FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:59:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a29c7eefso5981660e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698116351; x=1698721151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvrqgGSngoJnXhESnfS3t+NdB91nFoYVT3tITLPVU4M=;
        b=i6dAKWjzP8barq/3IpEpyqf9ssxXqAGHROwrf3JijTpIXBWtc5gt9BV3bE0noUFbV0
         keTtas6Lc4R2EBM/qvtpjuYRgoPnu5VVFPPvK8ySztD/YRpPSnQTFf5xQ+lt1nImXw/j
         6Lk014crdk1PDc5+S2x9v4grmtE6io0haf4y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698116351; x=1698721151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvrqgGSngoJnXhESnfS3t+NdB91nFoYVT3tITLPVU4M=;
        b=WyfYbIVdAgj8Jt9O5Jv5jz7tJqdmAWbBWoJc4/6LxWTMhr86jBEyVfm7wG6T3Up8LW
         zTyDrsbDPj7dQECvA4Cx/dwC7wpqFYPBGzA1YuDyDRomy7IwAapHAwEckIT2zjah7ROs
         JgHzpSxj1h8C/TFWOkeNtOLuaSaM5SsABwOczKbXdOPEiZRB5gFVgK3dyBb3IQ7S/kO7
         H5vHL13WRpHk8gIf7iXF6jRKqkIAZGwAjSFqC201CrYhLtVxnsd20hDzvgaSAf54ycpI
         7tRJOQVdjJY6p/VxuA0yjDmXjYS+rjPXjeyeKkYwKPgVZdcdY93tR7NvP/yZpJWibmdh
         9Jsg==
X-Gm-Message-State: AOJu0Yw8kh5W2h2+wXYq58UKDrbJ5dfHK495A1rZpB2WBsOlR2//ERK/
        /dBdWah86gfT/nxmLC53y9whrC5sU/rbXezOnjTBbQ==
X-Google-Smtp-Source: AGHT+IGBrjxdShgGwLm/nKBlp6mMXyHZKc8GJR6Sa8BG8WPw9au3jcqx4fC7Aiq/VT+UoJbUAgQ50zuQjPdOXvQt81c=
X-Received: by 2002:ac2:562a:0:b0:500:94c3:8e3b with SMTP id
 b10-20020ac2562a000000b0050094c38e3bmr7076723lff.57.1698116350988; Mon, 23
 Oct 2023 19:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com> <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org>
In-Reply-To: <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 24 Oct 2023 10:58:59 +0800
Message-ID: <CAGXv+5EpBLnXVdxnk9wBZi5F7U5wdJRfYH7fgg4Lkr1HJXm+WA@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com,
        matthias.bgg@gmail.com, u.kleine-koenig@pengutronix.de,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:52=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Quoting Chen-Yu Tsai (2023-10-19 22:06:35)
> > On Thu, Oct 19, 2023 at 8:49=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > >
> > > Fix the parenting of clocks imp_iic_wrap_ap_clock_i2c{4-6}, as those
> > > are effectively parented to infra_ao_i2c{4-6} and not to the I2C_AP.
> > > This permits the correct (and full) enablement and disablement of the
> > > I2C4, I2C5 and I2C6 bus clocks, satisfying the whole clock tree of
> > > those.
> > >
> > > As an example, when requesting to enable imp_iic_wrap_ap_clock_i2c4:
> > >
> > > Before: infra_ao_i2c_ap -> imp_iic_wrap_ap_clock_i2c4
> > > After:  infra_ao_i2c_ap -> infra_ao_i2c4 -> imp_iic_wrap_ap_clock_i2c=
4
> > >
> > > Fixes: 66cd0b4b0ce5 ("clk: mediatek: Add MT8186 imp i2c wrapper clock=
 support")
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> >
> > I'm curious about what led to discovering this error?
> >
>
> Is that an acked-by?

MediaTek engineers are saying the original code already matches the
documentation provided by their hardware engineers. I'm trying to get
them to respond on the mailing list.

ChenYu
