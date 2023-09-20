Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9A7A77F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjITJwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjITJwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:52:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73D78F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:52:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0c6d4d650so59380085ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1695203527; x=1695808327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAjfxMNySxbXYDqqkQfkESLiAhRgg9f8YsCkiLb1kdA=;
        b=OY8/6zxfS5f0j+FTd/W6o5PNBY0jObjArP3jj+cWkSE4F4gAjHCSHeIrL8yjz3F71U
         8Ykk/059MnL+w+qf2bGn/SW42rFKL15c3V2IHKDNsiUxjHzonXMIo2BOjKPVFSIJLcsV
         O4Sm0L4CfFzzMk5eOhgHf+L3SF27484nX2gWntJR0P8XyKrTogHFrVqRvqkr1oPonpHO
         5Z0xTyNvjwBmb2DtC28pOYrYMZHPyWyM7WeRix8Ih/aT9dmx1tvPkKWVlOPdHQDigD73
         9cIOSrJpMXul/Lk83JhnahZCG4YIOZ7Y+5ELa0jczaCNl1ABbcUD3SWX2fmOh21CqLKd
         zUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695203527; x=1695808327;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAjfxMNySxbXYDqqkQfkESLiAhRgg9f8YsCkiLb1kdA=;
        b=UUxIfUelC+vXzvnNv1dDv/SLMtqKpuJDMbjrex+mPurfdqxyDWM0bsGLxdBEdOJoef
         Azi7FG9LfGReuLysKvBFk3nxmWZIMhdbLqk6e6wiFPl8ThqPFyHlKEC4AlmbWlZQe73i
         wz/Xqd7ywLQ2vJR5qRiWQe7CwbkCEGgKtnYXd9MtVA6l9Oq45ZielDbtVFnWXgC3Y/6O
         Z3wBHwKTDHbgvmhvXUDzip3GRvU+O7XxZmIAxVSstlQOFVxpQy+w4gRqoNK0q1opq0kw
         pvlX7e8SXU2g2T7LHenFTuC2kkMvtQCD5LSLClv2BXRWtI31E9TniUjE1ggh6rPgkCTa
         AxqQ==
X-Gm-Message-State: AOJu0YwhEcafsZJOB+Aucw1a8PJOunESEoLEj3N40RzSL6ZwyQZ8XTvK
        +VYeACNptrF99aR1G9QNUkBB6Mxt0fiG2K43e6ookA==
X-Google-Smtp-Source: AGHT+IHdJ1h7Sz+AyI8DIB8o6cx1e67gDn44+qaRKDID9SW26w9vpf8dlDGScNFprNERzF01ovO2Cg==
X-Received: by 2002:a17:903:124d:b0:1bb:9c45:130f with SMTP id u13-20020a170903124d00b001bb9c45130fmr2077240plh.69.1695203527161;
        Wed, 20 Sep 2023 02:52:07 -0700 (PDT)
Received: from localhost ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id jg12-20020a17090326cc00b001b05e96d859sm1532139plb.135.2023.09.20.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 02:52:06 -0700 (PDT)
Date:   Wed, 20 Sep 2023 02:52:06 -0700 (PDT)
X-Google-Original-Date: Wed, 20 Sep 2023 02:51:50 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: Remove duplicate objcopy flag
In-Reply-To: <20230914091334.1458542-1-songshuaishuai@tinylab.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, songshuaishuai@tinylab.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     songshuaishuai@tinylab.org
Message-ID: <mhng-8cabcad9-a181-4db8-904b-3f7daa7621f1@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 02:13:34 PDT (-0700), songshuaishuai@tinylab.org wrote:
> There are two duplicate `-O binary` flags when objcopying from vmlinux
> to Image/xipImage.
>
> RISC-V set `-O binary` flag in both OBJCOPYFLAGS in the top-level riscv
> Makefile and OBJCOPYFLAGS_* in the boot/Makefile, and the objcopy cmd
> in Kbuild would join them together.
>
> The `-O binary` flag is only needed for objcopying Image, so remove the
> OBJCOPYFLAGS in the top-level riscv Makefile.
>
> Fixes: c0fbcd991860 ("RISC-V: Build flat and compressed kernel images")
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 1329e060c548..b43a6bb7e4dc 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -6,7 +6,6 @@
>  # for more details.
>  #
>
> -OBJCOPYFLAGS    := -O binary
>  LDFLAGS_vmlinux := -z norelro
>  ifeq ($(CONFIG_RELOCATABLE),y)
>  	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs

Does this result in any incorrect behavior?  It looks fine to me, but if 
there's no regression I'll put in on -next instead of -fixes.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
