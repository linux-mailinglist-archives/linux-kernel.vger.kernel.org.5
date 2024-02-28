Return-Path: <linux-kernel+bounces-84487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B124586A750
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680921F2C99F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46020327;
	Wed, 28 Feb 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDY73s4k"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E159E2030F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092060; cv=none; b=QNRy1GvqsssaS/oRa3AylIJgMQsRw5WfQjv5YmFy616Y1B7+ncLvLpV0mGPU1ycI53ND5okczvekwmLcs2WNZMfodBd4x6HbDlejug/xQ+1/9ba5XENyEuPwPe6i9Isv8y7tPoru6Pwov1yqWE3lBTxqU2F9gYFzorg1LWyy4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092060; c=relaxed/simple;
	bh=hNd1sEyWTTY5ZxqPlN2W7+wtXuPmALSQyS5Oy6bqxsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G113WyO9V5XNP9DL3/S+x80LwxPsQyJ0oSKV04nH8NMf2weNA3ADIx6VS0SHJ5sUNrIcsqSMGouCPk4sBzydXZ0QF+jhUdrfcsOxxDPDX355FbMFGqyZRn+4QJSmqyALNNb1xDTwUpAH4jskpxU7SFOyI/3HPEZUeY4WtE228kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDY73s4k; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7da6e0fc90eso253009241.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709092057; x=1709696857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QnH1oJZ3yFoqGeTtQaz7Mg98UaDYu9X6FwsvJH2uCg=;
        b=jDY73s4kbsVAWkbZDQ6ZgnCVLqevlTW5+yYEA2GoQLTaOkFMe7JJ9GWy4GDDhWhnmk
         HSmcNNuhLVKASLfy5tIYBfntosmJyvwIEKnqv5SZfsQHVynzJPRpBATYghG8iYwXxfUC
         Z8rCQbNdbFwqQvqTEWbBeDpNNVUGTg2RtbRe/mtUQAGlUKR1LJW9OezLUtkhrM/yXsmo
         APkbE8pJXObD68iD0sJZt6n0jzTV9u26E8rjGiBIhATFxpilqNNIIp0fG0mswcwgkVe4
         lDGuaSCzgxMqm8uUa2MAD4a42xc4DeByGpEJE/rmPwcLMlK6SAIuEL6l3fkvC4WLOFnw
         6mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709092057; x=1709696857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QnH1oJZ3yFoqGeTtQaz7Mg98UaDYu9X6FwsvJH2uCg=;
        b=HyYK4wOgJfUJ3+xmxHGTZPUErG1RH6w9y66KJf8mPbcBfvdmg3ogsYBVu+lkg9mou2
         UCDwvrVT29vWOM8Mv57S5Lp4vWZeTVv3HlnrS9CiAZspxPFTiyVL7HoR3lNibgQ1X/lz
         KAh6c7seFoEqDZdbJEuQKnDb6n0e2P/6PEn5sFvVznFkRQkhdxfHDfJRTPBYl3u2+hng
         K5R+mkKKalZRikHAIriXQiznUCmDTmtNa8heQSbi/63yKj8l71KDwrYs9QvqpbaYsApZ
         pM5AXoHgIBzQajnMDt8d6EsOiXXXyL/JneN4gDh0903Eo1t6T5EPHtSOHQ/6cuBEbaDs
         F53w==
X-Gm-Message-State: AOJu0YzbXDiGBVbhKWBSBs/GPccehjLYZD9YWCPU4JwGdSNl8MeZpc4z
	PMYdiQsgQN1vMrqCRIH1MwnfmOWyYh56aBYmg4+4uQ77ULxg7zk8Y94GeAqfCRMt+ywRO9XVQh1
	z3WJD9oHG4brcdUa6uCkMjnt2r2OU0gmYDag=
X-Google-Smtp-Source: AGHT+IGfLX2EZzehjczg/V4rHJkkVz/cAZAB4YX34jxqN/1Owyl+Nblq+rWJobsxdyU2j0JF2yBfefhXMBTXuIQSrkQ=
X-Received: by 2002:a1f:6201:0:b0:4c8:a2c6:c2be with SMTP id
 w1-20020a1f6201000000b004c8a2c6c2bemr1046000vkb.8.1709092057664; Tue, 27 Feb
 2024 19:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223205535.307307-1-jaegeuk@kernel.org> <20240223205535.307307-5-jaegeuk@kernel.org>
 <CACOAw_xdBY5Rg1J4jUTaH0UxVrdZ+CCVQj72q_cMxyCHuCTy_Q@mail.gmail.com> <Zd0VBo3ilwRq4BJy@google.com>
In-Reply-To: <Zd0VBo3ilwRq4BJy@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 27 Feb 2024 19:47:26 -0800
Message-ID: <CACOAw_z+ouZ1Pv0P=LPiwbOKFaBYO-8OKNsU7b62MLwi=Qp4wA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: allow to mount if cap is 100
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 2:47=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 02/26, Daeho Jeong wrote:
> > On Fri, Feb 23, 2024 at 12:56=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.or=
g> wrote:
> > >
> > > Don't block mounting the partition, if cap is 100%.
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/segment.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 6d586ae8b55f..f11361152d2a 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -904,6 +904,9 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sb=
i, block_t unusable)
> > >  {
> > >         int ovp_hole_segs =3D
> > >                 (overprovision_segments(sbi) - reserved_segments(sbi)=
);
> > > +
> > > +       if (F2FS_OPTION(sbi).unusable_cap_perc =3D=3D 100)
> > > +               return 0;
> >
> > With this, f2fs will not execute GC. What is this 100
> > unusable_cap_perc used for?
>
> Theoritically, it won't, but I was hitting a GC loop, and I suspected a w=
rong
> section/segment layout. So, I posted the below, and guess we need this pa=
tch
> as workaround.
>
> https://patchwork.kernel.org/project/f2fs/patch/20240224011411.3820719-1-=
jaegeuk@kernel.org/

Reviewed-by: Daeho Jeong <daehojeong@google.com>

>
> >
> > >         if (unusable > F2FS_OPTION(sbi).unusable_cap)
> > >                 return -EAGAIN;
> > >         if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
> > > --
> > > 2.44.0.rc0.258.g7320e95886-goog
> > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

