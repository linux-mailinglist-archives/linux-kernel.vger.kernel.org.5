Return-Path: <linux-kernel+bounces-61935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB338518A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1F328173F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D23D0B6;
	Mon, 12 Feb 2024 16:06:54 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A193CF7C;
	Mon, 12 Feb 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754013; cv=none; b=qK/rnqjURhOOSk26lhUzvS0rQVuousvdvS3c/azOw30sK4Jqd6ocfXqwXnm5Y4VYm/qYPA/jiFfdA/nQVm0h7BxE2QsVHlplwjjClnYsXdb4pBnWtrn5lSrhw2Oue0n+1HZh19VzNioF4soXUzlJXCgXiK3vuMCZUxgXtye1cKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754013; c=relaxed/simple;
	bh=eu8yVSLA3BKIkoJ10Jm9voSf8PwLnL5xz+s5QOM1Xrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilCvb9zZnZlrB6TeVB1AlvkfbTjcN7Cldhi1ys6b8LeYVwjKAWyrCB4u6zANBtVtF15f8PuraNWb+oILMwCdU9MJ5Q7U1D6CXg3EBA1Xl47X5q12nYx9Tz4fBGj/lr76o1m4mdC82Mq2HuHA7nn4yY+TJ7b8d+ynl+zREhW6oWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbed0710c74so2706296276.1;
        Mon, 12 Feb 2024 08:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754009; x=1708358809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gdwZc5+s56DZO0JOI15ZmhwmQHAyRJK2BxS4wcW7KI=;
        b=CSDUKwbqXr5z+6ORCeDtdIiRmekDG+ge6s+WS9YKtc0lxWOadKhRQ6ZDUYZGvgd2IW
         NNcyCV1WY+IQcGHfJXwHZNkfY0sCx0nLd1HZjvUWeBB8/9LoYbm+N36YdfLUFFhTFgLh
         PLu9n82wLLBpsLkinzrBURVMjZ7qtONagwV0j40xiD7Ug+YDPnJfOGYZX3lpSfX7PLjD
         nnTWEJ/8kPyaxyxKQ1SAXdOZwjgI/3iFyH7FyNYpOnfMo13UXD5SfX1wWVnD6QVUqDOc
         saIq312FDWwHeZJA5qX8Yxpz68F+IWtibJBelW//OJBQC7UbgjGt0oFtNSMus+tWte2n
         dKqQ==
X-Gm-Message-State: AOJu0YycwRoc1ekpkz4pkFFfPxltKCPdQUrDaAAsNYPhmpuHLhpfqCdR
	Sk1q9KoOrrBj0WLyEESCOhlv8QNH1cSuvnsSueqarAyXg1Te1hySjAZdaF957GI=
X-Google-Smtp-Source: AGHT+IFTUNkCyU8oYvLHSMxCIgfJS1ITNJwHHySkYqvZY9azjB8khLpqKkpZZpBfRSqLYYioHESr7A==
X-Received: by 2002:a25:ae61:0:b0:dc7:30cc:f264 with SMTP id g33-20020a25ae61000000b00dc730ccf264mr4866272ybe.56.1707754009390;
        Mon, 12 Feb 2024 08:06:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZDXixsoObVE+GV5dX6I7cfyNvA+j9BdimCcmfe6bevnvoKNxAjYM1Wy8JwlvUS9rv8TZd1BYpHCutxUSP+4ZJ34GKtzUTGpVozq9BPiGdqUFPIVL91ncuFZLge1vZq8rHFwgnLRb5hGc9c1iGB/pZuaCqy7UnOLlICTAqidm7YCutbztym702XaGq
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id g7-20020a056902134700b00dc701e0bdbcsm1221103ybu.44.2024.02.12.08.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:06:49 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc75bc22a10so2353468276.0;
        Mon, 12 Feb 2024 08:06:49 -0800 (PST)
X-Received: by 2002:a25:ae61:0:b0:dc7:30cc:f264 with SMTP id
 g33-20020a25ae61000000b00dc730ccf264mr4866250ybe.56.1707754008919; Mon, 12
 Feb 2024 08:06:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208120455.48009-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240208120455.48009-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 17:06:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUxBb5W_FTArzDWYx+qeYC0JKxwo1sXp_iCRsQjPD3rmg@mail.gmail.com>
Message-ID: <CAMuHMdUxBb5W_FTArzDWYx+qeYC0JKxwo1sXp_iCRsQjPD3rmg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: Preserve the order of SoCs
 based on their part numbers
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:05=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This commit ensures the preservation of the order of SoCs according to
> their part numbers.
>
> Fixes: 9c57c4a9a45c0 ("dt-bindings: soc: renesas: Document Renesas RZ/G3S=
 SoC variants")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

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

