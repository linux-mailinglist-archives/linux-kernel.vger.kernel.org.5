Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6224B76D5D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjHBRpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjHBRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:44:47 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E01717
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998283; bh=JnC0YDmsZILK8u0bSDOh1vFQYrIRYvha//idROOyrvs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Wi7yZPDisMUWZb7zLF4JWjI7qVkNhAcHUcfXXiXQegVyUPoF/sMKLMXVUtuipcOJidkRJDIE9cu1ZGaaU1a4tUZasjJJJZbd5LBwL9NfyMNYieu4UNe4ngb3EO2Wz+ofHjK8hrIYTdz5pg3SvxdFQH45ZGM9rOYmCEkhP5qn5e0YMYX0Nfme1bADt+GFXV5jVAiZzkzd0ZraBSxPViXX1lPeJfGvxzlyJeArZyR0MLVL4VCS0lNif1exnUo02pym0xJN3TeUzi8a3NMwbTz59Ushzc3srhgeNoGqYJuJivM0lnIG1/b+250XKYfjgJgNX6pOUP7N4OhhAuqRLpE3Zw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998283; bh=uzPZPpTCDqh6FxOw0WPxI3P+SqNHe44xdHqs0W3kjXJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=l5hUKPCyxMcmTHUdBj2vkY4zP3NwrIZ4xavOpIq+K5/TzvpCtozJ/ZTOH5soBB8ZhHJ+kagPfKahFwPqD4aTkaMkEzr/z6ZQLj1A4bJ6upEIBBikgU7Z3w5Va4JOGBhCIY6tUds7yFn4ODWlcJMg2Vwhaorljm2d+GyIdMWSx9KurOU1A/3R4XnRC0yGfr42zznd17mvr/QvmnwKxESq2p2ZqhTq6A0DltYwgcfA9kPFVQY0vz/EkbwOk23hM/pfvroRN7lPFHWi2uW8Wz89fMuXJBkDB0v1NhbfgG1z7bgnKbjsE0ev1GVeDN4V3B7lseZUS2BFuFqTL1yn3RE0jg==
X-YMail-OSG: 23cJLWwVM1lIKccHiQICkU2TmzF2efTLg4AD.mOVnoaR2nDOTpQ4lCIFsxSkmKy
 lt1542Kq4B8IkeENYNF2PwbTtnU2eS62YEYHhSDtY1KcyC1NSStBTDQvR7POar.KUotQ5mS9I5cp
 jD0RGd.Otoi4zXvdWFZQYLLJtGzaIR9YaqiAqKmtwpB6WdIB1tpzowBkyy2YDxAX2y8dQh9YJlz2
 4Ym6RPE1f80Y85su1_kXg7LesftURl4tfgzzx1.rQAlhLyPMpYy_zKrt_8d0jMzWMsE5cNwv79Df
 xq2xZ6Pg2oQDzhRpR1miYyZZM6Kfv9rt.8pZIE1594mfJt7Pd9xt7fkeVCbA6qbpt4YMzn9wHlrX
 EgYvKdIPkynQRC96nyBzgY28LK5Kt0qyWahkeyBFE_U6QZNP8wjBOfraKGomjYXtcVlyr3oC.ALn
 TIkbP1YYOnRYKqBGUu4jY6M_XiD.vH.5Ga9KTV6nU_OAkCjZlW_sPrbWZjxWaxe78Kb.pgrjXd9D
 d.pHfMXBYtX6Qgn7IUmx8vIF6e..znhe96gdZm_YI61bnPdiYj6OINUfACQguOanLPvLiCUmBPu8
 QUeIvvkEgwF1T2MTulbIEmpFL590x3W1vlUvRKx.Ur8gaEuTgtFCX5V.LFKQQk.SbmOURczeHoln
 ukmVeVl5h6dyZDS3AbTcA5c3aXzFGnOj7T0ZNHMnE813q3TWvRCEkr60y1.FbJqj0e.KcAXaMM4n
 eTlztaRwm.DbCd_AJR2nZ2hS89hOlbtQgyuVa9tUKdiHjbb6D.8Z1GqViI9HNHaw3HBTEL4ghTcc
 NsUCk7fPTUBgrucjDGedXsumIU47BMxjxpCMq.W1t2AaW7IIqFn0UVa7aD.5ySqpPhZMJYe8HHCS
 5w8VpC.B0hXtu6MI1gejCU2PrHWWMrLQkesoOG08wMD6xMLZ32t9.fTB_lp0oRmUrChPCgDXs8X.
 z26PfQDqGufMSkynEW8YRSjl.WE9om5HBiPU1ltX_CyVHm3gnzqW144qEQMi6zG.xx6yOOnJhVXO
 oekG3NM1SLzaVc_pSlqkVNccGubVoPkLf4_OLzJSQqmbjIJqxSejGsIxW4GDWqaBOSTZ7V8wijp7
 4aiW0S1N5faK740UfAkun_nG52zmIkDgY7fNJZp4XoL0SVfvB8RzMi1ZacrlQDB4sAFtGzpEJrZN
 cdnICEdmk7FP390PsaUZrb.by9yhaahri94qlfcbkyOkgmuhI9K2qZ2NAEgXnKRbu7D6hwN1Hh8g
 lyYThQzOwgiK7eyOQAT88o7CgIz2e5x7JBSS1IvY3zFySm6UcT2IVNb_WQoF99JPpA8O_SXwcp95
 BYX7H.tG8CDoU7aNUo9nxJYXnaJhMvKczxrX0ACMqEhiqX_Wd2AjUJQSugurOF3rvdy55BTeKFBl
 expUp0wPvkQ2D3X6T2t6tprPi_.DlCoG8fF2azZz9mXTZrfDIreEde6pTBkUhgZqUPPEmDh5e13j
 ttl7nwApNTxC7HI2SNDKttsh9GWQxG8LZFbnWIulBwefXq8tT0qocJ4BIKDsHSJwFrkluIqrpwL8
 .szL0119jMHlBJ_toSSsqxW3Z4Zhq0O8ya5RwgqYYKwlfrBQXgE1VHH3q0eIln1b3Ov9AcgQ64P1
 EffTiF6LWagglj93aMz72_5zGRUWpZNHlx.ouAM5LWgfjIEsPRUHPO6BPQCesbOOgJwfz2FxU30_
 n_uxa2CqjtcZTnSaFJkVFcVXbNqwymBJDs3ZrmteFqmLYwC.MHPmKbvTu_bH82rEg56c3UF7BPEd
 Ty8EfCNVxPR1.7CNnYtSq0oQDNn.yCTl02Te6Cm1DPvaHS_PLML4Uc_Ie.LDb4xmJ4QNbR7KrvAb
 Smvuijq7yDNbZ6xkM0462mW_PvHPvNIvkdJJ.Sya6b3fR9u.Oze5CjugBJmowxJGZCaTatP8VZQZ
 z1JqvPF_XPIKezsCaLcM.smy2f79ddAIQ3.fymQHEMGQZscs7zLMQObBTCCxYbo0YMQnhnha3l8x
 PNxjKGyzgrt7NtjastyUFFzM20FkerCcOkacdRRrIr0_TPc72p4z.hmjc_wRKmqTJXAiAqrB0B9m
 HiL2jhwyuFK4FIRLoSR3pOrVZODYpJvu7c0HzqfZA8fRhjckJPIDSQDueTNft_QgCYd.c56m1Mmt
 4cA.z.RVfhWgJteogHnhYCy_8RzVWa5fw_zxAl0JAiRIapmfdHEl8acnX36vbXxNjDXHhTXihLjG
 .T_n7ZqwV8wUo3j5CNiGke4OYutWheCvvwbn0JPXlpUY3zbt5LjP_yNccFGocAnCou_VCMXHeqoF
 CVVe3g0VkZUl6
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 154e54af-22ce-4e6d-9a7e-1c2c4679b520
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:44:43 +0000
Received: by hermes--production-gq1-7d844d8954-psjqr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 839fbc661e28c041ce8f4c5628604c14;
          Wed, 02 Aug 2023 17:44:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 00/11] LSM: Three basic syscalls
