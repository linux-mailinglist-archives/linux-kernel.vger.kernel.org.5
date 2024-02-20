Return-Path: <linux-kernel+bounces-72512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCB685B489
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C590B20DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52B5C04C;
	Tue, 20 Feb 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpQsYgk8"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DB5BAF8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416499; cv=none; b=EwLIEHphaqxSLThStxOWZwVlFtFDswiPKYTxIUMBgeEEeo4viutdmi+VogjZZsubGadI1MS7Gtn4CAhV0MGIId+DEZdjKCHuFBUWl63qgFBNQ9rRjw3DVVXaJvAuZv3zfUhoraW6ggmQ1sQHRJiishb4j6kDYEDOArMw9MQWt7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416499; c=relaxed/simple;
	bh=28UnzCoexnR7SKOvEJk9m7bBcLk2Svbf7cy7JYxYD4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrv8wExWLX6b4wQZtuu21wRdFFfiM+K/MF6Ptwa2/HD6bfP1n+jrAWsDdVIrJmiGX+vjCjgTfd6lOKbHtpYsRJE95cWI6W5wfTu9UJcBh0WYz0bDHklZnJ3eg0K1WpX3mFJRvp1l3+CX9DKQ3nYXKC1uUdqGCy7NV2ixKZYqJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gpQsYgk8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3801485276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708416497; x=1709021297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28UnzCoexnR7SKOvEJk9m7bBcLk2Svbf7cy7JYxYD4k=;
        b=gpQsYgk81obm98G+71Zi5mAssvfUYFbjFyCpgvlV+XqUnevvGJ3HzPDjVOEllL4vwE
         dyaosR/rVDGoR6oy8/d0NhepeoFeOej/7rI4WEMTP5tgwwb/lzjgthl+rc27cLO8B87X
         WH9pmszTZDayqgsdpkUZYJhal7BJLRMjxndsT3sSY/wRYLFMjmR62RNMZowpy7FTLmIU
         A8CHY6XR0MLPdympzsygHe+p5HywxxWxqXdqilCWoAHmFbnV1D9LeHt0YAoysCOmJ9DM
         xQqDjw1QRUk1Z6LyJ2c4eKQxDjEKq0HSYMZ0wFI+KxVzMM9oa/iJti9LnGkmHPfFJ5C2
         cm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708416497; x=1709021297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28UnzCoexnR7SKOvEJk9m7bBcLk2Svbf7cy7JYxYD4k=;
        b=w5wmZXGeJZieTg9tVfzoTczn6OVLbxoYxc7yENhHZElo/rfnq/Oq1CyOWC2uIW5jhf
         NTynLJCfCMxX+qL660v12mnzzwVfEfcXe2+yA7snf9j6DZjFlWTtD9gps4Q7uom3n2Xt
         RlAJuJIHMpSxD9Ht49NtQvo2mh/R8f9ERclScB+rh/uI15PVcl1St+epdRmafMUUxP8p
         K3cg9WEeaScSaMB2sALNF+NMeijew3VuaEiPoJ38e03P5EoVQGjv9KLe55ZfmQ2PUl/k
         CcMPBbz+HgCGSo9CaSyo0vh/61gj6OwbwBvUAwef8gfJ4KQqLSno3EM8aQrT0KetP3r3
         OwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1nWun34geJFsSXS5vFgfuo+Q6Gt/qX1Ug0jksBAxMCJKAnJc42u14bOeIhPpN3hqcNHjCv4cbK0x+lDj6QGRCGywkOi8djCjlD0ML
X-Gm-Message-State: AOJu0YyM6xliVef/Qv+uK5mSvk6KIPM1KfXUI0LQ3/4i/ABfcZbP3dIu
	BaPkjPTLLUvIfeL4lYoZYdH9mEqkLXAVbNRj4obYaV2gshLxRGibHatq1/hZXjOj1yGFlmcTZO5
	HwKcUFo+O4ZsdaePNjnKcx0evdkz4qvXT9uswnw==
X-Google-Smtp-Source: AGHT+IHwS8FUJ2YpAr5zBBP4g2PWTmpEHHrNfQR533DYLW0+7TUd1OEulUeyv5HJ/8x0UPP78f9sKazUFOtDShKj8MI=
X-Received: by 2002:a5b:bcc:0:b0:dcd:9808:256c with SMTP id
 c12-20020a5b0bcc000000b00dcd9808256cmr9950536ybr.58.1708416496932; Tue, 20
 Feb 2024 00:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-17-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-17-f88c0ccf372b@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:08:06 +0100
Message-ID: <CACRpkdZGixhbsqO+uNw4a1Z32LgdoGr_EhZeAsjzA9hKO53s0A@mail.gmail.com>
Subject: Re: [PATCH 17/23] gpio: nomadik: handle variadic GPIO count
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

> Read the "ngpios" device-tree property to determine the number of GPIOs
> for a bank. If not available, fallback to NMK_GPIO_PER_CHIP ie 32 ie
> the current behavior.
>
> The IP block always supports 32 GPIOs, but platforms can expose a lesser
> amount. The Mobileye EyeQ5 is in this case; one bank is 29 GPIOs and
> the other is 23.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

LGTM, with Bartosz' comments addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

