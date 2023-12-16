Return-Path: <linux-kernel+bounces-2171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3E8158E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D447D1F224B9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C04224EE;
	Sat, 16 Dec 2023 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXyXb0D3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C8219E6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2956AC433CA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702728920;
	bh=sUJVttjrqMGG9GOfiJGUCFG16DGITEYxiE+dbAV/C5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KXyXb0D3HhTGd85YYa6TrddgdSi8TZOvYAHS8TbsA4kJGo1pKEbjqJxCo99Pbo/6V
	 ogFlEg8oErZfA0De0+NUvMhAY36nosKo7vNOgvwaMqkpdATQdj867kYBVnYJjAMhLq
	 1O6kLtSmM7/hcc7p1TgaDAFf+LxvGbzrCZ7dFsmqMM6uHw+NKPkcEojYwvuacKD0lK
	 T4dXiyNVB+1Rl8cZWtfmwI+qb4cclaZbTtCYv8/VysQo+HQpcNZAgZG1vSiJaEhXb3
	 dbdoOPC7FwsfOb7Gv4c43M0PALU0atuIOVszANrQcYLhKz5786Rd4I3nL3wpxvu/wY
	 lwqGYGc3dKEfQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1e35c2807fso176582466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:15:20 -0800 (PST)
X-Gm-Message-State: AOJu0YzIsB6X0a6nQ0heVQAeFJHSicw6yrHlByPvOXqF7efS5XYLTQVM
	zq3KOrZQWTZvFF0JHO9GEKTMHSgYJc2HWw0z/yM=
X-Google-Smtp-Source: AGHT+IGimfM204DTWZkz4cNXSYZcmY+RORin+2Ttbp4/jiosUwmV4P2KE41dTSfih0mUlIa090mLfIjj/QZioA2o30U=
X-Received: by 2002:a17:906:dfd0:b0:a19:a1ba:da41 with SMTP id
 jt16-20020a170906dfd000b00a19a1bada41mr7126350ejc.104.1702728918592; Sat, 16
 Dec 2023 04:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW4PR84MB314514273F0B7DBCC5E35A978192A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB314514273F0B7DBCC5E35A978192A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 16 Dec 2023 20:15:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4AnfMJYj9Tqcte7wwtYc4orpZPGds4EpDjKrmgSsVO_Q@mail.gmail.com>
Message-ID: <CAAhV-H4AnfMJYj9Tqcte7wwtYc4orpZPGds4EpDjKrmgSsVO_Q@mail.gmail.com>
Subject: Re: [PATCH] checkstack: Add loongarch support for scripts/checkstack.pl
To: Youling Tang <youling.tang@outlook.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Sat, Dec 16, 2023 at 2:48=E2=80=AFPM Youling Tang <youling.tang@outlook.=
com> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> scripts/checkstack.pl lacks support for the loongarch architecture. Add
> support to detect "addi.{w,d} $sp, $sp, -FRAME_SIZE" stack frame generati=
on
> instruction.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  scripts/checkstack.pl | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> index f27d552aec43..e9d01b999b74 100755
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -16,6 +16,7 @@
>  #      sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
>  #      ppc64le port by Breno Leitao <leitao@debian.org>
>  #      riscv port by Wadim Mueller <wafgo01@gmail.com>
> +#      loongarch port by Youling Tang <tangyouling@kylinos.cn>
>  #
>  #      Usage:
>  #      objdump -d vmlinux | scripts/checkstack.pl [arch]
> @@ -104,6 +105,9 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_s=
tack);
>         } elsif ($arch =3D~ /^riscv(64)?$/) {
>                 #ffffffff8036e868:      c2010113                addi    s=
p,sp,-992
>                 $re =3D qr/.*addi.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
> +       } elsif ($arch =3D~ /^loongarch(32|64)?$/) {
> +               #9000000000224708:      02ff4063                addi.d  $=
sp, $sp, -48(0xfd0)
> +               $re =3D qr/.*addi\..*sp, .*sp, -([0-9]{1,8}).*/o;
>         } else {
>                 print("wrong or unknown architecture \"$arch\"\n");
>                 exit
> --
> 2.40.0
>

