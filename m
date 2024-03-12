Return-Path: <linux-kernel+bounces-99947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F57878F99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBB8B215EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC169D0E;
	Tue, 12 Mar 2024 08:21:00 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC60B651;
	Tue, 12 Mar 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231660; cv=none; b=i7vVKx2ybpegAZAtsuW99z+wCrp6w/gEoeRNnxwmx5n61U6ceTpLcosr2YKBpak4G/peUSMVpDZFmCnumKYIWbiHlIxKzCuaopsDr2jo+ZRY+sbOzIwyF8dqU2RssCahYwcMs8QIDaWy++NxGOrIgjlLt/WOcMuwS+7bMi134IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231660; c=relaxed/simple;
	bh=EC1IWzMZWa+M6F4YkLaSooXMV/yvn8uCENWgAg33cJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw29Ph77om122qu2MXzvZdwl2VxDusHbpURxX4rDrc1ZskXXtIqeeKr3pTcUvt0qxf6XvaodIeRtdIZKAzxe6VwSZD8Jy6YqioGp6Xrrcehdl3J2jBFw6/BciNewEHKbEYzb97nDFJpGqqvwNyzuyZt8ytIKae5spV5BPexeMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60a068e26d8so41906897b3.3;
        Tue, 12 Mar 2024 01:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710231657; x=1710836457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1bR56IqKqOsxuwkSHrydMHa9KKLbHNZNQKlBX5dtWc=;
        b=l98G609jMIShf3FaUBEmjbR2CwnIHe8YNxQ5px7z40Jxghbu/D5PWSJLjIyl+dZHV4
         Hmal/747my9yPq+qSQl+D1vKU/chDQxeZm14GwFMKLTq1x4H0+6WwcxXceQAVROw1nHF
         9m5TFo+bhAUfz72MZSXD+sgoslr0J3AciRT6QNvSdE2snfgMF1h8Baa4HnQZABr4UKsU
         AYCBI2uRC/3teMHHpSzQ1+R92jhtSNETPBfZNHMBcHUV2tNgbpfVTOQtfL9KtkC3JrR1
         12xTTaGwLMAkcuTfs5HJkx+sVN0b501904Pt59N55x5ywv8krKYPcf6xBvh4VUH+ClUE
         9rxw==
X-Forwarded-Encrypted: i=1; AJvYcCWhyo2DbdMcZ96ERNjkQiEuHE6gU5d7FbHN07zKcXjlJbsMAPzeZ+7Wv1FM80lDwUGeLufQ11b80AemW6/yKLseFRlcbXL3HVPAuUqLcKX8kAorng1VuhYojarsgqjmjp0l973x9U4Rw7Qo9PMN9vQFjgoWT15h7viukLcpI3kb5idp2hraiYysimbn10Wf02A1gs/ESAH6jdL2UPUnEZ9LD27/
X-Gm-Message-State: AOJu0Yw4lul1rhJNMSkxSoe87DndXOZysmF76VuqFktgN4i4ez/8Rh96
	//y61uom+XbDXBKcplNI+AFHHdTNvSEZ8+bxqQZbSwyYCbbo9jkhEj3M8FORfE8=
X-Google-Smtp-Source: AGHT+IGBk4eB0rHB9ARQyEmNJxLv7mX6XRRN+t8Wxl+8NL+F8ffzBrSwKgAwYdQ4FKG38M0c10nLiw==
X-Received: by 2002:a81:6f03:0:b0:609:f87b:aad3 with SMTP id k3-20020a816f03000000b00609f87baad3mr8413864ywc.31.1710231656818;
        Tue, 12 Mar 2024 01:20:56 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id p195-20020a0de6cc000000b0060a08edc81dsm1809121ywe.4.2024.03.12.01.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:20:55 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0579a931so35226217b3.0;
        Tue, 12 Mar 2024 01:20:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWl7vNUutERS6gABnipE7gG922zZeTYDqDOGTR8Gesy6U2azfSe5jBiP28OFXaJDTmHm8OihUTKB2/wv4mHP9NcVdESzEQpFLlmdS7EcGl7uCkuY8aUxIBKVTbJuFuW7OnD1dJ+zKjyyZ5HGgMHhg2V4923hK50TMsKIkTsXJ3tCU5RNqsC3Q1StM1S6HPiIuAyE62VyW9rByRSP9us0dxi/HAj
X-Received: by 2002:a81:a105:0:b0:60a:243:547c with SMTP id
 y5-20020a81a105000000b0060a0243547cmr8805841ywg.44.1710231655739; Tue, 12 Mar
 2024 01:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229204039.2861519-1-sashal@kernel.org> <20240229204039.2861519-12-sashal@kernel.org>
 <Ze9x6qqGYdRiWy3h@duo.ucw.cz>
In-Reply-To: <Ze9x6qqGYdRiWy3h@duo.ucw.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 09:20:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-ht_Vetq7+Xh0TqWOcnCdi=3d0VvfgXBF4ExtzGcRDg@mail.gmail.com>
Message-ID: <CAMuHMdX-ht_Vetq7+Xh0TqWOcnCdi=3d0VvfgXBF4ExtzGcRDg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 12/12] arm64: dts: Fix dtc interrupt_provider warnings
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Chanho Min <chanho.min@lge.com>, Arnd Bergmann <arnd@arndb.de>, tsahee@annapurnalabs.com, 
	atenart@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, rjui@broadcom.com, sbranden@broadcom.com, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	matthias.bgg@gmail.com, magnus.damm@gmail.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Mon, Mar 11, 2024 at 10:04=E2=80=AFPM Pavel Machek <pavel@ucw.cz> wrote:
> > From: Rob Herring <robh@kernel.org>
> >
> > [ Upstream commit 91adecf911e5df78ea3e8f866e69db2c33416a5c ]
> >
> > The dtc interrupt_provider warning is off by default. Fix all the warni=
ngs
> > so it can be enabled.
>
> We don't have that warning in 6.1 and likely won't enable it, so we
> should not need this.

Still, this fixes issues in DTS that were not noticed before because
the checks were disabled.

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

