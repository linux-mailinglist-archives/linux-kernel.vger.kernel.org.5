Return-Path: <linux-kernel+bounces-131255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2AA898557
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2891C26463
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E38004D;
	Thu,  4 Apr 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gN/cpNZt"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880A8F7D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227626; cv=none; b=mq99E52vqsNh0DBv8KRKRRN+Ap8qbtTZSS0jXPiCBIQ5MyZNRKGQGRpWeTDyiRe7bL+bHTNHN0eeZSuVFsyJJbNDmLpMfmCz/3n1+qaz2i3hRF2LtNyVA6S3nsOaDzbdvj3NPu/rQtEoN4uS4wNKeiKRhCrHB4HRLOqUNs3Z+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227626; c=relaxed/simple;
	bh=c01EuYyZ3SiHskwBzOJ+kOOtzarjS+3wqSXsqxO128w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbKDMZg0FOFbSNYgj62V6aPn+94rJWKKQIKJOAfr+y6UkEItlLjVAvKYur/qw4Lf4kvAbMT+8yjmERVF/iYEoTxLRpUFQb0AW0UI8kqDeyku2xVasY6Gj1OTzOZAPU7HrLh2UtGZYX2zkon6nHeg0r+bY5JYmNfNaHWopOTC0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gN/cpNZt; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so799402276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712227623; x=1712832423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OLGHTxDGXllhjSVr+wpHbh0zVlIAwon7mEvnonKBt0=;
        b=gN/cpNZt1xzI5Qt7W9riUkBX2lF/5yY2zwiavdC9N2C/pKG220qmZMxbcTR2NK276r
         QwX0iA2XAHbA9F8/v0PvqlJrvx7a4Pf+cllw7jPFlx7qFG+TQk0bEh8d7HKrNU5ApcKd
         JkT80C9o/mlKG/hCZP1CffGSvI1cX97pvVT4hpQj/JhdAxj3eEZDbqk1T+nyUmgNESW2
         0pO0g9ay0GjvxiqbG2aUnB3ep2a10JO+mHO0XwBrbOYPCjRP+DIxABlmhZD2Zke0uFQ4
         J8g/CoB8SUp9hgP/JZAUNRwhaKqwPIVh6+OQcn6mM/h2cq+cNQK3BrbAp7DIpciT+BqL
         nDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227623; x=1712832423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OLGHTxDGXllhjSVr+wpHbh0zVlIAwon7mEvnonKBt0=;
        b=aLDhZUISiEYuUlL8ZLrN9xIUhTnN4Nd6XinhslUlIHR/LSy7kwi/uXuAAvFuxyL7H0
         hEgoKyWXkCiMrxrmW2Q+JP5NRhvcUl01FTeZd1PKqPMZolNnhc3YrAyn2XUvnXgv9zxk
         6U1Mpr0i34OeVN38/uVGrBFU8JNuITqHVo5s8YC9sDLDGtpTROjlE0MhM0zYDDr3JoNt
         vCkoyo4zcESjnitwOU9PN0I0gACO0YBFk356WiKqKLlp5uZikZkNAEej6FuQirwwJctd
         JG4A6an+2/qUR0Bp7hW58MtvCUflqRy8H5Z3UzHzprNOgzqcGMBBk1jsC4KNtrd9swIE
         EAQg==
X-Forwarded-Encrypted: i=1; AJvYcCXPHJN3mAjuKfZpu0BWWJ4c7gyDG+lU378ytAjAFNyEiEIIeKU+XRCSvHQ6TQ6syjpYhK9Yy8JaGU884f26LVdFmbuydBelUOZsLyEx
X-Gm-Message-State: AOJu0YyCHRHO4T1RHrH6kWyQdDEI/LFxBs2zdiIc8zSFz9Sudgr/rSDP
	5nNXDpkTCYwnKkwfTm6SCTIoLiwsIU6wLSF3y1uJbKge4JEPr/WzSqa3k2EcqY6o4JjQyhcZei1
	W0lZQtN1Yg5xhDuxR1nH7jR2gG0KAUBdem5kRLA==
X-Google-Smtp-Source: AGHT+IHb2ngWJuGXnRgC7Jjqe2VL15KZSHlCl5aI2amVAv9f9Jw4owxwUzrf1g3jQ6SJX9boCj6Pb0Kb6Mg+LWoz51E=
X-Received: by 2002:a25:d045:0:b0:dc7:4b0a:589 with SMTP id
 h66-20020a25d045000000b00dc74b0a0589mr2041087ybg.55.1712227623549; Thu, 04
 Apr 2024 03:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 12:46:27 +0200
Message-ID: <CAPDyKFoWO+xUsOb0xDge62kNYu9v18eWBAZ=RgLjWJsgvqMWtQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: scpsys: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 22:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-scpsys.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
> index 59a7a8c261ed..1a80c1537a43 100644
> --- a/drivers/pmdomain/mediatek/mtk-scpsys.c
> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
> @@ -1138,7 +1138,6 @@ static struct platform_driver scpsys_drv = {
>         .driver = {
>                 .name = "mtk-scpsys",
>                 .suppress_bind_attrs = true,
> -               .owner = THIS_MODULE,
>                 .of_match_table = of_scpsys_match_tbl,
>         },
>  };
> --
> 2.34.1
>

