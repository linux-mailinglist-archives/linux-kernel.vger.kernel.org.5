Return-Path: <linux-kernel+bounces-159934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A98B3679
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC51E1F2291B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F772145327;
	Fri, 26 Apr 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shecuw3k"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4413F01A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130728; cv=none; b=UHSgn3t02ZeyiCxxGlid6HE6DpNGIsbEOmpUT2i1b+omJ3jpt36ypJZ/a1SnTeD/pCzPRMRXLYbZkFfQ/OXYaUTX5TgpUj4DzLFvbNO3w5R07BGHYZVSbcSp4YyU4+jwm8ljTLPBXqcUc7C4CM6vpP/a0j6XEkxnC1LpGko4Eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130728; c=relaxed/simple;
	bh=oQQv8gNjBd3NOr0K9to+egvgpC4579uFTU3SS1qMrn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F46V0+f8PNBXCWYrFbK1jANjUfbVSbkBYJ1xqs4mY95Ibuf9HkmzC6dzjXyu1cMzzcJuO+851sCuJJAX9Fb5YjavMDzqTK321QvWZfOfgJamyvcFSCSSb3xacpCKBqaFh9gNV4dEtuyVAmX+XXQT6ZD6EneVe7Qz7RpYJAETMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Shecuw3k; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so1644503f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714130725; x=1714735525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/KkZVOHUjSvKFzby4LSjkn/O+aGICzD1xt5kzZkffs=;
        b=Shecuw3kOSR9rORsJI00L/A2UqeOJtU9122vLNtSC5JCEizmYjMC33iuhXYnfMzNgo
         iyHEimOcFjEGWebT3I5VPBoA2LETRErf23eC6lukKL3eODrvKJvS+EXN50TSH4+u5PnO
         g46dGMCQPDsij65gZiwljNhlAwVpjyE7jEuJWQZk3vWkltFolExy39Tmes03BketOv+y
         BdRZ/u/IAuVocAF2hVKiEZdpu4iZ6ogGSVe02d+zF7XNMe7ErxGYhMFtqam5ij8gTDn4
         6qvwKIkaHMkuxVCgla/t5mx+UhziPEEV5gWBL9IabwH9FNGm/GwtUJQojZlcWlKUF1fT
         Tzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714130725; x=1714735525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/KkZVOHUjSvKFzby4LSjkn/O+aGICzD1xt5kzZkffs=;
        b=U70RUBsTP7+Yw9ukninioUrBLZz4UPjhWky8KopzTsUoFXUMjw4ul5tEPDUZP2rTu7
         XeL5ohoMyB8BmXDCnUWub1YgLIU6CXNKdCTOP+W1rfp7jGZCSIQ+C1r1i4D1CLkmQw+1
         tnQmWxiY09WCh2I78TZ9Cr7W4zT+Qclx68LCfJNnVrqqsp8jHsskIT6lh9TuFqHBQiXY
         ds6eylQFduRZIEiXyxONx/eE4L0iOnnCw58Elzn1RYa2NaDZIDRBjTyCxyhAXr68n8Kb
         beh0mKq5BU4GNPr6o+DVFfa2KFYdh2nUF0lh1QAk6jJ18A7Ep99q9g/tC9aVd9RSqOrV
         d1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnIatxDA8O2y9jSz9RXeS2GbO7DXDkT9xziY9J65LFmA4MRhh5gERu77IWtf7qiQYA5wdFVcciwe4TaYjpBeI60anAVHfi5BDbonMB
X-Gm-Message-State: AOJu0YxwwG8slQc4tWOv3GSBXfxBOh19ljVlyL49hdUFDMrMFs2ikFDt
	swskMOXM6eTsbYGB1vPdEZd6RcYqVZ63m9oLkmaf8tsheaxsy2P+ARvmGIX0rc3mPZjfEhNtTt6
	nix19iwCzyja1cUiyNli9LRdScPdXjQ==
