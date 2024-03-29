Return-Path: <linux-kernel+bounces-124391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA98916DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F311F2418C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8D4F20C;
	Fri, 29 Mar 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZP8lEPHa"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B04AEDF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708162; cv=none; b=C2JplyRZNH+cbBhbEV0cr+xSAuFrwhUiLSBJRQOPZgBfZg5hC9Av57zA991hl5oV3WKFgpgf6g2LE8P75cNF92WrbrDva/vIAaauFVbudRD3Ei1zKc32dCRTitc7d0u5BRpZH49/EHg7SLfW3NC4T/xNrZFzYAsV7biSnrKErR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708162; c=relaxed/simple;
	bh=+OfxbxIfen7xneKiEQ9eib/06LItZz8en2rFakQ6oNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miwEajZQZ4XDJKGiKPVO20RaQIble0L/hWZYXv/Axty4/26IdKvA4m+rYi9M1SzQcMHrHvQXw9xxh4KgtepDv+Rvedn7XReFiToaEjVKLhIny92I66wpoE2IyPXpJ0dwfpr8Y9PylNzZpa34ztRNdiGo3bcr5in3okmik5palt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZP8lEPHa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-515a68d45faso1829394e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711708159; x=1712312959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1xMjM+6aRGQ0ojnpGkzeXSIPQCNkcUYgWEAekM4AZs=;
        b=ZP8lEPHa1Rg5ROEeQLwGIGLBEwe8D3K0JOE03M7//YS6QiWfBM4FBhb09+pvDpOcKB
         lDrkcHDoId73V6VgQXELeJD4irjtOG3+vfP68yUNmIk1CCVmsAMaCei7g3SBocN6E380
         gmU/ItjpxLlto0J21GPYUHIN1YfEB6lPWW7C/5jeWtfoIIaX17vk84Z8AjLwAcgymXqq
         cm2gBJsN1E/cCu1uCZhcHgS0qLmAI0zb2YET2Gua0OSYWojjqS8SOCUJvwF6NNvb10Jv
         Wf3Hi4pVq8djRTdbt4r7V4iLZ8xm66U2WBqYbES8EeK5/fIJQbpNjf3VuVxP1l4+LQq7
         SaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708159; x=1712312959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1xMjM+6aRGQ0ojnpGkzeXSIPQCNkcUYgWEAekM4AZs=;
        b=tZXpbowwol+safIDITbxCP1AXAOu3I7vI17KJ+Z5aaUGcFnBgxkO6sLil96r3G79+K
         igFexxmAi+edNOEc7kHtEey/iKBBvFxS48EM6tgrKfKMC1TXjJaCB36HV5bPFjFHK2cT
         4KMLuAKZqFgTayn6kQO4CcLikn6Nr7iusNAh94VlVmIK+NDdW7Mfk85irnvfPWznyLco
         jBTD7IxhCjbGRzbtLKSCAvuE/17EtVhbI/p8KNjfFocMwQQcQvmpQxRwBEP149fuf2co
         iR7GW95zvazyJ6SZWNVmXfHbKeMEU1ghGTL5gUXDep7WiCCfqxCVqs4xoIj6m+1dRk/A
         BV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbSej80Tmgyiv8plO2EojgW9SkMg46HBLdt1Y2nfp1QkqaX9+0R1hzGdSUvgjUHO6/EXrUS1Rd4Ros+925VDcimE33I/f4d7ohi7uL
X-Gm-Message-State: AOJu0Yz1zZGCocS7tG52jZdf9SDP4Ib3pWtSNnJJbfTG+Xu489vZ8b99
	jo3IMGGRjO3i4vUk8xPEzaS97vxgkrnHqwQm6q3UCZCNCH8uIuDBulNwsqti8QJDtPRCZAzfaNW
	Km82BvOqHvUddfKssPiKI5AgzzdfgNaeU4lLjJA==
X-Google-Smtp-Source: AGHT+IFf1CNNBqLUzGwlQt3plBwsiRGnRlRofcvJpqCa5fkmx12mwCxpLy9gpfToW29g1IssLHz467H64sFTESJvcbo=
X-Received: by 2002:a19:a408:0:b0:515:ad80:566e with SMTP id
 q8-20020a19a408000000b00515ad80566emr1308393lfc.27.1711708158926; Fri, 29 Mar
 2024 03:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-parkway-dodgy-f0fe1fa20892@spud> <20240327-overrate-overuse-1e32abccd001@spud>
In-Reply-To: <20240327-overrate-overuse-1e32abccd001@spud>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 29 Mar 2024 11:29:08 +0100
Message-ID: <CAMRc=Mdkxh_Soc6Uy5vYrh5Svdc=hBBRwdAoGbU04V=We=YWZQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] dt-bindings: gpio: mpfs: allow gpio-line-names
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:25=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> From: Jamie Gibbons <jamie.gibbons@microchip.com>
>
> The BeagleV Fire devicetree will make use of gpio-line-names, allow it
> in the binding.
>
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.y=
aml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> index 6884dacb2865..d61569b3f15b 100644
> --- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> @@ -44,6 +44,7 @@ properties:
>      default: 32
>
>    gpio-controller: true
> +  gpio-line-names: true
>
>  patternProperties:
>    "^.+-hog(-[0-9]+)?$":
> --
> 2.43.0
>

Applied, thanks!

Bart

