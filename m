Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8796D7F980D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjK0D4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0D4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:56:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFEA12D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:56:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507c5249d55so5758118e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701057397; x=1701662197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdQ/Y6CJ/tXJPIZwoVwtxZbsYvh8pLzEZAF/c5I9cSM=;
        b=Ss7Z75Iu8nS3R3dp9wf+Z4+DWB7pM3CP7CKOxkm7U7dVfISOSzDtHhfPUjIrJ+q+mF
         zKKaqm7Z2nncDL/Lc1+dYYBWmeHapyCLgpvY+uI144fQHvwVsU1YJxdmloS6Iw1b5AoI
         olBF6MT1csIEiELI+M6vlnYf1CR+Dgctr3WWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701057397; x=1701662197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdQ/Y6CJ/tXJPIZwoVwtxZbsYvh8pLzEZAF/c5I9cSM=;
        b=VQblS3o0cRXrwovp0wyVaJpGeIdKD/DGQmuWeDGO3EPD3xq3xRhB3SCSFwrdtpwCdK
         NCSoaoN45TZwuPiAi+9/+AL8La+hilKxaU5RFyN0dC6aWunR4kaEIkahSb82y6AcsWoO
         NUj/I6EL+1fYsnYHjIBsYviypwtKROXg9adEZSHygdcgqa9LhBsHcP2Ggf6yjrxWFRkL
         /HjBMC937imCgaaSrjThdM460uW2/RPGOpUqUUX7CcKvfNvo2NfY6g4oCmyQHHv3Bshr
         AEWxJmSYEgoYJHpRIqGrk83JLPL0dqYTr+hB1YZa12wiqVY7cowVk4lLpTD201VcuR13
         CfVg==
X-Gm-Message-State: AOJu0Yyib5dNJrCJG/OgM8g642r++N1GKSwU4UgJQGOvoShmrCD7Mj2U
        BGjkFH1sdtFBAObG61kFH/m26od72af+ZZdkqR5jPA==
X-Google-Smtp-Source: AGHT+IH2iG08bIzEYYLAosPnZIOh4c7YPh9mfzAUPfhoifHONl5nCDKLKbiU6DKmkAdHGe0GNyiN+vKEshOsCkQVOrw=
X-Received: by 2002:a05:6512:3d94:b0:507:9a66:3577 with SMTP id
 k20-20020a0565123d9400b005079a663577mr4725984lfv.5.1701057397494; Sun, 26 Nov
 2023 19:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-8-wenst@chromium.org>
 <bbc99c85-750e-4736-9320-cf9471fe4c92@collabora.com>
In-Reply-To: <bbc99c85-750e-4736-9320-cf9471fe4c92@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 27 Nov 2023 11:56:26 +0800
Message-ID: <CAGXv+5EiopM2wdccvh5_p9+67DAZnCpEhLeXUfm=3ih2hFZU3g@mail.gmail.com>
Subject: Re: [PATCH 7/9] arm64: dts: mediatek: Introduce MT8186 Steelix
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 4:36=E2=80=AFPM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> On 10/13/23 02:02, Chen-Yu Tsai wrote:
> > The MT8186 Steelix, also known as the Lenovo 300e Yoga Chromebook Gen 4=
,
> > is a convertible device based on a common design of the same name. The
> > device comes in different variants. Of them, whether a world facing
> > camera is integrated is the only differentiating factor between the
> > two device trees added. The different SKU IDs describe this alone.
> >
> > The other device difference is the touchpad component used. This is
> > simply handled by having both possible components described in the
> > device tree, and letting the implementation figure out which one is
> > actually available. The system bootloader / firmware does not
> > differentiate this in that they share the same SKU IDs.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
> >   .../mt8186-corsola-steelix-sku131072.dts      |  18 ++
> >   .../mt8186-corsola-steelix-sku131073.dts      |  18 ++
> >   .../dts/mediatek/mt8186-corsola-steelix.dtsi  | 197 +++++++++++++++++=
+
> >   4 files changed, 235 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steeli=
x-sku131072.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steeli=
x-sku131073.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steeli=
x.dtsi
> >

[...]

> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi b=
/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
> > new file mode 100644
> > index 000000000000..8488f2f9dc4d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
> > @@ -0,0 +1,197 @@

[...]

> > +&i2c2 {
> > +     i2c-scl-internal-delay-ns =3D <22000>;
> > +
> > +     /* second source component */
> > +     touchpad@2c {
> > +             compatible =3D "hid-over-i2c";
> > +             reg =3D <0x2c>;
> > +             hid-descr-addr =3D <0x20>;
> > +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&trackpad_pin>;
> > +             vdd-supply =3D <&pp3300_s3>;
> > +             wakeup-source;
> > +     };
>
> Hi Chen-Yu,
>
> This is not okay, the `trackpad_pin` is shared with touchpad@15 , and if
> drivers are probed in parallel , this can lead to a conflict on this pin
> (GPIO11)

You're right. I've moved it under i2c2 for now, as we do for other platform=
s
with second source components.

This should hopefully be cleaned up once we have a hardware prober.

ChenYu
