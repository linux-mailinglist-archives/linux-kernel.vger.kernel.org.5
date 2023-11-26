Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFF7F930D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjKZOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:20:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A355101
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:20:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9FFC433C7;
        Sun, 26 Nov 2023 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701008415;
        bh=5HL7Cy5319r95tB2zVJxxM8nekMUKbOq+0WJf7ZzUxc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MSa3oRNDO3TDXTJK+fHM5zcoF0/IrcStXg4R3Z63zkh6hoh2JUdjFoyDVDhtuxNTJ
         9Gy7UEiY2TS8TeajmkmhFxFjWHzZodXKwh5jjCX4CTQVCvfSjbVi9UrNeNmiAeY72A
         lKAQd/i/8LBittoCyGOG3ngaIB5GVbCWX6EuInQI31tWaqYK0/4tFvdGOyQnaOkK/H
         AqnBrqvas3YCkWlwgp1AQ+qouCFFwQk9BuX8QAN8AoaTT6pf0xBI90vSrTWwKIfin3
         Q6Ith7c6d/z2RG1srlOzDGDMgQnFHIrdiI6uTKoBjH60QRAigyXfFCeuCHpaLQGrGi
         2A4DJEizHg7MQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507a3b8b113so4453390e87.0;
        Sun, 26 Nov 2023 06:20:15 -0800 (PST)
X-Gm-Message-State: AOJu0YxxVPZxI6Dz8o8bWNdVCddc4wY7tlFvDN9QO3i3T/MAaxkSWAGe
        Hjv8ugP+jX3Fs6gC6bQzVTe1D47oW7jQ0X6wixM=
X-Google-Smtp-Source: AGHT+IGMPnMHJifpP9OnzUJx3ixD5EYSC3TeGDlHLFsAK5HSLZdh/LlekFARTL1mu8S/HW3qFUrD1/7bfsF2FrOpAK4=
X-Received: by 2002:ac2:4210:0:b0:50a:9fb9:91b with SMTP id
 y16-20020ac24210000000b0050a9fb9091bmr5011131lfh.64.1701008413926; Sun, 26
 Nov 2023 06:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20231124035534.70432-1-wangrui@loongson.cn>
In-Reply-To: <20231124035534.70432-1-wangrui@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 26 Nov 2023 22:20:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H72pcXHQi-o71Ct7v+A1BSfNRTSzLrE9KMeS1dwd9KNnw@mail.gmail.com>
Message-ID: <CAAhV-H72pcXHQi-o71Ct7v+A1BSfNRTSzLrE9KMeS1dwd9KNnw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Apply dynamic relocations for LLD
To:     WANG Rui <wangrui@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-fixes, thanks.

Huacai

On Fri, Nov 24, 2023 at 11:56=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wro=
te:
>
> For the following assembly code:
>
>      .text
>      .global func
>  func:
>      nop
>
>      .data
>  var:
>      .dword func
>
> When linked with `-pie`, GNU LD populates the `var` variable with the
> pre-relocated value of `func`. However, LLVM LLD does not exhibit the
> same behavior. This issue also arises with the `kernel_entry` in
> arch/loongarch/kernel/head.S:
>
>  _head:
>      .word   MZ_MAGIC                /* "MZ", MS-DOS header */
>      .org    0x8
>      .dword  kernel_entry            /* Kernel entry point */
>
> The correct kernel entry from the MS-DOS header is crucial for jumping
> to vmlinux from zboot. This necessity is why the compressed kernel
> compiled by Clang encounters difficulties in booting.
>
> To address this problem, it is proposed to apply dynamic relocations to
> place with `--apply-dynamic-relocs`.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1962
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>  arch/loongarch/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 1f0d74403419..05ab85118212 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -83,7 +83,7 @@ endif
>
>  ifeq ($(CONFIG_RELOCATABLE),y)
>  KBUILD_CFLAGS_KERNEL           +=3D -fPIE
> -LDFLAGS_vmlinux                        +=3D -static -pie --no-dynamic-li=
nker -z notext
> +LDFLAGS_vmlinux                        +=3D -static -pie --no-dynamic-li=
nker -z notext $(call ld-option, --apply-dynamic-relocs)
>  endif
>
>  cflags-y +=3D $(call cc-option, -mno-check-zero-division)
> --
> 2.43.0
>
>
