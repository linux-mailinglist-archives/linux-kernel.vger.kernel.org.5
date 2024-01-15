Return-Path: <linux-kernel+bounces-25803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96CA82D610
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4701C2143C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E86E549;
	Mon, 15 Jan 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="AAwxUCuW"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DDF4E9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-40e779f030aso3771995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1705311281; x=1705916081; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVeIETKJbD2YNlbWRi5z9tGnSFWdTelMWGKS6kgbyVM=;
        b=AAwxUCuWI7j1dDRjDck4d+D2cufrDUVsVsRGtYVLDM+f38ICWp6tbmnafv/jAjd7KV
         updNzr8sHAhEzefPxgC5NiuwYMWG+KKQrCB65u/5e8OTMwnJg1iGEd0QZnTGXaRvoIx2
         0GQCsYMEv278WbPoCODt+tqIlNvbFjccjEAGbvHGLGSqBETUb6wImrs0acOsgm33Dvmu
         YedPr8WGtlYVm7B6LcUZi3CMffTaL/oLq6EiVXLejmG6fXDS7Us7OogdtZIu7tu9hrwn
         pp3AKRIoguOEV91s1omjYy24m1FjngVmvCGlPby10bLgfURbqDmZM1/5W0M8x/gZNjmH
         4ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311281; x=1705916081;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aVeIETKJbD2YNlbWRi5z9tGnSFWdTelMWGKS6kgbyVM=;
        b=PaLn9btJKcuor3uPGW7/pqD3WJytP/8UXK6UHbuTm7fs2M0dSWrUk3y3fFrWd/IhDM
         K5yLEEUJh4umbcZYCAymt7mJz1pWv5u8Fzd6eoJOJV6fjfPB5lUTBZiCJoHRfkXh/tT0
         aeiNFsYLNoVV1jjjiwzpH+chmZuMCBoLUvaIB+qNlZpKYMNQwZnfolZzA3VzNdQTb0O3
         klzL0rtTlvC1o3ScjPeKMwgqTbMQfAC8Ap6yAAHcT0ZltpydkBbQ9JywoxJWuRikMnfQ
         YeriWapI4f7i76dKln6xmbq6leTWce7IzpqJmHTMyYQkR6g91j6Zhr/DmcYOdgOgJP8p
         ShLQ==
X-Gm-Message-State: AOJu0YwUryDZFWSGNVi6jEg/NyOvQqHM7T81oR7aozcGJvCjmc6j6ihT
	MSZTK4TO52q1ndnYzjk1GAdlBAhfOfa5Tg==
X-Google-Smtp-Source: AGHT+IE3xTIokkIfoVb+V5SeUWjJWe0Uq4O6jxQzD2huPIzSPsIyRIATGA4vXlforTMS/1YYPi+xLQ==
X-Received: by 2002:a05:600c:354a:b0:40d:891e:a0f1 with SMTP id i10-20020a05600c354a00b0040d891ea0f1mr3107195wmq.7.1705311281450;
        Mon, 15 Jan 2024 01:34:41 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q14-20020ae9e40e000000b007815c45cdc5sm2823107qkc.95.2024.01.15.01.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jan 2024 10:34:36 +0100
Message-Id: <CYF6E9BR9QHY.3441MOKCRAB15@fairphone.com>
Subject: Re: [PATCH] dt-bindings: usb: add common Type-C USB Switch schema
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240115092923.105275-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240115092923.105275-1-krzysztof.kozlowski@linaro.org>

