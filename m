Return-Path: <linux-kernel+bounces-5865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC08190A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3EC1C24710
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD738FBA;
	Tue, 19 Dec 2023 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djO2xDfQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1C38F80;
	Tue, 19 Dec 2023 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so3248951fac.2;
        Tue, 19 Dec 2023 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703013683; x=1703618483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ETYb4p/dYwWhsBHF1nMWqW8fNK9SRI38gyUWxBP4t0=;
        b=djO2xDfQd85a2fpTfGKAzijr9XuJyDlw5Oxdn+TrlvwWNcGOYuHBlGpscQn0S4Yqlv
         fv2vzfeACQqH5ld5B8TJ0MqrWuUHBLZyPFjDAgSVme3gSKHEx6bGvD5F5oH7pP81AcE8
         QIDTChN4TlIu7XycdmdV5IOpjoHzsIFGqK4yBSAChFGDX+ORs1MjpE7H9Ee3jHAg7TTq
         +HDkigGPUjrA8/7B/k8jCz2LN3Nw6CXg+/aXeJClT/cOetSbBIXiatXVKQr7IW3oYNZw
         tign2j4cE/5/7KbU4aqhK5KaknIxCAzw1jzhtAJtofKB6HFtUq+m4xIIHa3fNITUj8w2
         DzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703013683; x=1703618483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ETYb4p/dYwWhsBHF1nMWqW8fNK9SRI38gyUWxBP4t0=;
        b=E+5H7QBQ3pS56mn699azncOL0rnYVrgSk3ujw9BORXvRqCibbehrG1l6IJXjleK5m3
         UouzEF2Q/vluFA9J37UI8hrg93mVw4Ksw6x99/YQSgXoPF0vIA9xcivK/MC7ERhLJ1XY
         zLbsDKrYv0EDFG7h7yXuIqGx+7ivSiD7Lb5T/8eX1ubHIVK1VjPTWWie//pMaNsP9YlS
         VoXFfRszzHOTlsQTO10RYZI9MWO4v+/Xymn3tlX1zgsOBl8Y38l3UCTRUJ24nlBkl49g
         khKhM/Km81tzhWI/RYgY4v+6h9bg2TNRx9S2CYCTgIj4cMtTp7iv3Z2dm+vSAzCJ6Kl/
         HlGA==
X-Gm-Message-State: AOJu0Yzrc+hetWL3POdgMA4ovXMASypyepkDIFuARyHEndvKCwyGlQUh
	hf8vajaJWyzzw9Ao3gfEWfEnsI0jWTbM0dqmKig=
X-Google-Smtp-Source: AGHT+IEZVSzHdhnBJF3ACTt4+Byj88TFSnsLe822jMawRK5DOWRBwmTecbWpBZ7A5KtB+207zqeJFbXxzgdOA1vZWXs=
X-Received: by 2002:a05:6870:15d5:b0:203:eb72:7594 with SMTP id
 k21-20020a05687015d500b00203eb727594mr2055316oad.19.1703013683353; Tue, 19
 Dec 2023 11:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219141930.367426-1-colin.i.king@gmail.com>
In-Reply-To: <20231219141930.367426-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Dec 2023 14:21:11 -0500
Message-ID: <CADnq5_Or8UGd1tarX9_Jvd20Lp3TcPYiGxCNicuExOJCiNUEmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant initialization of
 variable remainder
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Tue, Dec 19, 2023 at 12:40=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> Variable remainder is being initialized with a value that is never read,
> the assignment is redundant and can be removed. Also add a newline
> after the declaration to clean up the coding style.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/basics/conversion.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers=
/gpu/drm/amd/display/dc/basics/conversion.c
> index e295a839ab47..1090d235086a 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
> @@ -103,7 +103,8 @@ void convert_float_matrix(
>
>  static uint32_t find_gcd(uint32_t a, uint32_t b)
>  {
> -       uint32_t remainder =3D 0;
> +       uint32_t remainder;
> +
>         while (b !=3D 0) {
>                 remainder =3D a % b;
>                 a =3D b;
> --
> 2.39.2
>

