Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E432777048C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjHDP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjHDP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ACD59EB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBEF962056
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C42C433C9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691162764;
        bh=WvZAHorDIpiciLffkFVJw3h0wT4JjJwW3b25V9pJ9jc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rdgdWpwsgCrdio72CLu/5c47JmPJbC6pDJ9yd7X3ODpdKiXDv3a0AEludD6OO3h0Y
         kaaYjSPQ59gET1u3Dj4nloSvhNDFGqXLNNVZ3mvvWHmcfbw/eG5x3Q+n0IpgAqZAg6
         fL/++eStQJ5/amosKRZFt4besY0Ga/gHOArYUSlDGugZ7nNU+5cmvtKXAQKS3mhIDG
         ynkDtScRIaENlSn+ScpKQWq/S4phsR+kHrE0PirPoeN3/UVCaQFIKLmdDHCLA823F+
         oUIVDvVxYzZh7KAOdIYXKtrtsAosCu6wdRTZtM37y0ri6LDkidXfMmoYmVkOYrJrxY
         Zal2WDdHSB1uA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so7067932a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:26:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxA4q2AwtiaIqpVEZzPcY1ctfNu7+HbaG0i0FHKpLT9Rg1myAeJ
        oLMdDEUeXGTjjEeav9T4GVQl+k+Gt4ViAiQVyII=
X-Google-Smtp-Source: AGHT+IHgYIxDUocD7XElmW9huTw2tiWuHOgemRBa6n1ZRjbTHykdamk6R3XLjPmb3ulxLHxs7ZYARKgDoOxCKmOvacg=
X-Received: by 2002:a05:6402:3509:b0:522:ddeb:cdcb with SMTP id
 b9-20020a056402350900b00522ddebcdcbmr58574edd.18.1691162762460; Fri, 04 Aug
 2023 08:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230804125609.2054719-1-kernel@xen0n.name>
In-Reply-To: <20230804125609.2054719-1-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 4 Aug 2023 23:25:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5g-jmeQMhicrqhpStV9n0Z-EZ1dZAsuT2hmOaHki4ucg@mail.gmail.com>
Message-ID: <CAAhV-H5g-jmeQMhicrqhpStV9n0Z-EZ1dZAsuT2hmOaHki4ucg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Drop -ffreestanding from CFLAGS
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Fri, Aug 4, 2023 at 8:56=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wrot=
e:
>
> From: WANG Xuerui <git@xen0n.name>
>
> As explained by Nick in the original issue: the kernel usually does a
> good job of providing library helpers that have similar semantics as
> their ordinary userspace libc equivalents, but -ffreestanding disables
> such libcall optimization and other related features in the compiler,
> which can lead to unexpected things such as CONFIG_FORTIFY_SOURCE not
> working (!).
>
> As it turns out to be the case, removing the flag does not impact the
> LoongArch kernel's normal operation at all; so just remove it to
> restore expected libcall semantics globally on this architecture.
>
Not all processors support unaligned access, so we need the
alternative mechanism to select memset/memcpy/memmove implementations.
If remove -ffreestanding, the builtin implementation cannot be used on
all hardware.

Huacai

> Closes: https://github.com/ClangBuiltLinux/linux/issues/1897
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index b1e5db51b61c..db0d7210272d 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -83,7 +83,6 @@ KBUILD_CFLAGS_KERNEL          +=3D -fPIE
>  LDFLAGS_vmlinux                        +=3D -static -pie --no-dynamic-li=
nker -z notext
>  endif
>
> -cflags-y +=3D -ffreestanding
>  cflags-y +=3D $(call cc-option, -mno-check-zero-division)
>
>  load-y         =3D 0x9000000000200000
> --
> 2.40.0
>