Date:   Wed,  2 Aug 2023 10:44:23 -0700
Message-ID: <20230802174435.11928-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230802174435.11928-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three system calls for the Linux Security Module ABI.

lsm_get_self_attr() provides the security module specific attributes
that have previously been visible in the /proc/self/attr directory.
For each security module that uses the specified attribute on the
current process the system call will return an LSM identifier and
the value of the attribute. The LSM and attribute identifier values
are defined in include/uapi/linux/lsm.h

LSM identifiers are simple integers and reflect the order in which
the LSM was added to the mainline kernel. This is a convention, not
a promise of the API. LSM identifiers below the value of 100 are
reserved for unspecified future uses. That could include information
about the security infrastructure itself, or about how multiple LSMs
might interact with each other.

A new LSM hook security_getselfattr() is introduced to get the
required information from the security modules. This is similar
to the existing security_getprocattr() hook, but specifies the
format in which string data is returned and requires the module
to put the information into a userspace destination.

lsm_set_self_attr() changes the specified LSM attribute. Only one
attribute can be changed at a time, and then only if the specified
security module allows the change.

A new LSM hook security_setselfattr() is introduced to set the
required information in the security modules. This is similar
to the existing security_setprocattr() hook, but specifies the
format in which string data is presented and requires the module
to get the information from a userspace destination.

