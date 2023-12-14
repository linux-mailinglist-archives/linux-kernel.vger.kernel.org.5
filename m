Return-Path: <linux-kernel+bounces-169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB38813D03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027952836E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E967200;
	Thu, 14 Dec 2023 22:02:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70F2C682;
	Thu, 14 Dec 2023 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9f879f784so47022a34.2;
        Thu, 14 Dec 2023 14:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702591333; x=1703196133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPemIXHsGC2pL7OrGhnuYvM+owbrAtZjLeJGA6HoXBA=;
        b=QNlEn0B49sH5JPtWTNLKwVzVSTAh7+9a4l6kEoIm+kAg6yk9pxddBn+6Wb3jNahfUN
         JU0TAS/GzCA6vYyMSfA+/qDEPmfospNgzCs+q6Qs+ks5X9qA8X8g15FPkKMbrHNxLCD1
         ij6CpledXq56WX5y45xa3UM7+KFk+wVasXELVTmTqamyJdCF3aswa9ie4ygQb9JluhWN
         oLJlAlISS82f1RCQqlGu45CMbsUTevJ0SR4GUv7ZoMX9gCU0Q/POjkcuFaRnxfCY4Ygg
         rdXOHv31Qdt69UChmuYK73Jy6104vkc7GZdszgLI9m03mrYSogpG2PtqWoa60OP1YFCJ
         HPyQ==
X-Gm-Message-State: AOJu0Yy3DVWeDRdIAbYLU/mKygxYzonXx8rw2dseqMbqW5dRC4KF5MI3
	U+9GaV2GRWW2dF1sWb9nPg==
X-Google-Smtp-Source: AGHT+IFGjLR/Dd71l08mKUXouThqmEzNjRN83l0fPFsgqUBgmgfA06a/1ja4cfFBCwGsEI4kItxgcA==
X-Received: by 2002:a05:6830:2081:b0:6d9:f68e:3c77 with SMTP id y1-20020a056830208100b006d9f68e3c77mr10021326otq.11.1702591332732;
        Thu, 14 Dec 2023 14:02:12 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t21-20020a9d7f95000000b006d9214c03f2sm3337212otp.80.2023.12.14.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:02:12 -0800 (PST)
Received: (nullmailer pid 1010455 invoked by uid 1000);
	Thu, 14 Dec 2023 22:02:10 -0000
Date: Thu, 14 Dec 2023 16:02:10 -0600
From: Rob Herring <robh@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
Message-ID: <20231214220210.GA988134-robh@kernel.org>
References: <20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru>
 <20231212-aspire1-ec-v2-1-ca495ea0a7ac@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-aspire1-ec-v2-1-ca495ea0a7ac@trvn.ru>

On Tue, Dec 12, 2023 at 05:49:09PM +0500, Nikita Travkin wrote:
> Add binding for the EC found in the Acer Aspire 1 laptop.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../bindings/power/supply/acer,aspire1-ec.yaml     | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> new file mode 100644
> index 000000000000..1fbf1272a00f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Acer Aspire 1 Embedded Controller
> +
> +maintainers:
> +  - Nikita Travkin <nikita@trvn.ru>
> +
> +description:
> +  The Acer Aspire 1 laptop uses an embedded controller to control battery
> +  and charging as well as to provide a set of misc features such as the
> +  laptop lid status and HPD events for the USB Type-C DP alt mode.
> +
> +properties:
> +  compatible:
> +    const: acer,aspire1-ec
> +
> +  reg:
> +    const: 0x76
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  acer,media-keys-on-top:
> +    description: Configure the keyboard layout to use media features of
> +      the fn row when the fn key is not pressed. The firmware may choose
> +      to add this property when user selects the fn mode in the firmware
> +      setup utility.
> +    type: boolean

Besides the naming, this isn't really a property of the EC, but really 
part of the keyboard layout. It seems you just stuck it here because 
this is part of the specific device.

It is also hardly a feature unique to this device. I'm typing this from 
a device with the exact same thing (M1 Macbook Pro). Actually, all 3 
laptops I have in front of me have the same thing. The other 2 have 
a Fnlock (Fn+ESC) though.  On the M1, it's just a module param which I 
set as persistent. Though I now wonder if the Fnlock could be 
implemented on it too. Being able to switch whenever I want would be 
nice. That would probably have to be in Linux where as these other 
laptops probably implement this in their EC/firmware?

What I'm getting at is controlling changing this in firmware is not a 
great experience and this should all be common.

Rob

