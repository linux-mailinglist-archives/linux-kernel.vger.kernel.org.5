Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A477D367
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbjHOTc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbjHOTcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:32:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60B10FF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:32:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-523bf06f7f8so6028109a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692127949; x=1692732749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QUc0x0pjPpKWnmgAca1QOq5TW3L4ejfm50N+84Kmuc=;
        b=Rc4t/cyDu8Ic5J4iJ9ZsNBB62qcAxdOJVy9Ee86pehyaeAs0Suqmv9EQX/WgQ4X7v/
         7vVDh2H7MT+q8/wZFM6Bwvpo7G5dvUrHj76IvIoh29ISgu2tl4RQpoMFcbCkD65VrOcQ
         CnKpxVAUGCs8IeuVEkQdupwLaAg7eiExbfGx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692127949; x=1692732749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QUc0x0pjPpKWnmgAca1QOq5TW3L4ejfm50N+84Kmuc=;
        b=Q310CpME95H7CXpG6a6yl/QAGFjmYUv0HqXlFL5deOO0sRGSu4cz1ee0hS2Rqb6nKg
         ySmUPzfTAZkN1+5hrXQrgpdEe2YfEFC/xQhBhtA027tzxSv6w+1tS0HPahFuujtsM8/O
         jtakRfAxe0CptBVnRCy8vrJ3nxH/kxYtlAxGSQzNIXuYyPfVwzZMUafix+iT8sPleZx4
         xrJ4A1qY6Pl+5ONJ69TUy1QSRnGZOVZ+U0ludbXtJyumJ9+k+xXBxbn401YRsd6tTkg9
         oEtK62afHKe5KpVtaiJIMUDffwHAG2FRUQOvEEgCZZlIxTADFH1xkTpIbKRCJjp0Qbb3
         cQRQ==
X-Gm-Message-State: AOJu0YywQ0fMiQ3Q7LUfV417MBQmQtBU8khkGLwxr6G/sjjLVEKqV4pX
        5vlQbZPDgwNvgb7FgQcza1tpGfdrf6ucCsVhM2APKQ==
X-Google-Smtp-Source: AGHT+IHPucw9BLeOE5mj/ClCI9VuWtAQthZ4Yc/K3L9UQWnCrYh0dHeZpxUbJwm1u175jLtyW4lvjQ==
X-Received: by 2002:a17:906:7696:b0:99c:3b4:940f with SMTP id o22-20020a170906769600b0099c03b4940fmr11823392ejm.27.1692127948869;
        Tue, 15 Aug 2023 12:32:28 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709062dc800b0099b7276235esm7473497eji.93.2023.08.15.12.32.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 12:32:27 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so21895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:32:27 -0700 (PDT)
X-Received: by 2002:a05:600c:35c7:b0:3fd:e15:41e3 with SMTP id
 r7-20020a05600c35c700b003fd0e1541e3mr24772wmq.2.1692127947638; Tue, 15 Aug
 2023 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230815154412.713846-1-hsinyi@chromium.org> <20230815154412.713846-5-hsinyi@chromium.org>
In-Reply-To: <20230815154412.713846-5-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Aug 2023 12:32:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UvDZOgJ0TxeBYGgDMqSUYUX9am+QAMEXpRQ0C-Hh=kVw@mail.gmail.com>
Message-ID: <CAD=FV=UvDZOgJ0TxeBYGgDMqSUYUX9am+QAMEXpRQ0C-Hh=kVw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7180: disable quad mode for spi nor
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, Aug 15, 2023 at 8:45=E2=80=AFAM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Some of the SKUs are using gigadevice gd25lq64c flash chip. The chip
> default enables quad mode, which results in the write protect pin set to
> IO pin. In trogdor platforms, we won't use quad enable for all SKUs, so
> apply the property to disable spi nor's quad mode.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/bo=
ot/dts/qcom/sc7180-trogdor.dtsi
> index 5a33e16a8b677..0806ce8e86bea 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -436,6 +436,7 @@ flash@0 {
>                 spi-max-frequency =3D <37500000>;
>                 spi-tx-bus-width =3D <2>;
>                 spi-rx-bus-width =3D <2>;
> +               disable-quad-mode;

This seems unnecessary. Unless "tx-bus-width" or "rx-bus-width" is 4
then Quad SPI isn't enabled. You don't need an explicit property since
this can just be inferred from the tx and rx bus width.

-Doug
