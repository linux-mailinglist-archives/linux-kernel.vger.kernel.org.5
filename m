Return-Path: <linux-kernel+bounces-145386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C28A558F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5030CB23235
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B871B32;
	Mon, 15 Apr 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSWogZAC"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DC2119
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192548; cv=none; b=KBI8tcsogfbUvwlavJVa5zfNAjm+3O2D7e53JyZclZg/bDiY6mPbOdNPhIcMO1npLIdkQuFSZ6FfSLPa8oZvGSxrlXzhtYndi03gkrk6+dspg9yfLwyJ7n6Dr6VjQ6J5A9D1KVoe76R1hEJgUzxPv+AM7nwzv7/5b52fgfWfHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192548; c=relaxed/simple;
	bh=fBKUtpe6WJlYrr2+zWFLvMQ3icE3ciafglrtrTmdNhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgM00tUBp9Oi6dVBwdqrM9cOOd70WtKawV/Kh1sZMwrAdG/xnc7qV1s4clIchOBS+KlSiwY5MFGvFYHx9aiPnPX7/m/XrQSJlpCiXiJoz0Qhu/tJWj/GlEcZSQtdXwZUKlSD0/vQyWNWkIW2ezhy67uwzS4YN3A6HH842fhIFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSWogZAC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so4229698e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192545; x=1713797345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doatgCkp4QpvYF7S0Kze7TiNN5VDcuPhSAFHmXBg71Y=;
        b=iSWogZACYR3sxVsTDMRBQY8pCEd7FdNTzc5dq5CCC8HadjEIALsi0Al7CSIXH89G3V
         zAOx/XCGcwJY3m9bgoFBx9CUb9ZgOx7Y5HBgUQLtgHYB4wO9jC8fyUWOgHA7o+0XolvS
         g+zR3y/AiA92djvkKdm8ohrxfc/IZFy9ViPbFnobZR0+I4lIKMevrEG6f3914Y7HaKlk
         sI3H6zlwlQlQHt7uOsUlhadXSDAo5VnhTaaiuCxCfyxxp+k8axEYxMTK/w12Txy6Qh09
         eh0bhqId1OuRLbPo58D2gDiC8HbpoziB8f6w70CpM2Vte0omeDDReyR5u+ZdEJs4OoW5
         W8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192545; x=1713797345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doatgCkp4QpvYF7S0Kze7TiNN5VDcuPhSAFHmXBg71Y=;
        b=nnJOBwC7uugJNy0+lzIGhGC1kOdRHFpB3csrzRkR4/gYReqfzCKTWfdsWCIOxTtJ3s
         VZAXcFNSRIAUyxHgfXTPweOUnfhlrBpe2vCB9CnWROiFtXYWGtvd5BInsm7P1hZz4ewp
         RUaoj9jhPW9w1QG0PJUVVrqbCNDrGHYyoAVDW5h+YaBIfgom9B3CohaImlT/0vZBEoGP
         O8omp4FAtsCYhVkqsjG8DtZgSV1dtp0dUJJboAaCB+UQG7lkW9TC7X/cDffRjJxGGiJ2
         R0ze93p+ijkLagqYM1md6EP/cV4b/DxeWp76F7OGI2ejEYy7rThfHGogSPS9cU0hMlrP
         pdww==
X-Forwarded-Encrypted: i=1; AJvYcCVSjatJsSsH9jVeArRvu68qBXdM2rlI3Pn4e6YlRROFsQbiTxUIi4ztn+HF0udnN6E9RYC4GtmIyqq7zNog7andKYzJgLgLh1eEzDLz
X-Gm-Message-State: AOJu0YyiUs9fLGkKlSCrDI9mki5pThiuylKSJlCffdpXbu0l5iFyvzgU
	FfniIlYajkGUtUPf8pC0IgcpWsBRWTR5jF+lt+Sv1hJZSGxIvclQSJdjL3l550azyB/Gfe4WZyP
	Po4ENqO1bKOYfBuKi5ocQMQ5mwws=
X-Google-Smtp-Source: AGHT+IGqzYslrlA56W8a6QWZiyip60apCM21A8KHq3XDZjgDsG78nj1SbkXG74RgTlU9gVsfjJsRP48sfjcu0l6vBk4=
X-Received: by 2002:a05:6512:2e8:b0:518:9ce0:e623 with SMTP id
 m8-20020a05651202e800b005189ce0e623mr4883704lfq.2.1713192545274; Mon, 15 Apr
 2024 07:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000209c9506161fd1d4@google.com> <20240415132828.149954-1-aha310510@gmail.com>
In-Reply-To: <20240415132828.149954-1-aha310510@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 15 Apr 2024 23:48:48 +0900
Message-ID: <CAKFNMokdSAKhe41U7N=hwcq9EYFP9AgDo5OYpJ+a-VrjHjeF_g@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] UBSAN: array-index-out-of-bounds in nilfs_add_link
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:37=E2=80=AFPM Jeongjun Park wrote:
>
> please test array-index-out-of-bounds in nilfs_add_link
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git 0bbac3facb5d
>
> diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> index bc846b904b68..aee40db7a036 100644
> --- a/fs/nilfs2/dir.c
> +++ b/fs/nilfs2/dir.c
> @@ -240,7 +240,7 @@ nilfs_filetype_table[NILFS_FT_MAX] =3D {
>
>  #define S_SHIFT 12
>  static unsigned char
> -nilfs_type_by_mode[S_IFMT >> S_SHIFT] =3D {
> +nilfs_type_by_mode[(S_IFMT >> S_SHIFT) + 1] =3D {
>         [S_IFREG >> S_SHIFT]    =3D NILFS_FT_REG_FILE,
>         [S_IFDIR >> S_SHIFT]    =3D NILFS_FT_DIR,
>         [S_IFCHR >> S_SHIFT]    =3D NILFS_FT_CHRDEV,
> --
>

I found this patch of yours while debugging.

This patch looks correct as a fix for the issue.
In fact, I verified using the reproducer that it fixes the issue.

Is it okay to understand that you will finish it and send it to me?
If so, I'll take it and send it upstream after thorough testing.


Regards,
Ryusuke Konishi

