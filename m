Return-Path: <linux-kernel+bounces-12861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F296A81FB50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C971C20C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631410946;
	Thu, 28 Dec 2023 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZezu0yz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE106107BB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbd4d2b4aso1717105b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703798036; x=1704402836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czhsa2PHtfkuxcfNIhOkDR+827hn+j9Ys9y4lrIdX/4=;
        b=WZezu0yzdzfsVIhDeyxNp/eOG6+3fME/oRfRUCPRMaTnq9XYfCDF4fKutmmEpdlXD6
         XXf66lWqRAq8S4D+26OpiT4ol+TCH9I+/Vx09LULk2/N2tqKxHl7FXqJED7s9hLYtNyd
         +STRlR3feLkoACCs6Q8cAh2OTVGkvQV/QvSxPoJ07EPpsEqbdzQZa7zBt0eYs+RguCUg
         F3/2iLwJmgLAuGyMknuLlQhSAuK0dOr9Wm98VBtjlFYjLQAd+4pff6pkPhKdc00N0X6t
         +Bn+4px+8sHQV7K0pXv4kgJTWnQmWYWhieYTYZjC0iclEpg0Yaa8ASaaKfH9GW5ob/Hm
         ij0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703798036; x=1704402836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czhsa2PHtfkuxcfNIhOkDR+827hn+j9Ys9y4lrIdX/4=;
        b=CLZ5sVb8CN3rMhGM5Kzqpjeqkg2TGPJc1pcZ5Dr1tfn0Y/6LA8kFCaa63QDKL8AzDA
         8CLSH2mlrUcxhTDrjepRbWeIgz7hpDYYhh8xb9yoeRNUMcZrSG4bz+/XFBugFpZ4TDYU
         F5+U+cCjjDVRIm66JRTU+oO6zzkDvqiK6Ztz5+RNsV101wSlcEDn7bS/SDdWsEChOmrN
         wZNHhvML+6/Hf7YcIFh571cC6021P2KLtcZRiZGJdIzfR8g37WJXpO4F4o4QCA5Jvrki
         P2bhlOunlO/CiAzxbZPDrejArCnb0tcHhJu65uvgKN7hVIRfvOMprA11U0GAsdtYLJ9r
         8oeg==
X-Gm-Message-State: AOJu0Yy1K36fRAffSEJssK0VxUf6t/4zzvoYH8kdQAEU2afo2k8BWSDC
	paamdGumn1DF0Ba3/ECkteAdIRWGL6T5nYiVTShCEuciHKjSqw==
X-Google-Smtp-Source: AGHT+IGhGxQZFVZva3i10AqQa2qaqpnC00VcT536EnKvXKC1dSs/lbXwahDBxWu/93U+EBq0+D2IhazW92FAKgWIV8o=
X-Received: by 2002:a05:6808:1803:b0:3bb:c95b:935f with SMTP id
 bh3-20020a056808180300b003bbc95b935fmr3000674oib.1.1703798036845; Thu, 28 Dec
 2023 13:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223191902.22857-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231223191902.22857-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Dec 2023 22:13:45 +0100
Message-ID: <CACRpkdah=gsOuE8JVeG4ab2772ebgQ-0Vm8gRmPZbCZJWq4f2g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: constify iomem pointers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 8:19=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Constify few pointers to iomem, where the destination memory is not
> modified, for code safety and readability.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij

