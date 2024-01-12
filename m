Return-Path: <linux-kernel+bounces-24494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFC82BD6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA011C23D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63456B99;
	Fri, 12 Jan 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TXwmvMkQ"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6785556B67
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b7153b8d76so1116830e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705052595; x=1705657395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SOKaW2woRervs3SEctxvdhsDA2CX0fXEo5IZIZEkjI=;
        b=TXwmvMkQt1bOumNT9ex0KA1MwvpznXy0lLXDMsJFXN+cnNl2GWlLSfZaFxsjYsWF9q
         KQuvfv4cjMnyMvqCIC8QnRA4z2lrgXxakAnNvkb7iDmqX1X59vyi9F8ASou8YzD8BknU
         ZjMlx7pocpxBBPNoGDAN4oCPgtF7Noz0slVoAEAP8mKPbVnnmnqTfrr6OVBLPsTvnCI8
         qJIrBAILq9vRyzZqZuBhhQYoJOWNGAqiBRiDdJW0f2/D52c9XwRhccAncOdIceHb6YLf
         1YK/T8iE0U3rl9C3fw0UqyHc4Al6UJVfBS0ZUCswy9SsL4dyz54iGYahruAMR97cI7rG
         hdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052595; x=1705657395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SOKaW2woRervs3SEctxvdhsDA2CX0fXEo5IZIZEkjI=;
        b=pdRIt/PuFv1uH9tfScSziN8F1QRfMy+dV4nwleVO2tKpHpyCifcLblXEB/QzYTzQNy
         vJJXGSl3YksillTg9kWv90zahXbj/C8Y1QH3GR3SCNpUWIv9hVm81QWXMynrAj2SFzlo
         /3wAH2A9xyfl65/n/fGLHy6Zo25Snbk72pE6DvT7CQ85dEi8KoSU4FUn8a1hMZnRios6
         q2Van+bNjZZmKLx02pMnn9zLGvKgdIBWkNKOQ4O3e22SBqQfkgBGRVOmMmSOB428UsQS
         Frzvrb0xbsrNGuAZe2mnrDoeccoW5qpqdo868FGshk3beVO2eG+2hc/PKSNNO0spdJXT
         N81g==
X-Gm-Message-State: AOJu0YzonHWm9Xclnef0rHV017Uu2daRrBa1dABhBjSDLK9LMdv+6oAm
	WvG+SjaFsfn8SIl42+2Y4235G0BGDTY54mGeXeaDBC0XxATPjg==
X-Google-Smtp-Source: AGHT+IGaXoThckSM8NX1Ht9fT8RFyHBo65nMhJgSYIF7TWGvCDsemWJEAEquS+QXpokkqOQiXcw1Whlfv4mDa2JkGVI=
X-Received: by 2002:a05:6122:3b88:b0:4b6:aeb7:3f1d with SMTP id
 fs8-20020a0561223b8800b004b6aeb73f1dmr839449vkb.9.1705052595200; Fri, 12 Jan
 2024 01:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de> <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de> <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de> <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de> <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
 <20240111150201.GA28409@wunner.de> <CAMRc=Mcngw1vw9q0DXRWLKk4o9FOY+Mzz-niueT-v2THvbS1Dw@mail.gmail.com>
 <CAMuHMdUnB_eGhzyOYRczXLMgb65dfHgwHgnv7eXSWDvOvTEdjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUnB_eGhzyOYRczXLMgb65dfHgwHgnv7eXSWDvOvTEdjQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Jan 2024 10:43:04 +0100
Message-ID: <CAMRc=MeGsWV_71MzJ-Srm5MnwMfmwac_DLyC9O-8242eekuhNg@mail.gmail.com>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:44=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Bartosz,
>
> On Thu, Jan 11, 2024 at 5:16=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > No, it was actually a no-op due to CONFIG_PCI_DYNAMIC_OF_NODES not
> > being set. But this is only available if CONFIG_OF_DYNAMIC is enabled
> > which requires OF_UNITTEST (!).
>
> Huh? Config PCI_DYNAMIC_OF_NODES does select OF_DYNAMIC.
>

Indeed, I got something wrong.

But in any case: we *don't* need dynamic OF nodes as we don't create
new ones. We use the ones that already exist. This is logically a
wrong place to add this.

Lukas, Terry: am I getting this right - is the port driver supposed to
go away at some point? Because I'm not sure I understand what the
problem is here. To me it seems that when we create a real device for
the PCIe port, then it's only normal to populate its child devices
from the port driver.

Bartosz

> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>

