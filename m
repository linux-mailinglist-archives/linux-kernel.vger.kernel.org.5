Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5176E7C8C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJMRRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMRRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:17:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1219995
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:17:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso631311b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697217461; x=1697822261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMVyDqu7F9L/NyUu216jVo0D3sCma51x1zVdF7INqlA=;
        b=fIi8lX84JYWgo4D6wHSy2yq2X4YBWs+lNDKkHhdDcKyM5hFIr7Ntww/rtoRP2sDZtu
         ke1dVwsxMvxEIoM4uvzoY+OFCm+IR2i/EtIJ2RC5Z1n1CKAaLNgAw0EZLpxvJ47dhOyW
         RWfQUfSOmW/NdVGh1DIZbtADR8DsrLkYBF1Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697217461; x=1697822261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMVyDqu7F9L/NyUu216jVo0D3sCma51x1zVdF7INqlA=;
        b=DuKbx7BiakTVzKyRnO7iJio5pY0WnNDOygFuxcLWYW3sRAB2mhhdddrvwlyEVFDzQB
         17GqTWU7HXC8NFSpx93TdkZODHzYyTQjFdM+HfWNwaqiySkANYX0GeN9v+Vv0syY+fhU
         M1TavkxTXmyRr8/kC66vADPBcihVX8p8MGywEU0gIHZzlFgmXJ+pEC4clc1G4hhpPe8u
         XUawLOxKJ7v4v9qqhU+n8I4SHzLtdv8Isirs8j/d9/xUumnorlZTVlVMBhDVnqOeh7VQ
         Z+pPXeUZLfqg5ooXAeI7FkDbTv3QKCd8Y16frQOeP/WVCk8/fJyK3duv13lZ1BvFawi7
         zEWA==
X-Gm-Message-State: AOJu0YzLmHqFs50uT3gj4cvjGOpacv+vfXYYPQPxVJKCwO1PT70YR03l
        dWOQ17Ewa3FnBJWeLrczdTKbCg==
X-Google-Smtp-Source: AGHT+IFytYUTIBC8FW/Qxus4CgszolDPefICHjGeUN23FkbYqR9m1jil8+cGojt47ylSx+iJiYgSLQ==
X-Received: by 2002:a05:6a00:4188:b0:6ad:535e:6ed9 with SMTP id ca8-20020a056a00418800b006ad535e6ed9mr5463978pfb.16.1697217461415;
        Fri, 13 Oct 2023 10:17:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h26-20020a056a00001a00b0064fd4a6b306sm1268545pfk.76.2023.10.13.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:17:40 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:17:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Samuel Zeter <samuelzeter@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RESEND PATCH v2 0/2] *** Fix reformat_objdump.awk ***
Message-ID: <202310131013.DF45B0A82D@keescook>
References: <20221112090418.284656-1-samuelzeter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112090418.284656-1-samuelzeter@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*thread necromancy*

These patches still apply and are still needed to correctly process
objdump output. It accidentally doesn't produce any errors currently,
but manual inspection shows mangled results.

Can an x86 maintainer take these two patches please? I can carry them if
that's preferred?

Note that there is an older Ack from Masami:

https://lore.kernel.org/all/20220107205259.e66ff1bd90ac218611bf1178@kernel.org/

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

And I've now reviewed and tested this too:

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

On Sat, Nov 12, 2022 at 07:04:15PM +1000, Samuel Zeter wrote:
> These are two small patches which originally dealt with
> the problem found at:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1364
> 
> The original steps to reproduce were:
> $ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 defconfig
> $ scripts/config -e X86_DECODER_SELFTEST
> $ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 olddefconfig bzImage
> 
> Which resulted in the error:
> arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but
> insn_get_length() says 2
> 
> Upon inspection it turned out llvm-objdump was formatting its
> output differently, which caused objdump_reformat.awk to incorrectly
> output its values.
> 
> After fixing that bug, a second one was seen where the instruction
> "wait" was incorrectly matched with "fwait", which again caused
> insn_decoder_test to fail.
> 
> Samuel Zeter (2):
>   arch/x86/tools/objdump_reformat.awk: Ensure regex matches fwait
>   arch/x86/tools/objdump_reformat.awk: Allow for spaces
> 
>  arch/x86/tools/objdump_reformat.awk | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 151297128990b4b44be8d70b983053831fa857f6
> -- 
> 2.38.1
> 

-- 
Kees Cook
