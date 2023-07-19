Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEBF75A057
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGSVHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjGSVHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:07:13 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567061FD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:07:12 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34896a1574dso1049075ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689800831; x=1690405631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw73Q1YuV233rysJvP1vwk0uF1bjG87pfrX4sQ5t0bM=;
        b=rQY9Cr1SHH/ctX8CCtlKYTyYXgYTkCK5id94Tw8HxLbv3kd8qA3lfCfCqZkIPyzh19
         NYoECxUUSHCQgnxR3qyLw0WlEp7Z5hVdlj+nLF+KVe6yIKvdgO6UD6umk10qURup2rE6
         Ao8nttTKg0NethV5wHlHTMUhEkCy08I0wq8BhRyy0NTWFNHvmBX1ww5q0k9hAKK776XY
         VVr1qkU+BFnMw3Vf7STs9abodPpdX4XEqZFWgRQVoiEtXlwJWR1bjjHPyIjmHRCf9jRq
         bRt8ua3EGoh/Prc7l1u8xe3thu9eEQ3TIJddnTi6TVq4qR7okH/iEt4Ekpf/oK0tiGq9
         sYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689800831; x=1690405631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw73Q1YuV233rysJvP1vwk0uF1bjG87pfrX4sQ5t0bM=;
        b=ffZ0nXPvnfyAlWcECMrh7MLGkFe+9FpUMUN8lBMMCPXa22eh0snGC1JqA8K6N1mXWr
         gH/Zttg9mSeZ3qa7w6CzMvKXXmOG2iO5CnTl4+eVIFMcpgailjev6A8A4TiHAJzsCuq3
         i1jVKNaZcD1vIMf9ak00Q/FxJa+0+ACU2/AJ9XbDqMsALTZnJHq/3Ebk7F3HowwQqi0U
         wzEED0ax4gWcVz1LIyza+194FFtGSJR9+VHwF87kyYkOiz6tyiCzM7aq454K1AQjSy7e
         X/iaOaPFKkl7DlUi946YUsOLFB2Z7+5WuGKWnistwrYTa0RAMwgilPgwaa5soDyxwVfT
         tgOw==
X-Gm-Message-State: ABy/qLYSK1VwQH9PVdr69Vayd2jhfaU0dItHx60g/QBEJq7ijuHXINMz
        BIjBgBghb5QpuaKikgGzamCJ862Mt2/3lhRnf2FFpg==
X-Google-Smtp-Source: APBJJlGp2G2cIlYiY4AmGxq8lav5jER+fTKtxi4dg3vMFMU8lkC6QRf5wi2+xTGPdoYf3gDsm470s+y8hFvIsDhNy/g=
X-Received: by 2002:a92:d28a:0:b0:346:53cf:418d with SMTP id
 p10-20020a92d28a000000b0034653cf418dmr186086ilp.15.1689800831455; Wed, 19 Jul
 2023 14:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <961d125558137f7cb960de65e5f71da5d299d3bc.1689792825.git.tjeznach@rivosinc.com>
 <20230719-marbled-drivable-804aacbafee2@spud>
In-Reply-To: <20230719-marbled-drivable-804aacbafee2@spud>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Wed, 19 Jul 2023 14:07:00 -0700
Message-ID: <CAH2o1u4107Eve67gxEg1rtCLFyaABFsmfop1-ko=GT5wzeajiQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] RISC-V: arch/riscv/config: enable RISC-V IOMMU support
To:     Conor Dooley <conor@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:22=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Jul 19, 2023 at 12:33:46PM -0700, Tomasz Jeznach wrote:
>
> $subject: RISC-V: arch/riscv/config: enable RISC-V IOMMU support
>
> Please look at any other commits to the files you are touching
> and use a subject line that emulates them. In this case, try
> git log --oneline --no-merges -- arch/riscv/configs/
> Same goes for the odd pattern in your driver patches.
>
> Also, the patch may be trivial, but you still need to sign off on it
> and provide a commit message.
>

ack. added to-do the list for v2.

Thank you,
- Tomasz

> Thanks,
> Conor.
>
> > ---
> >  arch/riscv/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
> > index 0a0107460a5c..1a0c3b24329f 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -178,6 +178,7 @@ CONFIG_VIRTIO_PCI=3Dy
> >  CONFIG_VIRTIO_BALLOON=3Dy
> >  CONFIG_VIRTIO_INPUT=3Dy
> >  CONFIG_VIRTIO_MMIO=3Dy
> > +CONFIG_RISCV_IOMMU=3Dy
> >  CONFIG_SUN8I_DE2_CCU=3Dm
> >  CONFIG_SUN50I_IOMMU=3Dy
> >  CONFIG_RPMSG_CHAR=3Dy
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
