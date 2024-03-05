Return-Path: <linux-kernel+bounces-92468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69EC8720C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F091C22E1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6988613B;
	Tue,  5 Mar 2024 13:48:31 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9485C58;
	Tue,  5 Mar 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646510; cv=none; b=gekcDNBEhdXdPqRrk+7jJ4f6Isla7GeAxuB7g4XpsV5qW5a5wadyoCpK0BbKDAtXA4dHzePPA87pFf0zLF7Ef0eJI4bKtFAs314R/+w0tvwgOVlY9mJJc+794GqyAw3G7pQk7SpljPOBccBMlc7/Z5RLZgNquokZJqkxfXnHgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646510; c=relaxed/simple;
	bh=Kf2biJnuyrvpVTL0uTyY/d1ul1jGIFCNbllznSFarhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThJLqD6V+HqbPrLJs7TamG+mNHiC+A6BAlienHTyymCNTdZPvcmwbjsEId7Bf0KhJsk2F3lnsSx4TbZAtgXAd3BWZjqe0QtHjX3kr6uRodA2yLcB7qluVrnh7RvilaMiMBP5tEBbLPE0vBZNq2ysPGYrBAc1gRf1DuIQCI+Nle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5406124276.0;
        Tue, 05 Mar 2024 05:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646506; x=1710251306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa6eXUUE0pChqHQpQRAEU0D+PWfnG0pG7bmLlZjpoqU=;
        b=m1AO4TWlnLC7zItMuwRpjmwseo1UFB/1+wwu6umX+/mfuScXIc/roKmb/ZI1vNi3W5
         2wm1wgcNVIlyhQK5PQZLhVqGVNnQcfz+vI1hQhjgdtk/pTcGxaMN0QEVBMXl+eUV8BlD
         YDMC3FHKKqzElLAgqh5vrCupWtZ/rMnhd6D+UVlLtQTULRG88NpGdJW7UzZeN/DaZ1ZW
         0+atKmk45O3Oh8cd+p60/LVinYeMRk+tkBQjFIR9y3FGOom4ah4WUKrXdvOQ/9F2H5MT
         PhWgNHHJAImlSP+KqgKwo9oDGzsugdnBDc3aqeRE+AUeQ2BfgkO+TXeSQRBTvEDGPfdO
         kf5g==
X-Forwarded-Encrypted: i=1; AJvYcCVZKRG6YqTSNH8AA9ZHLqUZUEkf+3S0mWQQGVKziGFCQpm2p0MM4c6Chtjem6p52wmHztm624784ygNxZlc+oO0l2CC7RO0hykO2Gd3oeJKfmpGVWmqHUmRdWEe97sIOwM8Iz7FSFaxo+T8cdZByyEx8NmDBOsFmlDjZixEuWiF
X-Gm-Message-State: AOJu0YwmDl7oZmy3YJ//kxPvbW+OSdqirLDQw/KS/ORmwe3Uakzfd+Gq
	iMI/ZTLjiayXs4B02TMWIAcsZcgoDr7ztGaiEPfaRL7Q7OoQQ2djZBpTzdrzqyU=
X-Google-Smtp-Source: AGHT+IEQy6GGHoGqLk6uwk8ZNW45BRZT3ywA20T6HVZbUPu/S1lIdBnk0x2oO9lDy6GmpV8iOhS5Lw==
X-Received: by 2002:a25:d614:0:b0:dcc:3a3:9150 with SMTP id n20-20020a25d614000000b00dcc03a39150mr9622468ybg.22.1709646506286;
        Tue, 05 Mar 2024 05:48:26 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id g1-20020a259341000000b00dc6a0898efasm2583054ybo.15.2024.03.05.05.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 05:48:26 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608ccac1899so60551187b3.1;
        Tue, 05 Mar 2024 05:48:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXsLNAptFE3QxHu1GTuhf/xv+YKoec3ceF8yAwPjwargLz5+FzFHjscXwR8Qm8POuxKEO/rz40JY169h+L7MXPzCU8FLpAIkdNhJonQj3dyT6xl6dQkoe/vZspes63xIXv7iF+rPZDIsAPLVm8mNeY5s/6ycyMnNs+UfCq0AHW
X-Received: by 2002:a25:6a86:0:b0:dcc:f5d4:8b43 with SMTP id
 f128-20020a256a86000000b00dccf5d48b43mr8483801ybc.9.1709646505511; Tue, 05
 Mar 2024 05:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Mar 2024 14:48:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-PTyydtuMjP0dFkAGSKT2av7Vn5s-xJE8u=SkqrNkDw@mail.gmail.com>
Message-ID: <CAMuHMdV-PTyydtuMjP0dFkAGSKT2av7Vn5s-xJE8u=SkqrNkDw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: tmio: avoid concurrent runs of mmc_request_done()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 11:54=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
> outside of the spinlock protected critical section. That leaves a small
> race window during execution of 'tmio_mmc_reset()' where the done_work
> handler could grab a pointer to the now invalid 'host->mrq'. Both would
> use it to call mmc_request_done() causing problems (see link below).
>
> However, 'host->mrq' cannot simply be cleared earlier inside the
> critical section. That would allow new mrqs to come in asynchronously
> while the actual reset of the controller still needs to be done. So,
> like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
> coming in but still avoiding concurrency between work handlers.
>
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme@d=
e.bosch.com/
> Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theoreti=
cal race")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
> Cc: stable@vger.kernel.org # 3.0+

Thanks, I gave it a boot run on all boards in my farm, no issues seen.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

