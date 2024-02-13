Return-Path: <linux-kernel+bounces-63628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBC853277
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41801286D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181B56770;
	Tue, 13 Feb 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AerJqCAg"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FB41C75;
	Tue, 13 Feb 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832859; cv=none; b=ljnPxaxWhX8+5pMkFKgq7St1sECRzLH5KWUDuQBsPpkXbgW6GvPRRBHxJUUf468+fELJoWdrHM0Uhsq50jStoeM6hm4UntT9HksfjtlMYdhU/sPhFqx2o8yOq23wjT9HZxhsbdTJovUW7G9FXiopBSzEYoQu2tB2nPSsrp83r5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832859; c=relaxed/simple;
	bh=KXEPGwOdDv4uxjcbbuUkZBm2YCwzs+IBe0V0odvfHcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPabb8L9ewrfZXO1itJeawQ5osXRL8pX8QkkMxVozMODW+FFRmcjA7/XHjZ/pGYlBwcjazfCwW7OeHyTSzZ5HXV8DGmwaZwblcZvzqvhYCO5wX3NmwsH0MT5Q67+b/S+w2V+GjI4Pk+PPP8MfAGbjlKnTegb2T4oierMHBqGxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AerJqCAg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so2485501a91.1;
        Tue, 13 Feb 2024 06:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707832857; x=1708437657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvMVRf/8Qh4AP3Li64P70szRaFtg/YOxyS+pIDeY3+U=;
        b=AerJqCAg6cx9ro9S8Cmti9Op/HopmqjdJpbstMqXAQayxpK3xPyZfuhZ7vq1xR57wi
         oja+2ZIvh8QnL9ZdesO01kUjXmWhTZNcseTBGLNkR6m93P4WcZvVlrPHcvG/IQdP+APN
         JdSb6soCIFJly4YybP9ofh5F8QhzcSo1jxSkME6Pz4qokut++oSzNm0DWglw5TRYkBZY
         D6EWd4tP0Udh2PWsQS6J5EBYnAp21R1rQIi3rZoE03Sbdk9QrAgq140W/VWpuZA0jb3y
         OU1xl5kx3QnYBBnUlawrVk3gCzDdkUHvjz+Ar3txozR0qquTI6TS05zl0WxZBRIaOYyb
         DD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832857; x=1708437657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvMVRf/8Qh4AP3Li64P70szRaFtg/YOxyS+pIDeY3+U=;
        b=cf0RW+PBLYM5ShiJWHhlR6LMde3QnbaXVWKvNBuX5VGQQB/D60qwe93KJOvkm4Ru4P
         rjuiAhsbk6xMgOMtEktnlgoyZKoOb7DVYUHIX7gUTQBqWM07VryrfY2UKa+oGhVkyIUo
         uMhNevdxi9WJYtvEFCclNxivnDyEjYTKFig6tHQhsyA/CBu+QzKjCuSMBSxc9nPmy347
         gWxH7dB8gYKAN64TqEiKGvFSjkF87ZGWIV264O/LdyiNtLRde+1TqmyxGlq0Fxj1N/sg
         I4C86t0EHk4GLue9+G/e/u/OqL7UWyJ9MzhsoMHh+Lvp4XxWwj7L90E4/3f6fDboPCTL
         V2sg==
X-Gm-Message-State: AOJu0YzW0OJCTlPiTiUuoChTqYAUo5g/9vcDFpVudYMe4mdxA+Ajr9xy
	fPmKG4US6/HRqVkC8XAEWEQdMKVa/bYVNW2tqueQEC53PNz5JuZLQDqPJtzcut1eGpWt9onnLOd
	SoI7zfgfegcfoRHBP7V9v52DkD2s=
X-Google-Smtp-Source: AGHT+IHNJckNa5UDJY8D/GWcd8q+DY7pYSL8guGaVEGlmTmyqmqIna8Hm2NDgUtcz5Q2MjyxWtL1iulX0awEbY5Au3c=
X-Received: by 2002:a17:90b:1015:b0:297:2f49:7aa with SMTP id
 gm21-20020a17090b101500b002972f4907aamr4141526pjb.43.1707832857248; Tue, 13
 Feb 2024 06:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213150050.083de445@canb.auug.org.au>
In-Reply-To: <20240213150050.083de445@canb.auug.org.au>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Feb 2024 09:00:44 -0500
Message-ID: <CADnq5_M4sE4K9OCGVSDU=na_eQTV3YyifPHoERam_zJHM_nqpA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks.  I've squashed the fix in.

Alex

On Mon, Feb 12, 2024 at 11:00=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:42:
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1559:13: error: 'amdgpu_choose_low_po=
wer_state' defined but not used [-Werror=3Dunused-function]
>  1559 | static void amdgpu_choose_low_power_state(struct amdgpu_device *a=
dev) { }
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> (and many, many more)
>
> Caused by commit
>
>   c77536b15b7a ("drm/amd: Stop evicting resources on APUs in suspend")
>
> I have applied the following patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 13 Feb 2024 14:41:05 +1100
> Subject: [PATCH] fixup for "drm/amd: Stop evicting resources on APUs in s=
uspend"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 2a3f12bae823..2cf4fb3f7751 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1556,7 +1556,7 @@ void amdgpu_choose_low_power_state(struct amdgpu_de=
vice *adev);
>  #else
>  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev=
) { return false; }
>  static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) =
{ return false; }
> -static void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { =
}
> +static inline void amdgpu_choose_low_power_state(struct amdgpu_device *a=
dev) { }
>  #endif
>
>  #if defined(CONFIG_DRM_AMD_DC)
> --
> 2.43.0
>
> --
> Cheers,
> Stephen Rothwell

