Return-Path: <linux-kernel+bounces-46169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDA843B86
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFDE1F25E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E456996A;
	Wed, 31 Jan 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOtesOJ8"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF369946;
	Wed, 31 Jan 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694978; cv=none; b=U7vduSRucWHhCZ7KF5HpGsZjUnXB1TGLjl0traz45PJbtGJ/IS1OiUl95hVkirRcFoTHB94XnOCa4n0eusyaP7B38SUxPVBtgS+7YZN142OLdo6gWbXhS2HVev5A84n3PKUtdh4wa/l84Pb2TRuSZ1GJiQT/RbrRLAw/r9Glj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694978; c=relaxed/simple;
	bh=fK6iq4rUq+DD9xk9G5tnkNwycPJfH/ldT14R1RzQc3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oD8+kHt0w7OIZL3xgS8o7bVRqFYkJw89hZgb54SrqmoBs436Gn4wZL/0FS5rJmWYhj/VkxI4yPaqhibS+bj86LxYF/Tg9Z2X5cYbKEumCxbnUBEjAWu0WAZME5Ln+nwepb1Yc5BJqNhLI2fXhynHpDT495tKk2RILeGBk7pacbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOtesOJ8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so620610766b.2;
        Wed, 31 Jan 2024 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706694974; x=1707299774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEadS9UxY93S+yF9FZGOCXcaSPkNTNxK4D1IAVD6N6k=;
        b=JOtesOJ808gX9YpB+S6L5ViAI0DAEv+MzY6TWNIYQQdHQkEyEsRbK7Krjrb3zNgpYr
         Rf+GbvfDFrsalkKXlSFJ0gYHmqwkperxY8yPLjRS+q8FKfIS0GKnZBVfpeiT8ffIwP/V
         NjloSfUku6SsMhojeccvXbvLaEW7J7NRWcKCRf9naArxulyOB4xWqaL/gFCWdSEvx7rX
         YwzbFeO9tVkjgVd1jRvsG+PO4FqScJJmTIJngLkyMtwlzSFlCgFwUzpVBbHbTHJp543m
         6YYhs6MdakgIg23cR07CHXSbQT5g2b62BbSxCThTR3yOGiFJhuPWSJxruc6StknH7eHo
         s3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694974; x=1707299774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEadS9UxY93S+yF9FZGOCXcaSPkNTNxK4D1IAVD6N6k=;
        b=Ml8D8ZceT8knm93OJH8h7W1wx/3G1oT6OuyiVB1J0r7fcGZoH7PB90tCe1oE+8NXbm
         47RpULzAAtzcF09np4HskhVpPPl2isJvV7nOFyzIPVKsVzBTriMcOBEQ8fA6KWtyj+1U
         bLPwQb7Ci6SIf7GeWx8ZiPEOj49s5qZWBK/NnJPbbRHjpN/Dl+m7gAWCStXy4JkouAyl
         SMt/NhvOqBNvjWQN7hpjCdHzszEW5wosXFRsi4HXGBCM74olfGXjOwFfgiaat6wUFBI0
         HgjxIcBuW91lcwYYVXE5W6pC1qFjv6wTSv91Q2bkc7nmJMiAO8de6sUtpi1QNxQ+kwc0
         d6gw==
X-Gm-Message-State: AOJu0YwMyNZRku1BtGqMRzXUepeUsWgE0OPhVReQ2lvtC8n5SrnzwxdQ
	LhqyvuneU5RDSXsdCWBVUHFNEHNRg+gx9qDEvT/iv8cH1HG0ywcfJKmVg5YcozdJ8/7CFOgDau1
	Zad3MIb9DecQNK6vldF9fpFwq1Ao=
