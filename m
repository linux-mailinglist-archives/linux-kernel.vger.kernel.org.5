Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188687F38FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjKUWK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKUWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:10:56 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63445113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:10:52 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so76963751fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700604650; x=1701209450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bUrfVcVa3Jy5893jk/rq26iu6NlKWecKE/WOuTvkwso=;
        b=c93VEcJbj8ALkjb2camdiWx87HKu8PXqnNxpT8VvLWvcLTzyOMsvRA6ttq/42gj/lc
         KvPzOFfS0mcSdR8yQjtZEYFb9TWrF3pbdhe6mcJ1kKeaUno+qWh/3jzaUXoRkwmK42eq
         vNejBlPPTx2wF873z0Rcj7cKz6eU2aKgXRTxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700604650; x=1701209450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUrfVcVa3Jy5893jk/rq26iu6NlKWecKE/WOuTvkwso=;
        b=As7+QVKdhb4nQ6zbXXWmKbVD0IUtcXVGJBGG/T5l14+muEqunYrH9tUnOSQsyIvkWJ
         jZ4jLAgyb0qqIWfLzZAm4C5oln2QJ/RcTG/60JQy03rgCgAS6rDw/GDsXUphKloyB7Pm
         YNRDCm6rm8t2uCzaGQDVQ4g5hnOfYG3cRp3yO+1as+Cq9NbUkUIY69taRUNtEQTbyF14
         7I+3gJUbBXQH3GN/P3ZsQj9Yg24unI7PVCiDULDP7kgcS8sibIJhcEWSxXgZXfPWA44z
         0baB66kDM9vxCQQbb10EXpfnXH3d1tGRdvLUJQsKlruNkIeqp0TBCv8+omquCWmYP7VE
         4L5w==
X-Gm-Message-State: AOJu0YxNfuEvyOyGI5s1wTRNIu4lauGDMiPAzSGikZbqVMO86cwu++zP
        QCBmT+EKHB/C0Zri8wCmJSILCNtViXjr/MTvgdKgag==
X-Google-Smtp-Source: AGHT+IH2p2S3EHk/kjK8/fkaPAR1usnkzeYyJjccYKzDydluwPFiM16Adxhpj8TLMQfDrLQyuU1JUml1BLpSp818Tmg=
X-Received: by 2002:ac2:5e81:0:b0:509:8f57:8e2 with SMTP id
 b1-20020ac25e81000000b005098f5708e2mr89904lfq.29.1700604650301; Tue, 21 Nov
 2023 14:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20231119053234.2367621-1-masahiroy@kernel.org>
In-Reply-To: <20231119053234.2367621-1-masahiroy@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 21 Nov 2023 15:10:38 -0700
Message-ID: <CAPnjgZ1w+0jcdR-qHSbhdXHJFA-UNFNFTtB4-6BvxYTyuhyweA@mail.gmail.com>
Subject: Re: [PATCH] arm64: add dependency between vmlinuz.efi and Image
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 at 22:32, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> A common issue in Makefile is a race in parallel building.
>
> You need to be careful to prevent multiple threads from writing to the
> same file simultaneously.
>
> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> generate invalid images") addressed such a bad scenario.
>
> A similar symptom occurs with the following command:
>
>   $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/arm64/boot/Image
>     OBJCOPY arch/arm64/boot/Image
>     AS      arch/arm64/boot/zboot-header.o
>     PAD     arch/arm64/boot/vmlinux.bin
>     GZIP    arch/arm64/boot/vmlinuz
>     OBJCOPY arch/arm64/boot/vmlinuz.o
>     LD      arch/arm64/boot/vmlinuz.efi.elf
>     OBJCOPY arch/arm64/boot/vmlinuz.efi
>
> The log "OBJCOPY arch/arm64/boot/Image" is displayed twice.
>
> It indicates that two threads simultaneously enter arch/arm64/boot/
> and write to arch/arm64/boot/Image.
>
> It occasionally leads to a build failure:
>
>   $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/arm64/boot/Image
>     PAD     arch/arm64/boot/vmlinux.bin
>   truncate: Invalid number: 'arch/arm64/boot/vmlinux.bin'
>   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
>   arch/arm64/boot/vmlinux.bin] Error 1
>   make[2]: *** Deleting file 'arch/arm64/boot/vmlinux.bin'
>   make[1]: *** [arch/arm64/Makefile:163: vmlinuz.efi] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>   make: *** [Makefile:234: __sub-make] Error 2
>
> vmlinuz.efi depends on Image, but such a dependency is not specified
> in arch/arm64/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: SImon Glass <sjg@chromium.org>
