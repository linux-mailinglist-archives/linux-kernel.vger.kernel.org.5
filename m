Return-Path: <linux-kernel+bounces-23913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584D82B3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC388B20ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B051C46;
	Thu, 11 Jan 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLjM/OuB"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC351036
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4affeacaff9so975972e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704993351; x=1705598151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPxIBj0Nu8xEORuneqUuWH8O+j39UTrFRFHSau6xBbI=;
        b=QLjM/OuBT/qQBcgbLwvc41ffp1Z7Dyy5KrAipIHHcSpqkLiLcOOmRsPn/2Yecj7emo
         /+0koyoHvvxIPbQdSCVjhYM0L+9u0YpCbV5bWjC0rkKL2W5AkVLoYwTAhkCimH6QxkZi
         g2CHKfDQkO7Iulee2UYeW34AETvMNBKTV3/mqD5vdsT8qfinEdZLoVmyd0EvcJHEDnZ2
         agL2c3wRX5YIc/EpS5Z6Bf0MzI8GIul219U0dKQP1zVNsCrVN84BufEEICJb22x6s6XY
         SWKUdTM5UHKVHW0Y0q65rT8ICi02IdGUaPOTJb9AExY1oPS7OkX5R34oS8q6ou6VGoju
         gYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993351; x=1705598151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPxIBj0Nu8xEORuneqUuWH8O+j39UTrFRFHSau6xBbI=;
        b=JfC9iQfpCft2KbBxmKIFtRXNbNEerV9nTK8vsJnVbC0Aa1+2y0xtZxQK53LZDr5aVL
         j89eRa0Ti8ZyJLFzBX5zDGWsgn620I5o8f0NpAPVUEmyXpNmd3Ey6ZnDgL2wQCY10uY0
         EtGVNkiGP/ue2xMfBmdK52PknDDaUAmpszjrUIF1uzQxaMHFTN9mQv6NAhVy6KSUchKd
         2swKv/arTeFJApzrpzhVDapW8N1KxZla7vMbh+ESGduovAbWrwiiQ6VLY9TIBGhDhFd6
         uZt/y54waYB849e7JqAkA/M1hPPAf8yHaR/H3vErOmt7lxBG74tCQ3IwWSnCASSbfO6f
         GYTQ==
X-Gm-Message-State: AOJu0YxsALtD6LRQ3vyv0pLd3G8Jwo42pjrye5B1QJLVIXk96ASHkHdr
	+eh+pBWBwbFH6C+xZL0uImRtWlLKHyz/8R23zu8=
X-Google-Smtp-Source: AGHT+IGurpmaylu9PZFv0zDQOHwhHDlIYEEcR/qQFEaRbIGo8/ll684CFOtOfEk1QCAf2HWCJe9UvxixgjNZyEYBNao=
X-Received: by 2002:a05:6122:4a19:b0:4b6:dbfd:f89b with SMTP id
 ez25-20020a0561224a1900b004b6dbfdf89bmr202402vkb.27.1704993351400; Thu, 11
 Jan 2024 09:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228143152.1543509-1-chao@kernel.org> <20231228143152.1543509-3-chao@kernel.org>
 <CACOAw_xCfOtJaC3FbOhvbrEzyUwecdSujFo4-f--dz+33BC+Sg@mail.gmail.com> <e7f4a835-6a4c-4f94-a79f-a425b04516e2@kernel.org>
In-Reply-To: <e7f4a835-6a4c-4f94-a79f-a425b04516e2@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 11 Jan 2024 09:15:40 -0800
Message-ID: <CACOAw_wzBTV=+cqZeiCZvhud1Ek06aW_5nJbg=9FF327MNgxEg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 3/6] f2fs: compress: fix to check unreleased
 compressed cluster
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 5:33=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/1/11 9:18, Daeho Jeong wrote:
> > On Thu, Dec 28, 2023 at 6:33=E2=80=AFAM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> From: Sheng Yong <shengyong@oppo.com>
> >>
> >> Compressed cluster may not be released due to we can fail in
> >> release_compress_blocks(), fix to handle reserved compressed
> >> cluster correctly in reserve_compress_blocks().
> >>
> >> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> >> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>   fs/f2fs/file.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 026d05a7edd8..782ae3be48f6 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -3624,6 +3624,15 @@ static int reserve_compress_blocks(struct dnode=
_of_data *dn, pgoff_t count)
> >>                                  goto next;
> >>                          }
> >>
> >> +                       /*
> >> +                        * compressed cluster was not released due to
> >> +                        * it fails in release_compress_blocks().
> >> +                        */
> >> +                       if (blkaddr =3D=3D NEW_ADDR) {
> >> +                               compr_blocks++;
> >> +                               continue;
> >> +                       }
> >> +
> >>                          if (__is_valid_data_blkaddr(blkaddr)) {
> >>                                  compr_blocks++;
> >>                                  continue;
> >
> > How about merging two conditions like "blkaddr =3D=3D NEW_ADDR ||
> > __is_valid_data_blkaddr(blkaddr)"?
>
> Oh, sure.
>
> >
> >> @@ -3633,6 +3642,9 @@ static int reserve_compress_blocks(struct dnode_=
of_data *dn, pgoff_t count)
> >>                  }
> >>
> >>                  reserved =3D cluster_size - compr_blocks;
> >> +               if (!reserved)
> >> +                       goto next;
> >> +
> >
> > How can the reserved variable be zero?
>
> I guess it can happen if a cluster was not released during
> release_compress_blocks(), then all blocks in the cluster should
> has been reserved, so, in this round of reserving, it needs to skip
> reserve blocks, right?

Let's assume cluster_size is 4. How can compr_blocks be 4?

                        if (i =3D=3D 0) {
                                if (blkaddr =3D=3D COMPRESS_ADDR)
                                        continue;
                                dn->ofs_in_node +=3D cluster_size;
                                goto next;
                        }

We skip the block having COMPRESS_ADDR when counting compr_blocks.
So, the maximum value of compr_blocks should be 3, right?

>
> Thanks,
>
> >
> >>                  ret =3D inc_valid_block_count(sbi, dn->inode, &reserv=
ed);
> >>                  if (ret)
> >>                          return ret;
> >> --
> >> 2.40.1
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

