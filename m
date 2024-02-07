Return-Path: <linux-kernel+bounces-56598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840984CC5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4D01F25A20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD877C088;
	Wed,  7 Feb 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RaGiXOjl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A37A737
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315001; cv=none; b=KE74xN3r2yjUPMrc3grcQABmP0vKAAn9JpCtYMTyaEEK0tegrco8xbSMIm9OeDRWMwRiz77ZP8xTuJQ9SYUg4E4b0f6c6jtAo+76O9wn4cgulNk2Vgb8WgjB4K75ul4nRwoTjhET50RCyVAdw3WeTpbXrtA0u+QLKPFa5yahByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315001; c=relaxed/simple;
	bh=BKDsWKvVhFM/Cy72YcJXGjDqlfQVZMXnwbijgQC9w9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMdndwyIYRH/LuBjvTZf8Ohdfi12pcoyyT02vb28S3WXKy7PPVAsV7CRsicmY/TqVGeKZvu6CcLGxijO2u0O0tErPTn9+tRMiHPdPNoyGEk9eKKHULr+YxCfh/HCS83fEz7lw9pVo5Hmp7cS40tBxeBstRKH8ffytWlrDdntK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RaGiXOjl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso7476861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707314997; x=1707919797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6irP1tvQvmC+N3KqWkZ1ZNedEbfNyWW9uq8h43DmQ8=;
        b=RaGiXOjlDq0w0IZTIDmgmqbbnsdYi3zvksqb9WzVHHMmhAz7LBF002bp2nXPKN4mNX
         ivPkMWpEt+y03B16BOWub+Pm92BbVGyE/RS/NKwlRA7G51dK3xH0wP77QTtCX1cgQhFi
         UAP68hMV9c4lVgQlt4HisWkChz44Jn5v0EH8VUyorJSMGOc+HeUT7f1BTwEryjCgjZcQ
         lRc6DWDHPndFp+rJrlaomo/V78GBvVnHFAypOG8rRHMGrixvnUF2hQRjSl3FHfoUv9Uw
         eBBfIZWtpDbKHfbnXoICrIt0JjNEiSJ34zMGqc9EkF9uta+0xuAxVjC01bFmBinTZBvo
         VjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707314997; x=1707919797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6irP1tvQvmC+N3KqWkZ1ZNedEbfNyWW9uq8h43DmQ8=;
        b=awXdrENlljB4uo0eWMH29mP82a5wH1t35UWvlJnWpUAW6Zz/gryX21mph/vMDaTNhZ
         5dsmmT8xtgDXBu0Qj9H7Xk7Wc3+jGtSS7SWx3eKZe7VfSRLWRGUbAoFn0b7THDIFvYIA
         q9HY9I9HSCoojNazfILSmagV8h6DI4k+Ayn0rvPavY8x2H1LSFBSO0zyx+Tu9WJr4sBL
         Rca+yQEjwo6iSVtXIBfSYz2AFuqaAOQfVPVgGD9af1doq23NmbLo0p3fQaro/jGs8YKR
         oHjDcmFr1HpYJNWOJewZqTS9P5t9zqreW3kkgLQb3TV9v77vi/UF1JrR23Dn+9HrRFCB
         c3zg==
X-Gm-Message-State: AOJu0YxkyBcTrMLWk96EOwSCr+wTIzhCSZQhhTeNogbjIY3DJ/w/xAWC
	/wxrR4FROA3kbrkk9I9D+v10WnA29nNI4q0XLkmQu91qL3jtq1SuV5C0YG28Ob3/Wazn14QQIdN
	0XF61xj+wXYO6keDCTtDFXku6qq4b/+7j/2VJfA==
X-Google-Smtp-Source: AGHT+IHhzyOTIE2l/4+vT2W/e2E5y1CaYvo6UYY6mflThMpfUoGD+NroMW6YWIN3D0NRuDzgfJwjwdnNb95iCesClAQ=
X-Received: by 2002:a05:651c:624:b0:2d0:a56f:95b5 with SMTP id
 k36-20020a05651c062400b002d0a56f95b5mr3414053lje.37.1707314997306; Wed, 07
 Feb 2024 06:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
 <20240206-axi-spi-engine-round-2-1-v1-1-ea6eeb60f4fb@baylibre.com> <0158a82f-5445-43b9-9da5-8655c3a97c4d@wanadoo.fr>
In-Reply-To: <0158a82f-5445-43b9-9da5-8655c3a97c4d@wanadoo.fr>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 7 Feb 2024 08:09:46 -0600
Message-ID: <CAMknhBGGw41e8YfFfewgR=4zHr_BvfMxL3k4Ad2xbTLMEKTs7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: axi-spi-engine: remove use of ida for sync id
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:50=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 06/02/2024 =C3=A0 21:31, David Lechner a =C3=A9crit :
> > Profiling has shown that ida_alloc_range() accounts for about 10% of th=
e
> > time spent in spi_sync() when using the AXI SPI Engine controller. This
> > call is used to create a unique id for each SPI message to match to an
> > IRQ when the message is complete.
> >
> > Since the core SPI code serializes messages in a message queue, we can
> > only have one message in flight at a time, namely host->cur_msg. This
> > means that we can use a fixed value instead of a unique id for each
> > message since there can never be more than one message pending at a
> > time.
> >
> > This patch removes the use of ida...
>
> So, maybe #include <linux/idr.h> can be removed as well?
> (untested)
>

Yes it should be removed.

>
>
> Also, even if unrelated to your changes, spi_engine_prepare_message()
> could use struct_size() in:
>
>         size =3D sizeof(*p->instructions) * (p_dry.length + 1);
>         p =3D kzalloc(sizeof(*p) + size, GFP_KERNEL);
>
> -->
>         p =3D kzalloc(struct_size(p, instructions, p_dry.length + 1, GFP_=
KERNEL);
>
> which can be a little safer and less verbose.

Thanks for the suggestion. I will consider it for a separate patch in
the future.

