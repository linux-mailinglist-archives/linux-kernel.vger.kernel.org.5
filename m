Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC978FF94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbjIAPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjIAPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:01:00 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5410E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:00:57 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48d05fdb8bfso697181e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693580457; x=1694185257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnevc20nRmP7PquEdhakfrPorTg+eX5G0icySYl0ICg=;
        b=e0GxURrcKQCV6bGGqPuGBCdRRRdeOiEuDvv5rfD+CT1y7Ol75HEUQ16vfFHahVGUm1
         cG18GzJbHfZXC6gA529jbbCV540IwhpdX2H0yZa8lKw9+Pe2b3iLhvJ16Xv5vu6xf2s1
         wzCmLGyQmRco6PvKLWPwXlr1HH4tVIjwd87Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693580457; x=1694185257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnevc20nRmP7PquEdhakfrPorTg+eX5G0icySYl0ICg=;
        b=CJ/H8FTZvNkm5wI//t7fKbSJWGymEuj4uen/B3W1/wBfpZwwEAnP5e/rML1HdOg2Zb
         pbyQ+19ylYAcYQ1gr1SWWA0UCQxc4Bg6d1Q4yt3kqG6Y03hHiDpwldvG17y6D6CzlFIG
         s/T7sD0+IlnxHy3lyj4P+OshxkHaxpE+ffKr1i6/+H1OzMIt3mEOB6pTBiry/stUeaQ8
         CFomT0Wu6XmcpOYbGRbbuFzf4ZzZtcT2D8uUBIqYWQyU6nS7QOe91zTAJy+ItclTJwrD
         wWlINEyeFktC1l/MD7s4og8sj8exIK5wTarC8SKXb63IgHQqg+65mDt8T+ljH2r0HUjL
         Dpgg==
X-Gm-Message-State: AOJu0YyEFM7jAnAuICHsNUPH85BBKlxR6mIdXWveluPe469t+O9OQEjb
        ZUbdORyhXZn28Q4zUoSKL5VxTbPcnv8oTFKh/mVPt+kNefm8tLbEfEY=
X-Google-Smtp-Source: AGHT+IG+W/T5TeKymvtATZ1GHNxllQKC01DOQi4Q4SMcnuEycQsU5HjjfQBucfegSU4lOxNjd79MQXGybqZbwL/BL1I=
X-Received: by 2002:a1f:ed81:0:b0:48d:1fcd:9760 with SMTP id
 l123-20020a1fed81000000b0048d1fcd9760mr2743978vkh.10.1693580456779; Fri, 01
 Sep 2023 08:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230725073234.55892-10-angelogioacchino.delregno@collabora.com>
 <20230825120109.3132209-1-mwalle@kernel.org> <5b438dba-9b85-4448-bc89-08a11ddb822a@notapiano>
 <fc6c054941420ac2d016496ccbeecad4@kernel.org> <00f65d49-497c-4ade-a2f3-7a5b7ad803b6@notapiano>
 <18bfffdd7ce3bd7693c8362b28651b49@kernel.org> <cce6f9c2-e0b6-47e4-ae1c-9a3d8a4e4b02@notapiano>
 <7a3257dddac78c46408341253a3286f4@kernel.org> <CAGXv+5E4nWSuZdHmRhgYDUG4WhYs5o+-ZQBh3pnd2T_fdf9Edg@mail.gmail.com>
 <d6031e00cda9ea1e30bb75b2ca97300f@kernel.org>
In-Reply-To: <d6031e00cda9ea1e30bb75b2ca97300f@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Sep 2023 23:00:45 +0800
Message-ID: <CAGXv+5H_L+Zg66+nTaVGQ=yqcazMtKqG54eURtcjgA=q0VK2Eg@mail.gmail.com>
Subject: Re: [PATCH v7 09/11] drm/mediatek: dp: Add support for embedded
 DisplayPort aux-bus
To:     Michael Walle <mwalle@kernel.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, angelogioacchino.delregno@collabora.com,
        airlied@gmail.com, amergnat@baylibre.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ehristev@collabora.com,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 6:00=E2=80=AFPM Michael Walle <mwalle@kernel.org> wr=
ote:
>
> Hi,
>
> >> I was just curious if you know of any development for that (or
> >> similar)
> >> in the kernel.
> >
> > This is probably because support for this SoC began with Chromebooks,
> > which have fixed and defined uses for the pipelines. I suspect that
> > what you are working on is much more flexible.
>
> Yes. that is correct.
>
> > The driver should be made to allow dynamic selection of outputs, as
> > is commonly seen with other drivers, but I don't know if that's on
> > anyone's TODO list.
>
> Do you have any pointers where to look at?

There's a series [1] called "Add connector dynamic selection capability".
Not sure if it does what you want though. I haven't looked into it.

ChenYu

[1] https://lore.kernel.org/all/20230809181525.7561-1-jason-jh.lin@mediatek=
.com/
