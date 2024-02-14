Return-Path: <linux-kernel+bounces-65245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2DF854A03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC69C1F24E82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6215338B;
	Wed, 14 Feb 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvcT8YJo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D21B813;
	Wed, 14 Feb 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915834; cv=none; b=AbtcI12rcK0k+LFosUNwilX5LDGML94EqQ2QUAqs4qJJySDSWXDwpjVNoCbSmhqyuRzHLTGHKsM0cuu5iswQZZvYJMeV9JGnEB/UubS8LAp/9dwl2JJtvRitcOPvPqzB49/n03J7WlJkhFAov0qlX2jGvgGxguE2H4Gn0HpyWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915834; c=relaxed/simple;
	bh=Y5cCv6WN3AG3tMIqacma1w2YSEMZ6JaBHyisxC12c9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXwdbTZSOrryKwlob7xGvdHrK4UUVzJn84vpVQdAP6stEDNCDdGfHvgLeWIGTD+5iSzKQP4j1qTKWTuON/7bWW9lEeZq5FN31HCjLE3FoXMrYIx8dv13bEhRLBx9CgVmOj6cspIu2LMje01qFLxhDLQ2GR8+/jI0IwGBc7nLgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvcT8YJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FED8C43143;
	Wed, 14 Feb 2024 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915834;
	bh=Y5cCv6WN3AG3tMIqacma1w2YSEMZ6JaBHyisxC12c9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AvcT8YJoQNZs8sfRDTkmYygA8l0Kza6K8KEPY6U7YF/29oo0kvqwp44UZBHOO9osR
	 TK4RFyjNq+qR4wlkN6n+/wJeiSFhvBNfCAObgM80sJtGSwoUvEgYM7erDzssa3Fx8B
	 rxHRY+UhSYZjUxn+MgyDUGzHqPBf7DIS2+9n2BX6DogXsBakeZgX3CVQ6HNVmQJ2H9
	 yg/6H+xw9ZzE5Sxgpwj4QToZs1eY5dOaaUEd2NWIZNm3z+/fcmPObmj+mQtJQzz4e3
	 leKlh4ZGTJMSOlFYXtUASBH4/14g80J141xiKM29JjkRFxnMLfX5eKDJcXmKTbLqrx
	 cYW5Fi/ic4yUA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5638aa9a5c2so529040a12.3;
        Wed, 14 Feb 2024 05:03:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWD6j/DH0k7FIsBz9pEDIpD8O8mzLMWlyx9IzfvbXEUGGoOQO/vT2OHGcnqNWdYdXVO/ROcW6ElcmFJLpNFgtkPpuxueGhmfpU/u+ndLuG+SJNzXmAX07OuJjsxmyO1j3A5d6f/7N2LJkPK8dOpwbL5z0LWsfYK94qc911wogbZ3P2N3vMHUfVQ98BddLknqdh24pK9kuwXy+9j1DWu0aY/xXU=
X-Gm-Message-State: AOJu0YwqZyjH+kx1ouDtvBdKHvfwwQicj386I1Xn5gNDdtZmfdbN2x+q
	7ZirB/LGfgQSufG3l/iN1qcFXTnisuguHLg0N1VsYjikMFrlGkidyaiIT+tnMoJuJpkPyhmhtLZ
	6F8rFK+Sj/J/Y0c9lZOQUG1gLZ18=
X-Google-Smtp-Source: AGHT+IGDqSWASlPOhhqmPfhR917mdVVEr1HDL41oniwRUbx8hEYlWBy0XN5Ku7zm3JoyjDeFMN3Gw5snyzzzzutcjwg=
X-Received: by 2002:a05:6402:514f:b0:562:9f3:afeb with SMTP id
 n15-20020a056402514f00b0056209f3afebmr1987648edd.20.1707915832828; Wed, 14
 Feb 2024 05:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com> <1707524971-146908-2-git-send-email-quic_obabatun@quicinc.com>
In-Reply-To: <1707524971-146908-2-git-send-email-quic_obabatun@quicinc.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 14 Feb 2024 21:03:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5f5e-cCaX7Gr20oG8F-aywJcosLn4ajxx2SQWoB8JtSA@mail.gmail.com>
Message-ID: <CAAhV-H5f5e-cCaX7Gr20oG8F-aywJcosLn4ajxx2SQWoB8JtSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] loongarch: Call arch_mem_init() before
 platform_init() in the init sequence
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	robh+dt@kernel.org, frowand.list@gmail.com, linux-openrisc@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Oreoluwa,

On Sat, Feb 10, 2024 at 8:29=E2=80=AFAM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
> The platform_init() function which is called during device bootup
> contains a few calls to memblock_alloc().
> This is an issue because these allocations are done before reserved
> memory regions are set aside in arch_mem_init().
> This means that there is a possibility for memblock to allocate memory
> from any of the reserved memory regions.
>
> Hence, move the call to arch_mem_init() to be earlier in the init
> sequence so that all reserved memory is set aside before any allocations
> are made with memblock.
>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  arch/loongarch/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index edf2bba..66c307c 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -597,8 +597,8 @@ void __init setup_arch(char **cmdline_p)
>         parse_early_param();
>         reserve_initrd_mem();
>
> -       platform_init();
>         arch_mem_init(cmdline_p);
> +       platform_init();
Thank you for your patch, but I think we cannot simply exchange their
order. If I'm right, you try to move all memblock_reserve() as early
as possible, but both arch_mem_init() and platform_init() call
memblock_reserve(), we should do a complete refactor for this. And
since it works with the existing order, we can simply keep it as is
now.

Huacai

>
>         resource_init();
>  #ifdef CONFIG_SMP
> --

