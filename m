Return-Path: <linux-kernel+bounces-7890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2381AEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF2FB23916
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71154B673;
	Thu, 21 Dec 2023 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsSFWHsP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFBB64A;
	Thu, 21 Dec 2023 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc5ee69960so3710621fa.0;
        Wed, 20 Dec 2023 22:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703140045; x=1703744845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bUYlaraZvgnaRvFqkhplZceJUCJIoSDu2V8+PBmaGqw=;
        b=EsSFWHsPnf+kXl/Hy67PcxREhy+BXSRmaiiyK5+3XezWyLjU9ElUkSdVBwONlbPrCz
         r5kwZnMMdp2aw6iS4HE3ojc8NK+j169S1hzj3PzXnGfAuN22BzRVjlu3dffyA0MwrQF7
         YnHAmVnLANfOVe8cqRJBjTtevPTUzfJMyIOpZ/dapyq4dJQBWu5X/m1DO8c2cmn5jhoy
         9qGZsC2sV9xBm0KReS+z6hLNPYse9IH3yUltG2CsItNgc6APJjT45SIaOkJTH9IqWAv/
         6v6nWBJlbOBUlYw00UwNlrsrddqzDbgjLuwGNMuV5L1vPenvHe1E6soXmcTg0puf7gSD
         f5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703140045; x=1703744845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUYlaraZvgnaRvFqkhplZceJUCJIoSDu2V8+PBmaGqw=;
        b=WTHuZt1x5Fsab+tB20vS8LI06aM27tmpeG3Av4U4l6KDwvY4KRazuSJlZflgFieGr9
         R+IzT/LS4QJp+eB6WL2Xp/3QNgT/GAo8y1OFpzPcgVDrNevAaR8QF1leaxE/yJF2CX5d
         T1AC7FuHE+7kdTYrXE0CasCE+5QEq9EfPw0Z/9mUY8nWp5JCRN0wphY/4qVkgJOw1wI1
         RgTFmpUxwT+p77MiopHgqf/VodUbCfKD8hm1G+2k4kqzaE1poAkK4ZPsj4BxpTPuI7WY
         nX3pgBiXBFYiU94YlJEjTyMcwuu3JcKao+5Q52xc3oMMjAiUpOeTq4fr6pJ/Ff/RaB4e
         SeWA==
X-Gm-Message-State: AOJu0YywH/X3nUe/7CnoWLFsl73VpRkjfybm7KpELlVNTI6VbgjRs3gu
	mA2bBmM2lD4ITrgk3gVFPQsX1YdhBjeJ6VaKzejkH3KZjQ5BNg==
X-Google-Smtp-Source: AGHT+IGr8ds7tM65bV+bO56xsNx4q7k1kqiJPSfw32j4yZhvpd7vwHajRGCzWtcY0f4421/kv2STDbiUZ0+mBiaj/5o=
X-Received: by 2002:a2e:9106:0:b0:2cc:778a:f67e with SMTP id
 m6-20020a2e9106000000b002cc778af67emr1769164ljg.46.1703140045023; Wed, 20 Dec
 2023 22:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212065147.3475413-1-jim.t90615@gmail.com>
 <20231212065147.3475413-4-jim.t90615@gmail.com> <ZXnNRoGmeibdRAwq@smile.fi.intel.com>
In-Reply-To: <ZXnNRoGmeibdRAwq@smile.fi.intel.com>
From: Jim Liu <jim.t90615@gmail.com>
Date: Thu, 21 Dec 2023 14:27:13 +0800
Message-ID: <CAKUZ0+EDdBnPdY828L3DUTHKyXX209cJEuFWBs7xff_6bbDWPg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
To: Andy Shevchenko <andy@kernel.org>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org, 
	brgl@bgdev.pl, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy

Thanks for your comments.
I will modify it in the next version.

But some description as below



> > +static int npcm_sgpio_init_port(struct npcm_sgpio *gpio)
> > +{
> > +     u8 in_port, out_port, set_port, reg;
> > +
> > +     in_port = GPIO_BANK(gpio->nin_sgpio);
> > +     if (GPIO_BIT(gpio->nin_sgpio) > 0)
> > +             in_port += 1;
>
> This is strange... So, you are telling that offsets start from 1 and not 0?
>
> > +     out_port = GPIO_BANK(gpio->nout_sgpio);
> > +     if (GPIO_BIT(gpio->nout_sgpio) > 0)
> > +             out_port += 1;
>
> Ditto.
>
Yes,  if the customer has defined the in/out pins the offsets start from 1.
The NPCM_IOXCFG2_PORT register is the set number of in/out ports.
NPCM_IOXCFG2_PORT register define as below:
0~3 bit is the number of input ports
4~7 bit is the number of output ports
Each module can support 8 input ports and 8 output ports.
> ...
>
> > +     set_port = ((out_port & NPCM_IOXCFG2_PORT) << 4) | (in_port & NPCM_IOXCFG2_PORT);
>
> Outer parentheses are redundant.
>
> ...
>

Best regards,
Jim

