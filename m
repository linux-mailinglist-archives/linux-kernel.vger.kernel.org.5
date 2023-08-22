Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2C783AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjHVHct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjHVHcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12CF184;
        Tue, 22 Aug 2023 00:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79BF66497C;
        Tue, 22 Aug 2023 07:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF17C433C9;
        Tue, 22 Aug 2023 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692689564;
        bh=qm8bePmXQDxAe4hMK7cV/0XRjLqFLVFhkUxWkK/1yls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pu2+4xk3oy9SpJI1drb/oR1mmRFpYziweg8onCssqW4SS+/4DIYN3qxfgL1MaiFRD
         TxcA7P2ew90rAY1GB4SvUcLJIPXqTqbyEn+5UYNk0cBV0T3p44yYnXY+DLkvFoKJrQ
         e9aqZqt62mBMIA7oFEUXTJZOWioQJwHV/lH6MbSk3o+U34nNc9xzrH1TzCJ7o/qysY
         E4QhXFX0/HyMgEDeywjRn9tHTf7T9LJwMtPSW1K2OvsKmm8K0WUz7lz22mseK5+64d
         ubrE4TOzPjYlSkpfoHLhurUsW8vRmU1/rq57zmtxvkwwHfDYoFw+CaxlzosVAt0vN3
         fMh4bPlb+SrOw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so6425347e87.0;
        Tue, 22 Aug 2023 00:32:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YwNAZtEag+D94XKBvmgS3+rYR8OHMUEmG0jsBk+baBMYz0ZBxKE
        1WZhQX6IrXz2g7WTMn/zPRHqeV0B309TFxOMvFI=
X-Google-Smtp-Source: AGHT+IFpQJc7vqi9NEfra/Rh1hIm2mnVKSukKSrt+zRTz0wsLhC3bRak9Ae0hEdXcZdVETVuDF7RmJ9NbLdVeYxLK2Y=
X-Received: by 2002:a05:6512:3047:b0:4fe:9f83:8bda with SMTP id
 b7-20020a056512304700b004fe9f838bdamr7199240lfb.52.1692689562489; Tue, 22 Aug
 2023 00:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230822164859.26b0b8f6@canb.auug.org.au>
In-Reply-To: <20230822164859.26b0b8f6@canb.auug.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Aug 2023 09:32:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGKtpGNYx6hqygya+k_gQaMTiwEZnRGk9rZ=hcbcagKXA@mail.gmail.com>
Message-ID: <CAMj1kXGKtpGNYx6hqygya+k_gQaMTiwEZnRGk9rZ=hcbcagKXA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the efi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On Tue, 22 Aug 2023 at 08:49, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the efi tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> In file included from drivers/platform/x86/uv_sysfs.c:14:
> arch/x86/include/asm/uv/bios.h:118:22: error: expected ')' before '*' token
>   118 |         u64 (__efiapi *function)(enum uv_bios_cmd, ...);
>       |                      ^~
>       |                      )
>
> Caused by commit
>
>   73632c8c865f ("efi/runtime-wrappers: Remove duplicated macro for service returning void")
>

Thanks for the report.

I cannot reproduce this with Debian's GCC 12.2.0 when building the
efi/next tree either in isolation, or merged into yesterday's next.

Could you please share the compiler version and the .config you used? Thanks.

-- 
Ard.
