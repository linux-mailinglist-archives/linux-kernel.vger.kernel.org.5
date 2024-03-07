Return-Path: <linux-kernel+bounces-95158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF8874A05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAC41C2210E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C482D70;
	Thu,  7 Mar 2024 08:44:56 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640A82883;
	Thu,  7 Mar 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801096; cv=none; b=YDeTMo/aK0u5PL4VKGvxrcH/fewEIkyjiN32Sh0S1VWftRXneGDPBZxYC+6J072cz2NOfi4OVaZe9u5a9DQ/GtnOQcgEgpP7dfEIhHgZjmnphhkmPWXbzfG8qKLTcg5n5u+TBKaQnK9HtT+voX6q/hbg/Fv8CESZKAXX97g0KCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801096; c=relaxed/simple;
	bh=fZTndBaRGIc7XTnn+2HLU5SFyVILvATus03elPoOvG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eawnzU4w8EpNqrXE556NBF5imMCx4EZbtzt4ryTx7/pkk4w9VMcxWpMLjG9SFXfBOjxlGQ6TZq0AR/feG/cpldcWuS0tVSIXT6G1MiE02TmRAiJONbh0cjx53PNX5GwnhX8EcdzxhEzeSComY+zXunr3BQfUOu0W9U4YNI9eohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so595349276.2;
        Thu, 07 Mar 2024 00:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801092; x=1710405892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6KGx5cJC7n/o7O+84TUUVjMC/DZFxOfsHhOH0F6S8s=;
        b=tKSleO7PtgGA83MgoTaijIjyZNmLtMN3Ne+0gHcGuzR0geJmh4MxW7iH2ib1cu7om4
         JG1Afwn6i4Fka+l8fStANu26xw3Cq0MQRJtFu8H8wQHVE9hvCTDgMSsDZ+DzF8dJyzCJ
         VF3IGxGaBHkqIq0JhzDpkkqS43jKXbqhrNVM8QD8nIEgun2NPVyOZiy3Lg6/s6MS5At6
         G4IHFAW6mtgUEVJeOoQy1EVNqrEvq/wwmhCCuDmimEDRHvpZ2Ech2oSucxLKm2DqkLwp
         qUIJCnNvXqWY3NDlhWM7gAY3hpAamEQGYWup/NyIWUrmbm9nCOw8jHxZs7Y5CtAGiH1X
         +DAg==
X-Forwarded-Encrypted: i=1; AJvYcCXH+Vh2WIiiYkK9HmQvADovzxQTCdhhDoF+18amPmfV6jflLxnasAdUCFYuJKLTcPM158MIZzjJ5/miA9cxhZflRz/+WAgG6V3lVYy7gO3L3+iTqsqnlSQGj6EmwcqycVizZGHxl+0zNBS9qmFoIrvb+AFSgZexEjvsLKhlMc+lFPEQGIchBYFBwhiEVpP3QGknYJS7Fk6Ti5MGZiki1oizNi/I+l0zkIhy
X-Gm-Message-State: AOJu0YxspiAMDDItXIeFxCl/7n2vnM3+76LTb71TxqQFPAyHknwJhxGq
	XPZbBPZYNj1KcWqRpOl0rZuL4CeqAS2VSEanY/7V9J4KRWYHePETVsOUHPmnn5k=
X-Google-Smtp-Source: AGHT+IGc7m4g4Pb6b4U2eS9YbjCT13EuMWTe1kXONwhI/+jR4L1FviP+F3kmYJB0qQiKFihK0Rug+A==
X-Received: by 2002:a25:8a01:0:b0:dcd:407d:52e5 with SMTP id g1-20020a258a01000000b00dcd407d52e5mr15473596ybl.29.1709801092479;
        Thu, 07 Mar 2024 00:44:52 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id i3-20020a056902068300b00dc74ac54f5fsm3395091ybt.63.2024.03.07.00.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:44:51 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609acac53d0so5784217b3.1;
        Thu, 07 Mar 2024 00:44:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXD0LnnWPV6JllKRTeR8sR9Rl+fDLwkLpXa1gVhLk3mOw62Om2azyj5BIQyL/CKRyIEXrZbe4UWkqv7AvLz57y1C6+X9xVdIts6uWCD2+9iPnzRQvR96+21uxSeBEsHQ6stvomPN4eomd23d3wDiu+ZNW0BRLmCtzi8gQIHbXlfaIDwuP3VqIsvR36eLLbvYSExq6DK1ArBP/w7axUOnXv5MqIYsA1LDJ9
X-Received: by 2002:a81:7c0b:0:b0:608:cbf2:518a with SMTP id
 x11-20020a817c0b000000b00608cbf2518amr18018502ywc.49.1709801091706; Thu, 07
 Mar 2024 00:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306231007.13622-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240306231007.13622-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240306231007.13622-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 09:44:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUi5U1BjcdFu1p7PrUteuRxwWiQm39c-tprxA=_LED0DA@mail.gmail.com>
Message-ID: <CAMuHMdUi5U1BjcdFu1p7PrUteuRxwWiQm39c-tprxA=_LED0DA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: renesas,scif: Move ref for
 serial.yaml at the end
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:11=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> In preparation for adding more validation checks move the ref for
> 'serial.yaml' to the end and also move reset check in 'allOf' block.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

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

