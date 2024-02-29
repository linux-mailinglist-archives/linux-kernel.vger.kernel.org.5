Return-Path: <linux-kernel+bounces-85993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD7C86BE32
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1197228737C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A77A2D602;
	Thu, 29 Feb 2024 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buonsf7v"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3753611D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169676; cv=none; b=BCT5uT6qky2e6mR6TgBnE+g2hMSXQySDpO5BkUm4QsSZKgl0E1AgKHGCuvAG8SxBht7Pmq6qiSmW09+54Fga1RMzdM5lWZVVuJoVc7XQ9M+h4ysKZCBO9b+JjIo5egEpZAIIIdclp/eXBfs2Tcg1yTyICU5pSW91jkBlmaJdAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169676; c=relaxed/simple;
	bh=cEjYY9kFb7uzbm5TaEqlwralx1PFbTgPhxEn94bcWUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c36pVnO2Ucze+L9mj8KFYhB5i506hXfP3xX9IMQfDqiRtAIijgkbyNQYMEQN1Ey9TAW9D+czK9k51EzKAjXCgVoO6Yr5ISoNDA+PVrn0bL/RYhW+9dF9wRG/xhJfzcBfyS1dMUcJxin4+DB2MZX0HXhQhn2PJJomDHA2sPfc/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=buonsf7v; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc236729a2bso409620276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709169673; x=1709774473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8pWxbY8bTdABWL4CghYjnRxjnKy4WA9CLN4FaXielgY=;
        b=buonsf7v6bEg7h9To5xqL6Wl2jqeg6sWzd3f8qc9wc3tH4jAn9KgbZb/ZJpw7GvqVV
         4rC9edN24m1wEqL9HPGNoeMJ3iSweJwDhipQWoOV9dfK4gmwVoZ8hwPn9WrwnC3iPLwx
         LXhX1mm4kiDb5R9d9ccWFSlEl0nXweyBUsZCnbiqROGgY5/N2lRPDl9uWK8n0XzCSMYS
         BCJNauGJ9YfdPuxG9AhzM6ZjVTj8N4RgittlCBSwFsjcvjRhGdDt2W1kdrO126rt4FPE
         b6yir9MKjL9KcAcydw2ojys4sOBrCR/jvytdfDL+ROKbk+g7Jn0yPttpBNCSJ4s2Virs
         EDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169673; x=1709774473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pWxbY8bTdABWL4CghYjnRxjnKy4WA9CLN4FaXielgY=;
        b=iPbVkNNT6QolK8nmBgqo/Z+AUxhHwFrpC9EpjjQR7zGpp5sEJDrxOjtPb7bgebSD5z
         dRIqqYeGxrfKs7Nb6mI4R8DsZxPUTfKt83yUH65zR2wrvWAh9kKRiXP4MCsMwkZ2q754
         RUQ2WuGIbXSymF0Gp0dUXk4bJtMwGeGKJmGNVDhQfh1L1mnvn8MKVqQ5FX1e5t9O7e0n
         opiCKex8fMXrj5cMitZGZEp6fT5aVQP1CW3Z8mZlOvQbvcQb29jYlS6PPkCiQ4mjYpiY
         WS4u910E8/hTEtWIPxt3PX5QyJmtHms8gRDffMryJrnZkw9IV+uM+ctFcx5kBD2/tRPX
         HkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw8gV0YIoWTshoxooKM4/z2cHr+82YXdXG57nkCxSgdkd2FAqhJ0PPjUhbPgAmaib9cvsNF5cbFPAx/r8H4+kPsQkCO6VwQ9RkpPF7
X-Gm-Message-State: AOJu0YxLCczSc+koy1mtNqUqYb2BNAHcMsHBI9+qvjoD2SYyNyKTMs95
	nEmXkicdAB5ZgFG56ST7lZ6jle0iyCOCcz7ScOxL69KvIsWGucl5rRWnoBrcm70i0F5885mzIfh
	q2wSZN94oOH0XzuPkZly7HXySVA2ZRO6e7Xr2eA==
X-Google-Smtp-Source: AGHT+IHOpAZJPyGmQMjmMhQkQsXaBQmwz48/fjNR7YidqlvDqX1bph2DvMHP8sMPv0l6YYgtKS0uBk4CNLftjmfqwAI=
X-Received: by 2002:a25:9f07:0:b0:dc2:48af:bf17 with SMTP id
 n7-20020a259f07000000b00dc248afbf17mr940987ybq.62.1709169672236; Wed, 28 Feb
 2024 17:21:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-gpio-keys-v2-1-3beb60225abe@quicinc.com>
In-Reply-To: <20240228-gpio-keys-v2-1-3beb60225abe@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Feb 2024 03:21:00 +0200
Message-ID: <CAA8EJppHUYZ46Bz48HzY-D9brBRj+TEw_-6j_VUDyMZPxwf8tQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] arm64: dts: qcom: qcm6490-idp: enable pwrkey
 and volume-up/down function
To: quic_huliu@quicinc.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 11:57, Hui Liu via B4 Relay
<devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>
> From: Hui Liu <quic_huliu@quicinc.com>
>
> Add configurations to enable pwrkey, volume-up and volume-down function.

Please take a look at how similar patches describe the changes. E.g.
commit bb47bfbd5aa8 ("arm64: dts: qcom: sm8550-qrd: enable PMIC Volume
and Power buttons")



>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
> Changes in v2:
> - Update the commit description.
> - Link to v1: https://lore.kernel.org/r/20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index acf145d1d97c..4199ebf667af 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -9,6 +9,7 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>
> +#include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
> @@ -39,6 +40,24 @@ chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               label = "gpio-keys";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&key_vol_up_default>;
> +
> +               key-volume-up {
> +                       label = "volume_up";
> +                       gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
> +                       linux,input-type = <1>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       wakeup-source;
> +                       debounce-interval = <15>;
> +                       linux,can-disable;
> +               };
> +       };
> +
>         reserved-memory {
>                 xbl_mem: xbl@80700000 {
>                         reg = <0x0 0x80700000 0x0 0x100000>;
> @@ -421,6 +440,17 @@ vreg_bob_3p296: bob {
>         };
>  };
>
> +&pm7325_gpios {
> +       key_vol_up_default: key-vol-up-state {
> +               pins = "gpio6";
> +               function = "normal";
> +               input-enable;
> +               bias-pull-up;
> +               power-source = <0>;
> +               qcom,drive-strength = <3>;

Why is this property required? Anyway, it should use the defined name
rather than just numeric value.

> +       };
> +};
> +
>  &pm8350c_pwm {
>         status = "okay";
>
> @@ -448,6 +478,19 @@ led@3 {
>         };
>  };
>
> +&pmk8350_pon {
> +       status = "okay";
> +};
> +
> +&pon_pwrkey {
> +       status = "okay";
> +};
> +
> +&pon_resin {
> +       linux,code = <KEY_VOLUMEDOWN>;
> +       status = "okay";
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
>
> ---
> base-commit: 23e11d0318521e8693459b0e4d23aec614b3b68b
> change-id: 20240206-gpio-keys-138bbd850298
>
> Best regards,
> --
> Hui Liu <quic_huliu@quicinc.com>
>
>


-- 
With best wishes
Dmitry

