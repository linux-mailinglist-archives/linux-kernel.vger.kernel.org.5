Return-Path: <linux-kernel+bounces-145500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C98A56FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284551F221DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B257F7FD;
	Mon, 15 Apr 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvR3tylh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B51762E0;
	Mon, 15 Apr 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197006; cv=none; b=MWejwPvDGE71DXwy0vuv5epMeWYPyd5uY9jI8+fdC4wqaGcpVswqXqxAeuc6AmN0IovEkWcAwWVAdV4GNaSDRWrBRbCrSzUmASDQulcfqzhPfT5nGWb3+T9lPcZTopspcmRX4xZWZgOKY+EPOcgWMFqR+0AMuAP7MLG/Nlwyoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197006; c=relaxed/simple;
	bh=lIMvuAHwjLxn14xlI86pxUjympPvQM4ZFRtNHfmoXeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaSnWxknOMN/04YB3YjidW74rgm0vfSZg0hk2PuLVDQ6yoEXM6cybgwySU2rcQeC4T5p89Yf90jOVMzmMN+sgbeVG9E6XOrEx9N61OPOpOIwyKUoD0OFRwWavvCVmDOxykrvLied5WRLqWvY+4st8YS2n48aPTj6lM/4mpNGepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvR3tylh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41885eeb104so842625e9.0;
        Mon, 15 Apr 2024 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197000; x=1713801800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr8I+VgFd75ZRE+zHJAA09qQ4BgEHQBbfn3jY2/hZUM=;
        b=HvR3tylhe70yWSmMloY4s/Nh7QRiaLD/IKUhYZQacqmB75CNfG6EkBJfaEpc7fHPHA
         qk0PesxtvHxSgcY0zLtK9njkc8cIu1yghYJRK5zZykS0ZJ+IT4u1liUFmOxWHuroB8VF
         I9rthvh5MAN5GhH5sNiOz97gy8hQ+8lvVVeUxX/RqJBFpgI8aIlf+5SUpwy6ouFcaNUz
         ez414Xpe52HqiOcbDnOhurF5hUgR7JrZqBRy7/OYx5vMdoEoETf5mcUXuVqqCmqX3Dyy
         ShzJh35lCC2jZUvCcfN+ViMbzIZ2eTpVm6icQfLib1ZIGt+5BpcbsrRTcQJ6kVyflHBX
         p1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197000; x=1713801800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr8I+VgFd75ZRE+zHJAA09qQ4BgEHQBbfn3jY2/hZUM=;
        b=r6OxmD2/HnCDpUsListSlOZ6fQpOMeLV8/bzr/e1K1+5PFh6vu0x5gL7MDDX0FWN4p
         Pl2fD/ryHgt/01aTiwOvk6KSD0RKOJOqF+r/2ePH5FckKLYbtagWsK8rsfb4q/s7Mlt2
         pk6Nkex/SAxACJ0UoKhb+7Qm3WATEJk7smgslOyboDE5d9zMOmgb5CFT4kpUOgTLqnWf
         zlc9nlQ+1cULEB+UIAjsH4eStBSTNqZZUYIACtODO3H5+afJrePdqGV7DsRJS7yBseOu
         r4SFvedafHKyaEU2hB+e1d4QPE+vcOdkaB2k/20/iHK0WSrNHnYNMUuRLwF1vfcpIjyW
         kmcw==
X-Forwarded-Encrypted: i=1; AJvYcCXitwUWxjRI/8TqIBCsdzO8Gf0zhfjweK6MalE3pxBeB40pvcwsrEHgHLOjKxYD5G4pMrgNFiWTrlzNFtT2OpTeN/OL4A6MeBYtAQk96Z/O0Yun5V6sY92MlAiaeRmAI2fZ3xW3Dw0S5A==
X-Gm-Message-State: AOJu0YyykzTLVEyVKxhuZ69w59lAUfaI/vdGa3hHWHKwDScFQNmssX+A
	g3V9x2laYbW8lLNb8iRdPp1C1lYeomblo/ffIbuC4NuXUunC1gvRVTZwHixzkLfu7mhO3zZmc6O
	LMCUH6KAU7pyAlgM20XYCaSyTa0c=
