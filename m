Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E477F228C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjKUAvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjKUAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:51:46 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB9D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:51:41 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2ea7cc821so3225801b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527901; x=1701132701; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn9aLSeosG7l0BmT5llM/BGYPNtLICtF9m0AjdHG0XM=;
        b=ljYUw9pomTOCuHuLfwq5xwrekbGMMY1fJg0l9NVnaO8ZAdfPg/6la38Q8g5FXbuI+J
         g6qXXhzv4TiyfGT54ZxjVmnc51vOUTTN4YZO7dXphU/tLSWmmAgiRAJdZ4Y0cn9RDDjW
         9ZIytbVzVK7PbZsiqw3o+WxR0+LkJwoezcw5lFrNp9eDBAd1F0X9hgQfv2lvpV3eTN88
         mHM3/wiez566LYEski/4SgFjNCrLqlx9w11i2K9wMQQq3Zbk3Y7DDKD9JOPwf2fcJuaw
         PrOkb66w7PzcfRubpUx7u557fSnzh9/tmyjsYUD1v5iyMPHURGrir4bvys93elhIXfaw
         ZeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527901; x=1701132701;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pn9aLSeosG7l0BmT5llM/BGYPNtLICtF9m0AjdHG0XM=;
        b=QeV+sSrAvMNZz/Hv8XMeLRqtwltEHNbn+E7Q1KMfRROI4UX/8/QGtzZwItKKDjnJ3L
         UeFoamgANkKR4mTjq53HRN/LTnRSFbzfRfwXRoEyD9R5Zk6Io1hPK35e6azbP5rCtrtL
         21Yqudy6GI6J4foAxi5rEZ/+oeFgKN/3ura1r/ibgHmc4hihAntMyfqV2DET/UVw+NYR
         TGWzDwxuPp6cVVqaY6mGDpjnH4iYwFrj8O76LFwxi2i2Arcp9jEbvE79gs8q7gNN7UwH
         LHG6JkzFFjWZvLWjpEZ56xHUB+Hv+HRTX2e5/dguf5b2JriddhinchMFpMO8bJjrvxvb
         K9og==
X-Gm-Message-State: AOJu0YwZBU1I4ByRNlpqXXdj7LeGtiQ7t2HihcSdf9v/KJjyQtNzY8P/
        GbIBt0WPFgXBYwbdNx1srtQ=
X-Google-Smtp-Source: AGHT+IE+o49kLzCuw1FPClPjXT6ATg3hfgvXAS5obzWWtUpkGeQbWTToBNlZGXTLMvhqz0mk9VwJFQ==
X-Received: by 2002:a05:6871:a60a:b0:1f5:b60d:68ff with SMTP id we10-20020a056871a60a00b001f5b60d68ffmr10197694oab.14.1700527901134;
        Mon, 20 Nov 2023 16:51:41 -0800 (PST)
Received: from localhost (203-219-179-16.tpgi.com.au. [203.219.179.16])
        by smtp.gmail.com with ESMTPSA id n28-20020a056a000d5c00b006cbb80e4577sm723318pfv.210.2023.11.20.16.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 16:51:40 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Nov 2023 10:51:34 +1000
Message-Id: <CX42TU4QHS1Z.A0UUHMDAMZOL@wheely>
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>
Cc:     "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
X-Mailer: aerc 0.15.2
References: <20231120232332.4100288-1-masahiroy@kernel.org>
In-Reply-To: <20231120232332.4100288-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 21, 2023 at 9:23 AM AEST, Masahiro Yamada wrote:
> crtsavres.o is linked to modules. However, as explained in commit
> d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
> and always-y"), 'make modules' does not build extra-y.
>
> For example, the following command fails:
>
>   $ make ARCH=3Dpowerpc LLVM=3D1 KBUILD_MODPOST_WARN=3D1 mrproper ps3_def=
config modules
>     [snip]
>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such file o=
r directory
>   make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platforms/cell=
/spufs/spufs.ko] Error 1
>   make[2]: *** [Makefile:1844: modules] Error 2
>   make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350: __bui=
ld_one_by_one] Error 2
>   make: *** [Makefile:234: __sub-make] Error 2
>

Thanks. Is this the correct Fixes tag?

Fixes: d0e628cd817f ("powerpc/64: Do not link crtsavres.o in vmlinux")

Hmm, looks like LLD might just do this now automatically for us
too without --save-restore-funcs (https://reviews.llvm.org/D79977).
But we probably still need it for older versions, so we still need
your patch.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/powerpc/lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 51ad0397c17a..6eac63e79a89 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -45,7 +45,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+=3D error-injec=
t.o
>  # so it is only needed for modules, and only for older linkers which
>  # do not support --save-restore-funcs
>  ifndef CONFIG_LD_IS_BFD
> -extra-$(CONFIG_PPC64)	+=3D crtsavres.o
> +always-$(CONFIG_PPC64)	+=3D crtsavres.o
>  endif
> =20
>  obj-$(CONFIG_PPC_BOOK3S_64) +=3D copyuser_power7.o copypage_power7.o \

