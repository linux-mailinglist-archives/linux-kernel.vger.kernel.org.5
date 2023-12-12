Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF82280F3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjLLQ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjLLQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:56:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C159F95
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:56:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso29213715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702400180; x=1703004980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OpS8QvLmhoSAmNbzXuy9RYCtH6wkVeGub04kf2dZCE=;
        b=s2MaVV81eRkFFVSv+CEMDgYOGfK5RjAOq+uRUIVUlQQD8Y2UFunRUi/sDNTno9UQFm
         r0uA7das8So/k8J/lK7RNqoETh6UsXi+NvhMco65BeQImTiOri5giNZaRcoSu6ryA/Qo
         q9Rn6dw/ZJRaj+O2jY6+631owvuAb04h86dHPynbHZuviiglROPxOwgDzx+M8p1qybLo
         D4LFNvlzbyezHTLy0eBBgbaDvo/5OhvE9256UA2ycMqkm3rRKmRzU0VX7zjHIxt0JVSN
         YqvUh/KiU2qWNh7b4bRYJfWw5vtOzLh1IcejDHTmwwestEgm/6vZm/O1cNOh8hZV+MYO
         UYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400180; x=1703004980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OpS8QvLmhoSAmNbzXuy9RYCtH6wkVeGub04kf2dZCE=;
        b=U6PBd90+cUt76YFofQj4kTf8bXQa6pE0jV2q07P8cxTHhWWFujWg4m18imvRCfu99a
         z/qbM4Buj726iYDjP0+Ku+z6w2v40eulVjLTm8HQReoBfOBK7F39xInAfNqjbCDpvOCh
         x5UxHM1IrSbmzBM0yCbKoM8x8B9P7Pj1V8bnAGIk+dxu5+216UcbSUdwCG49cgq75YLY
         lfSOKzeqMZtXnocZmWDHUftcSz7hOC8lExuw2BRFZT5Mnn3U4iFxwMYl6mNP7DT8hKcR
         FaOmbUd+vkesodB6sGxOcuZXj6yyr9fLFoPMh6Zlzk+6AbVZcDAUrpZR9KM4PeVjwLnS
         YNJA==
X-Gm-Message-State: AOJu0YyMAPYzcbqa2OcLrjJgtpkZ10JOb4Yx0/GL3z5z2tMtqmwclxPi
        ijnipj+gIAv0T8HdQdi73/Bj45wRSoO7u43L1sSEeEMa+ow0r1nrQUI9sQ==
X-Google-Smtp-Source: AGHT+IF57G5xzFkVfzhQ6L4Jp050TnfWYKoW0vXKBEg5qX6/XT790iWuyYeR8u21h8EBH9G8WN6kIULlKe+iGLmGesE=
X-Received: by 2002:a05:600c:4e4f:b0:40c:23e0:7dad with SMTP id
 e15-20020a05600c4e4f00b0040c23e07dadmr3396524wmq.168.1702400180143; Tue, 12
 Dec 2023 08:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20231212-removeasmgeneric-v2-1-a0e6d7df34a7@google.com>
In-Reply-To: <20231212-removeasmgeneric-v2-1-a0e6d7df34a7@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Dec 2023 08:56:05 -0800
Message-ID: <CAKwvOdnTH+SgiLDkq4KmjVifF-bkxKfBNxE2o+XHjuRa6ZCSRA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: remove unused header
To:     tanzirh@google.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <nnn@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 4:20=E2=80=AFPM <tanzirh@google.com> wrote:
>
> arch/riscv/kernel/sys_riscv.c builds without using anything
> from asm-generic/mman-common.h. There seems to be no reason
> to include this file.
>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Thanks for the patch!

Fixes: 9e2e6042a7ec ("riscv: Allow PROT_WRITE-only mmap()")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> ---

You're still getting funky extra `---`; let's take a look later at how
you're using `b4` together offline.  It's not a problem for me to
apply the patch, but something still isn't quite right. (Do not send a
v3 over this)

> Changes in v2:
> - Changed name to riscv: remove unused header
> - Link to v1: https://lore.kernel.org/r/20231211-removeasmgeneric-v1-1-a0=
274e802789@google.com
> ---
>  arch/riscv/kernel/sys_riscv.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.=
c
> index a2ca5b7756a5..ebcaf386ea62 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -14,7 +14,6 @@
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
> -#include <asm-generic/mman-common.h>
>  #include <vdso/vsyscall.h>
>
>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231211-removeasmgeneric-f6be13a42b6b
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>


--=20
Thanks,
~Nick Desaulniers
