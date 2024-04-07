Return-Path: <linux-kernel+bounces-134254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A289AFAD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220C4B21860
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25611CA1;
	Sun,  7 Apr 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS0xH+NW"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB01111AA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712478606; cv=none; b=hztAqXsbaAuT/IeQaA2XgsHDjW0TUkvG7VE0ICgHsrRFkuDd1J9ycEHPtVQOGVvxx1sSj5LyRkE/calp4rBnCpmhljwuqlT2I0DuIcQ/ZNr/sIJyPtL7jX7JovimReCY4vC2mB2MLnu+fwsJvbj8oxp+j77ZeSXxaAbaJILF/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712478606; c=relaxed/simple;
	bh=eJ0TA+uucCe9HWrgb6ba/hkhLf6bm/hwxDEAlFX17IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eONcOOS8eDLRf08qXKj5iOaxHjjx4X1fxMWBUenrmECFrTPUSDu4jrz9WwycuA2pm3kp9+ZfMSEJDC//F6f7F8DOQ6hgEQw+PEo6D9mIyJVjZBL+/F5uAk7FblYt+/CWXoHEIWep3hAVjAM3Dl/3PWKd8DbnpKqTW/QZAGhRuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS0xH+NW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2629431f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712478603; x=1713083403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KegH3sR2j0m95M/huZzcgru/39HKdJxkpUlKBF8/G8M=;
        b=QS0xH+NWV3gXGyOKHqmt32jsMiUomMnMHGLrlBodd3qm/GWJI6z78nmCDqYOGzJA6N
         aXC1p+ntLEg3FoprRtcpAn/Ca2O+OU0dZGJfBJTa4VhjR3F/YJVMBZteoTBMllfEICwe
         npaEGxvic9DAjzx8HenOXIxI+of/d/X2QO1pFWhCjd2uute5cdHDcJ/uL5ZKVVFfrNgd
         RrMuG73sQsjcP5QASv/Mpe+LL0+WR3kzNdV7VUVjG1iiqzNNlIMM8/ezu4tV4qryyi3V
         qpBXhlNu+sqrqBhhkQBFMklPklzSJ9PtP0mtfyHIWiWvY8A3ajwX189lmBP3f9rFOKd0
         OBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712478603; x=1713083403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KegH3sR2j0m95M/huZzcgru/39HKdJxkpUlKBF8/G8M=;
        b=l4bOgOryn2vJBpA+1hpPSJRDJh2qcrTwDRk8+blA5JqqyyhHW1D82xfbARxWa3/aWn
         eQ1B0eDFiL0d0yTs+8gmDTYZC0OtqOrX2HkkZGmOK29RKNKD+uqGpncz9CCGGVp3thxl
         pgOwoD+pJAM2lT6Kb1lWZc6zhuIMWJ+3xIVuzuCucaFKL9Mv7NhPKfL+H+V7RK1lMSje
         87crFdwMQrhjdI1JhuQhfpz7/7HACPTDNQc7QtRh2Gxv//jE9OeUqChh4JSxeR68rpqE
         pi9aKt8FKPvnnW8jcVAr4ozYNJDbiSky+w2sZrtyIEThlZ64oyi558CzSaU6I++POezT
         rAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT+z/Nq2PKOV2G6MHvf3SEIZvMmrUVGdtqzwc1wfcLz3P7RCiOROG5uk4H1TC23Q1lFwC9Ub8pzcX1n2Y+IyaTth9RG6STRJVKhZMU
X-Gm-Message-State: AOJu0YyQJTCj7a6Fz5PjkxAbJNgatmwaahm3xh0qg/WzB+JpA/JtDl8l
	HxGmewR9L4zTKo2bS+WFJFh5uDRD4f3h2OagoLtDvE4tSR0wAVE3WT8t5PvpsdwWPwWe3RNYttn
	ImZeKVIOZMY4JaXwRtwhGkwlVok0=
X-Google-Smtp-Source: AGHT+IER9MAB73PUR1jmYTeM+srRha7Qvz29IeaO46RJPWA6TGNOJEbz4T5IkM8olphRgM345g9jm+LxQTjXUm8RluE=
X-Received: by 2002:adf:f345:0:b0:343:7884:fb52 with SMTP id
 e5-20020adff345000000b003437884fb52mr4655325wrp.50.1712478603332; Sun, 07 Apr
 2024 01:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403142420.2042498-1-chao@kernel.org> <CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com>
 <6a50a23e-8975-43cb-9496-38b6a083c703@kernel.org>
In-Reply-To: <6a50a23e-8975-43cb-9496-38b6a083c703@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Sun, 7 Apr 2024 16:29:52 +0800
Message-ID: <CAHJ8P3+YPhH9BsQumZFVM=bc_7zb=4oZH85+qG7bA4XJ3vLsFw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to relocate check condition in f2fs_fallocate()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 3:29=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/4/7 10:11, Zhiguo Niu wrote:
> > On Wed, Apr 3, 2024 at 10:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> compress and pinfile flag should be checked after inode lock held to
> >> avoid race condition, fix it.
> >>
> >> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> >> Fixes: 5fed0be8583f ("f2fs: do not allow partial truncation on pinned =
file")
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>   fs/f2fs/file.c | 20 +++++++++++---------
> >>   1 file changed, 11 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 148bfe3effdf..83a807e25e31 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -1820,15 +1820,6 @@ static long f2fs_fallocate(struct file *file, i=
nt mode,
> >>                  (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_=
RANGE)))
> >>                  return -EOPNOTSUPP;
> >>
> >> -       /*
> >> -        * Pinned file should not support partial truncation since the=
 block
> >> -        * can be used by applications.
> >> -        */
> >> -       if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)=
) &&
> >> -               (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RAN=
GE |
> >> -                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)=
))
> >> -               return -EOPNOTSUPP;
> >> -
> >>          if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> >>                          FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RAN=
GE |
> >>                          FALLOC_FL_INSERT_RANGE))
> >> @@ -1836,6 +1827,17 @@ static long f2fs_fallocate(struct file *file, i=
nt mode,
> >>
> >>          inode_lock(inode);
> >>
> >> +       /*
> >> +        * Pinned file should not support partial truncation since the=
 block
> >> +        * can be used by applications.
> >> +        */
> >> +       if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)=
) &&
> >> +               (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RAN=
GE |
> >> +                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)=
)) {
> >> +               ret =3D -EOPNOTSUPP;
> >> +               goto out;
> >> +       }
> >> +
> > Dear Chao,
> > I see  the judgment code "if(!f2fs_compressed_file(inode))" also is
> > before inode_lock in functions
> > f2fs_ioc_decompress_file/f2fs_ioc_compress_file/f2fs_reserve_compress_b=
locks/f2fs_release_compress_blocks.
> > should they are changed together?
>
> Zhiguo,
>
> Thanks for noticing that, I've submitted separated patches for fixing
> because those bugs were introduced by separated commits.
>
> Thanks,
Dear Chao,
You're welcome^^

>
> > thanks=EF=BC=81
> >>          ret =3D file_modified(file);
> >>          if (ret)
> >>                  goto out;
> >> --
> >> 2.40.1
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

