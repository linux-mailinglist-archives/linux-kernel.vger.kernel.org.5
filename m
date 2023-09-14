Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD579F9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjINFAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjINFAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:00:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1F01BCA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:59:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0940AC433A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694667596;
        bh=Rl6KtUOR7lGfXDB0ACl29fli7qsumtq8Sa3pkYraR3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sBtFRPlktiqUqWJ+qVtOTrvRJgzAdsvLUIzHPGybTJHNovqa3e34YDzYRAPD2W6fs
         10aCoKyxQ+XQEjYns8tKii8l5+PKnCmGipho2s+RKuc19K30+3kQ5Od2f/MWRSzqLh
         oriprnAmtCDrdqWvgABl/PRqo8RJhu6CBpA7C/Kyq6NX80dG/PR84MueSd2Os0krqw
         2wOU+y/9OAEwtRx7WyxkW2o1FVnZJAl8u4YWjquECx2qX2jfNMlCJ2jqRtrNT/JIQx
         +55S4uS0lHZyrbEJLPHqDT5qJ5CUXmtpO8cKHx2se4GegXUnprhUdtoszmUR/WaqT5
         OnUALmnm5IOqg==
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so468450f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:59:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxs8CppjdWLRbxFrGQaCBqNqMnKKMJGZFzrKhsJ1ylSZPeSaZ4X
        6kHdMBbBNo8P8nW+ycneqQlaV2kbMmpxb1k6j68=
X-Google-Smtp-Source: AGHT+IGAi8FBXeB97ec9p2Mj3AW5CWMiKE3sfA3yzAud6DIT7z8hpM7qtM6fK02eb/Fx6LARynCbCqmKWtUPEGFFP18=
X-Received: by 2002:a5d:490a:0:b0:31a:d5fa:d710 with SMTP id
 x10-20020a5d490a000000b0031ad5fad710mr3912116wrq.2.1694667594424; Wed, 13 Sep
 2023 21:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 14 Sep 2023 12:59:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRHbvwyZR_qUNsc3E9X=Y1H7yTcZo3NLgXQ45=jm1jbTg@mail.gmail.com>
Message-ID: <CAJF2gTRHbvwyZR_qUNsc3E9X=Y1H7yTcZo3NLgXQ45=jm1jbTg@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, samuel@sholland.org,
        rppt@kernel.org, suagrfillet@gmail.com, panqinglin2020@iscas.ac.cn,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 11:11=E2=80=AFAM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
> From: Song Shuai <suagrfillet@gmail.com>
>
> Since the commit 011f09d12052 set sv57 as default for CONFIG_64BIT,
> the comment of CONFIG_PAGE_OFFSET should be updated too.
>
> Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/include/asm/page.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index b55ba20903ec..53c00164c042 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -33,8 +33,8 @@
>  #define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
Why not remove CONFIG_PAGE_OFFSET and define PAGE_OFFSET_L2 ?

>  #endif
>  /*
> - * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address spac=
e so
> - * define the PAGE_OFFSET value for SV39.
> + * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address spac=
e so
> + * define the PAGE_OFFSET value for SV48 and SV39.
>   */
>  #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
>  #define PAGE_OFFSET_L3         _AC(0xffffffd800000000, UL)
> --
> 2.20.1
>


--=20
Best Regards
 Guo Ren
