Return-Path: <linux-kernel+bounces-1737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7A381535D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99222286284
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F2718EAC;
	Fri, 15 Dec 2023 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sJtBq1lT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68618EA1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678604; bh=xmg34kGtbQmrv1ygyT+YY4nUdO9IgZHWODMx7Sn62NQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=sJtBq1lTYv1ikqx8iHwtOHN87AabOq/xnTR85LaxhFJm36pHNSoIq/0xYQZNU+gaFLzoS8wgMRPRYOajwrkhgMQnG8gczhGIdkfD0rUYL84GlqaZb5dLTR+IjMvieWqdqV6zBW2VH028QzJ7Zz83/3+ZVZUi71avV2OAjvln+9L3qmEPmwaYGQpi9JGSVCWDmpa4VGUMLwyyhH/wCVl7dM5N29Rm6fsW7FAA2YYKX46cgk1YKWbiEeoA50TDiJIWppNyybBHL4eBrhct1e7DTrRTc2a3dR2Zvy2oeonW1o8A7Nmf+YYSGuaSXc7UUmsvVOVCeZ5iUQEynUgShGn75g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702678604; bh=YttJOIIOwS3nV9hEqgf17aMyiLBUGhoFne9Bh3Hk+V8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IUfC1kLiIj9uPelARh5iE50UhkzcUI7PwXMOaAW9OuyECeFu35K1kUao7OiiXmnunJ6dS6yFHnRFs2SH1NRBzfSmp5qXtDI4ULP4iDTo76nvDNIzvCGVUqhcFj4RKM+QDM/xsgm4j0if3SD0w4xwXsaF53FchB2ltlBVSZn1+zRWxwMkiv+Vhva7nHNNIQZDOVeQYz9RWY6eTHNH1x9+eC2mtzGx1TGvVmOuiUGqCWd9hv9GQFxUBxtBrcdWKORMLPsd2x355R2kKEM7FBWqr43JTNi//ERuEVnUUGVmIVA0tcg2Q5NPkIlZlcWFZff3qgRfX2aFaPQ+KWiJXfKwKw==
