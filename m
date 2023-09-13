Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8479F20A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjIMT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjIMT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:29:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51C1BF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:29:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so124904f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694633363; x=1695238163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T31Y6ADFFsmyLBOtJgWzvVVmYv2JScM5XB6j3nMa+Gc=;
        b=UWtRZy9BqwdrryHOT+tRxPgxrg/FeZ7cVG40LOg7sgJhLA/iF4CS0XCa9h6TuFhQUr
         M0ACdxH+78qPZV1R+4G9/Kw19wyaXIcyZYzVNN5laeV3isGLmEtA3w2p2KEjGbmExZ3J
         4eyfkXsEVVG8UIbW4kBMZQR/ppuhqbmHYtLQPcn7Dxu2O8gdFZroI3s6Hwo5p515xRdu
         OvdNFRw5WMqin+qMDTgqB7veUIw9xaLw/Y4mFmJ4uQiSMVdrfiwd4X0oZEuPezxCoaZp
         L6WkPGirhAanom2M0eOg7rBbc547vWxC9wh3kcPGTWP77XPO5AYFgZuHXNd+GAvBowia
         qrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633363; x=1695238163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T31Y6ADFFsmyLBOtJgWzvVVmYv2JScM5XB6j3nMa+Gc=;
        b=N40pEBlbySrxPBhedKQvHz6M9YZYBpV+mjexPMAJSDwPZub3K+IpHSy9wFquJ5oWt4
         1JwHJbXsMPEbCmVCpoKjqV04i0nFxiyiFnjhLcnWee+h7KE8z66t74eRHrqBe/WLk2GY
         K1stl1pBstRUTaqtr/FvSdo5uwkIEPwwI+/ZL0ac4Rj+4WJI+2BWTj+v0wabGGW3yA9m
         xf+mo3IDMLtuP09TWyibym5DUHoSUjheP+w9TVlx6otTAbOnnBgykvY0lKHDlBvhp/8D
         oeQyBV4WK/PhfuzvjfHqgF0z2x0LB5c2m3CcAWRCOjOEYeRvMwE8SmXHmT7KrV/DB/Ol
         Sakw==
X-Gm-Message-State: AOJu0YyNEKdiWFoVU628Z5pbW8GyKW4U6oSlIUcR3LZlAo9XBzZcJL02
        cIGJOoT6EbmymUezZFsNlwrCroldyJ8mBJQBFDGd0A==
X-Google-Smtp-Source: AGHT+IHK0TxwXTM7W/Z/2U4oklSQq+A9o1xceZ58v8xaUK+4Sl0mHqbws39rl1USVjfGjxquBf3yRbhTTcj7nvSi7Mg=
X-Received: by 2002:adf:b606:0:b0:31f:d15a:2230 with SMTP id
 f6-20020adfb606000000b0031fd15a2230mr571220wre.20.1694633362747; Wed, 13 Sep
 2023 12:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230913162458.2931065-1-peterlin@andestech.com>
In-Reply-To: <20230913162458.2931065-1-peterlin@andestech.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 13 Sep 2023 21:29:11 +0200
Message-ID: <CAHVXubhB_FY7Vc7105J_SuS8JbvVSyKTbtaamY1HPngyXRmWXA@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Improve PTDUMP to show RSW with non-zero value
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, david@redhat.com, akpm@linux-foundation.org,
        bjorn@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ycliang@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Wed, Sep 13, 2023 at 6:25=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> RSW field is allowed to encode 2 bits of information, currently
> PTDUMP only prints RSW when its value is 1 or 3.
>
> To fix this issue and enhance the debug experience with PTDUMP,
> allow it to print the RSW with any non-zero value, otherwise,
> it will print a empty string for each row.
>
> This patch also removes the val from the struct prot_bits
> as it is no longer needed.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
>  arch/riscv/include/asm/pgtable-bits.h |  2 +-
>  arch/riscv/mm/ptdump.c                | 33 ++++++++++++---------------
>  2 files changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/a=
sm/pgtable-bits.h
> index f896708e8331..d5e828b7d7c6 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -16,7 +16,7 @@
>  #define _PAGE_GLOBAL    (1 << 5)    /* Global */
>  #define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
>  #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
> -#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
> +#define _PAGE_SOFT      (3 << 8)    /* Reserved for software */

