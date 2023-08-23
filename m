Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74378550D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjHWKNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjHWISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:18:30 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0019A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:14:08 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44d3db0f56cso1353787137.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692778448; x=1693383248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BqnoaQrc+k/EGaIhjvlmrLzZhJHDQjGpktA3aeLEYU=;
        b=Lxd1xBz4QhTQBil+19Nth+mmfytAAWGErXLm7pP3QMD3JbyPH3q26Ux4lJypdghqNH
         wpPkhIsgoio8g/OPXqHrBJrUgkHCPJiS2PZTvqcPEKcG5hWADioTJakWZiBDgoI1VfSn
         pHP+eXlPlWLoG3z4MfdhtQYtGBI4nflQCHOjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778448; x=1693383248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BqnoaQrc+k/EGaIhjvlmrLzZhJHDQjGpktA3aeLEYU=;
        b=Pu0KrEAKkvu2Y/s1DOuqqV59zYLbwmmORJSWwKVxFo9aNJTN4asktv/PyPlt0WtlPM
         EMiZzECx29udENz0rGIQebmhjHlks8phSAhw37nXnw4e2lhrU/I5KL/CCHdLUjfy28bo
         9yPOKHxjoHr8B89S2TVp8pI/JyvAKbEYbNqVfUIOmKU6j+y53XMHPWLsKd974+VGsPk/
         eDM3+2g9WEBSB30i0WtWp8TlGZEwgaEnp+nWhkLoffUMReT9fEd6TErnic8ByWhDzqTb
         r6Os+smAmb+ke2X8a+z/NF0phCHNdmUhMCTX5S5HUKS4JAQXjC+jUckS80LMPa7YuPKE
         3Kow==
X-Gm-Message-State: AOJu0YyoHqxMMwbdBVomtWOfpWqy7UudM/zmu4SNsToMHDffJ39Jx9y8
        TaV1mBI/H5t3Xzo9NyqWDOnMEmQZZ9F4IxX6qNfhtg==
X-Google-Smtp-Source: AGHT+IH4+6ztIqeKvjoE4Y07evhyiEKAgLnuWl8fEl2206g85MjP70+R3xLs9H41CAsIZm89sGQsPoMer8AWCZBvYeQ=
X-Received: by 2002:a05:6102:18c:b0:44d:3ba7:b617 with SMTP id
 r12-20020a056102018c00b0044d3ba7b617mr7906256vsq.32.1692778447964; Wed, 23
 Aug 2023 01:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230822084520.564937-1-wenst@chromium.org> <20230822084520.564937-4-wenst@chromium.org>
 <5ad5ff92-1367-ba96-b126-da80511a2769@linaro.org> <CAGXv+5Gc+R-hUJi5gm8an+dkq3JMD2JGwP4kDakKaHbAX2P0gQ@mail.gmail.com>
 <e1c69599-a894-4cc8-123b-f4654b08412d@linaro.org>
In-Reply-To: <e1c69599-a894-4cc8-123b-f4654b08412d@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 23 Aug 2023 16:13:57 +0800
Message-ID: <CAGXv+5GL+Ltn-X-Hzxj7Wz_ztPVkCfo=WV6XdXGw_-j6ZhCF6w@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] regulator: dt-bindings: mt6358: Convert to DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 1:48=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/08/2023 05:54, Chen-Yu Tsai wrote:
> >>> +
> >>> +    regulator {
> >>> +        compatible =3D "mediatek,mt6358-regulator";
> >>> +
> >>> +        buck_vgpu {
> >>> +            regulator-name =3D "vgpu";
> >>> +            regulator-min-microvolt =3D <625000>;
> >>> +            regulator-max-microvolt =3D <900000>;
> >>> +            regulator-ramp-delay =3D <6250>;
> >>> +            regulator-enable-ramp-delay =3D <200>;
> >>> +            regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
> >>
> >> mt6397?
> >>
> >> Both cases look a bit confusing.
> >
> > There's only two regulator binding header files, mt6397 and mt6360.
> > They seem to correspond to the two classes of PMICs that MediaTek has.
> > I believe the two header files and thus the macros are meant to be
> > shared?
>
> Defines have specific model name, so they do not look like meant to be
> shared. If all the values of the binding match, they can be shared, but
> then this should be mentioned in the binding plus it should be used in
> the driver. I don't see your driver patches add include of this header.

Indeed. AFAICT the original raw values 0 and 1 just map directly to the
register bitfield values. And those are common across the series of PMICs.
I'll look into cleaning it up.

ChenYu

> > MT6397 and co refer to their AP PMICs, i.e. PMICs that are companion
> > chips to the SoC and provide most of the power rails a system needs,
> > along with things like RTC, audio codecs, etc.. The MT6358 and MT6366
> > belong to this class.
> >
> > MT6360 and possibly others refer to their charger PMICs, which integrat=
e
> > a battery charger, USB type-C PD stuff, LED drivers, and a handful of
> > regulators.
>
>
> Best regards,
> Krzysztof
>
