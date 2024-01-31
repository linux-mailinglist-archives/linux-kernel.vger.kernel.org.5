Return-Path: <linux-kernel+bounces-47029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8DE844835
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7466EB25087
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82853EA9B;
	Wed, 31 Jan 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIcyY7Z4"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509F3EA76
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730187; cv=none; b=BOwI9uE5YDSDqelogy6MO2aP5cA1uSRfWq7eLWG9jeaNTHW9WLtzMtYeJI7iKGTGs94B0n/PLu/y8KUbT6j+xa+UvGUaf7TDkoXevJ/RfXxt3havS057Y8d6BGn+eXs4U0g5Qd7TwPOVCxrN8Bk6Ns7KFYtvB9tqH4y7dbYYIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730187; c=relaxed/simple;
	bh=5LurfDzDMlU/+e4WHlA9quWo6BsFXeuGeJjyZPZVAOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMntKNtyaKPpJLd3aOgcACi9rkp6wt4AEiWb98hL49eCjQQC3euCC4WjafXUp1njbQW7QeVKcC8cPMxNa20hV0dK6RJpQh4HX9ei4UoJbLqGMau5h3CTGMS6M+iafbYixwcuuLqu2O5OwZLeEq9n8pxcTVwa0b2Qx73xyGJlij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIcyY7Z4; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60403c28ff6so1629107b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706730184; x=1707334984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LurfDzDMlU/+e4WHlA9quWo6BsFXeuGeJjyZPZVAOA=;
        b=LIcyY7Z4JAonoXYcKTcEcdwcvTlh8lJffcT+NJs9VnuJiK8WaVRkDYji7C1SmHz1Dl
         SJOgCGV3kZDTBHsCMLYBanv63QrXIK6tNsIy15Dbae8K0baedqcGRI4G8v/NLh7qtWKk
         pN8vDLsRqC7lMjscShrbTTpUxVrdSpzjj7i0VxXsnIMzJ8vpHZ30J+uFlDv6blmMY70N
         Dznc8f05/WvYZc7DrBRFCqi5aQzi/JnC4kdd32jWPEW2bj4dTrvVsVP0UiSoy4jI3VUz
         RIuc88yiiYcT/VNI71y8OnavUl63P1PFPxKHty0wrbQtkyTsGFfUvYvKOgXH2bZ7vfxR
         RmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730184; x=1707334984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LurfDzDMlU/+e4WHlA9quWo6BsFXeuGeJjyZPZVAOA=;
        b=J3d6e28K2uBuf5q26VRnnc04BlzhnaVW4Q0C2cEBwy2wYVz5PdYuoe9A1oVscFLl5b
         mXL4Sh1vInTfpdZzlG7TbNtRnW//KKMe5xBZQiKFpxoD/aLRFxVaIlyazflcQ7dX7r5O
         u/eleslHQihYCZYumROnxhv4DeKoOWC0nf+BF4vy0cm19l/qSmnuQXStkHpy7WR7FDk1
         WdbKxqSCs4jU2rBtWJOGVjCaUqOZDI7bNvO1JT7denaMbvu0CQoe9oBBsK96SFiT+jhi
         xFusCx3UUWnhssOrxs5spKiK0X+P8N3VbUFap78yu4RuRzDQa6M/v9BBH73yRi7QgDMU
         ZbRg==
X-Gm-Message-State: AOJu0YzD/1HmwuJICne8KOLP/xCHYrPV63Fou9cUr2VHp+v4+M4LAsGQ
	oA8UE5X2P3rc01Okm1bTBHbm5F2Lnrs19ZHXkUyKAAQmQy4dKHE2ykqMnRo38lUEb0ORiDiiWSj
	zFiUV2tAERA2TJuuO5zuCX/WnsYIqQlFBsSgPtg==
X-Google-Smtp-Source: AGHT+IFNchrTJN/laRoFT/serLUkj7SLPdu4ZsP2h1VQRwyjVfP96PoaTsrUDUW7Vv3PJ2nUnCiNh4c8poZyV3/bdYY=
X-Received: by 2002:a81:9103:0:b0:5ff:4b02:73b9 with SMTP id
 i3-20020a819103000000b005ff4b0273b9mr2679922ywg.21.1706730184634; Wed, 31 Jan
 2024 11:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-9-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-9-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 20:42:53 +0100
Message-ID: <CACRpkdah4My-nArTpnhV3sovT9SaUZJjrMaXmm67MFfrhcW6qQ@mail.gmail.com>
Subject: Re: [PATCH 08/22] gpio: sysfs: use gpio_device_find() to iterate over
 existing devices
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> With the list of GPIO devices now protected with SRCU we can use
> gpio_device_find() to traverse it from sysfs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is beautiful. And you can make the list private too.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

