Return-Path: <linux-kernel+bounces-67085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86959856609
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432F5286F12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA642132461;
	Thu, 15 Feb 2024 14:33:54 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F74131E39;
	Thu, 15 Feb 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007634; cv=none; b=eK7PBl3OKijrxXeWRbEwbvYthdMQO6PjtG7HYUEs1EjNeLKa9n40Qn7zKhLvkGoFLuFJ3tN23wFm19qG4P5RbyoPibHCTEVfjPpaVQBnDeekNvuiBirLiaxmcFwsWiB58TaqZer+tGc669UroUckeWZP5PZn4z+8b/m5ffRfJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007634; c=relaxed/simple;
	bh=P7xNhav6aJfwhARb1uRFeRs+f3vK41om6Ya4wO7sFs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDLUkQJTEWHhDTeZJKqBLonsdQJ00Q7Sxbw3kI6wVo+2OlSoJBEyKOj4e4HRzuH0ml2XpN8hC5cpvxMhU5deh+iq4YikNPVegTIUDGao12V2Oyr2X99yXSEPcRnwNk4+XchSBtCkHJF+8Lm92RNOSaqUheU+NnaFR5cUMlkE5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so703047276.1;
        Thu, 15 Feb 2024 06:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708007630; x=1708612430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRnGHYlf9o6eH3AsZCqpvdC1oI/90IKUzu5Kv/VNKDw=;
        b=hyH2DSq1nRbcqkHhpc5PS/K92TWx3fWan7mJewXZuduh07OZgmFkLwhnagFiNF60rL
         WdIy4lR/f4WkxJyMe8Hw0vpU9mvNN1QKaqiQOn3Twgeje11lDp45lOufINaHMOsA26jJ
         /8J5M+Rp2GLt0sjnYQ0+E0kXjIgN3qJ5R7+7X3ysXV/KTFyQ1vlJR2i/yptivsLneCKH
         G2Qvnn1nPFY+aL+irfTfNJ+57esv14vBRoDQIPDz9Cal/ddeI9NmXZ7f/1iU//xJEgH2
         qpJrxckOIsdwRaI30yh2oFXPtzP2Y6MWQP7MHg2l8paCOGCg0rRiQCpmccPWsC6BwvFR
         z0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2KS0acN/xqohpuRVWjnrzZMWiNyfvArn+SmBuiZMc/m7aJL5Y/USXkbt7BFwrQq3T5QQHF+19S6VX5py1vo8yWR+/c1C4HYVfXqyrHg0CSwmYarIzW0+EbXTF9OqHTYasr97D7jg3VekwF9P9GcL+n9ov15Ycdk7nuwzRisrFSTAl73VGZjTSD/5+jyZ6JqfbVQrUg2R+Uxs9gJRzVMRPDgsLM+sL/lZupLI=
X-Gm-Message-State: AOJu0YzrX4w/bulkRYMBPtZ0p5EPpiHX9gEnMC69OPTaCbRZ5eXn/0Sv
	rU0iFwfcYYPYNV3M7gO/clUIhkhTK1roqGOdXhJRHSzLdROqt3I9JSWV8Onx6efB9g==
X-Google-Smtp-Source: AGHT+IGpyxPfTAi9hYB3cwg+Y26aSU1R09q970/E7gjueMFlzULKfbAnef4pgFv39u3LuV5v7k4yQw==
X-Received: by 2002:a25:c8c1:0:b0:dc6:c670:c957 with SMTP id y184-20020a25c8c1000000b00dc6c670c957mr3662276ybf.32.1708007630429;
        Thu, 15 Feb 2024 06:33:50 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id g19-20020a25db13000000b00dcdb7d232f9sm212789ybf.4.2024.02.15.06.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 06:33:50 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607e54b6cf5so2101237b3.0;
        Thu, 15 Feb 2024 06:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnISvEHkT3uZLUBb7bGGqWNJeyO5s6JqyvvBIB1BGOeUTBTlCoFB3tVCqIBHlsGbCBCPijqTNldOe44xtu5p3AD/O1FF9RKVPPLtN2ar9USH7mZeDuUCu0goPsK9jwqdZdnm8mitc64GciEpwGQYqWp+eeCN6bSzr20mkHnEejaidUA+UeqW7w4t40E1jvh4w4u3AaOpSM/QArSuH/zrgLqReMlN0c5A2prE8=
X-Received: by 2002:a0d:df56:0:b0:607:e6b5:a492 with SMTP id
 i83-20020a0ddf56000000b00607e6b5a492mr405131ywe.26.1708007629791; Thu, 15 Feb
 2024 06:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com> <20240215140841.2278657-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240215140841.2278657-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 15:33:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUsLu70ZaQN4SBgP237EUPzF6rPRwSktXWfeBzLLY=eiA@mail.gmail.com>
Message-ID: <CAMuHMdUsLu70ZaQN4SBgP237EUPzF6rPRwSktXWfeBzLLY=eiA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:08=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> clocks are enabled though pm_runtime_* specific APIs). To avoid building
> a driver that doesn't work make explicit the dependency on CONFIG_PM.
>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v7:
> - updated the dependency to PM || COMPILE_TEST to be able to
>   compile-test the driver when compiling for a
>   !(ARCH_RZG2L || ARCH_R9A09G011) platform and CONFIG_PM is disabled

Although this doesn't make any practical difference:
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

