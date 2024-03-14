Return-Path: <linux-kernel+bounces-102767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5B87B70F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FDEB232D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C8CA6F;
	Thu, 14 Mar 2024 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B52KTksK"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320EBA50;
	Thu, 14 Mar 2024 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710389725; cv=none; b=YQCW4KTyWvqDgmtkYOVYPV3RFo04vOBR85aC6EZVWZ2HQoyy59oEntYZQLJUTKvt4YNQN7gFH1kYSIOpbfKm7T+ywmOjltq2UW8tAWHGs90ANmp0v7zWmQEF7QBKQ8MGDXT2ieWSi4//chU0wxB72ClZ2FWeLhE3JxDyzSoDEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710389725; c=relaxed/simple;
	bh=xbTsjwT2mDcXpNldJEeNANYfR4NjD9w+vYksc48n39U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YUTSs9z0JnMMmuMZMF/PLw5JpOdY3r0pSFfXhdoU3JoJVTxe38d4eMbWqzVNsxXnOSNgqzlXBgnGieFRb9fhWN573beLHAPuckbx4l6KjwaR5WLMIcCbPIvz2NcxHFoTNI+CPyqApYlmpgj4QEljxfJAWWwJ7V7jLs94m7eEVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B52KTksK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513cfd48224so344801e87.2;
        Wed, 13 Mar 2024 21:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710389721; x=1710994521; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Yfbg1VYyDwlmY/W5AnBncnQQ+VcP/WErSbaMSMO/0=;
        b=B52KTksKQYP/n2cj/KNl2m6oIIM/ejof/EhAS3fVJoA4jKY1OuK3ZXy21nLjRvg734
         HhpePqGjRFaDrDJFQI+0ZMnlHQBxYmXVZ25BQj0Y474msSSSwTEs+hQiafmHH362KLm3
         8Sd8X9NffF7FpxfEkxbu9ajHSn90Kx0O+/ql4hfJVBQroZ0zjyZEaah3WWui/DPRIL7p
         YnWBFgoPStKpWpgQcAm6ILQD7M/Q8iJtw5bvwPS+MJEGLBqe1EPXylfjqCgEUzeEK7Sz
         qK+z9mpAjCEBnX2J6wkiU+ZN0S9Xi5exicjRwfjemFhOqJhxRfmZ/yxeec9I/fOS/QTt
         EA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710389721; x=1710994521;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14Yfbg1VYyDwlmY/W5AnBncnQQ+VcP/WErSbaMSMO/0=;
        b=PklURwxG2EUbsWdooUl5O+z6gadRgxH76/Dlh2twl+Huu+SvZA5Y50zF7comWk6v/Z
         KK2lMW7B4W3zHGIqRoVQ5H/RSG/9FPYR4NCq4Fsjtok20dwke2ZcO8AWvhIKfHvGfrQT
         GM4fS/6XW0GbHvSu9Ov1bOQWS9qCQ48WdBDb/MDtQGrc+xfYJ3ZJ/FCEpGnvubsBNoFd
         fgkz2d8/sJQY5TSePL0lG47nOO0G9ZPGjdYF3wjHsGwH7f/ySqmegO84aEilDiCvhxUt
         pGQof2oay3fcDECIVAiyEljd9GNm0xS1CiUtQVZXnnidbVJZatlow24MagUieY0OMjna
         cJpw==
X-Forwarded-Encrypted: i=1; AJvYcCXUzMdZ4+ca9g9tY0HEOX65rpZCmWLIK8l4/BZiXZGRYehv81zXg8a5XnA/ndEh3YCP7ZZ4jFA5LORiS3VDGrYM0JFDCPfNPAhTjl+g0cozjKz/4Wx6+w/HvKHGphFTT2LxTkmZPunNXg==
X-Gm-Message-State: AOJu0YwjMi+PIHWdi+He0Wljb7R1EFTBczvAlskIXGMBEw+68etOztLp
	F2Xt+TsuzmuKCvWEWdMYR6dZuhk1GUt/+N3MMysimgBT1HBGGLhRRfM4+8yt4SpKkb2ufoJIHBa
	frWpemV9euWitucR//65oKn/TGgm3BHwTrfU=
X-Google-Smtp-Source: AGHT+IGo+HS6GyAjIBCKQGxf1D5TFbnWf+ILktc8ZtTisl009mTsWTzR/GPdCAgqQkpaxlBgSgEfAkCjmeWmYrrWOW0=
X-Received: by 2002:ac2:57c9:0:b0:513:cebd:87f7 with SMTP id
 k9-20020ac257c9000000b00513cebd87f7mr257872lfo.57.1710389720966; Wed, 13 Mar
 2024 21:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeHr+PH8spL5F+iZ@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <ZeHr+PH8spL5F+iZ@debian-BULLSEYE-live-builder-AMD64>
From: Steve French <smfrench@gmail.com>
Date: Wed, 13 Mar 2024 23:15:09 -0500
Message-ID: <CAH2r5msT=tSRkpZq2+f1gLL5Fcq-ohpKzD0kBioirZH-fXwq=w@mail.gmail.com>
Subject: Re: [PATCH] cifs: open_cached_dir(): add FILE_READ_EA to desired access
To: Eugene Korenevsky <ekorenevsky@astralinux.ru>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tentatively merged into cifs-2.6.git for-next pending additional review/tes=
ting

Let me know if any updates to this

On Fri, Mar 1, 2024 at 8:54=E2=80=AFAM Eugene Korenevsky
<ekorenevsky@astralinux.ru> wrote:
>
> Since smb2_query_eas() reads EA and uses cached directory,
> open_cached_dir() should request FILE_READ_EA access.
>
> Otherwise listxattr() and getxattr() will fail with EACCES
> (0xc0000022 STATUS_ACCESS_DENIED SMB status).
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D218543
> Signed-off-by: Eugene Korenevsky <ekorenevsky@astralinux.ru>
> ---
>  fs/smb/client/cached_dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index 3de5047a7ff9..a0017724d523 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -239,7 +239,8 @@ int open_cached_dir(unsigned int xid, struct cifs_tco=
n *tcon,
>                 .tcon =3D tcon,
>                 .path =3D path,
>                 .create_options =3D cifs_create_options(cifs_sb, CREATE_N=
OT_FILE),
> -               .desired_access =3D  FILE_READ_DATA | FILE_READ_ATTRIBUTE=
S,
> +               .desired_access =3D  FILE_READ_DATA | FILE_READ_ATTRIBUTE=
S |
> +                                  FILE_READ_EA,
>                 .disposition =3D FILE_OPEN,
>                 .fid =3D pfid,
>                 .replay =3D !!(retries),
> --
> 2.30.2
>
>


--=20
Thanks,

Steve

