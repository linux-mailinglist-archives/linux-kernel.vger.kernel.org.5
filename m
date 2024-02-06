Return-Path: <linux-kernel+bounces-54626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D584B1B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8CFB2227F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68712DD93;
	Tue,  6 Feb 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EG9HtWog"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1212D74D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213453; cv=none; b=Gn46bC1GC3oGfPk1oYqtwasBwqrF8/6HbX0Zsxa8UAOYTJT94yyfHMei8dk6IccA9i6KiIrg1lU4NFl/Uj/zN6pJqUcNEQ00QkbFqKfzUFujXgf9e4L6rJZZStFWtqtyaXZyQNoaUO1oDCeLU8m2uqW7NQjBb6qFL+sqq9JYXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213453; c=relaxed/simple;
	bh=NpPH85owZ20SCl7gPDrD1ciS1nl+zM/WUwZ0z1dCHO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7ETltSEOXKURX/4dWrATa9JeozimmedZhHzBOMpYz/YFySUbKWKt75+yhuzgd22aRuZawqYiBmMam4VqiorSiFTcByftNjw/P6H45MGHSHNQjlumauZovUaoaudgOvYtU3isVA/QZON3HuXVKo+CsmB6HLJIL7b88wgXOr748Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EG9HtWog; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60406da718aso53755967b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707213450; x=1707818250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq2wg0lmtUf7Y9KbMkjM4LSzECZ5og9xajY9d90SZeA=;
        b=EG9HtWogWkY3LttZ95TAM5ISxGu6ZbqC3fGmwfQAZQbpGGpXmIROgzJZcbqFzGPFlW
         3yVGcUt6o9UUa/LpB5o/WvUNqhlTLy+rMDzg5WjfJq6bYna/9JxiFxs1xkYeXm98mUB7
         RjOAI77umQ2omLoLOB+CKee5qFSxJ+ttbbIw6HH9SsneW6ZFTadO8Hdj/cpbZn+MR6Xq
         jioj6nuk9VvcBNRE8AqPFUyU7eQnDmzeg+FUZGIyKmfevtjbUDG3vGUAQPQ4ZJkhRpWy
         K9K+tGfvbSdxdWw66XsLf+DBaCaulj16nntdI4RBwt9VergnalW56yj9sU81mpkdOFy3
         BoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213450; x=1707818250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eq2wg0lmtUf7Y9KbMkjM4LSzECZ5og9xajY9d90SZeA=;
        b=Fo0SQ8caXxibgDcSyc6x98mjF09bh3tTiUf4fwnROMty9rC6n9u/qtKPJhWu7b8x8H
         rddtPWfUavUulqEnbzDf3XwecRHx+rxKevX1hdoXSVI8TnT25c8NqaqpXuwTOTUPWvuP
         aSBGki8Z5o8D++AD4TB3bMhSn7GCSSrJ6SYR3tec6iWhwRunupApO/Rg18z622UAQe/k
         v+QIlKZu0DjsKa1SNr72fdnWyQv07lJEUu53Zjm0AXSjy9Yh/y6PD2TBQ/jM6QAR1WCS
         rBYw2UUvzLaxtrxQ/69txQqbok6NVKrwvblwj5dnMT5wq2gvSqFH5lJ5lerswJj0sRjC
         W65A==
X-Gm-Message-State: AOJu0YzysV9xaGeUNLBBN3OSW2gGO3jP0ybVW9cPmYPXjSZZbpSJwKqr
	8uX+PZP5Wsxvgt0HOltUg1T3wCxShEVm+nw7khZgoNZio1yi0CPco8uq7kPc+OAw+B2DqTiJ+4w
	EmLga5KNmlOfh9/ui90wWIUHTbkLCbXrLKy1HSg==
X-Google-Smtp-Source: AGHT+IG5u0RUlCzKGSN5/5B0/qLQhE4mJ3srJl6aZpIRhRrSpKuDOaDOTP0OKh3xCd6YwxwgJxwWKTKO4NRUn/AvJf0=
X-Received: by 2002:a05:6902:102e:b0:dc6:83c:dce7 with SMTP id
 x14-20020a056902102e00b00dc6083cdce7mr1271773ybt.38.1707213450425; Tue, 06
 Feb 2024 01:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org> <20240206085238.1208256-3-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-3-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 6 Feb 2024 09:57:19 +0000
Message-ID: <CADrjBPpLB0RJO6xH=0+jvc=EnaNX6eCg2JV2DNkDdFAoS1mJQw@mail.gmail.com>
Subject: Re: [PATCH 2/4] spi: dt-bindings: samsung: add google,gs101-spi compatible
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 08:52, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Add "google,gs101-spi" dedicated compatible for representing SPI of
> Google GS101 SoC.
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> index f71099852653..2f0a0835ecfb 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - google,gs101-spi
>            - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
>            - samsung,s3c6410-spi
>            - samsung,s5pv210-spi # for S5PV210 and S5PC110
> --
> 2.43.0.594.gd9cf4e227d-goog
>

