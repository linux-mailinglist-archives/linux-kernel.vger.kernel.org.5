Return-Path: <linux-kernel+bounces-91881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3878717CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F21C20319
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25180034;
	Tue,  5 Mar 2024 08:14:18 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6C7EEFD;
	Tue,  5 Mar 2024 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626457; cv=none; b=Rxs85vaZN0Oh/M32++kRYCQiDIfIhKhpVnNf216tG7V0ihK3H5iThGpjEgEynkf/fT0OaBfoWm5uLVjaIAJcvvoLBEclHEzolzB0CmccMRuIRWobpz+JHY+77YWUEQ3vmsPqqvU6PpFJa9TZPwHE30Jj10T0GXbvMJWetG5iyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626457; c=relaxed/simple;
	bh=sdkbL0j1WDTfzOeFdax57xNB3etUtS+GxE2k2CRgZs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDwZ2KQkpq3L0DuIYxhEoHmTTfy7zNi+/5gFw78vh2fw0vKbgz2U3vagMxcFDPodSWFVIQNFMR1itYZYfVEyB9YnqTcPE0+9XR6rcyeTmJdxRoPahaZIybpkJ//fVAdysU/lnFqLpGYwVSVkCNGzqYWc2aNkXxIOUVqHTaWEZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6098bf69909so30344937b3.1;
        Tue, 05 Mar 2024 00:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626454; x=1710231254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/PGxtgAIaNlRumVOAqmpGsRhzvUMbZ5jyQA7IZ7SLc=;
        b=ismwGYkxuWSJcLLu4/7t30aAh8HyCBPRoJ3E4XKy7qYlDjwEkXs06EMkuYgcex1svG
         AKg9r/8ENgH0WrWsRJOMUJoG5NG3P2VRT1Vy1bQf7Nos4kCcm0dCb58uSppdCd30/SB+
         sYB2Rp1MIVUrKpcoSoruLHT9+eQd0GjeG78lh3Gl46ZQz+jB8TCcKOGa5Cu26tOvpO+L
         yfFKt6u1Eg/BlXFnh0BLZq4z7EEuIrJEIwFDpWA39XXNug/hpbK701gt0FNjJXb2oIcY
         GsZc16jz1VxE0cmQqiEEYjCBbYUWoPJKbaivE3mfyaJhE13Ms5A3gWftQZuQXhVD4GEH
         jtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTmwD6gSADtWpvKDbgLGvRCRVyzqR1TpureCv7GWNCe1BRa64EIwAmV7ZqgVYZVqfQMm5MR6YdJ9+RRY96yHsxCkG4D5UoRSewoweJa84qYeaNOuJEstABF+Z1xu5mAYzmnJVnfs5AGqKH6/I0uPuUC/9WCMitnA+4C+o1HTDvmrR32/E=
X-Gm-Message-State: AOJu0Yy7GArQ1bPkt7vhSUKYyvL3WK5Xq8bvkGAASQEh+C9rBUXF+y0E
	7886buCzvNDz9iFVj/sJ9rb5b9bpElT8pV6PAoWQl8XhnVa1+WWjSOEC8oiWEes=
X-Google-Smtp-Source: AGHT+IEPMjVoeyDtKFnxJjQxc3RlnLtRTMv8Uy1TA+pBy3lUFDY8++Si8Wgu0iT6vUYDqjYyWZbqgw==
X-Received: by 2002:a0d:cac9:0:b0:609:892e:b944 with SMTP id m192-20020a0dcac9000000b00609892eb944mr1388875ywd.4.1709626454054;
        Tue, 05 Mar 2024 00:14:14 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id r12-20020a81e40c000000b00607c3904416sm2977288ywl.40.2024.03.05.00.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:14:12 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so6051907276.0;
        Tue, 05 Mar 2024 00:14:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgK8caQANrK8oebiAEEtj597THcsbm+hLRHX/kpokKHmZAzzJPA0eaucpoWoBWAfF+Cm5FU2N6kDgu4iOpFHZb4HpNZEPuPJHlNdCZZoBg7paQmn7wP0fgO8sNDz/KZ85sTgBILk8ULOKplZC2OUtk3sL3BpwGhIpIb0cJ4yb/bI3NjQo=
X-Received: by 2002:a05:6902:248f:b0:dc2:271a:3799 with SMTP id
 ds15-20020a056902248f00b00dc2271a3799mr1604789ybb.23.1709626452674; Tue, 05
 Mar 2024 00:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz> <20240305035853.916430-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240305035853.916430-2-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Mar 2024 09:14:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYuucVQDor3na-iT+Jmsktr+vCVjQXGUA6vXd6-mXxmA@mail.gmail.com>
Message-ID: <CAMuHMdUYuucVQDor3na-iT+Jmsktr+vCVjQXGUA6vXd6-mXxmA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] auxdisplay: Add 7-segment LED display driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, lee@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Mar 5, 2024 at 4:59=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Add a driver for a 7-segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14-segment displays in the future.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v4:
>     - Fix one more usage of 7 segment
>     - Move ASCII art diagram to DT binding
>     - Include map_to_7segment.h for map_to_seg7()
>     - Use initialiser for values in seg_led_update

Thanks for the update!

> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -211,6 +211,16 @@ config ARM_CHARLCD
>           line and the Linux version on the second line, but that's
>           still useful.
>
> +config SEG_LED_GPIO
> +       tristate "Generic 7-segment LED display"

"depends on GPIOLIB || COMPILE_TEST"?

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

