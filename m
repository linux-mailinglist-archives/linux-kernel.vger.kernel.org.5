Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE67DCD91
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjJaNL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbjJaNL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:11:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165FCDA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:11:51 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 955723F1D9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698757909;
        bh=b2T7hXExx+WhS9Dv9tSkQ0JEJTevpbCwf8KukhTzG9g=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=R/j0hF+yzHC4mSPpdt5KQbhhTTlhtghcZ5ijNHTKXOSaFXWFjLzCMmsiIW/IeGQjE
         2si+app0Ee7OvW4k5LpELpJQCT/5/+MAFvpAFKs1y9B57HlVquq2A+2JXsPRAElNRM
         smABtyAMnUmkU/MkZFdahAvbWWPxYG5LFkMwwusdzwjJO3BpK/EhMpvQ69SGL0Vj7V
         ubxco5g3Tb0sqE8ngZ8+zutJm06c6wFCLkGaVzDT/TNg9puvOlzskhAG6hF9Zi97Gv
         GAxl/D8+UFlFec5Twb1hc3JZQQM2KbLol5I/qTzcyvzpPbAcgxZZxvQdX8hV5P/xZk
         pSeL2ca2Y/nLw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41ce372d248so69744111cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698757908; x=1699362708;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2T7hXExx+WhS9Dv9tSkQ0JEJTevpbCwf8KukhTzG9g=;
        b=hdRKyx8GA5S51YIh6dZpn0iVDvqFEdw6mfIsnK2XwuQN7/0alHzYJFmY1WPhlKRbyM
         9kSMeHCxM/knzJyaQfIEfjIcAjdd5VTua6+um7YNCmjhboufJfxyFLRoYyG/WpxxJNgj
         GKy5SQkNGaeM/2SW39JZOYagJPx3OO+wjgg/hmP5pPritUSB5kduby1kV1fslALooB3W
         SACOl2H5HD7PJLy+t9ooNNsWl34e77lj8nlMRfQDSGP/u+ZEKtmVUcLCdKmDoWay7PVI
         J5TQgjlpDcxrsKMW9J9LdKOo2aT97KmYA50cKj7zzCkmcIBp7Xi70NDYq5MUeZsWvfoa
         vJ2w==
X-Gm-Message-State: AOJu0YycslN1Z1dssh4yTLWcDMk+vcwj7HxI47bY7CdcDOCpF0ny94nM
        CMOh3fJ6pBu52LbArh1Gs6kHOto/1vAs6zs2cK0zGg4U4P9PACpJIrmTsYLNwTR2V/Hm/RY2j2a
        4Fiot4DNQ9wzM38ZxhbiCCsDg/1bBdalTqEz5B7rNfoUJkfUIZSnLh4ibyg==
X-Received: by 2002:a05:622a:351:b0:418:d3d:30e1 with SMTP id r17-20020a05622a035100b004180d3d30e1mr15984876qtw.4.1698757908409;
        Tue, 31 Oct 2023 06:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLydeufNQ40CIQK34i2W51RxoHoaC5kevrpJPqzBNZkr96WHN3wruIvi91h0D+mmmgNmgd+N5Yhsyd5FWYItM=
X-Received: by 2002:a05:622a:351:b0:418:d3d:30e1 with SMTP id
 r17-20020a05622a035100b004180d3d30e1mr15984845qtw.4.1698757908147; Tue, 31
 Oct 2023 06:11:48 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 06:11:47 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231031-module_relocations-v7-1-6f4719b64bf7@rivosinc.com>
References: <20231031-module_relocations-v7-0-6f4719b64bf7@rivosinc.com> <20231031-module_relocations-v7-1-6f4719b64bf7@rivosinc.com>
Mime-Version: 1.0
Date:   Tue, 31 Oct 2023 06:11:47 -0700
Message-ID: <CAJM55Z-v0EwrZp876DdLSzad2u55nJV_uBs_+MUJDqFW5MTPkA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] riscv: Avoid unaligned access when relocating modules
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nelson Chu <nelson@rivosinc.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Jenkins wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> With the C-extension regular 32bit instructions are not
> necessarily aligned on 4-byte boundaries. RISC-V instructions
> are in fact an ordered list of 16bit little-endian
> "parcels", so access the instruction as such.
>
> This should also make the code work in case someone builds
> a big-endian RISC-V machine.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/kernel/module.c | 153 +++++++++++++++++++++++----------------------
>  1 file changed, 77 insertions(+), 76 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 7c651d55fcbd..a9e94e939cb5 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -27,68 +27,86 @@ static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
>  #endif
>  }
>
> -static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
> +static int riscv_insn_rmw(void *location, u32 keep, u32 set)
> +{
> +	u16 *parcel = location;
> +	u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
> +
> +	insn &= keep;
> +	insn |= set;
> +
> +	parcel[0] = cpu_to_le32(insn);

Why cpu_to_le32(insn)? Unless I've misunderstood something downcasting unsigned
to unsigned values in C (eg. from u32 to u16) is defined to always discard the
most signifcant bits, so cpu_to_le16(insn) should be fine.

> +	parcel[1] = cpu_to_le16(insn >> 16);
> +	return 0;
> +}
> +
> +static int riscv_insn_rvc_rmw(void *location, u16 keep, u16 set)
> +{
> +	u16 *parcel = location;
> +
> +	*parcel = cpu_to_le16((le16_to_cpu(*parcel) & keep) | set);

In this case, maybe consider writing it out like above just so it's easy to see
that the two functions does the same just for differently sized instructions.
The compiler should generate the same code.

> +	return 0;
> +}
> +
> ...
