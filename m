Return-Path: <linux-kernel+bounces-74739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9C985D879
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2014A286FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0769D32;
	Wed, 21 Feb 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OItDn+I8"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AE69D28;
	Wed, 21 Feb 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520140; cv=none; b=r487BegsjFckpQbR9q4vxvR3XewH9wG5xCzAN3m/XO8Mb8bbQ28SJxlr0Z0vwaViuFk0Bw79/m7Hsb+yUPqFw3DGNvh9EBTpIWxE9fmRJGNoNZzBKvIlAgEN0cpRQseOBM9XEbSV6bC5NOOX4QrnhdxjRzpugVbTI6khCC4TNt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520140; c=relaxed/simple;
	bh=BLO3yH1f9XYAxLZPnPfV2ATOOxsVqEcXjqOx9jWDsWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBruKKbrwswDB2jQpzj4dgI/DD3u3iiSU6zilfC94FBQ2rOE0KUGyaHogVDKBVBvSFs9eM1YHJzaYyet7VVOMo3ggnE2s4f4zSvgx/lMrfZMcrfjbNOnshgJB6OZNdF4jWONWV4NVrd38B0dTjtFxE7nMj+Urnrhpfj1wxIFh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OItDn+I8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c66b093b86so5476161a12.0;
        Wed, 21 Feb 2024 04:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708520138; x=1709124938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPjLDm2Lg7w6b61bovpX2e/7PuAoyyIn9ZUIR2lJePM=;
        b=OItDn+I8u7NdTabUEpli9S1rXFMX+ddtxVBQuEz4pyxYTBYLOR0OxqF118boazZyVE
         gRXSF4mb5mYNKaKJafYK9rLeiiJryyw04Tdh9Sf/LSHI0+/U1fEKacCAUk4huN56U+RV
         xNAvKp36HwUVAokrGa6ppRlUh38QY/9rr501eU7G8emj/ow8YnrZE8GVKNTKT13+uVFb
         8EgYYBdpG8JiNQEqOs4bn36LA3a/KlM6VflrbN0tSUhqfiCnqM9b8vXM3Y3kHiuNAvkr
         PCtQhV4vJGTPyxcN5EOjeyHmT0SZ+1pBR74q+a3HROEe1zbmtlvwTgAw84LnNW1bZCxE
         9PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708520138; x=1709124938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPjLDm2Lg7w6b61bovpX2e/7PuAoyyIn9ZUIR2lJePM=;
        b=HyqqkytXg+NDLSG+c3yJmQ/P5hJ7/MJm3U6YFBak9f2fJYRSasqp7PMX+7vTCwf33D
         RwcpQTWBp9ppNcTaUq7W7XgZSxarUSkgIE+X/Z/rnGpLqeaKPMISc6rlQhP1DPEJY4k1
         fsfRM/eENCAmguFkE6HpUmAE7z9l1vpt3CF5KH/g/de9ZbQbWytBcmxH6m+Xnc2gb8F5
         HddjksrcOvgYgQ9bujz9CYgDx153HeVCjyJiMr+MKnxYMzp1nxwBhEy0QxF7iHq66Mbe
         m1zVzQoyNYVXYuWsYZLcjTlV77wvDRq3/AzNfOTZIJWhISFjGkv58r1sTupse/A8DqLe
         k39w==
X-Forwarded-Encrypted: i=1; AJvYcCXFjnpOMR8HrKG40EVgIt8DZRE3itGb9WIoMzKxNp9ObKAmQbtMa8hTZNw35piM5cSUc1EzYkC4wD3WDBvWXC/mhEs6CFErsgMlj3I/DRPSdl/jBAn8rScSfpVhrUqDJBab6pL0H7TN+A0jj5w4H8Z1oB6FwdlWicuSmTvELEZZ/lzG6ccKpXzK
X-Gm-Message-State: AOJu0YwXgJPSeOyA5ltsHNl62+7RlzeDs7pzbCvW07c7N7Q8D6X5KRUm
	RvoBsCkyU3IMg5i42hiYppDLSOuwx+BSL7hCNju1iOOAijQTwHl1
X-Google-Smtp-Source: AGHT+IGfpm02vM/88+RBjjwQJMRoSGI+3sE4KhUNggbX0WSLf6NK71qWGwEWztczL7y5Rxk+TEfzzw==
X-Received: by 2002:a17:90a:d152:b0:296:f2d5:6567 with SMTP id t18-20020a17090ad15200b00296f2d56567mr24073274pjw.4.1708520138041;
        Wed, 21 Feb 2024 04:55:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qc17-20020a17090b289100b002993743e4a7sm1635413pjb.20.2024.02.21.04.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:55:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 04:55:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: forbidden405@outlook.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: watchdog: arm,sp805: document the
 reset signal
Message-ID: <b28acf81-75e6-444b-bd4b-c67f2bbd980c@roeck-us.net>
References: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
 <20240221-hisi-wdt-v3-2-9642613dc2e6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-hisi-wdt-v3-2-9642613dc2e6@outlook.com>

On Wed, Feb 21, 2024 at 07:56:42PM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> The reset signal needs to be deasserted before operation of sp805
> module. Document in the binding.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> index 7aea255b301b..bd7c09ed1938 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> @@ -50,6 +50,10 @@ properties:
>        - const: wdog_clk
>        - const: apb_pclk
>  
> +  resets:
> +    maxItems: 1
> +    description: WDOGRESn input reset signal for sp805 module.
> +
>  required:
>    - compatible
>    - reg
> @@ -67,4 +71,5 @@ examples:
>          interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
>          clocks = <&wdt_clk>, <&apb_pclk>;
>          clock-names = "wdog_clk", "apb_pclk";
> +        resets = <&wdt_rst>;
>      };
> 
> -- 
> 2.43.0
> 

