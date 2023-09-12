Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C679DA59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjILU50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjILU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:57:13 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E7410D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552226; bh=cbrggHP6l1JfIJLYbC2zEBt5EkLwu533A5hIvNZTCdw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=PKkWS0LW3eWw95oNa+zakdO03Qf/un0Og3+/4p300LNwEdUt8/NNA/y9GnNYs4AfXcgQuuQQ9CqOSMb77xiAJAxEIF4/hSiuOQzVstmfigB91afySpPJwV83CF2r1KVOAY20qC8uK3JHtuWKAC09aAxsgX1zLHDs2+9JeArOeSF9mC85TWwOdMagPPhRg/a7anxWzJmPryP78G4BkuTHUG8dvTs6se9CIRsaLfLY94/4Aukz+66u21HCht5MXmKTHypNYGG3hzUYh/qkV5K2S9+vBEU7e8WN8kkgaPrdCRYkFIxx2CoOTWz9/w9aXcUtR88AlHl6PgC5CUJLIGhtAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552226; bh=xyATiwBp4YI/49B/2SSQj6W0gU1QlPNvQXcYcgp1u/r=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XggObRfpc3JEzijPEP/cZtT59o/AEgmew5S6PPWOUXT4pRk9fpvLVCeIuXPQhiwtnP89bTreq3TnX3DcI/1p+tqiNCwaUNlA42jic1Enq1Y5omDJBvEVm9+/xwYDpY+HyXg1UNdscKv7Qc0EEtke+gFYAqZMStMG/FqGSOsqNwyveVQVguJnoBRtLe22BvOl+3GrCxh1cCAeqGSjKnTZU5aD0wBdfyH+ABEJ6xAwZhEif6jR3aBdjnROanKxvGDsyf+ggZG+vDGggVhqlMN8BXUl1/bjLjdVRkagDomNNyZ3vHhQ64p5vkBgDUi3LX13GLn+VUFKxXZdFpUjHn+YfQ==
X-YMail-OSG: HnttVZAVM1lbWwQDe9DYPsEnGqZ8aLfZUnj9nvgNAj8QhT9P3YqnA8XS2oJgJDc
 VDQsX0PiELq74.QBcUbUpKHJDL8UIiGlCFb_LQFOrv666fOm1tajDnZPrgCPMPvvVEwlrQCA34ys
 iFz6tP1ymSJlP.UBfCXtGr5T0zg8cS_PqZPNN5wxindn7NQRBr427fmEJcTAC4tmhqMsODUwyr95
 AetvxMjsQU6qbr9RWV1Df_NevtOuFcZpvvudLwwqB6MvcU7rwu31f3ynwzylxbJRdcYZnMF57DZE
 a5_rQhf6xIsizJIFEgUc2xUW6sE8YdpUEXzwcnyxVBWrSVg2lVPuLf.EqRJG1tv66uoiPObplXfI
 CV67CKyFAC738fhk1zwu1jmZNMSHLOVD5CBzX_TJtUC.UmwBCselmCDVMjbCAZdt91o6rjdpETiM
 91_ukGWynbspkbr3_J3ZQpZ67wxdkrbPIKChIyy3J1BJ3.8Bz2djqOg549vgfe5SUD2Luua1t2Xg
 __HcvqhpOnuMKa5rc0.au8IUxl9QMshk0y4D41blA165AnaBJHS.WqAKTwfnJ25J4ZWehPVIl.kB
 SGuEo5GVjrgHjve7JDpEDfqG.UVogC05mrnPBEAXxDuBdLwDswO1LcbGpGh2UNAL6B.CC38KLgYJ
 0SDsYKkdpFXiV6SHAU09GqIIPfXMq26Fwu0p4eSSa6t9JL3m81srbFCIs.36Z.TrFyJKsfsvHVD.
 f8CigEXH6c3NlnawCo44hi38kBOpQzaGJwoM4sfA7OhKGt38Cfh3Vg4QYsFhCCKZLEcBfisbGjtQ
 51to3qm9DgjlWrROIrPEqp5T5VpQ_pKavGuIKkaxgGZTYf55PgilRkidrjBT3ay2HNHSX2tgkSfc
 Lw0MbAxXeCiNZxdGozsu0b3.lbXBvmFSkkVBq46Fzjz6uGtBtTj6wN8Lm48DoFM8FGZDEIr5YIOf
 EAOewL5Hm6.3M57dq1yRLRWlimX0qUgIijBzVhkX7M9_GkZPXw_ARzWY9QhrGYXR62iP5D_NAADV
 36TVBh0OmNo9Kl8BnuoWJha.2QznKb9PW8Ej8UodymkN2aBqXVw3dOdgjzEC4T6v8MpZpLl813g.
 LEUnpYliu_5zAXWo361XuyytlDyjKUYObPflmYgygAWQejBNg9f3_5ZLit0tzcN8gglxjogeiFAc
 b.khQxZQlvrIQO4zC9txlY9hxNF_EivF8EfIs3KmdgjW0DpskOzX1QXNccBDLlsqLYedGBC9xh0U
 RWmwOsG6_eDKdYH6hJcPg.jd7wal4M0sLeNMgd2A.j9FJ4_ulYg8h2icAETISchvrgaZQoS7Gi17
 gDYAx7pUhDii7M01r6Cf4ik16YKpHsvr0q6TKn2.FS3sGN.RxvX8KUHo.f0WZQkL9shHi.XYCQsn
 X4HCAnb.JnLWRjolAHQYM49SlfYLrCZDFuu_UtqES7BWeqJ.FbradR.2_ORANs7ESS4TY12kOtQA
 FhmraH7UEMgoBKhzDMQT7KuWuFhgzIvoDgkzPyARzBFTGnu2gjnVFb0sGGiA9IZHm4nU1lSGfZ4s
 R1mxDcNcAWAHpAQhpSIFlYImJkrSzzWDJVIja2CvSPLFObRZwf4dSpEGZInMNl8WgFNhdFNhX_9W
 ISr58yz6SY2ceFn0J.tYMLGAkzmrQBZBX2wiu6vRINXiCkLpCFI_zCR.PsMXMeJWz6hnsLqzYUJO
 mP0WxPu1jnbtxV4gY6NmlxYZOMtqwp9J4682DFKzO6KkyqdN0cuPvVMsXeIo6HOCUy7Kh_oKecdH
 h4SvB2IpLtMap5IxM08HmEtOWmJRv5ylu43r8rrJ8sZDRl7anmnKND_B4BNouE1haWTALAVOes8B
 Mhq3I8Dr_5uCx2fhL84oXD0.oK_kLg3EmW0j2RxkykJF9p1TNNIb4Jr1wWwkT7ubLBl2nijBjaux
 YrXZ1wJlKjJBBgFNbUK46yP4f7NssPZE9Fft9Q2xtkEv6qf4hIVuCqv5tzG6exPndjloFhmK1bcg
 IAi2rRoqEwX1IqDrH2cySVengfC24SaOzOZXF6G0cZ7z7QupSm0094CVCslU176jT_F0qD6DUmN8
 eYQpWtXVTFDsMGf4KC6CpSxRzGgoWz1p_ESW9iKUIQnr_6Hl5Qvkx2s9yudVcmLeTik.hfuH0c6Z
 HDyP6NG.MZx9aEtIdN0XYlhbpypSvgeMRH6Va5Z4MbSIKuiAoRKyWTZx6t6hEhHEuMhNzQUnmrzg
 W7JP1zHW359C_AsACksi40_6EvLZ7Hijd7mChCQqwUQgOtabfLWV6SDNxDyJVYjjqxadL_YJApei
 zdRtnpPmzbdXq
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2685e40c-3c79-4a47-b6fc-e9729ac899f2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 20:57:06 +0000
Received: by hermes--production-gq1-6b7c87dcf5-j6k2s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f651283ea04feeaf2c9a6af092ec150;
          Tue, 12 Sep 2023 20:57:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 00/11] LSM: Three basic syscalls
Date:   Tue, 12 Sep 2023 13:56:45 -0700
Message-ID: <20230912205658.3432-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
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

v15: Rebased on 6.6-rc1.
     Adopt suggested improvements to security_getprocattr,
     making the code easier to read.
     Squash a code fix from 0011 to 0004.
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
 security/security.c                           | 253 +++++++++++++++-
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
 63 files changed, 1694 insertions(+), 93 deletions(-)
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

