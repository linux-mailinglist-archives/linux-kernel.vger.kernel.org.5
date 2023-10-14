Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D447C9720
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjJNWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJNWyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:54:37 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C42DCC;
        Sat, 14 Oct 2023 15:54:36 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49ab6c1869dso2967970e0c.0;
        Sat, 14 Oct 2023 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697324075; x=1697928875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3dgwAPbWgceK8XnpO8ceX742rck1tlUzuW6UkEbMaQ=;
        b=Ge1EVanau9Tb9T4+lTUKWqrz3uMU75ASXnoyBqzB+Zw83Gii/9rbxQMfUgt9LqsCdj
         lt4soLJG8zUTVQdW36AQJ03W/ECGfb/qeEQ8MFCFXO7zMOlYvjsCa7zT6TqvWamwMYyd
         Nt4zmCTXeAAaezgp02dxjJfg38+zTWgPuncDec3FNMqtptzfeP0Gz6F/qqWtzfk/aJtT
         +Hp4Q70G9yZcetAdWdTaWHNiXSwY2deECbUq+EQHjSkHN/L31SMbVVMNVMwLAsxzdrsF
         A5Dno5uyETCA+XyD6u1JQP4GSfBylZV4GImd0wWdkaFOzaTq/t+R0WZTdowVZdhXFTUM
         jw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697324075; x=1697928875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3dgwAPbWgceK8XnpO8ceX742rck1tlUzuW6UkEbMaQ=;
        b=fVDuO6jYXJy6KZQaopmXgvs1HhV8tOkQQDkENVOvNYe2l7rgCEH242OBNHy5i8DSBp
         fl/a9gRCApCKK8jPmAs9ojgBPx57KblZ1J/pNRHTyqfWMivSlmOBXbQ7druZL9mnuGga
         StKdfFQTtmmOjhg5rHkkxjHiQfZtwurkaRWEShiZDidjAcOMhG6YzuVbdEM7dJkwvFuN
         KykLh74F7LsC8sYvKCCbYBVDY3/3g7PqTAaAWp+9hGIXSNnS329595FpcYooa0GryQ4B
         NRklwtJbq+TML1DkoQt+xCIPsEYhVMg8+s8pbaJ3193ZkZJ5KFJ30oLqLXZJrMQdtcty
         qEeg==
X-Gm-Message-State: AOJu0YzIKx/Cn+ZWhu0BYJvppD5wmw5d6VJTg8XTg10UvCTetPm+kRQA
        Wrj0FyvWqwxQIjbhxFCN0/yoaFyBb6FZdtJUTuwzv10orS7C8A==
X-Google-Smtp-Source: AGHT+IFfT3nqs45wSlTdh49Mfqnd7iS4fm3NazMXcrcNd0WEk8mfYCYz456yTKkBrC2Rm6aiZ0xPlI+0DL8Ucy3wF44=
X-Received: by 2002:a05:6122:1681:b0:49a:b587:ab79 with SMTP id
 1-20020a056122168100b0049ab587ab79mr2277741vkl.8.1697324075009; Sat, 14 Oct
 2023 15:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231013224818.3456409-1-jim.cromie@gmail.com>
In-Reply-To: <20231013224818.3456409-1-jim.cromie@gmail.com>
From:   jim.cromie@gmail.com
Date:   Sat, 14 Oct 2023 16:54:08 -0600
Message-ID: <CAJfuBxxc1HxYNbp1vdkh8yTOTHV-5ohskCA-twx5Uf2SmWTffg@mail.gmail.com>
Subject: Re: [PATCH v7b 00/25] fix DRM_USE_DYNAMIC_DEBUG=y regression
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 4:48=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> hi Jason, DRM-folk
>
> (now with checkpatch fixes)

I missed fixing boxed-vector, am just dropping it.

>
> This patchest fixes the chicken-egg initialization problem in the 1st
> version of ddebug-class-maps, that DRM-CI uncovered.
>
> The root-problem was DECLARE_DYNDBG_CLASSMAP, which broke the K&R rule:
> "define once, refer many".  In patch 14 it is replaced by:
>
>  DYNDBG_CLASSMAP_DEFINE - define and export a struct ddebug_class_map
>  DYNDBG_CLASSMAP_USE - ref the exported struct
>
> test-dynamic-debug is also extended with a -submod.ko, in order to
> recapitulate the drm & drivers initialization scenario.
>
> They're on v6.6-rc5 now, and apply cleanly to drm-tip/drm-tip.
>
> Ive been running recent revs on rc3+, on my desktop and laptop.
>
> The final blocker was a missing __align(8) on the ddebug_class_user
> record inserted by DYNDBG_CLASSMAP_USE.  This caused DRM=3Dy (builtin
> only) to have a corrupt record for drm_kms_helper (builtin dependent).
> Curiously, a clang build did not exhibit this problem.
>

