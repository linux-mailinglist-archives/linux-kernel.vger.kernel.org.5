Return-Path: <linux-kernel+bounces-25063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6782C71B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B49B2464A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C552817731;
	Fri, 12 Jan 2024 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOpkDo2p"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA617727
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cd03e3f8a3so2000387241.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705097985; x=1705702785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e/2OkUvS339Il58Bmr0PaHeMM9UBP4jRux2aDWKwj0=;
        b=lOpkDo2pdGaeYDqU4ZUqz6eEKM+3hfmNJR0+LEPyCd8zvQbHEmJOUXb1K2JeKZRoaL
         IpZY6FyYmWFLMZK4icFFFlNR9pikus/yThbgoM/Hf/YtjGjVFnMFwHP/fLtYVAGoLG5T
         jBDcINmTDA38sGu6f3ipvM+Y5h5wpNI4wDqi9O1Uo+mnpsCotcrYOeL7UCvtKERsIQIj
         WopnqkI8vlMPSq5CTcnoRlU8z9XDZ8mWv7npyGI8ZbHsGnjgMhhH67RdpGfkci9CS3fb
         Z7lJumJJ7MNlkrPspOAm3oIn8TP0gj4pKT+Tv2YH/pT5RgEJ/ij+UTjH2kSK+dPWp/By
         9HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097985; x=1705702785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7e/2OkUvS339Il58Bmr0PaHeMM9UBP4jRux2aDWKwj0=;
        b=XtfeztOnPV2co+FCUjSF7tuziAifrd8/XeVcqDouJpzrywuVia+WOC+SHbBSUtydga
         U7A0P+++oP4cxFubRxrMKcMlsfyLJHJwvi3ILb4KZ3PnwcqJ9j1J8PYFKNSwNxB9cOqe
         4Dg52htD2UErknkH73+ruCJRd4C1xU0SdPG1tfwf6SCAqub4MdAbISIs4uQmprxhmCGC
         JdWHQjhz1DfH+zI1roBHQSia2UV6pdJBUhILn/94iz8mLEsEJda4UvEE5fp/CfKNsmPN
         qax0Bn2yK+oXRJX+H/LgZvQxWNOODTWzz2xDtm+KzZg35wFFEWSjgt2YM4xQN/fJECOt
         jHCw==
X-Gm-Message-State: AOJu0YxPrz0IQ5WDcvoA+RJFtpfwdmze5SGHvac3HsH6EaRx0r54vvIB
	Ko7OvebQB6W+U8SDAHqTUcU+kioKmhGM29npiok=
X-Google-Smtp-Source: AGHT+IHbAIFmhodUFQ/mXl1kZldMTqJsd1oG8vONsS6msMLHUD2sLD4jVDfIFtfTXhcwfngf7f1LWSE8CEi3qClYBXQ=
X-Received: by 2002:a05:6122:2191:b0:4b6:d4c8:9caa with SMTP id
 j17-20020a056122219100b004b6d4c89caamr2254783vkd.21.1705097985517; Fri, 12
 Jan 2024 14:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143152.1543509-1-chao@kernel.org> <20231228143152.1543509-3-chao@kernel.org>
 <CACOAw_xCfOtJaC3FbOhvbrEzyUwecdSujFo4-f--dz+33BC+Sg@mail.gmail.com>
 <e7f4a835-6a4c-4f94-a79f-a425b04516e2@kernel.org> <CACOAw_wzBTV=+cqZeiCZvhud1Ek06aW_5nJbg=9FF327MNgxEg@mail.gmail.com>
 <d2f2e4ba-8668-4e37-a56f-dbe7c730b01f@kernel.org>
