Return-Path: <linux-kernel+bounces-65195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA5854941
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9CD1C21E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00A48CEC;
	Wed, 14 Feb 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4RVRHfB"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4A487BF;
	Wed, 14 Feb 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913973; cv=none; b=XasEzEihXAAOK9x/yNZ5wtazUj1byUff7ivi2PPp9OOQNX5pa3gPt+IC/qBLc8gh6L6vZnJ45KnVxhdcfjI7radPsbaSlvR1/G/8pOYoCNMJKqyUoa8MuyWx39GRoV9fxOgaMD8sc3NFDEUj6XqxO5gNLLTmVD9sDmy/DuYguSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913973; c=relaxed/simple;
	bh=dPtWFbe9ncomcuz14UEKUw0b6c7nUIN51XsH8rzmQWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp6t4/+ViHV3Vae5KT/q7T4LLlQ/5HVPq/+tgrQCTFYO7Mq2hVmtTthCk1cqgxGRe3HeF90iMU8qfJfRCD7o/4828vZJu0p+pZpaNemT5DqjqlGUkGWesUL0GCMnGSXx8X6dKEKR9C9pxkMLTvXRoCcx56RxR8biqzRsegs0+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4RVRHfB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cedfc32250so4060572a12.0;
        Wed, 14 Feb 2024 04:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707913971; x=1708518771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1Ye0dunwLazzlcONdORYQz6R5DZTpTLJFqvm1NaBMM=;
        b=L4RVRHfB19RkkRl0nH3ATnSVRvff+UsjyYiUAG3rMollnecGgnKQ60GKb5LLVJpaPm
         jX5xGuY8Punh1PulT9K+cPRjuJuMfwRxJQxCXmQ+EPzBozdGh89bAI6AxDHlknIN/6z2
         JpPDh7u72EUT2cl+tDAWk9Jg4VyMA0sPj8KylTVaEyvnldKD8ATCddkd3QtW5KD/q6j0
         ksM4eEIeFufZXbjH0DMC//TYN21y4o8tNy2SWKcxQdD7DwwH8PfMnrJ+FFEz+E00fnlx
         Tlpe19awLpC0AKHxWaBy+NTxzeHDTfn58ouOdzAJd20JJ14F7pNAR/WUpT86qjRFHjuz
         tyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707913971; x=1708518771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1Ye0dunwLazzlcONdORYQz6R5DZTpTLJFqvm1NaBMM=;
        b=EVQsWJJvDNr3pQX7/JrJATVOUv8dwbb3wHPl99JOFq5i9Oq7SmnJAa41loKFkyL94w
         Fnhf/T6jsRSdqLqmiRB8kdl1xTMSwbpW4DB47Y9+8p5q20lGk3x8buAqcS0F3eda4g3D
         ZQ4KoNTwQcrqOeH8PS0AEQ6IHaNXevNFPSk3U3P7mASidcipzOYF4TNIoDYgocx8ntEp
         dYgGHGOzUivKJc9VOgADMTrslzUDp6w5WFqQUmOY+F9/+t6EDBKg+d0TCcIQTozYEPHB
         MEKq3jrS/YFEmFkUMQo+mtIFzXYw4/TuWm/d/RXDt/HUMgcEofueUA2+AeajCZaYHfkN
         rxKA==
X-Forwarded-Encrypted: i=1; AJvYcCW7G4XtPGgsmcnASLc9AZuQ4PECHXS5OV3tHdUY9puhutFFmjN6haV6fSzAKn7XiPCbIM7wKCurkfjLPpWVA8y7T0ITeJNzIDvjr+WIr+58Go/Pxybpd0RW5K+TUcFS81pp+D1IAICCBQ==
X-Gm-Message-State: AOJu0Ywq+wjOkhe3qUgMk7JbGmdIJ/7NZ1ZOxXTDyhze3eYzlBWF5pHv
	UsnH7uPrhXrz+PysgTzgMAEOdHRMNNvJgHsZJnYCcez8gtfCLyhkJVKhGZFZ9Tdh78C8wgDKZ1k
	su2HcwSaFeWzII18dToTbs4A5pc4=
X-Google-Smtp-Source: AGHT+IHVmdw1nY0+4qD7E7k6QaVH+5XJQDDsj/LW3oDNKR06kE80kLwbeGs6MxsY6a+Qs73lI5I8l/GC4hlcwQZRmYY=
X-Received: by 2002:a17:90a:f407:b0:296:2f49:6c04 with SMTP id
 ch7-20020a17090af40700b002962f496c04mr2192291pjb.19.1707913971359; Wed, 14
 Feb 2024 04:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210204606.11944-1-aford173@gmail.com> <20240210204606.11944-2-aford173@gmail.com>
 <20240214121438.331a9f20@booty>
In-Reply-To: <20240214121438.331a9f20@booty>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 14 Feb 2024 06:32:40 -0600
Message-ID: <CAHCN7x+y9bcdEqDkpma1oaY88WvjHsWUOm55B4XNsPy5HM_-vw@mail.gmail.com>
Subject: Re: [PATCH V4 1/6] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:14=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hi Adam,
>
> On Sat, 10 Feb 2024 14:45:57 -0600
> Adam Ford <aford173@gmail.com> wrote:
>
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > Add a DT binding for the HDMI PHY found on the i.MX8MP SoC.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> I was a bit puzzled by this v4 series as it comes after v8... however
> thanks for keeping up!

It was confusing to me to try and figure out where the latest of each
of the various components were found.  I tried to explain it in the
cover letter, but basically the previous V8 was due to the fact that
some portion of it had been attempted 7 times.  When it was brought to
my attention that the PHY driver I used was not he right one and the
HDMI-TX and the PVI driver were already applied, I reverted to using
the revision history of the version of the PHY driver I pulled which
was V3 and with my changes became V4.

I debated on making this V9, but inreality this code was only
attempted 3 times, and the subsequent device tree stuff had undergone
some changes, but it was easier to keep them paired together with the
PHY driver so the series could be applied as a whole.

I will be making a V5 due to some build-bot feedback and your
feedback, but I'll be sure to pull your tags when I try again.  I just
want to give people around a week to mull it over and test it.

adam
>
> This patch is identical to the v8 I already reviewed, so:
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

