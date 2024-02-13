Return-Path: <linux-kernel+bounces-63336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0935C852DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41B0B221AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584A922638;
	Tue, 13 Feb 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQmPDah8"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12582225DE;
	Tue, 13 Feb 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819806; cv=none; b=bumZRVB1r9SoF+xfqRaX0tZV+J80YzHHwnGTFGTjlEDxIUWiIyRSMbp/hL8cpRdnETHkADmC6u8i1QbY/NHMtk8ruiQB2SKOjb80gE9l57XKIqd+0tsp5xn2cN1fWnkRdkkuo4xYbmmRRm+mbNKk7kNy74h5fY5dgib2nVVqUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819806; c=relaxed/simple;
	bh=CzpheErL3PUNz1bQEXoER7w/wKXn54oS+TEQWZ4lbKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpaHTfPEehKH/qQNrpFfnL3J64/VeODkDR/1Jay83DdTgPSFAKAfU2fal43sucf1ME+vVSuQeLsu1EvKE9ZfZQ5cfC+yd2+MsLUUX39VmNKZvjf7p2yRwHsbnd7aJC4zmZreWU0XNToUFUwfngntRQxgVCAEJp+qMklCpVU9ufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQmPDah8; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c02779e68cso755367e0c.3;
        Tue, 13 Feb 2024 02:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707819804; x=1708424604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6kghJqnnvzrivpJN4qYxQyxAg/hb6vlcHjDQwTaVHk=;
        b=jQmPDah8SNNJ4xSMrMNrB9pwFKiO+Duhmb38O7fAGHPlHm2yS5vUcUtqq1jueamwUS
         uJwotw0tyGM3jwF9pqAtq3CPvZaa5t0RIT3GnAWWNm6PsYxeGPzMcYMWe5l0lqyC1HXa
         B0K9qtAU3N2V4xgxqeZX/+wtihmP1IC0ENDXYAGo9kCqZckCvJwYgqVGZHeiewJHac25
         CwNUqPamGxi4LddmcvlqxneC392FwgY1LIXqlVdlqZq6CNAfGbXrNjB6weCPzj6IvwI6
         s/y8jt2ioCLDySJs9+I8eca+BUoH2DtiRPcyhF1Mcs5g5EdJoOiBtcRGXxUFcX7HD/xP
         otXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707819804; x=1708424604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6kghJqnnvzrivpJN4qYxQyxAg/hb6vlcHjDQwTaVHk=;
        b=gJuQWVvGoQrdImtw/Uk2Gdj0NkzOrBiLqlae89pljg4CymD4xkjuyi8Qdu4ctdzHfH
         sRnyDDVgqeDcWb/D6ivQTXFz0Lqo5KgQ8m+LW4C1jKvdrk3OOkeOvrsGpTTBnIlWPj0B
         j4OQNX0X+VVZfu5kS5kUvny8roZ+Ywz+QF475XWHzInE+9XLjkz+sjGsNfwPdaldPzk7
         2DVhshc8IxNRTYN89WtXyQeW6m7EubZZgJST9vVl+wXdfQxCMNbnmHQ4zWgYHlvX7LjX
         RDuSDiZyyEwq7B6HVGlRG33kH4k7psOAWj4QtuMxSnY6MPll/Y4qlfeetLiObASd1Hey
         NWlA==
X-Forwarded-Encrypted: i=1; AJvYcCUF1gs6ODxFhdnacpCbI37dPKlDe7RqdjF6nH4GX6S6YQDEm6JZfLhkGl7VeNb4jydU0ZS8JtfSDjItpWRduG+ku/FrjOmxqnfPj7BbSg6eNzABNkX9SWOwon6ajh6JRSXLAvAmrrwzUHuGTOV6g6FRinXNGquLbtZraqC3x/fIWz33RyLtSYQj27j4
X-Gm-Message-State: AOJu0Yzs6vVABuxezoxYy7hR4m7H/xDSBmYI3HIHmx13syb7+JH5D/Hz
	DNM4i3/AAo4Wm0evASwcGnSfk3XVkJ0HoPLnyHrNDK8miqpPUYjOTa6hbqygZIYoE3TvtzHH3JP
	tWD8kC2LCBy30rEKDYbLoX7oHb0tLQU/y
X-Google-Smtp-Source: AGHT+IGxPHOACF2JseXG6DKdDUst+O0caNbXHJGDrvhj/rQJCEfV2PnlmnoNFdOp6iYQAL14j19DKNfZ5oOrEiMlHBI=
X-Received: by 2002:a1f:cbc3:0:b0:4c0:34e8:d55d with SMTP id
 b186-20020a1fcbc3000000b004c034e8d55dmr5118655vkg.11.1707819803720; Tue, 13
 Feb 2024 02:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 13 Feb 2024 10:22:57 +0000
Message-ID: <CA+V-a8tN-qn8zuimte=-riahJBWGgGi8i5botNfWqdWwJ7w-4g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Nov 15, 2023 at 9:29=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G2U=
L
> SoC. "renesas,r9a07g043-ostm" compatible string will be used on the RZ/Fi=
ve
> SoC so to make this clear and to keep this file consistent, update the
> comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string "renesas,ostm=
"
> will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Gentle ping!

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/=
Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> index 7207929e5cd6..8b06a681764e 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> @@ -23,7 +23,7 @@ properties:
>        - enum:
>            - renesas,r7s72100-ostm  # RZ/A1H
>            - renesas,r7s9210-ostm   # RZ/A2M
> -          - renesas,r9a07g043-ostm # RZ/G2UL
> +          - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
>            - renesas,r9a07g044-ostm # RZ/G2{L,LC}
>            - renesas,r9a07g054-ostm # RZ/V2L
>        - const: renesas,ostm        # Generic
> --
> 2.34.1
>

