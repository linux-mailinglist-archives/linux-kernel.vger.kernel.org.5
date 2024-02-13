Return-Path: <linux-kernel+bounces-63926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2854C853677
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1D2B22EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF9C6024B;
	Tue, 13 Feb 2024 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5gDcq2Z"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985D5FEFA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842787; cv=none; b=o7FF4BjposXE/iFW9Lc2qFbaDyFzLkwrQXoESX72EDgZTDw1D4Az5wx1tcUIZSmvN4QhEj6VIKdfBTr5K9y+k6WMkKK1IXcK3nhS3oRlM0T8uujZb7blMNO0gRt3xGRwDZeXdmjzOSmKGFViiDAhD4beKiKHhqQtl+2Ovpm8F0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842787; c=relaxed/simple;
	bh=1ovtsfaMg8Lcn7chYH1W7UjE4PB2d2NiSPtnhsNJewU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uV6eSfQQGhviuLDmYDkh0GLqIfp/FvmIXi+b7V+uGfu+lcm3YAIP/83eGaLgTTsXAuwQYs1ae9rvHIsd0dHEXvY0x4YJk5QVoN1RCPvxwD1fJlezVg1MeMt9XG2UJyN/XtvkS+cGRZOlFHQ8ntrdwOzV30KnO2YzpWgC5UxPOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5gDcq2Z; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1661582276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707842784; x=1708447584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lExK6BFCXT7K47g38M6fcV4HVfSvaGgAkfoyjDKEgwg=;
        b=O5gDcq2ZL3rytJ0daSoAd6Qr7gfxYl3ggPXUWr+C8q2xGwIGkAs37SdJ5SGoTD5XYy
         Cyddt/fLY6QDatCF5o8hR2NkvwIF9Fc5Qnu1uVJ5nYkWVHNLpaM4FqyFdo+9GBfHR/X5
         2GuGjcPUlBNeiTFlRAbUmrokhhe6laQ+1aMI2Rgim0ibfFqOCa7tOEztzncni/5dWp5s
         NW7hmizpsV3cPKuYGLEpWxZantux/04u38R9wWhtK1BO+RQqXqW+v2wp90/RZCiFdV3D
         sA4cQ/rdfjSDmQiMCpqdbXpAEIpxMZKbuKIHrGQP43c3MP0tZGZMAgFaQ67EXEtMHgKO
         3brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842784; x=1708447584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lExK6BFCXT7K47g38M6fcV4HVfSvaGgAkfoyjDKEgwg=;
        b=WYoQefxuVAg4lNVfNH5Aba7/7KWaNSumYjjE68BrR+KHeAHS8EFV0B1JB2U1wr9G1U
         mOxbQ23sf3/8uTw+UjUEQqmXS7JxNL20eim7OFAGa60YNeB4+JtzcFjoVtGk9jHIq5S+
         wahWQoPg8EI2ej65kHGTJeZJDyy+LPLfPHcfVZKO44A0leRBK8DZVXJa/0OsGVxTx+LZ
         kv0QMft4kdxuep9r7QvOwQso/cZSBwu9xfv+F7ZxumCXpqjZ+vVW8tOoUJG8fhbhFvi9
         tMDvGD7OFRmyMrS0yU7pcLuHRaa0vhgEY27+sHLJm6aYArWIFBk616ONODw06ZQsb84e
         kdiA==
X-Forwarded-Encrypted: i=1; AJvYcCXS8YFYSXe+LrIs2eqI80Lv8jxYUJVZwTrZ6MSHoyuJEf9c6RMsatU93G0YXxBA2dGxAx4crJ0o13+4Ks9Lfoi39NMDvvcuUey1JAV9
X-Gm-Message-State: AOJu0YyWtJ+RtZS7N8nTqsqZgVHSkaSog4co70mfq3PC8XgFzL6GWDUt
	DMkHzfmv8J1NcPb/tMCJwkxJ46zBDL/biPbIMYzLhRWDIsNNntpw85aCK11t+BMHhtw8fgxVnUY
	ra5o+eUsbrGJCZcSWwC+1oPL9Iu0MAXW8JADaqt2QS93dAkor
X-Google-Smtp-Source: AGHT+IHRRooe3gtkPr1s5cWmjVbznagamZWAqd7ZtWG+qKZWax9GEcI3/kCDob2wpJ1buhzfIBS4wIQwi8pfHnYQwK8=
X-Received: by 2002:a5b:701:0:b0:dc6:18d0:95b0 with SMTP id
 g1-20020a5b0701000000b00dc618d095b0mr7312298ybq.8.1707842784564; Tue, 13 Feb
 2024 08:46:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208202137.630281-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202137.630281-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 17:45:48 +0100
Message-ID: <CAPDyKFqa8_j2-bxYa5VTzYTCqn9+Rm6X0KdS+F=NEwkqFu-5mw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: use typedef for dma_filter_fn
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 21:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use existing typedef for dma_filter_fn to avoid duplicating type
> definition.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index c1fb9740eab0..586f94d4dbfd 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -9,6 +9,7 @@
>  #ifndef RENESAS_SDHI_H
>  #define RENESAS_SDHI_H
>
> +#include <linux/dmaengine.h>
>  #include <linux/platform_device.h>
>  #include "tmio_mmc.h"
>
> @@ -63,7 +64,7 @@ struct renesas_sdhi_of_data_with_quirks {
>  struct renesas_sdhi_dma {
>         unsigned long end_flags;
>         enum dma_slave_buswidth dma_buswidth;
> -       bool (*filter)(struct dma_chan *chan, void *arg);
> +       dma_filter_fn filter;
>         void (*enable)(struct tmio_mmc_host *host, bool enable);
>         struct completion dma_dataend;
>         struct tasklet_struct dma_complete;
> --
> 2.34.1
>

