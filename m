Return-Path: <linux-kernel+bounces-117810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32188AFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D687E1F3F593
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B161BDD3;
	Mon, 25 Mar 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5+SDgIZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7C17579;
	Mon, 25 Mar 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394613; cv=none; b=n9BqnlSbeU/qhJfjH/VMui8n+fMwi2IN1R0i2Tyfx58V2PcHQA0tmykiBOksUaR0da2o7c2rrjtaK9S0zfNTRwLeKxJaYEaYWAW3+LufRQO4d2BEQ29BlgrSLfqxI83XkoFQ6bx5qbHMNIUGRJZrloFHkd2N8vXp81B3mkGEq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394613; c=relaxed/simple;
	bh=nAX1g5FAYeM8f4OsLvQyu5nop1FxLK7T4/S5kb/qsjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMV8vI9iH7DZ3tRc65jspdp6yGqEZLuENMxCNdvjpqcj4DWg2BnlcdsEo5nK4JEyDrC0zKpufwh4A7wA42GWG+O4zYjRYTMyhogTJL7Sz8tRjOwPH/JDLnQ7gV4rkp1j3b50Eqlcmt2px42Ym00LyALv3zk/DZKT/HtvblN7vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5+SDgIZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512e4f4e463so5100460e87.1;
        Mon, 25 Mar 2024 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711394610; x=1711999410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8aQL/Qh+/g6MnD8suhJB3IMrCXrJXRjBKFx//tw32U=;
        b=d5+SDgIZcJcmZW/1SQsc6plNPhxjx6yYpjsuY4IdJcy/OTwpKaQBo4yw2gXgsVB3PX
         jlp1UhI23eW7cwGDh5TKdHg00hRhb1rJtX+9zGToAKdv0j4k/fbzi49Si1FYA7v2sCjh
         i/yDBiefJDgOglz6gYyye9QbftShPbeEbqT/ukM8KWdxVrQZue6gttKbYtYMA/wlTgf1
         NXeE5smvOAI4QbH/MEQ9SXUk5WcxNFTl61Y2kmBhksjW9JDiZo6vT90xlkjDm4tpDHEI
         MdVyvcoRwtWlyhBw7nRyIfPUZFWCHPe4X9k2dN7Xhg/xEVIeMOVKh8ZKMTn/fm1I9omD
         x4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394610; x=1711999410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8aQL/Qh+/g6MnD8suhJB3IMrCXrJXRjBKFx//tw32U=;
        b=KXcNnTNJUG31pMJZDmgIGEYu3EmA62SJ6pRek8jxweknJLVpcE4ioDhpVOVnyY8gA0
         zRNQfYIK8vA1Sru1Fvo7XaIRdX3bHCJd0J4eqnkPS6FRxMo/XjU0XMZioQbEzNiuxN4r
         U9FeRcAI0HeqD+EIqp2CluY/t2Mi32lTf7Bb1c4VroSFSoMqSAB7PbNSt+yR6IH9040J
         bMBOub92yuZNw53K+7Rf7Xky1lylSEMFrFnaRlgx+EIIOps9rk7zr6VsrxyNclkcM3Zv
         OMjOoOwf+z+LuTQtckVQb+uTNpHLoBRH14WS8gjaKK3g1CarjHpccywCHowY1DxhRwTP
         VHZw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Zfs5/iSEOjKDSYRvAzHa6S+HgmkvsLZwEyfjS2n32FldEQlrKhPP9XUldNwG5rDQcogga9e+1yoG9wyYyRqP//sRgPiDYz23JAS2JSHdiipcpwqYJKSsN1Ht6YzowAdL
X-Gm-Message-State: AOJu0Yxc+q5PF7/XLmsQ3gX5RwtIlHR//F+3hAjDs5SdK4mw79OhjlNk
	L+y2auy9T2tiDTdRAZ3mBYZGq+6OuIEGDungkrtiTtrGazI2oRqfYmclIV4lt2jZ5qQ7Z8oSu9+
	vyjLmr2C4xG81WltIvppsdccUz/0=
X-Google-Smtp-Source: AGHT+IF1vk0UqW4liOGXjTqYiEBinsMXHGgEH6imFqIZGuouD3c8EayVtDMaf81Q2NsKzMpYNbz0b49BjVvEX9PL1hQ=
X-Received: by 2002:ac2:5df0:0:b0:513:d5bb:3017 with SMTP id
 z16-20020ac25df0000000b00513d5bb3017mr568024lfq.36.1711394609647; Mon, 25 Mar
 2024 12:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325155434.65589-1-puranjay12@gmail.com> <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud> <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
 <20240325-perpetual-liking-25f26e485b65@spud>
In-Reply-To: <20240325-perpetual-liking-25f26e485b65@spud>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 25 Mar 2024 20:23:18 +0100
Message-ID: <CANk7y0jtURUC6PWx5nSDigMpScUT+p3qd=hTtqJkCqAN+Nq32A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf,riscv: Implement bpf_addr_space_cast instruction
To: Conor Dooley <conor@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 8:19=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Mar 25, 2024 at 08:13:10PM +0100, Puranjay Mohan wrote:
> > On Mon, Mar 25, 2024 at 8:10=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Mon, Mar 25, 2024 at 03:54:34PM +0000, Puranjay Mohan wrote:
> > > > LLVM generates bpf_addr_space_cast instruction while translating
> > > > pointers between native (zero) address space and
> > > > __attribute__((address_space(N))). The addr_space=3D0 is reserved a=
s
> > > > bpf_arena address space.
> > > >
> > > > rY =3D addr_space_cast(rX, 0, 1) is processed by the verifier and
> > > > converted to normal 32-bit move: wX =3D wY
> > > >
> > > > rY =3D addr_space_cast(rX, 1, 0) has to be converted by JIT.
> > > >
> > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > >
> > > Doesn't compile for allmodconfig:
> > >   ../arch/riscv/net/bpf_jit_comp64.c:1086:7: error: call to undeclare=
d function 'insn_is_cast_user'; ISO C99 and later do not support implicit f=
unction declarations [-Wimplicit-function-declaration]
> > >
> > > Cheers,
> > > Conor.
> >
> > Yes,
> > I mentioned in the cover letter that a patch is required.
> > It just got merged in bpf-next/master:
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit=
/?id=3D770546ae9f4c1ae1ebcaf0874f0dd9631d77ec97
> >
> > So, rebasing on the latest bpf-next/master should fix the issue.
>
> Ah, I see now that there was a mention in the cover letter that I did
> not see first time around.
>
> Bjorn, do you think there's anything we can do about these kinda
> misleading CI failures for bpf stuff? Some stuff that touches bpf
> definitely is worth us building, but should we try and build it on top
> of the bpf tree instead?

Is there a separate CI for RISCV related stuff? is it public?

I would be interested in adding RISC-V support in
https://github.com/kernel-patches/bpf
Is someone already working on this?

