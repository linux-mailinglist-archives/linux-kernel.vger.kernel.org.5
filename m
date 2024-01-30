Return-Path: <linux-kernel+bounces-44977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311008429E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F511C21207
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159A4128385;
	Tue, 30 Jan 2024 16:48:49 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5186ADC;
	Tue, 30 Jan 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633328; cv=none; b=Ti2MHsycK4JOCdEvhweV6zRtrVKpbGDYo3lqSrH4LxAKuHEgDIC6hgsI4Vpk/plIg1ncnoCDIrRXB4m7/YNowNrcHFYmpuYX6fge+VVVFTpyDEoq0yZ4prM+byezhvWBHbiTKKR2Ar3iP1enM59ruMSmxzA8aAe3zZV91ThLKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633328; c=relaxed/simple;
	bh=jcj/XOzMZdXXBsQOJGQhpF4lWYN3lxOsRJ1/9mg/Sf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saWrrwPUECam3mcmsdJXBoSQfntAafJc/AMYDqT1e9EIUtZomfcelNTkRCMgtA7sB89t3iehohuU4R+lAmQ4FrJl08SgVCo8EfgSdUjIs2l8yn41QlaDbiq5RpbFgtbln4DpeVf9zZYThNAou7s0PmENwew67cX9RLh4WU4HQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2514909b6e.3;
        Tue, 30 Jan 2024 08:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633325; x=1707238125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+4tYl7sgEaPamnUJAXxXqFC7JS0yxLYZqNBS3Zyq74=;
        b=J8rs1uZ4DaDuwaZRxVW0bG3puLu9eu1wL5QAFLw4TgH5qwnKd5QmsJal5yAK9MXTuC
         p792bx3IvnGh6pqBNWMmjWgMA1Vjk0ljbiW3MU0fhdLV3wd7sCD+vlwp43CSb7MhEL+z
         nAchbWCkJ0cAPedr5dMjgaSbwXudUuBFxH7xTjr5N8ZClRYT/eyde0gYx8k/+fiWUXzC
         hrcez4LFQotHcxeq5s3D8n6lhthh3jrtj5HbtIguvty0IzRadBKvJZa1Z4+yMg2e3yXu
         joRZxHyoXHnHDjccozZF+6KSWzj7AEBnfcyI8YAD9fWhws36sjQz5EaaJTw7B8wVRoKW
         HuAw==
X-Gm-Message-State: AOJu0YxQEp1hlUpysjSgdzzq/8Xb6IzznqYl8Fs+Oiw8nKzdW08GNbIC
	r73jf4V7U2iknzgfpboRJMQrjE5wUCQouxw+smXBGiNjzBGkJyFmEYy8bgOxGEo=
X-Google-Smtp-Source: AGHT+IG518jY6K0kWJ7QRUQlQTJVD3dNZeVB7PK0IRTD27gWlnK2Yfanf/tgYhsyGb/mg9p78PZpRg==
X-Received: by 2002:a05:6870:a902:b0:210:ac52:bc0e with SMTP id eq2-20020a056870a90200b00210ac52bc0emr6430134oab.27.1706633325543;
        Tue, 30 Jan 2024 08:48:45 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id i3-20020a9d6503000000b006dc02337dafsm2008037otl.16.2024.01.30.08.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:48:45 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2514893b6e.3;
        Tue, 30 Jan 2024 08:48:44 -0800 (PST)
X-Received: by 2002:a05:6808:1442:b0:3be:2f6e:5a93 with SMTP id
 x2-20020a056808144200b003be2f6e5a93mr6807319oiv.14.1706633324679; Tue, 30 Jan
 2024 08:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com> <20240122111115.2861835-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240122111115.2861835-9-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 17:48:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYnFJDyrEresJ4YgnVXkAAuVSbQOu-opcxMSweQs=_rQ@mail.gmail.com>
Message-ID: <CAMuHMdVYnFJDyrEresJ4YgnVXkAAuVSbQOu-opcxMSweQs=_rQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thanks for your patch!

On Mon, Jan 22, 2024 at 12:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document the support for the watchdog IP available on RZ/G3S SoC. The
> watchdog IP available on RZ/G3S SoC is identical to the one found on
> RZ/G2UL SoC.

Or RZ/G2L, which is considered the baseline here.

>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

