Return-Path: <linux-kernel+bounces-56340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B0784C8E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF7EB2477C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A821171B6;
	Wed,  7 Feb 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpuXomQM"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE217BBD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302812; cv=none; b=X4c6LLtUGTspySJ8I2m1tKHPz+2x5bNV5LiTRIxy/zPGQMG3JilDoYUYRrv67kg9VQ7LoLRKFpi6dF/2j7jSu18HIlTsCted4+Ji/h/05OyrFTMlV/RrfdZuxev94fakhQiWszZKGp5eDnVdcB8rPL2h4KqFBUxWHpsSiMP8zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302812; c=relaxed/simple;
	bh=VKj881Aaf4mYKxSOVReOB5rnt8T7gInv+xnCpX24PSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkbZwGWgIMwtDhRodpnM1+Voi+cYEGjLutHAsOcwJ5/IlEPyhM/2XVVnkYuNWBzhFRpiaMrcLsaDXw+A14Dm7fxFlAYYx6h0s2yn6IAiHW/R5dYwN7C/RUANOe6ntloLwh56rhqmbX658pVp01yTSLANlLlvVgH8uZTWA990Gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rpuXomQM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-604966eaf6eso2409187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707302810; x=1707907610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKj881Aaf4mYKxSOVReOB5rnt8T7gInv+xnCpX24PSM=;
        b=rpuXomQMIAfp2RfA9kLzOdI5FPOF4CDY3nGI9VAjNsiiK+SI30rCOf48zqzObLrWrG
         //85ktCU0cmAnrAPUuIqqAAvIiaWLEF99maQiyXSEl3Fk0GiobnmXR7N5A9uCtOu1I2X
         i+nIqYNIwA45CZoF5VmraDR8CLphTtZp+ufB+++ZXU2DGXx+OKbZJQNaR+WFnIL5S7I1
         evYs7OTtxKxfpT5sZy3rZ158AgcWHzFH+Fr1zjVBo2qhG49E7HKneAiTSjRS/VDLv/a9
         A8/Kq2a3MulsDkg7q5N4DUiAJo12TIuyo2b0tVoHo3sJj3e8C+SQbtwh/+qiH7bF0iai
         q3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302810; x=1707907610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKj881Aaf4mYKxSOVReOB5rnt8T7gInv+xnCpX24PSM=;
        b=qr475Xo19sXiZ99qP5AVoQ6G5uEsthT6Qh87R+udhNiJVfdBqO8s93ByWxboXxAUZg
         nWIYtRn+CL60L5Kq5zuZ/YqeKKaesJdNHdfEUWOUSlkbPSL1oU26v5G8Qs2vLC1vK3Yf
         Jc2aW0ZOnoiqebjlJiWumDbuLZy0xFxruAPNxzwYIiKAzneSSYNvjrr76IqYE7LuhAdi
         PR6NPCli1sgpomzGUoN39/UDL0H5GO/7oU4yt0rkHMHgTA0kSAPG0KWIhKoLj6SYOdt0
         iJMuETQfUeRjvDIQbvgjti3xbXIkzbRRS+3exN2UO9Pn431w/Qcp59mck37I6s+MDH8V
         WJVg==
X-Gm-Message-State: AOJu0YxKp6Fpp3E4qVYdr5mgqlat0a2DUv3M+P8X69SswA2eOQ4L3QVW
	I7KewdD/voyTfondX3H8iGULdTXRCns4YLzaSEmyyTWi3tk19mhf+Aa8USZm9/leG3FkGD0flBv
	LxAbtSyXl92cUTUyn6wlyGpA0wMo3OkTZ7pv8Tw==
X-Google-Smtp-Source: AGHT+IFICaMWcFSHf+rMsrZpjqNCWw5NlgzTK1CiqqBvfuK2Ztc7Bl1sYVhPZ349FbFC6VpKk9kRIE5qv62ianruFtU=
X-Received: by 2002:a81:c709:0:b0:5ff:314a:99c with SMTP id
 m9-20020a81c709000000b005ff314a099cmr4376710ywi.5.1707302810126; Wed, 07 Feb
 2024 02:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211154239.4190429-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231211154239.4190429-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2024 11:47:03 +0100
Message-ID: <CACRpkdb-F_UkO-taK2Cqt-OkqWaTy3mp+YwiXxE0uMFad=D6+w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: nuvoton: Constify wpcm450_groups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is no modifications are assumed for wpcm450_groups. Constify it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied, thanks for reminding me, I must have missed it.

Yours,
Linus Walleij