X-YMail-OSG: n2PQSccVM1lczh3oicHZ8Ap_.8THguT1M6qz4IW2HyhUTpdLU65JoLLYatA2Xve
 T.HFPGga12XRHhREu4j6Kx7dIgHQPhchQ5gmZBgRYwDJuyoDa_5_Z4HJumJt8HF5igCd3eCD3vk1
 84wXt2Yit7QOXVsmcgLErWyqMUyVApqD.t_v_m5oBBtK.s8lcP1Do8WJ7V7WFERQqbtM8T5YQAnL
 cezcAuAkax._fLb5yqnAVkhbedAs9eb1R8PEJ4RMhfOzChbdl8hqo6wl9LXiVSGO4iqcSIdNkqsq
 2RHd9Ij9GmnAiwyltBK9QqLqGWAKED7oHEBcAsMIW_XQlYwMShCcqiMilcvOgv1BTLW4nD_RPUmf
 r1mHI2yANUsJDv1N2GEoJXGAZ_L8u._xDIoxP.TWgYeHxJBe1TWoyXJRhs60pnnr2iZr6YoYqfnm
 kiLY4s5v775w4cnYom9iaIkBJr2HxYuu9.O4DUvnBSGRGJwdg461hTzMgyeNnxZWJJM_yRWqLQE_
 z7JR.Zib1zbzye4wxcHzmMP6IDIsb8zGs1K3rqk0yUc2ay0aanNRxbAGmfRw803xtbmWE2GFkfeZ
 d0qJif0lPrHov46cDTLQI9hBmcfva8Y4KPOOsOm8qabwdv1LJtvEQYHqbcBpqTi8X81zZvsJracS
 Hvtc77hQ5q0wKVb.TR1x7uKMW7fQ0IaKGKqCkc11eOF3OYrmR.BiUGoL9hdkGxuErq5xNiyRa.gr
 .rZS8rRK0sirJYPonF_xInM7ZCLwJNy6P.do0p5oAp38PqS.Db_empU6wkhZFQDyb5ZYWkDLtx.l
 j_5BpS40F8ipCY88MI1Sk0fy4G1S9pFVBuCOEYNyEdjJYzyBxDvNvbFUzut5rt0_7QfaUp07QA.G
 9Aqp2jwiX56siFQIrF6VeMxtJ8ArV2ReUoJf5yt8UJwEKn3dph0xSTi6p0CJhJBD_VW_chCCA43N
 OgSReJ8qLTvWUnqMF3sp8L_4t8zX0_81oZTd3nTmarHMASsxDvzSRzVyFcg6t89PvRKo4Ep_NceL
 MpHvZQC8DUmw6WBus6bpSTTM336EAQtTm1DTteln3Xv.PHUGSmEczXR0H5C47FQcUH10.FP5qVmt
 yhV39qJRDyf5xt0qthZ_h0iBG_yTuYulzNVjw7i_fewaN8Ixx.Zr1cyhJBJLyXLazmY_jaTAZpFp
 Gf6CA1O3eWvWILZys7s5X7q1jtUH0gCDiEa0L7BQ1UDZl0TEDU2Dv6bLd2n_nkpZyIz5bJQi3xks
 BbHQ_ojM9eWi8nObqc0PrCqZVEkeatSmxZxhUr42zQb57KhLjKLSG2gA.a80usQS.IjN7RIRBWf0
 lZkd6_xNq6rwkhN3jWlManH9N5F6qsoBX3cG9qbfaV3epugYgmk5OE1UxP79GYJbNR4BU9RshLE0
 4Wq0B4YwxbWUUzvTqdUdJR2LL0Dc8c0G1kBreBTwGj_VaeDobJra.9u73027jEIhnGns5mL4z3O4
 nIfzviYh9hbBYaXs2vPXD8lGd63bzMIScceRlTOlsm8uUFmIHtKpcZmaWKWiWYSEBRRmrY16mJ9I
 NJHMUGepJBk9FXPQl42E3HXJyV70O7qRQ_XsF2MR3jLLoTrgohdYGLrSQo.NvbxliExr4HITDKjg
 X6gRfjsyGUHgzWj8IGCD1LdZ3fbhGn8etyaAu6jFW7kpVXhXLlJBsFcth4ocHOItE8BFgDVjdyjg
 s2no70fawLyBSA2i4RyIiPg5VSgzV3qb9U09pKpaasL4Wz5yAsq5bPi.29U1FCz7mRHNR_Ri9QwX
 fHVchY6WU8G_xuJVZNaqg83lLygubOwd25AN0y58Jh51oVMLzWEuyL.aij0ZRr4zh80_u8yTyIbn
 TtB9hJ4b6Euw0yhg8PEwOLH6uFy2lnc5BmMxj7HxHi5B1InPZwwqoBgk5B_6kIk3ixn8usdSi2a.
 _nhTUIv.ycZhjvbEpHmeOBAPB8IxnFXbDYg6eZG2QJbbxsVuhEcyw9FepdmyIVyd16inHW5OLktK
 jw8fYu7V5KascSJLdcq7EUrT7yA_4_IIEl1GtfwNaG8uOLKLNgCtWBC4jwlu6NbjCMCIC2FsBvJJ
 K_lwZxy5B99fMBiXYLsdY1VbETl_EJ6y2ttyCLcx0X9WJza7kgUVabWKDsR_1se1jJLMW0HEoPQ.
 GVtQnwuF3QIEVfmiWday8JJN6y1dOyVZvcKRmrfrCGaVRoRwb91oEbWQ_DBH77CwmkruC0z4C7EH
 6OvVQn_nFa.XtQV9jSsv9lVzQsEuBY0cYcRFJOmy8SsumPPwVFsG7gyncu3ZYFIeNSsbfkwF6eZ4
 rKvEPgN7BAuM1_EBRytA-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aeb49a0e-a4cd-4847-a9f3-2315a29a185d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:16:44 +0000
Received: by hermes--production-gq1-6949d6d8f9-k52jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af526ee8ff178a31e5a49e4e8cc011a6;
          Fri, 15 Dec 2023 22:16:42 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v39 00/42] LSM: General module stacking
Date: Fri, 15 Dec 2023 14:15:54 -0800
Message-ID: <20231215221636.105680-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20231215221636.105680-1-casey.ref@schaufler-ca.com>

