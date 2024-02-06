Return-Path: <linux-kernel+bounces-54818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FE84B40E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B4E1F2269D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C7130AD0;
	Tue,  6 Feb 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XxfL1v8u"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F0130AC4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219797; cv=none; b=o5m/qD19YHKWoCJvTRcC2bsYtOmv3Ey8GplhdhvjyEzGP1KIpbPVH7GxM/qhQ06TUoGN+Juht24ZcG545ry9yy4CWD0NZ2ABZll8tzbrVQ4WN9+Bo8VQGf2c5S81mphVSf7IWjtascC1NJbY2hGNjq7lSLU/4IX20sPss0CUQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219797; c=relaxed/simple;
	bh=EPQ+cVqCjVdYYihQHuYeCKtcklYcUa9mjYhu8zX/BuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QV6NCluQnIODGb3UdNMjgLuqayISEyvcM//wqA4tcp7RBAmi4FrcekulW51DySr3uEYjMvQ573tSuR1IhMCfuvJdbHP+GqblPzctPwNrFoahO2qeZlx9dyAEnsHK290cJyNr6xGQMz84f//1oDOOR89fhl5xRqtjIvieFNupU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XxfL1v8u; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso2291597241.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707219793; x=1707824593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPQ+cVqCjVdYYihQHuYeCKtcklYcUa9mjYhu8zX/BuA=;
        b=XxfL1v8u6sMsN9nrWxz3yneNDrNHQiK1GCEXJleB+zkH9ivp4vIaoCy/aeV0UEN/lS
         GYFCud+hl8sYHjlh8dOJd6a1yuMQXFx4WQXo5zx/tBDTrGdtGYeeAitR1hDJ3J/hHNsE
         0GQKfRlYYg5yoFEegSPdnAGXyS6yKFUBAihKFKMi2LgRtjjdZF86xTcOSbYYIlxlrtRQ
         luZ1FUTTMosqss19s18XiGgbSELakyIH/IXr8GAbs1+HZ8pVj9v6iaREg9NDHXTR1kT3
         +3sm4Pn2mSS/uOfUfRjzEpJ+UzeyIFbAH+s/kyxecIPLN5ltRIPvuere8tgQfQcnizfg
         UGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219793; x=1707824593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPQ+cVqCjVdYYihQHuYeCKtcklYcUa9mjYhu8zX/BuA=;
        b=FEgkOGN2K03zHdfJPfnQPbcGohIgUDbXAL3I9yHDtBqf1Nyd9wnnvUJ6iHwPs+zdyj
         /CJd9B/KOKMoWzVj71dAKewIpAERZl80aIARRBVNfvgEhUBW0AZNYrUkBlJSrMdPMPIK
         Muf4P9+BYYnb0cJisyPwFVCWQbylNdFxntfFVhHi/gtsBTzYZ5CCjXUKgwYK1s3TbI2M
         G1krPE4GjpBf8pFQrQ99mL1lVSkvtAdUS9i350WU4Mrub52F7RhQBAaOEA4nYcJ84h3g
         JQWIFxfqAD+Mm8FX5rW8hGuzTRTR3tJjcWiyo5qViuFzMUwjhe7xT/MlNF8PtmSdHpN7
         /Uiw==
X-Gm-Message-State: AOJu0YzxB4P3sB9AiYO7xyHsqwfO5pa/h3zJmnYWxF75Se2re1ZCPUde
	8HoynTzXgwmBz7shA8ukBA9QxFmpvvCHapYVguwmWqZ6zTyggF0lLjRGACoUMhR7jt4JP1pbx2y
	WxXBinVeFCjnQMqEElckGiFhMMj8Ea8ICw07Oiw==
X-Google-Smtp-Source: AGHT+IH/ty3l4JaUHzTYH22M32IOVtgJQ3dBcaWbXhnfjFajbREEFj3DCVA1V0Yyjmd3nXSfVWqfldaOAu0sdOIdccE=
X-Received: by 2002:a05:6122:1b0c:b0:4c0:1edf:f29f with SMTP id
 er12-20020a0561221b0c00b004c01edff29fmr2291037vkb.5.1707219793602; Tue, 06
 Feb 2024 03:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130105515.30258-1-me@kloenk.de>
In-Reply-To: <20240130105515.30258-1-me@kloenk.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 6 Feb 2024 12:43:02 +0100
Message-ID: <CAMRc=Mdb+=aHyyMZCf3ALWot-QY=NZ_mR=bubqofwHRV4srG3Q@mail.gmail.com>
Subject: Re: [PATCH] gpio-mvebu: no hardcoded timer assignment for pwm
To: Finn Behrens <me@kloenk.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Heisath <jannis@imserv.org>, Yureka Lilian <yuka@yuka.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:55=E2=80=AFAM Finn Behrens <me@kloenk.de> wrote:
>
> Removes the hardcoded timer assignment of timers to pwm controllers.
> This allows to use more than one pwm per gpio bank.
>
> Original patch with chip_data interface by Heisath <jannis@imserv.org>
>
> Link: https://wiki.kobol.io/helios4/pwm/#patch-requirement
> Co-developed-by: Yureka Lilian <yuka@yuka.dev>
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> ---

This looks good to me but I'd love for Uwe to Ack it before I pick it up.

Bart

