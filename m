Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490C27BE6C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377229AbjJIQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377811AbjJIQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:43:57 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE9A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:43:56 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49e035bdca7so1125279e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696869835; x=1697474635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h74o2AZcTC7GyQaZvo8+es5i4OkJLBnswUlj7gMbv2U=;
        b=hgyFnpAWsJpN7F0W7spdSAao0D1Fh8p55b2VjSkcyyxpOPa1YXwJJXhof/z/XpVf9+
         RZFwlUGH2mrkYhA6AuIyT5xN8j4jiE3mfTab9D+6MueuLE9dLeKJFLyIlEIcUgiJdVi3
         EGS1hJYliShtFphZYvgt3a4q1si8CcevvwqWPybfJa78Zq2Z8XwLhAG+/r8M5nAHnm9y
         vVhS6YlhLA+EBi3jAQeDQrZy5SJqTu4liDvaiRVEsx99vWaEmv8rkeyWPHPYQc8HyvH+
         ANd8IOqy4q5wfOgOq0GqmxLjaq5Z7HWgE6zr+I3I9KDDkmF6FiIJeSDSVhbuB1sjLxjP
         rbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869835; x=1697474635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h74o2AZcTC7GyQaZvo8+es5i4OkJLBnswUlj7gMbv2U=;
        b=WrM/J3FOrZZGnL4XU9kLXRipj/owy+I+GwB64MQsI1OlXVfyI1DwARI0SaDvhewv9m
         sU91HY6Jr76593mok/vyVRYUWqNfsxxITGMmWQAg6g6TXVkMRoZFHz0W8KCB2+ovPn12
         pF12K2lqlr0Wr3CDwa9EzicKOkR8Na8pcoA+mNvvDuGGLaMz70EZcd0HjgZPxVB0UQOy
         uMGsEeq+iQIKWEFGC/paUnlp1kicayPJ0Qvf5FHdpfBXz0PblKSS3YZHzcIzT1n4md8G
         r6UcUx42IRIWVZOieqebK4G8oykD/wo0dO3LqEzvnWBKS0yfyjjgHNN2nJQ06VkIGofV
         L8/g==
X-Gm-Message-State: AOJu0YwDS4eTVww+/vDpE29z8zo/6YfCvYKbvvI5OGLeqWgFPTPHgNfU
        TM9H3a6SlYrHE1SVR3rM1y3ckMTt2qWfk094x7KItJbvJniBnKeiGxdFvQ==
X-Google-Smtp-Source: AGHT+IEkXqZBLHppN9aD1rPab7CXnRnbSPIio7BIWqrTQXvtR6190yK7ITH0FWBWUzGCmJoQh0UXep8/jjC65cWusQM=
X-Received: by 2002:a1f:d686:0:b0:49d:a52a:441f with SMTP id
 n128-20020a1fd686000000b0049da52a441fmr12470392vkg.7.1696869835132; Mon, 09
 Oct 2023 09:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org> <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com> <2023100755-livestock-barcode-fe41@gregkh>
In-Reply-To: <2023100755-livestock-barcode-fe41@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 9 Oct 2023 22:13:42 +0530
Message-ID: <CA+G9fYvzV03=-LTmburzzwRpw0xuxoAXBKo0n1muYwOOiVG_bw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Eryu Guan <eguan@redhat.com>, chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 at 14:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 06, 2023 at 12:42:04PM -0600, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > On Thu, 5 Oct 2023 at 10:40, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
> > > On Wed, 4 Oct 2023 at 23:41, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 6.1.56 release=
.
> > > > There are 259 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/=
patch-6.1.56-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Results from Linaro=E2=80=99s test farm.
> > > Regressions on arm64 bcm2711-rpi-4-b device running LTP dio tests on
> > > NFS mounted rootfs.
> > > and LTP hugetlb hugemmap11 test case failed on x86 and arm64 bcm2711-=
rpi-4-b.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > LTP hugetlb tests failed log
> > >   tst_hugepage.c:83: TINFO: 1 hugepage(s) reserved
> > >   tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
> > >   hugemmap11.c:47: TFAIL: Memory mismatch after Direct-IO write
> > >
> > > LTP dio tests failed log
> > >   compare_file: char mismatch: infile offset 4096: 0x01 .   outfile
> > > offset 4096: 0x00 .
> > >   diotest01    1  TFAIL  :  diotest1.c:158: file compare failed for
> > > infile and outfile
> >
> > Bisection led to "NFS: Fix O_DIRECT locking issues" (upstream commit
> > 7c6339322ce0c6128acbe36aacc1eeb986dd7bf1). Reverting that patch and
> > "NFS: Fix error handling for O_DIRECT write scheduling" (upstream
> > commit 954998b60caa8f2a3bf3abe490de6f08d283687a) (not a clean revert
> > this one) made ltp-dio pass again.
>
> So this is also an issue in Linus's tree?  Or is it only on the 6.1.y

 It is only on the 6.1.y branch.

- Naresh
