Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38E7F9813
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0EAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0EAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:00:17 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C328212D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:00:22 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso41560611fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701057621; x=1701662421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hyXUgZR2V8CGJro2dBZPICRFG2CL4zf1FqusNumER4=;
        b=JuSrSvltC5UQ83aMrnUsOTRSllvtycVDuZMltBoSXu8wmKPRg8PMw/kX+28inwRHV/
         gw3WKQ2ea5igBBfTJsfqUVeN1MgUi2OKEoHxfdYXUqWQMN8A99e/xKiI6vezHJkCAYGE
         TWmwVMS6mzKlJjIiUiv8kFczv6CjN/qaHaJiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701057621; x=1701662421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hyXUgZR2V8CGJro2dBZPICRFG2CL4zf1FqusNumER4=;
        b=YZXVOMVKZWZPnOr4uYXq+c9UJXtmzDCJChsoyI8lu5xKyctAD0TJkE5ppPB6051571
         I5aGC716JMv6c/LKBG2YP1nvXV5cAW7j7iuMvww3ogF0ivtEXZfRVv+OVzlxC+Qn+1Fd
         KUvVmzir/M9ki1g7IerD/LeSow+FJDtF9UlPMHpsuGSw3Buzc4ah2A9x9MDF7zYNloZ6
         gqiOz+vvhVOyaMLJL7o2HmEKjfFPEaE04UsME93MXIoy/6GF14C+jW+WaIvqjU1p4iVD
         at7nIivmSohj+psqtk2kWWGWjqsDe2J92fRVJ0++3A0ut1DuyOdcQKxyf+bMTAz8Em6W
         s9sQ==
X-Gm-Message-State: AOJu0YwanRmFbatdlBH/wnz68q6z+hH/6HXL4rGlkNIl3Tvsye/pGBWx
        nEJhYyfUulLHKScwhdk8c3s5XhXygEkieQ0X7t0zXA==
X-Google-Smtp-Source: AGHT+IGWNLzkTfKJ9/s46JZ8EFnCkfTriGkCE5/WH1eK+5G+zIursvHQuaGd5Lbk44N+a4VuvKKNSbjCULPbRF3Hxbg=
X-Received: by 2002:a19:ac48:0:b0:50a:6fc5:e95c with SMTP id
 r8-20020a19ac48000000b0050a6fc5e95cmr6666053lfc.60.1701057621033; Sun, 26 Nov
 2023 20:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-7-wenst@chromium.org>
 <60beb523-292b-4c77-9030-1bfdfd73c140@collabora.com>
In-Reply-To: <60beb523-292b-4c77-9030-1bfdfd73c140@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 27 Nov 2023 12:00:10 +0800
Message-ID: <CAGXv+5GmjZbzLbxADoNXDiF8dTAwnxva29vuM0FG8vY-6wTJcQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 5:05=E2=80=AFPM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> On 10/13/23 02:02, Chen-Yu Tsai wrote:
> > Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> > Krabby design.
> >
> > Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> > convertible device with touchscreen and stylus.
> >
> > Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> > device. It does not have a touchscreen or stylus.
> >
> > The two devices both have two variants. The difference is a second
> > source touchpad controller that shares the same address as the original=
,
> > but is incompatible.
> >
> > The extra SKU IDs for the Tentacruel devices map to different sensor
> > components attached to the Embedded Controller. These are not visible
> > to the main processor.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile         |    4 +
> >   .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  130 ++
> >   .../mt8186-corsola-tentacool-sku327681.dts    |   49 +
> >   .../mt8186-corsola-tentacool-sku327683.dts    |   26 +
> >   .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
> >   .../mt8186-corsola-tentacruel-sku262148.dts   |   28 +
> >   .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1704 ++++++++++++++++=
+
> >   7 files changed, 1985 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby=
.dtsi
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ool-sku327681.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ool-sku327683.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ruel-sku262144.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ruel-sku262148.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> >

[...]

> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt8186-corsola.dtsi
> > new file mode 100644
> > index 000000000000..42ebab1bafeb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> > @@ -0,0 +1,1704 @@

[...]

>
> Hi Chen-Yu,
>
> These two aud_gpio_tdm empty entries cause this message to be printed:
>
> [   12.949519] mt8186_mt6366_rt1019_rt5682s sound: there is not valid
> maps for state aud_gpio_tdm_off
> [   12.959025] mt8186_mt6366_rt1019_rt5682s sound: there is not valid
> maps for state aud_gpio_tdm_on

I guess we need to teach the sound driver to ignore empty pinmux states?

ChenYu
