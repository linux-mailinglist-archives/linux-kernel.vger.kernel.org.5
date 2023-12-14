Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10B9812C75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443522AbjLNKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443478AbjLNKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:05:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C6BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:05:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-33621d443a7so4196471f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702548357; x=1703153157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDsPjfWnGKr9KSejE8QyzgD6e/he63cgsRUn3ctxThw=;
        b=Db7xGouYcEMoxcm44D4SrilE4KswMFIx1AzAkd0GfowMOwZhdWr2W8qAKJILnexLeR
         vyatx3XTh8xMcbEj9oXAVN0RS6qZ0qHEEZXhF+LdlNGH5TbDd+yxLfbuOHg/XVNRbJNt
         pZzv8OZ77Q1ZUtSaCPhvKPdkW3NvU8rYoNXl0HUcZsYT6tdIBqeKnACI4d+cFxYDQxYk
         C2hEwkjXvClcb4kE8+o5ZIx/kDqQYSI/c8WFqYzkDSdn90ac7eY8A1nZwueMgRfwM6DF
         rx2xZ5YgelI1X3bz3gZkio91CKE/5KqDOAKw8A1tgyvve1S1wTYDMWksyRFOd/nY3zUg
         TSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548357; x=1703153157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDsPjfWnGKr9KSejE8QyzgD6e/he63cgsRUn3ctxThw=;
        b=AfeMxNKg52ekDo2UceM9zRv9Gs6oe06MZzdxVr0c3eaGNWRN+e6FvxcnoFGnWLJl1J
         gzJUfY1XEEoTiMSLe+VwzZIqy8U6KPzfWkiv9SznlAyU5z7BI/V0vRrhI0yOYxmv4/cl
         j8bcTTDmFXLlu6wj3oweTi/+mi9RQN5i93x6pSTbrH1eyMLxYELAFATc564iF1onffBz
         VbUg7Za5KtiaIDbbmaOffyLR+f59UIhdDCbFv8dNUqqXFi8YWn3U5cTS+jhp3uQBBxTY
         +Gm2bLLVwNsuq7pWfylWB05vu0QLuQ/BTkuLFv/+Eo2IcShVLbopjTXhpr148eP+Ism1
         2/gA==
X-Gm-Message-State: AOJu0YxYMtZxbbjdWhZA+SuoUkUmu3z8S4pn/31HBNSuv3eqoUYwAwwp
        oLHrB8oG8kyesub8doIDoKR7KZAg7xfSQMlGzxG/UQ==
X-Google-Smtp-Source: AGHT+IFEj1d/zLkTSnTJxcMNp0WFx5qH7ufZ2AUcgoEC8MazG17uK9uacSlHh7g+oQWF1dkQvaBGJsNH94VyLR3Ch7Q=
X-Received: by 2002:adf:e053:0:b0:333:2fd2:2f08 with SMTP id
 w19-20020adfe053000000b003332fd22f08mr4447760wrh.129.1702548357302; Thu, 14
 Dec 2023 02:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20231211172504.058ad6b6@canb.auug.org.au> <9f0763c0-8175-4160-b72e-8e9e3aee42f8@infradead.org>
 <CAHVXubjbVxEvL01uu_Cm-_R8oLddwc6fUaQYE_Bc+sBThTmvWA@mail.gmail.com>
 <20231213-excretory-ashen-03a34f3a4c90@spud> <CAHVXubga7Q6X-zW_qztS2V_Z8TBp0gm2UV_GAj2O-5nn-_yCyA@mail.gmail.com>
In-Reply-To: <CAHVXubga7Q6X-zW_qztS2V_Z8TBp0gm2UV_GAj2O-5nn-_yCyA@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 14 Dec 2023 11:05:46 +0100
Message-ID: <CAHVXubhN3GQ1hu7uVof2RSByVzAGCeT_-_YvNpgaDOKuZL2fBw@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 11 (riscv32: patch.c)
To:     Conor Dooley <conor@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 2:33=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Wed, Dec 13, 2023 at 1:57=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, Dec 12, 2023 at 09:01:17AM +0100, Alexandre Ghiti wrote:
> > > Hi Randy,
> > >
> > > On Mon, Dec 11, 2023 at 10:17=E2=80=AFPM Randy Dunlap <rdunlap@infrad=
ead.org> wrote:
> > > >
> > > >
> > > >
> > > > On 12/10/23 22:25, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > >
> > > > > Changes since 20231208:
> > > > >
> > > >
> > > > on riscv32:
> > > >
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `.L4':
> > > > patch.c:(.text+0xbe): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0xc2): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `.L12':
> > > > patch.c:(.text+0xd2): undefined reference to `__exittext_end'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0xd6): undefined reference to `__exittext_end'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `.L15':
> > > > patch.c:(.text+0x1ea): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `.L7':
> > > > patch.c:(.text+0x1ee): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0x1fe): undefined reference to `__exittext_end'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `.L22':
> > > > patch.c:(.text+0x202): undefined reference to `__exittext_end'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `__patch_insn_write':
> > > > patch.c:(.text+0x410): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0x414): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0x424): undefined reference to `__exittext_end'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0x428): undefined reference to `__exittext_end'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `.L46':
> > > > patch.c:(.text+0x53c): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0x540): undefined reference to `__exittext_begin'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: arch/riscv/kernel/patch.o: in function `.L48':
> > > > patch.c:(.text+0x550): undefined reference to `__exittext_end'
> > > > /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld=
: patch.c:(.text+0x554): undefined reference to `__exittext_end'
> > > >
> > > >
> > > > Full randconfig file is attached.
> > >
> > > We can ignore this one as CONFIG_XIP is enabled and we agreed at LPC
> > > that I'll remove this soon.
> >
> > I don't think we can (even if people hadn't sent patches yesterday for
> > XIP) act as if XIP being removed is a foregone conclusion.
>
> Ok, the fix is easy enough for me to send it right now, so I'll fix that =
:)

The fix is here
https://patchwork.kernel.org/project/linux-riscv/patch/20231214091926.20343=
9-1-alexghiti@rivosinc.com/
and I asked Palmer to replace the v1 he already had in -fixes with
this new version, hopefully it will land in rc6.

Thanks,

Alex