On Mon Jan 15, 2024 at 10:29 AM CET, Krzysztof Kozlowski wrote:
> Several bindings implement parts of Type-C USB orientation and mode
> switching, and retiming.  Keep definition of such properties in one
> place, new usb-switch schema, to avoid duplicate defines.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/fcs,fsa4480.yaml  | 12 ++--
>  .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 12 ++--
>  .../devicetree/bindings/usb/nxp,ptn36502.yaml | 12 ++--
>  .../bindings/usb/onnn,nb7vpq904m.yaml         | 13 ++--
>  .../bindings/usb/qcom,wcd939x-usbss.yaml      | 12 ++--
>  .../devicetree/bindings/usb/usb-switch.yaml   | 68 +++++++++++++++++++
>  6 files changed, 93 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-switch.yaml
>
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Doc=
umentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> index f9410eb76a62..8b25b9a01ced 100644
> --- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> +++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> @@ -27,13 +27,8 @@ properties:
>    vcc-supply:
>      description: power supply (2.7V-5.5V)
> =20
> -  mode-switch:
> -    description: Flag the port as possible handle of altmode switching
> -    type: boolean
> -
> -  orientation-switch:
> -    description: Flag the port as possible handler of orientation switch=
ing
> -    type: boolean
> +  mode-switch: true
> +  orientation-switch: true
> =20
>    port:
>      $ref: /schemas/graph.yaml#/$defs/port-base
> @@ -79,6 +74,9 @@ required:
>    - reg
>    - port
> =20
> +allOf:
> +  - $ref: usb-switch.yaml#
> +
>  additionalProperties: false
> =20
>  examples:
> diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Do=
cumentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> index d3b2b666ec2a..88e1607cf053 100644
> --- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> @@ -33,13 +33,8 @@ properties:
>    vcc-supply:
>      description: power supply
> =20
> -  mode-switch:
> -    description: Flag the port as possible handle of altmode switching
> -    type: boolean
> -
> -  orientation-switch:
> -    description: Flag the port as possible handler of orientation switch=
ing
> -    type: boolean
> +  mode-switch: true
> +  orientation-switch: true
> =20
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
> @@ -54,6 +49,9 @@ required:
>    - orientation-switch
>    - port
> =20
> +allOf:
> +  - $ref: usb-switch.yaml#
> +
>  additionalProperties: false
> =20
>  examples:
> diff --git a/Documentation/devicetree/bindings/usb/nxp,ptn36502.yaml b/Do=
cumentation/devicetree/bindings/usb/nxp,ptn36502.yaml
> index eee548ac1abe..d805dde80796 100644
> --- a/Documentation/devicetree/bindings/usb/nxp,ptn36502.yaml
> +++ b/Documentation/devicetree/bindings/usb/nxp,ptn36502.yaml
> @@ -20,13 +20,8 @@ properties:
>    vdd18-supply:
>      description: Power supply for VDD18 pin
> =20
> -  retimer-switch:
> -    description: Flag the port as possible handle of SuperSpeed signals =
retiming
> -    type: boolean
> -
> -  orientation-switch:
> -    description: Flag the port as possible handler of orientation switch=
ing
> -    type: boolean
> +  orientation-switch: true
> +  retimer-switch: true
> =20
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> @@ -49,6 +44,9 @@ required:
>    - compatible
>    - reg
> =20
> +allOf:
> +  - $ref: usb-switch.yaml#
> +
>  additionalProperties: false
> =20
>  examples:
> diff --git a/Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml b=
/Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml
> index c0201da002f6..589914d22bf2 100644
> --- a/Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml
> +++ b/Documentation/devicetree/bindings/usb/onnn,nb7vpq904m.yaml
> @@ -21,14 +21,8 @@ properties:
>      description: power supply (1.8V)
> =20
>    enable-gpios: true
> -
> -  retimer-switch:
> -    description: Flag the port as possible handle of SuperSpeed signals =
retiming
> -    type: boolean
> -
> -  orientation-switch:
> -    description: Flag the port as possible handler of orientation switch=
ing
> -    type: boolean
> +  orientation-switch: true
> +  retimer-switch: true
> =20
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> @@ -95,6 +89,9 @@ required:
>    - compatible
>    - reg
> =20
> +allOf:
> +  - $ref: usb-switch.yaml#
> +
>  additionalProperties: false
> =20
>  examples:
> diff --git a/Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yam=
l b/Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yaml
> index 7ddfd3313a18..96346723f3e9 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,wcd939x-usbss.yaml
> @@ -35,13 +35,8 @@ properties:
>    vdd-supply:
>      description: USBSS VDD power supply
> =20
> -  mode-switch:
> -    description: Flag the port as possible handle of altmode switching
> -    type: boolean
> -
> -  orientation-switch:
> -    description: Flag the port as possible handler of orientation switch=
ing
> -    type: boolean
> +  mode-switch: true
> +  orientation-switch: true
> =20
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> @@ -63,6 +58,9 @@ required:
>    - reg
>    - ports
> =20
> +allOf:
> +  - $ref: usb-switch.yaml#
> +
>  additionalProperties: false
> =20
>  examples:
> diff --git a/Documentation/devicetree/bindings/usb/usb-switch.yaml b/Docu=
mentation/devicetree/bindings/usb/usb-switch.yaml
> new file mode 100644
> index 000000000000..0d0b60234d1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/usb-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Orientation and Mode Switches Common Properties
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +
> +description:
> +  Common properties for devices handling USB mode and orientation switch=
ing.
> +
> +properties:
> +  mode-switch:
> +    description: Possible handle of altmode switching

handle -> handler

> +    type: boolean
> +
> +  orientation-switch:
> +    description: Possible handler of orientation switching
> +    type: boolean
> +
> +  retimer-switch:
> +    description: Possible handle of SuperSpeed signals retiming

handle -> handler

> +    type: boolean
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node to link the device to a TypeC controller for the purpo=
se of
> +      handling altmode muxing and orientation switching.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Super Speed (SS) Output endpoint to the Type-C connector
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description:
> +          Super Speed (SS) Input endpoint from the Super-Speed PHY
> +        unevaluatedProperties: false
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            # additionalProperties: true

Don't think this should still be here?

The rest looks sane to the extent I know dt bindings.

Regards
Luca

> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> +                minItems: 1
> +                maxItems: 8
> +                uniqueItems: true
> +                items:
> +                  maximum: 8
> +
> +oneOf:
> +  - required:
> +      - port
> +  - required:
> +      - ports
> +
> +additionalProperties: true


