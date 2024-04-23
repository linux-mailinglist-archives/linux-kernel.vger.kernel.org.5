Return-Path: <linux-kernel+bounces-155615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A038AF4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C492846D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12513DDBA;
	Tue, 23 Apr 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwp0Q4mf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A285298;
	Tue, 23 Apr 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891769; cv=none; b=rdvH8xZ1AnEwGEr0JTh79hqbFeJNeKIdsJppa6dSjDmjNWRlUC9Fgv8/5hnGtEWN3oK4fg1DYzv48l/jcIcyeiuVhvrTFq02JnE2arSJda5Dc3Z9oDaSCjI9/rtA3hefcbfI/zqf8RFtmAMo9GU+hcMFTbeY0y8htXNu6mVHvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891769; c=relaxed/simple;
	bh=m466dLvNB0J/uZky3+7Cr0D0JS90YH5KfreDtY0WtCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6KaJcc8lxSIYDGqI8CdztIJmSiGHl7pClrfAOq96cuCodPyKdgs6+R7LlpmzPzicHoGMJSmA0zxqJSKxPXHzay6j3DceG5Nw8ATo013aMwh0XI+LmfAFz2eIAOaAZkDILj1IWXna/D1J7ol4oCC6sXOpVMtAiBnanP8r8DTvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwp0Q4mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88FAC116B1;
	Tue, 23 Apr 2024 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713891768;
	bh=m466dLvNB0J/uZky3+7Cr0D0JS90YH5KfreDtY0WtCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uwp0Q4mfSETIxa9OxjK3u8WnepsDNQvoZbPWMdrGbW3C7w21NNxl1qRoRwHNISOne
	 5pATbefczTl/liC1rygFYOPquXadURSEebV9ijNkUiuWz1QP65u7gBYIl9WHotkC+K
	 uCaYgHBm/FIMakELMGRYR59O2XaS+m5AFl5h7hc61lb4jQNxzPERhAJ/zrbg3kUdS4
	 OOXOHYcevRra4wJC4Lb64tK7BqVfFQl5C6sfWJobMgNrlEhtwq+UhojnbX4LYz7Sc/
	 2TRqCHfEumFSy3DRdWSGY9gVGkZfzeXGlgOM3+THhjr5eulcXZRAZa8Oem0GC1Xao/
	 fK/xjWqveLQNg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so53227e87.0;
        Tue, 23 Apr 2024 10:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTnpXnjgdT7pcdWkfnblln508x1csgZNhttI3WztFFG9VF6T/6ZV9rZ/k507kaZrYnYy7/U2LKCxI6wIhelgX4eG5ioK2oyYXp7XwHbmsd5KJirmpyntU8y21Yg/1IzG7y+yh+I9s3PbPQPfmEHLZ5ggoX3dciNSkKr32w4T6nNuixy7T0E4j3P/6JcMMVplMXrlNnKox/TYC9qyI38JXWeN7I
X-Gm-Message-State: AOJu0YwjcIvRg9LTBccsL/oG23YCuzkICqzgFSHRlO/su3l4hM8RkN07
	UTkySLWwoLu02o9G3PTm6ZOWtBJWq1Tvo7fxVjIJ8Xc17r6wpbi0g9xL4mx+bgtIY64cVR9DOCH
	9vWeo35UG/94EUMdsoQoW7oOoyA==
X-Google-Smtp-Source: AGHT+IGVgsWU2NH32RQwD8Bf2g9mUv7U7WYuzYFHvrHKWCMJy9A+v9NRW7oUYUBxGn5HV5Q+/Hbch3rapFRcttQIUl0=
X-Received: by 2002:a19:910a:0:b0:513:dcd2:1267 with SMTP id
 t10-20020a19910a000000b00513dcd21267mr954795lfd.23.1713891767189; Tue, 23 Apr
 2024 10:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326220628.2392802-1-quic_amelende@quicinc.com> <20240326220628.2392802-3-quic_amelende@quicinc.com>
In-Reply-To: <20240326220628.2392802-3-quic_amelende@quicinc.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 23 Apr 2024 12:02:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZkU_74JK-BGOe83-redCi_TcV3dOOZs9DX3jThHfXrw@mail.gmail.com>
Message-ID: <CAL_JsqLZkU_74JK-BGOe83-redCi_TcV3dOOZs9DX3jThHfXrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108
 and PMD8028 support
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, linus.walleij@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com, 
	quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 5:07=E2=80=AFPM Anjelique Melendez
<quic_amelende@quicinc.com> wrote:
>
> Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
> to include compatible strings for PMIH0108 and PMD8028 PMICs.

You didn't test this with dtbs_check:

     47  gpio@c000: gpio-line-names: ['AP_SUSPEND', '', '', '', '',
'', '', '', '', '', '', ''] is too short
     10  gpio@8800: gpio-line-names: ['FLASH_STROBE_1', 'AP_SUSPEND',
'PM8008_1_RST_N', '', '', '', 'PMIC_EDP_BL_EN', 'PMIC_EDP_BL_PWM', '']
is too short

>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yam=
l b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> index 2b17d244f051..a786357ed1af 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> @@ -57,10 +57,12 @@ properties:
>            - qcom,pma8084-gpio
>            - qcom,pmc8180-gpio
>            - qcom,pmc8180c-gpio
> +          - qcom,pmd8028-gpio
>            - qcom,pmi632-gpio
>            - qcom,pmi8950-gpio
>            - qcom,pmi8994-gpio
>            - qcom,pmi8998-gpio
> +          - qcom,pmih0108-gpio
>            - qcom,pmk8350-gpio
>            - qcom,pmk8550-gpio
>            - qcom,pmm8155au-gpio
> @@ -143,6 +145,7 @@ allOf:
>                - qcom,pm8005-gpio
>                - qcom,pm8450-gpio
>                - qcom,pm8916-gpio
> +              - qcom,pmd8028-gpio
>                - qcom,pmk8350-gpio
>                - qcom,pmr735a-gpio
>                - qcom,pmr735b-gpio
> @@ -304,6 +307,21 @@ allOf:
>            minItems: 1
>            maxItems: 7
>
> +  - if:
> +      properties:
> +        comptaible:

It took me a bit to find, but you've got a typo here. The result is
this "if" schema is always true unless you actually have an instance
with the typo too. Please send a fix.

> +          contains:
> +            enum:
> +              - qcom,pmih0108-gpio
> +    then:
> +      properties:
> +        gpio-line-names:
> +          minItems: 18
> +          maxItems: 18
> +        gpio-reserved-ranges:
> +          minItems: 1
> +          maxItems: 9

