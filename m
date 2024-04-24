Return-Path: <linux-kernel+bounces-156927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3E8B0A71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8021F217BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA815B568;
	Wed, 24 Apr 2024 13:08:30 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED615B133;
	Wed, 24 Apr 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964109; cv=none; b=k/SkUSULbIuS0IAKKfYJRwZLGvCQdzZPWlrrdpJfezPE5hXo82ysRPXQHGwQFBNGJ4oXuzsy6lpx6Kp4kQ/Wjd5Q7SZoMZUJg1K74zBVXjHiqK3wDLtVTXyF7suqSe9sU7zRoVO+hpU8iMbvs3AE6XuagbBYokWndjZLZ+A4EkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964109; c=relaxed/simple;
	bh=3fuD80C0yX/OfK7PbQv1+C5LFnM/rJsnB/YJ4shBc40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/FGyAa5lQDJwPR9aocG27/teSBhf3O3JcbyyZ6bkI2epxHSL48leod3AMo7ndbaAx1woOz3vOpR6a4TiJqBh/C70DeK4a4ZLZFvepXC9lME9G1cZqpQVbUPTq8ucaSXTSvA0a2L9/4bT3ydz8dYOD8EpokWLE3CBR/6sP7KZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de47485532cso6767279276.3;
        Wed, 24 Apr 2024 06:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964106; x=1714568906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ5BaNcJprdgWoCnp6hifCqMZXethulac/N0JRYezqc=;
        b=nWqLFOmC0KkPWxirPdqYWwNRPuQT4sFL6ilAkDMLOozpGTH4wqsMP+RSCUxer0ZGtE
         in5yFLIZyeS+uNTcp9Ej0nzQkAachjTVOTPE8VgIgZpgakXJSQ1AX0Uya04eEBihxcJd
         QQ+nFZchC/eOkq8qHp/g+sw+WqJx6HxzeKxotHpq1kFEoFsqawfH9cZDxcWtdCeLcsMI
         sFkxmzzgn9sqNhgpcMh3U0vJA4b40Lm0uEtvWladNHDyKC90n5CTsVyj7Vtt7y88HLrI
         tpO2JsiopS0ya+sJaNV/Ab/XOIK+ZXLEvWCFlOpPLIjER2lTMo8LlKfg9rMPjxYoEb2I
         5x1A==
X-Forwarded-Encrypted: i=1; AJvYcCWny6uf315iyDjREG6Lk5ofvKF7ZKjbCp/tp6MjQqQoG4IB/1Ij8gRt4zEXlfqNp/u8JvSE2IjMfzoE3D4MompvGBz7uBk9l0FC6CpXp3ATVIafsn8WAOwizPrKOn0DeeXo5zWhShr5kW5c1CWhgFq2HpBOoOzX3c7CEYWrepSKg+uZpXViN3WOpOwTVlrSUmB1a4B178OI2GZiIVrMLy0zJttoi33OHwe84W0=
X-Gm-Message-State: AOJu0YzsDJZCsRZH+WSSuaPnvtoK5njXROv1jnRpQJXfGqYjPHX08w6E
	LBWKDLSoKki5PwRgvrfL93vCb5rgDgkmrSprGA2vBrfOIU/m+pmnTEPHKKvr
X-Google-Smtp-Source: AGHT+IHbtuXioDSTdMMCWEC0d6JTra4ZL3MywkCb1c+6NwLJBwwXPHyYQ4s0oOHWjqA/RrDCdDSBMw==
X-Received: by 2002:a25:9007:0:b0:dc8:5e26:f501 with SMTP id s7-20020a259007000000b00dc85e26f501mr2335788ybl.61.1713964105938;
        Wed, 24 Apr 2024 06:08:25 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id x3-20020a056902102300b00dcc0cbb0aeesm3054498ybt.27.2024.04.24.06.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:08:25 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de56d4bb72bso824676276.2;
        Wed, 24 Apr 2024 06:08:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2iKYg8qorvBN+dQENDMcQ3IyKMLOROmOmEWtwZgo3Y6jdAuqlRZ73jNLuhIsXqwx8Sy5O5YQtnPfnALonwje9f8ng/P6TT3xUW5wijT6Ft9NGlyVP+10X2QAgHFxiENl3ih0PuPfunSPIGkWcpu6iG9OHBnTycPcNC5dxHeul0rh5/txtHfLnMiVyZsRiZ3jhV9QcN9ryw1I1HeLQFsl3h3bq7h7BwD6K81s=
X-Received: by 2002:a25:ab8c:0:b0:de4:7603:e888 with SMTP id
 v12-20020a25ab8c000000b00de47603e888mr2549826ybi.29.1713964105488; Wed, 24
 Apr 2024 06:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <658e6b1b23d5b66646bb830361b8c55ccf797771.1713025170.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <658e6b1b23d5b66646bb830361b8c55ccf797771.1713025170.git.christophe.jaillet@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 15:08:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0G_Sdvq8RTR1y8xRPqCiZi-u_FbbYdbS3g+k9YnFZvQ@mail.gmail.com>
Message-ID: <CAMuHMdW0G_Sdvq8RTR1y8xRPqCiZi-u_FbbYdbS3g+k9YnFZvQ@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r8a7740: Remove an unused field in struct div4_clk
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 6:19=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> In "struct div4_clk", the 'flags' field is unused.
>
> Remove it and update the 'div4_clks' array accordingly.
>
> Found with cppcheck, unusedStructMember.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

i.e. will queue in renesas-clk for v6.10.

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

