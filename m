Return-Path: <linux-kernel+bounces-23683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F882AFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658B328CEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9063C067;
	Thu, 11 Jan 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BXhJs+h3"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173ED3AC01
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b72377deb0so1619474e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704981244; x=1705586044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZlq/DrCdtM/ojaSMhAzGYv+U1jA3k7ByZIcttd1Mrg=;
        b=BXhJs+h3Y9eC0jASWAvGcKgRDYHcKfKfMwTrL/BUlcMH065SnmfQhvUTMwAy67Q/tE
         I+c2M0ycBU9KLrfZQ2Qub0mWyJmR6OnMVyonkwILVFEIdf2t3k8TVKnTyh3G7jSW0wyC
         V78PYq+LRlRfCSrkTHtxxmo4UvAvlpldi67L41HIR1EzfEdP7D4Qgh0mhjxGHuQxn6C1
         qJTrcVRAY+1+7n3LVco2VTQbgc/OtAjWZ5EmB+VfrseumyE7EHFF+H56Um/6dEM70f+M
         K61IETa0m/1HEq6LoyiGvDU03jGDF7cFvxKKGfHhSZRCoqxkQPaT9vLlfZwum6QBlXge
         dD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704981244; x=1705586044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZlq/DrCdtM/ojaSMhAzGYv+U1jA3k7ByZIcttd1Mrg=;
        b=GbUnlDmkRwUigqr0e3ppU3Whp/KpikQjPQn8i+kYWlnCfotr7WpluYQIqic9h6wqiM
         DDGuArtQ5HYKPT1HOt9dGDDBdTJHs/DEa9pQKe6MeryfWbqgPrzi5nMkmU3lzTbe0x+t
         pKYjQJeAiiLr0zVljrXIzRZNo2FDoLekSJkERSdE9g6lvlwrtiC1VrNFHcxL4cemySXU
         h+/9on0Kx2JzcxxYntwNJwwwSW48zWbaYxFQHr+QKCLQQakoZkMcVYh1RCey2mGSyu2H
         JiXk6xT0GVRw/B8cnsDr1ZIH6xe6MyEX4zFm/IkcEBYOZnL6/6YozJldUHkggg3y/Q41
         GDIA==
X-Gm-Message-State: AOJu0Yz3v2PT0P+rgvbyAxywqO4U+ONjPPufoeXVC4cTRjCxbJZMGECv
	Cbv3VkB3bsrPGS0yGoseyYuTQ3rTG8g790ePSm1ROXUSmbPymw==
X-Google-Smtp-Source: AGHT+IH7V+Jz5btSq+pxDhMgIcIn3mHxdwe1bF2gRcpkBD3Xl4SUVQQZWdsiHXNS9FkPVe9GNAzb0nCwViIDa1KnDoc=
X-Received: by 2002:a05:6122:3889:b0:4b6:b979:a28 with SMTP id
 eo9-20020a056122388900b004b6b9790a28mr475851vkb.17.1704981243859; Thu, 11 Jan
 2024 05:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111131904.1491496-1-hector.palacios@digi.com>
In-Reply-To: <20240111131904.1491496-1-hector.palacios@digi.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 11 Jan 2024 14:53:52 +0100
Message-ID: <CAMRc=McWxX7tXvUQiMr+5pRUS_XE7criGFskLOpyq70Ojdabqw@mail.gmail.com>
Subject: Re: [PATCH 0/2] support i.MX93 truly available GPIO pins
To: Hector Palacios <hector.palacios@digi.com>
Cc: bartosz.golaszewski@linaro.org, linus.walleij@linaro.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, haibo.chen@nxp.com, 
	peng.fan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 2:23=E2=80=AFPM Hector Palacios
<hector.palacios@digi.com> wrote:
>
> All four GPIO ports of i.MX93 SoC show 32 pins available, but
> not every port has 32 pins.
> Add support on the GPIO driver to 'ngpios' property and set
> the truly available pins on the SoC device tree.
>
> Hector Palacios (2):
>       gpio: vf610: add support to DT 'ngpios' property
>       arm64: dts: imx93: specify available 'ngpios' per GPIO port
>
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++++
>  drivers/gpio/gpio-vf610.c                | 7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
>

This is not my email address that comes up when using
get_maintainer.pl, please use it when sending patches.

Bartosz