X-Google-Smtp-Source: AGHT+IGnudFnkfz6Z05cxCNhWfRT6AhTVVqFs+J3nN12T7rpgYsfp9y3+IWYL9AdGU/G7zlxCfw/2BIy9fnGAran+C8=
X-Received: by 2002:a05:600c:1d0a:b0:418:5fb4:20ab with SMTP id
 l10-20020a05600c1d0a00b004185fb420abmr2227743wms.5.1713197000036; Mon, 15 Apr
 2024 09:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com> <3eb80a2f21a96cc0fc275db60631f673bb14e77f.camel@codeconstruct.com.au>
In-Reply-To: <3eb80a2f21a96cc0fc275db60631f673bb14e77f.camel@codeconstruct.com.au>
From: Chia Hsing Yin <peteryin.openbmc@gmail.com>
Date: Tue, 16 Apr 2024 00:03:08 +0800
Message-ID: <CAPSyxFRj0twCJG6Lr5UZpznrUHyd_L0Reo=kZSFwCw3FNQ+x+A@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Revise Meta(Facebook) Harma BMC(AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure thing, I will base on version 5 for future modifications.

Thanks.

On Mon, Apr 15, 2024 at 10:00=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Fri, 2024-04-12 at 17:15 +0800, Peter Yin wrote:
> > Summary:
> > Revise linux device tree entry related to Meta(Facebook) Harma
> > specific devices connected to BMC(AST2600) SoC.
> >
> > Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmL=
vP8Qbepm1AVjuCbaKw@mail.gmail.com/
> >
> > Change log:
> >
> > v4 -> v5
> >   - Patch 0011 - Add retimer device
> >   - Patch 0012 - Modify gpio line name
> >
> > v3 -> v4
> >   - Patch 0010 - Revise node name
> >   - fixed PDB temperature node name in Patch 0006
> >
> > v2 -> v3
> >   - Patch 0007 - Revise max31790 address
> >   - Patch 0008 - Harma: Add NIC Fru device
> >   - Patch 0009 - Add ltc4286 device
> >
> > v1 -> v2
> >   - Add infineon,slb9670 information for tpm.
> >   - Patch 0006 - Add PDB temperature.
> >
> > v1
> >   - Patch 0001 - Revise SGPIO line name.
> >   - Patch 0002 - Mapping ttyS2 to UART4.
> >   - Patch 0003 - Remove Vuart.
> >   - Patch 0004 - Add cpu power good line name.
> >   - Patch 0005 - Add spi-gpio.
> >
> > Peter Yin (12):
> >   ARM: dts: aspeed: Harma: Revise SGPIO line name.
> >   ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
> >   ARM: dts: aspeed: Harma: Remove Vuart
> >   ARM: dts: aspeed: Harma: Add cpu power good line name
> >   ARM: dts: aspeed: Harma: Add spi-gpio
> >   ARM: dts: aspeed: Harma: Add PDB temperature
> >   ARM: dts: aspeed: Harma: Revise max31790 address
> >   ARM: dts: aspeed: Harma: Add NIC Fru device
> >   ARM: dts: aspeed: Harma: Add ltc4286 device
> >   ARM: dts: aspeed: Harma: Revise node name
> >   ARM: dts: aspeed: Harma: Add retimer device
> >   ARM: dts: aspeed: Harma: Modify GPIO line name
> >
> >  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 107 ++++++++++++++----
> >  1 file changed, 85 insertions(+), 22 deletions(-)
> >
>
> Joel had applied an earlier version of this series to his for-next
> branch. I'm collecting patches targeting it while he's on leave. I've
> updated the series he'd applied to the v5 you've posted here.
>
> Can you please post any further changes as patches on top? You can find
> my branch here:
>
> https://github.com/amboar/linux/tree/for/bmc/dt-6.10
>
> Andrew

