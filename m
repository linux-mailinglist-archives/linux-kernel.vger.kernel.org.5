Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD97A0BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbjINRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjINRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:41:45 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC631FDA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:41:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-65618fb71a2so6340506d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694713300; x=1695318100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/EpZ1GWHc4x/nG0Kx2s7S+DQIRkgyoK7g5ng753eM0=;
        b=otj8EEYOTxzY2J8tIJeEUFhUCbiBA/COTW9HfzlGmihnfPeqL3HjGZOtCgEc9PtDZX
         CmBCSIiABEKuyapEGIXbZz8wD3mJoG4A0mVDDXckiTKqWqKjpNvMcKUBHWNJ+nrlPdis
         pWoQunUKK1i1MhVhmDHocB5hfSs4oNs9MC14B5L8p7nMa63C3jL3DEYbnpYa8UOJDxNn
         2R4BAXMX78OILx+2/hPg5d2Nqhhh09lstIHWezNXcoBY6OI6cw/fuDUhvzyO9mc/Xi1G
         IH/jO3vP2ijJgny4tY/2G3LtTbiGum+rVUpzIyr42k7aE/kjiuss44nWMDyGFci98AJV
         ihYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694713300; x=1695318100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/EpZ1GWHc4x/nG0Kx2s7S+DQIRkgyoK7g5ng753eM0=;
        b=iN1BykGtPFtdYHGXeGFPXAB4rzpHyc9TCZiv7sEkj1TOJXNLUtsA8diAHVrG84YHFK
         RzIbbFH7/RNPAAKJzAbctDldDAA23/aOretOlaLWbRSWoz/SJUl3kuidrW2Yu/F4tnNf
         +VhJTX1/eOvij6seC7BF2x5vHcLZ7ewvf/wmzu4FKmLBSYvOvrzT7wjoMmTNj/HkYBwH
         eo+3EutcHry5ZUiWFFpF2ikA7d32hHBa6F6ah7Yy6wwM8nlUfIiOKK3KrLqvkxSdpAg/
         Xkuu6wCx41/HhTyPY/RiLs1KtlT67CHCLkSa97sW3jK2vpjT0vbzUYX5vf04a8l4BusL
         uxcA==
X-Gm-Message-State: AOJu0Yx87Z1BY7JSI21mlHuN6zlfGSUl9G3+z7ATDXOt0b01psy7LIbi
        QzSfUO9n8BQJHhNHpHKu2Z0NfVh+Iv3+T+o23lPX6w==
X-Google-Smtp-Source: AGHT+IGrRQUd9vGZgOD7XJuFKtsEk06aXUbUmblrVes6BRVOnec7PqkFsbqyvZZKUVdAqUve111n932fyZemZTPEoJE=
X-Received: by 2002:a0c:cc03:0:b0:656:2f3f:852f with SMTP id
 r3-20020a0ccc03000000b006562f3f852fmr1005291qvk.28.1694713300087; Thu, 14 Sep
 2023 10:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <202309141433.6gzJPSYA-lkp@intel.com>
In-Reply-To: <202309141433.6gzJPSYA-lkp@intel.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 14 Sep 2023 10:41:01 -0700
Message-ID: <CABCJKuck=4TKdTjKqu6Qd6ZhqrtS+=a=zOz+G=vFuiMoyfXerA@mail.gmail.com>
Subject: Re: ld.lld: error: relocation R_RISCV_HI20 cannot be used against
 symbol '.L.str.6'; recompile with -fPIC
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:14=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Sami,
>
> FYI, the error/warning was bisected to this commit, please ignore it if i=
t's irrelevant.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   aed8aee11130a954356200afa3f1b8753e8a9482
> commit: 74f8fc31feb4b756814ec0720f48ccdc1175f774 riscv: Allow CONFIG_CFI_=
CLANG to be selected
> date:   3 weeks ago
> config: riscv-randconfig-r002-20230912 (https://download.01.org/0day-ci/a=
rchive/20230914/202309141433.6gzJPSYA-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230914/202309141433.6gzJPSYA-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309141433.6gzJPSYA-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '=
.L.str.6'; recompile with -fPIC
>    >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
>    >>> referenced by errata.c:94 (arch/riscv/errata/sifive/errata.c:94)
>    >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_pat=
ch_func) in archive vmlinux.a
> --
> >> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol=
 '.L.str.6'; recompile with -fPIC
>    >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
>    >>> referenced by errata.c:94 (arch/riscv/errata/sifive/errata.c:94)
>    >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_pat=
ch_func) in archive vmlinux.a

This randconfig builds a fairly large 64-bit kernel with
CONFIG_CMODEL_MEDLOW=3Dy. Switching to CMODEL_MEDANY fixed the linker
error for me, although the laterr BTFIDS step still fails:

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol bpf_cpumask
FAILED elf_update(WRITE): no error
make[3]: *** [../scripts/Makefile.vmlinux:36: vmlinux] Error 255

64-bit defconfig with CFI+CMODEL_MEDLOW works just fine and I can also
reproduce the linker errors by building allyesconfig+CMODEL_MEDLOW
without CFI, for example, so I assume the build failure with this
config is expected. Is there anything we should do here?

Sami
