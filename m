Return-Path: <linux-kernel+bounces-30247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E555831C34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A3C1C22059
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028B24B38;
	Thu, 18 Jan 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Waryo2ob"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2251E893;
	Thu, 18 Jan 2024 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591078; cv=none; b=CosNMFp1oMNPB2PJa/ld5gRDdvPPgB5eT5VvWKHiE8WS7QT2Ts/SFtpkJNEwbd+0pQc7IPSprBZlb95HxOe3KHnFSERXVxeGCMVvBdtfH+LLmVgMnj48ePvvMZjCS35yam/dPIKpJI4WRQHyaI+2x6AE9tQazGP3QMP93+PL+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591078; c=relaxed/simple;
	bh=y2f1I34XlBaXKaJRsT8nYxnUv+jA8opfGpK2r9ub/rM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=TFZO8ytdUBQEJzic7w/NZ1qWcFSBcULyIgZ0evU1T6em6tc6+BHsWNiluYokyHhfBVyZP022iVTD75gwdkpymlGAVplq0KtEIo/fP3rLA66xNaw0tFEIzQomtoHJ58vx+RzuxEDkXXebn/4XjDlBruklLLS3fNl+xxv+G+AL02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Waryo2ob; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so15366586a12.2;
        Thu, 18 Jan 2024 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705591074; x=1706195874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXNIeN/MszADqIFgoeR3I4RBj7C13Kq6e86qa9HX4xI=;
        b=Waryo2obONrZ4zHRYZ6W6HcYJluP314WsydWOz6/JgzNwTGcE5j2DQOqE57y2HUEY3
         w3bYATRGMeIikqfzuvrNGYS41t1gLBikrzbuYtOpGvH/sfxH8PjtwiwF2LJKC2jE1rnC
         9FhuGSIT+Gn+RENwd6GjlKCH/UTILLgx2qwTnxURRFttVG5mw049IiP/xNxXa5HeeSpn
         yd/njWvpIOw6CF03lTwXbgufkMy12wosN60hrNcJaloE6oKcp59seyFCld2gyYew9S4H
         +wOtOmiCFK0KEke8phHMuUeI47SAG67pm8zFQKhPFbsGlJxHeCh6h7wgVvYaB1vA/6p9
         dxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591074; x=1706195874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXNIeN/MszADqIFgoeR3I4RBj7C13Kq6e86qa9HX4xI=;
        b=fZpiwuJ9PlJ5b9U+Ga9HqYWZSW/jPlvW7VFnzIlw9Bf7zZK0aPs1fyWb1tSqW/dPlR
         OIH1KHzvxn8DbJ8TgbCJmSirArMPg1//c6rQA7bjrtZznLbIu8SI2LQIxzPf+WZ2fAW8
         c+HKwkXLDz9DkrYXHaSfqhgzuJpRBquYEqA1VYkVgqOC8VKtypOKm/rQwpgZoPzbTbGY
         j/O0B5UmhM3ZxPj98vLGWRQJOfNaRtJDxYp5I4inKoTAtgRmZwavs49pSHvnCg3Zg/+u
         p23WvRdjNoDPpKd/8P7yjdUDRjNAIkjuzdR794NtM5Akif9pjB7tDKyPi9Z4rSxcUczc
         eWYw==
X-Gm-Message-State: AOJu0YyRUhOIRv9t1qHTu362G8Ryi2aCtPFdQJLZ5CY6APXbei6L0Tcg
	ztIMowgwDm2uAuRl6D/FwZWk2ncpzLaGftk4uajetbfFlwRVgXZHrpUmMoNP5sSqL2BK4P4atRL
	FI8AvlOxmoVLyUZYlGuvnu7O1QT8=
X-Google-Smtp-Source: AGHT+IFxWpCFIFpoZ3849a/o+eU3juZNCrElQE/y1Tth9QxilfiAvh77bZdBf3nXrA5jRv2YTsqpo5ZGCSf7J8a0+y8=
X-Received: by 2002:a17:906:4ec9:b0:a2d:359b:2435 with SMTP id
 i9-20020a1709064ec900b00a2d359b2435mr390836ejv.116.1705591074445; Thu, 18 Jan
 2024 07:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118151303.3828292-1-alexious@zju.edu.cn>
In-Reply-To: <20240118151303.3828292-1-alexious@zju.edu.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 17:17:17 +0200
Message-ID: <CAHp75VdCKg3x3vc7TyjZ1bBwNj8aqk7Th8X8O9+kRQxM_CNdBA@mail.gmail.com>
Subject: Re: [PATCH] [v2] media: atomisp: ssh_css: Fix a null-pointer
 dereference in load_video_binaries
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Hsuan <hpa@redhat.com>, 
	Dan Carpenter <error27@gmail.com>, Brent Pappas <bpappas@pappasbrent.com>, 
	Alan Cox <alan@linux.intel.com>, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:13=E2=80=AFPM Zhipeng Lu <alexious@zju.edu.cn> wr=
ote:
>
> The allocation failure of mycs->yuv_scaler_binary in load_video_binaries
> is followed with a dereference of mycs->yuv_scaler_binary after the
> following call chain:
>
> sh_css_pipe_load_binaries
>   |-> load_video_binaries (mycs->yuv_scaler_binary =3D=3D NULL)
>   |
>   |-> sh_css_pipe_unload_binaries
>         |-> unload_video_binaries
>
> In unload_video_binaries, it calls to ia_css_binary_unload with argument
> &pipe->pipe_settings.video.yuv_scaler_binary[i], which refers to the
> same memory slot as mycs->yuv_scaler_binary. Thus, a null-pointer
> dereference is triggered.

Good for me now, thank you.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. If needed, or Hans can do it, the references to the functions can
be amended in the commit message as we use the 'func()' format (w/o
quotes).

--=20
With Best Regards,
Andy Shevchenko

