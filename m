Return-Path: <linux-kernel+bounces-98328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7FA877876
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CC81F21213
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720473A1D4;
	Sun, 10 Mar 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luXl4Aet"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5A26AD7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102616; cv=none; b=BX4xkOX/GpzK6a+EKhHqwSvA8Jkr/ZP6RjlR2/mVwJFNu6G3n4LHl5s2xhhWJP8dOen7nsmCltCJRaOJ7gHNEG9k0jJKk1fnJe0KavSP1TNraApJx0b0YyWii0EcbHS7heKCG9fVE2twySGes3H1K9TzRegRFX4/86jyDLe5/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102616; c=relaxed/simple;
	bh=hRYjIjhcQUrwQOLyYg0heV3HvwX+XLXU6/MHK/UxUqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTGg0VS/j/xdkmyZ0uXj2p/13mSk0SDK05TTqii2d3iv2JtUTUqOEd5QKzVHiJpaTltbvxOxoAJ6ia67hTUmFjOFomz5L3UAjGBftIl9wuz5kKUBeJxlMNNKnFbb+R8JjDi6ZXmLUgk6L5lFu5FOIl31aYAr2uZsgVqRbnL4rD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luXl4Aet; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d422b6253cso23892641fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710102611; x=1710707411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AcTeHZz9SFHjMEBvNqGBhJiSUnRUNEaWfwgBkgFbkN4=;
        b=luXl4Aet/F4M0sie3VTYHqUcZnH1PU9eyPqF7/oEW3Ri2E7q/niysB+a4U2v/1KAMC
         fgdnaX7Lfj+TRQtCLX+QMko32j8cXGKlh3tHKNmnnZOYscSP/GzrWuugW/JzTl14jb/B
         F3a0LFt6Y/XdU403RBtbMM7m6arD9I+cpjzE0SS2ngoYM6Ry9t1QWlrKkWXjDNZp85oB
         IyVYY9Dg2Lpjnmv1MAWlgXzKDJtocVFLFtjVat7Xe/AEzKws6RDhGXa9YdDMHEHLcTjH
         CDUOEroWcet04zwtu3cxVJ6/IDXjKGutIsCKL4Hb20RD44ASR0wN8kvxZ7gkoUUB/x1T
         f7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710102611; x=1710707411;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcTeHZz9SFHjMEBvNqGBhJiSUnRUNEaWfwgBkgFbkN4=;
        b=FVVSx5j/Jd95tsVcS/rrW8Ng6rnBwzldEc070XonzFjJeNzOv8qaxvDrj75Nv+LZUU
         vxNqQC7DppshH5moWQ8krGDg3s6cooUNoYl44s0UJwprmQoAQfbewnQKSuRKZms8I1p+
         eg38uBHoAP+mwh9rj5dlNPTFKJk0U+ZhGDCMfhgygNv3JkIuyvtt5d1c97CIKZOECKg9
         uomjGL9WZ8IInt1nbo0HSkmYG+bHye0ZVyqP7eOjzLUwfnyLMYpLGwDnYeGhWqzCT7q1
         GlNiqzUnzYpLUnAPZF0mUYTmMG/cg/F6485gwWxeHlIGzn2K1RV6IB8vhOUCeWB5LfHw
         g+VA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ToWHYdbCYKFXF7NOZ9NLXvxOD2e4JjcX7zM0S+NgCtry66GnJqMFF/giY9fqU7rRuRy0GqP9p8Od5Csgm3JK7u1LcUhZeya+Be/Z
X-Gm-Message-State: AOJu0YxHsvACEd7sfgvwHyJv5sisUCtK4bliMMaeIx4nPtGJjQKP2Ihn
	//GWcs6eJEPNG0XFcApDuKG+I7gycKLa2/a/4OGEc94wWXmFParZ1W7bhaXg11s=
X-Google-Smtp-Source: AGHT+IFblhrrPEnTmThZu+xFmkDNn8Kjs86Fm37+xlwbjYEWTusERkDbdruXLF5mgtM2P0kk0X4caw==
X-Received: by 2002:a2e:8486:0:b0:2d3:352a:518d with SMTP id b6-20020a2e8486000000b002d3352a518dmr2946577ljh.10.1710102611195;
        Sun, 10 Mar 2024 13:30:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id gy4-20020a0564025bc400b0056820311668sm2203995edb.57.2024.03.10.13.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 13:30:10 -0700 (PDT)
Message-ID: <448f9d20-8b45-4794-9440-89d6a6888aee@linaro.org>
Date: Sun, 10 Mar 2024 21:30:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: imx-pata: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240310175217.20981-1-animeshagarwal28@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240310175217.20981-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2024 18:52, Animesh Agarwal wrote:

What is happening with your patches? It's 3rd or 4th version the same
day and while it was improving, this version has some weird changes.


> This patchset converts imx-pata bindings to DT schema.

Why did you changed the sentence from imperative? What for? Please read
again my comments.

> file name is changed to fsl,imx-pata to follow vendor,device scheme
> imx31-pata and imx51-pata are added in compatible to ensure this node compiles to
> imx31-pata.dtsi or imx51-pata.dtsi

What is imx31-pata.dtsi? Where is this file?

> oneOf is also added to allow the usage of imx27 alone.

These are not sentences. Please use regular imperative mood with full
stop and capital letters.

> Cleanups are done in patch 6

patch 6 of what? There is no patch 6 here.

"Convert foo bar to DT schema format. Add missing fsl,imx31-pata and
fsl,imx51-pata compatibles during conversion, because they are already
being used in existing DTS."


> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> 
> ---
> Changes in v6:
> - removed items before const due to single element.



> 
> Changes in v5:
> - added oneOf in compatible property to allow the usage of imx27 alone.
> 
> Changes in v4:
> - added fsl,imx31-pata in compatible property as enum
> - imx31-pata was not listed in compatible in original txt binding
> - adding imx31-pata in enum ensures the node compiles to imx31.dtsi
> 
> Changes in v3:
> - added fsl,imx51-pata in compatible property as enum
> - imx51-pata was not listed in compatible in original txt binding
> - adding imx51-pata in enum ensures the node compiles to imx31.dtsi
> - fsl,imx27-pata is added as a const to ensure it is present always
> 
> Changes in v2:
> - fixed style issues
> - compatible property now matches the examples
> - fixed yamllint warnings/errors
> ---
>  .../devicetree/bindings/ata/fsl,imx-pata.yaml | 43 +++++++++++++++++++
>  .../devicetree/bindings/ata/imx-pata.txt      | 16 -------
>  2 files changed, 43 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> new file mode 100644
> index 000000000000..c108a4b6636a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/fsl,imx-pata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX PATA Controller
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx31-pata
> +              - fsl,imx51-pata
> +          - const: fsl,imx27-pata
> +      - const: fsl,imx27-pata
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: PATA Controller interrupts
> +
> +  clocks:
> +    items:
> +      - description: PATA Controller clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pata: pata@83fe0000 {
> +        compatible = "fsl,imx51-pata","fsl,imx27-pata";
> +        reg = <0x83fe0000 0x4000>;
> +        interrupts = <70>;
> +        clocks = <&clks 161>;
> +    };
> +

Why adding this blank line? It was not here before and no one asked to
you to change anything at this place. How it is possible to edit one
piece of file and cause some entirely unrelated changes in other places?
Please use an editor which you are comfortable with - which you know how
to use.

The use `git add -p`, to see what you are adding to commit. DO NOT USE
`GIT ADD FILE` or `GIT ADD .`. Almost never... Think what you are adding
to the commit.

Best regards,
Krzysztof


