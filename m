Return-Path: <linux-kernel+bounces-137109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A998089DD14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B051F2199A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BA130A4E;
	Tue,  9 Apr 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrcP0M3h"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8312F5A3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673723; cv=none; b=g5vwnsVqwH2gTOAcL4je9uAkmETJYn1OyNJw6eLHQOfF7zoQrbp7p9gc3aL4UZ60IaSDFBovJuvOOw4pFjjC4YSLAdQiJ19ktKgKJU1DLwc1V3kkNAdxIBq0yQBjW0Mazwsjl296JwJxu3yyRZeBCmMzDppedKI4kRR52bAEmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673723; c=relaxed/simple;
	bh=HC00lmey8uySGF4Lqn7tzQE0xcyEUhYbAHGKCK5KpUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1+5llrP74adwR9tybJtAorHXf0V5rxs8kfek/sLOgJ72Xvau28OV4sprH39JBAi4/b9p3IA6oMQ4EJMR10hLgDOo1jAvo3laXvCob9LMVXz6DDWjwFnfXCFRQVeFxy4SKH68VYpKFYjbcAcExLTasWHNDkQH8F+2GJtuhpQk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrcP0M3h; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47a0bebeacaso721549137.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712673720; x=1713278520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBPxWFHl1AiWVB8UI+LeFpQ0i9dZV3ja6KQ3kYMVIr8=;
        b=OrcP0M3hrVHMUHIU7aKw6E96OX5qd2osL/nYP1IIz9Du+yrGalPEq0XBILBGGDs1Go
         gcHpTpj3w2IVy680zeLygy3mLCpLJG1D/rgj/eNRX7wtbihH34XC3kkTJPMqKVl2TId7
         JOfVeY5wboQvMaALS21atRQG7s7TvkSzQnf+JD4aOXlIMIcZQ1BCI8fmCUXgnRywCSzz
         pc/tny1MDgXpQpw1zWUZ6nakjTF2QDc4bvSKlpvoCd4KoC0mUb/Y6rxfMFagAy2KzXrs
         VhPlSlsIWd1KhAEc76rJfEEErHqUQ3bXBsj26nB3YXwWcRsybywUjC7msqegaWfzbEAx
         puJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673720; x=1713278520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBPxWFHl1AiWVB8UI+LeFpQ0i9dZV3ja6KQ3kYMVIr8=;
        b=ZCzE2WF2z5Pljw0/EuHc5a38be7O/RjCo0BTaHzLWoCPfe2wRRfcC7TLFIQRHuPQQk
         p8fEzclvmzeSFFKTKm/S6aesj/SQp5Zdpq8XNPSJ1vsVk/lPk4syELuTsIYCb18BW1Lx
         cgcH+cNhKJkVp1kz07K+QNvBL3h9/fMvGDlLhVnQAbJHH98u0dfV4HllgHGotd8/veKs
         lcrAAyEVU6jVWJa8geq89SZ/OT7X6klk0q2tnDiWMXnUGIo2q6WehvAA/bInhLVGxwBU
         Fe7w98nULujUL15WEEdQwWLIy1B2opRWcQnjBJmz97f2mBqWll8EywZgyaHmChtLyhHY
         fYVQ==
X-Gm-Message-State: AOJu0YyRbne/9tZoi9PvNlrHuWUYBMedUKgBli19fKa0LcHXK/bfdXgM
	iqC+Hv2GQNmWU86F2hgJwwIdBDvq0BzpbWiTIHvYlx8Wq/5ASlG4OVjmgvsMxGdlJ/LMgNW9Yh9
	ksmXUH/5NYndoud2kF0KAw2/N0AY=
X-Google-Smtp-Source: AGHT+IHbyNQhlUoN0P903X2xsmHoLT6gRckaiuzHxU42vZAdz4IEjESKJ3IHBMxz17WuucojBcnvql3hz3d1QoxWFv4=
X-Received: by 2002:a05:6102:6c7:b0:47a:1005:ca15 with SMTP id
 m7-20020a05610206c700b0047a1005ca15mr3911038vsg.16.1712673720180; Tue, 09 Apr
 2024 07:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404195254.556896-1-jaegeuk@kernel.org>
In-Reply-To: <20240404195254.556896-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 9 Apr 2024 07:41:47 -0700
Message-ID: <CACOAw_zwwPDfnQpWEJ7ej2FAGGBoQW7H8NcdWOutB3fHpOibew@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't set RO when shutting down f2fs
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	=?UTF-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:54=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> Shutdown does not check the error of thaw_super due to readonly, which
> causes a deadlock like below.
>
> f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
>  - bdev_freeze
>   - freeze_super
>  - f2fs_stop_checkpoint()
>   - f2fs_handle_critical_error                     - sb_start_write
>     - set RO                                         - waiting
>  - bdev_thaw
>   - thaw_super_locked
>     - return -EINVAL, if sb_rdonly()
>  - f2fs_stop_discard_thread
>   -> wait for kthread_stop(discard_thread);
>
> Reported-by: "Light Hsieh (=E8=AC=9D=E6=98=8E=E7=87=88)" <Light.Hsieh@med=
iatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index df9765b41dac..ba6288e870c5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4135,9 +4135,16 @@ void f2fs_handle_critical_error(struct f2fs_sb_inf=
o *sbi, unsigned char reason,
>         if (shutdown)
>                 set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>
> -       /* continue filesystem operators if errors=3Dcontinue */
> -       if (continue_fs || f2fs_readonly(sb))
> +       /*
> +        * Continue filesystem operators if errors=3Dcontinue. Should not=
 set
> +        * RO by shutdown, since RO bypasses thaw_super which can hang th=
e
> +        * system.
> +        */
> +       if (continue_fs || f2fs_readonly(sb) ||
> +                               reason =3D=3D STOP_CP_REASON_SHUTDOWN) {

I think we can use "shutdown" variable instead of "reason =3D=3D
STOP_CP_REASON_SHUTDOWN" to be concise.

> +               f2fs_warn(sbi, "Stopped filesystem due to readon: %d", re=
ason);

readon -> reason?

>                 return;
> +       }
>
>         f2fs_warn(sbi, "Remounting filesystem read-only");
>         /*
> --
> 2.44.0.478.gd926399ef9-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

