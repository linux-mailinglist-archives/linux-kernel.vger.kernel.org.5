Return-Path: <linux-kernel+bounces-32589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1E835D93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0A01F2732A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83539ADE;
	Mon, 22 Jan 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wSblBoNJ"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D19364D5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914204; cv=none; b=VbMEhhn4v1zohSD36albdikrNfbZlpv94y+OxhQ3/OUdl+Prx11E0lfpLZON+7Bg9lnuRy0R8HFcikYHNwh5Le+pSrWu4Jg6s3exvsg3x1i0mCFkl2Tg8ntd6jviB/cgNb2jih7qKQqlupk3HHSjHo7+kgOl3MiY3sNngQeyjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914204; c=relaxed/simple;
	bh=+njKJ5zGoAf/8uWsGPVwc5bDkUZxyqOXYFLHFAW/f6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abh5h2es9e53+/Kdq74vyvksBaaUgCNx8j+D6sYzFlf/JW/kNan4CtVnRj8cWdhL0pflatXnHMZo9W3+z78eqUv80OtxgYrFLmED8lWK0QWTcrTUF1v1L81x/WlKLZ8f5l6xf0KUWbICfc7qAykEuO/qHDs4f6ToQpbk3IY7Hrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wSblBoNJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-466f6d4b6d3so592651137.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705914199; x=1706518999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUR27c1+iHU3ojrC4LDJ/zTx5jkFmb+9moT9azuGDlQ=;
        b=wSblBoNJyUW83Q/Yh72CAloigRFzMjBMMeKhkZhDx1d89IRjoJkvYwtralFbjHMP9S
         jPjBgAZVVSU5Vk9raNUNQ4YJpKDSHWVVBuvCN/GNqmt/owdpKdWNOaciwhLtSXRgx/fa
         U4wKy12nS23bbtMw0clkkJPRLOdgQaiROW88wf4vV2n+A80H8ZAmyGVimq5L2urIm4lB
         PwvnG4swZ39ILrqqfesdfGpg45vb2Off8zkVkeAie+PGFiS1V/iCt0V5k2kv+omvHsP2
         KkcK0vGhXwvPUiLlIiCCECmjUEAwx0htMeu52J38Ib34S2mghP9snj+CYavaR23bYAGc
         RCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914199; x=1706518999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUR27c1+iHU3ojrC4LDJ/zTx5jkFmb+9moT9azuGDlQ=;
        b=NWOup7T0mj08vRQ0gn5NK/Q09NeYs6WllQWMjkDxDTRzw1o0yMmwfAd/HbwB47uIdY
         nNpbuF74C/sgBx5L0Qfg8vOaF+Fr5qHr9NefWa/r08dbRmQxirg2K+ey17OhkhT6tYeh
         GsLyGHhzHz17sdYJQwL4508dfVCs77XX3A1/eDgWd828ChTb4Y7wDXqMXpZSZmi0eslm
         6M499N/DrVyFxP24I0WBoJBE8VreOd2tgQoD4Kq+NkmyhLTST8VMoiuAuhNNepQfGi9r
         2+fB+bHQh8SCJvwF21WhtliPxQ48W/JnQa3V012wMSy/IkRF5kadJeg3ImMnuqC3NjIK
         cG2Q==
X-Gm-Message-State: AOJu0YyoPnvllBEoKTPkvXRp882iQP1dHAPjnQgMUyxT+uH/vrFLhToy
	zxUCI/3STq3+0QwGiuZj9PgVNF84bYqOnu8kzTk8mXtAx1wSOl2U9ag/xF+fU8dHTYeLeCVXcTp
	i+29MRBJmY4kRvkk9okI7QCfWkLj1Eb89dQnmbDIf0Pv4twsg
X-Google-Smtp-Source: AGHT+IF8eESa41mI3oLuxHCHoMGVzbxUohIHKsVJ3gDU5CR8DvIfOpEJ9idSlUMF5+qSgs2hZ8AeLuwh28Hnrkt8UMQ=
X-Received: by 2002:a05:6102:2263:b0:468:1cc5:ed88 with SMTP id
 v3-20020a056102226300b004681cc5ed88mr550502vsd.23.1705914199051; Mon, 22 Jan
 2024 01:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109140221.77725-1-warthog618@gmail.com>
In-Reply-To: <20240109140221.77725-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 10:03:08 +0100
Message-ID: <CAMRc=Mc+FseBCD8h9T8=rYUhOJ7QC4FOxH+ePULnyf_8mKJMrA@mail.gmail.com>
Subject: Re: [PATCH 0/5] gpio: uapi: documentation improvements
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 3:02=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> This is a series of minor clarifications and formatting tidy ups for
> the GPIO uAPI kernel doc.
>
> The series is intended as a companion to my character device
> uAPI documentation series, but makes sense on its own too.
>
> The patches are self contained and trivial so not much to add here.
>
> Cheers,
> Kent.
>
> Kent Gibson (5):
>   gpio: uapi: improve description of fd fields
>   gpio: uapi: clarify hte references
>   gpio: uapi: drop trailing period from one sentence descriptions
>   gpio: uapi: document possible values of gpioevent_data.id
>   gpio: uapi: clarify using v2 rather than v1
>
>  include/uapi/linux/gpio.h | 52 ++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
>
> --
> 2.39.2
>

Series applied, thanks!

Bart

