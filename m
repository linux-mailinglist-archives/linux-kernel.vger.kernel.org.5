Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE0780E02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377722AbjHRO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377753AbjHRO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:27:19 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3E3AA7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:27:17 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44ac5e32ed5so283992137.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692368836; x=1692973636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ly4Wcs7osrmjCxBZpEjsQxdsgjdMwTTrdPeaYghpLw=;
        b=Fpi4DxZtc2PCBYrSLD8oyb1gc5Em9lCcnQ8MbWydVfncTn9FXxvoNfcUkaPPGGPujw
         7MjoLjdQq5myq103RbEAiteglSDxhLuOauPrUq71s8XsPUC5cOEHdsSzOYPbRkFymJvc
         Kjk7w8zRALuEdqvZZkPhODstVMJEN+Q4oMaFQGRrUkROtvVfte64f3nZXr/NY/MJW4kz
         kN1subMQsjcPVZPdyodRn8ICaMLACYwgoSqVzxGHAXD9PybmI1D/C/MV1TtnoppUO6vy
         AH/f01HHnFb10zK4zOr+v0WxS2WHQLzhpuBd61AnYsg+ScmAOVd4MFR4MB7hHpIftfr9
         bT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692368836; x=1692973636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ly4Wcs7osrmjCxBZpEjsQxdsgjdMwTTrdPeaYghpLw=;
        b=fhDCV/R340D7tf0/dJcjODA+QwC6sw/RP8kOpviFhw90j/Yrw0aU1PVuAQV0wlc2S/
         Ko24MSpzS+aNBjVvJvmACy/SQepgpxH0OusRhiz9bk92KOXJcDvfPuyjSEtqSieboRpE
         Irnl272HMI9JGL6tnaQYclGRKqstqos9qULb8uYkpMqZTDffp/7oMADh6aT5baPLtyNH
         JufKo21RiAbp3KIzAyfNgrNvipXnSv2na76A4OzTFBwYhbnUGcAUSa21Q0R10ZONCzd/
         UAV1UHQshXIeqm94z3tOSRnTnnx6qy/2HVJ35WernrerluuBhgv0iH9/dvp+/5XSUgP4
         ZIsA==
X-Gm-Message-State: AOJu0YzdIsa1wlgfJIz1Gxw66CzwWn69C3MVrt775A6ez/VwRkRWjWGa
        N+03qzOljV3IozlnMSc6TDqISPBOqsDbEZG06hGgPg==
X-Google-Smtp-Source: AGHT+IEp3TNPcqcN7SktOZkajFToVLj0HKTk+05IOyulMheJ+t+wwA9+ZQpLEHtHOwzyqR/3bFsosyJyvqp5TTEHfX8=
X-Received: by 2002:a67:bb14:0:b0:443:7ab8:b5d7 with SMTP id
 m20-20020a67bb14000000b004437ab8b5d7mr3009998vsn.14.1692368836506; Fri, 18
 Aug 2023 07:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230818135538.47481-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230818135538.47481-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 18 Aug 2023 16:27:05 +0200
Message-ID: <CAMRc=McJtC9WcCGkrQ5QiDRcAJngp95q2rrq9kzySftJ31W-4A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: correct PMIC GPIO label in gpio-ranges
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 3:56=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There are several PMICs with GPIO nodes and one of the nodes referenced
> other's in gpio-ranges which could result in deferred-probes like:
>
>   qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: can't add gpio chip
>
> Reported-by: Brian Masney <bmasney@redhat.com>
> Closes: https://lore.kernel.org/all/ZN5KIlI+RDu92jsi@brian-x1/
> Fixes: e5a893a7cec5 ("arm64: dts: qcom: sa8775p: add PMIC GPIO controller=
 nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boo=
t/dts/qcom/sa8775p-pmics.dtsi
> index 3c3b6287cd27..eaa43f022a65 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -173,7 +173,7 @@ pmm8654au_1_gpios: gpio@8800 {
>                         compatible =3D "qcom,pmm8654au-gpio", "qcom,spmi-=
gpio";
>                         reg =3D <0x8800>;
>                         gpio-controller;
> -                       gpio-ranges =3D <&pmm8654au_2_gpios 0 0 12>;
> +                       gpio-ranges =3D <&pmm8654au_1_gpios 0 0 12>;
>                         #gpio-cells =3D <2>;
>                         interrupt-controller;
>                         #interrupt-cells =3D <2>;
> --
> 2.34.1
>

My bad, must have been a bad copy-and-paste.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