X-Google-Smtp-Source: AGHT+IH4DyH0g1ej/nBlEHJ+mPR+KHehaqfvp4PLg2KVCzp3KPZ9erh9Kgz4XrTxHRarieng8jtQWjzFh74lTtCusQM=
X-Received: by 2002:a17:906:fc26:b0:a35:3152:c46b with SMTP id
 ov38-20020a170906fc2600b00a353152c46bmr708719ejb.60.1706694974324; Wed, 31
 Jan 2024 01:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-1-c6222c4c78df@gmail.com> <0702542c8d7dc4139ba5da690fd98e67@manjaro.org>
In-Reply-To: <0702542c8d7dc4139ba5da690fd98e67@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 31 Jan 2024 13:56:02 +0400
Message-ID: <CABjd4Ywx4-3BN7tF=Lv6LNTry_+j=jjM_v7SdzLaWHbuePip3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:05=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alexey,
>
> Some small nitpicks below, please have a look.
>
> On 2024-01-30 19:21, Alexey Charkov wrote:
> > Include thermal zones information in device tree for rk3588 variants
>
> Please use "RK3588" instead of "rk3588", both here and in the
> patch subject.  Looks much better.

Noted, thanks!

> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 162
> > ++++++++++++++++++++++++++++++
> >  1 file changed, 162 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > index 36b1b7acfe6a..696cb72d75d0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -10,6 +10,7 @@
> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/ata/ahci.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       compatible =3D "rockchip,rk3588";
> > @@ -2228,6 +2229,167 @@ tsadc: tsadc@fec00000 {
> >               status =3D "disabled";
> >       };
> >
> > +     thermal_zones: thermal-zones {
> > +             /* sensor near the center of the whole chip */
>
> It would be good to replace "whole chip" with "SoC".  Simpler and
> IIRC closer to the official description of the sensor.

The TRM only says "near chip center" (sic) :)

> > +             package_thermal: package-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 0>;
> > +
> > +                     trips {
> > +                             package_crit: package-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 0 and 1 */
> > +             bigcore0_thermal: bigcore0-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 1>;
> > +
> > +                     trips {
>
> Please add the following comment here, to make it clear what's
> the purpose of this thermal trip when the IPA thermal governor
> is used (more similar comments below):
>
>                                  /* IPA threshold */

Not so sure about this one: shouldn't the device tree be
implementation agnostic, and just describe the hardware and its
expectations? Sounds like references to a particular thermal governor
would be out of scope.

Best regards,
Alexey

> > +                             bigcore0_alert0: bigcore0-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
>
> Please add the following comment here:
>
>                                  /* IPA target */
>
> > +                             bigcore0_alert1: bigcore0-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore0_crit: bigcore0-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&bigcore0_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_b0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_b1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 2 and 3 */
> > +             bigcore2_thermal: bigcore2-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 2>;
> > +
> > +                     trips {
>
> Please add the following comment here:
>
>                                  /* IPA threshold */
>
> > +                             bigcore2_alert0: bigcore2-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
>
> Please add the following comment here:
>
>                                  /* IPA target */
>
> > +                             bigcore2_alert1: bigcore2-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore2_crit: bigcore2-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&bigcore2_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_b2 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_b3 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between the four A55 cores */
> > +             little_core_thermal: littlecore-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 3>;
> > +
> > +                     trips {
>
> Please add the following comment here:
>
>                                  /* IPA threshold */
>
> > +                             littlecore_alert0: littlecore-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
>
> Please add the following comment here:
>
>                                  /* IPA target */
>
> > +                             littlecore_alert1: littlecore-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             littlecore_crit: littlecore-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&littlecore_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_l0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_l1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_l2 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_l3 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor near the PD_CENTER power domain */
> > +             center_thermal: center-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 4>;
> > +
> > +                     trips {
> > +                             center_crit: center-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             gpu_thermal: gpu-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 5>;
> > +
> > +                     trips {
> > +                             gpu_crit: gpu-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             npu_thermal: npu-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 6>;
> > +
> > +                     trips {
> > +                             npu_crit: npu-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> >       saradc: adc@fec10000 {
> >               compatible =3D "rockchip,rk3588-saradc";
> >               reg =3D <0x0 0xfec10000 0x0 0x10000>;

