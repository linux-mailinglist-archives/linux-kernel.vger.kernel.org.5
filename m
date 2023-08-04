Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539076F87E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjHDDt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHDDtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:49:55 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575E3A90
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:49:54 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48642554ef1so619167e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 20:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691120993; x=1691725793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVSXp7pt1ynfIFYVxUfKRmE0SvUQ9GE4LWveQ3EWr04=;
        b=kuZVbEqhHTsnlhU4yOn7K+V0x//RYjK4AwrNZf3Pi5jTwku1adyhSoQ6KkKQ+LLqDh
         Qa+Vf7E/P3XbgbKMEG3wnNn0cu1Nh1j+fzr7YFAmPi4NyCBd2T41h2s5+r822Dk25Dbd
         sLCHjo4nM1pZUy5NDn8ET+YoCmMJsWoQNUWWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691120993; x=1691725793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVSXp7pt1ynfIFYVxUfKRmE0SvUQ9GE4LWveQ3EWr04=;
        b=LU+ChAdmKZq6UgNS7Ax214AkHXUo3JQs5tuUOWek0fP1tLt9kDQe2bZWWmdpJsisap
         VYmJxKNUbYsLEYnXxD8NRrchZqqxQ3XDVMu3RZwfyfHfziubrbgtRrCVu/v4j7AOSvPb
         dO2QRDXC//PJLy0o/zE0ZGIPDf8b5X8GbSsV9DbJo2F9LCYfW7d+bHMB8DPtcT8IBps9
         I3NjosLleKUuAJcWX5R1qXXR0T7xJpxnfDu/awKiwKbMZ0AMTy8APZKrm3+DmBKM+yWb
         sY9dekCzUGKtERRBDqozkRpFjmZrtNf5fBuXThvUm0q7xVOf7qnkGHP3vcO2+4ZXrKLn
         W6zw==
X-Gm-Message-State: AOJu0YwQWs2SMQqDE2CxZpv4D9e3BE53G9qS2/9XILWQXvcwT25UFgMP
        VdODS8Bg38zv/U9H6hgOxQ0Vlo5lQiwgtcsODLoEIQ==
X-Google-Smtp-Source: AGHT+IHYBwhOGTrCuCN8IOCqvpmaj2FCreDh6icca0SFM57jjcqreajpJTjlRkJ6xgR7wTok6XJeu9AaAfRKP49caHs=
X-Received: by 2002:a1f:e081:0:b0:486:556c:a0bb with SMTP id
 x123-20020a1fe081000000b00486556ca0bbmr269439vkg.9.1691120993526; Thu, 03 Aug
 2023 20:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230803074249.3065586-1-wenst@chromium.org> <20230803074249.3065586-10-wenst@chromium.org>
 <e9c38029-f27d-7800-2ba8-d9ee19d999e4@collabora.com>
In-Reply-To: <e9c38029-f27d-7800-2ba8-d9ee19d999e4@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 4 Aug 2023 11:49:42 +0800
Message-ID: <CAGXv+5G+kLNaj3F1NG+Y2zQuc7Xv_wczHeFUEUNGo8ZdVWYM1w@mail.gmail.com>
Subject: Re: [PATCH 9/9] soc: mediatek: pwrap: add support for MT6366 PMIC
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 5:01=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 03/08/23 09:42, Chen-Yu Tsai ha scritto:
> > The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It ha=
s
> > a different set of regulators. Specifically, it lacks the camera relate=
d
> > VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.
> >
> > Add a separate compatible for the MT6366 PMIC.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> We can express the same partial-compatibility state with bindings, adding=
 a
> new compatible here with the same platform data doesn't really add any va=
lue...
>
> ...also because in DT we'll have something like
>         compatible =3D "mediatek,mt6366", "mediatek,mt6358";
>
> so if any variation of platform data in mtk-pmic-wrap will ever be needed=
, we
> would still be able to do that in the future without any headache.
>
> In my opinion, this commit can be dropped.

As mentioned in my reply to the mfd patch, this might not be doable. There
are limitations on both the DT bindings and mfd driver sides.

ChenYu

> P.S.: We could add a comment in the mt6366.dtsi pmic devicetree for that,=
 too?
>
> Cheers,
> Angelo
>
> > ---
> >   drivers/soc/mediatek/mtk-pmic-wrap.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediate=
k/mtk-pmic-wrap.c
> > index 11095b8de71a..e3c0e767033b 100644
> > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > @@ -2257,6 +2257,8 @@ static const struct of_device_id of_slave_match_t=
bl[] =3D {
> >       { .compatible =3D "mediatek,mt6357", .data =3D &pmic_mt6357 },
> >       { .compatible =3D "mediatek,mt6358", .data =3D &pmic_mt6358 },
> >       { .compatible =3D "mediatek,mt6359", .data =3D &pmic_mt6359 },
> > +     /* MT6366 is mostly compatible with MT6358, except for slightly d=
ifferent regulators. */
> > +     { .compatible =3D "mediatek,mt6366", .data =3D &pmic_mt6358 },
> >
> >       /* The MT6380 PMIC only implements a regulator, so we bind it
> >        * directly instead of using a MFD.
>
>
