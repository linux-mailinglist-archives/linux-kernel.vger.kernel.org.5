Return-Path: <linux-kernel+bounces-147553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D918A762A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7ABB22E23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E335A0F9;
	Tue, 16 Apr 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sluXXdnc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B61E864
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302047; cv=none; b=oSJAxxOxr9XLx39C3zj775El2YJtvxW8h1xz7zEyGWNgBCOSsCYlSCoCzkU1DHeJOBWD8y/BOZ4I+MmwOz61fl2Yqqelvp0udnm2eOfpIhjIhL4Vq5+BoKvbrxbSmQzB5TMPm8mps1uqzwb9eiuv67YhMKgha4XjnjgqvPoqePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302047; c=relaxed/simple;
	bh=hYbx6PTsoNsyBmCWhe2uOm9re81gqj53ZsseQt9fWB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVFeXxlw05Y8I5NM/2kNZ1ztTk6sdA6FAik1m9Jyeh7AkDwE1PZX6toEvIIEdc8DuV1sK8J49JOyjgcMhqiohuOaP7FFdKKWCJhWTtQs9o+uWKjRxFwJ2l0X3SUc87aGcfrvx+3xDYsJcHnKU8JvszYq/Yo8UOUm5ZisescpBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sluXXdnc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516ef30b16eso5826293e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713302044; x=1713906844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn04wT0JBm+obxx+kTlgG9j7vzEDda0ye02bvz0wRxM=;
        b=sluXXdnc6zdIs4x9p+gDWVyfXHvhECnrb0kh/6H9CxC3yxUcvbKWCW0Ape+I8l0i9U
         W9ZeZobz1qmCW39geKwWfPYrDAlXPXVifNNvv0bawPASmEwmF/LA7J7lhrApjyRLiVdz
         4TfEeajCgDREwrov0hKC7Oshdsam1q91u7msP2RoulU+sgsY5fMr97QSxD8uP8N59sWL
         Qx9+/BUHXLKoV7+5P2fzGXyBJ18ZWyTIXK51qTFC0RkJcsi16/6w7O8ixhVzxWcWUVfN
         wVla90dAB15OGkhRWafEYM+wi7txvBODZ5xK2eEAo1/bXudY99irrjauwtSz9rUBodwX
         fctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302044; x=1713906844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn04wT0JBm+obxx+kTlgG9j7vzEDda0ye02bvz0wRxM=;
        b=kpNQJAMsLby2RxVCadJhTbqYo0+QR8Ffs0eC5ffhmiPQ4I8YsbP0SC+L+TAT8rVyDg
         nvYT0viixyVqrPlhZYyxiufEY+7cYpBY0vALRVM4fUKQoOmj4e5awkO4CwFwIhLosXOq
         2jLavFTsy7Fgzf8X+ZJGhhXml7NvnWOwebzurw591/a20hj+uZXduxS3WL4e5MKVCh9l
         TJVri2UTrAIs8fdzg7j+FIxyJL1GphUC5IUurgrhZWRoDmnf9j4E6RjeDc9pmCNnHyw9
         b/VyZ7lhwXMrAM+GQdLtU1Aik+a/V3uj0FAmBCdx7zeWXIgq2p9QM5wv6sev5lGt7OdK
         Ow0A==
X-Forwarded-Encrypted: i=1; AJvYcCUWZRLUE2eSnYy/EdIkb+RUJXRtWm6AfGxyGfbswstPH8EBVP850zs3LM6F5CmasqrOOKo7FrLo+UnCrb5Q5jaBjG7kMoLCAevL4KWF
X-Gm-Message-State: AOJu0YykqLmAlWZBJnD3seDxBE89q1uKWXR885qZuGDx/+sRImzbkYTh
	PQ3oWwIGfadYRvWKdyKdWDHC6mIElxV1TIfS423TwhVeWe9Df5A8YeqMN11yjpbDj5Q1QPO2F3s
	zLhsLg56fwGBPb+j1GI3ZVZcDuG6m+8WnvTPZJnEY86JZyuEV+ws=
X-Google-Smtp-Source: AGHT+IGAyUGV6VvWLvHMDAGW8JKzTq1oIDcVu3L+TgdMnw0Thj8YRZxvbWr+f5vVYXNKQFG5YhxvVU34ldmvzwxme38=
X-Received: by 2002:a19:8c49:0:b0:517:87ba:aff3 with SMTP id
 i9-20020a198c49000000b0051787baaff3mr9237406lfj.43.1713302044303; Tue, 16 Apr
 2024 14:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415131104.2807041-1-robh@kernel.org>
In-Reply-To: <20240415131104.2807041-1-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Apr 2024 23:13:53 +0200
Message-ID: <CAMRc=Mf+tFOCawEf=hmAYyBQMyMpPrXTrNhK3J19BM4Gx6zh6g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: eeprom: at24: Fix ST M24C64-D compatible schema
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Marek Vasut <marex@denx.de>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:11=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> The schema for the ST M24C64-D compatible string doesn't work.
> Validation fails as the 'd-wl' suffix is not added to the preceeding
> schema which defines the entries and vendors. The actual users are
> incorrect as well because the vendor is listed as Atmel whereas the
> part is made by ST.
>
> As this part doesn't appear to have multiple vendors, move it to its own
> entry.
>
> Fixes: 0997ff1fc143 ("dt-bindings: at24: add ST M24C64-D Additional Write=
 lockable page")
> Fixes: c761068f484c ("dt-bindings: at24: add ST M24C32-D Additional Write=
 lockable page")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documen=
tation/devicetree/bindings/eeprom/at24.yaml
> index 1812ef31d5f1..3c36cd0510de 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -68,14 +68,10 @@ properties:
>                    pattern: cs16$
>                - items:
>                    pattern: c32$
> -              - items:
> -                  pattern: c32d-wl$
>                - items:
>                    pattern: cs32$
>                - items:
>                    pattern: c64$
> -              - items:
> -                  pattern: c64d-wl$
>                - items:
>                    pattern: cs64$
>                - items:
> @@ -136,6 +132,7 @@ properties:
>                - renesas,r1ex24128
>                - samsung,s524ad0xd1
>            - const: atmel,24c128
> +      - pattern: '^atmel,24c(32|64)d-wl$' # Actual vendor is st
>
>    label:
>      description: Descriptive name of the EEPROM.
> --
> 2.43.0
>

Applied, thanks!

Bart

