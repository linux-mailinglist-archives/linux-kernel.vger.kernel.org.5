Return-Path: <linux-kernel+bounces-117783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516B88AF86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DE63050ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856F175B7;
	Mon, 25 Mar 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUW1fZJq"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3213FF5;
	Mon, 25 Mar 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394005; cv=none; b=qZHK6lIAOQ+G/RtPzGLg4o5+fs5ZpNeI6xb3Ffw+vc4zH+yT3lM3ZeweR0ejsYwYtnzt6pxFmaZF3IsSkO6UinTVDsm33XQdqWgzwkqkLCFNU8AV+S01+3kfc48eWN2o4B2RiTiCcziUyDWjNaUIyFB/1gHlKl/tbewbUzBmKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394005; c=relaxed/simple;
	bh=mHd8yBTq95tlBMjpkzBSblmDNN2ufxBHwGLG6XPFLiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbKq7+3y2ICO78wdBBi0aNaFJ9NQnkNCNqMJnCFZdo5V16ifFP5/5HONO3AXyOwKmAZR92DWuVPDuWsDufQrumgPL2o/SaVQ/LYOhyLB2iUjs8MHTmgzJbZgGtD6vvJ9UNXEjrj8tM1e3Qj/+36oX3rMGoCYCjKF0qhEz6cOzak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUW1fZJq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51588f70d2dso5512991e87.3;
        Mon, 25 Mar 2024 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711394002; x=1711998802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgBGkwDpvy+zR/EPv0TXmjkYIf1V+bfMcLLs2S2pnX0=;
        b=bUW1fZJqFD2ZHHJh2qZt1OFvYdccfTWAzoi5sLu2LO+Z5gJSJ7b7u8eBeD67t4UvGd
         FNi5Xlmid+Nx6DHbPEFkGZn+M5EdFU0NwO/0IbjytdUvA0qhkh4mrTbBsz0TulC7Lu07
         RX9quaUkVniaiR4u0PWeJzvHyXph4JmL2Cawl2zcOEwu4lCoeRGHKipZzuMq1MuJRscy
         cDJkt8MuuuILNElnir70/GCadaqrQhaauw2+dkCP0HsVfgxxrWPAemCzWqhzokNojjxM
         74Bocq5dZSi8zPY/HosRK4EOLGJ5YyhdqQMNGjQjwHRRmutqWLo9zbBt9/+DVhZGY1xT
         jv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394002; x=1711998802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgBGkwDpvy+zR/EPv0TXmjkYIf1V+bfMcLLs2S2pnX0=;
        b=OU0xMAzbJgpVa121ecj5Wby2VASYIZgYjftqK3dCmw3o3vGYmBRCRRVxmFzm22JirB
         a/STMEjd1uW3AT9VCl8zukvjLeJUh/unNiOgwdnRPJH3wj9/ejlkb+LCQqnf6TT/aBqT
         LmS+ExTcmsauyNy8Glu3R/V97yRbG1XmmlO2zChF0KRXJ1CB4TEvnW30bPzdv4iHxyGp
         IDjD0QDMEqvirdscrfHxYZhZo0m23TSlUuNQDOswe8Jt/QEiMp3ZhiiqWnQRmGteK+0E
         /+lds20vpO9Wh9GjsH7JDLsjSXuJu1HHKP/dWuzA3e+sTxIh3/t38YU2SuYbC0mLC5l2
         8swQ==
X-Forwarded-Encrypted: i=1; AJvYcCUftoFb0H/sZ/+tEdWGdMsKdTMCh+7VqOJuH1OOB3x8djc4IbkM4rMyHeBFNOfncficL25aAk/TBjtx4AXBdHa9Cc4aSdEK6x3GCw9u3drZI0i8HE0jVZgvfRHjDet6wBn9
X-Gm-Message-State: AOJu0Yx/gv0Xzr/QNV3bQiCFvS0f04AjorbEQpxS8y2cpn0br03YkZba
	LL8fA9d/8PwTTZ2wtRiPO6cCNkX5M62++HlCH5p6HnjGA1d0elru+qntyUvlzJxkwl8Ae3NSL/k
	JI/AxPxp3Xe3zCSGoHMu4Wk7aP6I=
X-Google-Smtp-Source: AGHT+IHC9129UFHKLJVWu59KlrBAFQHjuLJAPXRcIMITBR/y3yl7B/1mDZtCo+FXr/nzrNpi9QW3jmAQMdPb19b2ZOc=
X-Received: by 2002:a05:6512:328a:b0:513:cc25:d3b5 with SMTP id
 p10-20020a056512328a00b00513cc25d3b5mr5423878lfe.7.1711394001477; Mon, 25 Mar
 2024 12:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325155434.65589-1-puranjay12@gmail.com> <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
In-Reply-To: <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 25 Mar 2024 20:13:10 +0100
Message-ID: <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
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

On Mon, Mar 25, 2024 at 8:10=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Mar 25, 2024 at 03:54:34PM +0000, Puranjay Mohan wrote:
> > LLVM generates bpf_addr_space_cast instruction while translating
> > pointers between native (zero) address space and
> > __attribute__((address_space(N))). The addr_space=3D0 is reserved as
> > bpf_arena address space.
> >
> > rY =3D addr_space_cast(rX, 0, 1) is processed by the verifier and
> > converted to normal 32-bit move: wX =3D wY
> >
> > rY =3D addr_space_cast(rX, 1, 0) has to be converted by JIT.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> Doesn't compile for allmodconfig:
>   ../arch/riscv/net/bpf_jit_comp64.c:1086:7: error: call to undeclared fu=
nction 'insn_is_cast_user'; ISO C99 and later do not support implicit funct=
ion declarations [-Wimplicit-function-declaration]
>
> Cheers,
> Conor.

Yes,
I mentioned in the cover letter that a patch is required.
It just got merged in bpf-next/master:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3D770546ae9f4c1ae1ebcaf0874f0dd9631d77ec97

So, rebasing on the latest bpf-next/master should fix the issue.

Thanks,
Puranjay