>
> Widespread testing is appreciated.
> I have scripts if anyone wants them.
>
> I'll forward lkp-robot reports here when I get them.
> Patches also at https://github.com/jimc/linux (dd-fix-7b)
>

Date: Sat, 14 Oct 2023 18:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: Jim Cromie <jim.cromie@gmail.com>
Subject: [jimc:dd-fix-7a] BUILD SUCCESS 8e96f63f570a462b859876601a5f795a159=
99f6b
Message-ID: <202310141826.AN7MAD40-lkp@intel.com>
User-Agent: s-nail v14.9.24

tree/branch: https://github.com/jimc/linux.git dd-fix-7a
branch HEAD: 8e96f63f570a462b859876601a5f795a15999f6b  drm: restore
CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN

elapsed time: 3187m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc
alpha                            allyesconfig   gcc
alpha                               defconfig   gcc
arc                              allmodconfig   gcc
arc                               allnoconfig   gcc
arc                              allyesconfig   gcc
arc                                 defconfig   gcc
arc                   randconfig-001-20231012   gcc
arm                              allmodconfig   gcc
arm                               allnoconfig   gcc
arm                              allyesconfig   gcc
arm                                 defconfig   gcc
arm                   randconfig-001-20231013   gcc
arm64                            allmodconfig   gcc
arm64                             allnoconfig   gcc
arm64                            allyesconfig   gcc
arm64                               defconfig   gcc
csky                             allmodconfig   gcc
csky                              allnoconfig   gcc
csky                             allyesconfig   gcc
csky                                defconfig   gcc
i386                             allmodconfig   gcc
i386                              allnoconfig   gcc
i386                             allyesconfig   gcc
i386                              debian-10.3   gcc
i386                                defconfig   gcc
i386                  randconfig-001-20231013   gcc
i386                  randconfig-002-20231013   gcc
i386                  randconfig-003-20231013   gcc
i386                  randconfig-004-20231013   gcc
i386                  randconfig-005-20231013   gcc
i386                  randconfig-006-20231013   gcc
loongarch                        allmodconfig   gcc
loongarch                         allnoconfig   gcc
loongarch                        allyesconfig   gcc
loongarch                           defconfig   gcc
loongarch             randconfig-001-20231012   gcc
m68k                             allmodconfig   gcc
m68k                              allnoconfig   gcc
m68k                             allyesconfig   gcc
m68k                                defconfig   gcc
microblaze                       allmodconfig   gcc
microblaze                        allnoconfig   gcc
microblaze                       allyesconfig   gcc
microblaze                          defconfig   gcc
mips                             allmodconfig   gcc
mips                              allnoconfig   gcc
mips                             allyesconfig   gcc
nios2                            allmodconfig   gcc
nios2                             allnoconfig   gcc
nios2                            allyesconfig   gcc
nios2                               defconfig   gcc
openrisc                         allmodconfig   gcc
openrisc                          allnoconfig   gcc
openrisc                         allyesconfig   gcc
openrisc                            defconfig   gcc
parisc                           allmodconfig   gcc
parisc                            allnoconfig   gcc
parisc                           allyesconfig   gcc
parisc                              defconfig   gcc
parisc64                            defconfig   gcc
powerpc                           allnoconfig   gcc
powerpc                          allyesconfig   gcc
riscv                            allmodconfig   gcc
riscv                             allnoconfig   gcc
riscv                            allyesconfig   gcc
riscv                               defconfig   gcc
riscv                 randconfig-001-20231012   gcc
riscv                          rv32_defconfig   gcc
s390                             allmodconfig   gcc
s390                              allnoconfig   gcc
s390                             allyesconfig   gcc
s390                                defconfig   gcc
s390                  randconfig-001-20231012   gcc
sh                               allmodconfig   gcc
sh                                allnoconfig   gcc
sh                               allyesconfig   gcc
sh                                  defconfig   gcc
sparc                            allmodconfig   gcc
sparc                             allnoconfig   gcc
sparc                            allyesconfig   gcc
sparc                               defconfig   gcc
sparc                 randconfig-001-20231013   gcc
sparc64                          allmodconfig   gcc
sparc64                          allyesconfig   gcc
sparc64                             defconfig   gcc
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc
um                             i386_defconfig   gcc
um                           x86_64_defconfig   gcc
x86_64                            allnoconfig   gcc
x86_64                           allyesconfig   gcc
x86_64                              defconfig   gcc
x86_64                randconfig-001-20231013   gcc
x86_64                randconfig-002-20231013   gcc
x86_64                randconfig-003-20231013   gcc
x86_64                randconfig-004-20231013   gcc
x86_64                randconfig-005-20231013   gcc
x86_64                randconfig-006-20231013   gcc
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


> Jim Cromie (25):

>   dyndbg: add for_each_boxed_vector

Im dropping this one, more trouble than its worth.
hopefully one falls out of flex-array work.
