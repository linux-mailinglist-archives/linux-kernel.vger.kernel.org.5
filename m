Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2E78B8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjH1T6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjH1T6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:58:17 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4B195
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252692; bh=9uP6Rg4oC00NQB5WTQcmPKWTjed9/3CV4MlwP7Wfme0=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=erx8W1MvC3keAr2ToBPwntOJJ/mQld2LqHqTyYSWcIzUxno9LBRqoec9lr69hBw82p35U0fzL6nFqUgRWoAab8/JJxGHbMQF6iN6P2y0u3tPM/XJGr4rH99xJjUt1qeYFKYD50cJhZJ1LfYK+2OPdFk5Hx2vYbVY8K4AsGKSiszRhPUi6g+SwEYVNJmZ18/hDWlopyIjxn0caoEuDd0tRaJEZkwN+xlMzfaUF2Ib4SYx1I0Aa40FLZu/G7YPpl+KKTTPNljG/sqRGOFE1BsmGI7A0ELDc8Ny69SiqapCugB+M3R+jsKPwdT/oH/Lr0rJkmPTGFaHOPsqqGAJRZSd8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252692; bh=bSl74hFzLCZacqMitHWQ3CFXzAL4+OVFCFpj2pzaP24=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=j9O6KnD18ajbTtU/1yj9hakre6ledP2W+qc6fTpVwZCYBYijkNt82Zn4Klf2k/kXUclrpEvVHFTxODLwl6fQhBCGCLqf2flHiZvMAAVlL+eB7O6PpcEWOHzUVdLFtXnNR9ohgO/K25nUFP0huC+IigS8dwQXuA7vUERsVygAS4XFadxhl9fs3E9+rls0urmZJV3UVwO/BBXlGo4ERAKbqgLOUdUEpoj6G8K0laXaFvMlDhWZFt1rxUGqR9OkK1QHg+2v5vADIpan1DwfSfmTRBHu5EQoMdCyekkb5CNRpTKcd0xhc1rwnaV+8MeIe8jaZIDuAiq4q0U9GwjtYCthtw==
X-YMail-OSG: 7Bn_iiYVM1m23UywXsEQW9K1RXavEDn227whOc_oKdnghBaY8i_IhfoCYcKcXv4
 h1y8xuv9n0_yYbN86JRN4xIsdEpTfTKRH4ByLuD2YSdSbjP10s9JUIErhhKHgnPng6BfWHOal7Tc
 7M.zbUyUww_ubJDORSruPpqRSWbTt.CRC5P8pHgMXU8.kswzjIvjnIhf5DtcVsxBif0dLUGoJ8mR
 e56hRsylt2kB.PdFZF9CtBQjcK70h5NmtrlnRgTyPSPYWYI.W..fOBA3s5jpUyXG7jbUCapFd3C0
 JDnARsVCGUdH0QmPgtKF6WzYzxtopJSf3P5rrscs6Qne4IjYykDFJECPMnLNVCV1V6c4dvsLbPAw
 VQuSzjpb8M2yOltNdLYFqURsUnYUjxvvp8tEqoyNaNm5ySGeo4CfqTRU9btKlkzlczUjswciV6_J
 3VjYUDjW1aIqQ_4gynj_JjKuQi3IbQzWdohcKtiZPP2J.NgcM8SKnyAxKe1BmfqclMC0wSq0qwBV
 GjToHrcGK9Vvm1HWpjKtarmwY9jB.St_Ty8.Q2aCk7iIIyIg91br0L9Eofq6gYNxyTbkp3snzSC7
 Fb4aRcLq25QlQnZcsU7S3L0is6LKxfRKeaTZ1YtnuiYgm8lQxPVzAndXWXkkKKF9zRUpqG5mUpz8
 oMnhD_R1y7P3TI6qGF7Yk5duq_weMCezdctMG5h47Lv4Eyfy2E7KfvsmrlftfXPzHo8bQIwxUvxC
 1s22qfA815_hulV7_w0_uRHUcjYVs_.V8HFGXP8F68_7wV0IsjSGwVkPsPIVO5YNB5JzQqBeEzhd
 scutrObLhird_fSToR_krSOP11G9tsvxWeo.pA9MGjE58Rg7TVCssBa552wtnOsP26.e4DKpwuUA
 c5XTb55ywbyRq6kiANE396Fgx_AuhEp7sXDop0_xqcpykZRpYu6t2VvgUB7RrPm1occTku8YlKH1
 m6icfPb7WO8.e7e7jQvirVkd8.LvofXluJYcrpnQrElvgLJTjf6KajxU4r6CknzXmIg4pIHKRSNZ
 TJ_.urrvMePdL_7iGvC9bh2hp9jg_JyCs2IH6wZVNKbE9pXsTnG6GKjpLubZgAbp6SxFpi4AdUGq
 LoPaMlnTV4SPC0bG0NWoReGZYZLtNWi_egjQ5b2Mh9Dl9HXl8BsuGgdRj_ELtS9PzZiNeY1YyGXm
 rd1tazBQw0BMdytnN0bCiH.GprXTLOJwtmIxDgYuz5HOdVEWOhAafHYmxERbDSt_w_8G8OsAct6P
 jkbApYpWoobUKt54VCdTp8LSaN42aG7dwyPLiKd1ZIYMkd8vjiq2XZKMkzWAhpEyd9O_kWm5gkbX
 42qpnEAr75jNgF.LgRKBl.YeZgR9uoMF89wW2dvQnRxOKdqYe8_QdOsDWma8G0ehVhA3O7Ft354F
 4R1JRiP0HobVTLNI4GPbugi99Zzy0gEnJMoy1u3HPv5ZtWG3yYMs1dMaHhCrzheI8eDq14oXIgDS
 wvimIPDF4NEjPELtdT4_kHlCyM3ehzjn84IInA.nhcbsMGikI1t_HHrvEPZUR2MQA3w6B1s5kKfM
 BWpfaKm7K.wy0d2fUFhIswQhs_zNFZimgRzMNXjmzGlYm5pvwxWYDNt6TaChWtE4faT41dHQLPWV
 Aq8NQUGw9T6In3GI4.UlnxhF9.sbhSbQb4T.HtQDhJEWs__0UwZWN5xzAStI8b5fCPziwzfBwbXK
 K0CWTQfFOwpjG7LNbNpQLlhX.1AE2_offiG4t.MOAJPoG4uBfxiNC2rGsmxphKh64Y_QdBlknoAC
 qwjDMJK.2gXdV5RobowB79BlaUKXP2jkRgp1X6CeC..YPUkDRVry.V_Gb6UxFzkCd985v1.iowBV
 r7g4bVIyGF_x9Q.zGZ.npYlBqjXoLPi.oka7_BhFXBw5oSoFQ75mWpck48Z40kNGgzAgvL2Bfwes
 G3AUjWLGbBEcDGddGjBM_zBZbQKgsO3bEG_yzAH9aKMotRKpnRO9YD1LRPE.y53zasXnegDrpD1C
 kZ0Vm.6XaTBcDGANEofperFAzhZq2SemgptimW9OSMbuodi18iQMZ3HVCZC4myp0gEre.IuaOp5W
 QgprWE3omgTUwpGYiEhIBA4lj8enHDlTjlizlpcctIF58d1B036R_sT787PKSRNy569baZL.UOlL
 R3tX7Bvh0DFN2PPDPFpxGesmlW1YGvJ_o7.C.IFAs2ATgy2YT6wXxRjgNrwsZsdqu4qdB_h8unsk
 msnNtO4Hld2TOynKx4ljf6EtV8XxY_sVySJ_IXWrwp4g6.VFU2UbLoJvcDT.2jLJqGLHSwsHMJWl
 s8jOw_rvi2A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bc872c02-43c6-4339-9023-6c37d909c576
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 19:58:12 +0000
Received: by hermes--production-gq1-6b7c87dcf5-rj4xx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5b607809d087525ffd4c5fd459fa4399;
          Mon, 28 Aug 2023 19:58:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 00/11] LSM: Three basic syscalls
