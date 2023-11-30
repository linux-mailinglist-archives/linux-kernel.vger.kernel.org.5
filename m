Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60697FF91E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjK3SLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3SLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:11:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0110D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:11:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso1073205b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701367903; x=1701972703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNgtprTXnSXEG7sYtWfKlL6JyfLEgg9nzEegbfWpJTI=;
        b=OgpWtBgLwsGC4QZcmS4I1pyZnEPrkll2QmpBPz7DyRmAeHs/4T9xIjA+Ccq6QHBE79
         3yHqYiDoVjLYaYlNleBQBEPC5e95SA8dv+FIxlnaeNM6rErbDjt45DuAYvtdyFp3rBct
         rf9tGL82YE7Li2m8n+Womao6HmmUC76pRp09NwYQOTaZca9g3NgcUDAUVEiAzITsJ3Iy
         q8tLvUHED+IUd+ruqd+bp2vptcKFAafJ7+G6XjhUJZ5p72XLUue8EY5nhloz2msujfiR
         8yRjUJVOwkTUxUJteGiiWf59kvCSNp6slYc8JOtZZwn7vIyh48flRk/UzAUgTytXCE5G
         e1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367903; x=1701972703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNgtprTXnSXEG7sYtWfKlL6JyfLEgg9nzEegbfWpJTI=;
        b=dbh8l7eBE1vVKOj8kSMZ7jCHSym9n6w86cDTwKzVYRzIywgDwLi/nf3hg9TJ9MLCcV
         zLdvsDq9tmcQNcrZjfVMQ0KRImApcDF0rktkHmL0+7JI8vt6m/AQmc68X9RyRkEr7oUx
         qc6p35nzsIb/Gx0KEwaU3LOx7uyDq/+eDf7ltgLE/0HKE/6tXedo3Fb67fG7Dg5hdunP
         nLxsGZammE+4ogwuqDpZG+kOZNOD3BPdfpfeHm0geSraydL8O2LABISZxcVCvkiWxMmP
         CQjYQCAz34kvjDVAma5BJH7RT76PAYsGy4Z2FrCL6tpKbupc/DxZW390eg1pZ1AvNcLN
         auZA==
X-Gm-Message-State: AOJu0Yz1MSZHxTd7uCRVwgBkDWbtKg4Hxpwk8N5BVrdTT/ycF8C//0/4
        M3OAoWoSl+YLiwL6eNlp6c+L66xZEnBJnSwf0oi3Lw==
X-Google-Smtp-Source: AGHT+IGedkIyqsw0Qgh2ilKDtIK7r8EKT6xybDMBQyF5e/OvFulhnXxuxRY/6wWfVwGPFjlz9iPl2iAC/9bJsMESWfs=
X-Received: by 2002:a05:6a00:35ce:b0:6cb:8c91:682 with SMTP id
 dc14-20020a056a0035ce00b006cb8c910682mr26682257pfb.29.1701367902766; Thu, 30
 Nov 2023 10:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20231130162133.035359406@linuxfoundation.org> <CAEUSe7-yhmQkr1iK-82+Sc_YpVtWUQhuKoazoXHF_3oP9XTt4Q@mail.gmail.com>
 <e2e50813-79ba-4c84-b6ae-6885cbef54ab@roeck-us.net>
