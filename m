Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81577FD184
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjK2I7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2I7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:59:49 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800412C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:59:54 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4644a63032eso129546137.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701248394; x=1701853194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBUUYQft2seUnlUM4OmCBERBIGRIw1M9PaGf8BE6/Yo=;
        b=PlpJQXgCUWQD7ptz1svyvZ3i/H3+PiIBCwvm2Zft6MQeQvcApLYcP/stVhOI05rC/f
         3rTI/YUG22fXtmbUDH9xz+UuCeL6y/gRZrvSAL0V7yuv4hOPJFFyUv/4AOngYZ47FoyZ
         FwBzwkOzGHz9KYO+lviSpkbYjKz7sWbgkvj3soXovmq59ieo5TesO45eHOQAyReKB1ZR
         /quSCDCOqtElC20yNgf19wXDW7MC3Wq9xvL25/DERlWisi0jit9C5AHzl2pkEk6OJRK6
         p0cWD05HRkGfS7hMNf0LsPQPM+poFK6hM0rhwZtHouwrxmSxwPKGVbKSTlWiSG4N2sVj
         d8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248394; x=1701853194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBUUYQft2seUnlUM4OmCBERBIGRIw1M9PaGf8BE6/Yo=;
        b=t6Oy3YARxIj8foCZcmH6cJidbbk6agdTw9qqMsdhYGvZnMaxtERl+Yh+/4r0P8OaQY
         2WyepRw+smKWWEwBC3dyIjmNUhAydLGY4a6g8MwBD4BO8SY4kpRnpY0bT8eAROjPL56o
         eh5zUyL+pkcQBVTLVTrmsBiOpH6R5bXicKAxC/So7+nyYzZqBTa3ZfZ9CTxsRnv0dsT8
         QBFb0Qv+hMXMfUtkzZSFJ7ub/vQqszEXjGS0Oz7GiGqIF/OHnXBaX1v1FRBMy0Nf87Jq
         umzNxf5TuTtr7nDeA4h/hTrvhOIArqeAS+6xWyuknAGCO90UtyZTAvCiflPEl0FqUoDT
         F5ow==
X-Gm-Message-State: AOJu0YxfIoCaUf7Km+ywGgqLV3w9Oi57hBQB2+MAU68dfiCIjmMNmj4K
        53E8HxF65U1Cnm29EzKMVcfzuQy4Ho5kOmHSumGKmw==
X-Google-Smtp-Source: AGHT+IEAiYKsp8cH+2h3D9JtZpHKKIWvy5a5Q1QY0jUFvGMVWmqKhCUBJBpd5MooxAaQp9G4F38UYjLP10jlxrC+JuY=
X-Received: by 2002:a05:6102:415:b0:464:3c0a:fdd4 with SMTP id
 d21-20020a056102041500b004643c0afdd4mr4191842vsq.2.1701248394003; Wed, 29 Nov
 2023 00:59:54 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
 <ZWbjXV85zDXen_YH@archie.me>
In-Reply-To: <ZWbjXV85zDXen_YH@archie.me>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 29 Nov 2023 14:29:42 +0530
Message-ID: <CA+G9fYtByCCzrbM-a4du2b5rJVn_UaCz1HaMZMcBAcfyUBXPSA@mail.gmail.com>
Subject: Re: btrfs: super.c:416:25: error: 'ret' undeclared (first use in this
 function); did you mean 'net'?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 12:38, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Tue, Nov 28, 2023 at 05:55:51PM +0530, Naresh Kamboju wrote:
> > Following x86 and i386 build regressions noticed on Linux next-20231128 tag.
> >
> > Build log:
> > -----------
> > fs/btrfs/super.c: In function 'btrfs_parse_param':
> > fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this
> > function); did you mean 'net'?
> >   416 |                         ret = -EINVAL;
> >       |                         ^~~
> >       |                         net
> > fs/btrfs/super.c:416:25: note: each undeclared identifier is reported
> > only once for each function it appears in
> > fs/btrfs/super.c:417:25: error: label 'out' used but not defined
> >   417 |                         goto out;
> >       |                         ^~~~
> > make[5]: *** [scripts/Makefile.build:243: fs/btrfs/super.o] Error 1
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Links:
> >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/log
> >
> >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/details/
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51BFjRBS06YQ3U/
> > - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51BFjRBS06YQ3U/config
> >
>
> Is it W=1 build? I can't reproduce on btrfs tree with
> CONFIG_BTRFS_FS_POSIX_ACL=y and without W=1.

My config did not set this
# CONFIG_BTRFS_FS_POSIX_ACL is not set

Do you think the system should auto select the above config as default when
following config gets enabled ?

CONFIG_BTRFS_FS=m
(or)
CONFIG_BTRFS_FS=y

- Naresh

> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
