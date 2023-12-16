Return-Path: <linux-kernel+bounces-2173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B88158EB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221F31F22EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E02FE3A;
	Sat, 16 Dec 2023 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n909PnMs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013B2E83D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C83C433C7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702728935;
	bh=zWnJphzweoz7F+QrRhD2anzikZZpOjRmcdAuPKKE6YY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n909PnMsEAebADQStAwNBVmYruNwK9Y0UwtzcfdVKrJwASESID/SiUEdEylDqvPo+
	 25mTano9Cop824JBZbUTwSDw/sVPq2Xdqmirt4uOXNZDc3cLiE2eEIm4xUJHytwZOE
	 F5taDiHf560qSOY33/i5/pfXRX/9Ao4RIDyJjCnrKSF5YXO8S0iIpRsl2fyDMUZ5Xa
	 DLhPl0TKsIWNxLmqLSDR+oaBhQQrpxDzk1JZtosxQFIDJMuxxHTE3vybXpnRix5poI
	 GkIATXDZSpBz2Y9V9ziT86YEABgwsSkYSZGrpJWwyvezeQZJk275xm7BReXi4FqJAM
	 mvlOJb4386sOg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-551c03ae050so1672811a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:15:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzasCh4nzXngeGkAy3nAgPH/CAfHPiGrbEPrcdDAFavsVMOEGJ0
	SFfFy98/GkYwZDadnQcKEB8gPgqBqaapZI4o4qQ=
X-Google-Smtp-Source: AGHT+IGvsP91C0otMi0/JIAC4rU89or1Di3jQfjncBdh1FZOxyXVzrhnvGEjsBNFNuhhvwbrWbjytNUn19av9QcY31c=
X-Received: by 2002:a17:906:dfd0:b0:a19:a19a:eabd with SMTP id
 jt16-20020a170906dfd000b00a19a19aeabdmr6683403ejc.118.1702728934047; Sat, 16
 Dec 2023 04:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW4PR84MB3145B99B9677BB7887BB26CD8192A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB3145B99B9677BB7887BB26CD8192A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 16 Dec 2023 20:15:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5mr6OWN5uwY1Uyhd231ieJ=3fGJL5wg31gOj5Jqm+vMg@mail.gmail.com>
Message-ID: <CAAhV-H5mr6OWN5uwY1Uyhd231ieJ=3fGJL5wg31gOj5Jqm+vMg@mail.gmail.com>
Subject: Re: [PATCH] scripts/decodecode: Add support for LoongArch
To: Youling Tang <youling.tang@outlook.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Sat, Dec 16, 2023 at 2:58=E2=80=AFPM Youling Tang <youling.tang@outlook.=
com> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> An example how to invoke decodecode for loongarch64:
> $ echo 'Code: 380839f6  380831f9  28412bae  <24000ca6>
>   004081ad  0014cb50  004083e8  02bff34c  58008e91' | \
>   ARCH=3Dloongarch CROSS_COMPILE=3Dloongarch64-linux-gnu- \
>   ./scripts/decodecode
> Code: 380839f6 380831f9 28412bae <24000ca6> 004081ad 0014cb50 004083e8 02=
bff34c 58008e91
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   380839f6        ldx.w           $fp, $t3, $t2
>    4:   380831f9        ldx.w           $s2, $t3, $t0
>    8:   28412bae        ld.h            $t2, $s6, 74(0x4a)
>    c:*  24000ca6        ldptr.w         $a2, $a1, 12(0xc)               <=
-- trapping instruction
>   10:   004081ad        slli.w          $t1, $t1, 0x0
>   14:   0014cb50        and             $t4, $s3, $t6
>   18:   004083e8        slli.w          $a4, $s8, 0x0
>   1c:   02bff34c        addi.w          $t0, $s3, -4(0xffc)
>   20:   58008e91        beq             $t8, $t5, 140(0x8c)     # 0xac
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   24000ca6        ldptr.w         $a2, $a1, 12(0xc)
>    4:   004081ad        slli.w          $t1, $t1, 0x0
>    8:   0014cb50        and             $t4, $s3, $t6
>    c:   004083e8        slli.w          $a4, $s8, 0x0
>   10:   02bff34c        addi.w          $t0, $s3, -4(0xffc)
>   14:   58008e91        beq             $t8, $t5, 140(0x8c)     # 0xa0
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  scripts/decodecode | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/decodecode b/scripts/decodecode
> index 8fe71c292381..6364218b2178 100755
> --- a/scripts/decodecode
> +++ b/scripts/decodecode
> @@ -67,6 +67,7 @@ if [ -z "$ARCH" ]; then
>      case `uname -m` in
>         aarch64*) ARCH=3Darm64 ;;
>         arm*) ARCH=3Darm ;;
> +       loongarch*) ARCH=3Dloongarch ;;
>      esac
>  fi
>
> @@ -98,6 +99,10 @@ disas() {
>                 ${CROSS_COMPILE}strip $t.o
>         fi
>
> +       if [ "$ARCH" =3D "loongarch" ]; then
> +               ${CROSS_COMPILE}strip $t.o
> +       fi
> +
>         if [ $pc_sub -ne 0 ]; then
>                 if [ $PC ]; then
>                         adj_vma=3D$(( $PC - $pc_sub ))
> --
> 2.40.0
>

