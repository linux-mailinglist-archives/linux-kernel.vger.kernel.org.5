Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24B755ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGQFGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQFGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:06:21 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E64E54
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:06:18 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-791b8525b59so1418247241.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689570377; x=1692162377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xR7Jh7BXNDpu6+2aiq3ZuVrs5oBNof862oaaEGT22kE=;
        b=K/GmCjSqOYm0KWCBJgUAzYKSJMgtUbsQgdm3le7BCDDPkafCvqTGFvy/h05nnECb3A
         SXiLbd98PE5p0DHBkyrJHpnDi4u8V/Ls+0mW2DiZhRHrvaogGxeZH67R9I+WAMJaY50P
         8pej23rGRTwODqWQEVMMd1SMgtf10FCgibO2twTrOfGxcA/8g0nHbKKUFsBcTh+V0Iua
         kC+e+RKVSmL1ADafHew0B8wA2cozddQug8Fh9JDB0Bgqwh2ShRBoMalH9pf9DIAzi8r+
         31R2cmR6rsERPaezQDdv3EKRM4/jjsqC84/StexZJTLhJli4BYahal7F2Yfdu16GcEyH
         7zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689570377; x=1692162377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR7Jh7BXNDpu6+2aiq3ZuVrs5oBNof862oaaEGT22kE=;
        b=Q5GE5BUumtPMSDHEvQqypUvJpuFkb3yPOgrfZeUU1GOZ6rgJnoDTRcbocTEvIwngQo
         Z91ax1XnY3Ga1mMZnZpDPThvuz8j+BBhPNax03khvJay02OcvJu5koY5JKo/i1yazhvz
         1VeIba4yzT/MHWnCSL0L8jbTPX4ZCPJ9fp39MRhwoQcU+QZ/70DZ4+1BeZ0WEubTM5YJ
         zYHG8+HfOOkjvXx51vTXDmHybOHIk5YA8aqZS4IRdVWkE4qUMzlk8r5ZjRtP/ONHEfK9
         0F32IhSiz0NHvBZalZ6B5/tJ7rbNZsCSHgXZuuafrENrDJuYXoXGUdn7vyP63RbWkuJx
         wp3w==
X-Gm-Message-State: ABy/qLYCzz16FDx14xVugXZo+6nh9GMNilsdqZ9VK8A2ZbzToOnRFrnK
        NUqxdeyna/VJC0alhiudy9IzmFa/dbdDxs/dD5kQsg==
X-Google-Smtp-Source: APBJJlFtxcetEBCc4TSfgqF8xL/QIBSc2Drf5I8jWvVjy2toUPb9CBtwXYjXn2M9Pxxq/5xt2wL5YpHpWjFpfJPf2Vg=
X-Received: by 2002:a67:fd7b:0:b0:444:17aa:df60 with SMTP id
 h27-20020a67fd7b000000b0044417aadf60mr5035406vsa.13.1689570377332; Sun, 16
 Jul 2023 22:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com>
 <20230717043111.GA3842864@mit.edu>
In-Reply-To: <20230717043111.GA3842864@mit.edu>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 17 Jul 2023 10:36:06 +0530
Message-ID: <CA+G9fYukSUuNV5usVC1Zmq7uqxu5w2g8dTHgV9WUAA=nGBk20w@mail.gmail.com>
Subject: Re: next: kernel BUG at fs/ext4/mballoc.c:4369!
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
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

On Mon, 17 Jul 2023 at 10:01, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Jul 16, 2023 at 11:32:51AM +0530, Naresh Kamboju wrote:
> > Following kernel BUG noticed while testing LTP fs testing on x86_64
> > arch x86_64 on the Linux next-20230716 built with clang toolchain.
>
> Hmm, I'm not seeing the next-20230716 tag at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>
> or
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/
>
> I see a tag for next-20230717 and for next-20230714, but not
> next-20230716.  Was this a typo?  Does it reproduce on the
> next-20230717 tree?

Sorry it is a Typo,
Here is the kernel version, 6.5.0-rc1-next-20230714

>
> Also, since I don't use LTP, can you give me a trimmed-down
> reproducer, to save me some time?

Boot images for x86_64,
I have defconfig + test KConfigs.

   kernel:
      url:
        https://storage.tuxsuite.com/public/linaro/lkft/builds/2SY3QjxEGsLoae4uGpfjPnZqwKC/bzImage
    modules:
      url:
        https://storage.tuxsuite.com/public/linaro/lkft/builds/2SY3QjxEGsLoae4uGpfjPnZqwKC/modules.tar.xz
    nfsrootfs:
      url:
        https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2SPaZ6KtLE32NNDGqKrHtwJJz1g/images/intel-corei7-64/lkft-console-image-intel-corei7-64-20230711051126.rootfs.tar.xz


Build and install LTP:

# git clone https://github.com/linux-test-project/ltp.git
# cd ltp
# make autotools
# ./configure
# make
# make install

Connect external newly formatted SSD drive via USB and mount.
This drive will be used by LTP at run time to create temporary test files.


Run LTP

  cd /opt/ltp/
  ./runltp -f fs - d /mount/SSD-external-storage-drive


ref:
 - https://github.com/linux-test-project/ltp

- Naresh

>
> Thanks!!
>
>                                         - Ted
