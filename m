Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8C7A9A23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjIUSgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjIUSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB220A56
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:14:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so146854066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695320082; x=1695924882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3ymofUjZ6cvdicUv/Ni45W5/10AGo0Wvy6M/7t0Upc=;
        b=TiMxy27c1FgXrou2em/YSTLCvdgrr0pmz16nBmmF3/lAhDVHgAbO40edBDzdYI/Kkz
         PCwvRh7QpE9Pjnef7khPYkGskKSB3zAu8nwthppXPcc9KmFrOU/kNONUn/xQ9gomuQfC
         XZ1JBYPg2BfLtGcuUOQHEUp40oz6KIz0pJ2BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320082; x=1695924882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3ymofUjZ6cvdicUv/Ni45W5/10AGo0Wvy6M/7t0Upc=;
        b=snnvw39YHhbtBu1822mR7IHYIcpKQPNqlg4O3Dp5ANg7Bhm1lgLU/1KB5FyZhnI02I
         +68HSSWTQCy6yhnkqTr6Xb7PjuQB+MRkVQrEWJCC2PuyFvGDEcrkXvvvmplkqMoGyOF+
         j8WjBaQPOsU8JfrsbYSYeENFIsc+xDrCia5UdtZdllvW2qG6hbaVlzf/dG9Cs9iNb+2Z
         bCk5M035imN3Bwl5B3J9IJCMQQlW+vHt8qxkGvSOzIi15z5MSE+RjYSZmVPJnP4dkDH1
         iOHyrECvVro3m83gBh9Mzya7svzB7KBPi16Jx5WNjfAYlRdabtpEe7nZpEbfdNTw9lTn
         e3mg==
X-Gm-Message-State: AOJu0Yzvq0CM9ojizeZKgRZ9h0lFyT6gY3/kSwc0roL2nisEbVC0Hhw6
        cH1zWnQdpj4vdTvc2tgVZ+SnPrbJyA9glGMb4kMykvbw3V8+lZPG6FQ=
X-Google-Smtp-Source: AGHT+IF3ii8PU45QNcqpM+SUljh3J8nnca5RjE0Bdy00FFg9bpSg7BruQWeTpjsLBswRiqH04f9GvW1W1YDy9f62+c0=
X-Received: by 2002:ac2:5288:0:b0:504:3093:1fad with SMTP id
 q8-20020ac25288000000b0050430931fadmr691593lfm.20.1695287357186; Thu, 21 Sep
 2023 02:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230919104357.3971512-1-wenst@chromium.org> <20230919104357.3971512-11-wenst@chromium.org>
 <20230919135539.GR13143@google.com>
In-Reply-To: <20230919135539.GR13143@google.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 21 Sep 2023 17:09:06 +0800
Message-ID: <CAGXv+5G6fYh8wULmERrxbJyXmdDJjthnUEqT+_3nTTTndLf15Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] regulator: mt6358: Add missing regulators for MT6366
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 9:55=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 19 Sep 2023, Chen-Yu Tsai wrote:
>
> > When support for the MT6366 PMIC regulators was added, it was assumed
> > that it had the same functionality as MT6358. In reality there are
> > differences. A few regulators have different ranges, or were renamed
> > and repurposed, or removed altogether.
> >
> > Add the 3 regulators that were missing from the original submission.
> > These are added for completeness. VSRAM_CORE is not used in existing
> > projects. VM18 and VMDDR feed DRAM related consumers, and are not used
> > in-kernel.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Linear range selector values fixed
> >
> > Angelo's reviewed-by was dropped.
> >
> >  drivers/regulator/mt6358-regulator.c       | 20 ++++++++++++++++++++
>
> >  include/linux/mfd/mt6358/registers.h       | 17 +++++++++++++++++
>
> Acked-by: Lee Jones <lee@kernel.org>

Thanks! Could you also take a look at another patch this series is
based on and ack that one?

It's "regulator: mt6358: Add output voltage fine tuning to fixed regulators=
",
with message ID "20230913082919.1631287-3-wenst@chromium.org" [1].


ChenYu

[1] https://lore.kernel.org/linux-arm-kernel/20230913082919.1631287-4-wenst=
@chromium.org/

>
> >  include/linux/regulator/mt6358-regulator.h |  3 +++
> >  3 files changed, 40 insertions(+)
>
> [...]
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
