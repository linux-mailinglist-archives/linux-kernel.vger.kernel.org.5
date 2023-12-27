Return-Path: <linux-kernel+bounces-12157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A7181F0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F211828360E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6C4652B;
	Wed, 27 Dec 2023 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzGoHFp9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4046522
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3370769018cso179004f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703696842; x=1704301642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2k46Jala0YD5NXcnApjOoFpSTHoD3f87rQws09hLIw=;
        b=gzGoHFp9a1HV/QLd3sH/NUuYAuiYe7V1+7SjPr0kEeyyxCGzofhwS98hdkxI3Z7FCg
         vhuEeo6LxnTTHyDQdyzuvzPyvnyA2lEw9QH+E3cP8qUCdn1JfVFuW7JL1BjQLYpO6t2O
         ZSR4pGAp1bZfMrbz3L+3Wl326xCTi6CSfsXxe7Cc0KqttkTEMMZKiX8FI1HDtxfmdpqV
         QkwCmeAk/5zLWchBOcH1wpBRRO1LGU0XMEN7E2Ulr4CJZsrBIEBYHXGG2pS+P8zvWwdM
         6inufv/KSWqM9Le2wuKSbq4ZDOMUVHmz8NgBp25yVR/FoUkupo4nxQbepR7woJ+pVv0z
         4+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703696842; x=1704301642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2k46Jala0YD5NXcnApjOoFpSTHoD3f87rQws09hLIw=;
        b=tdwkAqMYCZGxzIXnw4qXG1bUV8jZUaYTMsShzJ5XJWPrji9yduMzWlKFHJv8rf9zo/
         Hjx8C+qpVD66VKbnHyrtTzZ1/lhw2ryAJlLoq6Z90CZaLZbouCl2jmIGOKVyTbOKNmzG
         kbMwTQZZ7RjtHby+5tNS09DN6BpNXIiosVRO0MwslklRpaEtQVWA6H+1sfUAPS+hLw7f
         Z8JhilBE6v7HLXDxUV93XxpNJPwTTnabjSA96vbBpSIQKpC2FYILFVBFoTeuVypmuw0r
         4J6/SJvxbC6xsmIB9HEhVnu4xaC3hyeMe9SvJQNZYAx6iPhgWi1j3Rj/ig+WErju/aAp
         2rew==
X-Gm-Message-State: AOJu0YwciWiJmf6KI2v8b/9FP/cJOXvb7ix/v4fOAz/m9GesyxRgGDo1
	9ywla6h87r8BpnQmU5MBSWc2bXlewJHbjw==
X-Google-Smtp-Source: AGHT+IFvAsevyU4xuTWC10GqCxM3mAuzHSzSaJJOI3RedlJFny8RqTPoHWH6qQLeDHxc9AlBMUNMlw==
X-Received: by 2002:a05:6000:104d:b0:336:70ed:4cc with SMTP id c13-20020a056000104d00b0033670ed04ccmr5340760wrx.95.1703696842066;
        Wed, 27 Dec 2023 09:07:22 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
        by smtp.gmail.com with ESMTPSA id z10-20020a5d4d0a000000b00336a2566aa2sm10819534wrt.61.2023.12.27.09.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 09:07:21 -0800 (PST)
Message-ID: <0ed8e2c6-512e-4f62-b436-2ce1b898549c@linaro.org>
Date: Wed, 27 Dec 2023 18:07:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] firmware: qemu_fw_cfg: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel@pengutronix.de, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/12/23 17:26, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/firmware/qemu_fw_cfg.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


