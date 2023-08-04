Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92A770603
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHDQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHDQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:30:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65D195
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:30:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so3976571e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691166632; x=1691771432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fb6BXc3V7vZl1BO3VO9rbNSiYgEtub9HXOe7U0lqXXA=;
        b=DOkOeApEhP9cQxwrIfIcpIWdWPKIF2osAWkSyszrDxr+BenYfT9IY+eBlgvqGnOl0G
         /YKsnYDrRXXMN1I+44XJACKGvVshNWMkKXXysH9aFoL7TCpC18n85EdnnbYcrUghO2hs
         ML77MSemNNc2MQI/yXiyfXzictuo9u+Zpi/jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166632; x=1691771432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb6BXc3V7vZl1BO3VO9rbNSiYgEtub9HXOe7U0lqXXA=;
        b=WVXheNaLbc9TAMjR650ew9xg780q8Ow/G+6GGONATliNWpGtMLYLX6HbH1kvPVV88+
         NY2G2SczJlM4zethCPyY82fbDscu5m4ZJYaAqXhFfXMoZifoZkJypXDA4/0IJhmZdlvR
         10TYLEH/AYY16JAFgeKTCm/asEvJkRhyDemkTlfS2yFheQD8JPE1DswMhQYj4giVp7QI
         EPO4rASYs/oCPhYdkm0lPhiYNeJ1N1X+OO68yGnnr3Ydeav3V7CMPomMXQJO+bRTVENb
         O9U3jGqgj9yHEn43zd6GXGQ+HlMO1cCbtjQG49dMyug8giUmRZ4mpK+j53Meu1KE7XfB
         1tSw==
X-Gm-Message-State: AOJu0Yzvp5t4CYyIN5gODd9HZD7gT/8OHpYgxFrdDF9aa/1ua3p7mPs3
        Mjmu2XfJRfA5iwn76RFNm1ukszok+eyElbNVwhEk7ocA
X-Google-Smtp-Source: AGHT+IFvaZ2l11t403N1AVcG2+2nK3YUE4JjGyWOiCSwaFTXf/C1dxJkfvVtvCzIozxgg5grK8FGTA==
X-Received: by 2002:a2e:80da:0:b0:2b9:cf90:ab9c with SMTP id r26-20020a2e80da000000b002b9cf90ab9cmr1970358ljg.8.1691166631920;
        Fri, 04 Aug 2023 09:30:31 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id bv26-20020a170906b1da00b009926928d486sm1521871ejb.35.2023.08.04.09.30.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 09:30:30 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5229e0603edso11549a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:30:30 -0700 (PDT)
X-Received: by 2002:a50:9e4c:0:b0:519:7d2:e256 with SMTP id
 z70-20020a509e4c000000b0051907d2e256mr2692ede.0.1691166629720; Fri, 04 Aug
 2023 09:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
In-Reply-To: <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Aug 2023 09:30:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzTY0XKb-hXLprT3OUrpaoNKiCqABgWyY_kXrZMD9H_A@mail.gmail.com>
Message-ID: <CAD=FV=UzTY0XKb-hXLprT3OUrpaoNKiCqABgWyY_kXrZMD9H_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Add board id for lazor/limozeen
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 4, 2023 at 2:58=E2=80=AFAM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Lazor Limozeen board device tree source
> + *
> + * Copyright 2023 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180-trogdor.dtsi"
> +#include "sc7180-trogdor-parade-ps8640.dtsi"
> +#include "sc7180-trogdor-lazor.dtsi"
> +#include "sc7180-trogdor-lte-sku.dtsi"
> +
> +/ {
> +       model =3D "Google Lazor Limozeen without Touchscreen (rev10+)";
> +       compatible =3D "google,lazor-sku6", "google,lazor-sku18", "qcom,s=
c7180";
> +};
> +
> +/delete-node/&ap_ts;
> +
> +&panel {
> +       compatible =3D "edp-panel";
> +};
> +
> +&sdhc_2 {
> +       status =3D "okay";
> +};
> +
> +&alc5682 {
> +       compatible =3D "realtek,rt5682s";
> +       /delete-property/ VBAT-supply;
> +       realtek,dmic1-clk-pin =3D <2>;
> +       realtek,dmic-clk-rate-hz =3D <2048000>;
> +};
> +
> +&sound {
> +       compatible =3D "google,sc7180-trogdor";
> +       model =3D "sc7180-rt5682s-max98357a-1mic";
> +};

The sort ordering of the nodes above is still wrong. It should be
alphabetical. AKA "alc5682", "panel", "sdhc_2", "sound".

Once that's fixed, feel free to include:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
