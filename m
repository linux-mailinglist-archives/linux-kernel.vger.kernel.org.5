Return-Path: <linux-kernel+bounces-24015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83282B564
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB1FB243F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99D5647B;
	Thu, 11 Jan 2024 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVrfh2eI"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062C52F9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4199024276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705002379; x=1705607179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAi2GDQ+ThdQ1lT7Cr2g77YBh1JVwDL9p52yhtkQlNo=;
        b=jVrfh2eIfKUdq1E/b3tnplpCL7xWlTRv+kslpwK32KG7qYz3NKoKPIBJRUzq4Q9vwS
         ItqcvepuwkUipMhL/N64VaRQtKdc3+1Xebvmw6gLmmVfM7u7QFFNZYyw7dhhiMLCAi2Q
         TUxxDe+3R/QHRE4j0igvqWeArlkK3I5VCCy6rZ800fGpt1sSzX0IZHnnFekFqtOAKBi9
         RwEhgvtRJqskEiiw6WWju3iZMm+/Nwp+6mL2Ttq5mrNShAjSGl+oDntsWACuvJtTXeL5
         72GTHDInGV7Qah5qsTiYhbwhj5VfphHU8DNGcnNF72GPW322wV2AT2IS0MszH2g2iuZw
         gD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002379; x=1705607179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAi2GDQ+ThdQ1lT7Cr2g77YBh1JVwDL9p52yhtkQlNo=;
        b=iOpG4gvZLEl176/61dKUqZ4EWvlki2uMUYoSCD8FuT/2rjQpRDQ9535fet1qi7ZoYT
         PYVtT4lOyaTnPTfn7XL4YvOtfiD4cF5POdzrF0EUCpZVuGmhqJyEQEMBi4yKe31tgiqF
         JcArN/CepKpkit/PP5XmZFOOtGbr3UTzoCJZ5Xf99L/aoxrswAruV9oiuU+4ZFZtKPgC
         ga42vbIf8pSbjmPVMOGnz6H3ELRcy+QE1klst0QE4l80xdW4Fmcq8s/XhvGgdaQGWEny
         pz6g6aJr9IMgivMtRLDjfumfGa9nEmGPX95/W8wVLM2USWKG/KmGZcud3GIBB1nMbE3E
         fOSw==
X-Gm-Message-State: AOJu0YwmXXXvXKeIHs8/PIyCV4pGLga/ghOVFSe1qeWU7ofZ3Q4K7ew3
	w+257zVUCQUnsAzKDowyr/h3yFGhlobZwd2/XW29e6qIdAoLrQ==
X-Google-Smtp-Source: AGHT+IHO/hbJI7uHyCOMQIngOSzow7KSL8+obEwrYolSGuUHUtXDHtI5B5XmyV1xIfhs7xwpVwi2TXyaGiDh+D7cEDw=
X-Received: by 2002:a25:74c8:0:b0:dbd:b419:1ca6 with SMTP id
 p191-20020a2574c8000000b00dbdb4191ca6mr133118ybc.82.1705002379332; Thu, 11
 Jan 2024 11:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111150429.681567-1-martin@kaiser.cx>
In-Reply-To: <20240111150429.681567-1-martin@kaiser.cx>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Jan 2024 20:46:07 +0100
Message-ID: <CACRpkdbxbqPKQbkDECy8-TDXpLuA1UcUhJkozioECeqm75eq8Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: vf610: allow disabling the vf610 driver
To: Martin Kaiser <martin@kaiser.cx>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:05=E2=80=AFPM Martin Kaiser <martin@kaiser.cx> wr=
ote:

> The vf610 gpio driver is enabled by default for all i.MX machines,
> without any option to disable it in a board-specific config file.
>
> Most i.MX chipsets have no hardware for this driver. Change the default
> to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.
>
> Add a text description after the bool type, this makes the driver
> selectable by make config etc. i.MX chips other than SOC_VF610 can now
> enable the driver from their board config.
>
> Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO=
_VF610")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

