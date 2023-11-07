Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6C7E4B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjKGWHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjKGWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:06:52 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406225BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:02:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a67b9cd230so228068839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699394546; x=1699999346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9GMN59KG9vz4YUQQehaTwQYKj13ptJRqtnV+YMinhk=;
        b=Tlfb7chF+kSksZaATbJuEfFi7NR0ctrrhOXvoU58A6NSatMce6eskh/BVVnQXBfXVs
         +mpO2b2mxkUxoZ3aWi7f4ngQQIbwA+ujlCjOoez8LYdnQagStK+sW2dnUEXBntUw2qVg
         LnOrj+IxgM3G/yfxZuJnSJedujwzM3o+67uh+54BpR4ynHdxoX+qkMvAyo714tfTfVNh
         r3mdLS3z9Utfz4S5fKen7EQyXs5CIhlrRaN/pAGqxONJAu+weASrQ20DvshJtEpD4mWw
         o5xZUf5miD8E/nyZFH+x6qku2uxd78Gn+0YGBIz7BiWAu73FqnfeY05/OQgudn9XRHs+
         /gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394546; x=1699999346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9GMN59KG9vz4YUQQehaTwQYKj13ptJRqtnV+YMinhk=;
        b=pdtfxA5L5Q4RXNWQ/bOQgtneCie2vLcNLauKIBqJjoQebeuexNxz5p+JfC2PyfV2Xd
         qnVIF60n+rqEeEDrDnhPtl6PkcqL6yxV0U/Xv1Yf5bMIePwfl7GuA2IFCVr+Q2PBQmiF
         0Ge1Zv1RVkoZ4epJRCRTb7LpLvAxLp3EYLHyXvj6QRYRUyX365UDoeCTmF9Csrtn3f1s
         NA/SXVcvaeJQmv+U5XeOdAA19Y+9ZikeOh4aHnKI7V9buvd83zsYEW44dBOUo1VPtf7C
         9m7YTYjSfI7ofmLWRZqqRNEQNsM8HSKQQPuAkxwdk/9xjOVagPwbVYwR7Ifr+ZEwnHNs
         9kCg==
X-Gm-Message-State: AOJu0YznQrIMghy6CPioiWC6fg/Sq5yHEI3FavKng9ai5cc6eMSW+dAH
        FQMGNovdy/QD5BrOlNkgfFFooxYepgxTUSCSiBw9hwoc7cka8g==
X-Google-Smtp-Source: AGHT+IEXEJb5mp/ZFOCjoV7fb92ReUAqfJH6RHtIx7OQj90gjipcbZuQmyjA/E0uRMirYr3XKgvS/ti/YIQFA/QMwXc=
X-Received: by 2002:a5d:8c87:0:b0:7a9:a9c6:d6b2 with SMTP id
 g7-20020a5d8c87000000b007a9a9c6d6b2mr152870ion.16.1699394545675; Tue, 07 Nov
 2023 14:02:25 -0800 (PST)
MIME-Version: 1.0
References: <202311080014.GABRIG2T-lkp@intel.com>
In-Reply-To: <202311080014.GABRIG2T-lkp@intel.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 7 Nov 2023 14:02:14 -0800
Message-ID: <CAKEwX=OBONGNw0omoEVNW29akLJ7WgvTjiOBqF0Bq8xmB7gbaA@mail.gmail.com>
Subject: Re: mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL pointer
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 8:30=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
> commit: cf264e1329fb0307e044f7675849f9f38b44c11a cachestat: implement cac=
hestat syscall
> date:   5 months ago
> config: s390-randconfig-r123-20231107 (https://download.01.org/0day-ci/ar=
chive/20231108/202311080014.GABRIG2T-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080014=
.GABRIG2T-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311080014.GABRIG2T-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    mm/filemap.c:1416:17: sparse: sparse: context imbalance in 'migration_=
entry_wait_on_locked' - unexpected unlock
> >> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL point=
er
> >> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL point=
er
> >> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL point=
er
> >> mm/filemap.c:4249:1: sparse: sparse: Using plain integer as NULL point=
er
>
> vim +4249 mm/filemap.c
>
>   4214
>   4215  /*
>   4216   * The cachestat(2) system call.
>   4217   *
>   4218   * cachestat() returns the page cache statistics of a file in the
>   4219   * bytes range specified by `off` and `len`: number of cached pag=
es,
>   4220   * number of dirty pages, number of pages marked for writeback,
>   4221   * number of evicted pages, and number of recently evicted pages.
>   4222   *
>   4223   * An evicted page is a page that is previously in the page cache
>   4224   * but has been evicted since. A page is recently evicted if its =
last
>   4225   * eviction was recent enough that its reentry to the cache would
>   4226   * indicate that it is actively being used by the system, and tha=
t
>   4227   * there is memory pressure on the system.
>   4228   *
>   4229   * `off` and `len` must be non-negative integers. If `len` > 0,
>   4230   * the queried range is [`off`, `off` + `len`]. If `len` =3D=3D 0=
,
>   4231   * we will query in the range from `off` to the end of the file.
>   4232   *
>   4233   * The `flags` argument is unused for now, but is included for fu=
ture
>   4234   * extensibility. User should pass 0 (i.e no flag specified).
>   4235   *
>   4236   * Currently, hugetlbfs is not supported.
>   4237   *
>   4238   * Because the status of a page can change after cachestat() chec=
ks it
>   4239   * but before it returns to the application, the returned values =
may
>   4240   * contain stale information.
>   4241   *
>   4242   * return values:
>   4243   *  zero        - success
>   4244   *  -EFAULT     - cstat or cstat_range points to an illegal addre=
ss
>   4245   *  -EINVAL     - invalid flags
>   4246   *  -EBADF      - invalid file descriptor
>   4247   *  -EOPNOTSUPP - file descriptor is of a hugetlbfs file
>   4248   */
> > 4249  SYSCALL_DEFINE4(cachestat, unsigned int, fd,
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

This is a known false positive with s390. See this thread:
https://lore.kernel.org/linux-mm/202305070840.X0G3ofjl-lkp@intel.com/
