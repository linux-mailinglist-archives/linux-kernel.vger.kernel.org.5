Return-Path: <linux-kernel+bounces-82246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5701386811D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB238B22E17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB912FB39;
	Mon, 26 Feb 2024 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evl44Lqn"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6122069
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976080; cv=none; b=BybV9EiGiqeq7zagbmcKpBVDmGAQLFiMckEgRVsSjpjnyW00GyJDUcCp5TA9wne7vG/FbtOLhFoISoflw0YdHi5RDCkFLgLAcJ9C2597bMMAo1zebJxOFvEn6kcjbPS0SdKHkVzlv7go88JaZ8XFS9l7JEqEt+BwZmT2rTUTGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976080; c=relaxed/simple;
	bh=hWEKAq88fYxNI1hRg1anzj/i0fUllsHeQ+yLt2KGLzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQzFLwQPDK+ak97O9wcPgejV9m0K94vNbz+o0fGYgXvgdpSgy4r20uLzukcWnX/BEKqhSgDFqU0fuksWP0naGat5BsmMUWDGPod1c9bPrXef/s39T/UuVVU+5IsWKwQmwm9+sYDW19YImFbo2CSPArDXpl9u2s1jZeH0P/z4kFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evl44Lqn; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c8a8f59ad0so470914e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976078; x=1709580878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OglrNgb8KxWqpi2oIRKvGycThhSHWIKrWgrygyi4MtM=;
        b=evl44LqnKAW7iVtv48ofMsqDIjC0bt+/JRM5wILoZ1UN3pZfa0tH1Y4I7cY4QrGtOo
         XUyxqZPcASAjegp9mM2ETiI9NCjprJKNXPcLVEkad0eSe9C1qfG2ZzfWRHf33diXjI6+
         msJZcBZI1iyh5K0c+0NYbiKWNMsxNzanGNy+1gLnGazZeNJPCCji3KUM7TJLoH8npcj1
         AzTvyETe6XKb3VxO6GhwSK8t8mdpTyhiCzioTp1xpZfQ+tQ6tVUK29PMMe9R3+yB8zRK
         hzictgELY+yv3eu6RCfbZ5kmbChLB7Wqp4IIqs1cuiWV1BDDxfQrt34v6UEjq2C6xaob
         k56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976078; x=1709580878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OglrNgb8KxWqpi2oIRKvGycThhSHWIKrWgrygyi4MtM=;
        b=fNaC4vjBD50xoxnqFR/4CIfy8vJXgh6/nYzHfUPOLtP3/XMVVyo5uGbEmWikLFMSGd
         zeiJWzeQuP6r+qfNIaJTWfNBu198XSfPmZUkgT/rQhgwgvjio9vT2R4LEuzpdCKRruVh
         zU2UrTNpRkvxqzqDH6EiDfSsDXkHa4nTJooyjIJroBFQrb8ApkjxqkO8J6OJP4XFwnSg
         +0N78gbhrbl0KPIFO/hsXwaHQiu24fZOLYqPj5uGhAyvpH8d0AsewKewqJQ6ryDbICTW
         osX5MrGAPoSaNbUuDmDBc2zWutJfMNRba/fRC7saKonlAP/lEefteHCtf35vVUuRwjup
         IfsQ==
X-Gm-Message-State: AOJu0Yx73ji0ShQFIJo+ofrSd+8Ydx5GVvhLQuZvQOUF3rc4aWEbFjam
	KZMicXlriR/lwOmhjCN4Dmw9O3Q3l28ZeH1diHakTvNPFkfQfuAZo0x8LdSyNy951x/7Aml3UMP
	D7EEOKyQBmNKl6NPl9rUA+Qxyu5Q=
X-Google-Smtp-Source: AGHT+IFRbmLcH3yDVMWlS4qRhMIzTge8OdpmN7IXcrrJAEBTH5t6Buk71GP4NesYll77VpA88EfVMoNzZG/5LoYJ3VA=
X-Received: by 2002:a1f:c784:0:b0:4c9:a9c9:4b3b with SMTP id
 x126-20020a1fc784000000b004c9a9c94b3bmr4166189vkf.9.1708976077978; Mon, 26
 Feb 2024 11:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223205535.307307-1-jaegeuk@kernel.org> <20240223205535.307307-5-jaegeuk@kernel.org>
In-Reply-To: <20240223205535.307307-5-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 26 Feb 2024 11:34:27 -0800
Message-ID: <CACOAw_xdBY5Rg1J4jUTaH0UxVrdZ+CCVQj72q_cMxyCHuCTy_Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: allow to mount if cap is 100
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:56=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> w=
rote:
>
> Don't block mounting the partition, if cap is 100%.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6d586ae8b55f..f11361152d2a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -904,6 +904,9 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, b=
lock_t unusable)
>  {
>         int ovp_hole_segs =3D
>                 (overprovision_segments(sbi) - reserved_segments(sbi));
> +
> +       if (F2FS_OPTION(sbi).unusable_cap_perc =3D=3D 100)
> +               return 0;

With this, f2fs will not execute GC. What is this 100
unusable_cap_perc used for?

>         if (unusable > F2FS_OPTION(sbi).unusable_cap)
>                 return -EAGAIN;
>         if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
> --
> 2.44.0.rc0.258.g7320e95886-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

