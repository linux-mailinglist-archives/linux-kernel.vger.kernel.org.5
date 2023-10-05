Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8217B9F37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjJEOVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjJEOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:18:57 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1245B8E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 22:55:37 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b07548b085so244284241.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 22:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696485337; x=1697090137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZcZ92+aK7pFvnYG3Zmua4wSvYZMloUcgVE7tYVuTB8=;
        b=OOdPTqgfhKSvdxtXNmfCpMtSHONe8CGrGlucUFT1/hKomeEh99dtQpuQVHhOhjNB8A
         fzXqRwHZ+b9+41AsRw8erunFGOWk2n94JxkF7q3RbKks6mZiUdO2TG3ZGTRvde+r18E4
         CTFgUTphDVT2lWMSA9k9WxK9V04P0hFQHpzo3GgCFp09hQ+jEVJxxuYfJjBbYxdV8K3Z
         UeX6+OeTK6lStTLY6oiJhbUncSGuH3+YOOXPJHkcIgWIsAgAqyafN1sfiU7C9SPmsPj3
         yygGVLrIO7ZGR+LB53RtUHpjXrp0n1UrJqy/IB9rnWmV9oGYMOS6YfMduGxVpoaGWStD
         yQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696485337; x=1697090137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZcZ92+aK7pFvnYG3Zmua4wSvYZMloUcgVE7tYVuTB8=;
        b=pBi9Pwc9d15wDT9gcvx7IIS9+xk1DKOXHDcyIIQieLTQS/0Kj/zn6fP4hmkPLo3qJq
         s5/2lM744pqkEr6OrFvGARjtUzKf5Q3F9MaZx6EM2yOH6j/4ndKOE15QQD1b9ACUrlfp
         Ghv0Lvp8zDEOVgkosoSePNtanFnbmBQbHk1MpRGNF0dpALPPg8U5LzlsXzmta8skVLKe
         jSENG4BCK+ZFFov9OVSM8u8ywapHohevpBen0tON9cbbYNJd6fOCw3FMKoojlZmhnvqh
         TedynE5E8XCRHOwVYtv+hW6X8vle1Dz1/nl3H6T3YRfFtRylJPvyr5+eyEgtEbmmnPqd
         MECQ==
X-Gm-Message-State: AOJu0YzokTwBhEIwHADIZkXQSs/P3X8YdgoCMCmDflMp0MxMJt4NFnhA
        BZo7w4dBKXqWDc125BbdNUU5OZYVZOwylow2dYTWmA==
X-Google-Smtp-Source: AGHT+IEfqFq+XiDNz2eIQnSJe4kBwvfbehxMBH2culMzbddsGyBv9EAUAsoMj1f9NVtaqL/bP7MZWcqyYrY+8efqtTY=
X-Received: by 2002:a67:b34a:0:b0:454:6faf:204d with SMTP id
 b10-20020a67b34a000000b004546faf204dmr4357700vsm.2.1696485335477; Wed, 04 Oct
 2023 22:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175229.211487444@linuxfoundation.org>
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Oct 2023 11:25:24 +0530
Message-ID: <CA+G9fYuH90g8jQ5SZHE98k16iQV5n+d2-G64xT9W9wrVmpt_Dg@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Netdev <netdev@vger.kernel.org>,
        kunit-dev@googlegroups.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 23:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While running kunit testing on qemu-armv7 following test failures noticed
on stable rc 6.5.6-rc1.

# req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:477

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
----------
<6>[ 1351.687335]     KTAP version 1
<6>[ 1351.688300]     # Subtest: Handshake API tests
<6>[ 1351.688760]     1..11
<6>[ 1351.689362]         KTAP version 1
<6>[ 1351.689985]         # Subtest: req_alloc API fuzzing
<6>[ 1351.694360]         ok 1 handshake_req_alloc NULL proto
<6>[ 1351.705855]         ok 2 handshake_req_alloc CLASS_NONE
<6>[ 1351.710878]         ok 3 handshake_req_alloc CLASS_MAX
<6>[ 1351.715435]         ok 4 handshake_req_alloc no callbacks
<6>[ 1351.722026]         ok 5 handshake_req_alloc no done callback
<6>[ 1351.726579]         ok 6 handshake_req_alloc excessive privsize
<6>[ 1351.732397]         ok 7 handshake_req_alloc all good
<6>[ 1351.732934]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
<6>[ 1351.733586]     ok 1 req_alloc API fuzzing
<6>[ 1351.741251]     ok 2 req_submit NULL req arg
<6>[ 1351.745979]     ok 3 req_submit NULL sock arg
<6>[ 1351.753307]     ok 4 req_submit NULL sock->file
<6>[ 1351.763090]     ok 5 req_lookup works
<6>[ 1351.770057]     ok 6 req_submit max pending
<6>[ 1351.774878]     ok 7 req_submit multiple
<6>[ 1351.782411]     ok 8 req_cancel before accept
<6>[ 1351.787423]     ok 9 req_cancel after accept
<6>[ 1351.795660]     ok 10 req_cancel after done
<3>[ 1351.799741]     # req_destroy works: EXPECTATION FAILED at
net/handshake/handshake-test.c:477
<3>[ 1351.799741]     Expected handshake_req_destroy_test == req, but
<3>[ 1351.799741]         handshake_req_destroy_test == 00000000
<3>[ 1351.799741]         req == cae22700
<6>[ 1351.803368]     not ok 11 req_destroy works
<6>[ 1351.804539] # Handshake API tests: pass:10 fail:1 skip:0 total:11
<6>[ 1351.805460] # Totals: pass:16 fail:1 skip:0 total:17
<6>[ 1351.806276] not ok 95 Handshake API tests

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257175/suite/kunit/test/req_alloc/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257175/suite/kunit/test/req_alloc/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/config

Steps to reproduce:
# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.49.2
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
Link to reproducer,
https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/tuxmake_reproducer.sh

or

tuxrun --runtime podman --device qemu-armv7 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/zImage
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/modules.tar.xz
--rootfs https://storage.tuxboot.com/debian/bookworm/armhf/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --image
docker.io/linaro/tuxrun-dispatcher:v0.49.2 --tests kunit --timeouts
boot=30


--
Linaro LKFT
https://lkft.linaro.org