In-Reply-To: <d2f2e4ba-8668-4e37-a56f-dbe7c730b01f@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 12 Jan 2024 14:19:34 -0800
Message-ID: <CACOAw_xLFQchVKde8dH5EooqrUq8J1pftDYFJ-Ur6KaqXL_dfQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 3/6] f2fs: compress: fix to check unreleased
 compressed cluster
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 5:06=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/1/12 1:15, Daeho Jeong wrote:
> > On Wed, Jan 10, 2024 at 5:33=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/1/11 9:18, Daeho Jeong wrote:
> >>> On Thu, Dec 28, 2023 at 6:33=E2=80=AFAM Chao Yu <chao@kernel.org> wro=
te:
> >>>>
> >>>> From: Sheng Yong <shengyong@oppo.com>
> >>>>
> >>>> Compressed cluster may not be released due to we can fail in
> >>>> release_compress_blocks(), fix to handle reserved compressed
> >>>> cluster correctly in reserve_compress_blocks().
> >>>>
> >>>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> >>>> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> >>>> Signed-off-by: Chao Yu <chao@kernel.org>
> >>>> ---
> >>>>    fs/f2fs/file.c | 12 ++++++++++++
> >>>>    1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>> index 026d05a7edd8..782ae3be48f6 100644
> >>>> --- a/fs/f2fs/file.c
> >>>> +++ b/fs/f2fs/file.c
> >>>> @@ -3624,6 +3624,15 @@ static int reserve_compress_blocks(struct dno=
de_of_data *dn, pgoff_t count)
> >>>>                                   goto next;
> >>>>                           }
> >>>>
> >>>> +                       /*
> >>>> +                        * compressed cluster was not released due t=
o
> >>>> +                        * it fails in release_compress_blocks().
> >>>> +                        */
> >>>> +                       if (blkaddr =3D=3D NEW_ADDR) {
> >>>> +                               compr_blocks++;
> >>>> +                               continue;
> >>>> +                       }
> >>>> +
> >>>>                           if (__is_valid_data_blkaddr(blkaddr)) {
> >>>>                                   compr_blocks++;
> >>>>                                   continue;
> >>>
> >>> How about merging two conditions like "blkaddr =3D=3D NEW_ADDR ||
> >>> __is_valid_data_blkaddr(blkaddr)"?
> >>
> >> Oh, sure.
> >>
> >>>
> >>>> @@ -3633,6 +3642,9 @@ static int reserve_compress_blocks(struct dnod=
e_of_data *dn, pgoff_t count)
> >>>>                   }
> >>>>
> >>>>                   reserved =3D cluster_size - compr_blocks;
> >>>> +               if (!reserved)
> >>>> +                       goto next;
> >>>> +
> >>>
> >>> How can the reserved variable be zero?
> >>
> >> I guess it can happen if a cluster was not released during
> >> release_compress_blocks(), then all blocks in the cluster should
> >> has been reserved, so, in this round of reserving, it needs to skip
> >> reserve blocks, right?
> >
> > Let's assume cluster_size is 4. How can compr_blocks be 4?
> >
> >                          if (i =3D=3D 0) {
> >                                  if (blkaddr =3D=3D COMPRESS_ADDR)
> >                                          continue;
> >                                  dn->ofs_in_node +=3D cluster_size;
> >                                  goto next;
> >                          }
> >
> > We skip the block having COMPRESS_ADDR when counting compr_blocks.
> > So, the maximum value of compr_blocks should be 3, right?
>
> Ah, got it, and I think you're right.
>
> Should fix the condition as below?
>
>                 /* for the case all blocks in cluster were reserved */
>                 if (reserved =3D=3D 1)
>                         goto next;

It looks good to me.

>
> Thanks,
>
> >
> >>
> >> Thanks,
> >>
> >>>
> >>>>                   ret =3D inc_valid_block_count(sbi, dn->inode, &res=
erved);
> >>>>                   if (ret)
> >>>>                           return ret;
> >>>> --
> >>>> 2.40.1
> >>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> Linux-f2fs-devel mailing list
> >>>> Linux-f2fs-devel@lists.sourceforge.net
> >>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

