Return-Path: <linux-kernel+bounces-81874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883EF867B45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CF7289F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5012C81B;
	Mon, 26 Feb 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoRS2yBQ"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768A12C55F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963944; cv=none; b=dkXC8Js0XRpTqQXwPqGmfKkpLr4BZgH03C0yQXrktMgo5tVJ47Tsn1CWlTr0hXyK7zqijFE1rI2Er9spn6z/anh7ER+mJ8xWpJI7h0ODv7HhRWEJ1A3F//9E/2dGgLI1149G9l/2oRz518TdEEM4A9+T5Ci/9/pftU7YPwYO2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963944; c=relaxed/simple;
	bh=a6f7tH+OqrI8hsygIm05fQcRkKGxUj/pum2GnIuoRvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BExbW09Htn+UQgwGOJ1EMbLNEfUTddiMC/3aNlz7rgY818IOLxPw70dN+c6/y80FarFpy6eKt133c1gBaHHBDBxrtrb4W4tvjXcS2N7D89NboAEFL50OvZg1pIbIJ8vajXXuV3HYlXYIfyrL7c39K/pISnwt66d/+BQ4PwEJu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoRS2yBQ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a04fb5e689so1665978eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708963942; x=1709568742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5sH6z9nrzqVNTL38OQhoDAwWJzK93pXYFPgmQuEUCcY=;
        b=BoRS2yBQ1FIjCzXe3Am2ozDjd3R7N9NAiJC1hWk9JYXOnorAh5dgaVcrrCuX3qzaAb
         bmOWwsK+A4uJnnUfIEoe4BYki7CgvY/ejWPgaB7Dw02NDMsmqwRenfzVpUmm/H/EpDW/
         I/PjgplIDH5Ld/WFgRp/hihvBa3mwqwiS6Iyizq1zvc40oE/ir1RsVddHzl1cQFMmXDE
         WOA1XJqA+nMW8KNueKX64MqlWrHnP4kl2Z/aHcRIVOau4X7G4RbMAqjdDlHLH6lsPK2+
         XqMRfNbdIDn0WS5LBRF/wndbTKXPEA6gl1UaIbQw1XRHQ8tZh8rgTkweQ8qKV6cpzPhA
         +0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963942; x=1709568742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sH6z9nrzqVNTL38OQhoDAwWJzK93pXYFPgmQuEUCcY=;
        b=j/t25Dl/uZysb9ov3WERj2P8s6uDnOvUwEuHX5i0GahlQr86tmyXB8ZtPCGnGRznkz
         Z891z9C6rIyX0ay6Q5wr9K7X49AP1f9k0+rSzfGJYgra8vU2h7z6dYG+OqZuoYo1Trv5
         +ApgrjqU3If2H9Dlyzr8CVdwsLonORJanAG8pCtXUqbaF9bjb0ltvzLkoK8GJndOec6j
         Zyq/YITuUph4p5veMSqhqwVIFtqbvvyD/fvD9WyZI3ViSd4HIWXxpn/pIsFyEqnDf1xt
         0+xEIypPIo1aUOFW4FSUDliDRhw5Gymkds0Dn5gsq5gIf2HXqFvoWdNvMMFsTWLlryK+
         mSqg==
X-Forwarded-Encrypted: i=1; AJvYcCWldqriY6XmNu35uESpYmzMiZJTZt6khAlJDlokVM9tD7umIf1R+LPJbY1KnUcEI6mYFuvZ0yb+gpsFzF28GWbonriMrTSzHkby0UHn
X-Gm-Message-State: AOJu0YzjPectfb1n7hyxnvTOdKX8qkQoP9K5D3HQFT3+norjZ8nShq6G
	ShmoN8rR9sK5OHUOdxwOMLzuG7wPpmWrjoLQRwHIVfRdeQoqM3NBmCEONffXZ4Y=
X-Google-Smtp-Source: AGHT+IFjUb+c/fFWRXoZFCN25O2SmDpaUNvFqFasQHJGd7CEyCqvLCJr1Pd5sypoEjZ6QljgaKYLNw==
X-Received: by 2002:a05:6358:6f0c:b0:17b:b532:80be with SMTP id r12-20020a0563586f0c00b0017bb53280bemr1375921rwn.25.1708963942241;
        Mon, 26 Feb 2024 08:12:22 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:360c:e16d:91ef:5fec])
        by smtp.gmail.com with ESMTPSA id d18-20020a63d652000000b005cfbdf71baasm3591736pgj.47.2024.02.26.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 08:12:21 -0800 (PST)
Date: Mon, 26 Feb 2024 09:12:19 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: ti,davinci: remove unstable
 remark
Message-ID: <Zdy4YwD9LNmq7hth@p14s>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
 <20240224091236.10146-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224091236.10146-3-krzysztof.kozlowski@linaro.org>

On Sat, Feb 24, 2024 at 10:12:36AM +0100, Krzysztof Kozlowski wrote:
> TI Davinci remoteproc bindings were marked as work-in-progress /
> unstable in 2017 in commit ae67b8007816 ("dt-bindings: remoteproc: Add
> bindings for Davinci DSP processors"). Almost seven years is enough, so
> drop the "unstable" remark and expect usual ABI rules.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/ti,davinci-rproc.txt        | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
> index 25f8658e216f..48a49c516b62 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
> @@ -1,9 +1,6 @@
>  TI Davinci DSP devices
>  =======================
>  
> -Binding status: Unstable - Subject to changes for DT representation of clocks
> -			   and resets
> -

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  The TI Davinci family of SoCs usually contains a TI DSP Core sub-system that
>  is used to offload some of the processor-intensive tasks or algorithms, for
>  achieving various system level goals.
> -- 
> 2.34.1
> 