This patchset provides the changes required to allow arbitrary
combination of all the existing Linux Security Modules (LSM).
It does not provide for all possible configurations of all of
co-existing modules. It does not ensure that the enforcement
of policy provided by one module does not interfere with the
behavior of another module.

The bulk of the code change is in support of the audit system.
Because subjects and objects may have multiple LSM specific
attributes that are used to make access control decisions it
was necessary to enhance the audit system to report these
security attributes. Separate audit records have been added
to include the additional information for each of the audit
event subject and object. Providing the required security
information using 32-bit secids was no longer sufficient. A
new structure, lsmblob, has been introduced to include the
data for all relevant modules.

The lsmblob structure has an entry for each of the modules
that has used secids. Each module provides a structure of
its own which contains the information it uses. For SELinux
this is a u32 secid. Smack provides a pointer into the label
list. Modules that are not configured use conditional compilation 
to have empty structures.

Because audit records may need to include the text representation
of more than one module's security attributes (commonly referred
to as the "security context") the interfaces that convert the
lsmblob into a text representation need to identify which module
provided the text. An structure lsmcontext has been added that
contains the text, its length and the identifier of the module
than created it.

Security attributes for network facilities have provided certain
challenges. The security information allowed in socket buffers
and secmarks is limited to a single u32 secid, and there is no
indication that this will ever be allowed to change. The netlabel
subsystem, which provides CIPSO and CALIPSO labeling on internet
packets, supports only one IP packet option at a time. Labeled
NFS3 also supports only one security module. The existing modules
have been updated to accept that they may not have access to
these networking security attributes. The first module to
register that uses them is given exclusive access.

The issue of multiple modules using the /proc/.../attr interfaces
has been largely addressed for some time by the inclusion of module
specific sub-directories. Applications should be using these except
for the case of SELinux.

Patch 0001 removes an interface dependency on audit from IMA.
Patch 0002 moves management of socket security blobs out of the
	modules and into the LSM infrastructure.
Patch 0003 introduces the lsmblob structure.
Patch 0004 introduces mechanism for the IMA mechanisms to handle
	the possibility of multiple modules that use attributes.
Patches 0005-0015 add new interfaces and change existing interfaces
	to use the lsmblob to represent security data.
Patches 0016-0021 replace a the use of string and length pairs to
	use a "security context" with an lsmcontext structure.
Patches 0022-0026 implement audit records describing the multiple
	security attributes on subjects and objects.
Patch 0027 removes scaffolding code used in support on lsmcontext.
Patches 0028-0030 optimize LSM hooks for the networking single
	module user case.
Patch 0031 implements mechanism to reserve use of network secmarks.
Patch 0032 limits security_secctx_to_secid() to a single module.
Patch 0033 removes the exclusive tag from AppArmor.
Patches 0034-0035 adds mount operation security blobs.
Patch 0036 moves management of key security blobs out of the
	modules and into the LSM infrastructure.
Patch 0037 enables management of mount operation security blobs
	in the modules.
Patches 0038-0039 remove scaffolding for lsmblobs.
Patch 0040 implements mechanism to reserve use of netlabel.
Patch 0041 restricts a hook used only by binder to a single module.
Patch 0042 removes the exclusive tag from Smack.

https://github.com:cschaufler/lsm-stacking.git#stack-6.7-rc1-pcmoore-dev-v39-b

