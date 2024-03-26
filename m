Return-Path: <linux-kernel+bounces-119606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D488CB01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212A71C63322
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33611D543;
	Tue, 26 Mar 2024 17:33:43 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197F1CD32;
	Tue, 26 Mar 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474423; cv=none; b=s+08EnSaulNEjs361YuH+5b2IasEiYByfcN7Nq1mAtDTpI7yrAa7FEPn9sohik/N+CPqP+vj5TPJZpf9ev5aVGGbAmiL4zmJx5ODs2uFNiCfuhoKnyEqhwllO9LKlIME8AZbVbx4Ne0luyuVRB3gMjMvPiL03Lk7iDE7YAxr+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474423; c=relaxed/simple;
	bh=t8ACIpKzv0q8/p8CXF4L4YvbLI9KGeAVitiworkqx8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCyaWSxLxZdspnNBTSnWrTe9K2ir07bDpBFaVVZGpJ+cJ0Jb8dnOFJpyJNFU3e/kxo+gyomaiczKTQ2VvFcadG3nGxzDPURhqVMQiJoH+NPYDSJHrDYwBy3f6LmqKbwQ4ZXsXZq4z6pZ3ys8mz9JCKSqnnVFonyNUKP9jMPSCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a434ea806so64130897b3.3;
        Tue, 26 Mar 2024 10:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474417; x=1712079217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S16dC9FBtS4z5iu5umvo/h4i6rfX9oeeL4oHp++Tmxw=;
        b=YfDibKkg9GtpiX87LjH5YOCGt/DmvOIs1lnOWqKlmkj14N6KsWPO8wfUzbQyV476wU
         YG9RFjv0YnIUjFBHfrGSp8D6k0CWbqWobYQJR5NGpyxoDn8aJDJADP3GJGvQddJnfLsu
         51QR82uvoHFrAhtrFPf7KTjfufehPB005MuuaO9TJKsfTcR4qzb4o0iJTJoCFADoesXP
         Y8jE/WjRFRa1mEHGOP82XjHMbQyfSp6ZdKoeSaHwd299yqi7hwsc1aEkGsgxyUTUnFCy
         2lISZsF5Zk5gdXV+Q9wnDE9PqIxONA3PD8t+L56qeLjOGNcOHUEQDwAebzt3h5TA5UmW
         z6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJZPcP1LBoOnKVqC5fAMJ8Xt4fo5W8VLrVYPaJHnTKuEge1COfkrbmeUZ0Bx9uhBadZ3RFvSdQH1UMTjGCLObwTmYdtQJw3zINoSNGJwY07OAN59VnUE0ovGg04jtUr78VnTjRRO3k
X-Gm-Message-State: AOJu0Yzar6IX+eNzAjgkj6LWF6rToVFdtE+KZfUa6EG/zKxRTqjijDik
	3xhsYI3nwy6tDMtpuouLpHWPwUyYib0Ybb1S9HMcRxTyDWQ3HWftThyK94Mw0Ag=
X-Google-Smtp-Source: AGHT+IEz8qmkP4Xd6vKX1r9Bwt7fXv6v3b8ny2nwya58UTxVWmsSaRtEJr3nIMFZp3xdM3eVeIDxCg==
X-Received: by 2002:a0d:d88d:0:b0:609:f3be:9c8d with SMTP id a135-20020a0dd88d000000b00609f3be9c8dmr1838045ywe.27.1711474416753;
        Tue, 26 Mar 2024 10:33:36 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id m12-20020a81404c000000b00609f893ee94sm1529057ywn.127.2024.03.26.10.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:33:35 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc236729a2bso5632845276.0;
        Tue, 26 Mar 2024 10:33:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQK1FioyIZ1JNohzj0ugrhpPv3UWiPPhZVZhSzeq8TeY3o23TftbfREWg0nSGeoXVNzQ2/7h+zqepRKX0BGbsJw6k77guD5iKoehgJZSv/VA/rA/8smLSrtbUQk5lR+zgO5OXQZtEd
X-Received: by 2002:a25:213:0:b0:dcf:a4a9:98bd with SMTP id
 19-20020a250213000000b00dcfa4a998bdmr1995576ybc.20.1711474414496; Tue, 26 Mar
 2024 10:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <631a1f4c066181b54617bfe2f38b0bd0ac865b68.1711474200.git.geert+renesas@glider.be>
In-Reply-To: <631a1f4c066181b54617bfe2f38b0bd0ac865b68.1711474200.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Mar 2024 18:33:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX85DW5scsc1Uxfz92GfMHi+N3icTCihwr43de5FvapZQ@mail.gmail.com>
Message-ID: <CAMuHMdX85DW5scsc1Uxfz92GfMHi+N3icTCihwr43de5FvapZQ@mail.gmail.com>
Subject: Re: [PATCH] drm: DRM_WERROR should depend on DRM
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor.dooley@microchip.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-clk@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:31=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> There is no point in asking the user about enforcing the DRM compiler
> warning policy when configuring a kernel without DRM support.
>
> Fixes: f89632a9e5fa6c47 ("drm: Add CONFIG_DRM_WERROR")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

My apologies, something went wrong with the list of recipients.
Please ignore.

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

