Return-Path: <linux-kernel+bounces-128568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B404E895C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E641F26DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B57A15B96F;
	Tue,  2 Apr 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYqD8REK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBE15B55A;
	Tue,  2 Apr 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086145; cv=none; b=dVrkbamxmgTcsubJea2pdHn0xVhgM0U0qRWgtJnXeqb/Fbp5aqcUJpLpy2ia3hrUzOAnHoKt0fv4wskWBH6we+i1C125OxzKQzlu+3moejYD+JmWiHr4Qd4VH6oPHMk363yeAp/xpOBiv+iN7l0dIhakjvmV4C3nRJF8MfX3H6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086145; c=relaxed/simple;
	bh=EhAHyl9cP3nWJoJwRMyp31F4H83JzTgrt3TBLtATRPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF5vwr1a/4zYTlv3gh4zpkzgLEyCzVy426NrEE6JEd1w3shn9YEvK4qs0JlzEpd3IKGORtXpyijYTvWp0ES7WzZr96psFLWmUqMlDCyQXO2ul49t+y+/qbvO+a0f91Jcx5PIX5W/BGfn5X7dopI6XkG5WRFXjI5amJHyPs+AlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYqD8REK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d82713f473so24118701fa.3;
        Tue, 02 Apr 2024 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086142; x=1712690942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhAHyl9cP3nWJoJwRMyp31F4H83JzTgrt3TBLtATRPM=;
        b=CYqD8REKN8s0bzShPPTrMUmPTaJ5yO8+2g6JTiBSnULraNLy0jpDcdpJoqJZ/pgEB6
         GVy53m0kTATygm+BTxaf9mjWaWmWLMxeCSF1c2KWi/n5rG/o9nF9m256aj/qGN6mlp1p
         OHcCUxFU+CtYD7Mfs/wjJiafUn5Q0Hrr7OG/L9eme/oG4LEYGgRRSOGhpSjNNe7U3e8C
         4/Qnj2o4XgSS993XNyQHrl2/4uFjDpd38FQuybLJMoBTk+RgI3tUzSnnVkb6qK2aJOoT
         hJVCIFiKs9sDw8pXb4TFPLsHg8ZlZnT57PTTzEkk09EC1THkvydErx9pboqlU4IaODCA
         wkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086142; x=1712690942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhAHyl9cP3nWJoJwRMyp31F4H83JzTgrt3TBLtATRPM=;
        b=UCn4bEuPNVosP/arRS/nSZxSAzKImNWeQSPSYieuUD1FvnnqOQn9Rt65oHSR5MtOiD
         Vi+Cg93Ckv3vLViRjyKy45uYy1L64B6K4oNKiOpsmCFKa35LEWWMmN7Ast+dQ90Mb3zM
         HSwg+evYUUIMIo2Hfah7Z/BE+JnE0KMgC0PVvFwjbRBeTo2WD2wntQYNoyDDD0uJ89rn
         tYZMHfRnh2pfsraWr6fTTCt8dLDw0N3aqWWtHUWSgUEuY098dRWvLXnjowYEGO+mywfd
         9zJISZXZTyN2r4LQeGIf83bZbnJhPZV5NCJkjJ1xzYyQ82HVxGJwVrUVKGcCgUzUqPzO
         I4zA==
X-Forwarded-Encrypted: i=1; AJvYcCVbzJ7Q/sn74rQkxhnou+FVd93kQIL31KJijDy6zZ9go2Z8v6/e1kCm/yseEAISa4uKfkJf3PYd2tIs0PqXK8Nfpx9O9WA6cUlTfRJRti3LvTgOFuF397BSYXko+nyu08qhZpPPT3MOmcKY
X-Gm-Message-State: AOJu0YxnSYae94H0hN/YeP95AsoF/TOzqSBYAB11+rpV9IXyEqfUnZqU
	GAXfoyGfJeDBcZLGr/8q8S0pPJ7z7RtkpBgu05GpR/Pf5s2eIkU76xSQcvIqqSwBuupHBe/A7+1
	WBDVuCKLd1CYv2aieDICziB4ZDxI=
X-Google-Smtp-Source: AGHT+IG12UrZ+tZaBT8KWaGbUc2/tzG6TFzFBRGcHZSyJ3RrVBGA7RdiJS8Yv9Q/NVxawbm/Yyjoo42Z52vQNS2I/q0=
X-Received: by 2002:a2e:a783:0:b0:2d4:132b:9f21 with SMTP id
 c3-20020a2ea783000000b002d4132b9f21mr3160289ljf.6.1712086141578; Tue, 02 Apr
 2024 12:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402174353.256627-1-hugo@hugovil.com> <20240402174353.256627-5-hugo@hugovil.com>
In-Reply-To: <20240402174353.256627-5-hugo@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Apr 2024 22:28:25 +0300
Message-ID: <CAHp75VedAiB_wSaq+oaNriC3HfLC=ft21O=ZYW_wCARPS7v3QQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (sc16is7xx_lines)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Before, sc16is7xx_lines was checked for a free (zero) bit first, and then
> later it was set only if UART port registration succeeded. Now that
> sc16is7xx_lines is shared for the I2C and SPI drivers, there is a
> possibility that the two drivers can simultaneously try to reserve the sa=
me
> line bit at the same time.
>
> To prevent this, make sure line allocation is reserved atomically, and us=
e
> a new variable to hold the status of UART port regisration.

registration

> Now that we no longer need to search if a bit is set, it is now possible
> to simplify sc16is7xx_lines allocation by using the IDA framework.

..

> -static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
> +static DEFINE_IDA(sc16is7xx_lines);

Don't we need to replace bitmap.h with idr.h with this change in place?

--=20
With Best Regards,
Andy Shevchenko

