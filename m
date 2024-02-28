Return-Path: <linux-kernel+bounces-84612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C686A905
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44ED4B25BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A9C2560B;
	Wed, 28 Feb 2024 07:31:51 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC92560C;
	Wed, 28 Feb 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105511; cv=none; b=CRiVdtA3CWKwnWaL+SBPRbueIYTnpx4A1BlYJrHdrCVknYYs/gaD3cw1+dsuUtafyjhKy9PxqarkGJeeJ/QZPqteMmjXma6nlnUK8BHJmDLeV8i+ZTBrOqbD6DLpThiOSycMHZyJP4WL98w631/4g5WFCU5X5B/D/qX9Cx1bE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105511; c=relaxed/simple;
	bh=7b/Mm0rd6kV5M5+yNjB1eglhtbDPT0suSYpIqAyjs98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu185EIeErU5qMIZ+OqukEJw7j4izDk4jx8K09eIBeHiYP9KInfn5Y3VwcHJZ5/2abziZHyDw9Ho4FMAp4LLZ2edgn8uiz3u6PF+H6TCHU5wH1gu114QTdhmq5x7eFyjyUl8cXPX1AqaZPnd8XMr1n542fdqd2C1lTkX3scl8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aedb1.dynamic.kabel-deutschland.de [95.90.237.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A509361E5FE04;
	Wed, 28 Feb 2024 08:30:42 +0100 (CET)
Message-ID: <93d67381-34fc-423c-868a-565378c63e09@molgen.mpg.de>
Date: Wed, 28 Feb 2024 08:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: Add NCT7363Y documentation
Content-Language: en-US
To: Ban Feng <baneric926@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 kcfeng0@nuvoton.com, kwliu@nuvoton.com, openbmc@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 DELPHINE_CHIU@wiwynn.com, naresh.solanki@9elements.com,
 billy_tsai@aspeedtech.com, Rob Herring <robh@kernel.org>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-3-kcfeng0@nuvoton.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240227005606.1107203-3-kcfeng0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ban,


Thank you for your patch.


Am 27.02.24 um 01:56 schrieb baneric926@gmail.com:
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> Adding bindings for the Nuvoton NCT7363Y Fan Controller

s/Adding/Add/ or even Document bindings …

Do you have an URL to the datasheet?

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> ---
>   .../bindings/hwmon/nuvoton,nct7363.yaml       | 63 +++++++++++++++++++
>   MAINTAINERS                                   |  6 ++
>   2 files changed, 69 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> new file mode 100644
> index 000000000000..1a9d9a5d614e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT7363Y Hardware Monitoring IC
> +
> +maintainers:
> +  - Ban Feng <kcfeng0@nuvoton.com>
> +
> +description: |
> +  The NCT7363Y is a Fan controller which provides up to 16 independent

lowecase: fan controller?

> +  FAN input monitors, and up to 16 independent PWM output with SMBus interface.

output*s*?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7363
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +patternProperties:
> +  "^fan-[0-9]+$":
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +    required:
> +      - pwms
> +      - tach-ch
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hwmon: hwmon@22 {
> +            compatible = "nuvoton,nct7363";
> +            reg = <0x22>;
> +            #pwm-cells = <2>;
> +
> +            fan-0 {
> +                pwms = <&hwmon 0 50000>;
> +                tach-ch = /bits/ 8 <0x00>;
> +            };
> +            fan-1 {
> +                pwms = <&hwmon 1 50000>;
> +                tach-ch = /bits/ 8 <0x01>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..7b1efefed7c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15084,6 +15084,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
>   F:	drivers/hwmon/nct6775-i2c.c
>   
> +NCT7363 HARDWARE MONITOR DRIVER
> +M:	Ban Feng <kcfeng0@nuvoton.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> +
>   NETDEVSIM
>   M:	Jakub Kicinski <kuba@kernel.org>
>   S:	Maintained

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

