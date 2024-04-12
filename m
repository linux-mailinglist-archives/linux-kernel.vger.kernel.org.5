Return-Path: <linux-kernel+bounces-142498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B068A2C53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420082837EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C453E1B;
	Fri, 12 Apr 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpbUm07S"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E05478B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917714; cv=none; b=Vi/2R0qLPSOzTRNLEMEtrULKnX6xqDN2rl91ZaTr7bEGU2lpF30YnzACH+rrgz1zuL3PuwOxiInmMqngCh2rDzXLixB/nXKmNszeq/GlYeyu/ywiRCE8WTWrBIvKJg0QrVJGsvfMuGYj7vdTkoLZsT8OIiZVE9l2f294k0CNHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917714; c=relaxed/simple;
	bh=eLTgpMLLk88+QMporuNHqvJUIoJTUhWc0odbIhAvwcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5HcmRmAcInkjZWQNYgCd8XS0jVssvSxRbPxKL6IwNFJSg06bVAP/FDcM8vtV2mvD3IQHgCvFzwk8KbDAFRid1dQ6uoUaQnNZzkCeFm2gs+KNUMfgiIBX6HZ4E7Jsl0NzSVMfSHiuPb3j77AXNANPkFsOTiHaBlFaB/QCCRM7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpbUm07S; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so760324276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712917710; x=1713522510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLTgpMLLk88+QMporuNHqvJUIoJTUhWc0odbIhAvwcM=;
        b=mpbUm07SJGdXs0meD6z1g0TcjWv25RkUY0vZF3+25LLs9TkTTexu8WxHlcipO2rv0U
         qDsyGYsr5s9Nq7NRa0fyobD3Ih9JSeoca50gqLkk4TgSF1joEltrjz519AOkmvdrRjwd
         dNkNWCPxBGbNZ/Y10WbQBparW3t4NSsOmX66fZp8+66Degy8AzWW03TmH7+6v7VBWnHh
         ma34sN7LEJ9jyzGX0YasA7Y3WNhjKeBEXQaD3FpydVwhOFHUS0BXOMCu5aNgVBuAFyZ9
         E1weOagpZQ0cg0hN3k34LBaxOFNEU671W0A/eVkOqmcbNds3TPgqZBD+/feKLfijtU+j
         eu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917710; x=1713522510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLTgpMLLk88+QMporuNHqvJUIoJTUhWc0odbIhAvwcM=;
        b=TBMdMcEMCZx1aXju8Ox5hkVrLKuTLnBmeT7JfNw0CeaA5zqU3TirWpuEHhamhx5y7Y
         qF5S+kt2zOPBlTF5T0RMa1bF5ii3DY0Brf3loAOx8dFu2fKzW3yyTvQ6CTmcJ/3TyeD9
         fNit/bgmHSoSlFSeO+iL/0xQQJQdfebqDZQOv3g1uo1vgizMabB1Hfm7so5bPxH6wX5+
         lTGYtOFOjBXCfXWkkMl+8hUVw/Hw6Uwqby7oLF7E6wUjIShajURTL3RwHHszTdXTbx1L
         Z4vf7cAyunLCqHyoeTe0itqZagEiB978e/AjOPwlsutVDgeXNW0r7ZhJ3oPeDdZUG6PM
         OiuA==
X-Forwarded-Encrypted: i=1; AJvYcCVlWuaGC0FInJx/3Ub8BHMHJpgSlEkYeP8o5LlHORcYiJcRv5gBz0DfRoRYfAoG5pdbFfpLjXRekF4Si2X8G3uiczwSW246eLspPSup
X-Gm-Message-State: AOJu0Yxxs7nzmi5G8AJ/mklkL2l6vsvFxBUrALr4VxnsqIe1gZOdFrpL
	insVeqd8Ea6jTvnNBIdZ8tfNkhvXT8Xbrx1mECajmVuxH6JCi77rjO8JrCB6Yed49KFaZU4pU/Y
	Mi7DgVDa3TGuBZvOxCkxAiDnuLamGXq5PruadYcMQ5MBNFAhl
X-Google-Smtp-Source: AGHT+IHPZw4JI1weB5+Ueqw+or5cIs3gBZYlkfLh4xNn2Aly++Ufb8+7mPl2iiIIx1tpNTRhIXA81+uSZdB4VQ/U8mM=
X-Received: by 2002:a25:ba45:0:b0:dd0:1276:c2d1 with SMTP id
 z5-20020a25ba45000000b00dd01276c2d1mr1826758ybj.35.1712917710171; Fri, 12 Apr
 2024 03:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410064156.1199493-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240410064156.1199493-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 12:28:18 +0200
Message-ID: <CACRpkda-JN0TA3A19hWzB=Bx6pcyLmTDxvqOwo8eveJFGcwrOA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: pcie-idio-24: Use -ENOTSUPP consistently
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: William Breathitt Gray <william.gray@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:41=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> The GPIO library expects the drivers to return -ENOTSUPP in some cases
> and not using analogue POSIX code. Make the driver to follow this.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

