Return-Path: <linux-kernel+bounces-23250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B83682A9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478D11C222A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90603FC01;
	Thu, 11 Jan 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Ww8auN30"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20132D52E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a2c375d2430so70334566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704963282; x=1705568082; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fdzAkRigLOJSs0p8z2FKeIqZxw3OTVE9TPYi8cJXf8=;
        b=Ww8auN30yMp8d0qUl6xxGNzHMHoKPxbrXBAHPgfcT16BZLssWZDTRx7lwa/iKPPl5g
         DCTP2v6fX+NXur10Fq5rI1dfDIZnPAZx41G2qVEGYDPiNNr9cm1SwS9WcKJJuyHDDFqK
         evSMVb+kPtr7Ozx4TyGQ1WwRCSkuGcH7EGF8ySUk/knhZG2guDzwh3/F8FpvxcvEkMBo
         rprJPtUC97NtgcGjkPLgYEl0fGzTT4IqUVprVdvRBXYd5HRinESKJFq3j/zkxKV0izZg
         76Rh0TKqScuqA5tS5qI18mygdkDt03QecfyLo+2J3P7/GHBWidMdkhlOeko4dyVAEND0
         A6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963282; x=1705568082;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8fdzAkRigLOJSs0p8z2FKeIqZxw3OTVE9TPYi8cJXf8=;
        b=QpplTHeKnxYmriwp1XZO2cOa95DcTBZNYxqTq/GYEwW1PmZkhhhCyB1/0+hv8V4lbw
         lJMRLnNFwiuivFpRQvxGp5yFm3F8veP2iDtRxsEsmtuQzWRL/YMskwwD5FJ5de+PSyA+
         rQtfDd10/RBQoKPBMA5Mtk0fUJYnS2NR9q1g8bsXXwC+/w/uaiDLrsei0+LIysPs34fO
         uaOkOdlZCaQuTNtXUcM53WqtvAsuLyTKAXXhSqWmWhPJe8LbYPY/hj0IkZHUUNvmupXi
         s85skobswefqkreOzP7Z4SqOLYC5ehFOWU0At+fvLHIOnEHogx1l/lCp+FdqC+Ott0fW
         EJ0g==
X-Gm-Message-State: AOJu0YzfOK6wY/pA4lXJV9DCbddUcGGpMh3dIg+/sQwQ7CcMMC7QjsSU
	9QXr9Lzg0o+H7n4sE/W18sI2Fsy9bylqUX9qFdcT+EA3IqpnZeCH
X-Google-Smtp-Source: AGHT+IFq5ynQNEJVSXgc5jOV5wTNN9Vjm/J5WWKvAdAgAN+RMQzy+62aeC55Dtrg2J/oQzlpesDVgA==
X-Received: by 2002:a17:906:17c4:b0:a28:d427:3959 with SMTP id u4-20020a17090617c400b00a28d4273959mr397730eje.62.1704962870935;
        Thu, 11 Jan 2024 00:47:50 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id rv4-20020a17090710c400b00a26e490e3f2sm305391ejb.181.2024.01.11.00.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jan 2024 09:47:49 +0100
Message-Id: <CYBQW9KRHVJS.3UOHTOMRWDWVK@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v3] arm64: dts: qcom: qcs6490-idp: Add definition
 for three LEDs.
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <quic_huliu@quicinc.com>, "Andy Gross" <agross@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240111-lpg-v3-1-811c9e82dae4@quicinc.com>
In-Reply-To: <20240111-lpg-v3-1-811c9e82dae4@quicinc.com>

On Thu Jan 11, 2024 at 3:52 AM CET, Hui Liu via B4 Relay wrote:
> From: Hui Liu <quic_huliu@quicinc.com>
>
> Add definition for three LEDs to make sure they can
> be enabled base on QCOM LPG LED driver.
>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
> Changes in v3:
> - Rephrased commit text and updated the nodes to qcm6490-idp board file.
> - Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fb=
bc65a@quicinc.com/
>
> Changes in v2:
> - Rephrased commit text and updated the nodes to board file.
> - Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572=
cb0@quicinc.com
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/d=
ts/qcom/qcm6490-idp.dts
> index 37c91fdf3ab9..f801144a1556 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -5,6 +5,7 @@
> =20
>  /dts-v1/;
> =20
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
>  #include "pm7325.dtsi"
> @@ -414,6 +415,30 @@ vreg_bob_3p296: bob {
>  	};
>  };
> =20
> +&pm8350c_pwm {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	status =3D "okay";
> +
> +	led@1 {
> +		reg =3D <1>;

Hi Hui Liu,

> +		color =3D <LED_COLOR_ID_RED>;
> +		label =3D "red";

Please remove the deprecated "label" property. Since you already have
"color" set you only need to add "function". On phones for the
notification LED we usually use "function =3D LED_FUNCTION_STATUS;"

Also depends on what your hardware looks like, if it's 3 separate LEDs
then with label replaced it would be okay.
If the 3 LEDs are in one spot (so you can mix the colors with it), then
please make it a RGB multi-led like e.g. in sm8550-qrd.dts.

Regards
Luca

> +	};
> +
> +	led@2 {
> +		reg =3D <2>;
> +		color =3D <LED_COLOR_ID_GREEN>;
> +		label =3D "green";
> +	};
> +
> +	led@3 {
> +		reg =3D <3>;
> +		color =3D <LED_COLOR_ID_BLUE>;
> +		label =3D "blue";
> +	};
> +};
> +
>  &qupv3_id_0 {
>  	status =3D "okay";
>  };
>
> ---
> base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
> change-id: 20231215-lpg-4aadd374811a
>
> Best regards,


