Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD87F5CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjKWKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjKWKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:44:28 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762BB91
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:44:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso748942b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700736274; x=1701341074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unmTJjjQSG4GhQBCjfHPKG9Uy9nrMwsNNaOqoSHqW9g=;
        b=mJ39gpRBk5Yq7BZAGzR631TPLGbHXdfHcR6bMU7BYSHGM0l4IXFcovt3rBxdKvSsSJ
         bGyNntZwwR2ez3745mP1wG5mHTWsA3iBPPHmf54EINfqXbpz7TShRulh1hyp5M/EZGDj
         +ppkUzMfZgquNGq/my9UHNKtWxeXoXmxPmbDb6sATgRUnII8N6UiV5j9/oapVx8+rN11
         P/MSYdbFfhMW0HULg4r3qrHSdDs/wxSYxdDcdQqldp+aODoV9cbEByG99RVKe9rjKPcA
         UtenG26kIdlyE7OeDbKfNJYpJjrVarjWaiu7q+HESSZVipY1fc19F2Ed/tX8h2VaH06R
         BUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736274; x=1701341074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unmTJjjQSG4GhQBCjfHPKG9Uy9nrMwsNNaOqoSHqW9g=;
        b=YgkkU91xdRuM+YBqrN2r3VEcKXFJmErwjYL8fARvGI1Pd6LXgSMv0RT9igqumMT844
         rbpTPBNt6JLmn8iiI6XBCo+wSjwgcLjZtQRqXfzdyD7NmmgNA11m5us8FB+4hg4t8tF0
         BcxLOxjJEOIgLxrjeQYTdK2oOL9/g1H/0l9teL1VISYcR0P/pb7RvUjjtT92VKxRKUg2
         PbVg401PR9WdKfnLspXhZdQlAPui/N6wLo0/tUDBMgWrHzHPbOjk0QBEFLELtwlvQ+rM
         L1ABPl0XDwtu1Ld+9IzgySV173Cr3yUqGHIAxW/2ggIIiGUzZZOACzvYSOhuHdrY5RWo
         svsA==
X-Gm-Message-State: AOJu0YyQUfyra9vQrcQUN9//e6zZLYPfxrBR7udHobRPs3yKeD3blqjA
        TVK2E6aNtPyGeYihbIJDHViDeaou0sOUwcXii1Q3GA==
X-Google-Smtp-Source: AGHT+IGkFYRhyV0fxJkdmnJmDbruM7tyCPnBEy8QS6oIFkUlufe60cG/P+XEsi8T11OkZWQvkjQH/aa9Fevg/e/ljSM=
X-Received: by 2002:a05:6a20:320f:b0:187:4487:c5e9 with SMTP id
 hl15-20020a056a20320f00b001874487c5e9mr4048871pzc.47.1700736273705; Thu, 23
 Nov 2023 02:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-3-apatel@ventanamicro.com> <adf2a8f4-f675-4d27-8b46-5d80d3251b6c@sifive.com>
In-Reply-To: <adf2a8f4-f675-4d27-8b46-5d80d3251b6c@sifive.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 23 Nov 2023 16:14:21 +0530
Message-ID: <CAK9=C2WmFFsVmZZj9j9VwdQOgBiXZOUujoj5VWcycPetkqHRMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] RISC-V: Add SBI debug console helper routines
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 4:15=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2023-11-17 9:38 PM, Anup Patel wrote:
> > Let us provide SBI debug console helper routines which can be
> > shared by serial/earlycon-riscv-sbi.c and hvc/hvc_riscv_sbi.c.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/sbi.h |  5 +++++
> >  arch/riscv/kernel/sbi.c      | 43 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 66f3933c14f6..ee7aef5f6233 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -334,6 +334,11 @@ static inline unsigned long sbi_mk_version(unsigne=
d long major,
> >  }
> >
> >  int sbi_err_map_linux_errno(int err);
> > +
> > +extern bool sbi_debug_console_available;
> > +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_a=
ddr);
> > +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_ad=
dr);
> > +
> >  #else /* CONFIG_RISCV_SBI */
> >  static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) {=
 return -1; }
> >  static inline void sbi_init(void) {}
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 5a62ed1da453..73a9c22c3945 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -571,6 +571,44 @@ long sbi_get_mimpid(void)
> >  }
> >  EXPORT_SYMBOL_GPL(sbi_get_mimpid);
> >
> > +bool sbi_debug_console_available;
> > +
> > +int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_a=
ddr)
> > +{
> > +     struct sbiret ret;
> > +
> > +     if (!sbi_debug_console_available)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRIT=
E,
> > +                             num_bytes, lower_32_bits(base_addr),
> > +                             upper_32_bits(base_addr), 0, 0, 0);
> > +     else
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRIT=
E,
> > +                             num_bytes, base_addr, 0, 0, 0, 0);
> > +
> > +     return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value=
;
> > +}
> > +
> > +int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_ad=
dr)
> > +{
> > +     struct sbiret ret;
> > +
> > +     if (!sbi_debug_console_available)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ=
,
> > +                             num_bytes, lower_32_bits(base_addr),
> > +                             upper_32_bits(base_addr), 0, 0, 0);
> > +     else
> > +             ret =3D sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ=
,
> > +                             num_bytes, base_addr, 0, 0, 0, 0);
> > +
> > +     return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value=
;
> > +}
>
> Since every place that calls these functions will need to do the vmalloc =
lookup,
> would it make sense to do it here, and have these take a pointer instead?

Yes, that's better. I will update.

Regards,
Anup
