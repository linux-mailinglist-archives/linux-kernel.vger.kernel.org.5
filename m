Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8F80E4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjLLHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:25:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701DA6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:25:07 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3332e351670so4832020f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702365906; x=1702970706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B27xiFe5ZInauBvN5IV6bsU1xf8ZxSkrwGh2mtgiMg=;
        b=SSgLdLihQV73VPxiFczii2OdFuOwresxy1fIXyZ4qHoptUMEAqfrUz+ylKSsPw1eT8
         QTSjcp7Z9GlWDXq/kIzCBvFlXrE4dZgxYn/VlXQ21jI+Yj3Amu0Qp95tBRhjvIU9wHKI
         MmRra8peARb+jbyrCXavHT9kVo204k6P5tWJbl3W6Zb3PBmTYNnPP0VuDP/k+N0+K6ij
         GLGE7kp5VHHGaNxbPv5f4kKwQmDjP7hBeOTh7YHMqRO0isNKRqZ218h6vT/ZR0ej6VlM
         T2NEX/oayh3Xuv3j6Vjrx15wO04MdkmvWfpa0j8vN4gsfBDhYYg8n12STLif5o3cZDVf
         NYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702365906; x=1702970706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/B27xiFe5ZInauBvN5IV6bsU1xf8ZxSkrwGh2mtgiMg=;
        b=j96btGBdYHOZoIuu4zs9KT1VQAvqhVGazJwjimk5oxidI5Otx9vPBz0w20NDPDVufx
         /8rbzvjsLvHTSvf2Ec/CgN87JAZgz7c02LoxugHO97DqzjQEGs3ulgopHWL2LP6mJ+en
         EPeT6hI37Rke5snNkibHrqpT9v9wvqHJPK/19dHITFrCthiKLQmp43/8gHg5jwRJR01f
         u8PPjNqh9ghkRwBO5RIRUpKfpRvh1oKzueszF8kyd0dFB4OWvEdLnM2fH58OlDASGIKp
         U604oyWIjG/7EYZB6Ag3XDs/01ibC+HYwYYIequyria7yQQdQ1jO0y9sosDuGHPeUJKE
         l4EQ==
X-Gm-Message-State: AOJu0Yzosr+6I0wgEnVR10zM/j7/5dH5xY0G7ptzsu+HlOjDV/HPjyC1
        mBugBWEuQUxu2I/c3axBe96efrGE8uhJNdkNOYJ+jfCP6/lZay/T16s=
X-Google-Smtp-Source: AGHT+IH1Fb9rddRA5/WR8NmRfrJizAad5afbmusjY3Kdfxu/oah8d3lJ45zcFFksR2gvQqvOR8i0RRi3MOJa5cw/QqE=
X-Received: by 2002:a5d:6205:0:b0:333:2fd2:7678 with SMTP id
 y5-20020a5d6205000000b003332fd27678mr1229203wru.105.1702365905783; Mon, 11
 Dec 2023 23:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20231211172504.058ad6b6@canb.auug.org.au> <846f4d8a-16ad-4ce2-9bcc-34e03f057421@infradead.org>
In-Reply-To: <846f4d8a-16ad-4ce2-9bcc-34e03f057421@infradead.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 12 Dec 2023 08:24:54 +0100
Message-ID: <CAHVXubitXvkWmvHd7JXs5kTZC4L2VvOD2B_ue3D5hUhevOpwfA@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 11 (drivers/perf/riscv_pmu_sbi.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Dec 11, 2023 at 10:22=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 12/10/23 22:25, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20231208:
> >
>
> on riscv32:
>
> ../drivers/perf/riscv_pmu_sbi.c:1015:35: error: initialization of 'int (*=
)(const struct ctl_table *, int,  void *, size_t *, loff_t *)' {aka 'int (*=
)(const struct ctl_table *, int,  void *, unsigned int *, long long int *)'=
} from incompatible pointer type 'int (*)(struct ctl_table *, int,  void *,=
 size_t *, loff_t *)' {aka 'int (*)(struct ctl_table *, int,  void *, unsig=
ned int *, long long int *)'} [-Werror=3Dincompatible-pointer-types]
>  1015 |                 .proc_handler   =3D riscv_pmu_proc_user_access_ha=
ndler,
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> ../drivers/perf/riscv_pmu_sbi.c:1015:35: note: (near initialization for '=
sbi_pmu_sysctl_table[0].proc_handler')
>
>
>
> Full randconfig file is attached.

I already sent a fix for that here:
https://lore.kernel.org/all/20231207083512.51792-1-alexghiti@rivosinc.com/

Thanks!

Alex

>
>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html
