Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9048C800CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379082AbjLAN5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLAN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:57:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691EFBC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:57:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54b532b261bso2663142a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701439062; x=1702043862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n/qv2LCwI00fHFBUjE06/h0++7Sj0TWAFXvAyHTE2s=;
        b=EyAcB0PSZcfjT2K6+eEuMxIj6OH7virM0tRIUdfKyhy753ALN1CTTOEAjlil5n4gnh
         noByHM6O1sN9Wo61PCTzMTxM4mAhNr5RDR1Oo19hjy1CkLoGlw2T6KtFwyPj+y2rS9rc
         /lafKaAYoUyC6g/54Z1AOh3YNCLooURaznLj9cf8TuT0HfEkN5fBgFhAQD0SokPD0Ve+
         L3LcVRfdlxYABKN8RJJxV6LkhwFH/JgbtknbSFOsvA6dmhTdog0P1qNZXcjkx5P8JBoO
         b766bxVUwwYbP+xr3CI6bOjHXn3Kqjo81dapbY6Jb4THbAFNkhiH8TaWxnkiiH4tEzO0
         ZD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701439062; x=1702043862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5n/qv2LCwI00fHFBUjE06/h0++7Sj0TWAFXvAyHTE2s=;
        b=p9m2ZTRfdbgwCjiU8Sp/rfbpbyMuYIb2pz6hyaya9a9VIfipOkFBYAxt0dGQheniKO
         8O4QVZ1JoEXpjYE/8WM9fp26PsP1iHCBz1/xgQzt8KkAJuFjxKSoaznUmeXPSkFRaqbj
         nOkptQrfP96km26ozrN/ah7Af66VTvKxFS4XHo0c9nY/16bxgbb3MrY7LbI2fMAkwKgV
         RCdgu+mav+97FOtvfe/0JDDIVUb8nGZ2DE/t+TOuV0+THAjguBh4KXdZNhMLYAhw+Pr6
         /+kz5r1RGdPXwUNPP9QB/C7pengpYYML2CRkfrWwrQ8NOjB2iB/FmaWkfQ5WyxvuGQ2j
         LBAQ==
X-Gm-Message-State: AOJu0Yw2KDVxAZvibROjMAw2Xh7U3xmJM/mUCEtobfY6cmqqeZvfaOhG
        GmmMHTmws53GkF2cZa6dGJ+MANGn3Zahlf1z7wE=
X-Google-Smtp-Source: AGHT+IFfkOWyhwcAkAnHUnlFEmYBTN9VWeBVAvneasImqWYtB0+3VBTv+Y0p8zOZF+Yrv8OmgdUOw+emPLOO3ekbsKk=
X-Received: by 2002:a50:aa84:0:b0:54c:4837:81f1 with SMTP id
 q4-20020a50aa84000000b0054c483781f1mr845192edc.66.1701439061559; Fri, 01 Dec
 2023 05:57:41 -0800 (PST)
MIME-Version: 1.0
References: <202310080853.UhMe5iWa-lkp@intel.com>
In-Reply-To: <202310080853.UhMe5iWa-lkp@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 1 Dec 2023 14:57:29 +0100
Message-ID: <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
Subject: Re: [tip:x86/percpu 12/12] arch/x86/include/asm/preempt.h:27:55:
 sparse: sparse: incompatible types for operation (&):
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 2:43=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/p=
ercpu
> head:   ca4256348660cb2162668ec3d13d1f921d05374a
> commit: ca4256348660cb2162668ec3d13d1f921d05374a [12/12] x86/percpu: Use =
C for percpu read/write accessors
> config: x86_64-randconfig-122-20231007 (https://download.01.org/0day-ci/a=
rchive/20231008/202310080853.UhMe5iWa-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231008/202310080853.UhMe5iWa-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    kernel/bpf/percpu_freelist.c: note: in included file (through arch/x86=
/include/asm/preempt.h, include/linux/preempt.h, include/linux/spinlock.h, =
...):
>    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: Expected ) at en=
d of cast operator
>    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: got __seg_gs
>    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: Expected ) at en=
d of cast operator
>    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: got __seg_gs

sparse is too strict here. The following code is perfectly legal:

--cut here--
int __seg_gs foo;

int bar (int *pcp)
{
  return *(typeof (*pcp) __seg_gs *)(unsigned long)(pcp);
}
--cut here--

$ gcc -O2 -S -Wextra -Wall test.c
$
$ sparse test.c
test.c:1:14: error: Expected ; at end of declaration
test.c:1:14: error: got foo
test.c:5:26: error: Expected ) at end of cast operator
test.c:5:26: error: got __seg_gs
$

Uros.
