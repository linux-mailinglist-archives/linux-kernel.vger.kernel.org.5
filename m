Return-Path: <linux-kernel+bounces-145581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A48A5812
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83071C22442
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ECB82482;
	Mon, 15 Apr 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIRg9Fca"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190E8062B;
	Mon, 15 Apr 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199519; cv=none; b=Uwh3x9Y3ORPmYdfribu1HHoSDewASjb2mtfCyBnoJbVp7T0bcXpL8h4g/a5tIxxLX0KplfQswmOBPi+DIIpgCNFqJWFgNzlB2r68z3TdKIoe6HDIh0oxXg26JndN3JpCb5P0ZzI7kjeMoD4of/Cttau6T9mtByKkSOMb7WKztlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199519; c=relaxed/simple;
	bh=wBW+oa3pCykS3OyYpa7PMDqthcdmirp/ICjlcDVn1yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZXLysGChLCLslkDatMlHbXY+yuYYMbl7vszt7C5zJH8DkOT9Dt5uQUqDvJ1clJkEYRkfeDSdR92oeE0mxJZU377QVQ/UIOSzydR9vSasZS54HXHs9LIYVhk66o/pvYqhARYhCfGFrYELgBHoLsherC/jSi7eXYIxHWbqCOCOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIRg9Fca; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso40667281fa.0;
        Mon, 15 Apr 2024 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713199516; x=1713804316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9v1PjagDUY8H1QOOVNJ+FGMolz3i+jv+HOl4/jTkIU=;
        b=eIRg9FcaTvT38cqeyLnOI+5Jr6EePO9BibI5Iso3M201aiskSxFTPrwI17vygmW3ND
         GpIJmn89np4NllRSMhFvqihCMxwiOXR8/85anNRymUf4z7odPmpQCdeIGoKv95MR+uiQ
         e7pfBhw3+juytU6/qQBEwVP8Yc5WkwpqHHX0inmWfDaFLmxwdxsLpWQ7n2CDioIQnA0w
         K4a6AJs24PHaOOJ4EqdMig6MdzcWoZ5mwz3/ShhEKvghKUSrfA4Q0gUpXBKOtwxi7LWq
         xySSgGHWP5KeRDvroEjoseMV+DHOMsKGSKbydXM+QVS5tpFyd2x9jY3Ncc3RK/WKw+hi
         V61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713199516; x=1713804316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9v1PjagDUY8H1QOOVNJ+FGMolz3i+jv+HOl4/jTkIU=;
        b=QuZJBzqBYVCfbsdR5XV+zHOreRrjcZuV55l7+bK3an1ofKW9L2DBxOxwE33JALFHju
         9BdOJLAmOWXCsSyTozQsIb+3ppQDCTFNdttGrE2IA+PnRl4XoGc89poT+sCIDsFCpVO/
         fIUaFanQmizBh1vbdIEiKa55zWE+wJ+5n5f1rxc0bonJ/N8TrlbPa2flpIsuvaW+2gFG
         51xPYFA+I8SIrC2n9C6PAgVSIKSysgAPmpzH1olrcoQhM4knPKIZqdBzU4aUk6RVqlie
         V61nUeS4Izz5ew4OB2Iqki+e3oif2j7zb4+OwwgK/Ag8U+u2VFHvVQn6crSw9JpYYI2W
         u/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXpAc6Uiljmo8iVP/+Gvmo9Tw7JwHd4lSG/6gODiNn4fvHxs6GmWZ+lEOzNQOG/RJCtSWMFKMehfSiWAWHzUmiCBp250BCNMVKgWbB
X-Gm-Message-State: AOJu0YzG4/merH9PuStBRZAZNf200f7tqZOHK0j18HFcVrGbl0E+U/Sl
	BSpE6mV8GURqCHkcRUKcp5maCTj0knmlUW2rQl/AauGMyLSpeRkveNcurqo2FvGtzK8oBnpwA03
	cs/5MK9U0uodkmRByFNM1FU0MTSE=
X-Google-Smtp-Source: AGHT+IHo3yzw96c6T6O7XQd5D5MeUjIy17EQ78/NP06KKVEq6l4hTDOfe6aa3zGIA5cBRi8TDGB1JrQnInWCofP859c=
X-Received: by 2002:a05:651c:19a4:b0:2da:91d0:54e7 with SMTP id
 bx36-20020a05651c19a400b002da91d054e7mr2063608ljb.31.1713199515580; Mon, 15
 Apr 2024 09:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415154002.151149-1-aha310510@gmail.com>
In-Reply-To: <20240415154002.151149-1-aha310510@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 16 Apr 2024 01:44:59 +0900
Message-ID: <CAKFNMon3DWhBxMor7UNqTcrTdms6nUQF+=uWDeEc0wWerH4sOQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs: Fix OOB in nilfs_set_de_type
To: Jeongjun Park <aha310510@gmail.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:40=E2=80=AFAM Jeongjun Park  wrote:
>
>
> static void nilfs_set_de_type(struct nilfs_dir_entry *de, struct inode *i=
node)
> {
>         umode_t mode =3D inode->i_mode;
>
>         de->file_type =3D nilfs_type_by_mode[(mode & S_IFMT)>>S_SHIFT]; /=
/ oob
> }
>
>
>
> The size of the nilfs_type_by_mode array in the fs/nilfs2/dir.c file is d=
efined
> as "S_IFMT >> S_SHIFT", but the nilfs_set_de_type() function, which uses =
this array,
> specifies the index to read from the array in the same way as "(mode & S_=
IFMT) >> S_SHIFT".
>
> However, when the index is determined this way, an out-of-bounds (OOB) er=
ror occurs by referring
> to an index that is 1 larger than the array size when the condition "mode=
 & S_IFMT =3D=3D S_IFMT" is satisfied.
> Therefore, a patch to resize the nilfs_type_by_mode array should be appli=
ed to prevent OOB errors.
>
>
>
> Reported-and-tested-by: syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail=
com
> Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  fs/nilfs2/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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

Thank you for your prompt response and posting the patch.

A little formatting and tag editing is required, but it's okay.
I'll handle this patch.

Thanks,
Ryusuke Konishi