Date:   Mon, 28 Aug 2023 12:57:50 -0700
Message-ID: <20230828195802.135055-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230828195802.135055-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

https://github.com/cschaufler/lsm-stacking.git#syscalls-6.5-rc7-v14

v14: Make the handling of LSM_FLAG_SINGLE easier to understand.
     Tighten the comments and documentation.
     Better use of const, static, and __ro_after_init.
     Add selftests for LSM_FLAG_SINGLE cases.
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
 Documentation/userspace-api/lsm.rst           |  73 +++++
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
 fs/proc/base.c                                |  29 +-
 fs/proc/internal.h                            |   2 +-
 include/linux/lsm_hook_defs.h                 |   4 +
 include/linux/lsm_hooks.h                     |  17 +-
 include/linux/security.h                      |  46 ++-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |   9 +-
 include/uapi/linux/lsm.h                      |  90 ++++++
 kernel/sys_ni.c                               |   3 +
 security/Makefile                             |   1 +
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       |  99 ++++++-
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
 security/lsm_syscalls.c                       | 120 ++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           | 247 +++++++++++++++-
 security/selinux/hooks.c                      | 143 +++++++--
 security/smack/smack_lsm.c                    | 103 ++++++-
 security/tomoyo/tomoyo.c                      |   9 +-
 security/yama/yama_lsm.c                      |   8 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   3 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   3 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/.gitignore        |   1 +
 tools/testing/selftests/lsm/Makefile          |  17 ++
 tools/testing/selftests/lsm/common.c          |  89 ++++++
 tools/testing/selftests/lsm/common.h          |  33 +++
 tools/testing/selftests/lsm/config            |   3 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 275 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 140 +++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  74 +++++
 63 files changed, 1688 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c
 create mode 100644 tools/testing/selftests/lsm/.gitignore
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/common.c
 create mode 100644 tools/testing/selftests/lsm/common.h
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

-- 
2.41.0

