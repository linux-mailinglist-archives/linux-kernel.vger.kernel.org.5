Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0317F5CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjKWKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKWKrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:47:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B48D4E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:47:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2856437b584so376569a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700736434; x=1701341234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pMzVl5pf9UJJ+Fo0I8VraoGZ78XJdMnoApdVbnPwyI=;
        b=l+1P/55KqdusmhKA4Wd3D1cDY9EIErGd3ChMlBmTF/mKHGJ2k5XQrncqTlxqHiGbrt
         P0pC1NtXC+eZTz7hZWevNr+pbdQR92Izb/pbThDI6qMVgiNfjXQa8OqhVuv2hDI4ccBz
         ftPIXvjmvmLYWrNxGoOmnuiiSVNuVC074jLpa/3+uSasquVfm65nyGsssmqBibt+9rZl
         LLUZuDfxG4dNXq7kcEW0+hU452FhCJBvZm9EH6uByoQkg5M78w7xCXUqJw9B1WAmuJV2
         AkFETBkuLsHdWvr2DNPIy6GLpErH06q210OkSoA+2ZldkBia9igl9gy3XX4DDk/cPO9V
         k9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736434; x=1701341234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pMzVl5pf9UJJ+Fo0I8VraoGZ78XJdMnoApdVbnPwyI=;
        b=kZdtFAZ/9hkdaEh9Q/XXY/J/J642sog5E8vWBHplhrPaZ05FtJ+q5+0OGaPWIqq+AJ
         7NwAlA6GYmKZ5s42gfjXdtACuFj6awm1WUnrt1n5HYpW1NF68lSJPJ1u5Z99YP8VwiI4
         vVGLz8Bgti8ctlP/DkdhEa2PO3MmALu9+ZOlXSFWzlc/4t6V9LN/AJpSsl7dg0Q5zwsQ
         /uhvbXdSivoaNqLduj8/m6bPKP0GSEyzGQCrD17JmZeK91pQA3T6x4SWg09+6hNk12Hd
         dtBTFby1v+Xb/0Jnx14zx75Ftz2G1s2f2FE8n+r0ezzpWMONtfSP6tMm8DnDAiAeIi1m
         MlbA==
X-Gm-Message-State: AOJu0YyeT6imdbwOnpREe7VANT28hsYmn+AMyAiSR5zui5J5I6+v+b3w
        2taaJ7EA9zV7H6hMOj5y8kOy2myxj5CLKCbE50juYw==
X-Google-Smtp-Source: AGHT+IENrREiF3sbwAjZt4xq30LW7CVvB2qLXvby7KV+9pgnoiYgGJgV8HcyQnZIfEDxokjnV5oOnnGUF3CBvrBWEKk=
X-Received: by 2002:a17:90a:187:b0:27d:3fa4:9d9a with SMTP id
 7-20020a17090a018700b0027d3fa49d9amr5082578pjc.29.1700736434399; Thu, 23 Nov
 2023 02:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-3-apatel@ventanamicro.com> <20231120-639982716fbfd33a6fc144d6@orel>
In-Reply-To: <20231120-639982716fbfd33a6fc144d6@orel>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 23 Nov 2023 16:17:02 +0530
Message-ID: <CAK9=C2X-cOxjJ-fBLrcvWvP+K8fD=PGucmrWN+m1ZK3j7ae_zg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] RISC-V: Add SBI debug console helper routines
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 1:35=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Nov 18, 2023 at 09:08:56AM +0530, Anup Patel wrote:
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
>
> We can't get perfect mappings, but I wonder if we can do better than
> returning ENOTSUPP for "Failed to write the byte due to I/O errors."
>
> How about
>
>  if (ret.error =3D=3D SBI_ERR_FAILURE)
>      return -EIO;
>
>  return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;

Seems overkill but I will update anyway.

>
>
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
>
> Same comment as above.

Okay.

>
> > +}
> > +
> >  void __init sbi_init(void)
> >  {
> >       int ret;
> > @@ -612,6 +650,11 @@ void __init sbi_init(void)
> >                       sbi_srst_reboot_nb.priority =3D 192;
> >                       register_restart_handler(&sbi_srst_reboot_nb);
> >               }
> > +             if ((sbi_spec_version >=3D sbi_mk_version(2, 0)) &&
> > +                 (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
> > +                     pr_info("SBI DBCN extension detected\n");
> > +                     sbi_debug_console_available =3D true;
> > +             }
> >       } else {
> >               __sbi_set_timer =3D __sbi_set_timer_v01;
> >               __sbi_send_ipi  =3D __sbi_send_ipi_v01;
> > --
> > 2.34.1
> >
>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew

Regards,
Anup
