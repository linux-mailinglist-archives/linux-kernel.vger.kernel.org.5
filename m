Return-Path: <linux-kernel+bounces-19218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5FA8269EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DB01C21C46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2BCC2C6;
	Mon,  8 Jan 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNRuyPD5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7AA11707;
	Mon,  8 Jan 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc00dbb560so1123321a34.3;
        Mon, 08 Jan 2024 00:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704704177; x=1705308977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FK6vgQf4XgzGLbd5nK4twLsrJfHIEMPJn5oCiEcqiCY=;
        b=hNRuyPD5afSzLVjCU7BgV8eELzBVMXBdjbmencBUw1s7UZwelwjP9fhFgTojEJl87g
         dpd41toCR96JyzJN51WxdV90HbvvApDRk7G7j7U0mZBVIYT+C/tmwB219nYMiRChCFou
         n4a4/AIQEPaAGjJUSRt56C74q8bafWsD5Ws1wAkW3GjHl4MsPgv15wUPRQgBkAnYC9wl
         h7fy7T2aRW+EBpDK7nS9EZkVLWiAA6sWf0P+bAJrUxPbzA2DUhmNCiKGUkUy/c5RFzgR
         AYMWtg1muMjsCVmBkrRvJcxRlrVP3qWvwGHSOVppQYLxvfXqsZgKhJiHr2kG7H/cYPR4
         jlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704177; x=1705308977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FK6vgQf4XgzGLbd5nK4twLsrJfHIEMPJn5oCiEcqiCY=;
        b=S0WSMfvinn6FV4BzUZGyHk/dfyQm9g00OXXveFuE0/O2bSsqJOe0hl+DtBhyWuA8t1
         UMxj4+Aisys3jET9gu5kgo5s4KM4kNR89bxLx5PqBIIr/ooAZW0NMNTtLtykAT3/gb+o
         M9rJ0rxf03e1j2nHpgmDHPPVY/zfUO2e9Sk3dw3YVIZ8L64/gbGl2J4K309CpU7OzCZP
         oLb9JeMBUq3v0KS/L2ySiYLa3xEdY6V6o2i+9iZYOyiA/xY3qt85YeasfuOEXFu2b2ev
         DHw25QJudqWxaCbYPv6O4PscTfdVq3UnLdqdEZkRsv+8uT8eJcNocwFLLDa/3eUa1ThG
         FuLA==
X-Gm-Message-State: AOJu0YxZwvxkn9eI4Utp9WmR7j66e2RRdhdP/qivnARd3ykjTsRIyRBa
	n6AAzpNWf/aictMGk3o8xyoVfCjjEAsIjIdLMvOQVur2UGk=
X-Google-Smtp-Source: AGHT+IHhdPsdFsqdafNMCOhsYr+2jPnyM8QmoF+JWRUpzlchL+vrJz8en44SkrwaqnD0aVkcoqxyy4FUnvB+2MNhHwI=
X-Received: by 2002:a05:6870:e8c5:b0:204:4d6c:e282 with SMTP id
 r5-20020a056870e8c500b002044d6ce282mr4814703oan.20.1704704177068; Mon, 08 Jan
 2024 00:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-5-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240104024244.12163-5-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 8 Jan 2024 16:55:40 +0800
Message-ID: <CAAfSe-u39LWO6A3sALHZqW8fVyiVBuus7ncVRq1RV6mWSgB5uA@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] gpio: eic-sprd: Support 8 banks EIC controller
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 10:43, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> In order to solve the problem of insufficient eic,
> it supports 8 banks of eic controller, each bank contains 8 eic.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 1ca3c444957c..715c7d581d7f 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -52,10 +52,10 @@
>  #define SPRD_EIC_SYNC_DATA             0x1c
>
>  /*
> - * The digital-chip EIC controller can support maximum 3 banks, and each bank
> + * The digital-chip EIC controller can support maximum 8 banks, and each bank
>   * contains 8 EICs.
>   */
> -#define SPRD_EIC_MAX_BANK              3
> +#define SPRD_EIC_MAX_BANK              8

This change seems not backward compatible.

Also this is not flexible to support more SoCs which may have more
than 8 banks (if we have this kind of SoCs in the future).

I would suggest adding a new item like 'bank_nums' into sprd_eic_variant_data.

Thanks,
Chunyan

>  #define SPRD_EIC_PER_BANK_NR           8
>  #define SPRD_EIC_DATA_MASK             GENMASK(7, 0)
>  #define SPRD_EIC_BIT(x)                        ((x) & (SPRD_EIC_PER_BANK_NR - 1))
> @@ -627,9 +627,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>
>         for (i = 0; i < SPRD_EIC_MAX_BANK; i++) {
>                 /*
> -                * We can have maximum 3 banks EICs, and each EIC has
> +                * We can have maximum 8 banks EICs, and each EIC has
>                  * its own base address. But some platform maybe only
> -                * have one bank EIC, thus base[1] and base[2] can be
> +                * have one bank EIC, thus base[1] to base[7] can be
>                  * optional.
>                  */
>                 res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> --
> 2.17.1
>

