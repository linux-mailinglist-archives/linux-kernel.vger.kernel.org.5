Return-Path: <linux-kernel+bounces-99943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D1878F87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E263C1F22A48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA969D04;
	Tue, 12 Mar 2024 08:16:34 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CF6997C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231393; cv=none; b=BiQGaUSrkxaowx3Gmtd6h6dDO4cGZfPEOiQ9+0csFLqwLeqmEbOZpGJe0px1vV2hoZO05DMCyOhZuhpZ9iGQddSaZ9Auv8DgMUHxE9h1VLBW66fozJaL4oUu/02Y+64zzve/mYlP2IwlzzwT05s98G8fmjF5fjuLWFzwoSZQV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231393; c=relaxed/simple;
	bh=9TudDafWaF+FYGXtWDHhnjKAASfax5HthUUAQO35k5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZbAf+SgYKi4n8K4h+vzBgUxDYHPOsF6LQtYl4EdL+pqgXrz8D5a4XDfmtULfaZc0cQiYCEshnblEld6FtBANlIeaptNMxa3j/PvM0U/NTRPndMI0PI1F5MFCjeWiCzq8LZXyZe8TBv6VBjqrDAYCCOeBy1FnSu9kJMvrs42Hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-609eb87a847so39988217b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710231390; x=1710836190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWM+miItVsq6psEs19WbN8BqqPLAx1Xcz4i/irmiElo=;
        b=MXfxS9L9FTnycB/lKcdNbkrpnc/t9kYnjdm0FcQLm5zddhADsvoIJA4mIQKVDhyE2h
         oZ8DVo4hXZ2Z59arHC8ZmzY4ZcZ/V5S36RLk0zsXWOew9GUyVBq38vUy74stUddUO4fm
         jKTKobjxLio2YZeNXsR/WqdiK/IOrn3IsQkI7578pxaa4aRFvPo4iC4b3lpksLpSWcMi
         /OC+YLiggFCE2YfLmqM2vj0gqh2Rv8QyIYqkGXLvycoN/Y7va5lzuzk34Nz18t9V8dv4
         Bzw9GXP5/2pQOAC72CCQ1UvEEi11AFPTfJrktbT+1Nr9yIT+bxLOx+MO5jvVQ7L2UsYi
         vZQg==
X-Forwarded-Encrypted: i=1; AJvYcCWGF0X3SL5OxXxK8i1W2uyDr2AroNIaf/c1OUYD0BWkz9HGndgZtm5N6fGYYZeWlOHzgofqR+8pnNQMOCDpeh26YM2OJA53PfAnz8n4
X-Gm-Message-State: AOJu0YzS6jtqAv5cJ3mi8DctlARg2TeQYBgiWeYs7mDZxT9+RnzzsH8Q
	HHfe2FNeDjpvrSaHskusnePQXeSFBpcCfqETMr+wIfniQikRlpQBNt7f8CK0xUI=
X-Google-Smtp-Source: AGHT+IGwn1tiuCka7tcxTpgP6jkTQiwv1n0FyvtUEl/CW1zoXg0RjN3JGQ+O1mJ+zH3vzNaSp7QDiw==
X-Received: by 2002:a0d:e9c5:0:b0:60a:317f:a9c8 with SMTP id s188-20020a0de9c5000000b0060a317fa9c8mr3873894ywe.9.1710231390515;
        Tue, 12 Mar 2024 01:16:30 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id m5-20020a814045000000b0060a380b2993sm1040554ywn.56.2024.03.12.01.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:16:30 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-609f4d8551eso40030897b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:16:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfATBaF8eH241h6bofL8JpgO6JaZVnrma2NeVZP32LM/eN4ROmTGDvT90UMGSPYF97JlqPxq59RYWiWuSoDlKzrgeunA3ys16idJmF
X-Received: by 2002:a25:5188:0:b0:dbe:d2ec:e31 with SMTP id
 f130-20020a255188000000b00dbed2ec0e31mr6419821ybb.27.1710231390091; Tue, 12
 Mar 2024 01:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de> <868dcff909d5056be2d548a249820b61fc2f0452.1710194084.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <868dcff909d5056be2d548a249820b61fc2f0452.1710194084.git.u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 09:16:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+fNUDOq95pA+kEnsyeTALT+xEYvOM0K=Y24H050zrFA@mail.gmail.com>
Message-ID: <CAMuHMdU+fNUDOq95pA+kEnsyeTALT+xEYvOM0K=Y24H050zrFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] auxdisplay: hd44780: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de
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

