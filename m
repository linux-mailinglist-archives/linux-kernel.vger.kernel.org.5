Return-Path: <linux-kernel+bounces-71523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CD85A69D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8711F21C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F73839D;
	Mon, 19 Feb 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inQcANvX"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90B383BB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354521; cv=none; b=Yt1xlZzxIgo/rjBQ3XpKkROw3YhSq2bBs9WPNoERTi/9QL01Nz0gHAB/rEoxN31pb/OqaczvSOY5zCXqLp1qw8sAV7iBcrmOx6JlMCYEQphtIg0h6fa5aa9DMY00s+1oN0+olQOc+lYf/Uw9n4on2jVjgZYiyNBxEzFJfN3q+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354521; c=relaxed/simple;
	bh=qH5wXiM3i78ypS1cE2GuObYzdJP6nTn9QLDwtM+E/gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svujXZN8oP32t1hfkaaRvLh1wL1BtjouH0/cNwNBISrHZoPJNaogEdx1//7UNeo76Iz3xwRL/dltKsM29MPGP+ej1V8SnYkVfZxbcy6su0nD9IZy/Ucqom+IlxeJJjtpyJ2keBKIkmslWlYZlQio4rRaWwiIY+ueWkfDYchPdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=inQcANvX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607cd210962so36645607b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354519; x=1708959319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH5wXiM3i78ypS1cE2GuObYzdJP6nTn9QLDwtM+E/gc=;
        b=inQcANvXPuCuqHnryjl/iYJk9U8YX74QKTNoRgcSh/w3cNzWxiLg/phOgd7Tfz8l+M
         VSOksR+Auug9hFDV0A0XSvsSlwoMB/9AftArn1ydHjsET4v8TKc90WV1CGo3lRbuO2CM
         8zPFN2Atu7tW6mPt7Pn0W4PK9UYx+j8hQG4N424F79htcSecCIoTnBle/mWx/TvWB68F
         KN6ilw43mTQ+X9kulN3QOdJwdMVKjcf2w8PbOhRiN1gjez0fcrku3gpTKuQUOKyAJJYL
         V12Wzw3rmoOuVbBwGpZRAdu7wRE9znCPzDM+JSFW6NaUqySFNJp51p+S0Rjr5Z7iVruP
         KLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354519; x=1708959319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qH5wXiM3i78ypS1cE2GuObYzdJP6nTn9QLDwtM+E/gc=;
        b=jqassbhTvomxoco8G5KC/A02LS8cxF4+ELoakcVTz9dAoaSVgfngw5Y4SJQOfFocLP
         kAuujG72jO4qymOVImxMdOuUVy3rJTIzjLKIR8v5FwbQBPwXrjRxlMX/WF16t4Qmpfrq
         efsZZ29XCeHkXBCOs6sjBREZDbsGX4TtBLaFmdLvu17mufGnIOIzQex0SFi7RBAOSifQ
         xy4UsO9WM3w0kpv3LlhlgqcsCV3F/0GkSjmcCInY18173pPbsUKFOi7WeMjZDqmS5yOR
         DHlRxwO/S1aMfzNwn7A8Wvg5m+5+8aLHDWf/ZgmVOxnquVxpSwFdtLUwehXvsmdlTSsa
         RGDA==
X-Forwarded-Encrypted: i=1; AJvYcCW6GVQo80CVoISkh1nsSOTcsFHqU1qTg/Jqm6z2bmOkVF3ypgSErgsS/5MuPYHNVrvpuL/3IzGn3P7A/ofyPEgR/WHe9p7sP6PnFs9a
X-Gm-Message-State: AOJu0YzVfJM+5ZXv88kfcaixaerjLZhRMScD3sDyB8wmOSv03HHE24Sg
	Dp9jrBgSYn1XfK3VdI0MELZ/I95D9nAS2EpbuHZfxNIfPSQyJ2VMDdNGy7gx8llhQOQMdmk3l1W
	faZupjgroSxFoGAz74wpkMdejSxlTIAisZCyqvw==
X-Google-Smtp-Source: AGHT+IFltO6KkjBY25OUgoFC/Kmxadk8ahvUfaezI8PdV+xriL2Xe4U881DZubLOYqtDNDNARjLCAVm5NBCSj2rOXnE=
X-Received: by 2002:a05:690c:a8c:b0:607:a8d9:c29e with SMTP id
 ci12-20020a05690c0a8c00b00607a8d9c29emr13974595ywb.33.1708354519351; Mon, 19
 Feb 2024 06:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-4-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-4-f88c0ccf372b@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 15:55:08 +0100
Message-ID: <CACRpkdZ5v4GUJtrOV4U4bhvKC+RZFXk8LZdyN1cbxmm5mxcLuQ@mail.gmail.com>
Subject: Re: [PATCH 04/23] dt-bindings: gpio: nomadik: add optional reset property
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Add optional reset device-tree property to the Nomadik GPIO controller.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

