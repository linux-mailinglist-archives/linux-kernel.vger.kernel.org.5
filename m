Return-Path: <linux-kernel+bounces-99944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D073E878F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E551F21D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F129A69D09;
	Tue, 12 Mar 2024 08:17:02 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704569D03
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231422; cv=none; b=LV6NoLVTIhQbGvnSUqw2PkdACoYjz4Ahjxi26zQf5OhP1GlJBE1/49FwAy3LPLtVmvQNzZ6F046nLOgwwMtWWobfU0KD/Uqfy/1E9eTRgaqmtRUInOgOnK1CGU1TmYtgZrKIW/PxcRfyrUVz+474YbhO3eyTw9KYQdbpTjtKvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231422; c=relaxed/simple;
	bh=9TudDafWaF+FYGXtWDHhnjKAASfax5HthUUAQO35k5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuYf9MYard2yqxC7zQsTM+EGVaWxjh7bI7JfVtg+IlpuGlI5n+u0/q/eA3X5MF8ej9z8Db42eqUUVhOOGhN4scWpmzMEz8Od5YthftZ5qMt3yZxSojEW4sHcL2qMHNknJk9r3Zn6OR16pTDfrn7oTyQmdV7q9psBVBlWzAS/ILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609f3ca61e0so50719707b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710231419; x=1710836219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWM+miItVsq6psEs19WbN8BqqPLAx1Xcz4i/irmiElo=;
        b=saoeFZJtBEHFUjpYkamV7KiypmBax+o2+xQl/61uHz7nZHWgJgq+8FVhqXq/+fhUE+
         K7udO8MT65vBDe4T3EYOFKQmTbOPETU+Y3QMkxm1DpTmobVGWyazG2BJYmc13cLP5TGN
         rflbXhg36+mXvgdKCsGsHCArnNUJ472Vh23EMq/q3/2YITe308FMzl6PkrU4tanHWyGy
         HIAyjCi8txHpUQSH03sxoF69whZk8QMqpNHnfJxAFSlmm38mYXIjHXathxO058zkpqZx
         Dggero13M1UqOaTx4a3aWju2aRWuO2f1SHDYNxkcpeXPZS3hWvZw7VV/FpzK4V4jJ/Fq
         QadQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT0ZgFwxrG6eU7lkLyVYjbBQhSlU+GCkxKdhFQM21gPWFzNH+2X+4rpnHx9Uz7S3ecdUXgnPdHLRDIsmrWQR50NaRExCv6bhRQLwpM
X-Gm-Message-State: AOJu0Yzyod/2d2P9Y7kgkIkKf50zwfYpXZI7ySAlVu3KiALwLWwTePJ4
	4ClAzM/LyhrODDYkTMAsLk40bzGtPDiwi45qkHxVd9pbtzEDrjG6R9OSREnuWK8=
X-Google-Smtp-Source: AGHT+IEDqsEN8SON+F0TAWQw7OiMxwZD7WsEFwZZvzskRX7xPnooxLBc1gGygDA1qIhWHZCqwZJk+Q==
X-Received: by 2002:a81:7709:0:b0:609:fc7e:b741 with SMTP id s9-20020a817709000000b00609fc7eb741mr8716352ywc.22.1710231419154;
        Tue, 12 Mar 2024 01:16:59 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id c123-20020a814e81000000b0060a28132b21sm1333934ywb.106.2024.03.12.01.16.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:16:58 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a057b6601so33070877b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:16:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnrcIbwSKJcGdXGGVjB+MfKlW6ZPbmn1S9QQKnlCg/wcOt7I7i52IupzwCxx+1+xYP/glKG45xjF7aCdxjwVB9TiMaQHCsHR/ef9Uw
X-Received: by 2002:a81:924b:0:b0:60a:56db:a894 with SMTP id
 j72-20020a81924b000000b0060a56dba894mr1529161ywg.44.1710231418523; Tue, 12
 Mar 2024 01:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de> <e14f61b16189138baceb72cc3a9c34698787ea92.1710194084.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <e14f61b16189138baceb72cc3a9c34698787ea92.1710194084.git.u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 09:16:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUZXWwUJzSCZ5qe3D=ivT4zus1xkpnsezkFen0=T+Rc9Q@mail.gmail.com>
Message-ID: <CAMuHMdUZXWwUJzSCZ5qe3D=ivT4zus1xkpnsezkFen0=T+Rc9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: cfag12864bfb: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

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

