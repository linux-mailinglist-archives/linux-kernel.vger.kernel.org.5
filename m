Return-Path: <linux-kernel+bounces-61713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E18515BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F7DB22F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E93FE2D;
	Mon, 12 Feb 2024 13:37:49 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F043FE27;
	Mon, 12 Feb 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745069; cv=none; b=dekVBnZo/ZRpP7qe8rX6BQQN9o4Yr8bE55LaeZ9FFerzy3MCEEgitZ4w26uFLa/y3+8VGFQ/1BfPkXbtq1EM5GXGTGw2lM4vSGG6ieihpZ/IKTdkdopvTWdK5psP3BBOzXAwbbwndSepsbYnR6QCXoospHnPEmwD7k74LCLrka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745069; c=relaxed/simple;
	bh=izF/KNc2FbaeiNpT5v05mZmKRTNf5gessNKCRFuFxto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBnqJYLtzBUWW0kOtAtDpoYGzw6XghMhp3ocfBBOdiJ/Gj6xCnMPFRtMDri8YFHdNyj0kLBee3IoJqdThj1Lrzk9jKgUDfAJxheBBxxmyy6mxNe3SyKCW0sTKL5ul4SbWmyuJ0Lf0iybODzayliNN1TXrOrl6O2q80IKXuRpltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-604a05a36d2so30679657b3.0;
        Mon, 12 Feb 2024 05:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745066; x=1708349866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DHBr9E2cVbSN649KozYLpsPSawKg/hI5ked7vHGgxg=;
        b=uNc1FxLS3ajAwXxtsOaKmt08Lr7gWpAfHgs4tnjfDdlcC0gt/Gl7HT3rRNd/4Xy9Xo
         q2RB2BGqB6iDNBihpTrqeVX4ruPzc+L4aJQeZJoI1sRhb3xMBcHAGIX6AmdGHS7NGYbl
         nEK6zwOfJWGhDOi7SyzdhkHKAUZgQsm/ERoXHxy3rGYImZtOThURjA89tKfZAVZ40rqx
         GRCuPkzKp/KLiKZVHvIrHkd46sl6dC54JluPUqD0U0zs7rNrRin41t6F/K00C5cE745u
         tiOO3cUd+WaPtGzLTFcFEqu3GMUqX/DlrBc7OO7pHH3z3ZEv0fnECiMn9denlSD/hSRP
         28kg==
X-Forwarded-Encrypted: i=1; AJvYcCXmWsZupYhb3BHNExw5tGGnr+FVD1HJpBTBBuJg3bEOhGe88Gf3lXBFWmeSas072ihXZDCsum2aomx1aI28hj+o21cz3dpRAIVR9+oTEvnKHVzgZK0ilSQcjtpGWHY/KN9qkdFg4qWt2Q==
X-Gm-Message-State: AOJu0YzWe9sosyzXLh09MDBDe6WO/Fb4rn4ovjZ9p3dslkpnouTGaFeP
	I+xYLJCFqt7uzTRz2LRk+w0iK9FJCCK/OfqrbI0DQi9Z8QkaJta6oivtYi0elp4=
X-Google-Smtp-Source: AGHT+IEEm+CA/oIf88Oz4N296XNFg7mOljsXY1arg35wxlhCxSB/lMcTbs7/ikr12UYnMI8VJwNkGw==
X-Received: by 2002:a81:8385:0:b0:607:78cd:5043 with SMTP id t127-20020a818385000000b0060778cd5043mr264159ywf.32.1707745065837;
        Mon, 12 Feb 2024 05:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUj07alt3gRngmv66F6roIBm7c82+9gEXWFoC7UQOL2QXRQCwWabz39KbEcklEy6ROLhJZLqq4L+j7HWddVs6TWKTdD040w3HuX6EZb9KIrUCKVXUDHI/a8jUBFXB2tGjSVNK0jHNk+nw==
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id u189-20020a8184c6000000b006048400c8e6sm1174700ywf.78.2024.02.12.05.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:37:45 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3110015276.0;
        Mon, 12 Feb 2024 05:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe0bOv/FVjnc4K6Phu5yOlj1NKCkvk38DVoYnBYtuy0eShpYhlzkkKgP6uXx1hw1pfaGXEmTs4yn4ysryc8McJLNkVvPuRGp+eYNSuPa0zzyX+NSalOPBntVFuBKXpmNcqovVEXXwXXQ==
X-Received: by 2002:a25:d64d:0:b0:dc6:e8a0:a42c with SMTP id
 n74-20020a25d64d000000b00dc6e8a0a42cmr4875506ybg.57.1707745063906; Mon, 12
 Feb 2024 05:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129212350.33370-1-wsa+renesas@sang-engineering.com> <20240129212350.33370-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240129212350.33370-3-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 14:37:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkBMZkQuJ-+echU2JFKQ-KxQH6R-GUUokd_tz72TsWSw@mail.gmail.com>
Message-ID: <CAMuHMdUkBMZkQuJ-+echU2JFKQ-KxQH6R-GUUokd_tz72TsWSw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: dts: renesas: ulcb-kf: adapt sound 5v
 regulator to schematics
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thanks for your patch!

On Mon, Jan 29, 2024 at 10:23=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Sound uses the standard 5V supply, so rename the fixed regulator as
> such. Also add properties dcoumenting it is always on, also during boot.

documenting

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Or shall we move the regulator to ulcb.dtsi? I tend to leave it here
> because 5V are not used on ULCB, but I am open to change it.

I think it's fine to keep it here, as the regulator (U59) that generates
5V from 12V is present on the Kingfisher board.  However, according
to the schematics, 5V is generated by the PMIC on the ULCB too, and
both 5V nets are connected through the board-to-board connectors?

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

