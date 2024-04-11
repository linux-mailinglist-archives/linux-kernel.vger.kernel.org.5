Return-Path: <linux-kernel+bounces-140267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F28A10FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B611F2CFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34493149001;
	Thu, 11 Apr 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zinz33/f"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D5147C7E;
	Thu, 11 Apr 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831955; cv=none; b=JaU7Fbq//X7QT+qclJ2ST6viplfcUHgfOkVn3tF1CKpzU6JllLbkMq8svMjaxa8HEmJtJan175vpXer7Dq5ZuiU77pP3qghR8MOGZ1Gn7Ykxxx8wM6Gb4gF9kN/Lu3T5DySvwurTu4bT19Qn1ELnF2Dj/YAwU5740wAR0Ni5rNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831955; c=relaxed/simple;
	bh=pWfyDzgg2FcL9zucQ9mhivkVL8xEVE3GnMTTbdODBE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmR08hcBt7Wv9IqZY5E7e1HvYRz5znHVn+WebM99qbK7BwYKlKuiWhhIRx+QFPEFg230bPTKelspZ6OezQzawvyk3W65ruTAffbRfrzISUocwmfdWDfuZm6HdMbqhVUp1jr2aK6Pslk+mu40kBXLpCszgg0VI8qzIUMyQqvgTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zinz33/f; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a522c00ce55so8671766b.0;
        Thu, 11 Apr 2024 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712831951; x=1713436751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxHiRwznB/WlWY/qprRawdCtyuIsVjD3shbwYS9mS6Y=;
        b=Zinz33/fVPavvrk9tDa3IOqA1tAsYOcLcdipxc7LlaXyXjpewnK77dKsYEKuXKJ8LI
         oLrCTWGDeaefxGp5jmmwg/gxiYaDRtAW3j7yl/QElK4qDuPDx3XeDqFqOFpgKTT5xU72
         OqKxxJ1boHgrxJd7u/d3UBCPpzS64nVP8E4oRwRlRkjBexFMGBTafL0ldc2l7Xmpc+rQ
         rfx1jvAw+HrSZrT+ckOEflt2q2/typdrG27iAEgP8aKtz/lkgVb6csWBRBDsSvEbVCas
         8LZoppVw+Rfyt6nLFMib+T+vSaIzuBspahtlJ0EIJLwBlf34oFbqAhVvuIqTlAyfam/I
         y6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712831951; x=1713436751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxHiRwznB/WlWY/qprRawdCtyuIsVjD3shbwYS9mS6Y=;
        b=BbofenDcDMQ3q7MmQAs63KHcgkH+bt7jFRWE9sw3e6RdpBRnt4g4vOC8LHgH24+VPB
         tmUmj/TleEwAFd4A/+7FltNlI8wvnbY1LbrzYAv1YJxtyNAM4pBq38jSD3i9CIVIy5HW
         4fMURgbgTV6sOkKyi0Ym6XX/7ajJb5xFFtURd9k+YpOw9Ve3sEwr/Q8lL8dGl3hNJ+Lq
         n85A+4L2SnLn7d+0UiucpWi/Ez7e8IK3rPN9hTPY5AKm6v2FLKjTt7hbdEKTmef1AS7Q
         lf4juOUJ+TmEVxcgJdKmDFAa30nhTnawlRZRjkXF9yV5pQ0Zg41GjIwAF1vMiE6booUt
         7d3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKwFpCDZgZi7kfZ/3a+Lp1B6RCkzlRS7qyvWTbfS2O4oWpuh3mBpWefS52wqTyxIi69qZycElf8OXUHfxFuPEVzEDf/BFQPcp/M5NS3IeJkk/WS049zCxArkEIoJ7PBsGcXH+RLw==
X-Gm-Message-State: AOJu0YwZCBJwQpcdZUvCxoeA6TWR+26Ud9Z7QwidvzlzQg2M+r+A2D9Q
	ZYo2bjNZB6qTFSqS9kWCtHKflnfWewhgqIVax+3fA7ML83ROwoeF
X-Google-Smtp-Source: AGHT+IE6aq4nNGLNCBVsVw2T5Tl1yUoF/Vd6d1ioqEei+XDXsS50PrvjgzSrllN4DUJB3hrp2n7UXA==
X-Received: by 2002:a17:906:f159:b0:a4e:2178:d91a with SMTP id gw25-20020a170906f15900b00a4e2178d91amr3855333ejb.59.1712831950652;
        Thu, 11 Apr 2024 03:39:10 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id l17-20020a170906079100b00a51b3c951b6sm618080ejc.191.2024.04.11.03.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:39:10 -0700 (PDT)
Message-ID: <b3c8b7c8b55a3944e56b71035fc0123dd96cb8b6.camel@gmail.com>
Subject: Re: [PATCH 1/2 v4] dt-bindings: pwm: Add AXI PWM generator
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, 
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org,  robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 dlechner@baylibre.com, Drew Fustini <dfustini@baylibre.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Apr 2024 12:42:43 +0200
In-Reply-To: <20240301173343.1086332-2-tgamblin@baylibre.com>
References: <20240301173343.1086332-1-tgamblin@baylibre.com>
	 <20240301173343.1086332-2-tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 12:33 -0500, Trevor Gamblin wrote:
> From: Drew Fustini <dfustini@baylibre.com>
>=20
> Add Analog Devices AXI PWM generator.
>=20
> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> v4 changes: None (rebased, added maintainer's previous Reviewed-by)
> v3 changes: None (rebased, added maintainer's previous Reviewed-by)
>=20
> v2 changes:
> * Address feedback for driver and device tree in v1:
> =C2=A0 * Relocate "unevaluatedProperties" in device tree binding
> =C2=A0 * Remove redundant "bindings for" in description
>=20
> ---
> =C2=A0.../bindings/pwm/adi,axi-pwmgen.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 48 +++++++++++++++++++
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 8 ++++
> =C2=A02 files changed, 56 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pw=
mgen.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> new file mode 100644
> index 000000000000..63461920a362
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/adi,axi-pwmgen.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI PWM generator
> +
> +maintainers:
> +=C2=A0 - Michael Hennerich <Michael.Hennerich@analog.com>
> +=C2=A0 - Nuno S=C3=A1 <nuno.sa@analog.com>
> +
> +description:
> +=C2=A0 The Analog Devices AXI PWM generator can generate PWM signals
> +=C2=A0 with variable pulse width and period.
> +
> +=C2=A0 https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> +
> +allOf:
> +=C2=A0 - $ref: pwm.yaml#
> +
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 const: adi,axi-pwmgen-1.00.a
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 "#pwm-cells":
> +=C2=A0=C2=A0=C2=A0 const: 2
> +
> +=C2=A0 clocks:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +required:
> +=C2=A0 - reg
> +=C2=A0 - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +=C2=A0 - |
> +=C2=A0=C2=A0=C2=A0 pwm@44b00000 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-pwmgen-1.00=
a";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44b00000 0x1000>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&spi_clk>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #pwm-cells =3D <2>;
> +=C2=A0=C2=A0=C2=A0 };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..8a4ed5545680 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3431,6 +3431,14 @@ W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> =C2=A0F:	drivers/spi/spi-axi-spi-engine.c
> =C2=A0
> +AXI PWM GENERATOR
> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +
> =C2=A0AXXIA I2C CONTROLLER
> =C2=A0M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
> =C2=A0L:	linux-i2c@vger.kernel.org


