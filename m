Return-Path: <linux-kernel+bounces-1207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF8814BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6222281F85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CDC36AE0;
	Fri, 15 Dec 2023 15:22:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE72FE26;
	Fri, 15 Dec 2023 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9da137748so312121a34.1;
        Fri, 15 Dec 2023 07:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653777; x=1703258577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw3CYoRVmGzAAcY/wyRAKNOBUN7bY7gSQi19yFERVh8=;
        b=cGEHC7xLtq4Ko6AZh9LJ8zMO6DQqD3OIRbNwbnl9C58FtKGawuXAxr8K6V8kkcyK29
         idCDLQrercW9LP3lACnZh6FpOwBeg3c4iuXPYaC/CjU/9iu2PuKVTINd/qvJZPhg/6aM
         6jVY25WG3wRGeEiCYy9yHed9VJxeFK9BKdOSGAR5xlJWQxdyBVYRNe0b+QzFrZxjU9du
         +fOEAVcxHsgMbE4YDNk+/uwOR2C0XlKxS/x/d1tCwPhUlOOsllbOC9aLBmrPnGrpDcpS
         Q/o9RJg+w0L/tFcRnvGoM03m9/4ROqQJppC7tAuGWSaQR/vuNtPaelLMzawZqf2i5ZPg
         s0Eg==
X-Gm-Message-State: AOJu0Yzhc0ie8JYrKSjnhD7mZAFi9hEQDhd+6iCZnYHLKdUhHYi3Iq4C
	ig0m5sTXEIjp8eWgC/XdBXWXsNGuPA==
X-Google-Smtp-Source: AGHT+IHLfII0gke7uRP+LV5Ugn7EjczkP0xhnm/lpvntYGNQZQI/qUz+mfer6s8PP4+Uu4dw106EpA==
X-Received: by 2002:a05:6830:1511:b0:6da:3273:319f with SMTP id k17-20020a056830151100b006da3273319fmr2279116otp.9.1702653777214;
        Fri, 15 Dec 2023 07:22:57 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eq9-20020a056830490900b006da0e88aa4bsm2685520otb.64.2023.12.15.07.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:22:56 -0800 (PST)
Received: (nullmailer pid 3974040 invoked by uid 1000);
	Fri, 15 Dec 2023 15:22:55 -0000
Date: Fri, 15 Dec 2023 09:22:55 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add "data-size" property
Message-ID: <20231215152255.GA3798777-robh@kernel.org>
References: <20231213154721.5037-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213154721.5037-1-zajec5@gmail.com>

On Wed, Dec 13, 2023 at 04:47:20PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Allow specifying NVMEM device content size in case it differs from
> device total size.
> 
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 4fd015d402ce..095aed4250de 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -26,6 +26,13 @@ properties:
>    "#size-cells":
>      const: 1
>  
> +  data-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      NVMEM device actual data (content) size. It may be need to be specified
> +      if it differs by design from the total NVMEM device size and it's
> +      impossible to determine it on runtime.

'data-size' is already defined in 
Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml.

That would be fine, but it's defining bits per word. So I think it's 
better if we call this something else. 'total-data-size' or 
'actual-data-size'?

I think Simon had something similar for binman.

Rob

