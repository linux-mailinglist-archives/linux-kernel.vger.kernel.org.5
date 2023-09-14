Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846DB79F7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjINCJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjINCJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:09:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A65271E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:08:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2746889aa89so160237a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694657298; x=1695262098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OfD2OkoRfQyy1jdkiRqmez3LLiLCnLchd58BEe/6mI=;
        b=Z+xLrXsfP0sQEntmtaUpgvaImem0bXokWi+vKHgvw0q3zxAD9dztFHEpIAas+nuaHe
         e6eavu8kFvxjurkikxdbRFZ4OpiumJDS37iEScrdjjUzEFMq3VQSz6U7i3d0NTgXONLa
         Ye/Bw+hR+NqKm4DVk8O+3EyB1newmH/x1wWYeunpWLM52qTAeFQ2aOGzV0jjcMSk5O0B
         Uab4HfkQXOgC7ycsn3F+kSn/6NZeFCh56voAKJmV42OHHxQoj2jIchYCCuXRrCfzOOzs
         sJCA0+7AbjiykapztK+MWg1s6eW0RV9M/L22DPQEjplDm3fdQMuZIHi7xah+MqxrJh1P
         KbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694657298; x=1695262098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OfD2OkoRfQyy1jdkiRqmez3LLiLCnLchd58BEe/6mI=;
        b=RIm4NBHRwOphqQQi1txGUZmebz2SQ6FuqSF68g1RziIIQ3DpgS1g+OWxL59iOBx4Zt
         PvAqVTHFvzSFFjyHe9LW1hipuIkpXWqzDW3aLeCAS7iOWEyyM9rOSOkvtKNeWwLTH7cI
         EyHztU6J86aF+452mt1TAoskGMwZRu644LY+s/oGzF/m8hr+2IznfQVkvS9deQEqadnr
         J+hYoxvXjlWgVIyekdSYaQidDL6jKu6v3QjqlvrTOOtD0zRZrRYztvAtfy4p+zijt5zg
         jEz3z3QEJ1P5/nqg9oYa4juUbkum//2c6ElWo5Z+Y+Qi+F8RWAytyIS5mBB1SxxwPtkx
         pEAA==
X-Gm-Message-State: AOJu0YwQFWlca/oxghueEymFPLYFDWpaMC64CevmXFUFfuHnLLUefpRz
        rZCiG6x0bwlFiIM38svQ6XlQJH0K4BnZpa2SYzE=
X-Google-Smtp-Source: AGHT+IEtLBFjSS4WH0pGMkLzb2v6wt1r1fjFCaU0YQ9oFAFfui0YN6Qx37fjDJyH6KydZatW4kFwuHfbAAQIZ14J+OY=
X-Received: by 2002:a17:90b:1d0c:b0:268:7ec:51ae with SMTP id
 on12-20020a17090b1d0c00b0026807ec51aemr3760831pjb.41.1694657298319; Wed, 13
 Sep 2023 19:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 14 Sep 2023 02:08:06 +0000
Message-ID: <CAAYs2=gV7qT=EjPuxBTyHPWW44qA1wEPuYnT-hz+4Cxz844KfQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, guoren@kernel.org,
        samuel@sholland.org, rppt@kernel.org, panqinglin2020@iscas.ac.cn,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai <songshuaishuai@tinylab.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=89 03:12=E5=86=99=E9=81=93=EF=BC=9A
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
Ping...

--=20
Thanks,
Song