In-Reply-To: <e2e50813-79ba-4c84-b6ae-6885cbef54ab@roeck-us.net>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 30 Nov 2023 12:11:31 -0600
Message-ID: <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        flaniel@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, 30 Nov 2023 at 11:44, Guenter Roeck <linux@roeck-us.net> wrote:
> On 11/30/23 09:21, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > Lots of failures everywhere:
> > * clang-17-lkftconfig                 arm64
> > * clang-17-lkftconfig                 arm64
> > * clang-17-lkftconfig                 arm64
> > * clang-lkftconfig                    arm64
> > * clang-lkftconfig                    arm
> > * clang-lkftconfig                    i386
> > * clang-lkftconfig                    x86_64
> > * gcc-12-lkftconfig                   arm64
> > * gcc-12-lkftconfig                   arm
> > * gcc-12-lkftconfig                   i386
> > * gcc-12-lkftconfig                   x86_64
> > * gcc-12-lkftconfig-64k_page_size     arm64
> > * gcc-12-lkftconfig-64k_page_size     arm64
> > * gcc-12-lkftconfig-armv8_features    arm64
> > * gcc-12-lkftconfig-debug             arm64
> > * gcc-12-lkftconfig-debug             arm64
> > * gcc-12-lkftconfig-debug             arm
> > * gcc-12-lkftconfig-debug             i386
> > * gcc-12-lkftconfig-debug             x86_64
> > * gcc-12-lkftconfig-debug-kmemleak    arm64
> > * gcc-12-lkftconfig-debug-kmemleak    arm
> > * gcc-12-lkftconfig-debug-kmemleak    i386
> > * gcc-12-lkftconfig-debug-kmemleak    x86_64
> > * gcc-12-lkftconfig-devicetree        arm64
> > * gcc-12-lkftconfig-kasan             arm64
> > * gcc-12-lkftconfig-kasan             arm64
> > * gcc-12-lkftconfig-kasan             x86_64
> > * gcc-12-lkftconfig-kselftest         arm64
> > * gcc-12-lkftconfig-kselftest-kernel  arm64
> > * gcc-12-lkftconfig-kselftest-kernel  arm
> > * gcc-12-lkftconfig-kselftest-kernel  i386
> > * gcc-12-lkftconfig-kunit             arm64
> > * gcc-12-lkftconfig-kunit             arm64
> > * gcc-12-lkftconfig-kunit             arm
> > * gcc-12-lkftconfig-kunit             i386
> > * gcc-12-lkftconfig-kunit             x86_64
> > * gcc-12-lkftconfig-libgpiod          arm64
> > * gcc-12-lkftconfig-libgpiod          arm
> > * gcc-12-lkftconfig-libgpiod          i386
> > * gcc-12-lkftconfig-libgpiod          x86_64
> > * gcc-12-lkftconfig-perf              arm64
> > * gcc-12-lkftconfig-perf-kernel       arm64
> > * gcc-12-lkftconfig-perf-kernel       arm
> > * gcc-12-lkftconfig-perf-kernel       i386
> > * gcc-12-lkftconfig-perf-kernel       x86_64
> > * gcc-12-lkftconfig-rcutorture        arm64
> > * gcc-12-lkftconfig-rcutorture        arm64
> > * gcc-12-lkftconfig-rcutorture        arm
> > * gcc-12-lkftconfig-rcutorture        i386
> > * gcc-12-lkftconfig-rcutorture        x86_64
> >
> > It's essentially this:
> >
> > -----8<-----
> >    make --silent --keep-going --jobs=3D8
> > O=3D/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=3Dx86_64 SRCARCH=
=3Dx86
> > CROSS_COMPILE=3Dx86_64-linux-gnu- 'CC=3Dsccache x86_64-linux-gnu-gcc'
> > 'HOSTCC=3Dsccache gcc'
> >    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x51:
> > unreachable instruction
> >    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
> > `__trace_kprobe_create':
> >    trace_kprobe.c:(.text+0x2f39): undefined reference to
> > `kallsyms_on_each_symbol'
> >    x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
> > `create_local_trace_kprobe':
> >    trace_kprobe.c:(.text+0x384b): undefined reference to
> > `kallsyms_on_each_symbol'
> >    make[1]: *** [/builds/linux/Makefile:1227: vmlinux] Error 1
> >    make[1]: Target '__all' not remade because of errors.
> >    make: *** [Makefile:226: __sub-make] Error 2
> >    make: Target '__all' not remade because of errors.
> > ----->8-----
> >
> > It only affects 5.15. Bisection in progress.
>
> I guess it will point to
>
> >> Francis Laniel <flaniel@linux.microsoft.com>
> >>      tracing/kprobes: Return EADDRNOTAVAIL when func matches several s=
ymbols

It sure did!:

  commit 7b4375c36a4c0e1b4b97ccbcdd427db5a460e04f
  Author: Francis Laniel <flaniel@linux.microsoft.com>
  Date:   Fri Oct 20 13:42:49 2023 +0300

      tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbo=
ls

      commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.

Reverting that commit made the build pass again.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