X-Google-Smtp-Source: AGHT+IFmuUcYbKho8+oCAuzCYhT5xSf0GYuCMoptOuX1QlBaPGQXvi7ZzpYyiYMeFgxOJH0DtuxDUr1rDCanCcD/iyo=
X-Received: by 2002:adf:9bd1:0:b0:34a:9be4:4674 with SMTP id
 e17-20020adf9bd1000000b0034a9be44674mr1517772wrc.8.1714130725203; Fri, 26 Apr
 2024 04:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416072108.5819-1-chao@kernel.org> <20240416072108.5819-2-chao@kernel.org>
 <CAHJ8P3J4Z7QJ=kpd_Nt+TGX2ZD8HH5YQWmbPsbS7+DeN2NrxyA@mail.gmail.com> <235d9db4-2ca5-4d7a-bd2a-36f98d1880a9@kernel.org>
In-Reply-To: <235d9db4-2ca5-4d7a-bd2a-36f98d1880a9@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 26 Apr 2024 19:25:14 +0800
Message-ID: <CAHJ8P3JD4KxSEz0mQF4+Mb8KvupLLwtj4F4ghPpePxTvr23vEg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: remove unnecessary block size check
 in init_f2fs_fs()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixed!

On Fri, Apr 26, 2024 at 5:37=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/4/16 19:12, Zhiguo Niu wrote:
> > On Tue, Apr 16, 2024 at 3:22=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> After commit d7e9a9037de2 ("f2fs: Support Block Size =3D=3D Page Size"=
),
> >> F2FS_BLKSIZE equals to PAGE_SIZE, remove unnecessary check condition.
> >>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>   fs/f2fs/super.c | 6 ------
> >>   1 file changed, 6 deletions(-)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 6d1e4fc629e2..32aa6d6fa871 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -4933,12 +4933,6 @@ static int __init init_f2fs_fs(void)
> >>   {
> >>          int err;
> >>
> >> -       if (PAGE_SIZE !=3D F2FS_BLKSIZE) {
> >> -               printk("F2FS not supported on PAGE_SIZE(%lu) !=3D BLOC=
K_SIZE(%lu)\n",
> >> -                               PAGE_SIZE, F2FS_BLKSIZE);
> >> -               return -EINVAL;
> >> -       }
> >> -
> >>          err =3D init_inodecache();
> >>          if (err)
> >>                  goto fail;
> > Dear Chao,
> >
> > Can you help modify the following  comment msg together with this patch=
?
> > They are also related to commit d7e9a9037de2 ("f2fs: Support Block
> > Size =3D=3D Page Size").
> > If you think there is a more suitable description, please help modify
> > it directly.
>
> Zhiguo,
>
> I missed to reply this, I guess you can update
> "f2fs: fix some ambiguous comments".
Dear Chao,
OK, I got it.
thanks!
>
> > thanks=EF=BC=81
> >
> > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> > index a357287..241e7b18 100644
> > --- a/include/linux/f2fs_fs.h
> > +++ b/include/linux/f2fs_fs.h
> > @@ -394,7 +394,8 @@ struct f2fs_nat_block {
> >
> >   /*
> >    * F2FS uses 4 bytes to represent block address. As a result, support=
ed size of
> > - * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
> > + * disk is 16 TB for a 4K page size and 64 TB for a 16K page size and =
it equals
>
> disk is 16 TB for 4K size block and 64 TB for 16K size block and it equal=
s
> to (1 << 32) / 512 segments.
>
> #define F2FS_MAX_SEGMENT                ((1 << 32) / 512)
>
> Thanks,
>
> > + * to 16 * 1024 * 1024 / 2 segments.
> >    */
> >   #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
> >
> > @@ -424,8 +425,10 @@ struct f2fs_sit_block {
> >   /*
> >    * For segment summary
> >    *
> > - * One summary block contains exactly 512 summary entries, which repre=
sents
> > - * exactly one segment by default. Not allow to change the basic units=
.
> > + * One summary block with 4KB size contains exactly 512 summary entrie=
s, which
> > + * represents exactly one segment with 2MB size.
> > + * Similarly, in the case of 16k block size, it represents one
> > segment with 8MB size.
> > + * Not allow to change the basic units.
> >    *
> >    * NOTE: For initializing fields, you must use set_summary
> >    *
> > @@ -556,6 +559,7 @@ struct f2fs_summary_block {
> >
> >   /*
> >    * space utilization of regular dentry and inline dentry (w/o extra
> > reservation)
> > + * when block size is 4KB.
> >
> >
> >
> >> --
> >> 2.40.1
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

