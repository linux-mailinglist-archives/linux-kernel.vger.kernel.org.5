Return-Path: <linux-kernel+bounces-2341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4E815B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F48284BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27D321AB;
	Sat, 16 Dec 2023 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iscJyetl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FC31A6F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A61B63F2C5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702754682;
	bh=arp4KgnNalvlcscGqi/VgrS8JYrKrYTVbwSx1z/f2Zk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=iscJyetlYx/Qnbmo/VkOHDYJiCr4Rk8y/rSSWRPM/rY61Og3jIV6/7uBwigcl8MsO
	 nEh1GHEqwlbBs9B+EMeRoFZiGLe/23dIWe0Bt2o0mReBGGkHQYap0cNVByxdnc+34T
	 h+EQOsZLiewz3AMDlS0z8NoYPv+MQTVijewBcp4PzNDh0HHueJkQssF8moXHX8o5eC
	 8C711SnZsGtXNF7Wy8UR1dZ8YDwUp3X1QYK+Eyvb/xZ2E25GE2Hj3Bq5sfVVgZ1xQ3
	 JzKqk2z4sTzvWQl/s7n/Wp8SsYk1vGvyI+zOUTjy5iif0RoJDF9iodY/x3Jn+B5/Mm
	 HhCVXkepkTWPg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-425d5915c69so33720341cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 11:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702754681; x=1703359481;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arp4KgnNalvlcscGqi/VgrS8JYrKrYTVbwSx1z/f2Zk=;
        b=qEqyLa5+4fUf7G169P+VhFegroEzOr8CA7QiRXewG/c/TbOQOVqu7uNdFiI7ZKQxuV
         feTKd3fzkY0HvwnUhE5qjfqIJ4/+kXnAqGQI2/A9xu/te6zsbe+fUy4bhQhzeWL7Au9/
         Wh0ODhz+a266nmETQpvgmxz1Z7z1pB35pM7M47UNdAI6ZDwbHIcltApvaU563aHm0GMy
         eGTUv29JZy2Ol9FlBqfpquxyKUQiDlHoqrO4XTmi3zFK5Dohs+4uRSRwGtOC4tceAfgI
         Y/804miIrzkd98RnBIemvv2W/LZH9N+efTMywKNq00ELIp4uYIt0JmXA4+EWcUxS10cU
         m2fw==
X-Gm-Message-State: AOJu0YzTLnFtcMbAyWIg/YX8r1OPkFGhv1H5+SbCPxW/Zwk3kRBCPd2w
	Wl5djeHm9dPpTJ1maGieeCcqdcNcXs3gqFWssVyj6jO7/VLB0vtafGes1/ZEhXF0eG8US9PXnSq
	14VhIOW2K710aEa8jLGBJK0WsQ+Kap4h7apxirnjXtMz6t9Ip3xv5xiQRaA==
X-Received: by 2002:a05:622a:1cf:b0:418:1565:ed50 with SMTP id t15-20020a05622a01cf00b004181565ed50mr17632929qtw.66.1702754681669;
        Sat, 16 Dec 2023 11:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh1FB45qk7mcuI2qHGO1vj4JgeCLK0ZvhpRnKj5MhPIcHzu1iD+2wJffax6hiqvMJOiTseak4ew2mkMkdlIE8=
X-Received: by 2002:a05:622a:1cf:b0:418:1565:ed50 with SMTP id
 t15-20020a05622a01cf00b004181565ed50mr17632917qtw.66.1702754681432; Sat, 16
 Dec 2023 11:24:41 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 16 Dec 2023 11:24:40 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <698fbb5d-0750-4f2a-857f-5429e5f589f9@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
 <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com> <698fbb5d-0750-4f2a-857f-5429e5f589f9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 16 Dec 2023 11:24:40 -0800
Message-ID: <CAJM55Z-e8mkjac-nCF9_w6EmMVbL9ued0mAcjwTMF=pKDLkMsA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> On 11/28/23 02:40, Cristian Ciocaltea wrote:
> > On 11/26/23 23:10, Emil Renner Berthing wrote:
> >> Cristian Ciocaltea wrote:
> >>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> >>> RGMII-ID.
> >>>
>
> [...]
>
> >> You've alse removed the phy reset gpio on the Starlight board:
> >>
> >>   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
> >>
> >> Why?
> >
> > I missed this in v1 as the gmac handling was done exclusively in
> > jh7100-common. Thanks for noticing!
>
> Hi Emil,
>
> I think the reset doesn't actually trigger because "snps,reset-gpios" is
> not a valid property, it should have been "snps,reset-gpio" (without the
> trailing "s").
>
> However, this seems to be deprecated now, and the recommended approach
> would be to define the reset gpio in the phy node, which I did in [1].
>
> Hopefully this won't cause any unexpected behaviour. Otherwise we should
> probably simply drop it.
>
> [1]: https://lore.kernel.org/lkml/20231215204050.2296404-8-cristian.ciocaltea@collabora.com/

Oh, nice catch! With your v3 patches the Starlight board still works fine and
GPIO63 is correctly grabbed and used for "PHY reset".

/Emil