lsm_list_modules() provides the LSM identifiers, in order, of the
security modules that are active on the system. This has been
available in the securityfs file /sys/kernel/security/lsm.

Patch 0001 changes the LSM registration from passing the name
of the module to passing a lsm_id structure that contains the
name of the module, an LSM identifier number and an attribute
identifier.
Patch 0002 adds the registered lsm_ids to a table.
Patch 0003 changes security_[gs]etprocattr() to use LSM IDs instead
of LSM names.
Patch 0004 implements lsm_get_self_attr() and lsm_set_self_attr().
New LSM hooks security_getselfattr() and security_setselfattr() are
defined.
Patch 0005 implements lsm_list_modules().
Patch 0006 wires up the syscalls.
Patch 0007 implements helper functions to make it easier for
security modules to use lsm_ctx structures.
Patch 0008 provides the Smack implementation for [gs]etselfattr().
Patch 0009 provides the AppArmor implementation for [gs]etselfattr().
Patch 0010 provides the SELinux implementation for [gs]etselfattr().
Patch 0011 implements selftests for the three new syscalls.

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.4-v12

v13: Change the setselfattr code to do a single user copy.
     Make the self tests more robust.
     Improve use of const.
     Change syscall numbers to reflect upstream additions.
v12: Repair a registration time overflow check.
v11: Remove redundent alignment code
     Improve a few comments.
     Use LSM_ATTR_UNDEF in place of 0 in a few places.
     Correct a return of -EINVAL to -E2BIG.
v10: Correct use of __user.
     Improve a few comments.
     Revert unnecessary changes in module initialization.
v9: Support a flag LSM_FLAG_SINGLE in lsm_get_self_attr() that
    instructs the call to provide only the attribute for the LSM
    identified in the referenced lsm_ctx structure.
    Fix a typing error.
    Change some coding style.
v8: Allow an LSM to provide more than one instance of an attribute,
    even though none of the existing modules do so.
    Pad the data returned by lsm_get_self_attr() to the size of
    the struct lsm_ctx.
    Change some displeasing varilable names.
