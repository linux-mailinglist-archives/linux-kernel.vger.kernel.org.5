Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F158279E290
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbjIMItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjIMItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:49:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17000196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:49:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502934c88b7so10662226e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694594986; x=1695199786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6OWBjAU1cxgbQTAWQU05/QpiwZ7u1WWxVUcWDMnlOc=;
        b=Y/GjTeBzhUUXf6ng/8VdFF6+XjCkqWeWjWk4/sQoR7RbMAre9aSgwXRei1dD26wBNK
         oZcobKWGD0dPwRSPBw4LWSyGVtcoSCqVn1ORQhkZ65mk0BUr8HndosUbIiyuJh7b7mqm
         QnWXqAMyGZAbokgLZBH2BtVYVaUY9BUePpJ+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594986; x=1695199786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6OWBjAU1cxgbQTAWQU05/QpiwZ7u1WWxVUcWDMnlOc=;
        b=WP2Dw50V1CJiv0eqb+lI6P4+Tert4VR979sgm/yRCKrfHkdmbne80SG5t1baP5rFsx
         dgk8R4UVvJRXkzQsA8UlzZswh1VW/F2TDl0vPjhxAwo/YS7DSGrpXJsI3PSdJK+XflAG
         +fdsWLQJU3R2EVtzRc1UidIzi4DycJdZ4zwJ/I3guSXm0uuarBNzgYEYCprbQxrwRGH0
         I4heSNZeMrg4eu4RuSbyIPlUaDG8dmHfKKI/nD42T/1OFaSJEtPoarwqxmyT8JN4t/LO
         IWOiGh857O+EAU0/iWRkvf+zCLGRB+m168giqL0t+NoAKMf+0j2c18iVLscuZqh5/umh
         Iz+Q==
X-Gm-Message-State: AOJu0YynYxQ7Q4GdDC0zFqqGxqqVD4/m6UjVcGBqfJ5e2SlJlVlz5By3
        yLTkYCfmlOx+BS9JX3er1XlZKADHJR8z4zk1Qe/LlQ==
X-Google-Smtp-Source: AGHT+IF326eu3RL07fH01eFNOizyYWT0naK68BbkFy0V0EwYECudUIkcOek+Rh5jKTj4V8DX9iBXAl4EHd5E1HbBXZE=
X-Received: by 2002:a05:6512:32aa:b0:500:94c3:8e3b with SMTP id
 q10-20020a05651232aa00b0050094c38e3bmr1304740lfe.57.1694594986120; Wed, 13
 Sep 2023 01:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230804225813.12493-1-robh@kernel.org> <f8759d51-f808-8082-ceaf-6c6dcaebe2d9@collabora.com>
 <4c99c180-3b79-6aef-6ff2-d430e575957d@baylibre.com>
In-Reply-To: <4c99c180-3b79-6aef-6ff2-d430e575957d@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 13 Sep 2023 16:49:34 +0800
Message-ID: <CAGXv+5FWhEab_wHs9+Q3begEBXCVrE4fK1S3sntDuRRE9iGFpg@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: dts: mediatek: Fix "status" values
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>, soc@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 9:10=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:
>
>
>
> On 12/09/2023 14:54, AngeloGioacchino Del Regno wrote:
> > Il 05/08/23 00:58, Rob Herring ha scritto:
> >> The defined value for "status" is "disabled", not "disable".
> >>
> >> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> >> Reviewed-by: AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >> Arnd, Please take this directly I guess. I think Mediatek maintainersh=
ip
> >> needs some help. Maybe AngeloGioacchino should be co-maintainer as
> >> that's the only response I seem to be getting.
> >
> > Sorry but I've seen this message just now as I've been on holiday in
> > August.
> >
> > Thing is, the MediaTek scene is starting to see more and more code,
> > bringing
> > an obvious increase in the amount of reviews to be done and in the requ=
ired
> > efforts to maintain the MTK bits - and we will possibly (hopefully) see
> > even
> > more of that.
> >
> > If Matthias needs/wants a co-maintainer for MediaTek I'm here and I wil=
l be
> > proud to become one.
> >
> > Cheers,
> > Angelo
> >
>
> I started reviewing MediaTek patches for some months now, so I'm still
> new. From my PoV, I'm agree with Angelo when he say the amount of patch
> is increasing. I support Angelo if he wants to become a co-maintainer
> and continue to do my best to review patches. ;)

I might not have enough time to do a lot of reviews, but if help is needed
for administrative tasks like queueing patches and sending pull requests,
that's something I can do.

ChenYu

> >>
> >> I think for future .dts patches I will not bother splitting them up by
> >> sub-arch because it's a pain to chase down the maintainers to apply
> >> stuff in a timely manner. /rant
> >>
> >>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> >> b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> >> index e4605d23fdc8..86cedb0bf1a9 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> >> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> >> @@ -585,11 +585,11 @@ &pwrap {
> >>   };
> >>   &sata {
> >> -    status =3D "disable";
> >> +    status =3D "disabled";
> >>   };
> >>   &sata_phy {
> >> -    status =3D "disable";
> >> +    status =3D "disabled";
> >>   };
> >>   &spi0 {
> >
> >
>
> --
> Regards,
> Alexandre
>
