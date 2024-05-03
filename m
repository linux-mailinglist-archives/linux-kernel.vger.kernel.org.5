Return-Path: <linux-kernel+bounces-167405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231FA8BA916
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FAD280E56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53F14F9DC;
	Fri,  3 May 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJiJaRvm"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C314A4C4
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725777; cv=none; b=bB4uU2qYRPuxTvQ7owMuJXP4gGRsRqLI/byrf54Y0oq+XvnwP++UZRYvM7t5w+LQTc1c6piK1Df2aGwhZEeBf5wYu4YfOOgc8BQmgZJb4Do53/Rdb5+lqOJMbdua8sAgoxWykqS0uDX7LNXhSREK9xuNhU9YEsJt+VkqJqSEv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725777; c=relaxed/simple;
	bh=l81VDrHxsffA2WCs1rrMOjTKK1OAEcxAypMYEy0ovOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVWNxiU59Vt9hpfOqo2ZM7aP7FmR4d1Hx+EkUKKG1MMU8ThSpCPxMBqgTNnOx9VdOKu1eWblpuHFSh3lA+jGy5Rdh4NFcZz6CLGhPjVfGoSsD0uEOwYWe1Q6ElHfGGbARgTAk5ET9OYhBjJ1GRYYqQRYpOPSQfSK//ypPHfyDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eJiJaRvm; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61be4b98766so49351437b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725775; x=1715330575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l81VDrHxsffA2WCs1rrMOjTKK1OAEcxAypMYEy0ovOY=;
        b=eJiJaRvmxNaZPX0kTSDWdnC5BQ3dnlSzDiL6AQ1yzeL+wdcotruyKYEfLY1NQKSChg
         /HZ+LzeqTvFmlOL/Bt6pgNa+19su4WAu6v/D++8BF13obL7OCdGmBbW0jW9rmBlSlkjD
         gXJSwA2jQN2bXn1cJ5PBrONjqOWhyiSfZgqD7e6pHCVd/s+Au4ZAXkzdjpms/sjDfc9Q
         qbhdNvVGNaSSLh5NSXR31vkK5+p0xUOLcbcbZ4O7xIVV7vOCsyror9im69c+UVe7gX4V
         CACc4WmRLXtJQGH+Y2lVpZ9W1yzooY2vIUvq98sAPaSjL8awAdrWqZZXgRnZh5Vygwnn
         Q1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725775; x=1715330575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l81VDrHxsffA2WCs1rrMOjTKK1OAEcxAypMYEy0ovOY=;
        b=ojwTwwvjrHmm39ErSMusX1Ea96l6jyAGW+Uo9/rB8xW8QLy4e7aFwURTcjXgJ7PSF8
         qvrU/HrkAXrMPDfZynwaAOdaF+D9/DqCJWU2uIhYR5ryVoPL8BXWCifSbuwiiSPFSckz
         fFHiDH3NQA4UfF+5YVFTUfrv7mHBizh5yib+hJCfmtRH/ilPsoE41D8rhEq1clCmTujy
         2RozoN43FwIzykuKoncRL7vIPUj3nx3/EYaOpu273N3sMV7ENdD6kam+IAIk85KOeMRd
         byH0sTBPyEJCzFvAxMzT5q4UDmZsZ9XtJMZv64th+dX2+yA7kQFiKVwhnDpourHOdzar
         9ynA==
X-Forwarded-Encrypted: i=1; AJvYcCWRFx93m9a5WNskFUT3CaL+w7ahkB6B3/S7GsNCbMOsXaFZOPHB6Su2xJP8PEh3MyqKfaUaYyUJKlDFnkIvq16OD11pyfthkpSYptYx
X-Gm-Message-State: AOJu0YwFgxDuIGA/uxf9z85KU3CMbtinVDT8bKqs1s1LlFCVaxZHZOnE
	Ri2aMfxtsWzKJDgqNxisnkg6DoYZARycQwQDns6xGo2cTsCxpplKzF8uZAWtytxMkRCGtXJtrKL
	WRzbKMiqZfSfnfkL1sRv13jf4PTYoVNNi5mBf+Q==
X-Google-Smtp-Source: AGHT+IH+xM1Y3m2/Fg9Cmc37kiLV9wltbt7f2AaSfD4H+YQIRzjErYhT3Ir8KdVsSLZ1dU5gJ3R8la+SgTZXFWbPKBY=
X-Received: by 2002:a05:6902:250e:b0:de4:78d7:3ff9 with SMTP id
 dt14-20020a056902250e00b00de478d73ff9mr2676714ybb.29.1714725774825; Fri, 03
 May 2024 01:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-6-ilpo.jarvinen@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:42:43 +0200
Message-ID: <CACRpkdaG8CYoGbEa1AG0bByd-oTWcnfKChn2F1QsdnUHLkoX+g@mail.gmail.com>
Subject: Re: [PATCH 05/10] PCI: ixp4xx: Use generic PCI Conf Type 0 helper
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:47=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> Convert Type 0 address calculation to use pci_conf0_offset() instead of
> abusing PCI_CONF1_ADDRESS().
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Looks better indeed.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

