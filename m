Return-Path: <linux-kernel+bounces-59494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C9D84F7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9503C1F267F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E906BB36;
	Fri,  9 Feb 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDj4fRU8"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F14EB3E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490354; cv=none; b=qUxHQhYA/y2jorwzaiOfaGfs5/PU38j1b9ihqXWe477uySSnknl1WquVQFuag8NXWkvVbKsHKNHdjET3cQ/6JyvbjwLZjxhJJ2c1jz5VX1jg2tUOzGdHXK287FwxEM7V5hx19xd06qJPq7HS9kfyW8nnhOswP07lB1ahX+4ynK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490354; c=relaxed/simple;
	bh=byUSXn1CBT+qucWO0Diq0c+JAjJggUINmXXOxd3wzhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njPnY3aVDjaoApBKoF63WiFmAJq7oG3rnc3VkSDwRi4aAnS4SpUavQAWZegODc5Xi/rouRBkyMKf3jKs8jViWV6X++sPqKiAbcqCbQaDLKoWS6ITF2f5ehcjAUd8FIygc0iw+ehIAGnUxHdYHNys03wvvsngyWzHKscgTtw54H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDj4fRU8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-604b23fc6a7so11532217b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 06:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707490351; x=1708095151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvSzfugfRa5xaGbubugy0cL8Ne5sgTH61y58yWXb1N8=;
        b=nDj4fRU8OAuuqqxq4bCapaC1rIrLIER9v4Au8Rg68yXQoVBn93fxTDAWddEiii9cYc
         xvPK7mjRqjPKz6r8rooplmyITClcPNecl6S2eeb9ZJvzzvctFRqoJA2s4G4JCedtiJQz
         KnpSQyxYpP8Ss5mUcoHIcoaiUFN+cdvS/quW3VrAcIKFTV1jLbkZfmlH3VdG3LlZYJna
         i8emUeH4S/Q1iFy2NcPO2SNFMwf1HzTQ6xXfs2I7bMedq/i1hfBUXAaUY4uebcUz0lkD
         GPMyLvt8pCNmZSM1tm4Jb3zoag49O8b2RAhfyjayO8V0glKu44HTL0sRiS802yjQQL2o
         PoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490351; x=1708095151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvSzfugfRa5xaGbubugy0cL8Ne5sgTH61y58yWXb1N8=;
        b=TkvYG6y7xPlLVsuQ0FtTyjs/0PuZeZ1kWILNfCd0QONC/1AwIC88X57R7LXR+n5ZEN
         gmGTDRrBjOedH/Zt82McCbMsKWVsjHbQ1wQlzWSLhVAYyv6YMRcFNyHhgL0kL6j+0dvf
         6qyhQSmFXtpQ7FHByjBetR6Qfdw9A0LLJOg8bxy/rlPv8Ot2JB6Z7HOY7fxM9NObigwQ
         lSK1aOZ4mIml829uxrfipMwY2Bty52PwlflTo9nj4+WMmQrJRPMxXsy+u4GXzXDyF1K6
         l8HFUg0EODeN0oIxIpGJoJ1rFProjH4edvNq1O5uvkJ8rqFzp3CHkqMLJY+RmtuPfOjS
         rchg==
X-Gm-Message-State: AOJu0YyT0sLcfdWOFTbaz7In4R+D23k411FEiv9bJjkVVXx7TFGg66Y5
	TIMnGwaEBiXmmZJB079iQ9+J/YT4GNGt+JeOptux6Nnl/II1Vm/tZsbCBY+CJAJZLzO9Ied1O1F
	A4fbPnY8bUuzd6uptBynRTozAdarRi+TxTZg1zg==
X-Google-Smtp-Source: AGHT+IGNGpV2dAOJ1roKWNaPkfmJ7IwBlppVZizxMiwadARMvHVBZZR+vznEFtx+LiP3R/KfEq3g8Uhvd7c0h8926OE=
X-Received: by 2002:a0d:df16:0:b0:602:b21e:876f with SMTP id
 i22-20020a0ddf16000000b00602b21e876fmr1761503ywe.0.1707490351229; Fri, 09 Feb
 2024 06:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208161700.268570-1-peter.griffin@linaro.org> <20240208161700.268570-2-peter.griffin@linaro.org>
In-Reply-To: <20240208161700.268570-2-peter.griffin@linaro.org>
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Fri, 9 Feb 2024 14:52:20 +0000
Message-ID: <CANgGJDpJX+ji1U3SN+2Q21FyckFQhmwb-Z2Qcx4-+GQ2ijmfCg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, krzysztof.kozlowski@linaro.org, linux@roeck-us.net, 
	wim@linux-watchdog.org, alim.akhtar@samsung.com, jaewon02.kim@samsung.com, 
	semen.protsenko@linaro.org, kernel-team@android.com, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-fsd@tesla.com, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 16:21, Peter Griffin <peter.griffin@linaro.org> wrote:
>
> Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> security hardening reasons so that they are only write accessible in el3
> via an SMC call.
>
> As most Exynos drivers that need to write PMU registers currently obtain a
> regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
> is implemented in this driver using a custom regmap similar to syscon to
> handle the SMC call. Platforms that don't secure PMU registers, get a mmio
> regmap like before. As regmaps abstract out the underlying register access
> changes to the leaf drivers are minimal.
>
> A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> that currently use syscon_regmap_lookup_by_phandle(). This also handles
> deferred probing.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Tested-by: Alexey Klimov <alexey.klimov@linaro.org>

Apparently it seems tested-by should be provided for both patches. This was
also tested on odroid xu3 and I also have WIP code that depends on this
SMC-based regmap. No issues are observed and behaves as expected.

> ---
> Changes since v3:
>  - Fix PMUALIVE_MASK
>  - Add TENSOR_ prefix
>  - clear SET_BITS bits on each loop iteration
>  - change set_bit to set_bits in func name
>  - Fix some alignment
>  - Add missing return on dev_err_probe
>  - Reduce indentation in loop

I no longer see the compilation warning related to struct device_node declared
inside parameter list with v4, I guess one line change addition in exynos-pmu.h
does the job.

Thank you!
BR,
Alexey

