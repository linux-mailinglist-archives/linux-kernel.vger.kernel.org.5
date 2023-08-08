Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B27736C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjHHCfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjHHCfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:35:18 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC2135;
        Mon,  7 Aug 2023 19:35:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63d0d38ff97so23295326d6.1;
        Mon, 07 Aug 2023 19:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691462117; x=1692066917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l09UiqmB32dH8CnL4PK01BLznGpgMmgVlMI1USmN8Rg=;
        b=c9QI2THwc6V0wze9ZFpZCtzey7oEy+avYyiO1ZSj+rxT5UZVrJ6yjmOHxyxilXffNT
         mDwElTYQX0wq5aGhCS4dk68BpQB02GaB6zYN8Lmu1rsyit1Y5PzRQRA6Utdhp0swbavg
         pDtF5xMcKDLLKLO7Q/2uS4bi/zm/e0yOyLYUjA88Ai41ddn/vqKnbO5tvFTGbmFIn7VX
         SaOZgtipltZLLJUXH+pGcXodWoCqzIkk/igia3GtqM1oxA6sauPtbVVLqsdcjyWhx2RP
         wRMKhj8fzkQQfxU/maTJzqElQJM1pS6JybYLFB+QcBw2RbDBItZiJPLhg8Bgd4+KuveG
         wTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462117; x=1692066917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l09UiqmB32dH8CnL4PK01BLznGpgMmgVlMI1USmN8Rg=;
        b=L7fOYsdF1wLYlRchCG5tn20ezc+ImPhluoNh+wwHMkkccFQEO176TlX29o+ydd7cei
         55zs7oTKfWefYAmUpiQSBmJtG8oNXrRhVeX5aNF4GypY1c2/YSXwfJadSQ/tqdHbHoia
         F7ekyHOLwhEiXplKZBnrQFw6LBFS5f+f5Nk6FL/EQ/NDCnzP+fn7usdweO/cZGtoWR4B
         sKQbOI/TE8CehVTHxK3MVkfL8UTIsfSLBiXfO7nlH/dOx9SUzOXeupyibNY9k4JXDf8f
         aUR/I7TFjQQZHE32czE2esnoYhvxG95Fc2y/NpMIc0Jfyr8lneoTtaE+AXvlOKytfBls
         n1wQ==
X-Gm-Message-State: AOJu0YwycIK2rr9ccwr8Q3ycGjr7W4poYKXVNDtkJHnQauUnXSVoGiAR
        hqWBNDhG8EtWTXEGD5PgD0T02BwqOtVD8lTp0oY=
X-Google-Smtp-Source: AGHT+IFDMtGJ80F0xqjZy6+OH+jLD7M4yo1YVM8luHYwGA+W36SwN22ALuxgICMveRdgK+WgS0Rc+/jP4c2v//7fyj8=
X-Received: by 2002:a0c:9d49:0:b0:635:ec47:bfb3 with SMTP id
 n9-20020a0c9d49000000b00635ec47bfb3mr11647255qvf.0.1691462116794; Mon, 07 Aug
 2023 19:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230807142238.50616687@canb.auug.org.au> <ZNB3PXgIBvJhiEu1@liuwe-devbox-debian-v2>
In-Reply-To: <ZNB3PXgIBvJhiEu1@liuwe-devbox-debian-v2>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Mon, 7 Aug 2023 19:35:05 -0700
Message-ID: <CAA42JLZbiXOukBNup8DyrBNivwvezvFdWiZ0CVJf03mSo0F8PA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the hyperv tree
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Tianyu.Lan@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 10:39=E2=80=AFPM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Mon, Aug 07, 2023 at 02:22:38PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the hyperv tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/pci/controller/pci-hyperv.o: warning: objtool: .altinstr_replac=
ement+0x0: weirdly overlapping alternative! 11 !=3D 6
> > drivers/hv/hv_balloon.o: warning: objtool: .altinstr_replacement+0x0: w=
eirdly overlapping alternative! 11 !=3D 6
> > drivers/hv/hv_vmbus.o: warning: objtool: .altinstr_replacement+0x3: wei=
rdly overlapping alternative! 10 !=3D 5
> > vmlinux.o: warning: objtool: .altinstr_replacement+0x633: weirdly overl=
apping alternative! 11 !=3D 6
> > incomplete ORC unwind tables in file: vmlinux
> > Failed to sort kernel tables
> >
> > I have no idea what caused this.

Hi Stephen,
My kernel source was checked out from the Hyper-V tree's hyperv-next
branch last Friday, which had Tianyu's 8 patches.

I'm able to repro the same build failure in a Ubuntu 22.04 VM with
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4:

I run the below commands:
make mrproper
make allmodconfig
make -j128
make -j128

...
  LD [M]  net/qrtr/qrtr-tun.ko
  LD [M]  net/qrtr/qrtr-mhi.ko
  LD [M]  virt/lib/irqbypass.ko
  LD [M]  arch/x86/video/fbdev.ko
make: *** [Makefile:234: __sub-make] Error 2

make -j128
  DESCEND objtool
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  CHK     kernel/kheaders_data.tar.xz
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  NM      System.map
  SORTTAB vmlinux
incomplete ORC unwind tables in file: vmlinux
Failed to sort kernel tables
make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Error 1
make[2]: *** Deleting file 'vmlinux'
make[1]: *** [/opt/linux-next/Makefile:1250: vmlinux] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:234: __sub-make] Error 2

If I revert Tianyu's patches by "git diff v6.5-rc4 | patch -Rp1",
the build can succeed.

If I apply the the patches, I get the same failure:

drivers/hv/hv_balloon.o: warning: objtool: .altinstr_replacement+0x0:
weirdly overlapping alternative! 11 !=3D 6
...
drivers/pci/controller/pci-hyperv.o: warning: objtool:
.altinstr_replacement+0x0: weirdly overlapping alternative! 11 !=3D 6
...
drivers/hv/hv_vmbus.o: warning: objtool: .altinstr_replacement+0x3:
weirdly overlapping alternative! 10 !=3D 5
...
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
vmlinux.o: warning: objtool: .altinstr_replacement+0x633: weirdly
overlapping alternative! 11 !=3D 6
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  GEN     .vmlinux.objs
  MODPOST Module.symvers
  CC      .vmlinux.export.o
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  NM      System.map
  SORTTAB vmlinux
incomplete ORC unwind tables in file: vmlinux
Failed to sort kernel tables
make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Error 1
make[2]: *** Deleting file 'vmlinux'
make[1]: *** [/opt/linux-next/Makefile:1250: vmlinux] Error 2
make[1]: *** Waiting for unfinished jobs....
...
make: *** [Makefile:234: __sub-make] Error 2

It turns out that I already made a fix
https://github.com/dcui/linux/commit/c4db45f6256248435b2a303b264ecbb41320c4=
1d
which can fix the build failure and fix a crash issue (see
https://lwn.net/ml/linux-kernel/SA1PR21MB1335A21D5D037FE88D9CF820BF0EA@SA1P=
R21MB1335.namprd21.prod.outlook.com/
)

Thanks,
Dexuan

> /me scratches head.
>
> > I have used the hyperv tree from next-20230804 for today.
>
> I've reverted that series from my tree. Thanks for the heads up.
>
> Thanks,
> Wei.
