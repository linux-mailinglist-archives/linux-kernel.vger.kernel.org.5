Return-Path: <linux-kernel+bounces-61451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D64851296
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E5CB24CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09039ACB;
	Mon, 12 Feb 2024 11:47:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94339857;
	Mon, 12 Feb 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738465; cv=none; b=QgikOfBGLR2V1ddrQzB2/7Z0agzN1Oa3umfHhcFr3a/qzMPQutFjF2skmSnsboPzJinHKppve5m6PXZnFZe/4JM1+Thv7vjF7vmAukFntx1+CUs1Md9DZSna/JbPqNXPD2oRg5z1ROD18f8W24Y3htT1XU1ljinz8FTcPF+Q8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738465; c=relaxed/simple;
	bh=2LLuzt/utxNQeoYBEvSpGD3oWa0MmajxLM7auRqCFHU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkP7furnguNf3GhTe3YxWX7LO2lG7peccn9pjlmqGPDUXakr3JCzMnOIFmYlQFH8wYASo2Y8Sj/F4kFh5ABEdmg3SLwOxhsnOR40ty/zQ48F2xNU+TGXOaIyFjY2Klfxm92FpTzLlm+ZsABYQX/wbaQwzveOc5rJsXqLeiDD7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYMzk396jz6JB09;
	Mon, 12 Feb 2024 19:43:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A717140136;
	Mon, 12 Feb 2024 19:47:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:47:39 +0000
Date: Mon, 12 Feb 2024 11:47:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?UTF-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
	<icenowy@aosc.io>, <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: magnetometer: Add DT binding for
 Voltafield AF8133J
Message-ID: <20240212114738.0000535b@Huawei.com>
In-Reply-To: <20240211205211.2890931-3-megi@xff.cz>
References: <20240211205211.2890931-1-megi@xff.cz>
	<20240211205211.2890931-3-megi@xff.cz>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 11 Feb 2024 21:51:58 +0100
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>

Title doesn't need to mention binding (it's implicit from the dt-bindings b=
it
dt-bindings: iio: magnetometer: Add Voltafield AF8133J

>=20
> Voltafield AF8133J is a simple magnetometer sensor produced by Voltafield
> Technology Corp, with dual power supplies (one for core and one for I/O)
> and active-low reset pin.
>=20
> The sensor has configurable range 1.2 - 2.2 mT and a software controlled
> standby mode.
>=20
> Add a device tree binding for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ond=C5=99ej Jirman <megi@xff.cz>

Hi Ond=C5=99ej

A few quick comments.


> ---
>  .../iio/magnetometer/voltafield,af8133j.yaml  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/vo=
ltafield,af8133j.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/voltafiel=
d,af8133j.yaml b/Documentation/devicetree/bindings/iio/magnetometer/voltafi=
eld,af8133j.yaml
> new file mode 100644
> index 000000000000..ab56c0f798ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/voltafield,af813=
3j.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/voltafield,af8133j.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Voltafield AF8133J magnetometer sensor
> +
> +maintainers:
> +  - Ond=C5=99ej Jirman <megi@xff.cz>
> +
> +properties:
> +  compatible:
> +    - voltafield,af8133j
Test your bindings (as described in the bot message).
    const: voltafield,af8133j

> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: |
No need for the | as the formatting doesn't need to be preserved.

> +      an pin needed for AF8133J to set the reset state. This should be u=
sually

A pin

> +      active low.
> +
> +  avdd-supply:
> +    description: |
> +      an optional regulator that needs to be on to provide AVDD power (W=
orking

An optional (if it were optional, A regulator if not)

> +      power, usually 3.3V) to the sensor.
Seems unlikely the power supply is optional (though specifying it in DT mig=
ht be -
however see below).

> +
> +  dvdd-supply:
> +    description: |
> +      an optional regulator that needs to be on to provide DVDD power (D=
igital
> +      IO power, 1.8V~AVDD) to the sensor.
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg

Any power supply that is required for operation should be listed here (even=
 though
we can rely on the stub supplies if it isn't in the DT).
I used to think this wasn't necessary, so lots of bindings upstream don't y=
et
have it.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        magnetometer@1c {
> +            compatible =3D "voltafield,af8133j";
> +            reg =3D <0x1c>;
> +            avdd-supply =3D <&reg_dldo1>;
> +            dvdd-supply =3D <&reg_dldo1>;
> +            reset-gpios =3D <&pio 1 1 GPIO_ACTIVE_LOW>;
> +        };
> +    };


