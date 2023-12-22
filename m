Return-Path: <linux-kernel+bounces-9238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47881C2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C1F28504B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059463A4;
	Fri, 22 Dec 2023 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3OLoF/l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A228E612E;
	Fri, 22 Dec 2023 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc95f1102eso15022171fa.1;
        Thu, 21 Dec 2023 17:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703208470; x=1703813270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbiwt6IU8kOI0izJYNgyXRRGilmtjvoO7sPIgNCgD0Y=;
        b=a3OLoF/lLCOsSO9XfNOud1fXQf1Pe7zLVEyUIEOlaA9TJEUC9wOV2NcT96rBC7HvyT
         AjTDsQZsR4Gytp4LS0w4IdRJoVTrjjCyUXvLuHs7ZVsdVz7kviI1ZrnImPjqI8OmrVvP
         hnFSLNkeSdFLQ/0vwiwcd/6i2HMRWWjlIvqvLiqyLCvFcvVcf9VaKXoYsym6b7PU9ZMd
         Wwb/HnQWfW1/yq66iRw0vyUVplbRgQyGqnicLh1/XRV0cwOff8RJlOJeIQTK+b1jKb5a
         WC8b/ZbpCpFodlYPUAo+w25NxnHX9jKfs8y/bicPppjNYus3phHd+o+A4ILVBUZAx92S
         KOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703208470; x=1703813270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbiwt6IU8kOI0izJYNgyXRRGilmtjvoO7sPIgNCgD0Y=;
        b=nO8iovgTYhYT8Codcj/YPSADVJHBEBO11epiFbkem7PZRVV4JPpATQcLBEW/cRL9Nx
         VgX8qLPy4lIN7JWgWPv3GsrMWxDal66WXYXTsvmb4mW7jZEGqX5YdZrXCxafiLqyeAqw
         qaJqwrZlkrW6B5I/0lDQJK6/TbWtx5ohMu5QhXiJfvG6fItCUQmSffy/OnCX5MVTfXMC
         5tHuhg2YRMiH8T4Q4821k1/a9a+4DvynRhk5pSErLVj32Gie2h9O5U+Ukcu4J6ymp7XU
         Q98NWHL1t7+zfwTZ03MybrO3CluX5UsFAhXBJPrgjz4PTWAV7x/1JU67ZnfF8sipNXBe
         EJpA==
X-Gm-Message-State: AOJu0Yw1Q09/EFTnfagZB7BoBthlKmA6GPo3LjBWQ36eWVsHKpCp7Brv
	yhGVstz6g93oT8gW1YOqboeCShLoe7/uFWXW+ao=
X-Google-Smtp-Source: AGHT+IGRFK340w+pzPlHUVllDThXR7WV8h/dGJL2cFunQZ3oNcWSX+JYJBEJ24qUE3U0QajRYKvKBv9l8k4Hh3J73GI=
X-Received: by 2002:a2e:6e04:0:b0:2cc:89ef:23f9 with SMTP id
 j4-20020a2e6e04000000b002cc89ef23f9mr142991ljc.17.1703208470239; Thu, 21 Dec
 2023 17:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212065147.3475413-1-jim.t90615@gmail.com>
 <20231212065147.3475413-4-jim.t90615@gmail.com> <ZXnNRoGmeibdRAwq@smile.fi.intel.com>
 <CAKUZ0+EDdBnPdY828L3DUTHKyXX209cJEuFWBs7xff_6bbDWPg@mail.gmail.com>
In-Reply-To: <CAKUZ0+EDdBnPdY828L3DUTHKyXX209cJEuFWBs7xff_6bbDWPg@mail.gmail.com>
From: Jim Liu <jim.t90615@gmail.com>
Date: Fri, 22 Dec 2023 09:27:39 +0800
Message-ID: <CAKUZ0+GhB9m5c-5PtZNM3YrXmXfDRPVH_ZKAPxecF5dQO7Jdcw@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
To: Andy Shevchenko <andy@kernel.org>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org, 
	brgl@bgdev.pl, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi  Andy

Thanks for your reply.
The description as below


> > > +     in_port = GPIO_BANK(gpio->nin_sgpio);
> > > +     if (GPIO_BIT(gpio->nin_sgpio) > 0)
> > > +             in_port += 1;
> >
> > This is strange... So, you are telling that offsets start from 1 and not 0?
> >
> > > +     out_port = GPIO_BANK(gpio->nout_sgpio);
> > > +     if (GPIO_BIT(gpio->nout_sgpio) > 0)
> > > +             out_port += 1;
> >
> > Ditto.
> >
> Yes,  if the customer has defined the in/out pins the offsets start from 1.

>Why?

The NPCM_IOXCFG2_PORT  default setting is to enable 0 input port and 0
output port.
The register default value is 0x0. Each port can support 8 pins.
If the register value is 0x31 means enable 3 output ports and 1 input port.
If customer has define nuvoton,input-ngpios  or  nuvoton,output-ngpios
dts property

For example , nuvoton,output-ngpios = <9>
> > > +     out_port = GPIO_BANK(gpio->nout_sgpio);
The out_port value is 1 but one port only supports 8 pins.
> > > +     if (GPIO_BIT(gpio->nout_sgpio) > 0)
> > > +             out_port += 1;
This out_port value is 2, the driver will enable two port to support 9 pins.

Maybe it is my expression error , the out_port and in_port default value is 0.


> The NPCM_IOXCFG2_PORT register is the set number of in/out ports.
> NPCM_IOXCFG2_PORT register define as below:
> 0~3 bit is the number of input ports
> 4~7 bit is the number of output ports
> Each module can support 8 input ports and 8 output ports.

Best regards,
Jim

