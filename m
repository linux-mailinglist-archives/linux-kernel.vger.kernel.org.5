Return-Path: <linux-kernel+bounces-106257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F5987EB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A8A1C21245
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540FB4F1FE;
	Mon, 18 Mar 2024 15:00:34 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E74EB30;
	Mon, 18 Mar 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774033; cv=none; b=cXHwezUdp+qHDJlMwk6wTF1CMTOQOfrWOLaXUndvMQYj0lZWWgnKnqB3jpPsx73Bqkz60Sq4w3Llp0Ar5PNFKS8DAyTi/umV0r1A4MhKw4NZyFJJ/5rPlKLnH2F687i7N8DB/m9SjRaniEFAxuZ4MQyWhrB72hZ3bR79RCz1wBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774033; c=relaxed/simple;
	bh=XDxXBRDjarTtKROiMq/2wlgwNHkBLP7nSY+Gzs5Go28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNmqSHPuKr/7LdhaFXnr4wRG6wttJFM0/ldmVBa04S7ICbEhBjrJllSO6s4IDOmgSIcmqTF8D6XNRpU8+dpHi0bY4uyM+RdjkU8iRBpgqyXohl21mj7FogusmbQ8PdD/cj/DyPIUbtXJViYdDVIXmy4Xk3qvYjEH9nCrPYkQ5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609ff069a40so52247937b3.1;
        Mon, 18 Mar 2024 08:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710774031; x=1711378831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXPz6+0togvKFnM43qr9sOSa8N0BWel3JsRydDrzDrc=;
        b=O34M3QeH9TFBpo/TjX3MS+ie6SBsI9c4uSAR8lLd70ju0GJ5fVL8velkeFbkI2umbo
         DvHEKjE8QNKm2hi0PVLxzkKdimXhKTWtQBw67eTY0lkGL32/qdO7tOi0QqsGvMi8gFCB
         FSwitXBDseyN1s5voKoKNAHE9IIoM9ntcZgZDGsmBE6vRXrNFQWEb7EpXsy8S/Q5h7Cv
         YKLbV8Rg/HGOIaaOa0nduy9twSm4HXGqn9rWGwDuzvhvwy/5myOQWbLoWNJCdVl2y41P
         B2Yj/51i9A3d+01dK140TMitmtcg+RTlDfVpddUAaO4QE51ef5SLBKyJ9npFjGOR8Kfm
         VeBA==
X-Forwarded-Encrypted: i=1; AJvYcCUH/2fwGL5EnVDbsxkHtaJh0CyUU5ZT5zNkwLHa2UfCqz2Pc5EBvA2Yp0ez3bwuuv4OCgm5QwCJu17kdXuiLbJ2UZoQsOH85xdfxK3MuHdy2lo89liX4IIoGrPVNHJb5S9skBEfBcqZcw3IJwDXLH2pIxTiyDta8ZrmL2KnWhAJk1yntw==
X-Gm-Message-State: AOJu0YwjbwKYiJuXzBWwMVwvggm55KIa3vFdGuDCX/7iw9xdb25so9xg
	OFVdCq/sS9ii4y3GThgY0RqYHWvE7Ex/DQevOAvEPe4v+M8C1IQM4QPcJ6o5i95oyg==
X-Google-Smtp-Source: AGHT+IHnJGFNqw3PdslviMvot3zB8cExfLW0Ine1evxhnZTs4rkG/kG+ucQCciHkDgPMgBaHTpBRjw==
X-Received: by 2002:a05:6902:82:b0:dc2:2041:fc49 with SMTP id h2-20020a056902008200b00dc22041fc49mr7165193ybs.5.1710774031052;
        Mon, 18 Mar 2024 08:00:31 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id b11-20020a252e4b000000b00dc7622402b9sm1773830ybn.43.2024.03.18.08.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 08:00:30 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc71031680so3878237276.2;
        Mon, 18 Mar 2024 08:00:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY1WP4nlk5BPBQVxtjsQcu9T+CnrqCY5HV53PlA7gs/s9x/rdc5qxF14nQQRVoasBmjMiyJgWrK1Gs7fGhCSLLi/lyxeujLBUhzj3LJxORFZ5bKJAsdv3E3e3gA4oesxudl1MRzMb3LphCYxCctGHYHsRPOe5VdiAv/IsSBh1U1oaOtg==
X-Received: by 2002:a05:6902:389:b0:dc7:4b43:db3f with SMTP id
 f9-20020a056902038900b00dc74b43db3fmr7205706ybs.21.1710774029683; Mon, 18 Mar
 2024 08:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318114346.112935-1-tanure@linux.com> <20240318114346.112935-2-tanure@linux.com>
 <20240318145423.GA3993342-robh@kernel.org>
In-Reply-To: <20240318145423.GA3993342-robh@kernel.org>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Mon, 18 Mar 2024 15:00:17 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+26Of3uwKMufDrngj5ciioqt0ne8gXD-jdmEdWTs4Ag+g@mail.gmail.com>
Message-ID: <CAJX_Q+26Of3uwKMufDrngj5ciioqt0ne8gXD-jdmEdWTs4Ag+g@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] clk: meson: T7: add support for Amlogic T7 SoC
 PLL clock driver
To: Rob Herring <robh@kernel.org>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Yu Tu <yu.tu@amlogic.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:54=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Mar 18, 2024 at 11:43:45AM +0000, Lucas Tanure wrote:
> > Add the T7 PLL clock controller driver in the T7 SoC family.
> >
> > This is RFC patch that enables SDCard, Ethernet and Clocking
> > for Amlogic T7 soc.
> > In this current state the patch doesn't work and gives a kernel
> > panic when probing the meson-axg-mmc for the SDCard.
> > DO NOT MERGE.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  drivers/clk/meson/Kconfig                     |   25 +
> >  drivers/clk/meson/Makefile                    |    2 +
> >  drivers/clk/meson/t7-peripherals.c            | 6368 +++++++++++++++++
> >  drivers/clk/meson/t7-peripherals.h            |  131 +
> >  drivers/clk/meson/t7-pll.c                    | 1543 ++++
> >  drivers/clk/meson/t7-pll.h                    |   83 +
> >  .../clock/amlogic,t7-peripherals-clkc.h       |  410 ++
> >  .../dt-bindings/clock/amlogic,t7-pll-clkc.h   |   69 +
> >  8 files changed, 8631 insertions(+)
> >  create mode 100644 drivers/clk/meson/t7-peripherals.c
> >  create mode 100644 drivers/clk/meson/t7-peripherals.h
> >  create mode 100644 drivers/clk/meson/t7-pll.c
> >  create mode 100644 drivers/clk/meson/t7-pll.h
>
> >  create mode 100644 include/dt-bindings/clock/amlogic,t7-peripherals-cl=
kc.h
> >  create mode 100644 include/dt-bindings/clock/amlogic,t7-pll-clkc.h
>
> I'm assuming since this is an RFC you know these go in a separate patch
> with the DT binding schema which is missing.
>
> Rob

Yes, This would be a few patches at least. The thing right now is to
get it to work.
I think some obscure thing is missing when setting up these clocks,
and only Amlogic knows.

After I have a working driver, I will submit a proper patch series
with documentation for the drivers and device trees.

Thanks
Lucas Tanure

