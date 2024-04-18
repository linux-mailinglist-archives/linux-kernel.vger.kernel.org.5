Return-Path: <linux-kernel+bounces-150847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27A8AA595
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA321F22A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B052F83;
	Thu, 18 Apr 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5GKLzf8"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6911CB4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481164; cv=none; b=Gb1GChIia/JAD1n86OkB3zlnS+A8dZtE2egxCDN3FLGf05ETR7+RkU88R8XKUNnaOJ1k+8q+KmlIQ7C9HMWM9uQH+YYNJR3pQkFVi82XiXLDxpHB0DFVVmxk2XupCF9vh1BuIquo7g95QTu4nIHjZ8dkL3a+dd2oOH9C2R6lUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481164; c=relaxed/simple;
	bh=D7fTlCHxbzizfcGJL3wob3PQR41wlpCaKsPqy4FDhWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g77RRH7p7ju4ADaXttlFrZgSb1qjIEFViKLO3X7HZsMFGVaZbLfN/8W6F80DMzNYBb7IrJXHZfj6yRmSIElspexl8kbK2pgDNPyksrvrZ7u5cjRbitcY4aKNFhvsGtxXDTE9Zfwd4vnMq53NEb1tq2sVKOtEeVKN5apfXrA4DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5GKLzf8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4266673bbso13501415ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713481162; x=1714085962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DdL3HzCb+5J1PYorhrvryxPtw9PH/EG3K3drRBpUY2s=;
        b=v5GKLzf8Fztmg9kxAwKYNFG/BAEMNz9cBJ24+8RadTvhJhtcV8ZgCVYVIv2RpfoVsC
         qpYdm+xhoMIbdztCIUUaAMWO28w0SDNCetUtRGOQT70smtX7Pg6jhEToZSV/QUep6zHs
         +YjZ7SjfsN54cRmMHDPa7VyYfh0I4U7jgtQkT8B8dTFNd7BPBv+Jx/wUeL3/+Gwz6yIC
         otU4dR6ibmjcdBHO/uEE0M9QVLisqvXeWPqNhLRP1Awu2/ENhRJS+p01ByIdT6Y/t07L
         +aUZVSIh0A3ESA1DYvBgvOWexbenV0KwspijUHD2vekF8zp1ohKwI8p7h0OmCS24My12
         KKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713481162; x=1714085962;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdL3HzCb+5J1PYorhrvryxPtw9PH/EG3K3drRBpUY2s=;
        b=kCAmq4kLJkPGXaNq8HY/ext5E6QhMeVM05ztMHi4JlCt+FKFTmUVKNuLjZNSrabj9S
         WMy/VQJVp479sgtkLj7shdwux74yRnm5i+k7WCjVxAfsoGQq90xQ4QVX5LapqesK6Lfe
         kIinCRiQOE26tHQ2XELhpEpwnFLRKzMfYoi9YuR77p7Zrpym952Bqhy9x0UOfKm0OPdY
         BOH/xN5tkfxHbKnqr9r0e8FsC7tuMFsRqDJyGILBnSilG/5zwLVZci1ge1mRSD9PmhBz
         dcr6RtGfwASxT5lcnjiZZlVPgQqhnlrgZdG/CJirNF48z3esk4AIl6KScutrSAiRRNAQ
         giLg==
X-Forwarded-Encrypted: i=1; AJvYcCXnchPv9wf88OQrXew4Wp0yMXNzWpHFkLfWBZuDpTDdp69/kIjQOvSTkmuxFwDjEmhMRG98MnfYDqvgoZbRUvkCGh/5VOuQvIBn/xfM
X-Gm-Message-State: AOJu0YwiWqY7u1j0tbpkQiR+t7XZ/wIpd4/D3hveANY5xh1EtZobLCxH
	QEFn14v5/Bb9bPQDIzM5VwxQarRqA4HY7WVTmAYf9d8n+id7KqPZ5jaWLSQa+DQ=
X-Google-Smtp-Source: AGHT+IGApT+hk2W1hlIDYOgCV0D14ijYcg4EQ8LzX3CAhRR+ar44aUioTQl9gQA+S9JbjymjV0Q5GA==
X-Received: by 2002:a17:902:f681:b0:1e0:c0dd:c5eb with SMTP id l1-20020a170902f68100b001e0c0ddc5ebmr636265plg.9.1713481162482;
        Thu, 18 Apr 2024 15:59:22 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.147])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b001e54f250ca9sm2044761plr.212.2024.04.18.15.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 15:59:21 -0700 (PDT)
Message-ID: <e0cc524b-82f2-4343-a1a8-9244464824f6@linaro.org>
Date: Fri, 19 Apr 2024 00:59:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: Add KD101NE3-40TI
 support
To: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, dianders@google.com,
 hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240418081548.12160-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240418081548.12160-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 10:15, lvzhaoxiong wrote:
> Create a new dt-scheam for the kd101ne3-40ti.

There is another thread like this, which is confusing. Please version
your patches. patman solves it. b4 as well.

Read the guidelines provided to you by Google.

> 
> Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>

Same comment as for all your other patches: please use full name.

> ---
>  .../panel/kingdisplay,kd101ne3-40ti.yaml      | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
> new file mode 100644
> index 000000000000..dc79a49eea3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/kingdisplay,kd101ne3-40ti.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: King Display KD035G6-40TI based MIPI-DSI panels
> +
> +description: |
> +  -This binding is for display panels using an JD9365DA controller
> +
> +maintainers:
> +  - Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: kingdisplay,kd101ne3-40ti
> +
> +  backlight: true
> +  port: true

Drop both

> +  pp3300-supply: true
> +  reg: true
> +  enable-gpios: true
> +  rotation: true

Drop these three. panel-common defines them.

> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpios
> +  - pp3300-supply
> +  - backlight
> +  - port

These can stay.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel: panel@0 {
> +            compatible = "kingdisplay,kd101ne3-40ti";
> +            reg = <0>;
> +            enable-gpios = <&pio 98 0>;

You included the header, so use it.



Best regards,
Krzysztof


