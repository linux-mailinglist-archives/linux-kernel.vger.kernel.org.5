Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F297FB9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbjK1Lv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjK1LvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:51:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92423D59
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:51:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2839c113cbcso4277429a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701172290; x=1701777090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86YcOJ2RQyi48TWuQ5HdsvkloxVpkC018HUuY5xlNz4=;
        b=TZmOGNxHCkCRJE+0xCkBTPjlJnxYtpgp0RzCsNfX7mgOp7mtjhOiJ75BErFWtaGNf8
         HWx78IlvbuHcMZUYjfvs5fo/nimgs3D8CKUhKFEO0cV23UjSpAn6LQg4cX/rgPDiHmcw
         HOImhpviZzDScZzouxavaVKuQhs87EcaBQf/VP9kDdLejeONgzqIrFwUF6VohC30Zpd6
         dc/ozPyDGqjhHNqlhydXFM6PGLMKyN0Es7flXWEI+Fno1KdlEemTEi2/a0nlLH25h6fe
         qTZT52ZpUHiEu1Nr+FJL0BESfPpdhAF7k13cAY4qTO7lqEqgwSbmce1WmXTuM28xCV6x
         bRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172290; x=1701777090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86YcOJ2RQyi48TWuQ5HdsvkloxVpkC018HUuY5xlNz4=;
        b=BRGhTBKvIqEzOwb5AnGZensEA/BKxIrnr7ie5mvZbA/XaeqYMOEnJw7Kfj1cAJaAUP
         d1a9aw/J6QPgN7FsWeTPTBsBPeKlxPGo5banUitbDo7igFfW0D9+kue8LDYVqStGeL9N
         Qmx0fLNmmb9nRfbCc56EQTcdeVGIRF5P3zuowZe9SAzgKfpwizS+nFZY1qORKk7oEiI9
         qEMeguicYu/89nUnZc8CBOdulJKFUqUonjrFXsF45SM9v2cLW5dJgtLM0DB6CmuD2kGI
         DZ3fBL/YHw2QKMriasel3JYVu9TRnCGSpSL8LCfsraWO94tHq3ODw7JGPpqn4avaZ4Nz
         jSzg==
X-Gm-Message-State: AOJu0YxhRm81wnuxp7v93GSuQJyROaG8z+fqaWDi1VvrO0Na+Uf5pJH7
        rpbJLuZVB9gC9LqP686yOvKEmLY+jsEv0GLPUSHCjQ==
X-Google-Smtp-Source: AGHT+IGmJKRteYV5UGlTJ7ecqKXrP9sLP7hWcJqjHvzwcLS3pfOQtgmuZNcPIe9Ge6NrNkjpEKxoTtQ2N7C4b8WjL7g=
X-Received: by 2002:a17:90b:3804:b0:285:d6a2:3bf9 with SMTP id
 mq4-20020a17090b380400b00285d6a23bf9mr6643833pjb.11.1701172290035; Tue, 28
 Nov 2023 03:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20231128055248.659808-1-bhe@redhat.com>
In-Reply-To: <20231128055248.659808-1-bhe@redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Tue, 28 Nov 2023 11:51:19 +0000
Message-ID: <CALrw=nG0AhxEmx39bnvM+CKh8bFijvsAPGU3CFY5Top0prS3yw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/base/cpu: crash data showing should depends on KEXEC_CORE
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, eric_devolder@yahoo.com,
        agordeev@linux.ibm.com, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 5:53=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> After commit 88a6f8994421 ("crash: memory and CPU hotplug sysfs
> attributes"), on x86_64, if only below kernel configs related to kdump
> are set, compiling error are triggered.
>
> ----
> CONFIG_CRASH_CORE=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_CRASH_HOTPLUG=3Dy
> ------
>
> ------------------------------------------------------
> drivers/base/cpu.c: In function =E2=80=98crash_hotplug_show=E2=80=99:
> drivers/base/cpu.c:309:40: error: implicit declaration of function =E2=80=
=98crash_hotplug_cpu_support=E2=80=99; did you mean =E2=80=98crash_hotplug_=
show=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>   309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support(=
));
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                        crash_hotplug_show
> cc1: some warnings being treated as errors
> ------------------------------------------------------
>
> CONFIG_KEXEC is used to enable kexec_load interface, the
> crash_notes/crash_notes_size/crash_hotplug showing depends on
> CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
>
> Fix it now.
>
> Fixes: commit 88a6f8994421 ("crash: memory and CPU hotplug sysfs attribut=
es")
> Signed-off-by: Baoquan He <bhe@redhat.com>

Tested-by: Ignat Korchagin <ignat@cloudflare.com> # compile-time only
for x86 and arm

> ---
>  drivers/base/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 9ea22e165acd..548491de818e 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -144,7 +144,7 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_releas=
e_store);
>  #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
>  #endif /* CONFIG_HOTPLUG_CPU */
>
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>  #include <linux/kexec.h>
>
>  static ssize_t crash_notes_show(struct device *dev,
> @@ -189,14 +189,14 @@ static const struct attribute_group crash_note_cpu_=
attr_group =3D {
>  #endif
>
>  static const struct attribute_group *common_cpu_attr_groups[] =3D {
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>         &crash_note_cpu_attr_group,
>  #endif
>         NULL
>  };
>
>  static const struct attribute_group *hotplugable_cpu_attr_groups[] =3D {
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>         &crash_note_cpu_attr_group,
>  #endif
>         NULL
> --
> 2.41.0
>
