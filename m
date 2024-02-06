Return-Path: <linux-kernel+bounces-54623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B35884B1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC472859E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980E12D77B;
	Tue,  6 Feb 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNw332XI"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34E12D759
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213378; cv=none; b=D2d50ts7zCslqUmiVDXaE8/Y2DLT7b86WxdQQoF2RIOacdiRMUNvdfDYqke6jSXe7vxByKKzFU8neXDnCB12V3+Vd7FATZJMYGI3J1In69aYjlvpZFpvkUjBYjUyfuRaeq7wOCtmooF8YH9oIMiM3DyrRaAX7TRDbpX2NYRR2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213378; c=relaxed/simple;
	bh=pwU543wkEC4pEjHTs+niRFnjN9ZiwdPq48b+x0FBCPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQpNNorYBGgxcxyDVQ3Yat/JH8+1FsBoAXPt85Qqg+9vG7M0k7LlC0RYOrW3vFLMWUYgZc+z+M7fYJwy3by7jfVr3RnPSyVNy5Ban2ribrVcmYIPkz/Wmy8V8GzJuGpKnHhxgsULeQZmx6d4aRi37QmZpvOjYGjSBwLeDPHzd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNw332XI; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c7a26a5cbso2876986d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707213375; x=1707818175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMShq1kVjIqxhVRjaGYU4SJMpzxmIaFIwT3PC41eekc=;
        b=dNw332XIaoEHTnyiiMk3asBU5CHbddzHvxKV9wLeuItnrU4cNtduoGyNdd36GEdJkC
         K3CnLNDrnykRWlRm+USnYor2iY2Vw9p/MFMAG7BigFgvXnXDpN9atbjihgFjITDKxVVp
         GWbd14Jh3My/BF7yOQoUkXkjXdRc2gzqQ9TVlYgiLwM/MiVYRF6QO4sodB3OBjFT9H+h
         ZoI7kqDAj+LWDk4LtUU8S3adz+M4yzXfndyXVVnsh1QnDMdj4ap14jREpBZ5X/GYzYvv
         IPfP5CrbYFXq+GhE1IVc66+guvIGAusPwA7q8SKNU5B6cccyiK2yRITHySeD1SrHWE7i
         CRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213375; x=1707818175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMShq1kVjIqxhVRjaGYU4SJMpzxmIaFIwT3PC41eekc=;
        b=Pz+ap0hGblxLis3+Y+2dD4qrZm0vZceEn6HRAMpJajALz10VLhK9L7RtfBBiLg11Nc
         0AKWkazxaTghuXrbHAFEABhTxFKswLUfPeVIYvSQQX99CTC3NIozEj8bM4JEFd3E3ekv
         SMZev3nf1wNQLDemzQrziMRteXWS71g0yclomNOjtM3pM0HoJpeCuvfJTGjjS+FmNc+7
         BpmfbYtMA4pQaHZaRA3js3129tVVh7k5kbTiMG4NjoAPkA71ALUtPXnEIJiqiXEsjYDE
         5x06ylz5E0/muM+we9Ph5Ko322GoiB5ooVzXNBTnZUnIfkkhgEd5lauvQ42T5VPddMbr
         EyIA==
X-Gm-Message-State: AOJu0YxxmcIy60ToSqCvP+hwNh3FwHE24OdirnbJltetOUdrJa4keGwk
	JX6XDscQE3qEmwDJnSxzDKV88310YVBuR4vCW4IZ16LGQp0HLCy0vuQGit4OaNB3p5o1WDMBNuF
	poPRKIT7vVyaC9MeFHuegvnVwgGgXTRQ9FqrfLA==
X-Google-Smtp-Source: AGHT+IFSdhPP6seqkN3QxA7HFQZjJlBC9D2/9kKIGZd292r7UcQK8SRWFqqkFkZYfhENYbBAeL3ygtD/3krIkOa2XD8=
X-Received: by 2002:a0c:dc09:0:b0:682:bfd0:d79e with SMTP id
 s9-20020a0cdc09000000b00682bfd0d79emr4046715qvk.27.1707213375539; Tue, 06 Feb
 2024 01:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org> <20240206085238.1208256-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-2-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 6 Feb 2024 09:56:04 +0000
Message-ID: <CADrjBPr7AjCOi_sgzpJWRmKdyYkgB8Vcw0HW-e4VKUVh_yT6wA@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: s3c64xx: explicitly include <linux/types.h>
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
> The driver uses u32 and relies on an implicit inclusion of
> <linux/types.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 72c35dbe53b2..c15ca6a910dc 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>
>
>  #define MAX_SPI_PORTS          12
>  #define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
> --
> 2.43.0.594.gd9cf4e227d-goog
>