v7: Pass the attribute desired to lsm_[gs]et_self_attr in its own
    parameter rather than encoding it in the flags.
    Change the flags parameters to u32.
    Don't shortcut out of calling LSM specific code in the
    infrastructure, let the LSM report that doesn't support an
    attribute instead. With that it is not necessary to maintain
    a set of supported attributes in the lsm_id structure.
    Fix a typing error.
v6: Switch from reusing security_[gs]procattr() to using new
    security_[gs]selfattr() hooks. Use explicit sized data types
    in the lsm_ctx structure.

v5: Correct syscall parameter data types.

v4: Restore "reserved" LSM ID values. Add explaination.
    Squash patches that introduce fields in lsm_id.
    Correct a wireup error.

v3: Add lsm_set_self_attr().
    Rename lsm_self_attr() to lsm_get_self_attr().
    Provide the values only for a specifed attribute in
    lsm_get_self_attr().
    Add selftests for the three new syscalls.
    Correct some parameter checking.

v2: Use user-interface safe data types.
    Remove "reserved" LSM ID values.
    Improve kerneldoc comments
    Include copyright dates
    Use more descriptive name for LSM counter
    Add documentation
    Correct wireup errors

Casey Schaufler (11):
  LSM: Identify modules by more than name
  LSM: Maintain a table of LSM attribute data
  proc: Use lsmids instead of lsm names for attrs
  LSM: syscalls for current process attributes
  LSM: Create lsm_list_modules system call
  LSM: wireup Linux Security Module syscalls
  LSM: Helpers for attribute names and filling lsm_ctx
  Smack: implement setselfattr and getselfattr hooks
  AppArmor: Add selfattr hooks
  SELinux: Add selfattr hooks
  LSM: selftests for Linux Security Module syscalls

 Documentation/userspace-api/index.rst         |   1 +
 Documentation/userspace-api/lsm.rst           |  73 ++++++
 MAINTAINERS                                   |   2 +
 arch/alpha/kernel/syscalls/syscall.tbl        |   3 +
 arch/arm/tools/syscall.tbl                    |   3 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   6 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   3 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   3 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   3 +
 arch/s390/kernel/syscalls/syscall.tbl         |   3 +
 arch/sh/kernel/syscalls/syscall.tbl           |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   3 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   3 +
 fs/proc/base.c                                |  29 ++-
 fs/proc/internal.h                            |   2 +-
 include/linux/lsm_hook_defs.h                 |   4 +
 include/linux/lsm_hooks.h                     |  17 +-
 include/linux/security.h                      |  46 +++-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |   9 +-
 include/uapi/linux/lsm.h                      |  90 +++++++
 kernel/sys_ni.c                               |   3 +
 security/Makefile                             |   1 +
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       |  99 +++++++-
 security/apparmor/procattr.c                  |  10 +-
 security/bpf/hooks.c                          |   9 +-
 security/commoncap.c                          |   8 +-
 security/landlock/cred.c                      |   2 +-
 security/landlock/fs.c                        |   2 +-
 security/landlock/ptrace.c                    |   2 +-
 security/landlock/setup.c                     |   6 +
 security/landlock/setup.h                     |   1 +
 security/loadpin/loadpin.c                    |   9 +-
 security/lockdown/lockdown.c                  |   8 +-
 security/lsm_syscalls.c                       | 118 +++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           | 226 ++++++++++++++++-
 security/selinux/hooks.c                      | 145 +++++++++--
 security/smack/smack_lsm.c                    | 102 +++++++-
 security/tomoyo/tomoyo.c                      |   9 +-
 security/yama/yama_lsm.c                      |   8 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   3 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   3 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/Makefile          |  19 ++
 tools/testing/selftests/lsm/common.c          |  81 ++++++
 tools/testing/selftests/lsm/common.h          |  33 +++
 tools/testing/selftests/lsm/config            |   3 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 240 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 140 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  74 ++++++
 62 files changed, 1624 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/common.c
 create mode 100644 tools/testing/selftests/lsm/common.h
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

-- 
2.41.0