That makes the PAGE_SPECIAL below use the 2 software reserved bits
right? You should redefine PAGE_SPECIAL to (1 << 8).

>
>  #define _PAGE_SPECIAL   _PAGE_SOFT
>  #define _PAGE_TABLE     _PAGE_PRESENT
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 20a9f991a6d7..62bbea17d475 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -129,7 +129,6 @@ static struct ptd_mm_info efi_ptd_info =3D {
>  /* Page Table Entry */
>  struct prot_bits {
>         u64 mask;
> -       u64 val;
>         const char *set;
>         const char *clear;
>  };
> @@ -137,47 +136,38 @@ struct prot_bits {
>  static const struct prot_bits pte_bits[] =3D {
>         {
>                 .mask =3D _PAGE_SOFT,
> -               .val =3D _PAGE_SOFT,
> -               .set =3D "RSW",
> -               .clear =3D "   ",
> +               .set =3D "RSW(%d)",
> +               .clear =3D "      ",
>         }, {
>                 .mask =3D _PAGE_DIRTY,
> -               .val =3D _PAGE_DIRTY,
>                 .set =3D "D",
>                 .clear =3D ".",
>         }, {
>                 .mask =3D _PAGE_ACCESSED,
> -               .val =3D _PAGE_ACCESSED,
>                 .set =3D "A",
>                 .clear =3D ".",
>         }, {
>                 .mask =3D _PAGE_GLOBAL,
> -               .val =3D _PAGE_GLOBAL,
>                 .set =3D "G",
>                 .clear =3D ".",
>         }, {
>                 .mask =3D _PAGE_USER,
> -               .val =3D _PAGE_USER,
>                 .set =3D "U",
>                 .clear =3D ".",
>         }, {
>                 .mask =3D _PAGE_EXEC,
> -               .val =3D _PAGE_EXEC,
>                 .set =3D "X",
>                 .clear =3D ".",
>         }, {
>                 .mask =3D _PAGE_WRITE,
> -               .val =3D _PAGE_WRITE,
>                 .set =3D "W",
>                 .clear =3D ".",
>         }, {
>                 .mask =3D _PAGE_READ,
> -               .val =3D _PAGE_READ,
>                 .set =3D "R",
>                 .clear =3D ".",
>         }, {
>                 .mask =3D _PAGE_PRESENT,
> -               .val =3D _PAGE_PRESENT,
>                 .set =3D "V",
>                 .clear =3D ".",
>         }
> @@ -208,15 +198,20 @@ static void dump_prot(struct pg_state *st)
>         unsigned int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(pte_bits); i++) {
> -               const char *s;
> -
> -               if ((st->current_prot & pte_bits[i].mask) =3D=3D pte_bits=
[i].val)
> -                       s =3D pte_bits[i].set;
> +               char s[7];
> +               unsigned long val;
> +
> +               val =3D st->current_prot & pte_bits[i].mask;
> +               if (val) {
> +                       if (pte_bits[i].mask =3D=3D _PAGE_SOFT)
> +                               sprintf(s, pte_bits[i].set, val >> 8);
> +                       else
> +                               sprintf(s, "%s", pte_bits[i].set);
> +               }
>                 else
> -                       s =3D pte_bits[i].clear;
> +                       sprintf(s, "%s", pte_bits[i].clear);
>
> -               if (s)
> -                       pt_dump_seq_printf(st->seq, " %s", s);
> +               pt_dump_seq_printf(st->seq, " %s", s);
>         }
>  }
>
> --
> 2.34.1
>
