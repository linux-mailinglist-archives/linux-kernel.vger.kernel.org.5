Return-Path: <linux-kernel+bounces-40161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33183DB6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B803EB22004
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C41BDCA;
	Fri, 26 Jan 2024 14:05:23 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C611B7ED;
	Fri, 26 Jan 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277922; cv=none; b=OjfUZjCkGgAIryf3BIImaqZeUKFqYMB2vhTkR0grZhr8ZQCNkmw6ZDMqGSAMbO5u1BdZNSwunwovPfyCeWMlLmOS6n6oAx5ni8wbPnq27jLTX3fhZnGKTta/piC+cYaF2TcJyvPW/1aeddrQKz4xFNfNYtqqtnG7x0b9m/WoYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277922; c=relaxed/simple;
	bh=y5XV2iWDw/9ztxzDPozZcIidWpXfunjJxpv/NOvfRus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0FxzukWk69LLm7htS7/1jkIAn/IcUW8G1axsyre/w4KFqeufjFtzvWUdNJQefZzLgU9BgULxE6YRyn/qZ/W/ID76w02kawoS5KS2ZQQi8rv05mr/YX+V9+LGiFuaSw+fyUMmwR3/sXiaM10BuwJJyEKeDJDZ5lqtrrv4cnEyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff7ec8772dso8188627b3.0;
        Fri, 26 Jan 2024 06:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706277918; x=1706882718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oDyGvwYwPLztiGZb85xGU6osFH8DNpEp/o7IfIZl6c=;
        b=Cjp1q+6nvcyutWTT86p7mQOXuR+GFRcQQJwTgKi1e2FIQmIg2vEzwl3wAQ6kvw6xVD
         9qJKjcq4O2L+ajk4H6J6B/IVzBXUVGmQrDMILbHhka6hWP+5j1Yls9LWQbgJqM0apbwv
         Hqxo2nwOB9rHPnV6IqUwIEk75PJ7MmooJSThW6wbz17gW4z9OUfvgt5bKnnMYj/v/XIx
         +oNEp0zYjhrIDQABFvU5fHjf596bm9FiZWC3W3jzrJdxKiSOrt6zivZe20LuLUUulsd6
         gytOoEvX/XB5G+23+hm/Ghvf/rCO3UEsl905fLz/vEiabj+Ll6WUSpybbZgCQa3PPlCs
         jDcA==
X-Gm-Message-State: AOJu0YyyoI3LAOwAw9QLZfe4no3FoOYjgmq9YcIfVJIHHJGvcwxqZb9+
	ceu3uLiqMimcN6ld85tkJxJ76DAkWrc/P0QXsYypfo4sYJiqBxmFm1meA1E3PhA=
X-Google-Smtp-Source: AGHT+IE+/e9P0xXvEnomhn8nWZ03JSoZhF7ggdLESbt4qZEnIP5kdXOoNDjK99a3OI5fwbkbEiBWGg==
X-Received: by 2002:a81:4904:0:b0:5ff:9d3d:290a with SMTP id w4-20020a814904000000b005ff9d3d290amr1257026ywa.56.1706277918075;
        Fri, 26 Jan 2024 06:05:18 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id ft2-20020a05690c360200b0060026481ad9sm403177ywb.0.2024.01.26.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:05:17 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc35fd0df02so464632276.0;
        Fri, 26 Jan 2024 06:05:17 -0800 (PST)
X-Received: by 2002:a25:ad1a:0:b0:dc2:2f78:bb9a with SMTP id
 y26-20020a25ad1a000000b00dc22f78bb9amr1195792ybi.106.1706277917490; Fri, 26
 Jan 2024 06:05:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117131807.24997-1-wsa+renesas@sang-engineering.com> <20240117131807.24997-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240117131807.24997-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2024 15:05:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtqyJDrq4MYrG7BEtppwUsa75mf=0+Tm7Ov+JvDMSHLQ@mail.gmail.com>
Message-ID: <CAMuHMdVtqyJDrq4MYrG7BEtppwUsa75mf=0+Tm7Ov+JvDMSHLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] arm64: dts: renesas: ulcb-kf: drop duplicate
 3.3v regulators
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Jan 17, 2024 at 2:18=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Schematics say that all these 3.3v sources are driven by "D3.3V". We
> have a regulator for it already in ulcb.dtsi. Use it instead.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Following a suggestion from Geert[1], let's inherit the 3.3V regulator
> from ulcb.dtsi. I kept the other KF regulators because:

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

> - 'hdmi_1v8' is really derived from d3.3v on the KingFisher board. It is
>   named "T1.8V" in the schematics. Maybe we rename it?
>
> - 'snd_vcc5v' looks like D5V to me. While it seems available on the

Yes, it's D5 (KF) aka D5.0V (ULCB).

>   connectors, it looks unused on the ULCB. So, keep it KingFisher only.
>   But maybe rename it to "reg_5v"?

These two can be updated later.

> [1] https://lore.kernel.org/r/CAMuHMdXbpBeKNL6QC_vYTrocf7xPcvUBQmoV9vboqV=
t_ciio+g@mail.gmail.com

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

