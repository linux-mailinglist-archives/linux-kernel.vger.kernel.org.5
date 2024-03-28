Return-Path: <linux-kernel+bounces-122918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF288FF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401EF29C434
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4567EF14;
	Thu, 28 Mar 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HFFTLrEi"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626558F72
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629931; cv=none; b=l9krqa61S68r4zvmEx64WWxW661R1wSt82cJ3X0UU2Evo04BMABSNr12CdKu1m9fVqbE/ADEhIXeCPLiLDmRnBspWjbcGQzU8Gp3MtWs5gSCgf6r2ArOBWqgkDhojQXflH5fIgRpWsk5yIp2oEnE3ol87dn2qD3lShPxsyH0ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629931; c=relaxed/simple;
	bh=8lEHF+5KeY7IwPxT0CU+sV7sbI+hhTxcWOVByD0uw5U=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Os1OZ2zss09cONDUkQVRw0DqzjKWpUzdtSMsHUiNNKbY+dTPe3F+hatbMEWl2heyQZK8De1Zwh6ZmKSrRYpiUg4pLvMB9Z+1qYKeRTpxuU4zi+dLLgUU3nFpBw3FOZjWuZtKGd3dPeAxXhpLBix0HcB1sM8j2f4ZOD+KcSE1y7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HFFTLrEi; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A3C8D3FB7A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711629923;
	bh=mcy8xBzJhA5/GwagWLEOHwxzAhDGLHOwYxY0lrDfVFk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HFFTLrEiJOTPG1C3kw4CIjslQ/f0MthN5gb8SFu70vCYm0ZQ90GRQddrD2/qy5yDS
	 EN289qhHPxysZ9yVSIbLfvOE2rGrtqPb/JV2NzlyZqNz2eLzZ0CGyFEHQguqHHbj1K
	 B7b+LE/cSixFk78JlwjPK3uw+gwcFglLSK6/LclCmybpU2GbH1uwictQ3PxjQ/w40u
	 s/9vdJG44fpEpYzbOBSodmCctU4mWLFBCNXvIplrUYy0vokHJ3Gb016RvxPMZesCW4
	 RzhYtmZr94BFzsM77k6tySW0u+wUrpxYQf0C/AqOUn5iGKlNlta5mXHlXQmwwiMSGv
	 pdDY9aqwlC6WA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4317b440bceso6525841cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629922; x=1712234722;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcy8xBzJhA5/GwagWLEOHwxzAhDGLHOwYxY0lrDfVFk=;
        b=iUdEf/DXpcbULqcwdaO5aoPcaG3Lq+dnjnrZd54jGFdcLBMPqhLSQMcrUFUL8JCazg
         S9Fxvo5/d/TqGfw/LXfmk6ctvcGWOFDgYkbiNRQlGVnw/DISztwWsYJ2Ck+TExLhRw//
         WEte7feOzEwLiH1UNpzdYncGQQBRGi7+GNaVUmFdGh4tZMJHGoGkZ5dqh/xbUYpRCKbS
         HiqklS6YjmXDhzAhybQfyWob7O8nUqdLYiZk5L2hq7+TugCUdscBhubADM4JN0WLcO2y
         QNwyBD6V6wGfj29RHhFkM6nAwT+PbV4wTLWpGwIAVK1Qm6RJXlmUF/oZDNZPhH6u+nsv
         Iq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUeYldJ+8gFuIEj5oIX1sOMUXJiIYs/CkABshE2If2tO78UZxUVoxMmxT+dHojGR3mpONtv0TH5B+I//l8X5rMncT1QWJwUG2cjq25
X-Gm-Message-State: AOJu0YzzQar5I0YHNWKY566h9eb/QBy0IasbnrRXGw3aZD1eOZWB0gqh
	4CX9ifHLxDLlkHI1YbYuaeaw1Sm3hV9enFGAyL3m6N41vFdkGpmKOeICuFbm0BB1b/HLUe99G7D
	NDeCpSIHIbT99ffOv3aJjSWGEey6SYl7CTekaxFr7uUJcO3XRDlKdFE0EW9KQJZbwsUQDc0p3JN
	t9SkTHA8o9tCiDxdGIFYiGMtaWGO7a3MA2KeEotGE444/m2T297Bmw
X-Received: by 2002:ac8:5e13:0:b0:432:b582:1818 with SMTP id h19-20020ac85e13000000b00432b5821818mr1585111qtx.45.1711629922494;
        Thu, 28 Mar 2024 05:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUKlsOrsfvlyk23QZwEukdnQFti77COK+AMtjF8pDiCQ3BPtiLG/Cb9YHlaPR5B4U1pD56yQlPhI2rzGy27Xc=
X-Received: by 2002:ac8:5e13:0:b0:432:b582:1818 with SMTP id
 h19-20020ac85e13000000b00432b5821818mr1585094qtx.45.1711629922222; Thu, 28
 Mar 2024 05:45:22 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Mar 2024 05:45:21 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <ZgVBurohYRDzFjgb@xhacker>
References: <20240131132600.4067-1-jszhang@kernel.org> <20240131132600.4067-7-jszhang@kernel.org>
 <20240206-magma-deem-2c88e45a545a@spud> <20240327-cotton-fang-37f6d8fde0e5@spud>
 <ZgVBurohYRDzFjgb@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 28 Mar 2024 05:45:21 -0700
Message-ID: <CAJM55Z8O20qjYmbjwOOE2CDCrWhCDGJ-jXY9TsR2hMSn-gEFtQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device tree
To: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> On Wed, Mar 27, 2024 at 06:06:58PM +0000, Conor Dooley wrote:
> > Yo,
> >
> > On Tue, Feb 06, 2024 at 07:13:48PM +0000, Conor Dooley wrote:
> > > On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
> > > > The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> > > > The board features:
> > > >
> > > > - JH7110 SoC
> > > > - 1/2/4/8 GiB LPDDR4 DRAM
> > > > - AXP15060 PMIC
> > > > - 40 pin GPIO header
> > > > - 3x USB 3.0 host port
> > > > - 1x USB 2.0 host port
> > > > - 1x M.2 E-Key
> > > > - 1x eMMC slot
> > > > - 1x MicroSD slot
> > > > - 1x QSPI Flash
> > > > - 1x 1Gbps Ethernet port
> > > > - 1x HDMI port
> > > > - 1x 2-lane DSI and 1x 4-lane DSI
> > > > - 1x 2-lane CSI
> > > >
> > > > Add the devicetree file describing the currently supported features,
> > > > namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > >
> > > Got a dtbs_check issue in the patchwork CI:
> > >
> > >   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rgmii-rxin-clock: 'clock-frequency' is a required property
> > >   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > >   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rmii-refin-clock: 'clock-frequency' is a required property
> > >   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > >
> > > Can you fix that please? Also, I applied some patches the other day that
> > > seem to conflict quite a bit with the common board dts patch. Would you
> > > please do a rebase on top of that please?
> >
> > Been going through stuff on my todo list now that the merge window is
> > closed. Could you please resend this with the rebase done?
>
> Thanks for the reminding, I will rebase on 6.9-rc1 then send out the
> patches.

Hi Jisheng,

A rebase would be great. It looks good to me, but could you maybe call the
common .dtsi something more generic like jh7110-common.dtsi like the
jh7100-common.dtsi. If we'll see other boards based on the jh7110 upstreamed
(eg. Star64) I suspect they'll also be heavily based on^M^M^M similar to the
VF2 schematics.

/Emil

>
> >
> > Thanks,
> > Conor.
>
>

