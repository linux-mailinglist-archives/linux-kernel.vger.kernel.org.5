Return-Path: <linux-kernel+bounces-109970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A1885860
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE311B222CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BB5A4D5;
	Thu, 21 Mar 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIa9ZBj0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60A58210;
	Thu, 21 Mar 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020704; cv=none; b=jDILXFJ763BX0kz6jjIWe4durwt2e69Il6udAJZN6YufzvXHLlIHH8wfY7O2nHiGnXm5KsuNGo7+cXPK5NWtOIsK2vO4XrT0jrCZjgyYRik3wdPlBYATiVhJXgqV8FUx4ZVIM6nhrbxrbOXA94fc0sixrwVdZxDXPm9vgety87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020704; c=relaxed/simple;
	bh=DJO28aVkOmnoGoHQnSfeSZEZa0r4jTvfugf4tMA0Cmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3FLrjS/dS+5PB9RUW+YKqgqJ5tEbnpTZYDwYGFnOr8Oya6dPDoJOB4+pwox9jb7dp8JoDfNkAd1H6J5ycIxxRfZfWmdv9MkH/LbUz74pBNzJdjJsIGqGUGAQtMaoy5/wD/yQwcGcPAi5ql2iHSJoUYa0qQ1WyGKe7tVdbEKq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIa9ZBj0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4146e5c719bso6539585e9.2;
        Thu, 21 Mar 2024 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711020701; x=1711625501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm9RUXritdc1cmBd9a/YU9HuV2GGTJD40+SLLBPKFHk=;
        b=cIa9ZBj0rzk28pfg4tvUCyCKUYnZNrHRyFAe+TIkyo9yXHZVRHw0z+DOI6GgTxgNzj
         9AoT4+ZbkYq3JRNF201b6FJ7PUzKSjvK6bRZJP6+o4DqAXmvi/nBsNT2/bsEzWK8oqjl
         5GRGyQ0N+wHf5UAl+v4Ho0zPy8fMTN6sZjtSjGyVNVvGa1Bdg7kaHk1Ih6sFtqUW8OXQ
         FkbtgVBP//Z4ng6MgTFHyIAfMrjMPVqSnBJGM4iCg0/7E1OnKzouH3yTq+yv2QUXWm6N
         jrgcz+aPTk1AieTm9aOtUKHhVZTorhfOrmUlXQwtXPKysDis6js8/LKVvVJTzgUhyweB
         llRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020701; x=1711625501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm9RUXritdc1cmBd9a/YU9HuV2GGTJD40+SLLBPKFHk=;
        b=JjYrSsmXo7k5YlQkn5oVJYKAnluQXv5LrPVbCLNKsFJ6Gs/CuNZ1fQ4CBmvrpIzG2E
         vGknOkXv/1kNP7YJL1Mqg3RJHXOWTuuPMl5nG6uhY1tUxGH7gBLn7otNrrwExpbFjYK/
         tMoahybDXSbL9lQE1cNon7f8UpbZ/Un+Sha03vjlstOmNaW5kBLR3BBE5gYT4ArfOAgq
         bnVMvOohH7GFm+OSkzRFYJ1ADU6WKNkamreEkeNRFIksNmahYNPl8NrgdEgzmQC5H43M
         TNccENtTwoxjtoGvP22V6j9wRbVGQYPwOX0GLkaSKsrQp+Xxi87DWQv21WZHIAb1vzoe
         TpCw==
X-Forwarded-Encrypted: i=1; AJvYcCUx5can+MN3BXs8UH5XoVKEOCJRrIZWsiDjilN0ZPG4TQ48cGuBIAOcJdFb0bsb1+ZHwARJ1EmuoIBbIAh/STmxznfMDfWalgzqUIhf1wt62lETDIK4Vxe/opMaid2HWn/Y6Gu4MQXgmtgkE38lKvF1b2B5aEnbIrjs
X-Gm-Message-State: AOJu0YzTcJeN7e5Lu9sFHnLASdOOBIZKKDFDWib0jO0GaDBRxOwbZ1oF
	eO4oIaUwiudVxCgsmvDapNOWcJ0+Sa+yvR7uRAtCT+uHwY2UYIKjSi+UEAnqyWFsSt59Nl8sGGC
	b/Y+vTqUKo2YY8V2uMydcYtHSH50=
X-Google-Smtp-Source: AGHT+IEGBweFJd+BeGA1qee4nfD63A/jOmAnFJCswQxI8IsENzoWjQqN3QQEBc36ULLJ0pzbxlzmG5i1Hh5X0pNdZio=
X-Received: by 2002:a5d:668e:0:b0:341:80fc:4913 with SMTP id
 l14-20020a5d668e000000b0034180fc4913mr2936875wru.67.1711020700630; Thu, 21
 Mar 2024 04:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321101058.68530-1-puranjay12@gmail.com> <CAADnVQLhwLgq=QuXD-Ls=t9Scr_4Zn9JwdkXfZQfZkT=ysx64Q@mail.gmail.com>
In-Reply-To: <CAADnVQLhwLgq=QuXD-Ls=t9Scr_4Zn9JwdkXfZQfZkT=ysx64Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 04:31:29 -0700
Message-ID: <CAADnVQLHrmkJ5p2gEUJkf_CRxq9gv8rcSuBm5GeZ_nUJxQOE0Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: verifier: prevent userspace memory access
To: Puranjay Mohan <puranjay12@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:05=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2024 at 3:11=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.=
c
> > index e613eebfd349..e61a51a5b4be 100644
> > --- a/arch/s390/net/bpf_jit_comp.c
> > +++ b/arch/s390/net/bpf_jit_comp.c
> > @@ -2691,3 +2691,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
> >  {
> >         return true;
> >  }
> > +
> > +u64 bpf_arch_uaddress_limit(void)
> > +{
> > +       return -ENOTSUPP;
> > +}
>
> Looks good and should work, but s390 CI is still not happy.
> Ideas?
> sock tests were not failing before. So something is going on.

I think I have an explanation.
-ENOTSUPP and u64... and later:
u64 uaddress_limit =3D bpf_arch_uaddress_limit()
if (uaddress_limit < 0)

I bet the compiler simply removes this check since unsigned cannot
be negative.
Odd that there is no compiler warning.

pw-bot: cr

