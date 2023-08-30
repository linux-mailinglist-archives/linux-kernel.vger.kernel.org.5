Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102978E180
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbjH3Vcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjH3Vcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:32:53 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B801FC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:32:23 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-64f92ca5d8bso1109526d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693431068; x=1694035868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrR3h31lbTk9xkTFf3cxnvH3CTKI0f+A5tILf14Z9rU=;
        b=gamCyvBVEajnCc8WkAh2xdKXgoOS/4ApS7ZU/ieo26ezcxY6beKXdYbnMcMgbbZfEQ
         ydTsO9EFzap/O57r2WUGilMJpUkWxD+pCRFLryMa/1Y6+tumhBxfMBlwWYQ9lpVOpRpm
         0OtwUVsxanYVv5WUAy9OSx+lD4siOBKztNCj5Ew36gjeR57om9TNbGxH+DuVfsE0AAnf
         UQXp9BWNK903VhDz/cgTjIyFXXh/jUq0otCd8srVcMFS00vhRscObUgZ30P6x6Xm3zoU
         rcqKqEkI2f25oosahcSR5eXN/CI11Pn78kfdOuTRTzgMLzxRQg3UwLAu3itbGOvJX4oL
         5aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693431068; x=1694035868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrR3h31lbTk9xkTFf3cxnvH3CTKI0f+A5tILf14Z9rU=;
        b=fNhu9L9LNLaPeDvzl1ghznKfg+R/x1ZkEILOwDuq8UxUu66JdUxx/WQ9Dct5xlYA/b
         nctRLB9ozak35nH4YyRnEAnMaS3esjKC313zhbwmh4Ygj8dOa4HEh9HssVvkPGG1rZ/k
         bRpuN36lhpPOHyO/MJrYBEy9pY0JRKkxaTSptRrXc0j/4GjOHjCKwWyW2GKXiq0XyXU2
         0wHeLLDr4VFhxXZElo+KANYhUZBdL+5WxX3t8kFVd4vQK9/gM3P1DPBKsgm5aOPOi9xC
         SfREraHA7xGKGTFOkrk89jO/rdliYmokqjMPtgfRa49lzZWg/FNtLXfmis3oDGqGj63y
         OCqw==
X-Gm-Message-State: AOJu0YzX5SX2fhSqlzBGbvPL+ffkuYgJ4HQE73QxcQt+asjPlSgP3vle
        zDo7QEoZMbh2hFN8WxaYbgXDmhN/VX9Vz+LM7Xi4pA==
X-Google-Smtp-Source: AGHT+IGrjJEwv2qzVN9QCDg++IKj/hIoaTc9P6YamyZpMeXxSw8x87Z+YFRb68fzXttUiOA1D22LxFIYohGyo3SEQJU=
X-Received: by 2002:a0c:cc13:0:b0:641:8ba9:68ab with SMTP id
 r19-20020a0ccc13000000b006418ba968abmr1039748qvk.42.1693431068402; Wed, 30
 Aug 2023 14:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
In-Reply-To: <20230722123850.634544-1-alexghiti@rivosinc.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 30 Aug 2023 14:30:31 -0700
Message-ID: <CABCJKucj78p4TBtXYmMdJ=vYK69XC=XU06uB+_fyfZLRnC4h0A@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Sat, Jul 22, 2023 at 5:39=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The following KASLR implementation allows to randomize the kernel mapping=
:
>
> - virtually: we expect the bootloader to provide a seed in the device-tre=
e
> - physically: only implemented in the EFI stub, it relies on the firmware=
 to
>   provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementati=
on
>   hence the patch 3 factorizes KASLR related functions for riscv to take
>   advantage.
>
> The new virtual kernel location is limited by the early page table that o=
nly
> has one PUD and with the PMD alignment constraint, the kernel can only ta=
ke
> < 512 positions.
>
> base-commit-tag: v6.5-rc1

Thanks for continuing to work on this!

I reviewed the patches and the code looks correct to me. I also
applied the series on top of v6.5 and after patching qemu to provide a
kaslr-seed, I confirmed that the virtual offset appears to be random
and is printed out when I panic the machine:

# echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
[   17.510012] lkdtm: Performing direct entry PANIC
[   17.510411] Kernel panic - not syncing: dumptest
[...]
[   17.518693] Kernel Offset: 0x32c00000 from 0xffffffff80000000

For the series:
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

I didn't test the EFI bits, but the rest of the series:
Tested-by: Sami Tolvanen <samitolvanen@google.com>

Conor, in another reply you mentioned you're planning on reviewing the
patches as well. Did you have any feedback or concerns?

Sami