Casey Schaufler (42):
  integrity: disassociate ima_filter_rule from security_audit_rule
  SM: Infrastructure management of the sock security
  LSM: Add the lsmblob data structure.
  IMA: avoid label collisions with stacked LSMs
  LSM: Use lsmblob in security_audit_rule_match
  LSM: Add lsmblob_to_secctx hook
  Audit: maintain an lsmblob in audit_context
  LSM: Use lsmblob in security_ipc_getsecid
  Audit: Update shutdown LSM data
  LSM: Use lsmblob in security_current_getsecid
  LSM: Use lsmblob in security_inode_getsecid
  Audit: use an lsmblob in audit_names
  LSM: Create new security_cred_getlsmblob LSM hook
  Audit: Change context data from secid to lsmblob
  Netlabel: Use lsmblob for audit data
  LSM: Ensure the correct LSM context releaser
  LSM: Use lsmcontext in security_secid_to_secctx
  LSM: Use lsmcontext in security_lsmblob_to_secctx
  LSM: Use lsmcontext in security_inode_getsecctx
  LSM: Use lsmcontext in security_dentry_init_security
  LSM: security_lsmblob_to_secctx module selection
  Audit: Create audit_stamp structure
  Audit: Allow multiple records in an audit_buffer
  Audit: Add record for multiple task security contexts
  audit: multiple subject lsm values for netlabel
  Audit: Add record for multiple object contexts
  LSM: Remove unused lsmcontext_init()
  LSM: Improve logic in security_getprocattr
  LSM: secctx provider check on release
  LSM: Single calls in socket_getpeersec hooks
  LSM: Exclusive secmark usage
  LSM: Identify which LSM handles the context string
  AppArmor: Remove the exclusive flag
  LSM: Add mount opts blob size tracking
  LSM: allocate mnt_opts blobs instead of module specific data
  LSM: Infrastructure management of the key security blob
  LSM: Infrastructure management of the mnt_opts security blob
  LSM: Correct handling of ENOSYS in inode_setxattr
  LSM: Remove lsmblob scaffolding
  LSM: Allow reservation of netlabel
  LSM: restrict security_cred_getsecid() to a single LSM
  Smack: Remove LSM_FLAG_EXCLUSIVE

 Documentation/ABI/testing/ima_policy    |   8 +-
 drivers/android/binder.c                |  25 +-
 fs/ceph/super.h                         |   3 +-
 fs/ceph/xattr.c                         |  15 +-
 fs/fuse/dir.c                           |  35 +-
 fs/nfs/dir.c                            |   2 +-
 fs/nfs/inode.c                          |  17 +-
 fs/nfs/internal.h                       |   8 +-
 fs/nfs/nfs4proc.c                       |  16 +-
 fs/nfs/nfs4xdr.c                        |  22 +-
 fs/nfsd/nfs4xdr.c                       |  21 +-
 include/linux/audit.h                   |  13 +
 include/linux/lsm/apparmor.h            |  17 +
 include/linux/lsm/bpf.h                 |  16 +
 include/linux/lsm/selinux.h             |  16 +
 include/linux/lsm/smack.h               |  17 +
 include/linux/lsm_hook_defs.h           |  35 +-
 include/linux/lsm_hooks.h               |   8 +
 include/linux/nfs4.h                    |   8 +-
 include/linux/nfs_fs.h                  |   2 +-
 include/linux/security.h                | 158 +++++++--
 include/net/netlabel.h                  |   2 +-
 include/net/scm.h                       |  12 +-
 include/uapi/linux/audit.h              |   2 +
 kernel/audit.c                          | 269 +++++++++++----
 kernel/audit.h                          |  20 +-
 kernel/auditfilter.c                    |   9 +-
 kernel/auditsc.c                        | 142 +++-----
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  16 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  22 +-
 net/netlabel/netlabel_unlabeled.c       |  46 ++-
 net/netlabel/netlabel_user.c            |  10 +-
 net/netlabel/netlabel_user.h            |   2 +-
 security/apparmor/audit.c               |  19 +-
 security/apparmor/include/audit.h       |   8 +-
 security/apparmor/include/net.h         |   8 +-
 security/apparmor/include/secid.h       |   5 +-
 security/apparmor/lsm.c                 |  65 +---
 security/apparmor/net.c                 |   2 +-
 security/apparmor/secid.c               |  52 ++-
 security/bpf/hooks.c                    |   1 +
 security/integrity/ima/ima.h            |  32 +-
 security/integrity/ima/ima_api.c        |   6 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  60 ++--
 security/integrity/ima/ima_policy.c     |  91 +++++-
 security/security.c                     | 415 ++++++++++++++++++------
 security/selinux/hooks.c                | 285 +++++++++-------
 security/selinux/include/audit.h        |  13 +-
 security/selinux/include/netlabel.h     |   5 +
 security/selinux/include/objsec.h       |  12 +
 security/selinux/netlabel.c             |  27 +-
 security/selinux/ss/services.c          |  20 +-
 security/smack/smack.h                  |  22 ++
 security/smack/smack_lsm.c              | 347 ++++++++++++--------
 security/smack/smack_netfilter.c        |  12 +-
 security/smack/smackfs.c                |  24 +-
 59 files changed, 1691 insertions(+), 883 deletions(-)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

-- 
2.41.0


