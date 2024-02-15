Return-Path: <linux-kernel+bounces-67659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FF856EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8509B211E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20A13B29D;
	Thu, 15 Feb 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4ejrwaK"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D613AA42
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029560; cv=none; b=r2PhMQC19UH5+hdAx1dNouGW1nx1nlg9K76OQvBTxCINmCjCqQDzkqL4dYwtySg/MO8wukR1XwQ+f1h+h2i5C6EM2vAY4dsdGv9eEnCkxbZfDDjO6WbsSnNf0Y5i2FNEdoKXaZtvjCHfrV7HYcarzx4ZN+jIOuuTOx2GU0k+W5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029560; c=relaxed/simple;
	bh=oZB9UxxjYJZ4A86GMlPL+c0aJyRyUWLlESSlMqLoAac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogu+o6YHkIUr91QBeIPwAwKVL6kbVv2BPO+zK0wc5Hm3o2vWJMGDwPt2aq8EAcvl6vrV6HkKw69eodOJiLVt7V7HuZadCz/q9Q71IxbST4TSxvbuHc3B+CX1VEOlsl7LtkvN6/2fmxnjctTLdF/lAPY5CA9mQWzZTwJlirEG2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4ejrwaK; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c02dfa01a8so411534e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708029558; x=1708634358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP8/sXQUg6d+/tAlWscHgJtEUS3CFlZkJ/dGjgcRmF8=;
        b=f4ejrwaKwRqg7Z5vpUG5eZGZKqz4rZt8PbISZNcAjaTyOJMRoGwib8qO/PLSKxyl7G
         YdZJR6yo1s02r65Kb0jv6NnaFI6jxw7g82MDPmO6IKlovqu443E5MBCLErBjSLbzgujt
         191zPt6AYiPtVbFUqC3O3YB1K2PeV+EKYAQnbr+m7LlvKbOKDkD7CRXTr1NetfTO1f8W
         tDU9ENPbthhxQ0QjXb02wiXMNgy1SYpQP3NGjdVpvF8BvyCZSiMybN6leWcNLs4st+Re
         EYjpMRiT7k4OTwFd1cUODf6toyJj4mvIJSmU1QIOi4uYTrRlZNBOj5xHJ260K6UstG3v
         PFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029558; x=1708634358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP8/sXQUg6d+/tAlWscHgJtEUS3CFlZkJ/dGjgcRmF8=;
        b=DzrvgIOCrmnzhrw7qA4Usyx958T4hGV/3JPYlipJvAuaeynUkGkAfbwqi/vDtXT8RJ
         CHf1YT2s7vNgvYZur0SGILyWNFTpcDpAqLpSvpqedkEbpvOg3a3hvP3LNiNSn+hmVSiv
         4ZtsISBBERm1XVyW/r+WwJULk9JdZYLEqxWGtx1y1z9nzEbIkMoxQNcaDCNKnsL3bbRo
         NSulEnaS7yfzYTZxvFgXwegrB18wyooz3Uv9YqFlsH8RhzYAXTAqWfhh3FtilvK0Qv/c
         PQjCFfciTrFrEuXYq/TiGenT45FVt65y9hpAp9SEWC9ObSFMLADB8cJBhb61ihVhj44p
         NZSg==
X-Gm-Message-State: AOJu0YyFNPhhyZ9tODohYh1MVLWwHzAE2gprDkWhI4sb005AyBPNBpbf
	7X0Q6VkJ/PYojoEN4+4ytpuwy554PZtP9AWVfC/cmmxPdSGwLlwP4OD0QsJpJDj/8X/Fvfg+B7h
	NFXy8yG49VSe1NhlFQKTXqRsjc6Q=
X-Google-Smtp-Source: AGHT+IGZeFq7SGMN9pvV+zTmQwR7jHhUTJ7ig1DtH3MAruI0U2O4Ew2wALWOgV5FjRM6w/Nx6JO01FVY6D241zI5kaw=
X-Received: by 2002:a1f:dd04:0:b0:4c0:309b:2755 with SMTP id
 u4-20020a1fdd04000000b004c0309b2755mr2533048vkg.3.1708029557760; Thu, 15 Feb
 2024 12:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215201053.2364270-1-daeho43@gmail.com> <Zc51zeFF3DrUXMem@google.com>
In-Reply-To: <Zc51zeFF3DrUXMem@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 15 Feb 2024 12:39:06 -0800
Message-ID: <CACOAw_z99UEofyh2PjRe8UfaqGBxwaGd392jHN42JM-bzLZnHw@mail.gmail.com>
Subject: Re: [PATCH] f2fs_io: add lseek command to execute lseek()
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 12:36=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> w=
rote:
>
> On 02/15, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added lseek command to support lseek() for SEEK_DATA and SEEK_HOLE.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  tools/f2fs_io/f2fs_io.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> > index e7d286a..b5c5b97 100644
> > --- a/tools/f2fs_io/f2fs_io.c
> > +++ b/tools/f2fs_io/f2fs_io.c
> > @@ -1630,6 +1630,43 @@ static void do_removexattr(int argc, char **argv=
, const struct cmd_desc *cmd)
> >       exit(0);
> >  }
> >
> > +#define lseek_desc "do lseek for SEEK_DATA or SEEK_HOLE for a file"
> > +#define lseek_help                                   \
> > +"f2fs_io lseek [whence] [offset] [file_path]\n\n"    \
> > +"Do lseek file data in file_path\n"                  \
> > +"whence can be\n"                                    \
>
> Can we also have all the other options as well?

Sounds good.

>
> > +"  data     : SEEK_DATA, return the file offset to the next data locat=
ion from offset\n"\
> > +"  hole     : SEEK_HOLE, return the file offset to the next hole from =
offset\n"
> > +
> > +static void do_lseek(int argc, char **argv, const struct cmd_desc *cmd=
)
> > +{
> > +     int fd, whence;
> > +     off_t offset, ret;
> > +
> > +     if (argc !=3D 4) {
> > +             fputs("Excess arguments\n\n", stderr);
> > +             fputs(cmd->cmd_help, stderr);
> > +             exit(1);
> > +     }
> > +
> > +     offset =3D atoi(argv[2]);
> > +
> > +     if (!strcmp(argv[1], "data"))
> > +             whence =3D SEEK_DATA;
> > +     else if (!strcmp(argv[1], "hole"))
> > +             whence =3D SEEK_HOLE;
> > +     else
> > +             die("Wrong whence type");
> > +
> > +     fd =3D xopen(argv[3], O_RDONLY, 0);
> > +
> > +     ret =3D lseek(fd, offset, whence);
> > +     if (ret < 0)
> > +             die_errno("lseek failed");
> > +     printf("returned offset=3D%ld\n", ret);
> > +     exit(0);
> > +}
> > +
> >  #define CMD_HIDDEN   0x0001
> >  #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
> >  #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
> > @@ -1671,6 +1708,7 @@ const struct cmd_desc cmd_list[] =3D {
> >       CMD(listxattr),
> >       CMD(setxattr),
> >       CMD(removexattr),
> > +     CMD(lseek),
> >       { NULL, NULL, NULL, NULL, 0 }
> >  };
> >
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

