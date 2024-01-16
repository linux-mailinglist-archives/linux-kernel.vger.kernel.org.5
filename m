Return-Path: <linux-kernel+bounces-27958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6134482F853
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF21C24E12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED64130E5C;
	Tue, 16 Jan 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhndZ5PJ"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B296130E4F;
	Tue, 16 Jan 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434688; cv=none; b=euMd0lYYpvbBiBnJLzEe1P697HhyuvkLw1AMbN5jE5X5Qu8jeIoCuBaLgCaifCzuoNM8tmuMY/HkM5yCWr6XlPXkIWPLxzCBaNOdt/1qGauNRZrJO8bkaqRuW7uuBMRJW3q7+glD2hLeDh9hOTfs0TGex4jhTA8J0R8EBaVqkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434688; c=relaxed/simple;
	bh=8LNFAiNLxDK9BNpZe1yap94I2WcbyLVKDUX+vZ5KaBQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=D5TeW1AC5SW66Rh/M+2k5NJYzJTSvn9jSFvMIkEdgNGs0iCQVKkrX/+gG2Lv7qzAyL1d0imBtQexujygqaL9hYCxRUAHilGBIRdWTLooUkTOw4d9X2NUQltvfFpynO4wzDkZrUPVoQkioJoaNaVrQYJE9KckgzDRpWJoo9ajSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhndZ5PJ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed4b84667so9604472276.0;
        Tue, 16 Jan 2024 11:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705434685; x=1706039485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K8w04xiJGT72J3l5pZYydZFnp7VG18KNZBIm6eg0WXU=;
        b=ZhndZ5PJmmeC7K11+j75TJ+jargGUCHC4OeVaOK/SjRtsuBWvD/V9Wpzg/AyPqXkku
         1Wc3jXyhonOnE7xkkpmcgTPhT1DkbwbVsdFELECY6KXrSZBcVQNgEoaMc1MEJ8WYimK5
         k0+vYaRAz+ACl1MKOaAObtLxN+sPvuy1uJJBKo6vHL7p6gaAO1wDQCQZHuheVttnUHvP
         d+pYcFcenLOP+bu9tAThFs51K97bRTp2w7a0AubNz7btfw8bBiDbEMaoDrLRR8PDLSK6
         Vxmf6E/bggwxD/F4PutNEnTp9UHMLWuH0HQamzXWaGof5x71hxCDID/lRGfACMu8enaq
         ql1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705434685; x=1706039485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8w04xiJGT72J3l5pZYydZFnp7VG18KNZBIm6eg0WXU=;
        b=QvzTYrBnAnY6Ncifi0VW7nBOWLhK8rT6qrli2WHqUEtPaL5l1rLvx4WDpxQExLZAKK
         B/MbDXRe5/In5ZVdzwwfO6QcaCzSOnQ7agdW+uQVWPvLDRkDbO9ze7TRVxk5/q/6hvpc
         L1HTHzdFNaWxynb4wWoqa1mgLFziTzIk7xmBhrV9xvPxr/0ISbb95k9Urj+G5af8fABd
         KsDQgrk/2c69pKOt13VHqpT6HU+lCVqMZCg7G5pKYdRPy/kbmucv2wFvEwDF2LpbuN0/
         AM3yP7FREM/ZJ6YzfroK/NFx5sir9tZNcud4U9nkfuqjfU/P7zE5fAp9Pep60XLmfCSK
         IPww==
X-Gm-Message-State: AOJu0YzENZgs6D/MVl0bGIsR7fT4SflMd6wKAPj/7X+7qdQMO23Xdufg
	5GTVSVo+4XkmN/dmOWbseoUbHD2KGooTMyq128I=
X-Google-Smtp-Source: AGHT+IEcHHyG+hJdFrG3M4zsgP7m+03vGfwWM2Y7XjxHTSXuNkOfPFJRl4DAeDiaEXh4RoBm4dUCzVDv8eYRlr6MSWI=
X-Received: by 2002:a25:910:0:b0:dc2:266a:7814 with SMTP id
 16-20020a250910000000b00dc2266a7814mr1142886ybj.120.1705434685611; Tue, 16
 Jan 2024 11:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-4-tmaimon77@gmail.com>
 <99eca166-7d78-4ada-ac0a-ad67f3d8eb33@linaro.org>
In-Reply-To: <99eca166-7d78-4ada-ac0a-ad67f3d8eb33@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 16 Jan 2024 21:51:14 +0200
Message-ID: <CAP6Zq1g7NoLVbAUyeQ8jm3qZvjLV6HSVZB+r-X7dxvVNtvddPg@mail.gmail.com>
Subject: Re: [PATCH v22 3/8] arm: dts: nuvoton: npcm7xx: modify rst syscon node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your comment.

On Wed, 10 Jan 2024 at 23:01, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 14:54, Tomer Maimon wrote:
> > rst node name and compatible property modified since clock and reset are
> > handled in the same memory region.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> > index 868454ae6bde..f72c5a03d04c 100644
> > --- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> > +++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> > @@ -93,8 +93,8 @@ gcr: gcr@800000 {
> >                       reg = <0x800000 0x1000>;
> >               };
> >
> > -             rst: rst@801000 {
> > -                     compatible = "nuvoton,npcm750-rst", "syscon", "simple-mfd";
> > +             clk_rst: syscon@801000 {
> > +                     compatible = "nuvoton,npcm750-clk-rst", "syscon", "simple-mfd";
>
> NAK. This breakes the users, is not justified, is not explained.
Sorry, I didn't understand, which user it is breaking? there isn't a
device tree node that uses the rst node.
Should I explain it better in the commit message?
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer

